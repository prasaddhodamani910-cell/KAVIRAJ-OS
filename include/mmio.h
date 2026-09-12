#ifndef MMIO_H
#define MMIO_H

#include "types.h"

static inline void mmio_write32(uint64_t base, uint64_t offset, uint32_t val) {
    *(volatile uint32_t *)(base + offset) = val;
}

static inline uint32_t mmio_read32(uint64_t base, uint64_t offset) {
    return *(volatile uint32_t *)(base + offset);
}

static inline uint8_t mmio_read8(uint64_t base, uint64_t offset) {
    return *(volatile uint8_t *)(base + offset);
}

#endif // MMIO_H
