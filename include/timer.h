#ifndef KAVIRAJ_TIMER_H
#define KAVIRAJ_TIMER_H

#include <types.h>

void timer_init(void);
void timer_handle_interrupt(void);

// Macro to unmask IRQs in the CPU
static inline void irq_enable(void) {
    __asm__ volatile ("msr daifclr, #2" ::: "memory");
}

static inline void irq_disable(void) {
    __asm__ volatile ("msr daifset, #2" ::: "memory");
}

#endif
