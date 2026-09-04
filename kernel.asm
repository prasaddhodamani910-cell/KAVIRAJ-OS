
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
40000048: 30 ad 04 40  	.word	0x4004ad30
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 b0 00 40  	.word	0x4000b000
40000054: 00 00 00 00  	.word	0x00000000
40000058: 30 ad 03 40  	.word	0x4003ad30
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 300426e0     	adr	x0, 0x4000854d <__rodata_start+0x154d>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000d8c     	bl	0x400036b4 <uart_puts>
40000088: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000008c: 91362800     	add	x0, x0, #0xd8a
40000090: aa1403e1     	mov	x1, x20
40000094: 94000e9d     	bl	0x40003b08 <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000a0: 913db400     	add	x0, x0, #0xf6d
400000a4: 94000e99     	bl	0x40003b08 <uart_printf>
400000a8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000ac: 91101800     	add	x0, x0, #0x406
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000e95     	bl	0x40003b08 <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400000c0: 91180400     	add	x0, x0, #0x601
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000e90     	bl	0x40003b08 <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000f0: 910d4c00     	add	x0, x0, #0x353
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000fc: 912c0c00     	add	x0, x0, #0xb03
40000100: 94000d6d     	bl	0x400036b4 <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000010c: 91027000     	add	x0, x0, #0x9c
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000d67     	bl	0x400036b4 <uart_puts>
4000011c: aa1303e0     	mov	x0, x19
40000120: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40000124: f9400bf5     	ldr	x21, [sp, #0x10]
40000128: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000012c: d65f03c0     	ret

0000000040000130 <c_handle_sync_invalid>:
40000130: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000134: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000138: aa0003f3     	mov	x19, x0
4000013c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000140: 9137dc00     	add	x0, x0, #0xdf7
40000144: 910003fd     	mov	x29, sp
40000148: d5385214     	mrs	x20, ESR_EL1
4000014c: 94000e6f     	bl	0x40003b08 <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000158: 9128f400     	add	x0, x0, #0xa3d
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000e6a     	bl	0x40003b08 <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000170: 91366c00     	add	x0, x0, #0xd9b
40000174: 910003fd     	mov	x29, sp
40000178: 94000d4f     	bl	0x400036b4 <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000188: 912c7400     	add	x0, x0, #0xb1d
4000018c: 910003fd     	mov	x29, sp
40000190: 94000d49     	bl	0x400036b4 <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001a0: 91097400     	add	x0, x0, #0x25d
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000d43     	bl	0x400036b4 <uart_puts>
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
400001d8: 94000a55     	bl	0x40002b2c <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 9400153a     	bl	0x400056c8 <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001f0: 910e6400     	add	x0, x0, #0x399
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000e44     	bl	0x40003b08 <uart_printf>
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
400002e8: 100568d3     	adr	x19, 0x4000b000 <__bss_start>
400002ec: aa0003f4     	mov	x20, x0
400002f0: aa1303e0     	mov	x0, x19
400002f4: 2a1f03e1     	mov	w1, wzr
400002f8: 52864a82     	mov	w2, #0x3254             // =12884
400002fc: 9400099e     	bl	0x40002974 <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 94000975     	bl	0x400028e0 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 940011c4     	bl	0x40004a2c <vfs_find>
40000320: d0000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
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
400003bc: 50042640     	adr	x0, 0x40008886 <__rodata_start+0x1886>
400003c0: 94000cbd     	bl	0x400036b4 <uart_puts>
400003c4: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400003c8: 91314694     	add	x20, x20, #0xc51
400003cc: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400003d0: 910372d6     	add	x22, x22, #0xdc
400003d4: 90000058     	adrp	x24, 0x40008000 <__rodata_start+0x1000>
400003d8: 910d9718     	add	x24, x24, #0x365
400003dc: 90000059     	adrp	x25, 0x40008000 <__rodata_start+0x1000>
400003e0: 911af339     	add	x25, x25, #0x6bc
400003e4: d000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: d000007b     	adrp	x27, 0x4000e000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000cac     	bl	0x400036b4 <uart_puts>
40000408: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000040c: 91076800     	add	x0, x0, #0x1da
40000410: 94000ca9     	bl	0x400036b4 <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000ca7     	bl	0x400036b4 <uart_puts>
4000041c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000420: 9136e000     	add	x0, x0, #0xdb8
40000424: aa1303e1     	mov	x1, x19
40000428: 94000db8     	bl	0x40003b08 <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000434: 910c6d29     	add	x9, x9, #0x31b
40000438: 7100011f     	cmp	w8, #0x0
4000043c: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
40000440: 91243508     	add	x8, x8, #0x90d
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000c9b     	bl	0x400036b4 <uart_puts>
4000044c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000450: 913e6c00     	add	x0, x0, #0xf9b
40000454: 94000c98     	bl	0x400036b4 <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000c8f     	bl	0x400036b4 <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000c8d     	bl	0x400036b4 <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000c88     	bl	0x400036b4 <uart_puts>
40000498: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000049c: 910dc000     	add	x0, x0, #0x370
400004a0: 94000c85     	bl	0x400036b4 <uart_puts>
400004a4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400004a8: 912ce800     	add	x0, x0, #0xb3a
400004ac: 94000c82     	bl	0x400036b4 <uart_puts>
400004b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400004b4: 911af800     	add	x0, x0, #0x6be
400004b8: 94000c7f     	bl	0x400036b4 <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400004c8: 9110c800     	add	x0, x0, #0x432
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000d8c     	bl	0x40003b08 <uart_printf>
400004dc: 94000caa     	bl	0x40003784 <uart_getc>
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
40000550: 940008dd     	bl	0x400028c4 <kstrcpy>
40000554: b9824b68     	ldrsw	x8, [x27, #0x248]
40000558: aa1503e0     	mov	x0, x21
4000055c: eb0802df     	cmp	x22, x8
40000560: 54ffff2c     	b.gt	0x40000544 <launch_kedit+0x280>
40000564: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
40000568: 910102b5     	add	x21, x21, #0x40
4000056c: 910023e0     	add	x0, sp, #0x8
40000570: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000574: 8b081ea8     	add	x8, x21, x8, lsl #7
40000578: 8b090101     	add	x1, x8, x9
4000057c: 940008d2     	bl	0x400028c4 <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 940008c8     	bl	0x400028c4 <kstrcpy>
400005a8: b97202a8     	ldr	w8, [x21, #0x3200]
400005ac: b93206bf     	str	wzr, [x21, #0x3204]
400005b0: b93212bc     	str	w28, [x21, #0x3210]
400005b4: 11000508     	add	w8, w8, #0x1
400005b8: b93202a8     	str	w8, [x21, #0x3200]
400005bc: 14000081     	b	0x400007c0 <launch_kedit+0x4fc>
400005c0: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400005c4: b9424508     	ldr	w8, [x8, #0x244]
400005c8: 7100051f     	cmp	w8, #0x1
400005cc: 54000fab     	b.lt	0x400007c0 <launch_kedit+0x4fc>
400005d0: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400005d4: 8b081e68     	add	x8, x19, x8, lsl #7
400005d8: 91010100     	add	x0, x8, #0x40
400005dc: 9400088b     	bl	0x40002808 <kstrlen>
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
40000618: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
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
40000650: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
40000654: 910102b5     	add	x21, x21, #0x40
40000658: 14000006     	b	0x40000670 <launch_kedit+0x3ac>
4000065c: b98242e8     	ldrsw	x8, [x23, #0x240]
40000660: 9100079c     	add	x28, x28, #0x1
40000664: 910202b5     	add	x21, x21, #0x80
40000668: eb08039f     	cmp	x28, x8
4000066c: 540001ca     	b.ge	0x400006a4 <launch_kedit+0x3e0>
40000670: aa1503e0     	mov	x0, x21
40000674: 94000865     	bl	0x40002808 <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 94000866     	bl	0x40002824 <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 94000863     	bl	0x40002824 <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 9400125b     	bl	0x40005018 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400006bc: 91314694     	add	x20, x20, #0xc51
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c30     	bl	0x40003784 <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c2e     	bl	0x40003784 <uart_getc>
400006d0: 71016e9f     	cmp	w20, #0x5b
400006d4: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400006d8: 91314694     	add	x20, x20, #0xc51
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
40000710: 9400083e     	bl	0x40002808 <kstrlen>
40000714: b9724668     	ldr	w8, [x19, #0x3244]
40000718: 6b00011f     	cmp	w8, w0
4000071c: 5400052d     	b.le	0x400007c0 <launch_kedit+0x4fc>
40000720: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000724: b9024500     	str	w0, [x8, #0x244]
40000728: 14000026     	b	0x400007c0 <launch_kedit+0x4fc>
4000072c: 7100611f     	cmp	w8, #0x18
40000730: 54000ac0     	b.eq	0x40000888 <launch_kedit+0x5c4>
40000734: 510082a8     	sub	w8, w21, #0x20
40000738: 12001d08     	and	w8, w8, #0xff
4000073c: 7101791f     	cmp	w8, #0x5e
40000740: 54000408     	b.hi	0x400007c0 <launch_kedit+0x4fc>
40000744: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000748: b9424508     	ldr	w8, [x8, #0x244]
4000074c: 7101f91f     	cmp	w8, #0x7e
40000750: 5400038c     	b.gt	0x400007c0 <launch_kedit+0x4fc>
40000754: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000758: 8b081e68     	add	x8, x19, x8, lsl #7
4000075c: 91010100     	add	x0, x8, #0x40
40000760: 9400082a     	bl	0x40002808 <kstrlen>
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
400007c0: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400007c4: 91092129     	add	x9, x9, #0x248
400007c8: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
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
40000824: 940007f9     	bl	0x40002808 <kstrlen>
40000828: eb14001f     	cmp	x0, x20
4000082c: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
40000830: 91314694     	add	x20, x20, #0xc51
40000834: 54fffc69     	b.ls	0x400007c0 <launch_kedit+0x4fc>
40000838: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
4000083c: b9424528     	ldr	w8, [x9, #0x244]
40000840: 11000508     	add	w8, w8, #0x1
40000844: b9024528     	str	w8, [x9, #0x244]
40000848: 17ffffde     	b	0x400007c0 <launch_kedit+0x4fc>
4000084c: 12001c09     	and	w9, w0, #0xff
40000850: 7101113f     	cmp	w9, #0x44
40000854: 54000101     	b.ne	0x40000874 <launch_kedit+0x5b0>
40000858: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
4000085c: b9424529     	ldr	w9, [x9, #0x244]
40000860: 71000529     	subs	w9, w9, #0x1
40000864: 5400008b     	b.lt	0x40000874 <launch_kedit+0x5b0>
40000868: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
4000086c: b9024509     	str	w9, [x8, #0x244]
40000870: 17ffffd4     	b	0x400007c0 <launch_kedit+0x4fc>
40000874: 51010409     	sub	w9, w0, #0x41
40000878: 12001d29     	and	w9, w9, #0xff
4000087c: 7100093f     	cmp	w9, #0x2
40000880: 54fff423     	b.lo	0x40000704 <launch_kedit+0x440>
40000884: 17ffffcf     	b	0x400007c0 <launch_kedit+0x4fc>
40000888: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000088c: 91223000     	add	x0, x0, #0x88c
40000890: 94000b89     	bl	0x400036b4 <uart_puts>
40000894: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000898: 9123ec00     	add	x0, x0, #0x8fb
4000089c: 94000b86     	bl	0x400036b4 <uart_puts>
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
400008d0: 3003efb3     	adr	x19, 0x400086c5 <__rodata_start+0x16c5>
400008d4: 72a05f54     	movk	w20, #0x2fa, lsl #16
400008d8: a9017bfd     	stp	x29, x30, [sp, #0x10]
400008dc: 910043fd     	add	x29, sp, #0x10
400008e0: aa1303e0     	mov	x0, x19
400008e4: 94000b74     	bl	0x400036b4 <uart_puts>
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
4000090c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000910: 91076800     	add	x0, x0, #0x1da
40000914: 910003fd     	mov	x29, sp
40000918: 94000b67     	bl	0x400036b4 <uart_puts>
4000091c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000920: 911af000     	add	x0, x0, #0x6bc
40000924: 94000b64     	bl	0x400036b4 <uart_puts>
40000928: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000092c: 910e7400     	add	x0, x0, #0x39d
40000930: 94000b61     	bl	0x400036b4 <uart_puts>
40000934: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000938: 91246800     	add	x0, x0, #0x91a
4000093c: 94000b5e     	bl	0x400036b4 <uart_puts>
40000940: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000944: 91374c00     	add	x0, x0, #0xdd3
40000948: 94000b5b     	bl	0x400036b4 <uart_puts>
4000094c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000b58     	bl	0x400036b4 <uart_puts>
40000958: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000095c: 91383800     	add	x0, x0, #0xe0e
40000960: 94000b55     	bl	0x400036b4 <uart_puts>
40000964: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000968: 910ee400     	add	x0, x0, #0x3b9
4000096c: 94000b52     	bl	0x400036b4 <uart_puts>
40000970: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000974: 913e8400     	add	x0, x0, #0xfa1
40000978: 94000c64     	bl	0x40003b08 <uart_printf>
4000097c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000980: 911b1c00     	add	x0, x0, #0x6c7
40000984: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000988: 9116f021     	add	x1, x1, #0x5bc
4000098c: 94000c5f     	bl	0x40003b08 <uart_printf>
40000990: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000994: 9100a000     	add	x0, x0, #0x28
40000998: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000099c: 91392821     	add	x1, x1, #0xe4a
400009a0: 94000c5a     	bl	0x40003b08 <uart_printf>
400009a4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009a8: 912cfc00     	add	x0, x0, #0xb3f
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000b41     	b	0x400036b4 <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009bc: 91099800     	add	x0, x0, #0x266
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b3c     	bl	0x400036b4 <uart_puts>
400009c8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009cc: 91160800     	add	x0, x0, #0x582
400009d0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009d4: 91396c21     	add	x1, x1, #0xe5b
400009d8: 94000c4c     	bl	0x40003b08 <uart_printf>
400009dc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009e0: 9126e000     	add	x0, x0, #0x9b8
400009e4: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
400009e8: 9116f021     	add	x1, x1, #0x5bc
400009ec: 94000c47     	bl	0x40003b08 <uart_printf>
400009f0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009f4: 910ca000     	add	x0, x0, #0x328
400009f8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009fc: 91392821     	add	x1, x1, #0xe4a
40000a00: 94000c42     	bl	0x40003b08 <uart_printf>
40000a04: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000a08: 9101e000     	add	x0, x0, #0x78
40000a0c: 94000b2a     	bl	0x400036b4 <uart_puts>
40000a10: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a14: 91224800     	add	x0, x0, #0x892
40000a18: 94000b27     	bl	0x400036b4 <uart_puts>
40000a1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a20: 911af000     	add	x0, x0, #0x6bc
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b23     	b	0x400036b4 <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a34: 91040000     	add	x0, x0, #0x100
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b1a     	bl	0x400036b4 <uart_puts>
40000a50: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a54: 91292c00     	add	x0, x0, #0xa4b
40000a58: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a5c: 91396c21     	add	x1, x1, #0xe5b
40000a60: f0000022     	adrp	x2, 0x40007000 <__rodata_start>
40000a64: 9116f042     	add	x2, x2, #0x5bc
40000a68: 94000c28     	bl	0x40003b08 <uart_printf>
40000a6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a70: 9129a800     	add	x0, x0, #0xa6a
40000a74: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a78: 91392821     	add	x1, x1, #0xe4a
40000a7c: 94000c23     	bl	0x40003b08 <uart_printf>
40000a80: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a84: 91330000     	add	x0, x0, #0xcc0
40000a88: 94000c20     	bl	0x40003b08 <uart_printf>
40000a8c: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40000a90: 91116908     	add	x8, x8, #0x45a
40000a94: b0000049     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40000a98: 9102b529     	add	x9, x9, #0xad
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000aa4: 91175c00     	add	x0, x0, #0x5d7
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000ab4: 91255529     	add	x9, x9, #0x955
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c12     	bl	0x40003b08 <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000acc: 91166c00     	add	x0, x0, #0x59b
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c0d     	bl	0x40003b08 <uart_printf>
40000ad8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000adc: 912f8400     	add	x0, x0, #0xbe1
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c08     	bl	0x40003b08 <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 1002c582     	adr	x2, 0x400063a8 <__text_end>
40000afc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b00: 91316000     	add	x0, x0, #0xc58
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c00     	bl	0x40003b08 <uart_printf>
40000b0c: d503201f     	nop
40000b10: 10032781     	adr	x1, 0x40007000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 10045fc2     	adr	x2, 0x40009710 <__rodata_end>
40000b1c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b20: 911b9000     	add	x0, x0, #0x6e4
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000bf8     	bl	0x40003b08 <uart_printf>
40000b2c: d503201f     	nop
40000b30: 1004a681     	adr	x1, 0x4000a000 <next_pid>
40000b34: d503201f     	nop
40000b38: 101d0fc2     	adr	x2, 0x4003ad30
40000b3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b40: 912d1400     	add	x0, x0, #0xb45
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000bf0     	bl	0x40003b08 <uart_printf>
40000b4c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b50: 91000c00     	add	x0, x0, #0x3
40000b54: d503201f     	nop
40000b58: 10250ec1     	adr	x1, 0x4004ad30 <__stack_top>
40000b5c: 94000beb     	bl	0x40003b08 <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b68: 911af000     	add	x0, x0, #0x6bc
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000ad1     	b	0x400036b4 <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b7c: 9102e000     	add	x0, x0, #0xb8
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000acc     	bl	0x400036b4 <uart_puts>
40000b88: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b8c: 912fec00     	add	x0, x0, #0xbfb
40000b90: 94000ac9     	bl	0x400036b4 <uart_puts>
40000b94: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b98: 9117e000     	add	x0, x0, #0x5f8
40000b9c: 94000ac6     	bl	0x400036b4 <uart_puts>
40000ba0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ba4: 912a1000     	add	x0, x0, #0xa84
40000ba8: 94000ac3     	bl	0x400036b4 <uart_puts>
40000bac: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bb0: 911c3800     	add	x0, x0, #0x70e
40000bb4: 94000ac0     	bl	0x400036b4 <uart_puts>
40000bb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000bbc: 91078800     	add	x0, x0, #0x1e2
40000bc0: 94000abd     	bl	0x400036b4 <uart_puts>
40000bc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bc8: 91320800     	add	x0, x0, #0xc82
40000bcc: 94000aba     	bl	0x400036b4 <uart_puts>
40000bd0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000bd4: 91119800     	add	x0, x0, #0x466
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000ab6     	b	0x400036b4 <uart_puts>

0000000040000be0 <read_line>:
40000be0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000be4: f9000bf7     	str	x23, [sp, #0x10]
40000be8: aa1f03f7     	mov	x23, xzr
40000bec: 910003fd     	mov	x29, sp
40000bf0: a90257f6     	stp	x22, x21, [sp, #0x20]
40000bf4: d1000435     	sub	x21, x1, #0x1
40000bf8: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000bfc: aa0003f3     	mov	x19, x0
40000c00: b0000054     	adrp	x20, 0x40009000 <__rodata_start+0x2000>
40000c04: 91187e94     	add	x20, x20, #0x61f
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000ade     	bl	0x40003784 <uart_getc>
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
40000c60: 94000a7e     	bl	0x40003658 <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000a8f     	bl	0x400036b4 <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c84: 91008c00     	add	x0, x0, #0x23
40000c88: 94000a8b     	bl	0x400036b4 <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cac: 91258400     	add	x0, x0, #0x961
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000a80     	bl	0x400036b4 <uart_puts>
40000cb8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cbc: 9114b800     	add	x0, x0, #0x52e
40000cc0: 94000a7d     	bl	0x400036b4 <uart_puts>
40000cc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cc8: 91234800     	add	x0, x0, #0x8d2
40000ccc: 94000a7a     	bl	0x400036b4 <uart_puts>
40000cd0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cd4: 91009800     	add	x0, x0, #0x26
40000cd8: 94000a77     	bl	0x400036b4 <uart_puts>
40000cdc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ce0: 91049000     	add	x0, x0, #0x124
40000ce4: 94000a74     	bl	0x400036b4 <uart_puts>
40000ce8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cec: 91399800     	add	x0, x0, #0xe66
40000cf0: 94000a71     	bl	0x400036b4 <uart_puts>
40000cf4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000cf8: 9112c400     	add	x0, x0, #0x4b1
40000cfc: 94000a6e     	bl	0x400036b4 <uart_puts>
40000d00: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d04: 911d6400     	add	x0, x0, #0x759
40000d08: 94000a6b     	bl	0x400036b4 <uart_puts>
40000d0c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d10: 911c4c00     	add	x0, x0, #0x713
40000d14: 94000a68     	bl	0x400036b4 <uart_puts>
40000d18: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d1c: 9113dc00     	add	x0, x0, #0x4f7
40000d20: 94000a65     	bl	0x400036b4 <uart_puts>
40000d24: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d28: 911d5000     	add	x0, x0, #0x754
40000d2c: 94000a62     	bl	0x400036b4 <uart_puts>
40000d30: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d34: 91332400     	add	x0, x0, #0xcc9
40000d38: 94000a5f     	bl	0x400036b4 <uart_puts>
40000d3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d40: 91038400     	add	x0, x0, #0xe1
40000d44: 94000a5c     	bl	0x400036b4 <uart_puts>
40000d48: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d4c: 9103c000     	add	x0, x0, #0xf0
40000d50: 94000a59     	bl	0x400036b4 <uart_puts>
40000d54: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d58: 91243800     	add	x0, x0, #0x90e
40000d5c: 94000a56     	bl	0x400036b4 <uart_puts>
40000d60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d64: 9130f000     	add	x0, x0, #0xc3c
40000d68: 94000a53     	bl	0x400036b4 <uart_puts>
40000d6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d70: 91052c00     	add	x0, x0, #0x14b
40000d74: 94000a50     	bl	0x400036b4 <uart_puts>
40000d78: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d7c: 91170800     	add	x0, x0, #0x5c2
40000d80: 94000a4d     	bl	0x400036b4 <uart_puts>
40000d84: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d88: 91188c00     	add	x0, x0, #0x623
40000d8c: 94000a4a     	bl	0x400036b4 <uart_puts>
40000d90: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d94: 910f6000     	add	x0, x0, #0x3d8
40000d98: 94000a47     	bl	0x400036b4 <uart_puts>
40000d9c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000da0: 910a2000     	add	x0, x0, #0x288
40000da4: 94000a44     	bl	0x400036b4 <uart_puts>
40000da8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dac: 9108c000     	add	x0, x0, #0x230
40000db0: 94000a41     	bl	0x400036b4 <uart_puts>
40000db4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000db8: 9104a400     	add	x0, x0, #0x129
40000dbc: 94000a3e     	bl	0x400036b4 <uart_puts>
40000dc0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dc4: 911e5800     	add	x0, x0, #0x796
40000dc8: 94000a3b     	bl	0x400036b4 <uart_puts>
40000dcc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dd0: 91107000     	add	x0, x0, #0x41c
40000dd4: 94000a38     	bl	0x400036b4 <uart_puts>
40000dd8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ddc: 9110ec00     	add	x0, x0, #0x43b
40000de0: 94000a35     	bl	0x400036b4 <uart_puts>
40000de4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000de8: 9119b000     	add	x0, x0, #0x66c
40000dec: 94000a32     	bl	0x400036b4 <uart_puts>
40000df0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000df4: 911e3400     	add	x0, x0, #0x78d
40000df8: 94000a2f     	bl	0x400036b4 <uart_puts>
40000dfc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e00: 9133d400     	add	x0, x0, #0xcf5
40000e04: 94000a2c     	bl	0x400036b4 <uart_puts>
40000e08: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e0c: 91044c00     	add	x0, x0, #0x113
40000e10: 94000a29     	bl	0x400036b4 <uart_puts>
40000e14: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000e18: 9105ac00     	add	x0, x0, #0x16b
40000e1c: 94000a26     	bl	0x400036b4 <uart_puts>
40000e20: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e24: 91297800     	add	x0, x0, #0xa5e
40000e28: 94000a23     	bl	0x400036b4 <uart_puts>
40000e2c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000e30: 91183000     	add	x0, x0, #0x60c
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a1f     	b	0x400036b4 <uart_puts>

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
40000f00: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f04: 91228c21     	add	x1, x1, #0x8a3
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 9400064e     	bl	0x40002848 <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f1c: 9126b821     	add	x1, x1, #0x9ae
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 94000649     	bl	0x40002848 <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f30: 9105f821     	add	x1, x1, #0x17e
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 94000644     	bl	0x40002848 <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f44: 9131f021     	add	x1, x1, #0xc7c
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 9400063f     	bl	0x40002848 <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f58: 910c1821     	add	x1, x1, #0x306
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 9400063a     	bl	0x40002848 <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f6c: 9124c421     	add	x1, x1, #0x931
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 94000635     	bl	0x40002848 <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f80: 9133c421     	add	x1, x1, #0xcf1
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 94000630     	bl	0x40002848 <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f94: 910a5c21     	add	x1, x1, #0x297
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 9400062b     	bl	0x40002848 <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fa8: 9126d421     	add	x1, x1, #0x9b5
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000626     	bl	0x40002848 <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fbc: 912a3c21     	add	x1, x1, #0xa8f
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 94000621     	bl	0x40002848 <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fd0: 91152421     	add	x1, x1, #0x549
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 9400061c     	bl	0x40002848 <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000fe4: 9114e821     	add	x1, x1, #0x53a
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000617     	bl	0x40002848 <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000ff8: 9111e021     	add	x1, x1, #0x478
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 94000612     	bl	0x40002848 <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000100c: 911ed021     	add	x1, x1, #0x7b4
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 9400060d     	bl	0x40002848 <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001020: 912ee821     	add	x1, x1, #0xbba
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 94000608     	bl	0x40002848 <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001034: 911eec21     	add	x1, x1, #0x7bb
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 94000603     	bl	0x40002848 <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001048: 913aa821     	add	x1, x1, #0xeaa
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 940005fe     	bl	0x40002848 <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000105c: 9101a421     	add	x1, x1, #0x69
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 940005f9     	bl	0x40002848 <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001070: 910c2421     	add	x1, x1, #0x309
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 940005f4     	bl	0x40002848 <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001084: 910d0421     	add	x1, x1, #0x341
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 940005ef     	bl	0x40002848 <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001098: 9119e421     	add	x1, x1, #0x679
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 940005ea     	bl	0x40002848 <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010ac: 91200c21     	add	x1, x1, #0x803
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 940005e5     	bl	0x40002848 <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010c0: 9107c021     	add	x1, x1, #0x1f0
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 940005e0     	bl	0x40002848 <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010d4: 910d1c21     	add	x1, x1, #0x347
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 940005db     	bl	0x40002848 <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010e8: 91202421     	add	x1, x1, #0x809
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 940005d6     	bl	0x40002848 <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010fc: 9119fc21     	add	x1, x1, #0x67f
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 940005d1     	bl	0x40002848 <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001110: 91062421     	add	x1, x1, #0x189
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 940005cc     	bl	0x40002848 <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001124: 910a4021     	add	x1, x1, #0x290
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 940005c7     	bl	0x40002848 <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001138: 912b7021     	add	x1, x1, #0xadc
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 940005c2     	bl	0x40002848 <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
4000114c: 911a3821     	add	x1, x1, #0x68e
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 940005bd     	bl	0x40002848 <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001160: 910aa821     	add	x1, x1, #0x2aa
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 940005b8     	bl	0x40002848 <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001174: 912f4c21     	add	x1, x1, #0xbd3
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 940005b3     	bl	0x40002848 <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001188: 910abc00     	add	x0, x0, #0x2af
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011a0: 91099800     	add	x0, x0, #0x266
400011a4: 94000944     	bl	0x400036b4 <uart_puts>
400011a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011ac: 91160800     	add	x0, x0, #0x582
400011b0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011b4: 91396c21     	add	x1, x1, #0xe5b
400011b8: 94000a54     	bl	0x40003b08 <uart_printf>
400011bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011c0: 9126e000     	add	x0, x0, #0x9b8
400011c4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400011c8: 9116f021     	add	x1, x1, #0x5bc
400011cc: 94000a4f     	bl	0x40003b08 <uart_printf>
400011d0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011d4: 910ca000     	add	x0, x0, #0x328
400011d8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011dc: 91392821     	add	x1, x1, #0xe4a
400011e0: 94000a4a     	bl	0x40003b08 <uart_printf>
400011e4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400011e8: 9101e000     	add	x0, x0, #0x78
400011ec: 94000932     	bl	0x400036b4 <uart_puts>
400011f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011f4: 91224800     	add	x0, x0, #0x892
400011f8: 9400092f     	bl	0x400036b4 <uart_puts>
400011fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001200: 911af000     	add	x0, x0, #0x6bc
40001204: 9400092c     	bl	0x400036b4 <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001210: 913b8400     	add	x0, x0, #0xee1
40001214: 94000928     	bl	0x400036b4 <uart_puts>
40001218: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000121c: 910aec00     	add	x0, x0, #0x2bb
40001220: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001224: 9116f021     	add	x1, x1, #0x5bc
40001228: 94000a38     	bl	0x40003b08 <uart_printf>
4000122c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001230: 912dbc00     	add	x0, x0, #0xb6f
40001234: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001238: 91392821     	add	x1, x1, #0xe4a
4000123c: 94000a33     	bl	0x40003b08 <uart_printf>
40001240: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001244: 91053c00     	add	x0, x0, #0x14f
40001248: 9400091b     	bl	0x400036b4 <uart_puts>
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
40001274: 94000565     	bl	0x40002808 <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000f67     	bl	0x4000501c <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000128c: 9109f400     	add	x0, x0, #0x27d
40001290: 94000909     	bl	0x400036b4 <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 9400055b     	bl	0x40002808 <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 9400062b     	bl	0x40002b5c <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 940001f2     	bl	0x40001a84 <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012c8: 91190c00     	add	x0, x0, #0x643
400012cc: 940008fa     	bl	0x400036b4 <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400012d8: 912b4800     	add	x0, x0, #0xad2
400012dc: 940008f6     	bl	0x400036b4 <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012e8: 91348800     	add	x0, x0, #0xd22
400012ec: 940008f2     	bl	0x400036b4 <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000326     	bl	0x40001f8c <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 94000542     	bl	0x40002808 <kstrlen>
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
40001344: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001348: 9124dc21     	add	x1, x1, #0x937
4000134c: aa1303e0     	mov	x0, x19
40001350: 940005a8     	bl	0x400029f0 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f2b     	bl	0x40005018 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001378: 91061821     	add	x1, x1, #0x186
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 94000532     	bl	0x40002848 <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000138c: 911a0000     	add	x0, x0, #0x680
40001390: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001394: 91396c21     	add	x1, x1, #0xe5b
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400013a0: 91118800     	add	x0, x0, #0x462
400013a4: 940008c4     	bl	0x400036b4 <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 94000261     	bl	0x40001d38 <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400013c8: 913e0800     	add	x0, x0, #0xf82
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400013d4: 913e5800     	add	x0, x0, #0xf96
400013d8: 940008b7     	bl	0x400036b4 <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013e4: 911a0000     	add	x0, x0, #0x680
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013f4: 91196400     	add	x0, x0, #0x659
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 940009c3     	bl	0x40003b08 <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d38     	bl	0x400048e4 <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 940004fe     	bl	0x40002808 <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000d84     	bl	0x40004a2c <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
40001434: 91198508     	add	x8, x8, #0x661
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 940009b2     	bl	0x40003b08 <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d28     	bl	0x400048f0 <vfs_getcwd>
40001454: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001458: 911a0000     	add	x0, x0, #0x680
4000145c: 910003e1     	mov	x1, sp
40001460: 940009aa     	bl	0x40003b08 <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000146c: 911f5000     	add	x0, x0, #0x7d4
40001470: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001474: 91396c21     	add	x1, x1, #0xe5b
40001478: d0000022     	adrp	x2, 0x40007000 <__rodata_start>
4000147c: 9116f042     	add	x2, x2, #0x5bc
40001480: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x1000>
40001484: 91392863     	add	x3, x3, #0xe4a
40001488: 940009a0     	bl	0x40003b08 <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f1b     	bl	0x40005100 <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000dc8     	bl	0x40004bc0 <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014ac: 9109b000     	add	x0, x0, #0x26c
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014bc: 9111d400     	add	x0, x0, #0x475
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 940004cf     	bl	0x40002808 <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000d55     	bl	0x40004a2c <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400014ec: 910c3400     	add	x0, x0, #0x30d
400014f0: 94000871     	bl	0x400036b4 <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 940004c3     	bl	0x40002808 <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000dd3     	bl	0x40004c54 <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001514: 913efc00     	add	x0, x0, #0xfbf
40001518: 94000867     	bl	0x400036b4 <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 940004b9     	bl	0x40002808 <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e1e     	bl	0x40004dac <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001540: 910a6c00     	add	x0, x0, #0x29b
40001544: 9400085c     	bl	0x400036b4 <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001550: 91067800     	add	x0, x0, #0x19e
40001554: 94000858     	bl	0x400036b4 <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 9400053e     	bl	0x40002a5c <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000ea8     	bl	0x40005018 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001584: 9111f800     	add	x0, x0, #0x47e
40001588: 9400084b     	bl	0x400036b4 <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001594: 9112c400     	add	x0, x0, #0x4b1
40001598: 94000847     	bl	0x400036b4 <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015a4: 91076800     	add	x0, x0, #0x1da
400015a8: 94000843     	bl	0x400036b4 <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015b4: 911af000     	add	x0, x0, #0x6bc
400015b8: 9400083f     	bl	0x400036b4 <uart_puts>
400015bc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015c0: 9133dc00     	add	x0, x0, #0xcf7
400015c4: 9400083c     	bl	0x400036b4 <uart_puts>
400015c8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 94000839     	bl	0x400036b4 <uart_puts>
400015d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015d8: 91321000     	add	x0, x0, #0xc84
400015dc: 94000836     	bl	0x400036b4 <uart_puts>
400015e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015e4: 91123400     	add	x0, x0, #0x48d
400015e8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400015ec: 91392821     	add	x1, x1, #0xe4a
400015f0: 94000946     	bl	0x40003b08 <uart_printf>
400015f4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015f8: 911ef800     	add	x0, x0, #0x7be
400015fc: 9400082e     	bl	0x400036b4 <uart_puts>
40001600: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001604: 9114fc00     	add	x0, x0, #0x53f
40001608: 9400082b     	bl	0x400036b4 <uart_puts>
4000160c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001610: 91131800     	add	x0, x0, #0x4c6
40001614: 94000828     	bl	0x400036b4 <uart_puts>
40001618: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000161c: 9126f400     	add	x0, x0, #0x9bd
40001620: 94000825     	bl	0x400036b4 <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: d0000028     	adrp	x8, 0x40007000 <__rodata_start>
4000162c: 911a0108     	add	x8, x8, #0x680
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001640: 912ef800     	add	x0, x0, #0xbbe
40001644: 9400081c     	bl	0x400036b4 <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001650: 9134ec00     	add	x0, x0, #0xd3b
40001654: 94000818     	bl	0x400036b4 <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 9400046a     	bl	0x40002808 <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 9400042f     	bl	0x40002728 <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001678: 9106d400     	add	x0, x0, #0x1b5
4000167c: 9400080e     	bl	0x400036b4 <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001688: 9138b000     	add	x0, x0, #0xe2c
4000168c: 9400080a     	bl	0x400036b4 <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: d0000035     	adrp	x21, 0x40007000 <__rodata_start>
40001698: 9112b2b5     	add	x21, x21, #0x4ac
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 940007ec     	bl	0x40003658 <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 940007e9     	bl	0x40003658 <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 940007e7     	bl	0x40003658 <uart_putc>
400016c0: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
400016c4: 910c8a73     	add	x19, x19, #0x322
400016c8: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400016cc: 911af294     	add	x20, x20, #0x6bc
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 940007db     	bl	0x40003658 <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 940007d8     	bl	0x40003658 <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 940007d6     	bl	0x40003658 <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 940007e6     	bl	0x400036b4 <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 940007e2     	bl	0x400036b4 <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001738: 91357800     	add	x0, x0, #0xd5e
4000173c: 940007de     	bl	0x400036b4 <uart_puts>
40001740: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001744: 913f3800     	add	x0, x0, #0xfce
40001748: 940007db     	bl	0x400036b4 <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001764: 91277800     	add	x0, x0, #0x9de
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 940007cc     	bl	0x400036b4 <uart_puts>
40001788: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
4000178c: 91394273     	add	x19, x19, #0xe50
40001790: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001794: 9101b294     	add	x20, x20, #0x6c
40001798: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
4000179c: 91187eb5     	add	x21, x21, #0x61f
400017a0: f0000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
400017a4: 91008ed6     	add	x22, x22, #0x23
400017a8: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x2000>
400017ac: 911a3af7     	add	x23, x23, #0x68e
400017b0: 90000058     	adrp	x24, 0x40009000 <__rodata_start+0x2000>
400017b4: 910aab18     	add	x24, x24, #0x2aa
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: d0000039     	adrp	x25, 0x40007000 <__rodata_start>
400017c0: 912f4f39     	add	x25, x25, #0xbd3
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000c49     	bl	0x400048f0 <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 940008cc     	bl	0x40003b08 <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 940007b5     	bl	0x400036b4 <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 940007e6     	bl	0x40003784 <uart_getc>
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
40001840: 94000786     	bl	0x40003658 <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 94000797     	bl	0x400036b4 <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 94000794     	bl	0x400036b4 <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 940003e6     	bl	0x40002808 <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 940002e6     	bl	0x40002414 <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 940003f0     	bl	0x40002848 <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 940003ec     	bl	0x40002848 <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 940003e8     	bl	0x40002848 <kstrcmp>
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
400018d0: d100c3ff     	sub	sp, sp, #0x30
400018d4: a9024ff4     	stp	x20, x19, [sp, #0x20]
400018d8: 529c6c13     	mov	w19, #0xe360            // =58208
400018dc: a9017bfd     	stp	x29, x30, [sp, #0x10]
400018e0: 910043fd     	add	x29, sp, #0x10
400018e4: 72a002d3     	movk	w19, #0x16, lsl #16
400018e8: 94000750     	bl	0x40003628 <uart_init>
400018ec: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400018f0: 91076800     	add	x0, x0, #0x1da
400018f4: 94000770     	bl	0x400036b4 <uart_puts>
400018f8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018fc: 91153800     	add	x0, x0, #0x54e
40001900: 9400076d     	bl	0x400036b4 <uart_puts>
40001904: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001908: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000190c: 6b13011f     	cmp	w8, w19
40001910: 540000aa     	b.ge	0x40001924 <kmain+0x54>
40001914: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001918: 11000508     	add	w8, w8, #0x1
4000191c: b81fc3a8     	stur	w8, [x29, #-0x4]
40001920: 17fffffa     	b	0x40001908 <kmain+0x38>
40001924: 528aa213     	mov	w19, #0x5510            // =21776
40001928: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000192c: 910c9000     	add	x0, x0, #0x324
40001930: 72a00453     	movk	w19, #0x22, lsl #16
40001934: 94000760     	bl	0x400036b4 <uart_puts>
40001938: b81fc3bf     	stur	wzr, [x29, #-0x4]
4000193c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001940: 6b13011f     	cmp	w8, w19
40001944: 540000aa     	b.ge	0x40001958 <kmain+0x88>
40001948: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000194c: 11000508     	add	w8, w8, #0x1
40001950: b81fc3a8     	stur	w8, [x29, #-0x4]
40001954: 17fffffa     	b	0x4000193c <kmain+0x6c>
40001958: 5298d814     	mov	w20, #0xc6c0            // =50880
4000195c: 72a005b4     	movk	w20, #0x2d, lsl #16
40001960: 94000a76     	bl	0x40004338 <vfs_init>
40001964: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001968: 911fb000     	add	x0, x0, #0x7ec
4000196c: 94000752     	bl	0x400036b4 <uart_puts>
40001970: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001974: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001978: 6b14011f     	cmp	w8, w20
4000197c: 540000aa     	b.ge	0x40001990 <kmain+0xc0>
40001980: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001984: 11000508     	add	w8, w8, #0x1
40001988: b81fc3a8     	stur	w8, [x29, #-0x4]
4000198c: 17fffffa     	b	0x40001974 <kmain+0xa4>
40001990: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001994: 9107d800     	add	x0, x0, #0x1f6
40001998: d503201f     	nop
4000199c: 1001f328     	adr	x8, 0x40005800 <exception_vector_table>
400019a0: d518c008     	msr	VBAR_EL1, x8
400019a4: 94000744     	bl	0x400036b4 <uart_puts>
400019a8: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019ac: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019b0: 6b13011f     	cmp	w8, w19
400019b4: 540000aa     	b.ge	0x400019c8 <kmain+0xf8>
400019b8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019bc: 11000508     	add	w8, w8, #0x1
400019c0: b81fc3a8     	stur	w8, [x29, #-0x4]
400019c4: 17fffffa     	b	0x400019ac <kmain+0xdc>
400019c8: 97fffa13     	bl	0x40000214 <gic_init>
400019cc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400019d0: 9115a400     	add	x0, x0, #0x569
400019d4: 94000738     	bl	0x400036b4 <uart_puts>
400019d8: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019dc: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019e0: 6b13011f     	cmp	w8, w19
400019e4: 540000aa     	b.ge	0x400019f8 <kmain+0x128>
400019e8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019ec: 11000508     	add	w8, w8, #0x1
400019f0: b81fc3a8     	stur	w8, [x29, #-0x4]
400019f4: 17fffffa     	b	0x400019dc <kmain+0x10c>
400019f8: 94000437     	bl	0x40002ad4 <timer_init>
400019fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001a00: 9122a000     	add	x0, x0, #0x8a8
40001a04: 9400072c     	bl	0x400036b4 <uart_puts>
40001a08: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001a0c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a10: 6b13011f     	cmp	w8, w19
40001a14: 540000aa     	b.ge	0x40001a28 <kmain+0x158>
40001a18: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a1c: 11000508     	add	w8, w8, #0x1
40001a20: b81fc3a8     	stur	w8, [x29, #-0x4]
40001a24: 17fffffa     	b	0x40001a0c <kmain+0x13c>
40001a28: 529e1014     	mov	w20, #0xf080            // =61568
40001a2c: 72a05f54     	movk	w20, #0x2fa, lsl #16
40001a30: 94000df4     	bl	0x40005200 <pmm_init>
40001a34: 94000e88     	bl	0x40005454 <sched_init>
40001a38: d503201f     	nop
40001a3c: 10ff7420     	adr	x0, 0x400008c0 <system_idle_daemon>
40001a40: 94000eac     	bl	0x400054f0 <sched_create_task>
40001a44: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a48: 911a1000     	add	x0, x0, #0x684
40001a4c: 9400071a     	bl	0x400036b4 <uart_puts>
40001a50: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001a54: 912f6273     	add	x19, x19, #0xbd8
40001a58: d50342ff     	msr	DAIFClr, #0x2
40001a5c: aa1303e0     	mov	x0, x19
40001a60: 94000715     	bl	0x400036b4 <uart_puts>
40001a64: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001a68: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a6c: 6b14011f     	cmp	w8, w20
40001a70: 54ffff6a     	b.ge	0x40001a5c <kmain+0x18c>
40001a74: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a78: 11000508     	add	w8, w8, #0x1
40001a7c: b81fc3a8     	stur	w8, [x29, #-0x4]
40001a80: 17fffffa     	b	0x40001a68 <kmain+0x198>

0000000040001a84 <kproj_execute>:
40001a84: d10683ff     	sub	sp, sp, #0x1a0
40001a88: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001a8c: 910603fd     	add	x29, sp, #0x180
40001a90: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001a94: b40001c0     	cbz	x0, 0x40001acc <kproj_execute+0x48>
40001a98: aa0003f3     	mov	x19, x0
40001a9c: 9400035b     	bl	0x40002808 <kstrlen>
40001aa0: b4000160     	cbz	x0, 0x40001acc <kproj_execute+0x48>
40001aa4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001aa8: 91274400     	add	x0, x0, #0x9d1
40001aac: aa1303e1     	mov	x1, x19
40001ab0: 94000816     	bl	0x40003b08 <uart_printf>
40001ab4: aa1303e0     	mov	x0, x19
40001ab8: 94000c67     	bl	0x40004c54 <vfs_mkdir>
40001abc: 34000140     	cbz	w0, 0x40001ae4 <kproj_execute+0x60>
40001ac0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001ac4: 911a4c00     	add	x0, x0, #0x693
40001ac8: 14000003     	b	0x40001ad4 <kproj_execute+0x50>
40001acc: d503201f     	nop
40001ad0: 7003bfe0     	adr	x0, 0x400092cf <__rodata_start+0x22cf>
40001ad4: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001ad8: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001adc: 910683ff     	add	sp, sp, #0x1a0
40001ae0: 140006f5     	b	0x400036b4 <uart_puts>
40001ae4: aa1303e0     	mov	x0, x19
40001ae8: 94000c36     	bl	0x40004bc0 <vfs_chdir>
40001aec: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001af0: 91022400     	add	x0, x0, #0x89
40001af4: 94000c58     	bl	0x40004c54 <vfs_mkdir>
40001af8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001afc: 911a0800     	add	x0, x0, #0x682
40001b00: 94000c55     	bl	0x40004c54 <vfs_mkdir>
40001b04: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b08: 91090c21     	add	x1, x1, #0x243
40001b0c: 910203e0     	add	x0, sp, #0x80
40001b10: 9400036d     	bl	0x400028c4 <kstrcpy>
40001b14: 910203e0     	add	x0, sp, #0x80
40001b18: aa1303e1     	mov	x1, x19
40001b1c: 94000342     	bl	0x40002824 <kstrcat>
40001b20: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b24: 913af021     	add	x1, x1, #0xebc
40001b28: 910203e0     	add	x0, sp, #0x80
40001b2c: 9400033e     	bl	0x40002824 <kstrcat>
40001b30: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b34: 9124e400     	add	x0, x0, #0x939
40001b38: 910203e1     	add	x1, sp, #0x80
40001b3c: 94000c9c     	bl	0x40004dac <vfs_touch>
40001b40: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b44: 913fd000     	add	x0, x0, #0xff4
40001b48: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b4c: 912f6821     	add	x1, x1, #0xbda
40001b50: 94000c97     	bl	0x40004dac <vfs_touch>
40001b54: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001b58: 91063421     	add	x1, x1, #0x18d
40001b5c: 910003e0     	mov	x0, sp
40001b60: 94000359     	bl	0x400028c4 <kstrcpy>
40001b64: 910003e0     	mov	x0, sp
40001b68: aa1303e1     	mov	x1, x19
40001b6c: 9400032e     	bl	0x40002824 <kstrcat>
40001b70: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b74: 912a5021     	add	x1, x1, #0xa94
40001b78: 910003e0     	mov	x0, sp
40001b7c: 9400032a     	bl	0x40002824 <kstrcat>
40001b80: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b84: 913ba000     	add	x0, x0, #0xee8
40001b88: 910003e1     	mov	x1, sp
40001b8c: 94000c88     	bl	0x40004dac <vfs_touch>
40001b90: 94000c86     	bl	0x40004da8 <vfs_sync>
40001b94: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b98: 9112f400     	add	x0, x0, #0x4bd
40001b9c: 940006c6     	bl	0x400036b4 <uart_puts>
40001ba0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ba4: 9113b000     	add	x0, x0, #0x4ec
40001ba8: aa1303e1     	mov	x1, x19
40001bac: 940007d7     	bl	0x40003b08 <uart_printf>
40001bb0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001bb4: 91023400     	add	x0, x0, #0x8d
40001bb8: 94000c02     	bl	0x40004bc0 <vfs_chdir>
40001bbc: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001bc0: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001bc4: 910683ff     	add	sp, sp, #0x1a0
40001bc8: d65f03c0     	ret

0000000040001bcc <process_init>:
40001bcc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001bd0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001bd4: b0000054     	adrp	x20, 0x4000a000 <next_pid>
40001bd8: d503201f     	nop
40001bdc: 100633d3     	adr	x19, 0x4000e254 <proc_table>
40001be0: b9400289     	ldr	w9, [x20]
40001be4: 52800068     	mov	w8, #0x3                // =3
40001be8: b9002668     	str	w8, [x19, #0x24]
40001bec: d503201f     	nop
40001bf0: 30036821     	adr	x1, 0x400088f5 <__rodata_start+0x18f5>
40001bf4: b9005668     	str	w8, [x19, #0x54]
40001bf8: 91001260     	add	x0, x19, #0x4
40001bfc: 910003fd     	mov	x29, sp
40001c00: b9008668     	str	w8, [x19, #0x84]
40001c04: b900b668     	str	w8, [x19, #0xb4]
40001c08: b900e668     	str	w8, [x19, #0xe4]
40001c0c: b9011668     	str	w8, [x19, #0x114]
40001c10: b9014668     	str	w8, [x19, #0x144]
40001c14: b9017668     	str	w8, [x19, #0x174]
40001c18: b901a668     	str	w8, [x19, #0x1a4]
40001c1c: b901d668     	str	w8, [x19, #0x1d4]
40001c20: b9020668     	str	w8, [x19, #0x204]
40001c24: b9023668     	str	w8, [x19, #0x234]
40001c28: b9026668     	str	w8, [x19, #0x264]
40001c2c: b9029668     	str	w8, [x19, #0x294]
40001c30: b902c668     	str	w8, [x19, #0x2c4]
40001c34: b902f668     	str	w8, [x19, #0x2f4]
40001c38: 11000528     	add	w8, w9, #0x1
40001c3c: f9000bf5     	str	x21, [sp, #0x10]
40001c40: b900327f     	str	wzr, [x19, #0x30]
40001c44: b900627f     	str	wzr, [x19, #0x60]
40001c48: b900927f     	str	wzr, [x19, #0x90]
40001c4c: b900c27f     	str	wzr, [x19, #0xc0]
40001c50: b900f27f     	str	wzr, [x19, #0xf0]
40001c54: b901227f     	str	wzr, [x19, #0x120]
40001c58: b901527f     	str	wzr, [x19, #0x150]
40001c5c: b901827f     	str	wzr, [x19, #0x180]
40001c60: b901b27f     	str	wzr, [x19, #0x1b0]
40001c64: b901e27f     	str	wzr, [x19, #0x1e0]
40001c68: b902127f     	str	wzr, [x19, #0x210]
40001c6c: b902427f     	str	wzr, [x19, #0x240]
40001c70: b902727f     	str	wzr, [x19, #0x270]
40001c74: b902a27f     	str	wzr, [x19, #0x2a0]
40001c78: b902d27f     	str	wzr, [x19, #0x2d0]
40001c7c: b9000288     	str	w8, [x20]
40001c80: b9000269     	str	w9, [x19]
40001c84: 94000310     	bl	0x400028c4 <kstrcpy>
40001c88: b9400288     	ldr	w8, [x20]
40001c8c: 52a00209     	mov	w9, #0x100000           // =1048576
40001c90: 5280384a     	mov	w10, #0x1c2             // =450
40001c94: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001c98: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001c9c: 911b3021     	add	x1, x1, #0x6cc
40001ca0: 11000509     	add	w9, w8, #0x1
40001ca4: 9100d260     	add	x0, x19, #0x34
40001ca8: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001cac: b9000289     	str	w9, [x20]
40001cb0: 94000305     	bl	0x400028c4 <kstrcpy>
40001cb4: b9400288     	ldr	w8, [x20]
40001cb8: 529d0009     	mov	w9, #0xe800             // =59392
40001cbc: 52800035     	mov	w21, #0x1               // =1
40001cc0: 72a00069     	movk	w9, #0x3, lsl #16
40001cc4: 5280018a     	mov	w10, #0xc               // =12
40001cc8: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001ccc: 912ad821     	add	x1, x1, #0xab6
40001cd0: 290aa675     	stp	w21, w9, [x19, #0x54]
40001cd4: 11000509     	add	w9, w8, #0x1
40001cd8: 91019260     	add	x0, x19, #0x64
40001cdc: b9000289     	str	w9, [x20]
40001ce0: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001ce4: 940002f8     	bl	0x400028c4 <kstrcpy>
40001ce8: b9400288     	ldr	w8, [x20]
40001cec: 52a00809     	mov	w9, #0x400000           // =4194304
40001cf0: 5280960a     	mov	w10, #0x4b0             // =1200
40001cf4: 2910a675     	stp	w21, w9, [x19, #0x84]
40001cf8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001cfc: 910d3421     	add	x1, x1, #0x34d
40001d00: 11000509     	add	w9, w8, #0x1
40001d04: 91025260     	add	x0, x19, #0x94
40001d08: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001d0c: b9000289     	str	w9, [x20]
40001d10: 940002ed     	bl	0x400028c4 <kstrcpy>
40001d14: 529a0008     	mov	w8, #0xd000             // =53248
40001d18: 52800aa9     	mov	w9, #0x55               // =85
40001d1c: f9400bf5     	ldr	x21, [sp, #0x10]
40001d20: 72a000e8     	movk	w8, #0x7, lsl #16
40001d24: b900be69     	str	w9, [x19, #0xbc]
40001d28: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001d2c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001d30: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001d34: d65f03c0     	ret

0000000040001d38 <process_kill>:
40001d38: 7100041f     	cmp	w0, #0x1
40001d3c: 5400118b     	b.lt	0x40001f6c <process_kill+0x234>
40001d40: d503201f     	nop
40001d44: 10062889     	adr	x9, 0x4000e254 <proc_table>
40001d48: b9400128     	ldr	w8, [x9]
40001d4c: 6b00011f     	cmp	w8, w0
40001d50: 54000081     	b.ne	0x40001d60 <process_kill+0x28>
40001d54: b9402528     	ldr	w8, [x9, #0x24]
40001d58: 71000d1f     	cmp	w8, #0x3
40001d5c: 54000f41     	b.ne	0x40001f44 <process_kill+0x20c>
40001d60: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d64: 910a1129     	add	x9, x9, #0x284
40001d68: b9400128     	ldr	w8, [x9]
40001d6c: 6b00011f     	cmp	w8, w0
40001d70: 54000081     	b.ne	0x40001d80 <process_kill+0x48>
40001d74: b9402528     	ldr	w8, [x9, #0x24]
40001d78: 71000d1f     	cmp	w8, #0x3
40001d7c: 54000e41     	b.ne	0x40001f44 <process_kill+0x20c>
40001d80: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d84: 910ad129     	add	x9, x9, #0x2b4
40001d88: b9400128     	ldr	w8, [x9]
40001d8c: 6b00011f     	cmp	w8, w0
40001d90: 54000081     	b.ne	0x40001da0 <process_kill+0x68>
40001d94: b9402528     	ldr	w8, [x9, #0x24]
40001d98: 71000d1f     	cmp	w8, #0x3
40001d9c: 54000d41     	b.ne	0x40001f44 <process_kill+0x20c>
40001da0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001da4: 910b9129     	add	x9, x9, #0x2e4
40001da8: b9400128     	ldr	w8, [x9]
40001dac: 6b00011f     	cmp	w8, w0
40001db0: 54000081     	b.ne	0x40001dc0 <process_kill+0x88>
40001db4: b9402528     	ldr	w8, [x9, #0x24]
40001db8: 71000d1f     	cmp	w8, #0x3
40001dbc: 54000c41     	b.ne	0x40001f44 <process_kill+0x20c>
40001dc0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001dc4: 910c5129     	add	x9, x9, #0x314
40001dc8: b9400128     	ldr	w8, [x9]
40001dcc: 6b00011f     	cmp	w8, w0
40001dd0: 54000081     	b.ne	0x40001de0 <process_kill+0xa8>
40001dd4: b9402528     	ldr	w8, [x9, #0x24]
40001dd8: 71000d1f     	cmp	w8, #0x3
40001ddc: 54000b41     	b.ne	0x40001f44 <process_kill+0x20c>
40001de0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001de4: 910d1129     	add	x9, x9, #0x344
40001de8: b9400128     	ldr	w8, [x9]
40001dec: 6b00011f     	cmp	w8, w0
40001df0: 54000081     	b.ne	0x40001e00 <process_kill+0xc8>
40001df4: b9402528     	ldr	w8, [x9, #0x24]
40001df8: 71000d1f     	cmp	w8, #0x3
40001dfc: 54000a41     	b.ne	0x40001f44 <process_kill+0x20c>
40001e00: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e04: 910dd129     	add	x9, x9, #0x374
40001e08: b9400128     	ldr	w8, [x9]
40001e0c: 6b00011f     	cmp	w8, w0
40001e10: 54000081     	b.ne	0x40001e20 <process_kill+0xe8>
40001e14: b9402528     	ldr	w8, [x9, #0x24]
40001e18: 71000d1f     	cmp	w8, #0x3
40001e1c: 54000941     	b.ne	0x40001f44 <process_kill+0x20c>
40001e20: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e24: 910e9129     	add	x9, x9, #0x3a4
40001e28: b9400128     	ldr	w8, [x9]
40001e2c: 6b00011f     	cmp	w8, w0
40001e30: 54000081     	b.ne	0x40001e40 <process_kill+0x108>
40001e34: b9402528     	ldr	w8, [x9, #0x24]
40001e38: 71000d1f     	cmp	w8, #0x3
40001e3c: 54000841     	b.ne	0x40001f44 <process_kill+0x20c>
40001e40: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e44: 910f5129     	add	x9, x9, #0x3d4
40001e48: b9400128     	ldr	w8, [x9]
40001e4c: 6b00011f     	cmp	w8, w0
40001e50: 54000081     	b.ne	0x40001e60 <process_kill+0x128>
40001e54: b9402528     	ldr	w8, [x9, #0x24]
40001e58: 71000d1f     	cmp	w8, #0x3
40001e5c: 54000741     	b.ne	0x40001f44 <process_kill+0x20c>
40001e60: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e64: 91101129     	add	x9, x9, #0x404
40001e68: b9400128     	ldr	w8, [x9]
40001e6c: 6b00011f     	cmp	w8, w0
40001e70: 54000081     	b.ne	0x40001e80 <process_kill+0x148>
40001e74: b9402528     	ldr	w8, [x9, #0x24]
40001e78: 71000d1f     	cmp	w8, #0x3
40001e7c: 54000641     	b.ne	0x40001f44 <process_kill+0x20c>
40001e80: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e84: 9110d129     	add	x9, x9, #0x434
40001e88: b9400128     	ldr	w8, [x9]
40001e8c: 6b00011f     	cmp	w8, w0
40001e90: 54000081     	b.ne	0x40001ea0 <process_kill+0x168>
40001e94: b9402528     	ldr	w8, [x9, #0x24]
40001e98: 71000d1f     	cmp	w8, #0x3
40001e9c: 54000541     	b.ne	0x40001f44 <process_kill+0x20c>
40001ea0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ea4: 91119129     	add	x9, x9, #0x464
40001ea8: b9400128     	ldr	w8, [x9]
40001eac: 6b00011f     	cmp	w8, w0
40001eb0: 54000081     	b.ne	0x40001ec0 <process_kill+0x188>
40001eb4: b9402528     	ldr	w8, [x9, #0x24]
40001eb8: 71000d1f     	cmp	w8, #0x3
40001ebc: 54000441     	b.ne	0x40001f44 <process_kill+0x20c>
40001ec0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ec4: 91125129     	add	x9, x9, #0x494
40001ec8: b9400128     	ldr	w8, [x9]
40001ecc: 6b00011f     	cmp	w8, w0
40001ed0: 54000081     	b.ne	0x40001ee0 <process_kill+0x1a8>
40001ed4: b9402528     	ldr	w8, [x9, #0x24]
40001ed8: 71000d1f     	cmp	w8, #0x3
40001edc: 54000341     	b.ne	0x40001f44 <process_kill+0x20c>
40001ee0: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ee4: 91131129     	add	x9, x9, #0x4c4
40001ee8: b9400128     	ldr	w8, [x9]
40001eec: 6b00011f     	cmp	w8, w0
40001ef0: 54000081     	b.ne	0x40001f00 <process_kill+0x1c8>
40001ef4: b9402528     	ldr	w8, [x9, #0x24]
40001ef8: 71000d1f     	cmp	w8, #0x3
40001efc: 54000241     	b.ne	0x40001f44 <process_kill+0x20c>
40001f00: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001f04: 9113d129     	add	x9, x9, #0x4f4
40001f08: b9400128     	ldr	w8, [x9]
40001f0c: 6b00011f     	cmp	w8, w0
40001f10: 54000081     	b.ne	0x40001f20 <process_kill+0x1e8>
40001f14: b9402528     	ldr	w8, [x9, #0x24]
40001f18: 71000d1f     	cmp	w8, #0x3
40001f1c: 54000141     	b.ne	0x40001f44 <process_kill+0x20c>
40001f20: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001f24: 91149129     	add	x9, x9, #0x524
40001f28: b9400128     	ldr	w8, [x9]
40001f2c: 6b00011f     	cmp	w8, w0
40001f30: 12800008     	mov	w8, #-0x1               // =-1
40001f34: 54000281     	b.ne	0x40001f84 <process_kill+0x24c>
40001f38: b940252a     	ldr	w10, [x9, #0x24]
40001f3c: 71000d5f     	cmp	w10, #0x3
40001f40: 54000220     	b.eq	0x40001f84 <process_kill+0x24c>
40001f44: 7100041f     	cmp	w0, #0x1
40001f48: 54000161     	b.ne	0x40001f74 <process_kill+0x23c>
40001f4c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f50: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f54: 91280800     	add	x0, x0, #0xa02
40001f58: 910003fd     	mov	x29, sp
40001f5c: 940005d6     	bl	0x400036b4 <uart_puts>
40001f60: 12800020     	mov	w0, #-0x2               // =-2
40001f64: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001f68: d65f03c0     	ret
40001f6c: 12800000     	mov	w0, #-0x1               // =-1
40001f70: d65f03c0     	ret
40001f74: 5280004a     	mov	w10, #0x2               // =2
40001f78: 2a1f03e0     	mov	w0, wzr
40001f7c: b900252a     	str	w10, [x9, #0x24]
40001f80: d65f03c0     	ret
40001f84: 2a0803e0     	mov	w0, w8
40001f88: d65f03c0     	ret

0000000040001f8c <launch_ktop>:
40001f8c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001f90: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f94: 91203400     	add	x0, x0, #0x80d
40001f98: f9000bf7     	str	x23, [sp, #0x10]
40001f9c: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fa0: 910003fd     	mov	x29, sp
40001fa4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fa8: 940005c3     	bl	0x400036b4 <uart_puts>
40001fac: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001fb0: 9120e400     	add	x0, x0, #0x839
40001fb4: 940005c0     	bl	0x400036b4 <uart_puts>
40001fb8: 2a1f03e8     	mov	w8, wzr
40001fbc: 2a1f03e1     	mov	w1, wzr
40001fc0: 52800209     	mov	w9, #0x10               // =16
40001fc4: b000006a     	adrp	x10, 0x4000e000 <__bss_start+0x3000>
40001fc8: 9109f14a     	add	x10, x10, #0x27c
40001fcc: 14000004     	b	0x40001fdc <launch_ktop+0x50>
40001fd0: f1000529     	subs	x9, x9, #0x1
40001fd4: 9100c14a     	add	x10, x10, #0x30
40001fd8: 54000120     	b.eq	0x40001ffc <launch_ktop+0x70>
40001fdc: b85fc14b     	ldur	w11, [x10, #-0x4]
40001fe0: 121f796b     	and	w11, w11, #0xfffffffe
40001fe4: 7100097f     	cmp	w11, #0x2
40001fe8: 54ffff40     	b.eq	0x40001fd0 <launch_ktop+0x44>
40001fec: b940014b     	ldr	w11, [x10]
40001ff0: 11000421     	add	w1, w1, #0x1
40001ff4: 0b080168     	add	w8, w11, w8
40001ff8: 17fffff6     	b	0x40001fd0 <launch_ktop+0x44>
40001ffc: 530a7d02     	lsr	w2, w8, #10
40002000: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002004: 912b0000     	add	x0, x0, #0xac0
40002008: 940006c0     	bl	0x40003b08 <uart_printf>
4000200c: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002010: 912fe800     	add	x0, x0, #0xbfa
40002014: 940005a8     	bl	0x400036b4 <uart_puts>
40002018: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000201c: 9134d000     	add	x0, x0, #0xd34
40002020: 940005a5     	bl	0x400036b4 <uart_puts>
40002024: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40002028: 910a0294     	add	x20, x20, #0x280
4000202c: d0000035     	adrp	x21, 0x40008000 <__rodata_start+0x1000>
40002030: 913abab5     	add	x21, x21, #0xeae
40002034: d503201f     	nop
40002038: 1003b616     	adr	x22, 0x400096f8 <__rodata_start+0x26f8>
4000203c: 52800217     	mov	w23, #0x10              // =16
40002040: d0000033     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
40002044: 9113a273     	add	x19, x19, #0x4e8
40002048: 1400000a     	b	0x40002070 <launch_ktop+0xe4>
4000204c: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002050: b85d4281     	ldur	w1, [x20, #-0x2c]
40002054: d100a285     	sub	x5, x20, #0x28
40002058: aa1303e0     	mov	x0, x19
4000205c: 530a7d03     	lsr	w3, w8, #10
40002060: 940006aa     	bl	0x40003b08 <uart_printf>
40002064: f10006f7     	subs	x23, x23, #0x1
40002068: 9100c294     	add	x20, x20, #0x30
4000206c: 54000120     	b.eq	0x40002090 <launch_ktop+0x104>
40002070: b85f8288     	ldur	w8, [x20, #-0x8]
40002074: 71000d1f     	cmp	w8, #0x3
40002078: 54ffff60     	b.eq	0x40002064 <launch_ktop+0xd8>
4000207c: 7100091f     	cmp	w8, #0x2
40002080: aa1503e2     	mov	x2, x21
40002084: 54fffe48     	b.hi	0x4000204c <launch_ktop+0xc0>
40002088: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
4000208c: 17fffff0     	b	0x4000204c <launch_ktop+0xc0>
40002090: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002094: 91064000     	add	x0, x0, #0x190
40002098: 94000587     	bl	0x400036b4 <uart_puts>
4000209c: 52808114     	mov	w20, #0x408             // =1032
400020a0: 52800033     	mov	w19, #0x1               // =1
400020a4: 72a02014     	movk	w20, #0x100, lsl #16
400020a8: 14000003     	b	0x400020b4 <launch_ktop+0x128>
400020ac: 7101c51f     	cmp	w8, #0x71
400020b0: 54000100     	b.eq	0x400020d0 <launch_ktop+0x144>
400020b4: 940005b4     	bl	0x40003784 <uart_getc>
400020b8: 12001c08     	and	w8, w0, #0xff
400020bc: 7100611f     	cmp	w8, #0x18
400020c0: 54ffff68     	b.hi	0x400020ac <launch_ktop+0x120>
400020c4: 1ac82269     	lsl	w9, w19, w8
400020c8: 6a14013f     	tst	w9, w20
400020cc: 54ffff00     	b.eq	0x400020ac <launch_ktop+0x120>
400020d0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400020d4: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
400020d8: 912bcc00     	add	x0, x0, #0xaf3
400020dc: a94257f6     	ldp	x22, x21, [sp, #0x20]
400020e0: f9400bf7     	ldr	x23, [sp, #0x10]
400020e4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400020e8: 14000573     	b	0x400036b4 <uart_puts>

00000000400020ec <script_init>:
400020ec: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400020f0: 90000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400020f4: d503201f     	nop
400020f8: 1002da00     	adr	x0, 0x40007c38 <__rodata_start+0xc38>
400020fc: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40002100: 91288421     	add	x1, x1, #0xa21
40002104: 910003fd     	mov	x29, sp
40002108: b905551f     	str	wzr, [x8, #0x554]
4000210c: 94000007     	bl	0x40002128 <script_set_var>
40002110: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002114: 9132ec00     	add	x0, x0, #0xcbb
40002118: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000211c: 911a2021     	add	x1, x1, #0x688
40002120: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002124: 14000001     	b	0x40002128 <script_set_var>

0000000040002128 <script_set_var>:
40002128: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000212c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002130: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40002134: 910003fd     	mov	x29, sp
40002138: b94556e8     	ldr	w8, [x23, #0x554]
4000213c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002140: aa0103f3     	mov	x19, x1
40002144: aa0003f4     	mov	x20, x0
40002148: a90257f6     	stp	x22, x21, [sp, #0x20]
4000214c: 7100051f     	cmp	w8, #0x1
40002150: 5400024b     	b.lt	0x40002198 <script_set_var+0x70>
40002154: aa1f03f8     	mov	x24, xzr
40002158: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
4000215c: 912562b5     	add	x21, x21, #0x958
40002160: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
40002164: 911562d6     	add	x22, x22, #0x558
40002168: aa1603e0     	mov	x0, x22
4000216c: aa1403e1     	mov	x1, x20
40002170: 940001b6     	bl	0x40002848 <kstrcmp>
40002174: 340003e0     	cbz	w0, 0x400021f0 <script_set_var+0xc8>
40002178: b98556e8     	ldrsw	x8, [x23, #0x554]
4000217c: 91000718     	add	x24, x24, #0x1
40002180: 910202b5     	add	x21, x21, #0x80
40002184: 910082d6     	add	x22, x22, #0x20
40002188: eb08031f     	cmp	x24, x8
4000218c: 54fffeeb     	b.lt	0x40002168 <script_set_var+0x40>
40002190: 71007d1f     	cmp	w8, #0x1f
40002194: 5400038c     	b.gt	0x40002204 <script_set_var+0xdc>
40002198: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
4000219c: 911562b5     	add	x21, x21, #0x558
400021a0: aa1403e1     	mov	x1, x20
400021a4: 93407d08     	sxtw	x8, w8
400021a8: 528003e2     	mov	w2, #0x1f               // =31
400021ac: 8b0816a0     	add	x0, x21, x8, lsl #5
400021b0: 940001cc     	bl	0x400028e0 <kstrncpy>
400021b4: b98556e8     	ldrsw	x8, [x23, #0x554]
400021b8: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
400021bc: 91256294     	add	x20, x20, #0x958
400021c0: aa1303e1     	mov	x1, x19
400021c4: 52800fe2     	mov	w2, #0x7f               // =127
400021c8: 8b0816a9     	add	x9, x21, x8, lsl #5
400021cc: 8b081e80     	add	x0, x20, x8, lsl #7
400021d0: 39007d3f     	strb	wzr, [x9, #0x1f]
400021d4: 940001c3     	bl	0x400028e0 <kstrncpy>
400021d8: b98556e8     	ldrsw	x8, [x23, #0x554]
400021dc: 8b081e89     	add	x9, x20, x8, lsl #7
400021e0: 11000508     	add	w8, w8, #0x1
400021e4: b90556e8     	str	w8, [x23, #0x554]
400021e8: 3901fd3f     	strb	wzr, [x9, #0x7f]
400021ec: 14000006     	b	0x40002204 <script_set_var+0xdc>
400021f0: aa1503e0     	mov	x0, x21
400021f4: aa1303e1     	mov	x1, x19
400021f8: 52800fe2     	mov	w2, #0x7f               // =127
400021fc: 940001b9     	bl	0x400028e0 <kstrncpy>
40002200: 3901febf     	strb	wzr, [x21, #0x7f]
40002204: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002208: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000220c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002210: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002214: d65f03c0     	ret

0000000040002218 <script_get_var>:
40002218: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000221c: a90257f6     	stp	x22, x21, [sp, #0x20]
40002220: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
40002224: 910003fd     	mov	x29, sp
40002228: b94556c8     	ldr	w8, [x22, #0x554]
4000222c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002230: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002234: 7100051f     	cmp	w8, #0x1
40002238: 540002ab     	b.lt	0x4000228c <script_get_var+0x74>
4000223c: aa0003f4     	mov	x20, x0
40002240: aa1f03f7     	mov	x23, xzr
40002244: 90000073     	adrp	x19, 0x4000e000 <__bss_start+0x3000>
40002248: 91256273     	add	x19, x19, #0x958
4000224c: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002250: 911562b5     	add	x21, x21, #0x558
40002254: b0000038     	adrp	x24, 0x40007000 <__rodata_start>
40002258: 91250718     	add	x24, x24, #0x941
4000225c: aa1503e0     	mov	x0, x21
40002260: aa1403e1     	mov	x1, x20
40002264: 94000179     	bl	0x40002848 <kstrcmp>
40002268: 34000160     	cbz	w0, 0x40002294 <script_get_var+0x7c>
4000226c: b98556c8     	ldrsw	x8, [x22, #0x554]
40002270: 910006f7     	add	x23, x23, #0x1
40002274: 91020273     	add	x19, x19, #0x80
40002278: 910082b5     	add	x21, x21, #0x20
4000227c: eb0802ff     	cmp	x23, x8
40002280: 54fffeeb     	b.lt	0x4000225c <script_get_var+0x44>
40002284: aa1803f3     	mov	x19, x24
40002288: 14000003     	b	0x40002294 <script_get_var+0x7c>
4000228c: b0000033     	adrp	x19, 0x40007000 <__rodata_start>
40002290: 91250673     	add	x19, x19, #0x941
40002294: aa1303e0     	mov	x0, x19
40002298: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000229c: a94257f6     	ldp	x22, x21, [sp, #0x20]
400022a0: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400022a4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400022a8: d65f03c0     	ret

00000000400022ac <script_expand_vars>:
400022ac: d10203ff     	sub	sp, sp, #0x80
400022b0: a9036ffc     	stp	x28, x27, [sp, #0x30]
400022b4: 2a1f03fc     	mov	w28, wzr
400022b8: a90467fa     	stp	x26, x25, [sp, #0x40]
400022bc: b0000039     	adrp	x25, 0x40007000 <__rodata_start>
400022c0: 91250739     	add	x25, x25, #0x941
400022c4: a9055ff8     	stp	x24, x23, [sp, #0x50]
400022c8: 910003f8     	mov	x24, sp
400022cc: 9000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400022d0: a90657f6     	stp	x22, x21, [sp, #0x60]
400022d4: 2a1f03f6     	mov	w22, wzr
400022d8: a9074ff4     	stp	x20, x19, [sp, #0x70]
400022dc: aa0103f3     	mov	x19, x1
400022e0: aa0003f4     	mov	x20, x0
400022e4: a9027bfd     	stp	x29, x30, [sp, #0x20]
400022e8: 910083fd     	add	x29, sp, #0x20
400022ec: 14000001     	b	0x400022f0 <script_expand_vars+0x44>
400022f0: 93407f89     	sxtw	x9, w28
400022f4: 38696a88     	ldrb	w8, [x20, x9]
400022f8: 7100911f     	cmp	w8, #0x24
400022fc: 540000e0     	b.eq	0x40002318 <script_expand_vars+0x6c>
40002300: 34000788     	cbz	w8, 0x400023f0 <script_expand_vars+0x144>
40002304: 110006ca     	add	w10, w22, #0x1
40002308: 3836ca68     	strb	w8, [x19, w22, sxtw]
4000230c: 1100053c     	add	w28, w9, #0x1
40002310: 2a0a03f6     	mov	w22, w10
40002314: 17fffff7     	b	0x400022f0 <script_expand_vars+0x44>
40002318: aa1f03e8     	mov	x8, xzr
4000231c: 14000005     	b	0x40002330 <script_expand_vars+0x84>
40002320: 9100050a     	add	x10, x8, #0x1
40002324: 38286b09     	strb	w9, [x24, x8]
40002328: d1000789     	sub	x9, x28, #0x1
4000232c: aa0a03e8     	mov	x8, x10
40002330: 9100053c     	add	x28, x9, #0x1
40002334: 14000004     	b	0x40002344 <script_expand_vars+0x98>
40002338: f100791f     	cmp	x8, #0x1e
4000233c: 9100079c     	add	x28, x28, #0x1
40002340: 54ffff09     	b.ls	0x40002320 <script_expand_vars+0x74>
40002344: 387c6a89     	ldrb	w9, [x20, x28]
40002348: 121a792a     	and	w10, w9, #0xffffffdf
4000234c: 5101054a     	sub	w10, w10, #0x41
40002350: 7100695f     	cmp	w10, #0x1a
40002354: 54ffff23     	b.lo	0x40002338 <script_expand_vars+0x8c>
40002358: 71017d3f     	cmp	w9, #0x5f
4000235c: 54fffee0     	b.eq	0x40002338 <script_expand_vars+0x8c>
40002360: 5100c12a     	sub	w10, w9, #0x30
40002364: 7100255f     	cmp	w10, #0x9
40002368: 54fffe89     	b.ls	0x40002338 <script_expand_vars+0x8c>
4000236c: b9455749     	ldr	w9, [x26, #0x554]
40002370: 38286b1f     	strb	wzr, [x24, x8]
40002374: 7100053f     	cmp	w9, #0x1
40002378: 5400028b     	b.lt	0x400023c8 <script_expand_vars+0x11c>
4000237c: aa1f03fb     	mov	x27, xzr
40002380: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002384: 911562b5     	add	x21, x21, #0x558
40002388: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
4000238c: 912562f7     	add	x23, x23, #0x958
40002390: 910003e1     	mov	x1, sp
40002394: aa1503e0     	mov	x0, x21
40002398: 9400012c     	bl	0x40002848 <kstrcmp>
4000239c: 34000100     	cbz	w0, 0x400023bc <script_expand_vars+0x110>
400023a0: b9855748     	ldrsw	x8, [x26, #0x554]
400023a4: 9100077b     	add	x27, x27, #0x1
400023a8: 910202f7     	add	x23, x23, #0x80
400023ac: 910082b5     	add	x21, x21, #0x20
400023b0: eb08037f     	cmp	x27, x8
400023b4: 54fffeeb     	b.lt	0x40002390 <script_expand_vars+0xe4>
400023b8: aa1903f7     	mov	x23, x25
400023bc: 394002e8     	ldrb	w8, [x23]
400023c0: 350000a8     	cbnz	w8, 0x400023d4 <script_expand_vars+0x128>
400023c4: 17ffffcb     	b	0x400022f0 <script_expand_vars+0x44>
400023c8: aa1903f7     	mov	x23, x25
400023cc: 394002e8     	ldrb	w8, [x23]
400023d0: 34fff908     	cbz	w8, 0x400022f0 <script_expand_vars+0x44>
400023d4: 8b36c269     	add	x9, x19, w22, sxtw
400023d8: 910006ea     	add	x10, x23, #0x1
400023dc: 38001528     	strb	w8, [x9], #0x1
400023e0: 110006d6     	add	w22, w22, #0x1
400023e4: 38401548     	ldrb	w8, [x10], #0x1
400023e8: 35ffffa8     	cbnz	w8, 0x400023dc <script_expand_vars+0x130>
400023ec: 17ffffc1     	b	0x400022f0 <script_expand_vars+0x44>
400023f0: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
400023f4: a9474ff4     	ldp	x20, x19, [sp, #0x70]
400023f8: a94657f6     	ldp	x22, x21, [sp, #0x60]
400023fc: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002400: a94467fa     	ldp	x26, x25, [sp, #0x40]
40002404: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002408: a9427bfd     	ldp	x29, x30, [sp, #0x20]
4000240c: 910203ff     	add	sp, sp, #0x80
40002410: d65f03c0     	ret

0000000040002414 <script_execute_line>:
40002414: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002418: a9014ffc     	stp	x28, x19, [sp, #0x10]
4000241c: 910003fd     	mov	x29, sp
40002420: d10803ff     	sub	sp, sp, #0x200
40002424: 14000004     	b	0x40002434 <script_execute_line+0x20>
40002428: 7100811f     	cmp	w8, #0x20
4000242c: 54000121     	b.ne	0x40002450 <script_execute_line+0x3c>
40002430: 91000400     	add	x0, x0, #0x1
40002434: 39400008     	ldrb	w8, [x0]
40002438: 71007d1f     	cmp	w8, #0x1f
4000243c: 54ffff6c     	b.gt	0x40002428 <script_execute_line+0x14>
40002440: 7100251f     	cmp	w8, #0x9
40002444: 54ffff60     	b.eq	0x40002430 <script_execute_line+0x1c>
40002448: 34001668     	cbz	w8, 0x40002714 <script_execute_line+0x300>
4000244c: 14000003     	b	0x40002458 <script_execute_line+0x44>
40002450: 71008d1f     	cmp	w8, #0x23
40002454: 54001600     	b.eq	0x40002714 <script_execute_line+0x300>
40002458: 910403e1     	add	x1, sp, #0x100
4000245c: 910403f3     	add	x19, sp, #0x100
40002460: 97ffff93     	bl	0x400022ac <script_expand_vars>
40002464: 394403e9     	ldrb	w9, [sp, #0x100]
40002468: 34001529     	cbz	w9, 0x4000270c <script_execute_line+0x2f8>
4000246c: 394407e8     	ldrb	w8, [sp, #0x101]
40002470: aa1f03ea     	mov	x10, xzr
40002474: 2a0903eb     	mov	w11, w9
40002478: 14000004     	b	0x40002488 <script_execute_line+0x74>
4000247c: 9100054a     	add	x10, x10, #0x1
40002480: 386a6a6b     	ldrb	w11, [x19, x10]
40002484: 340003cb     	cbz	w11, 0x400024fc <script_execute_line+0xe8>
40002488: b4ffffaa     	cbz	x10, 0x4000247c <script_execute_line+0x68>
4000248c: 7100f57f     	cmp	w11, #0x3d
40002490: 54ffff61     	b.ne	0x4000247c <script_execute_line+0x68>
40002494: 8b13014b     	add	x11, x10, x19
40002498: 385ff16c     	ldurb	w12, [x11, #-0x1]
4000249c: 7100f59f     	cmp	w12, #0x3d
400024a0: 54fffee0     	b.eq	0x4000247c <script_execute_line+0x68>
400024a4: 3940056b     	ldrb	w11, [x11, #0x1]
400024a8: 7100f57f     	cmp	w11, #0x3d
400024ac: 54fffe80     	b.eq	0x4000247c <script_execute_line+0x68>
400024b0: aa1f03ec     	mov	x12, xzr
400024b4: 2a1f03eb     	mov	w11, wzr
400024b8: 386c6a6d     	ldrb	w13, [x19, x12]
400024bc: 9100058c     	add	x12, x12, #0x1
400024c0: 710081bf     	cmp	w13, #0x20
400024c4: 1a9f156b     	csinc	w11, w11, wzr, ne
400024c8: eb0c015f     	cmp	x10, x12
400024cc: 54ffff61     	b.ne	0x400024b8 <script_execute_line+0xa4>
400024d0: 35fffd6b     	cbnz	w11, 0x4000247c <script_execute_line+0x68>
400024d4: 7101a53f     	cmp	w9, #0x69
400024d8: 54fffd20     	b.eq	0x4000247c <script_execute_line+0x68>
400024dc: 7101991f     	cmp	w8, #0x66
400024e0: 54fffce0     	b.eq	0x4000247c <script_execute_line+0x68>
400024e4: 910403e8     	add	x8, sp, #0x100
400024e8: 910403e0     	add	x0, sp, #0x100
400024ec: 8b0a0101     	add	x1, x8, x10
400024f0: 3800143f     	strb	wzr, [x1], #0x1
400024f4: 97ffff0d     	bl	0x40002128 <script_set_var>
400024f8: 14000087     	b	0x40002714 <script_execute_line+0x300>
400024fc: 394403e9     	ldrb	w9, [sp, #0x100]
40002500: 7101a53f     	cmp	w9, #0x69
40002504: 54001041     	b.ne	0x4000270c <script_execute_line+0x2f8>
40002508: 7101991f     	cmp	w8, #0x66
4000250c: 54001001     	b.ne	0x4000270c <script_execute_line+0x2f8>
40002510: 39440be8     	ldrb	w8, [sp, #0x102]
40002514: 7100811f     	cmp	w8, #0x20
40002518: 54000fa1     	b.ne	0x4000270c <script_execute_line+0x2f8>
4000251c: 39440fe9     	ldrb	w9, [sp, #0x103]
40002520: 7100813f     	cmp	w9, #0x20
40002524: 54000081     	b.ne	0x40002534 <script_execute_line+0x120>
40002528: aa1f03e9     	mov	x9, xzr
4000252c: 52800068     	mov	w8, #0x3                // =3
40002530: 14000014     	b	0x40002580 <script_execute_line+0x16c>
40002534: 910403ea     	add	x10, sp, #0x100
40002538: aa1f03e8     	mov	x8, xzr
4000253c: 910303eb     	add	x11, sp, #0xc0
40002540: 9100114a     	add	x10, x10, #0x4
40002544: 34000189     	cbz	w9, 0x40002574 <script_execute_line+0x160>
40002548: f100f91f     	cmp	x8, #0x3e
4000254c: 54000148     	b.hi	0x40002574 <script_execute_line+0x160>
40002550: 38286969     	strb	w9, [x11, x8]
40002554: 38686949     	ldrb	w9, [x10, x8]
40002558: 9100050c     	add	x12, x8, #0x1
4000255c: aa0c03e8     	mov	x8, x12
40002560: 7100813f     	cmp	w9, #0x20
40002564: 54ffff01     	b.ne	0x40002544 <script_execute_line+0x130>
40002568: 11000d8a     	add	w10, w12, #0x3
4000256c: 2a0c03e8     	mov	w8, w12
40002570: 14000002     	b	0x40002578 <script_execute_line+0x164>
40002574: 11000d0a     	add	w10, w8, #0x3
40002578: 2a0803e9     	mov	w9, w8
4000257c: 2a0a03e8     	mov	w8, w10
40002580: 910303ea     	add	x10, sp, #0xc0
40002584: 3829695f     	strb	wzr, [x10, x9]
40002588: 910403e9     	add	x9, sp, #0x100
4000258c: 3868692a     	ldrb	w10, [x9, x8]
40002590: 7100815f     	cmp	w10, #0x20
40002594: 54000061     	b.ne	0x400025a0 <script_execute_line+0x18c>
40002598: 91000508     	add	x8, x8, #0x1
4000259c: 17fffffc     	b	0x4000258c <script_execute_line+0x178>
400025a0: 7100855f     	cmp	w10, #0x21
400025a4: 54000060     	b.eq	0x400025b0 <script_execute_line+0x19c>
400025a8: 7100f55f     	cmp	w10, #0x3d
400025ac: 540000e1     	b.ne	0x400025c8 <script_execute_line+0x1b4>
400025b0: 11000509     	add	w9, w8, #0x1
400025b4: 910403ea     	add	x10, sp, #0x100
400025b8: 38694949     	ldrb	w9, [x10, w9, uxtw]
400025bc: 9100090a     	add	x10, x8, #0x2
400025c0: 7100f53f     	cmp	w9, #0x3d
400025c4: 9a880148     	csel	x8, x10, x8, eq
400025c8: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
400025cc: 910403ea     	add	x10, sp, #0x100
400025d0: d2c0002b     	mov	x11, #0x100000000       // =4294967296
400025d4: 8b088129     	add	x9, x9, x8, lsl #32
400025d8: 8b28c14a     	add	x10, x10, w8, sxtw
400025dc: 51000508     	sub	w8, w8, #0x1
400025e0: 3840154c     	ldrb	w12, [x10], #0x1
400025e4: 8b0b0129     	add	x9, x9, x11
400025e8: 11000508     	add	w8, w8, #0x1
400025ec: 7100819f     	cmp	w12, #0x20
400025f0: 54ffff80     	b.eq	0x400025e0 <script_execute_line+0x1cc>
400025f4: 9360fd2c     	asr	x12, x9, #32
400025f8: 910403e9     	add	x9, sp, #0x100
400025fc: 386c692d     	ldrb	w13, [x9, x12]
40002600: 710081bf     	cmp	w13, #0x20
40002604: 54000061     	b.ne	0x40002610 <script_execute_line+0x1fc>
40002608: aa1f03ea     	mov	x10, xzr
4000260c: 14000010     	b	0x4000264c <script_execute_line+0x238>
40002610: aa1f03eb     	mov	x11, xzr
40002614: 910203ec     	add	x12, sp, #0x80
40002618: 3400016d     	cbz	w13, 0x40002644 <script_execute_line+0x230>
4000261c: f100f97f     	cmp	x11, #0x3e
40002620: 54000128     	b.hi	0x40002644 <script_execute_line+0x230>
40002624: 382b698d     	strb	w13, [x12, x11]
40002628: 386b694d     	ldrb	w13, [x10, x11]
4000262c: 9100056e     	add	x14, x11, #0x1
40002630: 11000508     	add	w8, w8, #0x1
40002634: aa0e03eb     	mov	x11, x14
40002638: 710081bf     	cmp	w13, #0x20
4000263c: 54fffee1     	b.ne	0x40002618 <script_execute_line+0x204>
40002640: 2a0e03eb     	mov	w11, w14
40002644: 93407d0c     	sxtw	x12, w8
40002648: 2a0b03ea     	mov	w10, w11
4000264c: d3607d8d     	lsl	x13, x12, #32
40002650: 910203eb     	add	x11, sp, #0x80
40002654: d2c0006f     	mov	x15, #0x300000000       // =12884901888
40002658: d2c00050     	mov	x16, #0x200000000       // =8589934592
4000265c: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002660: 11001108     	add	w8, w8, #0x4
40002664: 382a697f     	strb	wzr, [x11, x10]
40002668: 8b0f01aa     	add	x10, x13, x15
4000266c: 8b1001ab     	add	x11, x13, x16
40002670: 8b0e01ad     	add	x13, x13, x14
40002674: 8b0c0129     	add	x9, x9, x12
40002678: 3840152c     	ldrb	w12, [x9], #0x1
4000267c: 7100819f     	cmp	w12, #0x20
40002680: 540000c1     	b.ne	0x40002698 <script_execute_line+0x284>
40002684: 11000508     	add	w8, w8, #0x1
40002688: 8b0e014a     	add	x10, x10, x14
4000268c: 8b0e016b     	add	x11, x11, x14
40002690: 8b0e01ad     	add	x13, x13, x14
40002694: 17fffff9     	b	0x40002678 <script_execute_line+0x264>
40002698: 7101d19f     	cmp	w12, #0x74
4000269c: 54000381     	b.ne	0x4000270c <script_execute_line+0x2f8>
400026a0: 9360fdac     	asr	x12, x13, #32
400026a4: 910403e9     	add	x9, sp, #0x100
400026a8: 386c692c     	ldrb	w12, [x9, x12]
400026ac: 7101a19f     	cmp	w12, #0x68
400026b0: 540002e1     	b.ne	0x4000270c <script_execute_line+0x2f8>
400026b4: 9360fd6b     	asr	x11, x11, #32
400026b8: 386b6929     	ldrb	w9, [x9, x11]
400026bc: 7101953f     	cmp	w9, #0x65
400026c0: 54000261     	b.ne	0x4000270c <script_execute_line+0x2f8>
400026c4: 9360fd4a     	asr	x10, x10, #32
400026c8: 910403e9     	add	x9, sp, #0x100
400026cc: 386a692a     	ldrb	w10, [x9, x10]
400026d0: 7101b95f     	cmp	w10, #0x6e
400026d4: 540001c1     	b.ne	0x4000270c <script_execute_line+0x2f8>
400026d8: 8b28c128     	add	x8, x9, w8, sxtw
400026dc: d1000501     	sub	x1, x8, #0x1
400026e0: 38401c28     	ldrb	w8, [x1, #0x1]!
400026e4: 7100811f     	cmp	w8, #0x20
400026e8: 54ffffc0     	b.eq	0x400026e0 <script_execute_line+0x2cc>
400026ec: 910003e0     	mov	x0, sp
400026f0: 94000075     	bl	0x400028c4 <kstrcpy>
400026f4: 910303e0     	add	x0, sp, #0xc0
400026f8: 910203e1     	add	x1, sp, #0x80
400026fc: 94000053     	bl	0x40002848 <kstrcmp>
40002700: 350000a0     	cbnz	w0, 0x40002714 <script_execute_line+0x300>
40002704: 910003e0     	mov	x0, sp
40002708: 14000002     	b	0x40002710 <script_execute_line+0x2fc>
4000270c: 910403e0     	add	x0, sp, #0x100
40002710: 97fff9cb     	bl	0x40000e3c <execute_command>
40002714: 2a1f03e0     	mov	w0, wzr
40002718: 910803ff     	add	sp, sp, #0x200
4000271c: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002720: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002724: d65f03c0     	ret

0000000040002728 <script_run_file>:
40002728: d10503ff     	sub	sp, sp, #0x140
4000272c: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002730: 910403fd     	add	x29, sp, #0x100
40002734: f9008bfc     	str	x28, [sp, #0x110]
40002738: a91257f6     	stp	x22, x21, [sp, #0x120]
4000273c: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002740: aa0003f4     	mov	x20, x0
40002744: 940008ba     	bl	0x40004a2c <vfs_find>
40002748: b4000080     	cbz	x0, 0x40002758 <script_run_file+0x30>
4000274c: b9402008     	ldr	w8, [x0, #0x20]
40002750: aa0003f3     	mov	x19, x0
40002754: 340000e8     	cbz	w8, 0x40002770 <script_run_file+0x48>
40002758: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000275c: 91029000     	add	x0, x0, #0xa4
40002760: aa1403e1     	mov	x1, x20
40002764: 940004e9     	bl	0x40003b08 <uart_printf>
40002768: 12800000     	mov	w0, #-0x1               // =-1
4000276c: 14000021     	b	0x400027f0 <script_run_file+0xc8>
40002770: f9401668     	ldr	x8, [x19, #0x28]
40002774: aa1f03f4     	mov	x20, xzr
40002778: 2a1f03e9     	mov	w9, wzr
4000277c: 9100c275     	add	x21, x19, #0x30
40002780: 910003f6     	mov	x22, sp
40002784: 14000008     	b	0x400027a4 <script_run_file+0x7c>
40002788: 7100053f     	cmp	w9, #0x1
4000278c: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002790: 2a1f03e9     	mov	w9, wzr
40002794: 5400022a     	b.ge	0x400027d8 <script_run_file+0xb0>
40002798: 91000694     	add	x20, x20, #0x1
4000279c: eb08029f     	cmp	x20, x8
400027a0: 54000268     	b.hi	0x400027ec <script_run_file+0xc4>
400027a4: eb08029f     	cmp	x20, x8
400027a8: 54ffff00     	b.eq	0x40002788 <script_run_file+0x60>
400027ac: 38746aaa     	ldrb	w10, [x21, x20]
400027b0: 7100295f     	cmp	w10, #0xa
400027b4: 54fffea0     	b.eq	0x40002788 <script_run_file+0x60>
400027b8: 7100355f     	cmp	w10, #0xd
400027bc: 54fffee0     	b.eq	0x40002798 <script_run_file+0x70>
400027c0: 7103f93f     	cmp	w9, #0xfe
400027c4: 54fffeac     	b.gt	0x40002798 <script_run_file+0x70>
400027c8: 1100052b     	add	w11, w9, #0x1
400027cc: 3829caca     	strb	w10, [x22, w9, sxtw]
400027d0: 2a0b03e9     	mov	w9, w11
400027d4: 17fffff1     	b	0x40002798 <script_run_file+0x70>
400027d8: 910003e0     	mov	x0, sp
400027dc: 97ffff0e     	bl	0x40002414 <script_execute_line>
400027e0: f9401668     	ldr	x8, [x19, #0x28]
400027e4: 2a1f03e9     	mov	w9, wzr
400027e8: 17ffffec     	b	0x40002798 <script_run_file+0x70>
400027ec: 2a1f03e0     	mov	w0, wzr
400027f0: a9534ff4     	ldp	x20, x19, [sp, #0x130]
400027f4: f9408bfc     	ldr	x28, [sp, #0x110]
400027f8: a95257f6     	ldp	x22, x21, [sp, #0x120]
400027fc: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002800: 910503ff     	add	sp, sp, #0x140
40002804: d65f03c0     	ret

0000000040002808 <kstrlen>:
40002808: b40000c0     	cbz	x0, 0x40002820 <kstrlen+0x18>
4000280c: aa1f03e8     	mov	x8, xzr
40002810: 38686809     	ldrb	w9, [x0, x8]
40002814: 91000508     	add	x8, x8, #0x1
40002818: 35ffffc9     	cbnz	w9, 0x40002810 <kstrlen+0x8>
4000281c: d1000500     	sub	x0, x8, #0x1
40002820: d65f03c0     	ret

0000000040002824 <kstrcat>:
40002824: b4000100     	cbz	x0, 0x40002844 <kstrcat+0x20>
40002828: b40000e1     	cbz	x1, 0x40002844 <kstrcat+0x20>
4000282c: d1000408     	sub	x8, x0, #0x1
40002830: 38401d09     	ldrb	w9, [x8, #0x1]!
40002834: 35ffffe9     	cbnz	w9, 0x40002830 <kstrcat+0xc>
40002838: 38401429     	ldrb	w9, [x1], #0x1
4000283c: 38001509     	strb	w9, [x8], #0x1
40002840: 35ffffc9     	cbnz	w9, 0x40002838 <kstrcat+0x14>
40002844: d65f03c0     	ret

0000000040002848 <kstrcmp>:
40002848: aa0003e8     	mov	x8, x0
4000284c: 12800000     	mov	w0, #-0x1               // =-1
40002850: b4000188     	cbz	x8, 0x40002880 <kstrcmp+0x38>
40002854: b4000161     	cbz	x1, 0x40002880 <kstrcmp+0x38>
40002858: 38401509     	ldrb	w9, [x8], #0x1
4000285c: 340000e9     	cbz	w9, 0x40002878 <kstrcmp+0x30>
40002860: 3940002a     	ldrb	w10, [x1]
40002864: 6b0a013f     	cmp	w9, w10
40002868: 54000081     	b.ne	0x40002878 <kstrcmp+0x30>
4000286c: 38401509     	ldrb	w9, [x8], #0x1
40002870: 91000421     	add	x1, x1, #0x1
40002874: 35ffff69     	cbnz	w9, 0x40002860 <kstrcmp+0x18>
40002878: 39400028     	ldrb	w8, [x1]
4000287c: 4b080120     	sub	w0, w9, w8
40002880: d65f03c0     	ret

0000000040002884 <kstrncmp>:
40002884: 12800008     	mov	w8, #-0x1               // =-1
40002888: b4000160     	cbz	x0, 0x400028b4 <kstrncmp+0x30>
4000288c: b4000141     	cbz	x1, 0x400028b4 <kstrncmp+0x30>
40002890: b4000102     	cbz	x2, 0x400028b0 <kstrncmp+0x2c>
40002894: 38401408     	ldrb	w8, [x0], #0x1
40002898: 38401429     	ldrb	w9, [x1], #0x1
4000289c: 34000108     	cbz	w8, 0x400028bc <kstrncmp+0x38>
400028a0: 6b09011f     	cmp	w8, w9
400028a4: 540000c1     	b.ne	0x400028bc <kstrncmp+0x38>
400028a8: f1000442     	subs	x2, x2, #0x1
400028ac: 54ffff41     	b.ne	0x40002894 <kstrncmp+0x10>
400028b0: 2a1f03e8     	mov	w8, wzr
400028b4: 2a0803e0     	mov	w0, w8
400028b8: d65f03c0     	ret
400028bc: 4b090100     	sub	w0, w8, w9
400028c0: d65f03c0     	ret

00000000400028c4 <kstrcpy>:
400028c4: b40000c0     	cbz	x0, 0x400028dc <kstrcpy+0x18>
400028c8: b40000a1     	cbz	x1, 0x400028dc <kstrcpy+0x18>
400028cc: aa0003e8     	mov	x8, x0
400028d0: 38401429     	ldrb	w9, [x1], #0x1
400028d4: 38001509     	strb	w9, [x8], #0x1
400028d8: 35ffffc9     	cbnz	w9, 0x400028d0 <kstrcpy+0xc>
400028dc: d65f03c0     	ret

00000000400028e0 <kstrncpy>:
400028e0: b4000480     	cbz	x0, 0x40002970 <kstrncpy+0x90>
400028e4: b4000461     	cbz	x1, 0x40002970 <kstrncpy+0x90>
400028e8: b4000442     	cbz	x2, 0x40002970 <kstrncpy+0x90>
400028ec: aa1f03e9     	mov	x9, xzr
400028f0: aa0203e8     	mov	x8, x2
400028f4: 3869682a     	ldrb	w10, [x1, x9]
400028f8: 3829680a     	strb	w10, [x0, x9]
400028fc: 340000ca     	cbz	w10, 0x40002914 <kstrncpy+0x34>
40002900: 91000529     	add	x9, x9, #0x1
40002904: d1000508     	sub	x8, x8, #0x1
40002908: eb09005f     	cmp	x2, x9
4000290c: 54ffff41     	b.ne	0x400028f4 <kstrncpy+0x14>
40002910: 14000018     	b	0x40002970 <kstrncpy+0x90>
40002914: cb09004a     	sub	x10, x2, x9
40002918: 8b090009     	add	x9, x0, x9
4000291c: f100095f     	cmp	x10, #0x2
40002920: 54000082     	b.hs	0x40002930 <kstrncpy+0x50>
40002924: 91000528     	add	x8, x9, #0x1
40002928: aa0a03e9     	mov	x9, x10
4000292c: 1400000e     	b	0x40002964 <kstrncpy+0x84>
40002930: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002934: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002938: 9100092c     	add	x12, x9, #0x2
4000293c: 8b090108     	add	x8, x8, x9
40002940: 92400149     	and	x9, x10, #0x1
40002944: aa0b03ed     	mov	x13, x11
40002948: 91000508     	add	x8, x8, #0x1
4000294c: f10009ad     	subs	x13, x13, #0x2
40002950: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002954: 3800259f     	strb	wzr, [x12], #0x2
40002958: 54ffffa1     	b.ne	0x4000294c <kstrncpy+0x6c>
4000295c: eb0b015f     	cmp	x10, x11
40002960: 54000080     	b.eq	0x40002970 <kstrncpy+0x90>
40002964: f1000529     	subs	x9, x9, #0x1
40002968: 3800151f     	strb	wzr, [x8], #0x1
4000296c: 54ffffc1     	b.ne	0x40002964 <kstrncpy+0x84>
40002970: d65f03c0     	ret

0000000040002974 <memset>:
40002974: b40002a0     	cbz	x0, 0x400029c8 <memset+0x54>
40002978: b4000282     	cbz	x2, 0x400029c8 <memset+0x54>
4000297c: f100085f     	cmp	x2, #0x2
40002980: 54000082     	b.hs	0x40002990 <memset+0x1c>
40002984: aa0003e8     	mov	x8, x0
40002988: aa0203e9     	mov	x9, x2
4000298c: 1400000c     	b	0x400029bc <memset+0x48>
40002990: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
40002994: 92400049     	and	x9, x2, #0x1
40002998: 9100040b     	add	x11, x0, #0x1
4000299c: 8b0a0008     	add	x8, x0, x10
400029a0: aa0a03ec     	mov	x12, x10
400029a4: f100098c     	subs	x12, x12, #0x2
400029a8: 381ff161     	sturb	w1, [x11, #-0x1]
400029ac: 38002561     	strb	w1, [x11], #0x2
400029b0: 54ffffa1     	b.ne	0x400029a4 <memset+0x30>
400029b4: eb0a005f     	cmp	x2, x10
400029b8: 54000080     	b.eq	0x400029c8 <memset+0x54>
400029bc: f1000529     	subs	x9, x9, #0x1
400029c0: 38001501     	strb	w1, [x8], #0x1
400029c4: 54ffffc1     	b.ne	0x400029bc <memset+0x48>
400029c8: d65f03c0     	ret

00000000400029cc <memcpy>:
400029cc: b4000100     	cbz	x0, 0x400029ec <memcpy+0x20>
400029d0: b40000e1     	cbz	x1, 0x400029ec <memcpy+0x20>
400029d4: b40000c2     	cbz	x2, 0x400029ec <memcpy+0x20>
400029d8: aa0003e8     	mov	x8, x0
400029dc: 38401429     	ldrb	w9, [x1], #0x1
400029e0: f1000442     	subs	x2, x2, #0x1
400029e4: 38001509     	strb	w9, [x8], #0x1
400029e8: 54ffffa1     	b.ne	0x400029dc <memcpy+0x10>
400029ec: d65f03c0     	ret

00000000400029f0 <kstrstr>:
400029f0: aa1f03e2     	mov	x2, xzr
400029f4: b40000e0     	cbz	x0, 0x40002a10 <kstrstr+0x20>
400029f8: b40000c1     	cbz	x1, 0x40002a10 <kstrstr+0x20>
400029fc: 39400028     	ldrb	w8, [x1]
40002a00: 340002c8     	cbz	w8, 0x40002a58 <kstrstr+0x68>
40002a04: 39400009     	ldrb	w9, [x0]
40002a08: 35000109     	cbnz	w9, 0x40002a28 <kstrstr+0x38>
40002a0c: aa1f03e2     	mov	x2, xzr
40002a10: aa0203e0     	mov	x0, x2
40002a14: d65f03c0     	ret
40002a18: 3940012c     	ldrb	w12, [x9]
40002a1c: 340001ec     	cbz	w12, 0x40002a58 <kstrstr+0x68>
40002a20: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a24: 34ffff49     	cbz	w9, 0x40002a0c <kstrstr+0x1c>
40002a28: 6b08013f     	cmp	w9, w8
40002a2c: 54ffffa1     	b.ne	0x40002a20 <kstrstr+0x30>
40002a30: 5280002a     	mov	w10, #0x1               // =1
40002a34: aa0103e9     	mov	x9, x1
40002a38: 2a0803eb     	mov	w11, w8
40002a3c: 3840152c     	ldrb	w12, [x9], #0x1
40002a40: 6b0c017f     	cmp	w11, w12
40002a44: 54fffec1     	b.ne	0x40002a1c <kstrstr+0x2c>
40002a48: 386a680b     	ldrb	w11, [x0, x10]
40002a4c: 9100054a     	add	x10, x10, #0x1
40002a50: 35ffff6b     	cbnz	w11, 0x40002a3c <kstrstr+0x4c>
40002a54: 17fffff1     	b	0x40002a18 <kstrstr+0x28>
40002a58: d65f03c0     	ret

0000000040002a5c <kstrchr>:
40002a5c: b4000140     	cbz	x0, 0x40002a84 <kstrchr+0x28>
40002a60: 39400009     	ldrb	w9, [x0]
40002a64: 340000c9     	cbz	w9, 0x40002a7c <kstrchr+0x20>
40002a68: 12001c28     	and	w8, w1, #0xff
40002a6c: 6b08013f     	cmp	w9, w8
40002a70: 540000a0     	b.eq	0x40002a84 <kstrchr+0x28>
40002a74: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a78: 35ffffa9     	cbnz	w9, 0x40002a6c <kstrchr+0x10>
40002a7c: 72001c3f     	tst	w1, #0xff
40002a80: 9a9f0000     	csel	x0, x0, xzr, eq
40002a84: d65f03c0     	ret

0000000040002a88 <ktolower>:
40002a88: 51010408     	sub	w8, w0, #0x41
40002a8c: 321b0009     	orr	w9, w0, #0x20
40002a90: 7100691f     	cmp	w8, #0x1a
40002a94: 1a803120     	csel	w0, w9, w0, lo
40002a98: d65f03c0     	ret

0000000040002a9c <kstr_tolower>:
40002a9c: b40001a0     	cbz	x0, 0x40002ad0 <kstr_tolower+0x34>
40002aa0: b4000181     	cbz	x1, 0x40002ad0 <kstr_tolower+0x34>
40002aa4: 39400029     	ldrb	w9, [x1]
40002aa8: 34000129     	cbz	w9, 0x40002acc <kstr_tolower+0x30>
40002aac: 91000428     	add	x8, x1, #0x1
40002ab0: 5101052a     	sub	w10, w9, #0x41
40002ab4: 321b012b     	orr	w11, w9, #0x20
40002ab8: 7100695f     	cmp	w10, #0x1a
40002abc: 1a893169     	csel	w9, w11, w9, lo
40002ac0: 38001409     	strb	w9, [x0], #0x1
40002ac4: 38401509     	ldrb	w9, [x8], #0x1
40002ac8: 35ffff49     	cbnz	w9, 0x40002ab0 <kstr_tolower+0x14>
40002acc: 3900001f     	strb	wzr, [x0]
40002ad0: d65f03c0     	ret

0000000040002ad4 <timer_init>:
40002ad4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002ad8: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002adc: f9000bf3     	str	x19, [sp, #0x10]
40002ae0: d53be008     	mrs	x8, CNTFRQ_EL0
40002ae4: f29999a9     	movk	x9, #0xcccd
40002ae8: b0000073     	adrp	x19, 0x4000f000 <var_values+0x6a8>
40002aec: 528003c0     	mov	w0, #0x1e               // =30
40002af0: 9bc97d09     	umulh	x9, x8, x9
40002af4: 910003fd     	mov	x29, sp
40002af8: 5280002a     	mov	w10, #0x1               // =1
40002afc: f904ae68     	str	x8, [x19, #0x958]
40002b00: d343fd29     	lsr	x9, x9, #3
40002b04: d51be209     	msr	CNTP_TVAL_EL0, x9
40002b08: d51be22a     	msr	CNTP_CTL_EL0, x10
40002b0c: 97fff5cd     	bl	0x40000240 <gic_enable_interrupt>
40002b10: d50342ff     	msr	DAIFClr, #0x2
40002b14: d503201f     	nop
40002b18: 30033640     	adr	x0, 0x400091e1 <__rodata_start+0x21e1>
40002b1c: b9495a61     	ldr	w1, [x19, #0x958]
40002b20: f9400bf3     	ldr	x19, [sp, #0x10]
40002b24: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002b28: 140003f8     	b	0x40003b08 <uart_printf>

0000000040002b2c <timer_handle_interrupt>:
40002b2c: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b30: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b34: f944ad08     	ldr	x8, [x8, #0x958]
40002b38: f29999a9     	movk	x9, #0xcccd
40002b3c: 9bc97d08     	umulh	x8, x8, x9
40002b40: b0000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40002b44: f944b12a     	ldr	x10, [x9, #0x960]
40002b48: 9100054a     	add	x10, x10, #0x1
40002b4c: f904b12a     	str	x10, [x9, #0x960]
40002b50: d343fd08     	lsr	x8, x8, #3
40002b54: d51be208     	msr	CNTP_TVAL_EL0, x8
40002b58: d65f03c0     	ret

0000000040002b5c <tui_launch>:
40002b5c: d105c3ff     	sub	sp, sp, #0x170
40002b60: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b64: 910443fd     	add	x29, sp, #0x110
40002b68: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002b6c: a91367fa     	stp	x26, x25, [sp, #0x130]
40002b70: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002b74: a91557f6     	stp	x22, x21, [sp, #0x150]
40002b78: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002b7c: 9400075a     	bl	0x400048e4 <vfs_get_cwd>
40002b80: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b84: b000007c     	adrp	x28, 0x4000f000 <var_values+0x6a8>
40002b88: b000007b     	adrp	x27, 0x4000f000 <var_values+0x6a8>
40002b8c: f904b500     	str	x0, [x8, #0x968]
40002b90: d503201f     	nop
40002b94: 7002e720     	adr	x0, 0x4000887b <__rodata_start+0x187b>
40002b98: b909739f     	str	wzr, [x28, #0x970]
40002b9c: b909777f     	str	wzr, [x27, #0x974]
40002ba0: 940002c5     	bl	0x400036b4 <uart_puts>
40002ba4: b0000036     	adrp	x22, 0x40007000 <__rodata_start>
40002ba8: 9110cad6     	add	x22, x22, #0x432
40002bac: b0000037     	adrp	x23, 0x40007000 <__rodata_start>
40002bb0: 910c8af7     	add	x23, x23, #0x322
40002bb4: b0000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40002bb8: 91260318     	add	x24, x24, #0x980
40002bbc: b000007a     	adrp	x26, 0x4000f000 <var_values+0x6a8>
40002bc0: b0000034     	adrp	x20, 0x40007000 <__rodata_start>
40002bc4: 91144e94     	add	x20, x20, #0x513
40002bc8: 14000005     	b	0x40002bdc <tui_launch+0x80>
40002bcc: b9497388     	ldr	w8, [x28, #0x970]
40002bd0: 7100011f     	cmp	w8, #0x0
40002bd4: 1a9f17e8     	cset	w8, eq
40002bd8: b9097388     	str	w8, [x28, #0x970]
40002bdc: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002be0: b9097b5f     	str	wzr, [x26, #0x978]
40002be4: f944b50a     	ldr	x10, [x8, #0x968]
40002be8: f9421948     	ldr	x8, [x10, #0x430]
40002bec: b4000108     	cbz	x8, 0x40002c0c <tui_launch+0xb0>
40002bf0: 52800029     	mov	w9, #0x1                // =1
40002bf4: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002bf8: b9097b49     	str	w9, [x26, #0x978]
40002bfc: f904c11f     	str	xzr, [x8, #0x980]
40002c00: f9401548     	ldr	x8, [x10, #0x28]
40002c04: b50000a8     	cbnz	x8, 0x40002c18 <tui_launch+0xbc>
40002c08: 14000027     	b	0x40002ca4 <tui_launch+0x148>
40002c0c: 2a1f03e9     	mov	w9, wzr
40002c10: f9401548     	ldr	x8, [x10, #0x28]
40002c14: b4000488     	cbz	x8, 0x40002ca4 <tui_launch+0x148>
40002c18: 2a0903e9     	mov	w9, w9
40002c1c: d100050c     	sub	x12, x8, #0x1
40002c20: d240152b     	eor	x11, x9, #0x3f
40002c24: eb0b019f     	cmp	x12, x11
40002c28: 9a8b318b     	csel	x11, x12, x11, lo
40002c2c: b400022c     	cbz	x12, 0x40002c70 <tui_launch+0x114>
40002c30: 9100056c     	add	x12, x11, #0x1
40002c34: 8b090f0e     	add	x14, x24, x9, lsl #3
40002c38: 9111014d     	add	x13, x10, #0x440
40002c3c: 927f798b     	and	x11, x12, #0xfffffffe
40002c40: aa090169     	orr	x9, x11, x9
40002c44: 910021ce     	add	x14, x14, #0x8
40002c48: aa0b03ef     	mov	x15, x11
40002c4c: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002c50: f10009ef     	subs	x15, x15, #0x2
40002c54: 910041ad     	add	x13, x13, #0x10
40002c58: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002c5c: 910041ce     	add	x14, x14, #0x10
40002c60: 54ffff61     	b.ne	0x40002c4c <tui_launch+0xf0>
40002c64: eb0b019f     	cmp	x12, x11
40002c68: 54000061     	b.ne	0x40002c74 <tui_launch+0x118>
40002c6c: 1400000d     	b	0x40002ca0 <tui_launch+0x144>
40002c70: aa1f03eb     	mov	x11, xzr
40002c74: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002c78: 9100056b     	add	x11, x11, #0x1
40002c7c: 9110e14a     	add	x10, x10, #0x438
40002c80: f840854c     	ldr	x12, [x10], #0x8
40002c84: f100f93f     	cmp	x9, #0x3e
40002c88: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002c8c: 91000529     	add	x9, x9, #0x1
40002c90: 54000088     	b.hi	0x40002ca0 <tui_launch+0x144>
40002c94: eb08017f     	cmp	x11, x8
40002c98: 9100056b     	add	x11, x11, #0x1
40002c9c: 54ffff23     	b.lo	0x40002c80 <tui_launch+0x124>
40002ca0: b9097b49     	str	w9, [x26, #0x978]
40002ca4: b949776a     	ldr	w10, [x27, #0x974]
40002ca8: 51000528     	sub	w8, w9, #0x1
40002cac: 6b08015f     	cmp	w10, w8
40002cb0: 1a88b148     	csel	w8, w10, w8, lt
40002cb4: 6b09015f     	cmp	w10, w9
40002cb8: 5400004a     	b.ge	0x40002cc0 <tui_launch+0x164>
40002cbc: 36f80068     	tbz	w8, #0x1f, 0x40002cc8 <tui_launch+0x16c>
40002cc0: 0aa87d08     	bic	w8, w8, w8, asr #31
40002cc4: b9097768     	str	w8, [x27, #0x974]
40002cc8: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002ccc: 91250800     	add	x0, x0, #0x942
40002cd0: 94000279     	bl	0x400036b4 <uart_puts>
40002cd4: b9497388     	ldr	w8, [x28, #0x970]
40002cd8: 52800020     	mov	w0, #0x1                // =1
40002cdc: 52800501     	mov	w1, #0x28               // =40
40002ce0: b0000022     	adrp	x2, 0x40007000 <__rodata_start>
40002ce4: 91023042     	add	x2, x2, #0x8c
40002ce8: 7100011f     	cmp	w8, #0x0
40002cec: 1a9f17e3     	cset	w3, eq
40002cf0: 94000171     	bl	0x400032b4 <draw_box>
40002cf4: 52800075     	mov	w21, #0x3               // =3
40002cf8: aa1603e0     	mov	x0, x22
40002cfc: 2a1503e1     	mov	w1, w21
40002d00: 52800042     	mov	w2, #0x2                // =2
40002d04: 94000381     	bl	0x40003b08 <uart_printf>
40002d08: aa1703e0     	mov	x0, x23
40002d0c: 9400026a     	bl	0x400036b4 <uart_puts>
40002d10: aa1703e0     	mov	x0, x23
40002d14: 94000268     	bl	0x400036b4 <uart_puts>
40002d18: aa1703e0     	mov	x0, x23
40002d1c: 94000266     	bl	0x400036b4 <uart_puts>
40002d20: aa1703e0     	mov	x0, x23
40002d24: 94000264     	bl	0x400036b4 <uart_puts>
40002d28: aa1703e0     	mov	x0, x23
40002d2c: 94000262     	bl	0x400036b4 <uart_puts>
40002d30: aa1703e0     	mov	x0, x23
40002d34: 94000260     	bl	0x400036b4 <uart_puts>
40002d38: aa1703e0     	mov	x0, x23
40002d3c: 9400025e     	bl	0x400036b4 <uart_puts>
40002d40: aa1703e0     	mov	x0, x23
40002d44: 9400025c     	bl	0x400036b4 <uart_puts>
40002d48: aa1703e0     	mov	x0, x23
40002d4c: 9400025a     	bl	0x400036b4 <uart_puts>
40002d50: aa1703e0     	mov	x0, x23
40002d54: 94000258     	bl	0x400036b4 <uart_puts>
40002d58: aa1703e0     	mov	x0, x23
40002d5c: 94000256     	bl	0x400036b4 <uart_puts>
40002d60: aa1703e0     	mov	x0, x23
40002d64: 94000254     	bl	0x400036b4 <uart_puts>
40002d68: aa1703e0     	mov	x0, x23
40002d6c: 94000252     	bl	0x400036b4 <uart_puts>
40002d70: aa1703e0     	mov	x0, x23
40002d74: 94000250     	bl	0x400036b4 <uart_puts>
40002d78: aa1703e0     	mov	x0, x23
40002d7c: 9400024e     	bl	0x400036b4 <uart_puts>
40002d80: aa1703e0     	mov	x0, x23
40002d84: 9400024c     	bl	0x400036b4 <uart_puts>
40002d88: aa1703e0     	mov	x0, x23
40002d8c: 9400024a     	bl	0x400036b4 <uart_puts>
40002d90: aa1703e0     	mov	x0, x23
40002d94: 94000248     	bl	0x400036b4 <uart_puts>
40002d98: aa1703e0     	mov	x0, x23
40002d9c: 94000246     	bl	0x400036b4 <uart_puts>
40002da0: aa1703e0     	mov	x0, x23
40002da4: 94000244     	bl	0x400036b4 <uart_puts>
40002da8: aa1703e0     	mov	x0, x23
40002dac: 94000242     	bl	0x400036b4 <uart_puts>
40002db0: aa1703e0     	mov	x0, x23
40002db4: 94000240     	bl	0x400036b4 <uart_puts>
40002db8: aa1703e0     	mov	x0, x23
40002dbc: 9400023e     	bl	0x400036b4 <uart_puts>
40002dc0: aa1703e0     	mov	x0, x23
40002dc4: 9400023c     	bl	0x400036b4 <uart_puts>
40002dc8: aa1703e0     	mov	x0, x23
40002dcc: 9400023a     	bl	0x400036b4 <uart_puts>
40002dd0: aa1703e0     	mov	x0, x23
40002dd4: 94000238     	bl	0x400036b4 <uart_puts>
40002dd8: aa1703e0     	mov	x0, x23
40002ddc: 94000236     	bl	0x400036b4 <uart_puts>
40002de0: aa1703e0     	mov	x0, x23
40002de4: 94000234     	bl	0x400036b4 <uart_puts>
40002de8: aa1703e0     	mov	x0, x23
40002dec: 94000232     	bl	0x400036b4 <uart_puts>
40002df0: aa1703e0     	mov	x0, x23
40002df4: 94000230     	bl	0x400036b4 <uart_puts>
40002df8: aa1703e0     	mov	x0, x23
40002dfc: 9400022e     	bl	0x400036b4 <uart_puts>
40002e00: aa1703e0     	mov	x0, x23
40002e04: 9400022c     	bl	0x400036b4 <uart_puts>
40002e08: aa1703e0     	mov	x0, x23
40002e0c: 9400022a     	bl	0x400036b4 <uart_puts>
40002e10: aa1703e0     	mov	x0, x23
40002e14: 94000228     	bl	0x400036b4 <uart_puts>
40002e18: aa1703e0     	mov	x0, x23
40002e1c: 94000226     	bl	0x400036b4 <uart_puts>
40002e20: aa1703e0     	mov	x0, x23
40002e24: 94000224     	bl	0x400036b4 <uart_puts>
40002e28: aa1703e0     	mov	x0, x23
40002e2c: 94000222     	bl	0x400036b4 <uart_puts>
40002e30: aa1703e0     	mov	x0, x23
40002e34: 94000220     	bl	0x400036b4 <uart_puts>
40002e38: 110006b5     	add	w21, w21, #0x1
40002e3c: 71005ebf     	cmp	w21, #0x17
40002e40: 54fff5c1     	b.ne	0x40002cf8 <tui_launch+0x19c>
40002e44: b9497768     	ldr	w8, [x27, #0x974]
40002e48: 52800249     	mov	w9, #0x12               // =18
40002e4c: 7100491f     	cmp	w8, #0x12
40002e50: 1a89c108     	csel	w8, w8, w9, gt
40002e54: 51004915     	sub	w21, w8, #0x12
40002e58: 8b354f19     	add	x25, x24, w21, uxtw #3
40002e5c: aa1f03f8     	mov	x24, xzr
40002e60: 14000004     	b	0x40002e70 <tui_launch+0x314>
40002e64: 91000718     	add	x24, x24, #0x1
40002e68: f100531f     	cmp	x24, #0x14
40002e6c: 540005a0     	b.eq	0x40002f20 <tui_launch+0x3c4>
40002e70: b9897b48     	ldrsw	x8, [x26, #0x978]
40002e74: 8b1802b3     	add	x19, x21, x24
40002e78: eb08027f     	cmp	x19, x8
40002e7c: 5400052a     	b.ge	0x40002f20 <tui_launch+0x3c4>
40002e80: 11000f01     	add	w1, w24, #0x3
40002e84: aa1603e0     	mov	x0, x22
40002e88: 52800062     	mov	w2, #0x3                // =3
40002e8c: 9400031f     	bl	0x40003b08 <uart_printf>
40002e90: b9497768     	ldr	w8, [x27, #0x974]
40002e94: eb08027f     	cmp	x19, x8
40002e98: 540000c1     	b.ne	0x40002eb0 <tui_launch+0x354>
40002e9c: b9497388     	ldr	w8, [x28, #0x970]
40002ea0: 35000088     	cbnz	w8, 0x40002eb0 <tui_launch+0x354>
40002ea4: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002ea8: 91037000     	add	x0, x0, #0xdc
40002eac: 94000202     	bl	0x400036b4 <uart_puts>
40002eb0: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002eb4: b40001e8     	cbz	x8, 0x40002ef0 <tui_launch+0x394>
40002eb8: b9402108     	ldr	w8, [x8, #0x20]
40002ebc: d0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40002ec0: 910a6129     	add	x9, x9, #0x298
40002ec4: 910223e0     	add	x0, sp, #0x88
40002ec8: 7100051f     	cmp	w8, #0x1
40002ecc: b0000028     	adrp	x8, 0x40007000 <__rodata_start>
40002ed0: 91360d08     	add	x8, x8, #0xd83
40002ed4: 9a880121     	csel	x1, x9, x8, eq
40002ed8: 97fffe7b     	bl	0x400028c4 <kstrcpy>
40002edc: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002ee0: 910223e0     	add	x0, sp, #0x88
40002ee4: 97fffe50     	bl	0x40002824 <kstrcat>
40002ee8: 910223e0     	add	x0, sp, #0x88
40002eec: 14000003     	b	0x40002ef8 <tui_launch+0x39c>
40002ef0: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002ef4: 9130ec00     	add	x0, x0, #0xc3b
40002ef8: 940001ef     	bl	0x400036b4 <uart_puts>
40002efc: b9497768     	ldr	w8, [x27, #0x974]
40002f00: eb08027f     	cmp	x19, x8
40002f04: 54fffb01     	b.ne	0x40002e64 <tui_launch+0x308>
40002f08: b9497388     	ldr	w8, [x28, #0x970]
40002f0c: 35fffac8     	cbnz	w8, 0x40002e64 <tui_launch+0x308>
40002f10: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002f14: 912ce800     	add	x0, x0, #0xb3a
40002f18: 940001e7     	bl	0x400036b4 <uart_puts>
40002f1c: 17ffffd2     	b	0x40002e64 <tui_launch+0x308>
40002f20: b9497388     	ldr	w8, [x28, #0x970]
40002f24: 52800540     	mov	w0, #0x2a               // =42
40002f28: 528004c1     	mov	w1, #0x26               // =38
40002f2c: d0000022     	adrp	x2, 0x40008000 <__rodata_start+0x1000>
40002f30: 91030442     	add	x2, x2, #0xc1
40002f34: 7100051f     	cmp	w8, #0x1
40002f38: 1a9f17e3     	cset	w3, eq
40002f3c: 940000de     	bl	0x400032b4 <draw_box>
40002f40: 52800075     	mov	w21, #0x3               // =3
40002f44: aa1603e0     	mov	x0, x22
40002f48: 2a1503e1     	mov	w1, w21
40002f4c: 52800562     	mov	w2, #0x2b               // =43
40002f50: 940002ee     	bl	0x40003b08 <uart_printf>
40002f54: aa1703e0     	mov	x0, x23
40002f58: 940001d7     	bl	0x400036b4 <uart_puts>
40002f5c: aa1703e0     	mov	x0, x23
40002f60: 940001d5     	bl	0x400036b4 <uart_puts>
40002f64: aa1703e0     	mov	x0, x23
40002f68: 940001d3     	bl	0x400036b4 <uart_puts>
40002f6c: aa1703e0     	mov	x0, x23
40002f70: 940001d1     	bl	0x400036b4 <uart_puts>
40002f74: aa1703e0     	mov	x0, x23
40002f78: 940001cf     	bl	0x400036b4 <uart_puts>
40002f7c: aa1703e0     	mov	x0, x23
40002f80: 940001cd     	bl	0x400036b4 <uart_puts>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 940001cb     	bl	0x400036b4 <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 940001c9     	bl	0x400036b4 <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 940001c7     	bl	0x400036b4 <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 940001c5     	bl	0x400036b4 <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 940001c3     	bl	0x400036b4 <uart_puts>
40002fac: aa1703e0     	mov	x0, x23
40002fb0: 940001c1     	bl	0x400036b4 <uart_puts>
40002fb4: aa1703e0     	mov	x0, x23
40002fb8: 940001bf     	bl	0x400036b4 <uart_puts>
40002fbc: aa1703e0     	mov	x0, x23
40002fc0: 940001bd     	bl	0x400036b4 <uart_puts>
40002fc4: aa1703e0     	mov	x0, x23
40002fc8: 940001bb     	bl	0x400036b4 <uart_puts>
40002fcc: aa1703e0     	mov	x0, x23
40002fd0: 940001b9     	bl	0x400036b4 <uart_puts>
40002fd4: aa1703e0     	mov	x0, x23
40002fd8: 940001b7     	bl	0x400036b4 <uart_puts>
40002fdc: aa1703e0     	mov	x0, x23
40002fe0: 940001b5     	bl	0x400036b4 <uart_puts>
40002fe4: aa1703e0     	mov	x0, x23
40002fe8: 940001b3     	bl	0x400036b4 <uart_puts>
40002fec: aa1703e0     	mov	x0, x23
40002ff0: 940001b1     	bl	0x400036b4 <uart_puts>
40002ff4: aa1703e0     	mov	x0, x23
40002ff8: 940001af     	bl	0x400036b4 <uart_puts>
40002ffc: aa1703e0     	mov	x0, x23
40003000: 940001ad     	bl	0x400036b4 <uart_puts>
40003004: aa1703e0     	mov	x0, x23
40003008: 940001ab     	bl	0x400036b4 <uart_puts>
4000300c: aa1703e0     	mov	x0, x23
40003010: 940001a9     	bl	0x400036b4 <uart_puts>
40003014: aa1703e0     	mov	x0, x23
40003018: 940001a7     	bl	0x400036b4 <uart_puts>
4000301c: aa1703e0     	mov	x0, x23
40003020: 940001a5     	bl	0x400036b4 <uart_puts>
40003024: aa1703e0     	mov	x0, x23
40003028: 940001a3     	bl	0x400036b4 <uart_puts>
4000302c: aa1703e0     	mov	x0, x23
40003030: 940001a1     	bl	0x400036b4 <uart_puts>
40003034: aa1703e0     	mov	x0, x23
40003038: 9400019f     	bl	0x400036b4 <uart_puts>
4000303c: aa1703e0     	mov	x0, x23
40003040: 9400019d     	bl	0x400036b4 <uart_puts>
40003044: aa1703e0     	mov	x0, x23
40003048: 9400019b     	bl	0x400036b4 <uart_puts>
4000304c: aa1703e0     	mov	x0, x23
40003050: 94000199     	bl	0x400036b4 <uart_puts>
40003054: aa1703e0     	mov	x0, x23
40003058: 94000197     	bl	0x400036b4 <uart_puts>
4000305c: aa1703e0     	mov	x0, x23
40003060: 94000195     	bl	0x400036b4 <uart_puts>
40003064: aa1703e0     	mov	x0, x23
40003068: 94000193     	bl	0x400036b4 <uart_puts>
4000306c: aa1703e0     	mov	x0, x23
40003070: 94000191     	bl	0x400036b4 <uart_puts>
40003074: 110006b5     	add	w21, w21, #0x1
40003078: 71005ebf     	cmp	w21, #0x17
4000307c: 54fff641     	b.ne	0x40002f44 <tui_launch+0x3e8>
40003080: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003084: 91165800     	add	x0, x0, #0x596
40003088: 52800061     	mov	w1, #0x3                // =3
4000308c: 52800562     	mov	w2, #0x2b               // =43
40003090: 9400029e     	bl	0x40003b08 <uart_printf>
40003094: d503201f     	nop
40003098: 10058de8     	adr	x8, 0x4000e254 <proc_table>
4000309c: aa1f03f3     	mov	x19, xzr
400030a0: 9100a115     	add	x21, x8, #0x28
400030a4: 52800058     	mov	w24, #0x2               // =2
400030a8: 90000039     	adrp	x25, 0x40007000 <__rodata_start>
400030ac: 91206f39     	add	x25, x25, #0x81b
400030b0: b85fc2a8     	ldur	w8, [x21, #-0x4]
400030b4: 71000d1f     	cmp	w8, #0x3
400030b8: 54000140     	b.eq	0x400030e0 <tui_launch+0x584>
400030bc: b94002a8     	ldr	w8, [x21]
400030c0: b85d82a3     	ldur	w3, [x21, #-0x28]
400030c4: d10092a4     	sub	x4, x21, #0x24
400030c8: 11000b01     	add	w1, w24, #0x2
400030cc: aa1403e0     	mov	x0, x20
400030d0: 52800562     	mov	w2, #0x2b               // =43
400030d4: 530a7d05     	lsr	w5, w8, #10
400030d8: 9400028c     	bl	0x40003b08 <uart_printf>
400030dc: 11000718     	add	w24, w24, #0x1
400030e0: f1003a7f     	cmp	x19, #0xe
400030e4: 540000a8     	b.hi	0x400030f8 <tui_launch+0x59c>
400030e8: 7100531f     	cmp	w24, #0x14
400030ec: 91000673     	add	x19, x19, #0x1
400030f0: 9100c2b5     	add	x21, x21, #0x30
400030f4: 54fffdeb     	b.lt	0x400030b0 <tui_launch+0x554>
400030f8: 940001a3     	bl	0x40003784 <uart_getc>
400030fc: 52801be8     	mov	w8, #0xdf               // =223
40003100: 0a080008     	and	w8, w0, w8
40003104: 7101451f     	cmp	w8, #0x51
40003108: 54000c00     	b.eq	0x40003288 <tui_launch+0x72c>
4000310c: 12001c08     	and	w8, w0, #0xff
40003110: 7100311f     	cmp	w8, #0xc
40003114: 5400010c     	b.gt	0x40003134 <tui_launch+0x5d8>
40003118: 7100251f     	cmp	w8, #0x9
4000311c: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40003120: 91260318     	add	x24, x24, #0x980
40003124: 54ffd540     	b.eq	0x40002bcc <tui_launch+0x70>
40003128: 7100291f     	cmp	w8, #0xa
4000312c: 540002e0     	b.eq	0x40003188 <tui_launch+0x62c>
40003130: 17fffeab     	b	0x40002bdc <tui_launch+0x80>
40003134: 7100351f     	cmp	w8, #0xd
40003138: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
4000313c: 91260318     	add	x24, x24, #0x980
40003140: 54000240     	b.eq	0x40003188 <tui_launch+0x62c>
40003144: 71006d1f     	cmp	w8, #0x1b
40003148: 54ffd4a1     	b.ne	0x40002bdc <tui_launch+0x80>
4000314c: 9400018e     	bl	0x40003784 <uart_getc>
40003150: 12001c13     	and	w19, w0, #0xff
40003154: 9400018c     	bl	0x40003784 <uart_getc>
40003158: 71016e7f     	cmp	w19, #0x5b
4000315c: 54ffd401     	b.ne	0x40002bdc <tui_launch+0x80>
40003160: 12001c08     	and	w8, w0, #0xff
40003164: 7101051f     	cmp	w8, #0x41
40003168: 54000781     	b.ne	0x40003258 <tui_launch+0x6fc>
4000316c: b9497388     	ldr	w8, [x28, #0x970]
40003170: 35ffd368     	cbnz	w8, 0x40002bdc <tui_launch+0x80>
40003174: b9497768     	ldr	w8, [x27, #0x974]
40003178: 71000508     	subs	w8, w8, #0x1
4000317c: 54ffd30b     	b.lt	0x40002bdc <tui_launch+0x80>
40003180: b9097768     	str	w8, [x27, #0x974]
40003184: 17fffe96     	b	0x40002bdc <tui_launch+0x80>
40003188: b9497388     	ldr	w8, [x28, #0x970]
4000318c: 35ffd288     	cbnz	w8, 0x40002bdc <tui_launch+0x80>
40003190: b9497b48     	ldr	w8, [x26, #0x978]
40003194: 7100051f     	cmp	w8, #0x1
40003198: 54ffd22b     	b.lt	0x40002bdc <tui_launch+0x80>
4000319c: b9897768     	ldrsw	x8, [x27, #0x974]
400031a0: f8687b15     	ldr	x21, [x24, x8, lsl #3]
400031a4: b4000115     	cbz	x21, 0x400031c4 <tui_launch+0x668>
400031a8: b94022a8     	ldr	w8, [x21, #0x20]
400031ac: 7100051f     	cmp	w8, #0x1
400031b0: 54000161     	b.ne	0x400031dc <tui_launch+0x680>
400031b4: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
400031b8: b909777f     	str	wzr, [x27, #0x974]
400031bc: f904b515     	str	x21, [x8, #0x968]
400031c0: 17fffe87     	b	0x40002bdc <tui_launch+0x80>
400031c4: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400031c8: b909777f     	str	wzr, [x27, #0x974]
400031cc: f944b528     	ldr	x8, [x9, #0x968]
400031d0: f9421908     	ldr	x8, [x8, #0x430]
400031d4: f904b528     	str	x8, [x9, #0x968]
400031d8: 17fffe81     	b	0x40002bdc <tui_launch+0x80>
400031dc: 390223ff     	strb	wzr, [sp, #0x88]
400031e0: aa1903e0     	mov	x0, x25
400031e4: 94000612     	bl	0x40004a2c <vfs_find>
400031e8: eb0002bf     	cmp	x21, x0
400031ec: 540001e0     	b.eq	0x40003228 <tui_launch+0x6cc>
400031f0: 910023e0     	add	x0, sp, #0x8
400031f4: 910223e1     	add	x1, sp, #0x88
400031f8: 97fffdb3     	bl	0x400028c4 <kstrcpy>
400031fc: 910223e0     	add	x0, sp, #0x88
40003200: aa1903e1     	mov	x1, x25
40003204: 97fffdb0     	bl	0x400028c4 <kstrcpy>
40003208: 910223e0     	add	x0, sp, #0x88
4000320c: aa1503e1     	mov	x1, x21
40003210: 97fffd85     	bl	0x40002824 <kstrcat>
40003214: 910223e0     	add	x0, sp, #0x88
40003218: 910023e1     	add	x1, sp, #0x8
4000321c: 97fffd82     	bl	0x40002824 <kstrcat>
40003220: f9421ab5     	ldr	x21, [x21, #0x430]
40003224: b5fffdf5     	cbnz	x21, 0x400031e0 <tui_launch+0x684>
40003228: 910223e0     	add	x0, sp, #0x88
4000322c: 97fffd77     	bl	0x40002808 <kstrlen>
40003230: b5000080     	cbnz	x0, 0x40003240 <tui_launch+0x6e4>
40003234: 910223e0     	add	x0, sp, #0x88
40003238: aa1903e1     	mov	x1, x25
4000323c: 97fffda2     	bl	0x400028c4 <kstrcpy>
40003240: 910223e0     	add	x0, sp, #0x88
40003244: 97fff420     	bl	0x400002c4 <launch_kedit>
40003248: d503201f     	nop
4000324c: 7002b160     	adr	x0, 0x4000887b <__rodata_start+0x187b>
40003250: 94000119     	bl	0x400036b4 <uart_puts>
40003254: 17fffe62     	b	0x40002bdc <tui_launch+0x80>
40003258: 7101091f     	cmp	w8, #0x42
4000325c: 54ffcc01     	b.ne	0x40002bdc <tui_launch+0x80>
40003260: b9497388     	ldr	w8, [x28, #0x970]
40003264: 35ffcbc8     	cbnz	w8, 0x40002bdc <tui_launch+0x80>
40003268: b9497b49     	ldr	w9, [x26, #0x978]
4000326c: b9497768     	ldr	w8, [x27, #0x974]
40003270: 51000529     	sub	w9, w9, #0x1
40003274: 6b09011f     	cmp	w8, w9
40003278: 54ffcb2a     	b.ge	0x40002bdc <tui_launch+0x80>
4000327c: 11000508     	add	w8, w8, #0x1
40003280: b9097768     	str	w8, [x27, #0x974]
40003284: 17fffe56     	b	0x40002bdc <tui_launch+0x80>
40003288: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000328c: 912bcc00     	add	x0, x0, #0xaf3
40003290: 94000109     	bl	0x400036b4 <uart_puts>
40003294: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003298: a95557f6     	ldp	x22, x21, [sp, #0x150]
4000329c: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400032a0: a95367fa     	ldp	x26, x25, [sp, #0x130]
400032a4: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400032a8: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400032ac: 9105c3ff     	add	sp, sp, #0x170
400032b0: d65f03c0     	ret

00000000400032b4 <draw_box>:
400032b4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400032b8: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400032bc: 911b4908     	add	x8, x8, #0x6d2
400032c0: 7100007f     	cmp	w3, #0x0
400032c4: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
400032c8: 91074929     	add	x9, x9, #0x1d2
400032cc: a9034ff4     	stp	x20, x19, [sp, #0x30]
400032d0: 2a0003f3     	mov	w19, w0
400032d4: 9a880120     	csel	x0, x9, x8, eq
400032d8: a9015ff8     	stp	x24, x23, [sp, #0x10]
400032dc: a90257f6     	stp	x22, x21, [sp, #0x20]
400032e0: 910003fd     	mov	x29, sp
400032e4: aa0203f4     	mov	x20, x2
400032e8: 2a0103f5     	mov	w21, w1
400032ec: 940000f2     	bl	0x400036b4 <uart_puts>
400032f0: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032f4: 91207400     	add	x0, x0, #0x81d
400032f8: 52800041     	mov	w1, #0x2                // =2
400032fc: 2a1303e2     	mov	w2, w19
40003300: 94000202     	bl	0x40003b08 <uart_printf>
40003304: 51000ab6     	sub	w22, w21, #0x2
40003308: 510006b7     	sub	w23, w21, #0x1
4000330c: 90000035     	adrp	x21, 0x40007000 <__rodata_start>
40003310: 91143eb5     	add	x21, x21, #0x50f
40003314: 2a1603f8     	mov	w24, w22
40003318: aa1503e0     	mov	x0, x21
4000331c: 940000e6     	bl	0x400036b4 <uart_puts>
40003320: 71000718     	subs	w24, w24, #0x1
40003324: 54ffffa1     	b.ne	0x40003318 <draw_box+0x64>
40003328: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000332c: 9126d000     	add	x0, x0, #0x9b4
40003330: 940000e1     	bl	0x400036b4 <uart_puts>
40003334: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003338: 9120a400     	add	x0, x0, #0x829
4000333c: 11000a62     	add	w2, w19, #0x2
40003340: 52800041     	mov	w1, #0x2                // =2
40003344: aa1403e3     	mov	x3, x20
40003348: 940001f0     	bl	0x40003b08 <uart_printf>
4000334c: b0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40003350: 91142a94     	add	x20, x20, #0x50a
40003354: 52800061     	mov	w1, #0x3                // =3
40003358: aa1403e0     	mov	x0, x20
4000335c: 2a1303e2     	mov	w2, w19
40003360: 940001ea     	bl	0x40003b08 <uart_printf>
40003364: 0b1302e2     	add	w2, w23, w19
40003368: aa1403e0     	mov	x0, x20
4000336c: 52800061     	mov	w1, #0x3                // =3
40003370: 940001e6     	bl	0x40003b08 <uart_printf>
40003374: aa1403e0     	mov	x0, x20
40003378: 52800081     	mov	w1, #0x4                // =4
4000337c: 2a1303e2     	mov	w2, w19
40003380: 940001e2     	bl	0x40003b08 <uart_printf>
40003384: 0b1302e2     	add	w2, w23, w19
40003388: aa1403e0     	mov	x0, x20
4000338c: 52800081     	mov	w1, #0x4                // =4
40003390: 940001de     	bl	0x40003b08 <uart_printf>
40003394: aa1403e0     	mov	x0, x20
40003398: 528000a1     	mov	w1, #0x5                // =5
4000339c: 2a1303e2     	mov	w2, w19
400033a0: 940001da     	bl	0x40003b08 <uart_printf>
400033a4: 0b1302e2     	add	w2, w23, w19
400033a8: aa1403e0     	mov	x0, x20
400033ac: 528000a1     	mov	w1, #0x5                // =5
400033b0: 940001d6     	bl	0x40003b08 <uart_printf>
400033b4: aa1403e0     	mov	x0, x20
400033b8: 528000c1     	mov	w1, #0x6                // =6
400033bc: 2a1303e2     	mov	w2, w19
400033c0: 940001d2     	bl	0x40003b08 <uart_printf>
400033c4: 0b1302e2     	add	w2, w23, w19
400033c8: aa1403e0     	mov	x0, x20
400033cc: 528000c1     	mov	w1, #0x6                // =6
400033d0: 940001ce     	bl	0x40003b08 <uart_printf>
400033d4: aa1403e0     	mov	x0, x20
400033d8: 528000e1     	mov	w1, #0x7                // =7
400033dc: 2a1303e2     	mov	w2, w19
400033e0: 940001ca     	bl	0x40003b08 <uart_printf>
400033e4: 0b1302e2     	add	w2, w23, w19
400033e8: aa1403e0     	mov	x0, x20
400033ec: 528000e1     	mov	w1, #0x7                // =7
400033f0: 940001c6     	bl	0x40003b08 <uart_printf>
400033f4: aa1403e0     	mov	x0, x20
400033f8: 52800101     	mov	w1, #0x8                // =8
400033fc: 2a1303e2     	mov	w2, w19
40003400: 940001c2     	bl	0x40003b08 <uart_printf>
40003404: 0b1302e2     	add	w2, w23, w19
40003408: aa1403e0     	mov	x0, x20
4000340c: 52800101     	mov	w1, #0x8                // =8
40003410: 940001be     	bl	0x40003b08 <uart_printf>
40003414: aa1403e0     	mov	x0, x20
40003418: 52800121     	mov	w1, #0x9                // =9
4000341c: 2a1303e2     	mov	w2, w19
40003420: 940001ba     	bl	0x40003b08 <uart_printf>
40003424: 0b1302e2     	add	w2, w23, w19
40003428: aa1403e0     	mov	x0, x20
4000342c: 52800121     	mov	w1, #0x9                // =9
40003430: 940001b6     	bl	0x40003b08 <uart_printf>
40003434: aa1403e0     	mov	x0, x20
40003438: 52800141     	mov	w1, #0xa                // =10
4000343c: 2a1303e2     	mov	w2, w19
40003440: 940001b2     	bl	0x40003b08 <uart_printf>
40003444: 0b1302e2     	add	w2, w23, w19
40003448: aa1403e0     	mov	x0, x20
4000344c: 52800141     	mov	w1, #0xa                // =10
40003450: 940001ae     	bl	0x40003b08 <uart_printf>
40003454: aa1403e0     	mov	x0, x20
40003458: 52800161     	mov	w1, #0xb                // =11
4000345c: 2a1303e2     	mov	w2, w19
40003460: 940001aa     	bl	0x40003b08 <uart_printf>
40003464: 0b1302e2     	add	w2, w23, w19
40003468: aa1403e0     	mov	x0, x20
4000346c: 52800161     	mov	w1, #0xb                // =11
40003470: 940001a6     	bl	0x40003b08 <uart_printf>
40003474: aa1403e0     	mov	x0, x20
40003478: 52800181     	mov	w1, #0xc                // =12
4000347c: 2a1303e2     	mov	w2, w19
40003480: 940001a2     	bl	0x40003b08 <uart_printf>
40003484: 0b1302e2     	add	w2, w23, w19
40003488: aa1403e0     	mov	x0, x20
4000348c: 52800181     	mov	w1, #0xc                // =12
40003490: 9400019e     	bl	0x40003b08 <uart_printf>
40003494: aa1403e0     	mov	x0, x20
40003498: 528001a1     	mov	w1, #0xd                // =13
4000349c: 2a1303e2     	mov	w2, w19
400034a0: 9400019a     	bl	0x40003b08 <uart_printf>
400034a4: 0b1302e2     	add	w2, w23, w19
400034a8: aa1403e0     	mov	x0, x20
400034ac: 528001a1     	mov	w1, #0xd                // =13
400034b0: 94000196     	bl	0x40003b08 <uart_printf>
400034b4: aa1403e0     	mov	x0, x20
400034b8: 528001c1     	mov	w1, #0xe                // =14
400034bc: 2a1303e2     	mov	w2, w19
400034c0: 94000192     	bl	0x40003b08 <uart_printf>
400034c4: 0b1302e2     	add	w2, w23, w19
400034c8: aa1403e0     	mov	x0, x20
400034cc: 528001c1     	mov	w1, #0xe                // =14
400034d0: 9400018e     	bl	0x40003b08 <uart_printf>
400034d4: aa1403e0     	mov	x0, x20
400034d8: 528001e1     	mov	w1, #0xf                // =15
400034dc: 2a1303e2     	mov	w2, w19
400034e0: 9400018a     	bl	0x40003b08 <uart_printf>
400034e4: 0b1302e2     	add	w2, w23, w19
400034e8: aa1403e0     	mov	x0, x20
400034ec: 528001e1     	mov	w1, #0xf                // =15
400034f0: 94000186     	bl	0x40003b08 <uart_printf>
400034f4: aa1403e0     	mov	x0, x20
400034f8: 52800201     	mov	w1, #0x10               // =16
400034fc: 2a1303e2     	mov	w2, w19
40003500: 94000182     	bl	0x40003b08 <uart_printf>
40003504: 0b1302e2     	add	w2, w23, w19
40003508: aa1403e0     	mov	x0, x20
4000350c: 52800201     	mov	w1, #0x10               // =16
40003510: 9400017e     	bl	0x40003b08 <uart_printf>
40003514: aa1403e0     	mov	x0, x20
40003518: 52800221     	mov	w1, #0x11               // =17
4000351c: 2a1303e2     	mov	w2, w19
40003520: 9400017a     	bl	0x40003b08 <uart_printf>
40003524: 0b1302e2     	add	w2, w23, w19
40003528: aa1403e0     	mov	x0, x20
4000352c: 52800221     	mov	w1, #0x11               // =17
40003530: 94000176     	bl	0x40003b08 <uart_printf>
40003534: aa1403e0     	mov	x0, x20
40003538: 52800241     	mov	w1, #0x12               // =18
4000353c: 2a1303e2     	mov	w2, w19
40003540: 94000172     	bl	0x40003b08 <uart_printf>
40003544: 0b1302e2     	add	w2, w23, w19
40003548: aa1403e0     	mov	x0, x20
4000354c: 52800241     	mov	w1, #0x12               // =18
40003550: 9400016e     	bl	0x40003b08 <uart_printf>
40003554: aa1403e0     	mov	x0, x20
40003558: 52800261     	mov	w1, #0x13               // =19
4000355c: 2a1303e2     	mov	w2, w19
40003560: 9400016a     	bl	0x40003b08 <uart_printf>
40003564: 0b1302e2     	add	w2, w23, w19
40003568: aa1403e0     	mov	x0, x20
4000356c: 52800261     	mov	w1, #0x13               // =19
40003570: 94000166     	bl	0x40003b08 <uart_printf>
40003574: aa1403e0     	mov	x0, x20
40003578: 52800281     	mov	w1, #0x14               // =20
4000357c: 2a1303e2     	mov	w2, w19
40003580: 94000162     	bl	0x40003b08 <uart_printf>
40003584: 0b1302e2     	add	w2, w23, w19
40003588: aa1403e0     	mov	x0, x20
4000358c: 52800281     	mov	w1, #0x14               // =20
40003590: 9400015e     	bl	0x40003b08 <uart_printf>
40003594: aa1403e0     	mov	x0, x20
40003598: 528002a1     	mov	w1, #0x15               // =21
4000359c: 2a1303e2     	mov	w2, w19
400035a0: 9400015a     	bl	0x40003b08 <uart_printf>
400035a4: 0b1302e2     	add	w2, w23, w19
400035a8: aa1403e0     	mov	x0, x20
400035ac: 528002a1     	mov	w1, #0x15               // =21
400035b0: 94000156     	bl	0x40003b08 <uart_printf>
400035b4: aa1403e0     	mov	x0, x20
400035b8: 528002c1     	mov	w1, #0x16               // =22
400035bc: 2a1303e2     	mov	w2, w19
400035c0: 94000152     	bl	0x40003b08 <uart_printf>
400035c4: 0b1302e2     	add	w2, w23, w19
400035c8: aa1403e0     	mov	x0, x20
400035cc: 528002c1     	mov	w1, #0x16               // =22
400035d0: 9400014e     	bl	0x40003b08 <uart_printf>
400035d4: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400035d8: 91161800     	add	x0, x0, #0x586
400035dc: 528002e1     	mov	w1, #0x17               // =23
400035e0: 2a1303e2     	mov	w2, w19
400035e4: 94000149     	bl	0x40003b08 <uart_printf>
400035e8: 90000033     	adrp	x19, 0x40007000 <__rodata_start>
400035ec: 91143e73     	add	x19, x19, #0x50f
400035f0: aa1303e0     	mov	x0, x19
400035f4: 94000030     	bl	0x400036b4 <uart_puts>
400035f8: 710006d6     	subs	w22, w22, #0x1
400035fc: 54ffffa1     	b.ne	0x400035f0 <draw_box+0x33c>
40003600: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003604: 91164800     	add	x0, x0, #0x592
40003608: 9400002b     	bl	0x400036b4 <uart_puts>
4000360c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003610: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40003614: 912ce800     	add	x0, x0, #0xb3a
40003618: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000361c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003620: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003624: 14000024     	b	0x400036b4 <uart_puts>

0000000040003628 <uart_init>:
40003628: 52800608     	mov	w8, #0x30               // =48
4000362c: 528001a9     	mov	w9, #0xd                // =13
40003630: 5280002a     	mov	w10, #0x1               // =1
40003634: 72a12008     	movk	w8, #0x900, lsl #16
40003638: b900011f     	str	wzr, [x8]
4000363c: b81f4109     	stur	w9, [x8, #-0xc]
40003640: 52800e09     	mov	w9, #0x70               // =112
40003644: b81f810a     	stur	w10, [x8, #-0x8]
40003648: b81fc109     	stur	w9, [x8, #-0x4]
4000364c: 52806029     	mov	w9, #0x301              // =769
40003650: b9000109     	str	w9, [x8]
40003654: d65f03c0     	ret

0000000040003658 <uart_putc>:
40003658: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
4000365c: b94b8108     	ldr	w8, [x8, #0xb80]
40003660: 340001a8     	cbz	w8, 0x40003694 <uart_putc+0x3c>
40003664: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003668: 5287ffca     	mov	w10, #0x3ffe            // =16382
4000366c: b94b8509     	ldr	w9, [x8, #0xb84]
40003670: 6b0a013f     	cmp	w9, w10
40003674: 5400010c     	b.gt	0x40003694 <uart_putc+0x3c>
40003678: 93407d29     	sxtw	x9, w9
4000367c: d503201f     	nop
40003680: 1006284a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
40003684: 9100052b     	add	x11, x9, #0x1
40003688: 38296940     	strb	w0, [x10, x9]
4000368c: b90b850b     	str	w11, [x8, #0xb84]
40003690: 382b695f     	strb	wzr, [x10, x11]
40003694: 52800308     	mov	w8, #0x18               // =24
40003698: 72a12008     	movk	w8, #0x900, lsl #16
4000369c: b9400109     	ldr	w9, [x8]
400036a0: 372fffe9     	tbnz	w9, #0x5, 0x4000369c <uart_putc+0x44>
400036a4: 12001c08     	and	w8, w0, #0xff
400036a8: 52a12009     	mov	w9, #0x9000000          // =150994944
400036ac: b9000128     	str	w8, [x9]
400036b0: d65f03c0     	ret

00000000400036b4 <uart_puts>:
400036b4: 52800308     	mov	w8, #0x18               // =24
400036b8: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400036bc: 9000006a     	adrp	x10, 0x4000f000 <var_values+0x6a8>
400036c0: 72a12008     	movk	w8, #0x900, lsl #16
400036c4: d503201f     	nop
400036c8: 1006260b     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
400036cc: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400036d0: 528001ad     	mov	w13, #0xd               // =13
400036d4: 52a1200e     	mov	w14, #0x9000000         // =150994944
400036d8: 3940000f     	ldrb	w15, [x0]
400036dc: 710029ff     	cmp	w15, #0xa
400036e0: 540000a0     	b.eq	0x400036f4 <uart_puts+0x40>
400036e4: 3400042f     	cbz	w15, 0x40003768 <uart_puts+0xb4>
400036e8: b94b8130     	ldr	w16, [x9, #0xb80]
400036ec: 35000250     	cbnz	w16, 0x40003734 <uart_puts+0x80>
400036f0: 14000019     	b	0x40003754 <uart_puts+0xa0>
400036f4: b94b812f     	ldr	w15, [x9, #0xb80]
400036f8: 3400012f     	cbz	w15, 0x4000371c <uart_puts+0x68>
400036fc: b94b854f     	ldr	w15, [x10, #0xb84]
40003700: 6b0c01ff     	cmp	w15, w12
40003704: 540000cc     	b.gt	0x4000371c <uart_puts+0x68>
40003708: 93407def     	sxtw	x15, w15
4000370c: 910005f0     	add	x16, x15, #0x1
40003710: 382f696d     	strb	w13, [x11, x15]
40003714: b90b8550     	str	w16, [x10, #0xb84]
40003718: 3830697f     	strb	wzr, [x11, x16]
4000371c: b940010f     	ldr	w15, [x8]
40003720: 372fffef     	tbnz	w15, #0x5, 0x4000371c <uart_puts+0x68>
40003724: b90001cd     	str	w13, [x14]
40003728: 3940000f     	ldrb	w15, [x0]
4000372c: b94b8130     	ldr	w16, [x9, #0xb80]
40003730: 34000130     	cbz	w16, 0x40003754 <uart_puts+0xa0>
40003734: b94b8550     	ldr	w16, [x10, #0xb84]
40003738: 6b0c021f     	cmp	w16, w12
4000373c: 540000cc     	b.gt	0x40003754 <uart_puts+0xa0>
40003740: 93407e10     	sxtw	x16, w16
40003744: 91000611     	add	x17, x16, #0x1
40003748: 3830696f     	strb	w15, [x11, x16]
4000374c: b90b8551     	str	w17, [x10, #0xb84]
40003750: 3831697f     	strb	wzr, [x11, x17]
40003754: 91000400     	add	x0, x0, #0x1
40003758: b9400110     	ldr	w16, [x8]
4000375c: 372ffff0     	tbnz	w16, #0x5, 0x40003758 <uart_puts+0xa4>
40003760: b90001cf     	str	w15, [x14]
40003764: 17ffffdd     	b	0x400036d8 <uart_puts+0x24>
40003768: d65f03c0     	ret

000000004000376c <uart_has_data>:
4000376c: 52800308     	mov	w8, #0x18               // =24
40003770: 52800029     	mov	w9, #0x1                // =1
40003774: 72a12008     	movk	w8, #0x900, lsl #16
40003778: b9400108     	ldr	w8, [x8]
4000377c: 0a681120     	bic	w0, w9, w8, lsr #4
40003780: d65f03c0     	ret

0000000040003784 <uart_getc>:
40003784: 52800308     	mov	w8, #0x18               // =24
40003788: 72a12008     	movk	w8, #0x900, lsl #16
4000378c: b9400109     	ldr	w9, [x8]
40003790: 3727ffe9     	tbnz	w9, #0x4, 0x4000378c <uart_getc+0x8>
40003794: 52a12008     	mov	w8, #0x9000000          // =150994944
40003798: b9400100     	ldr	w0, [x8]
4000379c: d65f03c0     	ret

00000000400037a0 <uart_print_hex_raw>:
400037a0: 52800308     	mov	w8, #0x18               // =24
400037a4: 2a1f03eb     	mov	w11, wzr
400037a8: 5280078c     	mov	w12, #0x3c              // =60
400037ac: 72a12008     	movk	w8, #0x900, lsl #16
400037b0: d503201f     	nop
400037b4: 1001e7ce     	adr	x14, 0x400074ac <__rodata_start+0x4ac>
400037b8: 9000006d     	adrp	x13, 0x4000f000 <var_values+0x6a8>
400037bc: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400037c0: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037c4: d503201f     	nop
400037c8: 10061e0a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
400037cc: 52a12010     	mov	w16, #0x9000000         // =150994944
400037d0: 14000003     	b	0x400037dc <uart_print_hex_raw+0x3c>
400037d4: b400032c     	cbz	x12, 0x40003838 <uart_print_hex_raw+0x98>
400037d8: d100118c     	sub	x12, x12, #0x4
400037dc: 9acc2411     	lsr	x17, x0, x12
400037e0: 53027d92     	lsr	w18, w12, #2
400037e4: 92400e31     	and	x17, x17, #0xf
400037e8: 6b01025f     	cmp	w18, w1
400037ec: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
400037f0: 1a9f056b     	csinc	w11, w11, wzr, eq
400037f4: 34ffff0b     	cbz	w11, 0x400037d4 <uart_print_hex_raw+0x34>
400037f8: b94b81b2     	ldr	w18, [x13, #0xb80]
400037fc: 387169d1     	ldrb	w17, [x14, x17]
40003800: 34000132     	cbz	w18, 0x40003824 <uart_print_hex_raw+0x84>
40003804: b94b8532     	ldr	w18, [x9, #0xb84]
40003808: 6b0f025f     	cmp	w18, w15
4000380c: 540000cc     	b.gt	0x40003824 <uart_print_hex_raw+0x84>
40003810: 93407e52     	sxtw	x18, w18
40003814: 91000642     	add	x2, x18, #0x1
40003818: 38326951     	strb	w17, [x10, x18]
4000381c: b90b8522     	str	w2, [x9, #0xb84]
40003820: 3822695f     	strb	wzr, [x10, x2]
40003824: b9400112     	ldr	w18, [x8]
40003828: 372ffff2     	tbnz	w18, #0x5, 0x40003824 <uart_print_hex_raw+0x84>
4000382c: b9000211     	str	w17, [x16]
40003830: b5fffd4c     	cbnz	x12, 0x400037d8 <uart_print_hex_raw+0x38>
40003834: d65f03c0     	ret
40003838: b94b81ab     	ldr	w11, [x13, #0xb80]
4000383c: 3400016b     	cbz	w11, 0x40003868 <uart_print_hex_raw+0xc8>
40003840: b94b852b     	ldr	w11, [x9, #0xb84]
40003844: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003848: 6b0c017f     	cmp	w11, w12
4000384c: 540000ec     	b.gt	0x40003868 <uart_print_hex_raw+0xc8>
40003850: 93407d6b     	sxtw	x11, w11
40003854: 5280060c     	mov	w12, #0x30              // =48
40003858: 9100056d     	add	x13, x11, #0x1
4000385c: 382b694c     	strb	w12, [x10, x11]
40003860: b90b852d     	str	w13, [x9, #0xb84]
40003864: 382d695f     	strb	wzr, [x10, x13]
40003868: b9400109     	ldr	w9, [x8]
4000386c: 372fffe9     	tbnz	w9, #0x5, 0x40003868 <uart_print_hex_raw+0xc8>
40003870: 52a12008     	mov	w8, #0x9000000          // =150994944
40003874: 52800609     	mov	w9, #0x30               // =48
40003878: b9000109     	str	w9, [x8]
4000387c: d65f03c0     	ret

0000000040003880 <uart_print_hex>:
40003880: 52800308     	mov	w8, #0x18               // =24
40003884: b000002c     	adrp	x12, 0x40008000 <__rodata_start+0x1000>
40003888: 9103398c     	add	x12, x12, #0xce
4000388c: 72a12008     	movk	w8, #0x900, lsl #16
40003890: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003894: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003898: d503201f     	nop
4000389c: 1006176a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
400038a0: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038a4: 528001ae     	mov	w14, #0xd               // =13
400038a8: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038ac: 39400190     	ldrb	w16, [x12]
400038b0: 71002a1f     	cmp	w16, #0xa
400038b4: 540000a0     	b.eq	0x400038c8 <uart_print_hex+0x48>
400038b8: 34000410     	cbz	w16, 0x40003938 <uart_print_hex+0xb8>
400038bc: b94b8171     	ldr	w17, [x11, #0xb80]
400038c0: 35000231     	cbnz	w17, 0x40003904 <uart_print_hex+0x84>
400038c4: 14000018     	b	0x40003924 <uart_print_hex+0xa4>
400038c8: b94b8171     	ldr	w17, [x11, #0xb80]
400038cc: 34000131     	cbz	w17, 0x400038f0 <uart_print_hex+0x70>
400038d0: b94b8531     	ldr	w17, [x9, #0xb84]
400038d4: 6b0d023f     	cmp	w17, w13
400038d8: 540000cc     	b.gt	0x400038f0 <uart_print_hex+0x70>
400038dc: 93407e31     	sxtw	x17, w17
400038e0: 91000632     	add	x18, x17, #0x1
400038e4: 3831694e     	strb	w14, [x10, x17]
400038e8: b90b8532     	str	w18, [x9, #0xb84]
400038ec: 3832695f     	strb	wzr, [x10, x18]
400038f0: b9400111     	ldr	w17, [x8]
400038f4: 372ffff1     	tbnz	w17, #0x5, 0x400038f0 <uart_print_hex+0x70>
400038f8: b90001ee     	str	w14, [x15]
400038fc: b94b8171     	ldr	w17, [x11, #0xb80]
40003900: 34000131     	cbz	w17, 0x40003924 <uart_print_hex+0xa4>
40003904: b94b8531     	ldr	w17, [x9, #0xb84]
40003908: 6b0d023f     	cmp	w17, w13
4000390c: 540000cc     	b.gt	0x40003924 <uart_print_hex+0xa4>
40003910: 93407e31     	sxtw	x17, w17
40003914: 91000632     	add	x18, x17, #0x1
40003918: 38316950     	strb	w16, [x10, x17]
4000391c: b90b8532     	str	w18, [x9, #0xb84]
40003920: 3832695f     	strb	wzr, [x10, x18]
40003924: 9100058c     	add	x12, x12, #0x1
40003928: b9400111     	ldr	w17, [x8]
4000392c: 372ffff1     	tbnz	w17, #0x5, 0x40003928 <uart_print_hex+0xa8>
40003930: b90001f0     	str	w16, [x15]
40003934: 17ffffde     	b	0x400038ac <uart_print_hex+0x2c>
40003938: 2a1f03ec     	mov	w12, wzr
4000393c: d503201f     	nop
40003940: 1001db6d     	adr	x13, 0x400074ac <__rodata_start+0x4ac>
40003944: 5280078e     	mov	w14, #0x3c              // =60
40003948: 5287ffcf     	mov	w15, #0x3ffe            // =16382
4000394c: 52a12010     	mov	w16, #0x9000000         // =150994944
40003950: 14000003     	b	0x4000395c <uart_print_hex+0xdc>
40003954: b40002ee     	cbz	x14, 0x400039b0 <uart_print_hex+0x130>
40003958: d10011ce     	sub	x14, x14, #0x4
4000395c: 9ace2411     	lsr	x17, x0, x14
40003960: f2400e31     	ands	x17, x17, #0xf
40003964: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003968: 1a9f158c     	csinc	w12, w12, wzr, ne
4000396c: 34ffff4c     	cbz	w12, 0x40003954 <uart_print_hex+0xd4>
40003970: b94b8172     	ldr	w18, [x11, #0xb80]
40003974: 387169b1     	ldrb	w17, [x13, x17]
40003978: 34000132     	cbz	w18, 0x4000399c <uart_print_hex+0x11c>
4000397c: b94b8532     	ldr	w18, [x9, #0xb84]
40003980: 6b0f025f     	cmp	w18, w15
40003984: 540000cc     	b.gt	0x4000399c <uart_print_hex+0x11c>
40003988: 93407e52     	sxtw	x18, w18
4000398c: 91000641     	add	x1, x18, #0x1
40003990: 38326951     	strb	w17, [x10, x18]
40003994: b90b8521     	str	w1, [x9, #0xb84]
40003998: 3821695f     	strb	wzr, [x10, x1]
4000399c: b9400112     	ldr	w18, [x8]
400039a0: 372ffff2     	tbnz	w18, #0x5, 0x4000399c <uart_print_hex+0x11c>
400039a4: b9000211     	str	w17, [x16]
400039a8: b5fffd8e     	cbnz	x14, 0x40003958 <uart_print_hex+0xd8>
400039ac: d65f03c0     	ret
400039b0: b94b816b     	ldr	w11, [x11, #0xb80]
400039b4: 3400016b     	cbz	w11, 0x400039e0 <uart_print_hex+0x160>
400039b8: b94b852b     	ldr	w11, [x9, #0xb84]
400039bc: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039c0: 6b0c017f     	cmp	w11, w12
400039c4: 540000ec     	b.gt	0x400039e0 <uart_print_hex+0x160>
400039c8: 93407d6b     	sxtw	x11, w11
400039cc: 5280060c     	mov	w12, #0x30              // =48
400039d0: 9100056d     	add	x13, x11, #0x1
400039d4: 382b694c     	strb	w12, [x10, x11]
400039d8: b90b852d     	str	w13, [x9, #0xb84]
400039dc: 382d695f     	strb	wzr, [x10, x13]
400039e0: b9400109     	ldr	w9, [x8]
400039e4: 372fffe9     	tbnz	w9, #0x5, 0x400039e0 <uart_print_hex+0x160>
400039e8: 52a12008     	mov	w8, #0x9000000          // =150994944
400039ec: 52800609     	mov	w9, #0x30               // =48
400039f0: b9000109     	str	w9, [x8]
400039f4: d65f03c0     	ret

00000000400039f8 <uart_print_dec>:
400039f8: d10083ff     	sub	sp, sp, #0x20
400039fc: 52800308     	mov	w8, #0x18               // =24
40003a00: 72a12008     	movk	w8, #0x900, lsl #16
40003a04: b4000540     	cbz	x0, 0x40003aac <uart_print_dec+0xb4>
40003a08: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003a0c: aa1f03e9     	mov	x9, xzr
40003a10: 5280014b     	mov	w11, #0xa               // =10
40003a14: f29999aa     	movk	x10, #0xcccd
40003a18: 910023ec     	add	x12, sp, #0x8
40003a1c: 9bca7c0d     	umulh	x13, x0, x10
40003a20: f100241f     	cmp	x0, #0x9
40003a24: d343fdad     	lsr	x13, x13, #3
40003a28: 1b0b81ae     	msub	w14, w13, w11, w0
40003a2c: aa0d03e0     	mov	x0, x13
40003a30: 321c05ce     	orr	w14, w14, #0x30
40003a34: 3829698e     	strb	w14, [x12, x9]
40003a38: 91000529     	add	x9, x9, #0x1
40003a3c: 54ffff08     	b.hi	0x40003a1c <uart_print_dec+0x24>
40003a40: 910023ea     	add	x10, sp, #0x8
40003a44: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003a48: 9000006c     	adrp	x12, 0x4000f000 <var_values+0x6a8>
40003a4c: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a50: d503201f     	nop
40003a54: 100609ae     	adr	x14, 0x4000fb88 <kernel_capture_buffer>
40003a58: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a5c: d1000530     	sub	x16, x9, #0x1
40003a60: b94b8172     	ldr	w18, [x11, #0xb80]
40003a64: 38706951     	ldrb	w17, [x10, x16]
40003a68: 34000132     	cbz	w18, 0x40003a8c <uart_print_dec+0x94>
40003a6c: b94b8592     	ldr	w18, [x12, #0xb84]
40003a70: 6b0d025f     	cmp	w18, w13
40003a74: 540000cc     	b.gt	0x40003a8c <uart_print_dec+0x94>
40003a78: 93407e52     	sxtw	x18, w18
40003a7c: 91000640     	add	x0, x18, #0x1
40003a80: 383269d1     	strb	w17, [x14, x18]
40003a84: b90b8580     	str	w0, [x12, #0xb84]
40003a88: 382069df     	strb	wzr, [x14, x0]
40003a8c: b9400112     	ldr	w18, [x8]
40003a90: 372ffff2     	tbnz	w18, #0x5, 0x40003a8c <uart_print_dec+0x94>
40003a94: 7100053f     	cmp	w9, #0x1
40003a98: aa1003e9     	mov	x9, x16
40003a9c: b90001f1     	str	w17, [x15]
40003aa0: 54fffdec     	b.gt	0x40003a5c <uart_print_dec+0x64>
40003aa4: 910083ff     	add	sp, sp, #0x20
40003aa8: d65f03c0     	ret
40003aac: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003ab0: b94b8129     	ldr	w9, [x9, #0xb80]
40003ab4: 340001c9     	cbz	w9, 0x40003aec <uart_print_dec+0xf4>
40003ab8: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003abc: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003ac0: b94b852a     	ldr	w10, [x9, #0xb84]
40003ac4: 6b0b015f     	cmp	w10, w11
40003ac8: 5400012c     	b.gt	0x40003aec <uart_print_dec+0xf4>
40003acc: 93407d4a     	sxtw	x10, w10
40003ad0: d503201f     	nop
40003ad4: 100605ab     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
40003ad8: 5280060c     	mov	w12, #0x30              // =48
40003adc: 9100054d     	add	x13, x10, #0x1
40003ae0: 382a696c     	strb	w12, [x11, x10]
40003ae4: b90b852d     	str	w13, [x9, #0xb84]
40003ae8: 382d697f     	strb	wzr, [x11, x13]
40003aec: b9400109     	ldr	w9, [x8]
40003af0: 372fffe9     	tbnz	w9, #0x5, 0x40003aec <uart_print_dec+0xf4>
40003af4: 52a12008     	mov	w8, #0x9000000          // =150994944
40003af8: 52800609     	mov	w9, #0x30               // =48
40003afc: b9000109     	str	w9, [x8]
40003b00: 910083ff     	add	sp, sp, #0x20
40003b04: d65f03c0     	ret

0000000040003b08 <uart_printf>:
40003b08: d10343ff     	sub	sp, sp, #0xd0
40003b0c: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003b10: 9101c3fd     	add	x29, sp, #0x70
40003b14: 910003e8     	mov	x8, sp
40003b18: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003b1c: 52800315     	mov	w21, #0x18              // =24
40003b20: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003b24: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003b28: 72a12015     	movk	w21, #0x900, lsl #16
40003b2c: 128006e9     	mov	w9, #-0x38              // =-56
40003b30: a90967fa     	stp	x26, x25, [sp, #0x90]
40003b34: 9100e108     	add	x8, x8, #0x38
40003b38: 910183aa     	add	x10, x29, #0x60
40003b3c: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003b40: 90000076     	adrp	x22, 0x4000f000 <var_values+0x6a8>
40003b44: 90000077     	adrp	x23, 0x4000f000 <var_values+0x6a8>
40003b48: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003b4c: aa0003f3     	mov	x19, x0
40003b50: aa1f03f4     	mov	x20, xzr
40003b54: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003b58: d503201f     	nop
40003b5c: 10060179     	adr	x25, 0x4000fb88 <kernel_capture_buffer>
40003b60: 528001ba     	mov	w26, #0xd               // =13
40003b64: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b68: 528004ae     	mov	w14, #0x25              // =37
40003b6c: f29999af     	movk	x15, #0xcccd
40003b70: 52800150     	mov	w16, #0xa               // =10
40003b74: d10063bc     	sub	x28, x29, #0x18
40003b78: d503201f     	nop
40003b7c: 1001c991     	adr	x17, 0x400074ac <__rodata_start+0x4ac>
40003b80: a9000be1     	stp	x1, x2, [sp]
40003b84: a90113e3     	stp	x3, x4, [sp, #0x10]
40003b88: a9021be5     	stp	x5, x6, [sp, #0x20]
40003b8c: f9002be9     	str	x9, [sp, #0x50]
40003b90: f90023e8     	str	x8, [sp, #0x40]
40003b94: a9032be7     	stp	x7, x10, [sp, #0x30]
40003b98: 14000004     	b	0x40003ba8 <uart_printf+0xa0>
40003b9c: 52800608     	mov	w8, #0x30               // =48
40003ba0: b9000368     	str	w8, [x27]
40003ba4: 91000694     	add	x20, x20, #0x1
40003ba8: 38746a68     	ldrb	w8, [x19, x20]
40003bac: 7100291f     	cmp	w8, #0xa
40003bb0: 54000440     	b.eq	0x40003c38 <uart_printf+0x130>
40003bb4: 7100951f     	cmp	w8, #0x25
40003bb8: 540000a0     	b.eq	0x40003bcc <uart_printf+0xc4>
40003bbc: 34003ae8     	cbz	w8, 0x40004318 <uart_printf+0x810>
40003bc0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003bc4: 350005a9     	cbnz	w9, 0x40003c78 <uart_printf+0x170>
40003bc8: 14000034     	b	0x40003c98 <uart_printf+0x190>
40003bcc: 9100068a     	add	x10, x20, #0x1
40003bd0: 386a6a68     	ldrb	w8, [x19, x10]
40003bd4: 7101b11f     	cmp	w8, #0x6c
40003bd8: 54000661     	b.ne	0x40003ca4 <uart_printf+0x19c>
40003bdc: 91000a89     	add	x9, x20, #0x2
40003be0: 91000e8b     	add	x11, x20, #0x3
40003be4: 38696a6a     	ldrb	w10, [x19, x9]
40003be8: 7101b15f     	cmp	w10, #0x6c
40003bec: 9a890174     	csel	x20, x11, x9, eq
40003bf0: 38746a69     	ldrb	w9, [x19, x20]
40003bf4: 7101bd3f     	cmp	w9, #0x6f
40003bf8: 540005ed     	b.le	0x40003cb4 <uart_printf+0x1ac>
40003bfc: 7101d13f     	cmp	w9, #0x74
40003c00: 5400080c     	b.gt	0x40003d00 <uart_printf+0x1f8>
40003c04: 7101c13f     	cmp	w9, #0x70
40003c08: 54000f00     	b.eq	0x40003de8 <uart_printf+0x2e0>
40003c0c: 7101cd3f     	cmp	w9, #0x73
40003c10: 54000b61     	b.ne	0x40003d7c <uart_printf+0x274>
40003c14: b98053e8     	ldrsw	x8, [sp, #0x50]
40003c18: 36f81408     	tbz	w8, #0x1f, 0x40003e98 <uart_printf+0x390>
40003c1c: 11002109     	add	w9, w8, #0x8
40003c20: 3100211f     	cmn	w8, #0x8
40003c24: b90053e9     	str	w9, [sp, #0x50]
40003c28: 54001388     	b.hi	0x40003e98 <uart_printf+0x390>
40003c2c: f94023e9     	ldr	x9, [sp, #0x40]
40003c30: 8b080128     	add	x8, x9, x8
40003c34: 1400009c     	b	0x40003ea4 <uart_printf+0x39c>
40003c38: b94b82c8     	ldr	w8, [x22, #0xb80]
40003c3c: 34000128     	cbz	w8, 0x40003c60 <uart_printf+0x158>
40003c40: b94b86e8     	ldr	w8, [x23, #0xb84]
40003c44: 6b18011f     	cmp	w8, w24
40003c48: 540000cc     	b.gt	0x40003c60 <uart_printf+0x158>
40003c4c: 93407d08     	sxtw	x8, w8
40003c50: 91000509     	add	x9, x8, #0x1
40003c54: 38286b3a     	strb	w26, [x25, x8]
40003c58: b90b86e9     	str	w9, [x23, #0xb84]
40003c5c: 38296b3f     	strb	wzr, [x25, x9]
40003c60: b94002a8     	ldr	w8, [x21]
40003c64: 372fffe8     	tbnz	w8, #0x5, 0x40003c60 <uart_printf+0x158>
40003c68: b900037a     	str	w26, [x27]
40003c6c: 38746a68     	ldrb	w8, [x19, x20]
40003c70: b94b82c9     	ldr	w9, [x22, #0xb80]
40003c74: 34000129     	cbz	w9, 0x40003c98 <uart_printf+0x190>
40003c78: b94b86e9     	ldr	w9, [x23, #0xb84]
40003c7c: 6b18013f     	cmp	w9, w24
40003c80: 540000cc     	b.gt	0x40003c98 <uart_printf+0x190>
40003c84: 93407d29     	sxtw	x9, w9
40003c88: 9100052a     	add	x10, x9, #0x1
40003c8c: 38296b28     	strb	w8, [x25, x9]
40003c90: b90b86ea     	str	w10, [x23, #0xb84]
40003c94: 382a6b3f     	strb	wzr, [x25, x10]
40003c98: b94002a9     	ldr	w9, [x21]
40003c9c: 372fffe9     	tbnz	w9, #0x5, 0x40003c98 <uart_printf+0x190>
40003ca0: 17ffffc0     	b	0x40003ba0 <uart_printf+0x98>
40003ca4: 2a0803e9     	mov	w9, w8
40003ca8: aa0a03f4     	mov	x20, x10
40003cac: 7101bd3f     	cmp	w9, #0x6f
40003cb0: 54fffa6c     	b.gt	0x40003bfc <uart_printf+0xf4>
40003cb4: 7100953f     	cmp	w9, #0x25
40003cb8: 54000440     	b.eq	0x40003d40 <uart_printf+0x238>
40003cbc: 71018d3f     	cmp	w9, #0x63
40003cc0: 54000c00     	b.eq	0x40003e40 <uart_printf+0x338>
40003cc4: 7101913f     	cmp	w9, #0x64
40003cc8: 540005a1     	b.ne	0x40003d7c <uart_printf+0x274>
40003ccc: b98053e9     	ldrsw	x9, [sp, #0x50]
40003cd0: 7101b11f     	cmp	w8, #0x6c
40003cd4: 540017c1     	b.ne	0x40003fcc <uart_printf+0x4c4>
40003cd8: 36f823c9     	tbz	w9, #0x1f, 0x40004150 <uart_printf+0x648>
40003cdc: 11002128     	add	w8, w9, #0x8
40003ce0: 3100213f     	cmn	w9, #0x8
40003ce4: b90053e8     	str	w8, [sp, #0x50]
40003ce8: 54002348     	b.hi	0x40004150 <uart_printf+0x648>
40003cec: f94023e8     	ldr	x8, [sp, #0x40]
40003cf0: 8b090108     	add	x8, x8, x9
40003cf4: f9400108     	ldr	x8, [x8]
40003cf8: b6f829a8     	tbz	x8, #0x3f, 0x4000422c <uart_printf+0x724>
40003cfc: 1400011a     	b	0x40004164 <uart_printf+0x65c>
40003d00: 7101d53f     	cmp	w9, #0x75
40003d04: 54000840     	b.eq	0x40003e0c <uart_printf+0x304>
40003d08: 7101e13f     	cmp	w9, #0x78
40003d0c: 54000381     	b.ne	0x40003d7c <uart_printf+0x274>
40003d10: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d14: 7101b11f     	cmp	w8, #0x6c
40003d18: 540014a1     	b.ne	0x40003fac <uart_printf+0x4a4>
40003d1c: 36f81d49     	tbz	w9, #0x1f, 0x400040c4 <uart_printf+0x5bc>
40003d20: 11002128     	add	w8, w9, #0x8
40003d24: 3100213f     	cmn	w9, #0x8
40003d28: b90053e8     	str	w8, [sp, #0x50]
40003d2c: 54001cc8     	b.hi	0x400040c4 <uart_printf+0x5bc>
40003d30: f94023e8     	ldr	x8, [sp, #0x40]
40003d34: 8b090108     	add	x8, x8, x9
40003d38: f9400108     	ldr	x8, [x8]
40003d3c: 140000eb     	b	0x400040e8 <uart_printf+0x5e0>
40003d40: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d44: 34000128     	cbz	w8, 0x40003d68 <uart_printf+0x260>
40003d48: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d4c: 6b18011f     	cmp	w8, w24
40003d50: 540000cc     	b.gt	0x40003d68 <uart_printf+0x260>
40003d54: 93407d08     	sxtw	x8, w8
40003d58: 91000509     	add	x9, x8, #0x1
40003d5c: 38286b2e     	strb	w14, [x25, x8]
40003d60: b90b86e9     	str	w9, [x23, #0xb84]
40003d64: 38296b3f     	strb	wzr, [x25, x9]
40003d68: b94002a8     	ldr	w8, [x21]
40003d6c: 372fffe8     	tbnz	w8, #0x5, 0x40003d68 <uart_printf+0x260>
40003d70: b900036e     	str	w14, [x27]
40003d74: 91000694     	add	x20, x20, #0x1
40003d78: 17ffff8c     	b	0x40003ba8 <uart_printf+0xa0>
40003d7c: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d80: 34000128     	cbz	w8, 0x40003da4 <uart_printf+0x29c>
40003d84: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d88: 6b18011f     	cmp	w8, w24
40003d8c: 540000cc     	b.gt	0x40003da4 <uart_printf+0x29c>
40003d90: 93407d08     	sxtw	x8, w8
40003d94: 91000509     	add	x9, x8, #0x1
40003d98: 38286b2e     	strb	w14, [x25, x8]
40003d9c: b90b86e9     	str	w9, [x23, #0xb84]
40003da0: 38296b3f     	strb	wzr, [x25, x9]
40003da4: b94002a8     	ldr	w8, [x21]
40003da8: 372fffe8     	tbnz	w8, #0x5, 0x40003da4 <uart_printf+0x29c>
40003dac: b900036e     	str	w14, [x27]
40003db0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003db4: 38746a68     	ldrb	w8, [x19, x20]
40003db8: 34000129     	cbz	w9, 0x40003ddc <uart_printf+0x2d4>
40003dbc: b94b86e9     	ldr	w9, [x23, #0xb84]
40003dc0: 6b18013f     	cmp	w9, w24
40003dc4: 540000cc     	b.gt	0x40003ddc <uart_printf+0x2d4>
40003dc8: 93407d29     	sxtw	x9, w9
40003dcc: 9100052a     	add	x10, x9, #0x1
40003dd0: 38296b28     	strb	w8, [x25, x9]
40003dd4: b90b86ea     	str	w10, [x23, #0xb84]
40003dd8: 382a6b3f     	strb	wzr, [x25, x10]
40003ddc: b94002a9     	ldr	w9, [x21]
40003de0: 372fffe9     	tbnz	w9, #0x5, 0x40003ddc <uart_printf+0x2d4>
40003de4: 17ffff6f     	b	0x40003ba0 <uart_printf+0x98>
40003de8: b98053e8     	ldrsw	x8, [sp, #0x50]
40003dec: 36f803c8     	tbz	w8, #0x1f, 0x40003e64 <uart_printf+0x35c>
40003df0: 11002109     	add	w9, w8, #0x8
40003df4: 3100211f     	cmn	w8, #0x8
40003df8: b90053e9     	str	w9, [sp, #0x50]
40003dfc: 54000348     	b.hi	0x40003e64 <uart_printf+0x35c>
40003e00: f94023e9     	ldr	x9, [sp, #0x40]
40003e04: 8b080128     	add	x8, x9, x8
40003e08: 1400001a     	b	0x40003e70 <uart_printf+0x368>
40003e0c: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e10: 7101b11f     	cmp	w8, #0x6c
40003e14: 54000bc1     	b.ne	0x40003f8c <uart_printf+0x484>
40003e18: 36f80ea9     	tbz	w9, #0x1f, 0x40003fec <uart_printf+0x4e4>
40003e1c: 11002128     	add	w8, w9, #0x8
40003e20: 3100213f     	cmn	w9, #0x8
40003e24: b90053e8     	str	w8, [sp, #0x50]
40003e28: 54000e28     	b.hi	0x40003fec <uart_printf+0x4e4>
40003e2c: f94023e8     	ldr	x8, [sp, #0x40]
40003e30: 8b090108     	add	x8, x8, x9
40003e34: f9400109     	ldr	x9, [x8]
40003e38: b50010a9     	cbnz	x9, 0x4000404c <uart_printf+0x544>
40003e3c: 14000071     	b	0x40004000 <uart_printf+0x4f8>
40003e40: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e44: 36f80828     	tbz	w8, #0x1f, 0x40003f48 <uart_printf+0x440>
40003e48: 11002109     	add	w9, w8, #0x8
40003e4c: 3100211f     	cmn	w8, #0x8
40003e50: b90053e9     	str	w9, [sp, #0x50]
40003e54: 540007a8     	b.hi	0x40003f48 <uart_printf+0x440>
40003e58: f94023e9     	ldr	x9, [sp, #0x40]
40003e5c: 8b080128     	add	x8, x9, x8
40003e60: 1400003d     	b	0x40003f54 <uart_printf+0x44c>
40003e64: f9401fe8     	ldr	x8, [sp, #0x38]
40003e68: 91002109     	add	x9, x8, #0x8
40003e6c: f9001fe9     	str	x9, [sp, #0x38]
40003e70: f9400100     	ldr	x0, [x8]
40003e74: 97fffe83     	bl	0x40003880 <uart_print_hex>
40003e78: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003e7c: 528004ae     	mov	w14, #0x25              // =37
40003e80: 52800150     	mov	w16, #0xa               // =10
40003e84: f29999af     	movk	x15, #0xcccd
40003e88: d503201f     	nop
40003e8c: 1001b111     	adr	x17, 0x400074ac <__rodata_start+0x4ac>
40003e90: 91000694     	add	x20, x20, #0x1
40003e94: 17ffff45     	b	0x40003ba8 <uart_printf+0xa0>
40003e98: f9401fe8     	ldr	x8, [sp, #0x38]
40003e9c: 91002109     	add	x9, x8, #0x8
40003ea0: f9001fe9     	str	x9, [sp, #0x38]
40003ea4: f9400108     	ldr	x8, [x8]
40003ea8: d0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40003eac: 911b6929     	add	x9, x9, #0x6da
40003eb0: f100011f     	cmp	x8, #0x0
40003eb4: 9a880128     	csel	x8, x9, x8, eq
40003eb8: 39400109     	ldrb	w9, [x8]
40003ebc: 7100293f     	cmp	w9, #0xa
40003ec0: 540000a0     	b.eq	0x40003ed4 <uart_printf+0x3cc>
40003ec4: 34ffe709     	cbz	w9, 0x40003ba4 <uart_printf+0x9c>
40003ec8: b94b82ca     	ldr	w10, [x22, #0xb80]
40003ecc: 3500024a     	cbnz	w10, 0x40003f14 <uart_printf+0x40c>
40003ed0: 14000019     	b	0x40003f34 <uart_printf+0x42c>
40003ed4: b94b82c9     	ldr	w9, [x22, #0xb80]
40003ed8: 34000129     	cbz	w9, 0x40003efc <uart_printf+0x3f4>
40003edc: b94b86e9     	ldr	w9, [x23, #0xb84]
40003ee0: 6b18013f     	cmp	w9, w24
40003ee4: 540000cc     	b.gt	0x40003efc <uart_printf+0x3f4>
40003ee8: 93407d29     	sxtw	x9, w9
40003eec: 9100052a     	add	x10, x9, #0x1
40003ef0: 38296b3a     	strb	w26, [x25, x9]
40003ef4: b90b86ea     	str	w10, [x23, #0xb84]
40003ef8: 382a6b3f     	strb	wzr, [x25, x10]
40003efc: b94002a9     	ldr	w9, [x21]
40003f00: 372fffe9     	tbnz	w9, #0x5, 0x40003efc <uart_printf+0x3f4>
40003f04: b900037a     	str	w26, [x27]
40003f08: 39400109     	ldrb	w9, [x8]
40003f0c: b94b82ca     	ldr	w10, [x22, #0xb80]
40003f10: 3400012a     	cbz	w10, 0x40003f34 <uart_printf+0x42c>
40003f14: b94b86ea     	ldr	w10, [x23, #0xb84]
40003f18: 6b18015f     	cmp	w10, w24
40003f1c: 540000cc     	b.gt	0x40003f34 <uart_printf+0x42c>
40003f20: 93407d4a     	sxtw	x10, w10
40003f24: 9100054b     	add	x11, x10, #0x1
40003f28: 382a6b29     	strb	w9, [x25, x10]
40003f2c: b90b86eb     	str	w11, [x23, #0xb84]
40003f30: 382b6b3f     	strb	wzr, [x25, x11]
40003f34: 91000508     	add	x8, x8, #0x1
40003f38: b94002aa     	ldr	w10, [x21]
40003f3c: 372fffea     	tbnz	w10, #0x5, 0x40003f38 <uart_printf+0x430>
40003f40: b9000369     	str	w9, [x27]
40003f44: 17ffffdd     	b	0x40003eb8 <uart_printf+0x3b0>
40003f48: f9401fe8     	ldr	x8, [sp, #0x38]
40003f4c: 91002109     	add	x9, x8, #0x8
40003f50: f9001fe9     	str	x9, [sp, #0x38]
40003f54: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f58: 39400108     	ldrb	w8, [x8]
40003f5c: 34000129     	cbz	w9, 0x40003f80 <uart_printf+0x478>
40003f60: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f64: 6b18013f     	cmp	w9, w24
40003f68: 540000cc     	b.gt	0x40003f80 <uart_printf+0x478>
40003f6c: 93407d29     	sxtw	x9, w9
40003f70: 9100052a     	add	x10, x9, #0x1
40003f74: 38296b28     	strb	w8, [x25, x9]
40003f78: b90b86ea     	str	w10, [x23, #0xb84]
40003f7c: 382a6b3f     	strb	wzr, [x25, x10]
40003f80: b94002a9     	ldr	w9, [x21]
40003f84: 372fffe9     	tbnz	w9, #0x5, 0x40003f80 <uart_printf+0x478>
40003f88: 17ffff06     	b	0x40003ba0 <uart_printf+0x98>
40003f8c: 36f80569     	tbz	w9, #0x1f, 0x40004038 <uart_printf+0x530>
40003f90: 11002128     	add	w8, w9, #0x8
40003f94: 3100213f     	cmn	w9, #0x8
40003f98: b90053e8     	str	w8, [sp, #0x50]
40003f9c: 540004e8     	b.hi	0x40004038 <uart_printf+0x530>
40003fa0: f94023e8     	ldr	x8, [sp, #0x40]
40003fa4: 8b090108     	add	x8, x8, x9
40003fa8: 14000027     	b	0x40004044 <uart_printf+0x53c>
40003fac: 36f80969     	tbz	w9, #0x1f, 0x400040d8 <uart_printf+0x5d0>
40003fb0: 11002128     	add	w8, w9, #0x8
40003fb4: 3100213f     	cmn	w9, #0x8
40003fb8: b90053e8     	str	w8, [sp, #0x50]
40003fbc: 540008e8     	b.hi	0x400040d8 <uart_printf+0x5d0>
40003fc0: f94023e8     	ldr	x8, [sp, #0x40]
40003fc4: 8b090108     	add	x8, x8, x9
40003fc8: 14000047     	b	0x400040e4 <uart_printf+0x5dc>
40003fcc: 36f81269     	tbz	w9, #0x1f, 0x40004218 <uart_printf+0x710>
40003fd0: 11002128     	add	w8, w9, #0x8
40003fd4: 3100213f     	cmn	w9, #0x8
40003fd8: b90053e8     	str	w8, [sp, #0x50]
40003fdc: 540011e8     	b.hi	0x40004218 <uart_printf+0x710>
40003fe0: f94023e8     	ldr	x8, [sp, #0x40]
40003fe4: 8b090108     	add	x8, x8, x9
40003fe8: 1400008f     	b	0x40004224 <uart_printf+0x71c>
40003fec: f9401fe8     	ldr	x8, [sp, #0x38]
40003ff0: 91002109     	add	x9, x8, #0x8
40003ff4: f9001fe9     	str	x9, [sp, #0x38]
40003ff8: f9400109     	ldr	x9, [x8]
40003ffc: b5000289     	cbnz	x9, 0x4000404c <uart_printf+0x544>
40004000: b94b82c8     	ldr	w8, [x22, #0xb80]
40004004: 34000148     	cbz	w8, 0x4000402c <uart_printf+0x524>
40004008: b94b86e8     	ldr	w8, [x23, #0xb84]
4000400c: 6b18011f     	cmp	w8, w24
40004010: 540000ec     	b.gt	0x4000402c <uart_printf+0x524>
40004014: 93407d08     	sxtw	x8, w8
40004018: 5280060a     	mov	w10, #0x30              // =48
4000401c: 91000509     	add	x9, x8, #0x1
40004020: 38286b2a     	strb	w10, [x25, x8]
40004024: b90b86e9     	str	w9, [x23, #0xb84]
40004028: 38296b3f     	strb	wzr, [x25, x9]
4000402c: b94002a8     	ldr	w8, [x21]
40004030: 372fffe8     	tbnz	w8, #0x5, 0x4000402c <uart_printf+0x524>
40004034: 17fffeda     	b	0x40003b9c <uart_printf+0x94>
40004038: f9401fe8     	ldr	x8, [sp, #0x38]
4000403c: 91002109     	add	x9, x8, #0x8
40004040: f9001fe9     	str	x9, [sp, #0x38]
40004044: b9400109     	ldr	w9, [x8]
40004048: b4fffdc9     	cbz	x9, 0x40004000 <uart_printf+0x4f8>
4000404c: aa1f03ea     	mov	x10, xzr
40004050: 9bcf7d28     	umulh	x8, x9, x15
40004054: f100253f     	cmp	x9, #0x9
40004058: d343fd0b     	lsr	x11, x8, #3
4000405c: 91000548     	add	x8, x10, #0x1
40004060: 1b10a56c     	msub	w12, w11, w16, w9
40004064: 321c0589     	orr	w9, w12, #0x30
40004068: 382a6b89     	strb	w9, [x28, x10]
4000406c: aa0803ea     	mov	x10, x8
40004070: aa0b03e9     	mov	x9, x11
40004074: 54fffee8     	b.hi	0x40004050 <uart_printf+0x548>
40004078: d1000509     	sub	x9, x8, #0x1
4000407c: b94b82cb     	ldr	w11, [x22, #0xb80]
40004080: 38696b8a     	ldrb	w10, [x28, x9]
40004084: 3400012b     	cbz	w11, 0x400040a8 <uart_printf+0x5a0>
40004088: b94b86eb     	ldr	w11, [x23, #0xb84]
4000408c: 6b18017f     	cmp	w11, w24
40004090: 540000cc     	b.gt	0x400040a8 <uart_printf+0x5a0>
40004094: 93407d6b     	sxtw	x11, w11
40004098: 9100056c     	add	x12, x11, #0x1
4000409c: 382b6b2a     	strb	w10, [x25, x11]
400040a0: b90b86ec     	str	w12, [x23, #0xb84]
400040a4: 382c6b3f     	strb	wzr, [x25, x12]
400040a8: b94002ab     	ldr	w11, [x21]
400040ac: 372fffeb     	tbnz	w11, #0x5, 0x400040a8 <uart_printf+0x5a0>
400040b0: 7100051f     	cmp	w8, #0x1
400040b4: aa0903e8     	mov	x8, x9
400040b8: b900036a     	str	w10, [x27]
400040bc: 54fffdec     	b.gt	0x40004078 <uart_printf+0x570>
400040c0: 17fffeb9     	b	0x40003ba4 <uart_printf+0x9c>
400040c4: f9401fe8     	ldr	x8, [sp, #0x38]
400040c8: 91002109     	add	x9, x8, #0x8
400040cc: f9001fe9     	str	x9, [sp, #0x38]
400040d0: f9400108     	ldr	x8, [x8]
400040d4: 14000005     	b	0x400040e8 <uart_printf+0x5e0>
400040d8: f9401fe8     	ldr	x8, [sp, #0x38]
400040dc: 91002109     	add	x9, x8, #0x8
400040e0: f9001fe9     	str	x9, [sp, #0x38]
400040e4: b9400108     	ldr	w8, [x8]
400040e8: 2a1f03e9     	mov	w9, wzr
400040ec: 5280078a     	mov	w10, #0x3c              // =60
400040f0: 14000003     	b	0x400040fc <uart_printf+0x5f4>
400040f4: b4000daa     	cbz	x10, 0x400042a8 <uart_printf+0x7a0>
400040f8: d100114a     	sub	x10, x10, #0x4
400040fc: 9aca250b     	lsr	x11, x8, x10
40004100: f2400d6b     	ands	x11, x11, #0xf
40004104: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004108: 1a9f1529     	csinc	w9, w9, wzr, ne
4000410c: 34ffff49     	cbz	w9, 0x400040f4 <uart_printf+0x5ec>
40004110: b94b82cc     	ldr	w12, [x22, #0xb80]
40004114: 386b6a2b     	ldrb	w11, [x17, x11]
40004118: 3400012c     	cbz	w12, 0x4000413c <uart_printf+0x634>
4000411c: b94b86ec     	ldr	w12, [x23, #0xb84]
40004120: 6b18019f     	cmp	w12, w24
40004124: 540000cc     	b.gt	0x4000413c <uart_printf+0x634>
40004128: 93407d8c     	sxtw	x12, w12
4000412c: 9100058d     	add	x13, x12, #0x1
40004130: 382c6b2b     	strb	w11, [x25, x12]
40004134: b90b86ed     	str	w13, [x23, #0xb84]
40004138: 382d6b3f     	strb	wzr, [x25, x13]
4000413c: b94002ac     	ldr	w12, [x21]
40004140: 372fffec     	tbnz	w12, #0x5, 0x4000413c <uart_printf+0x634>
40004144: b900036b     	str	w11, [x27]
40004148: b5fffd8a     	cbnz	x10, 0x400040f8 <uart_printf+0x5f0>
4000414c: 17fffe96     	b	0x40003ba4 <uart_printf+0x9c>
40004150: f9401fe8     	ldr	x8, [sp, #0x38]
40004154: 91002109     	add	x9, x8, #0x8
40004158: f9001fe9     	str	x9, [sp, #0x38]
4000415c: f9400108     	ldr	x8, [x8]
40004160: b6f80668     	tbz	x8, #0x3f, 0x4000422c <uart_printf+0x724>
40004164: b94b82c9     	ldr	w9, [x22, #0xb80]
40004168: 34000149     	cbz	w9, 0x40004190 <uart_printf+0x688>
4000416c: b94b86e9     	ldr	w9, [x23, #0xb84]
40004170: 6b18013f     	cmp	w9, w24
40004174: 540000ec     	b.gt	0x40004190 <uart_printf+0x688>
40004178: 93407d29     	sxtw	x9, w9
4000417c: 528005ab     	mov	w11, #0x2d              // =45
40004180: 9100052a     	add	x10, x9, #0x1
40004184: 38296b2b     	strb	w11, [x25, x9]
40004188: b90b86ea     	str	w10, [x23, #0xb84]
4000418c: 382a6b3f     	strb	wzr, [x25, x10]
40004190: b94002a9     	ldr	w9, [x21]
40004194: 372fffe9     	tbnz	w9, #0x5, 0x40004190 <uart_printf+0x688>
40004198: aa1f03e9     	mov	x9, xzr
4000419c: 528005aa     	mov	w10, #0x2d              // =45
400041a0: cb0803e8     	neg	x8, x8
400041a4: b900036a     	str	w10, [x27]
400041a8: 9bcf7d0a     	umulh	x10, x8, x15
400041ac: f100251f     	cmp	x8, #0x9
400041b0: d343fd4a     	lsr	x10, x10, #3
400041b4: 1b10a14b     	msub	w11, w10, w16, w8
400041b8: 321c0568     	orr	w8, w11, #0x30
400041bc: 38296b88     	strb	w8, [x28, x9]
400041c0: 91000529     	add	x9, x9, #0x1
400041c4: aa0a03e8     	mov	x8, x10
400041c8: 54ffff08     	b.hi	0x400041a8 <uart_printf+0x6a0>
400041cc: d1000528     	sub	x8, x9, #0x1
400041d0: b94b82cb     	ldr	w11, [x22, #0xb80]
400041d4: 38686b8a     	ldrb	w10, [x28, x8]
400041d8: 3400012b     	cbz	w11, 0x400041fc <uart_printf+0x6f4>
400041dc: b94b86eb     	ldr	w11, [x23, #0xb84]
400041e0: 6b18017f     	cmp	w11, w24
400041e4: 540000cc     	b.gt	0x400041fc <uart_printf+0x6f4>
400041e8: 93407d6b     	sxtw	x11, w11
400041ec: 9100056c     	add	x12, x11, #0x1
400041f0: 382b6b2a     	strb	w10, [x25, x11]
400041f4: b90b86ec     	str	w12, [x23, #0xb84]
400041f8: 382c6b3f     	strb	wzr, [x25, x12]
400041fc: b94002ab     	ldr	w11, [x21]
40004200: 372fffeb     	tbnz	w11, #0x5, 0x400041fc <uart_printf+0x6f4>
40004204: 7100053f     	cmp	w9, #0x1
40004208: aa0803e9     	mov	x9, x8
4000420c: b900036a     	str	w10, [x27]
40004210: 54fffdec     	b.gt	0x400041cc <uart_printf+0x6c4>
40004214: 17fffe64     	b	0x40003ba4 <uart_printf+0x9c>
40004218: f9401fe8     	ldr	x8, [sp, #0x38]
4000421c: 91002109     	add	x9, x8, #0x8
40004220: f9001fe9     	str	x9, [sp, #0x38]
40004224: b9800108     	ldrsw	x8, [x8]
40004228: b7fff9e8     	tbnz	x8, #0x3f, 0x40004164 <uart_printf+0x65c>
4000422c: b40005a8     	cbz	x8, 0x400042e0 <uart_printf+0x7d8>
40004230: aa1f03ea     	mov	x10, xzr
40004234: 9bcf7d09     	umulh	x9, x8, x15
40004238: f100251f     	cmp	x8, #0x9
4000423c: d343fd2b     	lsr	x11, x9, #3
40004240: 91000549     	add	x9, x10, #0x1
40004244: 1b10a16c     	msub	w12, w11, w16, w8
40004248: 321c0588     	orr	w8, w12, #0x30
4000424c: 382a6b88     	strb	w8, [x28, x10]
40004250: aa0903ea     	mov	x10, x9
40004254: aa0b03e8     	mov	x8, x11
40004258: 54fffee8     	b.hi	0x40004234 <uart_printf+0x72c>
4000425c: d1000528     	sub	x8, x9, #0x1
40004260: b94b82cb     	ldr	w11, [x22, #0xb80]
40004264: 38686b8a     	ldrb	w10, [x28, x8]
40004268: 3400012b     	cbz	w11, 0x4000428c <uart_printf+0x784>
4000426c: b94b86eb     	ldr	w11, [x23, #0xb84]
40004270: 6b18017f     	cmp	w11, w24
40004274: 540000cc     	b.gt	0x4000428c <uart_printf+0x784>
40004278: 93407d6b     	sxtw	x11, w11
4000427c: 9100056c     	add	x12, x11, #0x1
40004280: 382b6b2a     	strb	w10, [x25, x11]
40004284: b90b86ec     	str	w12, [x23, #0xb84]
40004288: 382c6b3f     	strb	wzr, [x25, x12]
4000428c: b94002ab     	ldr	w11, [x21]
40004290: 372fffeb     	tbnz	w11, #0x5, 0x4000428c <uart_printf+0x784>
40004294: 7100053f     	cmp	w9, #0x1
40004298: aa0803e9     	mov	x9, x8
4000429c: b900036a     	str	w10, [x27]
400042a0: 54fffdec     	b.gt	0x4000425c <uart_printf+0x754>
400042a4: 17fffe40     	b	0x40003ba4 <uart_printf+0x9c>
400042a8: b94b82c8     	ldr	w8, [x22, #0xb80]
400042ac: 34000148     	cbz	w8, 0x400042d4 <uart_printf+0x7cc>
400042b0: b94b86e8     	ldr	w8, [x23, #0xb84]
400042b4: 6b18011f     	cmp	w8, w24
400042b8: 540000ec     	b.gt	0x400042d4 <uart_printf+0x7cc>
400042bc: 93407d08     	sxtw	x8, w8
400042c0: 5280060a     	mov	w10, #0x30              // =48
400042c4: 91000509     	add	x9, x8, #0x1
400042c8: 38286b2a     	strb	w10, [x25, x8]
400042cc: b90b86e9     	str	w9, [x23, #0xb84]
400042d0: 38296b3f     	strb	wzr, [x25, x9]
400042d4: b94002a8     	ldr	w8, [x21]
400042d8: 372fffe8     	tbnz	w8, #0x5, 0x400042d4 <uart_printf+0x7cc>
400042dc: 17fffe30     	b	0x40003b9c <uart_printf+0x94>
400042e0: b94b82c8     	ldr	w8, [x22, #0xb80]
400042e4: 34000148     	cbz	w8, 0x4000430c <uart_printf+0x804>
400042e8: b94b86e8     	ldr	w8, [x23, #0xb84]
400042ec: 6b18011f     	cmp	w8, w24
400042f0: 540000ec     	b.gt	0x4000430c <uart_printf+0x804>
400042f4: 93407d08     	sxtw	x8, w8
400042f8: 5280060a     	mov	w10, #0x30              // =48
400042fc: 91000509     	add	x9, x8, #0x1
40004300: 38286b2a     	strb	w10, [x25, x8]
40004304: b90b86e9     	str	w9, [x23, #0xb84]
40004308: 38296b3f     	strb	wzr, [x25, x9]
4000430c: b94002a8     	ldr	w8, [x21]
40004310: 372fffe8     	tbnz	w8, #0x5, 0x4000430c <uart_printf+0x804>
40004314: 17fffe22     	b	0x40003b9c <uart_printf+0x94>
40004318: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
4000431c: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004320: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004324: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004328: a9486ffc     	ldp	x28, x27, [sp, #0x80]
4000432c: a9477bfd     	ldp	x29, x30, [sp, #0x70]
40004330: 910343ff     	add	sp, sp, #0xd0
40004334: d65f03c0     	ret

0000000040004338 <vfs_init>:
40004338: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
4000433c: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004340: f0000073     	adrp	x19, 0x40013000 <kernel_capture_buffer+0x3478>
40004344: 912e8273     	add	x19, x19, #0xba0
40004348: f9000bf9     	str	x25, [sp, #0x10]
4000434c: f0000079     	adrp	x25, 0x40013000 <kernel_capture_buffer+0x3478>
40004350: 52800034     	mov	w20, #0x1               // =1
40004354: aa1303e0     	mov	x0, x19
40004358: 2a1f03e1     	mov	w1, wzr
4000435c: 52809802     	mov	w2, #0x4c0              // =1216
40004360: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004364: 910003fd     	mov	x29, sp
40004368: a90357f6     	stp	x22, x21, [sp, #0x30]
4000436c: b90b8b34     	str	w20, [x25, #0xb88]
40004370: 97fff981     	bl	0x40002974 <memset>
40004374: 528005e8     	mov	w8, #0x2f               // =47
40004378: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
4000437c: b9002274     	str	w20, [x19, #0x20]
40004380: 79000268     	strh	w8, [x19]
40004384: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004388: f905c933     	str	x19, [x9, #0xb90]
4000438c: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004390: 7101fd1f     	cmp	w8, #0x7f
40004394: f9021a7f     	str	xzr, [x19, #0x430]
40004398: f900167f     	str	xzr, [x19, #0x28]
4000439c: b904ba7f     	str	wzr, [x19, #0x4b8]
400043a0: f905cd33     	str	x19, [x9, #0xb98]
400043a4: 540028ac     	b.gt	0x400048b8 <vfs_init+0x580>
400043a8: 52809809     	mov	w9, #0x4c0              // =1216
400043ac: 2a1f03e1     	mov	w1, wzr
400043b0: 52809802     	mov	w2, #0x4c0              // =1216
400043b4: 9b294d17     	smaddl	x23, w8, w9, x19
400043b8: 11000508     	add	w8, w8, #0x1
400043bc: b90b8b28     	str	w8, [x25, #0xb88]
400043c0: aa1703e0     	mov	x0, x23
400043c4: 97fff96c     	bl	0x40002974 <memset>
400043c8: 528d2c48     	mov	w8, #0x6962             // =26978
400043cc: b904baff     	str	wzr, [x23, #0x4b8]
400043d0: 72a00dc8     	movk	w8, #0x6e, lsl #16
400043d4: b90022f4     	str	w20, [x23, #0x20]
400043d8: b90002e8     	str	w8, [x23]
400043dc: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400043e0: f9021af3     	str	x19, [x23, #0x430]
400043e4: 71003d1f     	cmp	w8, #0xf
400043e8: f90016ff     	str	xzr, [x23, #0x28]
400043ec: 540000ac     	b.gt	0x40004400 <vfs_init+0xc8>
400043f0: 11000509     	add	w9, w8, #0x1
400043f4: 8b080e68     	add	x8, x19, x8, lsl #3
400043f8: b904ba69     	str	w9, [x19, #0x4b8]
400043fc: f9021d17     	str	x23, [x8, #0x438]
40004400: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004404: 7101fd1f     	cmp	w8, #0x7f
40004408: 5400258c     	b.gt	0x400048b8 <vfs_init+0x580>
4000440c: 52809809     	mov	w9, #0x4c0              // =1216
40004410: 2a1f03e1     	mov	w1, wzr
40004414: 52809802     	mov	w2, #0x4c0              // =1216
40004418: 9b294d16     	smaddl	x22, w8, w9, x19
4000441c: 11000508     	add	w8, w8, #0x1
40004420: b90b8b28     	str	w8, [x25, #0xb88]
40004424: aa1603e0     	mov	x0, x22
40004428: 97fff953     	bl	0x40002974 <memset>
4000442c: 528e8ca8     	mov	w8, #0x7465             // =29797
40004430: b904badf     	str	wzr, [x22, #0x4b8]
40004434: 52800029     	mov	w9, #0x1                // =1
40004438: 72a00c68     	movk	w8, #0x63, lsl #16
4000443c: b90022c9     	str	w9, [x22, #0x20]
40004440: b90002c8     	str	w8, [x22]
40004444: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004448: f9021ad3     	str	x19, [x22, #0x430]
4000444c: 71003d1f     	cmp	w8, #0xf
40004450: f90016df     	str	xzr, [x22, #0x28]
40004454: 540000ac     	b.gt	0x40004468 <vfs_init+0x130>
40004458: 11000509     	add	w9, w8, #0x1
4000445c: 8b080e68     	add	x8, x19, x8, lsl #3
40004460: b904ba69     	str	w9, [x19, #0x4b8]
40004464: f9021d16     	str	x22, [x8, #0x438]
40004468: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000446c: 7101fd1f     	cmp	w8, #0x7f
40004470: 5400224c     	b.gt	0x400048b8 <vfs_init+0x580>
40004474: 52809809     	mov	w9, #0x4c0              // =1216
40004478: 2a1f03e1     	mov	w1, wzr
4000447c: 52809802     	mov	w2, #0x4c0              // =1216
40004480: 9b294d14     	smaddl	x20, w8, w9, x19
40004484: 11000508     	add	w8, w8, #0x1
40004488: b90b8b28     	str	w8, [x25, #0xb88]
4000448c: aa1403e0     	mov	x0, x20
40004490: 97fff939     	bl	0x40002974 <memset>
40004494: 528ded08     	mov	w8, #0x6f68             // =28520
40004498: b904ba9f     	str	wzr, [x20, #0x4b8]
4000449c: 52800029     	mov	w9, #0x1                // =1
400044a0: 72acada8     	movk	w8, #0x656d, lsl #16
400044a4: 3900129f     	strb	wzr, [x20, #0x4]
400044a8: b9000288     	str	w8, [x20]
400044ac: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400044b0: b9002289     	str	w9, [x20, #0x20]
400044b4: 71003d1f     	cmp	w8, #0xf
400044b8: f9021a93     	str	x19, [x20, #0x430]
400044bc: f900169f     	str	xzr, [x20, #0x28]
400044c0: 540000ac     	b.gt	0x400044d4 <vfs_init+0x19c>
400044c4: 11000509     	add	w9, w8, #0x1
400044c8: 8b080e68     	add	x8, x19, x8, lsl #3
400044cc: b904ba69     	str	w9, [x19, #0x4b8]
400044d0: f9021d14     	str	x20, [x8, #0x438]
400044d4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400044d8: 7101fd1f     	cmp	w8, #0x7f
400044dc: 54001eec     	b.gt	0x400048b8 <vfs_init+0x580>
400044e0: 52809809     	mov	w9, #0x4c0              // =1216
400044e4: 2a1f03e1     	mov	w1, wzr
400044e8: 52809802     	mov	w2, #0x4c0              // =1216
400044ec: 9b294d15     	smaddl	x21, w8, w9, x19
400044f0: 11000508     	add	w8, w8, #0x1
400044f4: b90b8b28     	str	w8, [x25, #0xb88]
400044f8: aa1503e0     	mov	x0, x21
400044fc: 97fff91e     	bl	0x40002974 <memset>
40004500: 528dec88     	mov	w8, #0x6f64             // =28516
40004504: b904babf     	str	wzr, [x21, #0x4b8]
40004508: 52800029     	mov	w9, #0x1                // =1
4000450c: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004510: 390012bf     	strb	wzr, [x21, #0x4]
40004514: b90002a8     	str	w8, [x21]
40004518: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000451c: b90022a9     	str	w9, [x21, #0x20]
40004520: 71003d1f     	cmp	w8, #0xf
40004524: f9021ab3     	str	x19, [x21, #0x430]
40004528: f90016bf     	str	xzr, [x21, #0x28]
4000452c: 540000ac     	b.gt	0x40004540 <vfs_init+0x208>
40004530: 11000509     	add	w9, w8, #0x1
40004534: 8b080e68     	add	x8, x19, x8, lsl #3
40004538: b904ba69     	str	w9, [x19, #0x4b8]
4000453c: f9021d15     	str	x21, [x8, #0x438]
40004540: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004544: 7101fd1f     	cmp	w8, #0x7f
40004548: 54001b8c     	b.gt	0x400048b8 <vfs_init+0x580>
4000454c: 52809809     	mov	w9, #0x4c0              // =1216
40004550: 2a1f03e1     	mov	w1, wzr
40004554: 52809802     	mov	w2, #0x4c0              // =1216
40004558: 9b294d18     	smaddl	x24, w8, w9, x19
4000455c: 11000508     	add	w8, w8, #0x1
40004560: b90b8b28     	str	w8, [x25, #0xb88]
40004564: aa1803e0     	mov	x0, x24
40004568: 97fff903     	bl	0x40002974 <memset>
4000456c: 528d2c28     	mov	w8, #0x6961             // =26977
40004570: b904bb1f     	str	wzr, [x24, #0x4b8]
40004574: 79000308     	strh	w8, [x24]
40004578: b984bae8     	ldrsw	x8, [x23, #0x4b8]
4000457c: 39000b1f     	strb	wzr, [x24, #0x2]
40004580: 71003d1f     	cmp	w8, #0xf
40004584: b900231f     	str	wzr, [x24, #0x20]
40004588: f9021b17     	str	x23, [x24, #0x430]
4000458c: f900171f     	str	xzr, [x24, #0x28]
40004590: 540000ac     	b.gt	0x400045a4 <vfs_init+0x26c>
40004594: 8b080ee9     	add	x9, x23, x8, lsl #3
40004598: 11000508     	add	w8, w8, #0x1
4000459c: b904bae8     	str	w8, [x23, #0x4b8]
400045a0: f9021d38     	str	x24, [x9, #0x438]
400045a4: d503201f     	nop
400045a8: 50028077     	adr	x23, 0x400095b6 <__rodata_start+0x25b6>
400045ac: 9100c300     	add	x0, x24, #0x30
400045b0: aa1703e1     	mov	x1, x23
400045b4: 97fff8c4     	bl	0x400028c4 <kstrcpy>
400045b8: aa1703e0     	mov	x0, x23
400045bc: 97fff893     	bl	0x40002808 <kstrlen>
400045c0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045c4: f9001700     	str	x0, [x24, #0x28]
400045c8: 7101fd1f     	cmp	w8, #0x7f
400045cc: 5400176c     	b.gt	0x400048b8 <vfs_init+0x580>
400045d0: 52809809     	mov	w9, #0x4c0              // =1216
400045d4: 2a1f03e1     	mov	w1, wzr
400045d8: 52809802     	mov	w2, #0x4c0              // =1216
400045dc: 9b294d17     	smaddl	x23, w8, w9, x19
400045e0: 11000508     	add	w8, w8, #0x1
400045e4: b90b8b28     	str	w8, [x25, #0xb88]
400045e8: aa1703e0     	mov	x0, x23
400045ec: 97fff8e2     	bl	0x40002974 <memset>
400045f0: d28e6de8     	mov	x8, #0x736f             // =29551
400045f4: b904baff     	str	wzr, [x23, #0x4b8]
400045f8: 528cae69     	mov	w9, #0x6573             // =25971
400045fc: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004600: 790012e9     	strh	w9, [x23, #0x8]
40004604: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
40004608: 39002aff     	strb	wzr, [x23, #0xa]
4000460c: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004610: b90022ff     	str	wzr, [x23, #0x20]
40004614: f90002e8     	str	x8, [x23]
40004618: b984bac8     	ldrsw	x8, [x22, #0x4b8]
4000461c: f9021af6     	str	x22, [x23, #0x430]
40004620: 71003d1f     	cmp	w8, #0xf
40004624: f90016ff     	str	xzr, [x23, #0x28]
40004628: 540000ac     	b.gt	0x4000463c <vfs_init+0x304>
4000462c: 8b080ec9     	add	x9, x22, x8, lsl #3
40004630: 11000508     	add	w8, w8, #0x1
40004634: b904bac8     	str	w8, [x22, #0x4b8]
40004638: f9021d37     	str	x23, [x9, #0x438]
4000463c: f0000016     	adrp	x22, 0x40007000 <__rodata_start>
40004640: 91362ad6     	add	x22, x22, #0xd8a
40004644: 9100c2e0     	add	x0, x23, #0x30
40004648: aa1603e1     	mov	x1, x22
4000464c: 97fff89e     	bl	0x400028c4 <kstrcpy>
40004650: aa1603e0     	mov	x0, x22
40004654: 97fff86d     	bl	0x40002808 <kstrlen>
40004658: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000465c: f90016e0     	str	x0, [x23, #0x28]
40004660: 7101fd1f     	cmp	w8, #0x7f
40004664: 540012ac     	b.gt	0x400048b8 <vfs_init+0x580>
40004668: 52809809     	mov	w9, #0x4c0              // =1216
4000466c: 2a1f03e1     	mov	w1, wzr
40004670: 52809802     	mov	w2, #0x4c0              // =1216
40004674: 9b294d16     	smaddl	x22, w8, w9, x19
40004678: 11000508     	add	w8, w8, #0x1
4000467c: b90b8b28     	str	w8, [x25, #0xb88]
40004680: aa1603e0     	mov	x0, x22
40004684: 97fff8bc     	bl	0x40002974 <memset>
40004688: d28caee8     	mov	x8, #0x6577             // =25975
4000468c: b904badf     	str	wzr, [x22, #0x4b8]
40004690: 528f0e89     	mov	w9, #0x7874             // =30836
40004694: f2ac6d88     	movk	x8, #0x636c, lsl #16
40004698: 72a00e89     	movk	w9, #0x74, lsl #16
4000469c: b90022df     	str	wzr, [x22, #0x20]
400046a0: f2cdade8     	movk	x8, #0x6d6f, lsl #32
400046a4: b9000ac9     	str	w9, [x22, #0x8]
400046a8: f2e5cca8     	movk	x8, #0x2e65, lsl #48
400046ac: f9021ad5     	str	x21, [x22, #0x430]
400046b0: f90002c8     	str	x8, [x22]
400046b4: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400046b8: f90016df     	str	xzr, [x22, #0x28]
400046bc: 71003d1f     	cmp	w8, #0xf
400046c0: 540000ac     	b.gt	0x400046d4 <vfs_init+0x39c>
400046c4: 8b080ea9     	add	x9, x21, x8, lsl #3
400046c8: 11000508     	add	w8, w8, #0x1
400046cc: b904baa8     	str	w8, [x21, #0x4b8]
400046d0: f9021d36     	str	x22, [x9, #0x438]
400046d4: f0000017     	adrp	x23, 0x40007000 <__rodata_start>
400046d8: 913bcaf7     	add	x23, x23, #0xef2
400046dc: 9100c2c0     	add	x0, x22, #0x30
400046e0: aa1703e1     	mov	x1, x23
400046e4: 97fff878     	bl	0x400028c4 <kstrcpy>
400046e8: aa1703e0     	mov	x0, x23
400046ec: 97fff847     	bl	0x40002808 <kstrlen>
400046f0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400046f4: f90016c0     	str	x0, [x22, #0x28]
400046f8: 7101fd1f     	cmp	w8, #0x7f
400046fc: 54000dec     	b.gt	0x400048b8 <vfs_init+0x580>
40004700: 52809809     	mov	w9, #0x4c0              // =1216
40004704: 2a1f03e1     	mov	w1, wzr
40004708: 52809802     	mov	w2, #0x4c0              // =1216
4000470c: 9b294d16     	smaddl	x22, w8, w9, x19
40004710: 11000508     	add	w8, w8, #0x1
40004714: b90b8b28     	str	w8, [x25, #0xb88]
40004718: aa1603e0     	mov	x0, x22
4000471c: 97fff896     	bl	0x40002974 <memset>
40004720: d28c2d08     	mov	x8, #0x6168             // =24936
40004724: b904badf     	str	wzr, [x22, #0x4b8]
40004728: 528e85c9     	mov	w9, #0x742e             // =29742
4000472c: f2ac8e48     	movk	x8, #0x6472, lsl #16
40004730: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004734: 390032df     	strb	wzr, [x22, #0xc]
40004738: f2cc2ee8     	movk	x8, #0x6177, lsl #32
4000473c: b9000ac9     	str	w9, [x22, #0x8]
40004740: f2ecae48     	movk	x8, #0x6572, lsl #48
40004744: b90022df     	str	wzr, [x22, #0x20]
40004748: f90002c8     	str	x8, [x22]
4000474c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004750: f9021ad5     	str	x21, [x22, #0x430]
40004754: 71003d1f     	cmp	w8, #0xf
40004758: f90016df     	str	xzr, [x22, #0x28]
4000475c: 540000ac     	b.gt	0x40004770 <vfs_init+0x438>
40004760: 8b080ea9     	add	x9, x21, x8, lsl #3
40004764: 11000508     	add	w8, w8, #0x1
40004768: b904baa8     	str	w8, [x21, #0x4b8]
4000476c: f9021d36     	str	x22, [x9, #0x438]
40004770: 90000037     	adrp	x23, 0x40008000 <__rodata_start+0x1000>
40004774: 910a7ef7     	add	x23, x23, #0x29f
40004778: 9100c2c0     	add	x0, x22, #0x30
4000477c: aa1703e1     	mov	x1, x23
40004780: 97fff851     	bl	0x400028c4 <kstrcpy>
40004784: aa1703e0     	mov	x0, x23
40004788: 97fff820     	bl	0x40002808 <kstrlen>
4000478c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004790: f90016c0     	str	x0, [x22, #0x28]
40004794: 7101fd1f     	cmp	w8, #0x7f
40004798: 5400090c     	b.gt	0x400048b8 <vfs_init+0x580>
4000479c: 52809809     	mov	w9, #0x4c0              // =1216
400047a0: 2a1f03e1     	mov	w1, wzr
400047a4: 52809802     	mov	w2, #0x4c0              // =1216
400047a8: 9b294d16     	smaddl	x22, w8, w9, x19
400047ac: 11000508     	add	w8, w8, #0x1
400047b0: b90b8b28     	str	w8, [x25, #0xb88]
400047b4: aa1603e0     	mov	x0, x22
400047b8: 97fff86f     	bl	0x40002974 <memset>
400047bc: 528d2c28     	mov	w8, #0x6961             // =26977
400047c0: b904badf     	str	wzr, [x22, #0x4b8]
400047c4: 528e8f09     	mov	w9, #0x7478             // =29816
400047c8: 72ae85c8     	movk	w8, #0x742e, lsl #16
400047cc: 79000ac9     	strh	w9, [x22, #0x4]
400047d0: b90002c8     	str	w8, [x22]
400047d4: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400047d8: 39001adf     	strb	wzr, [x22, #0x6]
400047dc: 71003d1f     	cmp	w8, #0xf
400047e0: b90022df     	str	wzr, [x22, #0x20]
400047e4: f9021ad5     	str	x21, [x22, #0x430]
400047e8: f90016df     	str	xzr, [x22, #0x28]
400047ec: 540000ac     	b.gt	0x40004800 <vfs_init+0x4c8>
400047f0: 8b080ea9     	add	x9, x21, x8, lsl #3
400047f4: 11000508     	add	w8, w8, #0x1
400047f8: b904baa8     	str	w8, [x21, #0x4b8]
400047fc: f9021d36     	str	x22, [x9, #0x438]
40004800: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
40004804: 910bb2b5     	add	x21, x21, #0x2ec
40004808: 9100c2c0     	add	x0, x22, #0x30
4000480c: aa1503e1     	mov	x1, x21
40004810: 97fff82d     	bl	0x400028c4 <kstrcpy>
40004814: aa1503e0     	mov	x0, x21
40004818: 97fff7fc     	bl	0x40002808 <kstrlen>
4000481c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004820: f90016c0     	str	x0, [x22, #0x28]
40004824: 7101fd1f     	cmp	w8, #0x7f
40004828: 5400048c     	b.gt	0x400048b8 <vfs_init+0x580>
4000482c: 52809809     	mov	w9, #0x4c0              // =1216
40004830: 2a1f03e1     	mov	w1, wzr
40004834: 52809802     	mov	w2, #0x4c0              // =1216
40004838: 9b294d13     	smaddl	x19, w8, w9, x19
4000483c: 11000508     	add	w8, w8, #0x1
40004840: b90b8b28     	str	w8, [x25, #0xb88]
40004844: aa1303e0     	mov	x0, x19
40004848: 97fff84b     	bl	0x40002974 <memset>
4000484c: d28cae48     	mov	x8, #0x6572             // =25970
40004850: b904ba7f     	str	wzr, [x19, #0x4b8]
40004854: 528e8f09     	mov	w9, #0x7478             // =29816
40004858: f2ac8c28     	movk	x8, #0x6461, lsl #16
4000485c: 79001269     	strh	w9, [x19, #0x8]
40004860: f2ccada8     	movk	x8, #0x656d, lsl #32
40004864: 39002a7f     	strb	wzr, [x19, #0xa]
40004868: f2ee85c8     	movk	x8, #0x742e, lsl #48
4000486c: b900227f     	str	wzr, [x19, #0x20]
40004870: f9000268     	str	x8, [x19]
40004874: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004878: f9021a74     	str	x20, [x19, #0x430]
4000487c: 71003d1f     	cmp	w8, #0xf
40004880: f900167f     	str	xzr, [x19, #0x28]
40004884: 540000ac     	b.gt	0x40004898 <vfs_init+0x560>
40004888: 8b080e89     	add	x9, x20, x8, lsl #3
4000488c: 11000508     	add	w8, w8, #0x1
40004890: b904ba88     	str	w8, [x20, #0x4b8]
40004894: f9021d33     	str	x19, [x9, #0x438]
40004898: f0000014     	adrp	x20, 0x40007000 <__rodata_start>
4000489c: 910dc694     	add	x20, x20, #0x371
400048a0: 9100c260     	add	x0, x19, #0x30
400048a4: aa1403e1     	mov	x1, x20
400048a8: 97fff807     	bl	0x400028c4 <kstrcpy>
400048ac: aa1403e0     	mov	x0, x20
400048b0: 97fff7d6     	bl	0x40002808 <kstrlen>
400048b4: f9001660     	str	x0, [x19, #0x28]
400048b8: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400048bc: f9400bf9     	ldr	x25, [sp, #0x10]
400048c0: a94357f6     	ldp	x22, x21, [sp, #0x30]
400048c4: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400048c8: a8c57bfd     	ldp	x29, x30, [sp], #0x50
400048cc: d65f03c0     	ret

00000000400048d0 <vfs_load_internal>:
400048d0: 2a1f03e0     	mov	w0, wzr
400048d4: d65f03c0     	ret

00000000400048d8 <vfs_get_root>:
400048d8: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048dc: f945c900     	ldr	x0, [x8, #0xb90]
400048e0: d65f03c0     	ret

00000000400048e4 <vfs_get_cwd>:
400048e4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048e8: f945cd00     	ldr	x0, [x8, #0xb98]
400048ec: d65f03c0     	ret

00000000400048f0 <vfs_getcwd>:
400048f0: d10343ff     	sub	sp, sp, #0xd0
400048f4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048f8: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
400048fc: aa0003f3     	mov	x19, x0
40004900: f945cd08     	ldr	x8, [x8, #0xb98]
40004904: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004908: 910203fd     	add	x29, sp, #0x80
4000490c: a90967fa     	stp	x26, x25, [sp, #0x90]
40004910: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40004914: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004918: b4000228     	cbz	x8, 0x4000495c <vfs_getcwd+0x6c>
4000491c: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004920: f945c929     	ldr	x9, [x9, #0xb90]
40004924: eb09011f     	cmp	x8, x9
40004928: 540001a0     	b.eq	0x4000495c <vfs_getcwd+0x6c>
4000492c: aa1f03ea     	mov	x10, xzr
40004930: 910003eb     	mov	x11, sp
40004934: eb09011f     	cmp	x8, x9
40004938: 540001e0     	b.eq	0x40004974 <vfs_getcwd+0x84>
4000493c: f1003d5f     	cmp	x10, #0xf
40004940: 540001a8     	b.hi	0x40004974 <vfs_getcwd+0x84>
40004944: f82a7968     	str	x8, [x11, x10, lsl #3]
40004948: f9421908     	ldr	x8, [x8, #0x430]
4000494c: 9100054c     	add	x12, x10, #0x1
40004950: aa0c03ea     	mov	x10, x12
40004954: b5ffff08     	cbnz	x8, 0x40004934 <vfs_getcwd+0x44>
40004958: 14000008     	b	0x40004978 <vfs_getcwd+0x88>
4000495c: f100083f     	cmp	x1, #0x2
40004960: 54000583     	b.lo	0x40004a10 <vfs_getcwd+0x120>
40004964: 528005e8     	mov	w8, #0x2f               // =47
40004968: 3900067f     	strb	wzr, [x19, #0x1]
4000496c: 39000268     	strb	w8, [x19]
40004970: 14000028     	b	0x40004a10 <vfs_getcwd+0x120>
40004974: aa0a03ec     	mov	x12, x10
40004978: 7100059f     	cmp	w12, #0x1
4000497c: 3900027f     	strb	wzr, [x19]
40004980: 5400048b     	b.lt	0x40004a10 <vfs_getcwd+0x120>
40004984: aa1f03f6     	mov	x22, xzr
40004988: d1000435     	sub	x21, x1, #0x1
4000498c: 92407999     	and	x25, x12, #0x7fffffff
40004990: 528005f7     	mov	w23, #0x2f              // =47
40004994: 910003f8     	mov	x24, sp
40004998: 14000005     	b	0x400049ac <vfs_getcwd+0xbc>
4000499c: 8b0a02d6     	add	x22, x22, x10
400049a0: f100075f     	cmp	x26, #0x1
400049a4: 38366a7f     	strb	wzr, [x19, x22]
400049a8: 54000349     	b.ls	0x40004a10 <vfs_getcwd+0x120>
400049ac: eb1502df     	cmp	x22, x21
400049b0: aa1903fa     	mov	x26, x25
400049b4: 54000082     	b.hs	0x400049c4 <vfs_getcwd+0xd4>
400049b8: 38366a77     	strb	w23, [x19, x22]
400049bc: 910006d6     	add	x22, x22, #0x1
400049c0: 38366a7f     	strb	wzr, [x19, x22]
400049c4: d1000759     	sub	x25, x26, #0x1
400049c8: f8797b14     	ldr	x20, [x24, x25, lsl #3]
400049cc: aa1403e0     	mov	x0, x20
400049d0: 97fff78e     	bl	0x40002808 <kstrlen>
400049d4: b4fffe60     	cbz	x0, 0x400049a0 <vfs_getcwd+0xb0>
400049d8: eb1502df     	cmp	x22, x21
400049dc: 54fffe22     	b.hs	0x400049a0 <vfs_getcwd+0xb0>
400049e0: aa1f03e9     	mov	x9, xzr
400049e4: 8b160268     	add	x8, x19, x22
400049e8: 9100052a     	add	x10, x9, #0x1
400049ec: 38696a8b     	ldrb	w11, [x20, x9]
400049f0: eb00015f     	cmp	x10, x0
400049f4: 3829690b     	strb	w11, [x8, x9]
400049f8: 54fffd22     	b.hs	0x4000499c <vfs_getcwd+0xac>
400049fc: 8b160149     	add	x9, x10, x22
40004a00: eb15013f     	cmp	x9, x21
40004a04: aa0a03e9     	mov	x9, x10
40004a08: 54ffff03     	b.lo	0x400049e8 <vfs_getcwd+0xf8>
40004a0c: 17ffffe4     	b	0x4000499c <vfs_getcwd+0xac>
40004a10: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004a14: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004a18: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004a1c: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004a20: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004a24: 910343ff     	add	sp, sp, #0xd0
40004a28: d65f03c0     	ret

0000000040004a2c <vfs_find>:
40004a2c: d10203ff     	sub	sp, sp, #0x80
40004a30: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004a34: 910083fd     	add	x29, sp, #0x20
40004a38: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004a3c: a90467fa     	stp	x26, x25, [sp, #0x40]
40004a40: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004a44: a90657f6     	stp	x22, x21, [sp, #0x60]
40004a48: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004a4c: b4000a60     	cbz	x0, 0x40004b98 <vfs_find+0x16c>
40004a50: 39400008     	ldrb	w8, [x0]
40004a54: aa0003f4     	mov	x20, x0
40004a58: 34000a08     	cbz	w8, 0x40004b98 <vfs_find+0x16c>
40004a5c: 7100bd1f     	cmp	w8, #0x2f
40004a60: 54000121     	b.ne	0x40004a84 <vfs_find+0x58>
40004a64: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004a68: 52800037     	mov	w23, #0x1               // =1
40004a6c: f945c913     	ldr	x19, [x8, #0xb90]
40004a70: 38776a88     	ldrb	w8, [x20, x23]
40004a74: 7100bd1f     	cmp	w8, #0x2f
40004a78: 540000e1     	b.ne	0x40004a94 <vfs_find+0x68>
40004a7c: 910006f7     	add	x23, x23, #0x1
40004a80: 17fffffc     	b	0x40004a70 <vfs_find+0x44>
40004a84: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004a88: aa1f03f7     	mov	x23, xzr
40004a8c: f945cd33     	ldr	x19, [x9, #0xb98]
40004a90: 14000002     	b	0x40004a98 <vfs_find+0x6c>
40004a94: 34000848     	cbz	w8, 0x40004b9c <vfs_find+0x170>
40004a98: 91000698     	add	x24, x20, #0x1
40004a9c: f0000015     	adrp	x21, 0x40007000 <__rodata_start>
40004aa0: 91263eb5     	add	x21, x21, #0x98f
40004aa4: 910003f9     	mov	x25, sp
40004aa8: 90000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40004aac: 910236d6     	add	x22, x22, #0x8d
40004ab0: 14000006     	b	0x40004ac8 <vfs_find+0x9c>
40004ab4: f9421a68     	ldr	x8, [x19, #0x430]
40004ab8: f100011f     	cmp	x8, #0x0
40004abc: 9a880273     	csel	x19, x19, x8, eq
40004ac0: 385ff348     	ldurb	w8, [x26, #-0x1]
40004ac4: 340006c8     	cbz	w8, 0x40004b9c <vfs_find+0x170>
40004ac8: 7100bd1f     	cmp	w8, #0x2f
40004acc: 54000061     	b.ne	0x40004ad8 <vfs_find+0xac>
40004ad0: aa1f03e9     	mov	x9, xzr
40004ad4: 14000010     	b	0x40004b14 <vfs_find+0xe8>
40004ad8: aa1f03e9     	mov	x9, xzr
40004adc: 8b17030a     	add	x10, x24, x23
40004ae0: 34000188     	cbz	w8, 0x40004b10 <vfs_find+0xe4>
40004ae4: f100793f     	cmp	x9, #0x1e
40004ae8: 54000148     	b.hi	0x40004b10 <vfs_find+0xe4>
40004aec: 38296b28     	strb	w8, [x25, x9]
40004af0: 38696948     	ldrb	w8, [x10, x9]
40004af4: 9100052b     	add	x11, x9, #0x1
40004af8: aa0b03e9     	mov	x9, x11
40004afc: 7100bd1f     	cmp	w8, #0x2f
40004b00: 54ffff01     	b.ne	0x40004ae0 <vfs_find+0xb4>
40004b04: 8b0b02f7     	add	x23, x23, x11
40004b08: aa0b03e9     	mov	x9, x11
40004b0c: 14000002     	b	0x40004b14 <vfs_find+0xe8>
40004b10: 8b0902f7     	add	x23, x23, x9
40004b14: 8b17029a     	add	x26, x20, x23
40004b18: d10006f7     	sub	x23, x23, #0x1
40004b1c: 38296b3f     	strb	wzr, [x25, x9]
40004b20: 38401748     	ldrb	w8, [x26], #0x1
40004b24: 910006f7     	add	x23, x23, #0x1
40004b28: 7100bd1f     	cmp	w8, #0x2f
40004b2c: 54ffffa0     	b.eq	0x40004b20 <vfs_find+0xf4>
40004b30: 910003e0     	mov	x0, sp
40004b34: aa1503e1     	mov	x1, x21
40004b38: 97fff744     	bl	0x40002848 <kstrcmp>
40004b3c: 34fffc20     	cbz	w0, 0x40004ac0 <vfs_find+0x94>
40004b40: 910003e0     	mov	x0, sp
40004b44: aa1603e1     	mov	x1, x22
40004b48: 97fff740     	bl	0x40002848 <kstrcmp>
40004b4c: 34fffb40     	cbz	w0, 0x40004ab4 <vfs_find+0x88>
40004b50: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b54: 7100051f     	cmp	w8, #0x1
40004b58: 5400020b     	b.lt	0x40004b98 <vfs_find+0x16c>
40004b5c: aa1f03fb     	mov	x27, xzr
40004b60: 9110e27c     	add	x28, x19, #0x438
40004b64: 14000005     	b	0x40004b78 <vfs_find+0x14c>
40004b68: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b6c: 9100077b     	add	x27, x27, #0x1
40004b70: eb28c37f     	cmp	x27, w8, sxtw
40004b74: 5400012a     	b.ge	0x40004b98 <vfs_find+0x16c>
40004b78: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004b7c: b4ffff80     	cbz	x0, 0x40004b6c <vfs_find+0x140>
40004b80: 910003e1     	mov	x1, sp
40004b84: 97fff731     	bl	0x40002848 <kstrcmp>
40004b88: 35ffff00     	cbnz	w0, 0x40004b68 <vfs_find+0x13c>
40004b8c: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004b90: b5fff993     	cbnz	x19, 0x40004ac0 <vfs_find+0x94>
40004b94: 14000002     	b	0x40004b9c <vfs_find+0x170>
40004b98: aa1f03f3     	mov	x19, xzr
40004b9c: aa1303e0     	mov	x0, x19
40004ba0: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004ba4: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004ba8: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004bac: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004bb0: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004bb4: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004bb8: 910203ff     	add	sp, sp, #0x80
40004bbc: d65f03c0     	ret

0000000040004bc0 <vfs_chdir>:
40004bc0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004bc4: f9000bf3     	str	x19, [sp, #0x10]
40004bc8: 910003fd     	mov	x29, sp
40004bcc: b4000200     	cbz	x0, 0x40004c0c <vfs_chdir+0x4c>
40004bd0: 39400008     	ldrb	w8, [x0]
40004bd4: 340001c8     	cbz	w8, 0x40004c0c <vfs_chdir+0x4c>
40004bd8: b0000021     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40004bdc: 91086c21     	add	x1, x1, #0x21b
40004be0: aa0003f3     	mov	x19, x0
40004be4: 97fff719     	bl	0x40002848 <kstrcmp>
40004be8: 34000120     	cbz	w0, 0x40004c0c <vfs_chdir+0x4c>
40004bec: aa1303e0     	mov	x0, x19
40004bf0: 97ffff8f     	bl	0x40004a2c <vfs_find>
40004bf4: b40002c0     	cbz	x0, 0x40004c4c <vfs_chdir+0x8c>
40004bf8: b9402008     	ldr	w8, [x0, #0x20]
40004bfc: 7100051f     	cmp	w8, #0x1
40004c00: 54000180     	b.eq	0x40004c30 <vfs_chdir+0x70>
40004c04: 12800028     	mov	w8, #-0x2               // =-2
40004c08: 1400000d     	b	0x40004c3c <vfs_chdir+0x7c>
40004c0c: f0000000     	adrp	x0, 0x40007000 <__rodata_start>
40004c10: 913d9c00     	add	x0, x0, #0xf67
40004c14: 97ffff86     	bl	0x40004a2c <vfs_find>
40004c18: b4000080     	cbz	x0, 0x40004c28 <vfs_chdir+0x68>
40004c1c: b9402008     	ldr	w8, [x0, #0x20]
40004c20: 7100051f     	cmp	w8, #0x1
40004c24: 54000060     	b.eq	0x40004c30 <vfs_chdir+0x70>
40004c28: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004c2c: f945c900     	ldr	x0, [x8, #0xb90]
40004c30: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004c34: 2a1f03e8     	mov	w8, wzr
40004c38: f905cd20     	str	x0, [x9, #0xb98]
40004c3c: f9400bf3     	ldr	x19, [sp, #0x10]
40004c40: 2a0803e0     	mov	w0, w8
40004c44: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004c48: d65f03c0     	ret
40004c4c: 12800008     	mov	w8, #-0x1               // =-1
40004c50: 17fffffb     	b	0x40004c3c <vfs_chdir+0x7c>

0000000040004c54 <vfs_mkdir>:
40004c54: b40001e0     	cbz	x0, 0x40004c90 <vfs_mkdir+0x3c>
40004c58: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004c5c: 39400008     	ldrb	w8, [x0]
40004c60: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004c64: aa0003f3     	mov	x19, x0
40004c68: a90157f6     	stp	x22, x21, [sp, #0x10]
40004c6c: 910003fd     	mov	x29, sp
40004c70: 34000148     	cbz	w8, 0x40004c98 <vfs_mkdir+0x44>
40004c74: f0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
40004c78: f945ce95     	ldr	x21, [x20, #0xb98]
40004c7c: b944baa8     	ldr	w8, [x21, #0x4b8]
40004c80: 71003d1f     	cmp	w8, #0xf
40004c84: 540000ed     	b.le	0x40004ca0 <vfs_mkdir+0x4c>
40004c88: 12800020     	mov	w0, #-0x2               // =-2
40004c8c: 14000043     	b	0x40004d98 <vfs_mkdir+0x144>
40004c90: 12800000     	mov	w0, #-0x1               // =-1
40004c94: d65f03c0     	ret
40004c98: 12800000     	mov	w0, #-0x1               // =-1
40004c9c: 1400003f     	b	0x40004d98 <vfs_mkdir+0x144>
40004ca0: 7100051f     	cmp	w8, #0x1
40004ca4: 540001eb     	b.lt	0x40004ce0 <vfs_mkdir+0x8c>
40004ca8: aa1f03f6     	mov	x22, xzr
40004cac: 14000005     	b	0x40004cc0 <vfs_mkdir+0x6c>
40004cb0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004cb4: 910006d6     	add	x22, x22, #0x1
40004cb8: eb0802df     	cmp	x22, x8
40004cbc: 5400012a     	b.ge	0x40004ce0 <vfs_mkdir+0x8c>
40004cc0: 8b160ea8     	add	x8, x21, x22, lsl #3
40004cc4: f9421d00     	ldr	x0, [x8, #0x438]
40004cc8: b4ffff40     	cbz	x0, 0x40004cb0 <vfs_mkdir+0x5c>
40004ccc: aa1303e1     	mov	x1, x19
40004cd0: 97fff6de     	bl	0x40002848 <kstrcmp>
40004cd4: 340003e0     	cbz	w0, 0x40004d50 <vfs_mkdir+0xfc>
40004cd8: f945ce95     	ldr	x21, [x20, #0xb98]
40004cdc: 17fffff5     	b	0x40004cb0 <vfs_mkdir+0x5c>
40004ce0: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004ce4: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004ce8: 7101fd3f     	cmp	w9, #0x7f
40004cec: 5400006d     	b.le	0x40004cf8 <vfs_mkdir+0xa4>
40004cf0: 12800060     	mov	w0, #-0x4               // =-4
40004cf4: 14000029     	b	0x40004d98 <vfs_mkdir+0x144>
40004cf8: 5280980a     	mov	w10, #0x4c0             // =1216
40004cfc: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004d00: 912e816b     	add	x11, x11, #0xba0
40004d04: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d08: 11000529     	add	w9, w9, #0x1
40004d0c: 2a1f03e1     	mov	w1, wzr
40004d10: 52809802     	mov	w2, #0x4c0              // =1216
40004d14: b90b8909     	str	w9, [x8, #0xb88]
40004d18: aa1403e0     	mov	x0, x20
40004d1c: 97fff716     	bl	0x40002974 <memset>
40004d20: 39400268     	ldrb	w8, [x19]
40004d24: 340001a8     	cbz	w8, 0x40004d58 <vfs_mkdir+0x104>
40004d28: aa1f03ea     	mov	x10, xzr
40004d2c: 91000669     	add	x9, x19, #0x1
40004d30: 382a6a88     	strb	w8, [x20, x10]
40004d34: 9100054b     	add	x11, x10, #0x1
40004d38: 386a6928     	ldrb	w8, [x9, x10]
40004d3c: 34000108     	cbz	w8, 0x40004d5c <vfs_mkdir+0x108>
40004d40: f100795f     	cmp	x10, #0x1e
40004d44: aa0b03ea     	mov	x10, x11
40004d48: 54ffff43     	b.lo	0x40004d30 <vfs_mkdir+0xdc>
40004d4c: 14000004     	b	0x40004d5c <vfs_mkdir+0x108>
40004d50: 12800040     	mov	w0, #-0x3               // =-3
40004d54: 14000011     	b	0x40004d98 <vfs_mkdir+0x144>
40004d58: aa1f03eb     	mov	x11, xzr
40004d5c: 382b6a9f     	strb	wzr, [x20, x11]
40004d60: 2a1f03e0     	mov	w0, wzr
40004d64: 52800029     	mov	w9, #0x1                // =1
40004d68: b904ba9f     	str	wzr, [x20, #0x4b8]
40004d6c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004d70: b9002289     	str	w9, [x20, #0x20]
40004d74: f9021a95     	str	x21, [x20, #0x430]
40004d78: 71003d1f     	cmp	w8, #0xf
40004d7c: f900169f     	str	xzr, [x20, #0x28]
40004d80: 540000cc     	b.gt	0x40004d98 <vfs_mkdir+0x144>
40004d84: 8b080ea9     	add	x9, x21, x8, lsl #3
40004d88: 2a1f03e0     	mov	w0, wzr
40004d8c: 11000508     	add	w8, w8, #0x1
40004d90: b904baa8     	str	w8, [x21, #0x4b8]
40004d94: f9021d34     	str	x20, [x9, #0x438]
40004d98: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004d9c: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004da0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004da4: d65f03c0     	ret

0000000040004da8 <vfs_sync>:
40004da8: d65f03c0     	ret

0000000040004dac <vfs_touch>:
40004dac: b4000500     	cbz	x0, 0x40004e4c <vfs_touch+0xa0>
40004db0: 39400008     	ldrb	w8, [x0]
40004db4: 340004c8     	cbz	w8, 0x40004e4c <vfs_touch+0xa0>
40004db8: d10583ff     	sub	sp, sp, #0x160
40004dbc: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004dc0: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004dc4: aa1f03f4     	mov	x20, xzr
40004dc8: f945cd33     	ldr	x19, [x9, #0xb98]
40004dcc: aa0003e9     	mov	x9, x0
40004dd0: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004dd4: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004dd8: 910483fd     	add	x29, sp, #0x120
40004ddc: a91457f6     	stp	x22, x21, [sp, #0x140]
40004de0: 14000003     	b	0x40004dec <vfs_touch+0x40>
40004de4: aa0903f4     	mov	x20, x9
40004de8: 38401d28     	ldrb	w8, [x9, #0x1]!
40004dec: 7100bd1f     	cmp	w8, #0x2f
40004df0: 54ffffa0     	b.eq	0x40004de4 <vfs_touch+0x38>
40004df4: 35ffffa8     	cbnz	w8, 0x40004de8 <vfs_touch+0x3c>
40004df8: b4000334     	cbz	x20, 0x40004e5c <vfs_touch+0xb0>
40004dfc: cb000288     	sub	x8, x20, x0
40004e00: 52801fe9     	mov	w9, #0xff               // =255
40004e04: aa0103f5     	mov	x21, x1
40004e08: f103fd1f     	cmp	x8, #0xff
40004e0c: aa0003e1     	mov	x1, x0
40004e10: 910083e0     	add	x0, sp, #0x20
40004e14: 9a893113     	csel	x19, x8, x9, lo
40004e18: 910083f6     	add	x22, sp, #0x20
40004e1c: aa1303e2     	mov	x2, x19
40004e20: 97fff6b0     	bl	0x400028e0 <kstrncpy>
40004e24: 910083e0     	add	x0, sp, #0x20
40004e28: 38336adf     	strb	wzr, [x22, x19]
40004e2c: 97ffff00     	bl	0x40004a2c <vfs_find>
40004e30: b4000120     	cbz	x0, 0x40004e54 <vfs_touch+0xa8>
40004e34: b9402008     	ldr	w8, [x0, #0x20]
40004e38: aa0003f3     	mov	x19, x0
40004e3c: 7100051f     	cmp	w8, #0x1
40004e40: 540000a1     	b.ne	0x40004e54 <vfs_touch+0xa8>
40004e44: 91000688     	add	x8, x20, #0x1
40004e48: 14000007     	b	0x40004e64 <vfs_touch+0xb8>
40004e4c: 12800000     	mov	w0, #-0x1               // =-1
40004e50: d65f03c0     	ret
40004e54: 12800000     	mov	w0, #-0x1               // =-1
40004e58: 1400006a     	b	0x40005000 <vfs_touch+0x254>
40004e5c: aa0003e8     	mov	x8, x0
40004e60: aa0103f5     	mov	x21, x1
40004e64: 910003e0     	mov	x0, sp
40004e68: aa0803e1     	mov	x1, x8
40004e6c: 528003e2     	mov	w2, #0x1f               // =31
40004e70: 97fff69c     	bl	0x400028e0 <kstrncpy>
40004e74: b944ba68     	ldr	w8, [x19, #0x4b8]
40004e78: 39007fff     	strb	wzr, [sp, #0x1f]
40004e7c: 7100051f     	cmp	w8, #0x1
40004e80: 5400024b     	b.lt	0x40004ec8 <vfs_touch+0x11c>
40004e84: aa1f03f6     	mov	x22, xzr
40004e88: 9110e277     	add	x23, x19, #0x438
40004e8c: 14000004     	b	0x40004e9c <vfs_touch+0xf0>
40004e90: 910006d6     	add	x22, x22, #0x1
40004e94: eb28c2df     	cmp	x22, w8, sxtw
40004e98: 5400010a     	b.ge	0x40004eb8 <vfs_touch+0x10c>
40004e9c: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004ea0: b4ffff80     	cbz	x0, 0x40004e90 <vfs_touch+0xe4>
40004ea4: 910003e1     	mov	x1, sp
40004ea8: 97fff668     	bl	0x40002848 <kstrcmp>
40004eac: 340004a0     	cbz	w0, 0x40004f40 <vfs_touch+0x194>
40004eb0: b944ba68     	ldr	w8, [x19, #0x4b8]
40004eb4: 17fffff7     	b	0x40004e90 <vfs_touch+0xe4>
40004eb8: 71003d1f     	cmp	w8, #0xf
40004ebc: 5400006d     	b.le	0x40004ec8 <vfs_touch+0x11c>
40004ec0: 12800020     	mov	w0, #-0x2               // =-2
40004ec4: 1400004f     	b	0x40005000 <vfs_touch+0x254>
40004ec8: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004ecc: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004ed0: 7101fd3f     	cmp	w9, #0x7f
40004ed4: 5400006d     	b.le	0x40004ee0 <vfs_touch+0x134>
40004ed8: 12800060     	mov	w0, #-0x4               // =-4
40004edc: 14000049     	b	0x40005000 <vfs_touch+0x254>
40004ee0: 5280980a     	mov	w10, #0x4c0             // =1216
40004ee4: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004ee8: 912e816b     	add	x11, x11, #0xba0
40004eec: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004ef0: 11000529     	add	w9, w9, #0x1
40004ef4: 2a1f03e1     	mov	w1, wzr
40004ef8: 52809802     	mov	w2, #0x4c0              // =1216
40004efc: b90b8909     	str	w9, [x8, #0xb88]
40004f00: aa1403e0     	mov	x0, x20
40004f04: 97fff69c     	bl	0x40002974 <memset>
40004f08: 394003e8     	ldrb	w8, [sp]
40004f0c: 340003e8     	cbz	w8, 0x40004f88 <vfs_touch+0x1dc>
40004f10: 910003ea     	mov	x10, sp
40004f14: aa1f03e9     	mov	x9, xzr
40004f18: aa1503e0     	mov	x0, x21
40004f1c: b240014a     	orr	x10, x10, #0x1
40004f20: 38296a88     	strb	w8, [x20, x9]
40004f24: 38696948     	ldrb	w8, [x10, x9]
40004f28: 9100052b     	add	x11, x9, #0x1
40004f2c: 34000328     	cbz	w8, 0x40004f90 <vfs_touch+0x1e4>
40004f30: f100793f     	cmp	x9, #0x1e
40004f34: aa0b03e9     	mov	x9, x11
40004f38: 54ffff43     	b.lo	0x40004f20 <vfs_touch+0x174>
40004f3c: 14000015     	b	0x40004f90 <vfs_touch+0x1e4>
40004f40: b40005f5     	cbz	x21, 0x40004ffc <vfs_touch+0x250>
40004f44: aa1503e0     	mov	x0, x21
40004f48: 97fff630     	bl	0x40002808 <kstrlen>
40004f4c: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f50: f10ffc1f     	cmp	x0, #0x3ff
40004f54: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f58: 9a883014     	csel	x20, x0, x8, lo
40004f5c: aa1503e1     	mov	x1, x21
40004f60: 9100c120     	add	x0, x9, #0x30
40004f64: aa1403e2     	mov	x2, x20
40004f68: 97fff699     	bl	0x400029cc <memcpy>
40004f6c: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f70: 2a1f03e0     	mov	w0, wzr
40004f74: 8b140108     	add	x8, x8, x20
40004f78: 3900c11f     	strb	wzr, [x8, #0x30]
40004f7c: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f80: f9001514     	str	x20, [x8, #0x28]
40004f84: 1400001f     	b	0x40005000 <vfs_touch+0x254>
40004f88: aa1f03eb     	mov	x11, xzr
40004f8c: aa1503e0     	mov	x0, x21
40004f90: 382b6a9f     	strb	wzr, [x20, x11]
40004f94: b904ba9f     	str	wzr, [x20, #0x4b8]
40004f98: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004f9c: b900229f     	str	wzr, [x20, #0x20]
40004fa0: f9021a93     	str	x19, [x20, #0x430]
40004fa4: 71003d1f     	cmp	w8, #0xf
40004fa8: f900169f     	str	xzr, [x20, #0x28]
40004fac: 540000ac     	b.gt	0x40004fc0 <vfs_touch+0x214>
40004fb0: 8b080e69     	add	x9, x19, x8, lsl #3
40004fb4: 11000508     	add	w8, w8, #0x1
40004fb8: b904ba68     	str	w8, [x19, #0x4b8]
40004fbc: f9021d34     	str	x20, [x9, #0x438]
40004fc0: b4000200     	cbz	x0, 0x40005000 <vfs_touch+0x254>
40004fc4: aa0003f3     	mov	x19, x0
40004fc8: 97fff610     	bl	0x40002808 <kstrlen>
40004fcc: 52807fe8     	mov	w8, #0x3ff              // =1023
40004fd0: f10ffc1f     	cmp	x0, #0x3ff
40004fd4: 9100c296     	add	x22, x20, #0x30
40004fd8: 9a883015     	csel	x21, x0, x8, lo
40004fdc: aa1603e0     	mov	x0, x22
40004fe0: aa1303e1     	mov	x1, x19
40004fe4: aa1503e2     	mov	x2, x21
40004fe8: 97fff679     	bl	0x400029cc <memcpy>
40004fec: 2a1f03e0     	mov	w0, wzr
40004ff0: 38356adf     	strb	wzr, [x22, x21]
40004ff4: f9001695     	str	x21, [x20, #0x28]
40004ff8: 14000002     	b	0x40005000 <vfs_touch+0x254>
40004ffc: 2a1f03e0     	mov	w0, wzr
40005000: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005004: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005008: a9535ffc     	ldp	x28, x23, [sp, #0x130]
4000500c: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40005010: 910583ff     	add	sp, sp, #0x160
40005014: d65f03c0     	ret

0000000040005018 <vfs_write_file>:
40005018: 17ffff65     	b	0x40004dac <vfs_touch>

000000004000501c <vfs_remove>:
4000501c: b40005c0     	cbz	x0, 0x400050d4 <vfs_remove+0xb8>
40005020: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40005024: 39400008     	ldrb	w8, [x0]
40005028: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000502c: aa0003f3     	mov	x19, x0
40005030: f9000bf5     	str	x21, [sp, #0x10]
40005034: 910003fd     	mov	x29, sp
40005038: 34000448     	cbz	w8, 0x400050c0 <vfs_remove+0xa4>
4000503c: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
40005040: f945ce88     	ldr	x8, [x20, #0xb98]
40005044: b944b909     	ldr	w9, [x8, #0x4b8]
40005048: 7100053f     	cmp	w9, #0x1
4000504c: 540003ab     	b.lt	0x400050c0 <vfs_remove+0xa4>
40005050: aa1f03f5     	mov	x21, xzr
40005054: 14000005     	b	0x40005068 <vfs_remove+0x4c>
40005058: b984b909     	ldrsw	x9, [x8, #0x4b8]
4000505c: 910006b5     	add	x21, x21, #0x1
40005060: eb0902bf     	cmp	x21, x9
40005064: 540002ea     	b.ge	0x400050c0 <vfs_remove+0xa4>
40005068: 8b150d09     	add	x9, x8, x21, lsl #3
4000506c: f9421d20     	ldr	x0, [x9, #0x438]
40005070: b4ffff40     	cbz	x0, 0x40005058 <vfs_remove+0x3c>
40005074: aa1303e1     	mov	x1, x19
40005078: 97fff5f4     	bl	0x40002848 <kstrcmp>
4000507c: f945ce88     	ldr	x8, [x20, #0xb98]
40005080: 35fffec0     	cbnz	w0, 0x40005058 <vfs_remove+0x3c>
40005084: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005088: d1000529     	sub	x9, x9, #0x1
4000508c: 6b15013f     	cmp	w9, w21
40005090: 5400026d     	b.le	0x400050dc <vfs_remove+0xc0>
40005094: f945ce8a     	ldr	x10, [x20, #0xb98]
40005098: b984b949     	ldrsw	x9, [x10, #0x4b8]
4000509c: d1000529     	sub	x9, x9, #0x1
400050a0: 8b150d08     	add	x8, x8, x21, lsl #3
400050a4: 910006b5     	add	x21, x21, #0x1
400050a8: eb0902bf     	cmp	x21, x9
400050ac: f942210b     	ldr	x11, [x8, #0x440]
400050b0: f9021d0b     	str	x11, [x8, #0x438]
400050b4: aa0a03e8     	mov	x8, x10
400050b8: 54ffff4b     	b.lt	0x400050a0 <vfs_remove+0x84>
400050bc: 14000009     	b	0x400050e0 <vfs_remove+0xc4>
400050c0: 12800000     	mov	w0, #-0x1               // =-1
400050c4: a9424ff4     	ldp	x20, x19, [sp, #0x20]
400050c8: f9400bf5     	ldr	x21, [sp, #0x10]
400050cc: a8c37bfd     	ldp	x29, x30, [sp], #0x30
400050d0: d65f03c0     	ret
400050d4: 12800000     	mov	w0, #-0x1               // =-1
400050d8: d65f03c0     	ret
400050dc: aa0803ea     	mov	x10, x8
400050e0: 8b090d48     	add	x8, x10, x9, lsl #3
400050e4: 2a1f03e0     	mov	w0, wzr
400050e8: f9021d1f     	str	xzr, [x8, #0x438]
400050ec: f945ce88     	ldr	x8, [x20, #0xb98]
400050f0: b944b909     	ldr	w9, [x8, #0x4b8]
400050f4: 51000529     	sub	w9, w9, #0x1
400050f8: b904b909     	str	w9, [x8, #0x4b8]
400050fc: 17fffff2     	b	0x400050c4 <vfs_remove+0xa8>

0000000040005100 <vfs_list_dir>:
40005100: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005104: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40005108: f100001f     	cmp	x0, #0x0
4000510c: a90257f6     	stp	x22, x21, [sp, #0x20]
40005110: f945cd08     	ldr	x8, [x8, #0xb98]
40005114: f9000bf7     	str	x23, [sp, #0x10]
40005118: 910003fd     	mov	x29, sp
4000511c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005120: 9a800115     	csel	x21, x8, x0, eq
40005124: b94022a8     	ldr	w8, [x21, #0x20]
40005128: 7100051f     	cmp	w8, #0x1
4000512c: 54000521     	b.ne	0x400051d0 <vfs_list_dir+0xd0>
40005130: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005134: 91375c00     	add	x0, x0, #0xdd7
40005138: 97fff95f     	bl	0x400036b4 <uart_puts>
4000513c: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005140: 9120d800     	add	x0, x0, #0x836
40005144: 97fff95c     	bl	0x400036b4 <uart_puts>
40005148: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000514c: 9135b400     	add	x0, x0, #0xd6d
40005150: 97fff959     	bl	0x400036b4 <uart_puts>
40005154: f9421aa8     	ldr	x8, [x21, #0x430]
40005158: b4000088     	cbz	x8, 0x40005168 <vfs_list_dir+0x68>
4000515c: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005160: 910bf400     	add	x0, x0, #0x2fd
40005164: 97fff954     	bl	0x400036b4 <uart_puts>
40005168: b944baa1     	ldr	w1, [x21, #0x4b8]
4000516c: 7100043f     	cmp	w1, #0x1
40005170: 5400034b     	b.lt	0x400051d8 <vfs_list_dir+0xd8>
40005174: aa1f03f6     	mov	x22, xzr
40005178: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
4000517c: 912b9273     	add	x19, x19, #0xae4
40005180: 9110e2b7     	add	x23, x21, #0x438
40005184: f0000014     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40005188: 91198694     	add	x20, x20, #0x661
4000518c: 14000008     	b	0x400051ac <vfs_list_dir+0xac>
40005190: b9402841     	ldr	w1, [x2, #0x28]
40005194: aa1403e0     	mov	x0, x20
40005198: 97fffa5c     	bl	0x40003b08 <uart_printf>
4000519c: b984baa1     	ldrsw	x1, [x21, #0x4b8]
400051a0: 910006d6     	add	x22, x22, #0x1
400051a4: eb0102df     	cmp	x22, x1
400051a8: 5400018a     	b.ge	0x400051d8 <vfs_list_dir+0xd8>
400051ac: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
400051b0: b4ffff62     	cbz	x2, 0x4000519c <vfs_list_dir+0x9c>
400051b4: b9402048     	ldr	w8, [x2, #0x20]
400051b8: 7100051f     	cmp	w8, #0x1
400051bc: 54fffea1     	b.ne	0x40005190 <vfs_list_dir+0x90>
400051c0: aa1303e0     	mov	x0, x19
400051c4: aa0203e1     	mov	x1, x2
400051c8: 97fffa50     	bl	0x40003b08 <uart_printf>
400051cc: 17fffff4     	b	0x4000519c <vfs_list_dir+0x9c>
400051d0: 12800000     	mov	w0, #-0x1               // =-1
400051d4: 14000005     	b	0x400051e8 <vfs_list_dir+0xe8>
400051d8: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400051dc: 91264400     	add	x0, x0, #0x991
400051e0: 97fffa4a     	bl	0x40003b08 <uart_printf>
400051e4: 2a1f03e0     	mov	w0, wzr
400051e8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400051ec: f9400bf7     	ldr	x23, [sp, #0x10]
400051f0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400051f4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400051f8: d65f03c0     	ret

00000000400051fc <vfs_load>:
400051fc: d65f03c0     	ret

0000000040005200 <pmm_init>:
40005200: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005204: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005208: d503201f     	nop
4000520c: 101a4cb4     	adr	x20, 0x40039ba0 <memory_bitmap>
40005210: aa1403e0     	mov	x0, x20
40005214: 2a1f03e1     	mov	w1, wzr
40005218: 52820002     	mov	w2, #0x1000             // =4096
4000521c: 910003fd     	mov	x29, sp
40005220: 97fff5d5     	bl	0x40002974 <memset>
40005224: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
40005228: d503201f     	nop
4000522c: 1022eea8     	adr	x8, 0x4004b000 <__kernel_end>
40005230: f2820009     	movk	x9, #0x1000
40005234: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
40005238: f2402d1f     	tst	x8, #0xfff
4000523c: 8b090109     	add	x9, x8, x9
40005240: 8b0a010a     	add	x10, x8, x10
40005244: 9a890148     	csel	x8, x10, x9, eq
40005248: d34cfd13     	lsr	x19, x8, #12
4000524c: 340001b3     	cbz	w19, 0x40005280 <pmm_init+0x80>
40005250: 2a1f03e8     	mov	w8, wzr
40005254: 52800029     	mov	w9, #0x1                // =1
40005258: 2a0803ea     	mov	w10, w8
4000525c: 1200090b     	and	w11, w8, #0x7
40005260: 11000508     	add	w8, w8, #0x1
40005264: d343fd4a     	lsr	x10, x10, #3
40005268: 1acb212b     	lsl	w11, w9, w11
4000526c: 6b08027f     	cmp	w19, w8
40005270: 386a6a8c     	ldrb	w12, [x20, x10]
40005274: 2a0b018b     	orr	w11, w12, w11
40005278: 382a6a8b     	strb	w11, [x20, x10]
4000527c: 54fffee1     	b.ne	0x40005258 <pmm_init+0x58>
40005280: 52900008     	mov	w8, #0x8000             // =32768
40005284: b0000034     	adrp	x20, 0x4000a000 <next_pid>
40005288: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
4000528c: 4b130108     	sub	w8, w8, w19
40005290: d503201f     	nop
40005294: 7001e100     	adr	x0, 0x40008eb7 <__rodata_start+0x1eb7>
40005298: b9000688     	str	w8, [x20, #0x4]
4000529c: b90ba133     	str	w19, [x9, #0xba0]
400052a0: 97fffa1a     	bl	0x40003b08 <uart_printf>
400052a4: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400052a8: 911b8400     	add	x0, x0, #0x6e1
400052ac: 52801001     	mov	w1, #0x80               // =128
400052b0: 97fffa16     	bl	0x40003b08 <uart_printf>
400052b4: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400052b8: 91087400     	add	x0, x0, #0x21d
400052bc: 2a1303e1     	mov	w1, w19
400052c0: 97fffa12     	bl	0x40003b08 <uart_printf>
400052c4: b9400688     	ldr	w8, [x20, #0x4]
400052c8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400052cc: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400052d0: 911ad000     	add	x0, x0, #0x6b4
400052d4: 53084d01     	ubfx	w1, w8, #8, #12
400052d8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400052dc: 17fffa0b     	b	0x40003b08 <uart_printf>

00000000400052e0 <pmm_alloc_page>:
400052e0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400052e4: b0000028     	adrp	x8, 0x4000a000 <next_pid>
400052e8: f9000bf3     	str	x19, [sp, #0x10]
400052ec: 910003fd     	mov	x29, sp
400052f0: b940050a     	ldr	w10, [x8, #0x4]
400052f4: 3400030a     	cbz	w10, 0x40005354 <pmm_alloc_page+0x74>
400052f8: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
400052fc: b94ba12b     	ldr	w11, [x9, #0xba0]
40005300: 530f7d6c     	lsr	w12, w11, #15
40005304: 3500022c     	cbnz	w12, 0x40005348 <pmm_alloc_page+0x68>
40005308: 52a8000c     	mov	w12, #0x40000000        // =1073741824
4000530c: d503201f     	nop
40005310: 101a448d     	adr	x13, 0x40039ba0 <memory_bitmap>
40005314: 0b0b318c     	add	w12, w12, w11, lsl #12
40005318: 5280002e     	mov	w14, #0x1               // =1
4000531c: 2a0b03ef     	mov	w15, w11
40005320: 12000971     	and	w17, w11, #0x7
40005324: d343fdef     	lsr	x15, x15, #3
40005328: 1ad121d1     	lsl	w17, w14, w17
4000532c: 386f69b0     	ldrb	w16, [x13, x15]
40005330: 6a10023f     	tst	w17, w16
40005334: 540001e0     	b.eq	0x40005370 <pmm_alloc_page+0x90>
40005338: 1100056b     	add	w11, w11, #0x1
4000533c: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
40005340: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
40005344: 54fffec1     	b.ne	0x4000531c <pmm_alloc_page+0x3c>
40005348: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000534c: 9108dc00     	add	x0, x0, #0x237
40005350: 14000003     	b	0x4000535c <pmm_alloc_page+0x7c>
40005354: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005358: 911b2c00     	add	x0, x0, #0x6cb
4000535c: 97fff8d6     	bl	0x400036b4 <uart_puts>
40005360: aa1f03e0     	mov	x0, xzr
40005364: f9400bf3     	ldr	x19, [sp, #0x10]
40005368: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000536c: d65f03c0     	ret
40005370: 2a0c03f3     	mov	w19, w12
40005374: 5100054a     	sub	w10, w10, #0x1
40005378: 1100056b     	add	w11, w11, #0x1
4000537c: aa1303e0     	mov	x0, x19
40005380: 2a1f03e1     	mov	w1, wzr
40005384: 52820002     	mov	w2, #0x1000             // =4096
40005388: 2a11020e     	orr	w14, w16, w17
4000538c: 382f69ae     	strb	w14, [x13, x15]
40005390: b900050a     	str	w10, [x8, #0x4]
40005394: b90ba12b     	str	w11, [x9, #0xba0]
40005398: 97fff577     	bl	0x40002974 <memset>
4000539c: aa1303e0     	mov	x0, x19
400053a0: 17fffff1     	b	0x40005364 <pmm_alloc_page+0x84>

00000000400053a4 <pmm_free_page>:
400053a4: d35efc08     	lsr	x8, x0, #30
400053a8: b4000128     	cbz	x8, 0x400053cc <pmm_free_page+0x28>
400053ac: d35bfc08     	lsr	x8, x0, #27
400053b0: f100251f     	cmp	x8, #0x9
400053b4: 540000c2     	b.hs	0x400053cc <pmm_free_page+0x28>
400053b8: f2402c1f     	tst	x0, #0xfff
400053bc: 540000e0     	b.eq	0x400053d8 <pmm_free_page+0x34>
400053c0: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400053c4: 91218000     	add	x0, x0, #0x860
400053c8: 17fff8bb     	b	0x400036b4 <uart_puts>
400053cc: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400053d0: 91034400     	add	x0, x0, #0xd1
400053d4: 17fff8b8     	b	0x400036b4 <uart_puts>
400053d8: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
400053dc: d503201f     	nop
400053e0: 101a3e0a     	adr	x10, 0x40039ba0 <memory_bitmap>
400053e4: 8b080009     	add	x9, x0, x8
400053e8: 5280002d     	mov	w13, #0x1               // =1
400053ec: d34fad28     	ubfx	x8, x9, #15, #29
400053f0: d34c392c     	ubfx	x12, x9, #12, #3
400053f4: 3868694b     	ldrb	w11, [x10, x8]
400053f8: 1acc21ac     	lsl	w12, w13, w12
400053fc: 6a0b019f     	tst	w12, w11
40005400: 540001c0     	b.eq	0x40005438 <pmm_free_page+0x94>
40005404: b000002e     	adrp	x14, 0x4000a000 <next_pid>
40005408: b00001ad     	adrp	x13, 0x4003a000 <memory_bitmap+0x460>
4000540c: d34cfd29     	lsr	x9, x9, #12
40005410: b94005cf     	ldr	w15, [x14, #0x4]
40005414: b94ba1b0     	ldr	w16, [x13, #0xba0]
40005418: 0a2c016b     	bic	w11, w11, w12
4000541c: 3828694b     	strb	w11, [x10, x8]
40005420: 110005e8     	add	w8, w15, #0x1
40005424: 6b09021f     	cmp	w16, w9
40005428: b90005c8     	str	w8, [x14, #0x4]
4000542c: 54000049     	b.ls	0x40005434 <pmm_free_page+0x90>
40005430: b90ba1a9     	str	w9, [x13, #0xba0]
40005434: d65f03c0     	ret
40005438: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000543c: 9128ac00     	add	x0, x0, #0xa2b
40005440: 17fff89d     	b	0x400036b4 <uart_puts>

0000000040005444 <pmm_get_free_memory>:
40005444: b0000028     	adrp	x8, 0x4000a000 <next_pid>
40005448: b9400508     	ldr	w8, [x8, #0x4]
4000544c: 53144d00     	lsl	w0, w8, #12
40005450: d65f03c0     	ret

0000000040005454 <sched_init>:
40005454: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005458: 912ec108     	add	x8, x8, #0xbb0
4000545c: d2c00029     	mov	x9, #0x100000000        // =4294967296
40005460: f9001109     	str	x9, [x8, #0x20]
40005464: d2c00049     	mov	x9, #0x200000000        // =8589934592
40005468: d503201f     	nop
4000546c: 30013560     	adr	x0, 0x40007b19 <__rodata_start+0xb19>
40005470: f9001d09     	str	x9, [x8, #0x38]
40005474: d2c00069     	mov	x9, #0x300000000        // =12884901888
40005478: f9002909     	str	x9, [x8, #0x50]
4000547c: d2c00089     	mov	x9, #0x400000000        // =17179869184
40005480: f9003509     	str	x9, [x8, #0x68]
40005484: d2c000a9     	mov	x9, #0x500000000        // =21474836480
40005488: f9004109     	str	x9, [x8, #0x80]
4000548c: d2c000c9     	mov	x9, #0x600000000        // =25769803776
40005490: f9004d09     	str	x9, [x8, #0x98]
40005494: d2c000e9     	mov	x9, #0x700000000        // =30064771072
40005498: f9005909     	str	x9, [x8, #0xb0]
4000549c: d2c00109     	mov	x9, #0x800000000        // =34359738368
400054a0: f9006509     	str	x9, [x8, #0xc8]
400054a4: d2c00129     	mov	x9, #0x900000000        // =38654705664
400054a8: f9007109     	str	x9, [x8, #0xe0]
400054ac: d2c00149     	mov	x9, #0xa00000000        // =42949672960
400054b0: f9007d09     	str	x9, [x8, #0xf8]
400054b4: d2c00169     	mov	x9, #0xb00000000        // =47244640256
400054b8: f9008909     	str	x9, [x8, #0x110]
400054bc: d2c00189     	mov	x9, #0xc00000000        // =51539607552
400054c0: f9009509     	str	x9, [x8, #0x128]
400054c4: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
400054c8: f900a109     	str	x9, [x8, #0x140]
400054cc: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
400054d0: f900ad09     	str	x9, [x8, #0x158]
400054d4: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
400054d8: f900b909     	str	x9, [x8, #0x170]
400054dc: 52800049     	mov	w9, #0x2                // =2
400054e0: a900251f     	stp	xzr, x9, [x8]
400054e4: b0000028     	adrp	x8, 0x4000a000 <next_pid>
400054e8: b900091f     	str	wzr, [x8, #0x8]
400054ec: 17fff872     	b	0x400036b4 <uart_puts>

00000000400054f0 <sched_create_task>:
400054f0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400054f4: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400054f8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400054fc: aa0003f3     	mov	x19, x0
40005500: b94bd108     	ldr	w8, [x8, #0xbd0]
40005504: f9000bf7     	str	x23, [sp, #0x10]
40005508: 910003fd     	mov	x29, sp
4000550c: a90257f6     	stp	x22, x21, [sp, #0x20]
40005510: 340005c8     	cbz	w8, 0x400055c8 <sched_create_task+0xd8>
40005514: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005518: b94be908     	ldr	w8, [x8, #0xbe8]
4000551c: 340005a8     	cbz	w8, 0x400055d0 <sched_create_task+0xe0>
40005520: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005524: b94c0108     	ldr	w8, [x8, #0xc00]
40005528: 34000588     	cbz	w8, 0x400055d8 <sched_create_task+0xe8>
4000552c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005530: b94c1908     	ldr	w8, [x8, #0xc18]
40005534: 34000568     	cbz	w8, 0x400055e0 <sched_create_task+0xf0>
40005538: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
4000553c: b94c3108     	ldr	w8, [x8, #0xc30]
40005540: 34000548     	cbz	w8, 0x400055e8 <sched_create_task+0xf8>
40005544: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005548: b94c4908     	ldr	w8, [x8, #0xc48]
4000554c: 34000528     	cbz	w8, 0x400055f0 <sched_create_task+0x100>
40005550: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005554: b94c6108     	ldr	w8, [x8, #0xc60]
40005558: 34000508     	cbz	w8, 0x400055f8 <sched_create_task+0x108>
4000555c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005560: b94c7908     	ldr	w8, [x8, #0xc78]
40005564: 340004e8     	cbz	w8, 0x40005600 <sched_create_task+0x110>
40005568: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
4000556c: b94c9108     	ldr	w8, [x8, #0xc90]
40005570: 340004c8     	cbz	w8, 0x40005608 <sched_create_task+0x118>
40005574: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005578: b94ca908     	ldr	w8, [x8, #0xca8]
4000557c: 340004a8     	cbz	w8, 0x40005610 <sched_create_task+0x120>
40005580: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005584: b94cc108     	ldr	w8, [x8, #0xcc0]
40005588: 34000488     	cbz	w8, 0x40005618 <sched_create_task+0x128>
4000558c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005590: b94cd908     	ldr	w8, [x8, #0xcd8]
40005594: 34000468     	cbz	w8, 0x40005620 <sched_create_task+0x130>
40005598: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
4000559c: b94cf108     	ldr	w8, [x8, #0xcf0]
400055a0: 34000448     	cbz	w8, 0x40005628 <sched_create_task+0x138>
400055a4: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055a8: b94d0908     	ldr	w8, [x8, #0xd08]
400055ac: 34000428     	cbz	w8, 0x40005630 <sched_create_task+0x140>
400055b0: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055b4: b94d2108     	ldr	w8, [x8, #0xd20]
400055b8: 34000408     	cbz	w8, 0x40005638 <sched_create_task+0x148>
400055bc: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400055c0: 91001400     	add	x0, x0, #0x5
400055c4: 1400003c     	b	0x400056b4 <sched_create_task+0x1c4>
400055c8: 52800034     	mov	w20, #0x1               // =1
400055cc: 1400001c     	b	0x4000563c <sched_create_task+0x14c>
400055d0: 52800054     	mov	w20, #0x2               // =2
400055d4: 1400001a     	b	0x4000563c <sched_create_task+0x14c>
400055d8: 52800074     	mov	w20, #0x3               // =3
400055dc: 14000018     	b	0x4000563c <sched_create_task+0x14c>
400055e0: 52800094     	mov	w20, #0x4               // =4
400055e4: 14000016     	b	0x4000563c <sched_create_task+0x14c>
400055e8: 528000b4     	mov	w20, #0x5               // =5
400055ec: 14000014     	b	0x4000563c <sched_create_task+0x14c>
400055f0: 528000d4     	mov	w20, #0x6               // =6
400055f4: 14000012     	b	0x4000563c <sched_create_task+0x14c>
400055f8: 528000f4     	mov	w20, #0x7               // =7
400055fc: 14000010     	b	0x4000563c <sched_create_task+0x14c>
40005600: 52800114     	mov	w20, #0x8               // =8
40005604: 1400000e     	b	0x4000563c <sched_create_task+0x14c>
40005608: 52800134     	mov	w20, #0x9               // =9
4000560c: 1400000c     	b	0x4000563c <sched_create_task+0x14c>
40005610: 52800154     	mov	w20, #0xa               // =10
40005614: 1400000a     	b	0x4000563c <sched_create_task+0x14c>
40005618: 52800174     	mov	w20, #0xb               // =11
4000561c: 14000008     	b	0x4000563c <sched_create_task+0x14c>
40005620: 52800194     	mov	w20, #0xc               // =12
40005624: 14000006     	b	0x4000563c <sched_create_task+0x14c>
40005628: 528001b4     	mov	w20, #0xd               // =13
4000562c: 14000004     	b	0x4000563c <sched_create_task+0x14c>
40005630: 528001d4     	mov	w20, #0xe               // =14
40005634: 14000002     	b	0x4000563c <sched_create_task+0x14c>
40005638: 528001f4     	mov	w20, #0xf               // =15
4000563c: 97ffff29     	bl	0x400052e0 <pmm_alloc_page>
40005640: b4000360     	cbz	x0, 0x400056ac <sched_create_task+0x1bc>
40005644: 52800308     	mov	w8, #0x18               // =24
40005648: d503201f     	nop
4000564c: 101aaae9     	adr	x9, 0x4003aba8 <tasks>
40005650: 9ba82696     	umaddl	x22, w20, w8, x9
40005654: 913bc015     	add	x21, x0, #0xef0
40005658: aa0003f7     	mov	x23, x0
4000565c: 2a1f03e1     	mov	w1, wzr
40005660: 52802202     	mov	w2, #0x110              // =272
40005664: f90006c0     	str	x0, [x22, #0x8]
40005668: aa1503e0     	mov	x0, x21
4000566c: 97fff4c2     	bl	0x40002974 <memset>
40005670: 52800029     	mov	w9, #0x1                // =1
40005674: f907f6f3     	str	x19, [x23, #0xfe8]
40005678: 528000a8     	mov	w8, #0x5                // =5
4000567c: f90002d5     	str	x21, [x22]
40005680: 2a1403e1     	mov	w1, w20
40005684: 2a1303e2     	mov	w2, w19
40005688: b90012c9     	str	w9, [x22, #0x10]
4000568c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005690: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005694: f907fae8     	str	x8, [x23, #0xff0]
40005698: f9400bf7     	ldr	x23, [sp, #0x10]
4000569c: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400056a0: 911a3400     	add	x0, x0, #0x68d
400056a4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400056a8: 17fff918     	b	0x40003b08 <uart_printf>
400056ac: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400056b0: 91145800     	add	x0, x0, #0x516
400056b4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400056b8: f9400bf7     	ldr	x23, [sp, #0x10]
400056bc: a94257f6     	ldp	x22, x21, [sp, #0x20]
400056c0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400056c4: 17fff7fc     	b	0x400036b4 <uart_puts>

00000000400056c8 <sched_switch>:
400056c8: b0000028     	adrp	x8, 0x4000a000 <next_pid>
400056cc: b940090b     	ldr	w11, [x8, #0x8]
400056d0: 3100057f     	cmn	w11, #0x1
400056d4: 54000300     	b.eq	0x40005734 <sched_switch+0x6c>
400056d8: 5280030a     	mov	w10, #0x18              // =24
400056dc: d503201f     	nop
400056e0: 101aa649     	adr	x9, 0x4003aba8 <tasks>
400056e4: 9b2a256c     	smaddl	x12, w11, w10, x9
400056e8: 9b2a7d6d     	smull	x13, w11, w10
400056ec: b8410d8e     	ldr	w14, [x12, #0x10]!
400056f0: f82d6920     	str	x0, [x9, x13]
400056f4: 710009df     	cmp	w14, #0x2
400056f8: 54000061     	b.ne	0x40005704 <sched_switch+0x3c>
400056fc: 5280002d     	mov	w13, #0x1               // =1
40005700: b900018d     	str	w13, [x12]
40005704: 5280020c     	mov	w12, #0x10              // =16
40005708: 1100056b     	add	w11, w11, #0x1
4000570c: 6b0b03ed     	negs	w13, w11
40005710: 12000d6b     	and	w11, w11, #0xf
40005714: 12000dad     	and	w13, w13, #0xf
40005718: 5a8d456b     	csneg	w11, w11, w13, mi
4000571c: 9b2a256d     	smaddl	x13, w11, w10, x9
40005720: b8410dae     	ldr	w14, [x13, #0x10]!
40005724: 710005df     	cmp	w14, #0x1
40005728: 54000080     	b.eq	0x40005738 <sched_switch+0x70>
4000572c: 7100058c     	subs	w12, w12, #0x1
40005730: 54fffec1     	b.ne	0x40005708 <sched_switch+0x40>
40005734: d65f03c0     	ret
40005738: 5280030a     	mov	w10, #0x18              // =24
4000573c: b900090b     	str	w11, [x8, #0x8]
40005740: 52800048     	mov	w8, #0x2                // =2
40005744: 9b2a7d6a     	smull	x10, w11, w10
40005748: b90001a8     	str	w8, [x13]
4000574c: f86a6920     	ldr	x0, [x9, x10]
40005750: d65f03c0     	ret
		...

0000000040005800 <exception_vector_table>:
40005800: 140001e1     	b	0x40005f84 <handle_sync_invalid>
40005804: d503201f     	nop
40005808: d503201f     	nop
4000580c: d503201f     	nop
40005810: d503201f     	nop
40005814: d503201f     	nop
40005818: d503201f     	nop
4000581c: d503201f     	nop
40005820: d503201f     	nop
40005824: d503201f     	nop
40005828: d503201f     	nop
4000582c: d503201f     	nop
40005830: d503201f     	nop
40005834: d503201f     	nop
40005838: d503201f     	nop
4000583c: d503201f     	nop
40005840: d503201f     	nop
40005844: d503201f     	nop
40005848: d503201f     	nop
4000584c: d503201f     	nop
40005850: d503201f     	nop
40005854: d503201f     	nop
40005858: d503201f     	nop
4000585c: d503201f     	nop
40005860: d503201f     	nop
40005864: d503201f     	nop
40005868: d503201f     	nop
4000586c: d503201f     	nop
40005870: d503201f     	nop
40005874: d503201f     	nop
40005878: d503201f     	nop
4000587c: d503201f     	nop

0000000040005880 <curr_el_sp0_irq>:
40005880: 140001ed     	b	0x40006034 <handle_irq_invalid>
40005884: d503201f     	nop
40005888: d503201f     	nop
4000588c: d503201f     	nop
40005890: d503201f     	nop
40005894: d503201f     	nop
40005898: d503201f     	nop
4000589c: d503201f     	nop
400058a0: d503201f     	nop
400058a4: d503201f     	nop
400058a8: d503201f     	nop
400058ac: d503201f     	nop
400058b0: d503201f     	nop
400058b4: d503201f     	nop
400058b8: d503201f     	nop
400058bc: d503201f     	nop
400058c0: d503201f     	nop
400058c4: d503201f     	nop
400058c8: d503201f     	nop
400058cc: d503201f     	nop
400058d0: d503201f     	nop
400058d4: d503201f     	nop
400058d8: d503201f     	nop
400058dc: d503201f     	nop
400058e0: d503201f     	nop
400058e4: d503201f     	nop
400058e8: d503201f     	nop
400058ec: d503201f     	nop
400058f0: d503201f     	nop
400058f4: d503201f     	nop
400058f8: d503201f     	nop
400058fc: d503201f     	nop

0000000040005900 <curr_el_sp0_fiq>:
40005900: 140001f8     	b	0x400060e0 <handle_fiq_invalid>
40005904: d503201f     	nop
40005908: d503201f     	nop
4000590c: d503201f     	nop
40005910: d503201f     	nop
40005914: d503201f     	nop
40005918: d503201f     	nop
4000591c: d503201f     	nop
40005920: d503201f     	nop
40005924: d503201f     	nop
40005928: d503201f     	nop
4000592c: d503201f     	nop
40005930: d503201f     	nop
40005934: d503201f     	nop
40005938: d503201f     	nop
4000593c: d503201f     	nop
40005940: d503201f     	nop
40005944: d503201f     	nop
40005948: d503201f     	nop
4000594c: d503201f     	nop
40005950: d503201f     	nop
40005954: d503201f     	nop
40005958: d503201f     	nop
4000595c: d503201f     	nop
40005960: d503201f     	nop
40005964: d503201f     	nop
40005968: d503201f     	nop
4000596c: d503201f     	nop
40005970: d503201f     	nop
40005974: d503201f     	nop
40005978: d503201f     	nop
4000597c: d503201f     	nop

0000000040005980 <curr_el_sp0_serror>:
40005980: 14000203     	b	0x4000618c <handle_serror_invalid>
40005984: d503201f     	nop
40005988: d503201f     	nop
4000598c: d503201f     	nop
40005990: d503201f     	nop
40005994: d503201f     	nop
40005998: d503201f     	nop
4000599c: d503201f     	nop
400059a0: d503201f     	nop
400059a4: d503201f     	nop
400059a8: d503201f     	nop
400059ac: d503201f     	nop
400059b0: d503201f     	nop
400059b4: d503201f     	nop
400059b8: d503201f     	nop
400059bc: d503201f     	nop
400059c0: d503201f     	nop
400059c4: d503201f     	nop
400059c8: d503201f     	nop
400059cc: d503201f     	nop
400059d0: d503201f     	nop
400059d4: d503201f     	nop
400059d8: d503201f     	nop
400059dc: d503201f     	nop
400059e0: d503201f     	nop
400059e4: d503201f     	nop
400059e8: d503201f     	nop
400059ec: d503201f     	nop
400059f0: d503201f     	nop
400059f4: d503201f     	nop
400059f8: d503201f     	nop
400059fc: d503201f     	nop

0000000040005a00 <curr_el_spx_sync>:
40005a00: 14000210     	b	0x40006240 <handle_sync_exception_asm>
40005a04: d503201f     	nop
40005a08: d503201f     	nop
40005a0c: d503201f     	nop
40005a10: d503201f     	nop
40005a14: d503201f     	nop
40005a18: d503201f     	nop
40005a1c: d503201f     	nop
40005a20: d503201f     	nop
40005a24: d503201f     	nop
40005a28: d503201f     	nop
40005a2c: d503201f     	nop
40005a30: d503201f     	nop
40005a34: d503201f     	nop
40005a38: d503201f     	nop
40005a3c: d503201f     	nop
40005a40: d503201f     	nop
40005a44: d503201f     	nop
40005a48: d503201f     	nop
40005a4c: d503201f     	nop
40005a50: d503201f     	nop
40005a54: d503201f     	nop
40005a58: d503201f     	nop
40005a5c: d503201f     	nop
40005a60: d503201f     	nop
40005a64: d503201f     	nop
40005a68: d503201f     	nop
40005a6c: d503201f     	nop
40005a70: d503201f     	nop
40005a74: d503201f     	nop
40005a78: d503201f     	nop
40005a7c: d503201f     	nop

0000000040005a80 <curr_el_spx_irq>:
40005a80: 1400021d     	b	0x400062f4 <handle_irq_exception_asm>
40005a84: d503201f     	nop
40005a88: d503201f     	nop
40005a8c: d503201f     	nop
40005a90: d503201f     	nop
40005a94: d503201f     	nop
40005a98: d503201f     	nop
40005a9c: d503201f     	nop
40005aa0: d503201f     	nop
40005aa4: d503201f     	nop
40005aa8: d503201f     	nop
40005aac: d503201f     	nop
40005ab0: d503201f     	nop
40005ab4: d503201f     	nop
40005ab8: d503201f     	nop
40005abc: d503201f     	nop
40005ac0: d503201f     	nop
40005ac4: d503201f     	nop
40005ac8: d503201f     	nop
40005acc: d503201f     	nop
40005ad0: d503201f     	nop
40005ad4: d503201f     	nop
40005ad8: d503201f     	nop
40005adc: d503201f     	nop
40005ae0: d503201f     	nop
40005ae4: d503201f     	nop
40005ae8: d503201f     	nop
40005aec: d503201f     	nop
40005af0: d503201f     	nop
40005af4: d503201f     	nop
40005af8: d503201f     	nop
40005afc: d503201f     	nop

0000000040005b00 <curr_el_spx_fiq>:
40005b00: 14000178     	b	0x400060e0 <handle_fiq_invalid>
40005b04: d503201f     	nop
40005b08: d503201f     	nop
40005b0c: d503201f     	nop
40005b10: d503201f     	nop
40005b14: d503201f     	nop
40005b18: d503201f     	nop
40005b1c: d503201f     	nop
40005b20: d503201f     	nop
40005b24: d503201f     	nop
40005b28: d503201f     	nop
40005b2c: d503201f     	nop
40005b30: d503201f     	nop
40005b34: d503201f     	nop
40005b38: d503201f     	nop
40005b3c: d503201f     	nop
40005b40: d503201f     	nop
40005b44: d503201f     	nop
40005b48: d503201f     	nop
40005b4c: d503201f     	nop
40005b50: d503201f     	nop
40005b54: d503201f     	nop
40005b58: d503201f     	nop
40005b5c: d503201f     	nop
40005b60: d503201f     	nop
40005b64: d503201f     	nop
40005b68: d503201f     	nop
40005b6c: d503201f     	nop
40005b70: d503201f     	nop
40005b74: d503201f     	nop
40005b78: d503201f     	nop
40005b7c: d503201f     	nop

0000000040005b80 <curr_el_spx_serror>:
40005b80: 14000183     	b	0x4000618c <handle_serror_invalid>
40005b84: d503201f     	nop
40005b88: d503201f     	nop
40005b8c: d503201f     	nop
40005b90: d503201f     	nop
40005b94: d503201f     	nop
40005b98: d503201f     	nop
40005b9c: d503201f     	nop
40005ba0: d503201f     	nop
40005ba4: d503201f     	nop
40005ba8: d503201f     	nop
40005bac: d503201f     	nop
40005bb0: d503201f     	nop
40005bb4: d503201f     	nop
40005bb8: d503201f     	nop
40005bbc: d503201f     	nop
40005bc0: d503201f     	nop
40005bc4: d503201f     	nop
40005bc8: d503201f     	nop
40005bcc: d503201f     	nop
40005bd0: d503201f     	nop
40005bd4: d503201f     	nop
40005bd8: d503201f     	nop
40005bdc: d503201f     	nop
40005be0: d503201f     	nop
40005be4: d503201f     	nop
40005be8: d503201f     	nop
40005bec: d503201f     	nop
40005bf0: d503201f     	nop
40005bf4: d503201f     	nop
40005bf8: d503201f     	nop
40005bfc: d503201f     	nop

0000000040005c00 <lower_el_aarch64_sync>:
40005c00: 140000e1     	b	0x40005f84 <handle_sync_invalid>
40005c04: d503201f     	nop
40005c08: d503201f     	nop
40005c0c: d503201f     	nop
40005c10: d503201f     	nop
40005c14: d503201f     	nop
40005c18: d503201f     	nop
40005c1c: d503201f     	nop
40005c20: d503201f     	nop
40005c24: d503201f     	nop
40005c28: d503201f     	nop
40005c2c: d503201f     	nop
40005c30: d503201f     	nop
40005c34: d503201f     	nop
40005c38: d503201f     	nop
40005c3c: d503201f     	nop
40005c40: d503201f     	nop
40005c44: d503201f     	nop
40005c48: d503201f     	nop
40005c4c: d503201f     	nop
40005c50: d503201f     	nop
40005c54: d503201f     	nop
40005c58: d503201f     	nop
40005c5c: d503201f     	nop
40005c60: d503201f     	nop
40005c64: d503201f     	nop
40005c68: d503201f     	nop
40005c6c: d503201f     	nop
40005c70: d503201f     	nop
40005c74: d503201f     	nop
40005c78: d503201f     	nop
40005c7c: d503201f     	nop

0000000040005c80 <lower_el_aarch64_irq>:
40005c80: 140000ed     	b	0x40006034 <handle_irq_invalid>
40005c84: d503201f     	nop
40005c88: d503201f     	nop
40005c8c: d503201f     	nop
40005c90: d503201f     	nop
40005c94: d503201f     	nop
40005c98: d503201f     	nop
40005c9c: d503201f     	nop
40005ca0: d503201f     	nop
40005ca4: d503201f     	nop
40005ca8: d503201f     	nop
40005cac: d503201f     	nop
40005cb0: d503201f     	nop
40005cb4: d503201f     	nop
40005cb8: d503201f     	nop
40005cbc: d503201f     	nop
40005cc0: d503201f     	nop
40005cc4: d503201f     	nop
40005cc8: d503201f     	nop
40005ccc: d503201f     	nop
40005cd0: d503201f     	nop
40005cd4: d503201f     	nop
40005cd8: d503201f     	nop
40005cdc: d503201f     	nop
40005ce0: d503201f     	nop
40005ce4: d503201f     	nop
40005ce8: d503201f     	nop
40005cec: d503201f     	nop
40005cf0: d503201f     	nop
40005cf4: d503201f     	nop
40005cf8: d503201f     	nop
40005cfc: d503201f     	nop

0000000040005d00 <lower_el_aarch64_fiq>:
40005d00: 140000f8     	b	0x400060e0 <handle_fiq_invalid>
40005d04: d503201f     	nop
40005d08: d503201f     	nop
40005d0c: d503201f     	nop
40005d10: d503201f     	nop
40005d14: d503201f     	nop
40005d18: d503201f     	nop
40005d1c: d503201f     	nop
40005d20: d503201f     	nop
40005d24: d503201f     	nop
40005d28: d503201f     	nop
40005d2c: d503201f     	nop
40005d30: d503201f     	nop
40005d34: d503201f     	nop
40005d38: d503201f     	nop
40005d3c: d503201f     	nop
40005d40: d503201f     	nop
40005d44: d503201f     	nop
40005d48: d503201f     	nop
40005d4c: d503201f     	nop
40005d50: d503201f     	nop
40005d54: d503201f     	nop
40005d58: d503201f     	nop
40005d5c: d503201f     	nop
40005d60: d503201f     	nop
40005d64: d503201f     	nop
40005d68: d503201f     	nop
40005d6c: d503201f     	nop
40005d70: d503201f     	nop
40005d74: d503201f     	nop
40005d78: d503201f     	nop
40005d7c: d503201f     	nop

0000000040005d80 <lower_el_aarch64_serror>:
40005d80: 14000103     	b	0x4000618c <handle_serror_invalid>
40005d84: d503201f     	nop
40005d88: d503201f     	nop
40005d8c: d503201f     	nop
40005d90: d503201f     	nop
40005d94: d503201f     	nop
40005d98: d503201f     	nop
40005d9c: d503201f     	nop
40005da0: d503201f     	nop
40005da4: d503201f     	nop
40005da8: d503201f     	nop
40005dac: d503201f     	nop
40005db0: d503201f     	nop
40005db4: d503201f     	nop
40005db8: d503201f     	nop
40005dbc: d503201f     	nop
40005dc0: d503201f     	nop
40005dc4: d503201f     	nop
40005dc8: d503201f     	nop
40005dcc: d503201f     	nop
40005dd0: d503201f     	nop
40005dd4: d503201f     	nop
40005dd8: d503201f     	nop
40005ddc: d503201f     	nop
40005de0: d503201f     	nop
40005de4: d503201f     	nop
40005de8: d503201f     	nop
40005dec: d503201f     	nop
40005df0: d503201f     	nop
40005df4: d503201f     	nop
40005df8: d503201f     	nop
40005dfc: d503201f     	nop

0000000040005e00 <lower_el_aarch32_sync>:
40005e00: 14000061     	b	0x40005f84 <handle_sync_invalid>
40005e04: d503201f     	nop
40005e08: d503201f     	nop
40005e0c: d503201f     	nop
40005e10: d503201f     	nop
40005e14: d503201f     	nop
40005e18: d503201f     	nop
40005e1c: d503201f     	nop
40005e20: d503201f     	nop
40005e24: d503201f     	nop
40005e28: d503201f     	nop
40005e2c: d503201f     	nop
40005e30: d503201f     	nop
40005e34: d503201f     	nop
40005e38: d503201f     	nop
40005e3c: d503201f     	nop
40005e40: d503201f     	nop
40005e44: d503201f     	nop
40005e48: d503201f     	nop
40005e4c: d503201f     	nop
40005e50: d503201f     	nop
40005e54: d503201f     	nop
40005e58: d503201f     	nop
40005e5c: d503201f     	nop
40005e60: d503201f     	nop
40005e64: d503201f     	nop
40005e68: d503201f     	nop
40005e6c: d503201f     	nop
40005e70: d503201f     	nop
40005e74: d503201f     	nop
40005e78: d503201f     	nop
40005e7c: d503201f     	nop

0000000040005e80 <lower_el_aarch32_irq>:
40005e80: 1400006d     	b	0x40006034 <handle_irq_invalid>
40005e84: d503201f     	nop
40005e88: d503201f     	nop
40005e8c: d503201f     	nop
40005e90: d503201f     	nop
40005e94: d503201f     	nop
40005e98: d503201f     	nop
40005e9c: d503201f     	nop
40005ea0: d503201f     	nop
40005ea4: d503201f     	nop
40005ea8: d503201f     	nop
40005eac: d503201f     	nop
40005eb0: d503201f     	nop
40005eb4: d503201f     	nop
40005eb8: d503201f     	nop
40005ebc: d503201f     	nop
40005ec0: d503201f     	nop
40005ec4: d503201f     	nop
40005ec8: d503201f     	nop
40005ecc: d503201f     	nop
40005ed0: d503201f     	nop
40005ed4: d503201f     	nop
40005ed8: d503201f     	nop
40005edc: d503201f     	nop
40005ee0: d503201f     	nop
40005ee4: d503201f     	nop
40005ee8: d503201f     	nop
40005eec: d503201f     	nop
40005ef0: d503201f     	nop
40005ef4: d503201f     	nop
40005ef8: d503201f     	nop
40005efc: d503201f     	nop

0000000040005f00 <lower_el_aarch32_fiq>:
40005f00: 14000078     	b	0x400060e0 <handle_fiq_invalid>
40005f04: d503201f     	nop
40005f08: d503201f     	nop
40005f0c: d503201f     	nop
40005f10: d503201f     	nop
40005f14: d503201f     	nop
40005f18: d503201f     	nop
40005f1c: d503201f     	nop
40005f20: d503201f     	nop
40005f24: d503201f     	nop
40005f28: d503201f     	nop
40005f2c: d503201f     	nop
40005f30: d503201f     	nop
40005f34: d503201f     	nop
40005f38: d503201f     	nop
40005f3c: d503201f     	nop
40005f40: d503201f     	nop
40005f44: d503201f     	nop
40005f48: d503201f     	nop
40005f4c: d503201f     	nop
40005f50: d503201f     	nop
40005f54: d503201f     	nop
40005f58: d503201f     	nop
40005f5c: d503201f     	nop
40005f60: d503201f     	nop
40005f64: d503201f     	nop
40005f68: d503201f     	nop
40005f6c: d503201f     	nop
40005f70: d503201f     	nop
40005f74: d503201f     	nop
40005f78: d503201f     	nop
40005f7c: d503201f     	nop

0000000040005f80 <lower_el_aarch32_serror>:
40005f80: 14000083     	b	0x4000618c <handle_serror_invalid>

0000000040005f84 <handle_sync_invalid>:
40005f84: d10443ff     	sub	sp, sp, #0x110
40005f88: a90007e0     	stp	x0, x1, [sp]
40005f8c: d5384020     	mrs	x0, ELR_EL1
40005f90: d5384001     	mrs	x1, SPSR_EL1
40005f94: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40005f98: a94007e0     	ldp	x0, x1, [sp]
40005f9c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40005fa0: a90217e4     	stp	x4, x5, [sp, #0x20]
40005fa4: a9031fe6     	stp	x6, x7, [sp, #0x30]
40005fa8: a90427e8     	stp	x8, x9, [sp, #0x40]
40005fac: a9052fea     	stp	x10, x11, [sp, #0x50]
40005fb0: a90637ec     	stp	x12, x13, [sp, #0x60]
40005fb4: a9073fee     	stp	x14, x15, [sp, #0x70]
40005fb8: a90847f0     	stp	x16, x17, [sp, #0x80]
40005fbc: a9094ff2     	stp	x18, x19, [sp, #0x90]
40005fc0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005fc4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40005fc8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40005fcc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40005fd0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005fd4: f9007bfe     	str	x30, [sp, #0xf0]
40005fd8: 910003e0     	mov	x0, sp
40005fdc: 97ffe855     	bl	0x40000130 <c_handle_sync_invalid>
40005fe0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40005fe4: d5184020     	msr	ELR_EL1, x0
40005fe8: d5184001     	msr	SPSR_EL1, x1
40005fec: a94007e0     	ldp	x0, x1, [sp]
40005ff0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005ff4: a94217e4     	ldp	x4, x5, [sp, #0x20]
40005ff8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005ffc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006000: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006004: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006008: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000600c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006010: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006014: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006018: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000601c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006020: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006024: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006028: f9407bfe     	ldr	x30, [sp, #0xf0]
4000602c: 910443ff     	add	sp, sp, #0x110
40006030: d69f03e0     	eret

0000000040006034 <handle_irq_invalid>:
40006034: d10443ff     	sub	sp, sp, #0x110
40006038: a90007e0     	stp	x0, x1, [sp]
4000603c: d5384020     	mrs	x0, ELR_EL1
40006040: d5384001     	mrs	x1, SPSR_EL1
40006044: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006048: a94007e0     	ldp	x0, x1, [sp]
4000604c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006050: a90217e4     	stp	x4, x5, [sp, #0x20]
40006054: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006058: a90427e8     	stp	x8, x9, [sp, #0x40]
4000605c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006060: a90637ec     	stp	x12, x13, [sp, #0x60]
40006064: a9073fee     	stp	x14, x15, [sp, #0x70]
40006068: a90847f0     	stp	x16, x17, [sp, #0x80]
4000606c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006070: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006074: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006078: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000607c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006080: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006084: f9007bfe     	str	x30, [sp, #0xf0]
40006088: 97ffe838     	bl	0x40000168 <c_handle_irq_invalid>
4000608c: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40006090: d5184020     	msr	ELR_EL1, x0
40006094: d5184001     	msr	SPSR_EL1, x1
40006098: a94007e0     	ldp	x0, x1, [sp]
4000609c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400060a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
400060a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400060a8: a94427e8     	ldp	x8, x9, [sp, #0x40]
400060ac: a9452fea     	ldp	x10, x11, [sp, #0x50]
400060b0: a94637ec     	ldp	x12, x13, [sp, #0x60]
400060b4: a9473fee     	ldp	x14, x15, [sp, #0x70]
400060b8: a94847f0     	ldp	x16, x17, [sp, #0x80]
400060bc: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400060c0: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400060c4: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400060c8: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400060cc: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400060d0: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400060d4: f9407bfe     	ldr	x30, [sp, #0xf0]
400060d8: 910443ff     	add	sp, sp, #0x110
400060dc: d69f03e0     	eret

00000000400060e0 <handle_fiq_invalid>:
400060e0: d10443ff     	sub	sp, sp, #0x110
400060e4: a90007e0     	stp	x0, x1, [sp]
400060e8: d5384020     	mrs	x0, ELR_EL1
400060ec: d5384001     	mrs	x1, SPSR_EL1
400060f0: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400060f4: a94007e0     	ldp	x0, x1, [sp]
400060f8: a9010fe2     	stp	x2, x3, [sp, #0x10]
400060fc: a90217e4     	stp	x4, x5, [sp, #0x20]
40006100: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006104: a90427e8     	stp	x8, x9, [sp, #0x40]
40006108: a9052fea     	stp	x10, x11, [sp, #0x50]
4000610c: a90637ec     	stp	x12, x13, [sp, #0x60]
40006110: a9073fee     	stp	x14, x15, [sp, #0x70]
40006114: a90847f0     	stp	x16, x17, [sp, #0x80]
40006118: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000611c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006120: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006124: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006128: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000612c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006130: f9007bfe     	str	x30, [sp, #0xf0]
40006134: 97ffe813     	bl	0x40000180 <c_handle_fiq_invalid>
40006138: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
4000613c: d5184020     	msr	ELR_EL1, x0
40006140: d5184001     	msr	SPSR_EL1, x1
40006144: a94007e0     	ldp	x0, x1, [sp]
40006148: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000614c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006150: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006154: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006158: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000615c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006160: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006164: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006168: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000616c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006170: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006174: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006178: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000617c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006180: f9407bfe     	ldr	x30, [sp, #0xf0]
40006184: 910443ff     	add	sp, sp, #0x110
40006188: d69f03e0     	eret

000000004000618c <handle_serror_invalid>:
4000618c: d10443ff     	sub	sp, sp, #0x110
40006190: a90007e0     	stp	x0, x1, [sp]
40006194: d5384020     	mrs	x0, ELR_EL1
40006198: d5384001     	mrs	x1, SPSR_EL1
4000619c: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400061a0: a94007e0     	ldp	x0, x1, [sp]
400061a4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400061a8: a90217e4     	stp	x4, x5, [sp, #0x20]
400061ac: a9031fe6     	stp	x6, x7, [sp, #0x30]
400061b0: a90427e8     	stp	x8, x9, [sp, #0x40]
400061b4: a9052fea     	stp	x10, x11, [sp, #0x50]
400061b8: a90637ec     	stp	x12, x13, [sp, #0x60]
400061bc: a9073fee     	stp	x14, x15, [sp, #0x70]
400061c0: a90847f0     	stp	x16, x17, [sp, #0x80]
400061c4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400061c8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400061cc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400061d0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400061d4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400061d8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400061dc: f9007bfe     	str	x30, [sp, #0xf0]
400061e0: 97ffe7ee     	bl	0x40000198 <c_handle_serror_invalid>
400061e4: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400061e8: d5184020     	msr	ELR_EL1, x0
400061ec: d5184001     	msr	SPSR_EL1, x1
400061f0: a94007e0     	ldp	x0, x1, [sp]
400061f4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400061f8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400061fc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006200: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006204: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006208: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000620c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006210: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006214: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006218: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000621c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006220: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006224: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006228: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000622c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006230: 910443ff     	add	sp, sp, #0x110
40006234: d69f03e0     	eret

0000000040006238 <trigger_undefined_instruction>:
40006238: 00000000     	udf	#0x0
4000623c: d65f03c0     	ret

0000000040006240 <handle_sync_exception_asm>:
40006240: d10443ff     	sub	sp, sp, #0x110
40006244: a90007e0     	stp	x0, x1, [sp]
40006248: d5384020     	mrs	x0, ELR_EL1
4000624c: d5384001     	mrs	x1, SPSR_EL1
40006250: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006254: a94007e0     	ldp	x0, x1, [sp]
40006258: a9010fe2     	stp	x2, x3, [sp, #0x10]
4000625c: a90217e4     	stp	x4, x5, [sp, #0x20]
40006260: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006264: a90427e8     	stp	x8, x9, [sp, #0x40]
40006268: a9052fea     	stp	x10, x11, [sp, #0x50]
4000626c: a90637ec     	stp	x12, x13, [sp, #0x60]
40006270: a9073fee     	stp	x14, x15, [sp, #0x70]
40006274: a90847f0     	stp	x16, x17, [sp, #0x80]
40006278: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000627c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006280: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006284: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006288: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000628c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006290: f9007bfe     	str	x30, [sp, #0xf0]
40006294: 910003e0     	mov	x0, sp
40006298: 97ffe772     	bl	0x40000060 <handle_sync_exception>
4000629c: 9100001f     	mov	sp, x0
400062a0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400062a4: d5184020     	msr	ELR_EL1, x0
400062a8: d5184001     	msr	SPSR_EL1, x1
400062ac: a94007e0     	ldp	x0, x1, [sp]
400062b0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400062b4: a94217e4     	ldp	x4, x5, [sp, #0x20]
400062b8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400062bc: a94427e8     	ldp	x8, x9, [sp, #0x40]
400062c0: a9452fea     	ldp	x10, x11, [sp, #0x50]
400062c4: a94637ec     	ldp	x12, x13, [sp, #0x60]
400062c8: a9473fee     	ldp	x14, x15, [sp, #0x70]
400062cc: a94847f0     	ldp	x16, x17, [sp, #0x80]
400062d0: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400062d4: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400062d8: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400062dc: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400062e0: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400062e4: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400062e8: f9407bfe     	ldr	x30, [sp, #0xf0]
400062ec: 910443ff     	add	sp, sp, #0x110
400062f0: d69f03e0     	eret

00000000400062f4 <handle_irq_exception_asm>:
400062f4: d10443ff     	sub	sp, sp, #0x110
400062f8: a90007e0     	stp	x0, x1, [sp]
400062fc: d5384020     	mrs	x0, ELR_EL1
40006300: d5384001     	mrs	x1, SPSR_EL1
40006304: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006308: a94007e0     	ldp	x0, x1, [sp]
4000630c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006310: a90217e4     	stp	x4, x5, [sp, #0x20]
40006314: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006318: a90427e8     	stp	x8, x9, [sp, #0x40]
4000631c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006320: a90637ec     	stp	x12, x13, [sp, #0x60]
40006324: a9073fee     	stp	x14, x15, [sp, #0x70]
40006328: a90847f0     	stp	x16, x17, [sp, #0x80]
4000632c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006330: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006334: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006338: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000633c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006340: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006344: f9007bfe     	str	x30, [sp, #0xf0]
40006348: 910003e0     	mov	x0, sp
4000634c: 97ffe799     	bl	0x400001b0 <handle_irq_exception>
40006350: 9100001f     	mov	sp, x0
40006354: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40006358: d5184020     	msr	ELR_EL1, x0
4000635c: d5184001     	msr	SPSR_EL1, x1
40006360: a94007e0     	ldp	x0, x1, [sp]
40006364: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006368: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000636c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006370: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006374: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006378: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000637c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006380: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006384: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006388: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000638c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006390: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006394: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006398: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000639c: f9407bfe     	ldr	x30, [sp, #0xf0]
400063a0: 910443ff     	add	sp, sp, #0x110
400063a4: d69f03e0     	eret
