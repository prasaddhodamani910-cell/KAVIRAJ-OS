#include "uart.h"
#include "types.h"
#include "gic.h"
#include "timer.h"
#include "sched.h"

struct exception_context *handle_sync_exception(struct exception_context *ctx) {
    uint64_t esr, far;
    __asm__ volatile("mrs %0, esr_el1" : "=r" (esr));
    __asm__ volatile("mrs %0, far_el1" : "=r" (far));

    uart_puts("\n\033[31;1m[!] SYNCHRONOUS EXCEPTION TRIGGERED [!]\033[0m\n");
    uart_printf("  ESR_EL1: 0x%x\n", esr);
    uart_printf("  ELR_EL1 (PC of faulting instruction): 0x%x\n", ctx->elr_el1);
    uart_printf("  FAR_EL1 (Faulting Virtual Address): 0x%x\n", far);
    
    uint32_t ec = (esr >> 26) & 0x3F;
    uart_printf("  Exception Class (EC): 0x%x\n", ec);
    if (ec == 0x0) {
        uart_puts("  Type: Unknown/Undefined instruction\n");
    } else if (ec == 0x24) {
        uart_puts("  Type: Data Abort (EL1)\n");
    } else if (ec == 0x15) {
        uart_puts("  Type: SVC Call\n");
    }

    ctx->elr_el1 += 4;
    uart_puts("\033[32m[+] Recovering from exception. Resuming execution...\033[0m\n\n");
    return ctx;
}

void c_handle_sync_invalid(struct exception_context *ctx) {
    uint64_t esr;
    __asm__ volatile("mrs %0, esr_el1" : "=r" (esr));
    uart_printf("\n\033[31;1m[!] UNHANDLED SYNCHRONOUS EXCEPTION [!]\033[0m\n");
    uart_printf("  ESR_EL1: 0x%x | ELR_EL1: 0x%x\n", esr, ctx->elr_el1);
    while (1);
}

void c_handle_irq_invalid(void) {
    uart_puts("[!] UNHANDLED IRQ EXCEPTION\n");
    while (1);
}

void c_handle_fiq_invalid(void) {
    uart_puts("[!] UNHANDLED FIQ EXCEPTION\n");
    while (1);
}

void c_handle_serror_invalid(void) {
    uart_puts("[!] UNHANDLED SERROR EXCEPTION\n");
    while (1);
}

struct exception_context *handle_irq_exception(struct exception_context *ctx) {
    uint32_t intid = gic_acknowledge_interrupt();
    
    if (intid == 30) {
        timer_handle_interrupt();
        ctx = sched_switch(ctx);
    } else if (intid != 1023) {
        uart_printf("[IRQ] Unknown interrupt ID: %d\n", intid);
    }
    
    gic_end_interrupt(intid);
    return ctx;
}
