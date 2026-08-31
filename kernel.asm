
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
40000040: 90 9b 04 40  	.word	0x40049b90
40000044: 00 00 00 00  	.word	0x00000000
40000048: 00 b0 00 40  	.word	0x4000b000
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 90 9b 03 40  	.word	0x40039b90
40000054: 00 00 00 00  	.word	0x00000000

0000000040000058 <handle_sync_exception>:
40000058: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
4000005c: d503201f     	nop
40000060: 70042660     	adr	x0, 0x4000852f <__rodata_start+0x152f>
40000064: f9000bf5     	str	x21, [sp, #0x10]
40000068: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000006c: 910003fd     	mov	x29, sp
40000070: d5385214     	mrs	x20, ESR_EL1
40000074: d5384033     	mrs	x19, ELR_EL1
40000078: d5386015     	mrs	x21, FAR_EL1
4000007c: 94000d90     	bl	0x400036bc <uart_puts>
40000080: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000084: 91333800     	add	x0, x0, #0xcce
40000088: aa1403e1     	mov	x1, x20
4000008c: 94000e9c     	bl	0x40003afc <uart_printf>
40000090: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000094: 913ed400     	add	x0, x0, #0xfb5
40000098: aa1303e1     	mov	x1, x19
4000009c: 94000e98     	bl	0x40003afc <uart_printf>
400000a0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000a4: 91114c00     	add	x0, x0, #0x453
400000a8: aa1503e1     	mov	x1, x21
400000ac: 94000e94     	bl	0x40003afc <uart_printf>
400000b0: 531a7e94     	lsr	w20, w20, #26
400000b4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400000b8: 91104400     	add	x0, x0, #0x411
400000bc: 2a1403e1     	mov	w1, w20
400000c0: 94000e8f     	bl	0x40003afc <uart_printf>
400000c4: 35000094     	cbnz	w20, 0x400000d4 <handle_sync_exception+0x7c>
400000c8: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400000cc: 91000000     	add	x0, x0, #0x0
400000d0: 1400000a     	b	0x400000f8 <handle_sync_exception+0xa0>
400000d4: 7100929f     	cmp	w20, #0x24
400000d8: 540000c0     	b.eq	0x400000f0 <handle_sync_exception+0x98>
400000dc: 7100569f     	cmp	w20, #0x15
400000e0: 540000e1     	b.ne	0x400000fc <handle_sync_exception+0xa4>
400000e4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000e8: 910db000     	add	x0, x0, #0x36c
400000ec: 14000003     	b	0x400000f8 <handle_sync_exception+0xa0>
400000f0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400000f4: 91291c00     	add	x0, x0, #0xa47
400000f8: 94000d71     	bl	0x400036bc <uart_puts>
400000fc: 91001268     	add	x8, x19, #0x4
40000100: d5184028     	msr	ELR_EL1, x8
40000104: f9400bf5     	ldr	x21, [sp, #0x10]
40000108: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000010c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000110: 9103a400     	add	x0, x0, #0xe9
40000114: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40000118: 14000d69     	b	0x400036bc <uart_puts>

000000004000011c <c_handle_sync_invalid>:
4000011c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000120: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000124: 9138fc00     	add	x0, x0, #0xe3f
40000128: a9014ff4     	stp	x20, x19, [sp, #0x10]
4000012c: 910003fd     	mov	x29, sp
40000130: d5385213     	mrs	x19, ESR_EL1
40000134: d5384034     	mrs	x20, ELR_EL1
40000138: 94000e71     	bl	0x40003afc <uart_printf>
4000013c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000140: 912acc00     	add	x0, x0, #0xab3
40000144: aa1303e1     	mov	x1, x19
40000148: aa1403e2     	mov	x2, x20
4000014c: 94000e6c     	bl	0x40003afc <uart_printf>
40000150: 14000000     	b	0x40000150 <c_handle_sync_invalid+0x34>

0000000040000154 <c_handle_irq_invalid>:
40000154: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000158: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000015c: 91337c00     	add	x0, x0, #0xcdf
40000160: 910003fd     	mov	x29, sp
40000164: 94000d56     	bl	0x400036bc <uart_puts>
40000168: 14000000     	b	0x40000168 <c_handle_irq_invalid+0x14>

000000004000016c <c_handle_fiq_invalid>:
4000016c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000170: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000174: 91298400     	add	x0, x0, #0xa61
40000178: 910003fd     	mov	x29, sp
4000017c: 94000d50     	bl	0x400036bc <uart_puts>
40000180: 14000000     	b	0x40000180 <c_handle_fiq_invalid+0x14>

0000000040000184 <c_handle_serror_invalid>:
40000184: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000188: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000018c: 91036800     	add	x0, x0, #0xda
40000190: 910003fd     	mov	x29, sp
40000194: 94000d4a     	bl	0x400036bc <uart_puts>
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
400001c0: 10057213     	adr	x19, 0x4000b000 <__bss_start>
400001c4: aa0003f4     	mov	x20, x0
400001c8: aa1303e0     	mov	x0, x19
400001cc: 2a1f03e1     	mov	w1, wzr
400001d0: 52864a82     	mov	w2, #0x3254             // =12884
400001d4: 940009cf     	bl	0x40002910 <memset>
400001d8: aa1303e0     	mov	x0, x19
400001dc: aa1403e1     	mov	x1, x20
400001e0: 528007e2     	mov	w2, #0x3f               // =63
400001e4: 94000997     	bl	0x40002840 <kstrncpy>
400001e8: 5280003c     	mov	w28, #0x1               // =1
400001ec: aa1403e0     	mov	x0, x20
400001f0: b932427c     	str	w28, [x19, #0x3240]
400001f4: 9400121e     	bl	0x40004a6c <vfs_find>
400001f8: d0000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
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
40000294: 70042d00     	adr	x0, 0x40008837 <__rodata_start+0x1837>
40000298: 94000d09     	bl	0x400036bc <uart_puts>
4000029c: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
400002a0: 91326694     	add	x20, x20, #0xc99
400002a4: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
400002a8: 9104a6d6     	add	x22, x22, #0x129
400002ac: 90000058     	adrp	x24, 0x40008000 <__rodata_start+0x1000>
400002b0: 910dfb18     	add	x24, x24, #0x37e
400002b4: 90000059     	adrp	x25, 0x40008000 <__rodata_start+0x1000>
400002b8: 9119bf39     	add	x25, x25, #0x66f
400002bc: d000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
400002c0: 9109135a     	add	x26, x26, #0x244
400002c4: d000007b     	adrp	x27, 0x4000e000 <__bss_start+0x3000>
400002c8: 14000004     	b	0x400002d8 <launch_kedit+0x13c>
400002cc: 51004d08     	sub	w8, w8, #0x13
400002d0: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
400002d4: b9024d28     	str	w8, [x9, #0x24c]
400002d8: aa1403e0     	mov	x0, x20
400002dc: 94000cf8     	bl	0x400036bc <uart_puts>
400002e0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400002e4: 9107cc00     	add	x0, x0, #0x1f3
400002e8: 94000cf5     	bl	0x400036bc <uart_puts>
400002ec: aa1603e0     	mov	x0, x22
400002f0: 94000cf3     	bl	0x400036bc <uart_puts>
400002f4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400002f8: 9133f000     	add	x0, x0, #0xcfc
400002fc: aa1303e1     	mov	x1, x19
40000300: 94000dff     	bl	0x40003afc <uart_printf>
40000304: b9725268     	ldr	w8, [x19, #0x3250]
40000308: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
4000030c: 910cd129     	add	x9, x9, #0x334
40000310: 7100011f     	cmp	w8, #0x0
40000314: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
40000318: 9121c508     	add	x8, x8, #0x871
4000031c: 9a880120     	csel	x0, x9, x8, eq
40000320: 94000ce7     	bl	0x400036bc <uart_puts>
40000324: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000328: 913f8c00     	add	x0, x0, #0xfe3
4000032c: 94000ce4     	bl	0x400036bc <uart_puts>
40000330: aa1f03f5     	mov	x21, xzr
40000334: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000338: b9724269     	ldr	w9, [x19, #0x3240]
4000033c: 8b0802a8     	add	x8, x21, x8
40000340: 8b081e6a     	add	x10, x19, x8, lsl #7
40000344: 6b09011f     	cmp	w8, w9
40000348: 9101014a     	add	x10, x10, #0x40
4000034c: 9a98b140     	csel	x0, x10, x24, lt
40000350: 94000cdb     	bl	0x400036bc <uart_puts>
40000354: aa1903e0     	mov	x0, x25
40000358: 94000cd9     	bl	0x400036bc <uart_puts>
4000035c: 910006b5     	add	x21, x21, #0x1
40000360: 710052bf     	cmp	w21, #0x14
40000364: 54fffe81     	b.ne	0x40000334 <launch_kedit+0x198>
40000368: aa1603e0     	mov	x0, x22
4000036c: 94000cd4     	bl	0x400036bc <uart_puts>
40000370: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000374: 910e2400     	add	x0, x0, #0x389
40000378: 94000cd1     	bl	0x400036bc <uart_puts>
4000037c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000380: 9129f800     	add	x0, x0, #0xa7e
40000384: 94000cce     	bl	0x400036bc <uart_puts>
40000388: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000038c: 9119c400     	add	x0, x0, #0x671
40000390: 94000ccb     	bl	0x400036bc <uart_puts>
40000394: 2940a349     	ldp	w9, w8, [x26, #0x4]
40000398: b940034a     	ldr	w10, [x26]
4000039c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400003a0: 9111fc00     	add	x0, x0, #0x47f
400003a4: 4b080128     	sub	w8, w9, w8
400003a8: 11000542     	add	w2, w10, #0x1
400003ac: 11000901     	add	w1, w8, #0x2
400003b0: 94000dd3     	bl	0x40003afc <uart_printf>
400003b4: 94000cf5     	bl	0x40003788 <uart_getc>
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
40000428: 940008ff     	bl	0x40002824 <kstrcpy>
4000042c: b9824b68     	ldrsw	x8, [x27, #0x248]
40000430: aa1503e0     	mov	x0, x21
40000434: eb0802df     	cmp	x22, x8
40000438: 54ffff2c     	b.gt	0x4000041c <launch_kedit+0x280>
4000043c: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
40000440: 910102b5     	add	x21, x21, #0x40
40000444: 910023e0     	add	x0, sp, #0x8
40000448: b9b206a9     	ldrsw	x9, [x21, #0x3204]
4000044c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000450: 8b090101     	add	x1, x8, x9
40000454: 940008f4     	bl	0x40002824 <kstrcpy>
40000458: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
4000045c: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000460: 910023e1     	add	x1, sp, #0x8
40000464: 8b081ea8     	add	x8, x21, x8, lsl #7
40000468: 3829691f     	strb	wzr, [x8, x9]
4000046c: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000470: 91000508     	add	x8, x8, #0x1
40000474: 8b081ea0     	add	x0, x21, x8, lsl #7
40000478: b9320aa8     	str	w8, [x21, #0x3208]
4000047c: 940008ea     	bl	0x40002824 <kstrcpy>
40000480: b97202a8     	ldr	w8, [x21, #0x3200]
40000484: b93206bf     	str	wzr, [x21, #0x3204]
40000488: b93212bc     	str	w28, [x21, #0x3210]
4000048c: 11000508     	add	w8, w8, #0x1
40000490: b93202a8     	str	w8, [x21, #0x3200]
40000494: 14000081     	b	0x40000698 <launch_kedit+0x4fc>
40000498: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
4000049c: b9424508     	ldr	w8, [x8, #0x244]
400004a0: 7100051f     	cmp	w8, #0x1
400004a4: 54000fab     	b.lt	0x40000698 <launch_kedit+0x4fc>
400004a8: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400004ac: 8b081e68     	add	x8, x19, x8, lsl #7
400004b0: 91010100     	add	x0, x8, #0x40
400004b4: 940008ad     	bl	0x40002768 <kstrlen>
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
400004f0: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
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
40000528: f0000055     	adrp	x21, 0x4000b000 <__bss_start>
4000052c: 910102b5     	add	x21, x21, #0x40
40000530: 14000006     	b	0x40000548 <launch_kedit+0x3ac>
40000534: b98242e8     	ldrsw	x8, [x23, #0x240]
40000538: 9100079c     	add	x28, x28, #0x1
4000053c: 910202b5     	add	x21, x21, #0x80
40000540: eb08039f     	cmp	x28, x8
40000544: 540001ca     	b.ge	0x4000057c <launch_kedit+0x3e0>
40000548: aa1503e0     	mov	x0, x21
4000054c: 94000887     	bl	0x40002768 <kstrlen>
40000550: 0b0002d4     	add	w20, w22, w0
40000554: 710ffa9f     	cmp	w20, #0x3fe
40000558: 54fffeec     	b.gt	0x40000534 <launch_kedit+0x398>
4000055c: 910023e0     	add	x0, sp, #0x8
40000560: aa1503e1     	mov	x1, x21
40000564: 94000888     	bl	0x40002784 <kstrcat>
40000568: 910023e0     	add	x0, sp, #0x8
4000056c: aa1903e1     	mov	x1, x25
40000570: 94000885     	bl	0x40002784 <kstrcat>
40000574: 11000696     	add	w22, w20, #0x1
40000578: 17ffffef     	b	0x40000534 <launch_kedit+0x398>
4000057c: 910023e1     	add	x1, sp, #0x8
40000580: aa1303e0     	mov	x0, x19
40000584: 940012b5     	bl	0x40005058 <vfs_write_file>
40000588: b932527f     	str	wzr, [x19, #0x3250]
4000058c: 5280003c     	mov	w28, #0x1               // =1
40000590: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
40000594: 91326694     	add	x20, x20, #0xc99
40000598: 14000040     	b	0x40000698 <launch_kedit+0x4fc>
4000059c: 94000c7b     	bl	0x40003788 <uart_getc>
400005a0: 12001c14     	and	w20, w0, #0xff
400005a4: 94000c79     	bl	0x40003788 <uart_getc>
400005a8: 71016e9f     	cmp	w20, #0x5b
400005ac: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
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
400005e8: 94000860     	bl	0x40002768 <kstrlen>
400005ec: b9724668     	ldr	w8, [x19, #0x3244]
400005f0: 6b00011f     	cmp	w8, w0
400005f4: 5400052d     	b.le	0x40000698 <launch_kedit+0x4fc>
400005f8: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
400005fc: b9024500     	str	w0, [x8, #0x244]
40000600: 14000026     	b	0x40000698 <launch_kedit+0x4fc>
40000604: 7100611f     	cmp	w8, #0x18
40000608: 54000ac0     	b.eq	0x40000760 <launch_kedit+0x5c4>
4000060c: 510082a8     	sub	w8, w21, #0x20
40000610: 12001d08     	and	w8, w8, #0xff
40000614: 7101791f     	cmp	w8, #0x5e
40000618: 54000408     	b.hi	0x40000698 <launch_kedit+0x4fc>
4000061c: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000620: b9424508     	ldr	w8, [x8, #0x244]
40000624: 7101f91f     	cmp	w8, #0x7e
40000628: 5400038c     	b.gt	0x40000698 <launch_kedit+0x4fc>
4000062c: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000630: 8b081e68     	add	x8, x19, x8, lsl #7
40000634: 91010100     	add	x0, x8, #0x40
40000638: 9400084c     	bl	0x40002768 <kstrlen>
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
40000698: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
4000069c: 91092129     	add	x9, x9, #0x248
400006a0: f0000036     	adrp	x22, 0x40007000 <__rodata_start>
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
400006fc: 9400081b     	bl	0x40002768 <kstrlen>
40000700: eb14001f     	cmp	x0, x20
40000704: f0000034     	adrp	x20, 0x40007000 <__rodata_start>
40000708: 91326694     	add	x20, x20, #0xc99
4000070c: 54fffc69     	b.ls	0x40000698 <launch_kedit+0x4fc>
40000710: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40000714: b9424528     	ldr	w8, [x9, #0x244]
40000718: 11000508     	add	w8, w8, #0x1
4000071c: b9024528     	str	w8, [x9, #0x244]
40000720: 17ffffde     	b	0x40000698 <launch_kedit+0x4fc>
40000724: 12001c09     	and	w9, w0, #0xff
40000728: 7101113f     	cmp	w9, #0x44
4000072c: 54000101     	b.ne	0x4000074c <launch_kedit+0x5b0>
40000730: d0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40000734: b9424529     	ldr	w9, [x9, #0x244]
40000738: 71000529     	subs	w9, w9, #0x1
4000073c: 5400008b     	b.lt	0x4000074c <launch_kedit+0x5b0>
40000740: d0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40000744: b9024509     	str	w9, [x8, #0x244]
40000748: 17ffffd4     	b	0x40000698 <launch_kedit+0x4fc>
4000074c: 51010409     	sub	w9, w0, #0x41
40000750: 12001d29     	and	w9, w9, #0xff
40000754: 7100093f     	cmp	w9, #0x2
40000758: 54fff423     	b.lo	0x400005dc <launch_kedit+0x440>
4000075c: 17ffffcf     	b	0x40000698 <launch_kedit+0x4fc>
40000760: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000764: 9120f400     	add	x0, x0, #0x83d
40000768: 94000bd5     	bl	0x400036bc <uart_puts>
4000076c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000770: 91217c00     	add	x0, x0, #0x85f
40000774: 94000bd2     	bl	0x400036bc <uart_puts>
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
400007a0: 7003d280     	adr	x0, 0x400081f3 <__rodata_start+0x11f3>
400007a4: 910003fd     	mov	x29, sp
400007a8: 94000bc5     	bl	0x400036bc <uart_puts>
400007ac: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400007b0: 9119bc00     	add	x0, x0, #0x66f
400007b4: 94000bc2     	bl	0x400036bc <uart_puts>
400007b8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400007bc: 910ed800     	add	x0, x0, #0x3b6
400007c0: 94000bbf     	bl	0x400036bc <uart_puts>
400007c4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400007c8: 9121f800     	add	x0, x0, #0x87e
400007cc: 94000bbc     	bl	0x400036bc <uart_puts>
400007d0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400007d4: 91345c00     	add	x0, x0, #0xd17
400007d8: 94000bb9     	bl	0x400036bc <uart_puts>
400007dc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400007e0: 91009c00     	add	x0, x0, #0x27
400007e4: 94000bb6     	bl	0x400036bc <uart_puts>
400007e8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400007ec: 91354800     	add	x0, x0, #0xd52
400007f0: 94000bb3     	bl	0x400036bc <uart_puts>
400007f4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400007f8: 91085800     	add	x0, x0, #0x216
400007fc: 94000bb0     	bl	0x400036bc <uart_puts>
40000800: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000804: 913fa400     	add	x0, x0, #0xfe9
40000808: 94000cbd     	bl	0x40003afc <uart_printf>
4000080c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000810: 9119e000     	add	x0, x0, #0x678
40000814: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000818: 91182421     	add	x1, x1, #0x609
4000081c: 94000cb8     	bl	0x40003afc <uart_printf>
40000820: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000824: 913c7c00     	add	x0, x0, #0xf1f
40000828: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000082c: 91363821     	add	x1, x1, #0xd8e
40000830: 94000cb3     	bl	0x40003afc <uart_printf>
40000834: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000838: 912a0c00     	add	x0, x0, #0xa83
4000083c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000840: 14000b9f     	b	0x400036bc <uart_puts>

0000000040000844 <print_about>:
40000844: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000848: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000084c: 910acc00     	add	x0, x0, #0x2b3
40000850: 910003fd     	mov	x29, sp
40000854: 94000b9a     	bl	0x400036bc <uart_puts>
40000858: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000085c: 91159000     	add	x0, x0, #0x564
40000860: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000864: 91367c21     	add	x1, x1, #0xd9f
40000868: 94000ca5     	bl	0x40003afc <uart_printf>
4000086c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000870: 91279400     	add	x0, x0, #0x9e5
40000874: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000878: 91182421     	add	x1, x1, #0x609
4000087c: 94000ca0     	bl	0x40003afc <uart_printf>
40000880: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000884: 910d0400     	add	x0, x0, #0x341
40000888: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000088c: 91363821     	add	x1, x1, #0xd8e
40000890: 94000c9b     	bl	0x40003afc <uart_printf>
40000894: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000898: 913dbc00     	add	x0, x0, #0xf6f
4000089c: 94000b88     	bl	0x400036bc <uart_puts>
400008a0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400008a4: 91213400     	add	x0, x0, #0x84d
400008a8: 94000b85     	bl	0x400036bc <uart_puts>
400008ac: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008b0: 9119bc00     	add	x0, x0, #0x66f
400008b4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400008b8: 14000b81     	b	0x400036bc <uart_puts>

00000000400008bc <print_sysinfo>:
400008bc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400008c0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008c4: 91046400     	add	x0, x0, #0x119
400008c8: a9014ff4     	stp	x20, x19, [sp, #0x10]
400008cc: 910003fd     	mov	x29, sp
400008d0: d5384248     	mrs	x8, CurrentEL
400008d4: d3420d13     	ubfx	x19, x8, #2, #2
400008d8: d5380014     	mrs	x20, MIDR_EL1
400008dc: 94000b78     	bl	0x400036bc <uart_puts>
400008e0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400008e4: 91263c00     	add	x0, x0, #0x98f
400008e8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400008ec: 91367c21     	add	x1, x1, #0xd9f
400008f0: f0000022     	adrp	x2, 0x40007000 <__rodata_start>
400008f4: 91182442     	add	x2, x2, #0x609
400008f8: 94000c81     	bl	0x40003afc <uart_printf>
400008fc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000900: 9126b800     	add	x0, x0, #0x9ae
40000904: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000908: 91363821     	add	x1, x1, #0xd8e
4000090c: 94000c7c     	bl	0x40003afc <uart_printf>
40000910: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000914: 91301000     	add	x0, x0, #0xc04
40000918: 94000c79     	bl	0x40003afc <uart_printf>
4000091c: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40000920: 910add08     	add	x8, x8, #0x2b7
40000924: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000928: 913e9129     	add	x9, x9, #0xfa4
4000092c: f1000a7f     	cmp	x19, #0x2
40000930: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000934: 91189000     	add	x0, x0, #0x624
40000938: 9a880128     	csel	x8, x9, x8, eq
4000093c: f100067f     	cmp	x19, #0x1
40000940: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40000944: 9122e529     	add	x9, x9, #0x8b9
40000948: 2a1303e1     	mov	w1, w19
4000094c: 9a880122     	csel	x2, x9, x8, eq
40000950: 94000c6b     	bl	0x40003afc <uart_printf>
40000954: 53187e81     	lsr	w1, w20, #24
40000958: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000095c: 9115f400     	add	x0, x0, #0x57d
40000960: aa1403e2     	mov	x2, x20
40000964: 94000c66     	bl	0x40003afc <uart_printf>
40000968: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000096c: 912c9400     	add	x0, x0, #0xb25
40000970: d503201f     	nop
40000974: 10ffb461     	adr	x1, 0x40000000 <_start>
40000978: 94000c61     	bl	0x40003afc <uart_printf>
4000097c: d503201f     	nop
40000980: 10ffb401     	adr	x1, 0x40000000 <_start>
40000984: d503201f     	nop
40000988: 1002c642     	adr	x2, 0x40006250 <__text_end>
4000098c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000990: 91328000     	add	x0, x0, #0xca0
40000994: cb010043     	sub	x3, x2, x1
40000998: 94000c59     	bl	0x40003afc <uart_printf>
4000099c: d503201f     	nop
400009a0: 10033301     	adr	x1, 0x40007000 <__rodata_start>
400009a4: d503201f     	nop
400009a8: 10045f02     	adr	x2, 0x40009588 <__rodata_end>
400009ac: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009b0: 911b4400     	add	x0, x0, #0x6d1
400009b4: cb010043     	sub	x3, x2, x1
400009b8: 94000c51     	bl	0x40003afc <uart_printf>
400009bc: d503201f     	nop
400009c0: 1004b201     	adr	x1, 0x4000a000 <next_pid>
400009c4: d503201f     	nop
400009c8: 101c8e42     	adr	x2, 0x40039b90
400009cc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
400009d0: 912e3c00     	add	x0, x0, #0xb8f
400009d4: cb010043     	sub	x3, x2, x1
400009d8: 94000c49     	bl	0x40003afc <uart_printf>
400009dc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009e0: 91012c00     	add	x0, x0, #0x4b
400009e4: d503201f     	nop
400009e8: 10248d41     	adr	x1, 0x40049b90 <__stack_top>
400009ec: 94000c44     	bl	0x40003afc <uart_printf>
400009f0: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400009f4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400009f8: 9119bc00     	add	x0, x0, #0x66f
400009fc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000a00: 14000b2f     	b	0x400036bc <uart_puts>

0000000040000a04 <print_android_roadmap>:
40000a04: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000a08: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a0c: 913ebc00     	add	x0, x0, #0xfaf
40000a10: 910003fd     	mov	x29, sp
40000a14: 94000b2a     	bl	0x400036bc <uart_puts>
40000a18: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a1c: 912cfc00     	add	x0, x0, #0xb3f
40000a20: 94000b27     	bl	0x400036bc <uart_puts>
40000a24: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a28: 91191400     	add	x0, x0, #0x645
40000a2c: 94000b24     	bl	0x400036bc <uart_puts>
40000a30: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a34: 91272000     	add	x0, x0, #0x9c8
40000a38: 94000b21     	bl	0x400036bc <uart_puts>
40000a3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a40: 911bec00     	add	x0, x0, #0x6fb
40000a44: 94000b1e     	bl	0x400036bc <uart_puts>
40000a48: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000a4c: 9107ec00     	add	x0, x0, #0x1fb
40000a50: 94000b1b     	bl	0x400036bc <uart_puts>
40000a54: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000a58: 91332800     	add	x0, x0, #0xcca
40000a5c: 94000b18     	bl	0x400036bc <uart_puts>
40000a60: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000a64: 910b0c00     	add	x0, x0, #0x2c3
40000a68: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a6c: 14000b14     	b	0x400036bc <uart_puts>

0000000040000a70 <read_line>:
40000a70: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000a74: f9000bf7     	str	x23, [sp, #0x10]
40000a78: aa1f03f7     	mov	x23, xzr
40000a7c: 910003fd     	mov	x29, sp
40000a80: a90257f6     	stp	x22, x21, [sp, #0x20]
40000a84: d1000435     	sub	x21, x1, #0x1
40000a88: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000a8c: aa0003f3     	mov	x19, x0
40000a90: b0000054     	adrp	x20, 0x40009000 <__rodata_start+0x2000>
40000a94: 9110be94     	add	x20, x20, #0x42f
40000a98: aa1703f6     	mov	x22, x23
40000a9c: 94000b3b     	bl	0x40003788 <uart_getc>
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
40000af0: 94000adc     	bl	0x40003660 <uart_putc>
40000af4: 17ffffe9     	b	0x40000a98 <read_line+0x28>
40000af8: aa1f03f7     	mov	x23, xzr
40000afc: b4fffcf6     	cbz	x22, 0x40000a98 <read_line+0x28>
40000b00: aa1403e0     	mov	x0, x20
40000b04: d10006d7     	sub	x23, x22, #0x1
40000b08: 94000aed     	bl	0x400036bc <uart_puts>
40000b0c: 17ffffe3     	b	0x40000a98 <read_line+0x28>
40000b10: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b14: 9101ac00     	add	x0, x0, #0x6b
40000b18: 94000ae9     	bl	0x400036bc <uart_puts>
40000b1c: 38366a7f     	strb	wzr, [x19, x22]
40000b20: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000b24: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000b28: f9400bf7     	ldr	x23, [sp, #0x10]
40000b2c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000b30: d65f03c0     	ret

0000000040000b34 <print_help>:
40000b34: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b38: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b3c: 91231400     	add	x0, x0, #0x8c5
40000b40: 910003fd     	mov	x29, sp
40000b44: 94000ade     	bl	0x400036bc <uart_puts>
40000b48: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b4c: 9115ec00     	add	x0, x0, #0x57b
40000b50: 94000adb     	bl	0x400036bc <uart_puts>
40000b54: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b58: 91223400     	add	x0, x0, #0x88d
40000b5c: 94000ad8     	bl	0x400036bc <uart_puts>
40000b60: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b64: 9101b800     	add	x0, x0, #0x6e
40000b68: 94000ad5     	bl	0x400036bc <uart_puts>
40000b6c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b70: 9104f400     	add	x0, x0, #0x13d
40000b74: 94000ad2     	bl	0x400036bc <uart_puts>
40000b78: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000b7c: 9136a800     	add	x0, x0, #0xdaa
40000b80: 94000acf     	bl	0x400036bc <uart_puts>
40000b84: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000b88: 910c3800     	add	x0, x0, #0x30e
40000b8c: 94000acc     	bl	0x400036bc <uart_puts>
40000b90: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000b94: 911d1800     	add	x0, x0, #0x746
40000b98: 94000ac9     	bl	0x400036bc <uart_puts>
40000b9c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000ba0: 911b1000     	add	x0, x0, #0x6c4
40000ba4: 94000ac6     	bl	0x400036bc <uart_puts>
40000ba8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000bac: 910d5000     	add	x0, x0, #0x354
40000bb0: 94000ac3     	bl	0x400036bc <uart_puts>
40000bb4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000bb8: 911c1400     	add	x0, x0, #0x705
40000bbc: 94000ac0     	bl	0x400036bc <uart_puts>
40000bc0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bc4: 91344400     	add	x0, x0, #0xd11
40000bc8: 94000abd     	bl	0x400036bc <uart_puts>
40000bcc: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000bd0: 9104b800     	add	x0, x0, #0x12e
40000bd4: 94000aba     	bl	0x400036bc <uart_puts>
40000bd8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000bdc: 913f9c00     	add	x0, x0, #0xfe7
40000be0: 94000ab7     	bl	0x400036bc <uart_puts>
40000be4: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000be8: 91232400     	add	x0, x0, #0x8c9
40000bec: 94000ab4     	bl	0x400036bc <uart_puts>
40000bf0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000bf4: 912e0000     	add	x0, x0, #0xb80
40000bf8: 94000ab1     	bl	0x400036bc <uart_puts>
40000bfc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c00: 91059000     	add	x0, x0, #0x164
40000c04: 94000aae     	bl	0x400036bc <uart_puts>
40000c08: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c0c: 91169000     	add	x0, x0, #0x5a4
40000c10: 94000aab     	bl	0x400036bc <uart_puts>
40000c14: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000c18: 9110cc00     	add	x0, x0, #0x433
40000c1c: 94000aa8     	bl	0x400036bc <uart_puts>
40000c20: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c24: 910fc400     	add	x0, x0, #0x3f1
40000c28: 94000aa5     	bl	0x400036bc <uart_puts>
40000c2c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c30: 910b5400     	add	x0, x0, #0x2d5
40000c34: 94000aa2     	bl	0x400036bc <uart_puts>
40000c38: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c3c: 91092400     	add	x0, x0, #0x249
40000c40: 94000a9f     	bl	0x400036bc <uart_puts>
40000c44: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000c48: 91008000     	add	x0, x0, #0x20
40000c4c: 94000a9c     	bl	0x400036bc <uart_puts>
40000c50: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c54: 911d1c00     	add	x0, x0, #0x747
40000c58: 94000a99     	bl	0x400036bc <uart_puts>
40000c5c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000c60: 9110d400     	add	x0, x0, #0x435
40000c64: 94000a96     	bl	0x400036bc <uart_puts>
40000c68: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c6c: 91122000     	add	x0, x0, #0x488
40000c70: 94000a93     	bl	0x400036bc <uart_puts>
40000c74: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000c78: 9111f000     	add	x0, x0, #0x47c
40000c7c: 94000a90     	bl	0x400036bc <uart_puts>
40000c80: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c84: 911de800     	add	x0, x0, #0x77a
40000c88: 94000a8d     	bl	0x400036bc <uart_puts>
40000c8c: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c90: 9134f400     	add	x0, x0, #0xd3d
40000c94: 94000a8a     	bl	0x400036bc <uart_puts>
40000c98: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000c9c: 91058000     	add	x0, x0, #0x160
40000ca0: 94000a87     	bl	0x400036bc <uart_puts>
40000ca4: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40000ca8: 91018800     	add	x0, x0, #0x62
40000cac: 94000a84     	bl	0x400036bc <uart_puts>
40000cb0: f0000020     	adrp	x0, 0x40007000 <__rodata_start>
40000cb4: 912b5000     	add	x0, x0, #0xad4
40000cb8: 94000a81     	bl	0x400036bc <uart_puts>
40000cbc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40000cc0: 9117b800     	add	x0, x0, #0x5ee
40000cc4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000cc8: 14000a7d     	b	0x400036bc <uart_puts>

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
40000d90: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000d94: 91215021     	add	x1, x1, #0x854
40000d98: d10083a0     	sub	x0, x29, #0x20
40000d9c: 382c691f     	strb	wzr, [x8, x12]
40000da0: 94000682     	bl	0x400027a8 <kstrcmp>
40000da4: 34001400     	cbz	w0, 0x40001024 <execute_command+0x358>
40000da8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000dac: 91264821     	add	x1, x1, #0x992
40000db0: d10083a0     	sub	x0, x29, #0x20
40000db4: 9400067d     	bl	0x400027a8 <kstrcmp>
40000db8: 340013a0     	cbz	w0, 0x4000102c <execute_command+0x360>
40000dbc: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000dc0: 91065c21     	add	x1, x1, #0x197
40000dc4: d10083a0     	sub	x0, x29, #0x20
40000dc8: 94000678     	bl	0x400027a8 <kstrcmp>
40000dcc: 34001680     	cbz	w0, 0x4000109c <execute_command+0x3d0>
40000dd0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000dd4: 912f0021     	add	x1, x1, #0xbc0
40000dd8: d10083a0     	sub	x0, x29, #0x20
40000ddc: 94000673     	bl	0x400027a8 <kstrcmp>
40000de0: 34001800     	cbz	w0, 0x400010e0 <execute_command+0x414>
40000de4: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000de8: 910d4c21     	add	x1, x1, #0x353
40000dec: d10083a0     	sub	x0, x29, #0x20
40000df0: 9400066e     	bl	0x400027a8 <kstrcmp>
40000df4: 34001860     	cbz	w0, 0x40001100 <execute_command+0x434>
40000df8: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000dfc: 9123b021     	add	x1, x1, #0x8ec
40000e00: d10083a0     	sub	x0, x29, #0x20
40000e04: 94000669     	bl	0x400027a8 <kstrcmp>
40000e08: 34001900     	cbz	w0, 0x40001128 <execute_command+0x45c>
40000e0c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000e10: 9130d421     	add	x1, x1, #0xc35
40000e14: d10083a0     	sub	x0, x29, #0x20
40000e18: 94000664     	bl	0x400027a8 <kstrcmp>
40000e1c: 34001960     	cbz	w0, 0x40001148 <execute_command+0x47c>
40000e20: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000e24: 91045021     	add	x1, x1, #0x114
40000e28: d10083a0     	sub	x0, x29, #0x20
40000e2c: 9400065f     	bl	0x400027a8 <kstrcmp>
40000e30: 34001880     	cbz	w0, 0x40001140 <execute_command+0x474>
40000e34: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000e38: 91246421     	add	x1, x1, #0x919
40000e3c: d10083a0     	sub	x0, x29, #0x20
40000e40: 9400065a     	bl	0x400027a8 <kstrcmp>
40000e44: 340017e0     	cbz	w0, 0x40001140 <execute_command+0x474>
40000e48: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000e4c: 912c1421     	add	x1, x1, #0xb05
40000e50: d10083a0     	sub	x0, x29, #0x20
40000e54: 94000655     	bl	0x400027a8 <kstrcmp>
40000e58: 34001960     	cbz	w0, 0x40001184 <execute_command+0x4b8>
40000e5c: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000e60: 91165821     	add	x1, x1, #0x596
40000e64: d10083a0     	sub	x0, x29, #0x20
40000e68: 94000650     	bl	0x400027a8 <kstrcmp>
40000e6c: 34001900     	cbz	w0, 0x4000118c <execute_command+0x4c0>
40000e70: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000e74: 910e5c21     	add	x1, x1, #0x397
40000e78: d10083a0     	sub	x0, x29, #0x20
40000e7c: 9400064b     	bl	0x400027a8 <kstrcmp>
40000e80: 34001aa0     	cbz	w0, 0x400011d4 <execute_command+0x508>
40000e84: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000e88: 91131421     	add	x1, x1, #0x4c5
40000e8c: d10083a0     	sub	x0, x29, #0x20
40000e90: 94000646     	bl	0x400027a8 <kstrcmp>
40000e94: 34001b80     	cbz	w0, 0x40001204 <execute_command+0x538>
40000e98: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000e9c: 911d9421     	add	x1, x1, #0x765
40000ea0: d10083a0     	sub	x0, x29, #0x20
40000ea4: 94000641     	bl	0x400027a8 <kstrcmp>
40000ea8: 34001dc0     	cbz	w0, 0x40001260 <execute_command+0x594>
40000eac: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000eb0: 91301021     	add	x1, x1, #0xc04
40000eb4: d10083a0     	sub	x0, x29, #0x20
40000eb8: 9400063c     	bl	0x400027a8 <kstrcmp>
40000ebc: 340020e0     	cbz	w0, 0x400012d8 <execute_command+0x60c>
40000ec0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ec4: 911db021     	add	x1, x1, #0x76c
40000ec8: d10083a0     	sub	x0, x29, #0x20
40000ecc: 94000637     	bl	0x400027a8 <kstrcmp>
40000ed0: 34001e20     	cbz	w0, 0x40001294 <execute_command+0x5c8>
40000ed4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000ed8: 9137b821     	add	x1, x1, #0xdee
40000edc: d10083a0     	sub	x0, x29, #0x20
40000ee0: 94000632     	bl	0x400027a8 <kstrcmp>
40000ee4: 34001d80     	cbz	w0, 0x40001294 <execute_command+0x5c8>
40000ee8: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000eec: 9102c421     	add	x1, x1, #0xb1
40000ef0: d10083a0     	sub	x0, x29, #0x20
40000ef4: 9400062d     	bl	0x400027a8 <kstrcmp>
40000ef8: 340021a0     	cbz	w0, 0x4000132c <execute_command+0x660>
40000efc: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f00: 910d5821     	add	x1, x1, #0x356
40000f04: d10083a0     	sub	x0, x29, #0x20
40000f08: 94000628     	bl	0x400027a8 <kstrcmp>
40000f0c: 34002260     	cbz	w0, 0x40001358 <execute_command+0x68c>
40000f10: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f14: 910d6821     	add	x1, x1, #0x35a
40000f18: d10083a0     	sub	x0, x29, #0x20
40000f1c: 94000623     	bl	0x400027a8 <kstrcmp>
40000f20: 34002340     	cbz	w0, 0x40001388 <execute_command+0x6bc>
40000f24: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f28: 91196c21     	add	x1, x1, #0x65b
40000f2c: d10083a0     	sub	x0, x29, #0x20
40000f30: 9400061e     	bl	0x400027a8 <kstrcmp>
40000f34: 340023e0     	cbz	w0, 0x400013b0 <execute_command+0x6e4>
40000f38: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f3c: 911fc021     	add	x1, x1, #0x7f0
40000f40: d10083a0     	sub	x0, x29, #0x20
40000f44: 94000619     	bl	0x400027a8 <kstrcmp>
40000f48: 34002520     	cbz	w0, 0x400013ec <execute_command+0x720>
40000f4c: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f50: 9108f421     	add	x1, x1, #0x23d
40000f54: d10083a0     	sub	x0, x29, #0x20
40000f58: 94000614     	bl	0x400027a8 <kstrcmp>
40000f5c: 34002720     	cbz	w0, 0x40001440 <execute_command+0x774>
40000f60: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f64: 910d8021     	add	x1, x1, #0x360
40000f68: d10083a0     	sub	x0, x29, #0x20
40000f6c: 9400060f     	bl	0x400027a8 <kstrcmp>
40000f70: 34002600     	cbz	w0, 0x40001430 <execute_command+0x764>
40000f74: f0000021     	adrp	x1, 0x40007000 <__rodata_start>
40000f78: 911fd821     	add	x1, x1, #0x7f6
40000f7c: d10083a0     	sub	x0, x29, #0x20
40000f80: 9400060a     	bl	0x400027a8 <kstrcmp>
40000f84: 34002560     	cbz	w0, 0x40001430 <execute_command+0x764>
40000f88: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000f8c: 91198421     	add	x1, x1, #0x661
40000f90: d10083a0     	sub	x0, x29, #0x20
40000f94: 94000605     	bl	0x400027a8 <kstrcmp>
40000f98: 34002aa0     	cbz	w0, 0x400014ec <execute_command+0x820>
40000f9c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fa0: 91068821     	add	x1, x1, #0x1a2
40000fa4: d10083a0     	sub	x0, x29, #0x20
40000fa8: 94000600     	bl	0x400027a8 <kstrcmp>
40000fac: 34002a00     	cbz	w0, 0x400014ec <execute_command+0x820>
40000fb0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fb4: 910aa421     	add	x1, x1, #0x2a9
40000fb8: d10083a0     	sub	x0, x29, #0x20
40000fbc: 940005fb     	bl	0x400027a8 <kstrcmp>
40000fc0: 34002aa0     	cbz	w0, 0x40001514 <execute_command+0x848>
40000fc4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40000fc8: 91288021     	add	x1, x1, #0xa20
40000fcc: d10083a0     	sub	x0, x29, #0x20
40000fd0: 940005f6     	bl	0x400027a8 <kstrcmp>
40000fd4: 34003080     	cbz	w0, 0x400015e4 <execute_command+0x918>
40000fd8: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000fdc: 91127821     	add	x1, x1, #0x49e
40000fe0: d10083a0     	sub	x0, x29, #0x20
40000fe4: 940005f1     	bl	0x400027a8 <kstrcmp>
40000fe8: 34002ee0     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40000fec: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40000ff0: 91049c21     	add	x1, x1, #0x127
40000ff4: d10083a0     	sub	x0, x29, #0x20
40000ff8: 940005ec     	bl	0x400027a8 <kstrcmp>
40000ffc: 34002e40     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40001000: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001004: 91307421     	add	x1, x1, #0xc1d
40001008: d10083a0     	sub	x0, x29, #0x20
4000100c: 940005e7     	bl	0x400027a8 <kstrcmp>
40001010: 34002da0     	cbz	w0, 0x400015c4 <execute_command+0x8f8>
40001014: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001018: 9104b000     	add	x0, x0, #0x12c
4000101c: d10083a1     	sub	x1, x29, #0x20
40001020: 140000b4     	b	0x400012f0 <execute_command+0x624>
40001024: 97fffec4     	bl	0x40000b34 <print_help>
40001028: 1400002f     	b	0x400010e4 <execute_command+0x418>
4000102c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001030: 910acc00     	add	x0, x0, #0x2b3
40001034: 940009a2     	bl	0x400036bc <uart_puts>
40001038: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000103c: 91159000     	add	x0, x0, #0x564
40001040: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001044: 91367c21     	add	x1, x1, #0xd9f
40001048: 94000aad     	bl	0x40003afc <uart_printf>
4000104c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001050: 91279400     	add	x0, x0, #0x9e5
40001054: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001058: 91182421     	add	x1, x1, #0x609
4000105c: 94000aa8     	bl	0x40003afc <uart_printf>
40001060: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001064: 910d0400     	add	x0, x0, #0x341
40001068: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000106c: 91363821     	add	x1, x1, #0xd8e
40001070: 94000aa3     	bl	0x40003afc <uart_printf>
40001074: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001078: 913dbc00     	add	x0, x0, #0xf6f
4000107c: 94000990     	bl	0x400036bc <uart_puts>
40001080: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001084: 91213400     	add	x0, x0, #0x84d
40001088: 9400098d     	bl	0x400036bc <uart_puts>
4000108c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001090: 9119bc00     	add	x0, x0, #0x66f
40001094: 9400098a     	bl	0x400036bc <uart_puts>
40001098: 14000013     	b	0x400010e4 <execute_command+0x418>
4000109c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400010a0: 9137ec00     	add	x0, x0, #0xdfb
400010a4: 94000986     	bl	0x400036bc <uart_puts>
400010a8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400010ac: 910c2000     	add	x0, x0, #0x308
400010b0: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400010b4: 91182421     	add	x1, x1, #0x609
400010b8: 94000a91     	bl	0x40003afc <uart_printf>
400010bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400010c0: 912ee400     	add	x0, x0, #0xbb9
400010c4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400010c8: 91363821     	add	x1, x1, #0xd8e
400010cc: 94000a8c     	bl	0x40003afc <uart_printf>
400010d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400010d4: 91067000     	add	x0, x0, #0x19c
400010d8: 94000979     	bl	0x400036bc <uart_puts>
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
40001104: 94000599     	bl	0x40002768 <kstrlen>
40001108: b4000260     	cbz	x0, 0x40001154 <execute_command+0x488>
4000110c: 910103e0     	add	x0, sp, #0x40
40001110: 94000fd3     	bl	0x4000505c <vfs_remove>
40001114: 34000280     	cbz	w0, 0x40001164 <execute_command+0x498>
40001118: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
4000111c: 9103e800     	add	x0, x0, #0xfa
40001120: 94000967     	bl	0x400036bc <uart_puts>
40001124: 17fffff0     	b	0x400010e4 <execute_command+0x418>
40001128: 910103e0     	add	x0, sp, #0x40
4000112c: 9400058f     	bl	0x40002768 <kstrlen>
40001130: b4000220     	cbz	x0, 0x40001174 <execute_command+0x4a8>
40001134: 910103e0     	add	x0, sp, #0x40
40001138: 97fffc19     	bl	0x4000019c <launch_kedit>
4000113c: 17ffffea     	b	0x400010e4 <execute_command+0x418>
40001140: 9400068a     	bl	0x40002b68 <tui_launch>
40001144: 17ffffe8     	b	0x400010e4 <execute_command+0x418>
40001148: 910103e0     	add	x0, sp, #0x40
4000114c: 940001f1     	bl	0x40001910 <kproj_execute>
40001150: 17ffffe5     	b	0x400010e4 <execute_command+0x418>
40001154: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001158: 911a4000     	add	x0, x0, #0x690
4000115c: 94000958     	bl	0x400036bc <uart_puts>
40001160: 17ffffe1     	b	0x400010e4 <execute_command+0x418>
40001164: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001168: 91285800     	add	x0, x0, #0xa16
4000116c: 94000954     	bl	0x400036bc <uart_puts>
40001170: 17ffffdd     	b	0x400010e4 <execute_command+0x418>
40001174: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001178: 9135a800     	add	x0, x0, #0xd6a
4000117c: 94000950     	bl	0x400036bc <uart_puts>
40001180: 17ffffd9     	b	0x400010e4 <execute_command+0x418>
40001184: 94000324     	bl	0x40001e14 <launch_ktop>
40001188: 17ffffd7     	b	0x400010e4 <execute_command+0x418>
4000118c: 910103e0     	add	x0, sp, #0x40
40001190: 94000576     	bl	0x40002768 <kstrlen>
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
400011d4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400011d8: 9123c821     	add	x1, x1, #0x8f2
400011dc: aa1303e0     	mov	x0, x19
400011e0: 94000629     	bl	0x40002a84 <kstrstr>
400011e4: b4000460     	cbz	x0, 0x40001270 <execute_command+0x5a4>
400011e8: 3900001f     	strb	wzr, [x0]
400011ec: 38401c08     	ldrb	w8, [x0, #0x1]!
400011f0: 7100811f     	cmp	w8, #0x20
400011f4: 54ffffc0     	b.eq	0x400011ec <execute_command+0x520>
400011f8: 91001661     	add	x1, x19, #0x5
400011fc: 94000f97     	bl	0x40005058 <vfs_write_file>
40001200: 17ffffb9     	b	0x400010e4 <execute_command+0x418>
40001204: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001208: 91067c21     	add	x1, x1, #0x19f
4000120c: 910103e0     	add	x0, sp, #0x40
40001210: 94000566     	bl	0x400027a8 <kstrcmp>
40001214: 34000720     	cbz	w0, 0x400012f8 <execute_command+0x62c>
40001218: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000121c: 911b3400     	add	x0, x0, #0x6cd
40001220: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001224: 91367c21     	add	x1, x1, #0xd9f
40001228: 14000032     	b	0x400012f0 <execute_command+0x624>
4000122c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001230: 9111ec00     	add	x0, x0, #0x47b
40001234: 94000922     	bl	0x400036bc <uart_puts>
40001238: 17ffffab     	b	0x400010e4 <execute_command+0x418>
4000123c: 2a1f03f3     	mov	w19, wzr
40001240: 2a1303e0     	mov	w0, w19
40001244: 9400025f     	bl	0x40001bc0 <process_kill>
40001248: 3100041f     	cmn	w0, #0x1
4000124c: 540001a0     	b.eq	0x40001280 <execute_command+0x5b4>
40001250: 35fff4a0     	cbnz	w0, 0x400010e4 <execute_command+0x418>
40001254: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001258: 913a7000     	add	x0, x0, #0xe9c
4000125c: 1400000b     	b	0x40001288 <execute_command+0x5bc>
40001260: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001264: 913ac000     	add	x0, x0, #0xeb0
40001268: 94000915     	bl	0x400036bc <uart_puts>
4000126c: 17ffff9e     	b	0x400010e4 <execute_command+0x418>
40001270: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001274: 911b3400     	add	x0, x0, #0x6cd
40001278: 910103e1     	add	x1, sp, #0x40
4000127c: 1400001d     	b	0x400012f0 <execute_command+0x624>
40001280: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001284: 911a9800     	add	x0, x0, #0x6a6
40001288: 2a1303e1     	mov	w1, w19
4000128c: 94000a1c     	bl	0x40003afc <uart_printf>
40001290: 17ffff95     	b	0x400010e4 <execute_command+0x418>
40001294: 94000d88     	bl	0x400048b4 <vfs_get_cwd>
40001298: aa0003f3     	mov	x19, x0
4000129c: 910103e0     	add	x0, sp, #0x40
400012a0: 94000532     	bl	0x40002768 <kstrlen>
400012a4: b40003e0     	cbz	x0, 0x40001320 <execute_command+0x654>
400012a8: 910103e0     	add	x0, sp, #0x40
400012ac: 94000df0     	bl	0x40004a6c <vfs_find>
400012b0: b40004c0     	cbz	x0, 0x40001348 <execute_command+0x67c>
400012b4: b9402008     	ldr	w8, [x0, #0x20]
400012b8: 35000368     	cbnz	w8, 0x40001324 <execute_command+0x658>
400012bc: b9402801     	ldr	w1, [x0, #0x28]
400012c0: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x1000>
400012c4: 91190d08     	add	x8, x8, #0x643
400012c8: aa0003e2     	mov	x2, x0
400012cc: aa0803e0     	mov	x0, x8
400012d0: 94000a0b     	bl	0x40003afc <uart_printf>
400012d4: 17ffff84     	b	0x400010e4 <execute_command+0x418>
400012d8: 910003e0     	mov	x0, sp
400012dc: 52800801     	mov	w1, #0x40               // =64
400012e0: 94000d78     	bl	0x400048c0 <vfs_getcwd>
400012e4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012e8: 911b3400     	add	x0, x0, #0x6cd
400012ec: 910003e1     	mov	x1, sp
400012f0: 94000a03     	bl	0x40003afc <uart_printf>
400012f4: 17ffff7c     	b	0x400010e4 <execute_command+0x418>
400012f8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400012fc: 911f0400     	add	x0, x0, #0x7c1
40001300: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001304: 91367c21     	add	x1, x1, #0xd9f
40001308: d0000022     	adrp	x2, 0x40007000 <__rodata_start>
4000130c: 91182442     	add	x2, x2, #0x609
40001310: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x1000>
40001314: 91363863     	add	x3, x3, #0xd8e
40001318: 940009f9     	bl	0x40003afc <uart_printf>
4000131c: 17ffff72     	b	0x400010e4 <execute_command+0x418>
40001320: aa1303e0     	mov	x0, x19
40001324: 94000f87     	bl	0x40005140 <vfs_list_dir>
40001328: 17ffff6f     	b	0x400010e4 <execute_command+0x418>
4000132c: 910103e0     	add	x0, sp, #0x40
40001330: 94000e34     	bl	0x40004c00 <vfs_chdir>
40001334: 34ffed80     	cbz	w0, 0x400010e4 <execute_command+0x418>
40001338: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000133c: 910a1400     	add	x0, x0, #0x285
40001340: 910103e1     	add	x1, sp, #0x40
40001344: 17ffffeb     	b	0x400012f0 <execute_command+0x624>
40001348: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000134c: 91123800     	add	x0, x0, #0x48e
40001350: 910103e1     	add	x1, sp, #0x40
40001354: 17ffffe7     	b	0x400012f0 <execute_command+0x624>
40001358: 910103e0     	add	x0, sp, #0x40
4000135c: 94000503     	bl	0x40002768 <kstrlen>
40001360: b40003e0     	cbz	x0, 0x400013dc <execute_command+0x710>
40001364: 910103e0     	add	x0, sp, #0x40
40001368: 94000dc1     	bl	0x40004a6c <vfs_find>
4000136c: b4000060     	cbz	x0, 0x40001378 <execute_command+0x6ac>
40001370: b9402008     	ldr	w8, [x0, #0x20]
40001374: 34000a28     	cbz	w8, 0x400014b8 <execute_command+0x7ec>
40001378: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000137c: 910d6800     	add	x0, x0, #0x35a
40001380: 940008cf     	bl	0x400036bc <uart_puts>
40001384: 17ffff58     	b	0x400010e4 <execute_command+0x418>
40001388: 910103e0     	add	x0, sp, #0x40
4000138c: 940004f7     	bl	0x40002768 <kstrlen>
40001390: b4000480     	cbz	x0, 0x40001420 <execute_command+0x754>
40001394: 910103e0     	add	x0, sp, #0x40
40001398: 94000e3f     	bl	0x40004c94 <vfs_mkdir>
4000139c: 34ffea40     	cbz	w0, 0x400010e4 <execute_command+0x418>
400013a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400013a4: 913b6400     	add	x0, x0, #0xed9
400013a8: 940008c5     	bl	0x400036bc <uart_puts>
400013ac: 17ffff4e     	b	0x400010e4 <execute_command+0x418>
400013b0: 910103e0     	add	x0, sp, #0x40
400013b4: 940004ed     	bl	0x40002768 <kstrlen>
400013b8: b40008a0     	cbz	x0, 0x400014cc <execute_command+0x800>
400013bc: 910103e0     	add	x0, sp, #0x40
400013c0: aa1f03e1     	mov	x1, xzr
400013c4: 94000e8a     	bl	0x40004dec <vfs_touch>
400013c8: 34ffe8e0     	cbz	w0, 0x400010e4 <execute_command+0x418>
400013cc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400013d0: 91046000     	add	x0, x0, #0x118
400013d4: 940008ba     	bl	0x400036bc <uart_puts>
400013d8: 17ffff43     	b	0x400010e4 <execute_command+0x418>
400013dc: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
400013e0: 91025400     	add	x0, x0, #0x95
400013e4: 940008b6     	bl	0x400036bc <uart_puts>
400013e8: 17ffff3f     	b	0x400010e4 <execute_command+0x418>
400013ec: 910103e0     	add	x0, sp, #0x40
400013f0: 52800401     	mov	w1, #0x20               // =32
400013f4: 940005bf     	bl	0x40002af0 <kstrchr>
400013f8: b4000720     	cbz	x0, 0x400014dc <execute_command+0x810>
400013fc: aa0003e1     	mov	x1, x0
40001400: 910103e0     	add	x0, sp, #0x40
40001404: 3800143f     	strb	wzr, [x1], #0x1
40001408: 94000f14     	bl	0x40005058 <vfs_write_file>
4000140c: 34ffe6c0     	cbz	w0, 0x400010e4 <execute_command+0x418>
40001410: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001414: 91132c00     	add	x0, x0, #0x4cb
40001418: 940008a9     	bl	0x400036bc <uart_puts>
4000141c: 17ffff32     	b	0x400010e4 <execute_command+0x418>
40001420: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001424: 91132800     	add	x0, x0, #0x4ca
40001428: 940008a5     	bl	0x400036bc <uart_puts>
4000142c: 17ffff2e     	b	0x400010e4 <execute_command+0x418>
40001430: d503201f     	nop
40001434: 70036de0     	adr	x0, 0x400081f3 <__rodata_start+0x11f3>
40001438: 940008a1     	bl	0x400036bc <uart_puts>
4000143c: 17ffff2a     	b	0x400010e4 <execute_command+0x418>
40001440: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001444: 9119bc00     	add	x0, x0, #0x66f
40001448: 9400089d     	bl	0x400036bc <uart_puts>
4000144c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001450: 9130ec00     	add	x0, x0, #0xc3b
40001454: 9400089a     	bl	0x400036bc <uart_puts>
40001458: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000145c: 91018800     	add	x0, x0, #0x62
40001460: 94000897     	bl	0x400036bc <uart_puts>
40001464: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001468: 912f2000     	add	x0, x0, #0xbc8
4000146c: 94000894     	bl	0x400036bc <uart_puts>
40001470: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001474: 91136800     	add	x0, x0, #0x4da
40001478: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
4000147c: 91363821     	add	x1, x1, #0xd8e
40001480: 9400099f     	bl	0x40003afc <uart_printf>
40001484: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001488: 911dbc00     	add	x0, x0, #0x76f
4000148c: 9400088c     	bl	0x400036bc <uart_puts>
40001490: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001494: 910e7000     	add	x0, x0, #0x39c
40001498: 94000889     	bl	0x400036bc <uart_puts>
4000149c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014a0: 91137c00     	add	x0, x0, #0x4df
400014a4: 94000886     	bl	0x400036bc <uart_puts>
400014a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400014ac: 91248400     	add	x0, x0, #0x921
400014b0: 94000883     	bl	0x400036bc <uart_puts>
400014b4: 17ffff0c     	b	0x400010e4 <execute_command+0x418>
400014b8: d0000028     	adrp	x8, 0x40007000 <__rodata_start>
400014bc: 911b3508     	add	x8, x8, #0x6cd
400014c0: 9100c001     	add	x1, x0, #0x30
400014c4: aa0803e0     	mov	x0, x8
400014c8: 17ffff8a     	b	0x400012f0 <execute_command+0x624>
400014cc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400014d0: 91302000     	add	x0, x0, #0xc08
400014d4: 9400087a     	bl	0x400036bc <uart_puts>
400014d8: 17ffff03     	b	0x400010e4 <execute_command+0x418>
400014dc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400014e0: 91360c00     	add	x0, x0, #0xd83
400014e4: 94000876     	bl	0x400036bc <uart_puts>
400014e8: 17fffeff     	b	0x400010e4 <execute_command+0x418>
400014ec: 910103e0     	add	x0, sp, #0x40
400014f0: 9400049e     	bl	0x40002768 <kstrlen>
400014f4: b4000080     	cbz	x0, 0x40001504 <execute_command+0x838>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 94000463     	bl	0x40002688 <script_run_file>
40001500: 17fffef9     	b	0x400010e4 <execute_command+0x418>
40001504: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001508: 9102b000     	add	x0, x0, #0xac
4000150c: 9400086c     	bl	0x400036bc <uart_puts>
40001510: 17fffef5     	b	0x400010e4 <execute_command+0x418>
40001514: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001518: 9139d000     	add	x0, x0, #0xe74
4000151c: 94000868     	bl	0x400036bc <uart_puts>
40001520: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001524: d0000035     	adrp	x21, 0x40007000 <__rodata_start>
40001528: 9113e6b5     	add	x21, x21, #0x4f9
4000152c: 39400113     	ldrb	w19, [x8]
40001530: d344fe68     	lsr	x8, x19, #4
40001534: 38686aa0     	ldrb	w0, [x21, x8]
40001538: 9400084a     	bl	0x40003660 <uart_putc>
4000153c: 92400e68     	and	x8, x19, #0xf
40001540: 38686aa0     	ldrb	w0, [x21, x8]
40001544: 94000847     	bl	0x40003660 <uart_putc>
40001548: 52800400     	mov	w0, #0x20               // =32
4000154c: 94000845     	bl	0x40003660 <uart_putc>
40001550: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
40001554: 910dbe73     	add	x19, x19, #0x36f
40001558: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
4000155c: 9119be94     	add	x20, x20, #0x66f
40001560: 52800036     	mov	w22, #0x1               // =1
40001564: d503201f     	nop
40001568: 10ff54d7     	adr	x23, 0x40000000 <_start>
4000156c: 1400000d     	b	0x400015a0 <execute_command+0x8d4>
40001570: 38766af8     	ldrb	w24, [x23, x22]
40001574: d344ff08     	lsr	x8, x24, #4
40001578: 38686aa0     	ldrb	w0, [x21, x8]
4000157c: 94000839     	bl	0x40003660 <uart_putc>
40001580: 92400f08     	and	x8, x24, #0xf
40001584: 38686aa0     	ldrb	w0, [x21, x8]
40001588: 94000836     	bl	0x40003660 <uart_putc>
4000158c: 52800400     	mov	w0, #0x20               // =32
40001590: 94000834     	bl	0x40003660 <uart_putc>
40001594: 910006d6     	add	x22, x22, #0x1
40001598: f10082df     	cmp	x22, #0x20
4000159c: 54ffd780     	b.eq	0x4000108c <execute_command+0x3c0>
400015a0: 72000adf     	tst	w22, #0x7
400015a4: 54000061     	b.ne	0x400015b0 <execute_command+0x8e4>
400015a8: aa1303e0     	mov	x0, x19
400015ac: 94000844     	bl	0x400036bc <uart_puts>
400015b0: 72000edf     	tst	w22, #0xf
400015b4: 54fffde1     	b.ne	0x40001570 <execute_command+0x8a4>
400015b8: aa1403e0     	mov	x0, x20
400015bc: 94000840     	bl	0x400036bc <uart_puts>
400015c0: 17ffffec     	b	0x40001570 <execute_command+0x8a4>
400015c4: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400015c8: 91369800     	add	x0, x0, #0xda6
400015cc: 9400083c     	bl	0x400036bc <uart_puts>
400015d0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015d4: 913ba000     	add	x0, x0, #0xee8
400015d8: 94000839     	bl	0x400036bc <uart_puts>
400015dc: d503207f     	wfi
400015e0: 17ffffff     	b	0x400015dc <execute_command+0x910>
400015e4: 97fffd08     	bl	0x40000a04 <print_android_roadmap>
400015e8: 17fffebf     	b	0x400010e4 <execute_command+0x418>

00000000400015ec <kernel_shell>:
400015ec: d10543ff     	sub	sp, sp, #0x150
400015f0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400015f4: 91250800     	add	x0, x0, #0x942
400015f8: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
400015fc: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001600: 9103c3fd     	add	x29, sp, #0xf0
40001604: a91167fa     	stp	x26, x25, [sp, #0x110]
40001608: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000160c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001610: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001614: 9400082a     	bl	0x400036bc <uart_puts>
40001618: d0000033     	adrp	x19, 0x40007000 <__rodata_start>
4000161c: 913a6273     	add	x19, x19, #0xe98
40001620: f0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40001624: 9102d294     	add	x20, x20, #0xb4
40001628: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
4000162c: 9110beb5     	add	x21, x21, #0x42f
40001630: f0000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40001634: 9101aed6     	add	x22, x22, #0x6b
40001638: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x2000>
4000163c: 91127af7     	add	x23, x23, #0x49e
40001640: 90000058     	adrp	x24, 0x40009000 <__rodata_start+0x2000>
40001644: 91049f18     	add	x24, x24, #0x127
40001648: 910123fa     	add	x26, sp, #0x48
4000164c: d0000039     	adrp	x25, 0x40007000 <__rodata_start>
40001650: 91307739     	add	x25, x25, #0xc1d
40001654: 910023e0     	add	x0, sp, #0x8
40001658: 52800801     	mov	w1, #0x40               // =64
4000165c: 94000c99     	bl	0x400048c0 <vfs_getcwd>
40001660: 910023e1     	add	x1, sp, #0x8
40001664: aa1303e0     	mov	x0, x19
40001668: 94000925     	bl	0x40003afc <uart_printf>
4000166c: aa1403e0     	mov	x0, x20
40001670: 94000813     	bl	0x400036bc <uart_puts>
40001674: aa1f03fc     	mov	x28, xzr
40001678: aa1c03fb     	mov	x27, x28
4000167c: 94000843     	bl	0x40003788 <uart_getc>
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
400016d0: 940007e4     	bl	0x40003660 <uart_putc>
400016d4: 17ffffe9     	b	0x40001678 <kernel_shell+0x8c>
400016d8: aa1f03fc     	mov	x28, xzr
400016dc: b4fffcfb     	cbz	x27, 0x40001678 <kernel_shell+0x8c>
400016e0: aa1503e0     	mov	x0, x21
400016e4: d100077c     	sub	x28, x27, #0x1
400016e8: 940007f5     	bl	0x400036bc <uart_puts>
400016ec: 17ffffe3     	b	0x40001678 <kernel_shell+0x8c>
400016f0: aa1603e0     	mov	x0, x22
400016f4: 940007f2     	bl	0x400036bc <uart_puts>
400016f8: 910123e0     	add	x0, sp, #0x48
400016fc: 383b6b5f     	strb	wzr, [x26, x27]
40001700: 9400041a     	bl	0x40002768 <kstrlen>
40001704: b4fffa80     	cbz	x0, 0x40001654 <kernel_shell+0x68>
40001708: 910123e0     	add	x0, sp, #0x48
4000170c: 940002e4     	bl	0x4000229c <script_execute_line>
40001710: 910123e0     	add	x0, sp, #0x48
40001714: aa1703e1     	mov	x1, x23
40001718: 94000424     	bl	0x400027a8 <kstrcmp>
4000171c: 34000120     	cbz	w0, 0x40001740 <kernel_shell+0x154>
40001720: 910123e0     	add	x0, sp, #0x48
40001724: aa1803e1     	mov	x1, x24
40001728: 94000420     	bl	0x400027a8 <kstrcmp>
4000172c: 340000a0     	cbz	w0, 0x40001740 <kernel_shell+0x154>
40001730: 910123e0     	add	x0, sp, #0x48
40001734: aa1903e1     	mov	x1, x25
40001738: 9400041c     	bl	0x400027a8 <kstrcmp>
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
40001778: 940007ae     	bl	0x40003630 <uart_init>
4000177c: d503201f     	nop
40001780: 70035380     	adr	x0, 0x400081f3 <__rodata_start+0x11f3>
40001784: 940007ce     	bl	0x400036bc <uart_puts>
40001788: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
4000178c: 91166c00     	add	x0, x0, #0x59b
40001790: 940007cb     	bl	0x400036bc <uart_puts>
40001794: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001798: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000179c: 6b13011f     	cmp	w8, w19
400017a0: 540000aa     	b.ge	0x400017b4 <kmain+0x54>
400017a4: b85fc3a8     	ldur	w8, [x29, #-0x4]
400017a8: 11000508     	add	w8, w8, #0x1
400017ac: b81fc3a8     	stur	w8, [x29, #-0x4]
400017b0: 17fffffa     	b	0x40001798 <kmain+0x38>
400017b4: 528aa213     	mov	w19, #0x5510            // =21776
400017b8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400017bc: 910dc400     	add	x0, x0, #0x371
400017c0: 72a00453     	movk	w19, #0x22, lsl #16
400017c4: 940007be     	bl	0x400036bc <uart_puts>
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
400017f0: 94000ace     	bl	0x40004328 <vfs_init>
400017f4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400017f8: 911e7400     	add	x0, x0, #0x79d
400017fc: 940007b0     	bl	0x400036bc <uart_puts>
40001800: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001804: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001808: 6b14011f     	cmp	w8, w20
4000180c: 540000aa     	b.ge	0x40001820 <kmain+0xc0>
40001810: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001814: 11000508     	add	w8, w8, #0x1
40001818: b81fc3a8     	stur	w8, [x29, #-0x4]
4000181c: 17fffffa     	b	0x40001804 <kmain+0xa4>
40001820: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001824: 91090c00     	add	x0, x0, #0x243
40001828: d503201f     	nop
4000182c: 1001fea8     	adr	x8, 0x40005800 <exception_vector_table>
40001830: d518c008     	msr	VBAR_EL1, x8
40001834: 940007a2     	bl	0x400036bc <uart_puts>
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
40001860: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001864: 91023000     	add	x0, x0, #0x8c
40001868: 94000795     	bl	0x400036bc <uart_puts>
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
400018bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018c0: 91266000     	add	x0, x0, #0x998
400018c4: 9400077e     	bl	0x400036bc <uart_puts>
400018c8: 94001260     	bl	0x40006248 <trigger_undefined_instruction>
400018cc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018d0: 9127f800     	add	x0, x0, #0x9fe
400018d4: 9400077a     	bl	0x400036bc <uart_puts>
400018d8: 97fffbb0     	bl	0x40000798 <print_banner>
400018dc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400018e0: 9123d000     	add	x0, x0, #0x8f4
400018e4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400018e8: 91367c21     	add	x1, x1, #0xd9f
400018ec: 94000884     	bl	0x40003afc <uart_printf>
400018f0: 97fffbf3     	bl	0x400008bc <print_sysinfo>
400018f4: 97ffff3e     	bl	0x400015ec <kernel_shell>
400018f8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
400018fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001900: 913ba000     	add	x0, x0, #0xee8
40001904: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001908: 9100c3ff     	add	sp, sp, #0x30
4000190c: 1400076c     	b	0x400036bc <uart_puts>

0000000040001910 <kproj_execute>:
40001910: d10683ff     	sub	sp, sp, #0x1a0
40001914: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001918: 910603fd     	add	x29, sp, #0x180
4000191c: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001920: b40001c0     	cbz	x0, 0x40001958 <kproj_execute+0x48>
40001924: aa0003f3     	mov	x19, x0
40001928: 94000390     	bl	0x40002768 <kstrlen>
4000192c: b4000160     	cbz	x0, 0x40001958 <kproj_execute+0x48>
40001930: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001934: 91291c00     	add	x0, x0, #0xa47
40001938: aa1303e1     	mov	x1, x19
4000193c: 94000870     	bl	0x40003afc <uart_printf>
40001940: aa1303e0     	mov	x0, x19
40001944: 94000cd4     	bl	0x40004c94 <vfs_mkdir>
40001948: 34000140     	cbz	w0, 0x40001970 <kproj_execute+0x60>
4000194c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x2000>
40001950: 91128c00     	add	x0, x0, #0x4a3
40001954: 14000003     	b	0x40001960 <kproj_execute+0x50>
40001958: d503201f     	nop
4000195c: 1003bf80     	adr	x0, 0x4000914c <__rodata_start+0x214c>
40001960: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001964: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001968: 910683ff     	add	sp, sp, #0x1a0
4000196c: 14000754     	b	0x400036bc <uart_puts>
40001970: aa1303e0     	mov	x0, x19
40001974: 94000ca3     	bl	0x40004c00 <vfs_chdir>
40001978: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000197c: 91034400     	add	x0, x0, #0xd1
40001980: 94000cc5     	bl	0x40004c94 <vfs_mkdir>
40001984: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001988: 91199000     	add	x0, x0, #0x664
4000198c: 94000cc2     	bl	0x40004c94 <vfs_mkdir>
40001990: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001994: 910a4021     	add	x1, x1, #0x290
40001998: 910203e0     	add	x0, sp, #0x80
4000199c: 940003a2     	bl	0x40002824 <kstrcpy>
400019a0: 910203e0     	add	x0, sp, #0x80
400019a4: aa1303e1     	mov	x1, x19
400019a8: 94000377     	bl	0x40002784 <kstrcat>
400019ac: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400019b0: 913c1021     	add	x1, x1, #0xf04
400019b4: 910203e0     	add	x0, sp, #0x80
400019b8: 94000373     	bl	0x40002784 <kstrcat>
400019bc: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
400019c0: 91247400     	add	x0, x0, #0x91d
400019c4: 910203e1     	add	x1, sp, #0x80
400019c8: 94000d09     	bl	0x40004dec <vfs_touch>
400019cc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400019d0: 913c3800     	add	x0, x0, #0xf0e
400019d4: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
400019d8: 91308821     	add	x1, x1, #0xc22
400019dc: 94000d04     	bl	0x40004dec <vfs_touch>
400019e0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
400019e4: 91069821     	add	x1, x1, #0x1a6
400019e8: 910003e0     	mov	x0, sp
400019ec: 9400038e     	bl	0x40002824 <kstrcpy>
400019f0: 910003e0     	mov	x0, sp
400019f4: aa1303e1     	mov	x1, x19
400019f8: 94000363     	bl	0x40002784 <kstrcat>
400019fc: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001a00: 912c2821     	add	x1, x1, #0xb0a
40001a04: 910003e0     	mov	x0, sp
40001a08: 9400035f     	bl	0x40002784 <kstrcat>
40001a0c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a10: 913cc000     	add	x0, x0, #0xf30
40001a14: 910003e1     	mov	x1, sp
40001a18: 94000cf5     	bl	0x40004dec <vfs_touch>
40001a1c: 94000cf3     	bl	0x40004de8 <vfs_sync>
40001a20: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a24: 91142800     	add	x0, x0, #0x50a
40001a28: 94000725     	bl	0x400036bc <uart_puts>
40001a2c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001a30: 9114e400     	add	x0, x0, #0x539
40001a34: aa1303e1     	mov	x1, x19
40001a38: 94000831     	bl	0x40003afc <uart_printf>
40001a3c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001a40: 91035400     	add	x0, x0, #0xd5
40001a44: 94000c6f     	bl	0x40004c00 <vfs_chdir>
40001a48: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001a4c: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001a50: 910683ff     	add	sp, sp, #0x1a0
40001a54: d65f03c0     	ret

0000000040001a58 <process_init>:
40001a58: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40001a5c: a9014ff4     	stp	x20, x19, [sp, #0x10]
40001a60: b0000054     	adrp	x20, 0x4000a000 <next_pid>
40001a64: d503201f     	nop
40001a68: 10063f73     	adr	x19, 0x4000e254 <proc_table>
40001a6c: b9400289     	ldr	w9, [x20]
40001a70: 52800068     	mov	w8, #0x3                // =3
40001a74: b9002668     	str	w8, [x19, #0x24]
40001a78: d503201f     	nop
40001a7c: 30036ee1     	adr	x1, 0x40008859 <__rodata_start+0x1859>
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
40001b0c: 94000346     	bl	0x40002824 <kstrcpy>
40001b10: 90000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40001b14: b9400289     	ldr	w9, [x20]
40001b18: 5280384a     	mov	w10, #0x1c2             // =450
40001b1c: fd428d00     	ldr	d0, [x8, #0x518]
40001b20: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40001b24: 91137021     	add	x1, x1, #0x4dc
40001b28: 11000528     	add	w8, w9, #0x1
40001b2c: 9100d260     	add	x0, x19, #0x34
40001b30: 2905a66a     	stp	w10, w9, [x19, #0x2c]
40001b34: fc024260     	stur	d0, [x19, #0x24]
40001b38: b9000288     	str	w8, [x20]
40001b3c: 9400033a     	bl	0x40002824 <kstrcpy>
40001b40: 90000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40001b44: b9400289     	ldr	w9, [x20]
40001b48: 5280018a     	mov	w10, #0xc               // =12
40001b4c: fd42a100     	ldr	d0, [x8, #0x540]
40001b50: d0000021     	adrp	x1, 0x40007000 <__rodata_start>
40001b54: 912cb021     	add	x1, x1, #0xb2c
40001b58: 11000528     	add	w8, w9, #0x1
40001b5c: 91019260     	add	x0, x19, #0x64
40001b60: 290ba66a     	stp	w10, w9, [x19, #0x5c]
40001b64: fc054260     	stur	d0, [x19, #0x54]
40001b68: b9000288     	str	w8, [x20]
40001b6c: 9400032e     	bl	0x40002824 <kstrcpy>
40001b70: 90000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40001b74: b9400289     	ldr	w9, [x20]
40001b78: 5280960a     	mov	w10, #0x4b0             // =1200
40001b7c: fd427d00     	ldr	d0, [x8, #0x4f8]
40001b80: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001b84: 910d9821     	add	x1, x1, #0x366
40001b88: 11000528     	add	w8, w9, #0x1
40001b8c: 91025260     	add	x0, x19, #0x94
40001b90: 2911a66a     	stp	w10, w9, [x19, #0x8c]
40001b94: fc084260     	stur	d0, [x19, #0x84]
40001b98: b9000288     	str	w8, [x20]
40001b9c: 94000322     	bl	0x40002824 <kstrcpy>
40001ba0: 90000048     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40001ba4: fd42b100     	ldr	d0, [x8, #0x560]
40001ba8: 52800aa8     	mov	w8, #0x55               // =85
40001bac: b900be68     	str	w8, [x19, #0xbc]
40001bb0: fc0b4260     	stur	d0, [x19, #0xb4]
40001bb4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40001bb8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40001bbc: d65f03c0     	ret

0000000040001bc0 <process_kill>:
40001bc0: 7100041f     	cmp	w0, #0x1
40001bc4: 5400118b     	b.lt	0x40001df4 <process_kill+0x234>
40001bc8: d503201f     	nop
40001bcc: 10063449     	adr	x9, 0x4000e254 <proc_table>
40001bd0: b9400128     	ldr	w8, [x9]
40001bd4: 6b00011f     	cmp	w8, w0
40001bd8: 54000081     	b.ne	0x40001be8 <process_kill+0x28>
40001bdc: b9402528     	ldr	w8, [x9, #0x24]
40001be0: 71000d1f     	cmp	w8, #0x3
40001be4: 54000f41     	b.ne	0x40001dcc <process_kill+0x20c>
40001be8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001bec: 910a1129     	add	x9, x9, #0x284
40001bf0: b9400128     	ldr	w8, [x9]
40001bf4: 6b00011f     	cmp	w8, w0
40001bf8: 54000081     	b.ne	0x40001c08 <process_kill+0x48>
40001bfc: b9402528     	ldr	w8, [x9, #0x24]
40001c00: 71000d1f     	cmp	w8, #0x3
40001c04: 54000e41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c08: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001c0c: 910ad129     	add	x9, x9, #0x2b4
40001c10: b9400128     	ldr	w8, [x9]
40001c14: 6b00011f     	cmp	w8, w0
40001c18: 54000081     	b.ne	0x40001c28 <process_kill+0x68>
40001c1c: b9402528     	ldr	w8, [x9, #0x24]
40001c20: 71000d1f     	cmp	w8, #0x3
40001c24: 54000d41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c28: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001c2c: 910b9129     	add	x9, x9, #0x2e4
40001c30: b9400128     	ldr	w8, [x9]
40001c34: 6b00011f     	cmp	w8, w0
40001c38: 54000081     	b.ne	0x40001c48 <process_kill+0x88>
40001c3c: b9402528     	ldr	w8, [x9, #0x24]
40001c40: 71000d1f     	cmp	w8, #0x3
40001c44: 54000c41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c48: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001c4c: 910c5129     	add	x9, x9, #0x314
40001c50: b9400128     	ldr	w8, [x9]
40001c54: 6b00011f     	cmp	w8, w0
40001c58: 54000081     	b.ne	0x40001c68 <process_kill+0xa8>
40001c5c: b9402528     	ldr	w8, [x9, #0x24]
40001c60: 71000d1f     	cmp	w8, #0x3
40001c64: 54000b41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c68: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001c6c: 910d1129     	add	x9, x9, #0x344
40001c70: b9400128     	ldr	w8, [x9]
40001c74: 6b00011f     	cmp	w8, w0
40001c78: 54000081     	b.ne	0x40001c88 <process_kill+0xc8>
40001c7c: b9402528     	ldr	w8, [x9, #0x24]
40001c80: 71000d1f     	cmp	w8, #0x3
40001c84: 54000a41     	b.ne	0x40001dcc <process_kill+0x20c>
40001c88: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001c8c: 910dd129     	add	x9, x9, #0x374
40001c90: b9400128     	ldr	w8, [x9]
40001c94: 6b00011f     	cmp	w8, w0
40001c98: 54000081     	b.ne	0x40001ca8 <process_kill+0xe8>
40001c9c: b9402528     	ldr	w8, [x9, #0x24]
40001ca0: 71000d1f     	cmp	w8, #0x3
40001ca4: 54000941     	b.ne	0x40001dcc <process_kill+0x20c>
40001ca8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001cac: 910e9129     	add	x9, x9, #0x3a4
40001cb0: b9400128     	ldr	w8, [x9]
40001cb4: 6b00011f     	cmp	w8, w0
40001cb8: 54000081     	b.ne	0x40001cc8 <process_kill+0x108>
40001cbc: b9402528     	ldr	w8, [x9, #0x24]
40001cc0: 71000d1f     	cmp	w8, #0x3
40001cc4: 54000841     	b.ne	0x40001dcc <process_kill+0x20c>
40001cc8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001ccc: 910f5129     	add	x9, x9, #0x3d4
40001cd0: b9400128     	ldr	w8, [x9]
40001cd4: 6b00011f     	cmp	w8, w0
40001cd8: 54000081     	b.ne	0x40001ce8 <process_kill+0x128>
40001cdc: b9402528     	ldr	w8, [x9, #0x24]
40001ce0: 71000d1f     	cmp	w8, #0x3
40001ce4: 54000741     	b.ne	0x40001dcc <process_kill+0x20c>
40001ce8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001cec: 91101129     	add	x9, x9, #0x404
40001cf0: b9400128     	ldr	w8, [x9]
40001cf4: 6b00011f     	cmp	w8, w0
40001cf8: 54000081     	b.ne	0x40001d08 <process_kill+0x148>
40001cfc: b9402528     	ldr	w8, [x9, #0x24]
40001d00: 71000d1f     	cmp	w8, #0x3
40001d04: 54000641     	b.ne	0x40001dcc <process_kill+0x20c>
40001d08: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d0c: 9110d129     	add	x9, x9, #0x434
40001d10: b9400128     	ldr	w8, [x9]
40001d14: 6b00011f     	cmp	w8, w0
40001d18: 54000081     	b.ne	0x40001d28 <process_kill+0x168>
40001d1c: b9402528     	ldr	w8, [x9, #0x24]
40001d20: 71000d1f     	cmp	w8, #0x3
40001d24: 54000541     	b.ne	0x40001dcc <process_kill+0x20c>
40001d28: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d2c: 91119129     	add	x9, x9, #0x464
40001d30: b9400128     	ldr	w8, [x9]
40001d34: 6b00011f     	cmp	w8, w0
40001d38: 54000081     	b.ne	0x40001d48 <process_kill+0x188>
40001d3c: b9402528     	ldr	w8, [x9, #0x24]
40001d40: 71000d1f     	cmp	w8, #0x3
40001d44: 54000441     	b.ne	0x40001dcc <process_kill+0x20c>
40001d48: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d4c: 91125129     	add	x9, x9, #0x494
40001d50: b9400128     	ldr	w8, [x9]
40001d54: 6b00011f     	cmp	w8, w0
40001d58: 54000081     	b.ne	0x40001d68 <process_kill+0x1a8>
40001d5c: b9402528     	ldr	w8, [x9, #0x24]
40001d60: 71000d1f     	cmp	w8, #0x3
40001d64: 54000341     	b.ne	0x40001dcc <process_kill+0x20c>
40001d68: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d6c: 91131129     	add	x9, x9, #0x4c4
40001d70: b9400128     	ldr	w8, [x9]
40001d74: 6b00011f     	cmp	w8, w0
40001d78: 54000081     	b.ne	0x40001d88 <process_kill+0x1c8>
40001d7c: b9402528     	ldr	w8, [x9, #0x24]
40001d80: 71000d1f     	cmp	w8, #0x3
40001d84: 54000241     	b.ne	0x40001dcc <process_kill+0x20c>
40001d88: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
40001d8c: 9113d129     	add	x9, x9, #0x4f4
40001d90: b9400128     	ldr	w8, [x9]
40001d94: 6b00011f     	cmp	w8, w0
40001d98: 54000081     	b.ne	0x40001da8 <process_kill+0x1e8>
40001d9c: b9402528     	ldr	w8, [x9, #0x24]
40001da0: 71000d1f     	cmp	w8, #0x3
40001da4: 54000141     	b.ne	0x40001dcc <process_kill+0x20c>
40001da8: b0000069     	adrp	x9, 0x4000e000 <__bss_start+0x3000>
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
40001dd8: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001ddc: 9129e000     	add	x0, x0, #0xa78
40001de0: 910003fd     	mov	x29, sp
40001de4: 94000636     	bl	0x400036bc <uart_puts>
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
40001e18: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001e1c: 911fe800     	add	x0, x0, #0x7fa
40001e20: f9000bf7     	str	x23, [sp, #0x10]
40001e24: a90257f6     	stp	x22, x21, [sp, #0x20]
40001e28: 910003fd     	mov	x29, sp
40001e2c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001e30: 94000623     	bl	0x400036bc <uart_puts>
40001e34: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001e38: 911fa800     	add	x0, x0, #0x7ea
40001e3c: 94000620     	bl	0x400036bc <uart_puts>
40001e40: 2a1f03e8     	mov	w8, wzr
40001e44: 2a1f03e1     	mov	w1, wzr
40001e48: 52800209     	mov	w9, #0x10               // =16
40001e4c: b000006a     	adrp	x10, 0x4000e000 <__bss_start+0x3000>
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
40001e88: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001e8c: 912cd800     	add	x0, x0, #0xb36
40001e90: 9400071b     	bl	0x40003afc <uart_printf>
40001e94: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001e98: 91310800     	add	x0, x0, #0xc42
40001e9c: 94000608     	bl	0x400036bc <uart_puts>
40001ea0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001ea4: 9131e000     	add	x0, x0, #0xc78
40001ea8: 94000605     	bl	0x400036bc <uart_puts>
40001eac: b0000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40001eb0: 910a0294     	add	x20, x20, #0x280
40001eb4: f0000035     	adrp	x21, 0x40008000 <__rodata_start+0x1000>
40001eb8: 9137cab5     	add	x21, x21, #0xdf2
40001ebc: d503201f     	nop
40001ec0: 1003b596     	adr	x22, 0x40009570 <__rodata_start+0x2570>
40001ec4: 52800217     	mov	w23, #0x10              // =16
40001ec8: f0000033     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
40001ecc: 91140673     	add	x19, x19, #0x501
40001ed0: 1400000a     	b	0x40001ef8 <launch_ktop+0xe4>
40001ed4: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40001ed8: b85d4281     	ldur	w1, [x20, #-0x2c]
40001edc: d100a285     	sub	x5, x20, #0x28
40001ee0: aa1303e0     	mov	x0, x19
40001ee4: 530a7d03     	lsr	w3, w8, #10
40001ee8: 94000705     	bl	0x40003afc <uart_printf>
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
40001f18: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001f1c: 9106a400     	add	x0, x0, #0x1a9
40001f20: 940005e7     	bl	0x400036bc <uart_puts>
40001f24: 52808114     	mov	w20, #0x408             // =1032
40001f28: 52800033     	mov	w19, #0x1               // =1
40001f2c: 72a02014     	movk	w20, #0x100, lsl #16
40001f30: 14000003     	b	0x40001f3c <launch_ktop+0x128>
40001f34: 7101c51f     	cmp	w8, #0x71
40001f38: 54000100     	b.eq	0x40001f58 <launch_ktop+0x144>
40001f3c: 94000613     	bl	0x40003788 <uart_getc>
40001f40: 12001c08     	and	w8, w0, #0xff
40001f44: 7100611f     	cmp	w8, #0x18
40001f48: 54ffff68     	b.hi	0x40001f34 <launch_ktop+0x120>
40001f4c: 1ac82269     	lsl	w9, w19, w8
40001f50: 6a14013f     	tst	w9, w20
40001f54: 54ffff00     	b.eq	0x40001f34 <launch_ktop+0x120>
40001f58: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40001f5c: d0000020     	adrp	x0, 0x40007000 <__rodata_start>
40001f60: 912da400     	add	x0, x0, #0xb69
40001f64: a94257f6     	ldp	x22, x21, [sp, #0x20]
40001f68: f9400bf7     	ldr	x23, [sp, #0x10]
40001f6c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40001f70: 140005d3     	b	0x400036bc <uart_puts>

0000000040001f74 <script_init>:
40001f74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001f78: b0000068     	adrp	x8, 0x4000e000 <__bss_start+0x3000>
40001f7c: d503201f     	nop
40001f80: 1002e800     	adr	x0, 0x40007c80 <__rodata_start+0xc80>
40001f84: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001f88: 91261421     	add	x1, x1, #0x985
40001f8c: 910003fd     	mov	x29, sp
40001f90: b905551f     	str	wzr, [x8, #0x554]
40001f94: 94000007     	bl	0x40001fb0 <script_set_var>
40001f98: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40001f9c: 912ffc00     	add	x0, x0, #0xbff
40001fa0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x1000>
40001fa4: 9119a821     	add	x1, x1, #0x66a
40001fa8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001fac: 14000001     	b	0x40001fb0 <script_set_var>

0000000040001fb0 <script_set_var>:
40001fb0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001fb4: a9015ff8     	stp	x24, x23, [sp, #0x10]
40001fb8: b0000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40001fbc: 910003fd     	mov	x29, sp
40001fc0: b94556e8     	ldr	w8, [x23, #0x554]
40001fc4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001fc8: aa0103f3     	mov	x19, x1
40001fcc: aa0003f4     	mov	x20, x0
40001fd0: a90257f6     	stp	x22, x21, [sp, #0x20]
40001fd4: 7100051f     	cmp	w8, #0x1
40001fd8: 5400024b     	b.lt	0x40002020 <script_set_var+0x70>
40001fdc: aa1f03f8     	mov	x24, xzr
40001fe0: b0000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40001fe4: 912562b5     	add	x21, x21, #0x958
40001fe8: b0000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
40001fec: 911562d6     	add	x22, x22, #0x558
40001ff0: aa1603e0     	mov	x0, x22
40001ff4: aa1403e1     	mov	x1, x20
40001ff8: 940001ec     	bl	0x400027a8 <kstrcmp>
40001ffc: 340003e0     	cbz	w0, 0x40002078 <script_set_var+0xc8>
40002000: b98556e8     	ldrsw	x8, [x23, #0x554]
40002004: 91000718     	add	x24, x24, #0x1
40002008: 910202b5     	add	x21, x21, #0x80
4000200c: 910082d6     	add	x22, x22, #0x20
40002010: eb08031f     	cmp	x24, x8
40002014: 54fffeeb     	b.lt	0x40001ff0 <script_set_var+0x40>
40002018: 71007d1f     	cmp	w8, #0x1f
4000201c: 5400038c     	b.gt	0x4000208c <script_set_var+0xdc>
40002020: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
40002024: 911562b5     	add	x21, x21, #0x558
40002028: aa1403e1     	mov	x1, x20
4000202c: 93407d08     	sxtw	x8, w8
40002030: 528003e2     	mov	w2, #0x1f               // =31
40002034: 8b0816a0     	add	x0, x21, x8, lsl #5
40002038: 94000202     	bl	0x40002840 <kstrncpy>
4000203c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002040: 90000074     	adrp	x20, 0x4000e000 <__bss_start+0x3000>
40002044: 91256294     	add	x20, x20, #0x958
40002048: aa1303e1     	mov	x1, x19
4000204c: 52800fe2     	mov	w2, #0x7f               // =127
40002050: 8b0816a9     	add	x9, x21, x8, lsl #5
40002054: 8b081e80     	add	x0, x20, x8, lsl #7
40002058: 39007d3f     	strb	wzr, [x9, #0x1f]
4000205c: 940001f9     	bl	0x40002840 <kstrncpy>
40002060: b98556e8     	ldrsw	x8, [x23, #0x554]
40002064: 8b081e89     	add	x9, x20, x8, lsl #7
40002068: 11000508     	add	w8, w8, #0x1
4000206c: b90556e8     	str	w8, [x23, #0x554]
40002070: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002074: 14000006     	b	0x4000208c <script_set_var+0xdc>
40002078: aa1503e0     	mov	x0, x21
4000207c: aa1303e1     	mov	x1, x19
40002080: 52800fe2     	mov	w2, #0x7f               // =127
40002084: 940001ef     	bl	0x40002840 <kstrncpy>
40002088: 3901febf     	strb	wzr, [x21, #0x7f]
4000208c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002090: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002094: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002098: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000209c: d65f03c0     	ret

00000000400020a0 <script_get_var>:
400020a0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400020a4: a90257f6     	stp	x22, x21, [sp, #0x20]
400020a8: 90000076     	adrp	x22, 0x4000e000 <__bss_start+0x3000>
400020ac: 910003fd     	mov	x29, sp
400020b0: b94556c8     	ldr	w8, [x22, #0x554]
400020b4: a9015ff8     	stp	x24, x23, [sp, #0x10]
400020b8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400020bc: 7100051f     	cmp	w8, #0x1
400020c0: 540002ab     	b.lt	0x40002114 <script_get_var+0x74>
400020c4: aa0003f4     	mov	x20, x0
400020c8: aa1f03f7     	mov	x23, xzr
400020cc: 90000073     	adrp	x19, 0x4000e000 <__bss_start+0x3000>
400020d0: 91256273     	add	x19, x19, #0x958
400020d4: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
400020d8: 911562b5     	add	x21, x21, #0x558
400020dc: b0000038     	adrp	x24, 0x40007000 <__rodata_start>
400020e0: 91249718     	add	x24, x24, #0x925
400020e4: aa1503e0     	mov	x0, x21
400020e8: aa1403e1     	mov	x1, x20
400020ec: 940001af     	bl	0x400027a8 <kstrcmp>
400020f0: 34000160     	cbz	w0, 0x4000211c <script_get_var+0x7c>
400020f4: b98556c8     	ldrsw	x8, [x22, #0x554]
400020f8: 910006f7     	add	x23, x23, #0x1
400020fc: 91020273     	add	x19, x19, #0x80
40002100: 910082b5     	add	x21, x21, #0x20
40002104: eb0802ff     	cmp	x23, x8
40002108: 54fffeeb     	b.lt	0x400020e4 <script_get_var+0x44>
4000210c: aa1803f3     	mov	x19, x24
40002110: 14000003     	b	0x4000211c <script_get_var+0x7c>
40002114: b0000033     	adrp	x19, 0x40007000 <__rodata_start>
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
40002144: b0000039     	adrp	x25, 0x40007000 <__rodata_start>
40002148: 91249739     	add	x25, x25, #0x925
4000214c: a9055ff8     	stp	x24, x23, [sp, #0x50]
40002150: 910003f8     	mov	x24, sp
40002154: 9000007a     	adrp	x26, 0x4000e000 <__bss_start+0x3000>
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
40002208: 90000075     	adrp	x21, 0x4000e000 <__bss_start+0x3000>
4000220c: 911562b5     	add	x21, x21, #0x558
40002210: 90000077     	adrp	x23, 0x4000e000 <__bss_start+0x3000>
40002214: 912562f7     	add	x23, x23, #0x958
40002218: 910003e1     	mov	x1, sp
4000221c: aa1503e0     	mov	x0, x21
40002220: 94000162     	bl	0x400027a8 <kstrcmp>
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
400022d0: 34001d28     	cbz	w8, 0x40002674 <script_execute_line+0x3d8>
400022d4: 14000003     	b	0x400022e0 <script_execute_line+0x44>
400022d8: 71008d1f     	cmp	w8, #0x23
400022dc: 54001cc0     	b.eq	0x40002674 <script_execute_line+0x3d8>
400022e0: 910403e1     	add	x1, sp, #0x100
400022e4: 910403f3     	add	x19, sp, #0x100
400022e8: 97ffff93     	bl	0x40002134 <script_expand_vars>
400022ec: 394403e8     	ldrb	w8, [sp, #0x100]
400022f0: 34001be8     	cbz	w8, 0x4000266c <script_execute_line+0x3d0>
400022f4: 0f018400     	movi	v0.4h, #0x20
400022f8: 4f01e401     	movi	v1.16b, #0x20
400022fc: 394407ea     	ldrb	w10, [sp, #0x101]
40002300: aa1f03e9     	mov	x9, xzr
40002304: 9100426b     	add	x11, x19, #0x10
40002308: 2a0803ec     	mov	w12, w8
4000230c: 14000004     	b	0x4000231c <script_execute_line+0x80>
40002310: 91000529     	add	x9, x9, #0x1
40002314: 38696a6c     	ldrb	w12, [x19, x9]
40002318: 34000a2c     	cbz	w12, 0x4000245c <script_execute_line+0x1c0>
4000231c: b4ffffa9     	cbz	x9, 0x40002310 <script_execute_line+0x74>
40002320: 7100f59f     	cmp	w12, #0x3d
40002324: 54ffff61     	b.ne	0x40002310 <script_execute_line+0x74>
40002328: 8b13012c     	add	x12, x9, x19
4000232c: 385ff18d     	ldurb	w13, [x12, #-0x1]
40002330: 7100f5bf     	cmp	w13, #0x3d
40002334: 54fffee0     	b.eq	0x40002310 <script_execute_line+0x74>
40002338: 3940058c     	ldrb	w12, [x12, #0x1]
4000233c: 7100f59f     	cmp	w12, #0x3d
40002340: 54fffe80     	b.eq	0x40002310 <script_execute_line+0x74>
40002344: f100113f     	cmp	x9, #0x4
40002348: 54000082     	b.hs	0x40002358 <script_execute_line+0xbc>
4000234c: aa1f03ec     	mov	x12, xzr
40002350: 2a1f03ed     	mov	w13, wzr
40002354: 1400002f     	b	0x40002410 <script_execute_line+0x174>
40002358: f100813f     	cmp	x9, #0x20
4000235c: 54000082     	b.hs	0x4000236c <script_execute_line+0xd0>
40002360: aa1f03ec     	mov	x12, xzr
40002364: 2a1f03ed     	mov	w13, wzr
40002368: 14000018     	b	0x400023c8 <script_execute_line+0x12c>
4000236c: 6f00e402     	movi	v2.2d, #0000000000000000
40002370: 6f00e403     	movi	v3.2d, #0000000000000000
40002374: 927be92d     	and	x13, x9, #0xffffffffffffffe0
40002378: 927be52c     	and	x12, x9, #0x7fffffffffffffe0
4000237c: aa0b03ee     	mov	x14, x11
40002380: ad7f95c4     	ldp	q4, q5, [x14, #-0x10]
40002384: f10081ad     	subs	x13, x13, #0x20
40002388: 910081ce     	add	x14, x14, #0x20
4000238c: 6e218c84     	cmeq	v4.16b, v4.16b, v1.16b
40002390: 6e218ca5     	cmeq	v5.16b, v5.16b, v1.16b
40002394: 4ea41c42     	orr	v2.16b, v2.16b, v4.16b
40002398: 4ea51c63     	orr	v3.16b, v3.16b, v5.16b
4000239c: 54ffff21     	b.ne	0x40002380 <script_execute_line+0xe4>
400023a0: 4ea21c62     	orr	v2.16b, v3.16b, v2.16b
400023a4: eb0c013f     	cmp	x9, x12
400023a8: 4f0f5442     	shl	v2.16b, v2.16b, #0x7
400023ac: 4e20a842     	cmlt	v2.16b, v2.16b, #0
400023b0: 6e30a842     	umaxv	b2, v2.16b
400023b4: 1e26004d     	fmov	w13, s2
400023b8: 120001ad     	and	w13, w13, #0x1
400023bc: 540003a0     	b.eq	0x40002430 <script_execute_line+0x194>
400023c0: f27e093f     	tst	x9, #0x1c
400023c4: 54000260     	b.eq	0x40002410 <script_execute_line+0x174>
400023c8: 0e020da2     	dup	v2.4h, w13
400023cc: 927ef52d     	and	x13, x9, #0xfffffffffffffffc
400023d0: 8b0c026e     	add	x14, x19, x12
400023d4: cb0d018d     	sub	x13, x12, x13
400023d8: 927ef12c     	and	x12, x9, #0x7ffffffffffffffc
400023dc: bc4045c3     	ldr	s3, [x14], #0x4
400023e0: b10011ad     	adds	x13, x13, #0x4
400023e4: 2f08a463     	ushll	v3.8h, v3.8b, #0x0
400023e8: 2e608c63     	cmeq	v3.4h, v3.4h, v0.4h
400023ec: 0ea31c42     	orr	v2.8b, v2.8b, v3.8b
400023f0: 54ffff61     	b.ne	0x400023dc <script_execute_line+0x140>
400023f4: 0f1f5442     	shl	v2.4h, v2.4h, #0xf
400023f8: eb0c013f     	cmp	x9, x12
400023fc: 0e60a842     	cmlt	v2.4h, v2.4h, #0
40002400: 2e70a842     	umaxv	h2, v2.4h
40002404: 1e26004d     	fmov	w13, s2
40002408: 120001ad     	and	w13, w13, #0x1
4000240c: 54000120     	b.eq	0x40002430 <script_execute_line+0x194>
40002410: 386c6a6e     	ldrb	w14, [x19, x12]
40002414: 9100058c     	add	x12, x12, #0x1
40002418: 710081df     	cmp	w14, #0x20
4000241c: 1a9f15ad     	csinc	w13, w13, wzr, ne
40002420: eb0c013f     	cmp	x9, x12
40002424: 54ffff61     	b.ne	0x40002410 <script_execute_line+0x174>
40002428: 710001bf     	cmp	w13, #0x0
4000242c: 1a9f07ed     	cset	w13, ne
40002430: 3707f70d     	tbnz	w13, #0x0, 0x40002310 <script_execute_line+0x74>
40002434: 7101a51f     	cmp	w8, #0x69
40002438: 54fff6c0     	b.eq	0x40002310 <script_execute_line+0x74>
4000243c: 7101995f     	cmp	w10, #0x66
40002440: 54fff680     	b.eq	0x40002310 <script_execute_line+0x74>
40002444: 910403e8     	add	x8, sp, #0x100
40002448: 910403e0     	add	x0, sp, #0x100
4000244c: 8b090101     	add	x1, x8, x9
40002450: 3800143f     	strb	wzr, [x1], #0x1
40002454: 97fffed7     	bl	0x40001fb0 <script_set_var>
40002458: 14000087     	b	0x40002674 <script_execute_line+0x3d8>
4000245c: 394403e8     	ldrb	w8, [sp, #0x100]
40002460: 7101a51f     	cmp	w8, #0x69
40002464: 54001041     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002468: 7101995f     	cmp	w10, #0x66
4000246c: 54001001     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002470: 39440be8     	ldrb	w8, [sp, #0x102]
40002474: 7100811f     	cmp	w8, #0x20
40002478: 54000fa1     	b.ne	0x4000266c <script_execute_line+0x3d0>
4000247c: 39440fe9     	ldrb	w9, [sp, #0x103]
40002480: 7100813f     	cmp	w9, #0x20
40002484: 54000081     	b.ne	0x40002494 <script_execute_line+0x1f8>
40002488: aa1f03e9     	mov	x9, xzr
4000248c: 52800068     	mov	w8, #0x3                // =3
40002490: 14000014     	b	0x400024e0 <script_execute_line+0x244>
40002494: 910403ea     	add	x10, sp, #0x100
40002498: aa1f03e8     	mov	x8, xzr
4000249c: 910303eb     	add	x11, sp, #0xc0
400024a0: 9100114a     	add	x10, x10, #0x4
400024a4: 34000189     	cbz	w9, 0x400024d4 <script_execute_line+0x238>
400024a8: f100f91f     	cmp	x8, #0x3e
400024ac: 54000148     	b.hi	0x400024d4 <script_execute_line+0x238>
400024b0: 38286969     	strb	w9, [x11, x8]
400024b4: 38686949     	ldrb	w9, [x10, x8]
400024b8: 9100050c     	add	x12, x8, #0x1
400024bc: aa0c03e8     	mov	x8, x12
400024c0: 7100813f     	cmp	w9, #0x20
400024c4: 54ffff01     	b.ne	0x400024a4 <script_execute_line+0x208>
400024c8: 11000d8a     	add	w10, w12, #0x3
400024cc: 2a0c03e8     	mov	w8, w12
400024d0: 14000002     	b	0x400024d8 <script_execute_line+0x23c>
400024d4: 11000d0a     	add	w10, w8, #0x3
400024d8: 2a0803e9     	mov	w9, w8
400024dc: 2a0a03e8     	mov	w8, w10
400024e0: 910303ea     	add	x10, sp, #0xc0
400024e4: 3829695f     	strb	wzr, [x10, x9]
400024e8: 910403e9     	add	x9, sp, #0x100
400024ec: 3868692a     	ldrb	w10, [x9, x8]
400024f0: 7100815f     	cmp	w10, #0x20
400024f4: 54000061     	b.ne	0x40002500 <script_execute_line+0x264>
400024f8: 91000508     	add	x8, x8, #0x1
400024fc: 17fffffc     	b	0x400024ec <script_execute_line+0x250>
40002500: 7100855f     	cmp	w10, #0x21
40002504: 54000060     	b.eq	0x40002510 <script_execute_line+0x274>
40002508: 7100f55f     	cmp	w10, #0x3d
4000250c: 540000e1     	b.ne	0x40002528 <script_execute_line+0x28c>
40002510: 11000509     	add	w9, w8, #0x1
40002514: 910403ea     	add	x10, sp, #0x100
40002518: 38694949     	ldrb	w9, [x10, w9, uxtw]
4000251c: 9100090a     	add	x10, x8, #0x2
40002520: 7100f53f     	cmp	w9, #0x3d
40002524: 9a880148     	csel	x8, x10, x8, eq
40002528: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
4000252c: 910403ea     	add	x10, sp, #0x100
40002530: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002534: 8b088129     	add	x9, x9, x8, lsl #32
40002538: 8b28c14a     	add	x10, x10, w8, sxtw
4000253c: 51000508     	sub	w8, w8, #0x1
40002540: 3840154c     	ldrb	w12, [x10], #0x1
40002544: 8b0b0129     	add	x9, x9, x11
40002548: 11000508     	add	w8, w8, #0x1
4000254c: 7100819f     	cmp	w12, #0x20
40002550: 54ffff80     	b.eq	0x40002540 <script_execute_line+0x2a4>
40002554: 9360fd2c     	asr	x12, x9, #32
40002558: 910403e9     	add	x9, sp, #0x100
4000255c: 386c692d     	ldrb	w13, [x9, x12]
40002560: 710081bf     	cmp	w13, #0x20
40002564: 54000061     	b.ne	0x40002570 <script_execute_line+0x2d4>
40002568: aa1f03ea     	mov	x10, xzr
4000256c: 14000010     	b	0x400025ac <script_execute_line+0x310>
40002570: aa1f03eb     	mov	x11, xzr
40002574: 910203ec     	add	x12, sp, #0x80
40002578: 3400016d     	cbz	w13, 0x400025a4 <script_execute_line+0x308>
4000257c: f100f97f     	cmp	x11, #0x3e
40002580: 54000128     	b.hi	0x400025a4 <script_execute_line+0x308>
40002584: 382b698d     	strb	w13, [x12, x11]
40002588: 386b694d     	ldrb	w13, [x10, x11]
4000258c: 9100056e     	add	x14, x11, #0x1
40002590: 11000508     	add	w8, w8, #0x1
40002594: aa0e03eb     	mov	x11, x14
40002598: 710081bf     	cmp	w13, #0x20
4000259c: 54fffee1     	b.ne	0x40002578 <script_execute_line+0x2dc>
400025a0: 2a0e03eb     	mov	w11, w14
400025a4: 93407d0c     	sxtw	x12, w8
400025a8: 2a0b03ea     	mov	w10, w11
400025ac: d3607d8d     	lsl	x13, x12, #32
400025b0: 910203eb     	add	x11, sp, #0x80
400025b4: d2c0006f     	mov	x15, #0x300000000       // =12884901888
400025b8: d2c00050     	mov	x16, #0x200000000       // =8589934592
400025bc: d2c0002e     	mov	x14, #0x100000000       // =4294967296
400025c0: 11001108     	add	w8, w8, #0x4
400025c4: 382a697f     	strb	wzr, [x11, x10]
400025c8: 8b0f01aa     	add	x10, x13, x15
400025cc: 8b1001ab     	add	x11, x13, x16
400025d0: 8b0e01ad     	add	x13, x13, x14
400025d4: 8b0c0129     	add	x9, x9, x12
400025d8: 3840152c     	ldrb	w12, [x9], #0x1
400025dc: 7100819f     	cmp	w12, #0x20
400025e0: 540000c1     	b.ne	0x400025f8 <script_execute_line+0x35c>
400025e4: 11000508     	add	w8, w8, #0x1
400025e8: 8b0e014a     	add	x10, x10, x14
400025ec: 8b0e016b     	add	x11, x11, x14
400025f0: 8b0e01ad     	add	x13, x13, x14
400025f4: 17fffff9     	b	0x400025d8 <script_execute_line+0x33c>
400025f8: 7101d19f     	cmp	w12, #0x74
400025fc: 54000381     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002600: 9360fdac     	asr	x12, x13, #32
40002604: 910403e9     	add	x9, sp, #0x100
40002608: 386c692c     	ldrb	w12, [x9, x12]
4000260c: 7101a19f     	cmp	w12, #0x68
40002610: 540002e1     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002614: 9360fd6b     	asr	x11, x11, #32
40002618: 386b6929     	ldrb	w9, [x9, x11]
4000261c: 7101953f     	cmp	w9, #0x65
40002620: 54000261     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002624: 9360fd4a     	asr	x10, x10, #32
40002628: 910403e9     	add	x9, sp, #0x100
4000262c: 386a692a     	ldrb	w10, [x9, x10]
40002630: 7101b95f     	cmp	w10, #0x6e
40002634: 540001c1     	b.ne	0x4000266c <script_execute_line+0x3d0>
40002638: 8b28c128     	add	x8, x9, w8, sxtw
4000263c: d1000501     	sub	x1, x8, #0x1
40002640: 38401c28     	ldrb	w8, [x1, #0x1]!
40002644: 7100811f     	cmp	w8, #0x20
40002648: 54ffffc0     	b.eq	0x40002640 <script_execute_line+0x3a4>
4000264c: 910003e0     	mov	x0, sp
40002650: 94000075     	bl	0x40002824 <kstrcpy>
40002654: 910303e0     	add	x0, sp, #0xc0
40002658: 910203e1     	add	x1, sp, #0x80
4000265c: 94000053     	bl	0x400027a8 <kstrcmp>
40002660: 350000a0     	cbnz	w0, 0x40002674 <script_execute_line+0x3d8>
40002664: 910003e0     	mov	x0, sp
40002668: 14000002     	b	0x40002670 <script_execute_line+0x3d4>
4000266c: 910403e0     	add	x0, sp, #0x100
40002670: 97fff997     	bl	0x40000ccc <execute_command>
40002674: 2a1f03e0     	mov	w0, wzr
40002678: 910803ff     	add	sp, sp, #0x200
4000267c: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002680: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002684: d65f03c0     	ret

0000000040002688 <script_run_file>:
40002688: d10503ff     	sub	sp, sp, #0x140
4000268c: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002690: 910403fd     	add	x29, sp, #0x100
40002694: f9008bfc     	str	x28, [sp, #0x110]
40002698: a91257f6     	stp	x22, x21, [sp, #0x120]
4000269c: a9134ff4     	stp	x20, x19, [sp, #0x130]
400026a0: aa0003f4     	mov	x20, x0
400026a4: 940008f2     	bl	0x40004a6c <vfs_find>
400026a8: b4000080     	cbz	x0, 0x400026b8 <script_run_file+0x30>
400026ac: b9402008     	ldr	w8, [x0, #0x20]
400026b0: aa0003f3     	mov	x19, x0
400026b4: 340000e8     	cbz	w8, 0x400026d0 <script_run_file+0x48>
400026b8: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400026bc: 9103b000     	add	x0, x0, #0xec
400026c0: aa1403e1     	mov	x1, x20
400026c4: 9400050e     	bl	0x40003afc <uart_printf>
400026c8: 12800000     	mov	w0, #-0x1               // =-1
400026cc: 14000021     	b	0x40002750 <script_run_file+0xc8>
400026d0: f9401668     	ldr	x8, [x19, #0x28]
400026d4: aa1f03f4     	mov	x20, xzr
400026d8: 2a1f03e9     	mov	w9, wzr
400026dc: 9100c275     	add	x21, x19, #0x30
400026e0: 910003f6     	mov	x22, sp
400026e4: 14000008     	b	0x40002704 <script_run_file+0x7c>
400026e8: 7100053f     	cmp	w9, #0x1
400026ec: 3829cadf     	strb	wzr, [x22, w9, sxtw]
400026f0: 2a1f03e9     	mov	w9, wzr
400026f4: 5400022a     	b.ge	0x40002738 <script_run_file+0xb0>
400026f8: 91000694     	add	x20, x20, #0x1
400026fc: eb08029f     	cmp	x20, x8
40002700: 54000268     	b.hi	0x4000274c <script_run_file+0xc4>
40002704: eb08029f     	cmp	x20, x8
40002708: 54ffff00     	b.eq	0x400026e8 <script_run_file+0x60>
4000270c: 38746aaa     	ldrb	w10, [x21, x20]
40002710: 7100295f     	cmp	w10, #0xa
40002714: 54fffea0     	b.eq	0x400026e8 <script_run_file+0x60>
40002718: 7100355f     	cmp	w10, #0xd
4000271c: 54fffee0     	b.eq	0x400026f8 <script_run_file+0x70>
40002720: 7103f93f     	cmp	w9, #0xfe
40002724: 54fffeac     	b.gt	0x400026f8 <script_run_file+0x70>
40002728: 1100052b     	add	w11, w9, #0x1
4000272c: 3829caca     	strb	w10, [x22, w9, sxtw]
40002730: 2a0b03e9     	mov	w9, w11
40002734: 17fffff1     	b	0x400026f8 <script_run_file+0x70>
40002738: 910003e0     	mov	x0, sp
4000273c: 97fffed8     	bl	0x4000229c <script_execute_line>
40002740: f9401668     	ldr	x8, [x19, #0x28]
40002744: 2a1f03e9     	mov	w9, wzr
40002748: 17ffffec     	b	0x400026f8 <script_run_file+0x70>
4000274c: 2a1f03e0     	mov	w0, wzr
40002750: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002754: f9408bfc     	ldr	x28, [sp, #0x110]
40002758: a95257f6     	ldp	x22, x21, [sp, #0x120]
4000275c: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002760: 910503ff     	add	sp, sp, #0x140
40002764: d65f03c0     	ret

0000000040002768 <kstrlen>:
40002768: b40000c0     	cbz	x0, 0x40002780 <kstrlen+0x18>
4000276c: aa1f03e8     	mov	x8, xzr
40002770: 38686809     	ldrb	w9, [x0, x8]
40002774: 91000508     	add	x8, x8, #0x1
40002778: 35ffffc9     	cbnz	w9, 0x40002770 <kstrlen+0x8>
4000277c: d1000500     	sub	x0, x8, #0x1
40002780: d65f03c0     	ret

0000000040002784 <kstrcat>:
40002784: b4000100     	cbz	x0, 0x400027a4 <kstrcat+0x20>
40002788: b40000e1     	cbz	x1, 0x400027a4 <kstrcat+0x20>
4000278c: d1000408     	sub	x8, x0, #0x1
40002790: 38401d09     	ldrb	w9, [x8, #0x1]!
40002794: 35ffffe9     	cbnz	w9, 0x40002790 <kstrcat+0xc>
40002798: 38401429     	ldrb	w9, [x1], #0x1
4000279c: 38001509     	strb	w9, [x8], #0x1
400027a0: 35ffffc9     	cbnz	w9, 0x40002798 <kstrcat+0x14>
400027a4: d65f03c0     	ret

00000000400027a8 <kstrcmp>:
400027a8: aa0003e8     	mov	x8, x0
400027ac: 12800000     	mov	w0, #-0x1               // =-1
400027b0: b4000188     	cbz	x8, 0x400027e0 <kstrcmp+0x38>
400027b4: b4000161     	cbz	x1, 0x400027e0 <kstrcmp+0x38>
400027b8: 38401509     	ldrb	w9, [x8], #0x1
400027bc: 340000e9     	cbz	w9, 0x400027d8 <kstrcmp+0x30>
400027c0: 3940002a     	ldrb	w10, [x1]
400027c4: 6b0a013f     	cmp	w9, w10
400027c8: 54000081     	b.ne	0x400027d8 <kstrcmp+0x30>
400027cc: 38401509     	ldrb	w9, [x8], #0x1
400027d0: 91000421     	add	x1, x1, #0x1
400027d4: 35ffff69     	cbnz	w9, 0x400027c0 <kstrcmp+0x18>
400027d8: 39400028     	ldrb	w8, [x1]
400027dc: 4b080120     	sub	w0, w9, w8
400027e0: d65f03c0     	ret

00000000400027e4 <kstrncmp>:
400027e4: 12800008     	mov	w8, #-0x1               // =-1
400027e8: b4000160     	cbz	x0, 0x40002814 <kstrncmp+0x30>
400027ec: b4000141     	cbz	x1, 0x40002814 <kstrncmp+0x30>
400027f0: b4000102     	cbz	x2, 0x40002810 <kstrncmp+0x2c>
400027f4: 38401408     	ldrb	w8, [x0], #0x1
400027f8: 38401429     	ldrb	w9, [x1], #0x1
400027fc: 34000108     	cbz	w8, 0x4000281c <kstrncmp+0x38>
40002800: 6b09011f     	cmp	w8, w9
40002804: 540000c1     	b.ne	0x4000281c <kstrncmp+0x38>
40002808: f1000442     	subs	x2, x2, #0x1
4000280c: 54ffff41     	b.ne	0x400027f4 <kstrncmp+0x10>
40002810: 2a1f03e8     	mov	w8, wzr
40002814: 2a0803e0     	mov	w0, w8
40002818: d65f03c0     	ret
4000281c: 4b090100     	sub	w0, w8, w9
40002820: d65f03c0     	ret

0000000040002824 <kstrcpy>:
40002824: b40000c0     	cbz	x0, 0x4000283c <kstrcpy+0x18>
40002828: b40000a1     	cbz	x1, 0x4000283c <kstrcpy+0x18>
4000282c: aa0003e8     	mov	x8, x0
40002830: 38401429     	ldrb	w9, [x1], #0x1
40002834: 38001509     	strb	w9, [x8], #0x1
40002838: 35ffffc9     	cbnz	w9, 0x40002830 <kstrcpy+0xc>
4000283c: d65f03c0     	ret

0000000040002840 <kstrncpy>:
40002840: b4000660     	cbz	x0, 0x4000290c <kstrncpy+0xcc>
40002844: b4000641     	cbz	x1, 0x4000290c <kstrncpy+0xcc>
40002848: b4000622     	cbz	x2, 0x4000290c <kstrncpy+0xcc>
4000284c: aa0003e9     	mov	x9, x0
40002850: 9100440a     	add	x10, x0, #0x11
40002854: aa0003e8     	mov	x8, x0
40002858: 3840142b     	ldrb	w11, [x1], #0x1
4000285c: 3800150b     	strb	w11, [x8], #0x1
40002860: 340000cb     	cbz	w11, 0x40002878 <kstrncpy+0x38>
40002864: f1000442     	subs	x2, x2, #0x1
40002868: 9100054a     	add	x10, x10, #0x1
4000286c: aa0803e9     	mov	x9, x8
40002870: 54ffff41     	b.ne	0x40002858 <kstrncpy+0x18>
40002874: 14000026     	b	0x4000290c <kstrncpy+0xcc>
40002878: f1001c5f     	cmp	x2, #0x7
4000287c: 54000068     	b.hi	0x40002888 <kstrncpy+0x48>
40002880: aa0203ea     	mov	x10, x2
40002884: 1400001f     	b	0x40002900 <kstrncpy+0xc0>
40002888: f100805f     	cmp	x2, #0x20
4000288c: 54000062     	b.hs	0x40002898 <kstrncpy+0x58>
40002890: aa1f03eb     	mov	x11, xzr
40002894: 1400000c     	b	0x400028c4 <kstrncpy+0x84>
40002898: 6f00e400     	movi	v0.2d, #0000000000000000
4000289c: 927be84b     	and	x11, x2, #0xffffffffffffffe0
400028a0: aa0b03ec     	mov	x12, x11
400028a4: f100818c     	subs	x12, x12, #0x20
400028a8: ad3f8140     	stp	q0, q0, [x10, #-0x10]
400028ac: 9100814a     	add	x10, x10, #0x20
400028b0: 54ffffa1     	b.ne	0x400028a4 <kstrncpy+0x64>
400028b4: eb0b005f     	cmp	x2, x11
400028b8: 540002a0     	b.eq	0x4000290c <kstrncpy+0xcc>
400028bc: f27d045f     	tst	x2, #0x18
400028c0: 540001c0     	b.eq	0x400028f8 <kstrncpy+0xb8>
400028c4: 6f00e400     	movi	v0.2d, #0000000000000000
400028c8: 927df04c     	and	x12, x2, #0xfffffffffffffff8
400028cc: 9240084a     	and	x10, x2, #0x7
400028d0: 8b0c0108     	add	x8, x8, x12
400028d4: cb0c016d     	sub	x13, x11, x12
400028d8: 9100056b     	add	x11, x11, #0x1
400028dc: b10021ad     	adds	x13, x13, #0x8
400028e0: fc2b6920     	str	d0, [x9, x11]
400028e4: 9100216b     	add	x11, x11, #0x8
400028e8: 54ffffa1     	b.ne	0x400028dc <kstrncpy+0x9c>
400028ec: eb0c005f     	cmp	x2, x12
400028f0: 54000081     	b.ne	0x40002900 <kstrncpy+0xc0>
400028f4: 14000006     	b	0x4000290c <kstrncpy+0xcc>
400028f8: 9240104a     	and	x10, x2, #0x1f
400028fc: 8b0b0108     	add	x8, x8, x11
40002900: f100054a     	subs	x10, x10, #0x1
40002904: 3800151f     	strb	wzr, [x8], #0x1
40002908: 54ffffc1     	b.ne	0x40002900 <kstrncpy+0xc0>
4000290c: d65f03c0     	ret

0000000040002910 <memset>:
40002910: b4000500     	cbz	x0, 0x400029b0 <memset+0xa0>
40002914: b40004e2     	cbz	x2, 0x400029b0 <memset+0xa0>
40002918: f100205f     	cmp	x2, #0x8
4000291c: 54000082     	b.hs	0x4000292c <memset+0x1c>
40002920: aa0003e8     	mov	x8, x0
40002924: aa0203e9     	mov	x9, x2
40002928: 1400001f     	b	0x400029a4 <memset+0x94>
4000292c: f100805f     	cmp	x2, #0x20
40002930: 54000062     	b.hs	0x4000293c <memset+0x2c>
40002934: aa1f03ea     	mov	x10, xzr
40002938: 1400000d     	b	0x4000296c <memset+0x5c>
4000293c: 4e010c20     	dup	v0.16b, w1
40002940: 927be84a     	and	x10, x2, #0xffffffffffffffe0
40002944: 91004008     	add	x8, x0, #0x10
40002948: aa0a03e9     	mov	x9, x10
4000294c: f1008129     	subs	x9, x9, #0x20
40002950: ad3f8100     	stp	q0, q0, [x8, #-0x10]
40002954: 91008108     	add	x8, x8, #0x20
40002958: 54ffffa1     	b.ne	0x4000294c <memset+0x3c>
4000295c: eb0a005f     	cmp	x2, x10
40002960: 54000280     	b.eq	0x400029b0 <memset+0xa0>
40002964: f27d045f     	tst	x2, #0x18
40002968: 540001a0     	b.eq	0x4000299c <memset+0x8c>
4000296c: 0e010c20     	dup	v0.8b, w1
40002970: 927df04b     	and	x11, x2, #0xfffffffffffffff8
40002974: 92400849     	and	x9, x2, #0x7
40002978: 8b0b0008     	add	x8, x0, x11
4000297c: cb0b014c     	sub	x12, x10, x11
40002980: 8b0a000a     	add	x10, x0, x10
40002984: b100218c     	adds	x12, x12, #0x8
40002988: fc008540     	str	d0, [x10], #0x8
4000298c: 54ffffc1     	b.ne	0x40002984 <memset+0x74>
40002990: eb0b005f     	cmp	x2, x11
40002994: 54000081     	b.ne	0x400029a4 <memset+0x94>
40002998: 14000006     	b	0x400029b0 <memset+0xa0>
4000299c: 8b0a0008     	add	x8, x0, x10
400029a0: 92401049     	and	x9, x2, #0x1f
400029a4: f1000529     	subs	x9, x9, #0x1
400029a8: 38001501     	strb	w1, [x8], #0x1
400029ac: 54ffffc1     	b.ne	0x400029a4 <memset+0x94>
400029b0: d65f03c0     	ret

00000000400029b4 <memcpy>:
400029b4: b4000660     	cbz	x0, 0x40002a80 <memcpy+0xcc>
400029b8: b4000641     	cbz	x1, 0x40002a80 <memcpy+0xcc>
400029bc: b4000622     	cbz	x2, 0x40002a80 <memcpy+0xcc>
400029c0: f100205f     	cmp	x2, #0x8
400029c4: 54000103     	b.lo	0x400029e4 <memcpy+0x30>
400029c8: cb010008     	sub	x8, x0, x1
400029cc: f100811f     	cmp	x8, #0x20
400029d0: 540000a3     	b.lo	0x400029e4 <memcpy+0x30>
400029d4: f100805f     	cmp	x2, #0x20
400029d8: 540000e2     	b.hs	0x400029f4 <memcpy+0x40>
400029dc: aa1f03eb     	mov	x11, xzr
400029e0: 14000013     	b	0x40002a2c <memcpy+0x78>
400029e4: aa0103e8     	mov	x8, x1
400029e8: aa0003e9     	mov	x9, x0
400029ec: aa0203ea     	mov	x10, x2
400029f0: 14000020     	b	0x40002a70 <memcpy+0xbc>
400029f4: 927be84b     	and	x11, x2, #0xffffffffffffffe0
400029f8: 91004008     	add	x8, x0, #0x10
400029fc: 91004029     	add	x9, x1, #0x10
40002a00: aa0b03ea     	mov	x10, x11
40002a04: ad7f8520     	ldp	q0, q1, [x9, #-0x10]
40002a08: f100814a     	subs	x10, x10, #0x20
40002a0c: 91008129     	add	x9, x9, #0x20
40002a10: ad3f8500     	stp	q0, q1, [x8, #-0x10]
40002a14: 91008108     	add	x8, x8, #0x20
40002a18: 54ffff61     	b.ne	0x40002a04 <memcpy+0x50>
40002a1c: eb0b005f     	cmp	x2, x11
40002a20: 54000300     	b.eq	0x40002a80 <memcpy+0xcc>
40002a24: f27d045f     	tst	x2, #0x18
40002a28: 540001e0     	b.eq	0x40002a64 <memcpy+0xb0>
40002a2c: 927df04c     	and	x12, x2, #0xfffffffffffffff8
40002a30: 9240084a     	and	x10, x2, #0x7
40002a34: 8b0b000e     	add	x14, x0, x11
40002a38: 8b0c0028     	add	x8, x1, x12
40002a3c: 8b0c0009     	add	x9, x0, x12
40002a40: cb0c016d     	sub	x13, x11, x12
40002a44: 8b0b002b     	add	x11, x1, x11
40002a48: fc408560     	ldr	d0, [x11], #0x8
40002a4c: b10021ad     	adds	x13, x13, #0x8
40002a50: fc0085c0     	str	d0, [x14], #0x8
40002a54: 54ffffa1     	b.ne	0x40002a48 <memcpy+0x94>
40002a58: eb0c005f     	cmp	x2, x12
40002a5c: 540000a1     	b.ne	0x40002a70 <memcpy+0xbc>
40002a60: 14000008     	b	0x40002a80 <memcpy+0xcc>
40002a64: 8b0b0028     	add	x8, x1, x11
40002a68: 8b0b0009     	add	x9, x0, x11
40002a6c: 9240104a     	and	x10, x2, #0x1f
40002a70: 3840150b     	ldrb	w11, [x8], #0x1
40002a74: f100054a     	subs	x10, x10, #0x1
40002a78: 3800152b     	strb	w11, [x9], #0x1
40002a7c: 54ffffa1     	b.ne	0x40002a70 <memcpy+0xbc>
40002a80: d65f03c0     	ret

0000000040002a84 <kstrstr>:
40002a84: aa1f03e2     	mov	x2, xzr
40002a88: b40000e0     	cbz	x0, 0x40002aa4 <kstrstr+0x20>
40002a8c: b40000c1     	cbz	x1, 0x40002aa4 <kstrstr+0x20>
40002a90: 39400028     	ldrb	w8, [x1]
40002a94: 340002c8     	cbz	w8, 0x40002aec <kstrstr+0x68>
40002a98: 39400009     	ldrb	w9, [x0]
40002a9c: 35000109     	cbnz	w9, 0x40002abc <kstrstr+0x38>
40002aa0: aa1f03e2     	mov	x2, xzr
40002aa4: aa0203e0     	mov	x0, x2
40002aa8: d65f03c0     	ret
40002aac: 3940012c     	ldrb	w12, [x9]
40002ab0: 340001ec     	cbz	w12, 0x40002aec <kstrstr+0x68>
40002ab4: 38401c09     	ldrb	w9, [x0, #0x1]!
40002ab8: 34ffff49     	cbz	w9, 0x40002aa0 <kstrstr+0x1c>
40002abc: 6b08013f     	cmp	w9, w8
40002ac0: 54ffffa1     	b.ne	0x40002ab4 <kstrstr+0x30>
40002ac4: 5280002a     	mov	w10, #0x1               // =1
40002ac8: aa0103e9     	mov	x9, x1
40002acc: 2a0803eb     	mov	w11, w8
40002ad0: 3840152c     	ldrb	w12, [x9], #0x1
40002ad4: 6b0c017f     	cmp	w11, w12
40002ad8: 54fffec1     	b.ne	0x40002ab0 <kstrstr+0x2c>
40002adc: 386a680b     	ldrb	w11, [x0, x10]
40002ae0: 9100054a     	add	x10, x10, #0x1
40002ae4: 35ffff6b     	cbnz	w11, 0x40002ad0 <kstrstr+0x4c>
40002ae8: 17fffff1     	b	0x40002aac <kstrstr+0x28>
40002aec: d65f03c0     	ret

0000000040002af0 <kstrchr>:
40002af0: b4000140     	cbz	x0, 0x40002b18 <kstrchr+0x28>
40002af4: 39400009     	ldrb	w9, [x0]
40002af8: 340000c9     	cbz	w9, 0x40002b10 <kstrchr+0x20>
40002afc: 12001c28     	and	w8, w1, #0xff
40002b00: 6b08013f     	cmp	w9, w8
40002b04: 540000a0     	b.eq	0x40002b18 <kstrchr+0x28>
40002b08: 38401c09     	ldrb	w9, [x0, #0x1]!
40002b0c: 35ffffa9     	cbnz	w9, 0x40002b00 <kstrchr+0x10>
40002b10: 72001c3f     	tst	w1, #0xff
40002b14: 9a9f0000     	csel	x0, x0, xzr, eq
40002b18: d65f03c0     	ret

0000000040002b1c <ktolower>:
40002b1c: 51010408     	sub	w8, w0, #0x41
40002b20: 321b0009     	orr	w9, w0, #0x20
40002b24: 7100691f     	cmp	w8, #0x1a
40002b28: 1a803120     	csel	w0, w9, w0, lo
40002b2c: d65f03c0     	ret

0000000040002b30 <kstr_tolower>:
40002b30: b40001a0     	cbz	x0, 0x40002b64 <kstr_tolower+0x34>
40002b34: b4000181     	cbz	x1, 0x40002b64 <kstr_tolower+0x34>
40002b38: 39400029     	ldrb	w9, [x1]
40002b3c: 34000129     	cbz	w9, 0x40002b60 <kstr_tolower+0x30>
40002b40: 91000428     	add	x8, x1, #0x1
40002b44: 5101052a     	sub	w10, w9, #0x41
40002b48: 321b012b     	orr	w11, w9, #0x20
40002b4c: 7100695f     	cmp	w10, #0x1a
40002b50: 1a893169     	csel	w9, w11, w9, lo
40002b54: 38001409     	strb	w9, [x0], #0x1
40002b58: 38401509     	ldrb	w9, [x8], #0x1
40002b5c: 35ffff49     	cbnz	w9, 0x40002b44 <kstr_tolower+0x14>
40002b60: 3900001f     	strb	wzr, [x0]
40002b64: d65f03c0     	ret

0000000040002b68 <tui_launch>:
40002b68: d105c3ff     	sub	sp, sp, #0x170
40002b6c: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002b70: 910443fd     	add	x29, sp, #0x110
40002b74: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002b78: a91367fa     	stp	x26, x25, [sp, #0x130]
40002b7c: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002b80: a91557f6     	stp	x22, x21, [sp, #0x150]
40002b84: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002b88: 9400074b     	bl	0x400048b4 <vfs_get_cwd>
40002b8c: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002b90: b000007c     	adrp	x28, 0x4000f000 <var_values+0x6a8>
40002b94: b000007b     	adrp	x27, 0x4000f000 <var_values+0x6a8>
40002b98: f904ad00     	str	x0, [x8, #0x958]
40002b9c: d503201f     	nop
40002ba0: 1002e460     	adr	x0, 0x4000882c <__rodata_start+0x182c>
40002ba4: b909639f     	str	wzr, [x28, #0x960]
40002ba8: b909677f     	str	wzr, [x27, #0x964]
40002bac: 940002c4     	bl	0x400036bc <uart_puts>
40002bb0: b0000036     	adrp	x22, 0x40007000 <__rodata_start>
40002bb4: 9111fed6     	add	x22, x22, #0x47f
40002bb8: b0000037     	adrp	x23, 0x40007000 <__rodata_start>
40002bbc: 910dbef7     	add	x23, x23, #0x36f
40002bc0: b0000073     	adrp	x19, 0x4000f000 <var_values+0x6a8>
40002bc4: 9125c273     	add	x19, x19, #0x970
40002bc8: b000007a     	adrp	x26, 0x4000f000 <var_values+0x6a8>
40002bcc: 14000005     	b	0x40002be0 <tui_launch+0x78>
40002bd0: b9496388     	ldr	w8, [x28, #0x960]
40002bd4: 7100011f     	cmp	w8, #0x0
40002bd8: 1a9f17e8     	cset	w8, eq
40002bdc: b9096388     	str	w8, [x28, #0x960]
40002be0: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002be4: b9096b5f     	str	wzr, [x26, #0x968]
40002be8: f944ad0a     	ldr	x10, [x8, #0x958]
40002bec: f9421948     	ldr	x8, [x10, #0x430]
40002bf0: b4000108     	cbz	x8, 0x40002c10 <tui_launch+0xa8>
40002bf4: 52800029     	mov	w9, #0x1                // =1
40002bf8: b0000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40002bfc: b9096b49     	str	w9, [x26, #0x968]
40002c00: f904b91f     	str	xzr, [x8, #0x970]
40002c04: f9401548     	ldr	x8, [x10, #0x28]
40002c08: b50000a8     	cbnz	x8, 0x40002c1c <tui_launch+0xb4>
40002c0c: 14000028     	b	0x40002cac <tui_launch+0x144>
40002c10: 2a1f03e9     	mov	w9, wzr
40002c14: f9401548     	ldr	x8, [x10, #0x28]
40002c18: b40004a8     	cbz	x8, 0x40002cac <tui_launch+0x144>
40002c1c: 2a0903e9     	mov	w9, w9
40002c20: d100050b     	sub	x11, x8, #0x1
40002c24: d240152c     	eor	x12, x9, #0x3f
40002c28: eb0c017f     	cmp	x11, x12
40002c2c: 9a8c316b     	csel	x11, x11, x12, lo
40002c30: f1000d7f     	cmp	x11, #0x3
40002c34: 54000062     	b.hs	0x40002c40 <tui_launch+0xd8>
40002c38: aa1f03eb     	mov	x11, xzr
40002c3c: 14000010     	b	0x40002c7c <tui_launch+0x114>
40002c40: 9100056c     	add	x12, x11, #0x1
40002c44: 8b090e6d     	add	x13, x19, x9, lsl #3
40002c48: 9111214e     	add	x14, x10, #0x448
40002c4c: 927e758b     	and	x11, x12, #0xfffffffc
40002c50: aa090169     	orr	x9, x11, x9
40002c54: 910041ad     	add	x13, x13, #0x10
40002c58: aa0b03ef     	mov	x15, x11
40002c5c: ad7f85c0     	ldp	q0, q1, [x14, #-0x10]
40002c60: f10011ef     	subs	x15, x15, #0x4
40002c64: 910081ce     	add	x14, x14, #0x20
40002c68: ad3f85a0     	stp	q0, q1, [x13, #-0x10]
40002c6c: 910081ad     	add	x13, x13, #0x20
40002c70: 54ffff61     	b.ne	0x40002c5c <tui_launch+0xf4>
40002c74: eb0b019f     	cmp	x12, x11
40002c78: 54000180     	b.eq	0x40002ca8 <tui_launch+0x140>
40002c7c: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002c80: 9100056b     	add	x11, x11, #0x1
40002c84: 9110e14a     	add	x10, x10, #0x438
40002c88: f840854c     	ldr	x12, [x10], #0x8
40002c8c: f100f93f     	cmp	x9, #0x3e
40002c90: f8297a6c     	str	x12, [x19, x9, lsl #3]
40002c94: 91000529     	add	x9, x9, #0x1
40002c98: 54000088     	b.hi	0x40002ca8 <tui_launch+0x140>
40002c9c: eb08017f     	cmp	x11, x8
40002ca0: 9100056b     	add	x11, x11, #0x1
40002ca4: 54ffff23     	b.lo	0x40002c88 <tui_launch+0x120>
40002ca8: b9096b49     	str	w9, [x26, #0x968]
40002cac: b949676a     	ldr	w10, [x27, #0x964]
40002cb0: 51000528     	sub	w8, w9, #0x1
40002cb4: 6b08015f     	cmp	w10, w8
40002cb8: 1a88b148     	csel	w8, w10, w8, lt
40002cbc: 6b09015f     	cmp	w10, w9
40002cc0: 5400004a     	b.ge	0x40002cc8 <tui_launch+0x160>
40002cc4: 36f80068     	tbz	w8, #0x1f, 0x40002cd0 <tui_launch+0x168>
40002cc8: 0aa87d08     	bic	w8, w8, w8, asr #31
40002ccc: b9096768     	str	w8, [x27, #0x964]
40002cd0: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002cd4: 91249800     	add	x0, x0, #0x926
40002cd8: 94000279     	bl	0x400036bc <uart_puts>
40002cdc: b9496388     	ldr	w8, [x28, #0x960]
40002ce0: 52800020     	mov	w0, #0x1                // =1
40002ce4: 52800501     	mov	w1, #0x28               // =40
40002ce8: b0000022     	adrp	x2, 0x40007000 <__rodata_start>
40002cec: 91036442     	add	x2, x2, #0xd9
40002cf0: 7100011f     	cmp	w8, #0x0
40002cf4: 1a9f17e3     	cset	w3, eq
40002cf8: 94000171     	bl	0x400032bc <draw_box>
40002cfc: 52800075     	mov	w21, #0x3               // =3
40002d00: aa1603e0     	mov	x0, x22
40002d04: 2a1503e1     	mov	w1, w21
40002d08: 52800042     	mov	w2, #0x2                // =2
40002d0c: 9400037c     	bl	0x40003afc <uart_printf>
40002d10: aa1703e0     	mov	x0, x23
40002d14: 9400026a     	bl	0x400036bc <uart_puts>
40002d18: aa1703e0     	mov	x0, x23
40002d1c: 94000268     	bl	0x400036bc <uart_puts>
40002d20: aa1703e0     	mov	x0, x23
40002d24: 94000266     	bl	0x400036bc <uart_puts>
40002d28: aa1703e0     	mov	x0, x23
40002d2c: 94000264     	bl	0x400036bc <uart_puts>
40002d30: aa1703e0     	mov	x0, x23
40002d34: 94000262     	bl	0x400036bc <uart_puts>
40002d38: aa1703e0     	mov	x0, x23
40002d3c: 94000260     	bl	0x400036bc <uart_puts>
40002d40: aa1703e0     	mov	x0, x23
40002d44: 9400025e     	bl	0x400036bc <uart_puts>
40002d48: aa1703e0     	mov	x0, x23
40002d4c: 9400025c     	bl	0x400036bc <uart_puts>
40002d50: aa1703e0     	mov	x0, x23
40002d54: 9400025a     	bl	0x400036bc <uart_puts>
40002d58: aa1703e0     	mov	x0, x23
40002d5c: 94000258     	bl	0x400036bc <uart_puts>
40002d60: aa1703e0     	mov	x0, x23
40002d64: 94000256     	bl	0x400036bc <uart_puts>
40002d68: aa1703e0     	mov	x0, x23
40002d6c: 94000254     	bl	0x400036bc <uart_puts>
40002d70: aa1703e0     	mov	x0, x23
40002d74: 94000252     	bl	0x400036bc <uart_puts>
40002d78: aa1703e0     	mov	x0, x23
40002d7c: 94000250     	bl	0x400036bc <uart_puts>
40002d80: aa1703e0     	mov	x0, x23
40002d84: 9400024e     	bl	0x400036bc <uart_puts>
40002d88: aa1703e0     	mov	x0, x23
40002d8c: 9400024c     	bl	0x400036bc <uart_puts>
40002d90: aa1703e0     	mov	x0, x23
40002d94: 9400024a     	bl	0x400036bc <uart_puts>
40002d98: aa1703e0     	mov	x0, x23
40002d9c: 94000248     	bl	0x400036bc <uart_puts>
40002da0: aa1703e0     	mov	x0, x23
40002da4: 94000246     	bl	0x400036bc <uart_puts>
40002da8: aa1703e0     	mov	x0, x23
40002dac: 94000244     	bl	0x400036bc <uart_puts>
40002db0: aa1703e0     	mov	x0, x23
40002db4: 94000242     	bl	0x400036bc <uart_puts>
40002db8: aa1703e0     	mov	x0, x23
40002dbc: 94000240     	bl	0x400036bc <uart_puts>
40002dc0: aa1703e0     	mov	x0, x23
40002dc4: 9400023e     	bl	0x400036bc <uart_puts>
40002dc8: aa1703e0     	mov	x0, x23
40002dcc: 9400023c     	bl	0x400036bc <uart_puts>
40002dd0: aa1703e0     	mov	x0, x23
40002dd4: 9400023a     	bl	0x400036bc <uart_puts>
40002dd8: aa1703e0     	mov	x0, x23
40002ddc: 94000238     	bl	0x400036bc <uart_puts>
40002de0: aa1703e0     	mov	x0, x23
40002de4: 94000236     	bl	0x400036bc <uart_puts>
40002de8: aa1703e0     	mov	x0, x23
40002dec: 94000234     	bl	0x400036bc <uart_puts>
40002df0: aa1703e0     	mov	x0, x23
40002df4: 94000232     	bl	0x400036bc <uart_puts>
40002df8: aa1703e0     	mov	x0, x23
40002dfc: 94000230     	bl	0x400036bc <uart_puts>
40002e00: aa1703e0     	mov	x0, x23
40002e04: 9400022e     	bl	0x400036bc <uart_puts>
40002e08: aa1703e0     	mov	x0, x23
40002e0c: 9400022c     	bl	0x400036bc <uart_puts>
40002e10: aa1703e0     	mov	x0, x23
40002e14: 9400022a     	bl	0x400036bc <uart_puts>
40002e18: aa1703e0     	mov	x0, x23
40002e1c: 94000228     	bl	0x400036bc <uart_puts>
40002e20: aa1703e0     	mov	x0, x23
40002e24: 94000226     	bl	0x400036bc <uart_puts>
40002e28: aa1703e0     	mov	x0, x23
40002e2c: 94000224     	bl	0x400036bc <uart_puts>
40002e30: aa1703e0     	mov	x0, x23
40002e34: 94000222     	bl	0x400036bc <uart_puts>
40002e38: aa1703e0     	mov	x0, x23
40002e3c: 94000220     	bl	0x400036bc <uart_puts>
40002e40: 110006b5     	add	w21, w21, #0x1
40002e44: 71005ebf     	cmp	w21, #0x17
40002e48: 54fff5c1     	b.ne	0x40002d00 <tui_launch+0x198>
40002e4c: b9496768     	ldr	w8, [x27, #0x964]
40002e50: 52800249     	mov	w9, #0x12               // =18
40002e54: aa1f03f8     	mov	x24, xzr
40002e58: 7100491f     	cmp	w8, #0x12
40002e5c: 1a89c108     	csel	w8, w8, w9, gt
40002e60: 51004915     	sub	w21, w8, #0x12
40002e64: 8b354e79     	add	x25, x19, w21, uxtw #3
40002e68: 14000004     	b	0x40002e78 <tui_launch+0x310>
40002e6c: 91000718     	add	x24, x24, #0x1
40002e70: f100531f     	cmp	x24, #0x14
40002e74: 540005a0     	b.eq	0x40002f28 <tui_launch+0x3c0>
40002e78: b9896b48     	ldrsw	x8, [x26, #0x968]
40002e7c: 8b1802b4     	add	x20, x21, x24
40002e80: eb08029f     	cmp	x20, x8
40002e84: 5400052a     	b.ge	0x40002f28 <tui_launch+0x3c0>
40002e88: 11000f01     	add	w1, w24, #0x3
40002e8c: aa1603e0     	mov	x0, x22
40002e90: 52800062     	mov	w2, #0x3                // =3
40002e94: 9400031a     	bl	0x40003afc <uart_printf>
40002e98: b9496768     	ldr	w8, [x27, #0x964]
40002e9c: eb08029f     	cmp	x20, x8
40002ea0: 540000c1     	b.ne	0x40002eb8 <tui_launch+0x350>
40002ea4: b9496388     	ldr	w8, [x28, #0x960]
40002ea8: 35000088     	cbnz	w8, 0x40002eb8 <tui_launch+0x350>
40002eac: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002eb0: 9104a400     	add	x0, x0, #0x129
40002eb4: 94000202     	bl	0x400036bc <uart_puts>
40002eb8: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002ebc: b40001e8     	cbz	x8, 0x40002ef8 <tui_launch+0x390>
40002ec0: b9402108     	ldr	w8, [x8, #0x20]
40002ec4: d0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
40002ec8: 910ac529     	add	x9, x9, #0x2b1
40002ecc: 910223e0     	add	x0, sp, #0x88
40002ed0: 7100051f     	cmp	w8, #0x1
40002ed4: b0000028     	adrp	x8, 0x40007000 <__rodata_start>
40002ed8: 91372d08     	add	x8, x8, #0xdcb
40002edc: 9a880121     	csel	x1, x9, x8, eq
40002ee0: 97fffe51     	bl	0x40002824 <kstrcpy>
40002ee4: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002ee8: 910223e0     	add	x0, sp, #0x88
40002eec: 97fffe26     	bl	0x40002784 <kstrcat>
40002ef0: 910223e0     	add	x0, sp, #0x88
40002ef4: 14000003     	b	0x40002f00 <tui_launch+0x398>
40002ef8: b0000020     	adrp	x0, 0x40007000 <__rodata_start>
40002efc: 91320c00     	add	x0, x0, #0xc83
40002f00: 940001ef     	bl	0x400036bc <uart_puts>
40002f04: b9496768     	ldr	w8, [x27, #0x964]
40002f08: eb08029f     	cmp	x20, x8
40002f0c: 54fffb01     	b.ne	0x40002e6c <tui_launch+0x304>
40002f10: b9496388     	ldr	w8, [x28, #0x960]
40002f14: 35fffac8     	cbnz	w8, 0x40002e6c <tui_launch+0x304>
40002f18: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
40002f1c: 9129f800     	add	x0, x0, #0xa7e
40002f20: 940001e7     	bl	0x400036bc <uart_puts>
40002f24: 17ffffd2     	b	0x40002e6c <tui_launch+0x304>
40002f28: b9496388     	ldr	w8, [x28, #0x960]
40002f2c: 52800540     	mov	w0, #0x2a               // =42
40002f30: 528004c1     	mov	w1, #0x26               // =38
40002f34: d0000022     	adrp	x2, 0x40008000 <__rodata_start+0x1000>
40002f38: 91042442     	add	x2, x2, #0x109
40002f3c: 7100051f     	cmp	w8, #0x1
40002f40: 1a9f17e3     	cset	w3, eq
40002f44: 940000de     	bl	0x400032bc <draw_box>
40002f48: 52800075     	mov	w21, #0x3               // =3
40002f4c: aa1603e0     	mov	x0, x22
40002f50: 2a1503e1     	mov	w1, w21
40002f54: 52800562     	mov	w2, #0x2b               // =43
40002f58: 940002e9     	bl	0x40003afc <uart_printf>
40002f5c: aa1703e0     	mov	x0, x23
40002f60: 940001d7     	bl	0x400036bc <uart_puts>
40002f64: aa1703e0     	mov	x0, x23
40002f68: 940001d5     	bl	0x400036bc <uart_puts>
40002f6c: aa1703e0     	mov	x0, x23
40002f70: 940001d3     	bl	0x400036bc <uart_puts>
40002f74: aa1703e0     	mov	x0, x23
40002f78: 940001d1     	bl	0x400036bc <uart_puts>
40002f7c: aa1703e0     	mov	x0, x23
40002f80: 940001cf     	bl	0x400036bc <uart_puts>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 940001cd     	bl	0x400036bc <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 940001cb     	bl	0x400036bc <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 940001c9     	bl	0x400036bc <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 940001c7     	bl	0x400036bc <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 940001c5     	bl	0x400036bc <uart_puts>
40002fac: aa1703e0     	mov	x0, x23
40002fb0: 940001c3     	bl	0x400036bc <uart_puts>
40002fb4: aa1703e0     	mov	x0, x23
40002fb8: 940001c1     	bl	0x400036bc <uart_puts>
40002fbc: aa1703e0     	mov	x0, x23
40002fc0: 940001bf     	bl	0x400036bc <uart_puts>
40002fc4: aa1703e0     	mov	x0, x23
40002fc8: 940001bd     	bl	0x400036bc <uart_puts>
40002fcc: aa1703e0     	mov	x0, x23
40002fd0: 940001bb     	bl	0x400036bc <uart_puts>
40002fd4: aa1703e0     	mov	x0, x23
40002fd8: 940001b9     	bl	0x400036bc <uart_puts>
40002fdc: aa1703e0     	mov	x0, x23
40002fe0: 940001b7     	bl	0x400036bc <uart_puts>
40002fe4: aa1703e0     	mov	x0, x23
40002fe8: 940001b5     	bl	0x400036bc <uart_puts>
40002fec: aa1703e0     	mov	x0, x23
40002ff0: 940001b3     	bl	0x400036bc <uart_puts>
40002ff4: aa1703e0     	mov	x0, x23
40002ff8: 940001b1     	bl	0x400036bc <uart_puts>
40002ffc: aa1703e0     	mov	x0, x23
40003000: 940001af     	bl	0x400036bc <uart_puts>
40003004: aa1703e0     	mov	x0, x23
40003008: 940001ad     	bl	0x400036bc <uart_puts>
4000300c: aa1703e0     	mov	x0, x23
40003010: 940001ab     	bl	0x400036bc <uart_puts>
40003014: aa1703e0     	mov	x0, x23
40003018: 940001a9     	bl	0x400036bc <uart_puts>
4000301c: aa1703e0     	mov	x0, x23
40003020: 940001a7     	bl	0x400036bc <uart_puts>
40003024: aa1703e0     	mov	x0, x23
40003028: 940001a5     	bl	0x400036bc <uart_puts>
4000302c: aa1703e0     	mov	x0, x23
40003030: 940001a3     	bl	0x400036bc <uart_puts>
40003034: aa1703e0     	mov	x0, x23
40003038: 940001a1     	bl	0x400036bc <uart_puts>
4000303c: aa1703e0     	mov	x0, x23
40003040: 9400019f     	bl	0x400036bc <uart_puts>
40003044: aa1703e0     	mov	x0, x23
40003048: 9400019d     	bl	0x400036bc <uart_puts>
4000304c: aa1703e0     	mov	x0, x23
40003050: 9400019b     	bl	0x400036bc <uart_puts>
40003054: aa1703e0     	mov	x0, x23
40003058: 94000199     	bl	0x400036bc <uart_puts>
4000305c: aa1703e0     	mov	x0, x23
40003060: 94000197     	bl	0x400036bc <uart_puts>
40003064: aa1703e0     	mov	x0, x23
40003068: 94000195     	bl	0x400036bc <uart_puts>
4000306c: aa1703e0     	mov	x0, x23
40003070: 94000193     	bl	0x400036bc <uart_puts>
40003074: aa1703e0     	mov	x0, x23
40003078: 94000191     	bl	0x400036bc <uart_puts>
4000307c: 110006b5     	add	w21, w21, #0x1
40003080: 71005ebf     	cmp	w21, #0x17
40003084: 54fff641     	b.ne	0x40002f4c <tui_launch+0x3e4>
40003088: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000308c: 91178c00     	add	x0, x0, #0x5e3
40003090: 52800061     	mov	w1, #0x3                // =3
40003094: 52800562     	mov	w2, #0x2b               // =43
40003098: 94000299     	bl	0x40003afc <uart_printf>
4000309c: d503201f     	nop
400030a0: 10058da8     	adr	x8, 0x4000e254 <proc_table>
400030a4: aa1f03f4     	mov	x20, xzr
400030a8: 9100a115     	add	x21, x8, #0x28
400030ac: 52800058     	mov	w24, #0x2               // =2
400030b0: 90000039     	adrp	x25, 0x40007000 <__rodata_start>
400030b4: 91158339     	add	x25, x25, #0x560
400030b8: b85fc2a8     	ldur	w8, [x21, #-0x4]
400030bc: 71000d1f     	cmp	w8, #0x3
400030c0: 54000140     	b.eq	0x400030e8 <tui_launch+0x580>
400030c4: b94002a8     	ldr	w8, [x21]
400030c8: b85d82a3     	ldur	w3, [x21, #-0x28]
400030cc: d10092a4     	sub	x4, x21, #0x24
400030d0: 11000b01     	add	w1, w24, #0x2
400030d4: aa1903e0     	mov	x0, x25
400030d8: 52800562     	mov	w2, #0x2b               // =43
400030dc: 530a7d05     	lsr	w5, w8, #10
400030e0: 94000287     	bl	0x40003afc <uart_printf>
400030e4: 11000718     	add	w24, w24, #0x1
400030e8: f1003a9f     	cmp	x20, #0xe
400030ec: 540000a8     	b.hi	0x40003100 <tui_launch+0x598>
400030f0: 7100531f     	cmp	w24, #0x14
400030f4: 91000694     	add	x20, x20, #0x1
400030f8: 9100c2b5     	add	x21, x21, #0x30
400030fc: 54fffdeb     	b.lt	0x400030b8 <tui_launch+0x550>
40003100: 940001a2     	bl	0x40003788 <uart_getc>
40003104: 52801be8     	mov	w8, #0xdf               // =223
40003108: 0a080008     	and	w8, w0, w8
4000310c: 7101451f     	cmp	w8, #0x51
40003110: 54000c00     	b.eq	0x40003290 <tui_launch+0x728>
40003114: 12001c08     	and	w8, w0, #0xff
40003118: 7100311f     	cmp	w8, #0xc
4000311c: 5400010c     	b.gt	0x4000313c <tui_launch+0x5d4>
40003120: 7100251f     	cmp	w8, #0x9
40003124: 90000034     	adrp	x20, 0x40007000 <__rodata_start>
40003128: 91202294     	add	x20, x20, #0x808
4000312c: 54ffd520     	b.eq	0x40002bd0 <tui_launch+0x68>
40003130: 7100291f     	cmp	w8, #0xa
40003134: 540002e0     	b.eq	0x40003190 <tui_launch+0x628>
40003138: 17fffeaa     	b	0x40002be0 <tui_launch+0x78>
4000313c: 7100351f     	cmp	w8, #0xd
40003140: 90000034     	adrp	x20, 0x40007000 <__rodata_start>
40003144: 91202294     	add	x20, x20, #0x808
40003148: 54000240     	b.eq	0x40003190 <tui_launch+0x628>
4000314c: 71006d1f     	cmp	w8, #0x1b
40003150: 54ffd481     	b.ne	0x40002be0 <tui_launch+0x78>
40003154: 9400018d     	bl	0x40003788 <uart_getc>
40003158: 12001c14     	and	w20, w0, #0xff
4000315c: 9400018b     	bl	0x40003788 <uart_getc>
40003160: 71016e9f     	cmp	w20, #0x5b
40003164: 54ffd3e1     	b.ne	0x40002be0 <tui_launch+0x78>
40003168: 12001c08     	and	w8, w0, #0xff
4000316c: 7101051f     	cmp	w8, #0x41
40003170: 54000781     	b.ne	0x40003260 <tui_launch+0x6f8>
40003174: b9496388     	ldr	w8, [x28, #0x960]
40003178: 35ffd348     	cbnz	w8, 0x40002be0 <tui_launch+0x78>
4000317c: b9496768     	ldr	w8, [x27, #0x964]
40003180: 71000508     	subs	w8, w8, #0x1
40003184: 54ffd2eb     	b.lt	0x40002be0 <tui_launch+0x78>
40003188: b9096768     	str	w8, [x27, #0x964]
4000318c: 17fffe95     	b	0x40002be0 <tui_launch+0x78>
40003190: b9496388     	ldr	w8, [x28, #0x960]
40003194: 35ffd268     	cbnz	w8, 0x40002be0 <tui_launch+0x78>
40003198: b9496b48     	ldr	w8, [x26, #0x968]
4000319c: 7100051f     	cmp	w8, #0x1
400031a0: 54ffd20b     	b.lt	0x40002be0 <tui_launch+0x78>
400031a4: b9896768     	ldrsw	x8, [x27, #0x964]
400031a8: f8687a75     	ldr	x21, [x19, x8, lsl #3]
400031ac: b4000115     	cbz	x21, 0x400031cc <tui_launch+0x664>
400031b0: b94022a8     	ldr	w8, [x21, #0x20]
400031b4: 7100051f     	cmp	w8, #0x1
400031b8: 54000161     	b.ne	0x400031e4 <tui_launch+0x67c>
400031bc: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
400031c0: b909677f     	str	wzr, [x27, #0x964]
400031c4: f904ad15     	str	x21, [x8, #0x958]
400031c8: 17fffe86     	b	0x40002be0 <tui_launch+0x78>
400031cc: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400031d0: b909677f     	str	wzr, [x27, #0x964]
400031d4: f944ad28     	ldr	x8, [x9, #0x958]
400031d8: f9421908     	ldr	x8, [x8, #0x430]
400031dc: f904ad28     	str	x8, [x9, #0x958]
400031e0: 17fffe80     	b	0x40002be0 <tui_launch+0x78>
400031e4: 390223ff     	strb	wzr, [sp, #0x88]
400031e8: aa1403e0     	mov	x0, x20
400031ec: 94000620     	bl	0x40004a6c <vfs_find>
400031f0: eb0002bf     	cmp	x21, x0
400031f4: 540001e0     	b.eq	0x40003230 <tui_launch+0x6c8>
400031f8: 910023e0     	add	x0, sp, #0x8
400031fc: 910223e1     	add	x1, sp, #0x88
40003200: 97fffd89     	bl	0x40002824 <kstrcpy>
40003204: 910223e0     	add	x0, sp, #0x88
40003208: aa1403e1     	mov	x1, x20
4000320c: 97fffd86     	bl	0x40002824 <kstrcpy>
40003210: 910223e0     	add	x0, sp, #0x88
40003214: aa1503e1     	mov	x1, x21
40003218: 97fffd5b     	bl	0x40002784 <kstrcat>
4000321c: 910223e0     	add	x0, sp, #0x88
40003220: 910023e1     	add	x1, sp, #0x8
40003224: 97fffd58     	bl	0x40002784 <kstrcat>
40003228: f9421ab5     	ldr	x21, [x21, #0x430]
4000322c: b5fffdf5     	cbnz	x21, 0x400031e8 <tui_launch+0x680>
40003230: 910223e0     	add	x0, sp, #0x88
40003234: 97fffd4d     	bl	0x40002768 <kstrlen>
40003238: b5000080     	cbnz	x0, 0x40003248 <tui_launch+0x6e0>
4000323c: 910223e0     	add	x0, sp, #0x88
40003240: aa1403e1     	mov	x1, x20
40003244: 97fffd78     	bl	0x40002824 <kstrcpy>
40003248: 910223e0     	add	x0, sp, #0x88
4000324c: 97fff3d4     	bl	0x4000019c <launch_kedit>
40003250: d503201f     	nop
40003254: 1002aec0     	adr	x0, 0x4000882c <__rodata_start+0x182c>
40003258: 94000119     	bl	0x400036bc <uart_puts>
4000325c: 17fffe61     	b	0x40002be0 <tui_launch+0x78>
40003260: 7101091f     	cmp	w8, #0x42
40003264: 54ffcbe1     	b.ne	0x40002be0 <tui_launch+0x78>
40003268: b9496388     	ldr	w8, [x28, #0x960]
4000326c: 35ffcba8     	cbnz	w8, 0x40002be0 <tui_launch+0x78>
40003270: b9496b49     	ldr	w9, [x26, #0x968]
40003274: b9496768     	ldr	w8, [x27, #0x964]
40003278: 51000529     	sub	w9, w9, #0x1
4000327c: 6b09011f     	cmp	w8, w9
40003280: 54ffcb0a     	b.ge	0x40002be0 <tui_launch+0x78>
40003284: 11000508     	add	w8, w8, #0x1
40003288: b9096768     	str	w8, [x27, #0x964]
4000328c: 17fffe55     	b	0x40002be0 <tui_launch+0x78>
40003290: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003294: 912da400     	add	x0, x0, #0xb69
40003298: 94000109     	bl	0x400036bc <uart_puts>
4000329c: a9564ff4     	ldp	x20, x19, [sp, #0x160]
400032a0: a95557f6     	ldp	x22, x21, [sp, #0x150]
400032a4: a9545ff8     	ldp	x24, x23, [sp, #0x140]
400032a8: a95367fa     	ldp	x26, x25, [sp, #0x130]
400032ac: a9526ffc     	ldp	x28, x27, [sp, #0x120]
400032b0: a9517bfd     	ldp	x29, x30, [sp, #0x110]
400032b4: 9105c3ff     	add	sp, sp, #0x170
400032b8: d65f03c0     	ret

00000000400032bc <draw_box>:
400032bc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400032c0: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400032c4: 91138908     	add	x8, x8, #0x4e2
400032c8: 7100007f     	cmp	w3, #0x0
400032cc: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x1000>
400032d0: 9107ad29     	add	x9, x9, #0x1eb
400032d4: a9034ff4     	stp	x20, x19, [sp, #0x30]
400032d8: 2a0003f3     	mov	w19, w0
400032dc: 9a880120     	csel	x0, x9, x8, eq
400032e0: a9015ff8     	stp	x24, x23, [sp, #0x10]
400032e4: a90257f6     	stp	x22, x21, [sp, #0x20]
400032e8: 910003fd     	mov	x29, sp
400032ec: aa0203f4     	mov	x20, x2
400032f0: 2a0103f5     	mov	w21, w1
400032f4: 940000f2     	bl	0x400036bc <uart_puts>
400032f8: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400032fc: 91202800     	add	x0, x0, #0x80a
40003300: 52800041     	mov	w1, #0x2                // =2
40003304: 2a1303e2     	mov	w2, w19
40003308: 940001fd     	bl	0x40003afc <uart_printf>
4000330c: 51000ab6     	sub	w22, w21, #0x2
40003310: 510006b7     	sub	w23, w21, #0x1
40003314: 90000035     	adrp	x21, 0x40007000 <__rodata_start>
40003318: 911572b5     	add	x21, x21, #0x55c
4000331c: 2a1603f8     	mov	w24, w22
40003320: aa1503e0     	mov	x0, x21
40003324: 940000e6     	bl	0x400036bc <uart_puts>
40003328: 71000718     	subs	w24, w24, #0x1
4000332c: 54ffffa1     	b.ne	0x40003320 <draw_box+0x64>
40003330: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003334: 91278400     	add	x0, x0, #0x9e1
40003338: 940000e1     	bl	0x400036bc <uart_puts>
4000333c: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
40003340: 91205800     	add	x0, x0, #0x816
40003344: 11000a62     	add	w2, w19, #0x2
40003348: 52800041     	mov	w1, #0x2                // =2
4000334c: aa1403e3     	mov	x3, x20
40003350: 940001eb     	bl	0x40003afc <uart_printf>
40003354: b0000034     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
40003358: 91148e94     	add	x20, x20, #0x523
4000335c: 52800061     	mov	w1, #0x3                // =3
40003360: aa1403e0     	mov	x0, x20
40003364: 2a1303e2     	mov	w2, w19
40003368: 940001e5     	bl	0x40003afc <uart_printf>
4000336c: 0b1302e2     	add	w2, w23, w19
40003370: aa1403e0     	mov	x0, x20
40003374: 52800061     	mov	w1, #0x3                // =3
40003378: 940001e1     	bl	0x40003afc <uart_printf>
4000337c: aa1403e0     	mov	x0, x20
40003380: 52800081     	mov	w1, #0x4                // =4
40003384: 2a1303e2     	mov	w2, w19
40003388: 940001dd     	bl	0x40003afc <uart_printf>
4000338c: 0b1302e2     	add	w2, w23, w19
40003390: aa1403e0     	mov	x0, x20
40003394: 52800081     	mov	w1, #0x4                // =4
40003398: 940001d9     	bl	0x40003afc <uart_printf>
4000339c: aa1403e0     	mov	x0, x20
400033a0: 528000a1     	mov	w1, #0x5                // =5
400033a4: 2a1303e2     	mov	w2, w19
400033a8: 940001d5     	bl	0x40003afc <uart_printf>
400033ac: 0b1302e2     	add	w2, w23, w19
400033b0: aa1403e0     	mov	x0, x20
400033b4: 528000a1     	mov	w1, #0x5                // =5
400033b8: 940001d1     	bl	0x40003afc <uart_printf>
400033bc: aa1403e0     	mov	x0, x20
400033c0: 528000c1     	mov	w1, #0x6                // =6
400033c4: 2a1303e2     	mov	w2, w19
400033c8: 940001cd     	bl	0x40003afc <uart_printf>
400033cc: 0b1302e2     	add	w2, w23, w19
400033d0: aa1403e0     	mov	x0, x20
400033d4: 528000c1     	mov	w1, #0x6                // =6
400033d8: 940001c9     	bl	0x40003afc <uart_printf>
400033dc: aa1403e0     	mov	x0, x20
400033e0: 528000e1     	mov	w1, #0x7                // =7
400033e4: 2a1303e2     	mov	w2, w19
400033e8: 940001c5     	bl	0x40003afc <uart_printf>
400033ec: 0b1302e2     	add	w2, w23, w19
400033f0: aa1403e0     	mov	x0, x20
400033f4: 528000e1     	mov	w1, #0x7                // =7
400033f8: 940001c1     	bl	0x40003afc <uart_printf>
400033fc: aa1403e0     	mov	x0, x20
40003400: 52800101     	mov	w1, #0x8                // =8
40003404: 2a1303e2     	mov	w2, w19
40003408: 940001bd     	bl	0x40003afc <uart_printf>
4000340c: 0b1302e2     	add	w2, w23, w19
40003410: aa1403e0     	mov	x0, x20
40003414: 52800101     	mov	w1, #0x8                // =8
40003418: 940001b9     	bl	0x40003afc <uart_printf>
4000341c: aa1403e0     	mov	x0, x20
40003420: 52800121     	mov	w1, #0x9                // =9
40003424: 2a1303e2     	mov	w2, w19
40003428: 940001b5     	bl	0x40003afc <uart_printf>
4000342c: 0b1302e2     	add	w2, w23, w19
40003430: aa1403e0     	mov	x0, x20
40003434: 52800121     	mov	w1, #0x9                // =9
40003438: 940001b1     	bl	0x40003afc <uart_printf>
4000343c: aa1403e0     	mov	x0, x20
40003440: 52800141     	mov	w1, #0xa                // =10
40003444: 2a1303e2     	mov	w2, w19
40003448: 940001ad     	bl	0x40003afc <uart_printf>
4000344c: 0b1302e2     	add	w2, w23, w19
40003450: aa1403e0     	mov	x0, x20
40003454: 52800141     	mov	w1, #0xa                // =10
40003458: 940001a9     	bl	0x40003afc <uart_printf>
4000345c: aa1403e0     	mov	x0, x20
40003460: 52800161     	mov	w1, #0xb                // =11
40003464: 2a1303e2     	mov	w2, w19
40003468: 940001a5     	bl	0x40003afc <uart_printf>
4000346c: 0b1302e2     	add	w2, w23, w19
40003470: aa1403e0     	mov	x0, x20
40003474: 52800161     	mov	w1, #0xb                // =11
40003478: 940001a1     	bl	0x40003afc <uart_printf>
4000347c: aa1403e0     	mov	x0, x20
40003480: 52800181     	mov	w1, #0xc                // =12
40003484: 2a1303e2     	mov	w2, w19
40003488: 9400019d     	bl	0x40003afc <uart_printf>
4000348c: 0b1302e2     	add	w2, w23, w19
40003490: aa1403e0     	mov	x0, x20
40003494: 52800181     	mov	w1, #0xc                // =12
40003498: 94000199     	bl	0x40003afc <uart_printf>
4000349c: aa1403e0     	mov	x0, x20
400034a0: 528001a1     	mov	w1, #0xd                // =13
400034a4: 2a1303e2     	mov	w2, w19
400034a8: 94000195     	bl	0x40003afc <uart_printf>
400034ac: 0b1302e2     	add	w2, w23, w19
400034b0: aa1403e0     	mov	x0, x20
400034b4: 528001a1     	mov	w1, #0xd                // =13
400034b8: 94000191     	bl	0x40003afc <uart_printf>
400034bc: aa1403e0     	mov	x0, x20
400034c0: 528001c1     	mov	w1, #0xe                // =14
400034c4: 2a1303e2     	mov	w2, w19
400034c8: 9400018d     	bl	0x40003afc <uart_printf>
400034cc: 0b1302e2     	add	w2, w23, w19
400034d0: aa1403e0     	mov	x0, x20
400034d4: 528001c1     	mov	w1, #0xe                // =14
400034d8: 94000189     	bl	0x40003afc <uart_printf>
400034dc: aa1403e0     	mov	x0, x20
400034e0: 528001e1     	mov	w1, #0xf                // =15
400034e4: 2a1303e2     	mov	w2, w19
400034e8: 94000185     	bl	0x40003afc <uart_printf>
400034ec: 0b1302e2     	add	w2, w23, w19
400034f0: aa1403e0     	mov	x0, x20
400034f4: 528001e1     	mov	w1, #0xf                // =15
400034f8: 94000181     	bl	0x40003afc <uart_printf>
400034fc: aa1403e0     	mov	x0, x20
40003500: 52800201     	mov	w1, #0x10               // =16
40003504: 2a1303e2     	mov	w2, w19
40003508: 9400017d     	bl	0x40003afc <uart_printf>
4000350c: 0b1302e2     	add	w2, w23, w19
40003510: aa1403e0     	mov	x0, x20
40003514: 52800201     	mov	w1, #0x10               // =16
40003518: 94000179     	bl	0x40003afc <uart_printf>
4000351c: aa1403e0     	mov	x0, x20
40003520: 52800221     	mov	w1, #0x11               // =17
40003524: 2a1303e2     	mov	w2, w19
40003528: 94000175     	bl	0x40003afc <uart_printf>
4000352c: 0b1302e2     	add	w2, w23, w19
40003530: aa1403e0     	mov	x0, x20
40003534: 52800221     	mov	w1, #0x11               // =17
40003538: 94000171     	bl	0x40003afc <uart_printf>
4000353c: aa1403e0     	mov	x0, x20
40003540: 52800241     	mov	w1, #0x12               // =18
40003544: 2a1303e2     	mov	w2, w19
40003548: 9400016d     	bl	0x40003afc <uart_printf>
4000354c: 0b1302e2     	add	w2, w23, w19
40003550: aa1403e0     	mov	x0, x20
40003554: 52800241     	mov	w1, #0x12               // =18
40003558: 94000169     	bl	0x40003afc <uart_printf>
4000355c: aa1403e0     	mov	x0, x20
40003560: 52800261     	mov	w1, #0x13               // =19
40003564: 2a1303e2     	mov	w2, w19
40003568: 94000165     	bl	0x40003afc <uart_printf>
4000356c: 0b1302e2     	add	w2, w23, w19
40003570: aa1403e0     	mov	x0, x20
40003574: 52800261     	mov	w1, #0x13               // =19
40003578: 94000161     	bl	0x40003afc <uart_printf>
4000357c: aa1403e0     	mov	x0, x20
40003580: 52800281     	mov	w1, #0x14               // =20
40003584: 2a1303e2     	mov	w2, w19
40003588: 9400015d     	bl	0x40003afc <uart_printf>
4000358c: 0b1302e2     	add	w2, w23, w19
40003590: aa1403e0     	mov	x0, x20
40003594: 52800281     	mov	w1, #0x14               // =20
40003598: 94000159     	bl	0x40003afc <uart_printf>
4000359c: aa1403e0     	mov	x0, x20
400035a0: 528002a1     	mov	w1, #0x15               // =21
400035a4: 2a1303e2     	mov	w2, w19
400035a8: 94000155     	bl	0x40003afc <uart_printf>
400035ac: 0b1302e2     	add	w2, w23, w19
400035b0: aa1403e0     	mov	x0, x20
400035b4: 528002a1     	mov	w1, #0x15               // =21
400035b8: 94000151     	bl	0x40003afc <uart_printf>
400035bc: aa1403e0     	mov	x0, x20
400035c0: 528002c1     	mov	w1, #0x16               // =22
400035c4: 2a1303e2     	mov	w2, w19
400035c8: 9400014d     	bl	0x40003afc <uart_printf>
400035cc: 0b1302e2     	add	w2, w23, w19
400035d0: aa1403e0     	mov	x0, x20
400035d4: 528002c1     	mov	w1, #0x16               // =22
400035d8: 94000149     	bl	0x40003afc <uart_printf>
400035dc: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
400035e0: 91174c00     	add	x0, x0, #0x5d3
400035e4: 528002e1     	mov	w1, #0x17               // =23
400035e8: 2a1303e2     	mov	w2, w19
400035ec: 94000144     	bl	0x40003afc <uart_printf>
400035f0: 90000033     	adrp	x19, 0x40007000 <__rodata_start>
400035f4: 91157273     	add	x19, x19, #0x55c
400035f8: aa1303e0     	mov	x0, x19
400035fc: 94000030     	bl	0x400036bc <uart_puts>
40003600: 710006d6     	subs	w22, w22, #0x1
40003604: 54ffffa1     	b.ne	0x400035f8 <draw_box+0x33c>
40003608: 90000020     	adrp	x0, 0x40007000 <__rodata_start>
4000360c: 91177c00     	add	x0, x0, #0x5df
40003610: 9400002b     	bl	0x400036bc <uart_puts>
40003614: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003618: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000361c: 9129f800     	add	x0, x0, #0xa7e
40003620: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003624: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003628: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000362c: 14000024     	b	0x400036bc <uart_puts>

0000000040003630 <uart_init>:
40003630: 52800608     	mov	w8, #0x30               // =48
40003634: 528001a9     	mov	w9, #0xd                // =13
40003638: 5280002a     	mov	w10, #0x1               // =1
4000363c: 72a12008     	movk	w8, #0x900, lsl #16
40003640: b900011f     	str	wzr, [x8]
40003644: b81f4109     	stur	w9, [x8, #-0xc]
40003648: 52800e09     	mov	w9, #0x70               // =112
4000364c: b81f810a     	stur	w10, [x8, #-0x8]
40003650: b81fc109     	stur	w9, [x8, #-0x4]
40003654: 52806029     	mov	w9, #0x301              // =769
40003658: b9000109     	str	w9, [x8]
4000365c: d65f03c0     	ret

0000000040003660 <uart_putc>:
40003660: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003664: b94b7108     	ldr	w8, [x8, #0xb70]
40003668: 340001a8     	cbz	w8, 0x4000369c <uart_putc+0x3c>
4000366c: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a8>
40003670: 5287ffca     	mov	w10, #0x3ffe            // =16382
40003674: b94b7509     	ldr	w9, [x8, #0xb74]
40003678: 6b0a013f     	cmp	w9, w10
4000367c: 5400010c     	b.gt	0x4000369c <uart_putc+0x3c>
40003680: 93407d29     	sxtw	x9, w9
40003684: d503201f     	nop
40003688: 1006278a     	adr	x10, 0x4000fb78 <kernel_capture_buffer>
4000368c: 9100052b     	add	x11, x9, #0x1
40003690: 38296940     	strb	w0, [x10, x9]
40003694: b90b750b     	str	w11, [x8, #0xb74]
40003698: 382b695f     	strb	wzr, [x10, x11]
4000369c: 52800308     	mov	w8, #0x18               // =24
400036a0: 72a12008     	movk	w8, #0x900, lsl #16
400036a4: b9400109     	ldr	w9, [x8]
400036a8: 372fffe9     	tbnz	w9, #0x5, 0x400036a4 <uart_putc+0x44>
400036ac: 12001c08     	and	w8, w0, #0xff
400036b0: 52a12009     	mov	w9, #0x9000000          // =150994944
400036b4: b9000128     	str	w8, [x9]
400036b8: d65f03c0     	ret

00000000400036bc <uart_puts>:
400036bc: 52800308     	mov	w8, #0x18               // =24
400036c0: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400036c4: 9000006a     	adrp	x10, 0x4000f000 <var_values+0x6a8>
400036c8: 72a12008     	movk	w8, #0x900, lsl #16
400036cc: d503201f     	nop
400036d0: 1006254b     	adr	x11, 0x4000fb78 <kernel_capture_buffer>
400036d4: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400036d8: 528001ad     	mov	w13, #0xd               // =13
400036dc: 52a1200e     	mov	w14, #0x9000000         // =150994944
400036e0: 3940000f     	ldrb	w15, [x0]
400036e4: 710029ff     	cmp	w15, #0xa
400036e8: 540000a0     	b.eq	0x400036fc <uart_puts+0x40>
400036ec: 3400040f     	cbz	w15, 0x4000376c <uart_puts+0xb0>
400036f0: b94b7130     	ldr	w16, [x9, #0xb70]
400036f4: 35000230     	cbnz	w16, 0x40003738 <uart_puts+0x7c>
400036f8: 14000018     	b	0x40003758 <uart_puts+0x9c>
400036fc: b94b712f     	ldr	w15, [x9, #0xb70]
40003700: 3400010f     	cbz	w15, 0x40003720 <uart_puts+0x64>
40003704: b94b754f     	ldr	w15, [x10, #0xb74]
40003708: 6b0c01ff     	cmp	w15, w12
4000370c: 540000ac     	b.gt	0x40003720 <uart_puts+0x64>
40003710: 93407def     	sxtw	x15, w15
40003714: 110005f0     	add	w16, w15, #0x1
40003718: 782f696d     	strh	w13, [x11, x15]
4000371c: b90b7550     	str	w16, [x10, #0xb74]
40003720: b940010f     	ldr	w15, [x8]
40003724: 372fffef     	tbnz	w15, #0x5, 0x40003720 <uart_puts+0x64>
40003728: b90001cd     	str	w13, [x14]
4000372c: 3940000f     	ldrb	w15, [x0]
40003730: b94b7130     	ldr	w16, [x9, #0xb70]
40003734: 34000130     	cbz	w16, 0x40003758 <uart_puts+0x9c>
40003738: b94b7550     	ldr	w16, [x10, #0xb74]
4000373c: 6b0c021f     	cmp	w16, w12
40003740: 540000cc     	b.gt	0x40003758 <uart_puts+0x9c>
40003744: 93407e10     	sxtw	x16, w16
40003748: 91000611     	add	x17, x16, #0x1
4000374c: 3830696f     	strb	w15, [x11, x16]
40003750: b90b7551     	str	w17, [x10, #0xb74]
40003754: 3831697f     	strb	wzr, [x11, x17]
40003758: 91000400     	add	x0, x0, #0x1
4000375c: b9400110     	ldr	w16, [x8]
40003760: 372ffff0     	tbnz	w16, #0x5, 0x4000375c <uart_puts+0xa0>
40003764: b90001cf     	str	w15, [x14]
40003768: 17ffffde     	b	0x400036e0 <uart_puts+0x24>
4000376c: d65f03c0     	ret

0000000040003770 <uart_has_data>:
40003770: 52800308     	mov	w8, #0x18               // =24
40003774: 52800029     	mov	w9, #0x1                // =1
40003778: 72a12008     	movk	w8, #0x900, lsl #16
4000377c: b9400108     	ldr	w8, [x8]
40003780: 0a681120     	bic	w0, w9, w8, lsr #4
40003784: d65f03c0     	ret

0000000040003788 <uart_getc>:
40003788: 52800308     	mov	w8, #0x18               // =24
4000378c: 72a12008     	movk	w8, #0x900, lsl #16
40003790: b9400109     	ldr	w9, [x8]
40003794: 3727ffe9     	tbnz	w9, #0x4, 0x40003790 <uart_getc+0x8>
40003798: 52a12008     	mov	w8, #0x9000000          // =150994944
4000379c: b9400100     	ldr	w0, [x8]
400037a0: d65f03c0     	ret

00000000400037a4 <uart_print_hex_raw>:
400037a4: 52800308     	mov	w8, #0x18               // =24
400037a8: 2a1f03eb     	mov	w11, wzr
400037ac: 5280078c     	mov	w12, #0x3c              // =60
400037b0: 72a12008     	movk	w8, #0x900, lsl #16
400037b4: d503201f     	nop
400037b8: 3001ea0e     	adr	x14, 0x400074f9 <__rodata_start+0x4f9>
400037bc: 9000006d     	adrp	x13, 0x4000f000 <var_values+0x6a8>
400037c0: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
400037c4: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037c8: d503201f     	nop
400037cc: 10061d6a     	adr	x10, 0x4000fb78 <kernel_capture_buffer>
400037d0: 52a12010     	mov	w16, #0x9000000         // =150994944
400037d4: 14000003     	b	0x400037e0 <uart_print_hex_raw+0x3c>
400037d8: b400032c     	cbz	x12, 0x4000383c <uart_print_hex_raw+0x98>
400037dc: d100118c     	sub	x12, x12, #0x4
400037e0: 9acc2411     	lsr	x17, x0, x12
400037e4: 53027d92     	lsr	w18, w12, #2
400037e8: 92400e31     	and	x17, x17, #0xf
400037ec: 6b01025f     	cmp	w18, w1
400037f0: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
400037f4: 1a9f056b     	csinc	w11, w11, wzr, eq
400037f8: 34ffff0b     	cbz	w11, 0x400037d8 <uart_print_hex_raw+0x34>
400037fc: b94b71b2     	ldr	w18, [x13, #0xb70]
40003800: 387169d1     	ldrb	w17, [x14, x17]
40003804: 34000132     	cbz	w18, 0x40003828 <uart_print_hex_raw+0x84>
40003808: b94b7532     	ldr	w18, [x9, #0xb74]
4000380c: 6b0f025f     	cmp	w18, w15
40003810: 540000cc     	b.gt	0x40003828 <uart_print_hex_raw+0x84>
40003814: 93407e52     	sxtw	x18, w18
40003818: 91000642     	add	x2, x18, #0x1
4000381c: 38326951     	strb	w17, [x10, x18]
40003820: b90b7522     	str	w2, [x9, #0xb74]
40003824: 3822695f     	strb	wzr, [x10, x2]
40003828: b9400112     	ldr	w18, [x8]
4000382c: 372ffff2     	tbnz	w18, #0x5, 0x40003828 <uart_print_hex_raw+0x84>
40003830: b9000211     	str	w17, [x16]
40003834: b5fffd4c     	cbnz	x12, 0x400037dc <uart_print_hex_raw+0x38>
40003838: d65f03c0     	ret
4000383c: b94b71ab     	ldr	w11, [x13, #0xb70]
40003840: 3400014b     	cbz	w11, 0x40003868 <uart_print_hex_raw+0xc4>
40003844: b94b752b     	ldr	w11, [x9, #0xb74]
40003848: 5287ffcc     	mov	w12, #0x3ffe            // =16382
4000384c: 6b0c017f     	cmp	w11, w12
40003850: 540000cc     	b.gt	0x40003868 <uart_print_hex_raw+0xc4>
40003854: 93407d6b     	sxtw	x11, w11
40003858: 1100056c     	add	w12, w11, #0x1
4000385c: b90b752c     	str	w12, [x9, #0xb74]
40003860: 52800609     	mov	w9, #0x30               // =48
40003864: 782b6949     	strh	w9, [x10, x11]
40003868: b9400109     	ldr	w9, [x8]
4000386c: 372fffe9     	tbnz	w9, #0x5, 0x40003868 <uart_print_hex_raw+0xc4>
40003870: 52a12008     	mov	w8, #0x9000000          // =150994944
40003874: 52800609     	mov	w9, #0x30               // =48
40003878: b9000109     	str	w9, [x8]
4000387c: d65f03c0     	ret

0000000040003880 <uart_print_hex>:
40003880: 52800308     	mov	w8, #0x18               // =24
40003884: b000002c     	adrp	x12, 0x40008000 <__rodata_start+0x1000>
40003888: 9104598c     	add	x12, x12, #0x116
4000388c: 72a12008     	movk	w8, #0x900, lsl #16
40003890: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003894: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003898: d503201f     	nop
4000389c: 100616ea     	adr	x10, 0x4000fb78 <kernel_capture_buffer>
400038a0: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038a4: 528001ae     	mov	w14, #0xd               // =13
400038a8: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038ac: 39400190     	ldrb	w16, [x12]
400038b0: 71002a1f     	cmp	w16, #0xa
400038b4: 540000a0     	b.eq	0x400038c8 <uart_print_hex+0x48>
400038b8: 340003f0     	cbz	w16, 0x40003934 <uart_print_hex+0xb4>
400038bc: b94b7171     	ldr	w17, [x11, #0xb70]
400038c0: 35000211     	cbnz	w17, 0x40003900 <uart_print_hex+0x80>
400038c4: 14000017     	b	0x40003920 <uart_print_hex+0xa0>
400038c8: b94b7171     	ldr	w17, [x11, #0xb70]
400038cc: 34000111     	cbz	w17, 0x400038ec <uart_print_hex+0x6c>
400038d0: b94b7531     	ldr	w17, [x9, #0xb74]
400038d4: 6b0d023f     	cmp	w17, w13
400038d8: 540000ac     	b.gt	0x400038ec <uart_print_hex+0x6c>
400038dc: 93407e31     	sxtw	x17, w17
400038e0: 11000632     	add	w18, w17, #0x1
400038e4: 7831694e     	strh	w14, [x10, x17]
400038e8: b90b7532     	str	w18, [x9, #0xb74]
400038ec: b9400111     	ldr	w17, [x8]
400038f0: 372ffff1     	tbnz	w17, #0x5, 0x400038ec <uart_print_hex+0x6c>
400038f4: b90001ee     	str	w14, [x15]
400038f8: b94b7171     	ldr	w17, [x11, #0xb70]
400038fc: 34000131     	cbz	w17, 0x40003920 <uart_print_hex+0xa0>
40003900: b94b7531     	ldr	w17, [x9, #0xb74]
40003904: 6b0d023f     	cmp	w17, w13
40003908: 540000cc     	b.gt	0x40003920 <uart_print_hex+0xa0>
4000390c: 93407e31     	sxtw	x17, w17
40003910: 91000632     	add	x18, x17, #0x1
40003914: 38316950     	strb	w16, [x10, x17]
40003918: b90b7532     	str	w18, [x9, #0xb74]
4000391c: 3832695f     	strb	wzr, [x10, x18]
40003920: 9100058c     	add	x12, x12, #0x1
40003924: b9400111     	ldr	w17, [x8]
40003928: 372ffff1     	tbnz	w17, #0x5, 0x40003924 <uart_print_hex+0xa4>
4000392c: b90001f0     	str	w16, [x15]
40003930: 17ffffdf     	b	0x400038ac <uart_print_hex+0x2c>
40003934: 2a1f03ec     	mov	w12, wzr
40003938: d503201f     	nop
4000393c: 3001dded     	adr	x13, 0x400074f9 <__rodata_start+0x4f9>
40003940: 5280078e     	mov	w14, #0x3c              // =60
40003944: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003948: 52a12010     	mov	w16, #0x9000000         // =150994944
4000394c: 14000003     	b	0x40003958 <uart_print_hex+0xd8>
40003950: b40002ee     	cbz	x14, 0x400039ac <uart_print_hex+0x12c>
40003954: d10011ce     	sub	x14, x14, #0x4
40003958: 9ace2411     	lsr	x17, x0, x14
4000395c: f2400e31     	ands	x17, x17, #0xf
40003960: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003964: 1a9f158c     	csinc	w12, w12, wzr, ne
40003968: 34ffff4c     	cbz	w12, 0x40003950 <uart_print_hex+0xd0>
4000396c: b94b7172     	ldr	w18, [x11, #0xb70]
40003970: 387169b1     	ldrb	w17, [x13, x17]
40003974: 34000132     	cbz	w18, 0x40003998 <uart_print_hex+0x118>
40003978: b94b7532     	ldr	w18, [x9, #0xb74]
4000397c: 6b0f025f     	cmp	w18, w15
40003980: 540000cc     	b.gt	0x40003998 <uart_print_hex+0x118>
40003984: 93407e52     	sxtw	x18, w18
40003988: 91000641     	add	x1, x18, #0x1
4000398c: 38326951     	strb	w17, [x10, x18]
40003990: b90b7521     	str	w1, [x9, #0xb74]
40003994: 3821695f     	strb	wzr, [x10, x1]
40003998: b9400112     	ldr	w18, [x8]
4000399c: 372ffff2     	tbnz	w18, #0x5, 0x40003998 <uart_print_hex+0x118>
400039a0: b9000211     	str	w17, [x16]
400039a4: b5fffd8e     	cbnz	x14, 0x40003954 <uart_print_hex+0xd4>
400039a8: d65f03c0     	ret
400039ac: b94b716b     	ldr	w11, [x11, #0xb70]
400039b0: 3400014b     	cbz	w11, 0x400039d8 <uart_print_hex+0x158>
400039b4: b94b752b     	ldr	w11, [x9, #0xb74]
400039b8: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039bc: 6b0c017f     	cmp	w11, w12
400039c0: 540000cc     	b.gt	0x400039d8 <uart_print_hex+0x158>
400039c4: 93407d6b     	sxtw	x11, w11
400039c8: 1100056c     	add	w12, w11, #0x1
400039cc: b90b752c     	str	w12, [x9, #0xb74]
400039d0: 52800609     	mov	w9, #0x30               // =48
400039d4: 782b6949     	strh	w9, [x10, x11]
400039d8: b9400109     	ldr	w9, [x8]
400039dc: 372fffe9     	tbnz	w9, #0x5, 0x400039d8 <uart_print_hex+0x158>
400039e0: 52a12008     	mov	w8, #0x9000000          // =150994944
400039e4: 52800609     	mov	w9, #0x30               // =48
400039e8: b9000109     	str	w9, [x8]
400039ec: d65f03c0     	ret

00000000400039f0 <uart_print_dec>:
400039f0: d10083ff     	sub	sp, sp, #0x20
400039f4: 52800308     	mov	w8, #0x18               // =24
400039f8: 72a12008     	movk	w8, #0x900, lsl #16
400039fc: b4000540     	cbz	x0, 0x40003aa4 <uart_print_dec+0xb4>
40003a00: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003a04: aa1f03e9     	mov	x9, xzr
40003a08: 5280014b     	mov	w11, #0xa               // =10
40003a0c: f29999aa     	movk	x10, #0xcccd
40003a10: 910023ec     	add	x12, sp, #0x8
40003a14: 9bca7c0d     	umulh	x13, x0, x10
40003a18: f100241f     	cmp	x0, #0x9
40003a1c: d343fdad     	lsr	x13, x13, #3
40003a20: 1b0b81ae     	msub	w14, w13, w11, w0
40003a24: aa0d03e0     	mov	x0, x13
40003a28: 321c05ce     	orr	w14, w14, #0x30
40003a2c: 3829698e     	strb	w14, [x12, x9]
40003a30: 91000529     	add	x9, x9, #0x1
40003a34: 54ffff08     	b.hi	0x40003a14 <uart_print_dec+0x24>
40003a38: 910023ea     	add	x10, sp, #0x8
40003a3c: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a8>
40003a40: 9000006c     	adrp	x12, 0x4000f000 <var_values+0x6a8>
40003a44: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a48: d503201f     	nop
40003a4c: 1006096e     	adr	x14, 0x4000fb78 <kernel_capture_buffer>
40003a50: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a54: d1000530     	sub	x16, x9, #0x1
40003a58: b94b7172     	ldr	w18, [x11, #0xb70]
40003a5c: 38706951     	ldrb	w17, [x10, x16]
40003a60: 34000132     	cbz	w18, 0x40003a84 <uart_print_dec+0x94>
40003a64: b94b7592     	ldr	w18, [x12, #0xb74]
40003a68: 6b0d025f     	cmp	w18, w13
40003a6c: 540000cc     	b.gt	0x40003a84 <uart_print_dec+0x94>
40003a70: 93407e52     	sxtw	x18, w18
40003a74: 91000640     	add	x0, x18, #0x1
40003a78: 383269d1     	strb	w17, [x14, x18]
40003a7c: b90b7580     	str	w0, [x12, #0xb74]
40003a80: 382069df     	strb	wzr, [x14, x0]
40003a84: b9400112     	ldr	w18, [x8]
40003a88: 372ffff2     	tbnz	w18, #0x5, 0x40003a84 <uart_print_dec+0x94>
40003a8c: 7100053f     	cmp	w9, #0x1
40003a90: aa1003e9     	mov	x9, x16
40003a94: b90001f1     	str	w17, [x15]
40003a98: 54fffdec     	b.gt	0x40003a54 <uart_print_dec+0x64>
40003a9c: 910083ff     	add	sp, sp, #0x20
40003aa0: d65f03c0     	ret
40003aa4: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003aa8: b94b7129     	ldr	w9, [x9, #0xb70]
40003aac: 340001a9     	cbz	w9, 0x40003ae0 <uart_print_dec+0xf0>
40003ab0: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a8>
40003ab4: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003ab8: b94b752a     	ldr	w10, [x9, #0xb74]
40003abc: 6b0b015f     	cmp	w10, w11
40003ac0: 5400010c     	b.gt	0x40003ae0 <uart_print_dec+0xf0>
40003ac4: 93407d4a     	sxtw	x10, w10
40003ac8: d503201f     	nop
40003acc: 1006056c     	adr	x12, 0x4000fb78 <kernel_capture_buffer>
40003ad0: 1100054b     	add	w11, w10, #0x1
40003ad4: b90b752b     	str	w11, [x9, #0xb74]
40003ad8: 52800609     	mov	w9, #0x30               // =48
40003adc: 782a6989     	strh	w9, [x12, x10]
40003ae0: b9400109     	ldr	w9, [x8]
40003ae4: 372fffe9     	tbnz	w9, #0x5, 0x40003ae0 <uart_print_dec+0xf0>
40003ae8: 52a12008     	mov	w8, #0x9000000          // =150994944
40003aec: 52800609     	mov	w9, #0x30               // =48
40003af0: b9000109     	str	w9, [x8]
40003af4: 910083ff     	add	sp, sp, #0x20
40003af8: d65f03c0     	ret

0000000040003afc <uart_printf>:
40003afc: d10583ff     	sub	sp, sp, #0x160
40003b00: a9107bfd     	stp	x29, x30, [sp, #0x100]
40003b04: 910403fd     	add	x29, sp, #0x100
40003b08: 928006e8     	mov	x8, #-0x38              // =-56
40003b0c: a91457f6     	stp	x22, x21, [sp, #0x140]
40003b10: 52800315     	mov	w21, #0x18              // =24
40003b14: 910003e9     	mov	x9, sp
40003b18: d101e3aa     	sub	x10, x29, #0x78
40003b1c: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003b20: a9116ffc     	stp	x28, x27, [sp, #0x110]
40003b24: a91267fa     	stp	x26, x25, [sp, #0x120]
40003b28: 72a12015     	movk	w21, #0x900, lsl #16
40003b2c: f2dff008     	movk	x8, #0xff80, lsl #32
40003b30: a9135ff8     	stp	x24, x23, [sp, #0x130]
40003b34: 91020129     	add	x9, x9, #0x80
40003b38: 9100e14a     	add	x10, x10, #0x38
40003b3c: a9154ff4     	stp	x20, x19, [sp, #0x150]
40003b40: aa0003f3     	mov	x19, x0
40003b44: aa1f03f4     	mov	x20, xzr
40003b48: 910183ab     	add	x11, x29, #0x60
40003b4c: 90000076     	adrp	x22, 0x4000f000 <var_values+0x6a8>
40003b50: 90000077     	adrp	x23, 0x4000f000 <var_values+0x6a8>
40003b54: d503201f     	nop
40003b58: 10060118     	adr	x24, 0x4000fb78 <kernel_capture_buffer>
40003b5c: 5287ffd9     	mov	w25, #0x3ffe            // =16382
40003b60: 528001ba     	mov	w26, #0xd               // =13
40003b64: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003b68: 528004ae     	mov	w14, #0x25              // =37
40003b6c: f29999af     	movk	x15, #0xcccd
40003b70: 52800150     	mov	w16, #0xa               // =10
40003b74: d10083bc     	sub	x28, x29, #0x20
40003b78: d503201f     	nop
40003b7c: 3001cbf1     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
40003b80: a9388ba1     	stp	x1, x2, [x29, #-0x78]
40003b84: a93993a3     	stp	x3, x4, [x29, #-0x68]
40003b88: a93a9ba5     	stp	x5, x6, [x29, #-0x58]
40003b8c: f81b83a7     	stur	x7, [x29, #-0x48]
40003b90: ad0007e0     	stp	q0, q1, [sp]
40003b94: ad010fe2     	stp	q2, q3, [sp, #0x20]
40003b98: ad0217e4     	stp	q4, q5, [sp, #0x40]
40003b9c: ad031fe6     	stp	q6, q7, [sp, #0x60]
40003ba0: a93d23a9     	stp	x9, x8, [x29, #-0x30]
40003ba4: a93c2bab     	stp	x11, x10, [x29, #-0x40]
40003ba8: 14000004     	b	0x40003bb8 <uart_printf+0xbc>
40003bac: 52800608     	mov	w8, #0x30               // =48
40003bb0: b9000368     	str	w8, [x27]
40003bb4: 91000694     	add	x20, x20, #0x1
40003bb8: 38746a68     	ldrb	w8, [x19, x20]
40003bbc: 7100291f     	cmp	w8, #0xa
40003bc0: 54000440     	b.eq	0x40003c48 <uart_printf+0x14c>
40003bc4: 7100951f     	cmp	w8, #0x25
40003bc8: 540000a0     	b.eq	0x40003bdc <uart_printf+0xe0>
40003bcc: 340039e8     	cbz	w8, 0x40004308 <uart_printf+0x80c>
40003bd0: b94b72c9     	ldr	w9, [x22, #0xb70]
40003bd4: 35000589     	cbnz	w9, 0x40003c84 <uart_printf+0x188>
40003bd8: 14000033     	b	0x40003ca4 <uart_printf+0x1a8>
40003bdc: 9100068a     	add	x10, x20, #0x1
40003be0: 386a6a68     	ldrb	w8, [x19, x10]
40003be4: 7101b11f     	cmp	w8, #0x6c
40003be8: 54000641     	b.ne	0x40003cb0 <uart_printf+0x1b4>
40003bec: 91000a89     	add	x9, x20, #0x2
40003bf0: 91000e8b     	add	x11, x20, #0x3
40003bf4: 38696a6a     	ldrb	w10, [x19, x9]
40003bf8: 7101b15f     	cmp	w10, #0x6c
40003bfc: 9a890174     	csel	x20, x11, x9, eq
40003c00: 38746a69     	ldrb	w9, [x19, x20]
40003c04: 7101bd3f     	cmp	w9, #0x6f
40003c08: 540005cd     	b.le	0x40003cc0 <uart_printf+0x1c4>
40003c0c: 7101d13f     	cmp	w9, #0x74
40003c10: 540007ec     	b.gt	0x40003d0c <uart_printf+0x210>
40003c14: 7101c13f     	cmp	w9, #0x70
40003c18: 54000ea0     	b.eq	0x40003dec <uart_printf+0x2f0>
40003c1c: 7101cd3f     	cmp	w9, #0x73
40003c20: 54000b21     	b.ne	0x40003d84 <uart_printf+0x288>
40003c24: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003c28: 36f813a8     	tbz	w8, #0x1f, 0x40003e9c <uart_printf+0x3a0>
40003c2c: 11002109     	add	w9, w8, #0x8
40003c30: 3100211f     	cmn	w8, #0x8
40003c34: b81d83a9     	stur	w9, [x29, #-0x28]
40003c38: 54001328     	b.hi	0x40003e9c <uart_printf+0x3a0>
40003c3c: f85c83a9     	ldur	x9, [x29, #-0x38]
40003c40: 8b080128     	add	x8, x9, x8
40003c44: 14000099     	b	0x40003ea8 <uart_printf+0x3ac>
40003c48: b94b72c8     	ldr	w8, [x22, #0xb70]
40003c4c: 34000108     	cbz	w8, 0x40003c6c <uart_printf+0x170>
40003c50: b94b76e8     	ldr	w8, [x23, #0xb74]
40003c54: 6b19011f     	cmp	w8, w25
40003c58: 540000ac     	b.gt	0x40003c6c <uart_printf+0x170>
40003c5c: 93407d08     	sxtw	x8, w8
40003c60: 11000509     	add	w9, w8, #0x1
40003c64: 78286b1a     	strh	w26, [x24, x8]
40003c68: b90b76e9     	str	w9, [x23, #0xb74]
40003c6c: b94002a8     	ldr	w8, [x21]
40003c70: 372fffe8     	tbnz	w8, #0x5, 0x40003c6c <uart_printf+0x170>
40003c74: b900037a     	str	w26, [x27]
40003c78: 38746a68     	ldrb	w8, [x19, x20]
40003c7c: b94b72c9     	ldr	w9, [x22, #0xb70]
40003c80: 34000129     	cbz	w9, 0x40003ca4 <uart_printf+0x1a8>
40003c84: b94b76e9     	ldr	w9, [x23, #0xb74]
40003c88: 6b19013f     	cmp	w9, w25
40003c8c: 540000cc     	b.gt	0x40003ca4 <uart_printf+0x1a8>
40003c90: 93407d29     	sxtw	x9, w9
40003c94: 9100052a     	add	x10, x9, #0x1
40003c98: 38296b08     	strb	w8, [x24, x9]
40003c9c: b90b76ea     	str	w10, [x23, #0xb74]
40003ca0: 382a6b1f     	strb	wzr, [x24, x10]
40003ca4: b94002a9     	ldr	w9, [x21]
40003ca8: 372fffe9     	tbnz	w9, #0x5, 0x40003ca4 <uart_printf+0x1a8>
40003cac: 17ffffc1     	b	0x40003bb0 <uart_printf+0xb4>
40003cb0: 2a0803e9     	mov	w9, w8
40003cb4: aa0a03f4     	mov	x20, x10
40003cb8: 7101bd3f     	cmp	w9, #0x6f
40003cbc: 54fffa8c     	b.gt	0x40003c0c <uart_printf+0x110>
40003cc0: 7100953f     	cmp	w9, #0x25
40003cc4: 54000440     	b.eq	0x40003d4c <uart_printf+0x250>
40003cc8: 71018d3f     	cmp	w9, #0x63
40003ccc: 54000bc0     	b.eq	0x40003e44 <uart_printf+0x348>
40003cd0: 7101913f     	cmp	w9, #0x64
40003cd4: 54000581     	b.ne	0x40003d84 <uart_printf+0x288>
40003cd8: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003cdc: 7101b11f     	cmp	w8, #0x6c
40003ce0: 54001761     	b.ne	0x40003fcc <uart_printf+0x4d0>
40003ce4: 36f82349     	tbz	w9, #0x1f, 0x4000414c <uart_printf+0x650>
40003ce8: 11002128     	add	w8, w9, #0x8
40003cec: 3100213f     	cmn	w9, #0x8
40003cf0: b81d83a8     	stur	w8, [x29, #-0x28]
40003cf4: 540022c8     	b.hi	0x4000414c <uart_printf+0x650>
40003cf8: f85c83a8     	ldur	x8, [x29, #-0x38]
40003cfc: 8b090108     	add	x8, x8, x9
40003d00: f9400109     	ldr	x9, [x8]
40003d04: b6f82909     	tbz	x9, #0x3f, 0x40004224 <uart_printf+0x728>
40003d08: 14000116     	b	0x40004160 <uart_printf+0x664>
40003d0c: 7101d53f     	cmp	w9, #0x75
40003d10: 54000800     	b.eq	0x40003e10 <uart_printf+0x314>
40003d14: 7101e13f     	cmp	w9, #0x78
40003d18: 54000361     	b.ne	0x40003d84 <uart_printf+0x288>
40003d1c: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003d20: 7101b11f     	cmp	w8, #0x6c
40003d24: 54001441     	b.ne	0x40003fac <uart_printf+0x4b0>
40003d28: 36f81cc9     	tbz	w9, #0x1f, 0x400040c0 <uart_printf+0x5c4>
40003d2c: 11002128     	add	w8, w9, #0x8
40003d30: 3100213f     	cmn	w9, #0x8
40003d34: b81d83a8     	stur	w8, [x29, #-0x28]
40003d38: 54001c48     	b.hi	0x400040c0 <uart_printf+0x5c4>
40003d3c: f85c83a8     	ldur	x8, [x29, #-0x38]
40003d40: 8b090108     	add	x8, x8, x9
40003d44: f9400108     	ldr	x8, [x8]
40003d48: 140000e7     	b	0x400040e4 <uart_printf+0x5e8>
40003d4c: b94b72c8     	ldr	w8, [x22, #0xb70]
40003d50: 34000108     	cbz	w8, 0x40003d70 <uart_printf+0x274>
40003d54: b94b76e8     	ldr	w8, [x23, #0xb74]
40003d58: 6b19011f     	cmp	w8, w25
40003d5c: 540000ac     	b.gt	0x40003d70 <uart_printf+0x274>
40003d60: 93407d08     	sxtw	x8, w8
40003d64: 11000509     	add	w9, w8, #0x1
40003d68: 78286b0e     	strh	w14, [x24, x8]
40003d6c: b90b76e9     	str	w9, [x23, #0xb74]
40003d70: b94002a8     	ldr	w8, [x21]
40003d74: 372fffe8     	tbnz	w8, #0x5, 0x40003d70 <uart_printf+0x274>
40003d78: b900036e     	str	w14, [x27]
40003d7c: 91000694     	add	x20, x20, #0x1
40003d80: 17ffff8e     	b	0x40003bb8 <uart_printf+0xbc>
40003d84: b94b72c8     	ldr	w8, [x22, #0xb70]
40003d88: 34000108     	cbz	w8, 0x40003da8 <uart_printf+0x2ac>
40003d8c: b94b76e8     	ldr	w8, [x23, #0xb74]
40003d90: 6b19011f     	cmp	w8, w25
40003d94: 540000ac     	b.gt	0x40003da8 <uart_printf+0x2ac>
40003d98: 93407d08     	sxtw	x8, w8
40003d9c: 11000509     	add	w9, w8, #0x1
40003da0: 78286b0e     	strh	w14, [x24, x8]
40003da4: b90b76e9     	str	w9, [x23, #0xb74]
40003da8: b94002a8     	ldr	w8, [x21]
40003dac: 372fffe8     	tbnz	w8, #0x5, 0x40003da8 <uart_printf+0x2ac>
40003db0: b900036e     	str	w14, [x27]
40003db4: b94b72c9     	ldr	w9, [x22, #0xb70]
40003db8: 38746a68     	ldrb	w8, [x19, x20]
40003dbc: 34000129     	cbz	w9, 0x40003de0 <uart_printf+0x2e4>
40003dc0: b94b76e9     	ldr	w9, [x23, #0xb74]
40003dc4: 6b19013f     	cmp	w9, w25
40003dc8: 540000cc     	b.gt	0x40003de0 <uart_printf+0x2e4>
40003dcc: 93407d29     	sxtw	x9, w9
40003dd0: 9100052a     	add	x10, x9, #0x1
40003dd4: 38296b08     	strb	w8, [x24, x9]
40003dd8: b90b76ea     	str	w10, [x23, #0xb74]
40003ddc: 382a6b1f     	strb	wzr, [x24, x10]
40003de0: b94002a9     	ldr	w9, [x21]
40003de4: 372fffe9     	tbnz	w9, #0x5, 0x40003de0 <uart_printf+0x2e4>
40003de8: 17ffff72     	b	0x40003bb0 <uart_printf+0xb4>
40003dec: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003df0: 36f803c8     	tbz	w8, #0x1f, 0x40003e68 <uart_printf+0x36c>
40003df4: 11002109     	add	w9, w8, #0x8
40003df8: 3100211f     	cmn	w8, #0x8
40003dfc: b81d83a9     	stur	w9, [x29, #-0x28]
40003e00: 54000348     	b.hi	0x40003e68 <uart_printf+0x36c>
40003e04: f85c83a9     	ldur	x9, [x29, #-0x38]
40003e08: 8b080128     	add	x8, x9, x8
40003e0c: 1400001a     	b	0x40003e74 <uart_printf+0x378>
40003e10: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003e14: 7101b11f     	cmp	w8, #0x6c
40003e18: 54000ba1     	b.ne	0x40003f8c <uart_printf+0x490>
40003e1c: 36f80e89     	tbz	w9, #0x1f, 0x40003fec <uart_printf+0x4f0>
40003e20: 11002128     	add	w8, w9, #0x8
40003e24: 3100213f     	cmn	w9, #0x8
40003e28: b81d83a8     	stur	w8, [x29, #-0x28]
40003e2c: 54000e08     	b.hi	0x40003fec <uart_printf+0x4f0>
40003e30: f85c83a8     	ldur	x8, [x29, #-0x38]
40003e34: 8b090108     	add	x8, x8, x9
40003e38: f9400109     	ldr	x9, [x8]
40003e3c: b5001069     	cbnz	x9, 0x40004048 <uart_printf+0x54c>
40003e40: 14000070     	b	0x40004000 <uart_printf+0x504>
40003e44: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003e48: 36f80808     	tbz	w8, #0x1f, 0x40003f48 <uart_printf+0x44c>
40003e4c: 11002109     	add	w9, w8, #0x8
40003e50: 3100211f     	cmn	w8, #0x8
40003e54: b81d83a9     	stur	w9, [x29, #-0x28]
40003e58: 54000788     	b.hi	0x40003f48 <uart_printf+0x44c>
40003e5c: f85c83a9     	ldur	x9, [x29, #-0x38]
40003e60: 8b080128     	add	x8, x9, x8
40003e64: 1400003c     	b	0x40003f54 <uart_printf+0x458>
40003e68: f85c03a8     	ldur	x8, [x29, #-0x40]
40003e6c: 91002109     	add	x9, x8, #0x8
40003e70: f81c03a9     	stur	x9, [x29, #-0x40]
40003e74: f9400100     	ldr	x0, [x8]
40003e78: 97fffe82     	bl	0x40003880 <uart_print_hex>
40003e7c: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003e80: 528004ae     	mov	w14, #0x25              // =37
40003e84: 52800150     	mov	w16, #0xa               // =10
40003e88: f29999af     	movk	x15, #0xcccd
40003e8c: d503201f     	nop
40003e90: 3001b351     	adr	x17, 0x400074f9 <__rodata_start+0x4f9>
40003e94: 91000694     	add	x20, x20, #0x1
40003e98: 17ffff48     	b	0x40003bb8 <uart_printf+0xbc>
40003e9c: f85c03a8     	ldur	x8, [x29, #-0x40]
40003ea0: 91002109     	add	x9, x8, #0x8
40003ea4: f81c03a9     	stur	x9, [x29, #-0x40]
40003ea8: f9400108     	ldr	x8, [x8]
40003eac: d0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
40003eb0: 9113a929     	add	x9, x9, #0x4ea
40003eb4: f100011f     	cmp	x8, #0x0
40003eb8: 9a880128     	csel	x8, x9, x8, eq
40003ebc: 39400109     	ldrb	w9, [x8]
40003ec0: 7100293f     	cmp	w9, #0xa
40003ec4: 540000a0     	b.eq	0x40003ed8 <uart_printf+0x3dc>
40003ec8: 34ffe769     	cbz	w9, 0x40003bb4 <uart_printf+0xb8>
40003ecc: b94b72ca     	ldr	w10, [x22, #0xb70]
40003ed0: 3500022a     	cbnz	w10, 0x40003f14 <uart_printf+0x418>
40003ed4: 14000018     	b	0x40003f34 <uart_printf+0x438>
40003ed8: b94b72c9     	ldr	w9, [x22, #0xb70]
40003edc: 34000109     	cbz	w9, 0x40003efc <uart_printf+0x400>
40003ee0: b94b76e9     	ldr	w9, [x23, #0xb74]
40003ee4: 6b19013f     	cmp	w9, w25
40003ee8: 540000ac     	b.gt	0x40003efc <uart_printf+0x400>
40003eec: 93407d29     	sxtw	x9, w9
40003ef0: 1100052a     	add	w10, w9, #0x1
40003ef4: 78296b1a     	strh	w26, [x24, x9]
40003ef8: b90b76ea     	str	w10, [x23, #0xb74]
40003efc: b94002a9     	ldr	w9, [x21]
40003f00: 372fffe9     	tbnz	w9, #0x5, 0x40003efc <uart_printf+0x400>
40003f04: b900037a     	str	w26, [x27]
40003f08: 39400109     	ldrb	w9, [x8]
40003f0c: b94b72ca     	ldr	w10, [x22, #0xb70]
40003f10: 3400012a     	cbz	w10, 0x40003f34 <uart_printf+0x438>
40003f14: b94b76ea     	ldr	w10, [x23, #0xb74]
40003f18: 6b19015f     	cmp	w10, w25
40003f1c: 540000cc     	b.gt	0x40003f34 <uart_printf+0x438>
40003f20: 93407d4a     	sxtw	x10, w10
40003f24: 9100054b     	add	x11, x10, #0x1
40003f28: 382a6b09     	strb	w9, [x24, x10]
40003f2c: b90b76eb     	str	w11, [x23, #0xb74]
40003f30: 382b6b1f     	strb	wzr, [x24, x11]
40003f34: 91000508     	add	x8, x8, #0x1
40003f38: b94002aa     	ldr	w10, [x21]
40003f3c: 372fffea     	tbnz	w10, #0x5, 0x40003f38 <uart_printf+0x43c>
40003f40: b9000369     	str	w9, [x27]
40003f44: 17ffffde     	b	0x40003ebc <uart_printf+0x3c0>
40003f48: f85c03a8     	ldur	x8, [x29, #-0x40]
40003f4c: 91002109     	add	x9, x8, #0x8
40003f50: f81c03a9     	stur	x9, [x29, #-0x40]
40003f54: b94b72c9     	ldr	w9, [x22, #0xb70]
40003f58: 39400108     	ldrb	w8, [x8]
40003f5c: 34000129     	cbz	w9, 0x40003f80 <uart_printf+0x484>
40003f60: b94b76e9     	ldr	w9, [x23, #0xb74]
40003f64: 6b19013f     	cmp	w9, w25
40003f68: 540000cc     	b.gt	0x40003f80 <uart_printf+0x484>
40003f6c: 93407d29     	sxtw	x9, w9
40003f70: 9100052a     	add	x10, x9, #0x1
40003f74: 38296b08     	strb	w8, [x24, x9]
40003f78: b90b76ea     	str	w10, [x23, #0xb74]
40003f7c: 382a6b1f     	strb	wzr, [x24, x10]
40003f80: b94002a9     	ldr	w9, [x21]
40003f84: 372fffe9     	tbnz	w9, #0x5, 0x40003f80 <uart_printf+0x484>
40003f88: 17ffff0a     	b	0x40003bb0 <uart_printf+0xb4>
40003f8c: 36f80549     	tbz	w9, #0x1f, 0x40004034 <uart_printf+0x538>
40003f90: 11002128     	add	w8, w9, #0x8
40003f94: 3100213f     	cmn	w9, #0x8
40003f98: b81d83a8     	stur	w8, [x29, #-0x28]
40003f9c: 540004c8     	b.hi	0x40004034 <uart_printf+0x538>
40003fa0: f85c83a8     	ldur	x8, [x29, #-0x38]
40003fa4: 8b090108     	add	x8, x8, x9
40003fa8: 14000026     	b	0x40004040 <uart_printf+0x544>
40003fac: 36f80949     	tbz	w9, #0x1f, 0x400040d4 <uart_printf+0x5d8>
40003fb0: 11002128     	add	w8, w9, #0x8
40003fb4: 3100213f     	cmn	w9, #0x8
40003fb8: b81d83a8     	stur	w8, [x29, #-0x28]
40003fbc: 540008c8     	b.hi	0x400040d4 <uart_printf+0x5d8>
40003fc0: f85c83a8     	ldur	x8, [x29, #-0x38]
40003fc4: 8b090108     	add	x8, x8, x9
40003fc8: 14000046     	b	0x400040e0 <uart_printf+0x5e4>
40003fcc: 36f81229     	tbz	w9, #0x1f, 0x40004210 <uart_printf+0x714>
40003fd0: 11002128     	add	w8, w9, #0x8
40003fd4: 3100213f     	cmn	w9, #0x8
40003fd8: b81d83a8     	stur	w8, [x29, #-0x28]
40003fdc: 540011a8     	b.hi	0x40004210 <uart_printf+0x714>
40003fe0: f85c83a8     	ldur	x8, [x29, #-0x38]
40003fe4: 8b090108     	add	x8, x8, x9
40003fe8: 1400008d     	b	0x4000421c <uart_printf+0x720>
40003fec: f85c03a8     	ldur	x8, [x29, #-0x40]
40003ff0: 91002109     	add	x9, x8, #0x8
40003ff4: f81c03a9     	stur	x9, [x29, #-0x40]
40003ff8: f9400109     	ldr	x9, [x8]
40003ffc: b5000269     	cbnz	x9, 0x40004048 <uart_printf+0x54c>
40004000: b94b72c8     	ldr	w8, [x22, #0xb70]
40004004: 34000128     	cbz	w8, 0x40004028 <uart_printf+0x52c>
40004008: b94b76e8     	ldr	w8, [x23, #0xb74]
4000400c: 6b19011f     	cmp	w8, w25
40004010: 540000cc     	b.gt	0x40004028 <uart_printf+0x52c>
40004014: 93407d08     	sxtw	x8, w8
40004018: 11000509     	add	w9, w8, #0x1
4000401c: b90b76e9     	str	w9, [x23, #0xb74]
40004020: 52800609     	mov	w9, #0x30               // =48
40004024: 78286b09     	strh	w9, [x24, x8]
40004028: b94002a8     	ldr	w8, [x21]
4000402c: 372fffe8     	tbnz	w8, #0x5, 0x40004028 <uart_printf+0x52c>
40004030: 17fffedf     	b	0x40003bac <uart_printf+0xb0>
40004034: f85c03a8     	ldur	x8, [x29, #-0x40]
40004038: 91002109     	add	x9, x8, #0x8
4000403c: f81c03a9     	stur	x9, [x29, #-0x40]
40004040: b9400109     	ldr	w9, [x8]
40004044: b4fffde9     	cbz	x9, 0x40004000 <uart_printf+0x504>
40004048: aa1f03ea     	mov	x10, xzr
4000404c: 9bcf7d28     	umulh	x8, x9, x15
40004050: f100253f     	cmp	x9, #0x9
40004054: d343fd0b     	lsr	x11, x8, #3
40004058: 91000548     	add	x8, x10, #0x1
4000405c: 1b10a56c     	msub	w12, w11, w16, w9
40004060: 321c0589     	orr	w9, w12, #0x30
40004064: 382a6b89     	strb	w9, [x28, x10]
40004068: aa0803ea     	mov	x10, x8
4000406c: aa0b03e9     	mov	x9, x11
40004070: 54fffee8     	b.hi	0x4000404c <uart_printf+0x550>
40004074: d1000509     	sub	x9, x8, #0x1
40004078: b94b72cb     	ldr	w11, [x22, #0xb70]
4000407c: 38696b8a     	ldrb	w10, [x28, x9]
40004080: 3400012b     	cbz	w11, 0x400040a4 <uart_printf+0x5a8>
40004084: b94b76eb     	ldr	w11, [x23, #0xb74]
40004088: 6b19017f     	cmp	w11, w25
4000408c: 540000cc     	b.gt	0x400040a4 <uart_printf+0x5a8>
40004090: 93407d6b     	sxtw	x11, w11
40004094: 9100056c     	add	x12, x11, #0x1
40004098: 382b6b0a     	strb	w10, [x24, x11]
4000409c: b90b76ec     	str	w12, [x23, #0xb74]
400040a0: 382c6b1f     	strb	wzr, [x24, x12]
400040a4: b94002ab     	ldr	w11, [x21]
400040a8: 372fffeb     	tbnz	w11, #0x5, 0x400040a4 <uart_printf+0x5a8>
400040ac: 7100051f     	cmp	w8, #0x1
400040b0: aa0903e8     	mov	x8, x9
400040b4: b900036a     	str	w10, [x27]
400040b8: 54fffdec     	b.gt	0x40004074 <uart_printf+0x578>
400040bc: 17fffebe     	b	0x40003bb4 <uart_printf+0xb8>
400040c0: f85c03a8     	ldur	x8, [x29, #-0x40]
400040c4: 91002109     	add	x9, x8, #0x8
400040c8: f81c03a9     	stur	x9, [x29, #-0x40]
400040cc: f9400108     	ldr	x8, [x8]
400040d0: 14000005     	b	0x400040e4 <uart_printf+0x5e8>
400040d4: f85c03a8     	ldur	x8, [x29, #-0x40]
400040d8: 91002109     	add	x9, x8, #0x8
400040dc: f81c03a9     	stur	x9, [x29, #-0x40]
400040e0: b9400108     	ldr	w8, [x8]
400040e4: 2a1f03e9     	mov	w9, wzr
400040e8: 5280078a     	mov	w10, #0x3c              // =60
400040ec: 14000003     	b	0x400040f8 <uart_printf+0x5fc>
400040f0: b4000d8a     	cbz	x10, 0x400042a0 <uart_printf+0x7a4>
400040f4: d100114a     	sub	x10, x10, #0x4
400040f8: 9aca250b     	lsr	x11, x8, x10
400040fc: f2400d6b     	ands	x11, x11, #0xf
40004100: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004104: 1a9f1529     	csinc	w9, w9, wzr, ne
40004108: 34ffff49     	cbz	w9, 0x400040f0 <uart_printf+0x5f4>
4000410c: b94b72cc     	ldr	w12, [x22, #0xb70]
40004110: 386b6a2b     	ldrb	w11, [x17, x11]
40004114: 3400012c     	cbz	w12, 0x40004138 <uart_printf+0x63c>
40004118: b94b76ec     	ldr	w12, [x23, #0xb74]
4000411c: 6b19019f     	cmp	w12, w25
40004120: 540000cc     	b.gt	0x40004138 <uart_printf+0x63c>
40004124: 93407d8c     	sxtw	x12, w12
40004128: 9100058d     	add	x13, x12, #0x1
4000412c: 382c6b0b     	strb	w11, [x24, x12]
40004130: b90b76ed     	str	w13, [x23, #0xb74]
40004134: 382d6b1f     	strb	wzr, [x24, x13]
40004138: b94002ac     	ldr	w12, [x21]
4000413c: 372fffec     	tbnz	w12, #0x5, 0x40004138 <uart_printf+0x63c>
40004140: b900036b     	str	w11, [x27]
40004144: b5fffd8a     	cbnz	x10, 0x400040f4 <uart_printf+0x5f8>
40004148: 17fffe9b     	b	0x40003bb4 <uart_printf+0xb8>
4000414c: f85c03a8     	ldur	x8, [x29, #-0x40]
40004150: 91002109     	add	x9, x8, #0x8
40004154: f81c03a9     	stur	x9, [x29, #-0x40]
40004158: f9400109     	ldr	x9, [x8]
4000415c: b6f80649     	tbz	x9, #0x3f, 0x40004224 <uart_printf+0x728>
40004160: b94b72c8     	ldr	w8, [x22, #0xb70]
40004164: 34000128     	cbz	w8, 0x40004188 <uart_printf+0x68c>
40004168: b94b76e8     	ldr	w8, [x23, #0xb74]
4000416c: 6b19011f     	cmp	w8, w25
40004170: 540000cc     	b.gt	0x40004188 <uart_printf+0x68c>
40004174: 93407d08     	sxtw	x8, w8
40004178: 1100050a     	add	w10, w8, #0x1
4000417c: b90b76ea     	str	w10, [x23, #0xb74]
40004180: 528005aa     	mov	w10, #0x2d              // =45
40004184: 78286b0a     	strh	w10, [x24, x8]
40004188: b94002a8     	ldr	w8, [x21]
4000418c: 372fffe8     	tbnz	w8, #0x5, 0x40004188 <uart_printf+0x68c>
40004190: aa1f03e8     	mov	x8, xzr
40004194: 528005aa     	mov	w10, #0x2d              // =45
40004198: cb0903e9     	neg	x9, x9
4000419c: b900036a     	str	w10, [x27]
400041a0: 9bcf7d2a     	umulh	x10, x9, x15
400041a4: f100253f     	cmp	x9, #0x9
400041a8: d343fd4a     	lsr	x10, x10, #3
400041ac: 1b10a54b     	msub	w11, w10, w16, w9
400041b0: 321c0569     	orr	w9, w11, #0x30
400041b4: 38286b89     	strb	w9, [x28, x8]
400041b8: 91000508     	add	x8, x8, #0x1
400041bc: aa0a03e9     	mov	x9, x10
400041c0: 54ffff08     	b.hi	0x400041a0 <uart_printf+0x6a4>
400041c4: d1000509     	sub	x9, x8, #0x1
400041c8: b94b72cb     	ldr	w11, [x22, #0xb70]
400041cc: 38696b8a     	ldrb	w10, [x28, x9]
400041d0: 3400012b     	cbz	w11, 0x400041f4 <uart_printf+0x6f8>
400041d4: b94b76eb     	ldr	w11, [x23, #0xb74]
400041d8: 6b19017f     	cmp	w11, w25
400041dc: 540000cc     	b.gt	0x400041f4 <uart_printf+0x6f8>
400041e0: 93407d6b     	sxtw	x11, w11
400041e4: 9100056c     	add	x12, x11, #0x1
400041e8: 382b6b0a     	strb	w10, [x24, x11]
400041ec: b90b76ec     	str	w12, [x23, #0xb74]
400041f0: 382c6b1f     	strb	wzr, [x24, x12]
400041f4: b94002ab     	ldr	w11, [x21]
400041f8: 372fffeb     	tbnz	w11, #0x5, 0x400041f4 <uart_printf+0x6f8>
400041fc: 7100051f     	cmp	w8, #0x1
40004200: aa0903e8     	mov	x8, x9
40004204: b900036a     	str	w10, [x27]
40004208: 54fffdec     	b.gt	0x400041c4 <uart_printf+0x6c8>
4000420c: 17fffe6a     	b	0x40003bb4 <uart_printf+0xb8>
40004210: f85c03a8     	ldur	x8, [x29, #-0x40]
40004214: 91002109     	add	x9, x8, #0x8
40004218: f81c03a9     	stur	x9, [x29, #-0x40]
4000421c: b9800109     	ldrsw	x9, [x8]
40004220: b7fffa09     	tbnz	x9, #0x3f, 0x40004160 <uart_printf+0x664>
40004224: b4000589     	cbz	x9, 0x400042d4 <uart_printf+0x7d8>
40004228: aa1f03ea     	mov	x10, xzr
4000422c: 9bcf7d28     	umulh	x8, x9, x15
40004230: f100253f     	cmp	x9, #0x9
40004234: d343fd0b     	lsr	x11, x8, #3
40004238: 91000548     	add	x8, x10, #0x1
4000423c: 1b10a56c     	msub	w12, w11, w16, w9
40004240: 321c0589     	orr	w9, w12, #0x30
40004244: 382a6b89     	strb	w9, [x28, x10]
40004248: aa0803ea     	mov	x10, x8
4000424c: aa0b03e9     	mov	x9, x11
40004250: 54fffee8     	b.hi	0x4000422c <uart_printf+0x730>
40004254: d1000509     	sub	x9, x8, #0x1
40004258: b94b72cb     	ldr	w11, [x22, #0xb70]
4000425c: 38696b8a     	ldrb	w10, [x28, x9]
40004260: 3400012b     	cbz	w11, 0x40004284 <uart_printf+0x788>
40004264: b94b76eb     	ldr	w11, [x23, #0xb74]
40004268: 6b19017f     	cmp	w11, w25
4000426c: 540000cc     	b.gt	0x40004284 <uart_printf+0x788>
40004270: 93407d6b     	sxtw	x11, w11
40004274: 9100056c     	add	x12, x11, #0x1
40004278: 382b6b0a     	strb	w10, [x24, x11]
4000427c: b90b76ec     	str	w12, [x23, #0xb74]
40004280: 382c6b1f     	strb	wzr, [x24, x12]
40004284: b94002ab     	ldr	w11, [x21]
40004288: 372fffeb     	tbnz	w11, #0x5, 0x40004284 <uart_printf+0x788>
4000428c: 7100051f     	cmp	w8, #0x1
40004290: aa0903e8     	mov	x8, x9
40004294: b900036a     	str	w10, [x27]
40004298: 54fffdec     	b.gt	0x40004254 <uart_printf+0x758>
4000429c: 17fffe46     	b	0x40003bb4 <uart_printf+0xb8>
400042a0: b94b72c8     	ldr	w8, [x22, #0xb70]
400042a4: 34000128     	cbz	w8, 0x400042c8 <uart_printf+0x7cc>
400042a8: b94b76e8     	ldr	w8, [x23, #0xb74]
400042ac: 6b19011f     	cmp	w8, w25
400042b0: 540000cc     	b.gt	0x400042c8 <uart_printf+0x7cc>
400042b4: 93407d08     	sxtw	x8, w8
400042b8: 11000509     	add	w9, w8, #0x1
400042bc: b90b76e9     	str	w9, [x23, #0xb74]
400042c0: 52800609     	mov	w9, #0x30               // =48
400042c4: 78286b09     	strh	w9, [x24, x8]
400042c8: b94002a8     	ldr	w8, [x21]
400042cc: 372fffe8     	tbnz	w8, #0x5, 0x400042c8 <uart_printf+0x7cc>
400042d0: 17fffe37     	b	0x40003bac <uart_printf+0xb0>
400042d4: b94b72c8     	ldr	w8, [x22, #0xb70]
400042d8: 34000128     	cbz	w8, 0x400042fc <uart_printf+0x800>
400042dc: b94b76e8     	ldr	w8, [x23, #0xb74]
400042e0: 6b19011f     	cmp	w8, w25
400042e4: 540000cc     	b.gt	0x400042fc <uart_printf+0x800>
400042e8: 93407d08     	sxtw	x8, w8
400042ec: 11000509     	add	w9, w8, #0x1
400042f0: b90b76e9     	str	w9, [x23, #0xb74]
400042f4: 52800609     	mov	w9, #0x30               // =48
400042f8: 78286b09     	strh	w9, [x24, x8]
400042fc: b94002a8     	ldr	w8, [x21]
40004300: 372fffe8     	tbnz	w8, #0x5, 0x400042fc <uart_printf+0x800>
40004304: 17fffe2a     	b	0x40003bac <uart_printf+0xb0>
40004308: a9554ff4     	ldp	x20, x19, [sp, #0x150]
4000430c: a95457f6     	ldp	x22, x21, [sp, #0x140]
40004310: a9535ff8     	ldp	x24, x23, [sp, #0x130]
40004314: a95267fa     	ldp	x26, x25, [sp, #0x120]
40004318: a9516ffc     	ldp	x28, x27, [sp, #0x110]
4000431c: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40004320: 910583ff     	add	sp, sp, #0x160
40004324: d65f03c0     	ret

0000000040004328 <vfs_init>:
40004328: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
4000432c: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004330: f0000073     	adrp	x19, 0x40013000 <kernel_capture_buffer+0x3488>
40004334: 912e4273     	add	x19, x19, #0xb90
40004338: f9000bf9     	str	x25, [sp, #0x10]
4000433c: f0000079     	adrp	x25, 0x40013000 <kernel_capture_buffer+0x3488>
40004340: 52800034     	mov	w20, #0x1               // =1
40004344: aa1303e0     	mov	x0, x19
40004348: 2a1f03e1     	mov	w1, wzr
4000434c: 52809802     	mov	w2, #0x4c0              // =1216
40004350: a9025ff8     	stp	x24, x23, [sp, #0x20]
40004354: 910003fd     	mov	x29, sp
40004358: a90357f6     	stp	x22, x21, [sp, #0x30]
4000435c: b90b7b34     	str	w20, [x25, #0xb78]
40004360: 97fff96c     	bl	0x40002910 <memset>
40004364: 528005e8     	mov	w8, #0x2f               // =47
40004368: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
4000436c: b9002274     	str	w20, [x19, #0x20]
40004370: 79000268     	strh	w8, [x19]
40004374: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004378: f905c133     	str	x19, [x9, #0xb80]
4000437c: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
40004380: 7101fd1f     	cmp	w8, #0x7f
40004384: f9021a7f     	str	xzr, [x19, #0x430]
40004388: f900167f     	str	xzr, [x19, #0x28]
4000438c: b904ba7f     	str	wzr, [x19, #0x4b8]
40004390: f905c533     	str	x19, [x9, #0xb88]
40004394: 540027ac     	b.gt	0x40004888 <vfs_init+0x560>
40004398: 52809809     	mov	w9, #0x4c0              // =1216
4000439c: 2a1f03e1     	mov	w1, wzr
400043a0: 52809802     	mov	w2, #0x4c0              // =1216
400043a4: 9b294d17     	smaddl	x23, w8, w9, x19
400043a8: 11000508     	add	w8, w8, #0x1
400043ac: b90b7b28     	str	w8, [x25, #0xb78]
400043b0: aa1703e0     	mov	x0, x23
400043b4: 97fff957     	bl	0x40002910 <memset>
400043b8: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400043bc: b904baff     	str	wzr, [x23, #0x4b8]
400043c0: fd42a900     	ldr	d0, [x8, #0x550]
400043c4: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400043c8: b90022f4     	str	w20, [x23, #0x20]
400043cc: f9021af3     	str	x19, [x23, #0x430]
400043d0: 71003d1f     	cmp	w8, #0xf
400043d4: bd0002e0     	str	s0, [x23]
400043d8: f90016ff     	str	xzr, [x23, #0x28]
400043dc: 540000ac     	b.gt	0x400043f0 <vfs_init+0xc8>
400043e0: 11000509     	add	w9, w8, #0x1
400043e4: 8b080e68     	add	x8, x19, x8, lsl #3
400043e8: b904ba69     	str	w9, [x19, #0x4b8]
400043ec: f9021d17     	str	x23, [x8, #0x438]
400043f0: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400043f4: 7101fd1f     	cmp	w8, #0x7f
400043f8: 5400248c     	b.gt	0x40004888 <vfs_init+0x560>
400043fc: 52809809     	mov	w9, #0x4c0              // =1216
40004400: 2a1f03e1     	mov	w1, wzr
40004404: 52809802     	mov	w2, #0x4c0              // =1216
40004408: 9b294d16     	smaddl	x22, w8, w9, x19
4000440c: 11000508     	add	w8, w8, #0x1
40004410: b90b7b28     	str	w8, [x25, #0xb78]
40004414: aa1603e0     	mov	x0, x22
40004418: 97fff93e     	bl	0x40002910 <memset>
4000441c: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004420: b904badf     	str	wzr, [x22, #0x4b8]
40004424: 52800029     	mov	w9, #0x1                // =1
40004428: fd42b500     	ldr	d0, [x8, #0x568]
4000442c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004430: b90022c9     	str	w9, [x22, #0x20]
40004434: f9021ad3     	str	x19, [x22, #0x430]
40004438: 71003d1f     	cmp	w8, #0xf
4000443c: bd0002c0     	str	s0, [x22]
40004440: f90016df     	str	xzr, [x22, #0x28]
40004444: 540000ac     	b.gt	0x40004458 <vfs_init+0x130>
40004448: 11000509     	add	w9, w8, #0x1
4000444c: 8b080e68     	add	x8, x19, x8, lsl #3
40004450: b904ba69     	str	w9, [x19, #0x4b8]
40004454: f9021d16     	str	x22, [x8, #0x438]
40004458: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000445c: 7101fd1f     	cmp	w8, #0x7f
40004460: 5400214c     	b.gt	0x40004888 <vfs_init+0x560>
40004464: 52809809     	mov	w9, #0x4c0              // =1216
40004468: 2a1f03e1     	mov	w1, wzr
4000446c: 52809802     	mov	w2, #0x4c0              // =1216
40004470: 9b294d14     	smaddl	x20, w8, w9, x19
40004474: 11000508     	add	w8, w8, #0x1
40004478: b90b7b28     	str	w8, [x25, #0xb78]
4000447c: aa1403e0     	mov	x0, x20
40004480: 97fff924     	bl	0x40002910 <memset>
40004484: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004488: b904ba9f     	str	wzr, [x20, #0x4b8]
4000448c: 52800029     	mov	w9, #0x1                // =1
40004490: fd42ad00     	ldr	d0, [x8, #0x558]
40004494: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004498: 3900129f     	strb	wzr, [x20, #0x4]
4000449c: b9002289     	str	w9, [x20, #0x20]
400044a0: 71003d1f     	cmp	w8, #0xf
400044a4: bd000280     	str	s0, [x20]
400044a8: f9021a93     	str	x19, [x20, #0x430]
400044ac: f900169f     	str	xzr, [x20, #0x28]
400044b0: 540000ac     	b.gt	0x400044c4 <vfs_init+0x19c>
400044b4: 11000509     	add	w9, w8, #0x1
400044b8: 8b080e68     	add	x8, x19, x8, lsl #3
400044bc: b904ba69     	str	w9, [x19, #0x4b8]
400044c0: f9021d14     	str	x20, [x8, #0x438]
400044c4: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400044c8: 7101fd1f     	cmp	w8, #0x7f
400044cc: 54001dec     	b.gt	0x40004888 <vfs_init+0x560>
400044d0: 52809809     	mov	w9, #0x4c0              // =1216
400044d4: 2a1f03e1     	mov	w1, wzr
400044d8: 52809802     	mov	w2, #0x4c0              // =1216
400044dc: 9b294d15     	smaddl	x21, w8, w9, x19
400044e0: 11000508     	add	w8, w8, #0x1
400044e4: b90b7b28     	str	w8, [x25, #0xb78]
400044e8: aa1503e0     	mov	x0, x21
400044ec: 97fff909     	bl	0x40002910 <memset>
400044f0: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400044f4: b904babf     	str	wzr, [x21, #0x4b8]
400044f8: 52800029     	mov	w9, #0x1                // =1
400044fc: fd42a500     	ldr	d0, [x8, #0x548]
40004500: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004504: 390012bf     	strb	wzr, [x21, #0x4]
40004508: b90022a9     	str	w9, [x21, #0x20]
4000450c: 71003d1f     	cmp	w8, #0xf
40004510: bd0002a0     	str	s0, [x21]
40004514: f9021ab3     	str	x19, [x21, #0x430]
40004518: f90016bf     	str	xzr, [x21, #0x28]
4000451c: 540000ac     	b.gt	0x40004530 <vfs_init+0x208>
40004520: 11000509     	add	w9, w8, #0x1
40004524: 8b080e68     	add	x8, x19, x8, lsl #3
40004528: b904ba69     	str	w9, [x19, #0x4b8]
4000452c: f9021d15     	str	x21, [x8, #0x438]
40004530: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004534: 7101fd1f     	cmp	w8, #0x7f
40004538: 54001a8c     	b.gt	0x40004888 <vfs_init+0x560>
4000453c: 52809809     	mov	w9, #0x4c0              // =1216
40004540: 2a1f03e1     	mov	w1, wzr
40004544: 52809802     	mov	w2, #0x4c0              // =1216
40004548: 9b294d18     	smaddl	x24, w8, w9, x19
4000454c: 11000508     	add	w8, w8, #0x1
40004550: b90b7b28     	str	w8, [x25, #0xb78]
40004554: aa1803e0     	mov	x0, x24
40004558: 97fff8ee     	bl	0x40002910 <memset>
4000455c: 528d2c28     	mov	w8, #0x6961             // =26977
40004560: b904bb1f     	str	wzr, [x24, #0x4b8]
40004564: 79000308     	strh	w8, [x24]
40004568: b984bae8     	ldrsw	x8, [x23, #0x4b8]
4000456c: 39000b1f     	strb	wzr, [x24, #0x2]
40004570: 71003d1f     	cmp	w8, #0xf
40004574: b900231f     	str	wzr, [x24, #0x20]
40004578: f9021b17     	str	x23, [x24, #0x430]
4000457c: f900171f     	str	xzr, [x24, #0x28]
40004580: 540000ac     	b.gt	0x40004594 <vfs_init+0x26c>
40004584: 8b080ee9     	add	x9, x23, x8, lsl #3
40004588: 11000508     	add	w8, w8, #0x1
4000458c: b904bae8     	str	w8, [x23, #0x4b8]
40004590: f9021d38     	str	x24, [x9, #0x438]
40004594: d503201f     	nop
40004598: 50027177     	adr	x23, 0x400093c6 <__rodata_start+0x23c6>
4000459c: 9100c300     	add	x0, x24, #0x30
400045a0: aa1703e1     	mov	x1, x23
400045a4: 97fff8a0     	bl	0x40002824 <kstrcpy>
400045a8: aa1703e0     	mov	x0, x23
400045ac: 97fff86f     	bl	0x40002768 <kstrlen>
400045b0: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400045b4: f9001700     	str	x0, [x24, #0x28]
400045b8: 7101fd1f     	cmp	w8, #0x7f
400045bc: 5400166c     	b.gt	0x40004888 <vfs_init+0x560>
400045c0: 52809809     	mov	w9, #0x4c0              // =1216
400045c4: 2a1f03e1     	mov	w1, wzr
400045c8: 52809802     	mov	w2, #0x4c0              // =1216
400045cc: 9b294d17     	smaddl	x23, w8, w9, x19
400045d0: 11000508     	add	w8, w8, #0x1
400045d4: b90b7b28     	str	w8, [x25, #0xb78]
400045d8: aa1703e0     	mov	x0, x23
400045dc: 97fff8cd     	bl	0x40002910 <memset>
400045e0: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
400045e4: b904baff     	str	wzr, [x23, #0x4b8]
400045e8: 528cae69     	mov	w9, #0x6573             // =25971
400045ec: fd428100     	ldr	d0, [x8, #0x500]
400045f0: b984bac8     	ldrsw	x8, [x22, #0x4b8]
400045f4: 39002aff     	strb	wzr, [x23, #0xa]
400045f8: 790012e9     	strh	w9, [x23, #0x8]
400045fc: 71003d1f     	cmp	w8, #0xf
40004600: fd0002e0     	str	d0, [x23]
40004604: b90022ff     	str	wzr, [x23, #0x20]
40004608: f9021af6     	str	x22, [x23, #0x430]
4000460c: f90016ff     	str	xzr, [x23, #0x28]
40004610: 540000ac     	b.gt	0x40004624 <vfs_init+0x2fc>
40004614: 8b080ec9     	add	x9, x22, x8, lsl #3
40004618: 11000508     	add	w8, w8, #0x1
4000461c: b904bac8     	str	w8, [x22, #0x4b8]
40004620: f9021d37     	str	x23, [x9, #0x438]
40004624: f0000016     	adrp	x22, 0x40007000 <__rodata_start>
40004628: 91374ad6     	add	x22, x22, #0xdd2
4000462c: 9100c2e0     	add	x0, x23, #0x30
40004630: aa1603e1     	mov	x1, x22
40004634: 97fff87c     	bl	0x40002824 <kstrcpy>
40004638: aa1603e0     	mov	x0, x22
4000463c: 97fff84b     	bl	0x40002768 <kstrlen>
40004640: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004644: f90016e0     	str	x0, [x23, #0x28]
40004648: 7101fd1f     	cmp	w8, #0x7f
4000464c: 540011ec     	b.gt	0x40004888 <vfs_init+0x560>
40004650: 52809809     	mov	w9, #0x4c0              // =1216
40004654: 2a1f03e1     	mov	w1, wzr
40004658: 52809802     	mov	w2, #0x4c0              // =1216
4000465c: 9b294d16     	smaddl	x22, w8, w9, x19
40004660: 11000508     	add	w8, w8, #0x1
40004664: b90b7b28     	str	w8, [x25, #0xb78]
40004668: aa1603e0     	mov	x0, x22
4000466c: 97fff8a9     	bl	0x40002910 <memset>
40004670: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004674: b904badf     	str	wzr, [x22, #0x4b8]
40004678: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
4000467c: fd429d00     	ldr	d0, [x8, #0x538]
40004680: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004684: fd429521     	ldr	d1, [x9, #0x528]
40004688: b90022df     	str	wzr, [x22, #0x20]
4000468c: 71003d1f     	cmp	w8, #0xf
40004690: fd0002c0     	str	d0, [x22]
40004694: bd000ac1     	str	s1, [x22, #0x8]
40004698: f9021ad5     	str	x21, [x22, #0x430]
4000469c: f90016df     	str	xzr, [x22, #0x28]
400046a0: 540000ac     	b.gt	0x400046b4 <vfs_init+0x38c>
400046a4: 8b080ea9     	add	x9, x21, x8, lsl #3
400046a8: 11000508     	add	w8, w8, #0x1
400046ac: b904baa8     	str	w8, [x21, #0x4b8]
400046b0: f9021d36     	str	x22, [x9, #0x438]
400046b4: f0000017     	adrp	x23, 0x40007000 <__rodata_start>
400046b8: 913ceaf7     	add	x23, x23, #0xf3a
400046bc: 9100c2c0     	add	x0, x22, #0x30
400046c0: aa1703e1     	mov	x1, x23
400046c4: 97fff858     	bl	0x40002824 <kstrcpy>
400046c8: aa1703e0     	mov	x0, x23
400046cc: 97fff827     	bl	0x40002768 <kstrlen>
400046d0: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400046d4: f90016c0     	str	x0, [x22, #0x28]
400046d8: 7101fd1f     	cmp	w8, #0x7f
400046dc: 54000d6c     	b.gt	0x40004888 <vfs_init+0x560>
400046e0: 52809809     	mov	w9, #0x4c0              // =1216
400046e4: 2a1f03e1     	mov	w1, wzr
400046e8: 52809802     	mov	w2, #0x4c0              // =1216
400046ec: 9b294d16     	smaddl	x22, w8, w9, x19
400046f0: 11000508     	add	w8, w8, #0x1
400046f4: b90b7b28     	str	w8, [x25, #0xb78]
400046f8: aa1603e0     	mov	x0, x22
400046fc: 97fff885     	bl	0x40002910 <memset>
40004700: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004704: b904badf     	str	wzr, [x22, #0x4b8]
40004708: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x2000>
4000470c: fd428500     	ldr	d0, [x8, #0x508]
40004710: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004714: fd428921     	ldr	d1, [x9, #0x510]
40004718: 390032df     	strb	wzr, [x22, #0xc]
4000471c: 71003d1f     	cmp	w8, #0xf
40004720: fd0002c0     	str	d0, [x22]
40004724: bd000ac1     	str	s1, [x22, #0x8]
40004728: b90022df     	str	wzr, [x22, #0x20]
4000472c: f9021ad5     	str	x21, [x22, #0x430]
40004730: f90016df     	str	xzr, [x22, #0x28]
40004734: 540000ac     	b.gt	0x40004748 <vfs_init+0x420>
40004738: 8b080ea9     	add	x9, x21, x8, lsl #3
4000473c: 11000508     	add	w8, w8, #0x1
40004740: b904baa8     	str	w8, [x21, #0x4b8]
40004744: f9021d36     	str	x22, [x9, #0x438]
40004748: 90000037     	adrp	x23, 0x40008000 <__rodata_start+0x1000>
4000474c: 910ae2f7     	add	x23, x23, #0x2b8
40004750: 9100c2c0     	add	x0, x22, #0x30
40004754: aa1703e1     	mov	x1, x23
40004758: 97fff833     	bl	0x40002824 <kstrcpy>
4000475c: aa1703e0     	mov	x0, x23
40004760: 97fff802     	bl	0x40002768 <kstrlen>
40004764: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004768: f90016c0     	str	x0, [x22, #0x28]
4000476c: 7101fd1f     	cmp	w8, #0x7f
40004770: 540008cc     	b.gt	0x40004888 <vfs_init+0x560>
40004774: 52809809     	mov	w9, #0x4c0              // =1216
40004778: 2a1f03e1     	mov	w1, wzr
4000477c: 52809802     	mov	w2, #0x4c0              // =1216
40004780: 9b294d16     	smaddl	x22, w8, w9, x19
40004784: 11000508     	add	w8, w8, #0x1
40004788: b90b7b28     	str	w8, [x25, #0xb78]
4000478c: aa1603e0     	mov	x0, x22
40004790: 97fff860     	bl	0x40002910 <memset>
40004794: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004798: b904badf     	str	wzr, [x22, #0x4b8]
4000479c: 528e8f09     	mov	w9, #0x7478             // =29816
400047a0: fd429100     	ldr	d0, [x8, #0x520]
400047a4: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400047a8: 39001adf     	strb	wzr, [x22, #0x6]
400047ac: 79000ac9     	strh	w9, [x22, #0x4]
400047b0: 71003d1f     	cmp	w8, #0xf
400047b4: bd0002c0     	str	s0, [x22]
400047b8: b90022df     	str	wzr, [x22, #0x20]
400047bc: f9021ad5     	str	x21, [x22, #0x430]
400047c0: f90016df     	str	xzr, [x22, #0x28]
400047c4: 540000ac     	b.gt	0x400047d8 <vfs_init+0x4b0>
400047c8: 8b080ea9     	add	x9, x21, x8, lsl #3
400047cc: 11000508     	add	w8, w8, #0x1
400047d0: b904baa8     	str	w8, [x21, #0x4b8]
400047d4: f9021d36     	str	x22, [x9, #0x438]
400047d8: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x2000>
400047dc: 9105a6b5     	add	x21, x21, #0x169
400047e0: 9100c2c0     	add	x0, x22, #0x30
400047e4: aa1503e1     	mov	x1, x21
400047e8: 97fff80f     	bl	0x40002824 <kstrcpy>
400047ec: aa1503e0     	mov	x0, x21
400047f0: 97fff7de     	bl	0x40002768 <kstrlen>
400047f4: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400047f8: f90016c0     	str	x0, [x22, #0x28]
400047fc: 7101fd1f     	cmp	w8, #0x7f
40004800: 5400044c     	b.gt	0x40004888 <vfs_init+0x560>
40004804: 52809809     	mov	w9, #0x4c0              // =1216
40004808: 2a1f03e1     	mov	w1, wzr
4000480c: 52809802     	mov	w2, #0x4c0              // =1216
40004810: 9b294d13     	smaddl	x19, w8, w9, x19
40004814: 11000508     	add	w8, w8, #0x1
40004818: b90b7b28     	str	w8, [x25, #0xb78]
4000481c: aa1303e0     	mov	x0, x19
40004820: 97fff83c     	bl	0x40002910 <memset>
40004824: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x2000>
40004828: b904ba7f     	str	wzr, [x19, #0x4b8]
4000482c: 528e8f09     	mov	w9, #0x7478             // =29816
40004830: fd429900     	ldr	d0, [x8, #0x530]
40004834: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004838: 39002a7f     	strb	wzr, [x19, #0xa]
4000483c: 79001269     	strh	w9, [x19, #0x8]
40004840: 71003d1f     	cmp	w8, #0xf
40004844: fd000260     	str	d0, [x19]
40004848: b900227f     	str	wzr, [x19, #0x20]
4000484c: f9021a74     	str	x20, [x19, #0x430]
40004850: f900167f     	str	xzr, [x19, #0x28]
40004854: 540000ac     	b.gt	0x40004868 <vfs_init+0x540>
40004858: 8b080e89     	add	x9, x20, x8, lsl #3
4000485c: 11000508     	add	w8, w8, #0x1
40004860: b904ba88     	str	w8, [x20, #0x4b8]
40004864: f9021d33     	str	x19, [x9, #0x438]
40004868: f0000014     	adrp	x20, 0x40007000 <__rodata_start>
4000486c: 910efa94     	add	x20, x20, #0x3be
40004870: 9100c260     	add	x0, x19, #0x30
40004874: aa1403e1     	mov	x1, x20
40004878: 97fff7eb     	bl	0x40002824 <kstrcpy>
4000487c: aa1403e0     	mov	x0, x20
40004880: 97fff7ba     	bl	0x40002768 <kstrlen>
40004884: f9001660     	str	x0, [x19, #0x28]
40004888: a9444ff4     	ldp	x20, x19, [sp, #0x40]
4000488c: f9400bf9     	ldr	x25, [sp, #0x10]
40004890: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004894: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004898: a8c57bfd     	ldp	x29, x30, [sp], #0x50
4000489c: d65f03c0     	ret

00000000400048a0 <vfs_load_internal>:
400048a0: 2a1f03e0     	mov	w0, wzr
400048a4: d65f03c0     	ret

00000000400048a8 <vfs_get_root>:
400048a8: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
400048ac: f945c100     	ldr	x0, [x8, #0xb80]
400048b0: d65f03c0     	ret

00000000400048b4 <vfs_get_cwd>:
400048b4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
400048b8: f945c500     	ldr	x0, [x8, #0xb88]
400048bc: d65f03c0     	ret

00000000400048c0 <vfs_getcwd>:
400048c0: d10383ff     	sub	sp, sp, #0xe0
400048c4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
400048c8: a90d4ff4     	stp	x20, x19, [sp, #0xd0]
400048cc: aa0003f3     	mov	x19, x0
400048d0: f945c508     	ldr	x8, [x8, #0xb88]
400048d4: a9087bfd     	stp	x29, x30, [sp, #0x80]
400048d8: 910203fd     	add	x29, sp, #0x80
400048dc: a9096ffc     	stp	x28, x27, [sp, #0x90]
400048e0: a90a67fa     	stp	x26, x25, [sp, #0xa0]
400048e4: a90b5ff8     	stp	x24, x23, [sp, #0xb0]
400048e8: a90c57f6     	stp	x22, x21, [sp, #0xc0]
400048ec: b4000228     	cbz	x8, 0x40004930 <vfs_getcwd+0x70>
400048f0: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
400048f4: f945c129     	ldr	x9, [x9, #0xb80]
400048f8: eb09011f     	cmp	x8, x9
400048fc: 540001a0     	b.eq	0x40004930 <vfs_getcwd+0x70>
40004900: aa1f03ea     	mov	x10, xzr
40004904: 910003eb     	mov	x11, sp
40004908: eb09011f     	cmp	x8, x9
4000490c: 540001c0     	b.eq	0x40004944 <vfs_getcwd+0x84>
40004910: f1003d5f     	cmp	x10, #0xf
40004914: 54000188     	b.hi	0x40004944 <vfs_getcwd+0x84>
40004918: f82a7968     	str	x8, [x11, x10, lsl #3]
4000491c: f9421908     	ldr	x8, [x8, #0x430]
40004920: 9100054c     	add	x12, x10, #0x1
40004924: aa0c03ea     	mov	x10, x12
40004928: b5ffff08     	cbnz	x8, 0x40004908 <vfs_getcwd+0x48>
4000492c: 14000007     	b	0x40004948 <vfs_getcwd+0x88>
40004930: f100083f     	cmp	x1, #0x2
40004934: 540008c3     	b.lo	0x40004a4c <vfs_getcwd+0x18c>
40004938: 528005e8     	mov	w8, #0x2f               // =47
4000493c: 79000268     	strh	w8, [x19]
40004940: 14000043     	b	0x40004a4c <vfs_getcwd+0x18c>
40004944: aa0a03ec     	mov	x12, x10
40004948: 7100059f     	cmp	w12, #0x1
4000494c: 3900027f     	strb	wzr, [x19]
40004950: 540007eb     	b.lt	0x40004a4c <vfs_getcwd+0x18c>
40004954: aa1f03fc     	mov	x28, xzr
40004958: d1000435     	sub	x21, x1, #0x1
4000495c: 9240799a     	and	x26, x12, #0x7fffffff
40004960: d1000836     	sub	x22, x1, #0x2
40004964: 91004277     	add	x23, x19, #0x10
40004968: 528005f8     	mov	w24, #0x2f              // =47
4000496c: 910003f9     	mov	x25, sp
40004970: 14000006     	b	0x40004988 <vfs_getcwd+0xc8>
40004974: aa1c03e8     	mov	x8, x28
40004978: f100077f     	cmp	x27, #0x1
4000497c: aa0803fc     	mov	x28, x8
40004980: 38286a7f     	strb	wzr, [x19, x8]
40004984: 54000649     	b.ls	0x40004a4c <vfs_getcwd+0x18c>
40004988: eb15039f     	cmp	x28, x21
4000498c: aa1a03fb     	mov	x27, x26
40004990: 54000082     	b.hs	0x400049a0 <vfs_getcwd+0xe0>
40004994: 91000788     	add	x8, x28, #0x1
40004998: 783c6a78     	strh	w24, [x19, x28]
4000499c: aa0803fc     	mov	x28, x8
400049a0: d100077a     	sub	x26, x27, #0x1
400049a4: f87a7b34     	ldr	x20, [x25, x26, lsl #3]
400049a8: aa1403e0     	mov	x0, x20
400049ac: 97fff76f     	bl	0x40002768 <kstrlen>
400049b0: b4fffe20     	cbz	x0, 0x40004974 <vfs_getcwd+0xb4>
400049b4: eb15039f     	cmp	x28, x21
400049b8: 54fffde2     	b.hs	0x40004974 <vfs_getcwd+0xb4>
400049bc: cb1c02c8     	sub	x8, x22, x28
400049c0: d1000409     	sub	x9, x0, #0x1
400049c4: eb09011f     	cmp	x8, x9
400049c8: 9a893108     	csel	x8, x8, x9, lo
400049cc: 9100050a     	add	x10, x8, #0x1
400049d0: f100815f     	cmp	x10, #0x20
400049d4: 540000a3     	b.lo	0x400049e8 <vfs_getcwd+0x128>
400049d8: 8b130388     	add	x8, x28, x19
400049dc: cb140108     	sub	x8, x8, x20
400049e0: f100811f     	cmp	x8, #0x20
400049e4: 54000182     	b.hs	0x40004a14 <vfs_getcwd+0x154>
400049e8: aa1f03e9     	mov	x9, xzr
400049ec: aa1c03e8     	mov	x8, x28
400049f0: 38696a8a     	ldrb	w10, [x20, x9]
400049f4: 91000529     	add	x9, x9, #0x1
400049f8: eb00013f     	cmp	x9, x0
400049fc: 38286a6a     	strb	w10, [x19, x8]
40004a00: 91000508     	add	x8, x8, #0x1
40004a04: 54fffba2     	b.hs	0x40004978 <vfs_getcwd+0xb8>
40004a08: eb15011f     	cmp	x8, x21
40004a0c: 54ffff23     	b.lo	0x400049f0 <vfs_getcwd+0x130>
40004a10: 17ffffda     	b	0x40004978 <vfs_getcwd+0xb8>
40004a14: 927be949     	and	x9, x10, #0xffffffffffffffe0
40004a18: 8b1c02eb     	add	x11, x23, x28
40004a1c: 9100428c     	add	x12, x20, #0x10
40004a20: 8b090388     	add	x8, x28, x9
40004a24: aa0903ed     	mov	x13, x9
40004a28: ad7f8580     	ldp	q0, q1, [x12, #-0x10]
40004a2c: f10081ad     	subs	x13, x13, #0x20
40004a30: 9100818c     	add	x12, x12, #0x20
40004a34: ad3f8560     	stp	q0, q1, [x11, #-0x10]
40004a38: 9100816b     	add	x11, x11, #0x20
40004a3c: 54ffff61     	b.ne	0x40004a28 <vfs_getcwd+0x168>
40004a40: eb09015f     	cmp	x10, x9
40004a44: 54fffd61     	b.ne	0x400049f0 <vfs_getcwd+0x130>
40004a48: 17ffffcc     	b	0x40004978 <vfs_getcwd+0xb8>
40004a4c: a94d4ff4     	ldp	x20, x19, [sp, #0xd0]
40004a50: a94c57f6     	ldp	x22, x21, [sp, #0xc0]
40004a54: a94b5ff8     	ldp	x24, x23, [sp, #0xb0]
40004a58: a94a67fa     	ldp	x26, x25, [sp, #0xa0]
40004a5c: a9496ffc     	ldp	x28, x27, [sp, #0x90]
40004a60: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004a64: 910383ff     	add	sp, sp, #0xe0
40004a68: d65f03c0     	ret

0000000040004a6c <vfs_find>:
40004a6c: d10203ff     	sub	sp, sp, #0x80
40004a70: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004a74: 910083fd     	add	x29, sp, #0x20
40004a78: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004a7c: a90467fa     	stp	x26, x25, [sp, #0x40]
40004a80: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004a84: a90657f6     	stp	x22, x21, [sp, #0x60]
40004a88: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004a8c: b4000a60     	cbz	x0, 0x40004bd8 <vfs_find+0x16c>
40004a90: 39400008     	ldrb	w8, [x0]
40004a94: aa0003f4     	mov	x20, x0
40004a98: 34000a08     	cbz	w8, 0x40004bd8 <vfs_find+0x16c>
40004a9c: 7100bd1f     	cmp	w8, #0x2f
40004aa0: 54000121     	b.ne	0x40004ac4 <vfs_find+0x58>
40004aa4: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
40004aa8: 52800037     	mov	w23, #0x1               // =1
40004aac: f945c113     	ldr	x19, [x8, #0xb80]
40004ab0: 38776a88     	ldrb	w8, [x20, x23]
40004ab4: 7100bd1f     	cmp	w8, #0x2f
40004ab8: 540000e1     	b.ne	0x40004ad4 <vfs_find+0x68>
40004abc: 910006f7     	add	x23, x23, #0x1
40004ac0: 17fffffc     	b	0x40004ab0 <vfs_find+0x44>
40004ac4: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
40004ac8: aa1f03f7     	mov	x23, xzr
40004acc: f945c533     	ldr	x19, [x9, #0xb88]
40004ad0: 14000002     	b	0x40004ad8 <vfs_find+0x6c>
40004ad4: 34000848     	cbz	w8, 0x40004bdc <vfs_find+0x170>
40004ad8: 91000698     	add	x24, x20, #0x1
40004adc: f0000015     	adrp	x21, 0x40007000 <__rodata_start>
40004ae0: 9125ceb5     	add	x21, x21, #0x973
40004ae4: 910003f9     	mov	x25, sp
40004ae8: 90000036     	adrp	x22, 0x40008000 <__rodata_start+0x1000>
40004aec: 910356d6     	add	x22, x22, #0xd5
40004af0: 14000006     	b	0x40004b08 <vfs_find+0x9c>
40004af4: f9421a68     	ldr	x8, [x19, #0x430]
40004af8: f100011f     	cmp	x8, #0x0
40004afc: 9a880273     	csel	x19, x19, x8, eq
40004b00: 385ff348     	ldurb	w8, [x26, #-0x1]
40004b04: 340006c8     	cbz	w8, 0x40004bdc <vfs_find+0x170>
40004b08: 7100bd1f     	cmp	w8, #0x2f
40004b0c: 54000061     	b.ne	0x40004b18 <vfs_find+0xac>
40004b10: aa1f03e9     	mov	x9, xzr
40004b14: 14000010     	b	0x40004b54 <vfs_find+0xe8>
40004b18: aa1f03e9     	mov	x9, xzr
40004b1c: 8b17030a     	add	x10, x24, x23
40004b20: 34000188     	cbz	w8, 0x40004b50 <vfs_find+0xe4>
40004b24: f100793f     	cmp	x9, #0x1e
40004b28: 54000148     	b.hi	0x40004b50 <vfs_find+0xe4>
40004b2c: 38296b28     	strb	w8, [x25, x9]
40004b30: 38696948     	ldrb	w8, [x10, x9]
40004b34: 9100052b     	add	x11, x9, #0x1
40004b38: aa0b03e9     	mov	x9, x11
40004b3c: 7100bd1f     	cmp	w8, #0x2f
40004b40: 54ffff01     	b.ne	0x40004b20 <vfs_find+0xb4>
40004b44: 8b0b02f7     	add	x23, x23, x11
40004b48: aa0b03e9     	mov	x9, x11
40004b4c: 14000002     	b	0x40004b54 <vfs_find+0xe8>
40004b50: 8b0902f7     	add	x23, x23, x9
40004b54: 8b17029a     	add	x26, x20, x23
40004b58: d10006f7     	sub	x23, x23, #0x1
40004b5c: 38296b3f     	strb	wzr, [x25, x9]
40004b60: 38401748     	ldrb	w8, [x26], #0x1
40004b64: 910006f7     	add	x23, x23, #0x1
40004b68: 7100bd1f     	cmp	w8, #0x2f
40004b6c: 54ffffa0     	b.eq	0x40004b60 <vfs_find+0xf4>
40004b70: 910003e0     	mov	x0, sp
40004b74: aa1503e1     	mov	x1, x21
40004b78: 97fff70c     	bl	0x400027a8 <kstrcmp>
40004b7c: 34fffc20     	cbz	w0, 0x40004b00 <vfs_find+0x94>
40004b80: 910003e0     	mov	x0, sp
40004b84: aa1603e1     	mov	x1, x22
40004b88: 97fff708     	bl	0x400027a8 <kstrcmp>
40004b8c: 34fffb40     	cbz	w0, 0x40004af4 <vfs_find+0x88>
40004b90: b944ba68     	ldr	w8, [x19, #0x4b8]
40004b94: 7100051f     	cmp	w8, #0x1
40004b98: 5400020b     	b.lt	0x40004bd8 <vfs_find+0x16c>
40004b9c: aa1f03fb     	mov	x27, xzr
40004ba0: 9110e27c     	add	x28, x19, #0x438
40004ba4: 14000005     	b	0x40004bb8 <vfs_find+0x14c>
40004ba8: b944ba68     	ldr	w8, [x19, #0x4b8]
40004bac: 9100077b     	add	x27, x27, #0x1
40004bb0: eb28c37f     	cmp	x27, w8, sxtw
40004bb4: 5400012a     	b.ge	0x40004bd8 <vfs_find+0x16c>
40004bb8: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004bbc: b4ffff80     	cbz	x0, 0x40004bac <vfs_find+0x140>
40004bc0: 910003e1     	mov	x1, sp
40004bc4: 97fff6f9     	bl	0x400027a8 <kstrcmp>
40004bc8: 35ffff00     	cbnz	w0, 0x40004ba8 <vfs_find+0x13c>
40004bcc: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004bd0: b5fff993     	cbnz	x19, 0x40004b00 <vfs_find+0x94>
40004bd4: 14000002     	b	0x40004bdc <vfs_find+0x170>
40004bd8: aa1f03f3     	mov	x19, xzr
40004bdc: aa1303e0     	mov	x0, x19
40004be0: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004be4: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004be8: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004bec: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004bf0: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004bf4: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004bf8: 910203ff     	add	sp, sp, #0x80
40004bfc: d65f03c0     	ret

0000000040004c00 <vfs_chdir>:
40004c00: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004c04: f9000bf3     	str	x19, [sp, #0x10]
40004c08: 910003fd     	mov	x29, sp
40004c0c: b4000200     	cbz	x0, 0x40004c4c <vfs_chdir+0x4c>
40004c10: 39400008     	ldrb	w8, [x0]
40004c14: 340001c8     	cbz	w8, 0x40004c4c <vfs_chdir+0x4c>
40004c18: b0000021     	adrp	x1, 0x40009000 <__rodata_start+0x2000>
40004c1c: 91036021     	add	x1, x1, #0xd8
40004c20: aa0003f3     	mov	x19, x0
40004c24: 97fff6e1     	bl	0x400027a8 <kstrcmp>
40004c28: 34000120     	cbz	w0, 0x40004c4c <vfs_chdir+0x4c>
40004c2c: aa1303e0     	mov	x0, x19
40004c30: 97ffff8f     	bl	0x40004a6c <vfs_find>
40004c34: b40002c0     	cbz	x0, 0x40004c8c <vfs_chdir+0x8c>
40004c38: b9402008     	ldr	w8, [x0, #0x20]
40004c3c: 7100051f     	cmp	w8, #0x1
40004c40: 54000180     	b.eq	0x40004c70 <vfs_chdir+0x70>
40004c44: 12800028     	mov	w8, #-0x2               // =-2
40004c48: 1400000d     	b	0x40004c7c <vfs_chdir+0x7c>
40004c4c: f0000000     	adrp	x0, 0x40007000 <__rodata_start>
40004c50: 913ebc00     	add	x0, x0, #0xfaf
40004c54: 97ffff86     	bl	0x40004a6c <vfs_find>
40004c58: b4000080     	cbz	x0, 0x40004c68 <vfs_chdir+0x68>
40004c5c: b9402008     	ldr	w8, [x0, #0x20]
40004c60: 7100051f     	cmp	w8, #0x1
40004c64: 54000060     	b.eq	0x40004c70 <vfs_chdir+0x70>
40004c68: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
40004c6c: f945c100     	ldr	x0, [x8, #0xb80]
40004c70: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
40004c74: 2a1f03e8     	mov	w8, wzr
40004c78: f905c520     	str	x0, [x9, #0xb88]
40004c7c: f9400bf3     	ldr	x19, [sp, #0x10]
40004c80: 2a0803e0     	mov	w0, w8
40004c84: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004c88: d65f03c0     	ret
40004c8c: 12800008     	mov	w8, #-0x1               // =-1
40004c90: 17fffffb     	b	0x40004c7c <vfs_chdir+0x7c>

0000000040004c94 <vfs_mkdir>:
40004c94: b40001e0     	cbz	x0, 0x40004cd0 <vfs_mkdir+0x3c>
40004c98: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004c9c: 39400008     	ldrb	w8, [x0]
40004ca0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004ca4: aa0003f3     	mov	x19, x0
40004ca8: a90157f6     	stp	x22, x21, [sp, #0x10]
40004cac: 910003fd     	mov	x29, sp
40004cb0: 34000148     	cbz	w8, 0x40004cd8 <vfs_mkdir+0x44>
40004cb4: f0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3488>
40004cb8: f945c695     	ldr	x21, [x20, #0xb88]
40004cbc: b944baa8     	ldr	w8, [x21, #0x4b8]
40004cc0: 71003d1f     	cmp	w8, #0xf
40004cc4: 540000ed     	b.le	0x40004ce0 <vfs_mkdir+0x4c>
40004cc8: 12800020     	mov	w0, #-0x2               // =-2
40004ccc: 14000043     	b	0x40004dd8 <vfs_mkdir+0x144>
40004cd0: 12800000     	mov	w0, #-0x1               // =-1
40004cd4: d65f03c0     	ret
40004cd8: 12800000     	mov	w0, #-0x1               // =-1
40004cdc: 1400003f     	b	0x40004dd8 <vfs_mkdir+0x144>
40004ce0: 7100051f     	cmp	w8, #0x1
40004ce4: 540001eb     	b.lt	0x40004d20 <vfs_mkdir+0x8c>
40004ce8: aa1f03f6     	mov	x22, xzr
40004cec: 14000005     	b	0x40004d00 <vfs_mkdir+0x6c>
40004cf0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004cf4: 910006d6     	add	x22, x22, #0x1
40004cf8: eb0802df     	cmp	x22, x8
40004cfc: 5400012a     	b.ge	0x40004d20 <vfs_mkdir+0x8c>
40004d00: 8b160ea8     	add	x8, x21, x22, lsl #3
40004d04: f9421d00     	ldr	x0, [x8, #0x438]
40004d08: b4ffff40     	cbz	x0, 0x40004cf0 <vfs_mkdir+0x5c>
40004d0c: aa1303e1     	mov	x1, x19
40004d10: 97fff6a6     	bl	0x400027a8 <kstrcmp>
40004d14: 340003e0     	cbz	w0, 0x40004d90 <vfs_mkdir+0xfc>
40004d18: f945c695     	ldr	x21, [x20, #0xb88]
40004d1c: 17fffff5     	b	0x40004cf0 <vfs_mkdir+0x5c>
40004d20: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
40004d24: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004d28: 7101fd3f     	cmp	w9, #0x7f
40004d2c: 5400006d     	b.le	0x40004d38 <vfs_mkdir+0xa4>
40004d30: 12800060     	mov	w0, #-0x4               // =-4
40004d34: 14000029     	b	0x40004dd8 <vfs_mkdir+0x144>
40004d38: 5280980a     	mov	w10, #0x4c0             // =1216
40004d3c: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3488>
40004d40: 912e416b     	add	x11, x11, #0xb90
40004d44: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d48: 11000529     	add	w9, w9, #0x1
40004d4c: 2a1f03e1     	mov	w1, wzr
40004d50: 52809802     	mov	w2, #0x4c0              // =1216
40004d54: b90b7909     	str	w9, [x8, #0xb78]
40004d58: aa1403e0     	mov	x0, x20
40004d5c: 97fff6ed     	bl	0x40002910 <memset>
40004d60: 39400268     	ldrb	w8, [x19]
40004d64: 340001a8     	cbz	w8, 0x40004d98 <vfs_mkdir+0x104>
40004d68: aa1f03ea     	mov	x10, xzr
40004d6c: 91000669     	add	x9, x19, #0x1
40004d70: 382a6a88     	strb	w8, [x20, x10]
40004d74: 9100054b     	add	x11, x10, #0x1
40004d78: 386a6928     	ldrb	w8, [x9, x10]
40004d7c: 34000108     	cbz	w8, 0x40004d9c <vfs_mkdir+0x108>
40004d80: f100795f     	cmp	x10, #0x1e
40004d84: aa0b03ea     	mov	x10, x11
40004d88: 54ffff43     	b.lo	0x40004d70 <vfs_mkdir+0xdc>
40004d8c: 14000004     	b	0x40004d9c <vfs_mkdir+0x108>
40004d90: 12800040     	mov	w0, #-0x3               // =-3
40004d94: 14000011     	b	0x40004dd8 <vfs_mkdir+0x144>
40004d98: aa1f03eb     	mov	x11, xzr
40004d9c: 382b6a9f     	strb	wzr, [x20, x11]
40004da0: 2a1f03e0     	mov	w0, wzr
40004da4: 52800029     	mov	w9, #0x1                // =1
40004da8: b904ba9f     	str	wzr, [x20, #0x4b8]
40004dac: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004db0: b9002289     	str	w9, [x20, #0x20]
40004db4: f9021a95     	str	x21, [x20, #0x430]
40004db8: 71003d1f     	cmp	w8, #0xf
40004dbc: f900169f     	str	xzr, [x20, #0x28]
40004dc0: 540000cc     	b.gt	0x40004dd8 <vfs_mkdir+0x144>
40004dc4: 8b080ea9     	add	x9, x21, x8, lsl #3
40004dc8: 2a1f03e0     	mov	w0, wzr
40004dcc: 11000508     	add	w8, w8, #0x1
40004dd0: b904baa8     	str	w8, [x21, #0x4b8]
40004dd4: f9021d34     	str	x20, [x9, #0x438]
40004dd8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004ddc: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004de0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004de4: d65f03c0     	ret

0000000040004de8 <vfs_sync>:
40004de8: d65f03c0     	ret

0000000040004dec <vfs_touch>:
40004dec: b4000500     	cbz	x0, 0x40004e8c <vfs_touch+0xa0>
40004df0: 39400008     	ldrb	w8, [x0]
40004df4: 340004c8     	cbz	w8, 0x40004e8c <vfs_touch+0xa0>
40004df8: d10583ff     	sub	sp, sp, #0x160
40004dfc: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3488>
40004e00: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004e04: aa1f03f4     	mov	x20, xzr
40004e08: f945c533     	ldr	x19, [x9, #0xb88]
40004e0c: aa0003e9     	mov	x9, x0
40004e10: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004e14: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004e18: 910483fd     	add	x29, sp, #0x120
40004e1c: a91457f6     	stp	x22, x21, [sp, #0x140]
40004e20: 14000003     	b	0x40004e2c <vfs_touch+0x40>
40004e24: aa0903f4     	mov	x20, x9
40004e28: 38401d28     	ldrb	w8, [x9, #0x1]!
40004e2c: 7100bd1f     	cmp	w8, #0x2f
40004e30: 54ffffa0     	b.eq	0x40004e24 <vfs_touch+0x38>
40004e34: 35ffffa8     	cbnz	w8, 0x40004e28 <vfs_touch+0x3c>
40004e38: b4000334     	cbz	x20, 0x40004e9c <vfs_touch+0xb0>
40004e3c: cb000288     	sub	x8, x20, x0
40004e40: 52801fe9     	mov	w9, #0xff               // =255
40004e44: aa0103f5     	mov	x21, x1
40004e48: f103fd1f     	cmp	x8, #0xff
40004e4c: aa0003e1     	mov	x1, x0
40004e50: 910083e0     	add	x0, sp, #0x20
40004e54: 9a893113     	csel	x19, x8, x9, lo
40004e58: 910083f6     	add	x22, sp, #0x20
40004e5c: aa1303e2     	mov	x2, x19
40004e60: 97fff678     	bl	0x40002840 <kstrncpy>
40004e64: 910083e0     	add	x0, sp, #0x20
40004e68: 38336adf     	strb	wzr, [x22, x19]
40004e6c: 97ffff00     	bl	0x40004a6c <vfs_find>
40004e70: b4000120     	cbz	x0, 0x40004e94 <vfs_touch+0xa8>
40004e74: b9402008     	ldr	w8, [x0, #0x20]
40004e78: aa0003f3     	mov	x19, x0
40004e7c: 7100051f     	cmp	w8, #0x1
40004e80: 540000a1     	b.ne	0x40004e94 <vfs_touch+0xa8>
40004e84: 91000688     	add	x8, x20, #0x1
40004e88: 14000007     	b	0x40004ea4 <vfs_touch+0xb8>
40004e8c: 12800000     	mov	w0, #-0x1               // =-1
40004e90: d65f03c0     	ret
40004e94: 12800000     	mov	w0, #-0x1               // =-1
40004e98: 1400006a     	b	0x40005040 <vfs_touch+0x254>
40004e9c: aa0003e8     	mov	x8, x0
40004ea0: aa0103f5     	mov	x21, x1
40004ea4: 910003e0     	mov	x0, sp
40004ea8: aa0803e1     	mov	x1, x8
40004eac: 528003e2     	mov	w2, #0x1f               // =31
40004eb0: 97fff664     	bl	0x40002840 <kstrncpy>
40004eb4: b944ba68     	ldr	w8, [x19, #0x4b8]
40004eb8: 39007fff     	strb	wzr, [sp, #0x1f]
40004ebc: 7100051f     	cmp	w8, #0x1
40004ec0: 5400024b     	b.lt	0x40004f08 <vfs_touch+0x11c>
40004ec4: aa1f03f6     	mov	x22, xzr
40004ec8: 9110e277     	add	x23, x19, #0x438
40004ecc: 14000004     	b	0x40004edc <vfs_touch+0xf0>
40004ed0: 910006d6     	add	x22, x22, #0x1
40004ed4: eb28c2df     	cmp	x22, w8, sxtw
40004ed8: 5400010a     	b.ge	0x40004ef8 <vfs_touch+0x10c>
40004edc: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004ee0: b4ffff80     	cbz	x0, 0x40004ed0 <vfs_touch+0xe4>
40004ee4: 910003e1     	mov	x1, sp
40004ee8: 97fff630     	bl	0x400027a8 <kstrcmp>
40004eec: 340004a0     	cbz	w0, 0x40004f80 <vfs_touch+0x194>
40004ef0: b944ba68     	ldr	w8, [x19, #0x4b8]
40004ef4: 17fffff7     	b	0x40004ed0 <vfs_touch+0xe4>
40004ef8: 71003d1f     	cmp	w8, #0xf
40004efc: 5400006d     	b.le	0x40004f08 <vfs_touch+0x11c>
40004f00: 12800020     	mov	w0, #-0x2               // =-2
40004f04: 1400004f     	b	0x40005040 <vfs_touch+0x254>
40004f08: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
40004f0c: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004f10: 7101fd3f     	cmp	w9, #0x7f
40004f14: 5400006d     	b.le	0x40004f20 <vfs_touch+0x134>
40004f18: 12800060     	mov	w0, #-0x4               // =-4
40004f1c: 14000049     	b	0x40005040 <vfs_touch+0x254>
40004f20: 5280980a     	mov	w10, #0x4c0             // =1216
40004f24: f000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3488>
40004f28: 912e416b     	add	x11, x11, #0xb90
40004f2c: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004f30: 11000529     	add	w9, w9, #0x1
40004f34: 2a1f03e1     	mov	w1, wzr
40004f38: 52809802     	mov	w2, #0x4c0              // =1216
40004f3c: b90b7909     	str	w9, [x8, #0xb78]
40004f40: aa1403e0     	mov	x0, x20
40004f44: 97fff673     	bl	0x40002910 <memset>
40004f48: 394003e8     	ldrb	w8, [sp]
40004f4c: 340003e8     	cbz	w8, 0x40004fc8 <vfs_touch+0x1dc>
40004f50: 910003ea     	mov	x10, sp
40004f54: aa1f03e9     	mov	x9, xzr
40004f58: aa1503e0     	mov	x0, x21
40004f5c: b240014a     	orr	x10, x10, #0x1
40004f60: 38296a88     	strb	w8, [x20, x9]
40004f64: 38696948     	ldrb	w8, [x10, x9]
40004f68: 9100052b     	add	x11, x9, #0x1
40004f6c: 34000328     	cbz	w8, 0x40004fd0 <vfs_touch+0x1e4>
40004f70: f100793f     	cmp	x9, #0x1e
40004f74: aa0b03e9     	mov	x9, x11
40004f78: 54ffff43     	b.lo	0x40004f60 <vfs_touch+0x174>
40004f7c: 14000015     	b	0x40004fd0 <vfs_touch+0x1e4>
40004f80: b40005f5     	cbz	x21, 0x4000503c <vfs_touch+0x250>
40004f84: aa1503e0     	mov	x0, x21
40004f88: 97fff5f8     	bl	0x40002768 <kstrlen>
40004f8c: 52807fe8     	mov	w8, #0x3ff              // =1023
40004f90: f10ffc1f     	cmp	x0, #0x3ff
40004f94: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004f98: 9a883014     	csel	x20, x0, x8, lo
40004f9c: aa1503e1     	mov	x1, x21
40004fa0: 9100c120     	add	x0, x9, #0x30
40004fa4: aa1403e2     	mov	x2, x20
40004fa8: 97fff683     	bl	0x400029b4 <memcpy>
40004fac: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004fb0: 2a1f03e0     	mov	w0, wzr
40004fb4: 8b140108     	add	x8, x8, x20
40004fb8: 3900c11f     	strb	wzr, [x8, #0x30]
40004fbc: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004fc0: f9001514     	str	x20, [x8, #0x28]
40004fc4: 1400001f     	b	0x40005040 <vfs_touch+0x254>
40004fc8: aa1f03eb     	mov	x11, xzr
40004fcc: aa1503e0     	mov	x0, x21
40004fd0: 382b6a9f     	strb	wzr, [x20, x11]
40004fd4: b904ba9f     	str	wzr, [x20, #0x4b8]
40004fd8: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004fdc: b900229f     	str	wzr, [x20, #0x20]
40004fe0: f9021a93     	str	x19, [x20, #0x430]
40004fe4: 71003d1f     	cmp	w8, #0xf
40004fe8: f900169f     	str	xzr, [x20, #0x28]
40004fec: 540000ac     	b.gt	0x40005000 <vfs_touch+0x214>
40004ff0: 8b080e69     	add	x9, x19, x8, lsl #3
40004ff4: 11000508     	add	w8, w8, #0x1
40004ff8: b904ba68     	str	w8, [x19, #0x4b8]
40004ffc: f9021d34     	str	x20, [x9, #0x438]
40005000: b4000200     	cbz	x0, 0x40005040 <vfs_touch+0x254>
40005004: aa0003f3     	mov	x19, x0
40005008: 97fff5d8     	bl	0x40002768 <kstrlen>
4000500c: 52807fe8     	mov	w8, #0x3ff              // =1023
40005010: f10ffc1f     	cmp	x0, #0x3ff
40005014: 9100c296     	add	x22, x20, #0x30
40005018: 9a883015     	csel	x21, x0, x8, lo
4000501c: aa1603e0     	mov	x0, x22
40005020: aa1303e1     	mov	x1, x19
40005024: aa1503e2     	mov	x2, x21
40005028: 97fff663     	bl	0x400029b4 <memcpy>
4000502c: 2a1f03e0     	mov	w0, wzr
40005030: 38356adf     	strb	wzr, [x22, x21]
40005034: f9001695     	str	x21, [x20, #0x28]
40005038: 14000002     	b	0x40005040 <vfs_touch+0x254>
4000503c: 2a1f03e0     	mov	w0, wzr
40005040: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005044: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005048: a9535ffc     	ldp	x28, x23, [sp, #0x130]
4000504c: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40005050: 910583ff     	add	sp, sp, #0x160
40005054: d65f03c0     	ret

0000000040005058 <vfs_write_file>:
40005058: 17ffff65     	b	0x40004dec <vfs_touch>

000000004000505c <vfs_remove>:
4000505c: b40005c0     	cbz	x0, 0x40005114 <vfs_remove+0xb8>
40005060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40005064: 39400008     	ldrb	w8, [x0]
40005068: a9024ff4     	stp	x20, x19, [sp, #0x20]
4000506c: aa0003f3     	mov	x19, x0
40005070: f9000bf5     	str	x21, [sp, #0x10]
40005074: 910003fd     	mov	x29, sp
40005078: 34000448     	cbz	w8, 0x40005100 <vfs_remove+0xa4>
4000507c: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3488>
40005080: f945c688     	ldr	x8, [x20, #0xb88]
40005084: b944b909     	ldr	w9, [x8, #0x4b8]
40005088: 7100053f     	cmp	w9, #0x1
4000508c: 540003ab     	b.lt	0x40005100 <vfs_remove+0xa4>
40005090: aa1f03f5     	mov	x21, xzr
40005094: 14000005     	b	0x400050a8 <vfs_remove+0x4c>
40005098: b984b909     	ldrsw	x9, [x8, #0x4b8]
4000509c: 910006b5     	add	x21, x21, #0x1
400050a0: eb0902bf     	cmp	x21, x9
400050a4: 540002ea     	b.ge	0x40005100 <vfs_remove+0xa4>
400050a8: 8b150d09     	add	x9, x8, x21, lsl #3
400050ac: f9421d20     	ldr	x0, [x9, #0x438]
400050b0: b4ffff40     	cbz	x0, 0x40005098 <vfs_remove+0x3c>
400050b4: aa1303e1     	mov	x1, x19
400050b8: 97fff5bc     	bl	0x400027a8 <kstrcmp>
400050bc: f945c688     	ldr	x8, [x20, #0xb88]
400050c0: 35fffec0     	cbnz	w0, 0x40005098 <vfs_remove+0x3c>
400050c4: b984b909     	ldrsw	x9, [x8, #0x4b8]
400050c8: d1000529     	sub	x9, x9, #0x1
400050cc: 6b15013f     	cmp	w9, w21
400050d0: 5400026d     	b.le	0x4000511c <vfs_remove+0xc0>
400050d4: f945c68a     	ldr	x10, [x20, #0xb88]
400050d8: b984b949     	ldrsw	x9, [x10, #0x4b8]
400050dc: d1000529     	sub	x9, x9, #0x1
400050e0: 8b150d08     	add	x8, x8, x21, lsl #3
400050e4: 910006b5     	add	x21, x21, #0x1
400050e8: eb0902bf     	cmp	x21, x9
400050ec: f942210b     	ldr	x11, [x8, #0x440]
400050f0: f9021d0b     	str	x11, [x8, #0x438]
400050f4: aa0a03e8     	mov	x8, x10
400050f8: 54ffff4b     	b.lt	0x400050e0 <vfs_remove+0x84>
400050fc: 14000009     	b	0x40005120 <vfs_remove+0xc4>
40005100: 12800000     	mov	w0, #-0x1               // =-1
40005104: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005108: f9400bf5     	ldr	x21, [sp, #0x10]
4000510c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005110: d65f03c0     	ret
40005114: 12800000     	mov	w0, #-0x1               // =-1
40005118: d65f03c0     	ret
4000511c: aa0803ea     	mov	x10, x8
40005120: 8b090d48     	add	x8, x10, x9, lsl #3
40005124: 2a1f03e0     	mov	w0, wzr
40005128: f9021d1f     	str	xzr, [x8, #0x438]
4000512c: f945c688     	ldr	x8, [x20, #0xb88]
40005130: b944b909     	ldr	w9, [x8, #0x4b8]
40005134: 51000529     	sub	w9, w9, #0x1
40005138: b904b909     	str	w9, [x8, #0x4b8]
4000513c: 17fffff2     	b	0x40005104 <vfs_remove+0xa8>

0000000040005140 <vfs_list_dir>:
40005140: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005144: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3488>
40005148: f100001f     	cmp	x0, #0x0
4000514c: a90257f6     	stp	x22, x21, [sp, #0x20]
40005150: f945c508     	ldr	x8, [x8, #0xb88]
40005154: f9000bf7     	str	x23, [sp, #0x10]
40005158: 910003fd     	mov	x29, sp
4000515c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005160: 9a800115     	csel	x21, x8, x0, eq
40005164: b94022a8     	ldr	w8, [x21, #0x20]
40005168: 7100051f     	cmp	w8, #0x1
4000516c: 54000521     	b.ne	0x40005210 <vfs_list_dir+0xd0>
40005170: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005174: 91387c00     	add	x0, x0, #0xe1f
40005178: 97fff951     	bl	0x400036bc <uart_puts>
4000517c: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
40005180: 91208c00     	add	x0, x0, #0x823
40005184: 97fff94e     	bl	0x400036bc <uart_puts>
40005188: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
4000518c: 9132c400     	add	x0, x0, #0xcb1
40005190: 97fff94b     	bl	0x400036bc <uart_puts>
40005194: f9421aa8     	ldr	x8, [x21, #0x430]
40005198: b4000088     	cbz	x8, 0x400051a8 <vfs_list_dir+0x68>
4000519c: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x1000>
400051a0: 910c5800     	add	x0, x0, #0x316
400051a4: 97fff946     	bl	0x400036bc <uart_puts>
400051a8: b944baa1     	ldr	w1, [x21, #0x4b8]
400051ac: 7100043f     	cmp	w1, #0x1
400051b0: 5400034b     	b.lt	0x40005218 <vfs_list_dir+0xd8>
400051b4: aa1f03f6     	mov	x22, xzr
400051b8: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x1000>
400051bc: 9128a273     	add	x19, x19, #0xa28
400051c0: 9110e2b7     	add	x23, x21, #0x438
400051c4: f0000014     	adrp	x20, 0x40008000 <__rodata_start+0x1000>
400051c8: 91190e94     	add	x20, x20, #0x643
400051cc: 14000008     	b	0x400051ec <vfs_list_dir+0xac>
400051d0: b9402841     	ldr	w1, [x2, #0x28]
400051d4: aa1403e0     	mov	x0, x20
400051d8: 97fffa49     	bl	0x40003afc <uart_printf>
400051dc: b984baa1     	ldrsw	x1, [x21, #0x4b8]
400051e0: 910006d6     	add	x22, x22, #0x1
400051e4: eb0102df     	cmp	x22, x1
400051e8: 5400018a     	b.ge	0x40005218 <vfs_list_dir+0xd8>
400051ec: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
400051f0: b4ffff62     	cbz	x2, 0x400051dc <vfs_list_dir+0x9c>
400051f4: b9402048     	ldr	w8, [x2, #0x20]
400051f8: 7100051f     	cmp	w8, #0x1
400051fc: 54fffea1     	b.ne	0x400051d0 <vfs_list_dir+0x90>
40005200: aa1303e0     	mov	x0, x19
40005204: aa0203e1     	mov	x1, x2
40005208: 97fffa3d     	bl	0x40003afc <uart_printf>
4000520c: 17fffff4     	b	0x400051dc <vfs_list_dir+0x9c>
40005210: 12800000     	mov	w0, #-0x1               // =-1
40005214: 14000005     	b	0x40005228 <vfs_list_dir+0xe8>
40005218: d0000000     	adrp	x0, 0x40007000 <__rodata_start>
4000521c: 9125d400     	add	x0, x0, #0x975
40005220: 97fffa37     	bl	0x40003afc <uart_printf>
40005224: 2a1f03e0     	mov	w0, wzr
40005228: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000522c: f9400bf7     	ldr	x23, [sp, #0x10]
40005230: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005234: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005238: d65f03c0     	ret

000000004000523c <vfs_load>:
4000523c: d65f03c0     	ret
		...

0000000040005800 <exception_vector_table>:
40005800: 14000201     	b	0x40006004 <handle_sync_invalid>
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
40005880: 14000206     	b	0x40006098 <handle_irq_invalid>
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
40005900: 1400020a     	b	0x40006128 <handle_fiq_invalid>
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
40005980: 1400020e     	b	0x400061b8 <handle_serror_invalid>
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
40005a00: d10403ff     	sub	sp, sp, #0x100
40005a04: a90007e0     	stp	x0, x1, [sp]
40005a08: a9010fe2     	stp	x2, x3, [sp, #0x10]
40005a0c: a90217e4     	stp	x4, x5, [sp, #0x20]
40005a10: a9031fe6     	stp	x6, x7, [sp, #0x30]
40005a14: a90427e8     	stp	x8, x9, [sp, #0x40]
40005a18: a9052fea     	stp	x10, x11, [sp, #0x50]
40005a1c: a90637ec     	stp	x12, x13, [sp, #0x60]
40005a20: a9073fee     	stp	x14, x15, [sp, #0x70]
40005a24: a90847f0     	stp	x16, x17, [sp, #0x80]
40005a28: a9094ff2     	stp	x18, x19, [sp, #0x90]
40005a2c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40005a30: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40005a34: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40005a38: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40005a3c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40005a40: f9007bfe     	str	x30, [sp, #0xf0]
40005a44: 910003e0     	mov	x0, sp
40005a48: 97ffe984     	bl	0x40000058 <handle_sync_exception>
40005a4c: a94007e0     	ldp	x0, x1, [sp]
40005a50: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40005a54: a94217e4     	ldp	x4, x5, [sp, #0x20]
40005a58: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40005a5c: a94427e8     	ldp	x8, x9, [sp, #0x40]
40005a60: a9452fea     	ldp	x10, x11, [sp, #0x50]
40005a64: a94637ec     	ldp	x12, x13, [sp, #0x60]
40005a68: a9473fee     	ldp	x14, x15, [sp, #0x70]
40005a6c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40005a70: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40005a74: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40005a78: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40005a7c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40005a80: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40005a84: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40005a88: f9407bfe     	ldr	x30, [sp, #0xf0]
40005a8c: 910403ff     	add	sp, sp, #0x100
40005a90: d69f03e0     	eret
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

0000000040005b00 <curr_el_spx_irq>:
40005b00: 14000166     	b	0x40006098 <handle_irq_invalid>
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

0000000040005b80 <curr_el_spx_fiq>:
40005b80: 1400016a     	b	0x40006128 <handle_fiq_invalid>
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

0000000040005c00 <curr_el_spx_serror>:
40005c00: 1400016e     	b	0x400061b8 <handle_serror_invalid>
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

0000000040005c80 <lower_el_aarch64_sync>:
40005c80: 140000e1     	b	0x40006004 <handle_sync_invalid>
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

0000000040005d00 <lower_el_aarch64_irq>:
40005d00: 140000e6     	b	0x40006098 <handle_irq_invalid>
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

0000000040005d80 <lower_el_aarch64_fiq>:
40005d80: 140000ea     	b	0x40006128 <handle_fiq_invalid>
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

0000000040005e00 <lower_el_aarch64_serror>:
40005e00: 140000ee     	b	0x400061b8 <handle_serror_invalid>
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

0000000040005e80 <lower_el_aarch32_sync>:
40005e80: 14000061     	b	0x40006004 <handle_sync_invalid>
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

0000000040005f00 <lower_el_aarch32_irq>:
40005f00: 14000066     	b	0x40006098 <handle_irq_invalid>
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

0000000040005f80 <lower_el_aarch32_fiq>:
40005f80: 1400006a     	b	0x40006128 <handle_fiq_invalid>
40005f84: d503201f     	nop
40005f88: d503201f     	nop
40005f8c: d503201f     	nop
40005f90: d503201f     	nop
40005f94: d503201f     	nop
40005f98: d503201f     	nop
40005f9c: d503201f     	nop
40005fa0: d503201f     	nop
40005fa4: d503201f     	nop
40005fa8: d503201f     	nop
40005fac: d503201f     	nop
40005fb0: d503201f     	nop
40005fb4: d503201f     	nop
40005fb8: d503201f     	nop
40005fbc: d503201f     	nop
40005fc0: d503201f     	nop
40005fc4: d503201f     	nop
40005fc8: d503201f     	nop
40005fcc: d503201f     	nop
40005fd0: d503201f     	nop
40005fd4: d503201f     	nop
40005fd8: d503201f     	nop
40005fdc: d503201f     	nop
40005fe0: d503201f     	nop
40005fe4: d503201f     	nop
40005fe8: d503201f     	nop
40005fec: d503201f     	nop
40005ff0: d503201f     	nop
40005ff4: d503201f     	nop
40005ff8: d503201f     	nop
40005ffc: d503201f     	nop

0000000040006000 <lower_el_aarch32_serror>:
40006000: 1400006e     	b	0x400061b8 <handle_serror_invalid>

0000000040006004 <handle_sync_invalid>:
40006004: d10403ff     	sub	sp, sp, #0x100
40006008: a90007e0     	stp	x0, x1, [sp]
4000600c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006010: a90217e4     	stp	x4, x5, [sp, #0x20]
40006014: a9031fe6     	stp	x6, x7, [sp, #0x30]
40006018: a90427e8     	stp	x8, x9, [sp, #0x40]
4000601c: a9052fea     	stp	x10, x11, [sp, #0x50]
40006020: a90637ec     	stp	x12, x13, [sp, #0x60]
40006024: a9073fee     	stp	x14, x15, [sp, #0x70]
40006028: a90847f0     	stp	x16, x17, [sp, #0x80]
4000602c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006030: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006034: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40006038: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000603c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006040: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006044: f9007bfe     	str	x30, [sp, #0xf0]
40006048: 910003e0     	mov	x0, sp
4000604c: 97ffe834     	bl	0x4000011c <c_handle_sync_invalid>
40006050: a94007e0     	ldp	x0, x1, [sp]
40006054: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006058: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000605c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006060: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006064: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006068: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000606c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006070: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006074: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006078: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000607c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006080: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006084: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006088: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000608c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006090: 910403ff     	add	sp, sp, #0x100
40006094: d69f03e0     	eret

0000000040006098 <handle_irq_invalid>:
40006098: d10403ff     	sub	sp, sp, #0x100
4000609c: a90007e0     	stp	x0, x1, [sp]
400060a0: a9010fe2     	stp	x2, x3, [sp, #0x10]
400060a4: a90217e4     	stp	x4, x5, [sp, #0x20]
400060a8: a9031fe6     	stp	x6, x7, [sp, #0x30]
400060ac: a90427e8     	stp	x8, x9, [sp, #0x40]
400060b0: a9052fea     	stp	x10, x11, [sp, #0x50]
400060b4: a90637ec     	stp	x12, x13, [sp, #0x60]
400060b8: a9073fee     	stp	x14, x15, [sp, #0x70]
400060bc: a90847f0     	stp	x16, x17, [sp, #0x80]
400060c0: a9094ff2     	stp	x18, x19, [sp, #0x90]
400060c4: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400060c8: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400060cc: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400060d0: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400060d4: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400060d8: f9007bfe     	str	x30, [sp, #0xf0]
400060dc: 97ffe81e     	bl	0x40000154 <c_handle_irq_invalid>
400060e0: a94007e0     	ldp	x0, x1, [sp]
400060e4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400060e8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400060ec: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400060f0: a94427e8     	ldp	x8, x9, [sp, #0x40]
400060f4: a9452fea     	ldp	x10, x11, [sp, #0x50]
400060f8: a94637ec     	ldp	x12, x13, [sp, #0x60]
400060fc: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006100: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006104: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006108: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000610c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006110: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006114: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006118: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000611c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006120: 910403ff     	add	sp, sp, #0x100
40006124: d69f03e0     	eret

0000000040006128 <handle_fiq_invalid>:
40006128: d10403ff     	sub	sp, sp, #0x100
4000612c: a90007e0     	stp	x0, x1, [sp]
40006130: a9010fe2     	stp	x2, x3, [sp, #0x10]
40006134: a90217e4     	stp	x4, x5, [sp, #0x20]
40006138: a9031fe6     	stp	x6, x7, [sp, #0x30]
4000613c: a90427e8     	stp	x8, x9, [sp, #0x40]
40006140: a9052fea     	stp	x10, x11, [sp, #0x50]
40006144: a90637ec     	stp	x12, x13, [sp, #0x60]
40006148: a9073fee     	stp	x14, x15, [sp, #0x70]
4000614c: a90847f0     	stp	x16, x17, [sp, #0x80]
40006150: a9094ff2     	stp	x18, x19, [sp, #0x90]
40006154: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40006158: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
4000615c: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40006160: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40006164: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40006168: f9007bfe     	str	x30, [sp, #0xf0]
4000616c: 97ffe800     	bl	0x4000016c <c_handle_fiq_invalid>
40006170: a94007e0     	ldp	x0, x1, [sp]
40006174: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006178: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000617c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006180: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006184: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006188: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000618c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006190: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006194: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006198: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000619c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400061a0: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400061a4: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400061a8: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400061ac: f9407bfe     	ldr	x30, [sp, #0xf0]
400061b0: 910403ff     	add	sp, sp, #0x100
400061b4: d69f03e0     	eret

00000000400061b8 <handle_serror_invalid>:
400061b8: d10403ff     	sub	sp, sp, #0x100
400061bc: a90007e0     	stp	x0, x1, [sp]
400061c0: a9010fe2     	stp	x2, x3, [sp, #0x10]
400061c4: a90217e4     	stp	x4, x5, [sp, #0x20]
400061c8: a9031fe6     	stp	x6, x7, [sp, #0x30]
400061cc: a90427e8     	stp	x8, x9, [sp, #0x40]
400061d0: a9052fea     	stp	x10, x11, [sp, #0x50]
400061d4: a90637ec     	stp	x12, x13, [sp, #0x60]
400061d8: a9073fee     	stp	x14, x15, [sp, #0x70]
400061dc: a90847f0     	stp	x16, x17, [sp, #0x80]
400061e0: a9094ff2     	stp	x18, x19, [sp, #0x90]
400061e4: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400061e8: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400061ec: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400061f0: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400061f4: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400061f8: f9007bfe     	str	x30, [sp, #0xf0]
400061fc: 97ffe7e2     	bl	0x40000184 <c_handle_serror_invalid>
40006200: a94007e0     	ldp	x0, x1, [sp]
40006204: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40006208: a94217e4     	ldp	x4, x5, [sp, #0x20]
4000620c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40006210: a94427e8     	ldp	x8, x9, [sp, #0x40]
40006214: a9452fea     	ldp	x10, x11, [sp, #0x50]
40006218: a94637ec     	ldp	x12, x13, [sp, #0x60]
4000621c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40006220: a94847f0     	ldp	x16, x17, [sp, #0x80]
40006224: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40006228: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
4000622c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40006230: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40006234: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40006238: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
4000623c: f9407bfe     	ldr	x30, [sp, #0xf0]
40006240: 910403ff     	add	sp, sp, #0x100
40006244: d69f03e0     	eret

0000000040006248 <trigger_undefined_instruction>:
40006248: 00000000     	udf	#0x0
4000624c: d65f03c0     	ret
