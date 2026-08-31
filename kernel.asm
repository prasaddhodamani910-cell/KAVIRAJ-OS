
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
40000034: 9400057a     	bl	0x4000161c <kmain>

0000000040000038 <halt>:
40000038: d503207f     	wfi
4000003c: 17ffffff     	b	0x40000038 <halt>
40000040: 90 8b 04 40  	.word	0x40048b90
40000044: 00 00 00 00  	.word	0x00000000
40000048: 00 a0 00 40  	.word	0x4000a000
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 90 8b 03 40  	.word	0x40038b90
40000054: 00 00 00 00  	.word	0x00000000

0000000040000058 <launch_kedit>:
40000058: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
4000005c: a9016ffc     	stp	x28, x27, [sp, #0x10]
40000060: 910003fd     	mov	x29, sp
40000064: a90267fa     	stp	x26, x25, [sp, #0x20]
40000068: a9035ff8     	stp	x24, x23, [sp, #0x30]
4000006c: a90457f6     	stp	x22, x21, [sp, #0x40]
40000070: a9054ff4     	stp	x20, x19, [sp, #0x50]
40000074: d11043ff     	sub	sp, sp, #0x410
40000078: d503201f     	nop
4000007c: 1004fc33     	adr	x19, 0x4000a000 <__bss_start>
40000080: aa0003f4     	mov	x20, x0
40000084: aa1303e0     	mov	x0, x19
40000088: 2a1f03e1     	mov	w1, wzr
4000008c: 52864a82     	mov	w2, #0x3254             // =12884
40000090: 940009ba     	bl	0x40002778 <kmemset>
40000094: aa1303e0     	mov	x0, x19
40000098: aa1403e1     	mov	x1, x20
4000009c: 528007e2     	mov	w2, #0x3f               // =63
400000a0: 94000982     	bl	0x400026a8 <kstrncpy>
400000a4: 5280003c     	mov	w28, #0x1               // =1
400000a8: aa1403e0     	mov	x0, x20
400000ac: b932427c     	str	w28, [x19, #0x3240]
400000b0: 94001209     	bl	0x400048d4 <vfs_find>
400000b4: b0000077     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
400000b8: b40004a0     	cbz	x0, 0x4000014c <launch_kedit+0xf4>
400000bc: b9402008     	ldr	w8, [x0, #0x20]
400000c0: 35000468     	cbnz	w8, 0x4000014c <launch_kedit+0xf4>
400000c4: f9401408     	ldr	x8, [x0, #0x28]
400000c8: b40003c8     	cbz	x8, 0x40000140 <launch_kedit+0xe8>
400000cc: 2a1f03e8     	mov	w8, wzr
400000d0: 2a1f03eb     	mov	w11, wzr
400000d4: aa1f03e9     	mov	x9, xzr
400000d8: 9100c00a     	add	x10, x0, #0x30
400000dc: 1400000d     	b	0x40000110 <launch_kedit+0xb8>
400000e0: 93407d0c     	sxtw	x12, w8
400000e4: 7101891f     	cmp	w8, #0x62
400000e8: 11000508     	add	w8, w8, #0x1
400000ec: 8b0c1e6c     	add	x12, x19, x12, lsl #7
400000f0: 8b2bc18b     	add	x11, x12, w11, sxtw
400000f4: 3901017f     	strb	wzr, [x11, #0x40]
400000f8: 2a1f03eb     	mov	w11, wzr
400000fc: 5400022c     	b.gt	0x40000140 <launch_kedit+0xe8>
40000100: f940140c     	ldr	x12, [x0, #0x28]
40000104: 91000529     	add	x9, x9, #0x1
40000108: eb0c013f     	cmp	x9, x12
4000010c: 540001a2     	b.hs	0x40000140 <launch_kedit+0xe8>
40000110: 3869694c     	ldrb	w12, [x10, x9]
40000114: 7100299f     	cmp	w12, #0xa
40000118: 54fffe40     	b.eq	0x400000e0 <launch_kedit+0x88>
4000011c: 7101f97f     	cmp	w11, #0x7e
40000120: 54ffff0c     	b.gt	0x40000100 <launch_kedit+0xa8>
40000124: 2a0803ed     	mov	w13, w8
40000128: 93407dad     	sxtw	x13, w13
4000012c: 8b0d1e6d     	add	x13, x19, x13, lsl #7
40000130: 8b2bc1ad     	add	x13, x13, w11, sxtw
40000134: 1100056b     	add	w11, w11, #0x1
40000138: 390101ac     	strb	w12, [x13, #0x40]
4000013c: 17fffff1     	b	0x40000100 <launch_kedit+0xa8>
40000140: 7100051f     	cmp	w8, #0x1
40000144: 1a9f8508     	csinc	w8, w8, wzr, hi
40000148: b90242e8     	str	w8, [x23, #0x240]
4000014c: d503201f     	nop
40000150: 5003a540     	adr	x0, 0x400075fa <__rodata_start+0x15fa>
40000154: 94000cf4     	bl	0x40003524 <uart_puts>
40000158: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
4000015c: 912c1a94     	add	x20, x20, #0xb06
40000160: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
40000164: 91030ad6     	add	x22, x22, #0xc2
40000168: f0000038     	adrp	x24, 0x40007000 <__rodata_start+0x1000>
4000016c: 9105db18     	add	x24, x24, #0x176
40000170: f0000039     	adrp	x25, 0x40007000 <__rodata_start+0x1000>
40000174: 9110cb39     	add	x25, x25, #0x432
40000178: b000007a     	adrp	x26, 0x4000d000 <__bss_start+0x3000>
4000017c: 9109135a     	add	x26, x26, #0x244
40000180: b000007b     	adrp	x27, 0x4000d000 <__bss_start+0x3000>
40000184: 14000004     	b	0x40000194 <launch_kedit+0x13c>
40000188: 51004d08     	sub	w8, w8, #0x13
4000018c: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40000190: b9024d28     	str	w8, [x9, #0x24c]
40000194: aa1403e0     	mov	x0, x20
40000198: 94000ce3     	bl	0x40003524 <uart_puts>
4000019c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400001a0: 913ff400     	add	x0, x0, #0xffd
400001a4: 94000ce0     	bl	0x40003524 <uart_puts>
400001a8: aa1603e0     	mov	x0, x22
400001ac: 94000cde     	bl	0x40003524 <uart_puts>
400001b0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400001b4: 91296800     	add	x0, x0, #0xa5a
400001b8: aa1303e1     	mov	x1, x19
400001bc: 94000dea     	bl	0x40003964 <uart_printf>
400001c0: b9725268     	ldr	w8, [x19, #0x3250]
400001c4: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
400001c8: 9104f929     	add	x9, x9, #0x13e
400001cc: 7100011f     	cmp	w8, #0x0
400001d0: f0000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
400001d4: 9118d108     	add	x8, x8, #0x634
400001d8: 9a880120     	csel	x0, x9, x8, eq
400001dc: 94000cd2     	bl	0x40003524 <uart_puts>
400001e0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400001e4: 9137b400     	add	x0, x0, #0xded
400001e8: 94000ccf     	bl	0x40003524 <uart_puts>
400001ec: aa1f03f5     	mov	x21, xzr
400001f0: b9b24e68     	ldrsw	x8, [x19, #0x324c]
400001f4: b9724269     	ldr	w9, [x19, #0x3240]
400001f8: 8b0802a8     	add	x8, x21, x8
400001fc: 8b081e6a     	add	x10, x19, x8, lsl #7
40000200: 6b09011f     	cmp	w8, w9
40000204: 9101014a     	add	x10, x10, #0x40
40000208: 9a98b140     	csel	x0, x10, x24, lt
4000020c: 94000cc6     	bl	0x40003524 <uart_puts>
40000210: aa1903e0     	mov	x0, x25
40000214: 94000cc4     	bl	0x40003524 <uart_puts>
40000218: 910006b5     	add	x21, x21, #0x1
4000021c: 710052bf     	cmp	w21, #0x14
40000220: 54fffe81     	b.ne	0x400001f0 <launch_kedit+0x198>
40000224: aa1603e0     	mov	x0, x22
40000228: 94000cbf     	bl	0x40003524 <uart_puts>
4000022c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000230: 91060400     	add	x0, x0, #0x181
40000234: 94000cbc     	bl	0x40003524 <uart_puts>
40000238: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000023c: 91202800     	add	x0, x0, #0x80a
40000240: 94000cb9     	bl	0x40003524 <uart_puts>
40000244: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000248: 9110d000     	add	x0, x0, #0x434
4000024c: 94000cb6     	bl	0x40003524 <uart_puts>
40000250: 2940a349     	ldp	w9, w8, [x26, #0x4]
40000254: b940034a     	ldr	w10, [x26]
40000258: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000025c: 910e7c00     	add	x0, x0, #0x39f
40000260: 4b080128     	sub	w8, w9, w8
40000264: 11000542     	add	w2, w10, #0x1
40000268: 11000901     	add	w1, w8, #0x2
4000026c: 94000dbe     	bl	0x40003964 <uart_printf>
40000270: 94000ce0     	bl	0x400035f0 <uart_getc>
40000274: 12001c08     	and	w8, w0, #0xff
40000278: 2a0003f5     	mov	w21, w0
4000027c: 7100491f     	cmp	w8, #0x12
40000280: 5400010d     	b.le	0x400002a0 <launch_kedit+0x248>
40000284: 7100691f     	cmp	w8, #0x1a
40000288: 540009ed     	b.le	0x400003c4 <launch_kedit+0x36c>
4000028c: 71006d1f     	cmp	w8, #0x1b
40000290: 54000e40     	b.eq	0x40000458 <launch_kedit+0x400>
40000294: 7101fd1f     	cmp	w8, #0x7f
40000298: 540005e0     	b.eq	0x40000354 <launch_kedit+0x2fc>
4000029c: 1400008b     	b	0x400004c8 <launch_kedit+0x470>
400002a0: 7100211f     	cmp	w8, #0x8
400002a4: 54000580     	b.eq	0x40000354 <launch_kedit+0x2fc>
400002a8: 7100291f     	cmp	w8, #0xa
400002ac: 54000060     	b.eq	0x400002b8 <launch_kedit+0x260>
400002b0: 7100351f     	cmp	w8, #0xd
400002b4: 540010a1     	b.ne	0x400004c8 <launch_kedit+0x470>
400002b8: b98242f6     	ldrsw	x22, [x23, #0x240]
400002bc: 71018edf     	cmp	w22, #0x63
400002c0: 540014ac     	b.gt	0x40000554 <launch_kedit+0x4fc>
400002c4: b9824b68     	ldrsw	x8, [x27, #0x248]
400002c8: 6b0802df     	cmp	w22, w8
400002cc: 5400016d     	b.le	0x400002f8 <launch_kedit+0x2a0>
400002d0: 8b161e68     	add	x8, x19, x22, lsl #7
400002d4: 91010100     	add	x0, x8, #0x40
400002d8: d1020015     	sub	x21, x0, #0x80
400002dc: d10006d6     	sub	x22, x22, #0x1
400002e0: aa1503e1     	mov	x1, x21
400002e4: 940008ea     	bl	0x4000268c <kstrcpy>
400002e8: b9824b68     	ldrsw	x8, [x27, #0x248]
400002ec: aa1503e0     	mov	x0, x21
400002f0: eb0802df     	cmp	x22, x8
400002f4: 54ffff2c     	b.gt	0x400002d8 <launch_kedit+0x280>
400002f8: d0000055     	adrp	x21, 0x4000a000 <__bss_start>
400002fc: 910102b5     	add	x21, x21, #0x40
40000300: 910023e0     	add	x0, sp, #0x8
40000304: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000308: 8b081ea8     	add	x8, x21, x8, lsl #7
4000030c: 8b090101     	add	x1, x8, x9
40000310: 940008df     	bl	0x4000268c <kstrcpy>
40000314: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000318: b9b206a9     	ldrsw	x9, [x21, #0x3204]
4000031c: 910023e1     	add	x1, sp, #0x8
40000320: 8b081ea8     	add	x8, x21, x8, lsl #7
40000324: 3829691f     	strb	wzr, [x8, x9]
40000328: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
4000032c: 91000508     	add	x8, x8, #0x1
40000330: 8b081ea0     	add	x0, x21, x8, lsl #7
40000334: b9320aa8     	str	w8, [x21, #0x3208]
40000338: 940008d5     	bl	0x4000268c <kstrcpy>
4000033c: b97202a8     	ldr	w8, [x21, #0x3200]
40000340: b93206bf     	str	wzr, [x21, #0x3204]
40000344: b93212bc     	str	w28, [x21, #0x3210]
40000348: 11000508     	add	w8, w8, #0x1
4000034c: b93202a8     	str	w8, [x21, #0x3200]
40000350: 14000081     	b	0x40000554 <launch_kedit+0x4fc>
40000354: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40000358: b9424508     	ldr	w8, [x8, #0x244]
4000035c: 7100051f     	cmp	w8, #0x1
40000360: 54000fab     	b.lt	0x40000554 <launch_kedit+0x4fc>
40000364: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000368: 8b081e68     	add	x8, x19, x8, lsl #7
4000036c: 91010100     	add	x0, x8, #0x40
40000370: 94000898     	bl	0x400025d0 <kstrlen>
40000374: b9724669     	ldr	w9, [x19, #0x3244]
40000378: 6b00013f     	cmp	w9, w0
4000037c: 51000528     	sub	w8, w9, #0x1
40000380: 540001cc     	b.gt	0x400003b8 <launch_kedit+0x360>
40000384: 8b28c268     	add	x8, x19, w8, sxtw
40000388: 4b090009     	sub	w9, w0, w9
4000038c: 11000529     	add	w9, w9, #0x1
40000390: b9824b6a     	ldrsw	x10, [x27, #0x248]
40000394: 71000529     	subs	w9, w9, #0x1
40000398: 8b0a1d0a     	add	x10, x8, x10, lsl #7
4000039c: 91000508     	add	x8, x8, #0x1
400003a0: 3941054b     	ldrb	w11, [x10, #0x41]
400003a4: 3901014b     	strb	w11, [x10, #0x40]
400003a8: 54ffff41     	b.ne	0x40000390 <launch_kedit+0x338>
400003ac: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
400003b0: b9424508     	ldr	w8, [x8, #0x244]
400003b4: 51000508     	sub	w8, w8, #0x1
400003b8: b9000348     	str	w8, [x26]
400003bc: b9000f5c     	str	w28, [x26, #0xc]
400003c0: 14000065     	b	0x40000554 <launch_kedit+0x4fc>
400003c4: 71004d1f     	cmp	w8, #0x13
400003c8: 540007c1     	b.ne	0x400004c0 <launch_kedit+0x468>
400003cc: b94242e8     	ldr	w8, [x23, #0x240]
400003d0: 390023ff     	strb	wzr, [sp, #0x8]
400003d4: 7100051f     	cmp	w8, #0x1
400003d8: 5400030b     	b.lt	0x40000438 <launch_kedit+0x3e0>
400003dc: aa1f03fc     	mov	x28, xzr
400003e0: 2a1f03f6     	mov	w22, wzr
400003e4: d0000055     	adrp	x21, 0x4000a000 <__bss_start>
400003e8: 910102b5     	add	x21, x21, #0x40
400003ec: 14000006     	b	0x40000404 <launch_kedit+0x3ac>
400003f0: b98242e8     	ldrsw	x8, [x23, #0x240]
400003f4: 9100079c     	add	x28, x28, #0x1
400003f8: 910202b5     	add	x21, x21, #0x80
400003fc: eb08039f     	cmp	x28, x8
40000400: 540001ca     	b.ge	0x40000438 <launch_kedit+0x3e0>
40000404: aa1503e0     	mov	x0, x21
40000408: 94000872     	bl	0x400025d0 <kstrlen>
4000040c: 0b0002d4     	add	w20, w22, w0
40000410: 710ffa9f     	cmp	w20, #0x3fe
40000414: 54fffeec     	b.gt	0x400003f0 <launch_kedit+0x398>
40000418: 910023e0     	add	x0, sp, #0x8
4000041c: aa1503e1     	mov	x1, x21
40000420: 94000873     	bl	0x400025ec <kstrcat>
40000424: 910023e0     	add	x0, sp, #0x8
40000428: aa1903e1     	mov	x1, x25
4000042c: 94000870     	bl	0x400025ec <kstrcat>
40000430: 11000696     	add	w22, w20, #0x1
40000434: 17ffffef     	b	0x400003f0 <launch_kedit+0x398>
40000438: 910023e1     	add	x1, sp, #0x8
4000043c: aa1303e0     	mov	x0, x19
40000440: 940012a0     	bl	0x40004ec0 <vfs_write_file>
40000444: b932527f     	str	wzr, [x19, #0x3250]
40000448: 5280003c     	mov	w28, #0x1               // =1
4000044c: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
40000450: 912c1a94     	add	x20, x20, #0xb06
40000454: 14000040     	b	0x40000554 <launch_kedit+0x4fc>
40000458: 94000c66     	bl	0x400035f0 <uart_getc>
4000045c: 12001c14     	and	w20, w0, #0xff
40000460: 94000c64     	bl	0x400035f0 <uart_getc>
40000464: 71016e9f     	cmp	w20, #0x5b
40000468: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
4000046c: 912c1a94     	add	x20, x20, #0xb06
40000470: 54000721     	b.ne	0x40000554 <launch_kedit+0x4fc>
40000474: 12001c09     	and	w9, w0, #0xff
40000478: b9424b68     	ldr	w8, [x27, #0x248]
4000047c: 7101053f     	cmp	w9, #0x41
40000480: 54000801     	b.ne	0x40000580 <launch_kedit+0x528>
40000484: 7100011f     	cmp	w8, #0x0
40000488: 540007cd     	b.le	0x40000580 <launch_kedit+0x528>
4000048c: 12800009     	mov	w9, #-0x1               // =-1
40000490: 0b090108     	add	w8, w8, w9
40000494: b9024b68     	str	w8, [x27, #0x248]
40000498: 93407d08     	sxtw	x8, w8
4000049c: 8b081e68     	add	x8, x19, x8, lsl #7
400004a0: 91010100     	add	x0, x8, #0x40
400004a4: 9400084b     	bl	0x400025d0 <kstrlen>
400004a8: b9724668     	ldr	w8, [x19, #0x3244]
400004ac: 6b00011f     	cmp	w8, w0
400004b0: 5400052d     	b.le	0x40000554 <launch_kedit+0x4fc>
400004b4: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
400004b8: b9024500     	str	w0, [x8, #0x244]
400004bc: 14000026     	b	0x40000554 <launch_kedit+0x4fc>
400004c0: 7100611f     	cmp	w8, #0x18
400004c4: 54000ac0     	b.eq	0x4000061c <launch_kedit+0x5c4>
400004c8: 510082a8     	sub	w8, w21, #0x20
400004cc: 12001d08     	and	w8, w8, #0xff
400004d0: 7101791f     	cmp	w8, #0x5e
400004d4: 54000408     	b.hi	0x40000554 <launch_kedit+0x4fc>
400004d8: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
400004dc: b9424508     	ldr	w8, [x8, #0x244]
400004e0: 7101f91f     	cmp	w8, #0x7e
400004e4: 5400038c     	b.gt	0x40000554 <launch_kedit+0x4fc>
400004e8: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400004ec: 8b081e68     	add	x8, x19, x8, lsl #7
400004f0: 91010100     	add	x0, x8, #0x40
400004f4: 94000837     	bl	0x400025d0 <kstrlen>
400004f8: b9b24668     	ldrsw	x8, [x19, #0x3244]
400004fc: 6b00011f     	cmp	w8, w0
40000500: 540001ac     	b.gt	0x40000534 <launch_kedit+0x4dc>
40000504: 93407c08     	sxtw	x8, w0
40000508: 91000509     	add	x9, x8, #0x1
4000050c: 8b08026a     	add	x10, x19, x8
40000510: b9800748     	ldrsw	x8, [x26, #0x4]
40000514: d1000529     	sub	x9, x9, #0x1
40000518: 8b081d48     	add	x8, x10, x8, lsl #7
4000051c: d100054a     	sub	x10, x10, #0x1
40000520: 3941010b     	ldrb	w11, [x8, #0x40]
40000524: 3901050b     	strb	w11, [x8, #0x41]
40000528: b9800348     	ldrsw	x8, [x26]
4000052c: eb08013f     	cmp	x9, x8
40000530: 54ffff0c     	b.gt	0x40000510 <launch_kedit+0x4b8>
40000534: b9b24a69     	ldrsw	x9, [x19, #0x3248]
40000538: 8b091e69     	add	x9, x19, x9, lsl #7
4000053c: 8b080128     	add	x8, x9, x8
40000540: 39010115     	strb	w21, [x8, #0x40]
40000544: b9724668     	ldr	w8, [x19, #0x3244]
40000548: b932527c     	str	w28, [x19, #0x3250]
4000054c: 11000508     	add	w8, w8, #0x1
40000550: b9324668     	str	w8, [x19, #0x3244]
40000554: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40000558: 91092129     	add	x9, x9, #0x248
4000055c: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
40000560: 91030ad6     	add	x22, x22, #0xc2
40000564: 29402528     	ldp	w8, w9, [x9]
40000568: 6b09011f     	cmp	w8, w9
4000056c: 54ffe10b     	b.lt	0x4000018c <launch_kedit+0x134>
40000570: 11005129     	add	w9, w9, #0x14
40000574: 6b09011f     	cmp	w8, w9
40000578: 54ffe0eb     	b.lt	0x40000194 <launch_kedit+0x13c>
4000057c: 17ffff03     	b	0x40000188 <launch_kedit+0x130>
40000580: 71010d3f     	cmp	w9, #0x43
40000584: 54000120     	b.eq	0x400005a8 <launch_kedit+0x550>
40000588: 7101093f     	cmp	w9, #0x42
4000058c: 540002a1     	b.ne	0x400005e0 <launch_kedit+0x588>
40000590: b94242e9     	ldr	w9, [x23, #0x240]
40000594: 51000529     	sub	w9, w9, #0x1
40000598: 6b09011f     	cmp	w8, w9
4000059c: 54fff7ea     	b.ge	0x40000498 <launch_kedit+0x440>
400005a0: 52800029     	mov	w9, #0x1                // =1
400005a4: 17ffffbb     	b	0x40000490 <launch_kedit+0x438>
400005a8: 93407d08     	sxtw	x8, w8
400005ac: b9b24674     	ldrsw	x20, [x19, #0x3244]
400005b0: 8b081e68     	add	x8, x19, x8, lsl #7
400005b4: 91010100     	add	x0, x8, #0x40
400005b8: 94000806     	bl	0x400025d0 <kstrlen>
400005bc: eb14001f     	cmp	x0, x20
400005c0: d0000034     	adrp	x20, 0x40006000 <__rodata_start>
400005c4: 912c1a94     	add	x20, x20, #0xb06
400005c8: 54fffc69     	b.ls	0x40000554 <launch_kedit+0x4fc>
400005cc: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
400005d0: b9424528     	ldr	w8, [x9, #0x244]
400005d4: 11000508     	add	w8, w8, #0x1
400005d8: b9024528     	str	w8, [x9, #0x244]
400005dc: 17ffffde     	b	0x40000554 <launch_kedit+0x4fc>
400005e0: 12001c09     	and	w9, w0, #0xff
400005e4: 7101113f     	cmp	w9, #0x44
400005e8: 54000101     	b.ne	0x40000608 <launch_kedit+0x5b0>
400005ec: b0000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
400005f0: b9424529     	ldr	w9, [x9, #0x244]
400005f4: 71000529     	subs	w9, w9, #0x1
400005f8: 5400008b     	b.lt	0x40000608 <launch_kedit+0x5b0>
400005fc: b0000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40000600: b9024509     	str	w9, [x8, #0x244]
40000604: 17ffffd4     	b	0x40000554 <launch_kedit+0x4fc>
40000608: 51010409     	sub	w9, w0, #0x41
4000060c: 12001d29     	and	w9, w9, #0xff
40000610: 7100093f     	cmp	w9, #0x2
40000614: 54fff423     	b.lo	0x40000498 <launch_kedit+0x440>
40000618: 17ffffcf     	b	0x40000554 <launch_kedit+0x4fc>
4000061c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000620: 91180000     	add	x0, x0, #0x600
40000624: 94000bc0     	bl	0x40003524 <uart_puts>
40000628: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000062c: 91188800     	add	x0, x0, #0x622
40000630: 94000bbd     	bl	0x40003524 <uart_puts>
40000634: 911043ff     	add	sp, sp, #0x410
40000638: a9454ff4     	ldp	x20, x19, [sp, #0x50]
4000063c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40000640: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40000644: a94267fa     	ldp	x26, x25, [sp, #0x20]
40000648: a9416ffc     	ldp	x28, x27, [sp, #0x10]
4000064c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40000650: d65f03c0     	ret

0000000040000654 <print_banner>:
40000654: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000658: d503201f     	nop
4000065c: 30034d00     	adr	x0, 0x40006ffd <__rodata_start+0xffd>
40000660: 910003fd     	mov	x29, sp
40000664: 94000bb0     	bl	0x40003524 <uart_puts>
40000668: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000066c: 9110c800     	add	x0, x0, #0x432
40000670: 94000bad     	bl	0x40003524 <uart_puts>
40000674: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000678: 9106b800     	add	x0, x0, #0x1ae
4000067c: 94000baa     	bl	0x40003524 <uart_puts>
40000680: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000684: 91190400     	add	x0, x0, #0x641
40000688: 94000ba7     	bl	0x40003524 <uart_puts>
4000068c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000690: 9129d400     	add	x0, x0, #0xa75
40000694: 94000ba4     	bl	0x40003524 <uart_puts>
40000698: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000069c: 91000000     	add	x0, x0, #0x0
400006a0: 94000ba1     	bl	0x40003524 <uart_puts>
400006a4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006a8: 912ac000     	add	x0, x0, #0xab0
400006ac: 94000b9e     	bl	0x40003524 <uart_puts>
400006b0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006b4: 913d5000     	add	x0, x0, #0xf54
400006b8: 94000b9b     	bl	0x40003524 <uart_puts>
400006bc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400006c0: 9137cc00     	add	x0, x0, #0xdf3
400006c4: 94000ca8     	bl	0x40003964 <uart_printf>
400006c8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006cc: 9110ec00     	add	x0, x0, #0x43b
400006d0: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
400006d4: 9114a421     	add	x1, x1, #0x529
400006d8: 94000ca3     	bl	0x40003964 <uart_printf>
400006dc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006e0: 9131f400     	add	x0, x0, #0xc7d
400006e4: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400006e8: 912bb021     	add	x1, x1, #0xaec
400006ec: 94000c9e     	bl	0x40003964 <uart_printf>
400006f0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006f4: 91203c00     	add	x0, x0, #0x80f
400006f8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400006fc: 14000b8a     	b	0x40003524 <uart_puts>

0000000040000700 <print_about>:
40000700: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000704: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000708: 9107fc00     	add	x0, x0, #0x1ff
4000070c: 910003fd     	mov	x29, sp
40000710: 94000b85     	bl	0x40003524 <uart_puts>
40000714: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000718: 910c9c00     	add	x0, x0, #0x327
4000071c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000720: 912bf421     	add	x1, x1, #0xafd
40000724: 94000c90     	bl	0x40003964 <uart_printf>
40000728: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000072c: 9122f000     	add	x0, x0, #0x8bc
40000730: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000734: 9114a421     	add	x1, x1, #0x529
40000738: 94000c8b     	bl	0x40003964 <uart_printf>
4000073c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000740: 91052c00     	add	x0, x0, #0x14b
40000744: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000748: 912bb021     	add	x1, x1, #0xaec
4000074c: 94000c86     	bl	0x40003964 <uart_printf>
40000750: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000754: 91333400     	add	x0, x0, #0xccd
40000758: 94000b73     	bl	0x40003524 <uart_puts>
4000075c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000760: 911db400     	add	x0, x0, #0x76d
40000764: 94000b70     	bl	0x40003524 <uart_puts>
40000768: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000076c: 9110c800     	add	x0, x0, #0x432
40000770: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000774: 14000b6c     	b	0x40003524 <uart_puts>

0000000040000778 <print_sysinfo>:
40000778: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000077c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000780: 913c8c00     	add	x0, x0, #0xf23
40000784: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000788: 910003fd     	mov	x29, sp
4000078c: d5384248     	mrs	x8, CurrentEL
40000790: d3420d13     	ubfx	x19, x8, #2, #2
40000794: d5380014     	mrs	x20, MIDR_EL1
40000798: 94000b63     	bl	0x40003524 <uart_puts>
4000079c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007a0: 911d4800     	add	x0, x0, #0x752
400007a4: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400007a8: 912bf421     	add	x1, x1, #0xafd
400007ac: d0000022     	adrp	x2, 0x40006000 <__rodata_start>
400007b0: 9114a442     	add	x2, x2, #0x529
400007b4: 94000c6c     	bl	0x40003964 <uart_printf>
400007b8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007bc: 911dc400     	add	x0, x0, #0x771
400007c0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400007c4: 912bb021     	add	x1, x1, #0xaec
400007c8: 94000c67     	bl	0x40003964 <uart_printf>
400007cc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400007d0: 91264000     	add	x0, x0, #0x990
400007d4: 94000c64     	bl	0x40003964 <uart_printf>
400007d8: f0000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
400007dc: 913fd508     	add	x8, x8, #0xff5
400007e0: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
400007e4: 91340929     	add	x9, x9, #0xd02
400007e8: f1000a7f     	cmp	x19, #0x2
400007ec: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400007f0: 91151000     	add	x0, x0, #0x544
400007f4: 9a880128     	csel	x8, x9, x8, eq
400007f8: f100067f     	cmp	x19, #0x1
400007fc: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40000800: 9119f129     	add	x9, x9, #0x67c
40000804: 2a1303e1     	mov	w1, w19
40000808: 9a880122     	csel	x2, x9, x8, eq
4000080c: 94000c56     	bl	0x40003964 <uart_printf>
40000810: 53187e81     	lsr	w1, w20, #24
40000814: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000818: 910d0000     	add	x0, x0, #0x340
4000081c: aa1403e2     	mov	x2, x20
40000820: 94000c51     	bl	0x40003964 <uart_printf>
40000824: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000828: 9122c400     	add	x0, x0, #0x8b1
4000082c: d503201f     	nop
40000830: 10ffbe81     	adr	x1, 0x40000000 <_start>
40000834: 94000c4c     	bl	0x40003964 <uart_printf>
40000838: d503201f     	nop
4000083c: 10ffbe21     	adr	x1, 0x40000000 <_start>
40000840: d503201f     	nop
40000844: 10024322     	adr	x2, 0x400050a8 <__text_end>
40000848: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000084c: 912c3400     	add	x0, x0, #0xb0d
40000850: cb010043     	sub	x3, x2, x1
40000854: 94000c44     	bl	0x40003964 <uart_printf>
40000858: d503201f     	nop
4000085c: 1002bd21     	adr	x1, 0x40006000 <__rodata_start>
40000860: d503201f     	nop
40000864: 1003d222     	adr	x2, 0x400082a8 <__rodata_end>
40000868: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000086c: 9117c400     	add	x0, x0, #0x5f1
40000870: cb010043     	sub	x3, x2, x1
40000874: 94000c3c     	bl	0x40003964 <uart_printf>
40000878: d503201f     	nop
4000087c: 10043c21     	adr	x1, 0x40009000 <next_pid>
40000880: d503201f     	nop
40000884: 101c1862     	adr	x2, 0x40038b90
40000888: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000088c: 9127f000     	add	x0, x0, #0x9fc
40000890: cb010043     	sub	x3, x2, x1
40000894: 94000c34     	bl	0x40003964 <uart_printf>
40000898: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000089c: 91395400     	add	x0, x0, #0xe55
400008a0: d503201f     	nop
400008a4: 10241761     	adr	x1, 0x40048b90 <__stack_top>
400008a8: 94000c2f     	bl	0x40003964 <uart_printf>
400008ac: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400008b0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008b4: 9110c800     	add	x0, x0, #0x432
400008b8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400008bc: 14000b1a     	b	0x40003524 <uart_puts>

00000000400008c0 <print_android_roadmap>:
400008c0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400008c4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008c8: 91343400     	add	x0, x0, #0xd0d
400008cc: 910003fd     	mov	x29, sp
400008d0: 94000b15     	bl	0x40003524 <uart_puts>
400008d4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008d8: 91232c00     	add	x0, x0, #0x8cb
400008dc: 94000b12     	bl	0x40003524 <uart_puts>
400008e0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400008e4: 91159400     	add	x0, x0, #0x565
400008e8: 94000b0f     	bl	0x40003524 <uart_puts>
400008ec: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400008f0: 911e2c00     	add	x0, x0, #0x78b
400008f4: 94000b0c     	bl	0x40003524 <uart_puts>
400008f8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400008fc: 91186c00     	add	x0, x0, #0x61b
40000900: 94000b09     	bl	0x40003524 <uart_puts>
40000904: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000908: 91001400     	add	x0, x0, #0x5
4000090c: 94000b06     	bl	0x40003524 <uart_puts>
40000910: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000914: 912cdc00     	add	x0, x0, #0xb37
40000918: 94000b03     	bl	0x40003524 <uart_puts>
4000091c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000920: 91000400     	add	x0, x0, #0x1
40000924: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000928: 14000aff     	b	0x40003524 <uart_puts>

000000004000092c <read_line>:
4000092c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000930: f9000bf7     	str	x23, [sp, #0x10]
40000934: aa1f03f7     	mov	x23, xzr
40000938: 910003fd     	mov	x29, sp
4000093c: a90257f6     	stp	x22, x21, [sp, #0x20]
40000940: d1000435     	sub	x21, x1, #0x1
40000944: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000948: aa0003f3     	mov	x19, x0
4000094c: 90000054     	adrp	x20, 0x40008000 <__rodata_start+0x2000>
40000950: 91053e94     	add	x20, x20, #0x14f
40000954: aa1703f6     	mov	x22, x23
40000958: 94000b26     	bl	0x400035f0 <uart_getc>
4000095c: 12001c08     	and	w8, w0, #0xff
40000960: 7100311f     	cmp	w8, #0xc
40000964: 540000cc     	b.gt	0x4000097c <read_line+0x50>
40000968: 7100211f     	cmp	w8, #0x8
4000096c: 54000240     	b.eq	0x400009b4 <read_line+0x88>
40000970: 7100291f     	cmp	w8, #0xa
40000974: 540000c1     	b.ne	0x4000098c <read_line+0x60>
40000978: 14000015     	b	0x400009cc <read_line+0xa0>
4000097c: 7100351f     	cmp	w8, #0xd
40000980: 54000260     	b.eq	0x400009cc <read_line+0xa0>
40000984: 7101fd1f     	cmp	w8, #0x7f
40000988: 54000160     	b.eq	0x400009b4 <read_line+0x88>
4000098c: 51008008     	sub	w8, w0, #0x20
40000990: 12001d08     	and	w8, w8, #0xff
40000994: 7101791f     	cmp	w8, #0x5e
40000998: 54fffe08     	b.hi	0x40000958 <read_line+0x2c>
4000099c: eb1502df     	cmp	x22, x21
400009a0: 54fffdc2     	b.hs	0x40000958 <read_line+0x2c>
400009a4: 910006d7     	add	x23, x22, #0x1
400009a8: 38366a60     	strb	w0, [x19, x22]
400009ac: 94000ac7     	bl	0x400034c8 <uart_putc>
400009b0: 17ffffe9     	b	0x40000954 <read_line+0x28>
400009b4: aa1f03f7     	mov	x23, xzr
400009b8: b4fffcf6     	cbz	x22, 0x40000954 <read_line+0x28>
400009bc: aa1403e0     	mov	x0, x20
400009c0: d10006d7     	sub	x23, x22, #0x1
400009c4: 94000ad8     	bl	0x40003524 <uart_puts>
400009c8: 17ffffe3     	b	0x40000954 <read_line+0x28>
400009cc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400009d0: 9139d400     	add	x0, x0, #0xe75
400009d4: 94000ad4     	bl	0x40003524 <uart_puts>
400009d8: 38366a7f     	strb	wzr, [x19, x22]
400009dc: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400009e0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400009e4: f9400bf7     	ldr	x23, [sp, #0x10]
400009e8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400009ec: d65f03c0     	ret

00000000400009f0 <print_help>:
400009f0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009f4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400009f8: 911a2000     	add	x0, x0, #0x688
400009fc: 910003fd     	mov	x29, sp
40000a00: 94000ac9     	bl	0x40003524 <uart_puts>
40000a04: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a08: 91126c00     	add	x0, x0, #0x49b
40000a0c: 94000ac6     	bl	0x40003524 <uart_puts>
40000a10: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a14: 911eb400     	add	x0, x0, #0x7ad
40000a18: 94000ac3     	bl	0x40003524 <uart_puts>
40000a1c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a20: 9139e000     	add	x0, x0, #0xe78
40000a24: 94000ac0     	bl	0x40003524 <uart_puts>
40000a28: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a2c: 913d1c00     	add	x0, x0, #0xf47
40000a30: 94000abd     	bl	0x40003524 <uart_puts>
40000a34: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a38: 912c2000     	add	x0, x0, #0xb08
40000a3c: 94000aba     	bl	0x40003524 <uart_puts>
40000a40: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000a44: 91013000     	add	x0, x0, #0x4c
40000a48: 94000ab7     	bl	0x40003524 <uart_puts>
40000a4c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a50: 91199800     	add	x0, x0, #0x666
40000a54: 94000ab4     	bl	0x40003524 <uart_puts>
40000a58: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a5c: 91121c00     	add	x0, x0, #0x487
40000a60: 94000ab1     	bl	0x40003524 <uart_puts>
40000a64: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000a68: 91024800     	add	x0, x0, #0x92
40000a6c: 94000aae     	bl	0x40003524 <uart_puts>
40000a70: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a74: 91132000     	add	x0, x0, #0x4c8
40000a78: 94000aab     	bl	0x40003524 <uart_puts>
40000a7c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a80: 912df800     	add	x0, x0, #0xb7e
40000a84: 94000aa8     	bl	0x40003524 <uart_puts>
40000a88: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000a8c: 91031c00     	add	x0, x0, #0xc7
40000a90: 94000aa5     	bl	0x40003524 <uart_puts>
40000a94: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000a98: 91351400     	add	x0, x0, #0xd45
40000a9c: 94000aa2     	bl	0x40003524 <uart_puts>
40000aa0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000aa4: 911fa400     	add	x0, x0, #0x7e9
40000aa8: 94000a9f     	bl	0x40003524 <uart_puts>
40000aac: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ab0: 91243000     	add	x0, x0, #0x90c
40000ab4: 94000a9c     	bl	0x40003524 <uart_puts>
40000ab8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000abc: 913db800     	add	x0, x0, #0xf6e
40000ac0: 94000a99     	bl	0x40003524 <uart_puts>
40000ac4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ac8: 910d9c00     	add	x0, x0, #0x367
40000acc: 94000a96     	bl	0x40003524 <uart_puts>
40000ad0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000ad4: 91054c00     	add	x0, x0, #0x153
40000ad8: 94000a93     	bl	0x40003524 <uart_puts>
40000adc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ae0: 9107a400     	add	x0, x0, #0x1e9
40000ae4: 94000a90     	bl	0x40003524 <uart_puts>
40000ae8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000aec: 91088400     	add	x0, x0, #0x221
40000af0: 94000a8d     	bl	0x40003524 <uart_puts>
40000af4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000af8: 91014c00     	add	x0, x0, #0x53
40000afc: 94000a8a     	bl	0x40003524 <uart_puts>
40000b00: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b04: 9135f800     	add	x0, x0, #0xd7e
40000b08: 94000a87     	bl	0x40003524 <uart_puts>
40000b0c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b10: 91142800     	add	x0, x0, #0x50a
40000b14: 94000a84     	bl	0x40003524 <uart_puts>
40000b18: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b1c: 9108b400     	add	x0, x0, #0x22d
40000b20: 94000a81     	bl	0x40003524 <uart_puts>
40000b24: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b28: 910ea000     	add	x0, x0, #0x3a8
40000b2c: 94000a7e     	bl	0x40003524 <uart_puts>
40000b30: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b34: 91067000     	add	x0, x0, #0x19c
40000b38: 94000a7b     	bl	0x40003524 <uart_puts>
40000b3c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b40: 911a6800     	add	x0, x0, #0x69a
40000b44: 94000a78     	bl	0x40003524 <uart_puts>
40000b48: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b4c: 912ea800     	add	x0, x0, #0xbaa
40000b50: 94000a75     	bl	0x40003524 <uart_puts>
40000b54: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b58: 9103e400     	add	x0, x0, #0xf9
40000b5c: 94000a72     	bl	0x40003524 <uart_puts>
40000b60: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b64: 91370000     	add	x0, x0, #0xdc0
40000b68: 94000a6f     	bl	0x40003524 <uart_puts>
40000b6c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b70: 91250400     	add	x0, x0, #0x941
40000b74: 94000a6c     	bl	0x40003524 <uart_puts>
40000b78: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b7c: 910ec400     	add	x0, x0, #0x3b1
40000b80: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000b84: 14000a68     	b	0x40003524 <uart_puts>

0000000040000b88 <execute_command>:
40000b88: d104c3ff     	sub	sp, sp, #0x130
40000b8c: a9124ff4     	stp	x20, x19, [sp, #0x120]
40000b90: aa0003f3     	mov	x19, x0
40000b94: aa1f03e8     	mov	x8, xzr
40000b98: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
40000b9c: 910383fd     	add	x29, sp, #0xe0
40000ba0: f9007bfc     	str	x28, [sp, #0xf0]
40000ba4: a9105ff8     	stp	x24, x23, [sp, #0x100]
40000ba8: a91157f6     	stp	x22, x21, [sp, #0x110]
40000bac: 38686a6a     	ldrb	w10, [x19, x8]
40000bb0: 91000508     	add	x8, x8, #0x1
40000bb4: 7100815f     	cmp	w10, #0x20
40000bb8: 54ffffa0     	b.eq	0x40000bac <execute_command+0x24>
40000bbc: aa1f03e9     	mov	x9, xzr
40000bc0: d10083ab     	sub	x11, x29, #0x20
40000bc4: 340001aa     	cbz	w10, 0x40000bf8 <execute_command+0x70>
40000bc8: f100793f     	cmp	x9, #0x1e
40000bcc: 54000168     	b.hi	0x40000bf8 <execute_command+0x70>
40000bd0: 8b09026c     	add	x12, x19, x9
40000bd4: 3829696a     	strb	w10, [x11, x9]
40000bd8: 3868698a     	ldrb	w10, [x12, x8]
40000bdc: 9100052c     	add	x12, x9, #0x1
40000be0: aa0c03e9     	mov	x9, x12
40000be4: 7100815f     	cmp	w10, #0x20
40000be8: 54fffee1     	b.ne	0x40000bc4 <execute_command+0x3c>
40000bec: 8b0c0108     	add	x8, x8, x12
40000bf0: aa0c03e9     	mov	x9, x12
40000bf4: 14000002     	b	0x40000bfc <execute_command+0x74>
40000bf8: 8b090108     	add	x8, x8, x9
40000bfc: d1000508     	sub	x8, x8, #0x1
40000c00: d10083aa     	sub	x10, x29, #0x20
40000c04: 8b080268     	add	x8, x19, x8
40000c08: 3829695f     	strb	wzr, [x10, x9]
40000c0c: 38401509     	ldrb	w9, [x8], #0x1
40000c10: 7100813f     	cmp	w9, #0x20
40000c14: 54ffffc0     	b.eq	0x40000c0c <execute_command+0x84>
40000c18: 35000069     	cbnz	w9, 0x40000c24 <execute_command+0x9c>
40000c1c: aa1f03ec     	mov	x12, xzr
40000c20: 1400000a     	b	0x40000c48 <execute_command+0xc0>
40000c24: aa1f03ea     	mov	x10, xzr
40000c28: 910103eb     	add	x11, sp, #0x40
40000c2c: 382a6969     	strb	w9, [x11, x10]
40000c30: 386a6909     	ldrb	w9, [x8, x10]
40000c34: 9100054c     	add	x12, x10, #0x1
40000c38: 34000089     	cbz	w9, 0x40000c48 <execute_command+0xc0>
40000c3c: f101f95f     	cmp	x10, #0x7e
40000c40: aa0c03ea     	mov	x10, x12
40000c44: 54ffff43     	b.lo	0x40000c2c <execute_command+0xa4>
40000c48: 910103e8     	add	x8, sp, #0x40
40000c4c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000c50: 91185c21     	add	x1, x1, #0x617
40000c54: d10083a0     	sub	x0, x29, #0x20
40000c58: 382c691f     	strb	wzr, [x8, x12]
40000c5c: 9400066d     	bl	0x40002610 <kstrcmp>
40000c60: 34001400     	cbz	w0, 0x40000ee0 <execute_command+0x358>
40000c64: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000c68: 9122c821     	add	x1, x1, #0x8b2
40000c6c: d10083a0     	sub	x0, x29, #0x20
40000c70: 94000668     	bl	0x40002610 <kstrcmp>
40000c74: 340013a0     	cbz	w0, 0x40000ee8 <execute_command+0x360>
40000c78: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000c7c: 913e8421     	add	x1, x1, #0xfa1
40000c80: d10083a0     	sub	x0, x29, #0x20
40000c84: 94000663     	bl	0x40002610 <kstrcmp>
40000c88: 34001680     	cbz	w0, 0x40000f58 <execute_command+0x3d0>
40000c8c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000c90: 91253021     	add	x1, x1, #0x94c
40000c94: d10083a0     	sub	x0, x29, #0x20
40000c98: 9400065e     	bl	0x40002610 <kstrcmp>
40000c9c: 34001800     	cbz	w0, 0x40000f9c <execute_command+0x414>
40000ca0: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000ca4: 910a7c21     	add	x1, x1, #0x29f
40000ca8: d10083a0     	sub	x0, x29, #0x20
40000cac: 94000659     	bl	0x40002610 <kstrcmp>
40000cb0: 34001860     	cbz	w0, 0x40000fbc <execute_command+0x434>
40000cb4: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000cb8: 91203021     	add	x1, x1, #0x80c
40000cbc: d10083a0     	sub	x0, x29, #0x20
40000cc0: 94000654     	bl	0x40002610 <kstrcmp>
40000cc4: 34001900     	cbz	w0, 0x40000fe4 <execute_command+0x45c>
40000cc8: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000ccc: 91270421     	add	x1, x1, #0x9c1
40000cd0: d10083a0     	sub	x0, x29, #0x20
40000cd4: 9400064f     	bl	0x40002610 <kstrcmp>
40000cd8: 34001960     	cbz	w0, 0x40001004 <execute_command+0x47c>
40000cdc: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000ce0: 91394821     	add	x1, x1, #0xe52
40000ce4: d10083a0     	sub	x0, x29, #0x20
40000ce8: 9400064a     	bl	0x40002610 <kstrcmp>
40000cec: 34001880     	cbz	w0, 0x40000ffc <execute_command+0x474>
40000cf0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000cf4: 911b7021     	add	x1, x1, #0x6dc
40000cf8: d10083a0     	sub	x0, x29, #0x20
40000cfc: 94000645     	bl	0x40002610 <kstrcmp>
40000d00: 340017e0     	cbz	w0, 0x40000ffc <execute_command+0x474>
40000d04: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000d08: 9125c821     	add	x1, x1, #0x972
40000d0c: d10083a0     	sub	x0, x29, #0x20
40000d10: 94000640     	bl	0x40002610 <kstrcmp>
40000d14: 34001960     	cbz	w0, 0x40001040 <execute_command+0x4b8>
40000d18: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000d1c: 9112d821     	add	x1, x1, #0x4b6
40000d20: d10083a0     	sub	x0, x29, #0x20
40000d24: 9400063b     	bl	0x40002610 <kstrcmp>
40000d28: 34001900     	cbz	w0, 0x40001048 <execute_command+0x4c0>
40000d2c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000d30: 91035421     	add	x1, x1, #0xd5
40000d34: d10083a0     	sub	x0, x29, #0x20
40000d38: 94000636     	bl	0x40002610 <kstrcmp>
40000d3c: 34001aa0     	cbz	w0, 0x40001090 <execute_command+0x508>
40000d40: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000d44: 910f9421     	add	x1, x1, #0x3e5
40000d48: d10083a0     	sub	x0, x29, #0x20
40000d4c: 94000631     	bl	0x40002610 <kstrcmp>
40000d50: 34001b80     	cbz	w0, 0x400010c0 <execute_command+0x538>
40000d54: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000d58: 9114a021     	add	x1, x1, #0x528
40000d5c: d10083a0     	sub	x0, x29, #0x20
40000d60: 9400062c     	bl	0x40002610 <kstrcmp>
40000d64: 34001dc0     	cbz	w0, 0x4000111c <execute_command+0x594>
40000d68: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000d6c: 9129c421     	add	x1, x1, #0xa71
40000d70: d10083a0     	sub	x0, x29, #0x20
40000d74: 94000627     	bl	0x40002610 <kstrcmp>
40000d78: 340020e0     	cbz	w0, 0x40001194 <execute_command+0x60c>
40000d7c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000d80: 9114bc21     	add	x1, x1, #0x52f
40000d84: d10083a0     	sub	x0, x29, #0x20
40000d88: 94000622     	bl	0x40002610 <kstrcmp>
40000d8c: 34001e20     	cbz	w0, 0x40001150 <execute_command+0x5c8>
40000d90: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000d94: 912d3021     	add	x1, x1, #0xb4c
40000d98: d10083a0     	sub	x0, x29, #0x20
40000d9c: 9400061d     	bl	0x40002610 <kstrcmp>
40000da0: 34001d80     	cbz	w0, 0x40001150 <execute_command+0x5c8>
40000da4: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000da8: 913aec21     	add	x1, x1, #0xebb
40000dac: d10083a0     	sub	x0, x29, #0x20
40000db0: 94000618     	bl	0x40002610 <kstrcmp>
40000db4: 340021a0     	cbz	w0, 0x400011e8 <execute_command+0x660>
40000db8: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000dbc: 910a8821     	add	x1, x1, #0x2a2
40000dc0: d10083a0     	sub	x0, x29, #0x20
40000dc4: 94000613     	bl	0x40002610 <kstrcmp>
40000dc8: 34002260     	cbz	w0, 0x40001214 <execute_command+0x68c>
40000dcc: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000dd0: 91059021     	add	x1, x1, #0x164
40000dd4: d10083a0     	sub	x0, x29, #0x20
40000dd8: 9400060e     	bl	0x40002610 <kstrcmp>
40000ddc: 34002340     	cbz	w0, 0x40001244 <execute_command+0x6bc>
40000de0: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000de4: 91107821     	add	x1, x1, #0x41e
40000de8: d10083a0     	sub	x0, x29, #0x20
40000dec: 94000609     	bl	0x40002610 <kstrcmp>
40000df0: 340023e0     	cbz	w0, 0x4000126c <execute_command+0x6e4>
40000df4: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000df8: 911c4021     	add	x1, x1, #0x710
40000dfc: d10083a0     	sub	x0, x29, #0x20
40000e00: 94000604     	bl	0x40002610 <kstrcmp>
40000e04: 34002520     	cbz	w0, 0x400012a8 <execute_command+0x720>
40000e08: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e0c: 91075821     	add	x1, x1, #0x1d6
40000e10: d10083a0     	sub	x0, x29, #0x20
40000e14: 940005ff     	bl	0x40002610 <kstrcmp>
40000e18: 34002720     	cbz	w0, 0x400012fc <execute_command+0x774>
40000e1c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e20: 9105a821     	add	x1, x1, #0x16a
40000e24: d10083a0     	sub	x0, x29, #0x20
40000e28: 940005fa     	bl	0x40002610 <kstrcmp>
40000e2c: 34002600     	cbz	w0, 0x400012ec <execute_command+0x764>
40000e30: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e34: 911c5821     	add	x1, x1, #0x716
40000e38: d10083a0     	sub	x0, x29, #0x20
40000e3c: 940005f5     	bl	0x40002610 <kstrcmp>
40000e40: 34002560     	cbz	w0, 0x400012ec <execute_command+0x764>
40000e44: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e48: 91109021     	add	x1, x1, #0x424
40000e4c: d10083a0     	sub	x0, x29, #0x20
40000e50: 940005f0     	bl	0x40002610 <kstrcmp>
40000e54: 34002aa0     	cbz	w0, 0x400013a8 <execute_command+0x820>
40000e58: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000e5c: 913eb021     	add	x1, x1, #0xfac
40000e60: d10083a0     	sub	x0, x29, #0x20
40000e64: 940005eb     	bl	0x40002610 <kstrcmp>
40000e68: 34002a00     	cbz	w0, 0x400013a8 <execute_command+0x820>
40000e6c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e70: 9102cc21     	add	x1, x1, #0xb3
40000e74: d10083a0     	sub	x0, x29, #0x20
40000e78: 940005e6     	bl	0x40002610 <kstrcmp>
40000e7c: 34002aa0     	cbz	w0, 0x400013d0 <execute_command+0x848>
40000e80: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000e84: 911f8c21     	add	x1, x1, #0x7e3
40000e88: d10083a0     	sub	x0, x29, #0x20
40000e8c: 940005e1     	bl	0x40002610 <kstrcmp>
40000e90: 34003080     	cbz	w0, 0x400014a0 <execute_command+0x918>
40000e94: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000e98: 9106f821     	add	x1, x1, #0x1be
40000e9c: d10083a0     	sub	x0, x29, #0x20
40000ea0: 940005dc     	bl	0x40002610 <kstrcmp>
40000ea4: 34002ee0     	cbz	w0, 0x40001480 <execute_command+0x8f8>
40000ea8: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000eac: 91399421     	add	x1, x1, #0xe65
40000eb0: d10083a0     	sub	x0, x29, #0x20
40000eb4: 940005d7     	bl	0x40002610 <kstrcmp>
40000eb8: 34002e40     	cbz	w0, 0x40001480 <execute_command+0x8f8>
40000ebc: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000ec0: 912a2821     	add	x1, x1, #0xa8a
40000ec4: d10083a0     	sub	x0, x29, #0x20
40000ec8: 940005d2     	bl	0x40002610 <kstrcmp>
40000ecc: 34002da0     	cbz	w0, 0x40001480 <execute_command+0x8f8>
40000ed0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ed4: 9139a800     	add	x0, x0, #0xe6a
40000ed8: d10083a1     	sub	x1, x29, #0x20
40000edc: 140000b4     	b	0x400011ac <execute_command+0x624>
40000ee0: 97fffec4     	bl	0x400009f0 <print_help>
40000ee4: 1400002f     	b	0x40000fa0 <execute_command+0x418>
40000ee8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000eec: 9107fc00     	add	x0, x0, #0x1ff
40000ef0: 9400098d     	bl	0x40003524 <uart_puts>
40000ef4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ef8: 910c9c00     	add	x0, x0, #0x327
40000efc: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f00: 912bf421     	add	x1, x1, #0xafd
40000f04: 94000a98     	bl	0x40003964 <uart_printf>
40000f08: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f0c: 9122f000     	add	x0, x0, #0x8bc
40000f10: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f14: 9114a421     	add	x1, x1, #0x529
40000f18: 94000a93     	bl	0x40003964 <uart_printf>
40000f1c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f20: 91052c00     	add	x0, x0, #0x14b
40000f24: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f28: 912bb021     	add	x1, x1, #0xaec
40000f2c: 94000a8e     	bl	0x40003964 <uart_printf>
40000f30: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f34: 91333400     	add	x0, x0, #0xccd
40000f38: 9400097b     	bl	0x40003524 <uart_puts>
40000f3c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f40: 911db400     	add	x0, x0, #0x76d
40000f44: 94000978     	bl	0x40003524 <uart_puts>
40000f48: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f4c: 9110c800     	add	x0, x0, #0x432
40000f50: 94000975     	bl	0x40003524 <uart_puts>
40000f54: 14000013     	b	0x40000fa0 <execute_command+0x418>
40000f58: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f5c: 912d6400     	add	x0, x0, #0xb59
40000f60: 94000971     	bl	0x40003524 <uart_puts>
40000f64: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f68: 91095000     	add	x0, x0, #0x254
40000f6c: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000f70: 9114a421     	add	x1, x1, #0x529
40000f74: 94000a7c     	bl	0x40003964 <uart_printf>
40000f78: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f7c: 91289800     	add	x0, x0, #0xa26
40000f80: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000f84: 912bb021     	add	x1, x1, #0xaec
40000f88: 94000a77     	bl	0x40003964 <uart_printf>
40000f8c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f90: 9104d400     	add	x0, x0, #0x135
40000f94: 94000964     	bl	0x40003524 <uart_puts>
40000f98: 14000002     	b	0x40000fa0 <execute_command+0x418>
40000f9c: 97fffdf7     	bl	0x40000778 <print_sysinfo>
40000fa0: a9524ff4     	ldp	x20, x19, [sp, #0x120]
40000fa4: f9407bfc     	ldr	x28, [sp, #0xf0]
40000fa8: a95157f6     	ldp	x22, x21, [sp, #0x110]
40000fac: a9505ff8     	ldp	x24, x23, [sp, #0x100]
40000fb0: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
40000fb4: 9104c3ff     	add	sp, sp, #0x130
40000fb8: d65f03c0     	ret
40000fbc: 910103e0     	add	x0, sp, #0x40
40000fc0: 94000584     	bl	0x400025d0 <kstrlen>
40000fc4: b4000260     	cbz	x0, 0x40001010 <execute_command+0x488>
40000fc8: 910103e0     	add	x0, sp, #0x40
40000fcc: 94000fbe     	bl	0x40004ec4 <vfs_remove>
40000fd0: 34000280     	cbz	w0, 0x40001020 <execute_command+0x498>
40000fd4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000fd8: 9138e000     	add	x0, x0, #0xe38
40000fdc: 94000952     	bl	0x40003524 <uart_puts>
40000fe0: 17fffff0     	b	0x40000fa0 <execute_command+0x418>
40000fe4: 910103e0     	add	x0, sp, #0x40
40000fe8: 9400057a     	bl	0x400025d0 <kstrlen>
40000fec: b4000220     	cbz	x0, 0x40001030 <execute_command+0x4a8>
40000ff0: 910103e0     	add	x0, sp, #0x40
40000ff4: 97fffc19     	bl	0x40000058 <launch_kedit>
40000ff8: 17ffffea     	b	0x40000fa0 <execute_command+0x418>
40000ffc: 94000675     	bl	0x400029d0 <tui_launch>
40001000: 17ffffe8     	b	0x40000fa0 <execute_command+0x418>
40001004: 910103e0     	add	x0, sp, #0x40
40001008: 940001dc     	bl	0x40001778 <kproj_execute>
4000100c: 17ffffe5     	b	0x40000fa0 <execute_command+0x418>
40001010: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001014: 9116c000     	add	x0, x0, #0x5b0
40001018: 94000943     	bl	0x40003524 <uart_puts>
4000101c: 17ffffe1     	b	0x40000fa0 <execute_command+0x418>
40001020: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001024: 911f6400     	add	x0, x0, #0x7d9
40001028: 9400093f     	bl	0x40003524 <uart_puts>
4000102c: 17ffffdd     	b	0x40000fa0 <execute_command+0x418>
40001030: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001034: 912f5c00     	add	x0, x0, #0xbd7
40001038: 9400093b     	bl	0x40003524 <uart_puts>
4000103c: 17ffffd9     	b	0x40000fa0 <execute_command+0x418>
40001040: 9400030f     	bl	0x40001c7c <launch_ktop>
40001044: 17ffffd7     	b	0x40000fa0 <execute_command+0x418>
40001048: 910103e0     	add	x0, sp, #0x40
4000104c: 94000561     	bl	0x400025d0 <kstrlen>
40001050: b40004c0     	cbz	x0, 0x400010e8 <execute_command+0x560>
40001054: 394103e8     	ldrb	w8, [sp, #0x40]
40001058: 5100c109     	sub	w9, w8, #0x30
4000105c: 7100253f     	cmp	w9, #0x9
40001060: 540004c8     	b.hi	0x400010f8 <execute_command+0x570>
40001064: 910103e9     	add	x9, sp, #0x40
40001068: 2a1f03f3     	mov	w19, wzr
4000106c: 5280014a     	mov	w10, #0xa               // =10
40001070: b2400129     	orr	x9, x9, #0x1
40001074: 1b0a226b     	madd	w11, w19, w10, w8
40001078: 38401528     	ldrb	w8, [x9], #0x1
4000107c: 5100c10c     	sub	w12, w8, #0x30
40001080: 7100299f     	cmp	w12, #0xa
40001084: 5100c173     	sub	w19, w11, #0x30
40001088: 54ffff63     	b.lo	0x40001074 <execute_command+0x4ec>
4000108c: 1400001c     	b	0x400010fc <execute_command+0x574>
40001090: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001094: 91204821     	add	x1, x1, #0x812
40001098: aa1303e0     	mov	x0, x19
4000109c: 94000614     	bl	0x400028ec <kstrstr>
400010a0: b4000460     	cbz	x0, 0x4000112c <execute_command+0x5a4>
400010a4: 3900001f     	strb	wzr, [x0]
400010a8: 38401c08     	ldrb	w8, [x0, #0x1]!
400010ac: 7100811f     	cmp	w8, #0x20
400010b0: 54ffffc0     	b.eq	0x400010a8 <execute_command+0x520>
400010b4: 91001661     	add	x1, x19, #0x5
400010b8: 94000f82     	bl	0x40004ec0 <vfs_write_file>
400010bc: 17ffffb9     	b	0x40000fa0 <execute_command+0x418>
400010c0: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400010c4: 913ea421     	add	x1, x1, #0xfa9
400010c8: 910103e0     	add	x0, sp, #0x40
400010cc: 94000551     	bl	0x40002610 <kstrcmp>
400010d0: 34000720     	cbz	w0, 0x400011b4 <execute_command+0x62c>
400010d4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400010d8: 9117b400     	add	x0, x0, #0x5ed
400010dc: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400010e0: 912bf421     	add	x1, x1, #0xafd
400010e4: 14000032     	b	0x400011ac <execute_command+0x624>
400010e8: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400010ec: 9109cc00     	add	x0, x0, #0x273
400010f0: 9400090d     	bl	0x40003524 <uart_puts>
400010f4: 17ffffab     	b	0x40000fa0 <execute_command+0x418>
400010f8: 2a1f03f3     	mov	w19, wzr
400010fc: 2a1303e0     	mov	w0, w19
40001100: 9400024a     	bl	0x40001a28 <process_kill>
40001104: 3100041f     	cmn	w0, #0x1
40001108: 540001a0     	b.eq	0x4000113c <execute_command+0x5b4>
4000110c: 35fff4a0     	cbnz	w0, 0x40000fa0 <execute_command+0x418>
40001110: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001114: 912fe800     	add	x0, x0, #0xbfa
40001118: 1400000b     	b	0x40001144 <execute_command+0x5bc>
4000111c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001120: 91303800     	add	x0, x0, #0xc0e
40001124: 94000900     	bl	0x40003524 <uart_puts>
40001128: 17ffff9e     	b	0x40000fa0 <execute_command+0x418>
4000112c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001130: 9117b400     	add	x0, x0, #0x5ed
40001134: 910103e1     	add	x1, sp, #0x40
40001138: 1400001d     	b	0x400011ac <execute_command+0x624>
4000113c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001140: 91171800     	add	x0, x0, #0x5c6
40001144: 2a1303e1     	mov	w1, w19
40001148: 94000a07     	bl	0x40003964 <uart_printf>
4000114c: 17ffff95     	b	0x40000fa0 <execute_command+0x418>
40001150: 94000d73     	bl	0x4000471c <vfs_get_cwd>
40001154: aa0003f3     	mov	x19, x0
40001158: 910103e0     	add	x0, sp, #0x40
4000115c: 9400051d     	bl	0x400025d0 <kstrlen>
40001160: b40003e0     	cbz	x0, 0x400011dc <execute_command+0x654>
40001164: 910103e0     	add	x0, sp, #0x40
40001168: 94000ddb     	bl	0x400048d4 <vfs_find>
4000116c: b40004c0     	cbz	x0, 0x40001204 <execute_command+0x67c>
40001170: b9402008     	ldr	w8, [x0, #0x20]
40001174: 35000368     	cbnz	w8, 0x400011e0 <execute_command+0x658>
40001178: b9402801     	ldr	w1, [x0, #0x28]
4000117c: d0000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
40001180: 91101908     	add	x8, x8, #0x406
40001184: aa0003e2     	mov	x2, x0
40001188: aa0803e0     	mov	x0, x8
4000118c: 940009f6     	bl	0x40003964 <uart_printf>
40001190: 17ffff84     	b	0x40000fa0 <execute_command+0x418>
40001194: 910003e0     	mov	x0, sp
40001198: 52800801     	mov	w1, #0x40               // =64
4000119c: 94000d63     	bl	0x40004728 <vfs_getcwd>
400011a0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400011a4: 9117b400     	add	x0, x0, #0x5ed
400011a8: 910003e1     	mov	x1, sp
400011ac: 940009ee     	bl	0x40003964 <uart_printf>
400011b0: 17ffff7c     	b	0x40000fa0 <execute_command+0x418>
400011b4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400011b8: 911b8400     	add	x0, x0, #0x6e1
400011bc: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400011c0: 912bf421     	add	x1, x1, #0xafd
400011c4: b0000022     	adrp	x2, 0x40006000 <__rodata_start>
400011c8: 9114a442     	add	x2, x2, #0x529
400011cc: d0000023     	adrp	x3, 0x40007000 <__rodata_start+0x1000>
400011d0: 912bb063     	add	x3, x3, #0xaec
400011d4: 940009e4     	bl	0x40003964 <uart_printf>
400011d8: 17ffff72     	b	0x40000fa0 <execute_command+0x418>
400011dc: aa1303e0     	mov	x0, x19
400011e0: 94000f72     	bl	0x40004fa8 <vfs_list_dir>
400011e4: 17ffff6f     	b	0x40000fa0 <execute_command+0x418>
400011e8: 910103e0     	add	x0, sp, #0x40
400011ec: 94000e1f     	bl	0x40004a68 <vfs_chdir>
400011f0: 34ffed80     	cbz	w0, 0x40000fa0 <execute_command+0x418>
400011f4: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400011f8: 91023c00     	add	x0, x0, #0x8f
400011fc: 910103e1     	add	x1, sp, #0x40
40001200: 17ffffeb     	b	0x400011ac <execute_command+0x624>
40001204: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001208: 910a1800     	add	x0, x0, #0x286
4000120c: 910103e1     	add	x1, sp, #0x40
40001210: 17ffffe7     	b	0x400011ac <execute_command+0x624>
40001214: 910103e0     	add	x0, sp, #0x40
40001218: 940004ee     	bl	0x400025d0 <kstrlen>
4000121c: b40003e0     	cbz	x0, 0x40001298 <execute_command+0x710>
40001220: 910103e0     	add	x0, sp, #0x40
40001224: 94000dac     	bl	0x400048d4 <vfs_find>
40001228: b4000060     	cbz	x0, 0x40001234 <execute_command+0x6ac>
4000122c: b9402008     	ldr	w8, [x0, #0x20]
40001230: 34000a28     	cbz	w8, 0x40001374 <execute_command+0x7ec>
40001234: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001238: 910a9800     	add	x0, x0, #0x2a6
4000123c: 940008ba     	bl	0x40003524 <uart_puts>
40001240: 17ffff58     	b	0x40000fa0 <execute_command+0x418>
40001244: 910103e0     	add	x0, sp, #0x40
40001248: 940004e2     	bl	0x400025d0 <kstrlen>
4000124c: b4000480     	cbz	x0, 0x400012dc <execute_command+0x754>
40001250: 910103e0     	add	x0, sp, #0x40
40001254: 94000e2a     	bl	0x40004afc <vfs_mkdir>
40001258: 34ffea40     	cbz	w0, 0x40000fa0 <execute_command+0x418>
4000125c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001260: 9130dc00     	add	x0, x0, #0xc37
40001264: 940008b0     	bl	0x40003524 <uart_puts>
40001268: 17ffff4e     	b	0x40000fa0 <execute_command+0x418>
4000126c: 910103e0     	add	x0, sp, #0x40
40001270: 940004d8     	bl	0x400025d0 <kstrlen>
40001274: b40008a0     	cbz	x0, 0x40001388 <execute_command+0x800>
40001278: 910103e0     	add	x0, sp, #0x40
4000127c: aa1f03e1     	mov	x1, xzr
40001280: 94000e75     	bl	0x40004c54 <vfs_touch>
40001284: 34ffe8e0     	cbz	w0, 0x40000fa0 <execute_command+0x418>
40001288: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000128c: 91395800     	add	x0, x0, #0xe56
40001290: 940008a5     	bl	0x40003524 <uart_puts>
40001294: 17ffff43     	b	0x40000fa0 <execute_command+0x418>
40001298: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000129c: 9137cc00     	add	x0, x0, #0xdf3
400012a0: 940008a1     	bl	0x40003524 <uart_puts>
400012a4: 17ffff3f     	b	0x40000fa0 <execute_command+0x418>
400012a8: 910103e0     	add	x0, sp, #0x40
400012ac: 52800401     	mov	w1, #0x20               // =32
400012b0: 940005aa     	bl	0x40002958 <kstrchr>
400012b4: b4000720     	cbz	x0, 0x40001398 <execute_command+0x810>
400012b8: aa0003e1     	mov	x1, x0
400012bc: 910103e0     	add	x0, sp, #0x40
400012c0: 3800143f     	strb	wzr, [x1], #0x1
400012c4: 94000eff     	bl	0x40004ec0 <vfs_write_file>
400012c8: 34ffe6c0     	cbz	w0, 0x40000fa0 <execute_command+0x418>
400012cc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400012d0: 910fac00     	add	x0, x0, #0x3eb
400012d4: 94000894     	bl	0x40003524 <uart_puts>
400012d8: 17ffff32     	b	0x40000fa0 <execute_command+0x418>
400012dc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400012e0: 910b0800     	add	x0, x0, #0x2c2
400012e4: 94000890     	bl	0x40003524 <uart_puts>
400012e8: 17ffff2e     	b	0x40000fa0 <execute_command+0x418>
400012ec: d503201f     	nop
400012f0: 3002e860     	adr	x0, 0x40006ffd <__rodata_start+0xffd>
400012f4: 9400088c     	bl	0x40003524 <uart_puts>
400012f8: 17ffff2a     	b	0x40000fa0 <execute_command+0x418>
400012fc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001300: 9110c800     	add	x0, x0, #0x432
40001304: 94000888     	bl	0x40003524 <uart_puts>
40001308: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000130c: 91271c00     	add	x0, x0, #0x9c7
40001310: 94000885     	bl	0x40003524 <uart_puts>
40001314: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001318: 9100ec00     	add	x0, x0, #0x3b
4000131c: 94000882     	bl	0x40003524 <uart_puts>
40001320: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001324: 91255000     	add	x0, x0, #0x954
40001328: 9400087f     	bl	0x40003524 <uart_puts>
4000132c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001330: 910fe800     	add	x0, x0, #0x3fa
40001334: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001338: 912bb021     	add	x1, x1, #0xaec
4000133c: 9400098a     	bl	0x40003964 <uart_printf>
40001340: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001344: 9114c800     	add	x0, x0, #0x532
40001348: 94000877     	bl	0x40003524 <uart_puts>
4000134c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001350: 91036800     	add	x0, x0, #0xda
40001354: 94000874     	bl	0x40003524 <uart_puts>
40001358: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000135c: 910b5c00     	add	x0, x0, #0x2d7
40001360: 94000871     	bl	0x40003524 <uart_puts>
40001364: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001368: 911b9000     	add	x0, x0, #0x6e4
4000136c: 9400086e     	bl	0x40003524 <uart_puts>
40001370: 17ffff0c     	b	0x40000fa0 <execute_command+0x418>
40001374: b0000028     	adrp	x8, 0x40006000 <__rodata_start>
40001378: 9117b508     	add	x8, x8, #0x5ed
4000137c: 9100c001     	add	x1, x0, #0x30
40001380: aa0803e0     	mov	x0, x8
40001384: 17ffff8a     	b	0x400011ac <execute_command+0x624>
40001388: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000138c: 9129d400     	add	x0, x0, #0xa75
40001390: 94000865     	bl	0x40003524 <uart_puts>
40001394: 17ffff03     	b	0x40000fa0 <execute_command+0x418>
40001398: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000139c: 912fc000     	add	x0, x0, #0xbf0
400013a0: 94000861     	bl	0x40003524 <uart_puts>
400013a4: 17fffeff     	b	0x40000fa0 <execute_command+0x418>
400013a8: 910103e0     	add	x0, sp, #0x40
400013ac: 94000489     	bl	0x400025d0 <kstrlen>
400013b0: b4000080     	cbz	x0, 0x400013c0 <execute_command+0x838>
400013b4: 910103e0     	add	x0, sp, #0x40
400013b8: 9400044e     	bl	0x400024f0 <script_run_file>
400013bc: 17fffef9     	b	0x40000fa0 <execute_command+0x418>
400013c0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400013c4: 91382800     	add	x0, x0, #0xe0a
400013c8: 94000857     	bl	0x40003524 <uart_puts>
400013cc: 17fffef5     	b	0x40000fa0 <execute_command+0x418>
400013d0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400013d4: 9132b000     	add	x0, x0, #0xcac
400013d8: 94000853     	bl	0x40003524 <uart_puts>
400013dc: f0ffffe8     	adrp	x8, 0x40000000 <_start>
400013e0: b0000035     	adrp	x21, 0x40006000 <__rodata_start>
400013e4: 911066b5     	add	x21, x21, #0x419
400013e8: 39400113     	ldrb	w19, [x8]
400013ec: d344fe68     	lsr	x8, x19, #4
400013f0: 38686aa0     	ldrb	w0, [x21, x8]
400013f4: 94000835     	bl	0x400034c8 <uart_putc>
400013f8: 92400e68     	and	x8, x19, #0xf
400013fc: 38686aa0     	ldrb	w0, [x21, x8]
40001400: 94000832     	bl	0x400034c8 <uart_putc>
40001404: 52800400     	mov	w0, #0x20               // =32
40001408: 94000830     	bl	0x400034c8 <uart_putc>
4000140c: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
40001410: 910aee73     	add	x19, x19, #0x2bb
40001414: d0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40001418: 9110ca94     	add	x20, x20, #0x432
4000141c: 52800036     	mov	w22, #0x1               // =1
40001420: d503201f     	nop
40001424: 10ff5ef7     	adr	x23, 0x40000000 <_start>
40001428: 1400000d     	b	0x4000145c <execute_command+0x8d4>
4000142c: 38766af8     	ldrb	w24, [x23, x22]
40001430: d344ff08     	lsr	x8, x24, #4
40001434: 38686aa0     	ldrb	w0, [x21, x8]
40001438: 94000824     	bl	0x400034c8 <uart_putc>
4000143c: 92400f08     	and	x8, x24, #0xf
40001440: 38686aa0     	ldrb	w0, [x21, x8]
40001444: 94000821     	bl	0x400034c8 <uart_putc>
40001448: 52800400     	mov	w0, #0x20               // =32
4000144c: 9400081f     	bl	0x400034c8 <uart_putc>
40001450: 910006d6     	add	x22, x22, #0x1
40001454: f10082df     	cmp	x22, #0x20
40001458: 54ffd780     	b.eq	0x40000f48 <execute_command+0x3c0>
4000145c: 72000adf     	tst	w22, #0x7
40001460: 54000061     	b.ne	0x4000146c <execute_command+0x8e4>
40001464: aa1303e0     	mov	x0, x19
40001468: 9400082f     	bl	0x40003524 <uart_puts>
4000146c: 72000edf     	tst	w22, #0xf
40001470: 54fffde1     	b.ne	0x4000142c <execute_command+0x8a4>
40001474: aa1403e0     	mov	x0, x20
40001478: 9400082b     	bl	0x40003524 <uart_puts>
4000147c: 17ffffec     	b	0x4000142c <execute_command+0x8a4>
40001480: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001484: 91304c00     	add	x0, x0, #0xc13
40001488: 94000827     	bl	0x40003524 <uart_puts>
4000148c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001490: 91311800     	add	x0, x0, #0xc46
40001494: 94000824     	bl	0x40003524 <uart_puts>
40001498: d503207f     	wfi
4000149c: 17ffffff     	b	0x40001498 <execute_command+0x910>
400014a0: 97fffd08     	bl	0x400008c0 <print_android_roadmap>
400014a4: 17fffebf     	b	0x40000fa0 <execute_command+0x418>

00000000400014a8 <kernel_shell>:
400014a8: d10543ff     	sub	sp, sp, #0x150
400014ac: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400014b0: 911c1400     	add	x0, x0, #0x705
400014b4: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
400014b8: a9106ffc     	stp	x28, x27, [sp, #0x100]
400014bc: 9103c3fd     	add	x29, sp, #0xf0
400014c0: a91167fa     	stp	x26, x25, [sp, #0x110]
400014c4: a9125ff8     	stp	x24, x23, [sp, #0x120]
400014c8: a91357f6     	stp	x22, x21, [sp, #0x130]
400014cc: a9144ff4     	stp	x20, x19, [sp, #0x140]
400014d0: 94000815     	bl	0x40003524 <uart_puts>
400014d4: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
400014d8: 91334273     	add	x19, x19, #0xcd0
400014dc: b0000034     	adrp	x20, 0x40006000 <__rodata_start>
400014e0: 913afa94     	add	x20, x20, #0xebe
400014e4: f0000035     	adrp	x21, 0x40008000 <__rodata_start+0x2000>
400014e8: 91053eb5     	add	x21, x21, #0x14f
400014ec: b0000036     	adrp	x22, 0x40006000 <__rodata_start>
400014f0: 9139d6d6     	add	x22, x22, #0xe75
400014f4: f0000037     	adrp	x23, 0x40008000 <__rodata_start+0x2000>
400014f8: 9106faf7     	add	x23, x23, #0x1be
400014fc: d0000038     	adrp	x24, 0x40007000 <__rodata_start+0x1000>
40001500: 91399718     	add	x24, x24, #0xe65
40001504: 910123fa     	add	x26, sp, #0x48
40001508: b0000039     	adrp	x25, 0x40006000 <__rodata_start>
4000150c: 912a2b39     	add	x25, x25, #0xa8a
40001510: 910023e0     	add	x0, sp, #0x8
40001514: 52800801     	mov	w1, #0x40               // =64
40001518: 94000c84     	bl	0x40004728 <vfs_getcwd>
4000151c: 910023e1     	add	x1, sp, #0x8
40001520: aa1303e0     	mov	x0, x19
40001524: 94000910     	bl	0x40003964 <uart_printf>
40001528: aa1403e0     	mov	x0, x20
4000152c: 940007fe     	bl	0x40003524 <uart_puts>
40001530: aa1f03fc     	mov	x28, xzr
40001534: aa1c03fb     	mov	x27, x28
40001538: 9400082e     	bl	0x400035f0 <uart_getc>
4000153c: 12001c08     	and	w8, w0, #0xff
40001540: 7100311f     	cmp	w8, #0xc
40001544: 540000cc     	b.gt	0x4000155c <kernel_shell+0xb4>
40001548: 7100211f     	cmp	w8, #0x8
4000154c: 54000240     	b.eq	0x40001594 <kernel_shell+0xec>
40001550: 7100291f     	cmp	w8, #0xa
40001554: 540000c1     	b.ne	0x4000156c <kernel_shell+0xc4>
40001558: 14000015     	b	0x400015ac <kernel_shell+0x104>
4000155c: 7100351f     	cmp	w8, #0xd
40001560: 54000260     	b.eq	0x400015ac <kernel_shell+0x104>
40001564: 7101fd1f     	cmp	w8, #0x7f
40001568: 54000160     	b.eq	0x40001594 <kernel_shell+0xec>
4000156c: 51008008     	sub	w8, w0, #0x20
40001570: 12001d08     	and	w8, w8, #0xff
40001574: 7101791f     	cmp	w8, #0x5e
40001578: 54fffe08     	b.hi	0x40001538 <kernel_shell+0x90>
4000157c: f1027b7f     	cmp	x27, #0x9e
40001580: 54fffdc8     	b.hi	0x40001538 <kernel_shell+0x90>
40001584: 9100077c     	add	x28, x27, #0x1
40001588: 383b6b40     	strb	w0, [x26, x27]
4000158c: 940007cf     	bl	0x400034c8 <uart_putc>
40001590: 17ffffe9     	b	0x40001534 <kernel_shell+0x8c>
40001594: aa1f03fc     	mov	x28, xzr
40001598: b4fffcfb     	cbz	x27, 0x40001534 <kernel_shell+0x8c>
4000159c: aa1503e0     	mov	x0, x21
400015a0: d100077c     	sub	x28, x27, #0x1
400015a4: 940007e0     	bl	0x40003524 <uart_puts>
400015a8: 17ffffe3     	b	0x40001534 <kernel_shell+0x8c>
400015ac: aa1603e0     	mov	x0, x22
400015b0: 940007dd     	bl	0x40003524 <uart_puts>
400015b4: 910123e0     	add	x0, sp, #0x48
400015b8: 383b6b5f     	strb	wzr, [x26, x27]
400015bc: 94000405     	bl	0x400025d0 <kstrlen>
400015c0: b4fffa80     	cbz	x0, 0x40001510 <kernel_shell+0x68>
400015c4: 910123e0     	add	x0, sp, #0x48
400015c8: 940002cf     	bl	0x40002104 <script_execute_line>
400015cc: 910123e0     	add	x0, sp, #0x48
400015d0: aa1703e1     	mov	x1, x23
400015d4: 9400040f     	bl	0x40002610 <kstrcmp>
400015d8: 34000120     	cbz	w0, 0x400015fc <kernel_shell+0x154>
400015dc: 910123e0     	add	x0, sp, #0x48
400015e0: aa1803e1     	mov	x1, x24
400015e4: 9400040b     	bl	0x40002610 <kstrcmp>
400015e8: 340000a0     	cbz	w0, 0x400015fc <kernel_shell+0x154>
400015ec: 910123e0     	add	x0, sp, #0x48
400015f0: aa1903e1     	mov	x1, x25
400015f4: 94000407     	bl	0x40002610 <kstrcmp>
400015f8: 35fff8c0     	cbnz	w0, 0x40001510 <kernel_shell+0x68>
400015fc: a9544ff4     	ldp	x20, x19, [sp, #0x140]
40001600: a95357f6     	ldp	x22, x21, [sp, #0x130]
40001604: a9525ff8     	ldp	x24, x23, [sp, #0x120]
40001608: a95167fa     	ldp	x26, x25, [sp, #0x110]
4000160c: a9506ffc     	ldp	x28, x27, [sp, #0x100]
40001610: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
40001614: 910543ff     	add	sp, sp, #0x150
40001618: d65f03c0     	ret

000000004000161c <kmain>:
4000161c: d100c3ff     	sub	sp, sp, #0x30
40001620: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001624: 529c6c13     	mov	w19, #0xe360            // =58208
40001628: a9017bfd     	stp	x29, x30, [sp, #0x10]
4000162c: 910043fd     	add	x29, sp, #0x10
40001630: 72a002d3     	movk	w19, #0x16, lsl #16
40001634: 94000799     	bl	0x40003498 <uart_init>
40001638: d503201f     	nop
4000163c: 3002ce00     	adr	x0, 0x40006ffd <__rodata_start+0xffd>
40001640: 940007b9     	bl	0x40003524 <uart_puts>
40001644: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001648: 9112ec00     	add	x0, x0, #0x4bb
4000164c: 940007b6     	bl	0x40003524 <uart_puts>
40001650: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001654: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001658: 6b13011f     	cmp	w8, w19
4000165c: 540000aa     	b.ge	0x40001670 <kmain+0x54>
40001660: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001664: 11000508     	add	w8, w8, #0x1
40001668: b81fc3a8     	stur	w8, [x29, #-0x4]
4000166c: 17fffffa     	b	0x40001654 <kmain+0x38>
40001670: 528aa213     	mov	w19, #0x5510            // =21776
40001674: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001678: 910af400     	add	x0, x0, #0x2bd
4000167c: 72a00453     	movk	w19, #0x22, lsl #16
40001680: 940007a9     	bl	0x40003524 <uart_puts>
40001684: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001688: b85fc3a8     	ldur	w8, [x29, #-0x4]
4000168c: 6b13011f     	cmp	w8, w19
40001690: 540000aa     	b.ge	0x400016a4 <kmain+0x88>
40001694: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001698: 11000508     	add	w8, w8, #0x1
4000169c: b81fc3a8     	stur	w8, [x29, #-0x4]
400016a0: 17fffffa     	b	0x40001688 <kmain+0x6c>
400016a4: 5298d814     	mov	w20, #0xc6c0            // =50880
400016a8: 72a005b4     	movk	w20, #0x2d, lsl #16
400016ac: 94000ab9     	bl	0x40004190 <vfs_init>
400016b0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400016b4: 91158000     	add	x0, x0, #0x560
400016b8: 9400079b     	bl	0x40003524 <uart_puts>
400016bc: b81fc3bf     	stur	wzr, [x29, #-0x4]
400016c0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400016c4: 6b14011f     	cmp	w8, w20
400016c8: 540000aa     	b.ge	0x400016dc <kmain+0xc0>
400016cc: b85fc3a8     	ldur	w8, [x29, #-0x4]
400016d0: 11000508     	add	w8, w8, #0x1
400016d4: b81fc3a8     	stur	w8, [x29, #-0x4]
400016d8: 17fffffa     	b	0x400016c0 <kmain+0xa4>
400016dc: 94000079     	bl	0x400018c0 <process_init>
400016e0: 940001bf     	bl	0x40001ddc <script_init>
400016e4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400016e8: 91019400     	add	x0, x0, #0x65
400016ec: 9400078e     	bl	0x40003524 <uart_puts>
400016f0: b81fc3bf     	stur	wzr, [x29, #-0x4]
400016f4: b85fc3a8     	ldur	w8, [x29, #-0x4]
400016f8: 6b13011f     	cmp	w8, w19
400016fc: 540000aa     	b.ge	0x40001710 <kmain+0xf4>
40001700: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001704: 11000508     	add	w8, w8, #0x1
40001708: b81fc3a8     	stur	w8, [x29, #-0x4]
4000170c: 17fffffa     	b	0x400016f4 <kmain+0xd8>
40001710: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001714: 5291b008     	mov	w8, #0x8d80             // =36224
40001718: b85fc3a9     	ldur	w9, [x29, #-0x4]
4000171c: 72a00b68     	movk	w8, #0x5b, lsl #16
40001720: 6b08013f     	cmp	w9, w8
40001724: 540000ea     	b.ge	0x40001740 <kmain+0x124>
40001728: b85fc3a9     	ldur	w9, [x29, #-0x4]
4000172c: 11000529     	add	w9, w9, #0x1
40001730: b81fc3a9     	stur	w9, [x29, #-0x4]
40001734: b85fc3a9     	ldur	w9, [x29, #-0x4]
40001738: 6b08013f     	cmp	w9, w8
4000173c: 54ffff6b     	b.lt	0x40001728 <kmain+0x10c>
40001740: 97fffbc5     	bl	0x40000654 <print_banner>
40001744: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001748: 91205000     	add	x0, x0, #0x814
4000174c: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001750: 912bf421     	add	x1, x1, #0xafd
40001754: 94000884     	bl	0x40003964 <uart_printf>
40001758: 97fffc08     	bl	0x40000778 <print_sysinfo>
4000175c: 97ffff53     	bl	0x400014a8 <kernel_shell>
40001760: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001764: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001768: 91311800     	add	x0, x0, #0xc46
4000176c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001770: 9100c3ff     	add	sp, sp, #0x30
40001774: 1400076c     	b	0x40003524 <uart_puts>

0000000040001778 <kproj_execute>:
40001778: d10683ff     	sub	sp, sp, #0x1a0
4000177c: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001780: 910603fd     	add	x29, sp, #0x180
40001784: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001788: b40001c0     	cbz	x0, 0x400017c0 <kproj_execute+0x48>
4000178c: aa0003f3     	mov	x19, x0
40001790: 94000390     	bl	0x400025d0 <kstrlen>
40001794: b4000160     	cbz	x0, 0x400017c0 <kproj_execute+0x48>
40001798: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000179c: 91235400     	add	x0, x0, #0x8d5
400017a0: aa1303e1     	mov	x1, x19
400017a4: 94000870     	bl	0x40003964 <uart_printf>
400017a8: aa1303e0     	mov	x0, x19
400017ac: 94000cd4     	bl	0x40004afc <vfs_mkdir>
400017b0: 34000140     	cbz	w0, 0x400017d8 <kproj_execute+0x60>
400017b4: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400017b8: 91070c00     	add	x0, x0, #0x1c3
400017bc: 14000003     	b	0x400017c8 <kproj_execute+0x50>
400017c0: d503201f     	nop
400017c4: 50033620     	adr	x0, 0x40007e8a <__rodata_start+0x1e8a>
400017c8: a9594ffc     	ldp	x28, x19, [sp, #0x190]
400017cc: a9587bfd     	ldp	x29, x30, [sp, #0x180]
400017d0: 910683ff     	add	sp, sp, #0x1a0
400017d4: 14000754     	b	0x40003524 <uart_puts>
400017d8: aa1303e0     	mov	x0, x19
400017dc: 94000ca3     	bl	0x40004a68 <vfs_chdir>
400017e0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400017e4: 913b6c00     	add	x0, x0, #0xedb
400017e8: 94000cc5     	bl	0x40004afc <vfs_mkdir>
400017ec: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400017f0: 91109c00     	add	x0, x0, #0x427
400017f4: 94000cc2     	bl	0x40004afc <vfs_mkdir>
400017f8: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400017fc: 91077021     	add	x1, x1, #0x1dc
40001800: 910203e0     	add	x0, sp, #0x80
40001804: 940003a2     	bl	0x4000268c <kstrcpy>
40001808: 910203e0     	add	x0, sp, #0x80
4000180c: aa1303e1     	mov	x1, x19
40001810: 94000377     	bl	0x400025ec <kstrcat>
40001814: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001818: 9134f021     	add	x1, x1, #0xd3c
4000181c: 910203e0     	add	x0, sp, #0x80
40001820: 94000373     	bl	0x400025ec <kstrcat>
40001824: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001828: 9120f400     	add	x0, x0, #0x83d
4000182c: 910203e1     	add	x1, sp, #0x80
40001830: 94000d09     	bl	0x40004c54 <vfs_touch>
40001834: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001838: 9131b000     	add	x0, x0, #0xc6c
4000183c: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001840: 912a3c21     	add	x1, x1, #0xa8f
40001844: 94000d04     	bl	0x40004c54 <vfs_touch>
40001848: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
4000184c: 913ec021     	add	x1, x1, #0xfb0
40001850: 910003e0     	mov	x0, sp
40001854: 9400038e     	bl	0x4000268c <kstrcpy>
40001858: 910003e0     	mov	x0, sp
4000185c: aa1303e1     	mov	x1, x19
40001860: 94000363     	bl	0x400025ec <kstrcat>
40001864: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001868: 9125dc21     	add	x1, x1, #0x977
4000186c: 910003e0     	mov	x0, sp
40001870: 9400035f     	bl	0x400025ec <kstrcat>
40001874: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001878: 9135a000     	add	x0, x0, #0xd68
4000187c: 910003e1     	mov	x1, sp
40001880: 94000cf5     	bl	0x40004c54 <vfs_touch>
40001884: 94000cf3     	bl	0x40004c50 <vfs_sync>
40001888: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000188c: 9110a800     	add	x0, x0, #0x42a
40001890: 94000725     	bl	0x40003524 <uart_puts>
40001894: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001898: 91116400     	add	x0, x0, #0x459
4000189c: aa1303e1     	mov	x1, x19
400018a0: 94000831     	bl	0x40003964 <uart_printf>
400018a4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400018a8: 913b7c00     	add	x0, x0, #0xedf
400018ac: 94000c6f     	bl	0x40004a68 <vfs_chdir>
400018b0: a9594ffc     	ldp	x28, x19, [sp, #0x190]
400018b4: a9587bfd     	ldp	x29, x30, [sp, #0x180]
400018b8: 910683ff     	add	sp, sp, #0x1a0
400018bc: d65f03c0     	ret

00000000400018c0 <process_init>:
400018c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400018c4: a9014ff4     	stp	x20, x19, [sp, #0x10]
400018c8: 90000054     	adrp	x20, 0x40009000 <next_pid>
400018cc: d503201f     	nop
400018d0: 1005cc33     	adr	x19, 0x4000d254 <proc_table>
400018d4: b9400289     	ldr	w9, [x20]
400018d8: 52800068     	mov	w8, #0x3                // =3
400018dc: b9002668     	str	w8, [x19, #0x24]
400018e0: d503201f     	nop
400018e4: 1002e9c1     	adr	x1, 0x4000761c <__rodata_start+0x161c>
400018e8: b9005668     	str	w8, [x19, #0x54]
400018ec: 91001260     	add	x0, x19, #0x4
400018f0: 910003fd     	mov	x29, sp
400018f4: b9008668     	str	w8, [x19, #0x84]
400018f8: b900b668     	str	w8, [x19, #0xb4]
400018fc: b900e668     	str	w8, [x19, #0xe4]
40001900: b9011668     	str	w8, [x19, #0x114]
40001904: b9014668     	str	w8, [x19, #0x144]
40001908: b9017668     	str	w8, [x19, #0x174]
4000190c: b901a668     	str	w8, [x19, #0x1a4]
40001910: b901d668     	str	w8, [x19, #0x1d4]
40001914: b9020668     	str	w8, [x19, #0x204]
40001918: b9023668     	str	w8, [x19, #0x234]
4000191c: b9026668     	str	w8, [x19, #0x264]
40001920: b9029668     	str	w8, [x19, #0x294]
40001924: b902c668     	str	w8, [x19, #0x2c4]
40001928: b902f668     	str	w8, [x19, #0x2f4]
4000192c: 11000528     	add	w8, w9, #0x1
40001930: b900327f     	str	wzr, [x19, #0x30]
40001934: b900627f     	str	wzr, [x19, #0x60]
40001938: b900927f     	str	wzr, [x19, #0x90]
4000193c: b900c27f     	str	wzr, [x19, #0xc0]
40001940: b900f27f     	str	wzr, [x19, #0xf0]
40001944: b901227f     	str	wzr, [x19, #0x120]
40001948: b901527f     	str	wzr, [x19, #0x150]
4000194c: b901827f     	str	wzr, [x19, #0x180]
40001950: b901b27f     	str	wzr, [x19, #0x1b0]
40001954: b901e27f     	str	wzr, [x19, #0x1e0]
40001958: b902127f     	str	wzr, [x19, #0x210]
4000195c: b902427f     	str	wzr, [x19, #0x240]
40001960: b902727f     	str	wzr, [x19, #0x270]
40001964: b902a27f     	str	wzr, [x19, #0x2a0]
40001968: b902d27f     	str	wzr, [x19, #0x2d0]
4000196c: b9000288     	str	w8, [x20]
40001970: b9000269     	str	w9, [x19]
40001974: 94000346     	bl	0x4000268c <kstrcpy>
40001978: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000197c: b9400289     	ldr	w9, [x20]
40001980: 5280384a     	mov	w10, #0x1c2             // =450
40001984: fd411d00     	ldr	d0, [x8, #0x238]
40001988: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000198c: 9107f021     	add	x1, x1, #0x1fc
40001990: 11000528     	add	w8, w9, #0x1
40001994: 9100d260     	add	x0, x19, #0x34
40001998: 2905a66a     	stp	w10, w9, [x19, #0x2c]
4000199c: fc024260     	stur	d0, [x19, #0x24]
400019a0: b9000288     	str	w8, [x20]
400019a4: 9400033a     	bl	0x4000268c <kstrcpy>
400019a8: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400019ac: b9400289     	ldr	w9, [x20]
400019b0: 5280018a     	mov	w10, #0xc               // =12
400019b4: fd413100     	ldr	d0, [x8, #0x260]
400019b8: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400019bc: 91266421     	add	x1, x1, #0x999
400019c0: 11000528     	add	w8, w9, #0x1
400019c4: 91019260     	add	x0, x19, #0x64
400019c8: 290ba66a     	stp	w10, w9, [x19, #0x5c]
400019cc: fc054260     	stur	d0, [x19, #0x54]
400019d0: b9000288     	str	w8, [x20]
400019d4: 9400032e     	bl	0x4000268c <kstrcpy>
400019d8: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400019dc: b9400289     	ldr	w9, [x20]
400019e0: 5280960a     	mov	w10, #0x4b0             // =1200
400019e4: fd410d00     	ldr	d0, [x8, #0x218]
400019e8: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400019ec: 9105c021     	add	x1, x1, #0x170
400019f0: 11000528     	add	w8, w9, #0x1
400019f4: 91025260     	add	x0, x19, #0x94
400019f8: 2911a66a     	stp	w10, w9, [x19, #0x8c]
400019fc: fc084260     	stur	d0, [x19, #0x84]
40001a00: b9000288     	str	w8, [x20]
40001a04: 94000322     	bl	0x4000268c <kstrcpy>
40001a08: f0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40001a0c: fd414100     	ldr	d0, [x8, #0x280]
40001a10: 52800aa8     	mov	w8, #0x55               // =85
40001a14: b900be68     	str	w8, [x19, #0xbc]
40001a18: fc0b4260     	stur	d0, [x19, #0xb4]
40001a1c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40001a20: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40001a24: d65f03c0     	ret

0000000040001a28 <process_kill>:
40001a28: 7100041f     	cmp	w0, #0x1
40001a2c: 5400118b     	b.lt	0x40001c5c <process_kill+0x234>
40001a30: d503201f     	nop
40001a34: 1005c109     	adr	x9, 0x4000d254 <proc_table>
40001a38: b9400128     	ldr	w8, [x9]
40001a3c: 6b00011f     	cmp	w8, w0
40001a40: 54000081     	b.ne	0x40001a50 <process_kill+0x28>
40001a44: b9402528     	ldr	w8, [x9, #0x24]
40001a48: 71000d1f     	cmp	w8, #0x3
40001a4c: 54000f41     	b.ne	0x40001c34 <process_kill+0x20c>
40001a50: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001a54: 910a1129     	add	x9, x9, #0x284
40001a58: b9400128     	ldr	w8, [x9]
40001a5c: 6b00011f     	cmp	w8, w0
40001a60: 54000081     	b.ne	0x40001a70 <process_kill+0x48>
40001a64: b9402528     	ldr	w8, [x9, #0x24]
40001a68: 71000d1f     	cmp	w8, #0x3
40001a6c: 54000e41     	b.ne	0x40001c34 <process_kill+0x20c>
40001a70: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001a74: 910ad129     	add	x9, x9, #0x2b4
40001a78: b9400128     	ldr	w8, [x9]
40001a7c: 6b00011f     	cmp	w8, w0
40001a80: 54000081     	b.ne	0x40001a90 <process_kill+0x68>
40001a84: b9402528     	ldr	w8, [x9, #0x24]
40001a88: 71000d1f     	cmp	w8, #0x3
40001a8c: 54000d41     	b.ne	0x40001c34 <process_kill+0x20c>
40001a90: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001a94: 910b9129     	add	x9, x9, #0x2e4
40001a98: b9400128     	ldr	w8, [x9]
40001a9c: 6b00011f     	cmp	w8, w0
40001aa0: 54000081     	b.ne	0x40001ab0 <process_kill+0x88>
40001aa4: b9402528     	ldr	w8, [x9, #0x24]
40001aa8: 71000d1f     	cmp	w8, #0x3
40001aac: 54000c41     	b.ne	0x40001c34 <process_kill+0x20c>
40001ab0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001ab4: 910c5129     	add	x9, x9, #0x314
40001ab8: b9400128     	ldr	w8, [x9]
40001abc: 6b00011f     	cmp	w8, w0
40001ac0: 54000081     	b.ne	0x40001ad0 <process_kill+0xa8>
40001ac4: b9402528     	ldr	w8, [x9, #0x24]
40001ac8: 71000d1f     	cmp	w8, #0x3
40001acc: 54000b41     	b.ne	0x40001c34 <process_kill+0x20c>
40001ad0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001ad4: 910d1129     	add	x9, x9, #0x344
40001ad8: b9400128     	ldr	w8, [x9]
40001adc: 6b00011f     	cmp	w8, w0
40001ae0: 54000081     	b.ne	0x40001af0 <process_kill+0xc8>
40001ae4: b9402528     	ldr	w8, [x9, #0x24]
40001ae8: 71000d1f     	cmp	w8, #0x3
40001aec: 54000a41     	b.ne	0x40001c34 <process_kill+0x20c>
40001af0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001af4: 910dd129     	add	x9, x9, #0x374
40001af8: b9400128     	ldr	w8, [x9]
40001afc: 6b00011f     	cmp	w8, w0
40001b00: 54000081     	b.ne	0x40001b10 <process_kill+0xe8>
40001b04: b9402528     	ldr	w8, [x9, #0x24]
40001b08: 71000d1f     	cmp	w8, #0x3
40001b0c: 54000941     	b.ne	0x40001c34 <process_kill+0x20c>
40001b10: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001b14: 910e9129     	add	x9, x9, #0x3a4
40001b18: b9400128     	ldr	w8, [x9]
40001b1c: 6b00011f     	cmp	w8, w0
40001b20: 54000081     	b.ne	0x40001b30 <process_kill+0x108>
40001b24: b9402528     	ldr	w8, [x9, #0x24]
40001b28: 71000d1f     	cmp	w8, #0x3
40001b2c: 54000841     	b.ne	0x40001c34 <process_kill+0x20c>
40001b30: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001b34: 910f5129     	add	x9, x9, #0x3d4
40001b38: b9400128     	ldr	w8, [x9]
40001b3c: 6b00011f     	cmp	w8, w0
40001b40: 54000081     	b.ne	0x40001b50 <process_kill+0x128>
40001b44: b9402528     	ldr	w8, [x9, #0x24]
40001b48: 71000d1f     	cmp	w8, #0x3
40001b4c: 54000741     	b.ne	0x40001c34 <process_kill+0x20c>
40001b50: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001b54: 91101129     	add	x9, x9, #0x404
40001b58: b9400128     	ldr	w8, [x9]
40001b5c: 6b00011f     	cmp	w8, w0
40001b60: 54000081     	b.ne	0x40001b70 <process_kill+0x148>
40001b64: b9402528     	ldr	w8, [x9, #0x24]
40001b68: 71000d1f     	cmp	w8, #0x3
40001b6c: 54000641     	b.ne	0x40001c34 <process_kill+0x20c>
40001b70: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001b74: 9110d129     	add	x9, x9, #0x434
40001b78: b9400128     	ldr	w8, [x9]
40001b7c: 6b00011f     	cmp	w8, w0
40001b80: 54000081     	b.ne	0x40001b90 <process_kill+0x168>
40001b84: b9402528     	ldr	w8, [x9, #0x24]
40001b88: 71000d1f     	cmp	w8, #0x3
40001b8c: 54000541     	b.ne	0x40001c34 <process_kill+0x20c>
40001b90: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001b94: 91119129     	add	x9, x9, #0x464
40001b98: b9400128     	ldr	w8, [x9]
40001b9c: 6b00011f     	cmp	w8, w0
40001ba0: 54000081     	b.ne	0x40001bb0 <process_kill+0x188>
40001ba4: b9402528     	ldr	w8, [x9, #0x24]
40001ba8: 71000d1f     	cmp	w8, #0x3
40001bac: 54000441     	b.ne	0x40001c34 <process_kill+0x20c>
40001bb0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001bb4: 91125129     	add	x9, x9, #0x494
40001bb8: b9400128     	ldr	w8, [x9]
40001bbc: 6b00011f     	cmp	w8, w0
40001bc0: 54000081     	b.ne	0x40001bd0 <process_kill+0x1a8>
40001bc4: b9402528     	ldr	w8, [x9, #0x24]
40001bc8: 71000d1f     	cmp	w8, #0x3
40001bcc: 54000341     	b.ne	0x40001c34 <process_kill+0x20c>
40001bd0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001bd4: 91131129     	add	x9, x9, #0x4c4
40001bd8: b9400128     	ldr	w8, [x9]
40001bdc: 6b00011f     	cmp	w8, w0
40001be0: 54000081     	b.ne	0x40001bf0 <process_kill+0x1c8>
40001be4: b9402528     	ldr	w8, [x9, #0x24]
40001be8: 71000d1f     	cmp	w8, #0x3
40001bec: 54000241     	b.ne	0x40001c34 <process_kill+0x20c>
40001bf0: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001bf4: 9113d129     	add	x9, x9, #0x4f4
40001bf8: b9400128     	ldr	w8, [x9]
40001bfc: 6b00011f     	cmp	w8, w0
40001c00: 54000081     	b.ne	0x40001c10 <process_kill+0x1e8>
40001c04: b9402528     	ldr	w8, [x9, #0x24]
40001c08: 71000d1f     	cmp	w8, #0x3
40001c0c: 54000141     	b.ne	0x40001c34 <process_kill+0x20c>
40001c10: 90000069     	adrp	x9, 0x4000d000 <__bss_start+0x3000>
40001c14: 91149129     	add	x9, x9, #0x524
40001c18: b9400128     	ldr	w8, [x9]
40001c1c: 6b00011f     	cmp	w8, w0
40001c20: 12800008     	mov	w8, #-0x1               // =-1
40001c24: 54000281     	b.ne	0x40001c74 <process_kill+0x24c>
40001c28: b940252a     	ldr	w10, [x9, #0x24]
40001c2c: 71000d5f     	cmp	w10, #0x3
40001c30: 54000220     	b.eq	0x40001c74 <process_kill+0x24c>
40001c34: 7100041f     	cmp	w0, #0x1
40001c38: 54000161     	b.ne	0x40001c64 <process_kill+0x23c>
40001c3c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001c40: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001c44: 91241800     	add	x0, x0, #0x906
40001c48: 910003fd     	mov	x29, sp
40001c4c: 94000636     	bl	0x40003524 <uart_puts>
40001c50: 12800020     	mov	w0, #-0x2               // =-2
40001c54: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001c58: d65f03c0     	ret
40001c5c: 12800000     	mov	w0, #-0x1               // =-1
40001c60: d65f03c0     	ret
40001c64: 5280004a     	mov	w10, #0x2               // =2
40001c68: 2a1f03e0     	mov	w0, wzr
40001c6c: b900252a     	str	w10, [x9, #0x24]
40001c70: d65f03c0     	ret
40001c74: 2a0803e0     	mov	w0, w8
40001c78: d65f03c0     	ret

0000000040001c7c <launch_ktop>:
40001c7c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001c80: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001c84: 911c6800     	add	x0, x0, #0x71a
40001c88: f9000bf7     	str	x23, [sp, #0x10]
40001c8c: a90257f6     	stp	x22, x21, [sp, #0x20]
40001c90: 910003fd     	mov	x29, sp
40001c94: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001c98: 94000623     	bl	0x40003524 <uart_puts>
40001c9c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001ca0: 9116b400     	add	x0, x0, #0x5ad
40001ca4: 94000620     	bl	0x40003524 <uart_puts>
40001ca8: 2a1f03e8     	mov	w8, wzr
40001cac: 2a1f03e1     	mov	w1, wzr
40001cb0: 52800209     	mov	w9, #0x10               // =16
40001cb4: 9000006a     	adrp	x10, 0x4000d000 <__bss_start+0x3000>
40001cb8: 9109f14a     	add	x10, x10, #0x27c
40001cbc: 14000004     	b	0x40001ccc <launch_ktop+0x50>
40001cc0: f1000529     	subs	x9, x9, #0x1
40001cc4: 9100c14a     	add	x10, x10, #0x30
40001cc8: 54000120     	b.eq	0x40001cec <launch_ktop+0x70>
40001ccc: b85fc14b     	ldur	w11, [x10, #-0x4]
40001cd0: 121f796b     	and	w11, w11, #0xfffffffe
40001cd4: 7100097f     	cmp	w11, #0x2
40001cd8: 54ffff40     	b.eq	0x40001cc0 <launch_ktop+0x44>
40001cdc: b940014b     	ldr	w11, [x10]
40001ce0: 11000421     	add	w1, w1, #0x1
40001ce4: 0b080168     	add	w8, w11, w8
40001ce8: 17fffff6     	b	0x40001cc0 <launch_ktop+0x44>
40001cec: 530a7d02     	lsr	w2, w8, #10
40001cf0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001cf4: 91268c00     	add	x0, x0, #0x9a3
40001cf8: 9400071b     	bl	0x40003964 <uart_printf>
40001cfc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001d00: 912abc00     	add	x0, x0, #0xaaf
40001d04: 94000608     	bl	0x40003524 <uart_puts>
40001d08: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001d0c: 91281000     	add	x0, x0, #0xa04
40001d10: 94000605     	bl	0x40003524 <uart_puts>
40001d14: 90000074     	adrp	x20, 0x4000d000 <__bss_start+0x3000>
40001d18: 910a0294     	add	x20, x20, #0x280
40001d1c: d0000035     	adrp	x21, 0x40007000 <__rodata_start+0x1000>
40001d20: 912d42b5     	add	x21, x21, #0xb50
40001d24: d503201f     	nop
40001d28: 10032b56     	adr	x22, 0x40008290 <__rodata_start+0x2290>
40001d2c: 52800217     	mov	w23, #0x10              // =16
40001d30: d0000033     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
40001d34: 910be673     	add	x19, x19, #0x2f9
40001d38: 1400000a     	b	0x40001d60 <launch_ktop+0xe4>
40001d3c: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40001d40: b85d4281     	ldur	w1, [x20, #-0x2c]
40001d44: d100a285     	sub	x5, x20, #0x28
40001d48: aa1303e0     	mov	x0, x19
40001d4c: 530a7d03     	lsr	w3, w8, #10
40001d50: 94000705     	bl	0x40003964 <uart_printf>
40001d54: f10006f7     	subs	x23, x23, #0x1
40001d58: 9100c294     	add	x20, x20, #0x30
40001d5c: 54000120     	b.eq	0x40001d80 <launch_ktop+0x104>
40001d60: b85f8288     	ldur	w8, [x20, #-0x8]
40001d64: 71000d1f     	cmp	w8, #0x3
40001d68: 54ffff60     	b.eq	0x40001d54 <launch_ktop+0xd8>
40001d6c: 7100091f     	cmp	w8, #0x2
40001d70: aa1503e2     	mov	x2, x21
40001d74: 54fffe48     	b.hi	0x40001d3c <launch_ktop+0xc0>
40001d78: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
40001d7c: 17fffff0     	b	0x40001d3c <launch_ktop+0xc0>
40001d80: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001d84: 913ecc00     	add	x0, x0, #0xfb3
40001d88: 940005e7     	bl	0x40003524 <uart_puts>
40001d8c: 52808114     	mov	w20, #0x408             // =1032
40001d90: 52800033     	mov	w19, #0x1               // =1
40001d94: 72a02014     	movk	w20, #0x100, lsl #16
40001d98: 14000003     	b	0x40001da4 <launch_ktop+0x128>
40001d9c: 7101c51f     	cmp	w8, #0x71
40001da0: 54000100     	b.eq	0x40001dc0 <launch_ktop+0x144>
40001da4: 94000613     	bl	0x400035f0 <uart_getc>
40001da8: 12001c08     	and	w8, w0, #0xff
40001dac: 7100611f     	cmp	w8, #0x18
40001db0: 54ffff68     	b.hi	0x40001d9c <launch_ktop+0x120>
40001db4: 1ac82269     	lsl	w9, w19, w8
40001db8: 6a14013f     	tst	w9, w20
40001dbc: 54ffff00     	b.eq	0x40001d9c <launch_ktop+0x120>
40001dc0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40001dc4: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001dc8: 91275800     	add	x0, x0, #0x9d6
40001dcc: a94257f6     	ldp	x22, x21, [sp, #0x20]
40001dd0: f9400bf7     	ldr	x23, [sp, #0x10]
40001dd4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40001dd8: 140005d3     	b	0x40003524 <uart_puts>

0000000040001ddc <script_init>:
40001ddc: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001de0: 90000068     	adrp	x8, 0x4000d000 <__bss_start+0x3000>
40001de4: d503201f     	nop
40001de8: 30026820     	adr	x0, 0x40006aed <__rodata_start+0xaed>
40001dec: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001df0: 911d2021     	add	x1, x1, #0x748
40001df4: 910003fd     	mov	x29, sp
40001df8: b905551f     	str	wzr, [x8, #0x554]
40001dfc: 94000007     	bl	0x40001e18 <script_set_var>
40001e00: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001e04: 91262c00     	add	x0, x0, #0x98b
40001e08: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001e0c: 9110b421     	add	x1, x1, #0x42d
40001e10: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001e14: 14000001     	b	0x40001e18 <script_set_var>

0000000040001e18 <script_set_var>:
40001e18: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001e1c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40001e20: 90000077     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
40001e24: 910003fd     	mov	x29, sp
40001e28: b94556e8     	ldr	w8, [x23, #0x554]
40001e2c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001e30: aa0103f3     	mov	x19, x1
40001e34: aa0003f4     	mov	x20, x0
40001e38: a90257f6     	stp	x22, x21, [sp, #0x20]
40001e3c: 7100051f     	cmp	w8, #0x1
40001e40: 5400024b     	b.lt	0x40001e88 <script_set_var+0x70>
40001e44: aa1f03f8     	mov	x24, xzr
40001e48: 90000075     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40001e4c: 912562b5     	add	x21, x21, #0x958
40001e50: 90000076     	adrp	x22, 0x4000d000 <__bss_start+0x3000>
40001e54: 911562d6     	add	x22, x22, #0x558
40001e58: aa1603e0     	mov	x0, x22
40001e5c: aa1403e1     	mov	x1, x20
40001e60: 940001ec     	bl	0x40002610 <kstrcmp>
40001e64: 340003e0     	cbz	w0, 0x40001ee0 <script_set_var+0xc8>
40001e68: b98556e8     	ldrsw	x8, [x23, #0x554]
40001e6c: 91000718     	add	x24, x24, #0x1
40001e70: 910202b5     	add	x21, x21, #0x80
40001e74: 910082d6     	add	x22, x22, #0x20
40001e78: eb08031f     	cmp	x24, x8
40001e7c: 54fffeeb     	b.lt	0x40001e58 <script_set_var+0x40>
40001e80: 71007d1f     	cmp	w8, #0x1f
40001e84: 5400038c     	b.gt	0x40001ef4 <script_set_var+0xdc>
40001e88: 90000075     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40001e8c: 911562b5     	add	x21, x21, #0x558
40001e90: aa1403e1     	mov	x1, x20
40001e94: 93407d08     	sxtw	x8, w8
40001e98: 528003e2     	mov	w2, #0x1f               // =31
40001e9c: 8b0816a0     	add	x0, x21, x8, lsl #5
40001ea0: 94000202     	bl	0x400026a8 <kstrncpy>
40001ea4: b98556e8     	ldrsw	x8, [x23, #0x554]
40001ea8: 90000074     	adrp	x20, 0x4000d000 <__bss_start+0x3000>
40001eac: 91256294     	add	x20, x20, #0x958
40001eb0: aa1303e1     	mov	x1, x19
40001eb4: 52800fe2     	mov	w2, #0x7f               // =127
40001eb8: 8b0816a9     	add	x9, x21, x8, lsl #5
40001ebc: 8b081e80     	add	x0, x20, x8, lsl #7
40001ec0: 39007d3f     	strb	wzr, [x9, #0x1f]
40001ec4: 940001f9     	bl	0x400026a8 <kstrncpy>
40001ec8: b98556e8     	ldrsw	x8, [x23, #0x554]
40001ecc: 8b081e89     	add	x9, x20, x8, lsl #7
40001ed0: 11000508     	add	w8, w8, #0x1
40001ed4: b90556e8     	str	w8, [x23, #0x554]
40001ed8: 3901fd3f     	strb	wzr, [x9, #0x7f]
40001edc: 14000006     	b	0x40001ef4 <script_set_var+0xdc>
40001ee0: aa1503e0     	mov	x0, x21
40001ee4: aa1303e1     	mov	x1, x19
40001ee8: 52800fe2     	mov	w2, #0x7f               // =127
40001eec: 940001ef     	bl	0x400026a8 <kstrncpy>
40001ef0: 3901febf     	strb	wzr, [x21, #0x7f]
40001ef4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40001ef8: a94257f6     	ldp	x22, x21, [sp, #0x20]
40001efc: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40001f00: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40001f04: d65f03c0     	ret

0000000040001f08 <script_get_var>:
40001f08: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40001f0c: a90257f6     	stp	x22, x21, [sp, #0x20]
40001f10: 90000076     	adrp	x22, 0x4000d000 <__bss_start+0x3000>
40001f14: 910003fd     	mov	x29, sp
40001f18: b94556c8     	ldr	w8, [x22, #0x554]
40001f1c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40001f20: a9034ff4     	stp	x20, x19, [sp, #0x30]
40001f24: 7100051f     	cmp	w8, #0x1
40001f28: 540002ab     	b.lt	0x40001f7c <script_get_var+0x74>
40001f2c: aa0003f4     	mov	x20, x0
40001f30: aa1f03f7     	mov	x23, xzr
40001f34: 90000073     	adrp	x19, 0x4000d000 <__bss_start+0x3000>
40001f38: 91256273     	add	x19, x19, #0x958
40001f3c: 90000075     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40001f40: 911562b5     	add	x21, x21, #0x558
40001f44: b0000038     	adrp	x24, 0x40006000 <__rodata_start>
40001f48: 91211718     	add	x24, x24, #0x845
40001f4c: aa1503e0     	mov	x0, x21
40001f50: aa1403e1     	mov	x1, x20
40001f54: 940001af     	bl	0x40002610 <kstrcmp>
40001f58: 34000160     	cbz	w0, 0x40001f84 <script_get_var+0x7c>
40001f5c: b98556c8     	ldrsw	x8, [x22, #0x554]
40001f60: 910006f7     	add	x23, x23, #0x1
40001f64: 91020273     	add	x19, x19, #0x80
40001f68: 910082b5     	add	x21, x21, #0x20
40001f6c: eb0802ff     	cmp	x23, x8
40001f70: 54fffeeb     	b.lt	0x40001f4c <script_get_var+0x44>
40001f74: aa1803f3     	mov	x19, x24
40001f78: 14000003     	b	0x40001f84 <script_get_var+0x7c>
40001f7c: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
40001f80: 91211673     	add	x19, x19, #0x845
40001f84: aa1303e0     	mov	x0, x19
40001f88: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40001f8c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40001f90: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40001f94: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40001f98: d65f03c0     	ret

0000000040001f9c <script_expand_vars>:
40001f9c: d10203ff     	sub	sp, sp, #0x80
40001fa0: a9036ffc     	stp	x28, x27, [sp, #0x30]
40001fa4: 2a1f03fc     	mov	w28, wzr
40001fa8: a90467fa     	stp	x26, x25, [sp, #0x40]
40001fac: b0000039     	adrp	x25, 0x40006000 <__rodata_start>
40001fb0: 91211739     	add	x25, x25, #0x845
40001fb4: a9055ff8     	stp	x24, x23, [sp, #0x50]
40001fb8: 910003f8     	mov	x24, sp
40001fbc: 9000007a     	adrp	x26, 0x4000d000 <__bss_start+0x3000>
40001fc0: a90657f6     	stp	x22, x21, [sp, #0x60]
40001fc4: 2a1f03f6     	mov	w22, wzr
40001fc8: a9074ff4     	stp	x20, x19, [sp, #0x70]
40001fcc: aa0103f3     	mov	x19, x1
40001fd0: aa0003f4     	mov	x20, x0
40001fd4: a9027bfd     	stp	x29, x30, [sp, #0x20]
40001fd8: 910083fd     	add	x29, sp, #0x20
40001fdc: 14000001     	b	0x40001fe0 <script_expand_vars+0x44>
40001fe0: 93407f89     	sxtw	x9, w28
40001fe4: 38696a88     	ldrb	w8, [x20, x9]
40001fe8: 7100911f     	cmp	w8, #0x24
40001fec: 540000e0     	b.eq	0x40002008 <script_expand_vars+0x6c>
40001ff0: 34000788     	cbz	w8, 0x400020e0 <script_expand_vars+0x144>
40001ff4: 110006ca     	add	w10, w22, #0x1
40001ff8: 3836ca68     	strb	w8, [x19, w22, sxtw]
40001ffc: 1100053c     	add	w28, w9, #0x1
40002000: 2a0a03f6     	mov	w22, w10
40002004: 17fffff7     	b	0x40001fe0 <script_expand_vars+0x44>
40002008: aa1f03e8     	mov	x8, xzr
4000200c: 14000005     	b	0x40002020 <script_expand_vars+0x84>
40002010: 9100050a     	add	x10, x8, #0x1
40002014: 38286b09     	strb	w9, [x24, x8]
40002018: d1000789     	sub	x9, x28, #0x1
4000201c: aa0a03e8     	mov	x8, x10
40002020: 9100053c     	add	x28, x9, #0x1
40002024: 14000004     	b	0x40002034 <script_expand_vars+0x98>
40002028: f100791f     	cmp	x8, #0x1e
4000202c: 9100079c     	add	x28, x28, #0x1
40002030: 54ffff09     	b.ls	0x40002010 <script_expand_vars+0x74>
40002034: 387c6a89     	ldrb	w9, [x20, x28]
40002038: 121a792a     	and	w10, w9, #0xffffffdf
4000203c: 5101054a     	sub	w10, w10, #0x41
40002040: 7100695f     	cmp	w10, #0x1a
40002044: 54ffff23     	b.lo	0x40002028 <script_expand_vars+0x8c>
40002048: 71017d3f     	cmp	w9, #0x5f
4000204c: 54fffee0     	b.eq	0x40002028 <script_expand_vars+0x8c>
40002050: 5100c12a     	sub	w10, w9, #0x30
40002054: 7100255f     	cmp	w10, #0x9
40002058: 54fffe89     	b.ls	0x40002028 <script_expand_vars+0x8c>
4000205c: b9455749     	ldr	w9, [x26, #0x554]
40002060: 38286b1f     	strb	wzr, [x24, x8]
40002064: 7100053f     	cmp	w9, #0x1
40002068: 5400028b     	b.lt	0x400020b8 <script_expand_vars+0x11c>
4000206c: aa1f03fb     	mov	x27, xzr
40002070: f0000055     	adrp	x21, 0x4000d000 <__bss_start+0x3000>
40002074: 911562b5     	add	x21, x21, #0x558
40002078: f0000057     	adrp	x23, 0x4000d000 <__bss_start+0x3000>
4000207c: 912562f7     	add	x23, x23, #0x958
40002080: 910003e1     	mov	x1, sp
40002084: aa1503e0     	mov	x0, x21
40002088: 94000162     	bl	0x40002610 <kstrcmp>
4000208c: 34000100     	cbz	w0, 0x400020ac <script_expand_vars+0x110>
40002090: b9855748     	ldrsw	x8, [x26, #0x554]
40002094: 9100077b     	add	x27, x27, #0x1
40002098: 910202f7     	add	x23, x23, #0x80
4000209c: 910082b5     	add	x21, x21, #0x20
400020a0: eb08037f     	cmp	x27, x8
400020a4: 54fffeeb     	b.lt	0x40002080 <script_expand_vars+0xe4>
400020a8: aa1903f7     	mov	x23, x25
400020ac: 394002e8     	ldrb	w8, [x23]
400020b0: 350000a8     	cbnz	w8, 0x400020c4 <script_expand_vars+0x128>
400020b4: 17ffffcb     	b	0x40001fe0 <script_expand_vars+0x44>
400020b8: aa1903f7     	mov	x23, x25
400020bc: 394002e8     	ldrb	w8, [x23]
400020c0: 34fff908     	cbz	w8, 0x40001fe0 <script_expand_vars+0x44>
400020c4: 8b36c269     	add	x9, x19, w22, sxtw
400020c8: 910006ea     	add	x10, x23, #0x1
400020cc: 38001528     	strb	w8, [x9], #0x1
400020d0: 110006d6     	add	w22, w22, #0x1
400020d4: 38401548     	ldrb	w8, [x10], #0x1
400020d8: 35ffffa8     	cbnz	w8, 0x400020cc <script_expand_vars+0x130>
400020dc: 17ffffc1     	b	0x40001fe0 <script_expand_vars+0x44>
400020e0: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
400020e4: a9474ff4     	ldp	x20, x19, [sp, #0x70]
400020e8: a94657f6     	ldp	x22, x21, [sp, #0x60]
400020ec: a9455ff8     	ldp	x24, x23, [sp, #0x50]
400020f0: a94467fa     	ldp	x26, x25, [sp, #0x40]
400020f4: a9436ffc     	ldp	x28, x27, [sp, #0x30]
400020f8: a9427bfd     	ldp	x29, x30, [sp, #0x20]
400020fc: 910203ff     	add	sp, sp, #0x80
40002100: d65f03c0     	ret

0000000040002104 <script_execute_line>:
40002104: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002108: a9014ffc     	stp	x28, x19, [sp, #0x10]
4000210c: 910003fd     	mov	x29, sp
40002110: d10803ff     	sub	sp, sp, #0x200
40002114: 14000004     	b	0x40002124 <script_execute_line+0x20>
40002118: 7100811f     	cmp	w8, #0x20
4000211c: 54000121     	b.ne	0x40002140 <script_execute_line+0x3c>
40002120: 91000400     	add	x0, x0, #0x1
40002124: 39400008     	ldrb	w8, [x0]
40002128: 71007d1f     	cmp	w8, #0x1f
4000212c: 54ffff6c     	b.gt	0x40002118 <script_execute_line+0x14>
40002130: 7100251f     	cmp	w8, #0x9
40002134: 54ffff60     	b.eq	0x40002120 <script_execute_line+0x1c>
40002138: 34001d28     	cbz	w8, 0x400024dc <script_execute_line+0x3d8>
4000213c: 14000003     	b	0x40002148 <script_execute_line+0x44>
40002140: 71008d1f     	cmp	w8, #0x23
40002144: 54001cc0     	b.eq	0x400024dc <script_execute_line+0x3d8>
40002148: 910403e1     	add	x1, sp, #0x100
4000214c: 910403f3     	add	x19, sp, #0x100
40002150: 97ffff93     	bl	0x40001f9c <script_expand_vars>
40002154: 394403e8     	ldrb	w8, [sp, #0x100]
40002158: 34001be8     	cbz	w8, 0x400024d4 <script_execute_line+0x3d0>
4000215c: 0f018400     	movi	v0.4h, #0x20
40002160: 4f01e401     	movi	v1.16b, #0x20
40002164: 394407ea     	ldrb	w10, [sp, #0x101]
40002168: aa1f03e9     	mov	x9, xzr
4000216c: 9100426b     	add	x11, x19, #0x10
40002170: 2a0803ec     	mov	w12, w8
40002174: 14000004     	b	0x40002184 <script_execute_line+0x80>
40002178: 91000529     	add	x9, x9, #0x1
4000217c: 38696a6c     	ldrb	w12, [x19, x9]
40002180: 34000a2c     	cbz	w12, 0x400022c4 <script_execute_line+0x1c0>
40002184: b4ffffa9     	cbz	x9, 0x40002178 <script_execute_line+0x74>
40002188: 7100f59f     	cmp	w12, #0x3d
4000218c: 54ffff61     	b.ne	0x40002178 <script_execute_line+0x74>
40002190: 8b13012c     	add	x12, x9, x19
40002194: 385ff18d     	ldurb	w13, [x12, #-0x1]
40002198: 7100f5bf     	cmp	w13, #0x3d
4000219c: 54fffee0     	b.eq	0x40002178 <script_execute_line+0x74>
400021a0: 3940058c     	ldrb	w12, [x12, #0x1]
400021a4: 7100f59f     	cmp	w12, #0x3d
400021a8: 54fffe80     	b.eq	0x40002178 <script_execute_line+0x74>
400021ac: f100113f     	cmp	x9, #0x4
400021b0: 54000082     	b.hs	0x400021c0 <script_execute_line+0xbc>
400021b4: aa1f03ec     	mov	x12, xzr
400021b8: 2a1f03ed     	mov	w13, wzr
400021bc: 1400002f     	b	0x40002278 <script_execute_line+0x174>
400021c0: f100813f     	cmp	x9, #0x20
400021c4: 54000082     	b.hs	0x400021d4 <script_execute_line+0xd0>
400021c8: aa1f03ec     	mov	x12, xzr
400021cc: 2a1f03ed     	mov	w13, wzr
400021d0: 14000018     	b	0x40002230 <script_execute_line+0x12c>
400021d4: 6f00e402     	movi	v2.2d, #0000000000000000
400021d8: 6f00e403     	movi	v3.2d, #0000000000000000
400021dc: 927be92d     	and	x13, x9, #0xffffffffffffffe0
400021e0: 927be52c     	and	x12, x9, #0x7fffffffffffffe0
400021e4: aa0b03ee     	mov	x14, x11
400021e8: ad7f95c4     	ldp	q4, q5, [x14, #-0x10]
400021ec: f10081ad     	subs	x13, x13, #0x20
400021f0: 910081ce     	add	x14, x14, #0x20
400021f4: 6e218c84     	cmeq	v4.16b, v4.16b, v1.16b
400021f8: 6e218ca5     	cmeq	v5.16b, v5.16b, v1.16b
400021fc: 4ea41c42     	orr	v2.16b, v2.16b, v4.16b
40002200: 4ea51c63     	orr	v3.16b, v3.16b, v5.16b
40002204: 54ffff21     	b.ne	0x400021e8 <script_execute_line+0xe4>
40002208: 4ea21c62     	orr	v2.16b, v3.16b, v2.16b
4000220c: eb0c013f     	cmp	x9, x12
40002210: 4f0f5442     	shl	v2.16b, v2.16b, #0x7
40002214: 4e20a842     	cmlt	v2.16b, v2.16b, #0
40002218: 6e30a842     	umaxv	b2, v2.16b
4000221c: 1e26004d     	fmov	w13, s2
40002220: 120001ad     	and	w13, w13, #0x1
40002224: 540003a0     	b.eq	0x40002298 <script_execute_line+0x194>
40002228: f27e093f     	tst	x9, #0x1c
4000222c: 54000260     	b.eq	0x40002278 <script_execute_line+0x174>
40002230: 0e020da2     	dup	v2.4h, w13
40002234: 927ef52d     	and	x13, x9, #0xfffffffffffffffc
40002238: 8b0c026e     	add	x14, x19, x12
4000223c: cb0d018d     	sub	x13, x12, x13
40002240: 927ef12c     	and	x12, x9, #0x7ffffffffffffffc
40002244: bc4045c3     	ldr	s3, [x14], #0x4
40002248: b10011ad     	adds	x13, x13, #0x4
4000224c: 2f08a463     	ushll	v3.8h, v3.8b, #0x0
40002250: 2e608c63     	cmeq	v3.4h, v3.4h, v0.4h
40002254: 0ea31c42     	orr	v2.8b, v2.8b, v3.8b
40002258: 54ffff61     	b.ne	0x40002244 <script_execute_line+0x140>
4000225c: 0f1f5442     	shl	v2.4h, v2.4h, #0xf
40002260: eb0c013f     	cmp	x9, x12
40002264: 0e60a842     	cmlt	v2.4h, v2.4h, #0
40002268: 2e70a842     	umaxv	h2, v2.4h
4000226c: 1e26004d     	fmov	w13, s2
40002270: 120001ad     	and	w13, w13, #0x1
40002274: 54000120     	b.eq	0x40002298 <script_execute_line+0x194>
40002278: 386c6a6e     	ldrb	w14, [x19, x12]
4000227c: 9100058c     	add	x12, x12, #0x1
40002280: 710081df     	cmp	w14, #0x20
40002284: 1a9f15ad     	csinc	w13, w13, wzr, ne
40002288: eb0c013f     	cmp	x9, x12
4000228c: 54ffff61     	b.ne	0x40002278 <script_execute_line+0x174>
40002290: 710001bf     	cmp	w13, #0x0
40002294: 1a9f07ed     	cset	w13, ne
40002298: 3707f70d     	tbnz	w13, #0x0, 0x40002178 <script_execute_line+0x74>
4000229c: 7101a51f     	cmp	w8, #0x69
400022a0: 54fff6c0     	b.eq	0x40002178 <script_execute_line+0x74>
400022a4: 7101995f     	cmp	w10, #0x66
400022a8: 54fff680     	b.eq	0x40002178 <script_execute_line+0x74>
400022ac: 910403e8     	add	x8, sp, #0x100
400022b0: 910403e0     	add	x0, sp, #0x100
400022b4: 8b090101     	add	x1, x8, x9
400022b8: 3800143f     	strb	wzr, [x1], #0x1
400022bc: 97fffed7     	bl	0x40001e18 <script_set_var>
400022c0: 14000087     	b	0x400024dc <script_execute_line+0x3d8>
400022c4: 394403e8     	ldrb	w8, [sp, #0x100]
400022c8: 7101a51f     	cmp	w8, #0x69
400022cc: 54001041     	b.ne	0x400024d4 <script_execute_line+0x3d0>
400022d0: 7101995f     	cmp	w10, #0x66
400022d4: 54001001     	b.ne	0x400024d4 <script_execute_line+0x3d0>
400022d8: 39440be8     	ldrb	w8, [sp, #0x102]
400022dc: 7100811f     	cmp	w8, #0x20
400022e0: 54000fa1     	b.ne	0x400024d4 <script_execute_line+0x3d0>
400022e4: 39440fe9     	ldrb	w9, [sp, #0x103]
400022e8: 7100813f     	cmp	w9, #0x20
400022ec: 54000081     	b.ne	0x400022fc <script_execute_line+0x1f8>
400022f0: aa1f03e9     	mov	x9, xzr
400022f4: 52800068     	mov	w8, #0x3                // =3
400022f8: 14000014     	b	0x40002348 <script_execute_line+0x244>
400022fc: 910403ea     	add	x10, sp, #0x100
40002300: aa1f03e8     	mov	x8, xzr
40002304: 910303eb     	add	x11, sp, #0xc0
40002308: 9100114a     	add	x10, x10, #0x4
4000230c: 34000189     	cbz	w9, 0x4000233c <script_execute_line+0x238>
40002310: f100f91f     	cmp	x8, #0x3e
40002314: 54000148     	b.hi	0x4000233c <script_execute_line+0x238>
40002318: 38286969     	strb	w9, [x11, x8]
4000231c: 38686949     	ldrb	w9, [x10, x8]
40002320: 9100050c     	add	x12, x8, #0x1
40002324: aa0c03e8     	mov	x8, x12
40002328: 7100813f     	cmp	w9, #0x20
4000232c: 54ffff01     	b.ne	0x4000230c <script_execute_line+0x208>
40002330: 11000d8a     	add	w10, w12, #0x3
40002334: 2a0c03e8     	mov	w8, w12
40002338: 14000002     	b	0x40002340 <script_execute_line+0x23c>
4000233c: 11000d0a     	add	w10, w8, #0x3
40002340: 2a0803e9     	mov	w9, w8
40002344: 2a0a03e8     	mov	w8, w10
40002348: 910303ea     	add	x10, sp, #0xc0
4000234c: 3829695f     	strb	wzr, [x10, x9]
40002350: 910403e9     	add	x9, sp, #0x100
40002354: 3868692a     	ldrb	w10, [x9, x8]
40002358: 7100815f     	cmp	w10, #0x20
4000235c: 54000061     	b.ne	0x40002368 <script_execute_line+0x264>
40002360: 91000508     	add	x8, x8, #0x1
40002364: 17fffffc     	b	0x40002354 <script_execute_line+0x250>
40002368: 7100855f     	cmp	w10, #0x21
4000236c: 54000060     	b.eq	0x40002378 <script_execute_line+0x274>
40002370: 7100f55f     	cmp	w10, #0x3d
40002374: 540000e1     	b.ne	0x40002390 <script_execute_line+0x28c>
40002378: 11000509     	add	w9, w8, #0x1
4000237c: 910403ea     	add	x10, sp, #0x100
40002380: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002384: 9100090a     	add	x10, x8, #0x2
40002388: 7100f53f     	cmp	w9, #0x3d
4000238c: 9a880148     	csel	x8, x10, x8, eq
40002390: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002394: 910403ea     	add	x10, sp, #0x100
40002398: d2c0002b     	mov	x11, #0x100000000       // =4294967296
4000239c: 8b088129     	add	x9, x9, x8, lsl #32
400023a0: 8b28c14a     	add	x10, x10, w8, sxtw
400023a4: 51000508     	sub	w8, w8, #0x1
400023a8: 3840154c     	ldrb	w12, [x10], #0x1
400023ac: 8b0b0129     	add	x9, x9, x11
400023b0: 11000508     	add	w8, w8, #0x1
400023b4: 7100819f     	cmp	w12, #0x20
400023b8: 54ffff80     	b.eq	0x400023a8 <script_execute_line+0x2a4>
400023bc: 9360fd2c     	asr	x12, x9, #32
400023c0: 910403e9     	add	x9, sp, #0x100
400023c4: 386c692d     	ldrb	w13, [x9, x12]
400023c8: 710081bf     	cmp	w13, #0x20
400023cc: 54000061     	b.ne	0x400023d8 <script_execute_line+0x2d4>
400023d0: aa1f03ea     	mov	x10, xzr
400023d4: 14000010     	b	0x40002414 <script_execute_line+0x310>
400023d8: aa1f03eb     	mov	x11, xzr
400023dc: 910203ec     	add	x12, sp, #0x80
400023e0: 3400016d     	cbz	w13, 0x4000240c <script_execute_line+0x308>
400023e4: f100f97f     	cmp	x11, #0x3e
400023e8: 54000128     	b.hi	0x4000240c <script_execute_line+0x308>
400023ec: 382b698d     	strb	w13, [x12, x11]
400023f0: 386b694d     	ldrb	w13, [x10, x11]
400023f4: 9100056e     	add	x14, x11, #0x1
400023f8: 11000508     	add	w8, w8, #0x1
400023fc: aa0e03eb     	mov	x11, x14
40002400: 710081bf     	cmp	w13, #0x20
40002404: 54fffee1     	b.ne	0x400023e0 <script_execute_line+0x2dc>
40002408: 2a0e03eb     	mov	w11, w14
4000240c: 93407d0c     	sxtw	x12, w8
40002410: 2a0b03ea     	mov	w10, w11
40002414: d3607d8d     	lsl	x13, x12, #32
40002418: 910203eb     	add	x11, sp, #0x80
4000241c: d2c0006f     	mov	x15, #0x300000000       // =12884901888
40002420: d2c00050     	mov	x16, #0x200000000       // =8589934592
40002424: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002428: 11001108     	add	w8, w8, #0x4
4000242c: 382a697f     	strb	wzr, [x11, x10]
40002430: 8b0f01aa     	add	x10, x13, x15
40002434: 8b1001ab     	add	x11, x13, x16
40002438: 8b0e01ad     	add	x13, x13, x14
4000243c: 8b0c0129     	add	x9, x9, x12
40002440: 3840152c     	ldrb	w12, [x9], #0x1
40002444: 7100819f     	cmp	w12, #0x20
40002448: 540000c1     	b.ne	0x40002460 <script_execute_line+0x35c>
4000244c: 11000508     	add	w8, w8, #0x1
40002450: 8b0e014a     	add	x10, x10, x14
40002454: 8b0e016b     	add	x11, x11, x14
40002458: 8b0e01ad     	add	x13, x13, x14
4000245c: 17fffff9     	b	0x40002440 <script_execute_line+0x33c>
40002460: 7101d19f     	cmp	w12, #0x74
40002464: 54000381     	b.ne	0x400024d4 <script_execute_line+0x3d0>
40002468: 9360fdac     	asr	x12, x13, #32
4000246c: 910403e9     	add	x9, sp, #0x100
40002470: 386c692c     	ldrb	w12, [x9, x12]
40002474: 7101a19f     	cmp	w12, #0x68
40002478: 540002e1     	b.ne	0x400024d4 <script_execute_line+0x3d0>
4000247c: 9360fd6b     	asr	x11, x11, #32
40002480: 386b6929     	ldrb	w9, [x9, x11]
40002484: 7101953f     	cmp	w9, #0x65
40002488: 54000261     	b.ne	0x400024d4 <script_execute_line+0x3d0>
4000248c: 9360fd4a     	asr	x10, x10, #32
40002490: 910403e9     	add	x9, sp, #0x100
40002494: 386a692a     	ldrb	w10, [x9, x10]
40002498: 7101b95f     	cmp	w10, #0x6e
4000249c: 540001c1     	b.ne	0x400024d4 <script_execute_line+0x3d0>
400024a0: 8b28c128     	add	x8, x9, w8, sxtw
400024a4: d1000501     	sub	x1, x8, #0x1
400024a8: 38401c28     	ldrb	w8, [x1, #0x1]!
400024ac: 7100811f     	cmp	w8, #0x20
400024b0: 54ffffc0     	b.eq	0x400024a8 <script_execute_line+0x3a4>
400024b4: 910003e0     	mov	x0, sp
400024b8: 94000075     	bl	0x4000268c <kstrcpy>
400024bc: 910303e0     	add	x0, sp, #0xc0
400024c0: 910203e1     	add	x1, sp, #0x80
400024c4: 94000053     	bl	0x40002610 <kstrcmp>
400024c8: 350000a0     	cbnz	w0, 0x400024dc <script_execute_line+0x3d8>
400024cc: 910003e0     	mov	x0, sp
400024d0: 14000002     	b	0x400024d8 <script_execute_line+0x3d4>
400024d4: 910403e0     	add	x0, sp, #0x100
400024d8: 97fff9ac     	bl	0x40000b88 <execute_command>
400024dc: 2a1f03e0     	mov	w0, wzr
400024e0: 910803ff     	add	sp, sp, #0x200
400024e4: a9414ffc     	ldp	x28, x19, [sp, #0x10]
400024e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400024ec: d65f03c0     	ret

00000000400024f0 <script_run_file>:
400024f0: d10503ff     	sub	sp, sp, #0x140
400024f4: a9107bfd     	stp	x29, x30, [sp, #0x100]
400024f8: 910403fd     	add	x29, sp, #0x100
400024fc: f9008bfc     	str	x28, [sp, #0x110]
40002500: a91257f6     	stp	x22, x21, [sp, #0x120]
40002504: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002508: aa0003f4     	mov	x20, x0
4000250c: 940008f2     	bl	0x400048d4 <vfs_find>
40002510: b4000080     	cbz	x0, 0x40002520 <script_run_file+0x30>
40002514: b9402008     	ldr	w8, [x0, #0x20]
40002518: aa0003f3     	mov	x19, x0
4000251c: 340000e8     	cbz	w8, 0x40002538 <script_run_file+0x48>
40002520: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002524: 913bd800     	add	x0, x0, #0xef6
40002528: aa1403e1     	mov	x1, x20
4000252c: 9400050e     	bl	0x40003964 <uart_printf>
40002530: 12800000     	mov	w0, #-0x1               // =-1
40002534: 14000021     	b	0x400025b8 <script_run_file+0xc8>
40002538: f9401668     	ldr	x8, [x19, #0x28]
4000253c: aa1f03f4     	mov	x20, xzr
40002540: 2a1f03e9     	mov	w9, wzr
40002544: 9100c275     	add	x21, x19, #0x30
40002548: 910003f6     	mov	x22, sp
4000254c: 14000008     	b	0x4000256c <script_run_file+0x7c>
40002550: 7100053f     	cmp	w9, #0x1
40002554: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002558: 2a1f03e9     	mov	w9, wzr
4000255c: 5400022a     	b.ge	0x400025a0 <script_run_file+0xb0>
40002560: 91000694     	add	x20, x20, #0x1
40002564: eb08029f     	cmp	x20, x8
40002568: 54000268     	b.hi	0x400025b4 <script_run_file+0xc4>
4000256c: eb08029f     	cmp	x20, x8
40002570: 54ffff00     	b.eq	0x40002550 <script_run_file+0x60>
40002574: 38746aaa     	ldrb	w10, [x21, x20]
40002578: 7100295f     	cmp	w10, #0xa
4000257c: 54fffea0     	b.eq	0x40002550 <script_run_file+0x60>
40002580: 7100355f     	cmp	w10, #0xd
40002584: 54fffee0     	b.eq	0x40002560 <script_run_file+0x70>
40002588: 7103f93f     	cmp	w9, #0xfe
4000258c: 54fffeac     	b.gt	0x40002560 <script_run_file+0x70>
40002590: 1100052b     	add	w11, w9, #0x1
40002594: 3829caca     	strb	w10, [x22, w9, sxtw]
40002598: 2a0b03e9     	mov	w9, w11
4000259c: 17fffff1     	b	0x40002560 <script_run_file+0x70>
400025a0: 910003e0     	mov	x0, sp
400025a4: 97fffed8     	bl	0x40002104 <script_execute_line>
400025a8: f9401668     	ldr	x8, [x19, #0x28]
400025ac: 2a1f03e9     	mov	w9, wzr
400025b0: 17ffffec     	b	0x40002560 <script_run_file+0x70>
400025b4: 2a1f03e0     	mov	w0, wzr
400025b8: a9534ff4     	ldp	x20, x19, [sp, #0x130]
400025bc: f9408bfc     	ldr	x28, [sp, #0x110]
400025c0: a95257f6     	ldp	x22, x21, [sp, #0x120]
400025c4: a9507bfd     	ldp	x29, x30, [sp, #0x100]
400025c8: 910503ff     	add	sp, sp, #0x140
400025cc: d65f03c0     	ret

00000000400025d0 <kstrlen>:
400025d0: b40000c0     	cbz	x0, 0x400025e8 <kstrlen+0x18>
400025d4: aa1f03e8     	mov	x8, xzr
400025d8: 38686809     	ldrb	w9, [x0, x8]
400025dc: 91000508     	add	x8, x8, #0x1
400025e0: 35ffffc9     	cbnz	w9, 0x400025d8 <kstrlen+0x8>
400025e4: d1000500     	sub	x0, x8, #0x1
400025e8: d65f03c0     	ret

00000000400025ec <kstrcat>:
400025ec: b4000100     	cbz	x0, 0x4000260c <kstrcat+0x20>
400025f0: b40000e1     	cbz	x1, 0x4000260c <kstrcat+0x20>
400025f4: d1000408     	sub	x8, x0, #0x1
400025f8: 38401d09     	ldrb	w9, [x8, #0x1]!
400025fc: 35ffffe9     	cbnz	w9, 0x400025f8 <kstrcat+0xc>
40002600: 38401429     	ldrb	w9, [x1], #0x1
40002604: 38001509     	strb	w9, [x8], #0x1
40002608: 35ffffc9     	cbnz	w9, 0x40002600 <kstrcat+0x14>
4000260c: d65f03c0     	ret

0000000040002610 <kstrcmp>:
40002610: aa0003e8     	mov	x8, x0
40002614: 12800000     	mov	w0, #-0x1               // =-1
40002618: b4000188     	cbz	x8, 0x40002648 <kstrcmp+0x38>
4000261c: b4000161     	cbz	x1, 0x40002648 <kstrcmp+0x38>
40002620: 38401509     	ldrb	w9, [x8], #0x1
40002624: 340000e9     	cbz	w9, 0x40002640 <kstrcmp+0x30>
40002628: 3940002a     	ldrb	w10, [x1]
4000262c: 6b0a013f     	cmp	w9, w10
40002630: 54000081     	b.ne	0x40002640 <kstrcmp+0x30>
40002634: 38401509     	ldrb	w9, [x8], #0x1
40002638: 91000421     	add	x1, x1, #0x1
4000263c: 35ffff69     	cbnz	w9, 0x40002628 <kstrcmp+0x18>
40002640: 39400028     	ldrb	w8, [x1]
40002644: 4b080120     	sub	w0, w9, w8
40002648: d65f03c0     	ret

000000004000264c <kstrncmp>:
4000264c: 12800008     	mov	w8, #-0x1               // =-1
40002650: b4000160     	cbz	x0, 0x4000267c <kstrncmp+0x30>
40002654: b4000141     	cbz	x1, 0x4000267c <kstrncmp+0x30>
40002658: b4000102     	cbz	x2, 0x40002678 <kstrncmp+0x2c>
4000265c: 38401408     	ldrb	w8, [x0], #0x1
40002660: 38401429     	ldrb	w9, [x1], #0x1
40002664: 34000108     	cbz	w8, 0x40002684 <kstrncmp+0x38>
40002668: 6b09011f     	cmp	w8, w9
4000266c: 540000c1     	b.ne	0x40002684 <kstrncmp+0x38>
40002670: f1000442     	subs	x2, x2, #0x1
40002674: 54ffff41     	b.ne	0x4000265c <kstrncmp+0x10>
40002678: 2a1f03e8     	mov	w8, wzr
4000267c: 2a0803e0     	mov	w0, w8
40002680: d65f03c0     	ret
40002684: 4b090100     	sub	w0, w8, w9
40002688: d65f03c0     	ret

000000004000268c <kstrcpy>:
4000268c: b40000c0     	cbz	x0, 0x400026a4 <kstrcpy+0x18>
40002690: b40000a1     	cbz	x1, 0x400026a4 <kstrcpy+0x18>
40002694: aa0003e8     	mov	x8, x0
40002698: 38401429     	ldrb	w9, [x1], #0x1
4000269c: 38001509     	strb	w9, [x8], #0x1
400026a0: 35ffffc9     	cbnz	w9, 0x40002698 <kstrcpy+0xc>
400026a4: d65f03c0     	ret

00000000400026a8 <kstrncpy>:
400026a8: b4000660     	cbz	x0, 0x40002774 <kstrncpy+0xcc>
400026ac: b4000641     	cbz	x1, 0x40002774 <kstrncpy+0xcc>
400026b0: b4000622     	cbz	x2, 0x40002774 <kstrncpy+0xcc>
400026b4: aa0003e9     	mov	x9, x0
400026b8: 9100440a     	add	x10, x0, #0x11
400026bc: aa0003e8     	mov	x8, x0
400026c0: 3840142b     	ldrb	w11, [x1], #0x1
400026c4: 3800150b     	strb	w11, [x8], #0x1
400026c8: 340000cb     	cbz	w11, 0x400026e0 <kstrncpy+0x38>
400026cc: f1000442     	subs	x2, x2, #0x1
400026d0: 9100054a     	add	x10, x10, #0x1
400026d4: aa0803e9     	mov	x9, x8
400026d8: 54ffff41     	b.ne	0x400026c0 <kstrncpy+0x18>
400026dc: 14000026     	b	0x40002774 <kstrncpy+0xcc>
400026e0: f1001c5f     	cmp	x2, #0x7
400026e4: 54000068     	b.hi	0x400026f0 <kstrncpy+0x48>
400026e8: aa0203ea     	mov	x10, x2
400026ec: 1400001f     	b	0x40002768 <kstrncpy+0xc0>
400026f0: f100805f     	cmp	x2, #0x20
400026f4: 54000062     	b.hs	0x40002700 <kstrncpy+0x58>
400026f8: aa1f03eb     	mov	x11, xzr
400026fc: 1400000c     	b	0x4000272c <kstrncpy+0x84>
40002700: 6f00e400     	movi	v0.2d, #0000000000000000
40002704: 927be84b     	and	x11, x2, #0xffffffffffffffe0
40002708: aa0b03ec     	mov	x12, x11
4000270c: f100818c     	subs	x12, x12, #0x20
40002710: ad3f8140     	stp	q0, q0, [x10, #-0x10]
40002714: 9100814a     	add	x10, x10, #0x20
40002718: 54ffffa1     	b.ne	0x4000270c <kstrncpy+0x64>
4000271c: eb0b005f     	cmp	x2, x11
40002720: 540002a0     	b.eq	0x40002774 <kstrncpy+0xcc>
40002724: f27d045f     	tst	x2, #0x18
40002728: 540001c0     	b.eq	0x40002760 <kstrncpy+0xb8>
4000272c: 6f00e400     	movi	v0.2d, #0000000000000000
40002730: 927df04c     	and	x12, x2, #0xfffffffffffffff8
40002734: 9240084a     	and	x10, x2, #0x7
40002738: 8b0c0108     	add	x8, x8, x12
4000273c: cb0c016d     	sub	x13, x11, x12
40002740: 9100056b     	add	x11, x11, #0x1
40002744: b10021ad     	adds	x13, x13, #0x8
40002748: fc2b6920     	str	d0, [x9, x11]
4000274c: 9100216b     	add	x11, x11, #0x8
40002750: 54ffffa1     	b.ne	0x40002744 <kstrncpy+0x9c>
40002754: eb0c005f     	cmp	x2, x12
40002758: 54000081     	b.ne	0x40002768 <kstrncpy+0xc0>
4000275c: 14000006     	b	0x40002774 <kstrncpy+0xcc>
40002760: 9240104a     	and	x10, x2, #0x1f
40002764: 8b0b0108     	add	x8, x8, x11
40002768: f100054a     	subs	x10, x10, #0x1
4000276c: 3800151f     	strb	wzr, [x8], #0x1
40002770: 54ffffc1     	b.ne	0x40002768 <kstrncpy+0xc0>
40002774: d65f03c0     	ret

0000000040002778 <kmemset>:
40002778: b4000500     	cbz	x0, 0x40002818 <kmemset+0xa0>
4000277c: b40004e2     	cbz	x2, 0x40002818 <kmemset+0xa0>
40002780: f100205f     	cmp	x2, #0x8
40002784: 54000082     	b.hs	0x40002794 <kmemset+0x1c>
40002788: aa0003e8     	mov	x8, x0
4000278c: aa0203e9     	mov	x9, x2
40002790: 1400001f     	b	0x4000280c <kmemset+0x94>
40002794: f100805f     	cmp	x2, #0x20
40002798: 54000062     	b.hs	0x400027a4 <kmemset+0x2c>
4000279c: aa1f03ea     	mov	x10, xzr
400027a0: 1400000d     	b	0x400027d4 <kmemset+0x5c>
400027a4: 4e010c20     	dup	v0.16b, w1
400027a8: 927be84a     	and	x10, x2, #0xffffffffffffffe0
400027ac: 91004008     	add	x8, x0, #0x10
400027b0: aa0a03e9     	mov	x9, x10
400027b4: f1008129     	subs	x9, x9, #0x20
400027b8: ad3f8100     	stp	q0, q0, [x8, #-0x10]
400027bc: 91008108     	add	x8, x8, #0x20
400027c0: 54ffffa1     	b.ne	0x400027b4 <kmemset+0x3c>
400027c4: eb0a005f     	cmp	x2, x10
400027c8: 54000280     	b.eq	0x40002818 <kmemset+0xa0>
400027cc: f27d045f     	tst	x2, #0x18
400027d0: 540001a0     	b.eq	0x40002804 <kmemset+0x8c>
400027d4: 0e010c20     	dup	v0.8b, w1
400027d8: 927df04b     	and	x11, x2, #0xfffffffffffffff8
400027dc: 92400849     	and	x9, x2, #0x7
400027e0: 8b0b0008     	add	x8, x0, x11
400027e4: cb0b014c     	sub	x12, x10, x11
400027e8: 8b0a000a     	add	x10, x0, x10
400027ec: b100218c     	adds	x12, x12, #0x8
400027f0: fc008540     	str	d0, [x10], #0x8
400027f4: 54ffffc1     	b.ne	0x400027ec <kmemset+0x74>
400027f8: eb0b005f     	cmp	x2, x11
400027fc: 54000081     	b.ne	0x4000280c <kmemset+0x94>
40002800: 14000006     	b	0x40002818 <kmemset+0xa0>
40002804: 8b0a0008     	add	x8, x0, x10
40002808: 92401049     	and	x9, x2, #0x1f
4000280c: f1000529     	subs	x9, x9, #0x1
40002810: 38001501     	strb	w1, [x8], #0x1
40002814: 54ffffc1     	b.ne	0x4000280c <kmemset+0x94>
40002818: d65f03c0     	ret

000000004000281c <kmemcpy>:
4000281c: b4000660     	cbz	x0, 0x400028e8 <kmemcpy+0xcc>
40002820: b4000641     	cbz	x1, 0x400028e8 <kmemcpy+0xcc>
40002824: b4000622     	cbz	x2, 0x400028e8 <kmemcpy+0xcc>
40002828: f100205f     	cmp	x2, #0x8
4000282c: 54000103     	b.lo	0x4000284c <kmemcpy+0x30>
40002830: cb010008     	sub	x8, x0, x1
40002834: f100811f     	cmp	x8, #0x20
40002838: 540000a3     	b.lo	0x4000284c <kmemcpy+0x30>
4000283c: f100805f     	cmp	x2, #0x20
40002840: 540000e2     	b.hs	0x4000285c <kmemcpy+0x40>
40002844: aa1f03eb     	mov	x11, xzr
40002848: 14000013     	b	0x40002894 <kmemcpy+0x78>
4000284c: aa0103e8     	mov	x8, x1
40002850: aa0003e9     	mov	x9, x0
40002854: aa0203ea     	mov	x10, x2
40002858: 14000020     	b	0x400028d8 <kmemcpy+0xbc>
4000285c: 927be84b     	and	x11, x2, #0xffffffffffffffe0
40002860: 91004008     	add	x8, x0, #0x10
40002864: 91004029     	add	x9, x1, #0x10
40002868: aa0b03ea     	mov	x10, x11
4000286c: ad7f8520     	ldp	q0, q1, [x9, #-0x10]
40002870: f100814a     	subs	x10, x10, #0x20
40002874: 91008129     	add	x9, x9, #0x20
40002878: ad3f8500     	stp	q0, q1, [x8, #-0x10]
4000287c: 91008108     	add	x8, x8, #0x20
40002880: 54ffff61     	b.ne	0x4000286c <kmemcpy+0x50>
40002884: eb0b005f     	cmp	x2, x11
40002888: 54000300     	b.eq	0x400028e8 <kmemcpy+0xcc>
4000288c: f27d045f     	tst	x2, #0x18
40002890: 540001e0     	b.eq	0x400028cc <kmemcpy+0xb0>
40002894: 927df04c     	and	x12, x2, #0xfffffffffffffff8
40002898: 9240084a     	and	x10, x2, #0x7
4000289c: 8b0b000e     	add	x14, x0, x11
400028a0: 8b0c0028     	add	x8, x1, x12
400028a4: 8b0c0009     	add	x9, x0, x12
400028a8: cb0c016d     	sub	x13, x11, x12
400028ac: 8b0b002b     	add	x11, x1, x11
400028b0: fc408560     	ldr	d0, [x11], #0x8
400028b4: b10021ad     	adds	x13, x13, #0x8
400028b8: fc0085c0     	str	d0, [x14], #0x8
400028bc: 54ffffa1     	b.ne	0x400028b0 <kmemcpy+0x94>
400028c0: eb0c005f     	cmp	x2, x12
400028c4: 540000a1     	b.ne	0x400028d8 <kmemcpy+0xbc>
400028c8: 14000008     	b	0x400028e8 <kmemcpy+0xcc>
400028cc: 8b0b0028     	add	x8, x1, x11
400028d0: 8b0b0009     	add	x9, x0, x11
400028d4: 9240104a     	and	x10, x2, #0x1f
400028d8: 3840150b     	ldrb	w11, [x8], #0x1
400028dc: f100054a     	subs	x10, x10, #0x1
400028e0: 3800152b     	strb	w11, [x9], #0x1
400028e4: 54ffffa1     	b.ne	0x400028d8 <kmemcpy+0xbc>
400028e8: d65f03c0     	ret

00000000400028ec <kstrstr>:
400028ec: aa1f03e2     	mov	x2, xzr
400028f0: b40000e0     	cbz	x0, 0x4000290c <kstrstr+0x20>
400028f4: b40000c1     	cbz	x1, 0x4000290c <kstrstr+0x20>
400028f8: 39400028     	ldrb	w8, [x1]
400028fc: 340002c8     	cbz	w8, 0x40002954 <kstrstr+0x68>
40002900: 39400009     	ldrb	w9, [x0]
40002904: 35000109     	cbnz	w9, 0x40002924 <kstrstr+0x38>
40002908: aa1f03e2     	mov	x2, xzr
4000290c: aa0203e0     	mov	x0, x2
40002910: d65f03c0     	ret
40002914: 3940012c     	ldrb	w12, [x9]
40002918: 340001ec     	cbz	w12, 0x40002954 <kstrstr+0x68>
4000291c: 38401c09     	ldrb	w9, [x0, #0x1]!
40002920: 34ffff49     	cbz	w9, 0x40002908 <kstrstr+0x1c>
40002924: 6b08013f     	cmp	w9, w8
40002928: 54ffffa1     	b.ne	0x4000291c <kstrstr+0x30>
4000292c: 5280002a     	mov	w10, #0x1               // =1
40002930: aa0103e9     	mov	x9, x1
40002934: 2a0803eb     	mov	w11, w8
40002938: 3840152c     	ldrb	w12, [x9], #0x1
4000293c: 6b0c017f     	cmp	w11, w12
40002940: 54fffec1     	b.ne	0x40002918 <kstrstr+0x2c>
40002944: 386a680b     	ldrb	w11, [x0, x10]
40002948: 9100054a     	add	x10, x10, #0x1
4000294c: 35ffff6b     	cbnz	w11, 0x40002938 <kstrstr+0x4c>
40002950: 17fffff1     	b	0x40002914 <kstrstr+0x28>
40002954: d65f03c0     	ret

0000000040002958 <kstrchr>:
40002958: b4000140     	cbz	x0, 0x40002980 <kstrchr+0x28>
4000295c: 39400009     	ldrb	w9, [x0]
40002960: 340000c9     	cbz	w9, 0x40002978 <kstrchr+0x20>
40002964: 12001c28     	and	w8, w1, #0xff
40002968: 6b08013f     	cmp	w9, w8
4000296c: 540000a0     	b.eq	0x40002980 <kstrchr+0x28>
40002970: 38401c09     	ldrb	w9, [x0, #0x1]!
40002974: 35ffffa9     	cbnz	w9, 0x40002968 <kstrchr+0x10>
40002978: 72001c3f     	tst	w1, #0xff
4000297c: 9a9f0000     	csel	x0, x0, xzr, eq
40002980: d65f03c0     	ret

0000000040002984 <ktolower>:
40002984: 51010408     	sub	w8, w0, #0x41
40002988: 321b0009     	orr	w9, w0, #0x20
4000298c: 7100691f     	cmp	w8, #0x1a
40002990: 1a803120     	csel	w0, w9, w0, lo
40002994: d65f03c0     	ret

0000000040002998 <kstr_tolower>:
40002998: b40001a0     	cbz	x0, 0x400029cc <kstr_tolower+0x34>
4000299c: b4000181     	cbz	x1, 0x400029cc <kstr_tolower+0x34>
400029a0: 39400029     	ldrb	w9, [x1]
400029a4: 34000129     	cbz	w9, 0x400029c8 <kstr_tolower+0x30>
400029a8: 91000428     	add	x8, x1, #0x1
400029ac: 5101052a     	sub	w10, w9, #0x41
400029b0: 321b012b     	orr	w11, w9, #0x20
400029b4: 7100695f     	cmp	w10, #0x1a
400029b8: 1a893169     	csel	w9, w11, w9, lo
400029bc: 38001409     	strb	w9, [x0], #0x1
400029c0: 38401509     	ldrb	w9, [x8], #0x1
400029c4: 35ffff49     	cbnz	w9, 0x400029ac <kstr_tolower+0x14>
400029c8: 3900001f     	strb	wzr, [x0]
400029cc: d65f03c0     	ret

00000000400029d0 <tui_launch>:
400029d0: d105c3ff     	sub	sp, sp, #0x170
400029d4: a9117bfd     	stp	x29, x30, [sp, #0x110]
400029d8: 910443fd     	add	x29, sp, #0x110
400029dc: a9126ffc     	stp	x28, x27, [sp, #0x120]
400029e0: a91367fa     	stp	x26, x25, [sp, #0x130]
400029e4: a9145ff8     	stp	x24, x23, [sp, #0x140]
400029e8: a91557f6     	stp	x22, x21, [sp, #0x150]
400029ec: a9164ff4     	stp	x20, x19, [sp, #0x160]
400029f0: 9400074b     	bl	0x4000471c <vfs_get_cwd>
400029f4: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
400029f8: 9000007c     	adrp	x28, 0x4000e000 <var_values+0x6a8>
400029fc: 9000007b     	adrp	x27, 0x4000e000 <var_values+0x6a8>
40002a00: f904ad00     	str	x0, [x8, #0x958]
40002a04: d503201f     	nop
40002a08: 70025f20     	adr	x0, 0x400075ef <__rodata_start+0x15ef>
40002a0c: b909639f     	str	wzr, [x28, #0x960]
40002a10: b909677f     	str	wzr, [x27, #0x964]
40002a14: 940002c4     	bl	0x40003524 <uart_puts>
40002a18: 90000036     	adrp	x22, 0x40006000 <__rodata_start>
40002a1c: 910e7ed6     	add	x22, x22, #0x39f
40002a20: 90000037     	adrp	x23, 0x40006000 <__rodata_start>
40002a24: 910aeef7     	add	x23, x23, #0x2bb
40002a28: 90000073     	adrp	x19, 0x4000e000 <var_values+0x6a8>
40002a2c: 9125c273     	add	x19, x19, #0x970
40002a30: 9000007a     	adrp	x26, 0x4000e000 <var_values+0x6a8>
40002a34: 14000005     	b	0x40002a48 <tui_launch+0x78>
40002a38: b9496388     	ldr	w8, [x28, #0x960]
40002a3c: 7100011f     	cmp	w8, #0x0
40002a40: 1a9f17e8     	cset	w8, eq
40002a44: b9096388     	str	w8, [x28, #0x960]
40002a48: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40002a4c: b9096b5f     	str	wzr, [x26, #0x968]
40002a50: f944ad0a     	ldr	x10, [x8, #0x958]
40002a54: f9421948     	ldr	x8, [x10, #0x430]
40002a58: b4000108     	cbz	x8, 0x40002a78 <tui_launch+0xa8>
40002a5c: 52800029     	mov	w9, #0x1                // =1
40002a60: 90000068     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40002a64: b9096b49     	str	w9, [x26, #0x968]
40002a68: f904b91f     	str	xzr, [x8, #0x970]
40002a6c: f9401548     	ldr	x8, [x10, #0x28]
40002a70: b50000a8     	cbnz	x8, 0x40002a84 <tui_launch+0xb4>
40002a74: 14000028     	b	0x40002b14 <tui_launch+0x144>
40002a78: 2a1f03e9     	mov	w9, wzr
40002a7c: f9401548     	ldr	x8, [x10, #0x28]
40002a80: b40004a8     	cbz	x8, 0x40002b14 <tui_launch+0x144>
40002a84: 2a0903e9     	mov	w9, w9
40002a88: d100050b     	sub	x11, x8, #0x1
40002a8c: d240152c     	eor	x12, x9, #0x3f
40002a90: eb0c017f     	cmp	x11, x12
40002a94: 9a8c316b     	csel	x11, x11, x12, lo
40002a98: f1000d7f     	cmp	x11, #0x3
40002a9c: 54000062     	b.hs	0x40002aa8 <tui_launch+0xd8>
40002aa0: aa1f03eb     	mov	x11, xzr
40002aa4: 14000010     	b	0x40002ae4 <tui_launch+0x114>
40002aa8: 9100056c     	add	x12, x11, #0x1
40002aac: 8b090e6d     	add	x13, x19, x9, lsl #3
40002ab0: 9111214e     	add	x14, x10, #0x448
40002ab4: 927e758b     	and	x11, x12, #0xfffffffc
40002ab8: aa090169     	orr	x9, x11, x9
40002abc: 910041ad     	add	x13, x13, #0x10
40002ac0: aa0b03ef     	mov	x15, x11
40002ac4: ad7f85c0     	ldp	q0, q1, [x14, #-0x10]
40002ac8: f10011ef     	subs	x15, x15, #0x4
40002acc: 910081ce     	add	x14, x14, #0x20
40002ad0: ad3f85a0     	stp	q0, q1, [x13, #-0x10]
40002ad4: 910081ad     	add	x13, x13, #0x20
40002ad8: 54ffff61     	b.ne	0x40002ac4 <tui_launch+0xf4>
40002adc: eb0b019f     	cmp	x12, x11
40002ae0: 54000180     	b.eq	0x40002b10 <tui_launch+0x140>
40002ae4: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002ae8: 9100056b     	add	x11, x11, #0x1
40002aec: 9110e14a     	add	x10, x10, #0x438
40002af0: f840854c     	ldr	x12, [x10], #0x8
40002af4: f100f93f     	cmp	x9, #0x3e
40002af8: f8297a6c     	str	x12, [x19, x9, lsl #3]
40002afc: 91000529     	add	x9, x9, #0x1
40002b00: 54000088     	b.hi	0x40002b10 <tui_launch+0x140>
40002b04: eb08017f     	cmp	x11, x8
40002b08: 9100056b     	add	x11, x11, #0x1
40002b0c: 54ffff23     	b.lo	0x40002af0 <tui_launch+0x120>
40002b10: b9096b49     	str	w9, [x26, #0x968]
40002b14: b949676a     	ldr	w10, [x27, #0x964]
40002b18: 51000528     	sub	w8, w9, #0x1
40002b1c: 6b08015f     	cmp	w10, w8
40002b20: 1a88b148     	csel	w8, w10, w8, lt
40002b24: 6b09015f     	cmp	w10, w9
40002b28: 5400004a     	b.ge	0x40002b30 <tui_launch+0x160>
40002b2c: 36f80068     	tbz	w8, #0x1f, 0x40002b38 <tui_launch+0x168>
40002b30: 0aa87d08     	bic	w8, w8, w8, asr #31
40002b34: b9096768     	str	w8, [x27, #0x964]
40002b38: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002b3c: 91211800     	add	x0, x0, #0x846
40002b40: 94000279     	bl	0x40003524 <uart_puts>
40002b44: b9496388     	ldr	w8, [x28, #0x960]
40002b48: 52800020     	mov	w0, #0x1                // =1
40002b4c: 52800501     	mov	w1, #0x28               // =40
40002b50: 90000022     	adrp	x2, 0x40006000 <__rodata_start>
40002b54: 9102c842     	add	x2, x2, #0xb2
40002b58: 7100011f     	cmp	w8, #0x0
40002b5c: 1a9f17e3     	cset	w3, eq
40002b60: 94000171     	bl	0x40003124 <draw_box>
40002b64: 52800075     	mov	w21, #0x3               // =3
40002b68: aa1603e0     	mov	x0, x22
40002b6c: 2a1503e1     	mov	w1, w21
40002b70: 52800042     	mov	w2, #0x2                // =2
40002b74: 9400037c     	bl	0x40003964 <uart_printf>
40002b78: aa1703e0     	mov	x0, x23
40002b7c: 9400026a     	bl	0x40003524 <uart_puts>
40002b80: aa1703e0     	mov	x0, x23
40002b84: 94000268     	bl	0x40003524 <uart_puts>
40002b88: aa1703e0     	mov	x0, x23
40002b8c: 94000266     	bl	0x40003524 <uart_puts>
40002b90: aa1703e0     	mov	x0, x23
40002b94: 94000264     	bl	0x40003524 <uart_puts>
40002b98: aa1703e0     	mov	x0, x23
40002b9c: 94000262     	bl	0x40003524 <uart_puts>
40002ba0: aa1703e0     	mov	x0, x23
40002ba4: 94000260     	bl	0x40003524 <uart_puts>
40002ba8: aa1703e0     	mov	x0, x23
40002bac: 9400025e     	bl	0x40003524 <uart_puts>
40002bb0: aa1703e0     	mov	x0, x23
40002bb4: 9400025c     	bl	0x40003524 <uart_puts>
40002bb8: aa1703e0     	mov	x0, x23
40002bbc: 9400025a     	bl	0x40003524 <uart_puts>
40002bc0: aa1703e0     	mov	x0, x23
40002bc4: 94000258     	bl	0x40003524 <uart_puts>
40002bc8: aa1703e0     	mov	x0, x23
40002bcc: 94000256     	bl	0x40003524 <uart_puts>
40002bd0: aa1703e0     	mov	x0, x23
40002bd4: 94000254     	bl	0x40003524 <uart_puts>
40002bd8: aa1703e0     	mov	x0, x23
40002bdc: 94000252     	bl	0x40003524 <uart_puts>
40002be0: aa1703e0     	mov	x0, x23
40002be4: 94000250     	bl	0x40003524 <uart_puts>
40002be8: aa1703e0     	mov	x0, x23
40002bec: 9400024e     	bl	0x40003524 <uart_puts>
40002bf0: aa1703e0     	mov	x0, x23
40002bf4: 9400024c     	bl	0x40003524 <uart_puts>
40002bf8: aa1703e0     	mov	x0, x23
40002bfc: 9400024a     	bl	0x40003524 <uart_puts>
40002c00: aa1703e0     	mov	x0, x23
40002c04: 94000248     	bl	0x40003524 <uart_puts>
40002c08: aa1703e0     	mov	x0, x23
40002c0c: 94000246     	bl	0x40003524 <uart_puts>
40002c10: aa1703e0     	mov	x0, x23
40002c14: 94000244     	bl	0x40003524 <uart_puts>
40002c18: aa1703e0     	mov	x0, x23
40002c1c: 94000242     	bl	0x40003524 <uart_puts>
40002c20: aa1703e0     	mov	x0, x23
40002c24: 94000240     	bl	0x40003524 <uart_puts>
40002c28: aa1703e0     	mov	x0, x23
40002c2c: 9400023e     	bl	0x40003524 <uart_puts>
40002c30: aa1703e0     	mov	x0, x23
40002c34: 9400023c     	bl	0x40003524 <uart_puts>
40002c38: aa1703e0     	mov	x0, x23
40002c3c: 9400023a     	bl	0x40003524 <uart_puts>
40002c40: aa1703e0     	mov	x0, x23
40002c44: 94000238     	bl	0x40003524 <uart_puts>
40002c48: aa1703e0     	mov	x0, x23
40002c4c: 94000236     	bl	0x40003524 <uart_puts>
40002c50: aa1703e0     	mov	x0, x23
40002c54: 94000234     	bl	0x40003524 <uart_puts>
40002c58: aa1703e0     	mov	x0, x23
40002c5c: 94000232     	bl	0x40003524 <uart_puts>
40002c60: aa1703e0     	mov	x0, x23
40002c64: 94000230     	bl	0x40003524 <uart_puts>
40002c68: aa1703e0     	mov	x0, x23
40002c6c: 9400022e     	bl	0x40003524 <uart_puts>
40002c70: aa1703e0     	mov	x0, x23
40002c74: 9400022c     	bl	0x40003524 <uart_puts>
40002c78: aa1703e0     	mov	x0, x23
40002c7c: 9400022a     	bl	0x40003524 <uart_puts>
40002c80: aa1703e0     	mov	x0, x23
40002c84: 94000228     	bl	0x40003524 <uart_puts>
40002c88: aa1703e0     	mov	x0, x23
40002c8c: 94000226     	bl	0x40003524 <uart_puts>
40002c90: aa1703e0     	mov	x0, x23
40002c94: 94000224     	bl	0x40003524 <uart_puts>
40002c98: aa1703e0     	mov	x0, x23
40002c9c: 94000222     	bl	0x40003524 <uart_puts>
40002ca0: aa1703e0     	mov	x0, x23
40002ca4: 94000220     	bl	0x40003524 <uart_puts>
40002ca8: 110006b5     	add	w21, w21, #0x1
40002cac: 71005ebf     	cmp	w21, #0x17
40002cb0: 54fff5c1     	b.ne	0x40002b68 <tui_launch+0x198>
40002cb4: b9496768     	ldr	w8, [x27, #0x964]
40002cb8: 52800249     	mov	w9, #0x12               // =18
40002cbc: aa1f03f8     	mov	x24, xzr
40002cc0: 7100491f     	cmp	w8, #0x12
40002cc4: 1a89c108     	csel	w8, w8, w9, gt
40002cc8: 51004915     	sub	w21, w8, #0x12
40002ccc: 8b354e79     	add	x25, x19, w21, uxtw #3
40002cd0: 14000004     	b	0x40002ce0 <tui_launch+0x310>
40002cd4: 91000718     	add	x24, x24, #0x1
40002cd8: f100531f     	cmp	x24, #0x14
40002cdc: 540005a0     	b.eq	0x40002d90 <tui_launch+0x3c0>
40002ce0: b9896b48     	ldrsw	x8, [x26, #0x968]
40002ce4: 8b1802b4     	add	x20, x21, x24
40002ce8: eb08029f     	cmp	x20, x8
40002cec: 5400052a     	b.ge	0x40002d90 <tui_launch+0x3c0>
40002cf0: 11000f01     	add	w1, w24, #0x3
40002cf4: aa1603e0     	mov	x0, x22
40002cf8: 52800062     	mov	w2, #0x3                // =3
40002cfc: 9400031a     	bl	0x40003964 <uart_printf>
40002d00: b9496768     	ldr	w8, [x27, #0x964]
40002d04: eb08029f     	cmp	x20, x8
40002d08: 540000c1     	b.ne	0x40002d20 <tui_launch+0x350>
40002d0c: b9496388     	ldr	w8, [x28, #0x960]
40002d10: 35000088     	cbnz	w8, 0x40002d20 <tui_launch+0x350>
40002d14: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002d18: 91030800     	add	x0, x0, #0xc2
40002d1c: 94000202     	bl	0x40003524 <uart_puts>
40002d20: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40002d24: b40001e8     	cbz	x8, 0x40002d60 <tui_launch+0x390>
40002d28: b9402108     	ldr	w8, [x8, #0x20]
40002d2c: b0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40002d30: 9102ed29     	add	x9, x9, #0xbb
40002d34: 910223e0     	add	x0, sp, #0x88
40002d38: 7100051f     	cmp	w8, #0x1
40002d3c: 90000028     	adrp	x8, 0x40006000 <__rodata_start>
40002d40: 9130e108     	add	x8, x8, #0xc38
40002d44: 9a880121     	csel	x1, x9, x8, eq
40002d48: 97fffe51     	bl	0x4000268c <kstrcpy>
40002d4c: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40002d50: 910223e0     	add	x0, sp, #0x88
40002d54: 97fffe26     	bl	0x400025ec <kstrcat>
40002d58: 910223e0     	add	x0, sp, #0x88
40002d5c: 14000003     	b	0x40002d68 <tui_launch+0x398>
40002d60: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002d64: 912bc000     	add	x0, x0, #0xaf0
40002d68: 940001ef     	bl	0x40003524 <uart_puts>
40002d6c: b9496768     	ldr	w8, [x27, #0x964]
40002d70: eb08029f     	cmp	x20, x8
40002d74: 54fffb01     	b.ne	0x40002cd4 <tui_launch+0x304>
40002d78: b9496388     	ldr	w8, [x28, #0x960]
40002d7c: 35fffac8     	cbnz	w8, 0x40002cd4 <tui_launch+0x304>
40002d80: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40002d84: 91202800     	add	x0, x0, #0x80a
40002d88: 940001e7     	bl	0x40003524 <uart_puts>
40002d8c: 17ffffd2     	b	0x40002cd4 <tui_launch+0x304>
40002d90: b9496388     	ldr	w8, [x28, #0x960]
40002d94: 52800540     	mov	w0, #0x2a               // =42
40002d98: 528004c1     	mov	w1, #0x26               // =38
40002d9c: 90000022     	adrp	x2, 0x40006000 <__rodata_start>
40002da0: 913c4c42     	add	x2, x2, #0xf13
40002da4: 7100051f     	cmp	w8, #0x1
40002da8: 1a9f17e3     	cset	w3, eq
40002dac: 940000de     	bl	0x40003124 <draw_box>
40002db0: 52800075     	mov	w21, #0x3               // =3
40002db4: aa1603e0     	mov	x0, x22
40002db8: 2a1503e1     	mov	w1, w21
40002dbc: 52800562     	mov	w2, #0x2b               // =43
40002dc0: 940002e9     	bl	0x40003964 <uart_printf>
40002dc4: aa1703e0     	mov	x0, x23
40002dc8: 940001d7     	bl	0x40003524 <uart_puts>
40002dcc: aa1703e0     	mov	x0, x23
40002dd0: 940001d5     	bl	0x40003524 <uart_puts>
40002dd4: aa1703e0     	mov	x0, x23
40002dd8: 940001d3     	bl	0x40003524 <uart_puts>
40002ddc: aa1703e0     	mov	x0, x23
40002de0: 940001d1     	bl	0x40003524 <uart_puts>
40002de4: aa1703e0     	mov	x0, x23
40002de8: 940001cf     	bl	0x40003524 <uart_puts>
40002dec: aa1703e0     	mov	x0, x23
40002df0: 940001cd     	bl	0x40003524 <uart_puts>
40002df4: aa1703e0     	mov	x0, x23
40002df8: 940001cb     	bl	0x40003524 <uart_puts>
40002dfc: aa1703e0     	mov	x0, x23
40002e00: 940001c9     	bl	0x40003524 <uart_puts>
40002e04: aa1703e0     	mov	x0, x23
40002e08: 940001c7     	bl	0x40003524 <uart_puts>
40002e0c: aa1703e0     	mov	x0, x23
40002e10: 940001c5     	bl	0x40003524 <uart_puts>
40002e14: aa1703e0     	mov	x0, x23
40002e18: 940001c3     	bl	0x40003524 <uart_puts>
40002e1c: aa1703e0     	mov	x0, x23
40002e20: 940001c1     	bl	0x40003524 <uart_puts>
40002e24: aa1703e0     	mov	x0, x23
40002e28: 940001bf     	bl	0x40003524 <uart_puts>
40002e2c: aa1703e0     	mov	x0, x23
40002e30: 940001bd     	bl	0x40003524 <uart_puts>
40002e34: aa1703e0     	mov	x0, x23
40002e38: 940001bb     	bl	0x40003524 <uart_puts>
40002e3c: aa1703e0     	mov	x0, x23
40002e40: 940001b9     	bl	0x40003524 <uart_puts>
40002e44: aa1703e0     	mov	x0, x23
40002e48: 940001b7     	bl	0x40003524 <uart_puts>
40002e4c: aa1703e0     	mov	x0, x23
40002e50: 940001b5     	bl	0x40003524 <uart_puts>
40002e54: aa1703e0     	mov	x0, x23
40002e58: 940001b3     	bl	0x40003524 <uart_puts>
40002e5c: aa1703e0     	mov	x0, x23
40002e60: 940001b1     	bl	0x40003524 <uart_puts>
40002e64: aa1703e0     	mov	x0, x23
40002e68: 940001af     	bl	0x40003524 <uart_puts>
40002e6c: aa1703e0     	mov	x0, x23
40002e70: 940001ad     	bl	0x40003524 <uart_puts>
40002e74: aa1703e0     	mov	x0, x23
40002e78: 940001ab     	bl	0x40003524 <uart_puts>
40002e7c: aa1703e0     	mov	x0, x23
40002e80: 940001a9     	bl	0x40003524 <uart_puts>
40002e84: aa1703e0     	mov	x0, x23
40002e88: 940001a7     	bl	0x40003524 <uart_puts>
40002e8c: aa1703e0     	mov	x0, x23
40002e90: 940001a5     	bl	0x40003524 <uart_puts>
40002e94: aa1703e0     	mov	x0, x23
40002e98: 940001a3     	bl	0x40003524 <uart_puts>
40002e9c: aa1703e0     	mov	x0, x23
40002ea0: 940001a1     	bl	0x40003524 <uart_puts>
40002ea4: aa1703e0     	mov	x0, x23
40002ea8: 9400019f     	bl	0x40003524 <uart_puts>
40002eac: aa1703e0     	mov	x0, x23
40002eb0: 9400019d     	bl	0x40003524 <uart_puts>
40002eb4: aa1703e0     	mov	x0, x23
40002eb8: 9400019b     	bl	0x40003524 <uart_puts>
40002ebc: aa1703e0     	mov	x0, x23
40002ec0: 94000199     	bl	0x40003524 <uart_puts>
40002ec4: aa1703e0     	mov	x0, x23
40002ec8: 94000197     	bl	0x40003524 <uart_puts>
40002ecc: aa1703e0     	mov	x0, x23
40002ed0: 94000195     	bl	0x40003524 <uart_puts>
40002ed4: aa1703e0     	mov	x0, x23
40002ed8: 94000193     	bl	0x40003524 <uart_puts>
40002edc: aa1703e0     	mov	x0, x23
40002ee0: 94000191     	bl	0x40003524 <uart_puts>
40002ee4: 110006b5     	add	w21, w21, #0x1
40002ee8: 71005ebf     	cmp	w21, #0x17
40002eec: 54fff641     	b.ne	0x40002db4 <tui_launch+0x3e4>
40002ef0: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002ef4: 91140c00     	add	x0, x0, #0x503
40002ef8: 52800061     	mov	w1, #0x3                // =3
40002efc: 52800562     	mov	w2, #0x2b               // =43
40002f00: 94000299     	bl	0x40003964 <uart_printf>
40002f04: d503201f     	nop
40002f08: 10051a68     	adr	x8, 0x4000d254 <proc_table>
40002f0c: aa1f03f4     	mov	x20, xzr
40002f10: 9100a115     	add	x21, x8, #0x28
40002f14: 52800058     	mov	w24, #0x2               // =2
40002f18: 90000039     	adrp	x25, 0x40006000 <__rodata_start>
40002f1c: 91120339     	add	x25, x25, #0x480
40002f20: b85fc2a8     	ldur	w8, [x21, #-0x4]
40002f24: 71000d1f     	cmp	w8, #0x3
40002f28: 54000140     	b.eq	0x40002f50 <tui_launch+0x580>
40002f2c: b94002a8     	ldr	w8, [x21]
40002f30: b85d82a3     	ldur	w3, [x21, #-0x28]
40002f34: d10092a4     	sub	x4, x21, #0x24
40002f38: 11000b01     	add	w1, w24, #0x2
40002f3c: aa1903e0     	mov	x0, x25
40002f40: 52800562     	mov	w2, #0x2b               // =43
40002f44: 530a7d05     	lsr	w5, w8, #10
40002f48: 94000287     	bl	0x40003964 <uart_printf>
40002f4c: 11000718     	add	w24, w24, #0x1
40002f50: f1003a9f     	cmp	x20, #0xe
40002f54: 540000a8     	b.hi	0x40002f68 <tui_launch+0x598>
40002f58: 7100531f     	cmp	w24, #0x14
40002f5c: 91000694     	add	x20, x20, #0x1
40002f60: 9100c2b5     	add	x21, x21, #0x30
40002f64: 54fffdeb     	b.lt	0x40002f20 <tui_launch+0x550>
40002f68: 940001a2     	bl	0x400035f0 <uart_getc>
40002f6c: 52801be8     	mov	w8, #0xdf               // =223
40002f70: 0a080008     	and	w8, w0, w8
40002f74: 7101451f     	cmp	w8, #0x51
40002f78: 54000c00     	b.eq	0x400030f8 <tui_launch+0x728>
40002f7c: 12001c08     	and	w8, w0, #0xff
40002f80: 7100311f     	cmp	w8, #0xc
40002f84: 5400010c     	b.gt	0x40002fa4 <tui_launch+0x5d4>
40002f88: 7100251f     	cmp	w8, #0x9
40002f8c: 90000034     	adrp	x20, 0x40006000 <__rodata_start>
40002f90: 911ca294     	add	x20, x20, #0x728
40002f94: 54ffd520     	b.eq	0x40002a38 <tui_launch+0x68>
40002f98: 7100291f     	cmp	w8, #0xa
40002f9c: 540002e0     	b.eq	0x40002ff8 <tui_launch+0x628>
40002fa0: 17fffeaa     	b	0x40002a48 <tui_launch+0x78>
40002fa4: 7100351f     	cmp	w8, #0xd
40002fa8: 90000034     	adrp	x20, 0x40006000 <__rodata_start>
40002fac: 911ca294     	add	x20, x20, #0x728
40002fb0: 54000240     	b.eq	0x40002ff8 <tui_launch+0x628>
40002fb4: 71006d1f     	cmp	w8, #0x1b
40002fb8: 54ffd481     	b.ne	0x40002a48 <tui_launch+0x78>
40002fbc: 9400018d     	bl	0x400035f0 <uart_getc>
40002fc0: 12001c14     	and	w20, w0, #0xff
40002fc4: 9400018b     	bl	0x400035f0 <uart_getc>
40002fc8: 71016e9f     	cmp	w20, #0x5b
40002fcc: 54ffd3e1     	b.ne	0x40002a48 <tui_launch+0x78>
40002fd0: 12001c08     	and	w8, w0, #0xff
40002fd4: 7101051f     	cmp	w8, #0x41
40002fd8: 54000781     	b.ne	0x400030c8 <tui_launch+0x6f8>
40002fdc: b9496388     	ldr	w8, [x28, #0x960]
40002fe0: 35ffd348     	cbnz	w8, 0x40002a48 <tui_launch+0x78>
40002fe4: b9496768     	ldr	w8, [x27, #0x964]
40002fe8: 71000508     	subs	w8, w8, #0x1
40002fec: 54ffd2eb     	b.lt	0x40002a48 <tui_launch+0x78>
40002ff0: b9096768     	str	w8, [x27, #0x964]
40002ff4: 17fffe95     	b	0x40002a48 <tui_launch+0x78>
40002ff8: b9496388     	ldr	w8, [x28, #0x960]
40002ffc: 35ffd268     	cbnz	w8, 0x40002a48 <tui_launch+0x78>
40003000: b9496b48     	ldr	w8, [x26, #0x968]
40003004: 7100051f     	cmp	w8, #0x1
40003008: 54ffd20b     	b.lt	0x40002a48 <tui_launch+0x78>
4000300c: b9896768     	ldrsw	x8, [x27, #0x964]
40003010: f8687a75     	ldr	x21, [x19, x8, lsl #3]
40003014: b4000115     	cbz	x21, 0x40003034 <tui_launch+0x664>
40003018: b94022a8     	ldr	w8, [x21, #0x20]
4000301c: 7100051f     	cmp	w8, #0x1
40003020: 54000161     	b.ne	0x4000304c <tui_launch+0x67c>
40003024: f0000048     	adrp	x8, 0x4000e000 <var_values+0x6a8>
40003028: b909677f     	str	wzr, [x27, #0x964]
4000302c: f904ad15     	str	x21, [x8, #0x958]
40003030: 17fffe86     	b	0x40002a48 <tui_launch+0x78>
40003034: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
40003038: b909677f     	str	wzr, [x27, #0x964]
4000303c: f944ad28     	ldr	x8, [x9, #0x958]
40003040: f9421908     	ldr	x8, [x8, #0x430]
40003044: f904ad28     	str	x8, [x9, #0x958]
40003048: 17fffe80     	b	0x40002a48 <tui_launch+0x78>
4000304c: 390223ff     	strb	wzr, [sp, #0x88]
40003050: aa1403e0     	mov	x0, x20
40003054: 94000620     	bl	0x400048d4 <vfs_find>
40003058: eb0002bf     	cmp	x21, x0
4000305c: 540001e0     	b.eq	0x40003098 <tui_launch+0x6c8>
40003060: 910023e0     	add	x0, sp, #0x8
40003064: 910223e1     	add	x1, sp, #0x88
40003068: 97fffd89     	bl	0x4000268c <kstrcpy>
4000306c: 910223e0     	add	x0, sp, #0x88
40003070: aa1403e1     	mov	x1, x20
40003074: 97fffd86     	bl	0x4000268c <kstrcpy>
40003078: 910223e0     	add	x0, sp, #0x88
4000307c: aa1503e1     	mov	x1, x21
40003080: 97fffd5b     	bl	0x400025ec <kstrcat>
40003084: 910223e0     	add	x0, sp, #0x88
40003088: 910023e1     	add	x1, sp, #0x8
4000308c: 97fffd58     	bl	0x400025ec <kstrcat>
40003090: f9421ab5     	ldr	x21, [x21, #0x430]
40003094: b5fffdf5     	cbnz	x21, 0x40003050 <tui_launch+0x680>
40003098: 910223e0     	add	x0, sp, #0x88
4000309c: 97fffd4d     	bl	0x400025d0 <kstrlen>
400030a0: b5000080     	cbnz	x0, 0x400030b0 <tui_launch+0x6e0>
400030a4: 910223e0     	add	x0, sp, #0x88
400030a8: aa1403e1     	mov	x1, x20
400030ac: 97fffd78     	bl	0x4000268c <kstrcpy>
400030b0: 910223e0     	add	x0, sp, #0x88
400030b4: 97fff3e9     	bl	0x40000058 <launch_kedit>
400030b8: d503201f     	nop
400030bc: 70022980     	adr	x0, 0x400075ef <__rodata_start+0x15ef>
400030c0: 94000119     	bl	0x40003524 <uart_puts>
400030c4: 17fffe61     	b	0x40002a48 <tui_launch+0x78>
400030c8: 7101091f     	cmp	w8, #0x42
400030cc: 54ffcbe1     	b.ne	0x40002a48 <tui_launch+0x78>
400030d0: b9496388     	ldr	w8, [x28, #0x960]
400030d4: 35ffcba8     	cbnz	w8, 0x40002a48 <tui_launch+0x78>
400030d8: b9496b49     	ldr	w9, [x26, #0x968]
400030dc: b9496768     	ldr	w8, [x27, #0x964]
400030e0: 51000529     	sub	w9, w9, #0x1
400030e4: 6b09011f     	cmp	w8, w9
400030e8: 54ffcb0a     	b.ge	0x40002a48 <tui_launch+0x78>
400030ec: 11000508     	add	w8, w8, #0x1
400030f0: b9096768     	str	w8, [x27, #0x964]
400030f4: 17fffe55     	b	0x40002a48 <tui_launch+0x78>
400030f8: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400030fc: 91275800     	add	x0, x0, #0x9d6
40003100: 94000109     	bl	0x40003524 <uart_puts>
40003104: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003108: a95557f6     	ldp	x22, x21, [sp, #0x150]
4000310c: a9545ff8     	ldp	x24, x23, [sp, #0x140]
40003110: a95367fa     	ldp	x26, x25, [sp, #0x130]
40003114: a9526ffc     	ldp	x28, x27, [sp, #0x120]
40003118: a9517bfd     	ldp	x29, x30, [sp, #0x110]
4000311c: 9105c3ff     	add	sp, sp, #0x170
40003120: d65f03c0     	ret

0000000040003124 <draw_box>:
40003124: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40003128: b0000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000312c: 91080908     	add	x8, x8, #0x202
40003130: 7100007f     	cmp	w3, #0x0
40003134: f0000009     	adrp	x9, 0x40006000 <__rodata_start>
40003138: 913fd529     	add	x9, x9, #0xff5
4000313c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003140: 2a0003f3     	mov	w19, w0
40003144: 9a880120     	csel	x0, x9, x8, eq
40003148: a9015ff8     	stp	x24, x23, [sp, #0x10]
4000314c: a90257f6     	stp	x22, x21, [sp, #0x20]
40003150: 910003fd     	mov	x29, sp
40003154: aa0203f4     	mov	x20, x2
40003158: 2a0103f5     	mov	w21, w1
4000315c: 940000f2     	bl	0x40003524 <uart_puts>
40003160: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003164: 911ca800     	add	x0, x0, #0x72a
40003168: 52800041     	mov	w1, #0x2                // =2
4000316c: 2a1303e2     	mov	w2, w19
40003170: 940001fd     	bl	0x40003964 <uart_printf>
40003174: 51000ab6     	sub	w22, w21, #0x2
40003178: 510006b7     	sub	w23, w21, #0x1
4000317c: f0000015     	adrp	x21, 0x40006000 <__rodata_start>
40003180: 9111f2b5     	add	x21, x21, #0x47c
40003184: 2a1603f8     	mov	w24, w22
40003188: aa1503e0     	mov	x0, x21
4000318c: 940000e6     	bl	0x40003524 <uart_puts>
40003190: 71000718     	subs	w24, w24, #0x1
40003194: 54ffffa1     	b.ne	0x40003188 <draw_box+0x64>
40003198: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
4000319c: 9122e000     	add	x0, x0, #0x8b8
400031a0: 940000e1     	bl	0x40003524 <uart_puts>
400031a4: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400031a8: 911cd800     	add	x0, x0, #0x736
400031ac: 11000a62     	add	w2, w19, #0x2
400031b0: 52800041     	mov	w1, #0x2                // =2
400031b4: aa1403e3     	mov	x3, x20
400031b8: 940001eb     	bl	0x40003964 <uart_printf>
400031bc: 90000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
400031c0: 910c6e94     	add	x20, x20, #0x31b
400031c4: 52800061     	mov	w1, #0x3                // =3
400031c8: aa1403e0     	mov	x0, x20
400031cc: 2a1303e2     	mov	w2, w19
400031d0: 940001e5     	bl	0x40003964 <uart_printf>
400031d4: 0b1302e2     	add	w2, w23, w19
400031d8: aa1403e0     	mov	x0, x20
400031dc: 52800061     	mov	w1, #0x3                // =3
400031e0: 940001e1     	bl	0x40003964 <uart_printf>
400031e4: aa1403e0     	mov	x0, x20
400031e8: 52800081     	mov	w1, #0x4                // =4
400031ec: 2a1303e2     	mov	w2, w19
400031f0: 940001dd     	bl	0x40003964 <uart_printf>
400031f4: 0b1302e2     	add	w2, w23, w19
400031f8: aa1403e0     	mov	x0, x20
400031fc: 52800081     	mov	w1, #0x4                // =4
40003200: 940001d9     	bl	0x40003964 <uart_printf>
40003204: aa1403e0     	mov	x0, x20
40003208: 528000a1     	mov	w1, #0x5                // =5
4000320c: 2a1303e2     	mov	w2, w19
40003210: 940001d5     	bl	0x40003964 <uart_printf>
40003214: 0b1302e2     	add	w2, w23, w19
40003218: aa1403e0     	mov	x0, x20
4000321c: 528000a1     	mov	w1, #0x5                // =5
40003220: 940001d1     	bl	0x40003964 <uart_printf>
40003224: aa1403e0     	mov	x0, x20
40003228: 528000c1     	mov	w1, #0x6                // =6
4000322c: 2a1303e2     	mov	w2, w19
40003230: 940001cd     	bl	0x40003964 <uart_printf>
40003234: 0b1302e2     	add	w2, w23, w19
40003238: aa1403e0     	mov	x0, x20
4000323c: 528000c1     	mov	w1, #0x6                // =6
40003240: 940001c9     	bl	0x40003964 <uart_printf>
40003244: aa1403e0     	mov	x0, x20
40003248: 528000e1     	mov	w1, #0x7                // =7
4000324c: 2a1303e2     	mov	w2, w19
40003250: 940001c5     	bl	0x40003964 <uart_printf>
40003254: 0b1302e2     	add	w2, w23, w19
40003258: aa1403e0     	mov	x0, x20
4000325c: 528000e1     	mov	w1, #0x7                // =7
40003260: 940001c1     	bl	0x40003964 <uart_printf>
40003264: aa1403e0     	mov	x0, x20
40003268: 52800101     	mov	w1, #0x8                // =8
4000326c: 2a1303e2     	mov	w2, w19
40003270: 940001bd     	bl	0x40003964 <uart_printf>
40003274: 0b1302e2     	add	w2, w23, w19
40003278: aa1403e0     	mov	x0, x20
4000327c: 52800101     	mov	w1, #0x8                // =8
40003280: 940001b9     	bl	0x40003964 <uart_printf>
40003284: aa1403e0     	mov	x0, x20
40003288: 52800121     	mov	w1, #0x9                // =9
4000328c: 2a1303e2     	mov	w2, w19
40003290: 940001b5     	bl	0x40003964 <uart_printf>
40003294: 0b1302e2     	add	w2, w23, w19
40003298: aa1403e0     	mov	x0, x20
4000329c: 52800121     	mov	w1, #0x9                // =9
400032a0: 940001b1     	bl	0x40003964 <uart_printf>
400032a4: aa1403e0     	mov	x0, x20
400032a8: 52800141     	mov	w1, #0xa                // =10
400032ac: 2a1303e2     	mov	w2, w19
400032b0: 940001ad     	bl	0x40003964 <uart_printf>
400032b4: 0b1302e2     	add	w2, w23, w19
400032b8: aa1403e0     	mov	x0, x20
400032bc: 52800141     	mov	w1, #0xa                // =10
400032c0: 940001a9     	bl	0x40003964 <uart_printf>
400032c4: aa1403e0     	mov	x0, x20
400032c8: 52800161     	mov	w1, #0xb                // =11
400032cc: 2a1303e2     	mov	w2, w19
400032d0: 940001a5     	bl	0x40003964 <uart_printf>
400032d4: 0b1302e2     	add	w2, w23, w19
400032d8: aa1403e0     	mov	x0, x20
400032dc: 52800161     	mov	w1, #0xb                // =11
400032e0: 940001a1     	bl	0x40003964 <uart_printf>
400032e4: aa1403e0     	mov	x0, x20
400032e8: 52800181     	mov	w1, #0xc                // =12
400032ec: 2a1303e2     	mov	w2, w19
400032f0: 9400019d     	bl	0x40003964 <uart_printf>
400032f4: 0b1302e2     	add	w2, w23, w19
400032f8: aa1403e0     	mov	x0, x20
400032fc: 52800181     	mov	w1, #0xc                // =12
40003300: 94000199     	bl	0x40003964 <uart_printf>
40003304: aa1403e0     	mov	x0, x20
40003308: 528001a1     	mov	w1, #0xd                // =13
4000330c: 2a1303e2     	mov	w2, w19
40003310: 94000195     	bl	0x40003964 <uart_printf>
40003314: 0b1302e2     	add	w2, w23, w19
40003318: aa1403e0     	mov	x0, x20
4000331c: 528001a1     	mov	w1, #0xd                // =13
40003320: 94000191     	bl	0x40003964 <uart_printf>
40003324: aa1403e0     	mov	x0, x20
40003328: 528001c1     	mov	w1, #0xe                // =14
4000332c: 2a1303e2     	mov	w2, w19
40003330: 9400018d     	bl	0x40003964 <uart_printf>
40003334: 0b1302e2     	add	w2, w23, w19
40003338: aa1403e0     	mov	x0, x20
4000333c: 528001c1     	mov	w1, #0xe                // =14
40003340: 94000189     	bl	0x40003964 <uart_printf>
40003344: aa1403e0     	mov	x0, x20
40003348: 528001e1     	mov	w1, #0xf                // =15
4000334c: 2a1303e2     	mov	w2, w19
40003350: 94000185     	bl	0x40003964 <uart_printf>
40003354: 0b1302e2     	add	w2, w23, w19
40003358: aa1403e0     	mov	x0, x20
4000335c: 528001e1     	mov	w1, #0xf                // =15
40003360: 94000181     	bl	0x40003964 <uart_printf>
40003364: aa1403e0     	mov	x0, x20
40003368: 52800201     	mov	w1, #0x10               // =16
4000336c: 2a1303e2     	mov	w2, w19
40003370: 9400017d     	bl	0x40003964 <uart_printf>
40003374: 0b1302e2     	add	w2, w23, w19
40003378: aa1403e0     	mov	x0, x20
4000337c: 52800201     	mov	w1, #0x10               // =16
40003380: 94000179     	bl	0x40003964 <uart_printf>
40003384: aa1403e0     	mov	x0, x20
40003388: 52800221     	mov	w1, #0x11               // =17
4000338c: 2a1303e2     	mov	w2, w19
40003390: 94000175     	bl	0x40003964 <uart_printf>
40003394: 0b1302e2     	add	w2, w23, w19
40003398: aa1403e0     	mov	x0, x20
4000339c: 52800221     	mov	w1, #0x11               // =17
400033a0: 94000171     	bl	0x40003964 <uart_printf>
400033a4: aa1403e0     	mov	x0, x20
400033a8: 52800241     	mov	w1, #0x12               // =18
400033ac: 2a1303e2     	mov	w2, w19
400033b0: 9400016d     	bl	0x40003964 <uart_printf>
400033b4: 0b1302e2     	add	w2, w23, w19
400033b8: aa1403e0     	mov	x0, x20
400033bc: 52800241     	mov	w1, #0x12               // =18
400033c0: 94000169     	bl	0x40003964 <uart_printf>
400033c4: aa1403e0     	mov	x0, x20
400033c8: 52800261     	mov	w1, #0x13               // =19
400033cc: 2a1303e2     	mov	w2, w19
400033d0: 94000165     	bl	0x40003964 <uart_printf>
400033d4: 0b1302e2     	add	w2, w23, w19
400033d8: aa1403e0     	mov	x0, x20
400033dc: 52800261     	mov	w1, #0x13               // =19
400033e0: 94000161     	bl	0x40003964 <uart_printf>
400033e4: aa1403e0     	mov	x0, x20
400033e8: 52800281     	mov	w1, #0x14               // =20
400033ec: 2a1303e2     	mov	w2, w19
400033f0: 9400015d     	bl	0x40003964 <uart_printf>
400033f4: 0b1302e2     	add	w2, w23, w19
400033f8: aa1403e0     	mov	x0, x20
400033fc: 52800281     	mov	w1, #0x14               // =20
40003400: 94000159     	bl	0x40003964 <uart_printf>
40003404: aa1403e0     	mov	x0, x20
40003408: 528002a1     	mov	w1, #0x15               // =21
4000340c: 2a1303e2     	mov	w2, w19
40003410: 94000155     	bl	0x40003964 <uart_printf>
40003414: 0b1302e2     	add	w2, w23, w19
40003418: aa1403e0     	mov	x0, x20
4000341c: 528002a1     	mov	w1, #0x15               // =21
40003420: 94000151     	bl	0x40003964 <uart_printf>
40003424: aa1403e0     	mov	x0, x20
40003428: 528002c1     	mov	w1, #0x16               // =22
4000342c: 2a1303e2     	mov	w2, w19
40003430: 9400014d     	bl	0x40003964 <uart_printf>
40003434: 0b1302e2     	add	w2, w23, w19
40003438: aa1403e0     	mov	x0, x20
4000343c: 528002c1     	mov	w1, #0x16               // =22
40003440: 94000149     	bl	0x40003964 <uart_printf>
40003444: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003448: 9113cc00     	add	x0, x0, #0x4f3
4000344c: 528002e1     	mov	w1, #0x17               // =23
40003450: 2a1303e2     	mov	w2, w19
40003454: 94000144     	bl	0x40003964 <uart_printf>
40003458: f0000013     	adrp	x19, 0x40006000 <__rodata_start>
4000345c: 9111f273     	add	x19, x19, #0x47c
40003460: aa1303e0     	mov	x0, x19
40003464: 94000030     	bl	0x40003524 <uart_puts>
40003468: 710006d6     	subs	w22, w22, #0x1
4000346c: 54ffffa1     	b.ne	0x40003460 <draw_box+0x33c>
40003470: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003474: 9113fc00     	add	x0, x0, #0x4ff
40003478: 9400002b     	bl	0x40003524 <uart_puts>
4000347c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003480: 90000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40003484: 91202800     	add	x0, x0, #0x80a
40003488: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000348c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003490: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003494: 14000024     	b	0x40003524 <uart_puts>

0000000040003498 <uart_init>:
40003498: 52800608     	mov	w8, #0x30               // =48
4000349c: 528001a9     	mov	w9, #0xd                // =13
400034a0: 5280002a     	mov	w10, #0x1               // =1
400034a4: 72a12008     	movk	w8, #0x900, lsl #16
400034a8: b900011f     	str	wzr, [x8]
400034ac: b81f4109     	stur	w9, [x8, #-0xc]
400034b0: 52800e09     	mov	w9, #0x70               // =112
400034b4: b81f810a     	stur	w10, [x8, #-0x8]
400034b8: b81fc109     	stur	w9, [x8, #-0x4]
400034bc: 52806029     	mov	w9, #0x301              // =769
400034c0: b9000109     	str	w9, [x8]
400034c4: d65f03c0     	ret

00000000400034c8 <uart_putc>:
400034c8: f0000048     	adrp	x8, 0x4000e000 <var_values+0x6a8>
400034cc: b94b7108     	ldr	w8, [x8, #0xb70]
400034d0: 340001a8     	cbz	w8, 0x40003504 <uart_putc+0x3c>
400034d4: f0000048     	adrp	x8, 0x4000e000 <var_values+0x6a8>
400034d8: 5287ffca     	mov	w10, #0x3ffe            // =16382
400034dc: b94b7509     	ldr	w9, [x8, #0xb74]
400034e0: 6b0a013f     	cmp	w9, w10
400034e4: 5400010c     	b.gt	0x40003504 <uart_putc+0x3c>
400034e8: 93407d29     	sxtw	x9, w9
400034ec: d503201f     	nop
400034f0: 1005b44a     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
400034f4: 9100052b     	add	x11, x9, #0x1
400034f8: 38296940     	strb	w0, [x10, x9]
400034fc: b90b750b     	str	w11, [x8, #0xb74]
40003500: 382b695f     	strb	wzr, [x10, x11]
40003504: 52800308     	mov	w8, #0x18               // =24
40003508: 72a12008     	movk	w8, #0x900, lsl #16
4000350c: b9400109     	ldr	w9, [x8]
40003510: 372fffe9     	tbnz	w9, #0x5, 0x4000350c <uart_putc+0x44>
40003514: 12001c08     	and	w8, w0, #0xff
40003518: 52a12009     	mov	w9, #0x9000000          // =150994944
4000351c: b9000128     	str	w8, [x9]
40003520: d65f03c0     	ret

0000000040003524 <uart_puts>:
40003524: 52800308     	mov	w8, #0x18               // =24
40003528: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
4000352c: f000004a     	adrp	x10, 0x4000e000 <var_values+0x6a8>
40003530: 72a12008     	movk	w8, #0x900, lsl #16
40003534: d503201f     	nop
40003538: 1005b20b     	adr	x11, 0x4000eb78 <kernel_capture_buffer>
4000353c: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003540: 528001ad     	mov	w13, #0xd               // =13
40003544: 52a1200e     	mov	w14, #0x9000000         // =150994944
40003548: 3940000f     	ldrb	w15, [x0]
4000354c: 710029ff     	cmp	w15, #0xa
40003550: 540000a0     	b.eq	0x40003564 <uart_puts+0x40>
40003554: 3400040f     	cbz	w15, 0x400035d4 <uart_puts+0xb0>
40003558: b94b7130     	ldr	w16, [x9, #0xb70]
4000355c: 35000230     	cbnz	w16, 0x400035a0 <uart_puts+0x7c>
40003560: 14000018     	b	0x400035c0 <uart_puts+0x9c>
40003564: b94b712f     	ldr	w15, [x9, #0xb70]
40003568: 3400010f     	cbz	w15, 0x40003588 <uart_puts+0x64>
4000356c: b94b754f     	ldr	w15, [x10, #0xb74]
40003570: 6b0c01ff     	cmp	w15, w12
40003574: 540000ac     	b.gt	0x40003588 <uart_puts+0x64>
40003578: 93407def     	sxtw	x15, w15
4000357c: 110005f0     	add	w16, w15, #0x1
40003580: 782f696d     	strh	w13, [x11, x15]
40003584: b90b7550     	str	w16, [x10, #0xb74]
40003588: b940010f     	ldr	w15, [x8]
4000358c: 372fffef     	tbnz	w15, #0x5, 0x40003588 <uart_puts+0x64>
40003590: b90001cd     	str	w13, [x14]
40003594: 3940000f     	ldrb	w15, [x0]
40003598: b94b7130     	ldr	w16, [x9, #0xb70]
4000359c: 34000130     	cbz	w16, 0x400035c0 <uart_puts+0x9c>
400035a0: b94b7550     	ldr	w16, [x10, #0xb74]
400035a4: 6b0c021f     	cmp	w16, w12
400035a8: 540000cc     	b.gt	0x400035c0 <uart_puts+0x9c>
400035ac: 93407e10     	sxtw	x16, w16
400035b0: 91000611     	add	x17, x16, #0x1
400035b4: 3830696f     	strb	w15, [x11, x16]
400035b8: b90b7551     	str	w17, [x10, #0xb74]
400035bc: 3831697f     	strb	wzr, [x11, x17]
400035c0: 91000400     	add	x0, x0, #0x1
400035c4: b9400110     	ldr	w16, [x8]
400035c8: 372ffff0     	tbnz	w16, #0x5, 0x400035c4 <uart_puts+0xa0>
400035cc: b90001cf     	str	w15, [x14]
400035d0: 17ffffde     	b	0x40003548 <uart_puts+0x24>
400035d4: d65f03c0     	ret

00000000400035d8 <uart_has_data>:
400035d8: 52800308     	mov	w8, #0x18               // =24
400035dc: 52800029     	mov	w9, #0x1                // =1
400035e0: 72a12008     	movk	w8, #0x900, lsl #16
400035e4: b9400108     	ldr	w8, [x8]
400035e8: 0a681120     	bic	w0, w9, w8, lsr #4
400035ec: d65f03c0     	ret

00000000400035f0 <uart_getc>:
400035f0: 52800308     	mov	w8, #0x18               // =24
400035f4: 72a12008     	movk	w8, #0x900, lsl #16
400035f8: b9400109     	ldr	w9, [x8]
400035fc: 3727ffe9     	tbnz	w9, #0x4, 0x400035f8 <uart_getc+0x8>
40003600: 52a12008     	mov	w8, #0x9000000          // =150994944
40003604: b9400100     	ldr	w0, [x8]
40003608: d65f03c0     	ret

000000004000360c <uart_print_hex_raw>:
4000360c: 52800308     	mov	w8, #0x18               // =24
40003610: 2a1f03eb     	mov	w11, wzr
40003614: 5280078c     	mov	w12, #0x3c              // =60
40003618: 72a12008     	movk	w8, #0x900, lsl #16
4000361c: d503201f     	nop
40003620: 30016fce     	adr	x14, 0x40006419 <__rodata_start+0x419>
40003624: f000004d     	adrp	x13, 0x4000e000 <var_values+0x6a8>
40003628: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
4000362c: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003630: d503201f     	nop
40003634: 1005aa2a     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
40003638: 52a12010     	mov	w16, #0x9000000         // =150994944
4000363c: 14000003     	b	0x40003648 <uart_print_hex_raw+0x3c>
40003640: b400032c     	cbz	x12, 0x400036a4 <uart_print_hex_raw+0x98>
40003644: d100118c     	sub	x12, x12, #0x4
40003648: 9acc2411     	lsr	x17, x0, x12
4000364c: 53027d92     	lsr	w18, w12, #2
40003650: 92400e31     	and	x17, x17, #0xf
40003654: 6b01025f     	cmp	w18, w1
40003658: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
4000365c: 1a9f056b     	csinc	w11, w11, wzr, eq
40003660: 34ffff0b     	cbz	w11, 0x40003640 <uart_print_hex_raw+0x34>
40003664: b94b71b2     	ldr	w18, [x13, #0xb70]
40003668: 387169d1     	ldrb	w17, [x14, x17]
4000366c: 34000132     	cbz	w18, 0x40003690 <uart_print_hex_raw+0x84>
40003670: b94b7532     	ldr	w18, [x9, #0xb74]
40003674: 6b0f025f     	cmp	w18, w15
40003678: 540000cc     	b.gt	0x40003690 <uart_print_hex_raw+0x84>
4000367c: 93407e52     	sxtw	x18, w18
40003680: 91000642     	add	x2, x18, #0x1
40003684: 38326951     	strb	w17, [x10, x18]
40003688: b90b7522     	str	w2, [x9, #0xb74]
4000368c: 3822695f     	strb	wzr, [x10, x2]
40003690: b9400112     	ldr	w18, [x8]
40003694: 372ffff2     	tbnz	w18, #0x5, 0x40003690 <uart_print_hex_raw+0x84>
40003698: b9000211     	str	w17, [x16]
4000369c: b5fffd4c     	cbnz	x12, 0x40003644 <uart_print_hex_raw+0x38>
400036a0: d65f03c0     	ret
400036a4: b94b71ab     	ldr	w11, [x13, #0xb70]
400036a8: 3400014b     	cbz	w11, 0x400036d0 <uart_print_hex_raw+0xc4>
400036ac: b94b752b     	ldr	w11, [x9, #0xb74]
400036b0: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400036b4: 6b0c017f     	cmp	w11, w12
400036b8: 540000cc     	b.gt	0x400036d0 <uart_print_hex_raw+0xc4>
400036bc: 93407d6b     	sxtw	x11, w11
400036c0: 1100056c     	add	w12, w11, #0x1
400036c4: b90b752c     	str	w12, [x9, #0xb74]
400036c8: 52800609     	mov	w9, #0x30               // =48
400036cc: 782b6949     	strh	w9, [x10, x11]
400036d0: b9400109     	ldr	w9, [x8]
400036d4: 372fffe9     	tbnz	w9, #0x5, 0x400036d0 <uart_print_hex_raw+0xc4>
400036d8: 52a12008     	mov	w8, #0x9000000          // =150994944
400036dc: 52800609     	mov	w9, #0x30               // =48
400036e0: b9000109     	str	w9, [x8]
400036e4: d65f03c0     	ret

00000000400036e8 <uart_print_hex>:
400036e8: 52800308     	mov	w8, #0x18               // =24
400036ec: f000000c     	adrp	x12, 0x40006000 <__rodata_start>
400036f0: 913c818c     	add	x12, x12, #0xf20
400036f4: 72a12008     	movk	w8, #0x900, lsl #16
400036f8: f000004b     	adrp	x11, 0x4000e000 <var_values+0x6a8>
400036fc: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
40003700: d503201f     	nop
40003704: 1005a3aa     	adr	x10, 0x4000eb78 <kernel_capture_buffer>
40003708: 5287ffcd     	mov	w13, #0x3ffe            // =16382
4000370c: 528001ae     	mov	w14, #0xd               // =13
40003710: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003714: 39400190     	ldrb	w16, [x12]
40003718: 71002a1f     	cmp	w16, #0xa
4000371c: 540000a0     	b.eq	0x40003730 <uart_print_hex+0x48>
40003720: 340003f0     	cbz	w16, 0x4000379c <uart_print_hex+0xb4>
40003724: b94b7171     	ldr	w17, [x11, #0xb70]
40003728: 35000211     	cbnz	w17, 0x40003768 <uart_print_hex+0x80>
4000372c: 14000017     	b	0x40003788 <uart_print_hex+0xa0>
40003730: b94b7171     	ldr	w17, [x11, #0xb70]
40003734: 34000111     	cbz	w17, 0x40003754 <uart_print_hex+0x6c>
40003738: b94b7531     	ldr	w17, [x9, #0xb74]
4000373c: 6b0d023f     	cmp	w17, w13
40003740: 540000ac     	b.gt	0x40003754 <uart_print_hex+0x6c>
40003744: 93407e31     	sxtw	x17, w17
40003748: 11000632     	add	w18, w17, #0x1
4000374c: 7831694e     	strh	w14, [x10, x17]
40003750: b90b7532     	str	w18, [x9, #0xb74]
40003754: b9400111     	ldr	w17, [x8]
40003758: 372ffff1     	tbnz	w17, #0x5, 0x40003754 <uart_print_hex+0x6c>
4000375c: b90001ee     	str	w14, [x15]
40003760: b94b7171     	ldr	w17, [x11, #0xb70]
40003764: 34000131     	cbz	w17, 0x40003788 <uart_print_hex+0xa0>
40003768: b94b7531     	ldr	w17, [x9, #0xb74]
4000376c: 6b0d023f     	cmp	w17, w13
40003770: 540000cc     	b.gt	0x40003788 <uart_print_hex+0xa0>
40003774: 93407e31     	sxtw	x17, w17
40003778: 91000632     	add	x18, x17, #0x1
4000377c: 38316950     	strb	w16, [x10, x17]
40003780: b90b7532     	str	w18, [x9, #0xb74]
40003784: 3832695f     	strb	wzr, [x10, x18]
40003788: 9100058c     	add	x12, x12, #0x1
4000378c: b9400111     	ldr	w17, [x8]
40003790: 372ffff1     	tbnz	w17, #0x5, 0x4000378c <uart_print_hex+0xa4>
40003794: b90001f0     	str	w16, [x15]
40003798: 17ffffdf     	b	0x40003714 <uart_print_hex+0x2c>
4000379c: 2a1f03ec     	mov	w12, wzr
400037a0: d503201f     	nop
400037a4: 300163ad     	adr	x13, 0x40006419 <__rodata_start+0x419>
400037a8: 5280078e     	mov	w14, #0x3c              // =60
400037ac: 5287ffcf     	mov	w15, #0x3ffe            // =16382
400037b0: 52a12010     	mov	w16, #0x9000000         // =150994944
400037b4: 14000003     	b	0x400037c0 <uart_print_hex+0xd8>
400037b8: b40002ee     	cbz	x14, 0x40003814 <uart_print_hex+0x12c>
400037bc: d10011ce     	sub	x14, x14, #0x4
400037c0: 9ace2411     	lsr	x17, x0, x14
400037c4: f2400e31     	ands	x17, x17, #0xf
400037c8: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
400037cc: 1a9f158c     	csinc	w12, w12, wzr, ne
400037d0: 34ffff4c     	cbz	w12, 0x400037b8 <uart_print_hex+0xd0>
400037d4: b94b7172     	ldr	w18, [x11, #0xb70]
400037d8: 387169b1     	ldrb	w17, [x13, x17]
400037dc: 34000132     	cbz	w18, 0x40003800 <uart_print_hex+0x118>
400037e0: b94b7532     	ldr	w18, [x9, #0xb74]
400037e4: 6b0f025f     	cmp	w18, w15
400037e8: 540000cc     	b.gt	0x40003800 <uart_print_hex+0x118>
400037ec: 93407e52     	sxtw	x18, w18
400037f0: 91000641     	add	x1, x18, #0x1
400037f4: 38326951     	strb	w17, [x10, x18]
400037f8: b90b7521     	str	w1, [x9, #0xb74]
400037fc: 3821695f     	strb	wzr, [x10, x1]
40003800: b9400112     	ldr	w18, [x8]
40003804: 372ffff2     	tbnz	w18, #0x5, 0x40003800 <uart_print_hex+0x118>
40003808: b9000211     	str	w17, [x16]
4000380c: b5fffd8e     	cbnz	x14, 0x400037bc <uart_print_hex+0xd4>
40003810: d65f03c0     	ret
40003814: b94b716b     	ldr	w11, [x11, #0xb70]
40003818: 3400014b     	cbz	w11, 0x40003840 <uart_print_hex+0x158>
4000381c: b94b752b     	ldr	w11, [x9, #0xb74]
40003820: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003824: 6b0c017f     	cmp	w11, w12
40003828: 540000cc     	b.gt	0x40003840 <uart_print_hex+0x158>
4000382c: 93407d6b     	sxtw	x11, w11
40003830: 1100056c     	add	w12, w11, #0x1
40003834: b90b752c     	str	w12, [x9, #0xb74]
40003838: 52800609     	mov	w9, #0x30               // =48
4000383c: 782b6949     	strh	w9, [x10, x11]
40003840: b9400109     	ldr	w9, [x8]
40003844: 372fffe9     	tbnz	w9, #0x5, 0x40003840 <uart_print_hex+0x158>
40003848: 52a12008     	mov	w8, #0x9000000          // =150994944
4000384c: 52800609     	mov	w9, #0x30               // =48
40003850: b9000109     	str	w9, [x8]
40003854: d65f03c0     	ret

0000000040003858 <uart_print_dec>:
40003858: d10083ff     	sub	sp, sp, #0x20
4000385c: 52800308     	mov	w8, #0x18               // =24
40003860: 72a12008     	movk	w8, #0x900, lsl #16
40003864: b4000540     	cbz	x0, 0x4000390c <uart_print_dec+0xb4>
40003868: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
4000386c: aa1f03e9     	mov	x9, xzr
40003870: 5280014b     	mov	w11, #0xa               // =10
40003874: f29999aa     	movk	x10, #0xcccd
40003878: 910023ec     	add	x12, sp, #0x8
4000387c: 9bca7c0d     	umulh	x13, x0, x10
40003880: f100241f     	cmp	x0, #0x9
40003884: d343fdad     	lsr	x13, x13, #3
40003888: 1b0b81ae     	msub	w14, w13, w11, w0
4000388c: aa0d03e0     	mov	x0, x13
40003890: 321c05ce     	orr	w14, w14, #0x30
40003894: 3829698e     	strb	w14, [x12, x9]
40003898: 91000529     	add	x9, x9, #0x1
4000389c: 54ffff08     	b.hi	0x4000387c <uart_print_dec+0x24>
400038a0: 910023ea     	add	x10, sp, #0x8
400038a4: f000004b     	adrp	x11, 0x4000e000 <var_values+0x6a8>
400038a8: f000004c     	adrp	x12, 0x4000e000 <var_values+0x6a8>
400038ac: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400038b0: d503201f     	nop
400038b4: 1005962e     	adr	x14, 0x4000eb78 <kernel_capture_buffer>
400038b8: 52a1200f     	mov	w15, #0x9000000         // =150994944
400038bc: d1000530     	sub	x16, x9, #0x1
400038c0: b94b7172     	ldr	w18, [x11, #0xb70]
400038c4: 38706951     	ldrb	w17, [x10, x16]
400038c8: 34000132     	cbz	w18, 0x400038ec <uart_print_dec+0x94>
400038cc: b94b7592     	ldr	w18, [x12, #0xb74]
400038d0: 6b0d025f     	cmp	w18, w13
400038d4: 540000cc     	b.gt	0x400038ec <uart_print_dec+0x94>
400038d8: 93407e52     	sxtw	x18, w18
400038dc: 91000640     	add	x0, x18, #0x1
400038e0: 383269d1     	strb	w17, [x14, x18]
400038e4: b90b7580     	str	w0, [x12, #0xb74]
400038e8: 382069df     	strb	wzr, [x14, x0]
400038ec: b9400112     	ldr	w18, [x8]
400038f0: 372ffff2     	tbnz	w18, #0x5, 0x400038ec <uart_print_dec+0x94>
400038f4: 7100053f     	cmp	w9, #0x1
400038f8: aa1003e9     	mov	x9, x16
400038fc: b90001f1     	str	w17, [x15]
40003900: 54fffdec     	b.gt	0x400038bc <uart_print_dec+0x64>
40003904: 910083ff     	add	sp, sp, #0x20
40003908: d65f03c0     	ret
4000390c: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
40003910: b94b7129     	ldr	w9, [x9, #0xb70]
40003914: 340001a9     	cbz	w9, 0x40003948 <uart_print_dec+0xf0>
40003918: f0000049     	adrp	x9, 0x4000e000 <var_values+0x6a8>
4000391c: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003920: b94b752a     	ldr	w10, [x9, #0xb74]
40003924: 6b0b015f     	cmp	w10, w11
40003928: 5400010c     	b.gt	0x40003948 <uart_print_dec+0xf0>
4000392c: 93407d4a     	sxtw	x10, w10
40003930: d503201f     	nop
40003934: 1005922c     	adr	x12, 0x4000eb78 <kernel_capture_buffer>
40003938: 1100054b     	add	w11, w10, #0x1
4000393c: b90b752b     	str	w11, [x9, #0xb74]
40003940: 52800609     	mov	w9, #0x30               // =48
40003944: 782a6989     	strh	w9, [x12, x10]
40003948: b9400109     	ldr	w9, [x8]
4000394c: 372fffe9     	tbnz	w9, #0x5, 0x40003948 <uart_print_dec+0xf0>
40003950: 52a12008     	mov	w8, #0x9000000          // =150994944
40003954: 52800609     	mov	w9, #0x30               // =48
40003958: b9000109     	str	w9, [x8]
4000395c: 910083ff     	add	sp, sp, #0x20
40003960: d65f03c0     	ret

0000000040003964 <uart_printf>:
40003964: d10583ff     	sub	sp, sp, #0x160
40003968: a9107bfd     	stp	x29, x30, [sp, #0x100]
4000396c: 910403fd     	add	x29, sp, #0x100
40003970: 928006e8     	mov	x8, #-0x38              // =-56
40003974: a91457f6     	stp	x22, x21, [sp, #0x140]
40003978: 52800315     	mov	w21, #0x18              // =24
4000397c: 910003e9     	mov	x9, sp
40003980: d101e3aa     	sub	x10, x29, #0x78
40003984: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003988: a9116ffc     	stp	x28, x27, [sp, #0x110]
4000398c: a91267fa     	stp	x26, x25, [sp, #0x120]
40003990: 72a12015     	movk	w21, #0x900, lsl #16
40003994: f2dff008     	movk	x8, #0xff80, lsl #32
40003998: a9135ff8     	stp	x24, x23, [sp, #0x130]
4000399c: 91020129     	add	x9, x9, #0x80
400039a0: 9100e14a     	add	x10, x10, #0x38
400039a4: a9154ff4     	stp	x20, x19, [sp, #0x150]
400039a8: aa0003f3     	mov	x19, x0
400039ac: aa1f03f4     	mov	x20, xzr
400039b0: 910183ab     	add	x11, x29, #0x60
400039b4: f0000056     	adrp	x22, 0x4000e000 <var_values+0x6a8>
400039b8: f0000057     	adrp	x23, 0x4000e000 <var_values+0x6a8>
400039bc: d503201f     	nop
400039c0: 10058dd8     	adr	x24, 0x4000eb78 <kernel_capture_buffer>
400039c4: 5287ffd9     	mov	w25, #0x3ffe            // =16382
400039c8: 528001ba     	mov	w26, #0xd               // =13
400039cc: 52a1201b     	mov	w27, #0x9000000         // =150994944
400039d0: 528004ae     	mov	w14, #0x25              // =37
400039d4: f29999af     	movk	x15, #0xcccd
400039d8: 52800150     	mov	w16, #0xa               // =10
400039dc: d10083bc     	sub	x28, x29, #0x20
400039e0: d503201f     	nop
400039e4: 300151b1     	adr	x17, 0x40006419 <__rodata_start+0x419>
400039e8: a9388ba1     	stp	x1, x2, [x29, #-0x78]
400039ec: a93993a3     	stp	x3, x4, [x29, #-0x68]
400039f0: a93a9ba5     	stp	x5, x6, [x29, #-0x58]
400039f4: f81b83a7     	stur	x7, [x29, #-0x48]
400039f8: ad0007e0     	stp	q0, q1, [sp]
400039fc: ad010fe2     	stp	q2, q3, [sp, #0x20]
40003a00: ad0217e4     	stp	q4, q5, [sp, #0x40]
40003a04: ad031fe6     	stp	q6, q7, [sp, #0x60]
40003a08: a93d23a9     	stp	x9, x8, [x29, #-0x30]
40003a0c: a93c2bab     	stp	x11, x10, [x29, #-0x40]
40003a10: 14000004     	b	0x40003a20 <uart_printf+0xbc>
40003a14: 52800608     	mov	w8, #0x30               // =48
40003a18: b9000368     	str	w8, [x27]
40003a1c: 91000694     	add	x20, x20, #0x1
40003a20: 38746a68     	ldrb	w8, [x19, x20]
40003a24: 7100291f     	cmp	w8, #0xa
40003a28: 54000440     	b.eq	0x40003ab0 <uart_printf+0x14c>
40003a2c: 7100951f     	cmp	w8, #0x25
40003a30: 540000a0     	b.eq	0x40003a44 <uart_printf+0xe0>
40003a34: 340039e8     	cbz	w8, 0x40004170 <uart_printf+0x80c>
40003a38: b94b72c9     	ldr	w9, [x22, #0xb70]
40003a3c: 35000589     	cbnz	w9, 0x40003aec <uart_printf+0x188>
40003a40: 14000033     	b	0x40003b0c <uart_printf+0x1a8>
40003a44: 9100068a     	add	x10, x20, #0x1
40003a48: 386a6a68     	ldrb	w8, [x19, x10]
40003a4c: 7101b11f     	cmp	w8, #0x6c
40003a50: 54000641     	b.ne	0x40003b18 <uart_printf+0x1b4>
40003a54: 91000a89     	add	x9, x20, #0x2
40003a58: 91000e8b     	add	x11, x20, #0x3
40003a5c: 38696a6a     	ldrb	w10, [x19, x9]
40003a60: 7101b15f     	cmp	w10, #0x6c
40003a64: 9a890174     	csel	x20, x11, x9, eq
40003a68: 38746a69     	ldrb	w9, [x19, x20]
40003a6c: 7101bd3f     	cmp	w9, #0x6f
40003a70: 540005cd     	b.le	0x40003b28 <uart_printf+0x1c4>
40003a74: 7101d13f     	cmp	w9, #0x74
40003a78: 540007ec     	b.gt	0x40003b74 <uart_printf+0x210>
40003a7c: 7101c13f     	cmp	w9, #0x70
40003a80: 54000ea0     	b.eq	0x40003c54 <uart_printf+0x2f0>
40003a84: 7101cd3f     	cmp	w9, #0x73
40003a88: 54000b21     	b.ne	0x40003bec <uart_printf+0x288>
40003a8c: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003a90: 36f813a8     	tbz	w8, #0x1f, 0x40003d04 <uart_printf+0x3a0>
40003a94: 11002109     	add	w9, w8, #0x8
40003a98: 3100211f     	cmn	w8, #0x8
40003a9c: b81d83a9     	stur	w9, [x29, #-0x28]
40003aa0: 54001328     	b.hi	0x40003d04 <uart_printf+0x3a0>
40003aa4: f85c83a9     	ldur	x9, [x29, #-0x38]
40003aa8: 8b080128     	add	x8, x9, x8
40003aac: 14000099     	b	0x40003d10 <uart_printf+0x3ac>
40003ab0: b94b72c8     	ldr	w8, [x22, #0xb70]
40003ab4: 34000108     	cbz	w8, 0x40003ad4 <uart_printf+0x170>
40003ab8: b94b76e8     	ldr	w8, [x23, #0xb74]
40003abc: 6b19011f     	cmp	w8, w25
40003ac0: 540000ac     	b.gt	0x40003ad4 <uart_printf+0x170>
40003ac4: 93407d08     	sxtw	x8, w8
40003ac8: 11000509     	add	w9, w8, #0x1
40003acc: 78286b1a     	strh	w26, [x24, x8]
40003ad0: b90b76e9     	str	w9, [x23, #0xb74]
40003ad4: b94002a8     	ldr	w8, [x21]
40003ad8: 372fffe8     	tbnz	w8, #0x5, 0x40003ad4 <uart_printf+0x170>
40003adc: b900037a     	str	w26, [x27]
40003ae0: 38746a68     	ldrb	w8, [x19, x20]
40003ae4: b94b72c9     	ldr	w9, [x22, #0xb70]
40003ae8: 34000129     	cbz	w9, 0x40003b0c <uart_printf+0x1a8>
40003aec: b94b76e9     	ldr	w9, [x23, #0xb74]
40003af0: 6b19013f     	cmp	w9, w25
40003af4: 540000cc     	b.gt	0x40003b0c <uart_printf+0x1a8>
40003af8: 93407d29     	sxtw	x9, w9
40003afc: 9100052a     	add	x10, x9, #0x1
40003b00: 38296b08     	strb	w8, [x24, x9]
40003b04: b90b76ea     	str	w10, [x23, #0xb74]
40003b08: 382a6b1f     	strb	wzr, [x24, x10]
40003b0c: b94002a9     	ldr	w9, [x21]
40003b10: 372fffe9     	tbnz	w9, #0x5, 0x40003b0c <uart_printf+0x1a8>
40003b14: 17ffffc1     	b	0x40003a18 <uart_printf+0xb4>
40003b18: 2a0803e9     	mov	w9, w8
40003b1c: aa0a03f4     	mov	x20, x10
40003b20: 7101bd3f     	cmp	w9, #0x6f
40003b24: 54fffa8c     	b.gt	0x40003a74 <uart_printf+0x110>
40003b28: 7100953f     	cmp	w9, #0x25
40003b2c: 54000440     	b.eq	0x40003bb4 <uart_printf+0x250>
40003b30: 71018d3f     	cmp	w9, #0x63
40003b34: 54000bc0     	b.eq	0x40003cac <uart_printf+0x348>
40003b38: 7101913f     	cmp	w9, #0x64
40003b3c: 54000581     	b.ne	0x40003bec <uart_printf+0x288>
40003b40: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003b44: 7101b11f     	cmp	w8, #0x6c
40003b48: 54001761     	b.ne	0x40003e34 <uart_printf+0x4d0>
40003b4c: 36f82349     	tbz	w9, #0x1f, 0x40003fb4 <uart_printf+0x650>
40003b50: 11002128     	add	w8, w9, #0x8
40003b54: 3100213f     	cmn	w9, #0x8
40003b58: b81d83a8     	stur	w8, [x29, #-0x28]
40003b5c: 540022c8     	b.hi	0x40003fb4 <uart_printf+0x650>
40003b60: f85c83a8     	ldur	x8, [x29, #-0x38]
40003b64: 8b090108     	add	x8, x8, x9
40003b68: f9400109     	ldr	x9, [x8]
40003b6c: b6f82909     	tbz	x9, #0x3f, 0x4000408c <uart_printf+0x728>
40003b70: 14000116     	b	0x40003fc8 <uart_printf+0x664>
40003b74: 7101d53f     	cmp	w9, #0x75
40003b78: 54000800     	b.eq	0x40003c78 <uart_printf+0x314>
40003b7c: 7101e13f     	cmp	w9, #0x78
40003b80: 54000361     	b.ne	0x40003bec <uart_printf+0x288>
40003b84: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003b88: 7101b11f     	cmp	w8, #0x6c
40003b8c: 54001441     	b.ne	0x40003e14 <uart_printf+0x4b0>
40003b90: 36f81cc9     	tbz	w9, #0x1f, 0x40003f28 <uart_printf+0x5c4>
40003b94: 11002128     	add	w8, w9, #0x8
40003b98: 3100213f     	cmn	w9, #0x8
40003b9c: b81d83a8     	stur	w8, [x29, #-0x28]
40003ba0: 54001c48     	b.hi	0x40003f28 <uart_printf+0x5c4>
40003ba4: f85c83a8     	ldur	x8, [x29, #-0x38]
40003ba8: 8b090108     	add	x8, x8, x9
40003bac: f9400108     	ldr	x8, [x8]
40003bb0: 140000e7     	b	0x40003f4c <uart_printf+0x5e8>
40003bb4: b94b72c8     	ldr	w8, [x22, #0xb70]
40003bb8: 34000108     	cbz	w8, 0x40003bd8 <uart_printf+0x274>
40003bbc: b94b76e8     	ldr	w8, [x23, #0xb74]
40003bc0: 6b19011f     	cmp	w8, w25
40003bc4: 540000ac     	b.gt	0x40003bd8 <uart_printf+0x274>
40003bc8: 93407d08     	sxtw	x8, w8
40003bcc: 11000509     	add	w9, w8, #0x1
40003bd0: 78286b0e     	strh	w14, [x24, x8]
40003bd4: b90b76e9     	str	w9, [x23, #0xb74]
40003bd8: b94002a8     	ldr	w8, [x21]
40003bdc: 372fffe8     	tbnz	w8, #0x5, 0x40003bd8 <uart_printf+0x274>
40003be0: b900036e     	str	w14, [x27]
40003be4: 91000694     	add	x20, x20, #0x1
40003be8: 17ffff8e     	b	0x40003a20 <uart_printf+0xbc>
40003bec: b94b72c8     	ldr	w8, [x22, #0xb70]
40003bf0: 34000108     	cbz	w8, 0x40003c10 <uart_printf+0x2ac>
40003bf4: b94b76e8     	ldr	w8, [x23, #0xb74]
40003bf8: 6b19011f     	cmp	w8, w25
40003bfc: 540000ac     	b.gt	0x40003c10 <uart_printf+0x2ac>
40003c00: 93407d08     	sxtw	x8, w8
40003c04: 11000509     	add	w9, w8, #0x1
40003c08: 78286b0e     	strh	w14, [x24, x8]
40003c0c: b90b76e9     	str	w9, [x23, #0xb74]
40003c10: b94002a8     	ldr	w8, [x21]
40003c14: 372fffe8     	tbnz	w8, #0x5, 0x40003c10 <uart_printf+0x2ac>
40003c18: b900036e     	str	w14, [x27]
40003c1c: b94b72c9     	ldr	w9, [x22, #0xb70]
40003c20: 38746a68     	ldrb	w8, [x19, x20]
40003c24: 34000129     	cbz	w9, 0x40003c48 <uart_printf+0x2e4>
40003c28: b94b76e9     	ldr	w9, [x23, #0xb74]
40003c2c: 6b19013f     	cmp	w9, w25
40003c30: 540000cc     	b.gt	0x40003c48 <uart_printf+0x2e4>
40003c34: 93407d29     	sxtw	x9, w9
40003c38: 9100052a     	add	x10, x9, #0x1
40003c3c: 38296b08     	strb	w8, [x24, x9]
40003c40: b90b76ea     	str	w10, [x23, #0xb74]
40003c44: 382a6b1f     	strb	wzr, [x24, x10]
40003c48: b94002a9     	ldr	w9, [x21]
40003c4c: 372fffe9     	tbnz	w9, #0x5, 0x40003c48 <uart_printf+0x2e4>
40003c50: 17ffff72     	b	0x40003a18 <uart_printf+0xb4>
40003c54: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003c58: 36f803c8     	tbz	w8, #0x1f, 0x40003cd0 <uart_printf+0x36c>
40003c5c: 11002109     	add	w9, w8, #0x8
40003c60: 3100211f     	cmn	w8, #0x8
40003c64: b81d83a9     	stur	w9, [x29, #-0x28]
40003c68: 54000348     	b.hi	0x40003cd0 <uart_printf+0x36c>
40003c6c: f85c83a9     	ldur	x9, [x29, #-0x38]
40003c70: 8b080128     	add	x8, x9, x8
40003c74: 1400001a     	b	0x40003cdc <uart_printf+0x378>
40003c78: b89d83a9     	ldursw	x9, [x29, #-0x28]
40003c7c: 7101b11f     	cmp	w8, #0x6c
40003c80: 54000ba1     	b.ne	0x40003df4 <uart_printf+0x490>
40003c84: 36f80e89     	tbz	w9, #0x1f, 0x40003e54 <uart_printf+0x4f0>
40003c88: 11002128     	add	w8, w9, #0x8
40003c8c: 3100213f     	cmn	w9, #0x8
40003c90: b81d83a8     	stur	w8, [x29, #-0x28]
40003c94: 54000e08     	b.hi	0x40003e54 <uart_printf+0x4f0>
40003c98: f85c83a8     	ldur	x8, [x29, #-0x38]
40003c9c: 8b090108     	add	x8, x8, x9
40003ca0: f9400109     	ldr	x9, [x8]
40003ca4: b5001069     	cbnz	x9, 0x40003eb0 <uart_printf+0x54c>
40003ca8: 14000070     	b	0x40003e68 <uart_printf+0x504>
40003cac: b89d83a8     	ldursw	x8, [x29, #-0x28]
40003cb0: 36f80808     	tbz	w8, #0x1f, 0x40003db0 <uart_printf+0x44c>
40003cb4: 11002109     	add	w9, w8, #0x8
40003cb8: 3100211f     	cmn	w8, #0x8
40003cbc: b81d83a9     	stur	w9, [x29, #-0x28]
40003cc0: 54000788     	b.hi	0x40003db0 <uart_printf+0x44c>
40003cc4: f85c83a9     	ldur	x9, [x29, #-0x38]
40003cc8: 8b080128     	add	x8, x9, x8
40003ccc: 1400003c     	b	0x40003dbc <uart_printf+0x458>
40003cd0: f85c03a8     	ldur	x8, [x29, #-0x40]
40003cd4: 91002109     	add	x9, x8, #0x8
40003cd8: f81c03a9     	stur	x9, [x29, #-0x40]
40003cdc: f9400100     	ldr	x0, [x8]
40003ce0: 97fffe82     	bl	0x400036e8 <uart_print_hex>
40003ce4: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003ce8: 528004ae     	mov	w14, #0x25              // =37
40003cec: 52800150     	mov	w16, #0xa               // =10
40003cf0: f29999af     	movk	x15, #0xcccd
40003cf4: d503201f     	nop
40003cf8: 30013911     	adr	x17, 0x40006419 <__rodata_start+0x419>
40003cfc: 91000694     	add	x20, x20, #0x1
40003d00: 17ffff48     	b	0x40003a20 <uart_printf+0xbc>
40003d04: f85c03a8     	ldur	x8, [x29, #-0x40]
40003d08: 91002109     	add	x9, x8, #0x8
40003d0c: f81c03a9     	stur	x9, [x29, #-0x40]
40003d10: f9400108     	ldr	x8, [x8]
40003d14: b0000029     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
40003d18: 91082929     	add	x9, x9, #0x20a
40003d1c: f100011f     	cmp	x8, #0x0
40003d20: 9a880128     	csel	x8, x9, x8, eq
40003d24: 39400109     	ldrb	w9, [x8]
40003d28: 7100293f     	cmp	w9, #0xa
40003d2c: 540000a0     	b.eq	0x40003d40 <uart_printf+0x3dc>
40003d30: 34ffe769     	cbz	w9, 0x40003a1c <uart_printf+0xb8>
40003d34: b94b72ca     	ldr	w10, [x22, #0xb70]
40003d38: 3500022a     	cbnz	w10, 0x40003d7c <uart_printf+0x418>
40003d3c: 14000018     	b	0x40003d9c <uart_printf+0x438>
40003d40: b94b72c9     	ldr	w9, [x22, #0xb70]
40003d44: 34000109     	cbz	w9, 0x40003d64 <uart_printf+0x400>
40003d48: b94b76e9     	ldr	w9, [x23, #0xb74]
40003d4c: 6b19013f     	cmp	w9, w25
40003d50: 540000ac     	b.gt	0x40003d64 <uart_printf+0x400>
40003d54: 93407d29     	sxtw	x9, w9
40003d58: 1100052a     	add	w10, w9, #0x1
40003d5c: 78296b1a     	strh	w26, [x24, x9]
40003d60: b90b76ea     	str	w10, [x23, #0xb74]
40003d64: b94002a9     	ldr	w9, [x21]
40003d68: 372fffe9     	tbnz	w9, #0x5, 0x40003d64 <uart_printf+0x400>
40003d6c: b900037a     	str	w26, [x27]
40003d70: 39400109     	ldrb	w9, [x8]
40003d74: b94b72ca     	ldr	w10, [x22, #0xb70]
40003d78: 3400012a     	cbz	w10, 0x40003d9c <uart_printf+0x438>
40003d7c: b94b76ea     	ldr	w10, [x23, #0xb74]
40003d80: 6b19015f     	cmp	w10, w25
40003d84: 540000cc     	b.gt	0x40003d9c <uart_printf+0x438>
40003d88: 93407d4a     	sxtw	x10, w10
40003d8c: 9100054b     	add	x11, x10, #0x1
40003d90: 382a6b09     	strb	w9, [x24, x10]
40003d94: b90b76eb     	str	w11, [x23, #0xb74]
40003d98: 382b6b1f     	strb	wzr, [x24, x11]
40003d9c: 91000508     	add	x8, x8, #0x1
40003da0: b94002aa     	ldr	w10, [x21]
40003da4: 372fffea     	tbnz	w10, #0x5, 0x40003da0 <uart_printf+0x43c>
40003da8: b9000369     	str	w9, [x27]
40003dac: 17ffffde     	b	0x40003d24 <uart_printf+0x3c0>
40003db0: f85c03a8     	ldur	x8, [x29, #-0x40]
40003db4: 91002109     	add	x9, x8, #0x8
40003db8: f81c03a9     	stur	x9, [x29, #-0x40]
40003dbc: b94b72c9     	ldr	w9, [x22, #0xb70]
40003dc0: 39400108     	ldrb	w8, [x8]
40003dc4: 34000129     	cbz	w9, 0x40003de8 <uart_printf+0x484>
40003dc8: b94b76e9     	ldr	w9, [x23, #0xb74]
40003dcc: 6b19013f     	cmp	w9, w25
40003dd0: 540000cc     	b.gt	0x40003de8 <uart_printf+0x484>
40003dd4: 93407d29     	sxtw	x9, w9
40003dd8: 9100052a     	add	x10, x9, #0x1
40003ddc: 38296b08     	strb	w8, [x24, x9]
40003de0: b90b76ea     	str	w10, [x23, #0xb74]
40003de4: 382a6b1f     	strb	wzr, [x24, x10]
40003de8: b94002a9     	ldr	w9, [x21]
40003dec: 372fffe9     	tbnz	w9, #0x5, 0x40003de8 <uart_printf+0x484>
40003df0: 17ffff0a     	b	0x40003a18 <uart_printf+0xb4>
40003df4: 36f80549     	tbz	w9, #0x1f, 0x40003e9c <uart_printf+0x538>
40003df8: 11002128     	add	w8, w9, #0x8
40003dfc: 3100213f     	cmn	w9, #0x8
40003e00: b81d83a8     	stur	w8, [x29, #-0x28]
40003e04: 540004c8     	b.hi	0x40003e9c <uart_printf+0x538>
40003e08: f85c83a8     	ldur	x8, [x29, #-0x38]
40003e0c: 8b090108     	add	x8, x8, x9
40003e10: 14000026     	b	0x40003ea8 <uart_printf+0x544>
40003e14: 36f80949     	tbz	w9, #0x1f, 0x40003f3c <uart_printf+0x5d8>
40003e18: 11002128     	add	w8, w9, #0x8
40003e1c: 3100213f     	cmn	w9, #0x8
40003e20: b81d83a8     	stur	w8, [x29, #-0x28]
40003e24: 540008c8     	b.hi	0x40003f3c <uart_printf+0x5d8>
40003e28: f85c83a8     	ldur	x8, [x29, #-0x38]
40003e2c: 8b090108     	add	x8, x8, x9
40003e30: 14000046     	b	0x40003f48 <uart_printf+0x5e4>
40003e34: 36f81229     	tbz	w9, #0x1f, 0x40004078 <uart_printf+0x714>
40003e38: 11002128     	add	w8, w9, #0x8
40003e3c: 3100213f     	cmn	w9, #0x8
40003e40: b81d83a8     	stur	w8, [x29, #-0x28]
40003e44: 540011a8     	b.hi	0x40004078 <uart_printf+0x714>
40003e48: f85c83a8     	ldur	x8, [x29, #-0x38]
40003e4c: 8b090108     	add	x8, x8, x9
40003e50: 1400008d     	b	0x40004084 <uart_printf+0x720>
40003e54: f85c03a8     	ldur	x8, [x29, #-0x40]
40003e58: 91002109     	add	x9, x8, #0x8
40003e5c: f81c03a9     	stur	x9, [x29, #-0x40]
40003e60: f9400109     	ldr	x9, [x8]
40003e64: b5000269     	cbnz	x9, 0x40003eb0 <uart_printf+0x54c>
40003e68: b94b72c8     	ldr	w8, [x22, #0xb70]
40003e6c: 34000128     	cbz	w8, 0x40003e90 <uart_printf+0x52c>
40003e70: b94b76e8     	ldr	w8, [x23, #0xb74]
40003e74: 6b19011f     	cmp	w8, w25
40003e78: 540000cc     	b.gt	0x40003e90 <uart_printf+0x52c>
40003e7c: 93407d08     	sxtw	x8, w8
40003e80: 11000509     	add	w9, w8, #0x1
40003e84: b90b76e9     	str	w9, [x23, #0xb74]
40003e88: 52800609     	mov	w9, #0x30               // =48
40003e8c: 78286b09     	strh	w9, [x24, x8]
40003e90: b94002a8     	ldr	w8, [x21]
40003e94: 372fffe8     	tbnz	w8, #0x5, 0x40003e90 <uart_printf+0x52c>
40003e98: 17fffedf     	b	0x40003a14 <uart_printf+0xb0>
40003e9c: f85c03a8     	ldur	x8, [x29, #-0x40]
40003ea0: 91002109     	add	x9, x8, #0x8
40003ea4: f81c03a9     	stur	x9, [x29, #-0x40]
40003ea8: b9400109     	ldr	w9, [x8]
40003eac: b4fffde9     	cbz	x9, 0x40003e68 <uart_printf+0x504>
40003eb0: aa1f03ea     	mov	x10, xzr
40003eb4: 9bcf7d28     	umulh	x8, x9, x15
40003eb8: f100253f     	cmp	x9, #0x9
40003ebc: d343fd0b     	lsr	x11, x8, #3
40003ec0: 91000548     	add	x8, x10, #0x1
40003ec4: 1b10a56c     	msub	w12, w11, w16, w9
40003ec8: 321c0589     	orr	w9, w12, #0x30
40003ecc: 382a6b89     	strb	w9, [x28, x10]
40003ed0: aa0803ea     	mov	x10, x8
40003ed4: aa0b03e9     	mov	x9, x11
40003ed8: 54fffee8     	b.hi	0x40003eb4 <uart_printf+0x550>
40003edc: d1000509     	sub	x9, x8, #0x1
40003ee0: b94b72cb     	ldr	w11, [x22, #0xb70]
40003ee4: 38696b8a     	ldrb	w10, [x28, x9]
40003ee8: 3400012b     	cbz	w11, 0x40003f0c <uart_printf+0x5a8>
40003eec: b94b76eb     	ldr	w11, [x23, #0xb74]
40003ef0: 6b19017f     	cmp	w11, w25
40003ef4: 540000cc     	b.gt	0x40003f0c <uart_printf+0x5a8>
40003ef8: 93407d6b     	sxtw	x11, w11
40003efc: 9100056c     	add	x12, x11, #0x1
40003f00: 382b6b0a     	strb	w10, [x24, x11]
40003f04: b90b76ec     	str	w12, [x23, #0xb74]
40003f08: 382c6b1f     	strb	wzr, [x24, x12]
40003f0c: b94002ab     	ldr	w11, [x21]
40003f10: 372fffeb     	tbnz	w11, #0x5, 0x40003f0c <uart_printf+0x5a8>
40003f14: 7100051f     	cmp	w8, #0x1
40003f18: aa0903e8     	mov	x8, x9
40003f1c: b900036a     	str	w10, [x27]
40003f20: 54fffdec     	b.gt	0x40003edc <uart_printf+0x578>
40003f24: 17fffebe     	b	0x40003a1c <uart_printf+0xb8>
40003f28: f85c03a8     	ldur	x8, [x29, #-0x40]
40003f2c: 91002109     	add	x9, x8, #0x8
40003f30: f81c03a9     	stur	x9, [x29, #-0x40]
40003f34: f9400108     	ldr	x8, [x8]
40003f38: 14000005     	b	0x40003f4c <uart_printf+0x5e8>
40003f3c: f85c03a8     	ldur	x8, [x29, #-0x40]
40003f40: 91002109     	add	x9, x8, #0x8
40003f44: f81c03a9     	stur	x9, [x29, #-0x40]
40003f48: b9400108     	ldr	w8, [x8]
40003f4c: 2a1f03e9     	mov	w9, wzr
40003f50: 5280078a     	mov	w10, #0x3c              // =60
40003f54: 14000003     	b	0x40003f60 <uart_printf+0x5fc>
40003f58: b4000d8a     	cbz	x10, 0x40004108 <uart_printf+0x7a4>
40003f5c: d100114a     	sub	x10, x10, #0x4
40003f60: 9aca250b     	lsr	x11, x8, x10
40003f64: f2400d6b     	ands	x11, x11, #0xf
40003f68: fa400944     	ccmp	x10, #0x0, #0x4, eq
40003f6c: 1a9f1529     	csinc	w9, w9, wzr, ne
40003f70: 34ffff49     	cbz	w9, 0x40003f58 <uart_printf+0x5f4>
40003f74: b94b72cc     	ldr	w12, [x22, #0xb70]
40003f78: 386b6a2b     	ldrb	w11, [x17, x11]
40003f7c: 3400012c     	cbz	w12, 0x40003fa0 <uart_printf+0x63c>
40003f80: b94b76ec     	ldr	w12, [x23, #0xb74]
40003f84: 6b19019f     	cmp	w12, w25
40003f88: 540000cc     	b.gt	0x40003fa0 <uart_printf+0x63c>
40003f8c: 93407d8c     	sxtw	x12, w12
40003f90: 9100058d     	add	x13, x12, #0x1
40003f94: 382c6b0b     	strb	w11, [x24, x12]
40003f98: b90b76ed     	str	w13, [x23, #0xb74]
40003f9c: 382d6b1f     	strb	wzr, [x24, x13]
40003fa0: b94002ac     	ldr	w12, [x21]
40003fa4: 372fffec     	tbnz	w12, #0x5, 0x40003fa0 <uart_printf+0x63c>
40003fa8: b900036b     	str	w11, [x27]
40003fac: b5fffd8a     	cbnz	x10, 0x40003f5c <uart_printf+0x5f8>
40003fb0: 17fffe9b     	b	0x40003a1c <uart_printf+0xb8>
40003fb4: f85c03a8     	ldur	x8, [x29, #-0x40]
40003fb8: 91002109     	add	x9, x8, #0x8
40003fbc: f81c03a9     	stur	x9, [x29, #-0x40]
40003fc0: f9400109     	ldr	x9, [x8]
40003fc4: b6f80649     	tbz	x9, #0x3f, 0x4000408c <uart_printf+0x728>
40003fc8: b94b72c8     	ldr	w8, [x22, #0xb70]
40003fcc: 34000128     	cbz	w8, 0x40003ff0 <uart_printf+0x68c>
40003fd0: b94b76e8     	ldr	w8, [x23, #0xb74]
40003fd4: 6b19011f     	cmp	w8, w25
40003fd8: 540000cc     	b.gt	0x40003ff0 <uart_printf+0x68c>
40003fdc: 93407d08     	sxtw	x8, w8
40003fe0: 1100050a     	add	w10, w8, #0x1
40003fe4: b90b76ea     	str	w10, [x23, #0xb74]
40003fe8: 528005aa     	mov	w10, #0x2d              // =45
40003fec: 78286b0a     	strh	w10, [x24, x8]
40003ff0: b94002a8     	ldr	w8, [x21]
40003ff4: 372fffe8     	tbnz	w8, #0x5, 0x40003ff0 <uart_printf+0x68c>
40003ff8: aa1f03e8     	mov	x8, xzr
40003ffc: 528005aa     	mov	w10, #0x2d              // =45
40004000: cb0903e9     	neg	x9, x9
40004004: b900036a     	str	w10, [x27]
40004008: 9bcf7d2a     	umulh	x10, x9, x15
4000400c: f100253f     	cmp	x9, #0x9
40004010: d343fd4a     	lsr	x10, x10, #3
40004014: 1b10a54b     	msub	w11, w10, w16, w9
40004018: 321c0569     	orr	w9, w11, #0x30
4000401c: 38286b89     	strb	w9, [x28, x8]
40004020: 91000508     	add	x8, x8, #0x1
40004024: aa0a03e9     	mov	x9, x10
40004028: 54ffff08     	b.hi	0x40004008 <uart_printf+0x6a4>
4000402c: d1000509     	sub	x9, x8, #0x1
40004030: b94b72cb     	ldr	w11, [x22, #0xb70]
40004034: 38696b8a     	ldrb	w10, [x28, x9]
40004038: 3400012b     	cbz	w11, 0x4000405c <uart_printf+0x6f8>
4000403c: b94b76eb     	ldr	w11, [x23, #0xb74]
40004040: 6b19017f     	cmp	w11, w25
40004044: 540000cc     	b.gt	0x4000405c <uart_printf+0x6f8>
40004048: 93407d6b     	sxtw	x11, w11
4000404c: 9100056c     	add	x12, x11, #0x1
40004050: 382b6b0a     	strb	w10, [x24, x11]
40004054: b90b76ec     	str	w12, [x23, #0xb74]
40004058: 382c6b1f     	strb	wzr, [x24, x12]
4000405c: b94002ab     	ldr	w11, [x21]
40004060: 372fffeb     	tbnz	w11, #0x5, 0x4000405c <uart_printf+0x6f8>
40004064: 7100051f     	cmp	w8, #0x1
40004068: aa0903e8     	mov	x8, x9
4000406c: b900036a     	str	w10, [x27]
40004070: 54fffdec     	b.gt	0x4000402c <uart_printf+0x6c8>
40004074: 17fffe6a     	b	0x40003a1c <uart_printf+0xb8>
40004078: f85c03a8     	ldur	x8, [x29, #-0x40]
4000407c: 91002109     	add	x9, x8, #0x8
40004080: f81c03a9     	stur	x9, [x29, #-0x40]
40004084: b9800109     	ldrsw	x9, [x8]
40004088: b7fffa09     	tbnz	x9, #0x3f, 0x40003fc8 <uart_printf+0x664>
4000408c: b4000589     	cbz	x9, 0x4000413c <uart_printf+0x7d8>
40004090: aa1f03ea     	mov	x10, xzr
40004094: 9bcf7d28     	umulh	x8, x9, x15
40004098: f100253f     	cmp	x9, #0x9
4000409c: d343fd0b     	lsr	x11, x8, #3
400040a0: 91000548     	add	x8, x10, #0x1
400040a4: 1b10a56c     	msub	w12, w11, w16, w9
400040a8: 321c0589     	orr	w9, w12, #0x30
400040ac: 382a6b89     	strb	w9, [x28, x10]
400040b0: aa0803ea     	mov	x10, x8
400040b4: aa0b03e9     	mov	x9, x11
400040b8: 54fffee8     	b.hi	0x40004094 <uart_printf+0x730>
400040bc: d1000509     	sub	x9, x8, #0x1
400040c0: b94b72cb     	ldr	w11, [x22, #0xb70]
400040c4: 38696b8a     	ldrb	w10, [x28, x9]
400040c8: 3400012b     	cbz	w11, 0x400040ec <uart_printf+0x788>
400040cc: b94b76eb     	ldr	w11, [x23, #0xb74]
400040d0: 6b19017f     	cmp	w11, w25
400040d4: 540000cc     	b.gt	0x400040ec <uart_printf+0x788>
400040d8: 93407d6b     	sxtw	x11, w11
400040dc: 9100056c     	add	x12, x11, #0x1
400040e0: 382b6b0a     	strb	w10, [x24, x11]
400040e4: b90b76ec     	str	w12, [x23, #0xb74]
400040e8: 382c6b1f     	strb	wzr, [x24, x12]
400040ec: b94002ab     	ldr	w11, [x21]
400040f0: 372fffeb     	tbnz	w11, #0x5, 0x400040ec <uart_printf+0x788>
400040f4: 7100051f     	cmp	w8, #0x1
400040f8: aa0903e8     	mov	x8, x9
400040fc: b900036a     	str	w10, [x27]
40004100: 54fffdec     	b.gt	0x400040bc <uart_printf+0x758>
40004104: 17fffe46     	b	0x40003a1c <uart_printf+0xb8>
40004108: b94b72c8     	ldr	w8, [x22, #0xb70]
4000410c: 34000128     	cbz	w8, 0x40004130 <uart_printf+0x7cc>
40004110: b94b76e8     	ldr	w8, [x23, #0xb74]
40004114: 6b19011f     	cmp	w8, w25
40004118: 540000cc     	b.gt	0x40004130 <uart_printf+0x7cc>
4000411c: 93407d08     	sxtw	x8, w8
40004120: 11000509     	add	w9, w8, #0x1
40004124: b90b76e9     	str	w9, [x23, #0xb74]
40004128: 52800609     	mov	w9, #0x30               // =48
4000412c: 78286b09     	strh	w9, [x24, x8]
40004130: b94002a8     	ldr	w8, [x21]
40004134: 372fffe8     	tbnz	w8, #0x5, 0x40004130 <uart_printf+0x7cc>
40004138: 17fffe37     	b	0x40003a14 <uart_printf+0xb0>
4000413c: b94b72c8     	ldr	w8, [x22, #0xb70]
40004140: 34000128     	cbz	w8, 0x40004164 <uart_printf+0x800>
40004144: b94b76e8     	ldr	w8, [x23, #0xb74]
40004148: 6b19011f     	cmp	w8, w25
4000414c: 540000cc     	b.gt	0x40004164 <uart_printf+0x800>
40004150: 93407d08     	sxtw	x8, w8
40004154: 11000509     	add	w9, w8, #0x1
40004158: b90b76e9     	str	w9, [x23, #0xb74]
4000415c: 52800609     	mov	w9, #0x30               // =48
40004160: 78286b09     	strh	w9, [x24, x8]
40004164: b94002a8     	ldr	w8, [x21]
40004168: 372fffe8     	tbnz	w8, #0x5, 0x40004164 <uart_printf+0x800>
4000416c: 17fffe2a     	b	0x40003a14 <uart_printf+0xb0>
40004170: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40004174: a95457f6     	ldp	x22, x21, [sp, #0x140]
40004178: a9535ff8     	ldp	x24, x23, [sp, #0x130]
4000417c: a95267fa     	ldp	x26, x25, [sp, #0x120]
40004180: a9516ffc     	ldp	x28, x27, [sp, #0x110]
40004184: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40004188: 910583ff     	add	sp, sp, #0x160
4000418c: d65f03c0     	ret

0000000040004190 <vfs_init>:
40004190: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40004194: a9044ff4     	stp	x20, x19, [sp, #0x40]
40004198: d0000073     	adrp	x19, 0x40012000 <kernel_capture_buffer+0x3488>
4000419c: 912e4273     	add	x19, x19, #0xb90
400041a0: f9000bf9     	str	x25, [sp, #0x10]
400041a4: d0000079     	adrp	x25, 0x40012000 <kernel_capture_buffer+0x3488>
400041a8: 52800034     	mov	w20, #0x1               // =1
400041ac: aa1303e0     	mov	x0, x19
400041b0: 2a1f03e1     	mov	w1, wzr
400041b4: 52809802     	mov	w2, #0x4c0              // =1216
400041b8: a9025ff8     	stp	x24, x23, [sp, #0x20]
400041bc: 910003fd     	mov	x29, sp
400041c0: a90357f6     	stp	x22, x21, [sp, #0x30]
400041c4: b90b7b34     	str	w20, [x25, #0xb78]
400041c8: 97fff96c     	bl	0x40002778 <kmemset>
400041cc: 528005e8     	mov	w8, #0x2f               // =47
400041d0: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
400041d4: b9002274     	str	w20, [x19, #0x20]
400041d8: 79000268     	strh	w8, [x19]
400041dc: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400041e0: f905c133     	str	x19, [x9, #0xb80]
400041e4: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
400041e8: 7101fd1f     	cmp	w8, #0x7f
400041ec: f9021a7f     	str	xzr, [x19, #0x430]
400041f0: f900167f     	str	xzr, [x19, #0x28]
400041f4: b904ba7f     	str	wzr, [x19, #0x4b8]
400041f8: f905c533     	str	x19, [x9, #0xb88]
400041fc: 540027ac     	b.gt	0x400046f0 <vfs_init+0x560>
40004200: 52809809     	mov	w9, #0x4c0              // =1216
40004204: 2a1f03e1     	mov	w1, wzr
40004208: 52809802     	mov	w2, #0x4c0              // =1216
4000420c: 9b294d17     	smaddl	x23, w8, w9, x19
40004210: 11000508     	add	w8, w8, #0x1
40004214: b90b7b28     	str	w8, [x25, #0xb78]
40004218: aa1703e0     	mov	x0, x23
4000421c: 97fff957     	bl	0x40002778 <kmemset>
40004220: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40004224: b904baff     	str	wzr, [x23, #0x4b8]
40004228: fd413900     	ldr	d0, [x8, #0x270]
4000422c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004230: b90022f4     	str	w20, [x23, #0x20]
40004234: f9021af3     	str	x19, [x23, #0x430]
40004238: 71003d1f     	cmp	w8, #0xf
4000423c: bd0002e0     	str	s0, [x23]
40004240: f90016ff     	str	xzr, [x23, #0x28]
40004244: 540000ac     	b.gt	0x40004258 <vfs_init+0xc8>
40004248: 11000509     	add	w9, w8, #0x1
4000424c: 8b080e68     	add	x8, x19, x8, lsl #3
40004250: b904ba69     	str	w9, [x19, #0x4b8]
40004254: f9021d17     	str	x23, [x8, #0x438]
40004258: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000425c: 7101fd1f     	cmp	w8, #0x7f
40004260: 5400248c     	b.gt	0x400046f0 <vfs_init+0x560>
40004264: 52809809     	mov	w9, #0x4c0              // =1216
40004268: 2a1f03e1     	mov	w1, wzr
4000426c: 52809802     	mov	w2, #0x4c0              // =1216
40004270: 9b294d16     	smaddl	x22, w8, w9, x19
40004274: 11000508     	add	w8, w8, #0x1
40004278: b90b7b28     	str	w8, [x25, #0xb78]
4000427c: aa1603e0     	mov	x0, x22
40004280: 97fff93e     	bl	0x40002778 <kmemset>
40004284: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40004288: b904badf     	str	wzr, [x22, #0x4b8]
4000428c: 52800029     	mov	w9, #0x1                // =1
40004290: fd414500     	ldr	d0, [x8, #0x288]
40004294: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004298: b90022c9     	str	w9, [x22, #0x20]
4000429c: f9021ad3     	str	x19, [x22, #0x430]
400042a0: 71003d1f     	cmp	w8, #0xf
400042a4: bd0002c0     	str	s0, [x22]
400042a8: f90016df     	str	xzr, [x22, #0x28]
400042ac: 540000ac     	b.gt	0x400042c0 <vfs_init+0x130>
400042b0: 11000509     	add	w9, w8, #0x1
400042b4: 8b080e68     	add	x8, x19, x8, lsl #3
400042b8: b904ba69     	str	w9, [x19, #0x4b8]
400042bc: f9021d16     	str	x22, [x8, #0x438]
400042c0: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400042c4: 7101fd1f     	cmp	w8, #0x7f
400042c8: 5400214c     	b.gt	0x400046f0 <vfs_init+0x560>
400042cc: 52809809     	mov	w9, #0x4c0              // =1216
400042d0: 2a1f03e1     	mov	w1, wzr
400042d4: 52809802     	mov	w2, #0x4c0              // =1216
400042d8: 9b294d14     	smaddl	x20, w8, w9, x19
400042dc: 11000508     	add	w8, w8, #0x1
400042e0: b90b7b28     	str	w8, [x25, #0xb78]
400042e4: aa1403e0     	mov	x0, x20
400042e8: 97fff924     	bl	0x40002778 <kmemset>
400042ec: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400042f0: b904ba9f     	str	wzr, [x20, #0x4b8]
400042f4: 52800029     	mov	w9, #0x1                // =1
400042f8: fd413d00     	ldr	d0, [x8, #0x278]
400042fc: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004300: 3900129f     	strb	wzr, [x20, #0x4]
40004304: b9002289     	str	w9, [x20, #0x20]
40004308: 71003d1f     	cmp	w8, #0xf
4000430c: bd000280     	str	s0, [x20]
40004310: f9021a93     	str	x19, [x20, #0x430]
40004314: f900169f     	str	xzr, [x20, #0x28]
40004318: 540000ac     	b.gt	0x4000432c <vfs_init+0x19c>
4000431c: 11000509     	add	w9, w8, #0x1
40004320: 8b080e68     	add	x8, x19, x8, lsl #3
40004324: b904ba69     	str	w9, [x19, #0x4b8]
40004328: f9021d14     	str	x20, [x8, #0x438]
4000432c: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004330: 7101fd1f     	cmp	w8, #0x7f
40004334: 54001dec     	b.gt	0x400046f0 <vfs_init+0x560>
40004338: 52809809     	mov	w9, #0x4c0              // =1216
4000433c: 2a1f03e1     	mov	w1, wzr
40004340: 52809802     	mov	w2, #0x4c0              // =1216
40004344: 9b294d15     	smaddl	x21, w8, w9, x19
40004348: 11000508     	add	w8, w8, #0x1
4000434c: b90b7b28     	str	w8, [x25, #0xb78]
40004350: aa1503e0     	mov	x0, x21
40004354: 97fff909     	bl	0x40002778 <kmemset>
40004358: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000435c: b904babf     	str	wzr, [x21, #0x4b8]
40004360: 52800029     	mov	w9, #0x1                // =1
40004364: fd413500     	ldr	d0, [x8, #0x268]
40004368: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000436c: 390012bf     	strb	wzr, [x21, #0x4]
40004370: b90022a9     	str	w9, [x21, #0x20]
40004374: 71003d1f     	cmp	w8, #0xf
40004378: bd0002a0     	str	s0, [x21]
4000437c: f9021ab3     	str	x19, [x21, #0x430]
40004380: f90016bf     	str	xzr, [x21, #0x28]
40004384: 540000ac     	b.gt	0x40004398 <vfs_init+0x208>
40004388: 11000509     	add	w9, w8, #0x1
4000438c: 8b080e68     	add	x8, x19, x8, lsl #3
40004390: b904ba69     	str	w9, [x19, #0x4b8]
40004394: f9021d15     	str	x21, [x8, #0x438]
40004398: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000439c: 7101fd1f     	cmp	w8, #0x7f
400043a0: 54001a8c     	b.gt	0x400046f0 <vfs_init+0x560>
400043a4: 52809809     	mov	w9, #0x4c0              // =1216
400043a8: 2a1f03e1     	mov	w1, wzr
400043ac: 52809802     	mov	w2, #0x4c0              // =1216
400043b0: 9b294d18     	smaddl	x24, w8, w9, x19
400043b4: 11000508     	add	w8, w8, #0x1
400043b8: b90b7b28     	str	w8, [x25, #0xb78]
400043bc: aa1803e0     	mov	x0, x24
400043c0: 97fff8ee     	bl	0x40002778 <kmemset>
400043c4: 528d2c28     	mov	w8, #0x6961             // =26977
400043c8: b904bb1f     	str	wzr, [x24, #0x4b8]
400043cc: 79000308     	strh	w8, [x24]
400043d0: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400043d4: 39000b1f     	strb	wzr, [x24, #0x2]
400043d8: 71003d1f     	cmp	w8, #0xf
400043dc: b900231f     	str	wzr, [x24, #0x20]
400043e0: f9021b17     	str	x23, [x24, #0x430]
400043e4: f900171f     	str	xzr, [x24, #0x28]
400043e8: 540000ac     	b.gt	0x400043fc <vfs_init+0x26c>
400043ec: 8b080ee9     	add	x9, x23, x8, lsl #3
400043f0: 11000508     	add	w8, w8, #0x1
400043f4: b904bae8     	str	w8, [x23, #0x4b8]
400043f8: f9021d38     	str	x24, [x9, #0x438]
400043fc: d503201f     	nop
40004400: 1001e837     	adr	x23, 0x40008104 <__rodata_start+0x2104>
40004404: 9100c300     	add	x0, x24, #0x30
40004408: aa1703e1     	mov	x1, x23
4000440c: 97fff8a0     	bl	0x4000268c <kstrcpy>
40004410: aa1703e0     	mov	x0, x23
40004414: 97fff86f     	bl	0x400025d0 <kstrlen>
40004418: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000441c: f9001700     	str	x0, [x24, #0x28]
40004420: 7101fd1f     	cmp	w8, #0x7f
40004424: 5400166c     	b.gt	0x400046f0 <vfs_init+0x560>
40004428: 52809809     	mov	w9, #0x4c0              // =1216
4000442c: 2a1f03e1     	mov	w1, wzr
40004430: 52809802     	mov	w2, #0x4c0              // =1216
40004434: 9b294d17     	smaddl	x23, w8, w9, x19
40004438: 11000508     	add	w8, w8, #0x1
4000443c: b90b7b28     	str	w8, [x25, #0xb78]
40004440: aa1703e0     	mov	x0, x23
40004444: 97fff8cd     	bl	0x40002778 <kmemset>
40004448: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000444c: b904baff     	str	wzr, [x23, #0x4b8]
40004450: 528cae69     	mov	w9, #0x6573             // =25971
40004454: fd411100     	ldr	d0, [x8, #0x220]
40004458: b984bac8     	ldrsw	x8, [x22, #0x4b8]
4000445c: 39002aff     	strb	wzr, [x23, #0xa]
40004460: 790012e9     	strh	w9, [x23, #0x8]
40004464: 71003d1f     	cmp	w8, #0xf
40004468: fd0002e0     	str	d0, [x23]
4000446c: b90022ff     	str	wzr, [x23, #0x20]
40004470: f9021af6     	str	x22, [x23, #0x430]
40004474: f90016ff     	str	xzr, [x23, #0x28]
40004478: 540000ac     	b.gt	0x4000448c <vfs_init+0x2fc>
4000447c: 8b080ec9     	add	x9, x22, x8, lsl #3
40004480: 11000508     	add	w8, w8, #0x1
40004484: b904bac8     	str	w8, [x22, #0x4b8]
40004488: f9021d37     	str	x23, [x9, #0x438]
4000448c: d0000016     	adrp	x22, 0x40006000 <__rodata_start>
40004490: 9130fed6     	add	x22, x22, #0xc3f
40004494: 9100c2e0     	add	x0, x23, #0x30
40004498: aa1603e1     	mov	x1, x22
4000449c: 97fff87c     	bl	0x4000268c <kstrcpy>
400044a0: aa1603e0     	mov	x0, x22
400044a4: 97fff84b     	bl	0x400025d0 <kstrlen>
400044a8: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400044ac: f90016e0     	str	x0, [x23, #0x28]
400044b0: 7101fd1f     	cmp	w8, #0x7f
400044b4: 540011ec     	b.gt	0x400046f0 <vfs_init+0x560>
400044b8: 52809809     	mov	w9, #0x4c0              // =1216
400044bc: 2a1f03e1     	mov	w1, wzr
400044c0: 52809802     	mov	w2, #0x4c0              // =1216
400044c4: 9b294d16     	smaddl	x22, w8, w9, x19
400044c8: 11000508     	add	w8, w8, #0x1
400044cc: b90b7b28     	str	w8, [x25, #0xb78]
400044d0: aa1603e0     	mov	x0, x22
400044d4: 97fff8a9     	bl	0x40002778 <kmemset>
400044d8: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400044dc: b904badf     	str	wzr, [x22, #0x4b8]
400044e0: 90000029     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
400044e4: fd412d00     	ldr	d0, [x8, #0x258]
400044e8: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400044ec: fd412521     	ldr	d1, [x9, #0x248]
400044f0: b90022df     	str	wzr, [x22, #0x20]
400044f4: 71003d1f     	cmp	w8, #0xf
400044f8: fd0002c0     	str	d0, [x22]
400044fc: bd000ac1     	str	s1, [x22, #0x8]
40004500: f9021ad5     	str	x21, [x22, #0x430]
40004504: f90016df     	str	xzr, [x22, #0x28]
40004508: 540000ac     	b.gt	0x4000451c <vfs_init+0x38c>
4000450c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004510: 11000508     	add	w8, w8, #0x1
40004514: b904baa8     	str	w8, [x21, #0x4b8]
40004518: f9021d36     	str	x22, [x9, #0x438]
4000451c: d0000017     	adrp	x23, 0x40006000 <__rodata_start>
40004520: 9135caf7     	add	x23, x23, #0xd72
40004524: 9100c2c0     	add	x0, x22, #0x30
40004528: aa1703e1     	mov	x1, x23
4000452c: 97fff858     	bl	0x4000268c <kstrcpy>
40004530: aa1703e0     	mov	x0, x23
40004534: 97fff827     	bl	0x400025d0 <kstrlen>
40004538: b98b7b28     	ldrsw	x8, [x25, #0xb78]
4000453c: f90016c0     	str	x0, [x22, #0x28]
40004540: 7101fd1f     	cmp	w8, #0x7f
40004544: 54000d6c     	b.gt	0x400046f0 <vfs_init+0x560>
40004548: 52809809     	mov	w9, #0x4c0              // =1216
4000454c: 2a1f03e1     	mov	w1, wzr
40004550: 52809802     	mov	w2, #0x4c0              // =1216
40004554: 9b294d16     	smaddl	x22, w8, w9, x19
40004558: 11000508     	add	w8, w8, #0x1
4000455c: b90b7b28     	str	w8, [x25, #0xb78]
40004560: aa1603e0     	mov	x0, x22
40004564: 97fff885     	bl	0x40002778 <kmemset>
40004568: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000456c: b904badf     	str	wzr, [x22, #0x4b8]
40004570: 90000029     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
40004574: fd411500     	ldr	d0, [x8, #0x228]
40004578: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000457c: fd411921     	ldr	d1, [x9, #0x230]
40004580: 390032df     	strb	wzr, [x22, #0xc]
40004584: 71003d1f     	cmp	w8, #0xf
40004588: fd0002c0     	str	d0, [x22]
4000458c: bd000ac1     	str	s1, [x22, #0x8]
40004590: b90022df     	str	wzr, [x22, #0x20]
40004594: f9021ad5     	str	x21, [x22, #0x430]
40004598: f90016df     	str	xzr, [x22, #0x28]
4000459c: 540000ac     	b.gt	0x400045b0 <vfs_init+0x420>
400045a0: 8b080ea9     	add	x9, x21, x8, lsl #3
400045a4: 11000508     	add	w8, w8, #0x1
400045a8: b904baa8     	str	w8, [x21, #0x4b8]
400045ac: f9021d36     	str	x22, [x9, #0x438]
400045b0: f0000017     	adrp	x23, 0x40007000 <__rodata_start+0x1000>
400045b4: 91030af7     	add	x23, x23, #0xc2
400045b8: 9100c2c0     	add	x0, x22, #0x30
400045bc: aa1703e1     	mov	x1, x23
400045c0: 97fff833     	bl	0x4000268c <kstrcpy>
400045c4: aa1703e0     	mov	x0, x23
400045c8: 97fff802     	bl	0x400025d0 <kstrlen>
400045cc: b98b7b28     	ldrsw	x8, [x25, #0xb78]
400045d0: f90016c0     	str	x0, [x22, #0x28]
400045d4: 7101fd1f     	cmp	w8, #0x7f
400045d8: 540008cc     	b.gt	0x400046f0 <vfs_init+0x560>
400045dc: 52809809     	mov	w9, #0x4c0              // =1216
400045e0: 2a1f03e1     	mov	w1, wzr
400045e4: 52809802     	mov	w2, #0x4c0              // =1216
400045e8: 9b294d16     	smaddl	x22, w8, w9, x19
400045ec: 11000508     	add	w8, w8, #0x1
400045f0: b90b7b28     	str	w8, [x25, #0xb78]
400045f4: aa1603e0     	mov	x0, x22
400045f8: 97fff860     	bl	0x40002778 <kmemset>
400045fc: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40004600: b904badf     	str	wzr, [x22, #0x4b8]
40004604: 528e8f09     	mov	w9, #0x7478             // =29816
40004608: fd412100     	ldr	d0, [x8, #0x240]
4000460c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004610: 39001adf     	strb	wzr, [x22, #0x6]
40004614: 79000ac9     	strh	w9, [x22, #0x4]
40004618: 71003d1f     	cmp	w8, #0xf
4000461c: bd0002c0     	str	s0, [x22]
40004620: b90022df     	str	wzr, [x22, #0x20]
40004624: f9021ad5     	str	x21, [x22, #0x430]
40004628: f90016df     	str	xzr, [x22, #0x28]
4000462c: 540000ac     	b.gt	0x40004640 <vfs_init+0x4b0>
40004630: 8b080ea9     	add	x9, x21, x8, lsl #3
40004634: 11000508     	add	w8, w8, #0x1
40004638: b904baa8     	str	w8, [x21, #0x4b8]
4000463c: f9021d36     	str	x22, [x9, #0x438]
40004640: f0000015     	adrp	x21, 0x40007000 <__rodata_start+0x1000>
40004644: 913a9eb5     	add	x21, x21, #0xea7
40004648: 9100c2c0     	add	x0, x22, #0x30
4000464c: aa1503e1     	mov	x1, x21
40004650: 97fff80f     	bl	0x4000268c <kstrcpy>
40004654: aa1503e0     	mov	x0, x21
40004658: 97fff7de     	bl	0x400025d0 <kstrlen>
4000465c: b98b7b28     	ldrsw	x8, [x25, #0xb78]
40004660: f90016c0     	str	x0, [x22, #0x28]
40004664: 7101fd1f     	cmp	w8, #0x7f
40004668: 5400044c     	b.gt	0x400046f0 <vfs_init+0x560>
4000466c: 52809809     	mov	w9, #0x4c0              // =1216
40004670: 2a1f03e1     	mov	w1, wzr
40004674: 52809802     	mov	w2, #0x4c0              // =1216
40004678: 9b294d13     	smaddl	x19, w8, w9, x19
4000467c: 11000508     	add	w8, w8, #0x1
40004680: b90b7b28     	str	w8, [x25, #0xb78]
40004684: aa1303e0     	mov	x0, x19
40004688: 97fff83c     	bl	0x40002778 <kmemset>
4000468c: 90000028     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
40004690: b904ba7f     	str	wzr, [x19, #0x4b8]
40004694: 528e8f09     	mov	w9, #0x7478             // =29816
40004698: fd412900     	ldr	d0, [x8, #0x250]
4000469c: b984ba88     	ldrsw	x8, [x20, #0x4b8]
400046a0: 39002a7f     	strb	wzr, [x19, #0xa]
400046a4: 79001269     	strh	w9, [x19, #0x8]
400046a8: 71003d1f     	cmp	w8, #0xf
400046ac: fd000260     	str	d0, [x19]
400046b0: b900227f     	str	wzr, [x19, #0x20]
400046b4: f9021a74     	str	x20, [x19, #0x430]
400046b8: f900167f     	str	xzr, [x19, #0x28]
400046bc: 540000ac     	b.gt	0x400046d0 <vfs_init+0x540>
400046c0: 8b080e89     	add	x9, x20, x8, lsl #3
400046c4: 11000508     	add	w8, w8, #0x1
400046c8: b904ba88     	str	w8, [x20, #0x4b8]
400046cc: f9021d33     	str	x19, [x9, #0x438]
400046d0: d0000014     	adrp	x20, 0x40006000 <__rodata_start>
400046d4: 910c2a94     	add	x20, x20, #0x30a
400046d8: 9100c260     	add	x0, x19, #0x30
400046dc: aa1403e1     	mov	x1, x20
400046e0: 97fff7eb     	bl	0x4000268c <kstrcpy>
400046e4: aa1403e0     	mov	x0, x20
400046e8: 97fff7ba     	bl	0x400025d0 <kstrlen>
400046ec: f9001660     	str	x0, [x19, #0x28]
400046f0: a9444ff4     	ldp	x20, x19, [sp, #0x40]
400046f4: f9400bf9     	ldr	x25, [sp, #0x10]
400046f8: a94357f6     	ldp	x22, x21, [sp, #0x30]
400046fc: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004700: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004704: d65f03c0     	ret

0000000040004708 <vfs_load_internal>:
40004708: 2a1f03e0     	mov	w0, wzr
4000470c: d65f03c0     	ret

0000000040004710 <vfs_get_root>:
40004710: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004714: f945c100     	ldr	x0, [x8, #0xb80]
40004718: d65f03c0     	ret

000000004000471c <vfs_get_cwd>:
4000471c: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004720: f945c500     	ldr	x0, [x8, #0xb88]
40004724: d65f03c0     	ret

0000000040004728 <vfs_getcwd>:
40004728: d10383ff     	sub	sp, sp, #0xe0
4000472c: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004730: a90d4ff4     	stp	x20, x19, [sp, #0xd0]
40004734: aa0003f3     	mov	x19, x0
40004738: f945c508     	ldr	x8, [x8, #0xb88]
4000473c: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004740: 910203fd     	add	x29, sp, #0x80
40004744: a9096ffc     	stp	x28, x27, [sp, #0x90]
40004748: a90a67fa     	stp	x26, x25, [sp, #0xa0]
4000474c: a90b5ff8     	stp	x24, x23, [sp, #0xb0]
40004750: a90c57f6     	stp	x22, x21, [sp, #0xc0]
40004754: b4000228     	cbz	x8, 0x40004798 <vfs_getcwd+0x70>
40004758: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
4000475c: f945c129     	ldr	x9, [x9, #0xb80]
40004760: eb09011f     	cmp	x8, x9
40004764: 540001a0     	b.eq	0x40004798 <vfs_getcwd+0x70>
40004768: aa1f03ea     	mov	x10, xzr
4000476c: 910003eb     	mov	x11, sp
40004770: eb09011f     	cmp	x8, x9
40004774: 540001c0     	b.eq	0x400047ac <vfs_getcwd+0x84>
40004778: f1003d5f     	cmp	x10, #0xf
4000477c: 54000188     	b.hi	0x400047ac <vfs_getcwd+0x84>
40004780: f82a7968     	str	x8, [x11, x10, lsl #3]
40004784: f9421908     	ldr	x8, [x8, #0x430]
40004788: 9100054c     	add	x12, x10, #0x1
4000478c: aa0c03ea     	mov	x10, x12
40004790: b5ffff08     	cbnz	x8, 0x40004770 <vfs_getcwd+0x48>
40004794: 14000007     	b	0x400047b0 <vfs_getcwd+0x88>
40004798: f100083f     	cmp	x1, #0x2
4000479c: 540008c3     	b.lo	0x400048b4 <vfs_getcwd+0x18c>
400047a0: 528005e8     	mov	w8, #0x2f               // =47
400047a4: 79000268     	strh	w8, [x19]
400047a8: 14000043     	b	0x400048b4 <vfs_getcwd+0x18c>
400047ac: aa0a03ec     	mov	x12, x10
400047b0: 7100059f     	cmp	w12, #0x1
400047b4: 3900027f     	strb	wzr, [x19]
400047b8: 540007eb     	b.lt	0x400048b4 <vfs_getcwd+0x18c>
400047bc: aa1f03fc     	mov	x28, xzr
400047c0: d1000435     	sub	x21, x1, #0x1
400047c4: 9240799a     	and	x26, x12, #0x7fffffff
400047c8: d1000836     	sub	x22, x1, #0x2
400047cc: 91004277     	add	x23, x19, #0x10
400047d0: 528005f8     	mov	w24, #0x2f              // =47
400047d4: 910003f9     	mov	x25, sp
400047d8: 14000006     	b	0x400047f0 <vfs_getcwd+0xc8>
400047dc: aa1c03e8     	mov	x8, x28
400047e0: f100077f     	cmp	x27, #0x1
400047e4: aa0803fc     	mov	x28, x8
400047e8: 38286a7f     	strb	wzr, [x19, x8]
400047ec: 54000649     	b.ls	0x400048b4 <vfs_getcwd+0x18c>
400047f0: eb15039f     	cmp	x28, x21
400047f4: aa1a03fb     	mov	x27, x26
400047f8: 54000082     	b.hs	0x40004808 <vfs_getcwd+0xe0>
400047fc: 91000788     	add	x8, x28, #0x1
40004800: 783c6a78     	strh	w24, [x19, x28]
40004804: aa0803fc     	mov	x28, x8
40004808: d100077a     	sub	x26, x27, #0x1
4000480c: f87a7b34     	ldr	x20, [x25, x26, lsl #3]
40004810: aa1403e0     	mov	x0, x20
40004814: 97fff76f     	bl	0x400025d0 <kstrlen>
40004818: b4fffe20     	cbz	x0, 0x400047dc <vfs_getcwd+0xb4>
4000481c: eb15039f     	cmp	x28, x21
40004820: 54fffde2     	b.hs	0x400047dc <vfs_getcwd+0xb4>
40004824: cb1c02c8     	sub	x8, x22, x28
40004828: d1000409     	sub	x9, x0, #0x1
4000482c: eb09011f     	cmp	x8, x9
40004830: 9a893108     	csel	x8, x8, x9, lo
40004834: 9100050a     	add	x10, x8, #0x1
40004838: f100815f     	cmp	x10, #0x20
4000483c: 540000a3     	b.lo	0x40004850 <vfs_getcwd+0x128>
40004840: 8b130388     	add	x8, x28, x19
40004844: cb140108     	sub	x8, x8, x20
40004848: f100811f     	cmp	x8, #0x20
4000484c: 54000182     	b.hs	0x4000487c <vfs_getcwd+0x154>
40004850: aa1f03e9     	mov	x9, xzr
40004854: aa1c03e8     	mov	x8, x28
40004858: 38696a8a     	ldrb	w10, [x20, x9]
4000485c: 91000529     	add	x9, x9, #0x1
40004860: eb00013f     	cmp	x9, x0
40004864: 38286a6a     	strb	w10, [x19, x8]
40004868: 91000508     	add	x8, x8, #0x1
4000486c: 54fffba2     	b.hs	0x400047e0 <vfs_getcwd+0xb8>
40004870: eb15011f     	cmp	x8, x21
40004874: 54ffff23     	b.lo	0x40004858 <vfs_getcwd+0x130>
40004878: 17ffffda     	b	0x400047e0 <vfs_getcwd+0xb8>
4000487c: 927be949     	and	x9, x10, #0xffffffffffffffe0
40004880: 8b1c02eb     	add	x11, x23, x28
40004884: 9100428c     	add	x12, x20, #0x10
40004888: 8b090388     	add	x8, x28, x9
4000488c: aa0903ed     	mov	x13, x9
40004890: ad7f8580     	ldp	q0, q1, [x12, #-0x10]
40004894: f10081ad     	subs	x13, x13, #0x20
40004898: 9100818c     	add	x12, x12, #0x20
4000489c: ad3f8560     	stp	q0, q1, [x11, #-0x10]
400048a0: 9100816b     	add	x11, x11, #0x20
400048a4: 54ffff61     	b.ne	0x40004890 <vfs_getcwd+0x168>
400048a8: eb09015f     	cmp	x10, x9
400048ac: 54fffd61     	b.ne	0x40004858 <vfs_getcwd+0x130>
400048b0: 17ffffcc     	b	0x400047e0 <vfs_getcwd+0xb8>
400048b4: a94d4ff4     	ldp	x20, x19, [sp, #0xd0]
400048b8: a94c57f6     	ldp	x22, x21, [sp, #0xc0]
400048bc: a94b5ff8     	ldp	x24, x23, [sp, #0xb0]
400048c0: a94a67fa     	ldp	x26, x25, [sp, #0xa0]
400048c4: a9496ffc     	ldp	x28, x27, [sp, #0x90]
400048c8: a9487bfd     	ldp	x29, x30, [sp, #0x80]
400048cc: 910383ff     	add	sp, sp, #0xe0
400048d0: d65f03c0     	ret

00000000400048d4 <vfs_find>:
400048d4: d10203ff     	sub	sp, sp, #0x80
400048d8: a9027bfd     	stp	x29, x30, [sp, #0x20]
400048dc: 910083fd     	add	x29, sp, #0x20
400048e0: a9036ffc     	stp	x28, x27, [sp, #0x30]
400048e4: a90467fa     	stp	x26, x25, [sp, #0x40]
400048e8: a9055ff8     	stp	x24, x23, [sp, #0x50]
400048ec: a90657f6     	stp	x22, x21, [sp, #0x60]
400048f0: a9074ff4     	stp	x20, x19, [sp, #0x70]
400048f4: b4000a60     	cbz	x0, 0x40004a40 <vfs_find+0x16c>
400048f8: 39400008     	ldrb	w8, [x0]
400048fc: aa0003f4     	mov	x20, x0
40004900: 34000a08     	cbz	w8, 0x40004a40 <vfs_find+0x16c>
40004904: 7100bd1f     	cmp	w8, #0x2f
40004908: 54000121     	b.ne	0x4000492c <vfs_find+0x58>
4000490c: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004910: 52800037     	mov	w23, #0x1               // =1
40004914: f945c113     	ldr	x19, [x8, #0xb80]
40004918: 38776a88     	ldrb	w8, [x20, x23]
4000491c: 7100bd1f     	cmp	w8, #0x2f
40004920: 540000e1     	b.ne	0x4000493c <vfs_find+0x68>
40004924: 910006f7     	add	x23, x23, #0x1
40004928: 17fffffc     	b	0x40004918 <vfs_find+0x44>
4000492c: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004930: aa1f03f7     	mov	x23, xzr
40004934: f945c533     	ldr	x19, [x9, #0xb88]
40004938: 14000002     	b	0x40004940 <vfs_find+0x6c>
4000493c: 34000848     	cbz	w8, 0x40004a44 <vfs_find+0x170>
40004940: 91000698     	add	x24, x20, #0x1
40004944: d0000015     	adrp	x21, 0x40006000 <__rodata_start>
40004948: 91224eb5     	add	x21, x21, #0x893
4000494c: 910003f9     	mov	x25, sp
40004950: d0000016     	adrp	x22, 0x40006000 <__rodata_start>
40004954: 913b7ed6     	add	x22, x22, #0xedf
40004958: 14000006     	b	0x40004970 <vfs_find+0x9c>
4000495c: f9421a68     	ldr	x8, [x19, #0x430]
40004960: f100011f     	cmp	x8, #0x0
40004964: 9a880273     	csel	x19, x19, x8, eq
40004968: 385ff348     	ldurb	w8, [x26, #-0x1]
4000496c: 340006c8     	cbz	w8, 0x40004a44 <vfs_find+0x170>
40004970: 7100bd1f     	cmp	w8, #0x2f
40004974: 54000061     	b.ne	0x40004980 <vfs_find+0xac>
40004978: aa1f03e9     	mov	x9, xzr
4000497c: 14000010     	b	0x400049bc <vfs_find+0xe8>
40004980: aa1f03e9     	mov	x9, xzr
40004984: 8b17030a     	add	x10, x24, x23
40004988: 34000188     	cbz	w8, 0x400049b8 <vfs_find+0xe4>
4000498c: f100793f     	cmp	x9, #0x1e
40004990: 54000148     	b.hi	0x400049b8 <vfs_find+0xe4>
40004994: 38296b28     	strb	w8, [x25, x9]
40004998: 38696948     	ldrb	w8, [x10, x9]
4000499c: 9100052b     	add	x11, x9, #0x1
400049a0: aa0b03e9     	mov	x9, x11
400049a4: 7100bd1f     	cmp	w8, #0x2f
400049a8: 54ffff01     	b.ne	0x40004988 <vfs_find+0xb4>
400049ac: 8b0b02f7     	add	x23, x23, x11
400049b0: aa0b03e9     	mov	x9, x11
400049b4: 14000002     	b	0x400049bc <vfs_find+0xe8>
400049b8: 8b0902f7     	add	x23, x23, x9
400049bc: 8b17029a     	add	x26, x20, x23
400049c0: d10006f7     	sub	x23, x23, #0x1
400049c4: 38296b3f     	strb	wzr, [x25, x9]
400049c8: 38401748     	ldrb	w8, [x26], #0x1
400049cc: 910006f7     	add	x23, x23, #0x1
400049d0: 7100bd1f     	cmp	w8, #0x2f
400049d4: 54ffffa0     	b.eq	0x400049c8 <vfs_find+0xf4>
400049d8: 910003e0     	mov	x0, sp
400049dc: aa1503e1     	mov	x1, x21
400049e0: 97fff70c     	bl	0x40002610 <kstrcmp>
400049e4: 34fffc20     	cbz	w0, 0x40004968 <vfs_find+0x94>
400049e8: 910003e0     	mov	x0, sp
400049ec: aa1603e1     	mov	x1, x22
400049f0: 97fff708     	bl	0x40002610 <kstrcmp>
400049f4: 34fffb40     	cbz	w0, 0x4000495c <vfs_find+0x88>
400049f8: b944ba68     	ldr	w8, [x19, #0x4b8]
400049fc: 7100051f     	cmp	w8, #0x1
40004a00: 5400020b     	b.lt	0x40004a40 <vfs_find+0x16c>
40004a04: aa1f03fb     	mov	x27, xzr
40004a08: 9110e27c     	add	x28, x19, #0x438
40004a0c: 14000005     	b	0x40004a20 <vfs_find+0x14c>
40004a10: b944ba68     	ldr	w8, [x19, #0x4b8]
40004a14: 9100077b     	add	x27, x27, #0x1
40004a18: eb28c37f     	cmp	x27, w8, sxtw
40004a1c: 5400012a     	b.ge	0x40004a40 <vfs_find+0x16c>
40004a20: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004a24: b4ffff80     	cbz	x0, 0x40004a14 <vfs_find+0x140>
40004a28: 910003e1     	mov	x1, sp
40004a2c: 97fff6f9     	bl	0x40002610 <kstrcmp>
40004a30: 35ffff00     	cbnz	w0, 0x40004a10 <vfs_find+0x13c>
40004a34: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004a38: b5fff993     	cbnz	x19, 0x40004968 <vfs_find+0x94>
40004a3c: 14000002     	b	0x40004a44 <vfs_find+0x170>
40004a40: aa1f03f3     	mov	x19, xzr
40004a44: aa1303e0     	mov	x0, x19
40004a48: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004a4c: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004a50: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004a54: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004a58: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004a5c: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004a60: 910203ff     	add	sp, sp, #0x80
40004a64: d65f03c0     	ret

0000000040004a68 <vfs_chdir>:
40004a68: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004a6c: f9000bf3     	str	x19, [sp, #0x10]
40004a70: 910003fd     	mov	x29, sp
40004a74: b4000200     	cbz	x0, 0x40004ab4 <vfs_chdir+0x4c>
40004a78: 39400008     	ldrb	w8, [x0]
40004a7c: 340001c8     	cbz	w8, 0x40004ab4 <vfs_chdir+0x4c>
40004a80: f0000001     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40004a84: 9138d821     	add	x1, x1, #0xe36
40004a88: aa0003f3     	mov	x19, x0
40004a8c: 97fff6e1     	bl	0x40002610 <kstrcmp>
40004a90: 34000120     	cbz	w0, 0x40004ab4 <vfs_chdir+0x4c>
40004a94: aa1303e0     	mov	x0, x19
40004a98: 97ffff8f     	bl	0x400048d4 <vfs_find>
40004a9c: b40002c0     	cbz	x0, 0x40004af4 <vfs_chdir+0x8c>
40004aa0: b9402008     	ldr	w8, [x0, #0x20]
40004aa4: 7100051f     	cmp	w8, #0x1
40004aa8: 54000180     	b.eq	0x40004ad8 <vfs_chdir+0x70>
40004aac: 12800028     	mov	w8, #-0x2               // =-2
40004ab0: 1400000d     	b	0x40004ae4 <vfs_chdir+0x7c>
40004ab4: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004ab8: 91379c00     	add	x0, x0, #0xde7
40004abc: 97ffff86     	bl	0x400048d4 <vfs_find>
40004ac0: b4000080     	cbz	x0, 0x40004ad0 <vfs_chdir+0x68>
40004ac4: b9402008     	ldr	w8, [x0, #0x20]
40004ac8: 7100051f     	cmp	w8, #0x1
40004acc: 54000060     	b.eq	0x40004ad8 <vfs_chdir+0x70>
40004ad0: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004ad4: f945c100     	ldr	x0, [x8, #0xb80]
40004ad8: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004adc: 2a1f03e8     	mov	w8, wzr
40004ae0: f905c520     	str	x0, [x9, #0xb88]
40004ae4: f9400bf3     	ldr	x19, [sp, #0x10]
40004ae8: 2a0803e0     	mov	w0, w8
40004aec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004af0: d65f03c0     	ret
40004af4: 12800008     	mov	w8, #-0x1               // =-1
40004af8: 17fffffb     	b	0x40004ae4 <vfs_chdir+0x7c>

0000000040004afc <vfs_mkdir>:
40004afc: b40001e0     	cbz	x0, 0x40004b38 <vfs_mkdir+0x3c>
40004b00: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004b04: 39400008     	ldrb	w8, [x0]
40004b08: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004b0c: aa0003f3     	mov	x19, x0
40004b10: a90157f6     	stp	x22, x21, [sp, #0x10]
40004b14: 910003fd     	mov	x29, sp
40004b18: 34000148     	cbz	w8, 0x40004b40 <vfs_mkdir+0x44>
40004b1c: d0000074     	adrp	x20, 0x40012000 <kernel_capture_buffer+0x3488>
40004b20: f945c695     	ldr	x21, [x20, #0xb88]
40004b24: b944baa8     	ldr	w8, [x21, #0x4b8]
40004b28: 71003d1f     	cmp	w8, #0xf
40004b2c: 540000ed     	b.le	0x40004b48 <vfs_mkdir+0x4c>
40004b30: 12800020     	mov	w0, #-0x2               // =-2
40004b34: 14000043     	b	0x40004c40 <vfs_mkdir+0x144>
40004b38: 12800000     	mov	w0, #-0x1               // =-1
40004b3c: d65f03c0     	ret
40004b40: 12800000     	mov	w0, #-0x1               // =-1
40004b44: 1400003f     	b	0x40004c40 <vfs_mkdir+0x144>
40004b48: 7100051f     	cmp	w8, #0x1
40004b4c: 540001eb     	b.lt	0x40004b88 <vfs_mkdir+0x8c>
40004b50: aa1f03f6     	mov	x22, xzr
40004b54: 14000005     	b	0x40004b68 <vfs_mkdir+0x6c>
40004b58: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004b5c: 910006d6     	add	x22, x22, #0x1
40004b60: eb0802df     	cmp	x22, x8
40004b64: 5400012a     	b.ge	0x40004b88 <vfs_mkdir+0x8c>
40004b68: 8b160ea8     	add	x8, x21, x22, lsl #3
40004b6c: f9421d00     	ldr	x0, [x8, #0x438]
40004b70: b4ffff40     	cbz	x0, 0x40004b58 <vfs_mkdir+0x5c>
40004b74: aa1303e1     	mov	x1, x19
40004b78: 97fff6a6     	bl	0x40002610 <kstrcmp>
40004b7c: 340003e0     	cbz	w0, 0x40004bf8 <vfs_mkdir+0xfc>
40004b80: f945c695     	ldr	x21, [x20, #0xb88]
40004b84: 17fffff5     	b	0x40004b58 <vfs_mkdir+0x5c>
40004b88: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004b8c: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004b90: 7101fd3f     	cmp	w9, #0x7f
40004b94: 5400006d     	b.le	0x40004ba0 <vfs_mkdir+0xa4>
40004b98: 12800060     	mov	w0, #-0x4               // =-4
40004b9c: 14000029     	b	0x40004c40 <vfs_mkdir+0x144>
40004ba0: 5280980a     	mov	w10, #0x4c0             // =1216
40004ba4: d000006b     	adrp	x11, 0x40012000 <kernel_capture_buffer+0x3488>
40004ba8: 912e416b     	add	x11, x11, #0xb90
40004bac: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004bb0: 11000529     	add	w9, w9, #0x1
40004bb4: 2a1f03e1     	mov	w1, wzr
40004bb8: 52809802     	mov	w2, #0x4c0              // =1216
40004bbc: b90b7909     	str	w9, [x8, #0xb78]
40004bc0: aa1403e0     	mov	x0, x20
40004bc4: 97fff6ed     	bl	0x40002778 <kmemset>
40004bc8: 39400268     	ldrb	w8, [x19]
40004bcc: 340001a8     	cbz	w8, 0x40004c00 <vfs_mkdir+0x104>
40004bd0: aa1f03ea     	mov	x10, xzr
40004bd4: 91000669     	add	x9, x19, #0x1
40004bd8: 382a6a88     	strb	w8, [x20, x10]
40004bdc: 9100054b     	add	x11, x10, #0x1
40004be0: 386a6928     	ldrb	w8, [x9, x10]
40004be4: 34000108     	cbz	w8, 0x40004c04 <vfs_mkdir+0x108>
40004be8: f100795f     	cmp	x10, #0x1e
40004bec: aa0b03ea     	mov	x10, x11
40004bf0: 54ffff43     	b.lo	0x40004bd8 <vfs_mkdir+0xdc>
40004bf4: 14000004     	b	0x40004c04 <vfs_mkdir+0x108>
40004bf8: 12800040     	mov	w0, #-0x3               // =-3
40004bfc: 14000011     	b	0x40004c40 <vfs_mkdir+0x144>
40004c00: aa1f03eb     	mov	x11, xzr
40004c04: 382b6a9f     	strb	wzr, [x20, x11]
40004c08: 2a1f03e0     	mov	w0, wzr
40004c0c: 52800029     	mov	w9, #0x1                // =1
40004c10: b904ba9f     	str	wzr, [x20, #0x4b8]
40004c14: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004c18: b9002289     	str	w9, [x20, #0x20]
40004c1c: f9021a95     	str	x21, [x20, #0x430]
40004c20: 71003d1f     	cmp	w8, #0xf
40004c24: f900169f     	str	xzr, [x20, #0x28]
40004c28: 540000cc     	b.gt	0x40004c40 <vfs_mkdir+0x144>
40004c2c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004c30: 2a1f03e0     	mov	w0, wzr
40004c34: 11000508     	add	w8, w8, #0x1
40004c38: b904baa8     	str	w8, [x21, #0x4b8]
40004c3c: f9021d34     	str	x20, [x9, #0x438]
40004c40: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004c44: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004c48: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004c4c: d65f03c0     	ret

0000000040004c50 <vfs_sync>:
40004c50: d65f03c0     	ret

0000000040004c54 <vfs_touch>:
40004c54: b4000500     	cbz	x0, 0x40004cf4 <vfs_touch+0xa0>
40004c58: 39400008     	ldrb	w8, [x0]
40004c5c: 340004c8     	cbz	w8, 0x40004cf4 <vfs_touch+0xa0>
40004c60: d10583ff     	sub	sp, sp, #0x160
40004c64: d0000069     	adrp	x9, 0x40012000 <kernel_capture_buffer+0x3488>
40004c68: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004c6c: aa1f03f4     	mov	x20, xzr
40004c70: f945c533     	ldr	x19, [x9, #0xb88]
40004c74: aa0003e9     	mov	x9, x0
40004c78: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004c7c: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004c80: 910483fd     	add	x29, sp, #0x120
40004c84: a91457f6     	stp	x22, x21, [sp, #0x140]
40004c88: 14000003     	b	0x40004c94 <vfs_touch+0x40>
40004c8c: aa0903f4     	mov	x20, x9
40004c90: 38401d28     	ldrb	w8, [x9, #0x1]!
40004c94: 7100bd1f     	cmp	w8, #0x2f
40004c98: 54ffffa0     	b.eq	0x40004c8c <vfs_touch+0x38>
40004c9c: 35ffffa8     	cbnz	w8, 0x40004c90 <vfs_touch+0x3c>
40004ca0: b4000334     	cbz	x20, 0x40004d04 <vfs_touch+0xb0>
40004ca4: cb000288     	sub	x8, x20, x0
40004ca8: 52801fe9     	mov	w9, #0xff               // =255
40004cac: aa0103f5     	mov	x21, x1
40004cb0: f103fd1f     	cmp	x8, #0xff
40004cb4: aa0003e1     	mov	x1, x0
40004cb8: 910083e0     	add	x0, sp, #0x20
40004cbc: 9a893113     	csel	x19, x8, x9, lo
40004cc0: 910083f6     	add	x22, sp, #0x20
40004cc4: aa1303e2     	mov	x2, x19
40004cc8: 97fff678     	bl	0x400026a8 <kstrncpy>
40004ccc: 910083e0     	add	x0, sp, #0x20
40004cd0: 38336adf     	strb	wzr, [x22, x19]
40004cd4: 97ffff00     	bl	0x400048d4 <vfs_find>
40004cd8: b4000120     	cbz	x0, 0x40004cfc <vfs_touch+0xa8>
40004cdc: b9402008     	ldr	w8, [x0, #0x20]
40004ce0: aa0003f3     	mov	x19, x0
40004ce4: 7100051f     	cmp	w8, #0x1
40004ce8: 540000a1     	b.ne	0x40004cfc <vfs_touch+0xa8>
40004cec: 91000688     	add	x8, x20, #0x1
40004cf0: 14000007     	b	0x40004d0c <vfs_touch+0xb8>
40004cf4: 12800000     	mov	w0, #-0x1               // =-1
40004cf8: d65f03c0     	ret
40004cfc: 12800000     	mov	w0, #-0x1               // =-1
40004d00: 1400006a     	b	0x40004ea8 <vfs_touch+0x254>
40004d04: aa0003e8     	mov	x8, x0
40004d08: aa0103f5     	mov	x21, x1
40004d0c: 910003e0     	mov	x0, sp
40004d10: aa0803e1     	mov	x1, x8
40004d14: 528003e2     	mov	w2, #0x1f               // =31
40004d18: 97fff664     	bl	0x400026a8 <kstrncpy>
40004d1c: b944ba68     	ldr	w8, [x19, #0x4b8]
40004d20: 39007fff     	strb	wzr, [sp, #0x1f]
40004d24: 7100051f     	cmp	w8, #0x1
40004d28: 5400024b     	b.lt	0x40004d70 <vfs_touch+0x11c>
40004d2c: aa1f03f6     	mov	x22, xzr
40004d30: 9110e277     	add	x23, x19, #0x438
40004d34: 14000004     	b	0x40004d44 <vfs_touch+0xf0>
40004d38: 910006d6     	add	x22, x22, #0x1
40004d3c: eb28c2df     	cmp	x22, w8, sxtw
40004d40: 5400010a     	b.ge	0x40004d60 <vfs_touch+0x10c>
40004d44: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40004d48: b4ffff80     	cbz	x0, 0x40004d38 <vfs_touch+0xe4>
40004d4c: 910003e1     	mov	x1, sp
40004d50: 97fff630     	bl	0x40002610 <kstrcmp>
40004d54: 340004a0     	cbz	w0, 0x40004de8 <vfs_touch+0x194>
40004d58: b944ba68     	ldr	w8, [x19, #0x4b8]
40004d5c: 17fffff7     	b	0x40004d38 <vfs_touch+0xe4>
40004d60: 71003d1f     	cmp	w8, #0xf
40004d64: 5400006d     	b.le	0x40004d70 <vfs_touch+0x11c>
40004d68: 12800020     	mov	w0, #-0x2               // =-2
40004d6c: 1400004f     	b	0x40004ea8 <vfs_touch+0x254>
40004d70: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004d74: b98b7909     	ldrsw	x9, [x8, #0xb78]
40004d78: 7101fd3f     	cmp	w9, #0x7f
40004d7c: 5400006d     	b.le	0x40004d88 <vfs_touch+0x134>
40004d80: 12800060     	mov	w0, #-0x4               // =-4
40004d84: 14000049     	b	0x40004ea8 <vfs_touch+0x254>
40004d88: 5280980a     	mov	w10, #0x4c0             // =1216
40004d8c: d000006b     	adrp	x11, 0x40012000 <kernel_capture_buffer+0x3488>
40004d90: 912e416b     	add	x11, x11, #0xb90
40004d94: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004d98: 11000529     	add	w9, w9, #0x1
40004d9c: 2a1f03e1     	mov	w1, wzr
40004da0: 52809802     	mov	w2, #0x4c0              // =1216
40004da4: b90b7909     	str	w9, [x8, #0xb78]
40004da8: aa1403e0     	mov	x0, x20
40004dac: 97fff673     	bl	0x40002778 <kmemset>
40004db0: 394003e8     	ldrb	w8, [sp]
40004db4: 340003e8     	cbz	w8, 0x40004e30 <vfs_touch+0x1dc>
40004db8: 910003ea     	mov	x10, sp
40004dbc: aa1f03e9     	mov	x9, xzr
40004dc0: aa1503e0     	mov	x0, x21
40004dc4: b240014a     	orr	x10, x10, #0x1
40004dc8: 38296a88     	strb	w8, [x20, x9]
40004dcc: 38696948     	ldrb	w8, [x10, x9]
40004dd0: 9100052b     	add	x11, x9, #0x1
40004dd4: 34000328     	cbz	w8, 0x40004e38 <vfs_touch+0x1e4>
40004dd8: f100793f     	cmp	x9, #0x1e
40004ddc: aa0b03e9     	mov	x9, x11
40004de0: 54ffff43     	b.lo	0x40004dc8 <vfs_touch+0x174>
40004de4: 14000015     	b	0x40004e38 <vfs_touch+0x1e4>
40004de8: b40005f5     	cbz	x21, 0x40004ea4 <vfs_touch+0x250>
40004dec: aa1503e0     	mov	x0, x21
40004df0: 97fff5f8     	bl	0x400025d0 <kstrlen>
40004df4: 52807fe8     	mov	w8, #0x3ff              // =1023
40004df8: f10ffc1f     	cmp	x0, #0x3ff
40004dfc: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40004e00: 9a883014     	csel	x20, x0, x8, lo
40004e04: aa1503e1     	mov	x1, x21
40004e08: 9100c120     	add	x0, x9, #0x30
40004e0c: aa1403e2     	mov	x2, x20
40004e10: 97fff683     	bl	0x4000281c <kmemcpy>
40004e14: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004e18: 2a1f03e0     	mov	w0, wzr
40004e1c: 8b140108     	add	x8, x8, x20
40004e20: 3900c11f     	strb	wzr, [x8, #0x30]
40004e24: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40004e28: f9001514     	str	x20, [x8, #0x28]
40004e2c: 1400001f     	b	0x40004ea8 <vfs_touch+0x254>
40004e30: aa1f03eb     	mov	x11, xzr
40004e34: aa1503e0     	mov	x0, x21
40004e38: 382b6a9f     	strb	wzr, [x20, x11]
40004e3c: b904ba9f     	str	wzr, [x20, #0x4b8]
40004e40: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004e44: b900229f     	str	wzr, [x20, #0x20]
40004e48: f9021a93     	str	x19, [x20, #0x430]
40004e4c: 71003d1f     	cmp	w8, #0xf
40004e50: f900169f     	str	xzr, [x20, #0x28]
40004e54: 540000ac     	b.gt	0x40004e68 <vfs_touch+0x214>
40004e58: 8b080e69     	add	x9, x19, x8, lsl #3
40004e5c: 11000508     	add	w8, w8, #0x1
40004e60: b904ba68     	str	w8, [x19, #0x4b8]
40004e64: f9021d34     	str	x20, [x9, #0x438]
40004e68: b4000200     	cbz	x0, 0x40004ea8 <vfs_touch+0x254>
40004e6c: aa0003f3     	mov	x19, x0
40004e70: 97fff5d8     	bl	0x400025d0 <kstrlen>
40004e74: 52807fe8     	mov	w8, #0x3ff              // =1023
40004e78: f10ffc1f     	cmp	x0, #0x3ff
40004e7c: 9100c296     	add	x22, x20, #0x30
40004e80: 9a883015     	csel	x21, x0, x8, lo
40004e84: aa1603e0     	mov	x0, x22
40004e88: aa1303e1     	mov	x1, x19
40004e8c: aa1503e2     	mov	x2, x21
40004e90: 97fff663     	bl	0x4000281c <kmemcpy>
40004e94: 2a1f03e0     	mov	w0, wzr
40004e98: 38356adf     	strb	wzr, [x22, x21]
40004e9c: f9001695     	str	x21, [x20, #0x28]
40004ea0: 14000002     	b	0x40004ea8 <vfs_touch+0x254>
40004ea4: 2a1f03e0     	mov	w0, wzr
40004ea8: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40004eac: a95457f6     	ldp	x22, x21, [sp, #0x140]
40004eb0: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40004eb4: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40004eb8: 910583ff     	add	sp, sp, #0x160
40004ebc: d65f03c0     	ret

0000000040004ec0 <vfs_write_file>:
40004ec0: 17ffff65     	b	0x40004c54 <vfs_touch>

0000000040004ec4 <vfs_remove>:
40004ec4: b40005c0     	cbz	x0, 0x40004f7c <vfs_remove+0xb8>
40004ec8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004ecc: 39400008     	ldrb	w8, [x0]
40004ed0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004ed4: aa0003f3     	mov	x19, x0
40004ed8: f9000bf5     	str	x21, [sp, #0x10]
40004edc: 910003fd     	mov	x29, sp
40004ee0: 34000448     	cbz	w8, 0x40004f68 <vfs_remove+0xa4>
40004ee4: d0000074     	adrp	x20, 0x40012000 <kernel_capture_buffer+0x3488>
40004ee8: f945c688     	ldr	x8, [x20, #0xb88]
40004eec: b944b909     	ldr	w9, [x8, #0x4b8]
40004ef0: 7100053f     	cmp	w9, #0x1
40004ef4: 540003ab     	b.lt	0x40004f68 <vfs_remove+0xa4>
40004ef8: aa1f03f5     	mov	x21, xzr
40004efc: 14000005     	b	0x40004f10 <vfs_remove+0x4c>
40004f00: b984b909     	ldrsw	x9, [x8, #0x4b8]
40004f04: 910006b5     	add	x21, x21, #0x1
40004f08: eb0902bf     	cmp	x21, x9
40004f0c: 540002ea     	b.ge	0x40004f68 <vfs_remove+0xa4>
40004f10: 8b150d09     	add	x9, x8, x21, lsl #3
40004f14: f9421d20     	ldr	x0, [x9, #0x438]
40004f18: b4ffff40     	cbz	x0, 0x40004f00 <vfs_remove+0x3c>
40004f1c: aa1303e1     	mov	x1, x19
40004f20: 97fff5bc     	bl	0x40002610 <kstrcmp>
40004f24: f945c688     	ldr	x8, [x20, #0xb88]
40004f28: 35fffec0     	cbnz	w0, 0x40004f00 <vfs_remove+0x3c>
40004f2c: b984b909     	ldrsw	x9, [x8, #0x4b8]
40004f30: d1000529     	sub	x9, x9, #0x1
40004f34: 6b15013f     	cmp	w9, w21
40004f38: 5400026d     	b.le	0x40004f84 <vfs_remove+0xc0>
40004f3c: f945c68a     	ldr	x10, [x20, #0xb88]
40004f40: b984b949     	ldrsw	x9, [x10, #0x4b8]
40004f44: d1000529     	sub	x9, x9, #0x1
40004f48: 8b150d08     	add	x8, x8, x21, lsl #3
40004f4c: 910006b5     	add	x21, x21, #0x1
40004f50: eb0902bf     	cmp	x21, x9
40004f54: f942210b     	ldr	x11, [x8, #0x440]
40004f58: f9021d0b     	str	x11, [x8, #0x438]
40004f5c: aa0a03e8     	mov	x8, x10
40004f60: 54ffff4b     	b.lt	0x40004f48 <vfs_remove+0x84>
40004f64: 14000009     	b	0x40004f88 <vfs_remove+0xc4>
40004f68: 12800000     	mov	w0, #-0x1               // =-1
40004f6c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004f70: f9400bf5     	ldr	x21, [sp, #0x10]
40004f74: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004f78: d65f03c0     	ret
40004f7c: 12800000     	mov	w0, #-0x1               // =-1
40004f80: d65f03c0     	ret
40004f84: aa0803ea     	mov	x10, x8
40004f88: 8b090d48     	add	x8, x10, x9, lsl #3
40004f8c: 2a1f03e0     	mov	w0, wzr
40004f90: f9021d1f     	str	xzr, [x8, #0x438]
40004f94: f945c688     	ldr	x8, [x20, #0xb88]
40004f98: b944b909     	ldr	w9, [x8, #0x4b8]
40004f9c: 51000529     	sub	w9, w9, #0x1
40004fa0: b904b909     	str	w9, [x8, #0x4b8]
40004fa4: 17fffff2     	b	0x40004f6c <vfs_remove+0xa8>

0000000040004fa8 <vfs_list_dir>:
40004fa8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40004fac: d0000068     	adrp	x8, 0x40012000 <kernel_capture_buffer+0x3488>
40004fb0: f100001f     	cmp	x0, #0x0
40004fb4: a90257f6     	stp	x22, x21, [sp, #0x20]
40004fb8: f945c508     	ldr	x8, [x8, #0xb88]
40004fbc: f9000bf7     	str	x23, [sp, #0x10]
40004fc0: 910003fd     	mov	x29, sp
40004fc4: a9034ff4     	stp	x20, x19, [sp, #0x30]
40004fc8: 9a800115     	csel	x21, x8, x0, eq
40004fcc: b94022a8     	ldr	w8, [x21, #0x20]
40004fd0: 7100051f     	cmp	w8, #0x1
40004fd4: 54000521     	b.ne	0x40005078 <vfs_list_dir+0xd0>
40004fd8: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004fdc: 91323000     	add	x0, x0, #0xc8c
40004fe0: 97fff951     	bl	0x40003524 <uart_puts>
40004fe4: d0000000     	adrp	x0, 0x40006000 <__rodata_start>
40004fe8: 911d0c00     	add	x0, x0, #0x743
40004fec: 97fff94e     	bl	0x40003524 <uart_puts>
40004ff0: f0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40004ff4: 9128f400     	add	x0, x0, #0xa3d
40004ff8: 97fff94b     	bl	0x40003524 <uart_puts>
40004ffc: f9421aa8     	ldr	x8, [x21, #0x430]
40005000: b4000088     	cbz	x8, 0x40005010 <vfs_list_dir+0x68>
40005004: d0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40005008: 91048000     	add	x0, x0, #0x120
4000500c: 97fff946     	bl	0x40003524 <uart_puts>
40005010: b944baa1     	ldr	w1, [x21, #0x4b8]
40005014: 7100043f     	cmp	w1, #0x1
40005018: 5400034b     	b.lt	0x40005080 <vfs_list_dir+0xd8>
4000501c: aa1f03f6     	mov	x22, xzr
40005020: d0000013     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
40005024: 911fae73     	add	x19, x19, #0x7eb
40005028: 9110e2b7     	add	x23, x21, #0x438
4000502c: d0000014     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40005030: 91101a94     	add	x20, x20, #0x406
40005034: 14000008     	b	0x40005054 <vfs_list_dir+0xac>
40005038: b9402841     	ldr	w1, [x2, #0x28]
4000503c: aa1403e0     	mov	x0, x20
40005040: 97fffa49     	bl	0x40003964 <uart_printf>
40005044: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40005048: 910006d6     	add	x22, x22, #0x1
4000504c: eb0102df     	cmp	x22, x1
40005050: 5400018a     	b.ge	0x40005080 <vfs_list_dir+0xd8>
40005054: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005058: b4ffff62     	cbz	x2, 0x40005044 <vfs_list_dir+0x9c>
4000505c: b9402048     	ldr	w8, [x2, #0x20]
40005060: 7100051f     	cmp	w8, #0x1
40005064: 54fffea1     	b.ne	0x40005038 <vfs_list_dir+0x90>
40005068: aa1303e0     	mov	x0, x19
4000506c: aa0203e1     	mov	x1, x2
40005070: 97fffa3d     	bl	0x40003964 <uart_printf>
40005074: 17fffff4     	b	0x40005044 <vfs_list_dir+0x9c>
40005078: 12800000     	mov	w0, #-0x1               // =-1
4000507c: 14000005     	b	0x40005090 <vfs_list_dir+0xe8>
40005080: b0000000     	adrp	x0, 0x40006000 <__rodata_start>
40005084: 91225400     	add	x0, x0, #0x895
40005088: 97fffa37     	bl	0x40003964 <uart_printf>
4000508c: 2a1f03e0     	mov	w0, wzr
40005090: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005094: f9400bf7     	ldr	x23, [sp, #0x10]
40005098: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000509c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400050a0: d65f03c0     	ret

00000000400050a4 <vfs_load>:
400050a4: d65f03c0     	ret
