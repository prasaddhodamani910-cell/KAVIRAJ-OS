.section .text.boot
.global _start

_start:
    // 1. Check Processor Core ID (MPIDR_EL1)
    // Only Core 0 continues to boot; auxiliary cores are put to sleep.
    mrs     x0, mpidr_el1
    and     x0, x0, #0xFF
    cbz     x0, master_core

park_core:
    wfe
    b       park_core

master_core:
    // 2. Initialize Stack Pointer to top of allocated kernel stack
    ldr     x0, =__stack_top
    mov     sp, x0

    // 3. Clear BSS section (uninitialized global variables must be zero)
    ldr     x1, =__bss_start
    ldr     x2, =__bss_end
clear_bss_loop:
    cmp     x1, x2
    b.ge    jump_to_kernel
    str     xzr, [x1], #8
    b       clear_bss_loop

jump_to_kernel:
    // 4. Transfer execution to the C kernel entry point
    bl      kmain

    // 5. Halt if kernel returns
halt:
    wfi
    b       halt

