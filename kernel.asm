
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
40000048: d0 cd 04 40  	.word	0x4004cdd0
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 d0 00 40  	.word	0x4000d000
40000054: 00 00 00 00  	.word	0x00000000
40000058: d0 cd 03 40  	.word	0x4003cdd0
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 50053360     	adr	x0, 0x4000a6de <__rodata_start+0x16de>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000d99     	bl	0x400036e8 <uart_puts>
40000088: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000008c: 913f4000     	add	x0, x0, #0xfd0
40000090: aa1403e1     	mov	x1, x20
40000094: 94000eaa     	bl	0x40003b3c <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000a0: 91028000     	add	x0, x0, #0xa0
400000a4: 94000ea6     	bl	0x40003b3c <uart_printf>
400000a8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000ac: 91116800     	add	x0, x0, #0x45a
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000ea2     	bl	0x40003b3c <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400000c0: 91238c00     	add	x0, x0, #0x8e3
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000e9d     	bl	0x40003b3c <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000f0: 91130000     	add	x0, x0, #0x4c0
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000fc: 9133d800     	add	x0, x0, #0xcf6
40000100: 94000d7a     	bl	0x400036e8 <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
4000010c: 91030800     	add	x0, x0, #0xc2
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000d74     	bl	0x400036e8 <uart_puts>
4000011c: aa1303e0     	mov	x0, x19
40000120: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40000124: f9400bf5     	ldr	x21, [sp, #0x10]
40000128: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000012c: d65f03c0     	ret

0000000040000130 <c_handle_sync_invalid>:
40000130: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000134: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000138: aa0003f3     	mov	x19, x0
4000013c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000140: 913b9c00     	add	x0, x0, #0xee7
40000144: 910003fd     	mov	x29, sp
40000148: d5385214     	mrs	x20, ESR_EL1
4000014c: 94000e7c     	bl	0x40003b3c <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000158: 912bd000     	add	x0, x0, #0xaf4
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000e77     	bl	0x40003b3c <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000170: 913f8400     	add	x0, x0, #0xfe1
40000174: 910003fd     	mov	x29, sp
40000178: 94000d5c     	bl	0x400036e8 <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000188: 91344000     	add	x0, x0, #0xd10
4000018c: 910003fd     	mov	x29, sp
40000190: 94000d56     	bl	0x400036e8 <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001a0: 91138800     	add	x0, x0, #0x4e2
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000d50     	bl	0x400036e8 <uart_puts>
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
400001d8: 94000a62     	bl	0x40002b60 <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 9400155a     	bl	0x40005748 <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001f0: 91193000     	add	x0, x0, #0x64c
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000e51     	bl	0x40003b3c <uart_printf>
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
400002e8: 100668d3     	adr	x19, 0x4000d000 <__bss_start>
400002ec: aa0003f4     	mov	x20, x0
400002f0: aa1303e0     	mov	x0, x19
400002f4: 2a1f03e1     	mov	w1, wzr
400002f8: 52864a82     	mov	w2, #0x3254             // =12884
400002fc: 940009ab     	bl	0x400029a8 <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 94000982     	bl	0x40002914 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 940011cf     	bl	0x40004a58 <vfs_find>
40000320: 90000097     	adrp	x23, 0x40010000 <__bss_start+0x3000>
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
400003bc: 100534e0     	adr	x0, 0x4000aa58 <__rodata_start+0x1a58>
400003c0: 94000cca     	bl	0x400036e8 <uart_puts>
400003c4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400003c8: 91350694     	add	x20, x20, #0xd41
400003cc: b0000056     	adrp	x22, 0x40009000 <__rodata_start>
400003d0: 91040ad6     	add	x22, x22, #0x102
400003d4: d0000058     	adrp	x24, 0x4000a000 <__rodata_start+0x1000>
400003d8: 91134b18     	add	x24, x24, #0x4d2
400003dc: d0000059     	adrp	x25, 0x4000a000 <__rodata_start+0x1000>
400003e0: 91223b39     	add	x25, x25, #0x88e
400003e4: 9000009a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: 9000009b     	adrp	x27, 0x40010000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000cb9     	bl	0x400036e8 <uart_puts>
40000408: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000040c: 910c4c00     	add	x0, x0, #0x313
40000410: 94000cb6     	bl	0x400036e8 <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000cb4     	bl	0x400036e8 <uart_puts>
4000041c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000420: 913ff800     	add	x0, x0, #0xffe
40000424: aa1303e1     	mov	x1, x19
40000428: 94000dc5     	bl	0x40003b3c <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000434: 91122129     	add	x9, x9, #0x488
40000438: 7100011f     	cmp	w8, #0x0
4000043c: d0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40000440: 912b7d08     	add	x8, x8, #0xadf
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000ca8     	bl	0x400036e8 <uart_puts>
4000044c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000450: 91033800     	add	x0, x0, #0xce
40000454: 94000ca5     	bl	0x400036e8 <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000c9c     	bl	0x400036e8 <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000c9a     	bl	0x400036e8 <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000c95     	bl	0x400036e8 <uart_puts>
40000498: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000049c: 91137400     	add	x0, x0, #0x4dd
400004a0: 94000c92     	bl	0x400036e8 <uart_puts>
400004a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004a8: 9134b400     	add	x0, x0, #0xd2d
400004ac: 94000c8f     	bl	0x400036e8 <uart_puts>
400004b0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004b4: 91224000     	add	x0, x0, #0x890
400004b8: 94000c8c     	bl	0x400036e8 <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400004c8: 91121800     	add	x0, x0, #0x486
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000d99     	bl	0x40003b3c <uart_printf>
400004dc: 94000cb7     	bl	0x400037b8 <uart_getc>
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
40000550: 940008ea     	bl	0x400028f8 <kstrcpy>
40000554: b9824b68     	ldrsw	x8, [x27, #0x248]
40000558: aa1503e0     	mov	x0, x21
4000055c: eb0802df     	cmp	x22, x8
40000560: 54ffff2c     	b.gt	0x40000544 <launch_kedit+0x280>
40000564: b0000075     	adrp	x21, 0x4000d000 <__bss_start>
40000568: 910102b5     	add	x21, x21, #0x40
4000056c: 910023e0     	add	x0, sp, #0x8
40000570: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000574: 8b081ea8     	add	x8, x21, x8, lsl #7
40000578: 8b090101     	add	x1, x8, x9
4000057c: 940008df     	bl	0x400028f8 <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 940008d5     	bl	0x400028f8 <kstrcpy>
400005a8: b97202a8     	ldr	w8, [x21, #0x3200]
400005ac: b93206bf     	str	wzr, [x21, #0x3204]
400005b0: b93212bc     	str	w28, [x21, #0x3210]
400005b4: 11000508     	add	w8, w8, #0x1
400005b8: b93202a8     	str	w8, [x21, #0x3200]
400005bc: 14000081     	b	0x400007c0 <launch_kedit+0x4fc>
400005c0: 90000088     	adrp	x8, 0x40010000 <__bss_start+0x3000>
400005c4: b9424508     	ldr	w8, [x8, #0x244]
400005c8: 7100051f     	cmp	w8, #0x1
400005cc: 54000fab     	b.lt	0x400007c0 <launch_kedit+0x4fc>
400005d0: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400005d4: 8b081e68     	add	x8, x19, x8, lsl #7
400005d8: 91010100     	add	x0, x8, #0x40
400005dc: 94000898     	bl	0x4000283c <kstrlen>
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
40000618: 90000088     	adrp	x8, 0x40010000 <__bss_start+0x3000>
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
40000650: b0000075     	adrp	x21, 0x4000d000 <__bss_start>
40000654: 910102b5     	add	x21, x21, #0x40
40000658: 14000006     	b	0x40000670 <launch_kedit+0x3ac>
4000065c: b98242e8     	ldrsw	x8, [x23, #0x240]
40000660: 9100079c     	add	x28, x28, #0x1
40000664: 910202b5     	add	x21, x21, #0x80
40000668: eb08039f     	cmp	x28, x8
4000066c: 540001ca     	b.ge	0x400006a4 <launch_kedit+0x3e0>
40000670: aa1503e0     	mov	x0, x21
40000674: 94000872     	bl	0x4000283c <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 94000873     	bl	0x40002858 <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 94000870     	bl	0x40002858 <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 94001266     	bl	0x40005044 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006bc: 91350694     	add	x20, x20, #0xd41
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c3d     	bl	0x400037b8 <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c3b     	bl	0x400037b8 <uart_getc>
400006d0: 71016e9f     	cmp	w20, #0x5b
400006d4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006d8: 91350694     	add	x20, x20, #0xd41
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
40000710: 9400084b     	bl	0x4000283c <kstrlen>
40000714: b9724668     	ldr	w8, [x19, #0x3244]
40000718: 6b00011f     	cmp	w8, w0
4000071c: 5400052d     	b.le	0x400007c0 <launch_kedit+0x4fc>
40000720: 90000088     	adrp	x8, 0x40010000 <__bss_start+0x3000>
40000724: b9024500     	str	w0, [x8, #0x244]
40000728: 14000026     	b	0x400007c0 <launch_kedit+0x4fc>
4000072c: 7100611f     	cmp	w8, #0x18
40000730: 54000ac0     	b.eq	0x40000888 <launch_kedit+0x5c4>
40000734: 510082a8     	sub	w8, w21, #0x20
40000738: 12001d08     	and	w8, w8, #0xff
4000073c: 7101791f     	cmp	w8, #0x5e
40000740: 54000408     	b.hi	0x400007c0 <launch_kedit+0x4fc>
40000744: 90000088     	adrp	x8, 0x40010000 <__bss_start+0x3000>
40000748: b9424508     	ldr	w8, [x8, #0x244]
4000074c: 7101f91f     	cmp	w8, #0x7e
40000750: 5400038c     	b.gt	0x400007c0 <launch_kedit+0x4fc>
40000754: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000758: 8b081e68     	add	x8, x19, x8, lsl #7
4000075c: 91010100     	add	x0, x8, #0x40
40000760: 94000837     	bl	0x4000283c <kstrlen>
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
400007c0: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
400007c4: 91092129     	add	x9, x9, #0x248
400007c8: b0000056     	adrp	x22, 0x40009000 <__rodata_start>
400007cc: 91040ad6     	add	x22, x22, #0x102
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
40000824: 94000806     	bl	0x4000283c <kstrlen>
40000828: eb14001f     	cmp	x0, x20
4000082c: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
40000830: 91350694     	add	x20, x20, #0xd41
40000834: 54fffc69     	b.ls	0x400007c0 <launch_kedit+0x4fc>
40000838: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000083c: b9424528     	ldr	w8, [x9, #0x244]
40000840: 11000508     	add	w8, w8, #0x1
40000844: b9024528     	str	w8, [x9, #0x244]
40000848: 17ffffde     	b	0x400007c0 <launch_kedit+0x4fc>
4000084c: 12001c09     	and	w9, w0, #0xff
40000850: 7101113f     	cmp	w9, #0x44
40000854: 54000101     	b.ne	0x40000874 <launch_kedit+0x5b0>
40000858: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000085c: b9424529     	ldr	w9, [x9, #0x244]
40000860: 71000529     	subs	w9, w9, #0x1
40000864: 5400008b     	b.lt	0x40000874 <launch_kedit+0x5b0>
40000868: 90000088     	adrp	x8, 0x40010000 <__bss_start+0x3000>
4000086c: b9024509     	str	w9, [x8, #0x244]
40000870: 17ffffd4     	b	0x400007c0 <launch_kedit+0x4fc>
40000874: 51010409     	sub	w9, w0, #0x41
40000878: 12001d29     	and	w9, w9, #0xff
4000087c: 7100093f     	cmp	w9, #0x2
40000880: 54fff423     	b.lo	0x40000704 <launch_kedit+0x440>
40000884: 17ffffcf     	b	0x400007c0 <launch_kedit+0x4fc>
40000888: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000088c: 91297800     	add	x0, x0, #0xa5e
40000890: 94000b96     	bl	0x400036e8 <uart_puts>
40000894: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000898: 912b3400     	add	x0, x0, #0xacd
4000089c: 94000b93     	bl	0x400036e8 <uart_puts>
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
400008d0: 7004fe33     	adr	x19, 0x4000a897 <__rodata_start+0x1897>
400008d4: 72a05f54     	movk	w20, #0x2fa, lsl #16
400008d8: a9017bfd     	stp	x29, x30, [sp, #0x10]
400008dc: 910043fd     	add	x29, sp, #0x10
400008e0: aa1303e0     	mov	x0, x19
400008e4: 94000b81     	bl	0x400036e8 <uart_puts>
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
4000090c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000910: 910c4c00     	add	x0, x0, #0x313
40000914: 910003fd     	mov	x29, sp
40000918: 94000b74     	bl	0x400036e8 <uart_puts>
4000091c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000920: 91223800     	add	x0, x0, #0x88e
40000924: 94000b71     	bl	0x400036e8 <uart_puts>
40000928: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000092c: 91142800     	add	x0, x0, #0x50a
40000930: 94000b6e     	bl	0x400036e8 <uart_puts>
40000934: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000938: 912bb000     	add	x0, x0, #0xaec
4000093c: 94000b6b     	bl	0x400036e8 <uart_puts>
40000940: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000944: 91006400     	add	x0, x0, #0x19
40000948: 94000b68     	bl	0x400036e8 <uart_puts>
4000094c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000b65     	bl	0x400036e8 <uart_puts>
40000958: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000095c: 91015000     	add	x0, x0, #0x54
40000960: 94000b62     	bl	0x400036e8 <uart_puts>
40000964: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000968: 9119b000     	add	x0, x0, #0x66c
4000096c: 94000b5f     	bl	0x400036e8 <uart_puts>
40000970: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000974: 91035000     	add	x0, x0, #0xd4
40000978: 94000c71     	bl	0x40003b3c <uart_printf>
4000097c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000980: 91226400     	add	x0, x0, #0x899
40000984: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000988: 91184021     	add	x1, x1, #0x610
4000098c: 94000c6c     	bl	0x40003b3c <uart_printf>
40000990: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000994: 910ab400     	add	x0, x0, #0x2ad
40000998: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000099c: 91024021     	add	x1, x1, #0x90
400009a0: 94000c67     	bl	0x40003b3c <uart_printf>
400009a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009a8: 9134c800     	add	x0, x0, #0xd32
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000b4e     	b	0x400036e8 <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009bc: 910a3000     	add	x0, x0, #0x28c
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b49     	bl	0x400036e8 <uart_puts>
400009c8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009cc: 911c4c00     	add	x0, x0, #0x713
400009d0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009d4: 91028421     	add	x1, x1, #0xa1
400009d8: 94000c59     	bl	0x40003b3c <uart_printf>
400009dc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009e0: 91292800     	add	x0, x0, #0xa4a
400009e4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
400009e8: 91184021     	add	x1, x1, #0x610
400009ec: 94000c54     	bl	0x40003b3c <uart_printf>
400009f0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009f4: 91125400     	add	x0, x0, #0x495
400009f8: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009fc: 91024021     	add	x1, x1, #0x90
40000a00: 94000c4f     	bl	0x40003b3c <uart_printf>
40000a04: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000a08: 910bf400     	add	x0, x0, #0x2fd
40000a0c: 94000b37     	bl	0x400036e8 <uart_puts>
40000a10: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000a14: 91239800     	add	x0, x0, #0x8e6
40000a18: 94000b34     	bl	0x400036e8 <uart_puts>
40000a1c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a20: 91223800     	add	x0, x0, #0x88e
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b30     	b	0x400036e8 <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a34: 9108cc00     	add	x0, x0, #0x233
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b27     	bl	0x400036e8 <uart_puts>
40000a50: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a54: 9130f800     	add	x0, x0, #0xc3e
40000a58: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a5c: 91028421     	add	x1, x1, #0xa1
40000a60: b0000042     	adrp	x2, 0x40009000 <__rodata_start>
40000a64: 91184042     	add	x2, x2, #0x610
40000a68: 94000c35     	bl	0x40003b3c <uart_printf>
40000a6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a70: 91317400     	add	x0, x0, #0xc5d
40000a74: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a78: 91024021     	add	x1, x1, #0x90
40000a7c: 94000c30     	bl	0x40003b3c <uart_printf>
40000a80: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a84: 913c1800     	add	x0, x0, #0xf06
40000a88: 94000c2d     	bl	0x40003b3c <uart_printf>
40000a8c: f0000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
40000a90: 911c3508     	add	x8, x8, #0x70d
40000a94: f0000049     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40000a98: 910cc929     	add	x9, x9, #0x332
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000aa4: 9118ac00     	add	x0, x0, #0x62b
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000ab4: 912c9d29     	add	x9, x9, #0xb27
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c1f     	bl	0x40003b3c <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000acc: 911cb000     	add	x0, x0, #0x72c
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c1a     	bl	0x40003b3c <uart_printf>
40000ad8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000adc: 91375000     	add	x0, x0, #0xdd4
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c15     	bl	0x40003b3c <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 1003c582     	adr	x2, 0x400083a8 <__text_end>
40000afc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b00: 91352000     	add	x0, x0, #0xd48
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c0d     	bl	0x40003b3c <uart_printf>
40000b0c: d503201f     	nop
40000b10: 10042781     	adr	x1, 0x40009000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 10057702     	adr	x2, 0x4000b9f8 <__rodata_end>
40000b1c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b20: 911ce000     	add	x0, x0, #0x738
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000c05     	bl	0x40003b3c <uart_printf>
40000b2c: d503201f     	nop
40000b30: 1005a681     	adr	x1, 0x4000c000 <next_pid>
40000b34: d503201f     	nop
40000b38: 101e14c2     	adr	x2, 0x4003cdd0
40000b3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b40: 912ff000     	add	x0, x0, #0xbfc
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000bfd     	bl	0x40003b3c <uart_printf>
40000b4c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b50: 9104d800     	add	x0, x0, #0x136
40000b54: d503201f     	nop
40000b58: 102613c1     	adr	x1, 0x4004cdd0 <__stack_top>
40000b5c: 94000bf8     	bl	0x40003b3c <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b68: 91223800     	add	x0, x0, #0x88e
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000ade     	b	0x400036e8 <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000b7c: 910cf400     	add	x0, x0, #0x33d
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000ad9     	bl	0x400036e8 <uart_puts>
40000b88: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b8c: 9137b800     	add	x0, x0, #0xdee
40000b90: 94000ad6     	bl	0x400036e8 <uart_puts>
40000b94: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b98: 91193000     	add	x0, x0, #0x64c
40000b9c: 94000ad3     	bl	0x400036e8 <uart_puts>
40000ba0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ba4: 9131dc00     	add	x0, x0, #0xc77
40000ba8: 94000ad0     	bl	0x400036e8 <uart_puts>
40000bac: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bb0: 911d8800     	add	x0, x0, #0x762
40000bb4: 94000acd     	bl	0x400036e8 <uart_puts>
40000bb8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000bbc: 910c6c00     	add	x0, x0, #0x31b
40000bc0: 94000aca     	bl	0x400036e8 <uart_puts>
40000bc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bc8: 9135c800     	add	x0, x0, #0xd72
40000bcc: 94000ac7     	bl	0x400036e8 <uart_puts>
40000bd0: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000bd4: 911c6400     	add	x0, x0, #0x719
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000ac3     	b	0x400036e8 <uart_puts>

0000000040000be0 <read_line>:
40000be0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000be4: f9000bf7     	str	x23, [sp, #0x10]
40000be8: aa1f03f7     	mov	x23, xzr
40000bec: 910003fd     	mov	x29, sp
40000bf0: a90257f6     	stp	x22, x21, [sp, #0x20]
40000bf4: d1000435     	sub	x21, x1, #0x1
40000bf8: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000bfc: aa0003f3     	mov	x19, x0
40000c00: f0000054     	adrp	x20, 0x4000b000 <__rodata_start+0x2000>
40000c04: 91240694     	add	x20, x20, #0x901
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000aeb     	bl	0x400037b8 <uart_getc>
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
40000c60: 94000a8b     	bl	0x4000368c <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000a9c     	bl	0x400036e8 <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000c84: 91055800     	add	x0, x0, #0x156
40000c88: 94000a98     	bl	0x400036e8 <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cac: 912ccc00     	add	x0, x0, #0xb33
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000a8d     	bl	0x400036e8 <uart_puts>
40000cb8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cbc: 91160800     	add	x0, x0, #0x582
40000cc0: 94000a8a     	bl	0x400036e8 <uart_puts>
40000cc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cc8: 91249800     	add	x0, x0, #0x926
40000ccc: 94000a87     	bl	0x400036e8 <uart_puts>
40000cd0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cd4: 91056400     	add	x0, x0, #0x159
40000cd8: 94000a84     	bl	0x400036e8 <uart_puts>
40000cdc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ce0: 91095c00     	add	x0, x0, #0x257
40000ce4: 94000a81     	bl	0x400036e8 <uart_puts>
40000ce8: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cec: 9102b000     	add	x0, x0, #0xac
40000cf0: 94000a7e     	bl	0x400036e8 <uart_puts>
40000cf4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cf8: 911d9000     	add	x0, x0, #0x764
40000cfc: 94000a7b     	bl	0x400036e8 <uart_puts>
40000d00: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d04: 911eb400     	add	x0, x0, #0x7ad
40000d08: 94000a78     	bl	0x400036e8 <uart_puts>
40000d0c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d10: 91239400     	add	x0, x0, #0x8e5
40000d14: 94000a75     	bl	0x400036e8 <uart_puts>
40000d18: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d1c: 911ea800     	add	x0, x0, #0x7aa
40000d20: 94000a72     	bl	0x400036e8 <uart_puts>
40000d24: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d28: 91249800     	add	x0, x0, #0x926
40000d2c: 94000a6f     	bl	0x400036e8 <uart_puts>
40000d30: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d34: 9136e400     	add	x0, x0, #0xdb9
40000d38: 94000a6c     	bl	0x400036e8 <uart_puts>
40000d3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d40: 91041c00     	add	x0, x0, #0x107
40000d44: 94000a69     	bl	0x400036e8 <uart_puts>
40000d48: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d4c: 910dd400     	add	x0, x0, #0x375
40000d50: 94000a66     	bl	0x400036e8 <uart_puts>
40000d54: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d58: 91258800     	add	x0, x0, #0x962
40000d5c: 94000a63     	bl	0x400036e8 <uart_puts>
40000d60: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d64: 9138bc00     	add	x0, x0, #0xe2f
40000d68: 94000a60     	bl	0x400036e8 <uart_puts>
40000d6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d70: 9109f800     	add	x0, x0, #0x27e
40000d74: 94000a5d     	bl	0x400036e8 <uart_puts>
40000d78: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d7c: 911d4c00     	add	x0, x0, #0x753
40000d80: 94000a5a     	bl	0x400036e8 <uart_puts>
40000d84: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d88: 91241400     	add	x0, x0, #0x905
40000d8c: 94000a57     	bl	0x400036e8 <uart_puts>
40000d90: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d94: 91151400     	add	x0, x0, #0x545
40000d98: 94000a54     	bl	0x400036e8 <uart_puts>
40000d9c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000da0: 910ab800     	add	x0, x0, #0x2ae
40000da4: 94000a51     	bl	0x400036e8 <uart_puts>
40000da8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dac: 910da400     	add	x0, x0, #0x369
40000db0: 94000a4e     	bl	0x400036e8 <uart_puts>
40000db4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000db8: 910eb800     	add	x0, x0, #0x3ae
40000dbc: 94000a4b     	bl	0x400036e8 <uart_puts>
40000dc0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dc4: 9125a000     	add	x0, x0, #0x968
40000dc8: 94000a48     	bl	0x400036e8 <uart_puts>
40000dcc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dd0: 91162400     	add	x0, x0, #0x589
40000dd4: 94000a45     	bl	0x400036e8 <uart_puts>
40000dd8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000ddc: 91123c00     	add	x0, x0, #0x48f
40000de0: 94000a42     	bl	0x400036e8 <uart_puts>
40000de4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000de8: 91253800     	add	x0, x0, #0x94e
40000dec: 94000a3f     	bl	0x400036e8 <uart_puts>
40000df0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000df4: 911f8400     	add	x0, x0, #0x7e1
40000df8: 94000a3c     	bl	0x400036e8 <uart_puts>
40000dfc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e00: 91379400     	add	x0, x0, #0xde5
40000e04: 94000a39     	bl	0x400036e8 <uart_puts>
40000e08: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e0c: 9104e400     	add	x0, x0, #0x139
40000e10: 94000a36     	bl	0x400036e8 <uart_puts>
40000e14: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000e18: 910fc000     	add	x0, x0, #0x3f0
40000e1c: 94000a33     	bl	0x400036e8 <uart_puts>
40000e20: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e24: 912c5400     	add	x0, x0, #0xb15
40000e28: 94000a30     	bl	0x400036e8 <uart_puts>
40000e2c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000e30: 911e7400     	add	x0, x0, #0x79d
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a2c     	b	0x400036e8 <uart_puts>

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
40000f00: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f04: 9129d421     	add	x1, x1, #0xa75
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 9400065b     	bl	0x4000287c <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f1c: 91280821     	add	x1, x1, #0xa02
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 94000656     	bl	0x4000287c <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f30: 910ac421     	add	x1, x1, #0x2b1
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 94000651     	bl	0x4000287c <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f44: 9139bc21     	add	x1, x1, #0xe6f
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 9400064c     	bl	0x4000287c <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f58: 910cb021     	add	x1, x1, #0x32c
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 94000647     	bl	0x4000287c <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f6c: 91261421     	add	x1, x1, #0x985
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 94000642     	bl	0x4000287c <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f80: 913cdc21     	add	x1, x1, #0xf37
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 9400063d     	bl	0x4000287c <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000f94: 91147021     	add	x1, x1, #0x51c
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 94000638     	bl	0x4000287c <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000fa8: 912e1c21     	add	x1, x1, #0xb87
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000633     	bl	0x4000287c <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fbc: 912d1821     	add	x1, x1, #0xb46
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 9400062e     	bl	0x4000287c <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fd0: 91167421     	add	x1, x1, #0x59d
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 94000629     	bl	0x4000287c <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000fe4: 911fb421     	add	x1, x1, #0x7ed
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000624     	bl	0x4000287c <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000ff8: 91133021     	add	x1, x1, #0x4cc
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 9400061f     	bl	0x4000287c <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000100c: 91261821     	add	x1, x1, #0x986
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 9400061a     	bl	0x4000287c <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001020: 9131c421     	add	x1, x1, #0xc71
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 94000615     	bl	0x4000287c <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001034: 91263421     	add	x1, x1, #0x98d
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 94000610     	bl	0x4000287c <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001048: 9103c021     	add	x1, x1, #0xf0
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 9400060b     	bl	0x4000287c <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000105c: 91067021     	add	x1, x1, #0x19c
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 94000606     	bl	0x4000287c <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001070: 910cbc21     	add	x1, x1, #0x32f
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 94000601     	bl	0x4000287c <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001084: 9112b821     	add	x1, x1, #0x4ae
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 940005fc     	bl	0x4000287c <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001098: 91202821     	add	x1, x1, #0x80a
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 940005f7     	bl	0x4000287c <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010ac: 91215c21     	add	x1, x1, #0x857
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 940005f2     	bl	0x4000287c <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010c0: 91085821     	add	x1, x1, #0x216
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 940005ed     	bl	0x4000287c <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010d4: 9112d021     	add	x1, x1, #0x4b4
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 940005e8     	bl	0x4000287c <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010e8: 91217421     	add	x1, x1, #0x85d
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 940005e3     	bl	0x4000287c <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010fc: 91204021     	add	x1, x1, #0x810
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 940005de     	bl	0x4000287c <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001110: 910af021     	add	x1, x1, #0x2bc
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 940005d9     	bl	0x4000287c <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001124: 910f2421     	add	x1, x1, #0x3c9
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 940005d4     	bl	0x4000287c <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001138: 91333c21     	add	x1, x1, #0xccf
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 940005cf     	bl	0x4000287c <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000114c: 9125c021     	add	x1, x1, #0x970
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 940005ca     	bl	0x4000287c <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001160: 9114bc21     	add	x1, x1, #0x52f
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 940005c5     	bl	0x4000287c <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001174: 91322821     	add	x1, x1, #0xc8a
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 940005c0     	bl	0x4000287c <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001188: 9114d000     	add	x0, x0, #0x534
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011a0: 910a3000     	add	x0, x0, #0x28c
400011a4: 94000951     	bl	0x400036e8 <uart_puts>
400011a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011ac: 911c4c00     	add	x0, x0, #0x713
400011b0: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011b4: 91028421     	add	x1, x1, #0xa1
400011b8: 94000a61     	bl	0x40003b3c <uart_printf>
400011bc: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011c0: 91292800     	add	x0, x0, #0xa4a
400011c4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400011c8: 91184021     	add	x1, x1, #0x610
400011cc: 94000a5c     	bl	0x40003b3c <uart_printf>
400011d0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011d4: 91125400     	add	x0, x0, #0x495
400011d8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011dc: 91024021     	add	x1, x1, #0x90
400011e0: 94000a57     	bl	0x40003b3c <uart_printf>
400011e4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400011e8: 910bf400     	add	x0, x0, #0x2fd
400011ec: 9400093f     	bl	0x400036e8 <uart_puts>
400011f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011f4: 91239800     	add	x0, x0, #0x8e6
400011f8: 9400093c     	bl	0x400036e8 <uart_puts>
400011fc: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001200: 91223800     	add	x0, x0, #0x88e
40001204: 94000939     	bl	0x400036e8 <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001210: 91059800     	add	x0, x0, #0x166
40001214: 94000935     	bl	0x400036e8 <uart_puts>
40001218: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000121c: 910b8400     	add	x0, x0, #0x2e1
40001220: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001224: 91184021     	add	x1, x1, #0x610
40001228: 94000a45     	bl	0x40003b3c <uart_printf>
4000122c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001230: 91309800     	add	x0, x0, #0xc26
40001234: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001238: 91024021     	add	x1, x1, #0x90
4000123c: 94000a40     	bl	0x40003b3c <uart_printf>
40001240: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001244: 9105d400     	add	x0, x0, #0x175
40001248: 94000928     	bl	0x400036e8 <uart_puts>
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
40001274: 94000572     	bl	0x4000283c <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000f81     	bl	0x40005084 <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000128c: 91140800     	add	x0, x0, #0x502
40001290: 94000916     	bl	0x400036e8 <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 94000568     	bl	0x4000283c <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 94000638     	bl	0x40002b90 <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 940001ff     	bl	0x40001ab8 <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012c8: 911a5c00     	add	x0, x0, #0x697
400012cc: 94000907     	bl	0x400036e8 <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400012d8: 91331400     	add	x0, x0, #0xcc5
400012dc: 94000903     	bl	0x400036e8 <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012e8: 91384800     	add	x0, x0, #0xe12
400012ec: 940008ff     	bl	0x400036e8 <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000333     	bl	0x40001fc0 <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 9400054f     	bl	0x4000283c <kstrlen>
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
40001344: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001348: 91262c21     	add	x1, x1, #0x98b
4000134c: aa1303e0     	mov	x0, x19
40001350: 940005b5     	bl	0x40002a24 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f36     	bl	0x40005044 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001378: 910ae421     	add	x1, x1, #0x2b9
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 9400053f     	bl	0x4000287c <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000138c: 911b5000     	add	x0, x0, #0x6d4
40001390: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001394: 91028421     	add	x1, x1, #0xa1
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400013a0: 91173c00     	add	x0, x0, #0x5cf
400013a4: 940008d1     	bl	0x400036e8 <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 9400026e     	bl	0x40001d6c <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013c8: 91081c00     	add	x0, x0, #0x207
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013d4: 91086c00     	add	x0, x0, #0x21b
400013d8: 940008c4     	bl	0x400036e8 <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013e4: 911b5000     	add	x0, x0, #0x6d4
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013f4: 911ab400     	add	x0, x0, #0x6ad
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 940009d0     	bl	0x40003b3c <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d43     	bl	0x40004910 <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 9400050b     	bl	0x4000283c <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000d8f     	bl	0x40004a58 <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: b0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40001434: 911fc908     	add	x8, x8, #0x7f2
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 940009bf     	bl	0x40003b3c <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d33     	bl	0x4000491c <vfs_getcwd>
40001454: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001458: 911b5000     	add	x0, x0, #0x6d4
4000145c: 910003e1     	mov	x1, sp
40001460: 940009b7     	bl	0x40003b3c <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000146c: 9120a000     	add	x0, x0, #0x828
40001470: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001474: 91028421     	add	x1, x1, #0xa1
40001478: 90000042     	adrp	x2, 0x40009000 <__rodata_start>
4000147c: 91184042     	add	x2, x2, #0x610
40001480: d0000043     	adrp	x3, 0x4000b000 <__rodata_start+0x2000>
40001484: 91024063     	add	x3, x3, #0x90
40001488: 940009ad     	bl	0x40003b3c <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f35     	bl	0x40005168 <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000dd3     	bl	0x40004bec <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014ac: 910e9400     	add	x0, x0, #0x3a5
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014bc: 91178800     	add	x0, x0, #0x5e2
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 940004dc     	bl	0x4000283c <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000d60     	bl	0x40004a58 <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400014ec: 910ccc00     	add	x0, x0, #0x333
400014f0: 9400087e     	bl	0x400036e8 <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 940004d0     	bl	0x4000283c <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000dde     	bl	0x40004c80 <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001514: 91091000     	add	x0, x0, #0x244
40001518: 94000874     	bl	0x400036e8 <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 940004c6     	bl	0x4000283c <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e29     	bl	0x40004dd8 <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001540: 91148000     	add	x0, x0, #0x520
40001544: 94000869     	bl	0x400036e8 <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001550: 91108c00     	add	x0, x0, #0x423
40001554: 94000865     	bl	0x400036e8 <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 9400054b     	bl	0x40002a90 <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000eb3     	bl	0x40005044 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001584: 91134800     	add	x0, x0, #0x4d2
40001588: 94000858     	bl	0x400036e8 <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001594: 91187800     	add	x0, x0, #0x61e
40001598: 94000854     	bl	0x400036e8 <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015a4: 910c4c00     	add	x0, x0, #0x313
400015a8: 94000850     	bl	0x400036e8 <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015b4: 91223800     	add	x0, x0, #0x88e
400015b8: 9400084c     	bl	0x400036e8 <uart_puts>
400015bc: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015c0: 913cf400     	add	x0, x0, #0xf3d
400015c4: 94000849     	bl	0x400036e8 <uart_puts>
400015c8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 94000846     	bl	0x400036e8 <uart_puts>
400015d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015d8: 9139dc00     	add	x0, x0, #0xe77
400015dc: 94000843     	bl	0x400036e8 <uart_puts>
400015e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015e4: 91138400     	add	x0, x0, #0x4e1
400015e8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400015ec: 91024021     	add	x1, x1, #0x90
400015f0: 94000953     	bl	0x40003b3c <uart_printf>
400015f4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015f8: 91264000     	add	x0, x0, #0x990
400015fc: 9400083b     	bl	0x400036e8 <uart_puts>
40001600: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001604: 911fc800     	add	x0, x0, #0x7f2
40001608: 94000838     	bl	0x400036e8 <uart_puts>
4000160c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001610: 9118cc00     	add	x0, x0, #0x633
40001614: 94000835     	bl	0x400036e8 <uart_puts>
40001618: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000161c: 912e3c00     	add	x0, x0, #0xb8f
40001620: 94000832     	bl	0x400036e8 <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: 90000048     	adrp	x8, 0x40009000 <__rodata_start>
4000162c: 911b5108     	add	x8, x8, #0x6d4
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001640: 9131d400     	add	x0, x0, #0xc75
40001644: 94000829     	bl	0x400036e8 <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001650: 9138ac00     	add	x0, x0, #0xe2b
40001654: 94000825     	bl	0x400036e8 <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 94000477     	bl	0x4000283c <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 9400043c     	bl	0x4000275c <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001678: 9110e800     	add	x0, x0, #0x43a
4000167c: 9400081b     	bl	0x400036e8 <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001688: 913c7000     	add	x0, x0, #0xf1c
4000168c: 94000817     	bl	0x400036e8 <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: 90000055     	adrp	x21, 0x40009000 <__rodata_start>
40001698: 911402b5     	add	x21, x21, #0x500
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 940007f9     	bl	0x4000368c <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 940007f6     	bl	0x4000368c <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 940007f4     	bl	0x4000368c <uart_putc>
400016c0: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
400016c4: 910d2273     	add	x19, x19, #0x348
400016c8: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400016cc: 91223a94     	add	x20, x20, #0x88e
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 940007e8     	bl	0x4000368c <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 940007e5     	bl	0x4000368c <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 940007e3     	bl	0x4000368c <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 940007f3     	bl	0x400036e8 <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 940007ef     	bl	0x400036e8 <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001738: 91393800     	add	x0, x0, #0xe4e
4000173c: 940007eb     	bl	0x400036e8 <uart_puts>
40001740: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001744: 91094c00     	add	x0, x0, #0x253
40001748: 940007e8     	bl	0x400036e8 <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001764: 912ec000     	add	x0, x0, #0xbb0
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 940007d9     	bl	0x400036e8 <uart_puts>
40001788: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
4000178c: 913d0273     	add	x19, x19, #0xf40
40001790: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40001794: 91067e94     	add	x20, x20, #0x19f
40001798: d0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
4000179c: 912406b5     	add	x21, x21, #0x901
400017a0: b0000056     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
400017a4: 91055ad6     	add	x22, x22, #0x156
400017a8: d0000057     	adrp	x23, 0x4000b000 <__rodata_start+0x2000>
400017ac: 9125c2f7     	add	x23, x23, #0x970
400017b0: d0000058     	adrp	x24, 0x4000b000 <__rodata_start+0x2000>
400017b4: 9114bf18     	add	x24, x24, #0x52f
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: 90000059     	adrp	x25, 0x40009000 <__rodata_start>
400017c0: 91322b39     	add	x25, x25, #0xc8a
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000c54     	bl	0x4000491c <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 940008d9     	bl	0x40003b3c <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 940007c2     	bl	0x400036e8 <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 940007f3     	bl	0x400037b8 <uart_getc>
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
40001840: 94000793     	bl	0x4000368c <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 940007a4     	bl	0x400036e8 <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 940007a1     	bl	0x400036e8 <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 940003f3     	bl	0x4000283c <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 940002f3     	bl	0x40002448 <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 940003fd     	bl	0x4000287c <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 940003f9     	bl	0x4000287c <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 940003f5     	bl	0x4000287c <kstrcmp>
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
400018ec: 9400075c     	bl	0x4000365c <uart_init>
400018f0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400018f4: 910c4c00     	add	x0, x0, #0x313
400018f8: 9400077c     	bl	0x400036e8 <uart_puts>
400018fc: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001900: 91168800     	add	x0, x0, #0x5a2
40001904: 94000779     	bl	0x400036e8 <uart_puts>
40001908: b90003ff     	str	wzr, [sp]
4000190c: b94003e8     	ldr	w8, [sp]
40001910: 6b13011f     	cmp	w8, w19
40001914: 540000aa     	b.ge	0x40001928 <kmain+0x58>
40001918: b94003e8     	ldr	w8, [sp]
4000191c: 11000508     	add	w8, w8, #0x1
40001920: b90003e8     	str	w8, [sp]
40001924: 17fffffa     	b	0x4000190c <kmain+0x3c>
40001928: 528aa213     	mov	w19, #0x5510            // =21776
4000192c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001930: 910d2800     	add	x0, x0, #0x34a
40001934: 72a00453     	movk	w19, #0x22, lsl #16
40001938: 9400076c     	bl	0x400036e8 <uart_puts>
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
40001964: 94000a82     	bl	0x4000436c <vfs_init>
40001968: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000196c: 9126f800     	add	x0, x0, #0x9be
40001970: 9400075e     	bl	0x400036e8 <uart_puts>
40001974: b90003ff     	str	wzr, [sp]
40001978: b94003e8     	ldr	w8, [sp]
4000197c: 6b14011f     	cmp	w8, w20
40001980: 540000aa     	b.ge	0x40001994 <kmain+0xc4>
40001984: b94003e8     	ldr	w8, [sp]
40001988: 11000508     	add	w8, w8, #0x1
4000198c: b90003e8     	str	w8, [sp]
40001990: 17fffffa     	b	0x40001978 <kmain+0xa8>
40001994: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001998: 91087000     	add	x0, x0, #0x21c
4000199c: d503201f     	nop
400019a0: 1002f308     	adr	x8, 0x40007800 <exception_vector_table>
400019a4: d518c008     	msr	VBAR_EL1, x8
400019a8: 94000750     	bl	0x400036e8 <uart_puts>
400019ac: b90003ff     	str	wzr, [sp]
400019b0: b94003e8     	ldr	w8, [sp]
400019b4: 6b13011f     	cmp	w8, w19
400019b8: 540000aa     	b.ge	0x400019cc <kmain+0xfc>
400019bc: b94003e8     	ldr	w8, [sp]
400019c0: 11000508     	add	w8, w8, #0x1
400019c4: b90003e8     	str	w8, [sp]
400019c8: 17fffffa     	b	0x400019b0 <kmain+0xe0>
400019cc: 97fffa12     	bl	0x40000214 <gic_init>
400019d0: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400019d4: 91207000     	add	x0, x0, #0x81c
400019d8: 94000744     	bl	0x400036e8 <uart_puts>
400019dc: b90003ff     	str	wzr, [sp]
400019e0: b94003e8     	ldr	w8, [sp]
400019e4: 6b13011f     	cmp	w8, w19
400019e8: 540000aa     	b.ge	0x400019fc <kmain+0x12c>
400019ec: b94003e8     	ldr	w8, [sp]
400019f0: 11000508     	add	w8, w8, #0x1
400019f4: b90003e8     	str	w8, [sp]
400019f8: 17fffffa     	b	0x400019e0 <kmain+0x110>
400019fc: 94000443     	bl	0x40002b08 <timer_init>
40001a00: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001a04: 9129e800     	add	x0, x0, #0xa7a
40001a08: 94000738     	bl	0x400036e8 <uart_puts>
40001a0c: b90003ff     	str	wzr, [sp]
40001a10: b94003e8     	ldr	w8, [sp]
40001a14: 6b13011f     	cmp	w8, w19
40001a18: 540000aa     	b.ge	0x40001a2c <kmain+0x15c>
40001a1c: b94003e8     	ldr	w8, [sp]
40001a20: 11000508     	add	w8, w8, #0x1
40001a24: b90003e8     	str	w8, [sp]
40001a28: 17fffffa     	b	0x40001a10 <kmain+0x140>
40001a2c: 94000e15     	bl	0x40005280 <pmm_init>
40001a30: 94000ea9     	bl	0x400054d4 <sched_init>
40001a34: 94000f68     	bl	0x400057d4 <virtio_blk_init>
40001a38: 34000160     	cbz	w0, 0x40001a64 <kmain+0x194>
40001a3c: 910003e1     	mov	x1, sp
40001a40: aa1f03e0     	mov	x0, xzr
40001a44: 94000fae     	bl	0x400058fc <virtio_blk_read_sector>
40001a48: 34000080     	cbz	w0, 0x40001a58 <kmain+0x188>
40001a4c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001a50: 913eb000     	add	x0, x0, #0xfac
40001a54: 94000725     	bl	0x400036e8 <uart_puts>
40001a58: 9400111a     	bl	0x40005ec0 <fat16_init>
40001a5c: 94000e08     	bl	0x4000527c <vfs_load>
40001a60: 940010e3     	bl	0x40005dec <virtio_net_init>
40001a64: 529e1014     	mov	w20, #0xf080            // =61568
40001a68: d503201f     	nop
40001a6c: 10ff72a0     	adr	x0, 0x400008c0 <system_idle_daemon>
40001a70: 72a05f54     	movk	w20, #0x2fa, lsl #16
40001a74: 94000ebf     	bl	0x40005570 <sched_create_task>
40001a78: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001a7c: 911b6000     	add	x0, x0, #0x6d8
40001a80: 9400071a     	bl	0x400036e8 <uart_puts>
40001a84: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
40001a88: 91323e73     	add	x19, x19, #0xc8f
40001a8c: d50342ff     	msr	DAIFClr, #0x2
40001a90: aa1303e0     	mov	x0, x19
40001a94: 94000715     	bl	0x400036e8 <uart_puts>
40001a98: b90003ff     	str	wzr, [sp]
40001a9c: b94003e8     	ldr	w8, [sp]
40001aa0: 6b14011f     	cmp	w8, w20
40001aa4: 54ffff6a     	b.ge	0x40001a90 <kmain+0x1c0>
40001aa8: b94003e8     	ldr	w8, [sp]
40001aac: 11000508     	add	w8, w8, #0x1
40001ab0: b90003e8     	str	w8, [sp]
40001ab4: 17fffffa     	b	0x40001a9c <kmain+0x1cc>

0000000040001ab8 <kproj_execute>:
40001ab8: d10683ff     	sub	sp, sp, #0x1a0
40001abc: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001ac0: 910603fd     	add	x29, sp, #0x180
40001ac4: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001ac8: b40001c0     	cbz	x0, 0x40001b00 <kproj_execute+0x48>
40001acc: aa0003f3     	mov	x19, x0
40001ad0: 9400035b     	bl	0x4000283c <kstrlen>
40001ad4: b4000160     	cbz	x0, 0x40001b00 <kproj_execute+0x48>
40001ad8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001adc: 91298c00     	add	x0, x0, #0xa63
40001ae0: aa1303e1     	mov	x1, x19
40001ae4: 94000816     	bl	0x40003b3c <uart_printf>
40001ae8: aa1303e0     	mov	x0, x19
40001aec: 94000c65     	bl	0x40004c80 <vfs_mkdir>
40001af0: 34000140     	cbz	w0, 0x40001b18 <kproj_execute+0x60>
40001af4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001af8: 9125d400     	add	x0, x0, #0x975
40001afc: 14000003     	b	0x40001b08 <kproj_execute+0x50>
40001b00: d503201f     	nop
40001b04: 1004d280     	adr	x0, 0x4000b554 <__rodata_start+0x2554>
40001b08: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001b0c: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001b10: 910683ff     	add	sp, sp, #0x1a0
40001b14: 140006f5     	b	0x400036e8 <uart_puts>
40001b18: aa1303e0     	mov	x0, x19
40001b1c: 94000c34     	bl	0x40004bec <vfs_chdir>
40001b20: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001b24: 9106f000     	add	x0, x0, #0x1bc
40001b28: 94000c56     	bl	0x40004c80 <vfs_mkdir>
40001b2c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001b30: 91204c00     	add	x0, x0, #0x813
40001b34: 94000c53     	bl	0x40004c80 <vfs_mkdir>
40001b38: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001b3c: 9109a421     	add	x1, x1, #0x269
40001b40: 910203e0     	add	x0, sp, #0x80
40001b44: 9400036d     	bl	0x400028f8 <kstrcpy>
40001b48: 910203e0     	add	x0, sp, #0x80
40001b4c: aa1303e1     	mov	x1, x19
40001b50: 94000342     	bl	0x40002858 <kstrcat>
40001b54: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001b58: 913fa421     	add	x1, x1, #0xfe9
40001b5c: 910203e0     	add	x0, sp, #0x80
40001b60: 9400033e     	bl	0x40002858 <kstrcat>
40001b64: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001b68: 91263400     	add	x0, x0, #0x98d
40001b6c: 910203e1     	add	x1, sp, #0x80
40001b70: 94000c9a     	bl	0x40004dd8 <vfs_touch>
40001b74: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001b78: 9109e400     	add	x0, x0, #0x279
40001b7c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001b80: 91324421     	add	x1, x1, #0xc91
40001b84: 94000c95     	bl	0x40004dd8 <vfs_touch>
40001b88: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001b8c: 910b0021     	add	x1, x1, #0x2c0
40001b90: 910003e0     	mov	x0, sp
40001b94: 94000359     	bl	0x400028f8 <kstrcpy>
40001b98: 910003e0     	mov	x0, sp
40001b9c: aa1303e1     	mov	x1, x19
40001ba0: 9400032e     	bl	0x40002858 <kstrcat>
40001ba4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001ba8: 912d2c21     	add	x1, x1, #0xb4b
40001bac: 910003e0     	mov	x0, sp
40001bb0: 9400032a     	bl	0x40002858 <kstrcat>
40001bb4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001bb8: 91005400     	add	x0, x0, #0x15
40001bbc: 910003e1     	mov	x1, sp
40001bc0: 94000c86     	bl	0x40004dd8 <vfs_touch>
40001bc4: 94000c84     	bl	0x40004dd4 <vfs_sync>
40001bc8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001bcc: 91144400     	add	x0, x0, #0x511
40001bd0: 940006c6     	bl	0x400036e8 <uart_puts>
40001bd4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001bd8: 91150000     	add	x0, x0, #0x540
40001bdc: aa1303e1     	mov	x1, x19
40001be0: 940007d7     	bl	0x40003b3c <uart_printf>
40001be4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001be8: 91070000     	add	x0, x0, #0x1c0
40001bec: 94000c00     	bl	0x40004bec <vfs_chdir>
40001bf0: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001bf4: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001bf8: 910683ff     	add	sp, sp, #0x1a0
40001bfc: d65f03c0     	ret

0000000040001c00 <process_init>:
40001c00: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001c04: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001c08: f0000054     	adrp	x20, 0x4000c000 <next_pid>
40001c0c: d503201f     	nop
40001c10: 10073233     	adr	x19, 0x40010254 <proc_table>
40001c14: b9400289     	ldr	w9, [x20]
40001c18: 52800068     	mov	w8, #0x3                // =3
40001c1c: b9002668     	str	w8, [x19, #0x24]
40001c20: d503201f     	nop
40001c24: 70047501     	adr	x1, 0x4000aac7 <__rodata_start+0x1ac7>
40001c28: b9005668     	str	w8, [x19, #0x54]
40001c2c: 91001260     	add	x0, x19, #0x4
40001c30: 910003fd     	mov	x29, sp
40001c34: b9008668     	str	w8, [x19, #0x84]
40001c38: b900b668     	str	w8, [x19, #0xb4]
40001c3c: b900e668     	str	w8, [x19, #0xe4]
40001c40: b9011668     	str	w8, [x19, #0x114]
40001c44: b9014668     	str	w8, [x19, #0x144]
40001c48: b9017668     	str	w8, [x19, #0x174]
40001c4c: b901a668     	str	w8, [x19, #0x1a4]
40001c50: b901d668     	str	w8, [x19, #0x1d4]
40001c54: b9020668     	str	w8, [x19, #0x204]
40001c58: b9023668     	str	w8, [x19, #0x234]
40001c5c: b9026668     	str	w8, [x19, #0x264]
40001c60: b9029668     	str	w8, [x19, #0x294]
40001c64: b902c668     	str	w8, [x19, #0x2c4]
40001c68: b902f668     	str	w8, [x19, #0x2f4]
40001c6c: 11000528     	add	w8, w9, #0x1
40001c70: f9000bf5     	str	x21, [sp, #0x10]
40001c74: b900327f     	str	wzr, [x19, #0x30]
40001c78: b900627f     	str	wzr, [x19, #0x60]
40001c7c: b900927f     	str	wzr, [x19, #0x90]
40001c80: b900c27f     	str	wzr, [x19, #0xc0]
40001c84: b900f27f     	str	wzr, [x19, #0xf0]
40001c88: b901227f     	str	wzr, [x19, #0x120]
40001c8c: b901527f     	str	wzr, [x19, #0x150]
40001c90: b901827f     	str	wzr, [x19, #0x180]
40001c94: b901b27f     	str	wzr, [x19, #0x1b0]
40001c98: b901e27f     	str	wzr, [x19, #0x1e0]
40001c9c: b902127f     	str	wzr, [x19, #0x210]
40001ca0: b902427f     	str	wzr, [x19, #0x240]
40001ca4: b902727f     	str	wzr, [x19, #0x270]
40001ca8: b902a27f     	str	wzr, [x19, #0x2a0]
40001cac: b902d27f     	str	wzr, [x19, #0x2d0]
40001cb0: b9000288     	str	w8, [x20]
40001cb4: b9000269     	str	w9, [x19]
40001cb8: 94000310     	bl	0x400028f8 <kstrcpy>
40001cbc: b9400288     	ldr	w8, [x20]
40001cc0: 52a00209     	mov	w9, #0x100000           // =1048576
40001cc4: 5280384a     	mov	w10, #0x1c2             // =450
40001cc8: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001ccc: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001cd0: 9126b821     	add	x1, x1, #0x9ae
40001cd4: 11000509     	add	w9, w8, #0x1
40001cd8: 9100d260     	add	x0, x19, #0x34
40001cdc: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001ce0: b9000289     	str	w9, [x20]
40001ce4: 94000305     	bl	0x400028f8 <kstrcpy>
40001ce8: b9400288     	ldr	w8, [x20]
40001cec: 529d0009     	mov	w9, #0xe800             // =59392
40001cf0: 52800035     	mov	w21, #0x1               // =1
40001cf4: 72a00069     	movk	w9, #0x3, lsl #16
40001cf8: 5280018a     	mov	w10, #0xc               // =12
40001cfc: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001d00: 912db421     	add	x1, x1, #0xb6d
40001d04: 290aa675     	stp	w21, w9, [x19, #0x54]
40001d08: 11000509     	add	w9, w8, #0x1
40001d0c: 91019260     	add	x0, x19, #0x64
40001d10: b9000289     	str	w9, [x20]
40001d14: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001d18: 940002f8     	bl	0x400028f8 <kstrcpy>
40001d1c: b9400288     	ldr	w8, [x20]
40001d20: 52a00809     	mov	w9, #0x400000           // =4194304
40001d24: 5280960a     	mov	w10, #0x4b0             // =1200
40001d28: 2910a675     	stp	w21, w9, [x19, #0x84]
40001d2c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001d30: 9112e821     	add	x1, x1, #0x4ba
40001d34: 11000509     	add	w9, w8, #0x1
40001d38: 91025260     	add	x0, x19, #0x94
40001d3c: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001d40: b9000289     	str	w9, [x20]
40001d44: 940002ed     	bl	0x400028f8 <kstrcpy>
40001d48: 529a0008     	mov	w8, #0xd000             // =53248
40001d4c: 52800aa9     	mov	w9, #0x55               // =85
40001d50: f9400bf5     	ldr	x21, [sp, #0x10]
40001d54: 72a000e8     	movk	w8, #0x7, lsl #16
40001d58: b900be69     	str	w9, [x19, #0xbc]
40001d5c: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001d60: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001d64: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001d68: d65f03c0     	ret

0000000040001d6c <process_kill>:
40001d6c: 7100041f     	cmp	w0, #0x1
40001d70: 5400118b     	b.lt	0x40001fa0 <process_kill+0x234>
40001d74: d503201f     	nop
40001d78: 100726e9     	adr	x9, 0x40010254 <proc_table>
40001d7c: b9400128     	ldr	w8, [x9]
40001d80: 6b00011f     	cmp	w8, w0
40001d84: 54000081     	b.ne	0x40001d94 <process_kill+0x28>
40001d88: b9402528     	ldr	w8, [x9, #0x24]
40001d8c: 71000d1f     	cmp	w8, #0x3
40001d90: 54000f41     	b.ne	0x40001f78 <process_kill+0x20c>
40001d94: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001d98: 910a1129     	add	x9, x9, #0x284
40001d9c: b9400128     	ldr	w8, [x9]
40001da0: 6b00011f     	cmp	w8, w0
40001da4: 54000081     	b.ne	0x40001db4 <process_kill+0x48>
40001da8: b9402528     	ldr	w8, [x9, #0x24]
40001dac: 71000d1f     	cmp	w8, #0x3
40001db0: 54000e41     	b.ne	0x40001f78 <process_kill+0x20c>
40001db4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001db8: 910ad129     	add	x9, x9, #0x2b4
40001dbc: b9400128     	ldr	w8, [x9]
40001dc0: 6b00011f     	cmp	w8, w0
40001dc4: 54000081     	b.ne	0x40001dd4 <process_kill+0x68>
40001dc8: b9402528     	ldr	w8, [x9, #0x24]
40001dcc: 71000d1f     	cmp	w8, #0x3
40001dd0: 54000d41     	b.ne	0x40001f78 <process_kill+0x20c>
40001dd4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001dd8: 910b9129     	add	x9, x9, #0x2e4
40001ddc: b9400128     	ldr	w8, [x9]
40001de0: 6b00011f     	cmp	w8, w0
40001de4: 54000081     	b.ne	0x40001df4 <process_kill+0x88>
40001de8: b9402528     	ldr	w8, [x9, #0x24]
40001dec: 71000d1f     	cmp	w8, #0x3
40001df0: 54000c41     	b.ne	0x40001f78 <process_kill+0x20c>
40001df4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001df8: 910c5129     	add	x9, x9, #0x314
40001dfc: b9400128     	ldr	w8, [x9]
40001e00: 6b00011f     	cmp	w8, w0
40001e04: 54000081     	b.ne	0x40001e14 <process_kill+0xa8>
40001e08: b9402528     	ldr	w8, [x9, #0x24]
40001e0c: 71000d1f     	cmp	w8, #0x3
40001e10: 54000b41     	b.ne	0x40001f78 <process_kill+0x20c>
40001e14: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001e18: 910d1129     	add	x9, x9, #0x344
40001e1c: b9400128     	ldr	w8, [x9]
40001e20: 6b00011f     	cmp	w8, w0
40001e24: 54000081     	b.ne	0x40001e34 <process_kill+0xc8>
40001e28: b9402528     	ldr	w8, [x9, #0x24]
40001e2c: 71000d1f     	cmp	w8, #0x3
40001e30: 54000a41     	b.ne	0x40001f78 <process_kill+0x20c>
40001e34: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001e38: 910dd129     	add	x9, x9, #0x374
40001e3c: b9400128     	ldr	w8, [x9]
40001e40: 6b00011f     	cmp	w8, w0
40001e44: 54000081     	b.ne	0x40001e54 <process_kill+0xe8>
40001e48: b9402528     	ldr	w8, [x9, #0x24]
40001e4c: 71000d1f     	cmp	w8, #0x3
40001e50: 54000941     	b.ne	0x40001f78 <process_kill+0x20c>
40001e54: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001e58: 910e9129     	add	x9, x9, #0x3a4
40001e5c: b9400128     	ldr	w8, [x9]
40001e60: 6b00011f     	cmp	w8, w0
40001e64: 54000081     	b.ne	0x40001e74 <process_kill+0x108>
40001e68: b9402528     	ldr	w8, [x9, #0x24]
40001e6c: 71000d1f     	cmp	w8, #0x3
40001e70: 54000841     	b.ne	0x40001f78 <process_kill+0x20c>
40001e74: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001e78: 910f5129     	add	x9, x9, #0x3d4
40001e7c: b9400128     	ldr	w8, [x9]
40001e80: 6b00011f     	cmp	w8, w0
40001e84: 54000081     	b.ne	0x40001e94 <process_kill+0x128>
40001e88: b9402528     	ldr	w8, [x9, #0x24]
40001e8c: 71000d1f     	cmp	w8, #0x3
40001e90: 54000741     	b.ne	0x40001f78 <process_kill+0x20c>
40001e94: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001e98: 91101129     	add	x9, x9, #0x404
40001e9c: b9400128     	ldr	w8, [x9]
40001ea0: 6b00011f     	cmp	w8, w0
40001ea4: 54000081     	b.ne	0x40001eb4 <process_kill+0x148>
40001ea8: b9402528     	ldr	w8, [x9, #0x24]
40001eac: 71000d1f     	cmp	w8, #0x3
40001eb0: 54000641     	b.ne	0x40001f78 <process_kill+0x20c>
40001eb4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001eb8: 9110d129     	add	x9, x9, #0x434
40001ebc: b9400128     	ldr	w8, [x9]
40001ec0: 6b00011f     	cmp	w8, w0
40001ec4: 54000081     	b.ne	0x40001ed4 <process_kill+0x168>
40001ec8: b9402528     	ldr	w8, [x9, #0x24]
40001ecc: 71000d1f     	cmp	w8, #0x3
40001ed0: 54000541     	b.ne	0x40001f78 <process_kill+0x20c>
40001ed4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001ed8: 91119129     	add	x9, x9, #0x464
40001edc: b9400128     	ldr	w8, [x9]
40001ee0: 6b00011f     	cmp	w8, w0
40001ee4: 54000081     	b.ne	0x40001ef4 <process_kill+0x188>
40001ee8: b9402528     	ldr	w8, [x9, #0x24]
40001eec: 71000d1f     	cmp	w8, #0x3
40001ef0: 54000441     	b.ne	0x40001f78 <process_kill+0x20c>
40001ef4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001ef8: 91125129     	add	x9, x9, #0x494
40001efc: b9400128     	ldr	w8, [x9]
40001f00: 6b00011f     	cmp	w8, w0
40001f04: 54000081     	b.ne	0x40001f14 <process_kill+0x1a8>
40001f08: b9402528     	ldr	w8, [x9, #0x24]
40001f0c: 71000d1f     	cmp	w8, #0x3
40001f10: 54000341     	b.ne	0x40001f78 <process_kill+0x20c>
40001f14: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f18: 91131129     	add	x9, x9, #0x4c4
40001f1c: b9400128     	ldr	w8, [x9]
40001f20: 6b00011f     	cmp	w8, w0
40001f24: 54000081     	b.ne	0x40001f34 <process_kill+0x1c8>
40001f28: b9402528     	ldr	w8, [x9, #0x24]
40001f2c: 71000d1f     	cmp	w8, #0x3
40001f30: 54000241     	b.ne	0x40001f78 <process_kill+0x20c>
40001f34: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f38: 9113d129     	add	x9, x9, #0x4f4
40001f3c: b9400128     	ldr	w8, [x9]
40001f40: 6b00011f     	cmp	w8, w0
40001f44: 54000081     	b.ne	0x40001f54 <process_kill+0x1e8>
40001f48: b9402528     	ldr	w8, [x9, #0x24]
40001f4c: 71000d1f     	cmp	w8, #0x3
40001f50: 54000141     	b.ne	0x40001f78 <process_kill+0x20c>
40001f54: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f58: 91149129     	add	x9, x9, #0x524
40001f5c: b9400128     	ldr	w8, [x9]
40001f60: 6b00011f     	cmp	w8, w0
40001f64: 12800008     	mov	w8, #-0x1               // =-1
40001f68: 54000281     	b.ne	0x40001fb8 <process_kill+0x24c>
40001f6c: b940252a     	ldr	w10, [x9, #0x24]
40001f70: 71000d5f     	cmp	w10, #0x3
40001f74: 54000220     	b.eq	0x40001fb8 <process_kill+0x24c>
40001f78: 7100041f     	cmp	w0, #0x1
40001f7c: 54000161     	b.ne	0x40001fa8 <process_kill+0x23c>
40001f80: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f84: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001f88: 912a5000     	add	x0, x0, #0xa94
40001f8c: 910003fd     	mov	x29, sp
40001f90: 940005d6     	bl	0x400036e8 <uart_puts>
40001f94: 12800020     	mov	w0, #-0x2               // =-2
40001f98: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001f9c: d65f03c0     	ret
40001fa0: 12800000     	mov	w0, #-0x1               // =-1
40001fa4: d65f03c0     	ret
40001fa8: 5280004a     	mov	w10, #0x2               // =2
40001fac: 2a1f03e0     	mov	w0, wzr
40001fb0: b900252a     	str	w10, [x9, #0x24]
40001fb4: d65f03c0     	ret
40001fb8: 2a0803e0     	mov	w0, w8
40001fbc: d65f03c0     	ret

0000000040001fc0 <launch_ktop>:
40001fc0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001fc4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001fc8: 91218400     	add	x0, x0, #0x861
40001fcc: f9000bf7     	str	x23, [sp, #0x10]
40001fd0: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fd4: 910003fd     	mov	x29, sp
40001fd8: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fdc: 940005c3     	bl	0x400036e8 <uart_puts>
40001fe0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001fe4: 91282c00     	add	x0, x0, #0xa0b
40001fe8: 940005c0     	bl	0x400036e8 <uart_puts>
40001fec: 2a1f03e8     	mov	w8, wzr
40001ff0: 2a1f03e1     	mov	w1, wzr
40001ff4: 52800209     	mov	w9, #0x10               // =16
40001ff8: f000006a     	adrp	x10, 0x40010000 <__bss_start+0x3000>
40001ffc: 9109f14a     	add	x10, x10, #0x27c
40002000: 14000004     	b	0x40002010 <launch_ktop+0x50>
40002004: f1000529     	subs	x9, x9, #0x1
40002008: 9100c14a     	add	x10, x10, #0x30
4000200c: 54000120     	b.eq	0x40002030 <launch_ktop+0x70>
40002010: b85fc14b     	ldur	w11, [x10, #-0x4]
40002014: 121f796b     	and	w11, w11, #0xfffffffe
40002018: 7100097f     	cmp	w11, #0x2
4000201c: 54ffff40     	b.eq	0x40002004 <launch_ktop+0x44>
40002020: b940014b     	ldr	w11, [x10]
40002024: 11000421     	add	w1, w1, #0x1
40002028: 0b080168     	add	w8, w11, w8
4000202c: 17fffff6     	b	0x40002004 <launch_ktop+0x44>
40002030: 530a7d02     	lsr	w2, w8, #10
40002034: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002038: 912ddc00     	add	x0, x0, #0xb77
4000203c: 940006c0     	bl	0x40003b3c <uart_printf>
40002040: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002044: 9132c400     	add	x0, x0, #0xcb1
40002048: 940005a8     	bl	0x400036e8 <uart_puts>
4000204c: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002050: 913de800     	add	x0, x0, #0xf7a
40002054: 940005a5     	bl	0x400036e8 <uart_puts>
40002058: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
4000205c: 910a0294     	add	x20, x20, #0x280
40002060: b0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
40002064: 9103d2b5     	add	x21, x21, #0xf4
40002068: d503201f     	nop
4000206c: 1004cbb6     	adr	x22, 0x4000b9e0 <__rodata_start+0x29e0>
40002070: 52800217     	mov	w23, #0x10              // =16
40002074: 90000053     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
40002078: 91195673     	add	x19, x19, #0x655
4000207c: 1400000a     	b	0x400020a4 <launch_ktop+0xe4>
40002080: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002084: b85d4281     	ldur	w1, [x20, #-0x2c]
40002088: d100a285     	sub	x5, x20, #0x28
4000208c: aa1303e0     	mov	x0, x19
40002090: 530a7d03     	lsr	w3, w8, #10
40002094: 940006aa     	bl	0x40003b3c <uart_printf>
40002098: f10006f7     	subs	x23, x23, #0x1
4000209c: 9100c294     	add	x20, x20, #0x30
400020a0: 54000120     	b.eq	0x400020c4 <launch_ktop+0x104>
400020a4: b85f8288     	ldur	w8, [x20, #-0x8]
400020a8: 71000d1f     	cmp	w8, #0x3
400020ac: 54ffff60     	b.eq	0x40002098 <launch_ktop+0xd8>
400020b0: 7100091f     	cmp	w8, #0x2
400020b4: aa1503e2     	mov	x2, x21
400020b8: 54fffe48     	b.hi	0x40002080 <launch_ktop+0xc0>
400020bc: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
400020c0: 17fffff0     	b	0x40002080 <launch_ktop+0xc0>
400020c4: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400020c8: 910b0c00     	add	x0, x0, #0x2c3
400020cc: 94000587     	bl	0x400036e8 <uart_puts>
400020d0: 52808114     	mov	w20, #0x408             // =1032
400020d4: 52800033     	mov	w19, #0x1               // =1
400020d8: 72a02014     	movk	w20, #0x100, lsl #16
400020dc: 14000003     	b	0x400020e8 <launch_ktop+0x128>
400020e0: 7101c51f     	cmp	w8, #0x71
400020e4: 54000100     	b.eq	0x40002104 <launch_ktop+0x144>
400020e8: 940005b4     	bl	0x400037b8 <uart_getc>
400020ec: 12001c08     	and	w8, w0, #0xff
400020f0: 7100611f     	cmp	w8, #0x18
400020f4: 54ffff68     	b.hi	0x400020e0 <launch_ktop+0x120>
400020f8: 1ac82269     	lsl	w9, w19, w8
400020fc: 6a14013f     	tst	w9, w20
40002100: 54ffff00     	b.eq	0x400020e0 <launch_ktop+0x120>
40002104: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002108: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000210c: 912ea800     	add	x0, x0, #0xbaa
40002110: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002114: f9400bf7     	ldr	x23, [sp, #0x10]
40002118: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000211c: 14000573     	b	0x400036e8 <uart_puts>

0000000040002120 <script_init>:
40002120: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002124: d0000068     	adrp	x8, 0x40010000 <__bss_start+0x3000>
40002128: d503201f     	nop
4000212c: 7003de00     	adr	x0, 0x40009cef <__rodata_start+0xcef>
40002130: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40002134: 912fcc21     	add	x1, x1, #0xbf3
40002138: 910003fd     	mov	x29, sp
4000213c: b905551f     	str	wzr, [x8, #0x554]
40002140: 94000007     	bl	0x4000215c <script_set_var>
40002144: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002148: 913ab800     	add	x0, x0, #0xeae
4000214c: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40002150: 91206421     	add	x1, x1, #0x819
40002154: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002158: 14000001     	b	0x4000215c <script_set_var>

000000004000215c <script_set_var>:
4000215c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002160: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002164: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
40002168: 910003fd     	mov	x29, sp
4000216c: b94556e8     	ldr	w8, [x23, #0x554]
40002170: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002174: aa0103f3     	mov	x19, x1
40002178: aa0003f4     	mov	x20, x0
4000217c: a90257f6     	stp	x22, x21, [sp, #0x20]
40002180: 7100051f     	cmp	w8, #0x1
40002184: 5400024b     	b.lt	0x400021cc <script_set_var+0x70>
40002188: aa1f03f8     	mov	x24, xzr
4000218c: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
40002190: 912562b5     	add	x21, x21, #0x958
40002194: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
40002198: 911562d6     	add	x22, x22, #0x558
4000219c: aa1603e0     	mov	x0, x22
400021a0: aa1403e1     	mov	x1, x20
400021a4: 940001b6     	bl	0x4000287c <kstrcmp>
400021a8: 340003e0     	cbz	w0, 0x40002224 <script_set_var+0xc8>
400021ac: b98556e8     	ldrsw	x8, [x23, #0x554]
400021b0: 91000718     	add	x24, x24, #0x1
400021b4: 910202b5     	add	x21, x21, #0x80
400021b8: 910082d6     	add	x22, x22, #0x20
400021bc: eb08031f     	cmp	x24, x8
400021c0: 54fffeeb     	b.lt	0x4000219c <script_set_var+0x40>
400021c4: 71007d1f     	cmp	w8, #0x1f
400021c8: 5400038c     	b.gt	0x40002238 <script_set_var+0xdc>
400021cc: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400021d0: 911562b5     	add	x21, x21, #0x558
400021d4: aa1403e1     	mov	x1, x20
400021d8: 93407d08     	sxtw	x8, w8
400021dc: 528003e2     	mov	w2, #0x1f               // =31
400021e0: 8b0816a0     	add	x0, x21, x8, lsl #5
400021e4: 940001cc     	bl	0x40002914 <kstrncpy>
400021e8: b98556e8     	ldrsw	x8, [x23, #0x554]
400021ec: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
400021f0: 91256294     	add	x20, x20, #0x958
400021f4: aa1303e1     	mov	x1, x19
400021f8: 52800fe2     	mov	w2, #0x7f               // =127
400021fc: 8b0816a9     	add	x9, x21, x8, lsl #5
40002200: 8b081e80     	add	x0, x20, x8, lsl #7
40002204: 39007d3f     	strb	wzr, [x9, #0x1f]
40002208: 940001c3     	bl	0x40002914 <kstrncpy>
4000220c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002210: 8b081e89     	add	x9, x20, x8, lsl #7
40002214: 11000508     	add	w8, w8, #0x1
40002218: b90556e8     	str	w8, [x23, #0x554]
4000221c: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002220: 14000006     	b	0x40002238 <script_set_var+0xdc>
40002224: aa1503e0     	mov	x0, x21
40002228: aa1303e1     	mov	x1, x19
4000222c: 52800fe2     	mov	w2, #0x7f               // =127
40002230: 940001b9     	bl	0x40002914 <kstrncpy>
40002234: 3901febf     	strb	wzr, [x21, #0x7f]
40002238: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000223c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002240: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002244: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002248: d65f03c0     	ret

000000004000224c <script_get_var>:
4000224c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002250: a90257f6     	stp	x22, x21, [sp, #0x20]
40002254: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
40002258: 910003fd     	mov	x29, sp
4000225c: b94556c8     	ldr	w8, [x22, #0x554]
40002260: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002264: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002268: 7100051f     	cmp	w8, #0x1
4000226c: 540002ab     	b.lt	0x400022c0 <script_get_var+0x74>
40002270: aa0003f4     	mov	x20, x0
40002274: aa1f03f7     	mov	x23, xzr
40002278: d0000073     	adrp	x19, 0x40010000 <__bss_start+0x3000>
4000227c: 91256273     	add	x19, x19, #0x958
40002280: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
40002284: 911562b5     	add	x21, x21, #0x558
40002288: f0000038     	adrp	x24, 0x40009000 <__rodata_start>
4000228c: 91265718     	add	x24, x24, #0x995
40002290: aa1503e0     	mov	x0, x21
40002294: aa1403e1     	mov	x1, x20
40002298: 94000179     	bl	0x4000287c <kstrcmp>
4000229c: 34000160     	cbz	w0, 0x400022c8 <script_get_var+0x7c>
400022a0: b98556c8     	ldrsw	x8, [x22, #0x554]
400022a4: 910006f7     	add	x23, x23, #0x1
400022a8: 91020273     	add	x19, x19, #0x80
400022ac: 910082b5     	add	x21, x21, #0x20
400022b0: eb0802ff     	cmp	x23, x8
400022b4: 54fffeeb     	b.lt	0x40002290 <script_get_var+0x44>
400022b8: aa1803f3     	mov	x19, x24
400022bc: 14000003     	b	0x400022c8 <script_get_var+0x7c>
400022c0: f0000033     	adrp	x19, 0x40009000 <__rodata_start>
400022c4: 91265673     	add	x19, x19, #0x995
400022c8: aa1303e0     	mov	x0, x19
400022cc: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400022d0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400022d4: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400022d8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400022dc: d65f03c0     	ret

00000000400022e0 <script_expand_vars>:
400022e0: d10203ff     	sub	sp, sp, #0x80
400022e4: a9036ffc     	stp	x28, x27, [sp, #0x30]
400022e8: 2a1f03fc     	mov	w28, wzr
400022ec: a90467fa     	stp	x26, x25, [sp, #0x40]
400022f0: f0000039     	adrp	x25, 0x40009000 <__rodata_start>
400022f4: 91265739     	add	x25, x25, #0x995
400022f8: a9055ff8     	stp	x24, x23, [sp, #0x50]
400022fc: 910003f8     	mov	x24, sp
40002300: d000007a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
40002304: a90657f6     	stp	x22, x21, [sp, #0x60]
40002308: 2a1f03f6     	mov	w22, wzr
4000230c: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002310: aa0103f3     	mov	x19, x1
40002314: aa0003f4     	mov	x20, x0
40002318: a9027bfd     	stp	x29, x30, [sp, #0x20]
4000231c: 910083fd     	add	x29, sp, #0x20
40002320: 14000001     	b	0x40002324 <script_expand_vars+0x44>
40002324: 93407f89     	sxtw	x9, w28
40002328: 38696a88     	ldrb	w8, [x20, x9]
4000232c: 7100911f     	cmp	w8, #0x24
40002330: 540000e0     	b.eq	0x4000234c <script_expand_vars+0x6c>
40002334: 34000788     	cbz	w8, 0x40002424 <script_expand_vars+0x144>
40002338: 110006ca     	add	w10, w22, #0x1
4000233c: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002340: 1100053c     	add	w28, w9, #0x1
40002344: 2a0a03f6     	mov	w22, w10
40002348: 17fffff7     	b	0x40002324 <script_expand_vars+0x44>
4000234c: aa1f03e8     	mov	x8, xzr
40002350: 14000005     	b	0x40002364 <script_expand_vars+0x84>
40002354: 9100050a     	add	x10, x8, #0x1
40002358: 38286b09     	strb	w9, [x24, x8]
4000235c: d1000789     	sub	x9, x28, #0x1
40002360: aa0a03e8     	mov	x8, x10
40002364: 9100053c     	add	x28, x9, #0x1
40002368: 14000004     	b	0x40002378 <script_expand_vars+0x98>
4000236c: f100791f     	cmp	x8, #0x1e
40002370: 9100079c     	add	x28, x28, #0x1
40002374: 54ffff09     	b.ls	0x40002354 <script_expand_vars+0x74>
40002378: 387c6a89     	ldrb	w9, [x20, x28]
4000237c: 121a792a     	and	w10, w9, #0xffffffdf
40002380: 5101054a     	sub	w10, w10, #0x41
40002384: 7100695f     	cmp	w10, #0x1a
40002388: 54ffff23     	b.lo	0x4000236c <script_expand_vars+0x8c>
4000238c: 71017d3f     	cmp	w9, #0x5f
40002390: 54fffee0     	b.eq	0x4000236c <script_expand_vars+0x8c>
40002394: 5100c12a     	sub	w10, w9, #0x30
40002398: 7100255f     	cmp	w10, #0x9
4000239c: 54fffe89     	b.ls	0x4000236c <script_expand_vars+0x8c>
400023a0: b9455749     	ldr	w9, [x26, #0x554]
400023a4: 38286b1f     	strb	wzr, [x24, x8]
400023a8: 7100053f     	cmp	w9, #0x1
400023ac: 5400028b     	b.lt	0x400023fc <script_expand_vars+0x11c>
400023b0: aa1f03fb     	mov	x27, xzr
400023b4: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400023b8: 911562b5     	add	x21, x21, #0x558
400023bc: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
400023c0: 912562f7     	add	x23, x23, #0x958
400023c4: 910003e1     	mov	x1, sp
400023c8: aa1503e0     	mov	x0, x21
400023cc: 9400012c     	bl	0x4000287c <kstrcmp>
400023d0: 34000100     	cbz	w0, 0x400023f0 <script_expand_vars+0x110>
400023d4: b9855748     	ldrsw	x8, [x26, #0x554]
400023d8: 9100077b     	add	x27, x27, #0x1
400023dc: 910202f7     	add	x23, x23, #0x80
400023e0: 910082b5     	add	x21, x21, #0x20
400023e4: eb08037f     	cmp	x27, x8
400023e8: 54fffeeb     	b.lt	0x400023c4 <script_expand_vars+0xe4>
400023ec: aa1903f7     	mov	x23, x25
400023f0: 394002e8     	ldrb	w8, [x23]
400023f4: 350000a8     	cbnz	w8, 0x40002408 <script_expand_vars+0x128>
400023f8: 17ffffcb     	b	0x40002324 <script_expand_vars+0x44>
400023fc: aa1903f7     	mov	x23, x25
40002400: 394002e8     	ldrb	w8, [x23]
40002404: 34fff908     	cbz	w8, 0x40002324 <script_expand_vars+0x44>
40002408: 8b36c269     	add	x9, x19, w22, sxtw
4000240c: 910006ea     	add	x10, x23, #0x1
40002410: 38001528     	strb	w8, [x9], #0x1
40002414: 110006d6     	add	w22, w22, #0x1
40002418: 38401548     	ldrb	w8, [x10], #0x1
4000241c: 35ffffa8     	cbnz	w8, 0x40002410 <script_expand_vars+0x130>
40002420: 17ffffc1     	b	0x40002324 <script_expand_vars+0x44>
40002424: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
40002428: a9474ff4     	ldp	x20, x19, [sp, #0x70]
4000242c: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002430: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002434: a94467fa     	ldp	x26, x25, [sp, #0x40]
40002438: a9436ffc     	ldp	x28, x27, [sp, #0x30]
4000243c: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002440: 910203ff     	add	sp, sp, #0x80
40002444: d65f03c0     	ret

0000000040002448 <script_execute_line>:
40002448: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000244c: a9014ffc     	stp	x28, x19, [sp, #0x10]
40002450: 910003fd     	mov	x29, sp
40002454: d10803ff     	sub	sp, sp, #0x200
40002458: 14000004     	b	0x40002468 <script_execute_line+0x20>
4000245c: 7100811f     	cmp	w8, #0x20
40002460: 54000121     	b.ne	0x40002484 <script_execute_line+0x3c>
40002464: 91000400     	add	x0, x0, #0x1
40002468: 39400008     	ldrb	w8, [x0]
4000246c: 71007d1f     	cmp	w8, #0x1f
40002470: 54ffff6c     	b.gt	0x4000245c <script_execute_line+0x14>
40002474: 7100251f     	cmp	w8, #0x9
40002478: 54ffff60     	b.eq	0x40002464 <script_execute_line+0x1c>
4000247c: 34001668     	cbz	w8, 0x40002748 <script_execute_line+0x300>
40002480: 14000003     	b	0x4000248c <script_execute_line+0x44>
40002484: 71008d1f     	cmp	w8, #0x23
40002488: 54001600     	b.eq	0x40002748 <script_execute_line+0x300>
4000248c: 910403e1     	add	x1, sp, #0x100
40002490: 910403f3     	add	x19, sp, #0x100
40002494: 97ffff93     	bl	0x400022e0 <script_expand_vars>
40002498: 394403e9     	ldrb	w9, [sp, #0x100]
4000249c: 34001529     	cbz	w9, 0x40002740 <script_execute_line+0x2f8>
400024a0: 394407e8     	ldrb	w8, [sp, #0x101]
400024a4: aa1f03ea     	mov	x10, xzr
400024a8: 2a0903eb     	mov	w11, w9
400024ac: 14000004     	b	0x400024bc <script_execute_line+0x74>
400024b0: 9100054a     	add	x10, x10, #0x1
400024b4: 386a6a6b     	ldrb	w11, [x19, x10]
400024b8: 340003cb     	cbz	w11, 0x40002530 <script_execute_line+0xe8>
400024bc: b4ffffaa     	cbz	x10, 0x400024b0 <script_execute_line+0x68>
400024c0: 7100f57f     	cmp	w11, #0x3d
400024c4: 54ffff61     	b.ne	0x400024b0 <script_execute_line+0x68>
400024c8: 8b13014b     	add	x11, x10, x19
400024cc: 385ff16c     	ldurb	w12, [x11, #-0x1]
400024d0: 7100f59f     	cmp	w12, #0x3d
400024d4: 54fffee0     	b.eq	0x400024b0 <script_execute_line+0x68>
400024d8: 3940056b     	ldrb	w11, [x11, #0x1]
400024dc: 7100f57f     	cmp	w11, #0x3d
400024e0: 54fffe80     	b.eq	0x400024b0 <script_execute_line+0x68>
400024e4: aa1f03ec     	mov	x12, xzr
400024e8: 2a1f03eb     	mov	w11, wzr
400024ec: 386c6a6d     	ldrb	w13, [x19, x12]
400024f0: 9100058c     	add	x12, x12, #0x1
400024f4: 710081bf     	cmp	w13, #0x20
400024f8: 1a9f156b     	csinc	w11, w11, wzr, ne
400024fc: eb0c015f     	cmp	x10, x12
40002500: 54ffff61     	b.ne	0x400024ec <script_execute_line+0xa4>
40002504: 35fffd6b     	cbnz	w11, 0x400024b0 <script_execute_line+0x68>
40002508: 7101a53f     	cmp	w9, #0x69
4000250c: 54fffd20     	b.eq	0x400024b0 <script_execute_line+0x68>
40002510: 7101991f     	cmp	w8, #0x66
40002514: 54fffce0     	b.eq	0x400024b0 <script_execute_line+0x68>
40002518: 910403e8     	add	x8, sp, #0x100
4000251c: 910403e0     	add	x0, sp, #0x100
40002520: 8b0a0101     	add	x1, x8, x10
40002524: 3800143f     	strb	wzr, [x1], #0x1
40002528: 97ffff0d     	bl	0x4000215c <script_set_var>
4000252c: 14000087     	b	0x40002748 <script_execute_line+0x300>
40002530: 394403e9     	ldrb	w9, [sp, #0x100]
40002534: 7101a53f     	cmp	w9, #0x69
40002538: 54001041     	b.ne	0x40002740 <script_execute_line+0x2f8>
4000253c: 7101991f     	cmp	w8, #0x66
40002540: 54001001     	b.ne	0x40002740 <script_execute_line+0x2f8>
40002544: 39440be8     	ldrb	w8, [sp, #0x102]
40002548: 7100811f     	cmp	w8, #0x20
4000254c: 54000fa1     	b.ne	0x40002740 <script_execute_line+0x2f8>
40002550: 39440fe9     	ldrb	w9, [sp, #0x103]
40002554: 7100813f     	cmp	w9, #0x20
40002558: 54000081     	b.ne	0x40002568 <script_execute_line+0x120>
4000255c: aa1f03e9     	mov	x9, xzr
40002560: 52800068     	mov	w8, #0x3                // =3
40002564: 14000014     	b	0x400025b4 <script_execute_line+0x16c>
40002568: 910403ea     	add	x10, sp, #0x100
4000256c: aa1f03e8     	mov	x8, xzr
40002570: 910303eb     	add	x11, sp, #0xc0
40002574: 9100114a     	add	x10, x10, #0x4
40002578: 34000189     	cbz	w9, 0x400025a8 <script_execute_line+0x160>
4000257c: f100f91f     	cmp	x8, #0x3e
40002580: 54000148     	b.hi	0x400025a8 <script_execute_line+0x160>
40002584: 38286969     	strb	w9, [x11, x8]
40002588: 38686949     	ldrb	w9, [x10, x8]
4000258c: 9100050c     	add	x12, x8, #0x1
40002590: aa0c03e8     	mov	x8, x12
40002594: 7100813f     	cmp	w9, #0x20
40002598: 54ffff01     	b.ne	0x40002578 <script_execute_line+0x130>
4000259c: 11000d8a     	add	w10, w12, #0x3
400025a0: 2a0c03e8     	mov	w8, w12
400025a4: 14000002     	b	0x400025ac <script_execute_line+0x164>
400025a8: 11000d0a     	add	w10, w8, #0x3
400025ac: 2a0803e9     	mov	w9, w8
400025b0: 2a0a03e8     	mov	w8, w10
400025b4: 910303ea     	add	x10, sp, #0xc0
400025b8: 3829695f     	strb	wzr, [x10, x9]
400025bc: 910403e9     	add	x9, sp, #0x100
400025c0: 3868692a     	ldrb	w10, [x9, x8]
400025c4: 7100815f     	cmp	w10, #0x20
400025c8: 54000061     	b.ne	0x400025d4 <script_execute_line+0x18c>
400025cc: 91000508     	add	x8, x8, #0x1
400025d0: 17fffffc     	b	0x400025c0 <script_execute_line+0x178>
400025d4: 7100855f     	cmp	w10, #0x21
400025d8: 54000060     	b.eq	0x400025e4 <script_execute_line+0x19c>
400025dc: 7100f55f     	cmp	w10, #0x3d
400025e0: 540000e1     	b.ne	0x400025fc <script_execute_line+0x1b4>
400025e4: 11000509     	add	w9, w8, #0x1
400025e8: 910403ea     	add	x10, sp, #0x100
400025ec: 38694949     	ldrb	w9, [x10, w9, uxtw]
400025f0: 9100090a     	add	x10, x8, #0x2
400025f4: 7100f53f     	cmp	w9, #0x3d
400025f8: 9a880148     	csel	x8, x10, x8, eq
400025fc: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002600: 910403ea     	add	x10, sp, #0x100
40002604: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002608: 8b088129     	add	x9, x9, x8, lsl #32
4000260c: 8b28c14a     	add	x10, x10, w8, sxtw
40002610: 51000508     	sub	w8, w8, #0x1
40002614: 3840154c     	ldrb	w12, [x10], #0x1
40002618: 8b0b0129     	add	x9, x9, x11
4000261c: 11000508     	add	w8, w8, #0x1
40002620: 7100819f     	cmp	w12, #0x20
40002624: 54ffff80     	b.eq	0x40002614 <script_execute_line+0x1cc>
40002628: 9360fd2c     	asr	x12, x9, #32
4000262c: 910403e9     	add	x9, sp, #0x100
40002630: 386c692d     	ldrb	w13, [x9, x12]
40002634: 710081bf     	cmp	w13, #0x20
40002638: 54000061     	b.ne	0x40002644 <script_execute_line+0x1fc>
4000263c: aa1f03ea     	mov	x10, xzr
40002640: 14000010     	b	0x40002680 <script_execute_line+0x238>
40002644: aa1f03eb     	mov	x11, xzr
40002648: 910203ec     	add	x12, sp, #0x80
4000264c: 3400016d     	cbz	w13, 0x40002678 <script_execute_line+0x230>
40002650: f100f97f     	cmp	x11, #0x3e
40002654: 54000128     	b.hi	0x40002678 <script_execute_line+0x230>
40002658: 382b698d     	strb	w13, [x12, x11]
4000265c: 386b694d     	ldrb	w13, [x10, x11]
40002660: 9100056e     	add	x14, x11, #0x1
40002664: 11000508     	add	w8, w8, #0x1
40002668: aa0e03eb     	mov	x11, x14
4000266c: 710081bf     	cmp	w13, #0x20
40002670: 54fffee1     	b.ne	0x4000264c <script_execute_line+0x204>
40002674: 2a0e03eb     	mov	w11, w14
40002678: 93407d0c     	sxtw	x12, w8
4000267c: 2a0b03ea     	mov	w10, w11
40002680: d3607d8d     	lsl	x13, x12, #32
40002684: 910203eb     	add	x11, sp, #0x80
40002688: d2c0006f     	mov	x15, #0x300000000       // =12884901888
4000268c: d2c00050     	mov	x16, #0x200000000       // =8589934592
40002690: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002694: 11001108     	add	w8, w8, #0x4
40002698: 382a697f     	strb	wzr, [x11, x10]
4000269c: 8b0f01aa     	add	x10, x13, x15
400026a0: 8b1001ab     	add	x11, x13, x16
400026a4: 8b0e01ad     	add	x13, x13, x14
400026a8: 8b0c0129     	add	x9, x9, x12
400026ac: 3840152c     	ldrb	w12, [x9], #0x1
400026b0: 7100819f     	cmp	w12, #0x20
400026b4: 540000c1     	b.ne	0x400026cc <script_execute_line+0x284>
400026b8: 11000508     	add	w8, w8, #0x1
400026bc: 8b0e014a     	add	x10, x10, x14
400026c0: 8b0e016b     	add	x11, x11, x14
400026c4: 8b0e01ad     	add	x13, x13, x14
400026c8: 17fffff9     	b	0x400026ac <script_execute_line+0x264>
400026cc: 7101d19f     	cmp	w12, #0x74
400026d0: 54000381     	b.ne	0x40002740 <script_execute_line+0x2f8>
400026d4: 9360fdac     	asr	x12, x13, #32
400026d8: 910403e9     	add	x9, sp, #0x100
400026dc: 386c692c     	ldrb	w12, [x9, x12]
400026e0: 7101a19f     	cmp	w12, #0x68
400026e4: 540002e1     	b.ne	0x40002740 <script_execute_line+0x2f8>
400026e8: 9360fd6b     	asr	x11, x11, #32
400026ec: 386b6929     	ldrb	w9, [x9, x11]
400026f0: 7101953f     	cmp	w9, #0x65
400026f4: 54000261     	b.ne	0x40002740 <script_execute_line+0x2f8>
400026f8: 9360fd4a     	asr	x10, x10, #32
400026fc: 910403e9     	add	x9, sp, #0x100
40002700: 386a692a     	ldrb	w10, [x9, x10]
40002704: 7101b95f     	cmp	w10, #0x6e
40002708: 540001c1     	b.ne	0x40002740 <script_execute_line+0x2f8>
4000270c: 8b28c128     	add	x8, x9, w8, sxtw
40002710: d1000501     	sub	x1, x8, #0x1
40002714: 38401c28     	ldrb	w8, [x1, #0x1]!
40002718: 7100811f     	cmp	w8, #0x20
4000271c: 54ffffc0     	b.eq	0x40002714 <script_execute_line+0x2cc>
40002720: 910003e0     	mov	x0, sp
40002724: 94000075     	bl	0x400028f8 <kstrcpy>
40002728: 910303e0     	add	x0, sp, #0xc0
4000272c: 910203e1     	add	x1, sp, #0x80
40002730: 94000053     	bl	0x4000287c <kstrcmp>
40002734: 350000a0     	cbnz	w0, 0x40002748 <script_execute_line+0x300>
40002738: 910003e0     	mov	x0, sp
4000273c: 14000002     	b	0x40002744 <script_execute_line+0x2fc>
40002740: 910403e0     	add	x0, sp, #0x100
40002744: 97fff9be     	bl	0x40000e3c <execute_command>
40002748: 2a1f03e0     	mov	w0, wzr
4000274c: 910803ff     	add	sp, sp, #0x200
40002750: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002754: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002758: d65f03c0     	ret

000000004000275c <script_run_file>:
4000275c: d10503ff     	sub	sp, sp, #0x140
40002760: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002764: 910403fd     	add	x29, sp, #0x100
40002768: f9008bfc     	str	x28, [sp, #0x110]
4000276c: a91257f6     	stp	x22, x21, [sp, #0x120]
40002770: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002774: aa0003f4     	mov	x20, x0
40002778: 940008b8     	bl	0x40004a58 <vfs_find>
4000277c: b4000080     	cbz	x0, 0x4000278c <script_run_file+0x30>
40002780: b9402008     	ldr	w8, [x0, #0x20]
40002784: aa0003f3     	mov	x19, x0
40002788: 340000e8     	cbz	w8, 0x400027a4 <script_run_file+0x48>
4000278c: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002790: 91075c00     	add	x0, x0, #0x1d7
40002794: aa1403e1     	mov	x1, x20
40002798: 940004e9     	bl	0x40003b3c <uart_printf>
4000279c: 12800000     	mov	w0, #-0x1               // =-1
400027a0: 14000021     	b	0x40002824 <script_run_file+0xc8>
400027a4: f9401668     	ldr	x8, [x19, #0x28]
400027a8: aa1f03f4     	mov	x20, xzr
400027ac: 2a1f03e9     	mov	w9, wzr
400027b0: 9100c275     	add	x21, x19, #0x30
400027b4: 910003f6     	mov	x22, sp
400027b8: 14000008     	b	0x400027d8 <script_run_file+0x7c>
400027bc: 7100053f     	cmp	w9, #0x1
400027c0: 3829cadf     	strb	wzr, [x22, w9, sxtw]
400027c4: 2a1f03e9     	mov	w9, wzr
400027c8: 5400022a     	b.ge	0x4000280c <script_run_file+0xb0>
400027cc: 91000694     	add	x20, x20, #0x1
400027d0: eb08029f     	cmp	x20, x8
400027d4: 54000268     	b.hi	0x40002820 <script_run_file+0xc4>
400027d8: eb08029f     	cmp	x20, x8
400027dc: 54ffff00     	b.eq	0x400027bc <script_run_file+0x60>
400027e0: 38746aaa     	ldrb	w10, [x21, x20]
400027e4: 7100295f     	cmp	w10, #0xa
400027e8: 54fffea0     	b.eq	0x400027bc <script_run_file+0x60>
400027ec: 7100355f     	cmp	w10, #0xd
400027f0: 54fffee0     	b.eq	0x400027cc <script_run_file+0x70>
400027f4: 7103f93f     	cmp	w9, #0xfe
400027f8: 54fffeac     	b.gt	0x400027cc <script_run_file+0x70>
400027fc: 1100052b     	add	w11, w9, #0x1
40002800: 3829caca     	strb	w10, [x22, w9, sxtw]
40002804: 2a0b03e9     	mov	w9, w11
40002808: 17fffff1     	b	0x400027cc <script_run_file+0x70>
4000280c: 910003e0     	mov	x0, sp
40002810: 97ffff0e     	bl	0x40002448 <script_execute_line>
40002814: f9401668     	ldr	x8, [x19, #0x28]
40002818: 2a1f03e9     	mov	w9, wzr
4000281c: 17ffffec     	b	0x400027cc <script_run_file+0x70>
40002820: 2a1f03e0     	mov	w0, wzr
40002824: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002828: f9408bfc     	ldr	x28, [sp, #0x110]
4000282c: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002830: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002834: 910503ff     	add	sp, sp, #0x140
40002838: d65f03c0     	ret

000000004000283c <kstrlen>:
4000283c: b40000c0     	cbz	x0, 0x40002854 <kstrlen+0x18>
40002840: aa1f03e8     	mov	x8, xzr
40002844: 38686809     	ldrb	w9, [x0, x8]
40002848: 91000508     	add	x8, x8, #0x1
4000284c: 35ffffc9     	cbnz	w9, 0x40002844 <kstrlen+0x8>
40002850: d1000500     	sub	x0, x8, #0x1
40002854: d65f03c0     	ret

0000000040002858 <kstrcat>:
40002858: b4000100     	cbz	x0, 0x40002878 <kstrcat+0x20>
4000285c: b40000e1     	cbz	x1, 0x40002878 <kstrcat+0x20>
40002860: d1000408     	sub	x8, x0, #0x1
40002864: 38401d09     	ldrb	w9, [x8, #0x1]!
40002868: 35ffffe9     	cbnz	w9, 0x40002864 <kstrcat+0xc>
4000286c: 38401429     	ldrb	w9, [x1], #0x1
40002870: 38001509     	strb	w9, [x8], #0x1
40002874: 35ffffc9     	cbnz	w9, 0x4000286c <kstrcat+0x14>
40002878: d65f03c0     	ret

000000004000287c <kstrcmp>:
4000287c: aa0003e8     	mov	x8, x0
40002880: 12800000     	mov	w0, #-0x1               // =-1
40002884: b4000188     	cbz	x8, 0x400028b4 <kstrcmp+0x38>
40002888: b4000161     	cbz	x1, 0x400028b4 <kstrcmp+0x38>
4000288c: 38401509     	ldrb	w9, [x8], #0x1
40002890: 340000e9     	cbz	w9, 0x400028ac <kstrcmp+0x30>
40002894: 3940002a     	ldrb	w10, [x1]
40002898: 6b0a013f     	cmp	w9, w10
4000289c: 54000081     	b.ne	0x400028ac <kstrcmp+0x30>
400028a0: 38401509     	ldrb	w9, [x8], #0x1
400028a4: 91000421     	add	x1, x1, #0x1
400028a8: 35ffff69     	cbnz	w9, 0x40002894 <kstrcmp+0x18>
400028ac: 39400028     	ldrb	w8, [x1]
400028b0: 4b080120     	sub	w0, w9, w8
400028b4: d65f03c0     	ret

00000000400028b8 <kstrncmp>:
400028b8: 12800008     	mov	w8, #-0x1               // =-1
400028bc: b4000160     	cbz	x0, 0x400028e8 <kstrncmp+0x30>
400028c0: b4000141     	cbz	x1, 0x400028e8 <kstrncmp+0x30>
400028c4: b4000102     	cbz	x2, 0x400028e4 <kstrncmp+0x2c>
400028c8: 38401408     	ldrb	w8, [x0], #0x1
400028cc: 38401429     	ldrb	w9, [x1], #0x1
400028d0: 34000108     	cbz	w8, 0x400028f0 <kstrncmp+0x38>
400028d4: 6b09011f     	cmp	w8, w9
400028d8: 540000c1     	b.ne	0x400028f0 <kstrncmp+0x38>
400028dc: f1000442     	subs	x2, x2, #0x1
400028e0: 54ffff41     	b.ne	0x400028c8 <kstrncmp+0x10>
400028e4: 2a1f03e8     	mov	w8, wzr
400028e8: 2a0803e0     	mov	w0, w8
400028ec: d65f03c0     	ret
400028f0: 4b090100     	sub	w0, w8, w9
400028f4: d65f03c0     	ret

00000000400028f8 <kstrcpy>:
400028f8: b40000c0     	cbz	x0, 0x40002910 <kstrcpy+0x18>
400028fc: b40000a1     	cbz	x1, 0x40002910 <kstrcpy+0x18>
40002900: aa0003e8     	mov	x8, x0
40002904: 38401429     	ldrb	w9, [x1], #0x1
40002908: 38001509     	strb	w9, [x8], #0x1
4000290c: 35ffffc9     	cbnz	w9, 0x40002904 <kstrcpy+0xc>
40002910: d65f03c0     	ret

0000000040002914 <kstrncpy>:
40002914: b4000480     	cbz	x0, 0x400029a4 <kstrncpy+0x90>
40002918: b4000461     	cbz	x1, 0x400029a4 <kstrncpy+0x90>
4000291c: b4000442     	cbz	x2, 0x400029a4 <kstrncpy+0x90>
40002920: aa1f03e9     	mov	x9, xzr
40002924: aa0203e8     	mov	x8, x2
40002928: 3869682a     	ldrb	w10, [x1, x9]
4000292c: 3829680a     	strb	w10, [x0, x9]
40002930: 340000ca     	cbz	w10, 0x40002948 <kstrncpy+0x34>
40002934: 91000529     	add	x9, x9, #0x1
40002938: d1000508     	sub	x8, x8, #0x1
4000293c: eb09005f     	cmp	x2, x9
40002940: 54ffff41     	b.ne	0x40002928 <kstrncpy+0x14>
40002944: 14000018     	b	0x400029a4 <kstrncpy+0x90>
40002948: cb09004a     	sub	x10, x2, x9
4000294c: 8b090009     	add	x9, x0, x9
40002950: f100095f     	cmp	x10, #0x2
40002954: 54000082     	b.hs	0x40002964 <kstrncpy+0x50>
40002958: 91000528     	add	x8, x9, #0x1
4000295c: aa0a03e9     	mov	x9, x10
40002960: 1400000e     	b	0x40002998 <kstrncpy+0x84>
40002964: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002968: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
4000296c: 9100092c     	add	x12, x9, #0x2
40002970: 8b090108     	add	x8, x8, x9
40002974: 92400149     	and	x9, x10, #0x1
40002978: aa0b03ed     	mov	x13, x11
4000297c: 91000508     	add	x8, x8, #0x1
40002980: f10009ad     	subs	x13, x13, #0x2
40002984: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002988: 3800259f     	strb	wzr, [x12], #0x2
4000298c: 54ffffa1     	b.ne	0x40002980 <kstrncpy+0x6c>
40002990: eb0b015f     	cmp	x10, x11
40002994: 54000080     	b.eq	0x400029a4 <kstrncpy+0x90>
40002998: f1000529     	subs	x9, x9, #0x1
4000299c: 3800151f     	strb	wzr, [x8], #0x1
400029a0: 54ffffc1     	b.ne	0x40002998 <kstrncpy+0x84>
400029a4: d65f03c0     	ret

00000000400029a8 <memset>:
400029a8: b40002a0     	cbz	x0, 0x400029fc <memset+0x54>
400029ac: b4000282     	cbz	x2, 0x400029fc <memset+0x54>
400029b0: f100085f     	cmp	x2, #0x2
400029b4: 54000082     	b.hs	0x400029c4 <memset+0x1c>
400029b8: aa0003e8     	mov	x8, x0
400029bc: aa0203e9     	mov	x9, x2
400029c0: 1400000c     	b	0x400029f0 <memset+0x48>
400029c4: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
400029c8: 92400049     	and	x9, x2, #0x1
400029cc: 9100040b     	add	x11, x0, #0x1
400029d0: 8b0a0008     	add	x8, x0, x10
400029d4: aa0a03ec     	mov	x12, x10
400029d8: f100098c     	subs	x12, x12, #0x2
400029dc: 381ff161     	sturb	w1, [x11, #-0x1]
400029e0: 38002561     	strb	w1, [x11], #0x2
400029e4: 54ffffa1     	b.ne	0x400029d8 <memset+0x30>
400029e8: eb0a005f     	cmp	x2, x10
400029ec: 54000080     	b.eq	0x400029fc <memset+0x54>
400029f0: f1000529     	subs	x9, x9, #0x1
400029f4: 38001501     	strb	w1, [x8], #0x1
400029f8: 54ffffc1     	b.ne	0x400029f0 <memset+0x48>
400029fc: d65f03c0     	ret

0000000040002a00 <memcpy>:
40002a00: b4000100     	cbz	x0, 0x40002a20 <memcpy+0x20>
40002a04: b40000e1     	cbz	x1, 0x40002a20 <memcpy+0x20>
40002a08: b40000c2     	cbz	x2, 0x40002a20 <memcpy+0x20>
40002a0c: aa0003e8     	mov	x8, x0
40002a10: 38401429     	ldrb	w9, [x1], #0x1
40002a14: f1000442     	subs	x2, x2, #0x1
40002a18: 38001509     	strb	w9, [x8], #0x1
40002a1c: 54ffffa1     	b.ne	0x40002a10 <memcpy+0x10>
40002a20: d65f03c0     	ret

0000000040002a24 <kstrstr>:
40002a24: aa1f03e2     	mov	x2, xzr
40002a28: b40000e0     	cbz	x0, 0x40002a44 <kstrstr+0x20>
40002a2c: b40000c1     	cbz	x1, 0x40002a44 <kstrstr+0x20>
40002a30: 39400028     	ldrb	w8, [x1]
40002a34: 340002c8     	cbz	w8, 0x40002a8c <kstrstr+0x68>
40002a38: 39400009     	ldrb	w9, [x0]
40002a3c: 35000109     	cbnz	w9, 0x40002a5c <kstrstr+0x38>
40002a40: aa1f03e2     	mov	x2, xzr
40002a44: aa0203e0     	mov	x0, x2
40002a48: d65f03c0     	ret
40002a4c: 3940012c     	ldrb	w12, [x9]
40002a50: 340001ec     	cbz	w12, 0x40002a8c <kstrstr+0x68>
40002a54: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a58: 34ffff49     	cbz	w9, 0x40002a40 <kstrstr+0x1c>
40002a5c: 6b08013f     	cmp	w9, w8
40002a60: 54ffffa1     	b.ne	0x40002a54 <kstrstr+0x30>
40002a64: 5280002a     	mov	w10, #0x1               // =1
40002a68: aa0103e9     	mov	x9, x1
40002a6c: 2a0803eb     	mov	w11, w8
40002a70: 3840152c     	ldrb	w12, [x9], #0x1
40002a74: 6b0c017f     	cmp	w11, w12
40002a78: 54fffec1     	b.ne	0x40002a50 <kstrstr+0x2c>
40002a7c: 386a680b     	ldrb	w11, [x0, x10]
40002a80: 9100054a     	add	x10, x10, #0x1
40002a84: 35ffff6b     	cbnz	w11, 0x40002a70 <kstrstr+0x4c>
40002a88: 17fffff1     	b	0x40002a4c <kstrstr+0x28>
40002a8c: d65f03c0     	ret

0000000040002a90 <kstrchr>:
40002a90: b4000140     	cbz	x0, 0x40002ab8 <kstrchr+0x28>
40002a94: 39400009     	ldrb	w9, [x0]
40002a98: 340000c9     	cbz	w9, 0x40002ab0 <kstrchr+0x20>
40002a9c: 12001c28     	and	w8, w1, #0xff
40002aa0: 6b08013f     	cmp	w9, w8
40002aa4: 540000a0     	b.eq	0x40002ab8 <kstrchr+0x28>
40002aa8: 38401c09     	ldrb	w9, [x0, #0x1]!
40002aac: 35ffffa9     	cbnz	w9, 0x40002aa0 <kstrchr+0x10>
40002ab0: 72001c3f     	tst	w1, #0xff
40002ab4: 9a9f0000     	csel	x0, x0, xzr, eq
40002ab8: d65f03c0     	ret

0000000040002abc <ktolower>:
40002abc: 51010408     	sub	w8, w0, #0x41
40002ac0: 321b0009     	orr	w9, w0, #0x20
40002ac4: 7100691f     	cmp	w8, #0x1a
40002ac8: 1a803120     	csel	w0, w9, w0, lo
40002acc: d65f03c0     	ret

0000000040002ad0 <kstr_tolower>:
40002ad0: b40001a0     	cbz	x0, 0x40002b04 <kstr_tolower+0x34>
40002ad4: b4000181     	cbz	x1, 0x40002b04 <kstr_tolower+0x34>
40002ad8: 39400029     	ldrb	w9, [x1]
40002adc: 34000129     	cbz	w9, 0x40002b00 <kstr_tolower+0x30>
40002ae0: 91000428     	add	x8, x1, #0x1
40002ae4: 5101052a     	sub	w10, w9, #0x41
40002ae8: 321b012b     	orr	w11, w9, #0x20
40002aec: 7100695f     	cmp	w10, #0x1a
40002af0: 1a893169     	csel	w9, w11, w9, lo
40002af4: 38001409     	strb	w9, [x0], #0x1
40002af8: 38401509     	ldrb	w9, [x8], #0x1
40002afc: 35ffff49     	cbnz	w9, 0x40002ae4 <kstr_tolower+0x14>
40002b00: 3900001f     	strb	wzr, [x0]
40002b04: d65f03c0     	ret

0000000040002b08 <timer_init>:
40002b08: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002b0c: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b10: f9000bf3     	str	x19, [sp, #0x10]
40002b14: d53be008     	mrs	x8, CNTFRQ_EL0
40002b18: f29999a9     	movk	x9, #0xcccd
40002b1c: f0000073     	adrp	x19, 0x40011000 <var_values+0x6a8>
40002b20: 528003c0     	mov	w0, #0x1e               // =30
40002b24: 9bc97d09     	umulh	x9, x8, x9
40002b28: 910003fd     	mov	x29, sp
40002b2c: 5280002a     	mov	w10, #0x1               // =1
40002b30: f904ae68     	str	x8, [x19, #0x958]
40002b34: d343fd29     	lsr	x9, x9, #3
40002b38: d51be209     	msr	CNTP_TVAL_EL0, x9
40002b3c: d51be22a     	msr	CNTP_CTL_EL0, x10
40002b40: 97fff5c0     	bl	0x40000240 <gic_enable_interrupt>
40002b44: d50342ff     	msr	DAIFClr, #0x2
40002b48: d503201f     	nop
40002b4c: 500448c0     	adr	x0, 0x4000b466 <__rodata_start+0x2466>
40002b50: b9495a61     	ldr	w1, [x19, #0x958]
40002b54: f9400bf3     	ldr	x19, [sp, #0x10]
40002b58: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002b5c: 140003f8     	b	0x40003b3c <uart_printf>

0000000040002b60 <timer_handle_interrupt>:
40002b60: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002b64: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b68: f944ad08     	ldr	x8, [x8, #0x958]
40002b6c: f29999a9     	movk	x9, #0xcccd
40002b70: 9bc97d08     	umulh	x8, x8, x9
40002b74: f0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40002b78: f944b12a     	ldr	x10, [x9, #0x960]
40002b7c: 9100054a     	add	x10, x10, #0x1
40002b80: f904b12a     	str	x10, [x9, #0x960]
40002b84: d343fd08     	lsr	x8, x8, #3
40002b88: d51be208     	msr	CNTP_TVAL_EL0, x8
40002b8c: d65f03c0     	ret

0000000040002b90 <tui_launch>:
40002b90: d105c3ff     	sub	sp, sp, #0x170
40002b94: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b98: 910443fd     	add	x29, sp, #0x110
40002b9c: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002ba0: a91367fa     	stp	x26, x25, [sp, #0x130]
40002ba4: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002ba8: a91557f6     	stp	x22, x21, [sp, #0x150]
40002bac: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002bb0: 94000758     	bl	0x40004910 <vfs_get_cwd>
40002bb4: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002bb8: f000007c     	adrp	x28, 0x40011000 <var_values+0x6a8>
40002bbc: f000007b     	adrp	x27, 0x40011000 <var_values+0x6a8>
40002bc0: f904b500     	str	x0, [x8, #0x968]
40002bc4: d503201f     	nop
40002bc8: 3003f420     	adr	x0, 0x4000aa4d <__rodata_start+0x1a4d>
40002bcc: b909739f     	str	wzr, [x28, #0x970]
40002bd0: b909777f     	str	wzr, [x27, #0x974]
40002bd4: 940002c5     	bl	0x400036e8 <uart_puts>
40002bd8: f0000036     	adrp	x22, 0x40009000 <__rodata_start>
40002bdc: 91121ad6     	add	x22, x22, #0x486
40002be0: f0000037     	adrp	x23, 0x40009000 <__rodata_start>
40002be4: 910d22f7     	add	x23, x23, #0x348
40002be8: f0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40002bec: 91260318     	add	x24, x24, #0x980
40002bf0: f000007a     	adrp	x26, 0x40011000 <var_values+0x6a8>
40002bf4: f0000034     	adrp	x20, 0x40009000 <__rodata_start>
40002bf8: 91159e94     	add	x20, x20, #0x567
40002bfc: 14000005     	b	0x40002c10 <tui_launch+0x80>
40002c00: b9497388     	ldr	w8, [x28, #0x970]
40002c04: 7100011f     	cmp	w8, #0x0
40002c08: 1a9f17e8     	cset	w8, eq
40002c0c: b9097388     	str	w8, [x28, #0x970]
40002c10: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002c14: b9097b5f     	str	wzr, [x26, #0x978]
40002c18: f944b50a     	ldr	x10, [x8, #0x968]
40002c1c: f9421948     	ldr	x8, [x10, #0x430]
40002c20: b4000108     	cbz	x8, 0x40002c40 <tui_launch+0xb0>
40002c24: 52800029     	mov	w9, #0x1                // =1
40002c28: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002c2c: b9097b49     	str	w9, [x26, #0x978]
40002c30: f904c11f     	str	xzr, [x8, #0x980]
40002c34: f9401548     	ldr	x8, [x10, #0x28]
40002c38: b50000a8     	cbnz	x8, 0x40002c4c <tui_launch+0xbc>
40002c3c: 14000027     	b	0x40002cd8 <tui_launch+0x148>
40002c40: 2a1f03e9     	mov	w9, wzr
40002c44: f9401548     	ldr	x8, [x10, #0x28]
40002c48: b4000488     	cbz	x8, 0x40002cd8 <tui_launch+0x148>
40002c4c: 2a0903e9     	mov	w9, w9
40002c50: d100050c     	sub	x12, x8, #0x1
40002c54: d240152b     	eor	x11, x9, #0x3f
40002c58: eb0b019f     	cmp	x12, x11
40002c5c: 9a8b318b     	csel	x11, x12, x11, lo
40002c60: b400022c     	cbz	x12, 0x40002ca4 <tui_launch+0x114>
40002c64: 9100056c     	add	x12, x11, #0x1
40002c68: 8b090f0e     	add	x14, x24, x9, lsl #3
40002c6c: 9111014d     	add	x13, x10, #0x440
40002c70: 927f798b     	and	x11, x12, #0xfffffffe
40002c74: aa090169     	orr	x9, x11, x9
40002c78: 910021ce     	add	x14, x14, #0x8
40002c7c: aa0b03ef     	mov	x15, x11
40002c80: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002c84: f10009ef     	subs	x15, x15, #0x2
40002c88: 910041ad     	add	x13, x13, #0x10
40002c8c: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002c90: 910041ce     	add	x14, x14, #0x10
40002c94: 54ffff61     	b.ne	0x40002c80 <tui_launch+0xf0>
40002c98: eb0b019f     	cmp	x12, x11
40002c9c: 54000061     	b.ne	0x40002ca8 <tui_launch+0x118>
40002ca0: 1400000d     	b	0x40002cd4 <tui_launch+0x144>
40002ca4: aa1f03eb     	mov	x11, xzr
40002ca8: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002cac: 9100056b     	add	x11, x11, #0x1
40002cb0: 9110e14a     	add	x10, x10, #0x438
40002cb4: f840854c     	ldr	x12, [x10], #0x8
40002cb8: f100f93f     	cmp	x9, #0x3e
40002cbc: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002cc0: 91000529     	add	x9, x9, #0x1
40002cc4: 54000088     	b.hi	0x40002cd4 <tui_launch+0x144>
40002cc8: eb08017f     	cmp	x11, x8
40002ccc: 9100056b     	add	x11, x11, #0x1
40002cd0: 54ffff23     	b.lo	0x40002cb4 <tui_launch+0x124>
40002cd4: b9097b49     	str	w9, [x26, #0x978]
40002cd8: b949776a     	ldr	w10, [x27, #0x974]
40002cdc: 51000528     	sub	w8, w9, #0x1
40002ce0: 6b08015f     	cmp	w10, w8
40002ce4: 1a88b148     	csel	w8, w10, w8, lt
40002ce8: 6b09015f     	cmp	w10, w9
40002cec: 5400004a     	b.ge	0x40002cf4 <tui_launch+0x164>
40002cf0: 36f80068     	tbz	w8, #0x1f, 0x40002cfc <tui_launch+0x16c>
40002cf4: 0aa87d08     	bic	w8, w8, w8, asr #31
40002cf8: b9097768     	str	w8, [x27, #0x974]
40002cfc: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002d00: 91265800     	add	x0, x0, #0x996
40002d04: 94000279     	bl	0x400036e8 <uart_puts>
40002d08: b9497388     	ldr	w8, [x28, #0x970]
40002d0c: 52800020     	mov	w0, #0x1                // =1
40002d10: 52800501     	mov	w1, #0x28               // =40
40002d14: f0000022     	adrp	x2, 0x40009000 <__rodata_start>
40002d18: 91023042     	add	x2, x2, #0x8c
40002d1c: 7100011f     	cmp	w8, #0x0
40002d20: 1a9f17e3     	cset	w3, eq
40002d24: 94000171     	bl	0x400032e8 <draw_box>
40002d28: 52800075     	mov	w21, #0x3               // =3
40002d2c: aa1603e0     	mov	x0, x22
40002d30: 2a1503e1     	mov	w1, w21
40002d34: 52800042     	mov	w2, #0x2                // =2
40002d38: 94000381     	bl	0x40003b3c <uart_printf>
40002d3c: aa1703e0     	mov	x0, x23
40002d40: 9400026a     	bl	0x400036e8 <uart_puts>
40002d44: aa1703e0     	mov	x0, x23
40002d48: 94000268     	bl	0x400036e8 <uart_puts>
40002d4c: aa1703e0     	mov	x0, x23
40002d50: 94000266     	bl	0x400036e8 <uart_puts>
40002d54: aa1703e0     	mov	x0, x23
40002d58: 94000264     	bl	0x400036e8 <uart_puts>
40002d5c: aa1703e0     	mov	x0, x23
40002d60: 94000262     	bl	0x400036e8 <uart_puts>
40002d64: aa1703e0     	mov	x0, x23
40002d68: 94000260     	bl	0x400036e8 <uart_puts>
40002d6c: aa1703e0     	mov	x0, x23
40002d70: 9400025e     	bl	0x400036e8 <uart_puts>
40002d74: aa1703e0     	mov	x0, x23
40002d78: 9400025c     	bl	0x400036e8 <uart_puts>
40002d7c: aa1703e0     	mov	x0, x23
40002d80: 9400025a     	bl	0x400036e8 <uart_puts>
40002d84: aa1703e0     	mov	x0, x23
40002d88: 94000258     	bl	0x400036e8 <uart_puts>
40002d8c: aa1703e0     	mov	x0, x23
40002d90: 94000256     	bl	0x400036e8 <uart_puts>
40002d94: aa1703e0     	mov	x0, x23
40002d98: 94000254     	bl	0x400036e8 <uart_puts>
40002d9c: aa1703e0     	mov	x0, x23
40002da0: 94000252     	bl	0x400036e8 <uart_puts>
40002da4: aa1703e0     	mov	x0, x23
40002da8: 94000250     	bl	0x400036e8 <uart_puts>
40002dac: aa1703e0     	mov	x0, x23
40002db0: 9400024e     	bl	0x400036e8 <uart_puts>
40002db4: aa1703e0     	mov	x0, x23
40002db8: 9400024c     	bl	0x400036e8 <uart_puts>
40002dbc: aa1703e0     	mov	x0, x23
40002dc0: 9400024a     	bl	0x400036e8 <uart_puts>
40002dc4: aa1703e0     	mov	x0, x23
40002dc8: 94000248     	bl	0x400036e8 <uart_puts>
40002dcc: aa1703e0     	mov	x0, x23
40002dd0: 94000246     	bl	0x400036e8 <uart_puts>
40002dd4: aa1703e0     	mov	x0, x23
40002dd8: 94000244     	bl	0x400036e8 <uart_puts>
40002ddc: aa1703e0     	mov	x0, x23
40002de0: 94000242     	bl	0x400036e8 <uart_puts>
40002de4: aa1703e0     	mov	x0, x23
40002de8: 94000240     	bl	0x400036e8 <uart_puts>
40002dec: aa1703e0     	mov	x0, x23
40002df0: 9400023e     	bl	0x400036e8 <uart_puts>
40002df4: aa1703e0     	mov	x0, x23
40002df8: 9400023c     	bl	0x400036e8 <uart_puts>
40002dfc: aa1703e0     	mov	x0, x23
40002e00: 9400023a     	bl	0x400036e8 <uart_puts>
40002e04: aa1703e0     	mov	x0, x23
40002e08: 94000238     	bl	0x400036e8 <uart_puts>
40002e0c: aa1703e0     	mov	x0, x23
40002e10: 94000236     	bl	0x400036e8 <uart_puts>
40002e14: aa1703e0     	mov	x0, x23
40002e18: 94000234     	bl	0x400036e8 <uart_puts>
40002e1c: aa1703e0     	mov	x0, x23
40002e20: 94000232     	bl	0x400036e8 <uart_puts>
40002e24: aa1703e0     	mov	x0, x23
40002e28: 94000230     	bl	0x400036e8 <uart_puts>
40002e2c: aa1703e0     	mov	x0, x23
40002e30: 9400022e     	bl	0x400036e8 <uart_puts>
40002e34: aa1703e0     	mov	x0, x23
40002e38: 9400022c     	bl	0x400036e8 <uart_puts>
40002e3c: aa1703e0     	mov	x0, x23
40002e40: 9400022a     	bl	0x400036e8 <uart_puts>
40002e44: aa1703e0     	mov	x0, x23
40002e48: 94000228     	bl	0x400036e8 <uart_puts>
40002e4c: aa1703e0     	mov	x0, x23
40002e50: 94000226     	bl	0x400036e8 <uart_puts>
40002e54: aa1703e0     	mov	x0, x23
40002e58: 94000224     	bl	0x400036e8 <uart_puts>
40002e5c: aa1703e0     	mov	x0, x23
40002e60: 94000222     	bl	0x400036e8 <uart_puts>
40002e64: aa1703e0     	mov	x0, x23
40002e68: 94000220     	bl	0x400036e8 <uart_puts>
40002e6c: 110006b5     	add	w21, w21, #0x1
40002e70: 71005ebf     	cmp	w21, #0x17
40002e74: 54fff5c1     	b.ne	0x40002d2c <tui_launch+0x19c>
40002e78: b9497768     	ldr	w8, [x27, #0x974]
40002e7c: 52800249     	mov	w9, #0x12               // =18
40002e80: 7100491f     	cmp	w8, #0x12
40002e84: 1a89c108     	csel	w8, w8, w9, gt
40002e88: 51004915     	sub	w21, w8, #0x12
40002e8c: 8b354f19     	add	x25, x24, w21, uxtw #3
40002e90: aa1f03f8     	mov	x24, xzr
40002e94: 14000004     	b	0x40002ea4 <tui_launch+0x314>
40002e98: 91000718     	add	x24, x24, #0x1
40002e9c: f100531f     	cmp	x24, #0x14
40002ea0: 540005a0     	b.eq	0x40002f54 <tui_launch+0x3c4>
40002ea4: b9897b48     	ldrsw	x8, [x26, #0x978]
40002ea8: 8b1802b3     	add	x19, x21, x24
40002eac: eb08027f     	cmp	x19, x8
40002eb0: 5400052a     	b.ge	0x40002f54 <tui_launch+0x3c4>
40002eb4: 11000f01     	add	w1, w24, #0x3
40002eb8: aa1603e0     	mov	x0, x22
40002ebc: 52800062     	mov	w2, #0x3                // =3
40002ec0: 9400031f     	bl	0x40003b3c <uart_printf>
40002ec4: b9497768     	ldr	w8, [x27, #0x974]
40002ec8: eb08027f     	cmp	x19, x8
40002ecc: 540000c1     	b.ne	0x40002ee4 <tui_launch+0x354>
40002ed0: b9497388     	ldr	w8, [x28, #0x970]
40002ed4: 35000088     	cbnz	w8, 0x40002ee4 <tui_launch+0x354>
40002ed8: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002edc: 91040800     	add	x0, x0, #0x102
40002ee0: 94000202     	bl	0x400036e8 <uart_puts>
40002ee4: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002ee8: b40001e8     	cbz	x8, 0x40002f24 <tui_launch+0x394>
40002eec: b9402108     	ldr	w8, [x8, #0x20]
40002ef0: 90000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40002ef4: 910f4529     	add	x9, x9, #0x3d1
40002ef8: 910223e0     	add	x0, sp, #0x88
40002efc: 7100051f     	cmp	w8, #0x1
40002f00: f0000028     	adrp	x8, 0x40009000 <__rodata_start>
40002f04: 9139cd08     	add	x8, x8, #0xe73
40002f08: 9a880121     	csel	x1, x9, x8, eq
40002f0c: 97fffe7b     	bl	0x400028f8 <kstrcpy>
40002f10: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002f14: 910223e0     	add	x0, sp, #0x88
40002f18: 97fffe50     	bl	0x40002858 <kstrcat>
40002f1c: 910223e0     	add	x0, sp, #0x88
40002f20: 14000003     	b	0x40002f2c <tui_launch+0x39c>
40002f24: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002f28: 9133c800     	add	x0, x0, #0xcf2
40002f2c: 940001ef     	bl	0x400036e8 <uart_puts>
40002f30: b9497768     	ldr	w8, [x27, #0x974]
40002f34: eb08027f     	cmp	x19, x8
40002f38: 54fffb01     	b.ne	0x40002e98 <tui_launch+0x308>
40002f3c: b9497388     	ldr	w8, [x28, #0x970]
40002f40: 35fffac8     	cbnz	w8, 0x40002e98 <tui_launch+0x308>
40002f44: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002f48: 9134b400     	add	x0, x0, #0xd2d
40002f4c: 940001e7     	bl	0x400036e8 <uart_puts>
40002f50: 17ffffd2     	b	0x40002e98 <tui_launch+0x308>
40002f54: b9497388     	ldr	w8, [x28, #0x970]
40002f58: 52800540     	mov	w0, #0x2a               // =42
40002f5c: 528004c1     	mov	w1, #0x26               // =38
40002f60: 90000042     	adrp	x2, 0x4000a000 <__rodata_start+0x1000>
40002f64: 9107d042     	add	x2, x2, #0x1f4
40002f68: 7100051f     	cmp	w8, #0x1
40002f6c: 1a9f17e3     	cset	w3, eq
40002f70: 940000de     	bl	0x400032e8 <draw_box>
40002f74: 52800075     	mov	w21, #0x3               // =3
40002f78: aa1603e0     	mov	x0, x22
40002f7c: 2a1503e1     	mov	w1, w21
40002f80: 52800562     	mov	w2, #0x2b               // =43
40002f84: 940002ee     	bl	0x40003b3c <uart_printf>
40002f88: aa1703e0     	mov	x0, x23
40002f8c: 940001d7     	bl	0x400036e8 <uart_puts>
40002f90: aa1703e0     	mov	x0, x23
40002f94: 940001d5     	bl	0x400036e8 <uart_puts>
40002f98: aa1703e0     	mov	x0, x23
40002f9c: 940001d3     	bl	0x400036e8 <uart_puts>
40002fa0: aa1703e0     	mov	x0, x23
40002fa4: 940001d1     	bl	0x400036e8 <uart_puts>
40002fa8: aa1703e0     	mov	x0, x23
40002fac: 940001cf     	bl	0x400036e8 <uart_puts>
40002fb0: aa1703e0     	mov	x0, x23
40002fb4: 940001cd     	bl	0x400036e8 <uart_puts>
40002fb8: aa1703e0     	mov	x0, x23
40002fbc: 940001cb     	bl	0x400036e8 <uart_puts>
40002fc0: aa1703e0     	mov	x0, x23
40002fc4: 940001c9     	bl	0x400036e8 <uart_puts>
40002fc8: aa1703e0     	mov	x0, x23
40002fcc: 940001c7     	bl	0x400036e8 <uart_puts>
40002fd0: aa1703e0     	mov	x0, x23
40002fd4: 940001c5     	bl	0x400036e8 <uart_puts>
40002fd8: aa1703e0     	mov	x0, x23
40002fdc: 940001c3     	bl	0x400036e8 <uart_puts>
40002fe0: aa1703e0     	mov	x0, x23
40002fe4: 940001c1     	bl	0x400036e8 <uart_puts>
40002fe8: aa1703e0     	mov	x0, x23
40002fec: 940001bf     	bl	0x400036e8 <uart_puts>
40002ff0: aa1703e0     	mov	x0, x23
40002ff4: 940001bd     	bl	0x400036e8 <uart_puts>
40002ff8: aa1703e0     	mov	x0, x23
40002ffc: 940001bb     	bl	0x400036e8 <uart_puts>
40003000: aa1703e0     	mov	x0, x23
40003004: 940001b9     	bl	0x400036e8 <uart_puts>
40003008: aa1703e0     	mov	x0, x23
4000300c: 940001b7     	bl	0x400036e8 <uart_puts>
40003010: aa1703e0     	mov	x0, x23
40003014: 940001b5     	bl	0x400036e8 <uart_puts>
40003018: aa1703e0     	mov	x0, x23
4000301c: 940001b3     	bl	0x400036e8 <uart_puts>
40003020: aa1703e0     	mov	x0, x23
40003024: 940001b1     	bl	0x400036e8 <uart_puts>
40003028: aa1703e0     	mov	x0, x23
4000302c: 940001af     	bl	0x400036e8 <uart_puts>
40003030: aa1703e0     	mov	x0, x23
40003034: 940001ad     	bl	0x400036e8 <uart_puts>
40003038: aa1703e0     	mov	x0, x23
4000303c: 940001ab     	bl	0x400036e8 <uart_puts>
40003040: aa1703e0     	mov	x0, x23
40003044: 940001a9     	bl	0x400036e8 <uart_puts>
40003048: aa1703e0     	mov	x0, x23
4000304c: 940001a7     	bl	0x400036e8 <uart_puts>
40003050: aa1703e0     	mov	x0, x23
40003054: 940001a5     	bl	0x400036e8 <uart_puts>
40003058: aa1703e0     	mov	x0, x23
4000305c: 940001a3     	bl	0x400036e8 <uart_puts>
40003060: aa1703e0     	mov	x0, x23
40003064: 940001a1     	bl	0x400036e8 <uart_puts>
40003068: aa1703e0     	mov	x0, x23
4000306c: 9400019f     	bl	0x400036e8 <uart_puts>
40003070: aa1703e0     	mov	x0, x23
40003074: 9400019d     	bl	0x400036e8 <uart_puts>
40003078: aa1703e0     	mov	x0, x23
4000307c: 9400019b     	bl	0x400036e8 <uart_puts>
40003080: aa1703e0     	mov	x0, x23
40003084: 94000199     	bl	0x400036e8 <uart_puts>
40003088: aa1703e0     	mov	x0, x23
4000308c: 94000197     	bl	0x400036e8 <uart_puts>
40003090: aa1703e0     	mov	x0, x23
40003094: 94000195     	bl	0x400036e8 <uart_puts>
40003098: aa1703e0     	mov	x0, x23
4000309c: 94000193     	bl	0x400036e8 <uart_puts>
400030a0: aa1703e0     	mov	x0, x23
400030a4: 94000191     	bl	0x400036e8 <uart_puts>
400030a8: 110006b5     	add	w21, w21, #0x1
400030ac: 71005ebf     	cmp	w21, #0x17
400030b0: 54fff641     	b.ne	0x40002f78 <tui_launch+0x3e8>
400030b4: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400030b8: 9117a800     	add	x0, x0, #0x5ea
400030bc: 52800061     	mov	w1, #0x3                // =3
400030c0: 52800562     	mov	w2, #0x2b               // =43
400030c4: 9400029e     	bl	0x40003b3c <uart_printf>
400030c8: d503201f     	nop
400030cc: 10068c48     	adr	x8, 0x40010254 <proc_table>
400030d0: aa1f03f3     	mov	x19, xzr
400030d4: 9100a115     	add	x21, x8, #0x28
400030d8: 52800058     	mov	w24, #0x2               // =2
400030dc: d0000039     	adrp	x25, 0x40009000 <__rodata_start>
400030e0: 9121bf39     	add	x25, x25, #0x86f
400030e4: b85fc2a8     	ldur	w8, [x21, #-0x4]
400030e8: 71000d1f     	cmp	w8, #0x3
400030ec: 54000140     	b.eq	0x40003114 <tui_launch+0x584>
400030f0: b94002a8     	ldr	w8, [x21]
400030f4: b85d82a3     	ldur	w3, [x21, #-0x28]
400030f8: d10092a4     	sub	x4, x21, #0x24
400030fc: 11000b01     	add	w1, w24, #0x2
40003100: aa1403e0     	mov	x0, x20
40003104: 52800562     	mov	w2, #0x2b               // =43
40003108: 530a7d05     	lsr	w5, w8, #10
4000310c: 9400028c     	bl	0x40003b3c <uart_printf>
40003110: 11000718     	add	w24, w24, #0x1
40003114: f1003a7f     	cmp	x19, #0xe
40003118: 540000a8     	b.hi	0x4000312c <tui_launch+0x59c>
4000311c: 7100531f     	cmp	w24, #0x14
40003120: 91000673     	add	x19, x19, #0x1
40003124: 9100c2b5     	add	x21, x21, #0x30
40003128: 54fffdeb     	b.lt	0x400030e4 <tui_launch+0x554>
4000312c: 940001a3     	bl	0x400037b8 <uart_getc>
40003130: 52801be8     	mov	w8, #0xdf               // =223
40003134: 0a080008     	and	w8, w0, w8
40003138: 7101451f     	cmp	w8, #0x51
4000313c: 54000c00     	b.eq	0x400032bc <tui_launch+0x72c>
40003140: 12001c08     	and	w8, w0, #0xff
40003144: 7100311f     	cmp	w8, #0xc
40003148: 5400010c     	b.gt	0x40003168 <tui_launch+0x5d8>
4000314c: 7100251f     	cmp	w8, #0x9
40003150: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40003154: 91260318     	add	x24, x24, #0x980
40003158: 54ffd540     	b.eq	0x40002c00 <tui_launch+0x70>
4000315c: 7100291f     	cmp	w8, #0xa
40003160: 540002e0     	b.eq	0x400031bc <tui_launch+0x62c>
40003164: 17fffeab     	b	0x40002c10 <tui_launch+0x80>
40003168: 7100351f     	cmp	w8, #0xd
4000316c: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40003170: 91260318     	add	x24, x24, #0x980
40003174: 54000240     	b.eq	0x400031bc <tui_launch+0x62c>
40003178: 71006d1f     	cmp	w8, #0x1b
4000317c: 54ffd4a1     	b.ne	0x40002c10 <tui_launch+0x80>
40003180: 9400018e     	bl	0x400037b8 <uart_getc>
40003184: 12001c13     	and	w19, w0, #0xff
40003188: 9400018c     	bl	0x400037b8 <uart_getc>
4000318c: 71016e7f     	cmp	w19, #0x5b
40003190: 54ffd401     	b.ne	0x40002c10 <tui_launch+0x80>
40003194: 12001c08     	and	w8, w0, #0xff
40003198: 7101051f     	cmp	w8, #0x41
4000319c: 54000781     	b.ne	0x4000328c <tui_launch+0x6fc>
400031a0: b9497388     	ldr	w8, [x28, #0x970]
400031a4: 35ffd368     	cbnz	w8, 0x40002c10 <tui_launch+0x80>
400031a8: b9497768     	ldr	w8, [x27, #0x974]
400031ac: 71000508     	subs	w8, w8, #0x1
400031b0: 54ffd30b     	b.lt	0x40002c10 <tui_launch+0x80>
400031b4: b9097768     	str	w8, [x27, #0x974]
400031b8: 17fffe96     	b	0x40002c10 <tui_launch+0x80>
400031bc: b9497388     	ldr	w8, [x28, #0x970]
400031c0: 35ffd288     	cbnz	w8, 0x40002c10 <tui_launch+0x80>
400031c4: b9497b48     	ldr	w8, [x26, #0x978]
400031c8: 7100051f     	cmp	w8, #0x1
400031cc: 54ffd22b     	b.lt	0x40002c10 <tui_launch+0x80>
400031d0: b9897768     	ldrsw	x8, [x27, #0x974]
400031d4: f8687b15     	ldr	x21, [x24, x8, lsl #3]
400031d8: b4000115     	cbz	x21, 0x400031f8 <tui_launch+0x668>
400031dc: b94022a8     	ldr	w8, [x21, #0x20]
400031e0: 7100051f     	cmp	w8, #0x1
400031e4: 54000161     	b.ne	0x40003210 <tui_launch+0x680>
400031e8: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
400031ec: b909777f     	str	wzr, [x27, #0x974]
400031f0: f904b515     	str	x21, [x8, #0x968]
400031f4: 17fffe87     	b	0x40002c10 <tui_launch+0x80>
400031f8: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
400031fc: b909777f     	str	wzr, [x27, #0x974]
40003200: f944b528     	ldr	x8, [x9, #0x968]
40003204: f9421908     	ldr	x8, [x8, #0x430]
40003208: f904b528     	str	x8, [x9, #0x968]
4000320c: 17fffe81     	b	0x40002c10 <tui_launch+0x80>
40003210: 390223ff     	strb	wzr, [sp, #0x88]
40003214: aa1903e0     	mov	x0, x25
40003218: 94000610     	bl	0x40004a58 <vfs_find>
4000321c: eb0002bf     	cmp	x21, x0
40003220: 540001e0     	b.eq	0x4000325c <tui_launch+0x6cc>
40003224: 910023e0     	add	x0, sp, #0x8
40003228: 910223e1     	add	x1, sp, #0x88
4000322c: 97fffdb3     	bl	0x400028f8 <kstrcpy>
40003230: 910223e0     	add	x0, sp, #0x88
40003234: aa1903e1     	mov	x1, x25
40003238: 97fffdb0     	bl	0x400028f8 <kstrcpy>
4000323c: 910223e0     	add	x0, sp, #0x88
40003240: aa1503e1     	mov	x1, x21
40003244: 97fffd85     	bl	0x40002858 <kstrcat>
40003248: 910223e0     	add	x0, sp, #0x88
4000324c: 910023e1     	add	x1, sp, #0x8
40003250: 97fffd82     	bl	0x40002858 <kstrcat>
40003254: f9421ab5     	ldr	x21, [x21, #0x430]
40003258: b5fffdf5     	cbnz	x21, 0x40003214 <tui_launch+0x684>
4000325c: 910223e0     	add	x0, sp, #0x88
40003260: 97fffd77     	bl	0x4000283c <kstrlen>
40003264: b5000080     	cbnz	x0, 0x40003274 <tui_launch+0x6e4>
40003268: 910223e0     	add	x0, sp, #0x88
4000326c: aa1903e1     	mov	x1, x25
40003270: 97fffda2     	bl	0x400028f8 <kstrcpy>
40003274: 910223e0     	add	x0, sp, #0x88
40003278: 97fff413     	bl	0x400002c4 <launch_kedit>
4000327c: d503201f     	nop
40003280: 3003be60     	adr	x0, 0x4000aa4d <__rodata_start+0x1a4d>
40003284: 94000119     	bl	0x400036e8 <uart_puts>
40003288: 17fffe62     	b	0x40002c10 <tui_launch+0x80>
4000328c: 7101091f     	cmp	w8, #0x42
40003290: 54ffcc01     	b.ne	0x40002c10 <tui_launch+0x80>
40003294: b9497388     	ldr	w8, [x28, #0x970]
40003298: 35ffcbc8     	cbnz	w8, 0x40002c10 <tui_launch+0x80>
4000329c: b9497b49     	ldr	w9, [x26, #0x978]
400032a0: b9497768     	ldr	w8, [x27, #0x974]
400032a4: 51000529     	sub	w9, w9, #0x1
400032a8: 6b09011f     	cmp	w8, w9
400032ac: 54ffcb2a     	b.ge	0x40002c10 <tui_launch+0x80>
400032b0: 11000508     	add	w8, w8, #0x1
400032b4: b9097768     	str	w8, [x27, #0x974]
400032b8: 17fffe56     	b	0x40002c10 <tui_launch+0x80>
400032bc: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400032c0: 912ea800     	add	x0, x0, #0xbaa
400032c4: 94000109     	bl	0x400036e8 <uart_puts>
400032c8: a9564ff4     	ldp	x20, x19, [sp, #0x160]
400032cc: a95557f6     	ldp	x22, x21, [sp, #0x150]
400032d0: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400032d4: a95367fa     	ldp	x26, x25, [sp, #0x130]
400032d8: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400032dc: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400032e0: 9105c3ff     	add	sp, sp, #0x170
400032e4: d65f03c0     	ret

00000000400032e8 <draw_box>:
400032e8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400032ec: 90000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
400032f0: 9126d108     	add	x8, x8, #0x9b4
400032f4: 7100007f     	cmp	w3, #0x0
400032f8: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
400032fc: 910c1529     	add	x9, x9, #0x305
40003300: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003304: 2a0003f3     	mov	w19, w0
40003308: 9a880120     	csel	x0, x9, x8, eq
4000330c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003310: a90257f6     	stp	x22, x21, [sp, #0x20]
40003314: 910003fd     	mov	x29, sp
40003318: aa0203f4     	mov	x20, x2
4000331c: 2a0103f5     	mov	w21, w1
40003320: 940000f2     	bl	0x400036e8 <uart_puts>
40003324: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003328: 9121c400     	add	x0, x0, #0x871
4000332c: 52800041     	mov	w1, #0x2                // =2
40003330: 2a1303e2     	mov	w2, w19
40003334: 94000202     	bl	0x40003b3c <uart_printf>
40003338: 51000ab6     	sub	w22, w21, #0x2
4000333c: 510006b7     	sub	w23, w21, #0x1
40003340: d0000035     	adrp	x21, 0x40009000 <__rodata_start>
40003344: 91158eb5     	add	x21, x21, #0x563
40003348: 2a1603f8     	mov	w24, w22
4000334c: aa1503e0     	mov	x0, x21
40003350: 940000e6     	bl	0x400036e8 <uart_puts>
40003354: 71000718     	subs	w24, w24, #0x1
40003358: 54ffffa1     	b.ne	0x4000334c <draw_box+0x64>
4000335c: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003360: 91282000     	add	x0, x0, #0xa08
40003364: 940000e1     	bl	0x400036e8 <uart_puts>
40003368: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000336c: 9121f400     	add	x0, x0, #0x87d
40003370: 11000a62     	add	w2, w19, #0x2
40003374: 52800041     	mov	w1, #0x2                // =2
40003378: aa1403e3     	mov	x3, x20
4000337c: 940001f0     	bl	0x40003b3c <uart_printf>
40003380: f0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40003384: 9119de94     	add	x20, x20, #0x677
40003388: 52800061     	mov	w1, #0x3                // =3
4000338c: aa1403e0     	mov	x0, x20
40003390: 2a1303e2     	mov	w2, w19
40003394: 940001ea     	bl	0x40003b3c <uart_printf>
40003398: 0b1302e2     	add	w2, w23, w19
4000339c: aa1403e0     	mov	x0, x20
400033a0: 52800061     	mov	w1, #0x3                // =3
400033a4: 940001e6     	bl	0x40003b3c <uart_printf>
400033a8: aa1403e0     	mov	x0, x20
400033ac: 52800081     	mov	w1, #0x4                // =4
400033b0: 2a1303e2     	mov	w2, w19
400033b4: 940001e2     	bl	0x40003b3c <uart_printf>
400033b8: 0b1302e2     	add	w2, w23, w19
400033bc: aa1403e0     	mov	x0, x20
400033c0: 52800081     	mov	w1, #0x4                // =4
400033c4: 940001de     	bl	0x40003b3c <uart_printf>
400033c8: aa1403e0     	mov	x0, x20
400033cc: 528000a1     	mov	w1, #0x5                // =5
400033d0: 2a1303e2     	mov	w2, w19
400033d4: 940001da     	bl	0x40003b3c <uart_printf>
400033d8: 0b1302e2     	add	w2, w23, w19
400033dc: aa1403e0     	mov	x0, x20
400033e0: 528000a1     	mov	w1, #0x5                // =5
400033e4: 940001d6     	bl	0x40003b3c <uart_printf>
400033e8: aa1403e0     	mov	x0, x20
400033ec: 528000c1     	mov	w1, #0x6                // =6
400033f0: 2a1303e2     	mov	w2, w19
400033f4: 940001d2     	bl	0x40003b3c <uart_printf>
400033f8: 0b1302e2     	add	w2, w23, w19
400033fc: aa1403e0     	mov	x0, x20
40003400: 528000c1     	mov	w1, #0x6                // =6
40003404: 940001ce     	bl	0x40003b3c <uart_printf>
40003408: aa1403e0     	mov	x0, x20
4000340c: 528000e1     	mov	w1, #0x7                // =7
40003410: 2a1303e2     	mov	w2, w19
40003414: 940001ca     	bl	0x40003b3c <uart_printf>
40003418: 0b1302e2     	add	w2, w23, w19
4000341c: aa1403e0     	mov	x0, x20
40003420: 528000e1     	mov	w1, #0x7                // =7
40003424: 940001c6     	bl	0x40003b3c <uart_printf>
40003428: aa1403e0     	mov	x0, x20
4000342c: 52800101     	mov	w1, #0x8                // =8
40003430: 2a1303e2     	mov	w2, w19
40003434: 940001c2     	bl	0x40003b3c <uart_printf>
40003438: 0b1302e2     	add	w2, w23, w19
4000343c: aa1403e0     	mov	x0, x20
40003440: 52800101     	mov	w1, #0x8                // =8
40003444: 940001be     	bl	0x40003b3c <uart_printf>
40003448: aa1403e0     	mov	x0, x20
4000344c: 52800121     	mov	w1, #0x9                // =9
40003450: 2a1303e2     	mov	w2, w19
40003454: 940001ba     	bl	0x40003b3c <uart_printf>
40003458: 0b1302e2     	add	w2, w23, w19
4000345c: aa1403e0     	mov	x0, x20
40003460: 52800121     	mov	w1, #0x9                // =9
40003464: 940001b6     	bl	0x40003b3c <uart_printf>
40003468: aa1403e0     	mov	x0, x20
4000346c: 52800141     	mov	w1, #0xa                // =10
40003470: 2a1303e2     	mov	w2, w19
40003474: 940001b2     	bl	0x40003b3c <uart_printf>
40003478: 0b1302e2     	add	w2, w23, w19
4000347c: aa1403e0     	mov	x0, x20
40003480: 52800141     	mov	w1, #0xa                // =10
40003484: 940001ae     	bl	0x40003b3c <uart_printf>
40003488: aa1403e0     	mov	x0, x20
4000348c: 52800161     	mov	w1, #0xb                // =11
40003490: 2a1303e2     	mov	w2, w19
40003494: 940001aa     	bl	0x40003b3c <uart_printf>
40003498: 0b1302e2     	add	w2, w23, w19
4000349c: aa1403e0     	mov	x0, x20
400034a0: 52800161     	mov	w1, #0xb                // =11
400034a4: 940001a6     	bl	0x40003b3c <uart_printf>
400034a8: aa1403e0     	mov	x0, x20
400034ac: 52800181     	mov	w1, #0xc                // =12
400034b0: 2a1303e2     	mov	w2, w19
400034b4: 940001a2     	bl	0x40003b3c <uart_printf>
400034b8: 0b1302e2     	add	w2, w23, w19
400034bc: aa1403e0     	mov	x0, x20
400034c0: 52800181     	mov	w1, #0xc                // =12
400034c4: 9400019e     	bl	0x40003b3c <uart_printf>
400034c8: aa1403e0     	mov	x0, x20
400034cc: 528001a1     	mov	w1, #0xd                // =13
400034d0: 2a1303e2     	mov	w2, w19
400034d4: 9400019a     	bl	0x40003b3c <uart_printf>
400034d8: 0b1302e2     	add	w2, w23, w19
400034dc: aa1403e0     	mov	x0, x20
400034e0: 528001a1     	mov	w1, #0xd                // =13
400034e4: 94000196     	bl	0x40003b3c <uart_printf>
400034e8: aa1403e0     	mov	x0, x20
400034ec: 528001c1     	mov	w1, #0xe                // =14
400034f0: 2a1303e2     	mov	w2, w19
400034f4: 94000192     	bl	0x40003b3c <uart_printf>
400034f8: 0b1302e2     	add	w2, w23, w19
400034fc: aa1403e0     	mov	x0, x20
40003500: 528001c1     	mov	w1, #0xe                // =14
40003504: 9400018e     	bl	0x40003b3c <uart_printf>
40003508: aa1403e0     	mov	x0, x20
4000350c: 528001e1     	mov	w1, #0xf                // =15
40003510: 2a1303e2     	mov	w2, w19
40003514: 9400018a     	bl	0x40003b3c <uart_printf>
40003518: 0b1302e2     	add	w2, w23, w19
4000351c: aa1403e0     	mov	x0, x20
40003520: 528001e1     	mov	w1, #0xf                // =15
40003524: 94000186     	bl	0x40003b3c <uart_printf>
40003528: aa1403e0     	mov	x0, x20
4000352c: 52800201     	mov	w1, #0x10               // =16
40003530: 2a1303e2     	mov	w2, w19
40003534: 94000182     	bl	0x40003b3c <uart_printf>
40003538: 0b1302e2     	add	w2, w23, w19
4000353c: aa1403e0     	mov	x0, x20
40003540: 52800201     	mov	w1, #0x10               // =16
40003544: 9400017e     	bl	0x40003b3c <uart_printf>
40003548: aa1403e0     	mov	x0, x20
4000354c: 52800221     	mov	w1, #0x11               // =17
40003550: 2a1303e2     	mov	w2, w19
40003554: 9400017a     	bl	0x40003b3c <uart_printf>
40003558: 0b1302e2     	add	w2, w23, w19
4000355c: aa1403e0     	mov	x0, x20
40003560: 52800221     	mov	w1, #0x11               // =17
40003564: 94000176     	bl	0x40003b3c <uart_printf>
40003568: aa1403e0     	mov	x0, x20
4000356c: 52800241     	mov	w1, #0x12               // =18
40003570: 2a1303e2     	mov	w2, w19
40003574: 94000172     	bl	0x40003b3c <uart_printf>
40003578: 0b1302e2     	add	w2, w23, w19
4000357c: aa1403e0     	mov	x0, x20
40003580: 52800241     	mov	w1, #0x12               // =18
40003584: 9400016e     	bl	0x40003b3c <uart_printf>
40003588: aa1403e0     	mov	x0, x20
4000358c: 52800261     	mov	w1, #0x13               // =19
40003590: 2a1303e2     	mov	w2, w19
40003594: 9400016a     	bl	0x40003b3c <uart_printf>
40003598: 0b1302e2     	add	w2, w23, w19
4000359c: aa1403e0     	mov	x0, x20
400035a0: 52800261     	mov	w1, #0x13               // =19
400035a4: 94000166     	bl	0x40003b3c <uart_printf>
400035a8: aa1403e0     	mov	x0, x20
400035ac: 52800281     	mov	w1, #0x14               // =20
400035b0: 2a1303e2     	mov	w2, w19
400035b4: 94000162     	bl	0x40003b3c <uart_printf>
400035b8: 0b1302e2     	add	w2, w23, w19
400035bc: aa1403e0     	mov	x0, x20
400035c0: 52800281     	mov	w1, #0x14               // =20
400035c4: 9400015e     	bl	0x40003b3c <uart_printf>
400035c8: aa1403e0     	mov	x0, x20
400035cc: 528002a1     	mov	w1, #0x15               // =21
400035d0: 2a1303e2     	mov	w2, w19
400035d4: 9400015a     	bl	0x40003b3c <uart_printf>
400035d8: 0b1302e2     	add	w2, w23, w19
400035dc: aa1403e0     	mov	x0, x20
400035e0: 528002a1     	mov	w1, #0x15               // =21
400035e4: 94000156     	bl	0x40003b3c <uart_printf>
400035e8: aa1403e0     	mov	x0, x20
400035ec: 528002c1     	mov	w1, #0x16               // =22
400035f0: 2a1303e2     	mov	w2, w19
400035f4: 94000152     	bl	0x40003b3c <uart_printf>
400035f8: 0b1302e2     	add	w2, w23, w19
400035fc: aa1403e0     	mov	x0, x20
40003600: 528002c1     	mov	w1, #0x16               // =22
40003604: 9400014e     	bl	0x40003b3c <uart_printf>
40003608: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000360c: 91176800     	add	x0, x0, #0x5da
40003610: 528002e1     	mov	w1, #0x17               // =23
40003614: 2a1303e2     	mov	w2, w19
40003618: 94000149     	bl	0x40003b3c <uart_printf>
4000361c: d0000033     	adrp	x19, 0x40009000 <__rodata_start>
40003620: 91158e73     	add	x19, x19, #0x563
40003624: aa1303e0     	mov	x0, x19
40003628: 94000030     	bl	0x400036e8 <uart_puts>
4000362c: 710006d6     	subs	w22, w22, #0x1
40003630: 54ffffa1     	b.ne	0x40003624 <draw_box+0x33c>
40003634: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003638: 91179800     	add	x0, x0, #0x5e6
4000363c: 9400002b     	bl	0x400036e8 <uart_puts>
40003640: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003644: f0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40003648: 9134b400     	add	x0, x0, #0xd2d
4000364c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003650: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003654: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003658: 14000024     	b	0x400036e8 <uart_puts>

000000004000365c <uart_init>:
4000365c: 52800608     	mov	w8, #0x30               // =48
40003660: 528001a9     	mov	w9, #0xd                // =13
40003664: 5280002a     	mov	w10, #0x1               // =1
40003668: 72a12008     	movk	w8, #0x900, lsl #16
4000366c: b900011f     	str	wzr, [x8]
40003670: b81f4109     	stur	w9, [x8, #-0xc]
40003674: 52800e09     	mov	w9, #0x70               // =112
40003678: b81f810a     	stur	w10, [x8, #-0x8]
4000367c: b81fc109     	stur	w9, [x8, #-0x4]
40003680: 52806029     	mov	w9, #0x301              // =769
40003684: b9000109     	str	w9, [x8]
40003688: d65f03c0     	ret

000000004000368c <uart_putc>:
4000368c: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40003690: b94b8108     	ldr	w8, [x8, #0xb80]
40003694: 340001a8     	cbz	w8, 0x400036c8 <uart_putc+0x3c>
40003698: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
4000369c: 5287ffca     	mov	w10, #0x3ffe            // =16382
400036a0: b94b8509     	ldr	w9, [x8, #0xb84]
400036a4: 6b0a013f     	cmp	w9, w10
400036a8: 5400010c     	b.gt	0x400036c8 <uart_putc+0x3c>
400036ac: 93407d29     	sxtw	x9, w9
400036b0: d503201f     	nop
400036b4: 100726aa     	adr	x10, 0x40011b88 <kernel_capture_buffer>
400036b8: 9100052b     	add	x11, x9, #0x1
400036bc: 38296940     	strb	w0, [x10, x9]
400036c0: b90b850b     	str	w11, [x8, #0xb84]
400036c4: 382b695f     	strb	wzr, [x10, x11]
400036c8: 52800308     	mov	w8, #0x18               // =24
400036cc: 72a12008     	movk	w8, #0x900, lsl #16
400036d0: b9400109     	ldr	w9, [x8]
400036d4: 372fffe9     	tbnz	w9, #0x5, 0x400036d0 <uart_putc+0x44>
400036d8: 12001c08     	and	w8, w0, #0xff
400036dc: 52a12009     	mov	w9, #0x9000000          // =150994944
400036e0: b9000128     	str	w8, [x9]
400036e4: d65f03c0     	ret

00000000400036e8 <uart_puts>:
400036e8: 52800308     	mov	w8, #0x18               // =24
400036ec: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
400036f0: d000006a     	adrp	x10, 0x40011000 <var_values+0x6a8>
400036f4: 72a12008     	movk	w8, #0x900, lsl #16
400036f8: d503201f     	nop
400036fc: 1007246b     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003700: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003704: 528001ad     	mov	w13, #0xd               // =13
40003708: 52a1200e     	mov	w14, #0x9000000         // =150994944
4000370c: 3940000f     	ldrb	w15, [x0]
40003710: 710029ff     	cmp	w15, #0xa
40003714: 540000a0     	b.eq	0x40003728 <uart_puts+0x40>
40003718: 3400042f     	cbz	w15, 0x4000379c <uart_puts+0xb4>
4000371c: b94b8130     	ldr	w16, [x9, #0xb80]
40003720: 35000250     	cbnz	w16, 0x40003768 <uart_puts+0x80>
40003724: 14000019     	b	0x40003788 <uart_puts+0xa0>
40003728: b94b812f     	ldr	w15, [x9, #0xb80]
4000372c: 3400012f     	cbz	w15, 0x40003750 <uart_puts+0x68>
40003730: b94b854f     	ldr	w15, [x10, #0xb84]
40003734: 6b0c01ff     	cmp	w15, w12
40003738: 540000cc     	b.gt	0x40003750 <uart_puts+0x68>
4000373c: 93407def     	sxtw	x15, w15
40003740: 910005f0     	add	x16, x15, #0x1
40003744: 382f696d     	strb	w13, [x11, x15]
40003748: b90b8550     	str	w16, [x10, #0xb84]
4000374c: 3830697f     	strb	wzr, [x11, x16]
40003750: b940010f     	ldr	w15, [x8]
40003754: 372fffef     	tbnz	w15, #0x5, 0x40003750 <uart_puts+0x68>
40003758: b90001cd     	str	w13, [x14]
4000375c: 3940000f     	ldrb	w15, [x0]
40003760: b94b8130     	ldr	w16, [x9, #0xb80]
40003764: 34000130     	cbz	w16, 0x40003788 <uart_puts+0xa0>
40003768: b94b8550     	ldr	w16, [x10, #0xb84]
4000376c: 6b0c021f     	cmp	w16, w12
40003770: 540000cc     	b.gt	0x40003788 <uart_puts+0xa0>
40003774: 93407e10     	sxtw	x16, w16
40003778: 91000611     	add	x17, x16, #0x1
4000377c: 3830696f     	strb	w15, [x11, x16]
40003780: b90b8551     	str	w17, [x10, #0xb84]
40003784: 3831697f     	strb	wzr, [x11, x17]
40003788: 91000400     	add	x0, x0, #0x1
4000378c: b9400110     	ldr	w16, [x8]
40003790: 372ffff0     	tbnz	w16, #0x5, 0x4000378c <uart_puts+0xa4>
40003794: b90001cf     	str	w15, [x14]
40003798: 17ffffdd     	b	0x4000370c <uart_puts+0x24>
4000379c: d65f03c0     	ret

00000000400037a0 <uart_has_data>:
400037a0: 52800308     	mov	w8, #0x18               // =24
400037a4: 52800029     	mov	w9, #0x1                // =1
400037a8: 72a12008     	movk	w8, #0x900, lsl #16
400037ac: b9400108     	ldr	w8, [x8]
400037b0: 0a681120     	bic	w0, w9, w8, lsr #4
400037b4: d65f03c0     	ret

00000000400037b8 <uart_getc>:
400037b8: 52800308     	mov	w8, #0x18               // =24
400037bc: 72a12008     	movk	w8, #0x900, lsl #16
400037c0: b9400109     	ldr	w9, [x8]
400037c4: 3727ffe9     	tbnz	w9, #0x4, 0x400037c0 <uart_getc+0x8>
400037c8: 52a12008     	mov	w8, #0x9000000          // =150994944
400037cc: b9400100     	ldr	w0, [x8]
400037d0: d65f03c0     	ret

00000000400037d4 <uart_print_hex_raw>:
400037d4: 52800308     	mov	w8, #0x18               // =24
400037d8: 2a1f03eb     	mov	w11, wzr
400037dc: 5280078c     	mov	w12, #0x3c              // =60
400037e0: 72a12008     	movk	w8, #0x900, lsl #16
400037e4: d503201f     	nop
400037e8: 1002e8ce     	adr	x14, 0x40009500 <__rodata_start+0x500>
400037ec: d000006d     	adrp	x13, 0x40011000 <var_values+0x6a8>
400037f0: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
400037f4: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037f8: d503201f     	nop
400037fc: 10071c6a     	adr	x10, 0x40011b88 <kernel_capture_buffer>
40003800: 52a12010     	mov	w16, #0x9000000         // =150994944
40003804: 14000003     	b	0x40003810 <uart_print_hex_raw+0x3c>
40003808: b400032c     	cbz	x12, 0x4000386c <uart_print_hex_raw+0x98>
4000380c: d100118c     	sub	x12, x12, #0x4
40003810: 9acc2411     	lsr	x17, x0, x12
40003814: 53027d92     	lsr	w18, w12, #2
40003818: 92400e31     	and	x17, x17, #0xf
4000381c: 6b01025f     	cmp	w18, w1
40003820: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003824: 1a9f056b     	csinc	w11, w11, wzr, eq
40003828: 34ffff0b     	cbz	w11, 0x40003808 <uart_print_hex_raw+0x34>
4000382c: b94b81b2     	ldr	w18, [x13, #0xb80]
40003830: 387169d1     	ldrb	w17, [x14, x17]
40003834: 34000132     	cbz	w18, 0x40003858 <uart_print_hex_raw+0x84>
40003838: b94b8532     	ldr	w18, [x9, #0xb84]
4000383c: 6b0f025f     	cmp	w18, w15
40003840: 540000cc     	b.gt	0x40003858 <uart_print_hex_raw+0x84>
40003844: 93407e52     	sxtw	x18, w18
40003848: 91000642     	add	x2, x18, #0x1
4000384c: 38326951     	strb	w17, [x10, x18]
40003850: b90b8522     	str	w2, [x9, #0xb84]
40003854: 3822695f     	strb	wzr, [x10, x2]
40003858: b9400112     	ldr	w18, [x8]
4000385c: 372ffff2     	tbnz	w18, #0x5, 0x40003858 <uart_print_hex_raw+0x84>
40003860: b9000211     	str	w17, [x16]
40003864: b5fffd4c     	cbnz	x12, 0x4000380c <uart_print_hex_raw+0x38>
40003868: d65f03c0     	ret
4000386c: b94b81ab     	ldr	w11, [x13, #0xb80]
40003870: 3400016b     	cbz	w11, 0x4000389c <uart_print_hex_raw+0xc8>
40003874: b94b852b     	ldr	w11, [x9, #0xb84]
40003878: 5287ffcc     	mov	w12, #0x3ffe            // =16382
4000387c: 6b0c017f     	cmp	w11, w12
40003880: 540000ec     	b.gt	0x4000389c <uart_print_hex_raw+0xc8>
40003884: 93407d6b     	sxtw	x11, w11
40003888: 5280060c     	mov	w12, #0x30              // =48
4000388c: 9100056d     	add	x13, x11, #0x1
40003890: 382b694c     	strb	w12, [x10, x11]
40003894: b90b852d     	str	w13, [x9, #0xb84]
40003898: 382d695f     	strb	wzr, [x10, x13]
4000389c: b9400109     	ldr	w9, [x8]
400038a0: 372fffe9     	tbnz	w9, #0x5, 0x4000389c <uart_print_hex_raw+0xc8>
400038a4: 52a12008     	mov	w8, #0x9000000          // =150994944
400038a8: 52800609     	mov	w9, #0x30               // =48
400038ac: b9000109     	str	w9, [x8]
400038b0: d65f03c0     	ret

00000000400038b4 <uart_print_hex>:
400038b4: 52800308     	mov	w8, #0x18               // =24
400038b8: f000002c     	adrp	x12, 0x4000a000 <__rodata_start+0x1000>
400038bc: 9108058c     	add	x12, x12, #0x201
400038c0: 72a12008     	movk	w8, #0x900, lsl #16
400038c4: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
400038c8: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
400038cc: d503201f     	nop
400038d0: 100715ca     	adr	x10, 0x40011b88 <kernel_capture_buffer>
400038d4: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038d8: 528001ae     	mov	w14, #0xd               // =13
400038dc: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038e0: 39400190     	ldrb	w16, [x12]
400038e4: 71002a1f     	cmp	w16, #0xa
400038e8: 540000a0     	b.eq	0x400038fc <uart_print_hex+0x48>
400038ec: 34000410     	cbz	w16, 0x4000396c <uart_print_hex+0xb8>
400038f0: b94b8171     	ldr	w17, [x11, #0xb80]
400038f4: 35000231     	cbnz	w17, 0x40003938 <uart_print_hex+0x84>
400038f8: 14000018     	b	0x40003958 <uart_print_hex+0xa4>
400038fc: b94b8171     	ldr	w17, [x11, #0xb80]
40003900: 34000131     	cbz	w17, 0x40003924 <uart_print_hex+0x70>
40003904: b94b8531     	ldr	w17, [x9, #0xb84]
40003908: 6b0d023f     	cmp	w17, w13
4000390c: 540000cc     	b.gt	0x40003924 <uart_print_hex+0x70>
40003910: 93407e31     	sxtw	x17, w17
40003914: 91000632     	add	x18, x17, #0x1
40003918: 3831694e     	strb	w14, [x10, x17]
4000391c: b90b8532     	str	w18, [x9, #0xb84]
40003920: 3832695f     	strb	wzr, [x10, x18]
40003924: b9400111     	ldr	w17, [x8]
40003928: 372ffff1     	tbnz	w17, #0x5, 0x40003924 <uart_print_hex+0x70>
4000392c: b90001ee     	str	w14, [x15]
40003930: b94b8171     	ldr	w17, [x11, #0xb80]
40003934: 34000131     	cbz	w17, 0x40003958 <uart_print_hex+0xa4>
40003938: b94b8531     	ldr	w17, [x9, #0xb84]
4000393c: 6b0d023f     	cmp	w17, w13
40003940: 540000cc     	b.gt	0x40003958 <uart_print_hex+0xa4>
40003944: 93407e31     	sxtw	x17, w17
40003948: 91000632     	add	x18, x17, #0x1
4000394c: 38316950     	strb	w16, [x10, x17]
40003950: b90b8532     	str	w18, [x9, #0xb84]
40003954: 3832695f     	strb	wzr, [x10, x18]
40003958: 9100058c     	add	x12, x12, #0x1
4000395c: b9400111     	ldr	w17, [x8]
40003960: 372ffff1     	tbnz	w17, #0x5, 0x4000395c <uart_print_hex+0xa8>
40003964: b90001f0     	str	w16, [x15]
40003968: 17ffffde     	b	0x400038e0 <uart_print_hex+0x2c>
4000396c: 2a1f03ec     	mov	w12, wzr
40003970: d503201f     	nop
40003974: 1002dc6d     	adr	x13, 0x40009500 <__rodata_start+0x500>
40003978: 5280078e     	mov	w14, #0x3c              // =60
4000397c: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003980: 52a12010     	mov	w16, #0x9000000         // =150994944
40003984: 14000003     	b	0x40003990 <uart_print_hex+0xdc>
40003988: b40002ee     	cbz	x14, 0x400039e4 <uart_print_hex+0x130>
4000398c: d10011ce     	sub	x14, x14, #0x4
40003990: 9ace2411     	lsr	x17, x0, x14
40003994: f2400e31     	ands	x17, x17, #0xf
40003998: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
4000399c: 1a9f158c     	csinc	w12, w12, wzr, ne
400039a0: 34ffff4c     	cbz	w12, 0x40003988 <uart_print_hex+0xd4>
400039a4: b94b8172     	ldr	w18, [x11, #0xb80]
400039a8: 387169b1     	ldrb	w17, [x13, x17]
400039ac: 34000132     	cbz	w18, 0x400039d0 <uart_print_hex+0x11c>
400039b0: b94b8532     	ldr	w18, [x9, #0xb84]
400039b4: 6b0f025f     	cmp	w18, w15
400039b8: 540000cc     	b.gt	0x400039d0 <uart_print_hex+0x11c>
400039bc: 93407e52     	sxtw	x18, w18
400039c0: 91000641     	add	x1, x18, #0x1
400039c4: 38326951     	strb	w17, [x10, x18]
400039c8: b90b8521     	str	w1, [x9, #0xb84]
400039cc: 3821695f     	strb	wzr, [x10, x1]
400039d0: b9400112     	ldr	w18, [x8]
400039d4: 372ffff2     	tbnz	w18, #0x5, 0x400039d0 <uart_print_hex+0x11c>
400039d8: b9000211     	str	w17, [x16]
400039dc: b5fffd8e     	cbnz	x14, 0x4000398c <uart_print_hex+0xd8>
400039e0: d65f03c0     	ret
400039e4: b94b816b     	ldr	w11, [x11, #0xb80]
400039e8: 3400016b     	cbz	w11, 0x40003a14 <uart_print_hex+0x160>
400039ec: b94b852b     	ldr	w11, [x9, #0xb84]
400039f0: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039f4: 6b0c017f     	cmp	w11, w12
400039f8: 540000ec     	b.gt	0x40003a14 <uart_print_hex+0x160>
400039fc: 93407d6b     	sxtw	x11, w11
40003a00: 5280060c     	mov	w12, #0x30              // =48
40003a04: 9100056d     	add	x13, x11, #0x1
40003a08: 382b694c     	strb	w12, [x10, x11]
40003a0c: b90b852d     	str	w13, [x9, #0xb84]
40003a10: 382d695f     	strb	wzr, [x10, x13]
40003a14: b9400109     	ldr	w9, [x8]
40003a18: 372fffe9     	tbnz	w9, #0x5, 0x40003a14 <uart_print_hex+0x160>
40003a1c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003a20: 52800609     	mov	w9, #0x30               // =48
40003a24: b9000109     	str	w9, [x8]
40003a28: d65f03c0     	ret

0000000040003a2c <uart_print_dec>:
40003a2c: d10083ff     	sub	sp, sp, #0x20
40003a30: 52800308     	mov	w8, #0x18               // =24
40003a34: 72a12008     	movk	w8, #0x900, lsl #16
40003a38: b4000540     	cbz	x0, 0x40003ae0 <uart_print_dec+0xb4>
40003a3c: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003a40: aa1f03e9     	mov	x9, xzr
40003a44: 5280014b     	mov	w11, #0xa               // =10
40003a48: f29999aa     	movk	x10, #0xcccd
40003a4c: 910023ec     	add	x12, sp, #0x8
40003a50: 9bca7c0d     	umulh	x13, x0, x10
40003a54: f100241f     	cmp	x0, #0x9
40003a58: d343fdad     	lsr	x13, x13, #3
40003a5c: 1b0b81ae     	msub	w14, w13, w11, w0
40003a60: aa0d03e0     	mov	x0, x13
40003a64: 321c05ce     	orr	w14, w14, #0x30
40003a68: 3829698e     	strb	w14, [x12, x9]
40003a6c: 91000529     	add	x9, x9, #0x1
40003a70: 54ffff08     	b.hi	0x40003a50 <uart_print_dec+0x24>
40003a74: 910023ea     	add	x10, sp, #0x8
40003a78: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
40003a7c: d000006c     	adrp	x12, 0x40011000 <var_values+0x6a8>
40003a80: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a84: d503201f     	nop
40003a88: 1007080e     	adr	x14, 0x40011b88 <kernel_capture_buffer>
40003a8c: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a90: d1000530     	sub	x16, x9, #0x1
40003a94: b94b8172     	ldr	w18, [x11, #0xb80]
40003a98: 38706951     	ldrb	w17, [x10, x16]
40003a9c: 34000132     	cbz	w18, 0x40003ac0 <uart_print_dec+0x94>
40003aa0: b94b8592     	ldr	w18, [x12, #0xb84]
40003aa4: 6b0d025f     	cmp	w18, w13
40003aa8: 540000cc     	b.gt	0x40003ac0 <uart_print_dec+0x94>
40003aac: 93407e52     	sxtw	x18, w18
40003ab0: 91000640     	add	x0, x18, #0x1
40003ab4: 383269d1     	strb	w17, [x14, x18]
40003ab8: b90b8580     	str	w0, [x12, #0xb84]
40003abc: 382069df     	strb	wzr, [x14, x0]
40003ac0: b9400112     	ldr	w18, [x8]
40003ac4: 372ffff2     	tbnz	w18, #0x5, 0x40003ac0 <uart_print_dec+0x94>
40003ac8: 7100053f     	cmp	w9, #0x1
40003acc: aa1003e9     	mov	x9, x16
40003ad0: b90001f1     	str	w17, [x15]
40003ad4: 54fffdec     	b.gt	0x40003a90 <uart_print_dec+0x64>
40003ad8: 910083ff     	add	sp, sp, #0x20
40003adc: d65f03c0     	ret
40003ae0: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003ae4: b94b8129     	ldr	w9, [x9, #0xb80]
40003ae8: 340001c9     	cbz	w9, 0x40003b20 <uart_print_dec+0xf4>
40003aec: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003af0: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003af4: b94b852a     	ldr	w10, [x9, #0xb84]
40003af8: 6b0b015f     	cmp	w10, w11
40003afc: 5400012c     	b.gt	0x40003b20 <uart_print_dec+0xf4>
40003b00: 93407d4a     	sxtw	x10, w10
40003b04: d503201f     	nop
40003b08: 1007040b     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003b0c: 5280060c     	mov	w12, #0x30              // =48
40003b10: 9100054d     	add	x13, x10, #0x1
40003b14: 382a696c     	strb	w12, [x11, x10]
40003b18: b90b852d     	str	w13, [x9, #0xb84]
40003b1c: 382d697f     	strb	wzr, [x11, x13]
40003b20: b9400109     	ldr	w9, [x8]
40003b24: 372fffe9     	tbnz	w9, #0x5, 0x40003b20 <uart_print_dec+0xf4>
40003b28: 52a12008     	mov	w8, #0x9000000          // =150994944
40003b2c: 52800609     	mov	w9, #0x30               // =48
40003b30: b9000109     	str	w9, [x8]
40003b34: 910083ff     	add	sp, sp, #0x20
40003b38: d65f03c0     	ret

0000000040003b3c <uart_printf>:
40003b3c: d10343ff     	sub	sp, sp, #0xd0
40003b40: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003b44: 9101c3fd     	add	x29, sp, #0x70
40003b48: 910003e8     	mov	x8, sp
40003b4c: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003b50: 52800315     	mov	w21, #0x18              // =24
40003b54: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003b58: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003b5c: 72a12015     	movk	w21, #0x900, lsl #16
40003b60: 128006e9     	mov	w9, #-0x38              // =-56
40003b64: a90967fa     	stp	x26, x25, [sp, #0x90]
40003b68: 9100e108     	add	x8, x8, #0x38
40003b6c: 910183aa     	add	x10, x29, #0x60
40003b70: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003b74: d0000076     	adrp	x22, 0x40011000 <var_values+0x6a8>
40003b78: d0000077     	adrp	x23, 0x40011000 <var_values+0x6a8>
40003b7c: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003b80: aa0003f3     	mov	x19, x0
40003b84: aa1f03f4     	mov	x20, xzr
40003b88: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003b8c: d503201f     	nop
40003b90: 1006ffd9     	adr	x25, 0x40011b88 <kernel_capture_buffer>
40003b94: 528001ba     	mov	w26, #0xd               // =13
40003b98: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b9c: 528004ae     	mov	w14, #0x25              // =37
40003ba0: f29999af     	movk	x15, #0xcccd
40003ba4: 52800150     	mov	w16, #0xa               // =10
40003ba8: d10063bc     	sub	x28, x29, #0x18
40003bac: d503201f     	nop
40003bb0: 1002ca91     	adr	x17, 0x40009500 <__rodata_start+0x500>
40003bb4: a9000be1     	stp	x1, x2, [sp]
40003bb8: a90113e3     	stp	x3, x4, [sp, #0x10]
40003bbc: a9021be5     	stp	x5, x6, [sp, #0x20]
40003bc0: f9002be9     	str	x9, [sp, #0x50]
40003bc4: f90023e8     	str	x8, [sp, #0x40]
40003bc8: a9032be7     	stp	x7, x10, [sp, #0x30]
40003bcc: 14000004     	b	0x40003bdc <uart_printf+0xa0>
40003bd0: 52800608     	mov	w8, #0x30               // =48
40003bd4: b9000368     	str	w8, [x27]
40003bd8: 91000694     	add	x20, x20, #0x1
40003bdc: 38746a68     	ldrb	w8, [x19, x20]
40003be0: 7100291f     	cmp	w8, #0xa
40003be4: 54000440     	b.eq	0x40003c6c <uart_printf+0x130>
40003be8: 7100951f     	cmp	w8, #0x25
40003bec: 540000a0     	b.eq	0x40003c00 <uart_printf+0xc4>
40003bf0: 34003ae8     	cbz	w8, 0x4000434c <uart_printf+0x810>
40003bf4: b94b82c9     	ldr	w9, [x22, #0xb80]
40003bf8: 350005a9     	cbnz	w9, 0x40003cac <uart_printf+0x170>
40003bfc: 14000034     	b	0x40003ccc <uart_printf+0x190>
40003c00: 9100068a     	add	x10, x20, #0x1
40003c04: 386a6a68     	ldrb	w8, [x19, x10]
40003c08: 7101b11f     	cmp	w8, #0x6c
40003c0c: 54000661     	b.ne	0x40003cd8 <uart_printf+0x19c>
40003c10: 91000a89     	add	x9, x20, #0x2
40003c14: 91000e8b     	add	x11, x20, #0x3
40003c18: 38696a6a     	ldrb	w10, [x19, x9]
40003c1c: 7101b15f     	cmp	w10, #0x6c
40003c20: 9a890174     	csel	x20, x11, x9, eq
40003c24: 38746a69     	ldrb	w9, [x19, x20]
40003c28: 7101bd3f     	cmp	w9, #0x6f
40003c2c: 540005ed     	b.le	0x40003ce8 <uart_printf+0x1ac>
40003c30: 7101d13f     	cmp	w9, #0x74
40003c34: 5400080c     	b.gt	0x40003d34 <uart_printf+0x1f8>
40003c38: 7101c13f     	cmp	w9, #0x70
40003c3c: 54000f00     	b.eq	0x40003e1c <uart_printf+0x2e0>
40003c40: 7101cd3f     	cmp	w9, #0x73
40003c44: 54000b61     	b.ne	0x40003db0 <uart_printf+0x274>
40003c48: b98053e8     	ldrsw	x8, [sp, #0x50]
40003c4c: 36f81408     	tbz	w8, #0x1f, 0x40003ecc <uart_printf+0x390>
40003c50: 11002109     	add	w9, w8, #0x8
40003c54: 3100211f     	cmn	w8, #0x8
40003c58: b90053e9     	str	w9, [sp, #0x50]
40003c5c: 54001388     	b.hi	0x40003ecc <uart_printf+0x390>
40003c60: f94023e9     	ldr	x9, [sp, #0x40]
40003c64: 8b080128     	add	x8, x9, x8
40003c68: 1400009c     	b	0x40003ed8 <uart_printf+0x39c>
40003c6c: b94b82c8     	ldr	w8, [x22, #0xb80]
40003c70: 34000128     	cbz	w8, 0x40003c94 <uart_printf+0x158>
40003c74: b94b86e8     	ldr	w8, [x23, #0xb84]
40003c78: 6b18011f     	cmp	w8, w24
40003c7c: 540000cc     	b.gt	0x40003c94 <uart_printf+0x158>
40003c80: 93407d08     	sxtw	x8, w8
40003c84: 91000509     	add	x9, x8, #0x1
40003c88: 38286b3a     	strb	w26, [x25, x8]
40003c8c: b90b86e9     	str	w9, [x23, #0xb84]
40003c90: 38296b3f     	strb	wzr, [x25, x9]
40003c94: b94002a8     	ldr	w8, [x21]
40003c98: 372fffe8     	tbnz	w8, #0x5, 0x40003c94 <uart_printf+0x158>
40003c9c: b900037a     	str	w26, [x27]
40003ca0: 38746a68     	ldrb	w8, [x19, x20]
40003ca4: b94b82c9     	ldr	w9, [x22, #0xb80]
40003ca8: 34000129     	cbz	w9, 0x40003ccc <uart_printf+0x190>
40003cac: b94b86e9     	ldr	w9, [x23, #0xb84]
40003cb0: 6b18013f     	cmp	w9, w24
40003cb4: 540000cc     	b.gt	0x40003ccc <uart_printf+0x190>
40003cb8: 93407d29     	sxtw	x9, w9
40003cbc: 9100052a     	add	x10, x9, #0x1
40003cc0: 38296b28     	strb	w8, [x25, x9]
40003cc4: b90b86ea     	str	w10, [x23, #0xb84]
40003cc8: 382a6b3f     	strb	wzr, [x25, x10]
40003ccc: b94002a9     	ldr	w9, [x21]
40003cd0: 372fffe9     	tbnz	w9, #0x5, 0x40003ccc <uart_printf+0x190>
40003cd4: 17ffffc0     	b	0x40003bd4 <uart_printf+0x98>
40003cd8: 2a0803e9     	mov	w9, w8
40003cdc: aa0a03f4     	mov	x20, x10
40003ce0: 7101bd3f     	cmp	w9, #0x6f
40003ce4: 54fffa6c     	b.gt	0x40003c30 <uart_printf+0xf4>
40003ce8: 7100953f     	cmp	w9, #0x25
40003cec: 54000440     	b.eq	0x40003d74 <uart_printf+0x238>
40003cf0: 71018d3f     	cmp	w9, #0x63
40003cf4: 54000c00     	b.eq	0x40003e74 <uart_printf+0x338>
40003cf8: 7101913f     	cmp	w9, #0x64
40003cfc: 540005a1     	b.ne	0x40003db0 <uart_printf+0x274>
40003d00: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d04: 7101b11f     	cmp	w8, #0x6c
40003d08: 540017c1     	b.ne	0x40004000 <uart_printf+0x4c4>
40003d0c: 36f823c9     	tbz	w9, #0x1f, 0x40004184 <uart_printf+0x648>
40003d10: 11002128     	add	w8, w9, #0x8
40003d14: 3100213f     	cmn	w9, #0x8
40003d18: b90053e8     	str	w8, [sp, #0x50]
40003d1c: 54002348     	b.hi	0x40004184 <uart_printf+0x648>
40003d20: f94023e8     	ldr	x8, [sp, #0x40]
40003d24: 8b090108     	add	x8, x8, x9
40003d28: f9400108     	ldr	x8, [x8]
40003d2c: b6f829a8     	tbz	x8, #0x3f, 0x40004260 <uart_printf+0x724>
40003d30: 1400011a     	b	0x40004198 <uart_printf+0x65c>
40003d34: 7101d53f     	cmp	w9, #0x75
40003d38: 54000840     	b.eq	0x40003e40 <uart_printf+0x304>
40003d3c: 7101e13f     	cmp	w9, #0x78
40003d40: 54000381     	b.ne	0x40003db0 <uart_printf+0x274>
40003d44: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d48: 7101b11f     	cmp	w8, #0x6c
40003d4c: 540014a1     	b.ne	0x40003fe0 <uart_printf+0x4a4>
40003d50: 36f81d49     	tbz	w9, #0x1f, 0x400040f8 <uart_printf+0x5bc>
40003d54: 11002128     	add	w8, w9, #0x8
40003d58: 3100213f     	cmn	w9, #0x8
40003d5c: b90053e8     	str	w8, [sp, #0x50]
40003d60: 54001cc8     	b.hi	0x400040f8 <uart_printf+0x5bc>
40003d64: f94023e8     	ldr	x8, [sp, #0x40]
40003d68: 8b090108     	add	x8, x8, x9
40003d6c: f9400108     	ldr	x8, [x8]
40003d70: 140000eb     	b	0x4000411c <uart_printf+0x5e0>
40003d74: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d78: 34000128     	cbz	w8, 0x40003d9c <uart_printf+0x260>
40003d7c: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d80: 6b18011f     	cmp	w8, w24
40003d84: 540000cc     	b.gt	0x40003d9c <uart_printf+0x260>
40003d88: 93407d08     	sxtw	x8, w8
40003d8c: 91000509     	add	x9, x8, #0x1
40003d90: 38286b2e     	strb	w14, [x25, x8]
40003d94: b90b86e9     	str	w9, [x23, #0xb84]
40003d98: 38296b3f     	strb	wzr, [x25, x9]
40003d9c: b94002a8     	ldr	w8, [x21]
40003da0: 372fffe8     	tbnz	w8, #0x5, 0x40003d9c <uart_printf+0x260>
40003da4: b900036e     	str	w14, [x27]
40003da8: 91000694     	add	x20, x20, #0x1
40003dac: 17ffff8c     	b	0x40003bdc <uart_printf+0xa0>
40003db0: b94b82c8     	ldr	w8, [x22, #0xb80]
40003db4: 34000128     	cbz	w8, 0x40003dd8 <uart_printf+0x29c>
40003db8: b94b86e8     	ldr	w8, [x23, #0xb84]
40003dbc: 6b18011f     	cmp	w8, w24
40003dc0: 540000cc     	b.gt	0x40003dd8 <uart_printf+0x29c>
40003dc4: 93407d08     	sxtw	x8, w8
40003dc8: 91000509     	add	x9, x8, #0x1
40003dcc: 38286b2e     	strb	w14, [x25, x8]
40003dd0: b90b86e9     	str	w9, [x23, #0xb84]
40003dd4: 38296b3f     	strb	wzr, [x25, x9]
40003dd8: b94002a8     	ldr	w8, [x21]
40003ddc: 372fffe8     	tbnz	w8, #0x5, 0x40003dd8 <uart_printf+0x29c>
40003de0: b900036e     	str	w14, [x27]
40003de4: b94b82c9     	ldr	w9, [x22, #0xb80]
40003de8: 38746a68     	ldrb	w8, [x19, x20]
40003dec: 34000129     	cbz	w9, 0x40003e10 <uart_printf+0x2d4>
40003df0: b94b86e9     	ldr	w9, [x23, #0xb84]
40003df4: 6b18013f     	cmp	w9, w24
40003df8: 540000cc     	b.gt	0x40003e10 <uart_printf+0x2d4>
40003dfc: 93407d29     	sxtw	x9, w9
40003e00: 9100052a     	add	x10, x9, #0x1
40003e04: 38296b28     	strb	w8, [x25, x9]
40003e08: b90b86ea     	str	w10, [x23, #0xb84]
40003e0c: 382a6b3f     	strb	wzr, [x25, x10]
40003e10: b94002a9     	ldr	w9, [x21]
40003e14: 372fffe9     	tbnz	w9, #0x5, 0x40003e10 <uart_printf+0x2d4>
40003e18: 17ffff6f     	b	0x40003bd4 <uart_printf+0x98>
40003e1c: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e20: 36f803c8     	tbz	w8, #0x1f, 0x40003e98 <uart_printf+0x35c>
40003e24: 11002109     	add	w9, w8, #0x8
40003e28: 3100211f     	cmn	w8, #0x8
40003e2c: b90053e9     	str	w9, [sp, #0x50]
40003e30: 54000348     	b.hi	0x40003e98 <uart_printf+0x35c>
40003e34: f94023e9     	ldr	x9, [sp, #0x40]
40003e38: 8b080128     	add	x8, x9, x8
40003e3c: 1400001a     	b	0x40003ea4 <uart_printf+0x368>
40003e40: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e44: 7101b11f     	cmp	w8, #0x6c
40003e48: 54000bc1     	b.ne	0x40003fc0 <uart_printf+0x484>
40003e4c: 36f80ea9     	tbz	w9, #0x1f, 0x40004020 <uart_printf+0x4e4>
40003e50: 11002128     	add	w8, w9, #0x8
40003e54: 3100213f     	cmn	w9, #0x8
40003e58: b90053e8     	str	w8, [sp, #0x50]
40003e5c: 54000e28     	b.hi	0x40004020 <uart_printf+0x4e4>
40003e60: f94023e8     	ldr	x8, [sp, #0x40]
40003e64: 8b090108     	add	x8, x8, x9
40003e68: f9400109     	ldr	x9, [x8]
40003e6c: b50010a9     	cbnz	x9, 0x40004080 <uart_printf+0x544>
40003e70: 14000071     	b	0x40004034 <uart_printf+0x4f8>
40003e74: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e78: 36f80828     	tbz	w8, #0x1f, 0x40003f7c <uart_printf+0x440>
40003e7c: 11002109     	add	w9, w8, #0x8
40003e80: 3100211f     	cmn	w8, #0x8
40003e84: b90053e9     	str	w9, [sp, #0x50]
40003e88: 540007a8     	b.hi	0x40003f7c <uart_printf+0x440>
40003e8c: f94023e9     	ldr	x9, [sp, #0x40]
40003e90: 8b080128     	add	x8, x9, x8
40003e94: 1400003d     	b	0x40003f88 <uart_printf+0x44c>
40003e98: f9401fe8     	ldr	x8, [sp, #0x38]
40003e9c: 91002109     	add	x9, x8, #0x8
40003ea0: f9001fe9     	str	x9, [sp, #0x38]
40003ea4: f9400100     	ldr	x0, [x8]
40003ea8: 97fffe83     	bl	0x400038b4 <uart_print_hex>
40003eac: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003eb0: 528004ae     	mov	w14, #0x25              // =37
40003eb4: 52800150     	mov	w16, #0xa               // =10
40003eb8: f29999af     	movk	x15, #0xcccd
40003ebc: d503201f     	nop
40003ec0: 1002b211     	adr	x17, 0x40009500 <__rodata_start+0x500>
40003ec4: 91000694     	add	x20, x20, #0x1
40003ec8: 17ffff45     	b	0x40003bdc <uart_printf+0xa0>
40003ecc: f9401fe8     	ldr	x8, [sp, #0x38]
40003ed0: 91002109     	add	x9, x8, #0x8
40003ed4: f9001fe9     	str	x9, [sp, #0x38]
40003ed8: f9400108     	ldr	x8, [x8]
40003edc: 90000049     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40003ee0: 9126f129     	add	x9, x9, #0x9bc
40003ee4: f100011f     	cmp	x8, #0x0
40003ee8: 9a880128     	csel	x8, x9, x8, eq
40003eec: 39400109     	ldrb	w9, [x8]
40003ef0: 7100293f     	cmp	w9, #0xa
40003ef4: 540000a0     	b.eq	0x40003f08 <uart_printf+0x3cc>
40003ef8: 34ffe709     	cbz	w9, 0x40003bd8 <uart_printf+0x9c>
40003efc: b94b82ca     	ldr	w10, [x22, #0xb80]
40003f00: 3500024a     	cbnz	w10, 0x40003f48 <uart_printf+0x40c>
40003f04: 14000019     	b	0x40003f68 <uart_printf+0x42c>
40003f08: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f0c: 34000129     	cbz	w9, 0x40003f30 <uart_printf+0x3f4>
40003f10: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f14: 6b18013f     	cmp	w9, w24
40003f18: 540000cc     	b.gt	0x40003f30 <uart_printf+0x3f4>
40003f1c: 93407d29     	sxtw	x9, w9
40003f20: 9100052a     	add	x10, x9, #0x1
40003f24: 38296b3a     	strb	w26, [x25, x9]
40003f28: b90b86ea     	str	w10, [x23, #0xb84]
40003f2c: 382a6b3f     	strb	wzr, [x25, x10]
40003f30: b94002a9     	ldr	w9, [x21]
40003f34: 372fffe9     	tbnz	w9, #0x5, 0x40003f30 <uart_printf+0x3f4>
40003f38: b900037a     	str	w26, [x27]
40003f3c: 39400109     	ldrb	w9, [x8]
40003f40: b94b82ca     	ldr	w10, [x22, #0xb80]
40003f44: 3400012a     	cbz	w10, 0x40003f68 <uart_printf+0x42c>
40003f48: b94b86ea     	ldr	w10, [x23, #0xb84]
40003f4c: 6b18015f     	cmp	w10, w24
40003f50: 540000cc     	b.gt	0x40003f68 <uart_printf+0x42c>
40003f54: 93407d4a     	sxtw	x10, w10
40003f58: 9100054b     	add	x11, x10, #0x1
40003f5c: 382a6b29     	strb	w9, [x25, x10]
40003f60: b90b86eb     	str	w11, [x23, #0xb84]
40003f64: 382b6b3f     	strb	wzr, [x25, x11]
40003f68: 91000508     	add	x8, x8, #0x1
40003f6c: b94002aa     	ldr	w10, [x21]
40003f70: 372fffea     	tbnz	w10, #0x5, 0x40003f6c <uart_printf+0x430>
40003f74: b9000369     	str	w9, [x27]
40003f78: 17ffffdd     	b	0x40003eec <uart_printf+0x3b0>
40003f7c: f9401fe8     	ldr	x8, [sp, #0x38]
40003f80: 91002109     	add	x9, x8, #0x8
40003f84: f9001fe9     	str	x9, [sp, #0x38]
40003f88: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f8c: 39400108     	ldrb	w8, [x8]
40003f90: 34000129     	cbz	w9, 0x40003fb4 <uart_printf+0x478>
40003f94: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f98: 6b18013f     	cmp	w9, w24
40003f9c: 540000cc     	b.gt	0x40003fb4 <uart_printf+0x478>
40003fa0: 93407d29     	sxtw	x9, w9
40003fa4: 9100052a     	add	x10, x9, #0x1
40003fa8: 38296b28     	strb	w8, [x25, x9]
40003fac: b90b86ea     	str	w10, [x23, #0xb84]
40003fb0: 382a6b3f     	strb	wzr, [x25, x10]
40003fb4: b94002a9     	ldr	w9, [x21]
40003fb8: 372fffe9     	tbnz	w9, #0x5, 0x40003fb4 <uart_printf+0x478>
40003fbc: 17ffff06     	b	0x40003bd4 <uart_printf+0x98>
40003fc0: 36f80569     	tbz	w9, #0x1f, 0x4000406c <uart_printf+0x530>
40003fc4: 11002128     	add	w8, w9, #0x8
40003fc8: 3100213f     	cmn	w9, #0x8
40003fcc: b90053e8     	str	w8, [sp, #0x50]
40003fd0: 540004e8     	b.hi	0x4000406c <uart_printf+0x530>
40003fd4: f94023e8     	ldr	x8, [sp, #0x40]
40003fd8: 8b090108     	add	x8, x8, x9
40003fdc: 14000027     	b	0x40004078 <uart_printf+0x53c>
40003fe0: 36f80969     	tbz	w9, #0x1f, 0x4000410c <uart_printf+0x5d0>
40003fe4: 11002128     	add	w8, w9, #0x8
40003fe8: 3100213f     	cmn	w9, #0x8
40003fec: b90053e8     	str	w8, [sp, #0x50]
40003ff0: 540008e8     	b.hi	0x4000410c <uart_printf+0x5d0>
40003ff4: f94023e8     	ldr	x8, [sp, #0x40]
40003ff8: 8b090108     	add	x8, x8, x9
40003ffc: 14000047     	b	0x40004118 <uart_printf+0x5dc>
40004000: 36f81269     	tbz	w9, #0x1f, 0x4000424c <uart_printf+0x710>
40004004: 11002128     	add	w8, w9, #0x8
40004008: 3100213f     	cmn	w9, #0x8
4000400c: b90053e8     	str	w8, [sp, #0x50]
40004010: 540011e8     	b.hi	0x4000424c <uart_printf+0x710>
40004014: f94023e8     	ldr	x8, [sp, #0x40]
40004018: 8b090108     	add	x8, x8, x9
4000401c: 1400008f     	b	0x40004258 <uart_printf+0x71c>
40004020: f9401fe8     	ldr	x8, [sp, #0x38]
40004024: 91002109     	add	x9, x8, #0x8
40004028: f9001fe9     	str	x9, [sp, #0x38]
4000402c: f9400109     	ldr	x9, [x8]
40004030: b5000289     	cbnz	x9, 0x40004080 <uart_printf+0x544>
40004034: b94b82c8     	ldr	w8, [x22, #0xb80]
40004038: 34000148     	cbz	w8, 0x40004060 <uart_printf+0x524>
4000403c: b94b86e8     	ldr	w8, [x23, #0xb84]
40004040: 6b18011f     	cmp	w8, w24
40004044: 540000ec     	b.gt	0x40004060 <uart_printf+0x524>
40004048: 93407d08     	sxtw	x8, w8
4000404c: 5280060a     	mov	w10, #0x30              // =48
40004050: 91000509     	add	x9, x8, #0x1
40004054: 38286b2a     	strb	w10, [x25, x8]
40004058: b90b86e9     	str	w9, [x23, #0xb84]
4000405c: 38296b3f     	strb	wzr, [x25, x9]
40004060: b94002a8     	ldr	w8, [x21]
40004064: 372fffe8     	tbnz	w8, #0x5, 0x40004060 <uart_printf+0x524>
40004068: 17fffeda     	b	0x40003bd0 <uart_printf+0x94>
4000406c: f9401fe8     	ldr	x8, [sp, #0x38]
40004070: 91002109     	add	x9, x8, #0x8
40004074: f9001fe9     	str	x9, [sp, #0x38]
40004078: b9400109     	ldr	w9, [x8]
4000407c: b4fffdc9     	cbz	x9, 0x40004034 <uart_printf+0x4f8>
40004080: aa1f03ea     	mov	x10, xzr
40004084: 9bcf7d28     	umulh	x8, x9, x15
40004088: f100253f     	cmp	x9, #0x9
4000408c: d343fd0b     	lsr	x11, x8, #3
40004090: 91000548     	add	x8, x10, #0x1
40004094: 1b10a56c     	msub	w12, w11, w16, w9
40004098: 321c0589     	orr	w9, w12, #0x30
4000409c: 382a6b89     	strb	w9, [x28, x10]
400040a0: aa0803ea     	mov	x10, x8
400040a4: aa0b03e9     	mov	x9, x11
400040a8: 54fffee8     	b.hi	0x40004084 <uart_printf+0x548>
400040ac: d1000509     	sub	x9, x8, #0x1
400040b0: b94b82cb     	ldr	w11, [x22, #0xb80]
400040b4: 38696b8a     	ldrb	w10, [x28, x9]
400040b8: 3400012b     	cbz	w11, 0x400040dc <uart_printf+0x5a0>
400040bc: b94b86eb     	ldr	w11, [x23, #0xb84]
400040c0: 6b18017f     	cmp	w11, w24
400040c4: 540000cc     	b.gt	0x400040dc <uart_printf+0x5a0>
400040c8: 93407d6b     	sxtw	x11, w11
400040cc: 9100056c     	add	x12, x11, #0x1
400040d0: 382b6b2a     	strb	w10, [x25, x11]
400040d4: b90b86ec     	str	w12, [x23, #0xb84]
400040d8: 382c6b3f     	strb	wzr, [x25, x12]
400040dc: b94002ab     	ldr	w11, [x21]
400040e0: 372fffeb     	tbnz	w11, #0x5, 0x400040dc <uart_printf+0x5a0>
400040e4: 7100051f     	cmp	w8, #0x1
400040e8: aa0903e8     	mov	x8, x9
400040ec: b900036a     	str	w10, [x27]
400040f0: 54fffdec     	b.gt	0x400040ac <uart_printf+0x570>
400040f4: 17fffeb9     	b	0x40003bd8 <uart_printf+0x9c>
400040f8: f9401fe8     	ldr	x8, [sp, #0x38]
400040fc: 91002109     	add	x9, x8, #0x8
40004100: f9001fe9     	str	x9, [sp, #0x38]
40004104: f9400108     	ldr	x8, [x8]
40004108: 14000005     	b	0x4000411c <uart_printf+0x5e0>
4000410c: f9401fe8     	ldr	x8, [sp, #0x38]
40004110: 91002109     	add	x9, x8, #0x8
40004114: f9001fe9     	str	x9, [sp, #0x38]
40004118: b9400108     	ldr	w8, [x8]
4000411c: 2a1f03e9     	mov	w9, wzr
40004120: 5280078a     	mov	w10, #0x3c              // =60
40004124: 14000003     	b	0x40004130 <uart_printf+0x5f4>
40004128: b4000daa     	cbz	x10, 0x400042dc <uart_printf+0x7a0>
4000412c: d100114a     	sub	x10, x10, #0x4
40004130: 9aca250b     	lsr	x11, x8, x10
40004134: f2400d6b     	ands	x11, x11, #0xf
40004138: fa400944     	ccmp	x10, #0x0, #0x4, eq
4000413c: 1a9f1529     	csinc	w9, w9, wzr, ne
40004140: 34ffff49     	cbz	w9, 0x40004128 <uart_printf+0x5ec>
40004144: b94b82cc     	ldr	w12, [x22, #0xb80]
40004148: 386b6a2b     	ldrb	w11, [x17, x11]
4000414c: 3400012c     	cbz	w12, 0x40004170 <uart_printf+0x634>
40004150: b94b86ec     	ldr	w12, [x23, #0xb84]
40004154: 6b18019f     	cmp	w12, w24
40004158: 540000cc     	b.gt	0x40004170 <uart_printf+0x634>
4000415c: 93407d8c     	sxtw	x12, w12
40004160: 9100058d     	add	x13, x12, #0x1
40004164: 382c6b2b     	strb	w11, [x25, x12]
40004168: b90b86ed     	str	w13, [x23, #0xb84]
4000416c: 382d6b3f     	strb	wzr, [x25, x13]
40004170: b94002ac     	ldr	w12, [x21]
40004174: 372fffec     	tbnz	w12, #0x5, 0x40004170 <uart_printf+0x634>
40004178: b900036b     	str	w11, [x27]
4000417c: b5fffd8a     	cbnz	x10, 0x4000412c <uart_printf+0x5f0>
40004180: 17fffe96     	b	0x40003bd8 <uart_printf+0x9c>
40004184: f9401fe8     	ldr	x8, [sp, #0x38]
40004188: 91002109     	add	x9, x8, #0x8
4000418c: f9001fe9     	str	x9, [sp, #0x38]
40004190: f9400108     	ldr	x8, [x8]
40004194: b6f80668     	tbz	x8, #0x3f, 0x40004260 <uart_printf+0x724>
40004198: b94b82c9     	ldr	w9, [x22, #0xb80]
4000419c: 34000149     	cbz	w9, 0x400041c4 <uart_printf+0x688>
400041a0: b94b86e9     	ldr	w9, [x23, #0xb84]
400041a4: 6b18013f     	cmp	w9, w24
400041a8: 540000ec     	b.gt	0x400041c4 <uart_printf+0x688>
400041ac: 93407d29     	sxtw	x9, w9
400041b0: 528005ab     	mov	w11, #0x2d              // =45
400041b4: 9100052a     	add	x10, x9, #0x1
400041b8: 38296b2b     	strb	w11, [x25, x9]
400041bc: b90b86ea     	str	w10, [x23, #0xb84]
400041c0: 382a6b3f     	strb	wzr, [x25, x10]
400041c4: b94002a9     	ldr	w9, [x21]
400041c8: 372fffe9     	tbnz	w9, #0x5, 0x400041c4 <uart_printf+0x688>
400041cc: aa1f03e9     	mov	x9, xzr
400041d0: 528005aa     	mov	w10, #0x2d              // =45
400041d4: cb0803e8     	neg	x8, x8
400041d8: b900036a     	str	w10, [x27]
400041dc: 9bcf7d0a     	umulh	x10, x8, x15
400041e0: f100251f     	cmp	x8, #0x9
400041e4: d343fd4a     	lsr	x10, x10, #3
400041e8: 1b10a14b     	msub	w11, w10, w16, w8
400041ec: 321c0568     	orr	w8, w11, #0x30
400041f0: 38296b88     	strb	w8, [x28, x9]
400041f4: 91000529     	add	x9, x9, #0x1
400041f8: aa0a03e8     	mov	x8, x10
400041fc: 54ffff08     	b.hi	0x400041dc <uart_printf+0x6a0>
40004200: d1000528     	sub	x8, x9, #0x1
40004204: b94b82cb     	ldr	w11, [x22, #0xb80]
40004208: 38686b8a     	ldrb	w10, [x28, x8]
4000420c: 3400012b     	cbz	w11, 0x40004230 <uart_printf+0x6f4>
40004210: b94b86eb     	ldr	w11, [x23, #0xb84]
40004214: 6b18017f     	cmp	w11, w24
40004218: 540000cc     	b.gt	0x40004230 <uart_printf+0x6f4>
4000421c: 93407d6b     	sxtw	x11, w11
40004220: 9100056c     	add	x12, x11, #0x1
40004224: 382b6b2a     	strb	w10, [x25, x11]
40004228: b90b86ec     	str	w12, [x23, #0xb84]
4000422c: 382c6b3f     	strb	wzr, [x25, x12]
40004230: b94002ab     	ldr	w11, [x21]
40004234: 372fffeb     	tbnz	w11, #0x5, 0x40004230 <uart_printf+0x6f4>
40004238: 7100053f     	cmp	w9, #0x1
4000423c: aa0803e9     	mov	x9, x8
40004240: b900036a     	str	w10, [x27]
40004244: 54fffdec     	b.gt	0x40004200 <uart_printf+0x6c4>
40004248: 17fffe64     	b	0x40003bd8 <uart_printf+0x9c>
4000424c: f9401fe8     	ldr	x8, [sp, #0x38]
40004250: 91002109     	add	x9, x8, #0x8
40004254: f9001fe9     	str	x9, [sp, #0x38]
40004258: b9800108     	ldrsw	x8, [x8]
4000425c: b7fff9e8     	tbnz	x8, #0x3f, 0x40004198 <uart_printf+0x65c>
40004260: b40005a8     	cbz	x8, 0x40004314 <uart_printf+0x7d8>
40004264: aa1f03ea     	mov	x10, xzr
40004268: 9bcf7d09     	umulh	x9, x8, x15
4000426c: f100251f     	cmp	x8, #0x9
40004270: d343fd2b     	lsr	x11, x9, #3
40004274: 91000549     	add	x9, x10, #0x1
40004278: 1b10a16c     	msub	w12, w11, w16, w8
4000427c: 321c0588     	orr	w8, w12, #0x30
40004280: 382a6b88     	strb	w8, [x28, x10]
40004284: aa0903ea     	mov	x10, x9
40004288: aa0b03e8     	mov	x8, x11
4000428c: 54fffee8     	b.hi	0x40004268 <uart_printf+0x72c>
40004290: d1000528     	sub	x8, x9, #0x1
40004294: b94b82cb     	ldr	w11, [x22, #0xb80]
40004298: 38686b8a     	ldrb	w10, [x28, x8]
4000429c: 3400012b     	cbz	w11, 0x400042c0 <uart_printf+0x784>
400042a0: b94b86eb     	ldr	w11, [x23, #0xb84]
400042a4: 6b18017f     	cmp	w11, w24
400042a8: 540000cc     	b.gt	0x400042c0 <uart_printf+0x784>
400042ac: 93407d6b     	sxtw	x11, w11
400042b0: 9100056c     	add	x12, x11, #0x1
400042b4: 382b6b2a     	strb	w10, [x25, x11]
400042b8: b90b86ec     	str	w12, [x23, #0xb84]
400042bc: 382c6b3f     	strb	wzr, [x25, x12]
400042c0: b94002ab     	ldr	w11, [x21]
400042c4: 372fffeb     	tbnz	w11, #0x5, 0x400042c0 <uart_printf+0x784>
400042c8: 7100053f     	cmp	w9, #0x1
400042cc: aa0803e9     	mov	x9, x8
400042d0: b900036a     	str	w10, [x27]
400042d4: 54fffdec     	b.gt	0x40004290 <uart_printf+0x754>
400042d8: 17fffe40     	b	0x40003bd8 <uart_printf+0x9c>
400042dc: b94b82c8     	ldr	w8, [x22, #0xb80]
400042e0: 34000148     	cbz	w8, 0x40004308 <uart_printf+0x7cc>
400042e4: b94b86e8     	ldr	w8, [x23, #0xb84]
400042e8: 6b18011f     	cmp	w8, w24
400042ec: 540000ec     	b.gt	0x40004308 <uart_printf+0x7cc>
400042f0: 93407d08     	sxtw	x8, w8
400042f4: 5280060a     	mov	w10, #0x30              // =48
400042f8: 91000509     	add	x9, x8, #0x1
400042fc: 38286b2a     	strb	w10, [x25, x8]
40004300: b90b86e9     	str	w9, [x23, #0xb84]
40004304: 38296b3f     	strb	wzr, [x25, x9]
40004308: b94002a8     	ldr	w8, [x21]
4000430c: 372fffe8     	tbnz	w8, #0x5, 0x40004308 <uart_printf+0x7cc>
40004310: 17fffe30     	b	0x40003bd0 <uart_printf+0x94>
40004314: b94b82c8     	ldr	w8, [x22, #0xb80]
40004318: 34000148     	cbz	w8, 0x40004340 <uart_printf+0x804>
4000431c: b94b86e8     	ldr	w8, [x23, #0xb84]
40004320: 6b18011f     	cmp	w8, w24
40004324: 540000ec     	b.gt	0x40004340 <uart_printf+0x804>
40004328: 93407d08     	sxtw	x8, w8
4000432c: 5280060a     	mov	w10, #0x30              // =48
40004330: 91000509     	add	x9, x8, #0x1
40004334: 38286b2a     	strb	w10, [x25, x8]
40004338: b90b86e9     	str	w9, [x23, #0xb84]
4000433c: 38296b3f     	strb	wzr, [x25, x9]
40004340: b94002a8     	ldr	w8, [x21]
40004344: 372fffe8     	tbnz	w8, #0x5, 0x40004340 <uart_printf+0x804>
40004348: 17fffe22     	b	0x40003bd0 <uart_printf+0x94>
4000434c: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004350: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004354: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004358: a94967fa     	ldp	x26, x25, [sp, #0x90]
4000435c: a9486ffc     	ldp	x28, x27, [sp, #0x80]
40004360: a9477bfd     	ldp	x29, x30, [sp, #0x70]
40004364: 910343ff     	add	sp, sp, #0xd0
40004368: d65f03c0     	ret

000000004000436c <vfs_init>:
4000436c: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004370: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004374: b0000093     	adrp	x19, 0x40015000 <kernel_capture_buffer+0x3478>
40004378: 912e8273     	add	x19, x19, #0xba0
4000437c: f9000bf9     	str	x25, [sp, #0x10]
40004380: b0000099     	adrp	x25, 0x40015000 <kernel_capture_buffer+0x3478>
40004384: 52800034     	mov	w20, #0x1               // =1
40004388: aa1303e0     	mov	x0, x19
4000438c: 2a1f03e1     	mov	w1, wzr
40004390: 52809802     	mov	w2, #0x4c0              // =1216
40004394: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004398: 910003fd     	mov	x29, sp
4000439c: a90357f6     	stp	x22, x21, [sp, #0x30]
400043a0: b90b8b34     	str	w20, [x25, #0xb88]
400043a4: 97fff981     	bl	0x400029a8 <memset>
400043a8: 528005e8     	mov	w8, #0x2f               // =47
400043ac: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
400043b0: b9002274     	str	w20, [x19, #0x20]
400043b4: 79000268     	strh	w8, [x19]
400043b8: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400043bc: f905c933     	str	x19, [x9, #0xb90]
400043c0: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
400043c4: 7101fd1f     	cmp	w8, #0x7f
400043c8: f9021a7f     	str	xzr, [x19, #0x430]
400043cc: f900167f     	str	xzr, [x19, #0x28]
400043d0: b904ba7f     	str	wzr, [x19, #0x4b8]
400043d4: f905cd33     	str	x19, [x9, #0xb98]
400043d8: 540028ac     	b.gt	0x400048ec <vfs_init+0x580>
400043dc: 52809809     	mov	w9, #0x4c0              // =1216
400043e0: 2a1f03e1     	mov	w1, wzr
400043e4: 52809802     	mov	w2, #0x4c0              // =1216
400043e8: 9b294d17     	smaddl	x23, w8, w9, x19
400043ec: 11000508     	add	w8, w8, #0x1
400043f0: b90b8b28     	str	w8, [x25, #0xb88]
400043f4: aa1703e0     	mov	x0, x23
400043f8: 97fff96c     	bl	0x400029a8 <memset>
400043fc: 528d2c48     	mov	w8, #0x6962             // =26978
40004400: b904baff     	str	wzr, [x23, #0x4b8]
40004404: 72a00dc8     	movk	w8, #0x6e, lsl #16
40004408: b90022f4     	str	w20, [x23, #0x20]
4000440c: b90002e8     	str	w8, [x23]
40004410: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004414: f9021af3     	str	x19, [x23, #0x430]
40004418: 71003d1f     	cmp	w8, #0xf
4000441c: f90016ff     	str	xzr, [x23, #0x28]
40004420: 540000ac     	b.gt	0x40004434 <vfs_init+0xc8>
40004424: 11000509     	add	w9, w8, #0x1
40004428: 8b080e68     	add	x8, x19, x8, lsl #3
4000442c: b904ba69     	str	w9, [x19, #0x4b8]
40004430: f9021d17     	str	x23, [x8, #0x438]
40004434: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004438: 7101fd1f     	cmp	w8, #0x7f
4000443c: 5400258c     	b.gt	0x400048ec <vfs_init+0x580>
40004440: 52809809     	mov	w9, #0x4c0              // =1216
40004444: 2a1f03e1     	mov	w1, wzr
40004448: 52809802     	mov	w2, #0x4c0              // =1216
4000444c: 9b294d16     	smaddl	x22, w8, w9, x19
40004450: 11000508     	add	w8, w8, #0x1
40004454: b90b8b28     	str	w8, [x25, #0xb88]
40004458: aa1603e0     	mov	x0, x22
4000445c: 97fff953     	bl	0x400029a8 <memset>
40004460: 528e8ca8     	mov	w8, #0x7465             // =29797
40004464: b904badf     	str	wzr, [x22, #0x4b8]
40004468: 52800029     	mov	w9, #0x1                // =1
4000446c: 72a00c68     	movk	w8, #0x63, lsl #16
40004470: b90022c9     	str	w9, [x22, #0x20]
40004474: b90002c8     	str	w8, [x22]
40004478: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000447c: f9021ad3     	str	x19, [x22, #0x430]
40004480: 71003d1f     	cmp	w8, #0xf
40004484: f90016df     	str	xzr, [x22, #0x28]
40004488: 540000ac     	b.gt	0x4000449c <vfs_init+0x130>
4000448c: 11000509     	add	w9, w8, #0x1
40004490: 8b080e68     	add	x8, x19, x8, lsl #3
40004494: b904ba69     	str	w9, [x19, #0x4b8]
40004498: f9021d16     	str	x22, [x8, #0x438]
4000449c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400044a0: 7101fd1f     	cmp	w8, #0x7f
400044a4: 5400224c     	b.gt	0x400048ec <vfs_init+0x580>
400044a8: 52809809     	mov	w9, #0x4c0              // =1216
400044ac: 2a1f03e1     	mov	w1, wzr
400044b0: 52809802     	mov	w2, #0x4c0              // =1216
400044b4: 9b294d14     	smaddl	x20, w8, w9, x19
400044b8: 11000508     	add	w8, w8, #0x1
400044bc: b90b8b28     	str	w8, [x25, #0xb88]
400044c0: aa1403e0     	mov	x0, x20
400044c4: 97fff939     	bl	0x400029a8 <memset>
400044c8: 528ded08     	mov	w8, #0x6f68             // =28520
400044cc: b904ba9f     	str	wzr, [x20, #0x4b8]
400044d0: 52800029     	mov	w9, #0x1                // =1
400044d4: 72acada8     	movk	w8, #0x656d, lsl #16
400044d8: 3900129f     	strb	wzr, [x20, #0x4]
400044dc: b9000288     	str	w8, [x20]
400044e0: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400044e4: b9002289     	str	w9, [x20, #0x20]
400044e8: 71003d1f     	cmp	w8, #0xf
400044ec: f9021a93     	str	x19, [x20, #0x430]
400044f0: f900169f     	str	xzr, [x20, #0x28]
400044f4: 540000ac     	b.gt	0x40004508 <vfs_init+0x19c>
400044f8: 11000509     	add	w9, w8, #0x1
400044fc: 8b080e68     	add	x8, x19, x8, lsl #3
40004500: b904ba69     	str	w9, [x19, #0x4b8]
40004504: f9021d14     	str	x20, [x8, #0x438]
40004508: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000450c: 7101fd1f     	cmp	w8, #0x7f
40004510: 54001eec     	b.gt	0x400048ec <vfs_init+0x580>
40004514: 52809809     	mov	w9, #0x4c0              // =1216
40004518: 2a1f03e1     	mov	w1, wzr
4000451c: 52809802     	mov	w2, #0x4c0              // =1216
40004520: 9b294d15     	smaddl	x21, w8, w9, x19
40004524: 11000508     	add	w8, w8, #0x1
40004528: b90b8b28     	str	w8, [x25, #0xb88]
4000452c: aa1503e0     	mov	x0, x21
40004530: 97fff91e     	bl	0x400029a8 <memset>
40004534: 528dec88     	mov	w8, #0x6f64             // =28516
40004538: b904babf     	str	wzr, [x21, #0x4b8]
4000453c: 52800029     	mov	w9, #0x1                // =1
40004540: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004544: 390012bf     	strb	wzr, [x21, #0x4]
40004548: b90002a8     	str	w8, [x21]
4000454c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004550: b90022a9     	str	w9, [x21, #0x20]
40004554: 71003d1f     	cmp	w8, #0xf
40004558: f9021ab3     	str	x19, [x21, #0x430]
4000455c: f90016bf     	str	xzr, [x21, #0x28]
40004560: 540000ac     	b.gt	0x40004574 <vfs_init+0x208>
40004564: 11000509     	add	w9, w8, #0x1
40004568: 8b080e68     	add	x8, x19, x8, lsl #3
4000456c: b904ba69     	str	w9, [x19, #0x4b8]
40004570: f9021d15     	str	x21, [x8, #0x438]
40004574: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004578: 7101fd1f     	cmp	w8, #0x7f
4000457c: 54001b8c     	b.gt	0x400048ec <vfs_init+0x580>
40004580: 52809809     	mov	w9, #0x4c0              // =1216
40004584: 2a1f03e1     	mov	w1, wzr
40004588: 52809802     	mov	w2, #0x4c0              // =1216
4000458c: 9b294d18     	smaddl	x24, w8, w9, x19
40004590: 11000508     	add	w8, w8, #0x1
40004594: b90b8b28     	str	w8, [x25, #0xb88]
40004598: aa1803e0     	mov	x0, x24
4000459c: 97fff903     	bl	0x400029a8 <memset>
400045a0: 528d2c28     	mov	w8, #0x6961             // =26977
400045a4: b904bb1f     	str	wzr, [x24, #0x4b8]
400045a8: 79000308     	strh	w8, [x24]
400045ac: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400045b0: 39000b1f     	strb	wzr, [x24, #0x2]
400045b4: 71003d1f     	cmp	w8, #0xf
400045b8: b900231f     	str	wzr, [x24, #0x20]
400045bc: f9021b17     	str	x23, [x24, #0x430]
400045c0: f900171f     	str	xzr, [x24, #0x28]
400045c4: 540000ac     	b.gt	0x400045d8 <vfs_init+0x26c>
400045c8: 8b080ee9     	add	x9, x23, x8, lsl #3
400045cc: 11000508     	add	w8, w8, #0x1
400045d0: b904bae8     	str	w8, [x23, #0x4b8]
400045d4: f9021d38     	str	x24, [x9, #0x438]
400045d8: d503201f     	nop
400045dc: 30039477     	adr	x23, 0x4000b869 <__rodata_start+0x2869>
400045e0: 9100c300     	add	x0, x24, #0x30
400045e4: aa1703e1     	mov	x1, x23
400045e8: 97fff8c4     	bl	0x400028f8 <kstrcpy>
400045ec: aa1703e0     	mov	x0, x23
400045f0: 97fff893     	bl	0x4000283c <kstrlen>
400045f4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045f8: f9001700     	str	x0, [x24, #0x28]
400045fc: 7101fd1f     	cmp	w8, #0x7f
40004600: 5400176c     	b.gt	0x400048ec <vfs_init+0x580>
40004604: 52809809     	mov	w9, #0x4c0              // =1216
40004608: 2a1f03e1     	mov	w1, wzr
4000460c: 52809802     	mov	w2, #0x4c0              // =1216
40004610: 9b294d17     	smaddl	x23, w8, w9, x19
40004614: 11000508     	add	w8, w8, #0x1
40004618: b90b8b28     	str	w8, [x25, #0xb88]
4000461c: aa1703e0     	mov	x0, x23
40004620: 97fff8e2     	bl	0x400029a8 <memset>
40004624: d28e6de8     	mov	x8, #0x736f             // =29551
40004628: b904baff     	str	wzr, [x23, #0x4b8]
4000462c: 528cae69     	mov	w9, #0x6573             // =25971
40004630: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004634: 790012e9     	strh	w9, [x23, #0x8]
40004638: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
4000463c: 39002aff     	strb	wzr, [x23, #0xa]
40004640: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004644: b90022ff     	str	wzr, [x23, #0x20]
40004648: f90002e8     	str	x8, [x23]
4000464c: b984bac8     	ldrsw	x8, [x22, #0x4b8]
40004650: f9021af6     	str	x22, [x23, #0x430]
40004654: 71003d1f     	cmp	w8, #0xf
40004658: f90016ff     	str	xzr, [x23, #0x28]
4000465c: 540000ac     	b.gt	0x40004670 <vfs_init+0x304>
40004660: 8b080ec9     	add	x9, x22, x8, lsl #3
40004664: 11000508     	add	w8, w8, #0x1
40004668: b904bac8     	str	w8, [x22, #0x4b8]
4000466c: f9021d37     	str	x23, [x9, #0x438]
40004670: b0000036     	adrp	x22, 0x40009000 <__rodata_start>
40004674: 9139ead6     	add	x22, x22, #0xe7a
40004678: 9100c2e0     	add	x0, x23, #0x30
4000467c: aa1603e1     	mov	x1, x22
40004680: 97fff89e     	bl	0x400028f8 <kstrcpy>
40004684: aa1603e0     	mov	x0, x22
40004688: 97fff86d     	bl	0x4000283c <kstrlen>
4000468c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004690: f90016e0     	str	x0, [x23, #0x28]
40004694: 7101fd1f     	cmp	w8, #0x7f
40004698: 540012ac     	b.gt	0x400048ec <vfs_init+0x580>
4000469c: 52809809     	mov	w9, #0x4c0              // =1216
400046a0: 2a1f03e1     	mov	w1, wzr
400046a4: 52809802     	mov	w2, #0x4c0              // =1216
400046a8: 9b294d16     	smaddl	x22, w8, w9, x19
400046ac: 11000508     	add	w8, w8, #0x1
400046b0: b90b8b28     	str	w8, [x25, #0xb88]
400046b4: aa1603e0     	mov	x0, x22
400046b8: 97fff8bc     	bl	0x400029a8 <memset>
400046bc: d28caee8     	mov	x8, #0x6577             // =25975
400046c0: b904badf     	str	wzr, [x22, #0x4b8]
400046c4: 528f0e89     	mov	w9, #0x7874             // =30836
400046c8: f2ac6d88     	movk	x8, #0x636c, lsl #16
400046cc: 72a00e89     	movk	w9, #0x74, lsl #16
400046d0: b90022df     	str	wzr, [x22, #0x20]
400046d4: f2cdade8     	movk	x8, #0x6d6f, lsl #32
400046d8: b9000ac9     	str	w9, [x22, #0x8]
400046dc: f2e5cca8     	movk	x8, #0x2e65, lsl #48
400046e0: f9021ad5     	str	x21, [x22, #0x430]
400046e4: f90002c8     	str	x8, [x22]
400046e8: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400046ec: f90016df     	str	xzr, [x22, #0x28]
400046f0: 71003d1f     	cmp	w8, #0xf
400046f4: 540000ac     	b.gt	0x40004708 <vfs_init+0x39c>
400046f8: 8b080ea9     	add	x9, x21, x8, lsl #3
400046fc: 11000508     	add	w8, w8, #0x1
40004700: b904baa8     	str	w8, [x21, #0x4b8]
40004704: f9021d36     	str	x22, [x9, #0x438]
40004708: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
4000470c: 91007ef7     	add	x23, x23, #0x1f
40004710: 9100c2c0     	add	x0, x22, #0x30
40004714: aa1703e1     	mov	x1, x23
40004718: 97fff878     	bl	0x400028f8 <kstrcpy>
4000471c: aa1703e0     	mov	x0, x23
40004720: 97fff847     	bl	0x4000283c <kstrlen>
40004724: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004728: f90016c0     	str	x0, [x22, #0x28]
4000472c: 7101fd1f     	cmp	w8, #0x7f
40004730: 54000dec     	b.gt	0x400048ec <vfs_init+0x580>
40004734: 52809809     	mov	w9, #0x4c0              // =1216
40004738: 2a1f03e1     	mov	w1, wzr
4000473c: 52809802     	mov	w2, #0x4c0              // =1216
40004740: 9b294d16     	smaddl	x22, w8, w9, x19
40004744: 11000508     	add	w8, w8, #0x1
40004748: b90b8b28     	str	w8, [x25, #0xb88]
4000474c: aa1603e0     	mov	x0, x22
40004750: 97fff896     	bl	0x400029a8 <memset>
40004754: d28c2d08     	mov	x8, #0x6168             // =24936
40004758: b904badf     	str	wzr, [x22, #0x4b8]
4000475c: 528e85c9     	mov	w9, #0x742e             // =29742
40004760: f2ac8e48     	movk	x8, #0x6472, lsl #16
40004764: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004768: 390032df     	strb	wzr, [x22, #0xc]
4000476c: f2cc2ee8     	movk	x8, #0x6177, lsl #32
40004770: b9000ac9     	str	w9, [x22, #0x8]
40004774: f2ecae48     	movk	x8, #0x6572, lsl #48
40004778: b90022df     	str	wzr, [x22, #0x20]
4000477c: f90002c8     	str	x8, [x22]
40004780: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004784: f9021ad5     	str	x21, [x22, #0x430]
40004788: 71003d1f     	cmp	w8, #0xf
4000478c: f90016df     	str	xzr, [x22, #0x28]
40004790: 540000ac     	b.gt	0x400047a4 <vfs_init+0x438>
40004794: 8b080ea9     	add	x9, x21, x8, lsl #3
40004798: 11000508     	add	w8, w8, #0x1
4000479c: b904baa8     	str	w8, [x21, #0x4b8]
400047a0: f9021d36     	str	x22, [x9, #0x438]
400047a4: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
400047a8: 910f62f7     	add	x23, x23, #0x3d8
400047ac: 9100c2c0     	add	x0, x22, #0x30
400047b0: aa1703e1     	mov	x1, x23
400047b4: 97fff851     	bl	0x400028f8 <kstrcpy>
400047b8: aa1703e0     	mov	x0, x23
400047bc: 97fff820     	bl	0x4000283c <kstrlen>
400047c0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047c4: f90016c0     	str	x0, [x22, #0x28]
400047c8: 7101fd1f     	cmp	w8, #0x7f
400047cc: 5400090c     	b.gt	0x400048ec <vfs_init+0x580>
400047d0: 52809809     	mov	w9, #0x4c0              // =1216
400047d4: 2a1f03e1     	mov	w1, wzr
400047d8: 52809802     	mov	w2, #0x4c0              // =1216
400047dc: 9b294d16     	smaddl	x22, w8, w9, x19
400047e0: 11000508     	add	w8, w8, #0x1
400047e4: b90b8b28     	str	w8, [x25, #0xb88]
400047e8: aa1603e0     	mov	x0, x22
400047ec: 97fff86f     	bl	0x400029a8 <memset>
400047f0: 528d2c28     	mov	w8, #0x6961             // =26977
400047f4: b904badf     	str	wzr, [x22, #0x4b8]
400047f8: 528e8f09     	mov	w9, #0x7478             // =29816
400047fc: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004800: 79000ac9     	strh	w9, [x22, #0x4]
40004804: b90002c8     	str	w8, [x22]
40004808: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000480c: 39001adf     	strb	wzr, [x22, #0x6]
40004810: 71003d1f     	cmp	w8, #0xf
40004814: b90022df     	str	wzr, [x22, #0x20]
40004818: f9021ad5     	str	x21, [x22, #0x430]
4000481c: f90016df     	str	xzr, [x22, #0x28]
40004820: 540000ac     	b.gt	0x40004834 <vfs_init+0x4c8>
40004824: 8b080ea9     	add	x9, x21, x8, lsl #3
40004828: 11000508     	add	w8, w8, #0x1
4000482c: b904baa8     	str	w8, [x21, #0x4b8]
40004830: f9021d36     	str	x22, [x9, #0x438]
40004834: f0000035     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
40004838: 9115c6b5     	add	x21, x21, #0x571
4000483c: 9100c2c0     	add	x0, x22, #0x30
40004840: aa1503e1     	mov	x1, x21
40004844: 97fff82d     	bl	0x400028f8 <kstrcpy>
40004848: aa1503e0     	mov	x0, x21
4000484c: 97fff7fc     	bl	0x4000283c <kstrlen>
40004850: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004854: f90016c0     	str	x0, [x22, #0x28]
40004858: 7101fd1f     	cmp	w8, #0x7f
4000485c: 5400048c     	b.gt	0x400048ec <vfs_init+0x580>
40004860: 52809809     	mov	w9, #0x4c0              // =1216
40004864: 2a1f03e1     	mov	w1, wzr
40004868: 52809802     	mov	w2, #0x4c0              // =1216
4000486c: 9b294d13     	smaddl	x19, w8, w9, x19
40004870: 11000508     	add	w8, w8, #0x1
40004874: b90b8b28     	str	w8, [x25, #0xb88]
40004878: aa1303e0     	mov	x0, x19
4000487c: 97fff84b     	bl	0x400029a8 <memset>
40004880: d28cae48     	mov	x8, #0x6572             // =25970
40004884: b904ba7f     	str	wzr, [x19, #0x4b8]
40004888: 528e8f09     	mov	w9, #0x7478             // =29816
4000488c: f2ac8c28     	movk	x8, #0x6461, lsl #16
40004890: 79001269     	strh	w9, [x19, #0x8]
40004894: f2ccada8     	movk	x8, #0x656d, lsl #32
40004898: 39002a7f     	strb	wzr, [x19, #0xa]
4000489c: f2ee85c8     	movk	x8, #0x742e, lsl #48
400048a0: b900227f     	str	wzr, [x19, #0x20]
400048a4: f9000268     	str	x8, [x19]
400048a8: b984ba88     	ldrsw	x8, [x20, #0x4b8]
400048ac: f9021a74     	str	x20, [x19, #0x430]
400048b0: 71003d1f     	cmp	w8, #0xf
400048b4: f900167f     	str	xzr, [x19, #0x28]
400048b8: 540000ac     	b.gt	0x400048cc <vfs_init+0x560>
400048bc: 8b080e89     	add	x9, x20, x8, lsl #3
400048c0: 11000508     	add	w8, w8, #0x1
400048c4: b904ba88     	str	w8, [x20, #0x4b8]
400048c8: f9021d33     	str	x19, [x9, #0x438]
400048cc: b0000034     	adrp	x20, 0x40009000 <__rodata_start>
400048d0: 910e5e94     	add	x20, x20, #0x397
400048d4: 9100c260     	add	x0, x19, #0x30
400048d8: aa1403e1     	mov	x1, x20
400048dc: 97fff807     	bl	0x400028f8 <kstrcpy>
400048e0: aa1403e0     	mov	x0, x20
400048e4: 97fff7d6     	bl	0x4000283c <kstrlen>
400048e8: f9001660     	str	x0, [x19, #0x28]
400048ec: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400048f0: f9400bf9     	ldr	x25, [sp, #0x10]
400048f4: a94357f6     	ldp	x22, x21, [sp, #0x30]
400048f8: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400048fc: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004900: d65f03c0     	ret

0000000040004904 <vfs_get_root>:
40004904: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004908: f945c900     	ldr	x0, [x8, #0xb90]
4000490c: d65f03c0     	ret

0000000040004910 <vfs_get_cwd>:
40004910: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004914: f945cd00     	ldr	x0, [x8, #0xb98]
40004918: d65f03c0     	ret

000000004000491c <vfs_getcwd>:
4000491c: d10343ff     	sub	sp, sp, #0xd0
40004920: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004924: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004928: aa0003f3     	mov	x19, x0
4000492c: f945cd08     	ldr	x8, [x8, #0xb98]
40004930: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004934: 910203fd     	add	x29, sp, #0x80
40004938: a90967fa     	stp	x26, x25, [sp, #0x90]
4000493c: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40004940: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004944: b4000228     	cbz	x8, 0x40004988 <vfs_getcwd+0x6c>
40004948: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
4000494c: f945c929     	ldr	x9, [x9, #0xb90]
40004950: eb09011f     	cmp	x8, x9
40004954: 540001a0     	b.eq	0x40004988 <vfs_getcwd+0x6c>
40004958: aa1f03ea     	mov	x10, xzr
4000495c: 910003eb     	mov	x11, sp
40004960: eb09011f     	cmp	x8, x9
40004964: 540001e0     	b.eq	0x400049a0 <vfs_getcwd+0x84>
40004968: f1003d5f     	cmp	x10, #0xf
4000496c: 540001a8     	b.hi	0x400049a0 <vfs_getcwd+0x84>
40004970: f82a7968     	str	x8, [x11, x10, lsl #3]
40004974: f9421908     	ldr	x8, [x8, #0x430]
40004978: 9100054c     	add	x12, x10, #0x1
4000497c: aa0c03ea     	mov	x10, x12
40004980: b5ffff08     	cbnz	x8, 0x40004960 <vfs_getcwd+0x44>
40004984: 14000008     	b	0x400049a4 <vfs_getcwd+0x88>
40004988: f100083f     	cmp	x1, #0x2
4000498c: 54000583     	b.lo	0x40004a3c <vfs_getcwd+0x120>
40004990: 528005e8     	mov	w8, #0x2f               // =47
40004994: 3900067f     	strb	wzr, [x19, #0x1]
40004998: 39000268     	strb	w8, [x19]
4000499c: 14000028     	b	0x40004a3c <vfs_getcwd+0x120>
400049a0: aa0a03ec     	mov	x12, x10
400049a4: 7100059f     	cmp	w12, #0x1
400049a8: 3900027f     	strb	wzr, [x19]
400049ac: 5400048b     	b.lt	0x40004a3c <vfs_getcwd+0x120>
400049b0: aa1f03f6     	mov	x22, xzr
400049b4: d1000435     	sub	x21, x1, #0x1
400049b8: 92407999     	and	x25, x12, #0x7fffffff
400049bc: 528005f7     	mov	w23, #0x2f              // =47
400049c0: 910003f8     	mov	x24, sp
400049c4: 14000005     	b	0x400049d8 <vfs_getcwd+0xbc>
400049c8: 8b0a02d6     	add	x22, x22, x10
400049cc: f100075f     	cmp	x26, #0x1
400049d0: 38366a7f     	strb	wzr, [x19, x22]
400049d4: 54000349     	b.ls	0x40004a3c <vfs_getcwd+0x120>
400049d8: eb1502df     	cmp	x22, x21
400049dc: aa1903fa     	mov	x26, x25
400049e0: 54000082     	b.hs	0x400049f0 <vfs_getcwd+0xd4>
400049e4: 38366a77     	strb	w23, [x19, x22]
400049e8: 910006d6     	add	x22, x22, #0x1
400049ec: 38366a7f     	strb	wzr, [x19, x22]
400049f0: d1000759     	sub	x25, x26, #0x1
400049f4: f8797b14     	ldr	x20, [x24, x25, lsl #3]
400049f8: aa1403e0     	mov	x0, x20
400049fc: 97fff790     	bl	0x4000283c <kstrlen>
40004a00: b4fffe60     	cbz	x0, 0x400049cc <vfs_getcwd+0xb0>
40004a04: eb1502df     	cmp	x22, x21
40004a08: 54fffe22     	b.hs	0x400049cc <vfs_getcwd+0xb0>
40004a0c: aa1f03e9     	mov	x9, xzr
40004a10: 8b160268     	add	x8, x19, x22
40004a14: 9100052a     	add	x10, x9, #0x1
40004a18: 38696a8b     	ldrb	w11, [x20, x9]
40004a1c: eb00015f     	cmp	x10, x0
40004a20: 3829690b     	strb	w11, [x8, x9]
40004a24: 54fffd22     	b.hs	0x400049c8 <vfs_getcwd+0xac>
40004a28: 8b160149     	add	x9, x10, x22
40004a2c: eb15013f     	cmp	x9, x21
40004a30: aa0a03e9     	mov	x9, x10
40004a34: 54ffff03     	b.lo	0x40004a14 <vfs_getcwd+0xf8>
40004a38: 17ffffe4     	b	0x400049c8 <vfs_getcwd+0xac>
40004a3c: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004a40: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004a44: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004a48: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004a4c: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004a50: 910343ff     	add	sp, sp, #0xd0
40004a54: d65f03c0     	ret

0000000040004a58 <vfs_find>:
40004a58: d10203ff     	sub	sp, sp, #0x80
40004a5c: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004a60: 910083fd     	add	x29, sp, #0x20
40004a64: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004a68: a90467fa     	stp	x26, x25, [sp, #0x40]
40004a6c: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004a70: a90657f6     	stp	x22, x21, [sp, #0x60]
40004a74: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004a78: b4000a60     	cbz	x0, 0x40004bc4 <vfs_find+0x16c>
40004a7c: 39400008     	ldrb	w8, [x0]
40004a80: aa0003f4     	mov	x20, x0
40004a84: 34000a08     	cbz	w8, 0x40004bc4 <vfs_find+0x16c>
40004a88: 7100bd1f     	cmp	w8, #0x2f
40004a8c: 54000121     	b.ne	0x40004ab0 <vfs_find+0x58>
40004a90: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a94: 52800037     	mov	w23, #0x1               // =1
40004a98: f945c913     	ldr	x19, [x8, #0xb90]
40004a9c: 38776a88     	ldrb	w8, [x20, x23]
40004aa0: 7100bd1f     	cmp	w8, #0x2f
40004aa4: 540000e1     	b.ne	0x40004ac0 <vfs_find+0x68>
40004aa8: 910006f7     	add	x23, x23, #0x1
40004aac: 17fffffc     	b	0x40004a9c <vfs_find+0x44>
40004ab0: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004ab4: aa1f03f7     	mov	x23, xzr
40004ab8: f945cd33     	ldr	x19, [x9, #0xb98]
40004abc: 14000002     	b	0x40004ac4 <vfs_find+0x6c>
40004ac0: 34000848     	cbz	w8, 0x40004bc8 <vfs_find+0x170>
40004ac4: 91000698     	add	x24, x20, #0x1
40004ac8: b0000035     	adrp	x21, 0x40009000 <__rodata_start>
40004acc: 91278eb5     	add	x21, x21, #0x9e3
40004ad0: 910003f9     	mov	x25, sp
40004ad4: d0000036     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
40004ad8: 910702d6     	add	x22, x22, #0x1c0
40004adc: 14000006     	b	0x40004af4 <vfs_find+0x9c>
40004ae0: f9421a68     	ldr	x8, [x19, #0x430]
40004ae4: f100011f     	cmp	x8, #0x0
40004ae8: 9a880273     	csel	x19, x19, x8, eq
40004aec: 385ff348     	ldurb	w8, [x26, #-0x1]
40004af0: 340006c8     	cbz	w8, 0x40004bc8 <vfs_find+0x170>
40004af4: 7100bd1f     	cmp	w8, #0x2f
40004af8: 54000061     	b.ne	0x40004b04 <vfs_find+0xac>
40004afc: aa1f03e9     	mov	x9, xzr
40004b00: 14000010     	b	0x40004b40 <vfs_find+0xe8>
40004b04: aa1f03e9     	mov	x9, xzr
40004b08: 8b17030a     	add	x10, x24, x23
40004b0c: 34000188     	cbz	w8, 0x40004b3c <vfs_find+0xe4>
40004b10: f100793f     	cmp	x9, #0x1e
40004b14: 54000148     	b.hi	0x40004b3c <vfs_find+0xe4>
40004b18: 38296b28     	strb	w8, [x25, x9]
40004b1c: 38696948     	ldrb	w8, [x10, x9]
40004b20: 9100052b     	add	x11, x9, #0x1
40004b24: aa0b03e9     	mov	x9, x11
40004b28: 7100bd1f     	cmp	w8, #0x2f
40004b2c: 54ffff01     	b.ne	0x40004b0c <vfs_find+0xb4>
40004b30: 8b0b02f7     	add	x23, x23, x11
40004b34: aa0b03e9     	mov	x9, x11
40004b38: 14000002     	b	0x40004b40 <vfs_find+0xe8>
40004b3c: 8b0902f7     	add	x23, x23, x9
40004b40: 8b17029a     	add	x26, x20, x23
40004b44: d10006f7     	sub	x23, x23, #0x1
40004b48: 38296b3f     	strb	wzr, [x25, x9]
40004b4c: 38401748     	ldrb	w8, [x26], #0x1
40004b50: 910006f7     	add	x23, x23, #0x1
40004b54: 7100bd1f     	cmp	w8, #0x2f
40004b58: 54ffffa0     	b.eq	0x40004b4c <vfs_find+0xf4>
40004b5c: 910003e0     	mov	x0, sp
40004b60: aa1503e1     	mov	x1, x21
40004b64: 97fff746     	bl	0x4000287c <kstrcmp>
40004b68: 34fffc20     	cbz	w0, 0x40004aec <vfs_find+0x94>
40004b6c: 910003e0     	mov	x0, sp
40004b70: aa1603e1     	mov	x1, x22
40004b74: 97fff742     	bl	0x4000287c <kstrcmp>
40004b78: 34fffb40     	cbz	w0, 0x40004ae0 <vfs_find+0x88>
40004b7c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b80: 7100051f     	cmp	w8, #0x1
40004b84: 5400020b     	b.lt	0x40004bc4 <vfs_find+0x16c>
40004b88: aa1f03fb     	mov	x27, xzr
40004b8c: 9110e27c     	add	x28, x19, #0x438
40004b90: 14000005     	b	0x40004ba4 <vfs_find+0x14c>
40004b94: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b98: 9100077b     	add	x27, x27, #0x1
40004b9c: eb28c37f     	cmp	x27, w8, sxtw
40004ba0: 5400012a     	b.ge	0x40004bc4 <vfs_find+0x16c>
40004ba4: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004ba8: b4ffff80     	cbz	x0, 0x40004b98 <vfs_find+0x140>
40004bac: 910003e1     	mov	x1, sp
40004bb0: 97fff733     	bl	0x4000287c <kstrcmp>
40004bb4: 35ffff00     	cbnz	w0, 0x40004b94 <vfs_find+0x13c>
40004bb8: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004bbc: b5fff993     	cbnz	x19, 0x40004aec <vfs_find+0x94>
40004bc0: 14000002     	b	0x40004bc8 <vfs_find+0x170>
40004bc4: aa1f03f3     	mov	x19, xzr
40004bc8: aa1303e0     	mov	x0, x19
40004bcc: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004bd0: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004bd4: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004bd8: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004bdc: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004be0: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004be4: 910203ff     	add	sp, sp, #0x80
40004be8: d65f03c0     	ret

0000000040004bec <vfs_chdir>:
40004bec: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004bf0: f9000bf3     	str	x19, [sp, #0x10]
40004bf4: 910003fd     	mov	x29, sp
40004bf8: b4000200     	cbz	x0, 0x40004c38 <vfs_chdir+0x4c>
40004bfc: 39400008     	ldrb	w8, [x0]
40004c00: 340001c8     	cbz	w8, 0x40004c38 <vfs_chdir+0x4c>
40004c04: f0000021     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40004c08: 91128021     	add	x1, x1, #0x4a0
40004c0c: aa0003f3     	mov	x19, x0
40004c10: 97fff71b     	bl	0x4000287c <kstrcmp>
40004c14: 34000120     	cbz	w0, 0x40004c38 <vfs_chdir+0x4c>
40004c18: aa1303e0     	mov	x0, x19
40004c1c: 97ffff8f     	bl	0x40004a58 <vfs_find>
40004c20: b40002c0     	cbz	x0, 0x40004c78 <vfs_chdir+0x8c>
40004c24: b9402008     	ldr	w8, [x0, #0x20]
40004c28: 7100051f     	cmp	w8, #0x1
40004c2c: 54000180     	b.eq	0x40004c5c <vfs_chdir+0x70>
40004c30: 12800028     	mov	w8, #-0x2               // =-2
40004c34: 1400000d     	b	0x40004c68 <vfs_chdir+0x7c>
40004c38: d0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40004c3c: 91025000     	add	x0, x0, #0x94
40004c40: 97ffff86     	bl	0x40004a58 <vfs_find>
40004c44: b4000080     	cbz	x0, 0x40004c54 <vfs_chdir+0x68>
40004c48: b9402008     	ldr	w8, [x0, #0x20]
40004c4c: 7100051f     	cmp	w8, #0x1
40004c50: 54000060     	b.eq	0x40004c5c <vfs_chdir+0x70>
40004c54: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004c58: f945c900     	ldr	x0, [x8, #0xb90]
40004c5c: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004c60: 2a1f03e8     	mov	w8, wzr
40004c64: f905cd20     	str	x0, [x9, #0xb98]
40004c68: f9400bf3     	ldr	x19, [sp, #0x10]
40004c6c: 2a0803e0     	mov	w0, w8
40004c70: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004c74: d65f03c0     	ret
40004c78: 12800008     	mov	w8, #-0x1               // =-1
40004c7c: 17fffffb     	b	0x40004c68 <vfs_chdir+0x7c>

0000000040004c80 <vfs_mkdir>:
40004c80: b40001e0     	cbz	x0, 0x40004cbc <vfs_mkdir+0x3c>
40004c84: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004c88: 39400008     	ldrb	w8, [x0]
40004c8c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004c90: aa0003f3     	mov	x19, x0
40004c94: a90157f6     	stp	x22, x21, [sp, #0x10]
40004c98: 910003fd     	mov	x29, sp
40004c9c: 34000148     	cbz	w8, 0x40004cc4 <vfs_mkdir+0x44>
40004ca0: b0000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
40004ca4: f945ce95     	ldr	x21, [x20, #0xb98]
40004ca8: b944baa8     	ldr	w8, [x21, #0x4b8]
40004cac: 71003d1f     	cmp	w8, #0xf
40004cb0: 540000ed     	b.le	0x40004ccc <vfs_mkdir+0x4c>
40004cb4: 12800020     	mov	w0, #-0x2               // =-2
40004cb8: 14000043     	b	0x40004dc4 <vfs_mkdir+0x144>
40004cbc: 12800000     	mov	w0, #-0x1               // =-1
40004cc0: d65f03c0     	ret
40004cc4: 12800000     	mov	w0, #-0x1               // =-1
40004cc8: 1400003f     	b	0x40004dc4 <vfs_mkdir+0x144>
40004ccc: 7100051f     	cmp	w8, #0x1
40004cd0: 540001eb     	b.lt	0x40004d0c <vfs_mkdir+0x8c>
40004cd4: aa1f03f6     	mov	x22, xzr
40004cd8: 14000005     	b	0x40004cec <vfs_mkdir+0x6c>
40004cdc: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004ce0: 910006d6     	add	x22, x22, #0x1
40004ce4: eb0802df     	cmp	x22, x8
40004ce8: 5400012a     	b.ge	0x40004d0c <vfs_mkdir+0x8c>
40004cec: 8b160ea8     	add	x8, x21, x22, lsl #3
40004cf0: f9421d00     	ldr	x0, [x8, #0x438]
40004cf4: b4ffff40     	cbz	x0, 0x40004cdc <vfs_mkdir+0x5c>
40004cf8: aa1303e1     	mov	x1, x19
40004cfc: 97fff6e0     	bl	0x4000287c <kstrcmp>
40004d00: 340003e0     	cbz	w0, 0x40004d7c <vfs_mkdir+0xfc>
40004d04: f945ce95     	ldr	x21, [x20, #0xb98]
40004d08: 17fffff5     	b	0x40004cdc <vfs_mkdir+0x5c>
40004d0c: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004d10: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004d14: 7101fd3f     	cmp	w9, #0x7f
40004d18: 5400006d     	b.le	0x40004d24 <vfs_mkdir+0xa4>
40004d1c: 12800060     	mov	w0, #-0x4               // =-4
40004d20: 14000029     	b	0x40004dc4 <vfs_mkdir+0x144>
40004d24: 5280980a     	mov	w10, #0x4c0             // =1216
40004d28: b000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40004d2c: 912e816b     	add	x11, x11, #0xba0
40004d30: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d34: 11000529     	add	w9, w9, #0x1
40004d38: 2a1f03e1     	mov	w1, wzr
40004d3c: 52809802     	mov	w2, #0x4c0              // =1216
40004d40: b90b8909     	str	w9, [x8, #0xb88]
40004d44: aa1403e0     	mov	x0, x20
40004d48: 97fff718     	bl	0x400029a8 <memset>
40004d4c: 39400268     	ldrb	w8, [x19]
40004d50: 340001a8     	cbz	w8, 0x40004d84 <vfs_mkdir+0x104>
40004d54: aa1f03ea     	mov	x10, xzr
40004d58: 91000669     	add	x9, x19, #0x1
40004d5c: 382a6a88     	strb	w8, [x20, x10]
40004d60: 9100054b     	add	x11, x10, #0x1
40004d64: 386a6928     	ldrb	w8, [x9, x10]
40004d68: 34000108     	cbz	w8, 0x40004d88 <vfs_mkdir+0x108>
40004d6c: f100795f     	cmp	x10, #0x1e
40004d70: aa0b03ea     	mov	x10, x11
40004d74: 54ffff43     	b.lo	0x40004d5c <vfs_mkdir+0xdc>
40004d78: 14000004     	b	0x40004d88 <vfs_mkdir+0x108>
40004d7c: 12800040     	mov	w0, #-0x3               // =-3
40004d80: 14000011     	b	0x40004dc4 <vfs_mkdir+0x144>
40004d84: aa1f03eb     	mov	x11, xzr
40004d88: 382b6a9f     	strb	wzr, [x20, x11]
40004d8c: 2a1f03e0     	mov	w0, wzr
40004d90: 52800029     	mov	w9, #0x1                // =1
40004d94: b904ba9f     	str	wzr, [x20, #0x4b8]
40004d98: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004d9c: b9002289     	str	w9, [x20, #0x20]
40004da0: f9021a95     	str	x21, [x20, #0x430]
40004da4: 71003d1f     	cmp	w8, #0xf
40004da8: f900169f     	str	xzr, [x20, #0x28]
40004dac: 540000cc     	b.gt	0x40004dc4 <vfs_mkdir+0x144>
40004db0: 8b080ea9     	add	x9, x21, x8, lsl #3
40004db4: 2a1f03e0     	mov	w0, wzr
40004db8: 11000508     	add	w8, w8, #0x1
40004dbc: b904baa8     	str	w8, [x21, #0x4b8]
40004dc0: f9021d34     	str	x20, [x9, #0x438]
40004dc4: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004dc8: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004dcc: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004dd0: d65f03c0     	ret

0000000040004dd4 <vfs_sync>:
40004dd4: d65f03c0     	ret

0000000040004dd8 <vfs_touch>:
40004dd8: b4000500     	cbz	x0, 0x40004e78 <vfs_touch+0xa0>
40004ddc: 39400008     	ldrb	w8, [x0]
40004de0: 340004c8     	cbz	w8, 0x40004e78 <vfs_touch+0xa0>
40004de4: d10583ff     	sub	sp, sp, #0x160
40004de8: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004dec: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004df0: aa1f03f4     	mov	x20, xzr
40004df4: f945cd33     	ldr	x19, [x9, #0xb98]
40004df8: aa0003e9     	mov	x9, x0
40004dfc: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004e00: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004e04: 910483fd     	add	x29, sp, #0x120
40004e08: a91457f6     	stp	x22, x21, [sp, #0x140]
40004e0c: 14000003     	b	0x40004e18 <vfs_touch+0x40>
40004e10: aa0903f4     	mov	x20, x9
40004e14: 38401d28     	ldrb	w8, [x9, #0x1]!
40004e18: 7100bd1f     	cmp	w8, #0x2f
40004e1c: 54ffffa0     	b.eq	0x40004e10 <vfs_touch+0x38>
40004e20: 35ffffa8     	cbnz	w8, 0x40004e14 <vfs_touch+0x3c>
40004e24: b4000334     	cbz	x20, 0x40004e88 <vfs_touch+0xb0>
40004e28: cb000288     	sub	x8, x20, x0
40004e2c: 52801fe9     	mov	w9, #0xff               // =255
40004e30: aa0103f5     	mov	x21, x1
40004e34: f103fd1f     	cmp	x8, #0xff
40004e38: aa0003e1     	mov	x1, x0
40004e3c: 910083e0     	add	x0, sp, #0x20
40004e40: 9a893113     	csel	x19, x8, x9, lo
40004e44: 910083f6     	add	x22, sp, #0x20
40004e48: aa1303e2     	mov	x2, x19
40004e4c: 97fff6b2     	bl	0x40002914 <kstrncpy>
40004e50: 910083e0     	add	x0, sp, #0x20
40004e54: 38336adf     	strb	wzr, [x22, x19]
40004e58: 97ffff00     	bl	0x40004a58 <vfs_find>
40004e5c: b4000120     	cbz	x0, 0x40004e80 <vfs_touch+0xa8>
40004e60: b9402008     	ldr	w8, [x0, #0x20]
40004e64: aa0003f3     	mov	x19, x0
40004e68: 7100051f     	cmp	w8, #0x1
40004e6c: 540000a1     	b.ne	0x40004e80 <vfs_touch+0xa8>
40004e70: 91000688     	add	x8, x20, #0x1
40004e74: 14000007     	b	0x40004e90 <vfs_touch+0xb8>
40004e78: 12800000     	mov	w0, #-0x1               // =-1
40004e7c: d65f03c0     	ret
40004e80: 12800000     	mov	w0, #-0x1               // =-1
40004e84: 1400006a     	b	0x4000502c <vfs_touch+0x254>
40004e88: aa0003e8     	mov	x8, x0
40004e8c: aa0103f5     	mov	x21, x1
40004e90: 910003e0     	mov	x0, sp
40004e94: aa0803e1     	mov	x1, x8
40004e98: 528003e2     	mov	w2, #0x1f               // =31
40004e9c: 97fff69e     	bl	0x40002914 <kstrncpy>
40004ea0: b944ba68     	ldr	w8, [x19, #0x4b8]
40004ea4: 39007fff     	strb	wzr, [sp, #0x1f]
40004ea8: 7100051f     	cmp	w8, #0x1
40004eac: 5400024b     	b.lt	0x40004ef4 <vfs_touch+0x11c>
40004eb0: aa1f03f6     	mov	x22, xzr
40004eb4: 9110e277     	add	x23, x19, #0x438
40004eb8: 14000004     	b	0x40004ec8 <vfs_touch+0xf0>
40004ebc: 910006d6     	add	x22, x22, #0x1
40004ec0: eb28c2df     	cmp	x22, w8, sxtw
40004ec4: 5400010a     	b.ge	0x40004ee4 <vfs_touch+0x10c>
40004ec8: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004ecc: b4ffff80     	cbz	x0, 0x40004ebc <vfs_touch+0xe4>
40004ed0: 910003e1     	mov	x1, sp
40004ed4: 97fff66a     	bl	0x4000287c <kstrcmp>
40004ed8: 340004a0     	cbz	w0, 0x40004f6c <vfs_touch+0x194>
40004edc: b944ba68     	ldr	w8, [x19, #0x4b8]
40004ee0: 17fffff7     	b	0x40004ebc <vfs_touch+0xe4>
40004ee4: 71003d1f     	cmp	w8, #0xf
40004ee8: 5400006d     	b.le	0x40004ef4 <vfs_touch+0x11c>
40004eec: 12800020     	mov	w0, #-0x2               // =-2
40004ef0: 1400004f     	b	0x4000502c <vfs_touch+0x254>
40004ef4: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004ef8: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004efc: 7101fd3f     	cmp	w9, #0x7f
40004f00: 5400006d     	b.le	0x40004f0c <vfs_touch+0x134>
40004f04: 12800060     	mov	w0, #-0x4               // =-4
40004f08: 14000049     	b	0x4000502c <vfs_touch+0x254>
40004f0c: 5280980a     	mov	w10, #0x4c0             // =1216
40004f10: b000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40004f14: 912e816b     	add	x11, x11, #0xba0
40004f18: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004f1c: 11000529     	add	w9, w9, #0x1
40004f20: 2a1f03e1     	mov	w1, wzr
40004f24: 52809802     	mov	w2, #0x4c0              // =1216
40004f28: b90b8909     	str	w9, [x8, #0xb88]
40004f2c: aa1403e0     	mov	x0, x20
40004f30: 97fff69e     	bl	0x400029a8 <memset>
40004f34: 394003e8     	ldrb	w8, [sp]
40004f38: 340003e8     	cbz	w8, 0x40004fb4 <vfs_touch+0x1dc>
40004f3c: 910003ea     	mov	x10, sp
40004f40: aa1f03e9     	mov	x9, xzr
40004f44: aa1503e0     	mov	x0, x21
40004f48: b240014a     	orr	x10, x10, #0x1
40004f4c: 38296a88     	strb	w8, [x20, x9]
40004f50: 38696948     	ldrb	w8, [x10, x9]
40004f54: 9100052b     	add	x11, x9, #0x1
40004f58: 34000328     	cbz	w8, 0x40004fbc <vfs_touch+0x1e4>
40004f5c: f100793f     	cmp	x9, #0x1e
40004f60: aa0b03e9     	mov	x9, x11
40004f64: 54ffff43     	b.lo	0x40004f4c <vfs_touch+0x174>
40004f68: 14000015     	b	0x40004fbc <vfs_touch+0x1e4>
40004f6c: b40005f5     	cbz	x21, 0x40005028 <vfs_touch+0x250>
40004f70: aa1503e0     	mov	x0, x21
40004f74: 97fff632     	bl	0x4000283c <kstrlen>
40004f78: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f7c: f10ffc1f     	cmp	x0, #0x3ff
40004f80: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f84: 9a883014     	csel	x20, x0, x8, lo
40004f88: aa1503e1     	mov	x1, x21
40004f8c: 9100c120     	add	x0, x9, #0x30
40004f90: aa1403e2     	mov	x2, x20
40004f94: 97fff69b     	bl	0x40002a00 <memcpy>
40004f98: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f9c: 2a1f03e0     	mov	w0, wzr
40004fa0: 8b140108     	add	x8, x8, x20
40004fa4: 3900c11f     	strb	wzr, [x8, #0x30]
40004fa8: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004fac: f9001514     	str	x20, [x8, #0x28]
40004fb0: 1400001f     	b	0x4000502c <vfs_touch+0x254>
40004fb4: aa1f03eb     	mov	x11, xzr
40004fb8: aa1503e0     	mov	x0, x21
40004fbc: 382b6a9f     	strb	wzr, [x20, x11]
40004fc0: b904ba9f     	str	wzr, [x20, #0x4b8]
40004fc4: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004fc8: b900229f     	str	wzr, [x20, #0x20]
40004fcc: f9021a93     	str	x19, [x20, #0x430]
40004fd0: 71003d1f     	cmp	w8, #0xf
40004fd4: f900169f     	str	xzr, [x20, #0x28]
40004fd8: 540000ac     	b.gt	0x40004fec <vfs_touch+0x214>
40004fdc: 8b080e69     	add	x9, x19, x8, lsl #3
40004fe0: 11000508     	add	w8, w8, #0x1
40004fe4: b904ba68     	str	w8, [x19, #0x4b8]
40004fe8: f9021d34     	str	x20, [x9, #0x438]
40004fec: b4000200     	cbz	x0, 0x4000502c <vfs_touch+0x254>
40004ff0: aa0003f3     	mov	x19, x0
40004ff4: 97fff612     	bl	0x4000283c <kstrlen>
40004ff8: 52807fe8     	mov	w8, #0x3ff              // =1023
40004ffc: f10ffc1f     	cmp	x0, #0x3ff
40005000: 9100c296     	add	x22, x20, #0x30
40005004: 9a883015     	csel	x21, x0, x8, lo
40005008: aa1603e0     	mov	x0, x22
4000500c: aa1303e1     	mov	x1, x19
40005010: aa1503e2     	mov	x2, x21
40005014: 97fff67b     	bl	0x40002a00 <memcpy>
40005018: 2a1f03e0     	mov	w0, wzr
4000501c: 38356adf     	strb	wzr, [x22, x21]
40005020: f9001695     	str	x21, [x20, #0x28]
40005024: 14000002     	b	0x4000502c <vfs_touch+0x254>
40005028: 2a1f03e0     	mov	w0, wzr
4000502c: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005030: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005034: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40005038: a9527bfd     	ldp	x29, x30, [sp, #0x120]
4000503c: 910583ff     	add	sp, sp, #0x160
40005040: d65f03c0     	ret

0000000040005044 <vfs_write_file>:
40005044: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005048: a9014ff4     	stp	x20, x19, [sp, #0x10]
4000504c: aa0003f4     	mov	x20, x0
40005050: aa0103e0     	mov	x0, x1
40005054: 910003fd     	mov	x29, sp
40005058: aa0103f3     	mov	x19, x1
4000505c: 97fff5f8     	bl	0x4000283c <kstrlen>
40005060: aa0003e2     	mov	x2, x0
40005064: aa1403e0     	mov	x0, x20
40005068: aa1303e1     	mov	x1, x19
4000506c: 940005d3     	bl	0x400067b8 <fat16_write_file>
40005070: aa1403e0     	mov	x0, x20
40005074: aa1303e1     	mov	x1, x19
40005078: a9414ff4     	ldp	x20, x19, [sp, #0x10]
4000507c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005080: 17ffff56     	b	0x40004dd8 <vfs_touch>

0000000040005084 <vfs_remove>:
40005084: b40005c0     	cbz	x0, 0x4000513c <vfs_remove+0xb8>
40005088: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
4000508c: 39400008     	ldrb	w8, [x0]
40005090: a9024ff4     	stp	x20, x19, [sp, #0x20]
40005094: aa0003f3     	mov	x19, x0
40005098: f9000bf5     	str	x21, [sp, #0x10]
4000509c: 910003fd     	mov	x29, sp
400050a0: 34000448     	cbz	w8, 0x40005128 <vfs_remove+0xa4>
400050a4: 90000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
400050a8: f945ce88     	ldr	x8, [x20, #0xb98]
400050ac: b944b909     	ldr	w9, [x8, #0x4b8]
400050b0: 7100053f     	cmp	w9, #0x1
400050b4: 540003ab     	b.lt	0x40005128 <vfs_remove+0xa4>
400050b8: aa1f03f5     	mov	x21, xzr
400050bc: 14000005     	b	0x400050d0 <vfs_remove+0x4c>
400050c0: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050c4: 910006b5     	add	x21, x21, #0x1
400050c8: eb0902bf     	cmp	x21, x9
400050cc: 540002ea     	b.ge	0x40005128 <vfs_remove+0xa4>
400050d0: 8b150d09     	add	x9, x8, x21, lsl #3
400050d4: f9421d20     	ldr	x0, [x9, #0x438]
400050d8: b4ffff40     	cbz	x0, 0x400050c0 <vfs_remove+0x3c>
400050dc: aa1303e1     	mov	x1, x19
400050e0: 97fff5e7     	bl	0x4000287c <kstrcmp>
400050e4: f945ce88     	ldr	x8, [x20, #0xb98]
400050e8: 35fffec0     	cbnz	w0, 0x400050c0 <vfs_remove+0x3c>
400050ec: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050f0: d1000529     	sub	x9, x9, #0x1
400050f4: 6b15013f     	cmp	w9, w21
400050f8: 5400026d     	b.le	0x40005144 <vfs_remove+0xc0>
400050fc: f945ce8a     	ldr	x10, [x20, #0xb98]
40005100: b984b949     	ldrsw	x9, [x10, #0x4b8]
40005104: d1000529     	sub	x9, x9, #0x1
40005108: 8b150d08     	add	x8, x8, x21, lsl #3
4000510c: 910006b5     	add	x21, x21, #0x1
40005110: eb0902bf     	cmp	x21, x9
40005114: f942210b     	ldr	x11, [x8, #0x440]
40005118: f9021d0b     	str	x11, [x8, #0x438]
4000511c: aa0a03e8     	mov	x8, x10
40005120: 54ffff4b     	b.lt	0x40005108 <vfs_remove+0x84>
40005124: 14000009     	b	0x40005148 <vfs_remove+0xc4>
40005128: 12800000     	mov	w0, #-0x1               // =-1
4000512c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005130: f9400bf5     	ldr	x21, [sp, #0x10]
40005134: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005138: d65f03c0     	ret
4000513c: 12800000     	mov	w0, #-0x1               // =-1
40005140: d65f03c0     	ret
40005144: aa0803ea     	mov	x10, x8
40005148: 8b090d48     	add	x8, x10, x9, lsl #3
4000514c: 2a1f03e0     	mov	w0, wzr
40005150: f9021d1f     	str	xzr, [x8, #0x438]
40005154: f945ce88     	ldr	x8, [x20, #0xb98]
40005158: b944b909     	ldr	w9, [x8, #0x4b8]
4000515c: 51000529     	sub	w9, w9, #0x1
40005160: b904b909     	str	w9, [x8, #0x4b8]
40005164: 17fffff2     	b	0x4000512c <vfs_remove+0xa8>

0000000040005168 <vfs_list_dir>:
40005168: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000516c: 90000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40005170: f100001f     	cmp	x0, #0x0
40005174: a90257f6     	stp	x22, x21, [sp, #0x20]
40005178: f945cd08     	ldr	x8, [x8, #0xb98]
4000517c: f9000bf7     	str	x23, [sp, #0x10]
40005180: 910003fd     	mov	x29, sp
40005184: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005188: 9a800115     	csel	x21, x8, x0, eq
4000518c: b94022a8     	ldr	w8, [x21, #0x20]
40005190: 7100051f     	cmp	w8, #0x1
40005194: 54000521     	b.ne	0x40005238 <vfs_list_dir+0xd0>
40005198: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
4000519c: 913b1c00     	add	x0, x0, #0xec7
400051a0: 97fff952     	bl	0x400036e8 <uart_puts>
400051a4: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400051a8: 91222800     	add	x0, x0, #0x88a
400051ac: 97fff94f     	bl	0x400036e8 <uart_puts>
400051b0: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400051b4: 913ecc00     	add	x0, x0, #0xfb3
400051b8: 97fff94c     	bl	0x400036e8 <uart_puts>
400051bc: f9421aa8     	ldr	x8, [x21, #0x430]
400051c0: b4000088     	cbz	x8, 0x400051d0 <vfs_list_dir+0x68>
400051c4: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400051c8: 9110d800     	add	x0, x0, #0x436
400051cc: 97fff947     	bl	0x400036e8 <uart_puts>
400051d0: b944baa1     	ldr	w1, [x21, #0x4b8]
400051d4: 7100043f     	cmp	w1, #0x1
400051d8: 5400034b     	b.lt	0x40005240 <vfs_list_dir+0xd8>
400051dc: aa1f03f6     	mov	x22, xzr
400051e0: b0000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
400051e4: 91335e73     	add	x19, x19, #0xcd7
400051e8: 9110e2b7     	add	x23, x21, #0x438
400051ec: b0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400051f0: 911fca94     	add	x20, x20, #0x7f2
400051f4: 14000008     	b	0x40005214 <vfs_list_dir+0xac>
400051f8: b9402841     	ldr	w1, [x2, #0x28]
400051fc: aa1403e0     	mov	x0, x20
40005200: 97fffa4f     	bl	0x40003b3c <uart_printf>
40005204: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40005208: 910006d6     	add	x22, x22, #0x1
4000520c: eb0102df     	cmp	x22, x1
40005210: 5400018a     	b.ge	0x40005240 <vfs_list_dir+0xd8>
40005214: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005218: b4ffff62     	cbz	x2, 0x40005204 <vfs_list_dir+0x9c>
4000521c: b9402048     	ldr	w8, [x2, #0x20]
40005220: 7100051f     	cmp	w8, #0x1
40005224: 54fffea1     	b.ne	0x400051f8 <vfs_list_dir+0x90>
40005228: aa1303e0     	mov	x0, x19
4000522c: aa0203e1     	mov	x1, x2
40005230: 97fffa43     	bl	0x40003b3c <uart_printf>
40005234: 17fffff4     	b	0x40005204 <vfs_list_dir+0x9c>
40005238: 12800000     	mov	w0, #-0x1               // =-1
4000523c: 14000005     	b	0x40005250 <vfs_list_dir+0xe8>
40005240: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005244: 91279400     	add	x0, x0, #0x9e5
40005248: 97fffa3d     	bl	0x40003b3c <uart_printf>
4000524c: 2a1f03e0     	mov	w0, wzr
40005250: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005254: f9400bf7     	ldr	x23, [sp, #0x10]
40005258: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000525c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005260: d65f03c0     	ret

0000000040005264 <vfs_load_internal>:
40005264: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40005268: 910003fd     	mov	x29, sp
4000526c: 94000706     	bl	0x40006e84 <fat16_populate_vfs>
40005270: 2a1f03e0     	mov	w0, wzr
40005274: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40005278: d65f03c0     	ret

000000004000527c <vfs_load>:
4000527c: 14000702     	b	0x40006e84 <fat16_populate_vfs>

0000000040005280 <pmm_init>:
40005280: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005284: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005288: d503201f     	nop
4000528c: 101b48b4     	adr	x20, 0x4003bba0 <memory_bitmap>
40005290: aa1403e0     	mov	x0, x20
40005294: 2a1f03e1     	mov	w1, wzr
40005298: 52820002     	mov	w2, #0x1000             // =4096
4000529c: 910003fd     	mov	x29, sp
400052a0: 97fff5c2     	bl	0x400029a8 <memset>
400052a4: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
400052a8: d503201f     	nop
400052ac: 1023eaa8     	adr	x8, 0x4004d000 <__kernel_end>
400052b0: f2820009     	movk	x9, #0x1000
400052b4: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
400052b8: f2402d1f     	tst	x8, #0xfff
400052bc: 8b090109     	add	x9, x8, x9
400052c0: 8b0a010a     	add	x10, x8, x10
400052c4: 9a890148     	csel	x8, x10, x9, eq
400052c8: d34cfd13     	lsr	x19, x8, #12
400052cc: 340001b3     	cbz	w19, 0x40005300 <pmm_init+0x80>
400052d0: 2a1f03e8     	mov	w8, wzr
400052d4: 52800029     	mov	w9, #0x1                // =1
400052d8: 2a0803ea     	mov	w10, w8
400052dc: 1200090b     	and	w11, w8, #0x7
400052e0: 11000508     	add	w8, w8, #0x1
400052e4: d343fd4a     	lsr	x10, x10, #3
400052e8: 1acb212b     	lsl	w11, w9, w11
400052ec: 6b08027f     	cmp	w19, w8
400052f0: 386a6a8c     	ldrb	w12, [x20, x10]
400052f4: 2a0b018b     	orr	w11, w12, w11
400052f8: 382a6a8b     	strb	w11, [x20, x10]
400052fc: 54fffee1     	b.ne	0x400052d8 <pmm_init+0x58>
40005300: 52900008     	mov	w8, #0x8000             // =32768
40005304: f0000034     	adrp	x20, 0x4000c000 <next_pid>
40005308: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
4000530c: 4b130108     	sub	w8, w8, w19
40005310: d503201f     	nop
40005314: 3002ef40     	adr	x0, 0x4000b0fd <__rodata_start+0x20fd>
40005318: b9000688     	str	w8, [x20, #0x4]
4000531c: b90ba133     	str	w19, [x9, #0xba0]
40005320: 97fffa07     	bl	0x40003b3c <uart_printf>
40005324: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005328: 91270c00     	add	x0, x0, #0x9c3
4000532c: 52801001     	mov	w1, #0x80               // =128
40005330: 97fffa03     	bl	0x40003b3c <uart_printf>
40005334: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005338: 91128800     	add	x0, x0, #0x4a2
4000533c: 2a1303e1     	mov	w1, w19
40005340: 97fff9ff     	bl	0x40003b3c <uart_printf>
40005344: b9400688     	ldr	w8, [x20, #0x4]
40005348: a9414ff4     	ldp	x20, x19, [sp, #0x10]
4000534c: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005350: 911c2000     	add	x0, x0, #0x708
40005354: 53084d01     	ubfx	w1, w8, #8, #12
40005358: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000535c: 17fff9f8     	b	0x40003b3c <uart_printf>

0000000040005360 <pmm_alloc_page>:
40005360: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005364: f0000028     	adrp	x8, 0x4000c000 <next_pid>
40005368: f9000bf3     	str	x19, [sp, #0x10]
4000536c: 910003fd     	mov	x29, sp
40005370: b940050a     	ldr	w10, [x8, #0x4]
40005374: 3400030a     	cbz	w10, 0x400053d4 <pmm_alloc_page+0x74>
40005378: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
4000537c: b94ba12b     	ldr	w11, [x9, #0xba0]
40005380: 530f7d6c     	lsr	w12, w11, #15
40005384: 3500022c     	cbnz	w12, 0x400053c8 <pmm_alloc_page+0x68>
40005388: 52a8000c     	mov	w12, #0x40000000        // =1073741824
4000538c: d503201f     	nop
40005390: 101b408d     	adr	x13, 0x4003bba0 <memory_bitmap>
40005394: 0b0b318c     	add	w12, w12, w11, lsl #12
40005398: 5280002e     	mov	w14, #0x1               // =1
4000539c: 2a0b03ef     	mov	w15, w11
400053a0: 12000971     	and	w17, w11, #0x7
400053a4: d343fdef     	lsr	x15, x15, #3
400053a8: 1ad121d1     	lsl	w17, w14, w17
400053ac: 386f69b0     	ldrb	w16, [x13, x15]
400053b0: 6a10023f     	tst	w17, w16
400053b4: 540001e0     	b.eq	0x400053f0 <pmm_alloc_page+0x90>
400053b8: 1100056b     	add	w11, w11, #0x1
400053bc: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
400053c0: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
400053c4: 54fffec1     	b.ne	0x4000539c <pmm_alloc_page+0x3c>
400053c8: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400053cc: 9112f000     	add	x0, x0, #0x4bc
400053d0: 14000003     	b	0x400053dc <pmm_alloc_page+0x7c>
400053d4: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400053d8: 911c7c00     	add	x0, x0, #0x71f
400053dc: 97fff8c3     	bl	0x400036e8 <uart_puts>
400053e0: aa1f03e0     	mov	x0, xzr
400053e4: f9400bf3     	ldr	x19, [sp, #0x10]
400053e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400053ec: d65f03c0     	ret
400053f0: 2a0c03f3     	mov	w19, w12
400053f4: 5100054a     	sub	w10, w10, #0x1
400053f8: 1100056b     	add	w11, w11, #0x1
400053fc: aa1303e0     	mov	x0, x19
40005400: 2a1f03e1     	mov	w1, wzr
40005404: 52820002     	mov	w2, #0x1000             // =4096
40005408: 2a11020e     	orr	w14, w16, w17
4000540c: 382f69ae     	strb	w14, [x13, x15]
40005410: b900050a     	str	w10, [x8, #0x4]
40005414: b90ba12b     	str	w11, [x9, #0xba0]
40005418: 97fff564     	bl	0x400029a8 <memset>
4000541c: aa1303e0     	mov	x0, x19
40005420: 17fffff1     	b	0x400053e4 <pmm_alloc_page+0x84>

0000000040005424 <pmm_free_page>:
40005424: d35efc08     	lsr	x8, x0, #30
40005428: b4000128     	cbz	x8, 0x4000544c <pmm_free_page+0x28>
4000542c: d35bfc08     	lsr	x8, x0, #27
40005430: f100251f     	cmp	x8, #0x9
40005434: 540000c2     	b.hs	0x4000544c <pmm_free_page+0x28>
40005438: f2402c1f     	tst	x0, #0xfff
4000543c: 540000e0     	b.eq	0x40005458 <pmm_free_page+0x34>
40005440: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005444: 9122d000     	add	x0, x0, #0x8b4
40005448: 17fff8a8     	b	0x400036e8 <uart_puts>
4000544c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005450: 91081000     	add	x0, x0, #0x204
40005454: 17fff8a5     	b	0x400036e8 <uart_puts>
40005458: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
4000545c: d503201f     	nop
40005460: 101b3a0a     	adr	x10, 0x4003bba0 <memory_bitmap>
40005464: 8b080009     	add	x9, x0, x8
40005468: 5280002d     	mov	w13, #0x1               // =1
4000546c: d34fad28     	ubfx	x8, x9, #15, #29
40005470: d34c392c     	ubfx	x12, x9, #12, #3
40005474: 3868694b     	ldrb	w11, [x10, x8]
40005478: 1acc21ac     	lsl	w12, w13, w12
4000547c: 6a0b019f     	tst	w12, w11
40005480: 540001c0     	b.eq	0x400054b8 <pmm_free_page+0x94>
40005484: f000002e     	adrp	x14, 0x4000c000 <next_pid>
40005488: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
4000548c: d34cfd29     	lsr	x9, x9, #12
40005490: b94005cf     	ldr	w15, [x14, #0x4]
40005494: b94ba1b0     	ldr	w16, [x13, #0xba0]
40005498: 0a2c016b     	bic	w11, w11, w12
4000549c: 3828694b     	strb	w11, [x10, x8]
400054a0: 110005e8     	add	w8, w15, #0x1
400054a4: 6b09021f     	cmp	w16, w9
400054a8: b90005c8     	str	w8, [x14, #0x4]
400054ac: 54000049     	b.ls	0x400054b4 <pmm_free_page+0x90>
400054b0: b90ba1a9     	str	w9, [x13, #0xba0]
400054b4: d65f03c0     	ret
400054b8: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400054bc: 912ff400     	add	x0, x0, #0xbfd
400054c0: 17fff88a     	b	0x400036e8 <uart_puts>

00000000400054c4 <pmm_get_free_memory>:
400054c4: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400054c8: b9400508     	ldr	w8, [x8, #0x4]
400054cc: 53144d00     	lsl	w0, w8, #12
400054d0: d65f03c0     	ret

00000000400054d4 <sched_init>:
400054d4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400054d8: 912ec108     	add	x8, x8, #0xbb0
400054dc: d2c00029     	mov	x9, #0x100000000        // =4294967296
400054e0: f9001109     	str	x9, [x8, #0x20]
400054e4: d2c00049     	mov	x9, #0x200000000        // =8589934592
400054e8: d503201f     	nop
400054ec: 10023720     	adr	x0, 0x40009bd0 <__rodata_start+0xbd0>
400054f0: f9001d09     	str	x9, [x8, #0x38]
400054f4: d2c00069     	mov	x9, #0x300000000        // =12884901888
400054f8: f9002909     	str	x9, [x8, #0x50]
400054fc: d2c00089     	mov	x9, #0x400000000        // =17179869184
40005500: f9003509     	str	x9, [x8, #0x68]
40005504: d2c000a9     	mov	x9, #0x500000000        // =21474836480
40005508: f9004109     	str	x9, [x8, #0x80]
4000550c: d2c000c9     	mov	x9, #0x600000000        // =25769803776
40005510: f9004d09     	str	x9, [x8, #0x98]
40005514: d2c000e9     	mov	x9, #0x700000000        // =30064771072
40005518: f9005909     	str	x9, [x8, #0xb0]
4000551c: d2c00109     	mov	x9, #0x800000000        // =34359738368
40005520: f9006509     	str	x9, [x8, #0xc8]
40005524: d2c00129     	mov	x9, #0x900000000        // =38654705664
40005528: f9007109     	str	x9, [x8, #0xe0]
4000552c: d2c00149     	mov	x9, #0xa00000000        // =42949672960
40005530: f9007d09     	str	x9, [x8, #0xf8]
40005534: d2c00169     	mov	x9, #0xb00000000        // =47244640256
40005538: f9008909     	str	x9, [x8, #0x110]
4000553c: d2c00189     	mov	x9, #0xc00000000        // =51539607552
40005540: f9009509     	str	x9, [x8, #0x128]
40005544: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
40005548: f900a109     	str	x9, [x8, #0x140]
4000554c: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
40005550: f900ad09     	str	x9, [x8, #0x158]
40005554: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
40005558: f900b909     	str	x9, [x8, #0x170]
4000555c: 52800049     	mov	w9, #0x2                // =2
40005560: a900251f     	stp	xzr, x9, [x8]
40005564: f0000028     	adrp	x8, 0x4000c000 <next_pid>
40005568: b900091f     	str	wzr, [x8, #0x8]
4000556c: 17fff85f     	b	0x400036e8 <uart_puts>

0000000040005570 <sched_create_task>:
40005570: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005574: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005578: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000557c: aa0003f3     	mov	x19, x0
40005580: b94bd108     	ldr	w8, [x8, #0xbd0]
40005584: f9000bf7     	str	x23, [sp, #0x10]
40005588: 910003fd     	mov	x29, sp
4000558c: a90257f6     	stp	x22, x21, [sp, #0x20]
40005590: 340005c8     	cbz	w8, 0x40005648 <sched_create_task+0xd8>
40005594: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005598: b94be908     	ldr	w8, [x8, #0xbe8]
4000559c: 340005a8     	cbz	w8, 0x40005650 <sched_create_task+0xe0>
400055a0: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055a4: b94c0108     	ldr	w8, [x8, #0xc00]
400055a8: 34000588     	cbz	w8, 0x40005658 <sched_create_task+0xe8>
400055ac: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055b0: b94c1908     	ldr	w8, [x8, #0xc18]
400055b4: 34000568     	cbz	w8, 0x40005660 <sched_create_task+0xf0>
400055b8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055bc: b94c3108     	ldr	w8, [x8, #0xc30]
400055c0: 34000548     	cbz	w8, 0x40005668 <sched_create_task+0xf8>
400055c4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055c8: b94c4908     	ldr	w8, [x8, #0xc48]
400055cc: 34000528     	cbz	w8, 0x40005670 <sched_create_task+0x100>
400055d0: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055d4: b94c6108     	ldr	w8, [x8, #0xc60]
400055d8: 34000508     	cbz	w8, 0x40005678 <sched_create_task+0x108>
400055dc: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055e0: b94c7908     	ldr	w8, [x8, #0xc78]
400055e4: 340004e8     	cbz	w8, 0x40005680 <sched_create_task+0x110>
400055e8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055ec: b94c9108     	ldr	w8, [x8, #0xc90]
400055f0: 340004c8     	cbz	w8, 0x40005688 <sched_create_task+0x118>
400055f4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400055f8: b94ca908     	ldr	w8, [x8, #0xca8]
400055fc: 340004a8     	cbz	w8, 0x40005690 <sched_create_task+0x120>
40005600: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005604: b94cc108     	ldr	w8, [x8, #0xcc0]
40005608: 34000488     	cbz	w8, 0x40005698 <sched_create_task+0x128>
4000560c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005610: b94cd908     	ldr	w8, [x8, #0xcd8]
40005614: 34000468     	cbz	w8, 0x400056a0 <sched_create_task+0x130>
40005618: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000561c: b94cf108     	ldr	w8, [x8, #0xcf0]
40005620: 34000448     	cbz	w8, 0x400056a8 <sched_create_task+0x138>
40005624: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005628: b94d0908     	ldr	w8, [x8, #0xd08]
4000562c: 34000428     	cbz	w8, 0x400056b0 <sched_create_task+0x140>
40005630: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005634: b94d2108     	ldr	w8, [x8, #0xd20]
40005638: 34000408     	cbz	w8, 0x400056b8 <sched_create_task+0x148>
4000563c: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005640: 910a2800     	add	x0, x0, #0x28a
40005644: 1400003c     	b	0x40005734 <sched_create_task+0x1c4>
40005648: 52800034     	mov	w20, #0x1               // =1
4000564c: 1400001c     	b	0x400056bc <sched_create_task+0x14c>
40005650: 52800054     	mov	w20, #0x2               // =2
40005654: 1400001a     	b	0x400056bc <sched_create_task+0x14c>
40005658: 52800074     	mov	w20, #0x3               // =3
4000565c: 14000018     	b	0x400056bc <sched_create_task+0x14c>
40005660: 52800094     	mov	w20, #0x4               // =4
40005664: 14000016     	b	0x400056bc <sched_create_task+0x14c>
40005668: 528000b4     	mov	w20, #0x5               // =5
4000566c: 14000014     	b	0x400056bc <sched_create_task+0x14c>
40005670: 528000d4     	mov	w20, #0x6               // =6
40005674: 14000012     	b	0x400056bc <sched_create_task+0x14c>
40005678: 528000f4     	mov	w20, #0x7               // =7
4000567c: 14000010     	b	0x400056bc <sched_create_task+0x14c>
40005680: 52800114     	mov	w20, #0x8               // =8
40005684: 1400000e     	b	0x400056bc <sched_create_task+0x14c>
40005688: 52800134     	mov	w20, #0x9               // =9
4000568c: 1400000c     	b	0x400056bc <sched_create_task+0x14c>
40005690: 52800154     	mov	w20, #0xa               // =10
40005694: 1400000a     	b	0x400056bc <sched_create_task+0x14c>
40005698: 52800174     	mov	w20, #0xb               // =11
4000569c: 14000008     	b	0x400056bc <sched_create_task+0x14c>
400056a0: 52800194     	mov	w20, #0xc               // =12
400056a4: 14000006     	b	0x400056bc <sched_create_task+0x14c>
400056a8: 528001b4     	mov	w20, #0xd               // =13
400056ac: 14000004     	b	0x400056bc <sched_create_task+0x14c>
400056b0: 528001d4     	mov	w20, #0xe               // =14
400056b4: 14000002     	b	0x400056bc <sched_create_task+0x14c>
400056b8: 528001f4     	mov	w20, #0xf               // =15
400056bc: 97ffff29     	bl	0x40005360 <pmm_alloc_page>
400056c0: b4000360     	cbz	x0, 0x4000572c <sched_create_task+0x1bc>
400056c4: 52800308     	mov	w8, #0x18               // =24
400056c8: d503201f     	nop
400056cc: 101ba6e9     	adr	x9, 0x4003cba8 <tasks>
400056d0: 9ba82696     	umaddl	x22, w20, w8, x9
400056d4: 913bc015     	add	x21, x0, #0xef0
400056d8: aa0003f7     	mov	x23, x0
400056dc: 2a1f03e1     	mov	w1, wzr
400056e0: 52802202     	mov	w2, #0x110              // =272
400056e4: f90006c0     	str	x0, [x22, #0x8]
400056e8: aa1503e0     	mov	x0, x21
400056ec: 97fff4af     	bl	0x400029a8 <memset>
400056f0: 52800029     	mov	w9, #0x1                // =1
400056f4: f907f6f3     	str	x19, [x23, #0xfe8]
400056f8: 528000a8     	mov	w8, #0x5                // =5
400056fc: f90002d5     	str	x21, [x22]
40005700: 2a1403e1     	mov	w1, w20
40005704: 2a1303e2     	mov	w2, w19
40005708: b90012c9     	str	w9, [x22, #0x10]
4000570c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005710: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005714: f907fae8     	str	x8, [x23, #0xff0]
40005718: f9400bf7     	ldr	x23, [sp, #0x10]
4000571c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005720: 91207800     	add	x0, x0, #0x81e
40005724: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005728: 17fff905     	b	0x40003b3c <uart_printf>
4000572c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005730: 911a0c00     	add	x0, x0, #0x683
40005734: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005738: f9400bf7     	ldr	x23, [sp, #0x10]
4000573c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005740: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005744: 17fff7e9     	b	0x400036e8 <uart_puts>

0000000040005748 <sched_switch>:
40005748: f0000028     	adrp	x8, 0x4000c000 <next_pid>
4000574c: b940090b     	ldr	w11, [x8, #0x8]
40005750: 3100057f     	cmn	w11, #0x1
40005754: 54000300     	b.eq	0x400057b4 <sched_switch+0x6c>
40005758: 5280030a     	mov	w10, #0x18              // =24
4000575c: d503201f     	nop
40005760: 101ba249     	adr	x9, 0x4003cba8 <tasks>
40005764: 9b2a256c     	smaddl	x12, w11, w10, x9
40005768: 9b2a7d6d     	smull	x13, w11, w10
4000576c: b8410d8e     	ldr	w14, [x12, #0x10]!
40005770: f82d6920     	str	x0, [x9, x13]
40005774: 710009df     	cmp	w14, #0x2
40005778: 54000061     	b.ne	0x40005784 <sched_switch+0x3c>
4000577c: 5280002d     	mov	w13, #0x1               // =1
40005780: b900018d     	str	w13, [x12]
40005784: 5280020c     	mov	w12, #0x10              // =16
40005788: 1100056b     	add	w11, w11, #0x1
4000578c: 6b0b03ed     	negs	w13, w11
40005790: 12000d6b     	and	w11, w11, #0xf
40005794: 12000dad     	and	w13, w13, #0xf
40005798: 5a8d456b     	csneg	w11, w11, w13, mi
4000579c: 9b2a256d     	smaddl	x13, w11, w10, x9
400057a0: b8410dae     	ldr	w14, [x13, #0x10]!
400057a4: 710005df     	cmp	w14, #0x1
400057a8: 54000080     	b.eq	0x400057b8 <sched_switch+0x70>
400057ac: 7100058c     	subs	w12, w12, #0x1
400057b0: 54fffec1     	b.ne	0x40005788 <sched_switch+0x40>
400057b4: d65f03c0     	ret
400057b8: 5280030a     	mov	w10, #0x18              // =24
400057bc: b900090b     	str	w11, [x8, #0x8]
400057c0: 52800048     	mov	w8, #0x2                // =2
400057c4: 9b2a7d6a     	smull	x10, w11, w10
400057c8: b90001a8     	str	w8, [x13]
400057cc: f86a6920     	ldr	x0, [x9, x10]
400057d0: d65f03c0     	ret

00000000400057d4 <virtio_blk_init>:
400057d4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400057d8: 528d2ec9     	mov	w9, #0x6976             // =26998
400057dc: 52a14001     	mov	w1, #0xa000000          // =167772160
400057e0: 52800408     	mov	w8, #0x20               // =32
400057e4: 72ae8e49     	movk	w9, #0x7472, lsl #16
400057e8: a9014ff4     	stp	x20, x19, [sp, #0x10]
400057ec: 910003fd     	mov	x29, sp
400057f0: 14000004     	b	0x40005800 <virtio_blk_init+0x2c>
400057f4: f1000508     	subs	x8, x8, #0x1
400057f8: 91080021     	add	x1, x1, #0x200
400057fc: 540001a0     	b.eq	0x40005830 <virtio_blk_init+0x5c>
40005800: b940002a     	ldr	w10, [x1]
40005804: 6b09015f     	cmp	w10, w9
40005808: 54ffff61     	b.ne	0x400057f4 <virtio_blk_init+0x20>
4000580c: b9400422     	ldr	w2, [x1, #0x4]
40005810: b940082a     	ldr	w10, [x1, #0x8]
40005814: 7100095f     	cmp	w10, #0x2
40005818: 54fffee1     	b.ne	0x400057f4 <virtio_blk_init+0x20>
4000581c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005820: d503201f     	nop
40005824: 7002b460     	adr	x0, 0x4000aeb3 <__rodata_start+0x1eb3>
40005828: f9069501     	str	x1, [x8, #0xd28]
4000582c: 97fff8c4     	bl	0x40003b3c <uart_printf>
40005830: f00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
40005834: f9469688     	ldr	x8, [x20, #0xd28]
40005838: b40004a8     	cbz	x8, 0x400058cc <virtio_blk_init+0xf8>
4000583c: 52800029     	mov	w9, #0x1                // =1
40005840: 5280006a     	mov	w10, #0x3               // =3
40005844: b900711f     	str	wzr, [x8, #0x70]
40005848: b9007109     	str	w9, [x8, #0x70]
4000584c: b900710a     	str	w10, [x8, #0x70]
40005850: b900211f     	str	wzr, [x8, #0x20]
40005854: b900311f     	str	wzr, [x8, #0x30]
40005858: b9403509     	ldr	w9, [x8, #0x34]
4000585c: 34000409     	cbz	w9, 0x400058dc <virtio_blk_init+0x108>
40005860: 52800209     	mov	w9, #0x10               // =16
40005864: b9003909     	str	w9, [x8, #0x38]
40005868: 97fffebe     	bl	0x40005360 <pmm_alloc_page>
4000586c: aa0003f3     	mov	x19, x0
40005870: 97fffebc     	bl	0x40005360 <pmm_alloc_page>
40005874: b40003d3     	cbz	x19, 0x400058ec <virtio_blk_init+0x118>
40005878: f9469688     	ldr	x8, [x20, #0xd28]
4000587c: 52820009     	mov	w9, #0x1000             // =4096
40005880: 9104026a     	add	x10, x19, #0x100
40005884: d34cfe6b     	lsr	x11, x19, #12
40005888: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000588c: 91187800     	add	x0, x0, #0x61e
40005890: b9002909     	str	w9, [x8, #0x28]
40005894: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005898: f9069d2a     	str	x10, [x9, #0xd38]
4000589c: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400058a0: 528224aa     	mov	w10, #0x1125            // =4389
400058a4: f9069933     	str	x19, [x9, #0xd30]
400058a8: 8b0a0269     	add	x9, x19, x10
400058ac: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
400058b0: 9274cd29     	and	x9, x9, #0xfffffffffffff000
400058b4: 52800033     	mov	w19, #0x1               // =1
400058b8: f906a149     	str	x9, [x10, #0xd40]
400058bc: 528000e9     	mov	w9, #0x7                // =7
400058c0: b900410b     	str	w11, [x8, #0x40]
400058c4: b9007109     	str	w9, [x8, #0x70]
400058c8: 14000008     	b	0x400058e8 <virtio_blk_init+0x114>
400058cc: 2a1f03f3     	mov	w19, wzr
400058d0: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400058d4: 911ae800     	add	x0, x0, #0x6ba
400058d8: 14000004     	b	0x400058e8 <virtio_blk_init+0x114>
400058dc: 2a1f03f3     	mov	w19, wzr
400058e0: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400058e4: 91307400     	add	x0, x0, #0xc1d
400058e8: 97fff780     	bl	0x400036e8 <uart_puts>
400058ec: 2a1303e0     	mov	w0, w19
400058f0: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400058f4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400058f8: d65f03c0     	ret

00000000400058fc <virtio_blk_read_sector>:
400058fc: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005900: f9469509     	ldr	x9, [x8, #0xd28]
40005904: b4001309     	cbz	x9, 0x40005b64 <virtio_blk_read_sector+0x268>
40005908: d10083ff     	sub	sp, sp, #0x20
4000590c: d360fc09     	lsr	x9, x0, #32
40005910: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005914: 9135216b     	add	x11, x11, #0xd48
40005918: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
4000591c: 9135614a     	add	x10, x10, #0xd58
40005920: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005924: 29012560     	stp	w0, w9, [x11, #0x8]
40005928: 52801fe9     	mov	w9, #0xff               // =255
4000592c: d358fd6d     	lsr	x13, x11, #24
40005930: 29007d7f     	stp	wzr, wzr, [x11]
40005934: d348fc2e     	lsr	x14, x1, #8
40005938: d368fd6c     	lsr	x12, x11, #40
4000593c: 39000149     	strb	w9, [x10]
40005940: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005944: d348fd4f     	lsr	x15, x10, #8
40005948: f9469929     	ldr	x9, [x9, #0xd30]
4000594c: 910043fd     	add	x29, sp, #0x10
40005950: 39000d2d     	strb	w13, [x9, #0x3]
40005954: d348fd6d     	lsr	x13, x11, #8
40005958: 3900452e     	strb	w14, [x9, #0x11]
4000595c: 5280006e     	mov	w14, #0x3               // =3
40005960: 3900052d     	strb	w13, [x9, #0x1]
40005964: d368fc2d     	lsr	x13, x1, #40
40005968: 3900712e     	strb	w14, [x9, #0x1c]
4000596c: d368fd4e     	lsr	x14, x10, #40
40005970: 3900552d     	strb	w13, [x9, #0x15]
40005974: 5280004d     	mov	w13, #0x2               // =2
40005978: 3900012b     	strb	w11, [x9]
4000597c: 3900152c     	strb	w12, [x9, #0x5]
40005980: d350fd6c     	lsr	x12, x11, #16
40005984: 3900652d     	strb	w13, [x9, #0x19]
40005988: 3900792d     	strb	w13, [x9, #0x1e]
4000598c: 3900852f     	strb	w15, [x9, #0x21]
40005990: d378fd6f     	lsr	x15, x11, #56
40005994: 3900b12d     	strb	w13, [x9, #0x2c]
40005998: d360fd6d     	lsr	x13, x11, #32
4000599c: d370fd6b     	lsr	x11, x11, #48
400059a0: 3900952e     	strb	w14, [x9, #0x25]
400059a4: aa0903ee     	mov	x14, x9
400059a8: 38004dcd     	strb	w13, [x14, #0x4]!
400059ac: aa0903ed     	mov	x13, x9
400059b0: 390009cb     	strb	w11, [x14, #0x2]
400059b4: 5280020b     	mov	w11, #0x10              // =16
400059b8: 38008dab     	strb	w11, [x13, #0x8]!
400059bc: aa0903eb     	mov	x11, x9
400059c0: 39000dbf     	strb	wzr, [x13, #0x3]
400059c4: 390009bf     	strb	wzr, [x13, #0x2]
400059c8: d358fc2d     	lsr	x13, x1, #24
400059cc: 39000dcf     	strb	w15, [x14, #0x3]
400059d0: d350fc2e     	lsr	x14, x1, #16
400059d4: aa0903ef     	mov	x15, x9
400059d8: 38010d61     	strb	w1, [x11, #0x10]!
400059dc: 39000d6d     	strb	w13, [x11, #0x3]
400059e0: d360fc2d     	lsr	x13, x1, #32
400059e4: 3900096e     	strb	w14, [x11, #0x2]
400059e8: d378fc2e     	lsr	x14, x1, #56
400059ec: 38004d6d     	strb	w13, [x11, #0x4]!
400059f0: d370fc2d     	lsr	x13, x1, #48
400059f4: 39000d6e     	strb	w14, [x11, #0x3]
400059f8: aa0903ee     	mov	x14, x9
400059fc: 3900096d     	strb	w13, [x11, #0x2]
40005a00: d358fd4b     	lsr	x11, x10, #24
40005a04: d350fd4d     	lsr	x13, x10, #16
40005a08: 38020dca     	strb	w10, [x14, #0x20]!
40005a0c: 39000dcb     	strb	w11, [x14, #0x3]
40005a10: d360fd4b     	lsr	x11, x10, #32
40005a14: 390009cd     	strb	w13, [x14, #0x2]
40005a18: 38004dcb     	strb	w11, [x14, #0x4]!
40005a1c: d378fd4b     	lsr	x11, x10, #56
40005a20: d370fd4a     	lsr	x10, x10, #48
40005a24: 3900092c     	strb	w12, [x9, #0x2]
40005a28: 5280002c     	mov	w12, #0x1               // =1
40005a2c: 39000dcb     	strb	w11, [x14, #0x3]
40005a30: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005a34: 390009ca     	strb	w10, [x14, #0x2]
40005a38: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005a3c: 795ab96d     	ldrh	w13, [x11, #0xd5c]
40005a40: f9469d4e     	ldr	x14, [x10, #0xd38]
40005a44: 3900253f     	strb	wzr, [x9, #0x9]
40005a48: 92400dad     	and	x13, x13, #0xf
40005a4c: 3900353f     	strb	wzr, [x9, #0xd]
40005a50: 3900312c     	strb	w12, [x9, #0xc]
40005a54: 39003d3f     	strb	wzr, [x9, #0xf]
40005a58: 3900392c     	strb	w12, [x9, #0xe]
40005a5c: 3900753f     	strb	wzr, [x9, #0x1d]
40005a60: 39007d3f     	strb	wzr, [x9, #0x1f]
40005a64: 3900a53f     	strb	wzr, [x9, #0x29]
40005a68: 3900b53f     	strb	wzr, [x9, #0x2d]
40005a6c: 3900bd3f     	strb	wzr, [x9, #0x2f]
40005a70: 3900b93f     	strb	wzr, [x9, #0x2e]
40005a74: 38028d2c     	strb	w12, [x9, #0x28]!
40005a78: 8b0d05cc     	add	x12, x14, x13, lsl #1
40005a7c: 38018dff     	strb	wzr, [x15, #0x18]!
40005a80: 39000dff     	strb	wzr, [x15, #0x3]
40005a84: 390009ff     	strb	wzr, [x15, #0x2]
40005a88: 39000d3f     	strb	wzr, [x9, #0x3]
40005a8c: 3900093f     	strb	wzr, [x9, #0x2]
40005a90: 3900159f     	strb	wzr, [x12, #0x5]
40005a94: 3900119f     	strb	wzr, [x12, #0x4]
40005a98: d5033fbf     	dmb	sy
40005a9c: 795ab969     	ldrh	w9, [x11, #0xd5c]
40005aa0: f9469d4a     	ldr	x10, [x10, #0xd38]
40005aa4: 11000529     	add	w9, w9, #0x1
40005aa8: 53087d2c     	lsr	w12, w9, #8
40005aac: 791ab969     	strh	w9, [x11, #0xd5c]
40005ab0: 39000949     	strb	w9, [x10, #0x2]
40005ab4: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005ab8: 39000d4c     	strb	w12, [x10, #0x3]
40005abc: d5033fbf     	dmb	sy
40005ac0: f9469508     	ldr	x8, [x8, #0xd28]
40005ac4: b900511f     	str	wzr, [x8, #0x50]
40005ac8: f946a128     	ldr	x8, [x9, #0xd40]
40005acc: aa0803e9     	mov	x9, x8
40005ad0: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005ad4: 3940052b     	ldrb	w11, [x9, #0x1]
40005ad8: 3940052c     	ldrb	w12, [x9, #0x1]
40005adc: 3940012d     	ldrb	w13, [x9]
40005ae0: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005ae4: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005ae8: 6b09015f     	cmp	w10, w9
40005aec: 540002a1     	b.ne	0x40005b40 <virtio_blk_read_sector+0x244>
40005af0: 5292d00a     	mov	w10, #0x9680            // =38528
40005af4: 72a0130a     	movk	w10, #0x98, lsl #16
40005af8: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005afc: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005b00: 71018d7f     	cmp	w11, #0x63
40005b04: 540000ec     	b.gt	0x40005b20 <virtio_blk_read_sector+0x224>
40005b08: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005b0c: 1100056b     	add	w11, w11, #0x1
40005b10: b81fc3ab     	stur	w11, [x29, #-0x4]
40005b14: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005b18: 7101917f     	cmp	w11, #0x64
40005b1c: 54ffff6b     	b.lt	0x40005b08 <virtio_blk_read_sector+0x20c>
40005b20: 39400d0b     	ldrb	w11, [x8, #0x3]
40005b24: 3940090c     	ldrb	w12, [x8, #0x2]
40005b28: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005b2c: 6b09017f     	cmp	w11, w9
40005b30: 54000081     	b.ne	0x40005b40 <virtio_blk_read_sector+0x244>
40005b34: 7100055f     	cmp	w10, #0x1
40005b38: 5100054a     	sub	w10, w10, #0x1
40005b3c: 54fffde8     	b.hi	0x40005af8 <virtio_blk_read_sector+0x1fc>
40005b40: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005b44: 39756109     	ldrb	w9, [x8, #0xd58]
40005b48: 34000129     	cbz	w9, 0x40005b6c <virtio_blk_read_sector+0x270>
40005b4c: 39756101     	ldrb	w1, [x8, #0xd58]
40005b50: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005b54: 91049c00     	add	x0, x0, #0x127
40005b58: 97fff7f9     	bl	0x40003b3c <uart_printf>
40005b5c: 2a1f03e0     	mov	w0, wzr
40005b60: 14000004     	b	0x40005b70 <virtio_blk_read_sector+0x274>
40005b64: 2a1f03e0     	mov	w0, wzr
40005b68: d65f03c0     	ret
40005b6c: 52800020     	mov	w0, #0x1                // =1
40005b70: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005b74: 910083ff     	add	sp, sp, #0x20
40005b78: d65f03c0     	ret

0000000040005b7c <virtio_blk_write_sector>:
40005b7c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005b80: f9469509     	ldr	x9, [x8, #0xd28]
40005b84: b4001289     	cbz	x9, 0x40005dd4 <virtio_blk_write_sector+0x258>
40005b88: d10083ff     	sub	sp, sp, #0x20
40005b8c: d360fc0a     	lsr	x10, x0, #32
40005b90: f00001ac     	adrp	x12, 0x4003c000 <memory_bitmap+0x460>
40005b94: 9135818c     	add	x12, x12, #0xd60
40005b98: 52800029     	mov	w9, #0x1                // =1
40005b9c: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005ba0: 9135c16b     	add	x11, x11, #0xd70
40005ba4: 29012980     	stp	w0, w10, [x12, #0x8]
40005ba8: 52801fea     	mov	w10, #0xff              // =255
40005bac: d368fd8d     	lsr	x13, x12, #40
40005bb0: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005bb4: d358fd8e     	lsr	x14, x12, #24
40005bb8: d348fd6f     	lsr	x15, x11, #8
40005bbc: 29007d89     	stp	w9, wzr, [x12]
40005bc0: 910043fd     	add	x29, sp, #0x10
40005bc4: 3900016a     	strb	w10, [x11]
40005bc8: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005bcc: f946994a     	ldr	x10, [x10, #0xd30]
40005bd0: 3900154d     	strb	w13, [x10, #0x5]
40005bd4: d350fd8d     	lsr	x13, x12, #16
40005bd8: 39000d4e     	strb	w14, [x10, #0x3]
40005bdc: d348fd8e     	lsr	x14, x12, #8
40005be0: 3900094d     	strb	w13, [x10, #0x2]
40005be4: d368fc2d     	lsr	x13, x1, #40
40005be8: 3900054e     	strb	w14, [x10, #0x1]
40005bec: d348fc2e     	lsr	x14, x1, #8
40005bf0: 3900554d     	strb	w13, [x10, #0x15]
40005bf4: 5280004d     	mov	w13, #0x2               // =2
40005bf8: 3900454e     	strb	w14, [x10, #0x11]
40005bfc: d368fd6e     	lsr	x14, x11, #40
40005c00: 3900014c     	strb	w12, [x10]
40005c04: 3900654d     	strb	w13, [x10, #0x19]
40005c08: 3900794d     	strb	w13, [x10, #0x1e]
40005c0c: 3900854f     	strb	w15, [x10, #0x21]
40005c10: d378fd8f     	lsr	x15, x12, #56
40005c14: 3900b14d     	strb	w13, [x10, #0x2c]
40005c18: d360fd8d     	lsr	x13, x12, #32
40005c1c: d370fd8c     	lsr	x12, x12, #48
40005c20: 3900954e     	strb	w14, [x10, #0x25]
40005c24: aa0a03ee     	mov	x14, x10
40005c28: 38004dcd     	strb	w13, [x14, #0x4]!
40005c2c: aa0a03ed     	mov	x13, x10
40005c30: 390009cc     	strb	w12, [x14, #0x2]
40005c34: 5280020c     	mov	w12, #0x10              // =16
40005c38: 38008dac     	strb	w12, [x13, #0x8]!
40005c3c: aa0a03ec     	mov	x12, x10
40005c40: 39000dbf     	strb	wzr, [x13, #0x3]
40005c44: 390009bf     	strb	wzr, [x13, #0x2]
40005c48: d358fc2d     	lsr	x13, x1, #24
40005c4c: 39000dcf     	strb	w15, [x14, #0x3]
40005c50: d350fc2e     	lsr	x14, x1, #16
40005c54: d360fd6f     	lsr	x15, x11, #32
40005c58: 38010d81     	strb	w1, [x12, #0x10]!
40005c5c: 39000d8d     	strb	w13, [x12, #0x3]
40005c60: d360fc2d     	lsr	x13, x1, #32
40005c64: 3900098e     	strb	w14, [x12, #0x2]
40005c68: d378fc2e     	lsr	x14, x1, #56
40005c6c: 38004d8d     	strb	w13, [x12, #0x4]!
40005c70: d370fc2d     	lsr	x13, x1, #48
40005c74: 39000d8e     	strb	w14, [x12, #0x3]
40005c78: aa0a03ee     	mov	x14, x10
40005c7c: 3900098d     	strb	w13, [x12, #0x2]
40005c80: d358fd6d     	lsr	x13, x11, #24
40005c84: aa0a03ec     	mov	x12, x10
40005c88: 38018ddf     	strb	wzr, [x14, #0x18]!
40005c8c: 39000ddf     	strb	wzr, [x14, #0x3]
40005c90: 390009df     	strb	wzr, [x14, #0x2]
40005c94: d350fd6e     	lsr	x14, x11, #16
40005c98: 38020d8b     	strb	w11, [x12, #0x20]!
40005c9c: 39000d8d     	strb	w13, [x12, #0x3]
40005ca0: d378fd6d     	lsr	x13, x11, #56
40005ca4: d370fd6b     	lsr	x11, x11, #48
40005ca8: 3900098e     	strb	w14, [x12, #0x2]
40005cac: f00001ae     	adrp	x14, 0x4003c000 <memory_bitmap+0x460>
40005cb0: 38004d8f     	strb	w15, [x12, #0x4]!
40005cb4: 795ab9cf     	ldrh	w15, [x14, #0xd5c]
40005cb8: 39000d8d     	strb	w13, [x12, #0x3]
40005cbc: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
40005cc0: f9469dad     	ldr	x13, [x13, #0xd38]
40005cc4: 3900255f     	strb	wzr, [x10, #0x9]
40005cc8: 3900355f     	strb	wzr, [x10, #0xd]
40005ccc: 39003149     	strb	w9, [x10, #0xc]
40005cd0: 39003d5f     	strb	wzr, [x10, #0xf]
40005cd4: 39003949     	strb	w9, [x10, #0xe]
40005cd8: 3900755f     	strb	wzr, [x10, #0x1d]
40005cdc: 39007149     	strb	w9, [x10, #0x1c]
40005ce0: 39007d5f     	strb	wzr, [x10, #0x1f]
40005ce4: 3900a55f     	strb	wzr, [x10, #0x29]
40005ce8: 3900b55f     	strb	wzr, [x10, #0x2d]
40005cec: 3900bd5f     	strb	wzr, [x10, #0x2f]
40005cf0: 3900b95f     	strb	wzr, [x10, #0x2e]
40005cf4: 38028d49     	strb	w9, [x10, #0x28]!
40005cf8: 92400de9     	and	x9, x15, #0xf
40005cfc: 8b0905a9     	add	x9, x13, x9, lsl #1
40005d00: 39000d5f     	strb	wzr, [x10, #0x3]
40005d04: 3900095f     	strb	wzr, [x10, #0x2]
40005d08: 110005ea     	add	w10, w15, #0x1
40005d0c: 3900098b     	strb	w11, [x12, #0x2]
40005d10: 3900153f     	strb	wzr, [x9, #0x5]
40005d14: 3900113f     	strb	wzr, [x9, #0x4]
40005d18: 53087d49     	lsr	w9, w10, #8
40005d1c: 791ab9ca     	strh	w10, [x14, #0xd5c]
40005d20: 390009aa     	strb	w10, [x13, #0x2]
40005d24: 39000da9     	strb	w9, [x13, #0x3]
40005d28: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005d2c: d5033fbf     	dmb	sy
40005d30: f9469508     	ldr	x8, [x8, #0xd28]
40005d34: b900511f     	str	wzr, [x8, #0x50]
40005d38: f946a128     	ldr	x8, [x9, #0xd40]
40005d3c: aa0803e9     	mov	x9, x8
40005d40: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005d44: 3940052b     	ldrb	w11, [x9, #0x1]
40005d48: 3940052c     	ldrb	w12, [x9, #0x1]
40005d4c: 3940012d     	ldrb	w13, [x9]
40005d50: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005d54: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005d58: 6b09015f     	cmp	w10, w9
40005d5c: 540002a1     	b.ne	0x40005db0 <virtio_blk_write_sector+0x234>
40005d60: 5292d00a     	mov	w10, #0x9680            // =38528
40005d64: 72a0130a     	movk	w10, #0x98, lsl #16
40005d68: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005d6c: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d70: 71018d7f     	cmp	w11, #0x63
40005d74: 540000ec     	b.gt	0x40005d90 <virtio_blk_write_sector+0x214>
40005d78: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d7c: 1100056b     	add	w11, w11, #0x1
40005d80: b81fc3ab     	stur	w11, [x29, #-0x4]
40005d84: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005d88: 7101917f     	cmp	w11, #0x64
40005d8c: 54ffff6b     	b.lt	0x40005d78 <virtio_blk_write_sector+0x1fc>
40005d90: 39400d0b     	ldrb	w11, [x8, #0x3]
40005d94: 3940090c     	ldrb	w12, [x8, #0x2]
40005d98: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005d9c: 6b09017f     	cmp	w11, w9
40005da0: 54000081     	b.ne	0x40005db0 <virtio_blk_write_sector+0x234>
40005da4: 7100055f     	cmp	w10, #0x1
40005da8: 5100054a     	sub	w10, w10, #0x1
40005dac: 54fffde8     	b.hi	0x40005d68 <virtio_blk_write_sector+0x1ec>
40005db0: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005db4: 3975c109     	ldrb	w9, [x8, #0xd70]
40005db8: 34000129     	cbz	w9, 0x40005ddc <virtio_blk_write_sector+0x260>
40005dbc: 3975c101     	ldrb	w1, [x8, #0xd70]
40005dc0: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005dc4: 912b3c00     	add	x0, x0, #0xacf
40005dc8: 97fff75d     	bl	0x40003b3c <uart_printf>
40005dcc: 2a1f03e0     	mov	w0, wzr
40005dd0: 14000004     	b	0x40005de0 <virtio_blk_write_sector+0x264>
40005dd4: 2a1f03e0     	mov	w0, wzr
40005dd8: d65f03c0     	ret
40005ddc: 52800020     	mov	w0, #0x1                // =1
40005de0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005de4: 910083ff     	add	sp, sp, #0x20
40005de8: d65f03c0     	ret

0000000040005dec <virtio_net_init>:
40005dec: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005df0: 528d2ec9     	mov	w9, #0x6976             // =26998
40005df4: 52a14001     	mov	w1, #0xa000000          // =167772160
40005df8: 52800408     	mov	w8, #0x20               // =32
40005dfc: 72ae8e49     	movk	w9, #0x7472, lsl #16
40005e00: f9000bf3     	str	x19, [sp, #0x10]
40005e04: 910003fd     	mov	x29, sp
40005e08: 14000004     	b	0x40005e18 <virtio_net_init+0x2c>
40005e0c: f1000508     	subs	x8, x8, #0x1
40005e10: 91080021     	add	x1, x1, #0x200
40005e14: 54000180     	b.eq	0x40005e44 <virtio_net_init+0x58>
40005e18: b940002a     	ldr	w10, [x1]
40005e1c: 6b09015f     	cmp	w10, w9
40005e20: 54ffff61     	b.ne	0x40005e0c <virtio_net_init+0x20>
40005e24: b940082a     	ldr	w10, [x1, #0x8]
40005e28: 7100055f     	cmp	w10, #0x1
40005e2c: 54ffff01     	b.ne	0x40005e0c <virtio_net_init+0x20>
40005e30: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005e34: d503201f     	nop
40005e38: 1001afa0     	adr	x0, 0x4000942c <__rodata_start+0x42c>
40005e3c: f906bd01     	str	x1, [x8, #0xd78]
40005e40: 97fff73f     	bl	0x40003b3c <uart_printf>
40005e44: f00001b3     	adrp	x19, 0x4003c000 <memory_bitmap+0x460>
40005e48: f946be68     	ldr	x8, [x19, #0xd78]
40005e4c: b4000308     	cbz	x8, 0x40005eac <virtio_net_init+0xc0>
40005e50: 52800029     	mov	w9, #0x1                // =1
40005e54: 5280006a     	mov	w10, #0x3               // =3
40005e58: b900711f     	str	wzr, [x8, #0x70]
40005e5c: b9007109     	str	w9, [x8, #0x70]
40005e60: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005e64: 9122d000     	add	x0, x0, #0x8b4
40005e68: b900710a     	str	w10, [x8, #0x70]
40005e6c: b9401109     	ldr	w9, [x8, #0x10]
40005e70: 121b0129     	and	w9, w9, #0x20
40005e74: b9002109     	str	w9, [x8, #0x20]
40005e78: 39440101     	ldrb	w1, [x8, #0x100]
40005e7c: 39440502     	ldrb	w2, [x8, #0x101]
40005e80: 39440903     	ldrb	w3, [x8, #0x102]
40005e84: 39440d04     	ldrb	w4, [x8, #0x103]
40005e88: 39441105     	ldrb	w5, [x8, #0x104]
40005e8c: 39441506     	ldrb	w6, [x8, #0x105]
40005e90: 97fff72b     	bl	0x40003b3c <uart_printf>
40005e94: f946be68     	ldr	x8, [x19, #0xd78]
40005e98: 528000e9     	mov	w9, #0x7                // =7
40005e9c: b9007109     	str	w9, [x8, #0x70]
40005ea0: f9400bf3     	ldr	x19, [sp, #0x10]
40005ea4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005ea8: d65f03c0     	ret
40005eac: f9400bf3     	ldr	x19, [sp, #0x10]
40005eb0: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005eb4: 91027000     	add	x0, x0, #0x9c
40005eb8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005ebc: 17fff60b     	b	0x400036e8 <uart_puts>

0000000040005ec0 <fat16_init>:
40005ec0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005ec4: a9014ffc     	stp	x28, x19, [sp, #0x10]
40005ec8: 910003fd     	mov	x29, sp
40005ecc: d10803ff     	sub	sp, sp, #0x200
40005ed0: d503201f     	nop
40005ed4: 10022c00     	adr	x0, 0x4000a454 <__rodata_start+0x1454>
40005ed8: 97fff604     	bl	0x400036e8 <uart_puts>
40005edc: 910003e1     	mov	x1, sp
40005ee0: aa1f03e0     	mov	x0, xzr
40005ee4: 97fffe86     	bl	0x400058fc <virtio_blk_read_sector>
40005ee8: 34000780     	cbz	w0, 0x40005fd8 <fat16_init+0x118>
40005eec: d503201f     	nop
40005ef0: 101b7493     	adr	x19, 0x4003cd80 <bpb>
40005ef4: 910003e1     	mov	x1, sp
40005ef8: aa1303e0     	mov	x0, x19
40005efc: 528007c2     	mov	w2, #0x3e               // =62
40005f00: 97fff2c0     	bl	0x40002a00 <memcpy>
40005f04: b0000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40005f08: 91026821     	add	x1, x1, #0x9a
40005f0c: 9100da60     	add	x0, x19, #0x36
40005f10: 528000a2     	mov	w2, #0x5                // =5
40005f14: 97fff269     	bl	0x400028b8 <kstrncmp>
40005f18: 34000160     	cbz	w0, 0x40005f44 <fat16_init+0x84>
40005f1c: f00001a0     	adrp	x0, 0x4003c000 <memory_bitmap+0x460>
40005f20: 9136d800     	add	x0, x0, #0xdb6
40005f24: b0000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40005f28: 910c3421     	add	x1, x1, #0x30d
40005f2c: 528000a2     	mov	w2, #0x5                // =5
40005f30: 97fff262     	bl	0x400028b8 <kstrncmp>
40005f34: 34000080     	cbz	w0, 0x40005f44 <fat16_init+0x84>
40005f38: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005f3c: 91342000     	add	x0, x0, #0xd08
40005f40: 97fff5ea     	bl	0x400036e8 <uart_puts>
40005f44: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005f48: 91362d08     	add	x8, x8, #0xd8b
40005f4c: f00001b3     	adrp	x19, 0x4003c000 <memory_bitmap+0x460>
40005f50: 39401d09     	ldrb	w9, [x8, #0x7]
40005f54: 3940190a     	ldrb	w10, [x8, #0x6]
40005f58: 3940050b     	ldrb	w11, [x8, #0x1]
40005f5c: 3940010c     	ldrb	w12, [x8]
40005f60: 39400d0d     	ldrb	w13, [x8, #0x3]
40005f64: 39400901     	ldrb	w1, [x8, #0x2]
40005f68: 2a092142     	orr	w2, w10, w9, lsl #8
40005f6c: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005f70: 91283000     	add	x0, x0, #0xa0c
40005f74: 2a0b2189     	orr	w9, w12, w11, lsl #8
40005f78: 3940310b     	ldrb	w11, [x8, #0xc]
40005f7c: 39402d0c     	ldrb	w12, [x8, #0xb]
40005f80: 0b02152a     	add	w10, w9, w2, lsl #5
40005f84: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005f88: 3940150c     	ldrb	w12, [x8, #0x5]
40005f8c: 5100054a     	sub	w10, w10, #0x1
40005f90: 1ac90d49     	sdiv	w9, w10, w9
40005f94: 3940110a     	ldrb	w10, [x8, #0x4]
40005f98: 2a0a21aa     	orr	w10, w13, w10, lsl #8
40005f9c: 1b0c296b     	madd	w11, w11, w12, w10
40005fa0: f00001ac     	adrp	x12, 0x4003c000 <memory_bitmap+0x460>
40005fa4: b90dc18a     	str	w10, [x12, #0xdc0]
40005fa8: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005fac: b90dc54b     	str	w11, [x10, #0xdc4]
40005fb0: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005fb4: b90dc949     	str	w9, [x10, #0xdc8]
40005fb8: 0b0b0129     	add	w9, w9, w11
40005fbc: b90dce69     	str	w9, [x19, #0xdcc]
40005fc0: 97fff6df     	bl	0x40003b3c <uart_printf>
40005fc4: b94dce61     	ldr	w1, [x19, #0xdcc]
40005fc8: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005fcc: 91052c00     	add	x0, x0, #0x14b
40005fd0: 97fff6db     	bl	0x40003b3c <uart_printf>
40005fd4: 14000004     	b	0x40005fe4 <fat16_init+0x124>
40005fd8: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005fdc: 91213400     	add	x0, x0, #0x84d
40005fe0: 97fff5c2     	bl	0x400036e8 <uart_puts>
40005fe4: 910803ff     	add	sp, sp, #0x200
40005fe8: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40005fec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005ff0: d65f03c0     	ret

0000000040005ff4 <fat16_list_root>:
40005ff4: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40005ff8: a9016ffc     	stp	x28, x27, [sp, #0x10]
40005ffc: 910003fd     	mov	x29, sp
40006000: a90267fa     	stp	x26, x25, [sp, #0x20]
40006004: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006008: a90457f6     	stp	x22, x21, [sp, #0x40]
4000600c: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006010: d10843ff     	sub	sp, sp, #0x210
40006014: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40006018: 9121d400     	add	x0, x0, #0x875
4000601c: 97fff5b3     	bl	0x400036e8 <uart_puts>
40006020: d00001b5     	adrp	x21, 0x4003c000 <memory_bitmap+0x460>
40006024: b94dcaa8     	ldr	w8, [x21, #0xdc8]
40006028: 34000ee8     	cbz	w8, 0x40006204 <fat16_list_root+0x210>
4000602c: 2a1f03f6     	mov	w22, wzr
40006030: d00001b7     	adrp	x23, 0x4003c000 <memory_bitmap+0x460>
40006034: 910003f8     	mov	x24, sp
40006038: 90000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
4000603c: 913bb673     	add	x19, x19, #0xeed
40006040: 90000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40006044: 9111ea94     	add	x20, x20, #0x47a
40006048: 528005d9     	mov	w25, #0x2e              // =46
4000604c: 14000005     	b	0x40006060 <fat16_list_root+0x6c>
40006050: b94dcaa8     	ldr	w8, [x21, #0xdc8]
40006054: 110006d6     	add	w22, w22, #0x1
40006058: 6b0802df     	cmp	w22, w8
4000605c: 54000d42     	b.hs	0x40006204 <fat16_list_root+0x210>
40006060: b94dc6e8     	ldr	w8, [x23, #0xdc4]
40006064: 910043e1     	add	x1, sp, #0x10
40006068: 910043fa     	add	x26, sp, #0x10
4000606c: 0b160100     	add	w0, w8, w22
40006070: 97fffe23     	bl	0x400058fc <virtio_blk_read_sector>
40006074: 5280021b     	mov	w27, #0x10              // =16
40006078: 14000010     	b	0x400060b8 <fat16_list_root+0xc4>
4000607c: aa1a03e8     	mov	x8, x26
40006080: 910003e1     	mov	x1, sp
40006084: aa1303e0     	mov	x0, x19
40006088: 3841cd09     	ldrb	w9, [x8, #0x1c]!
4000608c: 3940090a     	ldrb	w10, [x8, #0x2]
40006090: 3940050b     	ldrb	w11, [x8, #0x1]
40006094: 39400d08     	ldrb	w8, [x8, #0x3]
40006098: 53103d4a     	lsl	w10, w10, #16
4000609c: 2a0b2129     	orr	w9, w9, w11, lsl #8
400060a0: 2a086148     	orr	w8, w10, w8, lsl #24
400060a4: 2a090102     	orr	w2, w8, w9
400060a8: 97fff6a5     	bl	0x40003b3c <uart_printf>
400060ac: f100077b     	subs	x27, x27, #0x1
400060b0: 9100835a     	add	x26, x26, #0x20
400060b4: 54fffce0     	b.eq	0x40006050 <fat16_list_root+0x5c>
400060b8: 39400349     	ldrb	w9, [x26]
400060bc: 7103953f     	cmp	w9, #0xe5
400060c0: 54ffff60     	b.eq	0x400060ac <fat16_list_root+0xb8>
400060c4: 34000a09     	cbz	w9, 0x40006204 <fat16_list_root+0x210>
400060c8: 39402f48     	ldrb	w8, [x26, #0xb]
400060cc: 72000d1f     	tst	w8, #0xf
400060d0: 54fffee1     	b.ne	0x400060ac <fat16_list_root+0xb8>
400060d4: 7100813f     	cmp	w9, #0x20
400060d8: 54000061     	b.ne	0x400060e4 <fat16_list_root+0xf0>
400060dc: aa1f03e9     	mov	x9, xzr
400060e0: 14000003     	b	0x400060ec <fat16_list_root+0xf8>
400060e4: 390003e9     	strb	w9, [sp]
400060e8: 52800029     	mov	w9, #0x1                // =1
400060ec: 3940074a     	ldrb	w10, [x26, #0x1]
400060f0: 7100815f     	cmp	w10, #0x20
400060f4: 54000080     	b.eq	0x40006104 <fat16_list_root+0x110>
400060f8: aa09030b     	orr	x11, x24, x9
400060fc: 91000529     	add	x9, x9, #0x1
40006100: 3900016a     	strb	w10, [x11]
40006104: 39400b4a     	ldrb	w10, [x26, #0x2]
40006108: 7100815f     	cmp	w10, #0x20
4000610c: 54000080     	b.eq	0x4000611c <fat16_list_root+0x128>
40006110: aa09030b     	orr	x11, x24, x9
40006114: 91000529     	add	x9, x9, #0x1
40006118: 3900016a     	strb	w10, [x11]
4000611c: 39400f4a     	ldrb	w10, [x26, #0x3]
40006120: 7100815f     	cmp	w10, #0x20
40006124: 54000080     	b.eq	0x40006134 <fat16_list_root+0x140>
40006128: 9100052b     	add	x11, x9, #0x1
4000612c: 38296b0a     	strb	w10, [x24, x9]
40006130: aa0b03e9     	mov	x9, x11
40006134: 3940134a     	ldrb	w10, [x26, #0x4]
40006138: 7100815f     	cmp	w10, #0x20
4000613c: 54000080     	b.eq	0x4000614c <fat16_list_root+0x158>
40006140: 9100052b     	add	x11, x9, #0x1
40006144: 38296b0a     	strb	w10, [x24, x9]
40006148: aa0b03e9     	mov	x9, x11
4000614c: 3940174a     	ldrb	w10, [x26, #0x5]
40006150: 7100815f     	cmp	w10, #0x20
40006154: 54000080     	b.eq	0x40006164 <fat16_list_root+0x170>
40006158: 9100052b     	add	x11, x9, #0x1
4000615c: 38296b0a     	strb	w10, [x24, x9]
40006160: aa0b03e9     	mov	x9, x11
40006164: 39401b4a     	ldrb	w10, [x26, #0x6]
40006168: 7100815f     	cmp	w10, #0x20
4000616c: 54000080     	b.eq	0x4000617c <fat16_list_root+0x188>
40006170: 9100052b     	add	x11, x9, #0x1
40006174: 38296b0a     	strb	w10, [x24, x9]
40006178: aa0b03e9     	mov	x9, x11
4000617c: 39401f4a     	ldrb	w10, [x26, #0x7]
40006180: 7100815f     	cmp	w10, #0x20
40006184: 54000080     	b.eq	0x40006194 <fat16_list_root+0x1a0>
40006188: 9100052b     	add	x11, x9, #0x1
4000618c: 38296b0a     	strb	w10, [x24, x9]
40006190: aa0b03e9     	mov	x9, x11
40006194: 3940234b     	ldrb	w11, [x26, #0x8]
40006198: 7100817f     	cmp	w11, #0x20
4000619c: 540001e0     	b.eq	0x400061d8 <fat16_list_root+0x1e4>
400061a0: 3940274c     	ldrb	w12, [x26, #0x9]
400061a4: 8b09030d     	add	x13, x24, x9
400061a8: 9100092a     	add	x10, x9, #0x2
400061ac: 390001b9     	strb	w25, [x13]
400061b0: 7100819f     	cmp	w12, #0x20
400061b4: 390005ab     	strb	w11, [x13, #0x1]
400061b8: 54000080     	b.eq	0x400061c8 <fat16_list_root+0x1d4>
400061bc: 91000d29     	add	x9, x9, #0x3
400061c0: 382a6b0c     	strb	w12, [x24, x10]
400061c4: aa0903ea     	mov	x10, x9
400061c8: 39402b4b     	ldrb	w11, [x26, #0xa]
400061cc: 7100817f     	cmp	w11, #0x20
400061d0: 54000101     	b.ne	0x400061f0 <fat16_list_root+0x1fc>
400061d4: aa0a03e9     	mov	x9, x10
400061d8: 38296b1f     	strb	wzr, [x24, x9]
400061dc: 3627f508     	tbz	w8, #0x4, 0x4000607c <fat16_list_root+0x88>
400061e0: 910003e1     	mov	x1, sp
400061e4: aa1403e0     	mov	x0, x20
400061e8: 97fff655     	bl	0x40003b3c <uart_printf>
400061ec: 17ffffb0     	b	0x400060ac <fat16_list_root+0xb8>
400061f0: 91000549     	add	x9, x10, #0x1
400061f4: 382a6b0b     	strb	w11, [x24, x10]
400061f8: 38296b1f     	strb	wzr, [x24, x9]
400061fc: 3627f408     	tbz	w8, #0x4, 0x4000607c <fat16_list_root+0x88>
40006200: 17fffff8     	b	0x400061e0 <fat16_list_root+0x1ec>
40006204: 910843ff     	add	sp, sp, #0x210
40006208: a9454ff4     	ldp	x20, x19, [sp, #0x50]
4000620c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006210: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006214: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006218: a9416ffc     	ldp	x28, x27, [sp, #0x10]
4000621c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006220: d65f03c0     	ret

0000000040006224 <fat16_get_next_cluster>:
40006224: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40006228: f9000bfc     	str	x28, [sp, #0x10]
4000622c: 910003fd     	mov	x29, sp
40006230: a9024ff4     	stp	x20, x19, [sp, #0x20]
40006234: d10803ff     	sub	sp, sp, #0x200
40006238: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000623c: 12181c09     	and	w9, w0, #0xff00
40006240: d37f1c13     	ubfiz	x19, x0, #1, #8
40006244: b94dc108     	ldr	w8, [x8, #0xdc0]
40006248: 910003e1     	mov	x1, sp
4000624c: 910003f4     	mov	x20, sp
40006250: 0b492108     	add	w8, w8, w9, lsr #8
40006254: aa0803e0     	mov	x0, x8
40006258: 97fffda9     	bl	0x400058fc <virtio_blk_read_sector>
4000625c: 8b130288     	add	x8, x20, x19
40006260: 39400509     	ldrb	w9, [x8, #0x1]
40006264: 39400108     	ldrb	w8, [x8]
40006268: 2a092100     	orr	w0, w8, w9, lsl #8
4000626c: 910803ff     	add	sp, sp, #0x200
40006270: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40006274: f9400bfc     	ldr	x28, [sp, #0x10]
40006278: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000627c: d65f03c0     	ret

0000000040006280 <fat16_read_file>:
40006280: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006284: a9016ffc     	stp	x28, x27, [sp, #0x10]
40006288: 910003fd     	mov	x29, sp
4000628c: a90267fa     	stp	x26, x25, [sp, #0x20]
40006290: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006294: a90457f6     	stp	x22, x21, [sp, #0x40]
40006298: a9054ff4     	stp	x20, x19, [sp, #0x50]
4000629c: d110c3ff     	sub	sp, sp, #0x430
400062a0: aa0103f3     	mov	x19, x1
400062a4: 910877e1     	add	x1, sp, #0x21d
400062a8: aa0203f5     	mov	x21, x2
400062ac: 94000084     	bl	0x400064bc <to_fat_name>
400062b0: d00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
400062b4: b94dca88     	ldr	w8, [x20, #0xdc8]
400062b8: 34000788     	cbz	w8, 0x400063a8 <fat16_read_file+0x128>
400062bc: 2a1f03f6     	mov	w22, wzr
400062c0: d00001b7     	adrp	x23, 0x4003c000 <memory_bitmap+0x460>
400062c4: 910077f8     	add	x24, sp, #0x1d
400062c8: 14000005     	b	0x400062dc <fat16_read_file+0x5c>
400062cc: b94dca88     	ldr	w8, [x20, #0xdc8]
400062d0: 110006d6     	add	w22, w22, #0x1
400062d4: 6b0802df     	cmp	w22, w8
400062d8: 54000682     	b.hs	0x400063a8 <fat16_read_file+0x128>
400062dc: b94dc6e8     	ldr	w8, [x23, #0xdc4]
400062e0: 910077e1     	add	x1, sp, #0x1d
400062e4: 0b160100     	add	w0, w8, w22
400062e8: 97fffd85     	bl	0x400058fc <virtio_blk_read_sector>
400062ec: aa1f03f9     	mov	x25, xzr
400062f0: 14000004     	b	0x40006300 <fat16_read_file+0x80>
400062f4: 91008339     	add	x25, x25, #0x20
400062f8: f108033f     	cmp	x25, #0x200
400062fc: 54fffe80     	b.eq	0x400062cc <fat16_read_file+0x4c>
40006300: 38796b08     	ldrb	w8, [x24, x25]
40006304: 7103951f     	cmp	w8, #0xe5
40006308: 54ffff60     	b.eq	0x400062f4 <fat16_read_file+0x74>
4000630c: 340004e8     	cbz	w8, 0x400063a8 <fat16_read_file+0x128>
40006310: 8b190308     	add	x8, x24, x25
40006314: 39402d08     	ldrb	w8, [x8, #0xb]
40006318: 7200111f     	tst	w8, #0x1f
4000631c: 54fffec1     	b.ne	0x400062f4 <fat16_read_file+0x74>
40006320: 8b190300     	add	x0, x24, x25
40006324: 910877e1     	add	x1, sp, #0x21d
40006328: 52800162     	mov	w2, #0xb                // =11
4000632c: 97fff163     	bl	0x400028b8 <kstrncmp>
40006330: 35fffe20     	cbnz	w0, 0x400062f4 <fat16_read_file+0x74>
40006334: 910077e8     	add	x8, sp, #0x1d
40006338: 8b190108     	add	x8, x8, x25
4000633c: aa0803e9     	mov	x9, x8
40006340: 3841cd2a     	ldrb	w10, [x9, #0x1c]!
40006344: 3940092b     	ldrb	w11, [x9, #0x2]
40006348: 3940052c     	ldrb	w12, [x9, #0x1]
4000634c: 39400d29     	ldrb	w9, [x9, #0x3]
40006350: d370bd6b     	lsl	x11, x11, #16
40006354: aa0c214a     	orr	x10, x10, x12, lsl #8
40006358: aa096169     	orr	x9, x11, x9, lsl #24
4000635c: aa0a0136     	orr	x22, x9, x10
40006360: 34000a16     	cbz	w22, 0x400064a0 <fat16_read_file+0x220>
40006364: 39406d09     	ldrb	w9, [x8, #0x1b]
40006368: 39406908     	ldrb	w8, [x8, #0x1a]
4000636c: 2a09210a     	orr	w10, w8, w9, lsl #8
40006370: 529ffea9     	mov	w9, #0xfff5             // =65525
40006374: 51000948     	sub	w8, w10, #0x2
40006378: 6b09011f     	cmp	w8, w9
4000637c: 540009a8     	b.hi	0x400064b0 <fat16_read_file+0x230>
40006380: eb1502df     	cmp	x22, x21
40006384: d10006b7     	sub	x23, x21, #0x1
40006388: aa1f03f4     	mov	x20, xzr
4000638c: 9a9532c8     	csel	x8, x22, x21, lo
40006390: eb1702df     	cmp	x22, x23
40006394: d00001bb     	adrp	x27, 0x4003c000 <memory_bitmap+0x460>
40006398: 9a9732d9     	csel	x25, x22, x23, lo
4000639c: 5280401c     	mov	w28, #0x200             // =512
400063a0: f90007e8     	str	x8, [sp, #0x8]
400063a4: 1400001b     	b	0x40006410 <fat16_read_file+0x190>
400063a8: 12800014     	mov	w20, #-0x1              // =-1
400063ac: 2a1403e0     	mov	w0, w20
400063b0: 9110c3ff     	add	sp, sp, #0x430
400063b4: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400063b8: a94457f6     	ldp	x22, x21, [sp, #0x40]
400063bc: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400063c0: a94267fa     	ldp	x26, x25, [sp, #0x20]
400063c4: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400063c8: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400063cc: d65f03c0     	ret
400063d0: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400063d4: f9400be9     	ldr	x9, [sp, #0x10]
400063d8: 9108a3e1     	add	x1, sp, #0x228
400063dc: b94dc108     	ldr	w8, [x8, #0xdc0]
400063e0: d37f1d35     	ubfiz	x21, x9, #1, #8
400063e4: 0b492100     	add	w0, w8, w9, lsr #8
400063e8: 97fffd45     	bl	0x400058fc <virtio_blk_read_sector>
400063ec: 9108a3e8     	add	x8, sp, #0x228
400063f0: 8b150108     	add	x8, x8, x21
400063f4: 39400509     	ldrb	w9, [x8, #0x1]
400063f8: 39400108     	ldrb	w8, [x8]
400063fc: 2a09210a     	orr	w10, w8, w9, lsl #8
40006400: 529ffec9     	mov	w9, #0xfff6             // =65526
40006404: 51000948     	sub	w8, w10, #0x2
40006408: 6b09011f     	cmp	w8, w9
4000640c: 54000542     	b.hs	0x400064b4 <fat16_read_file+0x234>
40006410: f94007e8     	ldr	x8, [sp, #0x8]
40006414: eb08029f     	cmp	x20, x8
40006418: 540004e2     	b.hs	0x400064b4 <fat16_read_file+0x234>
4000641c: 39763768     	ldrb	w8, [x27, #0xd8d]
40006420: f9000bea     	str	x10, [sp, #0x10]
40006424: 34fffd68     	cbz	w8, 0x400063d0 <fat16_read_file+0x150>
40006428: 51000949     	sub	w9, w10, #0x2
4000642c: 52800038     	mov	w24, #0x1               // =1
40006430: 1b087d28     	mul	w8, w9, w8
40006434: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40006438: b94dcd29     	ldr	w9, [x9, #0xdcc]
4000643c: 0b08013a     	add	w26, w9, w8
40006440: 2a1a03e0     	mov	w0, w26
40006444: 910077e1     	add	x1, sp, #0x1d
40006448: 97fffd2d     	bl	0x400058fc <virtio_blk_read_sector>
4000644c: 91080288     	add	x8, x20, #0x200
40006450: cb1402c9     	sub	x9, x22, x20
40006454: cb1402ea     	sub	x10, x23, x20
40006458: eb16011f     	cmp	x8, x22
4000645c: 8b140260     	add	x0, x19, x20
40006460: 910077e1     	add	x1, sp, #0x1d
40006464: 9a9c8128     	csel	x8, x9, x28, hi
40006468: 8b140109     	add	x9, x8, x20
4000646c: eb17013f     	cmp	x9, x23
40006470: 9a888155     	csel	x21, x10, x8, hi
40006474: aa1503e2     	mov	x2, x21
40006478: 97fff162     	bl	0x40002a00 <memcpy>
4000647c: 8b1402b4     	add	x20, x21, x20
40006480: eb19029f     	cmp	x20, x25
40006484: 54fffa62     	b.hs	0x400063d0 <fat16_read_file+0x150>
40006488: 39763768     	ldrb	w8, [x27, #0xd8d]
4000648c: 1100075a     	add	w26, w26, #0x1
40006490: eb08031f     	cmp	x24, x8
40006494: 91000718     	add	x24, x24, #0x1
40006498: 54fffd43     	b.lo	0x40006440 <fat16_read_file+0x1c0>
4000649c: 17ffffcd     	b	0x400063d0 <fat16_read_file+0x150>
400064a0: 2a1f03f4     	mov	w20, wzr
400064a4: b4fff855     	cbz	x21, 0x400063ac <fat16_read_file+0x12c>
400064a8: 3900027f     	strb	wzr, [x19]
400064ac: 17ffffc0     	b	0x400063ac <fat16_read_file+0x12c>
400064b0: aa1f03f4     	mov	x20, xzr
400064b4: 38346a7f     	strb	wzr, [x19, x20]
400064b8: 17ffffbd     	b	0x400063ac <fat16_read_file+0x12c>

00000000400064bc <to_fat_name>:
400064bc: 52800408     	mov	w8, #0x20               // =32
400064c0: 39000028     	strb	w8, [x1]
400064c4: 39000428     	strb	w8, [x1, #0x1]
400064c8: 39000828     	strb	w8, [x1, #0x2]
400064cc: 39000c28     	strb	w8, [x1, #0x3]
400064d0: 39001028     	strb	w8, [x1, #0x4]
400064d4: 39001428     	strb	w8, [x1, #0x5]
400064d8: 39001828     	strb	w8, [x1, #0x6]
400064dc: 39001c28     	strb	w8, [x1, #0x7]
400064e0: 39002028     	strb	w8, [x1, #0x8]
400064e4: 39002428     	strb	w8, [x1, #0x9]
400064e8: 39002828     	strb	w8, [x1, #0xa]
400064ec: 39400009     	ldrb	w9, [x0]
400064f0: 340002a9     	cbz	w9, 0x40006544 <to_fat_name+0x88>
400064f4: aa1f03e8     	mov	x8, xzr
400064f8: 9100040a     	add	x10, x0, #0x1
400064fc: 12001d2b     	and	w11, w9, #0xff
40006500: 7100b97f     	cmp	w11, #0x2e
40006504: 540001c0     	b.eq	0x4000653c <to_fat_name+0x80>
40006508: f1001d1f     	cmp	x8, #0x7
4000650c: 54000188     	b.hi	0x4000653c <to_fat_name+0x80>
40006510: 5101852b     	sub	w11, w9, #0x61
40006514: 5100812c     	sub	w12, w9, #0x20
40006518: 12001d6b     	and	w11, w11, #0xff
4000651c: 7100697f     	cmp	w11, #0x1a
40006520: 9100050b     	add	x11, x8, #0x1
40006524: 1a893189     	csel	w9, w12, w9, lo
40006528: 38286829     	strb	w9, [x1, x8]
4000652c: 38686949     	ldrb	w9, [x10, x8]
40006530: aa0b03e8     	mov	x8, x11
40006534: 35fffe49     	cbnz	w9, 0x400064fc <to_fat_name+0x40>
40006538: 2a0b03e8     	mov	w8, w11
4000653c: 2a0803e9     	mov	w9, w8
40006540: 14000002     	b	0x40006548 <to_fat_name+0x8c>
40006544: aa1f03e9     	mov	x9, xzr
40006548: 8b000128     	add	x8, x9, x0
4000654c: 91000d08     	add	x8, x8, #0x3
40006550: 3869680a     	ldrb	w10, [x0, x9]
40006554: 340000ea     	cbz	w10, 0x40006570 <to_fat_name+0xb4>
40006558: 7100b95f     	cmp	w10, #0x2e
4000655c: 540000c0     	b.eq	0x40006574 <to_fat_name+0xb8>
40006560: 91000529     	add	x9, x9, #0x1
40006564: 91000508     	add	x8, x8, #0x1
40006568: 3869680a     	ldrb	w10, [x0, x9]
4000656c: 35ffff6a     	cbnz	w10, 0x40006558 <to_fat_name+0x9c>
40006570: d65f03c0     	ret
40006574: 11000529     	add	w9, w9, #0x1
40006578: 38694809     	ldrb	w9, [x0, w9, uxtw]
4000657c: 34ffffa9     	cbz	w9, 0x40006570 <to_fat_name+0xb4>
40006580: 5101852a     	sub	w10, w9, #0x61
40006584: 5100812b     	sub	w11, w9, #0x20
40006588: 7100695f     	cmp	w10, #0x1a
4000658c: 1a893169     	csel	w9, w11, w9, lo
40006590: 39002029     	strb	w9, [x1, #0x8]
40006594: 385ff109     	ldurb	w9, [x8, #-0x1]
40006598: 34fffec9     	cbz	w9, 0x40006570 <to_fat_name+0xb4>
4000659c: 5101852a     	sub	w10, w9, #0x61
400065a0: 5100812b     	sub	w11, w9, #0x20
400065a4: 7100695f     	cmp	w10, #0x1a
400065a8: 1a893169     	csel	w9, w11, w9, lo
400065ac: 39002429     	strb	w9, [x1, #0x9]
400065b0: 39400108     	ldrb	w8, [x8]
400065b4: 34fffde8     	cbz	w8, 0x40006570 <to_fat_name+0xb4>
400065b8: 51018509     	sub	w9, w8, #0x61
400065bc: 5100810a     	sub	w10, w8, #0x20
400065c0: 7100693f     	cmp	w9, #0x1a
400065c4: 1a883148     	csel	w8, w10, w8, lo
400065c8: 39002828     	strb	w8, [x1, #0xa]
400065cc: d65f03c0     	ret

00000000400065d0 <fat16_set_fat_entry>:
400065d0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400065d4: f9000bfc     	str	x28, [sp, #0x10]
400065d8: 910003fd     	mov	x29, sp
400065dc: a90257f6     	stp	x22, x21, [sp, #0x20]
400065e0: a9034ff4     	stp	x20, x19, [sp, #0x30]
400065e4: d10803ff     	sub	sp, sp, #0x200
400065e8: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400065ec: 12181c09     	and	w9, w0, #0xff00
400065f0: d37f1c15     	ubfiz	x21, x0, #1, #8
400065f4: b94dc108     	ldr	w8, [x8, #0xdc0]
400065f8: 2a0103f4     	mov	w20, w1
400065fc: 910003e1     	mov	x1, sp
40006600: 910003f6     	mov	x22, sp
40006604: 0b492113     	add	w19, w8, w9, lsr #8
40006608: aa1303e0     	mov	x0, x19
4000660c: 97fffcbc     	bl	0x400058fc <virtio_blk_read_sector>
40006610: 53087e88     	lsr	w8, w20, #8
40006614: 8b1502c9     	add	x9, x22, x21
40006618: 910003e1     	mov	x1, sp
4000661c: aa1303e0     	mov	x0, x19
40006620: 39000134     	strb	w20, [x9]
40006624: 39000528     	strb	w8, [x9, #0x1]
40006628: 97fffd55     	bl	0x40005b7c <virtio_blk_write_sector>
4000662c: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006630: 39764108     	ldrb	w8, [x8, #0xd90]
40006634: 7100091f     	cmp	w8, #0x2
40006638: 540001c3     	b.lo	0x40006670 <fat16_set_fat_entry+0xa0>
4000663c: 52800034     	mov	w20, #0x1               // =1
40006640: d00001b5     	adrp	x21, 0x4003c000 <memory_bitmap+0x460>
40006644: 913642b5     	add	x21, x21, #0xd90
40006648: 39401ea8     	ldrb	w8, [x21, #0x7]
4000664c: 39401aa9     	ldrb	w9, [x21, #0x6]
40006650: 910003e1     	mov	x1, sp
40006654: 2a082128     	orr	w8, w9, w8, lsl #8
40006658: 1b084e80     	madd	w0, w20, w8, w19
4000665c: 97fffd48     	bl	0x40005b7c <virtio_blk_write_sector>
40006660: 394002a8     	ldrb	w8, [x21]
40006664: 11000694     	add	w20, w20, #0x1
40006668: 6b08029f     	cmp	w20, w8
4000666c: 54fffee3     	b.lo	0x40006648 <fat16_set_fat_entry+0x78>
40006670: 910803ff     	add	sp, sp, #0x200
40006674: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40006678: f9400bfc     	ldr	x28, [sp, #0x10]
4000667c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40006680: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40006684: d65f03c0     	ret

0000000040006688 <fat16_allocate_cluster>:
40006688: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
4000668c: f9000bfc     	str	x28, [sp, #0x10]
40006690: 910003fd     	mov	x29, sp
40006694: a9025ff8     	stp	x24, x23, [sp, #0x20]
40006698: a90357f6     	stp	x22, x21, [sp, #0x30]
4000669c: a9044ff4     	stp	x20, x19, [sp, #0x40]
400066a0: d10803ff     	sub	sp, sp, #0x200
400066a4: d00001b6     	adrp	x22, 0x4003c000 <memory_bitmap+0x460>
400066a8: 91365ad6     	add	x22, x22, #0xd96
400066ac: 394006c8     	ldrb	w8, [x22, #0x1]
400066b0: 394002c9     	ldrb	w9, [x22]
400066b4: 2a082128     	orr	w8, w9, w8, lsl #8
400066b8: 340006e8     	cbz	w8, 0x40006794 <fat16_allocate_cluster+0x10c>
400066bc: aa1f03f7     	mov	x23, xzr
400066c0: aa1f03f4     	mov	x20, xzr
400066c4: d00001b5     	adrp	x21, 0x4003c000 <memory_bitmap+0x460>
400066c8: 910003f8     	mov	x24, sp
400066cc: 14000008     	b	0x400066ec <fat16_allocate_cluster+0x64>
400066d0: 394006c8     	ldrb	w8, [x22, #0x1]
400066d4: 394002c9     	ldrb	w9, [x22]
400066d8: 91000694     	add	x20, x20, #0x1
400066dc: 910402f7     	add	x23, x23, #0x100
400066e0: aa082128     	orr	x8, x9, x8, lsl #8
400066e4: eb08029f     	cmp	x20, x8
400066e8: 54000562     	b.hs	0x40006794 <fat16_allocate_cluster+0x10c>
400066ec: b94dc2a8     	ldr	w8, [x21, #0xdc0]
400066f0: 910003e1     	mov	x1, sp
400066f4: 8b080280     	add	x0, x20, x8
400066f8: 97fffc81     	bl	0x400058fc <virtio_blk_read_sector>
400066fc: aa1f03e8     	mov	x8, xzr
40006700: aa1703f3     	mov	x19, x23
40006704: 14000005     	b	0x40006718 <fat16_allocate_cluster+0x90>
40006708: 91000908     	add	x8, x8, #0x2
4000670c: 91000673     	add	x19, x19, #0x1
40006710: f108011f     	cmp	x8, #0x200
40006714: 54fffde0     	b.eq	0x400066d0 <fat16_allocate_cluster+0x48>
40006718: f27f3a7f     	tst	x19, #0xfffe
4000671c: 54ffff60     	b.eq	0x40006708 <fat16_allocate_cluster+0x80>
40006720: 78686b09     	ldrh	w9, [x24, x8]
40006724: 35ffff29     	cbnz	w9, 0x40006708 <fat16_allocate_cluster+0x80>
40006728: b94dc2a9     	ldr	w9, [x21, #0xdc0]
4000672c: 910003ea     	mov	x10, sp
40006730: 910003e1     	mov	x1, sp
40006734: 529fffeb     	mov	w11, #0xffff            // =65535
40006738: 7828694b     	strh	w11, [x10, x8]
4000673c: 0b140120     	add	w0, w9, w20
40006740: 97fffd0f     	bl	0x40005b7c <virtio_blk_write_sector>
40006744: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006748: 39764108     	ldrb	w8, [x8, #0xd90]
4000674c: 7100091f     	cmp	w8, #0x2
40006750: 54000243     	b.lo	0x40006798 <fat16_allocate_cluster+0x110>
40006754: 52800036     	mov	w22, #0x1               // =1
40006758: d00001b7     	adrp	x23, 0x4003c000 <memory_bitmap+0x460>
4000675c: 913642f7     	add	x23, x23, #0xd90
40006760: 39401ee8     	ldrb	w8, [x23, #0x7]
40006764: 39401ae9     	ldrb	w9, [x23, #0x6]
40006768: 910003e1     	mov	x1, sp
4000676c: b94dc2aa     	ldr	w10, [x21, #0xdc0]
40006770: 2a082128     	orr	w8, w9, w8, lsl #8
40006774: 0b140149     	add	w9, w10, w20
40006778: 1b0826c0     	madd	w0, w22, w8, w9
4000677c: 97fffd00     	bl	0x40005b7c <virtio_blk_write_sector>
40006780: 394002e8     	ldrb	w8, [x23]
40006784: 110006d6     	add	w22, w22, #0x1
40006788: 6b0802df     	cmp	w22, w8
4000678c: 54fffea3     	b.lo	0x40006760 <fat16_allocate_cluster+0xd8>
40006790: 14000002     	b	0x40006798 <fat16_allocate_cluster+0x110>
40006794: 2a1f03f3     	mov	w19, wzr
40006798: 2a1303e0     	mov	w0, w19
4000679c: 910803ff     	add	sp, sp, #0x200
400067a0: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400067a4: f9400bfc     	ldr	x28, [sp, #0x10]
400067a8: a94357f6     	ldp	x22, x21, [sp, #0x30]
400067ac: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400067b0: a8c57bfd     	ldp	x29, x30, [sp], #0x50
400067b4: d65f03c0     	ret

00000000400067b8 <fat16_write_file>:
400067b8: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400067bc: a9016ffc     	stp	x28, x27, [sp, #0x10]
400067c0: 910003fd     	mov	x29, sp
400067c4: a90267fa     	stp	x26, x25, [sp, #0x20]
400067c8: a9035ff8     	stp	x24, x23, [sp, #0x30]
400067cc: a90457f6     	stp	x22, x21, [sp, #0x40]
400067d0: a9054ff4     	stp	x20, x19, [sp, #0x50]
400067d4: d11083ff     	sub	sp, sp, #0x420
400067d8: aa0103f4     	mov	x20, x1
400067dc: 910837e1     	add	x1, sp, #0x20d
400067e0: aa0203f3     	mov	x19, x2
400067e4: 97ffff36     	bl	0x400064bc <to_fat_name>
400067e8: d00001b6     	adrp	x22, 0x4003c000 <memory_bitmap+0x460>
400067ec: b94dcac8     	ldr	w8, [x22, #0xdc8]
400067f0: 34000d48     	cbz	w8, 0x40006998 <fat16_write_file+0x1e0>
400067f4: aa1f03f5     	mov	x21, xzr
400067f8: 2a1f03f8     	mov	w24, wzr
400067fc: 2a1f03f7     	mov	w23, wzr
40006800: d00001b9     	adrp	x25, 0x4003c000 <memory_bitmap+0x460>
40006804: 910033fa     	add	x26, sp, #0xc
40006808: 1400000b     	b	0x40006834 <fat16_write_file+0x7c>
4000680c: b40000d5     	cbz	x21, 0x40006824 <fat16_write_file+0x6c>
40006810: 910837e1     	add	x1, sp, #0x20d
40006814: aa1503e0     	mov	x0, x21
40006818: 52800162     	mov	w2, #0xb                // =11
4000681c: 97fff027     	bl	0x400028b8 <kstrncmp>
40006820: 34000480     	cbz	w0, 0x400068b0 <fat16_write_file+0xf8>
40006824: b94dcac8     	ldr	w8, [x22, #0xdc8]
40006828: 110006f7     	add	w23, w23, #0x1
4000682c: 6b0802ff     	cmp	w23, w8
40006830: 540003e2     	b.hs	0x400068ac <fat16_write_file+0xf4>
40006834: b94dc728     	ldr	w8, [x25, #0xdc4]
40006838: 910033e1     	add	x1, sp, #0xc
4000683c: 0b170100     	add	w0, w8, w23
40006840: 97fffc2f     	bl	0x400058fc <virtio_blk_read_sector>
40006844: aa1f03fb     	mov	x27, xzr
40006848: 14000008     	b	0x40006868 <fat16_write_file+0xb0>
4000684c: 910837e1     	add	x1, sp, #0x20d
40006850: 52800162     	mov	w2, #0xb                // =11
40006854: 97fff019     	bl	0x400028b8 <kstrncmp>
40006858: 340001c0     	cbz	w0, 0x40006890 <fat16_write_file+0xd8>
4000685c: 9100837b     	add	x27, x27, #0x20
40006860: f108037f     	cmp	x27, #0x200
40006864: 54fffd40     	b.eq	0x4000680c <fat16_write_file+0x54>
40006868: 8b1b0340     	add	x0, x26, x27
4000686c: 39400008     	ldrb	w8, [x0]
40006870: 7103951f     	cmp	w8, #0xe5
40006874: 7a401904     	ccmp	w8, #0x0, #0x4, ne
40006878: 54fffea1     	b.ne	0x4000684c <fat16_write_file+0x94>
4000687c: b5ffff15     	cbnz	x21, 0x4000685c <fat16_write_file+0xa4>
40006880: b94dc728     	ldr	w8, [x25, #0xdc4]
40006884: aa0003f5     	mov	x21, x0
40006888: 0b170118     	add	w24, w8, w23
4000688c: 17fffff4     	b	0x4000685c <fat16_write_file+0xa4>
40006890: 8b1b0348     	add	x8, x26, x27
40006894: 39402d09     	ldrb	w9, [x8, #0xb]
40006898: 3727fe29     	tbnz	w9, #0x4, 0x4000685c <fat16_write_file+0xa4>
4000689c: b94dc729     	ldr	w9, [x25, #0xdc4]
400068a0: aa0803f5     	mov	x21, x8
400068a4: 0b170138     	add	w24, w9, w23
400068a8: 17ffffda     	b	0x40006810 <fat16_write_file+0x58>
400068ac: b4000775     	cbz	x21, 0x40006998 <fat16_write_file+0x1e0>
400068b0: 910837e1     	add	x1, sp, #0x20d
400068b4: aa1503e0     	mov	x0, x21
400068b8: 52800162     	mov	w2, #0xb                // =11
400068bc: b90007f8     	str	w24, [sp, #0x4]
400068c0: 97ffeffe     	bl	0x400028b8 <kstrncmp>
400068c4: d00001bb     	adrp	x27, 0x4003c000 <memory_bitmap+0x460>
400068c8: 9136437b     	add	x27, x27, #0xd90
400068cc: 350006a0     	cbnz	w0, 0x400069a0 <fat16_write_file+0x1e8>
400068d0: 39406ea8     	ldrb	w8, [x21, #0x1b]
400068d4: 39406aa9     	ldrb	w9, [x21, #0x1a]
400068d8: 529ffeaa     	mov	w10, #0xfff5            // =65525
400068dc: 2a082128     	orr	w8, w9, w8, lsl #8
400068e0: 51000909     	sub	w9, w8, #0x2
400068e4: 6b0a013f     	cmp	w9, w10
400068e8: 540005c8     	b.hi	0x400069a0 <fat16_write_file+0x1e8>
400068ec: 910863f6     	add	x22, sp, #0x218
400068f0: 529ffed7     	mov	w23, #0xfff6            // =65526
400068f4: 14000005     	b	0x40006908 <fat16_write_file+0x150>
400068f8: 2a182328     	orr	w8, w25, w24, lsl #8
400068fc: 51000909     	sub	w9, w8, #0x2
40006900: 6b17013f     	cmp	w9, w23
40006904: 540004e2     	b.hs	0x400069a0 <fat16_write_file+0x1e8>
40006908: d00001b9     	adrp	x25, 0x4003c000 <memory_bitmap+0x460>
4000690c: 53087d15     	lsr	w21, w8, #8
40006910: 910863e1     	add	x1, sp, #0x218
40006914: b94dc329     	ldr	w9, [x25, #0xdc0]
40006918: d37f1d18     	ubfiz	x24, x8, #1, #8
4000691c: 0b150120     	add	w0, w9, w21
40006920: 97fffbf7     	bl	0x400058fc <virtio_blk_read_sector>
40006924: b94dc328     	ldr	w8, [x25, #0xdc0]
40006928: 8b1802da     	add	x26, x22, x24
4000692c: 910863e1     	add	x1, sp, #0x218
40006930: 39400758     	ldrb	w24, [x26, #0x1]
40006934: 39400359     	ldrb	w25, [x26]
40006938: 0b150115     	add	w21, w8, w21
4000693c: aa1503e0     	mov	x0, x21
40006940: 97fffbef     	bl	0x400058fc <virtio_blk_read_sector>
40006944: 910863e1     	add	x1, sp, #0x218
40006948: aa1503e0     	mov	x0, x21
4000694c: 3900075f     	strb	wzr, [x26, #0x1]
40006950: 3900035f     	strb	wzr, [x26]
40006954: 97fffc8a     	bl	0x40005b7c <virtio_blk_write_sector>
40006958: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000695c: 39764108     	ldrb	w8, [x8, #0xd90]
40006960: 7100091f     	cmp	w8, #0x2
40006964: 54fffca3     	b.lo	0x400068f8 <fat16_write_file+0x140>
40006968: 5280003a     	mov	w26, #0x1               // =1
4000696c: 39401f68     	ldrb	w8, [x27, #0x7]
40006970: 39401b69     	ldrb	w9, [x27, #0x6]
40006974: 910863e1     	add	x1, sp, #0x218
40006978: 2a082128     	orr	w8, w9, w8, lsl #8
4000697c: 1b085740     	madd	w0, w26, w8, w21
40006980: 97fffc7f     	bl	0x40005b7c <virtio_blk_write_sector>
40006984: 39400368     	ldrb	w8, [x27]
40006988: 1100075a     	add	w26, w26, #0x1
4000698c: 6b08035f     	cmp	w26, w8
40006990: 54fffee3     	b.lo	0x4000696c <fat16_write_file+0x1b4>
40006994: 17ffffd9     	b	0x400068f8 <fat16_write_file+0x140>
40006998: 12800013     	mov	w19, #-0x1              // =-1
4000699c: 14000131     	b	0x40006e60 <fat16_write_file+0x6a8>
400069a0: 2a1f03f6     	mov	w22, wzr
400069a4: 2a1f03f5     	mov	w21, wzr
400069a8: aa1f03fc     	mov	x28, xzr
400069ac: d00001ba     	adrp	x26, 0x4003c000 <memory_bitmap+0x460>
400069b0: 52804019     	mov	w25, #0x200             // =512
400069b4: 14000003     	b	0x400069c0 <fat16_write_file+0x208>
400069b8: b9400bf6     	ldr	w22, [sp, #0x8]
400069bc: b4000a13     	cbz	x19, 0x40006afc <fat16_write_file+0x344>
400069c0: 72003edf     	tst	w22, #0xffff
400069c4: 2a1503f8     	mov	w24, w21
400069c8: fa400a60     	ccmp	x19, #0x0, #0x0, eq
400069cc: 1a9f17e8     	cset	w8, eq
400069d0: eb13039f     	cmp	x28, x19
400069d4: 54000043     	b.lo	0x400069dc <fat16_write_file+0x224>
400069d8: 34000928     	cbz	w8, 0x40006afc <fat16_write_file+0x344>
400069dc: 97ffff2b     	bl	0x40006688 <fat16_allocate_cluster>
400069e0: 72003c17     	ands	w23, w0, #0xffff
400069e4: 540020e0     	b.eq	0x40006e00 <fat16_write_file+0x648>
400069e8: 72003edf     	tst	w22, #0xffff
400069ec: 2a0003f5     	mov	w21, w0
400069f0: 1a960016     	csel	w22, w0, w22, eq
400069f4: 72003f1f     	tst	w24, #0xffff
400069f8: b9000bf6     	str	w22, [sp, #0x8]
400069fc: 54000400     	b.eq	0x40006a7c <fat16_write_file+0x2c4>
40006a00: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006a04: 12181f09     	and	w9, w24, #0xff00
40006a08: 910863e1     	add	x1, sp, #0x218
40006a0c: b94dc108     	ldr	w8, [x8, #0xdc0]
40006a10: d37f1f18     	ubfiz	x24, x24, #1, #8
40006a14: 0b492116     	add	w22, w8, w9, lsr #8
40006a18: aa1603e0     	mov	x0, x22
40006a1c: 97fffbb8     	bl	0x400058fc <virtio_blk_read_sector>
40006a20: 53087ea8     	lsr	w8, w21, #8
40006a24: 910863e9     	add	x9, sp, #0x218
40006a28: 910863e1     	add	x1, sp, #0x218
40006a2c: 8b180129     	add	x9, x9, x24
40006a30: aa1603e0     	mov	x0, x22
40006a34: 39000528     	strb	w8, [x9, #0x1]
40006a38: 39000135     	strb	w21, [x9]
40006a3c: 97fffc50     	bl	0x40005b7c <virtio_blk_write_sector>
40006a40: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006a44: 39764108     	ldrb	w8, [x8, #0xd90]
40006a48: 7100091f     	cmp	w8, #0x2
40006a4c: 54000183     	b.lo	0x40006a7c <fat16_write_file+0x2c4>
40006a50: 52800038     	mov	w24, #0x1               // =1
40006a54: 39401f68     	ldrb	w8, [x27, #0x7]
40006a58: 39401b69     	ldrb	w9, [x27, #0x6]
40006a5c: 910863e1     	add	x1, sp, #0x218
40006a60: 2a082128     	orr	w8, w9, w8, lsl #8
40006a64: 1b085b00     	madd	w0, w24, w8, w22
40006a68: 97fffc45     	bl	0x40005b7c <virtio_blk_write_sector>
40006a6c: 39400368     	ldrb	w8, [x27]
40006a70: 11000718     	add	w24, w24, #0x1
40006a74: 6b08031f     	cmp	w24, w8
40006a78: 54fffee3     	b.lo	0x40006a54 <fat16_write_file+0x29c>
40006a7c: 39763748     	ldrb	w8, [x26, #0xd8d]
40006a80: 34fff9c8     	cbz	w8, 0x400069b8 <fat16_write_file+0x200>
40006a84: 51000ae9     	sub	w9, w23, #0x2
40006a88: 52800038     	mov	w24, #0x1               // =1
40006a8c: 1b087d28     	mul	w8, w9, w8
40006a90: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40006a94: b94dcd29     	ldr	w9, [x9, #0xdcc]
40006a98: 0b080137     	add	w23, w9, w8
40006a9c: 91080388     	add	x8, x28, #0x200
40006aa0: cb1c0269     	sub	x9, x19, x28
40006aa4: 910033e0     	add	x0, sp, #0xc
40006aa8: eb13011f     	cmp	x8, x19
40006aac: 2a1f03e1     	mov	w1, wzr
40006ab0: 52804002     	mov	w2, #0x200              // =512
40006ab4: 9a998136     	csel	x22, x9, x25, hi
40006ab8: 97ffefbc     	bl	0x400029a8 <memset>
40006abc: 910033e0     	add	x0, sp, #0xc
40006ac0: 8b1c0281     	add	x1, x20, x28
40006ac4: aa1603e2     	mov	x2, x22
40006ac8: 97ffefce     	bl	0x40002a00 <memcpy>
40006acc: 2a1703e0     	mov	w0, w23
40006ad0: 910033e1     	add	x1, sp, #0xc
40006ad4: 97fffc2a     	bl	0x40005b7c <virtio_blk_write_sector>
40006ad8: 8b1c02dc     	add	x28, x22, x28
40006adc: eb13039f     	cmp	x28, x19
40006ae0: 54fff6c2     	b.hs	0x400069b8 <fat16_write_file+0x200>
40006ae4: 39763748     	ldrb	w8, [x26, #0xd8d]
40006ae8: 110006f7     	add	w23, w23, #0x1
40006aec: eb08031f     	cmp	x24, x8
40006af0: 91000718     	add	x24, x24, #0x1
40006af4: 54fffd43     	b.lo	0x40006a9c <fat16_write_file+0x2e4>
40006af8: 17ffffb0     	b	0x400069b8 <fat16_write_file+0x200>
40006afc: b94007e8     	ldr	w8, [sp, #0x4]
40006b00: 910033e1     	add	x1, sp, #0xc
40006b04: 910033f5     	add	x21, sp, #0xc
40006b08: 2a0803f4     	mov	w20, w8
40006b0c: aa1403e0     	mov	x0, x20
40006b10: 97fffb7b     	bl	0x400058fc <virtio_blk_read_sector>
40006b14: 910033e0     	add	x0, sp, #0xc
40006b18: 910837e1     	add	x1, sp, #0x20d
40006b1c: 52800162     	mov	w2, #0xb                // =11
40006b20: 97ffef66     	bl	0x400028b8 <kstrncmp>
40006b24: 34001740     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006b28: 394033e8     	ldrb	w8, [sp, #0xc]
40006b2c: 910033f5     	add	x21, sp, #0xc
40006b30: 7103951f     	cmp	w8, #0xe5
40006b34: 540016c0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006b38: 340016a8     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006b3c: 910033e8     	add	x8, sp, #0xc
40006b40: 910837e1     	add	x1, sp, #0x20d
40006b44: 52800162     	mov	w2, #0xb                // =11
40006b48: 91008115     	add	x21, x8, #0x20
40006b4c: aa1503e0     	mov	x0, x21
40006b50: 97ffef5a     	bl	0x400028b8 <kstrncmp>
40006b54: 340015c0     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006b58: 3940b3e8     	ldrb	w8, [sp, #0x2c]
40006b5c: 34001588     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006b60: 7103951f     	cmp	w8, #0xe5
40006b64: 54001540     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006b68: 910033e8     	add	x8, sp, #0xc
40006b6c: 910837e1     	add	x1, sp, #0x20d
40006b70: 52800162     	mov	w2, #0xb                // =11
40006b74: 91010115     	add	x21, x8, #0x40
40006b78: aa1503e0     	mov	x0, x21
40006b7c: 97ffef4f     	bl	0x400028b8 <kstrncmp>
40006b80: 34001460     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006b84: 394133e8     	ldrb	w8, [sp, #0x4c]
40006b88: 34001428     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006b8c: 7103951f     	cmp	w8, #0xe5
40006b90: 540013e0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006b94: 910033e8     	add	x8, sp, #0xc
40006b98: 910837e1     	add	x1, sp, #0x20d
40006b9c: 52800162     	mov	w2, #0xb                // =11
40006ba0: 91018115     	add	x21, x8, #0x60
40006ba4: aa1503e0     	mov	x0, x21
40006ba8: 97ffef44     	bl	0x400028b8 <kstrncmp>
40006bac: 34001300     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006bb0: 3941b3e8     	ldrb	w8, [sp, #0x6c]
40006bb4: 340012c8     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006bb8: 7103951f     	cmp	w8, #0xe5
40006bbc: 54001280     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006bc0: 910033e8     	add	x8, sp, #0xc
40006bc4: 910837e1     	add	x1, sp, #0x20d
40006bc8: 52800162     	mov	w2, #0xb                // =11
40006bcc: 91020115     	add	x21, x8, #0x80
40006bd0: aa1503e0     	mov	x0, x21
40006bd4: 97ffef39     	bl	0x400028b8 <kstrncmp>
40006bd8: 340011a0     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006bdc: 394233e8     	ldrb	w8, [sp, #0x8c]
40006be0: 34001168     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006be4: 7103951f     	cmp	w8, #0xe5
40006be8: 54001120     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006bec: 910033e8     	add	x8, sp, #0xc
40006bf0: 910837e1     	add	x1, sp, #0x20d
40006bf4: 52800162     	mov	w2, #0xb                // =11
40006bf8: 91028115     	add	x21, x8, #0xa0
40006bfc: aa1503e0     	mov	x0, x21
40006c00: 97ffef2e     	bl	0x400028b8 <kstrncmp>
40006c04: 34001040     	cbz	w0, 0x40006e0c <fat16_write_file+0x654>
40006c08: 3942b3e8     	ldrb	w8, [sp, #0xac]
40006c0c: 34001008     	cbz	w8, 0x40006e0c <fat16_write_file+0x654>
40006c10: 7103951f     	cmp	w8, #0xe5
40006c14: 54000fc0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006c18: 910033e8     	add	x8, sp, #0xc
40006c1c: 910837e1     	add	x1, sp, #0x20d
40006c20: 52800162     	mov	w2, #0xb                // =11
40006c24: 91030115     	add	x21, x8, #0xc0
40006c28: 2a1603f7     	mov	w23, w22
40006c2c: aa1503e0     	mov	x0, x21
40006c30: 97ffef22     	bl	0x400028b8 <kstrncmp>
40006c34: 34000ea0     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006c38: 394333e8     	ldrb	w8, [sp, #0xcc]
40006c3c: 34000e68     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006c40: 7103951f     	cmp	w8, #0xe5
40006c44: 2a1703f6     	mov	w22, w23
40006c48: 54000e20     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006c4c: 910033e8     	add	x8, sp, #0xc
40006c50: 910837e1     	add	x1, sp, #0x20d
40006c54: 52800162     	mov	w2, #0xb                // =11
40006c58: 91038115     	add	x21, x8, #0xe0
40006c5c: aa1503e0     	mov	x0, x21
40006c60: 97ffef16     	bl	0x400028b8 <kstrncmp>
40006c64: 34000d20     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006c68: 3943b3e8     	ldrb	w8, [sp, #0xec]
40006c6c: 34000ce8     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006c70: 7103951f     	cmp	w8, #0xe5
40006c74: 2a1703f6     	mov	w22, w23
40006c78: 54000ca0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006c7c: 910033e8     	add	x8, sp, #0xc
40006c80: 910837e1     	add	x1, sp, #0x20d
40006c84: 52800162     	mov	w2, #0xb                // =11
40006c88: 91040115     	add	x21, x8, #0x100
40006c8c: aa1503e0     	mov	x0, x21
40006c90: 97ffef0a     	bl	0x400028b8 <kstrncmp>
40006c94: 34000ba0     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006c98: 394433e8     	ldrb	w8, [sp, #0x10c]
40006c9c: 34000b68     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006ca0: 7103951f     	cmp	w8, #0xe5
40006ca4: 2a1703f6     	mov	w22, w23
40006ca8: 54000b20     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006cac: 910033e8     	add	x8, sp, #0xc
40006cb0: 910837e1     	add	x1, sp, #0x20d
40006cb4: 52800162     	mov	w2, #0xb                // =11
40006cb8: 91048115     	add	x21, x8, #0x120
40006cbc: aa1503e0     	mov	x0, x21
40006cc0: 97ffeefe     	bl	0x400028b8 <kstrncmp>
40006cc4: 34000a20     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006cc8: 3944b3e8     	ldrb	w8, [sp, #0x12c]
40006ccc: 340009e8     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006cd0: 7103951f     	cmp	w8, #0xe5
40006cd4: 2a1703f6     	mov	w22, w23
40006cd8: 540009a0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006cdc: 910033e8     	add	x8, sp, #0xc
40006ce0: 910837e1     	add	x1, sp, #0x20d
40006ce4: 52800162     	mov	w2, #0xb                // =11
40006ce8: 91050115     	add	x21, x8, #0x140
40006cec: aa1503e0     	mov	x0, x21
40006cf0: 97ffeef2     	bl	0x400028b8 <kstrncmp>
40006cf4: 340008a0     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006cf8: 394533e8     	ldrb	w8, [sp, #0x14c]
40006cfc: 34000868     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006d00: 7103951f     	cmp	w8, #0xe5
40006d04: 2a1703f6     	mov	w22, w23
40006d08: 54000820     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006d0c: 910033e8     	add	x8, sp, #0xc
40006d10: 910837e1     	add	x1, sp, #0x20d
40006d14: 52800162     	mov	w2, #0xb                // =11
40006d18: 91058115     	add	x21, x8, #0x160
40006d1c: aa1503e0     	mov	x0, x21
40006d20: 97ffeee6     	bl	0x400028b8 <kstrncmp>
40006d24: 34000720     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006d28: 3945b3e8     	ldrb	w8, [sp, #0x16c]
40006d2c: 340006e8     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006d30: 7103951f     	cmp	w8, #0xe5
40006d34: 2a1703f6     	mov	w22, w23
40006d38: 540006a0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006d3c: 910033e8     	add	x8, sp, #0xc
40006d40: 910837e1     	add	x1, sp, #0x20d
40006d44: 52800162     	mov	w2, #0xb                // =11
40006d48: 91060115     	add	x21, x8, #0x180
40006d4c: aa1503e0     	mov	x0, x21
40006d50: 97ffeeda     	bl	0x400028b8 <kstrncmp>
40006d54: 340005a0     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006d58: 394633e8     	ldrb	w8, [sp, #0x18c]
40006d5c: 34000568     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006d60: 7103951f     	cmp	w8, #0xe5
40006d64: 2a1703f6     	mov	w22, w23
40006d68: 54000520     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006d6c: 910033e8     	add	x8, sp, #0xc
40006d70: 910837e1     	add	x1, sp, #0x20d
40006d74: 52800162     	mov	w2, #0xb                // =11
40006d78: 91068115     	add	x21, x8, #0x1a0
40006d7c: aa1503e0     	mov	x0, x21
40006d80: 97ffeece     	bl	0x400028b8 <kstrncmp>
40006d84: 34000420     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006d88: 3946b3e8     	ldrb	w8, [sp, #0x1ac]
40006d8c: 340003e8     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006d90: 7103951f     	cmp	w8, #0xe5
40006d94: 2a1703f6     	mov	w22, w23
40006d98: 540003a0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006d9c: 910033e8     	add	x8, sp, #0xc
40006da0: 910837e1     	add	x1, sp, #0x20d
40006da4: 52800162     	mov	w2, #0xb                // =11
40006da8: 91070115     	add	x21, x8, #0x1c0
40006dac: aa1503e0     	mov	x0, x21
40006db0: 97ffeec2     	bl	0x400028b8 <kstrncmp>
40006db4: 340002a0     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006db8: 394733e8     	ldrb	w8, [sp, #0x1cc]
40006dbc: 34000268     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006dc0: 7103951f     	cmp	w8, #0xe5
40006dc4: 2a1703f6     	mov	w22, w23
40006dc8: 54000220     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006dcc: 910033e8     	add	x8, sp, #0xc
40006dd0: 910837e1     	add	x1, sp, #0x20d
40006dd4: 52800162     	mov	w2, #0xb                // =11
40006dd8: 91078115     	add	x21, x8, #0x1e0
40006ddc: aa1503e0     	mov	x0, x21
40006de0: 97ffeeb6     	bl	0x400028b8 <kstrncmp>
40006de4: 34000120     	cbz	w0, 0x40006e08 <fat16_write_file+0x650>
40006de8: 3947b3e8     	ldrb	w8, [sp, #0x1ec]
40006dec: 340000e8     	cbz	w8, 0x40006e08 <fat16_write_file+0x650>
40006df0: 7103951f     	cmp	w8, #0xe5
40006df4: 2a1703f6     	mov	w22, w23
40006df8: 540000a0     	b.eq	0x40006e0c <fat16_write_file+0x654>
40006dfc: 14000019     	b	0x40006e60 <fat16_write_file+0x6a8>
40006e00: 12800033     	mov	w19, #-0x2              // =-2
40006e04: 14000017     	b	0x40006e60 <fat16_write_file+0x6a8>
40006e08: 2a1703f6     	mov	w22, w23
40006e0c: 910837e1     	add	x1, sp, #0x20d
40006e10: aa1503e0     	mov	x0, x21
40006e14: 52800162     	mov	w2, #0xb                // =11
40006e18: 97ffeebf     	bl	0x40002914 <kstrncpy>
40006e1c: 52800408     	mov	w8, #0x20               // =32
40006e20: 3801ceb3     	strb	w19, [x21, #0x1c]!
40006e24: 53087ec9     	lsr	w9, w22, #8
40006e28: 381ef2a8     	sturb	w8, [x21, #-0x11]
40006e2c: 53187e68     	lsr	w8, w19, #24
40006e30: 910033e1     	add	x1, sp, #0xc
40006e34: aa1403e0     	mov	x0, x20
40006e38: 381fe2b6     	sturb	w22, [x21, #-0x2]
40006e3c: 381ff2a9     	sturb	w9, [x21, #-0x1]
40006e40: 53107e69     	lsr	w9, w19, #16
40006e44: 39000ea8     	strb	w8, [x21, #0x3]
40006e48: 53087e68     	lsr	w8, w19, #8
40006e4c: 381f92bf     	sturb	wzr, [x21, #-0x7]
40006e50: 381f82bf     	sturb	wzr, [x21, #-0x8]
40006e54: 39000aa9     	strb	w9, [x21, #0x2]
40006e58: 390006a8     	strb	w8, [x21, #0x1]
40006e5c: 97fffb48     	bl	0x40005b7c <virtio_blk_write_sector>
40006e60: 2a1303e0     	mov	w0, w19
40006e64: 911083ff     	add	sp, sp, #0x420
40006e68: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006e6c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006e70: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006e74: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006e78: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006e7c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006e80: d65f03c0     	ret

0000000040006e84 <fat16_populate_vfs>:
40006e84: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006e88: f9000bfc     	str	x28, [sp, #0x10]
40006e8c: 910003fd     	mov	x29, sp
40006e90: a90267fa     	stp	x26, x25, [sp, #0x20]
40006e94: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006e98: a90457f6     	stp	x22, x21, [sp, #0x40]
40006e9c: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006ea0: d11843ff     	sub	sp, sp, #0x610
40006ea4: d00001b3     	adrp	x19, 0x4003c000 <memory_bitmap+0x460>
40006ea8: b94dca68     	ldr	w8, [x19, #0xdc8]
40006eac: 34000d68     	cbz	w8, 0x40007058 <fat16_populate_vfs+0x1d4>
40006eb0: 911043e8     	add	x8, sp, #0x410
40006eb4: 2a1f03f4     	mov	w20, wzr
40006eb8: d00001b6     	adrp	x22, 0x4003c000 <memory_bitmap+0x460>
40006ebc: 91001515     	add	x21, x8, #0x5
40006ec0: 911003f7     	add	x23, sp, #0x400
40006ec4: 528005d8     	mov	w24, #0x2e              // =46
40006ec8: 14000005     	b	0x40006edc <fat16_populate_vfs+0x58>
40006ecc: b94dca68     	ldr	w8, [x19, #0xdc8]
40006ed0: 11000694     	add	w20, w20, #0x1
40006ed4: 6b08029f     	cmp	w20, w8
40006ed8: 54000c02     	b.hs	0x40007058 <fat16_populate_vfs+0x1d4>
40006edc: b94dc6c8     	ldr	w8, [x22, #0xdc4]
40006ee0: 911043e1     	add	x1, sp, #0x410
40006ee4: 0b140100     	add	w0, w8, w20
40006ee8: 97fffa85     	bl	0x400058fc <virtio_blk_read_sector>
40006eec: aa1503f9     	mov	x25, x21
40006ef0: 5280021a     	mov	w26, #0x10              // =16
40006ef4: 14000004     	b	0x40006f04 <fat16_populate_vfs+0x80>
40006ef8: f100075a     	subs	x26, x26, #0x1
40006efc: 91008339     	add	x25, x25, #0x20
40006f00: 54fffe60     	b.eq	0x40006ecc <fat16_populate_vfs+0x48>
40006f04: 385fb328     	ldurb	w8, [x25, #-0x5]
40006f08: 7103951f     	cmp	w8, #0xe5
40006f0c: 54ffff60     	b.eq	0x40006ef8 <fat16_populate_vfs+0x74>
40006f10: 34000a48     	cbz	w8, 0x40007058 <fat16_populate_vfs+0x1d4>
40006f14: 39401b29     	ldrb	w9, [x25, #0x6]
40006f18: 7200113f     	tst	w9, #0x1f
40006f1c: 54fffee1     	b.ne	0x40006ef8 <fat16_populate_vfs+0x74>
40006f20: 7100811f     	cmp	w8, #0x20
40006f24: 54000061     	b.ne	0x40006f30 <fat16_populate_vfs+0xac>
40006f28: aa1f03e8     	mov	x8, xzr
40006f2c: 14000003     	b	0x40006f38 <fat16_populate_vfs+0xb4>
40006f30: 391003e8     	strb	w8, [sp, #0x400]
40006f34: 52800028     	mov	w8, #0x1                // =1
40006f38: 385fc329     	ldurb	w9, [x25, #-0x4]
40006f3c: 7100813f     	cmp	w9, #0x20
40006f40: 54000080     	b.eq	0x40006f50 <fat16_populate_vfs+0xcc>
40006f44: aa0802ea     	orr	x10, x23, x8
40006f48: 91000508     	add	x8, x8, #0x1
40006f4c: 39000149     	strb	w9, [x10]
40006f50: 385fd329     	ldurb	w9, [x25, #-0x3]
40006f54: 7100813f     	cmp	w9, #0x20
40006f58: 54000080     	b.eq	0x40006f68 <fat16_populate_vfs+0xe4>
40006f5c: aa0802ea     	orr	x10, x23, x8
40006f60: 91000508     	add	x8, x8, #0x1
40006f64: 39000149     	strb	w9, [x10]
40006f68: 385fe329     	ldurb	w9, [x25, #-0x2]
40006f6c: 7100813f     	cmp	w9, #0x20
40006f70: 54000080     	b.eq	0x40006f80 <fat16_populate_vfs+0xfc>
40006f74: 9100050a     	add	x10, x8, #0x1
40006f78: 38286ae9     	strb	w9, [x23, x8]
40006f7c: aa0a03e8     	mov	x8, x10
40006f80: 385ff329     	ldurb	w9, [x25, #-0x1]
40006f84: 7100813f     	cmp	w9, #0x20
40006f88: 54000080     	b.eq	0x40006f98 <fat16_populate_vfs+0x114>
40006f8c: 9100050a     	add	x10, x8, #0x1
40006f90: 38286ae9     	strb	w9, [x23, x8]
40006f94: aa0a03e8     	mov	x8, x10
40006f98: 39400329     	ldrb	w9, [x25]
40006f9c: 7100813f     	cmp	w9, #0x20
40006fa0: 54000080     	b.eq	0x40006fb0 <fat16_populate_vfs+0x12c>
40006fa4: 9100050a     	add	x10, x8, #0x1
40006fa8: 38286ae9     	strb	w9, [x23, x8]
40006fac: aa0a03e8     	mov	x8, x10
40006fb0: 39400729     	ldrb	w9, [x25, #0x1]
40006fb4: 7100813f     	cmp	w9, #0x20
40006fb8: 54000080     	b.eq	0x40006fc8 <fat16_populate_vfs+0x144>
40006fbc: 9100050a     	add	x10, x8, #0x1
40006fc0: 38286ae9     	strb	w9, [x23, x8]
40006fc4: aa0a03e8     	mov	x8, x10
40006fc8: 39400b29     	ldrb	w9, [x25, #0x2]
40006fcc: 7100813f     	cmp	w9, #0x20
40006fd0: 54000080     	b.eq	0x40006fe0 <fat16_populate_vfs+0x15c>
40006fd4: 9100050a     	add	x10, x8, #0x1
40006fd8: 38286ae9     	strb	w9, [x23, x8]
40006fdc: aa0a03e8     	mov	x8, x10
40006fe0: 39400f2a     	ldrb	w10, [x25, #0x3]
40006fe4: 7100815f     	cmp	w10, #0x20
40006fe8: 54000240     	b.eq	0x40007030 <fat16_populate_vfs+0x1ac>
40006fec: 3940132b     	ldrb	w11, [x25, #0x4]
40006ff0: 8b0802ec     	add	x12, x23, x8
40006ff4: 91000909     	add	x9, x8, #0x2
40006ff8: 39000198     	strb	w24, [x12]
40006ffc: 7100817f     	cmp	w11, #0x20
40007000: 3900058a     	strb	w10, [x12, #0x1]
40007004: 54000080     	b.eq	0x40007014 <fat16_populate_vfs+0x190>
40007008: 91000d08     	add	x8, x8, #0x3
4000700c: 38296aeb     	strb	w11, [x23, x9]
40007010: aa0803e9     	mov	x9, x8
40007014: 3940172a     	ldrb	w10, [x25, #0x5]
40007018: 7100815f     	cmp	w10, #0x20
4000701c: 54000061     	b.ne	0x40007028 <fat16_populate_vfs+0x1a4>
40007020: aa0903e8     	mov	x8, x9
40007024: 14000003     	b	0x40007030 <fat16_populate_vfs+0x1ac>
40007028: 91000528     	add	x8, x9, #0x1
4000702c: 38296aea     	strb	w10, [x23, x9]
40007030: 911003e0     	add	x0, sp, #0x400
40007034: 910003e1     	mov	x1, sp
40007038: 52808002     	mov	w2, #0x400              // =1024
4000703c: 38286aff     	strb	wzr, [x23, x8]
40007040: 97fffc90     	bl	0x40006280 <fat16_read_file>
40007044: 37fff5a0     	tbnz	w0, #0x1f, 0x40006ef8 <fat16_populate_vfs+0x74>
40007048: 911003e0     	add	x0, sp, #0x400
4000704c: 910003e1     	mov	x1, sp
40007050: 97fff762     	bl	0x40004dd8 <vfs_touch>
40007054: 17ffffa9     	b	0x40006ef8 <fat16_populate_vfs+0x74>
40007058: 911843ff     	add	sp, sp, #0x610
4000705c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40007060: f9400bfc     	ldr	x28, [sp, #0x10]
40007064: a94457f6     	ldp	x22, x21, [sp, #0x40]
40007068: a9435ff8     	ldp	x24, x23, [sp, #0x30]
4000706c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40007070: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40007074: d65f03c0     	ret
		...

0000000040007800 <exception_vector_table>:
40007800: 140001e1     	b	0x40007f84 <handle_sync_invalid>
40007804: d503201f     	nop
40007808: d503201f     	nop
4000780c: d503201f     	nop
40007810: d503201f     	nop
40007814: d503201f     	nop
40007818: d503201f     	nop
4000781c: d503201f     	nop
40007820: d503201f     	nop
40007824: d503201f     	nop
40007828: d503201f     	nop
4000782c: d503201f     	nop
40007830: d503201f     	nop
40007834: d503201f     	nop
40007838: d503201f     	nop
4000783c: d503201f     	nop
40007840: d503201f     	nop
40007844: d503201f     	nop
40007848: d503201f     	nop
4000784c: d503201f     	nop
40007850: d503201f     	nop
40007854: d503201f     	nop
40007858: d503201f     	nop
4000785c: d503201f     	nop
40007860: d503201f     	nop
40007864: d503201f     	nop
40007868: d503201f     	nop
4000786c: d503201f     	nop
40007870: d503201f     	nop
40007874: d503201f     	nop
40007878: d503201f     	nop
4000787c: d503201f     	nop

0000000040007880 <curr_el_sp0_irq>:
40007880: 140001ed     	b	0x40008034 <handle_irq_invalid>
40007884: d503201f     	nop
40007888: d503201f     	nop
4000788c: d503201f     	nop
40007890: d503201f     	nop
40007894: d503201f     	nop
40007898: d503201f     	nop
4000789c: d503201f     	nop
400078a0: d503201f     	nop
400078a4: d503201f     	nop
400078a8: d503201f     	nop
400078ac: d503201f     	nop
400078b0: d503201f     	nop
400078b4: d503201f     	nop
400078b8: d503201f     	nop
400078bc: d503201f     	nop
400078c0: d503201f     	nop
400078c4: d503201f     	nop
400078c8: d503201f     	nop
400078cc: d503201f     	nop
400078d0: d503201f     	nop
400078d4: d503201f     	nop
400078d8: d503201f     	nop
400078dc: d503201f     	nop
400078e0: d503201f     	nop
400078e4: d503201f     	nop
400078e8: d503201f     	nop
400078ec: d503201f     	nop
400078f0: d503201f     	nop
400078f4: d503201f     	nop
400078f8: d503201f     	nop
400078fc: d503201f     	nop

0000000040007900 <curr_el_sp0_fiq>:
40007900: 140001f8     	b	0x400080e0 <handle_fiq_invalid>
40007904: d503201f     	nop
40007908: d503201f     	nop
4000790c: d503201f     	nop
40007910: d503201f     	nop
40007914: d503201f     	nop
40007918: d503201f     	nop
4000791c: d503201f     	nop
40007920: d503201f     	nop
40007924: d503201f     	nop
40007928: d503201f     	nop
4000792c: d503201f     	nop
40007930: d503201f     	nop
40007934: d503201f     	nop
40007938: d503201f     	nop
4000793c: d503201f     	nop
40007940: d503201f     	nop
40007944: d503201f     	nop
40007948: d503201f     	nop
4000794c: d503201f     	nop
40007950: d503201f     	nop
40007954: d503201f     	nop
40007958: d503201f     	nop
4000795c: d503201f     	nop
40007960: d503201f     	nop
40007964: d503201f     	nop
40007968: d503201f     	nop
4000796c: d503201f     	nop
40007970: d503201f     	nop
40007974: d503201f     	nop
40007978: d503201f     	nop
4000797c: d503201f     	nop

0000000040007980 <curr_el_sp0_serror>:
40007980: 14000203     	b	0x4000818c <handle_serror_invalid>
40007984: d503201f     	nop
40007988: d503201f     	nop
4000798c: d503201f     	nop
40007990: d503201f     	nop
40007994: d503201f     	nop
40007998: d503201f     	nop
4000799c: d503201f     	nop
400079a0: d503201f     	nop
400079a4: d503201f     	nop
400079a8: d503201f     	nop
400079ac: d503201f     	nop
400079b0: d503201f     	nop
400079b4: d503201f     	nop
400079b8: d503201f     	nop
400079bc: d503201f     	nop
400079c0: d503201f     	nop
400079c4: d503201f     	nop
400079c8: d503201f     	nop
400079cc: d503201f     	nop
400079d0: d503201f     	nop
400079d4: d503201f     	nop
400079d8: d503201f     	nop
400079dc: d503201f     	nop
400079e0: d503201f     	nop
400079e4: d503201f     	nop
400079e8: d503201f     	nop
400079ec: d503201f     	nop
400079f0: d503201f     	nop
400079f4: d503201f     	nop
400079f8: d503201f     	nop
400079fc: d503201f     	nop

0000000040007a00 <curr_el_spx_sync>:
40007a00: 14000210     	b	0x40008240 <handle_sync_exception_asm>
40007a04: d503201f     	nop
40007a08: d503201f     	nop
40007a0c: d503201f     	nop
40007a10: d503201f     	nop
40007a14: d503201f     	nop
40007a18: d503201f     	nop
40007a1c: d503201f     	nop
40007a20: d503201f     	nop
40007a24: d503201f     	nop
40007a28: d503201f     	nop
40007a2c: d503201f     	nop
40007a30: d503201f     	nop
40007a34: d503201f     	nop
40007a38: d503201f     	nop
40007a3c: d503201f     	nop
40007a40: d503201f     	nop
40007a44: d503201f     	nop
40007a48: d503201f     	nop
40007a4c: d503201f     	nop
40007a50: d503201f     	nop
40007a54: d503201f     	nop
40007a58: d503201f     	nop
40007a5c: d503201f     	nop
40007a60: d503201f     	nop
40007a64: d503201f     	nop
40007a68: d503201f     	nop
40007a6c: d503201f     	nop
40007a70: d503201f     	nop
40007a74: d503201f     	nop
40007a78: d503201f     	nop
40007a7c: d503201f     	nop

0000000040007a80 <curr_el_spx_irq>:
40007a80: 1400021d     	b	0x400082f4 <handle_irq_exception_asm>
40007a84: d503201f     	nop
40007a88: d503201f     	nop
40007a8c: d503201f     	nop
40007a90: d503201f     	nop
40007a94: d503201f     	nop
40007a98: d503201f     	nop
40007a9c: d503201f     	nop
40007aa0: d503201f     	nop
40007aa4: d503201f     	nop
40007aa8: d503201f     	nop
40007aac: d503201f     	nop
40007ab0: d503201f     	nop
40007ab4: d503201f     	nop
40007ab8: d503201f     	nop
40007abc: d503201f     	nop
40007ac0: d503201f     	nop
40007ac4: d503201f     	nop
40007ac8: d503201f     	nop
40007acc: d503201f     	nop
40007ad0: d503201f     	nop
40007ad4: d503201f     	nop
40007ad8: d503201f     	nop
40007adc: d503201f     	nop
40007ae0: d503201f     	nop
40007ae4: d503201f     	nop
40007ae8: d503201f     	nop
40007aec: d503201f     	nop
40007af0: d503201f     	nop
40007af4: d503201f     	nop
40007af8: d503201f     	nop
40007afc: d503201f     	nop

0000000040007b00 <curr_el_spx_fiq>:
40007b00: 14000178     	b	0x400080e0 <handle_fiq_invalid>
40007b04: d503201f     	nop
40007b08: d503201f     	nop
40007b0c: d503201f     	nop
40007b10: d503201f     	nop
40007b14: d503201f     	nop
40007b18: d503201f     	nop
40007b1c: d503201f     	nop
40007b20: d503201f     	nop
40007b24: d503201f     	nop
40007b28: d503201f     	nop
40007b2c: d503201f     	nop
40007b30: d503201f     	nop
40007b34: d503201f     	nop
40007b38: d503201f     	nop
40007b3c: d503201f     	nop
40007b40: d503201f     	nop
40007b44: d503201f     	nop
40007b48: d503201f     	nop
40007b4c: d503201f     	nop
40007b50: d503201f     	nop
40007b54: d503201f     	nop
40007b58: d503201f     	nop
40007b5c: d503201f     	nop
40007b60: d503201f     	nop
40007b64: d503201f     	nop
40007b68: d503201f     	nop
40007b6c: d503201f     	nop
40007b70: d503201f     	nop
40007b74: d503201f     	nop
40007b78: d503201f     	nop
40007b7c: d503201f     	nop

0000000040007b80 <curr_el_spx_serror>:
40007b80: 14000183     	b	0x4000818c <handle_serror_invalid>
40007b84: d503201f     	nop
40007b88: d503201f     	nop
40007b8c: d503201f     	nop
40007b90: d503201f     	nop
40007b94: d503201f     	nop
40007b98: d503201f     	nop
40007b9c: d503201f     	nop
40007ba0: d503201f     	nop
40007ba4: d503201f     	nop
40007ba8: d503201f     	nop
40007bac: d503201f     	nop
40007bb0: d503201f     	nop
40007bb4: d503201f     	nop
40007bb8: d503201f     	nop
40007bbc: d503201f     	nop
40007bc0: d503201f     	nop
40007bc4: d503201f     	nop
40007bc8: d503201f     	nop
40007bcc: d503201f     	nop
40007bd0: d503201f     	nop
40007bd4: d503201f     	nop
40007bd8: d503201f     	nop
40007bdc: d503201f     	nop
40007be0: d503201f     	nop
40007be4: d503201f     	nop
40007be8: d503201f     	nop
40007bec: d503201f     	nop
40007bf0: d503201f     	nop
40007bf4: d503201f     	nop
40007bf8: d503201f     	nop
40007bfc: d503201f     	nop

0000000040007c00 <lower_el_aarch64_sync>:
40007c00: 140000e1     	b	0x40007f84 <handle_sync_invalid>
40007c04: d503201f     	nop
40007c08: d503201f     	nop
40007c0c: d503201f     	nop
40007c10: d503201f     	nop
40007c14: d503201f     	nop
40007c18: d503201f     	nop
40007c1c: d503201f     	nop
40007c20: d503201f     	nop
40007c24: d503201f     	nop
40007c28: d503201f     	nop
40007c2c: d503201f     	nop
40007c30: d503201f     	nop
40007c34: d503201f     	nop
40007c38: d503201f     	nop
40007c3c: d503201f     	nop
40007c40: d503201f     	nop
40007c44: d503201f     	nop
40007c48: d503201f     	nop
40007c4c: d503201f     	nop
40007c50: d503201f     	nop
40007c54: d503201f     	nop
40007c58: d503201f     	nop
40007c5c: d503201f     	nop
40007c60: d503201f     	nop
40007c64: d503201f     	nop
40007c68: d503201f     	nop
40007c6c: d503201f     	nop
40007c70: d503201f     	nop
40007c74: d503201f     	nop
40007c78: d503201f     	nop
40007c7c: d503201f     	nop

0000000040007c80 <lower_el_aarch64_irq>:
40007c80: 140000ed     	b	0x40008034 <handle_irq_invalid>
40007c84: d503201f     	nop
40007c88: d503201f     	nop
40007c8c: d503201f     	nop
40007c90: d503201f     	nop
40007c94: d503201f     	nop
40007c98: d503201f     	nop
40007c9c: d503201f     	nop
40007ca0: d503201f     	nop
40007ca4: d503201f     	nop
40007ca8: d503201f     	nop
40007cac: d503201f     	nop
40007cb0: d503201f     	nop
40007cb4: d503201f     	nop
40007cb8: d503201f     	nop
40007cbc: d503201f     	nop
40007cc0: d503201f     	nop
40007cc4: d503201f     	nop
40007cc8: d503201f     	nop
40007ccc: d503201f     	nop
40007cd0: d503201f     	nop
40007cd4: d503201f     	nop
40007cd8: d503201f     	nop
40007cdc: d503201f     	nop
40007ce0: d503201f     	nop
40007ce4: d503201f     	nop
40007ce8: d503201f     	nop
40007cec: d503201f     	nop
40007cf0: d503201f     	nop
40007cf4: d503201f     	nop
40007cf8: d503201f     	nop
40007cfc: d503201f     	nop

0000000040007d00 <lower_el_aarch64_fiq>:
40007d00: 140000f8     	b	0x400080e0 <handle_fiq_invalid>
40007d04: d503201f     	nop
40007d08: d503201f     	nop
40007d0c: d503201f     	nop
40007d10: d503201f     	nop
40007d14: d503201f     	nop
40007d18: d503201f     	nop
40007d1c: d503201f     	nop
40007d20: d503201f     	nop
40007d24: d503201f     	nop
40007d28: d503201f     	nop
40007d2c: d503201f     	nop
40007d30: d503201f     	nop
40007d34: d503201f     	nop
40007d38: d503201f     	nop
40007d3c: d503201f     	nop
40007d40: d503201f     	nop
40007d44: d503201f     	nop
40007d48: d503201f     	nop
40007d4c: d503201f     	nop
40007d50: d503201f     	nop
40007d54: d503201f     	nop
40007d58: d503201f     	nop
40007d5c: d503201f     	nop
40007d60: d503201f     	nop
40007d64: d503201f     	nop
40007d68: d503201f     	nop
40007d6c: d503201f     	nop
40007d70: d503201f     	nop
40007d74: d503201f     	nop
40007d78: d503201f     	nop
40007d7c: d503201f     	nop

0000000040007d80 <lower_el_aarch64_serror>:
40007d80: 14000103     	b	0x4000818c <handle_serror_invalid>
40007d84: d503201f     	nop
40007d88: d503201f     	nop
40007d8c: d503201f     	nop
40007d90: d503201f     	nop
40007d94: d503201f     	nop
40007d98: d503201f     	nop
40007d9c: d503201f     	nop
40007da0: d503201f     	nop
40007da4: d503201f     	nop
40007da8: d503201f     	nop
40007dac: d503201f     	nop
40007db0: d503201f     	nop
40007db4: d503201f     	nop
40007db8: d503201f     	nop
40007dbc: d503201f     	nop
40007dc0: d503201f     	nop
40007dc4: d503201f     	nop
40007dc8: d503201f     	nop
40007dcc: d503201f     	nop
40007dd0: d503201f     	nop
40007dd4: d503201f     	nop
40007dd8: d503201f     	nop
40007ddc: d503201f     	nop
40007de0: d503201f     	nop
40007de4: d503201f     	nop
40007de8: d503201f     	nop
40007dec: d503201f     	nop
40007df0: d503201f     	nop
40007df4: d503201f     	nop
40007df8: d503201f     	nop
40007dfc: d503201f     	nop

0000000040007e00 <lower_el_aarch32_sync>:
40007e00: 14000061     	b	0x40007f84 <handle_sync_invalid>
40007e04: d503201f     	nop
40007e08: d503201f     	nop
40007e0c: d503201f     	nop
40007e10: d503201f     	nop
40007e14: d503201f     	nop
40007e18: d503201f     	nop
40007e1c: d503201f     	nop
40007e20: d503201f     	nop
40007e24: d503201f     	nop
40007e28: d503201f     	nop
40007e2c: d503201f     	nop
40007e30: d503201f     	nop
40007e34: d503201f     	nop
40007e38: d503201f     	nop
40007e3c: d503201f     	nop
40007e40: d503201f     	nop
40007e44: d503201f     	nop
40007e48: d503201f     	nop
40007e4c: d503201f     	nop
40007e50: d503201f     	nop
40007e54: d503201f     	nop
40007e58: d503201f     	nop
40007e5c: d503201f     	nop
40007e60: d503201f     	nop
40007e64: d503201f     	nop
40007e68: d503201f     	nop
40007e6c: d503201f     	nop
40007e70: d503201f     	nop
40007e74: d503201f     	nop
40007e78: d503201f     	nop
40007e7c: d503201f     	nop

0000000040007e80 <lower_el_aarch32_irq>:
40007e80: 1400006d     	b	0x40008034 <handle_irq_invalid>
40007e84: d503201f     	nop
40007e88: d503201f     	nop
40007e8c: d503201f     	nop
40007e90: d503201f     	nop
40007e94: d503201f     	nop
40007e98: d503201f     	nop
40007e9c: d503201f     	nop
40007ea0: d503201f     	nop
40007ea4: d503201f     	nop
40007ea8: d503201f     	nop
40007eac: d503201f     	nop
40007eb0: d503201f     	nop
40007eb4: d503201f     	nop
40007eb8: d503201f     	nop
40007ebc: d503201f     	nop
40007ec0: d503201f     	nop
40007ec4: d503201f     	nop
40007ec8: d503201f     	nop
40007ecc: d503201f     	nop
40007ed0: d503201f     	nop
40007ed4: d503201f     	nop
40007ed8: d503201f     	nop
40007edc: d503201f     	nop
40007ee0: d503201f     	nop
40007ee4: d503201f     	nop
40007ee8: d503201f     	nop
40007eec: d503201f     	nop
40007ef0: d503201f     	nop
40007ef4: d503201f     	nop
40007ef8: d503201f     	nop
40007efc: d503201f     	nop

0000000040007f00 <lower_el_aarch32_fiq>:
40007f00: 14000078     	b	0x400080e0 <handle_fiq_invalid>
40007f04: d503201f     	nop
40007f08: d503201f     	nop
40007f0c: d503201f     	nop
40007f10: d503201f     	nop
40007f14: d503201f     	nop
40007f18: d503201f     	nop
40007f1c: d503201f     	nop
40007f20: d503201f     	nop
40007f24: d503201f     	nop
40007f28: d503201f     	nop
40007f2c: d503201f     	nop
40007f30: d503201f     	nop
40007f34: d503201f     	nop
40007f38: d503201f     	nop
40007f3c: d503201f     	nop
40007f40: d503201f     	nop
40007f44: d503201f     	nop
40007f48: d503201f     	nop
40007f4c: d503201f     	nop
40007f50: d503201f     	nop
40007f54: d503201f     	nop
40007f58: d503201f     	nop
40007f5c: d503201f     	nop
40007f60: d503201f     	nop
40007f64: d503201f     	nop
40007f68: d503201f     	nop
40007f6c: d503201f     	nop
40007f70: d503201f     	nop
40007f74: d503201f     	nop
40007f78: d503201f     	nop
40007f7c: d503201f     	nop

0000000040007f80 <lower_el_aarch32_serror>:
40007f80: 14000083     	b	0x4000818c <handle_serror_invalid>

0000000040007f84 <handle_sync_invalid>:
40007f84: d10443ff     	sub	sp, sp, #0x110
40007f88: a90007e0     	stp	x0, x1, [sp]
40007f8c: d5384020     	mrs	x0, ELR_EL1
40007f90: d5384001     	mrs	x1, SPSR_EL1
40007f94: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40007f98: a94007e0     	ldp	x0, x1, [sp]
40007f9c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40007fa0: a90217e4     	stp	x4, x5, [sp, #0x20]
40007fa4: a9031fe6     	stp	x6, x7, [sp, #0x30]
40007fa8: a90427e8     	stp	x8, x9, [sp, #0x40]
40007fac: a9052fea     	stp	x10, x11, [sp, #0x50]
40007fb0: a90637ec     	stp	x12, x13, [sp, #0x60]
40007fb4: a9073fee     	stp	x14, x15, [sp, #0x70]
40007fb8: a90847f0     	stp	x16, x17, [sp, #0x80]
40007fbc: a9094ff2     	stp	x18, x19, [sp, #0x90]
40007fc0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40007fc4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40007fc8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40007fcc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40007fd0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40007fd4: f9007bfe     	str	x30, [sp, #0xf0]
40007fd8: 910003e0     	mov	x0, sp
40007fdc: 97ffe055     	bl	0x40000130 <c_handle_sync_invalid>
40007fe0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40007fe4: d5184020     	msr	ELR_EL1, x0
40007fe8: d5184001     	msr	SPSR_EL1, x1
40007fec: a94007e0     	ldp	x0, x1, [sp]
40007ff0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40007ff4: a94217e4     	ldp	x4, x5, [sp, #0x20]
40007ff8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40007ffc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008000: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008004: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008008: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000800c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008010: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008014: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008018: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000801c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008020: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008024: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008028: f9407bfe     	ldr	x30, [sp, #0xf0]
4000802c: 910443ff     	add	sp, sp, #0x110
40008030: d69f03e0     	eret

0000000040008034 <handle_irq_invalid>:
40008034: d10443ff     	sub	sp, sp, #0x110
40008038: a90007e0     	stp	x0, x1, [sp]
4000803c: d5384020     	mrs	x0, ELR_EL1
40008040: d5384001     	mrs	x1, SPSR_EL1
40008044: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008048: a94007e0     	ldp	x0, x1, [sp]
4000804c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40008050: a90217e4     	stp	x4, x5, [sp, #0x20]
40008054: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008058: a90427e8     	stp	x8, x9, [sp, #0x40]
4000805c: a9052fea     	stp	x10, x11, [sp, #0x50]
40008060: a90637ec     	stp	x12, x13, [sp, #0x60]
40008064: a9073fee     	stp	x14, x15, [sp, #0x70]
40008068: a90847f0     	stp	x16, x17, [sp, #0x80]
4000806c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40008070: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008074: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008078: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000807c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40008080: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008084: f9007bfe     	str	x30, [sp, #0xf0]
40008088: 97ffe038     	bl	0x40000168 <c_handle_irq_invalid>
4000808c: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40008090: d5184020     	msr	ELR_EL1, x0
40008094: d5184001     	msr	SPSR_EL1, x1
40008098: a94007e0     	ldp	x0, x1, [sp]
4000809c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400080a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
400080a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400080a8: a94427e8     	ldp	x8, x9, [sp, #0x40]
400080ac: a9452fea     	ldp	x10, x11, [sp, #0x50]
400080b0: a94637ec     	ldp	x12, x13, [sp, #0x60]
400080b4: a9473fee     	ldp	x14, x15, [sp, #0x70]
400080b8: a94847f0     	ldp	x16, x17, [sp, #0x80]
400080bc: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400080c0: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400080c4: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400080c8: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400080cc: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400080d0: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400080d4: f9407bfe     	ldr	x30, [sp, #0xf0]
400080d8: 910443ff     	add	sp, sp, #0x110
400080dc: d69f03e0     	eret

00000000400080e0 <handle_fiq_invalid>:
400080e0: d10443ff     	sub	sp, sp, #0x110
400080e4: a90007e0     	stp	x0, x1, [sp]
400080e8: d5384020     	mrs	x0, ELR_EL1
400080ec: d5384001     	mrs	x1, SPSR_EL1
400080f0: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400080f4: a94007e0     	ldp	x0, x1, [sp]
400080f8: a9010fe2     	stp	x2, x3, [sp, #0x10]
400080fc: a90217e4     	stp	x4, x5, [sp, #0x20]
40008100: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008104: a90427e8     	stp	x8, x9, [sp, #0x40]
40008108: a9052fea     	stp	x10, x11, [sp, #0x50]
4000810c: a90637ec     	stp	x12, x13, [sp, #0x60]
40008110: a9073fee     	stp	x14, x15, [sp, #0x70]
40008114: a90847f0     	stp	x16, x17, [sp, #0x80]
40008118: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000811c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008120: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008124: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40008128: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000812c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008130: f9007bfe     	str	x30, [sp, #0xf0]
40008134: 97ffe013     	bl	0x40000180 <c_handle_fiq_invalid>
40008138: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
4000813c: d5184020     	msr	ELR_EL1, x0
40008140: d5184001     	msr	SPSR_EL1, x1
40008144: a94007e0     	ldp	x0, x1, [sp]
40008148: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000814c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40008150: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008154: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008158: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000815c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008160: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008164: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008168: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000816c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008170: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008174: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008178: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000817c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008180: f9407bfe     	ldr	x30, [sp, #0xf0]
40008184: 910443ff     	add	sp, sp, #0x110
40008188: d69f03e0     	eret

000000004000818c <handle_serror_invalid>:
4000818c: d10443ff     	sub	sp, sp, #0x110
40008190: a90007e0     	stp	x0, x1, [sp]
40008194: d5384020     	mrs	x0, ELR_EL1
40008198: d5384001     	mrs	x1, SPSR_EL1
4000819c: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400081a0: a94007e0     	ldp	x0, x1, [sp]
400081a4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400081a8: a90217e4     	stp	x4, x5, [sp, #0x20]
400081ac: a9031fe6     	stp	x6, x7, [sp, #0x30]
400081b0: a90427e8     	stp	x8, x9, [sp, #0x40]
400081b4: a9052fea     	stp	x10, x11, [sp, #0x50]
400081b8: a90637ec     	stp	x12, x13, [sp, #0x60]
400081bc: a9073fee     	stp	x14, x15, [sp, #0x70]
400081c0: a90847f0     	stp	x16, x17, [sp, #0x80]
400081c4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400081c8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400081cc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400081d0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400081d4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400081d8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400081dc: f9007bfe     	str	x30, [sp, #0xf0]
400081e0: 97ffdfee     	bl	0x40000198 <c_handle_serror_invalid>
400081e4: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400081e8: d5184020     	msr	ELR_EL1, x0
400081ec: d5184001     	msr	SPSR_EL1, x1
400081f0: a94007e0     	ldp	x0, x1, [sp]
400081f4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400081f8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400081fc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008200: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008204: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008208: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000820c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008210: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008214: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008218: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000821c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008220: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008224: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008228: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000822c: f9407bfe     	ldr	x30, [sp, #0xf0]
40008230: 910443ff     	add	sp, sp, #0x110
40008234: d69f03e0     	eret

0000000040008238 <trigger_undefined_instruction>:
40008238: 00000000     	udf	#0x0
4000823c: d65f03c0     	ret

0000000040008240 <handle_sync_exception_asm>:
40008240: d10443ff     	sub	sp, sp, #0x110
40008244: a90007e0     	stp	x0, x1, [sp]
40008248: d5384020     	mrs	x0, ELR_EL1
4000824c: d5384001     	mrs	x1, SPSR_EL1
40008250: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008254: a94007e0     	ldp	x0, x1, [sp]
40008258: a9010fe2     	stp	x2, x3, [sp, #0x10]
4000825c: a90217e4     	stp	x4, x5, [sp, #0x20]
40008260: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008264: a90427e8     	stp	x8, x9, [sp, #0x40]
40008268: a9052fea     	stp	x10, x11, [sp, #0x50]
4000826c: a90637ec     	stp	x12, x13, [sp, #0x60]
40008270: a9073fee     	stp	x14, x15, [sp, #0x70]
40008274: a90847f0     	stp	x16, x17, [sp, #0x80]
40008278: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000827c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008280: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008284: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40008288: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000828c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008290: f9007bfe     	str	x30, [sp, #0xf0]
40008294: 910003e0     	mov	x0, sp
40008298: 97ffdf72     	bl	0x40000060 <handle_sync_exception>
4000829c: 9100001f     	mov	sp, x0
400082a0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400082a4: d5184020     	msr	ELR_EL1, x0
400082a8: d5184001     	msr	SPSR_EL1, x1
400082ac: a94007e0     	ldp	x0, x1, [sp]
400082b0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400082b4: a94217e4     	ldp	x4, x5, [sp, #0x20]
400082b8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400082bc: a94427e8     	ldp	x8, x9, [sp, #0x40]
400082c0: a9452fea     	ldp	x10, x11, [sp, #0x50]
400082c4: a94637ec     	ldp	x12, x13, [sp, #0x60]
400082c8: a9473fee     	ldp	x14, x15, [sp, #0x70]
400082cc: a94847f0     	ldp	x16, x17, [sp, #0x80]
400082d0: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400082d4: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400082d8: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400082dc: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400082e0: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400082e4: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400082e8: f9407bfe     	ldr	x30, [sp, #0xf0]
400082ec: 910443ff     	add	sp, sp, #0x110
400082f0: d69f03e0     	eret

00000000400082f4 <handle_irq_exception_asm>:
400082f4: d10443ff     	sub	sp, sp, #0x110
400082f8: a90007e0     	stp	x0, x1, [sp]
400082fc: d5384020     	mrs	x0, ELR_EL1
40008300: d5384001     	mrs	x1, SPSR_EL1
40008304: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008308: a94007e0     	ldp	x0, x1, [sp]
4000830c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40008310: a90217e4     	stp	x4, x5, [sp, #0x20]
40008314: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008318: a90427e8     	stp	x8, x9, [sp, #0x40]
4000831c: a9052fea     	stp	x10, x11, [sp, #0x50]
40008320: a90637ec     	stp	x12, x13, [sp, #0x60]
40008324: a9073fee     	stp	x14, x15, [sp, #0x70]
40008328: a90847f0     	stp	x16, x17, [sp, #0x80]
4000832c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40008330: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008334: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008338: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000833c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40008340: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008344: f9007bfe     	str	x30, [sp, #0xf0]
40008348: 910003e0     	mov	x0, sp
4000834c: 97ffdf99     	bl	0x400001b0 <handle_irq_exception>
40008350: 9100001f     	mov	sp, x0
40008354: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40008358: d5184020     	msr	ELR_EL1, x0
4000835c: d5184001     	msr	SPSR_EL1, x1
40008360: a94007e0     	ldp	x0, x1, [sp]
40008364: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40008368: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000836c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008370: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008374: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008378: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000837c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008380: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008384: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008388: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000838c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008390: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008394: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008398: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000839c: f9407bfe     	ldr	x30, [sp, #0xf0]
400083a0: 910443ff     	add	sp, sp, #0x110
400083a4: d69f03e0     	eret
