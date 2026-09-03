
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
40000048: b0 ab 04 40  	.word	0x4004abb0
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 b0 00 40  	.word	0x4000b000
40000054: 00 00 00 00  	.word	0x00000000
40000058: b0 ab 03 40  	.word	0x4003abb0
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: d503201f     	nop
40000068: 50042800     	adr	x0, 0x4000856a <__rodata_start+0x156a>
4000006c: f9000bf5     	str	x21, [sp, #0x10]
40000070: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000074: 910003fd     	mov	x29, sp
40000078: d5385214     	mrs	x20, ESR_EL1
4000007c: d5384033     	mrs	x19, ELR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000e21     	bl	0x40003908 <uart_puts>
40000088: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000008c: 9136b800     	add	x0, x0, #0xdae
40000090: aa1403e1     	mov	x1, x20
40000094: 94000f32     	bl	0x40003d5c <uart_printf>
40000098: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000009c: 913f0400     	add	x0, x0, #0xfc1
400000a0: aa1303e1     	mov	x1, x19
400000a4: 94000f2e     	bl	0x40003d5c <uart_printf>
400000a8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000ac: 91114c00     	add	x0, x0, #0x453
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000f2a     	bl	0x40003d5c <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400000c0: 91180800     	add	x0, x0, #0x602
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000f25     	bl	0x40003d5c <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000f0: 910e9c00     	add	x0, x0, #0x3a7
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000fc: 912c9c00     	add	x0, x0, #0xb27
40000100: 94000e02     	bl	0x40003908 <uart_puts>
40000104: 91001268     	add	x8, x19, #0x4
40000108: d5184028     	msr	ELR_EL1, x8
4000010c: f9400bf5     	ldr	x21, [sp, #0x10]
40000110: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40000114: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000118: 9103a400     	add	x0, x0, #0xe9
4000011c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40000120: 14000dfa     	b	0x40003908 <uart_puts>

0000000040000124 <c_handle_sync_invalid>:
40000124: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000128: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000012c: 91392c00     	add	x0, x0, #0xe4b
40000130: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000134: 910003fd     	mov	x29, sp
40000138: d5385213     	mrs	x19, ESR_EL1
4000013c: d5384034     	mrs	x20, ELR_EL1
40000140: 94000f07     	bl	0x40003d5c <uart_printf>
40000144: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000148: 912afc00     	add	x0, x0, #0xabf
4000014c: aa1303e1     	mov	x1, x19
40000150: aa1403e2     	mov	x2, x20
40000154: 94000f02     	bl	0x40003d5c <uart_printf>
40000158: 14000000     	b	0x40000158 <c_handle_sync_invalid+0x34>

000000004000015c <c_handle_irq_invalid>:
4000015c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000160: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000164: 9136fc00     	add	x0, x0, #0xdbf
40000168: 910003fd     	mov	x29, sp
4000016c: 94000de7     	bl	0x40003908 <uart_puts>
40000170: 14000000     	b	0x40000170 <c_handle_irq_invalid+0x14>

0000000040000174 <c_handle_fiq_invalid>:
40000174: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000178: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000017c: 912d0400     	add	x0, x0, #0xb41
40000180: 910003fd     	mov	x29, sp
40000184: 94000de1     	bl	0x40003908 <uart_puts>
40000188: 14000000     	b	0x40000188 <c_handle_fiq_invalid+0x14>

000000004000018c <c_handle_serror_invalid>:
4000018c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000190: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000194: 91097800     	add	x0, x0, #0x25e
40000198: 910003fd     	mov	x29, sp
4000019c: 94000ddb     	bl	0x40003908 <uart_puts>
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
400001c8: 94000aec     	bl	0x40002d78 <timer_handle_interrupt>
400001cc: 14000005     	b	0x400001e0 <handle_irq_exception+0x3c>
400001d0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400001d4: 910e6800     	add	x0, x0, #0x39a
400001d8: 2a1303e1     	mov	w1, w19
400001dc: 94000ee0     	bl	0x40003d5c <uart_printf>
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
400002d8: 94000a3e     	bl	0x40002bd0 <memset>
400002dc: aa1303e0     	mov	x0, x19
400002e0: aa1403e1     	mov	x1, x20
400002e4: 528007e2     	mov	w2, #0x3f               // =63
400002e8: 94000a15     	bl	0x40002b3c <kstrncpy>
400002ec: 5280003c     	mov	w28, #0x1               // =1
400002f0: aa1403e0     	mov	x0, x20
400002f4: b932427c     	str	w28, [x19, #0x3240]
400002f8: 94001262     	bl	0x40004c80 <vfs_find>
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
40000398: 50042880     	adr	x0, 0x400088aa <__rodata_start+0x18aa>
4000039c: 94000d5b     	bl	0x40003908 <uart_puts>
400003a0: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400003a4: 91329694     	add	x20, x20, #0xca5
400003a8: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400003ac: 9104a6d6     	add	x22, x22, #0x129
400003b0: 90000058     	adrp	x24, 0x40008000 <__rodata_start+0x1000>
400003b4: 910ee718     	add	x24, x24, #0x3b9
400003b8: 90000059     	adrp	x25, 0x40008000 <__rodata_start+0x1000>
400003bc: 911aab39     	add	x25, x25, #0x6aa
400003c0: d000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400003c4: 9109135a     	add	x26, x26, #0x244
400003c8: d000007b     	adrp	x27, 0x4000e000 <__bss_start+0x3000>
400003cc: 14000004     	b	0x400003dc <launch_kedit+0x13c>
400003d0: 51004d08     	sub	w8, w8, #0x13
400003d4: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400003d8: b9024d28     	str	w8, [x9, #0x24c]
400003dc: aa1403e0     	mov	x0, x20
400003e0: 94000d4a     	bl	0x40003908 <uart_puts>
400003e4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400003e8: 9108b800     	add	x0, x0, #0x22e
400003ec: 94000d47     	bl	0x40003908 <uart_puts>
400003f0: aa1603e0     	mov	x0, x22
400003f4: 94000d45     	bl	0x40003908 <uart_puts>
400003f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400003fc: 91377000     	add	x0, x0, #0xddc
40000400: aa1303e1     	mov	x1, x19
40000404: 94000e56     	bl	0x40003d5c <uart_printf>
40000408: b9725268     	ldr	w8, [x19, #0x3250]
4000040c: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000410: 910dbd29     	add	x9, x9, #0x36f
40000414: 7100011f     	cmp	w8, #0x0
40000418: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
4000041c: 9124c508     	add	x8, x8, #0x931
40000420: 9a880120     	csel	x0, x9, x8, eq
40000424: 94000d39     	bl	0x40003908 <uart_puts>
40000428: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000042c: 913fbc00     	add	x0, x0, #0xfef
40000430: 94000d36     	bl	0x40003908 <uart_puts>
40000434: aa1f03f5     	mov	x21, xzr
40000438: b9b24e68     	ldrsw	x8, [x19, #0x324c]
4000043c: b9724269     	ldr	w9, [x19, #0x3240]
40000440: 8b0802a8     	add	x8, x21, x8
40000444: 8b081e6a     	add	x10, x19, x8, lsl #7
40000448: 6b09011f     	cmp	w8, w9
4000044c: 9101014a     	add	x10, x10, #0x40
40000450: 9a98b140     	csel	x0, x10, x24, lt
40000454: 94000d2d     	bl	0x40003908 <uart_puts>
40000458: aa1903e0     	mov	x0, x25
4000045c: 94000d2b     	bl	0x40003908 <uart_puts>
40000460: 910006b5     	add	x21, x21, #0x1
40000464: 710052bf     	cmp	w21, #0x14
40000468: 54fffe81     	b.ne	0x40000438 <launch_kedit+0x198>
4000046c: aa1603e0     	mov	x0, x22
40000470: 94000d26     	bl	0x40003908 <uart_puts>
40000474: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000478: 910f1000     	add	x0, x0, #0x3c4
4000047c: 94000d23     	bl	0x40003908 <uart_puts>
40000480: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000484: 912d7800     	add	x0, x0, #0xb5e
40000488: 94000d20     	bl	0x40003908 <uart_puts>
4000048c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000490: 911ab000     	add	x0, x0, #0x6ac
40000494: 94000d1d     	bl	0x40003908 <uart_puts>
40000498: 2940a349     	ldp	w9, w8, [x26, #0x4]
4000049c: b940034a     	ldr	w10, [x26]
400004a0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400004a4: 9111fc00     	add	x0, x0, #0x47f
400004a8: 4b080128     	sub	w8, w9, w8
400004ac: 11000542     	add	w2, w10, #0x1
400004b0: 11000901     	add	w1, w8, #0x2
400004b4: 94000e2a     	bl	0x40003d5c <uart_printf>
400004b8: 94000d48     	bl	0x400039d8 <uart_getc>
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
4000052c: 9400097d     	bl	0x40002b20 <kstrcpy>
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
40000558: 94000972     	bl	0x40002b20 <kstrcpy>
4000055c: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000560: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000564: 910023e1     	add	x1, sp, #0x8
40000568: 8b081ea8     	add	x8, x21, x8, lsl #7
4000056c: 3829691f     	strb	wzr, [x8, x9]
40000570: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000574: 91000508     	add	x8, x8, #0x1
40000578: 8b081ea0     	add	x0, x21, x8, lsl #7
4000057c: b9320aa8     	str	w8, [x21, #0x3208]
40000580: 94000968     	bl	0x40002b20 <kstrcpy>
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
400005b8: 9400092b     	bl	0x40002a64 <kstrlen>
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
40000650: 94000905     	bl	0x40002a64 <kstrlen>
40000654: 0b0002d4     	add	w20, w22, w0
40000658: 710ffa9f     	cmp	w20, #0x3fe
4000065c: 54fffeec     	b.gt	0x40000638 <launch_kedit+0x398>
40000660: 910023e0     	add	x0, sp, #0x8
40000664: aa1503e1     	mov	x1, x21
40000668: 94000906     	bl	0x40002a80 <kstrcat>
4000066c: 910023e0     	add	x0, sp, #0x8
40000670: aa1903e1     	mov	x1, x25
40000674: 94000903     	bl	0x40002a80 <kstrcat>
40000678: 11000696     	add	w22, w20, #0x1
4000067c: 17ffffef     	b	0x40000638 <launch_kedit+0x398>
40000680: 910023e1     	add	x1, sp, #0x8
40000684: aa1303e0     	mov	x0, x19
40000688: 940012f9     	bl	0x4000526c <vfs_write_file>
4000068c: b932527f     	str	wzr, [x19, #0x3250]
40000690: 5280003c     	mov	w28, #0x1               // =1
40000694: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
40000698: 91329694     	add	x20, x20, #0xca5
4000069c: 14000040     	b	0x4000079c <launch_kedit+0x4fc>
400006a0: 94000cce     	bl	0x400039d8 <uart_getc>
400006a4: 12001c14     	and	w20, w0, #0xff
400006a8: 94000ccc     	bl	0x400039d8 <uart_getc>
400006ac: 71016e9f     	cmp	w20, #0x5b
400006b0: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400006b4: 91329694     	add	x20, x20, #0xca5
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
400006ec: 940008de     	bl	0x40002a64 <kstrlen>
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
4000073c: 940008ca     	bl	0x40002a64 <kstrlen>
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
40000800: 94000899     	bl	0x40002a64 <kstrlen>
40000804: eb14001f     	cmp	x0, x20
40000808: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
4000080c: 91329694     	add	x20, x20, #0xca5
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
40000868: 9122c000     	add	x0, x0, #0x8b0
4000086c: 94000c27     	bl	0x40003908 <uart_puts>
40000870: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000874: 91247c00     	add	x0, x0, #0x91f
40000878: 94000c24     	bl	0x40003908 <uart_puts>
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
400008a4: 5003cc40     	adr	x0, 0x4000822e <__rodata_start+0x122e>
400008a8: 910003fd     	mov	x29, sp
400008ac: 94000c17     	bl	0x40003908 <uart_puts>
400008b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008b4: 911aa800     	add	x0, x0, #0x6aa
400008b8: 94000c14     	bl	0x40003908 <uart_puts>
400008bc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008c0: 910fc400     	add	x0, x0, #0x3f1
400008c4: 94000c11     	bl	0x40003908 <uart_puts>
400008c8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008cc: 9124f800     	add	x0, x0, #0x93e
400008d0: 94000c0e     	bl	0x40003908 <uart_puts>
400008d4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008d8: 9137dc00     	add	x0, x0, #0xdf7
400008dc: 94000c0b     	bl	0x40003908 <uart_puts>
400008e0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400008e4: 91009c00     	add	x0, x0, #0x27
400008e8: 94000c08     	bl	0x40003908 <uart_puts>
400008ec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008f0: 9138c800     	add	x0, x0, #0xe32
400008f4: 94000c05     	bl	0x40003908 <uart_puts>
400008f8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400008fc: 910ee800     	add	x0, x0, #0x3ba
40000900: 94000c02     	bl	0x40003908 <uart_puts>
40000904: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000908: 913fd400     	add	x0, x0, #0xff5
4000090c: 94000d14     	bl	0x40003d5c <uart_printf>
40000910: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000914: 911acc00     	add	x0, x0, #0x6b3
40000918: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000091c: 91182421     	add	x1, x1, #0x609
40000920: 94000d0f     	bl	0x40003d5c <uart_printf>
40000924: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000928: 9100a400     	add	x0, x0, #0x29
4000092c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000930: 9139b821     	add	x1, x1, #0xe6e
40000934: 94000d0a     	bl	0x40003d5c <uart_printf>
40000938: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000093c: 912d8c00     	add	x0, x0, #0xb63
40000940: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000944: 14000bf1     	b	0x40003908 <uart_puts>

0000000040000948 <print_about>:
40000948: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000094c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000950: 910acc00     	add	x0, x0, #0x2b3
40000954: 910003fd     	mov	x29, sp
40000958: 94000bec     	bl	0x40003908 <uart_puts>
4000095c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000960: 91167c00     	add	x0, x0, #0x59f
40000964: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000968: 9139fc21     	add	x1, x1, #0xe7f
4000096c: 94000cfc     	bl	0x40003d5c <uart_printf>
40000970: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000974: 9128e800     	add	x0, x0, #0xa3a
40000978: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000097c: 91182421     	add	x1, x1, #0x609
40000980: 94000cf7     	bl	0x40003d5c <uart_printf>
40000984: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000988: 910df000     	add	x0, x0, #0x37c
4000098c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000990: 9139b821     	add	x1, x1, #0xe6e
40000994: 94000cf2     	bl	0x40003d5c <uart_printf>
40000998: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000099c: 9101e400     	add	x0, x0, #0x79
400009a0: 94000bda     	bl	0x40003908 <uart_puts>
400009a4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009a8: 9122bc00     	add	x0, x0, #0x8af
400009ac: 94000bd7     	bl	0x40003908 <uart_puts>
400009b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009b4: 911aa800     	add	x0, x0, #0x6aa
400009b8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009bc: 14000bd3     	b	0x40003908 <uart_puts>

00000000400009c0 <print_sysinfo>:
400009c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400009c4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009c8: 91055000     	add	x0, x0, #0x154
400009cc: a9014ff4     	stp	x20, x19, [sp, #0x10]
400009d0: 910003fd     	mov	x29, sp
400009d4: d5384248     	mrs	x8, CurrentEL
400009d8: d3420d13     	ubfx	x19, x8, #2, #2
400009dc: d5380014     	mrs	x20, MIDR_EL1
400009e0: 94000bca     	bl	0x40003908 <uart_puts>
400009e4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009e8: 9129bc00     	add	x0, x0, #0xa6f
400009ec: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400009f0: 9139fc21     	add	x1, x1, #0xe7f
400009f4: f0000022     	adrp	x2, 0x40007000 <__rodata_start>
400009f8: 91182442     	add	x2, x2, #0x609
400009fc: 94000cd8     	bl	0x40003d5c <uart_printf>
40000a00: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a04: 912a3800     	add	x0, x0, #0xa8e
40000a08: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000a0c: 9139b821     	add	x1, x1, #0xe6e
40000a10: 94000cd3     	bl	0x40003d5c <uart_printf>
40000a14: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a18: 91339000     	add	x0, x0, #0xce4
40000a1c: 94000cd0     	bl	0x40003d5c <uart_printf>
40000a20: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40000a24: 91116d08     	add	x8, x8, #0x45b
40000a28: b0000049     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40000a2c: 9102b929     	add	x9, x9, #0xae
40000a30: f1000a7f     	cmp	x19, #0x2
40000a34: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a38: 91189000     	add	x0, x0, #0x624
40000a3c: 9a880128     	csel	x8, x9, x8, eq
40000a40: f100067f     	cmp	x19, #0x1
40000a44: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000a48: 9125e529     	add	x9, x9, #0x979
40000a4c: 2a1303e1     	mov	w1, w19
40000a50: 9a880122     	csel	x2, x9, x8, eq
40000a54: 94000cc2     	bl	0x40003d5c <uart_printf>
40000a58: 53187e81     	lsr	w1, w20, #24
40000a5c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a60: 9116e000     	add	x0, x0, #0x5b8
40000a64: aa1403e2     	mov	x2, x20
40000a68: 94000cbd     	bl	0x40003d5c <uart_printf>
40000a6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a70: 91301400     	add	x0, x0, #0xc05
40000a74: d503201f     	nop
40000a78: 10ffac41     	adr	x1, 0x40000000 <_start>
40000a7c: 94000cb8     	bl	0x40003d5c <uart_printf>
40000a80: d503201f     	nop
40000a84: 10ffabe1     	adr	x1, 0x40000000 <_start>
40000a88: d503201f     	nop
40000a8c: 1002c362     	adr	x2, 0x400062f8 <__text_end>
40000a90: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a94: 9132b000     	add	x0, x0, #0xcac
40000a98: cb010043     	sub	x3, x2, x1
40000a9c: 94000cb0     	bl	0x40003d5c <uart_printf>
40000aa0: d503201f     	nop
40000aa4: 10032ae1     	adr	x1, 0x40007000 <__rodata_start>
40000aa8: d503201f     	nop
40000aac: 10046362     	adr	x2, 0x40009718 <__rodata_end>
40000ab0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ab4: 911c0400     	add	x0, x0, #0x701
40000ab8: cb010043     	sub	x3, x2, x1
40000abc: 94000ca8     	bl	0x40003d5c <uart_printf>
40000ac0: d503201f     	nop
40000ac4: 1004a9e1     	adr	x1, 0x4000a000 <free_pages>
40000ac8: d503201f     	nop
40000acc: 101d0722     	adr	x2, 0x4003abb0
40000ad0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000ad4: 912e6c00     	add	x0, x0, #0xb9b
40000ad8: cb010043     	sub	x3, x2, x1
40000adc: 94000ca0     	bl	0x40003d5c <uart_printf>
40000ae0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ae4: 91015c00     	add	x0, x0, #0x57
40000ae8: d503201f     	nop
40000aec: 10250621     	adr	x1, 0x4004abb0 <__stack_top>
40000af0: 94000c9b     	bl	0x40003d5c <uart_printf>
40000af4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000af8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000afc: 911aa800     	add	x0, x0, #0x6aa
40000b00: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b04: 14000b81     	b	0x40003908 <uart_puts>

0000000040000b08 <print_android_roadmap>:
40000b08: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b0c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b10: 9102e400     	add	x0, x0, #0xb9
40000b14: 910003fd     	mov	x29, sp
40000b18: 94000b7c     	bl	0x40003908 <uart_puts>
40000b1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b20: 91307c00     	add	x0, x0, #0xc1f
40000b24: 94000b79     	bl	0x40003908 <uart_puts>
40000b28: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b2c: 91191400     	add	x0, x0, #0x645
40000b30: 94000b76     	bl	0x40003908 <uart_puts>
40000b34: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b38: 912aa000     	add	x0, x0, #0xaa8
40000b3c: 94000b73     	bl	0x40003908 <uart_puts>
40000b40: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b44: 911cac00     	add	x0, x0, #0x72b
40000b48: 94000b70     	bl	0x40003908 <uart_puts>
40000b4c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b50: 9108d800     	add	x0, x0, #0x236
40000b54: 94000b6d     	bl	0x40003908 <uart_puts>
40000b58: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b5c: 91335800     	add	x0, x0, #0xcd6
40000b60: 94000b6a     	bl	0x40003908 <uart_puts>
40000b64: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b68: 91119c00     	add	x0, x0, #0x467
40000b6c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000b70: 14000b66     	b	0x40003908 <uart_puts>

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
40000b98: 91188294     	add	x20, x20, #0x620
40000b9c: aa1703f6     	mov	x22, x23
40000ba0: 94000b8e     	bl	0x400039d8 <uart_getc>
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
40000bf4: 94000b2e     	bl	0x400038ac <uart_putc>
40000bf8: 17ffffe9     	b	0x40000b9c <read_line+0x28>
40000bfc: aa1f03f7     	mov	x23, xzr
40000c00: b4fffcf6     	cbz	x22, 0x40000b9c <read_line+0x28>
40000c04: aa1403e0     	mov	x0, x20
40000c08: d10006d7     	sub	x23, x22, #0x1
40000c0c: 94000b3f     	bl	0x40003908 <uart_puts>
40000c10: 17ffffe3     	b	0x40000b9c <read_line+0x28>
40000c14: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c18: 9101dc00     	add	x0, x0, #0x77
40000c1c: 94000b3b     	bl	0x40003908 <uart_puts>
40000c20: 38366a7f     	strb	wzr, [x19, x22]
40000c24: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c28: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c2c: f9400bf7     	ldr	x23, [sp, #0x10]
40000c30: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000c34: d65f03c0     	ret

0000000040000c38 <print_help>:
40000c38: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000c3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c40: 91261400     	add	x0, x0, #0x985
40000c44: 910003fd     	mov	x29, sp
40000c48: 94000b30     	bl	0x40003908 <uart_puts>
40000c4c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c50: 9115ec00     	add	x0, x0, #0x57b
40000c54: 94000b2d     	bl	0x40003908 <uart_puts>
40000c58: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c5c: 9123bc00     	add	x0, x0, #0x8ef
40000c60: 94000b2a     	bl	0x40003908 <uart_puts>
40000c64: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c68: 9101e800     	add	x0, x0, #0x7a
40000c6c: 94000b27     	bl	0x40003908 <uart_puts>
40000c70: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c74: 9105e000     	add	x0, x0, #0x178
40000c78: 94000b24     	bl	0x40003908 <uart_puts>
40000c7c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c80: 913a2800     	add	x0, x0, #0xe8a
40000c84: 94000b21     	bl	0x40003908 <uart_puts>
40000c88: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000c8c: 9112c800     	add	x0, x0, #0x4b2
40000c90: 94000b1e     	bl	0x40003908 <uart_puts>
40000c94: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c98: 911dd800     	add	x0, x0, #0x776
40000c9c: 94000b1b     	bl	0x40003908 <uart_puts>
40000ca0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ca4: 911bfc00     	add	x0, x0, #0x6ff
40000ca8: 94000b18     	bl	0x40003908 <uart_puts>
40000cac: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000cb0: 9113e000     	add	x0, x0, #0x4f8
40000cb4: 94000b15     	bl	0x40003908 <uart_puts>
40000cb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cbc: 911d0000     	add	x0, x0, #0x740
40000cc0: 94000b12     	bl	0x40003908 <uart_puts>
40000cc4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cc8: 91347400     	add	x0, x0, #0xd1d
40000ccc: 94000b0f     	bl	0x40003908 <uart_puts>
40000cd0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cd4: 9104b800     	add	x0, x0, #0x12e
40000cd8: 94000b0c     	bl	0x40003908 <uart_puts>
40000cdc: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000ce0: 9103c400     	add	x0, x0, #0xf1
40000ce4: 94000b09     	bl	0x40003908 <uart_puts>
40000ce8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cec: 9124ac00     	add	x0, x0, #0x92b
40000cf0: 94000b06     	bl	0x40003908 <uart_puts>
40000cf4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cf8: 91318000     	add	x0, x0, #0xc60
40000cfc: 94000b03     	bl	0x40003908 <uart_puts>
40000d00: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d04: 91067c00     	add	x0, x0, #0x19f
40000d08: 94000b00     	bl	0x40003908 <uart_puts>
40000d0c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d10: 91177c00     	add	x0, x0, #0x5df
40000d14: 94000afd     	bl	0x40003908 <uart_puts>
40000d18: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d1c: 91189000     	add	x0, x0, #0x624
40000d20: 94000afa     	bl	0x40003908 <uart_puts>
40000d24: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d28: 9110b000     	add	x0, x0, #0x42c
40000d2c: 94000af7     	bl	0x40003908 <uart_puts>
40000d30: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d34: 910b5400     	add	x0, x0, #0x2d5
40000d38: 94000af4     	bl	0x40003908 <uart_puts>
40000d3c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d40: 910a1000     	add	x0, x0, #0x284
40000d44: 94000af1     	bl	0x40003908 <uart_puts>
40000d48: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d4c: 9104a800     	add	x0, x0, #0x12a
40000d50: 94000aee     	bl	0x40003908 <uart_puts>
40000d54: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d58: 911e0800     	add	x0, x0, #0x782
40000d5c: 94000aeb     	bl	0x40003908 <uart_puts>
40000d60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000d64: 9111c000     	add	x0, x0, #0x470
40000d68: 94000ae8     	bl	0x40003908 <uart_puts>
40000d6c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d70: 91122000     	add	x0, x0, #0x488
40000d74: 94000ae5     	bl	0x40003908 <uart_puts>
40000d78: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000d7c: 9119b400     	add	x0, x0, #0x66d
40000d80: 94000ae2     	bl	0x40003908 <uart_puts>
40000d84: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d88: 911ea800     	add	x0, x0, #0x7aa
40000d8c: 94000adf     	bl	0x40003908 <uart_puts>
40000d90: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000d94: 91352400     	add	x0, x0, #0xd49
40000d98: 94000adc     	bl	0x40003908 <uart_puts>
40000d9c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000da0: 91058000     	add	x0, x0, #0x160
40000da4: 94000ad9     	bl	0x40003908 <uart_puts>
40000da8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000dac: 9105b000     	add	x0, x0, #0x16c
40000db0: 94000ad6     	bl	0x40003908 <uart_puts>
40000db4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000db8: 912b8000     	add	x0, x0, #0xae0
40000dbc: 94000ad3     	bl	0x40003908 <uart_puts>
40000dc0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000dc4: 9118a400     	add	x0, x0, #0x629
40000dc8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000dcc: 14000acf     	b	0x40003908 <uart_puts>

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
40000e98: 91231c21     	add	x1, x1, #0x8c7
40000e9c: d10083a0     	sub	x0, x29, #0x20
40000ea0: 382c691f     	strb	wzr, [x8, x12]
40000ea4: 94000700     	bl	0x40002aa4 <kstrcmp>
40000ea8: 34001400     	cbz	w0, 0x40001128 <execute_command+0x358>
40000eac: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000eb0: 9127d021     	add	x1, x1, #0x9f4
40000eb4: d10083a0     	sub	x0, x29, #0x20
40000eb8: 940006fb     	bl	0x40002aa4 <kstrcmp>
40000ebc: 340013a0     	cbz	w0, 0x40001130 <execute_command+0x360>
40000ec0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ec4: 91074821     	add	x1, x1, #0x1d2
40000ec8: d10083a0     	sub	x0, x29, #0x20
40000ecc: 940006f6     	bl	0x40002aa4 <kstrcmp>
40000ed0: 34001680     	cbz	w0, 0x400011a0 <execute_command+0x3d0>
40000ed4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ed8: 91328021     	add	x1, x1, #0xca0
40000edc: d10083a0     	sub	x0, x29, #0x20
40000ee0: 940006f1     	bl	0x40002aa4 <kstrcmp>
40000ee4: 34001800     	cbz	w0, 0x400011e4 <execute_command+0x414>
40000ee8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000eec: 910d4c21     	add	x1, x1, #0x353
40000ef0: d10083a0     	sub	x0, x29, #0x20
40000ef4: 940006ec     	bl	0x40002aa4 <kstrcmp>
40000ef8: 34001860     	cbz	w0, 0x40001204 <execute_command+0x434>
40000efc: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f00: 91253821     	add	x1, x1, #0x94e
40000f04: d10083a0     	sub	x0, x29, #0x20
40000f08: 940006e7     	bl	0x40002aa4 <kstrcmp>
40000f0c: 34001900     	cbz	w0, 0x4000122c <execute_command+0x45c>
40000f10: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f14: 91345421     	add	x1, x1, #0xd15
40000f18: d10083a0     	sub	x0, x29, #0x20
40000f1c: 940006e2     	bl	0x40002aa4 <kstrcmp>
40000f20: 34001960     	cbz	w0, 0x4000124c <execute_command+0x47c>
40000f24: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f28: 910a6021     	add	x1, x1, #0x298
40000f2c: d10083a0     	sub	x0, x29, #0x20
40000f30: 940006dd     	bl	0x40002aa4 <kstrcmp>
40000f34: 34001880     	cbz	w0, 0x40001244 <execute_command+0x474>
40000f38: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f3c: 91276421     	add	x1, x1, #0x9d9
40000f40: d10083a0     	sub	x0, x29, #0x20
40000f44: 940006d8     	bl	0x40002aa4 <kstrcmp>
40000f48: 340017e0     	cbz	w0, 0x40001244 <execute_command+0x474>
40000f4c: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f50: 912c4421     	add	x1, x1, #0xb11
40000f54: d10083a0     	sub	x0, x29, #0x20
40000f58: 940006d3     	bl	0x40002aa4 <kstrcmp>
40000f5c: 34001960     	cbz	w0, 0x40001288 <execute_command+0x4b8>
40000f60: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f64: 91165821     	add	x1, x1, #0x596
40000f68: d10083a0     	sub	x0, x29, #0x20
40000f6c: 940006ce     	bl	0x40002aa4 <kstrcmp>
40000f70: 34001900     	cbz	w0, 0x40001290 <execute_command+0x4c0>
40000f74: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000f78: 9114ec21     	add	x1, x1, #0x53b
40000f7c: d10083a0     	sub	x0, x29, #0x20
40000f80: 940006c9     	bl	0x40002aa4 <kstrcmp>
40000f84: 34001aa0     	cbz	w0, 0x400012d8 <execute_command+0x508>
40000f88: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f8c: 91131421     	add	x1, x1, #0x4c5
40000f90: d10083a0     	sub	x0, x29, #0x20
40000f94: 940006c4     	bl	0x40002aa4 <kstrcmp>
40000f98: 34001b80     	cbz	w0, 0x40001308 <execute_command+0x538>
40000f9c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fa0: 911e8021     	add	x1, x1, #0x7a0
40000fa4: d10083a0     	sub	x0, x29, #0x20
40000fa8: 940006bf     	bl	0x40002aa4 <kstrcmp>
40000fac: 34001dc0     	cbz	w0, 0x40001364 <execute_command+0x594>
40000fb0: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000fb4: 91304021     	add	x1, x1, #0xc10
40000fb8: d10083a0     	sub	x0, x29, #0x20
40000fbc: 940006ba     	bl	0x40002aa4 <kstrcmp>
40000fc0: 340020e0     	cbz	w0, 0x400013dc <execute_command+0x60c>
40000fc4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fc8: 911e9c21     	add	x1, x1, #0x7a7
40000fcc: d10083a0     	sub	x0, x29, #0x20
40000fd0: 940006b5     	bl	0x40002aa4 <kstrcmp>
40000fd4: 34001e20     	cbz	w0, 0x40001398 <execute_command+0x5c8>
40000fd8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fdc: 913b3821     	add	x1, x1, #0xece
40000fe0: d10083a0     	sub	x0, x29, #0x20
40000fe4: 940006b0     	bl	0x40002aa4 <kstrcmp>
40000fe8: 34001d80     	cbz	w0, 0x40001398 <execute_command+0x5c8>
40000fec: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ff0: 9102f421     	add	x1, x1, #0xbd
40000ff4: d10083a0     	sub	x0, x29, #0x20
40000ff8: 940006ab     	bl	0x40002aa4 <kstrcmp>
40000ffc: 340021a0     	cbz	w0, 0x40001430 <execute_command+0x660>
40001000: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001004: 910d5821     	add	x1, x1, #0x356
40001008: d10083a0     	sub	x0, x29, #0x20
4000100c: 940006a6     	bl	0x40002aa4 <kstrcmp>
40001010: 34002260     	cbz	w0, 0x4000145c <execute_command+0x68c>
40001014: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001018: 910e5421     	add	x1, x1, #0x395
4000101c: d10083a0     	sub	x0, x29, #0x20
40001020: 940006a1     	bl	0x40002aa4 <kstrcmp>
40001024: 34002340     	cbz	w0, 0x4000148c <execute_command+0x6bc>
40001028: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000102c: 911a5821     	add	x1, x1, #0x696
40001030: d10083a0     	sub	x0, x29, #0x20
40001034: 9400069c     	bl	0x40002aa4 <kstrcmp>
40001038: 340023e0     	cbz	w0, 0x400014b4 <execute_command+0x6e4>
4000103c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001040: 91208021     	add	x1, x1, #0x820
40001044: d10083a0     	sub	x0, x29, #0x20
40001048: 94000697     	bl	0x40002aa4 <kstrcmp>
4000104c: 34002520     	cbz	w0, 0x400014f0 <execute_command+0x720>
40001050: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001054: 9108f421     	add	x1, x1, #0x23d
40001058: d10083a0     	sub	x0, x29, #0x20
4000105c: 94000692     	bl	0x40002aa4 <kstrcmp>
40001060: 34002720     	cbz	w0, 0x40001544 <execute_command+0x774>
40001064: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001068: 910e6c21     	add	x1, x1, #0x39b
4000106c: d10083a0     	sub	x0, x29, #0x20
40001070: 9400068d     	bl	0x40002aa4 <kstrcmp>
40001074: 34002600     	cbz	w0, 0x40001534 <execute_command+0x764>
40001078: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000107c: 91209821     	add	x1, x1, #0x826
40001080: d10083a0     	sub	x0, x29, #0x20
40001084: 94000688     	bl	0x40002aa4 <kstrcmp>
40001088: 34002560     	cbz	w0, 0x40001534 <execute_command+0x764>
4000108c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001090: 911a7021     	add	x1, x1, #0x69c
40001094: d10083a0     	sub	x0, x29, #0x20
40001098: 94000683     	bl	0x40002aa4 <kstrcmp>
4000109c: 34002aa0     	cbz	w0, 0x400015f0 <execute_command+0x820>
400010a0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010a4: 91077421     	add	x1, x1, #0x1dd
400010a8: d10083a0     	sub	x0, x29, #0x20
400010ac: 9400067e     	bl	0x40002aa4 <kstrcmp>
400010b0: 34002a00     	cbz	w0, 0x400015f0 <execute_command+0x820>
400010b4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010b8: 910b9021     	add	x1, x1, #0x2e4
400010bc: d10083a0     	sub	x0, x29, #0x20
400010c0: 94000679     	bl	0x40002aa4 <kstrcmp>
400010c4: 34002aa0     	cbz	w0, 0x40001618 <execute_command+0x848>
400010c8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010cc: 912c0021     	add	x1, x1, #0xb00
400010d0: d10083a0     	sub	x0, x29, #0x20
400010d4: 94000674     	bl	0x40002aa4 <kstrcmp>
400010d8: 34003080     	cbz	w0, 0x400016e8 <execute_command+0x918>
400010dc: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
400010e0: 911a3c21     	add	x1, x1, #0x68f
400010e4: d10083a0     	sub	x0, x29, #0x20
400010e8: 9400066f     	bl	0x40002aa4 <kstrcmp>
400010ec: 34002ee0     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
400010f0: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
400010f4: 910aac21     	add	x1, x1, #0x2ab
400010f8: d10083a0     	sub	x0, x29, #0x20
400010fc: 9400066a     	bl	0x40002aa4 <kstrcmp>
40001100: 34002e40     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
40001104: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001108: 9130a421     	add	x1, x1, #0xc29
4000110c: d10083a0     	sub	x0, x29, #0x20
40001110: 94000665     	bl	0x40002aa4 <kstrcmp>
40001114: 34002da0     	cbz	w0, 0x400016c8 <execute_command+0x8f8>
40001118: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000111c: 910ac000     	add	x0, x0, #0x2b0
40001120: d10083a1     	sub	x1, x29, #0x20
40001124: 140000b4     	b	0x400013f4 <execute_command+0x624>
40001128: 97fffec4     	bl	0x40000c38 <print_help>
4000112c: 1400002f     	b	0x400011e8 <execute_command+0x418>
40001130: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001134: 910acc00     	add	x0, x0, #0x2b3
40001138: 940009f4     	bl	0x40003908 <uart_puts>
4000113c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001140: 91167c00     	add	x0, x0, #0x59f
40001144: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001148: 9139fc21     	add	x1, x1, #0xe7f
4000114c: 94000b04     	bl	0x40003d5c <uart_printf>
40001150: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001154: 9128e800     	add	x0, x0, #0xa3a
40001158: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
4000115c: 91182421     	add	x1, x1, #0x609
40001160: 94000aff     	bl	0x40003d5c <uart_printf>
40001164: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001168: 910df000     	add	x0, x0, #0x37c
4000116c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001170: 9139b821     	add	x1, x1, #0xe6e
40001174: 94000afa     	bl	0x40003d5c <uart_printf>
40001178: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000117c: 9101e400     	add	x0, x0, #0x79
40001180: 940009e2     	bl	0x40003908 <uart_puts>
40001184: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001188: 9122bc00     	add	x0, x0, #0x8af
4000118c: 940009df     	bl	0x40003908 <uart_puts>
40001190: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001194: 911aa800     	add	x0, x0, #0x6aa
40001198: 940009dc     	bl	0x40003908 <uart_puts>
4000119c: 14000013     	b	0x400011e8 <execute_command+0x418>
400011a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400011a4: 913c1400     	add	x0, x0, #0xf05
400011a8: 940009d8     	bl	0x40003908 <uart_puts>
400011ac: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011b0: 910c2000     	add	x0, x0, #0x308
400011b4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400011b8: 91182421     	add	x1, x1, #0x609
400011bc: 94000ae8     	bl	0x40003d5c <uart_printf>
400011c0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011c4: 912f1400     	add	x0, x0, #0xbc5
400011c8: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400011cc: 9139b821     	add	x1, x1, #0xe6e
400011d0: 94000ae3     	bl	0x40003d5c <uart_printf>
400011d4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400011d8: 91067000     	add	x0, x0, #0x19c
400011dc: 940009cb     	bl	0x40003908 <uart_puts>
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
40001208: 94000617     	bl	0x40002a64 <kstrlen>
4000120c: b4000260     	cbz	x0, 0x40001258 <execute_command+0x488>
40001210: 910103e0     	add	x0, sp, #0x40
40001214: 94001017     	bl	0x40005270 <vfs_remove>
40001218: 34000280     	cbz	w0, 0x40001268 <execute_command+0x498>
4000121c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001220: 9109f800     	add	x0, x0, #0x27e
40001224: 940009b9     	bl	0x40003908 <uart_puts>
40001228: 17fffff0     	b	0x400011e8 <execute_command+0x418>
4000122c: 910103e0     	add	x0, sp, #0x40
40001230: 9400060d     	bl	0x40002a64 <kstrlen>
40001234: b4000220     	cbz	x0, 0x40001278 <execute_command+0x4a8>
40001238: 910103e0     	add	x0, sp, #0x40
4000123c: 97fffc19     	bl	0x400002a0 <launch_kedit>
40001240: 17ffffea     	b	0x400011e8 <execute_command+0x418>
40001244: 940006db     	bl	0x40002db0 <tui_launch>
40001248: 17ffffe8     	b	0x400011e8 <execute_command+0x418>
4000124c: 910103e0     	add	x0, sp, #0x40
40001250: 9400020f     	bl	0x40001a8c <kproj_execute>
40001254: 17ffffe5     	b	0x400011e8 <execute_command+0x418>
40001258: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000125c: 911a4000     	add	x0, x0, #0x690
40001260: 940009aa     	bl	0x40003908 <uart_puts>
40001264: 17ffffe1     	b	0x400011e8 <execute_command+0x418>
40001268: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000126c: 912bd800     	add	x0, x0, #0xaf6
40001270: 940009a6     	bl	0x40003908 <uart_puts>
40001274: 17ffffdd     	b	0x400011e8 <execute_command+0x418>
40001278: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000127c: 9135d800     	add	x0, x0, #0xd76
40001280: 940009a2     	bl	0x40003908 <uart_puts>
40001284: 17ffffd9     	b	0x400011e8 <execute_command+0x418>
40001288: 940003d8     	bl	0x400021e8 <launch_ktop>
4000128c: 17ffffd7     	b	0x400011e8 <execute_command+0x418>
40001290: 910103e0     	add	x0, sp, #0x40
40001294: 940005f4     	bl	0x40002a64 <kstrlen>
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
400012dc: 91255021     	add	x1, x1, #0x954
400012e0: aa1303e0     	mov	x0, x19
400012e4: 9400065a     	bl	0x40002c4c <kstrstr>
400012e8: b4000460     	cbz	x0, 0x40001374 <execute_command+0x5a4>
400012ec: 3900001f     	strb	wzr, [x0]
400012f0: 38401c08     	ldrb	w8, [x0, #0x1]!
400012f4: 7100811f     	cmp	w8, #0x20
400012f8: 54ffffc0     	b.eq	0x400012f0 <execute_command+0x520>
400012fc: 91001661     	add	x1, x19, #0x5
40001300: 94000fdb     	bl	0x4000526c <vfs_write_file>
40001304: 17ffffb9     	b	0x400011e8 <execute_command+0x418>
40001308: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000130c: 91076821     	add	x1, x1, #0x1da
40001310: 910103e0     	add	x0, sp, #0x40
40001314: 940005e4     	bl	0x40002aa4 <kstrcmp>
40001318: 34000720     	cbz	w0, 0x400013fc <execute_command+0x62c>
4000131c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001320: 911b3400     	add	x0, x0, #0x6cd
40001324: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001328: 9139fc21     	add	x1, x1, #0xe7f
4000132c: 14000032     	b	0x400013f4 <execute_command+0x624>
40001330: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001334: 9112d800     	add	x0, x0, #0x4b6
40001338: 94000974     	bl	0x40003908 <uart_puts>
4000133c: 17ffffab     	b	0x400011e8 <execute_command+0x418>
40001340: 2a1f03f3     	mov	w19, wzr
40001344: 2a1303e0     	mov	w0, w19
40001348: 94000313     	bl	0x40001f94 <process_kill>
4000134c: 3100041f     	cmn	w0, #0x1
40001350: 540001a0     	b.eq	0x40001384 <execute_command+0x5b4>
40001354: 35fff4a0     	cbnz	w0, 0x400011e8 <execute_command+0x418>
40001358: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000135c: 913e9800     	add	x0, x0, #0xfa6
40001360: 1400000b     	b	0x4000138c <execute_command+0x5bc>
40001364: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001368: 913ee800     	add	x0, x0, #0xfba
4000136c: 94000967     	bl	0x40003908 <uart_puts>
40001370: 17ffff9e     	b	0x400011e8 <execute_command+0x418>
40001374: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001378: 911b3400     	add	x0, x0, #0x6cd
4000137c: 910103e1     	add	x1, sp, #0x40
40001380: 1400001d     	b	0x400013f4 <execute_command+0x624>
40001384: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001388: 911a9800     	add	x0, x0, #0x6a6
4000138c: 2a1303e1     	mov	w1, w19
40001390: 94000a73     	bl	0x40003d5c <uart_printf>
40001394: 17ffff95     	b	0x400011e8 <execute_command+0x418>
40001398: 94000de8     	bl	0x40004b38 <vfs_get_cwd>
4000139c: aa0003f3     	mov	x19, x0
400013a0: 910103e0     	add	x0, sp, #0x40
400013a4: 940005b0     	bl	0x40002a64 <kstrlen>
400013a8: b40003e0     	cbz	x0, 0x40001424 <execute_command+0x654>
400013ac: 910103e0     	add	x0, sp, #0x40
400013b0: 94000e34     	bl	0x40004c80 <vfs_find>
400013b4: b40004c0     	cbz	x0, 0x4000144c <execute_command+0x67c>
400013b8: b9402008     	ldr	w8, [x0, #0x20]
400013bc: 35000368     	cbnz	w8, 0x40001428 <execute_command+0x658>
400013c0: b9402801     	ldr	w1, [x0, #0x28]
400013c4: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
400013c8: 9119f908     	add	x8, x8, #0x67e
400013cc: aa0003e2     	mov	x2, x0
400013d0: aa0803e0     	mov	x0, x8
400013d4: 94000a62     	bl	0x40003d5c <uart_printf>
400013d8: 17ffff84     	b	0x400011e8 <execute_command+0x418>
400013dc: 910003e0     	mov	x0, sp
400013e0: 52800801     	mov	w1, #0x40               // =64
400013e4: 94000dd8     	bl	0x40004b44 <vfs_getcwd>
400013e8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400013ec: 911b3400     	add	x0, x0, #0x6cd
400013f0: 910003e1     	mov	x1, sp
400013f4: 94000a5a     	bl	0x40003d5c <uart_printf>
400013f8: 17ffff7c     	b	0x400011e8 <execute_command+0x418>
400013fc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001400: 911fc400     	add	x0, x0, #0x7f1
40001404: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001408: 9139fc21     	add	x1, x1, #0xe7f
4000140c: d0000022     	adrp	x2, 0x40007000 <__rodata_start>
40001410: 91182442     	add	x2, x2, #0x609
40001414: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x1000>
40001418: 9139b863     	add	x3, x3, #0xe6e
4000141c: 94000a50     	bl	0x40003d5c <uart_printf>
40001420: 17ffff72     	b	0x400011e8 <execute_command+0x418>
40001424: aa1303e0     	mov	x0, x19
40001428: 94000fcb     	bl	0x40005354 <vfs_list_dir>
4000142c: 17ffff6f     	b	0x400011e8 <execute_command+0x418>
40001430: 910103e0     	add	x0, sp, #0x40
40001434: 94000e78     	bl	0x40004e14 <vfs_chdir>
40001438: 34ffed80     	cbz	w0, 0x400011e8 <execute_command+0x418>
4000143c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001440: 910b0000     	add	x0, x0, #0x2c0
40001444: 910103e1     	add	x1, sp, #0x40
40001448: 17ffffeb     	b	0x400013f4 <execute_command+0x624>
4000144c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001450: 91132400     	add	x0, x0, #0x4c9
40001454: 910103e1     	add	x1, sp, #0x40
40001458: 17ffffe7     	b	0x400013f4 <execute_command+0x624>
4000145c: 910103e0     	add	x0, sp, #0x40
40001460: 94000581     	bl	0x40002a64 <kstrlen>
40001464: b40003e0     	cbz	x0, 0x400014e0 <execute_command+0x710>
40001468: 910103e0     	add	x0, sp, #0x40
4000146c: 94000e05     	bl	0x40004c80 <vfs_find>
40001470: b4000060     	cbz	x0, 0x4000147c <execute_command+0x6ac>
40001474: b9402008     	ldr	w8, [x0, #0x20]
40001478: 34000a28     	cbz	w8, 0x400015bc <execute_command+0x7ec>
4000147c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001480: 910d6800     	add	x0, x0, #0x35a
40001484: 94000921     	bl	0x40003908 <uart_puts>
40001488: 17ffff58     	b	0x400011e8 <execute_command+0x418>
4000148c: 910103e0     	add	x0, sp, #0x40
40001490: 94000575     	bl	0x40002a64 <kstrlen>
40001494: b4000480     	cbz	x0, 0x40001524 <execute_command+0x754>
40001498: 910103e0     	add	x0, sp, #0x40
4000149c: 94000e83     	bl	0x40004ea8 <vfs_mkdir>
400014a0: 34ffea40     	cbz	w0, 0x400011e8 <execute_command+0x418>
400014a4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014a8: 913f8c00     	add	x0, x0, #0xfe3
400014ac: 94000917     	bl	0x40003908 <uart_puts>
400014b0: 17ffff4e     	b	0x400011e8 <execute_command+0x418>
400014b4: 910103e0     	add	x0, sp, #0x40
400014b8: 9400056b     	bl	0x40002a64 <kstrlen>
400014bc: b40008a0     	cbz	x0, 0x400015d0 <execute_command+0x800>
400014c0: 910103e0     	add	x0, sp, #0x40
400014c4: aa1f03e1     	mov	x1, xzr
400014c8: 94000ece     	bl	0x40005000 <vfs_touch>
400014cc: 34ffe8e0     	cbz	w0, 0x400011e8 <execute_command+0x418>
400014d0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400014d4: 910a7000     	add	x0, x0, #0x29c
400014d8: 9400090c     	bl	0x40003908 <uart_puts>
400014dc: 17ffff43     	b	0x400011e8 <execute_command+0x418>
400014e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400014e4: 91067c00     	add	x0, x0, #0x19f
400014e8: 94000908     	bl	0x40003908 <uart_puts>
400014ec: 17ffff3f     	b	0x400011e8 <execute_command+0x418>
400014f0: 910103e0     	add	x0, sp, #0x40
400014f4: 52800401     	mov	w1, #0x20               // =32
400014f8: 940005f0     	bl	0x40002cb8 <kstrchr>
400014fc: b4000720     	cbz	x0, 0x400015e0 <execute_command+0x810>
40001500: aa0003e1     	mov	x1, x0
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 3800143f     	strb	wzr, [x1], #0x1
4000150c: 94000f58     	bl	0x4000526c <vfs_write_file>
40001510: 34ffe6c0     	cbz	w0, 0x400011e8 <execute_command+0x418>
40001514: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001518: 91132c00     	add	x0, x0, #0x4cb
4000151c: 940008fb     	bl	0x40003908 <uart_puts>
40001520: 17ffff32     	b	0x400011e8 <execute_command+0x418>
40001524: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001528: 91141400     	add	x0, x0, #0x505
4000152c: 940008f7     	bl	0x40003908 <uart_puts>
40001530: 17ffff2e     	b	0x400011e8 <execute_command+0x418>
40001534: d503201f     	nop
40001538: 500367a0     	adr	x0, 0x4000822e <__rodata_start+0x122e>
4000153c: 940008f3     	bl	0x40003908 <uart_puts>
40001540: 17ffff2a     	b	0x400011e8 <execute_command+0x418>
40001544: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001548: 911aa800     	add	x0, x0, #0x6aa
4000154c: 940008ef     	bl	0x40003908 <uart_puts>
40001550: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001554: 91346c00     	add	x0, x0, #0xd1b
40001558: 940008ec     	bl	0x40003908 <uart_puts>
4000155c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001560: 91018800     	add	x0, x0, #0x62
40001564: 940008e9     	bl	0x40003908 <uart_puts>
40001568: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000156c: 9132a000     	add	x0, x0, #0xca8
40001570: 940008e6     	bl	0x40003908 <uart_puts>
40001574: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001578: 91136800     	add	x0, x0, #0x4da
4000157c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001580: 9139b821     	add	x1, x1, #0xe6e
40001584: 940009f6     	bl	0x40003d5c <uart_printf>
40001588: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000158c: 911ea800     	add	x0, x0, #0x7aa
40001590: 940008de     	bl	0x40003908 <uart_puts>
40001594: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001598: 91150000     	add	x0, x0, #0x540
4000159c: 940008db     	bl	0x40003908 <uart_puts>
400015a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015a4: 91146800     	add	x0, x0, #0x51a
400015a8: 940008d8     	bl	0x40003908 <uart_puts>
400015ac: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015b0: 91278400     	add	x0, x0, #0x9e1
400015b4: 940008d5     	bl	0x40003908 <uart_puts>
400015b8: 17ffff0c     	b	0x400011e8 <execute_command+0x418>
400015bc: d0000028     	adrp	x8, 0x40007000 <__rodata_start>
400015c0: 911b3508     	add	x8, x8, #0x6cd
400015c4: 9100c001     	add	x1, x0, #0x30
400015c8: aa0803e0     	mov	x0, x8
400015cc: 17ffff8a     	b	0x400013f4 <execute_command+0x624>
400015d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015d4: 91305000     	add	x0, x0, #0xc14
400015d8: 940008cc     	bl	0x40003908 <uart_puts>
400015dc: 17ffff03     	b	0x400011e8 <execute_command+0x418>
400015e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015e4: 91363c00     	add	x0, x0, #0xd8f
400015e8: 940008c8     	bl	0x40003908 <uart_puts>
400015ec: 17fffeff     	b	0x400011e8 <execute_command+0x418>
400015f0: 910103e0     	add	x0, sp, #0x40
400015f4: 9400051c     	bl	0x40002a64 <kstrlen>
400015f8: b4000080     	cbz	x0, 0x40001608 <execute_command+0x838>
400015fc: 910103e0     	add	x0, sp, #0x40
40001600: 940004e1     	bl	0x40002984 <script_run_file>
40001604: 17fffef9     	b	0x400011e8 <execute_command+0x418>
40001608: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000160c: 9106d800     	add	x0, x0, #0x1b6
40001610: 940008be     	bl	0x40003908 <uart_puts>
40001614: 17fffef5     	b	0x400011e8 <execute_command+0x418>
40001618: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000161c: 913a0000     	add	x0, x0, #0xe80
40001620: 940008ba     	bl	0x40003908 <uart_puts>
40001624: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001628: d0000035     	adrp	x21, 0x40007000 <__rodata_start>
4000162c: 9113e6b5     	add	x21, x21, #0x4f9
40001630: 39400113     	ldrb	w19, [x8]
40001634: d344fe68     	lsr	x8, x19, #4
40001638: 38686aa0     	ldrb	w0, [x21, x8]
4000163c: 9400089c     	bl	0x400038ac <uart_putc>
40001640: 92400e68     	and	x8, x19, #0xf
40001644: 38686aa0     	ldrb	w0, [x21, x8]
40001648: 94000899     	bl	0x400038ac <uart_putc>
4000164c: 52800400     	mov	w0, #0x20               // =32
40001650: 94000897     	bl	0x400038ac <uart_putc>
40001654: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001658: 910dbe73     	add	x19, x19, #0x36f
4000165c: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001660: 911aaa94     	add	x20, x20, #0x6aa
40001664: 52800036     	mov	w22, #0x1               // =1
40001668: d503201f     	nop
4000166c: 10ff4cb7     	adr	x23, 0x40000000 <_start>
40001670: 1400000d     	b	0x400016a4 <execute_command+0x8d4>
40001674: 38766af8     	ldrb	w24, [x23, x22]
40001678: d344ff08     	lsr	x8, x24, #4
4000167c: 38686aa0     	ldrb	w0, [x21, x8]
40001680: 9400088b     	bl	0x400038ac <uart_putc>
40001684: 92400f08     	and	x8, x24, #0xf
40001688: 38686aa0     	ldrb	w0, [x21, x8]
4000168c: 94000888     	bl	0x400038ac <uart_putc>
40001690: 52800400     	mov	w0, #0x20               // =32
40001694: 94000886     	bl	0x400038ac <uart_putc>
40001698: 910006d6     	add	x22, x22, #0x1
4000169c: f10082df     	cmp	x22, #0x20
400016a0: 54ffd780     	b.eq	0x40001190 <execute_command+0x3c0>
400016a4: 72000adf     	tst	w22, #0x7
400016a8: 54000061     	b.ne	0x400016b4 <execute_command+0x8e4>
400016ac: aa1303e0     	mov	x0, x19
400016b0: 94000896     	bl	0x40003908 <uart_puts>
400016b4: 72000edf     	tst	w22, #0xf
400016b8: 54fffde1     	b.ne	0x40001674 <execute_command+0x8a4>
400016bc: aa1403e0     	mov	x0, x20
400016c0: 94000892     	bl	0x40003908 <uart_puts>
400016c4: 17ffffec     	b	0x40001674 <execute_command+0x8a4>
400016c8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400016cc: 9136c800     	add	x0, x0, #0xdb2
400016d0: 9400088e     	bl	0x40003908 <uart_puts>
400016d4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400016d8: 913fc800     	add	x0, x0, #0xff2
400016dc: 9400088b     	bl	0x40003908 <uart_puts>
400016e0: d503207f     	wfi
400016e4: 17ffffff     	b	0x400016e0 <execute_command+0x910>
400016e8: 97fffd08     	bl	0x40000b08 <print_android_roadmap>
400016ec: 17fffebf     	b	0x400011e8 <execute_command+0x418>

00000000400016f0 <kernel_shell>:
400016f0: d10543ff     	sub	sp, sp, #0x150
400016f4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400016f8: 91280800     	add	x0, x0, #0xa02
400016fc: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
40001700: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001704: 9103c3fd     	add	x29, sp, #0xf0
40001708: a91167fa     	stp	x26, x25, [sp, #0x110]
4000170c: a9125ff8     	stp	x24, x23, [sp, #0x120]
40001710: a91357f6     	stp	x22, x21, [sp, #0x130]
40001714: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001718: 9400087c     	bl	0x40003908 <uart_puts>
4000171c: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001720: 913a9273     	add	x19, x19, #0xea4
40001724: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001728: 91030294     	add	x20, x20, #0xc0
4000172c: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
40001730: 911882b5     	add	x21, x21, #0x620
40001734: f0000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40001738: 9101ded6     	add	x22, x22, #0x77
4000173c: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x2000>
40001740: 911a3ef7     	add	x23, x23, #0x68f
40001744: 90000058     	adrp	x24, 0x40009000 <__rodata_start+0x2000>
40001748: 910aaf18     	add	x24, x24, #0x2ab
4000174c: 910123fa     	add	x26, sp, #0x48
40001750: d0000039     	adrp	x25, 0x40007000 <__rodata_start>
40001754: 9130a739     	add	x25, x25, #0xc29
40001758: 910023e0     	add	x0, sp, #0x8
4000175c: 52800801     	mov	w1, #0x40               // =64
40001760: 94000cf9     	bl	0x40004b44 <vfs_getcwd>
40001764: 910023e1     	add	x1, sp, #0x8
40001768: aa1303e0     	mov	x0, x19
4000176c: 9400097c     	bl	0x40003d5c <uart_printf>
40001770: aa1403e0     	mov	x0, x20
40001774: 94000865     	bl	0x40003908 <uart_puts>
40001778: aa1f03fc     	mov	x28, xzr
4000177c: aa1c03fb     	mov	x27, x28
40001780: 94000896     	bl	0x400039d8 <uart_getc>
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
400017d4: 94000836     	bl	0x400038ac <uart_putc>
400017d8: 17ffffe9     	b	0x4000177c <kernel_shell+0x8c>
400017dc: aa1f03fc     	mov	x28, xzr
400017e0: b4fffcfb     	cbz	x27, 0x4000177c <kernel_shell+0x8c>
400017e4: aa1503e0     	mov	x0, x21
400017e8: d100077c     	sub	x28, x27, #0x1
400017ec: 94000847     	bl	0x40003908 <uart_puts>
400017f0: 17ffffe3     	b	0x4000177c <kernel_shell+0x8c>
400017f4: aa1603e0     	mov	x0, x22
400017f8: 94000844     	bl	0x40003908 <uart_puts>
400017fc: 910123e0     	add	x0, sp, #0x48
40001800: 383b6b5f     	strb	wzr, [x26, x27]
40001804: 94000498     	bl	0x40002a64 <kstrlen>
40001808: b4fffa80     	cbz	x0, 0x40001758 <kernel_shell+0x68>
4000180c: 910123e0     	add	x0, sp, #0x48
40001810: 94000398     	bl	0x40002670 <script_execute_line>
40001814: 910123e0     	add	x0, sp, #0x48
40001818: aa1703e1     	mov	x1, x23
4000181c: 940004a2     	bl	0x40002aa4 <kstrcmp>
40001820: 34000120     	cbz	w0, 0x40001844 <kernel_shell+0x154>
40001824: 910123e0     	add	x0, sp, #0x48
40001828: aa1803e1     	mov	x1, x24
4000182c: 9400049e     	bl	0x40002aa4 <kstrcmp>
40001830: 340000a0     	cbz	w0, 0x40001844 <kernel_shell+0x154>
40001834: 910123e0     	add	x0, sp, #0x48
40001838: aa1903e1     	mov	x1, x25
4000183c: 9400049a     	bl	0x40002aa4 <kstrcmp>
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
4000187c: 94000800     	bl	0x4000387c <uart_init>
40001880: d503201f     	nop
40001884: 50034d40     	adr	x0, 0x4000822e <__rodata_start+0x122e>
40001888: 94000820     	bl	0x40003908 <uart_puts>
4000188c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001890: 91166c00     	add	x0, x0, #0x59b
40001894: 9400081d     	bl	0x40003908 <uart_puts>
40001898: b81fc3bf     	stur	wzr, [x29, #-0x4]
4000189c: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018a0: 6b13011f     	cmp	w8, w19
400018a4: 540000aa     	b.ge	0x400018b8 <kmain+0x54>
400018a8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018ac: 11000508     	add	w8, w8, #0x1
400018b0: b81fc3a8     	stur	w8, [x29, #-0x4]
400018b4: 17fffffa     	b	0x4000189c <kmain+0x38>
400018b8: 528aa214     	mov	w20, #0x5510            // =21776
400018bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018c0: 910dc400     	add	x0, x0, #0x371
400018c4: 72a00454     	movk	w20, #0x22, lsl #16
400018c8: 94000810     	bl	0x40003908 <uart_puts>
400018cc: b81fc3bf     	stur	wzr, [x29, #-0x4]
400018d0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018d4: 6b14011f     	cmp	w8, w20
400018d8: 540000aa     	b.ge	0x400018ec <kmain+0x88>
400018dc: b85fc3a8     	ldur	w8, [x29, #-0x4]
400018e0: 11000508     	add	w8, w8, #0x1
400018e4: b81fc3a8     	stur	w8, [x29, #-0x4]
400018e8: 17fffffa     	b	0x400018d0 <kmain+0x6c>
400018ec: 5298d813     	mov	w19, #0xc6c0            // =50880
400018f0: 72a005b3     	movk	w19, #0x2d, lsl #16
400018f4: 94000b26     	bl	0x4000458c <vfs_init>
400018f8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400018fc: 911f6000     	add	x0, x0, #0x7d8
40001900: 94000802     	bl	0x40003908 <uart_puts>
40001904: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001908: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000190c: 6b13011f     	cmp	w8, w19
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
40001938: 940007f4     	bl	0x40003908 <uart_puts>
4000193c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001940: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001944: 6b14011f     	cmp	w8, w20
40001948: 540000aa     	b.ge	0x4000195c <kmain+0xf8>
4000194c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001950: 11000508     	add	w8, w8, #0x1
40001954: b81fc3a8     	stur	w8, [x29, #-0x4]
40001958: 17fffffa     	b	0x40001940 <kmain+0xdc>
4000195c: 97fffa25     	bl	0x400001f0 <gic_init>
40001960: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001964: 9115a800     	add	x0, x0, #0x56a
40001968: 940007e8     	bl	0x40003908 <uart_puts>
4000196c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001970: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001974: 6b14011f     	cmp	w8, w20
40001978: 540000aa     	b.ge	0x4000198c <kmain+0x128>
4000197c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001980: 11000508     	add	w8, w8, #0x1
40001984: b81fc3a8     	stur	w8, [x29, #-0x4]
40001988: 17fffffa     	b	0x40001970 <kmain+0x10c>
4000198c: 940004e9     	bl	0x40002d30 <timer_init>
40001990: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001994: 91233000     	add	x0, x0, #0x8cc
40001998: 940007dc     	bl	0x40003908 <uart_puts>
4000199c: b81fc3bf     	stur	wzr, [x29, #-0x4]
400019a0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019a4: 6b14011f     	cmp	w8, w20
400019a8: 540000aa     	b.ge	0x400019bc <kmain+0x158>
400019ac: b85fc3a8     	ldur	w8, [x29, #-0x4]
400019b0: 11000508     	add	w8, w8, #0x1
400019b4: b81fc3a8     	stur	w8, [x29, #-0x4]
400019b8: 17fffffa     	b	0x400019a0 <kmain+0x13c>
400019bc: 94000086     	bl	0x40001bd4 <pmm_init>
400019c0: 940000bd     	bl	0x40001cb4 <pmm_alloc_page>
400019c4: b4000160     	cbz	x0, 0x400019f0 <kmain+0x18c>
400019c8: aa0003f3     	mov	x19, x0
400019cc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400019d0: 91209400     	add	x0, x0, #0x825
400019d4: 2a1303e1     	mov	w1, w19
400019d8: 940008e1     	bl	0x40003d5c <uart_printf>
400019dc: aa1303e0     	mov	x0, x19
400019e0: 940000e6     	bl	0x40001d78 <pmm_free_page>
400019e4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400019e8: 9127e800     	add	x0, x0, #0x9fa
400019ec: 940007c7     	bl	0x40003908 <uart_puts>
400019f0: 9400010e     	bl	0x40001e28 <process_init>
400019f4: 94000255     	bl	0x40002348 <script_init>
400019f8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400019fc: 91023000     	add	x0, x0, #0x8c
40001a00: 940007c2     	bl	0x40003908 <uart_puts>
40001a04: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001a08: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a0c: 6b14011f     	cmp	w8, w20
40001a10: 540000aa     	b.ge	0x40001a24 <kmain+0x1c0>
40001a14: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001a18: 11000508     	add	w8, w8, #0x1
40001a1c: b81fc3a8     	stur	w8, [x29, #-0x4]
40001a20: 17fffffa     	b	0x40001a08 <kmain+0x1a4>
40001a24: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001a28: 5291b008     	mov	w8, #0x8d80             // =36224
40001a2c: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001a30: 72a00b68     	movk	w8, #0x5b, lsl #16
40001a34: 6b08013f     	cmp	w9, w8
40001a38: 540000ea     	b.ge	0x40001a54 <kmain+0x1f0>
40001a3c: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001a40: 11000529     	add	w9, w9, #0x1
40001a44: b81fc3a9     	stur	w9, [x29, #-0x4]
40001a48: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001a4c: 6b08013f     	cmp	w9, w8
40001a50: 54ffff6b     	b.lt	0x40001a3c <kmain+0x1d8>
40001a54: 97fffb92     	bl	0x4000089c <print_banner>
40001a58: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a5c: 91255800     	add	x0, x0, #0x956
40001a60: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001a64: 9139fc21     	add	x1, x1, #0xe7f
40001a68: 940008bd     	bl	0x40003d5c <uart_printf>
40001a6c: 97fffbd5     	bl	0x400009c0 <print_sysinfo>
40001a70: 97ffff20     	bl	0x400016f0 <kernel_shell>
40001a74: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001a78: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001a7c: 913fc800     	add	x0, x0, #0xff2
40001a80: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001a84: 9100c3ff     	add	sp, sp, #0x30
40001a88: 140007a0     	b	0x40003908 <uart_puts>

0000000040001a8c <kproj_execute>:
40001a8c: d10683ff     	sub	sp, sp, #0x1a0
40001a90: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001a94: 910603fd     	add	x29, sp, #0x180
40001a98: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001a9c: b40001c0     	cbz	x0, 0x40001ad4 <kproj_execute+0x48>
40001aa0: aa0003f3     	mov	x19, x0
40001aa4: 940003f0     	bl	0x40002a64 <kstrlen>
40001aa8: b4000160     	cbz	x0, 0x40001ad4 <kproj_execute+0x48>
40001aac: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ab0: 91294c00     	add	x0, x0, #0xa53
40001ab4: aa1303e1     	mov	x1, x19
40001ab8: 940008a9     	bl	0x40003d5c <uart_printf>
40001abc: aa1303e0     	mov	x0, x19
40001ac0: 94000cfa     	bl	0x40004ea8 <vfs_mkdir>
40001ac4: 34000140     	cbz	w0, 0x40001aec <kproj_execute+0x60>
40001ac8: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001acc: 911a5000     	add	x0, x0, #0x694
40001ad0: 14000003     	b	0x40001adc <kproj_execute+0x50>
40001ad4: d503201f     	nop
40001ad8: 1003bfc0     	adr	x0, 0x400092d0 <__rodata_start+0x22d0>
40001adc: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001ae0: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001ae4: 910683ff     	add	sp, sp, #0x1a0
40001ae8: 14000788     	b	0x40003908 <uart_puts>
40001aec: aa1303e0     	mov	x0, x19
40001af0: 94000cc9     	bl	0x40004e14 <vfs_chdir>
40001af4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001af8: 91037400     	add	x0, x0, #0xdd
40001afc: 94000ceb     	bl	0x40004ea8 <vfs_mkdir>
40001b00: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001b04: 911a7c00     	add	x0, x0, #0x69f
40001b08: 94000ce8     	bl	0x40004ea8 <vfs_mkdir>
40001b0c: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b10: 910a4021     	add	x1, x1, #0x290
40001b14: 910203e0     	add	x0, sp, #0x80
40001b18: 94000402     	bl	0x40002b20 <kstrcpy>
40001b1c: 910203e0     	add	x0, sp, #0x80
40001b20: aa1303e1     	mov	x1, x19
40001b24: 940003d7     	bl	0x40002a80 <kstrcat>
40001b28: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b2c: 913c4021     	add	x1, x1, #0xf10
40001b30: 910203e0     	add	x0, sp, #0x80
40001b34: 940003d3     	bl	0x40002a80 <kstrcat>
40001b38: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b3c: 9125fc00     	add	x0, x0, #0x97f
40001b40: 910203e1     	add	x1, sp, #0x80
40001b44: 94000d2f     	bl	0x40005000 <vfs_touch>
40001b48: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001b4c: 91006000     	add	x0, x0, #0x18
40001b50: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b54: 9130b821     	add	x1, x1, #0xc2e
40001b58: 94000d2a     	bl	0x40005000 <vfs_touch>
40001b5c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001b60: 91078421     	add	x1, x1, #0x1e1
40001b64: 910003e0     	mov	x0, sp
40001b68: 940003ee     	bl	0x40002b20 <kstrcpy>
40001b6c: 910003e0     	mov	x0, sp
40001b70: aa1303e1     	mov	x1, x19
40001b74: 940003c3     	bl	0x40002a80 <kstrcat>
40001b78: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b7c: 912c5821     	add	x1, x1, #0xb16
40001b80: 910003e0     	mov	x0, sp
40001b84: 940003bf     	bl	0x40002a80 <kstrcat>
40001b88: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001b8c: 913cf000     	add	x0, x0, #0xf3c
40001b90: 910003e1     	mov	x1, sp
40001b94: 94000d1b     	bl	0x40005000 <vfs_touch>
40001b98: 94000d19     	bl	0x40004ffc <vfs_sync>
40001b9c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ba0: 91142800     	add	x0, x0, #0x50a
40001ba4: 94000759     	bl	0x40003908 <uart_puts>
40001ba8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001bac: 9114e400     	add	x0, x0, #0x539
40001bb0: aa1303e1     	mov	x1, x19
40001bb4: 9400086a     	bl	0x40003d5c <uart_printf>
40001bb8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001bbc: 91038400     	add	x0, x0, #0xe1
40001bc0: 94000c95     	bl	0x40004e14 <vfs_chdir>
40001bc4: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001bc8: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001bcc: 910683ff     	add	sp, sp, #0x1a0
40001bd0: d65f03c0     	ret

0000000040001bd4 <pmm_init>:
40001bd4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40001bd8: a9014ff4     	stp	x20, x19, [sp, #0x10]
40001bdc: d503201f     	nop
40001be0: 100633b4     	adr	x20, 0x4000e254 <memory_bitmap>
40001be4: aa1403e0     	mov	x0, x20
40001be8: 2a1f03e1     	mov	w1, wzr
40001bec: 52820002     	mov	w2, #0x1000             // =4096
40001bf0: 910003fd     	mov	x29, sp
40001bf4: 940003f7     	bl	0x40002bd0 <memset>
40001bf8: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
40001bfc: d503201f     	nop
40001c00: 1024a008     	adr	x8, 0x4004b000 <__kernel_end>
40001c04: f2820009     	movk	x9, #0x1000
40001c08: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
40001c0c: f2402d1f     	tst	x8, #0xfff
40001c10: 8b090109     	add	x9, x8, x9
40001c14: 8b0a010a     	add	x10, x8, x10
40001c18: 9a890148     	csel	x8, x10, x9, eq
40001c1c: d34cfd13     	lsr	x19, x8, #12
40001c20: 340001b3     	cbz	w19, 0x40001c54 <pmm_init+0x80>
40001c24: 2a1f03e8     	mov	w8, wzr
40001c28: 52800029     	mov	w9, #0x1                // =1
40001c2c: 2a0803ea     	mov	w10, w8
40001c30: 1200090b     	and	w11, w8, #0x7
40001c34: 11000508     	add	w8, w8, #0x1
40001c38: d343fd4a     	lsr	x10, x10, #3
40001c3c: 1acb212b     	lsl	w11, w9, w11
40001c40: 6b08027f     	cmp	w19, w8
40001c44: 386a6a8c     	ldrb	w12, [x20, x10]
40001c48: 2a0b018b     	orr	w11, w12, w11
40001c4c: 382a6a8b     	strb	w11, [x20, x10]
40001c50: 54fffee1     	b.ne	0x40001c2c <pmm_init+0x58>
40001c54: 52900008     	mov	w8, #0x8000             // =32768
40001c58: b0000054     	adrp	x20, 0x4000a000 <free_pages>
40001c5c: d0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40001c60: 4b130108     	sub	w8, w8, w19
40001c64: d503201f     	nop
40001c68: 50039340     	adr	x0, 0x40008ed2 <__rodata_start+0x1ed2>
40001c6c: b9000288     	str	w8, [x20]
40001c70: b9025533     	str	w19, [x9, #0x254]
40001c74: 9400083a     	bl	0x40003d5c <uart_printf>
40001c78: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001c7c: 911b3400     	add	x0, x0, #0x6cd
40001c80: 52801001     	mov	w1, #0x80               // =128
40001c84: 94000836     	bl	0x40003d5c <uart_printf>
40001c88: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001c8c: 91073800     	add	x0, x0, #0x1ce
40001c90: 2a1303e1     	mov	w1, w19
40001c94: 94000832     	bl	0x40003d5c <uart_printf>
40001c98: b9400288     	ldr	w8, [x20]
40001c9c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40001ca0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ca4: 911b4400     	add	x0, x0, #0x6d1
40001ca8: 53084d01     	ubfx	w1, w8, #8, #12
40001cac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40001cb0: 1400082b     	b	0x40003d5c <uart_printf>

0000000040001cb4 <pmm_alloc_page>:
40001cb4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40001cb8: b0000048     	adrp	x8, 0x4000a000 <free_pages>
40001cbc: f9000bf3     	str	x19, [sp, #0x10]
40001cc0: 910003fd     	mov	x29, sp
40001cc4: b940010a     	ldr	w10, [x8]
40001cc8: 3400030a     	cbz	w10, 0x40001d28 <pmm_alloc_page+0x74>
40001ccc: d0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40001cd0: b942552b     	ldr	w11, [x9, #0x254]
40001cd4: 530f7d6c     	lsr	w12, w11, #15
40001cd8: 3500022c     	cbnz	w12, 0x40001d1c <pmm_alloc_page+0x68>
40001cdc: 52a8000c     	mov	w12, #0x40000000        // =1073741824
40001ce0: d503201f     	nop
40001ce4: 10062b8d     	adr	x13, 0x4000e254 <memory_bitmap>
40001ce8: 0b0b318c     	add	w12, w12, w11, lsl #12
40001cec: 5280002e     	mov	w14, #0x1               // =1
40001cf0: 2a0b03ef     	mov	w15, w11
40001cf4: 12000971     	and	w17, w11, #0x7
40001cf8: d343fdef     	lsr	x15, x15, #3
40001cfc: 1ad121d1     	lsl	w17, w14, w17
40001d00: 386f69b0     	ldrb	w16, [x13, x15]
40001d04: 6a10023f     	tst	w17, w16
40001d08: 540001e0     	b.eq	0x40001d44 <pmm_alloc_page+0x90>
40001d0c: 1100056b     	add	w11, w11, #0x1
40001d10: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
40001d14: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
40001d18: 54fffec1     	b.ne	0x40001cf0 <pmm_alloc_page+0x3c>
40001d1c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001d20: 9107a000     	add	x0, x0, #0x1e8
40001d24: 14000003     	b	0x40001d30 <pmm_alloc_page+0x7c>
40001d28: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001d2c: 911ba000     	add	x0, x0, #0x6e8
40001d30: 940006f6     	bl	0x40003908 <uart_puts>
40001d34: aa1f03e0     	mov	x0, xzr
40001d38: f9400bf3     	ldr	x19, [sp, #0x10]
40001d3c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40001d40: d65f03c0     	ret
40001d44: 2a0c03f3     	mov	w19, w12
40001d48: 5100054a     	sub	w10, w10, #0x1
40001d4c: 1100056b     	add	w11, w11, #0x1
40001d50: aa1303e0     	mov	x0, x19
40001d54: 2a1f03e1     	mov	w1, wzr
40001d58: 52820002     	mov	w2, #0x1000             // =4096
40001d5c: 2a11020e     	orr	w14, w16, w17
40001d60: 382f69ae     	strb	w14, [x13, x15]
40001d64: b900010a     	str	w10, [x8]
40001d68: b902552b     	str	w11, [x9, #0x254]
40001d6c: 94000399     	bl	0x40002bd0 <memset>
40001d70: aa1303e0     	mov	x0, x19
40001d74: 17fffff1     	b	0x40001d38 <pmm_alloc_page+0x84>

0000000040001d78 <pmm_free_page>:
40001d78: d35efc08     	lsr	x8, x0, #30
40001d7c: b4000128     	cbz	x8, 0x40001da0 <pmm_free_page+0x28>
40001d80: d35bfc08     	lsr	x8, x0, #27
40001d84: f100251f     	cmp	x8, #0x9
40001d88: 540000c2     	b.hs	0x40001da0 <pmm_free_page+0x28>
40001d8c: f2402c1f     	tst	x0, #0xfff
40001d90: 540000e0     	b.eq	0x40001dac <pmm_free_page+0x34>
40001d94: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001d98: 9120a800     	add	x0, x0, #0x82a
40001d9c: 140006db     	b	0x40003908 <uart_puts>
40001da0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001da4: 91039000     	add	x0, x0, #0xe4
40001da8: 140006d8     	b	0x40003908 <uart_puts>
40001dac: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
40001db0: d503201f     	nop
40001db4: 1006250a     	adr	x10, 0x4000e254 <memory_bitmap>
40001db8: 8b080009     	add	x9, x0, x8
40001dbc: 5280002d     	mov	w13, #0x1               // =1
40001dc0: d34fad28     	ubfx	x8, x9, #15, #29
40001dc4: d34c392c     	ubfx	x12, x9, #12, #3
40001dc8: 3868694b     	ldrb	w11, [x10, x8]
40001dcc: 1acc21ac     	lsl	w12, w13, w12
40001dd0: 6a0b019f     	tst	w12, w11
40001dd4: 540001c0     	b.eq	0x40001e0c <pmm_free_page+0x94>
40001dd8: b000004e     	adrp	x14, 0x4000a000 <free_pages>
40001ddc: d000006d     	adrp	x13, 0x4000f000 <memory_bitmap+0xdac>
40001de0: d34cfd29     	lsr	x9, x9, #12
40001de4: b94001cf     	ldr	w15, [x14]
40001de8: b94255b0     	ldr	w16, [x13, #0x254]
40001dec: 0a2c016b     	bic	w11, w11, w12
40001df0: 3828694b     	strb	w11, [x10, x8]
40001df4: 110005e8     	add	w8, w15, #0x1
40001df8: 6b09021f     	cmp	w16, w9
40001dfc: b90001c8     	str	w8, [x14]
40001e00: 54000049     	b.ls	0x40001e08 <pmm_free_page+0x90>
40001e04: b90255a9     	str	w9, [x13, #0x254]
40001e08: d65f03c0     	ret
40001e0c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001e10: 91291400     	add	x0, x0, #0xa45
40001e14: 140006bd     	b	0x40003908 <uart_puts>

0000000040001e18 <pmm_get_free_memory>:
40001e18: b0000048     	adrp	x8, 0x4000a000 <free_pages>
40001e1c: b9400108     	ldr	w8, [x8]
40001e20: 53144d00     	lsl	w0, w8, #12
40001e24: d65f03c0     	ret

0000000040001e28 <process_init>:
40001e28: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001e2c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001e30: b0000054     	adrp	x20, 0x4000a000 <free_pages>
40001e34: d503201f     	nop
40001e38: 1006a113     	adr	x19, 0x4000f258 <proc_table>
40001e3c: b9400689     	ldr	w9, [x20, #0x4]
40001e40: 52800068     	mov	w8, #0x3                // =3
40001e44: b9002668     	str	w8, [x19, #0x24]
40001e48: d503201f     	nop
40001e4c: 30035661     	adr	x1, 0x40008919 <__rodata_start+0x1919>
40001e50: b9005668     	str	w8, [x19, #0x54]
40001e54: 91001260     	add	x0, x19, #0x4
40001e58: 910003fd     	mov	x29, sp
40001e5c: b9008668     	str	w8, [x19, #0x84]
40001e60: b900b668     	str	w8, [x19, #0xb4]
40001e64: b900e668     	str	w8, [x19, #0xe4]
40001e68: b9011668     	str	w8, [x19, #0x114]
40001e6c: b9014668     	str	w8, [x19, #0x144]
40001e70: b9017668     	str	w8, [x19, #0x174]
40001e74: b901a668     	str	w8, [x19, #0x1a4]
40001e78: b901d668     	str	w8, [x19, #0x1d4]
40001e7c: b9020668     	str	w8, [x19, #0x204]
40001e80: b9023668     	str	w8, [x19, #0x234]
40001e84: b9026668     	str	w8, [x19, #0x264]
40001e88: b9029668     	str	w8, [x19, #0x294]
40001e8c: b902c668     	str	w8, [x19, #0x2c4]
40001e90: b902f668     	str	w8, [x19, #0x2f4]
40001e94: 11000528     	add	w8, w9, #0x1
40001e98: f9000bf5     	str	x21, [sp, #0x10]
40001e9c: b900327f     	str	wzr, [x19, #0x30]
40001ea0: b900627f     	str	wzr, [x19, #0x60]
40001ea4: b900927f     	str	wzr, [x19, #0x90]
40001ea8: b900c27f     	str	wzr, [x19, #0xc0]
40001eac: b900f27f     	str	wzr, [x19, #0xf0]
40001eb0: b901227f     	str	wzr, [x19, #0x120]
40001eb4: b901527f     	str	wzr, [x19, #0x150]
40001eb8: b901827f     	str	wzr, [x19, #0x180]
40001ebc: b901b27f     	str	wzr, [x19, #0x1b0]
40001ec0: b901e27f     	str	wzr, [x19, #0x1e0]
40001ec4: b902127f     	str	wzr, [x19, #0x210]
40001ec8: b902427f     	str	wzr, [x19, #0x240]
40001ecc: b902727f     	str	wzr, [x19, #0x270]
40001ed0: b902a27f     	str	wzr, [x19, #0x2a0]
40001ed4: b902d27f     	str	wzr, [x19, #0x2d0]
40001ed8: b9000688     	str	w8, [x20, #0x4]
40001edc: b9000269     	str	w9, [x19]
40001ee0: 94000310     	bl	0x40002b20 <kstrcpy>
40001ee4: b9400688     	ldr	w8, [x20, #0x4]
40001ee8: 52a00209     	mov	w9, #0x100000           // =1048576
40001eec: 5280384a     	mov	w10, #0x1c2             // =450
40001ef0: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001ef4: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001ef8: 911b9021     	add	x1, x1, #0x6e4
40001efc: 11000509     	add	w9, w8, #0x1
40001f00: 9100d260     	add	x0, x19, #0x34
40001f04: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001f08: b9000689     	str	w9, [x20, #0x4]
40001f0c: 94000305     	bl	0x40002b20 <kstrcpy>
40001f10: b9400688     	ldr	w8, [x20, #0x4]
40001f14: 529d0009     	mov	w9, #0xe800             // =59392
40001f18: 52800035     	mov	w21, #0x1               // =1
40001f1c: 72a00069     	movk	w9, #0x3, lsl #16
40001f20: 5280018a     	mov	w10, #0xc               // =12
40001f24: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001f28: 912ce021     	add	x1, x1, #0xb38
40001f2c: 290aa675     	stp	w21, w9, [x19, #0x54]
40001f30: 11000509     	add	w9, w8, #0x1
40001f34: 91019260     	add	x0, x19, #0x64
40001f38: b9000689     	str	w9, [x20, #0x4]
40001f3c: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001f40: 940002f8     	bl	0x40002b20 <kstrcpy>
40001f44: b9400688     	ldr	w8, [x20, #0x4]
40001f48: 52a00809     	mov	w9, #0x400000           // =4194304
40001f4c: 5280960a     	mov	w10, #0x4b0             // =1200
40001f50: 2910a675     	stp	w21, w9, [x19, #0x84]
40001f54: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001f58: 910e8421     	add	x1, x1, #0x3a1
40001f5c: 11000509     	add	w9, w8, #0x1
40001f60: 91025260     	add	x0, x19, #0x94
40001f64: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001f68: b9000689     	str	w9, [x20, #0x4]
40001f6c: 940002ed     	bl	0x40002b20 <kstrcpy>
40001f70: 529a0008     	mov	w8, #0xd000             // =53248
40001f74: 52800aa9     	mov	w9, #0x55               // =85
40001f78: f9400bf5     	ldr	x21, [sp, #0x10]
40001f7c: 72a000e8     	movk	w8, #0x7, lsl #16
40001f80: b900be69     	str	w9, [x19, #0xbc]
40001f84: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001f88: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001f8c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001f90: d65f03c0     	ret

0000000040001f94 <process_kill>:
40001f94: 7100041f     	cmp	w0, #0x1
40001f98: 5400118b     	b.lt	0x400021c8 <process_kill+0x234>
40001f9c: d503201f     	nop
40001fa0: 100695c9     	adr	x9, 0x4000f258 <proc_table>
40001fa4: b9400128     	ldr	w8, [x9]
40001fa8: 6b00011f     	cmp	w8, w0
40001fac: 54000081     	b.ne	0x40001fbc <process_kill+0x28>
40001fb0: b9402528     	ldr	w8, [x9, #0x24]
40001fb4: 71000d1f     	cmp	w8, #0x3
40001fb8: 54000f41     	b.ne	0x400021a0 <process_kill+0x20c>
40001fbc: d0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40001fc0: 910a2129     	add	x9, x9, #0x288
40001fc4: b9400128     	ldr	w8, [x9]
40001fc8: 6b00011f     	cmp	w8, w0
40001fcc: 54000081     	b.ne	0x40001fdc <process_kill+0x48>
40001fd0: b9402528     	ldr	w8, [x9, #0x24]
40001fd4: 71000d1f     	cmp	w8, #0x3
40001fd8: 54000e41     	b.ne	0x400021a0 <process_kill+0x20c>
40001fdc: d0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40001fe0: 910ae129     	add	x9, x9, #0x2b8
40001fe4: b9400128     	ldr	w8, [x9]
40001fe8: 6b00011f     	cmp	w8, w0
40001fec: 54000081     	b.ne	0x40001ffc <process_kill+0x68>
40001ff0: b9402528     	ldr	w8, [x9, #0x24]
40001ff4: 71000d1f     	cmp	w8, #0x3
40001ff8: 54000d41     	b.ne	0x400021a0 <process_kill+0x20c>
40001ffc: d0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002000: 910ba129     	add	x9, x9, #0x2e8
40002004: b9400128     	ldr	w8, [x9]
40002008: 6b00011f     	cmp	w8, w0
4000200c: 54000081     	b.ne	0x4000201c <process_kill+0x88>
40002010: b9402528     	ldr	w8, [x9, #0x24]
40002014: 71000d1f     	cmp	w8, #0x3
40002018: 54000c41     	b.ne	0x400021a0 <process_kill+0x20c>
4000201c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002020: 910c6129     	add	x9, x9, #0x318
40002024: b9400128     	ldr	w8, [x9]
40002028: 6b00011f     	cmp	w8, w0
4000202c: 54000081     	b.ne	0x4000203c <process_kill+0xa8>
40002030: b9402528     	ldr	w8, [x9, #0x24]
40002034: 71000d1f     	cmp	w8, #0x3
40002038: 54000b41     	b.ne	0x400021a0 <process_kill+0x20c>
4000203c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002040: 910d2129     	add	x9, x9, #0x348
40002044: b9400128     	ldr	w8, [x9]
40002048: 6b00011f     	cmp	w8, w0
4000204c: 54000081     	b.ne	0x4000205c <process_kill+0xc8>
40002050: b9402528     	ldr	w8, [x9, #0x24]
40002054: 71000d1f     	cmp	w8, #0x3
40002058: 54000a41     	b.ne	0x400021a0 <process_kill+0x20c>
4000205c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002060: 910de129     	add	x9, x9, #0x378
40002064: b9400128     	ldr	w8, [x9]
40002068: 6b00011f     	cmp	w8, w0
4000206c: 54000081     	b.ne	0x4000207c <process_kill+0xe8>
40002070: b9402528     	ldr	w8, [x9, #0x24]
40002074: 71000d1f     	cmp	w8, #0x3
40002078: 54000941     	b.ne	0x400021a0 <process_kill+0x20c>
4000207c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002080: 910ea129     	add	x9, x9, #0x3a8
40002084: b9400128     	ldr	w8, [x9]
40002088: 6b00011f     	cmp	w8, w0
4000208c: 54000081     	b.ne	0x4000209c <process_kill+0x108>
40002090: b9402528     	ldr	w8, [x9, #0x24]
40002094: 71000d1f     	cmp	w8, #0x3
40002098: 54000841     	b.ne	0x400021a0 <process_kill+0x20c>
4000209c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
400020a0: 910f6129     	add	x9, x9, #0x3d8
400020a4: b9400128     	ldr	w8, [x9]
400020a8: 6b00011f     	cmp	w8, w0
400020ac: 54000081     	b.ne	0x400020bc <process_kill+0x128>
400020b0: b9402528     	ldr	w8, [x9, #0x24]
400020b4: 71000d1f     	cmp	w8, #0x3
400020b8: 54000741     	b.ne	0x400021a0 <process_kill+0x20c>
400020bc: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
400020c0: 91102129     	add	x9, x9, #0x408
400020c4: b9400128     	ldr	w8, [x9]
400020c8: 6b00011f     	cmp	w8, w0
400020cc: 54000081     	b.ne	0x400020dc <process_kill+0x148>
400020d0: b9402528     	ldr	w8, [x9, #0x24]
400020d4: 71000d1f     	cmp	w8, #0x3
400020d8: 54000641     	b.ne	0x400021a0 <process_kill+0x20c>
400020dc: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
400020e0: 9110e129     	add	x9, x9, #0x438
400020e4: b9400128     	ldr	w8, [x9]
400020e8: 6b00011f     	cmp	w8, w0
400020ec: 54000081     	b.ne	0x400020fc <process_kill+0x168>
400020f0: b9402528     	ldr	w8, [x9, #0x24]
400020f4: 71000d1f     	cmp	w8, #0x3
400020f8: 54000541     	b.ne	0x400021a0 <process_kill+0x20c>
400020fc: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002100: 9111a129     	add	x9, x9, #0x468
40002104: b9400128     	ldr	w8, [x9]
40002108: 6b00011f     	cmp	w8, w0
4000210c: 54000081     	b.ne	0x4000211c <process_kill+0x188>
40002110: b9402528     	ldr	w8, [x9, #0x24]
40002114: 71000d1f     	cmp	w8, #0x3
40002118: 54000441     	b.ne	0x400021a0 <process_kill+0x20c>
4000211c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002120: 91126129     	add	x9, x9, #0x498
40002124: b9400128     	ldr	w8, [x9]
40002128: 6b00011f     	cmp	w8, w0
4000212c: 54000081     	b.ne	0x4000213c <process_kill+0x1a8>
40002130: b9402528     	ldr	w8, [x9, #0x24]
40002134: 71000d1f     	cmp	w8, #0x3
40002138: 54000341     	b.ne	0x400021a0 <process_kill+0x20c>
4000213c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002140: 91132129     	add	x9, x9, #0x4c8
40002144: b9400128     	ldr	w8, [x9]
40002148: 6b00011f     	cmp	w8, w0
4000214c: 54000081     	b.ne	0x4000215c <process_kill+0x1c8>
40002150: b9402528     	ldr	w8, [x9, #0x24]
40002154: 71000d1f     	cmp	w8, #0x3
40002158: 54000241     	b.ne	0x400021a0 <process_kill+0x20c>
4000215c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002160: 9113e129     	add	x9, x9, #0x4f8
40002164: b9400128     	ldr	w8, [x9]
40002168: 6b00011f     	cmp	w8, w0
4000216c: 54000081     	b.ne	0x4000217c <process_kill+0x1e8>
40002170: b9402528     	ldr	w8, [x9, #0x24]
40002174: 71000d1f     	cmp	w8, #0x3
40002178: 54000141     	b.ne	0x400021a0 <process_kill+0x20c>
4000217c: b0000069     	adrp	x9, 0x4000f000 <memory_bitmap+0xdac>
40002180: 9114a129     	add	x9, x9, #0x528
40002184: b9400128     	ldr	w8, [x9]
40002188: 6b00011f     	cmp	w8, w0
4000218c: 12800008     	mov	w8, #-0x1               // =-1
40002190: 54000281     	b.ne	0x400021e0 <process_kill+0x24c>
40002194: b940252a     	ldr	w10, [x9, #0x24]
40002198: 71000d5f     	cmp	w10, #0x3
4000219c: 54000220     	b.eq	0x400021e0 <process_kill+0x24c>
400021a0: 7100041f     	cmp	w0, #0x1
400021a4: 54000161     	b.ne	0x400021d0 <process_kill+0x23c>
400021a8: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400021ac: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
400021b0: 912a1000     	add	x0, x0, #0xa84
400021b4: 910003fd     	mov	x29, sp
400021b8: 940005d4     	bl	0x40003908 <uart_puts>
400021bc: 12800020     	mov	w0, #-0x2               // =-2
400021c0: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400021c4: d65f03c0     	ret
400021c8: 12800000     	mov	w0, #-0x1               // =-1
400021cc: d65f03c0     	ret
400021d0: 5280004a     	mov	w10, #0x2               // =2
400021d4: 2a1f03e0     	mov	w0, wzr
400021d8: b900252a     	str	w10, [x9, #0x24]
400021dc: d65f03c0     	ret
400021e0: 2a0803e0     	mov	w0, w8
400021e4: d65f03c0     	ret

00000000400021e8 <launch_ktop>:
400021e8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400021ec: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
400021f0: 91217000     	add	x0, x0, #0x85c
400021f4: f9000bf7     	str	x23, [sp, #0x10]
400021f8: a90257f6     	stp	x22, x21, [sp, #0x20]
400021fc: 910003fd     	mov	x29, sp
40002200: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002204: 940005c1     	bl	0x40003908 <uart_puts>
40002208: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000220c: 91217400     	add	x0, x0, #0x85d
40002210: 940005be     	bl	0x40003908 <uart_puts>
40002214: 2a1f03e8     	mov	w8, wzr
40002218: 2a1f03e1     	mov	w1, wzr
4000221c: 52800209     	mov	w9, #0x10               // =16
40002220: b000006a     	adrp	x10, 0x4000f000 <memory_bitmap+0xdac>
40002224: 910a014a     	add	x10, x10, #0x280
40002228: 14000004     	b	0x40002238 <launch_ktop+0x50>
4000222c: f1000529     	subs	x9, x9, #0x1
40002230: 9100c14a     	add	x10, x10, #0x30
40002234: 54000120     	b.eq	0x40002258 <launch_ktop+0x70>
40002238: b85fc14b     	ldur	w11, [x10, #-0x4]
4000223c: 121f796b     	and	w11, w11, #0xfffffffe
40002240: 7100097f     	cmp	w11, #0x2
40002244: 54ffff40     	b.eq	0x4000222c <launch_ktop+0x44>
40002248: b940014b     	ldr	w11, [x10]
4000224c: 11000421     	add	w1, w1, #0x1
40002250: 0b080168     	add	w8, w11, w8
40002254: 17fffff6     	b	0x4000222c <launch_ktop+0x44>
40002258: 530a7d02     	lsr	w2, w8, #10
4000225c: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002260: 912d0800     	add	x0, x0, #0xb42
40002264: 940006be     	bl	0x40003d5c <uart_printf>
40002268: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000226c: 91313800     	add	x0, x0, #0xc4e
40002270: 940005a6     	bl	0x40003908 <uart_puts>
40002274: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002278: 91356000     	add	x0, x0, #0xd58
4000227c: 940005a3     	bl	0x40003908 <uart_puts>
40002280: b0000074     	adrp	x20, 0x4000f000 <memory_bitmap+0xdac>
40002284: 910a1294     	add	x20, x20, #0x284
40002288: d0000035     	adrp	x21, 0x40008000 <__rodata_start+0x1000>
4000228c: 913bf2b5     	add	x21, x21, #0xefc
40002290: d503201f     	nop
40002294: 1003a376     	adr	x22, 0x40009700 <__rodata_start+0x2700>
40002298: 52800217     	mov	w23, #0x10              // =16
4000229c: d0000033     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
400022a0: 9114f273     	add	x19, x19, #0x53c
400022a4: 1400000a     	b	0x400022cc <launch_ktop+0xe4>
400022a8: 297f9288     	ldp	w8, w4, [x20, #-0x4]
400022ac: b85d4281     	ldur	w1, [x20, #-0x2c]
400022b0: d100a285     	sub	x5, x20, #0x28
400022b4: aa1303e0     	mov	x0, x19
400022b8: 530a7d03     	lsr	w3, w8, #10
400022bc: 940006a8     	bl	0x40003d5c <uart_printf>
400022c0: f10006f7     	subs	x23, x23, #0x1
400022c4: 9100c294     	add	x20, x20, #0x30
400022c8: 54000120     	b.eq	0x400022ec <launch_ktop+0x104>
400022cc: b85f8288     	ldur	w8, [x20, #-0x8]
400022d0: 71000d1f     	cmp	w8, #0x3
400022d4: 54ffff60     	b.eq	0x400022c0 <launch_ktop+0xd8>
400022d8: 7100091f     	cmp	w8, #0x2
400022dc: aa1503e2     	mov	x2, x21
400022e0: 54fffe48     	b.hi	0x400022a8 <launch_ktop+0xc0>
400022e4: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
400022e8: 17fffff0     	b	0x400022a8 <launch_ktop+0xc0>
400022ec: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400022f0: 91079000     	add	x0, x0, #0x1e4
400022f4: 94000585     	bl	0x40003908 <uart_puts>
400022f8: 52808114     	mov	w20, #0x408             // =1032
400022fc: 52800033     	mov	w19, #0x1               // =1
40002300: 72a02014     	movk	w20, #0x100, lsl #16
40002304: 14000003     	b	0x40002310 <launch_ktop+0x128>
40002308: 7101c51f     	cmp	w8, #0x71
4000230c: 54000100     	b.eq	0x4000232c <launch_ktop+0x144>
40002310: 940005b2     	bl	0x400039d8 <uart_getc>
40002314: 12001c08     	and	w8, w0, #0xff
40002318: 7100611f     	cmp	w8, #0x18
4000231c: 54ffff68     	b.hi	0x40002308 <launch_ktop+0x120>
40002320: 1ac82269     	lsl	w9, w19, w8
40002324: 6a14013f     	tst	w9, w20
40002328: 54ffff00     	b.eq	0x40002308 <launch_ktop+0x120>
4000232c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002330: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002334: 912dd400     	add	x0, x0, #0xb75
40002338: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000233c: f9400bf7     	ldr	x23, [sp, #0x10]
40002340: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002344: 14000571     	b	0x40003908 <uart_puts>

0000000040002348 <script_init>:
40002348: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000234c: b0000068     	adrp	x8, 0x4000f000 <memory_bitmap+0xdac>
40002350: d503201f     	nop
40002354: 1002c9c0     	adr	x0, 0x40007c8c <__rodata_start+0xc8c>
40002358: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000235c: 91299421     	add	x1, x1, #0xa65
40002360: 910003fd     	mov	x29, sp
40002364: b905591f     	str	wzr, [x8, #0x558]
40002368: 94000007     	bl	0x40002384 <script_set_var>
4000236c: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002370: 91337c00     	add	x0, x0, #0xcdf
40002374: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40002378: 911a9421     	add	x1, x1, #0x6a5
4000237c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002380: 14000001     	b	0x40002384 <script_set_var>

0000000040002384 <script_set_var>:
40002384: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002388: a9015ff8     	stp	x24, x23, [sp, #0x10]
4000238c: b0000077     	adrp	x23, 0x4000f000 <memory_bitmap+0xdac>
40002390: 910003fd     	mov	x29, sp
40002394: b9455ae8     	ldr	w8, [x23, #0x558]
40002398: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000239c: aa0103f3     	mov	x19, x1
400023a0: aa0003f4     	mov	x20, x0
400023a4: a90257f6     	stp	x22, x21, [sp, #0x20]
400023a8: 7100051f     	cmp	w8, #0x1
400023ac: 5400024b     	b.lt	0x400023f4 <script_set_var+0x70>
400023b0: aa1f03f8     	mov	x24, xzr
400023b4: b0000075     	adrp	x21, 0x4000f000 <memory_bitmap+0xdac>
400023b8: 912572b5     	add	x21, x21, #0x95c
400023bc: b0000076     	adrp	x22, 0x4000f000 <memory_bitmap+0xdac>
400023c0: 911572d6     	add	x22, x22, #0x55c
400023c4: aa1603e0     	mov	x0, x22
400023c8: aa1403e1     	mov	x1, x20
400023cc: 940001b6     	bl	0x40002aa4 <kstrcmp>
400023d0: 340003e0     	cbz	w0, 0x4000244c <script_set_var+0xc8>
400023d4: b9855ae8     	ldrsw	x8, [x23, #0x558]
400023d8: 91000718     	add	x24, x24, #0x1
400023dc: 910202b5     	add	x21, x21, #0x80
400023e0: 910082d6     	add	x22, x22, #0x20
400023e4: eb08031f     	cmp	x24, x8
400023e8: 54fffeeb     	b.lt	0x400023c4 <script_set_var+0x40>
400023ec: 71007d1f     	cmp	w8, #0x1f
400023f0: 5400038c     	b.gt	0x40002460 <script_set_var+0xdc>
400023f4: b0000075     	adrp	x21, 0x4000f000 <memory_bitmap+0xdac>
400023f8: 911572b5     	add	x21, x21, #0x55c
400023fc: aa1403e1     	mov	x1, x20
40002400: 93407d08     	sxtw	x8, w8
40002404: 528003e2     	mov	w2, #0x1f               // =31
40002408: 8b0816a0     	add	x0, x21, x8, lsl #5
4000240c: 940001cc     	bl	0x40002b3c <kstrncpy>
40002410: b9855ae8     	ldrsw	x8, [x23, #0x558]
40002414: b0000074     	adrp	x20, 0x4000f000 <memory_bitmap+0xdac>
40002418: 91257294     	add	x20, x20, #0x95c
4000241c: aa1303e1     	mov	x1, x19
40002420: 52800fe2     	mov	w2, #0x7f               // =127
40002424: 8b0816a9     	add	x9, x21, x8, lsl #5
40002428: 8b081e80     	add	x0, x20, x8, lsl #7
4000242c: 39007d3f     	strb	wzr, [x9, #0x1f]
40002430: 940001c3     	bl	0x40002b3c <kstrncpy>
40002434: b9855ae8     	ldrsw	x8, [x23, #0x558]
40002438: 8b081e89     	add	x9, x20, x8, lsl #7
4000243c: 11000508     	add	w8, w8, #0x1
40002440: b9055ae8     	str	w8, [x23, #0x558]
40002444: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002448: 14000006     	b	0x40002460 <script_set_var+0xdc>
4000244c: aa1503e0     	mov	x0, x21
40002450: aa1303e1     	mov	x1, x19
40002454: 52800fe2     	mov	w2, #0x7f               // =127
40002458: 940001b9     	bl	0x40002b3c <kstrncpy>
4000245c: 3901febf     	strb	wzr, [x21, #0x7f]
40002460: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002464: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002468: a9415ff8     	ldp	x24, x23, [sp, #0x10]
4000246c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002470: d65f03c0     	ret

0000000040002474 <script_get_var>:
40002474: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002478: a90257f6     	stp	x22, x21, [sp, #0x20]
4000247c: b0000076     	adrp	x22, 0x4000f000 <memory_bitmap+0xdac>
40002480: 910003fd     	mov	x29, sp
40002484: b9455ac8     	ldr	w8, [x22, #0x558]
40002488: a9015ff8     	stp	x24, x23, [sp, #0x10]
4000248c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002490: 7100051f     	cmp	w8, #0x1
40002494: 540002ab     	b.lt	0x400024e8 <script_get_var+0x74>
40002498: aa0003f4     	mov	x20, x0
4000249c: aa1f03f7     	mov	x23, xzr
400024a0: b0000073     	adrp	x19, 0x4000f000 <memory_bitmap+0xdac>
400024a4: 91257273     	add	x19, x19, #0x95c
400024a8: b0000075     	adrp	x21, 0x4000f000 <memory_bitmap+0xdac>
400024ac: 911572b5     	add	x21, x21, #0x55c
400024b0: b0000038     	adrp	x24, 0x40007000 <__rodata_start>
400024b4: 91261f18     	add	x24, x24, #0x987
400024b8: aa1503e0     	mov	x0, x21
400024bc: aa1403e1     	mov	x1, x20
400024c0: 94000179     	bl	0x40002aa4 <kstrcmp>
400024c4: 34000160     	cbz	w0, 0x400024f0 <script_get_var+0x7c>
400024c8: b9855ac8     	ldrsw	x8, [x22, #0x558]
400024cc: 910006f7     	add	x23, x23, #0x1
400024d0: 91020273     	add	x19, x19, #0x80
400024d4: 910082b5     	add	x21, x21, #0x20
400024d8: eb0802ff     	cmp	x23, x8
400024dc: 54fffeeb     	b.lt	0x400024b8 <script_get_var+0x44>
400024e0: aa1803f3     	mov	x19, x24
400024e4: 14000003     	b	0x400024f0 <script_get_var+0x7c>
400024e8: b0000033     	adrp	x19, 0x40007000 <__rodata_start>
400024ec: 91261e73     	add	x19, x19, #0x987
400024f0: aa1303e0     	mov	x0, x19
400024f4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400024f8: a94257f6     	ldp	x22, x21, [sp, #0x20]
400024fc: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002500: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002504: d65f03c0     	ret

0000000040002508 <script_expand_vars>:
40002508: d10203ff     	sub	sp, sp, #0x80
4000250c: a9036ffc     	stp	x28, x27, [sp, #0x30]
40002510: 2a1f03fc     	mov	w28, wzr
40002514: a90467fa     	stp	x26, x25, [sp, #0x40]
40002518: b0000039     	adrp	x25, 0x40007000 <__rodata_start>
4000251c: 91261f39     	add	x25, x25, #0x987
40002520: a9055ff8     	stp	x24, x23, [sp, #0x50]
40002524: 910003f8     	mov	x24, sp
40002528: b000007a     	adrp	x26, 0x4000f000 <memory_bitmap+0xdac>
4000252c: a90657f6     	stp	x22, x21, [sp, #0x60]
40002530: 2a1f03f6     	mov	w22, wzr
40002534: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002538: aa0103f3     	mov	x19, x1
4000253c: aa0003f4     	mov	x20, x0
40002540: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002544: 910083fd     	add	x29, sp, #0x20
40002548: 14000001     	b	0x4000254c <script_expand_vars+0x44>
4000254c: 93407f89     	sxtw	x9, w28
40002550: 38696a88     	ldrb	w8, [x20, x9]
40002554: 7100911f     	cmp	w8, #0x24
40002558: 540000e0     	b.eq	0x40002574 <script_expand_vars+0x6c>
4000255c: 34000788     	cbz	w8, 0x4000264c <script_expand_vars+0x144>
40002560: 110006ca     	add	w10, w22, #0x1
40002564: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002568: 1100053c     	add	w28, w9, #0x1
4000256c: 2a0a03f6     	mov	w22, w10
40002570: 17fffff7     	b	0x4000254c <script_expand_vars+0x44>
40002574: aa1f03e8     	mov	x8, xzr
40002578: 14000005     	b	0x4000258c <script_expand_vars+0x84>
4000257c: 9100050a     	add	x10, x8, #0x1
40002580: 38286b09     	strb	w9, [x24, x8]
40002584: d1000789     	sub	x9, x28, #0x1
40002588: aa0a03e8     	mov	x8, x10
4000258c: 9100053c     	add	x28, x9, #0x1
40002590: 14000004     	b	0x400025a0 <script_expand_vars+0x98>
40002594: f100791f     	cmp	x8, #0x1e
40002598: 9100079c     	add	x28, x28, #0x1
4000259c: 54ffff09     	b.ls	0x4000257c <script_expand_vars+0x74>
400025a0: 387c6a89     	ldrb	w9, [x20, x28]
400025a4: 121a792a     	and	w10, w9, #0xffffffdf
400025a8: 5101054a     	sub	w10, w10, #0x41
400025ac: 7100695f     	cmp	w10, #0x1a
400025b0: 54ffff23     	b.lo	0x40002594 <script_expand_vars+0x8c>
400025b4: 71017d3f     	cmp	w9, #0x5f
400025b8: 54fffee0     	b.eq	0x40002594 <script_expand_vars+0x8c>
400025bc: 5100c12a     	sub	w10, w9, #0x30
400025c0: 7100255f     	cmp	w10, #0x9
400025c4: 54fffe89     	b.ls	0x40002594 <script_expand_vars+0x8c>
400025c8: b9455b49     	ldr	w9, [x26, #0x558]
400025cc: 38286b1f     	strb	wzr, [x24, x8]
400025d0: 7100053f     	cmp	w9, #0x1
400025d4: 5400028b     	b.lt	0x40002624 <script_expand_vars+0x11c>
400025d8: aa1f03fb     	mov	x27, xzr
400025dc: b0000075     	adrp	x21, 0x4000f000 <memory_bitmap+0xdac>
400025e0: 911572b5     	add	x21, x21, #0x55c
400025e4: b0000077     	adrp	x23, 0x4000f000 <memory_bitmap+0xdac>
400025e8: 912572f7     	add	x23, x23, #0x95c
400025ec: 910003e1     	mov	x1, sp
400025f0: aa1503e0     	mov	x0, x21
400025f4: 9400012c     	bl	0x40002aa4 <kstrcmp>
400025f8: 34000100     	cbz	w0, 0x40002618 <script_expand_vars+0x110>
400025fc: b9855b48     	ldrsw	x8, [x26, #0x558]
40002600: 9100077b     	add	x27, x27, #0x1
40002604: 910202f7     	add	x23, x23, #0x80
40002608: 910082b5     	add	x21, x21, #0x20
4000260c: eb08037f     	cmp	x27, x8
40002610: 54fffeeb     	b.lt	0x400025ec <script_expand_vars+0xe4>
40002614: aa1903f7     	mov	x23, x25
40002618: 394002e8     	ldrb	w8, [x23]
4000261c: 350000a8     	cbnz	w8, 0x40002630 <script_expand_vars+0x128>
40002620: 17ffffcb     	b	0x4000254c <script_expand_vars+0x44>
40002624: aa1903f7     	mov	x23, x25
40002628: 394002e8     	ldrb	w8, [x23]
4000262c: 34fff908     	cbz	w8, 0x4000254c <script_expand_vars+0x44>
40002630: 8b36c269     	add	x9, x19, w22, sxtw
40002634: 910006ea     	add	x10, x23, #0x1
40002638: 38001528     	strb	w8, [x9], #0x1
4000263c: 110006d6     	add	w22, w22, #0x1
40002640: 38401548     	ldrb	w8, [x10], #0x1
40002644: 35ffffa8     	cbnz	w8, 0x40002638 <script_expand_vars+0x130>
40002648: 17ffffc1     	b	0x4000254c <script_expand_vars+0x44>
4000264c: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
40002650: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002654: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002658: a9455ff8     	ldp	x24, x23, [sp, #0x50]
4000265c: a94467fa     	ldp	x26, x25, [sp, #0x40]
40002660: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002664: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002668: 910203ff     	add	sp, sp, #0x80
4000266c: d65f03c0     	ret

0000000040002670 <script_execute_line>:
40002670: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002674: a9014ffc     	stp	x28, x19, [sp, #0x10]
40002678: 910003fd     	mov	x29, sp
4000267c: d10803ff     	sub	sp, sp, #0x200
40002680: 14000004     	b	0x40002690 <script_execute_line+0x20>
40002684: 7100811f     	cmp	w8, #0x20
40002688: 54000121     	b.ne	0x400026ac <script_execute_line+0x3c>
4000268c: 91000400     	add	x0, x0, #0x1
40002690: 39400008     	ldrb	w8, [x0]
40002694: 71007d1f     	cmp	w8, #0x1f
40002698: 54ffff6c     	b.gt	0x40002684 <script_execute_line+0x14>
4000269c: 7100251f     	cmp	w8, #0x9
400026a0: 54ffff60     	b.eq	0x4000268c <script_execute_line+0x1c>
400026a4: 34001668     	cbz	w8, 0x40002970 <script_execute_line+0x300>
400026a8: 14000003     	b	0x400026b4 <script_execute_line+0x44>
400026ac: 71008d1f     	cmp	w8, #0x23
400026b0: 54001600     	b.eq	0x40002970 <script_execute_line+0x300>
400026b4: 910403e1     	add	x1, sp, #0x100
400026b8: 910403f3     	add	x19, sp, #0x100
400026bc: 97ffff93     	bl	0x40002508 <script_expand_vars>
400026c0: 394403e9     	ldrb	w9, [sp, #0x100]
400026c4: 34001529     	cbz	w9, 0x40002968 <script_execute_line+0x2f8>
400026c8: 394407e8     	ldrb	w8, [sp, #0x101]
400026cc: aa1f03ea     	mov	x10, xzr
400026d0: 2a0903eb     	mov	w11, w9
400026d4: 14000004     	b	0x400026e4 <script_execute_line+0x74>
400026d8: 9100054a     	add	x10, x10, #0x1
400026dc: 386a6a6b     	ldrb	w11, [x19, x10]
400026e0: 340003cb     	cbz	w11, 0x40002758 <script_execute_line+0xe8>
400026e4: b4ffffaa     	cbz	x10, 0x400026d8 <script_execute_line+0x68>
400026e8: 7100f57f     	cmp	w11, #0x3d
400026ec: 54ffff61     	b.ne	0x400026d8 <script_execute_line+0x68>
400026f0: 8b13014b     	add	x11, x10, x19
400026f4: 385ff16c     	ldurb	w12, [x11, #-0x1]
400026f8: 7100f59f     	cmp	w12, #0x3d
400026fc: 54fffee0     	b.eq	0x400026d8 <script_execute_line+0x68>
40002700: 3940056b     	ldrb	w11, [x11, #0x1]
40002704: 7100f57f     	cmp	w11, #0x3d
40002708: 54fffe80     	b.eq	0x400026d8 <script_execute_line+0x68>
4000270c: aa1f03ec     	mov	x12, xzr
40002710: 2a1f03eb     	mov	w11, wzr
40002714: 386c6a6d     	ldrb	w13, [x19, x12]
40002718: 9100058c     	add	x12, x12, #0x1
4000271c: 710081bf     	cmp	w13, #0x20
40002720: 1a9f156b     	csinc	w11, w11, wzr, ne
40002724: eb0c015f     	cmp	x10, x12
40002728: 54ffff61     	b.ne	0x40002714 <script_execute_line+0xa4>
4000272c: 35fffd6b     	cbnz	w11, 0x400026d8 <script_execute_line+0x68>
40002730: 7101a53f     	cmp	w9, #0x69
40002734: 54fffd20     	b.eq	0x400026d8 <script_execute_line+0x68>
40002738: 7101991f     	cmp	w8, #0x66
4000273c: 54fffce0     	b.eq	0x400026d8 <script_execute_line+0x68>
40002740: 910403e8     	add	x8, sp, #0x100
40002744: 910403e0     	add	x0, sp, #0x100
40002748: 8b0a0101     	add	x1, x8, x10
4000274c: 3800143f     	strb	wzr, [x1], #0x1
40002750: 97ffff0d     	bl	0x40002384 <script_set_var>
40002754: 14000087     	b	0x40002970 <script_execute_line+0x300>
40002758: 394403e9     	ldrb	w9, [sp, #0x100]
4000275c: 7101a53f     	cmp	w9, #0x69
40002760: 54001041     	b.ne	0x40002968 <script_execute_line+0x2f8>
40002764: 7101991f     	cmp	w8, #0x66
40002768: 54001001     	b.ne	0x40002968 <script_execute_line+0x2f8>
4000276c: 39440be8     	ldrb	w8, [sp, #0x102]
40002770: 7100811f     	cmp	w8, #0x20
40002774: 54000fa1     	b.ne	0x40002968 <script_execute_line+0x2f8>
40002778: 39440fe9     	ldrb	w9, [sp, #0x103]
4000277c: 7100813f     	cmp	w9, #0x20
40002780: 54000081     	b.ne	0x40002790 <script_execute_line+0x120>
40002784: aa1f03e9     	mov	x9, xzr
40002788: 52800068     	mov	w8, #0x3                // =3
4000278c: 14000014     	b	0x400027dc <script_execute_line+0x16c>
40002790: 910403ea     	add	x10, sp, #0x100
40002794: aa1f03e8     	mov	x8, xzr
40002798: 910303eb     	add	x11, sp, #0xc0
4000279c: 9100114a     	add	x10, x10, #0x4
400027a0: 34000189     	cbz	w9, 0x400027d0 <script_execute_line+0x160>
400027a4: f100f91f     	cmp	x8, #0x3e
400027a8: 54000148     	b.hi	0x400027d0 <script_execute_line+0x160>
400027ac: 38286969     	strb	w9, [x11, x8]
400027b0: 38686949     	ldrb	w9, [x10, x8]
400027b4: 9100050c     	add	x12, x8, #0x1
400027b8: aa0c03e8     	mov	x8, x12
400027bc: 7100813f     	cmp	w9, #0x20
400027c0: 54ffff01     	b.ne	0x400027a0 <script_execute_line+0x130>
400027c4: 11000d8a     	add	w10, w12, #0x3
400027c8: 2a0c03e8     	mov	w8, w12
400027cc: 14000002     	b	0x400027d4 <script_execute_line+0x164>
400027d0: 11000d0a     	add	w10, w8, #0x3
400027d4: 2a0803e9     	mov	w9, w8
400027d8: 2a0a03e8     	mov	w8, w10
400027dc: 910303ea     	add	x10, sp, #0xc0
400027e0: 3829695f     	strb	wzr, [x10, x9]
400027e4: 910403e9     	add	x9, sp, #0x100
400027e8: 3868692a     	ldrb	w10, [x9, x8]
400027ec: 7100815f     	cmp	w10, #0x20
400027f0: 54000061     	b.ne	0x400027fc <script_execute_line+0x18c>
400027f4: 91000508     	add	x8, x8, #0x1
400027f8: 17fffffc     	b	0x400027e8 <script_execute_line+0x178>
400027fc: 7100855f     	cmp	w10, #0x21
40002800: 54000060     	b.eq	0x4000280c <script_execute_line+0x19c>
40002804: 7100f55f     	cmp	w10, #0x3d
40002808: 540000e1     	b.ne	0x40002824 <script_execute_line+0x1b4>
4000280c: 11000509     	add	w9, w8, #0x1
40002810: 910403ea     	add	x10, sp, #0x100
40002814: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002818: 9100090a     	add	x10, x8, #0x2
4000281c: 7100f53f     	cmp	w9, #0x3d
40002820: 9a880148     	csel	x8, x10, x8, eq
40002824: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002828: 910403ea     	add	x10, sp, #0x100
4000282c: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002830: 8b088129     	add	x9, x9, x8, lsl #32
40002834: 8b28c14a     	add	x10, x10, w8, sxtw
40002838: 51000508     	sub	w8, w8, #0x1
4000283c: 3840154c     	ldrb	w12, [x10], #0x1
40002840: 8b0b0129     	add	x9, x9, x11
40002844: 11000508     	add	w8, w8, #0x1
40002848: 7100819f     	cmp	w12, #0x20
4000284c: 54ffff80     	b.eq	0x4000283c <script_execute_line+0x1cc>
40002850: 9360fd2c     	asr	x12, x9, #32
40002854: 910403e9     	add	x9, sp, #0x100
40002858: 386c692d     	ldrb	w13, [x9, x12]
4000285c: 710081bf     	cmp	w13, #0x20
40002860: 54000061     	b.ne	0x4000286c <script_execute_line+0x1fc>
40002864: aa1f03ea     	mov	x10, xzr
40002868: 14000010     	b	0x400028a8 <script_execute_line+0x238>
4000286c: aa1f03eb     	mov	x11, xzr
40002870: 910203ec     	add	x12, sp, #0x80
40002874: 3400016d     	cbz	w13, 0x400028a0 <script_execute_line+0x230>
40002878: f100f97f     	cmp	x11, #0x3e
4000287c: 54000128     	b.hi	0x400028a0 <script_execute_line+0x230>
40002880: 382b698d     	strb	w13, [x12, x11]
40002884: 386b694d     	ldrb	w13, [x10, x11]
40002888: 9100056e     	add	x14, x11, #0x1
4000288c: 11000508     	add	w8, w8, #0x1
40002890: aa0e03eb     	mov	x11, x14
40002894: 710081bf     	cmp	w13, #0x20
40002898: 54fffee1     	b.ne	0x40002874 <script_execute_line+0x204>
4000289c: 2a0e03eb     	mov	w11, w14
400028a0: 93407d0c     	sxtw	x12, w8
400028a4: 2a0b03ea     	mov	w10, w11
400028a8: d3607d8d     	lsl	x13, x12, #32
400028ac: 910203eb     	add	x11, sp, #0x80
400028b0: d2c0006f     	mov	x15, #0x300000000       // =12884901888
400028b4: d2c00050     	mov	x16, #0x200000000       // =8589934592
400028b8: d2c0002e     	mov	x14, #0x100000000       // =4294967296
400028bc: 11001108     	add	w8, w8, #0x4
400028c0: 382a697f     	strb	wzr, [x11, x10]
400028c4: 8b0f01aa     	add	x10, x13, x15
400028c8: 8b1001ab     	add	x11, x13, x16
400028cc: 8b0e01ad     	add	x13, x13, x14
400028d0: 8b0c0129     	add	x9, x9, x12
400028d4: 3840152c     	ldrb	w12, [x9], #0x1
400028d8: 7100819f     	cmp	w12, #0x20
400028dc: 540000c1     	b.ne	0x400028f4 <script_execute_line+0x284>
400028e0: 11000508     	add	w8, w8, #0x1
400028e4: 8b0e014a     	add	x10, x10, x14
400028e8: 8b0e016b     	add	x11, x11, x14
400028ec: 8b0e01ad     	add	x13, x13, x14
400028f0: 17fffff9     	b	0x400028d4 <script_execute_line+0x264>
400028f4: 7101d19f     	cmp	w12, #0x74
400028f8: 54000381     	b.ne	0x40002968 <script_execute_line+0x2f8>
400028fc: 9360fdac     	asr	x12, x13, #32
40002900: 910403e9     	add	x9, sp, #0x100
40002904: 386c692c     	ldrb	w12, [x9, x12]
40002908: 7101a19f     	cmp	w12, #0x68
4000290c: 540002e1     	b.ne	0x40002968 <script_execute_line+0x2f8>
40002910: 9360fd6b     	asr	x11, x11, #32
40002914: 386b6929     	ldrb	w9, [x9, x11]
40002918: 7101953f     	cmp	w9, #0x65
4000291c: 54000261     	b.ne	0x40002968 <script_execute_line+0x2f8>
40002920: 9360fd4a     	asr	x10, x10, #32
40002924: 910403e9     	add	x9, sp, #0x100
40002928: 386a692a     	ldrb	w10, [x9, x10]
4000292c: 7101b95f     	cmp	w10, #0x6e
40002930: 540001c1     	b.ne	0x40002968 <script_execute_line+0x2f8>
40002934: 8b28c128     	add	x8, x9, w8, sxtw
40002938: d1000501     	sub	x1, x8, #0x1
4000293c: 38401c28     	ldrb	w8, [x1, #0x1]!
40002940: 7100811f     	cmp	w8, #0x20
40002944: 54ffffc0     	b.eq	0x4000293c <script_execute_line+0x2cc>
40002948: 910003e0     	mov	x0, sp
4000294c: 94000075     	bl	0x40002b20 <kstrcpy>
40002950: 910303e0     	add	x0, sp, #0xc0
40002954: 910203e1     	add	x1, sp, #0x80
40002958: 94000053     	bl	0x40002aa4 <kstrcmp>
4000295c: 350000a0     	cbnz	w0, 0x40002970 <script_execute_line+0x300>
40002960: 910003e0     	mov	x0, sp
40002964: 14000002     	b	0x4000296c <script_execute_line+0x2fc>
40002968: 910403e0     	add	x0, sp, #0x100
4000296c: 97fff919     	bl	0x40000dd0 <execute_command>
40002970: 2a1f03e0     	mov	w0, wzr
40002974: 910803ff     	add	sp, sp, #0x200
40002978: a9414ffc     	ldp	x28, x19, [sp, #0x10]
4000297c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002980: d65f03c0     	ret

0000000040002984 <script_run_file>:
40002984: d10503ff     	sub	sp, sp, #0x140
40002988: a9107bfd     	stp	x29, x30, [sp, #0x100]
4000298c: 910403fd     	add	x29, sp, #0x100
40002990: f9008bfc     	str	x28, [sp, #0x110]
40002994: a91257f6     	stp	x22, x21, [sp, #0x120]
40002998: a9134ff4     	stp	x20, x19, [sp, #0x130]
4000299c: aa0003f4     	mov	x20, x0
400029a0: 940008b8     	bl	0x40004c80 <vfs_find>
400029a4: b4000080     	cbz	x0, 0x400029b4 <script_run_file+0x30>
400029a8: b9402008     	ldr	w8, [x0, #0x20]
400029ac: aa0003f3     	mov	x19, x0
400029b0: 340000e8     	cbz	w8, 0x400029cc <script_run_file+0x48>
400029b4: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400029b8: 91049c00     	add	x0, x0, #0x127
400029bc: aa1403e1     	mov	x1, x20
400029c0: 940004e7     	bl	0x40003d5c <uart_printf>
400029c4: 12800000     	mov	w0, #-0x1               // =-1
400029c8: 14000021     	b	0x40002a4c <script_run_file+0xc8>
400029cc: f9401668     	ldr	x8, [x19, #0x28]
400029d0: aa1f03f4     	mov	x20, xzr
400029d4: 2a1f03e9     	mov	w9, wzr
400029d8: 9100c275     	add	x21, x19, #0x30
400029dc: 910003f6     	mov	x22, sp
400029e0: 14000008     	b	0x40002a00 <script_run_file+0x7c>
400029e4: 7100053f     	cmp	w9, #0x1
400029e8: 3829cadf     	strb	wzr, [x22, w9, sxtw]
400029ec: 2a1f03e9     	mov	w9, wzr
400029f0: 5400022a     	b.ge	0x40002a34 <script_run_file+0xb0>
400029f4: 91000694     	add	x20, x20, #0x1
400029f8: eb08029f     	cmp	x20, x8
400029fc: 54000268     	b.hi	0x40002a48 <script_run_file+0xc4>
40002a00: eb08029f     	cmp	x20, x8
40002a04: 54ffff00     	b.eq	0x400029e4 <script_run_file+0x60>
40002a08: 38746aaa     	ldrb	w10, [x21, x20]
40002a0c: 7100295f     	cmp	w10, #0xa
40002a10: 54fffea0     	b.eq	0x400029e4 <script_run_file+0x60>
40002a14: 7100355f     	cmp	w10, #0xd
40002a18: 54fffee0     	b.eq	0x400029f4 <script_run_file+0x70>
40002a1c: 7103f93f     	cmp	w9, #0xfe
40002a20: 54fffeac     	b.gt	0x400029f4 <script_run_file+0x70>
40002a24: 1100052b     	add	w11, w9, #0x1
40002a28: 3829caca     	strb	w10, [x22, w9, sxtw]
40002a2c: 2a0b03e9     	mov	w9, w11
40002a30: 17fffff1     	b	0x400029f4 <script_run_file+0x70>
40002a34: 910003e0     	mov	x0, sp
40002a38: 97ffff0e     	bl	0x40002670 <script_execute_line>
40002a3c: f9401668     	ldr	x8, [x19, #0x28]
40002a40: 2a1f03e9     	mov	w9, wzr
40002a44: 17ffffec     	b	0x400029f4 <script_run_file+0x70>
40002a48: 2a1f03e0     	mov	w0, wzr
40002a4c: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002a50: f9408bfc     	ldr	x28, [sp, #0x110]
40002a54: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002a58: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002a5c: 910503ff     	add	sp, sp, #0x140
40002a60: d65f03c0     	ret

0000000040002a64 <kstrlen>:
40002a64: b40000c0     	cbz	x0, 0x40002a7c <kstrlen+0x18>
40002a68: aa1f03e8     	mov	x8, xzr
40002a6c: 38686809     	ldrb	w9, [x0, x8]
40002a70: 91000508     	add	x8, x8, #0x1
40002a74: 35ffffc9     	cbnz	w9, 0x40002a6c <kstrlen+0x8>
40002a78: d1000500     	sub	x0, x8, #0x1
40002a7c: d65f03c0     	ret

0000000040002a80 <kstrcat>:
40002a80: b4000100     	cbz	x0, 0x40002aa0 <kstrcat+0x20>
40002a84: b40000e1     	cbz	x1, 0x40002aa0 <kstrcat+0x20>
40002a88: d1000408     	sub	x8, x0, #0x1
40002a8c: 38401d09     	ldrb	w9, [x8, #0x1]!
40002a90: 35ffffe9     	cbnz	w9, 0x40002a8c <kstrcat+0xc>
40002a94: 38401429     	ldrb	w9, [x1], #0x1
40002a98: 38001509     	strb	w9, [x8], #0x1
40002a9c: 35ffffc9     	cbnz	w9, 0x40002a94 <kstrcat+0x14>
40002aa0: d65f03c0     	ret

0000000040002aa4 <kstrcmp>:
40002aa4: aa0003e8     	mov	x8, x0
40002aa8: 12800000     	mov	w0, #-0x1               // =-1
40002aac: b4000188     	cbz	x8, 0x40002adc <kstrcmp+0x38>
40002ab0: b4000161     	cbz	x1, 0x40002adc <kstrcmp+0x38>
40002ab4: 38401509     	ldrb	w9, [x8], #0x1
40002ab8: 340000e9     	cbz	w9, 0x40002ad4 <kstrcmp+0x30>
40002abc: 3940002a     	ldrb	w10, [x1]
40002ac0: 6b0a013f     	cmp	w9, w10
40002ac4: 54000081     	b.ne	0x40002ad4 <kstrcmp+0x30>
40002ac8: 38401509     	ldrb	w9, [x8], #0x1
40002acc: 91000421     	add	x1, x1, #0x1
40002ad0: 35ffff69     	cbnz	w9, 0x40002abc <kstrcmp+0x18>
40002ad4: 39400028     	ldrb	w8, [x1]
40002ad8: 4b080120     	sub	w0, w9, w8
40002adc: d65f03c0     	ret

0000000040002ae0 <kstrncmp>:
40002ae0: 12800008     	mov	w8, #-0x1               // =-1
40002ae4: b4000160     	cbz	x0, 0x40002b10 <kstrncmp+0x30>
40002ae8: b4000141     	cbz	x1, 0x40002b10 <kstrncmp+0x30>
40002aec: b4000102     	cbz	x2, 0x40002b0c <kstrncmp+0x2c>
40002af0: 38401408     	ldrb	w8, [x0], #0x1
40002af4: 38401429     	ldrb	w9, [x1], #0x1
40002af8: 34000108     	cbz	w8, 0x40002b18 <kstrncmp+0x38>
40002afc: 6b09011f     	cmp	w8, w9
40002b00: 540000c1     	b.ne	0x40002b18 <kstrncmp+0x38>
40002b04: f1000442     	subs	x2, x2, #0x1
40002b08: 54ffff41     	b.ne	0x40002af0 <kstrncmp+0x10>
40002b0c: 2a1f03e8     	mov	w8, wzr
40002b10: 2a0803e0     	mov	w0, w8
40002b14: d65f03c0     	ret
40002b18: 4b090100     	sub	w0, w8, w9
40002b1c: d65f03c0     	ret

0000000040002b20 <kstrcpy>:
40002b20: b40000c0     	cbz	x0, 0x40002b38 <kstrcpy+0x18>
40002b24: b40000a1     	cbz	x1, 0x40002b38 <kstrcpy+0x18>
40002b28: aa0003e8     	mov	x8, x0
40002b2c: 38401429     	ldrb	w9, [x1], #0x1
40002b30: 38001509     	strb	w9, [x8], #0x1
40002b34: 35ffffc9     	cbnz	w9, 0x40002b2c <kstrcpy+0xc>
40002b38: d65f03c0     	ret

0000000040002b3c <kstrncpy>:
40002b3c: b4000480     	cbz	x0, 0x40002bcc <kstrncpy+0x90>
40002b40: b4000461     	cbz	x1, 0x40002bcc <kstrncpy+0x90>
40002b44: b4000442     	cbz	x2, 0x40002bcc <kstrncpy+0x90>
40002b48: aa1f03e9     	mov	x9, xzr
40002b4c: aa0203e8     	mov	x8, x2
40002b50: 3869682a     	ldrb	w10, [x1, x9]
40002b54: 3829680a     	strb	w10, [x0, x9]
40002b58: 340000ca     	cbz	w10, 0x40002b70 <kstrncpy+0x34>
40002b5c: 91000529     	add	x9, x9, #0x1
40002b60: d1000508     	sub	x8, x8, #0x1
40002b64: eb09005f     	cmp	x2, x9
40002b68: 54ffff41     	b.ne	0x40002b50 <kstrncpy+0x14>
40002b6c: 14000018     	b	0x40002bcc <kstrncpy+0x90>
40002b70: cb09004a     	sub	x10, x2, x9
40002b74: 8b090009     	add	x9, x0, x9
40002b78: f100095f     	cmp	x10, #0x2
40002b7c: 54000082     	b.hs	0x40002b8c <kstrncpy+0x50>
40002b80: 91000528     	add	x8, x9, #0x1
40002b84: aa0a03e9     	mov	x9, x10
40002b88: 1400000e     	b	0x40002bc0 <kstrncpy+0x84>
40002b8c: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002b90: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002b94: 9100092c     	add	x12, x9, #0x2
40002b98: 8b090108     	add	x8, x8, x9
40002b9c: 92400149     	and	x9, x10, #0x1
40002ba0: aa0b03ed     	mov	x13, x11
40002ba4: 91000508     	add	x8, x8, #0x1
40002ba8: f10009ad     	subs	x13, x13, #0x2
40002bac: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002bb0: 3800259f     	strb	wzr, [x12], #0x2
40002bb4: 54ffffa1     	b.ne	0x40002ba8 <kstrncpy+0x6c>
40002bb8: eb0b015f     	cmp	x10, x11
40002bbc: 54000080     	b.eq	0x40002bcc <kstrncpy+0x90>
40002bc0: f1000529     	subs	x9, x9, #0x1
40002bc4: 3800151f     	strb	wzr, [x8], #0x1
40002bc8: 54ffffc1     	b.ne	0x40002bc0 <kstrncpy+0x84>
40002bcc: d65f03c0     	ret

0000000040002bd0 <memset>:
40002bd0: b40002a0     	cbz	x0, 0x40002c24 <memset+0x54>
40002bd4: b4000282     	cbz	x2, 0x40002c24 <memset+0x54>
40002bd8: f100085f     	cmp	x2, #0x2
40002bdc: 54000082     	b.hs	0x40002bec <memset+0x1c>
40002be0: aa0003e8     	mov	x8, x0
40002be4: aa0203e9     	mov	x9, x2
40002be8: 1400000c     	b	0x40002c18 <memset+0x48>
40002bec: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
40002bf0: 92400049     	and	x9, x2, #0x1
40002bf4: 9100040b     	add	x11, x0, #0x1
40002bf8: 8b0a0008     	add	x8, x0, x10
40002bfc: aa0a03ec     	mov	x12, x10
40002c00: f100098c     	subs	x12, x12, #0x2
40002c04: 381ff161     	sturb	w1, [x11, #-0x1]
40002c08: 38002561     	strb	w1, [x11], #0x2
40002c0c: 54ffffa1     	b.ne	0x40002c00 <memset+0x30>
40002c10: eb0a005f     	cmp	x2, x10
40002c14: 54000080     	b.eq	0x40002c24 <memset+0x54>
40002c18: f1000529     	subs	x9, x9, #0x1
40002c1c: 38001501     	strb	w1, [x8], #0x1
40002c20: 54ffffc1     	b.ne	0x40002c18 <memset+0x48>
40002c24: d65f03c0     	ret

0000000040002c28 <memcpy>:
40002c28: b4000100     	cbz	x0, 0x40002c48 <memcpy+0x20>
40002c2c: b40000e1     	cbz	x1, 0x40002c48 <memcpy+0x20>
40002c30: b40000c2     	cbz	x2, 0x40002c48 <memcpy+0x20>
40002c34: aa0003e8     	mov	x8, x0
40002c38: 38401429     	ldrb	w9, [x1], #0x1
40002c3c: f1000442     	subs	x2, x2, #0x1
40002c40: 38001509     	strb	w9, [x8], #0x1
40002c44: 54ffffa1     	b.ne	0x40002c38 <memcpy+0x10>
40002c48: d65f03c0     	ret

0000000040002c4c <kstrstr>:
40002c4c: aa1f03e2     	mov	x2, xzr
40002c50: b40000e0     	cbz	x0, 0x40002c6c <kstrstr+0x20>
40002c54: b40000c1     	cbz	x1, 0x40002c6c <kstrstr+0x20>
40002c58: 39400028     	ldrb	w8, [x1]
40002c5c: 340002c8     	cbz	w8, 0x40002cb4 <kstrstr+0x68>
40002c60: 39400009     	ldrb	w9, [x0]
40002c64: 35000109     	cbnz	w9, 0x40002c84 <kstrstr+0x38>
40002c68: aa1f03e2     	mov	x2, xzr
40002c6c: aa0203e0     	mov	x0, x2
40002c70: d65f03c0     	ret
40002c74: 3940012c     	ldrb	w12, [x9]
40002c78: 340001ec     	cbz	w12, 0x40002cb4 <kstrstr+0x68>
40002c7c: 38401c09     	ldrb	w9, [x0, #0x1]!
40002c80: 34ffff49     	cbz	w9, 0x40002c68 <kstrstr+0x1c>
40002c84: 6b08013f     	cmp	w9, w8
40002c88: 54ffffa1     	b.ne	0x40002c7c <kstrstr+0x30>
40002c8c: 5280002a     	mov	w10, #0x1               // =1
40002c90: aa0103e9     	mov	x9, x1
40002c94: 2a0803eb     	mov	w11, w8
40002c98: 3840152c     	ldrb	w12, [x9], #0x1
40002c9c: 6b0c017f     	cmp	w11, w12
40002ca0: 54fffec1     	b.ne	0x40002c78 <kstrstr+0x2c>
40002ca4: 386a680b     	ldrb	w11, [x0, x10]
40002ca8: 9100054a     	add	x10, x10, #0x1
40002cac: 35ffff6b     	cbnz	w11, 0x40002c98 <kstrstr+0x4c>
40002cb0: 17fffff1     	b	0x40002c74 <kstrstr+0x28>
40002cb4: d65f03c0     	ret

0000000040002cb8 <kstrchr>:
40002cb8: b4000140     	cbz	x0, 0x40002ce0 <kstrchr+0x28>
40002cbc: 39400009     	ldrb	w9, [x0]
40002cc0: 340000c9     	cbz	w9, 0x40002cd8 <kstrchr+0x20>
40002cc4: 12001c28     	and	w8, w1, #0xff
40002cc8: 6b08013f     	cmp	w9, w8
40002ccc: 540000a0     	b.eq	0x40002ce0 <kstrchr+0x28>
40002cd0: 38401c09     	ldrb	w9, [x0, #0x1]!
40002cd4: 35ffffa9     	cbnz	w9, 0x40002cc8 <kstrchr+0x10>
40002cd8: 72001c3f     	tst	w1, #0xff
40002cdc: 9a9f0000     	csel	x0, x0, xzr, eq
40002ce0: d65f03c0     	ret

0000000040002ce4 <ktolower>:
40002ce4: 51010408     	sub	w8, w0, #0x41
40002ce8: 321b0009     	orr	w9, w0, #0x20
40002cec: 7100691f     	cmp	w8, #0x1a
40002cf0: 1a803120     	csel	w0, w9, w0, lo
40002cf4: d65f03c0     	ret

0000000040002cf8 <kstr_tolower>:
40002cf8: b40001a0     	cbz	x0, 0x40002d2c <kstr_tolower+0x34>
40002cfc: b4000181     	cbz	x1, 0x40002d2c <kstr_tolower+0x34>
40002d00: 39400029     	ldrb	w9, [x1]
40002d04: 34000129     	cbz	w9, 0x40002d28 <kstr_tolower+0x30>
40002d08: 91000428     	add	x8, x1, #0x1
40002d0c: 5101052a     	sub	w10, w9, #0x41
40002d10: 321b012b     	orr	w11, w9, #0x20
40002d14: 7100695f     	cmp	w10, #0x1a
40002d18: 1a893169     	csel	w9, w11, w9, lo
40002d1c: 38001409     	strb	w9, [x0], #0x1
40002d20: 38401509     	ldrb	w9, [x8], #0x1
40002d24: 35ffff49     	cbnz	w9, 0x40002d0c <kstr_tolower+0x14>
40002d28: 3900001f     	strb	wzr, [x0]
40002d2c: d65f03c0     	ret

0000000040002d30 <timer_init>:
40002d30: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002d34: f9000bf3     	str	x19, [sp, #0x10]
40002d38: d0000073     	adrp	x19, 0x40010000 <var_values+0x6a4>
40002d3c: 528003c0     	mov	w0, #0x1e               // =30
40002d40: 910003fd     	mov	x29, sp
40002d44: d53be008     	mrs	x8, CNTFRQ_EL0
40002d48: 52800029     	mov	w9, #0x1                // =1
40002d4c: f904b268     	str	x8, [x19, #0x960]
40002d50: d51be208     	msr	CNTP_TVAL_EL0, x8
40002d54: d51be229     	msr	CNTP_CTL_EL0, x9
40002d58: 97fff531     	bl	0x4000021c <gic_enable_interrupt>
40002d5c: d50342ff     	msr	DAIFClr, #0x2
40002d60: d503201f     	nop
40002d64: 500325e0     	adr	x0, 0x40009222 <__rodata_start+0x2222>
40002d68: b9496261     	ldr	w1, [x19, #0x960]
40002d6c: f9400bf3     	ldr	x19, [sp, #0x10]
40002d70: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002d74: 140003fa     	b	0x40003d5c <uart_printf>

0000000040002d78 <timer_handle_interrupt>:
40002d78: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002d7c: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
40002d80: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002d84: 91262000     	add	x0, x0, #0x988
40002d88: f944b509     	ldr	x9, [x8, #0x968]
40002d8c: 910003fd     	mov	x29, sp
40002d90: 91000529     	add	x9, x9, #0x1
40002d94: f904b509     	str	x9, [x8, #0x968]
40002d98: 940002dc     	bl	0x40003908 <uart_puts>
40002d9c: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
40002da0: f944b108     	ldr	x8, [x8, #0x960]
40002da4: d51be208     	msr	CNTP_TVAL_EL0, x8
40002da8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002dac: d65f03c0     	ret

0000000040002db0 <tui_launch>:
40002db0: d105c3ff     	sub	sp, sp, #0x170
40002db4: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002db8: 910443fd     	add	x29, sp, #0x110
40002dbc: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002dc0: a91367fa     	stp	x26, x25, [sp, #0x130]
40002dc4: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002dc8: a91557f6     	stp	x22, x21, [sp, #0x150]
40002dcc: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002dd0: 9400075a     	bl	0x40004b38 <vfs_get_cwd>
40002dd4: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
40002dd8: d000007c     	adrp	x28, 0x40010000 <var_values+0x6a4>
40002ddc: d000007b     	adrp	x27, 0x40010000 <var_values+0x6a4>
40002de0: f904b900     	str	x0, [x8, #0x970]
40002de4: d503201f     	nop
40002de8: 7002d5a0     	adr	x0, 0x4000889f <__rodata_start+0x189f>
40002dec: b9097b9f     	str	wzr, [x28, #0x978]
40002df0: b9097f7f     	str	wzr, [x27, #0x97c]
40002df4: 940002c5     	bl	0x40003908 <uart_puts>
40002df8: b0000036     	adrp	x22, 0x40007000 <__rodata_start>
40002dfc: 9111fed6     	add	x22, x22, #0x47f
40002e00: b0000037     	adrp	x23, 0x40007000 <__rodata_start>
40002e04: 910dbef7     	add	x23, x23, #0x36f
40002e08: d0000078     	adrp	x24, 0x40010000 <var_values+0x6a4>
40002e0c: 91262318     	add	x24, x24, #0x988
40002e10: d000007a     	adrp	x26, 0x40010000 <var_values+0x6a4>
40002e14: b0000034     	adrp	x20, 0x40007000 <__rodata_start>
40002e18: 91158294     	add	x20, x20, #0x560
40002e1c: 14000005     	b	0x40002e30 <tui_launch+0x80>
40002e20: b9497b88     	ldr	w8, [x28, #0x978]
40002e24: 7100011f     	cmp	w8, #0x0
40002e28: 1a9f17e8     	cset	w8, eq
40002e2c: b9097b88     	str	w8, [x28, #0x978]
40002e30: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
40002e34: b909835f     	str	wzr, [x26, #0x980]
40002e38: f944b90a     	ldr	x10, [x8, #0x970]
40002e3c: f9421948     	ldr	x8, [x10, #0x430]
40002e40: b4000108     	cbz	x8, 0x40002e60 <tui_launch+0xb0>
40002e44: 52800029     	mov	w9, #0x1                // =1
40002e48: d0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
40002e4c: b9098349     	str	w9, [x26, #0x980]
40002e50: f904c51f     	str	xzr, [x8, #0x988]
40002e54: f9401548     	ldr	x8, [x10, #0x28]
40002e58: b50000a8     	cbnz	x8, 0x40002e6c <tui_launch+0xbc>
40002e5c: 14000027     	b	0x40002ef8 <tui_launch+0x148>
40002e60: 2a1f03e9     	mov	w9, wzr
40002e64: f9401548     	ldr	x8, [x10, #0x28]
40002e68: b4000488     	cbz	x8, 0x40002ef8 <tui_launch+0x148>
40002e6c: 2a0903e9     	mov	w9, w9
40002e70: d100050c     	sub	x12, x8, #0x1
40002e74: d240152b     	eor	x11, x9, #0x3f
40002e78: eb0b019f     	cmp	x12, x11
40002e7c: 9a8b318b     	csel	x11, x12, x11, lo
40002e80: b400022c     	cbz	x12, 0x40002ec4 <tui_launch+0x114>
40002e84: 9100056c     	add	x12, x11, #0x1
40002e88: 8b090f0e     	add	x14, x24, x9, lsl #3
40002e8c: 9111014d     	add	x13, x10, #0x440
40002e90: 927f798b     	and	x11, x12, #0xfffffffe
40002e94: aa090169     	orr	x9, x11, x9
40002e98: 910021ce     	add	x14, x14, #0x8
40002e9c: aa0b03ef     	mov	x15, x11
40002ea0: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002ea4: f10009ef     	subs	x15, x15, #0x2
40002ea8: 910041ad     	add	x13, x13, #0x10
40002eac: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002eb0: 910041ce     	add	x14, x14, #0x10
40002eb4: 54ffff61     	b.ne	0x40002ea0 <tui_launch+0xf0>
40002eb8: eb0b019f     	cmp	x12, x11
40002ebc: 54000061     	b.ne	0x40002ec8 <tui_launch+0x118>
40002ec0: 1400000d     	b	0x40002ef4 <tui_launch+0x144>
40002ec4: aa1f03eb     	mov	x11, xzr
40002ec8: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002ecc: 9100056b     	add	x11, x11, #0x1
40002ed0: 9110e14a     	add	x10, x10, #0x438
40002ed4: f840854c     	ldr	x12, [x10], #0x8
40002ed8: f100f93f     	cmp	x9, #0x3e
40002edc: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002ee0: 91000529     	add	x9, x9, #0x1
40002ee4: 54000088     	b.hi	0x40002ef4 <tui_launch+0x144>
40002ee8: eb08017f     	cmp	x11, x8
40002eec: 9100056b     	add	x11, x11, #0x1
40002ef0: 54ffff23     	b.lo	0x40002ed4 <tui_launch+0x124>
40002ef4: b9098349     	str	w9, [x26, #0x980]
40002ef8: b9497f6a     	ldr	w10, [x27, #0x97c]
40002efc: 51000528     	sub	w8, w9, #0x1
40002f00: 6b08015f     	cmp	w10, w8
40002f04: 1a88b148     	csel	w8, w10, w8, lt
40002f08: 6b09015f     	cmp	w10, w9
40002f0c: 5400004a     	b.ge	0x40002f14 <tui_launch+0x164>
40002f10: 36f80068     	tbz	w8, #0x1f, 0x40002f1c <tui_launch+0x16c>
40002f14: 0aa87d08     	bic	w8, w8, w8, asr #31
40002f18: b9097f68     	str	w8, [x27, #0x97c]
40002f1c: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002f20: 91262800     	add	x0, x0, #0x98a
40002f24: 94000279     	bl	0x40003908 <uart_puts>
40002f28: b9497b88     	ldr	w8, [x28, #0x978]
40002f2c: 52800020     	mov	w0, #0x1                // =1
40002f30: 52800501     	mov	w1, #0x28               // =40
40002f34: b0000022     	adrp	x2, 0x40007000 <__rodata_start>
40002f38: 91036442     	add	x2, x2, #0xd9
40002f3c: 7100011f     	cmp	w8, #0x0
40002f40: 1a9f17e3     	cset	w3, eq
40002f44: 94000171     	bl	0x40003508 <draw_box>
40002f48: 52800075     	mov	w21, #0x3               // =3
40002f4c: aa1603e0     	mov	x0, x22
40002f50: 2a1503e1     	mov	w1, w21
40002f54: 52800042     	mov	w2, #0x2                // =2
40002f58: 94000381     	bl	0x40003d5c <uart_printf>
40002f5c: aa1703e0     	mov	x0, x23
40002f60: 9400026a     	bl	0x40003908 <uart_puts>
40002f64: aa1703e0     	mov	x0, x23
40002f68: 94000268     	bl	0x40003908 <uart_puts>
40002f6c: aa1703e0     	mov	x0, x23
40002f70: 94000266     	bl	0x40003908 <uart_puts>
40002f74: aa1703e0     	mov	x0, x23
40002f78: 94000264     	bl	0x40003908 <uart_puts>
40002f7c: aa1703e0     	mov	x0, x23
40002f80: 94000262     	bl	0x40003908 <uart_puts>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 94000260     	bl	0x40003908 <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 9400025e     	bl	0x40003908 <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 9400025c     	bl	0x40003908 <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 9400025a     	bl	0x40003908 <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 94000258     	bl	0x40003908 <uart_puts>
40002fac: aa1703e0     	mov	x0, x23
40002fb0: 94000256     	bl	0x40003908 <uart_puts>
40002fb4: aa1703e0     	mov	x0, x23
40002fb8: 94000254     	bl	0x40003908 <uart_puts>
40002fbc: aa1703e0     	mov	x0, x23
40002fc0: 94000252     	bl	0x40003908 <uart_puts>
40002fc4: aa1703e0     	mov	x0, x23
40002fc8: 94000250     	bl	0x40003908 <uart_puts>
40002fcc: aa1703e0     	mov	x0, x23
40002fd0: 9400024e     	bl	0x40003908 <uart_puts>
40002fd4: aa1703e0     	mov	x0, x23
40002fd8: 9400024c     	bl	0x40003908 <uart_puts>
40002fdc: aa1703e0     	mov	x0, x23
40002fe0: 9400024a     	bl	0x40003908 <uart_puts>
40002fe4: aa1703e0     	mov	x0, x23
40002fe8: 94000248     	bl	0x40003908 <uart_puts>
40002fec: aa1703e0     	mov	x0, x23
40002ff0: 94000246     	bl	0x40003908 <uart_puts>
40002ff4: aa1703e0     	mov	x0, x23
40002ff8: 94000244     	bl	0x40003908 <uart_puts>
40002ffc: aa1703e0     	mov	x0, x23
40003000: 94000242     	bl	0x40003908 <uart_puts>
40003004: aa1703e0     	mov	x0, x23
40003008: 94000240     	bl	0x40003908 <uart_puts>
4000300c: aa1703e0     	mov	x0, x23
40003010: 9400023e     	bl	0x40003908 <uart_puts>
40003014: aa1703e0     	mov	x0, x23
40003018: 9400023c     	bl	0x40003908 <uart_puts>
4000301c: aa1703e0     	mov	x0, x23
40003020: 9400023a     	bl	0x40003908 <uart_puts>
40003024: aa1703e0     	mov	x0, x23
40003028: 94000238     	bl	0x40003908 <uart_puts>
4000302c: aa1703e0     	mov	x0, x23
40003030: 94000236     	bl	0x40003908 <uart_puts>
40003034: aa1703e0     	mov	x0, x23
40003038: 94000234     	bl	0x40003908 <uart_puts>
4000303c: aa1703e0     	mov	x0, x23
40003040: 94000232     	bl	0x40003908 <uart_puts>
40003044: aa1703e0     	mov	x0, x23
40003048: 94000230     	bl	0x40003908 <uart_puts>
4000304c: aa1703e0     	mov	x0, x23
40003050: 9400022e     	bl	0x40003908 <uart_puts>
40003054: aa1703e0     	mov	x0, x23
40003058: 9400022c     	bl	0x40003908 <uart_puts>
4000305c: aa1703e0     	mov	x0, x23
40003060: 9400022a     	bl	0x40003908 <uart_puts>
40003064: aa1703e0     	mov	x0, x23
40003068: 94000228     	bl	0x40003908 <uart_puts>
4000306c: aa1703e0     	mov	x0, x23
40003070: 94000226     	bl	0x40003908 <uart_puts>
40003074: aa1703e0     	mov	x0, x23
40003078: 94000224     	bl	0x40003908 <uart_puts>
4000307c: aa1703e0     	mov	x0, x23
40003080: 94000222     	bl	0x40003908 <uart_puts>
40003084: aa1703e0     	mov	x0, x23
40003088: 94000220     	bl	0x40003908 <uart_puts>
4000308c: 110006b5     	add	w21, w21, #0x1
40003090: 71005ebf     	cmp	w21, #0x17
40003094: 54fff5c1     	b.ne	0x40002f4c <tui_launch+0x19c>
40003098: b9497f68     	ldr	w8, [x27, #0x97c]
4000309c: 52800249     	mov	w9, #0x12               // =18
400030a0: 7100491f     	cmp	w8, #0x12
400030a4: 1a89c108     	csel	w8, w8, w9, gt
400030a8: 51004915     	sub	w21, w8, #0x12
400030ac: 8b354f19     	add	x25, x24, w21, uxtw #3
400030b0: aa1f03f8     	mov	x24, xzr
400030b4: 14000004     	b	0x400030c4 <tui_launch+0x314>
400030b8: 91000718     	add	x24, x24, #0x1
400030bc: f100531f     	cmp	x24, #0x14
400030c0: 540005a0     	b.eq	0x40003174 <tui_launch+0x3c4>
400030c4: b9898348     	ldrsw	x8, [x26, #0x980]
400030c8: 8b1802b3     	add	x19, x21, x24
400030cc: eb08027f     	cmp	x19, x8
400030d0: 5400052a     	b.ge	0x40003174 <tui_launch+0x3c4>
400030d4: 11000f01     	add	w1, w24, #0x3
400030d8: aa1603e0     	mov	x0, x22
400030dc: 52800062     	mov	w2, #0x3                // =3
400030e0: 9400031f     	bl	0x40003d5c <uart_printf>
400030e4: b9497f68     	ldr	w8, [x27, #0x97c]
400030e8: eb08027f     	cmp	x19, x8
400030ec: 540000c1     	b.ne	0x40003104 <tui_launch+0x354>
400030f0: b9497b88     	ldr	w8, [x28, #0x978]
400030f4: 35000088     	cbnz	w8, 0x40003104 <tui_launch+0x354>
400030f8: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400030fc: 9104a400     	add	x0, x0, #0x129
40003100: 94000202     	bl	0x40003908 <uart_puts>
40003104: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40003108: b40001e8     	cbz	x8, 0x40003144 <tui_launch+0x394>
4000310c: b9402108     	ldr	w8, [x8, #0x20]
40003110: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40003114: 910bb129     	add	x9, x9, #0x2ec
40003118: 910223e0     	add	x0, sp, #0x88
4000311c: 7100051f     	cmp	w8, #0x1
40003120: 90000028     	adrp	x8, 0x40007000 <__rodata_start>
40003124: 91375d08     	add	x8, x8, #0xdd7
40003128: 9a880121     	csel	x1, x9, x8, eq
4000312c: 97fffe7d     	bl	0x40002b20 <kstrcpy>
40003130: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40003134: 910223e0     	add	x0, sp, #0x88
40003138: 97fffe52     	bl	0x40002a80 <kstrcat>
4000313c: 910223e0     	add	x0, sp, #0x88
40003140: 14000003     	b	0x4000314c <tui_launch+0x39c>
40003144: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003148: 91323c00     	add	x0, x0, #0xc8f
4000314c: 940001ef     	bl	0x40003908 <uart_puts>
40003150: b9497f68     	ldr	w8, [x27, #0x97c]
40003154: eb08027f     	cmp	x19, x8
40003158: 54fffb01     	b.ne	0x400030b8 <tui_launch+0x308>
4000315c: b9497b88     	ldr	w8, [x28, #0x978]
40003160: 35fffac8     	cbnz	w8, 0x400030b8 <tui_launch+0x308>
40003164: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40003168: 912d7800     	add	x0, x0, #0xb5e
4000316c: 940001e7     	bl	0x40003908 <uart_puts>
40003170: 17ffffd2     	b	0x400030b8 <tui_launch+0x308>
40003174: b9497b88     	ldr	w8, [x28, #0x978]
40003178: 52800540     	mov	w0, #0x2a               // =42
4000317c: 528004c1     	mov	w1, #0x26               // =38
40003180: b0000022     	adrp	x2, 0x40008000 <__rodata_start+0x1000>
40003184: 91051042     	add	x2, x2, #0x144
40003188: 7100051f     	cmp	w8, #0x1
4000318c: 1a9f17e3     	cset	w3, eq
40003190: 940000de     	bl	0x40003508 <draw_box>
40003194: 52800075     	mov	w21, #0x3               // =3
40003198: aa1603e0     	mov	x0, x22
4000319c: 2a1503e1     	mov	w1, w21
400031a0: 52800562     	mov	w2, #0x2b               // =43
400031a4: 940002ee     	bl	0x40003d5c <uart_printf>
400031a8: aa1703e0     	mov	x0, x23
400031ac: 940001d7     	bl	0x40003908 <uart_puts>
400031b0: aa1703e0     	mov	x0, x23
400031b4: 940001d5     	bl	0x40003908 <uart_puts>
400031b8: aa1703e0     	mov	x0, x23
400031bc: 940001d3     	bl	0x40003908 <uart_puts>
400031c0: aa1703e0     	mov	x0, x23
400031c4: 940001d1     	bl	0x40003908 <uart_puts>
400031c8: aa1703e0     	mov	x0, x23
400031cc: 940001cf     	bl	0x40003908 <uart_puts>
400031d0: aa1703e0     	mov	x0, x23
400031d4: 940001cd     	bl	0x40003908 <uart_puts>
400031d8: aa1703e0     	mov	x0, x23
400031dc: 940001cb     	bl	0x40003908 <uart_puts>
400031e0: aa1703e0     	mov	x0, x23
400031e4: 940001c9     	bl	0x40003908 <uart_puts>
400031e8: aa1703e0     	mov	x0, x23
400031ec: 940001c7     	bl	0x40003908 <uart_puts>
400031f0: aa1703e0     	mov	x0, x23
400031f4: 940001c5     	bl	0x40003908 <uart_puts>
400031f8: aa1703e0     	mov	x0, x23
400031fc: 940001c3     	bl	0x40003908 <uart_puts>
40003200: aa1703e0     	mov	x0, x23
40003204: 940001c1     	bl	0x40003908 <uart_puts>
40003208: aa1703e0     	mov	x0, x23
4000320c: 940001bf     	bl	0x40003908 <uart_puts>
40003210: aa1703e0     	mov	x0, x23
40003214: 940001bd     	bl	0x40003908 <uart_puts>
40003218: aa1703e0     	mov	x0, x23
4000321c: 940001bb     	bl	0x40003908 <uart_puts>
40003220: aa1703e0     	mov	x0, x23
40003224: 940001b9     	bl	0x40003908 <uart_puts>
40003228: aa1703e0     	mov	x0, x23
4000322c: 940001b7     	bl	0x40003908 <uart_puts>
40003230: aa1703e0     	mov	x0, x23
40003234: 940001b5     	bl	0x40003908 <uart_puts>
40003238: aa1703e0     	mov	x0, x23
4000323c: 940001b3     	bl	0x40003908 <uart_puts>
40003240: aa1703e0     	mov	x0, x23
40003244: 940001b1     	bl	0x40003908 <uart_puts>
40003248: aa1703e0     	mov	x0, x23
4000324c: 940001af     	bl	0x40003908 <uart_puts>
40003250: aa1703e0     	mov	x0, x23
40003254: 940001ad     	bl	0x40003908 <uart_puts>
40003258: aa1703e0     	mov	x0, x23
4000325c: 940001ab     	bl	0x40003908 <uart_puts>
40003260: aa1703e0     	mov	x0, x23
40003264: 940001a9     	bl	0x40003908 <uart_puts>
40003268: aa1703e0     	mov	x0, x23
4000326c: 940001a7     	bl	0x40003908 <uart_puts>
40003270: aa1703e0     	mov	x0, x23
40003274: 940001a5     	bl	0x40003908 <uart_puts>
40003278: aa1703e0     	mov	x0, x23
4000327c: 940001a3     	bl	0x40003908 <uart_puts>
40003280: aa1703e0     	mov	x0, x23
40003284: 940001a1     	bl	0x40003908 <uart_puts>
40003288: aa1703e0     	mov	x0, x23
4000328c: 9400019f     	bl	0x40003908 <uart_puts>
40003290: aa1703e0     	mov	x0, x23
40003294: 9400019d     	bl	0x40003908 <uart_puts>
40003298: aa1703e0     	mov	x0, x23
4000329c: 9400019b     	bl	0x40003908 <uart_puts>
400032a0: aa1703e0     	mov	x0, x23
400032a4: 94000199     	bl	0x40003908 <uart_puts>
400032a8: aa1703e0     	mov	x0, x23
400032ac: 94000197     	bl	0x40003908 <uart_puts>
400032b0: aa1703e0     	mov	x0, x23
400032b4: 94000195     	bl	0x40003908 <uart_puts>
400032b8: aa1703e0     	mov	x0, x23
400032bc: 94000193     	bl	0x40003908 <uart_puts>
400032c0: aa1703e0     	mov	x0, x23
400032c4: 94000191     	bl	0x40003908 <uart_puts>
400032c8: 110006b5     	add	w21, w21, #0x1
400032cc: 71005ebf     	cmp	w21, #0x17
400032d0: 54fff641     	b.ne	0x40003198 <tui_launch+0x3e8>
400032d4: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032d8: 91178c00     	add	x0, x0, #0x5e3
400032dc: 52800061     	mov	w1, #0x3                // =3
400032e0: 52800562     	mov	w2, #0x2b               // =43
400032e4: 9400029e     	bl	0x40003d5c <uart_printf>
400032e8: d503201f     	nop
400032ec: 1005fb68     	adr	x8, 0x4000f258 <proc_table>
400032f0: aa1f03f3     	mov	x19, xzr
400032f4: 9100a115     	add	x21, x8, #0x28
400032f8: 52800058     	mov	w24, #0x2               // =2
400032fc: 90000039     	adrp	x25, 0x40007000 <__rodata_start>
40003300: 9121ab39     	add	x25, x25, #0x86a
40003304: b85fc2a8     	ldur	w8, [x21, #-0x4]
40003308: 71000d1f     	cmp	w8, #0x3
4000330c: 54000140     	b.eq	0x40003334 <tui_launch+0x584>
40003310: b94002a8     	ldr	w8, [x21]
40003314: b85d82a3     	ldur	w3, [x21, #-0x28]
40003318: d10092a4     	sub	x4, x21, #0x24
4000331c: 11000b01     	add	w1, w24, #0x2
40003320: aa1403e0     	mov	x0, x20
40003324: 52800562     	mov	w2, #0x2b               // =43
40003328: 530a7d05     	lsr	w5, w8, #10
4000332c: 9400028c     	bl	0x40003d5c <uart_printf>
40003330: 11000718     	add	w24, w24, #0x1
40003334: f1003a7f     	cmp	x19, #0xe
40003338: 540000a8     	b.hi	0x4000334c <tui_launch+0x59c>
4000333c: 7100531f     	cmp	w24, #0x14
40003340: 91000673     	add	x19, x19, #0x1
40003344: 9100c2b5     	add	x21, x21, #0x30
40003348: 54fffdeb     	b.lt	0x40003304 <tui_launch+0x554>
4000334c: 940001a3     	bl	0x400039d8 <uart_getc>
40003350: 52801be8     	mov	w8, #0xdf               // =223
40003354: 0a080008     	and	w8, w0, w8
40003358: 7101451f     	cmp	w8, #0x51
4000335c: 54000c00     	b.eq	0x400034dc <tui_launch+0x72c>
40003360: 12001c08     	and	w8, w0, #0xff
40003364: 7100311f     	cmp	w8, #0xc
40003368: 5400010c     	b.gt	0x40003388 <tui_launch+0x5d8>
4000336c: 7100251f     	cmp	w8, #0x9
40003370: b0000078     	adrp	x24, 0x40010000 <var_values+0x6a4>
40003374: 91262318     	add	x24, x24, #0x988
40003378: 54ffd540     	b.eq	0x40002e20 <tui_launch+0x70>
4000337c: 7100291f     	cmp	w8, #0xa
40003380: 540002e0     	b.eq	0x400033dc <tui_launch+0x62c>
40003384: 17fffeab     	b	0x40002e30 <tui_launch+0x80>
40003388: 7100351f     	cmp	w8, #0xd
4000338c: b0000078     	adrp	x24, 0x40010000 <var_values+0x6a4>
40003390: 91262318     	add	x24, x24, #0x988
40003394: 54000240     	b.eq	0x400033dc <tui_launch+0x62c>
40003398: 71006d1f     	cmp	w8, #0x1b
4000339c: 54ffd4a1     	b.ne	0x40002e30 <tui_launch+0x80>
400033a0: 9400018e     	bl	0x400039d8 <uart_getc>
400033a4: 12001c13     	and	w19, w0, #0xff
400033a8: 9400018c     	bl	0x400039d8 <uart_getc>
400033ac: 71016e7f     	cmp	w19, #0x5b
400033b0: 54ffd401     	b.ne	0x40002e30 <tui_launch+0x80>
400033b4: 12001c08     	and	w8, w0, #0xff
400033b8: 7101051f     	cmp	w8, #0x41
400033bc: 54000781     	b.ne	0x400034ac <tui_launch+0x6fc>
400033c0: b9497b88     	ldr	w8, [x28, #0x978]
400033c4: 35ffd368     	cbnz	w8, 0x40002e30 <tui_launch+0x80>
400033c8: b9497f68     	ldr	w8, [x27, #0x97c]
400033cc: 71000508     	subs	w8, w8, #0x1
400033d0: 54ffd30b     	b.lt	0x40002e30 <tui_launch+0x80>
400033d4: b9097f68     	str	w8, [x27, #0x97c]
400033d8: 17fffe96     	b	0x40002e30 <tui_launch+0x80>
400033dc: b9497b88     	ldr	w8, [x28, #0x978]
400033e0: 35ffd288     	cbnz	w8, 0x40002e30 <tui_launch+0x80>
400033e4: b9498348     	ldr	w8, [x26, #0x980]
400033e8: 7100051f     	cmp	w8, #0x1
400033ec: 54ffd22b     	b.lt	0x40002e30 <tui_launch+0x80>
400033f0: b9897f68     	ldrsw	x8, [x27, #0x97c]
400033f4: f8687b15     	ldr	x21, [x24, x8, lsl #3]
400033f8: b4000115     	cbz	x21, 0x40003418 <tui_launch+0x668>
400033fc: b94022a8     	ldr	w8, [x21, #0x20]
40003400: 7100051f     	cmp	w8, #0x1
40003404: 54000161     	b.ne	0x40003430 <tui_launch+0x680>
40003408: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
4000340c: b9097f7f     	str	wzr, [x27, #0x97c]
40003410: f904b915     	str	x21, [x8, #0x970]
40003414: 17fffe87     	b	0x40002e30 <tui_launch+0x80>
40003418: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
4000341c: b9097f7f     	str	wzr, [x27, #0x97c]
40003420: f944b928     	ldr	x8, [x9, #0x970]
40003424: f9421908     	ldr	x8, [x8, #0x430]
40003428: f904b928     	str	x8, [x9, #0x970]
4000342c: 17fffe81     	b	0x40002e30 <tui_launch+0x80>
40003430: 390223ff     	strb	wzr, [sp, #0x88]
40003434: aa1903e0     	mov	x0, x25
40003438: 94000612     	bl	0x40004c80 <vfs_find>
4000343c: eb0002bf     	cmp	x21, x0
40003440: 540001e0     	b.eq	0x4000347c <tui_launch+0x6cc>
40003444: 910023e0     	add	x0, sp, #0x8
40003448: 910223e1     	add	x1, sp, #0x88
4000344c: 97fffdb5     	bl	0x40002b20 <kstrcpy>
40003450: 910223e0     	add	x0, sp, #0x88
40003454: aa1903e1     	mov	x1, x25
40003458: 97fffdb2     	bl	0x40002b20 <kstrcpy>
4000345c: 910223e0     	add	x0, sp, #0x88
40003460: aa1503e1     	mov	x1, x21
40003464: 97fffd87     	bl	0x40002a80 <kstrcat>
40003468: 910223e0     	add	x0, sp, #0x88
4000346c: 910023e1     	add	x1, sp, #0x8
40003470: 97fffd84     	bl	0x40002a80 <kstrcat>
40003474: f9421ab5     	ldr	x21, [x21, #0x430]
40003478: b5fffdf5     	cbnz	x21, 0x40003434 <tui_launch+0x684>
4000347c: 910223e0     	add	x0, sp, #0x88
40003480: 97fffd79     	bl	0x40002a64 <kstrlen>
40003484: b5000080     	cbnz	x0, 0x40003494 <tui_launch+0x6e4>
40003488: 910223e0     	add	x0, sp, #0x88
4000348c: aa1903e1     	mov	x1, x25
40003490: 97fffda4     	bl	0x40002b20 <kstrcpy>
40003494: 910223e0     	add	x0, sp, #0x88
40003498: 97fff382     	bl	0x400002a0 <launch_kedit>
4000349c: d503201f     	nop
400034a0: 70029fe0     	adr	x0, 0x4000889f <__rodata_start+0x189f>
400034a4: 94000119     	bl	0x40003908 <uart_puts>
400034a8: 17fffe62     	b	0x40002e30 <tui_launch+0x80>
400034ac: 7101091f     	cmp	w8, #0x42
400034b0: 54ffcc01     	b.ne	0x40002e30 <tui_launch+0x80>
400034b4: b9497b88     	ldr	w8, [x28, #0x978]
400034b8: 35ffcbc8     	cbnz	w8, 0x40002e30 <tui_launch+0x80>
400034bc: b9498349     	ldr	w9, [x26, #0x980]
400034c0: b9497f68     	ldr	w8, [x27, #0x97c]
400034c4: 51000529     	sub	w9, w9, #0x1
400034c8: 6b09011f     	cmp	w8, w9
400034cc: 54ffcb2a     	b.ge	0x40002e30 <tui_launch+0x80>
400034d0: 11000508     	add	w8, w8, #0x1
400034d4: b9097f68     	str	w8, [x27, #0x97c]
400034d8: 17fffe56     	b	0x40002e30 <tui_launch+0x80>
400034dc: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400034e0: 912dd400     	add	x0, x0, #0xb75
400034e4: 94000109     	bl	0x40003908 <uart_puts>
400034e8: a9564ff4     	ldp	x20, x19, [sp, #0x160]
400034ec: a95557f6     	ldp	x22, x21, [sp, #0x150]
400034f0: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400034f4: a95367fa     	ldp	x26, x25, [sp, #0x130]
400034f8: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400034fc: a9517bfd     	ldp	x29, x30, [sp, #0x110]
40003500: 9105c3ff     	add	sp, sp, #0x170
40003504: d65f03c0     	ret

0000000040003508 <draw_box>:
40003508: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000350c: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40003510: 911ba908     	add	x8, x8, #0x6ea
40003514: 7100007f     	cmp	w3, #0x0
40003518: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
4000351c: 91089929     	add	x9, x9, #0x226
40003520: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003524: 2a0003f3     	mov	w19, w0
40003528: 9a880120     	csel	x0, x9, x8, eq
4000352c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003530: a90257f6     	stp	x22, x21, [sp, #0x20]
40003534: 910003fd     	mov	x29, sp
40003538: aa0203f4     	mov	x20, x2
4000353c: 2a0103f5     	mov	w21, w1
40003540: 940000f2     	bl	0x40003908 <uart_puts>
40003544: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003548: 9121b000     	add	x0, x0, #0x86c
4000354c: 52800041     	mov	w1, #0x2                // =2
40003550: 2a1303e2     	mov	w2, w19
40003554: 94000202     	bl	0x40003d5c <uart_printf>
40003558: 51000ab6     	sub	w22, w21, #0x2
4000355c: 510006b7     	sub	w23, w21, #0x1
40003560: 90000035     	adrp	x21, 0x40007000 <__rodata_start>
40003564: 911572b5     	add	x21, x21, #0x55c
40003568: 2a1603f8     	mov	w24, w22
4000356c: aa1503e0     	mov	x0, x21
40003570: 940000e6     	bl	0x40003908 <uart_puts>
40003574: 71000718     	subs	w24, w24, #0x1
40003578: 54ffffa1     	b.ne	0x4000356c <draw_box+0x64>
4000357c: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003580: 9128d800     	add	x0, x0, #0xa36
40003584: 940000e1     	bl	0x40003908 <uart_puts>
40003588: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000358c: 9121e000     	add	x0, x0, #0x878
40003590: 11000a62     	add	w2, w19, #0x2
40003594: 52800041     	mov	w1, #0x2                // =2
40003598: aa1403e3     	mov	x3, x20
4000359c: 940001f0     	bl	0x40003d5c <uart_printf>
400035a0: b0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400035a4: 91157a94     	add	x20, x20, #0x55e
400035a8: 52800061     	mov	w1, #0x3                // =3
400035ac: aa1403e0     	mov	x0, x20
400035b0: 2a1303e2     	mov	w2, w19
400035b4: 940001ea     	bl	0x40003d5c <uart_printf>
400035b8: 0b1302e2     	add	w2, w23, w19
400035bc: aa1403e0     	mov	x0, x20
400035c0: 52800061     	mov	w1, #0x3                // =3
400035c4: 940001e6     	bl	0x40003d5c <uart_printf>
400035c8: aa1403e0     	mov	x0, x20
400035cc: 52800081     	mov	w1, #0x4                // =4
400035d0: 2a1303e2     	mov	w2, w19
400035d4: 940001e2     	bl	0x40003d5c <uart_printf>
400035d8: 0b1302e2     	add	w2, w23, w19
400035dc: aa1403e0     	mov	x0, x20
400035e0: 52800081     	mov	w1, #0x4                // =4
400035e4: 940001de     	bl	0x40003d5c <uart_printf>
400035e8: aa1403e0     	mov	x0, x20
400035ec: 528000a1     	mov	w1, #0x5                // =5
400035f0: 2a1303e2     	mov	w2, w19
400035f4: 940001da     	bl	0x40003d5c <uart_printf>
400035f8: 0b1302e2     	add	w2, w23, w19
400035fc: aa1403e0     	mov	x0, x20
40003600: 528000a1     	mov	w1, #0x5                // =5
40003604: 940001d6     	bl	0x40003d5c <uart_printf>
40003608: aa1403e0     	mov	x0, x20
4000360c: 528000c1     	mov	w1, #0x6                // =6
40003610: 2a1303e2     	mov	w2, w19
40003614: 940001d2     	bl	0x40003d5c <uart_printf>
40003618: 0b1302e2     	add	w2, w23, w19
4000361c: aa1403e0     	mov	x0, x20
40003620: 528000c1     	mov	w1, #0x6                // =6
40003624: 940001ce     	bl	0x40003d5c <uart_printf>
40003628: aa1403e0     	mov	x0, x20
4000362c: 528000e1     	mov	w1, #0x7                // =7
40003630: 2a1303e2     	mov	w2, w19
40003634: 940001ca     	bl	0x40003d5c <uart_printf>
40003638: 0b1302e2     	add	w2, w23, w19
4000363c: aa1403e0     	mov	x0, x20
40003640: 528000e1     	mov	w1, #0x7                // =7
40003644: 940001c6     	bl	0x40003d5c <uart_printf>
40003648: aa1403e0     	mov	x0, x20
4000364c: 52800101     	mov	w1, #0x8                // =8
40003650: 2a1303e2     	mov	w2, w19
40003654: 940001c2     	bl	0x40003d5c <uart_printf>
40003658: 0b1302e2     	add	w2, w23, w19
4000365c: aa1403e0     	mov	x0, x20
40003660: 52800101     	mov	w1, #0x8                // =8
40003664: 940001be     	bl	0x40003d5c <uart_printf>
40003668: aa1403e0     	mov	x0, x20
4000366c: 52800121     	mov	w1, #0x9                // =9
40003670: 2a1303e2     	mov	w2, w19
40003674: 940001ba     	bl	0x40003d5c <uart_printf>
40003678: 0b1302e2     	add	w2, w23, w19
4000367c: aa1403e0     	mov	x0, x20
40003680: 52800121     	mov	w1, #0x9                // =9
40003684: 940001b6     	bl	0x40003d5c <uart_printf>
40003688: aa1403e0     	mov	x0, x20
4000368c: 52800141     	mov	w1, #0xa                // =10
40003690: 2a1303e2     	mov	w2, w19
40003694: 940001b2     	bl	0x40003d5c <uart_printf>
40003698: 0b1302e2     	add	w2, w23, w19
4000369c: aa1403e0     	mov	x0, x20
400036a0: 52800141     	mov	w1, #0xa                // =10
400036a4: 940001ae     	bl	0x40003d5c <uart_printf>
400036a8: aa1403e0     	mov	x0, x20
400036ac: 52800161     	mov	w1, #0xb                // =11
400036b0: 2a1303e2     	mov	w2, w19
400036b4: 940001aa     	bl	0x40003d5c <uart_printf>
400036b8: 0b1302e2     	add	w2, w23, w19
400036bc: aa1403e0     	mov	x0, x20
400036c0: 52800161     	mov	w1, #0xb                // =11
400036c4: 940001a6     	bl	0x40003d5c <uart_printf>
400036c8: aa1403e0     	mov	x0, x20
400036cc: 52800181     	mov	w1, #0xc                // =12
400036d0: 2a1303e2     	mov	w2, w19
400036d4: 940001a2     	bl	0x40003d5c <uart_printf>
400036d8: 0b1302e2     	add	w2, w23, w19
400036dc: aa1403e0     	mov	x0, x20
400036e0: 52800181     	mov	w1, #0xc                // =12
400036e4: 9400019e     	bl	0x40003d5c <uart_printf>
400036e8: aa1403e0     	mov	x0, x20
400036ec: 528001a1     	mov	w1, #0xd                // =13
400036f0: 2a1303e2     	mov	w2, w19
400036f4: 9400019a     	bl	0x40003d5c <uart_printf>
400036f8: 0b1302e2     	add	w2, w23, w19
400036fc: aa1403e0     	mov	x0, x20
40003700: 528001a1     	mov	w1, #0xd                // =13
40003704: 94000196     	bl	0x40003d5c <uart_printf>
40003708: aa1403e0     	mov	x0, x20
4000370c: 528001c1     	mov	w1, #0xe                // =14
40003710: 2a1303e2     	mov	w2, w19
40003714: 94000192     	bl	0x40003d5c <uart_printf>
40003718: 0b1302e2     	add	w2, w23, w19
4000371c: aa1403e0     	mov	x0, x20
40003720: 528001c1     	mov	w1, #0xe                // =14
40003724: 9400018e     	bl	0x40003d5c <uart_printf>
40003728: aa1403e0     	mov	x0, x20
4000372c: 528001e1     	mov	w1, #0xf                // =15
40003730: 2a1303e2     	mov	w2, w19
40003734: 9400018a     	bl	0x40003d5c <uart_printf>
40003738: 0b1302e2     	add	w2, w23, w19
4000373c: aa1403e0     	mov	x0, x20
40003740: 528001e1     	mov	w1, #0xf                // =15
40003744: 94000186     	bl	0x40003d5c <uart_printf>
40003748: aa1403e0     	mov	x0, x20
4000374c: 52800201     	mov	w1, #0x10               // =16
40003750: 2a1303e2     	mov	w2, w19
40003754: 94000182     	bl	0x40003d5c <uart_printf>
40003758: 0b1302e2     	add	w2, w23, w19
4000375c: aa1403e0     	mov	x0, x20
40003760: 52800201     	mov	w1, #0x10               // =16
40003764: 9400017e     	bl	0x40003d5c <uart_printf>
40003768: aa1403e0     	mov	x0, x20
4000376c: 52800221     	mov	w1, #0x11               // =17
40003770: 2a1303e2     	mov	w2, w19
40003774: 9400017a     	bl	0x40003d5c <uart_printf>
40003778: 0b1302e2     	add	w2, w23, w19
4000377c: aa1403e0     	mov	x0, x20
40003780: 52800221     	mov	w1, #0x11               // =17
40003784: 94000176     	bl	0x40003d5c <uart_printf>
40003788: aa1403e0     	mov	x0, x20
4000378c: 52800241     	mov	w1, #0x12               // =18
40003790: 2a1303e2     	mov	w2, w19
40003794: 94000172     	bl	0x40003d5c <uart_printf>
40003798: 0b1302e2     	add	w2, w23, w19
4000379c: aa1403e0     	mov	x0, x20
400037a0: 52800241     	mov	w1, #0x12               // =18
400037a4: 9400016e     	bl	0x40003d5c <uart_printf>
400037a8: aa1403e0     	mov	x0, x20
400037ac: 52800261     	mov	w1, #0x13               // =19
400037b0: 2a1303e2     	mov	w2, w19
400037b4: 9400016a     	bl	0x40003d5c <uart_printf>
400037b8: 0b1302e2     	add	w2, w23, w19
400037bc: aa1403e0     	mov	x0, x20
400037c0: 52800261     	mov	w1, #0x13               // =19
400037c4: 94000166     	bl	0x40003d5c <uart_printf>
400037c8: aa1403e0     	mov	x0, x20
400037cc: 52800281     	mov	w1, #0x14               // =20
400037d0: 2a1303e2     	mov	w2, w19
400037d4: 94000162     	bl	0x40003d5c <uart_printf>
400037d8: 0b1302e2     	add	w2, w23, w19
400037dc: aa1403e0     	mov	x0, x20
400037e0: 52800281     	mov	w1, #0x14               // =20
400037e4: 9400015e     	bl	0x40003d5c <uart_printf>
400037e8: aa1403e0     	mov	x0, x20
400037ec: 528002a1     	mov	w1, #0x15               // =21
400037f0: 2a1303e2     	mov	w2, w19
400037f4: 9400015a     	bl	0x40003d5c <uart_printf>
400037f8: 0b1302e2     	add	w2, w23, w19
400037fc: aa1403e0     	mov	x0, x20
40003800: 528002a1     	mov	w1, #0x15               // =21
40003804: 94000156     	bl	0x40003d5c <uart_printf>
40003808: aa1403e0     	mov	x0, x20
4000380c: 528002c1     	mov	w1, #0x16               // =22
40003810: 2a1303e2     	mov	w2, w19
40003814: 94000152     	bl	0x40003d5c <uart_printf>
40003818: 0b1302e2     	add	w2, w23, w19
4000381c: aa1403e0     	mov	x0, x20
40003820: 528002c1     	mov	w1, #0x16               // =22
40003824: 9400014e     	bl	0x40003d5c <uart_printf>
40003828: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000382c: 91174c00     	add	x0, x0, #0x5d3
40003830: 528002e1     	mov	w1, #0x17               // =23
40003834: 2a1303e2     	mov	w2, w19
40003838: 94000149     	bl	0x40003d5c <uart_printf>
4000383c: 90000033     	adrp	x19, 0x40007000 <__rodata_start>
40003840: 91157273     	add	x19, x19, #0x55c
40003844: aa1303e0     	mov	x0, x19
40003848: 94000030     	bl	0x40003908 <uart_puts>
4000384c: 710006d6     	subs	w22, w22, #0x1
40003850: 54ffffa1     	b.ne	0x40003844 <draw_box+0x33c>
40003854: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003858: 91177c00     	add	x0, x0, #0x5df
4000385c: 9400002b     	bl	0x40003908 <uart_puts>
40003860: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003864: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40003868: 912d7800     	add	x0, x0, #0xb5e
4000386c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003870: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003874: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003878: 14000024     	b	0x40003908 <uart_puts>

000000004000387c <uart_init>:
4000387c: 52800608     	mov	w8, #0x30               // =48
40003880: 528001a9     	mov	w9, #0xd                // =13
40003884: 5280002a     	mov	w10, #0x1               // =1
40003888: 72a12008     	movk	w8, #0x900, lsl #16
4000388c: b900011f     	str	wzr, [x8]
40003890: b81f4109     	stur	w9, [x8, #-0xc]
40003894: 52800e09     	mov	w9, #0x70               // =112
40003898: b81f810a     	stur	w10, [x8, #-0x8]
4000389c: b81fc109     	stur	w9, [x8, #-0x4]
400038a0: 52806029     	mov	w9, #0x301              // =769
400038a4: b9000109     	str	w9, [x8]
400038a8: d65f03c0     	ret

00000000400038ac <uart_putc>:
400038ac: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
400038b0: b94b8908     	ldr	w8, [x8, #0xb88]
400038b4: 340001a8     	cbz	w8, 0x400038e8 <uart_putc+0x3c>
400038b8: b0000068     	adrp	x8, 0x40010000 <var_values+0x6a4>
400038bc: 5287ffca     	mov	w10, #0x3ffe            // =16382
400038c0: b94b8d09     	ldr	w9, [x8, #0xb8c]
400038c4: 6b0a013f     	cmp	w9, w10
400038c8: 5400010c     	b.gt	0x400038e8 <uart_putc+0x3c>
400038cc: 93407d29     	sxtw	x9, w9
400038d0: d503201f     	nop
400038d4: 100695ea     	adr	x10, 0x40010b90 <kernel_capture_buffer>
400038d8: 9100052b     	add	x11, x9, #0x1
400038dc: 38296940     	strb	w0, [x10, x9]
400038e0: b90b8d0b     	str	w11, [x8, #0xb8c]
400038e4: 382b695f     	strb	wzr, [x10, x11]
400038e8: 52800308     	mov	w8, #0x18               // =24
400038ec: 72a12008     	movk	w8, #0x900, lsl #16
400038f0: b9400109     	ldr	w9, [x8]
400038f4: 372fffe9     	tbnz	w9, #0x5, 0x400038f0 <uart_putc+0x44>
400038f8: 12001c08     	and	w8, w0, #0xff
400038fc: 52a12009     	mov	w9, #0x9000000          // =150994944
40003900: b9000128     	str	w8, [x9]
40003904: d65f03c0     	ret

0000000040003908 <uart_puts>:
40003908: 52800308     	mov	w8, #0x18               // =24
4000390c: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
40003910: b000006a     	adrp	x10, 0x40010000 <var_values+0x6a4>
40003914: 72a12008     	movk	w8, #0x900, lsl #16
40003918: d503201f     	nop
4000391c: 100693ab     	adr	x11, 0x40010b90 <kernel_capture_buffer>
40003920: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003924: 528001ad     	mov	w13, #0xd               // =13
40003928: 52a1200e     	mov	w14, #0x9000000         // =150994944
4000392c: 3940000f     	ldrb	w15, [x0]
40003930: 710029ff     	cmp	w15, #0xa
40003934: 540000a0     	b.eq	0x40003948 <uart_puts+0x40>
40003938: 3400042f     	cbz	w15, 0x400039bc <uart_puts+0xb4>
4000393c: b94b8930     	ldr	w16, [x9, #0xb88]
40003940: 35000250     	cbnz	w16, 0x40003988 <uart_puts+0x80>
40003944: 14000019     	b	0x400039a8 <uart_puts+0xa0>
40003948: b94b892f     	ldr	w15, [x9, #0xb88]
4000394c: 3400012f     	cbz	w15, 0x40003970 <uart_puts+0x68>
40003950: b94b8d4f     	ldr	w15, [x10, #0xb8c]
40003954: 6b0c01ff     	cmp	w15, w12
40003958: 540000cc     	b.gt	0x40003970 <uart_puts+0x68>
4000395c: 93407def     	sxtw	x15, w15
40003960: 910005f0     	add	x16, x15, #0x1
40003964: 382f696d     	strb	w13, [x11, x15]
40003968: b90b8d50     	str	w16, [x10, #0xb8c]
4000396c: 3830697f     	strb	wzr, [x11, x16]
40003970: b940010f     	ldr	w15, [x8]
40003974: 372fffef     	tbnz	w15, #0x5, 0x40003970 <uart_puts+0x68>
40003978: b90001cd     	str	w13, [x14]
4000397c: 3940000f     	ldrb	w15, [x0]
40003980: b94b8930     	ldr	w16, [x9, #0xb88]
40003984: 34000130     	cbz	w16, 0x400039a8 <uart_puts+0xa0>
40003988: b94b8d50     	ldr	w16, [x10, #0xb8c]
4000398c: 6b0c021f     	cmp	w16, w12
40003990: 540000cc     	b.gt	0x400039a8 <uart_puts+0xa0>
40003994: 93407e10     	sxtw	x16, w16
40003998: 91000611     	add	x17, x16, #0x1
4000399c: 3830696f     	strb	w15, [x11, x16]
400039a0: b90b8d51     	str	w17, [x10, #0xb8c]
400039a4: 3831697f     	strb	wzr, [x11, x17]
400039a8: 91000400     	add	x0, x0, #0x1
400039ac: b9400110     	ldr	w16, [x8]
400039b0: 372ffff0     	tbnz	w16, #0x5, 0x400039ac <uart_puts+0xa4>
400039b4: b90001cf     	str	w15, [x14]
400039b8: 17ffffdd     	b	0x4000392c <uart_puts+0x24>
400039bc: d65f03c0     	ret

00000000400039c0 <uart_has_data>:
400039c0: 52800308     	mov	w8, #0x18               // =24
400039c4: 52800029     	mov	w9, #0x1                // =1
400039c8: 72a12008     	movk	w8, #0x900, lsl #16
400039cc: b9400108     	ldr	w8, [x8]
400039d0: 0a681120     	bic	w0, w9, w8, lsr #4
400039d4: d65f03c0     	ret

00000000400039d8 <uart_getc>:
400039d8: 52800308     	mov	w8, #0x18               // =24
400039dc: 72a12008     	movk	w8, #0x900, lsl #16
400039e0: b9400109     	ldr	w9, [x8]
400039e4: 3727ffe9     	tbnz	w9, #0x4, 0x400039e0 <uart_getc+0x8>
400039e8: 52a12008     	mov	w8, #0x9000000          // =150994944
400039ec: b9400100     	ldr	w0, [x8]
400039f0: d65f03c0     	ret

00000000400039f4 <uart_print_hex_raw>:
400039f4: 52800308     	mov	w8, #0x18               // =24
400039f8: 2a1f03eb     	mov	w11, wzr
400039fc: 5280078c     	mov	w12, #0x3c              // =60
40003a00: 72a12008     	movk	w8, #0x900, lsl #16
40003a04: d503201f     	nop
40003a08: 3001d78e     	adr	x14, 0x400074f9 <__rodata_start+0x4f9>
40003a0c: b000006d     	adrp	x13, 0x40010000 <var_values+0x6a4>
40003a10: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
40003a14: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003a18: d503201f     	nop
40003a1c: 10068baa     	adr	x10, 0x40010b90 <kernel_capture_buffer>
40003a20: 52a12010     	mov	w16, #0x9000000         // =150994944
40003a24: 14000003     	b	0x40003a30 <uart_print_hex_raw+0x3c>
40003a28: b400032c     	cbz	x12, 0x40003a8c <uart_print_hex_raw+0x98>
40003a2c: d100118c     	sub	x12, x12, #0x4
40003a30: 9acc2411     	lsr	x17, x0, x12
40003a34: 53027d92     	lsr	w18, w12, #2
40003a38: 92400e31     	and	x17, x17, #0xf
40003a3c: 6b01025f     	cmp	w18, w1
40003a40: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003a44: 1a9f056b     	csinc	w11, w11, wzr, eq
40003a48: 34ffff0b     	cbz	w11, 0x40003a28 <uart_print_hex_raw+0x34>
40003a4c: b94b89b2     	ldr	w18, [x13, #0xb88]
40003a50: 387169d1     	ldrb	w17, [x14, x17]
40003a54: 34000132     	cbz	w18, 0x40003a78 <uart_print_hex_raw+0x84>
40003a58: b94b8d32     	ldr	w18, [x9, #0xb8c]
40003a5c: 6b0f025f     	cmp	w18, w15
40003a60: 540000cc     	b.gt	0x40003a78 <uart_print_hex_raw+0x84>
40003a64: 93407e52     	sxtw	x18, w18
40003a68: 91000642     	add	x2, x18, #0x1
40003a6c: 38326951     	strb	w17, [x10, x18]
40003a70: b90b8d22     	str	w2, [x9, #0xb8c]
40003a74: 3822695f     	strb	wzr, [x10, x2]
40003a78: b9400112     	ldr	w18, [x8]
40003a7c: 372ffff2     	tbnz	w18, #0x5, 0x40003a78 <uart_print_hex_raw+0x84>
40003a80: b9000211     	str	w17, [x16]
40003a84: b5fffd4c     	cbnz	x12, 0x40003a2c <uart_print_hex_raw+0x38>
40003a88: d65f03c0     	ret
40003a8c: b94b89ab     	ldr	w11, [x13, #0xb88]
40003a90: 3400016b     	cbz	w11, 0x40003abc <uart_print_hex_raw+0xc8>
40003a94: b94b8d2b     	ldr	w11, [x9, #0xb8c]
40003a98: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003a9c: 6b0c017f     	cmp	w11, w12
40003aa0: 540000ec     	b.gt	0x40003abc <uart_print_hex_raw+0xc8>
40003aa4: 93407d6b     	sxtw	x11, w11
40003aa8: 5280060c     	mov	w12, #0x30              // =48
40003aac: 9100056d     	add	x13, x11, #0x1
40003ab0: 382b694c     	strb	w12, [x10, x11]
40003ab4: b90b8d2d     	str	w13, [x9, #0xb8c]
40003ab8: 382d695f     	strb	wzr, [x10, x13]
40003abc: b9400109     	ldr	w9, [x8]
40003ac0: 372fffe9     	tbnz	w9, #0x5, 0x40003abc <uart_print_hex_raw+0xc8>
40003ac4: 52a12008     	mov	w8, #0x9000000          // =150994944
40003ac8: 52800609     	mov	w9, #0x30               // =48
40003acc: b9000109     	str	w9, [x8]
40003ad0: d65f03c0     	ret

0000000040003ad4 <uart_print_hex>:
40003ad4: 52800308     	mov	w8, #0x18               // =24
40003ad8: b000002c     	adrp	x12, 0x40008000 <__rodata_start+0x1000>
40003adc: 9105458c     	add	x12, x12, #0x151
40003ae0: 72a12008     	movk	w8, #0x900, lsl #16
40003ae4: b000006b     	adrp	x11, 0x40010000 <var_values+0x6a4>
40003ae8: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
40003aec: d503201f     	nop
40003af0: 1006850a     	adr	x10, 0x40010b90 <kernel_capture_buffer>
40003af4: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003af8: 528001ae     	mov	w14, #0xd               // =13
40003afc: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003b00: 39400190     	ldrb	w16, [x12]
40003b04: 71002a1f     	cmp	w16, #0xa
40003b08: 540000a0     	b.eq	0x40003b1c <uart_print_hex+0x48>
40003b0c: 34000410     	cbz	w16, 0x40003b8c <uart_print_hex+0xb8>
40003b10: b94b8971     	ldr	w17, [x11, #0xb88]
40003b14: 35000231     	cbnz	w17, 0x40003b58 <uart_print_hex+0x84>
40003b18: 14000018     	b	0x40003b78 <uart_print_hex+0xa4>
40003b1c: b94b8971     	ldr	w17, [x11, #0xb88]
40003b20: 34000131     	cbz	w17, 0x40003b44 <uart_print_hex+0x70>
40003b24: b94b8d31     	ldr	w17, [x9, #0xb8c]
40003b28: 6b0d023f     	cmp	w17, w13
40003b2c: 540000cc     	b.gt	0x40003b44 <uart_print_hex+0x70>
40003b30: 93407e31     	sxtw	x17, w17
40003b34: 91000632     	add	x18, x17, #0x1
40003b38: 3831694e     	strb	w14, [x10, x17]
40003b3c: b90b8d32     	str	w18, [x9, #0xb8c]
40003b40: 3832695f     	strb	wzr, [x10, x18]
40003b44: b9400111     	ldr	w17, [x8]
40003b48: 372ffff1     	tbnz	w17, #0x5, 0x40003b44 <uart_print_hex+0x70>
40003b4c: b90001ee     	str	w14, [x15]
40003b50: b94b8971     	ldr	w17, [x11, #0xb88]
40003b54: 34000131     	cbz	w17, 0x40003b78 <uart_print_hex+0xa4>
40003b58: b94b8d31     	ldr	w17, [x9, #0xb8c]
40003b5c: 6b0d023f     	cmp	w17, w13
40003b60: 540000cc     	b.gt	0x40003b78 <uart_print_hex+0xa4>
40003b64: 93407e31     	sxtw	x17, w17
40003b68: 91000632     	add	x18, x17, #0x1
40003b6c: 38316950     	strb	w16, [x10, x17]
40003b70: b90b8d32     	str	w18, [x9, #0xb8c]
40003b74: 3832695f     	strb	wzr, [x10, x18]
40003b78: 9100058c     	add	x12, x12, #0x1
40003b7c: b9400111     	ldr	w17, [x8]
40003b80: 372ffff1     	tbnz	w17, #0x5, 0x40003b7c <uart_print_hex+0xa8>
40003b84: b90001f0     	str	w16, [x15]
40003b88: 17ffffde     	b	0x40003b00 <uart_print_hex+0x2c>
40003b8c: 2a1f03ec     	mov	w12, wzr
40003b90: d503201f     	nop
40003b94: 3001cb2d     	adr	x13, 0x400074f9 <__rodata_start+0x4f9>
40003b98: 5280078e     	mov	w14, #0x3c              // =60
40003b9c: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003ba0: 52a12010     	mov	w16, #0x9000000         // =150994944
40003ba4: 14000003     	b	0x40003bb0 <uart_print_hex+0xdc>
40003ba8: b40002ee     	cbz	x14, 0x40003c04 <uart_print_hex+0x130>
40003bac: d10011ce     	sub	x14, x14, #0x4
40003bb0: 9ace2411     	lsr	x17, x0, x14
40003bb4: f2400e31     	ands	x17, x17, #0xf
40003bb8: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003bbc: 1a9f158c     	csinc	w12, w12, wzr, ne
40003bc0: 34ffff4c     	cbz	w12, 0x40003ba8 <uart_print_hex+0xd4>
40003bc4: b94b8972     	ldr	w18, [x11, #0xb88]
40003bc8: 387169b1     	ldrb	w17, [x13, x17]
40003bcc: 34000132     	cbz	w18, 0x40003bf0 <uart_print_hex+0x11c>
40003bd0: b94b8d32     	ldr	w18, [x9, #0xb8c]
40003bd4: 6b0f025f     	cmp	w18, w15
40003bd8: 540000cc     	b.gt	0x40003bf0 <uart_print_hex+0x11c>
40003bdc: 93407e52     	sxtw	x18, w18
40003be0: 91000641     	add	x1, x18, #0x1
40003be4: 38326951     	strb	w17, [x10, x18]
40003be8: b90b8d21     	str	w1, [x9, #0xb8c]
40003bec: 3821695f     	strb	wzr, [x10, x1]
40003bf0: b9400112     	ldr	w18, [x8]
40003bf4: 372ffff2     	tbnz	w18, #0x5, 0x40003bf0 <uart_print_hex+0x11c>
40003bf8: b9000211     	str	w17, [x16]
40003bfc: b5fffd8e     	cbnz	x14, 0x40003bac <uart_print_hex+0xd8>
40003c00: d65f03c0     	ret
40003c04: b94b896b     	ldr	w11, [x11, #0xb88]
40003c08: 3400016b     	cbz	w11, 0x40003c34 <uart_print_hex+0x160>
40003c0c: b94b8d2b     	ldr	w11, [x9, #0xb8c]
40003c10: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003c14: 6b0c017f     	cmp	w11, w12
40003c18: 540000ec     	b.gt	0x40003c34 <uart_print_hex+0x160>
40003c1c: 93407d6b     	sxtw	x11, w11
40003c20: 5280060c     	mov	w12, #0x30              // =48
40003c24: 9100056d     	add	x13, x11, #0x1
40003c28: 382b694c     	strb	w12, [x10, x11]
40003c2c: b90b8d2d     	str	w13, [x9, #0xb8c]
40003c30: 382d695f     	strb	wzr, [x10, x13]
40003c34: b9400109     	ldr	w9, [x8]
40003c38: 372fffe9     	tbnz	w9, #0x5, 0x40003c34 <uart_print_hex+0x160>
40003c3c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003c40: 52800609     	mov	w9, #0x30               // =48
40003c44: b9000109     	str	w9, [x8]
40003c48: d65f03c0     	ret

0000000040003c4c <uart_print_dec>:
40003c4c: d10083ff     	sub	sp, sp, #0x20
40003c50: 52800308     	mov	w8, #0x18               // =24
40003c54: 72a12008     	movk	w8, #0x900, lsl #16
40003c58: b4000540     	cbz	x0, 0x40003d00 <uart_print_dec+0xb4>
40003c5c: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003c60: aa1f03e9     	mov	x9, xzr
40003c64: 5280014b     	mov	w11, #0xa               // =10
40003c68: f29999aa     	movk	x10, #0xcccd
40003c6c: 910023ec     	add	x12, sp, #0x8
40003c70: 9bca7c0d     	umulh	x13, x0, x10
40003c74: f100241f     	cmp	x0, #0x9
40003c78: d343fdad     	lsr	x13, x13, #3
40003c7c: 1b0b81ae     	msub	w14, w13, w11, w0
40003c80: aa0d03e0     	mov	x0, x13
40003c84: 321c05ce     	orr	w14, w14, #0x30
40003c88: 3829698e     	strb	w14, [x12, x9]
40003c8c: 91000529     	add	x9, x9, #0x1
40003c90: 54ffff08     	b.hi	0x40003c70 <uart_print_dec+0x24>
40003c94: 910023ea     	add	x10, sp, #0x8
40003c98: b000006b     	adrp	x11, 0x40010000 <var_values+0x6a4>
40003c9c: b000006c     	adrp	x12, 0x40010000 <var_values+0x6a4>
40003ca0: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003ca4: d503201f     	nop
40003ca8: 1006774e     	adr	x14, 0x40010b90 <kernel_capture_buffer>
40003cac: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003cb0: d1000530     	sub	x16, x9, #0x1
40003cb4: b94b8972     	ldr	w18, [x11, #0xb88]
40003cb8: 38706951     	ldrb	w17, [x10, x16]
40003cbc: 34000132     	cbz	w18, 0x40003ce0 <uart_print_dec+0x94>
40003cc0: b94b8d92     	ldr	w18, [x12, #0xb8c]
40003cc4: 6b0d025f     	cmp	w18, w13
40003cc8: 540000cc     	b.gt	0x40003ce0 <uart_print_dec+0x94>
40003ccc: 93407e52     	sxtw	x18, w18
40003cd0: 91000640     	add	x0, x18, #0x1
40003cd4: 383269d1     	strb	w17, [x14, x18]
40003cd8: b90b8d80     	str	w0, [x12, #0xb8c]
40003cdc: 382069df     	strb	wzr, [x14, x0]
40003ce0: b9400112     	ldr	w18, [x8]
40003ce4: 372ffff2     	tbnz	w18, #0x5, 0x40003ce0 <uart_print_dec+0x94>
40003ce8: 7100053f     	cmp	w9, #0x1
40003cec: aa1003e9     	mov	x9, x16
40003cf0: b90001f1     	str	w17, [x15]
40003cf4: 54fffdec     	b.gt	0x40003cb0 <uart_print_dec+0x64>
40003cf8: 910083ff     	add	sp, sp, #0x20
40003cfc: d65f03c0     	ret
40003d00: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
40003d04: b94b8929     	ldr	w9, [x9, #0xb88]
40003d08: 340001c9     	cbz	w9, 0x40003d40 <uart_print_dec+0xf4>
40003d0c: b0000069     	adrp	x9, 0x40010000 <var_values+0x6a4>
40003d10: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003d14: b94b8d2a     	ldr	w10, [x9, #0xb8c]
40003d18: 6b0b015f     	cmp	w10, w11
40003d1c: 5400012c     	b.gt	0x40003d40 <uart_print_dec+0xf4>
40003d20: 93407d4a     	sxtw	x10, w10
40003d24: d503201f     	nop
40003d28: 1006734b     	adr	x11, 0x40010b90 <kernel_capture_buffer>
40003d2c: 5280060c     	mov	w12, #0x30              // =48
40003d30: 9100054d     	add	x13, x10, #0x1
40003d34: 382a696c     	strb	w12, [x11, x10]
40003d38: b90b8d2d     	str	w13, [x9, #0xb8c]
40003d3c: 382d697f     	strb	wzr, [x11, x13]
40003d40: b9400109     	ldr	w9, [x8]
40003d44: 372fffe9     	tbnz	w9, #0x5, 0x40003d40 <uart_print_dec+0xf4>
40003d48: 52a12008     	mov	w8, #0x9000000          // =150994944
40003d4c: 52800609     	mov	w9, #0x30               // =48
40003d50: b9000109     	str	w9, [x8]
40003d54: 910083ff     	add	sp, sp, #0x20
40003d58: d65f03c0     	ret

0000000040003d5c <uart_printf>:
40003d5c: d10343ff     	sub	sp, sp, #0xd0
40003d60: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003d64: 9101c3fd     	add	x29, sp, #0x70
40003d68: 910003e8     	mov	x8, sp
40003d6c: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003d70: 52800315     	mov	w21, #0x18              // =24
40003d74: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003d78: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003d7c: 72a12015     	movk	w21, #0x900, lsl #16
40003d80: 128006e9     	mov	w9, #-0x38              // =-56
40003d84: a90967fa     	stp	x26, x25, [sp, #0x90]
40003d88: 9100e108     	add	x8, x8, #0x38
40003d8c: 910183aa     	add	x10, x29, #0x60
40003d90: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003d94: b0000076     	adrp	x22, 0x40010000 <var_values+0x6a4>
40003d98: b0000077     	adrp	x23, 0x40010000 <var_values+0x6a4>
40003d9c: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003da0: aa0003f3     	mov	x19, x0
40003da4: aa1f03f4     	mov	x20, xzr
40003da8: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003dac: d503201f     	nop
40003db0: 10066f19     	adr	x25, 0x40010b90 <kernel_capture_buffer>
40003db4: 528001ba     	mov	w26, #0xd               // =13
40003db8: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003dbc: 528004ae     	mov	w14, #0x25              // =37
40003dc0: f29999af     	movk	x15, #0xcccd
40003dc4: 52800150     	mov	w16, #0xa               // =10
40003dc8: d10063bc     	sub	x28, x29, #0x18
40003dcc: d503201f     	nop
40003dd0: 3001b951     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
40003dd4: a9000be1     	stp	x1, x2, [sp]
40003dd8: a90113e3     	stp	x3, x4, [sp, #0x10]
40003ddc: a9021be5     	stp	x5, x6, [sp, #0x20]
40003de0: f9002be9     	str	x9, [sp, #0x50]
40003de4: f90023e8     	str	x8, [sp, #0x40]
40003de8: a9032be7     	stp	x7, x10, [sp, #0x30]
40003dec: 14000004     	b	0x40003dfc <uart_printf+0xa0>
40003df0: 52800608     	mov	w8, #0x30               // =48
40003df4: b9000368     	str	w8, [x27]
40003df8: 91000694     	add	x20, x20, #0x1
40003dfc: 38746a68     	ldrb	w8, [x19, x20]
40003e00: 7100291f     	cmp	w8, #0xa
40003e04: 54000440     	b.eq	0x40003e8c <uart_printf+0x130>
40003e08: 7100951f     	cmp	w8, #0x25
40003e0c: 540000a0     	b.eq	0x40003e20 <uart_printf+0xc4>
40003e10: 34003ae8     	cbz	w8, 0x4000456c <uart_printf+0x810>
40003e14: b94b8ac9     	ldr	w9, [x22, #0xb88]
40003e18: 350005a9     	cbnz	w9, 0x40003ecc <uart_printf+0x170>
40003e1c: 14000034     	b	0x40003eec <uart_printf+0x190>
40003e20: 9100068a     	add	x10, x20, #0x1
40003e24: 386a6a68     	ldrb	w8, [x19, x10]
40003e28: 7101b11f     	cmp	w8, #0x6c
40003e2c: 54000661     	b.ne	0x40003ef8 <uart_printf+0x19c>
40003e30: 91000a89     	add	x9, x20, #0x2
40003e34: 91000e8b     	add	x11, x20, #0x3
40003e38: 38696a6a     	ldrb	w10, [x19, x9]
40003e3c: 7101b15f     	cmp	w10, #0x6c
40003e40: 9a890174     	csel	x20, x11, x9, eq
40003e44: 38746a69     	ldrb	w9, [x19, x20]
40003e48: 7101bd3f     	cmp	w9, #0x6f
40003e4c: 540005ed     	b.le	0x40003f08 <uart_printf+0x1ac>
40003e50: 7101d13f     	cmp	w9, #0x74
40003e54: 5400080c     	b.gt	0x40003f54 <uart_printf+0x1f8>
40003e58: 7101c13f     	cmp	w9, #0x70
40003e5c: 54000f00     	b.eq	0x4000403c <uart_printf+0x2e0>
40003e60: 7101cd3f     	cmp	w9, #0x73
40003e64: 54000b61     	b.ne	0x40003fd0 <uart_printf+0x274>
40003e68: b98053e8     	ldrsw	x8, [sp, #0x50]
40003e6c: 36f81408     	tbz	w8, #0x1f, 0x400040ec <uart_printf+0x390>
40003e70: 11002109     	add	w9, w8, #0x8
40003e74: 3100211f     	cmn	w8, #0x8
40003e78: b90053e9     	str	w9, [sp, #0x50]
40003e7c: 54001388     	b.hi	0x400040ec <uart_printf+0x390>
40003e80: f94023e9     	ldr	x9, [sp, #0x40]
40003e84: 8b080128     	add	x8, x9, x8
40003e88: 1400009c     	b	0x400040f8 <uart_printf+0x39c>
40003e8c: b94b8ac8     	ldr	w8, [x22, #0xb88]
40003e90: 34000128     	cbz	w8, 0x40003eb4 <uart_printf+0x158>
40003e94: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40003e98: 6b18011f     	cmp	w8, w24
40003e9c: 540000cc     	b.gt	0x40003eb4 <uart_printf+0x158>
40003ea0: 93407d08     	sxtw	x8, w8
40003ea4: 91000509     	add	x9, x8, #0x1
40003ea8: 38286b3a     	strb	w26, [x25, x8]
40003eac: b90b8ee9     	str	w9, [x23, #0xb8c]
40003eb0: 38296b3f     	strb	wzr, [x25, x9]
40003eb4: b94002a8     	ldr	w8, [x21]
40003eb8: 372fffe8     	tbnz	w8, #0x5, 0x40003eb4 <uart_printf+0x158>
40003ebc: b900037a     	str	w26, [x27]
40003ec0: 38746a68     	ldrb	w8, [x19, x20]
40003ec4: b94b8ac9     	ldr	w9, [x22, #0xb88]
40003ec8: 34000129     	cbz	w9, 0x40003eec <uart_printf+0x190>
40003ecc: b94b8ee9     	ldr	w9, [x23, #0xb8c]
40003ed0: 6b18013f     	cmp	w9, w24
40003ed4: 540000cc     	b.gt	0x40003eec <uart_printf+0x190>
40003ed8: 93407d29     	sxtw	x9, w9
40003edc: 9100052a     	add	x10, x9, #0x1
40003ee0: 38296b28     	strb	w8, [x25, x9]
40003ee4: b90b8eea     	str	w10, [x23, #0xb8c]
40003ee8: 382a6b3f     	strb	wzr, [x25, x10]
40003eec: b94002a9     	ldr	w9, [x21]
40003ef0: 372fffe9     	tbnz	w9, #0x5, 0x40003eec <uart_printf+0x190>
40003ef4: 17ffffc0     	b	0x40003df4 <uart_printf+0x98>
40003ef8: 2a0803e9     	mov	w9, w8
40003efc: aa0a03f4     	mov	x20, x10
40003f00: 7101bd3f     	cmp	w9, #0x6f
40003f04: 54fffa6c     	b.gt	0x40003e50 <uart_printf+0xf4>
40003f08: 7100953f     	cmp	w9, #0x25
40003f0c: 54000440     	b.eq	0x40003f94 <uart_printf+0x238>
40003f10: 71018d3f     	cmp	w9, #0x63
40003f14: 54000c00     	b.eq	0x40004094 <uart_printf+0x338>
40003f18: 7101913f     	cmp	w9, #0x64
40003f1c: 540005a1     	b.ne	0x40003fd0 <uart_printf+0x274>
40003f20: b98053e9     	ldrsw	x9, [sp, #0x50]
40003f24: 7101b11f     	cmp	w8, #0x6c
40003f28: 540017c1     	b.ne	0x40004220 <uart_printf+0x4c4>
40003f2c: 36f823c9     	tbz	w9, #0x1f, 0x400043a4 <uart_printf+0x648>
40003f30: 11002128     	add	w8, w9, #0x8
40003f34: 3100213f     	cmn	w9, #0x8
40003f38: b90053e8     	str	w8, [sp, #0x50]
40003f3c: 54002348     	b.hi	0x400043a4 <uart_printf+0x648>
40003f40: f94023e8     	ldr	x8, [sp, #0x40]
40003f44: 8b090108     	add	x8, x8, x9
40003f48: f9400108     	ldr	x8, [x8]
40003f4c: b6f829a8     	tbz	x8, #0x3f, 0x40004480 <uart_printf+0x724>
40003f50: 1400011a     	b	0x400043b8 <uart_printf+0x65c>
40003f54: 7101d53f     	cmp	w9, #0x75
40003f58: 54000840     	b.eq	0x40004060 <uart_printf+0x304>
40003f5c: 7101e13f     	cmp	w9, #0x78
40003f60: 54000381     	b.ne	0x40003fd0 <uart_printf+0x274>
40003f64: b98053e9     	ldrsw	x9, [sp, #0x50]
40003f68: 7101b11f     	cmp	w8, #0x6c
40003f6c: 540014a1     	b.ne	0x40004200 <uart_printf+0x4a4>
40003f70: 36f81d49     	tbz	w9, #0x1f, 0x40004318 <uart_printf+0x5bc>
40003f74: 11002128     	add	w8, w9, #0x8
40003f78: 3100213f     	cmn	w9, #0x8
40003f7c: b90053e8     	str	w8, [sp, #0x50]
40003f80: 54001cc8     	b.hi	0x40004318 <uart_printf+0x5bc>
40003f84: f94023e8     	ldr	x8, [sp, #0x40]
40003f88: 8b090108     	add	x8, x8, x9
40003f8c: f9400108     	ldr	x8, [x8]
40003f90: 140000eb     	b	0x4000433c <uart_printf+0x5e0>
40003f94: b94b8ac8     	ldr	w8, [x22, #0xb88]
40003f98: 34000128     	cbz	w8, 0x40003fbc <uart_printf+0x260>
40003f9c: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40003fa0: 6b18011f     	cmp	w8, w24
40003fa4: 540000cc     	b.gt	0x40003fbc <uart_printf+0x260>
40003fa8: 93407d08     	sxtw	x8, w8
40003fac: 91000509     	add	x9, x8, #0x1
40003fb0: 38286b2e     	strb	w14, [x25, x8]
40003fb4: b90b8ee9     	str	w9, [x23, #0xb8c]
40003fb8: 38296b3f     	strb	wzr, [x25, x9]
40003fbc: b94002a8     	ldr	w8, [x21]
40003fc0: 372fffe8     	tbnz	w8, #0x5, 0x40003fbc <uart_printf+0x260>
40003fc4: b900036e     	str	w14, [x27]
40003fc8: 91000694     	add	x20, x20, #0x1
40003fcc: 17ffff8c     	b	0x40003dfc <uart_printf+0xa0>
40003fd0: b94b8ac8     	ldr	w8, [x22, #0xb88]
40003fd4: 34000128     	cbz	w8, 0x40003ff8 <uart_printf+0x29c>
40003fd8: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40003fdc: 6b18011f     	cmp	w8, w24
40003fe0: 540000cc     	b.gt	0x40003ff8 <uart_printf+0x29c>
40003fe4: 93407d08     	sxtw	x8, w8
40003fe8: 91000509     	add	x9, x8, #0x1
40003fec: 38286b2e     	strb	w14, [x25, x8]
40003ff0: b90b8ee9     	str	w9, [x23, #0xb8c]
40003ff4: 38296b3f     	strb	wzr, [x25, x9]
40003ff8: b94002a8     	ldr	w8, [x21]
40003ffc: 372fffe8     	tbnz	w8, #0x5, 0x40003ff8 <uart_printf+0x29c>
40004000: b900036e     	str	w14, [x27]
40004004: b94b8ac9     	ldr	w9, [x22, #0xb88]
40004008: 38746a68     	ldrb	w8, [x19, x20]
4000400c: 34000129     	cbz	w9, 0x40004030 <uart_printf+0x2d4>
40004010: b94b8ee9     	ldr	w9, [x23, #0xb8c]
40004014: 6b18013f     	cmp	w9, w24
40004018: 540000cc     	b.gt	0x40004030 <uart_printf+0x2d4>
4000401c: 93407d29     	sxtw	x9, w9
40004020: 9100052a     	add	x10, x9, #0x1
40004024: 38296b28     	strb	w8, [x25, x9]
40004028: b90b8eea     	str	w10, [x23, #0xb8c]
4000402c: 382a6b3f     	strb	wzr, [x25, x10]
40004030: b94002a9     	ldr	w9, [x21]
40004034: 372fffe9     	tbnz	w9, #0x5, 0x40004030 <uart_printf+0x2d4>
40004038: 17ffff6f     	b	0x40003df4 <uart_printf+0x98>
4000403c: b98053e8     	ldrsw	x8, [sp, #0x50]
40004040: 36f803c8     	tbz	w8, #0x1f, 0x400040b8 <uart_printf+0x35c>
40004044: 11002109     	add	w9, w8, #0x8
40004048: 3100211f     	cmn	w8, #0x8
4000404c: b90053e9     	str	w9, [sp, #0x50]
40004050: 54000348     	b.hi	0x400040b8 <uart_printf+0x35c>
40004054: f94023e9     	ldr	x9, [sp, #0x40]
40004058: 8b080128     	add	x8, x9, x8
4000405c: 1400001a     	b	0x400040c4 <uart_printf+0x368>
40004060: b98053e9     	ldrsw	x9, [sp, #0x50]
40004064: 7101b11f     	cmp	w8, #0x6c
40004068: 54000bc1     	b.ne	0x400041e0 <uart_printf+0x484>
4000406c: 36f80ea9     	tbz	w9, #0x1f, 0x40004240 <uart_printf+0x4e4>
40004070: 11002128     	add	w8, w9, #0x8
40004074: 3100213f     	cmn	w9, #0x8
40004078: b90053e8     	str	w8, [sp, #0x50]
4000407c: 54000e28     	b.hi	0x40004240 <uart_printf+0x4e4>
40004080: f94023e8     	ldr	x8, [sp, #0x40]
40004084: 8b090108     	add	x8, x8, x9
40004088: f9400109     	ldr	x9, [x8]
4000408c: b50010a9     	cbnz	x9, 0x400042a0 <uart_printf+0x544>
40004090: 14000071     	b	0x40004254 <uart_printf+0x4f8>
40004094: b98053e8     	ldrsw	x8, [sp, #0x50]
40004098: 36f80828     	tbz	w8, #0x1f, 0x4000419c <uart_printf+0x440>
4000409c: 11002109     	add	w9, w8, #0x8
400040a0: 3100211f     	cmn	w8, #0x8
400040a4: b90053e9     	str	w9, [sp, #0x50]
400040a8: 540007a8     	b.hi	0x4000419c <uart_printf+0x440>
400040ac: f94023e9     	ldr	x9, [sp, #0x40]
400040b0: 8b080128     	add	x8, x9, x8
400040b4: 1400003d     	b	0x400041a8 <uart_printf+0x44c>
400040b8: f9401fe8     	ldr	x8, [sp, #0x38]
400040bc: 91002109     	add	x9, x8, #0x8
400040c0: f9001fe9     	str	x9, [sp, #0x38]
400040c4: f9400100     	ldr	x0, [x8]
400040c8: 97fffe83     	bl	0x40003ad4 <uart_print_hex>
400040cc: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
400040d0: 528004ae     	mov	w14, #0x25              // =37
400040d4: 52800150     	mov	w16, #0xa               // =10
400040d8: f29999af     	movk	x15, #0xcccd
400040dc: d503201f     	nop
400040e0: 3001a0d1     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
400040e4: 91000694     	add	x20, x20, #0x1
400040e8: 17ffff45     	b	0x40003dfc <uart_printf+0xa0>
400040ec: f9401fe8     	ldr	x8, [sp, #0x38]
400040f0: 91002109     	add	x9, x8, #0x8
400040f4: f9001fe9     	str	x9, [sp, #0x38]
400040f8: f9400108     	ldr	x8, [x8]
400040fc: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40004100: 911bc929     	add	x9, x9, #0x6f2
40004104: f100011f     	cmp	x8, #0x0
40004108: 9a880128     	csel	x8, x9, x8, eq
4000410c: 39400109     	ldrb	w9, [x8]
40004110: 7100293f     	cmp	w9, #0xa
40004114: 540000a0     	b.eq	0x40004128 <uart_printf+0x3cc>
40004118: 34ffe709     	cbz	w9, 0x40003df8 <uart_printf+0x9c>
4000411c: b94b8aca     	ldr	w10, [x22, #0xb88]
40004120: 3500024a     	cbnz	w10, 0x40004168 <uart_printf+0x40c>
40004124: 14000019     	b	0x40004188 <uart_printf+0x42c>
40004128: b94b8ac9     	ldr	w9, [x22, #0xb88]
4000412c: 34000129     	cbz	w9, 0x40004150 <uart_printf+0x3f4>
40004130: b94b8ee9     	ldr	w9, [x23, #0xb8c]
40004134: 6b18013f     	cmp	w9, w24
40004138: 540000cc     	b.gt	0x40004150 <uart_printf+0x3f4>
4000413c: 93407d29     	sxtw	x9, w9
40004140: 9100052a     	add	x10, x9, #0x1
40004144: 38296b3a     	strb	w26, [x25, x9]
40004148: b90b8eea     	str	w10, [x23, #0xb8c]
4000414c: 382a6b3f     	strb	wzr, [x25, x10]
40004150: b94002a9     	ldr	w9, [x21]
40004154: 372fffe9     	tbnz	w9, #0x5, 0x40004150 <uart_printf+0x3f4>
40004158: b900037a     	str	w26, [x27]
4000415c: 39400109     	ldrb	w9, [x8]
40004160: b94b8aca     	ldr	w10, [x22, #0xb88]
40004164: 3400012a     	cbz	w10, 0x40004188 <uart_printf+0x42c>
40004168: b94b8eea     	ldr	w10, [x23, #0xb8c]
4000416c: 6b18015f     	cmp	w10, w24
40004170: 540000cc     	b.gt	0x40004188 <uart_printf+0x42c>
40004174: 93407d4a     	sxtw	x10, w10
40004178: 9100054b     	add	x11, x10, #0x1
4000417c: 382a6b29     	strb	w9, [x25, x10]
40004180: b90b8eeb     	str	w11, [x23, #0xb8c]
40004184: 382b6b3f     	strb	wzr, [x25, x11]
40004188: 91000508     	add	x8, x8, #0x1
4000418c: b94002aa     	ldr	w10, [x21]
40004190: 372fffea     	tbnz	w10, #0x5, 0x4000418c <uart_printf+0x430>
40004194: b9000369     	str	w9, [x27]
40004198: 17ffffdd     	b	0x4000410c <uart_printf+0x3b0>
4000419c: f9401fe8     	ldr	x8, [sp, #0x38]
400041a0: 91002109     	add	x9, x8, #0x8
400041a4: f9001fe9     	str	x9, [sp, #0x38]
400041a8: b94b8ac9     	ldr	w9, [x22, #0xb88]
400041ac: 39400108     	ldrb	w8, [x8]
400041b0: 34000129     	cbz	w9, 0x400041d4 <uart_printf+0x478>
400041b4: b94b8ee9     	ldr	w9, [x23, #0xb8c]
400041b8: 6b18013f     	cmp	w9, w24
400041bc: 540000cc     	b.gt	0x400041d4 <uart_printf+0x478>
400041c0: 93407d29     	sxtw	x9, w9
400041c4: 9100052a     	add	x10, x9, #0x1
400041c8: 38296b28     	strb	w8, [x25, x9]
400041cc: b90b8eea     	str	w10, [x23, #0xb8c]
400041d0: 382a6b3f     	strb	wzr, [x25, x10]
400041d4: b94002a9     	ldr	w9, [x21]
400041d8: 372fffe9     	tbnz	w9, #0x5, 0x400041d4 <uart_printf+0x478>
400041dc: 17ffff06     	b	0x40003df4 <uart_printf+0x98>
400041e0: 36f80569     	tbz	w9, #0x1f, 0x4000428c <uart_printf+0x530>
400041e4: 11002128     	add	w8, w9, #0x8
400041e8: 3100213f     	cmn	w9, #0x8
400041ec: b90053e8     	str	w8, [sp, #0x50]
400041f0: 540004e8     	b.hi	0x4000428c <uart_printf+0x530>
400041f4: f94023e8     	ldr	x8, [sp, #0x40]
400041f8: 8b090108     	add	x8, x8, x9
400041fc: 14000027     	b	0x40004298 <uart_printf+0x53c>
40004200: 36f80969     	tbz	w9, #0x1f, 0x4000432c <uart_printf+0x5d0>
40004204: 11002128     	add	w8, w9, #0x8
40004208: 3100213f     	cmn	w9, #0x8
4000420c: b90053e8     	str	w8, [sp, #0x50]
40004210: 540008e8     	b.hi	0x4000432c <uart_printf+0x5d0>
40004214: f94023e8     	ldr	x8, [sp, #0x40]
40004218: 8b090108     	add	x8, x8, x9
4000421c: 14000047     	b	0x40004338 <uart_printf+0x5dc>
40004220: 36f81269     	tbz	w9, #0x1f, 0x4000446c <uart_printf+0x710>
40004224: 11002128     	add	w8, w9, #0x8
40004228: 3100213f     	cmn	w9, #0x8
4000422c: b90053e8     	str	w8, [sp, #0x50]
40004230: 540011e8     	b.hi	0x4000446c <uart_printf+0x710>
40004234: f94023e8     	ldr	x8, [sp, #0x40]
40004238: 8b090108     	add	x8, x8, x9
4000423c: 1400008f     	b	0x40004478 <uart_printf+0x71c>
40004240: f9401fe8     	ldr	x8, [sp, #0x38]
40004244: 91002109     	add	x9, x8, #0x8
40004248: f9001fe9     	str	x9, [sp, #0x38]
4000424c: f9400109     	ldr	x9, [x8]
40004250: b5000289     	cbnz	x9, 0x400042a0 <uart_printf+0x544>
40004254: b94b8ac8     	ldr	w8, [x22, #0xb88]
40004258: 34000148     	cbz	w8, 0x40004280 <uart_printf+0x524>
4000425c: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40004260: 6b18011f     	cmp	w8, w24
40004264: 540000ec     	b.gt	0x40004280 <uart_printf+0x524>
40004268: 93407d08     	sxtw	x8, w8
4000426c: 5280060a     	mov	w10, #0x30              // =48
40004270: 91000509     	add	x9, x8, #0x1
40004274: 38286b2a     	strb	w10, [x25, x8]
40004278: b90b8ee9     	str	w9, [x23, #0xb8c]
4000427c: 38296b3f     	strb	wzr, [x25, x9]
40004280: b94002a8     	ldr	w8, [x21]
40004284: 372fffe8     	tbnz	w8, #0x5, 0x40004280 <uart_printf+0x524>
40004288: 17fffeda     	b	0x40003df0 <uart_printf+0x94>
4000428c: f9401fe8     	ldr	x8, [sp, #0x38]
40004290: 91002109     	add	x9, x8, #0x8
40004294: f9001fe9     	str	x9, [sp, #0x38]
40004298: b9400109     	ldr	w9, [x8]
4000429c: b4fffdc9     	cbz	x9, 0x40004254 <uart_printf+0x4f8>
400042a0: aa1f03ea     	mov	x10, xzr
400042a4: 9bcf7d28     	umulh	x8, x9, x15
400042a8: f100253f     	cmp	x9, #0x9
400042ac: d343fd0b     	lsr	x11, x8, #3
400042b0: 91000548     	add	x8, x10, #0x1
400042b4: 1b10a56c     	msub	w12, w11, w16, w9
400042b8: 321c0589     	orr	w9, w12, #0x30
400042bc: 382a6b89     	strb	w9, [x28, x10]
400042c0: aa0803ea     	mov	x10, x8
400042c4: aa0b03e9     	mov	x9, x11
400042c8: 54fffee8     	b.hi	0x400042a4 <uart_printf+0x548>
400042cc: d1000509     	sub	x9, x8, #0x1
400042d0: b94b8acb     	ldr	w11, [x22, #0xb88]
400042d4: 38696b8a     	ldrb	w10, [x28, x9]
400042d8: 3400012b     	cbz	w11, 0x400042fc <uart_printf+0x5a0>
400042dc: b94b8eeb     	ldr	w11, [x23, #0xb8c]
400042e0: 6b18017f     	cmp	w11, w24
400042e4: 540000cc     	b.gt	0x400042fc <uart_printf+0x5a0>
400042e8: 93407d6b     	sxtw	x11, w11
400042ec: 9100056c     	add	x12, x11, #0x1
400042f0: 382b6b2a     	strb	w10, [x25, x11]
400042f4: b90b8eec     	str	w12, [x23, #0xb8c]
400042f8: 382c6b3f     	strb	wzr, [x25, x12]
400042fc: b94002ab     	ldr	w11, [x21]
40004300: 372fffeb     	tbnz	w11, #0x5, 0x400042fc <uart_printf+0x5a0>
40004304: 7100051f     	cmp	w8, #0x1
40004308: aa0903e8     	mov	x8, x9
4000430c: b900036a     	str	w10, [x27]
40004310: 54fffdec     	b.gt	0x400042cc <uart_printf+0x570>
40004314: 17fffeb9     	b	0x40003df8 <uart_printf+0x9c>
40004318: f9401fe8     	ldr	x8, [sp, #0x38]
4000431c: 91002109     	add	x9, x8, #0x8
40004320: f9001fe9     	str	x9, [sp, #0x38]
40004324: f9400108     	ldr	x8, [x8]
40004328: 14000005     	b	0x4000433c <uart_printf+0x5e0>
4000432c: f9401fe8     	ldr	x8, [sp, #0x38]
40004330: 91002109     	add	x9, x8, #0x8
40004334: f9001fe9     	str	x9, [sp, #0x38]
40004338: b9400108     	ldr	w8, [x8]
4000433c: 2a1f03e9     	mov	w9, wzr
40004340: 5280078a     	mov	w10, #0x3c              // =60
40004344: 14000003     	b	0x40004350 <uart_printf+0x5f4>
40004348: b4000daa     	cbz	x10, 0x400044fc <uart_printf+0x7a0>
4000434c: d100114a     	sub	x10, x10, #0x4
40004350: 9aca250b     	lsr	x11, x8, x10
40004354: f2400d6b     	ands	x11, x11, #0xf
40004358: fa400944     	ccmp	x10, #0x0, #0x4, eq
4000435c: 1a9f1529     	csinc	w9, w9, wzr, ne
40004360: 34ffff49     	cbz	w9, 0x40004348 <uart_printf+0x5ec>
40004364: b94b8acc     	ldr	w12, [x22, #0xb88]
40004368: 386b6a2b     	ldrb	w11, [x17, x11]
4000436c: 3400012c     	cbz	w12, 0x40004390 <uart_printf+0x634>
40004370: b94b8eec     	ldr	w12, [x23, #0xb8c]
40004374: 6b18019f     	cmp	w12, w24
40004378: 540000cc     	b.gt	0x40004390 <uart_printf+0x634>
4000437c: 93407d8c     	sxtw	x12, w12
40004380: 9100058d     	add	x13, x12, #0x1
40004384: 382c6b2b     	strb	w11, [x25, x12]
40004388: b90b8eed     	str	w13, [x23, #0xb8c]
4000438c: 382d6b3f     	strb	wzr, [x25, x13]
40004390: b94002ac     	ldr	w12, [x21]
40004394: 372fffec     	tbnz	w12, #0x5, 0x40004390 <uart_printf+0x634>
40004398: b900036b     	str	w11, [x27]
4000439c: b5fffd8a     	cbnz	x10, 0x4000434c <uart_printf+0x5f0>
400043a0: 17fffe96     	b	0x40003df8 <uart_printf+0x9c>
400043a4: f9401fe8     	ldr	x8, [sp, #0x38]
400043a8: 91002109     	add	x9, x8, #0x8
400043ac: f9001fe9     	str	x9, [sp, #0x38]
400043b0: f9400108     	ldr	x8, [x8]
400043b4: b6f80668     	tbz	x8, #0x3f, 0x40004480 <uart_printf+0x724>
400043b8: b94b8ac9     	ldr	w9, [x22, #0xb88]
400043bc: 34000149     	cbz	w9, 0x400043e4 <uart_printf+0x688>
400043c0: b94b8ee9     	ldr	w9, [x23, #0xb8c]
400043c4: 6b18013f     	cmp	w9, w24
400043c8: 540000ec     	b.gt	0x400043e4 <uart_printf+0x688>
400043cc: 93407d29     	sxtw	x9, w9
400043d0: 528005ab     	mov	w11, #0x2d              // =45
400043d4: 9100052a     	add	x10, x9, #0x1
400043d8: 38296b2b     	strb	w11, [x25, x9]
400043dc: b90b8eea     	str	w10, [x23, #0xb8c]
400043e0: 382a6b3f     	strb	wzr, [x25, x10]
400043e4: b94002a9     	ldr	w9, [x21]
400043e8: 372fffe9     	tbnz	w9, #0x5, 0x400043e4 <uart_printf+0x688>
400043ec: aa1f03e9     	mov	x9, xzr
400043f0: 528005aa     	mov	w10, #0x2d              // =45
400043f4: cb0803e8     	neg	x8, x8
400043f8: b900036a     	str	w10, [x27]
400043fc: 9bcf7d0a     	umulh	x10, x8, x15
40004400: f100251f     	cmp	x8, #0x9
40004404: d343fd4a     	lsr	x10, x10, #3
40004408: 1b10a14b     	msub	w11, w10, w16, w8
4000440c: 321c0568     	orr	w8, w11, #0x30
40004410: 38296b88     	strb	w8, [x28, x9]
40004414: 91000529     	add	x9, x9, #0x1
40004418: aa0a03e8     	mov	x8, x10
4000441c: 54ffff08     	b.hi	0x400043fc <uart_printf+0x6a0>
40004420: d1000528     	sub	x8, x9, #0x1
40004424: b94b8acb     	ldr	w11, [x22, #0xb88]
40004428: 38686b8a     	ldrb	w10, [x28, x8]
4000442c: 3400012b     	cbz	w11, 0x40004450 <uart_printf+0x6f4>
40004430: b94b8eeb     	ldr	w11, [x23, #0xb8c]
40004434: 6b18017f     	cmp	w11, w24
40004438: 540000cc     	b.gt	0x40004450 <uart_printf+0x6f4>
4000443c: 93407d6b     	sxtw	x11, w11
40004440: 9100056c     	add	x12, x11, #0x1
40004444: 382b6b2a     	strb	w10, [x25, x11]
40004448: b90b8eec     	str	w12, [x23, #0xb8c]
4000444c: 382c6b3f     	strb	wzr, [x25, x12]
40004450: b94002ab     	ldr	w11, [x21]
40004454: 372fffeb     	tbnz	w11, #0x5, 0x40004450 <uart_printf+0x6f4>
40004458: 7100053f     	cmp	w9, #0x1
4000445c: aa0803e9     	mov	x9, x8
40004460: b900036a     	str	w10, [x27]
40004464: 54fffdec     	b.gt	0x40004420 <uart_printf+0x6c4>
40004468: 17fffe64     	b	0x40003df8 <uart_printf+0x9c>
4000446c: f9401fe8     	ldr	x8, [sp, #0x38]
40004470: 91002109     	add	x9, x8, #0x8
40004474: f9001fe9     	str	x9, [sp, #0x38]
40004478: b9800108     	ldrsw	x8, [x8]
4000447c: b7fff9e8     	tbnz	x8, #0x3f, 0x400043b8 <uart_printf+0x65c>
40004480: b40005a8     	cbz	x8, 0x40004534 <uart_printf+0x7d8>
40004484: aa1f03ea     	mov	x10, xzr
40004488: 9bcf7d09     	umulh	x9, x8, x15
4000448c: f100251f     	cmp	x8, #0x9
40004490: d343fd2b     	lsr	x11, x9, #3
40004494: 91000549     	add	x9, x10, #0x1
40004498: 1b10a16c     	msub	w12, w11, w16, w8
4000449c: 321c0588     	orr	w8, w12, #0x30
400044a0: 382a6b88     	strb	w8, [x28, x10]
400044a4: aa0903ea     	mov	x10, x9
400044a8: aa0b03e8     	mov	x8, x11
400044ac: 54fffee8     	b.hi	0x40004488 <uart_printf+0x72c>
400044b0: d1000528     	sub	x8, x9, #0x1
400044b4: b94b8acb     	ldr	w11, [x22, #0xb88]
400044b8: 38686b8a     	ldrb	w10, [x28, x8]
400044bc: 3400012b     	cbz	w11, 0x400044e0 <uart_printf+0x784>
400044c0: b94b8eeb     	ldr	w11, [x23, #0xb8c]
400044c4: 6b18017f     	cmp	w11, w24
400044c8: 540000cc     	b.gt	0x400044e0 <uart_printf+0x784>
400044cc: 93407d6b     	sxtw	x11, w11
400044d0: 9100056c     	add	x12, x11, #0x1
400044d4: 382b6b2a     	strb	w10, [x25, x11]
400044d8: b90b8eec     	str	w12, [x23, #0xb8c]
400044dc: 382c6b3f     	strb	wzr, [x25, x12]
400044e0: b94002ab     	ldr	w11, [x21]
400044e4: 372fffeb     	tbnz	w11, #0x5, 0x400044e0 <uart_printf+0x784>
400044e8: 7100053f     	cmp	w9, #0x1
400044ec: aa0803e9     	mov	x9, x8
400044f0: b900036a     	str	w10, [x27]
400044f4: 54fffdec     	b.gt	0x400044b0 <uart_printf+0x754>
400044f8: 17fffe40     	b	0x40003df8 <uart_printf+0x9c>
400044fc: b94b8ac8     	ldr	w8, [x22, #0xb88]
40004500: 34000148     	cbz	w8, 0x40004528 <uart_printf+0x7cc>
40004504: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40004508: 6b18011f     	cmp	w8, w24
4000450c: 540000ec     	b.gt	0x40004528 <uart_printf+0x7cc>
40004510: 93407d08     	sxtw	x8, w8
40004514: 5280060a     	mov	w10, #0x30              // =48
40004518: 91000509     	add	x9, x8, #0x1
4000451c: 38286b2a     	strb	w10, [x25, x8]
40004520: b90b8ee9     	str	w9, [x23, #0xb8c]
40004524: 38296b3f     	strb	wzr, [x25, x9]
40004528: b94002a8     	ldr	w8, [x21]
4000452c: 372fffe8     	tbnz	w8, #0x5, 0x40004528 <uart_printf+0x7cc>
40004530: 17fffe30     	b	0x40003df0 <uart_printf+0x94>
40004534: b94b8ac8     	ldr	w8, [x22, #0xb88]
40004538: 34000148     	cbz	w8, 0x40004560 <uart_printf+0x804>
4000453c: b94b8ee8     	ldr	w8, [x23, #0xb8c]
40004540: 6b18011f     	cmp	w8, w24
40004544: 540000ec     	b.gt	0x40004560 <uart_printf+0x804>
40004548: 93407d08     	sxtw	x8, w8
4000454c: 5280060a     	mov	w10, #0x30              // =48
40004550: 91000509     	add	x9, x8, #0x1
40004554: 38286b2a     	strb	w10, [x25, x8]
40004558: b90b8ee9     	str	w9, [x23, #0xb8c]
4000455c: 38296b3f     	strb	wzr, [x25, x9]
40004560: b94002a8     	ldr	w8, [x21]
40004564: 372fffe8     	tbnz	w8, #0x5, 0x40004560 <uart_printf+0x804>
40004568: 17fffe22     	b	0x40003df0 <uart_printf+0x94>
4000456c: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004570: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004574: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004578: a94967fa     	ldp	x26, x25, [sp, #0x90]
4000457c: a9486ffc     	ldp	x28, x27, [sp, #0x80]
40004580: a9477bfd     	ldp	x29, x30, [sp, #0x70]
40004584: 910343ff     	add	sp, sp, #0xd0
40004588: d65f03c0     	ret

000000004000458c <vfs_init>:
4000458c: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004590: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004594: 90000093     	adrp	x19, 0x40014000 <kernel_capture_buffer+0x3470>
40004598: 912ea273     	add	x19, x19, #0xba8
4000459c: f9000bf9     	str	x25, [sp, #0x10]
400045a0: 90000099     	adrp	x25, 0x40014000 <kernel_capture_buffer+0x3470>
400045a4: 52800034     	mov	w20, #0x1               // =1
400045a8: aa1303e0     	mov	x0, x19
400045ac: 2a1f03e1     	mov	w1, wzr
400045b0: 52809802     	mov	w2, #0x4c0              // =1216
400045b4: a9025ff8     	stp	x24, x23, [sp, #0x20]
400045b8: 910003fd     	mov	x29, sp
400045bc: a90357f6     	stp	x22, x21, [sp, #0x30]
400045c0: b90b9334     	str	w20, [x25, #0xb90]
400045c4: 97fff983     	bl	0x40002bd0 <memset>
400045c8: 528005e8     	mov	w8, #0x2f               // =47
400045cc: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
400045d0: b9002274     	str	w20, [x19, #0x20]
400045d4: 79000268     	strh	w8, [x19]
400045d8: b98b9328     	ldrsw	x8, [x25, #0xb90]
400045dc: f905cd33     	str	x19, [x9, #0xb98]
400045e0: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
400045e4: 7101fd1f     	cmp	w8, #0x7f
400045e8: f9021a7f     	str	xzr, [x19, #0x430]
400045ec: f900167f     	str	xzr, [x19, #0x28]
400045f0: b904ba7f     	str	wzr, [x19, #0x4b8]
400045f4: f905d133     	str	x19, [x9, #0xba0]
400045f8: 540028ac     	b.gt	0x40004b0c <vfs_init+0x580>
400045fc: 52809809     	mov	w9, #0x4c0              // =1216
40004600: 2a1f03e1     	mov	w1, wzr
40004604: 52809802     	mov	w2, #0x4c0              // =1216
40004608: 9b294d17     	smaddl	x23, w8, w9, x19
4000460c: 11000508     	add	w8, w8, #0x1
40004610: b90b9328     	str	w8, [x25, #0xb90]
40004614: aa1703e0     	mov	x0, x23
40004618: 97fff96e     	bl	0x40002bd0 <memset>
4000461c: 528d2c48     	mov	w8, #0x6962             // =26978
40004620: b904baff     	str	wzr, [x23, #0x4b8]
40004624: 72a00dc8     	movk	w8, #0x6e, lsl #16
40004628: b90022f4     	str	w20, [x23, #0x20]
4000462c: b90002e8     	str	w8, [x23]
40004630: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004634: f9021af3     	str	x19, [x23, #0x430]
40004638: 71003d1f     	cmp	w8, #0xf
4000463c: f90016ff     	str	xzr, [x23, #0x28]
40004640: 540000ac     	b.gt	0x40004654 <vfs_init+0xc8>
40004644: 11000509     	add	w9, w8, #0x1
40004648: 8b080e68     	add	x8, x19, x8, lsl #3
4000464c: b904ba69     	str	w9, [x19, #0x4b8]
40004650: f9021d17     	str	x23, [x8, #0x438]
40004654: b98b9328     	ldrsw	x8, [x25, #0xb90]
40004658: 7101fd1f     	cmp	w8, #0x7f
4000465c: 5400258c     	b.gt	0x40004b0c <vfs_init+0x580>
40004660: 52809809     	mov	w9, #0x4c0              // =1216
40004664: 2a1f03e1     	mov	w1, wzr
40004668: 52809802     	mov	w2, #0x4c0              // =1216
4000466c: 9b294d16     	smaddl	x22, w8, w9, x19
40004670: 11000508     	add	w8, w8, #0x1
40004674: b90b9328     	str	w8, [x25, #0xb90]
40004678: aa1603e0     	mov	x0, x22
4000467c: 97fff955     	bl	0x40002bd0 <memset>
40004680: 528e8ca8     	mov	w8, #0x7465             // =29797
40004684: b904badf     	str	wzr, [x22, #0x4b8]
40004688: 52800029     	mov	w9, #0x1                // =1
4000468c: 72a00c68     	movk	w8, #0x63, lsl #16
40004690: b90022c9     	str	w9, [x22, #0x20]
40004694: b90002c8     	str	w8, [x22]
40004698: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000469c: f9021ad3     	str	x19, [x22, #0x430]
400046a0: 71003d1f     	cmp	w8, #0xf
400046a4: f90016df     	str	xzr, [x22, #0x28]
400046a8: 540000ac     	b.gt	0x400046bc <vfs_init+0x130>
400046ac: 11000509     	add	w9, w8, #0x1
400046b0: 8b080e68     	add	x8, x19, x8, lsl #3
400046b4: b904ba69     	str	w9, [x19, #0x4b8]
400046b8: f9021d16     	str	x22, [x8, #0x438]
400046bc: b98b9328     	ldrsw	x8, [x25, #0xb90]
400046c0: 7101fd1f     	cmp	w8, #0x7f
400046c4: 5400224c     	b.gt	0x40004b0c <vfs_init+0x580>
400046c8: 52809809     	mov	w9, #0x4c0              // =1216
400046cc: 2a1f03e1     	mov	w1, wzr
400046d0: 52809802     	mov	w2, #0x4c0              // =1216
400046d4: 9b294d14     	smaddl	x20, w8, w9, x19
400046d8: 11000508     	add	w8, w8, #0x1
400046dc: b90b9328     	str	w8, [x25, #0xb90]
400046e0: aa1403e0     	mov	x0, x20
400046e4: 97fff93b     	bl	0x40002bd0 <memset>
400046e8: 528ded08     	mov	w8, #0x6f68             // =28520
400046ec: b904ba9f     	str	wzr, [x20, #0x4b8]
400046f0: 52800029     	mov	w9, #0x1                // =1
400046f4: 72acada8     	movk	w8, #0x656d, lsl #16
400046f8: 3900129f     	strb	wzr, [x20, #0x4]
400046fc: b9000288     	str	w8, [x20]
40004700: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004704: b9002289     	str	w9, [x20, #0x20]
40004708: 71003d1f     	cmp	w8, #0xf
4000470c: f9021a93     	str	x19, [x20, #0x430]
40004710: f900169f     	str	xzr, [x20, #0x28]
40004714: 540000ac     	b.gt	0x40004728 <vfs_init+0x19c>
40004718: 11000509     	add	w9, w8, #0x1
4000471c: 8b080e68     	add	x8, x19, x8, lsl #3
40004720: b904ba69     	str	w9, [x19, #0x4b8]
40004724: f9021d14     	str	x20, [x8, #0x438]
40004728: b98b9328     	ldrsw	x8, [x25, #0xb90]
4000472c: 7101fd1f     	cmp	w8, #0x7f
40004730: 54001eec     	b.gt	0x40004b0c <vfs_init+0x580>
40004734: 52809809     	mov	w9, #0x4c0              // =1216
40004738: 2a1f03e1     	mov	w1, wzr
4000473c: 52809802     	mov	w2, #0x4c0              // =1216
40004740: 9b294d15     	smaddl	x21, w8, w9, x19
40004744: 11000508     	add	w8, w8, #0x1
40004748: b90b9328     	str	w8, [x25, #0xb90]
4000474c: aa1503e0     	mov	x0, x21
40004750: 97fff920     	bl	0x40002bd0 <memset>
40004754: 528dec88     	mov	w8, #0x6f64             // =28516
40004758: b904babf     	str	wzr, [x21, #0x4b8]
4000475c: 52800029     	mov	w9, #0x1                // =1
40004760: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004764: 390012bf     	strb	wzr, [x21, #0x4]
40004768: b90002a8     	str	w8, [x21]
4000476c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004770: b90022a9     	str	w9, [x21, #0x20]
40004774: 71003d1f     	cmp	w8, #0xf
40004778: f9021ab3     	str	x19, [x21, #0x430]
4000477c: f90016bf     	str	xzr, [x21, #0x28]
40004780: 540000ac     	b.gt	0x40004794 <vfs_init+0x208>
40004784: 11000509     	add	w9, w8, #0x1
40004788: 8b080e68     	add	x8, x19, x8, lsl #3
4000478c: b904ba69     	str	w9, [x19, #0x4b8]
40004790: f9021d15     	str	x21, [x8, #0x438]
40004794: b98b9328     	ldrsw	x8, [x25, #0xb90]
40004798: 7101fd1f     	cmp	w8, #0x7f
4000479c: 54001b8c     	b.gt	0x40004b0c <vfs_init+0x580>
400047a0: 52809809     	mov	w9, #0x4c0              // =1216
400047a4: 2a1f03e1     	mov	w1, wzr
400047a8: 52809802     	mov	w2, #0x4c0              // =1216
400047ac: 9b294d18     	smaddl	x24, w8, w9, x19
400047b0: 11000508     	add	w8, w8, #0x1
400047b4: b90b9328     	str	w8, [x25, #0xb90]
400047b8: aa1803e0     	mov	x0, x24
400047bc: 97fff905     	bl	0x40002bd0 <memset>
400047c0: 528d2c28     	mov	w8, #0x6961             // =26977
400047c4: b904bb1f     	str	wzr, [x24, #0x4b8]
400047c8: 79000308     	strh	w8, [x24]
400047cc: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400047d0: 39000b1f     	strb	wzr, [x24, #0x2]
400047d4: 71003d1f     	cmp	w8, #0xf
400047d8: b900231f     	str	wzr, [x24, #0x20]
400047dc: f9021b17     	str	x23, [x24, #0x430]
400047e0: f900171f     	str	xzr, [x24, #0x28]
400047e4: 540000ac     	b.gt	0x400047f8 <vfs_init+0x26c>
400047e8: 8b080ee9     	add	x9, x23, x8, lsl #3
400047ec: 11000508     	add	w8, w8, #0x1
400047f0: b904bae8     	str	w8, [x23, #0x4b8]
400047f4: f9021d38     	str	x24, [x9, #0x438]
400047f8: d503201f     	nop
400047fc: 70026dd7     	adr	x23, 0x400095b7 <__rodata_start+0x25b7>
40004800: 9100c300     	add	x0, x24, #0x30
40004804: aa1703e1     	mov	x1, x23
40004808: 97fff8c6     	bl	0x40002b20 <kstrcpy>
4000480c: aa1703e0     	mov	x0, x23
40004810: 97fff895     	bl	0x40002a64 <kstrlen>
40004814: b98b9328     	ldrsw	x8, [x25, #0xb90]
40004818: f9001700     	str	x0, [x24, #0x28]
4000481c: 7101fd1f     	cmp	w8, #0x7f
40004820: 5400176c     	b.gt	0x40004b0c <vfs_init+0x580>
40004824: 52809809     	mov	w9, #0x4c0              // =1216
40004828: 2a1f03e1     	mov	w1, wzr
4000482c: 52809802     	mov	w2, #0x4c0              // =1216
40004830: 9b294d17     	smaddl	x23, w8, w9, x19
40004834: 11000508     	add	w8, w8, #0x1
40004838: b90b9328     	str	w8, [x25, #0xb90]
4000483c: aa1703e0     	mov	x0, x23
40004840: 97fff8e4     	bl	0x40002bd0 <memset>
40004844: d28e6de8     	mov	x8, #0x736f             // =29551
40004848: b904baff     	str	wzr, [x23, #0x4b8]
4000484c: 528cae69     	mov	w9, #0x6573             // =25971
40004850: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004854: 790012e9     	strh	w9, [x23, #0x8]
40004858: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
4000485c: 39002aff     	strb	wzr, [x23, #0xa]
40004860: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004864: b90022ff     	str	wzr, [x23, #0x20]
40004868: f90002e8     	str	x8, [x23]
4000486c: b984bac8     	ldrsw	x8, [x22, #0x4b8]
40004870: f9021af6     	str	x22, [x23, #0x430]
40004874: 71003d1f     	cmp	w8, #0xf
40004878: f90016ff     	str	xzr, [x23, #0x28]
4000487c: 540000ac     	b.gt	0x40004890 <vfs_init+0x304>
40004880: 8b080ec9     	add	x9, x22, x8, lsl #3
40004884: 11000508     	add	w8, w8, #0x1
40004888: b904bac8     	str	w8, [x22, #0x4b8]
4000488c: f9021d37     	str	x23, [x9, #0x438]
40004890: f0000016     	adrp	x22, 0x40007000 <__rodata_start>
40004894: 91377ad6     	add	x22, x22, #0xdde
40004898: 9100c2e0     	add	x0, x23, #0x30
4000489c: aa1603e1     	mov	x1, x22
400048a0: 97fff8a0     	bl	0x40002b20 <kstrcpy>
400048a4: aa1603e0     	mov	x0, x22
400048a8: 97fff86f     	bl	0x40002a64 <kstrlen>
400048ac: b98b9328     	ldrsw	x8, [x25, #0xb90]
400048b0: f90016e0     	str	x0, [x23, #0x28]
400048b4: 7101fd1f     	cmp	w8, #0x7f
400048b8: 540012ac     	b.gt	0x40004b0c <vfs_init+0x580>
400048bc: 52809809     	mov	w9, #0x4c0              // =1216
400048c0: 2a1f03e1     	mov	w1, wzr
400048c4: 52809802     	mov	w2, #0x4c0              // =1216
400048c8: 9b294d16     	smaddl	x22, w8, w9, x19
400048cc: 11000508     	add	w8, w8, #0x1
400048d0: b90b9328     	str	w8, [x25, #0xb90]
400048d4: aa1603e0     	mov	x0, x22
400048d8: 97fff8be     	bl	0x40002bd0 <memset>
400048dc: d28caee8     	mov	x8, #0x6577             // =25975
400048e0: b904badf     	str	wzr, [x22, #0x4b8]
400048e4: 528f0e89     	mov	w9, #0x7874             // =30836
400048e8: f2ac6d88     	movk	x8, #0x636c, lsl #16
400048ec: 72a00e89     	movk	w9, #0x74, lsl #16
400048f0: b90022df     	str	wzr, [x22, #0x20]
400048f4: f2cdade8     	movk	x8, #0x6d6f, lsl #32
400048f8: b9000ac9     	str	w9, [x22, #0x8]
400048fc: f2e5cca8     	movk	x8, #0x2e65, lsl #48
40004900: f9021ad5     	str	x21, [x22, #0x430]
40004904: f90002c8     	str	x8, [x22]
40004908: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000490c: f90016df     	str	xzr, [x22, #0x28]
40004910: 71003d1f     	cmp	w8, #0xf
40004914: 540000ac     	b.gt	0x40004928 <vfs_init+0x39c>
40004918: 8b080ea9     	add	x9, x21, x8, lsl #3
4000491c: 11000508     	add	w8, w8, #0x1
40004920: b904baa8     	str	w8, [x21, #0x4b8]
40004924: f9021d36     	str	x22, [x9, #0x438]
40004928: f0000017     	adrp	x23, 0x40007000 <__rodata_start>
4000492c: 913d1af7     	add	x23, x23, #0xf46
40004930: 9100c2c0     	add	x0, x22, #0x30
40004934: aa1703e1     	mov	x1, x23
40004938: 97fff87a     	bl	0x40002b20 <kstrcpy>
4000493c: aa1703e0     	mov	x0, x23
40004940: 97fff849     	bl	0x40002a64 <kstrlen>
40004944: b98b9328     	ldrsw	x8, [x25, #0xb90]
40004948: f90016c0     	str	x0, [x22, #0x28]
4000494c: 7101fd1f     	cmp	w8, #0x7f
40004950: 54000dec     	b.gt	0x40004b0c <vfs_init+0x580>
40004954: 52809809     	mov	w9, #0x4c0              // =1216
40004958: 2a1f03e1     	mov	w1, wzr
4000495c: 52809802     	mov	w2, #0x4c0              // =1216
40004960: 9b294d16     	smaddl	x22, w8, w9, x19
40004964: 11000508     	add	w8, w8, #0x1
40004968: b90b9328     	str	w8, [x25, #0xb90]
4000496c: aa1603e0     	mov	x0, x22
40004970: 97fff898     	bl	0x40002bd0 <memset>
40004974: d28c2d08     	mov	x8, #0x6168             // =24936
40004978: b904badf     	str	wzr, [x22, #0x4b8]
4000497c: 528e85c9     	mov	w9, #0x742e             // =29742
40004980: f2ac8e48     	movk	x8, #0x6472, lsl #16
40004984: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004988: 390032df     	strb	wzr, [x22, #0xc]
4000498c: f2cc2ee8     	movk	x8, #0x6177, lsl #32
40004990: b9000ac9     	str	w9, [x22, #0x8]
40004994: f2ecae48     	movk	x8, #0x6572, lsl #48
40004998: b90022df     	str	wzr, [x22, #0x20]
4000499c: f90002c8     	str	x8, [x22]
400049a0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400049a4: f9021ad5     	str	x21, [x22, #0x430]
400049a8: 71003d1f     	cmp	w8, #0xf
400049ac: f90016df     	str	xzr, [x22, #0x28]
400049b0: 540000ac     	b.gt	0x400049c4 <vfs_init+0x438>
400049b4: 8b080ea9     	add	x9, x21, x8, lsl #3
400049b8: 11000508     	add	w8, w8, #0x1
400049bc: b904baa8     	str	w8, [x21, #0x4b8]
400049c0: f9021d36     	str	x22, [x9, #0x438]
400049c4: 90000037     	adrp	x23, 0x40008000 <__rodata_start+0x1000>
400049c8: 910bcef7     	add	x23, x23, #0x2f3
400049cc: 9100c2c0     	add	x0, x22, #0x30
400049d0: aa1703e1     	mov	x1, x23
400049d4: 97fff853     	bl	0x40002b20 <kstrcpy>
400049d8: aa1703e0     	mov	x0, x23
400049dc: 97fff822     	bl	0x40002a64 <kstrlen>
400049e0: b98b9328     	ldrsw	x8, [x25, #0xb90]
400049e4: f90016c0     	str	x0, [x22, #0x28]
400049e8: 7101fd1f     	cmp	w8, #0x7f
400049ec: 5400090c     	b.gt	0x40004b0c <vfs_init+0x580>
400049f0: 52809809     	mov	w9, #0x4c0              // =1216
400049f4: 2a1f03e1     	mov	w1, wzr
400049f8: 52809802     	mov	w2, #0x4c0              // =1216
400049fc: 9b294d16     	smaddl	x22, w8, w9, x19
40004a00: 11000508     	add	w8, w8, #0x1
40004a04: b90b9328     	str	w8, [x25, #0xb90]
40004a08: aa1603e0     	mov	x0, x22
40004a0c: 97fff871     	bl	0x40002bd0 <memset>
40004a10: 528d2c28     	mov	w8, #0x6961             // =26977
40004a14: b904badf     	str	wzr, [x22, #0x4b8]
40004a18: 528e8f09     	mov	w9, #0x7478             // =29816
40004a1c: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004a20: 79000ac9     	strh	w9, [x22, #0x4]
40004a24: b90002c8     	str	w8, [x22]
40004a28: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004a2c: 39001adf     	strb	wzr, [x22, #0x6]
40004a30: 71003d1f     	cmp	w8, #0xf
40004a34: b90022df     	str	wzr, [x22, #0x20]
40004a38: f9021ad5     	str	x21, [x22, #0x430]
40004a3c: f90016df     	str	xzr, [x22, #0x28]
40004a40: 540000ac     	b.gt	0x40004a54 <vfs_init+0x4c8>
40004a44: 8b080ea9     	add	x9, x21, x8, lsl #3
40004a48: 11000508     	add	w8, w8, #0x1
40004a4c: b904baa8     	str	w8, [x21, #0x4b8]
40004a50: f9021d36     	str	x22, [x9, #0x438]
40004a54: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
40004a58: 910bb6b5     	add	x21, x21, #0x2ed
40004a5c: 9100c2c0     	add	x0, x22, #0x30
40004a60: aa1503e1     	mov	x1, x21
40004a64: 97fff82f     	bl	0x40002b20 <kstrcpy>
40004a68: aa1503e0     	mov	x0, x21
40004a6c: 97fff7fe     	bl	0x40002a64 <kstrlen>
40004a70: b98b9328     	ldrsw	x8, [x25, #0xb90]
40004a74: f90016c0     	str	x0, [x22, #0x28]
40004a78: 7101fd1f     	cmp	w8, #0x7f
40004a7c: 5400048c     	b.gt	0x40004b0c <vfs_init+0x580>
40004a80: 52809809     	mov	w9, #0x4c0              // =1216
40004a84: 2a1f03e1     	mov	w1, wzr
40004a88: 52809802     	mov	w2, #0x4c0              // =1216
40004a8c: 9b294d13     	smaddl	x19, w8, w9, x19
40004a90: 11000508     	add	w8, w8, #0x1
40004a94: b90b9328     	str	w8, [x25, #0xb90]
40004a98: aa1303e0     	mov	x0, x19
40004a9c: 97fff84d     	bl	0x40002bd0 <memset>
40004aa0: d28cae48     	mov	x8, #0x6572             // =25970
40004aa4: b904ba7f     	str	wzr, [x19, #0x4b8]
40004aa8: 528e8f09     	mov	w9, #0x7478             // =29816
40004aac: f2ac8c28     	movk	x8, #0x6461, lsl #16
40004ab0: 79001269     	strh	w9, [x19, #0x8]
40004ab4: f2ccada8     	movk	x8, #0x656d, lsl #32
40004ab8: 39002a7f     	strb	wzr, [x19, #0xa]
40004abc: f2ee85c8     	movk	x8, #0x742e, lsl #48
40004ac0: b900227f     	str	wzr, [x19, #0x20]
40004ac4: f9000268     	str	x8, [x19]
40004ac8: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004acc: f9021a74     	str	x20, [x19, #0x430]
40004ad0: 71003d1f     	cmp	w8, #0xf
40004ad4: f900167f     	str	xzr, [x19, #0x28]
40004ad8: 540000ac     	b.gt	0x40004aec <vfs_init+0x560>
40004adc: 8b080e89     	add	x9, x20, x8, lsl #3
40004ae0: 11000508     	add	w8, w8, #0x1
40004ae4: b904ba88     	str	w8, [x20, #0x4b8]
40004ae8: f9021d33     	str	x19, [x9, #0x438]
40004aec: f0000014     	adrp	x20, 0x40007000 <__rodata_start>
40004af0: 910efa94     	add	x20, x20, #0x3be
40004af4: 9100c260     	add	x0, x19, #0x30
40004af8: aa1403e1     	mov	x1, x20
40004afc: 97fff809     	bl	0x40002b20 <kstrcpy>
40004b00: aa1403e0     	mov	x0, x20
40004b04: 97fff7d8     	bl	0x40002a64 <kstrlen>
40004b08: f9001660     	str	x0, [x19, #0x28]
40004b0c: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004b10: f9400bf9     	ldr	x25, [sp, #0x10]
40004b14: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004b18: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004b1c: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004b20: d65f03c0     	ret

0000000040004b24 <vfs_load_internal>:
40004b24: 2a1f03e0     	mov	w0, wzr
40004b28: d65f03c0     	ret

0000000040004b2c <vfs_get_root>:
40004b2c: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004b30: f945cd00     	ldr	x0, [x8, #0xb98]
40004b34: d65f03c0     	ret

0000000040004b38 <vfs_get_cwd>:
40004b38: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004b3c: f945d100     	ldr	x0, [x8, #0xba0]
40004b40: d65f03c0     	ret

0000000040004b44 <vfs_getcwd>:
40004b44: d10343ff     	sub	sp, sp, #0xd0
40004b48: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004b4c: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004b50: aa0003f3     	mov	x19, x0
40004b54: f945d108     	ldr	x8, [x8, #0xba0]
40004b58: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004b5c: 910203fd     	add	x29, sp, #0x80
40004b60: a90967fa     	stp	x26, x25, [sp, #0x90]
40004b64: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40004b68: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004b6c: b4000228     	cbz	x8, 0x40004bb0 <vfs_getcwd+0x6c>
40004b70: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
40004b74: f945cd29     	ldr	x9, [x9, #0xb98]
40004b78: eb09011f     	cmp	x8, x9
40004b7c: 540001a0     	b.eq	0x40004bb0 <vfs_getcwd+0x6c>
40004b80: aa1f03ea     	mov	x10, xzr
40004b84: 910003eb     	mov	x11, sp
40004b88: eb09011f     	cmp	x8, x9
40004b8c: 540001e0     	b.eq	0x40004bc8 <vfs_getcwd+0x84>
40004b90: f1003d5f     	cmp	x10, #0xf
40004b94: 540001a8     	b.hi	0x40004bc8 <vfs_getcwd+0x84>
40004b98: f82a7968     	str	x8, [x11, x10, lsl #3]
40004b9c: f9421908     	ldr	x8, [x8, #0x430]
40004ba0: 9100054c     	add	x12, x10, #0x1
40004ba4: aa0c03ea     	mov	x10, x12
40004ba8: b5ffff08     	cbnz	x8, 0x40004b88 <vfs_getcwd+0x44>
40004bac: 14000008     	b	0x40004bcc <vfs_getcwd+0x88>
40004bb0: f100083f     	cmp	x1, #0x2
40004bb4: 54000583     	b.lo	0x40004c64 <vfs_getcwd+0x120>
40004bb8: 528005e8     	mov	w8, #0x2f               // =47
40004bbc: 3900067f     	strb	wzr, [x19, #0x1]
40004bc0: 39000268     	strb	w8, [x19]
40004bc4: 14000028     	b	0x40004c64 <vfs_getcwd+0x120>
40004bc8: aa0a03ec     	mov	x12, x10
40004bcc: 7100059f     	cmp	w12, #0x1
40004bd0: 3900027f     	strb	wzr, [x19]
40004bd4: 5400048b     	b.lt	0x40004c64 <vfs_getcwd+0x120>
40004bd8: aa1f03f6     	mov	x22, xzr
40004bdc: d1000435     	sub	x21, x1, #0x1
40004be0: 92407999     	and	x25, x12, #0x7fffffff
40004be4: 528005f7     	mov	w23, #0x2f              // =47
40004be8: 910003f8     	mov	x24, sp
40004bec: 14000005     	b	0x40004c00 <vfs_getcwd+0xbc>
40004bf0: 8b0a02d6     	add	x22, x22, x10
40004bf4: f100075f     	cmp	x26, #0x1
40004bf8: 38366a7f     	strb	wzr, [x19, x22]
40004bfc: 54000349     	b.ls	0x40004c64 <vfs_getcwd+0x120>
40004c00: eb1502df     	cmp	x22, x21
40004c04: aa1903fa     	mov	x26, x25
40004c08: 54000082     	b.hs	0x40004c18 <vfs_getcwd+0xd4>
40004c0c: 38366a77     	strb	w23, [x19, x22]
40004c10: 910006d6     	add	x22, x22, #0x1
40004c14: 38366a7f     	strb	wzr, [x19, x22]
40004c18: d1000759     	sub	x25, x26, #0x1
40004c1c: f8797b14     	ldr	x20, [x24, x25, lsl #3]
40004c20: aa1403e0     	mov	x0, x20
40004c24: 97fff790     	bl	0x40002a64 <kstrlen>
40004c28: b4fffe60     	cbz	x0, 0x40004bf4 <vfs_getcwd+0xb0>
40004c2c: eb1502df     	cmp	x22, x21
40004c30: 54fffe22     	b.hs	0x40004bf4 <vfs_getcwd+0xb0>
40004c34: aa1f03e9     	mov	x9, xzr
40004c38: 8b160268     	add	x8, x19, x22
40004c3c: 9100052a     	add	x10, x9, #0x1
40004c40: 38696a8b     	ldrb	w11, [x20, x9]
40004c44: eb00015f     	cmp	x10, x0
40004c48: 3829690b     	strb	w11, [x8, x9]
40004c4c: 54fffd22     	b.hs	0x40004bf0 <vfs_getcwd+0xac>
40004c50: 8b160149     	add	x9, x10, x22
40004c54: eb15013f     	cmp	x9, x21
40004c58: aa0a03e9     	mov	x9, x10
40004c5c: 54ffff03     	b.lo	0x40004c3c <vfs_getcwd+0xf8>
40004c60: 17ffffe4     	b	0x40004bf0 <vfs_getcwd+0xac>
40004c64: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004c68: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004c6c: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004c70: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004c74: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004c78: 910343ff     	add	sp, sp, #0xd0
40004c7c: d65f03c0     	ret

0000000040004c80 <vfs_find>:
40004c80: d10203ff     	sub	sp, sp, #0x80
40004c84: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004c88: 910083fd     	add	x29, sp, #0x20
40004c8c: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004c90: a90467fa     	stp	x26, x25, [sp, #0x40]
40004c94: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004c98: a90657f6     	stp	x22, x21, [sp, #0x60]
40004c9c: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004ca0: b4000a60     	cbz	x0, 0x40004dec <vfs_find+0x16c>
40004ca4: 39400008     	ldrb	w8, [x0]
40004ca8: aa0003f4     	mov	x20, x0
40004cac: 34000a08     	cbz	w8, 0x40004dec <vfs_find+0x16c>
40004cb0: 7100bd1f     	cmp	w8, #0x2f
40004cb4: 54000121     	b.ne	0x40004cd8 <vfs_find+0x58>
40004cb8: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004cbc: 52800037     	mov	w23, #0x1               // =1
40004cc0: f945cd13     	ldr	x19, [x8, #0xb98]
40004cc4: 38776a88     	ldrb	w8, [x20, x23]
40004cc8: 7100bd1f     	cmp	w8, #0x2f
40004ccc: 540000e1     	b.ne	0x40004ce8 <vfs_find+0x68>
40004cd0: 910006f7     	add	x23, x23, #0x1
40004cd4: 17fffffc     	b	0x40004cc4 <vfs_find+0x44>
40004cd8: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
40004cdc: aa1f03f7     	mov	x23, xzr
40004ce0: f945d133     	ldr	x19, [x9, #0xba0]
40004ce4: 14000002     	b	0x40004cec <vfs_find+0x6c>
40004ce8: 34000848     	cbz	w8, 0x40004df0 <vfs_find+0x170>
40004cec: 91000698     	add	x24, x20, #0x1
40004cf0: f0000015     	adrp	x21, 0x40007000 <__rodata_start>
40004cf4: 912622b5     	add	x21, x21, #0x988
40004cf8: 910003f9     	mov	x25, sp
40004cfc: 90000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40004d00: 910386d6     	add	x22, x22, #0xe1
40004d04: 14000006     	b	0x40004d1c <vfs_find+0x9c>
40004d08: f9421a68     	ldr	x8, [x19, #0x430]
40004d0c: f100011f     	cmp	x8, #0x0
40004d10: 9a880273     	csel	x19, x19, x8, eq
40004d14: 385ff348     	ldurb	w8, [x26, #-0x1]
40004d18: 340006c8     	cbz	w8, 0x40004df0 <vfs_find+0x170>
40004d1c: 7100bd1f     	cmp	w8, #0x2f
40004d20: 54000061     	b.ne	0x40004d2c <vfs_find+0xac>
40004d24: aa1f03e9     	mov	x9, xzr
40004d28: 14000010     	b	0x40004d68 <vfs_find+0xe8>
40004d2c: aa1f03e9     	mov	x9, xzr
40004d30: 8b17030a     	add	x10, x24, x23
40004d34: 34000188     	cbz	w8, 0x40004d64 <vfs_find+0xe4>
40004d38: f100793f     	cmp	x9, #0x1e
40004d3c: 54000148     	b.hi	0x40004d64 <vfs_find+0xe4>
40004d40: 38296b28     	strb	w8, [x25, x9]
40004d44: 38696948     	ldrb	w8, [x10, x9]
40004d48: 9100052b     	add	x11, x9, #0x1
40004d4c: aa0b03e9     	mov	x9, x11
40004d50: 7100bd1f     	cmp	w8, #0x2f
40004d54: 54ffff01     	b.ne	0x40004d34 <vfs_find+0xb4>
40004d58: 8b0b02f7     	add	x23, x23, x11
40004d5c: aa0b03e9     	mov	x9, x11
40004d60: 14000002     	b	0x40004d68 <vfs_find+0xe8>
40004d64: 8b0902f7     	add	x23, x23, x9
40004d68: 8b17029a     	add	x26, x20, x23
40004d6c: d10006f7     	sub	x23, x23, #0x1
40004d70: 38296b3f     	strb	wzr, [x25, x9]
40004d74: 38401748     	ldrb	w8, [x26], #0x1
40004d78: 910006f7     	add	x23, x23, #0x1
40004d7c: 7100bd1f     	cmp	w8, #0x2f
40004d80: 54ffffa0     	b.eq	0x40004d74 <vfs_find+0xf4>
40004d84: 910003e0     	mov	x0, sp
40004d88: aa1503e1     	mov	x1, x21
40004d8c: 97fff746     	bl	0x40002aa4 <kstrcmp>
40004d90: 34fffc20     	cbz	w0, 0x40004d14 <vfs_find+0x94>
40004d94: 910003e0     	mov	x0, sp
40004d98: aa1603e1     	mov	x1, x22
40004d9c: 97fff742     	bl	0x40002aa4 <kstrcmp>
40004da0: 34fffb40     	cbz	w0, 0x40004d08 <vfs_find+0x88>
40004da4: b944ba68     	ldr	w8, [x19, #0x4b8]
40004da8: 7100051f     	cmp	w8, #0x1
40004dac: 5400020b     	b.lt	0x40004dec <vfs_find+0x16c>
40004db0: aa1f03fb     	mov	x27, xzr
40004db4: 9110e27c     	add	x28, x19, #0x438
40004db8: 14000005     	b	0x40004dcc <vfs_find+0x14c>
40004dbc: b944ba68     	ldr	w8, [x19, #0x4b8]
40004dc0: 9100077b     	add	x27, x27, #0x1
40004dc4: eb28c37f     	cmp	x27, w8, sxtw
40004dc8: 5400012a     	b.ge	0x40004dec <vfs_find+0x16c>
40004dcc: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004dd0: b4ffff80     	cbz	x0, 0x40004dc0 <vfs_find+0x140>
40004dd4: 910003e1     	mov	x1, sp
40004dd8: 97fff733     	bl	0x40002aa4 <kstrcmp>
40004ddc: 35ffff00     	cbnz	w0, 0x40004dbc <vfs_find+0x13c>
40004de0: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004de4: b5fff993     	cbnz	x19, 0x40004d14 <vfs_find+0x94>
40004de8: 14000002     	b	0x40004df0 <vfs_find+0x170>
40004dec: aa1f03f3     	mov	x19, xzr
40004df0: aa1303e0     	mov	x0, x19
40004df4: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004df8: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004dfc: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004e00: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004e04: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004e08: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004e0c: 910203ff     	add	sp, sp, #0x80
40004e10: d65f03c0     	ret

0000000040004e14 <vfs_chdir>:
40004e14: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004e18: f9000bf3     	str	x19, [sp, #0x10]
40004e1c: 910003fd     	mov	x29, sp
40004e20: b4000200     	cbz	x0, 0x40004e60 <vfs_chdir+0x4c>
40004e24: 39400008     	ldrb	w8, [x0]
40004e28: 340001c8     	cbz	w8, 0x40004e60 <vfs_chdir+0x4c>
40004e2c: b0000021     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40004e30: 91097021     	add	x1, x1, #0x25c
40004e34: aa0003f3     	mov	x19, x0
40004e38: 97fff71b     	bl	0x40002aa4 <kstrcmp>
40004e3c: 34000120     	cbz	w0, 0x40004e60 <vfs_chdir+0x4c>
40004e40: aa1303e0     	mov	x0, x19
40004e44: 97ffff8f     	bl	0x40004c80 <vfs_find>
40004e48: b40002c0     	cbz	x0, 0x40004ea0 <vfs_chdir+0x8c>
40004e4c: b9402008     	ldr	w8, [x0, #0x20]
40004e50: 7100051f     	cmp	w8, #0x1
40004e54: 54000180     	b.eq	0x40004e84 <vfs_chdir+0x70>
40004e58: 12800028     	mov	w8, #-0x2               // =-2
40004e5c: 1400000d     	b	0x40004e90 <vfs_chdir+0x7c>
40004e60: f0000000     	adrp	x0, 0x40007000 <__rodata_start>
40004e64: 913eec00     	add	x0, x0, #0xfbb
40004e68: 97ffff86     	bl	0x40004c80 <vfs_find>
40004e6c: b4000080     	cbz	x0, 0x40004e7c <vfs_chdir+0x68>
40004e70: b9402008     	ldr	w8, [x0, #0x20]
40004e74: 7100051f     	cmp	w8, #0x1
40004e78: 54000060     	b.eq	0x40004e84 <vfs_chdir+0x70>
40004e7c: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004e80: f945cd00     	ldr	x0, [x8, #0xb98]
40004e84: 90000089     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
40004e88: 2a1f03e8     	mov	w8, wzr
40004e8c: f905d120     	str	x0, [x9, #0xba0]
40004e90: f9400bf3     	ldr	x19, [sp, #0x10]
40004e94: 2a0803e0     	mov	w0, w8
40004e98: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004e9c: d65f03c0     	ret
40004ea0: 12800008     	mov	w8, #-0x1               // =-1
40004ea4: 17fffffb     	b	0x40004e90 <vfs_chdir+0x7c>

0000000040004ea8 <vfs_mkdir>:
40004ea8: b40001e0     	cbz	x0, 0x40004ee4 <vfs_mkdir+0x3c>
40004eac: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004eb0: 39400008     	ldrb	w8, [x0]
40004eb4: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004eb8: aa0003f3     	mov	x19, x0
40004ebc: a90157f6     	stp	x22, x21, [sp, #0x10]
40004ec0: 910003fd     	mov	x29, sp
40004ec4: 34000148     	cbz	w8, 0x40004eec <vfs_mkdir+0x44>
40004ec8: 90000094     	adrp	x20, 0x40014000 <kernel_capture_buffer+0x3470>
40004ecc: f945d295     	ldr	x21, [x20, #0xba0]
40004ed0: b944baa8     	ldr	w8, [x21, #0x4b8]
40004ed4: 71003d1f     	cmp	w8, #0xf
40004ed8: 540000ed     	b.le	0x40004ef4 <vfs_mkdir+0x4c>
40004edc: 12800020     	mov	w0, #-0x2               // =-2
40004ee0: 14000043     	b	0x40004fec <vfs_mkdir+0x144>
40004ee4: 12800000     	mov	w0, #-0x1               // =-1
40004ee8: d65f03c0     	ret
40004eec: 12800000     	mov	w0, #-0x1               // =-1
40004ef0: 1400003f     	b	0x40004fec <vfs_mkdir+0x144>
40004ef4: 7100051f     	cmp	w8, #0x1
40004ef8: 540001eb     	b.lt	0x40004f34 <vfs_mkdir+0x8c>
40004efc: aa1f03f6     	mov	x22, xzr
40004f00: 14000005     	b	0x40004f14 <vfs_mkdir+0x6c>
40004f04: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004f08: 910006d6     	add	x22, x22, #0x1
40004f0c: eb0802df     	cmp	x22, x8
40004f10: 5400012a     	b.ge	0x40004f34 <vfs_mkdir+0x8c>
40004f14: 8b160ea8     	add	x8, x21, x22, lsl #3
40004f18: f9421d00     	ldr	x0, [x8, #0x438]
40004f1c: b4ffff40     	cbz	x0, 0x40004f04 <vfs_mkdir+0x5c>
40004f20: aa1303e1     	mov	x1, x19
40004f24: 97fff6e0     	bl	0x40002aa4 <kstrcmp>
40004f28: 340003e0     	cbz	w0, 0x40004fa4 <vfs_mkdir+0xfc>
40004f2c: f945d295     	ldr	x21, [x20, #0xba0]
40004f30: 17fffff5     	b	0x40004f04 <vfs_mkdir+0x5c>
40004f34: 90000088     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40004f38: b98b9109     	ldrsw	x9, [x8, #0xb90]
40004f3c: 7101fd3f     	cmp	w9, #0x7f
40004f40: 5400006d     	b.le	0x40004f4c <vfs_mkdir+0xa4>
40004f44: 12800060     	mov	w0, #-0x4               // =-4
40004f48: 14000029     	b	0x40004fec <vfs_mkdir+0x144>
40004f4c: 5280980a     	mov	w10, #0x4c0             // =1216
40004f50: 9000008b     	adrp	x11, 0x40014000 <kernel_capture_buffer+0x3470>
40004f54: 912ea16b     	add	x11, x11, #0xba8
40004f58: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004f5c: 11000529     	add	w9, w9, #0x1
40004f60: 2a1f03e1     	mov	w1, wzr
40004f64: 52809802     	mov	w2, #0x4c0              // =1216
40004f68: b90b9109     	str	w9, [x8, #0xb90]
40004f6c: aa1403e0     	mov	x0, x20
40004f70: 97fff718     	bl	0x40002bd0 <memset>
40004f74: 39400268     	ldrb	w8, [x19]
40004f78: 340001a8     	cbz	w8, 0x40004fac <vfs_mkdir+0x104>
40004f7c: aa1f03ea     	mov	x10, xzr
40004f80: 91000669     	add	x9, x19, #0x1
40004f84: 382a6a88     	strb	w8, [x20, x10]
40004f88: 9100054b     	add	x11, x10, #0x1
40004f8c: 386a6928     	ldrb	w8, [x9, x10]
40004f90: 34000108     	cbz	w8, 0x40004fb0 <vfs_mkdir+0x108>
40004f94: f100795f     	cmp	x10, #0x1e
40004f98: aa0b03ea     	mov	x10, x11
40004f9c: 54ffff43     	b.lo	0x40004f84 <vfs_mkdir+0xdc>
40004fa0: 14000004     	b	0x40004fb0 <vfs_mkdir+0x108>
40004fa4: 12800040     	mov	w0, #-0x3               // =-3
40004fa8: 14000011     	b	0x40004fec <vfs_mkdir+0x144>
40004fac: aa1f03eb     	mov	x11, xzr
40004fb0: 382b6a9f     	strb	wzr, [x20, x11]
40004fb4: 2a1f03e0     	mov	w0, wzr
40004fb8: 52800029     	mov	w9, #0x1                // =1
40004fbc: b904ba9f     	str	wzr, [x20, #0x4b8]
40004fc0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004fc4: b9002289     	str	w9, [x20, #0x20]
40004fc8: f9021a95     	str	x21, [x20, #0x430]
40004fcc: 71003d1f     	cmp	w8, #0xf
40004fd0: f900169f     	str	xzr, [x20, #0x28]
40004fd4: 540000cc     	b.gt	0x40004fec <vfs_mkdir+0x144>
40004fd8: 8b080ea9     	add	x9, x21, x8, lsl #3
40004fdc: 2a1f03e0     	mov	w0, wzr
40004fe0: 11000508     	add	w8, w8, #0x1
40004fe4: b904baa8     	str	w8, [x21, #0x4b8]
40004fe8: f9021d34     	str	x20, [x9, #0x438]
40004fec: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004ff0: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004ff4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004ff8: d65f03c0     	ret

0000000040004ffc <vfs_sync>:
40004ffc: d65f03c0     	ret

0000000040005000 <vfs_touch>:
40005000: b4000500     	cbz	x0, 0x400050a0 <vfs_touch+0xa0>
40005004: 39400008     	ldrb	w8, [x0]
40005008: 340004c8     	cbz	w8, 0x400050a0 <vfs_touch+0xa0>
4000500c: d10583ff     	sub	sp, sp, #0x160
40005010: f0000069     	adrp	x9, 0x40014000 <kernel_capture_buffer+0x3470>
40005014: a9154ff4     	stp	x20, x19, [sp, #0x150]
40005018: aa1f03f4     	mov	x20, xzr
4000501c: f945d133     	ldr	x19, [x9, #0xba0]
40005020: aa0003e9     	mov	x9, x0
40005024: a9127bfd     	stp	x29, x30, [sp, #0x120]
40005028: a9135ffc     	stp	x28, x23, [sp, #0x130]
4000502c: 910483fd     	add	x29, sp, #0x120
40005030: a91457f6     	stp	x22, x21, [sp, #0x140]
40005034: 14000003     	b	0x40005040 <vfs_touch+0x40>
40005038: aa0903f4     	mov	x20, x9
4000503c: 38401d28     	ldrb	w8, [x9, #0x1]!
40005040: 7100bd1f     	cmp	w8, #0x2f
40005044: 54ffffa0     	b.eq	0x40005038 <vfs_touch+0x38>
40005048: 35ffffa8     	cbnz	w8, 0x4000503c <vfs_touch+0x3c>
4000504c: b4000334     	cbz	x20, 0x400050b0 <vfs_touch+0xb0>
40005050: cb000288     	sub	x8, x20, x0
40005054: 52801fe9     	mov	w9, #0xff               // =255
40005058: aa0103f5     	mov	x21, x1
4000505c: f103fd1f     	cmp	x8, #0xff
40005060: aa0003e1     	mov	x1, x0
40005064: 910083e0     	add	x0, sp, #0x20
40005068: 9a893113     	csel	x19, x8, x9, lo
4000506c: 910083f6     	add	x22, sp, #0x20
40005070: aa1303e2     	mov	x2, x19
40005074: 97fff6b2     	bl	0x40002b3c <kstrncpy>
40005078: 910083e0     	add	x0, sp, #0x20
4000507c: 38336adf     	strb	wzr, [x22, x19]
40005080: 97ffff00     	bl	0x40004c80 <vfs_find>
40005084: b4000120     	cbz	x0, 0x400050a8 <vfs_touch+0xa8>
40005088: b9402008     	ldr	w8, [x0, #0x20]
4000508c: aa0003f3     	mov	x19, x0
40005090: 7100051f     	cmp	w8, #0x1
40005094: 540000a1     	b.ne	0x400050a8 <vfs_touch+0xa8>
40005098: 91000688     	add	x8, x20, #0x1
4000509c: 14000007     	b	0x400050b8 <vfs_touch+0xb8>
400050a0: 12800000     	mov	w0, #-0x1               // =-1
400050a4: d65f03c0     	ret
400050a8: 12800000     	mov	w0, #-0x1               // =-1
400050ac: 1400006a     	b	0x40005254 <vfs_touch+0x254>
400050b0: aa0003e8     	mov	x8, x0
400050b4: aa0103f5     	mov	x21, x1
400050b8: 910003e0     	mov	x0, sp
400050bc: aa0803e1     	mov	x1, x8
400050c0: 528003e2     	mov	w2, #0x1f               // =31
400050c4: 97fff69e     	bl	0x40002b3c <kstrncpy>
400050c8: b944ba68     	ldr	w8, [x19, #0x4b8]
400050cc: 39007fff     	strb	wzr, [sp, #0x1f]
400050d0: 7100051f     	cmp	w8, #0x1
400050d4: 5400024b     	b.lt	0x4000511c <vfs_touch+0x11c>
400050d8: aa1f03f6     	mov	x22, xzr
400050dc: 9110e277     	add	x23, x19, #0x438
400050e0: 14000004     	b	0x400050f0 <vfs_touch+0xf0>
400050e4: 910006d6     	add	x22, x22, #0x1
400050e8: eb28c2df     	cmp	x22, w8, sxtw
400050ec: 5400010a     	b.ge	0x4000510c <vfs_touch+0x10c>
400050f0: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
400050f4: b4ffff80     	cbz	x0, 0x400050e4 <vfs_touch+0xe4>
400050f8: 910003e1     	mov	x1, sp
400050fc: 97fff66a     	bl	0x40002aa4 <kstrcmp>
40005100: 340004a0     	cbz	w0, 0x40005194 <vfs_touch+0x194>
40005104: b944ba68     	ldr	w8, [x19, #0x4b8]
40005108: 17fffff7     	b	0x400050e4 <vfs_touch+0xe4>
4000510c: 71003d1f     	cmp	w8, #0xf
40005110: 5400006d     	b.le	0x4000511c <vfs_touch+0x11c>
40005114: 12800020     	mov	w0, #-0x2               // =-2
40005118: 1400004f     	b	0x40005254 <vfs_touch+0x254>
4000511c: f0000068     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
40005120: b98b9109     	ldrsw	x9, [x8, #0xb90]
40005124: 7101fd3f     	cmp	w9, #0x7f
40005128: 5400006d     	b.le	0x40005134 <vfs_touch+0x134>
4000512c: 12800060     	mov	w0, #-0x4               // =-4
40005130: 14000049     	b	0x40005254 <vfs_touch+0x254>
40005134: 5280980a     	mov	w10, #0x4c0             // =1216
40005138: f000006b     	adrp	x11, 0x40014000 <kernel_capture_buffer+0x3470>
4000513c: 912ea16b     	add	x11, x11, #0xba8
40005140: 9b2a2d34     	smaddl	x20, w9, w10, x11
40005144: 11000529     	add	w9, w9, #0x1
40005148: 2a1f03e1     	mov	w1, wzr
4000514c: 52809802     	mov	w2, #0x4c0              // =1216
40005150: b90b9109     	str	w9, [x8, #0xb90]
40005154: aa1403e0     	mov	x0, x20
40005158: 97fff69e     	bl	0x40002bd0 <memset>
4000515c: 394003e8     	ldrb	w8, [sp]
40005160: 340003e8     	cbz	w8, 0x400051dc <vfs_touch+0x1dc>
40005164: 910003ea     	mov	x10, sp
40005168: aa1f03e9     	mov	x9, xzr
4000516c: aa1503e0     	mov	x0, x21
40005170: b240014a     	orr	x10, x10, #0x1
40005174: 38296a88     	strb	w8, [x20, x9]
40005178: 38696948     	ldrb	w8, [x10, x9]
4000517c: 9100052b     	add	x11, x9, #0x1
40005180: 34000328     	cbz	w8, 0x400051e4 <vfs_touch+0x1e4>
40005184: f100793f     	cmp	x9, #0x1e
40005188: aa0b03e9     	mov	x9, x11
4000518c: 54ffff43     	b.lo	0x40005174 <vfs_touch+0x174>
40005190: 14000015     	b	0x400051e4 <vfs_touch+0x1e4>
40005194: b40005f5     	cbz	x21, 0x40005250 <vfs_touch+0x250>
40005198: aa1503e0     	mov	x0, x21
4000519c: 97fff632     	bl	0x40002a64 <kstrlen>
400051a0: 52807fe8     	mov	w8, #0x3ff              // =1023
400051a4: f10ffc1f     	cmp	x0, #0x3ff
400051a8: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
400051ac: 9a883014     	csel	x20, x0, x8, lo
400051b0: aa1503e1     	mov	x1, x21
400051b4: 9100c120     	add	x0, x9, #0x30
400051b8: aa1403e2     	mov	x2, x20
400051bc: 97fff69b     	bl	0x40002c28 <memcpy>
400051c0: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
400051c4: 2a1f03e0     	mov	w0, wzr
400051c8: 8b140108     	add	x8, x8, x20
400051cc: 3900c11f     	strb	wzr, [x8, #0x30]
400051d0: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
400051d4: f9001514     	str	x20, [x8, #0x28]
400051d8: 1400001f     	b	0x40005254 <vfs_touch+0x254>
400051dc: aa1f03eb     	mov	x11, xzr
400051e0: aa1503e0     	mov	x0, x21
400051e4: 382b6a9f     	strb	wzr, [x20, x11]
400051e8: b904ba9f     	str	wzr, [x20, #0x4b8]
400051ec: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400051f0: b900229f     	str	wzr, [x20, #0x20]
400051f4: f9021a93     	str	x19, [x20, #0x430]
400051f8: 71003d1f     	cmp	w8, #0xf
400051fc: f900169f     	str	xzr, [x20, #0x28]
40005200: 540000ac     	b.gt	0x40005214 <vfs_touch+0x214>
40005204: 8b080e69     	add	x9, x19, x8, lsl #3
40005208: 11000508     	add	w8, w8, #0x1
4000520c: b904ba68     	str	w8, [x19, #0x4b8]
40005210: f9021d34     	str	x20, [x9, #0x438]
40005214: b4000200     	cbz	x0, 0x40005254 <vfs_touch+0x254>
40005218: aa0003f3     	mov	x19, x0
4000521c: 97fff612     	bl	0x40002a64 <kstrlen>
40005220: 52807fe8     	mov	w8, #0x3ff              // =1023
40005224: f10ffc1f     	cmp	x0, #0x3ff
40005228: 9100c296     	add	x22, x20, #0x30
4000522c: 9a883015     	csel	x21, x0, x8, lo
40005230: aa1603e0     	mov	x0, x22
40005234: aa1303e1     	mov	x1, x19
40005238: aa1503e2     	mov	x2, x21
4000523c: 97fff67b     	bl	0x40002c28 <memcpy>
40005240: 2a1f03e0     	mov	w0, wzr
40005244: 38356adf     	strb	wzr, [x22, x21]
40005248: f9001695     	str	x21, [x20, #0x28]
4000524c: 14000002     	b	0x40005254 <vfs_touch+0x254>
40005250: 2a1f03e0     	mov	w0, wzr
40005254: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005258: a95457f6     	ldp	x22, x21, [sp, #0x140]
4000525c: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40005260: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40005264: 910583ff     	add	sp, sp, #0x160
40005268: d65f03c0     	ret

000000004000526c <vfs_write_file>:
4000526c: 17ffff65     	b	0x40005000 <vfs_touch>

0000000040005270 <vfs_remove>:
40005270: b40005c0     	cbz	x0, 0x40005328 <vfs_remove+0xb8>
40005274: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40005278: 39400008     	ldrb	w8, [x0]
4000527c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40005280: aa0003f3     	mov	x19, x0
40005284: f9000bf5     	str	x21, [sp, #0x10]
40005288: 910003fd     	mov	x29, sp
4000528c: 34000448     	cbz	w8, 0x40005314 <vfs_remove+0xa4>
40005290: f0000074     	adrp	x20, 0x40014000 <kernel_capture_buffer+0x3470>
40005294: f945d288     	ldr	x8, [x20, #0xba0]
40005298: b944b909     	ldr	w9, [x8, #0x4b8]
4000529c: 7100053f     	cmp	w9, #0x1
400052a0: 540003ab     	b.lt	0x40005314 <vfs_remove+0xa4>
400052a4: aa1f03f5     	mov	x21, xzr
400052a8: 14000005     	b	0x400052bc <vfs_remove+0x4c>
400052ac: b984b909     	ldrsw	x9, [x8, #0x4b8]
400052b0: 910006b5     	add	x21, x21, #0x1
400052b4: eb0902bf     	cmp	x21, x9
400052b8: 540002ea     	b.ge	0x40005314 <vfs_remove+0xa4>
400052bc: 8b150d09     	add	x9, x8, x21, lsl #3
400052c0: f9421d20     	ldr	x0, [x9, #0x438]
400052c4: b4ffff40     	cbz	x0, 0x400052ac <vfs_remove+0x3c>
400052c8: aa1303e1     	mov	x1, x19
400052cc: 97fff5f6     	bl	0x40002aa4 <kstrcmp>
400052d0: f945d288     	ldr	x8, [x20, #0xba0]
400052d4: 35fffec0     	cbnz	w0, 0x400052ac <vfs_remove+0x3c>
400052d8: b984b909     	ldrsw	x9, [x8, #0x4b8]
400052dc: d1000529     	sub	x9, x9, #0x1
400052e0: 6b15013f     	cmp	w9, w21
400052e4: 5400026d     	b.le	0x40005330 <vfs_remove+0xc0>
400052e8: f945d28a     	ldr	x10, [x20, #0xba0]
400052ec: b984b949     	ldrsw	x9, [x10, #0x4b8]
400052f0: d1000529     	sub	x9, x9, #0x1
400052f4: 8b150d08     	add	x8, x8, x21, lsl #3
400052f8: 910006b5     	add	x21, x21, #0x1
400052fc: eb0902bf     	cmp	x21, x9
40005300: f942210b     	ldr	x11, [x8, #0x440]
40005304: f9021d0b     	str	x11, [x8, #0x438]
40005308: aa0a03e8     	mov	x8, x10
4000530c: 54ffff4b     	b.lt	0x400052f4 <vfs_remove+0x84>
40005310: 14000009     	b	0x40005334 <vfs_remove+0xc4>
40005314: 12800000     	mov	w0, #-0x1               // =-1
40005318: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000531c: f9400bf5     	ldr	x21, [sp, #0x10]
40005320: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005324: d65f03c0     	ret
40005328: 12800000     	mov	w0, #-0x1               // =-1
4000532c: d65f03c0     	ret
40005330: aa0803ea     	mov	x10, x8
40005334: 8b090d48     	add	x8, x10, x9, lsl #3
40005338: 2a1f03e0     	mov	w0, wzr
4000533c: f9021d1f     	str	xzr, [x8, #0x438]
40005340: f945d288     	ldr	x8, [x20, #0xba0]
40005344: b944b909     	ldr	w9, [x8, #0x4b8]
40005348: 51000529     	sub	w9, w9, #0x1
4000534c: b904b909     	str	w9, [x8, #0x4b8]
40005350: 17fffff2     	b	0x40005318 <vfs_remove+0xa8>

0000000040005354 <vfs_list_dir>:
40005354: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005358: f0000068     	adrp	x8, 0x40014000 <kernel_capture_buffer+0x3470>
4000535c: f100001f     	cmp	x0, #0x0
40005360: a90257f6     	stp	x22, x21, [sp, #0x20]
40005364: f945d108     	ldr	x8, [x8, #0xba0]
40005368: f9000bf7     	str	x23, [sp, #0x10]
4000536c: 910003fd     	mov	x29, sp
40005370: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005374: 9a800115     	csel	x21, x8, x0, eq
40005378: b94022a8     	ldr	w8, [x21, #0x20]
4000537c: 7100051f     	cmp	w8, #0x1
40005380: 54000521     	b.ne	0x40005424 <vfs_list_dir+0xd0>
40005384: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005388: 9138ac00     	add	x0, x0, #0xe2b
4000538c: 97fff95f     	bl	0x40003908 <uart_puts>
40005390: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005394: 91221400     	add	x0, x0, #0x885
40005398: 97fff95c     	bl	0x40003908 <uart_puts>
4000539c: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400053a0: 91364400     	add	x0, x0, #0xd91
400053a4: 97fff959     	bl	0x40003908 <uart_puts>
400053a8: f9421aa8     	ldr	x8, [x21, #0x430]
400053ac: b4000088     	cbz	x8, 0x400053bc <vfs_list_dir+0x68>
400053b0: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400053b4: 910d4400     	add	x0, x0, #0x351
400053b8: 97fff954     	bl	0x40003908 <uart_puts>
400053bc: b944baa1     	ldr	w1, [x21, #0x4b8]
400053c0: 7100043f     	cmp	w1, #0x1
400053c4: 5400034b     	b.lt	0x4000542c <vfs_list_dir+0xd8>
400053c8: aa1f03f6     	mov	x22, xzr
400053cc: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
400053d0: 912c2273     	add	x19, x19, #0xb08
400053d4: 9110e2b7     	add	x23, x21, #0x438
400053d8: f0000014     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400053dc: 9119fa94     	add	x20, x20, #0x67e
400053e0: 14000008     	b	0x40005400 <vfs_list_dir+0xac>
400053e4: b9402841     	ldr	w1, [x2, #0x28]
400053e8: aa1403e0     	mov	x0, x20
400053ec: 97fffa5c     	bl	0x40003d5c <uart_printf>
400053f0: b984baa1     	ldrsw	x1, [x21, #0x4b8]
400053f4: 910006d6     	add	x22, x22, #0x1
400053f8: eb0102df     	cmp	x22, x1
400053fc: 5400018a     	b.ge	0x4000542c <vfs_list_dir+0xd8>
40005400: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005404: b4ffff62     	cbz	x2, 0x400053f0 <vfs_list_dir+0x9c>
40005408: b9402048     	ldr	w8, [x2, #0x20]
4000540c: 7100051f     	cmp	w8, #0x1
40005410: 54fffea1     	b.ne	0x400053e4 <vfs_list_dir+0x90>
40005414: aa1303e0     	mov	x0, x19
40005418: aa0203e1     	mov	x1, x2
4000541c: 97fffa50     	bl	0x40003d5c <uart_printf>
40005420: 17fffff4     	b	0x400053f0 <vfs_list_dir+0x9c>
40005424: 12800000     	mov	w0, #-0x1               // =-1
40005428: 14000005     	b	0x4000543c <vfs_list_dir+0xe8>
4000542c: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005430: 91275c00     	add	x0, x0, #0x9d7
40005434: 97fffa4a     	bl	0x40003d5c <uart_printf>
40005438: 2a1f03e0     	mov	w0, wzr
4000543c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005440: f9400bf7     	ldr	x23, [sp, #0x10]
40005444: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005448: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000544c: d65f03c0     	ret

0000000040005450 <vfs_load>:
40005450: d65f03c0     	ret
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
