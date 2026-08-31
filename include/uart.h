#ifndef UART_H
#define UART_H

#include "types.h"

// Memory Mapped I/O helper macros
#define mmio_write(reg, val) (*(volatile uint32_t *)(reg) = (val))
#define mmio_read(reg)       (*(volatile uint32_t *)(reg))

// ARM PL011 UART Base Address (matches QEMU 'virt' & standard ARM64 virtual platform)
#define UART0_BASE 0x09000000

#define UART0_DR   (UART0_BASE + 0x00) // Data Register
#define UART0_FR   (UART0_BASE + 0x18) // Flag Register
#define UART0_IBRD (UART0_BASE + 0x24) // Integer Baud Rate Divisor
#define UART0_FBRD (UART0_BASE + 0x28) // Fractional Baud Rate Divisor
#define UART0_LCRH (UART0_BASE + 0x2C) // Line Control Register
#define UART0_CR   (UART0_BASE + 0x30) // Control Register

// UART Flag Register Bits
#define UART_FR_TXFF (1 << 5) // Transmit FIFO Full
#define UART_FR_RXFE (1 << 4) // Receive FIFO Empty

void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
char uart_getc(void);
int  uart_has_data(void);
void uart_print_hex(uint64_t value);
void uart_print_dec(uint64_t value);
void uart_printf(const char *fmt, ...);

#endif // UART_H

extern int kernel_capture_mode;
extern char kernel_capture_buffer[16384];
extern int kernel_capture_idx;
