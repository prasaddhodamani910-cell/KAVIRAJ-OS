#include <timer.h>
#include <uart.h>
#include <gic.h>

#define TIMER_IRQ 30 // Physical Timer PPI

static uint64_t timer_frequency = 0;
static uint64_t ticks = 0;

void timer_init(void) {
    // Read the timer frequency
    __asm__ volatile ("mrs %0, cntfrq_el0" : "=r" (timer_frequency));
    
    // Set the compare value for 1 tick (1 per second)
    __asm__ volatile ("msr cntp_tval_el0, %0" :: "r" (timer_frequency));

    // Enable the timer
    uint64_t ctl = 1;
    __asm__ volatile ("msr cntp_ctl_el0, %0" :: "r" (ctl));

    // Enable the timer IRQ in the GIC
    gic_enable_interrupt(TIMER_IRQ);
    
    // Unmask IRQs on the CPU
    irq_enable();
    
    // Cast to int since timer_frequency fits in 32-bit (usually 62.5MHz)
    uart_printf("[+] Generic Physical Timer initialized. Frequency: %d Hz\n", (int)timer_frequency);
}

void timer_handle_interrupt(void) {
    ticks++;
    // Print a dot every tick
    uart_puts(".");

    // Reset the compare value for the next interrupt
    __asm__ volatile ("msr cntp_tval_el0, %0" :: "r" (timer_frequency));
}
