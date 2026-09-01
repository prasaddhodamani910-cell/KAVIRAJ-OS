
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
4000003c: 9400060a     	bl	0x40001864 <kmain>

0000000040000040 <halt>:
40000040: d503207f     	wfi
40000044: 17ffffff     	b	0x40000040 <halt>
40000048: a0 9b 04 40  	.word	0x40049ba0
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 b0 00 40  	.word	0x4000b000
40000054: 00 00 00 00  	.word	0x00000000
40000058: a0 9b 03 40  	.word	0x40039ba0
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: d503201f     	nop
40000068: 300421a0     	adr	x0, 0x4000849d <__rodata_start+0x149d>
4000006c: f9000bf5     	str	x21, [sp, #0x10]
40000070: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000074: 910003fd     	mov	x29, sp
40000078: d5385214     	mrs	x20, ESR_EL1
4000007c: d5384033     	mrs	x19, ELR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000d7f     	bl	0x40003680 <uart_puts>
40000088: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000008c: 91322400     	add	x0, x0, #0xc89
40000090: aa1403e1     	mov	x1, x20
40000094: 94000e90     	bl	0x40003ad4 <uart_printf>
40000098: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000009c: 913c8c00     	add	x0, x0, #0xf23
400000a0: aa1303e1     	mov	x1, x19
400000a4: 94000e8c     	bl	0x40003ad4 <uart_printf>
400000a8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000ac: 91114c00     	add	x0, x0, #0x453
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000e88     	bl	0x40003ad4 <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400000c0: 9111cc00     	add	x0, x0, #0x473
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000e83     	bl	0x40003ad4 <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000f0: 910b6800     	add	x0, x0, #0x2da
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000fc: 91280800     	add	x0, x0, #0xa02
40000100: 94000d60     	bl	0x40003680 <uart_puts>
40000104: 91001268     	add	x8, x19, #0x4
40000108: d5184028     	msr	ELR_EL1, x8
4000010c: f9400bf5     	ldr	x21, [sp, #0x10]
40000110: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40000114: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000118: 9103a400     	add	x0, x0, #0xe9
4000011c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40000120: 14000d58     	b	0x40003680 <uart_puts>

0000000040000124 <c_handle_sync_invalid>:
40000124: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000128: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000012c: 9136b400     	add	x0, x0, #0xdad
40000130: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000134: 910003fd     	mov	x29, sp
40000138: d5385213     	mrs	x19, ESR_EL1
4000013c: d5384034     	mrs	x20, ELR_EL1
40000140: 94000e65     	bl	0x40003ad4 <uart_printf>
40000144: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000148: 91288400     	add	x0, x0, #0xa21
4000014c: aa1303e1     	mov	x1, x19
40000150: aa1403e2     	mov	x2, x20
40000154: 94000e60     	bl	0x40003ad4 <uart_printf>
40000158: 14000000     	b	0x40000158 <c_handle_sync_invalid+0x34>

000000004000015c <c_handle_irq_invalid>:
4000015c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000160: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000164: 91326800     	add	x0, x0, #0xc9a
40000168: 910003fd     	mov	x29, sp
4000016c: 94000d45     	bl	0x40003680 <uart_puts>
40000170: 14000000     	b	0x40000170 <c_handle_irq_invalid+0x14>

0000000040000174 <c_handle_fiq_invalid>:
40000174: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000178: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000017c: 91287000     	add	x0, x0, #0xa1c
40000180: 910003fd     	mov	x29, sp
40000184: 94000d3f     	bl	0x40003680 <uart_puts>
40000188: 14000000     	b	0x40000188 <c_handle_fiq_invalid+0x14>

000000004000018c <c_handle_serror_invalid>:
4000018c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000190: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000194: 91033c00     	add	x0, x0, #0xcf
40000198: 910003fd     	mov	x29, sp
4000019c: 94000d39     	bl	0x40003680 <uart_puts>
400001a0: 14000000     	b	0x400001a0 <c_handle_serror_invalid+0x14>

00000000400001a4 <handle_irq_exception>:
400001a4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400001a8: f9000bf3     	str	x19, [sp, #0x10]
400001ac: 910003fd     	mov	x29, sp
400001b0: 94000033     	bl	0x4000027c <gic_acknowledge_interrupt>
400001b4: 2a0003f3     	mov	w19, w0
400001b8: 710ffc1f     	cmp	w0, #0x3ff
400001bc: 54000120     	b.eq	0x400001e0 <handle_irq_exception+0x3c>
400001c0: 71007a7f     	cmp	w19, #0x1e
400001c4: 54000061     	b.ne	0x400001d0 <handle_irq_exception+0x2c>
400001c8: 94000a4a     	bl	0x40002af0 <timer_handle_interrupt>
400001cc: 14000005     	b	0x400001e0 <handle_irq_exception+0x3c>
400001d0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001d4: 91082c00     	add	x0, x0, #0x20b
400001d8: 2a1303e1     	mov	w1, w19
400001dc: 94000e3e     	bl	0x40003ad4 <uart_printf>
400001e0: 2a1303e0     	mov	w0, w19
400001e4: f9400bf3     	ldr	x19, [sp, #0x10]
400001e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400001ec: 14000029     	b	0x40000290 <gic_end_interrupt>

00000000400001f0 <gic_init>:
400001f0: 52800089     	mov	w9, #0x4                // =4
400001f4: 52a10008     	mov	w8, #0x8000000          // =134217728
400001f8: 52801fea     	mov	w10, #0xff              // =255
400001fc: 72a10029     	movk	w9, #0x801, lsl #16
40000200: b900011f     	str	wzr, [x8]
40000204: 52a1002b     	mov	w11, #0x8010000         // =134283264
40000208: b900012a     	str	w10, [x9]
4000020c: 52800069     	mov	w9, #0x3                // =3
40000210: b9000169     	str	w9, [x11]
40000214: b9000109     	str	w9, [x8]
40000218: d65f03c0     	ret

000000004000021c <gic_enable_interrupt>:
4000021c: 53037c0a     	lsr	w10, w0, #3
40000220: 52800028     	mov	w8, #0x1                // =1
40000224: 5280200d     	mov	w13, #0x100             // =256
40000228: 52808009     	mov	w9, #0x400              // =1024
4000022c: 1ac0210b     	lsl	w11, w8, w0
40000230: 72a1000d     	movk	w13, #0x800, lsl #16
40000234: 927e694c     	and	x12, x10, #0x1ffffffc
40000238: 531d040a     	ubfiz	w10, w0, #3, #2
4000023c: 72a10009     	movk	w9, #0x800, lsl #16
40000240: b82d698b     	str	w11, [x12, x13]
40000244: 927e740b     	and	x11, x0, #0xfffffffc
40000248: 52801fec     	mov	w12, #0xff              // =255
4000024c: b869696d     	ldr	w13, [x11, x9]
40000250: 1aca218c     	lsl	w12, w12, w10
40000254: 7100801f     	cmp	w0, #0x20
40000258: 0a2c01ac     	bic	w12, w13, w12
4000025c: b829696c     	str	w12, [x11, x9]
40000260: 540000c3     	b.lo	0x40000278 <gic_enable_interrupt+0x5c>
40000264: 8b0b0129     	add	x9, x9, x11
40000268: 1aca2108     	lsl	w8, w8, w10
4000026c: b944012b     	ldr	w11, [x9, #0x400]
40000270: 2a080168     	orr	w8, w11, w8
40000274: b9040128     	str	w8, [x9, #0x400]
40000278: d65f03c0     	ret

000000004000027c <gic_acknowledge_interrupt>:
4000027c: 52800188     	mov	w8, #0xc                // =12
40000280: 72a10028     	movk	w8, #0x801, lsl #16
40000284: b9400108     	ldr	w8, [x8]
40000288: 12002500     	and	w0, w8, #0x3ff
4000028c: d65f03c0     	ret

0000000040000290 <gic_end_interrupt>:
40000290: 52800208     	mov	w8, #0x10               // =16
40000294: 72a10028     	movk	w8, #0x801, lsl #16
40000298: b9000100     	str	w0, [x8]
4000029c: d65f03c0     	ret

00000000400002a0 <launch_kedit>:
400002a0: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400002a4: a9016ffc     	stp	x28, x27, [sp, #0x10]
400002a8: 910003fd     	mov	x29, sp
400002ac: a90267fa     	stp	x26, x25, [sp, #0x20]
400002b0: a9035ff8     	stp	x24, x23, [sp, #0x30]
400002b4: a90457f6     	stp	x22, x21, [sp, #0x40]
400002b8: a9054ff4     	stp	x20, x19, [sp, #0x50]
400002bc: d11043ff     	sub	sp, sp, #0x410
400002c0: d503201f     	nop
400002c4: 100569f3     	adr	x19, 0x4000b000 <__bss_start>
400002c8: aa0003f4     	mov	x20, x0
400002cc: aa1303e0     	mov	x0, x19
400002d0: 2a1f03e1     	mov	w1, wzr
400002d4: 52864a82     	mov	w2, #0x3254             // =12884
400002d8: 9400099c     	bl	0x40002948 <memset>
400002dc: aa1303e0     	mov	x0, x19
400002e0: aa1403e1     	mov	x1, x20
400002e4: 528007e2     	mov	w2, #0x3f               // =63
400002e8: 94000973     	bl	0x400028b4 <kstrncpy>
400002ec: 5280003c     	mov	w28, #0x1               // =1
400002f0: aa1403e0     	mov	x0, x20
400002f4: b932427c     	str	w28, [x19, #0x3240]
400002f8: 940011c0     	bl	0x400049f8 <vfs_find>
400002fc: d0000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40000300: b40004a0     	cbz	x0, 0x40000394 <launch_kedit+0xf4>
40000304: b9402008     	ldr	w8, [x0, #0x20]
40000308: 35000468     	cbnz	w8, 0x40000394 <launch_kedit+0xf4>
4000030c: f9401408     	ldr	x8, [x0, #0x28]
40000310: b40003c8     	cbz	x8, 0x40000388 <launch_kedit+0xe8>
40000314: 2a1f03e8     	mov	w8, wzr
40000318: 2a1f03eb     	mov	w11, wzr
4000031c: aa1f03e9     	mov	x9, xzr
40000320: 9100c00a     	add	x10, x0, #0x30
40000324: 1400000d     	b	0x40000358 <launch_kedit+0xb8>
40000328: 93407d0c     	sxtw	x12, w8
4000032c: 7101891f     	cmp	w8, #0x62
40000330: 11000508     	add	w8, w8, #0x1
40000334: 8b0c1e6c     	add	x12, x19, x12, lsl #7
40000338: 8b2bc18b     	add	x11, x12, w11, sxtw
4000033c: 3901017f     	strb	wzr, [x11, #0x40]
40000340: 2a1f03eb     	mov	w11, wzr
40000344: 5400022c     	b.gt	0x40000388 <launch_kedit+0xe8>
40000348: f940140c     	ldr	x12, [x0, #0x28]
4000034c: 91000529     	add	x9, x9, #0x1
40000350: eb0c013f     	cmp	x9, x12
40000354: 540001a2     	b.hs	0x40000388 <launch_kedit+0xe8>
40000358: 3869694c     	ldrb	w12, [x10, x9]
4000035c: 7100299f     	cmp	w12, #0xa
40000360: 54fffe40     	b.eq	0x40000328 <launch_kedit+0x88>
40000364: 7101f97f     	cmp	w11, #0x7e
40000368: 54ffff0c     	b.gt	0x40000348 <launch_kedit+0xa8>
4000036c: 2a0803ed     	mov	w13, w8
40000370: 93407dad     	sxtw	x13, w13
40000374: 8b0d1e6d     	add	x13, x19, x13, lsl #7
40000378: 8b2bc1ad     	add	x13, x13, w11, sxtw
4000037c: 1100056b     	add	w11, w11, #0x1
40000380: 390101ac     	strb	w12, [x13, #0x40]
40000384: 17fffff1     	b	0x40000348 <launch_kedit+0xa8>
40000388: 7100051f     	cmp	w8, #0x1
4000038c: 1a9f8508     	csinc	w8, w8, wzr, hi
40000390: b90242e8     	str	w8, [x23, #0x240]
40000394: d503201f     	nop
40000398: 30042060     	adr	x0, 0x400087a5 <__rodata_start+0x17a5>
4000039c: 94000cb9     	bl	0x40003680 <uart_puts>
400003a0: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400003a4: 91301e94     	add	x20, x20, #0xc07
400003a8: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400003ac: 9104a6d6     	add	x22, x22, #0x129
400003b0: 90000058     	adrp	x24, 0x40008000 <__rodata_start+0x1000>
400003b4: 910bb318     	add	x24, x24, #0x2ec
400003b8: 90000059     	adrp	x25, 0x40008000 <__rodata_start+0x1000>
400003bc: 91177739     	add	x25, x25, #0x5dd
400003c0: d000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400003c4: 9109135a     	add	x26, x26, #0x244
400003c8: d000007b     	adrp	x27, 0x4000e000 <__bss_start+0x3000>
400003cc: 14000004     	b	0x400003dc <launch_kedit+0x13c>
400003d0: 51004d08     	sub	w8, w8, #0x13
400003d4: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400003d8: b9024d28     	str	w8, [x9, #0x24c]
400003dc: aa1403e0     	mov	x0, x20
400003e0: 94000ca8     	bl	0x40003680 <uart_puts>
400003e4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400003e8: 91058400     	add	x0, x0, #0x161
400003ec: 94000ca5     	bl	0x40003680 <uart_puts>
400003f0: aa1603e0     	mov	x0, x22
400003f4: 94000ca3     	bl	0x40003680 <uart_puts>
400003f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400003fc: 9132dc00     	add	x0, x0, #0xcb7
40000400: aa1303e1     	mov	x1, x19
40000404: 94000db4     	bl	0x40003ad4 <uart_printf>
40000408: b9725268     	ldr	w8, [x19, #0x3250]
4000040c: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000410: 910a8929     	add	x9, x9, #0x2a2
40000414: 7100011f     	cmp	w8, #0x0
40000418: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
4000041c: 9120b108     	add	x8, x8, #0x82c
40000420: 9a880120     	csel	x0, x9, x8, eq
40000424: 94000c97     	bl	0x40003680 <uart_puts>
40000428: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000042c: 913d4400     	add	x0, x0, #0xf51
40000430: 94000c94     	bl	0x40003680 <uart_puts>
40000434: aa1f03f5     	mov	x21, xzr
40000438: b9b24e68     	ldrsw	x8, [x19, #0x324c]
4000043c: b9724269     	ldr	w9, [x19, #0x3240]
40000440: 8b0802a8     	add	x8, x21, x8
40000444: 8b081e6a     	add	x10, x19, x8, lsl #7
40000448: 6b09011f     	cmp	w8, w9
4000044c: 9101014a     	add	x10, x10, #0x40
40000450: 9a98b140     	csel	x0, x10, x24, lt
40000454: 94000c8b     	bl	0x40003680 <uart_puts>
40000458: aa1903e0     	mov	x0, x25
4000045c: 94000c89     	bl	0x40003680 <uart_puts>
40000460: 910006b5     	add	x21, x21, #0x1
40000464: 710052bf     	cmp	w21, #0x14
40000468: 54fffe81     	b.ne	0x40000438 <launch_kedit+0x198>
4000046c: aa1603e0     	mov	x0, x22
40000470: 94000c84     	bl	0x40003680 <uart_puts>
40000474: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000478: 910bdc00     	add	x0, x0, #0x2f7
4000047c: 94000c81     	bl	0x40003680 <uart_puts>
40000480: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000484: 9128e400     	add	x0, x0, #0xa39
40000488: 94000c7e     	bl	0x40003680 <uart_puts>
4000048c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000490: 91177c00     	add	x0, x0, #0x5df
40000494: 94000c7b     	bl	0x40003680 <uart_puts>
40000498: 2940a349     	ldp	w9, w8, [x26, #0x4]
4000049c: b940034a     	ldr	w10, [x26]
400004a0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400004a4: 9111fc00     	add	x0, x0, #0x47f
400004a8: 4b080128     	sub	w8, w9, w8
400004ac: 11000542     	add	w2, w10, #0x1
400004b0: 11000901     	add	w1, w8, #0x2
400004b4: 94000d88     	bl	0x40003ad4 <uart_printf>
400004b8: 94000ca6     	bl	0x40003750 <uart_getc>
400004bc: 12001c08     	and	w8, w0, #0xff
400004c0: 2a0003f5     	mov	w21, w0
400004c4: 7100491f     	cmp	w8, #0x12
400004c8: 5400010d     	b.le	0x400004e8 <launch_kedit+0x248>
400004cc: 7100691f     	cmp	w8, #0x1a
400004d0: 540009ed     	b.le	0x4000060c <launch_kedit+0x36c>
400004d4: 71006d1f     	cmp	w8, #0x1b
400004d8: 54000e40     	b.eq	0x400006a0 <launch_kedit+0x400>
400004dc: 7101fd1f     	cmp	w8, #0x7f
400004e0: 540005e0     	b.eq	0x4000059c <launch_kedit+0x2fc>
400004e4: 1400008b     	b	0x40000710 <launch_kedit+0x470>
400004e8: 7100211f     	cmp	w8, #0x8
400004ec: 54000580     	b.eq	0x4000059c <launch_kedit+0x2fc>
400004f0: 7100291f     	cmp	w8, #0xa
400004f4: 54000060     	b.eq	0x40000500 <launch_kedit+0x260>
400004f8: 7100351f     	cmp	w8, #0xd
400004fc: 540010a1     	b.ne	0x40000710 <launch_kedit+0x470>
40000500: b98242f6     	ldrsw	x22, [x23, #0x240]
40000504: 71018edf     	cmp	w22, #0x63
40000508: 540014ac     	b.gt	0x4000079c <launch_kedit+0x4fc>
4000050c: b9824b68     	ldrsw	x8, [x27, #0x248]
40000510: 6b0802df     	cmp	w22, w8
40000514: 5400016d     	b.le	0x40000540 <launch_kedit+0x2a0>
40000518: 8b161e68     	add	x8, x19, x22, lsl #7
4000051c: 91010100     	add	x0, x8, #0x40
40000520: d1020015     	sub	x21, x0, #0x80
40000524: d10006d6     	sub	x22, x22, #0x1
40000528: aa1503e1     	mov	x1, x21
4000052c: 940008db     	bl	0x40002898 <kstrcpy>
40000530: b9824b68     	ldrsw	x8, [x27, #0x248]
40000534: aa1503e0     	mov	x0, x21
40000538: eb0802df     	cmp	x22, x8
4000053c: 54ffff2c     	b.gt	0x40000520 <launch_kedit+0x280>
40000540: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
40000544: 910102b5     	add	x21, x21, #0x40
40000548: 910023e0     	add	x0, sp, #0x8
4000054c: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000550: 8b081ea8     	add	x8, x21, x8, lsl #7
40000554: 8b090101     	add	x1, x8, x9
40000558: 940008d0     	bl	0x40002898 <kstrcpy>
4000055c: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000560: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000564: 910023e1     	add	x1, sp, #0x8
40000568: 8b081ea8     	add	x8, x21, x8, lsl #7
4000056c: 3829691f     	strb	wzr, [x8, x9]
40000570: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000574: 91000508     	add	x8, x8, #0x1
40000578: 8b081ea0     	add	x0, x21, x8, lsl #7
4000057c: b9320aa8     	str	w8, [x21, #0x3208]
40000580: 940008c6     	bl	0x40002898 <kstrcpy>
40000584: b97202a8     	ldr	w8, [x21, #0x3200]
40000588: b93206bf     	str	wzr, [x21, #0x3204]
4000058c: b93212bc     	str	w28, [x21, #0x3210]
40000590: 11000508     	add	w8, w8, #0x1
40000594: b93202a8     	str	w8, [x21, #0x3200]
40000598: 14000081     	b	0x4000079c <launch_kedit+0x4fc>
4000059c: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400005a0: b9424508     	ldr	w8, [x8, #0x244]
400005a4: 7100051f     	cmp	w8, #0x1
400005a8: 54000fab     	b.lt	0x4000079c <launch_kedit+0x4fc>
400005ac: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400005b0: 8b081e68     	add	x8, x19, x8, lsl #7
400005b4: 91010100     	add	x0, x8, #0x40
400005b8: 94000889     	bl	0x400027dc <kstrlen>
400005bc: b9724669     	ldr	w9, [x19, #0x3244]
400005c0: 6b00013f     	cmp	w9, w0
400005c4: 51000528     	sub	w8, w9, #0x1
400005c8: 540001cc     	b.gt	0x40000600 <launch_kedit+0x360>
400005cc: 8b28c268     	add	x8, x19, w8, sxtw
400005d0: 4b090009     	sub	w9, w0, w9
400005d4: 11000529     	add	w9, w9, #0x1
400005d8: b9824b6a     	ldrsw	x10, [x27, #0x248]
400005dc: 71000529     	subs	w9, w9, #0x1
400005e0: 8b0a1d0a     	add	x10, x8, x10, lsl #7
400005e4: 91000508     	add	x8, x8, #0x1
400005e8: 3941054b     	ldrb	w11, [x10, #0x41]
400005ec: 3901014b     	strb	w11, [x10, #0x40]
400005f0: 54ffff41     	b.ne	0x400005d8 <launch_kedit+0x338>
400005f4: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400005f8: b9424508     	ldr	w8, [x8, #0x244]
400005fc: 51000508     	sub	w8, w8, #0x1
40000600: b9000348     	str	w8, [x26]
40000604: b9000f5c     	str	w28, [x26, #0xc]
40000608: 14000065     	b	0x4000079c <launch_kedit+0x4fc>
4000060c: 71004d1f     	cmp	w8, #0x13
40000610: 540007c1     	b.ne	0x40000708 <launch_kedit+0x468>
40000614: b94242e8     	ldr	w8, [x23, #0x240]
40000618: 390023ff     	strb	wzr, [sp, #0x8]
4000061c: 7100051f     	cmp	w8, #0x1
40000620: 5400030b     	b.lt	0x40000680 <launch_kedit+0x3e0>
40000624: aa1f03fc     	mov	x28, xzr
40000628: 2a1f03f6     	mov	w22, wzr
4000062c: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
40000630: 910102b5     	add	x21, x21, #0x40
40000634: 14000006     	b	0x4000064c <launch_kedit+0x3ac>
40000638: b98242e8     	ldrsw	x8, [x23, #0x240]
4000063c: 9100079c     	add	x28, x28, #0x1
40000640: 910202b5     	add	x21, x21, #0x80
40000644: eb08039f     	cmp	x28, x8
40000648: 540001ca     	b.ge	0x40000680 <launch_kedit+0x3e0>
4000064c: aa1503e0     	mov	x0, x21
40000650: 94000863     	bl	0x400027dc <kstrlen>
40000654: 0b0002d4     	add	w20, w22, w0
40000658: 710ffa9f     	cmp	w20, #0x3fe
4000065c: 54fffeec     	b.gt	0x40000638 <launch_kedit+0x398>
40000660: 910023e0     	add	x0, sp, #0x8
40000664: aa1503e1     	mov	x1, x21
40000668: 94000864     	bl	0x400027f8 <kstrcat>
4000066c: 910023e0     	add	x0, sp, #0x8
40000670: aa1903e1     	mov	x1, x25
40000674: 94000861     	bl	0x400027f8 <kstrcat>
40000678: 11000696     	add	w22, w20, #0x1
4000067c: 17ffffef     	b	0x40000638 <launch_kedit+0x398>
40000680: 910023e1     	add	x1, sp, #0x8
40000684: aa1303e0     	mov	x0, x19
40000688: 94001257     	bl	0x40004fe4 <vfs_write_file>
4000068c: b932527f     	str	wzr, [x19, #0x3250]
40000690: 5280003c     	mov	w28, #0x1               // =1
40000694: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
40000698: 91301e94     	add	x20, x20, #0xc07
4000069c: 14000040     	b	0x4000079c <launch_kedit+0x4fc>
400006a0: 94000c2c     	bl	0x40003750 <uart_getc>
400006a4: 12001c14     	and	w20, w0, #0xff
400006a8: 94000c2a     	bl	0x40003750 <uart_getc>
400006ac: 71016e9f     	cmp	w20, #0x5b
400006b0: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400006b4: 91301e94     	add	x20, x20, #0xc07
400006b8: 54000721     	b.ne	0x4000079c <launch_kedit+0x4fc>
400006bc: 12001c09     	and	w9, w0, #0xff
400006c0: b9424b68     	ldr	w8, [x27, #0x248]
400006c4: 7101053f     	cmp	w9, #0x41
400006c8: 54000801     	b.ne	0x400007c8 <launch_kedit+0x528>
400006cc: 7100011f     	cmp	w8, #0x0
400006d0: 540007cd     	b.le	0x400007c8 <launch_kedit+0x528>
400006d4: 12800009     	mov	w9, #-0x1               // =-1
400006d8: 0b090108     	add	w8, w8, w9
400006dc: b9024b68     	str	w8, [x27, #0x248]
400006e0: 93407d08     	sxtw	x8, w8
400006e4: 8b081e68     	add	x8, x19, x8, lsl #7
400006e8: 91010100     	add	x0, x8, #0x40
400006ec: 9400083c     	bl	0x400027dc <kstrlen>
400006f0: b9724668     	ldr	w8, [x19, #0x3244]
400006f4: 6b00011f     	cmp	w8, w0
400006f8: 5400052d     	b.le	0x4000079c <launch_kedit+0x4fc>
400006fc: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000700: b9024500     	str	w0, [x8, #0x244]
40000704: 14000026     	b	0x4000079c <launch_kedit+0x4fc>
40000708: 7100611f     	cmp	w8, #0x18
4000070c: 54000ac0     	b.eq	0x40000864 <launch_kedit+0x5c4>
40000710: 510082a8     	sub	w8, w21, #0x20
40000714: 12001d08     	and	w8, w8, #0xff
40000718: 7101791f     	cmp	w8, #0x5e
4000071c: 54000408     	b.hi	0x4000079c <launch_kedit+0x4fc>
40000720: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000724: b9424508     	ldr	w8, [x8, #0x244]
40000728: 7101f91f     	cmp	w8, #0x7e
4000072c: 5400038c     	b.gt	0x4000079c <launch_kedit+0x4fc>
40000730: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000734: 8b081e68     	add	x8, x19, x8, lsl #7
40000738: 91010100     	add	x0, x8, #0x40
4000073c: 94000828     	bl	0x400027dc <kstrlen>
40000740: b9b24668     	ldrsw	x8, [x19, #0x3244]
40000744: 6b00011f     	cmp	w8, w0
40000748: 540001ac     	b.gt	0x4000077c <launch_kedit+0x4dc>
4000074c: 93407c08     	sxtw	x8, w0
40000750: 91000509     	add	x9, x8, #0x1
40000754: 8b08026a     	add	x10, x19, x8
40000758: b9800748     	ldrsw	x8, [x26, #0x4]
4000075c: d1000529     	sub	x9, x9, #0x1
40000760: 8b081d48     	add	x8, x10, x8, lsl #7
40000764: d100054a     	sub	x10, x10, #0x1
40000768: 3941010b     	ldrb	w11, [x8, #0x40]
4000076c: 3901050b     	strb	w11, [x8, #0x41]
40000770: b9800348     	ldrsw	x8, [x26]
40000774: eb08013f     	cmp	x9, x8
40000778: 54ffff0c     	b.gt	0x40000758 <launch_kedit+0x4b8>
4000077c: b9b24a69     	ldrsw	x9, [x19, #0x3248]
40000780: 8b091e69     	add	x9, x19, x9, lsl #7
40000784: 8b080128     	add	x8, x9, x8
40000788: 39010115     	strb	w21, [x8, #0x40]
4000078c: b9724668     	ldr	w8, [x19, #0x3244]
40000790: b932527c     	str	w28, [x19, #0x3250]
40000794: 11000508     	add	w8, w8, #0x1
40000798: b9324668     	str	w8, [x19, #0x3244]
4000079c: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400007a0: 91092129     	add	x9, x9, #0x248
400007a4: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400007a8: 9104a6d6     	add	x22, x22, #0x129
400007ac: 29402528     	ldp	w8, w9, [x9]
400007b0: 6b09011f     	cmp	w8, w9
400007b4: 54ffe10b     	b.lt	0x400003d4 <launch_kedit+0x134>
400007b8: 11005129     	add	w9, w9, #0x14
400007bc: 6b09011f     	cmp	w8, w9
400007c0: 54ffe0eb     	b.lt	0x400003dc <launch_kedit+0x13c>
400007c4: 17ffff03     	b	0x400003d0 <launch_kedit+0x130>
400007c8: 71010d3f     	cmp	w9, #0x43
400007cc: 54000120     	b.eq	0x400007f0 <launch_kedit+0x550>
400007d0: 7101093f     	cmp	w9, #0x42
400007d4: 540002a1     	b.ne	0x40000828 <launch_kedit+0x588>
400007d8: b94242e9     	ldr	w9, [x23, #0x240]
400007dc: 51000529     	sub	w9, w9, #0x1
400007e0: 6b09011f     	cmp	w8, w9
400007e4: 54fff7ea     	b.ge	0x400006e0 <launch_kedit+0x440>
400007e8: 52800029     	mov	w9, #0x1                // =1
400007ec: 17ffffbb     	b	0x400006d8 <launch_kedit+0x438>
400007f0: 93407d08     	sxtw	x8, w8
400007f4: b9b24674     	ldrsw	x20, [x19, #0x3244]
400007f8: 8b081e68     	add	x8, x19, x8, lsl #7
400007fc: 91010100     	add	x0, x8, #0x40
40000800: 940007f7     	bl	0x400027dc <kstrlen>
40000804: eb14001f     	cmp	x0, x20
40000808: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
4000080c: 91301e94     	add	x20, x20, #0xc07
40000810: 54fffc69     	b.ls	0x4000079c <launch_kedit+0x4fc>
40000814: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40000818: b9424528     	ldr	w8, [x9, #0x244]
4000081c: 11000508     	add	w8, w8, #0x1
40000820: b9024528     	str	w8, [x9, #0x244]
40000824: 17ffffde     	b	0x4000079c <launch_kedit+0x4fc>
40000828: 12001c09     	and	w9, w0, #0xff
4000082c: 7101113f     	cmp	w9, #0x44
40000830: 54000101     	b.ne	0x40000850 <launch_kedit+0x5b0>
40000834: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40000838: b9424529     	ldr	w9, [x9, #0x244]
4000083c: 71000529     	subs	w9, w9, #0x1
40000840: 5400008b     	b.lt	0x40000850 <launch_kedit+0x5b0>
40000844: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000848: b9024509     	str	w9, [x8, #0x244]
4000084c: 17ffffd4     	b	0x4000079c <launch_kedit+0x4fc>
40000850: 51010409     	sub	w9, w0, #0x41
40000854: 12001d29     	and	w9, w9, #0xff
40000858: 7100093f     	cmp	w9, #0x2
4000085c: 54fff423     	b.lo	0x400006e0 <launch_kedit+0x440>
40000860: 17ffffcf     	b	0x4000079c <launch_kedit+0x4fc>
40000864: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000868: 911eac00     	add	x0, x0, #0x7ab
4000086c: 94000b85     	bl	0x40003680 <uart_puts>
40000870: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000874: 91206800     	add	x0, x0, #0x81a
40000878: 94000b82     	bl	0x40003680 <uart_puts>
4000087c: 911043ff     	add	sp, sp, #0x410
40000880: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40000884: a94457f6     	ldp	x22, x21, [sp, #0x40]
40000888: a9435ff8     	ldp	x24, x23, [sp, #0x30]
4000088c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40000890: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40000894: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40000898: d65f03c0     	ret

000000004000089c <print_banner>:
4000089c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400008a0: d503201f     	nop
400008a4: 3003c5e0     	adr	x0, 0x40008161 <__rodata_start+0x1161>
400008a8: 910003fd     	mov	x29, sp
400008ac: 94000b75     	bl	0x40003680 <uart_puts>
400008b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008b4: 91177400     	add	x0, x0, #0x5dd
400008b8: 94000b72     	bl	0x40003680 <uart_puts>
400008bc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008c0: 910c9000     	add	x0, x0, #0x324
400008c4: 94000b6f     	bl	0x40003680 <uart_puts>
400008c8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008cc: 9120e400     	add	x0, x0, #0x839
400008d0: 94000b6c     	bl	0x40003680 <uart_puts>
400008d4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008d8: 91334800     	add	x0, x0, #0xcd2
400008dc: 94000b69     	bl	0x40003680 <uart_puts>
400008e0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400008e4: 91009c00     	add	x0, x0, #0x27
400008e8: 94000b66     	bl	0x40003680 <uart_puts>
400008ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008f0: 91343400     	add	x0, x0, #0xd0d
400008f4: 94000b63     	bl	0x40003680 <uart_puts>
400008f8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400008fc: 9108ac00     	add	x0, x0, #0x22b
40000900: 94000b60     	bl	0x40003680 <uart_puts>
40000904: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000908: 913d5c00     	add	x0, x0, #0xf57
4000090c: 94000c72     	bl	0x40003ad4 <uart_printf>
40000910: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000914: 91179800     	add	x0, x0, #0x5e6
40000918: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000091c: 91182421     	add	x1, x1, #0x609
40000920: 94000c6d     	bl	0x40003ad4 <uart_printf>
40000924: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000928: 913b6800     	add	x0, x0, #0xeda
4000092c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000930: 91352421     	add	x1, x1, #0xd49
40000934: 94000c68     	bl	0x40003ad4 <uart_printf>
40000938: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000093c: 9128f800     	add	x0, x0, #0xa3e
40000940: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000944: 14000b4f     	b	0x40003680 <uart_puts>

0000000040000948 <print_about>:
40000948: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000094c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000950: 910acc00     	add	x0, x0, #0x2b3
40000954: 910003fd     	mov	x29, sp
40000958: 94000b4a     	bl	0x40003680 <uart_puts>
4000095c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000960: 91134800     	add	x0, x0, #0x4d2
40000964: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000968: 91356821     	add	x1, x1, #0xd5a
4000096c: 94000c5a     	bl	0x40003ad4 <uart_printf>
40000970: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000974: 91267000     	add	x0, x0, #0x99c
40000978: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000097c: 91182421     	add	x1, x1, #0x609
40000980: 94000c55     	bl	0x40003ad4 <uart_printf>
40000984: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000988: 910abc00     	add	x0, x0, #0x2af
4000098c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000990: 91352421     	add	x1, x1, #0xd49
40000994: 94000c50     	bl	0x40003ad4 <uart_printf>
40000998: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000099c: 913ca800     	add	x0, x0, #0xf2a
400009a0: 94000b38     	bl	0x40003680 <uart_puts>
400009a4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009a8: 91213400     	add	x0, x0, #0x84d
400009ac: 94000b35     	bl	0x40003680 <uart_puts>
400009b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009b4: 91177400     	add	x0, x0, #0x5dd
400009b8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009bc: 14000b31     	b	0x40003680 <uart_puts>

00000000400009c0 <print_sysinfo>:
400009c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400009c4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009c8: 91021c00     	add	x0, x0, #0x87
400009cc: a9014ff4     	stp	x20, x19, [sp, #0x10]
400009d0: 910003fd     	mov	x29, sp
400009d4: d5384248     	mrs	x8, CurrentEL
400009d8: d3420d13     	ubfx	x19, x8, #2, #2
400009dc: d5380014     	mrs	x20, MIDR_EL1
400009e0: 94000b28     	bl	0x40003680 <uart_puts>
400009e4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009e8: 91252800     	add	x0, x0, #0x94a
400009ec: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009f0: 91356821     	add	x1, x1, #0xd5a
400009f4: f0000022     	adrp	x2, 0x40007000 <__rodata_start>
400009f8: 91182442     	add	x2, x2, #0x609
400009fc: 94000c36     	bl	0x40003ad4 <uart_printf>
40000a00: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a04: 9125a400     	add	x0, x0, #0x969
40000a08: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a0c: 91352421     	add	x1, x1, #0xd49
40000a10: 94000c31     	bl	0x40003ad4 <uart_printf>
40000a14: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a18: 912efc00     	add	x0, x0, #0xbbf
40000a1c: 94000c2e     	bl	0x40003ad4 <uart_printf>
40000a20: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40000a24: 910b3108     	add	x8, x8, #0x2cc
40000a28: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000a2c: 913d7d29     	add	x9, x9, #0xf5f
40000a30: f1000a7f     	cmp	x19, #0x2
40000a34: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a38: 91189000     	add	x0, x0, #0x624
40000a3c: 9a880128     	csel	x8, x9, x8, eq
40000a40: f100067f     	cmp	x19, #0x1
40000a44: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000a48: 9121d129     	add	x9, x9, #0x874
40000a4c: 2a1303e1     	mov	w1, w19
40000a50: 9a880122     	csel	x2, x9, x8, eq
40000a54: 94000c20     	bl	0x40003ad4 <uart_printf>
40000a58: 53187e81     	lsr	w1, w20, #24
40000a5c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a60: 9113ac00     	add	x0, x0, #0x4eb
40000a64: aa1403e2     	mov	x2, x20
40000a68: 94000c1b     	bl	0x40003ad4 <uart_printf>
40000a6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a70: 912b8000     	add	x0, x0, #0xae0
40000a74: d503201f     	nop
40000a78: 10ffac41     	adr	x1, 0x40000000 <_start>
40000a7c: 94000c16     	bl	0x40003ad4 <uart_printf>
40000a80: d503201f     	nop
40000a84: 10ffabe1     	adr	x1, 0x40000000 <_start>
40000a88: d503201f     	nop
40000a8c: 1002c362     	adr	x2, 0x400062f8 <__text_end>
40000a90: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a94: 91303800     	add	x0, x0, #0xc0e
40000a98: cb010043     	sub	x3, x2, x1
40000a9c: 94000c0e     	bl	0x40003ad4 <uart_printf>
40000aa0: d503201f     	nop
40000aa4: 10032ae1     	adr	x1, 0x40007000 <__rodata_start>
40000aa8: d503201f     	nop
40000aac: 10045622     	adr	x2, 0x40009570 <__rodata_end>
40000ab0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ab4: 911b4400     	add	x0, x0, #0x6d1
40000ab8: cb010043     	sub	x3, x2, x1
40000abc: 94000c06     	bl	0x40003ad4 <uart_printf>
40000ac0: d503201f     	nop
40000ac4: 1004a9e1     	adr	x1, 0x4000a000 <next_pid>
40000ac8: d503201f     	nop
40000acc: 101c86a2     	adr	x2, 0x40039ba0
40000ad0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ad4: 912bf400     	add	x0, x0, #0xafd
40000ad8: cb010043     	sub	x3, x2, x1
40000adc: 94000bfe     	bl	0x40003ad4 <uart_printf>
40000ae0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ae4: 913ee400     	add	x0, x0, #0xfb9
40000ae8: d503201f     	nop
40000aec: 102485a1     	adr	x1, 0x40049ba0 <__stack_top>
40000af0: 94000bf9     	bl	0x40003ad4 <uart_printf>
40000af4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000af8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000afc: 91177400     	add	x0, x0, #0x5dd
40000b00: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b04: 14000adf     	b	0x40003680 <uart_puts>

0000000040000b08 <print_android_roadmap>:
40000b08: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b0c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b10: 913da800     	add	x0, x0, #0xf6a
40000b14: 910003fd     	mov	x29, sp
40000b18: 94000ada     	bl	0x40003680 <uart_puts>
40000b1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b20: 912be800     	add	x0, x0, #0xafa
40000b24: 94000ad7     	bl	0x40003680 <uart_puts>
40000b28: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b2c: 91191400     	add	x0, x0, #0x645
40000b30: 94000ad4     	bl	0x40003680 <uart_puts>
40000b34: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b38: 91260c00     	add	x0, x0, #0x983
40000b3c: 94000ad1     	bl	0x40003680 <uart_puts>
40000b40: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b44: 911bec00     	add	x0, x0, #0x6fb
40000b48: 94000ace     	bl	0x40003680 <uart_puts>
40000b4c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b50: 9105a400     	add	x0, x0, #0x169
40000b54: 94000acb     	bl	0x40003680 <uart_puts>
40000b58: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b5c: 9130e000     	add	x0, x0, #0xc38
40000b60: 94000ac8     	bl	0x40003680 <uart_puts>
40000b64: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b68: 910b6000     	add	x0, x0, #0x2d8
40000b6c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000b70: 14000ac4     	b	0x40003680 <uart_puts>

0000000040000b74 <read_line>:
40000b74: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000b78: f9000bf7     	str	x23, [sp, #0x10]
40000b7c: aa1f03f7     	mov	x23, xzr
40000b80: 910003fd     	mov	x29, sp
40000b84: a90257f6     	stp	x22, x21, [sp, #0x20]
40000b88: d1000435     	sub	x21, x1, #0x1
40000b8c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000b90: aa0003f3     	mov	x19, x0
40000b94: b0000054     	adrp	x20, 0x40009000 <__rodata_start+0x2000>
40000b98: 91124694     	add	x20, x20, #0x491
40000b9c: aa1703f6     	mov	x22, x23
40000ba0: 94000aec     	bl	0x40003750 <uart_getc>
40000ba4: 12001c08     	and	w8, w0, #0xff
40000ba8: 7100311f     	cmp	w8, #0xc
40000bac: 540000cc     	b.gt	0x40000bc4 <read_line+0x50>
40000bb0: 7100211f     	cmp	w8, #0x8
40000bb4: 54000240     	b.eq	0x40000bfc <read_line+0x88>
40000bb8: 7100291f     	cmp	w8, #0xa
40000bbc: 540000c1     	b.ne	0x40000bd4 <read_line+0x60>
40000bc0: 14000015     	b	0x40000c14 <read_line+0xa0>
40000bc4: 7100351f     	cmp	w8, #0xd
40000bc8: 54000260     	b.eq	0x40000c14 <read_line+0xa0>
40000bcc: 7101fd1f     	cmp	w8, #0x7f
40000bd0: 54000160     	b.eq	0x40000bfc <read_line+0x88>
40000bd4: 51008008     	sub	w8, w0, #0x20
40000bd8: 12001d08     	and	w8, w8, #0xff
40000bdc: 7101791f     	cmp	w8, #0x5e
40000be0: 54fffe08     	b.hi	0x40000ba0 <read_line+0x2c>
40000be4: eb1502df     	cmp	x22, x21
40000be8: 54fffdc2     	b.hs	0x40000ba0 <read_line+0x2c>
40000bec: 910006d7     	add	x23, x22, #0x1
40000bf0: 38366a60     	strb	w0, [x19, x22]
40000bf4: 94000a8c     	bl	0x40003624 <uart_putc>
40000bf8: 17ffffe9     	b	0x40000b9c <read_line+0x28>
40000bfc: aa1f03f7     	mov	x23, xzr
40000c00: b4fffcf6     	cbz	x22, 0x40000b9c <read_line+0x28>
40000c04: aa1403e0     	mov	x0, x20
40000c08: d10006d7     	sub	x23, x22, #0x1
40000c0c: 94000a9d     	bl	0x40003680 <uart_puts>
40000c10: 17ffffe3     	b	0x40000b9c <read_line+0x28>
40000c14: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c18: 913f6400     	add	x0, x0, #0xfd9
40000c1c: 94000a99     	bl	0x40003680 <uart_puts>
40000c20: 38366a7f     	strb	wzr, [x19, x22]
40000c24: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c28: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c2c: f9400bf7     	ldr	x23, [sp, #0x10]
40000c30: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000c34: d65f03c0     	ret

0000000040000c38 <print_help>:
40000c38: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000c3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c40: 91220000     	add	x0, x0, #0x880
40000c44: 910003fd     	mov	x29, sp
40000c48: 94000a8e     	bl	0x40003680 <uart_puts>
40000c4c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c50: 9115ec00     	add	x0, x0, #0x57b
40000c54: 94000a8b     	bl	0x40003680 <uart_puts>
40000c58: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c5c: 91223400     	add	x0, x0, #0x88d
40000c60: 94000a88     	bl	0x40003680 <uart_puts>
40000c64: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c68: 913f7000     	add	x0, x0, #0xfdc
40000c6c: 94000a85     	bl	0x40003680 <uart_puts>
40000c70: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c74: 9102ac00     	add	x0, x0, #0xab
40000c78: 94000a82     	bl	0x40003680 <uart_puts>
40000c7c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c80: 91359400     	add	x0, x0, #0xd65
40000c84: 94000a7f     	bl	0x40003680 <uart_puts>
40000c88: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000c8c: 910c8c00     	add	x0, x0, #0x323
40000c90: 94000a7c     	bl	0x40003680 <uart_puts>
40000c94: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c98: 911d1800     	add	x0, x0, #0x746
40000c9c: 94000a79     	bl	0x40003680 <uart_puts>
40000ca0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ca4: 9118c800     	add	x0, x0, #0x632
40000ca8: 94000a76     	bl	0x40003680 <uart_puts>
40000cac: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000cb0: 910da400     	add	x0, x0, #0x369
40000cb4: 94000a73     	bl	0x40003680 <uart_puts>
40000cb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cbc: 9119cc00     	add	x0, x0, #0x673
40000cc0: 94000a70     	bl	0x40003680 <uart_puts>
40000cc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cc8: 9131fc00     	add	x0, x0, #0xc7f
40000ccc: 94000a6d     	bl	0x40003680 <uart_puts>
40000cd0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cd4: 9104b800     	add	x0, x0, #0x12e
40000cd8: 94000a6a     	bl	0x40003680 <uart_puts>
40000cdc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ce0: 913e8800     	add	x0, x0, #0xfa2
40000ce4: 94000a67     	bl	0x40003680 <uart_puts>
40000ce8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cec: 91232400     	add	x0, x0, #0x8c9
40000cf0: 94000a64     	bl	0x40003680 <uart_puts>
40000cf4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cf8: 912cec00     	add	x0, x0, #0xb3b
40000cfc: 94000a61     	bl	0x40003680 <uart_puts>
40000d00: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d04: 91034800     	add	x0, x0, #0xd2
40000d08: 94000a5e     	bl	0x40003680 <uart_puts>
40000d0c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d10: 91144800     	add	x0, x0, #0x512
40000d14: 94000a5b     	bl	0x40003680 <uart_puts>
40000d18: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d1c: 91125400     	add	x0, x0, #0x495
40000d20: 94000a58     	bl	0x40003680 <uart_puts>
40000d24: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d28: 910d7c00     	add	x0, x0, #0x35f
40000d2c: 94000a55     	bl	0x40003680 <uart_puts>
40000d30: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d34: 910b5400     	add	x0, x0, #0x2d5
40000d38: 94000a52     	bl	0x40003680 <uart_puts>
40000d3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d40: 9106dc00     	add	x0, x0, #0x1b7
40000d44: 94000a4f     	bl	0x40003680 <uart_puts>
40000d48: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d4c: 913f6c00     	add	x0, x0, #0xfdb
40000d50: 94000a4c     	bl	0x40003680 <uart_puts>
40000d54: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d58: 911ad400     	add	x0, x0, #0x6b5
40000d5c: 94000a49     	bl	0x40003680 <uart_puts>
40000d60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d64: 910e8c00     	add	x0, x0, #0x3a3
40000d68: 94000a46     	bl	0x40003680 <uart_puts>
40000d6c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d70: 91122000     	add	x0, x0, #0x488
40000d74: 94000a43     	bl	0x40003680 <uart_puts>
40000d78: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d7c: 91137800     	add	x0, x0, #0x4de
40000d80: 94000a40     	bl	0x40003680 <uart_puts>
40000d84: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d88: 911de800     	add	x0, x0, #0x77a
40000d8c: 94000a3d     	bl	0x40003680 <uart_puts>
40000d90: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d94: 9132ac00     	add	x0, x0, #0xcab
40000d98: 94000a3a     	bl	0x40003680 <uart_puts>
40000d9c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000da0: 91058000     	add	x0, x0, #0x160
40000da4: 94000a37     	bl	0x40003680 <uart_puts>
40000da8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000dac: 91007400     	add	x0, x0, #0x1d
40000db0: 94000a34     	bl	0x40003680 <uart_puts>
40000db4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000db8: 91290800     	add	x0, x0, #0xa42
40000dbc: 94000a31     	bl	0x40003680 <uart_puts>
40000dc0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dc4: 91157000     	add	x0, x0, #0x55c
40000dc8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000dcc: 14000a2d     	b	0x40003680 <uart_puts>

0000000040000dd0 <execute_command>:
40000dd0: d104c3ff     	sub	sp, sp, #0x130
40000dd4: a9124ff4     	stp	x20, x19, [sp, #0x120]
40000dd8: aa0003f3     	mov	x19, x0
40000ddc: aa1f03e8     	mov	x8, xzr
40000de0: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
40000de4: 910383fd     	add	x29, sp, #0xe0
40000de8: f9007bfc     	str	x28, [sp, #0xf0]
40000dec: a9105ff8     	stp	x24, x23, [sp, #0x100]
40000df0: a91157f6     	stp	x22, x21, [sp, #0x110]
40000df4: 38686a6a     	ldrb	w10, [x19, x8]
40000df8: 91000508     	add	x8, x8, #0x1
40000dfc: 7100815f     	cmp	w10, #0x20
40000e00: 54ffffa0     	b.eq	0x40000df4 <execute_command+0x24>
40000e04: aa1f03e9     	mov	x9, xzr
40000e08: d10083ab     	sub	x11, x29, #0x20
40000e0c: 340001aa     	cbz	w10, 0x40000e40 <execute_command+0x70>
40000e10: f100793f     	cmp	x9, #0x1e
40000e14: 54000168     	b.hi	0x40000e40 <execute_command+0x70>
40000e18: 8b09026c     	add	x12, x19, x9
40000e1c: 3829696a     	strb	w10, [x11, x9]
40000e20: 3868698a     	ldrb	w10, [x12, x8]
40000e24: 9100052c     	add	x12, x9, #0x1
40000e28: aa0c03e9     	mov	x9, x12
40000e2c: 7100815f     	cmp	w10, #0x20
40000e30: 54fffee1     	b.ne	0x40000e0c <execute_command+0x3c>
40000e34: 8b0c0108     	add	x8, x8, x12
40000e38: aa0c03e9     	mov	x9, x12
40000e3c: 14000002     	b	0x40000e44 <execute_command+0x74>
40000e40: 8b090108     	add	x8, x8, x9
40000e44: d1000508     	sub	x8, x8, #0x1
40000e48: d10083aa     	sub	x10, x29, #0x20
40000e4c: 8b080268     	add	x8, x19, x8
40000e50: 3829695f     	strb	wzr, [x10, x9]
40000e54: 38401509     	ldrb	w9, [x8], #0x1
40000e58: 7100813f     	cmp	w9, #0x20
40000e5c: 54ffffc0     	b.eq	0x40000e54 <execute_command+0x84>
40000e60: 35000069     	cbnz	w9, 0x40000e6c <execute_command+0x9c>
40000e64: aa1f03ec     	mov	x12, xzr
40000e68: 1400000a     	b	0x40000e90 <execute_command+0xc0>
40000e6c: aa1f03ea     	mov	x10, xzr
40000e70: 910103eb     	add	x11, sp, #0x40
40000e74: 382a6969     	strb	w9, [x11, x10]
40000e78: 386a6909     	ldrb	w9, [x8, x10]
40000e7c: 9100054c     	add	x12, x10, #0x1
40000e80: 34000089     	cbz	w9, 0x40000e90 <execute_command+0xc0>
40000e84: f101f95f     	cmp	x10, #0x7e
40000e88: aa0c03ea     	mov	x10, x12
40000e8c: 54ffff43     	b.lo	0x40000e74 <execute_command+0xa4>
40000e90: 910103e8     	add	x8, sp, #0x40
40000e94: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000e98: 911f0821     	add	x1, x1, #0x7c2
40000e9c: d10083a0     	sub	x0, x29, #0x20
40000ea0: 382c691f     	strb	wzr, [x8, x12]
40000ea4: 9400065e     	bl	0x4000281c <kstrcmp>
40000ea8: 34001400     	cbz	w0, 0x40001128 <execute_command+0x358>
40000eac: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000eb0: 91264821     	add	x1, x1, #0x992
40000eb4: d10083a0     	sub	x0, x29, #0x20
40000eb8: 94000659     	bl	0x4000281c <kstrcmp>
40000ebc: 340013a0     	cbz	w0, 0x40001130 <execute_command+0x360>
40000ec0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ec4: 91041421     	add	x1, x1, #0x105
40000ec8: d10083a0     	sub	x0, x29, #0x20
40000ecc: 94000654     	bl	0x4000281c <kstrcmp>
40000ed0: 34001680     	cbz	w0, 0x400011a0 <execute_command+0x3d0>
40000ed4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ed8: 912dec21     	add	x1, x1, #0xb7b
40000edc: d10083a0     	sub	x0, x29, #0x20
40000ee0: 9400064f     	bl	0x4000281c <kstrcmp>
40000ee4: 34001800     	cbz	w0, 0x400011e4 <execute_command+0x414>
40000ee8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000eec: 910d4c21     	add	x1, x1, #0x353
40000ef0: d10083a0     	sub	x0, x29, #0x20
40000ef4: 9400064a     	bl	0x4000281c <kstrcmp>
40000ef8: 34001860     	cbz	w0, 0x40001204 <execute_command+0x434>
40000efc: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f00: 9123b021     	add	x1, x1, #0x8ec
40000f04: d10083a0     	sub	x0, x29, #0x20
40000f08: 94000645     	bl	0x4000281c <kstrcmp>
40000f0c: 34001900     	cbz	w0, 0x4000122c <execute_command+0x45c>
40000f10: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f14: 912fc021     	add	x1, x1, #0xbf0
40000f18: d10083a0     	sub	x0, x29, #0x20
40000f1c: 94000640     	bl	0x4000281c <kstrcmp>
40000f20: 34001960     	cbz	w0, 0x4000124c <execute_command+0x47c>
40000f24: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f28: 91042421     	add	x1, x1, #0x109
40000f2c: d10083a0     	sub	x0, x29, #0x20
40000f30: 9400063b     	bl	0x4000281c <kstrcmp>
40000f34: 34001880     	cbz	w0, 0x40001244 <execute_command+0x474>
40000f38: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f3c: 91235021     	add	x1, x1, #0x8d4
40000f40: d10083a0     	sub	x0, x29, #0x20
40000f44: 94000636     	bl	0x4000281c <kstrcmp>
40000f48: 340017e0     	cbz	w0, 0x40001244 <execute_command+0x474>
40000f4c: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f50: 9129cc21     	add	x1, x1, #0xa73
40000f54: d10083a0     	sub	x0, x29, #0x20
40000f58: 94000631     	bl	0x4000281c <kstrcmp>
40000f5c: 34001960     	cbz	w0, 0x40001288 <execute_command+0x4b8>
40000f60: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f64: 91165821     	add	x1, x1, #0x596
40000f68: d10083a0     	sub	x0, x29, #0x20
40000f6c: 9400062c     	bl	0x4000281c <kstrcmp>
40000f70: 34001900     	cbz	w0, 0x40001290 <execute_command+0x4c0>
40000f74: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f78: 910eb021     	add	x1, x1, #0x3ac
40000f7c: d10083a0     	sub	x0, x29, #0x20
40000f80: 94000627     	bl	0x4000281c <kstrcmp>
40000f84: 34001aa0     	cbz	w0, 0x400012d8 <execute_command+0x508>
40000f88: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f8c: 91131421     	add	x1, x1, #0x4c5
40000f90: d10083a0     	sub	x0, x29, #0x20
40000f94: 94000622     	bl	0x4000281c <kstrcmp>
40000f98: 34001b80     	cbz	w0, 0x40001308 <execute_command+0x538>
40000f9c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fa0: 911b4c21     	add	x1, x1, #0x6d3
40000fa4: d10083a0     	sub	x0, x29, #0x20
40000fa8: 9400061d     	bl	0x4000281c <kstrcmp>
40000fac: 34001dc0     	cbz	w0, 0x40001364 <execute_command+0x594>
40000fb0: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fb4: 912dc821     	add	x1, x1, #0xb72
40000fb8: d10083a0     	sub	x0, x29, #0x20
40000fbc: 94000618     	bl	0x4000281c <kstrcmp>
40000fc0: 340020e0     	cbz	w0, 0x400013dc <execute_command+0x60c>
40000fc4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fc8: 911b6821     	add	x1, x1, #0x6da
40000fcc: d10083a0     	sub	x0, x29, #0x20
40000fd0: 94000613     	bl	0x4000281c <kstrcmp>
40000fd4: 34001e20     	cbz	w0, 0x40001398 <execute_command+0x5c8>
40000fd8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fdc: 9136a421     	add	x1, x1, #0xda9
40000fe0: d10083a0     	sub	x0, x29, #0x20
40000fe4: 9400060e     	bl	0x4000281c <kstrcmp>
40000fe8: 34001d80     	cbz	w0, 0x40001398 <execute_command+0x5c8>
40000fec: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ff0: 91007c21     	add	x1, x1, #0x1f
40000ff4: d10083a0     	sub	x0, x29, #0x20
40000ff8: 94000609     	bl	0x4000281c <kstrcmp>
40000ffc: 340021a0     	cbz	w0, 0x40001430 <execute_command+0x660>
40001000: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001004: 910d5821     	add	x1, x1, #0x356
40001008: d10083a0     	sub	x0, x29, #0x20
4000100c: 94000604     	bl	0x4000281c <kstrcmp>
40001010: 34002260     	cbz	w0, 0x4000145c <execute_command+0x68c>
40001014: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001018: 910b2021     	add	x1, x1, #0x2c8
4000101c: d10083a0     	sub	x0, x29, #0x20
40001020: 940005ff     	bl	0x4000281c <kstrcmp>
40001024: 34002340     	cbz	w0, 0x4000148c <execute_command+0x6bc>
40001028: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000102c: 91172421     	add	x1, x1, #0x5c9
40001030: d10083a0     	sub	x0, x29, #0x20
40001034: 940005fa     	bl	0x4000281c <kstrcmp>
40001038: 340023e0     	cbz	w0, 0x400014b4 <execute_command+0x6e4>
4000103c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001040: 911fc021     	add	x1, x1, #0x7f0
40001044: d10083a0     	sub	x0, x29, #0x20
40001048: 940005f5     	bl	0x4000281c <kstrcmp>
4000104c: 34002520     	cbz	w0, 0x400014f0 <execute_command+0x720>
40001050: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001054: 9108f421     	add	x1, x1, #0x23d
40001058: d10083a0     	sub	x0, x29, #0x20
4000105c: 940005f0     	bl	0x4000281c <kstrcmp>
40001060: 34002720     	cbz	w0, 0x40001544 <execute_command+0x774>
40001064: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001068: 910b3821     	add	x1, x1, #0x2ce
4000106c: d10083a0     	sub	x0, x29, #0x20
40001070: 940005eb     	bl	0x4000281c <kstrcmp>
40001074: 34002600     	cbz	w0, 0x40001534 <execute_command+0x764>
40001078: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000107c: 911fd821     	add	x1, x1, #0x7f6
40001080: d10083a0     	sub	x0, x29, #0x20
40001084: 940005e6     	bl	0x4000281c <kstrcmp>
40001088: 34002560     	cbz	w0, 0x40001534 <execute_command+0x764>
4000108c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001090: 91173c21     	add	x1, x1, #0x5cf
40001094: d10083a0     	sub	x0, x29, #0x20
40001098: 940005e1     	bl	0x4000281c <kstrcmp>
4000109c: 34002aa0     	cbz	w0, 0x400015f0 <execute_command+0x820>
400010a0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010a4: 91044021     	add	x1, x1, #0x110
400010a8: d10083a0     	sub	x0, x29, #0x20
400010ac: 940005dc     	bl	0x4000281c <kstrcmp>
400010b0: 34002a00     	cbz	w0, 0x400015f0 <execute_command+0x820>
400010b4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010b8: 91085c21     	add	x1, x1, #0x217
400010bc: d10083a0     	sub	x0, x29, #0x20
400010c0: 940005d7     	bl	0x4000281c <kstrcmp>
400010c4: 34002aa0     	cbz	w0, 0x40001618 <execute_command+0x848>
400010c8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010cc: 91276c21     	add	x1, x1, #0x9db
400010d0: d10083a0     	sub	x0, x29, #0x20
400010d4: 940005d2     	bl	0x4000281c <kstrcmp>
400010d8: 34003080     	cbz	w0, 0x400016e8 <execute_command+0x918>
400010dc: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
400010e0: 91140021     	add	x1, x1, #0x500
400010e4: d10083a0     	sub	x0, x29, #0x20
400010e8: 940005cd     	bl	0x4000281c <kstrcmp>
400010ec: 34002ee0     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
400010f0: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
400010f4: 91047021     	add	x1, x1, #0x11c
400010f8: d10083a0     	sub	x0, x29, #0x20
400010fc: 940005c8     	bl	0x4000281c <kstrcmp>
40001100: 34002e40     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
40001104: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001108: 912e2c21     	add	x1, x1, #0xb8b
4000110c: d10083a0     	sub	x0, x29, #0x20
40001110: 940005c3     	bl	0x4000281c <kstrcmp>
40001114: 34002da0     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
40001118: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000111c: 91048400     	add	x0, x0, #0x121
40001120: d10083a1     	sub	x1, x29, #0x20
40001124: 140000b4     	b	0x400013f4 <execute_command+0x624>
40001128: 97fffec4     	bl	0x40000c38 <print_help>
4000112c: 1400002f     	b	0x400011e8 <execute_command+0x418>
40001130: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001134: 910acc00     	add	x0, x0, #0x2b3
40001138: 94000952     	bl	0x40003680 <uart_puts>
4000113c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001140: 91134800     	add	x0, x0, #0x4d2
40001144: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001148: 91356821     	add	x1, x1, #0xd5a
4000114c: 94000a62     	bl	0x40003ad4 <uart_printf>
40001150: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001154: 91267000     	add	x0, x0, #0x99c
40001158: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000115c: 91182421     	add	x1, x1, #0x609
40001160: 94000a5d     	bl	0x40003ad4 <uart_printf>
40001164: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001168: 910abc00     	add	x0, x0, #0x2af
4000116c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001170: 91352421     	add	x1, x1, #0xd49
40001174: 94000a58     	bl	0x40003ad4 <uart_printf>
40001178: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000117c: 913ca800     	add	x0, x0, #0xf2a
40001180: 94000940     	bl	0x40003680 <uart_puts>
40001184: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001188: 91213400     	add	x0, x0, #0x84d
4000118c: 9400093d     	bl	0x40003680 <uart_puts>
40001190: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001194: 91177400     	add	x0, x0, #0x5dd
40001198: 9400093a     	bl	0x40003680 <uart_puts>
4000119c: 14000013     	b	0x400011e8 <execute_command+0x418>
400011a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011a4: 9136d800     	add	x0, x0, #0xdb6
400011a8: 94000936     	bl	0x40003680 <uart_puts>
400011ac: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011b0: 910c2000     	add	x0, x0, #0x308
400011b4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400011b8: 91182421     	add	x1, x1, #0x609
400011bc: 94000a46     	bl	0x40003ad4 <uart_printf>
400011c0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011c4: 912c9c00     	add	x0, x0, #0xb27
400011c8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011cc: 91352421     	add	x1, x1, #0xd49
400011d0: 94000a41     	bl	0x40003ad4 <uart_printf>
400011d4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011d8: 91067000     	add	x0, x0, #0x19c
400011dc: 94000929     	bl	0x40003680 <uart_puts>
400011e0: 14000002     	b	0x400011e8 <execute_command+0x418>
400011e4: 97fffdf7     	bl	0x400009c0 <print_sysinfo>
400011e8: a9524ff4     	ldp	x20, x19, [sp, #0x120]
400011ec: f9407bfc     	ldr	x28, [sp, #0xf0]
400011f0: a95157f6     	ldp	x22, x21, [sp, #0x110]
400011f4: a9505ff8     	ldp	x24, x23, [sp, #0x100]
400011f8: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
400011fc: 9104c3ff     	add	sp, sp, #0x130
40001200: d65f03c0     	ret
40001204: 910103e0     	add	x0, sp, #0x40
40001208: 94000575     	bl	0x400027dc <kstrlen>
4000120c: b4000260     	cbz	x0, 0x40001258 <execute_command+0x488>
40001210: 910103e0     	add	x0, sp, #0x40
40001214: 94000f75     	bl	0x40004fe8 <vfs_remove>
40001218: 34000280     	cbz	w0, 0x40001268 <execute_command+0x498>
4000121c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001220: 9103bc00     	add	x0, x0, #0xef
40001224: 94000917     	bl	0x40003680 <uart_puts>
40001228: 17fffff0     	b	0x400011e8 <execute_command+0x418>
4000122c: 910103e0     	add	x0, sp, #0x40
40001230: 9400056b     	bl	0x400027dc <kstrlen>
40001234: b4000220     	cbz	x0, 0x40001278 <execute_command+0x4a8>
40001238: 910103e0     	add	x0, sp, #0x40
4000123c: 97fffc19     	bl	0x400002a0 <launch_kedit>
40001240: 17ffffea     	b	0x400011e8 <execute_command+0x418>
40001244: 94000639     	bl	0x40002b28 <tui_launch>
40001248: 17ffffe8     	b	0x400011e8 <execute_command+0x418>
4000124c: 910103e0     	add	x0, sp, #0x40
40001250: 94000202     	bl	0x40001a58 <kproj_execute>
40001254: 17ffffe5     	b	0x400011e8 <execute_command+0x418>
40001258: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000125c: 911a4000     	add	x0, x0, #0x690
40001260: 94000908     	bl	0x40003680 <uart_puts>
40001264: 17ffffe1     	b	0x400011e8 <execute_command+0x418>
40001268: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000126c: 91274400     	add	x0, x0, #0x9d1
40001270: 94000904     	bl	0x40003680 <uart_puts>
40001274: 17ffffdd     	b	0x400011e8 <execute_command+0x418>
40001278: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000127c: 91336000     	add	x0, x0, #0xcd8
40001280: 94000900     	bl	0x40003680 <uart_puts>
40001284: 17ffffd9     	b	0x400011e8 <execute_command+0x418>
40001288: 94000336     	bl	0x40001f60 <launch_ktop>
4000128c: 17ffffd7     	b	0x400011e8 <execute_command+0x418>
40001290: 910103e0     	add	x0, sp, #0x40
40001294: 94000552     	bl	0x400027dc <kstrlen>
40001298: b40004c0     	cbz	x0, 0x40001330 <execute_command+0x560>
4000129c: 394103e8     	ldrb	w8, [sp, #0x40]
400012a0: 5100c109     	sub	w9, w8, #0x30
400012a4: 7100253f     	cmp	w9, #0x9
400012a8: 540004c8     	b.hi	0x40001340 <execute_command+0x570>
400012ac: 910103e9     	add	x9, sp, #0x40
400012b0: 2a1f03f3     	mov	w19, wzr
400012b4: 5280014a     	mov	w10, #0xa               // =10
400012b8: b2400129     	orr	x9, x9, #0x1
400012bc: 1b0a226b     	madd	w11, w19, w10, w8
400012c0: 38401528     	ldrb	w8, [x9], #0x1
400012c4: 5100c10c     	sub	w12, w8, #0x30
400012c8: 7100299f     	cmp	w12, #0xa
400012cc: 5100c173     	sub	w19, w11, #0x30
400012d0: 54ffff63     	b.lo	0x400012bc <execute_command+0x4ec>
400012d4: 1400001c     	b	0x40001344 <execute_command+0x574>
400012d8: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400012dc: 9123c821     	add	x1, x1, #0x8f2
400012e0: aa1303e0     	mov	x0, x19
400012e4: 940005b8     	bl	0x400029c4 <kstrstr>
400012e8: b4000460     	cbz	x0, 0x40001374 <execute_command+0x5a4>
400012ec: 3900001f     	strb	wzr, [x0]
400012f0: 38401c08     	ldrb	w8, [x0, #0x1]!
400012f4: 7100811f     	cmp	w8, #0x20
400012f8: 54ffffc0     	b.eq	0x400012f0 <execute_command+0x520>
400012fc: 91001661     	add	x1, x19, #0x5
40001300: 94000f39     	bl	0x40004fe4 <vfs_write_file>
40001304: 17ffffb9     	b	0x400011e8 <execute_command+0x418>
40001308: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000130c: 91043421     	add	x1, x1, #0x10d
40001310: 910103e0     	add	x0, sp, #0x40
40001314: 94000542     	bl	0x4000281c <kstrcmp>
40001318: 34000720     	cbz	w0, 0x400013fc <execute_command+0x62c>
4000131c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001320: 911b3400     	add	x0, x0, #0x6cd
40001324: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001328: 91356821     	add	x1, x1, #0xd5a
4000132c: 14000032     	b	0x400013f4 <execute_command+0x624>
40001330: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001334: 910fa400     	add	x0, x0, #0x3e9
40001338: 940008d2     	bl	0x40003680 <uart_puts>
4000133c: 17ffffab     	b	0x400011e8 <execute_command+0x418>
40001340: 2a1f03f3     	mov	w19, wzr
40001344: 2a1303e0     	mov	w0, w19
40001348: 94000271     	bl	0x40001d0c <process_kill>
4000134c: 3100041f     	cmn	w0, #0x1
40001350: 540001a0     	b.eq	0x40001384 <execute_command+0x5b4>
40001354: 35fff4a0     	cbnz	w0, 0x400011e8 <execute_command+0x418>
40001358: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000135c: 91395c00     	add	x0, x0, #0xe57
40001360: 1400000b     	b	0x4000138c <execute_command+0x5bc>
40001364: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001368: 9139ac00     	add	x0, x0, #0xe6b
4000136c: 940008c5     	bl	0x40003680 <uart_puts>
40001370: 17ffff9e     	b	0x400011e8 <execute_command+0x418>
40001374: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001378: 911b3400     	add	x0, x0, #0x6cd
4000137c: 910103e1     	add	x1, sp, #0x40
40001380: 1400001d     	b	0x400013f4 <execute_command+0x624>
40001384: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001388: 911a9800     	add	x0, x0, #0x6a6
4000138c: 2a1303e1     	mov	w1, w19
40001390: 940009d1     	bl	0x40003ad4 <uart_printf>
40001394: 17ffff95     	b	0x400011e8 <execute_command+0x418>
40001398: 94000d46     	bl	0x400048b0 <vfs_get_cwd>
4000139c: aa0003f3     	mov	x19, x0
400013a0: 910103e0     	add	x0, sp, #0x40
400013a4: 9400050e     	bl	0x400027dc <kstrlen>
400013a8: b40003e0     	cbz	x0, 0x40001424 <execute_command+0x654>
400013ac: 910103e0     	add	x0, sp, #0x40
400013b0: 94000d92     	bl	0x400049f8 <vfs_find>
400013b4: b40004c0     	cbz	x0, 0x4000144c <execute_command+0x67c>
400013b8: b9402008     	ldr	w8, [x0, #0x20]
400013bc: 35000368     	cbnz	w8, 0x40001428 <execute_command+0x658>
400013c0: b9402801     	ldr	w1, [x0, #0x28]
400013c4: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
400013c8: 9116c508     	add	x8, x8, #0x5b1
400013cc: aa0003e2     	mov	x2, x0
400013d0: aa0803e0     	mov	x0, x8
400013d4: 940009c0     	bl	0x40003ad4 <uart_printf>
400013d8: 17ffff84     	b	0x400011e8 <execute_command+0x418>
400013dc: 910003e0     	mov	x0, sp
400013e0: 52800801     	mov	w1, #0x40               // =64
400013e4: 94000d36     	bl	0x400048bc <vfs_getcwd>
400013e8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013ec: 911b3400     	add	x0, x0, #0x6cd
400013f0: 910003e1     	mov	x1, sp
400013f4: 940009b8     	bl	0x40003ad4 <uart_printf>
400013f8: 17ffff7c     	b	0x400011e8 <execute_command+0x418>
400013fc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001400: 911f0400     	add	x0, x0, #0x7c1
40001404: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001408: 91356821     	add	x1, x1, #0xd5a
4000140c: d0000022     	adrp	x2, 0x40007000 <__rodata_start>
40001410: 91182442     	add	x2, x2, #0x609
40001414: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x1000>
40001418: 91352463     	add	x3, x3, #0xd49
4000141c: 940009ae     	bl	0x40003ad4 <uart_printf>
40001420: 17ffff72     	b	0x400011e8 <execute_command+0x418>
40001424: aa1303e0     	mov	x0, x19
40001428: 94000f29     	bl	0x400050cc <vfs_list_dir>
4000142c: 17ffff6f     	b	0x400011e8 <execute_command+0x418>
40001430: 910103e0     	add	x0, sp, #0x40
40001434: 94000dd6     	bl	0x40004b8c <vfs_chdir>
40001438: 34ffed80     	cbz	w0, 0x400011e8 <execute_command+0x418>
4000143c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001440: 9107cc00     	add	x0, x0, #0x1f3
40001444: 910103e1     	add	x1, sp, #0x40
40001448: 17ffffeb     	b	0x400013f4 <execute_command+0x624>
4000144c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001450: 910ff000     	add	x0, x0, #0x3fc
40001454: 910103e1     	add	x1, sp, #0x40
40001458: 17ffffe7     	b	0x400013f4 <execute_command+0x624>
4000145c: 910103e0     	add	x0, sp, #0x40
40001460: 940004df     	bl	0x400027dc <kstrlen>
40001464: b40003e0     	cbz	x0, 0x400014e0 <execute_command+0x710>
40001468: 910103e0     	add	x0, sp, #0x40
4000146c: 94000d63     	bl	0x400049f8 <vfs_find>
40001470: b4000060     	cbz	x0, 0x4000147c <execute_command+0x6ac>
40001474: b9402008     	ldr	w8, [x0, #0x20]
40001478: 34000a28     	cbz	w8, 0x400015bc <execute_command+0x7ec>
4000147c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001480: 910d6800     	add	x0, x0, #0x35a
40001484: 9400087f     	bl	0x40003680 <uart_puts>
40001488: 17ffff58     	b	0x400011e8 <execute_command+0x418>
4000148c: 910103e0     	add	x0, sp, #0x40
40001490: 940004d3     	bl	0x400027dc <kstrlen>
40001494: b4000480     	cbz	x0, 0x40001524 <execute_command+0x754>
40001498: 910103e0     	add	x0, sp, #0x40
4000149c: 94000de1     	bl	0x40004c20 <vfs_mkdir>
400014a0: 34ffea40     	cbz	w0, 0x400011e8 <execute_command+0x418>
400014a4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014a8: 913a5000     	add	x0, x0, #0xe94
400014ac: 94000875     	bl	0x40003680 <uart_puts>
400014b0: 17ffff4e     	b	0x400011e8 <execute_command+0x418>
400014b4: 910103e0     	add	x0, sp, #0x40
400014b8: 940004c9     	bl	0x400027dc <kstrlen>
400014bc: b40008a0     	cbz	x0, 0x400015d0 <execute_command+0x800>
400014c0: 910103e0     	add	x0, sp, #0x40
400014c4: aa1f03e1     	mov	x1, xzr
400014c8: 94000e2c     	bl	0x40004d78 <vfs_touch>
400014cc: 34ffe8e0     	cbz	w0, 0x400011e8 <execute_command+0x418>
400014d0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400014d4: 91043400     	add	x0, x0, #0x10d
400014d8: 9400086a     	bl	0x40003680 <uart_puts>
400014dc: 17ffff43     	b	0x400011e8 <execute_command+0x418>
400014e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400014e4: 91014000     	add	x0, x0, #0x50
400014e8: 94000866     	bl	0x40003680 <uart_puts>
400014ec: 17ffff3f     	b	0x400011e8 <execute_command+0x418>
400014f0: 910103e0     	add	x0, sp, #0x40
400014f4: 52800401     	mov	w1, #0x20               // =32
400014f8: 9400054e     	bl	0x40002a30 <kstrchr>
400014fc: b4000720     	cbz	x0, 0x400015e0 <execute_command+0x810>
40001500: aa0003e1     	mov	x1, x0
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 3800143f     	strb	wzr, [x1], #0x1
4000150c: 94000eb6     	bl	0x40004fe4 <vfs_write_file>
40001510: 34ffe6c0     	cbz	w0, 0x400011e8 <execute_command+0x418>
40001514: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001518: 91132c00     	add	x0, x0, #0x4cb
4000151c: 94000859     	bl	0x40003680 <uart_puts>
40001520: 17ffff32     	b	0x400011e8 <execute_command+0x418>
40001524: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001528: 9110e000     	add	x0, x0, #0x438
4000152c: 94000855     	bl	0x40003680 <uart_puts>
40001530: 17ffff2e     	b	0x400011e8 <execute_command+0x418>
40001534: d503201f     	nop
40001538: 30036140     	adr	x0, 0x40008161 <__rodata_start+0x1161>
4000153c: 94000851     	bl	0x40003680 <uart_puts>
40001540: 17ffff2a     	b	0x400011e8 <execute_command+0x418>
40001544: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001548: 91177400     	add	x0, x0, #0x5dd
4000154c: 9400084d     	bl	0x40003680 <uart_puts>
40001550: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001554: 912fd800     	add	x0, x0, #0xbf6
40001558: 9400084a     	bl	0x40003680 <uart_puts>
4000155c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001560: 91018800     	add	x0, x0, #0x62
40001564: 94000847     	bl	0x40003680 <uart_puts>
40001568: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000156c: 912e0c00     	add	x0, x0, #0xb83
40001570: 94000844     	bl	0x40003680 <uart_puts>
40001574: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001578: 91136800     	add	x0, x0, #0x4da
4000157c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001580: 91352421     	add	x1, x1, #0xd49
40001584: 94000954     	bl	0x40003ad4 <uart_printf>
40001588: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000158c: 911b7400     	add	x0, x0, #0x6dd
40001590: 9400083c     	bl	0x40003680 <uart_puts>
40001594: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001598: 910ec400     	add	x0, x0, #0x3b1
4000159c: 94000839     	bl	0x40003680 <uart_puts>
400015a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015a4: 91113400     	add	x0, x0, #0x44d
400015a8: 94000836     	bl	0x40003680 <uart_puts>
400015ac: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015b0: 91237000     	add	x0, x0, #0x8dc
400015b4: 94000833     	bl	0x40003680 <uart_puts>
400015b8: 17ffff0c     	b	0x400011e8 <execute_command+0x418>
400015bc: d0000028     	adrp	x8, 0x40007000 <__rodata_start>
400015c0: 911b3508     	add	x8, x8, #0x6cd
400015c4: 9100c001     	add	x1, x0, #0x30
400015c8: aa0803e0     	mov	x0, x8
400015cc: 17ffff8a     	b	0x400013f4 <execute_command+0x624>
400015d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015d4: 912dd800     	add	x0, x0, #0xb76
400015d8: 9400082a     	bl	0x40003680 <uart_puts>
400015dc: 17ffff03     	b	0x400011e8 <execute_command+0x418>
400015e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015e4: 9133c400     	add	x0, x0, #0xcf1
400015e8: 94000826     	bl	0x40003680 <uart_puts>
400015ec: 17fffeff     	b	0x400011e8 <execute_command+0x418>
400015f0: 910103e0     	add	x0, sp, #0x40
400015f4: 9400047a     	bl	0x400027dc <kstrlen>
400015f8: b4000080     	cbz	x0, 0x40001608 <execute_command+0x838>
400015fc: 910103e0     	add	x0, sp, #0x40
40001600: 9400043f     	bl	0x400026fc <script_run_file>
40001604: 17fffef9     	b	0x400011e8 <execute_command+0x418>
40001608: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000160c: 91019c00     	add	x0, x0, #0x67
40001610: 9400081c     	bl	0x40003680 <uart_puts>
40001614: 17fffef5     	b	0x400011e8 <execute_command+0x418>
40001618: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000161c: 91378800     	add	x0, x0, #0xde2
40001620: 94000818     	bl	0x40003680 <uart_puts>
40001624: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001628: d0000035     	adrp	x21, 0x40007000 <__rodata_start>
4000162c: 9113e6b5     	add	x21, x21, #0x4f9
40001630: 39400113     	ldrb	w19, [x8]
40001634: d344fe68     	lsr	x8, x19, #4
40001638: 38686aa0     	ldrb	w0, [x21, x8]
4000163c: 940007fa     	bl	0x40003624 <uart_putc>
40001640: 92400e68     	and	x8, x19, #0xf
40001644: 38686aa0     	ldrb	w0, [x21, x8]
40001648: 940007f7     	bl	0x40003624 <uart_putc>
4000164c: 52800400     	mov	w0, #0x20               // =32
40001650: 940007f5     	bl	0x40003624 <uart_putc>
40001654: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001658: 910dbe73     	add	x19, x19, #0x36f
4000165c: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001660: 91177694     	add	x20, x20, #0x5dd
40001664: 52800036     	mov	w22, #0x1               // =1
40001668: d503201f     	nop
4000166c: 10ff4cb7     	adr	x23, 0x40000000 <_start>
40001670: 1400000d     	b	0x400016a4 <execute_command+0x8d4>
40001674: 38766af8     	ldrb	w24, [x23, x22]
40001678: d344ff08     	lsr	x8, x24, #4
4000167c: 38686aa0     	ldrb	w0, [x21, x8]
40001680: 940007e9     	bl	0x40003624 <uart_putc>
40001684: 92400f08     	and	x8, x24, #0xf
40001688: 38686aa0     	ldrb	w0, [x21, x8]
4000168c: 940007e6     	bl	0x40003624 <uart_putc>
40001690: 52800400     	mov	w0, #0x20               // =32
40001694: 940007e4     	bl	0x40003624 <uart_putc>
40001698: 910006d6     	add	x22, x22, #0x1
4000169c: f10082df     	cmp	x22, #0x20
400016a0: 54ffd780     	b.eq	0x40001190 <execute_command+0x3c0>
400016a4: 72000adf     	tst	w22, #0x7
400016a8: 54000061     	b.ne	0x400016b4 <execute_command+0x8e4>
400016ac: aa1303e0     	mov	x0, x19
400016b0: 940007f4     	bl	0x40003680 <uart_puts>
400016b4: 72000edf     	tst	w22, #0xf
400016b8: 54fffde1     	b.ne	0x40001674 <execute_command+0x8a4>
400016bc: aa1403e0     	mov	x0, x20
400016c0: 940007f0     	bl	0x40003680 <uart_puts>
400016c4: 17ffffec     	b	0x40001674 <execute_command+0x8a4>
400016c8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400016cc: 91345000     	add	x0, x0, #0xd14
400016d0: 940007ec     	bl	0x40003680 <uart_puts>
400016d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400016d8: 913a8c00     	add	x0, x0, #0xea3
400016dc: 940007e9     	bl	0x40003680 <uart_puts>
400016e0: d503207f     	wfi
400016e4: 17ffffff     	b	0x400016e0 <execute_command+0x910>
400016e8: 97fffd08     	bl	0x40000b08 <print_android_roadmap>
400016ec: 17fffebf     	b	0x400011e8 <execute_command+0x418>

00000000400016f0 <kernel_shell>:
400016f0: d10543ff     	sub	sp, sp, #0x150
400016f4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400016f8: 9123f400     	add	x0, x0, #0x8fd
400016fc: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
40001700: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001704: 9103c3fd     	add	x29, sp, #0xf0
40001708: a91167fa     	stp	x26, x25, [sp, #0x110]
4000170c: a9125ff8     	stp	x24, x23, [sp, #0x120]
40001710: a91357f6     	stp	x22, x21, [sp, #0x130]
40001714: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001718: 940007da     	bl	0x40003680 <uart_puts>
4000171c: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001720: 91381a73     	add	x19, x19, #0xe06
40001724: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001728: 91008a94     	add	x20, x20, #0x22
4000172c: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
40001730: 911246b5     	add	x21, x21, #0x491
40001734: d0000036     	adrp	x22, 0x40007000 <__rodata_start>
40001738: 913f66d6     	add	x22, x22, #0xfd9
4000173c: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x2000>
40001740: 911402f7     	add	x23, x23, #0x500
40001744: 90000058     	adrp	x24, 0x40009000 <__rodata_start+0x2000>
40001748: 91047318     	add	x24, x24, #0x11c
4000174c: 910123fa     	add	x26, sp, #0x48
40001750: d0000039     	adrp	x25, 0x40007000 <__rodata_start>
40001754: 912e2f39     	add	x25, x25, #0xb8b
40001758: 910023e0     	add	x0, sp, #0x8
4000175c: 52800801     	mov	w1, #0x40               // =64
40001760: 94000c57     	bl	0x400048bc <vfs_getcwd>
40001764: 910023e1     	add	x1, sp, #0x8
40001768: aa1303e0     	mov	x0, x19
4000176c: 940008da     	bl	0x40003ad4 <uart_printf>
40001770: aa1403e0     	mov	x0, x20
40001774: 940007c3     	bl	0x40003680 <uart_puts>
40001778: aa1f03fc     	mov	x28, xzr
4000177c: aa1c03fb     	mov	x27, x28
40001780: 940007f4     	bl	0x40003750 <uart_getc>
40001784: 12001c08     	and	w8, w0, #0xff
40001788: 7100311f     	cmp	w8, #0xc
4000178c: 540000cc     	b.gt	0x400017a4 <kernel_shell+0xb4>
40001790: 7100211f     	cmp	w8, #0x8
40001794: 54000240     	b.eq	0x400017dc <kernel_shell+0xec>
40001798: 7100291f     	cmp	w8, #0xa
4000179c: 540000c1     	b.ne	0x400017b4 <kernel_shell+0xc4>
400017a0: 14000015     	b	0x400017f4 <kernel_shell+0x104>
400017a4: 7100351f     	cmp	w8, #0xd
400017a8: 54000260     	b.eq	0x400017f4 <kernel_shell+0x104>
400017ac: 7101fd1f     	cmp	w8, #0x7f
400017b0: 54000160     	b.eq	0x400017dc <kernel_shell+0xec>
400017b4: 51008008     	sub	w8, w0, #0x20
400017b8: 12001d08     	and	w8, w8, #0xff
400017bc: 7101791f     	cmp	w8, #0x5e
400017c0: 54fffe08     	b.hi	0x40001780 <kernel_shell+0x90>
400017c4: f1027b7f     	cmp	x27, #0x9e
400017c8: 54fffdc8     	b.hi	0x40001780 <kernel_shell+0x90>
400017cc: 9100077c     	add	x28, x27, #0x1
400017d0: 383b6b40     	strb	w0, [x26, x27]
400017d4: 94000794     	bl	0x40003624 <uart_putc>
400017d8: 17ffffe9     	b	0x4000177c <kernel_shell+0x8c>
400017dc: aa1f03fc     	mov	x28, xzr
400017e0: b4fffcfb     	cbz	x27, 0x4000177c <kernel_shell+0x8c>
400017e4: aa1503e0     	mov	x0, x21
400017e8: d100077c     	sub	x28, x27, #0x1
400017ec: 940007a5     	bl	0x40003680 <uart_puts>
400017f0: 17ffffe3     	b	0x4000177c <kernel_shell+0x8c>
400017f4: aa1603e0     	mov	x0, x22
400017f8: 940007a2     	bl	0x40003680 <uart_puts>
400017fc: 910123e0     	add	x0, sp, #0x48
40001800: 383b6b5f     	strb	wzr, [x26, x27]
40001804: 940003f6     	bl	0x400027dc <kstrlen>
40001808: b4fffa80     	cbz	x0, 0x40001758 <kernel_shell+0x68>
4000180c: 910123e0     	add	x0, sp, #0x48
40001810: 940002f6     	bl	0x400023e8 <script_execute_line>
40001814: 910123e0     	add	x0, sp, #0x48
40001818: aa1703e1     	mov	x1, x23
4000181c: 94000400     	bl	0x4000281c <kstrcmp>
40001820: 34000120     	cbz	w0, 0x40001844 <kernel_shell+0x154>
40001824: 910123e0     	add	x0, sp, #0x48
40001828: aa1803e1     	mov	x1, x24
4000182c: 940003fc     	bl	0x4000281c <kstrcmp>
40001830: 340000a0     	cbz	w0, 0x40001844 <kernel_shell+0x154>
40001834: 910123e0     	add	x0, sp, #0x48
40001838: aa1903e1     	mov	x1, x25
4000183c: 940003f8     	bl	0x4000281c <kstrcmp>
40001840: 35fff8c0     	cbnz	w0, 0x40001758 <kernel_shell+0x68>
40001844: a9544ff4     	ldp	x20, x19, [sp, #0x140]
40001848: a95357f6     	ldp	x22, x21, [sp, #0x130]
4000184c: a9525ff8     	ldp	x24, x23, [sp, #0x120]
40001850: a95167fa     	ldp	x26, x25, [sp, #0x110]
40001854: a9506ffc     	ldp	x28, x27, [sp, #0x100]
40001858: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
4000185c: 910543ff     	add	sp, sp, #0x150
40001860: d65f03c0     	ret

0000000040001864 <kmain>:
40001864: d100c3ff     	sub	sp, sp, #0x30
40001868: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000186c: 529c6c13     	mov	w19, #0xe360            // =58208
40001870: a9017bfd     	stp	x29, x30, [sp, #0x10]
40001874: 910043fd     	add	x29, sp, #0x10
40001878: 72a002d3     	movk	w19, #0x16, lsl #16
4000187c: 9400075e     	bl	0x400035f4 <uart_init>
40001880: d503201f     	nop
40001884: 300346e0     	adr	x0, 0x40008161 <__rodata_start+0x1161>
40001888: 9400077e     	bl	0x40003680 <uart_puts>
4000188c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001890: 91166c00     	add	x0, x0, #0x59b
40001894: 9400077b     	bl	0x40003680 <uart_puts>
40001898: b81fc3bf     	stur	wzr, [x29, #-0x4]
4000189c: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018a0: 6b13011f     	cmp	w8, w19
400018a4: 540000aa     	b.ge	0x400018b8 <kmain+0x54>
400018a8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018ac: 11000508     	add	w8, w8, #0x1
400018b0: b81fc3a8     	stur	w8, [x29, #-0x4]
400018b4: 17fffffa     	b	0x4000189c <kmain+0x38>
400018b8: 528aa213     	mov	w19, #0x5510            // =21776
400018bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018c0: 910dc400     	add	x0, x0, #0x371
400018c4: 72a00453     	movk	w19, #0x22, lsl #16
400018c8: 9400076e     	bl	0x40003680 <uart_puts>
400018cc: b81fc3bf     	stur	wzr, [x29, #-0x4]
400018d0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018d4: 6b13011f     	cmp	w8, w19
400018d8: 540000aa     	b.ge	0x400018ec <kmain+0x88>
400018dc: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018e0: 11000508     	add	w8, w8, #0x1
400018e4: b81fc3a8     	stur	w8, [x29, #-0x4]
400018e8: 17fffffa     	b	0x400018d0 <kmain+0x6c>
400018ec: 5298d814     	mov	w20, #0xc6c0            // =50880
400018f0: 72a005b4     	movk	w20, #0x2d, lsl #16
400018f4: 94000a84     	bl	0x40004304 <vfs_init>
400018f8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400018fc: 911c2c00     	add	x0, x0, #0x70b
40001900: 94000760     	bl	0x40003680 <uart_puts>
40001904: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001908: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000190c: 6b14011f     	cmp	w8, w20
40001910: 540000aa     	b.ge	0x40001924 <kmain+0xc0>
40001914: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001918: 11000508     	add	w8, w8, #0x1
4000191c: b81fc3a8     	stur	w8, [x29, #-0x4]
40001920: 17fffffa     	b	0x40001908 <kmain+0xa4>
40001924: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001928: 91090c00     	add	x0, x0, #0x243
4000192c: d503201f     	nop
40001930: 1001f688     	adr	x8, 0x40005800 <exception_vector_table>
40001934: d518c008     	msr	VBAR_EL1, x8
40001938: 94000752     	bl	0x40003680 <uart_puts>
4000193c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001940: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001944: 6b13011f     	cmp	w8, w19
40001948: 540000aa     	b.ge	0x4000195c <kmain+0xf8>
4000194c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001950: 11000508     	add	w8, w8, #0x1
40001954: b81fc3a8     	stur	w8, [x29, #-0x4]
40001958: 17fffffa     	b	0x40001940 <kmain+0xdc>
4000195c: 97fffa25     	bl	0x400001f0 <gic_init>
40001960: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001964: 910f6c00     	add	x0, x0, #0x3db
40001968: 94000746     	bl	0x40003680 <uart_puts>
4000196c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001970: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001974: 6b13011f     	cmp	w8, w19
40001978: 540000aa     	b.ge	0x4000198c <kmain+0x128>
4000197c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001980: 11000508     	add	w8, w8, #0x1
40001984: b81fc3a8     	stur	w8, [x29, #-0x4]
40001988: 17fffffa     	b	0x40001970 <kmain+0x10c>
4000198c: 94000447     	bl	0x40002aa8 <timer_init>
40001990: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001994: 911f1c00     	add	x0, x0, #0x7c7
40001998: 9400073a     	bl	0x40003680 <uart_puts>
4000199c: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019a0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019a4: 6b13011f     	cmp	w8, w19
400019a8: 540000aa     	b.ge	0x400019bc <kmain+0x158>
400019ac: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019b0: 11000508     	add	w8, w8, #0x1
400019b4: b81fc3a8     	stur	w8, [x29, #-0x4]
400019b8: 17fffffa     	b	0x400019a0 <kmain+0x13c>
400019bc: 94000079     	bl	0x40001ba0 <process_init>
400019c0: 940001c0     	bl	0x400020c0 <script_init>
400019c4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400019c8: 91023000     	add	x0, x0, #0x8c
400019cc: 9400072d     	bl	0x40003680 <uart_puts>
400019d0: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019d4: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019d8: 6b13011f     	cmp	w8, w19
400019dc: 540000aa     	b.ge	0x400019f0 <kmain+0x18c>
400019e0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019e4: 11000508     	add	w8, w8, #0x1
400019e8: b81fc3a8     	stur	w8, [x29, #-0x4]
400019ec: 17fffffa     	b	0x400019d4 <kmain+0x170>
400019f0: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019f4: 5291b008     	mov	w8, #0x8d80             // =36224
400019f8: b85fc3a9     	ldur	w9, [x29, #-0x4]
400019fc: 72a00b68     	movk	w8, #0x5b, lsl #16
40001a00: 6b08013f     	cmp	w9, w8
40001a04: 540000ea     	b.ge	0x40001a20 <kmain+0x1bc>
40001a08: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001a0c: 11000529     	add	w9, w9, #0x1
40001a10: b81fc3a9     	stur	w9, [x29, #-0x4]
40001a14: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001a18: 6b08013f     	cmp	w9, w8
40001a1c: 54ffff6b     	b.lt	0x40001a08 <kmain+0x1a4>
40001a20: 97fffb9f     	bl	0x4000089c <print_banner>
40001a24: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a28: 9123d000     	add	x0, x0, #0x8f4
40001a2c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001a30: 91356821     	add	x1, x1, #0xd5a
40001a34: 94000828     	bl	0x40003ad4 <uart_printf>
40001a38: 97fffbe2     	bl	0x400009c0 <print_sysinfo>
40001a3c: 97ffff2d     	bl	0x400016f0 <kernel_shell>
40001a40: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001a44: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001a48: 913a8c00     	add	x0, x0, #0xea3
40001a4c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001a50: 9100c3ff     	add	sp, sp, #0x30
40001a54: 1400070b     	b	0x40003680 <uart_puts>

0000000040001a58 <kproj_execute>:
40001a58: d10683ff     	sub	sp, sp, #0x1a0
40001a5c: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001a60: 910603fd     	add	x29, sp, #0x180
40001a64: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001a68: b40001c0     	cbz	x0, 0x40001aa0 <kproj_execute+0x48>
40001a6c: aa0003f3     	mov	x19, x0
40001a70: 9400035b     	bl	0x400027dc <kstrlen>
40001a74: b4000160     	cbz	x0, 0x40001aa0 <kproj_execute+0x48>
40001a78: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a7c: 9126d400     	add	x0, x0, #0x9b5
40001a80: aa1303e1     	mov	x1, x19
40001a84: 94000814     	bl	0x40003ad4 <uart_printf>
40001a88: aa1303e0     	mov	x0, x19
40001a8c: 94000c65     	bl	0x40004c20 <vfs_mkdir>
40001a90: 34000140     	cbz	w0, 0x40001ab8 <kproj_execute+0x60>
40001a94: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001a98: 91141400     	add	x0, x0, #0x505
40001a9c: 14000003     	b	0x40001aa8 <kproj_execute+0x50>
40001aa0: d503201f     	nop
40001aa4: 3003b4e0     	adr	x0, 0x40009141 <__rodata_start+0x2141>
40001aa8: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001aac: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001ab0: 910683ff     	add	sp, sp, #0x1a0
40001ab4: 140006f3     	b	0x40003680 <uart_puts>
40001ab8: aa1303e0     	mov	x0, x19
40001abc: 94000c34     	bl	0x40004b8c <vfs_chdir>
40001ac0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001ac4: 9100fc00     	add	x0, x0, #0x3f
40001ac8: 94000c56     	bl	0x40004c20 <vfs_mkdir>
40001acc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001ad0: 91174800     	add	x0, x0, #0x5d2
40001ad4: 94000c53     	bl	0x40004c20 <vfs_mkdir>
40001ad8: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001adc: 910a4021     	add	x1, x1, #0x290
40001ae0: 910203e0     	add	x0, sp, #0x80
40001ae4: 9400036d     	bl	0x40002898 <kstrcpy>
40001ae8: 910203e0     	add	x0, sp, #0x80
40001aec: aa1303e1     	mov	x1, x19
40001af0: 94000342     	bl	0x400027f8 <kstrcat>
40001af4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001af8: 9139c821     	add	x1, x1, #0xe72
40001afc: 910203e0     	add	x0, sp, #0x80
40001b00: 9400033e     	bl	0x400027f8 <kstrcat>
40001b04: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b08: 91247400     	add	x0, x0, #0x91d
40001b0c: 910203e1     	add	x1, sp, #0x80
40001b10: 94000c9a     	bl	0x40004d78 <vfs_touch>
40001b14: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b18: 913b2400     	add	x0, x0, #0xec9
40001b1c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b20: 912e4021     	add	x1, x1, #0xb90
40001b24: 94000c95     	bl	0x40004d78 <vfs_touch>
40001b28: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001b2c: 91045021     	add	x1, x1, #0x114
40001b30: 910003e0     	mov	x0, sp
40001b34: 94000359     	bl	0x40002898 <kstrcpy>
40001b38: 910003e0     	mov	x0, sp
40001b3c: aa1303e1     	mov	x1, x19
40001b40: 9400032e     	bl	0x400027f8 <kstrcat>
40001b44: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b48: 9129e021     	add	x1, x1, #0xa78
40001b4c: 910003e0     	mov	x0, sp
40001b50: 9400032a     	bl	0x400027f8 <kstrcat>
40001b54: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b58: 913a7800     	add	x0, x0, #0xe9e
40001b5c: 910003e1     	mov	x1, sp
40001b60: 94000c86     	bl	0x40004d78 <vfs_touch>
40001b64: 94000c84     	bl	0x40004d74 <vfs_sync>
40001b68: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b6c: 91142800     	add	x0, x0, #0x50a
40001b70: 940006c4     	bl	0x40003680 <uart_puts>
40001b74: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b78: 9114e400     	add	x0, x0, #0x539
40001b7c: aa1303e1     	mov	x1, x19
40001b80: 940007d5     	bl	0x40003ad4 <uart_printf>
40001b84: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b88: 91010c00     	add	x0, x0, #0x43
40001b8c: 94000c00     	bl	0x40004b8c <vfs_chdir>
40001b90: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001b94: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001b98: 910683ff     	add	sp, sp, #0x1a0
40001b9c: d65f03c0     	ret

0000000040001ba0 <process_init>:
40001ba0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001ba4: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001ba8: b0000054     	adrp	x20, 0x4000a000 <next_pid>
40001bac: d503201f     	nop
40001bb0: 10063533     	adr	x19, 0x4000e254 <proc_table>
40001bb4: b9400289     	ldr	w9, [x20]
40001bb8: 52800068     	mov	w8, #0x3                // =3
40001bbc: b9002668     	str	w8, [x19, #0x24]
40001bc0: d503201f     	nop
40001bc4: 10036281     	adr	x1, 0x40008814 <__rodata_start+0x1814>
40001bc8: b9005668     	str	w8, [x19, #0x54]
40001bcc: 91001260     	add	x0, x19, #0x4
40001bd0: 910003fd     	mov	x29, sp
40001bd4: b9008668     	str	w8, [x19, #0x84]
40001bd8: b900b668     	str	w8, [x19, #0xb4]
40001bdc: b900e668     	str	w8, [x19, #0xe4]
40001be0: b9011668     	str	w8, [x19, #0x114]
40001be4: b9014668     	str	w8, [x19, #0x144]
40001be8: b9017668     	str	w8, [x19, #0x174]
40001bec: b901a668     	str	w8, [x19, #0x1a4]
40001bf0: b901d668     	str	w8, [x19, #0x1d4]
40001bf4: b9020668     	str	w8, [x19, #0x204]
40001bf8: b9023668     	str	w8, [x19, #0x234]
40001bfc: b9026668     	str	w8, [x19, #0x264]
40001c00: b9029668     	str	w8, [x19, #0x294]
40001c04: b902c668     	str	w8, [x19, #0x2c4]
40001c08: b902f668     	str	w8, [x19, #0x2f4]
40001c0c: 11000528     	add	w8, w9, #0x1
40001c10: f9000bf5     	str	x21, [sp, #0x10]
40001c14: b900327f     	str	wzr, [x19, #0x30]
40001c18: b900627f     	str	wzr, [x19, #0x60]
40001c1c: b900927f     	str	wzr, [x19, #0x90]
40001c20: b900c27f     	str	wzr, [x19, #0xc0]
40001c24: b900f27f     	str	wzr, [x19, #0xf0]
40001c28: b901227f     	str	wzr, [x19, #0x120]
40001c2c: b901527f     	str	wzr, [x19, #0x150]
40001c30: b901827f     	str	wzr, [x19, #0x180]
40001c34: b901b27f     	str	wzr, [x19, #0x1b0]
40001c38: b901e27f     	str	wzr, [x19, #0x1e0]
40001c3c: b902127f     	str	wzr, [x19, #0x210]
40001c40: b902427f     	str	wzr, [x19, #0x240]
40001c44: b902727f     	str	wzr, [x19, #0x270]
40001c48: b902a27f     	str	wzr, [x19, #0x2a0]
40001c4c: b902d27f     	str	wzr, [x19, #0x2d0]
40001c50: b9000288     	str	w8, [x20]
40001c54: b9000269     	str	w9, [x19]
40001c58: 94000310     	bl	0x40002898 <kstrcpy>
40001c5c: b9400288     	ldr	w8, [x20]
40001c60: 52a00209     	mov	w9, #0x100000           // =1048576
40001c64: 5280384a     	mov	w10, #0x1c2             // =450
40001c68: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001c6c: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001c70: 9114f821     	add	x1, x1, #0x53e
40001c74: 11000509     	add	w9, w8, #0x1
40001c78: 9100d260     	add	x0, x19, #0x34
40001c7c: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001c80: b9000289     	str	w9, [x20]
40001c84: 94000305     	bl	0x40002898 <kstrcpy>
40001c88: b9400288     	ldr	w8, [x20]
40001c8c: 529d0009     	mov	w9, #0xe800             // =59392
40001c90: 52800035     	mov	w21, #0x1               // =1
40001c94: 72a00069     	movk	w9, #0x3, lsl #16
40001c98: 5280018a     	mov	w10, #0xc               // =12
40001c9c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001ca0: 912a6821     	add	x1, x1, #0xa9a
40001ca4: 290aa675     	stp	w21, w9, [x19, #0x54]
40001ca8: 11000509     	add	w9, w8, #0x1
40001cac: 91019260     	add	x0, x19, #0x64
40001cb0: b9000289     	str	w9, [x20]
40001cb4: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001cb8: 940002f8     	bl	0x40002898 <kstrcpy>
40001cbc: b9400288     	ldr	w8, [x20]
40001cc0: 52a00809     	mov	w9, #0x400000           // =4194304
40001cc4: 5280960a     	mov	w10, #0x4b0             // =1200
40001cc8: 2910a675     	stp	w21, w9, [x19, #0x84]
40001ccc: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001cd0: 910b5021     	add	x1, x1, #0x2d4
40001cd4: 11000509     	add	w9, w8, #0x1
40001cd8: 91025260     	add	x0, x19, #0x94
40001cdc: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001ce0: b9000289     	str	w9, [x20]
40001ce4: 940002ed     	bl	0x40002898 <kstrcpy>
40001ce8: 529a0008     	mov	w8, #0xd000             // =53248
40001cec: 52800aa9     	mov	w9, #0x55               // =85
40001cf0: f9400bf5     	ldr	x21, [sp, #0x10]
40001cf4: 72a000e8     	movk	w8, #0x7, lsl #16
40001cf8: b900be69     	str	w9, [x19, #0xbc]
40001cfc: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001d00: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001d04: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001d08: d65f03c0     	ret

0000000040001d0c <process_kill>:
40001d0c: 7100041f     	cmp	w0, #0x1
40001d10: 5400118b     	b.lt	0x40001f40 <process_kill+0x234>
40001d14: d503201f     	nop
40001d18: 100629e9     	adr	x9, 0x4000e254 <proc_table>
40001d1c: b9400128     	ldr	w8, [x9]
40001d20: 6b00011f     	cmp	w8, w0
40001d24: 54000081     	b.ne	0x40001d34 <process_kill+0x28>
40001d28: b9402528     	ldr	w8, [x9, #0x24]
40001d2c: 71000d1f     	cmp	w8, #0x3
40001d30: 54000f41     	b.ne	0x40001f18 <process_kill+0x20c>
40001d34: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d38: 910a1129     	add	x9, x9, #0x284
40001d3c: b9400128     	ldr	w8, [x9]
40001d40: 6b00011f     	cmp	w8, w0
40001d44: 54000081     	b.ne	0x40001d54 <process_kill+0x48>
40001d48: b9402528     	ldr	w8, [x9, #0x24]
40001d4c: 71000d1f     	cmp	w8, #0x3
40001d50: 54000e41     	b.ne	0x40001f18 <process_kill+0x20c>
40001d54: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d58: 910ad129     	add	x9, x9, #0x2b4
40001d5c: b9400128     	ldr	w8, [x9]
40001d60: 6b00011f     	cmp	w8, w0
40001d64: 54000081     	b.ne	0x40001d74 <process_kill+0x68>
40001d68: b9402528     	ldr	w8, [x9, #0x24]
40001d6c: 71000d1f     	cmp	w8, #0x3
40001d70: 54000d41     	b.ne	0x40001f18 <process_kill+0x20c>
40001d74: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d78: 910b9129     	add	x9, x9, #0x2e4
40001d7c: b9400128     	ldr	w8, [x9]
40001d80: 6b00011f     	cmp	w8, w0
40001d84: 54000081     	b.ne	0x40001d94 <process_kill+0x88>
40001d88: b9402528     	ldr	w8, [x9, #0x24]
40001d8c: 71000d1f     	cmp	w8, #0x3
40001d90: 54000c41     	b.ne	0x40001f18 <process_kill+0x20c>
40001d94: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d98: 910c5129     	add	x9, x9, #0x314
40001d9c: b9400128     	ldr	w8, [x9]
40001da0: 6b00011f     	cmp	w8, w0
40001da4: 54000081     	b.ne	0x40001db4 <process_kill+0xa8>
40001da8: b9402528     	ldr	w8, [x9, #0x24]
40001dac: 71000d1f     	cmp	w8, #0x3
40001db0: 54000b41     	b.ne	0x40001f18 <process_kill+0x20c>
40001db4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001db8: 910d1129     	add	x9, x9, #0x344
40001dbc: b9400128     	ldr	w8, [x9]
40001dc0: 6b00011f     	cmp	w8, w0
40001dc4: 54000081     	b.ne	0x40001dd4 <process_kill+0xc8>
40001dc8: b9402528     	ldr	w8, [x9, #0x24]
40001dcc: 71000d1f     	cmp	w8, #0x3
40001dd0: 54000a41     	b.ne	0x40001f18 <process_kill+0x20c>
40001dd4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001dd8: 910dd129     	add	x9, x9, #0x374
40001ddc: b9400128     	ldr	w8, [x9]
40001de0: 6b00011f     	cmp	w8, w0
40001de4: 54000081     	b.ne	0x40001df4 <process_kill+0xe8>
40001de8: b9402528     	ldr	w8, [x9, #0x24]
40001dec: 71000d1f     	cmp	w8, #0x3
40001df0: 54000941     	b.ne	0x40001f18 <process_kill+0x20c>
40001df4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001df8: 910e9129     	add	x9, x9, #0x3a4
40001dfc: b9400128     	ldr	w8, [x9]
40001e00: 6b00011f     	cmp	w8, w0
40001e04: 54000081     	b.ne	0x40001e14 <process_kill+0x108>
40001e08: b9402528     	ldr	w8, [x9, #0x24]
40001e0c: 71000d1f     	cmp	w8, #0x3
40001e10: 54000841     	b.ne	0x40001f18 <process_kill+0x20c>
40001e14: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e18: 910f5129     	add	x9, x9, #0x3d4
40001e1c: b9400128     	ldr	w8, [x9]
40001e20: 6b00011f     	cmp	w8, w0
40001e24: 54000081     	b.ne	0x40001e34 <process_kill+0x128>
40001e28: b9402528     	ldr	w8, [x9, #0x24]
40001e2c: 71000d1f     	cmp	w8, #0x3
40001e30: 54000741     	b.ne	0x40001f18 <process_kill+0x20c>
40001e34: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e38: 91101129     	add	x9, x9, #0x404
40001e3c: b9400128     	ldr	w8, [x9]
40001e40: 6b00011f     	cmp	w8, w0
40001e44: 54000081     	b.ne	0x40001e54 <process_kill+0x148>
40001e48: b9402528     	ldr	w8, [x9, #0x24]
40001e4c: 71000d1f     	cmp	w8, #0x3
40001e50: 54000641     	b.ne	0x40001f18 <process_kill+0x20c>
40001e54: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e58: 9110d129     	add	x9, x9, #0x434
40001e5c: b9400128     	ldr	w8, [x9]
40001e60: 6b00011f     	cmp	w8, w0
40001e64: 54000081     	b.ne	0x40001e74 <process_kill+0x168>
40001e68: b9402528     	ldr	w8, [x9, #0x24]
40001e6c: 71000d1f     	cmp	w8, #0x3
40001e70: 54000541     	b.ne	0x40001f18 <process_kill+0x20c>
40001e74: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e78: 91119129     	add	x9, x9, #0x464
40001e7c: b9400128     	ldr	w8, [x9]
40001e80: 6b00011f     	cmp	w8, w0
40001e84: 54000081     	b.ne	0x40001e94 <process_kill+0x188>
40001e88: b9402528     	ldr	w8, [x9, #0x24]
40001e8c: 71000d1f     	cmp	w8, #0x3
40001e90: 54000441     	b.ne	0x40001f18 <process_kill+0x20c>
40001e94: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001e98: 91125129     	add	x9, x9, #0x494
40001e9c: b9400128     	ldr	w8, [x9]
40001ea0: 6b00011f     	cmp	w8, w0
40001ea4: 54000081     	b.ne	0x40001eb4 <process_kill+0x1a8>
40001ea8: b9402528     	ldr	w8, [x9, #0x24]
40001eac: 71000d1f     	cmp	w8, #0x3
40001eb0: 54000341     	b.ne	0x40001f18 <process_kill+0x20c>
40001eb4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001eb8: 91131129     	add	x9, x9, #0x4c4
40001ebc: b9400128     	ldr	w8, [x9]
40001ec0: 6b00011f     	cmp	w8, w0
40001ec4: 54000081     	b.ne	0x40001ed4 <process_kill+0x1c8>
40001ec8: b9402528     	ldr	w8, [x9, #0x24]
40001ecc: 71000d1f     	cmp	w8, #0x3
40001ed0: 54000241     	b.ne	0x40001f18 <process_kill+0x20c>
40001ed4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ed8: 9113d129     	add	x9, x9, #0x4f4
40001edc: b9400128     	ldr	w8, [x9]
40001ee0: 6b00011f     	cmp	w8, w0
40001ee4: 54000081     	b.ne	0x40001ef4 <process_kill+0x1e8>
40001ee8: b9402528     	ldr	w8, [x9, #0x24]
40001eec: 71000d1f     	cmp	w8, #0x3
40001ef0: 54000141     	b.ne	0x40001f18 <process_kill+0x20c>
40001ef4: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ef8: 91149129     	add	x9, x9, #0x524
40001efc: b9400128     	ldr	w8, [x9]
40001f00: 6b00011f     	cmp	w8, w0
40001f04: 12800008     	mov	w8, #-0x1               // =-1
40001f08: 54000281     	b.ne	0x40001f58 <process_kill+0x24c>
40001f0c: b940252a     	ldr	w10, [x9, #0x24]
40001f10: 71000d5f     	cmp	w10, #0x3
40001f14: 54000220     	b.eq	0x40001f58 <process_kill+0x24c>
40001f18: 7100041f     	cmp	w0, #0x1
40001f1c: 54000161     	b.ne	0x40001f48 <process_kill+0x23c>
40001f20: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f24: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f28: 91279800     	add	x0, x0, #0x9e6
40001f2c: 910003fd     	mov	x29, sp
40001f30: 940005d4     	bl	0x40003680 <uart_puts>
40001f34: 12800020     	mov	w0, #-0x2               // =-2
40001f38: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001f3c: d65f03c0     	ret
40001f40: 12800000     	mov	w0, #-0x1               // =-1
40001f44: d65f03c0     	ret
40001f48: 5280004a     	mov	w10, #0x2               // =2
40001f4c: 2a1f03e0     	mov	w0, wzr
40001f50: b900252a     	str	w10, [x9, #0x24]
40001f54: d65f03c0     	ret
40001f58: 2a0803e0     	mov	w0, w8
40001f5c: d65f03c0     	ret

0000000040001f60 <launch_ktop>:
40001f60: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001f64: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f68: 911fe800     	add	x0, x0, #0x7fa
40001f6c: f9000bf7     	str	x23, [sp, #0x10]
40001f70: a90257f6     	stp	x22, x21, [sp, #0x20]
40001f74: 910003fd     	mov	x29, sp
40001f78: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001f7c: 940005c1     	bl	0x40003680 <uart_puts>
40001f80: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001f84: 911d6000     	add	x0, x0, #0x758
40001f88: 940005be     	bl	0x40003680 <uart_puts>
40001f8c: 2a1f03e8     	mov	w8, wzr
40001f90: 2a1f03e1     	mov	w1, wzr
40001f94: 52800209     	mov	w9, #0x10               // =16
40001f98: b000006a     	adrp	x10, 0x4000e000 <__bss_start+0x3000>
40001f9c: 9109f14a     	add	x10, x10, #0x27c
40001fa0: 14000004     	b	0x40001fb0 <launch_ktop+0x50>
40001fa4: f1000529     	subs	x9, x9, #0x1
40001fa8: 9100c14a     	add	x10, x10, #0x30
40001fac: 54000120     	b.eq	0x40001fd0 <launch_ktop+0x70>
40001fb0: b85fc14b     	ldur	w11, [x10, #-0x4]
40001fb4: 121f796b     	and	w11, w11, #0xfffffffe
40001fb8: 7100097f     	cmp	w11, #0x2
40001fbc: 54ffff40     	b.eq	0x40001fa4 <launch_ktop+0x44>
40001fc0: b940014b     	ldr	w11, [x10]
40001fc4: 11000421     	add	w1, w1, #0x1
40001fc8: 0b080168     	add	w8, w11, w8
40001fcc: 17fffff6     	b	0x40001fa4 <launch_ktop+0x44>
40001fd0: 530a7d02     	lsr	w2, w8, #10
40001fd4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001fd8: 912a9000     	add	x0, x0, #0xaa4
40001fdc: 940006be     	bl	0x40003ad4 <uart_printf>
40001fe0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001fe4: 912ec000     	add	x0, x0, #0xbb0
40001fe8: 940005a6     	bl	0x40003680 <uart_puts>
40001fec: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001ff0: 9130cc00     	add	x0, x0, #0xc33
40001ff4: 940005a3     	bl	0x40003680 <uart_puts>
40001ff8: b0000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40001ffc: 910a0294     	add	x20, x20, #0x280
40002000: d0000035     	adrp	x21, 0x40008000 <__rodata_start+0x1000>
40002004: 9136b6b5     	add	x21, x21, #0xdad
40002008: d503201f     	nop
4000200c: 1003aa76     	adr	x22, 0x40009558 <__rodata_start+0x2558>
40002010: 52800217     	mov	w23, #0x10              // =16
40002014: d0000033     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
40002018: 9111be73     	add	x19, x19, #0x46f
4000201c: 1400000a     	b	0x40002044 <launch_ktop+0xe4>
40002020: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002024: b85d4281     	ldur	w1, [x20, #-0x2c]
40002028: d100a285     	sub	x5, x20, #0x28
4000202c: aa1303e0     	mov	x0, x19
40002030: 530a7d03     	lsr	w3, w8, #10
40002034: 940006a8     	bl	0x40003ad4 <uart_printf>
40002038: f10006f7     	subs	x23, x23, #0x1
4000203c: 9100c294     	add	x20, x20, #0x30
40002040: 54000120     	b.eq	0x40002064 <launch_ktop+0x104>
40002044: b85f8288     	ldur	w8, [x20, #-0x8]
40002048: 71000d1f     	cmp	w8, #0x3
4000204c: 54ffff60     	b.eq	0x40002038 <launch_ktop+0xd8>
40002050: 7100091f     	cmp	w8, #0x2
40002054: aa1503e2     	mov	x2, x21
40002058: 54fffe48     	b.hi	0x40002020 <launch_ktop+0xc0>
4000205c: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
40002060: 17fffff0     	b	0x40002020 <launch_ktop+0xc0>
40002064: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002068: 91045c00     	add	x0, x0, #0x117
4000206c: 94000585     	bl	0x40003680 <uart_puts>
40002070: 52808114     	mov	w20, #0x408             // =1032
40002074: 52800033     	mov	w19, #0x1               // =1
40002078: 72a02014     	movk	w20, #0x100, lsl #16
4000207c: 14000003     	b	0x40002088 <launch_ktop+0x128>
40002080: 7101c51f     	cmp	w8, #0x71
40002084: 54000100     	b.eq	0x400020a4 <launch_ktop+0x144>
40002088: 940005b2     	bl	0x40003750 <uart_getc>
4000208c: 12001c08     	and	w8, w0, #0xff
40002090: 7100611f     	cmp	w8, #0x18
40002094: 54ffff68     	b.hi	0x40002080 <launch_ktop+0x120>
40002098: 1ac82269     	lsl	w9, w19, w8
4000209c: 6a14013f     	tst	w9, w20
400020a0: 54ffff00     	b.eq	0x40002080 <launch_ktop+0x120>
400020a4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400020a8: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
400020ac: 912b5c00     	add	x0, x0, #0xad7
400020b0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400020b4: f9400bf7     	ldr	x23, [sp, #0x10]
400020b8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400020bc: 14000571     	b	0x40003680 <uart_puts>

00000000400020c0 <script_init>:
400020c0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400020c4: 90000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400020c8: d503201f     	nop
400020cc: 5002d900     	adr	x0, 0x40007bee <__rodata_start+0xbee>
400020d0: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400020d4: 91250021     	add	x1, x1, #0x940
400020d8: 910003fd     	mov	x29, sp
400020dc: b905551f     	str	wzr, [x8, #0x554]
400020e0: 94000007     	bl	0x400020fc <script_set_var>
400020e4: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400020e8: 912ee800     	add	x0, x0, #0xbba
400020ec: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400020f0: 91176021     	add	x1, x1, #0x5d8
400020f4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400020f8: 14000001     	b	0x400020fc <script_set_var>

00000000400020fc <script_set_var>:
400020fc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002100: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002104: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40002108: 910003fd     	mov	x29, sp
4000210c: b94556e8     	ldr	w8, [x23, #0x554]
40002110: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002114: aa0103f3     	mov	x19, x1
40002118: aa0003f4     	mov	x20, x0
4000211c: a90257f6     	stp	x22, x21, [sp, #0x20]
40002120: 7100051f     	cmp	w8, #0x1
40002124: 5400024b     	b.lt	0x4000216c <script_set_var+0x70>
40002128: aa1f03f8     	mov	x24, xzr
4000212c: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002130: 912562b5     	add	x21, x21, #0x958
40002134: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
40002138: 911562d6     	add	x22, x22, #0x558
4000213c: aa1603e0     	mov	x0, x22
40002140: aa1403e1     	mov	x1, x20
40002144: 940001b6     	bl	0x4000281c <kstrcmp>
40002148: 340003e0     	cbz	w0, 0x400021c4 <script_set_var+0xc8>
4000214c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002150: 91000718     	add	x24, x24, #0x1
40002154: 910202b5     	add	x21, x21, #0x80
40002158: 910082d6     	add	x22, x22, #0x20
4000215c: eb08031f     	cmp	x24, x8
40002160: 54fffeeb     	b.lt	0x4000213c <script_set_var+0x40>
40002164: 71007d1f     	cmp	w8, #0x1f
40002168: 5400038c     	b.gt	0x400021d8 <script_set_var+0xdc>
4000216c: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002170: 911562b5     	add	x21, x21, #0x558
40002174: aa1403e1     	mov	x1, x20
40002178: 93407d08     	sxtw	x8, w8
4000217c: 528003e2     	mov	w2, #0x1f               // =31
40002180: 8b0816a0     	add	x0, x21, x8, lsl #5
40002184: 940001cc     	bl	0x400028b4 <kstrncpy>
40002188: b98556e8     	ldrsw	x8, [x23, #0x554]
4000218c: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40002190: 91256294     	add	x20, x20, #0x958
40002194: aa1303e1     	mov	x1, x19
40002198: 52800fe2     	mov	w2, #0x7f               // =127
4000219c: 8b0816a9     	add	x9, x21, x8, lsl #5
400021a0: 8b081e80     	add	x0, x20, x8, lsl #7
400021a4: 39007d3f     	strb	wzr, [x9, #0x1f]
400021a8: 940001c3     	bl	0x400028b4 <kstrncpy>
400021ac: b98556e8     	ldrsw	x8, [x23, #0x554]
400021b0: 8b081e89     	add	x9, x20, x8, lsl #7
400021b4: 11000508     	add	w8, w8, #0x1
400021b8: b90556e8     	str	w8, [x23, #0x554]
400021bc: 3901fd3f     	strb	wzr, [x9, #0x7f]
400021c0: 14000006     	b	0x400021d8 <script_set_var+0xdc>
400021c4: aa1503e0     	mov	x0, x21
400021c8: aa1303e1     	mov	x1, x19
400021cc: 52800fe2     	mov	w2, #0x7f               // =127
400021d0: 940001b9     	bl	0x400028b4 <kstrncpy>
400021d4: 3901febf     	strb	wzr, [x21, #0x7f]
400021d8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400021dc: a94257f6     	ldp	x22, x21, [sp, #0x20]
400021e0: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400021e4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400021e8: d65f03c0     	ret

00000000400021ec <script_get_var>:
400021ec: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400021f0: a90257f6     	stp	x22, x21, [sp, #0x20]
400021f4: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
400021f8: 910003fd     	mov	x29, sp
400021fc: b94556c8     	ldr	w8, [x22, #0x554]
40002200: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002204: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002208: 7100051f     	cmp	w8, #0x1
4000220c: 540002ab     	b.lt	0x40002260 <script_get_var+0x74>
40002210: aa0003f4     	mov	x20, x0
40002214: aa1f03f7     	mov	x23, xzr
40002218: 90000073     	adrp	x19, 0x4000e000 <__bss_start+0x3000>
4000221c: 91256273     	add	x19, x19, #0x958
40002220: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002224: 911562b5     	add	x21, x21, #0x558
40002228: b0000038     	adrp	x24, 0x40007000 <__rodata_start>
4000222c: 91249718     	add	x24, x24, #0x925
40002230: aa1503e0     	mov	x0, x21
40002234: aa1403e1     	mov	x1, x20
40002238: 94000179     	bl	0x4000281c <kstrcmp>
4000223c: 34000160     	cbz	w0, 0x40002268 <script_get_var+0x7c>
40002240: b98556c8     	ldrsw	x8, [x22, #0x554]
40002244: 910006f7     	add	x23, x23, #0x1
40002248: 91020273     	add	x19, x19, #0x80
4000224c: 910082b5     	add	x21, x21, #0x20
40002250: eb0802ff     	cmp	x23, x8
40002254: 54fffeeb     	b.lt	0x40002230 <script_get_var+0x44>
40002258: aa1803f3     	mov	x19, x24
4000225c: 14000003     	b	0x40002268 <script_get_var+0x7c>
40002260: b0000033     	adrp	x19, 0x40007000 <__rodata_start>
40002264: 91249673     	add	x19, x19, #0x925
40002268: aa1303e0     	mov	x0, x19
4000226c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002270: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002274: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002278: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000227c: d65f03c0     	ret

0000000040002280 <script_expand_vars>:
40002280: d10203ff     	sub	sp, sp, #0x80
40002284: a9036ffc     	stp	x28, x27, [sp, #0x30]
40002288: 2a1f03fc     	mov	w28, wzr
4000228c: a90467fa     	stp	x26, x25, [sp, #0x40]
40002290: b0000039     	adrp	x25, 0x40007000 <__rodata_start>
40002294: 91249739     	add	x25, x25, #0x925
40002298: a9055ff8     	stp	x24, x23, [sp, #0x50]
4000229c: 910003f8     	mov	x24, sp
400022a0: 9000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400022a4: a90657f6     	stp	x22, x21, [sp, #0x60]
400022a8: 2a1f03f6     	mov	w22, wzr
400022ac: a9074ff4     	stp	x20, x19, [sp, #0x70]
400022b0: aa0103f3     	mov	x19, x1
400022b4: aa0003f4     	mov	x20, x0
400022b8: a9027bfd     	stp	x29, x30, [sp, #0x20]
400022bc: 910083fd     	add	x29, sp, #0x20
400022c0: 14000001     	b	0x400022c4 <script_expand_vars+0x44>
400022c4: 93407f89     	sxtw	x9, w28
400022c8: 38696a88     	ldrb	w8, [x20, x9]
400022cc: 7100911f     	cmp	w8, #0x24
400022d0: 540000e0     	b.eq	0x400022ec <script_expand_vars+0x6c>
400022d4: 34000788     	cbz	w8, 0x400023c4 <script_expand_vars+0x144>
400022d8: 110006ca     	add	w10, w22, #0x1
400022dc: 3836ca68     	strb	w8, [x19, w22, sxtw]
400022e0: 1100053c     	add	w28, w9, #0x1
400022e4: 2a0a03f6     	mov	w22, w10
400022e8: 17fffff7     	b	0x400022c4 <script_expand_vars+0x44>
400022ec: aa1f03e8     	mov	x8, xzr
400022f0: 14000005     	b	0x40002304 <script_expand_vars+0x84>
400022f4: 9100050a     	add	x10, x8, #0x1
400022f8: 38286b09     	strb	w9, [x24, x8]
400022fc: d1000789     	sub	x9, x28, #0x1
40002300: aa0a03e8     	mov	x8, x10
40002304: 9100053c     	add	x28, x9, #0x1
40002308: 14000004     	b	0x40002318 <script_expand_vars+0x98>
4000230c: f100791f     	cmp	x8, #0x1e
40002310: 9100079c     	add	x28, x28, #0x1
40002314: 54ffff09     	b.ls	0x400022f4 <script_expand_vars+0x74>
40002318: 387c6a89     	ldrb	w9, [x20, x28]
4000231c: 121a792a     	and	w10, w9, #0xffffffdf
40002320: 5101054a     	sub	w10, w10, #0x41
40002324: 7100695f     	cmp	w10, #0x1a
40002328: 54ffff23     	b.lo	0x4000230c <script_expand_vars+0x8c>
4000232c: 71017d3f     	cmp	w9, #0x5f
40002330: 54fffee0     	b.eq	0x4000230c <script_expand_vars+0x8c>
40002334: 5100c12a     	sub	w10, w9, #0x30
40002338: 7100255f     	cmp	w10, #0x9
4000233c: 54fffe89     	b.ls	0x4000230c <script_expand_vars+0x8c>
40002340: b9455749     	ldr	w9, [x26, #0x554]
40002344: 38286b1f     	strb	wzr, [x24, x8]
40002348: 7100053f     	cmp	w9, #0x1
4000234c: 5400028b     	b.lt	0x4000239c <script_expand_vars+0x11c>
40002350: aa1f03fb     	mov	x27, xzr
40002354: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002358: 911562b5     	add	x21, x21, #0x558
4000235c: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40002360: 912562f7     	add	x23, x23, #0x958
40002364: 910003e1     	mov	x1, sp
40002368: aa1503e0     	mov	x0, x21
4000236c: 9400012c     	bl	0x4000281c <kstrcmp>
40002370: 34000100     	cbz	w0, 0x40002390 <script_expand_vars+0x110>
40002374: b9855748     	ldrsw	x8, [x26, #0x554]
40002378: 9100077b     	add	x27, x27, #0x1
4000237c: 910202f7     	add	x23, x23, #0x80
40002380: 910082b5     	add	x21, x21, #0x20
40002384: eb08037f     	cmp	x27, x8
40002388: 54fffeeb     	b.lt	0x40002364 <script_expand_vars+0xe4>
4000238c: aa1903f7     	mov	x23, x25
40002390: 394002e8     	ldrb	w8, [x23]
40002394: 350000a8     	cbnz	w8, 0x400023a8 <script_expand_vars+0x128>
40002398: 17ffffcb     	b	0x400022c4 <script_expand_vars+0x44>
4000239c: aa1903f7     	mov	x23, x25
400023a0: 394002e8     	ldrb	w8, [x23]
400023a4: 34fff908     	cbz	w8, 0x400022c4 <script_expand_vars+0x44>
400023a8: 8b36c269     	add	x9, x19, w22, sxtw
400023ac: 910006ea     	add	x10, x23, #0x1
400023b0: 38001528     	strb	w8, [x9], #0x1
400023b4: 110006d6     	add	w22, w22, #0x1
400023b8: 38401548     	ldrb	w8, [x10], #0x1
400023bc: 35ffffa8     	cbnz	w8, 0x400023b0 <script_expand_vars+0x130>
400023c0: 17ffffc1     	b	0x400022c4 <script_expand_vars+0x44>
400023c4: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
400023c8: a9474ff4     	ldp	x20, x19, [sp, #0x70]
400023cc: a94657f6     	ldp	x22, x21, [sp, #0x60]
400023d0: a9455ff8     	ldp	x24, x23, [sp, #0x50]
400023d4: a94467fa     	ldp	x26, x25, [sp, #0x40]
400023d8: a9436ffc     	ldp	x28, x27, [sp, #0x30]
400023dc: a9427bfd     	ldp	x29, x30, [sp, #0x20]
400023e0: 910203ff     	add	sp, sp, #0x80
400023e4: d65f03c0     	ret

00000000400023e8 <script_execute_line>:
400023e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400023ec: a9014ffc     	stp	x28, x19, [sp, #0x10]
400023f0: 910003fd     	mov	x29, sp
400023f4: d10803ff     	sub	sp, sp, #0x200
400023f8: 14000004     	b	0x40002408 <script_execute_line+0x20>
400023fc: 7100811f     	cmp	w8, #0x20
40002400: 54000121     	b.ne	0x40002424 <script_execute_line+0x3c>
40002404: 91000400     	add	x0, x0, #0x1
40002408: 39400008     	ldrb	w8, [x0]
4000240c: 71007d1f     	cmp	w8, #0x1f
40002410: 54ffff6c     	b.gt	0x400023fc <script_execute_line+0x14>
40002414: 7100251f     	cmp	w8, #0x9
40002418: 54ffff60     	b.eq	0x40002404 <script_execute_line+0x1c>
4000241c: 34001668     	cbz	w8, 0x400026e8 <script_execute_line+0x300>
40002420: 14000003     	b	0x4000242c <script_execute_line+0x44>
40002424: 71008d1f     	cmp	w8, #0x23
40002428: 54001600     	b.eq	0x400026e8 <script_execute_line+0x300>
4000242c: 910403e1     	add	x1, sp, #0x100
40002430: 910403f3     	add	x19, sp, #0x100
40002434: 97ffff93     	bl	0x40002280 <script_expand_vars>
40002438: 394403e9     	ldrb	w9, [sp, #0x100]
4000243c: 34001529     	cbz	w9, 0x400026e0 <script_execute_line+0x2f8>
40002440: 394407e8     	ldrb	w8, [sp, #0x101]
40002444: aa1f03ea     	mov	x10, xzr
40002448: 2a0903eb     	mov	w11, w9
4000244c: 14000004     	b	0x4000245c <script_execute_line+0x74>
40002450: 9100054a     	add	x10, x10, #0x1
40002454: 386a6a6b     	ldrb	w11, [x19, x10]
40002458: 340003cb     	cbz	w11, 0x400024d0 <script_execute_line+0xe8>
4000245c: b4ffffaa     	cbz	x10, 0x40002450 <script_execute_line+0x68>
40002460: 7100f57f     	cmp	w11, #0x3d
40002464: 54ffff61     	b.ne	0x40002450 <script_execute_line+0x68>
40002468: 8b13014b     	add	x11, x10, x19
4000246c: 385ff16c     	ldurb	w12, [x11, #-0x1]
40002470: 7100f59f     	cmp	w12, #0x3d
40002474: 54fffee0     	b.eq	0x40002450 <script_execute_line+0x68>
40002478: 3940056b     	ldrb	w11, [x11, #0x1]
4000247c: 7100f57f     	cmp	w11, #0x3d
40002480: 54fffe80     	b.eq	0x40002450 <script_execute_line+0x68>
40002484: aa1f03ec     	mov	x12, xzr
40002488: 2a1f03eb     	mov	w11, wzr
4000248c: 386c6a6d     	ldrb	w13, [x19, x12]
40002490: 9100058c     	add	x12, x12, #0x1
40002494: 710081bf     	cmp	w13, #0x20
40002498: 1a9f156b     	csinc	w11, w11, wzr, ne
4000249c: eb0c015f     	cmp	x10, x12
400024a0: 54ffff61     	b.ne	0x4000248c <script_execute_line+0xa4>
400024a4: 35fffd6b     	cbnz	w11, 0x40002450 <script_execute_line+0x68>
400024a8: 7101a53f     	cmp	w9, #0x69
400024ac: 54fffd20     	b.eq	0x40002450 <script_execute_line+0x68>
400024b0: 7101991f     	cmp	w8, #0x66
400024b4: 54fffce0     	b.eq	0x40002450 <script_execute_line+0x68>
400024b8: 910403e8     	add	x8, sp, #0x100
400024bc: 910403e0     	add	x0, sp, #0x100
400024c0: 8b0a0101     	add	x1, x8, x10
400024c4: 3800143f     	strb	wzr, [x1], #0x1
400024c8: 97ffff0d     	bl	0x400020fc <script_set_var>
400024cc: 14000087     	b	0x400026e8 <script_execute_line+0x300>
400024d0: 394403e9     	ldrb	w9, [sp, #0x100]
400024d4: 7101a53f     	cmp	w9, #0x69
400024d8: 54001041     	b.ne	0x400026e0 <script_execute_line+0x2f8>
400024dc: 7101991f     	cmp	w8, #0x66
400024e0: 54001001     	b.ne	0x400026e0 <script_execute_line+0x2f8>
400024e4: 39440be8     	ldrb	w8, [sp, #0x102]
400024e8: 7100811f     	cmp	w8, #0x20
400024ec: 54000fa1     	b.ne	0x400026e0 <script_execute_line+0x2f8>
400024f0: 39440fe9     	ldrb	w9, [sp, #0x103]
400024f4: 7100813f     	cmp	w9, #0x20
400024f8: 54000081     	b.ne	0x40002508 <script_execute_line+0x120>
400024fc: aa1f03e9     	mov	x9, xzr
40002500: 52800068     	mov	w8, #0x3                // =3
40002504: 14000014     	b	0x40002554 <script_execute_line+0x16c>
40002508: 910403ea     	add	x10, sp, #0x100
4000250c: aa1f03e8     	mov	x8, xzr
40002510: 910303eb     	add	x11, sp, #0xc0
40002514: 9100114a     	add	x10, x10, #0x4
40002518: 34000189     	cbz	w9, 0x40002548 <script_execute_line+0x160>
4000251c: f100f91f     	cmp	x8, #0x3e
40002520: 54000148     	b.hi	0x40002548 <script_execute_line+0x160>
40002524: 38286969     	strb	w9, [x11, x8]
40002528: 38686949     	ldrb	w9, [x10, x8]
4000252c: 9100050c     	add	x12, x8, #0x1
40002530: aa0c03e8     	mov	x8, x12
40002534: 7100813f     	cmp	w9, #0x20
40002538: 54ffff01     	b.ne	0x40002518 <script_execute_line+0x130>
4000253c: 11000d8a     	add	w10, w12, #0x3
40002540: 2a0c03e8     	mov	w8, w12
40002544: 14000002     	b	0x4000254c <script_execute_line+0x164>
40002548: 11000d0a     	add	w10, w8, #0x3
4000254c: 2a0803e9     	mov	w9, w8
40002550: 2a0a03e8     	mov	w8, w10
40002554: 910303ea     	add	x10, sp, #0xc0
40002558: 3829695f     	strb	wzr, [x10, x9]
4000255c: 910403e9     	add	x9, sp, #0x100
40002560: 3868692a     	ldrb	w10, [x9, x8]
40002564: 7100815f     	cmp	w10, #0x20
40002568: 54000061     	b.ne	0x40002574 <script_execute_line+0x18c>
4000256c: 91000508     	add	x8, x8, #0x1
40002570: 17fffffc     	b	0x40002560 <script_execute_line+0x178>
40002574: 7100855f     	cmp	w10, #0x21
40002578: 54000060     	b.eq	0x40002584 <script_execute_line+0x19c>
4000257c: 7100f55f     	cmp	w10, #0x3d
40002580: 540000e1     	b.ne	0x4000259c <script_execute_line+0x1b4>
40002584: 11000509     	add	w9, w8, #0x1
40002588: 910403ea     	add	x10, sp, #0x100
4000258c: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002590: 9100090a     	add	x10, x8, #0x2
40002594: 7100f53f     	cmp	w9, #0x3d
40002598: 9a880148     	csel	x8, x10, x8, eq
4000259c: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
400025a0: 910403ea     	add	x10, sp, #0x100
400025a4: d2c0002b     	mov	x11, #0x100000000       // =4294967296
400025a8: 8b088129     	add	x9, x9, x8, lsl #32
400025ac: 8b28c14a     	add	x10, x10, w8, sxtw
400025b0: 51000508     	sub	w8, w8, #0x1
400025b4: 3840154c     	ldrb	w12, [x10], #0x1
400025b8: 8b0b0129     	add	x9, x9, x11
400025bc: 11000508     	add	w8, w8, #0x1
400025c0: 7100819f     	cmp	w12, #0x20
400025c4: 54ffff80     	b.eq	0x400025b4 <script_execute_line+0x1cc>
400025c8: 9360fd2c     	asr	x12, x9, #32
400025cc: 910403e9     	add	x9, sp, #0x100
400025d0: 386c692d     	ldrb	w13, [x9, x12]
400025d4: 710081bf     	cmp	w13, #0x20
400025d8: 54000061     	b.ne	0x400025e4 <script_execute_line+0x1fc>
400025dc: aa1f03ea     	mov	x10, xzr
400025e0: 14000010     	b	0x40002620 <script_execute_line+0x238>
400025e4: aa1f03eb     	mov	x11, xzr
400025e8: 910203ec     	add	x12, sp, #0x80
400025ec: 3400016d     	cbz	w13, 0x40002618 <script_execute_line+0x230>
400025f0: f100f97f     	cmp	x11, #0x3e
400025f4: 54000128     	b.hi	0x40002618 <script_execute_line+0x230>
400025f8: 382b698d     	strb	w13, [x12, x11]
400025fc: 386b694d     	ldrb	w13, [x10, x11]
40002600: 9100056e     	add	x14, x11, #0x1
40002604: 11000508     	add	w8, w8, #0x1
40002608: aa0e03eb     	mov	x11, x14
4000260c: 710081bf     	cmp	w13, #0x20
40002610: 54fffee1     	b.ne	0x400025ec <script_execute_line+0x204>
40002614: 2a0e03eb     	mov	w11, w14
40002618: 93407d0c     	sxtw	x12, w8
4000261c: 2a0b03ea     	mov	w10, w11
40002620: d3607d8d     	lsl	x13, x12, #32
40002624: 910203eb     	add	x11, sp, #0x80
40002628: d2c0006f     	mov	x15, #0x300000000       // =12884901888
4000262c: d2c00050     	mov	x16, #0x200000000       // =8589934592
40002630: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002634: 11001108     	add	w8, w8, #0x4
40002638: 382a697f     	strb	wzr, [x11, x10]
4000263c: 8b0f01aa     	add	x10, x13, x15
40002640: 8b1001ab     	add	x11, x13, x16
40002644: 8b0e01ad     	add	x13, x13, x14
40002648: 8b0c0129     	add	x9, x9, x12
4000264c: 3840152c     	ldrb	w12, [x9], #0x1
40002650: 7100819f     	cmp	w12, #0x20
40002654: 540000c1     	b.ne	0x4000266c <script_execute_line+0x284>
40002658: 11000508     	add	w8, w8, #0x1
4000265c: 8b0e014a     	add	x10, x10, x14
40002660: 8b0e016b     	add	x11, x11, x14
40002664: 8b0e01ad     	add	x13, x13, x14
40002668: 17fffff9     	b	0x4000264c <script_execute_line+0x264>
4000266c: 7101d19f     	cmp	w12, #0x74
40002670: 54000381     	b.ne	0x400026e0 <script_execute_line+0x2f8>
40002674: 9360fdac     	asr	x12, x13, #32
40002678: 910403e9     	add	x9, sp, #0x100
4000267c: 386c692c     	ldrb	w12, [x9, x12]
40002680: 7101a19f     	cmp	w12, #0x68
40002684: 540002e1     	b.ne	0x400026e0 <script_execute_line+0x2f8>
40002688: 9360fd6b     	asr	x11, x11, #32
4000268c: 386b6929     	ldrb	w9, [x9, x11]
40002690: 7101953f     	cmp	w9, #0x65
40002694: 54000261     	b.ne	0x400026e0 <script_execute_line+0x2f8>
40002698: 9360fd4a     	asr	x10, x10, #32
4000269c: 910403e9     	add	x9, sp, #0x100
400026a0: 386a692a     	ldrb	w10, [x9, x10]
400026a4: 7101b95f     	cmp	w10, #0x6e
400026a8: 540001c1     	b.ne	0x400026e0 <script_execute_line+0x2f8>
400026ac: 8b28c128     	add	x8, x9, w8, sxtw
400026b0: d1000501     	sub	x1, x8, #0x1
400026b4: 38401c28     	ldrb	w8, [x1, #0x1]!
400026b8: 7100811f     	cmp	w8, #0x20
400026bc: 54ffffc0     	b.eq	0x400026b4 <script_execute_line+0x2cc>
400026c0: 910003e0     	mov	x0, sp
400026c4: 94000075     	bl	0x40002898 <kstrcpy>
400026c8: 910303e0     	add	x0, sp, #0xc0
400026cc: 910203e1     	add	x1, sp, #0x80
400026d0: 94000053     	bl	0x4000281c <kstrcmp>
400026d4: 350000a0     	cbnz	w0, 0x400026e8 <script_execute_line+0x300>
400026d8: 910003e0     	mov	x0, sp
400026dc: 14000002     	b	0x400026e4 <script_execute_line+0x2fc>
400026e0: 910403e0     	add	x0, sp, #0x100
400026e4: 97fff9bb     	bl	0x40000dd0 <execute_command>
400026e8: 2a1f03e0     	mov	w0, wzr
400026ec: 910803ff     	add	sp, sp, #0x200
400026f0: a9414ffc     	ldp	x28, x19, [sp, #0x10]
400026f4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400026f8: d65f03c0     	ret

00000000400026fc <script_run_file>:
400026fc: d10503ff     	sub	sp, sp, #0x140
40002700: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002704: 910403fd     	add	x29, sp, #0x100
40002708: f9008bfc     	str	x28, [sp, #0x110]
4000270c: a91257f6     	stp	x22, x21, [sp, #0x120]
40002710: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002714: aa0003f4     	mov	x20, x0
40002718: 940008b8     	bl	0x400049f8 <vfs_find>
4000271c: b4000080     	cbz	x0, 0x4000272c <script_run_file+0x30>
40002720: b9402008     	ldr	w8, [x0, #0x20]
40002724: aa0003f3     	mov	x19, x0
40002728: 340000e8     	cbz	w8, 0x40002744 <script_run_file+0x48>
4000272c: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002730: 91016800     	add	x0, x0, #0x5a
40002734: aa1403e1     	mov	x1, x20
40002738: 940004e7     	bl	0x40003ad4 <uart_printf>
4000273c: 12800000     	mov	w0, #-0x1               // =-1
40002740: 14000021     	b	0x400027c4 <script_run_file+0xc8>
40002744: f9401668     	ldr	x8, [x19, #0x28]
40002748: aa1f03f4     	mov	x20, xzr
4000274c: 2a1f03e9     	mov	w9, wzr
40002750: 9100c275     	add	x21, x19, #0x30
40002754: 910003f6     	mov	x22, sp
40002758: 14000008     	b	0x40002778 <script_run_file+0x7c>
4000275c: 7100053f     	cmp	w9, #0x1
40002760: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002764: 2a1f03e9     	mov	w9, wzr
40002768: 5400022a     	b.ge	0x400027ac <script_run_file+0xb0>
4000276c: 91000694     	add	x20, x20, #0x1
40002770: eb08029f     	cmp	x20, x8
40002774: 54000268     	b.hi	0x400027c0 <script_run_file+0xc4>
40002778: eb08029f     	cmp	x20, x8
4000277c: 54ffff00     	b.eq	0x4000275c <script_run_file+0x60>
40002780: 38746aaa     	ldrb	w10, [x21, x20]
40002784: 7100295f     	cmp	w10, #0xa
40002788: 54fffea0     	b.eq	0x4000275c <script_run_file+0x60>
4000278c: 7100355f     	cmp	w10, #0xd
40002790: 54fffee0     	b.eq	0x4000276c <script_run_file+0x70>
40002794: 7103f93f     	cmp	w9, #0xfe
40002798: 54fffeac     	b.gt	0x4000276c <script_run_file+0x70>
4000279c: 1100052b     	add	w11, w9, #0x1
400027a0: 3829caca     	strb	w10, [x22, w9, sxtw]
400027a4: 2a0b03e9     	mov	w9, w11
400027a8: 17fffff1     	b	0x4000276c <script_run_file+0x70>
400027ac: 910003e0     	mov	x0, sp
400027b0: 97ffff0e     	bl	0x400023e8 <script_execute_line>
400027b4: f9401668     	ldr	x8, [x19, #0x28]
400027b8: 2a1f03e9     	mov	w9, wzr
400027bc: 17ffffec     	b	0x4000276c <script_run_file+0x70>
400027c0: 2a1f03e0     	mov	w0, wzr
400027c4: a9534ff4     	ldp	x20, x19, [sp, #0x130]
400027c8: f9408bfc     	ldr	x28, [sp, #0x110]
400027cc: a95257f6     	ldp	x22, x21, [sp, #0x120]
400027d0: a9507bfd     	ldp	x29, x30, [sp, #0x100]
400027d4: 910503ff     	add	sp, sp, #0x140
400027d8: d65f03c0     	ret

00000000400027dc <kstrlen>:
400027dc: b40000c0     	cbz	x0, 0x400027f4 <kstrlen+0x18>
400027e0: aa1f03e8     	mov	x8, xzr
400027e4: 38686809     	ldrb	w9, [x0, x8]
400027e8: 91000508     	add	x8, x8, #0x1
400027ec: 35ffffc9     	cbnz	w9, 0x400027e4 <kstrlen+0x8>
400027f0: d1000500     	sub	x0, x8, #0x1
400027f4: d65f03c0     	ret

00000000400027f8 <kstrcat>:
400027f8: b4000100     	cbz	x0, 0x40002818 <kstrcat+0x20>
400027fc: b40000e1     	cbz	x1, 0x40002818 <kstrcat+0x20>
40002800: d1000408     	sub	x8, x0, #0x1
40002804: 38401d09     	ldrb	w9, [x8, #0x1]!
40002808: 35ffffe9     	cbnz	w9, 0x40002804 <kstrcat+0xc>
4000280c: 38401429     	ldrb	w9, [x1], #0x1
40002810: 38001509     	strb	w9, [x8], #0x1
40002814: 35ffffc9     	cbnz	w9, 0x4000280c <kstrcat+0x14>
40002818: d65f03c0     	ret

000000004000281c <kstrcmp>:
4000281c: aa0003e8     	mov	x8, x0
40002820: 12800000     	mov	w0, #-0x1               // =-1
40002824: b4000188     	cbz	x8, 0x40002854 <kstrcmp+0x38>
40002828: b4000161     	cbz	x1, 0x40002854 <kstrcmp+0x38>
4000282c: 38401509     	ldrb	w9, [x8], #0x1
40002830: 340000e9     	cbz	w9, 0x4000284c <kstrcmp+0x30>
40002834: 3940002a     	ldrb	w10, [x1]
40002838: 6b0a013f     	cmp	w9, w10
4000283c: 54000081     	b.ne	0x4000284c <kstrcmp+0x30>
40002840: 38401509     	ldrb	w9, [x8], #0x1
40002844: 91000421     	add	x1, x1, #0x1
40002848: 35ffff69     	cbnz	w9, 0x40002834 <kstrcmp+0x18>
4000284c: 39400028     	ldrb	w8, [x1]
40002850: 4b080120     	sub	w0, w9, w8
40002854: d65f03c0     	ret

0000000040002858 <kstrncmp>:
40002858: 12800008     	mov	w8, #-0x1               // =-1
4000285c: b4000160     	cbz	x0, 0x40002888 <kstrncmp+0x30>
40002860: b4000141     	cbz	x1, 0x40002888 <kstrncmp+0x30>
40002864: b4000102     	cbz	x2, 0x40002884 <kstrncmp+0x2c>
40002868: 38401408     	ldrb	w8, [x0], #0x1
4000286c: 38401429     	ldrb	w9, [x1], #0x1
40002870: 34000108     	cbz	w8, 0x40002890 <kstrncmp+0x38>
40002874: 6b09011f     	cmp	w8, w9
40002878: 540000c1     	b.ne	0x40002890 <kstrncmp+0x38>
4000287c: f1000442     	subs	x2, x2, #0x1
40002880: 54ffff41     	b.ne	0x40002868 <kstrncmp+0x10>
40002884: 2a1f03e8     	mov	w8, wzr
40002888: 2a0803e0     	mov	w0, w8
4000288c: d65f03c0     	ret
40002890: 4b090100     	sub	w0, w8, w9
40002894: d65f03c0     	ret

0000000040002898 <kstrcpy>:
40002898: b40000c0     	cbz	x0, 0x400028b0 <kstrcpy+0x18>
4000289c: b40000a1     	cbz	x1, 0x400028b0 <kstrcpy+0x18>
400028a0: aa0003e8     	mov	x8, x0
400028a4: 38401429     	ldrb	w9, [x1], #0x1
400028a8: 38001509     	strb	w9, [x8], #0x1
400028ac: 35ffffc9     	cbnz	w9, 0x400028a4 <kstrcpy+0xc>
400028b0: d65f03c0     	ret

00000000400028b4 <kstrncpy>:
400028b4: b4000480     	cbz	x0, 0x40002944 <kstrncpy+0x90>
400028b8: b4000461     	cbz	x1, 0x40002944 <kstrncpy+0x90>
400028bc: b4000442     	cbz	x2, 0x40002944 <kstrncpy+0x90>
400028c0: aa1f03e9     	mov	x9, xzr
400028c4: aa0203e8     	mov	x8, x2
400028c8: 3869682a     	ldrb	w10, [x1, x9]
400028cc: 3829680a     	strb	w10, [x0, x9]
400028d0: 340000ca     	cbz	w10, 0x400028e8 <kstrncpy+0x34>
400028d4: 91000529     	add	x9, x9, #0x1
400028d8: d1000508     	sub	x8, x8, #0x1
400028dc: eb09005f     	cmp	x2, x9
400028e0: 54ffff41     	b.ne	0x400028c8 <kstrncpy+0x14>
400028e4: 14000018     	b	0x40002944 <kstrncpy+0x90>
400028e8: cb09004a     	sub	x10, x2, x9
400028ec: 8b090009     	add	x9, x0, x9
400028f0: f100095f     	cmp	x10, #0x2
400028f4: 54000082     	b.hs	0x40002904 <kstrncpy+0x50>
400028f8: 91000528     	add	x8, x9, #0x1
400028fc: aa0a03e9     	mov	x9, x10
40002900: 1400000e     	b	0x40002938 <kstrncpy+0x84>
40002904: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002908: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
4000290c: 9100092c     	add	x12, x9, #0x2
40002910: 8b090108     	add	x8, x8, x9
40002914: 92400149     	and	x9, x10, #0x1
40002918: aa0b03ed     	mov	x13, x11
4000291c: 91000508     	add	x8, x8, #0x1
40002920: f10009ad     	subs	x13, x13, #0x2
40002924: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002928: 3800259f     	strb	wzr, [x12], #0x2
4000292c: 54ffffa1     	b.ne	0x40002920 <kstrncpy+0x6c>
40002930: eb0b015f     	cmp	x10, x11
40002934: 54000080     	b.eq	0x40002944 <kstrncpy+0x90>
40002938: f1000529     	subs	x9, x9, #0x1
4000293c: 3800151f     	strb	wzr, [x8], #0x1
40002940: 54ffffc1     	b.ne	0x40002938 <kstrncpy+0x84>
40002944: d65f03c0     	ret

0000000040002948 <memset>:
40002948: b40002a0     	cbz	x0, 0x4000299c <memset+0x54>
4000294c: b4000282     	cbz	x2, 0x4000299c <memset+0x54>
40002950: f100085f     	cmp	x2, #0x2
40002954: 54000082     	b.hs	0x40002964 <memset+0x1c>
40002958: aa0003e8     	mov	x8, x0
4000295c: aa0203e9     	mov	x9, x2
40002960: 1400000c     	b	0x40002990 <memset+0x48>
40002964: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
40002968: 92400049     	and	x9, x2, #0x1
4000296c: 9100040b     	add	x11, x0, #0x1
40002970: 8b0a0008     	add	x8, x0, x10
40002974: aa0a03ec     	mov	x12, x10
40002978: f100098c     	subs	x12, x12, #0x2
4000297c: 381ff161     	sturb	w1, [x11, #-0x1]
40002980: 38002561     	strb	w1, [x11], #0x2
40002984: 54ffffa1     	b.ne	0x40002978 <memset+0x30>
40002988: eb0a005f     	cmp	x2, x10
4000298c: 54000080     	b.eq	0x4000299c <memset+0x54>
40002990: f1000529     	subs	x9, x9, #0x1
40002994: 38001501     	strb	w1, [x8], #0x1
40002998: 54ffffc1     	b.ne	0x40002990 <memset+0x48>
4000299c: d65f03c0     	ret

00000000400029a0 <memcpy>:
400029a0: b4000100     	cbz	x0, 0x400029c0 <memcpy+0x20>
400029a4: b40000e1     	cbz	x1, 0x400029c0 <memcpy+0x20>
400029a8: b40000c2     	cbz	x2, 0x400029c0 <memcpy+0x20>
400029ac: aa0003e8     	mov	x8, x0
400029b0: 38401429     	ldrb	w9, [x1], #0x1
400029b4: f1000442     	subs	x2, x2, #0x1
400029b8: 38001509     	strb	w9, [x8], #0x1
400029bc: 54ffffa1     	b.ne	0x400029b0 <memcpy+0x10>
400029c0: d65f03c0     	ret

00000000400029c4 <kstrstr>:
400029c4: aa1f03e2     	mov	x2, xzr
400029c8: b40000e0     	cbz	x0, 0x400029e4 <kstrstr+0x20>
400029cc: b40000c1     	cbz	x1, 0x400029e4 <kstrstr+0x20>
400029d0: 39400028     	ldrb	w8, [x1]
400029d4: 340002c8     	cbz	w8, 0x40002a2c <kstrstr+0x68>
400029d8: 39400009     	ldrb	w9, [x0]
400029dc: 35000109     	cbnz	w9, 0x400029fc <kstrstr+0x38>
400029e0: aa1f03e2     	mov	x2, xzr
400029e4: aa0203e0     	mov	x0, x2
400029e8: d65f03c0     	ret
400029ec: 3940012c     	ldrb	w12, [x9]
400029f0: 340001ec     	cbz	w12, 0x40002a2c <kstrstr+0x68>
400029f4: 38401c09     	ldrb	w9, [x0, #0x1]!
400029f8: 34ffff49     	cbz	w9, 0x400029e0 <kstrstr+0x1c>
400029fc: 6b08013f     	cmp	w9, w8
40002a00: 54ffffa1     	b.ne	0x400029f4 <kstrstr+0x30>
40002a04: 5280002a     	mov	w10, #0x1               // =1
40002a08: aa0103e9     	mov	x9, x1
40002a0c: 2a0803eb     	mov	w11, w8
40002a10: 3840152c     	ldrb	w12, [x9], #0x1
40002a14: 6b0c017f     	cmp	w11, w12
40002a18: 54fffec1     	b.ne	0x400029f0 <kstrstr+0x2c>
40002a1c: 386a680b     	ldrb	w11, [x0, x10]
40002a20: 9100054a     	add	x10, x10, #0x1
40002a24: 35ffff6b     	cbnz	w11, 0x40002a10 <kstrstr+0x4c>
40002a28: 17fffff1     	b	0x400029ec <kstrstr+0x28>
40002a2c: d65f03c0     	ret

0000000040002a30 <kstrchr>:
40002a30: b4000140     	cbz	x0, 0x40002a58 <kstrchr+0x28>
40002a34: 39400009     	ldrb	w9, [x0]
40002a38: 340000c9     	cbz	w9, 0x40002a50 <kstrchr+0x20>
40002a3c: 12001c28     	and	w8, w1, #0xff
40002a40: 6b08013f     	cmp	w9, w8
40002a44: 540000a0     	b.eq	0x40002a58 <kstrchr+0x28>
40002a48: 38401c09     	ldrb	w9, [x0, #0x1]!
40002a4c: 35ffffa9     	cbnz	w9, 0x40002a40 <kstrchr+0x10>
40002a50: 72001c3f     	tst	w1, #0xff
40002a54: 9a9f0000     	csel	x0, x0, xzr, eq
40002a58: d65f03c0     	ret

0000000040002a5c <ktolower>:
40002a5c: 51010408     	sub	w8, w0, #0x41
40002a60: 321b0009     	orr	w9, w0, #0x20
40002a64: 7100691f     	cmp	w8, #0x1a
40002a68: 1a803120     	csel	w0, w9, w0, lo
40002a6c: d65f03c0     	ret

0000000040002a70 <kstr_tolower>:
40002a70: b40001a0     	cbz	x0, 0x40002aa4 <kstr_tolower+0x34>
40002a74: b4000181     	cbz	x1, 0x40002aa4 <kstr_tolower+0x34>
40002a78: 39400029     	ldrb	w9, [x1]
40002a7c: 34000129     	cbz	w9, 0x40002aa0 <kstr_tolower+0x30>
40002a80: 91000428     	add	x8, x1, #0x1
40002a84: 5101052a     	sub	w10, w9, #0x41
40002a88: 321b012b     	orr	w11, w9, #0x20
40002a8c: 7100695f     	cmp	w10, #0x1a
40002a90: 1a893169     	csel	w9, w11, w9, lo
40002a94: 38001409     	strb	w9, [x0], #0x1
40002a98: 38401509     	ldrb	w9, [x8], #0x1
40002a9c: 35ffff49     	cbnz	w9, 0x40002a84 <kstr_tolower+0x14>
40002aa0: 3900001f     	strb	wzr, [x0]
40002aa4: d65f03c0     	ret

0000000040002aa8 <timer_init>:
40002aa8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002aac: f9000bf3     	str	x19, [sp, #0x10]
40002ab0: b0000073     	adrp	x19, 0x4000f000 <var_values+0x6a8>
40002ab4: 528003c0     	mov	w0, #0x1e               // =30
40002ab8: 910003fd     	mov	x29, sp
40002abc: d53be008     	mrs	x8, CNTFRQ_EL0
40002ac0: 52800029     	mov	w9, #0x1                // =1
40002ac4: f904ae68     	str	x8, [x19, #0x958]
40002ac8: d51be208     	msr	CNTP_TVAL_EL0, x8
40002acc: d51be229     	msr	CNTP_CTL_EL0, x9
40002ad0: 97fff5d3     	bl	0x4000021c <gic_enable_interrupt>
40002ad4: d50342ff     	msr	DAIFClr, #0x2
40002ad8: d503201f     	nop
40002adc: 70032da0     	adr	x0, 0x40009093 <__rodata_start+0x2093>
40002ae0: b9495a61     	ldr	w1, [x19, #0x958]
40002ae4: f9400bf3     	ldr	x19, [sp, #0x10]
40002ae8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002aec: 140003fa     	b	0x40003ad4 <uart_printf>

0000000040002af0 <timer_handle_interrupt>:
40002af0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002af4: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002af8: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002afc: 91249800     	add	x0, x0, #0x926
40002b00: f944b109     	ldr	x9, [x8, #0x960]
40002b04: 910003fd     	mov	x29, sp
40002b08: 91000529     	add	x9, x9, #0x1
40002b0c: f904b109     	str	x9, [x8, #0x960]
40002b10: 940002dc     	bl	0x40003680 <uart_puts>
40002b14: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b18: f944ad08     	ldr	x8, [x8, #0x958]
40002b1c: d51be208     	msr	CNTP_TVAL_EL0, x8
40002b20: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002b24: d65f03c0     	ret

0000000040002b28 <tui_launch>:
40002b28: d105c3ff     	sub	sp, sp, #0x170
40002b2c: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b30: 910443fd     	add	x29, sp, #0x110
40002b34: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002b38: a91367fa     	stp	x26, x25, [sp, #0x130]
40002b3c: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002b40: a91557f6     	stp	x22, x21, [sp, #0x150]
40002b44: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002b48: 9400075a     	bl	0x400048b0 <vfs_get_cwd>
40002b4c: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b50: b000007c     	adrp	x28, 0x4000f000 <var_values+0x6a8>
40002b54: b000007b     	adrp	x27, 0x4000f000 <var_values+0x6a8>
40002b58: f904b500     	str	x0, [x8, #0x968]
40002b5c: d503201f     	nop
40002b60: 5002e1c0     	adr	x0, 0x4000879a <__rodata_start+0x179a>
40002b64: b909739f     	str	wzr, [x28, #0x970]
40002b68: b909777f     	str	wzr, [x27, #0x974]
40002b6c: 940002c5     	bl	0x40003680 <uart_puts>
40002b70: b0000036     	adrp	x22, 0x40007000 <__rodata_start>
40002b74: 9111fed6     	add	x22, x22, #0x47f
40002b78: b0000037     	adrp	x23, 0x40007000 <__rodata_start>
40002b7c: 910dbef7     	add	x23, x23, #0x36f
40002b80: b0000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40002b84: 91260318     	add	x24, x24, #0x980
40002b88: b000007a     	adrp	x26, 0x4000f000 <var_values+0x6a8>
40002b8c: b0000034     	adrp	x20, 0x40007000 <__rodata_start>
40002b90: 91158294     	add	x20, x20, #0x560
40002b94: 14000005     	b	0x40002ba8 <tui_launch+0x80>
40002b98: b9497388     	ldr	w8, [x28, #0x970]
40002b9c: 7100011f     	cmp	w8, #0x0
40002ba0: 1a9f17e8     	cset	w8, eq
40002ba4: b9097388     	str	w8, [x28, #0x970]
40002ba8: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002bac: b9097b5f     	str	wzr, [x26, #0x978]
40002bb0: f944b50a     	ldr	x10, [x8, #0x968]
40002bb4: f9421948     	ldr	x8, [x10, #0x430]
40002bb8: b4000108     	cbz	x8, 0x40002bd8 <tui_launch+0xb0>
40002bbc: 52800029     	mov	w9, #0x1                // =1
40002bc0: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002bc4: b9097b49     	str	w9, [x26, #0x978]
40002bc8: f904c11f     	str	xzr, [x8, #0x980]
40002bcc: f9401548     	ldr	x8, [x10, #0x28]
40002bd0: b50000a8     	cbnz	x8, 0x40002be4 <tui_launch+0xbc>
40002bd4: 14000027     	b	0x40002c70 <tui_launch+0x148>
40002bd8: 2a1f03e9     	mov	w9, wzr
40002bdc: f9401548     	ldr	x8, [x10, #0x28]
40002be0: b4000488     	cbz	x8, 0x40002c70 <tui_launch+0x148>
40002be4: 2a0903e9     	mov	w9, w9
40002be8: d100050c     	sub	x12, x8, #0x1
40002bec: d240152b     	eor	x11, x9, #0x3f
40002bf0: eb0b019f     	cmp	x12, x11
40002bf4: 9a8b318b     	csel	x11, x12, x11, lo
40002bf8: b400022c     	cbz	x12, 0x40002c3c <tui_launch+0x114>
40002bfc: 9100056c     	add	x12, x11, #0x1
40002c00: 8b090f0e     	add	x14, x24, x9, lsl #3
40002c04: 9111014d     	add	x13, x10, #0x440
40002c08: 927f798b     	and	x11, x12, #0xfffffffe
40002c0c: aa090169     	orr	x9, x11, x9
40002c10: 910021ce     	add	x14, x14, #0x8
40002c14: aa0b03ef     	mov	x15, x11
40002c18: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002c1c: f10009ef     	subs	x15, x15, #0x2
40002c20: 910041ad     	add	x13, x13, #0x10
40002c24: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002c28: 910041ce     	add	x14, x14, #0x10
40002c2c: 54ffff61     	b.ne	0x40002c18 <tui_launch+0xf0>
40002c30: eb0b019f     	cmp	x12, x11
40002c34: 54000061     	b.ne	0x40002c40 <tui_launch+0x118>
40002c38: 1400000d     	b	0x40002c6c <tui_launch+0x144>
40002c3c: aa1f03eb     	mov	x11, xzr
40002c40: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002c44: 9100056b     	add	x11, x11, #0x1
40002c48: 9110e14a     	add	x10, x10, #0x438
40002c4c: f840854c     	ldr	x12, [x10], #0x8
40002c50: f100f93f     	cmp	x9, #0x3e
40002c54: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002c58: 91000529     	add	x9, x9, #0x1
40002c5c: 54000088     	b.hi	0x40002c6c <tui_launch+0x144>
40002c60: eb08017f     	cmp	x11, x8
40002c64: 9100056b     	add	x11, x11, #0x1
40002c68: 54ffff23     	b.lo	0x40002c4c <tui_launch+0x124>
40002c6c: b9097b49     	str	w9, [x26, #0x978]
40002c70: b949776a     	ldr	w10, [x27, #0x974]
40002c74: 51000528     	sub	w8, w9, #0x1
40002c78: 6b08015f     	cmp	w10, w8
40002c7c: 1a88b148     	csel	w8, w10, w8, lt
40002c80: 6b09015f     	cmp	w10, w9
40002c84: 5400004a     	b.ge	0x40002c8c <tui_launch+0x164>
40002c88: 36f80068     	tbz	w8, #0x1f, 0x40002c94 <tui_launch+0x16c>
40002c8c: 0aa87d08     	bic	w8, w8, w8, asr #31
40002c90: b9097768     	str	w8, [x27, #0x974]
40002c94: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002c98: 9124a000     	add	x0, x0, #0x928
40002c9c: 94000279     	bl	0x40003680 <uart_puts>
40002ca0: b9497388     	ldr	w8, [x28, #0x970]
40002ca4: 52800020     	mov	w0, #0x1                // =1
40002ca8: 52800501     	mov	w1, #0x28               // =40
40002cac: b0000022     	adrp	x2, 0x40007000 <__rodata_start>
40002cb0: 91036442     	add	x2, x2, #0xd9
40002cb4: 7100011f     	cmp	w8, #0x0
40002cb8: 1a9f17e3     	cset	w3, eq
40002cbc: 94000171     	bl	0x40003280 <draw_box>
40002cc0: 52800075     	mov	w21, #0x3               // =3
40002cc4: aa1603e0     	mov	x0, x22
40002cc8: 2a1503e1     	mov	w1, w21
40002ccc: 52800042     	mov	w2, #0x2                // =2
40002cd0: 94000381     	bl	0x40003ad4 <uart_printf>
40002cd4: aa1703e0     	mov	x0, x23
40002cd8: 9400026a     	bl	0x40003680 <uart_puts>
40002cdc: aa1703e0     	mov	x0, x23
40002ce0: 94000268     	bl	0x40003680 <uart_puts>
40002ce4: aa1703e0     	mov	x0, x23
40002ce8: 94000266     	bl	0x40003680 <uart_puts>
40002cec: aa1703e0     	mov	x0, x23
40002cf0: 94000264     	bl	0x40003680 <uart_puts>
40002cf4: aa1703e0     	mov	x0, x23
40002cf8: 94000262     	bl	0x40003680 <uart_puts>
40002cfc: aa1703e0     	mov	x0, x23
40002d00: 94000260     	bl	0x40003680 <uart_puts>
40002d04: aa1703e0     	mov	x0, x23
40002d08: 9400025e     	bl	0x40003680 <uart_puts>
40002d0c: aa1703e0     	mov	x0, x23
40002d10: 9400025c     	bl	0x40003680 <uart_puts>
40002d14: aa1703e0     	mov	x0, x23
40002d18: 9400025a     	bl	0x40003680 <uart_puts>
40002d1c: aa1703e0     	mov	x0, x23
40002d20: 94000258     	bl	0x40003680 <uart_puts>
40002d24: aa1703e0     	mov	x0, x23
40002d28: 94000256     	bl	0x40003680 <uart_puts>
40002d2c: aa1703e0     	mov	x0, x23
40002d30: 94000254     	bl	0x40003680 <uart_puts>
40002d34: aa1703e0     	mov	x0, x23
40002d38: 94000252     	bl	0x40003680 <uart_puts>
40002d3c: aa1703e0     	mov	x0, x23
40002d40: 94000250     	bl	0x40003680 <uart_puts>
40002d44: aa1703e0     	mov	x0, x23
40002d48: 9400024e     	bl	0x40003680 <uart_puts>
40002d4c: aa1703e0     	mov	x0, x23
40002d50: 9400024c     	bl	0x40003680 <uart_puts>
40002d54: aa1703e0     	mov	x0, x23
40002d58: 9400024a     	bl	0x40003680 <uart_puts>
40002d5c: aa1703e0     	mov	x0, x23
40002d60: 94000248     	bl	0x40003680 <uart_puts>
40002d64: aa1703e0     	mov	x0, x23
40002d68: 94000246     	bl	0x40003680 <uart_puts>
40002d6c: aa1703e0     	mov	x0, x23
40002d70: 94000244     	bl	0x40003680 <uart_puts>
40002d74: aa1703e0     	mov	x0, x23
40002d78: 94000242     	bl	0x40003680 <uart_puts>
40002d7c: aa1703e0     	mov	x0, x23
40002d80: 94000240     	bl	0x40003680 <uart_puts>
40002d84: aa1703e0     	mov	x0, x23
40002d88: 9400023e     	bl	0x40003680 <uart_puts>
40002d8c: aa1703e0     	mov	x0, x23
40002d90: 9400023c     	bl	0x40003680 <uart_puts>
40002d94: aa1703e0     	mov	x0, x23
40002d98: 9400023a     	bl	0x40003680 <uart_puts>
40002d9c: aa1703e0     	mov	x0, x23
40002da0: 94000238     	bl	0x40003680 <uart_puts>
40002da4: aa1703e0     	mov	x0, x23
40002da8: 94000236     	bl	0x40003680 <uart_puts>
40002dac: aa1703e0     	mov	x0, x23
40002db0: 94000234     	bl	0x40003680 <uart_puts>
40002db4: aa1703e0     	mov	x0, x23
40002db8: 94000232     	bl	0x40003680 <uart_puts>
40002dbc: aa1703e0     	mov	x0, x23
40002dc0: 94000230     	bl	0x40003680 <uart_puts>
40002dc4: aa1703e0     	mov	x0, x23
40002dc8: 9400022e     	bl	0x40003680 <uart_puts>
40002dcc: aa1703e0     	mov	x0, x23
40002dd0: 9400022c     	bl	0x40003680 <uart_puts>
40002dd4: aa1703e0     	mov	x0, x23
40002dd8: 9400022a     	bl	0x40003680 <uart_puts>
40002ddc: aa1703e0     	mov	x0, x23
40002de0: 94000228     	bl	0x40003680 <uart_puts>
40002de4: aa1703e0     	mov	x0, x23
40002de8: 94000226     	bl	0x40003680 <uart_puts>
40002dec: aa1703e0     	mov	x0, x23
40002df0: 94000224     	bl	0x40003680 <uart_puts>
40002df4: aa1703e0     	mov	x0, x23
40002df8: 94000222     	bl	0x40003680 <uart_puts>
40002dfc: aa1703e0     	mov	x0, x23
40002e00: 94000220     	bl	0x40003680 <uart_puts>
40002e04: 110006b5     	add	w21, w21, #0x1
40002e08: 71005ebf     	cmp	w21, #0x17
40002e0c: 54fff5c1     	b.ne	0x40002cc4 <tui_launch+0x19c>
40002e10: b9497768     	ldr	w8, [x27, #0x974]
40002e14: 52800249     	mov	w9, #0x12               // =18
40002e18: 7100491f     	cmp	w8, #0x12
40002e1c: 1a89c108     	csel	w8, w8, w9, gt
40002e20: 51004915     	sub	w21, w8, #0x12
40002e24: 8b354f19     	add	x25, x24, w21, uxtw #3
40002e28: aa1f03f8     	mov	x24, xzr
40002e2c: 14000004     	b	0x40002e3c <tui_launch+0x314>
40002e30: 91000718     	add	x24, x24, #0x1
40002e34: f100531f     	cmp	x24, #0x14
40002e38: 540005a0     	b.eq	0x40002eec <tui_launch+0x3c4>
40002e3c: b9897b48     	ldrsw	x8, [x26, #0x978]
40002e40: 8b1802b3     	add	x19, x21, x24
40002e44: eb08027f     	cmp	x19, x8
40002e48: 5400052a     	b.ge	0x40002eec <tui_launch+0x3c4>
40002e4c: 11000f01     	add	w1, w24, #0x3
40002e50: aa1603e0     	mov	x0, x22
40002e54: 52800062     	mov	w2, #0x3                // =3
40002e58: 9400031f     	bl	0x40003ad4 <uart_printf>
40002e5c: b9497768     	ldr	w8, [x27, #0x974]
40002e60: eb08027f     	cmp	x19, x8
40002e64: 540000c1     	b.ne	0x40002e7c <tui_launch+0x354>
40002e68: b9497388     	ldr	w8, [x28, #0x970]
40002e6c: 35000088     	cbnz	w8, 0x40002e7c <tui_launch+0x354>
40002e70: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002e74: 9104a400     	add	x0, x0, #0x129
40002e78: 94000202     	bl	0x40003680 <uart_puts>
40002e7c: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002e80: b40001e8     	cbz	x8, 0x40002ebc <tui_launch+0x394>
40002e84: b9402108     	ldr	w8, [x8, #0x20]
40002e88: d0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40002e8c: 91087d29     	add	x9, x9, #0x21f
40002e90: 910223e0     	add	x0, sp, #0x88
40002e94: 7100051f     	cmp	w8, #0x1
40002e98: b0000028     	adrp	x8, 0x40007000 <__rodata_start>
40002e9c: 9134e508     	add	x8, x8, #0xd39
40002ea0: 9a880121     	csel	x1, x9, x8, eq
40002ea4: 97fffe7d     	bl	0x40002898 <kstrcpy>
40002ea8: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002eac: 910223e0     	add	x0, sp, #0x88
40002eb0: 97fffe52     	bl	0x400027f8 <kstrcat>
40002eb4: 910223e0     	add	x0, sp, #0x88
40002eb8: 14000003     	b	0x40002ec4 <tui_launch+0x39c>
40002ebc: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002ec0: 912fc400     	add	x0, x0, #0xbf1
40002ec4: 940001ef     	bl	0x40003680 <uart_puts>
40002ec8: b9497768     	ldr	w8, [x27, #0x974]
40002ecc: eb08027f     	cmp	x19, x8
40002ed0: 54fffb01     	b.ne	0x40002e30 <tui_launch+0x308>
40002ed4: b9497388     	ldr	w8, [x28, #0x970]
40002ed8: 35fffac8     	cbnz	w8, 0x40002e30 <tui_launch+0x308>
40002edc: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002ee0: 9128e400     	add	x0, x0, #0xa39
40002ee4: 940001e7     	bl	0x40003680 <uart_puts>
40002ee8: 17ffffd2     	b	0x40002e30 <tui_launch+0x308>
40002eec: b9497388     	ldr	w8, [x28, #0x970]
40002ef0: 52800540     	mov	w0, #0x2a               // =42
40002ef4: 528004c1     	mov	w1, #0x26               // =38
40002ef8: d0000022     	adrp	x2, 0x40008000 <__rodata_start+0x1000>
40002efc: 9101dc42     	add	x2, x2, #0x77
40002f00: 7100051f     	cmp	w8, #0x1
40002f04: 1a9f17e3     	cset	w3, eq
40002f08: 940000de     	bl	0x40003280 <draw_box>
40002f0c: 52800075     	mov	w21, #0x3               // =3
40002f10: aa1603e0     	mov	x0, x22
40002f14: 2a1503e1     	mov	w1, w21
40002f18: 52800562     	mov	w2, #0x2b               // =43
40002f1c: 940002ee     	bl	0x40003ad4 <uart_printf>
40002f20: aa1703e0     	mov	x0, x23
40002f24: 940001d7     	bl	0x40003680 <uart_puts>
40002f28: aa1703e0     	mov	x0, x23
40002f2c: 940001d5     	bl	0x40003680 <uart_puts>
40002f30: aa1703e0     	mov	x0, x23
40002f34: 940001d3     	bl	0x40003680 <uart_puts>
40002f38: aa1703e0     	mov	x0, x23
40002f3c: 940001d1     	bl	0x40003680 <uart_puts>
40002f40: aa1703e0     	mov	x0, x23
40002f44: 940001cf     	bl	0x40003680 <uart_puts>
40002f48: aa1703e0     	mov	x0, x23
40002f4c: 940001cd     	bl	0x40003680 <uart_puts>
40002f50: aa1703e0     	mov	x0, x23
40002f54: 940001cb     	bl	0x40003680 <uart_puts>
40002f58: aa1703e0     	mov	x0, x23
40002f5c: 940001c9     	bl	0x40003680 <uart_puts>
40002f60: aa1703e0     	mov	x0, x23
40002f64: 940001c7     	bl	0x40003680 <uart_puts>
40002f68: aa1703e0     	mov	x0, x23
40002f6c: 940001c5     	bl	0x40003680 <uart_puts>
40002f70: aa1703e0     	mov	x0, x23
40002f74: 940001c3     	bl	0x40003680 <uart_puts>
40002f78: aa1703e0     	mov	x0, x23
40002f7c: 940001c1     	bl	0x40003680 <uart_puts>
40002f80: aa1703e0     	mov	x0, x23
40002f84: 940001bf     	bl	0x40003680 <uart_puts>
40002f88: aa1703e0     	mov	x0, x23
40002f8c: 940001bd     	bl	0x40003680 <uart_puts>
40002f90: aa1703e0     	mov	x0, x23
40002f94: 940001bb     	bl	0x40003680 <uart_puts>
40002f98: aa1703e0     	mov	x0, x23
40002f9c: 940001b9     	bl	0x40003680 <uart_puts>
40002fa0: aa1703e0     	mov	x0, x23
40002fa4: 940001b7     	bl	0x40003680 <uart_puts>
40002fa8: aa1703e0     	mov	x0, x23
40002fac: 940001b5     	bl	0x40003680 <uart_puts>
40002fb0: aa1703e0     	mov	x0, x23
40002fb4: 940001b3     	bl	0x40003680 <uart_puts>
40002fb8: aa1703e0     	mov	x0, x23
40002fbc: 940001b1     	bl	0x40003680 <uart_puts>
40002fc0: aa1703e0     	mov	x0, x23
40002fc4: 940001af     	bl	0x40003680 <uart_puts>
40002fc8: aa1703e0     	mov	x0, x23
40002fcc: 940001ad     	bl	0x40003680 <uart_puts>
40002fd0: aa1703e0     	mov	x0, x23
40002fd4: 940001ab     	bl	0x40003680 <uart_puts>
40002fd8: aa1703e0     	mov	x0, x23
40002fdc: 940001a9     	bl	0x40003680 <uart_puts>
40002fe0: aa1703e0     	mov	x0, x23
40002fe4: 940001a7     	bl	0x40003680 <uart_puts>
40002fe8: aa1703e0     	mov	x0, x23
40002fec: 940001a5     	bl	0x40003680 <uart_puts>
40002ff0: aa1703e0     	mov	x0, x23
40002ff4: 940001a3     	bl	0x40003680 <uart_puts>
40002ff8: aa1703e0     	mov	x0, x23
40002ffc: 940001a1     	bl	0x40003680 <uart_puts>
40003000: aa1703e0     	mov	x0, x23
40003004: 9400019f     	bl	0x40003680 <uart_puts>
40003008: aa1703e0     	mov	x0, x23
4000300c: 9400019d     	bl	0x40003680 <uart_puts>
40003010: aa1703e0     	mov	x0, x23
40003014: 9400019b     	bl	0x40003680 <uart_puts>
40003018: aa1703e0     	mov	x0, x23
4000301c: 94000199     	bl	0x40003680 <uart_puts>
40003020: aa1703e0     	mov	x0, x23
40003024: 94000197     	bl	0x40003680 <uart_puts>
40003028: aa1703e0     	mov	x0, x23
4000302c: 94000195     	bl	0x40003680 <uart_puts>
40003030: aa1703e0     	mov	x0, x23
40003034: 94000193     	bl	0x40003680 <uart_puts>
40003038: aa1703e0     	mov	x0, x23
4000303c: 94000191     	bl	0x40003680 <uart_puts>
40003040: 110006b5     	add	w21, w21, #0x1
40003044: 71005ebf     	cmp	w21, #0x17
40003048: 54fff641     	b.ne	0x40002f10 <tui_launch+0x3e8>
4000304c: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003050: 91178c00     	add	x0, x0, #0x5e3
40003054: 52800061     	mov	w1, #0x3                // =3
40003058: 52800562     	mov	w2, #0x2b               // =43
4000305c: 9400029e     	bl	0x40003ad4 <uart_printf>
40003060: d503201f     	nop
40003064: 10058f88     	adr	x8, 0x4000e254 <proc_table>
40003068: aa1f03f3     	mov	x19, xzr
4000306c: 9100a115     	add	x21, x8, #0x28
40003070: 52800058     	mov	w24, #0x2               // =2
40003074: 90000039     	adrp	x25, 0x40007000 <__rodata_start>
40003078: 91202339     	add	x25, x25, #0x808
4000307c: b85fc2a8     	ldur	w8, [x21, #-0x4]
40003080: 71000d1f     	cmp	w8, #0x3
40003084: 54000140     	b.eq	0x400030ac <tui_launch+0x584>
40003088: b94002a8     	ldr	w8, [x21]
4000308c: b85d82a3     	ldur	w3, [x21, #-0x28]
40003090: d10092a4     	sub	x4, x21, #0x24
40003094: 11000b01     	add	w1, w24, #0x2
40003098: aa1403e0     	mov	x0, x20
4000309c: 52800562     	mov	w2, #0x2b               // =43
400030a0: 530a7d05     	lsr	w5, w8, #10
400030a4: 9400028c     	bl	0x40003ad4 <uart_printf>
400030a8: 11000718     	add	w24, w24, #0x1
400030ac: f1003a7f     	cmp	x19, #0xe
400030b0: 540000a8     	b.hi	0x400030c4 <tui_launch+0x59c>
400030b4: 7100531f     	cmp	w24, #0x14
400030b8: 91000673     	add	x19, x19, #0x1
400030bc: 9100c2b5     	add	x21, x21, #0x30
400030c0: 54fffdeb     	b.lt	0x4000307c <tui_launch+0x554>
400030c4: 940001a3     	bl	0x40003750 <uart_getc>
400030c8: 52801be8     	mov	w8, #0xdf               // =223
400030cc: 0a080008     	and	w8, w0, w8
400030d0: 7101451f     	cmp	w8, #0x51
400030d4: 54000c00     	b.eq	0x40003254 <tui_launch+0x72c>
400030d8: 12001c08     	and	w8, w0, #0xff
400030dc: 7100311f     	cmp	w8, #0xc
400030e0: 5400010c     	b.gt	0x40003100 <tui_launch+0x5d8>
400030e4: 7100251f     	cmp	w8, #0x9
400030e8: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
400030ec: 91260318     	add	x24, x24, #0x980
400030f0: 54ffd540     	b.eq	0x40002b98 <tui_launch+0x70>
400030f4: 7100291f     	cmp	w8, #0xa
400030f8: 540002e0     	b.eq	0x40003154 <tui_launch+0x62c>
400030fc: 17fffeab     	b	0x40002ba8 <tui_launch+0x80>
40003100: 7100351f     	cmp	w8, #0xd
40003104: 90000078     	adrp	x24, 0x4000f000 <var_values+0x6a8>
40003108: 91260318     	add	x24, x24, #0x980
4000310c: 54000240     	b.eq	0x40003154 <tui_launch+0x62c>
40003110: 71006d1f     	cmp	w8, #0x1b
40003114: 54ffd4a1     	b.ne	0x40002ba8 <tui_launch+0x80>
40003118: 9400018e     	bl	0x40003750 <uart_getc>
4000311c: 12001c13     	and	w19, w0, #0xff
40003120: 9400018c     	bl	0x40003750 <uart_getc>
40003124: 71016e7f     	cmp	w19, #0x5b
40003128: 54ffd401     	b.ne	0x40002ba8 <tui_launch+0x80>
4000312c: 12001c08     	and	w8, w0, #0xff
40003130: 7101051f     	cmp	w8, #0x41
40003134: 54000781     	b.ne	0x40003224 <tui_launch+0x6fc>
40003138: b9497388     	ldr	w8, [x28, #0x970]
4000313c: 35ffd368     	cbnz	w8, 0x40002ba8 <tui_launch+0x80>
40003140: b9497768     	ldr	w8, [x27, #0x974]
40003144: 71000508     	subs	w8, w8, #0x1
40003148: 54ffd30b     	b.lt	0x40002ba8 <tui_launch+0x80>
4000314c: b9097768     	str	w8, [x27, #0x974]
40003150: 17fffe96     	b	0x40002ba8 <tui_launch+0x80>
40003154: b9497388     	ldr	w8, [x28, #0x970]
40003158: 35ffd288     	cbnz	w8, 0x40002ba8 <tui_launch+0x80>
4000315c: b9497b48     	ldr	w8, [x26, #0x978]
40003160: 7100051f     	cmp	w8, #0x1
40003164: 54ffd22b     	b.lt	0x40002ba8 <tui_launch+0x80>
40003168: b9897768     	ldrsw	x8, [x27, #0x974]
4000316c: f8687b15     	ldr	x21, [x24, x8, lsl #3]
40003170: b4000115     	cbz	x21, 0x40003190 <tui_launch+0x668>
40003174: b94022a8     	ldr	w8, [x21, #0x20]
40003178: 7100051f     	cmp	w8, #0x1
4000317c: 54000161     	b.ne	0x400031a8 <tui_launch+0x680>
40003180: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003184: b909777f     	str	wzr, [x27, #0x974]
40003188: f904b515     	str	x21, [x8, #0x968]
4000318c: 17fffe87     	b	0x40002ba8 <tui_launch+0x80>
40003190: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003194: b909777f     	str	wzr, [x27, #0x974]
40003198: f944b528     	ldr	x8, [x9, #0x968]
4000319c: f9421908     	ldr	x8, [x8, #0x430]
400031a0: f904b528     	str	x8, [x9, #0x968]
400031a4: 17fffe81     	b	0x40002ba8 <tui_launch+0x80>
400031a8: 390223ff     	strb	wzr, [sp, #0x88]
400031ac: aa1903e0     	mov	x0, x25
400031b0: 94000612     	bl	0x400049f8 <vfs_find>
400031b4: eb0002bf     	cmp	x21, x0
400031b8: 540001e0     	b.eq	0x400031f4 <tui_launch+0x6cc>
400031bc: 910023e0     	add	x0, sp, #0x8
400031c0: 910223e1     	add	x1, sp, #0x88
400031c4: 97fffdb5     	bl	0x40002898 <kstrcpy>
400031c8: 910223e0     	add	x0, sp, #0x88
400031cc: aa1903e1     	mov	x1, x25
400031d0: 97fffdb2     	bl	0x40002898 <kstrcpy>
400031d4: 910223e0     	add	x0, sp, #0x88
400031d8: aa1503e1     	mov	x1, x21
400031dc: 97fffd87     	bl	0x400027f8 <kstrcat>
400031e0: 910223e0     	add	x0, sp, #0x88
400031e4: 910023e1     	add	x1, sp, #0x8
400031e8: 97fffd84     	bl	0x400027f8 <kstrcat>
400031ec: f9421ab5     	ldr	x21, [x21, #0x430]
400031f0: b5fffdf5     	cbnz	x21, 0x400031ac <tui_launch+0x684>
400031f4: 910223e0     	add	x0, sp, #0x88
400031f8: 97fffd79     	bl	0x400027dc <kstrlen>
400031fc: b5000080     	cbnz	x0, 0x4000320c <tui_launch+0x6e4>
40003200: 910223e0     	add	x0, sp, #0x88
40003204: aa1903e1     	mov	x1, x25
40003208: 97fffda4     	bl	0x40002898 <kstrcpy>
4000320c: 910223e0     	add	x0, sp, #0x88
40003210: 97fff424     	bl	0x400002a0 <launch_kedit>
40003214: d503201f     	nop
40003218: 5002ac00     	adr	x0, 0x4000879a <__rodata_start+0x179a>
4000321c: 94000119     	bl	0x40003680 <uart_puts>
40003220: 17fffe62     	b	0x40002ba8 <tui_launch+0x80>
40003224: 7101091f     	cmp	w8, #0x42
40003228: 54ffcc01     	b.ne	0x40002ba8 <tui_launch+0x80>
4000322c: b9497388     	ldr	w8, [x28, #0x970]
40003230: 35ffcbc8     	cbnz	w8, 0x40002ba8 <tui_launch+0x80>
40003234: b9497b49     	ldr	w9, [x26, #0x978]
40003238: b9497768     	ldr	w8, [x27, #0x974]
4000323c: 51000529     	sub	w9, w9, #0x1
40003240: 6b09011f     	cmp	w8, w9
40003244: 54ffcb2a     	b.ge	0x40002ba8 <tui_launch+0x80>
40003248: 11000508     	add	w8, w8, #0x1
4000324c: b9097768     	str	w8, [x27, #0x974]
40003250: 17fffe56     	b	0x40002ba8 <tui_launch+0x80>
40003254: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003258: 912b5c00     	add	x0, x0, #0xad7
4000325c: 94000109     	bl	0x40003680 <uart_puts>
40003260: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003264: a95557f6     	ldp	x22, x21, [sp, #0x150]
40003268: a9545ff8     	ldp	x24, x23, [sp, #0x140]
4000326c: a95367fa     	ldp	x26, x25, [sp, #0x130]
40003270: a9526ffc     	ldp	x28, x27, [sp, #0x120]
40003274: a9517bfd     	ldp	x29, x30, [sp, #0x110]
40003278: 9105c3ff     	add	sp, sp, #0x170
4000327c: d65f03c0     	ret

0000000040003280 <draw_box>:
40003280: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40003284: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40003288: 91151108     	add	x8, x8, #0x544
4000328c: 7100007f     	cmp	w3, #0x0
40003290: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40003294: 91056529     	add	x9, x9, #0x159
40003298: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000329c: 2a0003f3     	mov	w19, w0
400032a0: 9a880120     	csel	x0, x9, x8, eq
400032a4: a9015ff8     	stp	x24, x23, [sp, #0x10]
400032a8: a90257f6     	stp	x22, x21, [sp, #0x20]
400032ac: 910003fd     	mov	x29, sp
400032b0: aa0203f4     	mov	x20, x2
400032b4: 2a0103f5     	mov	w21, w1
400032b8: 940000f2     	bl	0x40003680 <uart_puts>
400032bc: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032c0: 91202800     	add	x0, x0, #0x80a
400032c4: 52800041     	mov	w1, #0x2                // =2
400032c8: 2a1303e2     	mov	w2, w19
400032cc: 94000202     	bl	0x40003ad4 <uart_printf>
400032d0: 51000ab6     	sub	w22, w21, #0x2
400032d4: 510006b7     	sub	w23, w21, #0x1
400032d8: 90000035     	adrp	x21, 0x40007000 <__rodata_start>
400032dc: 911572b5     	add	x21, x21, #0x55c
400032e0: 2a1603f8     	mov	w24, w22
400032e4: aa1503e0     	mov	x0, x21
400032e8: 940000e6     	bl	0x40003680 <uart_puts>
400032ec: 71000718     	subs	w24, w24, #0x1
400032f0: 54ffffa1     	b.ne	0x400032e4 <draw_box+0x64>
400032f4: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032f8: 91266000     	add	x0, x0, #0x998
400032fc: 940000e1     	bl	0x40003680 <uart_puts>
40003300: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003304: 91205800     	add	x0, x0, #0x816
40003308: 11000a62     	add	w2, w19, #0x2
4000330c: 52800041     	mov	w1, #0x2                // =2
40003310: aa1403e3     	mov	x3, x20
40003314: 940001f0     	bl	0x40003ad4 <uart_printf>
40003318: b0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
4000331c: 91124694     	add	x20, x20, #0x491
40003320: 52800061     	mov	w1, #0x3                // =3
40003324: aa1403e0     	mov	x0, x20
40003328: 2a1303e2     	mov	w2, w19
4000332c: 940001ea     	bl	0x40003ad4 <uart_printf>
40003330: 0b1302e2     	add	w2, w23, w19
40003334: aa1403e0     	mov	x0, x20
40003338: 52800061     	mov	w1, #0x3                // =3
4000333c: 940001e6     	bl	0x40003ad4 <uart_printf>
40003340: aa1403e0     	mov	x0, x20
40003344: 52800081     	mov	w1, #0x4                // =4
40003348: 2a1303e2     	mov	w2, w19
4000334c: 940001e2     	bl	0x40003ad4 <uart_printf>
40003350: 0b1302e2     	add	w2, w23, w19
40003354: aa1403e0     	mov	x0, x20
40003358: 52800081     	mov	w1, #0x4                // =4
4000335c: 940001de     	bl	0x40003ad4 <uart_printf>
40003360: aa1403e0     	mov	x0, x20
40003364: 528000a1     	mov	w1, #0x5                // =5
40003368: 2a1303e2     	mov	w2, w19
4000336c: 940001da     	bl	0x40003ad4 <uart_printf>
40003370: 0b1302e2     	add	w2, w23, w19
40003374: aa1403e0     	mov	x0, x20
40003378: 528000a1     	mov	w1, #0x5                // =5
4000337c: 940001d6     	bl	0x40003ad4 <uart_printf>
40003380: aa1403e0     	mov	x0, x20
40003384: 528000c1     	mov	w1, #0x6                // =6
40003388: 2a1303e2     	mov	w2, w19
4000338c: 940001d2     	bl	0x40003ad4 <uart_printf>
40003390: 0b1302e2     	add	w2, w23, w19
40003394: aa1403e0     	mov	x0, x20
40003398: 528000c1     	mov	w1, #0x6                // =6
4000339c: 940001ce     	bl	0x40003ad4 <uart_printf>
400033a0: aa1403e0     	mov	x0, x20
400033a4: 528000e1     	mov	w1, #0x7                // =7
400033a8: 2a1303e2     	mov	w2, w19
400033ac: 940001ca     	bl	0x40003ad4 <uart_printf>
400033b0: 0b1302e2     	add	w2, w23, w19
400033b4: aa1403e0     	mov	x0, x20
400033b8: 528000e1     	mov	w1, #0x7                // =7
400033bc: 940001c6     	bl	0x40003ad4 <uart_printf>
400033c0: aa1403e0     	mov	x0, x20
400033c4: 52800101     	mov	w1, #0x8                // =8
400033c8: 2a1303e2     	mov	w2, w19
400033cc: 940001c2     	bl	0x40003ad4 <uart_printf>
400033d0: 0b1302e2     	add	w2, w23, w19
400033d4: aa1403e0     	mov	x0, x20
400033d8: 52800101     	mov	w1, #0x8                // =8
400033dc: 940001be     	bl	0x40003ad4 <uart_printf>
400033e0: aa1403e0     	mov	x0, x20
400033e4: 52800121     	mov	w1, #0x9                // =9
400033e8: 2a1303e2     	mov	w2, w19
400033ec: 940001ba     	bl	0x40003ad4 <uart_printf>
400033f0: 0b1302e2     	add	w2, w23, w19
400033f4: aa1403e0     	mov	x0, x20
400033f8: 52800121     	mov	w1, #0x9                // =9
400033fc: 940001b6     	bl	0x40003ad4 <uart_printf>
40003400: aa1403e0     	mov	x0, x20
40003404: 52800141     	mov	w1, #0xa                // =10
40003408: 2a1303e2     	mov	w2, w19
4000340c: 940001b2     	bl	0x40003ad4 <uart_printf>
40003410: 0b1302e2     	add	w2, w23, w19
40003414: aa1403e0     	mov	x0, x20
40003418: 52800141     	mov	w1, #0xa                // =10
4000341c: 940001ae     	bl	0x40003ad4 <uart_printf>
40003420: aa1403e0     	mov	x0, x20
40003424: 52800161     	mov	w1, #0xb                // =11
40003428: 2a1303e2     	mov	w2, w19
4000342c: 940001aa     	bl	0x40003ad4 <uart_printf>
40003430: 0b1302e2     	add	w2, w23, w19
40003434: aa1403e0     	mov	x0, x20
40003438: 52800161     	mov	w1, #0xb                // =11
4000343c: 940001a6     	bl	0x40003ad4 <uart_printf>
40003440: aa1403e0     	mov	x0, x20
40003444: 52800181     	mov	w1, #0xc                // =12
40003448: 2a1303e2     	mov	w2, w19
4000344c: 940001a2     	bl	0x40003ad4 <uart_printf>
40003450: 0b1302e2     	add	w2, w23, w19
40003454: aa1403e0     	mov	x0, x20
40003458: 52800181     	mov	w1, #0xc                // =12
4000345c: 9400019e     	bl	0x40003ad4 <uart_printf>
40003460: aa1403e0     	mov	x0, x20
40003464: 528001a1     	mov	w1, #0xd                // =13
40003468: 2a1303e2     	mov	w2, w19
4000346c: 9400019a     	bl	0x40003ad4 <uart_printf>
40003470: 0b1302e2     	add	w2, w23, w19
40003474: aa1403e0     	mov	x0, x20
40003478: 528001a1     	mov	w1, #0xd                // =13
4000347c: 94000196     	bl	0x40003ad4 <uart_printf>
40003480: aa1403e0     	mov	x0, x20
40003484: 528001c1     	mov	w1, #0xe                // =14
40003488: 2a1303e2     	mov	w2, w19
4000348c: 94000192     	bl	0x40003ad4 <uart_printf>
40003490: 0b1302e2     	add	w2, w23, w19
40003494: aa1403e0     	mov	x0, x20
40003498: 528001c1     	mov	w1, #0xe                // =14
4000349c: 9400018e     	bl	0x40003ad4 <uart_printf>
400034a0: aa1403e0     	mov	x0, x20
400034a4: 528001e1     	mov	w1, #0xf                // =15
400034a8: 2a1303e2     	mov	w2, w19
400034ac: 9400018a     	bl	0x40003ad4 <uart_printf>
400034b0: 0b1302e2     	add	w2, w23, w19
400034b4: aa1403e0     	mov	x0, x20
400034b8: 528001e1     	mov	w1, #0xf                // =15
400034bc: 94000186     	bl	0x40003ad4 <uart_printf>
400034c0: aa1403e0     	mov	x0, x20
400034c4: 52800201     	mov	w1, #0x10               // =16
400034c8: 2a1303e2     	mov	w2, w19
400034cc: 94000182     	bl	0x40003ad4 <uart_printf>
400034d0: 0b1302e2     	add	w2, w23, w19
400034d4: aa1403e0     	mov	x0, x20
400034d8: 52800201     	mov	w1, #0x10               // =16
400034dc: 9400017e     	bl	0x40003ad4 <uart_printf>
400034e0: aa1403e0     	mov	x0, x20
400034e4: 52800221     	mov	w1, #0x11               // =17
400034e8: 2a1303e2     	mov	w2, w19
400034ec: 9400017a     	bl	0x40003ad4 <uart_printf>
400034f0: 0b1302e2     	add	w2, w23, w19
400034f4: aa1403e0     	mov	x0, x20
400034f8: 52800221     	mov	w1, #0x11               // =17
400034fc: 94000176     	bl	0x40003ad4 <uart_printf>
40003500: aa1403e0     	mov	x0, x20
40003504: 52800241     	mov	w1, #0x12               // =18
40003508: 2a1303e2     	mov	w2, w19
4000350c: 94000172     	bl	0x40003ad4 <uart_printf>
40003510: 0b1302e2     	add	w2, w23, w19
40003514: aa1403e0     	mov	x0, x20
40003518: 52800241     	mov	w1, #0x12               // =18
4000351c: 9400016e     	bl	0x40003ad4 <uart_printf>
40003520: aa1403e0     	mov	x0, x20
40003524: 52800261     	mov	w1, #0x13               // =19
40003528: 2a1303e2     	mov	w2, w19
4000352c: 9400016a     	bl	0x40003ad4 <uart_printf>
40003530: 0b1302e2     	add	w2, w23, w19
40003534: aa1403e0     	mov	x0, x20
40003538: 52800261     	mov	w1, #0x13               // =19
4000353c: 94000166     	bl	0x40003ad4 <uart_printf>
40003540: aa1403e0     	mov	x0, x20
40003544: 52800281     	mov	w1, #0x14               // =20
40003548: 2a1303e2     	mov	w2, w19
4000354c: 94000162     	bl	0x40003ad4 <uart_printf>
40003550: 0b1302e2     	add	w2, w23, w19
40003554: aa1403e0     	mov	x0, x20
40003558: 52800281     	mov	w1, #0x14               // =20
4000355c: 9400015e     	bl	0x40003ad4 <uart_printf>
40003560: aa1403e0     	mov	x0, x20
40003564: 528002a1     	mov	w1, #0x15               // =21
40003568: 2a1303e2     	mov	w2, w19
4000356c: 9400015a     	bl	0x40003ad4 <uart_printf>
40003570: 0b1302e2     	add	w2, w23, w19
40003574: aa1403e0     	mov	x0, x20
40003578: 528002a1     	mov	w1, #0x15               // =21
4000357c: 94000156     	bl	0x40003ad4 <uart_printf>
40003580: aa1403e0     	mov	x0, x20
40003584: 528002c1     	mov	w1, #0x16               // =22
40003588: 2a1303e2     	mov	w2, w19
4000358c: 94000152     	bl	0x40003ad4 <uart_printf>
40003590: 0b1302e2     	add	w2, w23, w19
40003594: aa1403e0     	mov	x0, x20
40003598: 528002c1     	mov	w1, #0x16               // =22
4000359c: 9400014e     	bl	0x40003ad4 <uart_printf>
400035a0: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400035a4: 91174c00     	add	x0, x0, #0x5d3
400035a8: 528002e1     	mov	w1, #0x17               // =23
400035ac: 2a1303e2     	mov	w2, w19
400035b0: 94000149     	bl	0x40003ad4 <uart_printf>
400035b4: 90000033     	adrp	x19, 0x40007000 <__rodata_start>
400035b8: 91157273     	add	x19, x19, #0x55c
400035bc: aa1303e0     	mov	x0, x19
400035c0: 94000030     	bl	0x40003680 <uart_puts>
400035c4: 710006d6     	subs	w22, w22, #0x1
400035c8: 54ffffa1     	b.ne	0x400035bc <draw_box+0x33c>
400035cc: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400035d0: 91177c00     	add	x0, x0, #0x5df
400035d4: 9400002b     	bl	0x40003680 <uart_puts>
400035d8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400035dc: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400035e0: 9128e400     	add	x0, x0, #0xa39
400035e4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400035e8: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400035ec: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400035f0: 14000024     	b	0x40003680 <uart_puts>

00000000400035f4 <uart_init>:
400035f4: 52800608     	mov	w8, #0x30               // =48
400035f8: 528001a9     	mov	w9, #0xd                // =13
400035fc: 5280002a     	mov	w10, #0x1               // =1
40003600: 72a12008     	movk	w8, #0x900, lsl #16
40003604: b900011f     	str	wzr, [x8]
40003608: b81f4109     	stur	w9, [x8, #-0xc]
4000360c: 52800e09     	mov	w9, #0x70               // =112
40003610: b81f810a     	stur	w10, [x8, #-0x8]
40003614: b81fc109     	stur	w9, [x8, #-0x4]
40003618: 52806029     	mov	w9, #0x301              // =769
4000361c: b9000109     	str	w9, [x8]
40003620: d65f03c0     	ret

0000000040003624 <uart_putc>:
40003624: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003628: b94b8108     	ldr	w8, [x8, #0xb80]
4000362c: 340001a8     	cbz	w8, 0x40003660 <uart_putc+0x3c>
40003630: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003634: 5287ffca     	mov	w10, #0x3ffe            // =16382
40003638: b94b8509     	ldr	w9, [x8, #0xb84]
4000363c: 6b0a013f     	cmp	w9, w10
40003640: 5400010c     	b.gt	0x40003660 <uart_putc+0x3c>
40003644: 93407d29     	sxtw	x9, w9
40003648: d503201f     	nop
4000364c: 100629ea     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
40003650: 9100052b     	add	x11, x9, #0x1
40003654: 38296940     	strb	w0, [x10, x9]
40003658: b90b850b     	str	w11, [x8, #0xb84]
4000365c: 382b695f     	strb	wzr, [x10, x11]
40003660: 52800308     	mov	w8, #0x18               // =24
40003664: 72a12008     	movk	w8, #0x900, lsl #16
40003668: b9400109     	ldr	w9, [x8]
4000366c: 372fffe9     	tbnz	w9, #0x5, 0x40003668 <uart_putc+0x44>
40003670: 12001c08     	and	w8, w0, #0xff
40003674: 52a12009     	mov	w9, #0x9000000          // =150994944
40003678: b9000128     	str	w8, [x9]
4000367c: d65f03c0     	ret

0000000040003680 <uart_puts>:
40003680: 52800308     	mov	w8, #0x18               // =24
40003684: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003688: 9000006a     	adrp	x10, 0x4000f000 <var_values+0x6a8>
4000368c: 72a12008     	movk	w8, #0x900, lsl #16
40003690: d503201f     	nop
40003694: 100627ab     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
40003698: 5287ffcc     	mov	w12, #0x3ffe            // =16382
4000369c: 528001ad     	mov	w13, #0xd               // =13
400036a0: 52a1200e     	mov	w14, #0x9000000         // =150994944
400036a4: 3940000f     	ldrb	w15, [x0]
400036a8: 710029ff     	cmp	w15, #0xa
400036ac: 540000a0     	b.eq	0x400036c0 <uart_puts+0x40>
400036b0: 3400042f     	cbz	w15, 0x40003734 <uart_puts+0xb4>
400036b4: b94b8130     	ldr	w16, [x9, #0xb80]
400036b8: 35000250     	cbnz	w16, 0x40003700 <uart_puts+0x80>
400036bc: 14000019     	b	0x40003720 <uart_puts+0xa0>
400036c0: b94b812f     	ldr	w15, [x9, #0xb80]
400036c4: 3400012f     	cbz	w15, 0x400036e8 <uart_puts+0x68>
400036c8: b94b854f     	ldr	w15, [x10, #0xb84]
400036cc: 6b0c01ff     	cmp	w15, w12
400036d0: 540000cc     	b.gt	0x400036e8 <uart_puts+0x68>
400036d4: 93407def     	sxtw	x15, w15
400036d8: 910005f0     	add	x16, x15, #0x1
400036dc: 382f696d     	strb	w13, [x11, x15]
400036e0: b90b8550     	str	w16, [x10, #0xb84]
400036e4: 3830697f     	strb	wzr, [x11, x16]
400036e8: b940010f     	ldr	w15, [x8]
400036ec: 372fffef     	tbnz	w15, #0x5, 0x400036e8 <uart_puts+0x68>
400036f0: b90001cd     	str	w13, [x14]
400036f4: 3940000f     	ldrb	w15, [x0]
400036f8: b94b8130     	ldr	w16, [x9, #0xb80]
400036fc: 34000130     	cbz	w16, 0x40003720 <uart_puts+0xa0>
40003700: b94b8550     	ldr	w16, [x10, #0xb84]
40003704: 6b0c021f     	cmp	w16, w12
40003708: 540000cc     	b.gt	0x40003720 <uart_puts+0xa0>
4000370c: 93407e10     	sxtw	x16, w16
40003710: 91000611     	add	x17, x16, #0x1
40003714: 3830696f     	strb	w15, [x11, x16]
40003718: b90b8551     	str	w17, [x10, #0xb84]
4000371c: 3831697f     	strb	wzr, [x11, x17]
40003720: 91000400     	add	x0, x0, #0x1
40003724: b9400110     	ldr	w16, [x8]
40003728: 372ffff0     	tbnz	w16, #0x5, 0x40003724 <uart_puts+0xa4>
4000372c: b90001cf     	str	w15, [x14]
40003730: 17ffffdd     	b	0x400036a4 <uart_puts+0x24>
40003734: d65f03c0     	ret

0000000040003738 <uart_has_data>:
40003738: 52800308     	mov	w8, #0x18               // =24
4000373c: 52800029     	mov	w9, #0x1                // =1
40003740: 72a12008     	movk	w8, #0x900, lsl #16
40003744: b9400108     	ldr	w8, [x8]
40003748: 0a681120     	bic	w0, w9, w8, lsr #4
4000374c: d65f03c0     	ret

0000000040003750 <uart_getc>:
40003750: 52800308     	mov	w8, #0x18               // =24
40003754: 72a12008     	movk	w8, #0x900, lsl #16
40003758: b9400109     	ldr	w9, [x8]
4000375c: 3727ffe9     	tbnz	w9, #0x4, 0x40003758 <uart_getc+0x8>
40003760: 52a12008     	mov	w8, #0x9000000          // =150994944
40003764: b9400100     	ldr	w0, [x8]
40003768: d65f03c0     	ret

000000004000376c <uart_print_hex_raw>:
4000376c: 52800308     	mov	w8, #0x18               // =24
40003770: 2a1f03eb     	mov	w11, wzr
40003774: 5280078c     	mov	w12, #0x3c              // =60
40003778: 72a12008     	movk	w8, #0x900, lsl #16
4000377c: d503201f     	nop
40003780: 3001ebce     	adr	x14, 0x400074f9 <__rodata_start+0x4f9>
40003784: 9000006d     	adrp	x13, 0x4000f000 <var_values+0x6a8>
40003788: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
4000378c: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003790: d503201f     	nop
40003794: 10061faa     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
40003798: 52a12010     	mov	w16, #0x9000000         // =150994944
4000379c: 14000003     	b	0x400037a8 <uart_print_hex_raw+0x3c>
400037a0: b400032c     	cbz	x12, 0x40003804 <uart_print_hex_raw+0x98>
400037a4: d100118c     	sub	x12, x12, #0x4
400037a8: 9acc2411     	lsr	x17, x0, x12
400037ac: 53027d92     	lsr	w18, w12, #2
400037b0: 92400e31     	and	x17, x17, #0xf
400037b4: 6b01025f     	cmp	w18, w1
400037b8: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
400037bc: 1a9f056b     	csinc	w11, w11, wzr, eq
400037c0: 34ffff0b     	cbz	w11, 0x400037a0 <uart_print_hex_raw+0x34>
400037c4: b94b81b2     	ldr	w18, [x13, #0xb80]
400037c8: 387169d1     	ldrb	w17, [x14, x17]
400037cc: 34000132     	cbz	w18, 0x400037f0 <uart_print_hex_raw+0x84>
400037d0: b94b8532     	ldr	w18, [x9, #0xb84]
400037d4: 6b0f025f     	cmp	w18, w15
400037d8: 540000cc     	b.gt	0x400037f0 <uart_print_hex_raw+0x84>
400037dc: 93407e52     	sxtw	x18, w18
400037e0: 91000642     	add	x2, x18, #0x1
400037e4: 38326951     	strb	w17, [x10, x18]
400037e8: b90b8522     	str	w2, [x9, #0xb84]
400037ec: 3822695f     	strb	wzr, [x10, x2]
400037f0: b9400112     	ldr	w18, [x8]
400037f4: 372ffff2     	tbnz	w18, #0x5, 0x400037f0 <uart_print_hex_raw+0x84>
400037f8: b9000211     	str	w17, [x16]
400037fc: b5fffd4c     	cbnz	x12, 0x400037a4 <uart_print_hex_raw+0x38>
40003800: d65f03c0     	ret
40003804: b94b81ab     	ldr	w11, [x13, #0xb80]
40003808: 3400016b     	cbz	w11, 0x40003834 <uart_print_hex_raw+0xc8>
4000380c: b94b852b     	ldr	w11, [x9, #0xb84]
40003810: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003814: 6b0c017f     	cmp	w11, w12
40003818: 540000ec     	b.gt	0x40003834 <uart_print_hex_raw+0xc8>
4000381c: 93407d6b     	sxtw	x11, w11
40003820: 5280060c     	mov	w12, #0x30              // =48
40003824: 9100056d     	add	x13, x11, #0x1
40003828: 382b694c     	strb	w12, [x10, x11]
4000382c: b90b852d     	str	w13, [x9, #0xb84]
40003830: 382d695f     	strb	wzr, [x10, x13]
40003834: b9400109     	ldr	w9, [x8]
40003838: 372fffe9     	tbnz	w9, #0x5, 0x40003834 <uart_print_hex_raw+0xc8>
4000383c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003840: 52800609     	mov	w9, #0x30               // =48
40003844: b9000109     	str	w9, [x8]
40003848: d65f03c0     	ret

000000004000384c <uart_print_hex>:
4000384c: 52800308     	mov	w8, #0x18               // =24
40003850: b000002c     	adrp	x12, 0x40008000 <__rodata_start+0x1000>
40003854: 9102118c     	add	x12, x12, #0x84
40003858: 72a12008     	movk	w8, #0x900, lsl #16
4000385c: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003860: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003864: d503201f     	nop
40003868: 1006190a     	adr	x10, 0x4000fb88 <kernel_capture_buffer>
4000386c: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003870: 528001ae     	mov	w14, #0xd               // =13
40003874: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003878: 39400190     	ldrb	w16, [x12]
4000387c: 71002a1f     	cmp	w16, #0xa
40003880: 540000a0     	b.eq	0x40003894 <uart_print_hex+0x48>
40003884: 34000410     	cbz	w16, 0x40003904 <uart_print_hex+0xb8>
40003888: b94b8171     	ldr	w17, [x11, #0xb80]
4000388c: 35000231     	cbnz	w17, 0x400038d0 <uart_print_hex+0x84>
40003890: 14000018     	b	0x400038f0 <uart_print_hex+0xa4>
40003894: b94b8171     	ldr	w17, [x11, #0xb80]
40003898: 34000131     	cbz	w17, 0x400038bc <uart_print_hex+0x70>
4000389c: b94b8531     	ldr	w17, [x9, #0xb84]
400038a0: 6b0d023f     	cmp	w17, w13
400038a4: 540000cc     	b.gt	0x400038bc <uart_print_hex+0x70>
400038a8: 93407e31     	sxtw	x17, w17
400038ac: 91000632     	add	x18, x17, #0x1
400038b0: 3831694e     	strb	w14, [x10, x17]
400038b4: b90b8532     	str	w18, [x9, #0xb84]
400038b8: 3832695f     	strb	wzr, [x10, x18]
400038bc: b9400111     	ldr	w17, [x8]
400038c0: 372ffff1     	tbnz	w17, #0x5, 0x400038bc <uart_print_hex+0x70>
400038c4: b90001ee     	str	w14, [x15]
400038c8: b94b8171     	ldr	w17, [x11, #0xb80]
400038cc: 34000131     	cbz	w17, 0x400038f0 <uart_print_hex+0xa4>
400038d0: b94b8531     	ldr	w17, [x9, #0xb84]
400038d4: 6b0d023f     	cmp	w17, w13
400038d8: 540000cc     	b.gt	0x400038f0 <uart_print_hex+0xa4>
400038dc: 93407e31     	sxtw	x17, w17
400038e0: 91000632     	add	x18, x17, #0x1
400038e4: 38316950     	strb	w16, [x10, x17]
400038e8: b90b8532     	str	w18, [x9, #0xb84]
400038ec: 3832695f     	strb	wzr, [x10, x18]
400038f0: 9100058c     	add	x12, x12, #0x1
400038f4: b9400111     	ldr	w17, [x8]
400038f8: 372ffff1     	tbnz	w17, #0x5, 0x400038f4 <uart_print_hex+0xa8>
400038fc: b90001f0     	str	w16, [x15]
40003900: 17ffffde     	b	0x40003878 <uart_print_hex+0x2c>
40003904: 2a1f03ec     	mov	w12, wzr
40003908: d503201f     	nop
4000390c: 3001df6d     	adr	x13, 0x400074f9 <__rodata_start+0x4f9>
40003910: 5280078e     	mov	w14, #0x3c              // =60
40003914: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003918: 52a12010     	mov	w16, #0x9000000         // =150994944
4000391c: 14000003     	b	0x40003928 <uart_print_hex+0xdc>
40003920: b40002ee     	cbz	x14, 0x4000397c <uart_print_hex+0x130>
40003924: d10011ce     	sub	x14, x14, #0x4
40003928: 9ace2411     	lsr	x17, x0, x14
4000392c: f2400e31     	ands	x17, x17, #0xf
40003930: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003934: 1a9f158c     	csinc	w12, w12, wzr, ne
40003938: 34ffff4c     	cbz	w12, 0x40003920 <uart_print_hex+0xd4>
4000393c: b94b8172     	ldr	w18, [x11, #0xb80]
40003940: 387169b1     	ldrb	w17, [x13, x17]
40003944: 34000132     	cbz	w18, 0x40003968 <uart_print_hex+0x11c>
40003948: b94b8532     	ldr	w18, [x9, #0xb84]
4000394c: 6b0f025f     	cmp	w18, w15
40003950: 540000cc     	b.gt	0x40003968 <uart_print_hex+0x11c>
40003954: 93407e52     	sxtw	x18, w18
40003958: 91000641     	add	x1, x18, #0x1
4000395c: 38326951     	strb	w17, [x10, x18]
40003960: b90b8521     	str	w1, [x9, #0xb84]
40003964: 3821695f     	strb	wzr, [x10, x1]
40003968: b9400112     	ldr	w18, [x8]
4000396c: 372ffff2     	tbnz	w18, #0x5, 0x40003968 <uart_print_hex+0x11c>
40003970: b9000211     	str	w17, [x16]
40003974: b5fffd8e     	cbnz	x14, 0x40003924 <uart_print_hex+0xd8>
40003978: d65f03c0     	ret
4000397c: b94b816b     	ldr	w11, [x11, #0xb80]
40003980: 3400016b     	cbz	w11, 0x400039ac <uart_print_hex+0x160>
40003984: b94b852b     	ldr	w11, [x9, #0xb84]
40003988: 5287ffcc     	mov	w12, #0x3ffe            // =16382
4000398c: 6b0c017f     	cmp	w11, w12
40003990: 540000ec     	b.gt	0x400039ac <uart_print_hex+0x160>
40003994: 93407d6b     	sxtw	x11, w11
40003998: 5280060c     	mov	w12, #0x30              // =48
4000399c: 9100056d     	add	x13, x11, #0x1
400039a0: 382b694c     	strb	w12, [x10, x11]
400039a4: b90b852d     	str	w13, [x9, #0xb84]
400039a8: 382d695f     	strb	wzr, [x10, x13]
400039ac: b9400109     	ldr	w9, [x8]
400039b0: 372fffe9     	tbnz	w9, #0x5, 0x400039ac <uart_print_hex+0x160>
400039b4: 52a12008     	mov	w8, #0x9000000          // =150994944
400039b8: 52800609     	mov	w9, #0x30               // =48
400039bc: b9000109     	str	w9, [x8]
400039c0: d65f03c0     	ret

00000000400039c4 <uart_print_dec>:
400039c4: d10083ff     	sub	sp, sp, #0x20
400039c8: 52800308     	mov	w8, #0x18               // =24
400039cc: 72a12008     	movk	w8, #0x900, lsl #16
400039d0: b4000540     	cbz	x0, 0x40003a78 <uart_print_dec+0xb4>
400039d4: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
400039d8: aa1f03e9     	mov	x9, xzr
400039dc: 5280014b     	mov	w11, #0xa               // =10
400039e0: f29999aa     	movk	x10, #0xcccd
400039e4: 910023ec     	add	x12, sp, #0x8
400039e8: 9bca7c0d     	umulh	x13, x0, x10
400039ec: f100241f     	cmp	x0, #0x9
400039f0: d343fdad     	lsr	x13, x13, #3
400039f4: 1b0b81ae     	msub	w14, w13, w11, w0
400039f8: aa0d03e0     	mov	x0, x13
400039fc: 321c05ce     	orr	w14, w14, #0x30
40003a00: 3829698e     	strb	w14, [x12, x9]
40003a04: 91000529     	add	x9, x9, #0x1
40003a08: 54ffff08     	b.hi	0x400039e8 <uart_print_dec+0x24>
40003a0c: 910023ea     	add	x10, sp, #0x8
40003a10: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003a14: 9000006c     	adrp	x12, 0x4000f000 <var_values+0x6a8>
40003a18: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a1c: d503201f     	nop
40003a20: 10060b4e     	adr	x14, 0x4000fb88 <kernel_capture_buffer>
40003a24: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a28: d1000530     	sub	x16, x9, #0x1
40003a2c: b94b8172     	ldr	w18, [x11, #0xb80]
40003a30: 38706951     	ldrb	w17, [x10, x16]
40003a34: 34000132     	cbz	w18, 0x40003a58 <uart_print_dec+0x94>
40003a38: b94b8592     	ldr	w18, [x12, #0xb84]
40003a3c: 6b0d025f     	cmp	w18, w13
40003a40: 540000cc     	b.gt	0x40003a58 <uart_print_dec+0x94>
40003a44: 93407e52     	sxtw	x18, w18
40003a48: 91000640     	add	x0, x18, #0x1
40003a4c: 383269d1     	strb	w17, [x14, x18]
40003a50: b90b8580     	str	w0, [x12, #0xb84]
40003a54: 382069df     	strb	wzr, [x14, x0]
40003a58: b9400112     	ldr	w18, [x8]
40003a5c: 372ffff2     	tbnz	w18, #0x5, 0x40003a58 <uart_print_dec+0x94>
40003a60: 7100053f     	cmp	w9, #0x1
40003a64: aa1003e9     	mov	x9, x16
40003a68: b90001f1     	str	w17, [x15]
40003a6c: 54fffdec     	b.gt	0x40003a28 <uart_print_dec+0x64>
40003a70: 910083ff     	add	sp, sp, #0x20
40003a74: d65f03c0     	ret
40003a78: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003a7c: b94b8129     	ldr	w9, [x9, #0xb80]
40003a80: 340001c9     	cbz	w9, 0x40003ab8 <uart_print_dec+0xf4>
40003a84: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003a88: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003a8c: b94b852a     	ldr	w10, [x9, #0xb84]
40003a90: 6b0b015f     	cmp	w10, w11
40003a94: 5400012c     	b.gt	0x40003ab8 <uart_print_dec+0xf4>
40003a98: 93407d4a     	sxtw	x10, w10
40003a9c: d503201f     	nop
40003aa0: 1006074b     	adr	x11, 0x4000fb88 <kernel_capture_buffer>
40003aa4: 5280060c     	mov	w12, #0x30              // =48
40003aa8: 9100054d     	add	x13, x10, #0x1
40003aac: 382a696c     	strb	w12, [x11, x10]
40003ab0: b90b852d     	str	w13, [x9, #0xb84]
40003ab4: 382d697f     	strb	wzr, [x11, x13]
40003ab8: b9400109     	ldr	w9, [x8]
40003abc: 372fffe9     	tbnz	w9, #0x5, 0x40003ab8 <uart_print_dec+0xf4>
40003ac0: 52a12008     	mov	w8, #0x9000000          // =150994944
40003ac4: 52800609     	mov	w9, #0x30               // =48
40003ac8: b9000109     	str	w9, [x8]
40003acc: 910083ff     	add	sp, sp, #0x20
40003ad0: d65f03c0     	ret

0000000040003ad4 <uart_printf>:
40003ad4: d10343ff     	sub	sp, sp, #0xd0
40003ad8: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003adc: 9101c3fd     	add	x29, sp, #0x70
40003ae0: 910003e8     	mov	x8, sp
40003ae4: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003ae8: 52800315     	mov	w21, #0x18              // =24
40003aec: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003af0: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003af4: 72a12015     	movk	w21, #0x900, lsl #16
40003af8: 128006e9     	mov	w9, #-0x38              // =-56
40003afc: a90967fa     	stp	x26, x25, [sp, #0x90]
40003b00: 9100e108     	add	x8, x8, #0x38
40003b04: 910183aa     	add	x10, x29, #0x60
40003b08: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003b0c: 90000076     	adrp	x22, 0x4000f000 <var_values+0x6a8>
40003b10: 90000077     	adrp	x23, 0x4000f000 <var_values+0x6a8>
40003b14: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003b18: aa0003f3     	mov	x19, x0
40003b1c: aa1f03f4     	mov	x20, xzr
40003b20: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003b24: d503201f     	nop
40003b28: 10060319     	adr	x25, 0x4000fb88 <kernel_capture_buffer>
40003b2c: 528001ba     	mov	w26, #0xd               // =13
40003b30: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b34: 528004ae     	mov	w14, #0x25              // =37
40003b38: f29999af     	movk	x15, #0xcccd
40003b3c: 52800150     	mov	w16, #0xa               // =10
40003b40: d10063bc     	sub	x28, x29, #0x18
40003b44: d503201f     	nop
40003b48: 3001cd91     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
40003b4c: a9000be1     	stp	x1, x2, [sp]
40003b50: a90113e3     	stp	x3, x4, [sp, #0x10]
40003b54: a9021be5     	stp	x5, x6, [sp, #0x20]
40003b58: f9002be9     	str	x9, [sp, #0x50]
40003b5c: f90023e8     	str	x8, [sp, #0x40]
40003b60: a9032be7     	stp	x7, x10, [sp, #0x30]
40003b64: 14000004     	b	0x40003b74 <uart_printf+0xa0>
40003b68: 52800608     	mov	w8, #0x30               // =48
40003b6c: b9000368     	str	w8, [x27]
40003b70: 91000694     	add	x20, x20, #0x1
40003b74: 38746a68     	ldrb	w8, [x19, x20]
40003b78: 7100291f     	cmp	w8, #0xa
40003b7c: 54000440     	b.eq	0x40003c04 <uart_printf+0x130>
40003b80: 7100951f     	cmp	w8, #0x25
40003b84: 540000a0     	b.eq	0x40003b98 <uart_printf+0xc4>
40003b88: 34003ae8     	cbz	w8, 0x400042e4 <uart_printf+0x810>
40003b8c: b94b82c9     	ldr	w9, [x22, #0xb80]
40003b90: 350005a9     	cbnz	w9, 0x40003c44 <uart_printf+0x170>
40003b94: 14000034     	b	0x40003c64 <uart_printf+0x190>
40003b98: 9100068a     	add	x10, x20, #0x1
40003b9c: 386a6a68     	ldrb	w8, [x19, x10]
40003ba0: 7101b11f     	cmp	w8, #0x6c
40003ba4: 54000661     	b.ne	0x40003c70 <uart_printf+0x19c>
40003ba8: 91000a89     	add	x9, x20, #0x2
40003bac: 91000e8b     	add	x11, x20, #0x3
40003bb0: 38696a6a     	ldrb	w10, [x19, x9]
40003bb4: 7101b15f     	cmp	w10, #0x6c
40003bb8: 9a890174     	csel	x20, x11, x9, eq
40003bbc: 38746a69     	ldrb	w9, [x19, x20]
40003bc0: 7101bd3f     	cmp	w9, #0x6f
40003bc4: 540005ed     	b.le	0x40003c80 <uart_printf+0x1ac>
40003bc8: 7101d13f     	cmp	w9, #0x74
40003bcc: 5400080c     	b.gt	0x40003ccc <uart_printf+0x1f8>
40003bd0: 7101c13f     	cmp	w9, #0x70
40003bd4: 54000f00     	b.eq	0x40003db4 <uart_printf+0x2e0>
40003bd8: 7101cd3f     	cmp	w9, #0x73
40003bdc: 54000b61     	b.ne	0x40003d48 <uart_printf+0x274>
40003be0: b98053e8     	ldrsw	x8, [sp, #0x50]
40003be4: 36f81408     	tbz	w8, #0x1f, 0x40003e64 <uart_printf+0x390>
40003be8: 11002109     	add	w9, w8, #0x8
40003bec: 3100211f     	cmn	w8, #0x8
40003bf0: b90053e9     	str	w9, [sp, #0x50]
40003bf4: 54001388     	b.hi	0x40003e64 <uart_printf+0x390>
40003bf8: f94023e9     	ldr	x9, [sp, #0x40]
40003bfc: 8b080128     	add	x8, x9, x8
40003c00: 1400009c     	b	0x40003e70 <uart_printf+0x39c>
40003c04: b94b82c8     	ldr	w8, [x22, #0xb80]
40003c08: 34000128     	cbz	w8, 0x40003c2c <uart_printf+0x158>
40003c0c: b94b86e8     	ldr	w8, [x23, #0xb84]
40003c10: 6b18011f     	cmp	w8, w24
40003c14: 540000cc     	b.gt	0x40003c2c <uart_printf+0x158>
40003c18: 93407d08     	sxtw	x8, w8
40003c1c: 91000509     	add	x9, x8, #0x1
40003c20: 38286b3a     	strb	w26, [x25, x8]
40003c24: b90b86e9     	str	w9, [x23, #0xb84]
40003c28: 38296b3f     	strb	wzr, [x25, x9]
40003c2c: b94002a8     	ldr	w8, [x21]
40003c30: 372fffe8     	tbnz	w8, #0x5, 0x40003c2c <uart_printf+0x158>
40003c34: b900037a     	str	w26, [x27]
40003c38: 38746a68     	ldrb	w8, [x19, x20]
40003c3c: b94b82c9     	ldr	w9, [x22, #0xb80]
40003c40: 34000129     	cbz	w9, 0x40003c64 <uart_printf+0x190>
40003c44: b94b86e9     	ldr	w9, [x23, #0xb84]
40003c48: 6b18013f     	cmp	w9, w24
40003c4c: 540000cc     	b.gt	0x40003c64 <uart_printf+0x190>
40003c50: 93407d29     	sxtw	x9, w9
40003c54: 9100052a     	add	x10, x9, #0x1
40003c58: 38296b28     	strb	w8, [x25, x9]
40003c5c: b90b86ea     	str	w10, [x23, #0xb84]
40003c60: 382a6b3f     	strb	wzr, [x25, x10]
40003c64: b94002a9     	ldr	w9, [x21]
40003c68: 372fffe9     	tbnz	w9, #0x5, 0x40003c64 <uart_printf+0x190>
40003c6c: 17ffffc0     	b	0x40003b6c <uart_printf+0x98>
40003c70: 2a0803e9     	mov	w9, w8
40003c74: aa0a03f4     	mov	x20, x10
40003c78: 7101bd3f     	cmp	w9, #0x6f
40003c7c: 54fffa6c     	b.gt	0x40003bc8 <uart_printf+0xf4>
40003c80: 7100953f     	cmp	w9, #0x25
40003c84: 54000440     	b.eq	0x40003d0c <uart_printf+0x238>
40003c88: 71018d3f     	cmp	w9, #0x63
40003c8c: 54000c00     	b.eq	0x40003e0c <uart_printf+0x338>
40003c90: 7101913f     	cmp	w9, #0x64
40003c94: 540005a1     	b.ne	0x40003d48 <uart_printf+0x274>
40003c98: b98053e9     	ldrsw	x9, [sp, #0x50]
40003c9c: 7101b11f     	cmp	w8, #0x6c
40003ca0: 540017c1     	b.ne	0x40003f98 <uart_printf+0x4c4>
40003ca4: 36f823c9     	tbz	w9, #0x1f, 0x4000411c <uart_printf+0x648>
40003ca8: 11002128     	add	w8, w9, #0x8
40003cac: 3100213f     	cmn	w9, #0x8
40003cb0: b90053e8     	str	w8, [sp, #0x50]
40003cb4: 54002348     	b.hi	0x4000411c <uart_printf+0x648>
40003cb8: f94023e8     	ldr	x8, [sp, #0x40]
40003cbc: 8b090108     	add	x8, x8, x9
40003cc0: f9400108     	ldr	x8, [x8]
40003cc4: b6f829a8     	tbz	x8, #0x3f, 0x400041f8 <uart_printf+0x724>
40003cc8: 1400011a     	b	0x40004130 <uart_printf+0x65c>
40003ccc: 7101d53f     	cmp	w9, #0x75
40003cd0: 54000840     	b.eq	0x40003dd8 <uart_printf+0x304>
40003cd4: 7101e13f     	cmp	w9, #0x78
40003cd8: 54000381     	b.ne	0x40003d48 <uart_printf+0x274>
40003cdc: b98053e9     	ldrsw	x9, [sp, #0x50]
40003ce0: 7101b11f     	cmp	w8, #0x6c
40003ce4: 540014a1     	b.ne	0x40003f78 <uart_printf+0x4a4>
40003ce8: 36f81d49     	tbz	w9, #0x1f, 0x40004090 <uart_printf+0x5bc>
40003cec: 11002128     	add	w8, w9, #0x8
40003cf0: 3100213f     	cmn	w9, #0x8
40003cf4: b90053e8     	str	w8, [sp, #0x50]
40003cf8: 54001cc8     	b.hi	0x40004090 <uart_printf+0x5bc>
40003cfc: f94023e8     	ldr	x8, [sp, #0x40]
40003d00: 8b090108     	add	x8, x8, x9
40003d04: f9400108     	ldr	x8, [x8]
40003d08: 140000eb     	b	0x400040b4 <uart_printf+0x5e0>
40003d0c: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d10: 34000128     	cbz	w8, 0x40003d34 <uart_printf+0x260>
40003d14: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d18: 6b18011f     	cmp	w8, w24
40003d1c: 540000cc     	b.gt	0x40003d34 <uart_printf+0x260>
40003d20: 93407d08     	sxtw	x8, w8
40003d24: 91000509     	add	x9, x8, #0x1
40003d28: 38286b2e     	strb	w14, [x25, x8]
40003d2c: b90b86e9     	str	w9, [x23, #0xb84]
40003d30: 38296b3f     	strb	wzr, [x25, x9]
40003d34: b94002a8     	ldr	w8, [x21]
40003d38: 372fffe8     	tbnz	w8, #0x5, 0x40003d34 <uart_printf+0x260>
40003d3c: b900036e     	str	w14, [x27]
40003d40: 91000694     	add	x20, x20, #0x1
40003d44: 17ffff8c     	b	0x40003b74 <uart_printf+0xa0>
40003d48: b94b82c8     	ldr	w8, [x22, #0xb80]
40003d4c: 34000128     	cbz	w8, 0x40003d70 <uart_printf+0x29c>
40003d50: b94b86e8     	ldr	w8, [x23, #0xb84]
40003d54: 6b18011f     	cmp	w8, w24
40003d58: 540000cc     	b.gt	0x40003d70 <uart_printf+0x29c>
40003d5c: 93407d08     	sxtw	x8, w8
40003d60: 91000509     	add	x9, x8, #0x1
40003d64: 38286b2e     	strb	w14, [x25, x8]
40003d68: b90b86e9     	str	w9, [x23, #0xb84]
40003d6c: 38296b3f     	strb	wzr, [x25, x9]
40003d70: b94002a8     	ldr	w8, [x21]
40003d74: 372fffe8     	tbnz	w8, #0x5, 0x40003d70 <uart_printf+0x29c>
40003d78: b900036e     	str	w14, [x27]
40003d7c: b94b82c9     	ldr	w9, [x22, #0xb80]
40003d80: 38746a68     	ldrb	w8, [x19, x20]
40003d84: 34000129     	cbz	w9, 0x40003da8 <uart_printf+0x2d4>
40003d88: b94b86e9     	ldr	w9, [x23, #0xb84]
40003d8c: 6b18013f     	cmp	w9, w24
40003d90: 540000cc     	b.gt	0x40003da8 <uart_printf+0x2d4>
40003d94: 93407d29     	sxtw	x9, w9
40003d98: 9100052a     	add	x10, x9, #0x1
40003d9c: 38296b28     	strb	w8, [x25, x9]
40003da0: b90b86ea     	str	w10, [x23, #0xb84]
40003da4: 382a6b3f     	strb	wzr, [x25, x10]
40003da8: b94002a9     	ldr	w9, [x21]
40003dac: 372fffe9     	tbnz	w9, #0x5, 0x40003da8 <uart_printf+0x2d4>
40003db0: 17ffff6f     	b	0x40003b6c <uart_printf+0x98>
40003db4: b98053e8     	ldrsw	x8, [sp, #0x50]
40003db8: 36f803c8     	tbz	w8, #0x1f, 0x40003e30 <uart_printf+0x35c>
40003dbc: 11002109     	add	w9, w8, #0x8
40003dc0: 3100211f     	cmn	w8, #0x8
40003dc4: b90053e9     	str	w9, [sp, #0x50]
40003dc8: 54000348     	b.hi	0x40003e30 <uart_printf+0x35c>
40003dcc: f94023e9     	ldr	x9, [sp, #0x40]
40003dd0: 8b080128     	add	x8, x9, x8
40003dd4: 1400001a     	b	0x40003e3c <uart_printf+0x368>
40003dd8: b98053e9     	ldrsw	x9, [sp, #0x50]
40003ddc: 7101b11f     	cmp	w8, #0x6c
40003de0: 54000bc1     	b.ne	0x40003f58 <uart_printf+0x484>
40003de4: 36f80ea9     	tbz	w9, #0x1f, 0x40003fb8 <uart_printf+0x4e4>
40003de8: 11002128     	add	w8, w9, #0x8
40003dec: 3100213f     	cmn	w9, #0x8
40003df0: b90053e8     	str	w8, [sp, #0x50]
40003df4: 54000e28     	b.hi	0x40003fb8 <uart_printf+0x4e4>
40003df8: f94023e8     	ldr	x8, [sp, #0x40]
40003dfc: 8b090108     	add	x8, x8, x9
40003e00: f9400109     	ldr	x9, [x8]
40003e04: b50010a9     	cbnz	x9, 0x40004018 <uart_printf+0x544>
40003e08: 14000071     	b	0x40003fcc <uart_printf+0x4f8>
40003e0c: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e10: 36f80828     	tbz	w8, #0x1f, 0x40003f14 <uart_printf+0x440>
40003e14: 11002109     	add	w9, w8, #0x8
40003e18: 3100211f     	cmn	w8, #0x8
40003e1c: b90053e9     	str	w9, [sp, #0x50]
40003e20: 540007a8     	b.hi	0x40003f14 <uart_printf+0x440>
40003e24: f94023e9     	ldr	x9, [sp, #0x40]
40003e28: 8b080128     	add	x8, x9, x8
40003e2c: 1400003d     	b	0x40003f20 <uart_printf+0x44c>
40003e30: f9401fe8     	ldr	x8, [sp, #0x38]
40003e34: 91002109     	add	x9, x8, #0x8
40003e38: f9001fe9     	str	x9, [sp, #0x38]
40003e3c: f9400100     	ldr	x0, [x8]
40003e40: 97fffe83     	bl	0x4000384c <uart_print_hex>
40003e44: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003e48: 528004ae     	mov	w14, #0x25              // =37
40003e4c: 52800150     	mov	w16, #0xa               // =10
40003e50: f29999af     	movk	x15, #0xcccd
40003e54: d503201f     	nop
40003e58: 3001b511     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
40003e5c: 91000694     	add	x20, x20, #0x1
40003e60: 17ffff45     	b	0x40003b74 <uart_printf+0xa0>
40003e64: f9401fe8     	ldr	x8, [sp, #0x38]
40003e68: 91002109     	add	x9, x8, #0x8
40003e6c: f9001fe9     	str	x9, [sp, #0x38]
40003e70: f9400108     	ldr	x8, [x8]
40003e74: d0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40003e78: 91153129     	add	x9, x9, #0x54c
40003e7c: f100011f     	cmp	x8, #0x0
40003e80: 9a880128     	csel	x8, x9, x8, eq
40003e84: 39400109     	ldrb	w9, [x8]
40003e88: 7100293f     	cmp	w9, #0xa
40003e8c: 540000a0     	b.eq	0x40003ea0 <uart_printf+0x3cc>
40003e90: 34ffe709     	cbz	w9, 0x40003b70 <uart_printf+0x9c>
40003e94: b94b82ca     	ldr	w10, [x22, #0xb80]
40003e98: 3500024a     	cbnz	w10, 0x40003ee0 <uart_printf+0x40c>
40003e9c: 14000019     	b	0x40003f00 <uart_printf+0x42c>
40003ea0: b94b82c9     	ldr	w9, [x22, #0xb80]
40003ea4: 34000129     	cbz	w9, 0x40003ec8 <uart_printf+0x3f4>
40003ea8: b94b86e9     	ldr	w9, [x23, #0xb84]
40003eac: 6b18013f     	cmp	w9, w24
40003eb0: 540000cc     	b.gt	0x40003ec8 <uart_printf+0x3f4>
40003eb4: 93407d29     	sxtw	x9, w9
40003eb8: 9100052a     	add	x10, x9, #0x1
40003ebc: 38296b3a     	strb	w26, [x25, x9]
40003ec0: b90b86ea     	str	w10, [x23, #0xb84]
40003ec4: 382a6b3f     	strb	wzr, [x25, x10]
40003ec8: b94002a9     	ldr	w9, [x21]
40003ecc: 372fffe9     	tbnz	w9, #0x5, 0x40003ec8 <uart_printf+0x3f4>
40003ed0: b900037a     	str	w26, [x27]
40003ed4: 39400109     	ldrb	w9, [x8]
40003ed8: b94b82ca     	ldr	w10, [x22, #0xb80]
40003edc: 3400012a     	cbz	w10, 0x40003f00 <uart_printf+0x42c>
40003ee0: b94b86ea     	ldr	w10, [x23, #0xb84]
40003ee4: 6b18015f     	cmp	w10, w24
40003ee8: 540000cc     	b.gt	0x40003f00 <uart_printf+0x42c>
40003eec: 93407d4a     	sxtw	x10, w10
40003ef0: 9100054b     	add	x11, x10, #0x1
40003ef4: 382a6b29     	strb	w9, [x25, x10]
40003ef8: b90b86eb     	str	w11, [x23, #0xb84]
40003efc: 382b6b3f     	strb	wzr, [x25, x11]
40003f00: 91000508     	add	x8, x8, #0x1
40003f04: b94002aa     	ldr	w10, [x21]
40003f08: 372fffea     	tbnz	w10, #0x5, 0x40003f04 <uart_printf+0x430>
40003f0c: b9000369     	str	w9, [x27]
40003f10: 17ffffdd     	b	0x40003e84 <uart_printf+0x3b0>
40003f14: f9401fe8     	ldr	x8, [sp, #0x38]
40003f18: 91002109     	add	x9, x8, #0x8
40003f1c: f9001fe9     	str	x9, [sp, #0x38]
40003f20: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f24: 39400108     	ldrb	w8, [x8]
40003f28: 34000129     	cbz	w9, 0x40003f4c <uart_printf+0x478>
40003f2c: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f30: 6b18013f     	cmp	w9, w24
40003f34: 540000cc     	b.gt	0x40003f4c <uart_printf+0x478>
40003f38: 93407d29     	sxtw	x9, w9
40003f3c: 9100052a     	add	x10, x9, #0x1
40003f40: 38296b28     	strb	w8, [x25, x9]
40003f44: b90b86ea     	str	w10, [x23, #0xb84]
40003f48: 382a6b3f     	strb	wzr, [x25, x10]
40003f4c: b94002a9     	ldr	w9, [x21]
40003f50: 372fffe9     	tbnz	w9, #0x5, 0x40003f4c <uart_printf+0x478>
40003f54: 17ffff06     	b	0x40003b6c <uart_printf+0x98>
40003f58: 36f80569     	tbz	w9, #0x1f, 0x40004004 <uart_printf+0x530>
40003f5c: 11002128     	add	w8, w9, #0x8
40003f60: 3100213f     	cmn	w9, #0x8
40003f64: b90053e8     	str	w8, [sp, #0x50]
40003f68: 540004e8     	b.hi	0x40004004 <uart_printf+0x530>
40003f6c: f94023e8     	ldr	x8, [sp, #0x40]
40003f70: 8b090108     	add	x8, x8, x9
40003f74: 14000027     	b	0x40004010 <uart_printf+0x53c>
40003f78: 36f80969     	tbz	w9, #0x1f, 0x400040a4 <uart_printf+0x5d0>
40003f7c: 11002128     	add	w8, w9, #0x8
40003f80: 3100213f     	cmn	w9, #0x8
40003f84: b90053e8     	str	w8, [sp, #0x50]
40003f88: 540008e8     	b.hi	0x400040a4 <uart_printf+0x5d0>
40003f8c: f94023e8     	ldr	x8, [sp, #0x40]
40003f90: 8b090108     	add	x8, x8, x9
40003f94: 14000047     	b	0x400040b0 <uart_printf+0x5dc>
40003f98: 36f81269     	tbz	w9, #0x1f, 0x400041e4 <uart_printf+0x710>
40003f9c: 11002128     	add	w8, w9, #0x8
40003fa0: 3100213f     	cmn	w9, #0x8
40003fa4: b90053e8     	str	w8, [sp, #0x50]
40003fa8: 540011e8     	b.hi	0x400041e4 <uart_printf+0x710>
40003fac: f94023e8     	ldr	x8, [sp, #0x40]
40003fb0: 8b090108     	add	x8, x8, x9
40003fb4: 1400008f     	b	0x400041f0 <uart_printf+0x71c>
40003fb8: f9401fe8     	ldr	x8, [sp, #0x38]
40003fbc: 91002109     	add	x9, x8, #0x8
40003fc0: f9001fe9     	str	x9, [sp, #0x38]
40003fc4: f9400109     	ldr	x9, [x8]
40003fc8: b5000289     	cbnz	x9, 0x40004018 <uart_printf+0x544>
40003fcc: b94b82c8     	ldr	w8, [x22, #0xb80]
40003fd0: 34000148     	cbz	w8, 0x40003ff8 <uart_printf+0x524>
40003fd4: b94b86e8     	ldr	w8, [x23, #0xb84]
40003fd8: 6b18011f     	cmp	w8, w24
40003fdc: 540000ec     	b.gt	0x40003ff8 <uart_printf+0x524>
40003fe0: 93407d08     	sxtw	x8, w8
40003fe4: 5280060a     	mov	w10, #0x30              // =48
40003fe8: 91000509     	add	x9, x8, #0x1
40003fec: 38286b2a     	strb	w10, [x25, x8]
40003ff0: b90b86e9     	str	w9, [x23, #0xb84]
40003ff4: 38296b3f     	strb	wzr, [x25, x9]
40003ff8: b94002a8     	ldr	w8, [x21]
40003ffc: 372fffe8     	tbnz	w8, #0x5, 0x40003ff8 <uart_printf+0x524>
40004000: 17fffeda     	b	0x40003b68 <uart_printf+0x94>
40004004: f9401fe8     	ldr	x8, [sp, #0x38]
40004008: 91002109     	add	x9, x8, #0x8
4000400c: f9001fe9     	str	x9, [sp, #0x38]
40004010: b9400109     	ldr	w9, [x8]
40004014: b4fffdc9     	cbz	x9, 0x40003fcc <uart_printf+0x4f8>
40004018: aa1f03ea     	mov	x10, xzr
4000401c: 9bcf7d28     	umulh	x8, x9, x15
40004020: f100253f     	cmp	x9, #0x9
40004024: d343fd0b     	lsr	x11, x8, #3
40004028: 91000548     	add	x8, x10, #0x1
4000402c: 1b10a56c     	msub	w12, w11, w16, w9
40004030: 321c0589     	orr	w9, w12, #0x30
40004034: 382a6b89     	strb	w9, [x28, x10]
40004038: aa0803ea     	mov	x10, x8
4000403c: aa0b03e9     	mov	x9, x11
40004040: 54fffee8     	b.hi	0x4000401c <uart_printf+0x548>
40004044: d1000509     	sub	x9, x8, #0x1
40004048: b94b82cb     	ldr	w11, [x22, #0xb80]
4000404c: 38696b8a     	ldrb	w10, [x28, x9]
40004050: 3400012b     	cbz	w11, 0x40004074 <uart_printf+0x5a0>
40004054: b94b86eb     	ldr	w11, [x23, #0xb84]
40004058: 6b18017f     	cmp	w11, w24
4000405c: 540000cc     	b.gt	0x40004074 <uart_printf+0x5a0>
40004060: 93407d6b     	sxtw	x11, w11
40004064: 9100056c     	add	x12, x11, #0x1
40004068: 382b6b2a     	strb	w10, [x25, x11]
4000406c: b90b86ec     	str	w12, [x23, #0xb84]
40004070: 382c6b3f     	strb	wzr, [x25, x12]
40004074: b94002ab     	ldr	w11, [x21]
40004078: 372fffeb     	tbnz	w11, #0x5, 0x40004074 <uart_printf+0x5a0>
4000407c: 7100051f     	cmp	w8, #0x1
40004080: aa0903e8     	mov	x8, x9
40004084: b900036a     	str	w10, [x27]
40004088: 54fffdec     	b.gt	0x40004044 <uart_printf+0x570>
4000408c: 17fffeb9     	b	0x40003b70 <uart_printf+0x9c>
40004090: f9401fe8     	ldr	x8, [sp, #0x38]
40004094: 91002109     	add	x9, x8, #0x8
40004098: f9001fe9     	str	x9, [sp, #0x38]
4000409c: f9400108     	ldr	x8, [x8]
400040a0: 14000005     	b	0x400040b4 <uart_printf+0x5e0>
400040a4: f9401fe8     	ldr	x8, [sp, #0x38]
400040a8: 91002109     	add	x9, x8, #0x8
400040ac: f9001fe9     	str	x9, [sp, #0x38]
400040b0: b9400108     	ldr	w8, [x8]
400040b4: 2a1f03e9     	mov	w9, wzr
400040b8: 5280078a     	mov	w10, #0x3c              // =60
400040bc: 14000003     	b	0x400040c8 <uart_printf+0x5f4>
400040c0: b4000daa     	cbz	x10, 0x40004274 <uart_printf+0x7a0>
400040c4: d100114a     	sub	x10, x10, #0x4
400040c8: 9aca250b     	lsr	x11, x8, x10
400040cc: f2400d6b     	ands	x11, x11, #0xf
400040d0: fa400944     	ccmp	x10, #0x0, #0x4, eq
400040d4: 1a9f1529     	csinc	w9, w9, wzr, ne
400040d8: 34ffff49     	cbz	w9, 0x400040c0 <uart_printf+0x5ec>
400040dc: b94b82cc     	ldr	w12, [x22, #0xb80]
400040e0: 386b6a2b     	ldrb	w11, [x17, x11]
400040e4: 3400012c     	cbz	w12, 0x40004108 <uart_printf+0x634>
400040e8: b94b86ec     	ldr	w12, [x23, #0xb84]
400040ec: 6b18019f     	cmp	w12, w24
400040f0: 540000cc     	b.gt	0x40004108 <uart_printf+0x634>
400040f4: 93407d8c     	sxtw	x12, w12
400040f8: 9100058d     	add	x13, x12, #0x1
400040fc: 382c6b2b     	strb	w11, [x25, x12]
40004100: b90b86ed     	str	w13, [x23, #0xb84]
40004104: 382d6b3f     	strb	wzr, [x25, x13]
40004108: b94002ac     	ldr	w12, [x21]
4000410c: 372fffec     	tbnz	w12, #0x5, 0x40004108 <uart_printf+0x634>
40004110: b900036b     	str	w11, [x27]
40004114: b5fffd8a     	cbnz	x10, 0x400040c4 <uart_printf+0x5f0>
40004118: 17fffe96     	b	0x40003b70 <uart_printf+0x9c>
4000411c: f9401fe8     	ldr	x8, [sp, #0x38]
40004120: 91002109     	add	x9, x8, #0x8
40004124: f9001fe9     	str	x9, [sp, #0x38]
40004128: f9400108     	ldr	x8, [x8]
4000412c: b6f80668     	tbz	x8, #0x3f, 0x400041f8 <uart_printf+0x724>
40004130: b94b82c9     	ldr	w9, [x22, #0xb80]
40004134: 34000149     	cbz	w9, 0x4000415c <uart_printf+0x688>
40004138: b94b86e9     	ldr	w9, [x23, #0xb84]
4000413c: 6b18013f     	cmp	w9, w24
40004140: 540000ec     	b.gt	0x4000415c <uart_printf+0x688>
40004144: 93407d29     	sxtw	x9, w9
40004148: 528005ab     	mov	w11, #0x2d              // =45
4000414c: 9100052a     	add	x10, x9, #0x1
40004150: 38296b2b     	strb	w11, [x25, x9]
40004154: b90b86ea     	str	w10, [x23, #0xb84]
40004158: 382a6b3f     	strb	wzr, [x25, x10]
4000415c: b94002a9     	ldr	w9, [x21]
40004160: 372fffe9     	tbnz	w9, #0x5, 0x4000415c <uart_printf+0x688>
40004164: aa1f03e9     	mov	x9, xzr
40004168: 528005aa     	mov	w10, #0x2d              // =45
4000416c: cb0803e8     	neg	x8, x8
40004170: b900036a     	str	w10, [x27]
40004174: 9bcf7d0a     	umulh	x10, x8, x15
40004178: f100251f     	cmp	x8, #0x9
4000417c: d343fd4a     	lsr	x10, x10, #3
40004180: 1b10a14b     	msub	w11, w10, w16, w8
40004184: 321c0568     	orr	w8, w11, #0x30
40004188: 38296b88     	strb	w8, [x28, x9]
4000418c: 91000529     	add	x9, x9, #0x1
40004190: aa0a03e8     	mov	x8, x10
40004194: 54ffff08     	b.hi	0x40004174 <uart_printf+0x6a0>
40004198: d1000528     	sub	x8, x9, #0x1
4000419c: b94b82cb     	ldr	w11, [x22, #0xb80]
400041a0: 38686b8a     	ldrb	w10, [x28, x8]
400041a4: 3400012b     	cbz	w11, 0x400041c8 <uart_printf+0x6f4>
400041a8: b94b86eb     	ldr	w11, [x23, #0xb84]
400041ac: 6b18017f     	cmp	w11, w24
400041b0: 540000cc     	b.gt	0x400041c8 <uart_printf+0x6f4>
400041b4: 93407d6b     	sxtw	x11, w11
400041b8: 9100056c     	add	x12, x11, #0x1
400041bc: 382b6b2a     	strb	w10, [x25, x11]
400041c0: b90b86ec     	str	w12, [x23, #0xb84]
400041c4: 382c6b3f     	strb	wzr, [x25, x12]
400041c8: b94002ab     	ldr	w11, [x21]
400041cc: 372fffeb     	tbnz	w11, #0x5, 0x400041c8 <uart_printf+0x6f4>
400041d0: 7100053f     	cmp	w9, #0x1
400041d4: aa0803e9     	mov	x9, x8
400041d8: b900036a     	str	w10, [x27]
400041dc: 54fffdec     	b.gt	0x40004198 <uart_printf+0x6c4>
400041e0: 17fffe64     	b	0x40003b70 <uart_printf+0x9c>
400041e4: f9401fe8     	ldr	x8, [sp, #0x38]
400041e8: 91002109     	add	x9, x8, #0x8
400041ec: f9001fe9     	str	x9, [sp, #0x38]
400041f0: b9800108     	ldrsw	x8, [x8]
400041f4: b7fff9e8     	tbnz	x8, #0x3f, 0x40004130 <uart_printf+0x65c>
400041f8: b40005a8     	cbz	x8, 0x400042ac <uart_printf+0x7d8>
400041fc: aa1f03ea     	mov	x10, xzr
40004200: 9bcf7d09     	umulh	x9, x8, x15
40004204: f100251f     	cmp	x8, #0x9
40004208: d343fd2b     	lsr	x11, x9, #3
4000420c: 91000549     	add	x9, x10, #0x1
40004210: 1b10a16c     	msub	w12, w11, w16, w8
40004214: 321c0588     	orr	w8, w12, #0x30
40004218: 382a6b88     	strb	w8, [x28, x10]
4000421c: aa0903ea     	mov	x10, x9
40004220: aa0b03e8     	mov	x8, x11
40004224: 54fffee8     	b.hi	0x40004200 <uart_printf+0x72c>
40004228: d1000528     	sub	x8, x9, #0x1
4000422c: b94b82cb     	ldr	w11, [x22, #0xb80]
40004230: 38686b8a     	ldrb	w10, [x28, x8]
40004234: 3400012b     	cbz	w11, 0x40004258 <uart_printf+0x784>
40004238: b94b86eb     	ldr	w11, [x23, #0xb84]
4000423c: 6b18017f     	cmp	w11, w24
40004240: 540000cc     	b.gt	0x40004258 <uart_printf+0x784>
40004244: 93407d6b     	sxtw	x11, w11
40004248: 9100056c     	add	x12, x11, #0x1
4000424c: 382b6b2a     	strb	w10, [x25, x11]
40004250: b90b86ec     	str	w12, [x23, #0xb84]
40004254: 382c6b3f     	strb	wzr, [x25, x12]
40004258: b94002ab     	ldr	w11, [x21]
4000425c: 372fffeb     	tbnz	w11, #0x5, 0x40004258 <uart_printf+0x784>
40004260: 7100053f     	cmp	w9, #0x1
40004264: aa0803e9     	mov	x9, x8
40004268: b900036a     	str	w10, [x27]
4000426c: 54fffdec     	b.gt	0x40004228 <uart_printf+0x754>
40004270: 17fffe40     	b	0x40003b70 <uart_printf+0x9c>
40004274: b94b82c8     	ldr	w8, [x22, #0xb80]
40004278: 34000148     	cbz	w8, 0x400042a0 <uart_printf+0x7cc>
4000427c: b94b86e8     	ldr	w8, [x23, #0xb84]
40004280: 6b18011f     	cmp	w8, w24
40004284: 540000ec     	b.gt	0x400042a0 <uart_printf+0x7cc>
40004288: 93407d08     	sxtw	x8, w8
4000428c: 5280060a     	mov	w10, #0x30              // =48
40004290: 91000509     	add	x9, x8, #0x1
40004294: 38286b2a     	strb	w10, [x25, x8]
40004298: b90b86e9     	str	w9, [x23, #0xb84]
4000429c: 38296b3f     	strb	wzr, [x25, x9]
400042a0: b94002a8     	ldr	w8, [x21]
400042a4: 372fffe8     	tbnz	w8, #0x5, 0x400042a0 <uart_printf+0x7cc>
400042a8: 17fffe30     	b	0x40003b68 <uart_printf+0x94>
400042ac: b94b82c8     	ldr	w8, [x22, #0xb80]
400042b0: 34000148     	cbz	w8, 0x400042d8 <uart_printf+0x804>
400042b4: b94b86e8     	ldr	w8, [x23, #0xb84]
400042b8: 6b18011f     	cmp	w8, w24
400042bc: 540000ec     	b.gt	0x400042d8 <uart_printf+0x804>
400042c0: 93407d08     	sxtw	x8, w8
400042c4: 5280060a     	mov	w10, #0x30              // =48
400042c8: 91000509     	add	x9, x8, #0x1
400042cc: 38286b2a     	strb	w10, [x25, x8]
400042d0: b90b86e9     	str	w9, [x23, #0xb84]
400042d4: 38296b3f     	strb	wzr, [x25, x9]
400042d8: b94002a8     	ldr	w8, [x21]
400042dc: 372fffe8     	tbnz	w8, #0x5, 0x400042d8 <uart_printf+0x804>
400042e0: 17fffe22     	b	0x40003b68 <uart_printf+0x94>
400042e4: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
400042e8: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
400042ec: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
400042f0: a94967fa     	ldp	x26, x25, [sp, #0x90]
400042f4: a9486ffc     	ldp	x28, x27, [sp, #0x80]
400042f8: a9477bfd     	ldp	x29, x30, [sp, #0x70]
400042fc: 910343ff     	add	sp, sp, #0xd0
40004300: d65f03c0     	ret

0000000040004304 <vfs_init>:
40004304: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004308: a9044ff4     	stp	x20, x19, [sp, #0x40]
4000430c: f0000073     	adrp	x19, 0x40013000 <kernel_capture_buffer+0x3478>
40004310: 912e8273     	add	x19, x19, #0xba0
40004314: f9000bf9     	str	x25, [sp, #0x10]
40004318: f0000079     	adrp	x25, 0x40013000 <kernel_capture_buffer+0x3478>
4000431c: 52800034     	mov	w20, #0x1               // =1
40004320: aa1303e0     	mov	x0, x19
40004324: 2a1f03e1     	mov	w1, wzr
40004328: 52809802     	mov	w2, #0x4c0              // =1216
4000432c: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004330: 910003fd     	mov	x29, sp
40004334: a90357f6     	stp	x22, x21, [sp, #0x30]
40004338: b90b8b34     	str	w20, [x25, #0xb88]
4000433c: 97fff983     	bl	0x40002948 <memset>
40004340: 528005e8     	mov	w8, #0x2f               // =47
40004344: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004348: b9002274     	str	w20, [x19, #0x20]
4000434c: 79000268     	strh	w8, [x19]
40004350: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004354: f905c933     	str	x19, [x9, #0xb90]
40004358: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
4000435c: 7101fd1f     	cmp	w8, #0x7f
40004360: f9021a7f     	str	xzr, [x19, #0x430]
40004364: f900167f     	str	xzr, [x19, #0x28]
40004368: b904ba7f     	str	wzr, [x19, #0x4b8]
4000436c: f905cd33     	str	x19, [x9, #0xb98]
40004370: 540028ac     	b.gt	0x40004884 <vfs_init+0x580>
40004374: 52809809     	mov	w9, #0x4c0              // =1216
40004378: 2a1f03e1     	mov	w1, wzr
4000437c: 52809802     	mov	w2, #0x4c0              // =1216
40004380: 9b294d17     	smaddl	x23, w8, w9, x19
40004384: 11000508     	add	w8, w8, #0x1
40004388: b90b8b28     	str	w8, [x25, #0xb88]
4000438c: aa1703e0     	mov	x0, x23
40004390: 97fff96e     	bl	0x40002948 <memset>
40004394: 528d2c48     	mov	w8, #0x6962             // =26978
40004398: b904baff     	str	wzr, [x23, #0x4b8]
4000439c: 72a00dc8     	movk	w8, #0x6e, lsl #16
400043a0: b90022f4     	str	w20, [x23, #0x20]
400043a4: b90002e8     	str	w8, [x23]
400043a8: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400043ac: f9021af3     	str	x19, [x23, #0x430]
400043b0: 71003d1f     	cmp	w8, #0xf
400043b4: f90016ff     	str	xzr, [x23, #0x28]
400043b8: 540000ac     	b.gt	0x400043cc <vfs_init+0xc8>
400043bc: 11000509     	add	w9, w8, #0x1
400043c0: 8b080e68     	add	x8, x19, x8, lsl #3
400043c4: b904ba69     	str	w9, [x19, #0x4b8]
400043c8: f9021d17     	str	x23, [x8, #0x438]
400043cc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400043d0: 7101fd1f     	cmp	w8, #0x7f
400043d4: 5400258c     	b.gt	0x40004884 <vfs_init+0x580>
400043d8: 52809809     	mov	w9, #0x4c0              // =1216
400043dc: 2a1f03e1     	mov	w1, wzr
400043e0: 52809802     	mov	w2, #0x4c0              // =1216
400043e4: 9b294d16     	smaddl	x22, w8, w9, x19
400043e8: 11000508     	add	w8, w8, #0x1
400043ec: b90b8b28     	str	w8, [x25, #0xb88]
400043f0: aa1603e0     	mov	x0, x22
400043f4: 97fff955     	bl	0x40002948 <memset>
400043f8: 528e8ca8     	mov	w8, #0x7465             // =29797
400043fc: b904badf     	str	wzr, [x22, #0x4b8]
40004400: 52800029     	mov	w9, #0x1                // =1
40004404: 72a00c68     	movk	w8, #0x63, lsl #16
40004408: b90022c9     	str	w9, [x22, #0x20]
4000440c: b90002c8     	str	w8, [x22]
40004410: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004414: f9021ad3     	str	x19, [x22, #0x430]
40004418: 71003d1f     	cmp	w8, #0xf
4000441c: f90016df     	str	xzr, [x22, #0x28]
40004420: 540000ac     	b.gt	0x40004434 <vfs_init+0x130>
40004424: 11000509     	add	w9, w8, #0x1
40004428: 8b080e68     	add	x8, x19, x8, lsl #3
4000442c: b904ba69     	str	w9, [x19, #0x4b8]
40004430: f9021d16     	str	x22, [x8, #0x438]
40004434: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004438: 7101fd1f     	cmp	w8, #0x7f
4000443c: 5400224c     	b.gt	0x40004884 <vfs_init+0x580>
40004440: 52809809     	mov	w9, #0x4c0              // =1216
40004444: 2a1f03e1     	mov	w1, wzr
40004448: 52809802     	mov	w2, #0x4c0              // =1216
4000444c: 9b294d14     	smaddl	x20, w8, w9, x19
40004450: 11000508     	add	w8, w8, #0x1
40004454: b90b8b28     	str	w8, [x25, #0xb88]
40004458: aa1403e0     	mov	x0, x20
4000445c: 97fff93b     	bl	0x40002948 <memset>
40004460: 528ded08     	mov	w8, #0x6f68             // =28520
40004464: b904ba9f     	str	wzr, [x20, #0x4b8]
40004468: 52800029     	mov	w9, #0x1                // =1
4000446c: 72acada8     	movk	w8, #0x656d, lsl #16
40004470: 3900129f     	strb	wzr, [x20, #0x4]
40004474: b9000288     	str	w8, [x20]
40004478: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000447c: b9002289     	str	w9, [x20, #0x20]
40004480: 71003d1f     	cmp	w8, #0xf
40004484: f9021a93     	str	x19, [x20, #0x430]
40004488: f900169f     	str	xzr, [x20, #0x28]
4000448c: 540000ac     	b.gt	0x400044a0 <vfs_init+0x19c>
40004490: 11000509     	add	w9, w8, #0x1
40004494: 8b080e68     	add	x8, x19, x8, lsl #3
40004498: b904ba69     	str	w9, [x19, #0x4b8]
4000449c: f9021d14     	str	x20, [x8, #0x438]
400044a0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400044a4: 7101fd1f     	cmp	w8, #0x7f
400044a8: 54001eec     	b.gt	0x40004884 <vfs_init+0x580>
400044ac: 52809809     	mov	w9, #0x4c0              // =1216
400044b0: 2a1f03e1     	mov	w1, wzr
400044b4: 52809802     	mov	w2, #0x4c0              // =1216
400044b8: 9b294d15     	smaddl	x21, w8, w9, x19
400044bc: 11000508     	add	w8, w8, #0x1
400044c0: b90b8b28     	str	w8, [x25, #0xb88]
400044c4: aa1503e0     	mov	x0, x21
400044c8: 97fff920     	bl	0x40002948 <memset>
400044cc: 528dec88     	mov	w8, #0x6f64             // =28516
400044d0: b904babf     	str	wzr, [x21, #0x4b8]
400044d4: 52800029     	mov	w9, #0x1                // =1
400044d8: 72ae6c68     	movk	w8, #0x7363, lsl #16
400044dc: 390012bf     	strb	wzr, [x21, #0x4]
400044e0: b90002a8     	str	w8, [x21]
400044e4: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400044e8: b90022a9     	str	w9, [x21, #0x20]
400044ec: 71003d1f     	cmp	w8, #0xf
400044f0: f9021ab3     	str	x19, [x21, #0x430]
400044f4: f90016bf     	str	xzr, [x21, #0x28]
400044f8: 540000ac     	b.gt	0x4000450c <vfs_init+0x208>
400044fc: 11000509     	add	w9, w8, #0x1
40004500: 8b080e68     	add	x8, x19, x8, lsl #3
40004504: b904ba69     	str	w9, [x19, #0x4b8]
40004508: f9021d15     	str	x21, [x8, #0x438]
4000450c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004510: 7101fd1f     	cmp	w8, #0x7f
40004514: 54001b8c     	b.gt	0x40004884 <vfs_init+0x580>
40004518: 52809809     	mov	w9, #0x4c0              // =1216
4000451c: 2a1f03e1     	mov	w1, wzr
40004520: 52809802     	mov	w2, #0x4c0              // =1216
40004524: 9b294d18     	smaddl	x24, w8, w9, x19
40004528: 11000508     	add	w8, w8, #0x1
4000452c: b90b8b28     	str	w8, [x25, #0xb88]
40004530: aa1803e0     	mov	x0, x24
40004534: 97fff905     	bl	0x40002948 <memset>
40004538: 528d2c28     	mov	w8, #0x6961             // =26977
4000453c: b904bb1f     	str	wzr, [x24, #0x4b8]
40004540: 79000308     	strh	w8, [x24]
40004544: b984bae8     	ldrsw	x8, [x23, #0x4b8]
40004548: 39000b1f     	strb	wzr, [x24, #0x2]
4000454c: 71003d1f     	cmp	w8, #0xf
40004550: b900231f     	str	wzr, [x24, #0x20]
40004554: f9021b17     	str	x23, [x24, #0x430]
40004558: f900171f     	str	xzr, [x24, #0x28]
4000455c: 540000ac     	b.gt	0x40004570 <vfs_init+0x26c>
40004560: 8b080ee9     	add	x9, x23, x8, lsl #3
40004564: 11000508     	add	w8, w8, #0x1
40004568: b904bae8     	str	w8, [x23, #0x4b8]
4000456c: f9021d38     	str	x24, [x9, #0x438]
40004570: d503201f     	nop
40004574: 100275b7     	adr	x23, 0x40009428 <__rodata_start+0x2428>
40004578: 9100c300     	add	x0, x24, #0x30
4000457c: aa1703e1     	mov	x1, x23
40004580: 97fff8c6     	bl	0x40002898 <kstrcpy>
40004584: aa1703e0     	mov	x0, x23
40004588: 97fff895     	bl	0x400027dc <kstrlen>
4000458c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004590: f9001700     	str	x0, [x24, #0x28]
40004594: 7101fd1f     	cmp	w8, #0x7f
40004598: 5400176c     	b.gt	0x40004884 <vfs_init+0x580>
4000459c: 52809809     	mov	w9, #0x4c0              // =1216
400045a0: 2a1f03e1     	mov	w1, wzr
400045a4: 52809802     	mov	w2, #0x4c0              // =1216
400045a8: 9b294d17     	smaddl	x23, w8, w9, x19
400045ac: 11000508     	add	w8, w8, #0x1
400045b0: b90b8b28     	str	w8, [x25, #0xb88]
400045b4: aa1703e0     	mov	x0, x23
400045b8: 97fff8e4     	bl	0x40002948 <memset>
400045bc: d28e6de8     	mov	x8, #0x736f             // =29551
400045c0: b904baff     	str	wzr, [x23, #0x4b8]
400045c4: 528cae69     	mov	w9, #0x6573             // =25971
400045c8: f2ae45a8     	movk	x8, #0x722d, lsl #16
400045cc: 790012e9     	strh	w9, [x23, #0x8]
400045d0: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
400045d4: 39002aff     	strb	wzr, [x23, #0xa]
400045d8: f2ec2ca8     	movk	x8, #0x6165, lsl #48
400045dc: b90022ff     	str	wzr, [x23, #0x20]
400045e0: f90002e8     	str	x8, [x23]
400045e4: b984bac8     	ldrsw	x8, [x22, #0x4b8]
400045e8: f9021af6     	str	x22, [x23, #0x430]
400045ec: 71003d1f     	cmp	w8, #0xf
400045f0: f90016ff     	str	xzr, [x23, #0x28]
400045f4: 540000ac     	b.gt	0x40004608 <vfs_init+0x304>
400045f8: 8b080ec9     	add	x9, x22, x8, lsl #3
400045fc: 11000508     	add	w8, w8, #0x1
40004600: b904bac8     	str	w8, [x22, #0x4b8]
40004604: f9021d37     	str	x23, [x9, #0x438]
40004608: f0000016     	adrp	x22, 0x40007000 <__rodata_start>
4000460c: 913502d6     	add	x22, x22, #0xd40
40004610: 9100c2e0     	add	x0, x23, #0x30
40004614: aa1603e1     	mov	x1, x22
40004618: 97fff8a0     	bl	0x40002898 <kstrcpy>
4000461c: aa1603e0     	mov	x0, x22
40004620: 97fff86f     	bl	0x400027dc <kstrlen>
40004624: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004628: f90016e0     	str	x0, [x23, #0x28]
4000462c: 7101fd1f     	cmp	w8, #0x7f
40004630: 540012ac     	b.gt	0x40004884 <vfs_init+0x580>
40004634: 52809809     	mov	w9, #0x4c0              // =1216
40004638: 2a1f03e1     	mov	w1, wzr
4000463c: 52809802     	mov	w2, #0x4c0              // =1216
40004640: 9b294d16     	smaddl	x22, w8, w9, x19
40004644: 11000508     	add	w8, w8, #0x1
40004648: b90b8b28     	str	w8, [x25, #0xb88]
4000464c: aa1603e0     	mov	x0, x22
40004650: 97fff8be     	bl	0x40002948 <memset>
40004654: d28caee8     	mov	x8, #0x6577             // =25975
40004658: b904badf     	str	wzr, [x22, #0x4b8]
4000465c: 528f0e89     	mov	w9, #0x7874             // =30836
40004660: f2ac6d88     	movk	x8, #0x636c, lsl #16
40004664: 72a00e89     	movk	w9, #0x74, lsl #16
40004668: b90022df     	str	wzr, [x22, #0x20]
4000466c: f2cdade8     	movk	x8, #0x6d6f, lsl #32
40004670: b9000ac9     	str	w9, [x22, #0x8]
40004674: f2e5cca8     	movk	x8, #0x2e65, lsl #48
40004678: f9021ad5     	str	x21, [x22, #0x430]
4000467c: f90002c8     	str	x8, [x22]
40004680: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004684: f90016df     	str	xzr, [x22, #0x28]
40004688: 71003d1f     	cmp	w8, #0xf
4000468c: 540000ac     	b.gt	0x400046a0 <vfs_init+0x39c>
40004690: 8b080ea9     	add	x9, x21, x8, lsl #3
40004694: 11000508     	add	w8, w8, #0x1
40004698: b904baa8     	str	w8, [x21, #0x4b8]
4000469c: f9021d36     	str	x22, [x9, #0x438]
400046a0: f0000017     	adrp	x23, 0x40007000 <__rodata_start>
400046a4: 913aa2f7     	add	x23, x23, #0xea8
400046a8: 9100c2c0     	add	x0, x22, #0x30
400046ac: aa1703e1     	mov	x1, x23
400046b0: 97fff87a     	bl	0x40002898 <kstrcpy>
400046b4: aa1703e0     	mov	x0, x23
400046b8: 97fff849     	bl	0x400027dc <kstrlen>
400046bc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400046c0: f90016c0     	str	x0, [x22, #0x28]
400046c4: 7101fd1f     	cmp	w8, #0x7f
400046c8: 54000dec     	b.gt	0x40004884 <vfs_init+0x580>
400046cc: 52809809     	mov	w9, #0x4c0              // =1216
400046d0: 2a1f03e1     	mov	w1, wzr
400046d4: 52809802     	mov	w2, #0x4c0              // =1216
400046d8: 9b294d16     	smaddl	x22, w8, w9, x19
400046dc: 11000508     	add	w8, w8, #0x1
400046e0: b90b8b28     	str	w8, [x25, #0xb88]
400046e4: aa1603e0     	mov	x0, x22
400046e8: 97fff898     	bl	0x40002948 <memset>
400046ec: d28c2d08     	mov	x8, #0x6168             // =24936
400046f0: b904badf     	str	wzr, [x22, #0x4b8]
400046f4: 528e85c9     	mov	w9, #0x742e             // =29742
400046f8: f2ac8e48     	movk	x8, #0x6472, lsl #16
400046fc: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004700: 390032df     	strb	wzr, [x22, #0xc]
40004704: f2cc2ee8     	movk	x8, #0x6177, lsl #32
40004708: b9000ac9     	str	w9, [x22, #0x8]
4000470c: f2ecae48     	movk	x8, #0x6572, lsl #48
40004710: b90022df     	str	wzr, [x22, #0x20]
40004714: f90002c8     	str	x8, [x22]
40004718: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000471c: f9021ad5     	str	x21, [x22, #0x430]
40004720: 71003d1f     	cmp	w8, #0xf
40004724: f90016df     	str	xzr, [x22, #0x28]
40004728: 540000ac     	b.gt	0x4000473c <vfs_init+0x438>
4000472c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004730: 11000508     	add	w8, w8, #0x1
40004734: b904baa8     	str	w8, [x21, #0x4b8]
40004738: f9021d36     	str	x22, [x9, #0x438]
4000473c: 90000037     	adrp	x23, 0x40008000 <__rodata_start+0x1000>
40004740: 91089af7     	add	x23, x23, #0x226
40004744: 9100c2c0     	add	x0, x22, #0x30
40004748: aa1703e1     	mov	x1, x23
4000474c: 97fff853     	bl	0x40002898 <kstrcpy>
40004750: aa1703e0     	mov	x0, x23
40004754: 97fff822     	bl	0x400027dc <kstrlen>
40004758: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000475c: f90016c0     	str	x0, [x22, #0x28]
40004760: 7101fd1f     	cmp	w8, #0x7f
40004764: 5400090c     	b.gt	0x40004884 <vfs_init+0x580>
40004768: 52809809     	mov	w9, #0x4c0              // =1216
4000476c: 2a1f03e1     	mov	w1, wzr
40004770: 52809802     	mov	w2, #0x4c0              // =1216
40004774: 9b294d16     	smaddl	x22, w8, w9, x19
40004778: 11000508     	add	w8, w8, #0x1
4000477c: b90b8b28     	str	w8, [x25, #0xb88]
40004780: aa1603e0     	mov	x0, x22
40004784: 97fff871     	bl	0x40002948 <memset>
40004788: 528d2c28     	mov	w8, #0x6961             // =26977
4000478c: b904badf     	str	wzr, [x22, #0x4b8]
40004790: 528e8f09     	mov	w9, #0x7478             // =29816
40004794: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004798: 79000ac9     	strh	w9, [x22, #0x4]
4000479c: b90002c8     	str	w8, [x22]
400047a0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400047a4: 39001adf     	strb	wzr, [x22, #0x6]
400047a8: 71003d1f     	cmp	w8, #0xf
400047ac: b90022df     	str	wzr, [x22, #0x20]
400047b0: f9021ad5     	str	x21, [x22, #0x430]
400047b4: f90016df     	str	xzr, [x22, #0x28]
400047b8: 540000ac     	b.gt	0x400047cc <vfs_init+0x4c8>
400047bc: 8b080ea9     	add	x9, x21, x8, lsl #3
400047c0: 11000508     	add	w8, w8, #0x1
400047c4: b904baa8     	str	w8, [x21, #0x4b8]
400047c8: f9021d36     	str	x22, [x9, #0x438]
400047cc: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
400047d0: 91057ab5     	add	x21, x21, #0x15e
400047d4: 9100c2c0     	add	x0, x22, #0x30
400047d8: aa1503e1     	mov	x1, x21
400047dc: 97fff82f     	bl	0x40002898 <kstrcpy>
400047e0: aa1503e0     	mov	x0, x21
400047e4: 97fff7fe     	bl	0x400027dc <kstrlen>
400047e8: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047ec: f90016c0     	str	x0, [x22, #0x28]
400047f0: 7101fd1f     	cmp	w8, #0x7f
400047f4: 5400048c     	b.gt	0x40004884 <vfs_init+0x580>
400047f8: 52809809     	mov	w9, #0x4c0              // =1216
400047fc: 2a1f03e1     	mov	w1, wzr
40004800: 52809802     	mov	w2, #0x4c0              // =1216
40004804: 9b294d13     	smaddl	x19, w8, w9, x19
40004808: 11000508     	add	w8, w8, #0x1
4000480c: b90b8b28     	str	w8, [x25, #0xb88]
40004810: aa1303e0     	mov	x0, x19
40004814: 97fff84d     	bl	0x40002948 <memset>
40004818: d28cae48     	mov	x8, #0x6572             // =25970
4000481c: b904ba7f     	str	wzr, [x19, #0x4b8]
40004820: 528e8f09     	mov	w9, #0x7478             // =29816
40004824: f2ac8c28     	movk	x8, #0x6461, lsl #16
40004828: 79001269     	strh	w9, [x19, #0x8]
4000482c: f2ccada8     	movk	x8, #0x656d, lsl #32
40004830: 39002a7f     	strb	wzr, [x19, #0xa]
40004834: f2ee85c8     	movk	x8, #0x742e, lsl #48
40004838: b900227f     	str	wzr, [x19, #0x20]
4000483c: f9000268     	str	x8, [x19]
40004840: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004844: f9021a74     	str	x20, [x19, #0x430]
40004848: 71003d1f     	cmp	w8, #0xf
4000484c: f900167f     	str	xzr, [x19, #0x28]
40004850: 540000ac     	b.gt	0x40004864 <vfs_init+0x560>
40004854: 8b080e89     	add	x9, x20, x8, lsl #3
40004858: 11000508     	add	w8, w8, #0x1
4000485c: b904ba88     	str	w8, [x20, #0x4b8]
40004860: f9021d33     	str	x19, [x9, #0x438]
40004864: f0000014     	adrp	x20, 0x40007000 <__rodata_start>
40004868: 910efa94     	add	x20, x20, #0x3be
4000486c: 9100c260     	add	x0, x19, #0x30
40004870: aa1403e1     	mov	x1, x20
40004874: 97fff809     	bl	0x40002898 <kstrcpy>
40004878: aa1403e0     	mov	x0, x20
4000487c: 97fff7d8     	bl	0x400027dc <kstrlen>
40004880: f9001660     	str	x0, [x19, #0x28]
40004884: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004888: f9400bf9     	ldr	x25, [sp, #0x10]
4000488c: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004890: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004894: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004898: d65f03c0     	ret

000000004000489c <vfs_load_internal>:
4000489c: 2a1f03e0     	mov	w0, wzr
400048a0: d65f03c0     	ret

00000000400048a4 <vfs_get_root>:
400048a4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048a8: f945c900     	ldr	x0, [x8, #0xb90]
400048ac: d65f03c0     	ret

00000000400048b0 <vfs_get_cwd>:
400048b0: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048b4: f945cd00     	ldr	x0, [x8, #0xb98]
400048b8: d65f03c0     	ret

00000000400048bc <vfs_getcwd>:
400048bc: d10343ff     	sub	sp, sp, #0xd0
400048c0: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400048c4: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
400048c8: aa0003f3     	mov	x19, x0
400048cc: f945cd08     	ldr	x8, [x8, #0xb98]
400048d0: a9087bfd     	stp	x29, x30, [sp, #0x80]
400048d4: 910203fd     	add	x29, sp, #0x80
400048d8: a90967fa     	stp	x26, x25, [sp, #0x90]
400048dc: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
400048e0: a90b57f6     	stp	x22, x21, [sp, #0xb0]
400048e4: b4000228     	cbz	x8, 0x40004928 <vfs_getcwd+0x6c>
400048e8: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
400048ec: f945c929     	ldr	x9, [x9, #0xb90]
400048f0: eb09011f     	cmp	x8, x9
400048f4: 540001a0     	b.eq	0x40004928 <vfs_getcwd+0x6c>
400048f8: aa1f03ea     	mov	x10, xzr
400048fc: 910003eb     	mov	x11, sp
40004900: eb09011f     	cmp	x8, x9
40004904: 540001e0     	b.eq	0x40004940 <vfs_getcwd+0x84>
40004908: f1003d5f     	cmp	x10, #0xf
4000490c: 540001a8     	b.hi	0x40004940 <vfs_getcwd+0x84>
40004910: f82a7968     	str	x8, [x11, x10, lsl #3]
40004914: f9421908     	ldr	x8, [x8, #0x430]
40004918: 9100054c     	add	x12, x10, #0x1
4000491c: aa0c03ea     	mov	x10, x12
40004920: b5ffff08     	cbnz	x8, 0x40004900 <vfs_getcwd+0x44>
40004924: 14000008     	b	0x40004944 <vfs_getcwd+0x88>
40004928: f100083f     	cmp	x1, #0x2
4000492c: 54000583     	b.lo	0x400049dc <vfs_getcwd+0x120>
40004930: 528005e8     	mov	w8, #0x2f               // =47
40004934: 3900067f     	strb	wzr, [x19, #0x1]
40004938: 39000268     	strb	w8, [x19]
4000493c: 14000028     	b	0x400049dc <vfs_getcwd+0x120>
40004940: aa0a03ec     	mov	x12, x10
40004944: 7100059f     	cmp	w12, #0x1
40004948: 3900027f     	strb	wzr, [x19]
4000494c: 5400048b     	b.lt	0x400049dc <vfs_getcwd+0x120>
40004950: aa1f03f6     	mov	x22, xzr
40004954: d1000435     	sub	x21, x1, #0x1
40004958: 92407999     	and	x25, x12, #0x7fffffff
4000495c: 528005f7     	mov	w23, #0x2f              // =47
40004960: 910003f8     	mov	x24, sp
40004964: 14000005     	b	0x40004978 <vfs_getcwd+0xbc>
40004968: 8b0a02d6     	add	x22, x22, x10
4000496c: f100075f     	cmp	x26, #0x1
40004970: 38366a7f     	strb	wzr, [x19, x22]
40004974: 54000349     	b.ls	0x400049dc <vfs_getcwd+0x120>
40004978: eb1502df     	cmp	x22, x21
4000497c: aa1903fa     	mov	x26, x25
40004980: 54000082     	b.hs	0x40004990 <vfs_getcwd+0xd4>
40004984: 38366a77     	strb	w23, [x19, x22]
40004988: 910006d6     	add	x22, x22, #0x1
4000498c: 38366a7f     	strb	wzr, [x19, x22]
40004990: d1000759     	sub	x25, x26, #0x1
40004994: f8797b14     	ldr	x20, [x24, x25, lsl #3]
40004998: aa1403e0     	mov	x0, x20
4000499c: 97fff790     	bl	0x400027dc <kstrlen>
400049a0: b4fffe60     	cbz	x0, 0x4000496c <vfs_getcwd+0xb0>
400049a4: eb1502df     	cmp	x22, x21
400049a8: 54fffe22     	b.hs	0x4000496c <vfs_getcwd+0xb0>
400049ac: aa1f03e9     	mov	x9, xzr
400049b0: 8b160268     	add	x8, x19, x22
400049b4: 9100052a     	add	x10, x9, #0x1
400049b8: 38696a8b     	ldrb	w11, [x20, x9]
400049bc: eb00015f     	cmp	x10, x0
400049c0: 3829690b     	strb	w11, [x8, x9]
400049c4: 54fffd22     	b.hs	0x40004968 <vfs_getcwd+0xac>
400049c8: 8b160149     	add	x9, x10, x22
400049cc: eb15013f     	cmp	x9, x21
400049d0: aa0a03e9     	mov	x9, x10
400049d4: 54ffff03     	b.lo	0x400049b4 <vfs_getcwd+0xf8>
400049d8: 17ffffe4     	b	0x40004968 <vfs_getcwd+0xac>
400049dc: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
400049e0: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
400049e4: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
400049e8: a94967fa     	ldp	x26, x25, [sp, #0x90]
400049ec: a9487bfd     	ldp	x29, x30, [sp, #0x80]
400049f0: 910343ff     	add	sp, sp, #0xd0
400049f4: d65f03c0     	ret

00000000400049f8 <vfs_find>:
400049f8: d10203ff     	sub	sp, sp, #0x80
400049fc: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004a00: 910083fd     	add	x29, sp, #0x20
40004a04: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004a08: a90467fa     	stp	x26, x25, [sp, #0x40]
40004a0c: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004a10: a90657f6     	stp	x22, x21, [sp, #0x60]
40004a14: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004a18: b4000a60     	cbz	x0, 0x40004b64 <vfs_find+0x16c>
40004a1c: 39400008     	ldrb	w8, [x0]
40004a20: aa0003f4     	mov	x20, x0
40004a24: 34000a08     	cbz	w8, 0x40004b64 <vfs_find+0x16c>
40004a28: 7100bd1f     	cmp	w8, #0x2f
40004a2c: 54000121     	b.ne	0x40004a50 <vfs_find+0x58>
40004a30: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004a34: 52800037     	mov	w23, #0x1               // =1
40004a38: f945c913     	ldr	x19, [x8, #0xb90]
40004a3c: 38776a88     	ldrb	w8, [x20, x23]
40004a40: 7100bd1f     	cmp	w8, #0x2f
40004a44: 540000e1     	b.ne	0x40004a60 <vfs_find+0x68>
40004a48: 910006f7     	add	x23, x23, #0x1
40004a4c: 17fffffc     	b	0x40004a3c <vfs_find+0x44>
40004a50: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004a54: aa1f03f7     	mov	x23, xzr
40004a58: f945cd33     	ldr	x19, [x9, #0xb98]
40004a5c: 14000002     	b	0x40004a64 <vfs_find+0x6c>
40004a60: 34000848     	cbz	w8, 0x40004b68 <vfs_find+0x170>
40004a64: 91000698     	add	x24, x20, #0x1
40004a68: f0000015     	adrp	x21, 0x40007000 <__rodata_start>
40004a6c: 91249ab5     	add	x21, x21, #0x926
40004a70: 910003f9     	mov	x25, sp
40004a74: 90000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40004a78: 91010ed6     	add	x22, x22, #0x43
40004a7c: 14000006     	b	0x40004a94 <vfs_find+0x9c>
40004a80: f9421a68     	ldr	x8, [x19, #0x430]
40004a84: f100011f     	cmp	x8, #0x0
40004a88: 9a880273     	csel	x19, x19, x8, eq
40004a8c: 385ff348     	ldurb	w8, [x26, #-0x1]
40004a90: 340006c8     	cbz	w8, 0x40004b68 <vfs_find+0x170>
40004a94: 7100bd1f     	cmp	w8, #0x2f
40004a98: 54000061     	b.ne	0x40004aa4 <vfs_find+0xac>
40004a9c: aa1f03e9     	mov	x9, xzr
40004aa0: 14000010     	b	0x40004ae0 <vfs_find+0xe8>
40004aa4: aa1f03e9     	mov	x9, xzr
40004aa8: 8b17030a     	add	x10, x24, x23
40004aac: 34000188     	cbz	w8, 0x40004adc <vfs_find+0xe4>
40004ab0: f100793f     	cmp	x9, #0x1e
40004ab4: 54000148     	b.hi	0x40004adc <vfs_find+0xe4>
40004ab8: 38296b28     	strb	w8, [x25, x9]
40004abc: 38696948     	ldrb	w8, [x10, x9]
40004ac0: 9100052b     	add	x11, x9, #0x1
40004ac4: aa0b03e9     	mov	x9, x11
40004ac8: 7100bd1f     	cmp	w8, #0x2f
40004acc: 54ffff01     	b.ne	0x40004aac <vfs_find+0xb4>
40004ad0: 8b0b02f7     	add	x23, x23, x11
40004ad4: aa0b03e9     	mov	x9, x11
40004ad8: 14000002     	b	0x40004ae0 <vfs_find+0xe8>
40004adc: 8b0902f7     	add	x23, x23, x9
40004ae0: 8b17029a     	add	x26, x20, x23
40004ae4: d10006f7     	sub	x23, x23, #0x1
40004ae8: 38296b3f     	strb	wzr, [x25, x9]
40004aec: 38401748     	ldrb	w8, [x26], #0x1
40004af0: 910006f7     	add	x23, x23, #0x1
40004af4: 7100bd1f     	cmp	w8, #0x2f
40004af8: 54ffffa0     	b.eq	0x40004aec <vfs_find+0xf4>
40004afc: 910003e0     	mov	x0, sp
40004b00: aa1503e1     	mov	x1, x21
40004b04: 97fff746     	bl	0x4000281c <kstrcmp>
40004b08: 34fffc20     	cbz	w0, 0x40004a8c <vfs_find+0x94>
40004b0c: 910003e0     	mov	x0, sp
40004b10: aa1603e1     	mov	x1, x22
40004b14: 97fff742     	bl	0x4000281c <kstrcmp>
40004b18: 34fffb40     	cbz	w0, 0x40004a80 <vfs_find+0x88>
40004b1c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b20: 7100051f     	cmp	w8, #0x1
40004b24: 5400020b     	b.lt	0x40004b64 <vfs_find+0x16c>
40004b28: aa1f03fb     	mov	x27, xzr
40004b2c: 9110e27c     	add	x28, x19, #0x438
40004b30: 14000005     	b	0x40004b44 <vfs_find+0x14c>
40004b34: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b38: 9100077b     	add	x27, x27, #0x1
40004b3c: eb28c37f     	cmp	x27, w8, sxtw
40004b40: 5400012a     	b.ge	0x40004b64 <vfs_find+0x16c>
40004b44: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004b48: b4ffff80     	cbz	x0, 0x40004b38 <vfs_find+0x140>
40004b4c: 910003e1     	mov	x1, sp
40004b50: 97fff733     	bl	0x4000281c <kstrcmp>
40004b54: 35ffff00     	cbnz	w0, 0x40004b34 <vfs_find+0x13c>
40004b58: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004b5c: b5fff993     	cbnz	x19, 0x40004a8c <vfs_find+0x94>
40004b60: 14000002     	b	0x40004b68 <vfs_find+0x170>
40004b64: aa1f03f3     	mov	x19, xzr
40004b68: aa1303e0     	mov	x0, x19
40004b6c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004b70: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004b74: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004b78: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004b7c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004b80: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004b84: 910203ff     	add	sp, sp, #0x80
40004b88: d65f03c0     	ret

0000000040004b8c <vfs_chdir>:
40004b8c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004b90: f9000bf3     	str	x19, [sp, #0x10]
40004b94: 910003fd     	mov	x29, sp
40004b98: b4000200     	cbz	x0, 0x40004bd8 <vfs_chdir+0x4c>
40004b9c: 39400008     	ldrb	w8, [x0]
40004ba0: 340001c8     	cbz	w8, 0x40004bd8 <vfs_chdir+0x4c>
40004ba4: b0000021     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40004ba8: 91033421     	add	x1, x1, #0xcd
40004bac: aa0003f3     	mov	x19, x0
40004bb0: 97fff71b     	bl	0x4000281c <kstrcmp>
40004bb4: 34000120     	cbz	w0, 0x40004bd8 <vfs_chdir+0x4c>
40004bb8: aa1303e0     	mov	x0, x19
40004bbc: 97ffff8f     	bl	0x400049f8 <vfs_find>
40004bc0: b40002c0     	cbz	x0, 0x40004c18 <vfs_chdir+0x8c>
40004bc4: b9402008     	ldr	w8, [x0, #0x20]
40004bc8: 7100051f     	cmp	w8, #0x1
40004bcc: 54000180     	b.eq	0x40004bfc <vfs_chdir+0x70>
40004bd0: 12800028     	mov	w8, #-0x2               // =-2
40004bd4: 1400000d     	b	0x40004c08 <vfs_chdir+0x7c>
40004bd8: f0000000     	adrp	x0, 0x40007000 <__rodata_start>
40004bdc: 913c7400     	add	x0, x0, #0xf1d
40004be0: 97ffff86     	bl	0x400049f8 <vfs_find>
40004be4: b4000080     	cbz	x0, 0x40004bf4 <vfs_chdir+0x68>
40004be8: b9402008     	ldr	w8, [x0, #0x20]
40004bec: 7100051f     	cmp	w8, #0x1
40004bf0: 54000060     	b.eq	0x40004bfc <vfs_chdir+0x70>
40004bf4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004bf8: f945c900     	ldr	x0, [x8, #0xb90]
40004bfc: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004c00: 2a1f03e8     	mov	w8, wzr
40004c04: f905cd20     	str	x0, [x9, #0xb98]
40004c08: f9400bf3     	ldr	x19, [sp, #0x10]
40004c0c: 2a0803e0     	mov	w0, w8
40004c10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004c14: d65f03c0     	ret
40004c18: 12800008     	mov	w8, #-0x1               // =-1
40004c1c: 17fffffb     	b	0x40004c08 <vfs_chdir+0x7c>

0000000040004c20 <vfs_mkdir>:
40004c20: b40001e0     	cbz	x0, 0x40004c5c <vfs_mkdir+0x3c>
40004c24: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004c28: 39400008     	ldrb	w8, [x0]
40004c2c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004c30: aa0003f3     	mov	x19, x0
40004c34: a90157f6     	stp	x22, x21, [sp, #0x10]
40004c38: 910003fd     	mov	x29, sp
40004c3c: 34000148     	cbz	w8, 0x40004c64 <vfs_mkdir+0x44>
40004c40: f0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
40004c44: f945ce95     	ldr	x21, [x20, #0xb98]
40004c48: b944baa8     	ldr	w8, [x21, #0x4b8]
40004c4c: 71003d1f     	cmp	w8, #0xf
40004c50: 540000ed     	b.le	0x40004c6c <vfs_mkdir+0x4c>
40004c54: 12800020     	mov	w0, #-0x2               // =-2
40004c58: 14000043     	b	0x40004d64 <vfs_mkdir+0x144>
40004c5c: 12800000     	mov	w0, #-0x1               // =-1
40004c60: d65f03c0     	ret
40004c64: 12800000     	mov	w0, #-0x1               // =-1
40004c68: 1400003f     	b	0x40004d64 <vfs_mkdir+0x144>
40004c6c: 7100051f     	cmp	w8, #0x1
40004c70: 540001eb     	b.lt	0x40004cac <vfs_mkdir+0x8c>
40004c74: aa1f03f6     	mov	x22, xzr
40004c78: 14000005     	b	0x40004c8c <vfs_mkdir+0x6c>
40004c7c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004c80: 910006d6     	add	x22, x22, #0x1
40004c84: eb0802df     	cmp	x22, x8
40004c88: 5400012a     	b.ge	0x40004cac <vfs_mkdir+0x8c>
40004c8c: 8b160ea8     	add	x8, x21, x22, lsl #3
40004c90: f9421d00     	ldr	x0, [x8, #0x438]
40004c94: b4ffff40     	cbz	x0, 0x40004c7c <vfs_mkdir+0x5c>
40004c98: aa1303e1     	mov	x1, x19
40004c9c: 97fff6e0     	bl	0x4000281c <kstrcmp>
40004ca0: 340003e0     	cbz	w0, 0x40004d1c <vfs_mkdir+0xfc>
40004ca4: f945ce95     	ldr	x21, [x20, #0xb98]
40004ca8: 17fffff5     	b	0x40004c7c <vfs_mkdir+0x5c>
40004cac: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004cb0: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004cb4: 7101fd3f     	cmp	w9, #0x7f
40004cb8: 5400006d     	b.le	0x40004cc4 <vfs_mkdir+0xa4>
40004cbc: 12800060     	mov	w0, #-0x4               // =-4
40004cc0: 14000029     	b	0x40004d64 <vfs_mkdir+0x144>
40004cc4: 5280980a     	mov	w10, #0x4c0             // =1216
40004cc8: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004ccc: 912e816b     	add	x11, x11, #0xba0
40004cd0: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004cd4: 11000529     	add	w9, w9, #0x1
40004cd8: 2a1f03e1     	mov	w1, wzr
40004cdc: 52809802     	mov	w2, #0x4c0              // =1216
40004ce0: b90b8909     	str	w9, [x8, #0xb88]
40004ce4: aa1403e0     	mov	x0, x20
40004ce8: 97fff718     	bl	0x40002948 <memset>
40004cec: 39400268     	ldrb	w8, [x19]
40004cf0: 340001a8     	cbz	w8, 0x40004d24 <vfs_mkdir+0x104>
40004cf4: aa1f03ea     	mov	x10, xzr
40004cf8: 91000669     	add	x9, x19, #0x1
40004cfc: 382a6a88     	strb	w8, [x20, x10]
40004d00: 9100054b     	add	x11, x10, #0x1
40004d04: 386a6928     	ldrb	w8, [x9, x10]
40004d08: 34000108     	cbz	w8, 0x40004d28 <vfs_mkdir+0x108>
40004d0c: f100795f     	cmp	x10, #0x1e
40004d10: aa0b03ea     	mov	x10, x11
40004d14: 54ffff43     	b.lo	0x40004cfc <vfs_mkdir+0xdc>
40004d18: 14000004     	b	0x40004d28 <vfs_mkdir+0x108>
40004d1c: 12800040     	mov	w0, #-0x3               // =-3
40004d20: 14000011     	b	0x40004d64 <vfs_mkdir+0x144>
40004d24: aa1f03eb     	mov	x11, xzr
40004d28: 382b6a9f     	strb	wzr, [x20, x11]
40004d2c: 2a1f03e0     	mov	w0, wzr
40004d30: 52800029     	mov	w9, #0x1                // =1
40004d34: b904ba9f     	str	wzr, [x20, #0x4b8]
40004d38: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004d3c: b9002289     	str	w9, [x20, #0x20]
40004d40: f9021a95     	str	x21, [x20, #0x430]
40004d44: 71003d1f     	cmp	w8, #0xf
40004d48: f900169f     	str	xzr, [x20, #0x28]
40004d4c: 540000cc     	b.gt	0x40004d64 <vfs_mkdir+0x144>
40004d50: 8b080ea9     	add	x9, x21, x8, lsl #3
40004d54: 2a1f03e0     	mov	w0, wzr
40004d58: 11000508     	add	w8, w8, #0x1
40004d5c: b904baa8     	str	w8, [x21, #0x4b8]
40004d60: f9021d34     	str	x20, [x9, #0x438]
40004d64: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004d68: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004d6c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004d70: d65f03c0     	ret

0000000040004d74 <vfs_sync>:
40004d74: d65f03c0     	ret

0000000040004d78 <vfs_touch>:
40004d78: b4000500     	cbz	x0, 0x40004e18 <vfs_touch+0xa0>
40004d7c: 39400008     	ldrb	w8, [x0]
40004d80: 340004c8     	cbz	w8, 0x40004e18 <vfs_touch+0xa0>
40004d84: d10583ff     	sub	sp, sp, #0x160
40004d88: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3478>
40004d8c: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004d90: aa1f03f4     	mov	x20, xzr
40004d94: f945cd33     	ldr	x19, [x9, #0xb98]
40004d98: aa0003e9     	mov	x9, x0
40004d9c: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004da0: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004da4: 910483fd     	add	x29, sp, #0x120
40004da8: a91457f6     	stp	x22, x21, [sp, #0x140]
40004dac: 14000003     	b	0x40004db8 <vfs_touch+0x40>
40004db0: aa0903f4     	mov	x20, x9
40004db4: 38401d28     	ldrb	w8, [x9, #0x1]!
40004db8: 7100bd1f     	cmp	w8, #0x2f
40004dbc: 54ffffa0     	b.eq	0x40004db0 <vfs_touch+0x38>
40004dc0: 35ffffa8     	cbnz	w8, 0x40004db4 <vfs_touch+0x3c>
40004dc4: b4000334     	cbz	x20, 0x40004e28 <vfs_touch+0xb0>
40004dc8: cb000288     	sub	x8, x20, x0
40004dcc: 52801fe9     	mov	w9, #0xff               // =255
40004dd0: aa0103f5     	mov	x21, x1
40004dd4: f103fd1f     	cmp	x8, #0xff
40004dd8: aa0003e1     	mov	x1, x0
40004ddc: 910083e0     	add	x0, sp, #0x20
40004de0: 9a893113     	csel	x19, x8, x9, lo
40004de4: 910083f6     	add	x22, sp, #0x20
40004de8: aa1303e2     	mov	x2, x19
40004dec: 97fff6b2     	bl	0x400028b4 <kstrncpy>
40004df0: 910083e0     	add	x0, sp, #0x20
40004df4: 38336adf     	strb	wzr, [x22, x19]
40004df8: 97ffff00     	bl	0x400049f8 <vfs_find>
40004dfc: b4000120     	cbz	x0, 0x40004e20 <vfs_touch+0xa8>
40004e00: b9402008     	ldr	w8, [x0, #0x20]
40004e04: aa0003f3     	mov	x19, x0
40004e08: 7100051f     	cmp	w8, #0x1
40004e0c: 540000a1     	b.ne	0x40004e20 <vfs_touch+0xa8>
40004e10: 91000688     	add	x8, x20, #0x1
40004e14: 14000007     	b	0x40004e30 <vfs_touch+0xb8>
40004e18: 12800000     	mov	w0, #-0x1               // =-1
40004e1c: d65f03c0     	ret
40004e20: 12800000     	mov	w0, #-0x1               // =-1
40004e24: 1400006a     	b	0x40004fcc <vfs_touch+0x254>
40004e28: aa0003e8     	mov	x8, x0
40004e2c: aa0103f5     	mov	x21, x1
40004e30: 910003e0     	mov	x0, sp
40004e34: aa0803e1     	mov	x1, x8
40004e38: 528003e2     	mov	w2, #0x1f               // =31
40004e3c: 97fff69e     	bl	0x400028b4 <kstrncpy>
40004e40: b944ba68     	ldr	w8, [x19, #0x4b8]
40004e44: 39007fff     	strb	wzr, [sp, #0x1f]
40004e48: 7100051f     	cmp	w8, #0x1
40004e4c: 5400024b     	b.lt	0x40004e94 <vfs_touch+0x11c>
40004e50: aa1f03f6     	mov	x22, xzr
40004e54: 9110e277     	add	x23, x19, #0x438
40004e58: 14000004     	b	0x40004e68 <vfs_touch+0xf0>
40004e5c: 910006d6     	add	x22, x22, #0x1
40004e60: eb28c2df     	cmp	x22, w8, sxtw
40004e64: 5400010a     	b.ge	0x40004e84 <vfs_touch+0x10c>
40004e68: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004e6c: b4ffff80     	cbz	x0, 0x40004e5c <vfs_touch+0xe4>
40004e70: 910003e1     	mov	x1, sp
40004e74: 97fff66a     	bl	0x4000281c <kstrcmp>
40004e78: 340004a0     	cbz	w0, 0x40004f0c <vfs_touch+0x194>
40004e7c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004e80: 17fffff7     	b	0x40004e5c <vfs_touch+0xe4>
40004e84: 71003d1f     	cmp	w8, #0xf
40004e88: 5400006d     	b.le	0x40004e94 <vfs_touch+0x11c>
40004e8c: 12800020     	mov	w0, #-0x2               // =-2
40004e90: 1400004f     	b	0x40004fcc <vfs_touch+0x254>
40004e94: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
40004e98: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004e9c: 7101fd3f     	cmp	w9, #0x7f
40004ea0: 5400006d     	b.le	0x40004eac <vfs_touch+0x134>
40004ea4: 12800060     	mov	w0, #-0x4               // =-4
40004ea8: 14000049     	b	0x40004fcc <vfs_touch+0x254>
40004eac: 5280980a     	mov	w10, #0x4c0             // =1216
40004eb0: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3478>
40004eb4: 912e816b     	add	x11, x11, #0xba0
40004eb8: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004ebc: 11000529     	add	w9, w9, #0x1
40004ec0: 2a1f03e1     	mov	w1, wzr
40004ec4: 52809802     	mov	w2, #0x4c0              // =1216
40004ec8: b90b8909     	str	w9, [x8, #0xb88]
40004ecc: aa1403e0     	mov	x0, x20
40004ed0: 97fff69e     	bl	0x40002948 <memset>
40004ed4: 394003e8     	ldrb	w8, [sp]
40004ed8: 340003e8     	cbz	w8, 0x40004f54 <vfs_touch+0x1dc>
40004edc: 910003ea     	mov	x10, sp
40004ee0: aa1f03e9     	mov	x9, xzr
40004ee4: aa1503e0     	mov	x0, x21
40004ee8: b240014a     	orr	x10, x10, #0x1
40004eec: 38296a88     	strb	w8, [x20, x9]
40004ef0: 38696948     	ldrb	w8, [x10, x9]
40004ef4: 9100052b     	add	x11, x9, #0x1
40004ef8: 34000328     	cbz	w8, 0x40004f5c <vfs_touch+0x1e4>
40004efc: f100793f     	cmp	x9, #0x1e
40004f00: aa0b03e9     	mov	x9, x11
40004f04: 54ffff43     	b.lo	0x40004eec <vfs_touch+0x174>
40004f08: 14000015     	b	0x40004f5c <vfs_touch+0x1e4>
40004f0c: b40005f5     	cbz	x21, 0x40004fc8 <vfs_touch+0x250>
40004f10: aa1503e0     	mov	x0, x21
40004f14: 97fff632     	bl	0x400027dc <kstrlen>
40004f18: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f1c: f10ffc1f     	cmp	x0, #0x3ff
40004f20: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f24: 9a883014     	csel	x20, x0, x8, lo
40004f28: aa1503e1     	mov	x1, x21
40004f2c: 9100c120     	add	x0, x9, #0x30
40004f30: aa1403e2     	mov	x2, x20
40004f34: 97fff69b     	bl	0x400029a0 <memcpy>
40004f38: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f3c: 2a1f03e0     	mov	w0, wzr
40004f40: 8b140108     	add	x8, x8, x20
40004f44: 3900c11f     	strb	wzr, [x8, #0x30]
40004f48: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004f4c: f9001514     	str	x20, [x8, #0x28]
40004f50: 1400001f     	b	0x40004fcc <vfs_touch+0x254>
40004f54: aa1f03eb     	mov	x11, xzr
40004f58: aa1503e0     	mov	x0, x21
40004f5c: 382b6a9f     	strb	wzr, [x20, x11]
40004f60: b904ba9f     	str	wzr, [x20, #0x4b8]
40004f64: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004f68: b900229f     	str	wzr, [x20, #0x20]
40004f6c: f9021a93     	str	x19, [x20, #0x430]
40004f70: 71003d1f     	cmp	w8, #0xf
40004f74: f900169f     	str	xzr, [x20, #0x28]
40004f78: 540000ac     	b.gt	0x40004f8c <vfs_touch+0x214>
40004f7c: 8b080e69     	add	x9, x19, x8, lsl #3
40004f80: 11000508     	add	w8, w8, #0x1
40004f84: b904ba68     	str	w8, [x19, #0x4b8]
40004f88: f9021d34     	str	x20, [x9, #0x438]
40004f8c: b4000200     	cbz	x0, 0x40004fcc <vfs_touch+0x254>
40004f90: aa0003f3     	mov	x19, x0
40004f94: 97fff612     	bl	0x400027dc <kstrlen>
40004f98: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f9c: f10ffc1f     	cmp	x0, #0x3ff
40004fa0: 9100c296     	add	x22, x20, #0x30
40004fa4: 9a883015     	csel	x21, x0, x8, lo
40004fa8: aa1603e0     	mov	x0, x22
40004fac: aa1303e1     	mov	x1, x19
40004fb0: aa1503e2     	mov	x2, x21
40004fb4: 97fff67b     	bl	0x400029a0 <memcpy>
40004fb8: 2a1f03e0     	mov	w0, wzr
40004fbc: 38356adf     	strb	wzr, [x22, x21]
40004fc0: f9001695     	str	x21, [x20, #0x28]
40004fc4: 14000002     	b	0x40004fcc <vfs_touch+0x254>
40004fc8: 2a1f03e0     	mov	w0, wzr
40004fcc: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40004fd0: a95457f6     	ldp	x22, x21, [sp, #0x140]
40004fd4: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40004fd8: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40004fdc: 910583ff     	add	sp, sp, #0x160
40004fe0: d65f03c0     	ret

0000000040004fe4 <vfs_write_file>:
40004fe4: 17ffff65     	b	0x40004d78 <vfs_touch>

0000000040004fe8 <vfs_remove>:
40004fe8: b40005c0     	cbz	x0, 0x400050a0 <vfs_remove+0xb8>
40004fec: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004ff0: 39400008     	ldrb	w8, [x0]
40004ff4: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004ff8: aa0003f3     	mov	x19, x0
40004ffc: f9000bf5     	str	x21, [sp, #0x10]
40005000: 910003fd     	mov	x29, sp
40005004: 34000448     	cbz	w8, 0x4000508c <vfs_remove+0xa4>
40005008: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3478>
4000500c: f945ce88     	ldr	x8, [x20, #0xb98]
40005010: b944b909     	ldr	w9, [x8, #0x4b8]
40005014: 7100053f     	cmp	w9, #0x1
40005018: 540003ab     	b.lt	0x4000508c <vfs_remove+0xa4>
4000501c: aa1f03f5     	mov	x21, xzr
40005020: 14000005     	b	0x40005034 <vfs_remove+0x4c>
40005024: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005028: 910006b5     	add	x21, x21, #0x1
4000502c: eb0902bf     	cmp	x21, x9
40005030: 540002ea     	b.ge	0x4000508c <vfs_remove+0xa4>
40005034: 8b150d09     	add	x9, x8, x21, lsl #3
40005038: f9421d20     	ldr	x0, [x9, #0x438]
4000503c: b4ffff40     	cbz	x0, 0x40005024 <vfs_remove+0x3c>
40005040: aa1303e1     	mov	x1, x19
40005044: 97fff5f6     	bl	0x4000281c <kstrcmp>
40005048: f945ce88     	ldr	x8, [x20, #0xb98]
4000504c: 35fffec0     	cbnz	w0, 0x40005024 <vfs_remove+0x3c>
40005050: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005054: d1000529     	sub	x9, x9, #0x1
40005058: 6b15013f     	cmp	w9, w21
4000505c: 5400026d     	b.le	0x400050a8 <vfs_remove+0xc0>
40005060: f945ce8a     	ldr	x10, [x20, #0xb98]
40005064: b984b949     	ldrsw	x9, [x10, #0x4b8]
40005068: d1000529     	sub	x9, x9, #0x1
4000506c: 8b150d08     	add	x8, x8, x21, lsl #3
40005070: 910006b5     	add	x21, x21, #0x1
40005074: eb0902bf     	cmp	x21, x9
40005078: f942210b     	ldr	x11, [x8, #0x440]
4000507c: f9021d0b     	str	x11, [x8, #0x438]
40005080: aa0a03e8     	mov	x8, x10
40005084: 54ffff4b     	b.lt	0x4000506c <vfs_remove+0x84>
40005088: 14000009     	b	0x400050ac <vfs_remove+0xc4>
4000508c: 12800000     	mov	w0, #-0x1               // =-1
40005090: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005094: f9400bf5     	ldr	x21, [sp, #0x10]
40005098: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000509c: d65f03c0     	ret
400050a0: 12800000     	mov	w0, #-0x1               // =-1
400050a4: d65f03c0     	ret
400050a8: aa0803ea     	mov	x10, x8
400050ac: 8b090d48     	add	x8, x10, x9, lsl #3
400050b0: 2a1f03e0     	mov	w0, wzr
400050b4: f9021d1f     	str	xzr, [x8, #0x438]
400050b8: f945ce88     	ldr	x8, [x20, #0xb98]
400050bc: b944b909     	ldr	w9, [x8, #0x4b8]
400050c0: 51000529     	sub	w9, w9, #0x1
400050c4: b904b909     	str	w9, [x8, #0x4b8]
400050c8: 17fffff2     	b	0x40005090 <vfs_remove+0xa8>

00000000400050cc <vfs_list_dir>:
400050cc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400050d0: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3478>
400050d4: f100001f     	cmp	x0, #0x0
400050d8: a90257f6     	stp	x22, x21, [sp, #0x20]
400050dc: f945cd08     	ldr	x8, [x8, #0xb98]
400050e0: f9000bf7     	str	x23, [sp, #0x10]
400050e4: 910003fd     	mov	x29, sp
400050e8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400050ec: 9a800115     	csel	x21, x8, x0, eq
400050f0: b94022a8     	ldr	w8, [x21, #0x20]
400050f4: 7100051f     	cmp	w8, #0x1
400050f8: 54000521     	b.ne	0x4000519c <vfs_list_dir+0xd0>
400050fc: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005100: 91363400     	add	x0, x0, #0xd8d
40005104: 97fff95f     	bl	0x40003680 <uart_puts>
40005108: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
4000510c: 91208c00     	add	x0, x0, #0x823
40005110: 97fff95c     	bl	0x40003680 <uart_puts>
40005114: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40005118: 9131b000     	add	x0, x0, #0xc6c
4000511c: 97fff959     	bl	0x40003680 <uart_puts>
40005120: f9421aa8     	ldr	x8, [x21, #0x430]
40005124: b4000088     	cbz	x8, 0x40005134 <vfs_list_dir+0x68>
40005128: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000512c: 910a1000     	add	x0, x0, #0x284
40005130: 97fff954     	bl	0x40003680 <uart_puts>
40005134: b944baa1     	ldr	w1, [x21, #0x4b8]
40005138: 7100043f     	cmp	w1, #0x1
4000513c: 5400034b     	b.lt	0x400051a4 <vfs_list_dir+0xd8>
40005140: aa1f03f6     	mov	x22, xzr
40005144: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
40005148: 91278e73     	add	x19, x19, #0x9e3
4000514c: 9110e2b7     	add	x23, x21, #0x438
40005150: f0000014     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40005154: 9116c694     	add	x20, x20, #0x5b1
40005158: 14000008     	b	0x40005178 <vfs_list_dir+0xac>
4000515c: b9402841     	ldr	w1, [x2, #0x28]
40005160: aa1403e0     	mov	x0, x20
40005164: 97fffa5c     	bl	0x40003ad4 <uart_printf>
40005168: b984baa1     	ldrsw	x1, [x21, #0x4b8]
4000516c: 910006d6     	add	x22, x22, #0x1
40005170: eb0102df     	cmp	x22, x1
40005174: 5400018a     	b.ge	0x400051a4 <vfs_list_dir+0xd8>
40005178: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
4000517c: b4ffff62     	cbz	x2, 0x40005168 <vfs_list_dir+0x9c>
40005180: b9402048     	ldr	w8, [x2, #0x20]
40005184: 7100051f     	cmp	w8, #0x1
40005188: 54fffea1     	b.ne	0x4000515c <vfs_list_dir+0x90>
4000518c: aa1303e0     	mov	x0, x19
40005190: aa0203e1     	mov	x1, x2
40005194: 97fffa50     	bl	0x40003ad4 <uart_printf>
40005198: 17fffff4     	b	0x40005168 <vfs_list_dir+0x9c>
4000519c: 12800000     	mov	w0, #-0x1               // =-1
400051a0: 14000005     	b	0x400051b4 <vfs_list_dir+0xe8>
400051a4: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
400051a8: 9125d400     	add	x0, x0, #0x975
400051ac: 97fffa4a     	bl	0x40003ad4 <uart_printf>
400051b0: 2a1f03e0     	mov	w0, wzr
400051b4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400051b8: f9400bf7     	ldr	x23, [sp, #0x10]
400051bc: a94257f6     	ldp	x22, x21, [sp, #0x20]
400051c0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400051c4: d65f03c0     	ret

00000000400051c8 <vfs_load>:
400051c8: d65f03c0     	ret
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
40005880: 1400020b     	b	0x400060ac <handle_irq_invalid>
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
40005900: 1400020f     	b	0x4000613c <handle_fiq_invalid>
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
40005980: 14000213     	b	0x400061cc <handle_serror_invalid>
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
40005a00: 14000219     	b	0x40006264 <handle_sync_exception_asm>
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
40005a80: 14000166     	b	0x40006018 <handle_irq_exception_asm>
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
40005b00: 1400018f     	b	0x4000613c <handle_fiq_invalid>
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
40005b80: 14000193     	b	0x400061cc <handle_serror_invalid>
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
40005c80: 1400010b     	b	0x400060ac <handle_irq_invalid>
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
40005d00: 1400010f     	b	0x4000613c <handle_fiq_invalid>
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
40005d80: 14000113     	b	0x400061cc <handle_serror_invalid>
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
40005e80: 1400008b     	b	0x400060ac <handle_irq_invalid>
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
40005f00: 1400008f     	b	0x4000613c <handle_fiq_invalid>
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
40005f80: 14000093     	b	0x400061cc <handle_serror_invalid>

0000000040005f84 <handle_sync_invalid>:
40005f84: d10403ff     	sub	sp, sp, #0x100
40005f88: a90007e0     	stp	x0, x1, [sp]
40005f8c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40005f90: a90217e4     	stp	x4, x5, [sp, #0x20]
40005f94: a9031fe6     	stp	x6, x7, [sp, #0x30]
40005f98: a90427e8     	stp	x8, x9, [sp, #0x40]
40005f9c: a9052fea     	stp	x10, x11, [sp, #0x50]
40005fa0: a90637ec     	stp	x12, x13, [sp, #0x60]
40005fa4: a9073fee     	stp	x14, x15, [sp, #0x70]
40005fa8: a90847f0     	stp	x16, x17, [sp, #0x80]
40005fac: a9094ff2     	stp	x18, x19, [sp, #0x90]
40005fb0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005fb4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40005fb8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40005fbc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40005fc0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005fc4: f9007bfe     	str	x30, [sp, #0xf0]
40005fc8: 910003e0     	mov	x0, sp
40005fcc: 97ffe856     	bl	0x40000124 <c_handle_sync_invalid>
40005fd0: a94007e0     	ldp	x0, x1, [sp]
40005fd4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005fd8: a94217e4     	ldp	x4, x5, [sp, #0x20]
40005fdc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005fe0: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005fe4: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005fe8: a94637ec     	ldp	x12, x13, [sp, #0x60]
40005fec: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005ff0: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005ff4: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005ff8: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40005ffc: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006000: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006004: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006008: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000600c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006010: 910403ff     	add	sp, sp, #0x100
40006014: d69f03e0     	eret

0000000040006018 <handle_irq_exception_asm>:
40006018: d10403ff     	sub	sp, sp, #0x100
4000601c: a90007e0     	stp	x0, x1, [sp]
40006020: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006024: a90217e4     	stp	x4, x5, [sp, #0x20]
40006028: a9031fe6     	stp	x6, x7, [sp, #0x30]
4000602c: a90427e8     	stp	x8, x9, [sp, #0x40]
40006030: a9052fea     	stp	x10, x11, [sp, #0x50]
40006034: a90637ec     	stp	x12, x13, [sp, #0x60]
40006038: a9073fee     	stp	x14, x15, [sp, #0x70]
4000603c: a90847f0     	stp	x16, x17, [sp, #0x80]
40006040: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006044: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006048: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
4000604c: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006050: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006054: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006058: f9007bfe     	str	x30, [sp, #0xf0]
4000605c: 910003e0     	mov	x0, sp
40006060: 97ffe851     	bl	0x400001a4 <handle_irq_exception>
40006064: a94007e0     	ldp	x0, x1, [sp]
40006068: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000606c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006070: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006074: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006078: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000607c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006080: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006084: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006088: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000608c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006090: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006094: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006098: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000609c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400060a0: f9407bfe     	ldr	x30, [sp, #0xf0]
400060a4: 910403ff     	add	sp, sp, #0x100
400060a8: d69f03e0     	eret

00000000400060ac <handle_irq_invalid>:
400060ac: d10403ff     	sub	sp, sp, #0x100
400060b0: a90007e0     	stp	x0, x1, [sp]
400060b4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400060b8: a90217e4     	stp	x4, x5, [sp, #0x20]
400060bc: a9031fe6     	stp	x6, x7, [sp, #0x30]
400060c0: a90427e8     	stp	x8, x9, [sp, #0x40]
400060c4: a9052fea     	stp	x10, x11, [sp, #0x50]
400060c8: a90637ec     	stp	x12, x13, [sp, #0x60]
400060cc: a9073fee     	stp	x14, x15, [sp, #0x70]
400060d0: a90847f0     	stp	x16, x17, [sp, #0x80]
400060d4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400060d8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400060dc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400060e0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400060e4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400060e8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400060ec: f9007bfe     	str	x30, [sp, #0xf0]
400060f0: 97ffe81b     	bl	0x4000015c <c_handle_irq_invalid>
400060f4: a94007e0     	ldp	x0, x1, [sp]
400060f8: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400060fc: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006100: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006104: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006108: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000610c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006110: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006114: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006118: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000611c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006120: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006124: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006128: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000612c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006130: f9407bfe     	ldr	x30, [sp, #0xf0]
40006134: 910403ff     	add	sp, sp, #0x100
40006138: d69f03e0     	eret

000000004000613c <handle_fiq_invalid>:
4000613c: d10403ff     	sub	sp, sp, #0x100
40006140: a90007e0     	stp	x0, x1, [sp]
40006144: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006148: a90217e4     	stp	x4, x5, [sp, #0x20]
4000614c: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006150: a90427e8     	stp	x8, x9, [sp, #0x40]
40006154: a9052fea     	stp	x10, x11, [sp, #0x50]
40006158: a90637ec     	stp	x12, x13, [sp, #0x60]
4000615c: a9073fee     	stp	x14, x15, [sp, #0x70]
40006160: a90847f0     	stp	x16, x17, [sp, #0x80]
40006164: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006168: a90a57f4     	stp	x20, x21, [sp, #0xa0]
4000616c: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006170: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006174: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006178: a90e77fc     	stp	x28, x29, [sp, #0xe0]
4000617c: f9007bfe     	str	x30, [sp, #0xf0]
40006180: 97ffe7fd     	bl	0x40000174 <c_handle_fiq_invalid>
40006184: a94007e0     	ldp	x0, x1, [sp]
40006188: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000618c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006190: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006194: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006198: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000619c: a94637ec     	ldp	x12, x13, [sp, #0x60]
400061a0: a9473fee     	ldp	x14, x15, [sp, #0x70]
400061a4: a94847f0     	ldp	x16, x17, [sp, #0x80]
400061a8: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400061ac: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400061b0: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400061b4: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400061b8: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400061bc: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400061c0: f9407bfe     	ldr	x30, [sp, #0xf0]
400061c4: 910403ff     	add	sp, sp, #0x100
400061c8: d69f03e0     	eret

00000000400061cc <handle_serror_invalid>:
400061cc: d10403ff     	sub	sp, sp, #0x100
400061d0: a90007e0     	stp	x0, x1, [sp]
400061d4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400061d8: a90217e4     	stp	x4, x5, [sp, #0x20]
400061dc: a9031fe6     	stp	x6, x7, [sp, #0x30]
400061e0: a90427e8     	stp	x8, x9, [sp, #0x40]
400061e4: a9052fea     	stp	x10, x11, [sp, #0x50]
400061e8: a90637ec     	stp	x12, x13, [sp, #0x60]
400061ec: a9073fee     	stp	x14, x15, [sp, #0x70]
400061f0: a90847f0     	stp	x16, x17, [sp, #0x80]
400061f4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400061f8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400061fc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006200: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006204: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006208: a90e77fc     	stp	x28, x29, [sp, #0xe0]
4000620c: f9007bfe     	str	x30, [sp, #0xf0]
40006210: 97ffe7df     	bl	0x4000018c <c_handle_serror_invalid>
40006214: a94007e0     	ldp	x0, x1, [sp]
40006218: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000621c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40006220: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006224: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006228: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000622c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40006230: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006234: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006238: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000623c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40006240: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006244: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006248: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000624c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40006250: f9407bfe     	ldr	x30, [sp, #0xf0]
40006254: 910403ff     	add	sp, sp, #0x100
40006258: d69f03e0     	eret

000000004000625c <trigger_undefined_instruction>:
4000625c: 00000000     	udf	#0x0
40006260: d65f03c0     	ret

0000000040006264 <handle_sync_exception_asm>:
40006264: d10403ff     	sub	sp, sp, #0x100
40006268: a90007e0     	stp	x0, x1, [sp]
4000626c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006270: a90217e4     	stp	x4, x5, [sp, #0x20]
40006274: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006278: a90427e8     	stp	x8, x9, [sp, #0x40]
4000627c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006280: a90637ec     	stp	x12, x13, [sp, #0x60]
40006284: a9073fee     	stp	x14, x15, [sp, #0x70]
40006288: a90847f0     	stp	x16, x17, [sp, #0x80]
4000628c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006290: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006294: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006298: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000629c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400062a0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400062a4: f9007bfe     	str	x30, [sp, #0xf0]
400062a8: 910003e0     	mov	x0, sp
400062ac: 97ffe76d     	bl	0x40000060 <handle_sync_exception>
400062b0: a94007e0     	ldp	x0, x1, [sp]
400062b4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400062b8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400062bc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400062c0: a94427e8     	ldp	x8, x9, [sp, #0x40]
400062c4: a9452fea     	ldp	x10, x11, [sp, #0x50]
400062c8: a94637ec     	ldp	x12, x13, [sp, #0x60]
400062cc: a9473fee     	ldp	x14, x15, [sp, #0x70]
400062d0: a94847f0     	ldp	x16, x17, [sp, #0x80]
400062d4: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400062d8: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400062dc: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400062e0: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400062e4: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400062e8: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400062ec: f9407bfe     	ldr	x30, [sp, #0xf0]
400062f0: 910403ff     	add	sp, sp, #0x100
400062f4: d69f03e0     	eret
