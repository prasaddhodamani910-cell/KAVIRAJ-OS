.section .text
.global exception_vector_table
.global trigger_undefined_instruction

.macro save_context
    sub     sp, sp, #272
    stp     x0, x1, [sp, #0]
    
    mrs     x0, elr_el1
    mrs     x1, spsr_el1
    // We must match the C struct:
    // lr is at 240
    // elr is at 248
    // spsr is at 256
    stp     x0, x1, [sp, #248]
    
    ldp     x0, x1, [sp, #0]
    
    stp     x2, x3, [sp, #16]
    stp     x4, x5, [sp, #32]
    stp     x6, x7, [sp, #48]
    stp     x8, x9, [sp, #64]
    stp     x10, x11, [sp, #80]
    stp     x12, x13, [sp, #96]
    stp     x14, x15, [sp, #112]
    stp     x16, x17, [sp, #128]
    stp     x18, x19, [sp, #144]
    stp     x20, x21, [sp, #160]
    stp     x22, x23, [sp, #176]
    stp     x24, x25, [sp, #192]
    stp     x26, x27, [sp, #208]
    stp     x28, x29, [sp, #224]
    str     x30, [sp, #240]
.endm

.macro restore_context
    ldp     x0, x1, [sp, #248]
    msr     elr_el1, x0
    msr     spsr_el1, x1
    
    ldp     x0, x1, [sp, #0]
    ldp     x2, x3, [sp, #16]
    ldp     x4, x5, [sp, #32]
    ldp     x6, x7, [sp, #48]
    ldp     x8, x9, [sp, #64]
    ldp     x10, x11, [sp, #80]
    ldp     x12, x13, [sp, #96]
    ldp     x14, x15, [sp, #112]
    ldp     x16, x17, [sp, #128]
    ldp     x18, x19, [sp, #144]
    ldp     x20, x21, [sp, #160]
    ldp     x22, x23, [sp, #176]
    ldp     x24, x25, [sp, #192]
    ldp     x26, x27, [sp, #208]
    ldp     x28, x29, [sp, #224]
    ldr     x30, [sp, #240]
    add     sp, sp, #272
.endm

.align 11
exception_vector_table:
    .align 7
curr_el_sp0_sync:
    b   handle_sync_invalid
    .align 7
curr_el_sp0_irq:
    b   handle_irq_invalid
    .align 7
curr_el_sp0_fiq:
    b   handle_fiq_invalid
    .align 7
curr_el_sp0_serror:
    b   handle_serror_invalid

    .align 7
curr_el_spx_sync:
    b   handle_sync_exception_asm
    .align 7
curr_el_spx_irq:
    b   handle_irq_exception_asm
    .align 7
curr_el_spx_fiq:
    b   handle_fiq_invalid
    .align 7
curr_el_spx_serror:
    b   handle_serror_invalid

    .align 7
lower_el_aarch64_sync:
    b   handle_sync_invalid
    .align 7
lower_el_aarch64_irq:
    b   handle_irq_invalid
    .align 7
lower_el_aarch64_fiq:
    b   handle_fiq_invalid
    .align 7
lower_el_aarch64_serror:
    b   handle_serror_invalid

    .align 7
lower_el_aarch32_sync:
    b   handle_sync_invalid
    .align 7
lower_el_aarch32_irq:
    b   handle_irq_invalid
    .align 7
lower_el_aarch32_fiq:
    b   handle_fiq_invalid
    .align 7
lower_el_aarch32_serror:
    b   handle_serror_invalid


handle_sync_invalid:
    save_context
    mov     x0, sp
    bl      c_handle_sync_invalid
    restore_context
    eret

handle_irq_invalid:
    save_context
    bl      c_handle_irq_invalid
    restore_context
    eret

handle_fiq_invalid:
    save_context
    bl      c_handle_fiq_invalid
    restore_context
    eret

handle_serror_invalid:
    save_context
    bl      c_handle_serror_invalid
    restore_context
    eret

trigger_undefined_instruction:
    .inst 0x00000000
    ret

handle_sync_exception_asm:
    save_context
    mov     x0, sp
    bl      handle_sync_exception
    mov     sp, x0
    restore_context
    eret

handle_irq_exception_asm:
    save_context
    mov     x0, sp
    bl      handle_irq_exception
    mov     sp, x0
    restore_context
    eret
