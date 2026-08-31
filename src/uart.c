#include "uart.h"
#include <stdarg.h>

int kernel_capture_mode = 0;
char kernel_capture_buffer[16384];
int kernel_capture_idx = 0;


#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#include <unistd.h>

void uart_init(void) {}

void uart_putc(char c) {
    if (kernel_capture_mode && kernel_capture_idx < 16383) { kernel_capture_buffer[kernel_capture_idx++] = c; kernel_capture_buffer[kernel_capture_idx] = '\0'; }
    putchar(c);
    fflush(stdout);
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') {
            putchar('\r');
        }
        putchar(*s++);
    }
    fflush(stdout);
}

int uart_has_data(void) {
    return 1;
}

char uart_getc(void) {
    char c = 0;
    if (read(STDIN_FILENO, &c, 1) < 0) return 0;
    return c;
}

#else

void uart_init(void) {
    mmio_write(UART0_CR, 0x00000000);
    mmio_write(UART0_IBRD, 13);
    mmio_write(UART0_FBRD, 1);
    mmio_write(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
    mmio_write(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
}

void uart_putc(char c) {
    if (kernel_capture_mode && kernel_capture_idx < 16383) { kernel_capture_buffer[kernel_capture_idx++] = c; kernel_capture_buffer[kernel_capture_idx] = '\0'; }
    while (mmio_read(UART0_FR) & UART_FR_TXFF) {}
    mmio_write(UART0_DR, (uint32_t)c);
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') {
            uart_putc('\r');
        }
        uart_putc(*s++);
    }
}

int uart_has_data(void) {
    return !(mmio_read(UART0_FR) & UART_FR_RXFE);
}

char uart_getc(void) {
    while (mmio_read(UART0_FR) & UART_FR_RXFE) {}
    return (char)(mmio_read(UART0_DR) & 0xFF);
}
#endif

void uart_print_hex_raw(uint64_t value, int min_digits) {
    const char hex_chars[] = "0123456789ABCDEF";
    int started = 0;
    for (int i = 60; i >= 0; i -= 4) {
        int digit_idx = (i / 4) + 1;
        uint8_t nibble = (value >> i) & 0xF;
        if (nibble != 0 || digit_idx <= min_digits) {
            started = 1;
        }
        if (started) {
            uart_putc(hex_chars[nibble]);
        }
    }
    if (!started) {
        uart_putc('0');
    }
}

void uart_print_hex(uint64_t value) {
    uart_puts("0x");
    uart_print_hex_raw(value, 1);
}

void uart_print_dec(uint64_t value) {
    if (value == 0) {
        uart_putc('0');
        return;
    }
    char buffer[24];
    int idx = 0;
    while (value > 0) {
        buffer[idx++] = '0' + (value % 10);
        value /= 10;
    }
    for (int i = idx - 1; i >= 0; i--) {
        uart_putc(buffer[i]);
    }
}

void uart_printf(const char *fmt, ...) {
    __builtin_va_list args;
    __builtin_va_start(args, fmt);

    for (size_t i = 0; fmt[i] != '\0'; i++) {
        if (fmt[i] == '%') {
            i++;
            int is_long = 0;
            if (fmt[i] == 'l') {
                is_long = 1;
                i++;
                if (fmt[i] == 'l') {
                    i++;
                }
            }
            switch (fmt[i]) {
                case 'c': {
                    char c = (char)__builtin_va_arg(args, int);
                    uart_putc(c);
                    break;
                }
                case 's': {
                    const char *s = __builtin_va_arg(args, const char *);
                    if (!s) s = "(null)";
                    uart_puts(s);
                    break;
                }
                case 'd': {
                    int64_t val = is_long ? __builtin_va_arg(args, int64_t) : (int64_t)__builtin_va_arg(args, int);
                    if (val < 0) {
                        uart_putc('-');
                        uart_print_dec((uint64_t)(-val));
                    } else {
                        uart_print_dec((uint64_t)val);
                    }
                    break;
                }
                case 'u': {
                    uint64_t val = is_long ? __builtin_va_arg(args, uint64_t) : (uint64_t)__builtin_va_arg(args, unsigned int);
                    uart_print_dec(val);
                    break;
                }
                case 'x': {
                    uint64_t val = is_long ? __builtin_va_arg(args, uint64_t) : (uint64_t)__builtin_va_arg(args, unsigned int);
                    uart_print_hex_raw(val, 1);
                    break;
                }
                case 'p': {
                    uint64_t val = __builtin_va_arg(args, uint64_t);
                    uart_print_hex(val);
                    break;
                }
                case '%': {
                    uart_putc('%');
                    break;
                }
                default:
                    uart_putc('%');
                    uart_putc(fmt[i]);
                    break;
            }
        } else {
            if (fmt[i] == '\n') {
                uart_putc('\r');
            }
            uart_putc(fmt[i]);
        }
    }

    __builtin_va_end(args);
}
