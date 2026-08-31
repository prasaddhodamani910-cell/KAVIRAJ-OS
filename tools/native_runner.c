#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include "../include/types.h"

uint8_t dummy_space[0x40000];
uint8_t *__kernel_start = dummy_space;
uint8_t *__text_start   = dummy_space;
uint8_t *__text_end     = dummy_space + 0x10000;
uint8_t *__rodata_start = dummy_space + 0x10000;
uint8_t *__rodata_end   = dummy_space + 0x18000;
uint8_t *__data_start   = dummy_space + 0x18000;
uint8_t *__data_end     = dummy_space + 0x20000;
uint8_t *__bss_start    = dummy_space + 0x20000;
uint8_t *__bss_end      = dummy_space + 0x24000;
uint8_t *__stack_top    = dummy_space + 0x40000;
uint8_t *__kernel_end   = dummy_space + 0x40000;

static struct termios orig_termios;

static void disable_raw_mode(void) {
    tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

static void enable_raw_mode(void) {
    tcgetattr(STDIN_FILENO, &orig_termios);
    atexit(disable_raw_mode);
    struct termios raw = orig_termios;
    raw.c_lflag &= ~(ECHO | ICANON | IEXTEN);
    raw.c_cc[VMIN] = 1;
    raw.c_cc[VTIME] = 0;
    tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
}

extern void kmain(void);

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    if (isatty(STDIN_FILENO)) {
        enable_raw_mode();
    }
    kmain();
    return 0;
}
