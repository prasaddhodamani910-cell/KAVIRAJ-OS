#ifndef EXCEPTIONS_H
#define EXCEPTIONS_H

#include "types.h"

/* Pointer to the vector table defined in exceptions.S */
extern void exception_vector_table(void);

/* Triggers an undefined instruction exception */
extern void trigger_undefined_instruction(void);

/* Setup VBAR_EL1 register */
static inline void init_exceptions(void) {
    uint64_t addr = (uint64_t)&exception_vector_table;
    __asm__ volatile("msr vbar_el1, %0" : : "r" (addr));
}

#endif // EXCEPTIONS_H
