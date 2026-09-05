
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
40000048: 60 ad 04 40  	.word	0x4004ad60
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 b0 00 40  	.word	0x4000b000
40000054: 00 00 00 00  	.word	0x00000000
40000058: 60 ad 03 40  	.word	0x4003ad60
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 500429e0     	adr	x0, 0x400085ae <__rodata_start+0x15ae>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000d96     	bl	0x400036dc <uart_puts>
40000088: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000008c: 91391800     	add	x0, x0, #0xe46
40000090: aa1403e1     	mov	x1, x20
40000094: 94000ea7     	bl	0x40003b30 <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000a0: 913ea800     	add	x0, x0, #0xfaa
400000a4: 94000ea3     	bl	0x40003b30 <uart_printf>
400000a8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000ac: 91101800     	add	x0, x0, #0x406
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000e9f     	bl	0x40003b30 <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400000c0: 911c3c00     	add	x0, x0, #0x70f
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000e9a     	bl	0x40003b30 <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000f0: 910e4000     	add	x0, x0, #0x390
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000fc: 912e1400     	add	x0, x0, #0xb85
40000100: 94000d77     	bl	0x400036dc <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000010c: 91027000     	add	x0, x0, #0x9c
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000d71     	bl	0x400036dc <uart_puts>
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
4000014c: 94000e79     	bl	0x40003b30 <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000158: 9128f400     	add	x0, x0, #0xa3d
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000e74     	bl	0x40003b30 <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000170: 91395c00     	add	x0, x0, #0xe57
40000174: 910003fd     	mov	x29, sp
40000178: 94000d59     	bl	0x400036dc <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000188: 912e7c00     	add	x0, x0, #0xb9f
4000018c: 910003fd     	mov	x29, sp
40000190: 94000d53     	bl	0x400036dc <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001a0: 910cf400     	add	x0, x0, #0x33d
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000d4d     	bl	0x400036dc <uart_puts>
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
400001d8: 94000a5f     	bl	0x40002b54 <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 94001544     	bl	0x400056f0 <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001f0: 91129c00     	add	x0, x0, #0x4a7
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000e4e     	bl	0x40003b30 <uart_printf>
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
400002fc: 940009a8     	bl	0x4000299c <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 9400097f     	bl	0x40002908 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 940011ce     	bl	0x40004a54 <vfs_find>
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
400003bc: 70042940     	adr	x0, 0x400088e7 <__rodata_start+0x18e7>
400003c0: 94000cc7     	bl	0x400036dc <uart_puts>
400003c4: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400003c8: 91314694     	add	x20, x20, #0xc51
400003cc: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400003d0: 910372d6     	add	x22, x22, #0xdc
400003d4: 90000058     	adrp	x24, 0x40008000 <__rodata_start+0x1000>
400003d8: 910e8b18     	add	x24, x24, #0x3a2
400003dc: 90000059     	adrp	x25, 0x40008000 <__rodata_start+0x1000>
400003e0: 911c7739     	add	x25, x25, #0x71d
400003e4: d000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: d000007b     	adrp	x27, 0x4000e000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000cb6     	bl	0x400036dc <uart_puts>
40000408: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000040c: 91085c00     	add	x0, x0, #0x217
40000410: 94000cb3     	bl	0x400036dc <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000cb1     	bl	0x400036dc <uart_puts>
4000041c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000420: 9139d000     	add	x0, x0, #0xe74
40000424: aa1303e1     	mov	x1, x19
40000428: 94000dc2     	bl	0x40003b30 <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000434: 910d6129     	add	x9, x9, #0x358
40000438: 7100011f     	cmp	w8, #0x0
4000043c: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
40000440: 9125b908     	add	x8, x8, #0x96e
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000ca5     	bl	0x400036dc <uart_puts>
4000044c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000450: 913f6000     	add	x0, x0, #0xfd8
40000454: 94000ca2     	bl	0x400036dc <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000c99     	bl	0x400036dc <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000c97     	bl	0x400036dc <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000c92     	bl	0x400036dc <uart_puts>
40000498: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000049c: 910eb400     	add	x0, x0, #0x3ad
400004a0: 94000c8f     	bl	0x400036dc <uart_puts>
400004a4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400004a8: 912ef000     	add	x0, x0, #0xbbc
400004ac: 94000c8c     	bl	0x400036dc <uart_puts>
400004b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400004b4: 911c7c00     	add	x0, x0, #0x71f
400004b8: 94000c89     	bl	0x400036dc <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400004c8: 9110c800     	add	x0, x0, #0x432
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000d96     	bl	0x40003b30 <uart_printf>
400004dc: 94000cb4     	bl	0x400037ac <uart_getc>
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
40000550: 940008e7     	bl	0x400028ec <kstrcpy>
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
4000057c: 940008dc     	bl	0x400028ec <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 940008d2     	bl	0x400028ec <kstrcpy>
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
400005dc: 94000895     	bl	0x40002830 <kstrlen>
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
40000674: 9400086f     	bl	0x40002830 <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 94000870     	bl	0x4000284c <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 9400086d     	bl	0x4000284c <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 94001265     	bl	0x40005040 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400006bc: 91314694     	add	x20, x20, #0xc51
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c3a     	bl	0x400037ac <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c38     	bl	0x400037ac <uart_getc>
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
40000710: 94000848     	bl	0x40002830 <kstrlen>
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
40000760: 94000834     	bl	0x40002830 <kstrlen>
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
40000824: 94000803     	bl	0x40002830 <kstrlen>
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
4000088c: 9123b400     	add	x0, x0, #0x8ed
40000890: 94000b93     	bl	0x400036dc <uart_puts>
40000894: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000898: 91257000     	add	x0, x0, #0x95c
4000089c: 94000b90     	bl	0x400036dc <uart_puts>
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
400008d0: 5003f2b3     	adr	x19, 0x40008726 <__rodata_start+0x1726>
400008d4: 72a05f54     	movk	w20, #0x2fa, lsl #16
400008d8: a9017bfd     	stp	x29, x30, [sp, #0x10]
400008dc: 910043fd     	add	x29, sp, #0x10
400008e0: aa1303e0     	mov	x0, x19
400008e4: 94000b7e     	bl	0x400036dc <uart_puts>
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
40000910: 91085c00     	add	x0, x0, #0x217
40000914: 910003fd     	mov	x29, sp
40000918: 94000b71     	bl	0x400036dc <uart_puts>
4000091c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000920: 911c7400     	add	x0, x0, #0x71d
40000924: 94000b6e     	bl	0x400036dc <uart_puts>
40000928: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000092c: 910f6800     	add	x0, x0, #0x3da
40000930: 94000b6b     	bl	0x400036dc <uart_puts>
40000934: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000938: 9125ec00     	add	x0, x0, #0x97b
4000093c: 94000b68     	bl	0x400036dc <uart_puts>
40000940: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000944: 913a3c00     	add	x0, x0, #0xe8f
40000948: 94000b65     	bl	0x400036dc <uart_puts>
4000094c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000b62     	bl	0x400036dc <uart_puts>
40000958: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000095c: 913b2800     	add	x0, x0, #0xeca
40000960: 94000b5f     	bl	0x400036dc <uart_puts>
40000964: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000968: 91131c00     	add	x0, x0, #0x4c7
4000096c: 94000b5c     	bl	0x400036dc <uart_puts>
40000970: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000974: 913f7800     	add	x0, x0, #0xfde
40000978: 94000c6e     	bl	0x40003b30 <uart_printf>
4000097c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000980: 911ca000     	add	x0, x0, #0x728
40000984: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000988: 9116f021     	add	x1, x1, #0x5bc
4000098c: 94000c69     	bl	0x40003b30 <uart_printf>
40000990: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000994: 91042000     	add	x0, x0, #0x108
40000998: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000099c: 913c1821     	add	x1, x1, #0xf06
400009a0: 94000c64     	bl	0x40003b30 <uart_printf>
400009a4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009a8: 912f0400     	add	x0, x0, #0xbc1
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000b4b     	b	0x400036dc <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009bc: 91099800     	add	x0, x0, #0x266
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b46     	bl	0x400036dc <uart_puts>
400009c8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009cc: 91178c00     	add	x0, x0, #0x5e3
400009d0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009d4: 913c5c21     	add	x1, x1, #0xf17
400009d8: 94000c56     	bl	0x40003b30 <uart_printf>
400009dc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009e0: 9126e000     	add	x0, x0, #0x9b8
400009e4: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
400009e8: 9116f021     	add	x1, x1, #0x5bc
400009ec: 94000c51     	bl	0x40003b30 <uart_printf>
400009f0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009f4: 910d9400     	add	x0, x0, #0x365
400009f8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009fc: 913c1821     	add	x1, x1, #0xf06
40000a00: 94000c4c     	bl	0x40003b30 <uart_printf>
40000a04: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000a08: 91056000     	add	x0, x0, #0x158
40000a0c: 94000b34     	bl	0x400036dc <uart_puts>
40000a10: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a14: 91224800     	add	x0, x0, #0x892
40000a18: 94000b31     	bl	0x400036dc <uart_puts>
40000a1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a20: 911c7400     	add	x0, x0, #0x71d
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b2d     	b	0x400036dc <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a34: 9104f400     	add	x0, x0, #0x13d
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b24     	bl	0x400036dc <uart_puts>
40000a50: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a54: 912b3400     	add	x0, x0, #0xacd
40000a58: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a5c: 913c5c21     	add	x1, x1, #0xf17
40000a60: f0000022     	adrp	x2, 0x40007000 <__rodata_start>
40000a64: 9116f042     	add	x2, x2, #0x5bc
40000a68: 94000c32     	bl	0x40003b30 <uart_printf>
40000a6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a70: 912bb000     	add	x0, x0, #0xaec
40000a74: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a78: 913c1821     	add	x1, x1, #0xf06
40000a7c: 94000c2d     	bl	0x40003b30 <uart_printf>
40000a80: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a84: 9135f000     	add	x0, x0, #0xd7c
40000a88: 94000c2a     	bl	0x40003b30 <uart_printf>
40000a8c: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40000a90: 9115a108     	add	x8, x8, #0x568
40000a94: b0000049     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40000a98: 91063529     	add	x9, x9, #0x18d
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000aa4: 91175c00     	add	x0, x0, #0x5d7
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000ab4: 9126d929     	add	x9, x9, #0x9b6
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c1c     	bl	0x40003b30 <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000acc: 9117f000     	add	x0, x0, #0x5fc
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c17     	bl	0x40003b30 <uart_printf>
40000ad8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000adc: 91318c00     	add	x0, x0, #0xc63
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c12     	bl	0x40003b30 <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 10030582     	adr	x2, 0x40006ba8 <__text_end>
40000afc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b00: 91316000     	add	x0, x0, #0xc58
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c0a     	bl	0x40003b30 <uart_printf>
40000b0c: d503201f     	nop
40000b10: 10032781     	adr	x1, 0x40007000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 10046842     	adr	x2, 0x40009820 <__rodata_end>
40000b1c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b20: 911b9000     	add	x0, x0, #0x6e4
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000c02     	bl	0x40003b30 <uart_printf>
40000b2c: d503201f     	nop
40000b30: 1004a681     	adr	x1, 0x4000a000 <next_pid>
40000b34: d503201f     	nop
40000b38: 101d1142     	adr	x2, 0x4003ad60
40000b3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b40: 912d1400     	add	x0, x0, #0xb45
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000bfa     	bl	0x40003b30 <uart_printf>
40000b4c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b50: 91010000     	add	x0, x0, #0x40
40000b54: d503201f     	nop
40000b58: 10251041     	adr	x1, 0x4004ad60 <__stack_top>
40000b5c: 94000bf5     	bl	0x40003b30 <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b68: 911c7400     	add	x0, x0, #0x71d
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000adb     	b	0x400036dc <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b7c: 91066000     	add	x0, x0, #0x198
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000ad6     	bl	0x400036dc <uart_puts>
40000b88: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b8c: 9131f400     	add	x0, x0, #0xc7d
40000b90: 94000ad3     	bl	0x400036dc <uart_puts>
40000b94: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b98: 9117e000     	add	x0, x0, #0x5f8
40000b9c: 94000ad0     	bl	0x400036dc <uart_puts>
40000ba0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ba4: 912c1800     	add	x0, x0, #0xb06
40000ba8: 94000acd     	bl	0x400036dc <uart_puts>
40000bac: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bb0: 911c3800     	add	x0, x0, #0x70e
40000bb4: 94000aca     	bl	0x400036dc <uart_puts>
40000bb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000bbc: 91087c00     	add	x0, x0, #0x21f
40000bc0: 94000ac7     	bl	0x400036dc <uart_puts>
40000bc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bc8: 91320800     	add	x0, x0, #0xc82
40000bcc: 94000ac4     	bl	0x400036dc <uart_puts>
40000bd0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000bd4: 9115d000     	add	x0, x0, #0x574
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000ac0     	b	0x400036dc <uart_puts>

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
40000c04: 911cb694     	add	x20, x20, #0x72d
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000ae8     	bl	0x400037ac <uart_getc>
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
40000c60: 94000a88     	bl	0x40003680 <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000a99     	bl	0x400036dc <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c84: 91018000     	add	x0, x0, #0x60
40000c88: 94000a95     	bl	0x400036dc <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cac: 91270800     	add	x0, x0, #0x9c2
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000a8a     	bl	0x400036dc <uart_puts>
40000cb8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cbc: 9114b800     	add	x0, x0, #0x52e
40000cc0: 94000a87     	bl	0x400036dc <uart_puts>
40000cc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cc8: 91234800     	add	x0, x0, #0x8d2
40000ccc: 94000a84     	bl	0x400036dc <uart_puts>
40000cd0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cd4: 91018c00     	add	x0, x0, #0x63
40000cd8: 94000a81     	bl	0x400036dc <uart_puts>
40000cdc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ce0: 91058400     	add	x0, x0, #0x161
40000ce4: 94000a7e     	bl	0x400036dc <uart_puts>
40000ce8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cec: 913c8800     	add	x0, x0, #0xf22
40000cf0: 94000a7b     	bl	0x400036dc <uart_puts>
40000cf4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000cf8: 9116fc00     	add	x0, x0, #0x5bf
40000cfc: 94000a78     	bl	0x400036dc <uart_puts>
40000d00: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d04: 911d6400     	add	x0, x0, #0x759
40000d08: 94000a75     	bl	0x400036dc <uart_puts>
40000d0c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d10: 911dd000     	add	x0, x0, #0x774
40000d14: 94000a72     	bl	0x400036dc <uart_puts>
40000d18: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d1c: 91181400     	add	x0, x0, #0x605
40000d20: 94000a6f     	bl	0x400036dc <uart_puts>
40000d24: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d28: 911ed400     	add	x0, x0, #0x7b5
40000d2c: 94000a6c     	bl	0x400036dc <uart_puts>
40000d30: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d34: 91332400     	add	x0, x0, #0xcc9
40000d38: 94000a69     	bl	0x400036dc <uart_puts>
40000d3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d40: 91038400     	add	x0, x0, #0xe1
40000d44: 94000a66     	bl	0x400036dc <uart_puts>
40000d48: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d4c: 91074000     	add	x0, x0, #0x1d0
40000d50: 94000a63     	bl	0x400036dc <uart_puts>
40000d54: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d58: 91243800     	add	x0, x0, #0x90e
40000d5c: 94000a60     	bl	0x400036dc <uart_puts>
40000d60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d64: 9132f800     	add	x0, x0, #0xcbe
40000d68: 94000a5d     	bl	0x400036dc <uart_puts>
40000d6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d70: 91062000     	add	x0, x0, #0x188
40000d74: 94000a5a     	bl	0x400036dc <uart_puts>
40000d78: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d7c: 91188c00     	add	x0, x0, #0x623
40000d80: 94000a57     	bl	0x400036dc <uart_puts>
40000d84: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d88: 911cc400     	add	x0, x0, #0x731
40000d8c: 94000a54     	bl	0x400036dc <uart_puts>
40000d90: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d94: 91105400     	add	x0, x0, #0x415
40000d98: 94000a51     	bl	0x400036dc <uart_puts>
40000d9c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000da0: 910a2000     	add	x0, x0, #0x288
40000da4: 94000a4e     	bl	0x400036dc <uart_puts>
40000da8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dac: 9109b400     	add	x0, x0, #0x26d
40000db0: 94000a4b     	bl	0x400036dc <uart_puts>
40000db4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000db8: 91082400     	add	x0, x0, #0x209
40000dbc: 94000a48     	bl	0x400036dc <uart_puts>
40000dc0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dc4: 911fdc00     	add	x0, x0, #0x7f7
40000dc8: 94000a45     	bl	0x400036dc <uart_puts>
40000dcc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dd0: 91116400     	add	x0, x0, #0x459
40000dd4: 94000a42     	bl	0x400036dc <uart_puts>
40000dd8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ddc: 9110ec00     	add	x0, x0, #0x43b
40000de0: 94000a3f     	bl	0x400036dc <uart_puts>
40000de4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000de8: 911de800     	add	x0, x0, #0x77a
40000dec: 94000a3c     	bl	0x400036dc <uart_puts>
40000df0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000df4: 911e3400     	add	x0, x0, #0x78d
40000df8: 94000a39     	bl	0x400036dc <uart_puts>
40000dfc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e00: 9133d400     	add	x0, x0, #0xcf5
40000e04: 94000a36     	bl	0x400036dc <uart_puts>
40000e08: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e0c: 91044c00     	add	x0, x0, #0x113
40000e10: 94000a33     	bl	0x400036dc <uart_puts>
40000e14: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000e18: 91092c00     	add	x0, x0, #0x24b
40000e1c: 94000a30     	bl	0x400036dc <uart_puts>
40000e20: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000e24: 91297800     	add	x0, x0, #0xa5e
40000e28: 94000a2d     	bl	0x400036dc <uart_puts>
40000e2c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000e30: 9119b400     	add	x0, x0, #0x66d
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a29     	b	0x400036dc <uart_puts>

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
40000f04: 91241021     	add	x1, x1, #0x904
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 94000658     	bl	0x40002870 <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f1c: 9126b821     	add	x1, x1, #0x9ae
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 94000653     	bl	0x40002870 <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f30: 9106ec21     	add	x1, x1, #0x1bb
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 9400064e     	bl	0x40002870 <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f44: 9133f821     	add	x1, x1, #0xcfe
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 94000649     	bl	0x40002870 <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f58: 910c1821     	add	x1, x1, #0x306
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 94000644     	bl	0x40002870 <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f6c: 9124c421     	add	x1, x1, #0x931
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 9400063f     	bl	0x40002870 <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f80: 9136b421     	add	x1, x1, #0xdad
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 9400063a     	bl	0x40002870 <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f94: 910ddc21     	add	x1, x1, #0x377
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 94000635     	bl	0x40002870 <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fa8: 91285821     	add	x1, x1, #0xa16
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000630     	bl	0x40002870 <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fbc: 912a3c21     	add	x1, x1, #0xa8f
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 9400062b     	bl	0x40002870 <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fd0: 91152421     	add	x1, x1, #0x549
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 94000626     	bl	0x40002870 <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000fe4: 91192021     	add	x1, x1, #0x648
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000621     	bl	0x40002870 <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000ff8: 9111e021     	add	x1, x1, #0x478
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 9400061c     	bl	0x40002870 <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000100c: 91205421     	add	x1, x1, #0x815
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 94000617     	bl	0x40002870 <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001020: 912ee821     	add	x1, x1, #0xbba
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 94000612     	bl	0x40002870 <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001034: 91207021     	add	x1, x1, #0x81c
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 9400060d     	bl	0x40002870 <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001048: 913d9821     	add	x1, x1, #0xf66
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 94000608     	bl	0x40002870 <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000105c: 91029821     	add	x1, x1, #0xa6
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 94000603     	bl	0x40002870 <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001070: 910c2421     	add	x1, x1, #0x309
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 940005fe     	bl	0x40002870 <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001084: 910df821     	add	x1, x1, #0x37e
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 940005f9     	bl	0x40002870 <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001098: 911b6821     	add	x1, x1, #0x6da
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 940005f4     	bl	0x40002870 <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010ac: 91200c21     	add	x1, x1, #0x803
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 940005ef     	bl	0x40002870 <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010c0: 9107c021     	add	x1, x1, #0x1f0
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 940005ea     	bl	0x40002870 <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010d4: 910e1021     	add	x1, x1, #0x384
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 940005e5     	bl	0x40002870 <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010e8: 91202421     	add	x1, x1, #0x809
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 940005e0     	bl	0x40002870 <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010fc: 911b8021     	add	x1, x1, #0x6e0
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 940005db     	bl	0x40002870 <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001110: 91071821     	add	x1, x1, #0x1c6
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 940005d6     	bl	0x40002870 <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001124: 910b3421     	add	x1, x1, #0x2cd
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 940005d1     	bl	0x40002870 <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001138: 912d7821     	add	x1, x1, #0xb5e
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 940005cc     	bl	0x40002870 <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
4000114c: 911e7021     	add	x1, x1, #0x79c
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 940005c7     	bl	0x40002870 <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001160: 910e2821     	add	x1, x1, #0x38a
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 940005c2     	bl	0x40002870 <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001174: 912f4c21     	add	x1, x1, #0xbd3
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 940005bd     	bl	0x40002870 <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001188: 910e3c00     	add	x0, x0, #0x38f
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011a0: 91099800     	add	x0, x0, #0x266
400011a4: 9400094e     	bl	0x400036dc <uart_puts>
400011a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011ac: 91178c00     	add	x0, x0, #0x5e3
400011b0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011b4: 913c5c21     	add	x1, x1, #0xf17
400011b8: 94000a5e     	bl	0x40003b30 <uart_printf>
400011bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011c0: 9126e000     	add	x0, x0, #0x9b8
400011c4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400011c8: 9116f021     	add	x1, x1, #0x5bc
400011cc: 94000a59     	bl	0x40003b30 <uart_printf>
400011d0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011d4: 910d9400     	add	x0, x0, #0x365
400011d8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011dc: 913c1821     	add	x1, x1, #0xf06
400011e0: 94000a54     	bl	0x40003b30 <uart_printf>
400011e4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400011e8: 91056000     	add	x0, x0, #0x158
400011ec: 9400093c     	bl	0x400036dc <uart_puts>
400011f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011f4: 91224800     	add	x0, x0, #0x892
400011f8: 94000939     	bl	0x400036dc <uart_puts>
400011fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001200: 911c7400     	add	x0, x0, #0x71d
40001204: 94000936     	bl	0x400036dc <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001210: 913f0400     	add	x0, x0, #0xfc1
40001214: 94000932     	bl	0x400036dc <uart_puts>
40001218: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000121c: 910aec00     	add	x0, x0, #0x2bb
40001220: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001224: 9116f021     	add	x1, x1, #0x5bc
40001228: 94000a42     	bl	0x40003b30 <uart_printf>
4000122c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001230: 912dbc00     	add	x0, x0, #0xb6f
40001234: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001238: 913c1821     	add	x1, x1, #0xf06
4000123c: 94000a3d     	bl	0x40003b30 <uart_printf>
40001240: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001244: 91053c00     	add	x0, x0, #0x14f
40001248: 94000925     	bl	0x400036dc <uart_puts>
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
40001274: 9400056f     	bl	0x40002830 <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000f71     	bl	0x40005044 <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000128c: 910d7400     	add	x0, x0, #0x35d
40001290: 94000913     	bl	0x400036dc <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 94000565     	bl	0x40002830 <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 94000635     	bl	0x40002b84 <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 940001fc     	bl	0x40001aac <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012c8: 91190c00     	add	x0, x0, #0x643
400012cc: 94000904     	bl	0x400036dc <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400012d8: 912d5000     	add	x0, x0, #0xb54
400012dc: 94000900     	bl	0x400036dc <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012e8: 91348800     	add	x0, x0, #0xd22
400012ec: 940008fc     	bl	0x400036dc <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000330     	bl	0x40001fb4 <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 9400054c     	bl	0x40002830 <kstrlen>
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
40001350: 940005b2     	bl	0x40002a18 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f35     	bl	0x40005040 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001378: 91070c21     	add	x1, x1, #0x1c3
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 9400053c     	bl	0x40002870 <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000138c: 911a0000     	add	x0, x0, #0x680
40001390: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001394: 913c5c21     	add	x1, x1, #0xf17
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400013a0: 91127c00     	add	x0, x0, #0x49f
400013a4: 940008ce     	bl	0x400036dc <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 9400026b     	bl	0x40001d60 <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400013c8: 91018800     	add	x0, x0, #0x62
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400013d4: 9101d800     	add	x0, x0, #0x76
400013d8: 940008c1     	bl	0x400036dc <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013e4: 911a0000     	add	x0, x0, #0x680
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013f4: 91196400     	add	x0, x0, #0x659
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 940009cd     	bl	0x40003b30 <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d42     	bl	0x4000490c <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 94000508     	bl	0x40002830 <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000d8e     	bl	0x40004a54 <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
40001434: 911b0908     	add	x8, x8, #0x6c2
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 940009bc     	bl	0x40003b30 <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d32     	bl	0x40004918 <vfs_getcwd>
40001454: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001458: 911a0000     	add	x0, x0, #0x680
4000145c: 910003e1     	mov	x1, sp
40001460: 940009b4     	bl	0x40003b30 <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000146c: 911f5000     	add	x0, x0, #0x7d4
40001470: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001474: 913c5c21     	add	x1, x1, #0xf17
40001478: d0000022     	adrp	x2, 0x40007000 <__rodata_start>
4000147c: 9116f042     	add	x2, x2, #0x5bc
40001480: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x1000>
40001484: 913c1863     	add	x3, x3, #0xf06
40001488: 940009aa     	bl	0x40003b30 <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f25     	bl	0x40005128 <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000dd2     	bl	0x40004be8 <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014ac: 910aa400     	add	x0, x0, #0x2a9
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014bc: 9112c800     	add	x0, x0, #0x4b2
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 940004d9     	bl	0x40002830 <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000d5f     	bl	0x40004a54 <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400014ec: 910c3400     	add	x0, x0, #0x30d
400014f0: 9400087b     	bl	0x400036dc <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 940004cd     	bl	0x40002830 <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000ddd     	bl	0x40004c7c <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001514: 91027c00     	add	x0, x0, #0x9f
40001518: 94000871     	bl	0x400036dc <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 940004c3     	bl	0x40002830 <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e28     	bl	0x40004dd4 <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001540: 910dec00     	add	x0, x0, #0x37b
40001544: 94000866     	bl	0x400036dc <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001550: 9109f800     	add	x0, x0, #0x27e
40001554: 94000862     	bl	0x400036dc <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 94000548     	bl	0x40002a84 <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000eb2     	bl	0x40005040 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001584: 9111f800     	add	x0, x0, #0x47e
40001588: 94000855     	bl	0x400036dc <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001594: 9113b800     	add	x0, x0, #0x4ee
40001598: 94000851     	bl	0x400036dc <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015a4: 91085c00     	add	x0, x0, #0x217
400015a8: 9400084d     	bl	0x400036dc <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015b4: 911c7400     	add	x0, x0, #0x71d
400015b8: 94000849     	bl	0x400036dc <uart_puts>
400015bc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015c0: 9136cc00     	add	x0, x0, #0xdb3
400015c4: 94000846     	bl	0x400036dc <uart_puts>
400015c8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 94000843     	bl	0x400036dc <uart_puts>
400015d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015d8: 91341800     	add	x0, x0, #0xd06
400015dc: 94000840     	bl	0x400036dc <uart_puts>
400015e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015e4: 91123400     	add	x0, x0, #0x48d
400015e8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400015ec: 913c1821     	add	x1, x1, #0xf06
400015f0: 94000950     	bl	0x40003b30 <uart_printf>
400015f4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015f8: 91207c00     	add	x0, x0, #0x81f
400015fc: 94000838     	bl	0x400036dc <uart_puts>
40001600: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001604: 91193400     	add	x0, x0, #0x64d
40001608: 94000835     	bl	0x400036dc <uart_puts>
4000160c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001610: 91140c00     	add	x0, x0, #0x503
40001614: 94000832     	bl	0x400036dc <uart_puts>
40001618: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000161c: 91287800     	add	x0, x0, #0xa1e
40001620: 9400082f     	bl	0x400036dc <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: d0000028     	adrp	x8, 0x40007000 <__rodata_start>
4000162c: 911a0108     	add	x8, x8, #0x680
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001640: 912ef800     	add	x0, x0, #0xbbe
40001644: 94000826     	bl	0x400036dc <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001650: 9134ec00     	add	x0, x0, #0xd3b
40001654: 94000822     	bl	0x400036dc <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 94000474     	bl	0x40002830 <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 94000439     	bl	0x40002750 <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001678: 910a5400     	add	x0, x0, #0x295
4000167c: 94000818     	bl	0x400036dc <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001688: 9138b000     	add	x0, x0, #0xe2c
4000168c: 94000814     	bl	0x400036dc <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: d0000035     	adrp	x21, 0x40007000 <__rodata_start>
40001698: 9112b2b5     	add	x21, x21, #0x4ac
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 940007f6     	bl	0x40003680 <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 940007f3     	bl	0x40003680 <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 940007f1     	bl	0x40003680 <uart_putc>
400016c0: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
400016c4: 910c8a73     	add	x19, x19, #0x322
400016c8: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400016cc: 911c7694     	add	x20, x20, #0x71d
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 940007e5     	bl	0x40003680 <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 940007e2     	bl	0x40003680 <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 940007e0     	bl	0x40003680 <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 940007f0     	bl	0x400036dc <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 940007ec     	bl	0x400036dc <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001738: 91357800     	add	x0, x0, #0xd5e
4000173c: 940007e8     	bl	0x400036dc <uart_puts>
40001740: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001744: 9102b800     	add	x0, x0, #0xae
40001748: 940007e5     	bl	0x400036dc <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001764: 9128fc00     	add	x0, x0, #0xa3f
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 940007d6     	bl	0x400036dc <uart_puts>
40001788: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
4000178c: 91394273     	add	x19, x19, #0xe50
40001790: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001794: 9102a694     	add	x20, x20, #0xa9
40001798: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
4000179c: 911cb6b5     	add	x21, x21, #0x72d
400017a0: f0000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
400017a4: 910182d6     	add	x22, x22, #0x60
400017a8: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x2000>
400017ac: 911e72f7     	add	x23, x23, #0x79c
400017b0: 90000058     	adrp	x24, 0x40009000 <__rodata_start+0x2000>
400017b4: 910e2b18     	add	x24, x24, #0x38a
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: d0000039     	adrp	x25, 0x40007000 <__rodata_start>
400017c0: 912f4f39     	add	x25, x25, #0xbd3
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000c53     	bl	0x40004918 <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 940008d6     	bl	0x40003b30 <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 940007bf     	bl	0x400036dc <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 940007f0     	bl	0x400037ac <uart_getc>
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
40001840: 94000790     	bl	0x40003680 <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 940007a1     	bl	0x400036dc <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 9400079e     	bl	0x400036dc <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 940003f0     	bl	0x40002830 <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 940002f0     	bl	0x4000243c <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 940003fa     	bl	0x40002870 <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 940003f6     	bl	0x40002870 <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 940003f2     	bl	0x40002870 <kstrcmp>
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
400018ec: 94000759     	bl	0x40003650 <uart_init>
400018f0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400018f4: 91085c00     	add	x0, x0, #0x217
400018f8: 94000779     	bl	0x400036dc <uart_puts>
400018fc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001900: 91153800     	add	x0, x0, #0x54e
40001904: 94000776     	bl	0x400036dc <uart_puts>
40001908: b90003ff     	str	wzr, [sp]
4000190c: b94003e8     	ldr	w8, [sp]
40001910: 6b13011f     	cmp	w8, w19
40001914: 540000aa     	b.ge	0x40001928 <kmain+0x58>
40001918: b94003e8     	ldr	w8, [sp]
4000191c: 11000508     	add	w8, w8, #0x1
40001920: b90003e8     	str	w8, [sp]
40001924: 17fffffa     	b	0x4000190c <kmain+0x3c>
40001928: 528aa213     	mov	w19, #0x5510            // =21776
4000192c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001930: 910c9000     	add	x0, x0, #0x324
40001934: 72a00453     	movk	w19, #0x22, lsl #16
40001938: 94000769     	bl	0x400036dc <uart_puts>
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
40001964: 94000a7f     	bl	0x40004360 <vfs_init>
40001968: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000196c: 91213400     	add	x0, x0, #0x84d
40001970: 9400075b     	bl	0x400036dc <uart_puts>
40001974: b90003ff     	str	wzr, [sp]
40001978: b94003e8     	ldr	w8, [sp]
4000197c: 6b14011f     	cmp	w8, w20
40001980: 540000aa     	b.ge	0x40001994 <kmain+0xc4>
40001984: b94003e8     	ldr	w8, [sp]
40001988: 11000508     	add	w8, w8, #0x1
4000198c: b90003e8     	str	w8, [sp]
40001990: 17fffffa     	b	0x40001978 <kmain+0xa8>
40001994: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001998: 9107d800     	add	x0, x0, #0x1f6
4000199c: d503201f     	nop
400019a0: 10023308     	adr	x8, 0x40006000 <exception_vector_table>
400019a4: d518c008     	msr	VBAR_EL1, x8
400019a8: 9400074d     	bl	0x400036dc <uart_puts>
400019ac: b90003ff     	str	wzr, [sp]
400019b0: b94003e8     	ldr	w8, [sp]
400019b4: 6b13011f     	cmp	w8, w19
400019b8: 540000aa     	b.ge	0x400019cc <kmain+0xfc>
400019bc: b94003e8     	ldr	w8, [sp]
400019c0: 11000508     	add	w8, w8, #0x1
400019c4: b90003e8     	str	w8, [sp]
400019c8: 17fffffa     	b	0x400019b0 <kmain+0xe0>
400019cc: 97fffa12     	bl	0x40000214 <gic_init>
400019d0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400019d4: 9119dc00     	add	x0, x0, #0x677
400019d8: 94000741     	bl	0x400036dc <uart_puts>
400019dc: b90003ff     	str	wzr, [sp]
400019e0: b94003e8     	ldr	w8, [sp]
400019e4: 6b13011f     	cmp	w8, w19
400019e8: 540000aa     	b.ge	0x400019fc <kmain+0x12c>
400019ec: b94003e8     	ldr	w8, [sp]
400019f0: 11000508     	add	w8, w8, #0x1
400019f4: b90003e8     	str	w8, [sp]
400019f8: 17fffffa     	b	0x400019e0 <kmain+0x110>
400019fc: 94000440     	bl	0x40002afc <timer_init>
40001a00: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001a04: 91242400     	add	x0, x0, #0x909
40001a08: 94000735     	bl	0x400036dc <uart_puts>
40001a0c: b90003ff     	str	wzr, [sp]
40001a10: b94003e8     	ldr	w8, [sp]
40001a14: 6b13011f     	cmp	w8, w19
40001a18: 540000aa     	b.ge	0x40001a2c <kmain+0x15c>
40001a1c: b94003e8     	ldr	w8, [sp]
40001a20: 11000508     	add	w8, w8, #0x1
40001a24: b90003e8     	str	w8, [sp]
40001a28: 17fffffa     	b	0x40001a10 <kmain+0x140>
40001a2c: 94000dff     	bl	0x40005228 <pmm_init>
40001a30: 94000e93     	bl	0x4000547c <sched_init>
40001a34: 94000f52     	bl	0x4000577c <virtio_blk_init>
40001a38: 34000100     	cbz	w0, 0x40001a58 <kmain+0x188>
40001a3c: 910003e1     	mov	x1, sp
40001a40: aa1f03e0     	mov	x0, xzr
40001a44: 94000f98     	bl	0x400058a4 <virtio_blk_read_sector>
40001a48: 34000080     	cbz	w0, 0x40001a58 <kmain+0x188>
40001a4c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a50: 913af000     	add	x0, x0, #0xebc
40001a54: 94000722     	bl	0x400036dc <uart_puts>
40001a58: 529e1014     	mov	w20, #0xf080            // =61568
40001a5c: d503201f     	nop
40001a60: 10ff7300     	adr	x0, 0x400008c0 <system_idle_daemon>
40001a64: 72a05f54     	movk	w20, #0x2fa, lsl #16
40001a68: 94000eac     	bl	0x40005518 <sched_create_task>
40001a6c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a70: 911a1000     	add	x0, x0, #0x684
40001a74: 9400071a     	bl	0x400036dc <uart_puts>
40001a78: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001a7c: 912f6273     	add	x19, x19, #0xbd8
40001a80: d50342ff     	msr	DAIFClr, #0x2
40001a84: aa1303e0     	mov	x0, x19
40001a88: 94000715     	bl	0x400036dc <uart_puts>
40001a8c: b90003ff     	str	wzr, [sp]
40001a90: b94003e8     	ldr	w8, [sp]
40001a94: 6b14011f     	cmp	w8, w20
40001a98: 54ffff6a     	b.ge	0x40001a84 <kmain+0x1b4>
40001a9c: b94003e8     	ldr	w8, [sp]
40001aa0: 11000508     	add	w8, w8, #0x1
40001aa4: b90003e8     	str	w8, [sp]
40001aa8: 17fffffa     	b	0x40001a90 <kmain+0x1c0>

0000000040001aac <kproj_execute>:
40001aac: d10683ff     	sub	sp, sp, #0x1a0
40001ab0: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001ab4: 910603fd     	add	x29, sp, #0x180
40001ab8: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001abc: b40001c0     	cbz	x0, 0x40001af4 <kproj_execute+0x48>
40001ac0: aa0003f3     	mov	x19, x0
40001ac4: 9400035b     	bl	0x40002830 <kstrlen>
40001ac8: b4000160     	cbz	x0, 0x40001af4 <kproj_execute+0x48>
40001acc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ad0: 91274400     	add	x0, x0, #0x9d1
40001ad4: aa1303e1     	mov	x1, x19
40001ad8: 94000816     	bl	0x40003b30 <uart_printf>
40001adc: aa1303e0     	mov	x0, x19
40001ae0: 94000c67     	bl	0x40004c7c <vfs_mkdir>
40001ae4: 34000140     	cbz	w0, 0x40001b0c <kproj_execute+0x60>
40001ae8: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001aec: 911e8400     	add	x0, x0, #0x7a1
40001af0: 14000003     	b	0x40001afc <kproj_execute+0x50>
40001af4: d503201f     	nop
40001af8: 7003c5a0     	adr	x0, 0x400093af <__rodata_start+0x23af>
40001afc: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001b00: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001b04: 910683ff     	add	sp, sp, #0x1a0
40001b08: 140006f5     	b	0x400036dc <uart_puts>
40001b0c: aa1303e0     	mov	x0, x19
40001b10: 94000c36     	bl	0x40004be8 <vfs_chdir>
40001b14: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b18: 91031800     	add	x0, x0, #0xc6
40001b1c: 94000c58     	bl	0x40004c7c <vfs_mkdir>
40001b20: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b24: 911b8c00     	add	x0, x0, #0x6e3
40001b28: 94000c55     	bl	0x40004c7c <vfs_mkdir>
40001b2c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b30: 91090c21     	add	x1, x1, #0x243
40001b34: 910203e0     	add	x0, sp, #0x80
40001b38: 9400036d     	bl	0x400028ec <kstrcpy>
40001b3c: 910203e0     	add	x0, sp, #0x80
40001b40: aa1303e1     	mov	x1, x19
40001b44: 94000342     	bl	0x4000284c <kstrcat>
40001b48: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b4c: 913be421     	add	x1, x1, #0xef9
40001b50: 910203e0     	add	x0, sp, #0x80
40001b54: 9400033e     	bl	0x4000284c <kstrcat>
40001b58: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b5c: 9124e400     	add	x0, x0, #0x939
40001b60: 910203e1     	add	x1, sp, #0x80
40001b64: 94000c9c     	bl	0x40004dd4 <vfs_touch>
40001b68: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001b6c: 91035000     	add	x0, x0, #0xd4
40001b70: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b74: 912f6821     	add	x1, x1, #0xbda
40001b78: 94000c97     	bl	0x40004dd4 <vfs_touch>
40001b7c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001b80: 91072821     	add	x1, x1, #0x1ca
40001b84: 910003e0     	mov	x0, sp
40001b88: 94000359     	bl	0x400028ec <kstrcpy>
40001b8c: 910003e0     	mov	x0, sp
40001b90: aa1303e1     	mov	x1, x19
40001b94: 9400032e     	bl	0x4000284c <kstrcat>
40001b98: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b9c: 912a5021     	add	x1, x1, #0xa94
40001ba0: 910003e0     	mov	x0, sp
40001ba4: 9400032a     	bl	0x4000284c <kstrcat>
40001ba8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001bac: 913c9400     	add	x0, x0, #0xf25
40001bb0: 910003e1     	mov	x1, sp
40001bb4: 94000c88     	bl	0x40004dd4 <vfs_touch>
40001bb8: 94000c86     	bl	0x40004dd0 <vfs_sync>
40001bbc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001bc0: 9112f400     	add	x0, x0, #0x4bd
40001bc4: 940006c6     	bl	0x400036dc <uart_puts>
40001bc8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001bcc: 9113b000     	add	x0, x0, #0x4ec
40001bd0: aa1303e1     	mov	x1, x19
40001bd4: 940007d7     	bl	0x40003b30 <uart_printf>
40001bd8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001bdc: 91032800     	add	x0, x0, #0xca
40001be0: 94000c02     	bl	0x40004be8 <vfs_chdir>
40001be4: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001be8: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001bec: 910683ff     	add	sp, sp, #0x1a0
40001bf0: d65f03c0     	ret

0000000040001bf4 <process_init>:
40001bf4: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001bf8: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001bfc: b0000054     	adrp	x20, 0x4000a000 <next_pid>
40001c00: d503201f     	nop
40001c04: 10063293     	adr	x19, 0x4000e254 <proc_table>
40001c08: b9400289     	ldr	w9, [x20]
40001c0c: 52800068     	mov	w8, #0x3                // =3
40001c10: b9002668     	str	w8, [x19, #0x24]
40001c14: d503201f     	nop
40001c18: 500369e1     	adr	x1, 0x40008956 <__rodata_start+0x1956>
40001c1c: b9005668     	str	w8, [x19, #0x54]
40001c20: 91001260     	add	x0, x19, #0x4
40001c24: 910003fd     	mov	x29, sp
40001c28: b9008668     	str	w8, [x19, #0x84]
40001c2c: b900b668     	str	w8, [x19, #0xb4]
40001c30: b900e668     	str	w8, [x19, #0xe4]
40001c34: b9011668     	str	w8, [x19, #0x114]
40001c38: b9014668     	str	w8, [x19, #0x144]
40001c3c: b9017668     	str	w8, [x19, #0x174]
40001c40: b901a668     	str	w8, [x19, #0x1a4]
40001c44: b901d668     	str	w8, [x19, #0x1d4]
40001c48: b9020668     	str	w8, [x19, #0x204]
40001c4c: b9023668     	str	w8, [x19, #0x234]
40001c50: b9026668     	str	w8, [x19, #0x264]
40001c54: b9029668     	str	w8, [x19, #0x294]
40001c58: b902c668     	str	w8, [x19, #0x2c4]
40001c5c: b902f668     	str	w8, [x19, #0x2f4]
40001c60: 11000528     	add	w8, w9, #0x1
40001c64: f9000bf5     	str	x21, [sp, #0x10]
40001c68: b900327f     	str	wzr, [x19, #0x30]
40001c6c: b900627f     	str	wzr, [x19, #0x60]
40001c70: b900927f     	str	wzr, [x19, #0x90]
40001c74: b900c27f     	str	wzr, [x19, #0xc0]
40001c78: b900f27f     	str	wzr, [x19, #0xf0]
40001c7c: b901227f     	str	wzr, [x19, #0x120]
40001c80: b901527f     	str	wzr, [x19, #0x150]
40001c84: b901827f     	str	wzr, [x19, #0x180]
40001c88: b901b27f     	str	wzr, [x19, #0x1b0]
40001c8c: b901e27f     	str	wzr, [x19, #0x1e0]
40001c90: b902127f     	str	wzr, [x19, #0x210]
40001c94: b902427f     	str	wzr, [x19, #0x240]
40001c98: b902727f     	str	wzr, [x19, #0x270]
40001c9c: b902a27f     	str	wzr, [x19, #0x2a0]
40001ca0: b902d27f     	str	wzr, [x19, #0x2d0]
40001ca4: b9000288     	str	w8, [x20]
40001ca8: b9000269     	str	w9, [x19]
40001cac: 94000310     	bl	0x400028ec <kstrcpy>
40001cb0: b9400288     	ldr	w8, [x20]
40001cb4: 52a00209     	mov	w9, #0x100000           // =1048576
40001cb8: 5280384a     	mov	w10, #0x1c2             // =450
40001cbc: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001cc0: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001cc4: 911f6821     	add	x1, x1, #0x7da
40001cc8: 11000509     	add	w9, w8, #0x1
40001ccc: 9100d260     	add	x0, x19, #0x34
40001cd0: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001cd4: b9000289     	str	w9, [x20]
40001cd8: 94000305     	bl	0x400028ec <kstrcpy>
40001cdc: b9400288     	ldr	w8, [x20]
40001ce0: 529d0009     	mov	w9, #0xe800             // =59392
40001ce4: 52800035     	mov	w21, #0x1               // =1
40001ce8: 72a00069     	movk	w9, #0x3, lsl #16
40001cec: 5280018a     	mov	w10, #0xc               // =12
40001cf0: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001cf4: 912ad821     	add	x1, x1, #0xab6
40001cf8: 290aa675     	stp	w21, w9, [x19, #0x54]
40001cfc: 11000509     	add	w9, w8, #0x1
40001d00: 91019260     	add	x0, x19, #0x64
40001d04: b9000289     	str	w9, [x20]
40001d08: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001d0c: 940002f8     	bl	0x400028ec <kstrcpy>
40001d10: b9400288     	ldr	w8, [x20]
40001d14: 52a00809     	mov	w9, #0x400000           // =4194304
40001d18: 5280960a     	mov	w10, #0x4b0             // =1200
40001d1c: 2910a675     	stp	w21, w9, [x19, #0x84]
40001d20: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001d24: 910e2821     	add	x1, x1, #0x38a
40001d28: 11000509     	add	w9, w8, #0x1
40001d2c: 91025260     	add	x0, x19, #0x94
40001d30: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001d34: b9000289     	str	w9, [x20]
40001d38: 940002ed     	bl	0x400028ec <kstrcpy>
40001d3c: 529a0008     	mov	w8, #0xd000             // =53248
40001d40: 52800aa9     	mov	w9, #0x55               // =85
40001d44: f9400bf5     	ldr	x21, [sp, #0x10]
40001d48: 72a000e8     	movk	w8, #0x7, lsl #16
40001d4c: b900be69     	str	w9, [x19, #0xbc]
40001d50: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001d54: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001d58: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001d5c: d65f03c0     	ret

0000000040001d60 <process_kill>:
40001d60: 7100041f     	cmp	w0, #0x1
40001d64: 5400118b     	b.lt	0x40001f94 <process_kill+0x234>
40001d68: d503201f     	nop
40001d6c: 10062749     	adr	x9, 0x4000e254 <proc_table>
40001d70: b9400128     	ldr	w8, [x9]
40001d74: 6b00011f     	cmp	w8, w0
40001d78: 54000081     	b.ne	0x40001d88 <process_kill+0x28>
40001d7c: b9402528     	ldr	w8, [x9, #0x24]
40001d80: 71000d1f     	cmp	w8, #0x3
40001d84: 54000f41     	b.ne	0x40001f6c <process_kill+0x20c>
40001d88: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d8c: 910a1129     	add	x9, x9, #0x284
40001d90: b9400128     	ldr	w8, [x9]
40001d94: 6b00011f     	cmp	w8, w0
40001d98: 54000081     	b.ne	0x40001da8 <process_kill+0x48>
40001d9c: b9402528     	ldr	w8, [x9, #0x24]
40001da0: 71000d1f     	cmp	w8, #0x3
40001da4: 54000e41     	b.ne	0x40001f6c <process_kill+0x20c>
40001da8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001dac: 910ad129     	add	x9, x9, #0x2b4
40001db0: b9400128     	ldr	w8, [x9]
40001db4: 6b00011f     	cmp	w8, w0
40001db8: 54000081     	b.ne	0x40001dc8 <process_kill+0x68>
40001dbc: b9402528     	ldr	w8, [x9, #0x24]
40001dc0: 71000d1f     	cmp	w8, #0x3
40001dc4: 54000d41     	b.ne	0x40001f6c <process_kill+0x20c>
40001dc8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001dcc: 910b9129     	add	x9, x9, #0x2e4
40001dd0: b9400128     	ldr	w8, [x9]
40001dd4: 6b00011f     	cmp	w8, w0
40001dd8: 54000081     	b.ne	0x40001de8 <process_kill+0x88>
40001ddc: b9402528     	ldr	w8, [x9, #0x24]
40001de0: 71000d1f     	cmp	w8, #0x3
40001de4: 54000c41     	b.ne	0x40001f6c <process_kill+0x20c>
40001de8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001dec: 910c5129     	add	x9, x9, #0x314
40001df0: b9400128     	ldr	w8, [x9]
40001df4: 6b00011f     	cmp	w8, w0
40001df8: 54000081     	b.ne	0x40001e08 <process_kill+0xa8>
40001dfc: b9402528     	ldr	w8, [x9, #0x24]
40001e00: 71000d1f     	cmp	w8, #0x3
40001e04: 54000b41     	b.ne	0x40001f6c <process_kill+0x20c>
40001e08: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e0c: 910d1129     	add	x9, x9, #0x344
40001e10: b9400128     	ldr	w8, [x9]
40001e14: 6b00011f     	cmp	w8, w0
40001e18: 54000081     	b.ne	0x40001e28 <process_kill+0xc8>
40001e1c: b9402528     	ldr	w8, [x9, #0x24]
40001e20: 71000d1f     	cmp	w8, #0x3
40001e24: 54000a41     	b.ne	0x40001f6c <process_kill+0x20c>
40001e28: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e2c: 910dd129     	add	x9, x9, #0x374
40001e30: b9400128     	ldr	w8, [x9]
40001e34: 6b00011f     	cmp	w8, w0
40001e38: 54000081     	b.ne	0x40001e48 <process_kill+0xe8>
40001e3c: b9402528     	ldr	w8, [x9, #0x24]
40001e40: 71000d1f     	cmp	w8, #0x3
40001e44: 54000941     	b.ne	0x40001f6c <process_kill+0x20c>
40001e48: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e4c: 910e9129     	add	x9, x9, #0x3a4
40001e50: b9400128     	ldr	w8, [x9]
40001e54: 6b00011f     	cmp	w8, w0
40001e58: 54000081     	b.ne	0x40001e68 <process_kill+0x108>
40001e5c: b9402528     	ldr	w8, [x9, #0x24]
40001e60: 71000d1f     	cmp	w8, #0x3
40001e64: 54000841     	b.ne	0x40001f6c <process_kill+0x20c>
40001e68: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e6c: 910f5129     	add	x9, x9, #0x3d4
40001e70: b9400128     	ldr	w8, [x9]
40001e74: 6b00011f     	cmp	w8, w0
40001e78: 54000081     	b.ne	0x40001e88 <process_kill+0x128>
40001e7c: b9402528     	ldr	w8, [x9, #0x24]
40001e80: 71000d1f     	cmp	w8, #0x3
40001e84: 54000741     	b.ne	0x40001f6c <process_kill+0x20c>
40001e88: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e8c: 91101129     	add	x9, x9, #0x404
40001e90: b9400128     	ldr	w8, [x9]
40001e94: 6b00011f     	cmp	w8, w0
40001e98: 54000081     	b.ne	0x40001ea8 <process_kill+0x148>
40001e9c: b9402528     	ldr	w8, [x9, #0x24]
40001ea0: 71000d1f     	cmp	w8, #0x3
40001ea4: 54000641     	b.ne	0x40001f6c <process_kill+0x20c>
40001ea8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001eac: 9110d129     	add	x9, x9, #0x434
40001eb0: b9400128     	ldr	w8, [x9]
40001eb4: 6b00011f     	cmp	w8, w0
40001eb8: 54000081     	b.ne	0x40001ec8 <process_kill+0x168>
40001ebc: b9402528     	ldr	w8, [x9, #0x24]
40001ec0: 71000d1f     	cmp	w8, #0x3
40001ec4: 54000541     	b.ne	0x40001f6c <process_kill+0x20c>
40001ec8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ecc: 91119129     	add	x9, x9, #0x464
40001ed0: b9400128     	ldr	w8, [x9]
40001ed4: 6b00011f     	cmp	w8, w0
40001ed8: 54000081     	b.ne	0x40001ee8 <process_kill+0x188>
40001edc: b9402528     	ldr	w8, [x9, #0x24]
40001ee0: 71000d1f     	cmp	w8, #0x3
40001ee4: 54000441     	b.ne	0x40001f6c <process_kill+0x20c>
40001ee8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001eec: 91125129     	add	x9, x9, #0x494
40001ef0: b9400128     	ldr	w8, [x9]
40001ef4: 6b00011f     	cmp	w8, w0
40001ef8: 54000081     	b.ne	0x40001f08 <process_kill+0x1a8>
40001efc: b9402528     	ldr	w8, [x9, #0x24]
40001f00: 71000d1f     	cmp	w8, #0x3
40001f04: 54000341     	b.ne	0x40001f6c <process_kill+0x20c>
40001f08: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001f0c: 91131129     	add	x9, x9, #0x4c4
40001f10: b9400128     	ldr	w8, [x9]
40001f14: 6b00011f     	cmp	w8, w0
40001f18: 54000081     	b.ne	0x40001f28 <process_kill+0x1c8>
40001f1c: b9402528     	ldr	w8, [x9, #0x24]
40001f20: 71000d1f     	cmp	w8, #0x3
40001f24: 54000241     	b.ne	0x40001f6c <process_kill+0x20c>
40001f28: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001f2c: 9113d129     	add	x9, x9, #0x4f4
40001f30: b9400128     	ldr	w8, [x9]
40001f34: 6b00011f     	cmp	w8, w0
40001f38: 54000081     	b.ne	0x40001f48 <process_kill+0x1e8>
40001f3c: b9402528     	ldr	w8, [x9, #0x24]
40001f40: 71000d1f     	cmp	w8, #0x3
40001f44: 54000141     	b.ne	0x40001f6c <process_kill+0x20c>
40001f48: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001f4c: 91149129     	add	x9, x9, #0x524
40001f50: b9400128     	ldr	w8, [x9]
40001f54: 6b00011f     	cmp	w8, w0
40001f58: 12800008     	mov	w8, #-0x1               // =-1
40001f5c: 54000281     	b.ne	0x40001fac <process_kill+0x24c>
40001f60: b940252a     	ldr	w10, [x9, #0x24]
40001f64: 71000d5f     	cmp	w10, #0x3
40001f68: 54000220     	b.eq	0x40001fac <process_kill+0x24c>
40001f6c: 7100041f     	cmp	w0, #0x1
40001f70: 54000161     	b.ne	0x40001f9c <process_kill+0x23c>
40001f74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f78: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f7c: 91280800     	add	x0, x0, #0xa02
40001f80: 910003fd     	mov	x29, sp
40001f84: 940005d6     	bl	0x400036dc <uart_puts>
40001f88: 12800020     	mov	w0, #-0x2               // =-2
40001f8c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001f90: d65f03c0     	ret
40001f94: 12800000     	mov	w0, #-0x1               // =-1
40001f98: d65f03c0     	ret
40001f9c: 5280004a     	mov	w10, #0x2               // =2
40001fa0: 2a1f03e0     	mov	w0, wzr
40001fa4: b900252a     	str	w10, [x9, #0x24]
40001fa8: d65f03c0     	ret
40001fac: 2a0803e0     	mov	w0, w8
40001fb0: d65f03c0     	ret

0000000040001fb4 <launch_ktop>:
40001fb4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001fb8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001fbc: 91203400     	add	x0, x0, #0x80d
40001fc0: f9000bf7     	str	x23, [sp, #0x10]
40001fc4: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fc8: 910003fd     	mov	x29, sp
40001fcc: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fd0: 940005c3     	bl	0x400036dc <uart_puts>
40001fd4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001fd8: 91226800     	add	x0, x0, #0x89a
40001fdc: 940005c0     	bl	0x400036dc <uart_puts>
40001fe0: 2a1f03e8     	mov	w8, wzr
40001fe4: 2a1f03e1     	mov	w1, wzr
40001fe8: 52800209     	mov	w9, #0x10               // =16
40001fec: b000006a     	adrp	x10, 0x4000e000 <__bss_start+0x3000>
40001ff0: 9109f14a     	add	x10, x10, #0x27c
40001ff4: 14000004     	b	0x40002004 <launch_ktop+0x50>
40001ff8: f1000529     	subs	x9, x9, #0x1
40001ffc: 9100c14a     	add	x10, x10, #0x30
40002000: 54000120     	b.eq	0x40002024 <launch_ktop+0x70>
40002004: b85fc14b     	ldur	w11, [x10, #-0x4]
40002008: 121f796b     	and	w11, w11, #0xfffffffe
4000200c: 7100097f     	cmp	w11, #0x2
40002010: 54ffff40     	b.eq	0x40001ff8 <launch_ktop+0x44>
40002014: b940014b     	ldr	w11, [x10]
40002018: 11000421     	add	w1, w1, #0x1
4000201c: 0b080168     	add	w8, w11, w8
40002020: 17fffff6     	b	0x40001ff8 <launch_ktop+0x44>
40002024: 530a7d02     	lsr	w2, w8, #10
40002028: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000202c: 912b0000     	add	x0, x0, #0xac0
40002030: 940006c0     	bl	0x40003b30 <uart_printf>
40002034: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002038: 912fe800     	add	x0, x0, #0xbfa
4000203c: 940005a8     	bl	0x400036dc <uart_puts>
40002040: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002044: 9137c000     	add	x0, x0, #0xdf0
40002048: 940005a5     	bl	0x400036dc <uart_puts>
4000204c: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40002050: 910a0294     	add	x20, x20, #0x280
40002054: d0000035     	adrp	x21, 0x40008000 <__rodata_start+0x1000>
40002058: 913daab5     	add	x21, x21, #0xf6a
4000205c: d503201f     	nop
40002060: 1003bd56     	adr	x22, 0x40009808 <__rodata_start+0x2808>
40002064: 52800217     	mov	w23, #0x10              // =16
40002068: d0000033     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
4000206c: 91149673     	add	x19, x19, #0x525
40002070: 1400000a     	b	0x40002098 <launch_ktop+0xe4>
40002074: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002078: b85d4281     	ldur	w1, [x20, #-0x2c]
4000207c: d100a285     	sub	x5, x20, #0x28
40002080: aa1303e0     	mov	x0, x19
40002084: 530a7d03     	lsr	w3, w8, #10
40002088: 940006aa     	bl	0x40003b30 <uart_printf>
4000208c: f10006f7     	subs	x23, x23, #0x1
40002090: 9100c294     	add	x20, x20, #0x30
40002094: 54000120     	b.eq	0x400020b8 <launch_ktop+0x104>
40002098: b85f8288     	ldur	w8, [x20, #-0x8]
4000209c: 71000d1f     	cmp	w8, #0x3
400020a0: 54ffff60     	b.eq	0x4000208c <launch_ktop+0xd8>
400020a4: 7100091f     	cmp	w8, #0x2
400020a8: aa1503e2     	mov	x2, x21
400020ac: 54fffe48     	b.hi	0x40002074 <launch_ktop+0xc0>
400020b0: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
400020b4: 17fffff0     	b	0x40002074 <launch_ktop+0xc0>
400020b8: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400020bc: 91073400     	add	x0, x0, #0x1cd
400020c0: 94000587     	bl	0x400036dc <uart_puts>
400020c4: 52808114     	mov	w20, #0x408             // =1032
400020c8: 52800033     	mov	w19, #0x1               // =1
400020cc: 72a02014     	movk	w20, #0x100, lsl #16
400020d0: 14000003     	b	0x400020dc <launch_ktop+0x128>
400020d4: 7101c51f     	cmp	w8, #0x71
400020d8: 54000100     	b.eq	0x400020f8 <launch_ktop+0x144>
400020dc: 940005b4     	bl	0x400037ac <uart_getc>
400020e0: 12001c08     	and	w8, w0, #0xff
400020e4: 7100611f     	cmp	w8, #0x18
400020e8: 54ffff68     	b.hi	0x400020d4 <launch_ktop+0x120>
400020ec: 1ac82269     	lsl	w9, w19, w8
400020f0: 6a14013f     	tst	w9, w20
400020f4: 54ffff00     	b.eq	0x400020d4 <launch_ktop+0x120>
400020f8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400020fc: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002100: 912bcc00     	add	x0, x0, #0xaf3
40002104: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002108: f9400bf7     	ldr	x23, [sp, #0x10]
4000210c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002110: 14000573     	b	0x400036dc <uart_puts>

0000000040002114 <script_init>:
40002114: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002118: 90000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
4000211c: d503201f     	nop
40002120: 1002d8c0     	adr	x0, 0x40007c38 <__rodata_start+0xc38>
40002124: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40002128: 912a0821     	add	x1, x1, #0xa82
4000212c: 910003fd     	mov	x29, sp
40002130: b905551f     	str	wzr, [x8, #0x554]
40002134: 94000007     	bl	0x40002150 <script_set_var>
40002138: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000213c: 9134f400     	add	x0, x0, #0xd3d
40002140: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40002144: 911ba421     	add	x1, x1, #0x6e9
40002148: a8c17bfd     	ldp	x29, x30, [sp], #0x10
4000214c: 14000001     	b	0x40002150 <script_set_var>

0000000040002150 <script_set_var>:
40002150: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002154: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002158: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
4000215c: 910003fd     	mov	x29, sp
40002160: b94556e8     	ldr	w8, [x23, #0x554]
40002164: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002168: aa0103f3     	mov	x19, x1
4000216c: aa0003f4     	mov	x20, x0
40002170: a90257f6     	stp	x22, x21, [sp, #0x20]
40002174: 7100051f     	cmp	w8, #0x1
40002178: 5400024b     	b.lt	0x400021c0 <script_set_var+0x70>
4000217c: aa1f03f8     	mov	x24, xzr
40002180: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002184: 912562b5     	add	x21, x21, #0x958
40002188: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
4000218c: 911562d6     	add	x22, x22, #0x558
40002190: aa1603e0     	mov	x0, x22
40002194: aa1403e1     	mov	x1, x20
40002198: 940001b6     	bl	0x40002870 <kstrcmp>
4000219c: 340003e0     	cbz	w0, 0x40002218 <script_set_var+0xc8>
400021a0: b98556e8     	ldrsw	x8, [x23, #0x554]
400021a4: 91000718     	add	x24, x24, #0x1
400021a8: 910202b5     	add	x21, x21, #0x80
400021ac: 910082d6     	add	x22, x22, #0x20
400021b0: eb08031f     	cmp	x24, x8
400021b4: 54fffeeb     	b.lt	0x40002190 <script_set_var+0x40>
400021b8: 71007d1f     	cmp	w8, #0x1f
400021bc: 5400038c     	b.gt	0x4000222c <script_set_var+0xdc>
400021c0: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
400021c4: 911562b5     	add	x21, x21, #0x558
400021c8: aa1403e1     	mov	x1, x20
400021cc: 93407d08     	sxtw	x8, w8
400021d0: 528003e2     	mov	w2, #0x1f               // =31
400021d4: 8b0816a0     	add	x0, x21, x8, lsl #5
400021d8: 940001cc     	bl	0x40002908 <kstrncpy>
400021dc: b98556e8     	ldrsw	x8, [x23, #0x554]
400021e0: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
400021e4: 91256294     	add	x20, x20, #0x958
400021e8: aa1303e1     	mov	x1, x19
400021ec: 52800fe2     	mov	w2, #0x7f               // =127
400021f0: 8b0816a9     	add	x9, x21, x8, lsl #5
400021f4: 8b081e80     	add	x0, x20, x8, lsl #7
400021f8: 39007d3f     	strb	wzr, [x9, #0x1f]
400021fc: 940001c3     	bl	0x40002908 <kstrncpy>
40002200: b98556e8     	ldrsw	x8, [x23, #0x554]
40002204: 8b081e89     	add	x9, x20, x8, lsl #7
40002208: 11000508     	add	w8, w8, #0x1
4000220c: b90556e8     	str	w8, [x23, #0x554]
40002210: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002214: 14000006     	b	0x4000222c <script_set_var+0xdc>
40002218: aa1503e0     	mov	x0, x21
4000221c: aa1303e1     	mov	x1, x19
40002220: 52800fe2     	mov	w2, #0x7f               // =127
40002224: 940001b9     	bl	0x40002908 <kstrncpy>
40002228: 3901febf     	strb	wzr, [x21, #0x7f]
4000222c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002230: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002234: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002238: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000223c: d65f03c0     	ret

0000000040002240 <script_get_var>:
40002240: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002244: a90257f6     	stp	x22, x21, [sp, #0x20]
40002248: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
4000224c: 910003fd     	mov	x29, sp
40002250: b94556c8     	ldr	w8, [x22, #0x554]
40002254: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002258: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000225c: 7100051f     	cmp	w8, #0x1
40002260: 540002ab     	b.lt	0x400022b4 <script_get_var+0x74>
40002264: aa0003f4     	mov	x20, x0
40002268: aa1f03f7     	mov	x23, xzr
4000226c: 90000073     	adrp	x19, 0x4000e000 <__bss_start+0x3000>
40002270: 91256273     	add	x19, x19, #0x958
40002274: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002278: 911562b5     	add	x21, x21, #0x558
4000227c: b0000038     	adrp	x24, 0x40007000 <__rodata_start>
40002280: 91250718     	add	x24, x24, #0x941
40002284: aa1503e0     	mov	x0, x21
40002288: aa1403e1     	mov	x1, x20
4000228c: 94000179     	bl	0x40002870 <kstrcmp>
40002290: 34000160     	cbz	w0, 0x400022bc <script_get_var+0x7c>
40002294: b98556c8     	ldrsw	x8, [x22, #0x554]
40002298: 910006f7     	add	x23, x23, #0x1
4000229c: 91020273     	add	x19, x19, #0x80
400022a0: 910082b5     	add	x21, x21, #0x20
400022a4: eb0802ff     	cmp	x23, x8
400022a8: 54fffeeb     	b.lt	0x40002284 <script_get_var+0x44>
400022ac: aa1803f3     	mov	x19, x24
400022b0: 14000003     	b	0x400022bc <script_get_var+0x7c>
400022b4: b0000033     	adrp	x19, 0x40007000 <__rodata_start>
400022b8: 91250673     	add	x19, x19, #0x941
400022bc: aa1303e0     	mov	x0, x19
400022c0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400022c4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400022c8: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400022cc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400022d0: d65f03c0     	ret

00000000400022d4 <script_expand_vars>:
400022d4: d10203ff     	sub	sp, sp, #0x80
400022d8: a9036ffc     	stp	x28, x27, [sp, #0x30]
400022dc: 2a1f03fc     	mov	w28, wzr
400022e0: a90467fa     	stp	x26, x25, [sp, #0x40]
400022e4: b0000039     	adrp	x25, 0x40007000 <__rodata_start>
400022e8: 91250739     	add	x25, x25, #0x941
400022ec: a9055ff8     	stp	x24, x23, [sp, #0x50]
400022f0: 910003f8     	mov	x24, sp
400022f4: 9000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400022f8: a90657f6     	stp	x22, x21, [sp, #0x60]
400022fc: 2a1f03f6     	mov	w22, wzr
40002300: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002304: aa0103f3     	mov	x19, x1
40002308: aa0003f4     	mov	x20, x0
4000230c: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002310: 910083fd     	add	x29, sp, #0x20
40002314: 14000001     	b	0x40002318 <script_expand_vars+0x44>
40002318: 93407f89     	sxtw	x9, w28
4000231c: 38696a88     	ldrb	w8, [x20, x9]
40002320: 7100911f     	cmp	w8, #0x24
40002324: 540000e0     	b.eq	0x40002340 <script_expand_vars+0x6c>
40002328: 34000788     	cbz	w8, 0x40002418 <script_expand_vars+0x144>
4000232c: 110006ca     	add	w10, w22, #0x1
40002330: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002334: 1100053c     	add	w28, w9, #0x1
40002338: 2a0a03f6     	mov	w22, w10
4000233c: 17fffff7     	b	0x40002318 <script_expand_vars+0x44>
40002340: aa1f03e8     	mov	x8, xzr
40002344: 14000005     	b	0x40002358 <script_expand_vars+0x84>
40002348: 9100050a     	add	x10, x8, #0x1
4000234c: 38286b09     	strb	w9, [x24, x8]
40002350: d1000789     	sub	x9, x28, #0x1
40002354: aa0a03e8     	mov	x8, x10
40002358: 9100053c     	add	x28, x9, #0x1
4000235c: 14000004     	b	0x4000236c <script_expand_vars+0x98>
40002360: f100791f     	cmp	x8, #0x1e
40002364: 9100079c     	add	x28, x28, #0x1
40002368: 54ffff09     	b.ls	0x40002348 <script_expand_vars+0x74>
4000236c: 387c6a89     	ldrb	w9, [x20, x28]
40002370: 121a792a     	and	w10, w9, #0xffffffdf
40002374: 5101054a     	sub	w10, w10, #0x41
40002378: 7100695f     	cmp	w10, #0x1a
4000237c: 54ffff23     	b.lo	0x40002360 <script_expand_vars+0x8c>
40002380: 71017d3f     	cmp	w9, #0x5f
40002384: 54fffee0     	b.eq	0x40002360 <script_expand_vars+0x8c>
40002388: 5100c12a     	sub	w10, w9, #0x30
4000238c: 7100255f     	cmp	w10, #0x9
40002390: 54fffe89     	b.ls	0x40002360 <script_expand_vars+0x8c>
40002394: b9455749     	ldr	w9, [x26, #0x554]
40002398: 38286b1f     	strb	wzr, [x24, x8]
4000239c: 7100053f     	cmp	w9, #0x1
400023a0: 5400028b     	b.lt	0x400023f0 <script_expand_vars+0x11c>
400023a4: aa1f03fb     	mov	x27, xzr
400023a8: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
400023ac: 911562b5     	add	x21, x21, #0x558
400023b0: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
400023b4: 912562f7     	add	x23, x23, #0x958
400023b8: 910003e1     	mov	x1, sp
400023bc: aa1503e0     	mov	x0, x21
400023c0: 9400012c     	bl	0x40002870 <kstrcmp>
400023c4: 34000100     	cbz	w0, 0x400023e4 <script_expand_vars+0x110>
400023c8: b9855748     	ldrsw	x8, [x26, #0x554]
400023cc: 9100077b     	add	x27, x27, #0x1
400023d0: 910202f7     	add	x23, x23, #0x80
400023d4: 910082b5     	add	x21, x21, #0x20
400023d8: eb08037f     	cmp	x27, x8
400023dc: 54fffeeb     	b.lt	0x400023b8 <script_expand_vars+0xe4>
400023e0: aa1903f7     	mov	x23, x25
400023e4: 394002e8     	ldrb	w8, [x23]
400023e8: 350000a8     	cbnz	w8, 0x400023fc <script_expand_vars+0x128>
400023ec: 17ffffcb     	b	0x40002318 <script_expand_vars+0x44>
400023f0: aa1903f7     	mov	x23, x25
400023f4: 394002e8     	ldrb	w8, [x23]
400023f8: 34fff908     	cbz	w8, 0x40002318 <script_expand_vars+0x44>
400023fc: 8b36c269     	add	x9, x19, w22, sxtw
40002400: 910006ea     	add	x10, x23, #0x1
40002404: 38001528     	strb	w8, [x9], #0x1
40002408: 110006d6     	add	w22, w22, #0x1
4000240c: 38401548     	ldrb	w8, [x10], #0x1
40002410: 35ffffa8     	cbnz	w8, 0x40002404 <script_expand_vars+0x130>
40002414: 17ffffc1     	b	0x40002318 <script_expand_vars+0x44>
40002418: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
4000241c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002420: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002424: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002428: a94467fa     	ldp	x26, x25, [sp, #0x40]
4000242c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002430: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002434: 910203ff     	add	sp, sp, #0x80
40002438: d65f03c0     	ret

000000004000243c <script_execute_line>:
4000243c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002440: a9014ffc     	stp	x28, x19, [sp, #0x10]
40002444: 910003fd     	mov	x29, sp
40002448: d10803ff     	sub	sp, sp, #0x200
4000244c: 14000004     	b	0x4000245c <script_execute_line+0x20>
40002450: 7100811f     	cmp	w8, #0x20
40002454: 54000121     	b.ne	0x40002478 <script_execute_line+0x3c>
40002458: 91000400     	add	x0, x0, #0x1
4000245c: 39400008     	ldrb	w8, [x0]
40002460: 71007d1f     	cmp	w8, #0x1f
40002464: 54ffff6c     	b.gt	0x40002450 <script_execute_line+0x14>
40002468: 7100251f     	cmp	w8, #0x9
4000246c: 54ffff60     	b.eq	0x40002458 <script_execute_line+0x1c>
40002470: 34001668     	cbz	w8, 0x4000273c <script_execute_line+0x300>
40002474: 14000003     	b	0x40002480 <script_execute_line+0x44>
40002478: 71008d1f     	cmp	w8, #0x23
4000247c: 54001600     	b.eq	0x4000273c <script_execute_line+0x300>
40002480: 910403e1     	add	x1, sp, #0x100
40002484: 910403f3     	add	x19, sp, #0x100
40002488: 97ffff93     	bl	0x400022d4 <script_expand_vars>
4000248c: 394403e9     	ldrb	w9, [sp, #0x100]
40002490: 34001529     	cbz	w9, 0x40002734 <script_execute_line+0x2f8>
40002494: 394407e8     	ldrb	w8, [sp, #0x101]
40002498: aa1f03ea     	mov	x10, xzr
4000249c: 2a0903eb     	mov	w11, w9
400024a0: 14000004     	b	0x400024b0 <script_execute_line+0x74>
400024a4: 9100054a     	add	x10, x10, #0x1
400024a8: 386a6a6b     	ldrb	w11, [x19, x10]
400024ac: 340003cb     	cbz	w11, 0x40002524 <script_execute_line+0xe8>
400024b0: b4ffffaa     	cbz	x10, 0x400024a4 <script_execute_line+0x68>
400024b4: 7100f57f     	cmp	w11, #0x3d
400024b8: 54ffff61     	b.ne	0x400024a4 <script_execute_line+0x68>
400024bc: 8b13014b     	add	x11, x10, x19
400024c0: 385ff16c     	ldurb	w12, [x11, #-0x1]
400024c4: 7100f59f     	cmp	w12, #0x3d
400024c8: 54fffee0     	b.eq	0x400024a4 <script_execute_line+0x68>
400024cc: 3940056b     	ldrb	w11, [x11, #0x1]
400024d0: 7100f57f     	cmp	w11, #0x3d
400024d4: 54fffe80     	b.eq	0x400024a4 <script_execute_line+0x68>
400024d8: aa1f03ec     	mov	x12, xzr
400024dc: 2a1f03eb     	mov	w11, wzr
400024e0: 386c6a6d     	ldrb	w13, [x19, x12]
400024e4: 9100058c     	add	x12, x12, #0x1
400024e8: 710081bf     	cmp	w13, #0x20
400024ec: 1a9f156b     	csinc	w11, w11, wzr, ne
400024f0: eb0c015f     	cmp	x10, x12
400024f4: 54ffff61     	b.ne	0x400024e0 <script_execute_line+0xa4>
400024f8: 35fffd6b     	cbnz	w11, 0x400024a4 <script_execute_line+0x68>
400024fc: 7101a53f     	cmp	w9, #0x69
40002500: 54fffd20     	b.eq	0x400024a4 <script_execute_line+0x68>
40002504: 7101991f     	cmp	w8, #0x66
40002508: 54fffce0     	b.eq	0x400024a4 <script_execute_line+0x68>
4000250c: 910403e8     	add	x8, sp, #0x100
40002510: 910403e0     	add	x0, sp, #0x100
40002514: 8b0a0101     	add	x1, x8, x10
40002518: 3800143f     	strb	wzr, [x1], #0x1
4000251c: 97ffff0d     	bl	0x40002150 <script_set_var>
40002520: 14000087     	b	0x4000273c <script_execute_line+0x300>
40002524: 394403e9     	ldrb	w9, [sp, #0x100]
40002528: 7101a53f     	cmp	w9, #0x69
4000252c: 54001041     	b.ne	0x40002734 <script_execute_line+0x2f8>
40002530: 7101991f     	cmp	w8, #0x66
40002534: 54001001     	b.ne	0x40002734 <script_execute_line+0x2f8>
40002538: 39440be8     	ldrb	w8, [sp, #0x102]
4000253c: 7100811f     	cmp	w8, #0x20
40002540: 54000fa1     	b.ne	0x40002734 <script_execute_line+0x2f8>
40002544: 39440fe9     	ldrb	w9, [sp, #0x103]
40002548: 7100813f     	cmp	w9, #0x20
4000254c: 54000081     	b.ne	0x4000255c <script_execute_line+0x120>
40002550: aa1f03e9     	mov	x9, xzr
40002554: 52800068     	mov	w8, #0x3                // =3
40002558: 14000014     	b	0x400025a8 <script_execute_line+0x16c>
4000255c: 910403ea     	add	x10, sp, #0x100
40002560: aa1f03e8     	mov	x8, xzr
40002564: 910303eb     	add	x11, sp, #0xc0
40002568: 9100114a     	add	x10, x10, #0x4
4000256c: 34000189     	cbz	w9, 0x4000259c <script_execute_line+0x160>
40002570: f100f91f     	cmp	x8, #0x3e
40002574: 54000148     	b.hi	0x4000259c <script_execute_line+0x160>
40002578: 38286969     	strb	w9, [x11, x8]
4000257c: 38686949     	ldrb	w9, [x10, x8]
40002580: 9100050c     	add	x12, x8, #0x1
40002584: aa0c03e8     	mov	x8, x12
40002588: 7100813f     	cmp	w9, #0x20
4000258c: 54ffff01     	b.ne	0x4000256c <script_execute_line+0x130>
40002590: 11000d8a     	add	w10, w12, #0x3
40002594: 2a0c03e8     	mov	w8, w12
40002598: 14000002     	b	0x400025a0 <script_execute_line+0x164>
4000259c: 11000d0a     	add	w10, w8, #0x3
400025a0: 2a0803e9     	mov	w9, w8
400025a4: 2a0a03e8     	mov	w8, w10
400025a8: 910303ea     	add	x10, sp, #0xc0
400025ac: 3829695f     	strb	wzr, [x10, x9]
400025b0: 910403e9     	add	x9, sp, #0x100
400025b4: 3868692a     	ldrb	w10, [x9, x8]
400025b8: 7100815f     	cmp	w10, #0x20
400025bc: 54000061     	b.ne	0x400025c8 <script_execute_line+0x18c>
400025c0: 91000508     	add	x8, x8, #0x1
400025c4: 17fffffc     	b	0x400025b4 <script_execute_line+0x178>
400025c8: 7100855f     	cmp	w10, #0x21
400025cc: 54000060     	b.eq	0x400025d8 <script_execute_line+0x19c>
400025d0: 7100f55f     	cmp	w10, #0x3d
400025d4: 540000e1     	b.ne	0x400025f0 <script_execute_line+0x1b4>
400025d8: 11000509     	add	w9, w8, #0x1
400025dc: 910403ea     	add	x10, sp, #0x100
400025e0: 38694949     	ldrb	w9, [x10, w9, uxtw]
400025e4: 9100090a     	add	x10, x8, #0x2
400025e8: 7100f53f     	cmp	w9, #0x3d
400025ec: 9a880148     	csel	x8, x10, x8, eq
400025f0: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
400025f4: 910403ea     	add	x10, sp, #0x100
400025f8: d2c0002b     	mov	x11, #0x100000000       // =4294967296
400025fc: 8b088129     	add	x9, x9, x8, lsl #32
40002600: 8b28c14a     	add	x10, x10, w8, sxtw
40002604: 51000508     	sub	w8, w8, #0x1
40002608: 3840154c     	ldrb	w12, [x10], #0x1
4000260c: 8b0b0129     	add	x9, x9, x11
40002610: 11000508     	add	w8, w8, #0x1
40002614: 7100819f     	cmp	w12, #0x20
40002618: 54ffff80     	b.eq	0x40002608 <script_execute_line+0x1cc>
4000261c: 9360fd2c     	asr	x12, x9, #32
40002620: 910403e9     	add	x9, sp, #0x100
40002624: 386c692d     	ldrb	w13, [x9, x12]
40002628: 710081bf     	cmp	w13, #0x20
4000262c: 54000061     	b.ne	0x40002638 <script_execute_line+0x1fc>
40002630: aa1f03ea     	mov	x10, xzr
40002634: 14000010     	b	0x40002674 <script_execute_line+0x238>
40002638: aa1f03eb     	mov	x11, xzr
4000263c: 910203ec     	add	x12, sp, #0x80
40002640: 3400016d     	cbz	w13, 0x4000266c <script_execute_line+0x230>
40002644: f100f97f     	cmp	x11, #0x3e
40002648: 54000128     	b.hi	0x4000266c <script_execute_line+0x230>
4000264c: 382b698d     	strb	w13, [x12, x11]
40002650: 386b694d     	ldrb	w13, [x10, x11]
40002654: 9100056e     	add	x14, x11, #0x1
40002658: 11000508     	add	w8, w8, #0x1
4000265c: aa0e03eb     	mov	x11, x14
40002660: 710081bf     	cmp	w13, #0x20
40002664: 54fffee1     	b.ne	0x40002640 <script_execute_line+0x204>
40002668: 2a0e03eb     	mov	w11, w14
4000266c: 93407d0c     	sxtw	x12, w8
40002670: 2a0b03ea     	mov	w10, w11
40002674: d3607d8d     	lsl	x13, x12, #32
40002678: 910203eb     	add	x11, sp, #0x80
4000267c: d2c0006f     	mov	x15, #0x300000000       // =12884901888
40002680: d2c00050     	mov	x16, #0x200000000       // =8589934592
40002684: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002688: 11001108     	add	w8, w8, #0x4
4000268c: 382a697f     	strb	wzr, [x11, x10]
40002690: 8b0f01aa     	add	x10, x13, x15
40002694: 8b1001ab     	add	x11, x13, x16
40002698: 8b0e01ad     	add	x13, x13, x14
4000269c: 8b0c0129     	add	x9, x9, x12
400026a0: 3840152c     	ldrb	w12, [x9], #0x1
400026a4: 7100819f     	cmp	w12, #0x20
400026a8: 540000c1     	b.ne	0x400026c0 <script_execute_line+0x284>
400026ac: 11000508     	add	w8, w8, #0x1
400026b0: 8b0e014a     	add	x10, x10, x14
400026b4: 8b0e016b     	add	x11, x11, x14
400026b8: 8b0e01ad     	add	x13, x13, x14
400026bc: 17fffff9     	b	0x400026a0 <script_execute_line+0x264>
400026c0: 7101d19f     	cmp	w12, #0x74
400026c4: 54000381     	b.ne	0x40002734 <script_execute_line+0x2f8>
400026c8: 9360fdac     	asr	x12, x13, #32
400026cc: 910403e9     	add	x9, sp, #0x100
400026d0: 386c692c     	ldrb	w12, [x9, x12]
400026d4: 7101a19f     	cmp	w12, #0x68
400026d8: 540002e1     	b.ne	0x40002734 <script_execute_line+0x2f8>
400026dc: 9360fd6b     	asr	x11, x11, #32
400026e0: 386b6929     	ldrb	w9, [x9, x11]
400026e4: 7101953f     	cmp	w9, #0x65
400026e8: 54000261     	b.ne	0x40002734 <script_execute_line+0x2f8>
400026ec: 9360fd4a     	asr	x10, x10, #32
400026f0: 910403e9     	add	x9, sp, #0x100
400026f4: 386a692a     	ldrb	w10, [x9, x10]
400026f8: 7101b95f     	cmp	w10, #0x6e
400026fc: 540001c1     	b.ne	0x40002734 <script_execute_line+0x2f8>
40002700: 8b28c128     	add	x8, x9, w8, sxtw
40002704: d1000501     	sub	x1, x8, #0x1
40002708: 38401c28     	ldrb	w8, [x1, #0x1]!
4000270c: 7100811f     	cmp	w8, #0x20
40002710: 54ffffc0     	b.eq	0x40002708 <script_execute_line+0x2cc>
40002714: 910003e0     	mov	x0, sp
40002718: 94000075     	bl	0x400028ec <kstrcpy>
4000271c: 910303e0     	add	x0, sp, #0xc0
40002720: 910203e1     	add	x1, sp, #0x80
40002724: 94000053     	bl	0x40002870 <kstrcmp>
40002728: 350000a0     	cbnz	w0, 0x4000273c <script_execute_line+0x300>
4000272c: 910003e0     	mov	x0, sp
40002730: 14000002     	b	0x40002738 <script_execute_line+0x2fc>
40002734: 910403e0     	add	x0, sp, #0x100
40002738: 97fff9c1     	bl	0x40000e3c <execute_command>
4000273c: 2a1f03e0     	mov	w0, wzr
40002740: 910803ff     	add	sp, sp, #0x200
40002744: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002748: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000274c: d65f03c0     	ret

0000000040002750 <script_run_file>:
40002750: d10503ff     	sub	sp, sp, #0x140
40002754: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002758: 910403fd     	add	x29, sp, #0x100
4000275c: f9008bfc     	str	x28, [sp, #0x110]
40002760: a91257f6     	stp	x22, x21, [sp, #0x120]
40002764: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002768: aa0003f4     	mov	x20, x0
4000276c: 940008ba     	bl	0x40004a54 <vfs_find>
40002770: b4000080     	cbz	x0, 0x40002780 <script_run_file+0x30>
40002774: b9402008     	ldr	w8, [x0, #0x20]
40002778: aa0003f3     	mov	x19, x0
4000277c: 340000e8     	cbz	w8, 0x40002798 <script_run_file+0x48>
40002780: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002784: 91038400     	add	x0, x0, #0xe1
40002788: aa1403e1     	mov	x1, x20
4000278c: 940004e9     	bl	0x40003b30 <uart_printf>
40002790: 12800000     	mov	w0, #-0x1               // =-1
40002794: 14000021     	b	0x40002818 <script_run_file+0xc8>
40002798: f9401668     	ldr	x8, [x19, #0x28]
4000279c: aa1f03f4     	mov	x20, xzr
400027a0: 2a1f03e9     	mov	w9, wzr
400027a4: 9100c275     	add	x21, x19, #0x30
400027a8: 910003f6     	mov	x22, sp
400027ac: 14000008     	b	0x400027cc <script_run_file+0x7c>
400027b0: 7100053f     	cmp	w9, #0x1
400027b4: 3829cadf     	strb	wzr, [x22, w9, sxtw]
400027b8: 2a1f03e9     	mov	w9, wzr
400027bc: 5400022a     	b.ge	0x40002800 <script_run_file+0xb0>
400027c0: 91000694     	add	x20, x20, #0x1
400027c4: eb08029f     	cmp	x20, x8
400027c8: 54000268     	b.hi	0x40002814 <script_run_file+0xc4>
400027cc: eb08029f     	cmp	x20, x8
400027d0: 54ffff00     	b.eq	0x400027b0 <script_run_file+0x60>
400027d4: 38746aaa     	ldrb	w10, [x21, x20]
400027d8: 7100295f     	cmp	w10, #0xa
400027dc: 54fffea0     	b.eq	0x400027b0 <script_run_file+0x60>
400027e0: 7100355f     	cmp	w10, #0xd
400027e4: 54fffee0     	b.eq	0x400027c0 <script_run_file+0x70>
400027e8: 7103f93f     	cmp	w9, #0xfe
400027ec: 54fffeac     	b.gt	0x400027c0 <script_run_file+0x70>
400027f0: 1100052b     	add	w11, w9, #0x1
400027f4: 3829caca     	strb	w10, [x22, w9, sxtw]
400027f8: 2a0b03e9     	mov	w9, w11
400027fc: 17fffff1     	b	0x400027c0 <script_run_file+0x70>
40002800: 910003e0     	mov	x0, sp
40002804: 97ffff0e     	bl	0x4000243c <script_execute_line>
40002808: f9401668     	ldr	x8, [x19, #0x28]
4000280c: 2a1f03e9     	mov	w9, wzr
40002810: 17ffffec     	b	0x400027c0 <script_run_file+0x70>
40002814: 2a1f03e0     	mov	w0, wzr
40002818: a9534ff4     	ldp	x20, x19, [sp, #0x130]
4000281c: f9408bfc     	ldr	x28, [sp, #0x110]
40002820: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002824: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002828: 910503ff     	add	sp, sp, #0x140
4000282c: d65f03c0     	ret

0000000040002830 <kstrlen>:
40002830: b40000c0     	cbz	x0, 0x40002848 <kstrlen+0x18>
40002834: aa1f03e8     	mov	x8, xzr
40002838: 38686809     	ldrb	w9, [x0, x8]
4000283c: 91000508     	add	x8, x8, #0x1
40002840: 35ffffc9     	cbnz	w9, 0x40002838 <kstrlen+0x8>
40002844: d1000500     	sub	x0, x8, #0x1
40002848: d65f03c0     	ret

000000004000284c <kstrcat>:
4000284c: b4000100     	cbz	x0, 0x4000286c <kstrcat+0x20>
40002850: b40000e1     	cbz	x1, 0x4000286c <kstrcat+0x20>
40002854: d1000408     	sub	x8, x0, #0x1
40002858: 38401d09     	ldrb	w9, [x8, #0x1]!
4000285c: 35ffffe9     	cbnz	w9, 0x40002858 <kstrcat+0xc>
40002860: 38401429     	ldrb	w9, [x1], #0x1
40002864: 38001509     	strb	w9, [x8], #0x1
40002868: 35ffffc9     	cbnz	w9, 0x40002860 <kstrcat+0x14>
4000286c: d65f03c0     	ret

0000000040002870 <kstrcmp>:
40002870: aa0003e8     	mov	x8, x0
40002874: 12800000     	mov	w0, #-0x1               // =-1
40002878: b4000188     	cbz	x8, 0x400028a8 <kstrcmp+0x38>
4000287c: b4000161     	cbz	x1, 0x400028a8 <kstrcmp+0x38>
40002880: 38401509     	ldrb	w9, [x8], #0x1
40002884: 340000e9     	cbz	w9, 0x400028a0 <kstrcmp+0x30>
40002888: 3940002a     	ldrb	w10, [x1]
4000288c: 6b0a013f     	cmp	w9, w10
40002890: 54000081     	b.ne	0x400028a0 <kstrcmp+0x30>
40002894: 38401509     	ldrb	w9, [x8], #0x1
40002898: 91000421     	add	x1, x1, #0x1
4000289c: 35ffff69     	cbnz	w9, 0x40002888 <kstrcmp+0x18>
400028a0: 39400028     	ldrb	w8, [x1]
400028a4: 4b080120     	sub	w0, w9, w8
400028a8: d65f03c0     	ret

00000000400028ac <kstrncmp>:
400028ac: 12800008     	mov	w8, #-0x1               // =-1
400028b0: b4000160     	cbz	x0, 0x400028dc <kstrncmp+0x30>
400028b4: b4000141     	cbz	x1, 0x400028dc <kstrncmp+0x30>
400028b8: b4000102     	cbz	x2, 0x400028d8 <kstrncmp+0x2c>
400028bc: 38401408     	ldrb	w8, [x0], #0x1
400028c0: 38401429     	ldrb	w9, [x1], #0x1
400028c4: 34000108     	cbz	w8, 0x400028e4 <kstrncmp+0x38>
400028c8: 6b09011f     	cmp	w8, w9
400028cc: 540000c1     	b.ne	0x400028e4 <kstrncmp+0x38>
400028d0: f1000442     	subs	x2, x2, #0x1
400028d4: 54ffff41     	b.ne	0x400028bc <kstrncmp+0x10>
400028d8: 2a1f03e8     	mov	w8, wzr
400028dc: 2a0803e0     	mov	w0, w8
400028e0: d65f03c0     	ret
400028e4: 4b090100     	sub	w0, w8, w9
400028e8: d65f03c0     	ret

00000000400028ec <kstrcpy>:
400028ec: b40000c0     	cbz	x0, 0x40002904 <kstrcpy+0x18>
400028f0: b40000a1     	cbz	x1, 0x40002904 <kstrcpy+0x18>
400028f4: aa0003e8     	mov	x8, x0
400028f8: 38401429     	ldrb	w9, [x1], #0x1
400028fc: 38001509     	strb	w9, [x8], #0x1
40002900: 35ffffc9     	cbnz	w9, 0x400028f8 <kstrcpy+0xc>
40002904: d65f03c0     	ret

0000000040002908 <kstrncpy>:
40002908: b4000480     	cbz	x0, 0x40002998 <kstrncpy+0x90>
4000290c: b4000461     	cbz	x1, 0x40002998 <kstrncpy+0x90>
40002910: b4000442     	cbz	x2, 0x40002998 <kstrncpy+0x90>
40002914: aa1f03e9     	mov	x9, xzr
40002918: aa0203e8     	mov	x8, x2
4000291c: 3869682a     	ldrb	w10, [x1, x9]
40002920: 3829680a     	strb	w10, [x0, x9]
40002924: 340000ca     	cbz	w10, 0x4000293c <kstrncpy+0x34>
40002928: 91000529     	add	x9, x9, #0x1
4000292c: d1000508     	sub	x8, x8, #0x1
40002930: eb09005f     	cmp	x2, x9
40002934: 54ffff41     	b.ne	0x4000291c <kstrncpy+0x14>
40002938: 14000018     	b	0x40002998 <kstrncpy+0x90>
4000293c: cb09004a     	sub	x10, x2, x9
40002940: 8b090009     	add	x9, x0, x9
40002944: f100095f     	cmp	x10, #0x2
40002948: 54000082     	b.hs	0x40002958 <kstrncpy+0x50>
4000294c: 91000528     	add	x8, x9, #0x1
40002950: aa0a03e9     	mov	x9, x10
40002954: 1400000e     	b	0x4000298c <kstrncpy+0x84>
40002958: 927ff908     	and	x8, x8, #0xfffffffffffffffe
4000295c: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002960: 9100092c     	add	x12, x9, #0x2
40002964: 8b090108     	add	x8, x8, x9
40002968: 92400149     	and	x9, x10, #0x1
4000296c: aa0b03ed     	mov	x13, x11
40002970: 91000508     	add	x8, x8, #0x1
40002974: f10009ad     	subs	x13, x13, #0x2
40002978: 381ff19f     	sturb	wzr, [x12, #-0x1]
4000297c: 3800259f     	strb	wzr, [x12], #0x2
40002980: 54ffffa1     	b.ne	0x40002974 <kstrncpy+0x6c>
40002984: eb0b015f     	cmp	x10, x11
40002988: 54000080     	b.eq	0x40002998 <kstrncpy+0x90>
4000298c: f1000529     	subs	x9, x9, #0x1
40002990: 3800151f     	strb	wzr, [x8], #0x1
40002994: 54ffffc1     	b.ne	0x4000298c <kstrncpy+0x84>
40002998: d65f03c0     	ret

000000004000299c <memset>:
4000299c: b40002a0     	cbz	x0, 0x400029f0 <memset+0x54>
400029a0: b4000282     	cbz	x2, 0x400029f0 <memset+0x54>
400029a4: f100085f     	cmp	x2, #0x2
400029a8: 54000082     	b.hs	0x400029b8 <memset+0x1c>
400029ac: aa0003e8     	mov	x8, x0
400029b0: aa0203e9     	mov	x9, x2
400029b4: 1400000c     	b	0x400029e4 <memset+0x48>
400029b8: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
400029bc: 92400049     	and	x9, x2, #0x1
400029c0: 9100040b     	add	x11, x0, #0x1
400029c4: 8b0a0008     	add	x8, x0, x10
400029c8: aa0a03ec     	mov	x12, x10
400029cc: f100098c     	subs	x12, x12, #0x2
400029d0: 381ff161     	sturb	w1, [x11, #-0x1]
400029d4: 38002561     	strb	w1, [x11], #0x2
400029d8: 54ffffa1     	b.ne	0x400029cc <memset+0x30>
400029dc: eb0a005f     	cmp	x2, x10
400029e0: 54000080     	b.eq	0x400029f0 <memset+0x54>
400029e4: f1000529     	subs	x9, x9, #0x1
400029e8: 38001501     	strb	w1, [x8], #0x1
400029ec: 54ffffc1     	b.ne	0x400029e4 <memset+0x48>
400029f0: d65f03c0     	ret

00000000400029f4 <memcpy>:
400029f4: b4000100     	cbz	x0, 0x40002a14 <memcpy+0x20>
400029f8: b40000e1     	cbz	x1, 0x40002a14 <memcpy+0x20>
400029fc: b40000c2     	cbz	x2, 0x40002a14 <memcpy+0x20>
40002a00: aa0003e8     	mov	x8, x0
40002a04: 38401429     	ldrb	w9, [x1], #0x1
40002a08: f1000442     	subs	x2, x2, #0x1
40002a0c: 38001509     	strb	w9, [x8], #0x1
40002a10: 54ffffa1     	b.ne	0x40002a04 <memcpy+0x10>
40002a14: d65f03c0     	ret

0000000040002a18 <kstrstr>:
40002a18: aa1f03e2     	mov	x2, xzr
40002a1c: b40000e0     	cbz	x0, 0x40002a38 <kstrstr+0x20>
40002a20: b40000c1     	cbz	x1, 0x40002a38 <kstrstr+0x20>
40002a24: 39400028     	ldrb	w8, [x1]
40002a28: 340002c8     	cbz	w8, 0x40002a80 <kstrstr+0x68>
40002a2c: 39400009     	ldrb	w9, [x0]
40002a30: 35000109     	cbnz	w9, 0x40002a50 <kstrstr+0x38>
40002a34: aa1f03e2     	mov	x2, xzr
40002a38: aa0203e0     	mov	x0, x2
40002a3c: d65f03c0     	ret
40002a40: 3940012c     	ldrb	w12, [x9]
40002a44: 340001ec     	cbz	w12, 0x40002a80 <kstrstr+0x68>
40002a48: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a4c: 34ffff49     	cbz	w9, 0x40002a34 <kstrstr+0x1c>
40002a50: 6b08013f     	cmp	w9, w8
40002a54: 54ffffa1     	b.ne	0x40002a48 <kstrstr+0x30>
40002a58: 5280002a     	mov	w10, #0x1               // =1
40002a5c: aa0103e9     	mov	x9, x1
40002a60: 2a0803eb     	mov	w11, w8
40002a64: 3840152c     	ldrb	w12, [x9], #0x1
40002a68: 6b0c017f     	cmp	w11, w12
40002a6c: 54fffec1     	b.ne	0x40002a44 <kstrstr+0x2c>
40002a70: 386a680b     	ldrb	w11, [x0, x10]
40002a74: 9100054a     	add	x10, x10, #0x1
40002a78: 35ffff6b     	cbnz	w11, 0x40002a64 <kstrstr+0x4c>
40002a7c: 17fffff1     	b	0x40002a40 <kstrstr+0x28>
40002a80: d65f03c0     	ret

0000000040002a84 <kstrchr>:
40002a84: b4000140     	cbz	x0, 0x40002aac <kstrchr+0x28>
40002a88: 39400009     	ldrb	w9, [x0]
40002a8c: 340000c9     	cbz	w9, 0x40002aa4 <kstrchr+0x20>
40002a90: 12001c28     	and	w8, w1, #0xff
40002a94: 6b08013f     	cmp	w9, w8
40002a98: 540000a0     	b.eq	0x40002aac <kstrchr+0x28>
40002a9c: 38401c09     	ldrb	w9, [x0, #0x1]!
40002aa0: 35ffffa9     	cbnz	w9, 0x40002a94 <kstrchr+0x10>
40002aa4: 72001c3f     	tst	w1, #0xff
40002aa8: 9a9f0000     	csel	x0, x0, xzr, eq
40002aac: d65f03c0     	ret

0000000040002ab0 <ktolower>:
40002ab0: 51010408     	sub	w8, w0, #0x41
40002ab4: 321b0009     	orr	w9, w0, #0x20
40002ab8: 7100691f     	cmp	w8, #0x1a
40002abc: 1a803120     	csel	w0, w9, w0, lo
40002ac0: d65f03c0     	ret

0000000040002ac4 <kstr_tolower>:
40002ac4: b40001a0     	cbz	x0, 0x40002af8 <kstr_tolower+0x34>
40002ac8: b4000181     	cbz	x1, 0x40002af8 <kstr_tolower+0x34>
40002acc: 39400029     	ldrb	w9, [x1]
40002ad0: 34000129     	cbz	w9, 0x40002af4 <kstr_tolower+0x30>
40002ad4: 91000428     	add	x8, x1, #0x1
40002ad8: 5101052a     	sub	w10, w9, #0x41
40002adc: 321b012b     	orr	w11, w9, #0x20
40002ae0: 7100695f     	cmp	w10, #0x1a
40002ae4: 1a893169     	csel	w9, w11, w9, lo
40002ae8: 38001409     	strb	w9, [x0], #0x1
40002aec: 38401509     	ldrb	w9, [x8], #0x1
40002af0: 35ffff49     	cbnz	w9, 0x40002ad8 <kstr_tolower+0x14>
40002af4: 3900001f     	strb	wzr, [x0]
40002af8: d65f03c0     	ret

0000000040002afc <timer_init>:
40002afc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002b00: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b04: f9000bf3     	str	x19, [sp, #0x10]
40002b08: d53be008     	mrs	x8, CNTFRQ_EL0
40002b0c: f29999a9     	movk	x9, #0xcccd
40002b10: b0000073     	adrp	x19, 0x4000f000 <var_values+0x6a8>
40002b14: 528003c0     	mov	w0, #0x1e               // =30
40002b18: 9bc97d09     	umulh	x9, x8, x9
40002b1c: 910003fd     	mov	x29, sp
40002b20: 5280002a     	mov	w10, #0x1               // =1
40002b24: f904ae68     	str	x8, [x19, #0x958]
40002b28: d343fd29     	lsr	x9, x9, #3
40002b2c: d51be209     	msr	CNTP_TVAL_EL0, x9
40002b30: d51be22a     	msr	CNTP_CTL_EL0, x10
40002b34: 97fff5c3     	bl	0x40000240 <gic_enable_interrupt>
40002b38: d50342ff     	msr	DAIFClr, #0x2
40002b3c: d503201f     	nop
40002b40: 30033c00     	adr	x0, 0x400092c1 <__rodata_start+0x22c1>
40002b44: b9495a61     	ldr	w1, [x19, #0x958]
40002b48: f9400bf3     	ldr	x19, [sp, #0x10]
40002b4c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002b50: 140003f8     	b	0x40003b30 <uart_printf>

0000000040002b54 <timer_handle_interrupt>:
40002b54: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b58: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002b5c: f944ad08     	ldr	x8, [x8, #0x958]
40002b60: f29999a9     	movk	x9, #0xcccd
40002b64: 9bc97d08     	umulh	x8, x8, x9
40002b68: b0000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40002b6c: f944b12a     	ldr	x10, [x9, #0x960]
40002b70: 9100054a     	add	x10, x10, #0x1
40002b74: f904b12a     	str	x10, [x9, #0x960]
40002b78: d343fd08     	lsr	x8, x8, #3
40002b7c: d51be208     	msr	CNTP_TVAL_EL0, x8
40002b80: d65f03c0     	ret

0000000040002b84 <tui_launch>:
40002b84: d105c3ff     	sub	sp, sp, #0x170
40002b88: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b8c: 910443fd     	add	x29, sp, #0x110
40002b90: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002b94: a91367fa     	stp	x26, x25, [sp, #0x130]
40002b98: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002b9c: a91557f6     	stp	x22, x21, [sp, #0x150]
40002ba0: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002ba4: 9400075a     	bl	0x4000490c <vfs_get_cwd>
40002ba8: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002bac: b000007c     	adrp	x28, 0x4000f000 <var_values+0x6a8>
40002bb0: b000007b     	adrp	x27, 0x4000f000 <var_values+0x6a8>
40002bb4: f904b500     	str	x0, [x8, #0x968]
40002bb8: d503201f     	nop
40002bbc: 1002e900     	adr	x0, 0x400088dc <__rodata_start+0x18dc>
40002bc0: b909739f     	str	wzr, [x28, #0x970]
40002bc4: b909777f     	str	wzr, [x27, #0x974]
40002bc8: 940002c5     	bl	0x400036dc <uart_puts>
40002bcc: b0000036     	adrp	x22, 0x40007000 <__rodata_start>
40002bd0: 9110cad6     	add	x22, x22, #0x432
40002bd4: b0000037     	adrp	x23, 0x40007000 <__rodata_start>
40002bd8: 910c8af7     	add	x23, x23, #0x322
40002bdc: b0000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40002be0: 91260318     	add	x24, x24, #0x980
40002be4: b000007a     	adrp	x26, 0x4000f000 <var_values+0x6a8>
40002be8: b0000034     	adrp	x20, 0x40007000 <__rodata_start>
40002bec: 91144e94     	add	x20, x20, #0x513
40002bf0: 14000005     	b	0x40002c04 <tui_launch+0x80>
40002bf4: b9497388     	ldr	w8, [x28, #0x970]
40002bf8: 7100011f     	cmp	w8, #0x0
40002bfc: 1a9f17e8     	cset	w8, eq
40002c00: b9097388     	str	w8, [x28, #0x970]
40002c04: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002c08: b9097b5f     	str	wzr, [x26, #0x978]
40002c0c: f944b50a     	ldr	x10, [x8, #0x968]
40002c10: f9421948     	ldr	x8, [x10, #0x430]
40002c14: b4000108     	cbz	x8, 0x40002c34 <tui_launch+0xb0>
40002c18: 52800029     	mov	w9, #0x1                // =1
40002c1c: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002c20: b9097b49     	str	w9, [x26, #0x978]
40002c24: f904c11f     	str	xzr, [x8, #0x980]
40002c28: f9401548     	ldr	x8, [x10, #0x28]
40002c2c: b50000a8     	cbnz	x8, 0x40002c40 <tui_launch+0xbc>
40002c30: 14000027     	b	0x40002ccc <tui_launch+0x148>
40002c34: 2a1f03e9     	mov	w9, wzr
40002c38: f9401548     	ldr	x8, [x10, #0x28]
40002c3c: b4000488     	cbz	x8, 0x40002ccc <tui_launch+0x148>
40002c40: 2a0903e9     	mov	w9, w9
40002c44: d100050c     	sub	x12, x8, #0x1
40002c48: d240152b     	eor	x11, x9, #0x3f
40002c4c: eb0b019f     	cmp	x12, x11
40002c50: 9a8b318b     	csel	x11, x12, x11, lo
40002c54: b400022c     	cbz	x12, 0x40002c98 <tui_launch+0x114>
40002c58: 9100056c     	add	x12, x11, #0x1
40002c5c: 8b090f0e     	add	x14, x24, x9, lsl #3
40002c60: 9111014d     	add	x13, x10, #0x440
40002c64: 927f798b     	and	x11, x12, #0xfffffffe
40002c68: aa090169     	orr	x9, x11, x9
40002c6c: 910021ce     	add	x14, x14, #0x8
40002c70: aa0b03ef     	mov	x15, x11
40002c74: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002c78: f10009ef     	subs	x15, x15, #0x2
40002c7c: 910041ad     	add	x13, x13, #0x10
40002c80: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002c84: 910041ce     	add	x14, x14, #0x10
40002c88: 54ffff61     	b.ne	0x40002c74 <tui_launch+0xf0>
40002c8c: eb0b019f     	cmp	x12, x11
40002c90: 54000061     	b.ne	0x40002c9c <tui_launch+0x118>
40002c94: 1400000d     	b	0x40002cc8 <tui_launch+0x144>
40002c98: aa1f03eb     	mov	x11, xzr
40002c9c: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002ca0: 9100056b     	add	x11, x11, #0x1
40002ca4: 9110e14a     	add	x10, x10, #0x438
40002ca8: f840854c     	ldr	x12, [x10], #0x8
40002cac: f100f93f     	cmp	x9, #0x3e
40002cb0: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002cb4: 91000529     	add	x9, x9, #0x1
40002cb8: 54000088     	b.hi	0x40002cc8 <tui_launch+0x144>
40002cbc: eb08017f     	cmp	x11, x8
40002cc0: 9100056b     	add	x11, x11, #0x1
40002cc4: 54ffff23     	b.lo	0x40002ca8 <tui_launch+0x124>
40002cc8: b9097b49     	str	w9, [x26, #0x978]
40002ccc: b949776a     	ldr	w10, [x27, #0x974]
40002cd0: 51000528     	sub	w8, w9, #0x1
40002cd4: 6b08015f     	cmp	w10, w8
40002cd8: 1a88b148     	csel	w8, w10, w8, lt
40002cdc: 6b09015f     	cmp	w10, w9
40002ce0: 5400004a     	b.ge	0x40002ce8 <tui_launch+0x164>
40002ce4: 36f80068     	tbz	w8, #0x1f, 0x40002cf0 <tui_launch+0x16c>
40002ce8: 0aa87d08     	bic	w8, w8, w8, asr #31
40002cec: b9097768     	str	w8, [x27, #0x974]
40002cf0: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002cf4: 91250800     	add	x0, x0, #0x942
40002cf8: 94000279     	bl	0x400036dc <uart_puts>
40002cfc: b9497388     	ldr	w8, [x28, #0x970]
40002d00: 52800020     	mov	w0, #0x1                // =1
40002d04: 52800501     	mov	w1, #0x28               // =40
40002d08: b0000022     	adrp	x2, 0x40007000 <__rodata_start>
40002d0c: 91023042     	add	x2, x2, #0x8c
40002d10: 7100011f     	cmp	w8, #0x0
40002d14: 1a9f17e3     	cset	w3, eq
40002d18: 94000171     	bl	0x400032dc <draw_box>
40002d1c: 52800075     	mov	w21, #0x3               // =3
40002d20: aa1603e0     	mov	x0, x22
40002d24: 2a1503e1     	mov	w1, w21
40002d28: 52800042     	mov	w2, #0x2                // =2
40002d2c: 94000381     	bl	0x40003b30 <uart_printf>
40002d30: aa1703e0     	mov	x0, x23
40002d34: 9400026a     	bl	0x400036dc <uart_puts>
40002d38: aa1703e0     	mov	x0, x23
40002d3c: 94000268     	bl	0x400036dc <uart_puts>
40002d40: aa1703e0     	mov	x0, x23
40002d44: 94000266     	bl	0x400036dc <uart_puts>
40002d48: aa1703e0     	mov	x0, x23
40002d4c: 94000264     	bl	0x400036dc <uart_puts>
40002d50: aa1703e0     	mov	x0, x23
40002d54: 94000262     	bl	0x400036dc <uart_puts>
40002d58: aa1703e0     	mov	x0, x23
40002d5c: 94000260     	bl	0x400036dc <uart_puts>
40002d60: aa1703e0     	mov	x0, x23
40002d64: 9400025e     	bl	0x400036dc <uart_puts>
40002d68: aa1703e0     	mov	x0, x23
40002d6c: 9400025c     	bl	0x400036dc <uart_puts>
40002d70: aa1703e0     	mov	x0, x23
40002d74: 9400025a     	bl	0x400036dc <uart_puts>
40002d78: aa1703e0     	mov	x0, x23
40002d7c: 94000258     	bl	0x400036dc <uart_puts>
40002d80: aa1703e0     	mov	x0, x23
40002d84: 94000256     	bl	0x400036dc <uart_puts>
40002d88: aa1703e0     	mov	x0, x23
40002d8c: 94000254     	bl	0x400036dc <uart_puts>
40002d90: aa1703e0     	mov	x0, x23
40002d94: 94000252     	bl	0x400036dc <uart_puts>
40002d98: aa1703e0     	mov	x0, x23
40002d9c: 94000250     	bl	0x400036dc <uart_puts>
40002da0: aa1703e0     	mov	x0, x23
40002da4: 9400024e     	bl	0x400036dc <uart_puts>
40002da8: aa1703e0     	mov	x0, x23
40002dac: 9400024c     	bl	0x400036dc <uart_puts>
40002db0: aa1703e0     	mov	x0, x23
40002db4: 9400024a     	bl	0x400036dc <uart_puts>
40002db8: aa1703e0     	mov	x0, x23
40002dbc: 94000248     	bl	0x400036dc <uart_puts>
40002dc0: aa1703e0     	mov	x0, x23
40002dc4: 94000246     	bl	0x400036dc <uart_puts>
40002dc8: aa1703e0     	mov	x0, x23
40002dcc: 94000244     	bl	0x400036dc <uart_puts>
40002dd0: aa1703e0     	mov	x0, x23
40002dd4: 94000242     	bl	0x400036dc <uart_puts>
40002dd8: aa1703e0     	mov	x0, x23
40002ddc: 94000240     	bl	0x400036dc <uart_puts>
40002de0: aa1703e0     	mov	x0, x23
40002de4: 9400023e     	bl	0x400036dc <uart_puts>
40002de8: aa1703e0     	mov	x0, x23
40002dec: 9400023c     	bl	0x400036dc <uart_puts>
40002df0: aa1703e0     	mov	x0, x23
40002df4: 9400023a     	bl	0x400036dc <uart_puts>
40002df8: aa1703e0     	mov	x0, x23
40002dfc: 94000238     	bl	0x400036dc <uart_puts>
40002e00: aa1703e0     	mov	x0, x23
40002e04: 94000236     	bl	0x400036dc <uart_puts>
40002e08: aa1703e0     	mov	x0, x23
40002e0c: 94000234     	bl	0x400036dc <uart_puts>
40002e10: aa1703e0     	mov	x0, x23
40002e14: 94000232     	bl	0x400036dc <uart_puts>
40002e18: aa1703e0     	mov	x0, x23
40002e1c: 94000230     	bl	0x400036dc <uart_puts>
40002e20: aa1703e0     	mov	x0, x23
40002e24: 9400022e     	bl	0x400036dc <uart_puts>
40002e28: aa1703e0     	mov	x0, x23
40002e2c: 9400022c     	bl	0x400036dc <uart_puts>
40002e30: aa1703e0     	mov	x0, x23
40002e34: 9400022a     	bl	0x400036dc <uart_puts>
40002e38: aa1703e0     	mov	x0, x23
40002e3c: 94000228     	bl	0x400036dc <uart_puts>
40002e40: aa1703e0     	mov	x0, x23
40002e44: 94000226     	bl	0x400036dc <uart_puts>
40002e48: aa1703e0     	mov	x0, x23
40002e4c: 94000224     	bl	0x400036dc <uart_puts>
40002e50: aa1703e0     	mov	x0, x23
40002e54: 94000222     	bl	0x400036dc <uart_puts>
40002e58: aa1703e0     	mov	x0, x23
40002e5c: 94000220     	bl	0x400036dc <uart_puts>
40002e60: 110006b5     	add	w21, w21, #0x1
40002e64: 71005ebf     	cmp	w21, #0x17
40002e68: 54fff5c1     	b.ne	0x40002d20 <tui_launch+0x19c>
40002e6c: b9497768     	ldr	w8, [x27, #0x974]
40002e70: 52800249     	mov	w9, #0x12               // =18
40002e74: 7100491f     	cmp	w8, #0x12
40002e78: 1a89c108     	csel	w8, w8, w9, gt
40002e7c: 51004915     	sub	w21, w8, #0x12
40002e80: 8b354f19     	add	x25, x24, w21, uxtw #3
40002e84: aa1f03f8     	mov	x24, xzr
40002e88: 14000004     	b	0x40002e98 <tui_launch+0x314>
40002e8c: 91000718     	add	x24, x24, #0x1
40002e90: f100531f     	cmp	x24, #0x14
40002e94: 540005a0     	b.eq	0x40002f48 <tui_launch+0x3c4>
40002e98: b9897b48     	ldrsw	x8, [x26, #0x978]
40002e9c: 8b1802b3     	add	x19, x21, x24
40002ea0: eb08027f     	cmp	x19, x8
40002ea4: 5400052a     	b.ge	0x40002f48 <tui_launch+0x3c4>
40002ea8: 11000f01     	add	w1, w24, #0x3
40002eac: aa1603e0     	mov	x0, x22
40002eb0: 52800062     	mov	w2, #0x3                // =3
40002eb4: 9400031f     	bl	0x40003b30 <uart_printf>
40002eb8: b9497768     	ldr	w8, [x27, #0x974]
40002ebc: eb08027f     	cmp	x19, x8
40002ec0: 540000c1     	b.ne	0x40002ed8 <tui_launch+0x354>
40002ec4: b9497388     	ldr	w8, [x28, #0x970]
40002ec8: 35000088     	cbnz	w8, 0x40002ed8 <tui_launch+0x354>
40002ecc: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002ed0: 91037000     	add	x0, x0, #0xdc
40002ed4: 94000202     	bl	0x400036dc <uart_puts>
40002ed8: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002edc: b40001e8     	cbz	x8, 0x40002f18 <tui_launch+0x394>
40002ee0: b9402108     	ldr	w8, [x8, #0x20]
40002ee4: d0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40002ee8: 910b5529     	add	x9, x9, #0x2d5
40002eec: 910223e0     	add	x0, sp, #0x88
40002ef0: 7100051f     	cmp	w8, #0x1
40002ef4: b0000028     	adrp	x8, 0x40007000 <__rodata_start>
40002ef8: 91360d08     	add	x8, x8, #0xd83
40002efc: 9a880121     	csel	x1, x9, x8, eq
40002f00: 97fffe7b     	bl	0x400028ec <kstrcpy>
40002f04: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002f08: 910223e0     	add	x0, sp, #0x88
40002f0c: 97fffe50     	bl	0x4000284c <kstrcat>
40002f10: 910223e0     	add	x0, sp, #0x88
40002f14: 14000003     	b	0x40002f20 <tui_launch+0x39c>
40002f18: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002f1c: 9130ec00     	add	x0, x0, #0xc3b
40002f20: 940001ef     	bl	0x400036dc <uart_puts>
40002f24: b9497768     	ldr	w8, [x27, #0x974]
40002f28: eb08027f     	cmp	x19, x8
40002f2c: 54fffb01     	b.ne	0x40002e8c <tui_launch+0x308>
40002f30: b9497388     	ldr	w8, [x28, #0x970]
40002f34: 35fffac8     	cbnz	w8, 0x40002e8c <tui_launch+0x308>
40002f38: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002f3c: 912ef000     	add	x0, x0, #0xbbc
40002f40: 940001e7     	bl	0x400036dc <uart_puts>
40002f44: 17ffffd2     	b	0x40002e8c <tui_launch+0x308>
40002f48: b9497388     	ldr	w8, [x28, #0x970]
40002f4c: 52800540     	mov	w0, #0x2a               // =42
40002f50: 528004c1     	mov	w1, #0x26               // =38
40002f54: d0000022     	adrp	x2, 0x40008000 <__rodata_start+0x1000>
40002f58: 9103f842     	add	x2, x2, #0xfe
40002f5c: 7100051f     	cmp	w8, #0x1
40002f60: 1a9f17e3     	cset	w3, eq
40002f64: 940000de     	bl	0x400032dc <draw_box>
40002f68: 52800075     	mov	w21, #0x3               // =3
40002f6c: aa1603e0     	mov	x0, x22
40002f70: 2a1503e1     	mov	w1, w21
40002f74: 52800562     	mov	w2, #0x2b               // =43
40002f78: 940002ee     	bl	0x40003b30 <uart_printf>
40002f7c: aa1703e0     	mov	x0, x23
40002f80: 940001d7     	bl	0x400036dc <uart_puts>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 940001d5     	bl	0x400036dc <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 940001d3     	bl	0x400036dc <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 940001d1     	bl	0x400036dc <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 940001cf     	bl	0x400036dc <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 940001cd     	bl	0x400036dc <uart_puts>
40002fac: aa1703e0     	mov	x0, x23
40002fb0: 940001cb     	bl	0x400036dc <uart_puts>
40002fb4: aa1703e0     	mov	x0, x23
40002fb8: 940001c9     	bl	0x400036dc <uart_puts>
40002fbc: aa1703e0     	mov	x0, x23
40002fc0: 940001c7     	bl	0x400036dc <uart_puts>
40002fc4: aa1703e0     	mov	x0, x23
40002fc8: 940001c5     	bl	0x400036dc <uart_puts>
40002fcc: aa1703e0     	mov	x0, x23
40002fd0: 940001c3     	bl	0x400036dc <uart_puts>
40002fd4: aa1703e0     	mov	x0, x23
40002fd8: 940001c1     	bl	0x400036dc <uart_puts>
40002fdc: aa1703e0     	mov	x0, x23
40002fe0: 940001bf     	bl	0x400036dc <uart_puts>
40002fe4: aa1703e0     	mov	x0, x23
40002fe8: 940001bd     	bl	0x400036dc <uart_puts>
40002fec: aa1703e0     	mov	x0, x23
40002ff0: 940001bb     	bl	0x400036dc <uart_puts>
40002ff4: aa1703e0     	mov	x0, x23
40002ff8: 940001b9     	bl	0x400036dc <uart_puts>
40002ffc: aa1703e0     	mov	x0, x23
40003000: 940001b7     	bl	0x400036dc <uart_puts>
40003004: aa1703e0     	mov	x0, x23
40003008: 940001b5     	bl	0x400036dc <uart_puts>
4000300c: aa1703e0     	mov	x0, x23
40003010: 940001b3     	bl	0x400036dc <uart_puts>
40003014: aa1703e0     	mov	x0, x23
40003018: 940001b1     	bl	0x400036dc <uart_puts>
4000301c: aa1703e0     	mov	x0, x23
40003020: 940001af     	bl	0x400036dc <uart_puts>
40003024: aa1703e0     	mov	x0, x23
40003028: 940001ad     	bl	0x400036dc <uart_puts>
4000302c: aa1703e0     	mov	x0, x23
40003030: 940001ab     	bl	0x400036dc <uart_puts>
40003034: aa1703e0     	mov	x0, x23
40003038: 940001a9     	bl	0x400036dc <uart_puts>
4000303c: aa1703e0     	mov	x0, x23
40003040: 940001a7     	bl	0x400036dc <uart_puts>
40003044: aa1703e0     	mov	x0, x23
40003048: 940001a5     	bl	0x400036dc <uart_puts>
4000304c: aa1703e0     	mov	x0, x23
40003050: 940001a3     	bl	0x400036dc <uart_puts>
40003054: aa1703e0     	mov	x0, x23
40003058: 940001a1     	bl	0x400036dc <uart_puts>
4000305c: aa1703e0     	mov	x0, x23
40003060: 9400019f     	bl	0x400036dc <uart_puts>
40003064: aa1703e0     	mov	x0, x23
40003068: 9400019d     	bl	0x400036dc <uart_puts>
4000306c: aa1703e0     	mov	x0, x23
40003070: 9400019b     	bl	0x400036dc <uart_puts>
40003074: aa1703e0     	mov	x0, x23
40003078: 94000199     	bl	0x400036dc <uart_puts>
4000307c: aa1703e0     	mov	x0, x23
40003080: 94000197     	bl	0x400036dc <uart_puts>
40003084: aa1703e0     	mov	x0, x23
40003088: 94000195     	bl	0x400036dc <uart_puts>
4000308c: aa1703e0     	mov	x0, x23
40003090: 94000193     	bl	0x400036dc <uart_puts>
40003094: aa1703e0     	mov	x0, x23
40003098: 94000191     	bl	0x400036dc <uart_puts>
4000309c: 110006b5     	add	w21, w21, #0x1
400030a0: 71005ebf     	cmp	w21, #0x17
400030a4: 54fff641     	b.ne	0x40002f6c <tui_launch+0x3e8>
400030a8: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400030ac: 91165800     	add	x0, x0, #0x596
400030b0: 52800061     	mov	w1, #0x3                // =3
400030b4: 52800562     	mov	w2, #0x2b               // =43
400030b8: 9400029e     	bl	0x40003b30 <uart_printf>
400030bc: d503201f     	nop
400030c0: 10058ca8     	adr	x8, 0x4000e254 <proc_table>
400030c4: aa1f03f3     	mov	x19, xzr
400030c8: 9100a115     	add	x21, x8, #0x28
400030cc: 52800058     	mov	w24, #0x2               // =2
400030d0: 90000039     	adrp	x25, 0x40007000 <__rodata_start>
400030d4: 91206f39     	add	x25, x25, #0x81b
400030d8: b85fc2a8     	ldur	w8, [x21, #-0x4]
400030dc: 71000d1f     	cmp	w8, #0x3
400030e0: 54000140     	b.eq	0x40003108 <tui_launch+0x584>
400030e4: b94002a8     	ldr	w8, [x21]
400030e8: b85d82a3     	ldur	w3, [x21, #-0x28]
400030ec: d10092a4     	sub	x4, x21, #0x24
400030f0: 11000b01     	add	w1, w24, #0x2
400030f4: aa1403e0     	mov	x0, x20
400030f8: 52800562     	mov	w2, #0x2b               // =43
400030fc: 530a7d05     	lsr	w5, w8, #10
40003100: 9400028c     	bl	0x40003b30 <uart_printf>
40003104: 11000718     	add	w24, w24, #0x1
40003108: f1003a7f     	cmp	x19, #0xe
4000310c: 540000a8     	b.hi	0x40003120 <tui_launch+0x59c>
40003110: 7100531f     	cmp	w24, #0x14
40003114: 91000673     	add	x19, x19, #0x1
40003118: 9100c2b5     	add	x21, x21, #0x30
4000311c: 54fffdeb     	b.lt	0x400030d8 <tui_launch+0x554>
40003120: 940001a3     	bl	0x400037ac <uart_getc>
40003124: 52801be8     	mov	w8, #0xdf               // =223
40003128: 0a080008     	and	w8, w0, w8
4000312c: 7101451f     	cmp	w8, #0x51
40003130: 54000c00     	b.eq	0x400032b0 <tui_launch+0x72c>
40003134: 12001c08     	and	w8, w0, #0xff
40003138: 7100311f     	cmp	w8, #0xc
4000313c: 5400010c     	b.gt	0x4000315c <tui_launch+0x5d8>
40003140: 7100251f     	cmp	w8, #0x9
40003144: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40003148: 91260318     	add	x24, x24, #0x980
4000314c: 54ffd540     	b.eq	0x40002bf4 <tui_launch+0x70>
40003150: 7100291f     	cmp	w8, #0xa
40003154: 540002e0     	b.eq	0x400031b0 <tui_launch+0x62c>
40003158: 17fffeab     	b	0x40002c04 <tui_launch+0x80>
4000315c: 7100351f     	cmp	w8, #0xd
40003160: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40003164: 91260318     	add	x24, x24, #0x980
40003168: 54000240     	b.eq	0x400031b0 <tui_launch+0x62c>
4000316c: 71006d1f     	cmp	w8, #0x1b
40003170: 54ffd4a1     	b.ne	0x40002c04 <tui_launch+0x80>
40003174: 9400018e     	bl	0x400037ac <uart_getc>
40003178: 12001c13     	and	w19, w0, #0xff
4000317c: 9400018c     	bl	0x400037ac <uart_getc>
40003180: 71016e7f     	cmp	w19, #0x5b
40003184: 54ffd401     	b.ne	0x40002c04 <tui_launch+0x80>
40003188: 12001c08     	and	w8, w0, #0xff
4000318c: 7101051f     	cmp	w8, #0x41
40003190: 54000781     	b.ne	0x40003280 <tui_launch+0x6fc>
40003194: b9497388     	ldr	w8, [x28, #0x970]
40003198: 35ffd368     	cbnz	w8, 0x40002c04 <tui_launch+0x80>
4000319c: b9497768     	ldr	w8, [x27, #0x974]
400031a0: 71000508     	subs	w8, w8, #0x1
400031a4: 54ffd30b     	b.lt	0x40002c04 <tui_launch+0x80>
400031a8: b9097768     	str	w8, [x27, #0x974]
400031ac: 17fffe96     	b	0x40002c04 <tui_launch+0x80>
400031b0: b9497388     	ldr	w8, [x28, #0x970]
400031b4: 35ffd288     	cbnz	w8, 0x40002c04 <tui_launch+0x80>
400031b8: b9497b48     	ldr	w8, [x26, #0x978]
400031bc: 7100051f     	cmp	w8, #0x1
400031c0: 54ffd22b     	b.lt	0x40002c04 <tui_launch+0x80>
400031c4: b9897768     	ldrsw	x8, [x27, #0x974]
400031c8: f8687b15     	ldr	x21, [x24, x8, lsl #3]
400031cc: b4000115     	cbz	x21, 0x400031ec <tui_launch+0x668>
400031d0: b94022a8     	ldr	w8, [x21, #0x20]
400031d4: 7100051f     	cmp	w8, #0x1
400031d8: 54000161     	b.ne	0x40003204 <tui_launch+0x680>
400031dc: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
400031e0: b909777f     	str	wzr, [x27, #0x974]
400031e4: f904b515     	str	x21, [x8, #0x968]
400031e8: 17fffe87     	b	0x40002c04 <tui_launch+0x80>
400031ec: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400031f0: b909777f     	str	wzr, [x27, #0x974]
400031f4: f944b528     	ldr	x8, [x9, #0x968]
400031f8: f9421908     	ldr	x8, [x8, #0x430]
400031fc: f904b528     	str	x8, [x9, #0x968]
40003200: 17fffe81     	b	0x40002c04 <tui_launch+0x80>
40003204: 390223ff     	strb	wzr, [sp, #0x88]
40003208: aa1903e0     	mov	x0, x25
4000320c: 94000612     	bl	0x40004a54 <vfs_find>
40003210: eb0002bf     	cmp	x21, x0
40003214: 540001e0     	b.eq	0x40003250 <tui_launch+0x6cc>
40003218: 910023e0     	add	x0, sp, #0x8
4000321c: 910223e1     	add	x1, sp, #0x88
40003220: 97fffdb3     	bl	0x400028ec <kstrcpy>
40003224: 910223e0     	add	x0, sp, #0x88
40003228: aa1903e1     	mov	x1, x25
4000322c: 97fffdb0     	bl	0x400028ec <kstrcpy>
40003230: 910223e0     	add	x0, sp, #0x88
40003234: aa1503e1     	mov	x1, x21
40003238: 97fffd85     	bl	0x4000284c <kstrcat>
4000323c: 910223e0     	add	x0, sp, #0x88
40003240: 910023e1     	add	x1, sp, #0x8
40003244: 97fffd82     	bl	0x4000284c <kstrcat>
40003248: f9421ab5     	ldr	x21, [x21, #0x430]
4000324c: b5fffdf5     	cbnz	x21, 0x40003208 <tui_launch+0x684>
40003250: 910223e0     	add	x0, sp, #0x88
40003254: 97fffd77     	bl	0x40002830 <kstrlen>
40003258: b5000080     	cbnz	x0, 0x40003268 <tui_launch+0x6e4>
4000325c: 910223e0     	add	x0, sp, #0x88
40003260: aa1903e1     	mov	x1, x25
40003264: 97fffda2     	bl	0x400028ec <kstrcpy>
40003268: 910223e0     	add	x0, sp, #0x88
4000326c: 97fff416     	bl	0x400002c4 <launch_kedit>
40003270: d503201f     	nop
40003274: 1002b340     	adr	x0, 0x400088dc <__rodata_start+0x18dc>
40003278: 94000119     	bl	0x400036dc <uart_puts>
4000327c: 17fffe62     	b	0x40002c04 <tui_launch+0x80>
40003280: 7101091f     	cmp	w8, #0x42
40003284: 54ffcc01     	b.ne	0x40002c04 <tui_launch+0x80>
40003288: b9497388     	ldr	w8, [x28, #0x970]
4000328c: 35ffcbc8     	cbnz	w8, 0x40002c04 <tui_launch+0x80>
40003290: b9497b49     	ldr	w9, [x26, #0x978]
40003294: b9497768     	ldr	w8, [x27, #0x974]
40003298: 51000529     	sub	w9, w9, #0x1
4000329c: 6b09011f     	cmp	w8, w9
400032a0: 54ffcb2a     	b.ge	0x40002c04 <tui_launch+0x80>
400032a4: 11000508     	add	w8, w8, #0x1
400032a8: b9097768     	str	w8, [x27, #0x974]
400032ac: 17fffe56     	b	0x40002c04 <tui_launch+0x80>
400032b0: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032b4: 912bcc00     	add	x0, x0, #0xaf3
400032b8: 94000109     	bl	0x400036dc <uart_puts>
400032bc: a9564ff4     	ldp	x20, x19, [sp, #0x160]
400032c0: a95557f6     	ldp	x22, x21, [sp, #0x150]
400032c4: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400032c8: a95367fa     	ldp	x26, x25, [sp, #0x130]
400032cc: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400032d0: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400032d4: 9105c3ff     	add	sp, sp, #0x170
400032d8: d65f03c0     	ret

00000000400032dc <draw_box>:
400032dc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400032e0: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400032e4: 911f8108     	add	x8, x8, #0x7e0
400032e8: 7100007f     	cmp	w3, #0x0
400032ec: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
400032f0: 91083d29     	add	x9, x9, #0x20f
400032f4: a9034ff4     	stp	x20, x19, [sp, #0x30]
400032f8: 2a0003f3     	mov	w19, w0
400032fc: 9a880120     	csel	x0, x9, x8, eq
40003300: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003304: a90257f6     	stp	x22, x21, [sp, #0x20]
40003308: 910003fd     	mov	x29, sp
4000330c: aa0203f4     	mov	x20, x2
40003310: 2a0103f5     	mov	w21, w1
40003314: 940000f2     	bl	0x400036dc <uart_puts>
40003318: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000331c: 91207400     	add	x0, x0, #0x81d
40003320: 52800041     	mov	w1, #0x2                // =2
40003324: 2a1303e2     	mov	w2, w19
40003328: 94000202     	bl	0x40003b30 <uart_printf>
4000332c: 51000ab6     	sub	w22, w21, #0x2
40003330: 510006b7     	sub	w23, w21, #0x1
40003334: 90000035     	adrp	x21, 0x40007000 <__rodata_start>
40003338: 91143eb5     	add	x21, x21, #0x50f
4000333c: 2a1603f8     	mov	w24, w22
40003340: aa1503e0     	mov	x0, x21
40003344: 940000e6     	bl	0x400036dc <uart_puts>
40003348: 71000718     	subs	w24, w24, #0x1
4000334c: 54ffffa1     	b.ne	0x40003340 <draw_box+0x64>
40003350: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003354: 9126d000     	add	x0, x0, #0x9b4
40003358: 940000e1     	bl	0x400036dc <uart_puts>
4000335c: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003360: 9120a400     	add	x0, x0, #0x829
40003364: 11000a62     	add	w2, w19, #0x2
40003368: 52800041     	mov	w1, #0x2                // =2
4000336c: aa1403e3     	mov	x3, x20
40003370: 940001f0     	bl	0x40003b30 <uart_printf>
40003374: b0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40003378: 91151e94     	add	x20, x20, #0x547
4000337c: 52800061     	mov	w1, #0x3                // =3
40003380: aa1403e0     	mov	x0, x20
40003384: 2a1303e2     	mov	w2, w19
40003388: 940001ea     	bl	0x40003b30 <uart_printf>
4000338c: 0b1302e2     	add	w2, w23, w19
40003390: aa1403e0     	mov	x0, x20
40003394: 52800061     	mov	w1, #0x3                // =3
40003398: 940001e6     	bl	0x40003b30 <uart_printf>
4000339c: aa1403e0     	mov	x0, x20
400033a0: 52800081     	mov	w1, #0x4                // =4
400033a4: 2a1303e2     	mov	w2, w19
400033a8: 940001e2     	bl	0x40003b30 <uart_printf>
400033ac: 0b1302e2     	add	w2, w23, w19
400033b0: aa1403e0     	mov	x0, x20
400033b4: 52800081     	mov	w1, #0x4                // =4
400033b8: 940001de     	bl	0x40003b30 <uart_printf>
400033bc: aa1403e0     	mov	x0, x20
400033c0: 528000a1     	mov	w1, #0x5                // =5
400033c4: 2a1303e2     	mov	w2, w19
400033c8: 940001da     	bl	0x40003b30 <uart_printf>
400033cc: 0b1302e2     	add	w2, w23, w19
400033d0: aa1403e0     	mov	x0, x20
400033d4: 528000a1     	mov	w1, #0x5                // =5
400033d8: 940001d6     	bl	0x40003b30 <uart_printf>
400033dc: aa1403e0     	mov	x0, x20
400033e0: 528000c1     	mov	w1, #0x6                // =6
400033e4: 2a1303e2     	mov	w2, w19
400033e8: 940001d2     	bl	0x40003b30 <uart_printf>
400033ec: 0b1302e2     	add	w2, w23, w19
400033f0: aa1403e0     	mov	x0, x20
400033f4: 528000c1     	mov	w1, #0x6                // =6
400033f8: 940001ce     	bl	0x40003b30 <uart_printf>
400033fc: aa1403e0     	mov	x0, x20
40003400: 528000e1     	mov	w1, #0x7                // =7
40003404: 2a1303e2     	mov	w2, w19
40003408: 940001ca     	bl	0x40003b30 <uart_printf>
4000340c: 0b1302e2     	add	w2, w23, w19
40003410: aa1403e0     	mov	x0, x20
40003414: 528000e1     	mov	w1, #0x7                // =7
40003418: 940001c6     	bl	0x40003b30 <uart_printf>
4000341c: aa1403e0     	mov	x0, x20
40003420: 52800101     	mov	w1, #0x8                // =8
40003424: 2a1303e2     	mov	w2, w19
40003428: 940001c2     	bl	0x40003b30 <uart_printf>
4000342c: 0b1302e2     	add	w2, w23, w19
40003430: aa1403e0     	mov	x0, x20
40003434: 52800101     	mov	w1, #0x8                // =8
40003438: 940001be     	bl	0x40003b30 <uart_printf>
4000343c: aa1403e0     	mov	x0, x20
40003440: 52800121     	mov	w1, #0x9                // =9
40003444: 2a1303e2     	mov	w2, w19
40003448: 940001ba     	bl	0x40003b30 <uart_printf>
4000344c: 0b1302e2     	add	w2, w23, w19
40003450: aa1403e0     	mov	x0, x20
40003454: 52800121     	mov	w1, #0x9                // =9
40003458: 940001b6     	bl	0x40003b30 <uart_printf>
4000345c: aa1403e0     	mov	x0, x20
40003460: 52800141     	mov	w1, #0xa                // =10
40003464: 2a1303e2     	mov	w2, w19
40003468: 940001b2     	bl	0x40003b30 <uart_printf>
4000346c: 0b1302e2     	add	w2, w23, w19
40003470: aa1403e0     	mov	x0, x20
40003474: 52800141     	mov	w1, #0xa                // =10
40003478: 940001ae     	bl	0x40003b30 <uart_printf>
4000347c: aa1403e0     	mov	x0, x20
40003480: 52800161     	mov	w1, #0xb                // =11
40003484: 2a1303e2     	mov	w2, w19
40003488: 940001aa     	bl	0x40003b30 <uart_printf>
4000348c: 0b1302e2     	add	w2, w23, w19
40003490: aa1403e0     	mov	x0, x20
40003494: 52800161     	mov	w1, #0xb                // =11
40003498: 940001a6     	bl	0x40003b30 <uart_printf>
4000349c: aa1403e0     	mov	x0, x20
400034a0: 52800181     	mov	w1, #0xc                // =12
400034a4: 2a1303e2     	mov	w2, w19
400034a8: 940001a2     	bl	0x40003b30 <uart_printf>
400034ac: 0b1302e2     	add	w2, w23, w19
400034b0: aa1403e0     	mov	x0, x20
400034b4: 52800181     	mov	w1, #0xc                // =12
400034b8: 9400019e     	bl	0x40003b30 <uart_printf>
400034bc: aa1403e0     	mov	x0, x20
400034c0: 528001a1     	mov	w1, #0xd                // =13
400034c4: 2a1303e2     	mov	w2, w19
400034c8: 9400019a     	bl	0x40003b30 <uart_printf>
400034cc: 0b1302e2     	add	w2, w23, w19
400034d0: aa1403e0     	mov	x0, x20
400034d4: 528001a1     	mov	w1, #0xd                // =13
400034d8: 94000196     	bl	0x40003b30 <uart_printf>
400034dc: aa1403e0     	mov	x0, x20
400034e0: 528001c1     	mov	w1, #0xe                // =14
400034e4: 2a1303e2     	mov	w2, w19
400034e8: 94000192     	bl	0x40003b30 <uart_printf>
400034ec: 0b1302e2     	add	w2, w23, w19
400034f0: aa1403e0     	mov	x0, x20
400034f4: 528001c1     	mov	w1, #0xe                // =14
400034f8: 9400018e     	bl	0x40003b30 <uart_printf>
400034fc: aa1403e0     	mov	x0, x20
40003500: 528001e1     	mov	w1, #0xf                // =15
40003504: 2a1303e2     	mov	w2, w19
40003508: 9400018a     	bl	0x40003b30 <uart_printf>
4000350c: 0b1302e2     	add	w2, w23, w19
40003510: aa1403e0     	mov	x0, x20
40003514: 528001e1     	mov	w1, #0xf                // =15
40003518: 94000186     	bl	0x40003b30 <uart_printf>
4000351c: aa1403e0     	mov	x0, x20
40003520: 52800201     	mov	w1, #0x10               // =16
40003524: 2a1303e2     	mov	w2, w19
40003528: 94000182     	bl	0x40003b30 <uart_printf>
4000352c: 0b1302e2     	add	w2, w23, w19
40003530: aa1403e0     	mov	x0, x20
40003534: 52800201     	mov	w1, #0x10               // =16
40003538: 9400017e     	bl	0x40003b30 <uart_printf>
4000353c: aa1403e0     	mov	x0, x20
40003540: 52800221     	mov	w1, #0x11               // =17
40003544: 2a1303e2     	mov	w2, w19
40003548: 9400017a     	bl	0x40003b30 <uart_printf>
4000354c: 0b1302e2     	add	w2, w23, w19
40003550: aa1403e0     	mov	x0, x20
40003554: 52800221     	mov	w1, #0x11               // =17
40003558: 94000176     	bl	0x40003b30 <uart_printf>
4000355c: aa1403e0     	mov	x0, x20
40003560: 52800241     	mov	w1, #0x12               // =18
40003564: 2a1303e2     	mov	w2, w19
40003568: 94000172     	bl	0x40003b30 <uart_printf>
4000356c: 0b1302e2     	add	w2, w23, w19
40003570: aa1403e0     	mov	x0, x20
40003574: 52800241     	mov	w1, #0x12               // =18
40003578: 9400016e     	bl	0x40003b30 <uart_printf>
4000357c: aa1403e0     	mov	x0, x20
40003580: 52800261     	mov	w1, #0x13               // =19
40003584: 2a1303e2     	mov	w2, w19
40003588: 9400016a     	bl	0x40003b30 <uart_printf>
4000358c: 0b1302e2     	add	w2, w23, w19
40003590: aa1403e0     	mov	x0, x20
40003594: 52800261     	mov	w1, #0x13               // =19
40003598: 94000166     	bl	0x40003b30 <uart_printf>
4000359c: aa1403e0     	mov	x0, x20
400035a0: 52800281     	mov	w1, #0x14               // =20
400035a4: 2a1303e2     	mov	w2, w19
400035a8: 94000162     	bl	0x40003b30 <uart_printf>
400035ac: 0b1302e2     	add	w2, w23, w19
400035b0: aa1403e0     	mov	x0, x20
400035b4: 52800281     	mov	w1, #0x14               // =20
400035b8: 9400015e     	bl	0x40003b30 <uart_printf>
400035bc: aa1403e0     	mov	x0, x20
400035c0: 528002a1     	mov	w1, #0x15               // =21
400035c4: 2a1303e2     	mov	w2, w19
400035c8: 9400015a     	bl	0x40003b30 <uart_printf>
400035cc: 0b1302e2     	add	w2, w23, w19
400035d0: aa1403e0     	mov	x0, x20
400035d4: 528002a1     	mov	w1, #0x15               // =21
400035d8: 94000156     	bl	0x40003b30 <uart_printf>
400035dc: aa1403e0     	mov	x0, x20
400035e0: 528002c1     	mov	w1, #0x16               // =22
400035e4: 2a1303e2     	mov	w2, w19
400035e8: 94000152     	bl	0x40003b30 <uart_printf>
400035ec: 0b1302e2     	add	w2, w23, w19
400035f0: aa1403e0     	mov	x0, x20
400035f4: 528002c1     	mov	w1, #0x16               // =22
400035f8: 9400014e     	bl	0x40003b30 <uart_printf>
400035fc: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003600: 91161800     	add	x0, x0, #0x586
40003604: 528002e1     	mov	w1, #0x17               // =23
40003608: 2a1303e2     	mov	w2, w19
4000360c: 94000149     	bl	0x40003b30 <uart_printf>
40003610: 90000033     	adrp	x19, 0x40007000 <__rodata_start>
40003614: 91143e73     	add	x19, x19, #0x50f
40003618: aa1303e0     	mov	x0, x19
4000361c: 94000030     	bl	0x400036dc <uart_puts>
40003620: 710006d6     	subs	w22, w22, #0x1
40003624: 54ffffa1     	b.ne	0x40003618 <draw_box+0x33c>
40003628: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000362c: 91164800     	add	x0, x0, #0x592
40003630: 9400002b     	bl	0x400036dc <uart_puts>
40003634: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003638: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000363c: 912ef000     	add	x0, x0, #0xbbc
40003640: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003644: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003648: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000364c: 14000024     	b	0x400036dc <uart_puts>

0000000040003650 <uart_init>:
40003650: 52800608     	mov	w8, #0x30               // =48
40003654: 528001a9     	mov	w9, #0xd                // =13
40003658: 5280002a     	mov	w10, #0x1               // =1
4000365c: 72a12008     	movk	w8, #0x900, lsl #16
40003660: b900011f     	str	wzr, [x8]
40003664: b81f4109     	stur	w9, [x8, #-0xc]
40003668: 52800e09     	mov	w9, #0x70               // =112
4000366c: b81f810a     	stur	w10, [x8, #-0x8]
40003670: b81fc109     	stur	w9, [x8, #-0x4]
40003674: 52806029     	mov	w9, #0x301              // =769
40003678: b9000109     	str	w9, [x8]
4000367c: d65f03c0     	ret

0000000040003680 <uart_putc>:
40003680: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003684: b94b8108     	ldr	w8, [x8, #0xb80]
40003688: 340001a8     	cbz	w8, 0x400036bc <uart_putc+0x3c>
4000368c: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003690: 5287ffca     	mov	w10, #0x3ffe            // =16382
40003694: b94b8509     	ldr	w9, [x8, #0xb84]
40003698: 6b0a013f     	cmp	w9, w10
4000369c: 5400010c     	b.gt	0x400036bc <uart_putc+0x3c>
400036a0: 93407d29     	sxtw	x9, w9
400036a4: d503201f     	nop
400036a8: 1006270a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
400036ac: 9100052b     	add	x11, x9, #0x1
400036b0: 38296940     	strb	w0, [x10, x9]
400036b4: b90b850b     	str	w11, [x8, #0xb84]
400036b8: 382b695f     	strb	wzr, [x10, x11]
400036bc: 52800308     	mov	w8, #0x18               // =24
400036c0: 72a12008     	movk	w8, #0x900, lsl #16
400036c4: b9400109     	ldr	w9, [x8]
400036c8: 372fffe9     	tbnz	w9, #0x5, 0x400036c4 <uart_putc+0x44>
400036cc: 12001c08     	and	w8, w0, #0xff
400036d0: 52a12009     	mov	w9, #0x9000000          // =150994944
400036d4: b9000128     	str	w8, [x9]
400036d8: d65f03c0     	ret

00000000400036dc <uart_puts>:
400036dc: 52800308     	mov	w8, #0x18               // =24
400036e0: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400036e4: 9000006a     	adrp	x10, 0x4000f000 <var_values+0x6a8>
400036e8: 72a12008     	movk	w8, #0x900, lsl #16
400036ec: d503201f     	nop
400036f0: 100624cb     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
400036f4: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400036f8: 528001ad     	mov	w13, #0xd               // =13
400036fc: 52a1200e     	mov	w14, #0x9000000         // =150994944
40003700: 3940000f     	ldrb	w15, [x0]
40003704: 710029ff     	cmp	w15, #0xa
40003708: 540000a0     	b.eq	0x4000371c <uart_puts+0x40>
4000370c: 3400042f     	cbz	w15, 0x40003790 <uart_puts+0xb4>
40003710: b94b8130     	ldr	w16, [x9, #0xb80]
40003714: 35000250     	cbnz	w16, 0x4000375c <uart_puts+0x80>
40003718: 14000019     	b	0x4000377c <uart_puts+0xa0>
4000371c: b94b812f     	ldr	w15, [x9, #0xb80]
40003720: 3400012f     	cbz	w15, 0x40003744 <uart_puts+0x68>
40003724: b94b854f     	ldr	w15, [x10, #0xb84]
40003728: 6b0c01ff     	cmp	w15, w12
4000372c: 540000cc     	b.gt	0x40003744 <uart_puts+0x68>
40003730: 93407def     	sxtw	x15, w15
40003734: 910005f0     	add	x16, x15, #0x1
40003738: 382f696d     	strb	w13, [x11, x15]
4000373c: b90b8550     	str	w16, [x10, #0xb84]
40003740: 3830697f     	strb	wzr, [x11, x16]
40003744: b940010f     	ldr	w15, [x8]
40003748: 372fffef     	tbnz	w15, #0x5, 0x40003744 <uart_puts+0x68>
4000374c: b90001cd     	str	w13, [x14]
40003750: 3940000f     	ldrb	w15, [x0]
40003754: b94b8130     	ldr	w16, [x9, #0xb80]
40003758: 34000130     	cbz	w16, 0x4000377c <uart_puts+0xa0>
4000375c: b94b8550     	ldr	w16, [x10, #0xb84]
40003760: 6b0c021f     	cmp	w16, w12
40003764: 540000cc     	b.gt	0x4000377c <uart_puts+0xa0>
40003768: 93407e10     	sxtw	x16, w16
4000376c: 91000611     	add	x17, x16, #0x1
40003770: 3830696f     	strb	w15, [x11, x16]
40003774: b90b8551     	str	w17, [x10, #0xb84]
40003778: 3831697f     	strb	wzr, [x11, x17]
4000377c: 91000400     	add	x0, x0, #0x1
40003780: b9400110     	ldr	w16, [x8]
40003784: 372ffff0     	tbnz	w16, #0x5, 0x40003780 <uart_puts+0xa4>
40003788: b90001cf     	str	w15, [x14]
4000378c: 17ffffdd     	b	0x40003700 <uart_puts+0x24>
40003790: d65f03c0     	ret

0000000040003794 <uart_has_data>:
40003794: 52800308     	mov	w8, #0x18               // =24
40003798: 52800029     	mov	w9, #0x1                // =1
4000379c: 72a12008     	movk	w8, #0x900, lsl #16
400037a0: b9400108     	ldr	w8, [x8]
400037a4: 0a681120     	bic	w0, w9, w8, lsr #4
400037a8: d65f03c0     	ret

00000000400037ac <uart_getc>:
400037ac: 52800308     	mov	w8, #0x18               // =24
400037b0: 72a12008     	movk	w8, #0x900, lsl #16
400037b4: b9400109     	ldr	w9, [x8]
400037b8: 3727ffe9     	tbnz	w9, #0x4, 0x400037b4 <uart_getc+0x8>
400037bc: 52a12008     	mov	w8, #0x9000000          // =150994944
400037c0: b9400100     	ldr	w0, [x8]
400037c4: d65f03c0     	ret

00000000400037c8 <uart_print_hex_raw>:
400037c8: 52800308     	mov	w8, #0x18               // =24
400037cc: 2a1f03eb     	mov	w11, wzr
400037d0: 5280078c     	mov	w12, #0x3c              // =60
400037d4: 72a12008     	movk	w8, #0x900, lsl #16
400037d8: d503201f     	nop
400037dc: 1001e68e     	adr	x14, 0x400074ac <__rodata_start+0x4ac>
400037e0: 9000006d     	adrp	x13, 0x4000f000 <var_values+0x6a8>
400037e4: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400037e8: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037ec: d503201f     	nop
400037f0: 10061cca     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
400037f4: 52a12010     	mov	w16, #0x9000000         // =150994944
400037f8: 14000003     	b	0x40003804 <uart_print_hex_raw+0x3c>
400037fc: b400032c     	cbz	x12, 0x40003860 <uart_print_hex_raw+0x98>
40003800: d100118c     	sub	x12, x12, #0x4
40003804: 9acc2411     	lsr	x17, x0, x12
40003808: 53027d92     	lsr	w18, w12, #2
4000380c: 92400e31     	and	x17, x17, #0xf
40003810: 6b01025f     	cmp	w18, w1
40003814: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003818: 1a9f056b     	csinc	w11, w11, wzr, eq
4000381c: 34ffff0b     	cbz	w11, 0x400037fc <uart_print_hex_raw+0x34>
40003820: b94b81b2     	ldr	w18, [x13, #0xb80]
40003824: 387169d1     	ldrb	w17, [x14, x17]
40003828: 34000132     	cbz	w18, 0x4000384c <uart_print_hex_raw+0x84>
4000382c: b94b8532     	ldr	w18, [x9, #0xb84]
40003830: 6b0f025f     	cmp	w18, w15
40003834: 540000cc     	b.gt	0x4000384c <uart_print_hex_raw+0x84>
40003838: 93407e52     	sxtw	x18, w18
4000383c: 91000642     	add	x2, x18, #0x1
40003840: 38326951     	strb	w17, [x10, x18]
40003844: b90b8522     	str	w2, [x9, #0xb84]
40003848: 3822695f     	strb	wzr, [x10, x2]
4000384c: b9400112     	ldr	w18, [x8]
40003850: 372ffff2     	tbnz	w18, #0x5, 0x4000384c <uart_print_hex_raw+0x84>
40003854: b9000211     	str	w17, [x16]
40003858: b5fffd4c     	cbnz	x12, 0x40003800 <uart_print_hex_raw+0x38>
4000385c: d65f03c0     	ret
40003860: b94b81ab     	ldr	w11, [x13, #0xb80]
40003864: 3400016b     	cbz	w11, 0x40003890 <uart_print_hex_raw+0xc8>
40003868: b94b852b     	ldr	w11, [x9, #0xb84]
4000386c: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003870: 6b0c017f     	cmp	w11, w12
40003874: 540000ec     	b.gt	0x40003890 <uart_print_hex_raw+0xc8>
40003878: 93407d6b     	sxtw	x11, w11
4000387c: 5280060c     	mov	w12, #0x30              // =48
40003880: 9100056d     	add	x13, x11, #0x1
40003884: 382b694c     	strb	w12, [x10, x11]
40003888: b90b852d     	str	w13, [x9, #0xb84]
4000388c: 382d695f     	strb	wzr, [x10, x13]
40003890: b9400109     	ldr	w9, [x8]
40003894: 372fffe9     	tbnz	w9, #0x5, 0x40003890 <uart_print_hex_raw+0xc8>
40003898: 52a12008     	mov	w8, #0x9000000          // =150994944
4000389c: 52800609     	mov	w9, #0x30               // =48
400038a0: b9000109     	str	w9, [x8]
400038a4: d65f03c0     	ret

00000000400038a8 <uart_print_hex>:
400038a8: 52800308     	mov	w8, #0x18               // =24
400038ac: b000002c     	adrp	x12, 0x40008000 <__rodata_start+0x1000>
400038b0: 91042d8c     	add	x12, x12, #0x10b
400038b4: 72a12008     	movk	w8, #0x900, lsl #16
400038b8: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
400038bc: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400038c0: d503201f     	nop
400038c4: 1006162a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
400038c8: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038cc: 528001ae     	mov	w14, #0xd               // =13
400038d0: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038d4: 39400190     	ldrb	w16, [x12]
400038d8: 71002a1f     	cmp	w16, #0xa
400038dc: 540000a0     	b.eq	0x400038f0 <uart_print_hex+0x48>
400038e0: 34000410     	cbz	w16, 0x40003960 <uart_print_hex+0xb8>
400038e4: b94b8171     	ldr	w17, [x11, #0xb80]
400038e8: 35000231     	cbnz	w17, 0x4000392c <uart_print_hex+0x84>
400038ec: 14000018     	b	0x4000394c <uart_print_hex+0xa4>
400038f0: b94b8171     	ldr	w17, [x11, #0xb80]
400038f4: 34000131     	cbz	w17, 0x40003918 <uart_print_hex+0x70>
400038f8: b94b8531     	ldr	w17, [x9, #0xb84]
400038fc: 6b0d023f     	cmp	w17, w13
40003900: 540000cc     	b.gt	0x40003918 <uart_print_hex+0x70>
40003904: 93407e31     	sxtw	x17, w17
40003908: 91000632     	add	x18, x17, #0x1
4000390c: 3831694e     	strb	w14, [x10, x17]
40003910: b90b8532     	str	w18, [x9, #0xb84]
40003914: 3832695f     	strb	wzr, [x10, x18]
40003918: b9400111     	ldr	w17, [x8]
4000391c: 372ffff1     	tbnz	w17, #0x5, 0x40003918 <uart_print_hex+0x70>
40003920: b90001ee     	str	w14, [x15]
40003924: b94b8171     	ldr	w17, [x11, #0xb80]
40003928: 34000131     	cbz	w17, 0x4000394c <uart_print_hex+0xa4>
4000392c: b94b8531     	ldr	w17, [x9, #0xb84]
40003930: 6b0d023f     	cmp	w17, w13
40003934: 540000cc     	b.gt	0x4000394c <uart_print_hex+0xa4>
40003938: 93407e31     	sxtw	x17, w17
4000393c: 91000632     	add	x18, x17, #0x1
40003940: 38316950     	strb	w16, [x10, x17]
40003944: b90b8532     	str	w18, [x9, #0xb84]
40003948: 3832695f     	strb	wzr, [x10, x18]
4000394c: 9100058c     	add	x12, x12, #0x1
40003950: b9400111     	ldr	w17, [x8]
40003954: 372ffff1     	tbnz	w17, #0x5, 0x40003950 <uart_print_hex+0xa8>
40003958: b90001f0     	str	w16, [x15]
4000395c: 17ffffde     	b	0x400038d4 <uart_print_hex+0x2c>
40003960: 2a1f03ec     	mov	w12, wzr
40003964: d503201f     	nop
40003968: 1001da2d     	adr	x13, 0x400074ac <__rodata_start+0x4ac>
4000396c: 5280078e     	mov	w14, #0x3c              // =60
40003970: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003974: 52a12010     	mov	w16, #0x9000000         // =150994944
40003978: 14000003     	b	0x40003984 <uart_print_hex+0xdc>
4000397c: b40002ee     	cbz	x14, 0x400039d8 <uart_print_hex+0x130>
40003980: d10011ce     	sub	x14, x14, #0x4
40003984: 9ace2411     	lsr	x17, x0, x14
40003988: f2400e31     	ands	x17, x17, #0xf
4000398c: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003990: 1a9f158c     	csinc	w12, w12, wzr, ne
40003994: 34ffff4c     	cbz	w12, 0x4000397c <uart_print_hex+0xd4>
40003998: b94b8172     	ldr	w18, [x11, #0xb80]
4000399c: 387169b1     	ldrb	w17, [x13, x17]
400039a0: 34000132     	cbz	w18, 0x400039c4 <uart_print_hex+0x11c>
400039a4: b94b8532     	ldr	w18, [x9, #0xb84]
400039a8: 6b0f025f     	cmp	w18, w15
400039ac: 540000cc     	b.gt	0x400039c4 <uart_print_hex+0x11c>
400039b0: 93407e52     	sxtw	x18, w18
400039b4: 91000641     	add	x1, x18, #0x1
400039b8: 38326951     	strb	w17, [x10, x18]
400039bc: b90b8521     	str	w1, [x9, #0xb84]
400039c0: 3821695f     	strb	wzr, [x10, x1]
400039c4: b9400112     	ldr	w18, [x8]
400039c8: 372ffff2     	tbnz	w18, #0x5, 0x400039c4 <uart_print_hex+0x11c>
400039cc: b9000211     	str	w17, [x16]
400039d0: b5fffd8e     	cbnz	x14, 0x40003980 <uart_print_hex+0xd8>
400039d4: d65f03c0     	ret
400039d8: b94b816b     	ldr	w11, [x11, #0xb80]
400039dc: 3400016b     	cbz	w11, 0x40003a08 <uart_print_hex+0x160>
400039e0: b94b852b     	ldr	w11, [x9, #0xb84]
400039e4: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039e8: 6b0c017f     	cmp	w11, w12
400039ec: 540000ec     	b.gt	0x40003a08 <uart_print_hex+0x160>
400039f0: 93407d6b     	sxtw	x11, w11
400039f4: 5280060c     	mov	w12, #0x30              // =48
400039f8: 9100056d     	add	x13, x11, #0x1
400039fc: 382b694c     	strb	w12, [x10, x11]
40003a00: b90b852d     	str	w13, [x9, #0xb84]
40003a04: 382d695f     	strb	wzr, [x10, x13]
40003a08: b9400109     	ldr	w9, [x8]
40003a0c: 372fffe9     	tbnz	w9, #0x5, 0x40003a08 <uart_print_hex+0x160>
40003a10: 52a12008     	mov	w8, #0x9000000          // =150994944
40003a14: 52800609     	mov	w9, #0x30               // =48
40003a18: b9000109     	str	w9, [x8]
40003a1c: d65f03c0     	ret

0000000040003a20 <uart_print_dec>:
40003a20: d10083ff     	sub	sp, sp, #0x20
40003a24: 52800308     	mov	w8, #0x18               // =24
40003a28: 72a12008     	movk	w8, #0x900, lsl #16
40003a2c: b4000540     	cbz	x0, 0x40003ad4 <uart_print_dec+0xb4>
40003a30: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003a34: aa1f03e9     	mov	x9, xzr
40003a38: 5280014b     	mov	w11, #0xa               // =10
40003a3c: f29999aa     	movk	x10, #0xcccd
40003a40: 910023ec     	add	x12, sp, #0x8
40003a44: 9bca7c0d     	umulh	x13, x0, x10
40003a48: f100241f     	cmp	x0, #0x9
40003a4c: d343fdad     	lsr	x13, x13, #3
40003a50: 1b0b81ae     	msub	w14, w13, w11, w0
40003a54: aa0d03e0     	mov	x0, x13
40003a58: 321c05ce     	orr	w14, w14, #0x30
40003a5c: 3829698e     	strb	w14, [x12, x9]
40003a60: 91000529     	add	x9, x9, #0x1
40003a64: 54ffff08     	b.hi	0x40003a44 <uart_print_dec+0x24>
40003a68: 910023ea     	add	x10, sp, #0x8
40003a6c: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003a70: 9000006c     	adrp	x12, 0x4000f000 <var_values+0x6a8>
40003a74: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a78: d503201f     	nop
40003a7c: 1006086e     	adr	x14, 0x4000fb88 <kernel_capture_buffer>
40003a80: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a84: d1000530     	sub	x16, x9, #0x1
40003a88: b94b8172     	ldr	w18, [x11, #0xb80]
40003a8c: 38706951     	ldrb	w17, [x10, x16]
40003a90: 34000132     	cbz	w18, 0x40003ab4 <uart_print_dec+0x94>
40003a94: b94b8592     	ldr	w18, [x12, #0xb84]
40003a98: 6b0d025f     	cmp	w18, w13
40003a9c: 540000cc     	b.gt	0x40003ab4 <uart_print_dec+0x94>
40003aa0: 93407e52     	sxtw	x18, w18
40003aa4: 91000640     	add	x0, x18, #0x1
40003aa8: 383269d1     	strb	w17, [x14, x18]
40003aac: b90b8580     	str	w0, [x12, #0xb84]
40003ab0: 382069df     	strb	wzr, [x14, x0]
40003ab4: b9400112     	ldr	w18, [x8]
40003ab8: 372ffff2     	tbnz	w18, #0x5, 0x40003ab4 <uart_print_dec+0x94>
40003abc: 7100053f     	cmp	w9, #0x1
40003ac0: aa1003e9     	mov	x9, x16
40003ac4: b90001f1     	str	w17, [x15]
40003ac8: 54fffdec     	b.gt	0x40003a84 <uart_print_dec+0x64>
40003acc: 910083ff     	add	sp, sp, #0x20
40003ad0: d65f03c0     	ret
40003ad4: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003ad8: b94b8129     	ldr	w9, [x9, #0xb80]
40003adc: 340001c9     	cbz	w9, 0x40003b14 <uart_print_dec+0xf4>
40003ae0: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003ae4: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003ae8: b94b852a     	ldr	w10, [x9, #0xb84]
40003aec: 6b0b015f     	cmp	w10, w11
40003af0: 5400012c     	b.gt	0x40003b14 <uart_print_dec+0xf4>
40003af4: 93407d4a     	sxtw	x10, w10
40003af8: d503201f     	nop
40003afc: 1006046b     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
40003b00: 5280060c     	mov	w12, #0x30              // =48
40003b04: 9100054d     	add	x13, x10, #0x1
40003b08: 382a696c     	strb	w12, [x11, x10]
40003b0c: b90b852d     	str	w13, [x9, #0xb84]
40003b10: 382d697f     	strb	wzr, [x11, x13]
40003b14: b9400109     	ldr	w9, [x8]
40003b18: 372fffe9     	tbnz	w9, #0x5, 0x40003b14 <uart_print_dec+0xf4>
40003b1c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003b20: 52800609     	mov	w9, #0x30               // =48
40003b24: b9000109     	str	w9, [x8]
40003b28: 910083ff     	add	sp, sp, #0x20
40003b2c: d65f03c0     	ret

0000000040003b30 <uart_printf>:
40003b30: d10343ff     	sub	sp, sp, #0xd0
40003b34: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003b38: 9101c3fd     	add	x29, sp, #0x70
40003b3c: 910003e8     	mov	x8, sp
40003b40: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003b44: 52800315     	mov	w21, #0x18              // =24
40003b48: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003b4c: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003b50: 72a12015     	movk	w21, #0x900, lsl #16
40003b54: 128006e9     	mov	w9, #-0x38              // =-56
40003b58: a90967fa     	stp	x26, x25, [sp, #0x90]
40003b5c: 9100e108     	add	x8, x8, #0x38
40003b60: 910183aa     	add	x10, x29, #0x60
40003b64: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003b68: 90000076     	adrp	x22, 0x4000f000 <var_values+0x6a8>
40003b6c: 90000077     	adrp	x23, 0x4000f000 <var_values+0x6a8>
40003b70: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003b74: aa0003f3     	mov	x19, x0
40003b78: aa1f03f4     	mov	x20, xzr
40003b7c: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003b80: d503201f     	nop
40003b84: 10060039     	adr	x25, 0x4000fb88 <kernel_capture_buffer>
40003b88: 528001ba     	mov	w26, #0xd               // =13
40003b8c: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b90: 528004ae     	mov	w14, #0x25              // =37
40003b94: f29999af     	movk	x15, #0xcccd
40003b98: 52800150     	mov	w16, #0xa               // =10
40003b9c: d10063bc     	sub	x28, x29, #0x18
40003ba0: d503201f     	nop
40003ba4: 1001c851     	adr	x17, 0x400074ac <__rodata_start+0x4ac>
40003ba8: a9000be1     	stp	x1, x2, [sp]
40003bac: a90113e3     	stp	x3, x4, [sp, #0x10]
40003bb0: a9021be5     	stp	x5, x6, [sp, #0x20]
40003bb4: f9002be9     	str	x9, [sp, #0x50]
40003bb8: f90023e8     	str	x8, [sp, #0x40]
40003bbc: a9032be7     	stp	x7, x10, [sp, #0x30]
40003bc0: 14000004     	b	0x40003bd0 <uart_printf+0xa0>
40003bc4: 52800608     	mov	w8, #0x30               // =48
40003bc8: b9000368     	str	w8, [x27]
40003bcc: 91000694     	add	x20, x20, #0x1
40003bd0: 38746a68     	ldrb	w8, [x19, x20]
40003bd4: 7100291f     	cmp	w8, #0xa
40003bd8: 54000440     	b.eq	0x40003c60 <uart_printf+0x130>
40003bdc: 7100951f     	cmp	w8, #0x25
40003be0: 540000a0     	b.eq	0x40003bf4 <uart_printf+0xc4>
40003be4: 34003ae8     	cbz	w8, 0x40004340 <uart_printf+0x810>
40003be8: b94b82c9     	ldr	w9, [x22, #0xb80]
40003bec: 350005a9     	cbnz	w9, 0x40003ca0 <uart_printf+0x170>
40003bf0: 14000034     	b	0x40003cc0 <uart_printf+0x190>
40003bf4: 9100068a     	add	x10, x20, #0x1
40003bf8: 386a6a68     	ldrb	w8, [x19, x10]
40003bfc: 7101b11f     	cmp	w8, #0x6c
40003c00: 54000661     	b.ne	0x40003ccc <uart_printf+0x19c>
40003c04: 91000a89     	add	x9, x20, #0x2
40003c08: 91000e8b     	add	x11, x20, #0x3
40003c0c: 38696a6a     	ldrb	w10, [x19, x9]
40003c10: 7101b15f     	cmp	w10, #0x6c
40003c14: 9a890174     	csel	x20, x11, x9, eq
40003c18: 38746a69     	ldrb	w9, [x19, x20]
40003c1c: 7101bd3f     	cmp	w9, #0x6f
40003c20: 540005ed     	b.le	0x40003cdc <uart_printf+0x1ac>
40003c24: 7101d13f     	cmp	w9, #0x74
40003c28: 5400080c     	b.gt	0x40003d28 <uart_printf+0x1f8>
40003c2c: 7101c13f     	cmp	w9, #0x70
40003c30: 54000f00     	b.eq	0x40003e10 <uart_printf+0x2e0>
40003c34: 7101cd3f     	cmp	w9, #0x73
40003c38: 54000b61     	b.ne	0x40003da4 <uart_printf+0x274>
40003c3c: b98053e8     	ldrsw	x8, [sp, #0x50]
40003c40: 36f81408     	tbz	w8, #0x1f, 0x40003ec0 <uart_printf+0x390>
40003c44: 11002109     	add	w9, w8, #0x8
40003c48: 3100211f     	cmn	w8, #0x8
40003c4c: b90053e9     	str	w9, [sp, #0x50]
40003c50: 54001388     	b.hi	0x40003ec0 <uart_printf+0x390>
40003c54: f94023e9     	ldr	x9, [sp, #0x40]
40003c58: 8b080128     	add	x8, x9, x8
40003c5c: 1400009c     	b	0x40003ecc <uart_printf+0x39c>
40003c60: b94b82c8     	ldr	w8, [x22, #0xb80]
40003c64: 34000128     	cbz	w8, 0x40003c88 <uart_printf+0x158>
40003c68: b94b86e8     	ldr	w8, [x23, #0xb84]
40003c6c: 6b18011f     	cmp	w8, w24
40003c70: 540000cc     	b.gt	0x40003c88 <uart_printf+0x158>
40003c74: 93407d08     	sxtw	x8, w8
40003c78: 91000509     	add	x9, x8, #0x1
40003c7c: 38286b3a     	strb	w26, [x25, x8]
40003c80: b90b86e9     	str	w9, [x23, #0xb84]
40003c84: 38296b3f     	strb	wzr, [x25, x9]
40003c88: b94002a8     	ldr	w8, [x21]
40003c8c: 372fffe8     	tbnz	w8, #0x5, 0x40003c88 <uart_printf+0x158>
40003c90: b900037a     	str	w26, [x27]
40003c94: 38746a68     	ldrb	w8, [x19, x20]
40003c98: b94b82c9     	ldr	w9, [x22, #0xb80]
40003c9c: 34000129     	cbz	w9, 0x40003cc0 <uart_printf+0x190>
40003ca0: b94b86e9     	ldr	w9, [x23, #0xb84]
40003ca4: 6b18013f     	cmp	w9, w24
40003ca8: 540000cc     	b.gt	0x40003cc0 <uart_printf+0x190>
40003cac: 93407d29     	sxtw	x9, w9
40003cb0: 9100052a     	add	x10, x9, #0x1
40003cb4: 38296b28     	strb	w8, [x25, x9]
40003cb8: b90b86ea     	str	w10, [x23, #0xb84]
40003cbc: 382a6b3f     	strb	wzr, [x25, x10]
40003cc0: b94002a9     	ldr	w9, [x21]
40003cc4: 372fffe9     	tbnz	w9, #0x5, 0x40003cc0 <uart_printf+0x190>
40003cc8: 17ffffc0     	b	0x40003bc8 <uart_printf+0x98>
40003ccc: 2a0803e9     	mov	w9, w8
40003cd0: aa0a03f4     	mov	x20, x10
40003cd4: 7101bd3f     	cmp	w9, #0x6f
40003cd8: 54fffa6c     	b.gt	0x40003c24 <uart_printf+0xf4>
40003cdc: 7100953f     	cmp	w9, #0x25
40003ce0: 54000440     	b.eq	0x40003d68 <uart_printf+0x238>
40003ce4: 71018d3f     	cmp	w9, #0x63
40003ce8: 54000c00     	b.eq	0x40003e68 <uart_printf+0x338>
40003cec: 7101913f     	cmp	w9, #0x64
40003cf0: 540005a1     	b.ne	0x40003da4 <uart_printf+0x274>
40003cf4: b98053e9     	ldrsw	x9, [sp, #0x50]
40003cf8: 7101b11f     	cmp	w8, #0x6c
40003cfc: 540017c1     	b.ne	0x40003ff4 <uart_printf+0x4c4>
40003d00: 36f823c9     	tbz	w9, #0x1f, 0x40004178 <uart_printf+0x648>
40003d04: 11002128     	add	w8, w9, #0x8
40003d08: 3100213f     	cmn	w9, #0x8
40003d0c: b90053e8     	str	w8, [sp, #0x50]
40003d10: 54002348     	b.hi	0x40004178 <uart_printf+0x648>
40003d14: f94023e8     	ldr	x8, [sp, #0x40]
40003d18: 8b090108     	add	x8, x8, x9
40003d1c: f9400108     	ldr	x8, [x8]
40003d20: b6f829a8     	tbz	x8, #0x3f, 0x40004254 <uart_printf+0x724>
40003d24: 1400011a     	b	0x4000418c <uart_printf+0x65c>
40003d28: 7101d53f     	cmp	w9, #0x75
40003d2c: 54000840     	b.eq	0x40003e34 <uart_printf+0x304>
40003d30: 7101e13f     	cmp	w9, #0x78
40003d34: 54000381     	b.ne	0x40003da4 <uart_printf+0x274>
40003d38: b98053e9     	ldrsw	x9, [sp, #0x50]
40003d3c: 7101b11f     	cmp	w8, #0x6c
40003d40: 540014a1     	b.ne	0x40003fd4 <uart_printf+0x4a4>
40003d44: 36f81d49     	tbz	w9, #0x1f, 0x400040ec <uart_printf+0x5bc>
40003d48: 11002128     	add	w8, w9, #0x8
40003d4c: 3100213f     	cmn	w9, #0x8
40003d50: b90053e8     	str	w8, [sp, #0x50]
40003d54: 54001cc8     	b.hi	0x400040ec <uart_printf+0x5bc>
40003d58: f94023e8     	ldr	x8, [sp, #0x40]
40003d5c: 8b090108     	add	x8, x8, x9
40003d60: f9400108     	ldr	x8, [x8]
40003d64: 140000eb     	b	0x40004110 <uart_printf+0x5e0>
40003d68: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d6c: 34000128     	cbz	w8, 0x40003d90 <uart_printf+0x260>
40003d70: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d74: 6b18011f     	cmp	w8, w24
40003d78: 540000cc     	b.gt	0x40003d90 <uart_printf+0x260>
40003d7c: 93407d08     	sxtw	x8, w8
40003d80: 91000509     	add	x9, x8, #0x1
40003d84: 38286b2e     	strb	w14, [x25, x8]
40003d88: b90b86e9     	str	w9, [x23, #0xb84]
40003d8c: 38296b3f     	strb	wzr, [x25, x9]
40003d90: b94002a8     	ldr	w8, [x21]
40003d94: 372fffe8     	tbnz	w8, #0x5, 0x40003d90 <uart_printf+0x260>
40003d98: b900036e     	str	w14, [x27]
40003d9c: 91000694     	add	x20, x20, #0x1
40003da0: 17ffff8c     	b	0x40003bd0 <uart_printf+0xa0>
40003da4: b94b82c8     	ldr	w8, [x22, #0xb80]
40003da8: 34000128     	cbz	w8, 0x40003dcc <uart_printf+0x29c>
40003dac: b94b86e8     	ldr	w8, [x23, #0xb84]
40003db0: 6b18011f     	cmp	w8, w24
40003db4: 540000cc     	b.gt	0x40003dcc <uart_printf+0x29c>
40003db8: 93407d08     	sxtw	x8, w8
40003dbc: 91000509     	add	x9, x8, #0x1
40003dc0: 38286b2e     	strb	w14, [x25, x8]
40003dc4: b90b86e9     	str	w9, [x23, #0xb84]
40003dc8: 38296b3f     	strb	wzr, [x25, x9]
40003dcc: b94002a8     	ldr	w8, [x21]
40003dd0: 372fffe8     	tbnz	w8, #0x5, 0x40003dcc <uart_printf+0x29c>
40003dd4: b900036e     	str	w14, [x27]
40003dd8: b94b82c9     	ldr	w9, [x22, #0xb80]
40003ddc: 38746a68     	ldrb	w8, [x19, x20]
40003de0: 34000129     	cbz	w9, 0x40003e04 <uart_printf+0x2d4>
40003de4: b94b86e9     	ldr	w9, [x23, #0xb84]
40003de8: 6b18013f     	cmp	w9, w24
40003dec: 540000cc     	b.gt	0x40003e04 <uart_printf+0x2d4>
40003df0: 93407d29     	sxtw	x9, w9
40003df4: 9100052a     	add	x10, x9, #0x1
40003df8: 38296b28     	strb	w8, [x25, x9]
40003dfc: b90b86ea     	str	w10, [x23, #0xb84]
40003e00: 382a6b3f     	strb	wzr, [x25, x10]
40003e04: b94002a9     	ldr	w9, [x21]
40003e08: 372fffe9     	tbnz	w9, #0x5, 0x40003e04 <uart_printf+0x2d4>
40003e0c: 17ffff6f     	b	0x40003bc8 <uart_printf+0x98>
40003e10: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e14: 36f803c8     	tbz	w8, #0x1f, 0x40003e8c <uart_printf+0x35c>
40003e18: 11002109     	add	w9, w8, #0x8
40003e1c: 3100211f     	cmn	w8, #0x8
40003e20: b90053e9     	str	w9, [sp, #0x50]
40003e24: 54000348     	b.hi	0x40003e8c <uart_printf+0x35c>
40003e28: f94023e9     	ldr	x9, [sp, #0x40]
40003e2c: 8b080128     	add	x8, x9, x8
40003e30: 1400001a     	b	0x40003e98 <uart_printf+0x368>
40003e34: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e38: 7101b11f     	cmp	w8, #0x6c
40003e3c: 54000bc1     	b.ne	0x40003fb4 <uart_printf+0x484>
40003e40: 36f80ea9     	tbz	w9, #0x1f, 0x40004014 <uart_printf+0x4e4>
40003e44: 11002128     	add	w8, w9, #0x8
40003e48: 3100213f     	cmn	w9, #0x8
40003e4c: b90053e8     	str	w8, [sp, #0x50]
40003e50: 54000e28     	b.hi	0x40004014 <uart_printf+0x4e4>
40003e54: f94023e8     	ldr	x8, [sp, #0x40]
40003e58: 8b090108     	add	x8, x8, x9
40003e5c: f9400109     	ldr	x9, [x8]
40003e60: b50010a9     	cbnz	x9, 0x40004074 <uart_printf+0x544>
40003e64: 14000071     	b	0x40004028 <uart_printf+0x4f8>
40003e68: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e6c: 36f80828     	tbz	w8, #0x1f, 0x40003f70 <uart_printf+0x440>
40003e70: 11002109     	add	w9, w8, #0x8
40003e74: 3100211f     	cmn	w8, #0x8
40003e78: b90053e9     	str	w9, [sp, #0x50]
40003e7c: 540007a8     	b.hi	0x40003f70 <uart_printf+0x440>
40003e80: f94023e9     	ldr	x9, [sp, #0x40]
40003e84: 8b080128     	add	x8, x9, x8
40003e88: 1400003d     	b	0x40003f7c <uart_printf+0x44c>
40003e8c: f9401fe8     	ldr	x8, [sp, #0x38]
40003e90: 91002109     	add	x9, x8, #0x8
40003e94: f9001fe9     	str	x9, [sp, #0x38]
40003e98: f9400100     	ldr	x0, [x8]
40003e9c: 97fffe83     	bl	0x400038a8 <uart_print_hex>
40003ea0: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003ea4: 528004ae     	mov	w14, #0x25              // =37
40003ea8: 52800150     	mov	w16, #0xa               // =10
40003eac: f29999af     	movk	x15, #0xcccd
40003eb0: d503201f     	nop
40003eb4: 1001afd1     	adr	x17, 0x400074ac <__rodata_start+0x4ac>
40003eb8: 91000694     	add	x20, x20, #0x1
40003ebc: 17ffff45     	b	0x40003bd0 <uart_printf+0xa0>
40003ec0: f9401fe8     	ldr	x8, [sp, #0x38]
40003ec4: 91002109     	add	x9, x8, #0x8
40003ec8: f9001fe9     	str	x9, [sp, #0x38]
40003ecc: f9400108     	ldr	x8, [x8]
40003ed0: d0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40003ed4: 911fa129     	add	x9, x9, #0x7e8
40003ed8: f100011f     	cmp	x8, #0x0
40003edc: 9a880128     	csel	x8, x9, x8, eq
40003ee0: 39400109     	ldrb	w9, [x8]
40003ee4: 7100293f     	cmp	w9, #0xa
40003ee8: 540000a0     	b.eq	0x40003efc <uart_printf+0x3cc>
40003eec: 34ffe709     	cbz	w9, 0x40003bcc <uart_printf+0x9c>
40003ef0: b94b82ca     	ldr	w10, [x22, #0xb80]
40003ef4: 3500024a     	cbnz	w10, 0x40003f3c <uart_printf+0x40c>
40003ef8: 14000019     	b	0x40003f5c <uart_printf+0x42c>
40003efc: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f00: 34000129     	cbz	w9, 0x40003f24 <uart_printf+0x3f4>
40003f04: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f08: 6b18013f     	cmp	w9, w24
40003f0c: 540000cc     	b.gt	0x40003f24 <uart_printf+0x3f4>
40003f10: 93407d29     	sxtw	x9, w9
40003f14: 9100052a     	add	x10, x9, #0x1
40003f18: 38296b3a     	strb	w26, [x25, x9]
40003f1c: b90b86ea     	str	w10, [x23, #0xb84]
40003f20: 382a6b3f     	strb	wzr, [x25, x10]
40003f24: b94002a9     	ldr	w9, [x21]
40003f28: 372fffe9     	tbnz	w9, #0x5, 0x40003f24 <uart_printf+0x3f4>
40003f2c: b900037a     	str	w26, [x27]
40003f30: 39400109     	ldrb	w9, [x8]
40003f34: b94b82ca     	ldr	w10, [x22, #0xb80]
40003f38: 3400012a     	cbz	w10, 0x40003f5c <uart_printf+0x42c>
40003f3c: b94b86ea     	ldr	w10, [x23, #0xb84]
40003f40: 6b18015f     	cmp	w10, w24
40003f44: 540000cc     	b.gt	0x40003f5c <uart_printf+0x42c>
40003f48: 93407d4a     	sxtw	x10, w10
40003f4c: 9100054b     	add	x11, x10, #0x1
40003f50: 382a6b29     	strb	w9, [x25, x10]
40003f54: b90b86eb     	str	w11, [x23, #0xb84]
40003f58: 382b6b3f     	strb	wzr, [x25, x11]
40003f5c: 91000508     	add	x8, x8, #0x1
40003f60: b94002aa     	ldr	w10, [x21]
40003f64: 372fffea     	tbnz	w10, #0x5, 0x40003f60 <uart_printf+0x430>
40003f68: b9000369     	str	w9, [x27]
40003f6c: 17ffffdd     	b	0x40003ee0 <uart_printf+0x3b0>
40003f70: f9401fe8     	ldr	x8, [sp, #0x38]
40003f74: 91002109     	add	x9, x8, #0x8
40003f78: f9001fe9     	str	x9, [sp, #0x38]
40003f7c: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f80: 39400108     	ldrb	w8, [x8]
40003f84: 34000129     	cbz	w9, 0x40003fa8 <uart_printf+0x478>
40003f88: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f8c: 6b18013f     	cmp	w9, w24
40003f90: 540000cc     	b.gt	0x40003fa8 <uart_printf+0x478>
40003f94: 93407d29     	sxtw	x9, w9
40003f98: 9100052a     	add	x10, x9, #0x1
40003f9c: 38296b28     	strb	w8, [x25, x9]
40003fa0: b90b86ea     	str	w10, [x23, #0xb84]
40003fa4: 382a6b3f     	strb	wzr, [x25, x10]
40003fa8: b94002a9     	ldr	w9, [x21]
40003fac: 372fffe9     	tbnz	w9, #0x5, 0x40003fa8 <uart_printf+0x478>
40003fb0: 17ffff06     	b	0x40003bc8 <uart_printf+0x98>
40003fb4: 36f80569     	tbz	w9, #0x1f, 0x40004060 <uart_printf+0x530>
40003fb8: 11002128     	add	w8, w9, #0x8
40003fbc: 3100213f     	cmn	w9, #0x8
40003fc0: b90053e8     	str	w8, [sp, #0x50]
40003fc4: 540004e8     	b.hi	0x40004060 <uart_printf+0x530>
40003fc8: f94023e8     	ldr	x8, [sp, #0x40]
40003fcc: 8b090108     	add	x8, x8, x9
40003fd0: 14000027     	b	0x4000406c <uart_printf+0x53c>
40003fd4: 36f80969     	tbz	w9, #0x1f, 0x40004100 <uart_printf+0x5d0>
40003fd8: 11002128     	add	w8, w9, #0x8
40003fdc: 3100213f     	cmn	w9, #0x8
40003fe0: b90053e8     	str	w8, [sp, #0x50]
40003fe4: 540008e8     	b.hi	0x40004100 <uart_printf+0x5d0>
40003fe8: f94023e8     	ldr	x8, [sp, #0x40]
40003fec: 8b090108     	add	x8, x8, x9
40003ff0: 14000047     	b	0x4000410c <uart_printf+0x5dc>
40003ff4: 36f81269     	tbz	w9, #0x1f, 0x40004240 <uart_printf+0x710>
40003ff8: 11002128     	add	w8, w9, #0x8
40003ffc: 3100213f     	cmn	w9, #0x8
40004000: b90053e8     	str	w8, [sp, #0x50]
40004004: 540011e8     	b.hi	0x40004240 <uart_printf+0x710>
40004008: f94023e8     	ldr	x8, [sp, #0x40]
4000400c: 8b090108     	add	x8, x8, x9
40004010: 1400008f     	b	0x4000424c <uart_printf+0x71c>
40004014: f9401fe8     	ldr	x8, [sp, #0x38]
40004018: 91002109     	add	x9, x8, #0x8
4000401c: f9001fe9     	str	x9, [sp, #0x38]
40004020: f9400109     	ldr	x9, [x8]
40004024: b5000289     	cbnz	x9, 0x40004074 <uart_printf+0x544>
40004028: b94b82c8     	ldr	w8, [x22, #0xb80]
4000402c: 34000148     	cbz	w8, 0x40004054 <uart_printf+0x524>
40004030: b94b86e8     	ldr	w8, [x23, #0xb84]
40004034: 6b18011f     	cmp	w8, w24
40004038: 540000ec     	b.gt	0x40004054 <uart_printf+0x524>
4000403c: 93407d08     	sxtw	x8, w8
40004040: 5280060a     	mov	w10, #0x30              // =48
40004044: 91000509     	add	x9, x8, #0x1
40004048: 38286b2a     	strb	w10, [x25, x8]
4000404c: b90b86e9     	str	w9, [x23, #0xb84]
40004050: 38296b3f     	strb	wzr, [x25, x9]
40004054: b94002a8     	ldr	w8, [x21]
40004058: 372fffe8     	tbnz	w8, #0x5, 0x40004054 <uart_printf+0x524>
4000405c: 17fffeda     	b	0x40003bc4 <uart_printf+0x94>
40004060: f9401fe8     	ldr	x8, [sp, #0x38]
40004064: 91002109     	add	x9, x8, #0x8
40004068: f9001fe9     	str	x9, [sp, #0x38]
4000406c: b9400109     	ldr	w9, [x8]
40004070: b4fffdc9     	cbz	x9, 0x40004028 <uart_printf+0x4f8>
40004074: aa1f03ea     	mov	x10, xzr
40004078: 9bcf7d28     	umulh	x8, x9, x15
4000407c: f100253f     	cmp	x9, #0x9
40004080: d343fd0b     	lsr	x11, x8, #3
40004084: 91000548     	add	x8, x10, #0x1
40004088: 1b10a56c     	msub	w12, w11, w16, w9
4000408c: 321c0589     	orr	w9, w12, #0x30
40004090: 382a6b89     	strb	w9, [x28, x10]
40004094: aa0803ea     	mov	x10, x8
40004098: aa0b03e9     	mov	x9, x11
4000409c: 54fffee8     	b.hi	0x40004078 <uart_printf+0x548>
400040a0: d1000509     	sub	x9, x8, #0x1
400040a4: b94b82cb     	ldr	w11, [x22, #0xb80]
400040a8: 38696b8a     	ldrb	w10, [x28, x9]
400040ac: 3400012b     	cbz	w11, 0x400040d0 <uart_printf+0x5a0>
400040b0: b94b86eb     	ldr	w11, [x23, #0xb84]
400040b4: 6b18017f     	cmp	w11, w24
400040b8: 540000cc     	b.gt	0x400040d0 <uart_printf+0x5a0>
400040bc: 93407d6b     	sxtw	x11, w11
400040c0: 9100056c     	add	x12, x11, #0x1
400040c4: 382b6b2a     	strb	w10, [x25, x11]
400040c8: b90b86ec     	str	w12, [x23, #0xb84]
400040cc: 382c6b3f     	strb	wzr, [x25, x12]
400040d0: b94002ab     	ldr	w11, [x21]
400040d4: 372fffeb     	tbnz	w11, #0x5, 0x400040d0 <uart_printf+0x5a0>
400040d8: 7100051f     	cmp	w8, #0x1
400040dc: aa0903e8     	mov	x8, x9
400040e0: b900036a     	str	w10, [x27]
400040e4: 54fffdec     	b.gt	0x400040a0 <uart_printf+0x570>
400040e8: 17fffeb9     	b	0x40003bcc <uart_printf+0x9c>
400040ec: f9401fe8     	ldr	x8, [sp, #0x38]
400040f0: 91002109     	add	x9, x8, #0x8
400040f4: f9001fe9     	str	x9, [sp, #0x38]
400040f8: f9400108     	ldr	x8, [x8]
400040fc: 14000005     	b	0x40004110 <uart_printf+0x5e0>
40004100: f9401fe8     	ldr	x8, [sp, #0x38]
40004104: 91002109     	add	x9, x8, #0x8
40004108: f9001fe9     	str	x9, [sp, #0x38]
4000410c: b9400108     	ldr	w8, [x8]
40004110: 2a1f03e9     	mov	w9, wzr
40004114: 5280078a     	mov	w10, #0x3c              // =60
40004118: 14000003     	b	0x40004124 <uart_printf+0x5f4>
4000411c: b4000daa     	cbz	x10, 0x400042d0 <uart_printf+0x7a0>
40004120: d100114a     	sub	x10, x10, #0x4
40004124: 9aca250b     	lsr	x11, x8, x10
40004128: f2400d6b     	ands	x11, x11, #0xf
4000412c: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004130: 1a9f1529     	csinc	w9, w9, wzr, ne
40004134: 34ffff49     	cbz	w9, 0x4000411c <uart_printf+0x5ec>
40004138: b94b82cc     	ldr	w12, [x22, #0xb80]
4000413c: 386b6a2b     	ldrb	w11, [x17, x11]
40004140: 3400012c     	cbz	w12, 0x40004164 <uart_printf+0x634>
40004144: b94b86ec     	ldr	w12, [x23, #0xb84]
40004148: 6b18019f     	cmp	w12, w24
4000414c: 540000cc     	b.gt	0x40004164 <uart_printf+0x634>
40004150: 93407d8c     	sxtw	x12, w12
40004154: 9100058d     	add	x13, x12, #0x1
40004158: 382c6b2b     	strb	w11, [x25, x12]
4000415c: b90b86ed     	str	w13, [x23, #0xb84]
40004160: 382d6b3f     	strb	wzr, [x25, x13]
40004164: b94002ac     	ldr	w12, [x21]
40004168: 372fffec     	tbnz	w12, #0x5, 0x40004164 <uart_printf+0x634>
4000416c: b900036b     	str	w11, [x27]
40004170: b5fffd8a     	cbnz	x10, 0x40004120 <uart_printf+0x5f0>
40004174: 17fffe96     	b	0x40003bcc <uart_printf+0x9c>
40004178: f9401fe8     	ldr	x8, [sp, #0x38]
4000417c: 91002109     	add	x9, x8, #0x8
40004180: f9001fe9     	str	x9, [sp, #0x38]
40004184: f9400108     	ldr	x8, [x8]
40004188: b6f80668     	tbz	x8, #0x3f, 0x40004254 <uart_printf+0x724>
4000418c: b94b82c9     	ldr	w9, [x22, #0xb80]
40004190: 34000149     	cbz	w9, 0x400041b8 <uart_printf+0x688>
40004194: b94b86e9     	ldr	w9, [x23, #0xb84]
40004198: 6b18013f     	cmp	w9, w24
4000419c: 540000ec     	b.gt	0x400041b8 <uart_printf+0x688>
400041a0: 93407d29     	sxtw	x9, w9
400041a4: 528005ab     	mov	w11, #0x2d              // =45
400041a8: 9100052a     	add	x10, x9, #0x1
400041ac: 38296b2b     	strb	w11, [x25, x9]
400041b0: b90b86ea     	str	w10, [x23, #0xb84]
400041b4: 382a6b3f     	strb	wzr, [x25, x10]
400041b8: b94002a9     	ldr	w9, [x21]
400041bc: 372fffe9     	tbnz	w9, #0x5, 0x400041b8 <uart_printf+0x688>
400041c0: aa1f03e9     	mov	x9, xzr
400041c4: 528005aa     	mov	w10, #0x2d              // =45
400041c8: cb0803e8     	neg	x8, x8
400041cc: b900036a     	str	w10, [x27]
400041d0: 9bcf7d0a     	umulh	x10, x8, x15
400041d4: f100251f     	cmp	x8, #0x9
400041d8: d343fd4a     	lsr	x10, x10, #3
400041dc: 1b10a14b     	msub	w11, w10, w16, w8
400041e0: 321c0568     	orr	w8, w11, #0x30
400041e4: 38296b88     	strb	w8, [x28, x9]
400041e8: 91000529     	add	x9, x9, #0x1
400041ec: aa0a03e8     	mov	x8, x10
400041f0: 54ffff08     	b.hi	0x400041d0 <uart_printf+0x6a0>
400041f4: d1000528     	sub	x8, x9, #0x1
400041f8: b94b82cb     	ldr	w11, [x22, #0xb80]
400041fc: 38686b8a     	ldrb	w10, [x28, x8]
40004200: 3400012b     	cbz	w11, 0x40004224 <uart_printf+0x6f4>
40004204: b94b86eb     	ldr	w11, [x23, #0xb84]
40004208: 6b18017f     	cmp	w11, w24
4000420c: 540000cc     	b.gt	0x40004224 <uart_printf+0x6f4>
40004210: 93407d6b     	sxtw	x11, w11
40004214: 9100056c     	add	x12, x11, #0x1
40004218: 382b6b2a     	strb	w10, [x25, x11]
4000421c: b90b86ec     	str	w12, [x23, #0xb84]
40004220: 382c6b3f     	strb	wzr, [x25, x12]
40004224: b94002ab     	ldr	w11, [x21]
40004228: 372fffeb     	tbnz	w11, #0x5, 0x40004224 <uart_printf+0x6f4>
4000422c: 7100053f     	cmp	w9, #0x1
40004230: aa0803e9     	mov	x9, x8
40004234: b900036a     	str	w10, [x27]
40004238: 54fffdec     	b.gt	0x400041f4 <uart_printf+0x6c4>
4000423c: 17fffe64     	b	0x40003bcc <uart_printf+0x9c>
40004240: f9401fe8     	ldr	x8, [sp, #0x38]
40004244: 91002109     	add	x9, x8, #0x8
40004248: f9001fe9     	str	x9, [sp, #0x38]
4000424c: b9800108     	ldrsw	x8, [x8]
40004250: b7fff9e8     	tbnz	x8, #0x3f, 0x4000418c <uart_printf+0x65c>
40004254: b40005a8     	cbz	x8, 0x40004308 <uart_printf+0x7d8>
40004258: aa1f03ea     	mov	x10, xzr
4000425c: 9bcf7d09     	umulh	x9, x8, x15
40004260: f100251f     	cmp	x8, #0x9
40004264: d343fd2b     	lsr	x11, x9, #3
40004268: 91000549     	add	x9, x10, #0x1
4000426c: 1b10a16c     	msub	w12, w11, w16, w8
40004270: 321c0588     	orr	w8, w12, #0x30
40004274: 382a6b88     	strb	w8, [x28, x10]
40004278: aa0903ea     	mov	x10, x9
4000427c: aa0b03e8     	mov	x8, x11
40004280: 54fffee8     	b.hi	0x4000425c <uart_printf+0x72c>
40004284: d1000528     	sub	x8, x9, #0x1
40004288: b94b82cb     	ldr	w11, [x22, #0xb80]
4000428c: 38686b8a     	ldrb	w10, [x28, x8]
40004290: 3400012b     	cbz	w11, 0x400042b4 <uart_printf+0x784>
40004294: b94b86eb     	ldr	w11, [x23, #0xb84]
40004298: 6b18017f     	cmp	w11, w24
4000429c: 540000cc     	b.gt	0x400042b4 <uart_printf+0x784>
400042a0: 93407d6b     	sxtw	x11, w11
400042a4: 9100056c     	add	x12, x11, #0x1
400042a8: 382b6b2a     	strb	w10, [x25, x11]
400042ac: b90b86ec     	str	w12, [x23, #0xb84]
400042b0: 382c6b3f     	strb	wzr, [x25, x12]
400042b4: b94002ab     	ldr	w11, [x21]
400042b8: 372fffeb     	tbnz	w11, #0x5, 0x400042b4 <uart_printf+0x784>
400042bc: 7100053f     	cmp	w9, #0x1
400042c0: aa0803e9     	mov	x9, x8
400042c4: b900036a     	str	w10, [x27]
400042c8: 54fffdec     	b.gt	0x40004284 <uart_printf+0x754>
400042cc: 17fffe40     	b	0x40003bcc <uart_printf+0x9c>
400042d0: b94b82c8     	ldr	w8, [x22, #0xb80]
400042d4: 34000148     	cbz	w8, 0x400042fc <uart_printf+0x7cc>
400042d8: b94b86e8     	ldr	w8, [x23, #0xb84]
400042dc: 6b18011f     	cmp	w8, w24
400042e0: 540000ec     	b.gt	0x400042fc <uart_printf+0x7cc>
400042e4: 93407d08     	sxtw	x8, w8
400042e8: 5280060a     	mov	w10, #0x30              // =48
400042ec: 91000509     	add	x9, x8, #0x1
400042f0: 38286b2a     	strb	w10, [x25, x8]
400042f4: b90b86e9     	str	w9, [x23, #0xb84]
400042f8: 38296b3f     	strb	wzr, [x25, x9]
400042fc: b94002a8     	ldr	w8, [x21]
40004300: 372fffe8     	tbnz	w8, #0x5, 0x400042fc <uart_printf+0x7cc>
40004304: 17fffe30     	b	0x40003bc4 <uart_printf+0x94>
40004308: b94b82c8     	ldr	w8, [x22, #0xb80]
4000430c: 34000148     	cbz	w8, 0x40004334 <uart_printf+0x804>
40004310: b94b86e8     	ldr	w8, [x23, #0xb84]
40004314: 6b18011f     	cmp	w8, w24
40004318: 540000ec     	b.gt	0x40004334 <uart_printf+0x804>
4000431c: 93407d08     	sxtw	x8, w8
40004320: 5280060a     	mov	w10, #0x30              // =48
40004324: 91000509     	add	x9, x8, #0x1
40004328: 38286b2a     	strb	w10, [x25, x8]
4000432c: b90b86e9     	str	w9, [x23, #0xb84]
40004330: 38296b3f     	strb	wzr, [x25, x9]
40004334: b94002a8     	ldr	w8, [x21]
40004338: 372fffe8     	tbnz	w8, #0x5, 0x40004334 <uart_printf+0x804>
4000433c: 17fffe22     	b	0x40003bc4 <uart_printf+0x94>
40004340: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004344: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004348: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
4000434c: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004350: a9486ffc     	ldp	x28, x27, [sp, #0x80]
40004354: a9477bfd     	ldp	x29, x30, [sp, #0x70]
40004358: 910343ff     	add	sp, sp, #0xd0
4000435c: d65f03c0     	ret

0000000040004360 <vfs_init>:
40004360: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004364: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004368: f0000073     	adrp	x19, 0x40013000 <kernel_capture_buffer+0x3478>
4000436c: 912e8273     	add	x19, x19, #0xba0
40004370: f9000bf9     	str	x25, [sp, #0x10]
40004374: f0000079     	adrp	x25, 0x40013000 <kernel_capture_buffer+0x3478>
40004378: 52800034     	mov	w20, #0x1               // =1
4000437c: aa1303e0     	mov	x0, x19
40004380: 2a1f03e1     	mov	w1, wzr
40004384: 52809802     	mov	w2, #0x4c0              // =1216
40004388: a9025ff8     	stp	x24, x23, [sp, #0x20]
4000438c: 910003fd     	mov	x29, sp
40004390: a90357f6     	stp	x22, x21, [sp, #0x30]
40004394: b90b8b34     	str	w20, [x25, #0xb88]
40004398: 97fff981     	bl	0x4000299c <memset>
4000439c: 528005e8     	mov	w8, #0x2f               // =47
400043a0: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
400043a4: b9002274     	str	w20, [x19, #0x20]
400043a8: 79000268     	strh	w8, [x19]
400043ac: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400043b0: f905c933     	str	x19, [x9, #0xb90]
400043b4: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
400043b8: 7101fd1f     	cmp	w8, #0x7f
400043bc: f9021a7f     	str	xzr, [x19, #0x430]
400043c0: f900167f     	str	xzr, [x19, #0x28]
400043c4: b904ba7f     	str	wzr, [x19, #0x4b8]
400043c8: f905cd33     	str	x19, [x9, #0xb98]
400043cc: 540028ac     	b.gt	0x400048e0 <vfs_init+0x580>
400043d0: 52809809     	mov	w9, #0x4c0              // =1216
400043d4: 2a1f03e1     	mov	w1, wzr
400043d8: 52809802     	mov	w2, #0x4c0              // =1216
400043dc: 9b294d17     	smaddl	x23, w8, w9, x19
400043e0: 11000508     	add	w8, w8, #0x1
400043e4: b90b8b28     	str	w8, [x25, #0xb88]
400043e8: aa1703e0     	mov	x0, x23
400043ec: 97fff96c     	bl	0x4000299c <memset>
400043f0: 528d2c48     	mov	w8, #0x6962             // =26978
400043f4: b904baff     	str	wzr, [x23, #0x4b8]
400043f8: 72a00dc8     	movk	w8, #0x6e, lsl #16
400043fc: b90022f4     	str	w20, [x23, #0x20]
40004400: b90002e8     	str	w8, [x23]
40004404: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004408: f9021af3     	str	x19, [x23, #0x430]
4000440c: 71003d1f     	cmp	w8, #0xf
40004410: f90016ff     	str	xzr, [x23, #0x28]
40004414: 540000ac     	b.gt	0x40004428 <vfs_init+0xc8>
40004418: 11000509     	add	w9, w8, #0x1
4000441c: 8b080e68     	add	x8, x19, x8, lsl #3
40004420: b904ba69     	str	w9, [x19, #0x4b8]
40004424: f9021d17     	str	x23, [x8, #0x438]
40004428: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000442c: 7101fd1f     	cmp	w8, #0x7f
40004430: 5400258c     	b.gt	0x400048e0 <vfs_init+0x580>
40004434: 52809809     	mov	w9, #0x4c0              // =1216
40004438: 2a1f03e1     	mov	w1, wzr
4000443c: 52809802     	mov	w2, #0x4c0              // =1216
40004440: 9b294d16     	smaddl	x22, w8, w9, x19
40004444: 11000508     	add	w8, w8, #0x1
40004448: b90b8b28     	str	w8, [x25, #0xb88]
4000444c: aa1603e0     	mov	x0, x22
40004450: 97fff953     	bl	0x4000299c <memset>
40004454: 528e8ca8     	mov	w8, #0x7465             // =29797
40004458: b904badf     	str	wzr, [x22, #0x4b8]
4000445c: 52800029     	mov	w9, #0x1                // =1
40004460: 72a00c68     	movk	w8, #0x63, lsl #16
40004464: b90022c9     	str	w9, [x22, #0x20]
40004468: b90002c8     	str	w8, [x22]
4000446c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004470: f9021ad3     	str	x19, [x22, #0x430]
40004474: 71003d1f     	cmp	w8, #0xf
40004478: f90016df     	str	xzr, [x22, #0x28]
4000447c: 540000ac     	b.gt	0x40004490 <vfs_init+0x130>
40004480: 11000509     	add	w9, w8, #0x1
40004484: 8b080e68     	add	x8, x19, x8, lsl #3
40004488: b904ba69     	str	w9, [x19, #0x4b8]
4000448c: f9021d16     	str	x22, [x8, #0x438]
40004490: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004494: 7101fd1f     	cmp	w8, #0x7f
40004498: 5400224c     	b.gt	0x400048e0 <vfs_init+0x580>
4000449c: 52809809     	mov	w9, #0x4c0              // =1216
400044a0: 2a1f03e1     	mov	w1, wzr
400044a4: 52809802     	mov	w2, #0x4c0              // =1216
400044a8: 9b294d14     	smaddl	x20, w8, w9, x19
400044ac: 11000508     	add	w8, w8, #0x1
400044b0: b90b8b28     	str	w8, [x25, #0xb88]
400044b4: aa1403e0     	mov	x0, x20
400044b8: 97fff939     	bl	0x4000299c <memset>
400044bc: 528ded08     	mov	w8, #0x6f68             // =28520
400044c0: b904ba9f     	str	wzr, [x20, #0x4b8]
400044c4: 52800029     	mov	w9, #0x1                // =1
400044c8: 72acada8     	movk	w8, #0x656d, lsl #16
400044cc: 3900129f     	strb	wzr, [x20, #0x4]
400044d0: b9000288     	str	w8, [x20]
400044d4: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400044d8: b9002289     	str	w9, [x20, #0x20]
400044dc: 71003d1f     	cmp	w8, #0xf
400044e0: f9021a93     	str	x19, [x20, #0x430]
400044e4: f900169f     	str	xzr, [x20, #0x28]
400044e8: 540000ac     	b.gt	0x400044fc <vfs_init+0x19c>
400044ec: 11000509     	add	w9, w8, #0x1
400044f0: 8b080e68     	add	x8, x19, x8, lsl #3
400044f4: b904ba69     	str	w9, [x19, #0x4b8]
400044f8: f9021d14     	str	x20, [x8, #0x438]
400044fc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004500: 7101fd1f     	cmp	w8, #0x7f
40004504: 54001eec     	b.gt	0x400048e0 <vfs_init+0x580>
40004508: 52809809     	mov	w9, #0x4c0              // =1216
4000450c: 2a1f03e1     	mov	w1, wzr
40004510: 52809802     	mov	w2, #0x4c0              // =1216
40004514: 9b294d15     	smaddl	x21, w8, w9, x19
40004518: 11000508     	add	w8, w8, #0x1
4000451c: b90b8b28     	str	w8, [x25, #0xb88]
40004520: aa1503e0     	mov	x0, x21
40004524: 97fff91e     	bl	0x4000299c <memset>
40004528: 528dec88     	mov	w8, #0x6f64             // =28516
4000452c: b904babf     	str	wzr, [x21, #0x4b8]
40004530: 52800029     	mov	w9, #0x1                // =1
40004534: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004538: 390012bf     	strb	wzr, [x21, #0x4]
4000453c: b90002a8     	str	w8, [x21]
40004540: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004544: b90022a9     	str	w9, [x21, #0x20]
40004548: 71003d1f     	cmp	w8, #0xf
4000454c: f9021ab3     	str	x19, [x21, #0x430]
40004550: f90016bf     	str	xzr, [x21, #0x28]
40004554: 540000ac     	b.gt	0x40004568 <vfs_init+0x208>
40004558: 11000509     	add	w9, w8, #0x1
4000455c: 8b080e68     	add	x8, x19, x8, lsl #3
40004560: b904ba69     	str	w9, [x19, #0x4b8]
40004564: f9021d15     	str	x21, [x8, #0x438]
40004568: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000456c: 7101fd1f     	cmp	w8, #0x7f
40004570: 54001b8c     	b.gt	0x400048e0 <vfs_init+0x580>
40004574: 52809809     	mov	w9, #0x4c0              // =1216
40004578: 2a1f03e1     	mov	w1, wzr
4000457c: 52809802     	mov	w2, #0x4c0              // =1216
40004580: 9b294d18     	smaddl	x24, w8, w9, x19
40004584: 11000508     	add	w8, w8, #0x1
40004588: b90b8b28     	str	w8, [x25, #0xb88]
4000458c: aa1803e0     	mov	x0, x24
40004590: 97fff903     	bl	0x4000299c <memset>
40004594: 528d2c28     	mov	w8, #0x6961             // =26977
40004598: b904bb1f     	str	wzr, [x24, #0x4b8]
4000459c: 79000308     	strh	w8, [x24]
400045a0: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400045a4: 39000b1f     	strb	wzr, [x24, #0x2]
400045a8: 71003d1f     	cmp	w8, #0xf
400045ac: b900231f     	str	wzr, [x24, #0x20]
400045b0: f9021b17     	str	x23, [x24, #0x430]
400045b4: f900171f     	str	xzr, [x24, #0x28]
400045b8: 540000ac     	b.gt	0x400045cc <vfs_init+0x26c>
400045bc: 8b080ee9     	add	x9, x23, x8, lsl #3
400045c0: 11000508     	add	w8, w8, #0x1
400045c4: b904bae8     	str	w8, [x23, #0x4b8]
400045c8: f9021d38     	str	x24, [x9, #0x438]
400045cc: d503201f     	nop
400045d0: 100287b7     	adr	x23, 0x400096c4 <__rodata_start+0x26c4>
400045d4: 9100c300     	add	x0, x24, #0x30
400045d8: aa1703e1     	mov	x1, x23
400045dc: 97fff8c4     	bl	0x400028ec <kstrcpy>
400045e0: aa1703e0     	mov	x0, x23
400045e4: 97fff893     	bl	0x40002830 <kstrlen>
400045e8: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045ec: f9001700     	str	x0, [x24, #0x28]
400045f0: 7101fd1f     	cmp	w8, #0x7f
400045f4: 5400176c     	b.gt	0x400048e0 <vfs_init+0x580>
400045f8: 52809809     	mov	w9, #0x4c0              // =1216
400045fc: 2a1f03e1     	mov	w1, wzr
40004600: 52809802     	mov	w2, #0x4c0              // =1216
40004604: 9b294d17     	smaddl	x23, w8, w9, x19
40004608: 11000508     	add	w8, w8, #0x1
4000460c: b90b8b28     	str	w8, [x25, #0xb88]
40004610: aa1703e0     	mov	x0, x23
40004614: 97fff8e2     	bl	0x4000299c <memset>
40004618: d28e6de8     	mov	x8, #0x736f             // =29551
4000461c: b904baff     	str	wzr, [x23, #0x4b8]
40004620: 528cae69     	mov	w9, #0x6573             // =25971
40004624: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004628: 790012e9     	strh	w9, [x23, #0x8]
4000462c: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
40004630: 39002aff     	strb	wzr, [x23, #0xa]
40004634: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004638: b90022ff     	str	wzr, [x23, #0x20]
4000463c: f90002e8     	str	x8, [x23]
40004640: b984bac8     	ldrsw	x8, [x22, #0x4b8]
40004644: f9021af6     	str	x22, [x23, #0x430]
40004648: 71003d1f     	cmp	w8, #0xf
4000464c: f90016ff     	str	xzr, [x23, #0x28]
40004650: 540000ac     	b.gt	0x40004664 <vfs_init+0x304>
40004654: 8b080ec9     	add	x9, x22, x8, lsl #3
40004658: 11000508     	add	w8, w8, #0x1
4000465c: b904bac8     	str	w8, [x22, #0x4b8]
40004660: f9021d37     	str	x23, [x9, #0x438]
40004664: f0000016     	adrp	x22, 0x40007000 <__rodata_start>
40004668: 91362ad6     	add	x22, x22, #0xd8a
4000466c: 9100c2e0     	add	x0, x23, #0x30
40004670: aa1603e1     	mov	x1, x22
40004674: 97fff89e     	bl	0x400028ec <kstrcpy>
40004678: aa1603e0     	mov	x0, x22
4000467c: 97fff86d     	bl	0x40002830 <kstrlen>
40004680: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004684: f90016e0     	str	x0, [x23, #0x28]
40004688: 7101fd1f     	cmp	w8, #0x7f
4000468c: 540012ac     	b.gt	0x400048e0 <vfs_init+0x580>
40004690: 52809809     	mov	w9, #0x4c0              // =1216
40004694: 2a1f03e1     	mov	w1, wzr
40004698: 52809802     	mov	w2, #0x4c0              // =1216
4000469c: 9b294d16     	smaddl	x22, w8, w9, x19
400046a0: 11000508     	add	w8, w8, #0x1
400046a4: b90b8b28     	str	w8, [x25, #0xb88]
400046a8: aa1603e0     	mov	x0, x22
400046ac: 97fff8bc     	bl	0x4000299c <memset>
400046b0: d28caee8     	mov	x8, #0x6577             // =25975
400046b4: b904badf     	str	wzr, [x22, #0x4b8]
400046b8: 528f0e89     	mov	w9, #0x7874             // =30836
400046bc: f2ac6d88     	movk	x8, #0x636c, lsl #16
400046c0: 72a00e89     	movk	w9, #0x74, lsl #16
400046c4: b90022df     	str	wzr, [x22, #0x20]
400046c8: f2cdade8     	movk	x8, #0x6d6f, lsl #32
400046cc: b9000ac9     	str	w9, [x22, #0x8]
400046d0: f2e5cca8     	movk	x8, #0x2e65, lsl #48
400046d4: f9021ad5     	str	x21, [x22, #0x430]
400046d8: f90002c8     	str	x8, [x22]
400046dc: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400046e0: f90016df     	str	xzr, [x22, #0x28]
400046e4: 71003d1f     	cmp	w8, #0xf
400046e8: 540000ac     	b.gt	0x400046fc <vfs_init+0x39c>
400046ec: 8b080ea9     	add	x9, x21, x8, lsl #3
400046f0: 11000508     	add	w8, w8, #0x1
400046f4: b904baa8     	str	w8, [x21, #0x4b8]
400046f8: f9021d36     	str	x22, [x9, #0x438]
400046fc: f0000017     	adrp	x23, 0x40007000 <__rodata_start>
40004700: 913cbef7     	add	x23, x23, #0xf2f
40004704: 9100c2c0     	add	x0, x22, #0x30
40004708: aa1703e1     	mov	x1, x23
4000470c: 97fff878     	bl	0x400028ec <kstrcpy>
40004710: aa1703e0     	mov	x0, x23
40004714: 97fff847     	bl	0x40002830 <kstrlen>
40004718: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000471c: f90016c0     	str	x0, [x22, #0x28]
40004720: 7101fd1f     	cmp	w8, #0x7f
40004724: 54000dec     	b.gt	0x400048e0 <vfs_init+0x580>
40004728: 52809809     	mov	w9, #0x4c0              // =1216
4000472c: 2a1f03e1     	mov	w1, wzr
40004730: 52809802     	mov	w2, #0x4c0              // =1216
40004734: 9b294d16     	smaddl	x22, w8, w9, x19
40004738: 11000508     	add	w8, w8, #0x1
4000473c: b90b8b28     	str	w8, [x25, #0xb88]
40004740: aa1603e0     	mov	x0, x22
40004744: 97fff896     	bl	0x4000299c <memset>
40004748: d28c2d08     	mov	x8, #0x6168             // =24936
4000474c: b904badf     	str	wzr, [x22, #0x4b8]
40004750: 528e85c9     	mov	w9, #0x742e             // =29742
40004754: f2ac8e48     	movk	x8, #0x6472, lsl #16
40004758: 72ae8f09     	movk	w9, #0x7478, lsl #16
4000475c: 390032df     	strb	wzr, [x22, #0xc]
40004760: f2cc2ee8     	movk	x8, #0x6177, lsl #32
40004764: b9000ac9     	str	w9, [x22, #0x8]
40004768: f2ecae48     	movk	x8, #0x6572, lsl #48
4000476c: b90022df     	str	wzr, [x22, #0x20]
40004770: f90002c8     	str	x8, [x22]
40004774: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004778: f9021ad5     	str	x21, [x22, #0x430]
4000477c: 71003d1f     	cmp	w8, #0xf
40004780: f90016df     	str	xzr, [x22, #0x28]
40004784: 540000ac     	b.gt	0x40004798 <vfs_init+0x438>
40004788: 8b080ea9     	add	x9, x21, x8, lsl #3
4000478c: 11000508     	add	w8, w8, #0x1
40004790: b904baa8     	str	w8, [x21, #0x4b8]
40004794: f9021d36     	str	x22, [x9, #0x438]
40004798: 90000037     	adrp	x23, 0x40008000 <__rodata_start+0x1000>
4000479c: 910b72f7     	add	x23, x23, #0x2dc
400047a0: 9100c2c0     	add	x0, x22, #0x30
400047a4: aa1703e1     	mov	x1, x23
400047a8: 97fff851     	bl	0x400028ec <kstrcpy>
400047ac: aa1703e0     	mov	x0, x23
400047b0: 97fff820     	bl	0x40002830 <kstrlen>
400047b4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047b8: f90016c0     	str	x0, [x22, #0x28]
400047bc: 7101fd1f     	cmp	w8, #0x7f
400047c0: 5400090c     	b.gt	0x400048e0 <vfs_init+0x580>
400047c4: 52809809     	mov	w9, #0x4c0              // =1216
400047c8: 2a1f03e1     	mov	w1, wzr
400047cc: 52809802     	mov	w2, #0x4c0              // =1216
400047d0: 9b294d16     	smaddl	x22, w8, w9, x19
400047d4: 11000508     	add	w8, w8, #0x1
400047d8: b90b8b28     	str	w8, [x25, #0xb88]
400047dc: aa1603e0     	mov	x0, x22
400047e0: 97fff86f     	bl	0x4000299c <memset>
400047e4: 528d2c28     	mov	w8, #0x6961             // =26977
400047e8: b904badf     	str	wzr, [x22, #0x4b8]
400047ec: 528e8f09     	mov	w9, #0x7478             // =29816
400047f0: 72ae85c8     	movk	w8, #0x742e, lsl #16
400047f4: 79000ac9     	strh	w9, [x22, #0x4]
400047f8: b90002c8     	str	w8, [x22]
400047fc: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004800: 39001adf     	strb	wzr, [x22, #0x6]
40004804: 71003d1f     	cmp	w8, #0xf
40004808: b90022df     	str	wzr, [x22, #0x20]
4000480c: f9021ad5     	str	x21, [x22, #0x430]
40004810: f90016df     	str	xzr, [x22, #0x28]
40004814: 540000ac     	b.gt	0x40004828 <vfs_init+0x4c8>
40004818: 8b080ea9     	add	x9, x21, x8, lsl #3
4000481c: 11000508     	add	w8, w8, #0x1
40004820: b904baa8     	str	w8, [x21, #0x4b8]
40004824: f9021d36     	str	x22, [x9, #0x438]
40004828: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
4000482c: 910f32b5     	add	x21, x21, #0x3cc
40004830: 9100c2c0     	add	x0, x22, #0x30
40004834: aa1503e1     	mov	x1, x21
40004838: 97fff82d     	bl	0x400028ec <kstrcpy>
4000483c: aa1503e0     	mov	x0, x21
40004840: 97fff7fc     	bl	0x40002830 <kstrlen>
40004844: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004848: f90016c0     	str	x0, [x22, #0x28]
4000484c: 7101fd1f     	cmp	w8, #0x7f
40004850: 5400048c     	b.gt	0x400048e0 <vfs_init+0x580>
40004854: 52809809     	mov	w9, #0x4c0              // =1216
40004858: 2a1f03e1     	mov	w1, wzr
4000485c: 52809802     	mov	w2, #0x4c0              // =1216
40004860: 9b294d13     	smaddl	x19, w8, w9, x19
40004864: 11000508     	add	w8, w8, #0x1
40004868: b90b8b28     	str	w8, [x25, #0xb88]
4000486c: aa1303e0     	mov	x0, x19
40004870: 97fff84b     	bl	0x4000299c <memset>
40004874: d28cae48     	mov	x8, #0x6572             // =25970
40004878: b904ba7f     	str	wzr, [x19, #0x4b8]
4000487c: 528e8f09     	mov	w9, #0x7478             // =29816
40004880: f2ac8c28     	movk	x8, #0x6461, lsl #16
40004884: 79001269     	strh	w9, [x19, #0x8]
40004888: f2ccada8     	movk	x8, #0x656d, lsl #32
4000488c: 39002a7f     	strb	wzr, [x19, #0xa]
40004890: f2ee85c8     	movk	x8, #0x742e, lsl #48
40004894: b900227f     	str	wzr, [x19, #0x20]
40004898: f9000268     	str	x8, [x19]
4000489c: b984ba88     	ldrsw	x8, [x20, #0x4b8]
400048a0: f9021a74     	str	x20, [x19, #0x430]
400048a4: 71003d1f     	cmp	w8, #0xf
400048a8: f900167f     	str	xzr, [x19, #0x28]
400048ac: 540000ac     	b.gt	0x400048c0 <vfs_init+0x560>
400048b0: 8b080e89     	add	x9, x20, x8, lsl #3
400048b4: 11000508     	add	w8, w8, #0x1
400048b8: b904ba88     	str	w8, [x20, #0x4b8]
400048bc: f9021d33     	str	x19, [x9, #0x438]
400048c0: f0000014     	adrp	x20, 0x40007000 <__rodata_start>
400048c4: 910dc694     	add	x20, x20, #0x371
400048c8: 9100c260     	add	x0, x19, #0x30
400048cc: aa1403e1     	mov	x1, x20
400048d0: 97fff807     	bl	0x400028ec <kstrcpy>
400048d4: aa1403e0     	mov	x0, x20
400048d8: 97fff7d6     	bl	0x40002830 <kstrlen>
400048dc: f9001660     	str	x0, [x19, #0x28]
400048e0: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400048e4: f9400bf9     	ldr	x25, [sp, #0x10]
400048e8: a94357f6     	ldp	x22, x21, [sp, #0x30]
400048ec: a9425ff8     	ldp	x24, x23, [sp, #0x20]
400048f0: a8c57bfd     	ldp	x29, x30, [sp], #0x50
400048f4: d65f03c0     	ret

00000000400048f8 <vfs_load_internal>:
400048f8: 2a1f03e0     	mov	w0, wzr
400048fc: d65f03c0     	ret

0000000040004900 <vfs_get_root>:
40004900: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004904: f945c900     	ldr	x0, [x8, #0xb90]
40004908: d65f03c0     	ret

000000004000490c <vfs_get_cwd>:
4000490c: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004910: f945cd00     	ldr	x0, [x8, #0xb98]
40004914: d65f03c0     	ret

0000000040004918 <vfs_getcwd>:
40004918: d10343ff     	sub	sp, sp, #0xd0
4000491c: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004920: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004924: aa0003f3     	mov	x19, x0
40004928: f945cd08     	ldr	x8, [x8, #0xb98]
4000492c: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004930: 910203fd     	add	x29, sp, #0x80
40004934: a90967fa     	stp	x26, x25, [sp, #0x90]
40004938: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
4000493c: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004940: b4000228     	cbz	x8, 0x40004984 <vfs_getcwd+0x6c>
40004944: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
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
400049f8: 97fff78e     	bl	0x40002830 <kstrlen>
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
40004a8c: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004a90: 52800037     	mov	w23, #0x1               // =1
40004a94: f945c913     	ldr	x19, [x8, #0xb90]
40004a98: 38776a88     	ldrb	w8, [x20, x23]
40004a9c: 7100bd1f     	cmp	w8, #0x2f
40004aa0: 540000e1     	b.ne	0x40004abc <vfs_find+0x68>
40004aa4: 910006f7     	add	x23, x23, #0x1
40004aa8: 17fffffc     	b	0x40004a98 <vfs_find+0x44>
40004aac: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004ab0: aa1f03f7     	mov	x23, xzr
40004ab4: f945cd33     	ldr	x19, [x9, #0xb98]
40004ab8: 14000002     	b	0x40004ac0 <vfs_find+0x6c>
40004abc: 34000848     	cbz	w8, 0x40004bc4 <vfs_find+0x170>
40004ac0: 91000698     	add	x24, x20, #0x1
40004ac4: f0000015     	adrp	x21, 0x40007000 <__rodata_start>
40004ac8: 91263eb5     	add	x21, x21, #0x98f
40004acc: 910003f9     	mov	x25, sp
40004ad0: 90000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40004ad4: 91032ad6     	add	x22, x22, #0xca
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
40004b60: 97fff744     	bl	0x40002870 <kstrcmp>
40004b64: 34fffc20     	cbz	w0, 0x40004ae8 <vfs_find+0x94>
40004b68: 910003e0     	mov	x0, sp
40004b6c: aa1603e1     	mov	x1, x22
40004b70: 97fff740     	bl	0x40002870 <kstrcmp>
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
40004bac: 97fff731     	bl	0x40002870 <kstrcmp>
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
40004c00: b0000021     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40004c04: 910bec21     	add	x1, x1, #0x2fb
40004c08: aa0003f3     	mov	x19, x0
40004c0c: 97fff719     	bl	0x40002870 <kstrcmp>
40004c10: 34000120     	cbz	w0, 0x40004c34 <vfs_chdir+0x4c>
40004c14: aa1303e0     	mov	x0, x19
40004c18: 97ffff8f     	bl	0x40004a54 <vfs_find>
40004c1c: b40002c0     	cbz	x0, 0x40004c74 <vfs_chdir+0x8c>
40004c20: b9402008     	ldr	w8, [x0, #0x20]
40004c24: 7100051f     	cmp	w8, #0x1
40004c28: 54000180     	b.eq	0x40004c58 <vfs_chdir+0x70>
40004c2c: 12800028     	mov	w8, #-0x2               // =-2
40004c30: 1400000d     	b	0x40004c64 <vfs_chdir+0x7c>
40004c34: f0000000     	adrp	x0, 0x40007000 <__rodata_start>
40004c38: 913e9000     	add	x0, x0, #0xfa4
40004c3c: 97ffff86     	bl	0x40004a54 <vfs_find>
40004c40: b4000080     	cbz	x0, 0x40004c50 <vfs_chdir+0x68>
40004c44: b9402008     	ldr	w8, [x0, #0x20]
40004c48: 7100051f     	cmp	w8, #0x1
40004c4c: 54000060     	b.eq	0x40004c58 <vfs_chdir+0x70>
40004c50: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004c54: f945c900     	ldr	x0, [x8, #0xb90]
40004c58: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
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
40004c9c: f0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
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
40004cf8: 97fff6de     	bl	0x40002870 <kstrcmp>
40004cfc: 340003e0     	cbz	w0, 0x40004d78 <vfs_mkdir+0xfc>
40004d00: f945ce95     	ldr	x21, [x20, #0xb98]
40004d04: 17fffff5     	b	0x40004cd8 <vfs_mkdir+0x5c>
40004d08: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004d0c: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004d10: 7101fd3f     	cmp	w9, #0x7f
40004d14: 5400006d     	b.le	0x40004d20 <vfs_mkdir+0xa4>
40004d18: 12800060     	mov	w0, #-0x4               // =-4
40004d1c: 14000029     	b	0x40004dc0 <vfs_mkdir+0x144>
40004d20: 5280980a     	mov	w10, #0x4c0             // =1216
40004d24: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004d28: 912e816b     	add	x11, x11, #0xba0
40004d2c: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d30: 11000529     	add	w9, w9, #0x1
40004d34: 2a1f03e1     	mov	w1, wzr
40004d38: 52809802     	mov	w2, #0x4c0              // =1216
40004d3c: b90b8909     	str	w9, [x8, #0xb88]
40004d40: aa1403e0     	mov	x0, x20
40004d44: 97fff716     	bl	0x4000299c <memset>
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
40004de4: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
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
40004e48: 97fff6b0     	bl	0x40002908 <kstrncpy>
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
40004e98: 97fff69c     	bl	0x40002908 <kstrncpy>
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
40004ed0: 97fff668     	bl	0x40002870 <kstrcmp>
40004ed4: 340004a0     	cbz	w0, 0x40004f68 <vfs_touch+0x194>
40004ed8: b944ba68     	ldr	w8, [x19, #0x4b8]
40004edc: 17fffff7     	b	0x40004eb8 <vfs_touch+0xe4>
40004ee0: 71003d1f     	cmp	w8, #0xf
40004ee4: 5400006d     	b.le	0x40004ef0 <vfs_touch+0x11c>
40004ee8: 12800020     	mov	w0, #-0x2               // =-2
40004eec: 1400004f     	b	0x40005028 <vfs_touch+0x254>
40004ef0: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004ef4: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004ef8: 7101fd3f     	cmp	w9, #0x7f
40004efc: 5400006d     	b.le	0x40004f08 <vfs_touch+0x134>
40004f00: 12800060     	mov	w0, #-0x4               // =-4
40004f04: 14000049     	b	0x40005028 <vfs_touch+0x254>
40004f08: 5280980a     	mov	w10, #0x4c0             // =1216
40004f0c: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004f10: 912e816b     	add	x11, x11, #0xba0
40004f14: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004f18: 11000529     	add	w9, w9, #0x1
40004f1c: 2a1f03e1     	mov	w1, wzr
40004f20: 52809802     	mov	w2, #0x4c0              // =1216
40004f24: b90b8909     	str	w9, [x8, #0xb88]
40004f28: aa1403e0     	mov	x0, x20
40004f2c: 97fff69c     	bl	0x4000299c <memset>
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
40004f70: 97fff630     	bl	0x40002830 <kstrlen>
40004f74: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f78: f10ffc1f     	cmp	x0, #0x3ff
40004f7c: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f80: 9a883014     	csel	x20, x0, x8, lo
40004f84: aa1503e1     	mov	x1, x21
40004f88: 9100c120     	add	x0, x9, #0x30
40004f8c: aa1403e2     	mov	x2, x20
40004f90: 97fff699     	bl	0x400029f4 <memcpy>
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
40004ff0: 97fff610     	bl	0x40002830 <kstrlen>
40004ff4: 52807fe8     	mov	w8, #0x3ff              // =1023
40004ff8: f10ffc1f     	cmp	x0, #0x3ff
40004ffc: 9100c296     	add	x22, x20, #0x30
40005000: 9a883015     	csel	x21, x0, x8, lo
40005004: aa1603e0     	mov	x0, x22
40005008: aa1303e1     	mov	x1, x19
4000500c: aa1503e2     	mov	x2, x21
40005010: 97fff679     	bl	0x400029f4 <memcpy>
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
40005040: 17ffff65     	b	0x40004dd4 <vfs_touch>

0000000040005044 <vfs_remove>:
40005044: b40005c0     	cbz	x0, 0x400050fc <vfs_remove+0xb8>
40005048: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
4000504c: 39400008     	ldrb	w8, [x0]
40005050: a9024ff4     	stp	x20, x19, [sp, #0x20]
40005054: aa0003f3     	mov	x19, x0
40005058: f9000bf5     	str	x21, [sp, #0x10]
4000505c: 910003fd     	mov	x29, sp
40005060: 34000448     	cbz	w8, 0x400050e8 <vfs_remove+0xa4>
40005064: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
40005068: f945ce88     	ldr	x8, [x20, #0xb98]
4000506c: b944b909     	ldr	w9, [x8, #0x4b8]
40005070: 7100053f     	cmp	w9, #0x1
40005074: 540003ab     	b.lt	0x400050e8 <vfs_remove+0xa4>
40005078: aa1f03f5     	mov	x21, xzr
4000507c: 14000005     	b	0x40005090 <vfs_remove+0x4c>
40005080: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005084: 910006b5     	add	x21, x21, #0x1
40005088: eb0902bf     	cmp	x21, x9
4000508c: 540002ea     	b.ge	0x400050e8 <vfs_remove+0xa4>
40005090: 8b150d09     	add	x9, x8, x21, lsl #3
40005094: f9421d20     	ldr	x0, [x9, #0x438]
40005098: b4ffff40     	cbz	x0, 0x40005080 <vfs_remove+0x3c>
4000509c: aa1303e1     	mov	x1, x19
400050a0: 97fff5f4     	bl	0x40002870 <kstrcmp>
400050a4: f945ce88     	ldr	x8, [x20, #0xb98]
400050a8: 35fffec0     	cbnz	w0, 0x40005080 <vfs_remove+0x3c>
400050ac: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050b0: d1000529     	sub	x9, x9, #0x1
400050b4: 6b15013f     	cmp	w9, w21
400050b8: 5400026d     	b.le	0x40005104 <vfs_remove+0xc0>
400050bc: f945ce8a     	ldr	x10, [x20, #0xb98]
400050c0: b984b949     	ldrsw	x9, [x10, #0x4b8]
400050c4: d1000529     	sub	x9, x9, #0x1
400050c8: 8b150d08     	add	x8, x8, x21, lsl #3
400050cc: 910006b5     	add	x21, x21, #0x1
400050d0: eb0902bf     	cmp	x21, x9
400050d4: f942210b     	ldr	x11, [x8, #0x440]
400050d8: f9021d0b     	str	x11, [x8, #0x438]
400050dc: aa0a03e8     	mov	x8, x10
400050e0: 54ffff4b     	b.lt	0x400050c8 <vfs_remove+0x84>
400050e4: 14000009     	b	0x40005108 <vfs_remove+0xc4>
400050e8: 12800000     	mov	w0, #-0x1               // =-1
400050ec: a9424ff4     	ldp	x20, x19, [sp, #0x20]
400050f0: f9400bf5     	ldr	x21, [sp, #0x10]
400050f4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
400050f8: d65f03c0     	ret
400050fc: 12800000     	mov	w0, #-0x1               // =-1
40005100: d65f03c0     	ret
40005104: aa0803ea     	mov	x10, x8
40005108: 8b090d48     	add	x8, x10, x9, lsl #3
4000510c: 2a1f03e0     	mov	w0, wzr
40005110: f9021d1f     	str	xzr, [x8, #0x438]
40005114: f945ce88     	ldr	x8, [x20, #0xb98]
40005118: b944b909     	ldr	w9, [x8, #0x4b8]
4000511c: 51000529     	sub	w9, w9, #0x1
40005120: b904b909     	str	w9, [x8, #0x4b8]
40005124: 17fffff2     	b	0x400050ec <vfs_remove+0xa8>

0000000040005128 <vfs_list_dir>:
40005128: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000512c: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40005130: f100001f     	cmp	x0, #0x0
40005134: a90257f6     	stp	x22, x21, [sp, #0x20]
40005138: f945cd08     	ldr	x8, [x8, #0xb98]
4000513c: f9000bf7     	str	x23, [sp, #0x10]
40005140: 910003fd     	mov	x29, sp
40005144: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005148: 9a800115     	csel	x21, x8, x0, eq
4000514c: b94022a8     	ldr	w8, [x21, #0x20]
40005150: 7100051f     	cmp	w8, #0x1
40005154: 54000521     	b.ne	0x400051f8 <vfs_list_dir+0xd0>
40005158: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
4000515c: 91375c00     	add	x0, x0, #0xdd7
40005160: 97fff95f     	bl	0x400036dc <uart_puts>
40005164: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005168: 9120d800     	add	x0, x0, #0x836
4000516c: 97fff95c     	bl	0x400036dc <uart_puts>
40005170: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005174: 9138a400     	add	x0, x0, #0xe29
40005178: 97fff959     	bl	0x400036dc <uart_puts>
4000517c: f9421aa8     	ldr	x8, [x21, #0x430]
40005180: b4000088     	cbz	x8, 0x40005190 <vfs_list_dir+0x68>
40005184: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005188: 910ce800     	add	x0, x0, #0x33a
4000518c: 97fff954     	bl	0x400036dc <uart_puts>
40005190: b944baa1     	ldr	w1, [x21, #0x4b8]
40005194: 7100043f     	cmp	w1, #0x1
40005198: 5400034b     	b.lt	0x40005200 <vfs_list_dir+0xd8>
4000519c: aa1f03f6     	mov	x22, xzr
400051a0: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
400051a4: 912d9a73     	add	x19, x19, #0xb66
400051a8: 9110e2b7     	add	x23, x21, #0x438
400051ac: f0000014     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400051b0: 911b0a94     	add	x20, x20, #0x6c2
400051b4: 14000008     	b	0x400051d4 <vfs_list_dir+0xac>
400051b8: b9402841     	ldr	w1, [x2, #0x28]
400051bc: aa1403e0     	mov	x0, x20
400051c0: 97fffa5c     	bl	0x40003b30 <uart_printf>
400051c4: b984baa1     	ldrsw	x1, [x21, #0x4b8]
400051c8: 910006d6     	add	x22, x22, #0x1
400051cc: eb0102df     	cmp	x22, x1
400051d0: 5400018a     	b.ge	0x40005200 <vfs_list_dir+0xd8>
400051d4: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
400051d8: b4ffff62     	cbz	x2, 0x400051c4 <vfs_list_dir+0x9c>
400051dc: b9402048     	ldr	w8, [x2, #0x20]
400051e0: 7100051f     	cmp	w8, #0x1
400051e4: 54fffea1     	b.ne	0x400051b8 <vfs_list_dir+0x90>
400051e8: aa1303e0     	mov	x0, x19
400051ec: aa0203e1     	mov	x1, x2
400051f0: 97fffa50     	bl	0x40003b30 <uart_printf>
400051f4: 17fffff4     	b	0x400051c4 <vfs_list_dir+0x9c>
400051f8: 12800000     	mov	w0, #-0x1               // =-1
400051fc: 14000005     	b	0x40005210 <vfs_list_dir+0xe8>
40005200: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005204: 91264400     	add	x0, x0, #0x991
40005208: 97fffa4a     	bl	0x40003b30 <uart_printf>
4000520c: 2a1f03e0     	mov	w0, wzr
40005210: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005214: f9400bf7     	ldr	x23, [sp, #0x10]
40005218: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000521c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005220: d65f03c0     	ret

0000000040005224 <vfs_load>:
40005224: d65f03c0     	ret

0000000040005228 <pmm_init>:
40005228: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000522c: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005230: d503201f     	nop
40005234: 101a4b74     	adr	x20, 0x40039ba0 <memory_bitmap>
40005238: aa1403e0     	mov	x0, x20
4000523c: 2a1f03e1     	mov	w1, wzr
40005240: 52820002     	mov	w2, #0x1000             // =4096
40005244: 910003fd     	mov	x29, sp
40005248: 97fff5d5     	bl	0x4000299c <memset>
4000524c: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
40005250: d503201f     	nop
40005254: 1022ed68     	adr	x8, 0x4004b000 <__kernel_end>
40005258: f2820009     	movk	x9, #0x1000
4000525c: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
40005260: f2402d1f     	tst	x8, #0xfff
40005264: 8b090109     	add	x9, x8, x9
40005268: 8b0a010a     	add	x10, x8, x10
4000526c: 9a890148     	csel	x8, x10, x9, eq
40005270: d34cfd13     	lsr	x19, x8, #12
40005274: 340001b3     	cbz	w19, 0x400052a8 <pmm_init+0x80>
40005278: 2a1f03e8     	mov	w8, wzr
4000527c: 52800029     	mov	w9, #0x1                // =1
40005280: 2a0803ea     	mov	w10, w8
40005284: 1200090b     	and	w11, w8, #0x7
40005288: 11000508     	add	w8, w8, #0x1
4000528c: d343fd4a     	lsr	x10, x10, #3
40005290: 1acb212b     	lsl	w11, w9, w11
40005294: 6b08027f     	cmp	w19, w8
40005298: 386a6a8c     	ldrb	w12, [x20, x10]
4000529c: 2a0b018b     	orr	w11, w12, w11
400052a0: 382a6a8b     	strb	w11, [x20, x10]
400052a4: 54fffee1     	b.ne	0x40005280 <pmm_init+0x58>
400052a8: 52900008     	mov	w8, #0x8000             // =32768
400052ac: b0000034     	adrp	x20, 0x4000a000 <next_pid>
400052b0: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
400052b4: 4b130108     	sub	w8, w8, w19
400052b8: d503201f     	nop
400052bc: 7001e5a0     	adr	x0, 0x40008f73 <__rodata_start+0x1f73>
400052c0: b9000688     	str	w8, [x20, #0x4]
400052c4: b90ba133     	str	w19, [x9, #0xba0]
400052c8: 97fffa1a     	bl	0x40003b30 <uart_printf>
400052cc: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400052d0: 911fbc00     	add	x0, x0, #0x7ef
400052d4: 52801001     	mov	w1, #0x80               // =128
400052d8: 97fffa16     	bl	0x40003b30 <uart_printf>
400052dc: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400052e0: 910bf400     	add	x0, x0, #0x2fd
400052e4: 2a1303e1     	mov	w1, w19
400052e8: 97fffa12     	bl	0x40003b30 <uart_printf>
400052ec: b9400688     	ldr	w8, [x20, #0x4]
400052f0: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400052f4: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400052f8: 911ad000     	add	x0, x0, #0x6b4
400052fc: 53084d01     	ubfx	w1, w8, #8, #12
40005300: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005304: 17fffa0b     	b	0x40003b30 <uart_printf>

0000000040005308 <pmm_alloc_page>:
40005308: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000530c: b0000028     	adrp	x8, 0x4000a000 <next_pid>
40005310: f9000bf3     	str	x19, [sp, #0x10]
40005314: 910003fd     	mov	x29, sp
40005318: b940050a     	ldr	w10, [x8, #0x4]
4000531c: 3400030a     	cbz	w10, 0x4000537c <pmm_alloc_page+0x74>
40005320: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
40005324: b94ba12b     	ldr	w11, [x9, #0xba0]
40005328: 530f7d6c     	lsr	w12, w11, #15
4000532c: 3500022c     	cbnz	w12, 0x40005370 <pmm_alloc_page+0x68>
40005330: 52a8000c     	mov	w12, #0x40000000        // =1073741824
40005334: d503201f     	nop
40005338: 101a434d     	adr	x13, 0x40039ba0 <memory_bitmap>
4000533c: 0b0b318c     	add	w12, w12, w11, lsl #12
40005340: 5280002e     	mov	w14, #0x1               // =1
40005344: 2a0b03ef     	mov	w15, w11
40005348: 12000971     	and	w17, w11, #0x7
4000534c: d343fdef     	lsr	x15, x15, #3
40005350: 1ad121d1     	lsl	w17, w14, w17
40005354: 386f69b0     	ldrb	w16, [x13, x15]
40005358: 6a10023f     	tst	w17, w16
4000535c: 540001e0     	b.eq	0x40005398 <pmm_alloc_page+0x90>
40005360: 1100056b     	add	w11, w11, #0x1
40005364: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
40005368: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
4000536c: 54fffec1     	b.ne	0x40005344 <pmm_alloc_page+0x3c>
40005370: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40005374: 910c5c00     	add	x0, x0, #0x317
40005378: 14000003     	b	0x40005384 <pmm_alloc_page+0x7c>
4000537c: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005380: 911b2c00     	add	x0, x0, #0x6cb
40005384: 97fff8d6     	bl	0x400036dc <uart_puts>
40005388: aa1f03e0     	mov	x0, xzr
4000538c: f9400bf3     	ldr	x19, [sp, #0x10]
40005390: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005394: d65f03c0     	ret
40005398: 2a0c03f3     	mov	w19, w12
4000539c: 5100054a     	sub	w10, w10, #0x1
400053a0: 1100056b     	add	w11, w11, #0x1
400053a4: aa1303e0     	mov	x0, x19
400053a8: 2a1f03e1     	mov	w1, wzr
400053ac: 52820002     	mov	w2, #0x1000             // =4096
400053b0: 2a11020e     	orr	w14, w16, w17
400053b4: 382f69ae     	strb	w14, [x13, x15]
400053b8: b900050a     	str	w10, [x8, #0x4]
400053bc: b90ba12b     	str	w11, [x9, #0xba0]
400053c0: 97fff577     	bl	0x4000299c <memset>
400053c4: aa1303e0     	mov	x0, x19
400053c8: 17fffff1     	b	0x4000538c <pmm_alloc_page+0x84>

00000000400053cc <pmm_free_page>:
400053cc: d35efc08     	lsr	x8, x0, #30
400053d0: b4000128     	cbz	x8, 0x400053f4 <pmm_free_page+0x28>
400053d4: d35bfc08     	lsr	x8, x0, #27
400053d8: f100251f     	cmp	x8, #0x9
400053dc: 540000c2     	b.hs	0x400053f4 <pmm_free_page+0x28>
400053e0: f2402c1f     	tst	x0, #0xfff
400053e4: 540000e0     	b.eq	0x40005400 <pmm_free_page+0x34>
400053e8: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400053ec: 91218000     	add	x0, x0, #0x860
400053f0: 17fff8bb     	b	0x400036dc <uart_puts>
400053f4: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400053f8: 91043800     	add	x0, x0, #0x10e
400053fc: 17fff8b8     	b	0x400036dc <uart_puts>
40005400: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
40005404: d503201f     	nop
40005408: 101a3cca     	adr	x10, 0x40039ba0 <memory_bitmap>
4000540c: 8b080009     	add	x9, x0, x8
40005410: 5280002d     	mov	w13, #0x1               // =1
40005414: d34fad28     	ubfx	x8, x9, #15, #29
40005418: d34c392c     	ubfx	x12, x9, #12, #3
4000541c: 3868694b     	ldrb	w11, [x10, x8]
40005420: 1acc21ac     	lsl	w12, w13, w12
40005424: 6a0b019f     	tst	w12, w11
40005428: 540001c0     	b.eq	0x40005460 <pmm_free_page+0x94>
4000542c: b000002e     	adrp	x14, 0x4000a000 <next_pid>
40005430: b00001ad     	adrp	x13, 0x4003a000 <memory_bitmap+0x460>
40005434: d34cfd29     	lsr	x9, x9, #12
40005438: b94005cf     	ldr	w15, [x14, #0x4]
4000543c: b94ba1b0     	ldr	w16, [x13, #0xba0]
40005440: 0a2c016b     	bic	w11, w11, w12
40005444: 3828694b     	strb	w11, [x10, x8]
40005448: 110005e8     	add	w8, w15, #0x1
4000544c: 6b09021f     	cmp	w16, w9
40005450: b90005c8     	str	w8, [x14, #0x4]
40005454: 54000049     	b.ls	0x4000545c <pmm_free_page+0x90>
40005458: b90ba1a9     	str	w9, [x13, #0xba0]
4000545c: d65f03c0     	ret
40005460: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005464: 912a3000     	add	x0, x0, #0xa8c
40005468: 17fff89d     	b	0x400036dc <uart_puts>

000000004000546c <pmm_get_free_memory>:
4000546c: b0000028     	adrp	x8, 0x4000a000 <next_pid>
40005470: b9400508     	ldr	w8, [x8, #0x4]
40005474: 53144d00     	lsl	w0, w8, #12
40005478: d65f03c0     	ret

000000004000547c <sched_init>:
4000547c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005480: 912ec108     	add	x8, x8, #0xbb0
40005484: d2c00029     	mov	x9, #0x100000000        // =4294967296
40005488: f9001109     	str	x9, [x8, #0x20]
4000548c: d2c00049     	mov	x9, #0x200000000        // =8589934592
40005490: d503201f     	nop
40005494: 30013420     	adr	x0, 0x40007b19 <__rodata_start+0xb19>
40005498: f9001d09     	str	x9, [x8, #0x38]
4000549c: d2c00069     	mov	x9, #0x300000000        // =12884901888
400054a0: f9002909     	str	x9, [x8, #0x50]
400054a4: d2c00089     	mov	x9, #0x400000000        // =17179869184
400054a8: f9003509     	str	x9, [x8, #0x68]
400054ac: d2c000a9     	mov	x9, #0x500000000        // =21474836480
400054b0: f9004109     	str	x9, [x8, #0x80]
400054b4: d2c000c9     	mov	x9, #0x600000000        // =25769803776
400054b8: f9004d09     	str	x9, [x8, #0x98]
400054bc: d2c000e9     	mov	x9, #0x700000000        // =30064771072
400054c0: f9005909     	str	x9, [x8, #0xb0]
400054c4: d2c00109     	mov	x9, #0x800000000        // =34359738368
400054c8: f9006509     	str	x9, [x8, #0xc8]
400054cc: d2c00129     	mov	x9, #0x900000000        // =38654705664
400054d0: f9007109     	str	x9, [x8, #0xe0]
400054d4: d2c00149     	mov	x9, #0xa00000000        // =42949672960
400054d8: f9007d09     	str	x9, [x8, #0xf8]
400054dc: d2c00169     	mov	x9, #0xb00000000        // =47244640256
400054e0: f9008909     	str	x9, [x8, #0x110]
400054e4: d2c00189     	mov	x9, #0xc00000000        // =51539607552
400054e8: f9009509     	str	x9, [x8, #0x128]
400054ec: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
400054f0: f900a109     	str	x9, [x8, #0x140]
400054f4: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
400054f8: f900ad09     	str	x9, [x8, #0x158]
400054fc: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
40005500: f900b909     	str	x9, [x8, #0x170]
40005504: 52800049     	mov	w9, #0x2                // =2
40005508: a900251f     	stp	xzr, x9, [x8]
4000550c: b0000028     	adrp	x8, 0x4000a000 <next_pid>
40005510: b900091f     	str	wzr, [x8, #0x8]
40005514: 17fff872     	b	0x400036dc <uart_puts>

0000000040005518 <sched_create_task>:
40005518: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000551c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005520: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005524: aa0003f3     	mov	x19, x0
40005528: b94bd108     	ldr	w8, [x8, #0xbd0]
4000552c: f9000bf7     	str	x23, [sp, #0x10]
40005530: 910003fd     	mov	x29, sp
40005534: a90257f6     	stp	x22, x21, [sp, #0x20]
40005538: 340005c8     	cbz	w8, 0x400055f0 <sched_create_task+0xd8>
4000553c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005540: b94be908     	ldr	w8, [x8, #0xbe8]
40005544: 340005a8     	cbz	w8, 0x400055f8 <sched_create_task+0xe0>
40005548: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
4000554c: b94c0108     	ldr	w8, [x8, #0xc00]
40005550: 34000588     	cbz	w8, 0x40005600 <sched_create_task+0xe8>
40005554: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005558: b94c1908     	ldr	w8, [x8, #0xc18]
4000555c: 34000568     	cbz	w8, 0x40005608 <sched_create_task+0xf0>
40005560: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005564: b94c3108     	ldr	w8, [x8, #0xc30]
40005568: 34000548     	cbz	w8, 0x40005610 <sched_create_task+0xf8>
4000556c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005570: b94c4908     	ldr	w8, [x8, #0xc48]
40005574: 34000528     	cbz	w8, 0x40005618 <sched_create_task+0x100>
40005578: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
4000557c: b94c6108     	ldr	w8, [x8, #0xc60]
40005580: 34000508     	cbz	w8, 0x40005620 <sched_create_task+0x108>
40005584: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005588: b94c7908     	ldr	w8, [x8, #0xc78]
4000558c: 340004e8     	cbz	w8, 0x40005628 <sched_create_task+0x110>
40005590: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005594: b94c9108     	ldr	w8, [x8, #0xc90]
40005598: 340004c8     	cbz	w8, 0x40005630 <sched_create_task+0x118>
4000559c: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055a0: b94ca908     	ldr	w8, [x8, #0xca8]
400055a4: 340004a8     	cbz	w8, 0x40005638 <sched_create_task+0x120>
400055a8: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055ac: b94cc108     	ldr	w8, [x8, #0xcc0]
400055b0: 34000488     	cbz	w8, 0x40005640 <sched_create_task+0x128>
400055b4: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055b8: b94cd908     	ldr	w8, [x8, #0xcd8]
400055bc: 34000468     	cbz	w8, 0x40005648 <sched_create_task+0x130>
400055c0: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055c4: b94cf108     	ldr	w8, [x8, #0xcf0]
400055c8: 34000448     	cbz	w8, 0x40005650 <sched_create_task+0x138>
400055cc: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055d0: b94d0908     	ldr	w8, [x8, #0xd08]
400055d4: 34000428     	cbz	w8, 0x40005658 <sched_create_task+0x140>
400055d8: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400055dc: b94d2108     	ldr	w8, [x8, #0xd20]
400055e0: 34000408     	cbz	w8, 0x40005660 <sched_create_task+0x148>
400055e4: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400055e8: 91039400     	add	x0, x0, #0xe5
400055ec: 1400003c     	b	0x400056dc <sched_create_task+0x1c4>
400055f0: 52800034     	mov	w20, #0x1               // =1
400055f4: 1400001c     	b	0x40005664 <sched_create_task+0x14c>
400055f8: 52800054     	mov	w20, #0x2               // =2
400055fc: 1400001a     	b	0x40005664 <sched_create_task+0x14c>
40005600: 52800074     	mov	w20, #0x3               // =3
40005604: 14000018     	b	0x40005664 <sched_create_task+0x14c>
40005608: 52800094     	mov	w20, #0x4               // =4
4000560c: 14000016     	b	0x40005664 <sched_create_task+0x14c>
40005610: 528000b4     	mov	w20, #0x5               // =5
40005614: 14000014     	b	0x40005664 <sched_create_task+0x14c>
40005618: 528000d4     	mov	w20, #0x6               // =6
4000561c: 14000012     	b	0x40005664 <sched_create_task+0x14c>
40005620: 528000f4     	mov	w20, #0x7               // =7
40005624: 14000010     	b	0x40005664 <sched_create_task+0x14c>
40005628: 52800114     	mov	w20, #0x8               // =8
4000562c: 1400000e     	b	0x40005664 <sched_create_task+0x14c>
40005630: 52800134     	mov	w20, #0x9               // =9
40005634: 1400000c     	b	0x40005664 <sched_create_task+0x14c>
40005638: 52800154     	mov	w20, #0xa               // =10
4000563c: 1400000a     	b	0x40005664 <sched_create_task+0x14c>
40005640: 52800174     	mov	w20, #0xb               // =11
40005644: 14000008     	b	0x40005664 <sched_create_task+0x14c>
40005648: 52800194     	mov	w20, #0xc               // =12
4000564c: 14000006     	b	0x40005664 <sched_create_task+0x14c>
40005650: 528001b4     	mov	w20, #0xd               // =13
40005654: 14000004     	b	0x40005664 <sched_create_task+0x14c>
40005658: 528001d4     	mov	w20, #0xe               // =14
4000565c: 14000002     	b	0x40005664 <sched_create_task+0x14c>
40005660: 528001f4     	mov	w20, #0xf               // =15
40005664: 97ffff29     	bl	0x40005308 <pmm_alloc_page>
40005668: b4000360     	cbz	x0, 0x400056d4 <sched_create_task+0x1bc>
4000566c: 52800308     	mov	w8, #0x18               // =24
40005670: d503201f     	nop
40005674: 101aa9a9     	adr	x9, 0x4003aba8 <tasks>
40005678: 9ba82696     	umaddl	x22, w20, w8, x9
4000567c: 913bc015     	add	x21, x0, #0xef0
40005680: aa0003f7     	mov	x23, x0
40005684: 2a1f03e1     	mov	w1, wzr
40005688: 52802202     	mov	w2, #0x110              // =272
4000568c: f90006c0     	str	x0, [x22, #0x8]
40005690: aa1503e0     	mov	x0, x21
40005694: 97fff4c2     	bl	0x4000299c <memset>
40005698: 52800029     	mov	w9, #0x1                // =1
4000569c: f907f6f3     	str	x19, [x23, #0xfe8]
400056a0: 528000a8     	mov	w8, #0x5                // =5
400056a4: f90002d5     	str	x21, [x22]
400056a8: 2a1403e1     	mov	w1, w20
400056ac: 2a1303e2     	mov	w2, w19
400056b0: b90012c9     	str	w9, [x22, #0x10]
400056b4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400056b8: a94257f6     	ldp	x22, x21, [sp, #0x20]
400056bc: f907fae8     	str	x8, [x23, #0xff0]
400056c0: f9400bf7     	ldr	x23, [sp, #0x10]
400056c4: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400056c8: 911bb800     	add	x0, x0, #0x6ee
400056cc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400056d0: 17fff918     	b	0x40003b30 <uart_printf>
400056d4: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400056d8: 91154c00     	add	x0, x0, #0x553
400056dc: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400056e0: f9400bf7     	ldr	x23, [sp, #0x10]
400056e4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400056e8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400056ec: 17fff7fc     	b	0x400036dc <uart_puts>

00000000400056f0 <sched_switch>:
400056f0: b0000028     	adrp	x8, 0x4000a000 <next_pid>
400056f4: b940090b     	ldr	w11, [x8, #0x8]
400056f8: 3100057f     	cmn	w11, #0x1
400056fc: 54000300     	b.eq	0x4000575c <sched_switch+0x6c>
40005700: 5280030a     	mov	w10, #0x18              // =24
40005704: d503201f     	nop
40005708: 101aa509     	adr	x9, 0x4003aba8 <tasks>
4000570c: 9b2a256c     	smaddl	x12, w11, w10, x9
40005710: 9b2a7d6d     	smull	x13, w11, w10
40005714: b8410d8e     	ldr	w14, [x12, #0x10]!
40005718: f82d6920     	str	x0, [x9, x13]
4000571c: 710009df     	cmp	w14, #0x2
40005720: 54000061     	b.ne	0x4000572c <sched_switch+0x3c>
40005724: 5280002d     	mov	w13, #0x1               // =1
40005728: b900018d     	str	w13, [x12]
4000572c: 5280020c     	mov	w12, #0x10              // =16
40005730: 1100056b     	add	w11, w11, #0x1
40005734: 6b0b03ed     	negs	w13, w11
40005738: 12000d6b     	and	w11, w11, #0xf
4000573c: 12000dad     	and	w13, w13, #0xf
40005740: 5a8d456b     	csneg	w11, w11, w13, mi
40005744: 9b2a256d     	smaddl	x13, w11, w10, x9
40005748: b8410dae     	ldr	w14, [x13, #0x10]!
4000574c: 710005df     	cmp	w14, #0x1
40005750: 54000080     	b.eq	0x40005760 <sched_switch+0x70>
40005754: 7100058c     	subs	w12, w12, #0x1
40005758: 54fffec1     	b.ne	0x40005730 <sched_switch+0x40>
4000575c: d65f03c0     	ret
40005760: 5280030a     	mov	w10, #0x18              // =24
40005764: b900090b     	str	w11, [x8, #0x8]
40005768: 52800048     	mov	w8, #0x2                // =2
4000576c: 9b2a7d6a     	smull	x10, w11, w10
40005770: b90001a8     	str	w8, [x13]
40005774: f86a6920     	ldr	x0, [x9, x10]
40005778: d65f03c0     	ret

000000004000577c <virtio_blk_init>:
4000577c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005780: 528d2ec9     	mov	w9, #0x6976             // =26998
40005784: 52a14001     	mov	w1, #0xa000000          // =167772160
40005788: 52800408     	mov	w8, #0x20               // =32
4000578c: 72ae8e49     	movk	w9, #0x7472, lsl #16
40005790: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005794: 910003fd     	mov	x29, sp
40005798: 14000004     	b	0x400057a8 <virtio_blk_init+0x2c>
4000579c: f1000508     	subs	x8, x8, #0x1
400057a0: 91080021     	add	x1, x1, #0x200
400057a4: 540001a0     	b.eq	0x400057d8 <virtio_blk_init+0x5c>
400057a8: b940002a     	ldr	w10, [x1]
400057ac: 6b09015f     	cmp	w10, w9
400057b0: 54ffff61     	b.ne	0x4000579c <virtio_blk_init+0x20>
400057b4: b9400422     	ldr	w2, [x1, #0x4]
400057b8: b940082a     	ldr	w10, [x1, #0x8]
400057bc: 7100095f     	cmp	w10, #0x2
400057c0: 54fffee1     	b.ne	0x4000579c <virtio_blk_init+0x20>
400057c4: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400057c8: d503201f     	nop
400057cc: 5001aba0     	adr	x0, 0x40008d42 <__rodata_start+0x1d42>
400057d0: f9069501     	str	x1, [x8, #0xd28]
400057d4: 97fff8d7     	bl	0x40003b30 <uart_printf>
400057d8: b00001b4     	adrp	x20, 0x4003a000 <memory_bitmap+0x460>
400057dc: f9469688     	ldr	x8, [x20, #0xd28]
400057e0: b40004a8     	cbz	x8, 0x40005874 <virtio_blk_init+0xf8>
400057e4: 52800029     	mov	w9, #0x1                // =1
400057e8: 5280006a     	mov	w10, #0x3               // =3
400057ec: b900711f     	str	wzr, [x8, #0x70]
400057f0: b9007109     	str	w9, [x8, #0x70]
400057f4: b900710a     	str	w10, [x8, #0x70]
400057f8: b900211f     	str	wzr, [x8, #0x20]
400057fc: b900311f     	str	wzr, [x8, #0x30]
40005800: b9403509     	ldr	w9, [x8, #0x34]
40005804: 34000409     	cbz	w9, 0x40005884 <virtio_blk_init+0x108>
40005808: 52800209     	mov	w9, #0x10               // =16
4000580c: b9003909     	str	w9, [x8, #0x38]
40005810: 97fffebe     	bl	0x40005308 <pmm_alloc_page>
40005814: aa0003f3     	mov	x19, x0
40005818: 97fffebc     	bl	0x40005308 <pmm_alloc_page>
4000581c: b40003d3     	cbz	x19, 0x40005894 <virtio_blk_init+0x118>
40005820: f9469688     	ldr	x8, [x20, #0xd28]
40005824: 52820009     	mov	w9, #0x1000             // =4096
40005828: 9104026a     	add	x10, x19, #0x100
4000582c: d34cfe6b     	lsr	x11, x19, #12
40005830: 90000020     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40005834: 9111e400     	add	x0, x0, #0x479
40005838: b9002909     	str	w9, [x8, #0x28]
4000583c: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
40005840: f9069d2a     	str	x10, [x9, #0xd38]
40005844: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
40005848: 528224aa     	mov	w10, #0x1125            // =4389
4000584c: f9069933     	str	x19, [x9, #0xd30]
40005850: 8b0a0269     	add	x9, x19, x10
40005854: b00001aa     	adrp	x10, 0x4003a000 <memory_bitmap+0x460>
40005858: 9274cd29     	and	x9, x9, #0xfffffffffffff000
4000585c: 52800033     	mov	w19, #0x1               // =1
40005860: f906a149     	str	x9, [x10, #0xd40]
40005864: 528000e9     	mov	w9, #0x7                // =7
40005868: b900410b     	str	w11, [x8, #0x40]
4000586c: b9007109     	str	w9, [x8, #0x70]
40005870: 14000008     	b	0x40005890 <virtio_blk_init+0x114>
40005874: 2a1f03f3     	mov	w19, wzr
40005878: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000587c: 91162800     	add	x0, x0, #0x58a
40005880: 14000004     	b	0x40005890 <virtio_blk_init+0x114>
40005884: 2a1f03f3     	mov	w19, wzr
40005888: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000588c: 912ab000     	add	x0, x0, #0xaac
40005890: 97fff793     	bl	0x400036dc <uart_puts>
40005894: 2a1303e0     	mov	w0, w19
40005898: a9414ff4     	ldp	x20, x19, [sp, #0x10]
4000589c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400058a0: d65f03c0     	ret

00000000400058a4 <virtio_blk_read_sector>:
400058a4: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
400058a8: f9469509     	ldr	x9, [x8, #0xd28]
400058ac: b4001309     	cbz	x9, 0x40005b0c <virtio_blk_read_sector+0x268>
400058b0: d10083ff     	sub	sp, sp, #0x20
400058b4: d360fc09     	lsr	x9, x0, #32
400058b8: b00001ab     	adrp	x11, 0x4003a000 <memory_bitmap+0x460>
400058bc: 9135216b     	add	x11, x11, #0xd48
400058c0: b00001aa     	adrp	x10, 0x4003a000 <memory_bitmap+0x460>
400058c4: 9135614a     	add	x10, x10, #0xd58
400058c8: a9017bfd     	stp	x29, x30, [sp, #0x10]
400058cc: 29012560     	stp	w0, w9, [x11, #0x8]
400058d0: 52801fe9     	mov	w9, #0xff               // =255
400058d4: d358fd6d     	lsr	x13, x11, #24
400058d8: 29007d7f     	stp	wzr, wzr, [x11]
400058dc: d348fc2e     	lsr	x14, x1, #8
400058e0: d368fd6c     	lsr	x12, x11, #40
400058e4: 39000149     	strb	w9, [x10]
400058e8: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
400058ec: d348fd4f     	lsr	x15, x10, #8
400058f0: f9469929     	ldr	x9, [x9, #0xd30]
400058f4: 910043fd     	add	x29, sp, #0x10
400058f8: 39000d2d     	strb	w13, [x9, #0x3]
400058fc: d348fd6d     	lsr	x13, x11, #8
40005900: 3900452e     	strb	w14, [x9, #0x11]
40005904: 5280006e     	mov	w14, #0x3               // =3
40005908: 3900052d     	strb	w13, [x9, #0x1]
4000590c: d368fc2d     	lsr	x13, x1, #40
40005910: 3900712e     	strb	w14, [x9, #0x1c]
40005914: d368fd4e     	lsr	x14, x10, #40
40005918: 3900552d     	strb	w13, [x9, #0x15]
4000591c: 5280004d     	mov	w13, #0x2               // =2
40005920: 3900012b     	strb	w11, [x9]
40005924: 3900152c     	strb	w12, [x9, #0x5]
40005928: d350fd6c     	lsr	x12, x11, #16
4000592c: 3900652d     	strb	w13, [x9, #0x19]
40005930: 3900792d     	strb	w13, [x9, #0x1e]
40005934: 3900852f     	strb	w15, [x9, #0x21]
40005938: d378fd6f     	lsr	x15, x11, #56
4000593c: 3900b12d     	strb	w13, [x9, #0x2c]
40005940: d360fd6d     	lsr	x13, x11, #32
40005944: d370fd6b     	lsr	x11, x11, #48
40005948: 3900952e     	strb	w14, [x9, #0x25]
4000594c: aa0903ee     	mov	x14, x9
40005950: 38004dcd     	strb	w13, [x14, #0x4]!
40005954: aa0903ed     	mov	x13, x9
40005958: 390009cb     	strb	w11, [x14, #0x2]
4000595c: 5280020b     	mov	w11, #0x10              // =16
40005960: 38008dab     	strb	w11, [x13, #0x8]!
40005964: aa0903eb     	mov	x11, x9
40005968: 39000dbf     	strb	wzr, [x13, #0x3]
4000596c: 390009bf     	strb	wzr, [x13, #0x2]
40005970: d358fc2d     	lsr	x13, x1, #24
40005974: 39000dcf     	strb	w15, [x14, #0x3]
40005978: d350fc2e     	lsr	x14, x1, #16
4000597c: aa0903ef     	mov	x15, x9
40005980: 38010d61     	strb	w1, [x11, #0x10]!
40005984: 39000d6d     	strb	w13, [x11, #0x3]
40005988: d360fc2d     	lsr	x13, x1, #32
4000598c: 3900096e     	strb	w14, [x11, #0x2]
40005990: d378fc2e     	lsr	x14, x1, #56
40005994: 38004d6d     	strb	w13, [x11, #0x4]!
40005998: d370fc2d     	lsr	x13, x1, #48
4000599c: 39000d6e     	strb	w14, [x11, #0x3]
400059a0: aa0903ee     	mov	x14, x9
400059a4: 3900096d     	strb	w13, [x11, #0x2]
400059a8: d358fd4b     	lsr	x11, x10, #24
400059ac: d350fd4d     	lsr	x13, x10, #16
400059b0: 38020dca     	strb	w10, [x14, #0x20]!
400059b4: 39000dcb     	strb	w11, [x14, #0x3]
400059b8: d360fd4b     	lsr	x11, x10, #32
400059bc: 390009cd     	strb	w13, [x14, #0x2]
400059c0: 38004dcb     	strb	w11, [x14, #0x4]!
400059c4: d378fd4b     	lsr	x11, x10, #56
400059c8: d370fd4a     	lsr	x10, x10, #48
400059cc: 3900092c     	strb	w12, [x9, #0x2]
400059d0: 5280002c     	mov	w12, #0x1               // =1
400059d4: 39000dcb     	strb	w11, [x14, #0x3]
400059d8: b00001ab     	adrp	x11, 0x4003a000 <memory_bitmap+0x460>
400059dc: 390009ca     	strb	w10, [x14, #0x2]
400059e0: b00001aa     	adrp	x10, 0x4003a000 <memory_bitmap+0x460>
400059e4: 795ab96d     	ldrh	w13, [x11, #0xd5c]
400059e8: f9469d4e     	ldr	x14, [x10, #0xd38]
400059ec: 3900253f     	strb	wzr, [x9, #0x9]
400059f0: 92400dad     	and	x13, x13, #0xf
400059f4: 3900353f     	strb	wzr, [x9, #0xd]
400059f8: 3900312c     	strb	w12, [x9, #0xc]
400059fc: 39003d3f     	strb	wzr, [x9, #0xf]
40005a00: 3900392c     	strb	w12, [x9, #0xe]
40005a04: 3900753f     	strb	wzr, [x9, #0x1d]
40005a08: 39007d3f     	strb	wzr, [x9, #0x1f]
40005a0c: 3900a53f     	strb	wzr, [x9, #0x29]
40005a10: 3900b53f     	strb	wzr, [x9, #0x2d]
40005a14: 3900bd3f     	strb	wzr, [x9, #0x2f]
40005a18: 3900b93f     	strb	wzr, [x9, #0x2e]
40005a1c: 38028d2c     	strb	w12, [x9, #0x28]!
40005a20: 8b0d05cc     	add	x12, x14, x13, lsl #1
40005a24: 38018dff     	strb	wzr, [x15, #0x18]!
40005a28: 39000dff     	strb	wzr, [x15, #0x3]
40005a2c: 390009ff     	strb	wzr, [x15, #0x2]
40005a30: 39000d3f     	strb	wzr, [x9, #0x3]
40005a34: 3900093f     	strb	wzr, [x9, #0x2]
40005a38: 3900159f     	strb	wzr, [x12, #0x5]
40005a3c: 3900119f     	strb	wzr, [x12, #0x4]
40005a40: d5033fbf     	dmb	sy
40005a44: 795ab969     	ldrh	w9, [x11, #0xd5c]
40005a48: f9469d4a     	ldr	x10, [x10, #0xd38]
40005a4c: 11000529     	add	w9, w9, #0x1
40005a50: 53087d2c     	lsr	w12, w9, #8
40005a54: 791ab969     	strh	w9, [x11, #0xd5c]
40005a58: 39000949     	strb	w9, [x10, #0x2]
40005a5c: b00001a9     	adrp	x9, 0x4003a000 <memory_bitmap+0x460>
40005a60: 39000d4c     	strb	w12, [x10, #0x3]
40005a64: d5033fbf     	dmb	sy
40005a68: f9469508     	ldr	x8, [x8, #0xd28]
40005a6c: b900511f     	str	wzr, [x8, #0x50]
40005a70: f946a128     	ldr	x8, [x9, #0xd40]
40005a74: aa0803e9     	mov	x9, x8
40005a78: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005a7c: 3940052b     	ldrb	w11, [x9, #0x1]
40005a80: 3940052c     	ldrb	w12, [x9, #0x1]
40005a84: 3940012d     	ldrb	w13, [x9]
40005a88: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005a8c: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005a90: 6b09015f     	cmp	w10, w9
40005a94: 540002a1     	b.ne	0x40005ae8 <virtio_blk_read_sector+0x244>
40005a98: 5292d00a     	mov	w10, #0x9680            // =38528
40005a9c: 72a0130a     	movk	w10, #0x98, lsl #16
40005aa0: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005aa4: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005aa8: 71018d7f     	cmp	w11, #0x63
40005aac: 540000ec     	b.gt	0x40005ac8 <virtio_blk_read_sector+0x224>
40005ab0: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005ab4: 1100056b     	add	w11, w11, #0x1
40005ab8: b81fc3ab     	stur	w11, [x29, #-0x4]
40005abc: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005ac0: 7101917f     	cmp	w11, #0x64
40005ac4: 54ffff6b     	b.lt	0x40005ab0 <virtio_blk_read_sector+0x20c>
40005ac8: 39400d0b     	ldrb	w11, [x8, #0x3]
40005acc: 3940090c     	ldrb	w12, [x8, #0x2]
40005ad0: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005ad4: 6b09017f     	cmp	w11, w9
40005ad8: 54000081     	b.ne	0x40005ae8 <virtio_blk_read_sector+0x244>
40005adc: 7100055f     	cmp	w10, #0x1
40005ae0: 5100054a     	sub	w10, w10, #0x1
40005ae4: 54fffde8     	b.hi	0x40005aa0 <virtio_blk_read_sector+0x1fc>
40005ae8: b00001a8     	adrp	x8, 0x4003a000 <memory_bitmap+0x460>
40005aec: 39756109     	ldrb	w9, [x8, #0xd58]
40005af0: 34000129     	cbz	w9, 0x40005b14 <virtio_blk_read_sector+0x270>
40005af4: 39756101     	ldrb	w1, [x8, #0xd58]
40005af8: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005afc: 913e7400     	add	x0, x0, #0xf9d
40005b00: 97fff80c     	bl	0x40003b30 <uart_printf>
40005b04: 2a1f03e0     	mov	w0, wzr
40005b08: 14000004     	b	0x40005b18 <virtio_blk_read_sector+0x274>
40005b0c: 2a1f03e0     	mov	w0, wzr
40005b10: d65f03c0     	ret
40005b14: 52800020     	mov	w0, #0x1                // =1
40005b18: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005b1c: 910083ff     	add	sp, sp, #0x20
40005b20: d65f03c0     	ret
		...

0000000040006000 <exception_vector_table>:
40006000: 140001e1     	b	0x40006784 <handle_sync_invalid>
40006004: d503201f     	nop
40006008: d503201f     	nop
4000600c: d503201f     	nop
40006010: d503201f     	nop
40006014: d503201f     	nop
40006018: d503201f     	nop
4000601c: d503201f     	nop
40006020: d503201f     	nop
40006024: d503201f     	nop
40006028: d503201f     	nop
4000602c: d503201f     	nop
40006030: d503201f     	nop
40006034: d503201f     	nop
40006038: d503201f     	nop
4000603c: d503201f     	nop
40006040: d503201f     	nop
40006044: d503201f     	nop
40006048: d503201f     	nop
4000604c: d503201f     	nop
40006050: d503201f     	nop
40006054: d503201f     	nop
40006058: d503201f     	nop
4000605c: d503201f     	nop
40006060: d503201f     	nop
40006064: d503201f     	nop
40006068: d503201f     	nop
4000606c: d503201f     	nop
40006070: d503201f     	nop
40006074: d503201f     	nop
40006078: d503201f     	nop
4000607c: d503201f     	nop

0000000040006080 <curr_el_sp0_irq>:
40006080: 140001ed     	b	0x40006834 <handle_irq_invalid>
40006084: d503201f     	nop
40006088: d503201f     	nop
4000608c: d503201f     	nop
40006090: d503201f     	nop
40006094: d503201f     	nop
40006098: d503201f     	nop
4000609c: d503201f     	nop
400060a0: d503201f     	nop
400060a4: d503201f     	nop
400060a8: d503201f     	nop
400060ac: d503201f     	nop
400060b0: d503201f     	nop
400060b4: d503201f     	nop
400060b8: d503201f     	nop
400060bc: d503201f     	nop
400060c0: d503201f     	nop
400060c4: d503201f     	nop
400060c8: d503201f     	nop
400060cc: d503201f     	nop
400060d0: d503201f     	nop
400060d4: d503201f     	nop
400060d8: d503201f     	nop
400060dc: d503201f     	nop
400060e0: d503201f     	nop
400060e4: d503201f     	nop
400060e8: d503201f     	nop
400060ec: d503201f     	nop
400060f0: d503201f     	nop
400060f4: d503201f     	nop
400060f8: d503201f     	nop
400060fc: d503201f     	nop

0000000040006100 <curr_el_sp0_fiq>:
40006100: 140001f8     	b	0x400068e0 <handle_fiq_invalid>
40006104: d503201f     	nop
40006108: d503201f     	nop
4000610c: d503201f     	nop
40006110: d503201f     	nop
40006114: d503201f     	nop
40006118: d503201f     	nop
4000611c: d503201f     	nop
40006120: d503201f     	nop
40006124: d503201f     	nop
40006128: d503201f     	nop
4000612c: d503201f     	nop
40006130: d503201f     	nop
40006134: d503201f     	nop
40006138: d503201f     	nop
4000613c: d503201f     	nop
40006140: d503201f     	nop
40006144: d503201f     	nop
40006148: d503201f     	nop
4000614c: d503201f     	nop
40006150: d503201f     	nop
40006154: d503201f     	nop
40006158: d503201f     	nop
4000615c: d503201f     	nop
40006160: d503201f     	nop
40006164: d503201f     	nop
40006168: d503201f     	nop
4000616c: d503201f     	nop
40006170: d503201f     	nop
40006174: d503201f     	nop
40006178: d503201f     	nop
4000617c: d503201f     	nop

0000000040006180 <curr_el_sp0_serror>:
40006180: 14000203     	b	0x4000698c <handle_serror_invalid>
40006184: d503201f     	nop
40006188: d503201f     	nop
4000618c: d503201f     	nop
40006190: d503201f     	nop
40006194: d503201f     	nop
40006198: d503201f     	nop
4000619c: d503201f     	nop
400061a0: d503201f     	nop
400061a4: d503201f     	nop
400061a8: d503201f     	nop
400061ac: d503201f     	nop
400061b0: d503201f     	nop
400061b4: d503201f     	nop
400061b8: d503201f     	nop
400061bc: d503201f     	nop
400061c0: d503201f     	nop
400061c4: d503201f     	nop
400061c8: d503201f     	nop
400061cc: d503201f     	nop
400061d0: d503201f     	nop
400061d4: d503201f     	nop
400061d8: d503201f     	nop
400061dc: d503201f     	nop
400061e0: d503201f     	nop
400061e4: d503201f     	nop
400061e8: d503201f     	nop
400061ec: d503201f     	nop
400061f0: d503201f     	nop
400061f4: d503201f     	nop
400061f8: d503201f     	nop
400061fc: d503201f     	nop

0000000040006200 <curr_el_spx_sync>:
40006200: 14000210     	b	0x40006a40 <handle_sync_exception_asm>
40006204: d503201f     	nop
40006208: d503201f     	nop
4000620c: d503201f     	nop
40006210: d503201f     	nop
40006214: d503201f     	nop
40006218: d503201f     	nop
4000621c: d503201f     	nop
40006220: d503201f     	nop
40006224: d503201f     	nop
40006228: d503201f     	nop
4000622c: d503201f     	nop
40006230: d503201f     	nop
40006234: d503201f     	nop
40006238: d503201f     	nop
4000623c: d503201f     	nop
40006240: d503201f     	nop
40006244: d503201f     	nop
40006248: d503201f     	nop
4000624c: d503201f     	nop
40006250: d503201f     	nop
40006254: d503201f     	nop
40006258: d503201f     	nop
4000625c: d503201f     	nop
40006260: d503201f     	nop
40006264: d503201f     	nop
40006268: d503201f     	nop
4000626c: d503201f     	nop
40006270: d503201f     	nop
40006274: d503201f     	nop
40006278: d503201f     	nop
4000627c: d503201f     	nop

0000000040006280 <curr_el_spx_irq>:
40006280: 1400021d     	b	0x40006af4 <handle_irq_exception_asm>
40006284: d503201f     	nop
40006288: d503201f     	nop
4000628c: d503201f     	nop
40006290: d503201f     	nop
40006294: d503201f     	nop
40006298: d503201f     	nop
4000629c: d503201f     	nop
400062a0: d503201f     	nop
400062a4: d503201f     	nop
400062a8: d503201f     	nop
400062ac: d503201f     	nop
400062b0: d503201f     	nop
400062b4: d503201f     	nop
400062b8: d503201f     	nop
400062bc: d503201f     	nop
400062c0: d503201f     	nop
400062c4: d503201f     	nop
400062c8: d503201f     	nop
400062cc: d503201f     	nop
400062d0: d503201f     	nop
400062d4: d503201f     	nop
400062d8: d503201f     	nop
400062dc: d503201f     	nop
400062e0: d503201f     	nop
400062e4: d503201f     	nop
400062e8: d503201f     	nop
400062ec: d503201f     	nop
400062f0: d503201f     	nop
400062f4: d503201f     	nop
400062f8: d503201f     	nop
400062fc: d503201f     	nop

0000000040006300 <curr_el_spx_fiq>:
40006300: 14000178     	b	0x400068e0 <handle_fiq_invalid>
40006304: d503201f     	nop
40006308: d503201f     	nop
4000630c: d503201f     	nop
40006310: d503201f     	nop
40006314: d503201f     	nop
40006318: d503201f     	nop
4000631c: d503201f     	nop
40006320: d503201f     	nop
40006324: d503201f     	nop
40006328: d503201f     	nop
4000632c: d503201f     	nop
40006330: d503201f     	nop
40006334: d503201f     	nop
40006338: d503201f     	nop
4000633c: d503201f     	nop
40006340: d503201f     	nop
40006344: d503201f     	nop
40006348: d503201f     	nop
4000634c: d503201f     	nop
40006350: d503201f     	nop
40006354: d503201f     	nop
40006358: d503201f     	nop
4000635c: d503201f     	nop
40006360: d503201f     	nop
40006364: d503201f     	nop
40006368: d503201f     	nop
4000636c: d503201f     	nop
40006370: d503201f     	nop
40006374: d503201f     	nop
40006378: d503201f     	nop
4000637c: d503201f     	nop

0000000040006380 <curr_el_spx_serror>:
40006380: 14000183     	b	0x4000698c <handle_serror_invalid>
40006384: d503201f     	nop
40006388: d503201f     	nop
4000638c: d503201f     	nop
40006390: d503201f     	nop
40006394: d503201f     	nop
40006398: d503201f     	nop
4000639c: d503201f     	nop
400063a0: d503201f     	nop
400063a4: d503201f     	nop
400063a8: d503201f     	nop
400063ac: d503201f     	nop
400063b0: d503201f     	nop
400063b4: d503201f     	nop
400063b8: d503201f     	nop
400063bc: d503201f     	nop
400063c0: d503201f     	nop
400063c4: d503201f     	nop
400063c8: d503201f     	nop
400063cc: d503201f     	nop
400063d0: d503201f     	nop
400063d4: d503201f     	nop
400063d8: d503201f     	nop
400063dc: d503201f     	nop
400063e0: d503201f     	nop
400063e4: d503201f     	nop
400063e8: d503201f     	nop
400063ec: d503201f     	nop
400063f0: d503201f     	nop
400063f4: d503201f     	nop
400063f8: d503201f     	nop
400063fc: d503201f     	nop

0000000040006400 <lower_el_aarch64_sync>:
40006400: 140000e1     	b	0x40006784 <handle_sync_invalid>
40006404: d503201f     	nop
40006408: d503201f     	nop
4000640c: d503201f     	nop
40006410: d503201f     	nop
40006414: d503201f     	nop
40006418: d503201f     	nop
4000641c: d503201f     	nop
40006420: d503201f     	nop
40006424: d503201f     	nop
40006428: d503201f     	nop
4000642c: d503201f     	nop
40006430: d503201f     	nop
40006434: d503201f     	nop
40006438: d503201f     	nop
4000643c: d503201f     	nop
40006440: d503201f     	nop
40006444: d503201f     	nop
40006448: d503201f     	nop
4000644c: d503201f     	nop
40006450: d503201f     	nop
40006454: d503201f     	nop
40006458: d503201f     	nop
4000645c: d503201f     	nop
40006460: d503201f     	nop
40006464: d503201f     	nop
40006468: d503201f     	nop
4000646c: d503201f     	nop
40006470: d503201f     	nop
40006474: d503201f     	nop
40006478: d503201f     	nop
4000647c: d503201f     	nop

0000000040006480 <lower_el_aarch64_irq>:
40006480: 140000ed     	b	0x40006834 <handle_irq_invalid>
40006484: d503201f     	nop
40006488: d503201f     	nop
4000648c: d503201f     	nop
40006490: d503201f     	nop
40006494: d503201f     	nop
40006498: d503201f     	nop
4000649c: d503201f     	nop
400064a0: d503201f     	nop
400064a4: d503201f     	nop
400064a8: d503201f     	nop
400064ac: d503201f     	nop
400064b0: d503201f     	nop
400064b4: d503201f     	nop
400064b8: d503201f     	nop
400064bc: d503201f     	nop
400064c0: d503201f     	nop
400064c4: d503201f     	nop
400064c8: d503201f     	nop
400064cc: d503201f     	nop
400064d0: d503201f     	nop
400064d4: d503201f     	nop
400064d8: d503201f     	nop
400064dc: d503201f     	nop
400064e0: d503201f     	nop
400064e4: d503201f     	nop
400064e8: d503201f     	nop
400064ec: d503201f     	nop
400064f0: d503201f     	nop
400064f4: d503201f     	nop
400064f8: d503201f     	nop
400064fc: d503201f     	nop

0000000040006500 <lower_el_aarch64_fiq>:
40006500: 140000f8     	b	0x400068e0 <handle_fiq_invalid>
40006504: d503201f     	nop
40006508: d503201f     	nop
4000650c: d503201f     	nop
40006510: d503201f     	nop
40006514: d503201f     	nop
40006518: d503201f     	nop
4000651c: d503201f     	nop
40006520: d503201f     	nop
40006524: d503201f     	nop
40006528: d503201f     	nop
4000652c: d503201f     	nop
40006530: d503201f     	nop
40006534: d503201f     	nop
40006538: d503201f     	nop
4000653c: d503201f     	nop
40006540: d503201f     	nop
40006544: d503201f     	nop
40006548: d503201f     	nop
4000654c: d503201f     	nop
40006550: d503201f     	nop
40006554: d503201f     	nop
40006558: d503201f     	nop
4000655c: d503201f     	nop
40006560: d503201f     	nop
40006564: d503201f     	nop
40006568: d503201f     	nop
4000656c: d503201f     	nop
40006570: d503201f     	nop
40006574: d503201f     	nop
40006578: d503201f     	nop
4000657c: d503201f     	nop

0000000040006580 <lower_el_aarch64_serror>:
40006580: 14000103     	b	0x4000698c <handle_serror_invalid>
40006584: d503201f     	nop
40006588: d503201f     	nop
4000658c: d503201f     	nop
40006590: d503201f     	nop
40006594: d503201f     	nop
40006598: d503201f     	nop
4000659c: d503201f     	nop
400065a0: d503201f     	nop
400065a4: d503201f     	nop
400065a8: d503201f     	nop
400065ac: d503201f     	nop
400065b0: d503201f     	nop
400065b4: d503201f     	nop
400065b8: d503201f     	nop
400065bc: d503201f     	nop
400065c0: d503201f     	nop
400065c4: d503201f     	nop
400065c8: d503201f     	nop
400065cc: d503201f     	nop
400065d0: d503201f     	nop
400065d4: d503201f     	nop
400065d8: d503201f     	nop
400065dc: d503201f     	nop
400065e0: d503201f     	nop
400065e4: d503201f     	nop
400065e8: d503201f     	nop
400065ec: d503201f     	nop
400065f0: d503201f     	nop
400065f4: d503201f     	nop
400065f8: d503201f     	nop
400065fc: d503201f     	nop

0000000040006600 <lower_el_aarch32_sync>:
40006600: 14000061     	b	0x40006784 <handle_sync_invalid>
40006604: d503201f     	nop
40006608: d503201f     	nop
4000660c: d503201f     	nop
40006610: d503201f     	nop
40006614: d503201f     	nop
40006618: d503201f     	nop
4000661c: d503201f     	nop
40006620: d503201f     	nop
40006624: d503201f     	nop
40006628: d503201f     	nop
4000662c: d503201f     	nop
40006630: d503201f     	nop
40006634: d503201f     	nop
40006638: d503201f     	nop
4000663c: d503201f     	nop
40006640: d503201f     	nop
40006644: d503201f     	nop
40006648: d503201f     	nop
4000664c: d503201f     	nop
40006650: d503201f     	nop
40006654: d503201f     	nop
40006658: d503201f     	nop
4000665c: d503201f     	nop
40006660: d503201f     	nop
40006664: d503201f     	nop
40006668: d503201f     	nop
4000666c: d503201f     	nop
40006670: d503201f     	nop
40006674: d503201f     	nop
40006678: d503201f     	nop
4000667c: d503201f     	nop

0000000040006680 <lower_el_aarch32_irq>:
40006680: 1400006d     	b	0x40006834 <handle_irq_invalid>
40006684: d503201f     	nop
40006688: d503201f     	nop
4000668c: d503201f     	nop
40006690: d503201f     	nop
40006694: d503201f     	nop
40006698: d503201f     	nop
4000669c: d503201f     	nop
400066a0: d503201f     	nop
400066a4: d503201f     	nop
400066a8: d503201f     	nop
400066ac: d503201f     	nop
400066b0: d503201f     	nop
400066b4: d503201f     	nop
400066b8: d503201f     	nop
400066bc: d503201f     	nop
400066c0: d503201f     	nop
400066c4: d503201f     	nop
400066c8: d503201f     	nop
400066cc: d503201f     	nop
400066d0: d503201f     	nop
400066d4: d503201f     	nop
400066d8: d503201f     	nop
400066dc: d503201f     	nop
400066e0: d503201f     	nop
400066e4: d503201f     	nop
400066e8: d503201f     	nop
400066ec: d503201f     	nop
400066f0: d503201f     	nop
400066f4: d503201f     	nop
400066f8: d503201f     	nop
400066fc: d503201f     	nop

0000000040006700 <lower_el_aarch32_fiq>:
40006700: 14000078     	b	0x400068e0 <handle_fiq_invalid>
40006704: d503201f     	nop
40006708: d503201f     	nop
4000670c: d503201f     	nop
40006710: d503201f     	nop
40006714: d503201f     	nop
40006718: d503201f     	nop
4000671c: d503201f     	nop
40006720: d503201f     	nop
40006724: d503201f     	nop
40006728: d503201f     	nop
4000672c: d503201f     	nop
40006730: d503201f     	nop
40006734: d503201f     	nop
40006738: d503201f     	nop
4000673c: d503201f     	nop
40006740: d503201f     	nop
40006744: d503201f     	nop
40006748: d503201f     	nop
4000674c: d503201f     	nop
40006750: d503201f     	nop
40006754: d503201f     	nop
40006758: d503201f     	nop
4000675c: d503201f     	nop
40006760: d503201f     	nop
40006764: d503201f     	nop
40006768: d503201f     	nop
4000676c: d503201f     	nop
40006770: d503201f     	nop
40006774: d503201f     	nop
40006778: d503201f     	nop
4000677c: d503201f     	nop

0000000040006780 <lower_el_aarch32_serror>:
40006780: 14000083     	b	0x4000698c <handle_serror_invalid>

0000000040006784 <handle_sync_invalid>:
40006784: d10443ff     	sub	sp, sp, #0x110
40006788: a90007e0     	stp	x0, x1, [sp]
4000678c: d5384020     	mrs	x0, ELR_EL1
40006790: d5384001     	mrs	x1, SPSR_EL1
40006794: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006798: a94007e0     	ldp	x0, x1, [sp]
4000679c: a9010fe2     	stp	x2, x3, [sp, #0x10]
400067a0: a90217e4     	stp	x4, x5, [sp, #0x20]
400067a4: a9031fe6     	stp	x6, x7, [sp, #0x30]
400067a8: a90427e8     	stp	x8, x9, [sp, #0x40]
400067ac: a9052fea     	stp	x10, x11, [sp, #0x50]
400067b0: a90637ec     	stp	x12, x13, [sp, #0x60]
400067b4: a9073fee     	stp	x14, x15, [sp, #0x70]
400067b8: a90847f0     	stp	x16, x17, [sp, #0x80]
400067bc: a9094ff2     	stp	x18, x19, [sp, #0x90]
400067c0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400067c4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400067c8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400067cc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400067d0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400067d4: f9007bfe     	str	x30, [sp, #0xf0]
400067d8: 910003e0     	mov	x0, sp
400067dc: 97ffe655     	bl	0x40000130 <c_handle_sync_invalid>
400067e0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400067e4: d5184020     	msr	ELR_EL1, x0
400067e8: d5184001     	msr	SPSR_EL1, x1
400067ec: a94007e0     	ldp	x0, x1, [sp]
400067f0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400067f4: a94217e4     	ldp	x4, x5, [sp, #0x20]
400067f8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400067fc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006800: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006804: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006808: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000680c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006810: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006814: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006818: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000681c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006820: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006824: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006828: f9407bfe     	ldr	x30, [sp, #0xf0]
4000682c: 910443ff     	add	sp, sp, #0x110
40006830: d69f03e0     	eret

0000000040006834 <handle_irq_invalid>:
40006834: d10443ff     	sub	sp, sp, #0x110
40006838: a90007e0     	stp	x0, x1, [sp]
4000683c: d5384020     	mrs	x0, ELR_EL1
40006840: d5384001     	mrs	x1, SPSR_EL1
40006844: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006848: a94007e0     	ldp	x0, x1, [sp]
4000684c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006850: a90217e4     	stp	x4, x5, [sp, #0x20]
40006854: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006858: a90427e8     	stp	x8, x9, [sp, #0x40]
4000685c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006860: a90637ec     	stp	x12, x13, [sp, #0x60]
40006864: a9073fee     	stp	x14, x15, [sp, #0x70]
40006868: a90847f0     	stp	x16, x17, [sp, #0x80]
4000686c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006870: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006874: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006878: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000687c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006880: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006884: f9007bfe     	str	x30, [sp, #0xf0]
40006888: 97ffe638     	bl	0x40000168 <c_handle_irq_invalid>
4000688c: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40006890: d5184020     	msr	ELR_EL1, x0
40006894: d5184001     	msr	SPSR_EL1, x1
40006898: a94007e0     	ldp	x0, x1, [sp]
4000689c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400068a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
400068a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400068a8: a94427e8     	ldp	x8, x9, [sp, #0x40]
400068ac: a9452fea     	ldp	x10, x11, [sp, #0x50]
400068b0: a94637ec     	ldp	x12, x13, [sp, #0x60]
400068b4: a9473fee     	ldp	x14, x15, [sp, #0x70]
400068b8: a94847f0     	ldp	x16, x17, [sp, #0x80]
400068bc: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400068c0: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400068c4: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400068c8: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400068cc: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400068d0: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400068d4: f9407bfe     	ldr	x30, [sp, #0xf0]
400068d8: 910443ff     	add	sp, sp, #0x110
400068dc: d69f03e0     	eret

00000000400068e0 <handle_fiq_invalid>:
400068e0: d10443ff     	sub	sp, sp, #0x110
400068e4: a90007e0     	stp	x0, x1, [sp]
400068e8: d5384020     	mrs	x0, ELR_EL1
400068ec: d5384001     	mrs	x1, SPSR_EL1
400068f0: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400068f4: a94007e0     	ldp	x0, x1, [sp]
400068f8: a9010fe2     	stp	x2, x3, [sp, #0x10]
400068fc: a90217e4     	stp	x4, x5, [sp, #0x20]
40006900: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006904: a90427e8     	stp	x8, x9, [sp, #0x40]
40006908: a9052fea     	stp	x10, x11, [sp, #0x50]
4000690c: a90637ec     	stp	x12, x13, [sp, #0x60]
40006910: a9073fee     	stp	x14, x15, [sp, #0x70]
40006914: a90847f0     	stp	x16, x17, [sp, #0x80]
40006918: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000691c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006920: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006924: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006928: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000692c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006930: f9007bfe     	str	x30, [sp, #0xf0]
40006934: 97ffe613     	bl	0x40000180 <c_handle_fiq_invalid>
40006938: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
4000693c: d5184020     	msr	ELR_EL1, x0
40006940: d5184001     	msr	SPSR_EL1, x1
40006944: a94007e0     	ldp	x0, x1, [sp]
40006948: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000694c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006950: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006954: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006958: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000695c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006960: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006964: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006968: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000696c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006970: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006974: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006978: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000697c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006980: f9407bfe     	ldr	x30, [sp, #0xf0]
40006984: 910443ff     	add	sp, sp, #0x110
40006988: d69f03e0     	eret

000000004000698c <handle_serror_invalid>:
4000698c: d10443ff     	sub	sp, sp, #0x110
40006990: a90007e0     	stp	x0, x1, [sp]
40006994: d5384020     	mrs	x0, ELR_EL1
40006998: d5384001     	mrs	x1, SPSR_EL1
4000699c: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400069a0: a94007e0     	ldp	x0, x1, [sp]
400069a4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400069a8: a90217e4     	stp	x4, x5, [sp, #0x20]
400069ac: a9031fe6     	stp	x6, x7, [sp, #0x30]
400069b0: a90427e8     	stp	x8, x9, [sp, #0x40]
400069b4: a9052fea     	stp	x10, x11, [sp, #0x50]
400069b8: a90637ec     	stp	x12, x13, [sp, #0x60]
400069bc: a9073fee     	stp	x14, x15, [sp, #0x70]
400069c0: a90847f0     	stp	x16, x17, [sp, #0x80]
400069c4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400069c8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400069cc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400069d0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400069d4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400069d8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400069dc: f9007bfe     	str	x30, [sp, #0xf0]
400069e0: 97ffe5ee     	bl	0x40000198 <c_handle_serror_invalid>
400069e4: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400069e8: d5184020     	msr	ELR_EL1, x0
400069ec: d5184001     	msr	SPSR_EL1, x1
400069f0: a94007e0     	ldp	x0, x1, [sp]
400069f4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400069f8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400069fc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006a00: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006a04: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006a08: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006a0c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006a10: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006a14: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006a18: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006a1c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006a20: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006a24: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006a28: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006a2c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006a30: 910443ff     	add	sp, sp, #0x110
40006a34: d69f03e0     	eret

0000000040006a38 <trigger_undefined_instruction>:
40006a38: 00000000     	udf	#0x0
40006a3c: d65f03c0     	ret

0000000040006a40 <handle_sync_exception_asm>:
40006a40: d10443ff     	sub	sp, sp, #0x110
40006a44: a90007e0     	stp	x0, x1, [sp]
40006a48: d5384020     	mrs	x0, ELR_EL1
40006a4c: d5384001     	mrs	x1, SPSR_EL1
40006a50: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006a54: a94007e0     	ldp	x0, x1, [sp]
40006a58: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006a5c: a90217e4     	stp	x4, x5, [sp, #0x20]
40006a60: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006a64: a90427e8     	stp	x8, x9, [sp, #0x40]
40006a68: a9052fea     	stp	x10, x11, [sp, #0x50]
40006a6c: a90637ec     	stp	x12, x13, [sp, #0x60]
40006a70: a9073fee     	stp	x14, x15, [sp, #0x70]
40006a74: a90847f0     	stp	x16, x17, [sp, #0x80]
40006a78: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006a7c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006a80: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006a84: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006a88: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006a8c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006a90: f9007bfe     	str	x30, [sp, #0xf0]
40006a94: 910003e0     	mov	x0, sp
40006a98: 97ffe572     	bl	0x40000060 <handle_sync_exception>
40006a9c: 9100001f     	mov	sp, x0
40006aa0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40006aa4: d5184020     	msr	ELR_EL1, x0
40006aa8: d5184001     	msr	SPSR_EL1, x1
40006aac: a94007e0     	ldp	x0, x1, [sp]
40006ab0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006ab4: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006ab8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006abc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006ac0: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006ac4: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006ac8: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006acc: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006ad0: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006ad4: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006ad8: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006adc: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006ae0: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006ae4: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006ae8: f9407bfe     	ldr	x30, [sp, #0xf0]
40006aec: 910443ff     	add	sp, sp, #0x110
40006af0: d69f03e0     	eret

0000000040006af4 <handle_irq_exception_asm>:
40006af4: d10443ff     	sub	sp, sp, #0x110
40006af8: a90007e0     	stp	x0, x1, [sp]
40006afc: d5384020     	mrs	x0, ELR_EL1
40006b00: d5384001     	mrs	x1, SPSR_EL1
40006b04: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40006b08: a94007e0     	ldp	x0, x1, [sp]
40006b0c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006b10: a90217e4     	stp	x4, x5, [sp, #0x20]
40006b14: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006b18: a90427e8     	stp	x8, x9, [sp, #0x40]
40006b1c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006b20: a90637ec     	stp	x12, x13, [sp, #0x60]
40006b24: a9073fee     	stp	x14, x15, [sp, #0x70]
40006b28: a90847f0     	stp	x16, x17, [sp, #0x80]
40006b2c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006b30: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006b34: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006b38: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006b3c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006b40: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006b44: f9007bfe     	str	x30, [sp, #0xf0]
40006b48: 910003e0     	mov	x0, sp
40006b4c: 97ffe599     	bl	0x400001b0 <handle_irq_exception>
40006b50: 9100001f     	mov	sp, x0
40006b54: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40006b58: d5184020     	msr	ELR_EL1, x0
40006b5c: d5184001     	msr	SPSR_EL1, x1
40006b60: a94007e0     	ldp	x0, x1, [sp]
40006b64: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006b68: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006b6c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006b70: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006b74: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006b78: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006b7c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006b80: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006b84: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006b88: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006b8c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006b90: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006b94: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006b98: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006b9c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006ba0: 910443ff     	add	sp, sp, #0x110
40006ba4: d69f03e0     	eret
