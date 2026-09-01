#ifndef KAVIRAJ_GIC_H
#define KAVIRAJ_GIC_H

#include <types.h>

void gic_init(void);
void gic_enable_interrupt(uint32_t intid);
uint32_t gic_acknowledge_interrupt(void);
void gic_end_interrupt(uint32_t intid);

#endif
