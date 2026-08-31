ENTRY(_start)

SECTIONS
{
    /* Load address: 0x40000000 (Standard RAM base for ARM64 virt machine) */
    . = 0x40000000;
    __kernel_start = .;

    .text : ALIGN(4K) {
        __text_start = .;
        *(.text.boot)
        *(.text .text.*)
        __text_end = .;
    }

    .rodata : ALIGN(4K) {
        __rodata_start = .;
        *(.rodata .rodata.*)
        __rodata_end = .;
    }

    .data : ALIGN(4K) {
        __data_start = .;
        *(.data .data.*)
        __data_end = .;
    }

    .bss : ALIGN(4K) {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(16);
        __bss_end = .;
    }

    .stack : ALIGN(16) {
        . += 0x10000; /* 64 KB Stack */
        __stack_top = .;
    }

    . = ALIGN(4K);
    __kernel_end = .;
}
