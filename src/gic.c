#include <gic.h>
#include <uart.h>

#define GICD_BASE 0x08000000ULL
#define GICC_BASE 0x08010000ULL

#define GICD_CTLR        (*(volatile uint32_t *)(GICD_BASE + 0x000))
#define GICD_ISENABLER(n) (*(volatile uint32_t *)(GICD_BASE + 0x100 + (n) * 4))
#define GICD_IPRIORITYR(n) (*(volatile uint32_t *)(GICD_BASE + 0x400 + (n) * 4))
#define GICD_ITARGETSR(n) (*(volatile uint32_t *)(GICD_BASE + 0x800 + (n) * 4))

#define GICC_CTLR        (*(volatile uint32_t *)(GICC_BASE + 0x000))
#define GICC_PMR         (*(volatile uint32_t *)(GICC_BASE + 0x004))
#define GICC_IAR         (*(volatile uint32_t *)(GICC_BASE + 0x00C))
#define GICC_EOIR        (*(volatile uint32_t *)(GICC_BASE + 0x010))

void gic_init(void) {
    // Disable distributor
    GICD_CTLR = 0;

    // Enable CPU interface (Group 0 and Group 1) and unmask priorities
    GICC_PMR = 0xFF;
    GICC_CTLR = 3;

    // Enable distributor (Group 0 and Group 1)
    GICD_CTLR = 3;
}

void gic_enable_interrupt(uint32_t intid) {
    // Enable the interrupt
    GICD_ISENABLER(intid / 32) = 1 << (intid % 32);

    // Set priority to 0 (highest)
    uint32_t prio_reg = GICD_IPRIORITYR(intid / 4);
    prio_reg &= ~(0xFF << ((intid % 4) * 8));
    GICD_IPRIORITYR(intid / 4) = prio_reg;

    // Target CPU 0 (only for SPIs, but safe for PPIs as they are read-only)
    if (intid >= 32) {
        uint32_t target_reg = GICD_ITARGETSR(intid / 4);
        target_reg |= (1 << ((intid % 4) * 8));
        GICD_ITARGETSR(intid / 4) = target_reg;
    }
}

uint32_t gic_acknowledge_interrupt(void) {
    return GICC_IAR & 0x3FF;
}

void gic_end_interrupt(uint32_t intid) {
    GICC_EOIR = intid;
}
