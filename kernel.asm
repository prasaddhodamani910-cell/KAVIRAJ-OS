
kernel.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000040000000 <_start>:
40000000: d53800a0     	mrs	x0, MPIDR_EL1
40000004: 92401c00     	and	x0, x0, #0xff
40000008: b4000080     	cbz	x0, 0x40000018 <master_core>

000000004000000c <park_core>:
4000000c: d5034fdf     	msr	DAIFSet, #0xf
40000010: d503207f     	wfi
40000014: 17fffffe     	b	0x4000000c <park_core>

0000000040000018 <master_core>:
40000018: d50041bf     	msr	SPSel, #0x1
4000001c: 58000160     	ldr	x0, 0x40000048 <halt+0x8>
40000020: 9100001f     	mov	sp, x0
40000024: 58000161     	ldr	x1, 0x40000050 <halt+0x10>
40000028: 58000182     	ldr	x2, 0x40000058 <halt+0x18>

000000004000002c <clear_bss_loop>:
4000002c: eb02003f     	cmp	x1, x2
40000030: 5400006a     	b.ge	0x4000003c <jump_to_kernel>
40000034: f800843f     	str	xzr, [x1], #0x8
40000038: 17fffffd     	b	0x4000002c <clear_bss_loop>

000000004000003c <jump_to_kernel>:
4000003c: 94000625     	bl	0x400018d0 <kmain>

0000000040000040 <halt>:
40000040: d503207f     	wfi
40000044: 17ffffff     	b	0x40000040 <halt>
40000048: d0 bd 04 40  	.word	0x4004bdd0
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 c0 00 40  	.word	0x4000c000
40000054: 00 00 00 00  	.word	0x00000000
40000058: d0 bd 03 40  	.word	0x4003bdd0
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 5004b0c0     	adr	x0, 0x4000968a <__rodata_start+0x168a>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000d98     	bl	0x400036e4 <uart_puts>
40000088: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000008c: 913df000     	add	x0, x0, #0xf7c
40000090: aa1403e1     	mov	x1, x20
40000094: 94000ea9     	bl	0x40003b38 <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400000a0: 91013000     	add	x0, x0, #0x4c
400000a4: 94000ea5     	bl	0x40003b38 <uart_printf>
400000a8: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
400000ac: 91101800     	add	x0, x0, #0x406
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000ea1     	bl	0x40003b38 <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400000c0: 91218000     	add	x0, x0, #0x860
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000e9c     	bl	0x40003b38 <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400000f0: 9111b000     	add	x0, x0, #0x46c
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400000fc: 91328800     	add	x0, x0, #0xca2
40000100: 94000d79     	bl	0x400036e4 <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
4000010c: 91027000     	add	x0, x0, #0x9c
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000d73     	bl	0x400036e4 <uart_puts>
4000011c: aa1303e0     	mov	x0, x19
40000120: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40000124: f9400bf5     	ldr	x21, [sp, #0x10]
40000128: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000012c: d65f03c0     	ret

0000000040000130 <c_handle_sync_invalid>:
40000130: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000134: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000138: aa0003f3     	mov	x19, x0
4000013c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000140: 913a4c00     	add	x0, x0, #0xe93
40000144: 910003fd     	mov	x29, sp
40000148: d5385214     	mrs	x20, ESR_EL1
4000014c: 94000e7b     	bl	0x40003b38 <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000158: 912a8000     	add	x0, x0, #0xaa0
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000e76     	bl	0x40003b38 <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000170: 913e3400     	add	x0, x0, #0xf8d
40000174: 910003fd     	mov	x29, sp
40000178: 94000d5b     	bl	0x400036e4 <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000188: 9132f000     	add	x0, x0, #0xcbc
4000018c: 910003fd     	mov	x29, sp
40000190: 94000d55     	bl	0x400036e4 <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400001a0: 91123800     	add	x0, x0, #0x48e
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000d4f     	bl	0x400036e4 <uart_puts>
400001ac: 14000000     	b	0x400001ac <c_handle_serror_invalid+0x14>

00000000400001b0 <handle_irq_exception>:
400001b0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400001b4: a9014ff4     	stp	x20, x19, [sp, #0x10]
400001b8: 910003fd     	mov	x29, sp
400001bc: aa0003f3     	mov	x19, x0
400001c0: 94000038     	bl	0x400002a0 <gic_acknowledge_interrupt>
400001c4: 2a0003f4     	mov	w20, w0
400001c8: 710ffc1f     	cmp	w0, #0x3ff
400001cc: 54000180     	b.eq	0x400001fc <handle_irq_exception+0x4c>
400001d0: 71007a9f     	cmp	w20, #0x1e
400001d4: 540000c1     	b.ne	0x400001ec <handle_irq_exception+0x3c>
400001d8: 94000a61     	bl	0x40002b5c <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 94001559     	bl	0x40005744 <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400001f0: 9117e000     	add	x0, x0, #0x5f8
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000e50     	bl	0x40003b38 <uart_printf>
400001fc: 2a1403e0     	mov	w0, w20
40000200: 9400002d     	bl	0x400002b4 <gic_end_interrupt>
40000204: aa1303e0     	mov	x0, x19
40000208: a9414ff4     	ldp	x20, x19, [sp, #0x10]
4000020c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000210: d65f03c0     	ret

0000000040000214 <gic_init>:
40000214: 52800089     	mov	w9, #0x4                // =4
40000218: 52a10008     	mov	w8, #0x8000000          // =134217728
4000021c: 52801fea     	mov	w10, #0xff              // =255
40000220: 72a10029     	movk	w9, #0x801, lsl #16
40000224: b900011f     	str	wzr, [x8]
40000228: 52a1002b     	mov	w11, #0x8010000         // =134283264
4000022c: b900012a     	str	w10, [x9]
40000230: 52800069     	mov	w9, #0x3                // =3
40000234: b9000169     	str	w9, [x11]
40000238: b9000109     	str	w9, [x8]
4000023c: d65f03c0     	ret

0000000040000240 <gic_enable_interrupt>:
40000240: 53037c0a     	lsr	w10, w0, #3
40000244: 52800028     	mov	w8, #0x1                // =1
40000248: 5280200d     	mov	w13, #0x100             // =256
4000024c: 52808009     	mov	w9, #0x400              // =1024
40000250: 1ac0210b     	lsl	w11, w8, w0
40000254: 72a1000d     	movk	w13, #0x800, lsl #16
40000258: 927e694c     	and	x12, x10, #0x1ffffffc
4000025c: 531d040a     	ubfiz	w10, w0, #3, #2
40000260: 72a10009     	movk	w9, #0x800, lsl #16
40000264: b82d698b     	str	w11, [x12, x13]
40000268: 927e740b     	and	x11, x0, #0xfffffffc
4000026c: 52801fec     	mov	w12, #0xff              // =255
40000270: b869696d     	ldr	w13, [x11, x9]
40000274: 1aca218c     	lsl	w12, w12, w10
40000278: 7100801f     	cmp	w0, #0x20
4000027c: 0a2c01ac     	bic	w12, w13, w12
40000280: b829696c     	str	w12, [x11, x9]
40000284: 540000c3     	b.lo	0x4000029c <gic_enable_interrupt+0x5c>
40000288: 8b0b0129     	add	x9, x9, x11
4000028c: 1aca2108     	lsl	w8, w8, w10
40000290: b944012b     	ldr	w11, [x9, #0x400]
40000294: 2a080168     	orr	w8, w11, w8
40000298: b9040128     	str	w8, [x9, #0x400]
4000029c: d65f03c0     	ret

00000000400002a0 <gic_acknowledge_interrupt>:
400002a0: 52800188     	mov	w8, #0xc                // =12
400002a4: 72a10028     	movk	w8, #0x801, lsl #16
400002a8: b9400108     	ldr	w8, [x8]
400002ac: 12002500     	and	w0, w8, #0x3ff
400002b0: d65f03c0     	ret

00000000400002b4 <gic_end_interrupt>:
400002b4: 52800208     	mov	w8, #0x10               // =16
400002b8: 72a10028     	movk	w8, #0x801, lsl #16
400002bc: b9000100     	str	w0, [x8]
400002c0: d65f03c0     	ret

00000000400002c4 <launch_kedit>:
400002c4: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400002c8: a9016ffc     	stp	x28, x27, [sp, #0x10]
400002cc: 910003fd     	mov	x29, sp
400002d0: a90267fa     	stp	x26, x25, [sp, #0x20]
400002d4: a9035ff8     	stp	x24, x23, [sp, #0x30]
400002d8: a90457f6     	stp	x22, x21, [sp, #0x40]
400002dc: a9054ff4     	stp	x20, x19, [sp, #0x50]
400002e0: d11043ff     	sub	sp, sp, #0x410
400002e4: d503201f     	nop
400002e8: 1005e8d3     	adr	x19, 0x4000c000 <__bss_start>
400002ec: aa0003f4     	mov	x20, x0
400002f0: aa1303e0     	mov	x0, x19
400002f4: 2a1f03e1     	mov	w1, wzr
400002f8: 52864a82     	mov	w2, #0x3254             // =12884
400002fc: 940009aa     	bl	0x400029a4 <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 94000981     	bl	0x40002910 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 940011ce     	bl	0x40004a54 <vfs_find>
40000320: f0000077     	adrp	x23, 0x4000f000 <__bss_start+0x3000>
40000324: b40004a0     	cbz	x0, 0x400003b8 <launch_kedit+0xf4>
40000328: b9402008     	ldr	w8, [x0, #0x20]
4000032c: 35000468     	cbnz	w8, 0x400003b8 <launch_kedit+0xf4>
40000330: f9401408     	ldr	x8, [x0, #0x28]
40000334: b40003c8     	cbz	x8, 0x400003ac <launch_kedit+0xe8>
40000338: 2a1f03e8     	mov	w8, wzr
4000033c: 2a1f03eb     	mov	w11, wzr
40000340: aa1f03e9     	mov	x9, xzr
40000344: 9100c00a     	add	x10, x0, #0x30
40000348: 1400000d     	b	0x4000037c <launch_kedit+0xb8>
4000034c: 93407d0c     	sxtw	x12, w8
40000350: 7101891f     	cmp	w8, #0x62
40000354: 11000508     	add	w8, w8, #0x1
40000358: 8b0c1e6c     	add	x12, x19, x12, lsl #7
4000035c: 8b2bc18b     	add	x11, x12, w11, sxtw
40000360: 3901017f     	strb	wzr, [x11, #0x40]
40000364: 2a1f03eb     	mov	w11, wzr
40000368: 5400022c     	b.gt	0x400003ac <launch_kedit+0xe8>
4000036c: f940140c     	ldr	x12, [x0, #0x28]
40000370: 91000529     	add	x9, x9, #0x1
40000374: eb0c013f     	cmp	x9, x12
40000378: 540001a2     	b.hs	0x400003ac <launch_kedit+0xe8>
4000037c: 3869694c     	ldrb	w12, [x10, x9]
40000380: 7100299f     	cmp	w12, #0xa
40000384: 54fffe40     	b.eq	0x4000034c <launch_kedit+0x88>
40000388: 7101f97f     	cmp	w11, #0x7e
4000038c: 54ffff0c     	b.gt	0x4000036c <launch_kedit+0xa8>
40000390: 2a0803ed     	mov	w13, w8
40000394: 93407dad     	sxtw	x13, w13
40000398: 8b0d1e6d     	add	x13, x19, x13, lsl #7
4000039c: 8b2bc1ad     	add	x13, x13, w11, sxtw
400003a0: 1100056b     	add	w11, w11, #0x1
400003a4: 390101ac     	strb	w12, [x13, #0x40]
400003a8: 17fffff1     	b	0x4000036c <launch_kedit+0xa8>
400003ac: 7100051f     	cmp	w8, #0x1
400003b0: 1a9f8508     	csinc	w8, w8, wzr, hi
400003b4: b90242e8     	str	w8, [x23, #0x240]
400003b8: d503201f     	nop
400003bc: 1004b240     	adr	x0, 0x40009a04 <__rodata_start+0x1a04>
400003c0: 94000cc9     	bl	0x400036e4 <uart_puts>
400003c4: 90000054     	adrp	x20, 0x40008000 <__rodata_start>
400003c8: 9133b694     	add	x20, x20, #0xced
400003cc: 90000056     	adrp	x22, 0x40008000 <__rodata_start>
400003d0: 910372d6     	add	x22, x22, #0xdc
400003d4: b0000058     	adrp	x24, 0x40009000 <__rodata_start+0x1000>
400003d8: 9111fb18     	add	x24, x24, #0x47e
400003dc: b0000059     	adrp	x25, 0x40009000 <__rodata_start+0x1000>
400003e0: 9120eb39     	add	x25, x25, #0x83a
400003e4: f000007a     	adrp	x26, 0x4000f000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: f000007b     	adrp	x27, 0x4000f000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: f0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000cb8     	bl	0x400036e4 <uart_puts>
40000408: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000040c: 910afc00     	add	x0, x0, #0x2bf
40000410: 94000cb5     	bl	0x400036e4 <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000cb3     	bl	0x400036e4 <uart_puts>
4000041c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000420: 913ea800     	add	x0, x0, #0xfaa
40000424: aa1303e1     	mov	x1, x19
40000428: 94000dc4     	bl	0x40003b38 <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: b0000049     	adrp	x9, 0x40009000 <__rodata_start+0x1000>
40000434: 9110d129     	add	x9, x9, #0x434
40000438: 7100011f     	cmp	w8, #0x0
4000043c: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x1000>
40000440: 912a2d08     	add	x8, x8, #0xa8b
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000ca7     	bl	0x400036e4 <uart_puts>
4000044c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000450: 9101e800     	add	x0, x0, #0x7a
40000454: 94000ca4     	bl	0x400036e4 <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000c9b     	bl	0x400036e4 <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000c99     	bl	0x400036e4 <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000c94     	bl	0x400036e4 <uart_puts>
40000498: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000049c: 91122400     	add	x0, x0, #0x489
400004a0: 94000c91     	bl	0x400036e4 <uart_puts>
400004a4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400004a8: 91336400     	add	x0, x0, #0xcd9
400004ac: 94000c8e     	bl	0x400036e4 <uart_puts>
400004b0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400004b4: 9120f000     	add	x0, x0, #0x83c
400004b8: 94000c8b     	bl	0x400036e4 <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
400004c8: 9110c800     	add	x0, x0, #0x432
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000d98     	bl	0x40003b38 <uart_printf>
400004dc: 94000cb6     	bl	0x400037b4 <uart_getc>
400004e0: 12001c08     	and	w8, w0, #0xff
400004e4: 2a0003f5     	mov	w21, w0
400004e8: 7100491f     	cmp	w8, #0x12
400004ec: 5400010d     	b.le	0x4000050c <launch_kedit+0x248>
400004f0: 7100691f     	cmp	w8, #0x1a
400004f4: 540009ed     	b.le	0x40000630 <launch_kedit+0x36c>
400004f8: 71006d1f     	cmp	w8, #0x1b
400004fc: 54000e40     	b.eq	0x400006c4 <launch_kedit+0x400>
40000500: 7101fd1f     	cmp	w8, #0x7f
40000504: 540005e0     	b.eq	0x400005c0 <launch_kedit+0x2fc>
40000508: 1400008b     	b	0x40000734 <launch_kedit+0x470>
4000050c: 7100211f     	cmp	w8, #0x8
40000510: 54000580     	b.eq	0x400005c0 <launch_kedit+0x2fc>
40000514: 7100291f     	cmp	w8, #0xa
40000518: 54000060     	b.eq	0x40000524 <launch_kedit+0x260>
4000051c: 7100351f     	cmp	w8, #0xd
40000520: 540010a1     	b.ne	0x40000734 <launch_kedit+0x470>
40000524: b98242f6     	ldrsw	x22, [x23, #0x240]
40000528: 71018edf     	cmp	w22, #0x63
4000052c: 540014ac     	b.gt	0x400007c0 <launch_kedit+0x4fc>
40000530: b9824b68     	ldrsw	x8, [x27, #0x248]
40000534: 6b0802df     	cmp	w22, w8
40000538: 5400016d     	b.le	0x40000564 <launch_kedit+0x2a0>
4000053c: 8b161e68     	add	x8, x19, x22, lsl #7
40000540: 91010100     	add	x0, x8, #0x40
40000544: d1020015     	sub	x21, x0, #0x80
40000548: d10006d6     	sub	x22, x22, #0x1
4000054c: aa1503e1     	mov	x1, x21
40000550: 940008e9     	bl	0x400028f4 <kstrcpy>
40000554: b9824b68     	ldrsw	x8, [x27, #0x248]
40000558: aa1503e0     	mov	x0, x21
4000055c: eb0802df     	cmp	x22, x8
40000560: 54ffff2c     	b.gt	0x40000544 <launch_kedit+0x280>
40000564: 90000075     	adrp	x21, 0x4000c000 <__bss_start>
40000568: 910102b5     	add	x21, x21, #0x40
4000056c: 910023e0     	add	x0, sp, #0x8
40000570: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000574: 8b081ea8     	add	x8, x21, x8, lsl #7
40000578: 8b090101     	add	x1, x8, x9
4000057c: 940008de     	bl	0x400028f4 <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 940008d4     	bl	0x400028f4 <kstrcpy>
400005a8: b97202a8     	ldr	w8, [x21, #0x3200]
400005ac: b93206bf     	str	wzr, [x21, #0x3204]
400005b0: b93212bc     	str	w28, [x21, #0x3210]
400005b4: 11000508     	add	w8, w8, #0x1
400005b8: b93202a8     	str	w8, [x21, #0x3200]
400005bc: 14000081     	b	0x400007c0 <launch_kedit+0x4fc>
400005c0: f0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
400005c4: b9424508     	ldr	w8, [x8, #0x244]
400005c8: 7100051f     	cmp	w8, #0x1
400005cc: 54000fab     	b.lt	0x400007c0 <launch_kedit+0x4fc>
400005d0: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400005d4: 8b081e68     	add	x8, x19, x8, lsl #7
400005d8: 91010100     	add	x0, x8, #0x40
400005dc: 94000897     	bl	0x40002838 <kstrlen>
400005e0: b9724669     	ldr	w9, [x19, #0x3244]
400005e4: 6b00013f     	cmp	w9, w0
400005e8: 51000528     	sub	w8, w9, #0x1
400005ec: 540001cc     	b.gt	0x40000624 <launch_kedit+0x360>
400005f0: 8b28c268     	add	x8, x19, w8, sxtw
400005f4: 4b090009     	sub	w9, w0, w9
400005f8: 11000529     	add	w9, w9, #0x1
400005fc: b9824b6a     	ldrsw	x10, [x27, #0x248]
40000600: 71000529     	subs	w9, w9, #0x1
40000604: 8b0a1d0a     	add	x10, x8, x10, lsl #7
40000608: 91000508     	add	x8, x8, #0x1
4000060c: 3941054b     	ldrb	w11, [x10, #0x41]
40000610: 3901014b     	strb	w11, [x10, #0x40]
40000614: 54ffff41     	b.ne	0x400005fc <launch_kedit+0x338>
40000618: f0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
4000061c: b9424508     	ldr	w8, [x8, #0x244]
40000620: 51000508     	sub	w8, w8, #0x1
40000624: b9000348     	str	w8, [x26]
40000628: b9000f5c     	str	w28, [x26, #0xc]
4000062c: 14000065     	b	0x400007c0 <launch_kedit+0x4fc>
40000630: 71004d1f     	cmp	w8, #0x13
40000634: 540007c1     	b.ne	0x4000072c <launch_kedit+0x468>
40000638: b94242e8     	ldr	w8, [x23, #0x240]
4000063c: 390023ff     	strb	wzr, [sp, #0x8]
40000640: 7100051f     	cmp	w8, #0x1
40000644: 5400030b     	b.lt	0x400006a4 <launch_kedit+0x3e0>
40000648: aa1f03fc     	mov	x28, xzr
4000064c: 2a1f03f6     	mov	w22, wzr
40000650: 90000075     	adrp	x21, 0x4000c000 <__bss_start>
40000654: 910102b5     	add	x21, x21, #0x40
40000658: 14000006     	b	0x40000670 <launch_kedit+0x3ac>
4000065c: b98242e8     	ldrsw	x8, [x23, #0x240]
40000660: 9100079c     	add	x28, x28, #0x1
40000664: 910202b5     	add	x21, x21, #0x80
40000668: eb08039f     	cmp	x28, x8
4000066c: 540001ca     	b.ge	0x400006a4 <launch_kedit+0x3e0>
40000670: aa1503e0     	mov	x0, x21
40000674: 94000871     	bl	0x40002838 <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 94000872     	bl	0x40002854 <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 9400086f     	bl	0x40002854 <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 94001265     	bl	0x40005040 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: 90000054     	adrp	x20, 0x40008000 <__rodata_start>
400006bc: 9133b694     	add	x20, x20, #0xced
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c3c     	bl	0x400037b4 <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c3a     	bl	0x400037b4 <uart_getc>
400006d0: 71016e9f     	cmp	w20, #0x5b
400006d4: 90000054     	adrp	x20, 0x40008000 <__rodata_start>
400006d8: 9133b694     	add	x20, x20, #0xced
400006dc: 54000721     	b.ne	0x400007c0 <launch_kedit+0x4fc>
400006e0: 12001c09     	and	w9, w0, #0xff
400006e4: b9424b68     	ldr	w8, [x27, #0x248]
400006e8: 7101053f     	cmp	w9, #0x41
400006ec: 54000801     	b.ne	0x400007ec <launch_kedit+0x528>
400006f0: 7100011f     	cmp	w8, #0x0
400006f4: 540007cd     	b.le	0x400007ec <launch_kedit+0x528>
400006f8: 12800009     	mov	w9, #-0x1               // =-1
400006fc: 0b090108     	add	w8, w8, w9
40000700: b9024b68     	str	w8, [x27, #0x248]
40000704: 93407d08     	sxtw	x8, w8
40000708: 8b081e68     	add	x8, x19, x8, lsl #7
4000070c: 91010100     	add	x0, x8, #0x40
40000710: 9400084a     	bl	0x40002838 <kstrlen>
40000714: b9724668     	ldr	w8, [x19, #0x3244]
40000718: 6b00011f     	cmp	w8, w0
4000071c: 5400052d     	b.le	0x400007c0 <launch_kedit+0x4fc>
40000720: f0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
40000724: b9024500     	str	w0, [x8, #0x244]
40000728: 14000026     	b	0x400007c0 <launch_kedit+0x4fc>
4000072c: 7100611f     	cmp	w8, #0x18
40000730: 54000ac0     	b.eq	0x40000888 <launch_kedit+0x5c4>
40000734: 510082a8     	sub	w8, w21, #0x20
40000738: 12001d08     	and	w8, w8, #0xff
4000073c: 7101791f     	cmp	w8, #0x5e
40000740: 54000408     	b.hi	0x400007c0 <launch_kedit+0x4fc>
40000744: f0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
40000748: b9424508     	ldr	w8, [x8, #0x244]
4000074c: 7101f91f     	cmp	w8, #0x7e
40000750: 5400038c     	b.gt	0x400007c0 <launch_kedit+0x4fc>
40000754: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000758: 8b081e68     	add	x8, x19, x8, lsl #7
4000075c: 91010100     	add	x0, x8, #0x40
40000760: 94000836     	bl	0x40002838 <kstrlen>
40000764: b9b24668     	ldrsw	x8, [x19, #0x3244]
40000768: 6b00011f     	cmp	w8, w0
4000076c: 540001ac     	b.gt	0x400007a0 <launch_kedit+0x4dc>
40000770: 93407c08     	sxtw	x8, w0
40000774: 91000509     	add	x9, x8, #0x1
40000778: 8b08026a     	add	x10, x19, x8
4000077c: b9800748     	ldrsw	x8, [x26, #0x4]
40000780: d1000529     	sub	x9, x9, #0x1
40000784: 8b081d48     	add	x8, x10, x8, lsl #7
40000788: d100054a     	sub	x10, x10, #0x1
4000078c: 3941010b     	ldrb	w11, [x8, #0x40]
40000790: 3901050b     	strb	w11, [x8, #0x41]
40000794: b9800348     	ldrsw	x8, [x26]
40000798: eb08013f     	cmp	x9, x8
4000079c: 54ffff0c     	b.gt	0x4000077c <launch_kedit+0x4b8>
400007a0: b9b24a69     	ldrsw	x9, [x19, #0x3248]
400007a4: 8b091e69     	add	x9, x19, x9, lsl #7
400007a8: 8b080128     	add	x8, x9, x8
400007ac: 39010115     	strb	w21, [x8, #0x40]
400007b0: b9724668     	ldr	w8, [x19, #0x3244]
400007b4: b932527c     	str	w28, [x19, #0x3250]
400007b8: 11000508     	add	w8, w8, #0x1
400007bc: b9324668     	str	w8, [x19, #0x3244]
400007c0: f0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
400007c4: 91092129     	add	x9, x9, #0x248
400007c8: 90000056     	adrp	x22, 0x40008000 <__rodata_start>
400007cc: 910372d6     	add	x22, x22, #0xdc
400007d0: 29402528     	ldp	w8, w9, [x9]
400007d4: 6b09011f     	cmp	w8, w9
400007d8: 54ffe10b     	b.lt	0x400003f8 <launch_kedit+0x134>
400007dc: 11005129     	add	w9, w9, #0x14
400007e0: 6b09011f     	cmp	w8, w9
400007e4: 54ffe0eb     	b.lt	0x40000400 <launch_kedit+0x13c>
400007e8: 17ffff03     	b	0x400003f4 <launch_kedit+0x130>
400007ec: 71010d3f     	cmp	w9, #0x43
400007f0: 54000120     	b.eq	0x40000814 <launch_kedit+0x550>
400007f4: 7101093f     	cmp	w9, #0x42
400007f8: 540002a1     	b.ne	0x4000084c <launch_kedit+0x588>
400007fc: b94242e9     	ldr	w9, [x23, #0x240]
40000800: 51000529     	sub	w9, w9, #0x1
40000804: 6b09011f     	cmp	w8, w9
40000808: 54fff7ea     	b.ge	0x40000704 <launch_kedit+0x440>
4000080c: 52800029     	mov	w9, #0x1                // =1
40000810: 17ffffbb     	b	0x400006fc <launch_kedit+0x438>
40000814: 93407d08     	sxtw	x8, w8
40000818: b9b24674     	ldrsw	x20, [x19, #0x3244]
4000081c: 8b081e68     	add	x8, x19, x8, lsl #7
40000820: 91010100     	add	x0, x8, #0x40
40000824: 94000805     	bl	0x40002838 <kstrlen>
40000828: eb14001f     	cmp	x0, x20
4000082c: 90000054     	adrp	x20, 0x40008000 <__rodata_start>
40000830: 9133b694     	add	x20, x20, #0xced
40000834: 54fffc69     	b.ls	0x400007c0 <launch_kedit+0x4fc>
40000838: f0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
4000083c: b9424528     	ldr	w8, [x9, #0x244]
40000840: 11000508     	add	w8, w8, #0x1
40000844: b9024528     	str	w8, [x9, #0x244]
40000848: 17ffffde     	b	0x400007c0 <launch_kedit+0x4fc>
4000084c: 12001c09     	and	w9, w0, #0xff
40000850: 7101113f     	cmp	w9, #0x44
40000854: 54000101     	b.ne	0x40000874 <launch_kedit+0x5b0>
40000858: f0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
4000085c: b9424529     	ldr	w9, [x9, #0x244]
40000860: 71000529     	subs	w9, w9, #0x1
40000864: 5400008b     	b.lt	0x40000874 <launch_kedit+0x5b0>
40000868: f0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
4000086c: b9024509     	str	w9, [x8, #0x244]
40000870: 17ffffd4     	b	0x400007c0 <launch_kedit+0x4fc>
40000874: 51010409     	sub	w9, w0, #0x41
40000878: 12001d29     	and	w9, w9, #0xff
4000087c: 7100093f     	cmp	w9, #0x2
40000880: 54fff423     	b.lo	0x40000704 <launch_kedit+0x440>
40000884: 17ffffcf     	b	0x400007c0 <launch_kedit+0x4fc>
40000888: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000088c: 91282800     	add	x0, x0, #0xa0a
40000890: 94000b95     	bl	0x400036e4 <uart_puts>
40000894: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000898: 9129e400     	add	x0, x0, #0xa79
4000089c: 94000b92     	bl	0x400036e4 <uart_puts>
400008a0: 911043ff     	add	sp, sp, #0x410
400008a4: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400008a8: a94457f6     	ldp	x22, x21, [sp, #0x40]
400008ac: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400008b0: a94267fa     	ldp	x26, x25, [sp, #0x20]
400008b4: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400008b8: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400008bc: d65f03c0     	ret

00000000400008c0 <system_idle_daemon>:
400008c0: d100c3ff     	sub	sp, sp, #0x30
400008c4: a9024ff4     	stp	x20, x19, [sp, #0x20]
400008c8: 529e1014     	mov	w20, #0xf080            // =61568
400008cc: d503201f     	nop
400008d0: 70047b93     	adr	x19, 0x40009843 <__rodata_start+0x1843>
400008d4: 72a05f54     	movk	w20, #0x2fa, lsl #16
400008d8: a9017bfd     	stp	x29, x30, [sp, #0x10]
400008dc: 910043fd     	add	x29, sp, #0x10
400008e0: aa1303e0     	mov	x0, x19
400008e4: 94000b80     	bl	0x400036e4 <uart_puts>
400008e8: b81fc3bf     	stur	wzr, [x29, #-0x4]
400008ec: b85fc3a8     	ldur	w8, [x29, #-0x4]
400008f0: 6b14011f     	cmp	w8, w20
400008f4: 54ffff6a     	b.ge	0x400008e0 <system_idle_daemon+0x20>
400008f8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400008fc: 11000508     	add	w8, w8, #0x1
40000900: b81fc3a8     	stur	w8, [x29, #-0x4]
40000904: 17fffffa     	b	0x400008ec <system_idle_daemon+0x2c>

0000000040000908 <print_banner>:
40000908: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000090c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000910: 910afc00     	add	x0, x0, #0x2bf
40000914: 910003fd     	mov	x29, sp
40000918: 94000b73     	bl	0x400036e4 <uart_puts>
4000091c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000920: 9120e800     	add	x0, x0, #0x83a
40000924: 94000b70     	bl	0x400036e4 <uart_puts>
40000928: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000092c: 9112d800     	add	x0, x0, #0x4b6
40000930: 94000b6d     	bl	0x400036e4 <uart_puts>
40000934: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000938: 912a6000     	add	x0, x0, #0xa98
4000093c: 94000b6a     	bl	0x400036e4 <uart_puts>
40000940: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000944: 913f1400     	add	x0, x0, #0xfc5
40000948: 94000b67     	bl	0x400036e4 <uart_puts>
4000094c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000b64     	bl	0x400036e4 <uart_puts>
40000958: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
4000095c: 91000000     	add	x0, x0, #0x0
40000960: 94000b61     	bl	0x400036e4 <uart_puts>
40000964: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000968: 91186000     	add	x0, x0, #0x618
4000096c: 94000b5e     	bl	0x400036e4 <uart_puts>
40000970: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000974: 91020000     	add	x0, x0, #0x80
40000978: 94000c70     	bl	0x40003b38 <uart_printf>
4000097c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000980: 91211400     	add	x0, x0, #0x845
40000984: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000988: 9116f021     	add	x1, x1, #0x5bc
4000098c: 94000c6b     	bl	0x40003b38 <uart_printf>
40000990: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000994: 91096400     	add	x0, x0, #0x259
40000998: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
4000099c: 9100f021     	add	x1, x1, #0x3c
400009a0: 94000c66     	bl	0x40003b38 <uart_printf>
400009a4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400009a8: 91337800     	add	x0, x0, #0xcde
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000b4d     	b	0x400036e4 <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
400009bc: 91099800     	add	x0, x0, #0x266
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b48     	bl	0x400036e4 <uart_puts>
400009c8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400009cc: 911afc00     	add	x0, x0, #0x6bf
400009d0: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
400009d4: 91013421     	add	x1, x1, #0x4d
400009d8: 94000c58     	bl	0x40003b38 <uart_printf>
400009dc: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
400009e0: 9127d800     	add	x0, x0, #0x9f6
400009e4: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
400009e8: 9116f021     	add	x1, x1, #0x5bc
400009ec: 94000c53     	bl	0x40003b38 <uart_printf>
400009f0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400009f4: 91110400     	add	x0, x0, #0x441
400009f8: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
400009fc: 9100f021     	add	x1, x1, #0x3c
40000a00: 94000c4e     	bl	0x40003b38 <uart_printf>
40000a04: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000a08: 910aa400     	add	x0, x0, #0x2a9
40000a0c: 94000b36     	bl	0x400036e4 <uart_puts>
40000a10: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000a14: 91224800     	add	x0, x0, #0x892
40000a18: 94000b33     	bl	0x400036e4 <uart_puts>
40000a1c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000a20: 9120e800     	add	x0, x0, #0x83a
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b2f     	b	0x400036e4 <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000a34: 91077c00     	add	x0, x0, #0x1df
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b26     	bl	0x400036e4 <uart_puts>
40000a50: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000a54: 912fa800     	add	x0, x0, #0xbea
40000a58: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40000a5c: 91013421     	add	x1, x1, #0x4d
40000a60: 90000042     	adrp	x2, 0x40008000 <__rodata_start>
40000a64: 9116f042     	add	x2, x2, #0x5bc
40000a68: 94000c34     	bl	0x40003b38 <uart_printf>
40000a6c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000a70: 91302400     	add	x0, x0, #0xc09
40000a74: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40000a78: 9100f021     	add	x1, x1, #0x3c
40000a7c: 94000c2f     	bl	0x40003b38 <uart_printf>
40000a80: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000a84: 913ac800     	add	x0, x0, #0xeb2
40000a88: 94000c2c     	bl	0x40003b38 <uart_printf>
40000a8c: d0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x2000>
40000a90: 911ae508     	add	x8, x8, #0x6b9
40000a94: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x2000>
40000a98: 910b7929     	add	x9, x9, #0x2de
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000aa4: 91175c00     	add	x0, x0, #0x5d7
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: b0000049     	adrp	x9, 0x40009000 <__rodata_start+0x1000>
40000ab4: 912b4d29     	add	x9, x9, #0xad3
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c1e     	bl	0x40003b38 <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000acc: 911b6000     	add	x0, x0, #0x6d8
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c19     	bl	0x40003b38 <uart_printf>
40000ad8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000adc: 91360000     	add	x0, x0, #0xd80
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c14     	bl	0x40003b38 <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 10038582     	adr	x2, 0x40007ba8 <__text_end>
40000afc: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000b00: 9133d000     	add	x0, x0, #0xcf4
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c0c     	bl	0x40003b38 <uart_printf>
40000b0c: d503201f     	nop
40000b10: 1003a781     	adr	x1, 0x40008000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 1004f2c2     	adr	x2, 0x4000a970 <__rodata_end>
40000b1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000b20: 911b9000     	add	x0, x0, #0x6e4
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000c04     	bl	0x40003b38 <uart_printf>
40000b2c: d503201f     	nop
40000b30: 10052681     	adr	x1, 0x4000b000 <next_pid>
40000b34: d503201f     	nop
40000b38: 101d94c2     	adr	x2, 0x4003bdd0
40000b3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000b40: 912ea000     	add	x0, x0, #0xba8
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000bfc     	bl	0x40003b38 <uart_printf>
40000b4c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000b50: 91038800     	add	x0, x0, #0xe2
40000b54: d503201f     	nop
40000b58: 102593c1     	adr	x1, 0x4004bdd0 <__stack_top>
40000b5c: 94000bf7     	bl	0x40003b38 <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000b68: 9120e800     	add	x0, x0, #0x83a
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000add     	b	0x400036e4 <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000b7c: 910ba400     	add	x0, x0, #0x2e9
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000ad8     	bl	0x400036e4 <uart_puts>
40000b88: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000b8c: 91366800     	add	x0, x0, #0xd9a
40000b90: 94000ad5     	bl	0x400036e4 <uart_puts>
40000b94: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000b98: 9117e000     	add	x0, x0, #0x5f8
40000b9c: 94000ad2     	bl	0x400036e4 <uart_puts>
40000ba0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000ba4: 91308c00     	add	x0, x0, #0xc23
40000ba8: 94000acf     	bl	0x400036e4 <uart_puts>
40000bac: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000bb0: 911c3800     	add	x0, x0, #0x70e
40000bb4: 94000acc     	bl	0x400036e4 <uart_puts>
40000bb8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000bbc: 910b1c00     	add	x0, x0, #0x2c7
40000bc0: 94000ac9     	bl	0x400036e4 <uart_puts>
40000bc4: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000bc8: 91347800     	add	x0, x0, #0xd1e
40000bcc: 94000ac6     	bl	0x400036e4 <uart_puts>
40000bd0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000bd4: 911b1400     	add	x0, x0, #0x6c5
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000ac2     	b	0x400036e4 <uart_puts>

0000000040000be0 <read_line>:
40000be0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000be4: f9000bf7     	str	x23, [sp, #0x10]
40000be8: aa1f03f7     	mov	x23, xzr
40000bec: 910003fd     	mov	x29, sp
40000bf0: a90257f6     	stp	x22, x21, [sp, #0x20]
40000bf4: d1000435     	sub	x21, x1, #0x1
40000bf8: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000bfc: aa0003f3     	mov	x19, x0
40000c00: d0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x2000>
40000c04: 9121fa94     	add	x20, x20, #0x87e
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000aea     	bl	0x400037b4 <uart_getc>
40000c10: 12001c08     	and	w8, w0, #0xff
40000c14: 7100311f     	cmp	w8, #0xc
40000c18: 540000cc     	b.gt	0x40000c30 <read_line+0x50>
40000c1c: 7100211f     	cmp	w8, #0x8
40000c20: 54000240     	b.eq	0x40000c68 <read_line+0x88>
40000c24: 7100291f     	cmp	w8, #0xa
40000c28: 540000c1     	b.ne	0x40000c40 <read_line+0x60>
40000c2c: 14000015     	b	0x40000c80 <read_line+0xa0>
40000c30: 7100351f     	cmp	w8, #0xd
40000c34: 54000260     	b.eq	0x40000c80 <read_line+0xa0>
40000c38: 7101fd1f     	cmp	w8, #0x7f
40000c3c: 54000160     	b.eq	0x40000c68 <read_line+0x88>
40000c40: 51008008     	sub	w8, w0, #0x20
40000c44: 12001d08     	and	w8, w8, #0xff
40000c48: 7101791f     	cmp	w8, #0x5e
40000c4c: 54fffe08     	b.hi	0x40000c0c <read_line+0x2c>
40000c50: eb1502df     	cmp	x22, x21
40000c54: 54fffdc2     	b.hs	0x40000c0c <read_line+0x2c>
40000c58: 910006d7     	add	x23, x22, #0x1
40000c5c: 38366a60     	strb	w0, [x19, x22]
40000c60: 94000a8a     	bl	0x40003688 <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000a9b     	bl	0x400036e4 <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000c84: 91040800     	add	x0, x0, #0x102
40000c88: 94000a97     	bl	0x400036e4 <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000cac: 912b7c00     	add	x0, x0, #0xadf
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000a8c     	bl	0x400036e4 <uart_puts>
40000cb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000cbc: 9114b800     	add	x0, x0, #0x52e
40000cc0: 94000a89     	bl	0x400036e4 <uart_puts>
40000cc4: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000cc8: 91234800     	add	x0, x0, #0x8d2
40000ccc: 94000a86     	bl	0x400036e4 <uart_puts>
40000cd0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000cd4: 91041400     	add	x0, x0, #0x105
40000cd8: 94000a83     	bl	0x400036e4 <uart_puts>
40000cdc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000ce0: 91080c00     	add	x0, x0, #0x203
40000ce4: 94000a80     	bl	0x400036e4 <uart_puts>
40000ce8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000cec: 91016000     	add	x0, x0, #0x58
40000cf0: 94000a7d     	bl	0x400036e4 <uart_puts>
40000cf4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000cf8: 911c4000     	add	x0, x0, #0x710
40000cfc: 94000a7a     	bl	0x400036e4 <uart_puts>
40000d00: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000d04: 911d6400     	add	x0, x0, #0x759
40000d08: 94000a77     	bl	0x400036e4 <uart_puts>
40000d0c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d10: 91224400     	add	x0, x0, #0x891
40000d14: 94000a74     	bl	0x400036e4 <uart_puts>
40000d18: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000d1c: 911d5800     	add	x0, x0, #0x756
40000d20: 94000a71     	bl	0x400036e4 <uart_puts>
40000d24: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d28: 91234800     	add	x0, x0, #0x8d2
40000d2c: 94000a6e     	bl	0x400036e4 <uart_puts>
40000d30: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000d34: 91359400     	add	x0, x0, #0xd65
40000d38: 94000a6b     	bl	0x400036e4 <uart_puts>
40000d3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000d40: 91038400     	add	x0, x0, #0xe1
40000d44: 94000a68     	bl	0x400036e4 <uart_puts>
40000d48: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000d4c: 910c8400     	add	x0, x0, #0x321
40000d50: 94000a65     	bl	0x400036e4 <uart_puts>
40000d54: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000d58: 91243800     	add	x0, x0, #0x90e
40000d5c: 94000a62     	bl	0x400036e4 <uart_puts>
40000d60: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d64: 91376c00     	add	x0, x0, #0xddb
40000d68: 94000a5f     	bl	0x400036e4 <uart_puts>
40000d6c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d70: 9108a800     	add	x0, x0, #0x22a
40000d74: 94000a5c     	bl	0x400036e4 <uart_puts>
40000d78: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d7c: 911bfc00     	add	x0, x0, #0x6ff
40000d80: 94000a59     	bl	0x400036e4 <uart_puts>
40000d84: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000d88: 91220800     	add	x0, x0, #0x882
40000d8c: 94000a56     	bl	0x400036e4 <uart_puts>
40000d90: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000d94: 9113c400     	add	x0, x0, #0x4f1
40000d98: 94000a53     	bl	0x400036e4 <uart_puts>
40000d9c: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000da0: 910a2000     	add	x0, x0, #0x288
40000da4: 94000a50     	bl	0x400036e4 <uart_puts>
40000da8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000dac: 910c5400     	add	x0, x0, #0x315
40000db0: 94000a4d     	bl	0x400036e4 <uart_puts>
40000db4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000db8: 910d6800     	add	x0, x0, #0x35a
40000dbc: 94000a4a     	bl	0x400036e4 <uart_puts>
40000dc0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000dc4: 91245000     	add	x0, x0, #0x914
40000dc8: 94000a47     	bl	0x400036e4 <uart_puts>
40000dcc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000dd0: 9114d400     	add	x0, x0, #0x535
40000dd4: 94000a44     	bl	0x400036e4 <uart_puts>
40000dd8: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000ddc: 9110ec00     	add	x0, x0, #0x43b
40000de0: 94000a41     	bl	0x400036e4 <uart_puts>
40000de4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000de8: 91232c00     	add	x0, x0, #0x8cb
40000dec: 94000a3e     	bl	0x400036e4 <uart_puts>
40000df0: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000df4: 911e3400     	add	x0, x0, #0x78d
40000df8: 94000a3b     	bl	0x400036e4 <uart_puts>
40000dfc: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000e00: 91364400     	add	x0, x0, #0xd91
40000e04: 94000a38     	bl	0x400036e4 <uart_puts>
40000e08: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000e0c: 91044c00     	add	x0, x0, #0x113
40000e10: 94000a35     	bl	0x400036e4 <uart_puts>
40000e14: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40000e18: 910e7000     	add	x0, x0, #0x39c
40000e1c: 94000a32     	bl	0x400036e4 <uart_puts>
40000e20: 90000040     	adrp	x0, 0x40008000 <__rodata_start>
40000e24: 912b0400     	add	x0, x0, #0xac1
40000e28: 94000a2f     	bl	0x400036e4 <uart_puts>
40000e2c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40000e30: 911d2400     	add	x0, x0, #0x749
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a2b     	b	0x400036e4 <uart_puts>

0000000040000e3c <execute_command>:
40000e3c: d104c3ff     	sub	sp, sp, #0x130
40000e40: a9124ff4     	stp	x20, x19, [sp, #0x120]
40000e44: aa0003f3     	mov	x19, x0
40000e48: aa1f03e8     	mov	x8, xzr
40000e4c: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
40000e50: 910383fd     	add	x29, sp, #0xe0
40000e54: f9007bfc     	str	x28, [sp, #0xf0]
40000e58: a9105ff8     	stp	x24, x23, [sp, #0x100]
40000e5c: a91157f6     	stp	x22, x21, [sp, #0x110]
40000e60: 38686a6a     	ldrb	w10, [x19, x8]
40000e64: 91000508     	add	x8, x8, #0x1
40000e68: 7100815f     	cmp	w10, #0x20
40000e6c: 54ffffa0     	b.eq	0x40000e60 <execute_command+0x24>
40000e70: aa1f03e9     	mov	x9, xzr
40000e74: d10083ab     	sub	x11, x29, #0x20
40000e78: 340001aa     	cbz	w10, 0x40000eac <execute_command+0x70>
40000e7c: f100793f     	cmp	x9, #0x1e
40000e80: 54000168     	b.hi	0x40000eac <execute_command+0x70>
40000e84: 8b09026c     	add	x12, x19, x9
40000e88: 3829696a     	strb	w10, [x11, x9]
40000e8c: 3868698a     	ldrb	w10, [x12, x8]
40000e90: 9100052c     	add	x12, x9, #0x1
40000e94: aa0c03e9     	mov	x9, x12
40000e98: 7100815f     	cmp	w10, #0x20
40000e9c: 54fffee1     	b.ne	0x40000e78 <execute_command+0x3c>
40000ea0: 8b0c0108     	add	x8, x8, x12
40000ea4: aa0c03e9     	mov	x9, x12
40000ea8: 14000002     	b	0x40000eb0 <execute_command+0x74>
40000eac: 8b090108     	add	x8, x8, x9
40000eb0: d1000508     	sub	x8, x8, #0x1
40000eb4: d10083aa     	sub	x10, x29, #0x20
40000eb8: 8b080268     	add	x8, x19, x8
40000ebc: 3829695f     	strb	wzr, [x10, x9]
40000ec0: 38401509     	ldrb	w9, [x8], #0x1
40000ec4: 7100813f     	cmp	w9, #0x20
40000ec8: 54ffffc0     	b.eq	0x40000ec0 <execute_command+0x84>
40000ecc: 35000069     	cbnz	w9, 0x40000ed8 <execute_command+0x9c>
40000ed0: aa1f03ec     	mov	x12, xzr
40000ed4: 1400000a     	b	0x40000efc <execute_command+0xc0>
40000ed8: aa1f03ea     	mov	x10, xzr
40000edc: 910103eb     	add	x11, sp, #0x40
40000ee0: 382a6969     	strb	w9, [x11, x10]
40000ee4: 386a6909     	ldrb	w9, [x8, x10]
40000ee8: 9100054c     	add	x12, x10, #0x1
40000eec: 34000089     	cbz	w9, 0x40000efc <execute_command+0xc0>
40000ef0: f101f95f     	cmp	x10, #0x7e
40000ef4: aa0c03ea     	mov	x10, x12
40000ef8: 54ffff43     	b.lo	0x40000ee0 <execute_command+0xa4>
40000efc: 910103e8     	add	x8, sp, #0x40
40000f00: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40000f04: 91288421     	add	x1, x1, #0xa21
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 9400065a     	bl	0x40002878 <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000f1c: 9126b821     	add	x1, x1, #0x9ae
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 94000655     	bl	0x40002878 <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40000f30: 91097421     	add	x1, x1, #0x25d
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 94000650     	bl	0x40002878 <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40000f44: 91386c21     	add	x1, x1, #0xe1b
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 9400064b     	bl	0x40002878 <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000f58: 910c1821     	add	x1, x1, #0x306
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 94000646     	bl	0x40002878 <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000f6c: 9124c421     	add	x1, x1, #0x931
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 94000641     	bl	0x40002878 <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40000f80: 913b8c21     	add	x1, x1, #0xee3
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 9400063c     	bl	0x40002878 <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40000f94: 91132021     	add	x1, x1, #0x4c8
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 94000637     	bl	0x40002878 <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40000fa8: 912ccc21     	add	x1, x1, #0xb33
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000632     	bl	0x40002878 <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000fbc: 912bc821     	add	x1, x1, #0xaf2
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 9400062d     	bl	0x40002878 <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000fd0: 91152421     	add	x1, x1, #0x549
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 94000628     	bl	0x40002878 <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40000fe4: 911e6421     	add	x1, x1, #0x799
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000623     	bl	0x40002878 <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: 90000041     	adrp	x1, 0x40008000 <__rodata_start>
40000ff8: 9111e021     	add	x1, x1, #0x478
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 9400061e     	bl	0x40002878 <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
4000100c: 9124c821     	add	x1, x1, #0x932
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 94000619     	bl	0x40002878 <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001020: 91307421     	add	x1, x1, #0xc1d
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 94000614     	bl	0x40002878 <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001034: 9124e421     	add	x1, x1, #0x939
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 9400060f     	bl	0x40002878 <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001048: 91027021     	add	x1, x1, #0x9c
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 9400060a     	bl	0x40002878 <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
4000105c: 91052021     	add	x1, x1, #0x148
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 94000605     	bl	0x40002878 <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001070: 910c2421     	add	x1, x1, #0x309
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 94000600     	bl	0x40002878 <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001084: 91116821     	add	x1, x1, #0x45a
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 940005fb     	bl	0x40002878 <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001098: 911ed821     	add	x1, x1, #0x7b6
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 940005f6     	bl	0x40002878 <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
400010ac: 91200c21     	add	x1, x1, #0x803
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 940005f1     	bl	0x40002878 <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
400010c0: 9107c021     	add	x1, x1, #0x1f0
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 940005ec     	bl	0x40002878 <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
400010d4: 91118021     	add	x1, x1, #0x460
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 940005e7     	bl	0x40002878 <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
400010e8: 91202421     	add	x1, x1, #0x809
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 940005e2     	bl	0x40002878 <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
400010fc: 911ef021     	add	x1, x1, #0x7bc
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 940005dd     	bl	0x40002878 <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001110: 9109a021     	add	x1, x1, #0x268
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 940005d8     	bl	0x40002878 <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001124: 910dd421     	add	x1, x1, #0x375
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 940005d3     	bl	0x40002878 <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001138: 9131ec21     	add	x1, x1, #0xc7b
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 940005ce     	bl	0x40002878 <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
4000114c: 9123b421     	add	x1, x1, #0x8ed
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 940005c9     	bl	0x40002878 <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001160: 91136c21     	add	x1, x1, #0x4db
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 940005c4     	bl	0x40002878 <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001174: 9130d821     	add	x1, x1, #0xc36
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 940005bf     	bl	0x40002878 <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001188: 91138000     	add	x0, x0, #0x4e0
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400011a0: 91099800     	add	x0, x0, #0x266
400011a4: 94000950     	bl	0x400036e4 <uart_puts>
400011a8: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400011ac: 911afc00     	add	x0, x0, #0x6bf
400011b0: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
400011b4: 91013421     	add	x1, x1, #0x4d
400011b8: 94000a60     	bl	0x40003b38 <uart_printf>
400011bc: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400011c0: 9127d800     	add	x0, x0, #0x9f6
400011c4: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
400011c8: 9116f021     	add	x1, x1, #0x5bc
400011cc: 94000a5b     	bl	0x40003b38 <uart_printf>
400011d0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400011d4: 91110400     	add	x0, x0, #0x441
400011d8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
400011dc: 9100f021     	add	x1, x1, #0x3c
400011e0: 94000a56     	bl	0x40003b38 <uart_printf>
400011e4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400011e8: 910aa400     	add	x0, x0, #0x2a9
400011ec: 9400093e     	bl	0x400036e4 <uart_puts>
400011f0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400011f4: 91224800     	add	x0, x0, #0x892
400011f8: 9400093b     	bl	0x400036e4 <uart_puts>
400011fc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001200: 9120e800     	add	x0, x0, #0x83a
40001204: 94000938     	bl	0x400036e4 <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001210: 91044800     	add	x0, x0, #0x112
40001214: 94000934     	bl	0x400036e4 <uart_puts>
40001218: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
4000121c: 910aec00     	add	x0, x0, #0x2bb
40001220: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001224: 9116f021     	add	x1, x1, #0x5bc
40001228: 94000a44     	bl	0x40003b38 <uart_printf>
4000122c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001230: 912f4800     	add	x0, x0, #0xbd2
40001234: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001238: 9100f021     	add	x1, x1, #0x3c
4000123c: 94000a3f     	bl	0x40003b38 <uart_printf>
40001240: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001244: 91053c00     	add	x0, x0, #0x14f
40001248: 94000927     	bl	0x400036e4 <uart_puts>
4000124c: 14000002     	b	0x40001254 <execute_command+0x418>
40001250: 97fffdf7     	bl	0x40000a2c <print_sysinfo>
40001254: a9524ff4     	ldp	x20, x19, [sp, #0x120]
40001258: f9407bfc     	ldr	x28, [sp, #0xf0]
4000125c: a95157f6     	ldp	x22, x21, [sp, #0x110]
40001260: a9505ff8     	ldp	x24, x23, [sp, #0x100]
40001264: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
40001268: 9104c3ff     	add	sp, sp, #0x130
4000126c: d65f03c0     	ret
40001270: 910103e0     	add	x0, sp, #0x40
40001274: 94000571     	bl	0x40002838 <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000f80     	bl	0x40005080 <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
4000128c: 9112b800     	add	x0, x0, #0x4ae
40001290: 94000915     	bl	0x400036e4 <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 94000567     	bl	0x40002838 <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 94000637     	bl	0x40002b8c <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 940001fe     	bl	0x40001ab4 <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400012c8: 91190c00     	add	x0, x0, #0x643
400012cc: 94000906     	bl	0x400036e4 <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400012d8: 9131c400     	add	x0, x0, #0xc71
400012dc: 94000902     	bl	0x400036e4 <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400012e8: 9136f800     	add	x0, x0, #0xdbe
400012ec: 940008fe     	bl	0x400036e4 <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000332     	bl	0x40001fbc <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 9400054e     	bl	0x40002838 <kstrlen>
40001304: b40004c0     	cbz	x0, 0x4000139c <execute_command+0x560>
40001308: 394103e8     	ldrb	w8, [sp, #0x40]
4000130c: 5100c109     	sub	w9, w8, #0x30
40001310: 7100253f     	cmp	w9, #0x9
40001314: 540004c8     	b.hi	0x400013ac <execute_command+0x570>
40001318: 910103e9     	add	x9, sp, #0x40
4000131c: 2a1f03f3     	mov	w19, wzr
40001320: 5280014a     	mov	w10, #0xa               // =10
40001324: b2400129     	orr	x9, x9, #0x1
40001328: 1b0a226b     	madd	w11, w19, w10, w8
4000132c: 38401528     	ldrb	w8, [x9], #0x1
40001330: 5100c10c     	sub	w12, w8, #0x30
40001334: 7100299f     	cmp	w12, #0xa
40001338: 5100c173     	sub	w19, w11, #0x30
4000133c: 54ffff63     	b.lo	0x40001328 <execute_command+0x4ec>
40001340: 1400001c     	b	0x400013b0 <execute_command+0x574>
40001344: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001348: 9124dc21     	add	x1, x1, #0x937
4000134c: aa1303e0     	mov	x0, x19
40001350: 940005b4     	bl	0x40002a20 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f35     	bl	0x40005040 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001378: 91099421     	add	x1, x1, #0x265
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 9400053e     	bl	0x40002878 <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
4000138c: 911a0000     	add	x0, x0, #0x680
40001390: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001394: 91013421     	add	x1, x1, #0x4d
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400013a0: 9115ec00     	add	x0, x0, #0x57b
400013a4: 940008d0     	bl	0x400036e4 <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 9400026d     	bl	0x40001d68 <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400013c8: 9106cc00     	add	x0, x0, #0x1b3
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400013d4: 91071c00     	add	x0, x0, #0x1c7
400013d8: 940008c3     	bl	0x400036e4 <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400013e4: 911a0000     	add	x0, x0, #0x680
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400013f4: 91196400     	add	x0, x0, #0x659
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 940009cf     	bl	0x40003b38 <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d42     	bl	0x4000490c <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 9400050a     	bl	0x40002838 <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000d8e     	bl	0x40004a54 <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: 90000048     	adrp	x8, 0x40009000 <__rodata_start+0x1000>
40001434: 911e7908     	add	x8, x8, #0x79e
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 940009be     	bl	0x40003b38 <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d32     	bl	0x40004918 <vfs_getcwd>
40001454: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001458: 911a0000     	add	x0, x0, #0x680
4000145c: 910003e1     	mov	x1, sp
40001460: 940009b6     	bl	0x40003b38 <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
4000146c: 911f5000     	add	x0, x0, #0x7d4
40001470: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001474: 91013421     	add	x1, x1, #0x4d
40001478: f0000022     	adrp	x2, 0x40008000 <__rodata_start>
4000147c: 9116f042     	add	x2, x2, #0x5bc
40001480: b0000043     	adrp	x3, 0x4000a000 <__rodata_start+0x2000>
40001484: 9100f063     	add	x3, x3, #0x3c
40001488: 940009ac     	bl	0x40003b38 <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f34     	bl	0x40005164 <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000dd2     	bl	0x40004be8 <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400014ac: 910d4400     	add	x0, x0, #0x351
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400014bc: 91163800     	add	x0, x0, #0x58e
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 940004db     	bl	0x40002838 <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000d5f     	bl	0x40004a54 <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400014ec: 910c3400     	add	x0, x0, #0x30d
400014f0: 9400087d     	bl	0x400036e4 <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 940004cf     	bl	0x40002838 <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000ddd     	bl	0x40004c7c <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001514: 9107c000     	add	x0, x0, #0x1f0
40001518: 94000873     	bl	0x400036e4 <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 940004c5     	bl	0x40002838 <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e28     	bl	0x40004dd4 <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001540: 91133000     	add	x0, x0, #0x4cc
40001544: 94000868     	bl	0x400036e4 <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001550: 910f3c00     	add	x0, x0, #0x3cf
40001554: 94000864     	bl	0x400036e4 <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 9400054a     	bl	0x40002a8c <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000eb2     	bl	0x40005040 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001584: 9111f800     	add	x0, x0, #0x47e
40001588: 94000857     	bl	0x400036e4 <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001594: 91172800     	add	x0, x0, #0x5ca
40001598: 94000853     	bl	0x400036e4 <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400015a4: 910afc00     	add	x0, x0, #0x2bf
400015a8: 9400084f     	bl	0x400036e4 <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400015b4: 9120e800     	add	x0, x0, #0x83a
400015b8: 9400084b     	bl	0x400036e4 <uart_puts>
400015bc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400015c0: 913ba400     	add	x0, x0, #0xee9
400015c4: 94000848     	bl	0x400036e4 <uart_puts>
400015c8: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 94000845     	bl	0x400036e4 <uart_puts>
400015d4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400015d8: 91388c00     	add	x0, x0, #0xe23
400015dc: 94000842     	bl	0x400036e4 <uart_puts>
400015e0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
400015e4: 91123400     	add	x0, x0, #0x48d
400015e8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
400015ec: 9100f021     	add	x1, x1, #0x3c
400015f0: 94000952     	bl	0x40003b38 <uart_printf>
400015f4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400015f8: 9124f000     	add	x0, x0, #0x93c
400015fc: 9400083a     	bl	0x400036e4 <uart_puts>
40001600: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001604: 911e7800     	add	x0, x0, #0x79e
40001608: 94000837     	bl	0x400036e4 <uart_puts>
4000160c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001610: 91177c00     	add	x0, x0, #0x5df
40001614: 94000834     	bl	0x400036e4 <uart_puts>
40001618: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000161c: 912cec00     	add	x0, x0, #0xb3b
40001620: 94000831     	bl	0x400036e4 <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: f0000028     	adrp	x8, 0x40008000 <__rodata_start>
4000162c: 911a0108     	add	x8, x8, #0x680
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001640: 91308400     	add	x0, x0, #0xc21
40001644: 94000828     	bl	0x400036e4 <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001650: 91375c00     	add	x0, x0, #0xdd7
40001654: 94000824     	bl	0x400036e4 <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 94000476     	bl	0x40002838 <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 9400043b     	bl	0x40002758 <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001678: 910f9800     	add	x0, x0, #0x3e6
4000167c: 9400081a     	bl	0x400036e4 <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001688: 913b2000     	add	x0, x0, #0xec8
4000168c: 94000816     	bl	0x400036e4 <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: f0000035     	adrp	x21, 0x40008000 <__rodata_start>
40001698: 9112b2b5     	add	x21, x21, #0x4ac
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 940007f8     	bl	0x40003688 <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 940007f5     	bl	0x40003688 <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 940007f3     	bl	0x40003688 <uart_putc>
400016c0: f0000033     	adrp	x19, 0x40008000 <__rodata_start>
400016c4: 910c8a73     	add	x19, x19, #0x322
400016c8: 90000054     	adrp	x20, 0x40009000 <__rodata_start+0x1000>
400016cc: 9120ea94     	add	x20, x20, #0x83a
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 940007e7     	bl	0x40003688 <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 940007e4     	bl	0x40003688 <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 940007e2     	bl	0x40003688 <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 940007f2     	bl	0x400036e4 <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 940007ee     	bl	0x400036e4 <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001738: 9137e800     	add	x0, x0, #0xdfa
4000173c: 940007ea     	bl	0x400036e4 <uart_puts>
40001740: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001744: 9107fc00     	add	x0, x0, #0x1ff
40001748: 940007e7     	bl	0x400036e4 <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001764: 912d7000     	add	x0, x0, #0xb5c
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 940007d8     	bl	0x400036e4 <uart_puts>
40001788: f0000033     	adrp	x19, 0x40008000 <__rodata_start>
4000178c: 913bb273     	add	x19, x19, #0xeec
40001790: 90000054     	adrp	x20, 0x40009000 <__rodata_start+0x1000>
40001794: 91052e94     	add	x20, x20, #0x14b
40001798: b0000055     	adrp	x21, 0x4000a000 <__rodata_start+0x2000>
4000179c: 9121fab5     	add	x21, x21, #0x87e
400017a0: 90000056     	adrp	x22, 0x40009000 <__rodata_start+0x1000>
400017a4: 91040ad6     	add	x22, x22, #0x102
400017a8: b0000057     	adrp	x23, 0x4000a000 <__rodata_start+0x2000>
400017ac: 9123b6f7     	add	x23, x23, #0x8ed
400017b0: b0000058     	adrp	x24, 0x4000a000 <__rodata_start+0x2000>
400017b4: 91136f18     	add	x24, x24, #0x4db
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: f0000039     	adrp	x25, 0x40008000 <__rodata_start>
400017c0: 9130db39     	add	x25, x25, #0xc36
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000c53     	bl	0x40004918 <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 940008d8     	bl	0x40003b38 <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 940007c1     	bl	0x400036e4 <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 940007f2     	bl	0x400037b4 <uart_getc>
400017f0: 12001c08     	and	w8, w0, #0xff
400017f4: 7100311f     	cmp	w8, #0xc
400017f8: 540000cc     	b.gt	0x40001810 <kernel_shell+0xb4>
400017fc: 7100211f     	cmp	w8, #0x8
40001800: 54000240     	b.eq	0x40001848 <kernel_shell+0xec>
40001804: 7100291f     	cmp	w8, #0xa
40001808: 540000c1     	b.ne	0x40001820 <kernel_shell+0xc4>
4000180c: 14000015     	b	0x40001860 <kernel_shell+0x104>
40001810: 7100351f     	cmp	w8, #0xd
40001814: 54000260     	b.eq	0x40001860 <kernel_shell+0x104>
40001818: 7101fd1f     	cmp	w8, #0x7f
4000181c: 54000160     	b.eq	0x40001848 <kernel_shell+0xec>
40001820: 51008008     	sub	w8, w0, #0x20
40001824: 12001d08     	and	w8, w8, #0xff
40001828: 7101791f     	cmp	w8, #0x5e
4000182c: 54fffe08     	b.hi	0x400017ec <kernel_shell+0x90>
40001830: f1027b7f     	cmp	x27, #0x9e
40001834: 54fffdc8     	b.hi	0x400017ec <kernel_shell+0x90>
40001838: 9100077c     	add	x28, x27, #0x1
4000183c: 383b6b40     	strb	w0, [x26, x27]
40001840: 94000792     	bl	0x40003688 <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 940007a3     	bl	0x400036e4 <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 940007a0     	bl	0x400036e4 <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 940003f2     	bl	0x40002838 <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 940002f2     	bl	0x40002444 <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 940003fc     	bl	0x40002878 <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 940003f8     	bl	0x40002878 <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 940003f4     	bl	0x40002878 <kstrcmp>
400018ac: 35fff8c0     	cbnz	w0, 0x400017c4 <kernel_shell+0x68>
400018b0: a9544ff4     	ldp	x20, x19, [sp, #0x140]
400018b4: a95357f6     	ldp	x22, x21, [sp, #0x130]
400018b8: a9525ff8     	ldp	x24, x23, [sp, #0x120]
400018bc: a95167fa     	ldp	x26, x25, [sp, #0x110]
400018c0: a9506ffc     	ldp	x28, x27, [sp, #0x100]
400018c4: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
400018c8: 910543ff     	add	sp, sp, #0x150
400018cc: d65f03c0     	ret

00000000400018d0 <kmain>:
400018d0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
400018d4: f9000bfc     	str	x28, [sp, #0x10]
400018d8: 910003fd     	mov	x29, sp
400018dc: a9024ff4     	stp	x20, x19, [sp, #0x20]
400018e0: d10803ff     	sub	sp, sp, #0x200
400018e4: 529c6c13     	mov	w19, #0xe360            // =58208
400018e8: 72a002d3     	movk	w19, #0x16, lsl #16
400018ec: 9400075b     	bl	0x40003658 <uart_init>
400018f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400018f4: 910afc00     	add	x0, x0, #0x2bf
400018f8: 9400077b     	bl	0x400036e4 <uart_puts>
400018fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001900: 91153800     	add	x0, x0, #0x54e
40001904: 94000778     	bl	0x400036e4 <uart_puts>
40001908: b90003ff     	str	wzr, [sp]
4000190c: b94003e8     	ldr	w8, [sp]
40001910: 6b13011f     	cmp	w8, w19
40001914: 540000aa     	b.ge	0x40001928 <kmain+0x58>
40001918: b94003e8     	ldr	w8, [sp]
4000191c: 11000508     	add	w8, w8, #0x1
40001920: b90003e8     	str	w8, [sp]
40001924: 17fffffa     	b	0x4000190c <kmain+0x3c>
40001928: 528aa213     	mov	w19, #0x5510            // =21776
4000192c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001930: 910c9000     	add	x0, x0, #0x324
40001934: 72a00453     	movk	w19, #0x22, lsl #16
40001938: 9400076b     	bl	0x400036e4 <uart_puts>
4000193c: b90003ff     	str	wzr, [sp]
40001940: b94003e8     	ldr	w8, [sp]
40001944: 6b13011f     	cmp	w8, w19
40001948: 540000aa     	b.ge	0x4000195c <kmain+0x8c>
4000194c: b94003e8     	ldr	w8, [sp]
40001950: 11000508     	add	w8, w8, #0x1
40001954: b90003e8     	str	w8, [sp]
40001958: 17fffffa     	b	0x40001940 <kmain+0x70>
4000195c: 5298d814     	mov	w20, #0xc6c0            // =50880
40001960: 72a005b4     	movk	w20, #0x2d, lsl #16
40001964: 94000a81     	bl	0x40004368 <vfs_init>
40001968: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000196c: 9125a800     	add	x0, x0, #0x96a
40001970: 9400075d     	bl	0x400036e4 <uart_puts>
40001974: b90003ff     	str	wzr, [sp]
40001978: b94003e8     	ldr	w8, [sp]
4000197c: 6b14011f     	cmp	w8, w20
40001980: 540000aa     	b.ge	0x40001994 <kmain+0xc4>
40001984: b94003e8     	ldr	w8, [sp]
40001988: 11000508     	add	w8, w8, #0x1
4000198c: b90003e8     	str	w8, [sp]
40001990: 17fffffa     	b	0x40001978 <kmain+0xa8>
40001994: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001998: 9107d800     	add	x0, x0, #0x1f6
4000199c: d503201f     	nop
400019a0: 1002b308     	adr	x8, 0x40007000 <exception_vector_table>
400019a4: d518c008     	msr	VBAR_EL1, x8
400019a8: 9400074f     	bl	0x400036e4 <uart_puts>
400019ac: b90003ff     	str	wzr, [sp]
400019b0: b94003e8     	ldr	w8, [sp]
400019b4: 6b13011f     	cmp	w8, w19
400019b8: 540000aa     	b.ge	0x400019cc <kmain+0xfc>
400019bc: b94003e8     	ldr	w8, [sp]
400019c0: 11000508     	add	w8, w8, #0x1
400019c4: b90003e8     	str	w8, [sp]
400019c8: 17fffffa     	b	0x400019b0 <kmain+0xe0>
400019cc: 97fffa12     	bl	0x40000214 <gic_init>
400019d0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400019d4: 911f2000     	add	x0, x0, #0x7c8
400019d8: 94000743     	bl	0x400036e4 <uart_puts>
400019dc: b90003ff     	str	wzr, [sp]
400019e0: b94003e8     	ldr	w8, [sp]
400019e4: 6b13011f     	cmp	w8, w19
400019e8: 540000aa     	b.ge	0x400019fc <kmain+0x12c>
400019ec: b94003e8     	ldr	w8, [sp]
400019f0: 11000508     	add	w8, w8, #0x1
400019f4: b90003e8     	str	w8, [sp]
400019f8: 17fffffa     	b	0x400019e0 <kmain+0x110>
400019fc: 94000442     	bl	0x40002b04 <timer_init>
40001a00: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001a04: 91289800     	add	x0, x0, #0xa26
40001a08: 94000737     	bl	0x400036e4 <uart_puts>
40001a0c: b90003ff     	str	wzr, [sp]
40001a10: b94003e8     	ldr	w8, [sp]
40001a14: 6b13011f     	cmp	w8, w19
40001a18: 540000aa     	b.ge	0x40001a2c <kmain+0x15c>
40001a1c: b94003e8     	ldr	w8, [sp]
40001a20: 11000508     	add	w8, w8, #0x1
40001a24: b90003e8     	str	w8, [sp]
40001a28: 17fffffa     	b	0x40001a10 <kmain+0x140>
40001a2c: 94000e14     	bl	0x4000527c <pmm_init>
40001a30: 94000ea8     	bl	0x400054d0 <sched_init>
40001a34: 94000f67     	bl	0x400057d0 <virtio_blk_init>
40001a38: 34000140     	cbz	w0, 0x40001a60 <kmain+0x190>
40001a3c: 910003e1     	mov	x1, sp
40001a40: aa1f03e0     	mov	x0, xzr
40001a44: 94000fad     	bl	0x400058f8 <virtio_blk_read_sector>
40001a48: 34000080     	cbz	w0, 0x40001a58 <kmain+0x188>
40001a4c: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001a50: 913d6000     	add	x0, x0, #0xf58
40001a54: 94000724     	bl	0x400036e4 <uart_puts>
40001a58: 940010e4     	bl	0x40005de8 <fat16_init>
40001a5c: 94000e07     	bl	0x40005278 <vfs_load>
40001a60: 529e1014     	mov	w20, #0xf080            // =61568
40001a64: d503201f     	nop
40001a68: 10ff72c0     	adr	x0, 0x400008c0 <system_idle_daemon>
40001a6c: 72a05f54     	movk	w20, #0x2fa, lsl #16
40001a70: 94000ebf     	bl	0x4000556c <sched_create_task>
40001a74: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001a78: 911a1000     	add	x0, x0, #0x684
40001a7c: 9400071a     	bl	0x400036e4 <uart_puts>
40001a80: f0000033     	adrp	x19, 0x40008000 <__rodata_start>
40001a84: 9130ee73     	add	x19, x19, #0xc3b
40001a88: d50342ff     	msr	DAIFClr, #0x2
40001a8c: aa1303e0     	mov	x0, x19
40001a90: 94000715     	bl	0x400036e4 <uart_puts>
40001a94: b90003ff     	str	wzr, [sp]
40001a98: b94003e8     	ldr	w8, [sp]
40001a9c: 6b14011f     	cmp	w8, w20
40001aa0: 54ffff6a     	b.ge	0x40001a8c <kmain+0x1bc>
40001aa4: b94003e8     	ldr	w8, [sp]
40001aa8: 11000508     	add	w8, w8, #0x1
40001aac: b90003e8     	str	w8, [sp]
40001ab0: 17fffffa     	b	0x40001a98 <kmain+0x1c8>

0000000040001ab4 <kproj_execute>:
40001ab4: d10683ff     	sub	sp, sp, #0x1a0
40001ab8: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001abc: 910603fd     	add	x29, sp, #0x180
40001ac0: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001ac4: b40001c0     	cbz	x0, 0x40001afc <kproj_execute+0x48>
40001ac8: aa0003f3     	mov	x19, x0
40001acc: 9400035b     	bl	0x40002838 <kstrlen>
40001ad0: b4000160     	cbz	x0, 0x40001afc <kproj_execute+0x48>
40001ad4: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001ad8: 91283c00     	add	x0, x0, #0xa0f
40001adc: aa1303e1     	mov	x1, x19
40001ae0: 94000816     	bl	0x40003b38 <uart_printf>
40001ae4: aa1303e0     	mov	x0, x19
40001ae8: 94000c65     	bl	0x40004c7c <vfs_mkdir>
40001aec: 34000140     	cbz	w0, 0x40001b14 <kproj_execute+0x60>
40001af0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001af4: 9123c800     	add	x0, x0, #0x8f2
40001af8: 14000003     	b	0x40001b04 <kproj_execute+0x50>
40001afc: d503201f     	nop
40001b00: 10045000     	adr	x0, 0x4000a500 <__rodata_start+0x2500>
40001b04: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001b08: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001b0c: 910683ff     	add	sp, sp, #0x1a0
40001b10: 140006f5     	b	0x400036e4 <uart_puts>
40001b14: aa1303e0     	mov	x0, x19
40001b18: 94000c34     	bl	0x40004be8 <vfs_chdir>
40001b1c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001b20: 9105a000     	add	x0, x0, #0x168
40001b24: 94000c56     	bl	0x40004c7c <vfs_mkdir>
40001b28: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001b2c: 911efc00     	add	x0, x0, #0x7bf
40001b30: 94000c53     	bl	0x40004c7c <vfs_mkdir>
40001b34: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001b38: 91090c21     	add	x1, x1, #0x243
40001b3c: 910203e0     	add	x0, sp, #0x80
40001b40: 9400036d     	bl	0x400028f4 <kstrcpy>
40001b44: 910203e0     	add	x0, sp, #0x80
40001b48: aa1303e1     	mov	x1, x19
40001b4c: 94000342     	bl	0x40002854 <kstrcat>
40001b50: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001b54: 913e5421     	add	x1, x1, #0xf95
40001b58: 910203e0     	add	x0, sp, #0x80
40001b5c: 9400033e     	bl	0x40002854 <kstrcat>
40001b60: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001b64: 9124e400     	add	x0, x0, #0x939
40001b68: 910203e1     	add	x1, sp, #0x80
40001b6c: 94000c9a     	bl	0x40004dd4 <vfs_touch>
40001b70: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40001b74: 91089400     	add	x0, x0, #0x225
40001b78: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001b7c: 9130f421     	add	x1, x1, #0xc3d
40001b80: 94000c95     	bl	0x40004dd4 <vfs_touch>
40001b84: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001b88: 9109b021     	add	x1, x1, #0x26c
40001b8c: 910003e0     	mov	x0, sp
40001b90: 94000359     	bl	0x400028f4 <kstrcpy>
40001b94: 910003e0     	mov	x0, sp
40001b98: aa1303e1     	mov	x1, x19
40001b9c: 9400032e     	bl	0x40002854 <kstrcat>
40001ba0: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001ba4: 912bdc21     	add	x1, x1, #0xaf7
40001ba8: 910003e0     	mov	x0, sp
40001bac: 9400032a     	bl	0x40002854 <kstrcat>
40001bb0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001bb4: 913f0400     	add	x0, x0, #0xfc1
40001bb8: 910003e1     	mov	x1, sp
40001bbc: 94000c86     	bl	0x40004dd4 <vfs_touch>
40001bc0: 94000c84     	bl	0x40004dd0 <vfs_sync>
40001bc4: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001bc8: 9112f400     	add	x0, x0, #0x4bd
40001bcc: 940006c6     	bl	0x400036e4 <uart_puts>
40001bd0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001bd4: 9113b000     	add	x0, x0, #0x4ec
40001bd8: aa1303e1     	mov	x1, x19
40001bdc: 940007d7     	bl	0x40003b38 <uart_printf>
40001be0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001be4: 9105b000     	add	x0, x0, #0x16c
40001be8: 94000c00     	bl	0x40004be8 <vfs_chdir>
40001bec: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001bf0: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001bf4: 910683ff     	add	sp, sp, #0x1a0
40001bf8: d65f03c0     	ret

0000000040001bfc <process_init>:
40001bfc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001c00: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001c04: d0000054     	adrp	x20, 0x4000b000 <next_pid>
40001c08: d503201f     	nop
40001c0c: 1006b253     	adr	x19, 0x4000f254 <proc_table>
40001c10: b9400289     	ldr	w9, [x20]
40001c14: 52800068     	mov	w8, #0x3                // =3
40001c18: b9002668     	str	w8, [x19, #0x24]
40001c1c: d503201f     	nop
40001c20: 7003f281     	adr	x1, 0x40009a73 <__rodata_start+0x1a73>
40001c24: b9005668     	str	w8, [x19, #0x54]
40001c28: 91001260     	add	x0, x19, #0x4
40001c2c: 910003fd     	mov	x29, sp
40001c30: b9008668     	str	w8, [x19, #0x84]
40001c34: b900b668     	str	w8, [x19, #0xb4]
40001c38: b900e668     	str	w8, [x19, #0xe4]
40001c3c: b9011668     	str	w8, [x19, #0x114]
40001c40: b9014668     	str	w8, [x19, #0x144]
40001c44: b9017668     	str	w8, [x19, #0x174]
40001c48: b901a668     	str	w8, [x19, #0x1a4]
40001c4c: b901d668     	str	w8, [x19, #0x1d4]
40001c50: b9020668     	str	w8, [x19, #0x204]
40001c54: b9023668     	str	w8, [x19, #0x234]
40001c58: b9026668     	str	w8, [x19, #0x264]
40001c5c: b9029668     	str	w8, [x19, #0x294]
40001c60: b902c668     	str	w8, [x19, #0x2c4]
40001c64: b902f668     	str	w8, [x19, #0x2f4]
40001c68: 11000528     	add	w8, w9, #0x1
40001c6c: f9000bf5     	str	x21, [sp, #0x10]
40001c70: b900327f     	str	wzr, [x19, #0x30]
40001c74: b900627f     	str	wzr, [x19, #0x60]
40001c78: b900927f     	str	wzr, [x19, #0x90]
40001c7c: b900c27f     	str	wzr, [x19, #0xc0]
40001c80: b900f27f     	str	wzr, [x19, #0xf0]
40001c84: b901227f     	str	wzr, [x19, #0x120]
40001c88: b901527f     	str	wzr, [x19, #0x150]
40001c8c: b901827f     	str	wzr, [x19, #0x180]
40001c90: b901b27f     	str	wzr, [x19, #0x1b0]
40001c94: b901e27f     	str	wzr, [x19, #0x1e0]
40001c98: b902127f     	str	wzr, [x19, #0x210]
40001c9c: b902427f     	str	wzr, [x19, #0x240]
40001ca0: b902727f     	str	wzr, [x19, #0x270]
40001ca4: b902a27f     	str	wzr, [x19, #0x2a0]
40001ca8: b902d27f     	str	wzr, [x19, #0x2d0]
40001cac: b9000288     	str	w8, [x20]
40001cb0: b9000269     	str	w9, [x19]
40001cb4: 94000310     	bl	0x400028f4 <kstrcpy>
40001cb8: b9400288     	ldr	w8, [x20]
40001cbc: 52a00209     	mov	w9, #0x100000           // =1048576
40001cc0: 5280384a     	mov	w10, #0x1c2             // =450
40001cc4: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001cc8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40001ccc: 9124ac21     	add	x1, x1, #0x92b
40001cd0: 11000509     	add	w9, w8, #0x1
40001cd4: 9100d260     	add	x0, x19, #0x34
40001cd8: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001cdc: b9000289     	str	w9, [x20]
40001ce0: 94000305     	bl	0x400028f4 <kstrcpy>
40001ce4: b9400288     	ldr	w8, [x20]
40001ce8: 529d0009     	mov	w9, #0xe800             // =59392
40001cec: 52800035     	mov	w21, #0x1               // =1
40001cf0: 72a00069     	movk	w9, #0x3, lsl #16
40001cf4: 5280018a     	mov	w10, #0xc               // =12
40001cf8: f0000021     	adrp	x1, 0x40008000 <__rodata_start>
40001cfc: 912c6421     	add	x1, x1, #0xb19
40001d00: 290aa675     	stp	w21, w9, [x19, #0x54]
40001d04: 11000509     	add	w9, w8, #0x1
40001d08: 91019260     	add	x0, x19, #0x64
40001d0c: b9000289     	str	w9, [x20]
40001d10: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001d14: 940002f8     	bl	0x400028f4 <kstrcpy>
40001d18: b9400288     	ldr	w8, [x20]
40001d1c: 52a00809     	mov	w9, #0x400000           // =4194304
40001d20: 5280960a     	mov	w10, #0x4b0             // =1200
40001d24: 2910a675     	stp	w21, w9, [x19, #0x84]
40001d28: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40001d2c: 91119821     	add	x1, x1, #0x466
40001d30: 11000509     	add	w9, w8, #0x1
40001d34: 91025260     	add	x0, x19, #0x94
40001d38: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001d3c: b9000289     	str	w9, [x20]
40001d40: 940002ed     	bl	0x400028f4 <kstrcpy>
40001d44: 529a0008     	mov	w8, #0xd000             // =53248
40001d48: 52800aa9     	mov	w9, #0x55               // =85
40001d4c: f9400bf5     	ldr	x21, [sp, #0x10]
40001d50: 72a000e8     	movk	w8, #0x7, lsl #16
40001d54: b900be69     	str	w9, [x19, #0xbc]
40001d58: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001d5c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001d60: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001d64: d65f03c0     	ret

0000000040001d68 <process_kill>:
40001d68: 7100041f     	cmp	w0, #0x1
40001d6c: 5400118b     	b.lt	0x40001f9c <process_kill+0x234>
40001d70: d503201f     	nop
40001d74: 1006a709     	adr	x9, 0x4000f254 <proc_table>
40001d78: b9400128     	ldr	w8, [x9]
40001d7c: 6b00011f     	cmp	w8, w0
40001d80: 54000081     	b.ne	0x40001d90 <process_kill+0x28>
40001d84: b9402528     	ldr	w8, [x9, #0x24]
40001d88: 71000d1f     	cmp	w8, #0x3
40001d8c: 54000f41     	b.ne	0x40001f74 <process_kill+0x20c>
40001d90: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001d94: 910a1129     	add	x9, x9, #0x284
40001d98: b9400128     	ldr	w8, [x9]
40001d9c: 6b00011f     	cmp	w8, w0
40001da0: 54000081     	b.ne	0x40001db0 <process_kill+0x48>
40001da4: b9402528     	ldr	w8, [x9, #0x24]
40001da8: 71000d1f     	cmp	w8, #0x3
40001dac: 54000e41     	b.ne	0x40001f74 <process_kill+0x20c>
40001db0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001db4: 910ad129     	add	x9, x9, #0x2b4
40001db8: b9400128     	ldr	w8, [x9]
40001dbc: 6b00011f     	cmp	w8, w0
40001dc0: 54000081     	b.ne	0x40001dd0 <process_kill+0x68>
40001dc4: b9402528     	ldr	w8, [x9, #0x24]
40001dc8: 71000d1f     	cmp	w8, #0x3
40001dcc: 54000d41     	b.ne	0x40001f74 <process_kill+0x20c>
40001dd0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001dd4: 910b9129     	add	x9, x9, #0x2e4
40001dd8: b9400128     	ldr	w8, [x9]
40001ddc: 6b00011f     	cmp	w8, w0
40001de0: 54000081     	b.ne	0x40001df0 <process_kill+0x88>
40001de4: b9402528     	ldr	w8, [x9, #0x24]
40001de8: 71000d1f     	cmp	w8, #0x3
40001dec: 54000c41     	b.ne	0x40001f74 <process_kill+0x20c>
40001df0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001df4: 910c5129     	add	x9, x9, #0x314
40001df8: b9400128     	ldr	w8, [x9]
40001dfc: 6b00011f     	cmp	w8, w0
40001e00: 54000081     	b.ne	0x40001e10 <process_kill+0xa8>
40001e04: b9402528     	ldr	w8, [x9, #0x24]
40001e08: 71000d1f     	cmp	w8, #0x3
40001e0c: 54000b41     	b.ne	0x40001f74 <process_kill+0x20c>
40001e10: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001e14: 910d1129     	add	x9, x9, #0x344
40001e18: b9400128     	ldr	w8, [x9]
40001e1c: 6b00011f     	cmp	w8, w0
40001e20: 54000081     	b.ne	0x40001e30 <process_kill+0xc8>
40001e24: b9402528     	ldr	w8, [x9, #0x24]
40001e28: 71000d1f     	cmp	w8, #0x3
40001e2c: 54000a41     	b.ne	0x40001f74 <process_kill+0x20c>
40001e30: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001e34: 910dd129     	add	x9, x9, #0x374
40001e38: b9400128     	ldr	w8, [x9]
40001e3c: 6b00011f     	cmp	w8, w0
40001e40: 54000081     	b.ne	0x40001e50 <process_kill+0xe8>
40001e44: b9402528     	ldr	w8, [x9, #0x24]
40001e48: 71000d1f     	cmp	w8, #0x3
40001e4c: 54000941     	b.ne	0x40001f74 <process_kill+0x20c>
40001e50: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001e54: 910e9129     	add	x9, x9, #0x3a4
40001e58: b9400128     	ldr	w8, [x9]
40001e5c: 6b00011f     	cmp	w8, w0
40001e60: 54000081     	b.ne	0x40001e70 <process_kill+0x108>
40001e64: b9402528     	ldr	w8, [x9, #0x24]
40001e68: 71000d1f     	cmp	w8, #0x3
40001e6c: 54000841     	b.ne	0x40001f74 <process_kill+0x20c>
40001e70: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001e74: 910f5129     	add	x9, x9, #0x3d4
40001e78: b9400128     	ldr	w8, [x9]
40001e7c: 6b00011f     	cmp	w8, w0
40001e80: 54000081     	b.ne	0x40001e90 <process_kill+0x128>
40001e84: b9402528     	ldr	w8, [x9, #0x24]
40001e88: 71000d1f     	cmp	w8, #0x3
40001e8c: 54000741     	b.ne	0x40001f74 <process_kill+0x20c>
40001e90: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001e94: 91101129     	add	x9, x9, #0x404
40001e98: b9400128     	ldr	w8, [x9]
40001e9c: 6b00011f     	cmp	w8, w0
40001ea0: 54000081     	b.ne	0x40001eb0 <process_kill+0x148>
40001ea4: b9402528     	ldr	w8, [x9, #0x24]
40001ea8: 71000d1f     	cmp	w8, #0x3
40001eac: 54000641     	b.ne	0x40001f74 <process_kill+0x20c>
40001eb0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001eb4: 9110d129     	add	x9, x9, #0x434
40001eb8: b9400128     	ldr	w8, [x9]
40001ebc: 6b00011f     	cmp	w8, w0
40001ec0: 54000081     	b.ne	0x40001ed0 <process_kill+0x168>
40001ec4: b9402528     	ldr	w8, [x9, #0x24]
40001ec8: 71000d1f     	cmp	w8, #0x3
40001ecc: 54000541     	b.ne	0x40001f74 <process_kill+0x20c>
40001ed0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001ed4: 91119129     	add	x9, x9, #0x464
40001ed8: b9400128     	ldr	w8, [x9]
40001edc: 6b00011f     	cmp	w8, w0
40001ee0: 54000081     	b.ne	0x40001ef0 <process_kill+0x188>
40001ee4: b9402528     	ldr	w8, [x9, #0x24]
40001ee8: 71000d1f     	cmp	w8, #0x3
40001eec: 54000441     	b.ne	0x40001f74 <process_kill+0x20c>
40001ef0: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001ef4: 91125129     	add	x9, x9, #0x494
40001ef8: b9400128     	ldr	w8, [x9]
40001efc: 6b00011f     	cmp	w8, w0
40001f00: 54000081     	b.ne	0x40001f10 <process_kill+0x1a8>
40001f04: b9402528     	ldr	w8, [x9, #0x24]
40001f08: 71000d1f     	cmp	w8, #0x3
40001f0c: 54000341     	b.ne	0x40001f74 <process_kill+0x20c>
40001f10: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001f14: 91131129     	add	x9, x9, #0x4c4
40001f18: b9400128     	ldr	w8, [x9]
40001f1c: 6b00011f     	cmp	w8, w0
40001f20: 54000081     	b.ne	0x40001f30 <process_kill+0x1c8>
40001f24: b9402528     	ldr	w8, [x9, #0x24]
40001f28: 71000d1f     	cmp	w8, #0x3
40001f2c: 54000241     	b.ne	0x40001f74 <process_kill+0x20c>
40001f30: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001f34: 9113d129     	add	x9, x9, #0x4f4
40001f38: b9400128     	ldr	w8, [x9]
40001f3c: 6b00011f     	cmp	w8, w0
40001f40: 54000081     	b.ne	0x40001f50 <process_kill+0x1e8>
40001f44: b9402528     	ldr	w8, [x9, #0x24]
40001f48: 71000d1f     	cmp	w8, #0x3
40001f4c: 54000141     	b.ne	0x40001f74 <process_kill+0x20c>
40001f50: d0000069     	adrp	x9, 0x4000f000 <__bss_start+0x3000>
40001f54: 91149129     	add	x9, x9, #0x524
40001f58: b9400128     	ldr	w8, [x9]
40001f5c: 6b00011f     	cmp	w8, w0
40001f60: 12800008     	mov	w8, #-0x1               // =-1
40001f64: 54000281     	b.ne	0x40001fb4 <process_kill+0x24c>
40001f68: b940252a     	ldr	w10, [x9, #0x24]
40001f6c: 71000d5f     	cmp	w10, #0x3
40001f70: 54000220     	b.eq	0x40001fb4 <process_kill+0x24c>
40001f74: 7100041f     	cmp	w0, #0x1
40001f78: 54000161     	b.ne	0x40001fa4 <process_kill+0x23c>
40001f7c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f80: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001f84: 91290000     	add	x0, x0, #0xa40
40001f88: 910003fd     	mov	x29, sp
40001f8c: 940005d6     	bl	0x400036e4 <uart_puts>
40001f90: 12800020     	mov	w0, #-0x2               // =-2
40001f94: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001f98: d65f03c0     	ret
40001f9c: 12800000     	mov	w0, #-0x1               // =-1
40001fa0: d65f03c0     	ret
40001fa4: 5280004a     	mov	w10, #0x2               // =2
40001fa8: 2a1f03e0     	mov	w0, wzr
40001fac: b900252a     	str	w10, [x9, #0x24]
40001fb0: d65f03c0     	ret
40001fb4: 2a0803e0     	mov	w0, w8
40001fb8: d65f03c0     	ret

0000000040001fbc <launch_ktop>:
40001fbc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001fc0: f0000020     	adrp	x0, 0x40008000 <__rodata_start>
40001fc4: 91203400     	add	x0, x0, #0x80d
40001fc8: f9000bf7     	str	x23, [sp, #0x10]
40001fcc: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fd0: 910003fd     	mov	x29, sp
40001fd4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fd8: 940005c3     	bl	0x400036e4 <uart_puts>
40001fdc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40001fe0: 9126dc00     	add	x0, x0, #0x9b7
40001fe4: 940005c0     	bl	0x400036e4 <uart_puts>
40001fe8: 2a1f03e8     	mov	w8, wzr
40001fec: 2a1f03e1     	mov	w1, wzr
40001ff0: 52800209     	mov	w9, #0x10               // =16
40001ff4: d000006a     	adrp	x10, 0x4000f000 <__bss_start+0x3000>
40001ff8: 9109f14a     	add	x10, x10, #0x27c
40001ffc: 14000004     	b	0x4000200c <launch_ktop+0x50>
40002000: f1000529     	subs	x9, x9, #0x1
40002004: 9100c14a     	add	x10, x10, #0x30
40002008: 54000120     	b.eq	0x4000202c <launch_ktop+0x70>
4000200c: b85fc14b     	ldur	w11, [x10, #-0x4]
40002010: 121f796b     	and	w11, w11, #0xfffffffe
40002014: 7100097f     	cmp	w11, #0x2
40002018: 54ffff40     	b.eq	0x40002000 <launch_ktop+0x44>
4000201c: b940014b     	ldr	w11, [x10]
40002020: 11000421     	add	w1, w1, #0x1
40002024: 0b080168     	add	w8, w11, w8
40002028: 17fffff6     	b	0x40002000 <launch_ktop+0x44>
4000202c: 530a7d02     	lsr	w2, w8, #10
40002030: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002034: 912c8c00     	add	x0, x0, #0xb23
40002038: 940006c0     	bl	0x40003b38 <uart_printf>
4000203c: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002040: 91317400     	add	x0, x0, #0xc5d
40002044: 940005a8     	bl	0x400036e4 <uart_puts>
40002048: f0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000204c: 913c9800     	add	x0, x0, #0xf26
40002050: 940005a5     	bl	0x400036e4 <uart_puts>
40002054: b0000074     	adrp	x20, 0x4000f000 <__bss_start+0x3000>
40002058: 910a0294     	add	x20, x20, #0x280
4000205c: 90000055     	adrp	x21, 0x4000a000 <__rodata_start+0x2000>
40002060: 910282b5     	add	x21, x21, #0xa0
40002064: d503201f     	nop
40002068: 10044796     	adr	x22, 0x4000a958 <__rodata_start+0x2958>
4000206c: 52800217     	mov	w23, #0x10              // =16
40002070: f0000033     	adrp	x19, 0x40009000 <__rodata_start+0x1000>
40002074: 91180673     	add	x19, x19, #0x601
40002078: 1400000a     	b	0x400020a0 <launch_ktop+0xe4>
4000207c: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002080: b85d4281     	ldur	w1, [x20, #-0x2c]
40002084: d100a285     	sub	x5, x20, #0x28
40002088: aa1303e0     	mov	x0, x19
4000208c: 530a7d03     	lsr	w3, w8, #10
40002090: 940006aa     	bl	0x40003b38 <uart_printf>
40002094: f10006f7     	subs	x23, x23, #0x1
40002098: 9100c294     	add	x20, x20, #0x30
4000209c: 54000120     	b.eq	0x400020c0 <launch_ktop+0x104>
400020a0: b85f8288     	ldur	w8, [x20, #-0x8]
400020a4: 71000d1f     	cmp	w8, #0x3
400020a8: 54ffff60     	b.eq	0x40002094 <launch_ktop+0xd8>
400020ac: 7100091f     	cmp	w8, #0x2
400020b0: aa1503e2     	mov	x2, x21
400020b4: 54fffe48     	b.hi	0x4000207c <launch_ktop+0xc0>
400020b8: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
400020bc: 17fffff0     	b	0x4000207c <launch_ktop+0xc0>
400020c0: f0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400020c4: 9109bc00     	add	x0, x0, #0x26f
400020c8: 94000587     	bl	0x400036e4 <uart_puts>
400020cc: 52808114     	mov	w20, #0x408             // =1032
400020d0: 52800033     	mov	w19, #0x1               // =1
400020d4: 72a02014     	movk	w20, #0x100, lsl #16
400020d8: 14000003     	b	0x400020e4 <launch_ktop+0x128>
400020dc: 7101c51f     	cmp	w8, #0x71
400020e0: 54000100     	b.eq	0x40002100 <launch_ktop+0x144>
400020e4: 940005b4     	bl	0x400037b4 <uart_getc>
400020e8: 12001c08     	and	w8, w0, #0xff
400020ec: 7100611f     	cmp	w8, #0x18
400020f0: 54ffff68     	b.hi	0x400020dc <launch_ktop+0x120>
400020f4: 1ac82269     	lsl	w9, w19, w8
400020f8: 6a14013f     	tst	w9, w20
400020fc: 54ffff00     	b.eq	0x400020dc <launch_ktop+0x120>
40002100: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002104: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002108: 912d5800     	add	x0, x0, #0xb56
4000210c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002110: f9400bf7     	ldr	x23, [sp, #0x10]
40002114: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002118: 14000573     	b	0x400036e4 <uart_puts>

000000004000211c <script_init>:
4000211c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002120: b0000068     	adrp	x8, 0x4000f000 <__bss_start+0x3000>
40002124: d503201f     	nop
40002128: 70035b80     	adr	x0, 0x40008c9b <__rodata_start+0xc9b>
4000212c: f0000021     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40002130: 912e7c21     	add	x1, x1, #0xb9f
40002134: 910003fd     	mov	x29, sp
40002138: b905551f     	str	wzr, [x8, #0x554]
4000213c: 94000007     	bl	0x40002158 <script_set_var>
40002140: f0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40002144: 91396800     	add	x0, x0, #0xe5a
40002148: f0000021     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
4000214c: 911f1421     	add	x1, x1, #0x7c5
40002150: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002154: 14000001     	b	0x40002158 <script_set_var>

0000000040002158 <script_set_var>:
40002158: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000215c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002160: b0000077     	adrp	x23, 0x4000f000 <__bss_start+0x3000>
40002164: 910003fd     	mov	x29, sp
40002168: b94556e8     	ldr	w8, [x23, #0x554]
4000216c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002170: aa0103f3     	mov	x19, x1
40002174: aa0003f4     	mov	x20, x0
40002178: a90257f6     	stp	x22, x21, [sp, #0x20]
4000217c: 7100051f     	cmp	w8, #0x1
40002180: 5400024b     	b.lt	0x400021c8 <script_set_var+0x70>
40002184: aa1f03f8     	mov	x24, xzr
40002188: b0000075     	adrp	x21, 0x4000f000 <__bss_start+0x3000>
4000218c: 912562b5     	add	x21, x21, #0x958
40002190: b0000076     	adrp	x22, 0x4000f000 <__bss_start+0x3000>
40002194: 911562d6     	add	x22, x22, #0x558
40002198: aa1603e0     	mov	x0, x22
4000219c: aa1403e1     	mov	x1, x20
400021a0: 940001b6     	bl	0x40002878 <kstrcmp>
400021a4: 340003e0     	cbz	w0, 0x40002220 <script_set_var+0xc8>
400021a8: b98556e8     	ldrsw	x8, [x23, #0x554]
400021ac: 91000718     	add	x24, x24, #0x1
400021b0: 910202b5     	add	x21, x21, #0x80
400021b4: 910082d6     	add	x22, x22, #0x20
400021b8: eb08031f     	cmp	x24, x8
400021bc: 54fffeeb     	b.lt	0x40002198 <script_set_var+0x40>
400021c0: 71007d1f     	cmp	w8, #0x1f
400021c4: 5400038c     	b.gt	0x40002234 <script_set_var+0xdc>
400021c8: b0000075     	adrp	x21, 0x4000f000 <__bss_start+0x3000>
400021cc: 911562b5     	add	x21, x21, #0x558
400021d0: aa1403e1     	mov	x1, x20
400021d4: 93407d08     	sxtw	x8, w8
400021d8: 528003e2     	mov	w2, #0x1f               // =31
400021dc: 8b0816a0     	add	x0, x21, x8, lsl #5
400021e0: 940001cc     	bl	0x40002910 <kstrncpy>
400021e4: b98556e8     	ldrsw	x8, [x23, #0x554]
400021e8: b0000074     	adrp	x20, 0x4000f000 <__bss_start+0x3000>
400021ec: 91256294     	add	x20, x20, #0x958
400021f0: aa1303e1     	mov	x1, x19
400021f4: 52800fe2     	mov	w2, #0x7f               // =127
400021f8: 8b0816a9     	add	x9, x21, x8, lsl #5
400021fc: 8b081e80     	add	x0, x20, x8, lsl #7
40002200: 39007d3f     	strb	wzr, [x9, #0x1f]
40002204: 940001c3     	bl	0x40002910 <kstrncpy>
40002208: b98556e8     	ldrsw	x8, [x23, #0x554]
4000220c: 8b081e89     	add	x9, x20, x8, lsl #7
40002210: 11000508     	add	w8, w8, #0x1
40002214: b90556e8     	str	w8, [x23, #0x554]
40002218: 3901fd3f     	strb	wzr, [x9, #0x7f]
4000221c: 14000006     	b	0x40002234 <script_set_var+0xdc>
40002220: aa1503e0     	mov	x0, x21
40002224: aa1303e1     	mov	x1, x19
40002228: 52800fe2     	mov	w2, #0x7f               // =127
4000222c: 940001b9     	bl	0x40002910 <kstrncpy>
40002230: 3901febf     	strb	wzr, [x21, #0x7f]
40002234: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002238: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000223c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002240: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002244: d65f03c0     	ret

0000000040002248 <script_get_var>:
40002248: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000224c: a90257f6     	stp	x22, x21, [sp, #0x20]
40002250: b0000076     	adrp	x22, 0x4000f000 <__bss_start+0x3000>
40002254: 910003fd     	mov	x29, sp
40002258: b94556c8     	ldr	w8, [x22, #0x554]
4000225c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002260: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002264: 7100051f     	cmp	w8, #0x1
40002268: 540002ab     	b.lt	0x400022bc <script_get_var+0x74>
4000226c: aa0003f4     	mov	x20, x0
40002270: aa1f03f7     	mov	x23, xzr
40002274: b0000073     	adrp	x19, 0x4000f000 <__bss_start+0x3000>
40002278: 91256273     	add	x19, x19, #0x958
4000227c: b0000075     	adrp	x21, 0x4000f000 <__bss_start+0x3000>
40002280: 911562b5     	add	x21, x21, #0x558
40002284: d0000038     	adrp	x24, 0x40008000 <__rodata_start>
40002288: 91250718     	add	x24, x24, #0x941
4000228c: aa1503e0     	mov	x0, x21
40002290: aa1403e1     	mov	x1, x20
40002294: 94000179     	bl	0x40002878 <kstrcmp>
40002298: 34000160     	cbz	w0, 0x400022c4 <script_get_var+0x7c>
4000229c: b98556c8     	ldrsw	x8, [x22, #0x554]
400022a0: 910006f7     	add	x23, x23, #0x1
400022a4: 91020273     	add	x19, x19, #0x80
400022a8: 910082b5     	add	x21, x21, #0x20
400022ac: eb0802ff     	cmp	x23, x8
400022b0: 54fffeeb     	b.lt	0x4000228c <script_get_var+0x44>
400022b4: aa1803f3     	mov	x19, x24
400022b8: 14000003     	b	0x400022c4 <script_get_var+0x7c>
400022bc: d0000033     	adrp	x19, 0x40008000 <__rodata_start>
400022c0: 91250673     	add	x19, x19, #0x941
400022c4: aa1303e0     	mov	x0, x19
400022c8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400022cc: a94257f6     	ldp	x22, x21, [sp, #0x20]
400022d0: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400022d4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400022d8: d65f03c0     	ret

00000000400022dc <script_expand_vars>:
400022dc: d10203ff     	sub	sp, sp, #0x80
400022e0: a9036ffc     	stp	x28, x27, [sp, #0x30]
400022e4: 2a1f03fc     	mov	w28, wzr
400022e8: a90467fa     	stp	x26, x25, [sp, #0x40]
400022ec: d0000039     	adrp	x25, 0x40008000 <__rodata_start>
400022f0: 91250739     	add	x25, x25, #0x941
400022f4: a9055ff8     	stp	x24, x23, [sp, #0x50]
400022f8: 910003f8     	mov	x24, sp
400022fc: b000007a     	adrp	x26, 0x4000f000 <__bss_start+0x3000>
40002300: a90657f6     	stp	x22, x21, [sp, #0x60]
40002304: 2a1f03f6     	mov	w22, wzr
40002308: a9074ff4     	stp	x20, x19, [sp, #0x70]
4000230c: aa0103f3     	mov	x19, x1
40002310: aa0003f4     	mov	x20, x0
40002314: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002318: 910083fd     	add	x29, sp, #0x20
4000231c: 14000001     	b	0x40002320 <script_expand_vars+0x44>
40002320: 93407f89     	sxtw	x9, w28
40002324: 38696a88     	ldrb	w8, [x20, x9]
40002328: 7100911f     	cmp	w8, #0x24
4000232c: 540000e0     	b.eq	0x40002348 <script_expand_vars+0x6c>
40002330: 34000788     	cbz	w8, 0x40002420 <script_expand_vars+0x144>
40002334: 110006ca     	add	w10, w22, #0x1
40002338: 3836ca68     	strb	w8, [x19, w22, sxtw]
4000233c: 1100053c     	add	w28, w9, #0x1
40002340: 2a0a03f6     	mov	w22, w10
40002344: 17fffff7     	b	0x40002320 <script_expand_vars+0x44>
40002348: aa1f03e8     	mov	x8, xzr
4000234c: 14000005     	b	0x40002360 <script_expand_vars+0x84>
40002350: 9100050a     	add	x10, x8, #0x1
40002354: 38286b09     	strb	w9, [x24, x8]
40002358: d1000789     	sub	x9, x28, #0x1
4000235c: aa0a03e8     	mov	x8, x10
40002360: 9100053c     	add	x28, x9, #0x1
40002364: 14000004     	b	0x40002374 <script_expand_vars+0x98>
40002368: f100791f     	cmp	x8, #0x1e
4000236c: 9100079c     	add	x28, x28, #0x1
40002370: 54ffff09     	b.ls	0x40002350 <script_expand_vars+0x74>
40002374: 387c6a89     	ldrb	w9, [x20, x28]
40002378: 121a792a     	and	w10, w9, #0xffffffdf
4000237c: 5101054a     	sub	w10, w10, #0x41
40002380: 7100695f     	cmp	w10, #0x1a
40002384: 54ffff23     	b.lo	0x40002368 <script_expand_vars+0x8c>
40002388: 71017d3f     	cmp	w9, #0x5f
4000238c: 54fffee0     	b.eq	0x40002368 <script_expand_vars+0x8c>
40002390: 5100c12a     	sub	w10, w9, #0x30
40002394: 7100255f     	cmp	w10, #0x9
40002398: 54fffe89     	b.ls	0x40002368 <script_expand_vars+0x8c>
4000239c: b9455749     	ldr	w9, [x26, #0x554]
400023a0: 38286b1f     	strb	wzr, [x24, x8]
400023a4: 7100053f     	cmp	w9, #0x1
400023a8: 5400028b     	b.lt	0x400023f8 <script_expand_vars+0x11c>
400023ac: aa1f03fb     	mov	x27, xzr
400023b0: b0000075     	adrp	x21, 0x4000f000 <__bss_start+0x3000>
400023b4: 911562b5     	add	x21, x21, #0x558
400023b8: b0000077     	adrp	x23, 0x4000f000 <__bss_start+0x3000>
400023bc: 912562f7     	add	x23, x23, #0x958
400023c0: 910003e1     	mov	x1, sp
400023c4: aa1503e0     	mov	x0, x21
400023c8: 9400012c     	bl	0x40002878 <kstrcmp>
400023cc: 34000100     	cbz	w0, 0x400023ec <script_expand_vars+0x110>
400023d0: b9855748     	ldrsw	x8, [x26, #0x554]
400023d4: 9100077b     	add	x27, x27, #0x1
400023d8: 910202f7     	add	x23, x23, #0x80
400023dc: 910082b5     	add	x21, x21, #0x20
400023e0: eb08037f     	cmp	x27, x8
400023e4: 54fffeeb     	b.lt	0x400023c0 <script_expand_vars+0xe4>
400023e8: aa1903f7     	mov	x23, x25
400023ec: 394002e8     	ldrb	w8, [x23]
400023f0: 350000a8     	cbnz	w8, 0x40002404 <script_expand_vars+0x128>
400023f4: 17ffffcb     	b	0x40002320 <script_expand_vars+0x44>
400023f8: aa1903f7     	mov	x23, x25
400023fc: 394002e8     	ldrb	w8, [x23]
40002400: 34fff908     	cbz	w8, 0x40002320 <script_expand_vars+0x44>
40002404: 8b36c269     	add	x9, x19, w22, sxtw
40002408: 910006ea     	add	x10, x23, #0x1
4000240c: 38001528     	strb	w8, [x9], #0x1
40002410: 110006d6     	add	w22, w22, #0x1
40002414: 38401548     	ldrb	w8, [x10], #0x1
40002418: 35ffffa8     	cbnz	w8, 0x4000240c <script_expand_vars+0x130>
4000241c: 17ffffc1     	b	0x40002320 <script_expand_vars+0x44>
40002420: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
40002424: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002428: a94657f6     	ldp	x22, x21, [sp, #0x60]
4000242c: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002430: a94467fa     	ldp	x26, x25, [sp, #0x40]
40002434: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002438: a9427bfd     	ldp	x29, x30, [sp, #0x20]
4000243c: 910203ff     	add	sp, sp, #0x80
40002440: d65f03c0     	ret

0000000040002444 <script_execute_line>:
40002444: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002448: a9014ffc     	stp	x28, x19, [sp, #0x10]
4000244c: 910003fd     	mov	x29, sp
40002450: d10803ff     	sub	sp, sp, #0x200
40002454: 14000004     	b	0x40002464 <script_execute_line+0x20>
40002458: 7100811f     	cmp	w8, #0x20
4000245c: 54000121     	b.ne	0x40002480 <script_execute_line+0x3c>
40002460: 91000400     	add	x0, x0, #0x1
40002464: 39400008     	ldrb	w8, [x0]
40002468: 71007d1f     	cmp	w8, #0x1f
4000246c: 54ffff6c     	b.gt	0x40002458 <script_execute_line+0x14>
40002470: 7100251f     	cmp	w8, #0x9
40002474: 54ffff60     	b.eq	0x40002460 <script_execute_line+0x1c>
40002478: 34001668     	cbz	w8, 0x40002744 <script_execute_line+0x300>
4000247c: 14000003     	b	0x40002488 <script_execute_line+0x44>
40002480: 71008d1f     	cmp	w8, #0x23
40002484: 54001600     	b.eq	0x40002744 <script_execute_line+0x300>
40002488: 910403e1     	add	x1, sp, #0x100
4000248c: 910403f3     	add	x19, sp, #0x100
40002490: 97ffff93     	bl	0x400022dc <script_expand_vars>
40002494: 394403e9     	ldrb	w9, [sp, #0x100]
40002498: 34001529     	cbz	w9, 0x4000273c <script_execute_line+0x2f8>
4000249c: 394407e8     	ldrb	w8, [sp, #0x101]
400024a0: aa1f03ea     	mov	x10, xzr
400024a4: 2a0903eb     	mov	w11, w9
400024a8: 14000004     	b	0x400024b8 <script_execute_line+0x74>
400024ac: 9100054a     	add	x10, x10, #0x1
400024b0: 386a6a6b     	ldrb	w11, [x19, x10]
400024b4: 340003cb     	cbz	w11, 0x4000252c <script_execute_line+0xe8>
400024b8: b4ffffaa     	cbz	x10, 0x400024ac <script_execute_line+0x68>
400024bc: 7100f57f     	cmp	w11, #0x3d
400024c0: 54ffff61     	b.ne	0x400024ac <script_execute_line+0x68>
400024c4: 8b13014b     	add	x11, x10, x19
400024c8: 385ff16c     	ldurb	w12, [x11, #-0x1]
400024cc: 7100f59f     	cmp	w12, #0x3d
400024d0: 54fffee0     	b.eq	0x400024ac <script_execute_line+0x68>
400024d4: 3940056b     	ldrb	w11, [x11, #0x1]
400024d8: 7100f57f     	cmp	w11, #0x3d
400024dc: 54fffe80     	b.eq	0x400024ac <script_execute_line+0x68>
400024e0: aa1f03ec     	mov	x12, xzr
400024e4: 2a1f03eb     	mov	w11, wzr
400024e8: 386c6a6d     	ldrb	w13, [x19, x12]
400024ec: 9100058c     	add	x12, x12, #0x1
400024f0: 710081bf     	cmp	w13, #0x20
400024f4: 1a9f156b     	csinc	w11, w11, wzr, ne
400024f8: eb0c015f     	cmp	x10, x12
400024fc: 54ffff61     	b.ne	0x400024e8 <script_execute_line+0xa4>
40002500: 35fffd6b     	cbnz	w11, 0x400024ac <script_execute_line+0x68>
40002504: 7101a53f     	cmp	w9, #0x69
40002508: 54fffd20     	b.eq	0x400024ac <script_execute_line+0x68>
4000250c: 7101991f     	cmp	w8, #0x66
40002510: 54fffce0     	b.eq	0x400024ac <script_execute_line+0x68>
40002514: 910403e8     	add	x8, sp, #0x100
40002518: 910403e0     	add	x0, sp, #0x100
4000251c: 8b0a0101     	add	x1, x8, x10
40002520: 3800143f     	strb	wzr, [x1], #0x1
40002524: 97ffff0d     	bl	0x40002158 <script_set_var>
40002528: 14000087     	b	0x40002744 <script_execute_line+0x300>
4000252c: 394403e9     	ldrb	w9, [sp, #0x100]
40002530: 7101a53f     	cmp	w9, #0x69
40002534: 54001041     	b.ne	0x4000273c <script_execute_line+0x2f8>
40002538: 7101991f     	cmp	w8, #0x66
4000253c: 54001001     	b.ne	0x4000273c <script_execute_line+0x2f8>
40002540: 39440be8     	ldrb	w8, [sp, #0x102]
40002544: 7100811f     	cmp	w8, #0x20
40002548: 54000fa1     	b.ne	0x4000273c <script_execute_line+0x2f8>
4000254c: 39440fe9     	ldrb	w9, [sp, #0x103]
40002550: 7100813f     	cmp	w9, #0x20
40002554: 54000081     	b.ne	0x40002564 <script_execute_line+0x120>
40002558: aa1f03e9     	mov	x9, xzr
4000255c: 52800068     	mov	w8, #0x3                // =3
40002560: 14000014     	b	0x400025b0 <script_execute_line+0x16c>
40002564: 910403ea     	add	x10, sp, #0x100
40002568: aa1f03e8     	mov	x8, xzr
4000256c: 910303eb     	add	x11, sp, #0xc0
40002570: 9100114a     	add	x10, x10, #0x4
40002574: 34000189     	cbz	w9, 0x400025a4 <script_execute_line+0x160>
40002578: f100f91f     	cmp	x8, #0x3e
4000257c: 54000148     	b.hi	0x400025a4 <script_execute_line+0x160>
40002580: 38286969     	strb	w9, [x11, x8]
40002584: 38686949     	ldrb	w9, [x10, x8]
40002588: 9100050c     	add	x12, x8, #0x1
4000258c: aa0c03e8     	mov	x8, x12
40002590: 7100813f     	cmp	w9, #0x20
40002594: 54ffff01     	b.ne	0x40002574 <script_execute_line+0x130>
40002598: 11000d8a     	add	w10, w12, #0x3
4000259c: 2a0c03e8     	mov	w8, w12
400025a0: 14000002     	b	0x400025a8 <script_execute_line+0x164>
400025a4: 11000d0a     	add	w10, w8, #0x3
400025a8: 2a0803e9     	mov	w9, w8
400025ac: 2a0a03e8     	mov	w8, w10
400025b0: 910303ea     	add	x10, sp, #0xc0
400025b4: 3829695f     	strb	wzr, [x10, x9]
400025b8: 910403e9     	add	x9, sp, #0x100
400025bc: 3868692a     	ldrb	w10, [x9, x8]
400025c0: 7100815f     	cmp	w10, #0x20
400025c4: 54000061     	b.ne	0x400025d0 <script_execute_line+0x18c>
400025c8: 91000508     	add	x8, x8, #0x1
400025cc: 17fffffc     	b	0x400025bc <script_execute_line+0x178>
400025d0: 7100855f     	cmp	w10, #0x21
400025d4: 54000060     	b.eq	0x400025e0 <script_execute_line+0x19c>
400025d8: 7100f55f     	cmp	w10, #0x3d
400025dc: 540000e1     	b.ne	0x400025f8 <script_execute_line+0x1b4>
400025e0: 11000509     	add	w9, w8, #0x1
400025e4: 910403ea     	add	x10, sp, #0x100
400025e8: 38694949     	ldrb	w9, [x10, w9, uxtw]
400025ec: 9100090a     	add	x10, x8, #0x2
400025f0: 7100f53f     	cmp	w9, #0x3d
400025f4: 9a880148     	csel	x8, x10, x8, eq
400025f8: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
400025fc: 910403ea     	add	x10, sp, #0x100
40002600: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002604: 8b088129     	add	x9, x9, x8, lsl #32
40002608: 8b28c14a     	add	x10, x10, w8, sxtw
4000260c: 51000508     	sub	w8, w8, #0x1
40002610: 3840154c     	ldrb	w12, [x10], #0x1
40002614: 8b0b0129     	add	x9, x9, x11
40002618: 11000508     	add	w8, w8, #0x1
4000261c: 7100819f     	cmp	w12, #0x20
40002620: 54ffff80     	b.eq	0x40002610 <script_execute_line+0x1cc>
40002624: 9360fd2c     	asr	x12, x9, #32
40002628: 910403e9     	add	x9, sp, #0x100
4000262c: 386c692d     	ldrb	w13, [x9, x12]
40002630: 710081bf     	cmp	w13, #0x20
40002634: 54000061     	b.ne	0x40002640 <script_execute_line+0x1fc>
40002638: aa1f03ea     	mov	x10, xzr
4000263c: 14000010     	b	0x4000267c <script_execute_line+0x238>
40002640: aa1f03eb     	mov	x11, xzr
40002644: 910203ec     	add	x12, sp, #0x80
40002648: 3400016d     	cbz	w13, 0x40002674 <script_execute_line+0x230>
4000264c: f100f97f     	cmp	x11, #0x3e
40002650: 54000128     	b.hi	0x40002674 <script_execute_line+0x230>
40002654: 382b698d     	strb	w13, [x12, x11]
40002658: 386b694d     	ldrb	w13, [x10, x11]
4000265c: 9100056e     	add	x14, x11, #0x1
40002660: 11000508     	add	w8, w8, #0x1
40002664: aa0e03eb     	mov	x11, x14
40002668: 710081bf     	cmp	w13, #0x20
4000266c: 54fffee1     	b.ne	0x40002648 <script_execute_line+0x204>
40002670: 2a0e03eb     	mov	w11, w14
40002674: 93407d0c     	sxtw	x12, w8
40002678: 2a0b03ea     	mov	w10, w11
4000267c: d3607d8d     	lsl	x13, x12, #32
40002680: 910203eb     	add	x11, sp, #0x80
40002684: d2c0006f     	mov	x15, #0x300000000       // =12884901888
40002688: d2c00050     	mov	x16, #0x200000000       // =8589934592
4000268c: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002690: 11001108     	add	w8, w8, #0x4
40002694: 382a697f     	strb	wzr, [x11, x10]
40002698: 8b0f01aa     	add	x10, x13, x15
4000269c: 8b1001ab     	add	x11, x13, x16
400026a0: 8b0e01ad     	add	x13, x13, x14
400026a4: 8b0c0129     	add	x9, x9, x12
400026a8: 3840152c     	ldrb	w12, [x9], #0x1
400026ac: 7100819f     	cmp	w12, #0x20
400026b0: 540000c1     	b.ne	0x400026c8 <script_execute_line+0x284>
400026b4: 11000508     	add	w8, w8, #0x1
400026b8: 8b0e014a     	add	x10, x10, x14
400026bc: 8b0e016b     	add	x11, x11, x14
400026c0: 8b0e01ad     	add	x13, x13, x14
400026c4: 17fffff9     	b	0x400026a8 <script_execute_line+0x264>
400026c8: 7101d19f     	cmp	w12, #0x74
400026cc: 54000381     	b.ne	0x4000273c <script_execute_line+0x2f8>
400026d0: 9360fdac     	asr	x12, x13, #32
400026d4: 910403e9     	add	x9, sp, #0x100
400026d8: 386c692c     	ldrb	w12, [x9, x12]
400026dc: 7101a19f     	cmp	w12, #0x68
400026e0: 540002e1     	b.ne	0x4000273c <script_execute_line+0x2f8>
400026e4: 9360fd6b     	asr	x11, x11, #32
400026e8: 386b6929     	ldrb	w9, [x9, x11]
400026ec: 7101953f     	cmp	w9, #0x65
400026f0: 54000261     	b.ne	0x4000273c <script_execute_line+0x2f8>
400026f4: 9360fd4a     	asr	x10, x10, #32
400026f8: 910403e9     	add	x9, sp, #0x100
400026fc: 386a692a     	ldrb	w10, [x9, x10]
40002700: 7101b95f     	cmp	w10, #0x6e
40002704: 540001c1     	b.ne	0x4000273c <script_execute_line+0x2f8>
40002708: 8b28c128     	add	x8, x9, w8, sxtw
4000270c: d1000501     	sub	x1, x8, #0x1
40002710: 38401c28     	ldrb	w8, [x1, #0x1]!
40002714: 7100811f     	cmp	w8, #0x20
40002718: 54ffffc0     	b.eq	0x40002710 <script_execute_line+0x2cc>
4000271c: 910003e0     	mov	x0, sp
40002720: 94000075     	bl	0x400028f4 <kstrcpy>
40002724: 910303e0     	add	x0, sp, #0xc0
40002728: 910203e1     	add	x1, sp, #0x80
4000272c: 94000053     	bl	0x40002878 <kstrcmp>
40002730: 350000a0     	cbnz	w0, 0x40002744 <script_execute_line+0x300>
40002734: 910003e0     	mov	x0, sp
40002738: 14000002     	b	0x40002740 <script_execute_line+0x2fc>
4000273c: 910403e0     	add	x0, sp, #0x100
40002740: 97fff9bf     	bl	0x40000e3c <execute_command>
40002744: 2a1f03e0     	mov	w0, wzr
40002748: 910803ff     	add	sp, sp, #0x200
4000274c: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002750: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002754: d65f03c0     	ret

0000000040002758 <script_run_file>:
40002758: d10503ff     	sub	sp, sp, #0x140
4000275c: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002760: 910403fd     	add	x29, sp, #0x100
40002764: f9008bfc     	str	x28, [sp, #0x110]
40002768: a91257f6     	stp	x22, x21, [sp, #0x120]
4000276c: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002770: aa0003f4     	mov	x20, x0
40002774: 940008b8     	bl	0x40004a54 <vfs_find>
40002778: b4000080     	cbz	x0, 0x40002788 <script_run_file+0x30>
4000277c: b9402008     	ldr	w8, [x0, #0x20]
40002780: aa0003f3     	mov	x19, x0
40002784: 340000e8     	cbz	w8, 0x400027a0 <script_run_file+0x48>
40002788: f0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000278c: 91060c00     	add	x0, x0, #0x183
40002790: aa1403e1     	mov	x1, x20
40002794: 940004e9     	bl	0x40003b38 <uart_printf>
40002798: 12800000     	mov	w0, #-0x1               // =-1
4000279c: 14000021     	b	0x40002820 <script_run_file+0xc8>
400027a0: f9401668     	ldr	x8, [x19, #0x28]
400027a4: aa1f03f4     	mov	x20, xzr
400027a8: 2a1f03e9     	mov	w9, wzr
400027ac: 9100c275     	add	x21, x19, #0x30
400027b0: 910003f6     	mov	x22, sp
400027b4: 14000008     	b	0x400027d4 <script_run_file+0x7c>
400027b8: 7100053f     	cmp	w9, #0x1
400027bc: 3829cadf     	strb	wzr, [x22, w9, sxtw]
400027c0: 2a1f03e9     	mov	w9, wzr
400027c4: 5400022a     	b.ge	0x40002808 <script_run_file+0xb0>
400027c8: 91000694     	add	x20, x20, #0x1
400027cc: eb08029f     	cmp	x20, x8
400027d0: 54000268     	b.hi	0x4000281c <script_run_file+0xc4>
400027d4: eb08029f     	cmp	x20, x8
400027d8: 54ffff00     	b.eq	0x400027b8 <script_run_file+0x60>
400027dc: 38746aaa     	ldrb	w10, [x21, x20]
400027e0: 7100295f     	cmp	w10, #0xa
400027e4: 54fffea0     	b.eq	0x400027b8 <script_run_file+0x60>
400027e8: 7100355f     	cmp	w10, #0xd
400027ec: 54fffee0     	b.eq	0x400027c8 <script_run_file+0x70>
400027f0: 7103f93f     	cmp	w9, #0xfe
400027f4: 54fffeac     	b.gt	0x400027c8 <script_run_file+0x70>
400027f8: 1100052b     	add	w11, w9, #0x1
400027fc: 3829caca     	strb	w10, [x22, w9, sxtw]
40002800: 2a0b03e9     	mov	w9, w11
40002804: 17fffff1     	b	0x400027c8 <script_run_file+0x70>
40002808: 910003e0     	mov	x0, sp
4000280c: 97ffff0e     	bl	0x40002444 <script_execute_line>
40002810: f9401668     	ldr	x8, [x19, #0x28]
40002814: 2a1f03e9     	mov	w9, wzr
40002818: 17ffffec     	b	0x400027c8 <script_run_file+0x70>
4000281c: 2a1f03e0     	mov	w0, wzr
40002820: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002824: f9408bfc     	ldr	x28, [sp, #0x110]
40002828: a95257f6     	ldp	x22, x21, [sp, #0x120]
4000282c: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002830: 910503ff     	add	sp, sp, #0x140
40002834: d65f03c0     	ret

0000000040002838 <kstrlen>:
40002838: b40000c0     	cbz	x0, 0x40002850 <kstrlen+0x18>
4000283c: aa1f03e8     	mov	x8, xzr
40002840: 38686809     	ldrb	w9, [x0, x8]
40002844: 91000508     	add	x8, x8, #0x1
40002848: 35ffffc9     	cbnz	w9, 0x40002840 <kstrlen+0x8>
4000284c: d1000500     	sub	x0, x8, #0x1
40002850: d65f03c0     	ret

0000000040002854 <kstrcat>:
40002854: b4000100     	cbz	x0, 0x40002874 <kstrcat+0x20>
40002858: b40000e1     	cbz	x1, 0x40002874 <kstrcat+0x20>
4000285c: d1000408     	sub	x8, x0, #0x1
40002860: 38401d09     	ldrb	w9, [x8, #0x1]!
40002864: 35ffffe9     	cbnz	w9, 0x40002860 <kstrcat+0xc>
40002868: 38401429     	ldrb	w9, [x1], #0x1
4000286c: 38001509     	strb	w9, [x8], #0x1
40002870: 35ffffc9     	cbnz	w9, 0x40002868 <kstrcat+0x14>
40002874: d65f03c0     	ret

0000000040002878 <kstrcmp>:
40002878: aa0003e8     	mov	x8, x0
4000287c: 12800000     	mov	w0, #-0x1               // =-1
40002880: b4000188     	cbz	x8, 0x400028b0 <kstrcmp+0x38>
40002884: b4000161     	cbz	x1, 0x400028b0 <kstrcmp+0x38>
40002888: 38401509     	ldrb	w9, [x8], #0x1
4000288c: 340000e9     	cbz	w9, 0x400028a8 <kstrcmp+0x30>
40002890: 3940002a     	ldrb	w10, [x1]
40002894: 6b0a013f     	cmp	w9, w10
40002898: 54000081     	b.ne	0x400028a8 <kstrcmp+0x30>
4000289c: 38401509     	ldrb	w9, [x8], #0x1
400028a0: 91000421     	add	x1, x1, #0x1
400028a4: 35ffff69     	cbnz	w9, 0x40002890 <kstrcmp+0x18>
400028a8: 39400028     	ldrb	w8, [x1]
400028ac: 4b080120     	sub	w0, w9, w8
400028b0: d65f03c0     	ret

00000000400028b4 <kstrncmp>:
400028b4: 12800008     	mov	w8, #-0x1               // =-1
400028b8: b4000160     	cbz	x0, 0x400028e4 <kstrncmp+0x30>
400028bc: b4000141     	cbz	x1, 0x400028e4 <kstrncmp+0x30>
400028c0: b4000102     	cbz	x2, 0x400028e0 <kstrncmp+0x2c>
400028c4: 38401408     	ldrb	w8, [x0], #0x1
400028c8: 38401429     	ldrb	w9, [x1], #0x1
400028cc: 34000108     	cbz	w8, 0x400028ec <kstrncmp+0x38>
400028d0: 6b09011f     	cmp	w8, w9
400028d4: 540000c1     	b.ne	0x400028ec <kstrncmp+0x38>
400028d8: f1000442     	subs	x2, x2, #0x1
400028dc: 54ffff41     	b.ne	0x400028c4 <kstrncmp+0x10>
400028e0: 2a1f03e8     	mov	w8, wzr
400028e4: 2a0803e0     	mov	w0, w8
400028e8: d65f03c0     	ret
400028ec: 4b090100     	sub	w0, w8, w9
400028f0: d65f03c0     	ret

00000000400028f4 <kstrcpy>:
400028f4: b40000c0     	cbz	x0, 0x4000290c <kstrcpy+0x18>
400028f8: b40000a1     	cbz	x1, 0x4000290c <kstrcpy+0x18>
400028fc: aa0003e8     	mov	x8, x0
40002900: 38401429     	ldrb	w9, [x1], #0x1
40002904: 38001509     	strb	w9, [x8], #0x1
40002908: 35ffffc9     	cbnz	w9, 0x40002900 <kstrcpy+0xc>
4000290c: d65f03c0     	ret

0000000040002910 <kstrncpy>:
40002910: b4000480     	cbz	x0, 0x400029a0 <kstrncpy+0x90>
40002914: b4000461     	cbz	x1, 0x400029a0 <kstrncpy+0x90>
40002918: b4000442     	cbz	x2, 0x400029a0 <kstrncpy+0x90>
4000291c: aa1f03e9     	mov	x9, xzr
40002920: aa0203e8     	mov	x8, x2
40002924: 3869682a     	ldrb	w10, [x1, x9]
40002928: 3829680a     	strb	w10, [x0, x9]
4000292c: 340000ca     	cbz	w10, 0x40002944 <kstrncpy+0x34>
40002930: 91000529     	add	x9, x9, #0x1
40002934: d1000508     	sub	x8, x8, #0x1
40002938: eb09005f     	cmp	x2, x9
4000293c: 54ffff41     	b.ne	0x40002924 <kstrncpy+0x14>
40002940: 14000018     	b	0x400029a0 <kstrncpy+0x90>
40002944: cb09004a     	sub	x10, x2, x9
40002948: 8b090009     	add	x9, x0, x9
4000294c: f100095f     	cmp	x10, #0x2
40002950: 54000082     	b.hs	0x40002960 <kstrncpy+0x50>
40002954: 91000528     	add	x8, x9, #0x1
40002958: aa0a03e9     	mov	x9, x10
4000295c: 1400000e     	b	0x40002994 <kstrncpy+0x84>
40002960: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002964: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002968: 9100092c     	add	x12, x9, #0x2
4000296c: 8b090108     	add	x8, x8, x9
40002970: 92400149     	and	x9, x10, #0x1
40002974: aa0b03ed     	mov	x13, x11
40002978: 91000508     	add	x8, x8, #0x1
4000297c: f10009ad     	subs	x13, x13, #0x2
40002980: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002984: 3800259f     	strb	wzr, [x12], #0x2
40002988: 54ffffa1     	b.ne	0x4000297c <kstrncpy+0x6c>
4000298c: eb0b015f     	cmp	x10, x11
40002990: 54000080     	b.eq	0x400029a0 <kstrncpy+0x90>
40002994: f1000529     	subs	x9, x9, #0x1
40002998: 3800151f     	strb	wzr, [x8], #0x1
4000299c: 54ffffc1     	b.ne	0x40002994 <kstrncpy+0x84>
400029a0: d65f03c0     	ret

00000000400029a4 <memset>:
400029a4: b40002a0     	cbz	x0, 0x400029f8 <memset+0x54>
400029a8: b4000282     	cbz	x2, 0x400029f8 <memset+0x54>
400029ac: f100085f     	cmp	x2, #0x2
400029b0: 54000082     	b.hs	0x400029c0 <memset+0x1c>
400029b4: aa0003e8     	mov	x8, x0
400029b8: aa0203e9     	mov	x9, x2
400029bc: 1400000c     	b	0x400029ec <memset+0x48>
400029c0: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
400029c4: 92400049     	and	x9, x2, #0x1
400029c8: 9100040b     	add	x11, x0, #0x1
400029cc: 8b0a0008     	add	x8, x0, x10
400029d0: aa0a03ec     	mov	x12, x10
400029d4: f100098c     	subs	x12, x12, #0x2
400029d8: 381ff161     	sturb	w1, [x11, #-0x1]
400029dc: 38002561     	strb	w1, [x11], #0x2
400029e0: 54ffffa1     	b.ne	0x400029d4 <memset+0x30>
400029e4: eb0a005f     	cmp	x2, x10
400029e8: 54000080     	b.eq	0x400029f8 <memset+0x54>
400029ec: f1000529     	subs	x9, x9, #0x1
400029f0: 38001501     	strb	w1, [x8], #0x1
400029f4: 54ffffc1     	b.ne	0x400029ec <memset+0x48>
400029f8: d65f03c0     	ret

00000000400029fc <memcpy>:
400029fc: b4000100     	cbz	x0, 0x40002a1c <memcpy+0x20>
40002a00: b40000e1     	cbz	x1, 0x40002a1c <memcpy+0x20>
40002a04: b40000c2     	cbz	x2, 0x40002a1c <memcpy+0x20>
40002a08: aa0003e8     	mov	x8, x0
40002a0c: 38401429     	ldrb	w9, [x1], #0x1
40002a10: f1000442     	subs	x2, x2, #0x1
40002a14: 38001509     	strb	w9, [x8], #0x1
40002a18: 54ffffa1     	b.ne	0x40002a0c <memcpy+0x10>
40002a1c: d65f03c0     	ret

0000000040002a20 <kstrstr>:
40002a20: aa1f03e2     	mov	x2, xzr
40002a24: b40000e0     	cbz	x0, 0x40002a40 <kstrstr+0x20>
40002a28: b40000c1     	cbz	x1, 0x40002a40 <kstrstr+0x20>
40002a2c: 39400028     	ldrb	w8, [x1]
40002a30: 340002c8     	cbz	w8, 0x40002a88 <kstrstr+0x68>
40002a34: 39400009     	ldrb	w9, [x0]
40002a38: 35000109     	cbnz	w9, 0x40002a58 <kstrstr+0x38>
40002a3c: aa1f03e2     	mov	x2, xzr
40002a40: aa0203e0     	mov	x0, x2
40002a44: d65f03c0     	ret
40002a48: 3940012c     	ldrb	w12, [x9]
40002a4c: 340001ec     	cbz	w12, 0x40002a88 <kstrstr+0x68>
40002a50: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a54: 34ffff49     	cbz	w9, 0x40002a3c <kstrstr+0x1c>
40002a58: 6b08013f     	cmp	w9, w8
40002a5c: 54ffffa1     	b.ne	0x40002a50 <kstrstr+0x30>
40002a60: 5280002a     	mov	w10, #0x1               // =1
40002a64: aa0103e9     	mov	x9, x1
40002a68: 2a0803eb     	mov	w11, w8
40002a6c: 3840152c     	ldrb	w12, [x9], #0x1
40002a70: 6b0c017f     	cmp	w11, w12
40002a74: 54fffec1     	b.ne	0x40002a4c <kstrstr+0x2c>
40002a78: 386a680b     	ldrb	w11, [x0, x10]
40002a7c: 9100054a     	add	x10, x10, #0x1
40002a80: 35ffff6b     	cbnz	w11, 0x40002a6c <kstrstr+0x4c>
40002a84: 17fffff1     	b	0x40002a48 <kstrstr+0x28>
40002a88: d65f03c0     	ret

0000000040002a8c <kstrchr>:
40002a8c: b4000140     	cbz	x0, 0x40002ab4 <kstrchr+0x28>
40002a90: 39400009     	ldrb	w9, [x0]
40002a94: 340000c9     	cbz	w9, 0x40002aac <kstrchr+0x20>
40002a98: 12001c28     	and	w8, w1, #0xff
40002a9c: 6b08013f     	cmp	w9, w8
40002aa0: 540000a0     	b.eq	0x40002ab4 <kstrchr+0x28>
40002aa4: 38401c09     	ldrb	w9, [x0, #0x1]!
40002aa8: 35ffffa9     	cbnz	w9, 0x40002a9c <kstrchr+0x10>
40002aac: 72001c3f     	tst	w1, #0xff
40002ab0: 9a9f0000     	csel	x0, x0, xzr, eq
40002ab4: d65f03c0     	ret

0000000040002ab8 <ktolower>:
40002ab8: 51010408     	sub	w8, w0, #0x41
40002abc: 321b0009     	orr	w9, w0, #0x20
40002ac0: 7100691f     	cmp	w8, #0x1a
40002ac4: 1a803120     	csel	w0, w9, w0, lo
40002ac8: d65f03c0     	ret

0000000040002acc <kstr_tolower>:
40002acc: b40001a0     	cbz	x0, 0x40002b00 <kstr_tolower+0x34>
40002ad0: b4000181     	cbz	x1, 0x40002b00 <kstr_tolower+0x34>
40002ad4: 39400029     	ldrb	w9, [x1]
40002ad8: 34000129     	cbz	w9, 0x40002afc <kstr_tolower+0x30>
40002adc: 91000428     	add	x8, x1, #0x1
40002ae0: 5101052a     	sub	w10, w9, #0x41
40002ae4: 321b012b     	orr	w11, w9, #0x20
40002ae8: 7100695f     	cmp	w10, #0x1a
40002aec: 1a893169     	csel	w9, w11, w9, lo
40002af0: 38001409     	strb	w9, [x0], #0x1
40002af4: 38401509     	ldrb	w9, [x8], #0x1
40002af8: 35ffff49     	cbnz	w9, 0x40002ae0 <kstr_tolower+0x14>
40002afc: 3900001f     	strb	wzr, [x0]
40002b00: d65f03c0     	ret

0000000040002b04 <timer_init>:
40002b04: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002b08: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b0c: f9000bf3     	str	x19, [sp, #0x10]
40002b10: d53be008     	mrs	x8, CNTFRQ_EL0
40002b14: f29999a9     	movk	x9, #0xcccd
40002b18: d0000073     	adrp	x19, 0x40010000 <var_values+0x6a8>
40002b1c: 528003c0     	mov	w0, #0x1e               // =30
40002b20: 9bc97d09     	umulh	x9, x8, x9
40002b24: 910003fd     	mov	x29, sp
40002b28: 5280002a     	mov	w10, #0x1               // =1
40002b2c: f904ae68     	str	x8, [x19, #0x958]
40002b30: d343fd29     	lsr	x9, x9, #3
40002b34: d51be209     	msr	CNTP_TVAL_EL0, x9
40002b38: d51be22a     	msr	CNTP_CTL_EL0, x10
40002b3c: 97fff5c1     	bl	0x40000240 <gic_enable_interrupt>
40002b40: d50342ff     	msr	DAIFClr, #0x2
40002b44: d503201f     	nop
40002b48: 5003c640     	adr	x0, 0x4000a412 <__rodata_start+0x2412>
40002b4c: b9495a61     	ldr	w1, [x19, #0x958]
40002b50: f9400bf3     	ldr	x19, [sp, #0x10]
40002b54: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002b58: 140003f8     	b	0x40003b38 <uart_printf>

0000000040002b5c <timer_handle_interrupt>:
40002b5c: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
40002b60: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b64: f944ad08     	ldr	x8, [x8, #0x958]
40002b68: f29999a9     	movk	x9, #0xcccd
40002b6c: 9bc97d08     	umulh	x8, x8, x9
40002b70: d0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
40002b74: f944b12a     	ldr	x10, [x9, #0x960]
40002b78: 9100054a     	add	x10, x10, #0x1
40002b7c: f904b12a     	str	x10, [x9, #0x960]
40002b80: d343fd08     	lsr	x8, x8, #3
40002b84: d51be208     	msr	CNTP_TVAL_EL0, x8
40002b88: d65f03c0     	ret

0000000040002b8c <tui_launch>:
40002b8c: d105c3ff     	sub	sp, sp, #0x170
40002b90: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b94: 910443fd     	add	x29, sp, #0x110
40002b98: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002b9c: a91367fa     	stp	x26, x25, [sp, #0x130]
40002ba0: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002ba4: a91557f6     	stp	x22, x21, [sp, #0x150]
40002ba8: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002bac: 94000758     	bl	0x4000490c <vfs_get_cwd>
40002bb0: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
40002bb4: d000007c     	adrp	x28, 0x40010000 <var_values+0x6a8>
40002bb8: d000007b     	adrp	x27, 0x40010000 <var_values+0x6a8>
40002bbc: f904b500     	str	x0, [x8, #0x968]
40002bc0: d503201f     	nop
40002bc4: 300371a0     	adr	x0, 0x400099f9 <__rodata_start+0x19f9>
40002bc8: b909739f     	str	wzr, [x28, #0x970]
40002bcc: b909777f     	str	wzr, [x27, #0x974]
40002bd0: 940002c5     	bl	0x400036e4 <uart_puts>
40002bd4: d0000036     	adrp	x22, 0x40008000 <__rodata_start>
40002bd8: 9110cad6     	add	x22, x22, #0x432
40002bdc: d0000037     	adrp	x23, 0x40008000 <__rodata_start>
40002be0: 910c8af7     	add	x23, x23, #0x322
40002be4: d0000078     	adrp	x24, 0x40010000 <var_values+0x6a8>
40002be8: 91260318     	add	x24, x24, #0x980
40002bec: d000007a     	adrp	x26, 0x40010000 <var_values+0x6a8>
40002bf0: d0000034     	adrp	x20, 0x40008000 <__rodata_start>
40002bf4: 91144e94     	add	x20, x20, #0x513
40002bf8: 14000005     	b	0x40002c0c <tui_launch+0x80>
40002bfc: b9497388     	ldr	w8, [x28, #0x970]
40002c00: 7100011f     	cmp	w8, #0x0
40002c04: 1a9f17e8     	cset	w8, eq
40002c08: b9097388     	str	w8, [x28, #0x970]
40002c0c: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
40002c10: b9097b5f     	str	wzr, [x26, #0x978]
40002c14: f944b50a     	ldr	x10, [x8, #0x968]
40002c18: f9421948     	ldr	x8, [x10, #0x430]
40002c1c: b4000108     	cbz	x8, 0x40002c3c <tui_launch+0xb0>
40002c20: 52800029     	mov	w9, #0x1                // =1
40002c24: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
40002c28: b9097b49     	str	w9, [x26, #0x978]
40002c2c: f904c11f     	str	xzr, [x8, #0x980]
40002c30: f9401548     	ldr	x8, [x10, #0x28]
40002c34: b50000a8     	cbnz	x8, 0x40002c48 <tui_launch+0xbc>
40002c38: 14000027     	b	0x40002cd4 <tui_launch+0x148>
40002c3c: 2a1f03e9     	mov	w9, wzr
40002c40: f9401548     	ldr	x8, [x10, #0x28]
40002c44: b4000488     	cbz	x8, 0x40002cd4 <tui_launch+0x148>
40002c48: 2a0903e9     	mov	w9, w9
40002c4c: d100050c     	sub	x12, x8, #0x1
40002c50: d240152b     	eor	x11, x9, #0x3f
40002c54: eb0b019f     	cmp	x12, x11
40002c58: 9a8b318b     	csel	x11, x12, x11, lo
40002c5c: b400022c     	cbz	x12, 0x40002ca0 <tui_launch+0x114>
40002c60: 9100056c     	add	x12, x11, #0x1
40002c64: 8b090f0e     	add	x14, x24, x9, lsl #3
40002c68: 9111014d     	add	x13, x10, #0x440
40002c6c: 927f798b     	and	x11, x12, #0xfffffffe
40002c70: aa090169     	orr	x9, x11, x9
40002c74: 910021ce     	add	x14, x14, #0x8
40002c78: aa0b03ef     	mov	x15, x11
40002c7c: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002c80: f10009ef     	subs	x15, x15, #0x2
40002c84: 910041ad     	add	x13, x13, #0x10
40002c88: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002c8c: 910041ce     	add	x14, x14, #0x10
40002c90: 54ffff61     	b.ne	0x40002c7c <tui_launch+0xf0>
40002c94: eb0b019f     	cmp	x12, x11
40002c98: 54000061     	b.ne	0x40002ca4 <tui_launch+0x118>
40002c9c: 1400000d     	b	0x40002cd0 <tui_launch+0x144>
40002ca0: aa1f03eb     	mov	x11, xzr
40002ca4: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002ca8: 9100056b     	add	x11, x11, #0x1
40002cac: 9110e14a     	add	x10, x10, #0x438
40002cb0: f840854c     	ldr	x12, [x10], #0x8
40002cb4: f100f93f     	cmp	x9, #0x3e
40002cb8: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002cbc: 91000529     	add	x9, x9, #0x1
40002cc0: 54000088     	b.hi	0x40002cd0 <tui_launch+0x144>
40002cc4: eb08017f     	cmp	x11, x8
40002cc8: 9100056b     	add	x11, x11, #0x1
40002ccc: 54ffff23     	b.lo	0x40002cb0 <tui_launch+0x124>
40002cd0: b9097b49     	str	w9, [x26, #0x978]
40002cd4: b949776a     	ldr	w10, [x27, #0x974]
40002cd8: 51000528     	sub	w8, w9, #0x1
40002cdc: 6b08015f     	cmp	w10, w8
40002ce0: 1a88b148     	csel	w8, w10, w8, lt
40002ce4: 6b09015f     	cmp	w10, w9
40002ce8: 5400004a     	b.ge	0x40002cf0 <tui_launch+0x164>
40002cec: 36f80068     	tbz	w8, #0x1f, 0x40002cf8 <tui_launch+0x16c>
40002cf0: 0aa87d08     	bic	w8, w8, w8, asr #31
40002cf4: b9097768     	str	w8, [x27, #0x974]
40002cf8: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002cfc: 91250800     	add	x0, x0, #0x942
40002d00: 94000279     	bl	0x400036e4 <uart_puts>
40002d04: b9497388     	ldr	w8, [x28, #0x970]
40002d08: 52800020     	mov	w0, #0x1                // =1
40002d0c: 52800501     	mov	w1, #0x28               // =40
40002d10: d0000022     	adrp	x2, 0x40008000 <__rodata_start>
40002d14: 91023042     	add	x2, x2, #0x8c
40002d18: 7100011f     	cmp	w8, #0x0
40002d1c: 1a9f17e3     	cset	w3, eq
40002d20: 94000171     	bl	0x400032e4 <draw_box>
40002d24: 52800075     	mov	w21, #0x3               // =3
40002d28: aa1603e0     	mov	x0, x22
40002d2c: 2a1503e1     	mov	w1, w21
40002d30: 52800042     	mov	w2, #0x2                // =2
40002d34: 94000381     	bl	0x40003b38 <uart_printf>
40002d38: aa1703e0     	mov	x0, x23
40002d3c: 9400026a     	bl	0x400036e4 <uart_puts>
40002d40: aa1703e0     	mov	x0, x23
40002d44: 94000268     	bl	0x400036e4 <uart_puts>
40002d48: aa1703e0     	mov	x0, x23
40002d4c: 94000266     	bl	0x400036e4 <uart_puts>
40002d50: aa1703e0     	mov	x0, x23
40002d54: 94000264     	bl	0x400036e4 <uart_puts>
40002d58: aa1703e0     	mov	x0, x23
40002d5c: 94000262     	bl	0x400036e4 <uart_puts>
40002d60: aa1703e0     	mov	x0, x23
40002d64: 94000260     	bl	0x400036e4 <uart_puts>
40002d68: aa1703e0     	mov	x0, x23
40002d6c: 9400025e     	bl	0x400036e4 <uart_puts>
40002d70: aa1703e0     	mov	x0, x23
40002d74: 9400025c     	bl	0x400036e4 <uart_puts>
40002d78: aa1703e0     	mov	x0, x23
40002d7c: 9400025a     	bl	0x400036e4 <uart_puts>
40002d80: aa1703e0     	mov	x0, x23
40002d84: 94000258     	bl	0x400036e4 <uart_puts>
40002d88: aa1703e0     	mov	x0, x23
40002d8c: 94000256     	bl	0x400036e4 <uart_puts>
40002d90: aa1703e0     	mov	x0, x23
40002d94: 94000254     	bl	0x400036e4 <uart_puts>
40002d98: aa1703e0     	mov	x0, x23
40002d9c: 94000252     	bl	0x400036e4 <uart_puts>
40002da0: aa1703e0     	mov	x0, x23
40002da4: 94000250     	bl	0x400036e4 <uart_puts>
40002da8: aa1703e0     	mov	x0, x23
40002dac: 9400024e     	bl	0x400036e4 <uart_puts>
40002db0: aa1703e0     	mov	x0, x23
40002db4: 9400024c     	bl	0x400036e4 <uart_puts>
40002db8: aa1703e0     	mov	x0, x23
40002dbc: 9400024a     	bl	0x400036e4 <uart_puts>
40002dc0: aa1703e0     	mov	x0, x23
40002dc4: 94000248     	bl	0x400036e4 <uart_puts>
40002dc8: aa1703e0     	mov	x0, x23
40002dcc: 94000246     	bl	0x400036e4 <uart_puts>
40002dd0: aa1703e0     	mov	x0, x23
40002dd4: 94000244     	bl	0x400036e4 <uart_puts>
40002dd8: aa1703e0     	mov	x0, x23
40002ddc: 94000242     	bl	0x400036e4 <uart_puts>
40002de0: aa1703e0     	mov	x0, x23
40002de4: 94000240     	bl	0x400036e4 <uart_puts>
40002de8: aa1703e0     	mov	x0, x23
40002dec: 9400023e     	bl	0x400036e4 <uart_puts>
40002df0: aa1703e0     	mov	x0, x23
40002df4: 9400023c     	bl	0x400036e4 <uart_puts>
40002df8: aa1703e0     	mov	x0, x23
40002dfc: 9400023a     	bl	0x400036e4 <uart_puts>
40002e00: aa1703e0     	mov	x0, x23
40002e04: 94000238     	bl	0x400036e4 <uart_puts>
40002e08: aa1703e0     	mov	x0, x23
40002e0c: 94000236     	bl	0x400036e4 <uart_puts>
40002e10: aa1703e0     	mov	x0, x23
40002e14: 94000234     	bl	0x400036e4 <uart_puts>
40002e18: aa1703e0     	mov	x0, x23
40002e1c: 94000232     	bl	0x400036e4 <uart_puts>
40002e20: aa1703e0     	mov	x0, x23
40002e24: 94000230     	bl	0x400036e4 <uart_puts>
40002e28: aa1703e0     	mov	x0, x23
40002e2c: 9400022e     	bl	0x400036e4 <uart_puts>
40002e30: aa1703e0     	mov	x0, x23
40002e34: 9400022c     	bl	0x400036e4 <uart_puts>
40002e38: aa1703e0     	mov	x0, x23
40002e3c: 9400022a     	bl	0x400036e4 <uart_puts>
40002e40: aa1703e0     	mov	x0, x23
40002e44: 94000228     	bl	0x400036e4 <uart_puts>
40002e48: aa1703e0     	mov	x0, x23
40002e4c: 94000226     	bl	0x400036e4 <uart_puts>
40002e50: aa1703e0     	mov	x0, x23
40002e54: 94000224     	bl	0x400036e4 <uart_puts>
40002e58: aa1703e0     	mov	x0, x23
40002e5c: 94000222     	bl	0x400036e4 <uart_puts>
40002e60: aa1703e0     	mov	x0, x23
40002e64: 94000220     	bl	0x400036e4 <uart_puts>
40002e68: 110006b5     	add	w21, w21, #0x1
40002e6c: 71005ebf     	cmp	w21, #0x17
40002e70: 54fff5c1     	b.ne	0x40002d28 <tui_launch+0x19c>
40002e74: b9497768     	ldr	w8, [x27, #0x974]
40002e78: 52800249     	mov	w9, #0x12               // =18
40002e7c: 7100491f     	cmp	w8, #0x12
40002e80: 1a89c108     	csel	w8, w8, w9, gt
40002e84: 51004915     	sub	w21, w8, #0x12
40002e88: 8b354f19     	add	x25, x24, w21, uxtw #3
40002e8c: aa1f03f8     	mov	x24, xzr
40002e90: 14000004     	b	0x40002ea0 <tui_launch+0x314>
40002e94: 91000718     	add	x24, x24, #0x1
40002e98: f100531f     	cmp	x24, #0x14
40002e9c: 540005a0     	b.eq	0x40002f50 <tui_launch+0x3c4>
40002ea0: b9897b48     	ldrsw	x8, [x26, #0x978]
40002ea4: 8b1802b3     	add	x19, x21, x24
40002ea8: eb08027f     	cmp	x19, x8
40002eac: 5400052a     	b.ge	0x40002f50 <tui_launch+0x3c4>
40002eb0: 11000f01     	add	w1, w24, #0x3
40002eb4: aa1603e0     	mov	x0, x22
40002eb8: 52800062     	mov	w2, #0x3                // =3
40002ebc: 9400031f     	bl	0x40003b38 <uart_printf>
40002ec0: b9497768     	ldr	w8, [x27, #0x974]
40002ec4: eb08027f     	cmp	x19, x8
40002ec8: 540000c1     	b.ne	0x40002ee0 <tui_launch+0x354>
40002ecc: b9497388     	ldr	w8, [x28, #0x970]
40002ed0: 35000088     	cbnz	w8, 0x40002ee0 <tui_launch+0x354>
40002ed4: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002ed8: 91037000     	add	x0, x0, #0xdc
40002edc: 94000202     	bl	0x400036e4 <uart_puts>
40002ee0: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002ee4: b40001e8     	cbz	x8, 0x40002f20 <tui_launch+0x394>
40002ee8: b9402108     	ldr	w8, [x8, #0x20]
40002eec: f0000029     	adrp	x9, 0x40009000 <__rodata_start+0x1000>
40002ef0: 910df529     	add	x9, x9, #0x37d
40002ef4: 910223e0     	add	x0, sp, #0x88
40002ef8: 7100051f     	cmp	w8, #0x1
40002efc: d0000028     	adrp	x8, 0x40008000 <__rodata_start>
40002f00: 91387d08     	add	x8, x8, #0xe1f
40002f04: 9a880121     	csel	x1, x9, x8, eq
40002f08: 97fffe7b     	bl	0x400028f4 <kstrcpy>
40002f0c: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002f10: 910223e0     	add	x0, sp, #0x88
40002f14: 97fffe50     	bl	0x40002854 <kstrcat>
40002f18: 910223e0     	add	x0, sp, #0x88
40002f1c: 14000003     	b	0x40002f28 <tui_launch+0x39c>
40002f20: d0000020     	adrp	x0, 0x40008000 <__rodata_start>
40002f24: 91327800     	add	x0, x0, #0xc9e
40002f28: 940001ef     	bl	0x400036e4 <uart_puts>
40002f2c: b9497768     	ldr	w8, [x27, #0x974]
40002f30: eb08027f     	cmp	x19, x8
40002f34: 54fffb01     	b.ne	0x40002e94 <tui_launch+0x308>
40002f38: b9497388     	ldr	w8, [x28, #0x970]
40002f3c: 35fffac8     	cbnz	w8, 0x40002e94 <tui_launch+0x308>
40002f40: f0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40002f44: 91336400     	add	x0, x0, #0xcd9
40002f48: 940001e7     	bl	0x400036e4 <uart_puts>
40002f4c: 17ffffd2     	b	0x40002e94 <tui_launch+0x308>
40002f50: b9497388     	ldr	w8, [x28, #0x970]
40002f54: 52800540     	mov	w0, #0x2a               // =42
40002f58: 528004c1     	mov	w1, #0x26               // =38
40002f5c: f0000022     	adrp	x2, 0x40009000 <__rodata_start+0x1000>
40002f60: 91068042     	add	x2, x2, #0x1a0
40002f64: 7100051f     	cmp	w8, #0x1
40002f68: 1a9f17e3     	cset	w3, eq
40002f6c: 940000de     	bl	0x400032e4 <draw_box>
40002f70: 52800075     	mov	w21, #0x3               // =3
40002f74: aa1603e0     	mov	x0, x22
40002f78: 2a1503e1     	mov	w1, w21
40002f7c: 52800562     	mov	w2, #0x2b               // =43
40002f80: 940002ee     	bl	0x40003b38 <uart_printf>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 940001d7     	bl	0x400036e4 <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 940001d5     	bl	0x400036e4 <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 940001d3     	bl	0x400036e4 <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 940001d1     	bl	0x400036e4 <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 940001cf     	bl	0x400036e4 <uart_puts>
40002fac: aa1703e0     	mov	x0, x23
40002fb0: 940001cd     	bl	0x400036e4 <uart_puts>
40002fb4: aa1703e0     	mov	x0, x23
40002fb8: 940001cb     	bl	0x400036e4 <uart_puts>
40002fbc: aa1703e0     	mov	x0, x23
40002fc0: 940001c9     	bl	0x400036e4 <uart_puts>
40002fc4: aa1703e0     	mov	x0, x23
40002fc8: 940001c7     	bl	0x400036e4 <uart_puts>
40002fcc: aa1703e0     	mov	x0, x23
40002fd0: 940001c5     	bl	0x400036e4 <uart_puts>
40002fd4: aa1703e0     	mov	x0, x23
40002fd8: 940001c3     	bl	0x400036e4 <uart_puts>
40002fdc: aa1703e0     	mov	x0, x23
40002fe0: 940001c1     	bl	0x400036e4 <uart_puts>
40002fe4: aa1703e0     	mov	x0, x23
40002fe8: 940001bf     	bl	0x400036e4 <uart_puts>
40002fec: aa1703e0     	mov	x0, x23
40002ff0: 940001bd     	bl	0x400036e4 <uart_puts>
40002ff4: aa1703e0     	mov	x0, x23
40002ff8: 940001bb     	bl	0x400036e4 <uart_puts>
40002ffc: aa1703e0     	mov	x0, x23
40003000: 940001b9     	bl	0x400036e4 <uart_puts>
40003004: aa1703e0     	mov	x0, x23
40003008: 940001b7     	bl	0x400036e4 <uart_puts>
4000300c: aa1703e0     	mov	x0, x23
40003010: 940001b5     	bl	0x400036e4 <uart_puts>
40003014: aa1703e0     	mov	x0, x23
40003018: 940001b3     	bl	0x400036e4 <uart_puts>
4000301c: aa1703e0     	mov	x0, x23
40003020: 940001b1     	bl	0x400036e4 <uart_puts>
40003024: aa1703e0     	mov	x0, x23
40003028: 940001af     	bl	0x400036e4 <uart_puts>
4000302c: aa1703e0     	mov	x0, x23
40003030: 940001ad     	bl	0x400036e4 <uart_puts>
40003034: aa1703e0     	mov	x0, x23
40003038: 940001ab     	bl	0x400036e4 <uart_puts>
4000303c: aa1703e0     	mov	x0, x23
40003040: 940001a9     	bl	0x400036e4 <uart_puts>
40003044: aa1703e0     	mov	x0, x23
40003048: 940001a7     	bl	0x400036e4 <uart_puts>
4000304c: aa1703e0     	mov	x0, x23
40003050: 940001a5     	bl	0x400036e4 <uart_puts>
40003054: aa1703e0     	mov	x0, x23
40003058: 940001a3     	bl	0x400036e4 <uart_puts>
4000305c: aa1703e0     	mov	x0, x23
40003060: 940001a1     	bl	0x400036e4 <uart_puts>
40003064: aa1703e0     	mov	x0, x23
40003068: 9400019f     	bl	0x400036e4 <uart_puts>
4000306c: aa1703e0     	mov	x0, x23
40003070: 9400019d     	bl	0x400036e4 <uart_puts>
40003074: aa1703e0     	mov	x0, x23
40003078: 9400019b     	bl	0x400036e4 <uart_puts>
4000307c: aa1703e0     	mov	x0, x23
40003080: 94000199     	bl	0x400036e4 <uart_puts>
40003084: aa1703e0     	mov	x0, x23
40003088: 94000197     	bl	0x400036e4 <uart_puts>
4000308c: aa1703e0     	mov	x0, x23
40003090: 94000195     	bl	0x400036e4 <uart_puts>
40003094: aa1703e0     	mov	x0, x23
40003098: 94000193     	bl	0x400036e4 <uart_puts>
4000309c: aa1703e0     	mov	x0, x23
400030a0: 94000191     	bl	0x400036e4 <uart_puts>
400030a4: 110006b5     	add	w21, w21, #0x1
400030a8: 71005ebf     	cmp	w21, #0x17
400030ac: 54fff641     	b.ne	0x40002f74 <tui_launch+0x3e8>
400030b0: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
400030b4: 91165800     	add	x0, x0, #0x596
400030b8: 52800061     	mov	w1, #0x3                // =3
400030bc: 52800562     	mov	w2, #0x2b               // =43
400030c0: 9400029e     	bl	0x40003b38 <uart_printf>
400030c4: d503201f     	nop
400030c8: 10060c68     	adr	x8, 0x4000f254 <proc_table>
400030cc: aa1f03f3     	mov	x19, xzr
400030d0: 9100a115     	add	x21, x8, #0x28
400030d4: 52800058     	mov	w24, #0x2               // =2
400030d8: b0000039     	adrp	x25, 0x40008000 <__rodata_start>
400030dc: 91206f39     	add	x25, x25, #0x81b
400030e0: b85fc2a8     	ldur	w8, [x21, #-0x4]
400030e4: 71000d1f     	cmp	w8, #0x3
400030e8: 54000140     	b.eq	0x40003110 <tui_launch+0x584>
400030ec: b94002a8     	ldr	w8, [x21]
400030f0: b85d82a3     	ldur	w3, [x21, #-0x28]
400030f4: d10092a4     	sub	x4, x21, #0x24
400030f8: 11000b01     	add	w1, w24, #0x2
400030fc: aa1403e0     	mov	x0, x20
40003100: 52800562     	mov	w2, #0x2b               // =43
40003104: 530a7d05     	lsr	w5, w8, #10
40003108: 9400028c     	bl	0x40003b38 <uart_printf>
4000310c: 11000718     	add	w24, w24, #0x1
40003110: f1003a7f     	cmp	x19, #0xe
40003114: 540000a8     	b.hi	0x40003128 <tui_launch+0x59c>
40003118: 7100531f     	cmp	w24, #0x14
4000311c: 91000673     	add	x19, x19, #0x1
40003120: 9100c2b5     	add	x21, x21, #0x30
40003124: 54fffdeb     	b.lt	0x400030e0 <tui_launch+0x554>
40003128: 940001a3     	bl	0x400037b4 <uart_getc>
4000312c: 52801be8     	mov	w8, #0xdf               // =223
40003130: 0a080008     	and	w8, w0, w8
40003134: 7101451f     	cmp	w8, #0x51
40003138: 54000c00     	b.eq	0x400032b8 <tui_launch+0x72c>
4000313c: 12001c08     	and	w8, w0, #0xff
40003140: 7100311f     	cmp	w8, #0xc
40003144: 5400010c     	b.gt	0x40003164 <tui_launch+0x5d8>
40003148: 7100251f     	cmp	w8, #0x9
4000314c: b0000078     	adrp	x24, 0x40010000 <var_values+0x6a8>
40003150: 91260318     	add	x24, x24, #0x980
40003154: 54ffd540     	b.eq	0x40002bfc <tui_launch+0x70>
40003158: 7100291f     	cmp	w8, #0xa
4000315c: 540002e0     	b.eq	0x400031b8 <tui_launch+0x62c>
40003160: 17fffeab     	b	0x40002c0c <tui_launch+0x80>
40003164: 7100351f     	cmp	w8, #0xd
40003168: b0000078     	adrp	x24, 0x40010000 <var_values+0x6a8>
4000316c: 91260318     	add	x24, x24, #0x980
40003170: 54000240     	b.eq	0x400031b8 <tui_launch+0x62c>
40003174: 71006d1f     	cmp	w8, #0x1b
40003178: 54ffd4a1     	b.ne	0x40002c0c <tui_launch+0x80>
4000317c: 9400018e     	bl	0x400037b4 <uart_getc>
40003180: 12001c13     	and	w19, w0, #0xff
40003184: 9400018c     	bl	0x400037b4 <uart_getc>
40003188: 71016e7f     	cmp	w19, #0x5b
4000318c: 54ffd401     	b.ne	0x40002c0c <tui_launch+0x80>
40003190: 12001c08     	and	w8, w0, #0xff
40003194: 7101051f     	cmp	w8, #0x41
40003198: 54000781     	b.ne	0x40003288 <tui_launch+0x6fc>
4000319c: b9497388     	ldr	w8, [x28, #0x970]
400031a0: 35ffd368     	cbnz	w8, 0x40002c0c <tui_launch+0x80>
400031a4: b9497768     	ldr	w8, [x27, #0x974]
400031a8: 71000508     	subs	w8, w8, #0x1
400031ac: 54ffd30b     	b.lt	0x40002c0c <tui_launch+0x80>
400031b0: b9097768     	str	w8, [x27, #0x974]
400031b4: 17fffe96     	b	0x40002c0c <tui_launch+0x80>
400031b8: b9497388     	ldr	w8, [x28, #0x970]
400031bc: 35ffd288     	cbnz	w8, 0x40002c0c <tui_launch+0x80>
400031c0: b9497b48     	ldr	w8, [x26, #0x978]
400031c4: 7100051f     	cmp	w8, #0x1
400031c8: 54ffd22b     	b.lt	0x40002c0c <tui_launch+0x80>
400031cc: b9897768     	ldrsw	x8, [x27, #0x974]
400031d0: f8687b15     	ldr	x21, [x24, x8, lsl #3]
400031d4: b4000115     	cbz	x21, 0x400031f4 <tui_launch+0x668>
400031d8: b94022a8     	ldr	w8, [x21, #0x20]
400031dc: 7100051f     	cmp	w8, #0x1
400031e0: 54000161     	b.ne	0x4000320c <tui_launch+0x680>
400031e4: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
400031e8: b909777f     	str	wzr, [x27, #0x974]
400031ec: f904b515     	str	x21, [x8, #0x968]
400031f0: 17fffe87     	b	0x40002c0c <tui_launch+0x80>
400031f4: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
400031f8: b909777f     	str	wzr, [x27, #0x974]
400031fc: f944b528     	ldr	x8, [x9, #0x968]
40003200: f9421908     	ldr	x8, [x8, #0x430]
40003204: f904b528     	str	x8, [x9, #0x968]
40003208: 17fffe81     	b	0x40002c0c <tui_launch+0x80>
4000320c: 390223ff     	strb	wzr, [sp, #0x88]
40003210: aa1903e0     	mov	x0, x25
40003214: 94000610     	bl	0x40004a54 <vfs_find>
40003218: eb0002bf     	cmp	x21, x0
4000321c: 540001e0     	b.eq	0x40003258 <tui_launch+0x6cc>
40003220: 910023e0     	add	x0, sp, #0x8
40003224: 910223e1     	add	x1, sp, #0x88
40003228: 97fffdb3     	bl	0x400028f4 <kstrcpy>
4000322c: 910223e0     	add	x0, sp, #0x88
40003230: aa1903e1     	mov	x1, x25
40003234: 97fffdb0     	bl	0x400028f4 <kstrcpy>
40003238: 910223e0     	add	x0, sp, #0x88
4000323c: aa1503e1     	mov	x1, x21
40003240: 97fffd85     	bl	0x40002854 <kstrcat>
40003244: 910223e0     	add	x0, sp, #0x88
40003248: 910023e1     	add	x1, sp, #0x8
4000324c: 97fffd82     	bl	0x40002854 <kstrcat>
40003250: f9421ab5     	ldr	x21, [x21, #0x430]
40003254: b5fffdf5     	cbnz	x21, 0x40003210 <tui_launch+0x684>
40003258: 910223e0     	add	x0, sp, #0x88
4000325c: 97fffd77     	bl	0x40002838 <kstrlen>
40003260: b5000080     	cbnz	x0, 0x40003270 <tui_launch+0x6e4>
40003264: 910223e0     	add	x0, sp, #0x88
40003268: aa1903e1     	mov	x1, x25
4000326c: 97fffda2     	bl	0x400028f4 <kstrcpy>
40003270: 910223e0     	add	x0, sp, #0x88
40003274: 97fff414     	bl	0x400002c4 <launch_kedit>
40003278: d503201f     	nop
4000327c: 30033be0     	adr	x0, 0x400099f9 <__rodata_start+0x19f9>
40003280: 94000119     	bl	0x400036e4 <uart_puts>
40003284: 17fffe62     	b	0x40002c0c <tui_launch+0x80>
40003288: 7101091f     	cmp	w8, #0x42
4000328c: 54ffcc01     	b.ne	0x40002c0c <tui_launch+0x80>
40003290: b9497388     	ldr	w8, [x28, #0x970]
40003294: 35ffcbc8     	cbnz	w8, 0x40002c0c <tui_launch+0x80>
40003298: b9497b49     	ldr	w9, [x26, #0x978]
4000329c: b9497768     	ldr	w8, [x27, #0x974]
400032a0: 51000529     	sub	w9, w9, #0x1
400032a4: 6b09011f     	cmp	w8, w9
400032a8: 54ffcb2a     	b.ge	0x40002c0c <tui_launch+0x80>
400032ac: 11000508     	add	w8, w8, #0x1
400032b0: b9097768     	str	w8, [x27, #0x974]
400032b4: 17fffe56     	b	0x40002c0c <tui_launch+0x80>
400032b8: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
400032bc: 912d5800     	add	x0, x0, #0xb56
400032c0: 94000109     	bl	0x400036e4 <uart_puts>
400032c4: a9564ff4     	ldp	x20, x19, [sp, #0x160]
400032c8: a95557f6     	ldp	x22, x21, [sp, #0x150]
400032cc: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400032d0: a95367fa     	ldp	x26, x25, [sp, #0x130]
400032d4: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400032d8: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400032dc: 9105c3ff     	add	sp, sp, #0x170
400032e0: d65f03c0     	ret

00000000400032e4 <draw_box>:
400032e4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400032e8: f0000028     	adrp	x8, 0x4000a000 <__rodata_start+0x2000>
400032ec: 9124c508     	add	x8, x8, #0x931
400032f0: 7100007f     	cmp	w3, #0x0
400032f4: d0000029     	adrp	x9, 0x40009000 <__rodata_start+0x1000>
400032f8: 910ac529     	add	x9, x9, #0x2b1
400032fc: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003300: 2a0003f3     	mov	w19, w0
40003304: 9a880120     	csel	x0, x9, x8, eq
40003308: a9015ff8     	stp	x24, x23, [sp, #0x10]
4000330c: a90257f6     	stp	x22, x21, [sp, #0x20]
40003310: 910003fd     	mov	x29, sp
40003314: aa0203f4     	mov	x20, x2
40003318: 2a0103f5     	mov	w21, w1
4000331c: 940000f2     	bl	0x400036e4 <uart_puts>
40003320: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
40003324: 91207400     	add	x0, x0, #0x81d
40003328: 52800041     	mov	w1, #0x2                // =2
4000332c: 2a1303e2     	mov	w2, w19
40003330: 94000202     	bl	0x40003b38 <uart_printf>
40003334: 51000ab6     	sub	w22, w21, #0x2
40003338: 510006b7     	sub	w23, w21, #0x1
4000333c: b0000035     	adrp	x21, 0x40008000 <__rodata_start>
40003340: 91143eb5     	add	x21, x21, #0x50f
40003344: 2a1603f8     	mov	w24, w22
40003348: aa1503e0     	mov	x0, x21
4000334c: 940000e6     	bl	0x400036e4 <uart_puts>
40003350: 71000718     	subs	w24, w24, #0x1
40003354: 54ffffa1     	b.ne	0x40003348 <draw_box+0x64>
40003358: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
4000335c: 9126d000     	add	x0, x0, #0x9b4
40003360: 940000e1     	bl	0x400036e4 <uart_puts>
40003364: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
40003368: 9120a400     	add	x0, x0, #0x829
4000336c: 11000a62     	add	w2, w19, #0x2
40003370: 52800041     	mov	w1, #0x2                // =2
40003374: aa1403e3     	mov	x3, x20
40003378: 940001f0     	bl	0x40003b38 <uart_printf>
4000337c: d0000034     	adrp	x20, 0x40009000 <__rodata_start+0x1000>
40003380: 91188e94     	add	x20, x20, #0x623
40003384: 52800061     	mov	w1, #0x3                // =3
40003388: aa1403e0     	mov	x0, x20
4000338c: 2a1303e2     	mov	w2, w19
40003390: 940001ea     	bl	0x40003b38 <uart_printf>
40003394: 0b1302e2     	add	w2, w23, w19
40003398: aa1403e0     	mov	x0, x20
4000339c: 52800061     	mov	w1, #0x3                // =3
400033a0: 940001e6     	bl	0x40003b38 <uart_printf>
400033a4: aa1403e0     	mov	x0, x20
400033a8: 52800081     	mov	w1, #0x4                // =4
400033ac: 2a1303e2     	mov	w2, w19
400033b0: 940001e2     	bl	0x40003b38 <uart_printf>
400033b4: 0b1302e2     	add	w2, w23, w19
400033b8: aa1403e0     	mov	x0, x20
400033bc: 52800081     	mov	w1, #0x4                // =4
400033c0: 940001de     	bl	0x40003b38 <uart_printf>
400033c4: aa1403e0     	mov	x0, x20
400033c8: 528000a1     	mov	w1, #0x5                // =5
400033cc: 2a1303e2     	mov	w2, w19
400033d0: 940001da     	bl	0x40003b38 <uart_printf>
400033d4: 0b1302e2     	add	w2, w23, w19
400033d8: aa1403e0     	mov	x0, x20
400033dc: 528000a1     	mov	w1, #0x5                // =5
400033e0: 940001d6     	bl	0x40003b38 <uart_printf>
400033e4: aa1403e0     	mov	x0, x20
400033e8: 528000c1     	mov	w1, #0x6                // =6
400033ec: 2a1303e2     	mov	w2, w19
400033f0: 940001d2     	bl	0x40003b38 <uart_printf>
400033f4: 0b1302e2     	add	w2, w23, w19
400033f8: aa1403e0     	mov	x0, x20
400033fc: 528000c1     	mov	w1, #0x6                // =6
40003400: 940001ce     	bl	0x40003b38 <uart_printf>
40003404: aa1403e0     	mov	x0, x20
40003408: 528000e1     	mov	w1, #0x7                // =7
4000340c: 2a1303e2     	mov	w2, w19
40003410: 940001ca     	bl	0x40003b38 <uart_printf>
40003414: 0b1302e2     	add	w2, w23, w19
40003418: aa1403e0     	mov	x0, x20
4000341c: 528000e1     	mov	w1, #0x7                // =7
40003420: 940001c6     	bl	0x40003b38 <uart_printf>
40003424: aa1403e0     	mov	x0, x20
40003428: 52800101     	mov	w1, #0x8                // =8
4000342c: 2a1303e2     	mov	w2, w19
40003430: 940001c2     	bl	0x40003b38 <uart_printf>
40003434: 0b1302e2     	add	w2, w23, w19
40003438: aa1403e0     	mov	x0, x20
4000343c: 52800101     	mov	w1, #0x8                // =8
40003440: 940001be     	bl	0x40003b38 <uart_printf>
40003444: aa1403e0     	mov	x0, x20
40003448: 52800121     	mov	w1, #0x9                // =9
4000344c: 2a1303e2     	mov	w2, w19
40003450: 940001ba     	bl	0x40003b38 <uart_printf>
40003454: 0b1302e2     	add	w2, w23, w19
40003458: aa1403e0     	mov	x0, x20
4000345c: 52800121     	mov	w1, #0x9                // =9
40003460: 940001b6     	bl	0x40003b38 <uart_printf>
40003464: aa1403e0     	mov	x0, x20
40003468: 52800141     	mov	w1, #0xa                // =10
4000346c: 2a1303e2     	mov	w2, w19
40003470: 940001b2     	bl	0x40003b38 <uart_printf>
40003474: 0b1302e2     	add	w2, w23, w19
40003478: aa1403e0     	mov	x0, x20
4000347c: 52800141     	mov	w1, #0xa                // =10
40003480: 940001ae     	bl	0x40003b38 <uart_printf>
40003484: aa1403e0     	mov	x0, x20
40003488: 52800161     	mov	w1, #0xb                // =11
4000348c: 2a1303e2     	mov	w2, w19
40003490: 940001aa     	bl	0x40003b38 <uart_printf>
40003494: 0b1302e2     	add	w2, w23, w19
40003498: aa1403e0     	mov	x0, x20
4000349c: 52800161     	mov	w1, #0xb                // =11
400034a0: 940001a6     	bl	0x40003b38 <uart_printf>
400034a4: aa1403e0     	mov	x0, x20
400034a8: 52800181     	mov	w1, #0xc                // =12
400034ac: 2a1303e2     	mov	w2, w19
400034b0: 940001a2     	bl	0x40003b38 <uart_printf>
400034b4: 0b1302e2     	add	w2, w23, w19
400034b8: aa1403e0     	mov	x0, x20
400034bc: 52800181     	mov	w1, #0xc                // =12
400034c0: 9400019e     	bl	0x40003b38 <uart_printf>
400034c4: aa1403e0     	mov	x0, x20
400034c8: 528001a1     	mov	w1, #0xd                // =13
400034cc: 2a1303e2     	mov	w2, w19
400034d0: 9400019a     	bl	0x40003b38 <uart_printf>
400034d4: 0b1302e2     	add	w2, w23, w19
400034d8: aa1403e0     	mov	x0, x20
400034dc: 528001a1     	mov	w1, #0xd                // =13
400034e0: 94000196     	bl	0x40003b38 <uart_printf>
400034e4: aa1403e0     	mov	x0, x20
400034e8: 528001c1     	mov	w1, #0xe                // =14
400034ec: 2a1303e2     	mov	w2, w19
400034f0: 94000192     	bl	0x40003b38 <uart_printf>
400034f4: 0b1302e2     	add	w2, w23, w19
400034f8: aa1403e0     	mov	x0, x20
400034fc: 528001c1     	mov	w1, #0xe                // =14
40003500: 9400018e     	bl	0x40003b38 <uart_printf>
40003504: aa1403e0     	mov	x0, x20
40003508: 528001e1     	mov	w1, #0xf                // =15
4000350c: 2a1303e2     	mov	w2, w19
40003510: 9400018a     	bl	0x40003b38 <uart_printf>
40003514: 0b1302e2     	add	w2, w23, w19
40003518: aa1403e0     	mov	x0, x20
4000351c: 528001e1     	mov	w1, #0xf                // =15
40003520: 94000186     	bl	0x40003b38 <uart_printf>
40003524: aa1403e0     	mov	x0, x20
40003528: 52800201     	mov	w1, #0x10               // =16
4000352c: 2a1303e2     	mov	w2, w19
40003530: 94000182     	bl	0x40003b38 <uart_printf>
40003534: 0b1302e2     	add	w2, w23, w19
40003538: aa1403e0     	mov	x0, x20
4000353c: 52800201     	mov	w1, #0x10               // =16
40003540: 9400017e     	bl	0x40003b38 <uart_printf>
40003544: aa1403e0     	mov	x0, x20
40003548: 52800221     	mov	w1, #0x11               // =17
4000354c: 2a1303e2     	mov	w2, w19
40003550: 9400017a     	bl	0x40003b38 <uart_printf>
40003554: 0b1302e2     	add	w2, w23, w19
40003558: aa1403e0     	mov	x0, x20
4000355c: 52800221     	mov	w1, #0x11               // =17
40003560: 94000176     	bl	0x40003b38 <uart_printf>
40003564: aa1403e0     	mov	x0, x20
40003568: 52800241     	mov	w1, #0x12               // =18
4000356c: 2a1303e2     	mov	w2, w19
40003570: 94000172     	bl	0x40003b38 <uart_printf>
40003574: 0b1302e2     	add	w2, w23, w19
40003578: aa1403e0     	mov	x0, x20
4000357c: 52800241     	mov	w1, #0x12               // =18
40003580: 9400016e     	bl	0x40003b38 <uart_printf>
40003584: aa1403e0     	mov	x0, x20
40003588: 52800261     	mov	w1, #0x13               // =19
4000358c: 2a1303e2     	mov	w2, w19
40003590: 9400016a     	bl	0x40003b38 <uart_printf>
40003594: 0b1302e2     	add	w2, w23, w19
40003598: aa1403e0     	mov	x0, x20
4000359c: 52800261     	mov	w1, #0x13               // =19
400035a0: 94000166     	bl	0x40003b38 <uart_printf>
400035a4: aa1403e0     	mov	x0, x20
400035a8: 52800281     	mov	w1, #0x14               // =20
400035ac: 2a1303e2     	mov	w2, w19
400035b0: 94000162     	bl	0x40003b38 <uart_printf>
400035b4: 0b1302e2     	add	w2, w23, w19
400035b8: aa1403e0     	mov	x0, x20
400035bc: 52800281     	mov	w1, #0x14               // =20
400035c0: 9400015e     	bl	0x40003b38 <uart_printf>
400035c4: aa1403e0     	mov	x0, x20
400035c8: 528002a1     	mov	w1, #0x15               // =21
400035cc: 2a1303e2     	mov	w2, w19
400035d0: 9400015a     	bl	0x40003b38 <uart_printf>
400035d4: 0b1302e2     	add	w2, w23, w19
400035d8: aa1403e0     	mov	x0, x20
400035dc: 528002a1     	mov	w1, #0x15               // =21
400035e0: 94000156     	bl	0x40003b38 <uart_printf>
400035e4: aa1403e0     	mov	x0, x20
400035e8: 528002c1     	mov	w1, #0x16               // =22
400035ec: 2a1303e2     	mov	w2, w19
400035f0: 94000152     	bl	0x40003b38 <uart_printf>
400035f4: 0b1302e2     	add	w2, w23, w19
400035f8: aa1403e0     	mov	x0, x20
400035fc: 528002c1     	mov	w1, #0x16               // =22
40003600: 9400014e     	bl	0x40003b38 <uart_printf>
40003604: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
40003608: 91161800     	add	x0, x0, #0x586
4000360c: 528002e1     	mov	w1, #0x17               // =23
40003610: 2a1303e2     	mov	w2, w19
40003614: 94000149     	bl	0x40003b38 <uart_printf>
40003618: b0000033     	adrp	x19, 0x40008000 <__rodata_start>
4000361c: 91143e73     	add	x19, x19, #0x50f
40003620: aa1303e0     	mov	x0, x19
40003624: 94000030     	bl	0x400036e4 <uart_puts>
40003628: 710006d6     	subs	w22, w22, #0x1
4000362c: 54ffffa1     	b.ne	0x40003620 <draw_box+0x33c>
40003630: b0000020     	adrp	x0, 0x40008000 <__rodata_start>
40003634: 91164800     	add	x0, x0, #0x592
40003638: 9400002b     	bl	0x400036e4 <uart_puts>
4000363c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003640: d0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40003644: 91336400     	add	x0, x0, #0xcd9
40003648: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000364c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003650: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003654: 14000024     	b	0x400036e4 <uart_puts>

0000000040003658 <uart_init>:
40003658: 52800608     	mov	w8, #0x30               // =48
4000365c: 528001a9     	mov	w9, #0xd                // =13
40003660: 5280002a     	mov	w10, #0x1               // =1
40003664: 72a12008     	movk	w8, #0x900, lsl #16
40003668: b900011f     	str	wzr, [x8]
4000366c: b81f4109     	stur	w9, [x8, #-0xc]
40003670: 52800e09     	mov	w9, #0x70               // =112
40003674: b81f810a     	stur	w10, [x8, #-0x8]
40003678: b81fc109     	stur	w9, [x8, #-0x4]
4000367c: 52806029     	mov	w9, #0x301              // =769
40003680: b9000109     	str	w9, [x8]
40003684: d65f03c0     	ret

0000000040003688 <uart_putc>:
40003688: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
4000368c: b94b8108     	ldr	w8, [x8, #0xb80]
40003690: 340001a8     	cbz	w8, 0x400036c4 <uart_putc+0x3c>
40003694: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a8>
40003698: 5287ffca     	mov	w10, #0x3ffe            // =16382
4000369c: b94b8509     	ldr	w9, [x8, #0xb84]
400036a0: 6b0a013f     	cmp	w9, w10
400036a4: 5400010c     	b.gt	0x400036c4 <uart_putc+0x3c>
400036a8: 93407d29     	sxtw	x9, w9
400036ac: d503201f     	nop
400036b0: 1006a6ca     	adr	x10, 0x40010b88 <kernel_capture_buffer>
400036b4: 9100052b     	add	x11, x9, #0x1
400036b8: 38296940     	strb	w0, [x10, x9]
400036bc: b90b850b     	str	w11, [x8, #0xb84]
400036c0: 382b695f     	strb	wzr, [x10, x11]
400036c4: 52800308     	mov	w8, #0x18               // =24
400036c8: 72a12008     	movk	w8, #0x900, lsl #16
400036cc: b9400109     	ldr	w9, [x8]
400036d0: 372fffe9     	tbnz	w9, #0x5, 0x400036cc <uart_putc+0x44>
400036d4: 12001c08     	and	w8, w0, #0xff
400036d8: 52a12009     	mov	w9, #0x9000000          // =150994944
400036dc: b9000128     	str	w8, [x9]
400036e0: d65f03c0     	ret

00000000400036e4 <uart_puts>:
400036e4: 52800308     	mov	w8, #0x18               // =24
400036e8: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
400036ec: b000006a     	adrp	x10, 0x40010000 <var_values+0x6a8>
400036f0: 72a12008     	movk	w8, #0x900, lsl #16
400036f4: d503201f     	nop
400036f8: 1006a48b     	adr	x11, 0x40010b88 <kernel_capture_buffer>
400036fc: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003700: 528001ad     	mov	w13, #0xd               // =13
40003704: 52a1200e     	mov	w14, #0x9000000         // =150994944
40003708: 3940000f     	ldrb	w15, [x0]
4000370c: 710029ff     	cmp	w15, #0xa
40003710: 540000a0     	b.eq	0x40003724 <uart_puts+0x40>
40003714: 3400042f     	cbz	w15, 0x40003798 <uart_puts+0xb4>
40003718: b94b8130     	ldr	w16, [x9, #0xb80]
4000371c: 35000250     	cbnz	w16, 0x40003764 <uart_puts+0x80>
40003720: 14000019     	b	0x40003784 <uart_puts+0xa0>
40003724: b94b812f     	ldr	w15, [x9, #0xb80]
40003728: 3400012f     	cbz	w15, 0x4000374c <uart_puts+0x68>
4000372c: b94b854f     	ldr	w15, [x10, #0xb84]
40003730: 6b0c01ff     	cmp	w15, w12
40003734: 540000cc     	b.gt	0x4000374c <uart_puts+0x68>
40003738: 93407def     	sxtw	x15, w15
4000373c: 910005f0     	add	x16, x15, #0x1
40003740: 382f696d     	strb	w13, [x11, x15]
40003744: b90b8550     	str	w16, [x10, #0xb84]
40003748: 3830697f     	strb	wzr, [x11, x16]
4000374c: b940010f     	ldr	w15, [x8]
40003750: 372fffef     	tbnz	w15, #0x5, 0x4000374c <uart_puts+0x68>
40003754: b90001cd     	str	w13, [x14]
40003758: 3940000f     	ldrb	w15, [x0]
4000375c: b94b8130     	ldr	w16, [x9, #0xb80]
40003760: 34000130     	cbz	w16, 0x40003784 <uart_puts+0xa0>
40003764: b94b8550     	ldr	w16, [x10, #0xb84]
40003768: 6b0c021f     	cmp	w16, w12
4000376c: 540000cc     	b.gt	0x40003784 <uart_puts+0xa0>
40003770: 93407e10     	sxtw	x16, w16
40003774: 91000611     	add	x17, x16, #0x1
40003778: 3830696f     	strb	w15, [x11, x16]
4000377c: b90b8551     	str	w17, [x10, #0xb84]
40003780: 3831697f     	strb	wzr, [x11, x17]
40003784: 91000400     	add	x0, x0, #0x1
40003788: b9400110     	ldr	w16, [x8]
4000378c: 372ffff0     	tbnz	w16, #0x5, 0x40003788 <uart_puts+0xa4>
40003790: b90001cf     	str	w15, [x14]
40003794: 17ffffdd     	b	0x40003708 <uart_puts+0x24>
40003798: d65f03c0     	ret

000000004000379c <uart_has_data>:
4000379c: 52800308     	mov	w8, #0x18               // =24
400037a0: 52800029     	mov	w9, #0x1                // =1
400037a4: 72a12008     	movk	w8, #0x900, lsl #16
400037a8: b9400108     	ldr	w8, [x8]
400037ac: 0a681120     	bic	w0, w9, w8, lsr #4
400037b0: d65f03c0     	ret

00000000400037b4 <uart_getc>:
400037b4: 52800308     	mov	w8, #0x18               // =24
400037b8: 72a12008     	movk	w8, #0x900, lsl #16
400037bc: b9400109     	ldr	w9, [x8]
400037c0: 3727ffe9     	tbnz	w9, #0x4, 0x400037bc <uart_getc+0x8>
400037c4: 52a12008     	mov	w8, #0x9000000          // =150994944
400037c8: b9400100     	ldr	w0, [x8]
400037cc: d65f03c0     	ret

00000000400037d0 <uart_print_hex_raw>:
400037d0: 52800308     	mov	w8, #0x18               // =24
400037d4: 2a1f03eb     	mov	w11, wzr
400037d8: 5280078c     	mov	w12, #0x3c              // =60
400037dc: 72a12008     	movk	w8, #0x900, lsl #16
400037e0: d503201f     	nop
400037e4: 1002664e     	adr	x14, 0x400084ac <__rodata_start+0x4ac>
400037e8: b000006d     	adrp	x13, 0x40010000 <var_values+0x6a8>
400037ec: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
400037f0: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037f4: d503201f     	nop
400037f8: 10069c8a     	adr	x10, 0x40010b88 <kernel_capture_buffer>
400037fc: 52a12010     	mov	w16, #0x9000000         // =150994944
40003800: 14000003     	b	0x4000380c <uart_print_hex_raw+0x3c>
40003804: b400032c     	cbz	x12, 0x40003868 <uart_print_hex_raw+0x98>
40003808: d100118c     	sub	x12, x12, #0x4
4000380c: 9acc2411     	lsr	x17, x0, x12
40003810: 53027d92     	lsr	w18, w12, #2
40003814: 92400e31     	and	x17, x17, #0xf
40003818: 6b01025f     	cmp	w18, w1
4000381c: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003820: 1a9f056b     	csinc	w11, w11, wzr, eq
40003824: 34ffff0b     	cbz	w11, 0x40003804 <uart_print_hex_raw+0x34>
40003828: b94b81b2     	ldr	w18, [x13, #0xb80]
4000382c: 387169d1     	ldrb	w17, [x14, x17]
40003830: 34000132     	cbz	w18, 0x40003854 <uart_print_hex_raw+0x84>
40003834: b94b8532     	ldr	w18, [x9, #0xb84]
40003838: 6b0f025f     	cmp	w18, w15
4000383c: 540000cc     	b.gt	0x40003854 <uart_print_hex_raw+0x84>
40003840: 93407e52     	sxtw	x18, w18
40003844: 91000642     	add	x2, x18, #0x1
40003848: 38326951     	strb	w17, [x10, x18]
4000384c: b90b8522     	str	w2, [x9, #0xb84]
40003850: 3822695f     	strb	wzr, [x10, x2]
40003854: b9400112     	ldr	w18, [x8]
40003858: 372ffff2     	tbnz	w18, #0x5, 0x40003854 <uart_print_hex_raw+0x84>
4000385c: b9000211     	str	w17, [x16]
40003860: b5fffd4c     	cbnz	x12, 0x40003808 <uart_print_hex_raw+0x38>
40003864: d65f03c0     	ret
40003868: b94b81ab     	ldr	w11, [x13, #0xb80]
4000386c: 3400016b     	cbz	w11, 0x40003898 <uart_print_hex_raw+0xc8>
40003870: b94b852b     	ldr	w11, [x9, #0xb84]
40003874: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003878: 6b0c017f     	cmp	w11, w12
4000387c: 540000ec     	b.gt	0x40003898 <uart_print_hex_raw+0xc8>
40003880: 93407d6b     	sxtw	x11, w11
40003884: 5280060c     	mov	w12, #0x30              // =48
40003888: 9100056d     	add	x13, x11, #0x1
4000388c: 382b694c     	strb	w12, [x10, x11]
40003890: b90b852d     	str	w13, [x9, #0xb84]
40003894: 382d695f     	strb	wzr, [x10, x13]
40003898: b9400109     	ldr	w9, [x8]
4000389c: 372fffe9     	tbnz	w9, #0x5, 0x40003898 <uart_print_hex_raw+0xc8>
400038a0: 52a12008     	mov	w8, #0x9000000          // =150994944
400038a4: 52800609     	mov	w9, #0x30               // =48
400038a8: b9000109     	str	w9, [x8]
400038ac: d65f03c0     	ret

00000000400038b0 <uart_print_hex>:
400038b0: 52800308     	mov	w8, #0x18               // =24
400038b4: d000002c     	adrp	x12, 0x40009000 <__rodata_start+0x1000>
400038b8: 9106b58c     	add	x12, x12, #0x1ad
400038bc: 72a12008     	movk	w8, #0x900, lsl #16
400038c0: b000006b     	adrp	x11, 0x40010000 <var_values+0x6a8>
400038c4: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
400038c8: d503201f     	nop
400038cc: 100695ea     	adr	x10, 0x40010b88 <kernel_capture_buffer>
400038d0: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038d4: 528001ae     	mov	w14, #0xd               // =13
400038d8: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038dc: 39400190     	ldrb	w16, [x12]
400038e0: 71002a1f     	cmp	w16, #0xa
400038e4: 540000a0     	b.eq	0x400038f8 <uart_print_hex+0x48>
400038e8: 34000410     	cbz	w16, 0x40003968 <uart_print_hex+0xb8>
400038ec: b94b8171     	ldr	w17, [x11, #0xb80]
400038f0: 35000231     	cbnz	w17, 0x40003934 <uart_print_hex+0x84>
400038f4: 14000018     	b	0x40003954 <uart_print_hex+0xa4>
400038f8: b94b8171     	ldr	w17, [x11, #0xb80]
400038fc: 34000131     	cbz	w17, 0x40003920 <uart_print_hex+0x70>
40003900: b94b8531     	ldr	w17, [x9, #0xb84]
40003904: 6b0d023f     	cmp	w17, w13
40003908: 540000cc     	b.gt	0x40003920 <uart_print_hex+0x70>
4000390c: 93407e31     	sxtw	x17, w17
40003910: 91000632     	add	x18, x17, #0x1
40003914: 3831694e     	strb	w14, [x10, x17]
40003918: b90b8532     	str	w18, [x9, #0xb84]
4000391c: 3832695f     	strb	wzr, [x10, x18]
40003920: b9400111     	ldr	w17, [x8]
40003924: 372ffff1     	tbnz	w17, #0x5, 0x40003920 <uart_print_hex+0x70>
40003928: b90001ee     	str	w14, [x15]
4000392c: b94b8171     	ldr	w17, [x11, #0xb80]
40003930: 34000131     	cbz	w17, 0x40003954 <uart_print_hex+0xa4>
40003934: b94b8531     	ldr	w17, [x9, #0xb84]
40003938: 6b0d023f     	cmp	w17, w13
4000393c: 540000cc     	b.gt	0x40003954 <uart_print_hex+0xa4>
40003940: 93407e31     	sxtw	x17, w17
40003944: 91000632     	add	x18, x17, #0x1
40003948: 38316950     	strb	w16, [x10, x17]
4000394c: b90b8532     	str	w18, [x9, #0xb84]
40003950: 3832695f     	strb	wzr, [x10, x18]
40003954: 9100058c     	add	x12, x12, #0x1
40003958: b9400111     	ldr	w17, [x8]
4000395c: 372ffff1     	tbnz	w17, #0x5, 0x40003958 <uart_print_hex+0xa8>
40003960: b90001f0     	str	w16, [x15]
40003964: 17ffffde     	b	0x400038dc <uart_print_hex+0x2c>
40003968: 2a1f03ec     	mov	w12, wzr
4000396c: d503201f     	nop
40003970: 100259ed     	adr	x13, 0x400084ac <__rodata_start+0x4ac>
40003974: 5280078e     	mov	w14, #0x3c              // =60
40003978: 5287ffcf     	mov	w15, #0x3ffe            // =16382
4000397c: 52a12010     	mov	w16, #0x9000000         // =150994944
40003980: 14000003     	b	0x4000398c <uart_print_hex+0xdc>
40003984: b40002ee     	cbz	x14, 0x400039e0 <uart_print_hex+0x130>
40003988: d10011ce     	sub	x14, x14, #0x4
4000398c: 9ace2411     	lsr	x17, x0, x14
40003990: f2400e31     	ands	x17, x17, #0xf
40003994: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003998: 1a9f158c     	csinc	w12, w12, wzr, ne
4000399c: 34ffff4c     	cbz	w12, 0x40003984 <uart_print_hex+0xd4>
400039a0: b94b8172     	ldr	w18, [x11, #0xb80]
400039a4: 387169b1     	ldrb	w17, [x13, x17]
400039a8: 34000132     	cbz	w18, 0x400039cc <uart_print_hex+0x11c>
400039ac: b94b8532     	ldr	w18, [x9, #0xb84]
400039b0: 6b0f025f     	cmp	w18, w15
400039b4: 540000cc     	b.gt	0x400039cc <uart_print_hex+0x11c>
400039b8: 93407e52     	sxtw	x18, w18
400039bc: 91000641     	add	x1, x18, #0x1
400039c0: 38326951     	strb	w17, [x10, x18]
400039c4: b90b8521     	str	w1, [x9, #0xb84]
400039c8: 3821695f     	strb	wzr, [x10, x1]
400039cc: b9400112     	ldr	w18, [x8]
400039d0: 372ffff2     	tbnz	w18, #0x5, 0x400039cc <uart_print_hex+0x11c>
400039d4: b9000211     	str	w17, [x16]
400039d8: b5fffd8e     	cbnz	x14, 0x40003988 <uart_print_hex+0xd8>
400039dc: d65f03c0     	ret
400039e0: b94b816b     	ldr	w11, [x11, #0xb80]
400039e4: 3400016b     	cbz	w11, 0x40003a10 <uart_print_hex+0x160>
400039e8: b94b852b     	ldr	w11, [x9, #0xb84]
400039ec: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039f0: 6b0c017f     	cmp	w11, w12
400039f4: 540000ec     	b.gt	0x40003a10 <uart_print_hex+0x160>
400039f8: 93407d6b     	sxtw	x11, w11
400039fc: 5280060c     	mov	w12, #0x30              // =48
40003a00: 9100056d     	add	x13, x11, #0x1
40003a04: 382b694c     	strb	w12, [x10, x11]
40003a08: b90b852d     	str	w13, [x9, #0xb84]
40003a0c: 382d695f     	strb	wzr, [x10, x13]
40003a10: b9400109     	ldr	w9, [x8]
40003a14: 372fffe9     	tbnz	w9, #0x5, 0x40003a10 <uart_print_hex+0x160>
40003a18: 52a12008     	mov	w8, #0x9000000          // =150994944
40003a1c: 52800609     	mov	w9, #0x30               // =48
40003a20: b9000109     	str	w9, [x8]
40003a24: d65f03c0     	ret

0000000040003a28 <uart_print_dec>:
40003a28: d10083ff     	sub	sp, sp, #0x20
40003a2c: 52800308     	mov	w8, #0x18               // =24
40003a30: 72a12008     	movk	w8, #0x900, lsl #16
40003a34: b4000540     	cbz	x0, 0x40003adc <uart_print_dec+0xb4>
40003a38: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003a3c: aa1f03e9     	mov	x9, xzr
40003a40: 5280014b     	mov	w11, #0xa               // =10
40003a44: f29999aa     	movk	x10, #0xcccd
40003a48: 910023ec     	add	x12, sp, #0x8
40003a4c: 9bca7c0d     	umulh	x13, x0, x10
40003a50: f100241f     	cmp	x0, #0x9
40003a54: d343fdad     	lsr	x13, x13, #3
40003a58: 1b0b81ae     	msub	w14, w13, w11, w0
40003a5c: aa0d03e0     	mov	x0, x13
40003a60: 321c05ce     	orr	w14, w14, #0x30
40003a64: 3829698e     	strb	w14, [x12, x9]
40003a68: 91000529     	add	x9, x9, #0x1
40003a6c: 54ffff08     	b.hi	0x40003a4c <uart_print_dec+0x24>
40003a70: 910023ea     	add	x10, sp, #0x8
40003a74: b000006b     	adrp	x11, 0x40010000 <var_values+0x6a8>
40003a78: b000006c     	adrp	x12, 0x40010000 <var_values+0x6a8>
40003a7c: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a80: d503201f     	nop
40003a84: 1006882e     	adr	x14, 0x40010b88 <kernel_capture_buffer>
40003a88: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a8c: d1000530     	sub	x16, x9, #0x1
40003a90: b94b8172     	ldr	w18, [x11, #0xb80]
40003a94: 38706951     	ldrb	w17, [x10, x16]
40003a98: 34000132     	cbz	w18, 0x40003abc <uart_print_dec+0x94>
40003a9c: b94b8592     	ldr	w18, [x12, #0xb84]
40003aa0: 6b0d025f     	cmp	w18, w13
40003aa4: 540000cc     	b.gt	0x40003abc <uart_print_dec+0x94>
40003aa8: 93407e52     	sxtw	x18, w18
40003aac: 91000640     	add	x0, x18, #0x1
40003ab0: 383269d1     	strb	w17, [x14, x18]
40003ab4: b90b8580     	str	w0, [x12, #0xb84]
40003ab8: 382069df     	strb	wzr, [x14, x0]
40003abc: b9400112     	ldr	w18, [x8]
40003ac0: 372ffff2     	tbnz	w18, #0x5, 0x40003abc <uart_print_dec+0x94>
40003ac4: 7100053f     	cmp	w9, #0x1
40003ac8: aa1003e9     	mov	x9, x16
40003acc: b90001f1     	str	w17, [x15]
40003ad0: 54fffdec     	b.gt	0x40003a8c <uart_print_dec+0x64>
40003ad4: 910083ff     	add	sp, sp, #0x20
40003ad8: d65f03c0     	ret
40003adc: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
40003ae0: b94b8129     	ldr	w9, [x9, #0xb80]
40003ae4: 340001c9     	cbz	w9, 0x40003b1c <uart_print_dec+0xf4>
40003ae8: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a8>
40003aec: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003af0: b94b852a     	ldr	w10, [x9, #0xb84]
40003af4: 6b0b015f     	cmp	w10, w11
40003af8: 5400012c     	b.gt	0x40003b1c <uart_print_dec+0xf4>
40003afc: 93407d4a     	sxtw	x10, w10
40003b00: d503201f     	nop
40003b04: 1006842b     	adr	x11, 0x40010b88 <kernel_capture_buffer>
40003b08: 5280060c     	mov	w12, #0x30              // =48
40003b0c: 9100054d     	add	x13, x10, #0x1
40003b10: 382a696c     	strb	w12, [x11, x10]
40003b14: b90b852d     	str	w13, [x9, #0xb84]
40003b18: 382d697f     	strb	wzr, [x11, x13]
40003b1c: b9400109     	ldr	w9, [x8]
40003b20: 372fffe9     	tbnz	w9, #0x5, 0x40003b1c <uart_print_dec+0xf4>
40003b24: 52a12008     	mov	w8, #0x9000000          // =150994944
40003b28: 52800609     	mov	w9, #0x30               // =48
40003b2c: b9000109     	str	w9, [x8]
40003b30: 910083ff     	add	sp, sp, #0x20
40003b34: d65f03c0     	ret

0000000040003b38 <uart_printf>:
40003b38: d10343ff     	sub	sp, sp, #0xd0
40003b3c: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003b40: 9101c3fd     	add	x29, sp, #0x70
40003b44: 910003e8     	mov	x8, sp
40003b48: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003b4c: 52800315     	mov	w21, #0x18              // =24
40003b50: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003b54: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003b58: 72a12015     	movk	w21, #0x900, lsl #16
40003b5c: 128006e9     	mov	w9, #-0x38              // =-56
40003b60: a90967fa     	stp	x26, x25, [sp, #0x90]
40003b64: 9100e108     	add	x8, x8, #0x38
40003b68: 910183aa     	add	x10, x29, #0x60
40003b6c: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003b70: b0000076     	adrp	x22, 0x40010000 <var_values+0x6a8>
40003b74: b0000077     	adrp	x23, 0x40010000 <var_values+0x6a8>
40003b78: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003b7c: aa0003f3     	mov	x19, x0
40003b80: aa1f03f4     	mov	x20, xzr
40003b84: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003b88: d503201f     	nop
40003b8c: 10067ff9     	adr	x25, 0x40010b88 <kernel_capture_buffer>
40003b90: 528001ba     	mov	w26, #0xd               // =13
40003b94: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b98: 528004ae     	mov	w14, #0x25              // =37
40003b9c: f29999af     	movk	x15, #0xcccd
40003ba0: 52800150     	mov	w16, #0xa               // =10
40003ba4: d10063bc     	sub	x28, x29, #0x18
40003ba8: d503201f     	nop
40003bac: 10024811     	adr	x17, 0x400084ac <__rodata_start+0x4ac>
40003bb0: a9000be1     	stp	x1, x2, [sp]
40003bb4: a90113e3     	stp	x3, x4, [sp, #0x10]
40003bb8: a9021be5     	stp	x5, x6, [sp, #0x20]
40003bbc: f9002be9     	str	x9, [sp, #0x50]
40003bc0: f90023e8     	str	x8, [sp, #0x40]
40003bc4: a9032be7     	stp	x7, x10, [sp, #0x30]
40003bc8: 14000004     	b	0x40003bd8 <uart_printf+0xa0>
40003bcc: 52800608     	mov	w8, #0x30               // =48
40003bd0: b9000368     	str	w8, [x27]
40003bd4: 91000694     	add	x20, x20, #0x1
40003bd8: 38746a68     	ldrb	w8, [x19, x20]
40003bdc: 7100291f     	cmp	w8, #0xa
40003be0: 54000440     	b.eq	0x40003c68 <uart_printf+0x130>
40003be4: 7100951f     	cmp	w8, #0x25
40003be8: 540000a0     	b.eq	0x40003bfc <uart_printf+0xc4>
40003bec: 34003ae8     	cbz	w8, 0x40004348 <uart_printf+0x810>
40003bf0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003bf4: 350005a9     	cbnz	w9, 0x40003ca8 <uart_printf+0x170>
40003bf8: 14000034     	b	0x40003cc8 <uart_printf+0x190>
40003bfc: 9100068a     	add	x10, x20, #0x1
40003c00: 386a6a68     	ldrb	w8, [x19, x10]
40003c04: 7101b11f     	cmp	w8, #0x6c
40003c08: 54000661     	b.ne	0x40003cd4 <uart_printf+0x19c>
40003c0c: 91000a89     	add	x9, x20, #0x2
40003c10: 91000e8b     	add	x11, x20, #0x3
40003c14: 38696a6a     	ldrb	w10, [x19, x9]
40003c18: 7101b15f     	cmp	w10, #0x6c
40003c1c: 9a890174     	csel	x20, x11, x9, eq
40003c20: 38746a69     	ldrb	w9, [x19, x20]
40003c24: 7101bd3f     	cmp	w9, #0x6f
40003c28: 540005ed     	b.le	0x40003ce4 <uart_printf+0x1ac>
40003c2c: 7101d13f     	cmp	w9, #0x74
40003c30: 5400080c     	b.gt	0x40003d30 <uart_printf+0x1f8>
40003c34: 7101c13f     	cmp	w9, #0x70
40003c38: 54000f00     	b.eq	0x40003e18 <uart_printf+0x2e0>
40003c3c: 7101cd3f     	cmp	w9, #0x73
40003c40: 54000b61     	b.ne	0x40003dac <uart_printf+0x274>
40003c44: b98053e8     	ldrsw	x8, [sp, #0x50]
40003c48: 36f81408     	tbz	w8, #0x1f, 0x40003ec8 <uart_printf+0x390>
40003c4c: 11002109     	add	w9, w8, #0x8
40003c50: 3100211f     	cmn	w8, #0x8
40003c54: b90053e9     	str	w9, [sp, #0x50]
40003c58: 54001388     	b.hi	0x40003ec8 <uart_printf+0x390>
40003c5c: f94023e9     	ldr	x9, [sp, #0x40]
40003c60: 8b080128     	add	x8, x9, x8
40003c64: 1400009c     	b	0x40003ed4 <uart_printf+0x39c>
40003c68: b94b82c8     	ldr	w8, [x22, #0xb80]
40003c6c: 34000128     	cbz	w8, 0x40003c90 <uart_printf+0x158>
40003c70: b94b86e8     	ldr	w8, [x23, #0xb84]
40003c74: 6b18011f     	cmp	w8, w24
40003c78: 540000cc     	b.gt	0x40003c90 <uart_printf+0x158>
40003c7c: 93407d08     	sxtw	x8, w8
40003c80: 91000509     	add	x9, x8, #0x1
40003c84: 38286b3a     	strb	w26, [x25, x8]
40003c88: b90b86e9     	str	w9, [x23, #0xb84]
40003c8c: 38296b3f     	strb	wzr, [x25, x9]
40003c90: b94002a8     	ldr	w8, [x21]
40003c94: 372fffe8     	tbnz	w8, #0x5, 0x40003c90 <uart_printf+0x158>
40003c98: b900037a     	str	w26, [x27]
40003c9c: 38746a68     	ldrb	w8, [x19, x20]
40003ca0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003ca4: 34000129     	cbz	w9, 0x40003cc8 <uart_printf+0x190>
40003ca8: b94b86e9     	ldr	w9, [x23, #0xb84]
40003cac: 6b18013f     	cmp	w9, w24
40003cb0: 540000cc     	b.gt	0x40003cc8 <uart_printf+0x190>
40003cb4: 93407d29     	sxtw	x9, w9
40003cb8: 9100052a     	add	x10, x9, #0x1
40003cbc: 38296b28     	strb	w8, [x25, x9]
40003cc0: b90b86ea     	str	w10, [x23, #0xb84]
40003cc4: 382a6b3f     	strb	wzr, [x25, x10]
40003cc8: b94002a9     	ldr	w9, [x21]
40003ccc: 372fffe9     	tbnz	w9, #0x5, 0x40003cc8 <uart_printf+0x190>
40003cd0: 17ffffc0     	b	0x40003bd0 <uart_printf+0x98>
40003cd4: 2a0803e9     	mov	w9, w8
40003cd8: aa0a03f4     	mov	x20, x10
40003cdc: 7101bd3f     	cmp	w9, #0x6f
40003ce0: 54fffa6c     	b.gt	0x40003c2c <uart_printf+0xf4>
40003ce4: 7100953f     	cmp	w9, #0x25
40003ce8: 54000440     	b.eq	0x40003d70 <uart_printf+0x238>
40003cec: 71018d3f     	cmp	w9, #0x63
40003cf0: 54000c00     	b.eq	0x40003e70 <uart_printf+0x338>
40003cf4: 7101913f     	cmp	w9, #0x64
40003cf8: 540005a1     	b.ne	0x40003dac <uart_printf+0x274>
40003cfc: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d00: 7101b11f     	cmp	w8, #0x6c
40003d04: 540017c1     	b.ne	0x40003ffc <uart_printf+0x4c4>
40003d08: 36f823c9     	tbz	w9, #0x1f, 0x40004180 <uart_printf+0x648>
40003d0c: 11002128     	add	w8, w9, #0x8
40003d10: 3100213f     	cmn	w9, #0x8
40003d14: b90053e8     	str	w8, [sp, #0x50]
40003d18: 54002348     	b.hi	0x40004180 <uart_printf+0x648>
40003d1c: f94023e8     	ldr	x8, [sp, #0x40]
40003d20: 8b090108     	add	x8, x8, x9
40003d24: f9400108     	ldr	x8, [x8]
40003d28: b6f829a8     	tbz	x8, #0x3f, 0x4000425c <uart_printf+0x724>
40003d2c: 1400011a     	b	0x40004194 <uart_printf+0x65c>
40003d30: 7101d53f     	cmp	w9, #0x75
40003d34: 54000840     	b.eq	0x40003e3c <uart_printf+0x304>
40003d38: 7101e13f     	cmp	w9, #0x78
40003d3c: 54000381     	b.ne	0x40003dac <uart_printf+0x274>
40003d40: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d44: 7101b11f     	cmp	w8, #0x6c
40003d48: 540014a1     	b.ne	0x40003fdc <uart_printf+0x4a4>
40003d4c: 36f81d49     	tbz	w9, #0x1f, 0x400040f4 <uart_printf+0x5bc>
40003d50: 11002128     	add	w8, w9, #0x8
40003d54: 3100213f     	cmn	w9, #0x8
40003d58: b90053e8     	str	w8, [sp, #0x50]
40003d5c: 54001cc8     	b.hi	0x400040f4 <uart_printf+0x5bc>
40003d60: f94023e8     	ldr	x8, [sp, #0x40]
40003d64: 8b090108     	add	x8, x8, x9
40003d68: f9400108     	ldr	x8, [x8]
40003d6c: 140000eb     	b	0x40004118 <uart_printf+0x5e0>
40003d70: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d74: 34000128     	cbz	w8, 0x40003d98 <uart_printf+0x260>
40003d78: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d7c: 6b18011f     	cmp	w8, w24
40003d80: 540000cc     	b.gt	0x40003d98 <uart_printf+0x260>
40003d84: 93407d08     	sxtw	x8, w8
40003d88: 91000509     	add	x9, x8, #0x1
40003d8c: 38286b2e     	strb	w14, [x25, x8]
40003d90: b90b86e9     	str	w9, [x23, #0xb84]
40003d94: 38296b3f     	strb	wzr, [x25, x9]
40003d98: b94002a8     	ldr	w8, [x21]
40003d9c: 372fffe8     	tbnz	w8, #0x5, 0x40003d98 <uart_printf+0x260>
40003da0: b900036e     	str	w14, [x27]
40003da4: 91000694     	add	x20, x20, #0x1
40003da8: 17ffff8c     	b	0x40003bd8 <uart_printf+0xa0>
40003dac: b94b82c8     	ldr	w8, [x22, #0xb80]
40003db0: 34000128     	cbz	w8, 0x40003dd4 <uart_printf+0x29c>
40003db4: b94b86e8     	ldr	w8, [x23, #0xb84]
40003db8: 6b18011f     	cmp	w8, w24
40003dbc: 540000cc     	b.gt	0x40003dd4 <uart_printf+0x29c>
40003dc0: 93407d08     	sxtw	x8, w8
40003dc4: 91000509     	add	x9, x8, #0x1
40003dc8: 38286b2e     	strb	w14, [x25, x8]
40003dcc: b90b86e9     	str	w9, [x23, #0xb84]
40003dd0: 38296b3f     	strb	wzr, [x25, x9]
40003dd4: b94002a8     	ldr	w8, [x21]
40003dd8: 372fffe8     	tbnz	w8, #0x5, 0x40003dd4 <uart_printf+0x29c>
40003ddc: b900036e     	str	w14, [x27]
40003de0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003de4: 38746a68     	ldrb	w8, [x19, x20]
40003de8: 34000129     	cbz	w9, 0x40003e0c <uart_printf+0x2d4>
40003dec: b94b86e9     	ldr	w9, [x23, #0xb84]
40003df0: 6b18013f     	cmp	w9, w24
40003df4: 540000cc     	b.gt	0x40003e0c <uart_printf+0x2d4>
40003df8: 93407d29     	sxtw	x9, w9
40003dfc: 9100052a     	add	x10, x9, #0x1
40003e00: 38296b28     	strb	w8, [x25, x9]
40003e04: b90b86ea     	str	w10, [x23, #0xb84]
40003e08: 382a6b3f     	strb	wzr, [x25, x10]
40003e0c: b94002a9     	ldr	w9, [x21]
40003e10: 372fffe9     	tbnz	w9, #0x5, 0x40003e0c <uart_printf+0x2d4>
40003e14: 17ffff6f     	b	0x40003bd0 <uart_printf+0x98>
40003e18: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e1c: 36f803c8     	tbz	w8, #0x1f, 0x40003e94 <uart_printf+0x35c>
40003e20: 11002109     	add	w9, w8, #0x8
40003e24: 3100211f     	cmn	w8, #0x8
40003e28: b90053e9     	str	w9, [sp, #0x50]
40003e2c: 54000348     	b.hi	0x40003e94 <uart_printf+0x35c>
40003e30: f94023e9     	ldr	x9, [sp, #0x40]
40003e34: 8b080128     	add	x8, x9, x8
40003e38: 1400001a     	b	0x40003ea0 <uart_printf+0x368>
40003e3c: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e40: 7101b11f     	cmp	w8, #0x6c
40003e44: 54000bc1     	b.ne	0x40003fbc <uart_printf+0x484>
40003e48: 36f80ea9     	tbz	w9, #0x1f, 0x4000401c <uart_printf+0x4e4>
40003e4c: 11002128     	add	w8, w9, #0x8
40003e50: 3100213f     	cmn	w9, #0x8
40003e54: b90053e8     	str	w8, [sp, #0x50]
40003e58: 54000e28     	b.hi	0x4000401c <uart_printf+0x4e4>
40003e5c: f94023e8     	ldr	x8, [sp, #0x40]
40003e60: 8b090108     	add	x8, x8, x9
40003e64: f9400109     	ldr	x9, [x8]
40003e68: b50010a9     	cbnz	x9, 0x4000407c <uart_printf+0x544>
40003e6c: 14000071     	b	0x40004030 <uart_printf+0x4f8>
40003e70: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e74: 36f80828     	tbz	w8, #0x1f, 0x40003f78 <uart_printf+0x440>
40003e78: 11002109     	add	w9, w8, #0x8
40003e7c: 3100211f     	cmn	w8, #0x8
40003e80: b90053e9     	str	w9, [sp, #0x50]
40003e84: 540007a8     	b.hi	0x40003f78 <uart_printf+0x440>
40003e88: f94023e9     	ldr	x9, [sp, #0x40]
40003e8c: 8b080128     	add	x8, x9, x8
40003e90: 1400003d     	b	0x40003f84 <uart_printf+0x44c>
40003e94: f9401fe8     	ldr	x8, [sp, #0x38]
40003e98: 91002109     	add	x9, x8, #0x8
40003e9c: f9001fe9     	str	x9, [sp, #0x38]
40003ea0: f9400100     	ldr	x0, [x8]
40003ea4: 97fffe83     	bl	0x400038b0 <uart_print_hex>
40003ea8: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003eac: 528004ae     	mov	w14, #0x25              // =37
40003eb0: 52800150     	mov	w16, #0xa               // =10
40003eb4: f29999af     	movk	x15, #0xcccd
40003eb8: d503201f     	nop
40003ebc: 10022f91     	adr	x17, 0x400084ac <__rodata_start+0x4ac>
40003ec0: 91000694     	add	x20, x20, #0x1
40003ec4: 17ffff45     	b	0x40003bd8 <uart_printf+0xa0>
40003ec8: f9401fe8     	ldr	x8, [sp, #0x38]
40003ecc: 91002109     	add	x9, x8, #0x8
40003ed0: f9001fe9     	str	x9, [sp, #0x38]
40003ed4: f9400108     	ldr	x8, [x8]
40003ed8: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x2000>
40003edc: 9124e529     	add	x9, x9, #0x939
40003ee0: f100011f     	cmp	x8, #0x0
40003ee4: 9a880128     	csel	x8, x9, x8, eq
40003ee8: 39400109     	ldrb	w9, [x8]
40003eec: 7100293f     	cmp	w9, #0xa
40003ef0: 540000a0     	b.eq	0x40003f04 <uart_printf+0x3cc>
40003ef4: 34ffe709     	cbz	w9, 0x40003bd4 <uart_printf+0x9c>
40003ef8: b94b82ca     	ldr	w10, [x22, #0xb80]
40003efc: 3500024a     	cbnz	w10, 0x40003f44 <uart_printf+0x40c>
40003f00: 14000019     	b	0x40003f64 <uart_printf+0x42c>
40003f04: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f08: 34000129     	cbz	w9, 0x40003f2c <uart_printf+0x3f4>
40003f0c: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f10: 6b18013f     	cmp	w9, w24
40003f14: 540000cc     	b.gt	0x40003f2c <uart_printf+0x3f4>
40003f18: 93407d29     	sxtw	x9, w9
40003f1c: 9100052a     	add	x10, x9, #0x1
40003f20: 38296b3a     	strb	w26, [x25, x9]
40003f24: b90b86ea     	str	w10, [x23, #0xb84]
40003f28: 382a6b3f     	strb	wzr, [x25, x10]
40003f2c: b94002a9     	ldr	w9, [x21]
40003f30: 372fffe9     	tbnz	w9, #0x5, 0x40003f2c <uart_printf+0x3f4>
40003f34: b900037a     	str	w26, [x27]
40003f38: 39400109     	ldrb	w9, [x8]
40003f3c: b94b82ca     	ldr	w10, [x22, #0xb80]
40003f40: 3400012a     	cbz	w10, 0x40003f64 <uart_printf+0x42c>
40003f44: b94b86ea     	ldr	w10, [x23, #0xb84]
40003f48: 6b18015f     	cmp	w10, w24
40003f4c: 540000cc     	b.gt	0x40003f64 <uart_printf+0x42c>
40003f50: 93407d4a     	sxtw	x10, w10
40003f54: 9100054b     	add	x11, x10, #0x1
40003f58: 382a6b29     	strb	w9, [x25, x10]
40003f5c: b90b86eb     	str	w11, [x23, #0xb84]
40003f60: 382b6b3f     	strb	wzr, [x25, x11]
40003f64: 91000508     	add	x8, x8, #0x1
40003f68: b94002aa     	ldr	w10, [x21]
40003f6c: 372fffea     	tbnz	w10, #0x5, 0x40003f68 <uart_printf+0x430>
40003f70: b9000369     	str	w9, [x27]
40003f74: 17ffffdd     	b	0x40003ee8 <uart_printf+0x3b0>
40003f78: f9401fe8     	ldr	x8, [sp, #0x38]
40003f7c: 91002109     	add	x9, x8, #0x8
40003f80: f9001fe9     	str	x9, [sp, #0x38]
40003f84: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f88: 39400108     	ldrb	w8, [x8]
40003f8c: 34000129     	cbz	w9, 0x40003fb0 <uart_printf+0x478>
40003f90: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f94: 6b18013f     	cmp	w9, w24
40003f98: 540000cc     	b.gt	0x40003fb0 <uart_printf+0x478>
40003f9c: 93407d29     	sxtw	x9, w9
40003fa0: 9100052a     	add	x10, x9, #0x1
40003fa4: 38296b28     	strb	w8, [x25, x9]
40003fa8: b90b86ea     	str	w10, [x23, #0xb84]
40003fac: 382a6b3f     	strb	wzr, [x25, x10]
40003fb0: b94002a9     	ldr	w9, [x21]
40003fb4: 372fffe9     	tbnz	w9, #0x5, 0x40003fb0 <uart_printf+0x478>
40003fb8: 17ffff06     	b	0x40003bd0 <uart_printf+0x98>
40003fbc: 36f80569     	tbz	w9, #0x1f, 0x40004068 <uart_printf+0x530>
40003fc0: 11002128     	add	w8, w9, #0x8
40003fc4: 3100213f     	cmn	w9, #0x8
40003fc8: b90053e8     	str	w8, [sp, #0x50]
40003fcc: 540004e8     	b.hi	0x40004068 <uart_printf+0x530>
40003fd0: f94023e8     	ldr	x8, [sp, #0x40]
40003fd4: 8b090108     	add	x8, x8, x9
40003fd8: 14000027     	b	0x40004074 <uart_printf+0x53c>
40003fdc: 36f80969     	tbz	w9, #0x1f, 0x40004108 <uart_printf+0x5d0>
40003fe0: 11002128     	add	w8, w9, #0x8
40003fe4: 3100213f     	cmn	w9, #0x8
40003fe8: b90053e8     	str	w8, [sp, #0x50]
40003fec: 540008e8     	b.hi	0x40004108 <uart_printf+0x5d0>
40003ff0: f94023e8     	ldr	x8, [sp, #0x40]
40003ff4: 8b090108     	add	x8, x8, x9
40003ff8: 14000047     	b	0x40004114 <uart_printf+0x5dc>
40003ffc: 36f81269     	tbz	w9, #0x1f, 0x40004248 <uart_printf+0x710>
40004000: 11002128     	add	w8, w9, #0x8
40004004: 3100213f     	cmn	w9, #0x8
40004008: b90053e8     	str	w8, [sp, #0x50]
4000400c: 540011e8     	b.hi	0x40004248 <uart_printf+0x710>
40004010: f94023e8     	ldr	x8, [sp, #0x40]
40004014: 8b090108     	add	x8, x8, x9
40004018: 1400008f     	b	0x40004254 <uart_printf+0x71c>
4000401c: f9401fe8     	ldr	x8, [sp, #0x38]
40004020: 91002109     	add	x9, x8, #0x8
40004024: f9001fe9     	str	x9, [sp, #0x38]
40004028: f9400109     	ldr	x9, [x8]
4000402c: b5000289     	cbnz	x9, 0x4000407c <uart_printf+0x544>
40004030: b94b82c8     	ldr	w8, [x22, #0xb80]
40004034: 34000148     	cbz	w8, 0x4000405c <uart_printf+0x524>
40004038: b94b86e8     	ldr	w8, [x23, #0xb84]
4000403c: 6b18011f     	cmp	w8, w24
40004040: 540000ec     	b.gt	0x4000405c <uart_printf+0x524>
40004044: 93407d08     	sxtw	x8, w8
40004048: 5280060a     	mov	w10, #0x30              // =48
4000404c: 91000509     	add	x9, x8, #0x1
40004050: 38286b2a     	strb	w10, [x25, x8]
40004054: b90b86e9     	str	w9, [x23, #0xb84]
40004058: 38296b3f     	strb	wzr, [x25, x9]
4000405c: b94002a8     	ldr	w8, [x21]
40004060: 372fffe8     	tbnz	w8, #0x5, 0x4000405c <uart_printf+0x524>
40004064: 17fffeda     	b	0x40003bcc <uart_printf+0x94>
40004068: f9401fe8     	ldr	x8, [sp, #0x38]
4000406c: 91002109     	add	x9, x8, #0x8
40004070: f9001fe9     	str	x9, [sp, #0x38]
40004074: b9400109     	ldr	w9, [x8]
40004078: b4fffdc9     	cbz	x9, 0x40004030 <uart_printf+0x4f8>
4000407c: aa1f03ea     	mov	x10, xzr
40004080: 9bcf7d28     	umulh	x8, x9, x15
40004084: f100253f     	cmp	x9, #0x9
40004088: d343fd0b     	lsr	x11, x8, #3
4000408c: 91000548     	add	x8, x10, #0x1
40004090: 1b10a56c     	msub	w12, w11, w16, w9
40004094: 321c0589     	orr	w9, w12, #0x30
40004098: 382a6b89     	strb	w9, [x28, x10]
4000409c: aa0803ea     	mov	x10, x8
400040a0: aa0b03e9     	mov	x9, x11
400040a4: 54fffee8     	b.hi	0x40004080 <uart_printf+0x548>
400040a8: d1000509     	sub	x9, x8, #0x1
400040ac: b94b82cb     	ldr	w11, [x22, #0xb80]
400040b0: 38696b8a     	ldrb	w10, [x28, x9]
400040b4: 3400012b     	cbz	w11, 0x400040d8 <uart_printf+0x5a0>
400040b8: b94b86eb     	ldr	w11, [x23, #0xb84]
400040bc: 6b18017f     	cmp	w11, w24
400040c0: 540000cc     	b.gt	0x400040d8 <uart_printf+0x5a0>
400040c4: 93407d6b     	sxtw	x11, w11
400040c8: 9100056c     	add	x12, x11, #0x1
400040cc: 382b6b2a     	strb	w10, [x25, x11]
400040d0: b90b86ec     	str	w12, [x23, #0xb84]
400040d4: 382c6b3f     	strb	wzr, [x25, x12]
400040d8: b94002ab     	ldr	w11, [x21]
400040dc: 372fffeb     	tbnz	w11, #0x5, 0x400040d8 <uart_printf+0x5a0>
400040e0: 7100051f     	cmp	w8, #0x1
400040e4: aa0903e8     	mov	x8, x9
400040e8: b900036a     	str	w10, [x27]
400040ec: 54fffdec     	b.gt	0x400040a8 <uart_printf+0x570>
400040f0: 17fffeb9     	b	0x40003bd4 <uart_printf+0x9c>
400040f4: f9401fe8     	ldr	x8, [sp, #0x38]
400040f8: 91002109     	add	x9, x8, #0x8
400040fc: f9001fe9     	str	x9, [sp, #0x38]
40004100: f9400108     	ldr	x8, [x8]
40004104: 14000005     	b	0x40004118 <uart_printf+0x5e0>
40004108: f9401fe8     	ldr	x8, [sp, #0x38]
4000410c: 91002109     	add	x9, x8, #0x8
40004110: f9001fe9     	str	x9, [sp, #0x38]
40004114: b9400108     	ldr	w8, [x8]
40004118: 2a1f03e9     	mov	w9, wzr
4000411c: 5280078a     	mov	w10, #0x3c              // =60
40004120: 14000003     	b	0x4000412c <uart_printf+0x5f4>
40004124: b4000daa     	cbz	x10, 0x400042d8 <uart_printf+0x7a0>
40004128: d100114a     	sub	x10, x10, #0x4
4000412c: 9aca250b     	lsr	x11, x8, x10
40004130: f2400d6b     	ands	x11, x11, #0xf
40004134: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004138: 1a9f1529     	csinc	w9, w9, wzr, ne
4000413c: 34ffff49     	cbz	w9, 0x40004124 <uart_printf+0x5ec>
40004140: b94b82cc     	ldr	w12, [x22, #0xb80]
40004144: 386b6a2b     	ldrb	w11, [x17, x11]
40004148: 3400012c     	cbz	w12, 0x4000416c <uart_printf+0x634>
4000414c: b94b86ec     	ldr	w12, [x23, #0xb84]
40004150: 6b18019f     	cmp	w12, w24
40004154: 540000cc     	b.gt	0x4000416c <uart_printf+0x634>
40004158: 93407d8c     	sxtw	x12, w12
4000415c: 9100058d     	add	x13, x12, #0x1
40004160: 382c6b2b     	strb	w11, [x25, x12]
40004164: b90b86ed     	str	w13, [x23, #0xb84]
40004168: 382d6b3f     	strb	wzr, [x25, x13]
4000416c: b94002ac     	ldr	w12, [x21]
40004170: 372fffec     	tbnz	w12, #0x5, 0x4000416c <uart_printf+0x634>
40004174: b900036b     	str	w11, [x27]
40004178: b5fffd8a     	cbnz	x10, 0x40004128 <uart_printf+0x5f0>
4000417c: 17fffe96     	b	0x40003bd4 <uart_printf+0x9c>
40004180: f9401fe8     	ldr	x8, [sp, #0x38]
40004184: 91002109     	add	x9, x8, #0x8
40004188: f9001fe9     	str	x9, [sp, #0x38]
4000418c: f9400108     	ldr	x8, [x8]
40004190: b6f80668     	tbz	x8, #0x3f, 0x4000425c <uart_printf+0x724>
40004194: b94b82c9     	ldr	w9, [x22, #0xb80]
40004198: 34000149     	cbz	w9, 0x400041c0 <uart_printf+0x688>
4000419c: b94b86e9     	ldr	w9, [x23, #0xb84]
400041a0: 6b18013f     	cmp	w9, w24
400041a4: 540000ec     	b.gt	0x400041c0 <uart_printf+0x688>
400041a8: 93407d29     	sxtw	x9, w9
400041ac: 528005ab     	mov	w11, #0x2d              // =45
400041b0: 9100052a     	add	x10, x9, #0x1
400041b4: 38296b2b     	strb	w11, [x25, x9]
400041b8: b90b86ea     	str	w10, [x23, #0xb84]
400041bc: 382a6b3f     	strb	wzr, [x25, x10]
400041c0: b94002a9     	ldr	w9, [x21]
400041c4: 372fffe9     	tbnz	w9, #0x5, 0x400041c0 <uart_printf+0x688>
400041c8: aa1f03e9     	mov	x9, xzr
400041cc: 528005aa     	mov	w10, #0x2d              // =45
400041d0: cb0803e8     	neg	x8, x8
400041d4: b900036a     	str	w10, [x27]
400041d8: 9bcf7d0a     	umulh	x10, x8, x15
400041dc: f100251f     	cmp	x8, #0x9
400041e0: d343fd4a     	lsr	x10, x10, #3
400041e4: 1b10a14b     	msub	w11, w10, w16, w8
400041e8: 321c0568     	orr	w8, w11, #0x30
400041ec: 38296b88     	strb	w8, [x28, x9]
400041f0: 91000529     	add	x9, x9, #0x1
400041f4: aa0a03e8     	mov	x8, x10
400041f8: 54ffff08     	b.hi	0x400041d8 <uart_printf+0x6a0>
400041fc: d1000528     	sub	x8, x9, #0x1
40004200: b94b82cb     	ldr	w11, [x22, #0xb80]
40004204: 38686b8a     	ldrb	w10, [x28, x8]
40004208: 3400012b     	cbz	w11, 0x4000422c <uart_printf+0x6f4>
4000420c: b94b86eb     	ldr	w11, [x23, #0xb84]
40004210: 6b18017f     	cmp	w11, w24
40004214: 540000cc     	b.gt	0x4000422c <uart_printf+0x6f4>
40004218: 93407d6b     	sxtw	x11, w11
4000421c: 9100056c     	add	x12, x11, #0x1
40004220: 382b6b2a     	strb	w10, [x25, x11]
40004224: b90b86ec     	str	w12, [x23, #0xb84]
40004228: 382c6b3f     	strb	wzr, [x25, x12]
4000422c: b94002ab     	ldr	w11, [x21]
40004230: 372fffeb     	tbnz	w11, #0x5, 0x4000422c <uart_printf+0x6f4>
40004234: 7100053f     	cmp	w9, #0x1
40004238: aa0803e9     	mov	x9, x8
4000423c: b900036a     	str	w10, [x27]
40004240: 54fffdec     	b.gt	0x400041fc <uart_printf+0x6c4>
40004244: 17fffe64     	b	0x40003bd4 <uart_printf+0x9c>
40004248: f9401fe8     	ldr	x8, [sp, #0x38]
4000424c: 91002109     	add	x9, x8, #0x8
40004250: f9001fe9     	str	x9, [sp, #0x38]
40004254: b9800108     	ldrsw	x8, [x8]
40004258: b7fff9e8     	tbnz	x8, #0x3f, 0x40004194 <uart_printf+0x65c>
4000425c: b40005a8     	cbz	x8, 0x40004310 <uart_printf+0x7d8>
40004260: aa1f03ea     	mov	x10, xzr
40004264: 9bcf7d09     	umulh	x9, x8, x15
40004268: f100251f     	cmp	x8, #0x9
4000426c: d343fd2b     	lsr	x11, x9, #3
40004270: 91000549     	add	x9, x10, #0x1
40004274: 1b10a16c     	msub	w12, w11, w16, w8
40004278: 321c0588     	orr	w8, w12, #0x30
4000427c: 382a6b88     	strb	w8, [x28, x10]
40004280: aa0903ea     	mov	x10, x9
40004284: aa0b03e8     	mov	x8, x11
40004288: 54fffee8     	b.hi	0x40004264 <uart_printf+0x72c>
4000428c: d1000528     	sub	x8, x9, #0x1
40004290: b94b82cb     	ldr	w11, [x22, #0xb80]
40004294: 38686b8a     	ldrb	w10, [x28, x8]
40004298: 3400012b     	cbz	w11, 0x400042bc <uart_printf+0x784>
4000429c: b94b86eb     	ldr	w11, [x23, #0xb84]
400042a0: 6b18017f     	cmp	w11, w24
400042a4: 540000cc     	b.gt	0x400042bc <uart_printf+0x784>
400042a8: 93407d6b     	sxtw	x11, w11
400042ac: 9100056c     	add	x12, x11, #0x1
400042b0: 382b6b2a     	strb	w10, [x25, x11]
400042b4: b90b86ec     	str	w12, [x23, #0xb84]
400042b8: 382c6b3f     	strb	wzr, [x25, x12]
400042bc: b94002ab     	ldr	w11, [x21]
400042c0: 372fffeb     	tbnz	w11, #0x5, 0x400042bc <uart_printf+0x784>
400042c4: 7100053f     	cmp	w9, #0x1
400042c8: aa0803e9     	mov	x9, x8
400042cc: b900036a     	str	w10, [x27]
400042d0: 54fffdec     	b.gt	0x4000428c <uart_printf+0x754>
400042d4: 17fffe40     	b	0x40003bd4 <uart_printf+0x9c>
400042d8: b94b82c8     	ldr	w8, [x22, #0xb80]
400042dc: 34000148     	cbz	w8, 0x40004304 <uart_printf+0x7cc>
400042e0: b94b86e8     	ldr	w8, [x23, #0xb84]
400042e4: 6b18011f     	cmp	w8, w24
400042e8: 540000ec     	b.gt	0x40004304 <uart_printf+0x7cc>
400042ec: 93407d08     	sxtw	x8, w8
400042f0: 5280060a     	mov	w10, #0x30              // =48
400042f4: 91000509     	add	x9, x8, #0x1
400042f8: 38286b2a     	strb	w10, [x25, x8]
400042fc: b90b86e9     	str	w9, [x23, #0xb84]
40004300: 38296b3f     	strb	wzr, [x25, x9]
40004304: b94002a8     	ldr	w8, [x21]
40004308: 372fffe8     	tbnz	w8, #0x5, 0x40004304 <uart_printf+0x7cc>
4000430c: 17fffe30     	b	0x40003bcc <uart_printf+0x94>
40004310: b94b82c8     	ldr	w8, [x22, #0xb80]
40004314: 34000148     	cbz	w8, 0x4000433c <uart_printf+0x804>
40004318: b94b86e8     	ldr	w8, [x23, #0xb84]
4000431c: 6b18011f     	cmp	w8, w24
40004320: 540000ec     	b.gt	0x4000433c <uart_printf+0x804>
40004324: 93407d08     	sxtw	x8, w8
40004328: 5280060a     	mov	w10, #0x30              // =48
4000432c: 91000509     	add	x9, x8, #0x1
40004330: 38286b2a     	strb	w10, [x25, x8]
40004334: b90b86e9     	str	w9, [x23, #0xb84]
40004338: 38296b3f     	strb	wzr, [x25, x9]
4000433c: b94002a8     	ldr	w8, [x21]
40004340: 372fffe8     	tbnz	w8, #0x5, 0x4000433c <uart_printf+0x804>
40004344: 17fffe22     	b	0x40003bcc <uart_printf+0x94>
40004348: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
4000434c: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004350: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004354: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004358: a9486ffc     	ldp	x28, x27, [sp, #0x80]
4000435c: a9477bfd     	ldp	x29, x30, [sp, #0x70]
40004360: 910343ff     	add	sp, sp, #0xd0
40004364: d65f03c0     	ret

0000000040004368 <vfs_init>:
40004368: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
4000436c: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004370: 90000093     	adrp	x19, 0x40014000 <kernel_capture_buffer+0x3478>
40004374: 912e8273     	add	x19, x19, #0xba0
40004378: f9000bf9     	str	x25, [sp, #0x10]
4000437c: 90000099     	adrp	x25, 0x40014000 <kernel_capture_buffer+0x3478>
40004380: 52800034     	mov	w20, #0x1               // =1
40004384: aa1303e0     	mov	x0, x19
40004388: 2a1f03e1     	mov	w1, wzr
4000438c: 52809802     	mov	w2, #0x4c0              // =1216
40004390: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004394: 910003fd     	mov	x29, sp
40004398: a90357f6     	stp	x22, x21, [sp, #0x30]
4000439c: b90b8b34     	str	w20, [x25, #0xb88]
400043a0: 97fff981     	bl	0x400029a4 <memset>
400043a4: 528005e8     	mov	w8, #0x2f               // =47
400043a8: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
400043ac: b9002274     	str	w20, [x19, #0x20]
400043b0: 79000268     	strh	w8, [x19]
400043b4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400043b8: f905c933     	str	x19, [x9, #0xb90]
400043bc: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
400043c0: 7101fd1f     	cmp	w8, #0x7f
400043c4: f9021a7f     	str	xzr, [x19, #0x430]
400043c8: f900167f     	str	xzr, [x19, #0x28]
400043cc: b904ba7f     	str	wzr, [x19, #0x4b8]
400043d0: f905cd33     	str	x19, [x9, #0xb98]
400043d4: 540028ac     	b.gt	0x400048e8 <vfs_init+0x580>
400043d8: 52809809     	mov	w9, #0x4c0              // =1216
400043dc: 2a1f03e1     	mov	w1, wzr
400043e0: 52809802     	mov	w2, #0x4c0              // =1216
400043e4: 9b294d17     	smaddl	x23, w8, w9, x19
400043e8: 11000508     	add	w8, w8, #0x1
400043ec: b90b8b28     	str	w8, [x25, #0xb88]
400043f0: aa1703e0     	mov	x0, x23
400043f4: 97fff96c     	bl	0x400029a4 <memset>
400043f8: 528d2c48     	mov	w8, #0x6962             // =26978
400043fc: b904baff     	str	wzr, [x23, #0x4b8]
40004400: 72a00dc8     	movk	w8, #0x6e, lsl #16
40004404: b90022f4     	str	w20, [x23, #0x20]
40004408: b90002e8     	str	w8, [x23]
4000440c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004410: f9021af3     	str	x19, [x23, #0x430]
40004414: 71003d1f     	cmp	w8, #0xf
40004418: f90016ff     	str	xzr, [x23, #0x28]
4000441c: 540000ac     	b.gt	0x40004430 <vfs_init+0xc8>
40004420: 11000509     	add	w9, w8, #0x1
40004424: 8b080e68     	add	x8, x19, x8, lsl #3
40004428: b904ba69     	str	w9, [x19, #0x4b8]
4000442c: f9021d17     	str	x23, [x8, #0x438]
40004430: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004434: 7101fd1f     	cmp	w8, #0x7f
40004438: 5400258c     	b.gt	0x400048e8 <vfs_init+0x580>
4000443c: 52809809     	mov	w9, #0x4c0              // =1216
40004440: 2a1f03e1     	mov	w1, wzr
40004444: 52809802     	mov	w2, #0x4c0              // =1216
40004448: 9b294d16     	smaddl	x22, w8, w9, x19
4000444c: 11000508     	add	w8, w8, #0x1
40004450: b90b8b28     	str	w8, [x25, #0xb88]
40004454: aa1603e0     	mov	x0, x22
40004458: 97fff953     	bl	0x400029a4 <memset>
4000445c: 528e8ca8     	mov	w8, #0x7465             // =29797
40004460: b904badf     	str	wzr, [x22, #0x4b8]
40004464: 52800029     	mov	w9, #0x1                // =1
40004468: 72a00c68     	movk	w8, #0x63, lsl #16
4000446c: b90022c9     	str	w9, [x22, #0x20]
40004470: b90002c8     	str	w8, [x22]
40004474: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004478: f9021ad3     	str	x19, [x22, #0x430]
4000447c: 71003d1f     	cmp	w8, #0xf
40004480: f90016df     	str	xzr, [x22, #0x28]
40004484: 540000ac     	b.gt	0x40004498 <vfs_init+0x130>
40004488: 11000509     	add	w9, w8, #0x1
4000448c: 8b080e68     	add	x8, x19, x8, lsl #3
40004490: b904ba69     	str	w9, [x19, #0x4b8]
40004494: f9021d16     	str	x22, [x8, #0x438]
40004498: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000449c: 7101fd1f     	cmp	w8, #0x7f
400044a0: 5400224c     	b.gt	0x400048e8 <vfs_init+0x580>
400044a4: 52809809     	mov	w9, #0x4c0              // =1216
400044a8: 2a1f03e1     	mov	w1, wzr
400044ac: 52809802     	mov	w2, #0x4c0              // =1216
400044b0: 9b294d14     	smaddl	x20, w8, w9, x19
400044b4: 11000508     	add	w8, w8, #0x1
400044b8: b90b8b28     	str	w8, [x25, #0xb88]
400044bc: aa1403e0     	mov	x0, x20
400044c0: 97fff939     	bl	0x400029a4 <memset>
400044c4: 528ded08     	mov	w8, #0x6f68             // =28520
400044c8: b904ba9f     	str	wzr, [x20, #0x4b8]
400044cc: 52800029     	mov	w9, #0x1                // =1
400044d0: 72acada8     	movk	w8, #0x656d, lsl #16
400044d4: 3900129f     	strb	wzr, [x20, #0x4]
400044d8: b9000288     	str	w8, [x20]
400044dc: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400044e0: b9002289     	str	w9, [x20, #0x20]
400044e4: 71003d1f     	cmp	w8, #0xf
400044e8: f9021a93     	str	x19, [x20, #0x430]
400044ec: f900169f     	str	xzr, [x20, #0x28]
400044f0: 540000ac     	b.gt	0x40004504 <vfs_init+0x19c>
400044f4: 11000509     	add	w9, w8, #0x1
400044f8: 8b080e68     	add	x8, x19, x8, lsl #3
400044fc: b904ba69     	str	w9, [x19, #0x4b8]
40004500: f9021d14     	str	x20, [x8, #0x438]
40004504: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004508: 7101fd1f     	cmp	w8, #0x7f
4000450c: 54001eec     	b.gt	0x400048e8 <vfs_init+0x580>
40004510: 52809809     	mov	w9, #0x4c0              // =1216
40004514: 2a1f03e1     	mov	w1, wzr
40004518: 52809802     	mov	w2, #0x4c0              // =1216
4000451c: 9b294d15     	smaddl	x21, w8, w9, x19
40004520: 11000508     	add	w8, w8, #0x1
40004524: b90b8b28     	str	w8, [x25, #0xb88]
40004528: aa1503e0     	mov	x0, x21
4000452c: 97fff91e     	bl	0x400029a4 <memset>
40004530: 528dec88     	mov	w8, #0x6f64             // =28516
40004534: b904babf     	str	wzr, [x21, #0x4b8]
40004538: 52800029     	mov	w9, #0x1                // =1
4000453c: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004540: 390012bf     	strb	wzr, [x21, #0x4]
40004544: b90002a8     	str	w8, [x21]
40004548: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000454c: b90022a9     	str	w9, [x21, #0x20]
40004550: 71003d1f     	cmp	w8, #0xf
40004554: f9021ab3     	str	x19, [x21, #0x430]
40004558: f90016bf     	str	xzr, [x21, #0x28]
4000455c: 540000ac     	b.gt	0x40004570 <vfs_init+0x208>
40004560: 11000509     	add	w9, w8, #0x1
40004564: 8b080e68     	add	x8, x19, x8, lsl #3
40004568: b904ba69     	str	w9, [x19, #0x4b8]
4000456c: f9021d15     	str	x21, [x8, #0x438]
40004570: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004574: 7101fd1f     	cmp	w8, #0x7f
40004578: 54001b8c     	b.gt	0x400048e8 <vfs_init+0x580>
4000457c: 52809809     	mov	w9, #0x4c0              // =1216
40004580: 2a1f03e1     	mov	w1, wzr
40004584: 52809802     	mov	w2, #0x4c0              // =1216
40004588: 9b294d18     	smaddl	x24, w8, w9, x19
4000458c: 11000508     	add	w8, w8, #0x1
40004590: b90b8b28     	str	w8, [x25, #0xb88]
40004594: aa1803e0     	mov	x0, x24
40004598: 97fff903     	bl	0x400029a4 <memset>
4000459c: 528d2c28     	mov	w8, #0x6961             // =26977
400045a0: b904bb1f     	str	wzr, [x24, #0x4b8]
400045a4: 79000308     	strh	w8, [x24]
400045a8: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400045ac: 39000b1f     	strb	wzr, [x24, #0x2]
400045b0: 71003d1f     	cmp	w8, #0xf
400045b4: b900231f     	str	wzr, [x24, #0x20]
400045b8: f9021b17     	str	x23, [x24, #0x430]
400045bc: f900171f     	str	xzr, [x24, #0x28]
400045c0: 540000ac     	b.gt	0x400045d4 <vfs_init+0x26c>
400045c4: 8b080ee9     	add	x9, x23, x8, lsl #3
400045c8: 11000508     	add	w8, w8, #0x1
400045cc: b904bae8     	str	w8, [x23, #0x4b8]
400045d0: f9021d38     	str	x24, [x9, #0x438]
400045d4: d503201f     	nop
400045d8: 300311f7     	adr	x23, 0x4000a815 <__rodata_start+0x2815>
400045dc: 9100c300     	add	x0, x24, #0x30
400045e0: aa1703e1     	mov	x1, x23
400045e4: 97fff8c4     	bl	0x400028f4 <kstrcpy>
400045e8: aa1703e0     	mov	x0, x23
400045ec: 97fff893     	bl	0x40002838 <kstrlen>
400045f0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045f4: f9001700     	str	x0, [x24, #0x28]
400045f8: 7101fd1f     	cmp	w8, #0x7f
400045fc: 5400176c     	b.gt	0x400048e8 <vfs_init+0x580>
40004600: 52809809     	mov	w9, #0x4c0              // =1216
40004604: 2a1f03e1     	mov	w1, wzr
40004608: 52809802     	mov	w2, #0x4c0              // =1216
4000460c: 9b294d17     	smaddl	x23, w8, w9, x19
40004610: 11000508     	add	w8, w8, #0x1
40004614: b90b8b28     	str	w8, [x25, #0xb88]
40004618: aa1703e0     	mov	x0, x23
4000461c: 97fff8e2     	bl	0x400029a4 <memset>
40004620: d28e6de8     	mov	x8, #0x736f             // =29551
40004624: b904baff     	str	wzr, [x23, #0x4b8]
40004628: 528cae69     	mov	w9, #0x6573             // =25971
4000462c: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004630: 790012e9     	strh	w9, [x23, #0x8]
40004634: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
40004638: 39002aff     	strb	wzr, [x23, #0xa]
4000463c: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004640: b90022ff     	str	wzr, [x23, #0x20]
40004644: f90002e8     	str	x8, [x23]
40004648: b984bac8     	ldrsw	x8, [x22, #0x4b8]
4000464c: f9021af6     	str	x22, [x23, #0x430]
40004650: 71003d1f     	cmp	w8, #0xf
40004654: f90016ff     	str	xzr, [x23, #0x28]
40004658: 540000ac     	b.gt	0x4000466c <vfs_init+0x304>
4000465c: 8b080ec9     	add	x9, x22, x8, lsl #3
40004660: 11000508     	add	w8, w8, #0x1
40004664: b904bac8     	str	w8, [x22, #0x4b8]
40004668: f9021d37     	str	x23, [x9, #0x438]
4000466c: 90000036     	adrp	x22, 0x40008000 <__rodata_start>
40004670: 91389ad6     	add	x22, x22, #0xe26
40004674: 9100c2e0     	add	x0, x23, #0x30
40004678: aa1603e1     	mov	x1, x22
4000467c: 97fff89e     	bl	0x400028f4 <kstrcpy>
40004680: aa1603e0     	mov	x0, x22
40004684: 97fff86d     	bl	0x40002838 <kstrlen>
40004688: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000468c: f90016e0     	str	x0, [x23, #0x28]
40004690: 7101fd1f     	cmp	w8, #0x7f
40004694: 540012ac     	b.gt	0x400048e8 <vfs_init+0x580>
40004698: 52809809     	mov	w9, #0x4c0              // =1216
4000469c: 2a1f03e1     	mov	w1, wzr
400046a0: 52809802     	mov	w2, #0x4c0              // =1216
400046a4: 9b294d16     	smaddl	x22, w8, w9, x19
400046a8: 11000508     	add	w8, w8, #0x1
400046ac: b90b8b28     	str	w8, [x25, #0xb88]
400046b0: aa1603e0     	mov	x0, x22
400046b4: 97fff8bc     	bl	0x400029a4 <memset>
400046b8: d28caee8     	mov	x8, #0x6577             // =25975
400046bc: b904badf     	str	wzr, [x22, #0x4b8]
400046c0: 528f0e89     	mov	w9, #0x7874             // =30836
400046c4: f2ac6d88     	movk	x8, #0x636c, lsl #16
400046c8: 72a00e89     	movk	w9, #0x74, lsl #16
400046cc: b90022df     	str	wzr, [x22, #0x20]
400046d0: f2cdade8     	movk	x8, #0x6d6f, lsl #32
400046d4: b9000ac9     	str	w9, [x22, #0x8]
400046d8: f2e5cca8     	movk	x8, #0x2e65, lsl #48
400046dc: f9021ad5     	str	x21, [x22, #0x430]
400046e0: f90002c8     	str	x8, [x22]
400046e4: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400046e8: f90016df     	str	xzr, [x22, #0x28]
400046ec: 71003d1f     	cmp	w8, #0xf
400046f0: 540000ac     	b.gt	0x40004704 <vfs_init+0x39c>
400046f4: 8b080ea9     	add	x9, x21, x8, lsl #3
400046f8: 11000508     	add	w8, w8, #0x1
400046fc: b904baa8     	str	w8, [x21, #0x4b8]
40004700: f9021d36     	str	x22, [x9, #0x438]
40004704: 90000037     	adrp	x23, 0x40008000 <__rodata_start>
40004708: 913f2ef7     	add	x23, x23, #0xfcb
4000470c: 9100c2c0     	add	x0, x22, #0x30
40004710: aa1703e1     	mov	x1, x23
40004714: 97fff878     	bl	0x400028f4 <kstrcpy>
40004718: aa1703e0     	mov	x0, x23
4000471c: 97fff847     	bl	0x40002838 <kstrlen>
40004720: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004724: f90016c0     	str	x0, [x22, #0x28]
40004728: 7101fd1f     	cmp	w8, #0x7f
4000472c: 54000dec     	b.gt	0x400048e8 <vfs_init+0x580>
40004730: 52809809     	mov	w9, #0x4c0              // =1216
40004734: 2a1f03e1     	mov	w1, wzr
40004738: 52809802     	mov	w2, #0x4c0              // =1216
4000473c: 9b294d16     	smaddl	x22, w8, w9, x19
40004740: 11000508     	add	w8, w8, #0x1
40004744: b90b8b28     	str	w8, [x25, #0xb88]
40004748: aa1603e0     	mov	x0, x22
4000474c: 97fff896     	bl	0x400029a4 <memset>
40004750: d28c2d08     	mov	x8, #0x6168             // =24936
40004754: b904badf     	str	wzr, [x22, #0x4b8]
40004758: 528e85c9     	mov	w9, #0x742e             // =29742
4000475c: f2ac8e48     	movk	x8, #0x6472, lsl #16
40004760: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004764: 390032df     	strb	wzr, [x22, #0xc]
40004768: f2cc2ee8     	movk	x8, #0x6177, lsl #32
4000476c: b9000ac9     	str	w9, [x22, #0x8]
40004770: f2ecae48     	movk	x8, #0x6572, lsl #48
40004774: b90022df     	str	wzr, [x22, #0x20]
40004778: f90002c8     	str	x8, [x22]
4000477c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004780: f9021ad5     	str	x21, [x22, #0x430]
40004784: 71003d1f     	cmp	w8, #0xf
40004788: f90016df     	str	xzr, [x22, #0x28]
4000478c: 540000ac     	b.gt	0x400047a0 <vfs_init+0x438>
40004790: 8b080ea9     	add	x9, x21, x8, lsl #3
40004794: 11000508     	add	w8, w8, #0x1
40004798: b904baa8     	str	w8, [x21, #0x4b8]
4000479c: f9021d36     	str	x22, [x9, #0x438]
400047a0: b0000037     	adrp	x23, 0x40009000 <__rodata_start+0x1000>
400047a4: 910e12f7     	add	x23, x23, #0x384
400047a8: 9100c2c0     	add	x0, x22, #0x30
400047ac: aa1703e1     	mov	x1, x23
400047b0: 97fff851     	bl	0x400028f4 <kstrcpy>
400047b4: aa1703e0     	mov	x0, x23
400047b8: 97fff820     	bl	0x40002838 <kstrlen>
400047bc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047c0: f90016c0     	str	x0, [x22, #0x28]
400047c4: 7101fd1f     	cmp	w8, #0x7f
400047c8: 5400090c     	b.gt	0x400048e8 <vfs_init+0x580>
400047cc: 52809809     	mov	w9, #0x4c0              // =1216
400047d0: 2a1f03e1     	mov	w1, wzr
400047d4: 52809802     	mov	w2, #0x4c0              // =1216
400047d8: 9b294d16     	smaddl	x22, w8, w9, x19
400047dc: 11000508     	add	w8, w8, #0x1
400047e0: b90b8b28     	str	w8, [x25, #0xb88]
400047e4: aa1603e0     	mov	x0, x22
400047e8: 97fff86f     	bl	0x400029a4 <memset>
400047ec: 528d2c28     	mov	w8, #0x6961             // =26977
400047f0: b904badf     	str	wzr, [x22, #0x4b8]
400047f4: 528e8f09     	mov	w9, #0x7478             // =29816
400047f8: 72ae85c8     	movk	w8, #0x742e, lsl #16
400047fc: 79000ac9     	strh	w9, [x22, #0x4]
40004800: b90002c8     	str	w8, [x22]
40004804: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004808: 39001adf     	strb	wzr, [x22, #0x6]
4000480c: 71003d1f     	cmp	w8, #0xf
40004810: b90022df     	str	wzr, [x22, #0x20]
40004814: f9021ad5     	str	x21, [x22, #0x430]
40004818: f90016df     	str	xzr, [x22, #0x28]
4000481c: 540000ac     	b.gt	0x40004830 <vfs_init+0x4c8>
40004820: 8b080ea9     	add	x9, x21, x8, lsl #3
40004824: 11000508     	add	w8, w8, #0x1
40004828: b904baa8     	str	w8, [x21, #0x4b8]
4000482c: f9021d36     	str	x22, [x9, #0x438]
40004830: d0000035     	adrp	x21, 0x4000a000 <__rodata_start+0x2000>
40004834: 911476b5     	add	x21, x21, #0x51d
40004838: 9100c2c0     	add	x0, x22, #0x30
4000483c: aa1503e1     	mov	x1, x21
40004840: 97fff82d     	bl	0x400028f4 <kstrcpy>
40004844: aa1503e0     	mov	x0, x21
40004848: 97fff7fc     	bl	0x40002838 <kstrlen>
4000484c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004850: f90016c0     	str	x0, [x22, #0x28]
40004854: 7101fd1f     	cmp	w8, #0x7f
40004858: 5400048c     	b.gt	0x400048e8 <vfs_init+0x580>
4000485c: 52809809     	mov	w9, #0x4c0              // =1216
40004860: 2a1f03e1     	mov	w1, wzr
40004864: 52809802     	mov	w2, #0x4c0              // =1216
40004868: 9b294d13     	smaddl	x19, w8, w9, x19
4000486c: 11000508     	add	w8, w8, #0x1
40004870: b90b8b28     	str	w8, [x25, #0xb88]
40004874: aa1303e0     	mov	x0, x19
40004878: 97fff84b     	bl	0x400029a4 <memset>
4000487c: d28cae48     	mov	x8, #0x6572             // =25970
40004880: b904ba7f     	str	wzr, [x19, #0x4b8]
40004884: 528e8f09     	mov	w9, #0x7478             // =29816
40004888: f2ac8c28     	movk	x8, #0x6461, lsl #16
4000488c: 79001269     	strh	w9, [x19, #0x8]
40004890: f2ccada8     	movk	x8, #0x656d, lsl #32
40004894: 39002a7f     	strb	wzr, [x19, #0xa]
40004898: f2ee85c8     	movk	x8, #0x742e, lsl #48
4000489c: b900227f     	str	wzr, [x19, #0x20]
400048a0: f9000268     	str	x8, [x19]
400048a4: b984ba88     	ldrsw	x8, [x20, #0x4b8]
400048a8: f9021a74     	str	x20, [x19, #0x430]
400048ac: 71003d1f     	cmp	w8, #0xf
400048b0: f900167f     	str	xzr, [x19, #0x28]
400048b4: 540000ac     	b.gt	0x400048c8 <vfs_init+0x560>
400048b8: 8b080e89     	add	x9, x20, x8, lsl #3
400048bc: 11000508     	add	w8, w8, #0x1
400048c0: b904ba88     	str	w8, [x20, #0x4b8]
400048c4: f9021d33     	str	x19, [x9, #0x438]
400048c8: 90000034     	adrp	x20, 0x40008000 <__rodata_start>
400048cc: 910dc694     	add	x20, x20, #0x371
400048d0: 9100c260     	add	x0, x19, #0x30
400048d4: aa1403e1     	mov	x1, x20
400048d8: 97fff807     	bl	0x400028f4 <kstrcpy>
400048dc: aa1403e0     	mov	x0, x20
400048e0: 97fff7d6     	bl	0x40002838 <kstrlen>
400048e4: f9001660     	str	x0, [x19, #0x28]
400048e8: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400048ec: f9400bf9     	ldr	x25, [sp, #0x10]
400048f0: a94357f6     	ldp	x22, x21, [sp, #0x30]
400048f4: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400048f8: a8c57bfd     	ldp	x29, x30, [sp], #0x50
400048fc: d65f03c0     	ret

0000000040004900 <vfs_get_root>:
40004900: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004904: f945c900     	ldr	x0, [x8, #0xb90]
40004908: d65f03c0     	ret

000000004000490c <vfs_get_cwd>:
4000490c: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004910: f945cd00     	ldr	x0, [x8, #0xb98]
40004914: d65f03c0     	ret

0000000040004918 <vfs_getcwd>:
40004918: d10343ff     	sub	sp, sp, #0xd0
4000491c: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004920: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004924: aa0003f3     	mov	x19, x0
40004928: f945cd08     	ldr	x8, [x8, #0xb98]
4000492c: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004930: 910203fd     	add	x29, sp, #0x80
40004934: a90967fa     	stp	x26, x25, [sp, #0x90]
40004938: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
4000493c: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004940: b4000228     	cbz	x8, 0x40004984 <vfs_getcwd+0x6c>
40004944: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
40004948: f945c929     	ldr	x9, [x9, #0xb90]
4000494c: eb09011f     	cmp	x8, x9
40004950: 540001a0     	b.eq	0x40004984 <vfs_getcwd+0x6c>
40004954: aa1f03ea     	mov	x10, xzr
40004958: 910003eb     	mov	x11, sp
4000495c: eb09011f     	cmp	x8, x9
40004960: 540001e0     	b.eq	0x4000499c <vfs_getcwd+0x84>
40004964: f1003d5f     	cmp	x10, #0xf
40004968: 540001a8     	b.hi	0x4000499c <vfs_getcwd+0x84>
4000496c: f82a7968     	str	x8, [x11, x10, lsl #3]
40004970: f9421908     	ldr	x8, [x8, #0x430]
40004974: 9100054c     	add	x12, x10, #0x1
40004978: aa0c03ea     	mov	x10, x12
4000497c: b5ffff08     	cbnz	x8, 0x4000495c <vfs_getcwd+0x44>
40004980: 14000008     	b	0x400049a0 <vfs_getcwd+0x88>
40004984: f100083f     	cmp	x1, #0x2
40004988: 54000583     	b.lo	0x40004a38 <vfs_getcwd+0x120>
4000498c: 528005e8     	mov	w8, #0x2f               // =47
40004990: 3900067f     	strb	wzr, [x19, #0x1]
40004994: 39000268     	strb	w8, [x19]
40004998: 14000028     	b	0x40004a38 <vfs_getcwd+0x120>
4000499c: aa0a03ec     	mov	x12, x10
400049a0: 7100059f     	cmp	w12, #0x1
400049a4: 3900027f     	strb	wzr, [x19]
400049a8: 5400048b     	b.lt	0x40004a38 <vfs_getcwd+0x120>
400049ac: aa1f03f6     	mov	x22, xzr
400049b0: d1000435     	sub	x21, x1, #0x1
400049b4: 92407999     	and	x25, x12, #0x7fffffff
400049b8: 528005f7     	mov	w23, #0x2f              // =47
400049bc: 910003f8     	mov	x24, sp
400049c0: 14000005     	b	0x400049d4 <vfs_getcwd+0xbc>
400049c4: 8b0a02d6     	add	x22, x22, x10
400049c8: f100075f     	cmp	x26, #0x1
400049cc: 38366a7f     	strb	wzr, [x19, x22]
400049d0: 54000349     	b.ls	0x40004a38 <vfs_getcwd+0x120>
400049d4: eb1502df     	cmp	x22, x21
400049d8: aa1903fa     	mov	x26, x25
400049dc: 54000082     	b.hs	0x400049ec <vfs_getcwd+0xd4>
400049e0: 38366a77     	strb	w23, [x19, x22]
400049e4: 910006d6     	add	x22, x22, #0x1
400049e8: 38366a7f     	strb	wzr, [x19, x22]
400049ec: d1000759     	sub	x25, x26, #0x1
400049f0: f8797b14     	ldr	x20, [x24, x25, lsl #3]
400049f4: aa1403e0     	mov	x0, x20
400049f8: 97fff790     	bl	0x40002838 <kstrlen>
400049fc: b4fffe60     	cbz	x0, 0x400049c8 <vfs_getcwd+0xb0>
40004a00: eb1502df     	cmp	x22, x21
40004a04: 54fffe22     	b.hs	0x400049c8 <vfs_getcwd+0xb0>
40004a08: aa1f03e9     	mov	x9, xzr
40004a0c: 8b160268     	add	x8, x19, x22
40004a10: 9100052a     	add	x10, x9, #0x1
40004a14: 38696a8b     	ldrb	w11, [x20, x9]
40004a18: eb00015f     	cmp	x10, x0
40004a1c: 3829690b     	strb	w11, [x8, x9]
40004a20: 54fffd22     	b.hs	0x400049c4 <vfs_getcwd+0xac>
40004a24: 8b160149     	add	x9, x10, x22
40004a28: eb15013f     	cmp	x9, x21
40004a2c: aa0a03e9     	mov	x9, x10
40004a30: 54ffff03     	b.lo	0x40004a10 <vfs_getcwd+0xf8>
40004a34: 17ffffe4     	b	0x400049c4 <vfs_getcwd+0xac>
40004a38: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004a3c: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004a40: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004a44: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004a48: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004a4c: 910343ff     	add	sp, sp, #0xd0
40004a50: d65f03c0     	ret

0000000040004a54 <vfs_find>:
40004a54: d10203ff     	sub	sp, sp, #0x80
40004a58: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004a5c: 910083fd     	add	x29, sp, #0x20
40004a60: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004a64: a90467fa     	stp	x26, x25, [sp, #0x40]
40004a68: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004a6c: a90657f6     	stp	x22, x21, [sp, #0x60]
40004a70: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004a74: b4000a60     	cbz	x0, 0x40004bc0 <vfs_find+0x16c>
40004a78: 39400008     	ldrb	w8, [x0]
40004a7c: aa0003f4     	mov	x20, x0
40004a80: 34000a08     	cbz	w8, 0x40004bc0 <vfs_find+0x16c>
40004a84: 7100bd1f     	cmp	w8, #0x2f
40004a88: 54000121     	b.ne	0x40004aac <vfs_find+0x58>
40004a8c: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004a90: 52800037     	mov	w23, #0x1               // =1
40004a94: f945c913     	ldr	x19, [x8, #0xb90]
40004a98: 38776a88     	ldrb	w8, [x20, x23]
40004a9c: 7100bd1f     	cmp	w8, #0x2f
40004aa0: 540000e1     	b.ne	0x40004abc <vfs_find+0x68>
40004aa4: 910006f7     	add	x23, x23, #0x1
40004aa8: 17fffffc     	b	0x40004a98 <vfs_find+0x44>
40004aac: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
40004ab0: aa1f03f7     	mov	x23, xzr
40004ab4: f945cd33     	ldr	x19, [x9, #0xb98]
40004ab8: 14000002     	b	0x40004ac0 <vfs_find+0x6c>
40004abc: 34000848     	cbz	w8, 0x40004bc4 <vfs_find+0x170>
40004ac0: 91000698     	add	x24, x20, #0x1
40004ac4: 90000035     	adrp	x21, 0x40008000 <__rodata_start>
40004ac8: 91263eb5     	add	x21, x21, #0x98f
40004acc: 910003f9     	mov	x25, sp
40004ad0: b0000036     	adrp	x22, 0x40009000 <__rodata_start+0x1000>
40004ad4: 9105b2d6     	add	x22, x22, #0x16c
40004ad8: 14000006     	b	0x40004af0 <vfs_find+0x9c>
40004adc: f9421a68     	ldr	x8, [x19, #0x430]
40004ae0: f100011f     	cmp	x8, #0x0
40004ae4: 9a880273     	csel	x19, x19, x8, eq
40004ae8: 385ff348     	ldurb	w8, [x26, #-0x1]
40004aec: 340006c8     	cbz	w8, 0x40004bc4 <vfs_find+0x170>
40004af0: 7100bd1f     	cmp	w8, #0x2f
40004af4: 54000061     	b.ne	0x40004b00 <vfs_find+0xac>
40004af8: aa1f03e9     	mov	x9, xzr
40004afc: 14000010     	b	0x40004b3c <vfs_find+0xe8>
40004b00: aa1f03e9     	mov	x9, xzr
40004b04: 8b17030a     	add	x10, x24, x23
40004b08: 34000188     	cbz	w8, 0x40004b38 <vfs_find+0xe4>
40004b0c: f100793f     	cmp	x9, #0x1e
40004b10: 54000148     	b.hi	0x40004b38 <vfs_find+0xe4>
40004b14: 38296b28     	strb	w8, [x25, x9]
40004b18: 38696948     	ldrb	w8, [x10, x9]
40004b1c: 9100052b     	add	x11, x9, #0x1
40004b20: aa0b03e9     	mov	x9, x11
40004b24: 7100bd1f     	cmp	w8, #0x2f
40004b28: 54ffff01     	b.ne	0x40004b08 <vfs_find+0xb4>
40004b2c: 8b0b02f7     	add	x23, x23, x11
40004b30: aa0b03e9     	mov	x9, x11
40004b34: 14000002     	b	0x40004b3c <vfs_find+0xe8>
40004b38: 8b0902f7     	add	x23, x23, x9
40004b3c: 8b17029a     	add	x26, x20, x23
40004b40: d10006f7     	sub	x23, x23, #0x1
40004b44: 38296b3f     	strb	wzr, [x25, x9]
40004b48: 38401748     	ldrb	w8, [x26], #0x1
40004b4c: 910006f7     	add	x23, x23, #0x1
40004b50: 7100bd1f     	cmp	w8, #0x2f
40004b54: 54ffffa0     	b.eq	0x40004b48 <vfs_find+0xf4>
40004b58: 910003e0     	mov	x0, sp
40004b5c: aa1503e1     	mov	x1, x21
40004b60: 97fff746     	bl	0x40002878 <kstrcmp>
40004b64: 34fffc20     	cbz	w0, 0x40004ae8 <vfs_find+0x94>
40004b68: 910003e0     	mov	x0, sp
40004b6c: aa1603e1     	mov	x1, x22
40004b70: 97fff742     	bl	0x40002878 <kstrcmp>
40004b74: 34fffb40     	cbz	w0, 0x40004adc <vfs_find+0x88>
40004b78: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b7c: 7100051f     	cmp	w8, #0x1
40004b80: 5400020b     	b.lt	0x40004bc0 <vfs_find+0x16c>
40004b84: aa1f03fb     	mov	x27, xzr
40004b88: 9110e27c     	add	x28, x19, #0x438
40004b8c: 14000005     	b	0x40004ba0 <vfs_find+0x14c>
40004b90: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b94: 9100077b     	add	x27, x27, #0x1
40004b98: eb28c37f     	cmp	x27, w8, sxtw
40004b9c: 5400012a     	b.ge	0x40004bc0 <vfs_find+0x16c>
40004ba0: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004ba4: b4ffff80     	cbz	x0, 0x40004b94 <vfs_find+0x140>
40004ba8: 910003e1     	mov	x1, sp
40004bac: 97fff733     	bl	0x40002878 <kstrcmp>
40004bb0: 35ffff00     	cbnz	w0, 0x40004b90 <vfs_find+0x13c>
40004bb4: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004bb8: b5fff993     	cbnz	x19, 0x40004ae8 <vfs_find+0x94>
40004bbc: 14000002     	b	0x40004bc4 <vfs_find+0x170>
40004bc0: aa1f03f3     	mov	x19, xzr
40004bc4: aa1303e0     	mov	x0, x19
40004bc8: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004bcc: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004bd0: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004bd4: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004bd8: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004bdc: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004be0: 910203ff     	add	sp, sp, #0x80
40004be4: d65f03c0     	ret

0000000040004be8 <vfs_chdir>:
40004be8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004bec: f9000bf3     	str	x19, [sp, #0x10]
40004bf0: 910003fd     	mov	x29, sp
40004bf4: b4000200     	cbz	x0, 0x40004c34 <vfs_chdir+0x4c>
40004bf8: 39400008     	ldrb	w8, [x0]
40004bfc: 340001c8     	cbz	w8, 0x40004c34 <vfs_chdir+0x4c>
40004c00: d0000021     	adrp	x1, 0x4000a000 <__rodata_start+0x2000>
40004c04: 91113021     	add	x1, x1, #0x44c
40004c08: aa0003f3     	mov	x19, x0
40004c0c: 97fff71b     	bl	0x40002878 <kstrcmp>
40004c10: 34000120     	cbz	w0, 0x40004c34 <vfs_chdir+0x4c>
40004c14: aa1303e0     	mov	x0, x19
40004c18: 97ffff8f     	bl	0x40004a54 <vfs_find>
40004c1c: b40002c0     	cbz	x0, 0x40004c74 <vfs_chdir+0x8c>
40004c20: b9402008     	ldr	w8, [x0, #0x20]
40004c24: 7100051f     	cmp	w8, #0x1
40004c28: 54000180     	b.eq	0x40004c58 <vfs_chdir+0x70>
40004c2c: 12800028     	mov	w8, #-0x2               // =-2
40004c30: 1400000d     	b	0x40004c64 <vfs_chdir+0x7c>
40004c34: b0000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40004c38: 91010000     	add	x0, x0, #0x40
40004c3c: 97ffff86     	bl	0x40004a54 <vfs_find>
40004c40: b4000080     	cbz	x0, 0x40004c50 <vfs_chdir+0x68>
40004c44: b9402008     	ldr	w8, [x0, #0x20]
40004c48: 7100051f     	cmp	w8, #0x1
40004c4c: 54000060     	b.eq	0x40004c58 <vfs_chdir+0x70>
40004c50: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004c54: f945c900     	ldr	x0, [x8, #0xb90]
40004c58: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
40004c5c: 2a1f03e8     	mov	w8, wzr
40004c60: f905cd20     	str	x0, [x9, #0xb98]
40004c64: f9400bf3     	ldr	x19, [sp, #0x10]
40004c68: 2a0803e0     	mov	w0, w8
40004c6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004c70: d65f03c0     	ret
40004c74: 12800008     	mov	w8, #-0x1               // =-1
40004c78: 17fffffb     	b	0x40004c64 <vfs_chdir+0x7c>

0000000040004c7c <vfs_mkdir>:
40004c7c: b40001e0     	cbz	x0, 0x40004cb8 <vfs_mkdir+0x3c>
40004c80: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004c84: 39400008     	ldrb	w8, [x0]
40004c88: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004c8c: aa0003f3     	mov	x19, x0
40004c90: a90157f6     	stp	x22, x21, [sp, #0x10]
40004c94: 910003fd     	mov	x29, sp
40004c98: 34000148     	cbz	w8, 0x40004cc0 <vfs_mkdir+0x44>
40004c9c: 90000094     	adrp	x20, 0x40014000 <kernel_capture_buffer+0x3478>
40004ca0: f945ce95     	ldr	x21, [x20, #0xb98]
40004ca4: b944baa8     	ldr	w8, [x21, #0x4b8]
40004ca8: 71003d1f     	cmp	w8, #0xf
40004cac: 540000ed     	b.le	0x40004cc8 <vfs_mkdir+0x4c>
40004cb0: 12800020     	mov	w0, #-0x2               // =-2
40004cb4: 14000043     	b	0x40004dc0 <vfs_mkdir+0x144>
40004cb8: 12800000     	mov	w0, #-0x1               // =-1
40004cbc: d65f03c0     	ret
40004cc0: 12800000     	mov	w0, #-0x1               // =-1
40004cc4: 1400003f     	b	0x40004dc0 <vfs_mkdir+0x144>
40004cc8: 7100051f     	cmp	w8, #0x1
40004ccc: 540001eb     	b.lt	0x40004d08 <vfs_mkdir+0x8c>
40004cd0: aa1f03f6     	mov	x22, xzr
40004cd4: 14000005     	b	0x40004ce8 <vfs_mkdir+0x6c>
40004cd8: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004cdc: 910006d6     	add	x22, x22, #0x1
40004ce0: eb0802df     	cmp	x22, x8
40004ce4: 5400012a     	b.ge	0x40004d08 <vfs_mkdir+0x8c>
40004ce8: 8b160ea8     	add	x8, x21, x22, lsl #3
40004cec: f9421d00     	ldr	x0, [x8, #0x438]
40004cf0: b4ffff40     	cbz	x0, 0x40004cd8 <vfs_mkdir+0x5c>
40004cf4: aa1303e1     	mov	x1, x19
40004cf8: 97fff6e0     	bl	0x40002878 <kstrcmp>
40004cfc: 340003e0     	cbz	w0, 0x40004d78 <vfs_mkdir+0xfc>
40004d00: f945ce95     	ldr	x21, [x20, #0xb98]
40004d04: 17fffff5     	b	0x40004cd8 <vfs_mkdir+0x5c>
40004d08: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004d0c: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004d10: 7101fd3f     	cmp	w9, #0x7f
40004d14: 5400006d     	b.le	0x40004d20 <vfs_mkdir+0xa4>
40004d18: 12800060     	mov	w0, #-0x4               // =-4
40004d1c: 14000029     	b	0x40004dc0 <vfs_mkdir+0x144>
40004d20: 5280980a     	mov	w10, #0x4c0             // =1216
40004d24: 9000008b     	adrp	x11, 0x40014000 <kernel_capture_buffer+0x3478>
40004d28: 912e816b     	add	x11, x11, #0xba0
40004d2c: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d30: 11000529     	add	w9, w9, #0x1
40004d34: 2a1f03e1     	mov	w1, wzr
40004d38: 52809802     	mov	w2, #0x4c0              // =1216
40004d3c: b90b8909     	str	w9, [x8, #0xb88]
40004d40: aa1403e0     	mov	x0, x20
40004d44: 97fff718     	bl	0x400029a4 <memset>
40004d48: 39400268     	ldrb	w8, [x19]
40004d4c: 340001a8     	cbz	w8, 0x40004d80 <vfs_mkdir+0x104>
40004d50: aa1f03ea     	mov	x10, xzr
40004d54: 91000669     	add	x9, x19, #0x1
40004d58: 382a6a88     	strb	w8, [x20, x10]
40004d5c: 9100054b     	add	x11, x10, #0x1
40004d60: 386a6928     	ldrb	w8, [x9, x10]
40004d64: 34000108     	cbz	w8, 0x40004d84 <vfs_mkdir+0x108>
40004d68: f100795f     	cmp	x10, #0x1e
40004d6c: aa0b03ea     	mov	x10, x11
40004d70: 54ffff43     	b.lo	0x40004d58 <vfs_mkdir+0xdc>
40004d74: 14000004     	b	0x40004d84 <vfs_mkdir+0x108>
40004d78: 12800040     	mov	w0, #-0x3               // =-3
40004d7c: 14000011     	b	0x40004dc0 <vfs_mkdir+0x144>
40004d80: aa1f03eb     	mov	x11, xzr
40004d84: 382b6a9f     	strb	wzr, [x20, x11]
40004d88: 2a1f03e0     	mov	w0, wzr
40004d8c: 52800029     	mov	w9, #0x1                // =1
40004d90: b904ba9f     	str	wzr, [x20, #0x4b8]
40004d94: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004d98: b9002289     	str	w9, [x20, #0x20]
40004d9c: f9021a95     	str	x21, [x20, #0x430]
40004da0: 71003d1f     	cmp	w8, #0xf
40004da4: f900169f     	str	xzr, [x20, #0x28]
40004da8: 540000cc     	b.gt	0x40004dc0 <vfs_mkdir+0x144>
40004dac: 8b080ea9     	add	x9, x21, x8, lsl #3
40004db0: 2a1f03e0     	mov	w0, wzr
40004db4: 11000508     	add	w8, w8, #0x1
40004db8: b904baa8     	str	w8, [x21, #0x4b8]
40004dbc: f9021d34     	str	x20, [x9, #0x438]
40004dc0: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004dc4: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004dc8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004dcc: d65f03c0     	ret

0000000040004dd0 <vfs_sync>:
40004dd0: d65f03c0     	ret

0000000040004dd4 <vfs_touch>:
40004dd4: b4000500     	cbz	x0, 0x40004e74 <vfs_touch+0xa0>
40004dd8: 39400008     	ldrb	w8, [x0]
40004ddc: 340004c8     	cbz	w8, 0x40004e74 <vfs_touch+0xa0>
40004de0: d10583ff     	sub	sp, sp, #0x160
40004de4: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3478>
40004de8: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004dec: aa1f03f4     	mov	x20, xzr
40004df0: f945cd33     	ldr	x19, [x9, #0xb98]
40004df4: aa0003e9     	mov	x9, x0
40004df8: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004dfc: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004e00: 910483fd     	add	x29, sp, #0x120
40004e04: a91457f6     	stp	x22, x21, [sp, #0x140]
40004e08: 14000003     	b	0x40004e14 <vfs_touch+0x40>
40004e0c: aa0903f4     	mov	x20, x9
40004e10: 38401d28     	ldrb	w8, [x9, #0x1]!
40004e14: 7100bd1f     	cmp	w8, #0x2f
40004e18: 54ffffa0     	b.eq	0x40004e0c <vfs_touch+0x38>
40004e1c: 35ffffa8     	cbnz	w8, 0x40004e10 <vfs_touch+0x3c>
40004e20: b4000334     	cbz	x20, 0x40004e84 <vfs_touch+0xb0>
40004e24: cb000288     	sub	x8, x20, x0
40004e28: 52801fe9     	mov	w9, #0xff               // =255
40004e2c: aa0103f5     	mov	x21, x1
40004e30: f103fd1f     	cmp	x8, #0xff
40004e34: aa0003e1     	mov	x1, x0
40004e38: 910083e0     	add	x0, sp, #0x20
40004e3c: 9a893113     	csel	x19, x8, x9, lo
40004e40: 910083f6     	add	x22, sp, #0x20
40004e44: aa1303e2     	mov	x2, x19
40004e48: 97fff6b2     	bl	0x40002910 <kstrncpy>
40004e4c: 910083e0     	add	x0, sp, #0x20
40004e50: 38336adf     	strb	wzr, [x22, x19]
40004e54: 97ffff00     	bl	0x40004a54 <vfs_find>
40004e58: b4000120     	cbz	x0, 0x40004e7c <vfs_touch+0xa8>
40004e5c: b9402008     	ldr	w8, [x0, #0x20]
40004e60: aa0003f3     	mov	x19, x0
40004e64: 7100051f     	cmp	w8, #0x1
40004e68: 540000a1     	b.ne	0x40004e7c <vfs_touch+0xa8>
40004e6c: 91000688     	add	x8, x20, #0x1
40004e70: 14000007     	b	0x40004e8c <vfs_touch+0xb8>
40004e74: 12800000     	mov	w0, #-0x1               // =-1
40004e78: d65f03c0     	ret
40004e7c: 12800000     	mov	w0, #-0x1               // =-1
40004e80: 1400006a     	b	0x40005028 <vfs_touch+0x254>
40004e84: aa0003e8     	mov	x8, x0
40004e88: aa0103f5     	mov	x21, x1
40004e8c: 910003e0     	mov	x0, sp
40004e90: aa0803e1     	mov	x1, x8
40004e94: 528003e2     	mov	w2, #0x1f               // =31
40004e98: 97fff69e     	bl	0x40002910 <kstrncpy>
40004e9c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004ea0: 39007fff     	strb	wzr, [sp, #0x1f]
40004ea4: 7100051f     	cmp	w8, #0x1
40004ea8: 5400024b     	b.lt	0x40004ef0 <vfs_touch+0x11c>
40004eac: aa1f03f6     	mov	x22, xzr
40004eb0: 9110e277     	add	x23, x19, #0x438
40004eb4: 14000004     	b	0x40004ec4 <vfs_touch+0xf0>
40004eb8: 910006d6     	add	x22, x22, #0x1
40004ebc: eb28c2df     	cmp	x22, w8, sxtw
40004ec0: 5400010a     	b.ge	0x40004ee0 <vfs_touch+0x10c>
40004ec4: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004ec8: b4ffff80     	cbz	x0, 0x40004eb8 <vfs_touch+0xe4>
40004ecc: 910003e1     	mov	x1, sp
40004ed0: 97fff66a     	bl	0x40002878 <kstrcmp>
40004ed4: 340004a0     	cbz	w0, 0x40004f68 <vfs_touch+0x194>
40004ed8: b944ba68     	ldr	w8, [x19, #0x4b8]
40004edc: 17fffff7     	b	0x40004eb8 <vfs_touch+0xe4>
40004ee0: 71003d1f     	cmp	w8, #0xf
40004ee4: 5400006d     	b.le	0x40004ef0 <vfs_touch+0x11c>
40004ee8: 12800020     	mov	w0, #-0x2               // =-2
40004eec: 1400004f     	b	0x40005028 <vfs_touch+0x254>
40004ef0: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
40004ef4: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004ef8: 7101fd3f     	cmp	w9, #0x7f
40004efc: 5400006d     	b.le	0x40004f08 <vfs_touch+0x134>
40004f00: 12800060     	mov	w0, #-0x4               // =-4
40004f04: 14000049     	b	0x40005028 <vfs_touch+0x254>
40004f08: 5280980a     	mov	w10, #0x4c0             // =1216
40004f0c: 9000008b     	adrp	x11, 0x40014000 <kernel_capture_buffer+0x3478>
40004f10: 912e816b     	add	x11, x11, #0xba0
40004f14: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004f18: 11000529     	add	w9, w9, #0x1
40004f1c: 2a1f03e1     	mov	w1, wzr
40004f20: 52809802     	mov	w2, #0x4c0              // =1216
40004f24: b90b8909     	str	w9, [x8, #0xb88]
40004f28: aa1403e0     	mov	x0, x20
40004f2c: 97fff69e     	bl	0x400029a4 <memset>
40004f30: 394003e8     	ldrb	w8, [sp]
40004f34: 340003e8     	cbz	w8, 0x40004fb0 <vfs_touch+0x1dc>
40004f38: 910003ea     	mov	x10, sp
40004f3c: aa1f03e9     	mov	x9, xzr
40004f40: aa1503e0     	mov	x0, x21
40004f44: b240014a     	orr	x10, x10, #0x1
40004f48: 38296a88     	strb	w8, [x20, x9]
40004f4c: 38696948     	ldrb	w8, [x10, x9]
40004f50: 9100052b     	add	x11, x9, #0x1
40004f54: 34000328     	cbz	w8, 0x40004fb8 <vfs_touch+0x1e4>
40004f58: f100793f     	cmp	x9, #0x1e
40004f5c: aa0b03e9     	mov	x9, x11
40004f60: 54ffff43     	b.lo	0x40004f48 <vfs_touch+0x174>
40004f64: 14000015     	b	0x40004fb8 <vfs_touch+0x1e4>
40004f68: b40005f5     	cbz	x21, 0x40005024 <vfs_touch+0x250>
40004f6c: aa1503e0     	mov	x0, x21
40004f70: 97fff632     	bl	0x40002838 <kstrlen>
40004f74: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f78: f10ffc1f     	cmp	x0, #0x3ff
40004f7c: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f80: 9a883014     	csel	x20, x0, x8, lo
40004f84: aa1503e1     	mov	x1, x21
40004f88: 9100c120     	add	x0, x9, #0x30
40004f8c: aa1403e2     	mov	x2, x20
40004f90: 97fff69b     	bl	0x400029fc <memcpy>
40004f94: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f98: 2a1f03e0     	mov	w0, wzr
40004f9c: 8b140108     	add	x8, x8, x20
40004fa0: 3900c11f     	strb	wzr, [x8, #0x30]
40004fa4: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004fa8: f9001514     	str	x20, [x8, #0x28]
40004fac: 1400001f     	b	0x40005028 <vfs_touch+0x254>
40004fb0: aa1f03eb     	mov	x11, xzr
40004fb4: aa1503e0     	mov	x0, x21
40004fb8: 382b6a9f     	strb	wzr, [x20, x11]
40004fbc: b904ba9f     	str	wzr, [x20, #0x4b8]
40004fc0: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004fc4: b900229f     	str	wzr, [x20, #0x20]
40004fc8: f9021a93     	str	x19, [x20, #0x430]
40004fcc: 71003d1f     	cmp	w8, #0xf
40004fd0: f900169f     	str	xzr, [x20, #0x28]
40004fd4: 540000ac     	b.gt	0x40004fe8 <vfs_touch+0x214>
40004fd8: 8b080e69     	add	x9, x19, x8, lsl #3
40004fdc: 11000508     	add	w8, w8, #0x1
40004fe0: b904ba68     	str	w8, [x19, #0x4b8]
40004fe4: f9021d34     	str	x20, [x9, #0x438]
40004fe8: b4000200     	cbz	x0, 0x40005028 <vfs_touch+0x254>
40004fec: aa0003f3     	mov	x19, x0
40004ff0: 97fff612     	bl	0x40002838 <kstrlen>
40004ff4: 52807fe8     	mov	w8, #0x3ff              // =1023
40004ff8: f10ffc1f     	cmp	x0, #0x3ff
40004ffc: 9100c296     	add	x22, x20, #0x30
40005000: 9a883015     	csel	x21, x0, x8, lo
40005004: aa1603e0     	mov	x0, x22
40005008: aa1303e1     	mov	x1, x19
4000500c: aa1503e2     	mov	x2, x21
40005010: 97fff67b     	bl	0x400029fc <memcpy>
40005014: 2a1f03e0     	mov	w0, wzr
40005018: 38356adf     	strb	wzr, [x22, x21]
4000501c: f9001695     	str	x21, [x20, #0x28]
40005020: 14000002     	b	0x40005028 <vfs_touch+0x254>
40005024: 2a1f03e0     	mov	w0, wzr
40005028: a9554ff4     	ldp	x20, x19, [sp, #0x150]
4000502c: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005030: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40005034: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40005038: 910583ff     	add	sp, sp, #0x160
4000503c: d65f03c0     	ret

0000000040005040 <vfs_write_file>:
40005040: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005044: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005048: aa0003f4     	mov	x20, x0
4000504c: aa0103e0     	mov	x0, x1
40005050: 910003fd     	mov	x29, sp
40005054: aa0103f3     	mov	x19, x1
40005058: 97fff5f8     	bl	0x40002838 <kstrlen>
4000505c: aa0003e2     	mov	x2, x0
40005060: aa1403e0     	mov	x0, x20
40005064: aa1303e1     	mov	x1, x19
40005068: 9400059e     	bl	0x400066e0 <fat16_write_file>
4000506c: aa1403e0     	mov	x0, x20
40005070: aa1303e1     	mov	x1, x19
40005074: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40005078: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000507c: 17ffff56     	b	0x40004dd4 <vfs_touch>

0000000040005080 <vfs_remove>:
40005080: b40005c0     	cbz	x0, 0x40005138 <vfs_remove+0xb8>
40005084: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40005088: 39400008     	ldrb	w8, [x0]
4000508c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40005090: aa0003f3     	mov	x19, x0
40005094: f9000bf5     	str	x21, [sp, #0x10]
40005098: 910003fd     	mov	x29, sp
4000509c: 34000448     	cbz	w8, 0x40005124 <vfs_remove+0xa4>
400050a0: f0000074     	adrp	x20, 0x40014000 <kernel_capture_buffer+0x3478>
400050a4: f945ce88     	ldr	x8, [x20, #0xb98]
400050a8: b944b909     	ldr	w9, [x8, #0x4b8]
400050ac: 7100053f     	cmp	w9, #0x1
400050b0: 540003ab     	b.lt	0x40005124 <vfs_remove+0xa4>
400050b4: aa1f03f5     	mov	x21, xzr
400050b8: 14000005     	b	0x400050cc <vfs_remove+0x4c>
400050bc: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050c0: 910006b5     	add	x21, x21, #0x1
400050c4: eb0902bf     	cmp	x21, x9
400050c8: 540002ea     	b.ge	0x40005124 <vfs_remove+0xa4>
400050cc: 8b150d09     	add	x9, x8, x21, lsl #3
400050d0: f9421d20     	ldr	x0, [x9, #0x438]
400050d4: b4ffff40     	cbz	x0, 0x400050bc <vfs_remove+0x3c>
400050d8: aa1303e1     	mov	x1, x19
400050dc: 97fff5e7     	bl	0x40002878 <kstrcmp>
400050e0: f945ce88     	ldr	x8, [x20, #0xb98]
400050e4: 35fffec0     	cbnz	w0, 0x400050bc <vfs_remove+0x3c>
400050e8: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050ec: d1000529     	sub	x9, x9, #0x1
400050f0: 6b15013f     	cmp	w9, w21
400050f4: 5400026d     	b.le	0x40005140 <vfs_remove+0xc0>
400050f8: f945ce8a     	ldr	x10, [x20, #0xb98]
400050fc: b984b949     	ldrsw	x9, [x10, #0x4b8]
40005100: d1000529     	sub	x9, x9, #0x1
40005104: 8b150d08     	add	x8, x8, x21, lsl #3
40005108: 910006b5     	add	x21, x21, #0x1
4000510c: eb0902bf     	cmp	x21, x9
40005110: f942210b     	ldr	x11, [x8, #0x440]
40005114: f9021d0b     	str	x11, [x8, #0x438]
40005118: aa0a03e8     	mov	x8, x10
4000511c: 54ffff4b     	b.lt	0x40005104 <vfs_remove+0x84>
40005120: 14000009     	b	0x40005144 <vfs_remove+0xc4>
40005124: 12800000     	mov	w0, #-0x1               // =-1
40005128: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000512c: f9400bf5     	ldr	x21, [sp, #0x10]
40005130: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005134: d65f03c0     	ret
40005138: 12800000     	mov	w0, #-0x1               // =-1
4000513c: d65f03c0     	ret
40005140: aa0803ea     	mov	x10, x8
40005144: 8b090d48     	add	x8, x10, x9, lsl #3
40005148: 2a1f03e0     	mov	w0, wzr
4000514c: f9021d1f     	str	xzr, [x8, #0x438]
40005150: f945ce88     	ldr	x8, [x20, #0xb98]
40005154: b944b909     	ldr	w9, [x8, #0x4b8]
40005158: 51000529     	sub	w9, w9, #0x1
4000515c: b904b909     	str	w9, [x8, #0x4b8]
40005160: 17fffff2     	b	0x40005128 <vfs_remove+0xa8>

0000000040005164 <vfs_list_dir>:
40005164: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005168: f0000068     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3478>
4000516c: f100001f     	cmp	x0, #0x0
40005170: a90257f6     	stp	x22, x21, [sp, #0x20]
40005174: f945cd08     	ldr	x8, [x8, #0xb98]
40005178: f9000bf7     	str	x23, [sp, #0x10]
4000517c: 910003fd     	mov	x29, sp
40005180: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005184: 9a800115     	csel	x21, x8, x0, eq
40005188: b94022a8     	ldr	w8, [x21, #0x20]
4000518c: 7100051f     	cmp	w8, #0x1
40005190: 54000521     	b.ne	0x40005234 <vfs_list_dir+0xd0>
40005194: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005198: 9139cc00     	add	x0, x0, #0xe73
4000519c: 97fff952     	bl	0x400036e4 <uart_puts>
400051a0: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
400051a4: 9120d800     	add	x0, x0, #0x836
400051a8: 97fff94f     	bl	0x400036e4 <uart_puts>
400051ac: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400051b0: 913d7c00     	add	x0, x0, #0xf5f
400051b4: 97fff94c     	bl	0x400036e4 <uart_puts>
400051b8: f9421aa8     	ldr	x8, [x21, #0x430]
400051bc: b4000088     	cbz	x8, 0x400051cc <vfs_list_dir+0x68>
400051c0: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400051c4: 910f8800     	add	x0, x0, #0x3e2
400051c8: 97fff947     	bl	0x400036e4 <uart_puts>
400051cc: b944baa1     	ldr	w1, [x21, #0x4b8]
400051d0: 7100043f     	cmp	w1, #0x1
400051d4: 5400034b     	b.lt	0x4000523c <vfs_list_dir+0xd8>
400051d8: aa1f03f6     	mov	x22, xzr
400051dc: 90000033     	adrp	x19, 0x40009000 <__rodata_start+0x1000>
400051e0: 91320e73     	add	x19, x19, #0xc83
400051e4: 9110e2b7     	add	x23, x21, #0x438
400051e8: 90000034     	adrp	x20, 0x40009000 <__rodata_start+0x1000>
400051ec: 911e7a94     	add	x20, x20, #0x79e
400051f0: 14000008     	b	0x40005210 <vfs_list_dir+0xac>
400051f4: b9402841     	ldr	w1, [x2, #0x28]
400051f8: aa1403e0     	mov	x0, x20
400051fc: 97fffa4f     	bl	0x40003b38 <uart_printf>
40005200: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40005204: 910006d6     	add	x22, x22, #0x1
40005208: eb0102df     	cmp	x22, x1
4000520c: 5400018a     	b.ge	0x4000523c <vfs_list_dir+0xd8>
40005210: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005214: b4ffff62     	cbz	x2, 0x40005200 <vfs_list_dir+0x9c>
40005218: b9402048     	ldr	w8, [x2, #0x20]
4000521c: 7100051f     	cmp	w8, #0x1
40005220: 54fffea1     	b.ne	0x400051f4 <vfs_list_dir+0x90>
40005224: aa1303e0     	mov	x0, x19
40005228: aa0203e1     	mov	x1, x2
4000522c: 97fffa43     	bl	0x40003b38 <uart_printf>
40005230: 17fffff4     	b	0x40005200 <vfs_list_dir+0x9c>
40005234: 12800000     	mov	w0, #-0x1               // =-1
40005238: 14000005     	b	0x4000524c <vfs_list_dir+0xe8>
4000523c: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005240: 91264400     	add	x0, x0, #0x991
40005244: 97fffa3d     	bl	0x40003b38 <uart_printf>
40005248: 2a1f03e0     	mov	w0, wzr
4000524c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005250: f9400bf7     	ldr	x23, [sp, #0x10]
40005254: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005258: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000525c: d65f03c0     	ret

0000000040005260 <vfs_load_internal>:
40005260: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40005264: 910003fd     	mov	x29, sp
40005268: 940006d1     	bl	0x40006dac <fat16_populate_vfs>
4000526c: 2a1f03e0     	mov	w0, wzr
40005270: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40005274: d65f03c0     	ret

0000000040005278 <vfs_load>:
40005278: 140006cd     	b	0x40006dac <fat16_populate_vfs>

000000004000527c <pmm_init>:
4000527c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005280: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005284: d503201f     	nop
40005288: 101ac8d4     	adr	x20, 0x4003aba0 <memory_bitmap>
4000528c: aa1403e0     	mov	x0, x20
40005290: 2a1f03e1     	mov	w1, wzr
40005294: 52820002     	mov	w2, #0x1000             // =4096
40005298: 910003fd     	mov	x29, sp
4000529c: 97fff5c2     	bl	0x400029a4 <memset>
400052a0: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
400052a4: d503201f     	nop
400052a8: 10236ac8     	adr	x8, 0x4004c000 <__kernel_end>
400052ac: f2820009     	movk	x9, #0x1000
400052b0: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
400052b4: f2402d1f     	tst	x8, #0xfff
400052b8: 8b090109     	add	x9, x8, x9
400052bc: 8b0a010a     	add	x10, x8, x10
400052c0: 9a890148     	csel	x8, x10, x9, eq
400052c4: d34cfd13     	lsr	x19, x8, #12
400052c8: 340001b3     	cbz	w19, 0x400052fc <pmm_init+0x80>
400052cc: 2a1f03e8     	mov	w8, wzr
400052d0: 52800029     	mov	w9, #0x1                // =1
400052d4: 2a0803ea     	mov	w10, w8
400052d8: 1200090b     	and	w11, w8, #0x7
400052dc: 11000508     	add	w8, w8, #0x1
400052e0: d343fd4a     	lsr	x10, x10, #3
400052e4: 1acb212b     	lsl	w11, w9, w11
400052e8: 6b08027f     	cmp	w19, w8
400052ec: 386a6a8c     	ldrb	w12, [x20, x10]
400052f0: 2a0b018b     	orr	w11, w12, w11
400052f4: 382a6a8b     	strb	w11, [x20, x10]
400052f8: 54fffee1     	b.ne	0x400052d4 <pmm_init+0x58>
400052fc: 52900008     	mov	w8, #0x8000             // =32768
40005300: d0000034     	adrp	x20, 0x4000b000 <next_pid>
40005304: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005308: 4b130108     	sub	w8, w8, w19
4000530c: d503201f     	nop
40005310: 30026cc0     	adr	x0, 0x4000a0a9 <__rodata_start+0x20a9>
40005314: b9000688     	str	w8, [x20, #0x4]
40005318: b90ba133     	str	w19, [x9, #0xba0]
4000531c: 97fffa07     	bl	0x40003b38 <uart_printf>
40005320: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40005324: 91250000     	add	x0, x0, #0x940
40005328: 52801001     	mov	w1, #0x80               // =128
4000532c: 97fffa03     	bl	0x40003b38 <uart_printf>
40005330: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40005334: 91113800     	add	x0, x0, #0x44e
40005338: 2a1303e1     	mov	w1, w19
4000533c: 97fff9ff     	bl	0x40003b38 <uart_printf>
40005340: b9400688     	ldr	w8, [x20, #0x4]
40005344: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40005348: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
4000534c: 911ad000     	add	x0, x0, #0x6b4
40005350: 53084d01     	ubfx	w1, w8, #8, #12
40005354: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005358: 17fff9f8     	b	0x40003b38 <uart_printf>

000000004000535c <pmm_alloc_page>:
4000535c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005360: d0000028     	adrp	x8, 0x4000b000 <next_pid>
40005364: f9000bf3     	str	x19, [sp, #0x10]
40005368: 910003fd     	mov	x29, sp
4000536c: b940050a     	ldr	w10, [x8, #0x4]
40005370: 3400030a     	cbz	w10, 0x400053d0 <pmm_alloc_page+0x74>
40005374: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005378: b94ba12b     	ldr	w11, [x9, #0xba0]
4000537c: 530f7d6c     	lsr	w12, w11, #15
40005380: 3500022c     	cbnz	w12, 0x400053c4 <pmm_alloc_page+0x68>
40005384: 52a8000c     	mov	w12, #0x40000000        // =1073741824
40005388: d503201f     	nop
4000538c: 101ac0ad     	adr	x13, 0x4003aba0 <memory_bitmap>
40005390: 0b0b318c     	add	w12, w12, w11, lsl #12
40005394: 5280002e     	mov	w14, #0x1               // =1
40005398: 2a0b03ef     	mov	w15, w11
4000539c: 12000971     	and	w17, w11, #0x7
400053a0: d343fdef     	lsr	x15, x15, #3
400053a4: 1ad121d1     	lsl	w17, w14, w17
400053a8: 386f69b0     	ldrb	w16, [x13, x15]
400053ac: 6a10023f     	tst	w17, w16
400053b0: 540001e0     	b.eq	0x400053ec <pmm_alloc_page+0x90>
400053b4: 1100056b     	add	w11, w11, #0x1
400053b8: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
400053bc: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
400053c0: 54fffec1     	b.ne	0x40005398 <pmm_alloc_page+0x3c>
400053c4: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
400053c8: 9111a000     	add	x0, x0, #0x468
400053cc: 14000003     	b	0x400053d8 <pmm_alloc_page+0x7c>
400053d0: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
400053d4: 911b2c00     	add	x0, x0, #0x6cb
400053d8: 97fff8c3     	bl	0x400036e4 <uart_puts>
400053dc: aa1f03e0     	mov	x0, xzr
400053e0: f9400bf3     	ldr	x19, [sp, #0x10]
400053e4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400053e8: d65f03c0     	ret
400053ec: 2a0c03f3     	mov	w19, w12
400053f0: 5100054a     	sub	w10, w10, #0x1
400053f4: 1100056b     	add	w11, w11, #0x1
400053f8: aa1303e0     	mov	x0, x19
400053fc: 2a1f03e1     	mov	w1, wzr
40005400: 52820002     	mov	w2, #0x1000             // =4096
40005404: 2a11020e     	orr	w14, w16, w17
40005408: 382f69ae     	strb	w14, [x13, x15]
4000540c: b900050a     	str	w10, [x8, #0x4]
40005410: b90ba12b     	str	w11, [x9, #0xba0]
40005414: 97fff564     	bl	0x400029a4 <memset>
40005418: aa1303e0     	mov	x0, x19
4000541c: 17fffff1     	b	0x400053e0 <pmm_alloc_page+0x84>

0000000040005420 <pmm_free_page>:
40005420: d35efc08     	lsr	x8, x0, #30
40005424: b4000128     	cbz	x8, 0x40005448 <pmm_free_page+0x28>
40005428: d35bfc08     	lsr	x8, x0, #27
4000542c: f100251f     	cmp	x8, #0x9
40005430: 540000c2     	b.hs	0x40005448 <pmm_free_page+0x28>
40005434: f2402c1f     	tst	x0, #0xfff
40005438: 540000e0     	b.eq	0x40005454 <pmm_free_page+0x34>
4000543c: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005440: 91218000     	add	x0, x0, #0x860
40005444: 17fff8a8     	b	0x400036e4 <uart_puts>
40005448: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000544c: 9106c000     	add	x0, x0, #0x1b0
40005450: 17fff8a5     	b	0x400036e4 <uart_puts>
40005454: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
40005458: d503201f     	nop
4000545c: 101aba2a     	adr	x10, 0x4003aba0 <memory_bitmap>
40005460: 8b080009     	add	x9, x0, x8
40005464: 5280002d     	mov	w13, #0x1               // =1
40005468: d34fad28     	ubfx	x8, x9, #15, #29
4000546c: d34c392c     	ubfx	x12, x9, #12, #3
40005470: 3868694b     	ldrb	w11, [x10, x8]
40005474: 1acc21ac     	lsl	w12, w13, w12
40005478: 6a0b019f     	tst	w12, w11
4000547c: 540001c0     	b.eq	0x400054b4 <pmm_free_page+0x94>
40005480: d000002e     	adrp	x14, 0x4000b000 <next_pid>
40005484: d00001ad     	adrp	x13, 0x4003b000 <memory_bitmap+0x460>
40005488: d34cfd29     	lsr	x9, x9, #12
4000548c: b94005cf     	ldr	w15, [x14, #0x4]
40005490: b94ba1b0     	ldr	w16, [x13, #0xba0]
40005494: 0a2c016b     	bic	w11, w11, w12
40005498: 3828694b     	strb	w11, [x10, x8]
4000549c: 110005e8     	add	w8, w15, #0x1
400054a0: 6b09021f     	cmp	w16, w9
400054a4: b90005c8     	str	w8, [x14, #0x4]
400054a8: 54000049     	b.ls	0x400054b0 <pmm_free_page+0x90>
400054ac: b90ba1a9     	str	w9, [x13, #0xba0]
400054b0: d65f03c0     	ret
400054b4: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400054b8: 912ea400     	add	x0, x0, #0xba9
400054bc: 17fff88a     	b	0x400036e4 <uart_puts>

00000000400054c0 <pmm_get_free_memory>:
400054c0: d0000028     	adrp	x8, 0x4000b000 <next_pid>
400054c4: b9400508     	ldr	w8, [x8, #0x4]
400054c8: 53144d00     	lsl	w0, w8, #12
400054cc: d65f03c0     	ret

00000000400054d0 <sched_init>:
400054d0: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400054d4: 912ec108     	add	x8, x8, #0xbb0
400054d8: d2c00029     	mov	x9, #0x100000000        // =4294967296
400054dc: f9001109     	str	x9, [x8, #0x20]
400054e0: d2c00049     	mov	x9, #0x200000000        // =8589934592
400054e4: d503201f     	nop
400054e8: 1001b4a0     	adr	x0, 0x40008b7c <__rodata_start+0xb7c>
400054ec: f9001d09     	str	x9, [x8, #0x38]
400054f0: d2c00069     	mov	x9, #0x300000000        // =12884901888
400054f4: f9002909     	str	x9, [x8, #0x50]
400054f8: d2c00089     	mov	x9, #0x400000000        // =17179869184
400054fc: f9003509     	str	x9, [x8, #0x68]
40005500: d2c000a9     	mov	x9, #0x500000000        // =21474836480
40005504: f9004109     	str	x9, [x8, #0x80]
40005508: d2c000c9     	mov	x9, #0x600000000        // =25769803776
4000550c: f9004d09     	str	x9, [x8, #0x98]
40005510: d2c000e9     	mov	x9, #0x700000000        // =30064771072
40005514: f9005909     	str	x9, [x8, #0xb0]
40005518: d2c00109     	mov	x9, #0x800000000        // =34359738368
4000551c: f9006509     	str	x9, [x8, #0xc8]
40005520: d2c00129     	mov	x9, #0x900000000        // =38654705664
40005524: f9007109     	str	x9, [x8, #0xe0]
40005528: d2c00149     	mov	x9, #0xa00000000        // =42949672960
4000552c: f9007d09     	str	x9, [x8, #0xf8]
40005530: d2c00169     	mov	x9, #0xb00000000        // =47244640256
40005534: f9008909     	str	x9, [x8, #0x110]
40005538: d2c00189     	mov	x9, #0xc00000000        // =51539607552
4000553c: f9009509     	str	x9, [x8, #0x128]
40005540: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
40005544: f900a109     	str	x9, [x8, #0x140]
40005548: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
4000554c: f900ad09     	str	x9, [x8, #0x158]
40005550: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
40005554: f900b909     	str	x9, [x8, #0x170]
40005558: 52800049     	mov	w9, #0x2                // =2
4000555c: a900251f     	stp	xzr, x9, [x8]
40005560: d0000028     	adrp	x8, 0x4000b000 <next_pid>
40005564: b900091f     	str	wzr, [x8, #0x8]
40005568: 17fff85f     	b	0x400036e4 <uart_puts>

000000004000556c <sched_create_task>:
4000556c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005570: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005574: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005578: aa0003f3     	mov	x19, x0
4000557c: b94bd108     	ldr	w8, [x8, #0xbd0]
40005580: f9000bf7     	str	x23, [sp, #0x10]
40005584: 910003fd     	mov	x29, sp
40005588: a90257f6     	stp	x22, x21, [sp, #0x20]
4000558c: 340005c8     	cbz	w8, 0x40005644 <sched_create_task+0xd8>
40005590: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005594: b94be908     	ldr	w8, [x8, #0xbe8]
40005598: 340005a8     	cbz	w8, 0x4000564c <sched_create_task+0xe0>
4000559c: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055a0: b94c0108     	ldr	w8, [x8, #0xc00]
400055a4: 34000588     	cbz	w8, 0x40005654 <sched_create_task+0xe8>
400055a8: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055ac: b94c1908     	ldr	w8, [x8, #0xc18]
400055b0: 34000568     	cbz	w8, 0x4000565c <sched_create_task+0xf0>
400055b4: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055b8: b94c3108     	ldr	w8, [x8, #0xc30]
400055bc: 34000548     	cbz	w8, 0x40005664 <sched_create_task+0xf8>
400055c0: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055c4: b94c4908     	ldr	w8, [x8, #0xc48]
400055c8: 34000528     	cbz	w8, 0x4000566c <sched_create_task+0x100>
400055cc: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055d0: b94c6108     	ldr	w8, [x8, #0xc60]
400055d4: 34000508     	cbz	w8, 0x40005674 <sched_create_task+0x108>
400055d8: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055dc: b94c7908     	ldr	w8, [x8, #0xc78]
400055e0: 340004e8     	cbz	w8, 0x4000567c <sched_create_task+0x110>
400055e4: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055e8: b94c9108     	ldr	w8, [x8, #0xc90]
400055ec: 340004c8     	cbz	w8, 0x40005684 <sched_create_task+0x118>
400055f0: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400055f4: b94ca908     	ldr	w8, [x8, #0xca8]
400055f8: 340004a8     	cbz	w8, 0x4000568c <sched_create_task+0x120>
400055fc: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005600: b94cc108     	ldr	w8, [x8, #0xcc0]
40005604: 34000488     	cbz	w8, 0x40005694 <sched_create_task+0x128>
40005608: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
4000560c: b94cd908     	ldr	w8, [x8, #0xcd8]
40005610: 34000468     	cbz	w8, 0x4000569c <sched_create_task+0x130>
40005614: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005618: b94cf108     	ldr	w8, [x8, #0xcf0]
4000561c: 34000448     	cbz	w8, 0x400056a4 <sched_create_task+0x138>
40005620: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005624: b94d0908     	ldr	w8, [x8, #0xd08]
40005628: 34000428     	cbz	w8, 0x400056ac <sched_create_task+0x140>
4000562c: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005630: b94d2108     	ldr	w8, [x8, #0xd20]
40005634: 34000408     	cbz	w8, 0x400056b4 <sched_create_task+0x148>
40005638: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
4000563c: 9108d800     	add	x0, x0, #0x236
40005640: 1400003c     	b	0x40005730 <sched_create_task+0x1c4>
40005644: 52800034     	mov	w20, #0x1               // =1
40005648: 1400001c     	b	0x400056b8 <sched_create_task+0x14c>
4000564c: 52800054     	mov	w20, #0x2               // =2
40005650: 1400001a     	b	0x400056b8 <sched_create_task+0x14c>
40005654: 52800074     	mov	w20, #0x3               // =3
40005658: 14000018     	b	0x400056b8 <sched_create_task+0x14c>
4000565c: 52800094     	mov	w20, #0x4               // =4
40005660: 14000016     	b	0x400056b8 <sched_create_task+0x14c>
40005664: 528000b4     	mov	w20, #0x5               // =5
40005668: 14000014     	b	0x400056b8 <sched_create_task+0x14c>
4000566c: 528000d4     	mov	w20, #0x6               // =6
40005670: 14000012     	b	0x400056b8 <sched_create_task+0x14c>
40005674: 528000f4     	mov	w20, #0x7               // =7
40005678: 14000010     	b	0x400056b8 <sched_create_task+0x14c>
4000567c: 52800114     	mov	w20, #0x8               // =8
40005680: 1400000e     	b	0x400056b8 <sched_create_task+0x14c>
40005684: 52800134     	mov	w20, #0x9               // =9
40005688: 1400000c     	b	0x400056b8 <sched_create_task+0x14c>
4000568c: 52800154     	mov	w20, #0xa               // =10
40005690: 1400000a     	b	0x400056b8 <sched_create_task+0x14c>
40005694: 52800174     	mov	w20, #0xb               // =11
40005698: 14000008     	b	0x400056b8 <sched_create_task+0x14c>
4000569c: 52800194     	mov	w20, #0xc               // =12
400056a0: 14000006     	b	0x400056b8 <sched_create_task+0x14c>
400056a4: 528001b4     	mov	w20, #0xd               // =13
400056a8: 14000004     	b	0x400056b8 <sched_create_task+0x14c>
400056ac: 528001d4     	mov	w20, #0xe               // =14
400056b0: 14000002     	b	0x400056b8 <sched_create_task+0x14c>
400056b4: 528001f4     	mov	w20, #0xf               // =15
400056b8: 97ffff29     	bl	0x4000535c <pmm_alloc_page>
400056bc: b4000360     	cbz	x0, 0x40005728 <sched_create_task+0x1bc>
400056c0: 52800308     	mov	w8, #0x18               // =24
400056c4: d503201f     	nop
400056c8: 101b2709     	adr	x9, 0x4003bba8 <tasks>
400056cc: 9ba82696     	umaddl	x22, w20, w8, x9
400056d0: 913bc015     	add	x21, x0, #0xef0
400056d4: aa0003f7     	mov	x23, x0
400056d8: 2a1f03e1     	mov	w1, wzr
400056dc: 52802202     	mov	w2, #0x110              // =272
400056e0: f90006c0     	str	x0, [x22, #0x8]
400056e4: aa1503e0     	mov	x0, x21
400056e8: 97fff4af     	bl	0x400029a4 <memset>
400056ec: 52800029     	mov	w9, #0x1                // =1
400056f0: f907f6f3     	str	x19, [x23, #0xfe8]
400056f4: 528000a8     	mov	w8, #0x5                // =5
400056f8: f90002d5     	str	x21, [x22]
400056fc: 2a1403e1     	mov	w1, w20
40005700: 2a1303e2     	mov	w2, w19
40005704: b90012c9     	str	w9, [x22, #0x10]
40005708: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000570c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005710: f907fae8     	str	x8, [x23, #0xff0]
40005714: f9400bf7     	ldr	x23, [sp, #0x10]
40005718: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000571c: 911f2800     	add	x0, x0, #0x7ca
40005720: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005724: 17fff905     	b	0x40003b38 <uart_printf>
40005728: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
4000572c: 9118bc00     	add	x0, x0, #0x62f
40005730: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005734: f9400bf7     	ldr	x23, [sp, #0x10]
40005738: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000573c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005740: 17fff7e9     	b	0x400036e4 <uart_puts>

0000000040005744 <sched_switch>:
40005744: d0000028     	adrp	x8, 0x4000b000 <next_pid>
40005748: b940090b     	ldr	w11, [x8, #0x8]
4000574c: 3100057f     	cmn	w11, #0x1
40005750: 54000300     	b.eq	0x400057b0 <sched_switch+0x6c>
40005754: 5280030a     	mov	w10, #0x18              // =24
40005758: d503201f     	nop
4000575c: 101b2269     	adr	x9, 0x4003bba8 <tasks>
40005760: 9b2a256c     	smaddl	x12, w11, w10, x9
40005764: 9b2a7d6d     	smull	x13, w11, w10
40005768: b8410d8e     	ldr	w14, [x12, #0x10]!
4000576c: f82d6920     	str	x0, [x9, x13]
40005770: 710009df     	cmp	w14, #0x2
40005774: 54000061     	b.ne	0x40005780 <sched_switch+0x3c>
40005778: 5280002d     	mov	w13, #0x1               // =1
4000577c: b900018d     	str	w13, [x12]
40005780: 5280020c     	mov	w12, #0x10              // =16
40005784: 1100056b     	add	w11, w11, #0x1
40005788: 6b0b03ed     	negs	w13, w11
4000578c: 12000d6b     	and	w11, w11, #0xf
40005790: 12000dad     	and	w13, w13, #0xf
40005794: 5a8d456b     	csneg	w11, w11, w13, mi
40005798: 9b2a256d     	smaddl	x13, w11, w10, x9
4000579c: b8410dae     	ldr	w14, [x13, #0x10]!
400057a0: 710005df     	cmp	w14, #0x1
400057a4: 54000080     	b.eq	0x400057b4 <sched_switch+0x70>
400057a8: 7100058c     	subs	w12, w12, #0x1
400057ac: 54fffec1     	b.ne	0x40005784 <sched_switch+0x40>
400057b0: d65f03c0     	ret
400057b4: 5280030a     	mov	w10, #0x18              // =24
400057b8: b900090b     	str	w11, [x8, #0x8]
400057bc: 52800048     	mov	w8, #0x2                // =2
400057c0: 9b2a7d6a     	smull	x10, w11, w10
400057c4: b90001a8     	str	w8, [x13]
400057c8: f86a6920     	ldr	x0, [x9, x10]
400057cc: d65f03c0     	ret

00000000400057d0 <virtio_blk_init>:
400057d0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400057d4: 528d2ec9     	mov	w9, #0x6976             // =26998
400057d8: 52a14001     	mov	w1, #0xa000000          // =167772160
400057dc: 52800408     	mov	w8, #0x20               // =32
400057e0: 72ae8e49     	movk	w9, #0x7472, lsl #16
400057e4: a9014ff4     	stp	x20, x19, [sp, #0x10]
400057e8: 910003fd     	mov	x29, sp
400057ec: 14000004     	b	0x400057fc <virtio_blk_init+0x2c>
400057f0: f1000508     	subs	x8, x8, #0x1
400057f4: 91080021     	add	x1, x1, #0x200
400057f8: 540001a0     	b.eq	0x4000582c <virtio_blk_init+0x5c>
400057fc: b940002a     	ldr	w10, [x1]
40005800: 6b09015f     	cmp	w10, w9
40005804: 54ffff61     	b.ne	0x400057f0 <virtio_blk_init+0x20>
40005808: b9400422     	ldr	w2, [x1, #0x4]
4000580c: b940082a     	ldr	w10, [x1, #0x8]
40005810: 7100095f     	cmp	w10, #0x2
40005814: 54fffee1     	b.ne	0x400057f0 <virtio_blk_init+0x20>
40005818: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
4000581c: d503201f     	nop
40005820: 700231e0     	adr	x0, 0x40009e5f <__rodata_start+0x1e5f>
40005824: f9069501     	str	x1, [x8, #0xd28]
40005828: 97fff8c4     	bl	0x40003b38 <uart_printf>
4000582c: d00001b4     	adrp	x20, 0x4003b000 <memory_bitmap+0x460>
40005830: f9469688     	ldr	x8, [x20, #0xd28]
40005834: b40004a8     	cbz	x8, 0x400058c8 <virtio_blk_init+0xf8>
40005838: 52800029     	mov	w9, #0x1                // =1
4000583c: 5280006a     	mov	w10, #0x3               // =3
40005840: b900711f     	str	wzr, [x8, #0x70]
40005844: b9007109     	str	w9, [x8, #0x70]
40005848: b900710a     	str	w10, [x8, #0x70]
4000584c: b900211f     	str	wzr, [x8, #0x20]
40005850: b900311f     	str	wzr, [x8, #0x30]
40005854: b9403509     	ldr	w9, [x8, #0x34]
40005858: 34000409     	cbz	w9, 0x400058d8 <virtio_blk_init+0x108>
4000585c: 52800209     	mov	w9, #0x10               // =16
40005860: b9003909     	str	w9, [x8, #0x38]
40005864: 97fffebe     	bl	0x4000535c <pmm_alloc_page>
40005868: aa0003f3     	mov	x19, x0
4000586c: 97fffebc     	bl	0x4000535c <pmm_alloc_page>
40005870: b40003d3     	cbz	x19, 0x400058e8 <virtio_blk_init+0x118>
40005874: f9469688     	ldr	x8, [x20, #0xd28]
40005878: 52820009     	mov	w9, #0x1000             // =4096
4000587c: 9104026a     	add	x10, x19, #0x100
40005880: d34cfe6b     	lsr	x11, x19, #12
40005884: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40005888: 91172800     	add	x0, x0, #0x5ca
4000588c: b9002909     	str	w9, [x8, #0x28]
40005890: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005894: f9069d2a     	str	x10, [x9, #0xd38]
40005898: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
4000589c: 528224aa     	mov	w10, #0x1125            // =4389
400058a0: f9069933     	str	x19, [x9, #0xd30]
400058a4: 8b0a0269     	add	x9, x19, x10
400058a8: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
400058ac: 9274cd29     	and	x9, x9, #0xfffffffffffff000
400058b0: 52800033     	mov	w19, #0x1               // =1
400058b4: f906a149     	str	x9, [x10, #0xd40]
400058b8: 528000e9     	mov	w9, #0x7                // =7
400058bc: b900410b     	str	w11, [x8, #0x40]
400058c0: b9007109     	str	w9, [x8, #0x70]
400058c4: 14000008     	b	0x400058e4 <virtio_blk_init+0x114>
400058c8: 2a1f03f3     	mov	w19, wzr
400058cc: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400058d0: 91199800     	add	x0, x0, #0x666
400058d4: 14000004     	b	0x400058e4 <virtio_blk_init+0x114>
400058d8: 2a1f03f3     	mov	w19, wzr
400058dc: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
400058e0: 912f2400     	add	x0, x0, #0xbc9
400058e4: 97fff780     	bl	0x400036e4 <uart_puts>
400058e8: 2a1303e0     	mov	w0, w19
400058ec: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400058f0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400058f4: d65f03c0     	ret

00000000400058f8 <virtio_blk_read_sector>:
400058f8: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400058fc: f9469509     	ldr	x9, [x8, #0xd28]
40005900: b4001309     	cbz	x9, 0x40005b60 <virtio_blk_read_sector+0x268>
40005904: d10083ff     	sub	sp, sp, #0x20
40005908: d360fc09     	lsr	x9, x0, #32
4000590c: d00001ab     	adrp	x11, 0x4003b000 <memory_bitmap+0x460>
40005910: 9135216b     	add	x11, x11, #0xd48
40005914: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
40005918: 9135614a     	add	x10, x10, #0xd58
4000591c: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005920: 29012560     	stp	w0, w9, [x11, #0x8]
40005924: 52801fe9     	mov	w9, #0xff               // =255
40005928: d358fd6d     	lsr	x13, x11, #24
4000592c: 29007d7f     	stp	wzr, wzr, [x11]
40005930: d348fc2e     	lsr	x14, x1, #8
40005934: d368fd6c     	lsr	x12, x11, #40
40005938: 39000149     	strb	w9, [x10]
4000593c: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005940: d348fd4f     	lsr	x15, x10, #8
40005944: f9469929     	ldr	x9, [x9, #0xd30]
40005948: 910043fd     	add	x29, sp, #0x10
4000594c: 39000d2d     	strb	w13, [x9, #0x3]
40005950: d348fd6d     	lsr	x13, x11, #8
40005954: 3900452e     	strb	w14, [x9, #0x11]
40005958: 5280006e     	mov	w14, #0x3               // =3
4000595c: 3900052d     	strb	w13, [x9, #0x1]
40005960: d368fc2d     	lsr	x13, x1, #40
40005964: 3900712e     	strb	w14, [x9, #0x1c]
40005968: d368fd4e     	lsr	x14, x10, #40
4000596c: 3900552d     	strb	w13, [x9, #0x15]
40005970: 5280004d     	mov	w13, #0x2               // =2
40005974: 3900012b     	strb	w11, [x9]
40005978: 3900152c     	strb	w12, [x9, #0x5]
4000597c: d350fd6c     	lsr	x12, x11, #16
40005980: 3900652d     	strb	w13, [x9, #0x19]
40005984: 3900792d     	strb	w13, [x9, #0x1e]
40005988: 3900852f     	strb	w15, [x9, #0x21]
4000598c: d378fd6f     	lsr	x15, x11, #56
40005990: 3900b12d     	strb	w13, [x9, #0x2c]
40005994: d360fd6d     	lsr	x13, x11, #32
40005998: d370fd6b     	lsr	x11, x11, #48
4000599c: 3900952e     	strb	w14, [x9, #0x25]
400059a0: aa0903ee     	mov	x14, x9
400059a4: 38004dcd     	strb	w13, [x14, #0x4]!
400059a8: aa0903ed     	mov	x13, x9
400059ac: 390009cb     	strb	w11, [x14, #0x2]
400059b0: 5280020b     	mov	w11, #0x10              // =16
400059b4: 38008dab     	strb	w11, [x13, #0x8]!
400059b8: aa0903eb     	mov	x11, x9
400059bc: 39000dbf     	strb	wzr, [x13, #0x3]
400059c0: 390009bf     	strb	wzr, [x13, #0x2]
400059c4: d358fc2d     	lsr	x13, x1, #24
400059c8: 39000dcf     	strb	w15, [x14, #0x3]
400059cc: d350fc2e     	lsr	x14, x1, #16
400059d0: aa0903ef     	mov	x15, x9
400059d4: 38010d61     	strb	w1, [x11, #0x10]!
400059d8: 39000d6d     	strb	w13, [x11, #0x3]
400059dc: d360fc2d     	lsr	x13, x1, #32
400059e0: 3900096e     	strb	w14, [x11, #0x2]
400059e4: d378fc2e     	lsr	x14, x1, #56
400059e8: 38004d6d     	strb	w13, [x11, #0x4]!
400059ec: d370fc2d     	lsr	x13, x1, #48
400059f0: 39000d6e     	strb	w14, [x11, #0x3]
400059f4: aa0903ee     	mov	x14, x9
400059f8: 3900096d     	strb	w13, [x11, #0x2]
400059fc: d358fd4b     	lsr	x11, x10, #24
40005a00: d350fd4d     	lsr	x13, x10, #16
40005a04: 38020dca     	strb	w10, [x14, #0x20]!
40005a08: 39000dcb     	strb	w11, [x14, #0x3]
40005a0c: d360fd4b     	lsr	x11, x10, #32
40005a10: 390009cd     	strb	w13, [x14, #0x2]
40005a14: 38004dcb     	strb	w11, [x14, #0x4]!
40005a18: d378fd4b     	lsr	x11, x10, #56
40005a1c: d370fd4a     	lsr	x10, x10, #48
40005a20: 3900092c     	strb	w12, [x9, #0x2]
40005a24: 5280002c     	mov	w12, #0x1               // =1
40005a28: 39000dcb     	strb	w11, [x14, #0x3]
40005a2c: d00001ab     	adrp	x11, 0x4003b000 <memory_bitmap+0x460>
40005a30: 390009ca     	strb	w10, [x14, #0x2]
40005a34: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
40005a38: 795ab96d     	ldrh	w13, [x11, #0xd5c]
40005a3c: f9469d4e     	ldr	x14, [x10, #0xd38]
40005a40: 3900253f     	strb	wzr, [x9, #0x9]
40005a44: 92400dad     	and	x13, x13, #0xf
40005a48: 3900353f     	strb	wzr, [x9, #0xd]
40005a4c: 3900312c     	strb	w12, [x9, #0xc]
40005a50: 39003d3f     	strb	wzr, [x9, #0xf]
40005a54: 3900392c     	strb	w12, [x9, #0xe]
40005a58: 3900753f     	strb	wzr, [x9, #0x1d]
40005a5c: 39007d3f     	strb	wzr, [x9, #0x1f]
40005a60: 3900a53f     	strb	wzr, [x9, #0x29]
40005a64: 3900b53f     	strb	wzr, [x9, #0x2d]
40005a68: 3900bd3f     	strb	wzr, [x9, #0x2f]
40005a6c: 3900b93f     	strb	wzr, [x9, #0x2e]
40005a70: 38028d2c     	strb	w12, [x9, #0x28]!
40005a74: 8b0d05cc     	add	x12, x14, x13, lsl #1
40005a78: 38018dff     	strb	wzr, [x15, #0x18]!
40005a7c: 39000dff     	strb	wzr, [x15, #0x3]
40005a80: 390009ff     	strb	wzr, [x15, #0x2]
40005a84: 39000d3f     	strb	wzr, [x9, #0x3]
40005a88: 3900093f     	strb	wzr, [x9, #0x2]
40005a8c: 3900159f     	strb	wzr, [x12, #0x5]
40005a90: 3900119f     	strb	wzr, [x12, #0x4]
40005a94: d5033fbf     	dmb	sy
40005a98: 795ab969     	ldrh	w9, [x11, #0xd5c]
40005a9c: f9469d4a     	ldr	x10, [x10, #0xd38]
40005aa0: 11000529     	add	w9, w9, #0x1
40005aa4: 53087d2c     	lsr	w12, w9, #8
40005aa8: 791ab969     	strh	w9, [x11, #0xd5c]
40005aac: 39000949     	strb	w9, [x10, #0x2]
40005ab0: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005ab4: 39000d4c     	strb	w12, [x10, #0x3]
40005ab8: d5033fbf     	dmb	sy
40005abc: f9469508     	ldr	x8, [x8, #0xd28]
40005ac0: b900511f     	str	wzr, [x8, #0x50]
40005ac4: f946a128     	ldr	x8, [x9, #0xd40]
40005ac8: aa0803e9     	mov	x9, x8
40005acc: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005ad0: 3940052b     	ldrb	w11, [x9, #0x1]
40005ad4: 3940052c     	ldrb	w12, [x9, #0x1]
40005ad8: 3940012d     	ldrb	w13, [x9]
40005adc: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005ae0: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005ae4: 6b09015f     	cmp	w10, w9
40005ae8: 540002a1     	b.ne	0x40005b3c <virtio_blk_read_sector+0x244>
40005aec: 5292d00a     	mov	w10, #0x9680            // =38528
40005af0: 72a0130a     	movk	w10, #0x98, lsl #16
40005af4: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005af8: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005afc: 71018d7f     	cmp	w11, #0x63
40005b00: 540000ec     	b.gt	0x40005b1c <virtio_blk_read_sector+0x224>
40005b04: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005b08: 1100056b     	add	w11, w11, #0x1
40005b0c: b81fc3ab     	stur	w11, [x29, #-0x4]
40005b10: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005b14: 7101917f     	cmp	w11, #0x64
40005b18: 54ffff6b     	b.lt	0x40005b04 <virtio_blk_read_sector+0x20c>
40005b1c: 39400d0b     	ldrb	w11, [x8, #0x3]
40005b20: 3940090c     	ldrb	w12, [x8, #0x2]
40005b24: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005b28: 6b09017f     	cmp	w11, w9
40005b2c: 54000081     	b.ne	0x40005b3c <virtio_blk_read_sector+0x244>
40005b30: 7100055f     	cmp	w10, #0x1
40005b34: 5100054a     	sub	w10, w10, #0x1
40005b38: 54fffde8     	b.hi	0x40005af4 <virtio_blk_read_sector+0x1fc>
40005b3c: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005b40: 39756109     	ldrb	w9, [x8, #0xd58]
40005b44: 34000129     	cbz	w9, 0x40005b68 <virtio_blk_read_sector+0x270>
40005b48: 39756101     	ldrb	w1, [x8, #0xd58]
40005b4c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40005b50: 91034c00     	add	x0, x0, #0xd3
40005b54: 97fff7f9     	bl	0x40003b38 <uart_printf>
40005b58: 2a1f03e0     	mov	w0, wzr
40005b5c: 14000004     	b	0x40005b6c <virtio_blk_read_sector+0x274>
40005b60: 2a1f03e0     	mov	w0, wzr
40005b64: d65f03c0     	ret
40005b68: 52800020     	mov	w0, #0x1                // =1
40005b6c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005b70: 910083ff     	add	sp, sp, #0x20
40005b74: d65f03c0     	ret

0000000040005b78 <virtio_blk_write_sector>:
40005b78: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005b7c: f9469509     	ldr	x9, [x8, #0xd28]
40005b80: b4001289     	cbz	x9, 0x40005dd0 <virtio_blk_write_sector+0x258>
40005b84: d10083ff     	sub	sp, sp, #0x20
40005b88: d360fc0a     	lsr	x10, x0, #32
40005b8c: d00001ac     	adrp	x12, 0x4003b000 <memory_bitmap+0x460>
40005b90: 9135818c     	add	x12, x12, #0xd60
40005b94: 52800029     	mov	w9, #0x1                // =1
40005b98: d00001ab     	adrp	x11, 0x4003b000 <memory_bitmap+0x460>
40005b9c: 9135c16b     	add	x11, x11, #0xd70
40005ba0: 29012980     	stp	w0, w10, [x12, #0x8]
40005ba4: 52801fea     	mov	w10, #0xff              // =255
40005ba8: d368fd8d     	lsr	x13, x12, #40
40005bac: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005bb0: d358fd8e     	lsr	x14, x12, #24
40005bb4: d348fd6f     	lsr	x15, x11, #8
40005bb8: 29007d89     	stp	w9, wzr, [x12]
40005bbc: 910043fd     	add	x29, sp, #0x10
40005bc0: 3900016a     	strb	w10, [x11]
40005bc4: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
40005bc8: f946994a     	ldr	x10, [x10, #0xd30]
40005bcc: 3900154d     	strb	w13, [x10, #0x5]
40005bd0: d350fd8d     	lsr	x13, x12, #16
40005bd4: 39000d4e     	strb	w14, [x10, #0x3]
40005bd8: d348fd8e     	lsr	x14, x12, #8
40005bdc: 3900094d     	strb	w13, [x10, #0x2]
40005be0: d368fc2d     	lsr	x13, x1, #40
40005be4: 3900054e     	strb	w14, [x10, #0x1]
40005be8: d348fc2e     	lsr	x14, x1, #8
40005bec: 3900554d     	strb	w13, [x10, #0x15]
40005bf0: 5280004d     	mov	w13, #0x2               // =2
40005bf4: 3900454e     	strb	w14, [x10, #0x11]
40005bf8: d368fd6e     	lsr	x14, x11, #40
40005bfc: 3900014c     	strb	w12, [x10]
40005c00: 3900654d     	strb	w13, [x10, #0x19]
40005c04: 3900794d     	strb	w13, [x10, #0x1e]
40005c08: 3900854f     	strb	w15, [x10, #0x21]
40005c0c: d378fd8f     	lsr	x15, x12, #56
40005c10: 3900b14d     	strb	w13, [x10, #0x2c]
40005c14: d360fd8d     	lsr	x13, x12, #32
40005c18: d370fd8c     	lsr	x12, x12, #48
40005c1c: 3900954e     	strb	w14, [x10, #0x25]
40005c20: aa0a03ee     	mov	x14, x10
40005c24: 38004dcd     	strb	w13, [x14, #0x4]!
40005c28: aa0a03ed     	mov	x13, x10
40005c2c: 390009cc     	strb	w12, [x14, #0x2]
40005c30: 5280020c     	mov	w12, #0x10              // =16
40005c34: 38008dac     	strb	w12, [x13, #0x8]!
40005c38: aa0a03ec     	mov	x12, x10
40005c3c: 39000dbf     	strb	wzr, [x13, #0x3]
40005c40: 390009bf     	strb	wzr, [x13, #0x2]
40005c44: d358fc2d     	lsr	x13, x1, #24
40005c48: 39000dcf     	strb	w15, [x14, #0x3]
40005c4c: d350fc2e     	lsr	x14, x1, #16
40005c50: d360fd6f     	lsr	x15, x11, #32
40005c54: 38010d81     	strb	w1, [x12, #0x10]!
40005c58: 39000d8d     	strb	w13, [x12, #0x3]
40005c5c: d360fc2d     	lsr	x13, x1, #32
40005c60: 3900098e     	strb	w14, [x12, #0x2]
40005c64: d378fc2e     	lsr	x14, x1, #56
40005c68: 38004d8d     	strb	w13, [x12, #0x4]!
40005c6c: d370fc2d     	lsr	x13, x1, #48
40005c70: 39000d8e     	strb	w14, [x12, #0x3]
40005c74: aa0a03ee     	mov	x14, x10
40005c78: 3900098d     	strb	w13, [x12, #0x2]
40005c7c: d358fd6d     	lsr	x13, x11, #24
40005c80: aa0a03ec     	mov	x12, x10
40005c84: 38018ddf     	strb	wzr, [x14, #0x18]!
40005c88: 39000ddf     	strb	wzr, [x14, #0x3]
40005c8c: 390009df     	strb	wzr, [x14, #0x2]
40005c90: d350fd6e     	lsr	x14, x11, #16
40005c94: 38020d8b     	strb	w11, [x12, #0x20]!
40005c98: 39000d8d     	strb	w13, [x12, #0x3]
40005c9c: d378fd6d     	lsr	x13, x11, #56
40005ca0: d370fd6b     	lsr	x11, x11, #48
40005ca4: 3900098e     	strb	w14, [x12, #0x2]
40005ca8: d00001ae     	adrp	x14, 0x4003b000 <memory_bitmap+0x460>
40005cac: 38004d8f     	strb	w15, [x12, #0x4]!
40005cb0: 795ab9cf     	ldrh	w15, [x14, #0xd5c]
40005cb4: 39000d8d     	strb	w13, [x12, #0x3]
40005cb8: d00001ad     	adrp	x13, 0x4003b000 <memory_bitmap+0x460>
40005cbc: f9469dad     	ldr	x13, [x13, #0xd38]
40005cc0: 3900255f     	strb	wzr, [x10, #0x9]
40005cc4: 3900355f     	strb	wzr, [x10, #0xd]
40005cc8: 39003149     	strb	w9, [x10, #0xc]
40005ccc: 39003d5f     	strb	wzr, [x10, #0xf]
40005cd0: 39003949     	strb	w9, [x10, #0xe]
40005cd4: 3900755f     	strb	wzr, [x10, #0x1d]
40005cd8: 39007149     	strb	w9, [x10, #0x1c]
40005cdc: 39007d5f     	strb	wzr, [x10, #0x1f]
40005ce0: 3900a55f     	strb	wzr, [x10, #0x29]
40005ce4: 3900b55f     	strb	wzr, [x10, #0x2d]
40005ce8: 3900bd5f     	strb	wzr, [x10, #0x2f]
40005cec: 3900b95f     	strb	wzr, [x10, #0x2e]
40005cf0: 38028d49     	strb	w9, [x10, #0x28]!
40005cf4: 92400de9     	and	x9, x15, #0xf
40005cf8: 8b0905a9     	add	x9, x13, x9, lsl #1
40005cfc: 39000d5f     	strb	wzr, [x10, #0x3]
40005d00: 3900095f     	strb	wzr, [x10, #0x2]
40005d04: 110005ea     	add	w10, w15, #0x1
40005d08: 3900098b     	strb	w11, [x12, #0x2]
40005d0c: 3900153f     	strb	wzr, [x9, #0x5]
40005d10: 3900113f     	strb	wzr, [x9, #0x4]
40005d14: 53087d49     	lsr	w9, w10, #8
40005d18: 791ab9ca     	strh	w10, [x14, #0xd5c]
40005d1c: 390009aa     	strb	w10, [x13, #0x2]
40005d20: 39000da9     	strb	w9, [x13, #0x3]
40005d24: d00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40005d28: d5033fbf     	dmb	sy
40005d2c: f9469508     	ldr	x8, [x8, #0xd28]
40005d30: b900511f     	str	wzr, [x8, #0x50]
40005d34: f946a128     	ldr	x8, [x9, #0xd40]
40005d38: aa0803e9     	mov	x9, x8
40005d3c: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005d40: 3940052b     	ldrb	w11, [x9, #0x1]
40005d44: 3940052c     	ldrb	w12, [x9, #0x1]
40005d48: 3940012d     	ldrb	w13, [x9]
40005d4c: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005d50: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005d54: 6b09015f     	cmp	w10, w9
40005d58: 540002a1     	b.ne	0x40005dac <virtio_blk_write_sector+0x234>
40005d5c: 5292d00a     	mov	w10, #0x9680            // =38528
40005d60: 72a0130a     	movk	w10, #0x98, lsl #16
40005d64: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005d68: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d6c: 71018d7f     	cmp	w11, #0x63
40005d70: 540000ec     	b.gt	0x40005d8c <virtio_blk_write_sector+0x214>
40005d74: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d78: 1100056b     	add	w11, w11, #0x1
40005d7c: b81fc3ab     	stur	w11, [x29, #-0x4]
40005d80: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d84: 7101917f     	cmp	w11, #0x64
40005d88: 54ffff6b     	b.lt	0x40005d74 <virtio_blk_write_sector+0x1fc>
40005d8c: 39400d0b     	ldrb	w11, [x8, #0x3]
40005d90: 3940090c     	ldrb	w12, [x8, #0x2]
40005d94: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005d98: 6b09017f     	cmp	w11, w9
40005d9c: 54000081     	b.ne	0x40005dac <virtio_blk_write_sector+0x234>
40005da0: 7100055f     	cmp	w10, #0x1
40005da4: 5100054a     	sub	w10, w10, #0x1
40005da8: 54fffde8     	b.hi	0x40005d64 <virtio_blk_write_sector+0x1ec>
40005dac: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005db0: 3975c109     	ldrb	w9, [x8, #0xd70]
40005db4: 34000129     	cbz	w9, 0x40005dd8 <virtio_blk_write_sector+0x260>
40005db8: 3975c101     	ldrb	w1, [x8, #0xd70]
40005dbc: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005dc0: 9129ec00     	add	x0, x0, #0xa7b
40005dc4: 97fff75d     	bl	0x40003b38 <uart_printf>
40005dc8: 2a1f03e0     	mov	w0, wzr
40005dcc: 14000004     	b	0x40005ddc <virtio_blk_write_sector+0x264>
40005dd0: 2a1f03e0     	mov	w0, wzr
40005dd4: d65f03c0     	ret
40005dd8: 52800020     	mov	w0, #0x1                // =1
40005ddc: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005de0: 910083ff     	add	sp, sp, #0x20
40005de4: d65f03c0     	ret

0000000040005de8 <fat16_init>:
40005de8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005dec: a9014ffc     	stp	x28, x19, [sp, #0x10]
40005df0: 910003fd     	mov	x29, sp
40005df4: d10803ff     	sub	sp, sp, #0x200
40005df8: d503201f     	nop
40005dfc: 1001b020     	adr	x0, 0x40009400 <__rodata_start+0x1400>
40005e00: 97fff639     	bl	0x400036e4 <uart_puts>
40005e04: 910003e1     	mov	x1, sp
40005e08: aa1f03e0     	mov	x0, xzr
40005e0c: 97fffebb     	bl	0x400058f8 <virtio_blk_read_sector>
40005e10: 34000780     	cbz	w0, 0x40005f00 <fat16_init+0x118>
40005e14: d503201f     	nop
40005e18: 101afaf3     	adr	x19, 0x4003bd74 <bpb>
40005e1c: 910003e1     	mov	x1, sp
40005e20: aa1303e0     	mov	x0, x19
40005e24: 528007c2     	mov	w2, #0x3e               // =62
40005e28: 97fff2f5     	bl	0x400029fc <memcpy>
40005e2c: 90000021     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40005e30: 91011821     	add	x1, x1, #0x46
40005e34: 9100da60     	add	x0, x19, #0x36
40005e38: 528000a2     	mov	w2, #0x5                // =5
40005e3c: 97fff29e     	bl	0x400028b4 <kstrncmp>
40005e40: 34000160     	cbz	w0, 0x40005e6c <fat16_init+0x84>
40005e44: d00001a0     	adrp	x0, 0x4003b000 <memory_bitmap+0x460>
40005e48: 9136a800     	add	x0, x0, #0xdaa
40005e4c: 90000021     	adrp	x1, 0x40009000 <__rodata_start+0x1000>
40005e50: 910ae421     	add	x1, x1, #0x2b9
40005e54: 528000a2     	mov	w2, #0x5                // =5
40005e58: 97fff297     	bl	0x400028b4 <kstrncmp>
40005e5c: 34000080     	cbz	w0, 0x40005e6c <fat16_init+0x84>
40005e60: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005e64: 9132d000     	add	x0, x0, #0xcb4
40005e68: 97fff61f     	bl	0x400036e4 <uart_puts>
40005e6c: d00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40005e70: 9135fd08     	add	x8, x8, #0xd7f
40005e74: d00001b3     	adrp	x19, 0x4003b000 <memory_bitmap+0x460>
40005e78: 39401d09     	ldrb	w9, [x8, #0x7]
40005e7c: 3940190a     	ldrb	w10, [x8, #0x6]
40005e80: 3940050b     	ldrb	w11, [x8, #0x1]
40005e84: 3940010c     	ldrb	w12, [x8]
40005e88: 39400d0d     	ldrb	w13, [x8, #0x3]
40005e8c: 39400901     	ldrb	w1, [x8, #0x2]
40005e90: 2a092142     	orr	w2, w10, w9, lsl #8
40005e94: f0000000     	adrp	x0, 0x40008000 <__rodata_start>
40005e98: 9126e000     	add	x0, x0, #0x9b8
40005e9c: 2a0b2189     	orr	w9, w12, w11, lsl #8
40005ea0: 3940310b     	ldrb	w11, [x8, #0xc]
40005ea4: 39402d0c     	ldrb	w12, [x8, #0xb]
40005ea8: 0b02152a     	add	w10, w9, w2, lsl #5
40005eac: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005eb0: 3940150c     	ldrb	w12, [x8, #0x5]
40005eb4: 5100054a     	sub	w10, w10, #0x1
40005eb8: 1ac90d49     	sdiv	w9, w10, w9
40005ebc: 3940110a     	ldrb	w10, [x8, #0x4]
40005ec0: 2a0a21aa     	orr	w10, w13, w10, lsl #8
40005ec4: 1b0c296b     	madd	w11, w11, w12, w10
40005ec8: d00001ac     	adrp	x12, 0x4003b000 <memory_bitmap+0x460>
40005ecc: b90db58a     	str	w10, [x12, #0xdb4]
40005ed0: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
40005ed4: b90db94b     	str	w11, [x10, #0xdb8]
40005ed8: d00001aa     	adrp	x10, 0x4003b000 <memory_bitmap+0x460>
40005edc: b90dbd49     	str	w9, [x10, #0xdbc]
40005ee0: 0b0b0129     	add	w9, w9, w11
40005ee4: b90dc269     	str	w9, [x19, #0xdc0]
40005ee8: 97fff714     	bl	0x40003b38 <uart_printf>
40005eec: b94dc261     	ldr	w1, [x19, #0xdc0]
40005ef0: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x2000>
40005ef4: 9103dc00     	add	x0, x0, #0xf7
40005ef8: 97fff710     	bl	0x40003b38 <uart_printf>
40005efc: 14000004     	b	0x40005f0c <fat16_init+0x124>
40005f00: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40005f04: 911fe400     	add	x0, x0, #0x7f9
40005f08: 97fff5f7     	bl	0x400036e4 <uart_puts>
40005f0c: 910803ff     	add	sp, sp, #0x200
40005f10: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40005f14: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005f18: d65f03c0     	ret

0000000040005f1c <fat16_list_root>:
40005f1c: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40005f20: a9016ffc     	stp	x28, x27, [sp, #0x10]
40005f24: 910003fd     	mov	x29, sp
40005f28: a90267fa     	stp	x26, x25, [sp, #0x20]
40005f2c: a9035ff8     	stp	x24, x23, [sp, #0x30]
40005f30: a90457f6     	stp	x22, x21, [sp, #0x40]
40005f34: a9054ff4     	stp	x20, x19, [sp, #0x50]
40005f38: d10843ff     	sub	sp, sp, #0x210
40005f3c: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x1000>
40005f40: 91208400     	add	x0, x0, #0x821
40005f44: 97fff5e8     	bl	0x400036e4 <uart_puts>
40005f48: d00001b5     	adrp	x21, 0x4003b000 <memory_bitmap+0x460>
40005f4c: b94dbea8     	ldr	w8, [x21, #0xdbc]
40005f50: 34000ee8     	cbz	w8, 0x4000612c <fat16_list_root+0x210>
40005f54: 2a1f03f6     	mov	w22, wzr
40005f58: d00001b7     	adrp	x23, 0x4003b000 <memory_bitmap+0x460>
40005f5c: 910003f8     	mov	x24, sp
40005f60: 90000033     	adrp	x19, 0x40009000 <__rodata_start+0x1000>
40005f64: 913a6673     	add	x19, x19, #0xe99
40005f68: 90000034     	adrp	x20, 0x40009000 <__rodata_start+0x1000>
40005f6c: 91109a94     	add	x20, x20, #0x426
40005f70: 528005d9     	mov	w25, #0x2e              // =46
40005f74: 14000005     	b	0x40005f88 <fat16_list_root+0x6c>
40005f78: b94dbea8     	ldr	w8, [x21, #0xdbc]
40005f7c: 110006d6     	add	w22, w22, #0x1
40005f80: 6b0802df     	cmp	w22, w8
40005f84: 54000d42     	b.hs	0x4000612c <fat16_list_root+0x210>
40005f88: b94dbae8     	ldr	w8, [x23, #0xdb8]
40005f8c: 910043e1     	add	x1, sp, #0x10
40005f90: 910043fa     	add	x26, sp, #0x10
40005f94: 0b160100     	add	w0, w8, w22
40005f98: 97fffe58     	bl	0x400058f8 <virtio_blk_read_sector>
40005f9c: 5280021b     	mov	w27, #0x10              // =16
40005fa0: 14000010     	b	0x40005fe0 <fat16_list_root+0xc4>
40005fa4: aa1a03e8     	mov	x8, x26
40005fa8: 910003e1     	mov	x1, sp
40005fac: aa1303e0     	mov	x0, x19
40005fb0: 3841cd09     	ldrb	w9, [x8, #0x1c]!
40005fb4: 3940090a     	ldrb	w10, [x8, #0x2]
40005fb8: 3940050b     	ldrb	w11, [x8, #0x1]
40005fbc: 39400d08     	ldrb	w8, [x8, #0x3]
40005fc0: 53103d4a     	lsl	w10, w10, #16
40005fc4: 2a0b2129     	orr	w9, w9, w11, lsl #8
40005fc8: 2a086148     	orr	w8, w10, w8, lsl #24
40005fcc: 2a090102     	orr	w2, w8, w9
40005fd0: 97fff6da     	bl	0x40003b38 <uart_printf>
40005fd4: f100077b     	subs	x27, x27, #0x1
40005fd8: 9100835a     	add	x26, x26, #0x20
40005fdc: 54fffce0     	b.eq	0x40005f78 <fat16_list_root+0x5c>
40005fe0: 39400349     	ldrb	w9, [x26]
40005fe4: 7103953f     	cmp	w9, #0xe5
40005fe8: 54ffff60     	b.eq	0x40005fd4 <fat16_list_root+0xb8>
40005fec: 34000a09     	cbz	w9, 0x4000612c <fat16_list_root+0x210>
40005ff0: 39402f48     	ldrb	w8, [x26, #0xb]
40005ff4: 72000d1f     	tst	w8, #0xf
40005ff8: 54fffee1     	b.ne	0x40005fd4 <fat16_list_root+0xb8>
40005ffc: 7100813f     	cmp	w9, #0x20
40006000: 54000061     	b.ne	0x4000600c <fat16_list_root+0xf0>
40006004: aa1f03e9     	mov	x9, xzr
40006008: 14000003     	b	0x40006014 <fat16_list_root+0xf8>
4000600c: 390003e9     	strb	w9, [sp]
40006010: 52800029     	mov	w9, #0x1                // =1
40006014: 3940074a     	ldrb	w10, [x26, #0x1]
40006018: 7100815f     	cmp	w10, #0x20
4000601c: 54000080     	b.eq	0x4000602c <fat16_list_root+0x110>
40006020: aa09030b     	orr	x11, x24, x9
40006024: 91000529     	add	x9, x9, #0x1
40006028: 3900016a     	strb	w10, [x11]
4000602c: 39400b4a     	ldrb	w10, [x26, #0x2]
40006030: 7100815f     	cmp	w10, #0x20
40006034: 54000080     	b.eq	0x40006044 <fat16_list_root+0x128>
40006038: aa09030b     	orr	x11, x24, x9
4000603c: 91000529     	add	x9, x9, #0x1
40006040: 3900016a     	strb	w10, [x11]
40006044: 39400f4a     	ldrb	w10, [x26, #0x3]
40006048: 7100815f     	cmp	w10, #0x20
4000604c: 54000080     	b.eq	0x4000605c <fat16_list_root+0x140>
40006050: 9100052b     	add	x11, x9, #0x1
40006054: 38296b0a     	strb	w10, [x24, x9]
40006058: aa0b03e9     	mov	x9, x11
4000605c: 3940134a     	ldrb	w10, [x26, #0x4]
40006060: 7100815f     	cmp	w10, #0x20
40006064: 54000080     	b.eq	0x40006074 <fat16_list_root+0x158>
40006068: 9100052b     	add	x11, x9, #0x1
4000606c: 38296b0a     	strb	w10, [x24, x9]
40006070: aa0b03e9     	mov	x9, x11
40006074: 3940174a     	ldrb	w10, [x26, #0x5]
40006078: 7100815f     	cmp	w10, #0x20
4000607c: 54000080     	b.eq	0x4000608c <fat16_list_root+0x170>
40006080: 9100052b     	add	x11, x9, #0x1
40006084: 38296b0a     	strb	w10, [x24, x9]
40006088: aa0b03e9     	mov	x9, x11
4000608c: 39401b4a     	ldrb	w10, [x26, #0x6]
40006090: 7100815f     	cmp	w10, #0x20
40006094: 54000080     	b.eq	0x400060a4 <fat16_list_root+0x188>
40006098: 9100052b     	add	x11, x9, #0x1
4000609c: 38296b0a     	strb	w10, [x24, x9]
400060a0: aa0b03e9     	mov	x9, x11
400060a4: 39401f4a     	ldrb	w10, [x26, #0x7]
400060a8: 7100815f     	cmp	w10, #0x20
400060ac: 54000080     	b.eq	0x400060bc <fat16_list_root+0x1a0>
400060b0: 9100052b     	add	x11, x9, #0x1
400060b4: 38296b0a     	strb	w10, [x24, x9]
400060b8: aa0b03e9     	mov	x9, x11
400060bc: 3940234b     	ldrb	w11, [x26, #0x8]
400060c0: 7100817f     	cmp	w11, #0x20
400060c4: 540001e0     	b.eq	0x40006100 <fat16_list_root+0x1e4>
400060c8: 3940274c     	ldrb	w12, [x26, #0x9]
400060cc: 8b09030d     	add	x13, x24, x9
400060d0: 9100092a     	add	x10, x9, #0x2
400060d4: 390001b9     	strb	w25, [x13]
400060d8: 7100819f     	cmp	w12, #0x20
400060dc: 390005ab     	strb	w11, [x13, #0x1]
400060e0: 54000080     	b.eq	0x400060f0 <fat16_list_root+0x1d4>
400060e4: 91000d29     	add	x9, x9, #0x3
400060e8: 382a6b0c     	strb	w12, [x24, x10]
400060ec: aa0903ea     	mov	x10, x9
400060f0: 39402b4b     	ldrb	w11, [x26, #0xa]
400060f4: 7100817f     	cmp	w11, #0x20
400060f8: 54000101     	b.ne	0x40006118 <fat16_list_root+0x1fc>
400060fc: aa0a03e9     	mov	x9, x10
40006100: 38296b1f     	strb	wzr, [x24, x9]
40006104: 3627f508     	tbz	w8, #0x4, 0x40005fa4 <fat16_list_root+0x88>
40006108: 910003e1     	mov	x1, sp
4000610c: aa1403e0     	mov	x0, x20
40006110: 97fff68a     	bl	0x40003b38 <uart_printf>
40006114: 17ffffb0     	b	0x40005fd4 <fat16_list_root+0xb8>
40006118: 91000549     	add	x9, x10, #0x1
4000611c: 382a6b0b     	strb	w11, [x24, x10]
40006120: 38296b1f     	strb	wzr, [x24, x9]
40006124: 3627f408     	tbz	w8, #0x4, 0x40005fa4 <fat16_list_root+0x88>
40006128: 17fffff8     	b	0x40006108 <fat16_list_root+0x1ec>
4000612c: 910843ff     	add	sp, sp, #0x210
40006130: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006134: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006138: a9435ff8     	ldp	x24, x23, [sp, #0x30]
4000613c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006140: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006144: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006148: d65f03c0     	ret

000000004000614c <fat16_get_next_cluster>:
4000614c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40006150: f9000bfc     	str	x28, [sp, #0x10]
40006154: 910003fd     	mov	x29, sp
40006158: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000615c: d10803ff     	sub	sp, sp, #0x200
40006160: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40006164: 12181c09     	and	w9, w0, #0xff00
40006168: d37f1c13     	ubfiz	x19, x0, #1, #8
4000616c: b94db508     	ldr	w8, [x8, #0xdb4]
40006170: 910003e1     	mov	x1, sp
40006174: 910003f4     	mov	x20, sp
40006178: 0b492108     	add	w8, w8, w9, lsr #8
4000617c: aa0803e0     	mov	x0, x8
40006180: 97fffdde     	bl	0x400058f8 <virtio_blk_read_sector>
40006184: 8b130288     	add	x8, x20, x19
40006188: 39400509     	ldrb	w9, [x8, #0x1]
4000618c: 39400108     	ldrb	w8, [x8]
40006190: 2a092100     	orr	w0, w8, w9, lsl #8
40006194: 910803ff     	add	sp, sp, #0x200
40006198: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000619c: f9400bfc     	ldr	x28, [sp, #0x10]
400061a0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
400061a4: d65f03c0     	ret

00000000400061a8 <fat16_read_file>:
400061a8: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400061ac: a9016ffc     	stp	x28, x27, [sp, #0x10]
400061b0: 910003fd     	mov	x29, sp
400061b4: a90267fa     	stp	x26, x25, [sp, #0x20]
400061b8: a9035ff8     	stp	x24, x23, [sp, #0x30]
400061bc: a90457f6     	stp	x22, x21, [sp, #0x40]
400061c0: a9054ff4     	stp	x20, x19, [sp, #0x50]
400061c4: d110c3ff     	sub	sp, sp, #0x430
400061c8: aa0103f3     	mov	x19, x1
400061cc: 910877e1     	add	x1, sp, #0x21d
400061d0: aa0203f5     	mov	x21, x2
400061d4: 94000084     	bl	0x400063e4 <to_fat_name>
400061d8: b00001b4     	adrp	x20, 0x4003b000 <memory_bitmap+0x460>
400061dc: b94dbe88     	ldr	w8, [x20, #0xdbc]
400061e0: 34000788     	cbz	w8, 0x400062d0 <fat16_read_file+0x128>
400061e4: 2a1f03f6     	mov	w22, wzr
400061e8: b00001b7     	adrp	x23, 0x4003b000 <memory_bitmap+0x460>
400061ec: 910077f8     	add	x24, sp, #0x1d
400061f0: 14000005     	b	0x40006204 <fat16_read_file+0x5c>
400061f4: b94dbe88     	ldr	w8, [x20, #0xdbc]
400061f8: 110006d6     	add	w22, w22, #0x1
400061fc: 6b0802df     	cmp	w22, w8
40006200: 54000682     	b.hs	0x400062d0 <fat16_read_file+0x128>
40006204: b94dbae8     	ldr	w8, [x23, #0xdb8]
40006208: 910077e1     	add	x1, sp, #0x1d
4000620c: 0b160100     	add	w0, w8, w22
40006210: 97fffdba     	bl	0x400058f8 <virtio_blk_read_sector>
40006214: aa1f03f9     	mov	x25, xzr
40006218: 14000004     	b	0x40006228 <fat16_read_file+0x80>
4000621c: 91008339     	add	x25, x25, #0x20
40006220: f108033f     	cmp	x25, #0x200
40006224: 54fffe80     	b.eq	0x400061f4 <fat16_read_file+0x4c>
40006228: 38796b08     	ldrb	w8, [x24, x25]
4000622c: 7103951f     	cmp	w8, #0xe5
40006230: 54ffff60     	b.eq	0x4000621c <fat16_read_file+0x74>
40006234: 340004e8     	cbz	w8, 0x400062d0 <fat16_read_file+0x128>
40006238: 8b190308     	add	x8, x24, x25
4000623c: 39402d08     	ldrb	w8, [x8, #0xb]
40006240: 7200111f     	tst	w8, #0x1f
40006244: 54fffec1     	b.ne	0x4000621c <fat16_read_file+0x74>
40006248: 8b190300     	add	x0, x24, x25
4000624c: 910877e1     	add	x1, sp, #0x21d
40006250: 52800162     	mov	w2, #0xb                // =11
40006254: 97fff198     	bl	0x400028b4 <kstrncmp>
40006258: 35fffe20     	cbnz	w0, 0x4000621c <fat16_read_file+0x74>
4000625c: 910077e8     	add	x8, sp, #0x1d
40006260: 8b190108     	add	x8, x8, x25
40006264: aa0803e9     	mov	x9, x8
40006268: 3841cd2a     	ldrb	w10, [x9, #0x1c]!
4000626c: 3940092b     	ldrb	w11, [x9, #0x2]
40006270: 3940052c     	ldrb	w12, [x9, #0x1]
40006274: 39400d29     	ldrb	w9, [x9, #0x3]
40006278: d370bd6b     	lsl	x11, x11, #16
4000627c: aa0c214a     	orr	x10, x10, x12, lsl #8
40006280: aa096169     	orr	x9, x11, x9, lsl #24
40006284: aa0a0136     	orr	x22, x9, x10
40006288: 34000a16     	cbz	w22, 0x400063c8 <fat16_read_file+0x220>
4000628c: 39406d09     	ldrb	w9, [x8, #0x1b]
40006290: 39406908     	ldrb	w8, [x8, #0x1a]
40006294: 2a09210a     	orr	w10, w8, w9, lsl #8
40006298: 529ffea9     	mov	w9, #0xfff5             // =65525
4000629c: 51000948     	sub	w8, w10, #0x2
400062a0: 6b09011f     	cmp	w8, w9
400062a4: 540009a8     	b.hi	0x400063d8 <fat16_read_file+0x230>
400062a8: eb1502df     	cmp	x22, x21
400062ac: d10006b7     	sub	x23, x21, #0x1
400062b0: aa1f03f4     	mov	x20, xzr
400062b4: 9a9532c8     	csel	x8, x22, x21, lo
400062b8: eb1702df     	cmp	x22, x23
400062bc: b00001bb     	adrp	x27, 0x4003b000 <memory_bitmap+0x460>
400062c0: 9a9732d9     	csel	x25, x22, x23, lo
400062c4: 5280401c     	mov	w28, #0x200             // =512
400062c8: f90007e8     	str	x8, [sp, #0x8]
400062cc: 1400001b     	b	0x40006338 <fat16_read_file+0x190>
400062d0: 12800014     	mov	w20, #-0x1              // =-1
400062d4: 2a1403e0     	mov	w0, w20
400062d8: 9110c3ff     	add	sp, sp, #0x430
400062dc: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400062e0: a94457f6     	ldp	x22, x21, [sp, #0x40]
400062e4: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400062e8: a94267fa     	ldp	x26, x25, [sp, #0x20]
400062ec: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400062f0: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400062f4: d65f03c0     	ret
400062f8: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
400062fc: f9400be9     	ldr	x9, [sp, #0x10]
40006300: 9108a3e1     	add	x1, sp, #0x228
40006304: b94db508     	ldr	w8, [x8, #0xdb4]
40006308: d37f1d35     	ubfiz	x21, x9, #1, #8
4000630c: 0b492100     	add	w0, w8, w9, lsr #8
40006310: 97fffd7a     	bl	0x400058f8 <virtio_blk_read_sector>
40006314: 9108a3e8     	add	x8, sp, #0x228
40006318: 8b150108     	add	x8, x8, x21
4000631c: 39400509     	ldrb	w9, [x8, #0x1]
40006320: 39400108     	ldrb	w8, [x8]
40006324: 2a09210a     	orr	w10, w8, w9, lsl #8
40006328: 529ffec9     	mov	w9, #0xfff6             // =65526
4000632c: 51000948     	sub	w8, w10, #0x2
40006330: 6b09011f     	cmp	w8, w9
40006334: 54000542     	b.hs	0x400063dc <fat16_read_file+0x234>
40006338: f94007e8     	ldr	x8, [sp, #0x8]
4000633c: eb08029f     	cmp	x20, x8
40006340: 540004e2     	b.hs	0x400063dc <fat16_read_file+0x234>
40006344: 39760768     	ldrb	w8, [x27, #0xd81]
40006348: f9000bea     	str	x10, [sp, #0x10]
4000634c: 34fffd68     	cbz	w8, 0x400062f8 <fat16_read_file+0x150>
40006350: 51000949     	sub	w9, w10, #0x2
40006354: 52800038     	mov	w24, #0x1               // =1
40006358: 1b087d28     	mul	w8, w9, w8
4000635c: b00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
40006360: b94dc129     	ldr	w9, [x9, #0xdc0]
40006364: 0b08013a     	add	w26, w9, w8
40006368: 2a1a03e0     	mov	w0, w26
4000636c: 910077e1     	add	x1, sp, #0x1d
40006370: 97fffd62     	bl	0x400058f8 <virtio_blk_read_sector>
40006374: 91080288     	add	x8, x20, #0x200
40006378: cb1402c9     	sub	x9, x22, x20
4000637c: cb1402ea     	sub	x10, x23, x20
40006380: eb16011f     	cmp	x8, x22
40006384: 8b140260     	add	x0, x19, x20
40006388: 910077e1     	add	x1, sp, #0x1d
4000638c: 9a9c8128     	csel	x8, x9, x28, hi
40006390: 8b140109     	add	x9, x8, x20
40006394: eb17013f     	cmp	x9, x23
40006398: 9a888155     	csel	x21, x10, x8, hi
4000639c: aa1503e2     	mov	x2, x21
400063a0: 97fff197     	bl	0x400029fc <memcpy>
400063a4: 8b1402b4     	add	x20, x21, x20
400063a8: eb19029f     	cmp	x20, x25
400063ac: 54fffa62     	b.hs	0x400062f8 <fat16_read_file+0x150>
400063b0: 39760768     	ldrb	w8, [x27, #0xd81]
400063b4: 1100075a     	add	w26, w26, #0x1
400063b8: eb08031f     	cmp	x24, x8
400063bc: 91000718     	add	x24, x24, #0x1
400063c0: 54fffd43     	b.lo	0x40006368 <fat16_read_file+0x1c0>
400063c4: 17ffffcd     	b	0x400062f8 <fat16_read_file+0x150>
400063c8: 2a1f03f4     	mov	w20, wzr
400063cc: b4fff855     	cbz	x21, 0x400062d4 <fat16_read_file+0x12c>
400063d0: 3900027f     	strb	wzr, [x19]
400063d4: 17ffffc0     	b	0x400062d4 <fat16_read_file+0x12c>
400063d8: aa1f03f4     	mov	x20, xzr
400063dc: 38346a7f     	strb	wzr, [x19, x20]
400063e0: 17ffffbd     	b	0x400062d4 <fat16_read_file+0x12c>

00000000400063e4 <to_fat_name>:
400063e4: 52800408     	mov	w8, #0x20               // =32
400063e8: 39000028     	strb	w8, [x1]
400063ec: 39000428     	strb	w8, [x1, #0x1]
400063f0: 39000828     	strb	w8, [x1, #0x2]
400063f4: 39000c28     	strb	w8, [x1, #0x3]
400063f8: 39001028     	strb	w8, [x1, #0x4]
400063fc: 39001428     	strb	w8, [x1, #0x5]
40006400: 39001828     	strb	w8, [x1, #0x6]
40006404: 39001c28     	strb	w8, [x1, #0x7]
40006408: 39002028     	strb	w8, [x1, #0x8]
4000640c: 39002428     	strb	w8, [x1, #0x9]
40006410: 39002828     	strb	w8, [x1, #0xa]
40006414: 39400009     	ldrb	w9, [x0]
40006418: 340002a9     	cbz	w9, 0x4000646c <to_fat_name+0x88>
4000641c: aa1f03e8     	mov	x8, xzr
40006420: 9100040a     	add	x10, x0, #0x1
40006424: 12001d2b     	and	w11, w9, #0xff
40006428: 7100b97f     	cmp	w11, #0x2e
4000642c: 540001c0     	b.eq	0x40006464 <to_fat_name+0x80>
40006430: f1001d1f     	cmp	x8, #0x7
40006434: 54000188     	b.hi	0x40006464 <to_fat_name+0x80>
40006438: 5101852b     	sub	w11, w9, #0x61
4000643c: 5100812c     	sub	w12, w9, #0x20
40006440: 12001d6b     	and	w11, w11, #0xff
40006444: 7100697f     	cmp	w11, #0x1a
40006448: 9100050b     	add	x11, x8, #0x1
4000644c: 1a893189     	csel	w9, w12, w9, lo
40006450: 38286829     	strb	w9, [x1, x8]
40006454: 38686949     	ldrb	w9, [x10, x8]
40006458: aa0b03e8     	mov	x8, x11
4000645c: 35fffe49     	cbnz	w9, 0x40006424 <to_fat_name+0x40>
40006460: 2a0b03e8     	mov	w8, w11
40006464: 2a0803e9     	mov	w9, w8
40006468: 14000002     	b	0x40006470 <to_fat_name+0x8c>
4000646c: aa1f03e9     	mov	x9, xzr
40006470: 8b000128     	add	x8, x9, x0
40006474: 91000d08     	add	x8, x8, #0x3
40006478: 3869680a     	ldrb	w10, [x0, x9]
4000647c: 340000ea     	cbz	w10, 0x40006498 <to_fat_name+0xb4>
40006480: 7100b95f     	cmp	w10, #0x2e
40006484: 540000c0     	b.eq	0x4000649c <to_fat_name+0xb8>
40006488: 91000529     	add	x9, x9, #0x1
4000648c: 91000508     	add	x8, x8, #0x1
40006490: 3869680a     	ldrb	w10, [x0, x9]
40006494: 35ffff6a     	cbnz	w10, 0x40006480 <to_fat_name+0x9c>
40006498: d65f03c0     	ret
4000649c: 11000529     	add	w9, w9, #0x1
400064a0: 38694809     	ldrb	w9, [x0, w9, uxtw]
400064a4: 34ffffa9     	cbz	w9, 0x40006498 <to_fat_name+0xb4>
400064a8: 5101852a     	sub	w10, w9, #0x61
400064ac: 5100812b     	sub	w11, w9, #0x20
400064b0: 7100695f     	cmp	w10, #0x1a
400064b4: 1a893169     	csel	w9, w11, w9, lo
400064b8: 39002029     	strb	w9, [x1, #0x8]
400064bc: 385ff109     	ldurb	w9, [x8, #-0x1]
400064c0: 34fffec9     	cbz	w9, 0x40006498 <to_fat_name+0xb4>
400064c4: 5101852a     	sub	w10, w9, #0x61
400064c8: 5100812b     	sub	w11, w9, #0x20
400064cc: 7100695f     	cmp	w10, #0x1a
400064d0: 1a893169     	csel	w9, w11, w9, lo
400064d4: 39002429     	strb	w9, [x1, #0x9]
400064d8: 39400108     	ldrb	w8, [x8]
400064dc: 34fffde8     	cbz	w8, 0x40006498 <to_fat_name+0xb4>
400064e0: 51018509     	sub	w9, w8, #0x61
400064e4: 5100810a     	sub	w10, w8, #0x20
400064e8: 7100693f     	cmp	w9, #0x1a
400064ec: 1a883148     	csel	w8, w10, w8, lo
400064f0: 39002828     	strb	w8, [x1, #0xa]
400064f4: d65f03c0     	ret

00000000400064f8 <fat16_set_fat_entry>:
400064f8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400064fc: f9000bfc     	str	x28, [sp, #0x10]
40006500: 910003fd     	mov	x29, sp
40006504: a90257f6     	stp	x22, x21, [sp, #0x20]
40006508: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000650c: d10803ff     	sub	sp, sp, #0x200
40006510: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40006514: 12181c09     	and	w9, w0, #0xff00
40006518: d37f1c15     	ubfiz	x21, x0, #1, #8
4000651c: b94db508     	ldr	w8, [x8, #0xdb4]
40006520: 2a0103f4     	mov	w20, w1
40006524: 910003e1     	mov	x1, sp
40006528: 910003f6     	mov	x22, sp
4000652c: 0b492113     	add	w19, w8, w9, lsr #8
40006530: aa1303e0     	mov	x0, x19
40006534: 97fffcf1     	bl	0x400058f8 <virtio_blk_read_sector>
40006538: 53087e88     	lsr	w8, w20, #8
4000653c: 8b1502c9     	add	x9, x22, x21
40006540: 910003e1     	mov	x1, sp
40006544: aa1303e0     	mov	x0, x19
40006548: 39000134     	strb	w20, [x9]
4000654c: 39000528     	strb	w8, [x9, #0x1]
40006550: 97fffd8a     	bl	0x40005b78 <virtio_blk_write_sector>
40006554: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40006558: 39761108     	ldrb	w8, [x8, #0xd84]
4000655c: 7100091f     	cmp	w8, #0x2
40006560: 540001c3     	b.lo	0x40006598 <fat16_set_fat_entry+0xa0>
40006564: 52800034     	mov	w20, #0x1               // =1
40006568: b00001b5     	adrp	x21, 0x4003b000 <memory_bitmap+0x460>
4000656c: 913612b5     	add	x21, x21, #0xd84
40006570: 39401ea8     	ldrb	w8, [x21, #0x7]
40006574: 39401aa9     	ldrb	w9, [x21, #0x6]
40006578: 910003e1     	mov	x1, sp
4000657c: 2a082128     	orr	w8, w9, w8, lsl #8
40006580: 1b084e80     	madd	w0, w20, w8, w19
40006584: 97fffd7d     	bl	0x40005b78 <virtio_blk_write_sector>
40006588: 394002a8     	ldrb	w8, [x21]
4000658c: 11000694     	add	w20, w20, #0x1
40006590: 6b08029f     	cmp	w20, w8
40006594: 54fffee3     	b.lo	0x40006570 <fat16_set_fat_entry+0x78>
40006598: 910803ff     	add	sp, sp, #0x200
4000659c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400065a0: f9400bfc     	ldr	x28, [sp, #0x10]
400065a4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400065a8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400065ac: d65f03c0     	ret

00000000400065b0 <fat16_allocate_cluster>:
400065b0: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
400065b4: f9000bfc     	str	x28, [sp, #0x10]
400065b8: 910003fd     	mov	x29, sp
400065bc: a9025ff8     	stp	x24, x23, [sp, #0x20]
400065c0: a90357f6     	stp	x22, x21, [sp, #0x30]
400065c4: a9044ff4     	stp	x20, x19, [sp, #0x40]
400065c8: d10803ff     	sub	sp, sp, #0x200
400065cc: b00001b6     	adrp	x22, 0x4003b000 <memory_bitmap+0x460>
400065d0: 91362ad6     	add	x22, x22, #0xd8a
400065d4: 394006c8     	ldrb	w8, [x22, #0x1]
400065d8: 394002c9     	ldrb	w9, [x22]
400065dc: 2a082128     	orr	w8, w9, w8, lsl #8
400065e0: 340006e8     	cbz	w8, 0x400066bc <fat16_allocate_cluster+0x10c>
400065e4: aa1f03f7     	mov	x23, xzr
400065e8: aa1f03f4     	mov	x20, xzr
400065ec: b00001b5     	adrp	x21, 0x4003b000 <memory_bitmap+0x460>
400065f0: 910003f8     	mov	x24, sp
400065f4: 14000008     	b	0x40006614 <fat16_allocate_cluster+0x64>
400065f8: 394006c8     	ldrb	w8, [x22, #0x1]
400065fc: 394002c9     	ldrb	w9, [x22]
40006600: 91000694     	add	x20, x20, #0x1
40006604: 910402f7     	add	x23, x23, #0x100
40006608: aa082128     	orr	x8, x9, x8, lsl #8
4000660c: eb08029f     	cmp	x20, x8
40006610: 54000562     	b.hs	0x400066bc <fat16_allocate_cluster+0x10c>
40006614: b94db6a8     	ldr	w8, [x21, #0xdb4]
40006618: 910003e1     	mov	x1, sp
4000661c: 8b080280     	add	x0, x20, x8
40006620: 97fffcb6     	bl	0x400058f8 <virtio_blk_read_sector>
40006624: aa1f03e8     	mov	x8, xzr
40006628: aa1703f3     	mov	x19, x23
4000662c: 14000005     	b	0x40006640 <fat16_allocate_cluster+0x90>
40006630: 91000908     	add	x8, x8, #0x2
40006634: 91000673     	add	x19, x19, #0x1
40006638: f108011f     	cmp	x8, #0x200
4000663c: 54fffde0     	b.eq	0x400065f8 <fat16_allocate_cluster+0x48>
40006640: f27f3a7f     	tst	x19, #0xfffe
40006644: 54ffff60     	b.eq	0x40006630 <fat16_allocate_cluster+0x80>
40006648: 78686b09     	ldrh	w9, [x24, x8]
4000664c: 35ffff29     	cbnz	w9, 0x40006630 <fat16_allocate_cluster+0x80>
40006650: b94db6a9     	ldr	w9, [x21, #0xdb4]
40006654: 910003ea     	mov	x10, sp
40006658: 910003e1     	mov	x1, sp
4000665c: 529fffeb     	mov	w11, #0xffff            // =65535
40006660: 7828694b     	strh	w11, [x10, x8]
40006664: 0b140120     	add	w0, w9, w20
40006668: 97fffd44     	bl	0x40005b78 <virtio_blk_write_sector>
4000666c: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40006670: 39761108     	ldrb	w8, [x8, #0xd84]
40006674: 7100091f     	cmp	w8, #0x2
40006678: 54000243     	b.lo	0x400066c0 <fat16_allocate_cluster+0x110>
4000667c: 52800036     	mov	w22, #0x1               // =1
40006680: b00001b7     	adrp	x23, 0x4003b000 <memory_bitmap+0x460>
40006684: 913612f7     	add	x23, x23, #0xd84
40006688: 39401ee8     	ldrb	w8, [x23, #0x7]
4000668c: 39401ae9     	ldrb	w9, [x23, #0x6]
40006690: 910003e1     	mov	x1, sp
40006694: b94db6aa     	ldr	w10, [x21, #0xdb4]
40006698: 2a082128     	orr	w8, w9, w8, lsl #8
4000669c: 0b140149     	add	w9, w10, w20
400066a0: 1b0826c0     	madd	w0, w22, w8, w9
400066a4: 97fffd35     	bl	0x40005b78 <virtio_blk_write_sector>
400066a8: 394002e8     	ldrb	w8, [x23]
400066ac: 110006d6     	add	w22, w22, #0x1
400066b0: 6b0802df     	cmp	w22, w8
400066b4: 54fffea3     	b.lo	0x40006688 <fat16_allocate_cluster+0xd8>
400066b8: 14000002     	b	0x400066c0 <fat16_allocate_cluster+0x110>
400066bc: 2a1f03f3     	mov	w19, wzr
400066c0: 2a1303e0     	mov	w0, w19
400066c4: 910803ff     	add	sp, sp, #0x200
400066c8: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400066cc: f9400bfc     	ldr	x28, [sp, #0x10]
400066d0: a94357f6     	ldp	x22, x21, [sp, #0x30]
400066d4: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400066d8: a8c57bfd     	ldp	x29, x30, [sp], #0x50
400066dc: d65f03c0     	ret

00000000400066e0 <fat16_write_file>:
400066e0: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400066e4: a9016ffc     	stp	x28, x27, [sp, #0x10]
400066e8: 910003fd     	mov	x29, sp
400066ec: a90267fa     	stp	x26, x25, [sp, #0x20]
400066f0: a9035ff8     	stp	x24, x23, [sp, #0x30]
400066f4: a90457f6     	stp	x22, x21, [sp, #0x40]
400066f8: a9054ff4     	stp	x20, x19, [sp, #0x50]
400066fc: d11083ff     	sub	sp, sp, #0x420
40006700: aa0103f4     	mov	x20, x1
40006704: 910837e1     	add	x1, sp, #0x20d
40006708: aa0203f3     	mov	x19, x2
4000670c: 97ffff36     	bl	0x400063e4 <to_fat_name>
40006710: b00001b6     	adrp	x22, 0x4003b000 <memory_bitmap+0x460>
40006714: b94dbec8     	ldr	w8, [x22, #0xdbc]
40006718: 34000d48     	cbz	w8, 0x400068c0 <fat16_write_file+0x1e0>
4000671c: aa1f03f5     	mov	x21, xzr
40006720: 2a1f03f8     	mov	w24, wzr
40006724: 2a1f03f7     	mov	w23, wzr
40006728: b00001b9     	adrp	x25, 0x4003b000 <memory_bitmap+0x460>
4000672c: 910033fa     	add	x26, sp, #0xc
40006730: 1400000b     	b	0x4000675c <fat16_write_file+0x7c>
40006734: b40000d5     	cbz	x21, 0x4000674c <fat16_write_file+0x6c>
40006738: 910837e1     	add	x1, sp, #0x20d
4000673c: aa1503e0     	mov	x0, x21
40006740: 52800162     	mov	w2, #0xb                // =11
40006744: 97fff05c     	bl	0x400028b4 <kstrncmp>
40006748: 34000480     	cbz	w0, 0x400067d8 <fat16_write_file+0xf8>
4000674c: b94dbec8     	ldr	w8, [x22, #0xdbc]
40006750: 110006f7     	add	w23, w23, #0x1
40006754: 6b0802ff     	cmp	w23, w8
40006758: 540003e2     	b.hs	0x400067d4 <fat16_write_file+0xf4>
4000675c: b94dbb28     	ldr	w8, [x25, #0xdb8]
40006760: 910033e1     	add	x1, sp, #0xc
40006764: 0b170100     	add	w0, w8, w23
40006768: 97fffc64     	bl	0x400058f8 <virtio_blk_read_sector>
4000676c: aa1f03fb     	mov	x27, xzr
40006770: 14000008     	b	0x40006790 <fat16_write_file+0xb0>
40006774: 910837e1     	add	x1, sp, #0x20d
40006778: 52800162     	mov	w2, #0xb                // =11
4000677c: 97fff04e     	bl	0x400028b4 <kstrncmp>
40006780: 340001c0     	cbz	w0, 0x400067b8 <fat16_write_file+0xd8>
40006784: 9100837b     	add	x27, x27, #0x20
40006788: f108037f     	cmp	x27, #0x200
4000678c: 54fffd40     	b.eq	0x40006734 <fat16_write_file+0x54>
40006790: 8b1b0340     	add	x0, x26, x27
40006794: 39400008     	ldrb	w8, [x0]
40006798: 7103951f     	cmp	w8, #0xe5
4000679c: 7a401904     	ccmp	w8, #0x0, #0x4, ne
400067a0: 54fffea1     	b.ne	0x40006774 <fat16_write_file+0x94>
400067a4: b5ffff15     	cbnz	x21, 0x40006784 <fat16_write_file+0xa4>
400067a8: b94dbb28     	ldr	w8, [x25, #0xdb8]
400067ac: aa0003f5     	mov	x21, x0
400067b0: 0b170118     	add	w24, w8, w23
400067b4: 17fffff4     	b	0x40006784 <fat16_write_file+0xa4>
400067b8: 8b1b0348     	add	x8, x26, x27
400067bc: 39402d09     	ldrb	w9, [x8, #0xb]
400067c0: 3727fe29     	tbnz	w9, #0x4, 0x40006784 <fat16_write_file+0xa4>
400067c4: b94dbb29     	ldr	w9, [x25, #0xdb8]
400067c8: aa0803f5     	mov	x21, x8
400067cc: 0b170138     	add	w24, w9, w23
400067d0: 17ffffda     	b	0x40006738 <fat16_write_file+0x58>
400067d4: b4000775     	cbz	x21, 0x400068c0 <fat16_write_file+0x1e0>
400067d8: 910837e1     	add	x1, sp, #0x20d
400067dc: aa1503e0     	mov	x0, x21
400067e0: 52800162     	mov	w2, #0xb                // =11
400067e4: b90007f8     	str	w24, [sp, #0x4]
400067e8: 97fff033     	bl	0x400028b4 <kstrncmp>
400067ec: b00001bb     	adrp	x27, 0x4003b000 <memory_bitmap+0x460>
400067f0: 9136137b     	add	x27, x27, #0xd84
400067f4: 350006a0     	cbnz	w0, 0x400068c8 <fat16_write_file+0x1e8>
400067f8: 39406ea8     	ldrb	w8, [x21, #0x1b]
400067fc: 39406aa9     	ldrb	w9, [x21, #0x1a]
40006800: 529ffeaa     	mov	w10, #0xfff5            // =65525
40006804: 2a082128     	orr	w8, w9, w8, lsl #8
40006808: 51000909     	sub	w9, w8, #0x2
4000680c: 6b0a013f     	cmp	w9, w10
40006810: 540005c8     	b.hi	0x400068c8 <fat16_write_file+0x1e8>
40006814: 910863f6     	add	x22, sp, #0x218
40006818: 529ffed7     	mov	w23, #0xfff6            // =65526
4000681c: 14000005     	b	0x40006830 <fat16_write_file+0x150>
40006820: 2a182328     	orr	w8, w25, w24, lsl #8
40006824: 51000909     	sub	w9, w8, #0x2
40006828: 6b17013f     	cmp	w9, w23
4000682c: 540004e2     	b.hs	0x400068c8 <fat16_write_file+0x1e8>
40006830: b00001b9     	adrp	x25, 0x4003b000 <memory_bitmap+0x460>
40006834: 53087d15     	lsr	w21, w8, #8
40006838: 910863e1     	add	x1, sp, #0x218
4000683c: b94db729     	ldr	w9, [x25, #0xdb4]
40006840: d37f1d18     	ubfiz	x24, x8, #1, #8
40006844: 0b150120     	add	w0, w9, w21
40006848: 97fffc2c     	bl	0x400058f8 <virtio_blk_read_sector>
4000684c: b94db728     	ldr	w8, [x25, #0xdb4]
40006850: 8b1802da     	add	x26, x22, x24
40006854: 910863e1     	add	x1, sp, #0x218
40006858: 39400758     	ldrb	w24, [x26, #0x1]
4000685c: 39400359     	ldrb	w25, [x26]
40006860: 0b150115     	add	w21, w8, w21
40006864: aa1503e0     	mov	x0, x21
40006868: 97fffc24     	bl	0x400058f8 <virtio_blk_read_sector>
4000686c: 910863e1     	add	x1, sp, #0x218
40006870: aa1503e0     	mov	x0, x21
40006874: 3900075f     	strb	wzr, [x26, #0x1]
40006878: 3900035f     	strb	wzr, [x26]
4000687c: 97fffcbf     	bl	0x40005b78 <virtio_blk_write_sector>
40006880: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
40006884: 39761108     	ldrb	w8, [x8, #0xd84]
40006888: 7100091f     	cmp	w8, #0x2
4000688c: 54fffca3     	b.lo	0x40006820 <fat16_write_file+0x140>
40006890: 5280003a     	mov	w26, #0x1               // =1
40006894: 39401f68     	ldrb	w8, [x27, #0x7]
40006898: 39401b69     	ldrb	w9, [x27, #0x6]
4000689c: 910863e1     	add	x1, sp, #0x218
400068a0: 2a082128     	orr	w8, w9, w8, lsl #8
400068a4: 1b085740     	madd	w0, w26, w8, w21
400068a8: 97fffcb4     	bl	0x40005b78 <virtio_blk_write_sector>
400068ac: 39400368     	ldrb	w8, [x27]
400068b0: 1100075a     	add	w26, w26, #0x1
400068b4: 6b08035f     	cmp	w26, w8
400068b8: 54fffee3     	b.lo	0x40006894 <fat16_write_file+0x1b4>
400068bc: 17ffffd9     	b	0x40006820 <fat16_write_file+0x140>
400068c0: 12800013     	mov	w19, #-0x1              // =-1
400068c4: 14000131     	b	0x40006d88 <fat16_write_file+0x6a8>
400068c8: 2a1f03f6     	mov	w22, wzr
400068cc: 2a1f03f5     	mov	w21, wzr
400068d0: aa1f03fc     	mov	x28, xzr
400068d4: b00001ba     	adrp	x26, 0x4003b000 <memory_bitmap+0x460>
400068d8: 52804019     	mov	w25, #0x200             // =512
400068dc: 14000003     	b	0x400068e8 <fat16_write_file+0x208>
400068e0: b9400bf6     	ldr	w22, [sp, #0x8]
400068e4: b4000a13     	cbz	x19, 0x40006a24 <fat16_write_file+0x344>
400068e8: 72003edf     	tst	w22, #0xffff
400068ec: 2a1503f8     	mov	w24, w21
400068f0: fa400a60     	ccmp	x19, #0x0, #0x0, eq
400068f4: 1a9f17e8     	cset	w8, eq
400068f8: eb13039f     	cmp	x28, x19
400068fc: 54000043     	b.lo	0x40006904 <fat16_write_file+0x224>
40006900: 34000928     	cbz	w8, 0x40006a24 <fat16_write_file+0x344>
40006904: 97ffff2b     	bl	0x400065b0 <fat16_allocate_cluster>
40006908: 72003c17     	ands	w23, w0, #0xffff
4000690c: 540020e0     	b.eq	0x40006d28 <fat16_write_file+0x648>
40006910: 72003edf     	tst	w22, #0xffff
40006914: 2a0003f5     	mov	w21, w0
40006918: 1a960016     	csel	w22, w0, w22, eq
4000691c: 72003f1f     	tst	w24, #0xffff
40006920: b9000bf6     	str	w22, [sp, #0x8]
40006924: 54000400     	b.eq	0x400069a4 <fat16_write_file+0x2c4>
40006928: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
4000692c: 12181f09     	and	w9, w24, #0xff00
40006930: 910863e1     	add	x1, sp, #0x218
40006934: b94db508     	ldr	w8, [x8, #0xdb4]
40006938: d37f1f18     	ubfiz	x24, x24, #1, #8
4000693c: 0b492116     	add	w22, w8, w9, lsr #8
40006940: aa1603e0     	mov	x0, x22
40006944: 97fffbed     	bl	0x400058f8 <virtio_blk_read_sector>
40006948: 53087ea8     	lsr	w8, w21, #8
4000694c: 910863e9     	add	x9, sp, #0x218
40006950: 910863e1     	add	x1, sp, #0x218
40006954: 8b180129     	add	x9, x9, x24
40006958: aa1603e0     	mov	x0, x22
4000695c: 39000528     	strb	w8, [x9, #0x1]
40006960: 39000135     	strb	w21, [x9]
40006964: 97fffc85     	bl	0x40005b78 <virtio_blk_write_sector>
40006968: b00001a8     	adrp	x8, 0x4003b000 <memory_bitmap+0x460>
4000696c: 39761108     	ldrb	w8, [x8, #0xd84]
40006970: 7100091f     	cmp	w8, #0x2
40006974: 54000183     	b.lo	0x400069a4 <fat16_write_file+0x2c4>
40006978: 52800038     	mov	w24, #0x1               // =1
4000697c: 39401f68     	ldrb	w8, [x27, #0x7]
40006980: 39401b69     	ldrb	w9, [x27, #0x6]
40006984: 910863e1     	add	x1, sp, #0x218
40006988: 2a082128     	orr	w8, w9, w8, lsl #8
4000698c: 1b085b00     	madd	w0, w24, w8, w22
40006990: 97fffc7a     	bl	0x40005b78 <virtio_blk_write_sector>
40006994: 39400368     	ldrb	w8, [x27]
40006998: 11000718     	add	w24, w24, #0x1
4000699c: 6b08031f     	cmp	w24, w8
400069a0: 54fffee3     	b.lo	0x4000697c <fat16_write_file+0x29c>
400069a4: 39760748     	ldrb	w8, [x26, #0xd81]
400069a8: 34fff9c8     	cbz	w8, 0x400068e0 <fat16_write_file+0x200>
400069ac: 51000ae9     	sub	w9, w23, #0x2
400069b0: 52800038     	mov	w24, #0x1               // =1
400069b4: 1b087d28     	mul	w8, w9, w8
400069b8: b00001a9     	adrp	x9, 0x4003b000 <memory_bitmap+0x460>
400069bc: b94dc129     	ldr	w9, [x9, #0xdc0]
400069c0: 0b080137     	add	w23, w9, w8
400069c4: 91080388     	add	x8, x28, #0x200
400069c8: cb1c0269     	sub	x9, x19, x28
400069cc: 910033e0     	add	x0, sp, #0xc
400069d0: eb13011f     	cmp	x8, x19
400069d4: 2a1f03e1     	mov	w1, wzr
400069d8: 52804002     	mov	w2, #0x200              // =512
400069dc: 9a998136     	csel	x22, x9, x25, hi
400069e0: 97ffeff1     	bl	0x400029a4 <memset>
400069e4: 910033e0     	add	x0, sp, #0xc
400069e8: 8b1c0281     	add	x1, x20, x28
400069ec: aa1603e2     	mov	x2, x22
400069f0: 97fff003     	bl	0x400029fc <memcpy>
400069f4: 2a1703e0     	mov	w0, w23
400069f8: 910033e1     	add	x1, sp, #0xc
400069fc: 97fffc5f     	bl	0x40005b78 <virtio_blk_write_sector>
40006a00: 8b1c02dc     	add	x28, x22, x28
40006a04: eb13039f     	cmp	x28, x19
40006a08: 54fff6c2     	b.hs	0x400068e0 <fat16_write_file+0x200>
40006a0c: 39760748     	ldrb	w8, [x26, #0xd81]
40006a10: 110006f7     	add	w23, w23, #0x1
40006a14: eb08031f     	cmp	x24, x8
40006a18: 91000718     	add	x24, x24, #0x1
40006a1c: 54fffd43     	b.lo	0x400069c4 <fat16_write_file+0x2e4>
40006a20: 17ffffb0     	b	0x400068e0 <fat16_write_file+0x200>
40006a24: b94007e8     	ldr	w8, [sp, #0x4]
40006a28: 910033e1     	add	x1, sp, #0xc
40006a2c: 910033f5     	add	x21, sp, #0xc
40006a30: 2a0803f4     	mov	w20, w8
40006a34: aa1403e0     	mov	x0, x20
40006a38: 97fffbb0     	bl	0x400058f8 <virtio_blk_read_sector>
40006a3c: 910033e0     	add	x0, sp, #0xc
40006a40: 910837e1     	add	x1, sp, #0x20d
40006a44: 52800162     	mov	w2, #0xb                // =11
40006a48: 97ffef9b     	bl	0x400028b4 <kstrncmp>
40006a4c: 34001740     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006a50: 394033e8     	ldrb	w8, [sp, #0xc]
40006a54: 910033f5     	add	x21, sp, #0xc
40006a58: 7103951f     	cmp	w8, #0xe5
40006a5c: 540016c0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006a60: 340016a8     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006a64: 910033e8     	add	x8, sp, #0xc
40006a68: 910837e1     	add	x1, sp, #0x20d
40006a6c: 52800162     	mov	w2, #0xb                // =11
40006a70: 91008115     	add	x21, x8, #0x20
40006a74: aa1503e0     	mov	x0, x21
40006a78: 97ffef8f     	bl	0x400028b4 <kstrncmp>
40006a7c: 340015c0     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006a80: 3940b3e8     	ldrb	w8, [sp, #0x2c]
40006a84: 34001588     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006a88: 7103951f     	cmp	w8, #0xe5
40006a8c: 54001540     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006a90: 910033e8     	add	x8, sp, #0xc
40006a94: 910837e1     	add	x1, sp, #0x20d
40006a98: 52800162     	mov	w2, #0xb                // =11
40006a9c: 91010115     	add	x21, x8, #0x40
40006aa0: aa1503e0     	mov	x0, x21
40006aa4: 97ffef84     	bl	0x400028b4 <kstrncmp>
40006aa8: 34001460     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006aac: 394133e8     	ldrb	w8, [sp, #0x4c]
40006ab0: 34001428     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006ab4: 7103951f     	cmp	w8, #0xe5
40006ab8: 540013e0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006abc: 910033e8     	add	x8, sp, #0xc
40006ac0: 910837e1     	add	x1, sp, #0x20d
40006ac4: 52800162     	mov	w2, #0xb                // =11
40006ac8: 91018115     	add	x21, x8, #0x60
40006acc: aa1503e0     	mov	x0, x21
40006ad0: 97ffef79     	bl	0x400028b4 <kstrncmp>
40006ad4: 34001300     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006ad8: 3941b3e8     	ldrb	w8, [sp, #0x6c]
40006adc: 340012c8     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006ae0: 7103951f     	cmp	w8, #0xe5
40006ae4: 54001280     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006ae8: 910033e8     	add	x8, sp, #0xc
40006aec: 910837e1     	add	x1, sp, #0x20d
40006af0: 52800162     	mov	w2, #0xb                // =11
40006af4: 91020115     	add	x21, x8, #0x80
40006af8: aa1503e0     	mov	x0, x21
40006afc: 97ffef6e     	bl	0x400028b4 <kstrncmp>
40006b00: 340011a0     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006b04: 394233e8     	ldrb	w8, [sp, #0x8c]
40006b08: 34001168     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006b0c: 7103951f     	cmp	w8, #0xe5
40006b10: 54001120     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006b14: 910033e8     	add	x8, sp, #0xc
40006b18: 910837e1     	add	x1, sp, #0x20d
40006b1c: 52800162     	mov	w2, #0xb                // =11
40006b20: 91028115     	add	x21, x8, #0xa0
40006b24: aa1503e0     	mov	x0, x21
40006b28: 97ffef63     	bl	0x400028b4 <kstrncmp>
40006b2c: 34001040     	cbz	w0, 0x40006d34 <fat16_write_file+0x654>
40006b30: 3942b3e8     	ldrb	w8, [sp, #0xac]
40006b34: 34001008     	cbz	w8, 0x40006d34 <fat16_write_file+0x654>
40006b38: 7103951f     	cmp	w8, #0xe5
40006b3c: 54000fc0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006b40: 910033e8     	add	x8, sp, #0xc
40006b44: 910837e1     	add	x1, sp, #0x20d
40006b48: 52800162     	mov	w2, #0xb                // =11
40006b4c: 91030115     	add	x21, x8, #0xc0
40006b50: 2a1603f7     	mov	w23, w22
40006b54: aa1503e0     	mov	x0, x21
40006b58: 97ffef57     	bl	0x400028b4 <kstrncmp>
40006b5c: 34000ea0     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006b60: 394333e8     	ldrb	w8, [sp, #0xcc]
40006b64: 34000e68     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006b68: 7103951f     	cmp	w8, #0xe5
40006b6c: 2a1703f6     	mov	w22, w23
40006b70: 54000e20     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006b74: 910033e8     	add	x8, sp, #0xc
40006b78: 910837e1     	add	x1, sp, #0x20d
40006b7c: 52800162     	mov	w2, #0xb                // =11
40006b80: 91038115     	add	x21, x8, #0xe0
40006b84: aa1503e0     	mov	x0, x21
40006b88: 97ffef4b     	bl	0x400028b4 <kstrncmp>
40006b8c: 34000d20     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006b90: 3943b3e8     	ldrb	w8, [sp, #0xec]
40006b94: 34000ce8     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006b98: 7103951f     	cmp	w8, #0xe5
40006b9c: 2a1703f6     	mov	w22, w23
40006ba0: 54000ca0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006ba4: 910033e8     	add	x8, sp, #0xc
40006ba8: 910837e1     	add	x1, sp, #0x20d
40006bac: 52800162     	mov	w2, #0xb                // =11
40006bb0: 91040115     	add	x21, x8, #0x100
40006bb4: aa1503e0     	mov	x0, x21
40006bb8: 97ffef3f     	bl	0x400028b4 <kstrncmp>
40006bbc: 34000ba0     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006bc0: 394433e8     	ldrb	w8, [sp, #0x10c]
40006bc4: 34000b68     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006bc8: 7103951f     	cmp	w8, #0xe5
40006bcc: 2a1703f6     	mov	w22, w23
40006bd0: 54000b20     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006bd4: 910033e8     	add	x8, sp, #0xc
40006bd8: 910837e1     	add	x1, sp, #0x20d
40006bdc: 52800162     	mov	w2, #0xb                // =11
40006be0: 91048115     	add	x21, x8, #0x120
40006be4: aa1503e0     	mov	x0, x21
40006be8: 97ffef33     	bl	0x400028b4 <kstrncmp>
40006bec: 34000a20     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006bf0: 3944b3e8     	ldrb	w8, [sp, #0x12c]
40006bf4: 340009e8     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006bf8: 7103951f     	cmp	w8, #0xe5
40006bfc: 2a1703f6     	mov	w22, w23
40006c00: 540009a0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006c04: 910033e8     	add	x8, sp, #0xc
40006c08: 910837e1     	add	x1, sp, #0x20d
40006c0c: 52800162     	mov	w2, #0xb                // =11
40006c10: 91050115     	add	x21, x8, #0x140
40006c14: aa1503e0     	mov	x0, x21
40006c18: 97ffef27     	bl	0x400028b4 <kstrncmp>
40006c1c: 340008a0     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006c20: 394533e8     	ldrb	w8, [sp, #0x14c]
40006c24: 34000868     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006c28: 7103951f     	cmp	w8, #0xe5
40006c2c: 2a1703f6     	mov	w22, w23
40006c30: 54000820     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006c34: 910033e8     	add	x8, sp, #0xc
40006c38: 910837e1     	add	x1, sp, #0x20d
40006c3c: 52800162     	mov	w2, #0xb                // =11
40006c40: 91058115     	add	x21, x8, #0x160
40006c44: aa1503e0     	mov	x0, x21
40006c48: 97ffef1b     	bl	0x400028b4 <kstrncmp>
40006c4c: 34000720     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006c50: 3945b3e8     	ldrb	w8, [sp, #0x16c]
40006c54: 340006e8     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006c58: 7103951f     	cmp	w8, #0xe5
40006c5c: 2a1703f6     	mov	w22, w23
40006c60: 540006a0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006c64: 910033e8     	add	x8, sp, #0xc
40006c68: 910837e1     	add	x1, sp, #0x20d
40006c6c: 52800162     	mov	w2, #0xb                // =11
40006c70: 91060115     	add	x21, x8, #0x180
40006c74: aa1503e0     	mov	x0, x21
40006c78: 97ffef0f     	bl	0x400028b4 <kstrncmp>
40006c7c: 340005a0     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006c80: 394633e8     	ldrb	w8, [sp, #0x18c]
40006c84: 34000568     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006c88: 7103951f     	cmp	w8, #0xe5
40006c8c: 2a1703f6     	mov	w22, w23
40006c90: 54000520     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006c94: 910033e8     	add	x8, sp, #0xc
40006c98: 910837e1     	add	x1, sp, #0x20d
40006c9c: 52800162     	mov	w2, #0xb                // =11
40006ca0: 91068115     	add	x21, x8, #0x1a0
40006ca4: aa1503e0     	mov	x0, x21
40006ca8: 97ffef03     	bl	0x400028b4 <kstrncmp>
40006cac: 34000420     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006cb0: 3946b3e8     	ldrb	w8, [sp, #0x1ac]
40006cb4: 340003e8     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006cb8: 7103951f     	cmp	w8, #0xe5
40006cbc: 2a1703f6     	mov	w22, w23
40006cc0: 540003a0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006cc4: 910033e8     	add	x8, sp, #0xc
40006cc8: 910837e1     	add	x1, sp, #0x20d
40006ccc: 52800162     	mov	w2, #0xb                // =11
40006cd0: 91070115     	add	x21, x8, #0x1c0
40006cd4: aa1503e0     	mov	x0, x21
40006cd8: 97ffeef7     	bl	0x400028b4 <kstrncmp>
40006cdc: 340002a0     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006ce0: 394733e8     	ldrb	w8, [sp, #0x1cc]
40006ce4: 34000268     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006ce8: 7103951f     	cmp	w8, #0xe5
40006cec: 2a1703f6     	mov	w22, w23
40006cf0: 54000220     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006cf4: 910033e8     	add	x8, sp, #0xc
40006cf8: 910837e1     	add	x1, sp, #0x20d
40006cfc: 52800162     	mov	w2, #0xb                // =11
40006d00: 91078115     	add	x21, x8, #0x1e0
40006d04: aa1503e0     	mov	x0, x21
40006d08: 97ffeeeb     	bl	0x400028b4 <kstrncmp>
40006d0c: 34000120     	cbz	w0, 0x40006d30 <fat16_write_file+0x650>
40006d10: 3947b3e8     	ldrb	w8, [sp, #0x1ec]
40006d14: 340000e8     	cbz	w8, 0x40006d30 <fat16_write_file+0x650>
40006d18: 7103951f     	cmp	w8, #0xe5
40006d1c: 2a1703f6     	mov	w22, w23
40006d20: 540000a0     	b.eq	0x40006d34 <fat16_write_file+0x654>
40006d24: 14000019     	b	0x40006d88 <fat16_write_file+0x6a8>
40006d28: 12800033     	mov	w19, #-0x2              // =-2
40006d2c: 14000017     	b	0x40006d88 <fat16_write_file+0x6a8>
40006d30: 2a1703f6     	mov	w22, w23
40006d34: 910837e1     	add	x1, sp, #0x20d
40006d38: aa1503e0     	mov	x0, x21
40006d3c: 52800162     	mov	w2, #0xb                // =11
40006d40: 97ffeef4     	bl	0x40002910 <kstrncpy>
40006d44: 52800408     	mov	w8, #0x20               // =32
40006d48: 3801ceb3     	strb	w19, [x21, #0x1c]!
40006d4c: 53087ec9     	lsr	w9, w22, #8
40006d50: 381ef2a8     	sturb	w8, [x21, #-0x11]
40006d54: 53187e68     	lsr	w8, w19, #24
40006d58: 910033e1     	add	x1, sp, #0xc
40006d5c: aa1403e0     	mov	x0, x20
40006d60: 381fe2b6     	sturb	w22, [x21, #-0x2]
40006d64: 381ff2a9     	sturb	w9, [x21, #-0x1]
40006d68: 53107e69     	lsr	w9, w19, #16
40006d6c: 39000ea8     	strb	w8, [x21, #0x3]
40006d70: 53087e68     	lsr	w8, w19, #8
40006d74: 381f92bf     	sturb	wzr, [x21, #-0x7]
40006d78: 381f82bf     	sturb	wzr, [x21, #-0x8]
40006d7c: 39000aa9     	strb	w9, [x21, #0x2]
40006d80: 390006a8     	strb	w8, [x21, #0x1]
40006d84: 97fffb7d     	bl	0x40005b78 <virtio_blk_write_sector>
40006d88: 2a1303e0     	mov	w0, w19
40006d8c: 911083ff     	add	sp, sp, #0x420
40006d90: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006d94: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006d98: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006d9c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006da0: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006da4: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006da8: d65f03c0     	ret

0000000040006dac <fat16_populate_vfs>:
40006dac: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006db0: f9000bfc     	str	x28, [sp, #0x10]
40006db4: 910003fd     	mov	x29, sp
40006db8: a90267fa     	stp	x26, x25, [sp, #0x20]
40006dbc: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006dc0: a90457f6     	stp	x22, x21, [sp, #0x40]
40006dc4: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006dc8: d11843ff     	sub	sp, sp, #0x610
40006dcc: b00001b3     	adrp	x19, 0x4003b000 <memory_bitmap+0x460>
40006dd0: b94dbe68     	ldr	w8, [x19, #0xdbc]
40006dd4: 34000d68     	cbz	w8, 0x40006f80 <fat16_populate_vfs+0x1d4>
40006dd8: 911043e8     	add	x8, sp, #0x410
40006ddc: 2a1f03f4     	mov	w20, wzr
40006de0: b00001b6     	adrp	x22, 0x4003b000 <memory_bitmap+0x460>
40006de4: 91001515     	add	x21, x8, #0x5
40006de8: 911003f7     	add	x23, sp, #0x400
40006dec: 528005d8     	mov	w24, #0x2e              // =46
40006df0: 14000005     	b	0x40006e04 <fat16_populate_vfs+0x58>
40006df4: b94dbe68     	ldr	w8, [x19, #0xdbc]
40006df8: 11000694     	add	w20, w20, #0x1
40006dfc: 6b08029f     	cmp	w20, w8
40006e00: 54000c02     	b.hs	0x40006f80 <fat16_populate_vfs+0x1d4>
40006e04: b94dbac8     	ldr	w8, [x22, #0xdb8]
40006e08: 911043e1     	add	x1, sp, #0x410
40006e0c: 0b140100     	add	w0, w8, w20
40006e10: 97fffaba     	bl	0x400058f8 <virtio_blk_read_sector>
40006e14: aa1503f9     	mov	x25, x21
40006e18: 5280021a     	mov	w26, #0x10              // =16
40006e1c: 14000004     	b	0x40006e2c <fat16_populate_vfs+0x80>
40006e20: f100075a     	subs	x26, x26, #0x1
40006e24: 91008339     	add	x25, x25, #0x20
40006e28: 54fffe60     	b.eq	0x40006df4 <fat16_populate_vfs+0x48>
40006e2c: 385fb328     	ldurb	w8, [x25, #-0x5]
40006e30: 7103951f     	cmp	w8, #0xe5
40006e34: 54ffff60     	b.eq	0x40006e20 <fat16_populate_vfs+0x74>
40006e38: 34000a48     	cbz	w8, 0x40006f80 <fat16_populate_vfs+0x1d4>
40006e3c: 39401b29     	ldrb	w9, [x25, #0x6]
40006e40: 7200113f     	tst	w9, #0x1f
40006e44: 54fffee1     	b.ne	0x40006e20 <fat16_populate_vfs+0x74>
40006e48: 7100811f     	cmp	w8, #0x20
40006e4c: 54000061     	b.ne	0x40006e58 <fat16_populate_vfs+0xac>
40006e50: aa1f03e8     	mov	x8, xzr
40006e54: 14000003     	b	0x40006e60 <fat16_populate_vfs+0xb4>
40006e58: 391003e8     	strb	w8, [sp, #0x400]
40006e5c: 52800028     	mov	w8, #0x1                // =1
40006e60: 385fc329     	ldurb	w9, [x25, #-0x4]
40006e64: 7100813f     	cmp	w9, #0x20
40006e68: 54000080     	b.eq	0x40006e78 <fat16_populate_vfs+0xcc>
40006e6c: aa0802ea     	orr	x10, x23, x8
40006e70: 91000508     	add	x8, x8, #0x1
40006e74: 39000149     	strb	w9, [x10]
40006e78: 385fd329     	ldurb	w9, [x25, #-0x3]
40006e7c: 7100813f     	cmp	w9, #0x20
40006e80: 54000080     	b.eq	0x40006e90 <fat16_populate_vfs+0xe4>
40006e84: aa0802ea     	orr	x10, x23, x8
40006e88: 91000508     	add	x8, x8, #0x1
40006e8c: 39000149     	strb	w9, [x10]
40006e90: 385fe329     	ldurb	w9, [x25, #-0x2]
40006e94: 7100813f     	cmp	w9, #0x20
40006e98: 54000080     	b.eq	0x40006ea8 <fat16_populate_vfs+0xfc>
40006e9c: 9100050a     	add	x10, x8, #0x1
40006ea0: 38286ae9     	strb	w9, [x23, x8]
40006ea4: aa0a03e8     	mov	x8, x10
40006ea8: 385ff329     	ldurb	w9, [x25, #-0x1]
40006eac: 7100813f     	cmp	w9, #0x20
40006eb0: 54000080     	b.eq	0x40006ec0 <fat16_populate_vfs+0x114>
40006eb4: 9100050a     	add	x10, x8, #0x1
40006eb8: 38286ae9     	strb	w9, [x23, x8]
40006ebc: aa0a03e8     	mov	x8, x10
40006ec0: 39400329     	ldrb	w9, [x25]
40006ec4: 7100813f     	cmp	w9, #0x20
40006ec8: 54000080     	b.eq	0x40006ed8 <fat16_populate_vfs+0x12c>
40006ecc: 9100050a     	add	x10, x8, #0x1
40006ed0: 38286ae9     	strb	w9, [x23, x8]
40006ed4: aa0a03e8     	mov	x8, x10
40006ed8: 39400729     	ldrb	w9, [x25, #0x1]
40006edc: 7100813f     	cmp	w9, #0x20
40006ee0: 54000080     	b.eq	0x40006ef0 <fat16_populate_vfs+0x144>
40006ee4: 9100050a     	add	x10, x8, #0x1
40006ee8: 38286ae9     	strb	w9, [x23, x8]
40006eec: aa0a03e8     	mov	x8, x10
40006ef0: 39400b29     	ldrb	w9, [x25, #0x2]
40006ef4: 7100813f     	cmp	w9, #0x20
40006ef8: 54000080     	b.eq	0x40006f08 <fat16_populate_vfs+0x15c>
40006efc: 9100050a     	add	x10, x8, #0x1
40006f00: 38286ae9     	strb	w9, [x23, x8]
40006f04: aa0a03e8     	mov	x8, x10
40006f08: 39400f2a     	ldrb	w10, [x25, #0x3]
40006f0c: 7100815f     	cmp	w10, #0x20
40006f10: 54000240     	b.eq	0x40006f58 <fat16_populate_vfs+0x1ac>
40006f14: 3940132b     	ldrb	w11, [x25, #0x4]
40006f18: 8b0802ec     	add	x12, x23, x8
40006f1c: 91000909     	add	x9, x8, #0x2
40006f20: 39000198     	strb	w24, [x12]
40006f24: 7100817f     	cmp	w11, #0x20
40006f28: 3900058a     	strb	w10, [x12, #0x1]
40006f2c: 54000080     	b.eq	0x40006f3c <fat16_populate_vfs+0x190>
40006f30: 91000d08     	add	x8, x8, #0x3
40006f34: 38296aeb     	strb	w11, [x23, x9]
40006f38: aa0803e9     	mov	x9, x8
40006f3c: 3940172a     	ldrb	w10, [x25, #0x5]
40006f40: 7100815f     	cmp	w10, #0x20
40006f44: 54000061     	b.ne	0x40006f50 <fat16_populate_vfs+0x1a4>
40006f48: aa0903e8     	mov	x8, x9
40006f4c: 14000003     	b	0x40006f58 <fat16_populate_vfs+0x1ac>
40006f50: 91000528     	add	x8, x9, #0x1
40006f54: 38296aea     	strb	w10, [x23, x9]
40006f58: 911003e0     	add	x0, sp, #0x400
40006f5c: 910003e1     	mov	x1, sp
40006f60: 52808002     	mov	w2, #0x400              // =1024
40006f64: 38286aff     	strb	wzr, [x23, x8]
40006f68: 97fffc90     	bl	0x400061a8 <fat16_read_file>
40006f6c: 37fff5a0     	tbnz	w0, #0x1f, 0x40006e20 <fat16_populate_vfs+0x74>
40006f70: 911003e0     	add	x0, sp, #0x400
40006f74: 910003e1     	mov	x1, sp
40006f78: 97fff797     	bl	0x40004dd4 <vfs_touch>
40006f7c: 17ffffa9     	b	0x40006e20 <fat16_populate_vfs+0x74>
40006f80: 911843ff     	add	sp, sp, #0x610
40006f84: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006f88: f9400bfc     	ldr	x28, [sp, #0x10]
40006f8c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006f90: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006f94: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006f98: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006f9c: d65f03c0     	ret
		...

0000000040007000 <exception_vector_table>:
40007000: 140001e1     	b	0x40007784 <handle_sync_invalid>
40007004: d503201f     	nop
40007008: d503201f     	nop
4000700c: d503201f     	nop
40007010: d503201f     	nop
40007014: d503201f     	nop
40007018: d503201f     	nop
4000701c: d503201f     	nop
40007020: d503201f     	nop
40007024: d503201f     	nop
40007028: d503201f     	nop
4000702c: d503201f     	nop
40007030: d503201f     	nop
40007034: d503201f     	nop
40007038: d503201f     	nop
4000703c: d503201f     	nop
40007040: d503201f     	nop
40007044: d503201f     	nop
40007048: d503201f     	nop
4000704c: d503201f     	nop
40007050: d503201f     	nop
40007054: d503201f     	nop
40007058: d503201f     	nop
4000705c: d503201f     	nop
40007060: d503201f     	nop
40007064: d503201f     	nop
40007068: d503201f     	nop
4000706c: d503201f     	nop
40007070: d503201f     	nop
40007074: d503201f     	nop
40007078: d503201f     	nop
4000707c: d503201f     	nop

0000000040007080 <curr_el_sp0_irq>:
40007080: 140001ed     	b	0x40007834 <handle_irq_invalid>
40007084: d503201f     	nop
40007088: d503201f     	nop
4000708c: d503201f     	nop
40007090: d503201f     	nop
40007094: d503201f     	nop
40007098: d503201f     	nop
4000709c: d503201f     	nop
400070a0: d503201f     	nop
400070a4: d503201f     	nop
400070a8: d503201f     	nop
400070ac: d503201f     	nop
400070b0: d503201f     	nop
400070b4: d503201f     	nop
400070b8: d503201f     	nop
400070bc: d503201f     	nop
400070c0: d503201f     	nop
400070c4: d503201f     	nop
400070c8: d503201f     	nop
400070cc: d503201f     	nop
400070d0: d503201f     	nop
400070d4: d503201f     	nop
400070d8: d503201f     	nop
400070dc: d503201f     	nop
400070e0: d503201f     	nop
400070e4: d503201f     	nop
400070e8: d503201f     	nop
400070ec: d503201f     	nop
400070f0: d503201f     	nop
400070f4: d503201f     	nop
400070f8: d503201f     	nop
400070fc: d503201f     	nop

0000000040007100 <curr_el_sp0_fiq>:
40007100: 140001f8     	b	0x400078e0 <handle_fiq_invalid>
40007104: d503201f     	nop
40007108: d503201f     	nop
4000710c: d503201f     	nop
40007110: d503201f     	nop
40007114: d503201f     	nop
40007118: d503201f     	nop
4000711c: d503201f     	nop
40007120: d503201f     	nop
40007124: d503201f     	nop
40007128: d503201f     	nop
4000712c: d503201f     	nop
40007130: d503201f     	nop
40007134: d503201f     	nop
40007138: d503201f     	nop
4000713c: d503201f     	nop
40007140: d503201f     	nop
40007144: d503201f     	nop
40007148: d503201f     	nop
4000714c: d503201f     	nop
40007150: d503201f     	nop
40007154: d503201f     	nop
40007158: d503201f     	nop
4000715c: d503201f     	nop
40007160: d503201f     	nop
40007164: d503201f     	nop
40007168: d503201f     	nop
4000716c: d503201f     	nop
40007170: d503201f     	nop
40007174: d503201f     	nop
40007178: d503201f     	nop
4000717c: d503201f     	nop

0000000040007180 <curr_el_sp0_serror>:
40007180: 14000203     	b	0x4000798c <handle_serror_invalid>
40007184: d503201f     	nop
40007188: d503201f     	nop
4000718c: d503201f     	nop
40007190: d503201f     	nop
40007194: d503201f     	nop
40007198: d503201f     	nop
4000719c: d503201f     	nop
400071a0: d503201f     	nop
400071a4: d503201f     	nop
400071a8: d503201f     	nop
400071ac: d503201f     	nop
400071b0: d503201f     	nop
400071b4: d503201f     	nop
400071b8: d503201f     	nop
400071bc: d503201f     	nop
400071c0: d503201f     	nop
400071c4: d503201f     	nop
400071c8: d503201f     	nop
400071cc: d503201f     	nop
400071d0: d503201f     	nop
400071d4: d503201f     	nop
400071d8: d503201f     	nop
400071dc: d503201f     	nop
400071e0: d503201f     	nop
400071e4: d503201f     	nop
400071e8: d503201f     	nop
400071ec: d503201f     	nop
400071f0: d503201f     	nop
400071f4: d503201f     	nop
400071f8: d503201f     	nop
400071fc: d503201f     	nop

0000000040007200 <curr_el_spx_sync>:
40007200: 14000210     	b	0x40007a40 <handle_sync_exception_asm>
40007204: d503201f     	nop
40007208: d503201f     	nop
4000720c: d503201f     	nop
40007210: d503201f     	nop
40007214: d503201f     	nop
40007218: d503201f     	nop
4000721c: d503201f     	nop
40007220: d503201f     	nop
40007224: d503201f     	nop
40007228: d503201f     	nop
4000722c: d503201f     	nop
40007230: d503201f     	nop
40007234: d503201f     	nop
40007238: d503201f     	nop
4000723c: d503201f     	nop
40007240: d503201f     	nop
40007244: d503201f     	nop
40007248: d503201f     	nop
4000724c: d503201f     	nop
40007250: d503201f     	nop
40007254: d503201f     	nop
40007258: d503201f     	nop
4000725c: d503201f     	nop
40007260: d503201f     	nop
40007264: d503201f     	nop
40007268: d503201f     	nop
4000726c: d503201f     	nop
40007270: d503201f     	nop
40007274: d503201f     	nop
40007278: d503201f     	nop
4000727c: d503201f     	nop

0000000040007280 <curr_el_spx_irq>:
40007280: 1400021d     	b	0x40007af4 <handle_irq_exception_asm>
40007284: d503201f     	nop
40007288: d503201f     	nop
4000728c: d503201f     	nop
40007290: d503201f     	nop
40007294: d503201f     	nop
40007298: d503201f     	nop
4000729c: d503201f     	nop
400072a0: d503201f     	nop
400072a4: d503201f     	nop
400072a8: d503201f     	nop
400072ac: d503201f     	nop
400072b0: d503201f     	nop
400072b4: d503201f     	nop
400072b8: d503201f     	nop
400072bc: d503201f     	nop
400072c0: d503201f     	nop
400072c4: d503201f     	nop
400072c8: d503201f     	nop
400072cc: d503201f     	nop
400072d0: d503201f     	nop
400072d4: d503201f     	nop
400072d8: d503201f     	nop
400072dc: d503201f     	nop
400072e0: d503201f     	nop
400072e4: d503201f     	nop
400072e8: d503201f     	nop
400072ec: d503201f     	nop
400072f0: d503201f     	nop
400072f4: d503201f     	nop
400072f8: d503201f     	nop
400072fc: d503201f     	nop

0000000040007300 <curr_el_spx_fiq>:
40007300: 14000178     	b	0x400078e0 <handle_fiq_invalid>
40007304: d503201f     	nop
40007308: d503201f     	nop
4000730c: d503201f     	nop
40007310: d503201f     	nop
40007314: d503201f     	nop
40007318: d503201f     	nop
4000731c: d503201f     	nop
40007320: d503201f     	nop
40007324: d503201f     	nop
40007328: d503201f     	nop
4000732c: d503201f     	nop
40007330: d503201f     	nop
40007334: d503201f     	nop
40007338: d503201f     	nop
4000733c: d503201f     	nop
40007340: d503201f     	nop
40007344: d503201f     	nop
40007348: d503201f     	nop
4000734c: d503201f     	nop
40007350: d503201f     	nop
40007354: d503201f     	nop
40007358: d503201f     	nop
4000735c: d503201f     	nop
40007360: d503201f     	nop
40007364: d503201f     	nop
40007368: d503201f     	nop
4000736c: d503201f     	nop
40007370: d503201f     	nop
40007374: d503201f     	nop
40007378: d503201f     	nop
4000737c: d503201f     	nop

0000000040007380 <curr_el_spx_serror>:
40007380: 14000183     	b	0x4000798c <handle_serror_invalid>
40007384: d503201f     	nop
40007388: d503201f     	nop
4000738c: d503201f     	nop
40007390: d503201f     	nop
40007394: d503201f     	nop
40007398: d503201f     	nop
4000739c: d503201f     	nop
400073a0: d503201f     	nop
400073a4: d503201f     	nop
400073a8: d503201f     	nop
400073ac: d503201f     	nop
400073b0: d503201f     	nop
400073b4: d503201f     	nop
400073b8: d503201f     	nop
400073bc: d503201f     	nop
400073c0: d503201f     	nop
400073c4: d503201f     	nop
400073c8: d503201f     	nop
400073cc: d503201f     	nop
400073d0: d503201f     	nop
400073d4: d503201f     	nop
400073d8: d503201f     	nop
400073dc: d503201f     	nop
400073e0: d503201f     	nop
400073e4: d503201f     	nop
400073e8: d503201f     	nop
400073ec: d503201f     	nop
400073f0: d503201f     	nop
400073f4: d503201f     	nop
400073f8: d503201f     	nop
400073fc: d503201f     	nop

0000000040007400 <lower_el_aarch64_sync>:
40007400: 140000e1     	b	0x40007784 <handle_sync_invalid>
40007404: d503201f     	nop
40007408: d503201f     	nop
4000740c: d503201f     	nop
40007410: d503201f     	nop
40007414: d503201f     	nop
40007418: d503201f     	nop
4000741c: d503201f     	nop
40007420: d503201f     	nop
40007424: d503201f     	nop
40007428: d503201f     	nop
4000742c: d503201f     	nop
40007430: d503201f     	nop
40007434: d503201f     	nop
40007438: d503201f     	nop
4000743c: d503201f     	nop
40007440: d503201f     	nop
40007444: d503201f     	nop
40007448: d503201f     	nop
4000744c: d503201f     	nop
40007450: d503201f     	nop
40007454: d503201f     	nop
40007458: d503201f     	nop
4000745c: d503201f     	nop
40007460: d503201f     	nop
40007464: d503201f     	nop
40007468: d503201f     	nop
4000746c: d503201f     	nop
40007470: d503201f     	nop
40007474: d503201f     	nop
40007478: d503201f     	nop
4000747c: d503201f     	nop

0000000040007480 <lower_el_aarch64_irq>:
40007480: 140000ed     	b	0x40007834 <handle_irq_invalid>
40007484: d503201f     	nop
40007488: d503201f     	nop
4000748c: d503201f     	nop
40007490: d503201f     	nop
40007494: d503201f     	nop
40007498: d503201f     	nop
4000749c: d503201f     	nop
400074a0: d503201f     	nop
400074a4: d503201f     	nop
400074a8: d503201f     	nop
400074ac: d503201f     	nop
400074b0: d503201f     	nop
400074b4: d503201f     	nop
400074b8: d503201f     	nop
400074bc: d503201f     	nop
400074c0: d503201f     	nop
400074c4: d503201f     	nop
400074c8: d503201f     	nop
400074cc: d503201f     	nop
400074d0: d503201f     	nop
400074d4: d503201f     	nop
400074d8: d503201f     	nop
400074dc: d503201f     	nop
400074e0: d503201f     	nop
400074e4: d503201f     	nop
400074e8: d503201f     	nop
400074ec: d503201f     	nop
400074f0: d503201f     	nop
400074f4: d503201f     	nop
400074f8: d503201f     	nop
400074fc: d503201f     	nop

0000000040007500 <lower_el_aarch64_fiq>:
40007500: 140000f8     	b	0x400078e0 <handle_fiq_invalid>
40007504: d503201f     	nop
40007508: d503201f     	nop
4000750c: d503201f     	nop
40007510: d503201f     	nop
40007514: d503201f     	nop
40007518: d503201f     	nop
4000751c: d503201f     	nop
40007520: d503201f     	nop
40007524: d503201f     	nop
40007528: d503201f     	nop
4000752c: d503201f     	nop
40007530: d503201f     	nop
40007534: d503201f     	nop
40007538: d503201f     	nop
4000753c: d503201f     	nop
40007540: d503201f     	nop
40007544: d503201f     	nop
40007548: d503201f     	nop
4000754c: d503201f     	nop
40007550: d503201f     	nop
40007554: d503201f     	nop
40007558: d503201f     	nop
4000755c: d503201f     	nop
40007560: d503201f     	nop
40007564: d503201f     	nop
40007568: d503201f     	nop
4000756c: d503201f     	nop
40007570: d503201f     	nop
40007574: d503201f     	nop
40007578: d503201f     	nop
4000757c: d503201f     	nop

0000000040007580 <lower_el_aarch64_serror>:
40007580: 14000103     	b	0x4000798c <handle_serror_invalid>
40007584: d503201f     	nop
40007588: d503201f     	nop
4000758c: d503201f     	nop
40007590: d503201f     	nop
40007594: d503201f     	nop
40007598: d503201f     	nop
4000759c: d503201f     	nop
400075a0: d503201f     	nop
400075a4: d503201f     	nop
400075a8: d503201f     	nop
400075ac: d503201f     	nop
400075b0: d503201f     	nop
400075b4: d503201f     	nop
400075b8: d503201f     	nop
400075bc: d503201f     	nop
400075c0: d503201f     	nop
400075c4: d503201f     	nop
400075c8: d503201f     	nop
400075cc: d503201f     	nop
400075d0: d503201f     	nop
400075d4: d503201f     	nop
400075d8: d503201f     	nop
400075dc: d503201f     	nop
400075e0: d503201f     	nop
400075e4: d503201f     	nop
400075e8: d503201f     	nop
400075ec: d503201f     	nop
400075f0: d503201f     	nop
400075f4: d503201f     	nop
400075f8: d503201f     	nop
400075fc: d503201f     	nop

0000000040007600 <lower_el_aarch32_sync>:
40007600: 14000061     	b	0x40007784 <handle_sync_invalid>
40007604: d503201f     	nop
40007608: d503201f     	nop
4000760c: d503201f     	nop
40007610: d503201f     	nop
40007614: d503201f     	nop
40007618: d503201f     	nop
4000761c: d503201f     	nop
40007620: d503201f     	nop
40007624: d503201f     	nop
40007628: d503201f     	nop
4000762c: d503201f     	nop
40007630: d503201f     	nop
40007634: d503201f     	nop
40007638: d503201f     	nop
4000763c: d503201f     	nop
40007640: d503201f     	nop
40007644: d503201f     	nop
40007648: d503201f     	nop
4000764c: d503201f     	nop
40007650: d503201f     	nop
40007654: d503201f     	nop
40007658: d503201f     	nop
4000765c: d503201f     	nop
40007660: d503201f     	nop
40007664: d503201f     	nop
40007668: d503201f     	nop
4000766c: d503201f     	nop
40007670: d503201f     	nop
40007674: d503201f     	nop
40007678: d503201f     	nop
4000767c: d503201f     	nop

0000000040007680 <lower_el_aarch32_irq>:
40007680: 1400006d     	b	0x40007834 <handle_irq_invalid>
40007684: d503201f     	nop
40007688: d503201f     	nop
4000768c: d503201f     	nop
40007690: d503201f     	nop
40007694: d503201f     	nop
40007698: d503201f     	nop
4000769c: d503201f     	nop
400076a0: d503201f     	nop
400076a4: d503201f     	nop
400076a8: d503201f     	nop
400076ac: d503201f     	nop
400076b0: d503201f     	nop
400076b4: d503201f     	nop
400076b8: d503201f     	nop
400076bc: d503201f     	nop
400076c0: d503201f     	nop
400076c4: d503201f     	nop
400076c8: d503201f     	nop
400076cc: d503201f     	nop
400076d0: d503201f     	nop
400076d4: d503201f     	nop
400076d8: d503201f     	nop
400076dc: d503201f     	nop
400076e0: d503201f     	nop
400076e4: d503201f     	nop
400076e8: d503201f     	nop
400076ec: d503201f     	nop
400076f0: d503201f     	nop
400076f4: d503201f     	nop
400076f8: d503201f     	nop
400076fc: d503201f     	nop

0000000040007700 <lower_el_aarch32_fiq>:
40007700: 14000078     	b	0x400078e0 <handle_fiq_invalid>
40007704: d503201f     	nop
40007708: d503201f     	nop
4000770c: d503201f     	nop
40007710: d503201f     	nop
40007714: d503201f     	nop
40007718: d503201f     	nop
4000771c: d503201f     	nop
40007720: d503201f     	nop
40007724: d503201f     	nop
40007728: d503201f     	nop
4000772c: d503201f     	nop
40007730: d503201f     	nop
40007734: d503201f     	nop
40007738: d503201f     	nop
4000773c: d503201f     	nop
40007740: d503201f     	nop
40007744: d503201f     	nop
40007748: d503201f     	nop
4000774c: d503201f     	nop
40007750: d503201f     	nop
40007754: d503201f     	nop
40007758: d503201f     	nop
4000775c: d503201f     	nop
40007760: d503201f     	nop
40007764: d503201f     	nop
40007768: d503201f     	nop
4000776c: d503201f     	nop
40007770: d503201f     	nop
40007774: d503201f     	nop
40007778: d503201f     	nop
4000777c: d503201f     	nop

0000000040007780 <lower_el_aarch32_serror>:
40007780: 14000083     	b	0x4000798c <handle_serror_invalid>

0000000040007784 <handle_sync_invalid>:
40007784: d10443ff     	sub	sp, sp, #0x110
40007788: a90007e0     	stp	x0, x1, [sp]
4000778c: d5384020     	mrs	x0, ELR_EL1
40007790: d5384001     	mrs	x1, SPSR_EL1
40007794: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40007798: a94007e0     	ldp	x0, x1, [sp]
4000779c: a9010fe2     	stp	x2, x3, [sp, #0x10]
400077a0: a90217e4     	stp	x4, x5, [sp, #0x20]
400077a4: a9031fe6     	stp	x6, x7, [sp, #0x30]
400077a8: a90427e8     	stp	x8, x9, [sp, #0x40]
400077ac: a9052fea     	stp	x10, x11, [sp, #0x50]
400077b0: a90637ec     	stp	x12, x13, [sp, #0x60]
400077b4: a9073fee     	stp	x14, x15, [sp, #0x70]
400077b8: a90847f0     	stp	x16, x17, [sp, #0x80]
400077bc: a9094ff2     	stp	x18, x19, [sp, #0x90]
400077c0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400077c4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400077c8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400077cc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400077d0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400077d4: f9007bfe     	str	x30, [sp, #0xf0]
400077d8: 910003e0     	mov	x0, sp
400077dc: 97ffe255     	bl	0x40000130 <c_handle_sync_invalid>
400077e0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400077e4: d5184020     	msr	ELR_EL1, x0
400077e8: d5184001     	msr	SPSR_EL1, x1
400077ec: a94007e0     	ldp	x0, x1, [sp]
400077f0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400077f4: a94217e4     	ldp	x4, x5, [sp, #0x20]
400077f8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400077fc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40007800: a9452fea     	ldp	x10, x11, [sp, #0x50]
40007804: a94637ec     	ldp	x12, x13, [sp, #0x60]
40007808: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000780c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40007810: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40007814: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40007818: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000781c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40007820: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40007824: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40007828: f9407bfe     	ldr	x30, [sp, #0xf0]
4000782c: 910443ff     	add	sp, sp, #0x110
40007830: d69f03e0     	eret

0000000040007834 <handle_irq_invalid>:
40007834: d10443ff     	sub	sp, sp, #0x110
40007838: a90007e0     	stp	x0, x1, [sp]
4000783c: d5384020     	mrs	x0, ELR_EL1
40007840: d5384001     	mrs	x1, SPSR_EL1
40007844: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40007848: a94007e0     	ldp	x0, x1, [sp]
4000784c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40007850: a90217e4     	stp	x4, x5, [sp, #0x20]
40007854: a9031fe6     	stp	x6, x7, [sp, #0x30]
40007858: a90427e8     	stp	x8, x9, [sp, #0x40]
4000785c: a9052fea     	stp	x10, x11, [sp, #0x50]
40007860: a90637ec     	stp	x12, x13, [sp, #0x60]
40007864: a9073fee     	stp	x14, x15, [sp, #0x70]
40007868: a90847f0     	stp	x16, x17, [sp, #0x80]
4000786c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40007870: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40007874: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40007878: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000787c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40007880: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40007884: f9007bfe     	str	x30, [sp, #0xf0]
40007888: 97ffe238     	bl	0x40000168 <c_handle_irq_invalid>
4000788c: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40007890: d5184020     	msr	ELR_EL1, x0
40007894: d5184001     	msr	SPSR_EL1, x1
40007898: a94007e0     	ldp	x0, x1, [sp]
4000789c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400078a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
400078a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400078a8: a94427e8     	ldp	x8, x9, [sp, #0x40]
400078ac: a9452fea     	ldp	x10, x11, [sp, #0x50]
400078b0: a94637ec     	ldp	x12, x13, [sp, #0x60]
400078b4: a9473fee     	ldp	x14, x15, [sp, #0x70]
400078b8: a94847f0     	ldp	x16, x17, [sp, #0x80]
400078bc: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400078c0: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400078c4: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400078c8: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400078cc: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400078d0: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400078d4: f9407bfe     	ldr	x30, [sp, #0xf0]
400078d8: 910443ff     	add	sp, sp, #0x110
400078dc: d69f03e0     	eret

00000000400078e0 <handle_fiq_invalid>:
400078e0: d10443ff     	sub	sp, sp, #0x110
400078e4: a90007e0     	stp	x0, x1, [sp]
400078e8: d5384020     	mrs	x0, ELR_EL1
400078ec: d5384001     	mrs	x1, SPSR_EL1
400078f0: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400078f4: a94007e0     	ldp	x0, x1, [sp]
400078f8: a9010fe2     	stp	x2, x3, [sp, #0x10]
400078fc: a90217e4     	stp	x4, x5, [sp, #0x20]
40007900: a9031fe6     	stp	x6, x7, [sp, #0x30]
40007904: a90427e8     	stp	x8, x9, [sp, #0x40]
40007908: a9052fea     	stp	x10, x11, [sp, #0x50]
4000790c: a90637ec     	stp	x12, x13, [sp, #0x60]
40007910: a9073fee     	stp	x14, x15, [sp, #0x70]
40007914: a90847f0     	stp	x16, x17, [sp, #0x80]
40007918: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000791c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40007920: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40007924: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40007928: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000792c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40007930: f9007bfe     	str	x30, [sp, #0xf0]
40007934: 97ffe213     	bl	0x40000180 <c_handle_fiq_invalid>
40007938: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
4000793c: d5184020     	msr	ELR_EL1, x0
40007940: d5184001     	msr	SPSR_EL1, x1
40007944: a94007e0     	ldp	x0, x1, [sp]
40007948: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000794c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40007950: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40007954: a94427e8     	ldp	x8, x9, [sp, #0x40]
40007958: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000795c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40007960: a9473fee     	ldp	x14, x15, [sp, #0x70]
40007964: a94847f0     	ldp	x16, x17, [sp, #0x80]
40007968: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000796c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40007970: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40007974: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40007978: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000797c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40007980: f9407bfe     	ldr	x30, [sp, #0xf0]
40007984: 910443ff     	add	sp, sp, #0x110
40007988: d69f03e0     	eret

000000004000798c <handle_serror_invalid>:
4000798c: d10443ff     	sub	sp, sp, #0x110
40007990: a90007e0     	stp	x0, x1, [sp]
40007994: d5384020     	mrs	x0, ELR_EL1
40007998: d5384001     	mrs	x1, SPSR_EL1
4000799c: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400079a0: a94007e0     	ldp	x0, x1, [sp]
400079a4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400079a8: a90217e4     	stp	x4, x5, [sp, #0x20]
400079ac: a9031fe6     	stp	x6, x7, [sp, #0x30]
400079b0: a90427e8     	stp	x8, x9, [sp, #0x40]
400079b4: a9052fea     	stp	x10, x11, [sp, #0x50]
400079b8: a90637ec     	stp	x12, x13, [sp, #0x60]
400079bc: a9073fee     	stp	x14, x15, [sp, #0x70]
400079c0: a90847f0     	stp	x16, x17, [sp, #0x80]
400079c4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400079c8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400079cc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400079d0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400079d4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400079d8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400079dc: f9007bfe     	str	x30, [sp, #0xf0]
400079e0: 97ffe1ee     	bl	0x40000198 <c_handle_serror_invalid>
400079e4: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400079e8: d5184020     	msr	ELR_EL1, x0
400079ec: d5184001     	msr	SPSR_EL1, x1
400079f0: a94007e0     	ldp	x0, x1, [sp]
400079f4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400079f8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400079fc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40007a00: a94427e8     	ldp	x8, x9, [sp, #0x40]
40007a04: a9452fea     	ldp	x10, x11, [sp, #0x50]
40007a08: a94637ec     	ldp	x12, x13, [sp, #0x60]
40007a0c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40007a10: a94847f0     	ldp	x16, x17, [sp, #0x80]
40007a14: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40007a18: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40007a1c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40007a20: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40007a24: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40007a28: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40007a2c: f9407bfe     	ldr	x30, [sp, #0xf0]
40007a30: 910443ff     	add	sp, sp, #0x110
40007a34: d69f03e0     	eret

0000000040007a38 <trigger_undefined_instruction>:
40007a38: 00000000     	udf	#0x0
40007a3c: d65f03c0     	ret

0000000040007a40 <handle_sync_exception_asm>:
40007a40: d10443ff     	sub	sp, sp, #0x110
40007a44: a90007e0     	stp	x0, x1, [sp]
40007a48: d5384020     	mrs	x0, ELR_EL1
40007a4c: d5384001     	mrs	x1, SPSR_EL1
40007a50: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40007a54: a94007e0     	ldp	x0, x1, [sp]
40007a58: a9010fe2     	stp	x2, x3, [sp, #0x10]
40007a5c: a90217e4     	stp	x4, x5, [sp, #0x20]
40007a60: a9031fe6     	stp	x6, x7, [sp, #0x30]
40007a64: a90427e8     	stp	x8, x9, [sp, #0x40]
40007a68: a9052fea     	stp	x10, x11, [sp, #0x50]
40007a6c: a90637ec     	stp	x12, x13, [sp, #0x60]
40007a70: a9073fee     	stp	x14, x15, [sp, #0x70]
40007a74: a90847f0     	stp	x16, x17, [sp, #0x80]
40007a78: a9094ff2     	stp	x18, x19, [sp, #0x90]
40007a7c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40007a80: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40007a84: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40007a88: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40007a8c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40007a90: f9007bfe     	str	x30, [sp, #0xf0]
40007a94: 910003e0     	mov	x0, sp
40007a98: 97ffe172     	bl	0x40000060 <handle_sync_exception>
40007a9c: 9100001f     	mov	sp, x0
40007aa0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40007aa4: d5184020     	msr	ELR_EL1, x0
40007aa8: d5184001     	msr	SPSR_EL1, x1
40007aac: a94007e0     	ldp	x0, x1, [sp]
40007ab0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40007ab4: a94217e4     	ldp	x4, x5, [sp, #0x20]
40007ab8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40007abc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40007ac0: a9452fea     	ldp	x10, x11, [sp, #0x50]
40007ac4: a94637ec     	ldp	x12, x13, [sp, #0x60]
40007ac8: a9473fee     	ldp	x14, x15, [sp, #0x70]
40007acc: a94847f0     	ldp	x16, x17, [sp, #0x80]
40007ad0: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40007ad4: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40007ad8: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40007adc: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40007ae0: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40007ae4: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40007ae8: f9407bfe     	ldr	x30, [sp, #0xf0]
40007aec: 910443ff     	add	sp, sp, #0x110
40007af0: d69f03e0     	eret

0000000040007af4 <handle_irq_exception_asm>:
40007af4: d10443ff     	sub	sp, sp, #0x110
40007af8: a90007e0     	stp	x0, x1, [sp]
40007afc: d5384020     	mrs	x0, ELR_EL1
40007b00: d5384001     	mrs	x1, SPSR_EL1
40007b04: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40007b08: a94007e0     	ldp	x0, x1, [sp]
40007b0c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40007b10: a90217e4     	stp	x4, x5, [sp, #0x20]
40007b14: a9031fe6     	stp	x6, x7, [sp, #0x30]
40007b18: a90427e8     	stp	x8, x9, [sp, #0x40]
40007b1c: a9052fea     	stp	x10, x11, [sp, #0x50]
40007b20: a90637ec     	stp	x12, x13, [sp, #0x60]
40007b24: a9073fee     	stp	x14, x15, [sp, #0x70]
40007b28: a90847f0     	stp	x16, x17, [sp, #0x80]
40007b2c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40007b30: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40007b34: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40007b38: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40007b3c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40007b40: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40007b44: f9007bfe     	str	x30, [sp, #0xf0]
40007b48: 910003e0     	mov	x0, sp
40007b4c: 97ffe199     	bl	0x400001b0 <handle_irq_exception>
40007b50: 9100001f     	mov	sp, x0
40007b54: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40007b58: d5184020     	msr	ELR_EL1, x0
40007b5c: d5184001     	msr	SPSR_EL1, x1
40007b60: a94007e0     	ldp	x0, x1, [sp]
40007b64: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40007b68: a94217e4     	ldp	x4, x5, [sp, #0x20]
40007b6c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40007b70: a94427e8     	ldp	x8, x9, [sp, #0x40]
40007b74: a9452fea     	ldp	x10, x11, [sp, #0x50]
40007b78: a94637ec     	ldp	x12, x13, [sp, #0x60]
40007b7c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40007b80: a94847f0     	ldp	x16, x17, [sp, #0x80]
40007b84: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40007b88: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40007b8c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40007b90: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40007b94: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40007b98: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40007b9c: f9407bfe     	ldr	x30, [sp, #0xf0]
40007ba0: 910443ff     	add	sp, sp, #0x110
40007ba4: d69f03e0     	eret
