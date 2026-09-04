#ifndef KAVIRAJ_SCHED_H
#define KAVIRAJ_SCHED_H

#include <types.h>

struct exception_context {
    uint64_t x[30];
    uint64_t lr;       // x30
    uint64_t elr_el1;  // PC to return to (offset 248)
    uint64_t spsr_el1; // CPU state (offset 256)
    uint64_t padding;  // Make size 272 (multiple of 16)
};

void sched_init(void);
void sched_create_task(void (*entry)(void));
struct exception_context *sched_switch(struct exception_context *ctx);

#endif
