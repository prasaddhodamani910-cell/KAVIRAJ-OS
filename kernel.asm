
kernel.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000040000000 <_start>:
40000000: d53800a0     	mrs	x0, MPIDR_EL1
40000004: 92401c00     	and	x0, x0, #0xff
40000008: b4000060     	cbz	x0, 0x40000014 <master_core>

000000004000000c <park_core>:
4000000c: d503205f     	wfe
40000010: 17ffffff     	b	0x4000000c <park_core>

0000000040000014 <master_core>:
40000014: 58000160     	ldr	x0, 0x40000040 <halt+0x8>
40000018: 9100001f     	mov	sp, x0
4000001c: 58000161     	ldr	x1, 0x40000048 <halt+0x10>
40000020: 58000182     	ldr	x2, 0x40000050 <halt+0x18>

0000000040000024 <clear_bss_loop>:
40000024: eb02003f     	cmp	x1, x2
40000028: 5400006a     	b.ge	0x40000034 <jump_to_kernel>
4000002c: f800843f     	str	xzr, [x1], #0x8
40000030: 17fffffd     	b	0x40000024 <clear_bss_loop>

0000000040000034 <jump_to_kernel>:
40000034: 940005cb     	bl	0x40001760 <kmain>

0000000040000038 <halt>:
40000038: d503207f     	wfi
4000003c: 17ffffff     	b	0x40000038 <halt>
40000040: 90 8b 04 40  	.word	0x40048b90
40000044: 00 00 00 00  	.word	0x00000000
40000048: 00 a0 00 40  	.word	0x4000a000
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 90 8b 03 40  	.word	0x40038b90
40000054: 00 00 00 00  	.word	0x00000000

0000000040000058 <handle_sync_exception>:
40000058: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
4000005c: d503201f     	nop
40000060: 7003a660     	adr	x0, 0x4000752f <__rodata_start+0x152f>
40000064: f9000bf5     	str	x21, [sp, #0x10]
40000068: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000006c: 910003fd     	mov	x29, sp
40000070: d5385214     	mrs	x20, ESR_EL1
40000074: d5384033     	mrs	x19, ELR_EL1
40000078: d5386015     	mrs	x21, FAR_EL1
4000007c: 94000d0e     	bl	0x400034b4 <uart_puts>
40000080: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000084: 91333800     	add	x0, x0, #0xcce
40000088: aa1403e1     	mov	x1, x20
4000008c: 94000e1a     	bl	0x400038f4 <uart_printf>
40000090: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000094: 913ed400     	add	x0, x0, #0xfb5
40000098: aa1303e1     	mov	x1, x19
4000009c: 94000e16     	bl	0x400038f4 <uart_printf>
400000a0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400000a4: 91114c00     	add	x0, x0, #0x453
400000a8: aa1503e1     	mov	x1, x21
400000ac: 94000e12     	bl	0x400038f4 <uart_printf>
400000b0: 531a7e94     	lsr	w20, w20, #26
400000b4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400000b8: 91104400     	add	x0, x0, #0x411
400000bc: 2a1403e1     	mov	w1, w20
400000c0: 94000e0d     	bl	0x400038f4 <uart_printf>
400000c4: 35000094     	cbnz	w20, 0x400000d4 <handle_sync_exception+0x7c>
400000c8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400000cc: 91000000     	add	x0, x0, #0x0
400000d0: 1400000a     	b	0x400000f8 <handle_sync_exception+0xa0>
400000d4: 7100929f     	cmp	w20, #0x24
400000d8: 540000c0     	b.eq	0x400000f0 <handle_sync_exception+0x98>
400000dc: 7100569f     	cmp	w20, #0x15
400000e0: 540000e1     	b.ne	0x400000fc <handle_sync_exception+0xa4>
400000e4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400000e8: 910db000     	add	x0, x0, #0x36c
400000ec: 14000003     	b	0x400000f8 <handle_sync_exception+0xa0>
400000f0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400000f4: 91291c00     	add	x0, x0, #0xa47
400000f8: 94000cef     	bl	0x400034b4 <uart_puts>
400000fc: 91001268     	add	x8, x19, #0x4
40000100: d5184028     	msr	ELR_EL1, x8
40000104: f9400bf5     	ldr	x21, [sp, #0x10]
40000108: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000010c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000110: 9103a400     	add	x0, x0, #0xe9
40000114: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40000118: 14000ce7     	b	0x400034b4 <uart_puts>

000000004000011c <c_handle_sync_invalid>:
4000011c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000120: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000124: 9138fc00     	add	x0, x0, #0xe3f
40000128: a9014ff4     	stp	x20, x19, [sp, #0x10]
4000012c: 910003fd     	mov	x29, sp
40000130: d5385213     	mrs	x19, ESR_EL1
40000134: d5384034     	mrs	x20, ELR_EL1
40000138: 94000def     	bl	0x400038f4 <uart_printf>
4000013c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000140: 912acc00     	add	x0, x0, #0xab3
40000144: aa1303e1     	mov	x1, x19
40000148: aa1403e2     	mov	x2, x20
4000014c: 94000dea     	bl	0x400038f4 <uart_printf>
40000150: 14000000     	b	0x40000150 <c_handle_sync_invalid+0x34>

0000000040000154 <c_handle_irq_invalid>:
40000154: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000158: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000015c: 91337c00     	add	x0, x0, #0xcdf
40000160: 910003fd     	mov	x29, sp
40000164: 94000cd4     	bl	0x400034b4 <uart_puts>
40000168: 14000000     	b	0x40000168 <c_handle_irq_invalid+0x14>

000000004000016c <c_handle_fiq_invalid>:
4000016c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000170: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000174: 91298400     	add	x0, x0, #0xa61
40000178: 910003fd     	mov	x29, sp
4000017c: 94000cce     	bl	0x400034b4 <uart_puts>
40000180: 14000000     	b	0x40000180 <c_handle_fiq_invalid+0x14>

0000000040000184 <c_handle_serror_invalid>:
40000184: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000188: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000018c: 91036800     	add	x0, x0, #0xda
40000190: 910003fd     	mov	x29, sp
40000194: 94000cc8     	bl	0x400034b4 <uart_puts>
40000198: 14000000     	b	0x40000198 <c_handle_serror_invalid+0x14>

000000004000019c <launch_kedit>:
4000019c: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400001a0: a9016ffc     	stp	x28, x27, [sp, #0x10]
400001a4: 910003fd     	mov	x29, sp
400001a8: a90267fa     	stp	x26, x25, [sp, #0x20]
400001ac: a9035ff8     	stp	x24, x23, [sp, #0x30]
400001b0: a90457f6     	stp	x22, x21, [sp, #0x40]
400001b4: a9054ff4     	stp	x20, x19, [sp, #0x50]
400001b8: d11043ff     	sub	sp, sp, #0x410
400001bc: d503201f     	nop
400001c0: 1004f213     	adr	x19, 0x4000a000 <__bss_start>
400001c4: aa0003f4     	mov	x20, x0
400001c8: aa1303e0     	mov	x0, x19
400001cc: 2a1f03e1     	mov	w1, wzr
400001d0: 52864a82     	mov	w2, #0x3254             // =12884
400001d4: 9400098a     	bl	0x400027fc <memset>
400001d8: aa1303e0     	mov	x0, x19
400001dc: aa1403e1     	mov	x1, x20
400001e0: 528007e2     	mov	w2, #0x3f               // =63
400001e4: 94000961     	bl	0x40002768 <kstrncpy>
400001e8: 5280003c     	mov	w28, #0x1               // =1
400001ec: aa1403e0     	mov	x0, x20
400001f0: b932427c     	str	w28, [x19, #0x3240]
400001f4: 94001180     	bl	0x400047f4 <vfs_find>
400001f8: b0000077     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
400001fc: b40004a0     	cbz	x0, 0x40000290 <launch_kedit+0xf4>
40000200: b9402008     	ldr	w8, [x0, #0x20]
40000204: 35000468     	cbnz	w8, 0x40000290 <launch_kedit+0xf4>
40000208: f9401408     	ldr	x8, [x0, #0x28]
4000020c: b40003c8     	cbz	x8, 0x40000284 <launch_kedit+0xe8>
40000210: 2a1f03e8     	mov	w8, wzr
40000214: 2a1f03eb     	mov	w11, wzr
40000218: aa1f03e9     	mov	x9, xzr
4000021c: 9100c00a     	add	x10, x0, #0x30
40000220: 1400000d     	b	0x40000254 <launch_kedit+0xb8>
40000224: 93407d0c     	sxtw	x12, w8
40000228: 7101891f     	cmp	w8, #0x62
4000022c: 11000508     	add	w8, w8, #0x1
40000230: 8b0c1e6c     	add	x12, x19, x12, lsl #7
40000234: 8b2bc18b     	add	x11, x12, w11, sxtw
40000238: 3901017f     	strb	wzr, [x11, #0x40]
4000023c: 2a1f03eb     	mov	w11, wzr
40000240: 5400022c     	b.gt	0x40000284 <launch_kedit+0xe8>
40000244: f940140c     	ldr	x12, [x0, #0x28]
40000248: 91000529     	add	x9, x9, #0x1
4000024c: eb0c013f     	cmp	x9, x12
40000250: 540001a2     	b.hs	0x40000284 <launch_kedit+0xe8>
40000254: 3869694c     	ldrb	w12, [x10, x9]
40000258: 7100299f     	cmp	w12, #0xa
4000025c: 54fffe40     	b.eq	0x40000224 <launch_kedit+0x88>
40000260: 7101f97f     	cmp	w11, #0x7e
40000264: 54ffff0c     	b.gt	0x40000244 <launch_kedit+0xa8>
40000268: 2a0803ed     	mov	w13, w8
4000026c: 93407dad     	sxtw	x13, w13
40000270: 8b0d1e6d     	add	x13, x19, x13, lsl #7
40000274: 8b2bc1ad     	add	x13, x13, w11, sxtw
40000278: 1100056b     	add	w11, w11, #0x1
4000027c: 390101ac     	strb	w12, [x13, #0x40]
40000280: 17fffff1     	b	0x40000244 <launch_kedit+0xa8>
40000284: 7100051f     	cmp	w8, #0x1
40000288: 1a9f8508     	csinc	w8, w8, wzr, hi
4000028c: b90242e8     	str	w8, [x23, #0x240]
40000290: d503201f     	nop
40000294: 7003ad00     	adr	x0, 0x40007837 <__rodata_start+0x1837>
40000298: 94000c87     	bl	0x400034b4 <uart_puts>
4000029c: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
400002a0: 91326694     	add	x20, x20, #0xc99
400002a4: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
400002a8: 9104a6d6     	add	x22, x22, #0x129
400002ac: f0000038     	adrp	x24, 0x40007000 <__rodata_start+0x1000>
400002b0: 910dfb18     	add	x24, x24, #0x37e
400002b4: f0000039     	adrp	x25, 0x40007000 <__rodata_start+0x1000>
400002b8: 9119bf39     	add	x25, x25, #0x66f
400002bc: b000007a     	adrp	x26, 0x4000d000 <__bss_start+0x3000>
400002c0: 9109135a     	add	x26, x26, #0x244
400002c4: b000007b     	adrp	x27, 0x4000d000 <__bss_start+0x3000>
400002c8: 14000004     	b	0x400002d8 <launch_kedit+0x13c>
400002cc: 51004d08     	sub	w8, w8, #0x13
400002d0: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
400002d4: b9024d28     	str	w8, [x9, #0x24c]
400002d8: aa1403e0     	mov	x0, x20
400002dc: 94000c76     	bl	0x400034b4 <uart_puts>
400002e0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400002e4: 9107cc00     	add	x0, x0, #0x1f3
400002e8: 94000c73     	bl	0x400034b4 <uart_puts>
400002ec: aa1603e0     	mov	x0, x22
400002f0: 94000c71     	bl	0x400034b4 <uart_puts>
400002f4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400002f8: 9133f000     	add	x0, x0, #0xcfc
400002fc: aa1303e1     	mov	x1, x19
40000300: 94000d7d     	bl	0x400038f4 <uart_printf>
40000304: b9725268     	ldr	w8, [x19, #0x3250]
40000308: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
4000030c: 910cd129     	add	x9, x9, #0x334
40000310: 7100011f     	cmp	w8, #0x0
40000314: f0000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
40000318: 9121c508     	add	x8, x8, #0x871
4000031c: 9a880120     	csel	x0, x9, x8, eq
40000320: 94000c65     	bl	0x400034b4 <uart_puts>
40000324: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000328: 913f8c00     	add	x0, x0, #0xfe3
4000032c: 94000c62     	bl	0x400034b4 <uart_puts>
40000330: aa1f03f5     	mov	x21, xzr
40000334: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000338: b9724269     	ldr	w9, [x19, #0x3240]
4000033c: 8b0802a8     	add	x8, x21, x8
40000340: 8b081e6a     	add	x10, x19, x8, lsl #7
40000344: 6b09011f     	cmp	w8, w9
40000348: 9101014a     	add	x10, x10, #0x40
4000034c: 9a98b140     	csel	x0, x10, x24, lt
40000350: 94000c59     	bl	0x400034b4 <uart_puts>
40000354: aa1903e0     	mov	x0, x25
40000358: 94000c57     	bl	0x400034b4 <uart_puts>
4000035c: 910006b5     	add	x21, x21, #0x1
40000360: 710052bf     	cmp	w21, #0x14
40000364: 54fffe81     	b.ne	0x40000334 <launch_kedit+0x198>
40000368: aa1603e0     	mov	x0, x22
4000036c: 94000c52     	bl	0x400034b4 <uart_puts>
40000370: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000374: 910e2400     	add	x0, x0, #0x389
40000378: 94000c4f     	bl	0x400034b4 <uart_puts>
4000037c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000380: 9129f800     	add	x0, x0, #0xa7e
40000384: 94000c4c     	bl	0x400034b4 <uart_puts>
40000388: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000038c: 9119c400     	add	x0, x0, #0x671
40000390: 94000c49     	bl	0x400034b4 <uart_puts>
40000394: 2940a349     	ldp	w9, w8, [x26, #0x4]
40000398: b940034a     	ldr	w10, [x26]
4000039c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003a0: 9111fc00     	add	x0, x0, #0x47f
400003a4: 4b080128     	sub	w8, w9, w8
400003a8: 11000542     	add	w2, w10, #0x1
400003ac: 11000901     	add	w1, w8, #0x2
400003b0: 94000d51     	bl	0x400038f4 <uart_printf>
400003b4: 94000c73     	bl	0x40003580 <uart_getc>
400003b8: 12001c08     	and	w8, w0, #0xff
400003bc: 2a0003f5     	mov	w21, w0
400003c0: 7100491f     	cmp	w8, #0x12
400003c4: 5400010d     	b.le	0x400003e4 <launch_kedit+0x248>
400003c8: 7100691f     	cmp	w8, #0x1a
400003cc: 540009ed     	b.le	0x40000508 <launch_kedit+0x36c>
400003d0: 71006d1f     	cmp	w8, #0x1b
400003d4: 54000e40     	b.eq	0x4000059c <launch_kedit+0x400>
400003d8: 7101fd1f     	cmp	w8, #0x7f
400003dc: 540005e0     	b.eq	0x40000498 <launch_kedit+0x2fc>
400003e0: 1400008b     	b	0x4000060c <launch_kedit+0x470>
400003e4: 7100211f     	cmp	w8, #0x8
400003e8: 54000580     	b.eq	0x40000498 <launch_kedit+0x2fc>
400003ec: 7100291f     	cmp	w8, #0xa
400003f0: 54000060     	b.eq	0x400003fc <launch_kedit+0x260>
400003f4: 7100351f     	cmp	w8, #0xd
400003f8: 540010a1     	b.ne	0x4000060c <launch_kedit+0x470>
400003fc: b98242f6     	ldrsw	x22, [x23, #0x240]
40000400: 71018edf     	cmp	w22, #0x63
40000404: 540014ac     	b.gt	0x40000698 <launch_kedit+0x4fc>
40000408: b9824b68     	ldrsw	x8, [x27, #0x248]
4000040c: 6b0802df     	cmp	w22, w8
40000410: 5400016d     	b.le	0x4000043c <launch_kedit+0x2a0>
40000414: 8b161e68     	add	x8, x19, x22, lsl #7
40000418: 91010100     	add	x0, x8, #0x40
4000041c: d1020015     	sub	x21, x0, #0x80
40000420: d10006d6     	sub	x22, x22, #0x1
40000424: aa1503e1     	mov	x1, x21
40000428: 940008c9     	bl	0x4000274c <kstrcpy>
4000042c: b9824b68     	ldrsw	x8, [x27, #0x248]
40000430: aa1503e0     	mov	x0, x21
40000434: eb0802df     	cmp	x22, x8
40000438: 54ffff2c     	b.gt	0x4000041c <launch_kedit+0x280>
4000043c: d0000055     	adrp	x21, 0x4000a000 <__bss_start>
40000440: 910102b5     	add	x21, x21, #0x40
40000444: 910023e0     	add	x0, sp, #0x8
40000448: b9b206a9     	ldrsw	x9, [x21, #0x3204]
4000044c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000450: 8b090101     	add	x1, x8, x9
40000454: 940008be     	bl	0x4000274c <kstrcpy>
40000458: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
4000045c: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000460: 910023e1     	add	x1, sp, #0x8
40000464: 8b081ea8     	add	x8, x21, x8, lsl #7
40000468: 3829691f     	strb	wzr, [x8, x9]
4000046c: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000470: 91000508     	add	x8, x8, #0x1
40000474: 8b081ea0     	add	x0, x21, x8, lsl #7
40000478: b9320aa8     	str	w8, [x21, #0x3208]
4000047c: 940008b4     	bl	0x4000274c <kstrcpy>
40000480: b97202a8     	ldr	w8, [x21, #0x3200]
40000484: b93206bf     	str	wzr, [x21, #0x3204]
40000488: b93212bc     	str	w28, [x21, #0x3210]
4000048c: 11000508     	add	w8, w8, #0x1
40000490: b93202a8     	str	w8, [x21, #0x3200]
40000494: 14000081     	b	0x40000698 <launch_kedit+0x4fc>
40000498: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
4000049c: b9424508     	ldr	w8, [x8, #0x244]
400004a0: 7100051f     	cmp	w8, #0x1
400004a4: 54000fab     	b.lt	0x40000698 <launch_kedit+0x4fc>
400004a8: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400004ac: 8b081e68     	add	x8, x19, x8, lsl #7
400004b0: 91010100     	add	x0, x8, #0x40
400004b4: 94000877     	bl	0x40002690 <kstrlen>
400004b8: b9724669     	ldr	w9, [x19, #0x3244]
400004bc: 6b00013f     	cmp	w9, w0
400004c0: 51000528     	sub	w8, w9, #0x1
400004c4: 540001cc     	b.gt	0x400004fc <launch_kedit+0x360>
400004c8: 8b28c268     	add	x8, x19, w8, sxtw
400004cc: 4b090009     	sub	w9, w0, w9
400004d0: 11000529     	add	w9, w9, #0x1
400004d4: b9824b6a     	ldrsw	x10, [x27, #0x248]
400004d8: 71000529     	subs	w9, w9, #0x1
400004dc: 8b0a1d0a     	add	x10, x8, x10, lsl #7
400004e0: 91000508     	add	x8, x8, #0x1
400004e4: 3941054b     	ldrb	w11, [x10, #0x41]
400004e8: 3901014b     	strb	w11, [x10, #0x40]
400004ec: 54ffff41     	b.ne	0x400004d4 <launch_kedit+0x338>
400004f0: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
400004f4: b9424508     	ldr	w8, [x8, #0x244]
400004f8: 51000508     	sub	w8, w8, #0x1
400004fc: b9000348     	str	w8, [x26]
40000500: b9000f5c     	str	w28, [x26, #0xc]
40000504: 14000065     	b	0x40000698 <launch_kedit+0x4fc>
40000508: 71004d1f     	cmp	w8, #0x13
4000050c: 540007c1     	b.ne	0x40000604 <launch_kedit+0x468>
40000510: b94242e8     	ldr	w8, [x23, #0x240]
40000514: 390023ff     	strb	wzr, [sp, #0x8]
40000518: 7100051f     	cmp	w8, #0x1
4000051c: 5400030b     	b.lt	0x4000057c <launch_kedit+0x3e0>
40000520: aa1f03fc     	mov	x28, xzr
40000524: 2a1f03f6     	mov	w22, wzr
40000528: d0000055     	adrp	x21, 0x4000a000 <__bss_start>
4000052c: 910102b5     	add	x21, x21, #0x40
40000530: 14000006     	b	0x40000548 <launch_kedit+0x3ac>
40000534: b98242e8     	ldrsw	x8, [x23, #0x240]
40000538: 9100079c     	add	x28, x28, #0x1
4000053c: 910202b5     	add	x21, x21, #0x80
40000540: eb08039f     	cmp	x28, x8
40000544: 540001ca     	b.ge	0x4000057c <launch_kedit+0x3e0>
40000548: aa1503e0     	mov	x0, x21
4000054c: 94000851     	bl	0x40002690 <kstrlen>
40000550: 0b0002d4     	add	w20, w22, w0
40000554: 710ffa9f     	cmp	w20, #0x3fe
40000558: 54fffeec     	b.gt	0x40000534 <launch_kedit+0x398>
4000055c: 910023e0     	add	x0, sp, #0x8
40000560: aa1503e1     	mov	x1, x21
40000564: 94000852     	bl	0x400026ac <kstrcat>
40000568: 910023e0     	add	x0, sp, #0x8
4000056c: aa1903e1     	mov	x1, x25
40000570: 9400084f     	bl	0x400026ac <kstrcat>
40000574: 11000696     	add	w22, w20, #0x1
40000578: 17ffffef     	b	0x40000534 <launch_kedit+0x398>
4000057c: 910023e1     	add	x1, sp, #0x8
40000580: aa1303e0     	mov	x0, x19
40000584: 94001217     	bl	0x40004de0 <vfs_write_file>
40000588: b932527f     	str	wzr, [x19, #0x3250]
4000058c: 5280003c     	mov	w28, #0x1               // =1
40000590: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
40000594: 91326694     	add	x20, x20, #0xc99
40000598: 14000040     	b	0x40000698 <launch_kedit+0x4fc>
4000059c: 94000bf9     	bl	0x40003580 <uart_getc>
400005a0: 12001c14     	and	w20, w0, #0xff
400005a4: 94000bf7     	bl	0x40003580 <uart_getc>
400005a8: 71016e9f     	cmp	w20, #0x5b
400005ac: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
400005b0: 91326694     	add	x20, x20, #0xc99
400005b4: 54000721     	b.ne	0x40000698 <launch_kedit+0x4fc>
400005b8: 12001c09     	and	w9, w0, #0xff
400005bc: b9424b68     	ldr	w8, [x27, #0x248]
400005c0: 7101053f     	cmp	w9, #0x41
400005c4: 54000801     	b.ne	0x400006c4 <launch_kedit+0x528>
400005c8: 7100011f     	cmp	w8, #0x0
400005cc: 540007cd     	b.le	0x400006c4 <launch_kedit+0x528>
400005d0: 12800009     	mov	w9, #-0x1               // =-1
400005d4: 0b090108     	add	w8, w8, w9
400005d8: b9024b68     	str	w8, [x27, #0x248]
400005dc: 93407d08     	sxtw	x8, w8
400005e0: 8b081e68     	add	x8, x19, x8, lsl #7
400005e4: 91010100     	add	x0, x8, #0x40
400005e8: 9400082a     	bl	0x40002690 <kstrlen>
400005ec: b9724668     	ldr	w8, [x19, #0x3244]
400005f0: 6b00011f     	cmp	w8, w0
400005f4: 5400052d     	b.le	0x40000698 <launch_kedit+0x4fc>
400005f8: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
400005fc: b9024500     	str	w0, [x8, #0x244]
40000600: 14000026     	b	0x40000698 <launch_kedit+0x4fc>
40000604: 7100611f     	cmp	w8, #0x18
40000608: 54000ac0     	b.eq	0x40000760 <launch_kedit+0x5c4>
4000060c: 510082a8     	sub	w8, w21, #0x20
40000610: 12001d08     	and	w8, w8, #0xff
40000614: 7101791f     	cmp	w8, #0x5e
40000618: 54000408     	b.hi	0x40000698 <launch_kedit+0x4fc>
4000061c: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40000620: b9424508     	ldr	w8, [x8, #0x244]
40000624: 7101f91f     	cmp	w8, #0x7e
40000628: 5400038c     	b.gt	0x40000698 <launch_kedit+0x4fc>
4000062c: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000630: 8b081e68     	add	x8, x19, x8, lsl #7
40000634: 91010100     	add	x0, x8, #0x40
40000638: 94000816     	bl	0x40002690 <kstrlen>
4000063c: b9b24668     	ldrsw	x8, [x19, #0x3244]
40000640: 6b00011f     	cmp	w8, w0
40000644: 540001ac     	b.gt	0x40000678 <launch_kedit+0x4dc>
40000648: 93407c08     	sxtw	x8, w0
4000064c: 91000509     	add	x9, x8, #0x1
40000650: 8b08026a     	add	x10, x19, x8
40000654: b9800748     	ldrsw	x8, [x26, #0x4]
40000658: d1000529     	sub	x9, x9, #0x1
4000065c: 8b081d48     	add	x8, x10, x8, lsl #7
40000660: d100054a     	sub	x10, x10, #0x1
40000664: 3941010b     	ldrb	w11, [x8, #0x40]
40000668: 3901050b     	strb	w11, [x8, #0x41]
4000066c: b9800348     	ldrsw	x8, [x26]
40000670: eb08013f     	cmp	x9, x8
40000674: 54ffff0c     	b.gt	0x40000654 <launch_kedit+0x4b8>
40000678: b9b24a69     	ldrsw	x9, [x19, #0x3248]
4000067c: 8b091e69     	add	x9, x19, x9, lsl #7
40000680: 8b080128     	add	x8, x9, x8
40000684: 39010115     	strb	w21, [x8, #0x40]
40000688: b9724668     	ldr	w8, [x19, #0x3244]
4000068c: b932527c     	str	w28, [x19, #0x3250]
40000690: 11000508     	add	w8, w8, #0x1
40000694: b9324668     	str	w8, [x19, #0x3244]
40000698: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
4000069c: 91092129     	add	x9, x9, #0x248
400006a0: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
400006a4: 9104a6d6     	add	x22, x22, #0x129
400006a8: 29402528     	ldp	w8, w9, [x9]
400006ac: 6b09011f     	cmp	w8, w9
400006b0: 54ffe10b     	b.lt	0x400002d0 <launch_kedit+0x134>
400006b4: 11005129     	add	w9, w9, #0x14
400006b8: 6b09011f     	cmp	w8, w9
400006bc: 54ffe0eb     	b.lt	0x400002d8 <launch_kedit+0x13c>
400006c0: 17ffff03     	b	0x400002cc <launch_kedit+0x130>
400006c4: 71010d3f     	cmp	w9, #0x43
400006c8: 54000120     	b.eq	0x400006ec <launch_kedit+0x550>
400006cc: 7101093f     	cmp	w9, #0x42
400006d0: 540002a1     	b.ne	0x40000724 <launch_kedit+0x588>
400006d4: b94242e9     	ldr	w9, [x23, #0x240]
400006d8: 51000529     	sub	w9, w9, #0x1
400006dc: 6b09011f     	cmp	w8, w9
400006e0: 54fff7ea     	b.ge	0x400005dc <launch_kedit+0x440>
400006e4: 52800029     	mov	w9, #0x1                // =1
400006e8: 17ffffbb     	b	0x400005d4 <launch_kedit+0x438>
400006ec: 93407d08     	sxtw	x8, w8
400006f0: b9b24674     	ldrsw	x20, [x19, #0x3244]
400006f4: 8b081e68     	add	x8, x19, x8, lsl #7
400006f8: 91010100     	add	x0, x8, #0x40
400006fc: 940007e5     	bl	0x40002690 <kstrlen>
40000700: eb14001f     	cmp	x0, x20
40000704: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
40000708: 91326694     	add	x20, x20, #0xc99
4000070c: 54fffc69     	b.ls	0x40000698 <launch_kedit+0x4fc>
40000710: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40000714: b9424528     	ldr	w8, [x9, #0x244]
40000718: 11000508     	add	w8, w8, #0x1
4000071c: b9024528     	str	w8, [x9, #0x244]
40000720: 17ffffde     	b	0x40000698 <launch_kedit+0x4fc>
40000724: 12001c09     	and	w9, w0, #0xff
40000728: 7101113f     	cmp	w9, #0x44
4000072c: 54000101     	b.ne	0x4000074c <launch_kedit+0x5b0>
40000730: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40000734: b9424529     	ldr	w9, [x9, #0x244]
40000738: 71000529     	subs	w9, w9, #0x1
4000073c: 5400008b     	b.lt	0x4000074c <launch_kedit+0x5b0>
40000740: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40000744: b9024509     	str	w9, [x8, #0x244]
40000748: 17ffffd4     	b	0x40000698 <launch_kedit+0x4fc>
4000074c: 51010409     	sub	w9, w0, #0x41
40000750: 12001d29     	and	w9, w9, #0xff
40000754: 7100093f     	cmp	w9, #0x2
40000758: 54fff423     	b.lo	0x400005dc <launch_kedit+0x440>
4000075c: 17ffffcf     	b	0x40000698 <launch_kedit+0x4fc>
40000760: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000764: 9120f400     	add	x0, x0, #0x83d
40000768: 94000b53     	bl	0x400034b4 <uart_puts>
4000076c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000770: 91217c00     	add	x0, x0, #0x85f
40000774: 94000b50     	bl	0x400034b4 <uart_puts>
40000778: 911043ff     	add	sp, sp, #0x410
4000077c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40000780: a94457f6     	ldp	x22, x21, [sp, #0x40]
40000784: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40000788: a94267fa     	ldp	x26, x25, [sp, #0x20]
4000078c: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40000790: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40000794: d65f03c0     	ret

0000000040000798 <print_banner>:
40000798: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000079c: d503201f     	nop
400007a0: 70035280     	adr	x0, 0x400071f3 <__rodata_start+0x11f3>
400007a4: 910003fd     	mov	x29, sp
400007a8: 94000b43     	bl	0x400034b4 <uart_puts>
400007ac: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007b0: 9119bc00     	add	x0, x0, #0x66f
400007b4: 94000b40     	bl	0x400034b4 <uart_puts>
400007b8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007bc: 910ed800     	add	x0, x0, #0x3b6
400007c0: 94000b3d     	bl	0x400034b4 <uart_puts>
400007c4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007c8: 9121f800     	add	x0, x0, #0x87e
400007cc: 94000b3a     	bl	0x400034b4 <uart_puts>
400007d0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007d4: 91345c00     	add	x0, x0, #0xd17
400007d8: 94000b37     	bl	0x400034b4 <uart_puts>
400007dc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400007e0: 91009c00     	add	x0, x0, #0x27
400007e4: 94000b34     	bl	0x400034b4 <uart_puts>
400007e8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007ec: 91354800     	add	x0, x0, #0xd52
400007f0: 94000b31     	bl	0x400034b4 <uart_puts>
400007f4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400007f8: 91085800     	add	x0, x0, #0x216
400007fc: 94000b2e     	bl	0x400034b4 <uart_puts>
40000800: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000804: 913fa400     	add	x0, x0, #0xfe9
40000808: 94000c3b     	bl	0x400038f4 <uart_printf>
4000080c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000810: 9119e000     	add	x0, x0, #0x678
40000814: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000818: 91182421     	add	x1, x1, #0x609
4000081c: 94000c36     	bl	0x400038f4 <uart_printf>
40000820: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000824: 913c7c00     	add	x0, x0, #0xf1f
40000828: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000082c: 91363821     	add	x1, x1, #0xd8e
40000830: 94000c31     	bl	0x400038f4 <uart_printf>
40000834: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000838: 912a0c00     	add	x0, x0, #0xa83
4000083c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000840: 14000b1d     	b	0x400034b4 <uart_puts>

0000000040000844 <print_about>:
40000844: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000848: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000084c: 910acc00     	add	x0, x0, #0x2b3
40000850: 910003fd     	mov	x29, sp
40000854: 94000b18     	bl	0x400034b4 <uart_puts>
40000858: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000085c: 91159000     	add	x0, x0, #0x564
40000860: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000864: 91367c21     	add	x1, x1, #0xd9f
40000868: 94000c23     	bl	0x400038f4 <uart_printf>
4000086c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000870: 91279400     	add	x0, x0, #0x9e5
40000874: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000878: 91182421     	add	x1, x1, #0x609
4000087c: 94000c1e     	bl	0x400038f4 <uart_printf>
40000880: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000884: 910d0400     	add	x0, x0, #0x341
40000888: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000088c: 91363821     	add	x1, x1, #0xd8e
40000890: 94000c19     	bl	0x400038f4 <uart_printf>
40000894: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000898: 913dbc00     	add	x0, x0, #0xf6f
4000089c: 94000b06     	bl	0x400034b4 <uart_puts>
400008a0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400008a4: 91213400     	add	x0, x0, #0x84d
400008a8: 94000b03     	bl	0x400034b4 <uart_puts>
400008ac: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008b0: 9119bc00     	add	x0, x0, #0x66f
400008b4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400008b8: 14000aff     	b	0x400034b4 <uart_puts>

00000000400008bc <print_sysinfo>:
400008bc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400008c0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008c4: 91046400     	add	x0, x0, #0x119
400008c8: a9014ff4     	stp	x20, x19, [sp, #0x10]
400008cc: 910003fd     	mov	x29, sp
400008d0: d5384248     	mrs	x8, CurrentEL
400008d4: d3420d13     	ubfx	x19, x8, #2, #2
400008d8: d5380014     	mrs	x20, MIDR_EL1
400008dc: 94000af6     	bl	0x400034b4 <uart_puts>
400008e0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008e4: 91263c00     	add	x0, x0, #0x98f
400008e8: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400008ec: 91367c21     	add	x1, x1, #0xd9f
400008f0: d0000022     	adrp	x2, 0x40006000 <__rodata_start>
400008f4: 91182442     	add	x2, x2, #0x609
400008f8: 94000bff     	bl	0x400038f4 <uart_printf>
400008fc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000900: 9126b800     	add	x0, x0, #0x9ae
40000904: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000908: 91363821     	add	x1, x1, #0xd8e
4000090c: 94000bfa     	bl	0x400038f4 <uart_printf>
40000910: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000914: 91301000     	add	x0, x0, #0xc04
40000918: 94000bf7     	bl	0x400038f4 <uart_printf>
4000091c: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40000920: 910add08     	add	x8, x8, #0x2b7
40000924: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40000928: 913e9129     	add	x9, x9, #0xfa4
4000092c: f1000a7f     	cmp	x19, #0x2
40000930: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000934: 91189000     	add	x0, x0, #0x624
40000938: 9a880128     	csel	x8, x9, x8, eq
4000093c: f100067f     	cmp	x19, #0x1
40000940: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40000944: 9122e529     	add	x9, x9, #0x8b9
40000948: 2a1303e1     	mov	w1, w19
4000094c: 9a880122     	csel	x2, x9, x8, eq
40000950: 94000be9     	bl	0x400038f4 <uart_printf>
40000954: 53187e81     	lsr	w1, w20, #24
40000958: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000095c: 9115f400     	add	x0, x0, #0x57d
40000960: aa1403e2     	mov	x2, x20
40000964: 94000be4     	bl	0x400038f4 <uart_printf>
40000968: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000096c: 912c9400     	add	x0, x0, #0xb25
40000970: d503201f     	nop
40000974: 10ffb461     	adr	x1, 0x40000000 <_start>
40000978: 94000bdf     	bl	0x400038f4 <uart_printf>
4000097c: d503201f     	nop
40000980: 10ffb401     	adr	x1, 0x40000000 <_start>
40000984: d503201f     	nop
40000988: 10028642     	adr	x2, 0x40005a50 <__text_end>
4000098c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000990: 91328000     	add	x0, x0, #0xca0
40000994: cb010043     	sub	x3, x2, x1
40000998: 94000bd7     	bl	0x400038f4 <uart_printf>
4000099c: d503201f     	nop
400009a0: 1002b301     	adr	x1, 0x40006000 <__rodata_start>
400009a4: d503201f     	nop
400009a8: 1003db42     	adr	x2, 0x40008510 <__rodata_end>
400009ac: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400009b0: 911b4400     	add	x0, x0, #0x6d1
400009b4: cb010043     	sub	x3, x2, x1
400009b8: 94000bcf     	bl	0x400038f4 <uart_printf>
400009bc: d503201f     	nop
400009c0: 10043201     	adr	x1, 0x40009000 <next_pid>
400009c4: d503201f     	nop
400009c8: 101c0e42     	adr	x2, 0x40038b90
400009cc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400009d0: 912e3c00     	add	x0, x0, #0xb8f
400009d4: cb010043     	sub	x3, x2, x1
400009d8: 94000bc7     	bl	0x400038f4 <uart_printf>
400009dc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400009e0: 91012c00     	add	x0, x0, #0x4b
400009e4: d503201f     	nop
400009e8: 10240d41     	adr	x1, 0x40048b90 <__stack_top>
400009ec: 94000bc2     	bl	0x400038f4 <uart_printf>
400009f0: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400009f4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400009f8: 9119bc00     	add	x0, x0, #0x66f
400009fc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000a00: 14000aad     	b	0x400034b4 <uart_puts>

0000000040000a04 <print_android_roadmap>:
40000a04: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000a08: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a0c: 913ebc00     	add	x0, x0, #0xfaf
40000a10: 910003fd     	mov	x29, sp
40000a14: 94000aa8     	bl	0x400034b4 <uart_puts>
40000a18: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a1c: 912cfc00     	add	x0, x0, #0xb3f
40000a20: 94000aa5     	bl	0x400034b4 <uart_puts>
40000a24: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a28: 91191400     	add	x0, x0, #0x645
40000a2c: 94000aa2     	bl	0x400034b4 <uart_puts>
40000a30: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a34: 91272000     	add	x0, x0, #0x9c8
40000a38: 94000a9f     	bl	0x400034b4 <uart_puts>
40000a3c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a40: 911bec00     	add	x0, x0, #0x6fb
40000a44: 94000a9c     	bl	0x400034b4 <uart_puts>
40000a48: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a4c: 9107ec00     	add	x0, x0, #0x1fb
40000a50: 94000a99     	bl	0x400034b4 <uart_puts>
40000a54: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a58: 91332800     	add	x0, x0, #0xcca
40000a5c: 94000a96     	bl	0x400034b4 <uart_puts>
40000a60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000a64: 910b0c00     	add	x0, x0, #0x2c3
40000a68: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a6c: 14000a92     	b	0x400034b4 <uart_puts>

0000000040000a70 <read_line>:
40000a70: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000a74: f9000bf7     	str	x23, [sp, #0x10]
40000a78: aa1f03f7     	mov	x23, xzr
40000a7c: 910003fd     	mov	x29, sp
40000a80: a90257f6     	stp	x22, x21, [sp, #0x20]
40000a84: d1000435     	sub	x21, x1, #0x1
40000a88: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000a8c: aa0003f3     	mov	x19, x0
40000a90: 90000054     	adrp	x20, 0x40008000 <__rodata_start+0x2000>
40000a94: 9110be94     	add	x20, x20, #0x42f
40000a98: aa1703f6     	mov	x22, x23
40000a9c: 94000ab9     	bl	0x40003580 <uart_getc>
40000aa0: 12001c08     	and	w8, w0, #0xff
40000aa4: 7100311f     	cmp	w8, #0xc
40000aa8: 540000cc     	b.gt	0x40000ac0 <read_line+0x50>
40000aac: 7100211f     	cmp	w8, #0x8
40000ab0: 54000240     	b.eq	0x40000af8 <read_line+0x88>
40000ab4: 7100291f     	cmp	w8, #0xa
40000ab8: 540000c1     	b.ne	0x40000ad0 <read_line+0x60>
40000abc: 14000015     	b	0x40000b10 <read_line+0xa0>
40000ac0: 7100351f     	cmp	w8, #0xd
40000ac4: 54000260     	b.eq	0x40000b10 <read_line+0xa0>
40000ac8: 7101fd1f     	cmp	w8, #0x7f
40000acc: 54000160     	b.eq	0x40000af8 <read_line+0x88>
40000ad0: 51008008     	sub	w8, w0, #0x20
40000ad4: 12001d08     	and	w8, w8, #0xff
40000ad8: 7101791f     	cmp	w8, #0x5e
40000adc: 54fffe08     	b.hi	0x40000a9c <read_line+0x2c>
40000ae0: eb1502df     	cmp	x22, x21
40000ae4: 54fffdc2     	b.hs	0x40000a9c <read_line+0x2c>
40000ae8: 910006d7     	add	x23, x22, #0x1
40000aec: 38366a60     	strb	w0, [x19, x22]
40000af0: 94000a5a     	bl	0x40003458 <uart_putc>
40000af4: 17ffffe9     	b	0x40000a98 <read_line+0x28>
40000af8: aa1f03f7     	mov	x23, xzr
40000afc: b4fffcf6     	cbz	x22, 0x40000a98 <read_line+0x28>
40000b00: aa1403e0     	mov	x0, x20
40000b04: d10006d7     	sub	x23, x22, #0x1
40000b08: 94000a6b     	bl	0x400034b4 <uart_puts>
40000b0c: 17ffffe3     	b	0x40000a98 <read_line+0x28>
40000b10: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b14: 9101ac00     	add	x0, x0, #0x6b
40000b18: 94000a67     	bl	0x400034b4 <uart_puts>
40000b1c: 38366a7f     	strb	wzr, [x19, x22]
40000b20: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000b24: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000b28: f9400bf7     	ldr	x23, [sp, #0x10]
40000b2c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000b30: d65f03c0     	ret

0000000040000b34 <print_help>:
40000b34: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b38: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b3c: 91231400     	add	x0, x0, #0x8c5
40000b40: 910003fd     	mov	x29, sp
40000b44: 94000a5c     	bl	0x400034b4 <uart_puts>
40000b48: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b4c: 9115ec00     	add	x0, x0, #0x57b
40000b50: 94000a59     	bl	0x400034b4 <uart_puts>
40000b54: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b58: 91223400     	add	x0, x0, #0x88d
40000b5c: 94000a56     	bl	0x400034b4 <uart_puts>
40000b60: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b64: 9101b800     	add	x0, x0, #0x6e
40000b68: 94000a53     	bl	0x400034b4 <uart_puts>
40000b6c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b70: 9104f400     	add	x0, x0, #0x13d
40000b74: 94000a50     	bl	0x400034b4 <uart_puts>
40000b78: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b7c: 9136a800     	add	x0, x0, #0xdaa
40000b80: 94000a4d     	bl	0x400034b4 <uart_puts>
40000b84: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b88: 910c3800     	add	x0, x0, #0x30e
40000b8c: 94000a4a     	bl	0x400034b4 <uart_puts>
40000b90: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b94: 911d1800     	add	x0, x0, #0x746
40000b98: 94000a47     	bl	0x400034b4 <uart_puts>
40000b9c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ba0: 911b1000     	add	x0, x0, #0x6c4
40000ba4: 94000a44     	bl	0x400034b4 <uart_puts>
40000ba8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000bac: 910d5000     	add	x0, x0, #0x354
40000bb0: 94000a41     	bl	0x400034b4 <uart_puts>
40000bb4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000bb8: 911c1400     	add	x0, x0, #0x705
40000bbc: 94000a3e     	bl	0x400034b4 <uart_puts>
40000bc0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000bc4: 91344400     	add	x0, x0, #0xd11
40000bc8: 94000a3b     	bl	0x400034b4 <uart_puts>
40000bcc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000bd0: 9104b800     	add	x0, x0, #0x12e
40000bd4: 94000a38     	bl	0x400034b4 <uart_puts>
40000bd8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000bdc: 913f9c00     	add	x0, x0, #0xfe7
40000be0: 94000a35     	bl	0x400034b4 <uart_puts>
40000be4: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000be8: 91232400     	add	x0, x0, #0x8c9
40000bec: 94000a32     	bl	0x400034b4 <uart_puts>
40000bf0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000bf4: 912e0000     	add	x0, x0, #0xb80
40000bf8: 94000a2f     	bl	0x400034b4 <uart_puts>
40000bfc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c00: 91059000     	add	x0, x0, #0x164
40000c04: 94000a2c     	bl	0x400034b4 <uart_puts>
40000c08: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c0c: 91169000     	add	x0, x0, #0x5a4
40000c10: 94000a29     	bl	0x400034b4 <uart_puts>
40000c14: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000c18: 9110cc00     	add	x0, x0, #0x433
40000c1c: 94000a26     	bl	0x400034b4 <uart_puts>
40000c20: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c24: 910fc400     	add	x0, x0, #0x3f1
40000c28: 94000a23     	bl	0x400034b4 <uart_puts>
40000c2c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c30: 910b5400     	add	x0, x0, #0x2d5
40000c34: 94000a20     	bl	0x400034b4 <uart_puts>
40000c38: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c3c: 91092400     	add	x0, x0, #0x249
40000c40: 94000a1d     	bl	0x400034b4 <uart_puts>
40000c44: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000c48: 91008000     	add	x0, x0, #0x20
40000c4c: 94000a1a     	bl	0x400034b4 <uart_puts>
40000c50: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c54: 911d1c00     	add	x0, x0, #0x747
40000c58: 94000a17     	bl	0x400034b4 <uart_puts>
40000c5c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c60: 9110d400     	add	x0, x0, #0x435
40000c64: 94000a14     	bl	0x400034b4 <uart_puts>
40000c68: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c6c: 91122000     	add	x0, x0, #0x488
40000c70: 94000a11     	bl	0x400034b4 <uart_puts>
40000c74: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000c78: 9111f000     	add	x0, x0, #0x47c
40000c7c: 94000a0e     	bl	0x400034b4 <uart_puts>
40000c80: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c84: 911de800     	add	x0, x0, #0x77a
40000c88: 94000a0b     	bl	0x400034b4 <uart_puts>
40000c8c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c90: 9134f400     	add	x0, x0, #0xd3d
40000c94: 94000a08     	bl	0x400034b4 <uart_puts>
40000c98: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c9c: 91058000     	add	x0, x0, #0x160
40000ca0: 94000a05     	bl	0x400034b4 <uart_puts>
40000ca4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000ca8: 91018800     	add	x0, x0, #0x62
40000cac: 94000a02     	bl	0x400034b4 <uart_puts>
40000cb0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000cb4: 912b5000     	add	x0, x0, #0xad4
40000cb8: 940009ff     	bl	0x400034b4 <uart_puts>
40000cbc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000cc0: 9117b800     	add	x0, x0, #0x5ee
40000cc4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000cc8: 140009fb     	b	0x400034b4 <uart_puts>

0000000040000ccc <execute_command>:
40000ccc: d104c3ff     	sub	sp, sp, #0x130
40000cd0: a9124ff4     	stp	x20, x19, [sp, #0x120]
40000cd4: aa0003f3     	mov	x19, x0
40000cd8: aa1f03e8     	mov	x8, xzr
40000cdc: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
40000ce0: 910383fd     	add	x29, sp, #0xe0
40000ce4: f9007bfc     	str	x28, [sp, #0xf0]
40000ce8: a9105ff8     	stp	x24, x23, [sp, #0x100]
40000cec: a91157f6     	stp	x22, x21, [sp, #0x110]
40000cf0: 38686a6a     	ldrb	w10, [x19, x8]
40000cf4: 91000508     	add	x8, x8, #0x1
40000cf8: 7100815f     	cmp	w10, #0x20
40000cfc: 54ffffa0     	b.eq	0x40000cf0 <execute_command+0x24>
40000d00: aa1f03e9     	mov	x9, xzr
40000d04: d10083ab     	sub	x11, x29, #0x20
40000d08: 340001aa     	cbz	w10, 0x40000d3c <execute_command+0x70>
40000d0c: f100793f     	cmp	x9, #0x1e
40000d10: 54000168     	b.hi	0x40000d3c <execute_command+0x70>
40000d14: 8b09026c     	add	x12, x19, x9
40000d18: 3829696a     	strb	w10, [x11, x9]
40000d1c: 3868698a     	ldrb	w10, [x12, x8]
40000d20: 9100052c     	add	x12, x9, #0x1
40000d24: aa0c03e9     	mov	x9, x12
40000d28: 7100815f     	cmp	w10, #0x20
40000d2c: 54fffee1     	b.ne	0x40000d08 <execute_command+0x3c>
40000d30: 8b0c0108     	add	x8, x8, x12
40000d34: aa0c03e9     	mov	x9, x12
40000d38: 14000002     	b	0x40000d40 <execute_command+0x74>
40000d3c: 8b090108     	add	x8, x8, x9
40000d40: d1000508     	sub	x8, x8, #0x1
40000d44: d10083aa     	sub	x10, x29, #0x20
40000d48: 8b080268     	add	x8, x19, x8
40000d4c: 3829695f     	strb	wzr, [x10, x9]
40000d50: 38401509     	ldrb	w9, [x8], #0x1
40000d54: 7100813f     	cmp	w9, #0x20
40000d58: 54ffffc0     	b.eq	0x40000d50 <execute_command+0x84>
40000d5c: 35000069     	cbnz	w9, 0x40000d68 <execute_command+0x9c>
40000d60: aa1f03ec     	mov	x12, xzr
40000d64: 1400000a     	b	0x40000d8c <execute_command+0xc0>
40000d68: aa1f03ea     	mov	x10, xzr
40000d6c: 910103eb     	add	x11, sp, #0x40
40000d70: 382a6969     	strb	w9, [x11, x10]
40000d74: 386a6909     	ldrb	w9, [x8, x10]
40000d78: 9100054c     	add	x12, x10, #0x1
40000d7c: 34000089     	cbz	w9, 0x40000d8c <execute_command+0xc0>
40000d80: f101f95f     	cmp	x10, #0x7e
40000d84: aa0c03ea     	mov	x10, x12
40000d88: 54ffff43     	b.lo	0x40000d70 <execute_command+0xa4>
40000d8c: 910103e8     	add	x8, sp, #0x40
40000d90: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000d94: 91215021     	add	x1, x1, #0x854
40000d98: d10083a0     	sub	x0, x29, #0x20
40000d9c: 382c691f     	strb	wzr, [x8, x12]
40000da0: 9400064c     	bl	0x400026d0 <kstrcmp>
40000da4: 34001400     	cbz	w0, 0x40001024 <execute_command+0x358>
40000da8: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000dac: 91264821     	add	x1, x1, #0x992
40000db0: d10083a0     	sub	x0, x29, #0x20
40000db4: 94000647     	bl	0x400026d0 <kstrcmp>
40000db8: 340013a0     	cbz	w0, 0x4000102c <execute_command+0x360>
40000dbc: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000dc0: 91065c21     	add	x1, x1, #0x197
40000dc4: d10083a0     	sub	x0, x29, #0x20
40000dc8: 94000642     	bl	0x400026d0 <kstrcmp>
40000dcc: 34001680     	cbz	w0, 0x4000109c <execute_command+0x3d0>
40000dd0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000dd4: 912f0021     	add	x1, x1, #0xbc0
40000dd8: d10083a0     	sub	x0, x29, #0x20
40000ddc: 9400063d     	bl	0x400026d0 <kstrcmp>
40000de0: 34001800     	cbz	w0, 0x400010e0 <execute_command+0x414>
40000de4: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000de8: 910d4c21     	add	x1, x1, #0x353
40000dec: d10083a0     	sub	x0, x29, #0x20
40000df0: 94000638     	bl	0x400026d0 <kstrcmp>
40000df4: 34001860     	cbz	w0, 0x40001100 <execute_command+0x434>
40000df8: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000dfc: 9123b021     	add	x1, x1, #0x8ec
40000e00: d10083a0     	sub	x0, x29, #0x20
40000e04: 94000633     	bl	0x400026d0 <kstrcmp>
40000e08: 34001900     	cbz	w0, 0x40001128 <execute_command+0x45c>
40000e0c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e10: 9130d421     	add	x1, x1, #0xc35
40000e14: d10083a0     	sub	x0, x29, #0x20
40000e18: 9400062e     	bl	0x400026d0 <kstrcmp>
40000e1c: 34001960     	cbz	w0, 0x40001148 <execute_command+0x47c>
40000e20: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000e24: 91045021     	add	x1, x1, #0x114
40000e28: d10083a0     	sub	x0, x29, #0x20
40000e2c: 94000629     	bl	0x400026d0 <kstrcmp>
40000e30: 34001880     	cbz	w0, 0x40001140 <execute_command+0x474>
40000e34: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e38: 91246421     	add	x1, x1, #0x919
40000e3c: d10083a0     	sub	x0, x29, #0x20
40000e40: 94000624     	bl	0x400026d0 <kstrcmp>
40000e44: 340017e0     	cbz	w0, 0x40001140 <execute_command+0x474>
40000e48: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e4c: 912c1421     	add	x1, x1, #0xb05
40000e50: d10083a0     	sub	x0, x29, #0x20
40000e54: 9400061f     	bl	0x400026d0 <kstrcmp>
40000e58: 34001960     	cbz	w0, 0x40001184 <execute_command+0x4b8>
40000e5c: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e60: 91165821     	add	x1, x1, #0x596
40000e64: d10083a0     	sub	x0, x29, #0x20
40000e68: 9400061a     	bl	0x400026d0 <kstrcmp>
40000e6c: 34001900     	cbz	w0, 0x4000118c <execute_command+0x4c0>
40000e70: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000e74: 910e5c21     	add	x1, x1, #0x397
40000e78: d10083a0     	sub	x0, x29, #0x20
40000e7c: 94000615     	bl	0x400026d0 <kstrcmp>
40000e80: 34001aa0     	cbz	w0, 0x400011d4 <execute_command+0x508>
40000e84: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e88: 91131421     	add	x1, x1, #0x4c5
40000e8c: d10083a0     	sub	x0, x29, #0x20
40000e90: 94000610     	bl	0x400026d0 <kstrcmp>
40000e94: 34001b80     	cbz	w0, 0x40001204 <execute_command+0x538>
40000e98: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e9c: 911d9421     	add	x1, x1, #0x765
40000ea0: d10083a0     	sub	x0, x29, #0x20
40000ea4: 9400060b     	bl	0x400026d0 <kstrcmp>
40000ea8: 34001dc0     	cbz	w0, 0x40001260 <execute_command+0x594>
40000eac: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000eb0: 91301021     	add	x1, x1, #0xc04
40000eb4: d10083a0     	sub	x0, x29, #0x20
40000eb8: 94000606     	bl	0x400026d0 <kstrcmp>
40000ebc: 340020e0     	cbz	w0, 0x400012d8 <execute_command+0x60c>
40000ec0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000ec4: 911db021     	add	x1, x1, #0x76c
40000ec8: d10083a0     	sub	x0, x29, #0x20
40000ecc: 94000601     	bl	0x400026d0 <kstrcmp>
40000ed0: 34001e20     	cbz	w0, 0x40001294 <execute_command+0x5c8>
40000ed4: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000ed8: 9137b821     	add	x1, x1, #0xdee
40000edc: d10083a0     	sub	x0, x29, #0x20
40000ee0: 940005fc     	bl	0x400026d0 <kstrcmp>
40000ee4: 34001d80     	cbz	w0, 0x40001294 <execute_command+0x5c8>
40000ee8: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000eec: 9102c421     	add	x1, x1, #0xb1
40000ef0: d10083a0     	sub	x0, x29, #0x20
40000ef4: 940005f7     	bl	0x400026d0 <kstrcmp>
40000ef8: 340021a0     	cbz	w0, 0x4000132c <execute_command+0x660>
40000efc: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f00: 910d5821     	add	x1, x1, #0x356
40000f04: d10083a0     	sub	x0, x29, #0x20
40000f08: 940005f2     	bl	0x400026d0 <kstrcmp>
40000f0c: 34002260     	cbz	w0, 0x40001358 <execute_command+0x68c>
40000f10: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f14: 910d6821     	add	x1, x1, #0x35a
40000f18: d10083a0     	sub	x0, x29, #0x20
40000f1c: 940005ed     	bl	0x400026d0 <kstrcmp>
40000f20: 34002340     	cbz	w0, 0x40001388 <execute_command+0x6bc>
40000f24: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f28: 91196c21     	add	x1, x1, #0x65b
40000f2c: d10083a0     	sub	x0, x29, #0x20
40000f30: 940005e8     	bl	0x400026d0 <kstrcmp>
40000f34: 340023e0     	cbz	w0, 0x400013b0 <execute_command+0x6e4>
40000f38: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f3c: 911fc021     	add	x1, x1, #0x7f0
40000f40: d10083a0     	sub	x0, x29, #0x20
40000f44: 940005e3     	bl	0x400026d0 <kstrcmp>
40000f48: 34002520     	cbz	w0, 0x400013ec <execute_command+0x720>
40000f4c: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f50: 9108f421     	add	x1, x1, #0x23d
40000f54: d10083a0     	sub	x0, x29, #0x20
40000f58: 940005de     	bl	0x400026d0 <kstrcmp>
40000f5c: 34002720     	cbz	w0, 0x40001440 <execute_command+0x774>
40000f60: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f64: 910d8021     	add	x1, x1, #0x360
40000f68: d10083a0     	sub	x0, x29, #0x20
40000f6c: 940005d9     	bl	0x400026d0 <kstrcmp>
40000f70: 34002600     	cbz	w0, 0x40001430 <execute_command+0x764>
40000f74: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f78: 911fd821     	add	x1, x1, #0x7f6
40000f7c: d10083a0     	sub	x0, x29, #0x20
40000f80: 940005d4     	bl	0x400026d0 <kstrcmp>
40000f84: 34002560     	cbz	w0, 0x40001430 <execute_command+0x764>
40000f88: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f8c: 91198421     	add	x1, x1, #0x661
40000f90: d10083a0     	sub	x0, x29, #0x20
40000f94: 940005cf     	bl	0x400026d0 <kstrcmp>
40000f98: 34002aa0     	cbz	w0, 0x400014ec <execute_command+0x820>
40000f9c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000fa0: 91068821     	add	x1, x1, #0x1a2
40000fa4: d10083a0     	sub	x0, x29, #0x20
40000fa8: 940005ca     	bl	0x400026d0 <kstrcmp>
40000fac: 34002a00     	cbz	w0, 0x400014ec <execute_command+0x820>
40000fb0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000fb4: 910aa421     	add	x1, x1, #0x2a9
40000fb8: d10083a0     	sub	x0, x29, #0x20
40000fbc: 940005c5     	bl	0x400026d0 <kstrcmp>
40000fc0: 34002aa0     	cbz	w0, 0x40001514 <execute_command+0x848>
40000fc4: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000fc8: 91288021     	add	x1, x1, #0xa20
40000fcc: d10083a0     	sub	x0, x29, #0x20
40000fd0: 940005c0     	bl	0x400026d0 <kstrcmp>
40000fd4: 34003080     	cbz	w0, 0x400015e4 <execute_command+0x918>
40000fd8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000fdc: 91127821     	add	x1, x1, #0x49e
40000fe0: d10083a0     	sub	x0, x29, #0x20
40000fe4: 940005bb     	bl	0x400026d0 <kstrcmp>
40000fe8: 34002ee0     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40000fec: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000ff0: 91049c21     	add	x1, x1, #0x127
40000ff4: d10083a0     	sub	x0, x29, #0x20
40000ff8: 940005b6     	bl	0x400026d0 <kstrcmp>
40000ffc: 34002e40     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40001000: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001004: 91307421     	add	x1, x1, #0xc1d
40001008: d10083a0     	sub	x0, x29, #0x20
4000100c: 940005b1     	bl	0x400026d0 <kstrcmp>
40001010: 34002da0     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40001014: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001018: 9104b000     	add	x0, x0, #0x12c
4000101c: d10083a1     	sub	x1, x29, #0x20
40001020: 140000b4     	b	0x400012f0 <execute_command+0x624>
40001024: 97fffec4     	bl	0x40000b34 <print_help>
40001028: 1400002f     	b	0x400010e4 <execute_command+0x418>
4000102c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001030: 910acc00     	add	x0, x0, #0x2b3
40001034: 94000920     	bl	0x400034b4 <uart_puts>
40001038: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000103c: 91159000     	add	x0, x0, #0x564
40001040: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001044: 91367c21     	add	x1, x1, #0xd9f
40001048: 94000a2b     	bl	0x400038f4 <uart_printf>
4000104c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001050: 91279400     	add	x0, x0, #0x9e5
40001054: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001058: 91182421     	add	x1, x1, #0x609
4000105c: 94000a26     	bl	0x400038f4 <uart_printf>
40001060: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001064: 910d0400     	add	x0, x0, #0x341
40001068: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000106c: 91363821     	add	x1, x1, #0xd8e
40001070: 94000a21     	bl	0x400038f4 <uart_printf>
40001074: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001078: 913dbc00     	add	x0, x0, #0xf6f
4000107c: 9400090e     	bl	0x400034b4 <uart_puts>
40001080: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001084: 91213400     	add	x0, x0, #0x84d
40001088: 9400090b     	bl	0x400034b4 <uart_puts>
4000108c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001090: 9119bc00     	add	x0, x0, #0x66f
40001094: 94000908     	bl	0x400034b4 <uart_puts>
40001098: 14000013     	b	0x400010e4 <execute_command+0x418>
4000109c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400010a0: 9137ec00     	add	x0, x0, #0xdfb
400010a4: 94000904     	bl	0x400034b4 <uart_puts>
400010a8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400010ac: 910c2000     	add	x0, x0, #0x308
400010b0: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400010b4: 91182421     	add	x1, x1, #0x609
400010b8: 94000a0f     	bl	0x400038f4 <uart_printf>
400010bc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400010c0: 912ee400     	add	x0, x0, #0xbb9
400010c4: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400010c8: 91363821     	add	x1, x1, #0xd8e
400010cc: 94000a0a     	bl	0x400038f4 <uart_printf>
400010d0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400010d4: 91067000     	add	x0, x0, #0x19c
400010d8: 940008f7     	bl	0x400034b4 <uart_puts>
400010dc: 14000002     	b	0x400010e4 <execute_command+0x418>
400010e0: 97fffdf7     	bl	0x400008bc <print_sysinfo>
400010e4: a9524ff4     	ldp	x20, x19, [sp, #0x120]
400010e8: f9407bfc     	ldr	x28, [sp, #0xf0]
400010ec: a95157f6     	ldp	x22, x21, [sp, #0x110]
400010f0: a9505ff8     	ldp	x24, x23, [sp, #0x100]
400010f4: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
400010f8: 9104c3ff     	add	sp, sp, #0x130
400010fc: d65f03c0     	ret
40001100: 910103e0     	add	x0, sp, #0x40
40001104: 94000563     	bl	0x40002690 <kstrlen>
40001108: b4000260     	cbz	x0, 0x40001154 <execute_command+0x488>
4000110c: 910103e0     	add	x0, sp, #0x40
40001110: 94000f35     	bl	0x40004de4 <vfs_remove>
40001114: 34000280     	cbz	w0, 0x40001164 <execute_command+0x498>
40001118: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000111c: 9103e800     	add	x0, x0, #0xfa
40001120: 940008e5     	bl	0x400034b4 <uart_puts>
40001124: 17fffff0     	b	0x400010e4 <execute_command+0x418>
40001128: 910103e0     	add	x0, sp, #0x40
4000112c: 94000559     	bl	0x40002690 <kstrlen>
40001130: b4000220     	cbz	x0, 0x40001174 <execute_command+0x4a8>
40001134: 910103e0     	add	x0, sp, #0x40
40001138: 97fffc19     	bl	0x4000019c <launch_kedit>
4000113c: 17ffffea     	b	0x400010e4 <execute_command+0x418>
40001140: 94000607     	bl	0x4000295c <tui_launch>
40001144: 17ffffe8     	b	0x400010e4 <execute_command+0x418>
40001148: 910103e0     	add	x0, sp, #0x40
4000114c: 940001f1     	bl	0x40001910 <kproj_execute>
40001150: 17ffffe5     	b	0x400010e4 <execute_command+0x418>
40001154: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001158: 911a4000     	add	x0, x0, #0x690
4000115c: 940008d6     	bl	0x400034b4 <uart_puts>
40001160: 17ffffe1     	b	0x400010e4 <execute_command+0x418>
40001164: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001168: 91285800     	add	x0, x0, #0xa16
4000116c: 940008d2     	bl	0x400034b4 <uart_puts>
40001170: 17ffffdd     	b	0x400010e4 <execute_command+0x418>
40001174: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001178: 9135a800     	add	x0, x0, #0xd6a
4000117c: 940008ce     	bl	0x400034b4 <uart_puts>
40001180: 17ffffd9     	b	0x400010e4 <execute_command+0x418>
40001184: 94000324     	bl	0x40001e14 <launch_ktop>
40001188: 17ffffd7     	b	0x400010e4 <execute_command+0x418>
4000118c: 910103e0     	add	x0, sp, #0x40
40001190: 94000540     	bl	0x40002690 <kstrlen>
40001194: b40004c0     	cbz	x0, 0x4000122c <execute_command+0x560>
40001198: 394103e8     	ldrb	w8, [sp, #0x40]
4000119c: 5100c109     	sub	w9, w8, #0x30
400011a0: 7100253f     	cmp	w9, #0x9
400011a4: 540004c8     	b.hi	0x4000123c <execute_command+0x570>
400011a8: 910103e9     	add	x9, sp, #0x40
400011ac: 2a1f03f3     	mov	w19, wzr
400011b0: 5280014a     	mov	w10, #0xa               // =10
400011b4: b2400129     	orr	x9, x9, #0x1
400011b8: 1b0a226b     	madd	w11, w19, w10, w8
400011bc: 38401528     	ldrb	w8, [x9], #0x1
400011c0: 5100c10c     	sub	w12, w8, #0x30
400011c4: 7100299f     	cmp	w12, #0xa
400011c8: 5100c173     	sub	w19, w11, #0x30
400011cc: 54ffff63     	b.lo	0x400011b8 <execute_command+0x4ec>
400011d0: 1400001c     	b	0x40001240 <execute_command+0x574>
400011d4: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400011d8: 9123c821     	add	x1, x1, #0x8f2
400011dc: aa1303e0     	mov	x0, x19
400011e0: 940005a6     	bl	0x40002878 <kstrstr>
400011e4: b4000460     	cbz	x0, 0x40001270 <execute_command+0x5a4>
400011e8: 3900001f     	strb	wzr, [x0]
400011ec: 38401c08     	ldrb	w8, [x0, #0x1]!
400011f0: 7100811f     	cmp	w8, #0x20
400011f4: 54ffffc0     	b.eq	0x400011ec <execute_command+0x520>
400011f8: 91001661     	add	x1, x19, #0x5
400011fc: 94000ef9     	bl	0x40004de0 <vfs_write_file>
40001200: 17ffffb9     	b	0x400010e4 <execute_command+0x418>
40001204: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001208: 91067c21     	add	x1, x1, #0x19f
4000120c: 910103e0     	add	x0, sp, #0x40
40001210: 94000530     	bl	0x400026d0 <kstrcmp>
40001214: 34000720     	cbz	w0, 0x400012f8 <execute_command+0x62c>
40001218: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000121c: 911b3400     	add	x0, x0, #0x6cd
40001220: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001224: 91367c21     	add	x1, x1, #0xd9f
40001228: 14000032     	b	0x400012f0 <execute_command+0x624>
4000122c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001230: 9111ec00     	add	x0, x0, #0x47b
40001234: 940008a0     	bl	0x400034b4 <uart_puts>
40001238: 17ffffab     	b	0x400010e4 <execute_command+0x418>
4000123c: 2a1f03f3     	mov	w19, wzr
40001240: 2a1303e0     	mov	w0, w19
40001244: 9400025f     	bl	0x40001bc0 <process_kill>
40001248: 3100041f     	cmn	w0, #0x1
4000124c: 540001a0     	b.eq	0x40001280 <execute_command+0x5b4>
40001250: 35fff4a0     	cbnz	w0, 0x400010e4 <execute_command+0x418>
40001254: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001258: 913a7000     	add	x0, x0, #0xe9c
4000125c: 1400000b     	b	0x40001288 <execute_command+0x5bc>
40001260: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001264: 913ac000     	add	x0, x0, #0xeb0
40001268: 94000893     	bl	0x400034b4 <uart_puts>
4000126c: 17ffff9e     	b	0x400010e4 <execute_command+0x418>
40001270: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001274: 911b3400     	add	x0, x0, #0x6cd
40001278: 910103e1     	add	x1, sp, #0x40
4000127c: 1400001d     	b	0x400012f0 <execute_command+0x624>
40001280: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001284: 911a9800     	add	x0, x0, #0x6a6
40001288: 2a1303e1     	mov	w1, w19
4000128c: 9400099a     	bl	0x400038f4 <uart_printf>
40001290: 17ffff95     	b	0x400010e4 <execute_command+0x418>
40001294: 94000d07     	bl	0x400046b0 <vfs_get_cwd>
40001298: aa0003f3     	mov	x19, x0
4000129c: 910103e0     	add	x0, sp, #0x40
400012a0: 940004fc     	bl	0x40002690 <kstrlen>
400012a4: b40003e0     	cbz	x0, 0x40001320 <execute_command+0x654>
400012a8: 910103e0     	add	x0, sp, #0x40
400012ac: 94000d52     	bl	0x400047f4 <vfs_find>
400012b0: b40004c0     	cbz	x0, 0x40001348 <execute_command+0x67c>
400012b4: b9402008     	ldr	w8, [x0, #0x20]
400012b8: 35000368     	cbnz	w8, 0x40001324 <execute_command+0x658>
400012bc: b9402801     	ldr	w1, [x0, #0x28]
400012c0: d0000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
400012c4: 91190d08     	add	x8, x8, #0x643
400012c8: aa0003e2     	mov	x2, x0
400012cc: aa0803e0     	mov	x0, x8
400012d0: 94000989     	bl	0x400038f4 <uart_printf>
400012d4: 17ffff84     	b	0x400010e4 <execute_command+0x418>
400012d8: 910003e0     	mov	x0, sp
400012dc: 52800801     	mov	w1, #0x40               // =64
400012e0: 94000cf7     	bl	0x400046bc <vfs_getcwd>
400012e4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400012e8: 911b3400     	add	x0, x0, #0x6cd
400012ec: 910003e1     	mov	x1, sp
400012f0: 94000981     	bl	0x400038f4 <uart_printf>
400012f4: 17ffff7c     	b	0x400010e4 <execute_command+0x418>
400012f8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400012fc: 911f0400     	add	x0, x0, #0x7c1
40001300: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001304: 91367c21     	add	x1, x1, #0xd9f
40001308: b0000022     	adrp	x2, 0x40006000 <__rodata_start>
4000130c: 91182442     	add	x2, x2, #0x609
40001310: d0000023     	adrp	x3, 0x40007000 <__rodata_start+0x1000>
40001314: 91363863     	add	x3, x3, #0xd8e
40001318: 94000977     	bl	0x400038f4 <uart_printf>
4000131c: 17ffff72     	b	0x400010e4 <execute_command+0x418>
40001320: aa1303e0     	mov	x0, x19
40001324: 94000ee9     	bl	0x40004ec8 <vfs_list_dir>
40001328: 17ffff6f     	b	0x400010e4 <execute_command+0x418>
4000132c: 910103e0     	add	x0, sp, #0x40
40001330: 94000d96     	bl	0x40004988 <vfs_chdir>
40001334: 34ffed80     	cbz	w0, 0x400010e4 <execute_command+0x418>
40001338: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000133c: 910a1400     	add	x0, x0, #0x285
40001340: 910103e1     	add	x1, sp, #0x40
40001344: 17ffffeb     	b	0x400012f0 <execute_command+0x624>
40001348: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000134c: 91123800     	add	x0, x0, #0x48e
40001350: 910103e1     	add	x1, sp, #0x40
40001354: 17ffffe7     	b	0x400012f0 <execute_command+0x624>
40001358: 910103e0     	add	x0, sp, #0x40
4000135c: 940004cd     	bl	0x40002690 <kstrlen>
40001360: b40003e0     	cbz	x0, 0x400013dc <execute_command+0x710>
40001364: 910103e0     	add	x0, sp, #0x40
40001368: 94000d23     	bl	0x400047f4 <vfs_find>
4000136c: b4000060     	cbz	x0, 0x40001378 <execute_command+0x6ac>
40001370: b9402008     	ldr	w8, [x0, #0x20]
40001374: 34000a28     	cbz	w8, 0x400014b8 <execute_command+0x7ec>
40001378: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000137c: 910d6800     	add	x0, x0, #0x35a
40001380: 9400084d     	bl	0x400034b4 <uart_puts>
40001384: 17ffff58     	b	0x400010e4 <execute_command+0x418>
40001388: 910103e0     	add	x0, sp, #0x40
4000138c: 940004c1     	bl	0x40002690 <kstrlen>
40001390: b4000480     	cbz	x0, 0x40001420 <execute_command+0x754>
40001394: 910103e0     	add	x0, sp, #0x40
40001398: 94000da1     	bl	0x40004a1c <vfs_mkdir>
4000139c: 34ffea40     	cbz	w0, 0x400010e4 <execute_command+0x418>
400013a0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400013a4: 913b6400     	add	x0, x0, #0xed9
400013a8: 94000843     	bl	0x400034b4 <uart_puts>
400013ac: 17ffff4e     	b	0x400010e4 <execute_command+0x418>
400013b0: 910103e0     	add	x0, sp, #0x40
400013b4: 940004b7     	bl	0x40002690 <kstrlen>
400013b8: b40008a0     	cbz	x0, 0x400014cc <execute_command+0x800>
400013bc: 910103e0     	add	x0, sp, #0x40
400013c0: aa1f03e1     	mov	x1, xzr
400013c4: 94000dec     	bl	0x40004b74 <vfs_touch>
400013c8: 34ffe8e0     	cbz	w0, 0x400010e4 <execute_command+0x418>
400013cc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400013d0: 91046000     	add	x0, x0, #0x118
400013d4: 94000838     	bl	0x400034b4 <uart_puts>
400013d8: 17ffff43     	b	0x400010e4 <execute_command+0x418>
400013dc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400013e0: 91025400     	add	x0, x0, #0x95
400013e4: 94000834     	bl	0x400034b4 <uart_puts>
400013e8: 17ffff3f     	b	0x400010e4 <execute_command+0x418>
400013ec: 910103e0     	add	x0, sp, #0x40
400013f0: 52800401     	mov	w1, #0x20               // =32
400013f4: 9400053c     	bl	0x400028e4 <kstrchr>
400013f8: b4000720     	cbz	x0, 0x400014dc <execute_command+0x810>
400013fc: aa0003e1     	mov	x1, x0
40001400: 910103e0     	add	x0, sp, #0x40
40001404: 3800143f     	strb	wzr, [x1], #0x1
40001408: 94000e76     	bl	0x40004de0 <vfs_write_file>
4000140c: 34ffe6c0     	cbz	w0, 0x400010e4 <execute_command+0x418>
40001410: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001414: 91132c00     	add	x0, x0, #0x4cb
40001418: 94000827     	bl	0x400034b4 <uart_puts>
4000141c: 17ffff32     	b	0x400010e4 <execute_command+0x418>
40001420: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001424: 91132800     	add	x0, x0, #0x4ca
40001428: 94000823     	bl	0x400034b4 <uart_puts>
4000142c: 17ffff2e     	b	0x400010e4 <execute_command+0x418>
40001430: d503201f     	nop
40001434: 7002ede0     	adr	x0, 0x400071f3 <__rodata_start+0x11f3>
40001438: 9400081f     	bl	0x400034b4 <uart_puts>
4000143c: 17ffff2a     	b	0x400010e4 <execute_command+0x418>
40001440: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001444: 9119bc00     	add	x0, x0, #0x66f
40001448: 9400081b     	bl	0x400034b4 <uart_puts>
4000144c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001450: 9130ec00     	add	x0, x0, #0xc3b
40001454: 94000818     	bl	0x400034b4 <uart_puts>
40001458: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000145c: 91018800     	add	x0, x0, #0x62
40001460: 94000815     	bl	0x400034b4 <uart_puts>
40001464: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001468: 912f2000     	add	x0, x0, #0xbc8
4000146c: 94000812     	bl	0x400034b4 <uart_puts>
40001470: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001474: 91136800     	add	x0, x0, #0x4da
40001478: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000147c: 91363821     	add	x1, x1, #0xd8e
40001480: 9400091d     	bl	0x400038f4 <uart_printf>
40001484: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001488: 911dbc00     	add	x0, x0, #0x76f
4000148c: 9400080a     	bl	0x400034b4 <uart_puts>
40001490: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001494: 910e7000     	add	x0, x0, #0x39c
40001498: 94000807     	bl	0x400034b4 <uart_puts>
4000149c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400014a0: 91137c00     	add	x0, x0, #0x4df
400014a4: 94000804     	bl	0x400034b4 <uart_puts>
400014a8: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400014ac: 91248400     	add	x0, x0, #0x921
400014b0: 94000801     	bl	0x400034b4 <uart_puts>
400014b4: 17ffff0c     	b	0x400010e4 <execute_command+0x418>
400014b8: b0000028     	adrp	x8, 0x40006000 <__rodata_start>
400014bc: 911b3508     	add	x8, x8, #0x6cd
400014c0: 9100c001     	add	x1, x0, #0x30
400014c4: aa0803e0     	mov	x0, x8
400014c8: 17ffff8a     	b	0x400012f0 <execute_command+0x624>
400014cc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400014d0: 91302000     	add	x0, x0, #0xc08
400014d4: 940007f8     	bl	0x400034b4 <uart_puts>
400014d8: 17ffff03     	b	0x400010e4 <execute_command+0x418>
400014dc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400014e0: 91360c00     	add	x0, x0, #0xd83
400014e4: 940007f4     	bl	0x400034b4 <uart_puts>
400014e8: 17fffeff     	b	0x400010e4 <execute_command+0x418>
400014ec: 910103e0     	add	x0, sp, #0x40
400014f0: 94000468     	bl	0x40002690 <kstrlen>
400014f4: b4000080     	cbz	x0, 0x40001504 <execute_command+0x838>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 9400042d     	bl	0x400025b0 <script_run_file>
40001500: 17fffef9     	b	0x400010e4 <execute_command+0x418>
40001504: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001508: 9102b000     	add	x0, x0, #0xac
4000150c: 940007ea     	bl	0x400034b4 <uart_puts>
40001510: 17fffef5     	b	0x400010e4 <execute_command+0x418>
40001514: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001518: 9139d000     	add	x0, x0, #0xe74
4000151c: 940007e6     	bl	0x400034b4 <uart_puts>
40001520: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001524: b0000035     	adrp	x21, 0x40006000 <__rodata_start>
40001528: 9113e6b5     	add	x21, x21, #0x4f9
4000152c: 39400113     	ldrb	w19, [x8]
40001530: d344fe68     	lsr	x8, x19, #4
40001534: 38686aa0     	ldrb	w0, [x21, x8]
40001538: 940007c8     	bl	0x40003458 <uart_putc>
4000153c: 92400e68     	and	x8, x19, #0xf
40001540: 38686aa0     	ldrb	w0, [x21, x8]
40001544: 940007c5     	bl	0x40003458 <uart_putc>
40001548: 52800400     	mov	w0, #0x20               // =32
4000154c: 940007c3     	bl	0x40003458 <uart_putc>
40001550: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
40001554: 910dbe73     	add	x19, x19, #0x36f
40001558: d0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
4000155c: 9119be94     	add	x20, x20, #0x66f
40001560: 52800036     	mov	w22, #0x1               // =1
40001564: d503201f     	nop
40001568: 10ff54d7     	adr	x23, 0x40000000 <_start>
4000156c: 1400000d     	b	0x400015a0 <execute_command+0x8d4>
40001570: 38766af8     	ldrb	w24, [x23, x22]
40001574: d344ff08     	lsr	x8, x24, #4
40001578: 38686aa0     	ldrb	w0, [x21, x8]
4000157c: 940007b7     	bl	0x40003458 <uart_putc>
40001580: 92400f08     	and	x8, x24, #0xf
40001584: 38686aa0     	ldrb	w0, [x21, x8]
40001588: 940007b4     	bl	0x40003458 <uart_putc>
4000158c: 52800400     	mov	w0, #0x20               // =32
40001590: 940007b2     	bl	0x40003458 <uart_putc>
40001594: 910006d6     	add	x22, x22, #0x1
40001598: f10082df     	cmp	x22, #0x20
4000159c: 54ffd780     	b.eq	0x4000108c <execute_command+0x3c0>
400015a0: 72000adf     	tst	w22, #0x7
400015a4: 54000061     	b.ne	0x400015b0 <execute_command+0x8e4>
400015a8: aa1303e0     	mov	x0, x19
400015ac: 940007c2     	bl	0x400034b4 <uart_puts>
400015b0: 72000edf     	tst	w22, #0xf
400015b4: 54fffde1     	b.ne	0x40001570 <execute_command+0x8a4>
400015b8: aa1403e0     	mov	x0, x20
400015bc: 940007be     	bl	0x400034b4 <uart_puts>
400015c0: 17ffffec     	b	0x40001570 <execute_command+0x8a4>
400015c4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400015c8: 91369800     	add	x0, x0, #0xda6
400015cc: 940007ba     	bl	0x400034b4 <uart_puts>
400015d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400015d4: 913ba000     	add	x0, x0, #0xee8
400015d8: 940007b7     	bl	0x400034b4 <uart_puts>
400015dc: d503207f     	wfi
400015e0: 17ffffff     	b	0x400015dc <execute_command+0x910>
400015e4: 97fffd08     	bl	0x40000a04 <print_android_roadmap>
400015e8: 17fffebf     	b	0x400010e4 <execute_command+0x418>

00000000400015ec <kernel_shell>:
400015ec: d10543ff     	sub	sp, sp, #0x150
400015f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400015f4: 91250800     	add	x0, x0, #0x942
400015f8: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
400015fc: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001600: 9103c3fd     	add	x29, sp, #0xf0
40001604: a91167fa     	stp	x26, x25, [sp, #0x110]
40001608: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000160c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001610: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001614: 940007a8     	bl	0x400034b4 <uart_puts>
40001618: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
4000161c: 913a6273     	add	x19, x19, #0xe98
40001620: d0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40001624: 9102d294     	add	x20, x20, #0xb4
40001628: f0000035     	adrp	x21, 0x40008000 <__rodata_start+0x2000>
4000162c: 9110beb5     	add	x21, x21, #0x42f
40001630: d0000036     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
40001634: 9101aed6     	add	x22, x22, #0x6b
40001638: f0000037     	adrp	x23, 0x40008000 <__rodata_start+0x2000>
4000163c: 91127af7     	add	x23, x23, #0x49e
40001640: f0000038     	adrp	x24, 0x40008000 <__rodata_start+0x2000>
40001644: 91049f18     	add	x24, x24, #0x127
40001648: 910123fa     	add	x26, sp, #0x48
4000164c: b0000039     	adrp	x25, 0x40006000 <__rodata_start>
40001650: 91307739     	add	x25, x25, #0xc1d
40001654: 910023e0     	add	x0, sp, #0x8
40001658: 52800801     	mov	w1, #0x40               // =64
4000165c: 94000c18     	bl	0x400046bc <vfs_getcwd>
40001660: 910023e1     	add	x1, sp, #0x8
40001664: aa1303e0     	mov	x0, x19
40001668: 940008a3     	bl	0x400038f4 <uart_printf>
4000166c: aa1403e0     	mov	x0, x20
40001670: 94000791     	bl	0x400034b4 <uart_puts>
40001674: aa1f03fc     	mov	x28, xzr
40001678: aa1c03fb     	mov	x27, x28
4000167c: 940007c1     	bl	0x40003580 <uart_getc>
40001680: 12001c08     	and	w8, w0, #0xff
40001684: 7100311f     	cmp	w8, #0xc
40001688: 540000cc     	b.gt	0x400016a0 <kernel_shell+0xb4>
4000168c: 7100211f     	cmp	w8, #0x8
40001690: 54000240     	b.eq	0x400016d8 <kernel_shell+0xec>
40001694: 7100291f     	cmp	w8, #0xa
40001698: 540000c1     	b.ne	0x400016b0 <kernel_shell+0xc4>
4000169c: 14000015     	b	0x400016f0 <kernel_shell+0x104>
400016a0: 7100351f     	cmp	w8, #0xd
400016a4: 54000260     	b.eq	0x400016f0 <kernel_shell+0x104>
400016a8: 7101fd1f     	cmp	w8, #0x7f
400016ac: 54000160     	b.eq	0x400016d8 <kernel_shell+0xec>
400016b0: 51008008     	sub	w8, w0, #0x20
400016b4: 12001d08     	and	w8, w8, #0xff
400016b8: 7101791f     	cmp	w8, #0x5e
400016bc: 54fffe08     	b.hi	0x4000167c <kernel_shell+0x90>
400016c0: f1027b7f     	cmp	x27, #0x9e
400016c4: 54fffdc8     	b.hi	0x4000167c <kernel_shell+0x90>
400016c8: 9100077c     	add	x28, x27, #0x1
400016cc: 383b6b40     	strb	w0, [x26, x27]
400016d0: 94000762     	bl	0x40003458 <uart_putc>
400016d4: 17ffffe9     	b	0x40001678 <kernel_shell+0x8c>
400016d8: aa1f03fc     	mov	x28, xzr
400016dc: b4fffcfb     	cbz	x27, 0x40001678 <kernel_shell+0x8c>
400016e0: aa1503e0     	mov	x0, x21
400016e4: d100077c     	sub	x28, x27, #0x1
400016e8: 94000773     	bl	0x400034b4 <uart_puts>
400016ec: 17ffffe3     	b	0x40001678 <kernel_shell+0x8c>
400016f0: aa1603e0     	mov	x0, x22
400016f4: 94000770     	bl	0x400034b4 <uart_puts>
400016f8: 910123e0     	add	x0, sp, #0x48
400016fc: 383b6b5f     	strb	wzr, [x26, x27]
40001700: 940003e4     	bl	0x40002690 <kstrlen>
40001704: b4fffa80     	cbz	x0, 0x40001654 <kernel_shell+0x68>
40001708: 910123e0     	add	x0, sp, #0x48
4000170c: 940002e4     	bl	0x4000229c <script_execute_line>
40001710: 910123e0     	add	x0, sp, #0x48
40001714: aa1703e1     	mov	x1, x23
40001718: 940003ee     	bl	0x400026d0 <kstrcmp>
4000171c: 34000120     	cbz	w0, 0x40001740 <kernel_shell+0x154>
40001720: 910123e0     	add	x0, sp, #0x48
40001724: aa1803e1     	mov	x1, x24
40001728: 940003ea     	bl	0x400026d0 <kstrcmp>
4000172c: 340000a0     	cbz	w0, 0x40001740 <kernel_shell+0x154>
40001730: 910123e0     	add	x0, sp, #0x48
40001734: aa1903e1     	mov	x1, x25
40001738: 940003e6     	bl	0x400026d0 <kstrcmp>
4000173c: 35fff8c0     	cbnz	w0, 0x40001654 <kernel_shell+0x68>
40001740: a9544ff4     	ldp	x20, x19, [sp, #0x140]
40001744: a95357f6     	ldp	x22, x21, [sp, #0x130]
40001748: a9525ff8     	ldp	x24, x23, [sp, #0x120]
4000174c: a95167fa     	ldp	x26, x25, [sp, #0x110]
40001750: a9506ffc     	ldp	x28, x27, [sp, #0x100]
40001754: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
40001758: 910543ff     	add	sp, sp, #0x150
4000175c: d65f03c0     	ret

0000000040001760 <kmain>:
40001760: d100c3ff     	sub	sp, sp, #0x30
40001764: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001768: 529c6c13     	mov	w19, #0xe360            // =58208
4000176c: a9017bfd     	stp	x29, x30, [sp, #0x10]
40001770: 910043fd     	add	x29, sp, #0x10
40001774: 72a002d3     	movk	w19, #0x16, lsl #16
40001778: 9400072c     	bl	0x40003428 <uart_init>
4000177c: d503201f     	nop
40001780: 7002d380     	adr	x0, 0x400071f3 <__rodata_start+0x11f3>
40001784: 9400074c     	bl	0x400034b4 <uart_puts>
40001788: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000178c: 91166c00     	add	x0, x0, #0x59b
40001790: 94000749     	bl	0x400034b4 <uart_puts>
40001794: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001798: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000179c: 6b13011f     	cmp	w8, w19
400017a0: 540000aa     	b.ge	0x400017b4 <kmain+0x54>
400017a4: b85fc3a8     	ldur	w8, [x29, #-0x4]
400017a8: 11000508     	add	w8, w8, #0x1
400017ac: b81fc3a8     	stur	w8, [x29, #-0x4]
400017b0: 17fffffa     	b	0x40001798 <kmain+0x38>
400017b4: 528aa213     	mov	w19, #0x5510            // =21776
400017b8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400017bc: 910dc400     	add	x0, x0, #0x371
400017c0: 72a00453     	movk	w19, #0x22, lsl #16
400017c4: 9400073c     	bl	0x400034b4 <uart_puts>
400017c8: b81fc3bf     	stur	wzr, [x29, #-0x4]
400017cc: b85fc3a8     	ldur	w8, [x29, #-0x4]
400017d0: 6b13011f     	cmp	w8, w19
400017d4: 540000aa     	b.ge	0x400017e8 <kmain+0x88>
400017d8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400017dc: 11000508     	add	w8, w8, #0x1
400017e0: b81fc3a8     	stur	w8, [x29, #-0x4]
400017e4: 17fffffa     	b	0x400017cc <kmain+0x6c>
400017e8: 5298d814     	mov	w20, #0xc6c0            // =50880
400017ec: 72a005b4     	movk	w20, #0x2d, lsl #16
400017f0: 94000a45     	bl	0x40004104 <vfs_init>
400017f4: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400017f8: 911e7400     	add	x0, x0, #0x79d
400017fc: 9400072e     	bl	0x400034b4 <uart_puts>
40001800: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001804: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001808: 6b14011f     	cmp	w8, w20
4000180c: 540000aa     	b.ge	0x40001820 <kmain+0xc0>
40001810: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001814: 11000508     	add	w8, w8, #0x1
40001818: b81fc3a8     	stur	w8, [x29, #-0x4]
4000181c: 17fffffa     	b	0x40001804 <kmain+0xa4>
40001820: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001824: 91090c00     	add	x0, x0, #0x243
40001828: d503201f     	nop
4000182c: 1001bea8     	adr	x8, 0x40005000 <exception_vector_table>
40001830: d518c008     	msr	VBAR_EL1, x8
40001834: 94000720     	bl	0x400034b4 <uart_puts>
40001838: b81fc3bf     	stur	wzr, [x29, #-0x4]
4000183c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001840: 6b13011f     	cmp	w8, w19
40001844: 540000aa     	b.ge	0x40001858 <kmain+0xf8>
40001848: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000184c: 11000508     	add	w8, w8, #0x1
40001850: b81fc3a8     	stur	w8, [x29, #-0x4]
40001854: 17fffffa     	b	0x4000183c <kmain+0xdc>
40001858: 94000080     	bl	0x40001a58 <process_init>
4000185c: 940001c6     	bl	0x40001f74 <script_init>
40001860: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001864: 91023000     	add	x0, x0, #0x8c
40001868: 94000713     	bl	0x400034b4 <uart_puts>
4000186c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001870: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001874: 6b13011f     	cmp	w8, w19
40001878: 540000aa     	b.ge	0x4000188c <kmain+0x12c>
4000187c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001880: 11000508     	add	w8, w8, #0x1
40001884: b81fc3a8     	stur	w8, [x29, #-0x4]
40001888: 17fffffa     	b	0x40001870 <kmain+0x110>
4000188c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001890: 5291b008     	mov	w8, #0x8d80             // =36224
40001894: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001898: 72a00b68     	movk	w8, #0x5b, lsl #16
4000189c: 6b08013f     	cmp	w9, w8
400018a0: 540000ea     	b.ge	0x400018bc <kmain+0x15c>
400018a4: b85fc3a9     	ldur	w9, [x29, #-0x4]
400018a8: 11000529     	add	w9, w9, #0x1
400018ac: b81fc3a9     	stur	w9, [x29, #-0x4]
400018b0: b85fc3a9     	ldur	w9, [x29, #-0x4]
400018b4: 6b08013f     	cmp	w9, w8
400018b8: 54ffff6b     	b.lt	0x400018a4 <kmain+0x144>
400018bc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400018c0: 91266000     	add	x0, x0, #0x998
400018c4: 940006fc     	bl	0x400034b4 <uart_puts>
400018c8: 94001060     	bl	0x40005a48 <trigger_undefined_instruction>
400018cc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400018d0: 9127f800     	add	x0, x0, #0x9fe
400018d4: 940006f8     	bl	0x400034b4 <uart_puts>
400018d8: 97fffbb0     	bl	0x40000798 <print_banner>
400018dc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400018e0: 9123d000     	add	x0, x0, #0x8f4
400018e4: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400018e8: 91367c21     	add	x1, x1, #0xd9f
400018ec: 94000802     	bl	0x400038f4 <uart_printf>
400018f0: 97fffbf3     	bl	0x400008bc <print_sysinfo>
400018f4: 97ffff3e     	bl	0x400015ec <kernel_shell>
400018f8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
400018fc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001900: 913ba000     	add	x0, x0, #0xee8
40001904: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001908: 9100c3ff     	add	sp, sp, #0x30
4000190c: 140006ea     	b	0x400034b4 <uart_puts>

0000000040001910 <kproj_execute>:
40001910: d10683ff     	sub	sp, sp, #0x1a0
40001914: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001918: 910603fd     	add	x29, sp, #0x180
4000191c: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001920: b40001c0     	cbz	x0, 0x40001958 <kproj_execute+0x48>
40001924: aa0003f3     	mov	x19, x0
40001928: 9400035a     	bl	0x40002690 <kstrlen>
4000192c: b4000160     	cbz	x0, 0x40001958 <kproj_execute+0x48>
40001930: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001934: 91291c00     	add	x0, x0, #0xa47
40001938: aa1303e1     	mov	x1, x19
4000193c: 940007ee     	bl	0x400038f4 <uart_printf>
40001940: aa1303e0     	mov	x0, x19
40001944: 94000c36     	bl	0x40004a1c <vfs_mkdir>
40001948: 34000140     	cbz	w0, 0x40001970 <kproj_execute+0x60>
4000194c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001950: 91128c00     	add	x0, x0, #0x4a3
40001954: 14000003     	b	0x40001960 <kproj_execute+0x50>
40001958: d503201f     	nop
4000195c: 10033f80     	adr	x0, 0x4000814c <__rodata_start+0x214c>
40001960: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001964: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001968: 910683ff     	add	sp, sp, #0x1a0
4000196c: 140006d2     	b	0x400034b4 <uart_puts>
40001970: aa1303e0     	mov	x0, x19
40001974: 94000c05     	bl	0x40004988 <vfs_chdir>
40001978: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000197c: 91034400     	add	x0, x0, #0xd1
40001980: 94000c27     	bl	0x40004a1c <vfs_mkdir>
40001984: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001988: 91199000     	add	x0, x0, #0x664
4000198c: 94000c24     	bl	0x40004a1c <vfs_mkdir>
40001990: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001994: 910a4021     	add	x1, x1, #0x290
40001998: 910203e0     	add	x0, sp, #0x80
4000199c: 9400036c     	bl	0x4000274c <kstrcpy>
400019a0: 910203e0     	add	x0, sp, #0x80
400019a4: aa1303e1     	mov	x1, x19
400019a8: 94000341     	bl	0x400026ac <kstrcat>
400019ac: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400019b0: 913c1021     	add	x1, x1, #0xf04
400019b4: 910203e0     	add	x0, sp, #0x80
400019b8: 9400033d     	bl	0x400026ac <kstrcat>
400019bc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400019c0: 91247400     	add	x0, x0, #0x91d
400019c4: 910203e1     	add	x1, sp, #0x80
400019c8: 94000c6b     	bl	0x40004b74 <vfs_touch>
400019cc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400019d0: 913c3800     	add	x0, x0, #0xf0e
400019d4: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400019d8: 91308821     	add	x1, x1, #0xc22
400019dc: 94000c66     	bl	0x40004b74 <vfs_touch>
400019e0: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400019e4: 91069821     	add	x1, x1, #0x1a6
400019e8: 910003e0     	mov	x0, sp
400019ec: 94000358     	bl	0x4000274c <kstrcpy>
400019f0: 910003e0     	mov	x0, sp
400019f4: aa1303e1     	mov	x1, x19
400019f8: 9400032d     	bl	0x400026ac <kstrcat>
400019fc: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001a00: 912c2821     	add	x1, x1, #0xb0a
40001a04: 910003e0     	mov	x0, sp
40001a08: 94000329     	bl	0x400026ac <kstrcat>
40001a0c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001a10: 913cc000     	add	x0, x0, #0xf30
40001a14: 910003e1     	mov	x1, sp
40001a18: 94000c57     	bl	0x40004b74 <vfs_touch>
40001a1c: 94000c55     	bl	0x40004b70 <vfs_sync>
40001a20: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001a24: 91142800     	add	x0, x0, #0x50a
40001a28: 940006a3     	bl	0x400034b4 <uart_puts>
40001a2c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001a30: 9114e400     	add	x0, x0, #0x539
40001a34: aa1303e1     	mov	x1, x19
40001a38: 940007af     	bl	0x400038f4 <uart_printf>
40001a3c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001a40: 91035400     	add	x0, x0, #0xd5
40001a44: 94000bd1     	bl	0x40004988 <vfs_chdir>
40001a48: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001a4c: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001a50: 910683ff     	add	sp, sp, #0x1a0
40001a54: d65f03c0     	ret

0000000040001a58 <process_init>:
40001a58: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40001a5c: a9014ff4     	stp	x20, x19, [sp, #0x10]
40001a60: 90000054     	adrp	x20, 0x40009000 <next_pid>
40001a64: d503201f     	nop
40001a68: 1005bf73     	adr	x19, 0x4000d254 <proc_table>
40001a6c: b9400289     	ldr	w9, [x20]
40001a70: 52800068     	mov	w8, #0x3                // =3
40001a74: b9002668     	str	w8, [x19, #0x24]
40001a78: d503201f     	nop
40001a7c: 3002eee1     	adr	x1, 0x40007859 <__rodata_start+0x1859>
40001a80: b9005668     	str	w8, [x19, #0x54]
40001a84: 91001260     	add	x0, x19, #0x4
40001a88: 910003fd     	mov	x29, sp
40001a8c: b9008668     	str	w8, [x19, #0x84]
40001a90: b900b668     	str	w8, [x19, #0xb4]
40001a94: b900e668     	str	w8, [x19, #0xe4]
40001a98: b9011668     	str	w8, [x19, #0x114]
40001a9c: b9014668     	str	w8, [x19, #0x144]
40001aa0: b9017668     	str	w8, [x19, #0x174]
40001aa4: b901a668     	str	w8, [x19, #0x1a4]
40001aa8: b901d668     	str	w8, [x19, #0x1d4]
40001aac: b9020668     	str	w8, [x19, #0x204]
40001ab0: b9023668     	str	w8, [x19, #0x234]
40001ab4: b9026668     	str	w8, [x19, #0x264]
40001ab8: b9029668     	str	w8, [x19, #0x294]
40001abc: b902c668     	str	w8, [x19, #0x2c4]
40001ac0: b902f668     	str	w8, [x19, #0x2f4]
40001ac4: 11000528     	add	w8, w9, #0x1
40001ac8: b900327f     	str	wzr, [x19, #0x30]
40001acc: b900627f     	str	wzr, [x19, #0x60]
40001ad0: b900927f     	str	wzr, [x19, #0x90]
40001ad4: b900c27f     	str	wzr, [x19, #0xc0]
40001ad8: b900f27f     	str	wzr, [x19, #0xf0]
40001adc: b901227f     	str	wzr, [x19, #0x120]
40001ae0: b901527f     	str	wzr, [x19, #0x150]
40001ae4: b901827f     	str	wzr, [x19, #0x180]
40001ae8: b901b27f     	str	wzr, [x19, #0x1b0]
40001aec: b901e27f     	str	wzr, [x19, #0x1e0]
40001af0: b902127f     	str	wzr, [x19, #0x210]
40001af4: b902427f     	str	wzr, [x19, #0x240]
40001af8: b902727f     	str	wzr, [x19, #0x270]
40001afc: b902a27f     	str	wzr, [x19, #0x2a0]
40001b00: b902d27f     	str	wzr, [x19, #0x2d0]
40001b04: b9000288     	str	w8, [x20]
40001b08: b9000269     	str	w9, [x19]
40001b0c: 94000310     	bl	0x4000274c <kstrcpy>
40001b10: b9400288     	ldr	w8, [x20]
40001b14: d2e00209     	mov	x9, #0x10000000000000   // =4503599627370496
40001b18: 5280384a     	mov	w10, #0x1c2             // =450
40001b1c: f8024269     	stur	x9, [x19, #0x24]
40001b20: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001b24: 91137021     	add	x1, x1, #0x4dc
40001b28: 11000509     	add	w9, w8, #0x1
40001b2c: 9100d260     	add	x0, x19, #0x34
40001b30: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001b34: b9000289     	str	w9, [x20]
40001b38: 94000305     	bl	0x4000274c <kstrcpy>
40001b3c: d2800029     	mov	x9, #0x1                // =1
40001b40: b9400288     	ldr	w8, [x20]
40001b44: 5280018a     	mov	w10, #0xc               // =12
40001b48: f2dd0009     	movk	x9, #0xe800, lsl #32
40001b4c: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001b50: 912cb021     	add	x1, x1, #0xb2c
40001b54: f2e00069     	movk	x9, #0x3, lsl #48
40001b58: 91019260     	add	x0, x19, #0x64
40001b5c: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001b60: f8054269     	stur	x9, [x19, #0x54]
40001b64: 11000509     	add	w9, w8, #0x1
40001b68: b9000289     	str	w9, [x20]
40001b6c: 940002f8     	bl	0x4000274c <kstrcpy>
40001b70: b9400288     	ldr	w8, [x20]
40001b74: d2800029     	mov	x9, #0x1                // =1
40001b78: 5280960a     	mov	w10, #0x4b0             // =1200
40001b7c: f2e00809     	movk	x9, #0x40, lsl #48
40001b80: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001b84: 910d9821     	add	x1, x1, #0x366
40001b88: f8084269     	stur	x9, [x19, #0x84]
40001b8c: 11000509     	add	w9, w8, #0x1
40001b90: 91025260     	add	x0, x19, #0x94
40001b94: b9000289     	str	w9, [x20]
40001b98: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001b9c: 940002ec     	bl	0x4000274c <kstrcpy>
40001ba0: d2da0008     	mov	x8, #0xd00000000000     // =228698418577408
40001ba4: 52800aa9     	mov	w9, #0x55               // =85
40001ba8: f2e000e8     	movk	x8, #0x7, lsl #48
40001bac: b900be69     	str	w9, [x19, #0xbc]
40001bb0: f80b4268     	stur	x8, [x19, #0xb4]
40001bb4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40001bb8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40001bbc: d65f03c0     	ret

0000000040001bc0 <process_kill>:
40001bc0: 7100041f     	cmp	w0, #0x1
40001bc4: 5400118b     	b.lt	0x40001df4 <process_kill+0x234>
40001bc8: d503201f     	nop
40001bcc: 1005b449     	adr	x9, 0x4000d254 <proc_table>
40001bd0: b9400128     	ldr	w8, [x9]
40001bd4: 6b00011f     	cmp	w8, w0
40001bd8: 54000081     	b.ne	0x40001be8 <process_kill+0x28>
40001bdc: b9402528     	ldr	w8, [x9, #0x24]
40001be0: 71000d1f     	cmp	w8, #0x3
40001be4: 54000f41     	b.ne	0x40001dcc <process_kill+0x20c>
40001be8: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001bec: 910a1129     	add	x9, x9, #0x284
40001bf0: b9400128     	ldr	w8, [x9]
40001bf4: 6b00011f     	cmp	w8, w0
40001bf8: 54000081     	b.ne	0x40001c08 <process_kill+0x48>
40001bfc: b9402528     	ldr	w8, [x9, #0x24]
40001c00: 71000d1f     	cmp	w8, #0x3
40001c04: 54000e41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c08: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c0c: 910ad129     	add	x9, x9, #0x2b4
40001c10: b9400128     	ldr	w8, [x9]
40001c14: 6b00011f     	cmp	w8, w0
40001c18: 54000081     	b.ne	0x40001c28 <process_kill+0x68>
40001c1c: b9402528     	ldr	w8, [x9, #0x24]
40001c20: 71000d1f     	cmp	w8, #0x3
40001c24: 54000d41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c28: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c2c: 910b9129     	add	x9, x9, #0x2e4
40001c30: b9400128     	ldr	w8, [x9]
40001c34: 6b00011f     	cmp	w8, w0
40001c38: 54000081     	b.ne	0x40001c48 <process_kill+0x88>
40001c3c: b9402528     	ldr	w8, [x9, #0x24]
40001c40: 71000d1f     	cmp	w8, #0x3
40001c44: 54000c41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c48: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c4c: 910c5129     	add	x9, x9, #0x314
40001c50: b9400128     	ldr	w8, [x9]
40001c54: 6b00011f     	cmp	w8, w0
40001c58: 54000081     	b.ne	0x40001c68 <process_kill+0xa8>
40001c5c: b9402528     	ldr	w8, [x9, #0x24]
40001c60: 71000d1f     	cmp	w8, #0x3
40001c64: 54000b41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c68: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c6c: 910d1129     	add	x9, x9, #0x344
40001c70: b9400128     	ldr	w8, [x9]
40001c74: 6b00011f     	cmp	w8, w0
40001c78: 54000081     	b.ne	0x40001c88 <process_kill+0xc8>
40001c7c: b9402528     	ldr	w8, [x9, #0x24]
40001c80: 71000d1f     	cmp	w8, #0x3
40001c84: 54000a41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c88: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c8c: 910dd129     	add	x9, x9, #0x374
40001c90: b9400128     	ldr	w8, [x9]
40001c94: 6b00011f     	cmp	w8, w0
40001c98: 54000081     	b.ne	0x40001ca8 <process_kill+0xe8>
40001c9c: b9402528     	ldr	w8, [x9, #0x24]
40001ca0: 71000d1f     	cmp	w8, #0x3
40001ca4: 54000941     	b.ne	0x40001dcc <process_kill+0x20c>
40001ca8: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001cac: 910e9129     	add	x9, x9, #0x3a4
40001cb0: b9400128     	ldr	w8, [x9]
40001cb4: 6b00011f     	cmp	w8, w0
40001cb8: 54000081     	b.ne	0x40001cc8 <process_kill+0x108>
40001cbc: b9402528     	ldr	w8, [x9, #0x24]
40001cc0: 71000d1f     	cmp	w8, #0x3
40001cc4: 54000841     	b.ne	0x40001dcc <process_kill+0x20c>
40001cc8: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001ccc: 910f5129     	add	x9, x9, #0x3d4
40001cd0: b9400128     	ldr	w8, [x9]
40001cd4: 6b00011f     	cmp	w8, w0
40001cd8: 54000081     	b.ne	0x40001ce8 <process_kill+0x128>
40001cdc: b9402528     	ldr	w8, [x9, #0x24]
40001ce0: 71000d1f     	cmp	w8, #0x3
40001ce4: 54000741     	b.ne	0x40001dcc <process_kill+0x20c>
40001ce8: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001cec: 91101129     	add	x9, x9, #0x404
40001cf0: b9400128     	ldr	w8, [x9]
40001cf4: 6b00011f     	cmp	w8, w0
40001cf8: 54000081     	b.ne	0x40001d08 <process_kill+0x148>
40001cfc: b9402528     	ldr	w8, [x9, #0x24]
40001d00: 71000d1f     	cmp	w8, #0x3
40001d04: 54000641     	b.ne	0x40001dcc <process_kill+0x20c>
40001d08: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001d0c: 9110d129     	add	x9, x9, #0x434
40001d10: b9400128     	ldr	w8, [x9]
40001d14: 6b00011f     	cmp	w8, w0
40001d18: 54000081     	b.ne	0x40001d28 <process_kill+0x168>
40001d1c: b9402528     	ldr	w8, [x9, #0x24]
40001d20: 71000d1f     	cmp	w8, #0x3
40001d24: 54000541     	b.ne	0x40001dcc <process_kill+0x20c>
40001d28: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001d2c: 91119129     	add	x9, x9, #0x464
40001d30: b9400128     	ldr	w8, [x9]
40001d34: 6b00011f     	cmp	w8, w0
40001d38: 54000081     	b.ne	0x40001d48 <process_kill+0x188>
40001d3c: b9402528     	ldr	w8, [x9, #0x24]
40001d40: 71000d1f     	cmp	w8, #0x3
40001d44: 54000441     	b.ne	0x40001dcc <process_kill+0x20c>
40001d48: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001d4c: 91125129     	add	x9, x9, #0x494
40001d50: b9400128     	ldr	w8, [x9]
40001d54: 6b00011f     	cmp	w8, w0
40001d58: 54000081     	b.ne	0x40001d68 <process_kill+0x1a8>
40001d5c: b9402528     	ldr	w8, [x9, #0x24]
40001d60: 71000d1f     	cmp	w8, #0x3
40001d64: 54000341     	b.ne	0x40001dcc <process_kill+0x20c>
40001d68: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001d6c: 91131129     	add	x9, x9, #0x4c4
40001d70: b9400128     	ldr	w8, [x9]
40001d74: 6b00011f     	cmp	w8, w0
40001d78: 54000081     	b.ne	0x40001d88 <process_kill+0x1c8>
40001d7c: b9402528     	ldr	w8, [x9, #0x24]
40001d80: 71000d1f     	cmp	w8, #0x3
40001d84: 54000241     	b.ne	0x40001dcc <process_kill+0x20c>
40001d88: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001d8c: 9113d129     	add	x9, x9, #0x4f4
40001d90: b9400128     	ldr	w8, [x9]
40001d94: 6b00011f     	cmp	w8, w0
40001d98: 54000081     	b.ne	0x40001da8 <process_kill+0x1e8>
40001d9c: b9402528     	ldr	w8, [x9, #0x24]
40001da0: 71000d1f     	cmp	w8, #0x3
40001da4: 54000141     	b.ne	0x40001dcc <process_kill+0x20c>
40001da8: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001dac: 91149129     	add	x9, x9, #0x524
40001db0: b9400128     	ldr	w8, [x9]
40001db4: 6b00011f     	cmp	w8, w0
40001db8: 12800008     	mov	w8, #-0x1               // =-1
40001dbc: 54000281     	b.ne	0x40001e0c <process_kill+0x24c>
40001dc0: b940252a     	ldr	w10, [x9, #0x24]
40001dc4: 71000d5f     	cmp	w10, #0x3
40001dc8: 54000220     	b.eq	0x40001e0c <process_kill+0x24c>
40001dcc: 7100041f     	cmp	w0, #0x1
40001dd0: 54000161     	b.ne	0x40001dfc <process_kill+0x23c>
40001dd4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001dd8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001ddc: 9129e000     	add	x0, x0, #0xa78
40001de0: 910003fd     	mov	x29, sp
40001de4: 940005b4     	bl	0x400034b4 <uart_puts>
40001de8: 12800020     	mov	w0, #-0x2               // =-2
40001dec: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001df0: d65f03c0     	ret
40001df4: 12800000     	mov	w0, #-0x1               // =-1
40001df8: d65f03c0     	ret
40001dfc: 5280004a     	mov	w10, #0x2               // =2
40001e00: 2a1f03e0     	mov	w0, wzr
40001e04: b900252a     	str	w10, [x9, #0x24]
40001e08: d65f03c0     	ret
40001e0c: 2a0803e0     	mov	w0, w8
40001e10: d65f03c0     	ret

0000000040001e14 <launch_ktop>:
40001e14: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001e18: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001e1c: 911fe800     	add	x0, x0, #0x7fa
40001e20: f9000bf7     	str	x23, [sp, #0x10]
40001e24: a90257f6     	stp	x22, x21, [sp, #0x20]
40001e28: 910003fd     	mov	x29, sp
40001e2c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001e30: 940005a1     	bl	0x400034b4 <uart_puts>
40001e34: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001e38: 911fa800     	add	x0, x0, #0x7ea
40001e3c: 9400059e     	bl	0x400034b4 <uart_puts>
40001e40: 2a1f03e8     	mov	w8, wzr
40001e44: 2a1f03e1     	mov	w1, wzr
40001e48: 52800209     	mov	w9, #0x10               // =16
40001e4c: 9000006a     	adrp	x10, 0x4000d000 <__bss_start+0x3000>
40001e50: 9109f14a     	add	x10, x10, #0x27c
40001e54: 14000004     	b	0x40001e64 <launch_ktop+0x50>
40001e58: f1000529     	subs	x9, x9, #0x1
40001e5c: 9100c14a     	add	x10, x10, #0x30
40001e60: 54000120     	b.eq	0x40001e84 <launch_ktop+0x70>
40001e64: b85fc14b     	ldur	w11, [x10, #-0x4]
40001e68: 121f796b     	and	w11, w11, #0xfffffffe
40001e6c: 7100097f     	cmp	w11, #0x2
40001e70: 54ffff40     	b.eq	0x40001e58 <launch_ktop+0x44>
40001e74: b940014b     	ldr	w11, [x10]
40001e78: 11000421     	add	w1, w1, #0x1
40001e7c: 0b080168     	add	w8, w11, w8
40001e80: 17fffff6     	b	0x40001e58 <launch_ktop+0x44>
40001e84: 530a7d02     	lsr	w2, w8, #10
40001e88: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001e8c: 912cd800     	add	x0, x0, #0xb36
40001e90: 94000699     	bl	0x400038f4 <uart_printf>
40001e94: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001e98: 91310800     	add	x0, x0, #0xc42
40001e9c: 94000586     	bl	0x400034b4 <uart_puts>
40001ea0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001ea4: 9131e000     	add	x0, x0, #0xc78
40001ea8: 94000583     	bl	0x400034b4 <uart_puts>
40001eac: 90000074     	adrp	x20, 0x4000d000 <__bss_start+0x3000>
40001eb0: 910a0294     	add	x20, x20, #0x280
40001eb4: d0000035     	adrp	x21, 0x40007000 <__rodata_start+0x1000>
40001eb8: 9137cab5     	add	x21, x21, #0xdf2
40001ebc: d503201f     	nop
40001ec0: 100331d6     	adr	x22, 0x400084f8 <__rodata_start+0x24f8>
40001ec4: 52800217     	mov	w23, #0x10              // =16
40001ec8: d0000033     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
40001ecc: 91140673     	add	x19, x19, #0x501
40001ed0: 1400000a     	b	0x40001ef8 <launch_ktop+0xe4>
40001ed4: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40001ed8: b85d4281     	ldur	w1, [x20, #-0x2c]
40001edc: d100a285     	sub	x5, x20, #0x28
40001ee0: aa1303e0     	mov	x0, x19
40001ee4: 530a7d03     	lsr	w3, w8, #10
40001ee8: 94000683     	bl	0x400038f4 <uart_printf>
40001eec: f10006f7     	subs	x23, x23, #0x1
40001ef0: 9100c294     	add	x20, x20, #0x30
40001ef4: 54000120     	b.eq	0x40001f18 <launch_ktop+0x104>
40001ef8: b85f8288     	ldur	w8, [x20, #-0x8]
40001efc: 71000d1f     	cmp	w8, #0x3
40001f00: 54ffff60     	b.eq	0x40001eec <launch_ktop+0xd8>
40001f04: 7100091f     	cmp	w8, #0x2
40001f08: aa1503e2     	mov	x2, x21
40001f0c: 54fffe48     	b.hi	0x40001ed4 <launch_ktop+0xc0>
40001f10: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
40001f14: 17fffff0     	b	0x40001ed4 <launch_ktop+0xc0>
40001f18: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001f1c: 9106a400     	add	x0, x0, #0x1a9
40001f20: 94000565     	bl	0x400034b4 <uart_puts>
40001f24: 52808114     	mov	w20, #0x408             // =1032
40001f28: 52800033     	mov	w19, #0x1               // =1
40001f2c: 72a02014     	movk	w20, #0x100, lsl #16
40001f30: 14000003     	b	0x40001f3c <launch_ktop+0x128>
40001f34: 7101c51f     	cmp	w8, #0x71
40001f38: 54000100     	b.eq	0x40001f58 <launch_ktop+0x144>
40001f3c: 94000591     	bl	0x40003580 <uart_getc>
40001f40: 12001c08     	and	w8, w0, #0xff
40001f44: 7100611f     	cmp	w8, #0x18
40001f48: 54ffff68     	b.hi	0x40001f34 <launch_ktop+0x120>
40001f4c: 1ac82269     	lsl	w9, w19, w8
40001f50: 6a14013f     	tst	w9, w20
40001f54: 54ffff00     	b.eq	0x40001f34 <launch_ktop+0x120>
40001f58: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40001f5c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001f60: 912da400     	add	x0, x0, #0xb69
40001f64: a94257f6     	ldp	x22, x21, [sp, #0x20]
40001f68: f9400bf7     	ldr	x23, [sp, #0x10]
40001f6c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40001f70: 14000551     	b	0x400034b4 <uart_puts>

0000000040001f74 <script_init>:
40001f74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f78: 90000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40001f7c: d503201f     	nop
40001f80: 10026800     	adr	x0, 0x40006c80 <__rodata_start+0xc80>
40001f84: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001f88: 91261421     	add	x1, x1, #0x985
40001f8c: 910003fd     	mov	x29, sp
40001f90: b905551f     	str	wzr, [x8, #0x554]
40001f94: 94000007     	bl	0x40001fb0 <script_set_var>
40001f98: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001f9c: 912ffc00     	add	x0, x0, #0xbff
40001fa0: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001fa4: 9119a821     	add	x1, x1, #0x66a
40001fa8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001fac: 14000001     	b	0x40001fb0 <script_set_var>

0000000040001fb0 <script_set_var>:
40001fb0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001fb4: a9015ff8     	stp	x24, x23, [sp, #0x10]
40001fb8: 90000077     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
40001fbc: 910003fd     	mov	x29, sp
40001fc0: b94556e8     	ldr	w8, [x23, #0x554]
40001fc4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fc8: aa0103f3     	mov	x19, x1
40001fcc: aa0003f4     	mov	x20, x0
40001fd0: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fd4: 7100051f     	cmp	w8, #0x1
40001fd8: 5400024b     	b.lt	0x40002020 <script_set_var+0x70>
40001fdc: aa1f03f8     	mov	x24, xzr
40001fe0: 90000075     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40001fe4: 912562b5     	add	x21, x21, #0x958
40001fe8: 90000076     	adrp	x22, 0x4000d000 <__bss_start+0x3000>
40001fec: 911562d6     	add	x22, x22, #0x558
40001ff0: aa1603e0     	mov	x0, x22
40001ff4: aa1403e1     	mov	x1, x20
40001ff8: 940001b6     	bl	0x400026d0 <kstrcmp>
40001ffc: 340003e0     	cbz	w0, 0x40002078 <script_set_var+0xc8>
40002000: b98556e8     	ldrsw	x8, [x23, #0x554]
40002004: 91000718     	add	x24, x24, #0x1
40002008: 910202b5     	add	x21, x21, #0x80
4000200c: 910082d6     	add	x22, x22, #0x20
40002010: eb08031f     	cmp	x24, x8
40002014: 54fffeeb     	b.lt	0x40001ff0 <script_set_var+0x40>
40002018: 71007d1f     	cmp	w8, #0x1f
4000201c: 5400038c     	b.gt	0x4000208c <script_set_var+0xdc>
40002020: f0000055     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40002024: 911562b5     	add	x21, x21, #0x558
40002028: aa1403e1     	mov	x1, x20
4000202c: 93407d08     	sxtw	x8, w8
40002030: 528003e2     	mov	w2, #0x1f               // =31
40002034: 8b0816a0     	add	x0, x21, x8, lsl #5
40002038: 940001cc     	bl	0x40002768 <kstrncpy>
4000203c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002040: f0000054     	adrp	x20, 0x4000d000 <__bss_start+0x3000>
40002044: 91256294     	add	x20, x20, #0x958
40002048: aa1303e1     	mov	x1, x19
4000204c: 52800fe2     	mov	w2, #0x7f               // =127
40002050: 8b0816a9     	add	x9, x21, x8, lsl #5
40002054: 8b081e80     	add	x0, x20, x8, lsl #7
40002058: 39007d3f     	strb	wzr, [x9, #0x1f]
4000205c: 940001c3     	bl	0x40002768 <kstrncpy>
40002060: b98556e8     	ldrsw	x8, [x23, #0x554]
40002064: 8b081e89     	add	x9, x20, x8, lsl #7
40002068: 11000508     	add	w8, w8, #0x1
4000206c: b90556e8     	str	w8, [x23, #0x554]
40002070: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002074: 14000006     	b	0x4000208c <script_set_var+0xdc>
40002078: aa1503e0     	mov	x0, x21
4000207c: aa1303e1     	mov	x1, x19
40002080: 52800fe2     	mov	w2, #0x7f               // =127
40002084: 940001b9     	bl	0x40002768 <kstrncpy>
40002088: 3901febf     	strb	wzr, [x21, #0x7f]
4000208c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002090: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002094: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002098: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000209c: d65f03c0     	ret

00000000400020a0 <script_get_var>:
400020a0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400020a4: a90257f6     	stp	x22, x21, [sp, #0x20]
400020a8: f0000056     	adrp	x22, 0x4000d000 <__bss_start+0x3000>
400020ac: 910003fd     	mov	x29, sp
400020b0: b94556c8     	ldr	w8, [x22, #0x554]
400020b4: a9015ff8     	stp	x24, x23, [sp, #0x10]
400020b8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400020bc: 7100051f     	cmp	w8, #0x1
400020c0: 540002ab     	b.lt	0x40002114 <script_get_var+0x74>
400020c4: aa0003f4     	mov	x20, x0
400020c8: aa1f03f7     	mov	x23, xzr
400020cc: f0000053     	adrp	x19, 0x4000d000 <__bss_start+0x3000>
400020d0: 91256273     	add	x19, x19, #0x958
400020d4: f0000055     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
400020d8: 911562b5     	add	x21, x21, #0x558
400020dc: 90000038     	adrp	x24, 0x40006000 <__rodata_start>
400020e0: 91249718     	add	x24, x24, #0x925
400020e4: aa1503e0     	mov	x0, x21
400020e8: aa1403e1     	mov	x1, x20
400020ec: 94000179     	bl	0x400026d0 <kstrcmp>
400020f0: 34000160     	cbz	w0, 0x4000211c <script_get_var+0x7c>
400020f4: b98556c8     	ldrsw	x8, [x22, #0x554]
400020f8: 910006f7     	add	x23, x23, #0x1
400020fc: 91020273     	add	x19, x19, #0x80
40002100: 910082b5     	add	x21, x21, #0x20
40002104: eb0802ff     	cmp	x23, x8
40002108: 54fffeeb     	b.lt	0x400020e4 <script_get_var+0x44>
4000210c: aa1803f3     	mov	x19, x24
40002110: 14000003     	b	0x4000211c <script_get_var+0x7c>
40002114: 90000033     	adrp	x19, 0x40006000 <__rodata_start>
40002118: 91249673     	add	x19, x19, #0x925
4000211c: aa1303e0     	mov	x0, x19
40002120: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002124: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002128: a9415ff8     	ldp	x24, x23, [sp, #0x10]
4000212c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002130: d65f03c0     	ret

0000000040002134 <script_expand_vars>:
40002134: d10203ff     	sub	sp, sp, #0x80
40002138: a9036ffc     	stp	x28, x27, [sp, #0x30]
4000213c: 2a1f03fc     	mov	w28, wzr
40002140: a90467fa     	stp	x26, x25, [sp, #0x40]
40002144: 90000039     	adrp	x25, 0x40006000 <__rodata_start>
40002148: 91249739     	add	x25, x25, #0x925
4000214c: a9055ff8     	stp	x24, x23, [sp, #0x50]
40002150: 910003f8     	mov	x24, sp
40002154: f000005a     	adrp	x26, 0x4000d000 <__bss_start+0x3000>
40002158: a90657f6     	stp	x22, x21, [sp, #0x60]
4000215c: 2a1f03f6     	mov	w22, wzr
40002160: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002164: aa0103f3     	mov	x19, x1
40002168: aa0003f4     	mov	x20, x0
4000216c: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002170: 910083fd     	add	x29, sp, #0x20
40002174: 14000001     	b	0x40002178 <script_expand_vars+0x44>
40002178: 93407f89     	sxtw	x9, w28
4000217c: 38696a88     	ldrb	w8, [x20, x9]
40002180: 7100911f     	cmp	w8, #0x24
40002184: 540000e0     	b.eq	0x400021a0 <script_expand_vars+0x6c>
40002188: 34000788     	cbz	w8, 0x40002278 <script_expand_vars+0x144>
4000218c: 110006ca     	add	w10, w22, #0x1
40002190: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002194: 1100053c     	add	w28, w9, #0x1
40002198: 2a0a03f6     	mov	w22, w10
4000219c: 17fffff7     	b	0x40002178 <script_expand_vars+0x44>
400021a0: aa1f03e8     	mov	x8, xzr
400021a4: 14000005     	b	0x400021b8 <script_expand_vars+0x84>
400021a8: 9100050a     	add	x10, x8, #0x1
400021ac: 38286b09     	strb	w9, [x24, x8]
400021b0: d1000789     	sub	x9, x28, #0x1
400021b4: aa0a03e8     	mov	x8, x10
400021b8: 9100053c     	add	x28, x9, #0x1
400021bc: 14000004     	b	0x400021cc <script_expand_vars+0x98>
400021c0: f100791f     	cmp	x8, #0x1e
400021c4: 9100079c     	add	x28, x28, #0x1
400021c8: 54ffff09     	b.ls	0x400021a8 <script_expand_vars+0x74>
400021cc: 387c6a89     	ldrb	w9, [x20, x28]
400021d0: 121a792a     	and	w10, w9, #0xffffffdf
400021d4: 5101054a     	sub	w10, w10, #0x41
400021d8: 7100695f     	cmp	w10, #0x1a
400021dc: 54ffff23     	b.lo	0x400021c0 <script_expand_vars+0x8c>
400021e0: 71017d3f     	cmp	w9, #0x5f
400021e4: 54fffee0     	b.eq	0x400021c0 <script_expand_vars+0x8c>
400021e8: 5100c12a     	sub	w10, w9, #0x30
400021ec: 7100255f     	cmp	w10, #0x9
400021f0: 54fffe89     	b.ls	0x400021c0 <script_expand_vars+0x8c>
400021f4: b9455749     	ldr	w9, [x26, #0x554]
400021f8: 38286b1f     	strb	wzr, [x24, x8]
400021fc: 7100053f     	cmp	w9, #0x1
40002200: 5400028b     	b.lt	0x40002250 <script_expand_vars+0x11c>
40002204: aa1f03fb     	mov	x27, xzr
40002208: f0000055     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
4000220c: 911562b5     	add	x21, x21, #0x558
40002210: f0000057     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
40002214: 912562f7     	add	x23, x23, #0x958
40002218: 910003e1     	mov	x1, sp
4000221c: aa1503e0     	mov	x0, x21
40002220: 9400012c     	bl	0x400026d0 <kstrcmp>
40002224: 34000100     	cbz	w0, 0x40002244 <script_expand_vars+0x110>
40002228: b9855748     	ldrsw	x8, [x26, #0x554]
4000222c: 9100077b     	add	x27, x27, #0x1
40002230: 910202f7     	add	x23, x23, #0x80
40002234: 910082b5     	add	x21, x21, #0x20
40002238: eb08037f     	cmp	x27, x8
4000223c: 54fffeeb     	b.lt	0x40002218 <script_expand_vars+0xe4>
40002240: aa1903f7     	mov	x23, x25
40002244: 394002e8     	ldrb	w8, [x23]
40002248: 350000a8     	cbnz	w8, 0x4000225c <script_expand_vars+0x128>
4000224c: 17ffffcb     	b	0x40002178 <script_expand_vars+0x44>
40002250: aa1903f7     	mov	x23, x25
40002254: 394002e8     	ldrb	w8, [x23]
40002258: 34fff908     	cbz	w8, 0x40002178 <script_expand_vars+0x44>
4000225c: 8b36c269     	add	x9, x19, w22, sxtw
40002260: 910006ea     	add	x10, x23, #0x1
40002264: 38001528     	strb	w8, [x9], #0x1
40002268: 110006d6     	add	w22, w22, #0x1
4000226c: 38401548     	ldrb	w8, [x10], #0x1
40002270: 35ffffa8     	cbnz	w8, 0x40002264 <script_expand_vars+0x130>
40002274: 17ffffc1     	b	0x40002178 <script_expand_vars+0x44>
40002278: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
4000227c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002280: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002284: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002288: a94467fa     	ldp	x26, x25, [sp, #0x40]
4000228c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002290: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002294: 910203ff     	add	sp, sp, #0x80
40002298: d65f03c0     	ret

000000004000229c <script_execute_line>:
4000229c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400022a0: a9014ffc     	stp	x28, x19, [sp, #0x10]
400022a4: 910003fd     	mov	x29, sp
400022a8: d10803ff     	sub	sp, sp, #0x200
400022ac: 14000004     	b	0x400022bc <script_execute_line+0x20>
400022b0: 7100811f     	cmp	w8, #0x20
400022b4: 54000121     	b.ne	0x400022d8 <script_execute_line+0x3c>
400022b8: 91000400     	add	x0, x0, #0x1
400022bc: 39400008     	ldrb	w8, [x0]
400022c0: 71007d1f     	cmp	w8, #0x1f
400022c4: 54ffff6c     	b.gt	0x400022b0 <script_execute_line+0x14>
400022c8: 7100251f     	cmp	w8, #0x9
400022cc: 54ffff60     	b.eq	0x400022b8 <script_execute_line+0x1c>
400022d0: 34001668     	cbz	w8, 0x4000259c <script_execute_line+0x300>
400022d4: 14000003     	b	0x400022e0 <script_execute_line+0x44>
400022d8: 71008d1f     	cmp	w8, #0x23
400022dc: 54001600     	b.eq	0x4000259c <script_execute_line+0x300>
400022e0: 910403e1     	add	x1, sp, #0x100
400022e4: 910403f3     	add	x19, sp, #0x100
400022e8: 97ffff93     	bl	0x40002134 <script_expand_vars>
400022ec: 394403e9     	ldrb	w9, [sp, #0x100]
400022f0: 34001529     	cbz	w9, 0x40002594 <script_execute_line+0x2f8>
400022f4: 394407e8     	ldrb	w8, [sp, #0x101]
400022f8: aa1f03ea     	mov	x10, xzr
400022fc: 2a0903eb     	mov	w11, w9
40002300: 14000004     	b	0x40002310 <script_execute_line+0x74>
40002304: 9100054a     	add	x10, x10, #0x1
40002308: 386a6a6b     	ldrb	w11, [x19, x10]
4000230c: 340003cb     	cbz	w11, 0x40002384 <script_execute_line+0xe8>
40002310: b4ffffaa     	cbz	x10, 0x40002304 <script_execute_line+0x68>
40002314: 7100f57f     	cmp	w11, #0x3d
40002318: 54ffff61     	b.ne	0x40002304 <script_execute_line+0x68>
4000231c: 8b13014b     	add	x11, x10, x19
40002320: 385ff16c     	ldurb	w12, [x11, #-0x1]
40002324: 7100f59f     	cmp	w12, #0x3d
40002328: 54fffee0     	b.eq	0x40002304 <script_execute_line+0x68>
4000232c: 3940056b     	ldrb	w11, [x11, #0x1]
40002330: 7100f57f     	cmp	w11, #0x3d
40002334: 54fffe80     	b.eq	0x40002304 <script_execute_line+0x68>
40002338: aa1f03ec     	mov	x12, xzr
4000233c: 2a1f03eb     	mov	w11, wzr
40002340: 386c6a6d     	ldrb	w13, [x19, x12]
40002344: 9100058c     	add	x12, x12, #0x1
40002348: 710081bf     	cmp	w13, #0x20
4000234c: 1a9f156b     	csinc	w11, w11, wzr, ne
40002350: eb0c015f     	cmp	x10, x12
40002354: 54ffff61     	b.ne	0x40002340 <script_execute_line+0xa4>
40002358: 35fffd6b     	cbnz	w11, 0x40002304 <script_execute_line+0x68>
4000235c: 7101a53f     	cmp	w9, #0x69
40002360: 54fffd20     	b.eq	0x40002304 <script_execute_line+0x68>
40002364: 7101991f     	cmp	w8, #0x66
40002368: 54fffce0     	b.eq	0x40002304 <script_execute_line+0x68>
4000236c: 910403e8     	add	x8, sp, #0x100
40002370: 910403e0     	add	x0, sp, #0x100
40002374: 8b0a0101     	add	x1, x8, x10
40002378: 3800143f     	strb	wzr, [x1], #0x1
4000237c: 97ffff0d     	bl	0x40001fb0 <script_set_var>
40002380: 14000087     	b	0x4000259c <script_execute_line+0x300>
40002384: 394403e9     	ldrb	w9, [sp, #0x100]
40002388: 7101a53f     	cmp	w9, #0x69
4000238c: 54001041     	b.ne	0x40002594 <script_execute_line+0x2f8>
40002390: 7101991f     	cmp	w8, #0x66
40002394: 54001001     	b.ne	0x40002594 <script_execute_line+0x2f8>
40002398: 39440be8     	ldrb	w8, [sp, #0x102]
4000239c: 7100811f     	cmp	w8, #0x20
400023a0: 54000fa1     	b.ne	0x40002594 <script_execute_line+0x2f8>
400023a4: 39440fe9     	ldrb	w9, [sp, #0x103]
400023a8: 7100813f     	cmp	w9, #0x20
400023ac: 54000081     	b.ne	0x400023bc <script_execute_line+0x120>
400023b0: aa1f03e9     	mov	x9, xzr
400023b4: 52800068     	mov	w8, #0x3                // =3
400023b8: 14000014     	b	0x40002408 <script_execute_line+0x16c>
400023bc: 910403ea     	add	x10, sp, #0x100
400023c0: aa1f03e8     	mov	x8, xzr
400023c4: 910303eb     	add	x11, sp, #0xc0
400023c8: 9100114a     	add	x10, x10, #0x4
400023cc: 34000189     	cbz	w9, 0x400023fc <script_execute_line+0x160>
400023d0: f100f91f     	cmp	x8, #0x3e
400023d4: 54000148     	b.hi	0x400023fc <script_execute_line+0x160>
400023d8: 38286969     	strb	w9, [x11, x8]
400023dc: 38686949     	ldrb	w9, [x10, x8]
400023e0: 9100050c     	add	x12, x8, #0x1
400023e4: aa0c03e8     	mov	x8, x12
400023e8: 7100813f     	cmp	w9, #0x20
400023ec: 54ffff01     	b.ne	0x400023cc <script_execute_line+0x130>
400023f0: 11000d8a     	add	w10, w12, #0x3
400023f4: 2a0c03e8     	mov	w8, w12
400023f8: 14000002     	b	0x40002400 <script_execute_line+0x164>
400023fc: 11000d0a     	add	w10, w8, #0x3
40002400: 2a0803e9     	mov	w9, w8
40002404: 2a0a03e8     	mov	w8, w10
40002408: 910303ea     	add	x10, sp, #0xc0
4000240c: 3829695f     	strb	wzr, [x10, x9]
40002410: 910403e9     	add	x9, sp, #0x100
40002414: 3868692a     	ldrb	w10, [x9, x8]
40002418: 7100815f     	cmp	w10, #0x20
4000241c: 54000061     	b.ne	0x40002428 <script_execute_line+0x18c>
40002420: 91000508     	add	x8, x8, #0x1
40002424: 17fffffc     	b	0x40002414 <script_execute_line+0x178>
40002428: 7100855f     	cmp	w10, #0x21
4000242c: 54000060     	b.eq	0x40002438 <script_execute_line+0x19c>
40002430: 7100f55f     	cmp	w10, #0x3d
40002434: 540000e1     	b.ne	0x40002450 <script_execute_line+0x1b4>
40002438: 11000509     	add	w9, w8, #0x1
4000243c: 910403ea     	add	x10, sp, #0x100
40002440: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002444: 9100090a     	add	x10, x8, #0x2
40002448: 7100f53f     	cmp	w9, #0x3d
4000244c: 9a880148     	csel	x8, x10, x8, eq
40002450: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002454: 910403ea     	add	x10, sp, #0x100
40002458: d2c0002b     	mov	x11, #0x100000000       // =4294967296
4000245c: 8b088129     	add	x9, x9, x8, lsl #32
40002460: 8b28c14a     	add	x10, x10, w8, sxtw
40002464: 51000508     	sub	w8, w8, #0x1
40002468: 3840154c     	ldrb	w12, [x10], #0x1
4000246c: 8b0b0129     	add	x9, x9, x11
40002470: 11000508     	add	w8, w8, #0x1
40002474: 7100819f     	cmp	w12, #0x20
40002478: 54ffff80     	b.eq	0x40002468 <script_execute_line+0x1cc>
4000247c: 9360fd2c     	asr	x12, x9, #32
40002480: 910403e9     	add	x9, sp, #0x100
40002484: 386c692d     	ldrb	w13, [x9, x12]
40002488: 710081bf     	cmp	w13, #0x20
4000248c: 54000061     	b.ne	0x40002498 <script_execute_line+0x1fc>
40002490: aa1f03ea     	mov	x10, xzr
40002494: 14000010     	b	0x400024d4 <script_execute_line+0x238>
40002498: aa1f03eb     	mov	x11, xzr
4000249c: 910203ec     	add	x12, sp, #0x80
400024a0: 3400016d     	cbz	w13, 0x400024cc <script_execute_line+0x230>
400024a4: f100f97f     	cmp	x11, #0x3e
400024a8: 54000128     	b.hi	0x400024cc <script_execute_line+0x230>
400024ac: 382b698d     	strb	w13, [x12, x11]
400024b0: 386b694d     	ldrb	w13, [x10, x11]
400024b4: 9100056e     	add	x14, x11, #0x1
400024b8: 11000508     	add	w8, w8, #0x1
400024bc: aa0e03eb     	mov	x11, x14
400024c0: 710081bf     	cmp	w13, #0x20
400024c4: 54fffee1     	b.ne	0x400024a0 <script_execute_line+0x204>
400024c8: 2a0e03eb     	mov	w11, w14
400024cc: 93407d0c     	sxtw	x12, w8
400024d0: 2a0b03ea     	mov	w10, w11
400024d4: d3607d8d     	lsl	x13, x12, #32
400024d8: 910203eb     	add	x11, sp, #0x80
400024dc: d2c0006f     	mov	x15, #0x300000000       // =12884901888
400024e0: d2c00050     	mov	x16, #0x200000000       // =8589934592
400024e4: d2c0002e     	mov	x14, #0x100000000       // =4294967296
400024e8: 11001108     	add	w8, w8, #0x4
400024ec: 382a697f     	strb	wzr, [x11, x10]
400024f0: 8b0f01aa     	add	x10, x13, x15
400024f4: 8b1001ab     	add	x11, x13, x16
400024f8: 8b0e01ad     	add	x13, x13, x14
400024fc: 8b0c0129     	add	x9, x9, x12
40002500: 3840152c     	ldrb	w12, [x9], #0x1
40002504: 7100819f     	cmp	w12, #0x20
40002508: 540000c1     	b.ne	0x40002520 <script_execute_line+0x284>
4000250c: 11000508     	add	w8, w8, #0x1
40002510: 8b0e014a     	add	x10, x10, x14
40002514: 8b0e016b     	add	x11, x11, x14
40002518: 8b0e01ad     	add	x13, x13, x14
4000251c: 17fffff9     	b	0x40002500 <script_execute_line+0x264>
40002520: 7101d19f     	cmp	w12, #0x74
40002524: 54000381     	b.ne	0x40002594 <script_execute_line+0x2f8>
40002528: 9360fdac     	asr	x12, x13, #32
4000252c: 910403e9     	add	x9, sp, #0x100
40002530: 386c692c     	ldrb	w12, [x9, x12]
40002534: 7101a19f     	cmp	w12, #0x68
40002538: 540002e1     	b.ne	0x40002594 <script_execute_line+0x2f8>
4000253c: 9360fd6b     	asr	x11, x11, #32
40002540: 386b6929     	ldrb	w9, [x9, x11]
40002544: 7101953f     	cmp	w9, #0x65
40002548: 54000261     	b.ne	0x40002594 <script_execute_line+0x2f8>
4000254c: 9360fd4a     	asr	x10, x10, #32
40002550: 910403e9     	add	x9, sp, #0x100
40002554: 386a692a     	ldrb	w10, [x9, x10]
40002558: 7101b95f     	cmp	w10, #0x6e
4000255c: 540001c1     	b.ne	0x40002594 <script_execute_line+0x2f8>
40002560: 8b28c128     	add	x8, x9, w8, sxtw
40002564: d1000501     	sub	x1, x8, #0x1
40002568: 38401c28     	ldrb	w8, [x1, #0x1]!
4000256c: 7100811f     	cmp	w8, #0x20
40002570: 54ffffc0     	b.eq	0x40002568 <script_execute_line+0x2cc>
40002574: 910003e0     	mov	x0, sp
40002578: 94000075     	bl	0x4000274c <kstrcpy>
4000257c: 910303e0     	add	x0, sp, #0xc0
40002580: 910203e1     	add	x1, sp, #0x80
40002584: 94000053     	bl	0x400026d0 <kstrcmp>
40002588: 350000a0     	cbnz	w0, 0x4000259c <script_execute_line+0x300>
4000258c: 910003e0     	mov	x0, sp
40002590: 14000002     	b	0x40002598 <script_execute_line+0x2fc>
40002594: 910403e0     	add	x0, sp, #0x100
40002598: 97fff9cd     	bl	0x40000ccc <execute_command>
4000259c: 2a1f03e0     	mov	w0, wzr
400025a0: 910803ff     	add	sp, sp, #0x200
400025a4: a9414ffc     	ldp	x28, x19, [sp, #0x10]
400025a8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400025ac: d65f03c0     	ret

00000000400025b0 <script_run_file>:
400025b0: d10503ff     	sub	sp, sp, #0x140
400025b4: a9107bfd     	stp	x29, x30, [sp, #0x100]
400025b8: 910403fd     	add	x29, sp, #0x100
400025bc: f9008bfc     	str	x28, [sp, #0x110]
400025c0: a91257f6     	stp	x22, x21, [sp, #0x120]
400025c4: a9134ff4     	stp	x20, x19, [sp, #0x130]
400025c8: aa0003f4     	mov	x20, x0
400025cc: 9400088a     	bl	0x400047f4 <vfs_find>
400025d0: b4000080     	cbz	x0, 0x400025e0 <script_run_file+0x30>
400025d4: b9402008     	ldr	w8, [x0, #0x20]
400025d8: aa0003f3     	mov	x19, x0
400025dc: 340000e8     	cbz	w8, 0x400025f8 <script_run_file+0x48>
400025e0: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400025e4: 9103b000     	add	x0, x0, #0xec
400025e8: aa1403e1     	mov	x1, x20
400025ec: 940004c2     	bl	0x400038f4 <uart_printf>
400025f0: 12800000     	mov	w0, #-0x1               // =-1
400025f4: 14000021     	b	0x40002678 <script_run_file+0xc8>
400025f8: f9401668     	ldr	x8, [x19, #0x28]
400025fc: aa1f03f4     	mov	x20, xzr
40002600: 2a1f03e9     	mov	w9, wzr
40002604: 9100c275     	add	x21, x19, #0x30
40002608: 910003f6     	mov	x22, sp
4000260c: 14000008     	b	0x4000262c <script_run_file+0x7c>
40002610: 7100053f     	cmp	w9, #0x1
40002614: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002618: 2a1f03e9     	mov	w9, wzr
4000261c: 5400022a     	b.ge	0x40002660 <script_run_file+0xb0>
40002620: 91000694     	add	x20, x20, #0x1
40002624: eb08029f     	cmp	x20, x8
40002628: 54000268     	b.hi	0x40002674 <script_run_file+0xc4>
4000262c: eb08029f     	cmp	x20, x8
40002630: 54ffff00     	b.eq	0x40002610 <script_run_file+0x60>
40002634: 38746aaa     	ldrb	w10, [x21, x20]
40002638: 7100295f     	cmp	w10, #0xa
4000263c: 54fffea0     	b.eq	0x40002610 <script_run_file+0x60>
40002640: 7100355f     	cmp	w10, #0xd
40002644: 54fffee0     	b.eq	0x40002620 <script_run_file+0x70>
40002648: 7103f93f     	cmp	w9, #0xfe
4000264c: 54fffeac     	b.gt	0x40002620 <script_run_file+0x70>
40002650: 1100052b     	add	w11, w9, #0x1
40002654: 3829caca     	strb	w10, [x22, w9, sxtw]
40002658: 2a0b03e9     	mov	w9, w11
4000265c: 17fffff1     	b	0x40002620 <script_run_file+0x70>
40002660: 910003e0     	mov	x0, sp
40002664: 97ffff0e     	bl	0x4000229c <script_execute_line>
40002668: f9401668     	ldr	x8, [x19, #0x28]
4000266c: 2a1f03e9     	mov	w9, wzr
40002670: 17ffffec     	b	0x40002620 <script_run_file+0x70>
40002674: 2a1f03e0     	mov	w0, wzr
40002678: a9534ff4     	ldp	x20, x19, [sp, #0x130]
4000267c: f9408bfc     	ldr	x28, [sp, #0x110]
40002680: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002684: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002688: 910503ff     	add	sp, sp, #0x140
4000268c: d65f03c0     	ret

0000000040002690 <kstrlen>:
40002690: b40000c0     	cbz	x0, 0x400026a8 <kstrlen+0x18>
40002694: aa1f03e8     	mov	x8, xzr
40002698: 38686809     	ldrb	w9, [x0, x8]
4000269c: 91000508     	add	x8, x8, #0x1
400026a0: 35ffffc9     	cbnz	w9, 0x40002698 <kstrlen+0x8>
400026a4: d1000500     	sub	x0, x8, #0x1
400026a8: d65f03c0     	ret

00000000400026ac <kstrcat>:
400026ac: b4000100     	cbz	x0, 0x400026cc <kstrcat+0x20>
400026b0: b40000e1     	cbz	x1, 0x400026cc <kstrcat+0x20>
400026b4: d1000408     	sub	x8, x0, #0x1
400026b8: 38401d09     	ldrb	w9, [x8, #0x1]!
400026bc: 35ffffe9     	cbnz	w9, 0x400026b8 <kstrcat+0xc>
400026c0: 38401429     	ldrb	w9, [x1], #0x1
400026c4: 38001509     	strb	w9, [x8], #0x1
400026c8: 35ffffc9     	cbnz	w9, 0x400026c0 <kstrcat+0x14>
400026cc: d65f03c0     	ret

00000000400026d0 <kstrcmp>:
400026d0: aa0003e8     	mov	x8, x0
400026d4: 12800000     	mov	w0, #-0x1               // =-1
400026d8: b4000188     	cbz	x8, 0x40002708 <kstrcmp+0x38>
400026dc: b4000161     	cbz	x1, 0x40002708 <kstrcmp+0x38>
400026e0: 38401509     	ldrb	w9, [x8], #0x1
400026e4: 340000e9     	cbz	w9, 0x40002700 <kstrcmp+0x30>
400026e8: 3940002a     	ldrb	w10, [x1]
400026ec: 6b0a013f     	cmp	w9, w10
400026f0: 54000081     	b.ne	0x40002700 <kstrcmp+0x30>
400026f4: 38401509     	ldrb	w9, [x8], #0x1
400026f8: 91000421     	add	x1, x1, #0x1
400026fc: 35ffff69     	cbnz	w9, 0x400026e8 <kstrcmp+0x18>
40002700: 39400028     	ldrb	w8, [x1]
40002704: 4b080120     	sub	w0, w9, w8
40002708: d65f03c0     	ret

000000004000270c <kstrncmp>:
4000270c: 12800008     	mov	w8, #-0x1               // =-1
40002710: b4000160     	cbz	x0, 0x4000273c <kstrncmp+0x30>
40002714: b4000141     	cbz	x1, 0x4000273c <kstrncmp+0x30>
40002718: b4000102     	cbz	x2, 0x40002738 <kstrncmp+0x2c>
4000271c: 38401408     	ldrb	w8, [x0], #0x1
40002720: 38401429     	ldrb	w9, [x1], #0x1
40002724: 34000108     	cbz	w8, 0x40002744 <kstrncmp+0x38>
40002728: 6b09011f     	cmp	w8, w9
4000272c: 540000c1     	b.ne	0x40002744 <kstrncmp+0x38>
40002730: f1000442     	subs	x2, x2, #0x1
40002734: 54ffff41     	b.ne	0x4000271c <kstrncmp+0x10>
40002738: 2a1f03e8     	mov	w8, wzr
4000273c: 2a0803e0     	mov	w0, w8
40002740: d65f03c0     	ret
40002744: 4b090100     	sub	w0, w8, w9
40002748: d65f03c0     	ret

000000004000274c <kstrcpy>:
4000274c: b40000c0     	cbz	x0, 0x40002764 <kstrcpy+0x18>
40002750: b40000a1     	cbz	x1, 0x40002764 <kstrcpy+0x18>
40002754: aa0003e8     	mov	x8, x0
40002758: 38401429     	ldrb	w9, [x1], #0x1
4000275c: 38001509     	strb	w9, [x8], #0x1
40002760: 35ffffc9     	cbnz	w9, 0x40002758 <kstrcpy+0xc>
40002764: d65f03c0     	ret

0000000040002768 <kstrncpy>:
40002768: b4000480     	cbz	x0, 0x400027f8 <kstrncpy+0x90>
4000276c: b4000461     	cbz	x1, 0x400027f8 <kstrncpy+0x90>
40002770: b4000442     	cbz	x2, 0x400027f8 <kstrncpy+0x90>
40002774: aa1f03e9     	mov	x9, xzr
40002778: aa0203e8     	mov	x8, x2
4000277c: 3869682a     	ldrb	w10, [x1, x9]
40002780: 3829680a     	strb	w10, [x0, x9]
40002784: 340000ca     	cbz	w10, 0x4000279c <kstrncpy+0x34>
40002788: 91000529     	add	x9, x9, #0x1
4000278c: d1000508     	sub	x8, x8, #0x1
40002790: eb09005f     	cmp	x2, x9
40002794: 54ffff41     	b.ne	0x4000277c <kstrncpy+0x14>
40002798: 14000018     	b	0x400027f8 <kstrncpy+0x90>
4000279c: cb09004a     	sub	x10, x2, x9
400027a0: 8b090009     	add	x9, x0, x9
400027a4: f100095f     	cmp	x10, #0x2
400027a8: 54000082     	b.hs	0x400027b8 <kstrncpy+0x50>
400027ac: 91000528     	add	x8, x9, #0x1
400027b0: aa0a03e9     	mov	x9, x10
400027b4: 1400000e     	b	0x400027ec <kstrncpy+0x84>
400027b8: 927ff908     	and	x8, x8, #0xfffffffffffffffe
400027bc: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
400027c0: 9100092c     	add	x12, x9, #0x2
400027c4: 8b090108     	add	x8, x8, x9
400027c8: 92400149     	and	x9, x10, #0x1
400027cc: aa0b03ed     	mov	x13, x11
400027d0: 91000508     	add	x8, x8, #0x1
400027d4: f10009ad     	subs	x13, x13, #0x2
400027d8: 781ff19f     	sturh	wzr, [x12, #-0x1]
400027dc: 9100098c     	add	x12, x12, #0x2
400027e0: 54ffffa1     	b.ne	0x400027d4 <kstrncpy+0x6c>
400027e4: eb0b015f     	cmp	x10, x11
400027e8: 54000080     	b.eq	0x400027f8 <kstrncpy+0x90>
400027ec: f1000529     	subs	x9, x9, #0x1
400027f0: 3800151f     	strb	wzr, [x8], #0x1
400027f4: 54ffffc1     	b.ne	0x400027ec <kstrncpy+0x84>
400027f8: d65f03c0     	ret

00000000400027fc <memset>:
400027fc: b40002a0     	cbz	x0, 0x40002850 <memset+0x54>
40002800: b4000282     	cbz	x2, 0x40002850 <memset+0x54>
40002804: f100085f     	cmp	x2, #0x2
40002808: 54000082     	b.hs	0x40002818 <memset+0x1c>
4000280c: aa0003e8     	mov	x8, x0
40002810: aa0203e9     	mov	x9, x2
40002814: 1400000c     	b	0x40002844 <memset+0x48>
40002818: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
4000281c: 92400049     	and	x9, x2, #0x1
40002820: 9100040b     	add	x11, x0, #0x1
40002824: 8b0a0008     	add	x8, x0, x10
40002828: aa0a03ec     	mov	x12, x10
4000282c: f100098c     	subs	x12, x12, #0x2
40002830: 381ff161     	sturb	w1, [x11, #-0x1]
40002834: 38002561     	strb	w1, [x11], #0x2
40002838: 54ffffa1     	b.ne	0x4000282c <memset+0x30>
4000283c: eb0a005f     	cmp	x2, x10
40002840: 54000080     	b.eq	0x40002850 <memset+0x54>
40002844: f1000529     	subs	x9, x9, #0x1
40002848: 38001501     	strb	w1, [x8], #0x1
4000284c: 54ffffc1     	b.ne	0x40002844 <memset+0x48>
40002850: d65f03c0     	ret

0000000040002854 <memcpy>:
40002854: b4000100     	cbz	x0, 0x40002874 <memcpy+0x20>
40002858: b40000e1     	cbz	x1, 0x40002874 <memcpy+0x20>
4000285c: b40000c2     	cbz	x2, 0x40002874 <memcpy+0x20>
40002860: aa0003e8     	mov	x8, x0
40002864: 38401429     	ldrb	w9, [x1], #0x1
40002868: f1000442     	subs	x2, x2, #0x1
4000286c: 38001509     	strb	w9, [x8], #0x1
40002870: 54ffffa1     	b.ne	0x40002864 <memcpy+0x10>
40002874: d65f03c0     	ret

0000000040002878 <kstrstr>:
40002878: aa1f03e2     	mov	x2, xzr
4000287c: b40000e0     	cbz	x0, 0x40002898 <kstrstr+0x20>
40002880: b40000c1     	cbz	x1, 0x40002898 <kstrstr+0x20>
40002884: 39400028     	ldrb	w8, [x1]
40002888: 340002c8     	cbz	w8, 0x400028e0 <kstrstr+0x68>
4000288c: 39400009     	ldrb	w9, [x0]
40002890: 35000109     	cbnz	w9, 0x400028b0 <kstrstr+0x38>
40002894: aa1f03e2     	mov	x2, xzr
40002898: aa0203e0     	mov	x0, x2
4000289c: d65f03c0     	ret
400028a0: 3940012c     	ldrb	w12, [x9]
400028a4: 340001ec     	cbz	w12, 0x400028e0 <kstrstr+0x68>
400028a8: 38401c09     	ldrb	w9, [x0, #0x1]!
400028ac: 34ffff49     	cbz	w9, 0x40002894 <kstrstr+0x1c>
400028b0: 6b08013f     	cmp	w9, w8
400028b4: 54ffffa1     	b.ne	0x400028a8 <kstrstr+0x30>
400028b8: 5280002a     	mov	w10, #0x1               // =1
400028bc: aa0103e9     	mov	x9, x1
400028c0: 2a0803eb     	mov	w11, w8
400028c4: 3840152c     	ldrb	w12, [x9], #0x1
400028c8: 6b0c017f     	cmp	w11, w12
400028cc: 54fffec1     	b.ne	0x400028a4 <kstrstr+0x2c>
400028d0: 386a680b     	ldrb	w11, [x0, x10]
400028d4: 9100054a     	add	x10, x10, #0x1
400028d8: 35ffff6b     	cbnz	w11, 0x400028c4 <kstrstr+0x4c>
400028dc: 17fffff1     	b	0x400028a0 <kstrstr+0x28>
400028e0: d65f03c0     	ret

00000000400028e4 <kstrchr>:
400028e4: b4000140     	cbz	x0, 0x4000290c <kstrchr+0x28>
400028e8: 39400009     	ldrb	w9, [x0]
400028ec: 340000c9     	cbz	w9, 0x40002904 <kstrchr+0x20>
400028f0: 12001c28     	and	w8, w1, #0xff
400028f4: 6b08013f     	cmp	w9, w8
400028f8: 540000a0     	b.eq	0x4000290c <kstrchr+0x28>
400028fc: 38401c09     	ldrb	w9, [x0, #0x1]!
40002900: 35ffffa9     	cbnz	w9, 0x400028f4 <kstrchr+0x10>
40002904: 72001c3f     	tst	w1, #0xff
40002908: 9a9f0000     	csel	x0, x0, xzr, eq
4000290c: d65f03c0     	ret

0000000040002910 <ktolower>:
40002910: 51010408     	sub	w8, w0, #0x41
40002914: 321b0009     	orr	w9, w0, #0x20
40002918: 7100691f     	cmp	w8, #0x1a
4000291c: 1a803120     	csel	w0, w9, w0, lo
40002920: d65f03c0     	ret

0000000040002924 <kstr_tolower>:
40002924: b40001a0     	cbz	x0, 0x40002958 <kstr_tolower+0x34>
40002928: b4000181     	cbz	x1, 0x40002958 <kstr_tolower+0x34>
4000292c: 39400029     	ldrb	w9, [x1]
40002930: 34000129     	cbz	w9, 0x40002954 <kstr_tolower+0x30>
40002934: 91000428     	add	x8, x1, #0x1
40002938: 5101052a     	sub	w10, w9, #0x41
4000293c: 321b012b     	orr	w11, w9, #0x20
40002940: 7100695f     	cmp	w10, #0x1a
40002944: 1a893169     	csel	w9, w11, w9, lo
40002948: 38001409     	strb	w9, [x0], #0x1
4000294c: 38401509     	ldrb	w9, [x8], #0x1
40002950: 35ffff49     	cbnz	w9, 0x40002938 <kstr_tolower+0x14>
40002954: 3900001f     	strb	wzr, [x0]
40002958: d65f03c0     	ret

000000004000295c <tui_launch>:
4000295c: d105c3ff     	sub	sp, sp, #0x170
40002960: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002964: 910443fd     	add	x29, sp, #0x110
40002968: a9126ffc     	stp	x28, x27, [sp, #0x120]
4000296c: a91367fa     	stp	x26, x25, [sp, #0x130]
40002970: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002974: a91557f6     	stp	x22, x21, [sp, #0x150]
40002978: a9164ff4     	stp	x20, x19, [sp, #0x160]
4000297c: 9400074d     	bl	0x400046b0 <vfs_get_cwd>
40002980: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40002984: 9000007c     	adrp	x28, 0x4000e000 <var_values+0x6a8>
40002988: 9000007b     	adrp	x27, 0x4000e000 <var_values+0x6a8>
4000298c: f904ad00     	str	x0, [x8, #0x958]
40002990: d503201f     	nop
40002994: 100274c0     	adr	x0, 0x4000782c <__rodata_start+0x182c>
40002998: b909639f     	str	wzr, [x28, #0x960]
4000299c: b909677f     	str	wzr, [x27, #0x964]
400029a0: 940002c5     	bl	0x400034b4 <uart_puts>
400029a4: 90000036     	adrp	x22, 0x40006000 <__rodata_start>
400029a8: 9111fed6     	add	x22, x22, #0x47f
400029ac: 90000037     	adrp	x23, 0x40006000 <__rodata_start>
400029b0: 910dbef7     	add	x23, x23, #0x36f
400029b4: 90000078     	adrp	x24, 0x4000e000 <var_values+0x6a8>
400029b8: 9125c318     	add	x24, x24, #0x970
400029bc: 9000007a     	adrp	x26, 0x4000e000 <var_values+0x6a8>
400029c0: 90000034     	adrp	x20, 0x40006000 <__rodata_start>
400029c4: 91158294     	add	x20, x20, #0x560
400029c8: 14000005     	b	0x400029dc <tui_launch+0x80>
400029cc: b9496388     	ldr	w8, [x28, #0x960]
400029d0: 7100011f     	cmp	w8, #0x0
400029d4: 1a9f17e8     	cset	w8, eq
400029d8: b9096388     	str	w8, [x28, #0x960]
400029dc: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
400029e0: b9096b5f     	str	wzr, [x26, #0x968]
400029e4: f944ad0a     	ldr	x10, [x8, #0x958]
400029e8: f9421948     	ldr	x8, [x10, #0x430]
400029ec: b4000108     	cbz	x8, 0x40002a0c <tui_launch+0xb0>
400029f0: 52800029     	mov	w9, #0x1                // =1
400029f4: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
400029f8: b9096b49     	str	w9, [x26, #0x968]
400029fc: f904b91f     	str	xzr, [x8, #0x970]
40002a00: f9401548     	ldr	x8, [x10, #0x28]
40002a04: b50000a8     	cbnz	x8, 0x40002a18 <tui_launch+0xbc>
40002a08: 14000027     	b	0x40002aa4 <tui_launch+0x148>
40002a0c: 2a1f03e9     	mov	w9, wzr
40002a10: f9401548     	ldr	x8, [x10, #0x28]
40002a14: b4000488     	cbz	x8, 0x40002aa4 <tui_launch+0x148>
40002a18: 2a0903e9     	mov	w9, w9
40002a1c: d100050c     	sub	x12, x8, #0x1
40002a20: d240152b     	eor	x11, x9, #0x3f
40002a24: eb0b019f     	cmp	x12, x11
40002a28: 9a8b318b     	csel	x11, x12, x11, lo
40002a2c: b400022c     	cbz	x12, 0x40002a70 <tui_launch+0x114>
40002a30: 9100056c     	add	x12, x11, #0x1
40002a34: 8b090f0e     	add	x14, x24, x9, lsl #3
40002a38: 9111014d     	add	x13, x10, #0x440
40002a3c: 927f798b     	and	x11, x12, #0xfffffffe
40002a40: aa090169     	orr	x9, x11, x9
40002a44: 910021ce     	add	x14, x14, #0x8
40002a48: aa0b03ef     	mov	x15, x11
40002a4c: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002a50: f10009ef     	subs	x15, x15, #0x2
40002a54: 910041ad     	add	x13, x13, #0x10
40002a58: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002a5c: 910041ce     	add	x14, x14, #0x10
40002a60: 54ffff61     	b.ne	0x40002a4c <tui_launch+0xf0>
40002a64: eb0b019f     	cmp	x12, x11
40002a68: 54000061     	b.ne	0x40002a74 <tui_launch+0x118>
40002a6c: 1400000d     	b	0x40002aa0 <tui_launch+0x144>
40002a70: aa1f03eb     	mov	x11, xzr
40002a74: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002a78: 9100056b     	add	x11, x11, #0x1
40002a7c: 9110e14a     	add	x10, x10, #0x438
40002a80: f840854c     	ldr	x12, [x10], #0x8
40002a84: f100f93f     	cmp	x9, #0x3e
40002a88: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002a8c: 91000529     	add	x9, x9, #0x1
40002a90: 54000088     	b.hi	0x40002aa0 <tui_launch+0x144>
40002a94: eb08017f     	cmp	x11, x8
40002a98: 9100056b     	add	x11, x11, #0x1
40002a9c: 54ffff23     	b.lo	0x40002a80 <tui_launch+0x124>
40002aa0: b9096b49     	str	w9, [x26, #0x968]
40002aa4: b949676a     	ldr	w10, [x27, #0x964]
40002aa8: 51000528     	sub	w8, w9, #0x1
40002aac: 6b08015f     	cmp	w10, w8
40002ab0: 1a88b148     	csel	w8, w10, w8, lt
40002ab4: 6b09015f     	cmp	w10, w9
40002ab8: 5400004a     	b.ge	0x40002ac0 <tui_launch+0x164>
40002abc: 36f80068     	tbz	w8, #0x1f, 0x40002ac8 <tui_launch+0x16c>
40002ac0: 0aa87d08     	bic	w8, w8, w8, asr #31
40002ac4: b9096768     	str	w8, [x27, #0x964]
40002ac8: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002acc: 91249800     	add	x0, x0, #0x926
40002ad0: 94000279     	bl	0x400034b4 <uart_puts>
40002ad4: b9496388     	ldr	w8, [x28, #0x960]
40002ad8: 52800020     	mov	w0, #0x1                // =1
40002adc: 52800501     	mov	w1, #0x28               // =40
40002ae0: 90000022     	adrp	x2, 0x40006000 <__rodata_start>
40002ae4: 91036442     	add	x2, x2, #0xd9
40002ae8: 7100011f     	cmp	w8, #0x0
40002aec: 1a9f17e3     	cset	w3, eq
40002af0: 94000171     	bl	0x400030b4 <draw_box>
40002af4: 52800075     	mov	w21, #0x3               // =3
40002af8: aa1603e0     	mov	x0, x22
40002afc: 2a1503e1     	mov	w1, w21
40002b00: 52800042     	mov	w2, #0x2                // =2
40002b04: 9400037c     	bl	0x400038f4 <uart_printf>
40002b08: aa1703e0     	mov	x0, x23
40002b0c: 9400026a     	bl	0x400034b4 <uart_puts>
40002b10: aa1703e0     	mov	x0, x23
40002b14: 94000268     	bl	0x400034b4 <uart_puts>
40002b18: aa1703e0     	mov	x0, x23
40002b1c: 94000266     	bl	0x400034b4 <uart_puts>
40002b20: aa1703e0     	mov	x0, x23
40002b24: 94000264     	bl	0x400034b4 <uart_puts>
40002b28: aa1703e0     	mov	x0, x23
40002b2c: 94000262     	bl	0x400034b4 <uart_puts>
40002b30: aa1703e0     	mov	x0, x23
40002b34: 94000260     	bl	0x400034b4 <uart_puts>
40002b38: aa1703e0     	mov	x0, x23
40002b3c: 9400025e     	bl	0x400034b4 <uart_puts>
40002b40: aa1703e0     	mov	x0, x23
40002b44: 9400025c     	bl	0x400034b4 <uart_puts>
40002b48: aa1703e0     	mov	x0, x23
40002b4c: 9400025a     	bl	0x400034b4 <uart_puts>
40002b50: aa1703e0     	mov	x0, x23
40002b54: 94000258     	bl	0x400034b4 <uart_puts>
40002b58: aa1703e0     	mov	x0, x23
40002b5c: 94000256     	bl	0x400034b4 <uart_puts>
40002b60: aa1703e0     	mov	x0, x23
40002b64: 94000254     	bl	0x400034b4 <uart_puts>
40002b68: aa1703e0     	mov	x0, x23
40002b6c: 94000252     	bl	0x400034b4 <uart_puts>
40002b70: aa1703e0     	mov	x0, x23
40002b74: 94000250     	bl	0x400034b4 <uart_puts>
40002b78: aa1703e0     	mov	x0, x23
40002b7c: 9400024e     	bl	0x400034b4 <uart_puts>
40002b80: aa1703e0     	mov	x0, x23
40002b84: 9400024c     	bl	0x400034b4 <uart_puts>
40002b88: aa1703e0     	mov	x0, x23
40002b8c: 9400024a     	bl	0x400034b4 <uart_puts>
40002b90: aa1703e0     	mov	x0, x23
40002b94: 94000248     	bl	0x400034b4 <uart_puts>
40002b98: aa1703e0     	mov	x0, x23
40002b9c: 94000246     	bl	0x400034b4 <uart_puts>
40002ba0: aa1703e0     	mov	x0, x23
40002ba4: 94000244     	bl	0x400034b4 <uart_puts>
40002ba8: aa1703e0     	mov	x0, x23
40002bac: 94000242     	bl	0x400034b4 <uart_puts>
40002bb0: aa1703e0     	mov	x0, x23
40002bb4: 94000240     	bl	0x400034b4 <uart_puts>
40002bb8: aa1703e0     	mov	x0, x23
40002bbc: 9400023e     	bl	0x400034b4 <uart_puts>
40002bc0: aa1703e0     	mov	x0, x23
40002bc4: 9400023c     	bl	0x400034b4 <uart_puts>
40002bc8: aa1703e0     	mov	x0, x23
40002bcc: 9400023a     	bl	0x400034b4 <uart_puts>
40002bd0: aa1703e0     	mov	x0, x23
40002bd4: 94000238     	bl	0x400034b4 <uart_puts>
40002bd8: aa1703e0     	mov	x0, x23
40002bdc: 94000236     	bl	0x400034b4 <uart_puts>
40002be0: aa1703e0     	mov	x0, x23
40002be4: 94000234     	bl	0x400034b4 <uart_puts>
40002be8: aa1703e0     	mov	x0, x23
40002bec: 94000232     	bl	0x400034b4 <uart_puts>
40002bf0: aa1703e0     	mov	x0, x23
40002bf4: 94000230     	bl	0x400034b4 <uart_puts>
40002bf8: aa1703e0     	mov	x0, x23
40002bfc: 9400022e     	bl	0x400034b4 <uart_puts>
40002c00: aa1703e0     	mov	x0, x23
40002c04: 9400022c     	bl	0x400034b4 <uart_puts>
40002c08: aa1703e0     	mov	x0, x23
40002c0c: 9400022a     	bl	0x400034b4 <uart_puts>
40002c10: aa1703e0     	mov	x0, x23
40002c14: 94000228     	bl	0x400034b4 <uart_puts>
40002c18: aa1703e0     	mov	x0, x23
40002c1c: 94000226     	bl	0x400034b4 <uart_puts>
40002c20: aa1703e0     	mov	x0, x23
40002c24: 94000224     	bl	0x400034b4 <uart_puts>
40002c28: aa1703e0     	mov	x0, x23
40002c2c: 94000222     	bl	0x400034b4 <uart_puts>
40002c30: aa1703e0     	mov	x0, x23
40002c34: 94000220     	bl	0x400034b4 <uart_puts>
40002c38: 110006b5     	add	w21, w21, #0x1
40002c3c: 71005ebf     	cmp	w21, #0x17
40002c40: 54fff5c1     	b.ne	0x40002af8 <tui_launch+0x19c>
40002c44: b9496768     	ldr	w8, [x27, #0x964]
40002c48: 52800249     	mov	w9, #0x12               // =18
40002c4c: 7100491f     	cmp	w8, #0x12
40002c50: 1a89c108     	csel	w8, w8, w9, gt
40002c54: 51004915     	sub	w21, w8, #0x12
40002c58: 8b354f19     	add	x25, x24, w21, uxtw #3
40002c5c: aa1f03f8     	mov	x24, xzr
40002c60: 14000004     	b	0x40002c70 <tui_launch+0x314>
40002c64: 91000718     	add	x24, x24, #0x1
40002c68: f100531f     	cmp	x24, #0x14
40002c6c: 540005a0     	b.eq	0x40002d20 <tui_launch+0x3c4>
40002c70: b9896b48     	ldrsw	x8, [x26, #0x968]
40002c74: 8b1802b3     	add	x19, x21, x24
40002c78: eb08027f     	cmp	x19, x8
40002c7c: 5400052a     	b.ge	0x40002d20 <tui_launch+0x3c4>
40002c80: 11000f01     	add	w1, w24, #0x3
40002c84: aa1603e0     	mov	x0, x22
40002c88: 52800062     	mov	w2, #0x3                // =3
40002c8c: 9400031a     	bl	0x400038f4 <uart_printf>
40002c90: b9496768     	ldr	w8, [x27, #0x964]
40002c94: eb08027f     	cmp	x19, x8
40002c98: 540000c1     	b.ne	0x40002cb0 <tui_launch+0x354>
40002c9c: b9496388     	ldr	w8, [x28, #0x960]
40002ca0: 35000088     	cbnz	w8, 0x40002cb0 <tui_launch+0x354>
40002ca4: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002ca8: 9104a400     	add	x0, x0, #0x129
40002cac: 94000202     	bl	0x400034b4 <uart_puts>
40002cb0: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002cb4: b40001e8     	cbz	x8, 0x40002cf0 <tui_launch+0x394>
40002cb8: b9402108     	ldr	w8, [x8, #0x20]
40002cbc: b0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40002cc0: 910ac529     	add	x9, x9, #0x2b1
40002cc4: 910223e0     	add	x0, sp, #0x88
40002cc8: 7100051f     	cmp	w8, #0x1
40002ccc: 90000028     	adrp	x8, 0x40006000 <__rodata_start>
40002cd0: 91372d08     	add	x8, x8, #0xdcb
40002cd4: 9a880121     	csel	x1, x9, x8, eq
40002cd8: 97fffe9d     	bl	0x4000274c <kstrcpy>
40002cdc: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002ce0: 910223e0     	add	x0, sp, #0x88
40002ce4: 97fffe72     	bl	0x400026ac <kstrcat>
40002ce8: 910223e0     	add	x0, sp, #0x88
40002cec: 14000003     	b	0x40002cf8 <tui_launch+0x39c>
40002cf0: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002cf4: 91320c00     	add	x0, x0, #0xc83
40002cf8: 940001ef     	bl	0x400034b4 <uart_puts>
40002cfc: b9496768     	ldr	w8, [x27, #0x964]
40002d00: eb08027f     	cmp	x19, x8
40002d04: 54fffb01     	b.ne	0x40002c64 <tui_launch+0x308>
40002d08: b9496388     	ldr	w8, [x28, #0x960]
40002d0c: 35fffac8     	cbnz	w8, 0x40002c64 <tui_launch+0x308>
40002d10: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40002d14: 9129f800     	add	x0, x0, #0xa7e
40002d18: 940001e7     	bl	0x400034b4 <uart_puts>
40002d1c: 17ffffd2     	b	0x40002c64 <tui_launch+0x308>
40002d20: b9496388     	ldr	w8, [x28, #0x960]
40002d24: 52800540     	mov	w0, #0x2a               // =42
40002d28: 528004c1     	mov	w1, #0x26               // =38
40002d2c: b0000022     	adrp	x2, 0x40007000 <__rodata_start+0x1000>
40002d30: 91042442     	add	x2, x2, #0x109
40002d34: 7100051f     	cmp	w8, #0x1
40002d38: 1a9f17e3     	cset	w3, eq
40002d3c: 940000de     	bl	0x400030b4 <draw_box>
40002d40: 52800075     	mov	w21, #0x3               // =3
40002d44: aa1603e0     	mov	x0, x22
40002d48: 2a1503e1     	mov	w1, w21
40002d4c: 52800562     	mov	w2, #0x2b               // =43
40002d50: 940002e9     	bl	0x400038f4 <uart_printf>
40002d54: aa1703e0     	mov	x0, x23
40002d58: 940001d7     	bl	0x400034b4 <uart_puts>
40002d5c: aa1703e0     	mov	x0, x23
40002d60: 940001d5     	bl	0x400034b4 <uart_puts>
40002d64: aa1703e0     	mov	x0, x23
40002d68: 940001d3     	bl	0x400034b4 <uart_puts>
40002d6c: aa1703e0     	mov	x0, x23
40002d70: 940001d1     	bl	0x400034b4 <uart_puts>
40002d74: aa1703e0     	mov	x0, x23
40002d78: 940001cf     	bl	0x400034b4 <uart_puts>
40002d7c: aa1703e0     	mov	x0, x23
40002d80: 940001cd     	bl	0x400034b4 <uart_puts>
40002d84: aa1703e0     	mov	x0, x23
40002d88: 940001cb     	bl	0x400034b4 <uart_puts>
40002d8c: aa1703e0     	mov	x0, x23
40002d90: 940001c9     	bl	0x400034b4 <uart_puts>
40002d94: aa1703e0     	mov	x0, x23
40002d98: 940001c7     	bl	0x400034b4 <uart_puts>
40002d9c: aa1703e0     	mov	x0, x23
40002da0: 940001c5     	bl	0x400034b4 <uart_puts>
40002da4: aa1703e0     	mov	x0, x23
40002da8: 940001c3     	bl	0x400034b4 <uart_puts>
40002dac: aa1703e0     	mov	x0, x23
40002db0: 940001c1     	bl	0x400034b4 <uart_puts>
40002db4: aa1703e0     	mov	x0, x23
40002db8: 940001bf     	bl	0x400034b4 <uart_puts>
40002dbc: aa1703e0     	mov	x0, x23
40002dc0: 940001bd     	bl	0x400034b4 <uart_puts>
40002dc4: aa1703e0     	mov	x0, x23
40002dc8: 940001bb     	bl	0x400034b4 <uart_puts>
40002dcc: aa1703e0     	mov	x0, x23
40002dd0: 940001b9     	bl	0x400034b4 <uart_puts>
40002dd4: aa1703e0     	mov	x0, x23
40002dd8: 940001b7     	bl	0x400034b4 <uart_puts>
40002ddc: aa1703e0     	mov	x0, x23
40002de0: 940001b5     	bl	0x400034b4 <uart_puts>
40002de4: aa1703e0     	mov	x0, x23
40002de8: 940001b3     	bl	0x400034b4 <uart_puts>
40002dec: aa1703e0     	mov	x0, x23
40002df0: 940001b1     	bl	0x400034b4 <uart_puts>
40002df4: aa1703e0     	mov	x0, x23
40002df8: 940001af     	bl	0x400034b4 <uart_puts>
40002dfc: aa1703e0     	mov	x0, x23
40002e00: 940001ad     	bl	0x400034b4 <uart_puts>
40002e04: aa1703e0     	mov	x0, x23
40002e08: 940001ab     	bl	0x400034b4 <uart_puts>
40002e0c: aa1703e0     	mov	x0, x23
40002e10: 940001a9     	bl	0x400034b4 <uart_puts>
40002e14: aa1703e0     	mov	x0, x23
40002e18: 940001a7     	bl	0x400034b4 <uart_puts>
40002e1c: aa1703e0     	mov	x0, x23
40002e20: 940001a5     	bl	0x400034b4 <uart_puts>
40002e24: aa1703e0     	mov	x0, x23
40002e28: 940001a3     	bl	0x400034b4 <uart_puts>
40002e2c: aa1703e0     	mov	x0, x23
40002e30: 940001a1     	bl	0x400034b4 <uart_puts>
40002e34: aa1703e0     	mov	x0, x23
40002e38: 9400019f     	bl	0x400034b4 <uart_puts>
40002e3c: aa1703e0     	mov	x0, x23
40002e40: 9400019d     	bl	0x400034b4 <uart_puts>
40002e44: aa1703e0     	mov	x0, x23
40002e48: 9400019b     	bl	0x400034b4 <uart_puts>
40002e4c: aa1703e0     	mov	x0, x23
40002e50: 94000199     	bl	0x400034b4 <uart_puts>
40002e54: aa1703e0     	mov	x0, x23
40002e58: 94000197     	bl	0x400034b4 <uart_puts>
40002e5c: aa1703e0     	mov	x0, x23
40002e60: 94000195     	bl	0x400034b4 <uart_puts>
40002e64: aa1703e0     	mov	x0, x23
40002e68: 94000193     	bl	0x400034b4 <uart_puts>
40002e6c: aa1703e0     	mov	x0, x23
40002e70: 94000191     	bl	0x400034b4 <uart_puts>
40002e74: 110006b5     	add	w21, w21, #0x1
40002e78: 71005ebf     	cmp	w21, #0x17
40002e7c: 54fff641     	b.ne	0x40002d44 <tui_launch+0x3e8>
40002e80: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002e84: 91178c00     	add	x0, x0, #0x5e3
40002e88: 52800061     	mov	w1, #0x3                // =3
40002e8c: 52800562     	mov	w2, #0x2b               // =43
40002e90: 94000299     	bl	0x400038f4 <uart_printf>
40002e94: d503201f     	nop
40002e98: 10051de8     	adr	x8, 0x4000d254 <proc_table>
40002e9c: aa1f03f3     	mov	x19, xzr
40002ea0: 9100a115     	add	x21, x8, #0x28
40002ea4: 52800058     	mov	w24, #0x2               // =2
40002ea8: 90000039     	adrp	x25, 0x40006000 <__rodata_start>
40002eac: 91202339     	add	x25, x25, #0x808
40002eb0: b85fc2a8     	ldur	w8, [x21, #-0x4]
40002eb4: 71000d1f     	cmp	w8, #0x3
40002eb8: 54000140     	b.eq	0x40002ee0 <tui_launch+0x584>
40002ebc: b94002a8     	ldr	w8, [x21]
40002ec0: b85d82a3     	ldur	w3, [x21, #-0x28]
40002ec4: d10092a4     	sub	x4, x21, #0x24
40002ec8: 11000b01     	add	w1, w24, #0x2
40002ecc: aa1403e0     	mov	x0, x20
40002ed0: 52800562     	mov	w2, #0x2b               // =43
40002ed4: 530a7d05     	lsr	w5, w8, #10
40002ed8: 94000287     	bl	0x400038f4 <uart_printf>
40002edc: 11000718     	add	w24, w24, #0x1
40002ee0: f1003a7f     	cmp	x19, #0xe
40002ee4: 540000a8     	b.hi	0x40002ef8 <tui_launch+0x59c>
40002ee8: 7100531f     	cmp	w24, #0x14
40002eec: 91000673     	add	x19, x19, #0x1
40002ef0: 9100c2b5     	add	x21, x21, #0x30
40002ef4: 54fffdeb     	b.lt	0x40002eb0 <tui_launch+0x554>
40002ef8: 940001a2     	bl	0x40003580 <uart_getc>
40002efc: 52801be8     	mov	w8, #0xdf               // =223
40002f00: 0a080008     	and	w8, w0, w8
40002f04: 7101451f     	cmp	w8, #0x51
40002f08: 54000c00     	b.eq	0x40003088 <tui_launch+0x72c>
40002f0c: 12001c08     	and	w8, w0, #0xff
40002f10: 7100311f     	cmp	w8, #0xc
40002f14: 5400010c     	b.gt	0x40002f34 <tui_launch+0x5d8>
40002f18: 7100251f     	cmp	w8, #0x9
40002f1c: 90000078     	adrp	x24, 0x4000e000 <var_values+0x6a8>
40002f20: 9125c318     	add	x24, x24, #0x970
40002f24: 54ffd540     	b.eq	0x400029cc <tui_launch+0x70>
40002f28: 7100291f     	cmp	w8, #0xa
40002f2c: 540002e0     	b.eq	0x40002f88 <tui_launch+0x62c>
40002f30: 17fffeab     	b	0x400029dc <tui_launch+0x80>
40002f34: 7100351f     	cmp	w8, #0xd
40002f38: 90000078     	adrp	x24, 0x4000e000 <var_values+0x6a8>
40002f3c: 9125c318     	add	x24, x24, #0x970
40002f40: 54000240     	b.eq	0x40002f88 <tui_launch+0x62c>
40002f44: 71006d1f     	cmp	w8, #0x1b
40002f48: 54ffd4a1     	b.ne	0x400029dc <tui_launch+0x80>
40002f4c: 9400018d     	bl	0x40003580 <uart_getc>
40002f50: 12001c13     	and	w19, w0, #0xff
40002f54: 9400018b     	bl	0x40003580 <uart_getc>
40002f58: 71016e7f     	cmp	w19, #0x5b
40002f5c: 54ffd401     	b.ne	0x400029dc <tui_launch+0x80>
40002f60: 12001c08     	and	w8, w0, #0xff
40002f64: 7101051f     	cmp	w8, #0x41
40002f68: 54000781     	b.ne	0x40003058 <tui_launch+0x6fc>
40002f6c: b9496388     	ldr	w8, [x28, #0x960]
40002f70: 35ffd368     	cbnz	w8, 0x400029dc <tui_launch+0x80>
40002f74: b9496768     	ldr	w8, [x27, #0x964]
40002f78: 71000508     	subs	w8, w8, #0x1
40002f7c: 54ffd30b     	b.lt	0x400029dc <tui_launch+0x80>
40002f80: b9096768     	str	w8, [x27, #0x964]
40002f84: 17fffe96     	b	0x400029dc <tui_launch+0x80>
40002f88: b9496388     	ldr	w8, [x28, #0x960]
40002f8c: 35ffd288     	cbnz	w8, 0x400029dc <tui_launch+0x80>
40002f90: b9496b48     	ldr	w8, [x26, #0x968]
40002f94: 7100051f     	cmp	w8, #0x1
40002f98: 54ffd22b     	b.lt	0x400029dc <tui_launch+0x80>
40002f9c: b9896768     	ldrsw	x8, [x27, #0x964]
40002fa0: f8687b15     	ldr	x21, [x24, x8, lsl #3]
40002fa4: b4000115     	cbz	x21, 0x40002fc4 <tui_launch+0x668>
40002fa8: b94022a8     	ldr	w8, [x21, #0x20]
40002fac: 7100051f     	cmp	w8, #0x1
40002fb0: 54000161     	b.ne	0x40002fdc <tui_launch+0x680>
40002fb4: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40002fb8: b909677f     	str	wzr, [x27, #0x964]
40002fbc: f904ad15     	str	x21, [x8, #0x958]
40002fc0: 17fffe87     	b	0x400029dc <tui_launch+0x80>
40002fc4: 90000069     	adrp	x9, 0x4000e000 <var_values+0x6a8>
40002fc8: b909677f     	str	wzr, [x27, #0x964]
40002fcc: f944ad28     	ldr	x8, [x9, #0x958]
40002fd0: f9421908     	ldr	x8, [x8, #0x430]
40002fd4: f904ad28     	str	x8, [x9, #0x958]
40002fd8: 17fffe81     	b	0x400029dc <tui_launch+0x80>
40002fdc: 390223ff     	strb	wzr, [sp, #0x88]
40002fe0: aa1903e0     	mov	x0, x25
40002fe4: 94000604     	bl	0x400047f4 <vfs_find>
40002fe8: eb0002bf     	cmp	x21, x0
40002fec: 540001e0     	b.eq	0x40003028 <tui_launch+0x6cc>
40002ff0: 910023e0     	add	x0, sp, #0x8
40002ff4: 910223e1     	add	x1, sp, #0x88
40002ff8: 97fffdd5     	bl	0x4000274c <kstrcpy>
40002ffc: 910223e0     	add	x0, sp, #0x88
40003000: aa1903e1     	mov	x1, x25
40003004: 97fffdd2     	bl	0x4000274c <kstrcpy>
40003008: 910223e0     	add	x0, sp, #0x88
4000300c: aa1503e1     	mov	x1, x21
40003010: 97fffda7     	bl	0x400026ac <kstrcat>
40003014: 910223e0     	add	x0, sp, #0x88
40003018: 910023e1     	add	x1, sp, #0x8
4000301c: 97fffda4     	bl	0x400026ac <kstrcat>
40003020: f9421ab5     	ldr	x21, [x21, #0x430]
40003024: b5fffdf5     	cbnz	x21, 0x40002fe0 <tui_launch+0x684>
40003028: 910223e0     	add	x0, sp, #0x88
4000302c: 97fffd99     	bl	0x40002690 <kstrlen>
40003030: b5000080     	cbnz	x0, 0x40003040 <tui_launch+0x6e4>
40003034: 910223e0     	add	x0, sp, #0x88
40003038: aa1903e1     	mov	x1, x25
4000303c: 97fffdc4     	bl	0x4000274c <kstrcpy>
40003040: 910223e0     	add	x0, sp, #0x88
40003044: 97fff456     	bl	0x4000019c <launch_kedit>
40003048: d503201f     	nop
4000304c: 10023f00     	adr	x0, 0x4000782c <__rodata_start+0x182c>
40003050: 94000119     	bl	0x400034b4 <uart_puts>
40003054: 17fffe62     	b	0x400029dc <tui_launch+0x80>
40003058: 7101091f     	cmp	w8, #0x42
4000305c: 54ffcc01     	b.ne	0x400029dc <tui_launch+0x80>
40003060: b9496388     	ldr	w8, [x28, #0x960]
40003064: 35ffcbc8     	cbnz	w8, 0x400029dc <tui_launch+0x80>
40003068: b9496b49     	ldr	w9, [x26, #0x968]
4000306c: b9496768     	ldr	w8, [x27, #0x964]
40003070: 51000529     	sub	w9, w9, #0x1
40003074: 6b09011f     	cmp	w8, w9
40003078: 54ffcb2a     	b.ge	0x400029dc <tui_launch+0x80>
4000307c: 11000508     	add	w8, w8, #0x1
40003080: b9096768     	str	w8, [x27, #0x964]
40003084: 17fffe56     	b	0x400029dc <tui_launch+0x80>
40003088: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
4000308c: 912da400     	add	x0, x0, #0xb69
40003090: 94000109     	bl	0x400034b4 <uart_puts>
40003094: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003098: a95557f6     	ldp	x22, x21, [sp, #0x150]
4000309c: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400030a0: a95367fa     	ldp	x26, x25, [sp, #0x130]
400030a4: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400030a8: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400030ac: 9105c3ff     	add	sp, sp, #0x170
400030b0: d65f03c0     	ret

00000000400030b4 <draw_box>:
400030b4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400030b8: b0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400030bc: 91138908     	add	x8, x8, #0x4e2
400030c0: 7100007f     	cmp	w3, #0x0
400030c4: 90000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
400030c8: 9107ad29     	add	x9, x9, #0x1eb
400030cc: a9034ff4     	stp	x20, x19, [sp, #0x30]
400030d0: 2a0003f3     	mov	w19, w0
400030d4: 9a880120     	csel	x0, x9, x8, eq
400030d8: a9015ff8     	stp	x24, x23, [sp, #0x10]
400030dc: a90257f6     	stp	x22, x21, [sp, #0x20]
400030e0: 910003fd     	mov	x29, sp
400030e4: aa0203f4     	mov	x20, x2
400030e8: 2a0103f5     	mov	w21, w1
400030ec: 940000f2     	bl	0x400034b4 <uart_puts>
400030f0: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400030f4: 91202800     	add	x0, x0, #0x80a
400030f8: 52800041     	mov	w1, #0x2                // =2
400030fc: 2a1303e2     	mov	w2, w19
40003100: 940001fd     	bl	0x400038f4 <uart_printf>
40003104: 51000ab6     	sub	w22, w21, #0x2
40003108: 510006b7     	sub	w23, w21, #0x1
4000310c: f0000015     	adrp	x21, 0x40006000 <__rodata_start>
40003110: 911572b5     	add	x21, x21, #0x55c
40003114: 2a1603f8     	mov	w24, w22
40003118: aa1503e0     	mov	x0, x21
4000311c: 940000e6     	bl	0x400034b4 <uart_puts>
40003120: 71000718     	subs	w24, w24, #0x1
40003124: 54ffffa1     	b.ne	0x40003118 <draw_box+0x64>
40003128: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
4000312c: 91278400     	add	x0, x0, #0x9e1
40003130: 940000e1     	bl	0x400034b4 <uart_puts>
40003134: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003138: 91205800     	add	x0, x0, #0x816
4000313c: 11000a62     	add	w2, w19, #0x2
40003140: 52800041     	mov	w1, #0x2                // =2
40003144: aa1403e3     	mov	x3, x20
40003148: 940001eb     	bl	0x400038f4 <uart_printf>
4000314c: 90000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40003150: 91148e94     	add	x20, x20, #0x523
40003154: 52800061     	mov	w1, #0x3                // =3
40003158: aa1403e0     	mov	x0, x20
4000315c: 2a1303e2     	mov	w2, w19
40003160: 940001e5     	bl	0x400038f4 <uart_printf>
40003164: 0b1302e2     	add	w2, w23, w19
40003168: aa1403e0     	mov	x0, x20
4000316c: 52800061     	mov	w1, #0x3                // =3
40003170: 940001e1     	bl	0x400038f4 <uart_printf>
40003174: aa1403e0     	mov	x0, x20
40003178: 52800081     	mov	w1, #0x4                // =4
4000317c: 2a1303e2     	mov	w2, w19
40003180: 940001dd     	bl	0x400038f4 <uart_printf>
40003184: 0b1302e2     	add	w2, w23, w19
40003188: aa1403e0     	mov	x0, x20
4000318c: 52800081     	mov	w1, #0x4                // =4
40003190: 940001d9     	bl	0x400038f4 <uart_printf>
40003194: aa1403e0     	mov	x0, x20
40003198: 528000a1     	mov	w1, #0x5                // =5
4000319c: 2a1303e2     	mov	w2, w19
400031a0: 940001d5     	bl	0x400038f4 <uart_printf>
400031a4: 0b1302e2     	add	w2, w23, w19
400031a8: aa1403e0     	mov	x0, x20
400031ac: 528000a1     	mov	w1, #0x5                // =5
400031b0: 940001d1     	bl	0x400038f4 <uart_printf>
400031b4: aa1403e0     	mov	x0, x20
400031b8: 528000c1     	mov	w1, #0x6                // =6
400031bc: 2a1303e2     	mov	w2, w19
400031c0: 940001cd     	bl	0x400038f4 <uart_printf>
400031c4: 0b1302e2     	add	w2, w23, w19
400031c8: aa1403e0     	mov	x0, x20
400031cc: 528000c1     	mov	w1, #0x6                // =6
400031d0: 940001c9     	bl	0x400038f4 <uart_printf>
400031d4: aa1403e0     	mov	x0, x20
400031d8: 528000e1     	mov	w1, #0x7                // =7
400031dc: 2a1303e2     	mov	w2, w19
400031e0: 940001c5     	bl	0x400038f4 <uart_printf>
400031e4: 0b1302e2     	add	w2, w23, w19
400031e8: aa1403e0     	mov	x0, x20
400031ec: 528000e1     	mov	w1, #0x7                // =7
400031f0: 940001c1     	bl	0x400038f4 <uart_printf>
400031f4: aa1403e0     	mov	x0, x20
400031f8: 52800101     	mov	w1, #0x8                // =8
400031fc: 2a1303e2     	mov	w2, w19
40003200: 940001bd     	bl	0x400038f4 <uart_printf>
40003204: 0b1302e2     	add	w2, w23, w19
40003208: aa1403e0     	mov	x0, x20
4000320c: 52800101     	mov	w1, #0x8                // =8
40003210: 940001b9     	bl	0x400038f4 <uart_printf>
40003214: aa1403e0     	mov	x0, x20
40003218: 52800121     	mov	w1, #0x9                // =9
4000321c: 2a1303e2     	mov	w2, w19
40003220: 940001b5     	bl	0x400038f4 <uart_printf>
40003224: 0b1302e2     	add	w2, w23, w19
40003228: aa1403e0     	mov	x0, x20
4000322c: 52800121     	mov	w1, #0x9                // =9
40003230: 940001b1     	bl	0x400038f4 <uart_printf>
40003234: aa1403e0     	mov	x0, x20
40003238: 52800141     	mov	w1, #0xa                // =10
4000323c: 2a1303e2     	mov	w2, w19
40003240: 940001ad     	bl	0x400038f4 <uart_printf>
40003244: 0b1302e2     	add	w2, w23, w19
40003248: aa1403e0     	mov	x0, x20
4000324c: 52800141     	mov	w1, #0xa                // =10
40003250: 940001a9     	bl	0x400038f4 <uart_printf>
40003254: aa1403e0     	mov	x0, x20
40003258: 52800161     	mov	w1, #0xb                // =11
4000325c: 2a1303e2     	mov	w2, w19
40003260: 940001a5     	bl	0x400038f4 <uart_printf>
40003264: 0b1302e2     	add	w2, w23, w19
40003268: aa1403e0     	mov	x0, x20
4000326c: 52800161     	mov	w1, #0xb                // =11
40003270: 940001a1     	bl	0x400038f4 <uart_printf>
40003274: aa1403e0     	mov	x0, x20
40003278: 52800181     	mov	w1, #0xc                // =12
4000327c: 2a1303e2     	mov	w2, w19
40003280: 9400019d     	bl	0x400038f4 <uart_printf>
40003284: 0b1302e2     	add	w2, w23, w19
40003288: aa1403e0     	mov	x0, x20
4000328c: 52800181     	mov	w1, #0xc                // =12
40003290: 94000199     	bl	0x400038f4 <uart_printf>
40003294: aa1403e0     	mov	x0, x20
40003298: 528001a1     	mov	w1, #0xd                // =13
4000329c: 2a1303e2     	mov	w2, w19
400032a0: 94000195     	bl	0x400038f4 <uart_printf>
400032a4: 0b1302e2     	add	w2, w23, w19
400032a8: aa1403e0     	mov	x0, x20
400032ac: 528001a1     	mov	w1, #0xd                // =13
400032b0: 94000191     	bl	0x400038f4 <uart_printf>
400032b4: aa1403e0     	mov	x0, x20
400032b8: 528001c1     	mov	w1, #0xe                // =14
400032bc: 2a1303e2     	mov	w2, w19
400032c0: 9400018d     	bl	0x400038f4 <uart_printf>
400032c4: 0b1302e2     	add	w2, w23, w19
400032c8: aa1403e0     	mov	x0, x20
400032cc: 528001c1     	mov	w1, #0xe                // =14
400032d0: 94000189     	bl	0x400038f4 <uart_printf>
400032d4: aa1403e0     	mov	x0, x20
400032d8: 528001e1     	mov	w1, #0xf                // =15
400032dc: 2a1303e2     	mov	w2, w19
400032e0: 94000185     	bl	0x400038f4 <uart_printf>
400032e4: 0b1302e2     	add	w2, w23, w19
400032e8: aa1403e0     	mov	x0, x20
400032ec: 528001e1     	mov	w1, #0xf                // =15
400032f0: 94000181     	bl	0x400038f4 <uart_printf>
400032f4: aa1403e0     	mov	x0, x20
400032f8: 52800201     	mov	w1, #0x10               // =16
400032fc: 2a1303e2     	mov	w2, w19
40003300: 9400017d     	bl	0x400038f4 <uart_printf>
40003304: 0b1302e2     	add	w2, w23, w19
40003308: aa1403e0     	mov	x0, x20
4000330c: 52800201     	mov	w1, #0x10               // =16
40003310: 94000179     	bl	0x400038f4 <uart_printf>
40003314: aa1403e0     	mov	x0, x20
40003318: 52800221     	mov	w1, #0x11               // =17
4000331c: 2a1303e2     	mov	w2, w19
40003320: 94000175     	bl	0x400038f4 <uart_printf>
40003324: 0b1302e2     	add	w2, w23, w19
40003328: aa1403e0     	mov	x0, x20
4000332c: 52800221     	mov	w1, #0x11               // =17
40003330: 94000171     	bl	0x400038f4 <uart_printf>
40003334: aa1403e0     	mov	x0, x20
40003338: 52800241     	mov	w1, #0x12               // =18
4000333c: 2a1303e2     	mov	w2, w19
40003340: 9400016d     	bl	0x400038f4 <uart_printf>
40003344: 0b1302e2     	add	w2, w23, w19
40003348: aa1403e0     	mov	x0, x20
4000334c: 52800241     	mov	w1, #0x12               // =18
40003350: 94000169     	bl	0x400038f4 <uart_printf>
40003354: aa1403e0     	mov	x0, x20
40003358: 52800261     	mov	w1, #0x13               // =19
4000335c: 2a1303e2     	mov	w2, w19
40003360: 94000165     	bl	0x400038f4 <uart_printf>
40003364: 0b1302e2     	add	w2, w23, w19
40003368: aa1403e0     	mov	x0, x20
4000336c: 52800261     	mov	w1, #0x13               // =19
40003370: 94000161     	bl	0x400038f4 <uart_printf>
40003374: aa1403e0     	mov	x0, x20
40003378: 52800281     	mov	w1, #0x14               // =20
4000337c: 2a1303e2     	mov	w2, w19
40003380: 9400015d     	bl	0x400038f4 <uart_printf>
40003384: 0b1302e2     	add	w2, w23, w19
40003388: aa1403e0     	mov	x0, x20
4000338c: 52800281     	mov	w1, #0x14               // =20
40003390: 94000159     	bl	0x400038f4 <uart_printf>
40003394: aa1403e0     	mov	x0, x20
40003398: 528002a1     	mov	w1, #0x15               // =21
4000339c: 2a1303e2     	mov	w2, w19
400033a0: 94000155     	bl	0x400038f4 <uart_printf>
400033a4: 0b1302e2     	add	w2, w23, w19
400033a8: aa1403e0     	mov	x0, x20
400033ac: 528002a1     	mov	w1, #0x15               // =21
400033b0: 94000151     	bl	0x400038f4 <uart_printf>
400033b4: aa1403e0     	mov	x0, x20
400033b8: 528002c1     	mov	w1, #0x16               // =22
400033bc: 2a1303e2     	mov	w2, w19
400033c0: 9400014d     	bl	0x400038f4 <uart_printf>
400033c4: 0b1302e2     	add	w2, w23, w19
400033c8: aa1403e0     	mov	x0, x20
400033cc: 528002c1     	mov	w1, #0x16               // =22
400033d0: 94000149     	bl	0x400038f4 <uart_printf>
400033d4: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400033d8: 91174c00     	add	x0, x0, #0x5d3
400033dc: 528002e1     	mov	w1, #0x17               // =23
400033e0: 2a1303e2     	mov	w2, w19
400033e4: 94000144     	bl	0x400038f4 <uart_printf>
400033e8: f0000013     	adrp	x19, 0x40006000 <__rodata_start>
400033ec: 91157273     	add	x19, x19, #0x55c
400033f0: aa1303e0     	mov	x0, x19
400033f4: 94000030     	bl	0x400034b4 <uart_puts>
400033f8: 710006d6     	subs	w22, w22, #0x1
400033fc: 54ffffa1     	b.ne	0x400033f0 <draw_box+0x33c>
40003400: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003404: 91177c00     	add	x0, x0, #0x5df
40003408: 9400002b     	bl	0x400034b4 <uart_puts>
4000340c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003410: 90000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40003414: 9129f800     	add	x0, x0, #0xa7e
40003418: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000341c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003420: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003424: 14000024     	b	0x400034b4 <uart_puts>

0000000040003428 <uart_init>:
40003428: 52800608     	mov	w8, #0x30               // =48
4000342c: 528001a9     	mov	w9, #0xd                // =13
40003430: 5280002a     	mov	w10, #0x1               // =1
40003434: 72a12008     	movk	w8, #0x900, lsl #16
40003438: b900011f     	str	wzr, [x8]
4000343c: b81f4109     	stur	w9, [x8, #-0xc]
40003440: 52800e09     	mov	w9, #0x70               // =112
40003444: b81f810a     	stur	w10, [x8, #-0x8]
40003448: b81fc109     	stur	w9, [x8, #-0x4]
4000344c: 52806029     	mov	w9, #0x301              // =769
40003450: b9000109     	str	w9, [x8]
40003454: d65f03c0     	ret

0000000040003458 <uart_putc>:
40003458: f0000048     	adrp	x8, 0x4000e000 <var_values+0x6a8>
4000345c: b94b7108     	ldr	w8, [x8, #0xb70]
40003460: 340001a8     	cbz	w8, 0x40003494 <uart_putc+0x3c>
40003464: f0000048     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40003468: 5287ffca     	mov	w10, #0x3ffe            // =16382
4000346c: b94b7509     	ldr	w9, [x8, #0xb74]
40003470: 6b0a013f     	cmp	w9, w10
40003474: 5400010c     	b.gt	0x40003494 <uart_putc+0x3c>
40003478: 93407d29     	sxtw	x9, w9
4000347c: d503201f     	nop
40003480: 1005b7ca     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
40003484: 9100052b     	add	x11, x9, #0x1
40003488: 38296940     	strb	w0, [x10, x9]
4000348c: b90b750b     	str	w11, [x8, #0xb74]
40003490: 382b695f     	strb	wzr, [x10, x11]
40003494: 52800308     	mov	w8, #0x18               // =24
40003498: 72a12008     	movk	w8, #0x900, lsl #16
4000349c: b9400109     	ldr	w9, [x8]
400034a0: 372fffe9     	tbnz	w9, #0x5, 0x4000349c <uart_putc+0x44>
400034a4: 12001c08     	and	w8, w0, #0xff
400034a8: 52a12009     	mov	w9, #0x9000000          // =150994944
400034ac: b9000128     	str	w8, [x9]
400034b0: d65f03c0     	ret

00000000400034b4 <uart_puts>:
400034b4: 52800308     	mov	w8, #0x18               // =24
400034b8: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
400034bc: f000004a     	adrp	x10, 0x4000e000 <var_values+0x6a8>
400034c0: 72a12008     	movk	w8, #0x900, lsl #16
400034c4: d503201f     	nop
400034c8: 1005b58b     	adr	x11, 0x4000eb78 <kernel_capture_buffer>
400034cc: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400034d0: 528001ad     	mov	w13, #0xd               // =13
400034d4: 52a1200e     	mov	w14, #0x9000000         // =150994944
400034d8: 3940000f     	ldrb	w15, [x0]
400034dc: 710029ff     	cmp	w15, #0xa
400034e0: 540000a0     	b.eq	0x400034f4 <uart_puts+0x40>
400034e4: 3400040f     	cbz	w15, 0x40003564 <uart_puts+0xb0>
400034e8: b94b7130     	ldr	w16, [x9, #0xb70]
400034ec: 35000230     	cbnz	w16, 0x40003530 <uart_puts+0x7c>
400034f0: 14000018     	b	0x40003550 <uart_puts+0x9c>
400034f4: b94b712f     	ldr	w15, [x9, #0xb70]
400034f8: 3400010f     	cbz	w15, 0x40003518 <uart_puts+0x64>
400034fc: b94b754f     	ldr	w15, [x10, #0xb74]
40003500: 6b0c01ff     	cmp	w15, w12
40003504: 540000ac     	b.gt	0x40003518 <uart_puts+0x64>
40003508: 93407def     	sxtw	x15, w15
4000350c: 110005f0     	add	w16, w15, #0x1
40003510: 782f696d     	strh	w13, [x11, x15]
40003514: b90b7550     	str	w16, [x10, #0xb74]
40003518: b940010f     	ldr	w15, [x8]
4000351c: 372fffef     	tbnz	w15, #0x5, 0x40003518 <uart_puts+0x64>
40003520: b90001cd     	str	w13, [x14]
40003524: 3940000f     	ldrb	w15, [x0]
40003528: b94b7130     	ldr	w16, [x9, #0xb70]
4000352c: 34000130     	cbz	w16, 0x40003550 <uart_puts+0x9c>
40003530: b94b7550     	ldr	w16, [x10, #0xb74]
40003534: 6b0c021f     	cmp	w16, w12
40003538: 540000cc     	b.gt	0x40003550 <uart_puts+0x9c>
4000353c: 93407e10     	sxtw	x16, w16
40003540: 91000611     	add	x17, x16, #0x1
40003544: 3830696f     	strb	w15, [x11, x16]
40003548: b90b7551     	str	w17, [x10, #0xb74]
4000354c: 3831697f     	strb	wzr, [x11, x17]
40003550: 91000400     	add	x0, x0, #0x1
40003554: b9400110     	ldr	w16, [x8]
40003558: 372ffff0     	tbnz	w16, #0x5, 0x40003554 <uart_puts+0xa0>
4000355c: b90001cf     	str	w15, [x14]
40003560: 17ffffde     	b	0x400034d8 <uart_puts+0x24>
40003564: d65f03c0     	ret

0000000040003568 <uart_has_data>:
40003568: 52800308     	mov	w8, #0x18               // =24
4000356c: 52800029     	mov	w9, #0x1                // =1
40003570: 72a12008     	movk	w8, #0x900, lsl #16
40003574: b9400108     	ldr	w8, [x8]
40003578: 0a681120     	bic	w0, w9, w8, lsr #4
4000357c: d65f03c0     	ret

0000000040003580 <uart_getc>:
40003580: 52800308     	mov	w8, #0x18               // =24
40003584: 72a12008     	movk	w8, #0x900, lsl #16
40003588: b9400109     	ldr	w9, [x8]
4000358c: 3727ffe9     	tbnz	w9, #0x4, 0x40003588 <uart_getc+0x8>
40003590: 52a12008     	mov	w8, #0x9000000          // =150994944
40003594: b9400100     	ldr	w0, [x8]
40003598: d65f03c0     	ret

000000004000359c <uart_print_hex_raw>:
4000359c: 52800308     	mov	w8, #0x18               // =24
400035a0: 2a1f03eb     	mov	w11, wzr
400035a4: 5280078c     	mov	w12, #0x3c              // =60
400035a8: 72a12008     	movk	w8, #0x900, lsl #16
400035ac: d503201f     	nop
400035b0: 30017a4e     	adr	x14, 0x400064f9 <__rodata_start+0x4f9>
400035b4: f000004d     	adrp	x13, 0x4000e000 <var_values+0x6a8>
400035b8: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
400035bc: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400035c0: d503201f     	nop
400035c4: 1005adaa     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
400035c8: 52a12010     	mov	w16, #0x9000000         // =150994944
400035cc: 14000003     	b	0x400035d8 <uart_print_hex_raw+0x3c>
400035d0: b400032c     	cbz	x12, 0x40003634 <uart_print_hex_raw+0x98>
400035d4: d100118c     	sub	x12, x12, #0x4
400035d8: 9acc2411     	lsr	x17, x0, x12
400035dc: 53027d92     	lsr	w18, w12, #2
400035e0: 92400e31     	and	x17, x17, #0xf
400035e4: 6b01025f     	cmp	w18, w1
400035e8: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
400035ec: 1a9f056b     	csinc	w11, w11, wzr, eq
400035f0: 34ffff0b     	cbz	w11, 0x400035d0 <uart_print_hex_raw+0x34>
400035f4: b94b71b2     	ldr	w18, [x13, #0xb70]
400035f8: 387169d1     	ldrb	w17, [x14, x17]
400035fc: 34000132     	cbz	w18, 0x40003620 <uart_print_hex_raw+0x84>
40003600: b94b7532     	ldr	w18, [x9, #0xb74]
40003604: 6b0f025f     	cmp	w18, w15
40003608: 540000cc     	b.gt	0x40003620 <uart_print_hex_raw+0x84>
4000360c: 93407e52     	sxtw	x18, w18
40003610: 91000642     	add	x2, x18, #0x1
40003614: 38326951     	strb	w17, [x10, x18]
40003618: b90b7522     	str	w2, [x9, #0xb74]
4000361c: 3822695f     	strb	wzr, [x10, x2]
40003620: b9400112     	ldr	w18, [x8]
40003624: 372ffff2     	tbnz	w18, #0x5, 0x40003620 <uart_print_hex_raw+0x84>
40003628: b9000211     	str	w17, [x16]
4000362c: b5fffd4c     	cbnz	x12, 0x400035d4 <uart_print_hex_raw+0x38>
40003630: d65f03c0     	ret
40003634: b94b71ab     	ldr	w11, [x13, #0xb70]
40003638: 3400014b     	cbz	w11, 0x40003660 <uart_print_hex_raw+0xc4>
4000363c: b94b752b     	ldr	w11, [x9, #0xb74]
40003640: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003644: 6b0c017f     	cmp	w11, w12
40003648: 540000cc     	b.gt	0x40003660 <uart_print_hex_raw+0xc4>
4000364c: 93407d6b     	sxtw	x11, w11
40003650: 1100056c     	add	w12, w11, #0x1
40003654: b90b752c     	str	w12, [x9, #0xb74]
40003658: 52800609     	mov	w9, #0x30               // =48
4000365c: 782b6949     	strh	w9, [x10, x11]
40003660: b9400109     	ldr	w9, [x8]
40003664: 372fffe9     	tbnz	w9, #0x5, 0x40003660 <uart_print_hex_raw+0xc4>
40003668: 52a12008     	mov	w8, #0x9000000          // =150994944
4000366c: 52800609     	mov	w9, #0x30               // =48
40003670: b9000109     	str	w9, [x8]
40003674: d65f03c0     	ret

0000000040003678 <uart_print_hex>:
40003678: 52800308     	mov	w8, #0x18               // =24
4000367c: 9000002c     	adrp	x12, 0x40007000 <__rodata_start+0x1000>
40003680: 9104598c     	add	x12, x12, #0x116
40003684: 72a12008     	movk	w8, #0x900, lsl #16
40003688: f000004b     	adrp	x11, 0x4000e000 <var_values+0x6a8>
4000368c: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
40003690: d503201f     	nop
40003694: 1005a72a     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
40003698: 5287ffcd     	mov	w13, #0x3ffe            // =16382
4000369c: 528001ae     	mov	w14, #0xd               // =13
400036a0: 52a1200f     	mov	w15, #0x9000000         // =150994944
400036a4: 39400190     	ldrb	w16, [x12]
400036a8: 71002a1f     	cmp	w16, #0xa
400036ac: 540000a0     	b.eq	0x400036c0 <uart_print_hex+0x48>
400036b0: 340003f0     	cbz	w16, 0x4000372c <uart_print_hex+0xb4>
400036b4: b94b7171     	ldr	w17, [x11, #0xb70]
400036b8: 35000211     	cbnz	w17, 0x400036f8 <uart_print_hex+0x80>
400036bc: 14000017     	b	0x40003718 <uart_print_hex+0xa0>
400036c0: b94b7171     	ldr	w17, [x11, #0xb70]
400036c4: 34000111     	cbz	w17, 0x400036e4 <uart_print_hex+0x6c>
400036c8: b94b7531     	ldr	w17, [x9, #0xb74]
400036cc: 6b0d023f     	cmp	w17, w13
400036d0: 540000ac     	b.gt	0x400036e4 <uart_print_hex+0x6c>
400036d4: 93407e31     	sxtw	x17, w17
400036d8: 11000632     	add	w18, w17, #0x1
400036dc: 7831694e     	strh	w14, [x10, x17]
400036e0: b90b7532     	str	w18, [x9, #0xb74]
400036e4: b9400111     	ldr	w17, [x8]
400036e8: 372ffff1     	tbnz	w17, #0x5, 0x400036e4 <uart_print_hex+0x6c>
400036ec: b90001ee     	str	w14, [x15]
400036f0: b94b7171     	ldr	w17, [x11, #0xb70]
400036f4: 34000131     	cbz	w17, 0x40003718 <uart_print_hex+0xa0>
400036f8: b94b7531     	ldr	w17, [x9, #0xb74]
400036fc: 6b0d023f     	cmp	w17, w13
40003700: 540000cc     	b.gt	0x40003718 <uart_print_hex+0xa0>
40003704: 93407e31     	sxtw	x17, w17
40003708: 91000632     	add	x18, x17, #0x1
4000370c: 38316950     	strb	w16, [x10, x17]
40003710: b90b7532     	str	w18, [x9, #0xb74]
40003714: 3832695f     	strb	wzr, [x10, x18]
40003718: 9100058c     	add	x12, x12, #0x1
4000371c: b9400111     	ldr	w17, [x8]
40003720: 372ffff1     	tbnz	w17, #0x5, 0x4000371c <uart_print_hex+0xa4>
40003724: b90001f0     	str	w16, [x15]
40003728: 17ffffdf     	b	0x400036a4 <uart_print_hex+0x2c>
4000372c: 2a1f03ec     	mov	w12, wzr
40003730: d503201f     	nop
40003734: 30016e2d     	adr	x13, 0x400064f9 <__rodata_start+0x4f9>
40003738: 5280078e     	mov	w14, #0x3c              // =60
4000373c: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003740: 52a12010     	mov	w16, #0x9000000         // =150994944
40003744: 14000003     	b	0x40003750 <uart_print_hex+0xd8>
40003748: b40002ee     	cbz	x14, 0x400037a4 <uart_print_hex+0x12c>
4000374c: d10011ce     	sub	x14, x14, #0x4
40003750: 9ace2411     	lsr	x17, x0, x14
40003754: f2400e31     	ands	x17, x17, #0xf
40003758: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
4000375c: 1a9f158c     	csinc	w12, w12, wzr, ne
40003760: 34ffff4c     	cbz	w12, 0x40003748 <uart_print_hex+0xd0>
40003764: b94b7172     	ldr	w18, [x11, #0xb70]
40003768: 387169b1     	ldrb	w17, [x13, x17]
4000376c: 34000132     	cbz	w18, 0x40003790 <uart_print_hex+0x118>
40003770: b94b7532     	ldr	w18, [x9, #0xb74]
40003774: 6b0f025f     	cmp	w18, w15
40003778: 540000cc     	b.gt	0x40003790 <uart_print_hex+0x118>
4000377c: 93407e52     	sxtw	x18, w18
40003780: 91000641     	add	x1, x18, #0x1
40003784: 38326951     	strb	w17, [x10, x18]
40003788: b90b7521     	str	w1, [x9, #0xb74]
4000378c: 3821695f     	strb	wzr, [x10, x1]
40003790: b9400112     	ldr	w18, [x8]
40003794: 372ffff2     	tbnz	w18, #0x5, 0x40003790 <uart_print_hex+0x118>
40003798: b9000211     	str	w17, [x16]
4000379c: b5fffd8e     	cbnz	x14, 0x4000374c <uart_print_hex+0xd4>
400037a0: d65f03c0     	ret
400037a4: b94b716b     	ldr	w11, [x11, #0xb70]
400037a8: 3400014b     	cbz	w11, 0x400037d0 <uart_print_hex+0x158>
400037ac: b94b752b     	ldr	w11, [x9, #0xb74]
400037b0: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400037b4: 6b0c017f     	cmp	w11, w12
400037b8: 540000cc     	b.gt	0x400037d0 <uart_print_hex+0x158>
400037bc: 93407d6b     	sxtw	x11, w11
400037c0: 1100056c     	add	w12, w11, #0x1
400037c4: b90b752c     	str	w12, [x9, #0xb74]
400037c8: 52800609     	mov	w9, #0x30               // =48
400037cc: 782b6949     	strh	w9, [x10, x11]
400037d0: b9400109     	ldr	w9, [x8]
400037d4: 372fffe9     	tbnz	w9, #0x5, 0x400037d0 <uart_print_hex+0x158>
400037d8: 52a12008     	mov	w8, #0x9000000          // =150994944
400037dc: 52800609     	mov	w9, #0x30               // =48
400037e0: b9000109     	str	w9, [x8]
400037e4: d65f03c0     	ret

00000000400037e8 <uart_print_dec>:
400037e8: d10083ff     	sub	sp, sp, #0x20
400037ec: 52800308     	mov	w8, #0x18               // =24
400037f0: 72a12008     	movk	w8, #0x900, lsl #16
400037f4: b4000540     	cbz	x0, 0x4000389c <uart_print_dec+0xb4>
400037f8: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
400037fc: aa1f03e9     	mov	x9, xzr
40003800: 5280014b     	mov	w11, #0xa               // =10
40003804: f29999aa     	movk	x10, #0xcccd
40003808: 910023ec     	add	x12, sp, #0x8
4000380c: 9bca7c0d     	umulh	x13, x0, x10
40003810: f100241f     	cmp	x0, #0x9
40003814: d343fdad     	lsr	x13, x13, #3
40003818: 1b0b81ae     	msub	w14, w13, w11, w0
4000381c: aa0d03e0     	mov	x0, x13
40003820: 321c05ce     	orr	w14, w14, #0x30
40003824: 3829698e     	strb	w14, [x12, x9]
40003828: 91000529     	add	x9, x9, #0x1
4000382c: 54ffff08     	b.hi	0x4000380c <uart_print_dec+0x24>
40003830: 910023ea     	add	x10, sp, #0x8
40003834: f000004b     	adrp	x11, 0x4000e000 <var_values+0x6a8>
40003838: f000004c     	adrp	x12, 0x4000e000 <var_values+0x6a8>
4000383c: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003840: d503201f     	nop
40003844: 100599ae     	adr	x14, 0x4000eb78 <kernel_capture_buffer>
40003848: 52a1200f     	mov	w15, #0x9000000         // =150994944
4000384c: d1000530     	sub	x16, x9, #0x1
40003850: b94b7172     	ldr	w18, [x11, #0xb70]
40003854: 38706951     	ldrb	w17, [x10, x16]
40003858: 34000132     	cbz	w18, 0x4000387c <uart_print_dec+0x94>
4000385c: b94b7592     	ldr	w18, [x12, #0xb74]
40003860: 6b0d025f     	cmp	w18, w13
40003864: 540000cc     	b.gt	0x4000387c <uart_print_dec+0x94>
40003868: 93407e52     	sxtw	x18, w18
4000386c: 91000640     	add	x0, x18, #0x1
40003870: 383269d1     	strb	w17, [x14, x18]
40003874: b90b7580     	str	w0, [x12, #0xb74]
40003878: 382069df     	strb	wzr, [x14, x0]
4000387c: b9400112     	ldr	w18, [x8]
40003880: 372ffff2     	tbnz	w18, #0x5, 0x4000387c <uart_print_dec+0x94>
40003884: 7100053f     	cmp	w9, #0x1
40003888: aa1003e9     	mov	x9, x16
4000388c: b90001f1     	str	w17, [x15]
40003890: 54fffdec     	b.gt	0x4000384c <uart_print_dec+0x64>
40003894: 910083ff     	add	sp, sp, #0x20
40003898: d65f03c0     	ret
4000389c: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
400038a0: b94b7129     	ldr	w9, [x9, #0xb70]
400038a4: 340001a9     	cbz	w9, 0x400038d8 <uart_print_dec+0xf0>
400038a8: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
400038ac: 5287ffcb     	mov	w11, #0x3ffe            // =16382
400038b0: b94b752a     	ldr	w10, [x9, #0xb74]
400038b4: 6b0b015f     	cmp	w10, w11
400038b8: 5400010c     	b.gt	0x400038d8 <uart_print_dec+0xf0>
400038bc: 93407d4a     	sxtw	x10, w10
400038c0: d503201f     	nop
400038c4: 100595ac     	adr	x12, 0x4000eb78 <kernel_capture_buffer>
400038c8: 1100054b     	add	w11, w10, #0x1
400038cc: b90b752b     	str	w11, [x9, #0xb74]
400038d0: 52800609     	mov	w9, #0x30               // =48
400038d4: 782a6989     	strh	w9, [x12, x10]
400038d8: b9400109     	ldr	w9, [x8]
400038dc: 372fffe9     	tbnz	w9, #0x5, 0x400038d8 <uart_print_dec+0xf0>
400038e0: 52a12008     	mov	w8, #0x9000000          // =150994944
400038e4: 52800609     	mov	w9, #0x30               // =48
400038e8: b9000109     	str	w9, [x8]
400038ec: 910083ff     	add	sp, sp, #0x20
400038f0: d65f03c0     	ret

00000000400038f4 <uart_printf>:
400038f4: d10343ff     	sub	sp, sp, #0xd0
400038f8: a9077bfd     	stp	x29, x30, [sp, #0x70]
400038fc: 9101c3fd     	add	x29, sp, #0x70
40003900: 910003e8     	mov	x8, sp
40003904: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003908: 52800315     	mov	w21, #0x18              // =24
4000390c: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003910: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003914: 72a12015     	movk	w21, #0x900, lsl #16
40003918: 128006e9     	mov	w9, #-0x38              // =-56
4000391c: a90967fa     	stp	x26, x25, [sp, #0x90]
40003920: 9100e108     	add	x8, x8, #0x38
40003924: 910183aa     	add	x10, x29, #0x60
40003928: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
4000392c: f0000056     	adrp	x22, 0x4000e000 <var_values+0x6a8>
40003930: f0000057     	adrp	x23, 0x4000e000 <var_values+0x6a8>
40003934: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003938: aa0003f3     	mov	x19, x0
4000393c: aa1f03f4     	mov	x20, xzr
40003940: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003944: d503201f     	nop
40003948: 10059199     	adr	x25, 0x4000eb78 <kernel_capture_buffer>
4000394c: 528001ba     	mov	w26, #0xd               // =13
40003950: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003954: 528004ae     	mov	w14, #0x25              // =37
40003958: f29999af     	movk	x15, #0xcccd
4000395c: 52800150     	mov	w16, #0xa               // =10
40003960: d10063bc     	sub	x28, x29, #0x18
40003964: d503201f     	nop
40003968: 30015c91     	adr	x17, 0x400064f9 <__rodata_start+0x4f9>
4000396c: a9000be1     	stp	x1, x2, [sp]
40003970: a90113e3     	stp	x3, x4, [sp, #0x10]
40003974: a9021be5     	stp	x5, x6, [sp, #0x20]
40003978: f9002be9     	str	x9, [sp, #0x50]
4000397c: f90023e8     	str	x8, [sp, #0x40]
40003980: a9032be7     	stp	x7, x10, [sp, #0x30]
40003984: 14000004     	b	0x40003994 <uart_printf+0xa0>
40003988: 52800608     	mov	w8, #0x30               // =48
4000398c: b9000368     	str	w8, [x27]
40003990: 91000694     	add	x20, x20, #0x1
40003994: 38746a68     	ldrb	w8, [x19, x20]
40003998: 7100291f     	cmp	w8, #0xa
4000399c: 54000440     	b.eq	0x40003a24 <uart_printf+0x130>
400039a0: 7100951f     	cmp	w8, #0x25
400039a4: 540000a0     	b.eq	0x400039b8 <uart_printf+0xc4>
400039a8: 340039e8     	cbz	w8, 0x400040e4 <uart_printf+0x7f0>
400039ac: b94b72c9     	ldr	w9, [x22, #0xb70]
400039b0: 35000589     	cbnz	w9, 0x40003a60 <uart_printf+0x16c>
400039b4: 14000033     	b	0x40003a80 <uart_printf+0x18c>
400039b8: 9100068a     	add	x10, x20, #0x1
400039bc: 386a6a68     	ldrb	w8, [x19, x10]
400039c0: 7101b11f     	cmp	w8, #0x6c
400039c4: 54000641     	b.ne	0x40003a8c <uart_printf+0x198>
400039c8: 91000a89     	add	x9, x20, #0x2
400039cc: 91000e8b     	add	x11, x20, #0x3
400039d0: 38696a6a     	ldrb	w10, [x19, x9]
400039d4: 7101b15f     	cmp	w10, #0x6c
400039d8: 9a890174     	csel	x20, x11, x9, eq
400039dc: 38746a69     	ldrb	w9, [x19, x20]
400039e0: 7101bd3f     	cmp	w9, #0x6f
400039e4: 540005cd     	b.le	0x40003a9c <uart_printf+0x1a8>
400039e8: 7101d13f     	cmp	w9, #0x74
400039ec: 540007ec     	b.gt	0x40003ae8 <uart_printf+0x1f4>
400039f0: 7101c13f     	cmp	w9, #0x70
400039f4: 54000ea0     	b.eq	0x40003bc8 <uart_printf+0x2d4>
400039f8: 7101cd3f     	cmp	w9, #0x73
400039fc: 54000b21     	b.ne	0x40003b60 <uart_printf+0x26c>
40003a00: b98053e8     	ldrsw	x8, [sp, #0x50]
40003a04: 36f813a8     	tbz	w8, #0x1f, 0x40003c78 <uart_printf+0x384>
40003a08: 11002109     	add	w9, w8, #0x8
40003a0c: 3100211f     	cmn	w8, #0x8
40003a10: b90053e9     	str	w9, [sp, #0x50]
40003a14: 54001328     	b.hi	0x40003c78 <uart_printf+0x384>
40003a18: f94023e9     	ldr	x9, [sp, #0x40]
40003a1c: 8b080128     	add	x8, x9, x8
40003a20: 14000099     	b	0x40003c84 <uart_printf+0x390>
40003a24: b94b72c8     	ldr	w8, [x22, #0xb70]
40003a28: 34000108     	cbz	w8, 0x40003a48 <uart_printf+0x154>
40003a2c: b94b76e8     	ldr	w8, [x23, #0xb74]
40003a30: 6b18011f     	cmp	w8, w24
40003a34: 540000ac     	b.gt	0x40003a48 <uart_printf+0x154>
40003a38: 93407d08     	sxtw	x8, w8
40003a3c: 11000509     	add	w9, w8, #0x1
40003a40: 78286b3a     	strh	w26, [x25, x8]
40003a44: b90b76e9     	str	w9, [x23, #0xb74]
40003a48: b94002a8     	ldr	w8, [x21]
40003a4c: 372fffe8     	tbnz	w8, #0x5, 0x40003a48 <uart_printf+0x154>
40003a50: b900037a     	str	w26, [x27]
40003a54: 38746a68     	ldrb	w8, [x19, x20]
40003a58: b94b72c9     	ldr	w9, [x22, #0xb70]
40003a5c: 34000129     	cbz	w9, 0x40003a80 <uart_printf+0x18c>
40003a60: b94b76e9     	ldr	w9, [x23, #0xb74]
40003a64: 6b18013f     	cmp	w9, w24
40003a68: 540000cc     	b.gt	0x40003a80 <uart_printf+0x18c>
40003a6c: 93407d29     	sxtw	x9, w9
40003a70: 9100052a     	add	x10, x9, #0x1
40003a74: 38296b28     	strb	w8, [x25, x9]
40003a78: b90b76ea     	str	w10, [x23, #0xb74]
40003a7c: 382a6b3f     	strb	wzr, [x25, x10]
40003a80: b94002a9     	ldr	w9, [x21]
40003a84: 372fffe9     	tbnz	w9, #0x5, 0x40003a80 <uart_printf+0x18c>
40003a88: 17ffffc1     	b	0x4000398c <uart_printf+0x98>
40003a8c: 2a0803e9     	mov	w9, w8
40003a90: aa0a03f4     	mov	x20, x10
40003a94: 7101bd3f     	cmp	w9, #0x6f
40003a98: 54fffa8c     	b.gt	0x400039e8 <uart_printf+0xf4>
40003a9c: 7100953f     	cmp	w9, #0x25
40003aa0: 54000440     	b.eq	0x40003b28 <uart_printf+0x234>
40003aa4: 71018d3f     	cmp	w9, #0x63
40003aa8: 54000bc0     	b.eq	0x40003c20 <uart_printf+0x32c>
40003aac: 7101913f     	cmp	w9, #0x64
40003ab0: 54000581     	b.ne	0x40003b60 <uart_printf+0x26c>
40003ab4: b98053e9     	ldrsw	x9, [sp, #0x50]
40003ab8: 7101b11f     	cmp	w8, #0x6c
40003abc: 54001761     	b.ne	0x40003da8 <uart_printf+0x4b4>
40003ac0: 36f82349     	tbz	w9, #0x1f, 0x40003f28 <uart_printf+0x634>
40003ac4: 11002128     	add	w8, w9, #0x8
40003ac8: 3100213f     	cmn	w9, #0x8
40003acc: b90053e8     	str	w8, [sp, #0x50]
40003ad0: 540022c8     	b.hi	0x40003f28 <uart_printf+0x634>
40003ad4: f94023e8     	ldr	x8, [sp, #0x40]
40003ad8: 8b090108     	add	x8, x8, x9
40003adc: f9400109     	ldr	x9, [x8]
40003ae0: b6f82909     	tbz	x9, #0x3f, 0x40004000 <uart_printf+0x70c>
40003ae4: 14000116     	b	0x40003f3c <uart_printf+0x648>
40003ae8: 7101d53f     	cmp	w9, #0x75
40003aec: 54000800     	b.eq	0x40003bec <uart_printf+0x2f8>
40003af0: 7101e13f     	cmp	w9, #0x78
40003af4: 54000361     	b.ne	0x40003b60 <uart_printf+0x26c>
40003af8: b98053e9     	ldrsw	x9, [sp, #0x50]
40003afc: 7101b11f     	cmp	w8, #0x6c
40003b00: 54001441     	b.ne	0x40003d88 <uart_printf+0x494>
40003b04: 36f81cc9     	tbz	w9, #0x1f, 0x40003e9c <uart_printf+0x5a8>
40003b08: 11002128     	add	w8, w9, #0x8
40003b0c: 3100213f     	cmn	w9, #0x8
40003b10: b90053e8     	str	w8, [sp, #0x50]
40003b14: 54001c48     	b.hi	0x40003e9c <uart_printf+0x5a8>
40003b18: f94023e8     	ldr	x8, [sp, #0x40]
40003b1c: 8b090108     	add	x8, x8, x9
40003b20: f9400108     	ldr	x8, [x8]
40003b24: 140000e7     	b	0x40003ec0 <uart_printf+0x5cc>
40003b28: b94b72c8     	ldr	w8, [x22, #0xb70]
40003b2c: 34000108     	cbz	w8, 0x40003b4c <uart_printf+0x258>
40003b30: b94b76e8     	ldr	w8, [x23, #0xb74]
40003b34: 6b18011f     	cmp	w8, w24
40003b38: 540000ac     	b.gt	0x40003b4c <uart_printf+0x258>
40003b3c: 93407d08     	sxtw	x8, w8
40003b40: 11000509     	add	w9, w8, #0x1
40003b44: 78286b2e     	strh	w14, [x25, x8]
40003b48: b90b76e9     	str	w9, [x23, #0xb74]
40003b4c: b94002a8     	ldr	w8, [x21]
40003b50: 372fffe8     	tbnz	w8, #0x5, 0x40003b4c <uart_printf+0x258>
40003b54: b900036e     	str	w14, [x27]
40003b58: 91000694     	add	x20, x20, #0x1
40003b5c: 17ffff8e     	b	0x40003994 <uart_printf+0xa0>
40003b60: b94b72c8     	ldr	w8, [x22, #0xb70]
40003b64: 34000108     	cbz	w8, 0x40003b84 <uart_printf+0x290>
40003b68: b94b76e8     	ldr	w8, [x23, #0xb74]
40003b6c: 6b18011f     	cmp	w8, w24
40003b70: 540000ac     	b.gt	0x40003b84 <uart_printf+0x290>
40003b74: 93407d08     	sxtw	x8, w8
40003b78: 11000509     	add	w9, w8, #0x1
40003b7c: 78286b2e     	strh	w14, [x25, x8]
40003b80: b90b76e9     	str	w9, [x23, #0xb74]
40003b84: b94002a8     	ldr	w8, [x21]
40003b88: 372fffe8     	tbnz	w8, #0x5, 0x40003b84 <uart_printf+0x290>
40003b8c: b900036e     	str	w14, [x27]
40003b90: b94b72c9     	ldr	w9, [x22, #0xb70]
40003b94: 38746a68     	ldrb	w8, [x19, x20]
40003b98: 34000129     	cbz	w9, 0x40003bbc <uart_printf+0x2c8>
40003b9c: b94b76e9     	ldr	w9, [x23, #0xb74]
40003ba0: 6b18013f     	cmp	w9, w24
40003ba4: 540000cc     	b.gt	0x40003bbc <uart_printf+0x2c8>
40003ba8: 93407d29     	sxtw	x9, w9
40003bac: 9100052a     	add	x10, x9, #0x1
40003bb0: 38296b28     	strb	w8, [x25, x9]
40003bb4: b90b76ea     	str	w10, [x23, #0xb74]
40003bb8: 382a6b3f     	strb	wzr, [x25, x10]
40003bbc: b94002a9     	ldr	w9, [x21]
40003bc0: 372fffe9     	tbnz	w9, #0x5, 0x40003bbc <uart_printf+0x2c8>
40003bc4: 17ffff72     	b	0x4000398c <uart_printf+0x98>
40003bc8: b98053e8     	ldrsw	x8, [sp, #0x50]
40003bcc: 36f803c8     	tbz	w8, #0x1f, 0x40003c44 <uart_printf+0x350>
40003bd0: 11002109     	add	w9, w8, #0x8
40003bd4: 3100211f     	cmn	w8, #0x8
40003bd8: b90053e9     	str	w9, [sp, #0x50]
40003bdc: 54000348     	b.hi	0x40003c44 <uart_printf+0x350>
40003be0: f94023e9     	ldr	x9, [sp, #0x40]
40003be4: 8b080128     	add	x8, x9, x8
40003be8: 1400001a     	b	0x40003c50 <uart_printf+0x35c>
40003bec: b98053e9     	ldrsw	x9, [sp, #0x50]
40003bf0: 7101b11f     	cmp	w8, #0x6c
40003bf4: 54000ba1     	b.ne	0x40003d68 <uart_printf+0x474>
40003bf8: 36f80e89     	tbz	w9, #0x1f, 0x40003dc8 <uart_printf+0x4d4>
40003bfc: 11002128     	add	w8, w9, #0x8
40003c00: 3100213f     	cmn	w9, #0x8
40003c04: b90053e8     	str	w8, [sp, #0x50]
40003c08: 54000e08     	b.hi	0x40003dc8 <uart_printf+0x4d4>
40003c0c: f94023e8     	ldr	x8, [sp, #0x40]
40003c10: 8b090108     	add	x8, x8, x9
40003c14: f9400109     	ldr	x9, [x8]
40003c18: b5001069     	cbnz	x9, 0x40003e24 <uart_printf+0x530>
40003c1c: 14000070     	b	0x40003ddc <uart_printf+0x4e8>
40003c20: b98053e8     	ldrsw	x8, [sp, #0x50]
40003c24: 36f80808     	tbz	w8, #0x1f, 0x40003d24 <uart_printf+0x430>
40003c28: 11002109     	add	w9, w8, #0x8
40003c2c: 3100211f     	cmn	w8, #0x8
40003c30: b90053e9     	str	w9, [sp, #0x50]
40003c34: 54000788     	b.hi	0x40003d24 <uart_printf+0x430>
40003c38: f94023e9     	ldr	x9, [sp, #0x40]
40003c3c: 8b080128     	add	x8, x9, x8
40003c40: 1400003c     	b	0x40003d30 <uart_printf+0x43c>
40003c44: f9401fe8     	ldr	x8, [sp, #0x38]
40003c48: 91002109     	add	x9, x8, #0x8
40003c4c: f9001fe9     	str	x9, [sp, #0x38]
40003c50: f9400100     	ldr	x0, [x8]
40003c54: 97fffe89     	bl	0x40003678 <uart_print_hex>
40003c58: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003c5c: 528004ae     	mov	w14, #0x25              // =37
40003c60: 52800150     	mov	w16, #0xa               // =10
40003c64: f29999af     	movk	x15, #0xcccd
40003c68: d503201f     	nop
40003c6c: 30014471     	adr	x17, 0x400064f9 <__rodata_start+0x4f9>
40003c70: 91000694     	add	x20, x20, #0x1
40003c74: 17ffff48     	b	0x40003994 <uart_printf+0xa0>
40003c78: f9401fe8     	ldr	x8, [sp, #0x38]
40003c7c: 91002109     	add	x9, x8, #0x8
40003c80: f9001fe9     	str	x9, [sp, #0x38]
40003c84: f9400108     	ldr	x8, [x8]
40003c88: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
40003c8c: 9113a929     	add	x9, x9, #0x4ea
40003c90: f100011f     	cmp	x8, #0x0
40003c94: 9a880128     	csel	x8, x9, x8, eq
40003c98: 39400109     	ldrb	w9, [x8]
40003c9c: 7100293f     	cmp	w9, #0xa
40003ca0: 540000a0     	b.eq	0x40003cb4 <uart_printf+0x3c0>
40003ca4: 34ffe769     	cbz	w9, 0x40003990 <uart_printf+0x9c>
40003ca8: b94b72ca     	ldr	w10, [x22, #0xb70]
40003cac: 3500022a     	cbnz	w10, 0x40003cf0 <uart_printf+0x3fc>
40003cb0: 14000018     	b	0x40003d10 <uart_printf+0x41c>
40003cb4: b94b72c9     	ldr	w9, [x22, #0xb70]
40003cb8: 34000109     	cbz	w9, 0x40003cd8 <uart_printf+0x3e4>
40003cbc: b94b76e9     	ldr	w9, [x23, #0xb74]
40003cc0: 6b18013f     	cmp	w9, w24
40003cc4: 540000ac     	b.gt	0x40003cd8 <uart_printf+0x3e4>
40003cc8: 93407d29     	sxtw	x9, w9
40003ccc: 1100052a     	add	w10, w9, #0x1
40003cd0: 78296b3a     	strh	w26, [x25, x9]
40003cd4: b90b76ea     	str	w10, [x23, #0xb74]
40003cd8: b94002a9     	ldr	w9, [x21]
40003cdc: 372fffe9     	tbnz	w9, #0x5, 0x40003cd8 <uart_printf+0x3e4>
40003ce0: b900037a     	str	w26, [x27]
40003ce4: 39400109     	ldrb	w9, [x8]
40003ce8: b94b72ca     	ldr	w10, [x22, #0xb70]
40003cec: 3400012a     	cbz	w10, 0x40003d10 <uart_printf+0x41c>
40003cf0: b94b76ea     	ldr	w10, [x23, #0xb74]
40003cf4: 6b18015f     	cmp	w10, w24
40003cf8: 540000cc     	b.gt	0x40003d10 <uart_printf+0x41c>
40003cfc: 93407d4a     	sxtw	x10, w10
40003d00: 9100054b     	add	x11, x10, #0x1
40003d04: 382a6b29     	strb	w9, [x25, x10]
40003d08: b90b76eb     	str	w11, [x23, #0xb74]
40003d0c: 382b6b3f     	strb	wzr, [x25, x11]
40003d10: 91000508     	add	x8, x8, #0x1
40003d14: b94002aa     	ldr	w10, [x21]
40003d18: 372fffea     	tbnz	w10, #0x5, 0x40003d14 <uart_printf+0x420>
40003d1c: b9000369     	str	w9, [x27]
40003d20: 17ffffde     	b	0x40003c98 <uart_printf+0x3a4>
40003d24: f9401fe8     	ldr	x8, [sp, #0x38]
40003d28: 91002109     	add	x9, x8, #0x8
40003d2c: f9001fe9     	str	x9, [sp, #0x38]
40003d30: b94b72c9     	ldr	w9, [x22, #0xb70]
40003d34: 39400108     	ldrb	w8, [x8]
40003d38: 34000129     	cbz	w9, 0x40003d5c <uart_printf+0x468>
40003d3c: b94b76e9     	ldr	w9, [x23, #0xb74]
40003d40: 6b18013f     	cmp	w9, w24
40003d44: 540000cc     	b.gt	0x40003d5c <uart_printf+0x468>
40003d48: 93407d29     	sxtw	x9, w9
40003d4c: 9100052a     	add	x10, x9, #0x1
40003d50: 38296b28     	strb	w8, [x25, x9]
40003d54: b90b76ea     	str	w10, [x23, #0xb74]
40003d58: 382a6b3f     	strb	wzr, [x25, x10]
40003d5c: b94002a9     	ldr	w9, [x21]
40003d60: 372fffe9     	tbnz	w9, #0x5, 0x40003d5c <uart_printf+0x468>
40003d64: 17ffff0a     	b	0x4000398c <uart_printf+0x98>
40003d68: 36f80549     	tbz	w9, #0x1f, 0x40003e10 <uart_printf+0x51c>
40003d6c: 11002128     	add	w8, w9, #0x8
40003d70: 3100213f     	cmn	w9, #0x8
40003d74: b90053e8     	str	w8, [sp, #0x50]
40003d78: 540004c8     	b.hi	0x40003e10 <uart_printf+0x51c>
40003d7c: f94023e8     	ldr	x8, [sp, #0x40]
40003d80: 8b090108     	add	x8, x8, x9
40003d84: 14000026     	b	0x40003e1c <uart_printf+0x528>
40003d88: 36f80949     	tbz	w9, #0x1f, 0x40003eb0 <uart_printf+0x5bc>
40003d8c: 11002128     	add	w8, w9, #0x8
40003d90: 3100213f     	cmn	w9, #0x8
40003d94: b90053e8     	str	w8, [sp, #0x50]
40003d98: 540008c8     	b.hi	0x40003eb0 <uart_printf+0x5bc>
40003d9c: f94023e8     	ldr	x8, [sp, #0x40]
40003da0: 8b090108     	add	x8, x8, x9
40003da4: 14000046     	b	0x40003ebc <uart_printf+0x5c8>
40003da8: 36f81229     	tbz	w9, #0x1f, 0x40003fec <uart_printf+0x6f8>
40003dac: 11002128     	add	w8, w9, #0x8
40003db0: 3100213f     	cmn	w9, #0x8
40003db4: b90053e8     	str	w8, [sp, #0x50]
40003db8: 540011a8     	b.hi	0x40003fec <uart_printf+0x6f8>
40003dbc: f94023e8     	ldr	x8, [sp, #0x40]
40003dc0: 8b090108     	add	x8, x8, x9
40003dc4: 1400008d     	b	0x40003ff8 <uart_printf+0x704>
40003dc8: f9401fe8     	ldr	x8, [sp, #0x38]
40003dcc: 91002109     	add	x9, x8, #0x8
40003dd0: f9001fe9     	str	x9, [sp, #0x38]
40003dd4: f9400109     	ldr	x9, [x8]
40003dd8: b5000269     	cbnz	x9, 0x40003e24 <uart_printf+0x530>
40003ddc: b94b72c8     	ldr	w8, [x22, #0xb70]
40003de0: 34000128     	cbz	w8, 0x40003e04 <uart_printf+0x510>
40003de4: b94b76e8     	ldr	w8, [x23, #0xb74]
40003de8: 6b18011f     	cmp	w8, w24
40003dec: 540000cc     	b.gt	0x40003e04 <uart_printf+0x510>
40003df0: 93407d08     	sxtw	x8, w8
40003df4: 11000509     	add	w9, w8, #0x1
40003df8: b90b76e9     	str	w9, [x23, #0xb74]
40003dfc: 52800609     	mov	w9, #0x30               // =48
40003e00: 78286b29     	strh	w9, [x25, x8]
40003e04: b94002a8     	ldr	w8, [x21]
40003e08: 372fffe8     	tbnz	w8, #0x5, 0x40003e04 <uart_printf+0x510>
40003e0c: 17fffedf     	b	0x40003988 <uart_printf+0x94>
40003e10: f9401fe8     	ldr	x8, [sp, #0x38]
40003e14: 91002109     	add	x9, x8, #0x8
40003e18: f9001fe9     	str	x9, [sp, #0x38]
40003e1c: b9400109     	ldr	w9, [x8]
40003e20: b4fffde9     	cbz	x9, 0x40003ddc <uart_printf+0x4e8>
40003e24: aa1f03ea     	mov	x10, xzr
40003e28: 9bcf7d28     	umulh	x8, x9, x15
40003e2c: f100253f     	cmp	x9, #0x9
40003e30: d343fd0b     	lsr	x11, x8, #3
40003e34: 91000548     	add	x8, x10, #0x1
40003e38: 1b10a56c     	msub	w12, w11, w16, w9
40003e3c: 321c0589     	orr	w9, w12, #0x30
40003e40: 382a6b89     	strb	w9, [x28, x10]
40003e44: aa0803ea     	mov	x10, x8
40003e48: aa0b03e9     	mov	x9, x11
40003e4c: 54fffee8     	b.hi	0x40003e28 <uart_printf+0x534>
40003e50: d1000509     	sub	x9, x8, #0x1
40003e54: b94b72cb     	ldr	w11, [x22, #0xb70]
40003e58: 38696b8a     	ldrb	w10, [x28, x9]
40003e5c: 3400012b     	cbz	w11, 0x40003e80 <uart_printf+0x58c>
40003e60: b94b76eb     	ldr	w11, [x23, #0xb74]
40003e64: 6b18017f     	cmp	w11, w24
40003e68: 540000cc     	b.gt	0x40003e80 <uart_printf+0x58c>
40003e6c: 93407d6b     	sxtw	x11, w11
40003e70: 9100056c     	add	x12, x11, #0x1
40003e74: 382b6b2a     	strb	w10, [x25, x11]
40003e78: b90b76ec     	str	w12, [x23, #0xb74]
40003e7c: 382c6b3f     	strb	wzr, [x25, x12]
40003e80: b94002ab     	ldr	w11, [x21]
40003e84: 372fffeb     	tbnz	w11, #0x5, 0x40003e80 <uart_printf+0x58c>
40003e88: 7100051f     	cmp	w8, #0x1
40003e8c: aa0903e8     	mov	x8, x9
40003e90: b900036a     	str	w10, [x27]
40003e94: 54fffdec     	b.gt	0x40003e50 <uart_printf+0x55c>
40003e98: 17fffebe     	b	0x40003990 <uart_printf+0x9c>
40003e9c: f9401fe8     	ldr	x8, [sp, #0x38]
40003ea0: 91002109     	add	x9, x8, #0x8
40003ea4: f9001fe9     	str	x9, [sp, #0x38]
40003ea8: f9400108     	ldr	x8, [x8]
40003eac: 14000005     	b	0x40003ec0 <uart_printf+0x5cc>
40003eb0: f9401fe8     	ldr	x8, [sp, #0x38]
40003eb4: 91002109     	add	x9, x8, #0x8
40003eb8: f9001fe9     	str	x9, [sp, #0x38]
40003ebc: b9400108     	ldr	w8, [x8]
40003ec0: 2a1f03e9     	mov	w9, wzr
40003ec4: 5280078a     	mov	w10, #0x3c              // =60
40003ec8: 14000003     	b	0x40003ed4 <uart_printf+0x5e0>
40003ecc: b4000d8a     	cbz	x10, 0x4000407c <uart_printf+0x788>
40003ed0: d100114a     	sub	x10, x10, #0x4
40003ed4: 9aca250b     	lsr	x11, x8, x10
40003ed8: f2400d6b     	ands	x11, x11, #0xf
40003edc: fa400944     	ccmp	x10, #0x0, #0x4, eq
40003ee0: 1a9f1529     	csinc	w9, w9, wzr, ne
40003ee4: 34ffff49     	cbz	w9, 0x40003ecc <uart_printf+0x5d8>
40003ee8: b94b72cc     	ldr	w12, [x22, #0xb70]
40003eec: 386b6a2b     	ldrb	w11, [x17, x11]
40003ef0: 3400012c     	cbz	w12, 0x40003f14 <uart_printf+0x620>
40003ef4: b94b76ec     	ldr	w12, [x23, #0xb74]
40003ef8: 6b18019f     	cmp	w12, w24
40003efc: 540000cc     	b.gt	0x40003f14 <uart_printf+0x620>
40003f00: 93407d8c     	sxtw	x12, w12
40003f04: 9100058d     	add	x13, x12, #0x1
40003f08: 382c6b2b     	strb	w11, [x25, x12]
40003f0c: b90b76ed     	str	w13, [x23, #0xb74]
40003f10: 382d6b3f     	strb	wzr, [x25, x13]
40003f14: b94002ac     	ldr	w12, [x21]
40003f18: 372fffec     	tbnz	w12, #0x5, 0x40003f14 <uart_printf+0x620>
40003f1c: b900036b     	str	w11, [x27]
40003f20: b5fffd8a     	cbnz	x10, 0x40003ed0 <uart_printf+0x5dc>
40003f24: 17fffe9b     	b	0x40003990 <uart_printf+0x9c>
40003f28: f9401fe8     	ldr	x8, [sp, #0x38]
40003f2c: 91002109     	add	x9, x8, #0x8
40003f30: f9001fe9     	str	x9, [sp, #0x38]
40003f34: f9400109     	ldr	x9, [x8]
40003f38: b6f80649     	tbz	x9, #0x3f, 0x40004000 <uart_printf+0x70c>
40003f3c: b94b72c8     	ldr	w8, [x22, #0xb70]
40003f40: 34000128     	cbz	w8, 0x40003f64 <uart_printf+0x670>
40003f44: b94b76e8     	ldr	w8, [x23, #0xb74]
40003f48: 6b18011f     	cmp	w8, w24
40003f4c: 540000cc     	b.gt	0x40003f64 <uart_printf+0x670>
40003f50: 93407d08     	sxtw	x8, w8
40003f54: 1100050a     	add	w10, w8, #0x1
40003f58: b90b76ea     	str	w10, [x23, #0xb74]
40003f5c: 528005aa     	mov	w10, #0x2d              // =45
40003f60: 78286b2a     	strh	w10, [x25, x8]
40003f64: b94002a8     	ldr	w8, [x21]
40003f68: 372fffe8     	tbnz	w8, #0x5, 0x40003f64 <uart_printf+0x670>
40003f6c: aa1f03e8     	mov	x8, xzr
40003f70: 528005aa     	mov	w10, #0x2d              // =45
40003f74: cb0903e9     	neg	x9, x9
40003f78: b900036a     	str	w10, [x27]
40003f7c: 9bcf7d2a     	umulh	x10, x9, x15
40003f80: f100253f     	cmp	x9, #0x9
40003f84: d343fd4a     	lsr	x10, x10, #3
40003f88: 1b10a54b     	msub	w11, w10, w16, w9
40003f8c: 321c0569     	orr	w9, w11, #0x30
40003f90: 38286b89     	strb	w9, [x28, x8]
40003f94: 91000508     	add	x8, x8, #0x1
40003f98: aa0a03e9     	mov	x9, x10
40003f9c: 54ffff08     	b.hi	0x40003f7c <uart_printf+0x688>
40003fa0: d1000509     	sub	x9, x8, #0x1
40003fa4: b94b72cb     	ldr	w11, [x22, #0xb70]
40003fa8: 38696b8a     	ldrb	w10, [x28, x9]
40003fac: 3400012b     	cbz	w11, 0x40003fd0 <uart_printf+0x6dc>
40003fb0: b94b76eb     	ldr	w11, [x23, #0xb74]
40003fb4: 6b18017f     	cmp	w11, w24
40003fb8: 540000cc     	b.gt	0x40003fd0 <uart_printf+0x6dc>
40003fbc: 93407d6b     	sxtw	x11, w11
40003fc0: 9100056c     	add	x12, x11, #0x1
40003fc4: 382b6b2a     	strb	w10, [x25, x11]
40003fc8: b90b76ec     	str	w12, [x23, #0xb74]
40003fcc: 382c6b3f     	strb	wzr, [x25, x12]
40003fd0: b94002ab     	ldr	w11, [x21]
40003fd4: 372fffeb     	tbnz	w11, #0x5, 0x40003fd0 <uart_printf+0x6dc>
40003fd8: 7100051f     	cmp	w8, #0x1
40003fdc: aa0903e8     	mov	x8, x9
40003fe0: b900036a     	str	w10, [x27]
40003fe4: 54fffdec     	b.gt	0x40003fa0 <uart_printf+0x6ac>
40003fe8: 17fffe6a     	b	0x40003990 <uart_printf+0x9c>
40003fec: f9401fe8     	ldr	x8, [sp, #0x38]
40003ff0: 91002109     	add	x9, x8, #0x8
40003ff4: f9001fe9     	str	x9, [sp, #0x38]
40003ff8: b9800109     	ldrsw	x9, [x8]
40003ffc: b7fffa09     	tbnz	x9, #0x3f, 0x40003f3c <uart_printf+0x648>
40004000: b4000589     	cbz	x9, 0x400040b0 <uart_printf+0x7bc>
40004004: aa1f03ea     	mov	x10, xzr
40004008: 9bcf7d28     	umulh	x8, x9, x15
4000400c: f100253f     	cmp	x9, #0x9
40004010: d343fd0b     	lsr	x11, x8, #3
40004014: 91000548     	add	x8, x10, #0x1
40004018: 1b10a56c     	msub	w12, w11, w16, w9
4000401c: 321c0589     	orr	w9, w12, #0x30
40004020: 382a6b89     	strb	w9, [x28, x10]
40004024: aa0803ea     	mov	x10, x8
40004028: aa0b03e9     	mov	x9, x11
4000402c: 54fffee8     	b.hi	0x40004008 <uart_printf+0x714>
40004030: d1000509     	sub	x9, x8, #0x1
40004034: b94b72cb     	ldr	w11, [x22, #0xb70]
40004038: 38696b8a     	ldrb	w10, [x28, x9]
4000403c: 3400012b     	cbz	w11, 0x40004060 <uart_printf+0x76c>
40004040: b94b76eb     	ldr	w11, [x23, #0xb74]
40004044: 6b18017f     	cmp	w11, w24
40004048: 540000cc     	b.gt	0x40004060 <uart_printf+0x76c>
4000404c: 93407d6b     	sxtw	x11, w11
40004050: 9100056c     	add	x12, x11, #0x1
40004054: 382b6b2a     	strb	w10, [x25, x11]
40004058: b90b76ec     	str	w12, [x23, #0xb74]
4000405c: 382c6b3f     	strb	wzr, [x25, x12]
40004060: b94002ab     	ldr	w11, [x21]
40004064: 372fffeb     	tbnz	w11, #0x5, 0x40004060 <uart_printf+0x76c>
40004068: 7100051f     	cmp	w8, #0x1
4000406c: aa0903e8     	mov	x8, x9
40004070: b900036a     	str	w10, [x27]
40004074: 54fffdec     	b.gt	0x40004030 <uart_printf+0x73c>
40004078: 17fffe46     	b	0x40003990 <uart_printf+0x9c>
4000407c: b94b72c8     	ldr	w8, [x22, #0xb70]
40004080: 34000128     	cbz	w8, 0x400040a4 <uart_printf+0x7b0>
40004084: b94b76e8     	ldr	w8, [x23, #0xb74]
40004088: 6b18011f     	cmp	w8, w24
4000408c: 540000cc     	b.gt	0x400040a4 <uart_printf+0x7b0>
40004090: 93407d08     	sxtw	x8, w8
40004094: 11000509     	add	w9, w8, #0x1
40004098: b90b76e9     	str	w9, [x23, #0xb74]
4000409c: 52800609     	mov	w9, #0x30               // =48
400040a0: 78286b29     	strh	w9, [x25, x8]
400040a4: b94002a8     	ldr	w8, [x21]
400040a8: 372fffe8     	tbnz	w8, #0x5, 0x400040a4 <uart_printf+0x7b0>
400040ac: 17fffe37     	b	0x40003988 <uart_printf+0x94>
400040b0: b94b72c8     	ldr	w8, [x22, #0xb70]
400040b4: 34000128     	cbz	w8, 0x400040d8 <uart_printf+0x7e4>
400040b8: b94b76e8     	ldr	w8, [x23, #0xb74]
400040bc: 6b18011f     	cmp	w8, w24
400040c0: 540000cc     	b.gt	0x400040d8 <uart_printf+0x7e4>
400040c4: 93407d08     	sxtw	x8, w8
400040c8: 11000509     	add	w9, w8, #0x1
400040cc: b90b76e9     	str	w9, [x23, #0xb74]
400040d0: 52800609     	mov	w9, #0x30               // =48
400040d4: 78286b29     	strh	w9, [x25, x8]
400040d8: b94002a8     	ldr	w8, [x21]
400040dc: 372fffe8     	tbnz	w8, #0x5, 0x400040d8 <uart_printf+0x7e4>
400040e0: 17fffe2a     	b	0x40003988 <uart_printf+0x94>
400040e4: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
400040e8: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
400040ec: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
400040f0: a94967fa     	ldp	x26, x25, [sp, #0x90]
400040f4: a9486ffc     	ldp	x28, x27, [sp, #0x80]
400040f8: a9477bfd     	ldp	x29, x30, [sp, #0x70]
400040fc: 910343ff     	add	sp, sp, #0xd0
40004100: d65f03c0     	ret

0000000040004104 <vfs_init>:
40004104: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004108: a9044ff4     	stp	x20, x19, [sp, #0x40]
4000410c: d0000073     	adrp	x19, 0x40012000 <kernel_capture_buffer+0x3488>
40004110: 912e4273     	add	x19, x19, #0xb90
40004114: f9000bf9     	str	x25, [sp, #0x10]
40004118: d0000079     	adrp	x25, 0x40012000 <kernel_capture_buffer+0x3488>
4000411c: 52800034     	mov	w20, #0x1               // =1
40004120: aa1303e0     	mov	x0, x19
40004124: 2a1f03e1     	mov	w1, wzr
40004128: 52809802     	mov	w2, #0x4c0              // =1216
4000412c: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004130: 910003fd     	mov	x29, sp
40004134: a90357f6     	stp	x22, x21, [sp, #0x30]
40004138: b90b7b34     	str	w20, [x25, #0xb78]
4000413c: 97fff9b0     	bl	0x400027fc <memset>
40004140: 528005e8     	mov	w8, #0x2f               // =47
40004144: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004148: b9002274     	str	w20, [x19, #0x20]
4000414c: 79000268     	strh	w8, [x19]
40004150: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004154: f905c133     	str	x19, [x9, #0xb80]
40004158: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
4000415c: 7101fd1f     	cmp	w8, #0x7f
40004160: f9021a7f     	str	xzr, [x19, #0x430]
40004164: f900167f     	str	xzr, [x19, #0x28]
40004168: b904ba7f     	str	wzr, [x19, #0x4b8]
4000416c: f905c533     	str	x19, [x9, #0xb88]
40004170: 540028ac     	b.gt	0x40004684 <vfs_init+0x580>
40004174: 52809809     	mov	w9, #0x4c0              // =1216
40004178: 2a1f03e1     	mov	w1, wzr
4000417c: 52809802     	mov	w2, #0x4c0              // =1216
40004180: 9b294d17     	smaddl	x23, w8, w9, x19
40004184: 11000508     	add	w8, w8, #0x1
40004188: b90b7b28     	str	w8, [x25, #0xb78]
4000418c: aa1703e0     	mov	x0, x23
40004190: 97fff99b     	bl	0x400027fc <memset>
40004194: 528d2c48     	mov	w8, #0x6962             // =26978
40004198: b904baff     	str	wzr, [x23, #0x4b8]
4000419c: 72a00dc8     	movk	w8, #0x6e, lsl #16
400041a0: b90022f4     	str	w20, [x23, #0x20]
400041a4: b90002e8     	str	w8, [x23]
400041a8: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400041ac: f9021af3     	str	x19, [x23, #0x430]
400041b0: 71003d1f     	cmp	w8, #0xf
400041b4: f90016ff     	str	xzr, [x23, #0x28]
400041b8: 540000ac     	b.gt	0x400041cc <vfs_init+0xc8>
400041bc: 11000509     	add	w9, w8, #0x1
400041c0: 8b080e68     	add	x8, x19, x8, lsl #3
400041c4: b904ba69     	str	w9, [x19, #0x4b8]
400041c8: f9021d17     	str	x23, [x8, #0x438]
400041cc: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400041d0: 7101fd1f     	cmp	w8, #0x7f
400041d4: 5400258c     	b.gt	0x40004684 <vfs_init+0x580>
400041d8: 52809809     	mov	w9, #0x4c0              // =1216
400041dc: 2a1f03e1     	mov	w1, wzr
400041e0: 52809802     	mov	w2, #0x4c0              // =1216
400041e4: 9b294d16     	smaddl	x22, w8, w9, x19
400041e8: 11000508     	add	w8, w8, #0x1
400041ec: b90b7b28     	str	w8, [x25, #0xb78]
400041f0: aa1603e0     	mov	x0, x22
400041f4: 97fff982     	bl	0x400027fc <memset>
400041f8: 528e8ca8     	mov	w8, #0x7465             // =29797
400041fc: b904badf     	str	wzr, [x22, #0x4b8]
40004200: 52800029     	mov	w9, #0x1                // =1
40004204: 72a00c68     	movk	w8, #0x63, lsl #16
40004208: b90022c9     	str	w9, [x22, #0x20]
4000420c: b90002c8     	str	w8, [x22]
40004210: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004214: f9021ad3     	str	x19, [x22, #0x430]
40004218: 71003d1f     	cmp	w8, #0xf
4000421c: f90016df     	str	xzr, [x22, #0x28]
40004220: 540000ac     	b.gt	0x40004234 <vfs_init+0x130>
40004224: 11000509     	add	w9, w8, #0x1
40004228: 8b080e68     	add	x8, x19, x8, lsl #3
4000422c: b904ba69     	str	w9, [x19, #0x4b8]
40004230: f9021d16     	str	x22, [x8, #0x438]
40004234: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004238: 7101fd1f     	cmp	w8, #0x7f
4000423c: 5400224c     	b.gt	0x40004684 <vfs_init+0x580>
40004240: 52809809     	mov	w9, #0x4c0              // =1216
40004244: 2a1f03e1     	mov	w1, wzr
40004248: 52809802     	mov	w2, #0x4c0              // =1216
4000424c: 9b294d14     	smaddl	x20, w8, w9, x19
40004250: 11000508     	add	w8, w8, #0x1
40004254: b90b7b28     	str	w8, [x25, #0xb78]
40004258: aa1403e0     	mov	x0, x20
4000425c: 97fff968     	bl	0x400027fc <memset>
40004260: 528ded08     	mov	w8, #0x6f68             // =28520
40004264: b904ba9f     	str	wzr, [x20, #0x4b8]
40004268: 52800029     	mov	w9, #0x1                // =1
4000426c: 72acada8     	movk	w8, #0x656d, lsl #16
40004270: 3900129f     	strb	wzr, [x20, #0x4]
40004274: b9000288     	str	w8, [x20]
40004278: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000427c: b9002289     	str	w9, [x20, #0x20]
40004280: 71003d1f     	cmp	w8, #0xf
40004284: f9021a93     	str	x19, [x20, #0x430]
40004288: f900169f     	str	xzr, [x20, #0x28]
4000428c: 540000ac     	b.gt	0x400042a0 <vfs_init+0x19c>
40004290: 11000509     	add	w9, w8, #0x1
40004294: 8b080e68     	add	x8, x19, x8, lsl #3
40004298: b904ba69     	str	w9, [x19, #0x4b8]
4000429c: f9021d14     	str	x20, [x8, #0x438]
400042a0: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400042a4: 7101fd1f     	cmp	w8, #0x7f
400042a8: 54001eec     	b.gt	0x40004684 <vfs_init+0x580>
400042ac: 52809809     	mov	w9, #0x4c0              // =1216
400042b0: 2a1f03e1     	mov	w1, wzr
400042b4: 52809802     	mov	w2, #0x4c0              // =1216
400042b8: 9b294d15     	smaddl	x21, w8, w9, x19
400042bc: 11000508     	add	w8, w8, #0x1
400042c0: b90b7b28     	str	w8, [x25, #0xb78]
400042c4: aa1503e0     	mov	x0, x21
400042c8: 97fff94d     	bl	0x400027fc <memset>
400042cc: 528dec88     	mov	w8, #0x6f64             // =28516
400042d0: b904babf     	str	wzr, [x21, #0x4b8]
400042d4: 52800029     	mov	w9, #0x1                // =1
400042d8: 72ae6c68     	movk	w8, #0x7363, lsl #16
400042dc: 390012bf     	strb	wzr, [x21, #0x4]
400042e0: b90002a8     	str	w8, [x21]
400042e4: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400042e8: b90022a9     	str	w9, [x21, #0x20]
400042ec: 71003d1f     	cmp	w8, #0xf
400042f0: f9021ab3     	str	x19, [x21, #0x430]
400042f4: f90016bf     	str	xzr, [x21, #0x28]
400042f8: 540000ac     	b.gt	0x4000430c <vfs_init+0x208>
400042fc: 11000509     	add	w9, w8, #0x1
40004300: 8b080e68     	add	x8, x19, x8, lsl #3
40004304: b904ba69     	str	w9, [x19, #0x4b8]
40004308: f9021d15     	str	x21, [x8, #0x438]
4000430c: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004310: 7101fd1f     	cmp	w8, #0x7f
40004314: 54001b8c     	b.gt	0x40004684 <vfs_init+0x580>
40004318: 52809809     	mov	w9, #0x4c0              // =1216
4000431c: 2a1f03e1     	mov	w1, wzr
40004320: 52809802     	mov	w2, #0x4c0              // =1216
40004324: 9b294d18     	smaddl	x24, w8, w9, x19
40004328: 11000508     	add	w8, w8, #0x1
4000432c: b90b7b28     	str	w8, [x25, #0xb78]
40004330: aa1803e0     	mov	x0, x24
40004334: 97fff932     	bl	0x400027fc <memset>
40004338: 528d2c28     	mov	w8, #0x6961             // =26977
4000433c: b904bb1f     	str	wzr, [x24, #0x4b8]
40004340: 79000308     	strh	w8, [x24]
40004344: b984bae8     	ldrsw	x8, [x23, #0x4b8]
40004348: 39000b1f     	strb	wzr, [x24, #0x2]
4000434c: 71003d1f     	cmp	w8, #0xf
40004350: b900231f     	str	wzr, [x24, #0x20]
40004354: f9021b17     	str	x23, [x24, #0x430]
40004358: f900171f     	str	xzr, [x24, #0x28]
4000435c: 540000ac     	b.gt	0x40004370 <vfs_init+0x26c>
40004360: 8b080ee9     	add	x9, x23, x8, lsl #3
40004364: 11000508     	add	w8, w8, #0x1
40004368: b904bae8     	str	w8, [x23, #0x4b8]
4000436c: f9021d38     	str	x24, [x9, #0x438]
40004370: d503201f     	nop
40004374: 50020297     	adr	x23, 0x400083c6 <__rodata_start+0x23c6>
40004378: 9100c300     	add	x0, x24, #0x30
4000437c: aa1703e1     	mov	x1, x23
40004380: 97fff8f3     	bl	0x4000274c <kstrcpy>
40004384: aa1703e0     	mov	x0, x23
40004388: 97fff8c2     	bl	0x40002690 <kstrlen>
4000438c: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004390: f9001700     	str	x0, [x24, #0x28]
40004394: 7101fd1f     	cmp	w8, #0x7f
40004398: 5400176c     	b.gt	0x40004684 <vfs_init+0x580>
4000439c: 52809809     	mov	w9, #0x4c0              // =1216
400043a0: 2a1f03e1     	mov	w1, wzr
400043a4: 52809802     	mov	w2, #0x4c0              // =1216
400043a8: 9b294d17     	smaddl	x23, w8, w9, x19
400043ac: 11000508     	add	w8, w8, #0x1
400043b0: b90b7b28     	str	w8, [x25, #0xb78]
400043b4: aa1703e0     	mov	x0, x23
400043b8: 97fff911     	bl	0x400027fc <memset>
400043bc: d28e6de8     	mov	x8, #0x736f             // =29551
400043c0: b904baff     	str	wzr, [x23, #0x4b8]
400043c4: 528cae69     	mov	w9, #0x6573             // =25971
400043c8: f2ae45a8     	movk	x8, #0x722d, lsl #16
400043cc: 790012e9     	strh	w9, [x23, #0x8]
400043d0: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
400043d4: 39002aff     	strb	wzr, [x23, #0xa]
400043d8: f2ec2ca8     	movk	x8, #0x6165, lsl #48
400043dc: b90022ff     	str	wzr, [x23, #0x20]
400043e0: f90002e8     	str	x8, [x23]
400043e4: b984bac8     	ldrsw	x8, [x22, #0x4b8]
400043e8: f9021af6     	str	x22, [x23, #0x430]
400043ec: 71003d1f     	cmp	w8, #0xf
400043f0: f90016ff     	str	xzr, [x23, #0x28]
400043f4: 540000ac     	b.gt	0x40004408 <vfs_init+0x304>
400043f8: 8b080ec9     	add	x9, x22, x8, lsl #3
400043fc: 11000508     	add	w8, w8, #0x1
40004400: b904bac8     	str	w8, [x22, #0x4b8]
40004404: f9021d37     	str	x23, [x9, #0x438]
40004408: d0000016     	adrp	x22, 0x40006000 <__rodata_start>
4000440c: 91374ad6     	add	x22, x22, #0xdd2
40004410: 9100c2e0     	add	x0, x23, #0x30
40004414: aa1603e1     	mov	x1, x22
40004418: 97fff8cd     	bl	0x4000274c <kstrcpy>
4000441c: aa1603e0     	mov	x0, x22
40004420: 97fff89c     	bl	0x40002690 <kstrlen>
40004424: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004428: f90016e0     	str	x0, [x23, #0x28]
4000442c: 7101fd1f     	cmp	w8, #0x7f
40004430: 540012ac     	b.gt	0x40004684 <vfs_init+0x580>
40004434: 52809809     	mov	w9, #0x4c0              // =1216
40004438: 2a1f03e1     	mov	w1, wzr
4000443c: 52809802     	mov	w2, #0x4c0              // =1216
40004440: 9b294d16     	smaddl	x22, w8, w9, x19
40004444: 11000508     	add	w8, w8, #0x1
40004448: b90b7b28     	str	w8, [x25, #0xb78]
4000444c: aa1603e0     	mov	x0, x22
40004450: 97fff8eb     	bl	0x400027fc <memset>
40004454: d28caee8     	mov	x8, #0x6577             // =25975
40004458: b904badf     	str	wzr, [x22, #0x4b8]
4000445c: 528f0e89     	mov	w9, #0x7874             // =30836
40004460: f2ac6d88     	movk	x8, #0x636c, lsl #16
40004464: 72a00e89     	movk	w9, #0x74, lsl #16
40004468: b90022df     	str	wzr, [x22, #0x20]
4000446c: f2cdade8     	movk	x8, #0x6d6f, lsl #32
40004470: b9000ac9     	str	w9, [x22, #0x8]
40004474: f2e5cca8     	movk	x8, #0x2e65, lsl #48
40004478: f9021ad5     	str	x21, [x22, #0x430]
4000447c: f90002c8     	str	x8, [x22]
40004480: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004484: f90016df     	str	xzr, [x22, #0x28]
40004488: 71003d1f     	cmp	w8, #0xf
4000448c: 540000ac     	b.gt	0x400044a0 <vfs_init+0x39c>
40004490: 8b080ea9     	add	x9, x21, x8, lsl #3
40004494: 11000508     	add	w8, w8, #0x1
40004498: b904baa8     	str	w8, [x21, #0x4b8]
4000449c: f9021d36     	str	x22, [x9, #0x438]
400044a0: d0000017     	adrp	x23, 0x40006000 <__rodata_start>
400044a4: 913ceaf7     	add	x23, x23, #0xf3a
400044a8: 9100c2c0     	add	x0, x22, #0x30
400044ac: aa1703e1     	mov	x1, x23
400044b0: 97fff8a7     	bl	0x4000274c <kstrcpy>
400044b4: aa1703e0     	mov	x0, x23
400044b8: 97fff876     	bl	0x40002690 <kstrlen>
400044bc: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400044c0: f90016c0     	str	x0, [x22, #0x28]
400044c4: 7101fd1f     	cmp	w8, #0x7f
400044c8: 54000dec     	b.gt	0x40004684 <vfs_init+0x580>
400044cc: 52809809     	mov	w9, #0x4c0              // =1216
400044d0: 2a1f03e1     	mov	w1, wzr
400044d4: 52809802     	mov	w2, #0x4c0              // =1216
400044d8: 9b294d16     	smaddl	x22, w8, w9, x19
400044dc: 11000508     	add	w8, w8, #0x1
400044e0: b90b7b28     	str	w8, [x25, #0xb78]
400044e4: aa1603e0     	mov	x0, x22
400044e8: 97fff8c5     	bl	0x400027fc <memset>
400044ec: d28c2d08     	mov	x8, #0x6168             // =24936
400044f0: b904badf     	str	wzr, [x22, #0x4b8]
400044f4: 528e85c9     	mov	w9, #0x742e             // =29742
400044f8: f2ac8e48     	movk	x8, #0x6472, lsl #16
400044fc: 72ae8f09     	movk	w9, #0x7478, lsl #16
40004500: 390032df     	strb	wzr, [x22, #0xc]
40004504: f2cc2ee8     	movk	x8, #0x6177, lsl #32
40004508: b9000ac9     	str	w9, [x22, #0x8]
4000450c: f2ecae48     	movk	x8, #0x6572, lsl #48
40004510: b90022df     	str	wzr, [x22, #0x20]
40004514: f90002c8     	str	x8, [x22]
40004518: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000451c: f9021ad5     	str	x21, [x22, #0x430]
40004520: 71003d1f     	cmp	w8, #0xf
40004524: f90016df     	str	xzr, [x22, #0x28]
40004528: 540000ac     	b.gt	0x4000453c <vfs_init+0x438>
4000452c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004530: 11000508     	add	w8, w8, #0x1
40004534: b904baa8     	str	w8, [x21, #0x4b8]
40004538: f9021d36     	str	x22, [x9, #0x438]
4000453c: f0000017     	adrp	x23, 0x40007000 <__rodata_start+0x1000>
40004540: 910ae2f7     	add	x23, x23, #0x2b8
40004544: 9100c2c0     	add	x0, x22, #0x30
40004548: aa1703e1     	mov	x1, x23
4000454c: 97fff880     	bl	0x4000274c <kstrcpy>
40004550: aa1703e0     	mov	x0, x23
40004554: 97fff84f     	bl	0x40002690 <kstrlen>
40004558: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000455c: f90016c0     	str	x0, [x22, #0x28]
40004560: 7101fd1f     	cmp	w8, #0x7f
40004564: 5400090c     	b.gt	0x40004684 <vfs_init+0x580>
40004568: 52809809     	mov	w9, #0x4c0              // =1216
4000456c: 2a1f03e1     	mov	w1, wzr
40004570: 52809802     	mov	w2, #0x4c0              // =1216
40004574: 9b294d16     	smaddl	x22, w8, w9, x19
40004578: 11000508     	add	w8, w8, #0x1
4000457c: b90b7b28     	str	w8, [x25, #0xb78]
40004580: aa1603e0     	mov	x0, x22
40004584: 97fff89e     	bl	0x400027fc <memset>
40004588: 528d2c28     	mov	w8, #0x6961             // =26977
4000458c: b904badf     	str	wzr, [x22, #0x4b8]
40004590: 528e8f09     	mov	w9, #0x7478             // =29816
40004594: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004598: 79000ac9     	strh	w9, [x22, #0x4]
4000459c: b90002c8     	str	w8, [x22]
400045a0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400045a4: 39001adf     	strb	wzr, [x22, #0x6]
400045a8: 71003d1f     	cmp	w8, #0xf
400045ac: b90022df     	str	wzr, [x22, #0x20]
400045b0: f9021ad5     	str	x21, [x22, #0x430]
400045b4: f90016df     	str	xzr, [x22, #0x28]
400045b8: 540000ac     	b.gt	0x400045cc <vfs_init+0x4c8>
400045bc: 8b080ea9     	add	x9, x21, x8, lsl #3
400045c0: 11000508     	add	w8, w8, #0x1
400045c4: b904baa8     	str	w8, [x21, #0x4b8]
400045c8: f9021d36     	str	x22, [x9, #0x438]
400045cc: 90000035     	adrp	x21, 0x40008000 <__rodata_start+0x2000>
400045d0: 9105a6b5     	add	x21, x21, #0x169
400045d4: 9100c2c0     	add	x0, x22, #0x30
400045d8: aa1503e1     	mov	x1, x21
400045dc: 97fff85c     	bl	0x4000274c <kstrcpy>
400045e0: aa1503e0     	mov	x0, x21
400045e4: 97fff82b     	bl	0x40002690 <kstrlen>
400045e8: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400045ec: f90016c0     	str	x0, [x22, #0x28]
400045f0: 7101fd1f     	cmp	w8, #0x7f
400045f4: 5400048c     	b.gt	0x40004684 <vfs_init+0x580>
400045f8: 52809809     	mov	w9, #0x4c0              // =1216
400045fc: 2a1f03e1     	mov	w1, wzr
40004600: 52809802     	mov	w2, #0x4c0              // =1216
40004604: 9b294d13     	smaddl	x19, w8, w9, x19
40004608: 11000508     	add	w8, w8, #0x1
4000460c: b90b7b28     	str	w8, [x25, #0xb78]
40004610: aa1303e0     	mov	x0, x19
40004614: 97fff87a     	bl	0x400027fc <memset>
40004618: d28cae48     	mov	x8, #0x6572             // =25970
4000461c: b904ba7f     	str	wzr, [x19, #0x4b8]
40004620: 528e8f09     	mov	w9, #0x7478             // =29816
40004624: f2ac8c28     	movk	x8, #0x6461, lsl #16
40004628: 79001269     	strh	w9, [x19, #0x8]
4000462c: f2ccada8     	movk	x8, #0x656d, lsl #32
40004630: 39002a7f     	strb	wzr, [x19, #0xa]
40004634: f2ee85c8     	movk	x8, #0x742e, lsl #48
40004638: b900227f     	str	wzr, [x19, #0x20]
4000463c: f9000268     	str	x8, [x19]
40004640: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004644: f9021a74     	str	x20, [x19, #0x430]
40004648: 71003d1f     	cmp	w8, #0xf
4000464c: f900167f     	str	xzr, [x19, #0x28]
40004650: 540000ac     	b.gt	0x40004664 <vfs_init+0x560>
40004654: 8b080e89     	add	x9, x20, x8, lsl #3
40004658: 11000508     	add	w8, w8, #0x1
4000465c: b904ba88     	str	w8, [x20, #0x4b8]
40004660: f9021d33     	str	x19, [x9, #0x438]
40004664: d0000014     	adrp	x20, 0x40006000 <__rodata_start>
40004668: 910efa94     	add	x20, x20, #0x3be
4000466c: 9100c260     	add	x0, x19, #0x30
40004670: aa1403e1     	mov	x1, x20
40004674: 97fff836     	bl	0x4000274c <kstrcpy>
40004678: aa1403e0     	mov	x0, x20
4000467c: 97fff805     	bl	0x40002690 <kstrlen>
40004680: f9001660     	str	x0, [x19, #0x28]
40004684: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004688: f9400bf9     	ldr	x25, [sp, #0x10]
4000468c: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004690: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004694: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004698: d65f03c0     	ret

000000004000469c <vfs_load_internal>:
4000469c: 2a1f03e0     	mov	w0, wzr
400046a0: d65f03c0     	ret

00000000400046a4 <vfs_get_root>:
400046a4: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
400046a8: f945c100     	ldr	x0, [x8, #0xb80]
400046ac: d65f03c0     	ret

00000000400046b0 <vfs_get_cwd>:
400046b0: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
400046b4: f945c500     	ldr	x0, [x8, #0xb88]
400046b8: d65f03c0     	ret

00000000400046bc <vfs_getcwd>:
400046bc: d10343ff     	sub	sp, sp, #0xd0
400046c0: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
400046c4: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
400046c8: aa0003f3     	mov	x19, x0
400046cc: f945c508     	ldr	x8, [x8, #0xb88]
400046d0: a9087bfd     	stp	x29, x30, [sp, #0x80]
400046d4: 910203fd     	add	x29, sp, #0x80
400046d8: a90967fa     	stp	x26, x25, [sp, #0x90]
400046dc: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
400046e0: a90b57f6     	stp	x22, x21, [sp, #0xb0]
400046e4: b4000228     	cbz	x8, 0x40004728 <vfs_getcwd+0x6c>
400046e8: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
400046ec: f945c129     	ldr	x9, [x9, #0xb80]
400046f0: eb09011f     	cmp	x8, x9
400046f4: 540001a0     	b.eq	0x40004728 <vfs_getcwd+0x6c>
400046f8: aa1f03ea     	mov	x10, xzr
400046fc: 910003eb     	mov	x11, sp
40004700: eb09011f     	cmp	x8, x9
40004704: 540001c0     	b.eq	0x4000473c <vfs_getcwd+0x80>
40004708: f1003d5f     	cmp	x10, #0xf
4000470c: 54000188     	b.hi	0x4000473c <vfs_getcwd+0x80>
40004710: f82a7968     	str	x8, [x11, x10, lsl #3]
40004714: f9421908     	ldr	x8, [x8, #0x430]
40004718: 9100054c     	add	x12, x10, #0x1
4000471c: aa0c03ea     	mov	x10, x12
40004720: b5ffff08     	cbnz	x8, 0x40004700 <vfs_getcwd+0x44>
40004724: 14000007     	b	0x40004740 <vfs_getcwd+0x84>
40004728: f100083f     	cmp	x1, #0x2
4000472c: 54000563     	b.lo	0x400047d8 <vfs_getcwd+0x11c>
40004730: 528005e8     	mov	w8, #0x2f               // =47
40004734: 79000268     	strh	w8, [x19]
40004738: 14000028     	b	0x400047d8 <vfs_getcwd+0x11c>
4000473c: aa0a03ec     	mov	x12, x10
40004740: 7100059f     	cmp	w12, #0x1
40004744: 3900027f     	strb	wzr, [x19]
40004748: 5400048b     	b.lt	0x400047d8 <vfs_getcwd+0x11c>
4000474c: aa1f03f5     	mov	x21, xzr
40004750: d1000436     	sub	x22, x1, #0x1
40004754: 92407999     	and	x25, x12, #0x7fffffff
40004758: 528005f7     	mov	w23, #0x2f              // =47
4000475c: 910003f8     	mov	x24, sp
40004760: 14000005     	b	0x40004774 <vfs_getcwd+0xb8>
40004764: 8b0a02b5     	add	x21, x21, x10
40004768: f100075f     	cmp	x26, #0x1
4000476c: 38356a7f     	strb	wzr, [x19, x21]
40004770: 54000349     	b.ls	0x400047d8 <vfs_getcwd+0x11c>
40004774: eb1602bf     	cmp	x21, x22
40004778: aa1903fa     	mov	x26, x25
4000477c: 54000082     	b.hs	0x4000478c <vfs_getcwd+0xd0>
40004780: 910006a8     	add	x8, x21, #0x1
40004784: 78356a77     	strh	w23, [x19, x21]
40004788: aa0803f5     	mov	x21, x8
4000478c: d1000759     	sub	x25, x26, #0x1
40004790: f8797b14     	ldr	x20, [x24, x25, lsl #3]
40004794: aa1403e0     	mov	x0, x20
40004798: 97fff7be     	bl	0x40002690 <kstrlen>
4000479c: b4fffe60     	cbz	x0, 0x40004768 <vfs_getcwd+0xac>
400047a0: eb1602bf     	cmp	x21, x22
400047a4: 54fffe22     	b.hs	0x40004768 <vfs_getcwd+0xac>
400047a8: aa1f03e9     	mov	x9, xzr
400047ac: 8b150268     	add	x8, x19, x21
400047b0: 9100052a     	add	x10, x9, #0x1
400047b4: 38696a8b     	ldrb	w11, [x20, x9]
400047b8: eb00015f     	cmp	x10, x0
400047bc: 3829690b     	strb	w11, [x8, x9]
400047c0: 54fffd22     	b.hs	0x40004764 <vfs_getcwd+0xa8>
400047c4: 8b150149     	add	x9, x10, x21
400047c8: eb16013f     	cmp	x9, x22
400047cc: aa0a03e9     	mov	x9, x10
400047d0: 54ffff03     	b.lo	0x400047b0 <vfs_getcwd+0xf4>
400047d4: 17ffffe4     	b	0x40004764 <vfs_getcwd+0xa8>
400047d8: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
400047dc: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
400047e0: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
400047e4: a94967fa     	ldp	x26, x25, [sp, #0x90]
400047e8: a9487bfd     	ldp	x29, x30, [sp, #0x80]
400047ec: 910343ff     	add	sp, sp, #0xd0
400047f0: d65f03c0     	ret

00000000400047f4 <vfs_find>:
400047f4: d10203ff     	sub	sp, sp, #0x80
400047f8: a9027bfd     	stp	x29, x30, [sp, #0x20]
400047fc: 910083fd     	add	x29, sp, #0x20
40004800: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004804: a90467fa     	stp	x26, x25, [sp, #0x40]
40004808: a9055ff8     	stp	x24, x23, [sp, #0x50]
4000480c: a90657f6     	stp	x22, x21, [sp, #0x60]
40004810: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004814: b4000a60     	cbz	x0, 0x40004960 <vfs_find+0x16c>
40004818: 39400008     	ldrb	w8, [x0]
4000481c: aa0003f4     	mov	x20, x0
40004820: 34000a08     	cbz	w8, 0x40004960 <vfs_find+0x16c>
40004824: 7100bd1f     	cmp	w8, #0x2f
40004828: 54000121     	b.ne	0x4000484c <vfs_find+0x58>
4000482c: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004830: 52800037     	mov	w23, #0x1               // =1
40004834: f945c113     	ldr	x19, [x8, #0xb80]
40004838: 38776a88     	ldrb	w8, [x20, x23]
4000483c: 7100bd1f     	cmp	w8, #0x2f
40004840: 540000e1     	b.ne	0x4000485c <vfs_find+0x68>
40004844: 910006f7     	add	x23, x23, #0x1
40004848: 17fffffc     	b	0x40004838 <vfs_find+0x44>
4000484c: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004850: aa1f03f7     	mov	x23, xzr
40004854: f945c533     	ldr	x19, [x9, #0xb88]
40004858: 14000002     	b	0x40004860 <vfs_find+0x6c>
4000485c: 34000848     	cbz	w8, 0x40004964 <vfs_find+0x170>
40004860: 91000698     	add	x24, x20, #0x1
40004864: d0000015     	adrp	x21, 0x40006000 <__rodata_start>
40004868: 9125ceb5     	add	x21, x21, #0x973
4000486c: 910003f9     	mov	x25, sp
40004870: f0000016     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
40004874: 910356d6     	add	x22, x22, #0xd5
40004878: 14000006     	b	0x40004890 <vfs_find+0x9c>
4000487c: f9421a68     	ldr	x8, [x19, #0x430]
40004880: f100011f     	cmp	x8, #0x0
40004884: 9a880273     	csel	x19, x19, x8, eq
40004888: 385ff348     	ldurb	w8, [x26, #-0x1]
4000488c: 340006c8     	cbz	w8, 0x40004964 <vfs_find+0x170>
40004890: 7100bd1f     	cmp	w8, #0x2f
40004894: 54000061     	b.ne	0x400048a0 <vfs_find+0xac>
40004898: aa1f03e9     	mov	x9, xzr
4000489c: 14000010     	b	0x400048dc <vfs_find+0xe8>
400048a0: aa1f03e9     	mov	x9, xzr
400048a4: 8b17030a     	add	x10, x24, x23
400048a8: 34000188     	cbz	w8, 0x400048d8 <vfs_find+0xe4>
400048ac: f100793f     	cmp	x9, #0x1e
400048b0: 54000148     	b.hi	0x400048d8 <vfs_find+0xe4>
400048b4: 38296b28     	strb	w8, [x25, x9]
400048b8: 38696948     	ldrb	w8, [x10, x9]
400048bc: 9100052b     	add	x11, x9, #0x1
400048c0: aa0b03e9     	mov	x9, x11
400048c4: 7100bd1f     	cmp	w8, #0x2f
400048c8: 54ffff01     	b.ne	0x400048a8 <vfs_find+0xb4>
400048cc: 8b0b02f7     	add	x23, x23, x11
400048d0: aa0b03e9     	mov	x9, x11
400048d4: 14000002     	b	0x400048dc <vfs_find+0xe8>
400048d8: 8b0902f7     	add	x23, x23, x9
400048dc: 8b17029a     	add	x26, x20, x23
400048e0: d10006f7     	sub	x23, x23, #0x1
400048e4: 38296b3f     	strb	wzr, [x25, x9]
400048e8: 38401748     	ldrb	w8, [x26], #0x1
400048ec: 910006f7     	add	x23, x23, #0x1
400048f0: 7100bd1f     	cmp	w8, #0x2f
400048f4: 54ffffa0     	b.eq	0x400048e8 <vfs_find+0xf4>
400048f8: 910003e0     	mov	x0, sp
400048fc: aa1503e1     	mov	x1, x21
40004900: 97fff774     	bl	0x400026d0 <kstrcmp>
40004904: 34fffc20     	cbz	w0, 0x40004888 <vfs_find+0x94>
40004908: 910003e0     	mov	x0, sp
4000490c: aa1603e1     	mov	x1, x22
40004910: 97fff770     	bl	0x400026d0 <kstrcmp>
40004914: 34fffb40     	cbz	w0, 0x4000487c <vfs_find+0x88>
40004918: b944ba68     	ldr	w8, [x19, #0x4b8]
4000491c: 7100051f     	cmp	w8, #0x1
40004920: 5400020b     	b.lt	0x40004960 <vfs_find+0x16c>
40004924: aa1f03fb     	mov	x27, xzr
40004928: 9110e27c     	add	x28, x19, #0x438
4000492c: 14000005     	b	0x40004940 <vfs_find+0x14c>
40004930: b944ba68     	ldr	w8, [x19, #0x4b8]
40004934: 9100077b     	add	x27, x27, #0x1
40004938: eb28c37f     	cmp	x27, w8, sxtw
4000493c: 5400012a     	b.ge	0x40004960 <vfs_find+0x16c>
40004940: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004944: b4ffff80     	cbz	x0, 0x40004934 <vfs_find+0x140>
40004948: 910003e1     	mov	x1, sp
4000494c: 97fff761     	bl	0x400026d0 <kstrcmp>
40004950: 35ffff00     	cbnz	w0, 0x40004930 <vfs_find+0x13c>
40004954: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004958: b5fff993     	cbnz	x19, 0x40004888 <vfs_find+0x94>
4000495c: 14000002     	b	0x40004964 <vfs_find+0x170>
40004960: aa1f03f3     	mov	x19, xzr
40004964: aa1303e0     	mov	x0, x19
40004968: a9474ff4     	ldp	x20, x19, [sp, #0x70]
4000496c: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004970: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004974: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004978: a9436ffc     	ldp	x28, x27, [sp, #0x30]
4000497c: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004980: 910203ff     	add	sp, sp, #0x80
40004984: d65f03c0     	ret

0000000040004988 <vfs_chdir>:
40004988: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000498c: f9000bf3     	str	x19, [sp, #0x10]
40004990: 910003fd     	mov	x29, sp
40004994: b4000200     	cbz	x0, 0x400049d4 <vfs_chdir+0x4c>
40004998: 39400008     	ldrb	w8, [x0]
4000499c: 340001c8     	cbz	w8, 0x400049d4 <vfs_chdir+0x4c>
400049a0: 90000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400049a4: 91036021     	add	x1, x1, #0xd8
400049a8: aa0003f3     	mov	x19, x0
400049ac: 97fff749     	bl	0x400026d0 <kstrcmp>
400049b0: 34000120     	cbz	w0, 0x400049d4 <vfs_chdir+0x4c>
400049b4: aa1303e0     	mov	x0, x19
400049b8: 97ffff8f     	bl	0x400047f4 <vfs_find>
400049bc: b40002c0     	cbz	x0, 0x40004a14 <vfs_chdir+0x8c>
400049c0: b9402008     	ldr	w8, [x0, #0x20]
400049c4: 7100051f     	cmp	w8, #0x1
400049c8: 54000180     	b.eq	0x400049f8 <vfs_chdir+0x70>
400049cc: 12800028     	mov	w8, #-0x2               // =-2
400049d0: 1400000d     	b	0x40004a04 <vfs_chdir+0x7c>
400049d4: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
400049d8: 913ebc00     	add	x0, x0, #0xfaf
400049dc: 97ffff86     	bl	0x400047f4 <vfs_find>
400049e0: b4000080     	cbz	x0, 0x400049f0 <vfs_chdir+0x68>
400049e4: b9402008     	ldr	w8, [x0, #0x20]
400049e8: 7100051f     	cmp	w8, #0x1
400049ec: 54000060     	b.eq	0x400049f8 <vfs_chdir+0x70>
400049f0: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
400049f4: f945c100     	ldr	x0, [x8, #0xb80]
400049f8: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
400049fc: 2a1f03e8     	mov	w8, wzr
40004a00: f905c520     	str	x0, [x9, #0xb88]
40004a04: f9400bf3     	ldr	x19, [sp, #0x10]
40004a08: 2a0803e0     	mov	w0, w8
40004a0c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004a10: d65f03c0     	ret
40004a14: 12800008     	mov	w8, #-0x1               // =-1
40004a18: 17fffffb     	b	0x40004a04 <vfs_chdir+0x7c>

0000000040004a1c <vfs_mkdir>:
40004a1c: b40001e0     	cbz	x0, 0x40004a58 <vfs_mkdir+0x3c>
40004a20: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004a24: 39400008     	ldrb	w8, [x0]
40004a28: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004a2c: aa0003f3     	mov	x19, x0
40004a30: a90157f6     	stp	x22, x21, [sp, #0x10]
40004a34: 910003fd     	mov	x29, sp
40004a38: 34000148     	cbz	w8, 0x40004a60 <vfs_mkdir+0x44>
40004a3c: d0000074     	adrp	x20, 0x40012000 <kernel_capture_buffer+0x3488>
40004a40: f945c695     	ldr	x21, [x20, #0xb88]
40004a44: b944baa8     	ldr	w8, [x21, #0x4b8]
40004a48: 71003d1f     	cmp	w8, #0xf
40004a4c: 540000ed     	b.le	0x40004a68 <vfs_mkdir+0x4c>
40004a50: 12800020     	mov	w0, #-0x2               // =-2
40004a54: 14000043     	b	0x40004b60 <vfs_mkdir+0x144>
40004a58: 12800000     	mov	w0, #-0x1               // =-1
40004a5c: d65f03c0     	ret
40004a60: 12800000     	mov	w0, #-0x1               // =-1
40004a64: 1400003f     	b	0x40004b60 <vfs_mkdir+0x144>
40004a68: 7100051f     	cmp	w8, #0x1
40004a6c: 540001eb     	b.lt	0x40004aa8 <vfs_mkdir+0x8c>
40004a70: aa1f03f6     	mov	x22, xzr
40004a74: 14000005     	b	0x40004a88 <vfs_mkdir+0x6c>
40004a78: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004a7c: 910006d6     	add	x22, x22, #0x1
40004a80: eb0802df     	cmp	x22, x8
40004a84: 5400012a     	b.ge	0x40004aa8 <vfs_mkdir+0x8c>
40004a88: 8b160ea8     	add	x8, x21, x22, lsl #3
40004a8c: f9421d00     	ldr	x0, [x8, #0x438]
40004a90: b4ffff40     	cbz	x0, 0x40004a78 <vfs_mkdir+0x5c>
40004a94: aa1303e1     	mov	x1, x19
40004a98: 97fff70e     	bl	0x400026d0 <kstrcmp>
40004a9c: 340003e0     	cbz	w0, 0x40004b18 <vfs_mkdir+0xfc>
40004aa0: f945c695     	ldr	x21, [x20, #0xb88]
40004aa4: 17fffff5     	b	0x40004a78 <vfs_mkdir+0x5c>
40004aa8: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004aac: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004ab0: 7101fd3f     	cmp	w9, #0x7f
40004ab4: 5400006d     	b.le	0x40004ac0 <vfs_mkdir+0xa4>
40004ab8: 12800060     	mov	w0, #-0x4               // =-4
40004abc: 14000029     	b	0x40004b60 <vfs_mkdir+0x144>
40004ac0: 5280980a     	mov	w10, #0x4c0             // =1216
40004ac4: d000006b     	adrp	x11, 0x40012000 <kernel_capture_buffer+0x3488>
40004ac8: 912e416b     	add	x11, x11, #0xb90
40004acc: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004ad0: 11000529     	add	w9, w9, #0x1
40004ad4: 2a1f03e1     	mov	w1, wzr
40004ad8: 52809802     	mov	w2, #0x4c0              // =1216
40004adc: b90b7909     	str	w9, [x8, #0xb78]
40004ae0: aa1403e0     	mov	x0, x20
40004ae4: 97fff746     	bl	0x400027fc <memset>
40004ae8: 39400268     	ldrb	w8, [x19]
40004aec: 340001a8     	cbz	w8, 0x40004b20 <vfs_mkdir+0x104>
40004af0: aa1f03ea     	mov	x10, xzr
40004af4: 91000669     	add	x9, x19, #0x1
40004af8: 382a6a88     	strb	w8, [x20, x10]
40004afc: 9100054b     	add	x11, x10, #0x1
40004b00: 386a6928     	ldrb	w8, [x9, x10]
40004b04: 34000108     	cbz	w8, 0x40004b24 <vfs_mkdir+0x108>
40004b08: f100795f     	cmp	x10, #0x1e
40004b0c: aa0b03ea     	mov	x10, x11
40004b10: 54ffff43     	b.lo	0x40004af8 <vfs_mkdir+0xdc>
40004b14: 14000004     	b	0x40004b24 <vfs_mkdir+0x108>
40004b18: 12800040     	mov	w0, #-0x3               // =-3
40004b1c: 14000011     	b	0x40004b60 <vfs_mkdir+0x144>
40004b20: aa1f03eb     	mov	x11, xzr
40004b24: 382b6a9f     	strb	wzr, [x20, x11]
40004b28: 2a1f03e0     	mov	w0, wzr
40004b2c: 52800029     	mov	w9, #0x1                // =1
40004b30: b904ba9f     	str	wzr, [x20, #0x4b8]
40004b34: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004b38: b9002289     	str	w9, [x20, #0x20]
40004b3c: f9021a95     	str	x21, [x20, #0x430]
40004b40: 71003d1f     	cmp	w8, #0xf
40004b44: f900169f     	str	xzr, [x20, #0x28]
40004b48: 540000cc     	b.gt	0x40004b60 <vfs_mkdir+0x144>
40004b4c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004b50: 2a1f03e0     	mov	w0, wzr
40004b54: 11000508     	add	w8, w8, #0x1
40004b58: b904baa8     	str	w8, [x21, #0x4b8]
40004b5c: f9021d34     	str	x20, [x9, #0x438]
40004b60: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004b64: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004b68: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004b6c: d65f03c0     	ret

0000000040004b70 <vfs_sync>:
40004b70: d65f03c0     	ret

0000000040004b74 <vfs_touch>:
40004b74: b4000500     	cbz	x0, 0x40004c14 <vfs_touch+0xa0>
40004b78: 39400008     	ldrb	w8, [x0]
40004b7c: 340004c8     	cbz	w8, 0x40004c14 <vfs_touch+0xa0>
40004b80: d10583ff     	sub	sp, sp, #0x160
40004b84: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004b88: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004b8c: aa1f03f4     	mov	x20, xzr
40004b90: f945c533     	ldr	x19, [x9, #0xb88]
40004b94: aa0003e9     	mov	x9, x0
40004b98: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004b9c: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004ba0: 910483fd     	add	x29, sp, #0x120
40004ba4: a91457f6     	stp	x22, x21, [sp, #0x140]
40004ba8: 14000003     	b	0x40004bb4 <vfs_touch+0x40>
40004bac: aa0903f4     	mov	x20, x9
40004bb0: 38401d28     	ldrb	w8, [x9, #0x1]!
40004bb4: 7100bd1f     	cmp	w8, #0x2f
40004bb8: 54ffffa0     	b.eq	0x40004bac <vfs_touch+0x38>
40004bbc: 35ffffa8     	cbnz	w8, 0x40004bb0 <vfs_touch+0x3c>
40004bc0: b4000334     	cbz	x20, 0x40004c24 <vfs_touch+0xb0>
40004bc4: cb000288     	sub	x8, x20, x0
40004bc8: 52801fe9     	mov	w9, #0xff               // =255
40004bcc: aa0103f5     	mov	x21, x1
40004bd0: f103fd1f     	cmp	x8, #0xff
40004bd4: aa0003e1     	mov	x1, x0
40004bd8: 910083e0     	add	x0, sp, #0x20
40004bdc: 9a893113     	csel	x19, x8, x9, lo
40004be0: 910083f6     	add	x22, sp, #0x20
40004be4: aa1303e2     	mov	x2, x19
40004be8: 97fff6e0     	bl	0x40002768 <kstrncpy>
40004bec: 910083e0     	add	x0, sp, #0x20
40004bf0: 38336adf     	strb	wzr, [x22, x19]
40004bf4: 97ffff00     	bl	0x400047f4 <vfs_find>
40004bf8: b4000120     	cbz	x0, 0x40004c1c <vfs_touch+0xa8>
40004bfc: b9402008     	ldr	w8, [x0, #0x20]
40004c00: aa0003f3     	mov	x19, x0
40004c04: 7100051f     	cmp	w8, #0x1
40004c08: 540000a1     	b.ne	0x40004c1c <vfs_touch+0xa8>
40004c0c: 91000688     	add	x8, x20, #0x1
40004c10: 14000007     	b	0x40004c2c <vfs_touch+0xb8>
40004c14: 12800000     	mov	w0, #-0x1               // =-1
40004c18: d65f03c0     	ret
40004c1c: 12800000     	mov	w0, #-0x1               // =-1
40004c20: 1400006a     	b	0x40004dc8 <vfs_touch+0x254>
40004c24: aa0003e8     	mov	x8, x0
40004c28: aa0103f5     	mov	x21, x1
40004c2c: 910003e0     	mov	x0, sp
40004c30: aa0803e1     	mov	x1, x8
40004c34: 528003e2     	mov	w2, #0x1f               // =31
40004c38: 97fff6cc     	bl	0x40002768 <kstrncpy>
40004c3c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004c40: 39007fff     	strb	wzr, [sp, #0x1f]
40004c44: 7100051f     	cmp	w8, #0x1
40004c48: 5400024b     	b.lt	0x40004c90 <vfs_touch+0x11c>
40004c4c: aa1f03f6     	mov	x22, xzr
40004c50: 9110e277     	add	x23, x19, #0x438
40004c54: 14000004     	b	0x40004c64 <vfs_touch+0xf0>
40004c58: 910006d6     	add	x22, x22, #0x1
40004c5c: eb28c2df     	cmp	x22, w8, sxtw
40004c60: 5400010a     	b.ge	0x40004c80 <vfs_touch+0x10c>
40004c64: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004c68: b4ffff80     	cbz	x0, 0x40004c58 <vfs_touch+0xe4>
40004c6c: 910003e1     	mov	x1, sp
40004c70: 97fff698     	bl	0x400026d0 <kstrcmp>
40004c74: 340004a0     	cbz	w0, 0x40004d08 <vfs_touch+0x194>
40004c78: b944ba68     	ldr	w8, [x19, #0x4b8]
40004c7c: 17fffff7     	b	0x40004c58 <vfs_touch+0xe4>
40004c80: 71003d1f     	cmp	w8, #0xf
40004c84: 5400006d     	b.le	0x40004c90 <vfs_touch+0x11c>
40004c88: 12800020     	mov	w0, #-0x2               // =-2
40004c8c: 1400004f     	b	0x40004dc8 <vfs_touch+0x254>
40004c90: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004c94: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004c98: 7101fd3f     	cmp	w9, #0x7f
40004c9c: 5400006d     	b.le	0x40004ca8 <vfs_touch+0x134>
40004ca0: 12800060     	mov	w0, #-0x4               // =-4
40004ca4: 14000049     	b	0x40004dc8 <vfs_touch+0x254>
40004ca8: 5280980a     	mov	w10, #0x4c0             // =1216
40004cac: d000006b     	adrp	x11, 0x40012000 <kernel_capture_buffer+0x3488>
40004cb0: 912e416b     	add	x11, x11, #0xb90
40004cb4: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004cb8: 11000529     	add	w9, w9, #0x1
40004cbc: 2a1f03e1     	mov	w1, wzr
40004cc0: 52809802     	mov	w2, #0x4c0              // =1216
40004cc4: b90b7909     	str	w9, [x8, #0xb78]
40004cc8: aa1403e0     	mov	x0, x20
40004ccc: 97fff6cc     	bl	0x400027fc <memset>
40004cd0: 394003e8     	ldrb	w8, [sp]
40004cd4: 340003e8     	cbz	w8, 0x40004d50 <vfs_touch+0x1dc>
40004cd8: 910003ea     	mov	x10, sp
40004cdc: aa1f03e9     	mov	x9, xzr
40004ce0: aa1503e0     	mov	x0, x21
40004ce4: b240014a     	orr	x10, x10, #0x1
40004ce8: 38296a88     	strb	w8, [x20, x9]
40004cec: 38696948     	ldrb	w8, [x10, x9]
40004cf0: 9100052b     	add	x11, x9, #0x1
40004cf4: 34000328     	cbz	w8, 0x40004d58 <vfs_touch+0x1e4>
40004cf8: f100793f     	cmp	x9, #0x1e
40004cfc: aa0b03e9     	mov	x9, x11
40004d00: 54ffff43     	b.lo	0x40004ce8 <vfs_touch+0x174>
40004d04: 14000015     	b	0x40004d58 <vfs_touch+0x1e4>
40004d08: b40005f5     	cbz	x21, 0x40004dc4 <vfs_touch+0x250>
40004d0c: aa1503e0     	mov	x0, x21
40004d10: 97fff660     	bl	0x40002690 <kstrlen>
40004d14: 52807fe8     	mov	w8, #0x3ff              // =1023
40004d18: f10ffc1f     	cmp	x0, #0x3ff
40004d1c: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004d20: 9a883014     	csel	x20, x0, x8, lo
40004d24: aa1503e1     	mov	x1, x21
40004d28: 9100c120     	add	x0, x9, #0x30
40004d2c: aa1403e2     	mov	x2, x20
40004d30: 97fff6c9     	bl	0x40002854 <memcpy>
40004d34: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004d38: 2a1f03e0     	mov	w0, wzr
40004d3c: 8b140108     	add	x8, x8, x20
40004d40: 3900c11f     	strb	wzr, [x8, #0x30]
40004d44: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004d48: f9001514     	str	x20, [x8, #0x28]
40004d4c: 1400001f     	b	0x40004dc8 <vfs_touch+0x254>
40004d50: aa1f03eb     	mov	x11, xzr
40004d54: aa1503e0     	mov	x0, x21
40004d58: 382b6a9f     	strb	wzr, [x20, x11]
40004d5c: b904ba9f     	str	wzr, [x20, #0x4b8]
40004d60: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004d64: b900229f     	str	wzr, [x20, #0x20]
40004d68: f9021a93     	str	x19, [x20, #0x430]
40004d6c: 71003d1f     	cmp	w8, #0xf
40004d70: f900169f     	str	xzr, [x20, #0x28]
40004d74: 540000ac     	b.gt	0x40004d88 <vfs_touch+0x214>
40004d78: 8b080e69     	add	x9, x19, x8, lsl #3
40004d7c: 11000508     	add	w8, w8, #0x1
40004d80: b904ba68     	str	w8, [x19, #0x4b8]
40004d84: f9021d34     	str	x20, [x9, #0x438]
40004d88: b4000200     	cbz	x0, 0x40004dc8 <vfs_touch+0x254>
40004d8c: aa0003f3     	mov	x19, x0
40004d90: 97fff640     	bl	0x40002690 <kstrlen>
40004d94: 52807fe8     	mov	w8, #0x3ff              // =1023
40004d98: f10ffc1f     	cmp	x0, #0x3ff
40004d9c: 9100c296     	add	x22, x20, #0x30
40004da0: 9a883015     	csel	x21, x0, x8, lo
40004da4: aa1603e0     	mov	x0, x22
40004da8: aa1303e1     	mov	x1, x19
40004dac: aa1503e2     	mov	x2, x21
40004db0: 97fff6a9     	bl	0x40002854 <memcpy>
40004db4: 2a1f03e0     	mov	w0, wzr
40004db8: 38356adf     	strb	wzr, [x22, x21]
40004dbc: f9001695     	str	x21, [x20, #0x28]
40004dc0: 14000002     	b	0x40004dc8 <vfs_touch+0x254>
40004dc4: 2a1f03e0     	mov	w0, wzr
40004dc8: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40004dcc: a95457f6     	ldp	x22, x21, [sp, #0x140]
40004dd0: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40004dd4: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40004dd8: 910583ff     	add	sp, sp, #0x160
40004ddc: d65f03c0     	ret

0000000040004de0 <vfs_write_file>:
40004de0: 17ffff65     	b	0x40004b74 <vfs_touch>

0000000040004de4 <vfs_remove>:
40004de4: b40005c0     	cbz	x0, 0x40004e9c <vfs_remove+0xb8>
40004de8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004dec: 39400008     	ldrb	w8, [x0]
40004df0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004df4: aa0003f3     	mov	x19, x0
40004df8: f9000bf5     	str	x21, [sp, #0x10]
40004dfc: 910003fd     	mov	x29, sp
40004e00: 34000448     	cbz	w8, 0x40004e88 <vfs_remove+0xa4>
40004e04: d0000074     	adrp	x20, 0x40012000 <kernel_capture_buffer+0x3488>
40004e08: f945c688     	ldr	x8, [x20, #0xb88]
40004e0c: b944b909     	ldr	w9, [x8, #0x4b8]
40004e10: 7100053f     	cmp	w9, #0x1
40004e14: 540003ab     	b.lt	0x40004e88 <vfs_remove+0xa4>
40004e18: aa1f03f5     	mov	x21, xzr
40004e1c: 14000005     	b	0x40004e30 <vfs_remove+0x4c>
40004e20: b984b909     	ldrsw	x9, [x8, #0x4b8]
40004e24: 910006b5     	add	x21, x21, #0x1
40004e28: eb0902bf     	cmp	x21, x9
40004e2c: 540002ea     	b.ge	0x40004e88 <vfs_remove+0xa4>
40004e30: 8b150d09     	add	x9, x8, x21, lsl #3
40004e34: f9421d20     	ldr	x0, [x9, #0x438]
40004e38: b4ffff40     	cbz	x0, 0x40004e20 <vfs_remove+0x3c>
40004e3c: aa1303e1     	mov	x1, x19
40004e40: 97fff624     	bl	0x400026d0 <kstrcmp>
40004e44: f945c688     	ldr	x8, [x20, #0xb88]
40004e48: 35fffec0     	cbnz	w0, 0x40004e20 <vfs_remove+0x3c>
40004e4c: b984b909     	ldrsw	x9, [x8, #0x4b8]
40004e50: d1000529     	sub	x9, x9, #0x1
40004e54: 6b15013f     	cmp	w9, w21
40004e58: 5400026d     	b.le	0x40004ea4 <vfs_remove+0xc0>
40004e5c: f945c68a     	ldr	x10, [x20, #0xb88]
40004e60: b984b949     	ldrsw	x9, [x10, #0x4b8]
40004e64: d1000529     	sub	x9, x9, #0x1
40004e68: 8b150d08     	add	x8, x8, x21, lsl #3
40004e6c: 910006b5     	add	x21, x21, #0x1
40004e70: eb0902bf     	cmp	x21, x9
40004e74: f942210b     	ldr	x11, [x8, #0x440]
40004e78: f9021d0b     	str	x11, [x8, #0x438]
40004e7c: aa0a03e8     	mov	x8, x10
40004e80: 54ffff4b     	b.lt	0x40004e68 <vfs_remove+0x84>
40004e84: 14000009     	b	0x40004ea8 <vfs_remove+0xc4>
40004e88: 12800000     	mov	w0, #-0x1               // =-1
40004e8c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004e90: f9400bf5     	ldr	x21, [sp, #0x10]
40004e94: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004e98: d65f03c0     	ret
40004e9c: 12800000     	mov	w0, #-0x1               // =-1
40004ea0: d65f03c0     	ret
40004ea4: aa0803ea     	mov	x10, x8
40004ea8: 8b090d48     	add	x8, x10, x9, lsl #3
40004eac: 2a1f03e0     	mov	w0, wzr
40004eb0: f9021d1f     	str	xzr, [x8, #0x438]
40004eb4: f945c688     	ldr	x8, [x20, #0xb88]
40004eb8: b944b909     	ldr	w9, [x8, #0x4b8]
40004ebc: 51000529     	sub	w9, w9, #0x1
40004ec0: b904b909     	str	w9, [x8, #0x4b8]
40004ec4: 17fffff2     	b	0x40004e8c <vfs_remove+0xa8>

0000000040004ec8 <vfs_list_dir>:
40004ec8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40004ecc: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004ed0: f100001f     	cmp	x0, #0x0
40004ed4: a90257f6     	stp	x22, x21, [sp, #0x20]
40004ed8: f945c508     	ldr	x8, [x8, #0xb88]
40004edc: f9000bf7     	str	x23, [sp, #0x10]
40004ee0: 910003fd     	mov	x29, sp
40004ee4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40004ee8: 9a800115     	csel	x21, x8, x0, eq
40004eec: b94022a8     	ldr	w8, [x21, #0x20]
40004ef0: 7100051f     	cmp	w8, #0x1
40004ef4: 54000521     	b.ne	0x40004f98 <vfs_list_dir+0xd0>
40004ef8: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004efc: 91387c00     	add	x0, x0, #0xe1f
40004f00: 97fff96d     	bl	0x400034b4 <uart_puts>
40004f04: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004f08: 91208c00     	add	x0, x0, #0x823
40004f0c: 97fff96a     	bl	0x400034b4 <uart_puts>
40004f10: f0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40004f14: 9132c400     	add	x0, x0, #0xcb1
40004f18: 97fff967     	bl	0x400034b4 <uart_puts>
40004f1c: f9421aa8     	ldr	x8, [x21, #0x430]
40004f20: b4000088     	cbz	x8, 0x40004f30 <vfs_list_dir+0x68>
40004f24: f0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40004f28: 910c5800     	add	x0, x0, #0x316
40004f2c: 97fff962     	bl	0x400034b4 <uart_puts>
40004f30: b944baa1     	ldr	w1, [x21, #0x4b8]
40004f34: 7100043f     	cmp	w1, #0x1
40004f38: 5400034b     	b.lt	0x40004fa0 <vfs_list_dir+0xd8>
40004f3c: aa1f03f6     	mov	x22, xzr
40004f40: f0000013     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
40004f44: 9128a273     	add	x19, x19, #0xa28
40004f48: 9110e2b7     	add	x23, x21, #0x438
40004f4c: f0000014     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40004f50: 91190e94     	add	x20, x20, #0x643
40004f54: 14000008     	b	0x40004f74 <vfs_list_dir+0xac>
40004f58: b9402841     	ldr	w1, [x2, #0x28]
40004f5c: aa1403e0     	mov	x0, x20
40004f60: 97fffa65     	bl	0x400038f4 <uart_printf>
40004f64: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40004f68: 910006d6     	add	x22, x22, #0x1
40004f6c: eb0102df     	cmp	x22, x1
40004f70: 5400018a     	b.ge	0x40004fa0 <vfs_list_dir+0xd8>
40004f74: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40004f78: b4ffff62     	cbz	x2, 0x40004f64 <vfs_list_dir+0x9c>
40004f7c: b9402048     	ldr	w8, [x2, #0x20]
40004f80: 7100051f     	cmp	w8, #0x1
40004f84: 54fffea1     	b.ne	0x40004f58 <vfs_list_dir+0x90>
40004f88: aa1303e0     	mov	x0, x19
40004f8c: aa0203e1     	mov	x1, x2
40004f90: 97fffa59     	bl	0x400038f4 <uart_printf>
40004f94: 17fffff4     	b	0x40004f64 <vfs_list_dir+0x9c>
40004f98: 12800000     	mov	w0, #-0x1               // =-1
40004f9c: 14000005     	b	0x40004fb0 <vfs_list_dir+0xe8>
40004fa0: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004fa4: 9125d400     	add	x0, x0, #0x975
40004fa8: 97fffa53     	bl	0x400038f4 <uart_printf>
40004fac: 2a1f03e0     	mov	w0, wzr
40004fb0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40004fb4: f9400bf7     	ldr	x23, [sp, #0x10]
40004fb8: a94257f6     	ldp	x22, x21, [sp, #0x20]
40004fbc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40004fc0: d65f03c0     	ret

0000000040004fc4 <vfs_load>:
40004fc4: d65f03c0     	ret
		...

0000000040005000 <exception_vector_table>:
40005000: 14000201     	b	0x40005804 <handle_sync_invalid>
40005004: d503201f     	nop
40005008: d503201f     	nop
4000500c: d503201f     	nop
40005010: d503201f     	nop
40005014: d503201f     	nop
40005018: d503201f     	nop
4000501c: d503201f     	nop
40005020: d503201f     	nop
40005024: d503201f     	nop
40005028: d503201f     	nop
4000502c: d503201f     	nop
40005030: d503201f     	nop
40005034: d503201f     	nop
40005038: d503201f     	nop
4000503c: d503201f     	nop
40005040: d503201f     	nop
40005044: d503201f     	nop
40005048: d503201f     	nop
4000504c: d503201f     	nop
40005050: d503201f     	nop
40005054: d503201f     	nop
40005058: d503201f     	nop
4000505c: d503201f     	nop
40005060: d503201f     	nop
40005064: d503201f     	nop
40005068: d503201f     	nop
4000506c: d503201f     	nop
40005070: d503201f     	nop
40005074: d503201f     	nop
40005078: d503201f     	nop
4000507c: d503201f     	nop

0000000040005080 <curr_el_sp0_irq>:
40005080: 14000206     	b	0x40005898 <handle_irq_invalid>
40005084: d503201f     	nop
40005088: d503201f     	nop
4000508c: d503201f     	nop
40005090: d503201f     	nop
40005094: d503201f     	nop
40005098: d503201f     	nop
4000509c: d503201f     	nop
400050a0: d503201f     	nop
400050a4: d503201f     	nop
400050a8: d503201f     	nop
400050ac: d503201f     	nop
400050b0: d503201f     	nop
400050b4: d503201f     	nop
400050b8: d503201f     	nop
400050bc: d503201f     	nop
400050c0: d503201f     	nop
400050c4: d503201f     	nop
400050c8: d503201f     	nop
400050cc: d503201f     	nop
400050d0: d503201f     	nop
400050d4: d503201f     	nop
400050d8: d503201f     	nop
400050dc: d503201f     	nop
400050e0: d503201f     	nop
400050e4: d503201f     	nop
400050e8: d503201f     	nop
400050ec: d503201f     	nop
400050f0: d503201f     	nop
400050f4: d503201f     	nop
400050f8: d503201f     	nop
400050fc: d503201f     	nop

0000000040005100 <curr_el_sp0_fiq>:
40005100: 1400020a     	b	0x40005928 <handle_fiq_invalid>
40005104: d503201f     	nop
40005108: d503201f     	nop
4000510c: d503201f     	nop
40005110: d503201f     	nop
40005114: d503201f     	nop
40005118: d503201f     	nop
4000511c: d503201f     	nop
40005120: d503201f     	nop
40005124: d503201f     	nop
40005128: d503201f     	nop
4000512c: d503201f     	nop
40005130: d503201f     	nop
40005134: d503201f     	nop
40005138: d503201f     	nop
4000513c: d503201f     	nop
40005140: d503201f     	nop
40005144: d503201f     	nop
40005148: d503201f     	nop
4000514c: d503201f     	nop
40005150: d503201f     	nop
40005154: d503201f     	nop
40005158: d503201f     	nop
4000515c: d503201f     	nop
40005160: d503201f     	nop
40005164: d503201f     	nop
40005168: d503201f     	nop
4000516c: d503201f     	nop
40005170: d503201f     	nop
40005174: d503201f     	nop
40005178: d503201f     	nop
4000517c: d503201f     	nop

0000000040005180 <curr_el_sp0_serror>:
40005180: 1400020e     	b	0x400059b8 <handle_serror_invalid>
40005184: d503201f     	nop
40005188: d503201f     	nop
4000518c: d503201f     	nop
40005190: d503201f     	nop
40005194: d503201f     	nop
40005198: d503201f     	nop
4000519c: d503201f     	nop
400051a0: d503201f     	nop
400051a4: d503201f     	nop
400051a8: d503201f     	nop
400051ac: d503201f     	nop
400051b0: d503201f     	nop
400051b4: d503201f     	nop
400051b8: d503201f     	nop
400051bc: d503201f     	nop
400051c0: d503201f     	nop
400051c4: d503201f     	nop
400051c8: d503201f     	nop
400051cc: d503201f     	nop
400051d0: d503201f     	nop
400051d4: d503201f     	nop
400051d8: d503201f     	nop
400051dc: d503201f     	nop
400051e0: d503201f     	nop
400051e4: d503201f     	nop
400051e8: d503201f     	nop
400051ec: d503201f     	nop
400051f0: d503201f     	nop
400051f4: d503201f     	nop
400051f8: d503201f     	nop
400051fc: d503201f     	nop

0000000040005200 <curr_el_spx_sync>:
40005200: d10403ff     	sub	sp, sp, #0x100
40005204: a90007e0     	stp	x0, x1, [sp]
40005208: a9010fe2     	stp	x2, x3, [sp, #0x10]
4000520c: a90217e4     	stp	x4, x5, [sp, #0x20]
40005210: a9031fe6     	stp	x6, x7, [sp, #0x30]
40005214: a90427e8     	stp	x8, x9, [sp, #0x40]
40005218: a9052fea     	stp	x10, x11, [sp, #0x50]
4000521c: a90637ec     	stp	x12, x13, [sp, #0x60]
40005220: a9073fee     	stp	x14, x15, [sp, #0x70]
40005224: a90847f0     	stp	x16, x17, [sp, #0x80]
40005228: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000522c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005230: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40005234: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40005238: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000523c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005240: f9007bfe     	str	x30, [sp, #0xf0]
40005244: 910003e0     	mov	x0, sp
40005248: 97ffeb84     	bl	0x40000058 <handle_sync_exception>
4000524c: a94007e0     	ldp	x0, x1, [sp]
40005250: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005254: a94217e4     	ldp	x4, x5, [sp, #0x20]
40005258: a9431fe6     	ldp	x6, x7, [sp, #0x30]
4000525c: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005260: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005264: a94637ec     	ldp	x12, x13, [sp, #0x60]
40005268: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000526c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005270: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005274: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40005278: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000527c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40005280: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40005284: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40005288: f9407bfe     	ldr	x30, [sp, #0xf0]
4000528c: 910403ff     	add	sp, sp, #0x100
40005290: d69f03e0     	eret
40005294: d503201f     	nop
40005298: d503201f     	nop
4000529c: d503201f     	nop
400052a0: d503201f     	nop
400052a4: d503201f     	nop
400052a8: d503201f     	nop
400052ac: d503201f     	nop
400052b0: d503201f     	nop
400052b4: d503201f     	nop
400052b8: d503201f     	nop
400052bc: d503201f     	nop
400052c0: d503201f     	nop
400052c4: d503201f     	nop
400052c8: d503201f     	nop
400052cc: d503201f     	nop
400052d0: d503201f     	nop
400052d4: d503201f     	nop
400052d8: d503201f     	nop
400052dc: d503201f     	nop
400052e0: d503201f     	nop
400052e4: d503201f     	nop
400052e8: d503201f     	nop
400052ec: d503201f     	nop
400052f0: d503201f     	nop
400052f4: d503201f     	nop
400052f8: d503201f     	nop
400052fc: d503201f     	nop

0000000040005300 <curr_el_spx_irq>:
40005300: 14000166     	b	0x40005898 <handle_irq_invalid>
40005304: d503201f     	nop
40005308: d503201f     	nop
4000530c: d503201f     	nop
40005310: d503201f     	nop
40005314: d503201f     	nop
40005318: d503201f     	nop
4000531c: d503201f     	nop
40005320: d503201f     	nop
40005324: d503201f     	nop
40005328: d503201f     	nop
4000532c: d503201f     	nop
40005330: d503201f     	nop
40005334: d503201f     	nop
40005338: d503201f     	nop
4000533c: d503201f     	nop
40005340: d503201f     	nop
40005344: d503201f     	nop
40005348: d503201f     	nop
4000534c: d503201f     	nop
40005350: d503201f     	nop
40005354: d503201f     	nop
40005358: d503201f     	nop
4000535c: d503201f     	nop
40005360: d503201f     	nop
40005364: d503201f     	nop
40005368: d503201f     	nop
4000536c: d503201f     	nop
40005370: d503201f     	nop
40005374: d503201f     	nop
40005378: d503201f     	nop
4000537c: d503201f     	nop

0000000040005380 <curr_el_spx_fiq>:
40005380: 1400016a     	b	0x40005928 <handle_fiq_invalid>
40005384: d503201f     	nop
40005388: d503201f     	nop
4000538c: d503201f     	nop
40005390: d503201f     	nop
40005394: d503201f     	nop
40005398: d503201f     	nop
4000539c: d503201f     	nop
400053a0: d503201f     	nop
400053a4: d503201f     	nop
400053a8: d503201f     	nop
400053ac: d503201f     	nop
400053b0: d503201f     	nop
400053b4: d503201f     	nop
400053b8: d503201f     	nop
400053bc: d503201f     	nop
400053c0: d503201f     	nop
400053c4: d503201f     	nop
400053c8: d503201f     	nop
400053cc: d503201f     	nop
400053d0: d503201f     	nop
400053d4: d503201f     	nop
400053d8: d503201f     	nop
400053dc: d503201f     	nop
400053e0: d503201f     	nop
400053e4: d503201f     	nop
400053e8: d503201f     	nop
400053ec: d503201f     	nop
400053f0: d503201f     	nop
400053f4: d503201f     	nop
400053f8: d503201f     	nop
400053fc: d503201f     	nop

0000000040005400 <curr_el_spx_serror>:
40005400: 1400016e     	b	0x400059b8 <handle_serror_invalid>
40005404: d503201f     	nop
40005408: d503201f     	nop
4000540c: d503201f     	nop
40005410: d503201f     	nop
40005414: d503201f     	nop
40005418: d503201f     	nop
4000541c: d503201f     	nop
40005420: d503201f     	nop
40005424: d503201f     	nop
40005428: d503201f     	nop
4000542c: d503201f     	nop
40005430: d503201f     	nop
40005434: d503201f     	nop
40005438: d503201f     	nop
4000543c: d503201f     	nop
40005440: d503201f     	nop
40005444: d503201f     	nop
40005448: d503201f     	nop
4000544c: d503201f     	nop
40005450: d503201f     	nop
40005454: d503201f     	nop
40005458: d503201f     	nop
4000545c: d503201f     	nop
40005460: d503201f     	nop
40005464: d503201f     	nop
40005468: d503201f     	nop
4000546c: d503201f     	nop
40005470: d503201f     	nop
40005474: d503201f     	nop
40005478: d503201f     	nop
4000547c: d503201f     	nop

0000000040005480 <lower_el_aarch64_sync>:
40005480: 140000e1     	b	0x40005804 <handle_sync_invalid>
40005484: d503201f     	nop
40005488: d503201f     	nop
4000548c: d503201f     	nop
40005490: d503201f     	nop
40005494: d503201f     	nop
40005498: d503201f     	nop
4000549c: d503201f     	nop
400054a0: d503201f     	nop
400054a4: d503201f     	nop
400054a8: d503201f     	nop
400054ac: d503201f     	nop
400054b0: d503201f     	nop
400054b4: d503201f     	nop
400054b8: d503201f     	nop
400054bc: d503201f     	nop
400054c0: d503201f     	nop
400054c4: d503201f     	nop
400054c8: d503201f     	nop
400054cc: d503201f     	nop
400054d0: d503201f     	nop
400054d4: d503201f     	nop
400054d8: d503201f     	nop
400054dc: d503201f     	nop
400054e0: d503201f     	nop
400054e4: d503201f     	nop
400054e8: d503201f     	nop
400054ec: d503201f     	nop
400054f0: d503201f     	nop
400054f4: d503201f     	nop
400054f8: d503201f     	nop
400054fc: d503201f     	nop

0000000040005500 <lower_el_aarch64_irq>:
40005500: 140000e6     	b	0x40005898 <handle_irq_invalid>
40005504: d503201f     	nop
40005508: d503201f     	nop
4000550c: d503201f     	nop
40005510: d503201f     	nop
40005514: d503201f     	nop
40005518: d503201f     	nop
4000551c: d503201f     	nop
40005520: d503201f     	nop
40005524: d503201f     	nop
40005528: d503201f     	nop
4000552c: d503201f     	nop
40005530: d503201f     	nop
40005534: d503201f     	nop
40005538: d503201f     	nop
4000553c: d503201f     	nop
40005540: d503201f     	nop
40005544: d503201f     	nop
40005548: d503201f     	nop
4000554c: d503201f     	nop
40005550: d503201f     	nop
40005554: d503201f     	nop
40005558: d503201f     	nop
4000555c: d503201f     	nop
40005560: d503201f     	nop
40005564: d503201f     	nop
40005568: d503201f     	nop
4000556c: d503201f     	nop
40005570: d503201f     	nop
40005574: d503201f     	nop
40005578: d503201f     	nop
4000557c: d503201f     	nop

0000000040005580 <lower_el_aarch64_fiq>:
40005580: 140000ea     	b	0x40005928 <handle_fiq_invalid>
40005584: d503201f     	nop
40005588: d503201f     	nop
4000558c: d503201f     	nop
40005590: d503201f     	nop
40005594: d503201f     	nop
40005598: d503201f     	nop
4000559c: d503201f     	nop
400055a0: d503201f     	nop
400055a4: d503201f     	nop
400055a8: d503201f     	nop
400055ac: d503201f     	nop
400055b0: d503201f     	nop
400055b4: d503201f     	nop
400055b8: d503201f     	nop
400055bc: d503201f     	nop
400055c0: d503201f     	nop
400055c4: d503201f     	nop
400055c8: d503201f     	nop
400055cc: d503201f     	nop
400055d0: d503201f     	nop
400055d4: d503201f     	nop
400055d8: d503201f     	nop
400055dc: d503201f     	nop
400055e0: d503201f     	nop
400055e4: d503201f     	nop
400055e8: d503201f     	nop
400055ec: d503201f     	nop
400055f0: d503201f     	nop
400055f4: d503201f     	nop
400055f8: d503201f     	nop
400055fc: d503201f     	nop

0000000040005600 <lower_el_aarch64_serror>:
40005600: 140000ee     	b	0x400059b8 <handle_serror_invalid>
40005604: d503201f     	nop
40005608: d503201f     	nop
4000560c: d503201f     	nop
40005610: d503201f     	nop
40005614: d503201f     	nop
40005618: d503201f     	nop
4000561c: d503201f     	nop
40005620: d503201f     	nop
40005624: d503201f     	nop
40005628: d503201f     	nop
4000562c: d503201f     	nop
40005630: d503201f     	nop
40005634: d503201f     	nop
40005638: d503201f     	nop
4000563c: d503201f     	nop
40005640: d503201f     	nop
40005644: d503201f     	nop
40005648: d503201f     	nop
4000564c: d503201f     	nop
40005650: d503201f     	nop
40005654: d503201f     	nop
40005658: d503201f     	nop
4000565c: d503201f     	nop
40005660: d503201f     	nop
40005664: d503201f     	nop
40005668: d503201f     	nop
4000566c: d503201f     	nop
40005670: d503201f     	nop
40005674: d503201f     	nop
40005678: d503201f     	nop
4000567c: d503201f     	nop

0000000040005680 <lower_el_aarch32_sync>:
40005680: 14000061     	b	0x40005804 <handle_sync_invalid>
40005684: d503201f     	nop
40005688: d503201f     	nop
4000568c: d503201f     	nop
40005690: d503201f     	nop
40005694: d503201f     	nop
40005698: d503201f     	nop
4000569c: d503201f     	nop
400056a0: d503201f     	nop
400056a4: d503201f     	nop
400056a8: d503201f     	nop
400056ac: d503201f     	nop
400056b0: d503201f     	nop
400056b4: d503201f     	nop
400056b8: d503201f     	nop
400056bc: d503201f     	nop
400056c0: d503201f     	nop
400056c4: d503201f     	nop
400056c8: d503201f     	nop
400056cc: d503201f     	nop
400056d0: d503201f     	nop
400056d4: d503201f     	nop
400056d8: d503201f     	nop
400056dc: d503201f     	nop
400056e0: d503201f     	nop
400056e4: d503201f     	nop
400056e8: d503201f     	nop
400056ec: d503201f     	nop
400056f0: d503201f     	nop
400056f4: d503201f     	nop
400056f8: d503201f     	nop
400056fc: d503201f     	nop

0000000040005700 <lower_el_aarch32_irq>:
40005700: 14000066     	b	0x40005898 <handle_irq_invalid>
40005704: d503201f     	nop
40005708: d503201f     	nop
4000570c: d503201f     	nop
40005710: d503201f     	nop
40005714: d503201f     	nop
40005718: d503201f     	nop
4000571c: d503201f     	nop
40005720: d503201f     	nop
40005724: d503201f     	nop
40005728: d503201f     	nop
4000572c: d503201f     	nop
40005730: d503201f     	nop
40005734: d503201f     	nop
40005738: d503201f     	nop
4000573c: d503201f     	nop
40005740: d503201f     	nop
40005744: d503201f     	nop
40005748: d503201f     	nop
4000574c: d503201f     	nop
40005750: d503201f     	nop
40005754: d503201f     	nop
40005758: d503201f     	nop
4000575c: d503201f     	nop
40005760: d503201f     	nop
40005764: d503201f     	nop
40005768: d503201f     	nop
4000576c: d503201f     	nop
40005770: d503201f     	nop
40005774: d503201f     	nop
40005778: d503201f     	nop
4000577c: d503201f     	nop

0000000040005780 <lower_el_aarch32_fiq>:
40005780: 1400006a     	b	0x40005928 <handle_fiq_invalid>
40005784: d503201f     	nop
40005788: d503201f     	nop
4000578c: d503201f     	nop
40005790: d503201f     	nop
40005794: d503201f     	nop
40005798: d503201f     	nop
4000579c: d503201f     	nop
400057a0: d503201f     	nop
400057a4: d503201f     	nop
400057a8: d503201f     	nop
400057ac: d503201f     	nop
400057b0: d503201f     	nop
400057b4: d503201f     	nop
400057b8: d503201f     	nop
400057bc: d503201f     	nop
400057c0: d503201f     	nop
400057c4: d503201f     	nop
400057c8: d503201f     	nop
400057cc: d503201f     	nop
400057d0: d503201f     	nop
400057d4: d503201f     	nop
400057d8: d503201f     	nop
400057dc: d503201f     	nop
400057e0: d503201f     	nop
400057e4: d503201f     	nop
400057e8: d503201f     	nop
400057ec: d503201f     	nop
400057f0: d503201f     	nop
400057f4: d503201f     	nop
400057f8: d503201f     	nop
400057fc: d503201f     	nop

0000000040005800 <lower_el_aarch32_serror>:
40005800: 1400006e     	b	0x400059b8 <handle_serror_invalid>

0000000040005804 <handle_sync_invalid>:
40005804: d10403ff     	sub	sp, sp, #0x100
40005808: a90007e0     	stp	x0, x1, [sp]
4000580c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40005810: a90217e4     	stp	x4, x5, [sp, #0x20]
40005814: a9031fe6     	stp	x6, x7, [sp, #0x30]
40005818: a90427e8     	stp	x8, x9, [sp, #0x40]
4000581c: a9052fea     	stp	x10, x11, [sp, #0x50]
40005820: a90637ec     	stp	x12, x13, [sp, #0x60]
40005824: a9073fee     	stp	x14, x15, [sp, #0x70]
40005828: a90847f0     	stp	x16, x17, [sp, #0x80]
4000582c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40005830: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005834: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40005838: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000583c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40005840: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005844: f9007bfe     	str	x30, [sp, #0xf0]
40005848: 910003e0     	mov	x0, sp
4000584c: 97ffea34     	bl	0x4000011c <c_handle_sync_invalid>
40005850: a94007e0     	ldp	x0, x1, [sp]
40005854: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005858: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000585c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005860: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005864: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005868: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000586c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005870: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005874: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005878: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000587c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40005880: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40005884: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40005888: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000588c: f9407bfe     	ldr	x30, [sp, #0xf0]
40005890: 910403ff     	add	sp, sp, #0x100
40005894: d69f03e0     	eret

0000000040005898 <handle_irq_invalid>:
40005898: d10403ff     	sub	sp, sp, #0x100
4000589c: a90007e0     	stp	x0, x1, [sp]
400058a0: a9010fe2     	stp	x2, x3, [sp, #0x10]
400058a4: a90217e4     	stp	x4, x5, [sp, #0x20]
400058a8: a9031fe6     	stp	x6, x7, [sp, #0x30]
400058ac: a90427e8     	stp	x8, x9, [sp, #0x40]
400058b0: a9052fea     	stp	x10, x11, [sp, #0x50]
400058b4: a90637ec     	stp	x12, x13, [sp, #0x60]
400058b8: a9073fee     	stp	x14, x15, [sp, #0x70]
400058bc: a90847f0     	stp	x16, x17, [sp, #0x80]
400058c0: a9094ff2     	stp	x18, x19, [sp, #0x90]
400058c4: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400058c8: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400058cc: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400058d0: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400058d4: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400058d8: f9007bfe     	str	x30, [sp, #0xf0]
400058dc: 97ffea1e     	bl	0x40000154 <c_handle_irq_invalid>
400058e0: a94007e0     	ldp	x0, x1, [sp]
400058e4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400058e8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400058ec: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400058f0: a94427e8     	ldp	x8, x9, [sp, #0x40]
400058f4: a9452fea     	ldp	x10, x11, [sp, #0x50]
400058f8: a94637ec     	ldp	x12, x13, [sp, #0x60]
400058fc: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005900: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005904: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005908: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000590c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40005910: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40005914: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40005918: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000591c: f9407bfe     	ldr	x30, [sp, #0xf0]
40005920: 910403ff     	add	sp, sp, #0x100
40005924: d69f03e0     	eret

0000000040005928 <handle_fiq_invalid>:
40005928: d10403ff     	sub	sp, sp, #0x100
4000592c: a90007e0     	stp	x0, x1, [sp]
40005930: a9010fe2     	stp	x2, x3, [sp, #0x10]
40005934: a90217e4     	stp	x4, x5, [sp, #0x20]
40005938: a9031fe6     	stp	x6, x7, [sp, #0x30]
4000593c: a90427e8     	stp	x8, x9, [sp, #0x40]
40005940: a9052fea     	stp	x10, x11, [sp, #0x50]
40005944: a90637ec     	stp	x12, x13, [sp, #0x60]
40005948: a9073fee     	stp	x14, x15, [sp, #0x70]
4000594c: a90847f0     	stp	x16, x17, [sp, #0x80]
40005950: a9094ff2     	stp	x18, x19, [sp, #0x90]
40005954: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005958: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
4000595c: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40005960: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40005964: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005968: f9007bfe     	str	x30, [sp, #0xf0]
4000596c: 97ffea00     	bl	0x4000016c <c_handle_fiq_invalid>
40005970: a94007e0     	ldp	x0, x1, [sp]
40005974: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005978: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000597c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005980: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005984: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005988: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000598c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005990: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005994: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005998: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000599c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400059a0: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400059a4: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400059a8: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400059ac: f9407bfe     	ldr	x30, [sp, #0xf0]
400059b0: 910403ff     	add	sp, sp, #0x100
400059b4: d69f03e0     	eret

00000000400059b8 <handle_serror_invalid>:
400059b8: d10403ff     	sub	sp, sp, #0x100
400059bc: a90007e0     	stp	x0, x1, [sp]
400059c0: a9010fe2     	stp	x2, x3, [sp, #0x10]
400059c4: a90217e4     	stp	x4, x5, [sp, #0x20]
400059c8: a9031fe6     	stp	x6, x7, [sp, #0x30]
400059cc: a90427e8     	stp	x8, x9, [sp, #0x40]
400059d0: a9052fea     	stp	x10, x11, [sp, #0x50]
400059d4: a90637ec     	stp	x12, x13, [sp, #0x60]
400059d8: a9073fee     	stp	x14, x15, [sp, #0x70]
400059dc: a90847f0     	stp	x16, x17, [sp, #0x80]
400059e0: a9094ff2     	stp	x18, x19, [sp, #0x90]
400059e4: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400059e8: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400059ec: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400059f0: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400059f4: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400059f8: f9007bfe     	str	x30, [sp, #0xf0]
400059fc: 97ffe9e2     	bl	0x40000184 <c_handle_serror_invalid>
40005a00: a94007e0     	ldp	x0, x1, [sp]
40005a04: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005a08: a94217e4     	ldp	x4, x5, [sp, #0x20]
40005a0c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005a10: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005a14: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005a18: a94637ec     	ldp	x12, x13, [sp, #0x60]
40005a1c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005a20: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005a24: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005a28: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40005a2c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40005a30: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40005a34: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40005a38: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40005a3c: f9407bfe     	ldr	x30, [sp, #0xf0]
40005a40: 910403ff     	add	sp, sp, #0x100
40005a44: d69f03e0     	eret

0000000040005a48 <trigger_undefined_instruction>:
40005a48: 00000000     	udf	#0x0
40005a4c: d65f03c0     	ret
