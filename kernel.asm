
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
40000034: 94000709     	bl	0x40001c58 <kmain>

0000000040000038 <halt>:
40000038: d503207f     	wfi
4000003c: 17ffffff     	b	0x40000038 <halt>
40000040: a0 9b 04 40  	.word	0x40049ba0
40000044: 00 00 00 00  	.word	0x00000000
40000048: 00 b0 00 40  	.word	0x4000b000
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 98 9b 03 40  	.word	0x40039b98
40000054: 00 00 00 00  	.word	0x00000000

0000000040000058 <ai_init>:
40000058: f0000048     	adrp	x8, 0x4000b000 <cloud_connected>
4000005c: f0000049     	adrp	x9, 0x4000b000 <cloud_connected>
40000060: b900051f     	str	wzr, [x8, #0x4]
40000064: b900013f     	str	wzr, [x9]
40000068: d65f03c0     	ret

000000004000006c <ai_auto_mode>:
4000006c: d503201f     	nop
40000070: 500322a0     	adr	x0, 0x400064c6 <__rodata_start+0x4c6>
40000074: 14000f36     	b	0x40003d4c <uart_puts>

0000000040000078 <ai_process_query>:
40000078: b4000220     	cbz	x0, 0x400000bc <ai_process_query+0x44>
4000007c: 39400008     	ldrb	w8, [x0]
40000080: aa0003e1     	mov	x1, x0
40000084: 340001c8     	cbz	w8, 0x400000bc <ai_process_query+0x44>
40000088: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000008c: f0000048     	adrp	x8, 0x4000b000 <cloud_connected>
40000090: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000094: 91020000     	add	x0, x0, #0x80
40000098: b9400509     	ldr	w9, [x8, #0x4]
4000009c: 910003fd     	mov	x29, sp
400000a0: 11000529     	add	w9, w9, #0x1
400000a4: b9000509     	str	w9, [x8, #0x4]
400000a8: 94001039     	bl	0x4000418c <uart_printf>
400000ac: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
400000b0: 910b1c00     	add	x0, x0, #0x2c7
400000b4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400000b8: 14000f25     	b	0x40003d4c <uart_puts>
400000bc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400000c0: 912c1400     	add	x0, x0, #0xb05
400000c4: 14000f22     	b	0x40003d4c <uart_puts>

00000000400000c8 <ai_start_interactive>:
400000c8: d105c3ff     	sub	sp, sp, #0x170
400000cc: a9117bfd     	stp	x29, x30, [sp, #0x110]
400000d0: 910443fd     	add	x29, sp, #0x110
400000d4: a9126ffc     	stp	x28, x27, [sp, #0x120]
400000d8: a91367fa     	stp	x26, x25, [sp, #0x130]
400000dc: a9145ff8     	stp	x24, x23, [sp, #0x140]
400000e0: a91557f6     	stp	x22, x21, [sp, #0x150]
400000e4: a9164ff4     	stp	x20, x19, [sp, #0x160]
400000e8: 940000ef     	bl	0x400004a4 <print_ai_banner>
400000ec: 90000053     	adrp	x19, 0x40008000 <__rodata_start+0x2000>
400000f0: 911d1673     	add	x19, x19, #0x745
400000f4: 90000054     	adrp	x20, 0x40008000 <__rodata_start+0x2000>
400000f8: 913a7294     	add	x20, x20, #0xe9c
400000fc: b0000055     	adrp	x21, 0x40009000 <__rodata_start+0x3000>
40000100: 910c4ab5     	add	x21, x21, #0x312
40000104: f0000036     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
40000108: 911d06d6     	add	x22, x22, #0x741
4000010c: f0000037     	adrp	x23, 0x40007000 <__rodata_start+0x1000>
40000110: 91070af7     	add	x23, x23, #0x1c2
40000114: f0000038     	adrp	x24, 0x40007000 <__rodata_start+0x1000>
40000118: 91356718     	add	x24, x24, #0xd59
4000011c: b0000059     	adrp	x25, 0x40009000 <__rodata_start+0x3000>
40000120: 910c5b39     	add	x25, x25, #0x316
40000124: 910023fc     	add	x28, sp, #0x8
40000128: 14000002     	b	0x40000130 <ai_start_interactive+0x68>
4000012c: 940000de     	bl	0x400004a4 <print_ai_banner>
40000130: aa1303e0     	mov	x0, x19
40000134: 94000f06     	bl	0x40003d4c <uart_puts>
40000138: aa1403e0     	mov	x0, x20
4000013c: 94000f04     	bl	0x40003d4c <uart_puts>
40000140: aa1f03fa     	mov	x26, xzr
40000144: aa1a03fb     	mov	x27, x26
40000148: 94000f34     	bl	0x40003e18 <uart_getc>
4000014c: 12001c08     	and	w8, w0, #0xff
40000150: 7100311f     	cmp	w8, #0xc
40000154: 540000cc     	b.gt	0x4000016c <ai_start_interactive+0xa4>
40000158: 7100211f     	cmp	w8, #0x8
4000015c: 54000240     	b.eq	0x400001a4 <ai_start_interactive+0xdc>
40000160: 7100291f     	cmp	w8, #0xa
40000164: 540000c1     	b.ne	0x4000017c <ai_start_interactive+0xb4>
40000168: 14000015     	b	0x400001bc <ai_start_interactive+0xf4>
4000016c: 7100351f     	cmp	w8, #0xd
40000170: 54000260     	b.eq	0x400001bc <ai_start_interactive+0xf4>
40000174: 7101fd1f     	cmp	w8, #0x7f
40000178: 54000160     	b.eq	0x400001a4 <ai_start_interactive+0xdc>
4000017c: 51008008     	sub	w8, w0, #0x20
40000180: 12001d08     	and	w8, w8, #0xff
40000184: 7101791f     	cmp	w8, #0x5e
40000188: 54fffe08     	b.hi	0x40000148 <ai_start_interactive+0x80>
4000018c: f103fb7f     	cmp	x27, #0xfe
40000190: 54fffdc8     	b.hi	0x40000148 <ai_start_interactive+0x80>
40000194: 9100077a     	add	x26, x27, #0x1
40000198: 383b6b80     	strb	w0, [x28, x27]
4000019c: 94000ed5     	bl	0x40003cf0 <uart_putc>
400001a0: 17ffffe9     	b	0x40000144 <ai_start_interactive+0x7c>
400001a4: aa1f03fa     	mov	x26, xzr
400001a8: b4fffcfb     	cbz	x27, 0x40000144 <ai_start_interactive+0x7c>
400001ac: aa1503e0     	mov	x0, x21
400001b0: d100077a     	sub	x26, x27, #0x1
400001b4: 94000ee6     	bl	0x40003d4c <uart_puts>
400001b8: 17ffffe3     	b	0x40000144 <ai_start_interactive+0x7c>
400001bc: aa1603e0     	mov	x0, x22
400001c0: 94000ee3     	bl	0x40003d4c <uart_puts>
400001c4: 910023e0     	add	x0, sp, #0x8
400001c8: 383b6b9f     	strb	wzr, [x28, x27]
400001cc: 94000b0b     	bl	0x40002df8 <kstrlen>
400001d0: b4fffb00     	cbz	x0, 0x40000130 <ai_start_interactive+0x68>
400001d4: 910023e0     	add	x0, sp, #0x8
400001d8: aa1703e1     	mov	x1, x23
400001dc: 94000b17     	bl	0x40002e38 <kstrcmp>
400001e0: 340014c0     	cbz	w0, 0x40000478 <ai_start_interactive+0x3b0>
400001e4: 910023e0     	add	x0, sp, #0x8
400001e8: aa1803e1     	mov	x1, x24
400001ec: 94000b13     	bl	0x40002e38 <kstrcmp>
400001f0: 34001440     	cbz	w0, 0x40000478 <ai_start_interactive+0x3b0>
400001f4: 910023e0     	add	x0, sp, #0x8
400001f8: aa1903e1     	mov	x1, x25
400001fc: 94000b0f     	bl	0x40002e38 <kstrcmp>
40000200: 340013c0     	cbz	w0, 0x40000478 <ai_start_interactive+0x3b0>
40000204: 910023e0     	add	x0, sp, #0x8
40000208: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000020c: 910b1c21     	add	x1, x1, #0x2c7
40000210: 94000b0a     	bl	0x40002e38 <kstrcmp>
40000214: 34fff8c0     	cbz	w0, 0x4000012c <ai_start_interactive+0x64>
40000218: 910023e0     	add	x0, sp, #0x8
4000021c: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000220: 912ca021     	add	x1, x1, #0xb28
40000224: 94000b05     	bl	0x40002e38 <kstrcmp>
40000228: 34fff820     	cbz	w0, 0x4000012c <ai_start_interactive+0x64>
4000022c: 910023e0     	add	x0, sp, #0x8
40000230: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000234: 910cec21     	add	x1, x1, #0x33b
40000238: 94000b00     	bl	0x40002e38 <kstrcmp>
4000023c: 340005e0     	cbz	w0, 0x400002f8 <ai_start_interactive+0x230>
40000240: 910023e0     	add	x0, sp, #0x8
40000244: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000248: 91301021     	add	x1, x1, #0xc04
4000024c: 94000afb     	bl	0x40002e38 <kstrcmp>
40000250: 34000a60     	cbz	w0, 0x4000039c <ai_start_interactive+0x2d4>
40000254: 910023e0     	add	x0, sp, #0x8
40000258: b0000041     	adrp	x1, 0x40009000 <__rodata_start+0x3000>
4000025c: 910c6c21     	add	x1, x1, #0x31b
40000260: 528000a2     	mov	w2, #0x5                // =5
40000264: 94000b04     	bl	0x40002e74 <kstrncmp>
40000268: 340008c0     	cbz	w0, 0x40000380 <ai_start_interactive+0x2b8>
4000026c: 910023e0     	add	x0, sp, #0x8
40000270: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40000274: 9102fc21     	add	x1, x1, #0xbf
40000278: 528000a2     	mov	w2, #0x5                // =5
4000027c: 94000afe     	bl	0x40002e74 <kstrncmp>
40000280: 34000800     	cbz	w0, 0x40000380 <ai_start_interactive+0x2b8>
40000284: 910023e0     	add	x0, sp, #0x8
40000288: f0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000028c: 913e7821     	add	x1, x1, #0xf9e
40000290: 94000aea     	bl	0x40002e38 <kstrcmp>
40000294: 34000e00     	cbz	w0, 0x40000454 <ai_start_interactive+0x38c>
40000298: 910023e0     	add	x0, sp, #0x8
4000029c: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
400002a0: 91261c21     	add	x1, x1, #0x987
400002a4: 94000ae5     	bl	0x40002e38 <kstrcmp>
400002a8: 34000d60     	cbz	w0, 0x40000454 <ai_start_interactive+0x38c>
400002ac: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400002b0: 910dbc00     	add	x0, x0, #0x36f
400002b4: 94000ea6     	bl	0x40003d4c <uart_puts>
400002b8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400002bc: 913eb800     	add	x0, x0, #0xfae
400002c0: 94000ea3     	bl	0x40003d4c <uart_puts>
400002c4: 394023e8     	ldrb	w8, [sp, #0x8]
400002c8: 34000d28     	cbz	w8, 0x4000046c <ai_start_interactive+0x3a4>
400002cc: f0000049     	adrp	x9, 0x4000b000 <cloud_connected>
400002d0: 910023e1     	add	x1, sp, #0x8
400002d4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400002d8: 91020000     	add	x0, x0, #0x80
400002dc: b9400528     	ldr	w8, [x9, #0x4]
400002e0: 11000508     	add	w8, w8, #0x1
400002e4: b9000528     	str	w8, [x9, #0x4]
400002e8: 94000fa9     	bl	0x4000418c <uart_printf>
400002ec: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
400002f0: 910b1c00     	add	x0, x0, #0x2c7
400002f4: 14000025     	b	0x40000388 <ai_start_interactive+0x2c0>
400002f8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400002fc: 911dd800     	add	x0, x0, #0x776
40000300: 94000e93     	bl	0x40003d4c <uart_puts>
40000304: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000308: 9130fc00     	add	x0, x0, #0xc3f
4000030c: 94000e90     	bl	0x40003d4c <uart_puts>
40000310: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000314: 91357c00     	add	x0, x0, #0xd5f
40000318: 94000e8d     	bl	0x40003d4c <uart_puts>
4000031c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000320: 91395400     	add	x0, x0, #0xe55
40000324: 94000e8a     	bl	0x40003d4c <uart_puts>
40000328: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000032c: 91329000     	add	x0, x0, #0xca4
40000330: 94000e87     	bl	0x40003d4c <uart_puts>
40000334: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000338: 912f2000     	add	x0, x0, #0xbc8
4000033c: 94000e84     	bl	0x40003d4c <uart_puts>
40000340: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000344: 91212c00     	add	x0, x0, #0x84b
40000348: 94000e81     	bl	0x40003d4c <uart_puts>
4000034c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000350: 9121f800     	add	x0, x0, #0x87e
40000354: 94000e7e     	bl	0x40003d4c <uart_puts>
40000358: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000035c: 91165000     	add	x0, x0, #0x594
40000360: 94000e7b     	bl	0x40003d4c <uart_puts>
40000364: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000368: 910b3800     	add	x0, x0, #0x2ce
4000036c: 94000e78     	bl	0x40003d4c <uart_puts>
40000370: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000374: 913dcc00     	add	x0, x0, #0xf73
40000378: 94000e75     	bl	0x40003d4c <uart_puts>
4000037c: 17ffff6d     	b	0x40000130 <ai_start_interactive+0x68>
40000380: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000384: 91163000     	add	x0, x0, #0x58c
40000388: 94000e71     	bl	0x40003d4c <uart_puts>
4000038c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000390: 913e7000     	add	x0, x0, #0xf9c
40000394: 94000e6e     	bl	0x40003d4c <uart_puts>
40000398: 17ffff66     	b	0x40000130 <ai_start_interactive+0x68>
4000039c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400003a0: 91174000     	add	x0, x0, #0x5d0
400003a4: 94000e6a     	bl	0x40003d4c <uart_puts>
400003a8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003ac: 911a6800     	add	x0, x0, #0x69a
400003b0: 94000e67     	bl	0x40003d4c <uart_puts>
400003b4: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003b8: 91049000     	add	x0, x0, #0x124
400003bc: 94000e64     	bl	0x40003d4c <uart_puts>
400003c0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400003c4: 9125c400     	add	x0, x0, #0x971
400003c8: 94000e61     	bl	0x40003d4c <uart_puts>
400003cc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400003d0: 91128400     	add	x0, x0, #0x4a1
400003d4: 94000e5e     	bl	0x40003d4c <uart_puts>
400003d8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003dc: 910be800     	add	x0, x0, #0x2fa
400003e0: 94000e5b     	bl	0x40003d4c <uart_puts>
400003e4: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003e8: 91000000     	add	x0, x0, #0x0
400003ec: 94000e58     	bl	0x40003d4c <uart_puts>
400003f0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400003f4: 911b6800     	add	x0, x0, #0x6da
400003f8: 94000e55     	bl	0x40003d4c <uart_puts>
400003fc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000400: 913db400     	add	x0, x0, #0xf6d
40000404: 94000e52     	bl	0x40003d4c <uart_puts>
40000408: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000040c: 9105b000     	add	x0, x0, #0x16c
40000410: 94000e4f     	bl	0x40003d4c <uart_puts>
40000414: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000418: 912aa400     	add	x0, x0, #0xaa9
4000041c: 94000e4c     	bl	0x40003d4c <uart_puts>
40000420: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000424: 91023400     	add	x0, x0, #0x8d
40000428: 94000e49     	bl	0x40003d4c <uart_puts>
4000042c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000430: 910d0800     	add	x0, x0, #0x342
40000434: 94000e46     	bl	0x40003d4c <uart_puts>
40000438: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000043c: 913e3000     	add	x0, x0, #0xf8c
40000440: 94000e43     	bl	0x40003d4c <uart_puts>
40000444: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000448: 91225c00     	add	x0, x0, #0x897
4000044c: 94000e40     	bl	0x40003d4c <uart_puts>
40000450: 17ffff38     	b	0x40000130 <ai_start_interactive+0x68>
40000454: f0000048     	adrp	x8, 0x4000b000 <cloud_connected>
40000458: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000045c: 91267400     	add	x0, x0, #0x99d
40000460: b9400501     	ldr	w1, [x8, #0x4]
40000464: 94000f4a     	bl	0x4000418c <uart_printf>
40000468: 17ffff32     	b	0x40000130 <ai_start_interactive+0x68>
4000046c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000470: 912c1400     	add	x0, x0, #0xb05
40000474: 17ffffc5     	b	0x40000388 <ai_start_interactive+0x2c0>
40000478: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000047c: 913cc800     	add	x0, x0, #0xf32
40000480: 94000e33     	bl	0x40003d4c <uart_puts>
40000484: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40000488: a95557f6     	ldp	x22, x21, [sp, #0x150]
4000048c: a9545ff8     	ldp	x24, x23, [sp, #0x140]
40000490: a95367fa     	ldp	x26, x25, [sp, #0x130]
40000494: a9526ffc     	ldp	x28, x27, [sp, #0x120]
40000498: a9517bfd     	ldp	x29, x30, [sp, #0x110]
4000049c: 9105c3ff     	add	sp, sp, #0x170
400004a0: d65f03c0     	ret

00000000400004a4 <print_ai_banner>:
400004a4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400004a8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400004ac: 91271000     	add	x0, x0, #0x9c4
400004b0: 910003fd     	mov	x29, sp
400004b4: 94000e26     	bl	0x40003d4c <uart_puts>
400004b8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400004bc: 913ae400     	add	x0, x0, #0xeb9
400004c0: 94000e23     	bl	0x40003d4c <uart_puts>
400004c4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400004c8: 9120f800     	add	x0, x0, #0x83e
400004cc: 94000e20     	bl	0x40003d4c <uart_puts>
400004d0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400004d4: 91060400     	add	x0, x0, #0x181
400004d8: 94000e1d     	bl	0x40003d4c <uart_puts>
400004dc: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400004e0: 911c1400     	add	x0, x0, #0x705
400004e4: 94000e1a     	bl	0x40003d4c <uart_puts>
400004e8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
400004ec: 91302800     	add	x0, x0, #0xc0a
400004f0: 94000e17     	bl	0x40003d4c <uart_puts>
400004f4: f0000048     	adrp	x8, 0x4000b000 <cloud_connected>
400004f8: d0000029     	adrp	x9, 0x40006000 <__rodata_start>
400004fc: 9113a129     	add	x9, x9, #0x4e8
40000500: b9400108     	ldr	w8, [x8]
40000504: 7100011f     	cmp	w8, #0x0
40000508: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
4000050c: 9107a108     	add	x8, x8, #0x1e8
40000510: 9a890100     	csel	x0, x8, x9, eq
40000514: 94000e0e     	bl	0x40003d4c <uart_puts>
40000518: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000051c: 91072000     	add	x0, x0, #0x1c8
40000520: 94000e0b     	bl	0x40003d4c <uart_puts>
40000524: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000528: 913a5c00     	add	x0, x0, #0xe97
4000052c: 94000e08     	bl	0x40003d4c <uart_puts>
40000530: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000534: 910dbc00     	add	x0, x0, #0x36f
40000538: 94000e05     	bl	0x40003d4c <uart_puts>
4000053c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000540: 912cb800     	add	x0, x0, #0xb2e
40000544: 94000e02     	bl	0x40003d4c <uart_puts>
40000548: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000054c: 91263800     	add	x0, x0, #0x98e
40000550: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000554: 14000dfe     	b	0x40003d4c <uart_puts>

0000000040000558 <launch_kedit>:
40000558: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
4000055c: a9016ffc     	stp	x28, x27, [sp, #0x10]
40000560: 910003fd     	mov	x29, sp
40000564: a90267fa     	stp	x26, x25, [sp, #0x20]
40000568: a9035ff8     	stp	x24, x23, [sp, #0x30]
4000056c: a90457f6     	stp	x22, x21, [sp, #0x40]
40000570: a9054ff4     	stp	x20, x19, [sp, #0x50]
40000574: d11043ff     	sub	sp, sp, #0x410
40000578: d503201f     	nop
4000057c: 10055473     	adr	x19, 0x4000b008 <E>
40000580: aa0003f4     	mov	x20, x0
40000584: aa1303e0     	mov	x0, x19
40000588: 2a1f03e1     	mov	w1, wzr
4000058c: 52864a82     	mov	w2, #0x3254             // =12884
40000590: 94000a84     	bl	0x40002fa0 <kmemset>
40000594: aa1303e0     	mov	x0, x19
40000598: aa1403e1     	mov	x1, x20
4000059c: 528007e2     	mov	w2, #0x3f               // =63
400005a0: 94000a4c     	bl	0x40002ed0 <kstrncpy>
400005a4: 5280003c     	mov	w28, #0x1               // =1
400005a8: aa1403e0     	mov	x0, x20
400005ac: b932427c     	str	w28, [x19, #0x3240]
400005b0: 940012d3     	bl	0x400050fc <vfs_find>
400005b4: d0000077     	adrp	x23, 0x4000e000 <E+0x2ff8>
400005b8: b40004a0     	cbz	x0, 0x4000064c <launch_kedit+0xf4>
400005bc: b9402008     	ldr	w8, [x0, #0x20]
400005c0: 35000468     	cbnz	w8, 0x4000064c <launch_kedit+0xf4>
400005c4: f9401408     	ldr	x8, [x0, #0x28]
400005c8: b40003c8     	cbz	x8, 0x40000640 <launch_kedit+0xe8>
400005cc: 2a1f03e8     	mov	w8, wzr
400005d0: 2a1f03eb     	mov	w11, wzr
400005d4: aa1f03e9     	mov	x9, xzr
400005d8: 9100c00a     	add	x10, x0, #0x30
400005dc: 1400000d     	b	0x40000610 <launch_kedit+0xb8>
400005e0: 93407d0c     	sxtw	x12, w8
400005e4: 7101891f     	cmp	w8, #0x62
400005e8: 11000508     	add	w8, w8, #0x1
400005ec: 8b0c1e6c     	add	x12, x19, x12, lsl #7
400005f0: 8b2bc18b     	add	x11, x12, w11, sxtw
400005f4: 3901017f     	strb	wzr, [x11, #0x40]
400005f8: 2a1f03eb     	mov	w11, wzr
400005fc: 5400022c     	b.gt	0x40000640 <launch_kedit+0xe8>
40000600: f940140c     	ldr	x12, [x0, #0x28]
40000604: 91000529     	add	x9, x9, #0x1
40000608: eb0c013f     	cmp	x9, x12
4000060c: 540001a2     	b.hs	0x40000640 <launch_kedit+0xe8>
40000610: 3869694c     	ldrb	w12, [x10, x9]
40000614: 7100299f     	cmp	w12, #0xa
40000618: 54fffe40     	b.eq	0x400005e0 <launch_kedit+0x88>
4000061c: 7101f97f     	cmp	w11, #0x7e
40000620: 54ffff0c     	b.gt	0x40000600 <launch_kedit+0xa8>
40000624: 2a0803ed     	mov	w13, w8
40000628: 93407dad     	sxtw	x13, w13
4000062c: 8b0d1e6d     	add	x13, x19, x13, lsl #7
40000630: 8b2bc1ad     	add	x13, x13, w11, sxtw
40000634: 1100056b     	add	w11, w11, #0x1
40000638: 390101ac     	strb	w12, [x13, #0x40]
4000063c: 17fffff1     	b	0x40000600 <launch_kedit+0xa8>
40000640: 7100051f     	cmp	w8, #0x1
40000644: 1a9f8508     	csinc	w8, w8, wzr, hi
40000648: b9024ae8     	str	w8, [x23, #0x248]
4000064c: d503201f     	nop
40000650: 1003e060     	adr	x0, 0x4000825c <__rodata_start+0x225c>
40000654: 94000dbe     	bl	0x40003d4c <uart_puts>
40000658: f0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
4000065c: 910e9694     	add	x20, x20, #0x3a5
40000660: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
40000664: 91050ad6     	add	x22, x22, #0x142
40000668: f0000038     	adrp	x24, 0x40007000 <__rodata_start+0x1000>
4000066c: 912ea318     	add	x24, x24, #0xba8
40000670: f0000039     	adrp	x25, 0x40007000 <__rodata_start+0x1000>
40000674: 913e7339     	add	x25, x25, #0xf9c
40000678: d000007a     	adrp	x26, 0x4000e000 <E+0x2ff8>
4000067c: 9109335a     	add	x26, x26, #0x24c
40000680: d000007b     	adrp	x27, 0x4000e000 <E+0x2ff8>
40000684: 14000004     	b	0x40000694 <launch_kedit+0x13c>
40000688: 51004d08     	sub	w8, w8, #0x13
4000068c: d0000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
40000690: b9025528     	str	w8, [x9, #0x254]
40000694: aa1403e0     	mov	x0, x20
40000698: 94000dad     	bl	0x40003d4c <uart_puts>
4000069c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006a0: 91271000     	add	x0, x0, #0x9c4
400006a4: 94000daa     	bl	0x40003d4c <uart_puts>
400006a8: aa1603e0     	mov	x0, x22
400006ac: 94000da8     	bl	0x40003d4c <uart_puts>
400006b0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400006b4: 91268800     	add	x0, x0, #0x9a2
400006b8: aa1303e1     	mov	x1, x19
400006bc: 94000eb4     	bl	0x4000418c <uart_printf>
400006c0: b9725268     	ldr	w8, [x19, #0x3250]
400006c4: f0000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
400006c8: 912dd929     	add	x9, x9, #0xb76
400006cc: 7100011f     	cmp	w8, #0x0
400006d0: 90000048     	adrp	x8, 0x40008000 <__rodata_start+0x2000>
400006d4: 910d1108     	add	x8, x8, #0x344
400006d8: 9a880120     	csel	x0, x9, x8, eq
400006dc: 94000d9c     	bl	0x40003d4c <uart_puts>
400006e0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400006e4: 911d1000     	add	x0, x0, #0x744
400006e8: 94000d99     	bl	0x40003d4c <uart_puts>
400006ec: aa1f03f5     	mov	x21, xzr
400006f0: b9b24e68     	ldrsw	x8, [x19, #0x324c]
400006f4: b9724269     	ldr	w9, [x19, #0x3240]
400006f8: 8b0802a8     	add	x8, x21, x8
400006fc: 8b081e6a     	add	x10, x19, x8, lsl #7
40000700: 6b09011f     	cmp	w8, w9
40000704: 9101014a     	add	x10, x10, #0x40
40000708: 9a98b140     	csel	x0, x10, x24, lt
4000070c: 94000d90     	bl	0x40003d4c <uart_puts>
40000710: aa1903e0     	mov	x0, x25
40000714: 94000d8e     	bl	0x40003d4c <uart_puts>
40000718: 910006b5     	add	x21, x21, #0x1
4000071c: 710052bf     	cmp	w21, #0x14
40000720: 54fffe81     	b.ne	0x400006f0 <launch_kedit+0x198>
40000724: aa1603e0     	mov	x0, x22
40000728: 94000d89     	bl	0x40003d4c <uart_puts>
4000072c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000730: 912ecc00     	add	x0, x0, #0xbb3
40000734: 94000d86     	bl	0x40003d4c <uart_puts>
40000738: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000073c: 9116fc00     	add	x0, x0, #0x5bf
40000740: 94000d83     	bl	0x40003d4c <uart_puts>
40000744: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000748: 913e9800     	add	x0, x0, #0xfa6
4000074c: 94000d80     	bl	0x40003d4c <uart_puts>
40000750: 2940a349     	ldp	w9, w8, [x26, #0x4]
40000754: b940034a     	ldr	w10, [x26]
40000758: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000075c: 91157800     	add	x0, x0, #0x55e
40000760: 4b080128     	sub	w8, w9, w8
40000764: 11000542     	add	w2, w10, #0x1
40000768: 11000901     	add	w1, w8, #0x2
4000076c: 94000e88     	bl	0x4000418c <uart_printf>
40000770: 94000daa     	bl	0x40003e18 <uart_getc>
40000774: 12001c08     	and	w8, w0, #0xff
40000778: 2a0003f5     	mov	w21, w0
4000077c: 7100491f     	cmp	w8, #0x12
40000780: 5400010d     	b.le	0x400007a0 <launch_kedit+0x248>
40000784: 7100691f     	cmp	w8, #0x1a
40000788: 540009ed     	b.le	0x400008c4 <launch_kedit+0x36c>
4000078c: 71006d1f     	cmp	w8, #0x1b
40000790: 54000e40     	b.eq	0x40000958 <launch_kedit+0x400>
40000794: 7101fd1f     	cmp	w8, #0x7f
40000798: 540005e0     	b.eq	0x40000854 <launch_kedit+0x2fc>
4000079c: 1400008b     	b	0x400009c8 <launch_kedit+0x470>
400007a0: 7100211f     	cmp	w8, #0x8
400007a4: 54000580     	b.eq	0x40000854 <launch_kedit+0x2fc>
400007a8: 7100291f     	cmp	w8, #0xa
400007ac: 54000060     	b.eq	0x400007b8 <launch_kedit+0x260>
400007b0: 7100351f     	cmp	w8, #0xd
400007b4: 540010a1     	b.ne	0x400009c8 <launch_kedit+0x470>
400007b8: b9824af6     	ldrsw	x22, [x23, #0x248]
400007bc: 71018edf     	cmp	w22, #0x63
400007c0: 540014ac     	b.gt	0x40000a54 <launch_kedit+0x4fc>
400007c4: b9825368     	ldrsw	x8, [x27, #0x250]
400007c8: 6b0802df     	cmp	w22, w8
400007cc: 5400016d     	b.le	0x400007f8 <launch_kedit+0x2a0>
400007d0: 8b161e68     	add	x8, x19, x22, lsl #7
400007d4: 91010100     	add	x0, x8, #0x40
400007d8: d1020015     	sub	x21, x0, #0x80
400007dc: d10006d6     	sub	x22, x22, #0x1
400007e0: aa1503e1     	mov	x1, x21
400007e4: 940009b4     	bl	0x40002eb4 <kstrcpy>
400007e8: b9825368     	ldrsw	x8, [x27, #0x250]
400007ec: aa1503e0     	mov	x0, x21
400007f0: eb0802df     	cmp	x22, x8
400007f4: 54ffff2c     	b.gt	0x400007d8 <launch_kedit+0x280>
400007f8: f0000055     	adrp	x21, 0x4000b000 <cloud_connected>
400007fc: 910122b5     	add	x21, x21, #0x48
40000800: 910023e0     	add	x0, sp, #0x8
40000804: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000808: 8b081ea8     	add	x8, x21, x8, lsl #7
4000080c: 8b090101     	add	x1, x8, x9
40000810: 940009a9     	bl	0x40002eb4 <kstrcpy>
40000814: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000818: b9b206a9     	ldrsw	x9, [x21, #0x3204]
4000081c: 910023e1     	add	x1, sp, #0x8
40000820: 8b081ea8     	add	x8, x21, x8, lsl #7
40000824: 3829691f     	strb	wzr, [x8, x9]
40000828: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
4000082c: 91000508     	add	x8, x8, #0x1
40000830: 8b081ea0     	add	x0, x21, x8, lsl #7
40000834: b9320aa8     	str	w8, [x21, #0x3208]
40000838: 9400099f     	bl	0x40002eb4 <kstrcpy>
4000083c: b97202a8     	ldr	w8, [x21, #0x3200]
40000840: b93206bf     	str	wzr, [x21, #0x3204]
40000844: b93212bc     	str	w28, [x21, #0x3210]
40000848: 11000508     	add	w8, w8, #0x1
4000084c: b93202a8     	str	w8, [x21, #0x3200]
40000850: 14000081     	b	0x40000a54 <launch_kedit+0x4fc>
40000854: d0000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
40000858: b9424d08     	ldr	w8, [x8, #0x24c]
4000085c: 7100051f     	cmp	w8, #0x1
40000860: 54000fab     	b.lt	0x40000a54 <launch_kedit+0x4fc>
40000864: b9b24a68     	ldrsw	x8, [x19, #0x3248]
40000868: 8b081e68     	add	x8, x19, x8, lsl #7
4000086c: 91010100     	add	x0, x8, #0x40
40000870: 94000962     	bl	0x40002df8 <kstrlen>
40000874: b9724669     	ldr	w9, [x19, #0x3244]
40000878: 6b00013f     	cmp	w9, w0
4000087c: 51000528     	sub	w8, w9, #0x1
40000880: 540001cc     	b.gt	0x400008b8 <launch_kedit+0x360>
40000884: 8b28c268     	add	x8, x19, w8, sxtw
40000888: 4b090009     	sub	w9, w0, w9
4000088c: 11000529     	add	w9, w9, #0x1
40000890: b982536a     	ldrsw	x10, [x27, #0x250]
40000894: 71000529     	subs	w9, w9, #0x1
40000898: 8b0a1d0a     	add	x10, x8, x10, lsl #7
4000089c: 91000508     	add	x8, x8, #0x1
400008a0: 3941054b     	ldrb	w11, [x10, #0x41]
400008a4: 3901014b     	strb	w11, [x10, #0x40]
400008a8: 54ffff41     	b.ne	0x40000890 <launch_kedit+0x338>
400008ac: d0000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
400008b0: b9424d08     	ldr	w8, [x8, #0x24c]
400008b4: 51000508     	sub	w8, w8, #0x1
400008b8: b9000348     	str	w8, [x26]
400008bc: b9000f5c     	str	w28, [x26, #0xc]
400008c0: 14000065     	b	0x40000a54 <launch_kedit+0x4fc>
400008c4: 71004d1f     	cmp	w8, #0x13
400008c8: 540007c1     	b.ne	0x400009c0 <launch_kedit+0x468>
400008cc: b9424ae8     	ldr	w8, [x23, #0x248]
400008d0: 390023ff     	strb	wzr, [sp, #0x8]
400008d4: 7100051f     	cmp	w8, #0x1
400008d8: 5400030b     	b.lt	0x40000938 <launch_kedit+0x3e0>
400008dc: aa1f03fc     	mov	x28, xzr
400008e0: 2a1f03f6     	mov	w22, wzr
400008e4: f0000055     	adrp	x21, 0x4000b000 <cloud_connected>
400008e8: 910122b5     	add	x21, x21, #0x48
400008ec: 14000006     	b	0x40000904 <launch_kedit+0x3ac>
400008f0: b9824ae8     	ldrsw	x8, [x23, #0x248]
400008f4: 9100079c     	add	x28, x28, #0x1
400008f8: 910202b5     	add	x21, x21, #0x80
400008fc: eb08039f     	cmp	x28, x8
40000900: 540001ca     	b.ge	0x40000938 <launch_kedit+0x3e0>
40000904: aa1503e0     	mov	x0, x21
40000908: 9400093c     	bl	0x40002df8 <kstrlen>
4000090c: 0b0002d4     	add	w20, w22, w0
40000910: 710ffa9f     	cmp	w20, #0x3fe
40000914: 54fffeec     	b.gt	0x400008f0 <launch_kedit+0x398>
40000918: 910023e0     	add	x0, sp, #0x8
4000091c: aa1503e1     	mov	x1, x21
40000920: 9400093d     	bl	0x40002e14 <kstrcat>
40000924: 910023e0     	add	x0, sp, #0x8
40000928: aa1903e1     	mov	x1, x25
4000092c: 9400093a     	bl	0x40002e14 <kstrcat>
40000930: 11000696     	add	w22, w20, #0x1
40000934: 17ffffef     	b	0x400008f0 <launch_kedit+0x398>
40000938: 910023e1     	add	x1, sp, #0x8
4000093c: aa1303e0     	mov	x0, x19
40000940: 9400136a     	bl	0x400056e8 <vfs_write_file>
40000944: b932527f     	str	wzr, [x19, #0x3250]
40000948: 5280003c     	mov	w28, #0x1               // =1
4000094c: f0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40000950: 910e9694     	add	x20, x20, #0x3a5
40000954: 14000040     	b	0x40000a54 <launch_kedit+0x4fc>
40000958: 94000d30     	bl	0x40003e18 <uart_getc>
4000095c: 12001c14     	and	w20, w0, #0xff
40000960: 94000d2e     	bl	0x40003e18 <uart_getc>
40000964: 71016e9f     	cmp	w20, #0x5b
40000968: f0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
4000096c: 910e9694     	add	x20, x20, #0x3a5
40000970: 54000721     	b.ne	0x40000a54 <launch_kedit+0x4fc>
40000974: 12001c09     	and	w9, w0, #0xff
40000978: b9425368     	ldr	w8, [x27, #0x250]
4000097c: 7101053f     	cmp	w9, #0x41
40000980: 54000801     	b.ne	0x40000a80 <launch_kedit+0x528>
40000984: 7100011f     	cmp	w8, #0x0
40000988: 540007cd     	b.le	0x40000a80 <launch_kedit+0x528>
4000098c: 12800009     	mov	w9, #-0x1               // =-1
40000990: 0b090108     	add	w8, w8, w9
40000994: b9025368     	str	w8, [x27, #0x250]
40000998: 93407d08     	sxtw	x8, w8
4000099c: 8b081e68     	add	x8, x19, x8, lsl #7
400009a0: 91010100     	add	x0, x8, #0x40
400009a4: 94000915     	bl	0x40002df8 <kstrlen>
400009a8: b9724668     	ldr	w8, [x19, #0x3244]
400009ac: 6b00011f     	cmp	w8, w0
400009b0: 5400052d     	b.le	0x40000a54 <launch_kedit+0x4fc>
400009b4: d0000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
400009b8: b9024d00     	str	w0, [x8, #0x24c]
400009bc: 14000026     	b	0x40000a54 <launch_kedit+0x4fc>
400009c0: 7100611f     	cmp	w8, #0x18
400009c4: 54000ac0     	b.eq	0x40000b1c <launch_kedit+0x5c4>
400009c8: 510082a8     	sub	w8, w21, #0x20
400009cc: 12001d08     	and	w8, w8, #0xff
400009d0: 7101791f     	cmp	w8, #0x5e
400009d4: 54000408     	b.hi	0x40000a54 <launch_kedit+0x4fc>
400009d8: d0000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
400009dc: b9424d08     	ldr	w8, [x8, #0x24c]
400009e0: 7101f91f     	cmp	w8, #0x7e
400009e4: 5400038c     	b.gt	0x40000a54 <launch_kedit+0x4fc>
400009e8: b9b24a68     	ldrsw	x8, [x19, #0x3248]
400009ec: 8b081e68     	add	x8, x19, x8, lsl #7
400009f0: 91010100     	add	x0, x8, #0x40
400009f4: 94000901     	bl	0x40002df8 <kstrlen>
400009f8: b9b24668     	ldrsw	x8, [x19, #0x3244]
400009fc: 6b00011f     	cmp	w8, w0
40000a00: 540001ac     	b.gt	0x40000a34 <launch_kedit+0x4dc>
40000a04: 93407c08     	sxtw	x8, w0
40000a08: 91000509     	add	x9, x8, #0x1
40000a0c: 8b08026a     	add	x10, x19, x8
40000a10: b9800748     	ldrsw	x8, [x26, #0x4]
40000a14: d1000529     	sub	x9, x9, #0x1
40000a18: 8b081d48     	add	x8, x10, x8, lsl #7
40000a1c: d100054a     	sub	x10, x10, #0x1
40000a20: 3941010b     	ldrb	w11, [x8, #0x40]
40000a24: 3901050b     	strb	w11, [x8, #0x41]
40000a28: b9800348     	ldrsw	x8, [x26]
40000a2c: eb08013f     	cmp	x9, x8
40000a30: 54ffff0c     	b.gt	0x40000a10 <launch_kedit+0x4b8>
40000a34: b9b24a69     	ldrsw	x9, [x19, #0x3248]
40000a38: 8b091e69     	add	x9, x19, x9, lsl #7
40000a3c: 8b080128     	add	x8, x9, x8
40000a40: 39010115     	strb	w21, [x8, #0x40]
40000a44: b9724668     	ldr	w8, [x19, #0x3244]
40000a48: b932527c     	str	w28, [x19, #0x3250]
40000a4c: 11000508     	add	w8, w8, #0x1
40000a50: b9324668     	str	w8, [x19, #0x3244]
40000a54: d0000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
40000a58: 91094129     	add	x9, x9, #0x250
40000a5c: d0000036     	adrp	x22, 0x40006000 <__rodata_start>
40000a60: 91050ad6     	add	x22, x22, #0x142
40000a64: 29402528     	ldp	w8, w9, [x9]
40000a68: 6b09011f     	cmp	w8, w9
40000a6c: 54ffe10b     	b.lt	0x4000068c <launch_kedit+0x134>
40000a70: 11005129     	add	w9, w9, #0x14
40000a74: 6b09011f     	cmp	w8, w9
40000a78: 54ffe0eb     	b.lt	0x40000694 <launch_kedit+0x13c>
40000a7c: 17ffff03     	b	0x40000688 <launch_kedit+0x130>
40000a80: 71010d3f     	cmp	w9, #0x43
40000a84: 54000120     	b.eq	0x40000aa8 <launch_kedit+0x550>
40000a88: 7101093f     	cmp	w9, #0x42
40000a8c: 540002a1     	b.ne	0x40000ae0 <launch_kedit+0x588>
40000a90: b9424ae9     	ldr	w9, [x23, #0x248]
40000a94: 51000529     	sub	w9, w9, #0x1
40000a98: 6b09011f     	cmp	w8, w9
40000a9c: 54fff7ea     	b.ge	0x40000998 <launch_kedit+0x440>
40000aa0: 52800029     	mov	w9, #0x1                // =1
40000aa4: 17ffffbb     	b	0x40000990 <launch_kedit+0x438>
40000aa8: 93407d08     	sxtw	x8, w8
40000aac: b9b24674     	ldrsw	x20, [x19, #0x3244]
40000ab0: 8b081e68     	add	x8, x19, x8, lsl #7
40000ab4: 91010100     	add	x0, x8, #0x40
40000ab8: 940008d0     	bl	0x40002df8 <kstrlen>
40000abc: eb14001f     	cmp	x0, x20
40000ac0: f0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40000ac4: 910e9694     	add	x20, x20, #0x3a5
40000ac8: 54fffc69     	b.ls	0x40000a54 <launch_kedit+0x4fc>
40000acc: d0000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
40000ad0: b9424d28     	ldr	w8, [x9, #0x24c]
40000ad4: 11000508     	add	w8, w8, #0x1
40000ad8: b9024d28     	str	w8, [x9, #0x24c]
40000adc: 17ffffde     	b	0x40000a54 <launch_kedit+0x4fc>
40000ae0: 12001c09     	and	w9, w0, #0xff
40000ae4: 7101113f     	cmp	w9, #0x44
40000ae8: 54000101     	b.ne	0x40000b08 <launch_kedit+0x5b0>
40000aec: d0000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
40000af0: b9424d29     	ldr	w9, [x9, #0x24c]
40000af4: 71000529     	subs	w9, w9, #0x1
40000af8: 5400008b     	b.lt	0x40000b08 <launch_kedit+0x5b0>
40000afc: d0000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
40000b00: b9024d09     	str	w9, [x8, #0x24c]
40000b04: 17ffffd4     	b	0x40000a54 <launch_kedit+0x4fc>
40000b08: 51010409     	sub	w9, w0, #0x41
40000b0c: 12001d29     	and	w9, w9, #0xff
40000b10: 7100093f     	cmp	w9, #0x2
40000b14: 54fff423     	b.lo	0x40000998 <launch_kedit+0x440>
40000b18: 17ffffcf     	b	0x40000a54 <launch_kedit+0x4fc>
40000b1c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b20: 91098800     	add	x0, x0, #0x262
40000b24: 94000c8a     	bl	0x40003d4c <uart_puts>
40000b28: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b2c: 910cc800     	add	x0, x0, #0x332
40000b30: 94000c87     	bl	0x40003d4c <uart_puts>
40000b34: 911043ff     	add	sp, sp, #0x410
40000b38: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40000b3c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40000b40: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40000b44: a94267fa     	ldp	x26, x25, [sp, #0x20]
40000b48: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40000b4c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40000b50: d65f03c0     	ret

0000000040000b54 <print_banner>:
40000b54: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b58: d503201f     	nop
40000b5c: 10037340     	adr	x0, 0x400079c4 <__rodata_start+0x19c4>
40000b60: 910003fd     	mov	x29, sp
40000b64: 94000c7a     	bl	0x40003d4c <uart_puts>
40000b68: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b6c: 913e7000     	add	x0, x0, #0xf9c
40000b70: 94000c77     	bl	0x40003d4c <uart_puts>
40000b74: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000b78: 912f8000     	add	x0, x0, #0xbe0
40000b7c: 94000c74     	bl	0x40003d4c <uart_puts>
40000b80: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b84: 910d4400     	add	x0, x0, #0x351
40000b88: 94000c71     	bl	0x40003d4c <uart_puts>
40000b8c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000b90: 9126f400     	add	x0, x0, #0x9bd
40000b94: 94000c6e     	bl	0x40003d4c <uart_puts>
40000b98: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000b9c: 9100b800     	add	x0, x0, #0x2e
40000ba0: 94000c6b     	bl	0x40003d4c <uart_puts>
40000ba4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000ba8: 9127e000     	add	x0, x0, #0x9f8
40000bac: 94000c68     	bl	0x40003d4c <uart_puts>
40000bb0: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40000bb4: 91033000     	add	x0, x0, #0xcc
40000bb8: 94000c65     	bl	0x40003d4c <uart_puts>
40000bbc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000bc0: 911d2800     	add	x0, x0, #0x74a
40000bc4: 94000d72     	bl	0x4000418c <uart_printf>
40000bc8: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000bcc: 913eb400     	add	x0, x0, #0xfad
40000bd0: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000bd4: 9122fc21     	add	x1, x1, #0x8bf
40000bd8: 94000d6d     	bl	0x4000418c <uart_printf>
40000bdc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000be0: 91338400     	add	x0, x0, #0xce1
40000be4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000be8: 9128d021     	add	x1, x1, #0xa34
40000bec: 94000d68     	bl	0x4000418c <uart_printf>
40000bf0: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000bf4: 91171000     	add	x0, x0, #0x5c4
40000bf8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bfc: 14000c54     	b	0x40003d4c <uart_puts>

0000000040000c00 <print_about>:
40000c00: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000c04: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c08: 910c7c00     	add	x0, x0, #0x31f
40000c0c: 910003fd     	mov	x29, sp
40000c10: 94000c4f     	bl	0x40003d4c <uart_puts>
40000c14: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c18: 91389c00     	add	x0, x0, #0xe27
40000c1c: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000c20: 91291421     	add	x1, x1, #0xa45
40000c24: 94000d5a     	bl	0x4000418c <uart_printf>
40000c28: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c2c: 913f2c00     	add	x0, x0, #0xfcb
40000c30: d0000021     	adrp	x1, 0x40006000 <__rodata_start>
40000c34: 9122fc21     	add	x1, x1, #0x8bf
40000c38: 94000d55     	bl	0x4000418c <uart_printf>
40000c3c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c40: 912e0c00     	add	x0, x0, #0xb83
40000c44: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000c48: 9128d021     	add	x1, x1, #0xa34
40000c4c: 94000d50     	bl	0x4000418c <uart_printf>
40000c50: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000c54: 9134c400     	add	x0, x0, #0xd31
40000c58: 94000c3d     	bl	0x40003d4c <uart_puts>
40000c5c: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000c60: 9131cc00     	add	x0, x0, #0xc73
40000c64: 94000c3a     	bl	0x40003d4c <uart_puts>
40000c68: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c6c: 913e7000     	add	x0, x0, #0xf9c
40000c70: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000c74: 14000c36     	b	0x40003d4c <uart_puts>

0000000040000c78 <print_sysinfo>:
40000c78: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000c7c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000c80: 91230000     	add	x0, x0, #0x8c0
40000c84: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000c88: 910003fd     	mov	x29, sp
40000c8c: d5384248     	mrs	x8, CurrentEL
40000c90: d3420d13     	ubfx	x19, x8, #2, #2
40000c94: d5380014     	mrs	x20, MIDR_EL1
40000c98: 94000c2d     	bl	0x40003d4c <uart_puts>
40000c9c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000ca0: 91133c00     	add	x0, x0, #0x4cf
40000ca4: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000ca8: 91291421     	add	x1, x1, #0xa45
40000cac: d0000022     	adrp	x2, 0x40006000 <__rodata_start>
40000cb0: 9122fc42     	add	x2, x2, #0x8bf
40000cb4: 94000d36     	bl	0x4000418c <uart_printf>
40000cb8: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000cbc: 9113b800     	add	x0, x0, #0x4ee
40000cc0: 90000041     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40000cc4: 9128d021     	add	x1, x1, #0xa34
40000cc8: 94000d31     	bl	0x4000418c <uart_printf>
40000ccc: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000cd0: 91229c00     	add	x0, x0, #0x8a7
40000cd4: 94000d2e     	bl	0x4000418c <uart_printf>
40000cd8: b0000048     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40000cdc: 9105b508     	add	x8, x8, #0x16d
40000ce0: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
40000ce4: 91359929     	add	x9, x9, #0xd66
40000ce8: f1000a7f     	cmp	x19, #0x2
40000cec: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000cf0: 91236800     	add	x0, x0, #0x8da
40000cf4: 9a880128     	csel	x8, x9, x8, eq
40000cf8: f100067f     	cmp	x19, #0x1
40000cfc: 90000049     	adrp	x9, 0x40008000 <__rodata_start+0x2000>
40000d00: 910e3129     	add	x9, x9, #0x38c
40000d04: 2a1303e1     	mov	w1, w19
40000d08: 9a880122     	csel	x2, x9, x8, eq
40000d0c: 94000d20     	bl	0x4000418c <uart_printf>
40000d10: 53187e81     	lsr	w1, w20, #24
40000d14: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000d18: 91390000     	add	x0, x0, #0xe40
40000d1c: aa1403e2     	mov	x2, x20
40000d20: 94000d1b     	bl	0x4000418c <uart_printf>
40000d24: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000d28: 91199800     	add	x0, x0, #0x666
40000d2c: d503201f     	nop
40000d30: 10ff9681     	adr	x1, 0x40000000 <_start>
40000d34: 94000d16     	bl	0x4000418c <uart_printf>
40000d38: d503201f     	nop
40000d3c: 10ff9621     	adr	x1, 0x40000000 <_start>
40000d40: d503201f     	nop
40000d44: 10025c62     	adr	x2, 0x400058d0 <__text_end>
40000d48: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000d4c: 910eb000     	add	x0, x0, #0x3ac
40000d50: cb010043     	sub	x3, x2, x1
40000d54: 94000d0e     	bl	0x4000418c <uart_printf>
40000d58: d503201f     	nop
40000d5c: 10029521     	adr	x1, 0x40006000 <__rodata_start>
40000d60: d503201f     	nop
40000d64: 10043d62     	adr	x2, 0x40009510 <__rodata_end>
40000d68: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000d6c: 91278800     	add	x0, x0, #0x9e2
40000d70: cb010043     	sub	x3, x2, x1
40000d74: 94000d06     	bl	0x4000418c <uart_printf>
40000d78: d503201f     	nop
40000d7c: 10049421     	adr	x1, 0x4000a000 <next_pid>
40000d80: d503201f     	nop
40000d84: 101c70a2     	adr	x2, 0x40039b98 <__bss_end>
40000d88: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000d8c: 9108c400     	add	x0, x0, #0x231
40000d90: cb010043     	sub	x3, x2, x1
40000d94: 94000cfe     	bl	0x4000418c <uart_printf>
40000d98: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000d9c: 911eb000     	add	x0, x0, #0x7ac
40000da0: d503201f     	nop
40000da4: 10246fe1     	adr	x1, 0x40049ba0 <__stack_top>
40000da8: 94000cf9     	bl	0x4000418c <uart_printf>
40000dac: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000db0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000db4: 913e7000     	add	x0, x0, #0xf9c
40000db8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000dbc: 14000be4     	b	0x40003d4c <uart_puts>

0000000040000dc0 <print_android_roadmap>:
40000dc0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000dc4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000dc8: 9135c400     	add	x0, x0, #0xd71
40000dcc: 910003fd     	mov	x29, sp
40000dd0: 94000bdf     	bl	0x40003d4c <uart_puts>
40000dd4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000dd8: 911a0000     	add	x0, x0, #0x680
40000ddc: 94000bdc     	bl	0x40003d4c <uart_puts>
40000de0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000de4: 9123ec00     	add	x0, x0, #0x8fb
40000de8: 94000bd9     	bl	0x40003d4c <uart_puts>
40000dec: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000df0: 91142000     	add	x0, x0, #0x508
40000df4: 94000bd6     	bl	0x40003d4c <uart_puts>
40000df8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000dfc: 91283000     	add	x0, x0, #0xa0c
40000e00: 94000bd3     	bl	0x40003d4c <uart_puts>
40000e04: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000e08: 91273000     	add	x0, x0, #0x9cc
40000e0c: 94000bd0     	bl	0x40003d4c <uart_puts>
40000e10: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000e14: 910f5800     	add	x0, x0, #0x3d6
40000e18: 94000bcd     	bl	0x40003d4c <uart_puts>
40000e1c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40000e20: 9105e400     	add	x0, x0, #0x179
40000e24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e28: 14000bc9     	b	0x40003d4c <uart_puts>

0000000040000e2c <read_line>:
40000e2c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40000e30: f9000bf7     	str	x23, [sp, #0x10]
40000e34: aa1f03f7     	mov	x23, xzr
40000e38: 910003fd     	mov	x29, sp
40000e3c: a90257f6     	stp	x22, x21, [sp, #0x20]
40000e40: d1000435     	sub	x21, x1, #0x1
40000e44: a9034ff4     	stp	x20, x19, [sp, #0x30]
40000e48: aa0003f3     	mov	x19, x0
40000e4c: b0000054     	adrp	x20, 0x40009000 <__rodata_start+0x3000>
40000e50: 910c4a94     	add	x20, x20, #0x312
40000e54: aa1703f6     	mov	x22, x23
40000e58: 94000bf0     	bl	0x40003e18 <uart_getc>
40000e5c: 12001c08     	and	w8, w0, #0xff
40000e60: 7100311f     	cmp	w8, #0xc
40000e64: 540000cc     	b.gt	0x40000e7c <read_line+0x50>
40000e68: 7100211f     	cmp	w8, #0x8
40000e6c: 54000240     	b.eq	0x40000eb4 <read_line+0x88>
40000e70: 7100291f     	cmp	w8, #0xa
40000e74: 540000c1     	b.ne	0x40000e8c <read_line+0x60>
40000e78: 14000015     	b	0x40000ecc <read_line+0xa0>
40000e7c: 7100351f     	cmp	w8, #0xd
40000e80: 54000260     	b.eq	0x40000ecc <read_line+0xa0>
40000e84: 7101fd1f     	cmp	w8, #0x7f
40000e88: 54000160     	b.eq	0x40000eb4 <read_line+0x88>
40000e8c: 51008008     	sub	w8, w0, #0x20
40000e90: 12001d08     	and	w8, w8, #0xff
40000e94: 7101791f     	cmp	w8, #0x5e
40000e98: 54fffe08     	b.hi	0x40000e58 <read_line+0x2c>
40000e9c: eb1502df     	cmp	x22, x21
40000ea0: 54fffdc2     	b.hs	0x40000e58 <read_line+0x2c>
40000ea4: 910006d7     	add	x23, x22, #0x1
40000ea8: 38366a60     	strb	w0, [x19, x22]
40000eac: 94000b91     	bl	0x40003cf0 <uart_putc>
40000eb0: 17ffffe9     	b	0x40000e54 <read_line+0x28>
40000eb4: aa1f03f7     	mov	x23, xzr
40000eb8: b4fffcf6     	cbz	x22, 0x40000e54 <read_line+0x28>
40000ebc: aa1403e0     	mov	x0, x20
40000ec0: d10006d7     	sub	x23, x22, #0x1
40000ec4: 94000ba2     	bl	0x40003d4c <uart_puts>
40000ec8: 17ffffe3     	b	0x40000e54 <read_line+0x28>
40000ecc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ed0: 911d0400     	add	x0, x0, #0x741
40000ed4: 94000b9e     	bl	0x40003d4c <uart_puts>
40000ed8: 38366a7f     	strb	wzr, [x19, x22]
40000edc: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000ee0: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000ee4: f9400bf7     	ldr	x23, [sp, #0x10]
40000ee8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000eec: d65f03c0     	ret

0000000040000ef0 <print_help>:
40000ef0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ef4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000ef8: 910e6000     	add	x0, x0, #0x398
40000efc: 910003fd     	mov	x29, sp
40000f00: 94000b93     	bl	0x40003d4c <uart_puts>
40000f04: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f08: 913f9000     	add	x0, x0, #0xfe4
40000f0c: 94000b90     	bl	0x40003d4c <uart_puts>
40000f10: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f14: 9132cc00     	add	x0, x0, #0xcb3
40000f18: 94000b8d     	bl	0x40003d4c <uart_puts>
40000f1c: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f20: 91031400     	add	x0, x0, #0xc5
40000f24: 94000b8a     	bl	0x40003d4c <uart_puts>
40000f28: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f2c: 91107400     	add	x0, x0, #0x41d
40000f30: 94000b87     	bl	0x40003d4c <uart_puts>
40000f34: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f38: 9133bc00     	add	x0, x0, #0xcef
40000f3c: 94000b84     	bl	0x40003d4c <uart_puts>
40000f40: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f44: 91239000     	add	x0, x0, #0x8e4
40000f48: 94000b81     	bl	0x40003d4c <uart_puts>
40000f4c: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000f50: 91294000     	add	x0, x0, #0xa50
40000f54: 94000b7e     	bl	0x40003d4c <uart_puts>
40000f58: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40000f5c: 91071000     	add	x0, x0, #0x1c4
40000f60: 94000b7b     	bl	0x40003d4c <uart_puts>
40000f64: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000f68: 91295c00     	add	x0, x0, #0xa57
40000f6c: 94000b78     	bl	0x40003d4c <uart_puts>
40000f70: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f74: 913fe400     	add	x0, x0, #0xff9
40000f78: 94000b75     	bl	0x40003d4c <uart_puts>
40000f7c: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40000f80: 91082800     	add	x0, x0, #0x20a
40000f84: 94000b72     	bl	0x40003d4c <uart_puts>
40000f88: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000f8c: 9100e800     	add	x0, x0, #0x3a
40000f90: 94000b6f     	bl	0x40003d4c <uart_puts>
40000f94: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000f98: 91119800     	add	x0, x0, #0x466
40000f9c: 94000b6c     	bl	0x40003d4c <uart_puts>
40000fa0: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000fa4: 91051c00     	add	x0, x0, #0x147
40000fa8: 94000b69     	bl	0x40003d4c <uart_puts>
40000fac: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000fb0: 9136a400     	add	x0, x0, #0xda9
40000fb4: 94000b66     	bl	0x40003d4c <uart_puts>
40000fb8: d0000020     	adrp	x0, 0x40006000 <__rodata_start>
40000fbc: 9134d000     	add	x0, x0, #0xd34
40000fc0: 94000b63     	bl	0x40003d4c <uart_puts>
40000fc4: 90000040     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40000fc8: 911b0400     	add	x0, x0, #0x6c1
40000fcc: 94000b60     	bl	0x40003d4c <uart_puts>
40000fd0: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000fd4: 91242c00     	add	x0, x0, #0x90b
40000fd8: 94000b5d     	bl	0x40003d4c <uart_puts>
40000fdc: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000fe0: 91399c00     	add	x0, x0, #0xe67
40000fe4: 94000b5a     	bl	0x40003d4c <uart_puts>
40000fe8: b0000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40000fec: 910c8400     	add	x0, x0, #0x321
40000ff0: 94000b57     	bl	0x40003d4c <uart_puts>
40000ff4: f0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40000ff8: 91306c00     	add	x0, x0, #0xc1b
40000ffc: 94000b54     	bl	0x40003d4c <uart_puts>
40001000: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001004: 910d0400     	add	x0, x0, #0x341
40001008: 94000b51     	bl	0x40003d4c <uart_puts>
4000100c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001010: 91286800     	add	x0, x0, #0xa1a
40001014: 94000b4e     	bl	0x40003d4c <uart_puts>
40001018: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000101c: 91378800     	add	x0, x0, #0xde2
40001020: 94000b4b     	bl	0x40003d4c <uart_puts>
40001024: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001028: 9101f000     	add	x0, x0, #0x7c
4000102c: 94000b48     	bl	0x40003d4c <uart_puts>
40001030: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001034: 9105e400     	add	x0, x0, #0x179
40001038: 94000b45     	bl	0x40003d4c <uart_puts>
4000103c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001040: 912a2c00     	add	x0, x0, #0xa8b
40001044: 94000b42     	bl	0x40003d4c <uart_puts>
40001048: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000104c: 91317c00     	add	x0, x0, #0xc5f
40001050: 94000b3f     	bl	0x40003d4c <uart_puts>
40001054: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001058: 9106d400     	add	x0, x0, #0x1b5
4000105c: 94000b3c     	bl	0x40003d4c <uart_puts>
40001060: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001064: 91159c00     	add	x0, x0, #0x567
40001068: 94000b39     	bl	0x40003d4c <uart_puts>
4000106c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001070: 91169c00     	add	x0, x0, #0x5a7
40001074: 94000b36     	bl	0x40003d4c <uart_puts>
40001078: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
4000107c: 910da800     	add	x0, x0, #0x36a
40001080: 94000b33     	bl	0x40003d4c <uart_puts>
40001084: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001088: 912b0800     	add	x0, x0, #0xac2
4000108c: 94000b30     	bl	0x40003d4c <uart_puts>
40001090: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001094: 91124800     	add	x0, x0, #0x492
40001098: 94000b2d     	bl	0x40003d4c <uart_puts>
4000109c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400010a0: 9107d000     	add	x0, x0, #0x1f4
400010a4: 94000b2a     	bl	0x40003d4c <uart_puts>
400010a8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400010ac: 91389000     	add	x0, x0, #0xe24
400010b0: 94000b27     	bl	0x40003d4c <uart_puts>
400010b4: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400010b8: 91041c00     	add	x0, x0, #0x107
400010bc: 94000b24     	bl	0x40003d4c <uart_puts>
400010c0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400010c4: 913ac400     	add	x0, x0, #0xeb1
400010c8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400010cc: 14000b20     	b	0x40003d4c <uart_puts>

00000000400010d0 <execute_command>:
400010d0: d104c3ff     	sub	sp, sp, #0x130
400010d4: a9124ff4     	stp	x20, x19, [sp, #0x120]
400010d8: aa0003f3     	mov	x19, x0
400010dc: aa1f03e8     	mov	x8, xzr
400010e0: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
400010e4: 910383fd     	add	x29, sp, #0xe0
400010e8: f9007bfc     	str	x28, [sp, #0xf0]
400010ec: a9105ff8     	stp	x24, x23, [sp, #0x100]
400010f0: a91157f6     	stp	x22, x21, [sp, #0x110]
400010f4: 38686a6a     	ldrb	w10, [x19, x8]
400010f8: 91000508     	add	x8, x8, #0x1
400010fc: 7100815f     	cmp	w10, #0x20
40001100: 54ffffa0     	b.eq	0x400010f4 <execute_command+0x24>
40001104: aa1f03e9     	mov	x9, xzr
40001108: d10083ab     	sub	x11, x29, #0x20
4000110c: 340001aa     	cbz	w10, 0x40001140 <execute_command+0x70>
40001110: f100793f     	cmp	x9, #0x1e
40001114: 54000168     	b.hi	0x40001140 <execute_command+0x70>
40001118: 8b09026c     	add	x12, x19, x9
4000111c: 3829696a     	strb	w10, [x11, x9]
40001120: 3868698a     	ldrb	w10, [x12, x8]
40001124: 9100052c     	add	x12, x9, #0x1
40001128: aa0c03e9     	mov	x9, x12
4000112c: 7100815f     	cmp	w10, #0x20
40001130: 54fffee1     	b.ne	0x4000110c <execute_command+0x3c>
40001134: 8b0c0108     	add	x8, x8, x12
40001138: aa0c03e9     	mov	x9, x12
4000113c: 14000002     	b	0x40001144 <execute_command+0x74>
40001140: 8b090108     	add	x8, x8, x9
40001144: d1000508     	sub	x8, x8, #0x1
40001148: d10083aa     	sub	x10, x29, #0x20
4000114c: 8b080268     	add	x8, x19, x8
40001150: 3829695f     	strb	wzr, [x10, x9]
40001154: 38401509     	ldrb	w9, [x8], #0x1
40001158: 7100813f     	cmp	w9, #0x20
4000115c: 54ffffc0     	b.eq	0x40001154 <execute_command+0x84>
40001160: 35000069     	cbnz	w9, 0x4000116c <execute_command+0x9c>
40001164: aa1f03ec     	mov	x12, xzr
40001168: 1400000a     	b	0x40001190 <execute_command+0xc0>
4000116c: aa1f03ea     	mov	x10, xzr
40001170: 910103eb     	add	x11, sp, #0x40
40001174: 382a6969     	strb	w9, [x11, x10]
40001178: 386a6909     	ldrb	w9, [x8, x10]
4000117c: 9100054c     	add	x12, x10, #0x1
40001180: 34000089     	cbz	w9, 0x40001190 <execute_command+0xc0>
40001184: f101f95f     	cmp	x10, #0x7e
40001188: aa0c03ea     	mov	x10, x12
4000118c: 54ffff43     	b.lo	0x40001174 <execute_command+0xa4>
40001190: 910103e8     	add	x8, sp, #0x40
40001194: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001198: 9109e421     	add	x1, x1, #0x279
4000119c: d10083a0     	sub	x0, x29, #0x20
400011a0: 382c691f     	strb	wzr, [x8, x12]
400011a4: 94000725     	bl	0x40002e38 <kstrcmp>
400011a8: 34001840     	cbz	w0, 0x400014b0 <execute_command+0x3e0>
400011ac: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400011b0: 913d8c21     	add	x1, x1, #0xf63
400011b4: d10083a0     	sub	x0, x29, #0x20
400011b8: 94000720     	bl	0x40002e38 <kstrcmp>
400011bc: 340017e0     	cbz	w0, 0x400014b8 <execute_command+0x3e8>
400011c0: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400011c4: 9124f821     	add	x1, x1, #0x93e
400011c8: d10083a0     	sub	x0, x29, #0x20
400011cc: 9400071b     	bl	0x40002e38 <kstrcmp>
400011d0: 34001ac0     	cbz	w0, 0x40001528 <execute_command+0x458>
400011d4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400011d8: 911c0421     	add	x1, x1, #0x701
400011dc: d10083a0     	sub	x0, x29, #0x20
400011e0: 94000716     	bl	0x40002e38 <kstrcmp>
400011e4: 34001c40     	cbz	w0, 0x4000156c <execute_command+0x49c>
400011e8: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400011ec: 910efc21     	add	x1, x1, #0x3bf
400011f0: d10083a0     	sub	x0, x29, #0x20
400011f4: 94000711     	bl	0x40002e38 <kstrcmp>
400011f8: 34001be0     	cbz	w0, 0x40001574 <execute_command+0x4a4>
400011fc: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001200: 91355c21     	add	x1, x1, #0xd57
40001204: d10083a0     	sub	x0, x29, #0x20
40001208: 9400070c     	bl	0x40002e38 <kstrcmp>
4000120c: 34001ce0     	cbz	w0, 0x400015a8 <execute_command+0x4d8>
40001210: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001214: 910f0821     	add	x1, x1, #0x3c2
40001218: d10083a0     	sub	x0, x29, #0x20
4000121c: 94000707     	bl	0x40002e38 <kstrcmp>
40001220: 34001be0     	cbz	w0, 0x4000159c <execute_command+0x4cc>
40001224: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001228: 91251821     	add	x1, x1, #0x946
4000122c: d10083a0     	sub	x0, x29, #0x20
40001230: 94000702     	bl	0x40002e38 <kstrcmp>
40001234: 34001b40     	cbz	w0, 0x4000159c <execute_command+0x4cc>
40001238: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000123c: 9109f821     	add	x1, x1, #0x27e
40001240: d10083a0     	sub	x0, x29, #0x20
40001244: 940006fd     	bl	0x40002e38 <kstrcmp>
40001248: 34001d40     	cbz	w0, 0x400015f0 <execute_command+0x520>
4000124c: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001250: 91236021     	add	x1, x1, #0x8d8
40001254: d10083a0     	sub	x0, x29, #0x20
40001258: 940006f8     	bl	0x40002e38 <kstrcmp>
4000125c: 34001d00     	cbz	w0, 0x400015fc <execute_command+0x52c>
40001260: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001264: 9101a421     	add	x1, x1, #0x69
40001268: d10083a0     	sub	x0, x29, #0x20
4000126c: 940006f3     	bl	0x40002e38 <kstrcmp>
40001270: 34001d00     	cbz	w0, 0x40001610 <execute_command+0x540>
40001274: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001278: 913e7821     	add	x1, x1, #0xf9e
4000127c: d10083a0     	sub	x0, x29, #0x20
40001280: 940006ee     	bl	0x40002e38 <kstrcmp>
40001284: 34001c20     	cbz	w0, 0x40001608 <execute_command+0x538>
40001288: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000128c: 910fb021     	add	x1, x1, #0x3ec
40001290: d10083a0     	sub	x0, x29, #0x20
40001294: 940006e9     	bl	0x40002e38 <kstrcmp>
40001298: 34001b80     	cbz	w0, 0x40001608 <execute_command+0x538>
4000129c: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400012a0: 9104e021     	add	x1, x1, #0x138
400012a4: d10083a0     	sub	x0, x29, #0x20
400012a8: 940006e4     	bl	0x40002e38 <kstrcmp>
400012ac: 34001c40     	cbz	w0, 0x40001634 <execute_command+0x564>
400012b0: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400012b4: 911f4021     	add	x1, x1, #0x7d0
400012b8: d10083a0     	sub	x0, x29, #0x20
400012bc: 940006df     	bl	0x40002e38 <kstrcmp>
400012c0: 34001be0     	cbz	w0, 0x4000163c <execute_command+0x56c>
400012c4: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x3000>
400012c8: 91093421     	add	x1, x1, #0x24d
400012cc: d10083a0     	sub	x0, x29, #0x20
400012d0: 940006da     	bl	0x40002e38 <kstrcmp>
400012d4: 34001d80     	cbz	w0, 0x40001684 <execute_command+0x5b4>
400012d8: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400012dc: 91179021     	add	x1, x1, #0x5e4
400012e0: d10083a0     	sub	x0, x29, #0x20
400012e4: 940006d5     	bl	0x40002e38 <kstrcmp>
400012e8: 34001e60     	cbz	w0, 0x400016b4 <execute_command+0x5e4>
400012ec: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400012f0: 91026821     	add	x1, x1, #0x9a
400012f4: d10083a0     	sub	x0, x29, #0x20
400012f8: 940006d0     	bl	0x40002e38 <kstrcmp>
400012fc: 340020a0     	cbz	w0, 0x40001710 <execute_command+0x640>
40001300: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001304: 910a9821     	add	x1, x1, #0x2a6
40001308: d10083a0     	sub	x0, x29, #0x20
4000130c: 940006cb     	bl	0x40002e38 <kstrcmp>
40001310: 34002360     	cbz	w0, 0x4000177c <execute_command+0x6ac>
40001314: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001318: 91028421     	add	x1, x1, #0xa1
4000131c: d10083a0     	sub	x0, x29, #0x20
40001320: 940006c6     	bl	0x40002e38 <kstrcmp>
40001324: 34002100     	cbz	w0, 0x40001744 <execute_command+0x674>
40001328: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000132c: 912a5021     	add	x1, x1, #0xa94
40001330: d10083a0     	sub	x0, x29, #0x20
40001334: 940006c1     	bl	0x40002e38 <kstrcmp>
40001338: 34002060     	cbz	w0, 0x40001744 <execute_command+0x674>
4000133c: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001340: 911f3021     	add	x1, x1, #0x7cc
40001344: d10083a0     	sub	x0, x29, #0x20
40001348: 940006bc     	bl	0x40002e38 <kstrcmp>
4000134c: 340023c0     	cbz	w0, 0x400017c4 <execute_command+0x6f4>
40001350: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001354: 910f2421     	add	x1, x1, #0x3c9
40001358: d10083a0     	sub	x0, x29, #0x20
4000135c: 940006b7     	bl	0x40002e38 <kstrcmp>
40001360: 34002480     	cbz	w0, 0x400017f0 <execute_command+0x720>
40001364: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001368: 912e7021     	add	x1, x1, #0xb9c
4000136c: d10083a0     	sub	x0, x29, #0x20
40001370: 940006b2     	bl	0x40002e38 <kstrcmp>
40001374: 34002620     	cbz	w0, 0x40001838 <execute_command+0x768>
40001378: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000137c: 913c7821     	add	x1, x1, #0xf1e
40001380: d10083a0     	sub	x0, x29, #0x20
40001384: 940006ad     	bl	0x40002e38 <kstrcmp>
40001388: 340026c0     	cbz	w0, 0x40001860 <execute_command+0x790>
4000138c: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001390: 912ce021     	add	x1, x1, #0xb38
40001394: d10083a0     	sub	x0, x29, #0x20
40001398: 940006a8     	bl	0x40002e38 <kstrcmp>
4000139c: 34002800     	cbz	w0, 0x4000189c <execute_command+0x7cc>
400013a0: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400013a4: 910b4421     	add	x1, x1, #0x2d1
400013a8: d10083a0     	sub	x0, x29, #0x20
400013ac: 940006a3     	bl	0x40002e38 <kstrcmp>
400013b0: 34002a00     	cbz	w0, 0x400018f0 <execute_command+0x820>
400013b4: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400013b8: 912ca021     	add	x1, x1, #0xb28
400013bc: d10083a0     	sub	x0, x29, #0x20
400013c0: 9400069e     	bl	0x40002e38 <kstrcmp>
400013c4: 340028e0     	cbz	w0, 0x400018e0 <execute_command+0x810>
400013c8: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400013cc: 912cf821     	add	x1, x1, #0xb3e
400013d0: d10083a0     	sub	x0, x29, #0x20
400013d4: 94000699     	bl	0x40002e38 <kstrcmp>
400013d8: 34002840     	cbz	w0, 0x400018e0 <execute_command+0x810>
400013dc: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400013e0: 912a6021     	add	x1, x1, #0xa98
400013e4: d10083a0     	sub	x0, x29, #0x20
400013e8: 94000694     	bl	0x40002e38 <kstrcmp>
400013ec: 34002d80     	cbz	w0, 0x4000199c <execute_command+0x8cc>
400013f0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400013f4: 912a6c21     	add	x1, x1, #0xa9b
400013f8: d10083a0     	sub	x0, x29, #0x20
400013fc: 9400068f     	bl	0x40002e38 <kstrcmp>
40001400: 34002ce0     	cbz	w0, 0x4000199c <execute_command+0x8cc>
40001404: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001408: 913c9021     	add	x1, x1, #0xf24
4000140c: d10083a0     	sub	x0, x29, #0x20
40001410: 9400068a     	bl	0x40002e38 <kstrcmp>
40001414: 34002de0     	cbz	w0, 0x400019d0 <execute_command+0x900>
40001418: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
4000141c: 91253021     	add	x1, x1, #0x94c
40001420: d10083a0     	sub	x0, x29, #0x20
40001424: 94000685     	bl	0x40002e38 <kstrcmp>
40001428: 34002d40     	cbz	w0, 0x400019d0 <execute_command+0x900>
4000142c: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001430: 9129e821     	add	x1, x1, #0xa7a
40001434: d10083a0     	sub	x0, x29, #0x20
40001438: 94000680     	bl	0x40002e38 <kstrcmp>
4000143c: 34002e80     	cbz	w0, 0x40001a0c <execute_command+0x93c>
40001440: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001444: 91158021     	add	x1, x1, #0x560
40001448: d10083a0     	sub	x0, x29, #0x20
4000144c: 9400067b     	bl	0x40002e38 <kstrcmp>
40001450: 34003460     	cbz	w0, 0x40001adc <execute_command+0xa0c>
40001454: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x3000>
40001458: 910c5821     	add	x1, x1, #0x316
4000145c: d10083a0     	sub	x0, x29, #0x20
40001460: 94000676     	bl	0x40002e38 <kstrcmp>
40001464: 340032c0     	cbz	w0, 0x40001abc <execute_command+0x9ec>
40001468: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000146c: 913ec421     	add	x1, x1, #0xfb1
40001470: d10083a0     	sub	x0, x29, #0x20
40001474: 94000671     	bl	0x40002e38 <kstrcmp>
40001478: 34003220     	cbz	w0, 0x40001abc <execute_command+0x9ec>
4000147c: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001480: 910afc21     	add	x1, x1, #0x2bf
40001484: d10083a0     	sub	x0, x29, #0x20
40001488: 9400066c     	bl	0x40002e38 <kstrcmp>
4000148c: 34003180     	cbz	w0, 0x40001abc <execute_command+0x9ec>
40001490: d10083a0     	sub	x0, x29, #0x20
40001494: 910103e1     	add	x1, sp, #0x40
40001498: 94000279     	bl	0x40001e7c <kpkg_try_run>
4000149c: 35000be0     	cbnz	w0, 0x40001618 <execute_command+0x548>
400014a0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400014a4: 913ed800     	add	x0, x0, #0xfb6
400014a8: d10083a1     	sub	x1, x29, #0x20
400014ac: 140000ba     	b	0x40001794 <execute_command+0x6c4>
400014b0: 97fffe90     	bl	0x40000ef0 <print_help>
400014b4: 14000059     	b	0x40001618 <execute_command+0x548>
400014b8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400014bc: 910c7c00     	add	x0, x0, #0x31f
400014c0: 94000a23     	bl	0x40003d4c <uart_puts>
400014c4: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400014c8: 91389c00     	add	x0, x0, #0xe27
400014cc: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400014d0: 91291421     	add	x1, x1, #0xa45
400014d4: 94000b2e     	bl	0x4000418c <uart_printf>
400014d8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400014dc: 913f2c00     	add	x0, x0, #0xfcb
400014e0: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400014e4: 9122fc21     	add	x1, x1, #0x8bf
400014e8: 94000b29     	bl	0x4000418c <uart_printf>
400014ec: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400014f0: 912e0c00     	add	x0, x0, #0xb83
400014f4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400014f8: 9128d021     	add	x1, x1, #0xa34
400014fc: 94000b24     	bl	0x4000418c <uart_printf>
40001500: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001504: 9134c400     	add	x0, x0, #0xd31
40001508: 94000a11     	bl	0x40003d4c <uart_puts>
4000150c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001510: 9131cc00     	add	x0, x0, #0xc73
40001514: 94000a0e     	bl	0x40003d4c <uart_puts>
40001518: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000151c: 913e7000     	add	x0, x0, #0xf9c
40001520: 94000a0b     	bl	0x40003d4c <uart_puts>
40001524: 1400003d     	b	0x40001618 <execute_command+0x548>
40001528: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000152c: 912ba000     	add	x0, x0, #0xae8
40001530: 94000a07     	bl	0x40003d4c <uart_puts>
40001534: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001538: 910dd000     	add	x0, x0, #0x374
4000153c: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001540: 9122fc21     	add	x1, x1, #0x8bf
40001544: 94000b12     	bl	0x4000418c <uart_printf>
40001548: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000154c: 91096c00     	add	x0, x0, #0x25b
40001550: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001554: 9128d021     	add	x1, x1, #0xa34
40001558: 94000b0d     	bl	0x4000418c <uart_printf>
4000155c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001560: 9108c000     	add	x0, x0, #0x230
40001564: 940009fa     	bl	0x40003d4c <uart_puts>
40001568: 1400002c     	b	0x40001618 <execute_command+0x548>
4000156c: 97fffdc3     	bl	0x40000c78 <print_sysinfo>
40001570: 1400002a     	b	0x40001618 <execute_command+0x548>
40001574: 910103e0     	add	x0, sp, #0x40
40001578: 94000620     	bl	0x40002df8 <kstrlen>
4000157c: b4000220     	cbz	x0, 0x400015c0 <execute_command+0x4f0>
40001580: 910103e0     	add	x0, sp, #0x40
40001584: 9400105a     	bl	0x400056ec <vfs_remove>
40001588: 34000240     	cbz	w0, 0x400015d0 <execute_command+0x500>
4000158c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001590: 913e1000     	add	x0, x0, #0xf84
40001594: 940009ee     	bl	0x40003d4c <uart_puts>
40001598: 14000020     	b	0x40001618 <execute_command+0x548>
4000159c: 910103e0     	add	x0, sp, #0x40
400015a0: 940002a7     	bl	0x4000203c <kpy_execute>
400015a4: 1400001d     	b	0x40001618 <execute_command+0x548>
400015a8: 910103e0     	add	x0, sp, #0x40
400015ac: 94000613     	bl	0x40002df8 <kstrlen>
400015b0: b4000180     	cbz	x0, 0x400015e0 <execute_command+0x510>
400015b4: 910103e0     	add	x0, sp, #0x40
400015b8: 97fffbe8     	bl	0x40000558 <launch_kedit>
400015bc: 14000017     	b	0x40001618 <execute_command+0x548>
400015c0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400015c4: 91251800     	add	x0, x0, #0x946
400015c8: 940009e1     	bl	0x40003d4c <uart_puts>
400015cc: 14000013     	b	0x40001618 <execute_command+0x548>
400015d0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400015d4: 91155800     	add	x0, x0, #0x556
400015d8: 940009dd     	bl	0x40003d4c <uart_puts>
400015dc: 1400000f     	b	0x40001618 <execute_command+0x548>
400015e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400015e4: 9112fc00     	add	x0, x0, #0x4bf
400015e8: 940009d9     	bl	0x40003d4c <uart_puts>
400015ec: 1400000b     	b	0x40001618 <execute_command+0x548>
400015f0: 910103e0     	add	x0, sp, #0x40
400015f4: 94000203     	bl	0x40001e00 <kimg_execute>
400015f8: 14000008     	b	0x40001618 <execute_command+0x548>
400015fc: 910103e0     	add	x0, sp, #0x40
40001600: 9400023d     	bl	0x40001ef4 <kproj_execute>
40001604: 14000005     	b	0x40001618 <execute_command+0x548>
40001608: 940006fc     	bl	0x400031f8 <tui_launch>
4000160c: 14000003     	b	0x40001618 <execute_command+0x548>
40001610: 910103e0     	add	x0, sp, #0x40
40001614: 94000217     	bl	0x40001e70 <kpkg_execute>
40001618: a9524ff4     	ldp	x20, x19, [sp, #0x120]
4000161c: f9407bfc     	ldr	x28, [sp, #0xf0]
40001620: a95157f6     	ldp	x22, x21, [sp, #0x110]
40001624: a9505ff8     	ldp	x24, x23, [sp, #0x100]
40001628: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
4000162c: 9104c3ff     	add	sp, sp, #0x130
40001630: d65f03c0     	ret
40001634: 9400039c     	bl	0x400024a4 <launch_ktop>
40001638: 17fffff8     	b	0x40001618 <execute_command+0x548>
4000163c: 910103e0     	add	x0, sp, #0x40
40001640: 940005ee     	bl	0x40002df8 <kstrlen>
40001644: b40004c0     	cbz	x0, 0x400016dc <execute_command+0x60c>
40001648: 394103e8     	ldrb	w8, [sp, #0x40]
4000164c: 5100c109     	sub	w9, w8, #0x30
40001650: 7100253f     	cmp	w9, #0x9
40001654: 540004c8     	b.hi	0x400016ec <execute_command+0x61c>
40001658: 910103e9     	add	x9, sp, #0x40
4000165c: 2a1f03f3     	mov	w19, wzr
40001660: 5280014a     	mov	w10, #0xa               // =10
40001664: b2400129     	orr	x9, x9, #0x1
40001668: 1b0a226b     	madd	w11, w19, w10, w8
4000166c: 38401528     	ldrb	w8, [x9], #0x1
40001670: 5100c10c     	sub	w12, w8, #0x30
40001674: 7100299f     	cmp	w12, #0xa
40001678: 5100c173     	sub	w19, w11, #0x30
4000167c: 54ffff63     	b.lo	0x40001668 <execute_command+0x598>
40001680: 1400001c     	b	0x400016f0 <execute_command+0x620>
40001684: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001688: 91357421     	add	x1, x1, #0xd5d
4000168c: aa1303e0     	mov	x0, x19
40001690: 940006a1     	bl	0x40003114 <kstrstr>
40001694: b4000460     	cbz	x0, 0x40001720 <execute_command+0x650>
40001698: 3900001f     	strb	wzr, [x0]
4000169c: 38401c08     	ldrb	w8, [x0, #0x1]!
400016a0: 7100811f     	cmp	w8, #0x20
400016a4: 54ffffc0     	b.eq	0x4000169c <execute_command+0x5cc>
400016a8: 91001661     	add	x1, x19, #0x5
400016ac: 9400100f     	bl	0x400056e8 <vfs_write_file>
400016b0: 17ffffda     	b	0x40001618 <execute_command+0x548>
400016b4: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400016b8: 91252421     	add	x1, x1, #0x949
400016bc: 910103e0     	add	x0, sp, #0x40
400016c0: 940005de     	bl	0x40002e38 <kstrcmp>
400016c4: 340006c0     	cbz	w0, 0x4000179c <execute_command+0x6cc>
400016c8: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400016cc: 91260c00     	add	x0, x0, #0x983
400016d0: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400016d4: 91291421     	add	x1, x1, #0xa45
400016d8: 1400002f     	b	0x40001794 <execute_command+0x6c4>
400016dc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400016e0: 91329400     	add	x0, x0, #0xca5
400016e4: 9400099a     	bl	0x40003d4c <uart_puts>
400016e8: 17ffffcc     	b	0x40001618 <execute_command+0x548>
400016ec: 2a1f03f3     	mov	w19, wzr
400016f0: 2a1303e0     	mov	w0, w19
400016f4: 940002d7     	bl	0x40002250 <process_kill>
400016f8: 3100041f     	cmn	w0, #0x1
400016fc: 540001a0     	b.eq	0x40001730 <execute_command+0x660>
40001700: 35fff8c0     	cbnz	w0, 0x40001618 <execute_command+0x548>
40001704: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001708: 912e2400     	add	x0, x0, #0xb89
4000170c: 1400000b     	b	0x40001738 <execute_command+0x668>
40001710: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001714: 912e7400     	add	x0, x0, #0xb9d
40001718: 9400098d     	bl	0x40003d4c <uart_puts>
4000171c: 17ffffbf     	b	0x40001618 <execute_command+0x548>
40001720: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001724: 91260c00     	add	x0, x0, #0x983
40001728: 910103e1     	add	x1, sp, #0x40
4000172c: 1400001a     	b	0x40001794 <execute_command+0x6c4>
40001730: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001734: 91257000     	add	x0, x0, #0x95c
40001738: 2a1303e1     	mov	w1, w19
4000173c: 94000a94     	bl	0x4000418c <uart_printf>
40001740: 17ffffb6     	b	0x40001618 <execute_command+0x548>
40001744: 94000e00     	bl	0x40004f44 <vfs_get_cwd>
40001748: aa0003f3     	mov	x19, x0
4000174c: 910103e0     	add	x0, sp, #0x40
40001750: 940005aa     	bl	0x40002df8 <kstrlen>
40001754: b40000e0     	cbz	x0, 0x40001770 <execute_command+0x6a0>
40001758: 910103e0     	add	x0, sp, #0x40
4000175c: 94000e68     	bl	0x400050fc <vfs_find>
40001760: b4000400     	cbz	x0, 0x400017e0 <execute_command+0x710>
40001764: b9402008     	ldr	w8, [x0, #0x20]
40001768: aa0003f3     	mov	x19, x0
4000176c: 340005a8     	cbz	w8, 0x40001820 <execute_command+0x750>
40001770: aa1303e0     	mov	x0, x19
40001774: 94001017     	bl	0x400057d0 <vfs_list_dir>
40001778: 17ffffa8     	b	0x40001618 <execute_command+0x548>
4000177c: 910003e0     	mov	x0, sp
40001780: 52800801     	mov	w1, #0x40               // =64
40001784: 94000df3     	bl	0x40004f50 <vfs_getcwd>
40001788: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000178c: 91260c00     	add	x0, x0, #0x983
40001790: 910003e1     	mov	x1, sp
40001794: 94000a7e     	bl	0x4000418c <uart_printf>
40001798: 17ffffa0     	b	0x40001618 <execute_command+0x548>
4000179c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400017a0: 912c2400     	add	x0, x0, #0xb09
400017a4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400017a8: 91291421     	add	x1, x1, #0xa45
400017ac: b0000022     	adrp	x2, 0x40006000 <__rodata_start>
400017b0: 9122fc42     	add	x2, x2, #0x8bf
400017b4: f0000023     	adrp	x3, 0x40008000 <__rodata_start+0x2000>
400017b8: 9128d063     	add	x3, x3, #0xa34
400017bc: 94000a74     	bl	0x4000418c <uart_printf>
400017c0: 17ffff96     	b	0x40001618 <execute_command+0x548>
400017c4: 910103e0     	add	x0, sp, #0x40
400017c8: 94000eb2     	bl	0x40005290 <vfs_chdir>
400017cc: 34fff260     	cbz	w0, 0x40001618 <execute_command+0x548>
400017d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400017d4: 91295800     	add	x0, x0, #0xa56
400017d8: 910103e1     	add	x1, sp, #0x40
400017dc: 17ffffee     	b	0x40001794 <execute_command+0x6c4>
400017e0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400017e4: 9132e000     	add	x0, x0, #0xcb8
400017e8: 910103e1     	add	x1, sp, #0x40
400017ec: 17ffffea     	b	0x40001794 <execute_command+0x6c4>
400017f0: 910103e0     	add	x0, sp, #0x40
400017f4: 94000581     	bl	0x40002df8 <kstrlen>
400017f8: b40004a0     	cbz	x0, 0x4000188c <execute_command+0x7bc>
400017fc: 910103e0     	add	x0, sp, #0x40
40001800: 94000e3f     	bl	0x400050fc <vfs_find>
40001804: b4000060     	cbz	x0, 0x40001810 <execute_command+0x740>
40001808: b9402008     	ldr	w8, [x0, #0x20]
4000180c: 34000ae8     	cbz	w8, 0x40001968 <execute_command+0x898>
40001810: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001814: 910f3400     	add	x0, x0, #0x3cd
40001818: 9400094d     	bl	0x40003d4c <uart_puts>
4000181c: 17ffff7f     	b	0x40001618 <execute_command+0x548>
40001820: b9402a61     	ldr	w1, [x19, #0x28]
40001824: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001828: 913c1800     	add	x0, x0, #0xf06
4000182c: aa1303e2     	mov	x2, x19
40001830: 94000a57     	bl	0x4000418c <uart_printf>
40001834: 17ffff79     	b	0x40001618 <execute_command+0x548>
40001838: 910103e0     	add	x0, sp, #0x40
4000183c: 9400056f     	bl	0x40002df8 <kstrlen>
40001840: b4000480     	cbz	x0, 0x400018d0 <execute_command+0x800>
40001844: 910103e0     	add	x0, sp, #0x40
40001848: 94000eb7     	bl	0x40005324 <vfs_mkdir>
4000184c: 34ffee60     	cbz	w0, 0x40001618 <execute_command+0x548>
40001850: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001854: 912f1800     	add	x0, x0, #0xbc6
40001858: 9400093d     	bl	0x40003d4c <uart_puts>
4000185c: 17ffff6f     	b	0x40001618 <execute_command+0x548>
40001860: 910103e0     	add	x0, sp, #0x40
40001864: 94000565     	bl	0x40002df8 <kstrlen>
40001868: b40008a0     	cbz	x0, 0x4000197c <execute_command+0x8ac>
4000186c: 910103e0     	add	x0, sp, #0x40
40001870: aa1f03e1     	mov	x1, xzr
40001874: 94000f02     	bl	0x4000547c <vfs_touch>
40001878: 34ffed00     	cbz	w0, 0x40001618 <execute_command+0x548>
4000187c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001880: 913e8800     	add	x0, x0, #0xfa2
40001884: 94000932     	bl	0x40003d4c <uart_puts>
40001888: 17ffff64     	b	0x40001618 <execute_command+0x548>
4000188c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001890: 91395c00     	add	x0, x0, #0xe57
40001894: 9400092e     	bl	0x40003d4c <uart_puts>
40001898: 17ffff60     	b	0x40001618 <execute_command+0x548>
4000189c: 910103e0     	add	x0, sp, #0x40
400018a0: 52800401     	mov	w1, #0x20               // =32
400018a4: 94000637     	bl	0x40003180 <kstrchr>
400018a8: b4000720     	cbz	x0, 0x4000198c <execute_command+0x8bc>
400018ac: aa0003e1     	mov	x1, x0
400018b0: 910103e0     	add	x0, sp, #0x40
400018b4: 3800143f     	strb	wzr, [x1], #0x1
400018b8: 94000f8c     	bl	0x400056e8 <vfs_write_file>
400018bc: 34ffeae0     	cbz	w0, 0x40001618 <execute_command+0x548>
400018c0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
400018c4: 9117a800     	add	x0, x0, #0x5ea
400018c8: 94000921     	bl	0x40003d4c <uart_puts>
400018cc: 17ffff53     	b	0x40001618 <execute_command+0x548>
400018d0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400018d4: 9133d000     	add	x0, x0, #0xcf4
400018d8: 9400091d     	bl	0x40003d4c <uart_puts>
400018dc: 17ffff4f     	b	0x40001618 <execute_command+0x548>
400018e0: d503201f     	nop
400018e4: 10030700     	adr	x0, 0x400079c4 <__rodata_start+0x19c4>
400018e8: 94000919     	bl	0x40003d4c <uart_puts>
400018ec: 17ffff4b     	b	0x40001618 <execute_command+0x548>
400018f0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400018f4: 913e7000     	add	x0, x0, #0xf9c
400018f8: 94000915     	bl	0x40003d4c <uart_puts>
400018fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001900: 91237800     	add	x0, x0, #0x8de
40001904: 94000912     	bl	0x40003d4c <uart_puts>
40001908: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
4000190c: 9101b800     	add	x0, x0, #0x6e
40001910: 9400090f     	bl	0x40003d4c <uart_puts>
40001914: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001918: 911c2400     	add	x0, x0, #0x709
4000191c: 9400090c     	bl	0x40003d4c <uart_puts>
40001920: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001924: 9117e400     	add	x0, x0, #0x5f9
40001928: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000192c: 9128d021     	add	x1, x1, #0xa34
40001930: 94000a17     	bl	0x4000418c <uart_printf>
40001934: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001938: 91029000     	add	x0, x0, #0xa4
4000193c: 94000904     	bl	0x40003d4c <uart_puts>
40001940: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40001944: 91094800     	add	x0, x0, #0x252
40001948: 94000901     	bl	0x40003d4c <uart_puts>
4000194c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001950: 91342400     	add	x0, x0, #0xd09
40001954: 940008fe     	bl	0x40003d4c <uart_puts>
40001958: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000195c: 910fd000     	add	x0, x0, #0x3f4
40001960: 940008fb     	bl	0x40003d4c <uart_puts>
40001964: 17ffff2d     	b	0x40001618 <execute_command+0x548>
40001968: b0000028     	adrp	x8, 0x40006000 <__rodata_start>
4000196c: 91260d08     	add	x8, x8, #0x983
40001970: 9100c001     	add	x1, x0, #0x30
40001974: aa0803e0     	mov	x0, x8
40001978: 17ffff87     	b	0x40001794 <execute_command+0x6c4>
4000197c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001980: 910aa800     	add	x0, x0, #0x2aa
40001984: 940008f2     	bl	0x40003d4c <uart_puts>
40001988: 17ffff24     	b	0x40001618 <execute_command+0x548>
4000198c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001990: 91136000     	add	x0, x0, #0x4d8
40001994: 940008ee     	bl	0x40003d4c <uart_puts>
40001998: 17ffff20     	b	0x40001618 <execute_command+0x548>
4000199c: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
400019a0: 911f5421     	add	x1, x1, #0x7d5
400019a4: 910103e0     	add	x0, sp, #0x40
400019a8: 528000e2     	mov	w2, #0x7                // =7
400019ac: 910103f3     	add	x19, sp, #0x40
400019b0: 94000531     	bl	0x40002e74 <kstrncmp>
400019b4: 340001a0     	cbz	w0, 0x400019e8 <execute_command+0x918>
400019b8: 910103e0     	add	x0, sp, #0x40
400019bc: 9400050f     	bl	0x40002df8 <kstrlen>
400019c0: b40001a0     	cbz	x0, 0x400019f4 <execute_command+0x924>
400019c4: 910103e0     	add	x0, sp, #0x40
400019c8: 97fff9ac     	bl	0x40000078 <ai_process_query>
400019cc: 17ffff13     	b	0x40001618 <execute_command+0x548>
400019d0: 910103e0     	add	x0, sp, #0x40
400019d4: 94000509     	bl	0x40002df8 <kstrlen>
400019d8: b4000120     	cbz	x0, 0x400019fc <execute_command+0x92c>
400019dc: 910103e0     	add	x0, sp, #0x40
400019e0: 940004ce     	bl	0x40002d18 <script_run_file>
400019e4: 17ffff0d     	b	0x40001618 <execute_command+0x548>
400019e8: 91001e60     	add	x0, x19, #0x7
400019ec: 97fff9a0     	bl	0x4000006c <ai_auto_mode>
400019f0: 17ffff0a     	b	0x40001618 <execute_command+0x548>
400019f4: 97fff9b5     	bl	0x400000c8 <ai_start_interactive>
400019f8: 17ffff08     	b	0x40001618 <execute_command+0x548>
400019fc: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001a00: 9139b800     	add	x0, x0, #0xe6e
40001a04: 940008d2     	bl	0x40003d4c <uart_puts>
40001a08: 17ffff04     	b	0x40001618 <execute_command+0x548>
40001a0c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001a10: 91180000     	add	x0, x0, #0x600
40001a14: 940008ce     	bl	0x40003d4c <uart_puts>
40001a18: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001a1c: b0000035     	adrp	x21, 0x40006000 <__rodata_start>
40001a20: 911862b5     	add	x21, x21, #0x618
40001a24: 39400113     	ldrb	w19, [x8]
40001a28: d344fe68     	lsr	x8, x19, #4
40001a2c: 38686aa0     	ldrb	w0, [x21, x8]
40001a30: 940008b0     	bl	0x40003cf0 <uart_putc>
40001a34: 92400e68     	and	x8, x19, #0xf
40001a38: 38686aa0     	ldrb	w0, [x21, x8]
40001a3c: 940008ad     	bl	0x40003cf0 <uart_putc>
40001a40: 52800400     	mov	w0, #0x20               // =32
40001a44: 940008ab     	bl	0x40003cf0 <uart_putc>
40001a48: b0000033     	adrp	x19, 0x40006000 <__rodata_start>
40001a4c: 910f8a73     	add	x19, x19, #0x3e2
40001a50: d0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40001a54: 913e7294     	add	x20, x20, #0xf9c
40001a58: 52800036     	mov	w22, #0x1               // =1
40001a5c: d503201f     	nop
40001a60: 10ff2d17     	adr	x23, 0x40000000 <_start>
40001a64: 1400000d     	b	0x40001a98 <execute_command+0x9c8>
40001a68: 38766af8     	ldrb	w24, [x23, x22]
40001a6c: d344ff08     	lsr	x8, x24, #4
40001a70: 38686aa0     	ldrb	w0, [x21, x8]
40001a74: 9400089f     	bl	0x40003cf0 <uart_putc>
40001a78: 92400f08     	and	x8, x24, #0xf
40001a7c: 38686aa0     	ldrb	w0, [x21, x8]
40001a80: 9400089c     	bl	0x40003cf0 <uart_putc>
40001a84: 52800400     	mov	w0, #0x20               // =32
40001a88: 9400089a     	bl	0x40003cf0 <uart_putc>
40001a8c: 910006d6     	add	x22, x22, #0x1
40001a90: f10082df     	cmp	x22, #0x20
40001a94: 54ffd420     	b.eq	0x40001518 <execute_command+0x448>
40001a98: 72000adf     	tst	w22, #0x7
40001a9c: 54000061     	b.ne	0x40001aa8 <execute_command+0x9d8>
40001aa0: aa1303e0     	mov	x0, x19
40001aa4: 940008aa     	bl	0x40003d4c <uart_puts>
40001aa8: 72000edf     	tst	w22, #0xf
40001aac: 54fffde1     	b.ne	0x40001a68 <execute_command+0x998>
40001ab0: aa1403e0     	mov	x0, x20
40001ab4: 940008a6     	bl	0x40003d4c <uart_puts>
40001ab8: 17ffffec     	b	0x40001a68 <execute_command+0x998>
40001abc: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001ac0: 9113ec00     	add	x0, x0, #0x4fb
40001ac4: 940008a2     	bl	0x40003d4c <uart_puts>
40001ac8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001acc: 912f5400     	add	x0, x0, #0xbd5
40001ad0: 9400089f     	bl	0x40003d4c <uart_puts>
40001ad4: d503207f     	wfi
40001ad8: 17ffffff     	b	0x40001ad4 <execute_command+0xa04>
40001adc: 97fffcb9     	bl	0x40000dc0 <print_android_roadmap>
40001ae0: 17fffece     	b	0x40001618 <execute_command+0x548>

0000000040001ae4 <kernel_shell>:
40001ae4: d10543ff     	sub	sp, sp, #0x150
40001ae8: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001aec: 91105400     	add	x0, x0, #0x415
40001af0: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
40001af4: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001af8: 9103c3fd     	add	x29, sp, #0xf0
40001afc: a91167fa     	stp	x26, x25, [sp, #0x110]
40001b00: a9125ff8     	stp	x24, x23, [sp, #0x120]
40001b04: a91357f6     	stp	x22, x21, [sp, #0x130]
40001b08: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001b0c: 94000890     	bl	0x40003d4c <uart_puts>
40001b10: d0000033     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
40001b14: 91189273     	add	x19, x19, #0x624
40001b18: d0000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40001b1c: 911f3e94     	add	x20, x20, #0x7cf
40001b20: 90000055     	adrp	x21, 0x40009000 <__rodata_start+0x3000>
40001b24: 910c4ab5     	add	x21, x21, #0x312
40001b28: d0000036     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
40001b2c: 911d06d6     	add	x22, x22, #0x741
40001b30: 90000057     	adrp	x23, 0x40009000 <__rodata_start+0x3000>
40001b34: 910c5af7     	add	x23, x23, #0x316
40001b38: f0000038     	adrp	x24, 0x40008000 <__rodata_start+0x2000>
40001b3c: 913ec718     	add	x24, x24, #0xfb1
40001b40: 910123fa     	add	x26, sp, #0x48
40001b44: d0000039     	adrp	x25, 0x40007000 <__rodata_start+0x1000>
40001b48: 910aff39     	add	x25, x25, #0x2bf
40001b4c: 910023e0     	add	x0, sp, #0x8
40001b50: 52800801     	mov	w1, #0x40               // =64
40001b54: 94000cff     	bl	0x40004f50 <vfs_getcwd>
40001b58: 910023e1     	add	x1, sp, #0x8
40001b5c: aa1303e0     	mov	x0, x19
40001b60: 9400098b     	bl	0x4000418c <uart_printf>
40001b64: aa1403e0     	mov	x0, x20
40001b68: 94000879     	bl	0x40003d4c <uart_puts>
40001b6c: aa1f03fc     	mov	x28, xzr
40001b70: aa1c03fb     	mov	x27, x28
40001b74: 940008a9     	bl	0x40003e18 <uart_getc>
40001b78: 12001c08     	and	w8, w0, #0xff
40001b7c: 7100311f     	cmp	w8, #0xc
40001b80: 540000cc     	b.gt	0x40001b98 <kernel_shell+0xb4>
40001b84: 7100211f     	cmp	w8, #0x8
40001b88: 54000240     	b.eq	0x40001bd0 <kernel_shell+0xec>
40001b8c: 7100291f     	cmp	w8, #0xa
40001b90: 540000c1     	b.ne	0x40001ba8 <kernel_shell+0xc4>
40001b94: 14000015     	b	0x40001be8 <kernel_shell+0x104>
40001b98: 7100351f     	cmp	w8, #0xd
40001b9c: 54000260     	b.eq	0x40001be8 <kernel_shell+0x104>
40001ba0: 7101fd1f     	cmp	w8, #0x7f
40001ba4: 54000160     	b.eq	0x40001bd0 <kernel_shell+0xec>
40001ba8: 51008008     	sub	w8, w0, #0x20
40001bac: 12001d08     	and	w8, w8, #0xff
40001bb0: 7101791f     	cmp	w8, #0x5e
40001bb4: 54fffe08     	b.hi	0x40001b74 <kernel_shell+0x90>
40001bb8: f1027b7f     	cmp	x27, #0x9e
40001bbc: 54fffdc8     	b.hi	0x40001b74 <kernel_shell+0x90>
40001bc0: 9100077c     	add	x28, x27, #0x1
40001bc4: 383b6b40     	strb	w0, [x26, x27]
40001bc8: 9400084a     	bl	0x40003cf0 <uart_putc>
40001bcc: 17ffffe9     	b	0x40001b70 <kernel_shell+0x8c>
40001bd0: aa1f03fc     	mov	x28, xzr
40001bd4: b4fffcfb     	cbz	x27, 0x40001b70 <kernel_shell+0x8c>
40001bd8: aa1503e0     	mov	x0, x21
40001bdc: d100077c     	sub	x28, x27, #0x1
40001be0: 9400085b     	bl	0x40003d4c <uart_puts>
40001be4: 17ffffe3     	b	0x40001b70 <kernel_shell+0x8c>
40001be8: aa1603e0     	mov	x0, x22
40001bec: 94000858     	bl	0x40003d4c <uart_puts>
40001bf0: 910123e0     	add	x0, sp, #0x48
40001bf4: 383b6b5f     	strb	wzr, [x26, x27]
40001bf8: 94000480     	bl	0x40002df8 <kstrlen>
40001bfc: b4fffa80     	cbz	x0, 0x40001b4c <kernel_shell+0x68>
40001c00: 910123e0     	add	x0, sp, #0x48
40001c04: 9400034a     	bl	0x4000292c <script_execute_line>
40001c08: 910123e0     	add	x0, sp, #0x48
40001c0c: aa1703e1     	mov	x1, x23
40001c10: 9400048a     	bl	0x40002e38 <kstrcmp>
40001c14: 34000120     	cbz	w0, 0x40001c38 <kernel_shell+0x154>
40001c18: 910123e0     	add	x0, sp, #0x48
40001c1c: aa1803e1     	mov	x1, x24
40001c20: 94000486     	bl	0x40002e38 <kstrcmp>
40001c24: 340000a0     	cbz	w0, 0x40001c38 <kernel_shell+0x154>
40001c28: 910123e0     	add	x0, sp, #0x48
40001c2c: aa1903e1     	mov	x1, x25
40001c30: 94000482     	bl	0x40002e38 <kstrcmp>
40001c34: 35fff8c0     	cbnz	w0, 0x40001b4c <kernel_shell+0x68>
40001c38: a9544ff4     	ldp	x20, x19, [sp, #0x140]
40001c3c: a95357f6     	ldp	x22, x21, [sp, #0x130]
40001c40: a9525ff8     	ldp	x24, x23, [sp, #0x120]
40001c44: a95167fa     	ldp	x26, x25, [sp, #0x110]
40001c48: a9506ffc     	ldp	x28, x27, [sp, #0x100]
40001c4c: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
40001c50: 910543ff     	add	sp, sp, #0x150
40001c54: d65f03c0     	ret

0000000040001c58 <kmain>:
40001c58: d100c3ff     	sub	sp, sp, #0x30
40001c5c: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001c60: 529c6c13     	mov	w19, #0xe360            // =58208
40001c64: a9017bfd     	stp	x29, x30, [sp, #0x10]
40001c68: 910043fd     	add	x29, sp, #0x10
40001c6c: 72a002d3     	movk	w19, #0x16, lsl #16
40001c70: 94000814     	bl	0x40003cc0 <uart_init>
40001c74: d503201f     	nop
40001c78: 1002ea60     	adr	x0, 0x400079c4 <__rodata_start+0x19c4>
40001c7c: 94000834     	bl	0x40003d4c <uart_puts>
40001c80: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001c84: 911f7400     	add	x0, x0, #0x7dd
40001c88: 94000831     	bl	0x40003d4c <uart_puts>
40001c8c: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001c90: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001c94: 6b13011f     	cmp	w8, w19
40001c98: 540000aa     	b.ge	0x40001cac <kmain+0x54>
40001c9c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001ca0: 11000508     	add	w8, w8, #0x1
40001ca4: b81fc3a8     	stur	w8, [x29, #-0x4]
40001ca8: 17fffffa     	b	0x40001c90 <kmain+0x38>
40001cac: 528aa213     	mov	w19, #0x5510            // =21776
40001cb0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001cb4: 910f9000     	add	x0, x0, #0x3e4
40001cb8: 72a00453     	movk	w19, #0x22, lsl #16
40001cbc: 94000824     	bl	0x40003d4c <uart_puts>
40001cc0: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001cc4: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001cc8: 6b13011f     	cmp	w8, w19
40001ccc: 540000aa     	b.ge	0x40001ce0 <kmain+0x88>
40001cd0: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001cd4: 11000508     	add	w8, w8, #0x1
40001cd8: b81fc3a8     	stur	w8, [x29, #-0x4]
40001cdc: 17fffffa     	b	0x40001cc4 <kmain+0x6c>
40001ce0: 5298d814     	mov	w20, #0xc6c0            // =50880
40001ce4: 72a005b4     	movk	w20, #0x2d, lsl #16
40001ce8: 94000b34     	bl	0x400049b8 <vfs_init>
40001cec: 94000055     	bl	0x40001e40 <kpkg_init>
40001cf0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001cf4: 91034800     	add	x0, x0, #0xd2
40001cf8: 94000815     	bl	0x40003d4c <uart_puts>
40001cfc: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001d00: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d04: 6b14011f     	cmp	w8, w20
40001d08: 540000aa     	b.ge	0x40001d1c <kmain+0xc4>
40001d0c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d10: 11000508     	add	w8, w8, #0x1
40001d14: b81fc3a8     	stur	w8, [x29, #-0x4]
40001d18: 17fffffa     	b	0x40001d00 <kmain+0xa8>
40001d1c: 940000f3     	bl	0x400020e8 <process_init>
40001d20: 94000239     	bl	0x40002604 <script_init>
40001d24: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001d28: 91026000     	add	x0, x0, #0x98
40001d2c: 94000808     	bl	0x40003d4c <uart_puts>
40001d30: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001d34: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d38: 6b13011f     	cmp	w8, w19
40001d3c: 540000aa     	b.ge	0x40001d50 <kmain+0xf8>
40001d40: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d44: 11000508     	add	w8, w8, #0x1
40001d48: b81fc3a8     	stur	w8, [x29, #-0x4]
40001d4c: 17fffffa     	b	0x40001d34 <kmain+0xdc>
40001d50: 52870e13     	mov	w19, #0x3870            // =14448
40001d54: 72a00733     	movk	w19, #0x39, lsl #16
40001d58: 97fff8c0     	bl	0x40000058 <ai_init>
40001d5c: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40001d60: 910e3000     	add	x0, x0, #0x38c
40001d64: 940007fa     	bl	0x40003d4c <uart_puts>
40001d68: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001d6c: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d70: 6b13011f     	cmp	w8, w19
40001d74: 540000aa     	b.ge	0x40001d88 <kmain+0x130>
40001d78: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001d7c: 11000508     	add	w8, w8, #0x1
40001d80: b81fc3a8     	stur	w8, [x29, #-0x4]
40001d84: 17fffffa     	b	0x40001d6c <kmain+0x114>
40001d88: 5291b013     	mov	w19, #0x8d80            // =36224
40001d8c: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001d90: 91116000     	add	x0, x0, #0x458
40001d94: 72a00b73     	movk	w19, #0x5b, lsl #16
40001d98: 940007ed     	bl	0x40003d4c <uart_puts>
40001d9c: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001da0: 91357c00     	add	x0, x0, #0xd5f
40001da4: 940007ea     	bl	0x40003d4c <uart_puts>
40001da8: b81fc3bf     	stur	wzr, [x29, #-0x4]
40001dac: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001db0: 6b13011f     	cmp	w8, w19
40001db4: 540000aa     	b.ge	0x40001dc8 <kmain+0x170>
40001db8: b85fc3a8     	ldur	w8, [x29, #-0x4]
40001dbc: 11000508     	add	w8, w8, #0x1
40001dc0: b81fc3a8     	stur	w8, [x29, #-0x4]
40001dc4: 17fffffa     	b	0x40001dac <kmain+0x154>
40001dc8: 97fffb63     	bl	0x40000b54 <print_banner>
40001dcc: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001dd0: 9135e000     	add	x0, x0, #0xd78
40001dd4: f0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40001dd8: 91291421     	add	x1, x1, #0xa45
40001ddc: 940008ec     	bl	0x4000418c <uart_printf>
40001de0: 97fffba6     	bl	0x40000c78 <print_sysinfo>
40001de4: 97ffff40     	bl	0x40001ae4 <kernel_shell>
40001de8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001dec: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001df0: 912f5400     	add	x0, x0, #0xbd5
40001df4: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40001df8: 9100c3ff     	add	sp, sp, #0x30
40001dfc: 140007d4     	b	0x40003d4c <uart_puts>

0000000040001e00 <kimg_execute>:
40001e00: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001e04: 910003fd     	mov	x29, sp
40001e08: b40000e0     	cbz	x0, 0x40001e24 <kimg_execute+0x24>
40001e0c: 940003fb     	bl	0x40002df8 <kstrlen>
40001e10: b40000a0     	cbz	x0, 0x40001e24 <kimg_execute+0x24>
40001e14: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40001e18: 910fb400     	add	x0, x0, #0x3ed
40001e1c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001e20: 140007cb     	b	0x40003d4c <uart_puts>
40001e24: d503201f     	nop
40001e28: 3003ad80     	adr	x0, 0x400093d9 <__rodata_start+0x33d9>
40001e2c: 940007c8     	bl	0x40003d4c <uart_puts>
40001e30: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001e34: 911fb000     	add	x0, x0, #0x7ec
40001e38: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001e3c: 140007c4     	b	0x40003d4c <uart_puts>

0000000040001e40 <kpkg_init>:
40001e40: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40001e44: d503201f     	nop
40001e48: 10033900     	adr	x0, 0x40008568 <__rodata_start+0x2568>
40001e4c: 910003fd     	mov	x29, sp
40001e50: 94000cab     	bl	0x400050fc <vfs_find>
40001e54: b4000060     	cbz	x0, 0x40001e60 <kpkg_init+0x20>
40001e58: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001e5c: d65f03c0     	ret
40001e60: d503201f     	nop
40001e64: 10033820     	adr	x0, 0x40008568 <__rodata_start+0x2568>
40001e68: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40001e6c: 14000d2e     	b	0x40005324 <vfs_mkdir>

0000000040001e70 <kpkg_execute>:
40001e70: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001e74: 913f5800     	add	x0, x0, #0xfd6
40001e78: 140007b5     	b	0x40003d4c <uart_puts>

0000000040001e7c <kpkg_try_run>:
40001e7c: d10183ff     	sub	sp, sp, #0x60
40001e80: f9002bf3     	str	x19, [sp, #0x50]
40001e84: aa0003f3     	mov	x19, x0
40001e88: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001e8c: 91003821     	add	x1, x1, #0xe
40001e90: 910003e0     	mov	x0, sp
40001e94: a9047bfd     	stp	x29, x30, [sp, #0x40]
40001e98: 910103fd     	add	x29, sp, #0x40
40001e9c: 94000406     	bl	0x40002eb4 <kstrcpy>
40001ea0: 910003e0     	mov	x0, sp
40001ea4: aa1303e1     	mov	x1, x19
40001ea8: 940003db     	bl	0x40002e14 <kstrcat>
40001eac: 90000041     	adrp	x1, 0x40009000 <__rodata_start+0x3000>
40001eb0: 9110a821     	add	x1, x1, #0x42a
40001eb4: 910003e0     	mov	x0, sp
40001eb8: 940003d7     	bl	0x40002e14 <kstrcat>
40001ebc: 910003e0     	mov	x0, sp
40001ec0: 94000c8f     	bl	0x400050fc <vfs_find>
40001ec4: b4000100     	cbz	x0, 0x40001ee4 <kpkg_try_run+0x68>
40001ec8: b9402008     	ldr	w8, [x0, #0x20]
40001ecc: 34000068     	cbz	w8, 0x40001ed8 <kpkg_try_run+0x5c>
40001ed0: 2a1f03e0     	mov	w0, wzr
40001ed4: 14000004     	b	0x40001ee4 <kpkg_try_run+0x68>
40001ed8: 910003e0     	mov	x0, sp
40001edc: 9400038f     	bl	0x40002d18 <script_run_file>
40001ee0: 52800020     	mov	w0, #0x1                // =1
40001ee4: a9447bfd     	ldp	x29, x30, [sp, #0x40]
40001ee8: f9402bf3     	ldr	x19, [sp, #0x50]
40001eec: 910183ff     	add	sp, sp, #0x60
40001ef0: d65f03c0     	ret

0000000040001ef4 <kproj_execute>:
40001ef4: d10683ff     	sub	sp, sp, #0x1a0
40001ef8: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001efc: 910603fd     	add	x29, sp, #0x180
40001f00: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001f04: b40001c0     	cbz	x0, 0x40001f3c <kproj_execute+0x48>
40001f08: aa0003f3     	mov	x19, x0
40001f0c: 940003bb     	bl	0x40002df8 <kstrlen>
40001f10: b4000160     	cbz	x0, 0x40001f3c <kproj_execute+0x48>
40001f14: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001f18: 91005000     	add	x0, x0, #0x14
40001f1c: aa1303e1     	mov	x1, x19
40001f20: 9400089b     	bl	0x4000418c <uart_printf>
40001f24: aa1303e0     	mov	x0, x19
40001f28: 94000cff     	bl	0x40005324 <vfs_mkdir>
40001f2c: 34000140     	cbz	w0, 0x40001f54 <kproj_execute+0x60>
40001f30: 90000040     	adrp	x0, 0x40009000 <__rodata_start+0x3000>
40001f34: 9110bc00     	add	x0, x0, #0x42f
40001f38: 14000003     	b	0x40001f44 <kproj_execute+0x50>
40001f3c: d503201f     	nop
40001f40: 50038600     	adr	x0, 0x40009002 <__rodata_start+0x3002>
40001f44: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001f48: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001f4c: 910683ff     	add	sp, sp, #0x1a0
40001f50: 1400077f     	b	0x40003d4c <uart_puts>
40001f54: aa1303e0     	mov	x0, x19
40001f58: 94000cce     	bl	0x40005290 <vfs_chdir>
40001f5c: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001f60: 91213c00     	add	x0, x0, #0x84f
40001f64: 94000cf0     	bl	0x40005324 <vfs_mkdir>
40001f68: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001f6c: 913c9c00     	add	x0, x0, #0xf27
40001f70: 94000ced     	bl	0x40005324 <vfs_mkdir>
40001f74: b0000021     	adrp	x1, 0x40006000 <__rodata_start>
40001f78: 910b5c21     	add	x1, x1, #0x2d7
40001f7c: 910203e0     	add	x0, sp, #0x80
40001f80: 940003cd     	bl	0x40002eb4 <kstrcpy>
40001f84: 910203e0     	add	x0, sp, #0x80
40001f88: aa1303e1     	mov	x1, x19
40001f8c: 940003a2     	bl	0x40002e14 <kstrcat>
40001f90: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001f94: 911a4021     	add	x1, x1, #0x690
40001f98: 910203e0     	add	x0, sp, #0x80
40001f9c: 9400039e     	bl	0x40002e14 <kstrcat>
40001fa0: b0000020     	adrp	x0, 0x40006000 <__rodata_start>
40001fa4: 91368400     	add	x0, x0, #0xda1
40001fa8: 910203e1     	add	x1, sp, #0x80
40001fac: 94000d34     	bl	0x4000547c <vfs_touch>
40001fb0: f0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40001fb4: 912fec00     	add	x0, x0, #0xbfb
40001fb8: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001fbc: 910b1021     	add	x1, x1, #0x2c4
40001fc0: 94000d2f     	bl	0x4000547c <vfs_touch>
40001fc4: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001fc8: 91254021     	add	x1, x1, #0x950
40001fcc: 910003e0     	mov	x0, sp
40001fd0: 940003b9     	bl	0x40002eb4 <kstrcpy>
40001fd4: 910003e0     	mov	x0, sp
40001fd8: aa1303e1     	mov	x1, x19
40001fdc: 9400038e     	bl	0x40002e14 <kstrcat>
40001fe0: d0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40001fe4: 9104f421     	add	x1, x1, #0x13d
40001fe8: 910003e0     	mov	x0, sp
40001fec: 9400038a     	bl	0x40002e14 <kstrcat>
40001ff0: d0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40001ff4: 911af000     	add	x0, x0, #0x6bc
40001ff8: 910003e1     	mov	x1, sp
40001ffc: 94000d20     	bl	0x4000547c <vfs_touch>
40002000: 94000d1e     	bl	0x40005478 <vfs_sync>
40002004: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002008: 9118a400     	add	x0, x0, #0x629
4000200c: 94000750     	bl	0x40003d4c <uart_puts>
40002010: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
40002014: 91196000     	add	x0, x0, #0x658
40002018: aa1303e1     	mov	x1, x19
4000201c: 9400085c     	bl	0x4000418c <uart_printf>
40002020: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40002024: 91214c00     	add	x0, x0, #0x853
40002028: 94000c9a     	bl	0x40005290 <vfs_chdir>
4000202c: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40002030: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40002034: 910683ff     	add	sp, sp, #0x1a0
40002038: d65f03c0     	ret

000000004000203c <kpy_execute>:
4000203c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002040: f9000bf3     	str	x19, [sp, #0x10]
40002044: 910003fd     	mov	x29, sp
40002048: b4000240     	cbz	x0, 0x40002090 <kpy_execute+0x54>
4000204c: aa0003f3     	mov	x19, x0
40002050: 9400036a     	bl	0x40002df8 <kstrlen>
40002054: b40001e0     	cbz	x0, 0x40002090 <kpy_execute+0x54>
40002058: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
4000205c: 91124c21     	add	x1, x1, #0x493
40002060: aa1303e0     	mov	x0, x19
40002064: 52800062     	mov	w2, #0x3                // =3
40002068: 94000383     	bl	0x40002e74 <kstrncmp>
4000206c: 340001c0     	cbz	w0, 0x400020a4 <kpy_execute+0x68>
40002070: aa1303e0     	mov	x0, x19
40002074: 94000c22     	bl	0x400050fc <vfs_find>
40002078: b4000260     	cbz	x0, 0x400020c4 <kpy_execute+0x88>
4000207c: b9402008     	ldr	w8, [x0, #0x20]
40002080: 340002e8     	cbz	w8, 0x400020dc <kpy_execute+0xa0>
40002084: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40002088: 910a1000     	add	x0, x0, #0x284
4000208c: 14000010     	b	0x400020cc <kpy_execute+0x90>
40002090: d503201f     	nop
40002094: 10035bc0     	adr	x0, 0x40008c0c <__rodata_start+0x2c0c>
40002098: f9400bf3     	ldr	x19, [sp, #0x10]
4000209c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400020a0: 1400072b     	b	0x40003d4c <uart_puts>
400020a4: 91000a60     	add	x0, x19, #0x2
400020a8: 38401c08     	ldrb	w8, [x0, #0x1]!
400020ac: 7100811f     	cmp	w8, #0x20
400020b0: 54ffffc0     	b.eq	0x400020a8 <kpy_execute+0x6c>
400020b4: 94000351     	bl	0x40002df8 <kstrlen>
400020b8: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
400020bc: 91039400     	add	x0, x0, #0xe5
400020c0: 17fffff6     	b	0x40002098 <kpy_execute+0x5c>
400020c4: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
400020c8: 912d0800     	add	x0, x0, #0xb42
400020cc: aa1303e1     	mov	x1, x19
400020d0: f9400bf3     	ldr	x19, [sp, #0x10]
400020d4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400020d8: 1400082d     	b	0x4000418c <uart_printf>
400020dc: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
400020e0: 9136a400     	add	x0, x0, #0xda9
400020e4: 17ffffed     	b	0x40002098 <kpy_execute+0x5c>

00000000400020e8 <process_init>:
400020e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400020ec: a9014ff4     	stp	x20, x19, [sp, #0x10]
400020f0: 90000054     	adrp	x20, 0x4000a000 <next_pid>
400020f4: d503201f     	nop
400020f8: 10060b33     	adr	x19, 0x4000e25c <proc_table>
400020fc: b9400289     	ldr	w9, [x20]
40002100: 52800068     	mov	w8, #0x3                // =3
40002104: b9002668     	str	w8, [x19, #0x24]
40002108: d503201f     	nop
4000210c: 30030da1     	adr	x1, 0x400082c1 <__rodata_start+0x22c1>
40002110: b9005668     	str	w8, [x19, #0x54]
40002114: 91001260     	add	x0, x19, #0x4
40002118: 910003fd     	mov	x29, sp
4000211c: b9008668     	str	w8, [x19, #0x84]
40002120: b900b668     	str	w8, [x19, #0xb4]
40002124: b900e668     	str	w8, [x19, #0xe4]
40002128: b9011668     	str	w8, [x19, #0x114]
4000212c: b9014668     	str	w8, [x19, #0x144]
40002130: b9017668     	str	w8, [x19, #0x174]
40002134: b901a668     	str	w8, [x19, #0x1a4]
40002138: b901d668     	str	w8, [x19, #0x1d4]
4000213c: b9020668     	str	w8, [x19, #0x204]
40002140: b9023668     	str	w8, [x19, #0x234]
40002144: b9026668     	str	w8, [x19, #0x264]
40002148: b9029668     	str	w8, [x19, #0x294]
4000214c: b902c668     	str	w8, [x19, #0x2c4]
40002150: b902f668     	str	w8, [x19, #0x2f4]
40002154: 11000528     	add	w8, w9, #0x1
40002158: b900327f     	str	wzr, [x19, #0x30]
4000215c: b900627f     	str	wzr, [x19, #0x60]
40002160: b900927f     	str	wzr, [x19, #0x90]
40002164: b900c27f     	str	wzr, [x19, #0xc0]
40002168: b900f27f     	str	wzr, [x19, #0xf0]
4000216c: b901227f     	str	wzr, [x19, #0x120]
40002170: b901527f     	str	wzr, [x19, #0x150]
40002174: b901827f     	str	wzr, [x19, #0x180]
40002178: b901b27f     	str	wzr, [x19, #0x1b0]
4000217c: b901e27f     	str	wzr, [x19, #0x1e0]
40002180: b902127f     	str	wzr, [x19, #0x210]
40002184: b902427f     	str	wzr, [x19, #0x240]
40002188: b902727f     	str	wzr, [x19, #0x270]
4000218c: b902a27f     	str	wzr, [x19, #0x2a0]
40002190: b902d27f     	str	wzr, [x19, #0x2d0]
40002194: b9000288     	str	w8, [x20]
40002198: b9000269     	str	w9, [x19]
4000219c: 94000346     	bl	0x40002eb4 <kstrcpy>
400021a0: f0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
400021a4: b9400289     	ldr	w9, [x20]
400021a8: 5280384a     	mov	w10, #0x1c2             // =450
400021ac: fd425100     	ldr	d0, [x8, #0x4a0]
400021b0: f0000021     	adrp	x1, 0x40009000 <__rodata_start+0x3000>
400021b4: 9111a021     	add	x1, x1, #0x468
400021b8: 11000528     	add	w8, w9, #0x1
400021bc: 9100d260     	add	x0, x19, #0x34
400021c0: 2905a66a     	stp	w10, w9, [x19, #0x2c]
400021c4: fc024260     	stur	d0, [x19, #0x24]
400021c8: b9000288     	str	w8, [x20]
400021cc: 9400033a     	bl	0x40002eb4 <kstrcpy>
400021d0: f0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
400021d4: b9400289     	ldr	w9, [x20]
400021d8: 5280018a     	mov	w10, #0xc               // =12
400021dc: fd426500     	ldr	d0, [x8, #0x4c8]
400021e0: b0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
400021e4: 91057c21     	add	x1, x1, #0x15f
400021e8: 11000528     	add	w8, w9, #0x1
400021ec: 91019260     	add	x0, x19, #0x64
400021f0: 290ba66a     	stp	w10, w9, [x19, #0x5c]
400021f4: fc054260     	stur	d0, [x19, #0x54]
400021f8: b9000288     	str	w8, [x20]
400021fc: 9400032e     	bl	0x40002eb4 <kstrcpy>
40002200: f0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40002204: b9400289     	ldr	w9, [x20]
40002208: 5280960a     	mov	w10, #0x4b0             // =1200
4000220c: fd424100     	ldr	d0, [x8, #0x480]
40002210: b0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40002214: 912e8821     	add	x1, x1, #0xba2
40002218: 11000528     	add	w8, w9, #0x1
4000221c: 91025260     	add	x0, x19, #0x94
40002220: 2911a66a     	stp	w10, w9, [x19, #0x8c]
40002224: fc084260     	stur	d0, [x19, #0x84]
40002228: b9000288     	str	w8, [x20]
4000222c: 94000322     	bl	0x40002eb4 <kstrcpy>
40002230: f0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40002234: fd427500     	ldr	d0, [x8, #0x4e8]
40002238: 52800aa8     	mov	w8, #0x55               // =85
4000223c: b900be68     	str	w8, [x19, #0xbc]
40002240: fc0b4260     	stur	d0, [x19, #0xb4]
40002244: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40002248: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000224c: d65f03c0     	ret

0000000040002250 <process_kill>:
40002250: 7100041f     	cmp	w0, #0x1
40002254: 5400118b     	b.lt	0x40002484 <process_kill+0x234>
40002258: d503201f     	nop
4000225c: 10060009     	adr	x9, 0x4000e25c <proc_table>
40002260: b9400128     	ldr	w8, [x9]
40002264: 6b00011f     	cmp	w8, w0
40002268: 54000081     	b.ne	0x40002278 <process_kill+0x28>
4000226c: b9402528     	ldr	w8, [x9, #0x24]
40002270: 71000d1f     	cmp	w8, #0x3
40002274: 54000f41     	b.ne	0x4000245c <process_kill+0x20c>
40002278: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000227c: 910a3129     	add	x9, x9, #0x28c
40002280: b9400128     	ldr	w8, [x9]
40002284: 6b00011f     	cmp	w8, w0
40002288: 54000081     	b.ne	0x40002298 <process_kill+0x48>
4000228c: b9402528     	ldr	w8, [x9, #0x24]
40002290: 71000d1f     	cmp	w8, #0x3
40002294: 54000e41     	b.ne	0x4000245c <process_kill+0x20c>
40002298: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000229c: 910af129     	add	x9, x9, #0x2bc
400022a0: b9400128     	ldr	w8, [x9]
400022a4: 6b00011f     	cmp	w8, w0
400022a8: 54000081     	b.ne	0x400022b8 <process_kill+0x68>
400022ac: b9402528     	ldr	w8, [x9, #0x24]
400022b0: 71000d1f     	cmp	w8, #0x3
400022b4: 54000d41     	b.ne	0x4000245c <process_kill+0x20c>
400022b8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400022bc: 910bb129     	add	x9, x9, #0x2ec
400022c0: b9400128     	ldr	w8, [x9]
400022c4: 6b00011f     	cmp	w8, w0
400022c8: 54000081     	b.ne	0x400022d8 <process_kill+0x88>
400022cc: b9402528     	ldr	w8, [x9, #0x24]
400022d0: 71000d1f     	cmp	w8, #0x3
400022d4: 54000c41     	b.ne	0x4000245c <process_kill+0x20c>
400022d8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400022dc: 910c7129     	add	x9, x9, #0x31c
400022e0: b9400128     	ldr	w8, [x9]
400022e4: 6b00011f     	cmp	w8, w0
400022e8: 54000081     	b.ne	0x400022f8 <process_kill+0xa8>
400022ec: b9402528     	ldr	w8, [x9, #0x24]
400022f0: 71000d1f     	cmp	w8, #0x3
400022f4: 54000b41     	b.ne	0x4000245c <process_kill+0x20c>
400022f8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400022fc: 910d3129     	add	x9, x9, #0x34c
40002300: b9400128     	ldr	w8, [x9]
40002304: 6b00011f     	cmp	w8, w0
40002308: 54000081     	b.ne	0x40002318 <process_kill+0xc8>
4000230c: b9402528     	ldr	w8, [x9, #0x24]
40002310: 71000d1f     	cmp	w8, #0x3
40002314: 54000a41     	b.ne	0x4000245c <process_kill+0x20c>
40002318: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000231c: 910df129     	add	x9, x9, #0x37c
40002320: b9400128     	ldr	w8, [x9]
40002324: 6b00011f     	cmp	w8, w0
40002328: 54000081     	b.ne	0x40002338 <process_kill+0xe8>
4000232c: b9402528     	ldr	w8, [x9, #0x24]
40002330: 71000d1f     	cmp	w8, #0x3
40002334: 54000941     	b.ne	0x4000245c <process_kill+0x20c>
40002338: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000233c: 910eb129     	add	x9, x9, #0x3ac
40002340: b9400128     	ldr	w8, [x9]
40002344: 6b00011f     	cmp	w8, w0
40002348: 54000081     	b.ne	0x40002358 <process_kill+0x108>
4000234c: b9402528     	ldr	w8, [x9, #0x24]
40002350: 71000d1f     	cmp	w8, #0x3
40002354: 54000841     	b.ne	0x4000245c <process_kill+0x20c>
40002358: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000235c: 910f7129     	add	x9, x9, #0x3dc
40002360: b9400128     	ldr	w8, [x9]
40002364: 6b00011f     	cmp	w8, w0
40002368: 54000081     	b.ne	0x40002378 <process_kill+0x128>
4000236c: b9402528     	ldr	w8, [x9, #0x24]
40002370: 71000d1f     	cmp	w8, #0x3
40002374: 54000741     	b.ne	0x4000245c <process_kill+0x20c>
40002378: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000237c: 91103129     	add	x9, x9, #0x40c
40002380: b9400128     	ldr	w8, [x9]
40002384: 6b00011f     	cmp	w8, w0
40002388: 54000081     	b.ne	0x40002398 <process_kill+0x148>
4000238c: b9402528     	ldr	w8, [x9, #0x24]
40002390: 71000d1f     	cmp	w8, #0x3
40002394: 54000641     	b.ne	0x4000245c <process_kill+0x20c>
40002398: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000239c: 9110f129     	add	x9, x9, #0x43c
400023a0: b9400128     	ldr	w8, [x9]
400023a4: 6b00011f     	cmp	w8, w0
400023a8: 54000081     	b.ne	0x400023b8 <process_kill+0x168>
400023ac: b9402528     	ldr	w8, [x9, #0x24]
400023b0: 71000d1f     	cmp	w8, #0x3
400023b4: 54000541     	b.ne	0x4000245c <process_kill+0x20c>
400023b8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400023bc: 9111b129     	add	x9, x9, #0x46c
400023c0: b9400128     	ldr	w8, [x9]
400023c4: 6b00011f     	cmp	w8, w0
400023c8: 54000081     	b.ne	0x400023d8 <process_kill+0x188>
400023cc: b9402528     	ldr	w8, [x9, #0x24]
400023d0: 71000d1f     	cmp	w8, #0x3
400023d4: 54000441     	b.ne	0x4000245c <process_kill+0x20c>
400023d8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400023dc: 91127129     	add	x9, x9, #0x49c
400023e0: b9400128     	ldr	w8, [x9]
400023e4: 6b00011f     	cmp	w8, w0
400023e8: 54000081     	b.ne	0x400023f8 <process_kill+0x1a8>
400023ec: b9402528     	ldr	w8, [x9, #0x24]
400023f0: 71000d1f     	cmp	w8, #0x3
400023f4: 54000341     	b.ne	0x4000245c <process_kill+0x20c>
400023f8: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
400023fc: 91133129     	add	x9, x9, #0x4cc
40002400: b9400128     	ldr	w8, [x9]
40002404: 6b00011f     	cmp	w8, w0
40002408: 54000081     	b.ne	0x40002418 <process_kill+0x1c8>
4000240c: b9402528     	ldr	w8, [x9, #0x24]
40002410: 71000d1f     	cmp	w8, #0x3
40002414: 54000241     	b.ne	0x4000245c <process_kill+0x20c>
40002418: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000241c: 9113f129     	add	x9, x9, #0x4fc
40002420: b9400128     	ldr	w8, [x9]
40002424: 6b00011f     	cmp	w8, w0
40002428: 54000081     	b.ne	0x40002438 <process_kill+0x1e8>
4000242c: b9402528     	ldr	w8, [x9, #0x24]
40002430: 71000d1f     	cmp	w8, #0x3
40002434: 54000141     	b.ne	0x4000245c <process_kill+0x20c>
40002438: 90000069     	adrp	x9, 0x4000e000 <E+0x2ff8>
4000243c: 9114b129     	add	x9, x9, #0x52c
40002440: b9400128     	ldr	w8, [x9]
40002444: 6b00011f     	cmp	w8, w0
40002448: 12800008     	mov	w8, #-0x1               // =-1
4000244c: 54000281     	b.ne	0x4000249c <process_kill+0x24c>
40002450: b940252a     	ldr	w10, [x9, #0x24]
40002454: 71000d5f     	cmp	w10, #0x3
40002458: 54000220     	b.eq	0x4000249c <process_kill+0x24c>
4000245c: 7100041f     	cmp	w0, #0x1
40002460: 54000161     	b.ne	0x4000248c <process_kill+0x23c>
40002464: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002468: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000246c: 91011400     	add	x0, x0, #0x45
40002470: 910003fd     	mov	x29, sp
40002474: 94000636     	bl	0x40003d4c <uart_puts>
40002478: 12800020     	mov	w0, #-0x2               // =-2
4000247c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002480: d65f03c0     	ret
40002484: 12800000     	mov	w0, #-0x1               // =-1
40002488: d65f03c0     	ret
4000248c: 5280004a     	mov	w10, #0x2               // =2
40002490: 2a1f03e0     	mov	w0, wzr
40002494: b900252a     	str	w10, [x9, #0x24]
40002498: d65f03c0     	ret
4000249c: 2a0803e0     	mov	w0, w8
400024a0: d65f03c0     	ret

00000000400024a4 <launch_ktop>:
400024a4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400024a8: 90000020     	adrp	x0, 0x40006000 <__rodata_start>
400024ac: 912dd400     	add	x0, x0, #0xb75
400024b0: f9000bf7     	str	x23, [sp, #0x10]
400024b4: a90257f6     	stp	x22, x21, [sp, #0x20]
400024b8: 910003fd     	mov	x29, sp
400024bc: a9034ff4     	stp	x20, x19, [sp, #0x30]
400024c0: 94000623     	bl	0x40003d4c <uart_puts>
400024c4: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400024c8: 91047c00     	add	x0, x0, #0x11f
400024cc: 94000620     	bl	0x40003d4c <uart_puts>
400024d0: 2a1f03e8     	mov	w8, wzr
400024d4: 2a1f03e1     	mov	w1, wzr
400024d8: 52800209     	mov	w9, #0x10               // =16
400024dc: 9000006a     	adrp	x10, 0x4000e000 <E+0x2ff8>
400024e0: 910a114a     	add	x10, x10, #0x284
400024e4: 14000004     	b	0x400024f4 <launch_ktop+0x50>
400024e8: f1000529     	subs	x9, x9, #0x1
400024ec: 9100c14a     	add	x10, x10, #0x30
400024f0: 54000120     	b.eq	0x40002514 <launch_ktop+0x70>
400024f4: b85fc14b     	ldur	w11, [x10, #-0x4]
400024f8: 121f796b     	and	w11, w11, #0xfffffffe
400024fc: 7100097f     	cmp	w11, #0x2
40002500: 54ffff40     	b.eq	0x400024e8 <launch_ktop+0x44>
40002504: b940014b     	ldr	w11, [x10]
40002508: 11000421     	add	w1, w1, #0x1
4000250c: 0b080168     	add	w8, w11, w8
40002510: 17fffff6     	b	0x400024e8 <launch_ktop+0x44>
40002514: 530a7d02     	lsr	w2, w8, #10
40002518: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000251c: 9105a400     	add	x0, x0, #0x169
40002520: 9400071b     	bl	0x4000418c <uart_printf>
40002524: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40002528: 910b9000     	add	x0, x0, #0x2e4
4000252c: 94000608     	bl	0x40003d4c <uart_puts>
40002530: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40002534: 91246c00     	add	x0, x0, #0x91b
40002538: 94000605     	bl	0x40003d4c <uart_puts>
4000253c: 90000074     	adrp	x20, 0x4000e000 <E+0x2ff8>
40002540: 910a2294     	add	x20, x20, #0x288
40002544: d0000035     	adrp	x21, 0x40008000 <__rodata_start+0x2000>
40002548: 912a82b5     	add	x21, x21, #0xaa0
4000254c: d503201f     	nop
40002550: 10037d56     	adr	x22, 0x400094f8 <__rodata_start+0x34f8>
40002554: 52800217     	mov	w23, #0x10              // =16
40002558: b0000033     	adrp	x19, 0x40007000 <__rodata_start+0x1000>
4000255c: 9134ae73     	add	x19, x19, #0xd2b
40002560: 1400000a     	b	0x40002588 <launch_ktop+0xe4>
40002564: 297f9288     	ldp	w8, w4, [x20, #-0x4]
40002568: b85d4281     	ldur	w1, [x20, #-0x2c]
4000256c: d100a285     	sub	x5, x20, #0x28
40002570: aa1303e0     	mov	x0, x19
40002574: 530a7d03     	lsr	w3, w8, #10
40002578: 94000705     	bl	0x4000418c <uart_printf>
4000257c: f10006f7     	subs	x23, x23, #0x1
40002580: 9100c294     	add	x20, x20, #0x30
40002584: 54000120     	b.eq	0x400025a8 <launch_ktop+0x104>
40002588: b85f8288     	ldur	w8, [x20, #-0x8]
4000258c: 71000d1f     	cmp	w8, #0x3
40002590: 54ffff60     	b.eq	0x4000257c <launch_ktop+0xd8>
40002594: 7100091f     	cmp	w8, #0x2
40002598: aa1503e2     	mov	x2, x21
4000259c: 54fffe48     	b.hi	0x40002564 <launch_ktop+0xc0>
400025a0: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
400025a4: 17fffff0     	b	0x40002564 <launch_ktop+0xc0>
400025a8: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400025ac: 91254c00     	add	x0, x0, #0x953
400025b0: 940005e7     	bl	0x40003d4c <uart_puts>
400025b4: 52808114     	mov	w20, #0x408             // =1032
400025b8: 52800033     	mov	w19, #0x1               // =1
400025bc: 72a02014     	movk	w20, #0x100, lsl #16
400025c0: 14000003     	b	0x400025cc <launch_ktop+0x128>
400025c4: 7101c51f     	cmp	w8, #0x71
400025c8: 54000100     	b.eq	0x400025e8 <launch_ktop+0x144>
400025cc: 94000613     	bl	0x40003e18 <uart_getc>
400025d0: 12001c08     	and	w8, w0, #0xff
400025d4: 7100611f     	cmp	w8, #0x18
400025d8: 54ffff68     	b.hi	0x400025c4 <launch_ktop+0x120>
400025dc: 1ac82269     	lsl	w9, w19, w8
400025e0: 6a14013f     	tst	w9, w20
400025e4: 54ffff00     	b.eq	0x400025c4 <launch_ktop+0x120>
400025e8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400025ec: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400025f0: 91067000     	add	x0, x0, #0x19c
400025f4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400025f8: f9400bf7     	ldr	x23, [sp, #0x10]
400025fc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002600: 140005d3     	b	0x40003d4c <uart_puts>

0000000040002604 <script_init>:
40002604: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002608: 90000068     	adrp	x8, 0x4000e000 <E+0x2ff8>
4000260c: d503201f     	nop
40002610: 50026880     	adr	x0, 0x40007322 <__rodata_start+0x1322>
40002614: d0000021     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
40002618: 91125c21     	add	x1, x1, #0x497
4000261c: 910003fd     	mov	x29, sp
40002620: b9055d1f     	str	wzr, [x8, #0x55c]
40002624: 94000007     	bl	0x40002640 <script_set_var>
40002628: d0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000262c: 911d0000     	add	x0, x0, #0x740
40002630: b0000021     	adrp	x1, 0x40007000 <__rodata_start+0x1000>
40002634: 913cb421     	add	x1, x1, #0xf2d
40002638: a8c17bfd     	ldp	x29, x30, [sp], #0x10
4000263c: 14000001     	b	0x40002640 <script_set_var>

0000000040002640 <script_set_var>:
40002640: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002644: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002648: 90000077     	adrp	x23, 0x4000e000 <E+0x2ff8>
4000264c: 910003fd     	mov	x29, sp
40002650: b9455ee8     	ldr	w8, [x23, #0x55c]
40002654: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002658: aa0103f3     	mov	x19, x1
4000265c: aa0003f4     	mov	x20, x0
40002660: a90257f6     	stp	x22, x21, [sp, #0x20]
40002664: 7100051f     	cmp	w8, #0x1
40002668: 5400024b     	b.lt	0x400026b0 <script_set_var+0x70>
4000266c: aa1f03f8     	mov	x24, xzr
40002670: 90000075     	adrp	x21, 0x4000e000 <E+0x2ff8>
40002674: 912582b5     	add	x21, x21, #0x960
40002678: 90000076     	adrp	x22, 0x4000e000 <E+0x2ff8>
4000267c: 911582d6     	add	x22, x22, #0x560
40002680: aa1603e0     	mov	x0, x22
40002684: aa1403e1     	mov	x1, x20
40002688: 940001ec     	bl	0x40002e38 <kstrcmp>
4000268c: 340003e0     	cbz	w0, 0x40002708 <script_set_var+0xc8>
40002690: b9855ee8     	ldrsw	x8, [x23, #0x55c]
40002694: 91000718     	add	x24, x24, #0x1
40002698: 910202b5     	add	x21, x21, #0x80
4000269c: 910082d6     	add	x22, x22, #0x20
400026a0: eb08031f     	cmp	x24, x8
400026a4: 54fffeeb     	b.lt	0x40002680 <script_set_var+0x40>
400026a8: 71007d1f     	cmp	w8, #0x1f
400026ac: 5400038c     	b.gt	0x4000271c <script_set_var+0xdc>
400026b0: 90000075     	adrp	x21, 0x4000e000 <E+0x2ff8>
400026b4: 911582b5     	add	x21, x21, #0x560
400026b8: aa1403e1     	mov	x1, x20
400026bc: 93407d08     	sxtw	x8, w8
400026c0: 528003e2     	mov	w2, #0x1f               // =31
400026c4: 8b0816a0     	add	x0, x21, x8, lsl #5
400026c8: 94000202     	bl	0x40002ed0 <kstrncpy>
400026cc: b9855ee8     	ldrsw	x8, [x23, #0x55c]
400026d0: 90000074     	adrp	x20, 0x4000e000 <E+0x2ff8>
400026d4: 91258294     	add	x20, x20, #0x960
400026d8: aa1303e1     	mov	x1, x19
400026dc: 52800fe2     	mov	w2, #0x7f               // =127
400026e0: 8b0816a9     	add	x9, x21, x8, lsl #5
400026e4: 8b081e80     	add	x0, x20, x8, lsl #7
400026e8: 39007d3f     	strb	wzr, [x9, #0x1f]
400026ec: 940001f9     	bl	0x40002ed0 <kstrncpy>
400026f0: b9855ee8     	ldrsw	x8, [x23, #0x55c]
400026f4: 8b081e89     	add	x9, x20, x8, lsl #7
400026f8: 11000508     	add	w8, w8, #0x1
400026fc: b9055ee8     	str	w8, [x23, #0x55c]
40002700: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002704: 14000006     	b	0x4000271c <script_set_var+0xdc>
40002708: aa1503e0     	mov	x0, x21
4000270c: aa1303e1     	mov	x1, x19
40002710: 52800fe2     	mov	w2, #0x7f               // =127
40002714: 940001ef     	bl	0x40002ed0 <kstrncpy>
40002718: 3901febf     	strb	wzr, [x21, #0x7f]
4000271c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002720: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002724: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002728: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000272c: d65f03c0     	ret

0000000040002730 <script_get_var>:
40002730: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002734: a90257f6     	stp	x22, x21, [sp, #0x20]
40002738: 90000076     	adrp	x22, 0x4000e000 <E+0x2ff8>
4000273c: 910003fd     	mov	x29, sp
40002740: b9455ec8     	ldr	w8, [x22, #0x55c]
40002744: a9015ff8     	stp	x24, x23, [sp, #0x10]
40002748: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000274c: 7100051f     	cmp	w8, #0x1
40002750: 540002ab     	b.lt	0x400027a4 <script_get_var+0x74>
40002754: aa0003f4     	mov	x20, x0
40002758: aa1f03f7     	mov	x23, xzr
4000275c: 90000073     	adrp	x19, 0x4000e000 <E+0x2ff8>
40002760: 91258273     	add	x19, x19, #0x960
40002764: 90000075     	adrp	x21, 0x4000e000 <E+0x2ff8>
40002768: 911582b5     	add	x21, x21, #0x560
4000276c: 90000038     	adrp	x24, 0x40006000 <__rodata_start>
40002770: 9137a318     	add	x24, x24, #0xde8
40002774: aa1503e0     	mov	x0, x21
40002778: aa1403e1     	mov	x1, x20
4000277c: 940001af     	bl	0x40002e38 <kstrcmp>
40002780: 34000160     	cbz	w0, 0x400027ac <script_get_var+0x7c>
40002784: b9855ec8     	ldrsw	x8, [x22, #0x55c]
40002788: 910006f7     	add	x23, x23, #0x1
4000278c: 91020273     	add	x19, x19, #0x80
40002790: 910082b5     	add	x21, x21, #0x20
40002794: eb0802ff     	cmp	x23, x8
40002798: 54fffeeb     	b.lt	0x40002774 <script_get_var+0x44>
4000279c: aa1803f3     	mov	x19, x24
400027a0: 14000003     	b	0x400027ac <script_get_var+0x7c>
400027a4: 90000033     	adrp	x19, 0x40006000 <__rodata_start>
400027a8: 9137a273     	add	x19, x19, #0xde8
400027ac: aa1303e0     	mov	x0, x19
400027b0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400027b4: a94257f6     	ldp	x22, x21, [sp, #0x20]
400027b8: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400027bc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400027c0: d65f03c0     	ret

00000000400027c4 <script_expand_vars>:
400027c4: d10203ff     	sub	sp, sp, #0x80
400027c8: a9036ffc     	stp	x28, x27, [sp, #0x30]
400027cc: 2a1f03fc     	mov	w28, wzr
400027d0: a90467fa     	stp	x26, x25, [sp, #0x40]
400027d4: 90000039     	adrp	x25, 0x40006000 <__rodata_start>
400027d8: 9137a339     	add	x25, x25, #0xde8
400027dc: a9055ff8     	stp	x24, x23, [sp, #0x50]
400027e0: 910003f8     	mov	x24, sp
400027e4: 9000007a     	adrp	x26, 0x4000e000 <E+0x2ff8>
400027e8: a90657f6     	stp	x22, x21, [sp, #0x60]
400027ec: 2a1f03f6     	mov	w22, wzr
400027f0: a9074ff4     	stp	x20, x19, [sp, #0x70]
400027f4: aa0103f3     	mov	x19, x1
400027f8: aa0003f4     	mov	x20, x0
400027fc: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002800: 910083fd     	add	x29, sp, #0x20
40002804: 14000001     	b	0x40002808 <script_expand_vars+0x44>
40002808: 93407f89     	sxtw	x9, w28
4000280c: 38696a88     	ldrb	w8, [x20, x9]
40002810: 7100911f     	cmp	w8, #0x24
40002814: 540000e0     	b.eq	0x40002830 <script_expand_vars+0x6c>
40002818: 34000788     	cbz	w8, 0x40002908 <script_expand_vars+0x144>
4000281c: 110006ca     	add	w10, w22, #0x1
40002820: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002824: 1100053c     	add	w28, w9, #0x1
40002828: 2a0a03f6     	mov	w22, w10
4000282c: 17fffff7     	b	0x40002808 <script_expand_vars+0x44>
40002830: aa1f03e8     	mov	x8, xzr
40002834: 14000005     	b	0x40002848 <script_expand_vars+0x84>
40002838: 9100050a     	add	x10, x8, #0x1
4000283c: 38286b09     	strb	w9, [x24, x8]
40002840: d1000789     	sub	x9, x28, #0x1
40002844: aa0a03e8     	mov	x8, x10
40002848: 9100053c     	add	x28, x9, #0x1
4000284c: 14000004     	b	0x4000285c <script_expand_vars+0x98>
40002850: f100791f     	cmp	x8, #0x1e
40002854: 9100079c     	add	x28, x28, #0x1
40002858: 54ffff09     	b.ls	0x40002838 <script_expand_vars+0x74>
4000285c: 387c6a89     	ldrb	w9, [x20, x28]
40002860: 121a792a     	and	w10, w9, #0xffffffdf
40002864: 5101054a     	sub	w10, w10, #0x41
40002868: 7100695f     	cmp	w10, #0x1a
4000286c: 54ffff23     	b.lo	0x40002850 <script_expand_vars+0x8c>
40002870: 71017d3f     	cmp	w9, #0x5f
40002874: 54fffee0     	b.eq	0x40002850 <script_expand_vars+0x8c>
40002878: 5100c12a     	sub	w10, w9, #0x30
4000287c: 7100255f     	cmp	w10, #0x9
40002880: 54fffe89     	b.ls	0x40002850 <script_expand_vars+0x8c>
40002884: b9455f49     	ldr	w9, [x26, #0x55c]
40002888: 38286b1f     	strb	wzr, [x24, x8]
4000288c: 7100053f     	cmp	w9, #0x1
40002890: 5400028b     	b.lt	0x400028e0 <script_expand_vars+0x11c>
40002894: aa1f03fb     	mov	x27, xzr
40002898: 90000075     	adrp	x21, 0x4000e000 <E+0x2ff8>
4000289c: 911582b5     	add	x21, x21, #0x560
400028a0: 90000077     	adrp	x23, 0x4000e000 <E+0x2ff8>
400028a4: 912582f7     	add	x23, x23, #0x960
400028a8: 910003e1     	mov	x1, sp
400028ac: aa1503e0     	mov	x0, x21
400028b0: 94000162     	bl	0x40002e38 <kstrcmp>
400028b4: 34000100     	cbz	w0, 0x400028d4 <script_expand_vars+0x110>
400028b8: b9855f48     	ldrsw	x8, [x26, #0x55c]
400028bc: 9100077b     	add	x27, x27, #0x1
400028c0: 910202f7     	add	x23, x23, #0x80
400028c4: 910082b5     	add	x21, x21, #0x20
400028c8: eb08037f     	cmp	x27, x8
400028cc: 54fffeeb     	b.lt	0x400028a8 <script_expand_vars+0xe4>
400028d0: aa1903f7     	mov	x23, x25
400028d4: 394002e8     	ldrb	w8, [x23]
400028d8: 350000a8     	cbnz	w8, 0x400028ec <script_expand_vars+0x128>
400028dc: 17ffffcb     	b	0x40002808 <script_expand_vars+0x44>
400028e0: aa1903f7     	mov	x23, x25
400028e4: 394002e8     	ldrb	w8, [x23]
400028e8: 34fff908     	cbz	w8, 0x40002808 <script_expand_vars+0x44>
400028ec: 8b36c269     	add	x9, x19, w22, sxtw
400028f0: 910006ea     	add	x10, x23, #0x1
400028f4: 38001528     	strb	w8, [x9], #0x1
400028f8: 110006d6     	add	w22, w22, #0x1
400028fc: 38401548     	ldrb	w8, [x10], #0x1
40002900: 35ffffa8     	cbnz	w8, 0x400028f4 <script_expand_vars+0x130>
40002904: 17ffffc1     	b	0x40002808 <script_expand_vars+0x44>
40002908: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
4000290c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002910: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002914: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002918: a94467fa     	ldp	x26, x25, [sp, #0x40]
4000291c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002920: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002924: 910203ff     	add	sp, sp, #0x80
40002928: d65f03c0     	ret

000000004000292c <script_execute_line>:
4000292c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002930: a9014ffc     	stp	x28, x19, [sp, #0x10]
40002934: 910003fd     	mov	x29, sp
40002938: d10803ff     	sub	sp, sp, #0x200
4000293c: 14000004     	b	0x4000294c <script_execute_line+0x20>
40002940: 7100811f     	cmp	w8, #0x20
40002944: 54000121     	b.ne	0x40002968 <script_execute_line+0x3c>
40002948: 91000400     	add	x0, x0, #0x1
4000294c: 39400008     	ldrb	w8, [x0]
40002950: 71007d1f     	cmp	w8, #0x1f
40002954: 54ffff6c     	b.gt	0x40002940 <script_execute_line+0x14>
40002958: 7100251f     	cmp	w8, #0x9
4000295c: 54ffff60     	b.eq	0x40002948 <script_execute_line+0x1c>
40002960: 34001d28     	cbz	w8, 0x40002d04 <script_execute_line+0x3d8>
40002964: 14000003     	b	0x40002970 <script_execute_line+0x44>
40002968: 71008d1f     	cmp	w8, #0x23
4000296c: 54001cc0     	b.eq	0x40002d04 <script_execute_line+0x3d8>
40002970: 910403e1     	add	x1, sp, #0x100
40002974: 910403f3     	add	x19, sp, #0x100
40002978: 97ffff93     	bl	0x400027c4 <script_expand_vars>
4000297c: 394403e8     	ldrb	w8, [sp, #0x100]
40002980: 34001be8     	cbz	w8, 0x40002cfc <script_execute_line+0x3d0>
40002984: 0f018400     	movi	v0.4h, #0x20
40002988: 4f01e401     	movi	v1.16b, #0x20
4000298c: 394407ea     	ldrb	w10, [sp, #0x101]
40002990: aa1f03e9     	mov	x9, xzr
40002994: 9100426b     	add	x11, x19, #0x10
40002998: 2a0803ec     	mov	w12, w8
4000299c: 14000004     	b	0x400029ac <script_execute_line+0x80>
400029a0: 91000529     	add	x9, x9, #0x1
400029a4: 38696a6c     	ldrb	w12, [x19, x9]
400029a8: 34000a2c     	cbz	w12, 0x40002aec <script_execute_line+0x1c0>
400029ac: b4ffffa9     	cbz	x9, 0x400029a0 <script_execute_line+0x74>
400029b0: 7100f59f     	cmp	w12, #0x3d
400029b4: 54ffff61     	b.ne	0x400029a0 <script_execute_line+0x74>
400029b8: 8b13012c     	add	x12, x9, x19
400029bc: 385ff18d     	ldurb	w13, [x12, #-0x1]
400029c0: 7100f5bf     	cmp	w13, #0x3d
400029c4: 54fffee0     	b.eq	0x400029a0 <script_execute_line+0x74>
400029c8: 3940058c     	ldrb	w12, [x12, #0x1]
400029cc: 7100f59f     	cmp	w12, #0x3d
400029d0: 54fffe80     	b.eq	0x400029a0 <script_execute_line+0x74>
400029d4: f100113f     	cmp	x9, #0x4
400029d8: 54000082     	b.hs	0x400029e8 <script_execute_line+0xbc>
400029dc: aa1f03ec     	mov	x12, xzr
400029e0: 2a1f03ed     	mov	w13, wzr
400029e4: 1400002f     	b	0x40002aa0 <script_execute_line+0x174>
400029e8: f100813f     	cmp	x9, #0x20
400029ec: 54000082     	b.hs	0x400029fc <script_execute_line+0xd0>
400029f0: aa1f03ec     	mov	x12, xzr
400029f4: 2a1f03ed     	mov	w13, wzr
400029f8: 14000018     	b	0x40002a58 <script_execute_line+0x12c>
400029fc: 6f00e402     	movi	v2.2d, #0000000000000000
40002a00: 6f00e403     	movi	v3.2d, #0000000000000000
40002a04: 927be92d     	and	x13, x9, #0xffffffffffffffe0
40002a08: 927be52c     	and	x12, x9, #0x7fffffffffffffe0
40002a0c: aa0b03ee     	mov	x14, x11
40002a10: ad7f95c4     	ldp	q4, q5, [x14, #-0x10]
40002a14: f10081ad     	subs	x13, x13, #0x20
40002a18: 910081ce     	add	x14, x14, #0x20
40002a1c: 6e218c84     	cmeq	v4.16b, v4.16b, v1.16b
40002a20: 6e218ca5     	cmeq	v5.16b, v5.16b, v1.16b
40002a24: 4ea41c42     	orr	v2.16b, v2.16b, v4.16b
40002a28: 4ea51c63     	orr	v3.16b, v3.16b, v5.16b
40002a2c: 54ffff21     	b.ne	0x40002a10 <script_execute_line+0xe4>
40002a30: 4ea21c62     	orr	v2.16b, v3.16b, v2.16b
40002a34: eb0c013f     	cmp	x9, x12
40002a38: 4f0f5442     	shl	v2.16b, v2.16b, #0x7
40002a3c: 4e20a842     	cmlt	v2.16b, v2.16b, #0
40002a40: 6e30a842     	umaxv	b2, v2.16b
40002a44: 1e26004d     	fmov	w13, s2
40002a48: 120001ad     	and	w13, w13, #0x1
40002a4c: 540003a0     	b.eq	0x40002ac0 <script_execute_line+0x194>
40002a50: f27e093f     	tst	x9, #0x1c
40002a54: 54000260     	b.eq	0x40002aa0 <script_execute_line+0x174>
40002a58: 0e020da2     	dup	v2.4h, w13
40002a5c: 927ef52d     	and	x13, x9, #0xfffffffffffffffc
40002a60: 8b0c026e     	add	x14, x19, x12
40002a64: cb0d018d     	sub	x13, x12, x13
40002a68: 927ef12c     	and	x12, x9, #0x7ffffffffffffffc
40002a6c: bc4045c3     	ldr	s3, [x14], #0x4
40002a70: b10011ad     	adds	x13, x13, #0x4
40002a74: 2f08a463     	ushll	v3.8h, v3.8b, #0x0
40002a78: 2e608c63     	cmeq	v3.4h, v3.4h, v0.4h
40002a7c: 0ea31c42     	orr	v2.8b, v2.8b, v3.8b
40002a80: 54ffff61     	b.ne	0x40002a6c <script_execute_line+0x140>
40002a84: 0f1f5442     	shl	v2.4h, v2.4h, #0xf
40002a88: eb0c013f     	cmp	x9, x12
40002a8c: 0e60a842     	cmlt	v2.4h, v2.4h, #0
40002a90: 2e70a842     	umaxv	h2, v2.4h
40002a94: 1e26004d     	fmov	w13, s2
40002a98: 120001ad     	and	w13, w13, #0x1
40002a9c: 54000120     	b.eq	0x40002ac0 <script_execute_line+0x194>
40002aa0: 386c6a6e     	ldrb	w14, [x19, x12]
40002aa4: 9100058c     	add	x12, x12, #0x1
40002aa8: 710081df     	cmp	w14, #0x20
40002aac: 1a9f15ad     	csinc	w13, w13, wzr, ne
40002ab0: eb0c013f     	cmp	x9, x12
40002ab4: 54ffff61     	b.ne	0x40002aa0 <script_execute_line+0x174>
40002ab8: 710001bf     	cmp	w13, #0x0
40002abc: 1a9f07ed     	cset	w13, ne
40002ac0: 3707f70d     	tbnz	w13, #0x0, 0x400029a0 <script_execute_line+0x74>
40002ac4: 7101a51f     	cmp	w8, #0x69
40002ac8: 54fff6c0     	b.eq	0x400029a0 <script_execute_line+0x74>
40002acc: 7101995f     	cmp	w10, #0x66
40002ad0: 54fff680     	b.eq	0x400029a0 <script_execute_line+0x74>
40002ad4: 910403e8     	add	x8, sp, #0x100
40002ad8: 910403e0     	add	x0, sp, #0x100
40002adc: 8b090101     	add	x1, x8, x9
40002ae0: 3800143f     	strb	wzr, [x1], #0x1
40002ae4: 97fffed7     	bl	0x40002640 <script_set_var>
40002ae8: 14000087     	b	0x40002d04 <script_execute_line+0x3d8>
40002aec: 394403e8     	ldrb	w8, [sp, #0x100]
40002af0: 7101a51f     	cmp	w8, #0x69
40002af4: 54001041     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002af8: 7101995f     	cmp	w10, #0x66
40002afc: 54001001     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002b00: 39440be8     	ldrb	w8, [sp, #0x102]
40002b04: 7100811f     	cmp	w8, #0x20
40002b08: 54000fa1     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002b0c: 39440fe9     	ldrb	w9, [sp, #0x103]
40002b10: 7100813f     	cmp	w9, #0x20
40002b14: 54000081     	b.ne	0x40002b24 <script_execute_line+0x1f8>
40002b18: aa1f03e9     	mov	x9, xzr
40002b1c: 52800068     	mov	w8, #0x3                // =3
40002b20: 14000014     	b	0x40002b70 <script_execute_line+0x244>
40002b24: 910403ea     	add	x10, sp, #0x100
40002b28: aa1f03e8     	mov	x8, xzr
40002b2c: 910303eb     	add	x11, sp, #0xc0
40002b30: 9100114a     	add	x10, x10, #0x4
40002b34: 34000189     	cbz	w9, 0x40002b64 <script_execute_line+0x238>
40002b38: f100f91f     	cmp	x8, #0x3e
40002b3c: 54000148     	b.hi	0x40002b64 <script_execute_line+0x238>
40002b40: 38286969     	strb	w9, [x11, x8]
40002b44: 38686949     	ldrb	w9, [x10, x8]
40002b48: 9100050c     	add	x12, x8, #0x1
40002b4c: aa0c03e8     	mov	x8, x12
40002b50: 7100813f     	cmp	w9, #0x20
40002b54: 54ffff01     	b.ne	0x40002b34 <script_execute_line+0x208>
40002b58: 11000d8a     	add	w10, w12, #0x3
40002b5c: 2a0c03e8     	mov	w8, w12
40002b60: 14000002     	b	0x40002b68 <script_execute_line+0x23c>
40002b64: 11000d0a     	add	w10, w8, #0x3
40002b68: 2a0803e9     	mov	w9, w8
40002b6c: 2a0a03e8     	mov	w8, w10
40002b70: 910303ea     	add	x10, sp, #0xc0
40002b74: 3829695f     	strb	wzr, [x10, x9]
40002b78: 910403e9     	add	x9, sp, #0x100
40002b7c: 3868692a     	ldrb	w10, [x9, x8]
40002b80: 7100815f     	cmp	w10, #0x20
40002b84: 54000061     	b.ne	0x40002b90 <script_execute_line+0x264>
40002b88: 91000508     	add	x8, x8, #0x1
40002b8c: 17fffffc     	b	0x40002b7c <script_execute_line+0x250>
40002b90: 7100855f     	cmp	w10, #0x21
40002b94: 54000060     	b.eq	0x40002ba0 <script_execute_line+0x274>
40002b98: 7100f55f     	cmp	w10, #0x3d
40002b9c: 540000e1     	b.ne	0x40002bb8 <script_execute_line+0x28c>
40002ba0: 11000509     	add	w9, w8, #0x1
40002ba4: 910403ea     	add	x10, sp, #0x100
40002ba8: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002bac: 9100090a     	add	x10, x8, #0x2
40002bb0: 7100f53f     	cmp	w9, #0x3d
40002bb4: 9a880148     	csel	x8, x10, x8, eq
40002bb8: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002bbc: 910403ea     	add	x10, sp, #0x100
40002bc0: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002bc4: 8b088129     	add	x9, x9, x8, lsl #32
40002bc8: 8b28c14a     	add	x10, x10, w8, sxtw
40002bcc: 51000508     	sub	w8, w8, #0x1
40002bd0: 3840154c     	ldrb	w12, [x10], #0x1
40002bd4: 8b0b0129     	add	x9, x9, x11
40002bd8: 11000508     	add	w8, w8, #0x1
40002bdc: 7100819f     	cmp	w12, #0x20
40002be0: 54ffff80     	b.eq	0x40002bd0 <script_execute_line+0x2a4>
40002be4: 9360fd2c     	asr	x12, x9, #32
40002be8: 910403e9     	add	x9, sp, #0x100
40002bec: 386c692d     	ldrb	w13, [x9, x12]
40002bf0: 710081bf     	cmp	w13, #0x20
40002bf4: 54000061     	b.ne	0x40002c00 <script_execute_line+0x2d4>
40002bf8: aa1f03ea     	mov	x10, xzr
40002bfc: 14000010     	b	0x40002c3c <script_execute_line+0x310>
40002c00: aa1f03eb     	mov	x11, xzr
40002c04: 910203ec     	add	x12, sp, #0x80
40002c08: 3400016d     	cbz	w13, 0x40002c34 <script_execute_line+0x308>
40002c0c: f100f97f     	cmp	x11, #0x3e
40002c10: 54000128     	b.hi	0x40002c34 <script_execute_line+0x308>
40002c14: 382b698d     	strb	w13, [x12, x11]
40002c18: 386b694d     	ldrb	w13, [x10, x11]
40002c1c: 9100056e     	add	x14, x11, #0x1
40002c20: 11000508     	add	w8, w8, #0x1
40002c24: aa0e03eb     	mov	x11, x14
40002c28: 710081bf     	cmp	w13, #0x20
40002c2c: 54fffee1     	b.ne	0x40002c08 <script_execute_line+0x2dc>
40002c30: 2a0e03eb     	mov	w11, w14
40002c34: 93407d0c     	sxtw	x12, w8
40002c38: 2a0b03ea     	mov	w10, w11
40002c3c: d3607d8d     	lsl	x13, x12, #32
40002c40: 910203eb     	add	x11, sp, #0x80
40002c44: d2c0006f     	mov	x15, #0x300000000       // =12884901888
40002c48: d2c00050     	mov	x16, #0x200000000       // =8589934592
40002c4c: d2c0002e     	mov	x14, #0x100000000       // =4294967296
40002c50: 11001108     	add	w8, w8, #0x4
40002c54: 382a697f     	strb	wzr, [x11, x10]
40002c58: 8b0f01aa     	add	x10, x13, x15
40002c5c: 8b1001ab     	add	x11, x13, x16
40002c60: 8b0e01ad     	add	x13, x13, x14
40002c64: 8b0c0129     	add	x9, x9, x12
40002c68: 3840152c     	ldrb	w12, [x9], #0x1
40002c6c: 7100819f     	cmp	w12, #0x20
40002c70: 540000c1     	b.ne	0x40002c88 <script_execute_line+0x35c>
40002c74: 11000508     	add	w8, w8, #0x1
40002c78: 8b0e014a     	add	x10, x10, x14
40002c7c: 8b0e016b     	add	x11, x11, x14
40002c80: 8b0e01ad     	add	x13, x13, x14
40002c84: 17fffff9     	b	0x40002c68 <script_execute_line+0x33c>
40002c88: 7101d19f     	cmp	w12, #0x74
40002c8c: 54000381     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002c90: 9360fdac     	asr	x12, x13, #32
40002c94: 910403e9     	add	x9, sp, #0x100
40002c98: 386c692c     	ldrb	w12, [x9, x12]
40002c9c: 7101a19f     	cmp	w12, #0x68
40002ca0: 540002e1     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002ca4: 9360fd6b     	asr	x11, x11, #32
40002ca8: 386b6929     	ldrb	w9, [x9, x11]
40002cac: 7101953f     	cmp	w9, #0x65
40002cb0: 54000261     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002cb4: 9360fd4a     	asr	x10, x10, #32
40002cb8: 910403e9     	add	x9, sp, #0x100
40002cbc: 386a692a     	ldrb	w10, [x9, x10]
40002cc0: 7101b95f     	cmp	w10, #0x6e
40002cc4: 540001c1     	b.ne	0x40002cfc <script_execute_line+0x3d0>
40002cc8: 8b28c128     	add	x8, x9, w8, sxtw
40002ccc: d1000501     	sub	x1, x8, #0x1
40002cd0: 38401c28     	ldrb	w8, [x1, #0x1]!
40002cd4: 7100811f     	cmp	w8, #0x20
40002cd8: 54ffffc0     	b.eq	0x40002cd0 <script_execute_line+0x3a4>
40002cdc: 910003e0     	mov	x0, sp
40002ce0: 94000075     	bl	0x40002eb4 <kstrcpy>
40002ce4: 910303e0     	add	x0, sp, #0xc0
40002ce8: 910203e1     	add	x1, sp, #0x80
40002cec: 94000053     	bl	0x40002e38 <kstrcmp>
40002cf0: 350000a0     	cbnz	w0, 0x40002d04 <script_execute_line+0x3d8>
40002cf4: 910003e0     	mov	x0, sp
40002cf8: 14000002     	b	0x40002d00 <script_execute_line+0x3d4>
40002cfc: 910403e0     	add	x0, sp, #0x100
40002d00: 97fff8f4     	bl	0x400010d0 <execute_command>
40002d04: 2a1f03e0     	mov	w0, wzr
40002d08: 910803ff     	add	sp, sp, #0x200
40002d0c: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002d10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002d14: d65f03c0     	ret

0000000040002d18 <script_run_file>:
40002d18: d10503ff     	sub	sp, sp, #0x140
40002d1c: a9107bfd     	stp	x29, x30, [sp, #0x100]
40002d20: 910403fd     	add	x29, sp, #0x100
40002d24: f9008bfc     	str	x28, [sp, #0x110]
40002d28: a91257f6     	stp	x22, x21, [sp, #0x120]
40002d2c: a9134ff4     	stp	x20, x19, [sp, #0x130]
40002d30: aa0003f4     	mov	x20, x0
40002d34: 940008f2     	bl	0x400050fc <vfs_find>
40002d38: b4000080     	cbz	x0, 0x40002d48 <script_run_file+0x30>
40002d3c: b9402008     	ldr	w8, [x0, #0x20]
40002d40: aa0003f3     	mov	x19, x0
40002d44: 340000e8     	cbz	w8, 0x40002d60 <script_run_file+0x48>
40002d48: b0000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40002d4c: 9121a800     	add	x0, x0, #0x86a
40002d50: aa1403e1     	mov	x1, x20
40002d54: 9400050e     	bl	0x4000418c <uart_printf>
40002d58: 12800000     	mov	w0, #-0x1               // =-1
40002d5c: 14000021     	b	0x40002de0 <script_run_file+0xc8>
40002d60: f9401668     	ldr	x8, [x19, #0x28]
40002d64: aa1f03f4     	mov	x20, xzr
40002d68: 2a1f03e9     	mov	w9, wzr
40002d6c: 9100c275     	add	x21, x19, #0x30
40002d70: 910003f6     	mov	x22, sp
40002d74: 14000008     	b	0x40002d94 <script_run_file+0x7c>
40002d78: 7100053f     	cmp	w9, #0x1
40002d7c: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002d80: 2a1f03e9     	mov	w9, wzr
40002d84: 5400022a     	b.ge	0x40002dc8 <script_run_file+0xb0>
40002d88: 91000694     	add	x20, x20, #0x1
40002d8c: eb08029f     	cmp	x20, x8
40002d90: 54000268     	b.hi	0x40002ddc <script_run_file+0xc4>
40002d94: eb08029f     	cmp	x20, x8
40002d98: 54ffff00     	b.eq	0x40002d78 <script_run_file+0x60>
40002d9c: 38746aaa     	ldrb	w10, [x21, x20]
40002da0: 7100295f     	cmp	w10, #0xa
40002da4: 54fffea0     	b.eq	0x40002d78 <script_run_file+0x60>
40002da8: 7100355f     	cmp	w10, #0xd
40002dac: 54fffee0     	b.eq	0x40002d88 <script_run_file+0x70>
40002db0: 7103f93f     	cmp	w9, #0xfe
40002db4: 54fffeac     	b.gt	0x40002d88 <script_run_file+0x70>
40002db8: 1100052b     	add	w11, w9, #0x1
40002dbc: 3829caca     	strb	w10, [x22, w9, sxtw]
40002dc0: 2a0b03e9     	mov	w9, w11
40002dc4: 17fffff1     	b	0x40002d88 <script_run_file+0x70>
40002dc8: 910003e0     	mov	x0, sp
40002dcc: 97fffed8     	bl	0x4000292c <script_execute_line>
40002dd0: f9401668     	ldr	x8, [x19, #0x28]
40002dd4: 2a1f03e9     	mov	w9, wzr
40002dd8: 17ffffec     	b	0x40002d88 <script_run_file+0x70>
40002ddc: 2a1f03e0     	mov	w0, wzr
40002de0: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002de4: f9408bfc     	ldr	x28, [sp, #0x110]
40002de8: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002dec: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002df0: 910503ff     	add	sp, sp, #0x140
40002df4: d65f03c0     	ret

0000000040002df8 <kstrlen>:
40002df8: b40000c0     	cbz	x0, 0x40002e10 <kstrlen+0x18>
40002dfc: aa1f03e8     	mov	x8, xzr
40002e00: 38686809     	ldrb	w9, [x0, x8]
40002e04: 91000508     	add	x8, x8, #0x1
40002e08: 35ffffc9     	cbnz	w9, 0x40002e00 <kstrlen+0x8>
40002e0c: d1000500     	sub	x0, x8, #0x1
40002e10: d65f03c0     	ret

0000000040002e14 <kstrcat>:
40002e14: b4000100     	cbz	x0, 0x40002e34 <kstrcat+0x20>
40002e18: b40000e1     	cbz	x1, 0x40002e34 <kstrcat+0x20>
40002e1c: d1000408     	sub	x8, x0, #0x1
40002e20: 38401d09     	ldrb	w9, [x8, #0x1]!
40002e24: 35ffffe9     	cbnz	w9, 0x40002e20 <kstrcat+0xc>
40002e28: 38401429     	ldrb	w9, [x1], #0x1
40002e2c: 38001509     	strb	w9, [x8], #0x1
40002e30: 35ffffc9     	cbnz	w9, 0x40002e28 <kstrcat+0x14>
40002e34: d65f03c0     	ret

0000000040002e38 <kstrcmp>:
40002e38: aa0003e8     	mov	x8, x0
40002e3c: 12800000     	mov	w0, #-0x1               // =-1
40002e40: b4000188     	cbz	x8, 0x40002e70 <kstrcmp+0x38>
40002e44: b4000161     	cbz	x1, 0x40002e70 <kstrcmp+0x38>
40002e48: 38401509     	ldrb	w9, [x8], #0x1
40002e4c: 340000e9     	cbz	w9, 0x40002e68 <kstrcmp+0x30>
40002e50: 3940002a     	ldrb	w10, [x1]
40002e54: 6b0a013f     	cmp	w9, w10
40002e58: 54000081     	b.ne	0x40002e68 <kstrcmp+0x30>
40002e5c: 38401509     	ldrb	w9, [x8], #0x1
40002e60: 91000421     	add	x1, x1, #0x1
40002e64: 35ffff69     	cbnz	w9, 0x40002e50 <kstrcmp+0x18>
40002e68: 39400028     	ldrb	w8, [x1]
40002e6c: 4b080120     	sub	w0, w9, w8
40002e70: d65f03c0     	ret

0000000040002e74 <kstrncmp>:
40002e74: 12800008     	mov	w8, #-0x1               // =-1
40002e78: b4000160     	cbz	x0, 0x40002ea4 <kstrncmp+0x30>
40002e7c: b4000141     	cbz	x1, 0x40002ea4 <kstrncmp+0x30>
40002e80: b4000102     	cbz	x2, 0x40002ea0 <kstrncmp+0x2c>
40002e84: 38401408     	ldrb	w8, [x0], #0x1
40002e88: 38401429     	ldrb	w9, [x1], #0x1
40002e8c: 34000108     	cbz	w8, 0x40002eac <kstrncmp+0x38>
40002e90: 6b09011f     	cmp	w8, w9
40002e94: 540000c1     	b.ne	0x40002eac <kstrncmp+0x38>
40002e98: f1000442     	subs	x2, x2, #0x1
40002e9c: 54ffff41     	b.ne	0x40002e84 <kstrncmp+0x10>
40002ea0: 2a1f03e8     	mov	w8, wzr
40002ea4: 2a0803e0     	mov	w0, w8
40002ea8: d65f03c0     	ret
40002eac: 4b090100     	sub	w0, w8, w9
40002eb0: d65f03c0     	ret

0000000040002eb4 <kstrcpy>:
40002eb4: b40000c0     	cbz	x0, 0x40002ecc <kstrcpy+0x18>
40002eb8: b40000a1     	cbz	x1, 0x40002ecc <kstrcpy+0x18>
40002ebc: aa0003e8     	mov	x8, x0
40002ec0: 38401429     	ldrb	w9, [x1], #0x1
40002ec4: 38001509     	strb	w9, [x8], #0x1
40002ec8: 35ffffc9     	cbnz	w9, 0x40002ec0 <kstrcpy+0xc>
40002ecc: d65f03c0     	ret

0000000040002ed0 <kstrncpy>:
40002ed0: b4000660     	cbz	x0, 0x40002f9c <kstrncpy+0xcc>
40002ed4: b4000641     	cbz	x1, 0x40002f9c <kstrncpy+0xcc>
40002ed8: b4000622     	cbz	x2, 0x40002f9c <kstrncpy+0xcc>
40002edc: aa0003e9     	mov	x9, x0
40002ee0: 9100440a     	add	x10, x0, #0x11
40002ee4: aa0003e8     	mov	x8, x0
40002ee8: 3840142b     	ldrb	w11, [x1], #0x1
40002eec: 3800150b     	strb	w11, [x8], #0x1
40002ef0: 340000cb     	cbz	w11, 0x40002f08 <kstrncpy+0x38>
40002ef4: f1000442     	subs	x2, x2, #0x1
40002ef8: 9100054a     	add	x10, x10, #0x1
40002efc: aa0803e9     	mov	x9, x8
40002f00: 54ffff41     	b.ne	0x40002ee8 <kstrncpy+0x18>
40002f04: 14000026     	b	0x40002f9c <kstrncpy+0xcc>
40002f08: f1001c5f     	cmp	x2, #0x7
40002f0c: 54000068     	b.hi	0x40002f18 <kstrncpy+0x48>
40002f10: aa0203ea     	mov	x10, x2
40002f14: 1400001f     	b	0x40002f90 <kstrncpy+0xc0>
40002f18: f100805f     	cmp	x2, #0x20
40002f1c: 54000062     	b.hs	0x40002f28 <kstrncpy+0x58>
40002f20: aa1f03eb     	mov	x11, xzr
40002f24: 1400000c     	b	0x40002f54 <kstrncpy+0x84>
40002f28: 6f00e400     	movi	v0.2d, #0000000000000000
40002f2c: 927be84b     	and	x11, x2, #0xffffffffffffffe0
40002f30: aa0b03ec     	mov	x12, x11
40002f34: f100818c     	subs	x12, x12, #0x20
40002f38: ad3f8140     	stp	q0, q0, [x10, #-0x10]
40002f3c: 9100814a     	add	x10, x10, #0x20
40002f40: 54ffffa1     	b.ne	0x40002f34 <kstrncpy+0x64>
40002f44: eb0b005f     	cmp	x2, x11
40002f48: 540002a0     	b.eq	0x40002f9c <kstrncpy+0xcc>
40002f4c: f27d045f     	tst	x2, #0x18
40002f50: 540001c0     	b.eq	0x40002f88 <kstrncpy+0xb8>
40002f54: 6f00e400     	movi	v0.2d, #0000000000000000
40002f58: 927df04c     	and	x12, x2, #0xfffffffffffffff8
40002f5c: 9240084a     	and	x10, x2, #0x7
40002f60: 8b0c0108     	add	x8, x8, x12
40002f64: cb0c016d     	sub	x13, x11, x12
40002f68: 9100056b     	add	x11, x11, #0x1
40002f6c: b10021ad     	adds	x13, x13, #0x8
40002f70: fc2b6920     	str	d0, [x9, x11]
40002f74: 9100216b     	add	x11, x11, #0x8
40002f78: 54ffffa1     	b.ne	0x40002f6c <kstrncpy+0x9c>
40002f7c: eb0c005f     	cmp	x2, x12
40002f80: 54000081     	b.ne	0x40002f90 <kstrncpy+0xc0>
40002f84: 14000006     	b	0x40002f9c <kstrncpy+0xcc>
40002f88: 9240104a     	and	x10, x2, #0x1f
40002f8c: 8b0b0108     	add	x8, x8, x11
40002f90: f100054a     	subs	x10, x10, #0x1
40002f94: 3800151f     	strb	wzr, [x8], #0x1
40002f98: 54ffffc1     	b.ne	0x40002f90 <kstrncpy+0xc0>
40002f9c: d65f03c0     	ret

0000000040002fa0 <kmemset>:
40002fa0: b4000500     	cbz	x0, 0x40003040 <kmemset+0xa0>
40002fa4: b40004e2     	cbz	x2, 0x40003040 <kmemset+0xa0>
40002fa8: f100205f     	cmp	x2, #0x8
40002fac: 54000082     	b.hs	0x40002fbc <kmemset+0x1c>
40002fb0: aa0003e8     	mov	x8, x0
40002fb4: aa0203e9     	mov	x9, x2
40002fb8: 1400001f     	b	0x40003034 <kmemset+0x94>
40002fbc: f100805f     	cmp	x2, #0x20
40002fc0: 54000062     	b.hs	0x40002fcc <kmemset+0x2c>
40002fc4: aa1f03ea     	mov	x10, xzr
40002fc8: 1400000d     	b	0x40002ffc <kmemset+0x5c>
40002fcc: 4e010c20     	dup	v0.16b, w1
40002fd0: 927be84a     	and	x10, x2, #0xffffffffffffffe0
40002fd4: 91004008     	add	x8, x0, #0x10
40002fd8: aa0a03e9     	mov	x9, x10
40002fdc: f1008129     	subs	x9, x9, #0x20
40002fe0: ad3f8100     	stp	q0, q0, [x8, #-0x10]
40002fe4: 91008108     	add	x8, x8, #0x20
40002fe8: 54ffffa1     	b.ne	0x40002fdc <kmemset+0x3c>
40002fec: eb0a005f     	cmp	x2, x10
40002ff0: 54000280     	b.eq	0x40003040 <kmemset+0xa0>
40002ff4: f27d045f     	tst	x2, #0x18
40002ff8: 540001a0     	b.eq	0x4000302c <kmemset+0x8c>
40002ffc: 0e010c20     	dup	v0.8b, w1
40003000: 927df04b     	and	x11, x2, #0xfffffffffffffff8
40003004: 92400849     	and	x9, x2, #0x7
40003008: 8b0b0008     	add	x8, x0, x11
4000300c: cb0b014c     	sub	x12, x10, x11
40003010: 8b0a000a     	add	x10, x0, x10
40003014: b100218c     	adds	x12, x12, #0x8
40003018: fc008540     	str	d0, [x10], #0x8
4000301c: 54ffffc1     	b.ne	0x40003014 <kmemset+0x74>
40003020: eb0b005f     	cmp	x2, x11
40003024: 54000081     	b.ne	0x40003034 <kmemset+0x94>
40003028: 14000006     	b	0x40003040 <kmemset+0xa0>
4000302c: 8b0a0008     	add	x8, x0, x10
40003030: 92401049     	and	x9, x2, #0x1f
40003034: f1000529     	subs	x9, x9, #0x1
40003038: 38001501     	strb	w1, [x8], #0x1
4000303c: 54ffffc1     	b.ne	0x40003034 <kmemset+0x94>
40003040: d65f03c0     	ret

0000000040003044 <kmemcpy>:
40003044: b4000660     	cbz	x0, 0x40003110 <kmemcpy+0xcc>
40003048: b4000641     	cbz	x1, 0x40003110 <kmemcpy+0xcc>
4000304c: b4000622     	cbz	x2, 0x40003110 <kmemcpy+0xcc>
40003050: f100205f     	cmp	x2, #0x8
40003054: 54000103     	b.lo	0x40003074 <kmemcpy+0x30>
40003058: cb010008     	sub	x8, x0, x1
4000305c: f100811f     	cmp	x8, #0x20
40003060: 540000a3     	b.lo	0x40003074 <kmemcpy+0x30>
40003064: f100805f     	cmp	x2, #0x20
40003068: 540000e2     	b.hs	0x40003084 <kmemcpy+0x40>
4000306c: aa1f03eb     	mov	x11, xzr
40003070: 14000013     	b	0x400030bc <kmemcpy+0x78>
40003074: aa0103e8     	mov	x8, x1
40003078: aa0003e9     	mov	x9, x0
4000307c: aa0203ea     	mov	x10, x2
40003080: 14000020     	b	0x40003100 <kmemcpy+0xbc>
40003084: 927be84b     	and	x11, x2, #0xffffffffffffffe0
40003088: 91004008     	add	x8, x0, #0x10
4000308c: 91004029     	add	x9, x1, #0x10
40003090: aa0b03ea     	mov	x10, x11
40003094: ad7f8520     	ldp	q0, q1, [x9, #-0x10]
40003098: f100814a     	subs	x10, x10, #0x20
4000309c: 91008129     	add	x9, x9, #0x20
400030a0: ad3f8500     	stp	q0, q1, [x8, #-0x10]
400030a4: 91008108     	add	x8, x8, #0x20
400030a8: 54ffff61     	b.ne	0x40003094 <kmemcpy+0x50>
400030ac: eb0b005f     	cmp	x2, x11
400030b0: 54000300     	b.eq	0x40003110 <kmemcpy+0xcc>
400030b4: f27d045f     	tst	x2, #0x18
400030b8: 540001e0     	b.eq	0x400030f4 <kmemcpy+0xb0>
400030bc: 927df04c     	and	x12, x2, #0xfffffffffffffff8
400030c0: 9240084a     	and	x10, x2, #0x7
400030c4: 8b0b000e     	add	x14, x0, x11
400030c8: 8b0c0028     	add	x8, x1, x12
400030cc: 8b0c0009     	add	x9, x0, x12
400030d0: cb0c016d     	sub	x13, x11, x12
400030d4: 8b0b002b     	add	x11, x1, x11
400030d8: fc408560     	ldr	d0, [x11], #0x8
400030dc: b10021ad     	adds	x13, x13, #0x8
400030e0: fc0085c0     	str	d0, [x14], #0x8
400030e4: 54ffffa1     	b.ne	0x400030d8 <kmemcpy+0x94>
400030e8: eb0c005f     	cmp	x2, x12
400030ec: 540000a1     	b.ne	0x40003100 <kmemcpy+0xbc>
400030f0: 14000008     	b	0x40003110 <kmemcpy+0xcc>
400030f4: 8b0b0028     	add	x8, x1, x11
400030f8: 8b0b0009     	add	x9, x0, x11
400030fc: 9240104a     	and	x10, x2, #0x1f
40003100: 3840150b     	ldrb	w11, [x8], #0x1
40003104: f100054a     	subs	x10, x10, #0x1
40003108: 3800152b     	strb	w11, [x9], #0x1
4000310c: 54ffffa1     	b.ne	0x40003100 <kmemcpy+0xbc>
40003110: d65f03c0     	ret

0000000040003114 <kstrstr>:
40003114: aa1f03e2     	mov	x2, xzr
40003118: b40000e0     	cbz	x0, 0x40003134 <kstrstr+0x20>
4000311c: b40000c1     	cbz	x1, 0x40003134 <kstrstr+0x20>
40003120: 39400028     	ldrb	w8, [x1]
40003124: 340002c8     	cbz	w8, 0x4000317c <kstrstr+0x68>
40003128: 39400009     	ldrb	w9, [x0]
4000312c: 35000109     	cbnz	w9, 0x4000314c <kstrstr+0x38>
40003130: aa1f03e2     	mov	x2, xzr
40003134: aa0203e0     	mov	x0, x2
40003138: d65f03c0     	ret
4000313c: 3940012c     	ldrb	w12, [x9]
40003140: 340001ec     	cbz	w12, 0x4000317c <kstrstr+0x68>
40003144: 38401c09     	ldrb	w9, [x0, #0x1]!
40003148: 34ffff49     	cbz	w9, 0x40003130 <kstrstr+0x1c>
4000314c: 6b08013f     	cmp	w9, w8
40003150: 54ffffa1     	b.ne	0x40003144 <kstrstr+0x30>
40003154: 5280002a     	mov	w10, #0x1               // =1
40003158: aa0103e9     	mov	x9, x1
4000315c: 2a0803eb     	mov	w11, w8
40003160: 3840152c     	ldrb	w12, [x9], #0x1
40003164: 6b0c017f     	cmp	w11, w12
40003168: 54fffec1     	b.ne	0x40003140 <kstrstr+0x2c>
4000316c: 386a680b     	ldrb	w11, [x0, x10]
40003170: 9100054a     	add	x10, x10, #0x1
40003174: 35ffff6b     	cbnz	w11, 0x40003160 <kstrstr+0x4c>
40003178: 17fffff1     	b	0x4000313c <kstrstr+0x28>
4000317c: d65f03c0     	ret

0000000040003180 <kstrchr>:
40003180: b4000140     	cbz	x0, 0x400031a8 <kstrchr+0x28>
40003184: 39400009     	ldrb	w9, [x0]
40003188: 340000c9     	cbz	w9, 0x400031a0 <kstrchr+0x20>
4000318c: 12001c28     	and	w8, w1, #0xff
40003190: 6b08013f     	cmp	w9, w8
40003194: 540000a0     	b.eq	0x400031a8 <kstrchr+0x28>
40003198: 38401c09     	ldrb	w9, [x0, #0x1]!
4000319c: 35ffffa9     	cbnz	w9, 0x40003190 <kstrchr+0x10>
400031a0: 72001c3f     	tst	w1, #0xff
400031a4: 9a9f0000     	csel	x0, x0, xzr, eq
400031a8: d65f03c0     	ret

00000000400031ac <ktolower>:
400031ac: 51010408     	sub	w8, w0, #0x41
400031b0: 321b0009     	orr	w9, w0, #0x20
400031b4: 7100691f     	cmp	w8, #0x1a
400031b8: 1a803120     	csel	w0, w9, w0, lo
400031bc: d65f03c0     	ret

00000000400031c0 <kstr_tolower>:
400031c0: b40001a0     	cbz	x0, 0x400031f4 <kstr_tolower+0x34>
400031c4: b4000181     	cbz	x1, 0x400031f4 <kstr_tolower+0x34>
400031c8: 39400029     	ldrb	w9, [x1]
400031cc: 34000129     	cbz	w9, 0x400031f0 <kstr_tolower+0x30>
400031d0: 91000428     	add	x8, x1, #0x1
400031d4: 5101052a     	sub	w10, w9, #0x41
400031d8: 321b012b     	orr	w11, w9, #0x20
400031dc: 7100695f     	cmp	w10, #0x1a
400031e0: 1a893169     	csel	w9, w11, w9, lo
400031e4: 38001409     	strb	w9, [x0], #0x1
400031e8: 38401509     	ldrb	w9, [x8], #0x1
400031ec: 35ffff49     	cbnz	w9, 0x400031d4 <kstr_tolower+0x14>
400031f0: 3900001f     	strb	wzr, [x0]
400031f4: d65f03c0     	ret

00000000400031f8 <tui_launch>:
400031f8: d105c3ff     	sub	sp, sp, #0x170
400031fc: a9117bfd     	stp	x29, x30, [sp, #0x110]
40003200: 910443fd     	add	x29, sp, #0x110
40003204: a9126ffc     	stp	x28, x27, [sp, #0x120]
40003208: a91367fa     	stp	x26, x25, [sp, #0x130]
4000320c: a9145ff8     	stp	x24, x23, [sp, #0x140]
40003210: a91557f6     	stp	x22, x21, [sp, #0x150]
40003214: a9164ff4     	stp	x20, x19, [sp, #0x160]
40003218: 9400074b     	bl	0x40004f44 <vfs_get_cwd>
4000321c: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
40003220: 9000007c     	adrp	x28, 0x4000f000 <var_values+0x6a0>
40003224: 9000007b     	adrp	x27, 0x4000f000 <var_values+0x6a0>
40003228: f904b100     	str	x0, [x8, #0x960]
4000322c: d503201f     	nop
40003230: 30027980     	adr	x0, 0x40008161 <__rodata_start+0x2161>
40003234: b9096b9f     	str	wzr, [x28, #0x968]
40003238: b9096f7f     	str	wzr, [x27, #0x96c]
4000323c: 940002c4     	bl	0x40003d4c <uart_puts>
40003240: f0000016     	adrp	x22, 0x40006000 <__rodata_start>
40003244: 91157ad6     	add	x22, x22, #0x55e
40003248: f0000017     	adrp	x23, 0x40006000 <__rodata_start>
4000324c: 910f8af7     	add	x23, x23, #0x3e2
40003250: 90000073     	adrp	x19, 0x4000f000 <var_values+0x6a0>
40003254: 9125e273     	add	x19, x19, #0x978
40003258: 9000007a     	adrp	x26, 0x4000f000 <var_values+0x6a0>
4000325c: 14000005     	b	0x40003270 <tui_launch+0x78>
40003260: b9496b88     	ldr	w8, [x28, #0x968]
40003264: 7100011f     	cmp	w8, #0x0
40003268: 1a9f17e8     	cset	w8, eq
4000326c: b9096b88     	str	w8, [x28, #0x968]
40003270: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
40003274: b909735f     	str	wzr, [x26, #0x970]
40003278: f944b10a     	ldr	x10, [x8, #0x960]
4000327c: f9421948     	ldr	x8, [x10, #0x430]
40003280: b4000108     	cbz	x8, 0x400032a0 <tui_launch+0xa8>
40003284: 52800029     	mov	w9, #0x1                // =1
40003288: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
4000328c: b9097349     	str	w9, [x26, #0x970]
40003290: f904bd1f     	str	xzr, [x8, #0x978]
40003294: f9401548     	ldr	x8, [x10, #0x28]
40003298: b50000a8     	cbnz	x8, 0x400032ac <tui_launch+0xb4>
4000329c: 14000028     	b	0x4000333c <tui_launch+0x144>
400032a0: 2a1f03e9     	mov	w9, wzr
400032a4: f9401548     	ldr	x8, [x10, #0x28]
400032a8: b40004a8     	cbz	x8, 0x4000333c <tui_launch+0x144>
400032ac: 2a0903e9     	mov	w9, w9
400032b0: d100050b     	sub	x11, x8, #0x1
400032b4: d240152c     	eor	x12, x9, #0x3f
400032b8: eb0c017f     	cmp	x11, x12
400032bc: 9a8c316b     	csel	x11, x11, x12, lo
400032c0: f1000d7f     	cmp	x11, #0x3
400032c4: 54000062     	b.hs	0x400032d0 <tui_launch+0xd8>
400032c8: aa1f03eb     	mov	x11, xzr
400032cc: 14000010     	b	0x4000330c <tui_launch+0x114>
400032d0: 9100056c     	add	x12, x11, #0x1
400032d4: 8b090e6d     	add	x13, x19, x9, lsl #3
400032d8: 9111214e     	add	x14, x10, #0x448
400032dc: 927e758b     	and	x11, x12, #0xfffffffc
400032e0: aa090169     	orr	x9, x11, x9
400032e4: 910041ad     	add	x13, x13, #0x10
400032e8: aa0b03ef     	mov	x15, x11
400032ec: ad7f85c0     	ldp	q0, q1, [x14, #-0x10]
400032f0: f10011ef     	subs	x15, x15, #0x4
400032f4: 910081ce     	add	x14, x14, #0x20
400032f8: ad3f85a0     	stp	q0, q1, [x13, #-0x10]
400032fc: 910081ad     	add	x13, x13, #0x20
40003300: 54ffff61     	b.ne	0x400032ec <tui_launch+0xf4>
40003304: eb0b019f     	cmp	x12, x11
40003308: 54000180     	b.eq	0x40003338 <tui_launch+0x140>
4000330c: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40003310: 9100056b     	add	x11, x11, #0x1
40003314: 9110e14a     	add	x10, x10, #0x438
40003318: f840854c     	ldr	x12, [x10], #0x8
4000331c: f100f93f     	cmp	x9, #0x3e
40003320: f8297a6c     	str	x12, [x19, x9, lsl #3]
40003324: 91000529     	add	x9, x9, #0x1
40003328: 54000088     	b.hi	0x40003338 <tui_launch+0x140>
4000332c: eb08017f     	cmp	x11, x8
40003330: 9100056b     	add	x11, x11, #0x1
40003334: 54ffff23     	b.lo	0x40003318 <tui_launch+0x120>
40003338: b9097349     	str	w9, [x26, #0x970]
4000333c: b9496f6a     	ldr	w10, [x27, #0x96c]
40003340: 51000528     	sub	w8, w9, #0x1
40003344: 6b08015f     	cmp	w10, w8
40003348: 1a88b148     	csel	w8, w10, w8, lt
4000334c: 6b09015f     	cmp	w10, w9
40003350: 5400004a     	b.ge	0x40003358 <tui_launch+0x160>
40003354: 36f80068     	tbz	w8, #0x1f, 0x40003360 <tui_launch+0x168>
40003358: 0aa87d08     	bic	w8, w8, w8, asr #31
4000335c: b9096f68     	str	w8, [x27, #0x96c]
40003360: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003364: 9137a400     	add	x0, x0, #0xde9
40003368: 94000279     	bl	0x40003d4c <uart_puts>
4000336c: b9496b88     	ldr	w8, [x28, #0x968]
40003370: 52800020     	mov	w0, #0x1                // =1
40003374: 52800501     	mov	w1, #0x28               // =40
40003378: f0000002     	adrp	x2, 0x40006000 <__rodata_start>
4000337c: 91045042     	add	x2, x2, #0x114
40003380: 7100011f     	cmp	w8, #0x0
40003384: 1a9f17e3     	cset	w3, eq
40003388: 94000171     	bl	0x4000394c <draw_box>
4000338c: 52800075     	mov	w21, #0x3               // =3
40003390: aa1603e0     	mov	x0, x22
40003394: 2a1503e1     	mov	w1, w21
40003398: 52800042     	mov	w2, #0x2                // =2
4000339c: 9400037c     	bl	0x4000418c <uart_printf>
400033a0: aa1703e0     	mov	x0, x23
400033a4: 9400026a     	bl	0x40003d4c <uart_puts>
400033a8: aa1703e0     	mov	x0, x23
400033ac: 94000268     	bl	0x40003d4c <uart_puts>
400033b0: aa1703e0     	mov	x0, x23
400033b4: 94000266     	bl	0x40003d4c <uart_puts>
400033b8: aa1703e0     	mov	x0, x23
400033bc: 94000264     	bl	0x40003d4c <uart_puts>
400033c0: aa1703e0     	mov	x0, x23
400033c4: 94000262     	bl	0x40003d4c <uart_puts>
400033c8: aa1703e0     	mov	x0, x23
400033cc: 94000260     	bl	0x40003d4c <uart_puts>
400033d0: aa1703e0     	mov	x0, x23
400033d4: 9400025e     	bl	0x40003d4c <uart_puts>
400033d8: aa1703e0     	mov	x0, x23
400033dc: 9400025c     	bl	0x40003d4c <uart_puts>
400033e0: aa1703e0     	mov	x0, x23
400033e4: 9400025a     	bl	0x40003d4c <uart_puts>
400033e8: aa1703e0     	mov	x0, x23
400033ec: 94000258     	bl	0x40003d4c <uart_puts>
400033f0: aa1703e0     	mov	x0, x23
400033f4: 94000256     	bl	0x40003d4c <uart_puts>
400033f8: aa1703e0     	mov	x0, x23
400033fc: 94000254     	bl	0x40003d4c <uart_puts>
40003400: aa1703e0     	mov	x0, x23
40003404: 94000252     	bl	0x40003d4c <uart_puts>
40003408: aa1703e0     	mov	x0, x23
4000340c: 94000250     	bl	0x40003d4c <uart_puts>
40003410: aa1703e0     	mov	x0, x23
40003414: 9400024e     	bl	0x40003d4c <uart_puts>
40003418: aa1703e0     	mov	x0, x23
4000341c: 9400024c     	bl	0x40003d4c <uart_puts>
40003420: aa1703e0     	mov	x0, x23
40003424: 9400024a     	bl	0x40003d4c <uart_puts>
40003428: aa1703e0     	mov	x0, x23
4000342c: 94000248     	bl	0x40003d4c <uart_puts>
40003430: aa1703e0     	mov	x0, x23
40003434: 94000246     	bl	0x40003d4c <uart_puts>
40003438: aa1703e0     	mov	x0, x23
4000343c: 94000244     	bl	0x40003d4c <uart_puts>
40003440: aa1703e0     	mov	x0, x23
40003444: 94000242     	bl	0x40003d4c <uart_puts>
40003448: aa1703e0     	mov	x0, x23
4000344c: 94000240     	bl	0x40003d4c <uart_puts>
40003450: aa1703e0     	mov	x0, x23
40003454: 9400023e     	bl	0x40003d4c <uart_puts>
40003458: aa1703e0     	mov	x0, x23
4000345c: 9400023c     	bl	0x40003d4c <uart_puts>
40003460: aa1703e0     	mov	x0, x23
40003464: 9400023a     	bl	0x40003d4c <uart_puts>
40003468: aa1703e0     	mov	x0, x23
4000346c: 94000238     	bl	0x40003d4c <uart_puts>
40003470: aa1703e0     	mov	x0, x23
40003474: 94000236     	bl	0x40003d4c <uart_puts>
40003478: aa1703e0     	mov	x0, x23
4000347c: 94000234     	bl	0x40003d4c <uart_puts>
40003480: aa1703e0     	mov	x0, x23
40003484: 94000232     	bl	0x40003d4c <uart_puts>
40003488: aa1703e0     	mov	x0, x23
4000348c: 94000230     	bl	0x40003d4c <uart_puts>
40003490: aa1703e0     	mov	x0, x23
40003494: 9400022e     	bl	0x40003d4c <uart_puts>
40003498: aa1703e0     	mov	x0, x23
4000349c: 9400022c     	bl	0x40003d4c <uart_puts>
400034a0: aa1703e0     	mov	x0, x23
400034a4: 9400022a     	bl	0x40003d4c <uart_puts>
400034a8: aa1703e0     	mov	x0, x23
400034ac: 94000228     	bl	0x40003d4c <uart_puts>
400034b0: aa1703e0     	mov	x0, x23
400034b4: 94000226     	bl	0x40003d4c <uart_puts>
400034b8: aa1703e0     	mov	x0, x23
400034bc: 94000224     	bl	0x40003d4c <uart_puts>
400034c0: aa1703e0     	mov	x0, x23
400034c4: 94000222     	bl	0x40003d4c <uart_puts>
400034c8: aa1703e0     	mov	x0, x23
400034cc: 94000220     	bl	0x40003d4c <uart_puts>
400034d0: 110006b5     	add	w21, w21, #0x1
400034d4: 71005ebf     	cmp	w21, #0x17
400034d8: 54fff5c1     	b.ne	0x40003390 <tui_launch+0x198>
400034dc: b9496f68     	ldr	w8, [x27, #0x96c]
400034e0: 52800249     	mov	w9, #0x12               // =18
400034e4: aa1f03f8     	mov	x24, xzr
400034e8: 7100491f     	cmp	w8, #0x12
400034ec: 1a89c108     	csel	w8, w8, w9, gt
400034f0: 51004915     	sub	w21, w8, #0x12
400034f4: 8b354e79     	add	x25, x19, w21, uxtw #3
400034f8: 14000004     	b	0x40003508 <tui_launch+0x310>
400034fc: 91000718     	add	x24, x24, #0x1
40003500: f100531f     	cmp	x24, #0x14
40003504: 540005a0     	b.eq	0x400035b8 <tui_launch+0x3c0>
40003508: b9897348     	ldrsw	x8, [x26, #0x970]
4000350c: 8b1802b4     	add	x20, x21, x24
40003510: eb08029f     	cmp	x20, x8
40003514: 5400052a     	b.ge	0x400035b8 <tui_launch+0x3c0>
40003518: 11000f01     	add	w1, w24, #0x3
4000351c: aa1603e0     	mov	x0, x22
40003520: 52800062     	mov	w2, #0x3                // =3
40003524: 9400031a     	bl	0x4000418c <uart_printf>
40003528: b9496f68     	ldr	w8, [x27, #0x96c]
4000352c: eb08029f     	cmp	x20, x8
40003530: 540000c1     	b.ne	0x40003548 <tui_launch+0x350>
40003534: b9496b88     	ldr	w8, [x28, #0x968]
40003538: 35000088     	cbnz	w8, 0x40003548 <tui_launch+0x350>
4000353c: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003540: 91050800     	add	x0, x0, #0x142
40003544: 94000202     	bl	0x40003d4c <uart_puts>
40003548: f8787b28     	ldr	x8, [x25, x24, lsl #3]
4000354c: b40001e8     	cbz	x8, 0x40003588 <tui_launch+0x390>
40003550: b9402108     	ldr	w8, [x8, #0x20]
40003554: 90000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40003558: 912a0929     	add	x9, x9, #0xa82
4000355c: 910223e0     	add	x0, sp, #0x88
40003560: 7100051f     	cmp	w8, #0x1
40003564: 90000028     	adrp	x8, 0x40007000 <__rodata_start+0x1000>
40003568: 91148108     	add	x8, x8, #0x520
4000356c: 9a880121     	csel	x1, x9, x8, eq
40003570: 97fffe51     	bl	0x40002eb4 <kstrcpy>
40003574: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40003578: 910223e0     	add	x0, sp, #0x88
4000357c: 97fffe26     	bl	0x40002e14 <kstrcat>
40003580: 910223e0     	add	x0, sp, #0x88
40003584: 14000003     	b	0x40003590 <tui_launch+0x398>
40003588: 90000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
4000358c: 910c9400     	add	x0, x0, #0x325
40003590: 940001ef     	bl	0x40003d4c <uart_puts>
40003594: b9496f68     	ldr	w8, [x27, #0x96c]
40003598: eb08029f     	cmp	x20, x8
4000359c: 54fffb01     	b.ne	0x400034fc <tui_launch+0x304>
400035a0: b9496b88     	ldr	w8, [x28, #0x968]
400035a4: 35fffac8     	cbnz	w8, 0x400034fc <tui_launch+0x304>
400035a8: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
400035ac: 9116fc00     	add	x0, x0, #0x5bf
400035b0: 940001e7     	bl	0x40003d4c <uart_puts>
400035b4: 17ffffd2     	b	0x400034fc <tui_launch+0x304>
400035b8: b9496b88     	ldr	w8, [x28, #0x968]
400035bc: 52800540     	mov	w0, #0x2a               // =42
400035c0: 528004c1     	mov	w1, #0x26               // =38
400035c4: 90000022     	adrp	x2, 0x40007000 <__rodata_start+0x1000>
400035c8: 91221c42     	add	x2, x2, #0x887
400035cc: 7100051f     	cmp	w8, #0x1
400035d0: 1a9f17e3     	cset	w3, eq
400035d4: 940000de     	bl	0x4000394c <draw_box>
400035d8: 52800075     	mov	w21, #0x3               // =3
400035dc: aa1603e0     	mov	x0, x22
400035e0: 2a1503e1     	mov	w1, w21
400035e4: 52800562     	mov	w2, #0x2b               // =43
400035e8: 940002e9     	bl	0x4000418c <uart_printf>
400035ec: aa1703e0     	mov	x0, x23
400035f0: 940001d7     	bl	0x40003d4c <uart_puts>
400035f4: aa1703e0     	mov	x0, x23
400035f8: 940001d5     	bl	0x40003d4c <uart_puts>
400035fc: aa1703e0     	mov	x0, x23
40003600: 940001d3     	bl	0x40003d4c <uart_puts>
40003604: aa1703e0     	mov	x0, x23
40003608: 940001d1     	bl	0x40003d4c <uart_puts>
4000360c: aa1703e0     	mov	x0, x23
40003610: 940001cf     	bl	0x40003d4c <uart_puts>
40003614: aa1703e0     	mov	x0, x23
40003618: 940001cd     	bl	0x40003d4c <uart_puts>
4000361c: aa1703e0     	mov	x0, x23
40003620: 940001cb     	bl	0x40003d4c <uart_puts>
40003624: aa1703e0     	mov	x0, x23
40003628: 940001c9     	bl	0x40003d4c <uart_puts>
4000362c: aa1703e0     	mov	x0, x23
40003630: 940001c7     	bl	0x40003d4c <uart_puts>
40003634: aa1703e0     	mov	x0, x23
40003638: 940001c5     	bl	0x40003d4c <uart_puts>
4000363c: aa1703e0     	mov	x0, x23
40003640: 940001c3     	bl	0x40003d4c <uart_puts>
40003644: aa1703e0     	mov	x0, x23
40003648: 940001c1     	bl	0x40003d4c <uart_puts>
4000364c: aa1703e0     	mov	x0, x23
40003650: 940001bf     	bl	0x40003d4c <uart_puts>
40003654: aa1703e0     	mov	x0, x23
40003658: 940001bd     	bl	0x40003d4c <uart_puts>
4000365c: aa1703e0     	mov	x0, x23
40003660: 940001bb     	bl	0x40003d4c <uart_puts>
40003664: aa1703e0     	mov	x0, x23
40003668: 940001b9     	bl	0x40003d4c <uart_puts>
4000366c: aa1703e0     	mov	x0, x23
40003670: 940001b7     	bl	0x40003d4c <uart_puts>
40003674: aa1703e0     	mov	x0, x23
40003678: 940001b5     	bl	0x40003d4c <uart_puts>
4000367c: aa1703e0     	mov	x0, x23
40003680: 940001b3     	bl	0x40003d4c <uart_puts>
40003684: aa1703e0     	mov	x0, x23
40003688: 940001b1     	bl	0x40003d4c <uart_puts>
4000368c: aa1703e0     	mov	x0, x23
40003690: 940001af     	bl	0x40003d4c <uart_puts>
40003694: aa1703e0     	mov	x0, x23
40003698: 940001ad     	bl	0x40003d4c <uart_puts>
4000369c: aa1703e0     	mov	x0, x23
400036a0: 940001ab     	bl	0x40003d4c <uart_puts>
400036a4: aa1703e0     	mov	x0, x23
400036a8: 940001a9     	bl	0x40003d4c <uart_puts>
400036ac: aa1703e0     	mov	x0, x23
400036b0: 940001a7     	bl	0x40003d4c <uart_puts>
400036b4: aa1703e0     	mov	x0, x23
400036b8: 940001a5     	bl	0x40003d4c <uart_puts>
400036bc: aa1703e0     	mov	x0, x23
400036c0: 940001a3     	bl	0x40003d4c <uart_puts>
400036c4: aa1703e0     	mov	x0, x23
400036c8: 940001a1     	bl	0x40003d4c <uart_puts>
400036cc: aa1703e0     	mov	x0, x23
400036d0: 9400019f     	bl	0x40003d4c <uart_puts>
400036d4: aa1703e0     	mov	x0, x23
400036d8: 9400019d     	bl	0x40003d4c <uart_puts>
400036dc: aa1703e0     	mov	x0, x23
400036e0: 9400019b     	bl	0x40003d4c <uart_puts>
400036e4: aa1703e0     	mov	x0, x23
400036e8: 94000199     	bl	0x40003d4c <uart_puts>
400036ec: aa1703e0     	mov	x0, x23
400036f0: 94000197     	bl	0x40003d4c <uart_puts>
400036f4: aa1703e0     	mov	x0, x23
400036f8: 94000195     	bl	0x40003d4c <uart_puts>
400036fc: aa1703e0     	mov	x0, x23
40003700: 94000193     	bl	0x40003d4c <uart_puts>
40003704: aa1703e0     	mov	x0, x23
40003708: 94000191     	bl	0x40003d4c <uart_puts>
4000370c: 110006b5     	add	w21, w21, #0x1
40003710: 71005ebf     	cmp	w21, #0x17
40003714: 54fff641     	b.ne	0x400035dc <tui_launch+0x3e4>
40003718: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
4000371c: 91209400     	add	x0, x0, #0x825
40003720: 52800061     	mov	w1, #0x3                // =3
40003724: 52800562     	mov	w2, #0x2b               // =43
40003728: 94000299     	bl	0x4000418c <uart_printf>
4000372c: d503201f     	nop
40003730: 10055968     	adr	x8, 0x4000e25c <proc_table>
40003734: aa1f03f4     	mov	x20, xzr
40003738: 9100a115     	add	x21, x8, #0x28
4000373c: 52800058     	mov	w24, #0x2               // =2
40003740: f0000019     	adrp	x25, 0x40006000 <__rodata_start>
40003744: 9119ff39     	add	x25, x25, #0x67f
40003748: b85fc2a8     	ldur	w8, [x21, #-0x4]
4000374c: 71000d1f     	cmp	w8, #0x3
40003750: 54000140     	b.eq	0x40003778 <tui_launch+0x580>
40003754: b94002a8     	ldr	w8, [x21]
40003758: b85d82a3     	ldur	w3, [x21, #-0x28]
4000375c: d10092a4     	sub	x4, x21, #0x24
40003760: 11000b01     	add	w1, w24, #0x2
40003764: aa1903e0     	mov	x0, x25
40003768: 52800562     	mov	w2, #0x2b               // =43
4000376c: 530a7d05     	lsr	w5, w8, #10
40003770: 94000287     	bl	0x4000418c <uart_printf>
40003774: 11000718     	add	w24, w24, #0x1
40003778: f1003a9f     	cmp	x20, #0xe
4000377c: 540000a8     	b.hi	0x40003790 <tui_launch+0x598>
40003780: 7100531f     	cmp	w24, #0x14
40003784: 91000694     	add	x20, x20, #0x1
40003788: 9100c2b5     	add	x21, x21, #0x30
4000378c: 54fffdeb     	b.lt	0x40003748 <tui_launch+0x550>
40003790: 940001a2     	bl	0x40003e18 <uart_getc>
40003794: 52801be8     	mov	w8, #0xdf               // =223
40003798: 0a080008     	and	w8, w0, w8
4000379c: 7101451f     	cmp	w8, #0x51
400037a0: 54000c00     	b.eq	0x40003920 <tui_launch+0x728>
400037a4: 12001c08     	and	w8, w0, #0xff
400037a8: 7100311f     	cmp	w8, #0xc
400037ac: 5400010c     	b.gt	0x400037cc <tui_launch+0x5d4>
400037b0: 7100251f     	cmp	w8, #0x9
400037b4: f0000014     	adrp	x20, 0x40006000 <__rodata_start>
400037b8: 912e0e94     	add	x20, x20, #0xb83
400037bc: 54ffd520     	b.eq	0x40003260 <tui_launch+0x68>
400037c0: 7100291f     	cmp	w8, #0xa
400037c4: 540002e0     	b.eq	0x40003820 <tui_launch+0x628>
400037c8: 17fffeaa     	b	0x40003270 <tui_launch+0x78>
400037cc: 7100351f     	cmp	w8, #0xd
400037d0: f0000014     	adrp	x20, 0x40006000 <__rodata_start>
400037d4: 912e0e94     	add	x20, x20, #0xb83
400037d8: 54000240     	b.eq	0x40003820 <tui_launch+0x628>
400037dc: 71006d1f     	cmp	w8, #0x1b
400037e0: 54ffd481     	b.ne	0x40003270 <tui_launch+0x78>
400037e4: 9400018d     	bl	0x40003e18 <uart_getc>
400037e8: 12001c14     	and	w20, w0, #0xff
400037ec: 9400018b     	bl	0x40003e18 <uart_getc>
400037f0: 71016e9f     	cmp	w20, #0x5b
400037f4: 54ffd3e1     	b.ne	0x40003270 <tui_launch+0x78>
400037f8: 12001c08     	and	w8, w0, #0xff
400037fc: 7101051f     	cmp	w8, #0x41
40003800: 54000781     	b.ne	0x400038f0 <tui_launch+0x6f8>
40003804: b9496b88     	ldr	w8, [x28, #0x968]
40003808: 35ffd348     	cbnz	w8, 0x40003270 <tui_launch+0x78>
4000380c: b9496f68     	ldr	w8, [x27, #0x96c]
40003810: 71000508     	subs	w8, w8, #0x1
40003814: 54ffd2eb     	b.lt	0x40003270 <tui_launch+0x78>
40003818: b9096f68     	str	w8, [x27, #0x96c]
4000381c: 17fffe95     	b	0x40003270 <tui_launch+0x78>
40003820: b9496b88     	ldr	w8, [x28, #0x968]
40003824: 35ffd268     	cbnz	w8, 0x40003270 <tui_launch+0x78>
40003828: b9497348     	ldr	w8, [x26, #0x970]
4000382c: 7100051f     	cmp	w8, #0x1
40003830: 54ffd20b     	b.lt	0x40003270 <tui_launch+0x78>
40003834: b9896f68     	ldrsw	x8, [x27, #0x96c]
40003838: f8687a75     	ldr	x21, [x19, x8, lsl #3]
4000383c: b4000115     	cbz	x21, 0x4000385c <tui_launch+0x664>
40003840: b94022a8     	ldr	w8, [x21, #0x20]
40003844: 7100051f     	cmp	w8, #0x1
40003848: 54000161     	b.ne	0x40003874 <tui_launch+0x67c>
4000384c: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
40003850: b9096f7f     	str	wzr, [x27, #0x96c]
40003854: f904b115     	str	x21, [x8, #0x960]
40003858: 17fffe86     	b	0x40003270 <tui_launch+0x78>
4000385c: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40003860: b9096f7f     	str	wzr, [x27, #0x96c]
40003864: f944b128     	ldr	x8, [x9, #0x960]
40003868: f9421908     	ldr	x8, [x8, #0x430]
4000386c: f904b128     	str	x8, [x9, #0x960]
40003870: 17fffe80     	b	0x40003270 <tui_launch+0x78>
40003874: 390223ff     	strb	wzr, [sp, #0x88]
40003878: aa1403e0     	mov	x0, x20
4000387c: 94000620     	bl	0x400050fc <vfs_find>
40003880: eb0002bf     	cmp	x21, x0
40003884: 540001e0     	b.eq	0x400038c0 <tui_launch+0x6c8>
40003888: 910023e0     	add	x0, sp, #0x8
4000388c: 910223e1     	add	x1, sp, #0x88
40003890: 97fffd89     	bl	0x40002eb4 <kstrcpy>
40003894: 910223e0     	add	x0, sp, #0x88
40003898: aa1403e1     	mov	x1, x20
4000389c: 97fffd86     	bl	0x40002eb4 <kstrcpy>
400038a0: 910223e0     	add	x0, sp, #0x88
400038a4: aa1503e1     	mov	x1, x21
400038a8: 97fffd5b     	bl	0x40002e14 <kstrcat>
400038ac: 910223e0     	add	x0, sp, #0x88
400038b0: 910023e1     	add	x1, sp, #0x8
400038b4: 97fffd58     	bl	0x40002e14 <kstrcat>
400038b8: f9421ab5     	ldr	x21, [x21, #0x430]
400038bc: b5fffdf5     	cbnz	x21, 0x40003878 <tui_launch+0x680>
400038c0: 910223e0     	add	x0, sp, #0x88
400038c4: 97fffd4d     	bl	0x40002df8 <kstrlen>
400038c8: b5000080     	cbnz	x0, 0x400038d8 <tui_launch+0x6e0>
400038cc: 910223e0     	add	x0, sp, #0x88
400038d0: aa1403e1     	mov	x1, x20
400038d4: 97fffd78     	bl	0x40002eb4 <kstrcpy>
400038d8: 910223e0     	add	x0, sp, #0x88
400038dc: 97fff31f     	bl	0x40000558 <launch_kedit>
400038e0: d503201f     	nop
400038e4: 300243e0     	adr	x0, 0x40008161 <__rodata_start+0x2161>
400038e8: 94000119     	bl	0x40003d4c <uart_puts>
400038ec: 17fffe61     	b	0x40003270 <tui_launch+0x78>
400038f0: 7101091f     	cmp	w8, #0x42
400038f4: 54ffcbe1     	b.ne	0x40003270 <tui_launch+0x78>
400038f8: b9496b88     	ldr	w8, [x28, #0x968]
400038fc: 35ffcba8     	cbnz	w8, 0x40003270 <tui_launch+0x78>
40003900: b9497349     	ldr	w9, [x26, #0x970]
40003904: b9496f68     	ldr	w8, [x27, #0x96c]
40003908: 51000529     	sub	w9, w9, #0x1
4000390c: 6b09011f     	cmp	w8, w9
40003910: 54ffcb0a     	b.ge	0x40003270 <tui_launch+0x78>
40003914: 11000508     	add	w8, w8, #0x1
40003918: b9096f68     	str	w8, [x27, #0x96c]
4000391c: 17fffe55     	b	0x40003270 <tui_launch+0x78>
40003920: 90000020     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40003924: 91067000     	add	x0, x0, #0x19c
40003928: 94000109     	bl	0x40003d4c <uart_puts>
4000392c: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003930: a95557f6     	ldp	x22, x21, [sp, #0x150]
40003934: a9545ff8     	ldp	x24, x23, [sp, #0x140]
40003938: a95367fa     	ldp	x26, x25, [sp, #0x130]
4000393c: a9526ffc     	ldp	x28, x27, [sp, #0x120]
40003940: a9517bfd     	ldp	x29, x30, [sp, #0x110]
40003944: 9105c3ff     	add	sp, sp, #0x170
40003948: d65f03c0     	ret

000000004000394c <draw_box>:
4000394c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40003950: d0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40003954: 9111b908     	add	x8, x8, #0x46e
40003958: 7100007f     	cmp	w3, #0x0
4000395c: 90000029     	adrp	x9, 0x40007000 <__rodata_start+0x1000>
40003960: 91265529     	add	x9, x9, #0x995
40003964: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003968: 2a0003f3     	mov	w19, w0
4000396c: 9a880120     	csel	x0, x9, x8, eq
40003970: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003974: a90257f6     	stp	x22, x21, [sp, #0x20]
40003978: 910003fd     	mov	x29, sp
4000397c: aa0203f4     	mov	x20, x2
40003980: 2a0103f5     	mov	w21, w1
40003984: 940000f2     	bl	0x40003d4c <uart_puts>
40003988: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
4000398c: 912e1400     	add	x0, x0, #0xb85
40003990: 52800041     	mov	w1, #0x2                // =2
40003994: 2a1303e2     	mov	w2, w19
40003998: 940001fd     	bl	0x4000418c <uart_printf>
4000399c: 51000ab6     	sub	w22, w21, #0x2
400039a0: 510006b7     	sub	w23, w21, #0x1
400039a4: f0000015     	adrp	x21, 0x40006000 <__rodata_start>
400039a8: 9119eeb5     	add	x21, x21, #0x67b
400039ac: 2a1603f8     	mov	w24, w22
400039b0: aa1503e0     	mov	x0, x21
400039b4: 940000e6     	bl	0x40003d4c <uart_puts>
400039b8: 71000718     	subs	w24, w24, #0x1
400039bc: 54ffffa1     	b.ne	0x400039b0 <draw_box+0x64>
400039c0: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400039c4: 913da400     	add	x0, x0, #0xf69
400039c8: 940000e1     	bl	0x40003d4c <uart_puts>
400039cc: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
400039d0: 912e4400     	add	x0, x0, #0xb91
400039d4: 11000a62     	add	w2, w19, #0x2
400039d8: 52800041     	mov	w1, #0x2                // =2
400039dc: aa1403e3     	mov	x3, x20
400039e0: 940001eb     	bl	0x4000418c <uart_printf>
400039e4: 90000034     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
400039e8: 91353694     	add	x20, x20, #0xd4d
400039ec: 52800061     	mov	w1, #0x3                // =3
400039f0: aa1403e0     	mov	x0, x20
400039f4: 2a1303e2     	mov	w2, w19
400039f8: 940001e5     	bl	0x4000418c <uart_printf>
400039fc: 0b1302e2     	add	w2, w23, w19
40003a00: aa1403e0     	mov	x0, x20
40003a04: 52800061     	mov	w1, #0x3                // =3
40003a08: 940001e1     	bl	0x4000418c <uart_printf>
40003a0c: aa1403e0     	mov	x0, x20
40003a10: 52800081     	mov	w1, #0x4                // =4
40003a14: 2a1303e2     	mov	w2, w19
40003a18: 940001dd     	bl	0x4000418c <uart_printf>
40003a1c: 0b1302e2     	add	w2, w23, w19
40003a20: aa1403e0     	mov	x0, x20
40003a24: 52800081     	mov	w1, #0x4                // =4
40003a28: 940001d9     	bl	0x4000418c <uart_printf>
40003a2c: aa1403e0     	mov	x0, x20
40003a30: 528000a1     	mov	w1, #0x5                // =5
40003a34: 2a1303e2     	mov	w2, w19
40003a38: 940001d5     	bl	0x4000418c <uart_printf>
40003a3c: 0b1302e2     	add	w2, w23, w19
40003a40: aa1403e0     	mov	x0, x20
40003a44: 528000a1     	mov	w1, #0x5                // =5
40003a48: 940001d1     	bl	0x4000418c <uart_printf>
40003a4c: aa1403e0     	mov	x0, x20
40003a50: 528000c1     	mov	w1, #0x6                // =6
40003a54: 2a1303e2     	mov	w2, w19
40003a58: 940001cd     	bl	0x4000418c <uart_printf>
40003a5c: 0b1302e2     	add	w2, w23, w19
40003a60: aa1403e0     	mov	x0, x20
40003a64: 528000c1     	mov	w1, #0x6                // =6
40003a68: 940001c9     	bl	0x4000418c <uart_printf>
40003a6c: aa1403e0     	mov	x0, x20
40003a70: 528000e1     	mov	w1, #0x7                // =7
40003a74: 2a1303e2     	mov	w2, w19
40003a78: 940001c5     	bl	0x4000418c <uart_printf>
40003a7c: 0b1302e2     	add	w2, w23, w19
40003a80: aa1403e0     	mov	x0, x20
40003a84: 528000e1     	mov	w1, #0x7                // =7
40003a88: 940001c1     	bl	0x4000418c <uart_printf>
40003a8c: aa1403e0     	mov	x0, x20
40003a90: 52800101     	mov	w1, #0x8                // =8
40003a94: 2a1303e2     	mov	w2, w19
40003a98: 940001bd     	bl	0x4000418c <uart_printf>
40003a9c: 0b1302e2     	add	w2, w23, w19
40003aa0: aa1403e0     	mov	x0, x20
40003aa4: 52800101     	mov	w1, #0x8                // =8
40003aa8: 940001b9     	bl	0x4000418c <uart_printf>
40003aac: aa1403e0     	mov	x0, x20
40003ab0: 52800121     	mov	w1, #0x9                // =9
40003ab4: 2a1303e2     	mov	w2, w19
40003ab8: 940001b5     	bl	0x4000418c <uart_printf>
40003abc: 0b1302e2     	add	w2, w23, w19
40003ac0: aa1403e0     	mov	x0, x20
40003ac4: 52800121     	mov	w1, #0x9                // =9
40003ac8: 940001b1     	bl	0x4000418c <uart_printf>
40003acc: aa1403e0     	mov	x0, x20
40003ad0: 52800141     	mov	w1, #0xa                // =10
40003ad4: 2a1303e2     	mov	w2, w19
40003ad8: 940001ad     	bl	0x4000418c <uart_printf>
40003adc: 0b1302e2     	add	w2, w23, w19
40003ae0: aa1403e0     	mov	x0, x20
40003ae4: 52800141     	mov	w1, #0xa                // =10
40003ae8: 940001a9     	bl	0x4000418c <uart_printf>
40003aec: aa1403e0     	mov	x0, x20
40003af0: 52800161     	mov	w1, #0xb                // =11
40003af4: 2a1303e2     	mov	w2, w19
40003af8: 940001a5     	bl	0x4000418c <uart_printf>
40003afc: 0b1302e2     	add	w2, w23, w19
40003b00: aa1403e0     	mov	x0, x20
40003b04: 52800161     	mov	w1, #0xb                // =11
40003b08: 940001a1     	bl	0x4000418c <uart_printf>
40003b0c: aa1403e0     	mov	x0, x20
40003b10: 52800181     	mov	w1, #0xc                // =12
40003b14: 2a1303e2     	mov	w2, w19
40003b18: 9400019d     	bl	0x4000418c <uart_printf>
40003b1c: 0b1302e2     	add	w2, w23, w19
40003b20: aa1403e0     	mov	x0, x20
40003b24: 52800181     	mov	w1, #0xc                // =12
40003b28: 94000199     	bl	0x4000418c <uart_printf>
40003b2c: aa1403e0     	mov	x0, x20
40003b30: 528001a1     	mov	w1, #0xd                // =13
40003b34: 2a1303e2     	mov	w2, w19
40003b38: 94000195     	bl	0x4000418c <uart_printf>
40003b3c: 0b1302e2     	add	w2, w23, w19
40003b40: aa1403e0     	mov	x0, x20
40003b44: 528001a1     	mov	w1, #0xd                // =13
40003b48: 94000191     	bl	0x4000418c <uart_printf>
40003b4c: aa1403e0     	mov	x0, x20
40003b50: 528001c1     	mov	w1, #0xe                // =14
40003b54: 2a1303e2     	mov	w2, w19
40003b58: 9400018d     	bl	0x4000418c <uart_printf>
40003b5c: 0b1302e2     	add	w2, w23, w19
40003b60: aa1403e0     	mov	x0, x20
40003b64: 528001c1     	mov	w1, #0xe                // =14
40003b68: 94000189     	bl	0x4000418c <uart_printf>
40003b6c: aa1403e0     	mov	x0, x20
40003b70: 528001e1     	mov	w1, #0xf                // =15
40003b74: 2a1303e2     	mov	w2, w19
40003b78: 94000185     	bl	0x4000418c <uart_printf>
40003b7c: 0b1302e2     	add	w2, w23, w19
40003b80: aa1403e0     	mov	x0, x20
40003b84: 528001e1     	mov	w1, #0xf                // =15
40003b88: 94000181     	bl	0x4000418c <uart_printf>
40003b8c: aa1403e0     	mov	x0, x20
40003b90: 52800201     	mov	w1, #0x10               // =16
40003b94: 2a1303e2     	mov	w2, w19
40003b98: 9400017d     	bl	0x4000418c <uart_printf>
40003b9c: 0b1302e2     	add	w2, w23, w19
40003ba0: aa1403e0     	mov	x0, x20
40003ba4: 52800201     	mov	w1, #0x10               // =16
40003ba8: 94000179     	bl	0x4000418c <uart_printf>
40003bac: aa1403e0     	mov	x0, x20
40003bb0: 52800221     	mov	w1, #0x11               // =17
40003bb4: 2a1303e2     	mov	w2, w19
40003bb8: 94000175     	bl	0x4000418c <uart_printf>
40003bbc: 0b1302e2     	add	w2, w23, w19
40003bc0: aa1403e0     	mov	x0, x20
40003bc4: 52800221     	mov	w1, #0x11               // =17
40003bc8: 94000171     	bl	0x4000418c <uart_printf>
40003bcc: aa1403e0     	mov	x0, x20
40003bd0: 52800241     	mov	w1, #0x12               // =18
40003bd4: 2a1303e2     	mov	w2, w19
40003bd8: 9400016d     	bl	0x4000418c <uart_printf>
40003bdc: 0b1302e2     	add	w2, w23, w19
40003be0: aa1403e0     	mov	x0, x20
40003be4: 52800241     	mov	w1, #0x12               // =18
40003be8: 94000169     	bl	0x4000418c <uart_printf>
40003bec: aa1403e0     	mov	x0, x20
40003bf0: 52800261     	mov	w1, #0x13               // =19
40003bf4: 2a1303e2     	mov	w2, w19
40003bf8: 94000165     	bl	0x4000418c <uart_printf>
40003bfc: 0b1302e2     	add	w2, w23, w19
40003c00: aa1403e0     	mov	x0, x20
40003c04: 52800261     	mov	w1, #0x13               // =19
40003c08: 94000161     	bl	0x4000418c <uart_printf>
40003c0c: aa1403e0     	mov	x0, x20
40003c10: 52800281     	mov	w1, #0x14               // =20
40003c14: 2a1303e2     	mov	w2, w19
40003c18: 9400015d     	bl	0x4000418c <uart_printf>
40003c1c: 0b1302e2     	add	w2, w23, w19
40003c20: aa1403e0     	mov	x0, x20
40003c24: 52800281     	mov	w1, #0x14               // =20
40003c28: 94000159     	bl	0x4000418c <uart_printf>
40003c2c: aa1403e0     	mov	x0, x20
40003c30: 528002a1     	mov	w1, #0x15               // =21
40003c34: 2a1303e2     	mov	w2, w19
40003c38: 94000155     	bl	0x4000418c <uart_printf>
40003c3c: 0b1302e2     	add	w2, w23, w19
40003c40: aa1403e0     	mov	x0, x20
40003c44: 528002a1     	mov	w1, #0x15               // =21
40003c48: 94000151     	bl	0x4000418c <uart_printf>
40003c4c: aa1403e0     	mov	x0, x20
40003c50: 528002c1     	mov	w1, #0x16               // =22
40003c54: 2a1303e2     	mov	w2, w19
40003c58: 9400014d     	bl	0x4000418c <uart_printf>
40003c5c: 0b1302e2     	add	w2, w23, w19
40003c60: aa1403e0     	mov	x0, x20
40003c64: 528002c1     	mov	w1, #0x16               // =22
40003c68: 94000149     	bl	0x4000418c <uart_printf>
40003c6c: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003c70: 91205400     	add	x0, x0, #0x815
40003c74: 528002e1     	mov	w1, #0x17               // =23
40003c78: 2a1303e2     	mov	w2, w19
40003c7c: 94000144     	bl	0x4000418c <uart_printf>
40003c80: f0000013     	adrp	x19, 0x40006000 <__rodata_start>
40003c84: 9119ee73     	add	x19, x19, #0x67b
40003c88: aa1303e0     	mov	x0, x19
40003c8c: 94000030     	bl	0x40003d4c <uart_puts>
40003c90: 710006d6     	subs	w22, w22, #0x1
40003c94: 54ffffa1     	b.ne	0x40003c88 <draw_box+0x33c>
40003c98: f0000000     	adrp	x0, 0x40006000 <__rodata_start>
40003c9c: 91208400     	add	x0, x0, #0x821
40003ca0: 9400002b     	bl	0x40003d4c <uart_puts>
40003ca4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003ca8: b0000020     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
40003cac: 9116fc00     	add	x0, x0, #0x5bf
40003cb0: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003cb4: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003cb8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003cbc: 14000024     	b	0x40003d4c <uart_puts>

0000000040003cc0 <uart_init>:
40003cc0: 52800608     	mov	w8, #0x30               // =48
40003cc4: 528001a9     	mov	w9, #0xd                // =13
40003cc8: 5280002a     	mov	w10, #0x1               // =1
40003ccc: 72a12008     	movk	w8, #0x900, lsl #16
40003cd0: b900011f     	str	wzr, [x8]
40003cd4: b81f4109     	stur	w9, [x8, #-0xc]
40003cd8: 52800e09     	mov	w9, #0x70               // =112
40003cdc: b81f810a     	stur	w10, [x8, #-0x8]
40003ce0: b81fc109     	stur	w9, [x8, #-0x4]
40003ce4: 52806029     	mov	w9, #0x301              // =769
40003ce8: b9000109     	str	w9, [x8]
40003cec: d65f03c0     	ret

0000000040003cf0 <uart_putc>:
40003cf0: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
40003cf4: b94b7908     	ldr	w8, [x8, #0xb78]
40003cf8: 340001a8     	cbz	w8, 0x40003d2c <uart_putc+0x3c>
40003cfc: 90000068     	adrp	x8, 0x4000f000 <var_values+0x6a0>
40003d00: 5287ffca     	mov	w10, #0x3ffe            // =16382
40003d04: b94b7d09     	ldr	w9, [x8, #0xb7c]
40003d08: 6b0a013f     	cmp	w9, w10
40003d0c: 5400010c     	b.gt	0x40003d2c <uart_putc+0x3c>
40003d10: 93407d29     	sxtw	x9, w9
40003d14: d503201f     	nop
40003d18: 1005f34a     	adr	x10, 0x4000fb80 <kernel_capture_buffer>
40003d1c: 9100052b     	add	x11, x9, #0x1
40003d20: 38296940     	strb	w0, [x10, x9]
40003d24: b90b7d0b     	str	w11, [x8, #0xb7c]
40003d28: 382b695f     	strb	wzr, [x10, x11]
40003d2c: 52800308     	mov	w8, #0x18               // =24
40003d30: 72a12008     	movk	w8, #0x900, lsl #16
40003d34: b9400109     	ldr	w9, [x8]
40003d38: 372fffe9     	tbnz	w9, #0x5, 0x40003d34 <uart_putc+0x44>
40003d3c: 12001c08     	and	w8, w0, #0xff
40003d40: 52a12009     	mov	w9, #0x9000000          // =150994944
40003d44: b9000128     	str	w8, [x9]
40003d48: d65f03c0     	ret

0000000040003d4c <uart_puts>:
40003d4c: 52800308     	mov	w8, #0x18               // =24
40003d50: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40003d54: 9000006a     	adrp	x10, 0x4000f000 <var_values+0x6a0>
40003d58: 72a12008     	movk	w8, #0x900, lsl #16
40003d5c: d503201f     	nop
40003d60: 1005f10b     	adr	x11, 0x4000fb80 <kernel_capture_buffer>
40003d64: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003d68: 528001ad     	mov	w13, #0xd               // =13
40003d6c: 52a1200e     	mov	w14, #0x9000000         // =150994944
40003d70: 3940000f     	ldrb	w15, [x0]
40003d74: 710029ff     	cmp	w15, #0xa
40003d78: 540000a0     	b.eq	0x40003d8c <uart_puts+0x40>
40003d7c: 3400040f     	cbz	w15, 0x40003dfc <uart_puts+0xb0>
40003d80: b94b7930     	ldr	w16, [x9, #0xb78]
40003d84: 35000230     	cbnz	w16, 0x40003dc8 <uart_puts+0x7c>
40003d88: 14000018     	b	0x40003de8 <uart_puts+0x9c>
40003d8c: b94b792f     	ldr	w15, [x9, #0xb78]
40003d90: 3400010f     	cbz	w15, 0x40003db0 <uart_puts+0x64>
40003d94: b94b7d4f     	ldr	w15, [x10, #0xb7c]
40003d98: 6b0c01ff     	cmp	w15, w12
40003d9c: 540000ac     	b.gt	0x40003db0 <uart_puts+0x64>
40003da0: 93407def     	sxtw	x15, w15
40003da4: 110005f0     	add	w16, w15, #0x1
40003da8: 782f696d     	strh	w13, [x11, x15]
40003dac: b90b7d50     	str	w16, [x10, #0xb7c]
40003db0: b940010f     	ldr	w15, [x8]
40003db4: 372fffef     	tbnz	w15, #0x5, 0x40003db0 <uart_puts+0x64>
40003db8: b90001cd     	str	w13, [x14]
40003dbc: 3940000f     	ldrb	w15, [x0]
40003dc0: b94b7930     	ldr	w16, [x9, #0xb78]
40003dc4: 34000130     	cbz	w16, 0x40003de8 <uart_puts+0x9c>
40003dc8: b94b7d50     	ldr	w16, [x10, #0xb7c]
40003dcc: 6b0c021f     	cmp	w16, w12
40003dd0: 540000cc     	b.gt	0x40003de8 <uart_puts+0x9c>
40003dd4: 93407e10     	sxtw	x16, w16
40003dd8: 91000611     	add	x17, x16, #0x1
40003ddc: 3830696f     	strb	w15, [x11, x16]
40003de0: b90b7d51     	str	w17, [x10, #0xb7c]
40003de4: 3831697f     	strb	wzr, [x11, x17]
40003de8: 91000400     	add	x0, x0, #0x1
40003dec: b9400110     	ldr	w16, [x8]
40003df0: 372ffff0     	tbnz	w16, #0x5, 0x40003dec <uart_puts+0xa0>
40003df4: b90001cf     	str	w15, [x14]
40003df8: 17ffffde     	b	0x40003d70 <uart_puts+0x24>
40003dfc: d65f03c0     	ret

0000000040003e00 <uart_has_data>:
40003e00: 52800308     	mov	w8, #0x18               // =24
40003e04: 52800029     	mov	w9, #0x1                // =1
40003e08: 72a12008     	movk	w8, #0x900, lsl #16
40003e0c: b9400108     	ldr	w8, [x8]
40003e10: 0a681120     	bic	w0, w9, w8, lsr #4
40003e14: d65f03c0     	ret

0000000040003e18 <uart_getc>:
40003e18: 52800308     	mov	w8, #0x18               // =24
40003e1c: 72a12008     	movk	w8, #0x900, lsl #16
40003e20: b9400109     	ldr	w9, [x8]
40003e24: 3727ffe9     	tbnz	w9, #0x4, 0x40003e20 <uart_getc+0x8>
40003e28: 52a12008     	mov	w8, #0x9000000          // =150994944
40003e2c: b9400100     	ldr	w0, [x8]
40003e30: d65f03c0     	ret

0000000040003e34 <uart_print_hex_raw>:
40003e34: 52800308     	mov	w8, #0x18               // =24
40003e38: 2a1f03eb     	mov	w11, wzr
40003e3c: 5280078c     	mov	w12, #0x3c              // =60
40003e40: 72a12008     	movk	w8, #0x900, lsl #16
40003e44: d503201f     	nop
40003e48: 10013e8e     	adr	x14, 0x40006618 <__rodata_start+0x618>
40003e4c: 9000006d     	adrp	x13, 0x4000f000 <var_values+0x6a0>
40003e50: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40003e54: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003e58: d503201f     	nop
40003e5c: 1005e92a     	adr	x10, 0x4000fb80 <kernel_capture_buffer>
40003e60: 52a12010     	mov	w16, #0x9000000         // =150994944
40003e64: 14000003     	b	0x40003e70 <uart_print_hex_raw+0x3c>
40003e68: b400032c     	cbz	x12, 0x40003ecc <uart_print_hex_raw+0x98>
40003e6c: d100118c     	sub	x12, x12, #0x4
40003e70: 9acc2411     	lsr	x17, x0, x12
40003e74: 53027d92     	lsr	w18, w12, #2
40003e78: 92400e31     	and	x17, x17, #0xf
40003e7c: 6b01025f     	cmp	w18, w1
40003e80: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003e84: 1a9f056b     	csinc	w11, w11, wzr, eq
40003e88: 34ffff0b     	cbz	w11, 0x40003e68 <uart_print_hex_raw+0x34>
40003e8c: b94b79b2     	ldr	w18, [x13, #0xb78]
40003e90: 387169d1     	ldrb	w17, [x14, x17]
40003e94: 34000132     	cbz	w18, 0x40003eb8 <uart_print_hex_raw+0x84>
40003e98: b94b7d32     	ldr	w18, [x9, #0xb7c]
40003e9c: 6b0f025f     	cmp	w18, w15
40003ea0: 540000cc     	b.gt	0x40003eb8 <uart_print_hex_raw+0x84>
40003ea4: 93407e52     	sxtw	x18, w18
40003ea8: 91000642     	add	x2, x18, #0x1
40003eac: 38326951     	strb	w17, [x10, x18]
40003eb0: b90b7d22     	str	w2, [x9, #0xb7c]
40003eb4: 3822695f     	strb	wzr, [x10, x2]
40003eb8: b9400112     	ldr	w18, [x8]
40003ebc: 372ffff2     	tbnz	w18, #0x5, 0x40003eb8 <uart_print_hex_raw+0x84>
40003ec0: b9000211     	str	w17, [x16]
40003ec4: b5fffd4c     	cbnz	x12, 0x40003e6c <uart_print_hex_raw+0x38>
40003ec8: d65f03c0     	ret
40003ecc: b94b79ab     	ldr	w11, [x13, #0xb78]
40003ed0: 3400014b     	cbz	w11, 0x40003ef8 <uart_print_hex_raw+0xc4>
40003ed4: b94b7d2b     	ldr	w11, [x9, #0xb7c]
40003ed8: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003edc: 6b0c017f     	cmp	w11, w12
40003ee0: 540000cc     	b.gt	0x40003ef8 <uart_print_hex_raw+0xc4>
40003ee4: 93407d6b     	sxtw	x11, w11
40003ee8: 1100056c     	add	w12, w11, #0x1
40003eec: b90b7d2c     	str	w12, [x9, #0xb7c]
40003ef0: 52800609     	mov	w9, #0x30               // =48
40003ef4: 782b6949     	strh	w9, [x10, x11]
40003ef8: b9400109     	ldr	w9, [x8]
40003efc: 372fffe9     	tbnz	w9, #0x5, 0x40003ef8 <uart_print_hex_raw+0xc4>
40003f00: 52a12008     	mov	w8, #0x9000000          // =150994944
40003f04: 52800609     	mov	w9, #0x30               // =48
40003f08: b9000109     	str	w9, [x8]
40003f0c: d65f03c0     	ret

0000000040003f10 <uart_print_hex>:
40003f10: 52800308     	mov	w8, #0x18               // =24
40003f14: 9000002c     	adrp	x12, 0x40007000 <__rodata_start+0x1000>
40003f18: 9122518c     	add	x12, x12, #0x894
40003f1c: 72a12008     	movk	w8, #0x900, lsl #16
40003f20: 9000006b     	adrp	x11, 0x4000f000 <var_values+0x6a0>
40003f24: 90000069     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40003f28: d503201f     	nop
40003f2c: 1005e2aa     	adr	x10, 0x4000fb80 <kernel_capture_buffer>
40003f30: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003f34: 528001ae     	mov	w14, #0xd               // =13
40003f38: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003f3c: 39400190     	ldrb	w16, [x12]
40003f40: 71002a1f     	cmp	w16, #0xa
40003f44: 540000a0     	b.eq	0x40003f58 <uart_print_hex+0x48>
40003f48: 340003f0     	cbz	w16, 0x40003fc4 <uart_print_hex+0xb4>
40003f4c: b94b7971     	ldr	w17, [x11, #0xb78]
40003f50: 35000211     	cbnz	w17, 0x40003f90 <uart_print_hex+0x80>
40003f54: 14000017     	b	0x40003fb0 <uart_print_hex+0xa0>
40003f58: b94b7971     	ldr	w17, [x11, #0xb78]
40003f5c: 34000111     	cbz	w17, 0x40003f7c <uart_print_hex+0x6c>
40003f60: b94b7d31     	ldr	w17, [x9, #0xb7c]
40003f64: 6b0d023f     	cmp	w17, w13
40003f68: 540000ac     	b.gt	0x40003f7c <uart_print_hex+0x6c>
40003f6c: 93407e31     	sxtw	x17, w17
40003f70: 11000632     	add	w18, w17, #0x1
40003f74: 7831694e     	strh	w14, [x10, x17]
40003f78: b90b7d32     	str	w18, [x9, #0xb7c]
40003f7c: b9400111     	ldr	w17, [x8]
40003f80: 372ffff1     	tbnz	w17, #0x5, 0x40003f7c <uart_print_hex+0x6c>
40003f84: b90001ee     	str	w14, [x15]
40003f88: b94b7971     	ldr	w17, [x11, #0xb78]
40003f8c: 34000131     	cbz	w17, 0x40003fb0 <uart_print_hex+0xa0>
40003f90: b94b7d31     	ldr	w17, [x9, #0xb7c]
40003f94: 6b0d023f     	cmp	w17, w13
40003f98: 540000cc     	b.gt	0x40003fb0 <uart_print_hex+0xa0>
40003f9c: 93407e31     	sxtw	x17, w17
40003fa0: 91000632     	add	x18, x17, #0x1
40003fa4: 38316950     	strb	w16, [x10, x17]
40003fa8: b90b7d32     	str	w18, [x9, #0xb7c]
40003fac: 3832695f     	strb	wzr, [x10, x18]
40003fb0: 9100058c     	add	x12, x12, #0x1
40003fb4: b9400111     	ldr	w17, [x8]
40003fb8: 372ffff1     	tbnz	w17, #0x5, 0x40003fb4 <uart_print_hex+0xa4>
40003fbc: b90001f0     	str	w16, [x15]
40003fc0: 17ffffdf     	b	0x40003f3c <uart_print_hex+0x2c>
40003fc4: 2a1f03ec     	mov	w12, wzr
40003fc8: d503201f     	nop
40003fcc: 1001326d     	adr	x13, 0x40006618 <__rodata_start+0x618>
40003fd0: 5280078e     	mov	w14, #0x3c              // =60
40003fd4: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003fd8: 52a12010     	mov	w16, #0x9000000         // =150994944
40003fdc: 14000003     	b	0x40003fe8 <uart_print_hex+0xd8>
40003fe0: b40002ee     	cbz	x14, 0x4000403c <uart_print_hex+0x12c>
40003fe4: d10011ce     	sub	x14, x14, #0x4
40003fe8: 9ace2411     	lsr	x17, x0, x14
40003fec: f2400e31     	ands	x17, x17, #0xf
40003ff0: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003ff4: 1a9f158c     	csinc	w12, w12, wzr, ne
40003ff8: 34ffff4c     	cbz	w12, 0x40003fe0 <uart_print_hex+0xd0>
40003ffc: b94b7972     	ldr	w18, [x11, #0xb78]
40004000: 387169b1     	ldrb	w17, [x13, x17]
40004004: 34000132     	cbz	w18, 0x40004028 <uart_print_hex+0x118>
40004008: b94b7d32     	ldr	w18, [x9, #0xb7c]
4000400c: 6b0f025f     	cmp	w18, w15
40004010: 540000cc     	b.gt	0x40004028 <uart_print_hex+0x118>
40004014: 93407e52     	sxtw	x18, w18
40004018: 91000641     	add	x1, x18, #0x1
4000401c: 38326951     	strb	w17, [x10, x18]
40004020: b90b7d21     	str	w1, [x9, #0xb7c]
40004024: 3821695f     	strb	wzr, [x10, x1]
40004028: b9400112     	ldr	w18, [x8]
4000402c: 372ffff2     	tbnz	w18, #0x5, 0x40004028 <uart_print_hex+0x118>
40004030: b9000211     	str	w17, [x16]
40004034: b5fffd8e     	cbnz	x14, 0x40003fe4 <uart_print_hex+0xd4>
40004038: d65f03c0     	ret
4000403c: b94b796b     	ldr	w11, [x11, #0xb78]
40004040: 3400014b     	cbz	w11, 0x40004068 <uart_print_hex+0x158>
40004044: b94b7d2b     	ldr	w11, [x9, #0xb7c]
40004048: 5287ffcc     	mov	w12, #0x3ffe            // =16382
4000404c: 6b0c017f     	cmp	w11, w12
40004050: 540000cc     	b.gt	0x40004068 <uart_print_hex+0x158>
40004054: 93407d6b     	sxtw	x11, w11
40004058: 1100056c     	add	w12, w11, #0x1
4000405c: b90b7d2c     	str	w12, [x9, #0xb7c]
40004060: 52800609     	mov	w9, #0x30               // =48
40004064: 782b6949     	strh	w9, [x10, x11]
40004068: b9400109     	ldr	w9, [x8]
4000406c: 372fffe9     	tbnz	w9, #0x5, 0x40004068 <uart_print_hex+0x158>
40004070: 52a12008     	mov	w8, #0x9000000          // =150994944
40004074: 52800609     	mov	w9, #0x30               // =48
40004078: b9000109     	str	w9, [x8]
4000407c: d65f03c0     	ret

0000000040004080 <uart_print_dec>:
40004080: d10083ff     	sub	sp, sp, #0x20
40004084: 52800308     	mov	w8, #0x18               // =24
40004088: 72a12008     	movk	w8, #0x900, lsl #16
4000408c: b4000540     	cbz	x0, 0x40004134 <uart_print_dec+0xb4>
40004090: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40004094: aa1f03e9     	mov	x9, xzr
40004098: 5280014b     	mov	w11, #0xa               // =10
4000409c: f29999aa     	movk	x10, #0xcccd
400040a0: 910023ec     	add	x12, sp, #0x8
400040a4: 9bca7c0d     	umulh	x13, x0, x10
400040a8: f100241f     	cmp	x0, #0x9
400040ac: d343fdad     	lsr	x13, x13, #3
400040b0: 1b0b81ae     	msub	w14, w13, w11, w0
400040b4: aa0d03e0     	mov	x0, x13
400040b8: 321c05ce     	orr	w14, w14, #0x30
400040bc: 3829698e     	strb	w14, [x12, x9]
400040c0: 91000529     	add	x9, x9, #0x1
400040c4: 54ffff08     	b.hi	0x400040a4 <uart_print_dec+0x24>
400040c8: 910023ea     	add	x10, sp, #0x8
400040cc: f000004b     	adrp	x11, 0x4000f000 <var_values+0x6a0>
400040d0: f000004c     	adrp	x12, 0x4000f000 <var_values+0x6a0>
400040d4: 5287ffcd     	mov	w13, #0x3ffe            // =16382
400040d8: d503201f     	nop
400040dc: 1005d52e     	adr	x14, 0x4000fb80 <kernel_capture_buffer>
400040e0: 52a1200f     	mov	w15, #0x9000000         // =150994944
400040e4: d1000530     	sub	x16, x9, #0x1
400040e8: b94b7972     	ldr	w18, [x11, #0xb78]
400040ec: 38706951     	ldrb	w17, [x10, x16]
400040f0: 34000132     	cbz	w18, 0x40004114 <uart_print_dec+0x94>
400040f4: b94b7d92     	ldr	w18, [x12, #0xb7c]
400040f8: 6b0d025f     	cmp	w18, w13
400040fc: 540000cc     	b.gt	0x40004114 <uart_print_dec+0x94>
40004100: 93407e52     	sxtw	x18, w18
40004104: 91000640     	add	x0, x18, #0x1
40004108: 383269d1     	strb	w17, [x14, x18]
4000410c: b90b7d80     	str	w0, [x12, #0xb7c]
40004110: 382069df     	strb	wzr, [x14, x0]
40004114: b9400112     	ldr	w18, [x8]
40004118: 372ffff2     	tbnz	w18, #0x5, 0x40004114 <uart_print_dec+0x94>
4000411c: 7100053f     	cmp	w9, #0x1
40004120: aa1003e9     	mov	x9, x16
40004124: b90001f1     	str	w17, [x15]
40004128: 54fffdec     	b.gt	0x400040e4 <uart_print_dec+0x64>
4000412c: 910083ff     	add	sp, sp, #0x20
40004130: d65f03c0     	ret
40004134: f0000049     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40004138: b94b7929     	ldr	w9, [x9, #0xb78]
4000413c: 340001a9     	cbz	w9, 0x40004170 <uart_print_dec+0xf0>
40004140: f0000049     	adrp	x9, 0x4000f000 <var_values+0x6a0>
40004144: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40004148: b94b7d2a     	ldr	w10, [x9, #0xb7c]
4000414c: 6b0b015f     	cmp	w10, w11
40004150: 5400010c     	b.gt	0x40004170 <uart_print_dec+0xf0>
40004154: 93407d4a     	sxtw	x10, w10
40004158: d503201f     	nop
4000415c: 1005d12c     	adr	x12, 0x4000fb80 <kernel_capture_buffer>
40004160: 1100054b     	add	w11, w10, #0x1
40004164: b90b7d2b     	str	w11, [x9, #0xb7c]
40004168: 52800609     	mov	w9, #0x30               // =48
4000416c: 782a6989     	strh	w9, [x12, x10]
40004170: b9400109     	ldr	w9, [x8]
40004174: 372fffe9     	tbnz	w9, #0x5, 0x40004170 <uart_print_dec+0xf0>
40004178: 52a12008     	mov	w8, #0x9000000          // =150994944
4000417c: 52800609     	mov	w9, #0x30               // =48
40004180: b9000109     	str	w9, [x8]
40004184: 910083ff     	add	sp, sp, #0x20
40004188: d65f03c0     	ret

000000004000418c <uart_printf>:
4000418c: d10583ff     	sub	sp, sp, #0x160
40004190: a9107bfd     	stp	x29, x30, [sp, #0x100]
40004194: 910403fd     	add	x29, sp, #0x100
40004198: 928006e8     	mov	x8, #-0x38              // =-56
4000419c: a91457f6     	stp	x22, x21, [sp, #0x140]
400041a0: 52800315     	mov	w21, #0x18              // =24
400041a4: 910003e9     	mov	x9, sp
400041a8: d101e3aa     	sub	x10, x29, #0x78
400041ac: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
400041b0: a9116ffc     	stp	x28, x27, [sp, #0x110]
400041b4: a91267fa     	stp	x26, x25, [sp, #0x120]
400041b8: 72a12015     	movk	w21, #0x900, lsl #16
400041bc: f2dff008     	movk	x8, #0xff80, lsl #32
400041c0: a9135ff8     	stp	x24, x23, [sp, #0x130]
400041c4: 91020129     	add	x9, x9, #0x80
400041c8: 9100e14a     	add	x10, x10, #0x38
400041cc: a9154ff4     	stp	x20, x19, [sp, #0x150]
400041d0: aa0003f3     	mov	x19, x0
400041d4: aa1f03f4     	mov	x20, xzr
400041d8: 910183ab     	add	x11, x29, #0x60
400041dc: f0000056     	adrp	x22, 0x4000f000 <var_values+0x6a0>
400041e0: f0000057     	adrp	x23, 0x4000f000 <var_values+0x6a0>
400041e4: d503201f     	nop
400041e8: 1005ccd8     	adr	x24, 0x4000fb80 <kernel_capture_buffer>
400041ec: 5287ffd9     	mov	w25, #0x3ffe            // =16382
400041f0: 528001ba     	mov	w26, #0xd               // =13
400041f4: 52a1201b     	mov	w27, #0x9000000         // =150994944
400041f8: 528004ae     	mov	w14, #0x25              // =37
400041fc: f29999af     	movk	x15, #0xcccd
40004200: 52800150     	mov	w16, #0xa               // =10
40004204: d10083bc     	sub	x28, x29, #0x20
40004208: d503201f     	nop
4000420c: 10012071     	adr	x17, 0x40006618 <__rodata_start+0x618>
40004210: a9388ba1     	stp	x1, x2, [x29, #-0x78]
40004214: a93993a3     	stp	x3, x4, [x29, #-0x68]
40004218: a93a9ba5     	stp	x5, x6, [x29, #-0x58]
4000421c: f81b83a7     	stur	x7, [x29, #-0x48]
40004220: ad0007e0     	stp	q0, q1, [sp]
40004224: ad010fe2     	stp	q2, q3, [sp, #0x20]
40004228: ad0217e4     	stp	q4, q5, [sp, #0x40]
4000422c: ad031fe6     	stp	q6, q7, [sp, #0x60]
40004230: a93d23a9     	stp	x9, x8, [x29, #-0x30]
40004234: a93c2bab     	stp	x11, x10, [x29, #-0x40]
40004238: 14000004     	b	0x40004248 <uart_printf+0xbc>
4000423c: 52800608     	mov	w8, #0x30               // =48
40004240: b9000368     	str	w8, [x27]
40004244: 91000694     	add	x20, x20, #0x1
40004248: 38746a68     	ldrb	w8, [x19, x20]
4000424c: 7100291f     	cmp	w8, #0xa
40004250: 54000440     	b.eq	0x400042d8 <uart_printf+0x14c>
40004254: 7100951f     	cmp	w8, #0x25
40004258: 540000a0     	b.eq	0x4000426c <uart_printf+0xe0>
4000425c: 340039e8     	cbz	w8, 0x40004998 <uart_printf+0x80c>
40004260: b94b7ac9     	ldr	w9, [x22, #0xb78]
40004264: 35000589     	cbnz	w9, 0x40004314 <uart_printf+0x188>
40004268: 14000033     	b	0x40004334 <uart_printf+0x1a8>
4000426c: 9100068a     	add	x10, x20, #0x1
40004270: 386a6a68     	ldrb	w8, [x19, x10]
40004274: 7101b11f     	cmp	w8, #0x6c
40004278: 54000641     	b.ne	0x40004340 <uart_printf+0x1b4>
4000427c: 91000a89     	add	x9, x20, #0x2
40004280: 91000e8b     	add	x11, x20, #0x3
40004284: 38696a6a     	ldrb	w10, [x19, x9]
40004288: 7101b15f     	cmp	w10, #0x6c
4000428c: 9a890174     	csel	x20, x11, x9, eq
40004290: 38746a69     	ldrb	w9, [x19, x20]
40004294: 7101bd3f     	cmp	w9, #0x6f
40004298: 540005cd     	b.le	0x40004350 <uart_printf+0x1c4>
4000429c: 7101d13f     	cmp	w9, #0x74
400042a0: 540007ec     	b.gt	0x4000439c <uart_printf+0x210>
400042a4: 7101c13f     	cmp	w9, #0x70
400042a8: 54000ea0     	b.eq	0x4000447c <uart_printf+0x2f0>
400042ac: 7101cd3f     	cmp	w9, #0x73
400042b0: 54000b21     	b.ne	0x40004414 <uart_printf+0x288>
400042b4: b89d83a8     	ldursw	x8, [x29, #-0x28]
400042b8: 36f813a8     	tbz	w8, #0x1f, 0x4000452c <uart_printf+0x3a0>
400042bc: 11002109     	add	w9, w8, #0x8
400042c0: 3100211f     	cmn	w8, #0x8
400042c4: b81d83a9     	stur	w9, [x29, #-0x28]
400042c8: 54001328     	b.hi	0x4000452c <uart_printf+0x3a0>
400042cc: f85c83a9     	ldur	x9, [x29, #-0x38]
400042d0: 8b080128     	add	x8, x9, x8
400042d4: 14000099     	b	0x40004538 <uart_printf+0x3ac>
400042d8: b94b7ac8     	ldr	w8, [x22, #0xb78]
400042dc: 34000108     	cbz	w8, 0x400042fc <uart_printf+0x170>
400042e0: b94b7ee8     	ldr	w8, [x23, #0xb7c]
400042e4: 6b19011f     	cmp	w8, w25
400042e8: 540000ac     	b.gt	0x400042fc <uart_printf+0x170>
400042ec: 93407d08     	sxtw	x8, w8
400042f0: 11000509     	add	w9, w8, #0x1
400042f4: 78286b1a     	strh	w26, [x24, x8]
400042f8: b90b7ee9     	str	w9, [x23, #0xb7c]
400042fc: b94002a8     	ldr	w8, [x21]
40004300: 372fffe8     	tbnz	w8, #0x5, 0x400042fc <uart_printf+0x170>
40004304: b900037a     	str	w26, [x27]
40004308: 38746a68     	ldrb	w8, [x19, x20]
4000430c: b94b7ac9     	ldr	w9, [x22, #0xb78]
40004310: 34000129     	cbz	w9, 0x40004334 <uart_printf+0x1a8>
40004314: b94b7ee9     	ldr	w9, [x23, #0xb7c]
40004318: 6b19013f     	cmp	w9, w25
4000431c: 540000cc     	b.gt	0x40004334 <uart_printf+0x1a8>
40004320: 93407d29     	sxtw	x9, w9
40004324: 9100052a     	add	x10, x9, #0x1
40004328: 38296b08     	strb	w8, [x24, x9]
4000432c: b90b7eea     	str	w10, [x23, #0xb7c]
40004330: 382a6b1f     	strb	wzr, [x24, x10]
40004334: b94002a9     	ldr	w9, [x21]
40004338: 372fffe9     	tbnz	w9, #0x5, 0x40004334 <uart_printf+0x1a8>
4000433c: 17ffffc1     	b	0x40004240 <uart_printf+0xb4>
40004340: 2a0803e9     	mov	w9, w8
40004344: aa0a03f4     	mov	x20, x10
40004348: 7101bd3f     	cmp	w9, #0x6f
4000434c: 54fffa8c     	b.gt	0x4000429c <uart_printf+0x110>
40004350: 7100953f     	cmp	w9, #0x25
40004354: 54000440     	b.eq	0x400043dc <uart_printf+0x250>
40004358: 71018d3f     	cmp	w9, #0x63
4000435c: 54000bc0     	b.eq	0x400044d4 <uart_printf+0x348>
40004360: 7101913f     	cmp	w9, #0x64
40004364: 54000581     	b.ne	0x40004414 <uart_printf+0x288>
40004368: b89d83a9     	ldursw	x9, [x29, #-0x28]
4000436c: 7101b11f     	cmp	w8, #0x6c
40004370: 54001761     	b.ne	0x4000465c <uart_printf+0x4d0>
40004374: 36f82349     	tbz	w9, #0x1f, 0x400047dc <uart_printf+0x650>
40004378: 11002128     	add	w8, w9, #0x8
4000437c: 3100213f     	cmn	w9, #0x8
40004380: b81d83a8     	stur	w8, [x29, #-0x28]
40004384: 540022c8     	b.hi	0x400047dc <uart_printf+0x650>
40004388: f85c83a8     	ldur	x8, [x29, #-0x38]
4000438c: 8b090108     	add	x8, x8, x9
40004390: f9400109     	ldr	x9, [x8]
40004394: b6f82909     	tbz	x9, #0x3f, 0x400048b4 <uart_printf+0x728>
40004398: 14000116     	b	0x400047f0 <uart_printf+0x664>
4000439c: 7101d53f     	cmp	w9, #0x75
400043a0: 54000800     	b.eq	0x400044a0 <uart_printf+0x314>
400043a4: 7101e13f     	cmp	w9, #0x78
400043a8: 54000361     	b.ne	0x40004414 <uart_printf+0x288>
400043ac: b89d83a9     	ldursw	x9, [x29, #-0x28]
400043b0: 7101b11f     	cmp	w8, #0x6c
400043b4: 54001441     	b.ne	0x4000463c <uart_printf+0x4b0>
400043b8: 36f81cc9     	tbz	w9, #0x1f, 0x40004750 <uart_printf+0x5c4>
400043bc: 11002128     	add	w8, w9, #0x8
400043c0: 3100213f     	cmn	w9, #0x8
400043c4: b81d83a8     	stur	w8, [x29, #-0x28]
400043c8: 54001c48     	b.hi	0x40004750 <uart_printf+0x5c4>
400043cc: f85c83a8     	ldur	x8, [x29, #-0x38]
400043d0: 8b090108     	add	x8, x8, x9
400043d4: f9400108     	ldr	x8, [x8]
400043d8: 140000e7     	b	0x40004774 <uart_printf+0x5e8>
400043dc: b94b7ac8     	ldr	w8, [x22, #0xb78]
400043e0: 34000108     	cbz	w8, 0x40004400 <uart_printf+0x274>
400043e4: b94b7ee8     	ldr	w8, [x23, #0xb7c]
400043e8: 6b19011f     	cmp	w8, w25
400043ec: 540000ac     	b.gt	0x40004400 <uart_printf+0x274>
400043f0: 93407d08     	sxtw	x8, w8
400043f4: 11000509     	add	w9, w8, #0x1
400043f8: 78286b0e     	strh	w14, [x24, x8]
400043fc: b90b7ee9     	str	w9, [x23, #0xb7c]
40004400: b94002a8     	ldr	w8, [x21]
40004404: 372fffe8     	tbnz	w8, #0x5, 0x40004400 <uart_printf+0x274>
40004408: b900036e     	str	w14, [x27]
4000440c: 91000694     	add	x20, x20, #0x1
40004410: 17ffff8e     	b	0x40004248 <uart_printf+0xbc>
40004414: b94b7ac8     	ldr	w8, [x22, #0xb78]
40004418: 34000108     	cbz	w8, 0x40004438 <uart_printf+0x2ac>
4000441c: b94b7ee8     	ldr	w8, [x23, #0xb7c]
40004420: 6b19011f     	cmp	w8, w25
40004424: 540000ac     	b.gt	0x40004438 <uart_printf+0x2ac>
40004428: 93407d08     	sxtw	x8, w8
4000442c: 11000509     	add	w9, w8, #0x1
40004430: 78286b0e     	strh	w14, [x24, x8]
40004434: b90b7ee9     	str	w9, [x23, #0xb7c]
40004438: b94002a8     	ldr	w8, [x21]
4000443c: 372fffe8     	tbnz	w8, #0x5, 0x40004438 <uart_printf+0x2ac>
40004440: b900036e     	str	w14, [x27]
40004444: b94b7ac9     	ldr	w9, [x22, #0xb78]
40004448: 38746a68     	ldrb	w8, [x19, x20]
4000444c: 34000129     	cbz	w9, 0x40004470 <uart_printf+0x2e4>
40004450: b94b7ee9     	ldr	w9, [x23, #0xb7c]
40004454: 6b19013f     	cmp	w9, w25
40004458: 540000cc     	b.gt	0x40004470 <uart_printf+0x2e4>
4000445c: 93407d29     	sxtw	x9, w9
40004460: 9100052a     	add	x10, x9, #0x1
40004464: 38296b08     	strb	w8, [x24, x9]
40004468: b90b7eea     	str	w10, [x23, #0xb7c]
4000446c: 382a6b1f     	strb	wzr, [x24, x10]
40004470: b94002a9     	ldr	w9, [x21]
40004474: 372fffe9     	tbnz	w9, #0x5, 0x40004470 <uart_printf+0x2e4>
40004478: 17ffff72     	b	0x40004240 <uart_printf+0xb4>
4000447c: b89d83a8     	ldursw	x8, [x29, #-0x28]
40004480: 36f803c8     	tbz	w8, #0x1f, 0x400044f8 <uart_printf+0x36c>
40004484: 11002109     	add	w9, w8, #0x8
40004488: 3100211f     	cmn	w8, #0x8
4000448c: b81d83a9     	stur	w9, [x29, #-0x28]
40004490: 54000348     	b.hi	0x400044f8 <uart_printf+0x36c>
40004494: f85c83a9     	ldur	x9, [x29, #-0x38]
40004498: 8b080128     	add	x8, x9, x8
4000449c: 1400001a     	b	0x40004504 <uart_printf+0x378>
400044a0: b89d83a9     	ldursw	x9, [x29, #-0x28]
400044a4: 7101b11f     	cmp	w8, #0x6c
400044a8: 54000ba1     	b.ne	0x4000461c <uart_printf+0x490>
400044ac: 36f80e89     	tbz	w9, #0x1f, 0x4000467c <uart_printf+0x4f0>
400044b0: 11002128     	add	w8, w9, #0x8
400044b4: 3100213f     	cmn	w9, #0x8
400044b8: b81d83a8     	stur	w8, [x29, #-0x28]
400044bc: 54000e08     	b.hi	0x4000467c <uart_printf+0x4f0>
400044c0: f85c83a8     	ldur	x8, [x29, #-0x38]
400044c4: 8b090108     	add	x8, x8, x9
400044c8: f9400109     	ldr	x9, [x8]
400044cc: b5001069     	cbnz	x9, 0x400046d8 <uart_printf+0x54c>
400044d0: 14000070     	b	0x40004690 <uart_printf+0x504>
400044d4: b89d83a8     	ldursw	x8, [x29, #-0x28]
400044d8: 36f80808     	tbz	w8, #0x1f, 0x400045d8 <uart_printf+0x44c>
400044dc: 11002109     	add	w9, w8, #0x8
400044e0: 3100211f     	cmn	w8, #0x8
400044e4: b81d83a9     	stur	w9, [x29, #-0x28]
400044e8: 54000788     	b.hi	0x400045d8 <uart_printf+0x44c>
400044ec: f85c83a9     	ldur	x9, [x29, #-0x38]
400044f0: 8b080128     	add	x8, x9, x8
400044f4: 1400003c     	b	0x400045e4 <uart_printf+0x458>
400044f8: f85c03a8     	ldur	x8, [x29, #-0x40]
400044fc: 91002109     	add	x9, x8, #0x8
40004500: f81c03a9     	stur	x9, [x29, #-0x40]
40004504: f9400100     	ldr	x0, [x8]
40004508: 97fffe82     	bl	0x40003f10 <uart_print_hex>
4000450c: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40004510: 528004ae     	mov	w14, #0x25              // =37
40004514: 52800150     	mov	w16, #0xa               // =10
40004518: f29999af     	movk	x15, #0xcccd
4000451c: d503201f     	nop
40004520: 100107d1     	adr	x17, 0x40006618 <__rodata_start+0x618>
40004524: 91000694     	add	x20, x20, #0x1
40004528: 17ffff48     	b	0x40004248 <uart_printf+0xbc>
4000452c: f85c03a8     	ldur	x8, [x29, #-0x40]
40004530: 91002109     	add	x9, x8, #0x8
40004534: f81c03a9     	stur	x9, [x29, #-0x40]
40004538: f9400108     	ldr	x8, [x8]
4000453c: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x3000>
40004540: 9111d929     	add	x9, x9, #0x476
40004544: f100011f     	cmp	x8, #0x0
40004548: 9a880128     	csel	x8, x9, x8, eq
4000454c: 39400109     	ldrb	w9, [x8]
40004550: 7100293f     	cmp	w9, #0xa
40004554: 540000a0     	b.eq	0x40004568 <uart_printf+0x3dc>
40004558: 34ffe769     	cbz	w9, 0x40004244 <uart_printf+0xb8>
4000455c: b94b7aca     	ldr	w10, [x22, #0xb78]
40004560: 3500022a     	cbnz	w10, 0x400045a4 <uart_printf+0x418>
40004564: 14000018     	b	0x400045c4 <uart_printf+0x438>
40004568: b94b7ac9     	ldr	w9, [x22, #0xb78]
4000456c: 34000109     	cbz	w9, 0x4000458c <uart_printf+0x400>
40004570: b94b7ee9     	ldr	w9, [x23, #0xb7c]
40004574: 6b19013f     	cmp	w9, w25
40004578: 540000ac     	b.gt	0x4000458c <uart_printf+0x400>
4000457c: 93407d29     	sxtw	x9, w9
40004580: 1100052a     	add	w10, w9, #0x1
40004584: 78296b1a     	strh	w26, [x24, x9]
40004588: b90b7eea     	str	w10, [x23, #0xb7c]
4000458c: b94002a9     	ldr	w9, [x21]
40004590: 372fffe9     	tbnz	w9, #0x5, 0x4000458c <uart_printf+0x400>
40004594: b900037a     	str	w26, [x27]
40004598: 39400109     	ldrb	w9, [x8]
4000459c: b94b7aca     	ldr	w10, [x22, #0xb78]
400045a0: 3400012a     	cbz	w10, 0x400045c4 <uart_printf+0x438>
400045a4: b94b7eea     	ldr	w10, [x23, #0xb7c]
400045a8: 6b19015f     	cmp	w10, w25
400045ac: 540000cc     	b.gt	0x400045c4 <uart_printf+0x438>
400045b0: 93407d4a     	sxtw	x10, w10
400045b4: 9100054b     	add	x11, x10, #0x1
400045b8: 382a6b09     	strb	w9, [x24, x10]
400045bc: b90b7eeb     	str	w11, [x23, #0xb7c]
400045c0: 382b6b1f     	strb	wzr, [x24, x11]
400045c4: 91000508     	add	x8, x8, #0x1
400045c8: b94002aa     	ldr	w10, [x21]
400045cc: 372fffea     	tbnz	w10, #0x5, 0x400045c8 <uart_printf+0x43c>
400045d0: b9000369     	str	w9, [x27]
400045d4: 17ffffde     	b	0x4000454c <uart_printf+0x3c0>
400045d8: f85c03a8     	ldur	x8, [x29, #-0x40]
400045dc: 91002109     	add	x9, x8, #0x8
400045e0: f81c03a9     	stur	x9, [x29, #-0x40]
400045e4: b94b7ac9     	ldr	w9, [x22, #0xb78]
400045e8: 39400108     	ldrb	w8, [x8]
400045ec: 34000129     	cbz	w9, 0x40004610 <uart_printf+0x484>
400045f0: b94b7ee9     	ldr	w9, [x23, #0xb7c]
400045f4: 6b19013f     	cmp	w9, w25
400045f8: 540000cc     	b.gt	0x40004610 <uart_printf+0x484>
400045fc: 93407d29     	sxtw	x9, w9
40004600: 9100052a     	add	x10, x9, #0x1
40004604: 38296b08     	strb	w8, [x24, x9]
40004608: b90b7eea     	str	w10, [x23, #0xb7c]
4000460c: 382a6b1f     	strb	wzr, [x24, x10]
40004610: b94002a9     	ldr	w9, [x21]
40004614: 372fffe9     	tbnz	w9, #0x5, 0x40004610 <uart_printf+0x484>
40004618: 17ffff0a     	b	0x40004240 <uart_printf+0xb4>
4000461c: 36f80549     	tbz	w9, #0x1f, 0x400046c4 <uart_printf+0x538>
40004620: 11002128     	add	w8, w9, #0x8
40004624: 3100213f     	cmn	w9, #0x8
40004628: b81d83a8     	stur	w8, [x29, #-0x28]
4000462c: 540004c8     	b.hi	0x400046c4 <uart_printf+0x538>
40004630: f85c83a8     	ldur	x8, [x29, #-0x38]
40004634: 8b090108     	add	x8, x8, x9
40004638: 14000026     	b	0x400046d0 <uart_printf+0x544>
4000463c: 36f80949     	tbz	w9, #0x1f, 0x40004764 <uart_printf+0x5d8>
40004640: 11002128     	add	w8, w9, #0x8
40004644: 3100213f     	cmn	w9, #0x8
40004648: b81d83a8     	stur	w8, [x29, #-0x28]
4000464c: 540008c8     	b.hi	0x40004764 <uart_printf+0x5d8>
40004650: f85c83a8     	ldur	x8, [x29, #-0x38]
40004654: 8b090108     	add	x8, x8, x9
40004658: 14000046     	b	0x40004770 <uart_printf+0x5e4>
4000465c: 36f81229     	tbz	w9, #0x1f, 0x400048a0 <uart_printf+0x714>
40004660: 11002128     	add	w8, w9, #0x8
40004664: 3100213f     	cmn	w9, #0x8
40004668: b81d83a8     	stur	w8, [x29, #-0x28]
4000466c: 540011a8     	b.hi	0x400048a0 <uart_printf+0x714>
40004670: f85c83a8     	ldur	x8, [x29, #-0x38]
40004674: 8b090108     	add	x8, x8, x9
40004678: 1400008d     	b	0x400048ac <uart_printf+0x720>
4000467c: f85c03a8     	ldur	x8, [x29, #-0x40]
40004680: 91002109     	add	x9, x8, #0x8
40004684: f81c03a9     	stur	x9, [x29, #-0x40]
40004688: f9400109     	ldr	x9, [x8]
4000468c: b5000269     	cbnz	x9, 0x400046d8 <uart_printf+0x54c>
40004690: b94b7ac8     	ldr	w8, [x22, #0xb78]
40004694: 34000128     	cbz	w8, 0x400046b8 <uart_printf+0x52c>
40004698: b94b7ee8     	ldr	w8, [x23, #0xb7c]
4000469c: 6b19011f     	cmp	w8, w25
400046a0: 540000cc     	b.gt	0x400046b8 <uart_printf+0x52c>
400046a4: 93407d08     	sxtw	x8, w8
400046a8: 11000509     	add	w9, w8, #0x1
400046ac: b90b7ee9     	str	w9, [x23, #0xb7c]
400046b0: 52800609     	mov	w9, #0x30               // =48
400046b4: 78286b09     	strh	w9, [x24, x8]
400046b8: b94002a8     	ldr	w8, [x21]
400046bc: 372fffe8     	tbnz	w8, #0x5, 0x400046b8 <uart_printf+0x52c>
400046c0: 17fffedf     	b	0x4000423c <uart_printf+0xb0>
400046c4: f85c03a8     	ldur	x8, [x29, #-0x40]
400046c8: 91002109     	add	x9, x8, #0x8
400046cc: f81c03a9     	stur	x9, [x29, #-0x40]
400046d0: b9400109     	ldr	w9, [x8]
400046d4: b4fffde9     	cbz	x9, 0x40004690 <uart_printf+0x504>
400046d8: aa1f03ea     	mov	x10, xzr
400046dc: 9bcf7d28     	umulh	x8, x9, x15
400046e0: f100253f     	cmp	x9, #0x9
400046e4: d343fd0b     	lsr	x11, x8, #3
400046e8: 91000548     	add	x8, x10, #0x1
400046ec: 1b10a56c     	msub	w12, w11, w16, w9
400046f0: 321c0589     	orr	w9, w12, #0x30
400046f4: 382a6b89     	strb	w9, [x28, x10]
400046f8: aa0803ea     	mov	x10, x8
400046fc: aa0b03e9     	mov	x9, x11
40004700: 54fffee8     	b.hi	0x400046dc <uart_printf+0x550>
40004704: d1000509     	sub	x9, x8, #0x1
40004708: b94b7acb     	ldr	w11, [x22, #0xb78]
4000470c: 38696b8a     	ldrb	w10, [x28, x9]
40004710: 3400012b     	cbz	w11, 0x40004734 <uart_printf+0x5a8>
40004714: b94b7eeb     	ldr	w11, [x23, #0xb7c]
40004718: 6b19017f     	cmp	w11, w25
4000471c: 540000cc     	b.gt	0x40004734 <uart_printf+0x5a8>
40004720: 93407d6b     	sxtw	x11, w11
40004724: 9100056c     	add	x12, x11, #0x1
40004728: 382b6b0a     	strb	w10, [x24, x11]
4000472c: b90b7eec     	str	w12, [x23, #0xb7c]
40004730: 382c6b1f     	strb	wzr, [x24, x12]
40004734: b94002ab     	ldr	w11, [x21]
40004738: 372fffeb     	tbnz	w11, #0x5, 0x40004734 <uart_printf+0x5a8>
4000473c: 7100051f     	cmp	w8, #0x1
40004740: aa0903e8     	mov	x8, x9
40004744: b900036a     	str	w10, [x27]
40004748: 54fffdec     	b.gt	0x40004704 <uart_printf+0x578>
4000474c: 17fffebe     	b	0x40004244 <uart_printf+0xb8>
40004750: f85c03a8     	ldur	x8, [x29, #-0x40]
40004754: 91002109     	add	x9, x8, #0x8
40004758: f81c03a9     	stur	x9, [x29, #-0x40]
4000475c: f9400108     	ldr	x8, [x8]
40004760: 14000005     	b	0x40004774 <uart_printf+0x5e8>
40004764: f85c03a8     	ldur	x8, [x29, #-0x40]
40004768: 91002109     	add	x9, x8, #0x8
4000476c: f81c03a9     	stur	x9, [x29, #-0x40]
40004770: b9400108     	ldr	w8, [x8]
40004774: 2a1f03e9     	mov	w9, wzr
40004778: 5280078a     	mov	w10, #0x3c              // =60
4000477c: 14000003     	b	0x40004788 <uart_printf+0x5fc>
40004780: b4000d8a     	cbz	x10, 0x40004930 <uart_printf+0x7a4>
40004784: d100114a     	sub	x10, x10, #0x4
40004788: 9aca250b     	lsr	x11, x8, x10
4000478c: f2400d6b     	ands	x11, x11, #0xf
40004790: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004794: 1a9f1529     	csinc	w9, w9, wzr, ne
40004798: 34ffff49     	cbz	w9, 0x40004780 <uart_printf+0x5f4>
4000479c: b94b7acc     	ldr	w12, [x22, #0xb78]
400047a0: 386b6a2b     	ldrb	w11, [x17, x11]
400047a4: 3400012c     	cbz	w12, 0x400047c8 <uart_printf+0x63c>
400047a8: b94b7eec     	ldr	w12, [x23, #0xb7c]
400047ac: 6b19019f     	cmp	w12, w25
400047b0: 540000cc     	b.gt	0x400047c8 <uart_printf+0x63c>
400047b4: 93407d8c     	sxtw	x12, w12
400047b8: 9100058d     	add	x13, x12, #0x1
400047bc: 382c6b0b     	strb	w11, [x24, x12]
400047c0: b90b7eed     	str	w13, [x23, #0xb7c]
400047c4: 382d6b1f     	strb	wzr, [x24, x13]
400047c8: b94002ac     	ldr	w12, [x21]
400047cc: 372fffec     	tbnz	w12, #0x5, 0x400047c8 <uart_printf+0x63c>
400047d0: b900036b     	str	w11, [x27]
400047d4: b5fffd8a     	cbnz	x10, 0x40004784 <uart_printf+0x5f8>
400047d8: 17fffe9b     	b	0x40004244 <uart_printf+0xb8>
400047dc: f85c03a8     	ldur	x8, [x29, #-0x40]
400047e0: 91002109     	add	x9, x8, #0x8
400047e4: f81c03a9     	stur	x9, [x29, #-0x40]
400047e8: f9400109     	ldr	x9, [x8]
400047ec: b6f80649     	tbz	x9, #0x3f, 0x400048b4 <uart_printf+0x728>
400047f0: b94b7ac8     	ldr	w8, [x22, #0xb78]
400047f4: 34000128     	cbz	w8, 0x40004818 <uart_printf+0x68c>
400047f8: b94b7ee8     	ldr	w8, [x23, #0xb7c]
400047fc: 6b19011f     	cmp	w8, w25
40004800: 540000cc     	b.gt	0x40004818 <uart_printf+0x68c>
40004804: 93407d08     	sxtw	x8, w8
40004808: 1100050a     	add	w10, w8, #0x1
4000480c: b90b7eea     	str	w10, [x23, #0xb7c]
40004810: 528005aa     	mov	w10, #0x2d              // =45
40004814: 78286b0a     	strh	w10, [x24, x8]
40004818: b94002a8     	ldr	w8, [x21]
4000481c: 372fffe8     	tbnz	w8, #0x5, 0x40004818 <uart_printf+0x68c>
40004820: aa1f03e8     	mov	x8, xzr
40004824: 528005aa     	mov	w10, #0x2d              // =45
40004828: cb0903e9     	neg	x9, x9
4000482c: b900036a     	str	w10, [x27]
40004830: 9bcf7d2a     	umulh	x10, x9, x15
40004834: f100253f     	cmp	x9, #0x9
40004838: d343fd4a     	lsr	x10, x10, #3
4000483c: 1b10a54b     	msub	w11, w10, w16, w9
40004840: 321c0569     	orr	w9, w11, #0x30
40004844: 38286b89     	strb	w9, [x28, x8]
40004848: 91000508     	add	x8, x8, #0x1
4000484c: aa0a03e9     	mov	x9, x10
40004850: 54ffff08     	b.hi	0x40004830 <uart_printf+0x6a4>
40004854: d1000509     	sub	x9, x8, #0x1
40004858: b94b7acb     	ldr	w11, [x22, #0xb78]
4000485c: 38696b8a     	ldrb	w10, [x28, x9]
40004860: 3400012b     	cbz	w11, 0x40004884 <uart_printf+0x6f8>
40004864: b94b7eeb     	ldr	w11, [x23, #0xb7c]
40004868: 6b19017f     	cmp	w11, w25
4000486c: 540000cc     	b.gt	0x40004884 <uart_printf+0x6f8>
40004870: 93407d6b     	sxtw	x11, w11
40004874: 9100056c     	add	x12, x11, #0x1
40004878: 382b6b0a     	strb	w10, [x24, x11]
4000487c: b90b7eec     	str	w12, [x23, #0xb7c]
40004880: 382c6b1f     	strb	wzr, [x24, x12]
40004884: b94002ab     	ldr	w11, [x21]
40004888: 372fffeb     	tbnz	w11, #0x5, 0x40004884 <uart_printf+0x6f8>
4000488c: 7100051f     	cmp	w8, #0x1
40004890: aa0903e8     	mov	x8, x9
40004894: b900036a     	str	w10, [x27]
40004898: 54fffdec     	b.gt	0x40004854 <uart_printf+0x6c8>
4000489c: 17fffe6a     	b	0x40004244 <uart_printf+0xb8>
400048a0: f85c03a8     	ldur	x8, [x29, #-0x40]
400048a4: 91002109     	add	x9, x8, #0x8
400048a8: f81c03a9     	stur	x9, [x29, #-0x40]
400048ac: b9800109     	ldrsw	x9, [x8]
400048b0: b7fffa09     	tbnz	x9, #0x3f, 0x400047f0 <uart_printf+0x664>
400048b4: b4000589     	cbz	x9, 0x40004964 <uart_printf+0x7d8>
400048b8: aa1f03ea     	mov	x10, xzr
400048bc: 9bcf7d28     	umulh	x8, x9, x15
400048c0: f100253f     	cmp	x9, #0x9
400048c4: d343fd0b     	lsr	x11, x8, #3
400048c8: 91000548     	add	x8, x10, #0x1
400048cc: 1b10a56c     	msub	w12, w11, w16, w9
400048d0: 321c0589     	orr	w9, w12, #0x30
400048d4: 382a6b89     	strb	w9, [x28, x10]
400048d8: aa0803ea     	mov	x10, x8
400048dc: aa0b03e9     	mov	x9, x11
400048e0: 54fffee8     	b.hi	0x400048bc <uart_printf+0x730>
400048e4: d1000509     	sub	x9, x8, #0x1
400048e8: b94b7acb     	ldr	w11, [x22, #0xb78]
400048ec: 38696b8a     	ldrb	w10, [x28, x9]
400048f0: 3400012b     	cbz	w11, 0x40004914 <uart_printf+0x788>
400048f4: b94b7eeb     	ldr	w11, [x23, #0xb7c]
400048f8: 6b19017f     	cmp	w11, w25
400048fc: 540000cc     	b.gt	0x40004914 <uart_printf+0x788>
40004900: 93407d6b     	sxtw	x11, w11
40004904: 9100056c     	add	x12, x11, #0x1
40004908: 382b6b0a     	strb	w10, [x24, x11]
4000490c: b90b7eec     	str	w12, [x23, #0xb7c]
40004910: 382c6b1f     	strb	wzr, [x24, x12]
40004914: b94002ab     	ldr	w11, [x21]
40004918: 372fffeb     	tbnz	w11, #0x5, 0x40004914 <uart_printf+0x788>
4000491c: 7100051f     	cmp	w8, #0x1
40004920: aa0903e8     	mov	x8, x9
40004924: b900036a     	str	w10, [x27]
40004928: 54fffdec     	b.gt	0x400048e4 <uart_printf+0x758>
4000492c: 17fffe46     	b	0x40004244 <uart_printf+0xb8>
40004930: b94b7ac8     	ldr	w8, [x22, #0xb78]
40004934: 34000128     	cbz	w8, 0x40004958 <uart_printf+0x7cc>
40004938: b94b7ee8     	ldr	w8, [x23, #0xb7c]
4000493c: 6b19011f     	cmp	w8, w25
40004940: 540000cc     	b.gt	0x40004958 <uart_printf+0x7cc>
40004944: 93407d08     	sxtw	x8, w8
40004948: 11000509     	add	w9, w8, #0x1
4000494c: b90b7ee9     	str	w9, [x23, #0xb7c]
40004950: 52800609     	mov	w9, #0x30               // =48
40004954: 78286b09     	strh	w9, [x24, x8]
40004958: b94002a8     	ldr	w8, [x21]
4000495c: 372fffe8     	tbnz	w8, #0x5, 0x40004958 <uart_printf+0x7cc>
40004960: 17fffe37     	b	0x4000423c <uart_printf+0xb0>
40004964: b94b7ac8     	ldr	w8, [x22, #0xb78]
40004968: 34000128     	cbz	w8, 0x4000498c <uart_printf+0x800>
4000496c: b94b7ee8     	ldr	w8, [x23, #0xb7c]
40004970: 6b19011f     	cmp	w8, w25
40004974: 540000cc     	b.gt	0x4000498c <uart_printf+0x800>
40004978: 93407d08     	sxtw	x8, w8
4000497c: 11000509     	add	w9, w8, #0x1
40004980: b90b7ee9     	str	w9, [x23, #0xb7c]
40004984: 52800609     	mov	w9, #0x30               // =48
40004988: 78286b09     	strh	w9, [x24, x8]
4000498c: b94002a8     	ldr	w8, [x21]
40004990: 372fffe8     	tbnz	w8, #0x5, 0x4000498c <uart_printf+0x800>
40004994: 17fffe2a     	b	0x4000423c <uart_printf+0xb0>
40004998: a9554ff4     	ldp	x20, x19, [sp, #0x150]
4000499c: a95457f6     	ldp	x22, x21, [sp, #0x140]
400049a0: a9535ff8     	ldp	x24, x23, [sp, #0x130]
400049a4: a95267fa     	ldp	x26, x25, [sp, #0x120]
400049a8: a9516ffc     	ldp	x28, x27, [sp, #0x110]
400049ac: a9507bfd     	ldp	x29, x30, [sp, #0x100]
400049b0: 910583ff     	add	sp, sp, #0x160
400049b4: d65f03c0     	ret

00000000400049b8 <vfs_init>:
400049b8: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
400049bc: a9044ff4     	stp	x20, x19, [sp, #0x40]
400049c0: f0000073     	adrp	x19, 0x40013000 <kernel_capture_buffer+0x3480>
400049c4: 912e6273     	add	x19, x19, #0xb98
400049c8: f9000bf9     	str	x25, [sp, #0x10]
400049cc: f0000079     	adrp	x25, 0x40013000 <kernel_capture_buffer+0x3480>
400049d0: 52800034     	mov	w20, #0x1               // =1
400049d4: aa1303e0     	mov	x0, x19
400049d8: 2a1f03e1     	mov	w1, wzr
400049dc: 52809802     	mov	w2, #0x4c0              // =1216
400049e0: a9025ff8     	stp	x24, x23, [sp, #0x20]
400049e4: 910003fd     	mov	x29, sp
400049e8: a90357f6     	stp	x22, x21, [sp, #0x30]
400049ec: b90b8334     	str	w20, [x25, #0xb80]
400049f0: 97fff96c     	bl	0x40002fa0 <kmemset>
400049f4: 528005e8     	mov	w8, #0x2f               // =47
400049f8: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
400049fc: b9002274     	str	w20, [x19, #0x20]
40004a00: 79000268     	strh	w8, [x19]
40004a04: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004a08: f905c533     	str	x19, [x9, #0xb88]
40004a0c: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
40004a10: 7101fd1f     	cmp	w8, #0x7f
40004a14: f9021a7f     	str	xzr, [x19, #0x430]
40004a18: f900167f     	str	xzr, [x19, #0x28]
40004a1c: b904ba7f     	str	wzr, [x19, #0x4b8]
40004a20: f905c933     	str	x19, [x9, #0xb90]
40004a24: 540027ac     	b.gt	0x40004f18 <vfs_init+0x560>
40004a28: 52809809     	mov	w9, #0x4c0              // =1216
40004a2c: 2a1f03e1     	mov	w1, wzr
40004a30: 52809802     	mov	w2, #0x4c0              // =1216
40004a34: 9b294d17     	smaddl	x23, w8, w9, x19
40004a38: 11000508     	add	w8, w8, #0x1
40004a3c: b90b8328     	str	w8, [x25, #0xb80]
40004a40: aa1703e0     	mov	x0, x23
40004a44: 97fff957     	bl	0x40002fa0 <kmemset>
40004a48: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004a4c: b904baff     	str	wzr, [x23, #0x4b8]
40004a50: fd426d00     	ldr	d0, [x8, #0x4d8]
40004a54: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004a58: b90022f4     	str	w20, [x23, #0x20]
40004a5c: f9021af3     	str	x19, [x23, #0x430]
40004a60: 71003d1f     	cmp	w8, #0xf
40004a64: bd0002e0     	str	s0, [x23]
40004a68: f90016ff     	str	xzr, [x23, #0x28]
40004a6c: 540000ac     	b.gt	0x40004a80 <vfs_init+0xc8>
40004a70: 11000509     	add	w9, w8, #0x1
40004a74: 8b080e68     	add	x8, x19, x8, lsl #3
40004a78: b904ba69     	str	w9, [x19, #0x4b8]
40004a7c: f9021d17     	str	x23, [x8, #0x438]
40004a80: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004a84: 7101fd1f     	cmp	w8, #0x7f
40004a88: 5400248c     	b.gt	0x40004f18 <vfs_init+0x560>
40004a8c: 52809809     	mov	w9, #0x4c0              // =1216
40004a90: 2a1f03e1     	mov	w1, wzr
40004a94: 52809802     	mov	w2, #0x4c0              // =1216
40004a98: 9b294d16     	smaddl	x22, w8, w9, x19
40004a9c: 11000508     	add	w8, w8, #0x1
40004aa0: b90b8328     	str	w8, [x25, #0xb80]
40004aa4: aa1603e0     	mov	x0, x22
40004aa8: 97fff93e     	bl	0x40002fa0 <kmemset>
40004aac: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004ab0: b904badf     	str	wzr, [x22, #0x4b8]
40004ab4: 52800029     	mov	w9, #0x1                // =1
40004ab8: fd427900     	ldr	d0, [x8, #0x4f0]
40004abc: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004ac0: b90022c9     	str	w9, [x22, #0x20]
40004ac4: f9021ad3     	str	x19, [x22, #0x430]
40004ac8: 71003d1f     	cmp	w8, #0xf
40004acc: bd0002c0     	str	s0, [x22]
40004ad0: f90016df     	str	xzr, [x22, #0x28]
40004ad4: 540000ac     	b.gt	0x40004ae8 <vfs_init+0x130>
40004ad8: 11000509     	add	w9, w8, #0x1
40004adc: 8b080e68     	add	x8, x19, x8, lsl #3
40004ae0: b904ba69     	str	w9, [x19, #0x4b8]
40004ae4: f9021d16     	str	x22, [x8, #0x438]
40004ae8: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004aec: 7101fd1f     	cmp	w8, #0x7f
40004af0: 5400214c     	b.gt	0x40004f18 <vfs_init+0x560>
40004af4: 52809809     	mov	w9, #0x4c0              // =1216
40004af8: 2a1f03e1     	mov	w1, wzr
40004afc: 52809802     	mov	w2, #0x4c0              // =1216
40004b00: 9b294d14     	smaddl	x20, w8, w9, x19
40004b04: 11000508     	add	w8, w8, #0x1
40004b08: b90b8328     	str	w8, [x25, #0xb80]
40004b0c: aa1403e0     	mov	x0, x20
40004b10: 97fff924     	bl	0x40002fa0 <kmemset>
40004b14: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004b18: b904ba9f     	str	wzr, [x20, #0x4b8]
40004b1c: 52800029     	mov	w9, #0x1                // =1
40004b20: fd427100     	ldr	d0, [x8, #0x4e0]
40004b24: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004b28: 3900129f     	strb	wzr, [x20, #0x4]
40004b2c: b9002289     	str	w9, [x20, #0x20]
40004b30: 71003d1f     	cmp	w8, #0xf
40004b34: bd000280     	str	s0, [x20]
40004b38: f9021a93     	str	x19, [x20, #0x430]
40004b3c: f900169f     	str	xzr, [x20, #0x28]
40004b40: 540000ac     	b.gt	0x40004b54 <vfs_init+0x19c>
40004b44: 11000509     	add	w9, w8, #0x1
40004b48: 8b080e68     	add	x8, x19, x8, lsl #3
40004b4c: b904ba69     	str	w9, [x19, #0x4b8]
40004b50: f9021d14     	str	x20, [x8, #0x438]
40004b54: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004b58: 7101fd1f     	cmp	w8, #0x7f
40004b5c: 54001dec     	b.gt	0x40004f18 <vfs_init+0x560>
40004b60: 52809809     	mov	w9, #0x4c0              // =1216
40004b64: 2a1f03e1     	mov	w1, wzr
40004b68: 52809802     	mov	w2, #0x4c0              // =1216
40004b6c: 9b294d15     	smaddl	x21, w8, w9, x19
40004b70: 11000508     	add	w8, w8, #0x1
40004b74: b90b8328     	str	w8, [x25, #0xb80]
40004b78: aa1503e0     	mov	x0, x21
40004b7c: 97fff909     	bl	0x40002fa0 <kmemset>
40004b80: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004b84: b904babf     	str	wzr, [x21, #0x4b8]
40004b88: 52800029     	mov	w9, #0x1                // =1
40004b8c: fd426900     	ldr	d0, [x8, #0x4d0]
40004b90: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004b94: 390012bf     	strb	wzr, [x21, #0x4]
40004b98: b90022a9     	str	w9, [x21, #0x20]
40004b9c: 71003d1f     	cmp	w8, #0xf
40004ba0: bd0002a0     	str	s0, [x21]
40004ba4: f9021ab3     	str	x19, [x21, #0x430]
40004ba8: f90016bf     	str	xzr, [x21, #0x28]
40004bac: 540000ac     	b.gt	0x40004bc0 <vfs_init+0x208>
40004bb0: 11000509     	add	w9, w8, #0x1
40004bb4: 8b080e68     	add	x8, x19, x8, lsl #3
40004bb8: b904ba69     	str	w9, [x19, #0x4b8]
40004bbc: f9021d15     	str	x21, [x8, #0x438]
40004bc0: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004bc4: 7101fd1f     	cmp	w8, #0x7f
40004bc8: 54001a8c     	b.gt	0x40004f18 <vfs_init+0x560>
40004bcc: 52809809     	mov	w9, #0x4c0              // =1216
40004bd0: 2a1f03e1     	mov	w1, wzr
40004bd4: 52809802     	mov	w2, #0x4c0              // =1216
40004bd8: 9b294d18     	smaddl	x24, w8, w9, x19
40004bdc: 11000508     	add	w8, w8, #0x1
40004be0: b90b8328     	str	w8, [x25, #0xb80]
40004be4: aa1803e0     	mov	x0, x24
40004be8: 97fff8ee     	bl	0x40002fa0 <kmemset>
40004bec: 528d2c28     	mov	w8, #0x6961             // =26977
40004bf0: b904bb1f     	str	wzr, [x24, #0x4b8]
40004bf4: 79000308     	strh	w8, [x24]
40004bf8: b984bae8     	ldrsw	x8, [x23, #0x4b8]
40004bfc: 39000b1f     	strb	wzr, [x24, #0x2]
40004c00: 71003d1f     	cmp	w8, #0xf
40004c04: b900231f     	str	wzr, [x24, #0x20]
40004c08: f9021b17     	str	x23, [x24, #0x430]
40004c0c: f900171f     	str	xzr, [x24, #0x28]
40004c10: 540000ac     	b.gt	0x40004c24 <vfs_init+0x26c>
40004c14: 8b080ee9     	add	x9, x23, x8, lsl #3
40004c18: 11000508     	add	w8, w8, #0x1
40004c1c: b904bae8     	str	w8, [x23, #0x4b8]
40004c20: f9021d38     	str	x24, [x9, #0x438]
40004c24: d503201f     	nop
40004c28: 100232b7     	adr	x23, 0x4000927c <__rodata_start+0x327c>
40004c2c: 9100c300     	add	x0, x24, #0x30
40004c30: aa1703e1     	mov	x1, x23
40004c34: 97fff8a0     	bl	0x40002eb4 <kstrcpy>
40004c38: aa1703e0     	mov	x0, x23
40004c3c: 97fff86f     	bl	0x40002df8 <kstrlen>
40004c40: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004c44: f9001700     	str	x0, [x24, #0x28]
40004c48: 7101fd1f     	cmp	w8, #0x7f
40004c4c: 5400166c     	b.gt	0x40004f18 <vfs_init+0x560>
40004c50: 52809809     	mov	w9, #0x4c0              // =1216
40004c54: 2a1f03e1     	mov	w1, wzr
40004c58: 52809802     	mov	w2, #0x4c0              // =1216
40004c5c: 9b294d17     	smaddl	x23, w8, w9, x19
40004c60: 11000508     	add	w8, w8, #0x1
40004c64: b90b8328     	str	w8, [x25, #0xb80]
40004c68: aa1703e0     	mov	x0, x23
40004c6c: 97fff8cd     	bl	0x40002fa0 <kmemset>
40004c70: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004c74: b904baff     	str	wzr, [x23, #0x4b8]
40004c78: 528cae69     	mov	w9, #0x6573             // =25971
40004c7c: fd424500     	ldr	d0, [x8, #0x488]
40004c80: b984bac8     	ldrsw	x8, [x22, #0x4b8]
40004c84: 39002aff     	strb	wzr, [x23, #0xa]
40004c88: 790012e9     	strh	w9, [x23, #0x8]
40004c8c: 71003d1f     	cmp	w8, #0xf
40004c90: fd0002e0     	str	d0, [x23]
40004c94: b90022ff     	str	wzr, [x23, #0x20]
40004c98: f9021af6     	str	x22, [x23, #0x430]
40004c9c: f90016ff     	str	xzr, [x23, #0x28]
40004ca0: 540000ac     	b.gt	0x40004cb4 <vfs_init+0x2fc>
40004ca4: 8b080ec9     	add	x9, x22, x8, lsl #3
40004ca8: 11000508     	add	w8, w8, #0x1
40004cac: b904bac8     	str	w8, [x22, #0x4b8]
40004cb0: f9021d37     	str	x23, [x9, #0x438]
40004cb4: f0000016     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
40004cb8: 91149ed6     	add	x22, x22, #0x527
40004cbc: 9100c2e0     	add	x0, x23, #0x30
40004cc0: aa1603e1     	mov	x1, x22
40004cc4: 97fff87c     	bl	0x40002eb4 <kstrcpy>
40004cc8: aa1603e0     	mov	x0, x22
40004ccc: 97fff84b     	bl	0x40002df8 <kstrlen>
40004cd0: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004cd4: f90016e0     	str	x0, [x23, #0x28]
40004cd8: 7101fd1f     	cmp	w8, #0x7f
40004cdc: 540011ec     	b.gt	0x40004f18 <vfs_init+0x560>
40004ce0: 52809809     	mov	w9, #0x4c0              // =1216
40004ce4: 2a1f03e1     	mov	w1, wzr
40004ce8: 52809802     	mov	w2, #0x4c0              // =1216
40004cec: 9b294d16     	smaddl	x22, w8, w9, x19
40004cf0: 11000508     	add	w8, w8, #0x1
40004cf4: b90b8328     	str	w8, [x25, #0xb80]
40004cf8: aa1603e0     	mov	x0, x22
40004cfc: 97fff8a9     	bl	0x40002fa0 <kmemset>
40004d00: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004d04: b904badf     	str	wzr, [x22, #0x4b8]
40004d08: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x3000>
40004d0c: fd426100     	ldr	d0, [x8, #0x4c0]
40004d10: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004d14: fd425921     	ldr	d1, [x9, #0x4b0]
40004d18: b90022df     	str	wzr, [x22, #0x20]
40004d1c: 71003d1f     	cmp	w8, #0xf
40004d20: fd0002c0     	str	d0, [x22]
40004d24: bd000ac1     	str	s1, [x22, #0x8]
40004d28: f9021ad5     	str	x21, [x22, #0x430]
40004d2c: f90016df     	str	xzr, [x22, #0x28]
40004d30: 540000ac     	b.gt	0x40004d44 <vfs_init+0x38c>
40004d34: 8b080ea9     	add	x9, x21, x8, lsl #3
40004d38: 11000508     	add	w8, w8, #0x1
40004d3c: b904baa8     	str	w8, [x21, #0x4b8]
40004d40: f9021d36     	str	x22, [x9, #0x438]
40004d44: f0000017     	adrp	x23, 0x40007000 <__rodata_start+0x1000>
40004d48: 911b1af7     	add	x23, x23, #0x6c6
40004d4c: 9100c2c0     	add	x0, x22, #0x30
40004d50: aa1703e1     	mov	x1, x23
40004d54: 97fff858     	bl	0x40002eb4 <kstrcpy>
40004d58: aa1703e0     	mov	x0, x23
40004d5c: 97fff827     	bl	0x40002df8 <kstrlen>
40004d60: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004d64: f90016c0     	str	x0, [x22, #0x28]
40004d68: 7101fd1f     	cmp	w8, #0x7f
40004d6c: 54000d6c     	b.gt	0x40004f18 <vfs_init+0x560>
40004d70: 52809809     	mov	w9, #0x4c0              // =1216
40004d74: 2a1f03e1     	mov	w1, wzr
40004d78: 52809802     	mov	w2, #0x4c0              // =1216
40004d7c: 9b294d16     	smaddl	x22, w8, w9, x19
40004d80: 11000508     	add	w8, w8, #0x1
40004d84: b90b8328     	str	w8, [x25, #0xb80]
40004d88: aa1603e0     	mov	x0, x22
40004d8c: 97fff885     	bl	0x40002fa0 <kmemset>
40004d90: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004d94: b904badf     	str	wzr, [x22, #0x4b8]
40004d98: b0000029     	adrp	x9, 0x40009000 <__rodata_start+0x3000>
40004d9c: fd424900     	ldr	d0, [x8, #0x490]
40004da0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004da4: fd424d21     	ldr	d1, [x9, #0x498]
40004da8: 390032df     	strb	wzr, [x22, #0xc]
40004dac: 71003d1f     	cmp	w8, #0xf
40004db0: fd0002c0     	str	d0, [x22]
40004db4: bd000ac1     	str	s1, [x22, #0x8]
40004db8: b90022df     	str	wzr, [x22, #0x20]
40004dbc: f9021ad5     	str	x21, [x22, #0x430]
40004dc0: f90016df     	str	xzr, [x22, #0x28]
40004dc4: 540000ac     	b.gt	0x40004dd8 <vfs_init+0x420>
40004dc8: 8b080ea9     	add	x9, x21, x8, lsl #3
40004dcc: 11000508     	add	w8, w8, #0x1
40004dd0: b904baa8     	str	w8, [x21, #0x4b8]
40004dd4: f9021d36     	str	x22, [x9, #0x438]
40004dd8: f0000017     	adrp	x23, 0x40007000 <__rodata_start+0x1000>
40004ddc: 912a26f7     	add	x23, x23, #0xa89
40004de0: 9100c2c0     	add	x0, x22, #0x30
40004de4: aa1703e1     	mov	x1, x23
40004de8: 97fff833     	bl	0x40002eb4 <kstrcpy>
40004dec: aa1703e0     	mov	x0, x23
40004df0: 97fff802     	bl	0x40002df8 <kstrlen>
40004df4: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004df8: f90016c0     	str	x0, [x22, #0x28]
40004dfc: 7101fd1f     	cmp	w8, #0x7f
40004e00: 540008cc     	b.gt	0x40004f18 <vfs_init+0x560>
40004e04: 52809809     	mov	w9, #0x4c0              // =1216
40004e08: 2a1f03e1     	mov	w1, wzr
40004e0c: 52809802     	mov	w2, #0x4c0              // =1216
40004e10: 9b294d16     	smaddl	x22, w8, w9, x19
40004e14: 11000508     	add	w8, w8, #0x1
40004e18: b90b8328     	str	w8, [x25, #0xb80]
40004e1c: aa1603e0     	mov	x0, x22
40004e20: 97fff860     	bl	0x40002fa0 <kmemset>
40004e24: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004e28: b904badf     	str	wzr, [x22, #0x4b8]
40004e2c: 528e8f09     	mov	w9, #0x7478             // =29816
40004e30: fd425500     	ldr	d0, [x8, #0x4a8]
40004e34: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004e38: 39001adf     	strb	wzr, [x22, #0x6]
40004e3c: 79000ac9     	strh	w9, [x22, #0x4]
40004e40: 71003d1f     	cmp	w8, #0xf
40004e44: bd0002c0     	str	s0, [x22]
40004e48: b90022df     	str	wzr, [x22, #0x20]
40004e4c: f9021ad5     	str	x21, [x22, #0x430]
40004e50: f90016df     	str	xzr, [x22, #0x28]
40004e54: 540000ac     	b.gt	0x40004e68 <vfs_init+0x4b0>
40004e58: 8b080ea9     	add	x9, x21, x8, lsl #3
40004e5c: 11000508     	add	w8, w8, #0x1
40004e60: b904baa8     	str	w8, [x21, #0x4b8]
40004e64: f9021d36     	str	x22, [x9, #0x438]
40004e68: b0000035     	adrp	x21, 0x40009000 <__rodata_start+0x3000>
40004e6c: 91007eb5     	add	x21, x21, #0x1f
40004e70: 9100c2c0     	add	x0, x22, #0x30
40004e74: aa1503e1     	mov	x1, x21
40004e78: 97fff80f     	bl	0x40002eb4 <kstrcpy>
40004e7c: aa1503e0     	mov	x0, x21
40004e80: 97fff7de     	bl	0x40002df8 <kstrlen>
40004e84: b98b8328     	ldrsw	x8, [x25, #0xb80]
40004e88: f90016c0     	str	x0, [x22, #0x28]
40004e8c: 7101fd1f     	cmp	w8, #0x7f
40004e90: 5400044c     	b.gt	0x40004f18 <vfs_init+0x560>
40004e94: 52809809     	mov	w9, #0x4c0              // =1216
40004e98: 2a1f03e1     	mov	w1, wzr
40004e9c: 52809802     	mov	w2, #0x4c0              // =1216
40004ea0: 9b294d13     	smaddl	x19, w8, w9, x19
40004ea4: 11000508     	add	w8, w8, #0x1
40004ea8: b90b8328     	str	w8, [x25, #0xb80]
40004eac: aa1303e0     	mov	x0, x19
40004eb0: 97fff83c     	bl	0x40002fa0 <kmemset>
40004eb4: b0000028     	adrp	x8, 0x40009000 <__rodata_start+0x3000>
40004eb8: b904ba7f     	str	wzr, [x19, #0x4b8]
40004ebc: 528e8f09     	mov	w9, #0x7478             // =29816
40004ec0: fd425d00     	ldr	d0, [x8, #0x4b8]
40004ec4: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004ec8: 39002a7f     	strb	wzr, [x19, #0xa]
40004ecc: 79001269     	strh	w9, [x19, #0x8]
40004ed0: 71003d1f     	cmp	w8, #0xf
40004ed4: fd000260     	str	d0, [x19]
40004ed8: b900227f     	str	wzr, [x19, #0x20]
40004edc: f9021a74     	str	x20, [x19, #0x430]
40004ee0: f900167f     	str	xzr, [x19, #0x28]
40004ee4: 540000ac     	b.gt	0x40004ef8 <vfs_init+0x540>
40004ee8: 8b080e89     	add	x9, x20, x8, lsl #3
40004eec: 11000508     	add	w8, w8, #0x1
40004ef0: b904ba88     	str	w8, [x20, #0x4b8]
40004ef4: f9021d33     	str	x19, [x9, #0x438]
40004ef8: d0000014     	adrp	x20, 0x40006000 <__rodata_start>
40004efc: 9110c694     	add	x20, x20, #0x431
40004f00: 9100c260     	add	x0, x19, #0x30
40004f04: aa1403e1     	mov	x1, x20
40004f08: 97fff7eb     	bl	0x40002eb4 <kstrcpy>
40004f0c: aa1403e0     	mov	x0, x20
40004f10: 97fff7ba     	bl	0x40002df8 <kstrlen>
40004f14: f9001660     	str	x0, [x19, #0x28]
40004f18: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004f1c: f9400bf9     	ldr	x25, [sp, #0x10]
40004f20: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004f24: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004f28: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004f2c: d65f03c0     	ret

0000000040004f30 <vfs_load_internal>:
40004f30: 2a1f03e0     	mov	w0, wzr
40004f34: d65f03c0     	ret

0000000040004f38 <vfs_get_root>:
40004f38: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
40004f3c: f945c500     	ldr	x0, [x8, #0xb88]
40004f40: d65f03c0     	ret

0000000040004f44 <vfs_get_cwd>:
40004f44: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
40004f48: f945c900     	ldr	x0, [x8, #0xb90]
40004f4c: d65f03c0     	ret

0000000040004f50 <vfs_getcwd>:
40004f50: d10383ff     	sub	sp, sp, #0xe0
40004f54: f0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
40004f58: a90d4ff4     	stp	x20, x19, [sp, #0xd0]
40004f5c: aa0003f3     	mov	x19, x0
40004f60: f945c908     	ldr	x8, [x8, #0xb90]
40004f64: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004f68: 910203fd     	add	x29, sp, #0x80
40004f6c: a9096ffc     	stp	x28, x27, [sp, #0x90]
40004f70: a90a67fa     	stp	x26, x25, [sp, #0xa0]
40004f74: a90b5ff8     	stp	x24, x23, [sp, #0xb0]
40004f78: a90c57f6     	stp	x22, x21, [sp, #0xc0]
40004f7c: b4000228     	cbz	x8, 0x40004fc0 <vfs_getcwd+0x70>
40004f80: f0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
40004f84: f945c529     	ldr	x9, [x9, #0xb88]
40004f88: eb09011f     	cmp	x8, x9
40004f8c: 540001a0     	b.eq	0x40004fc0 <vfs_getcwd+0x70>
40004f90: aa1f03ea     	mov	x10, xzr
40004f94: 910003eb     	mov	x11, sp
40004f98: eb09011f     	cmp	x8, x9
40004f9c: 540001c0     	b.eq	0x40004fd4 <vfs_getcwd+0x84>
40004fa0: f1003d5f     	cmp	x10, #0xf
40004fa4: 54000188     	b.hi	0x40004fd4 <vfs_getcwd+0x84>
40004fa8: f82a7968     	str	x8, [x11, x10, lsl #3]
40004fac: f9421908     	ldr	x8, [x8, #0x430]
40004fb0: 9100054c     	add	x12, x10, #0x1
40004fb4: aa0c03ea     	mov	x10, x12
40004fb8: b5ffff08     	cbnz	x8, 0x40004f98 <vfs_getcwd+0x48>
40004fbc: 14000007     	b	0x40004fd8 <vfs_getcwd+0x88>
40004fc0: f100083f     	cmp	x1, #0x2
40004fc4: 540008c3     	b.lo	0x400050dc <vfs_getcwd+0x18c>
40004fc8: 528005e8     	mov	w8, #0x2f               // =47
40004fcc: 79000268     	strh	w8, [x19]
40004fd0: 14000043     	b	0x400050dc <vfs_getcwd+0x18c>
40004fd4: aa0a03ec     	mov	x12, x10
40004fd8: 7100059f     	cmp	w12, #0x1
40004fdc: 3900027f     	strb	wzr, [x19]
40004fe0: 540007eb     	b.lt	0x400050dc <vfs_getcwd+0x18c>
40004fe4: aa1f03fc     	mov	x28, xzr
40004fe8: d1000435     	sub	x21, x1, #0x1
40004fec: 9240799a     	and	x26, x12, #0x7fffffff
40004ff0: d1000836     	sub	x22, x1, #0x2
40004ff4: 91004277     	add	x23, x19, #0x10
40004ff8: 528005f8     	mov	w24, #0x2f              // =47
40004ffc: 910003f9     	mov	x25, sp
40005000: 14000006     	b	0x40005018 <vfs_getcwd+0xc8>
40005004: aa1c03e8     	mov	x8, x28
40005008: f100077f     	cmp	x27, #0x1
4000500c: aa0803fc     	mov	x28, x8
40005010: 38286a7f     	strb	wzr, [x19, x8]
40005014: 54000649     	b.ls	0x400050dc <vfs_getcwd+0x18c>
40005018: eb15039f     	cmp	x28, x21
4000501c: aa1a03fb     	mov	x27, x26
40005020: 54000082     	b.hs	0x40005030 <vfs_getcwd+0xe0>
40005024: 91000788     	add	x8, x28, #0x1
40005028: 783c6a78     	strh	w24, [x19, x28]
4000502c: aa0803fc     	mov	x28, x8
40005030: d100077a     	sub	x26, x27, #0x1
40005034: f87a7b34     	ldr	x20, [x25, x26, lsl #3]
40005038: aa1403e0     	mov	x0, x20
4000503c: 97fff76f     	bl	0x40002df8 <kstrlen>
40005040: b4fffe20     	cbz	x0, 0x40005004 <vfs_getcwd+0xb4>
40005044: eb15039f     	cmp	x28, x21
40005048: 54fffde2     	b.hs	0x40005004 <vfs_getcwd+0xb4>
4000504c: cb1c02c8     	sub	x8, x22, x28
40005050: d1000409     	sub	x9, x0, #0x1
40005054: eb09011f     	cmp	x8, x9
40005058: 9a893108     	csel	x8, x8, x9, lo
4000505c: 9100050a     	add	x10, x8, #0x1
40005060: f100815f     	cmp	x10, #0x20
40005064: 540000a3     	b.lo	0x40005078 <vfs_getcwd+0x128>
40005068: 8b130388     	add	x8, x28, x19
4000506c: cb140108     	sub	x8, x8, x20
40005070: f100811f     	cmp	x8, #0x20
40005074: 54000182     	b.hs	0x400050a4 <vfs_getcwd+0x154>
40005078: aa1f03e9     	mov	x9, xzr
4000507c: aa1c03e8     	mov	x8, x28
40005080: 38696a8a     	ldrb	w10, [x20, x9]
40005084: 91000529     	add	x9, x9, #0x1
40005088: eb00013f     	cmp	x9, x0
4000508c: 38286a6a     	strb	w10, [x19, x8]
40005090: 91000508     	add	x8, x8, #0x1
40005094: 54fffba2     	b.hs	0x40005008 <vfs_getcwd+0xb8>
40005098: eb15011f     	cmp	x8, x21
4000509c: 54ffff23     	b.lo	0x40005080 <vfs_getcwd+0x130>
400050a0: 17ffffda     	b	0x40005008 <vfs_getcwd+0xb8>
400050a4: 927be949     	and	x9, x10, #0xffffffffffffffe0
400050a8: 8b1c02eb     	add	x11, x23, x28
400050ac: 9100428c     	add	x12, x20, #0x10
400050b0: 8b090388     	add	x8, x28, x9
400050b4: aa0903ed     	mov	x13, x9
400050b8: ad7f8580     	ldp	q0, q1, [x12, #-0x10]
400050bc: f10081ad     	subs	x13, x13, #0x20
400050c0: 9100818c     	add	x12, x12, #0x20
400050c4: ad3f8560     	stp	q0, q1, [x11, #-0x10]
400050c8: 9100816b     	add	x11, x11, #0x20
400050cc: 54ffff61     	b.ne	0x400050b8 <vfs_getcwd+0x168>
400050d0: eb09015f     	cmp	x10, x9
400050d4: 54fffd61     	b.ne	0x40005080 <vfs_getcwd+0x130>
400050d8: 17ffffcc     	b	0x40005008 <vfs_getcwd+0xb8>
400050dc: a94d4ff4     	ldp	x20, x19, [sp, #0xd0]
400050e0: a94c57f6     	ldp	x22, x21, [sp, #0xc0]
400050e4: a94b5ff8     	ldp	x24, x23, [sp, #0xb0]
400050e8: a94a67fa     	ldp	x26, x25, [sp, #0xa0]
400050ec: a9496ffc     	ldp	x28, x27, [sp, #0x90]
400050f0: a9487bfd     	ldp	x29, x30, [sp, #0x80]
400050f4: 910383ff     	add	sp, sp, #0xe0
400050f8: d65f03c0     	ret

00000000400050fc <vfs_find>:
400050fc: d10203ff     	sub	sp, sp, #0x80
40005100: a9027bfd     	stp	x29, x30, [sp, #0x20]
40005104: 910083fd     	add	x29, sp, #0x20
40005108: a9036ffc     	stp	x28, x27, [sp, #0x30]
4000510c: a90467fa     	stp	x26, x25, [sp, #0x40]
40005110: a9055ff8     	stp	x24, x23, [sp, #0x50]
40005114: a90657f6     	stp	x22, x21, [sp, #0x60]
40005118: a9074ff4     	stp	x20, x19, [sp, #0x70]
4000511c: b4000a60     	cbz	x0, 0x40005268 <vfs_find+0x16c>
40005120: 39400008     	ldrb	w8, [x0]
40005124: aa0003f4     	mov	x20, x0
40005128: 34000a08     	cbz	w8, 0x40005268 <vfs_find+0x16c>
4000512c: 7100bd1f     	cmp	w8, #0x2f
40005130: 54000121     	b.ne	0x40005154 <vfs_find+0x58>
40005134: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
40005138: 52800037     	mov	w23, #0x1               // =1
4000513c: f945c513     	ldr	x19, [x8, #0xb88]
40005140: 38776a88     	ldrb	w8, [x20, x23]
40005144: 7100bd1f     	cmp	w8, #0x2f
40005148: 540000e1     	b.ne	0x40005164 <vfs_find+0x68>
4000514c: 910006f7     	add	x23, x23, #0x1
40005150: 17fffffc     	b	0x40005140 <vfs_find+0x44>
40005154: d0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
40005158: aa1f03f7     	mov	x23, xzr
4000515c: f945c933     	ldr	x19, [x9, #0xb90]
40005160: 14000002     	b	0x40005168 <vfs_find+0x6c>
40005164: 34000848     	cbz	w8, 0x4000526c <vfs_find+0x170>
40005168: 91000698     	add	x24, x20, #0x1
4000516c: b0000015     	adrp	x21, 0x40006000 <__rodata_start>
40005170: 9138dab5     	add	x21, x21, #0xe36
40005174: 910003f9     	mov	x25, sp
40005178: d0000016     	adrp	x22, 0x40007000 <__rodata_start+0x1000>
4000517c: 91214ed6     	add	x22, x22, #0x853
40005180: 14000006     	b	0x40005198 <vfs_find+0x9c>
40005184: f9421a68     	ldr	x8, [x19, #0x430]
40005188: f100011f     	cmp	x8, #0x0
4000518c: 9a880273     	csel	x19, x19, x8, eq
40005190: 385ff348     	ldurb	w8, [x26, #-0x1]
40005194: 340006c8     	cbz	w8, 0x4000526c <vfs_find+0x170>
40005198: 7100bd1f     	cmp	w8, #0x2f
4000519c: 54000061     	b.ne	0x400051a8 <vfs_find+0xac>
400051a0: aa1f03e9     	mov	x9, xzr
400051a4: 14000010     	b	0x400051e4 <vfs_find+0xe8>
400051a8: aa1f03e9     	mov	x9, xzr
400051ac: 8b17030a     	add	x10, x24, x23
400051b0: 34000188     	cbz	w8, 0x400051e0 <vfs_find+0xe4>
400051b4: f100793f     	cmp	x9, #0x1e
400051b8: 54000148     	b.hi	0x400051e0 <vfs_find+0xe4>
400051bc: 38296b28     	strb	w8, [x25, x9]
400051c0: 38696948     	ldrb	w8, [x10, x9]
400051c4: 9100052b     	add	x11, x9, #0x1
400051c8: aa0b03e9     	mov	x9, x11
400051cc: 7100bd1f     	cmp	w8, #0x2f
400051d0: 54ffff01     	b.ne	0x400051b0 <vfs_find+0xb4>
400051d4: 8b0b02f7     	add	x23, x23, x11
400051d8: aa0b03e9     	mov	x9, x11
400051dc: 14000002     	b	0x400051e4 <vfs_find+0xe8>
400051e0: 8b0902f7     	add	x23, x23, x9
400051e4: 8b17029a     	add	x26, x20, x23
400051e8: d10006f7     	sub	x23, x23, #0x1
400051ec: 38296b3f     	strb	wzr, [x25, x9]
400051f0: 38401748     	ldrb	w8, [x26], #0x1
400051f4: 910006f7     	add	x23, x23, #0x1
400051f8: 7100bd1f     	cmp	w8, #0x2f
400051fc: 54ffffa0     	b.eq	0x400051f0 <vfs_find+0xf4>
40005200: 910003e0     	mov	x0, sp
40005204: aa1503e1     	mov	x1, x21
40005208: 97fff70c     	bl	0x40002e38 <kstrcmp>
4000520c: 34fffc20     	cbz	w0, 0x40005190 <vfs_find+0x94>
40005210: 910003e0     	mov	x0, sp
40005214: aa1603e1     	mov	x1, x22
40005218: 97fff708     	bl	0x40002e38 <kstrcmp>
4000521c: 34fffb40     	cbz	w0, 0x40005184 <vfs_find+0x88>
40005220: b944ba68     	ldr	w8, [x19, #0x4b8]
40005224: 7100051f     	cmp	w8, #0x1
40005228: 5400020b     	b.lt	0x40005268 <vfs_find+0x16c>
4000522c: aa1f03fb     	mov	x27, xzr
40005230: 9110e27c     	add	x28, x19, #0x438
40005234: 14000005     	b	0x40005248 <vfs_find+0x14c>
40005238: b944ba68     	ldr	w8, [x19, #0x4b8]
4000523c: 9100077b     	add	x27, x27, #0x1
40005240: eb28c37f     	cmp	x27, w8, sxtw
40005244: 5400012a     	b.ge	0x40005268 <vfs_find+0x16c>
40005248: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
4000524c: b4ffff80     	cbz	x0, 0x4000523c <vfs_find+0x140>
40005250: 910003e1     	mov	x1, sp
40005254: 97fff6f9     	bl	0x40002e38 <kstrcmp>
40005258: 35ffff00     	cbnz	w0, 0x40005238 <vfs_find+0x13c>
4000525c: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40005260: b5fff993     	cbnz	x19, 0x40005190 <vfs_find+0x94>
40005264: 14000002     	b	0x4000526c <vfs_find+0x170>
40005268: aa1f03f3     	mov	x19, xzr
4000526c: aa1303e0     	mov	x0, x19
40005270: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40005274: a94657f6     	ldp	x22, x21, [sp, #0x60]
40005278: a9455ff8     	ldp	x24, x23, [sp, #0x50]
4000527c: a94467fa     	ldp	x26, x25, [sp, #0x40]
40005280: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40005284: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40005288: 910203ff     	add	sp, sp, #0x80
4000528c: d65f03c0     	ret

0000000040005290 <vfs_chdir>:
40005290: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005294: f9000bf3     	str	x19, [sp, #0x10]
40005298: 910003fd     	mov	x29, sp
4000529c: b4000200     	cbz	x0, 0x400052dc <vfs_chdir+0x4c>
400052a0: 39400008     	ldrb	w8, [x0]
400052a4: 340001c8     	cbz	w8, 0x400052dc <vfs_chdir+0x4c>
400052a8: f0000001     	adrp	x1, 0x40008000 <__rodata_start+0x2000>
400052ac: 913a6821     	add	x1, x1, #0xe9a
400052b0: aa0003f3     	mov	x19, x0
400052b4: 97fff6e1     	bl	0x40002e38 <kstrcmp>
400052b8: 34000120     	cbz	w0, 0x400052dc <vfs_chdir+0x4c>
400052bc: aa1303e0     	mov	x0, x19
400052c0: 97ffff8f     	bl	0x400050fc <vfs_find>
400052c4: b40002c0     	cbz	x0, 0x4000531c <vfs_chdir+0x8c>
400052c8: b9402008     	ldr	w8, [x0, #0x20]
400052cc: 7100051f     	cmp	w8, #0x1
400052d0: 54000180     	b.eq	0x40005300 <vfs_chdir+0x70>
400052d4: 12800028     	mov	w8, #-0x2               // =-2
400052d8: 1400000d     	b	0x4000530c <vfs_chdir+0x7c>
400052dc: d0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
400052e0: 911cec00     	add	x0, x0, #0x73b
400052e4: 97ffff86     	bl	0x400050fc <vfs_find>
400052e8: b4000080     	cbz	x0, 0x400052f8 <vfs_chdir+0x68>
400052ec: b9402008     	ldr	w8, [x0, #0x20]
400052f0: 7100051f     	cmp	w8, #0x1
400052f4: 54000060     	b.eq	0x40005300 <vfs_chdir+0x70>
400052f8: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
400052fc: f945c500     	ldr	x0, [x8, #0xb88]
40005300: d0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
40005304: 2a1f03e8     	mov	w8, wzr
40005308: f905c920     	str	x0, [x9, #0xb90]
4000530c: f9400bf3     	ldr	x19, [sp, #0x10]
40005310: 2a0803e0     	mov	w0, w8
40005314: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005318: d65f03c0     	ret
4000531c: 12800008     	mov	w8, #-0x1               // =-1
40005320: 17fffffb     	b	0x4000530c <vfs_chdir+0x7c>

0000000040005324 <vfs_mkdir>:
40005324: b40001e0     	cbz	x0, 0x40005360 <vfs_mkdir+0x3c>
40005328: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
4000532c: 39400008     	ldrb	w8, [x0]
40005330: a9024ff4     	stp	x20, x19, [sp, #0x20]
40005334: aa0003f3     	mov	x19, x0
40005338: a90157f6     	stp	x22, x21, [sp, #0x10]
4000533c: 910003fd     	mov	x29, sp
40005340: 34000148     	cbz	w8, 0x40005368 <vfs_mkdir+0x44>
40005344: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3480>
40005348: f945ca95     	ldr	x21, [x20, #0xb90]
4000534c: b944baa8     	ldr	w8, [x21, #0x4b8]
40005350: 71003d1f     	cmp	w8, #0xf
40005354: 540000ed     	b.le	0x40005370 <vfs_mkdir+0x4c>
40005358: 12800020     	mov	w0, #-0x2               // =-2
4000535c: 14000043     	b	0x40005468 <vfs_mkdir+0x144>
40005360: 12800000     	mov	w0, #-0x1               // =-1
40005364: d65f03c0     	ret
40005368: 12800000     	mov	w0, #-0x1               // =-1
4000536c: 1400003f     	b	0x40005468 <vfs_mkdir+0x144>
40005370: 7100051f     	cmp	w8, #0x1
40005374: 540001eb     	b.lt	0x400053b0 <vfs_mkdir+0x8c>
40005378: aa1f03f6     	mov	x22, xzr
4000537c: 14000005     	b	0x40005390 <vfs_mkdir+0x6c>
40005380: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40005384: 910006d6     	add	x22, x22, #0x1
40005388: eb0802df     	cmp	x22, x8
4000538c: 5400012a     	b.ge	0x400053b0 <vfs_mkdir+0x8c>
40005390: 8b160ea8     	add	x8, x21, x22, lsl #3
40005394: f9421d00     	ldr	x0, [x8, #0x438]
40005398: b4ffff40     	cbz	x0, 0x40005380 <vfs_mkdir+0x5c>
4000539c: aa1303e1     	mov	x1, x19
400053a0: 97fff6a6     	bl	0x40002e38 <kstrcmp>
400053a4: 340003e0     	cbz	w0, 0x40005420 <vfs_mkdir+0xfc>
400053a8: f945ca95     	ldr	x21, [x20, #0xb90]
400053ac: 17fffff5     	b	0x40005380 <vfs_mkdir+0x5c>
400053b0: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
400053b4: b98b8109     	ldrsw	x9, [x8, #0xb80]
400053b8: 7101fd3f     	cmp	w9, #0x7f
400053bc: 5400006d     	b.le	0x400053c8 <vfs_mkdir+0xa4>
400053c0: 12800060     	mov	w0, #-0x4               // =-4
400053c4: 14000029     	b	0x40005468 <vfs_mkdir+0x144>
400053c8: 5280980a     	mov	w10, #0x4c0             // =1216
400053cc: d000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3480>
400053d0: 912e616b     	add	x11, x11, #0xb98
400053d4: 9b2a2d34     	smaddl	x20, w9, w10, x11
400053d8: 11000529     	add	w9, w9, #0x1
400053dc: 2a1f03e1     	mov	w1, wzr
400053e0: 52809802     	mov	w2, #0x4c0              // =1216
400053e4: b90b8109     	str	w9, [x8, #0xb80]
400053e8: aa1403e0     	mov	x0, x20
400053ec: 97fff6ed     	bl	0x40002fa0 <kmemset>
400053f0: 39400268     	ldrb	w8, [x19]
400053f4: 340001a8     	cbz	w8, 0x40005428 <vfs_mkdir+0x104>
400053f8: aa1f03ea     	mov	x10, xzr
400053fc: 91000669     	add	x9, x19, #0x1
40005400: 382a6a88     	strb	w8, [x20, x10]
40005404: 9100054b     	add	x11, x10, #0x1
40005408: 386a6928     	ldrb	w8, [x9, x10]
4000540c: 34000108     	cbz	w8, 0x4000542c <vfs_mkdir+0x108>
40005410: f100795f     	cmp	x10, #0x1e
40005414: aa0b03ea     	mov	x10, x11
40005418: 54ffff43     	b.lo	0x40005400 <vfs_mkdir+0xdc>
4000541c: 14000004     	b	0x4000542c <vfs_mkdir+0x108>
40005420: 12800040     	mov	w0, #-0x3               // =-3
40005424: 14000011     	b	0x40005468 <vfs_mkdir+0x144>
40005428: aa1f03eb     	mov	x11, xzr
4000542c: 382b6a9f     	strb	wzr, [x20, x11]
40005430: 2a1f03e0     	mov	w0, wzr
40005434: 52800029     	mov	w9, #0x1                // =1
40005438: b904ba9f     	str	wzr, [x20, #0x4b8]
4000543c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40005440: b9002289     	str	w9, [x20, #0x20]
40005444: f9021a95     	str	x21, [x20, #0x430]
40005448: 71003d1f     	cmp	w8, #0xf
4000544c: f900169f     	str	xzr, [x20, #0x28]
40005450: 540000cc     	b.gt	0x40005468 <vfs_mkdir+0x144>
40005454: 8b080ea9     	add	x9, x21, x8, lsl #3
40005458: 2a1f03e0     	mov	w0, wzr
4000545c: 11000508     	add	w8, w8, #0x1
40005460: b904baa8     	str	w8, [x21, #0x4b8]
40005464: f9021d34     	str	x20, [x9, #0x438]
40005468: a9424ff4     	ldp	x20, x19, [sp, #0x20]
4000546c: a94157f6     	ldp	x22, x21, [sp, #0x10]
40005470: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005474: d65f03c0     	ret

0000000040005478 <vfs_sync>:
40005478: d65f03c0     	ret

000000004000547c <vfs_touch>:
4000547c: b4000500     	cbz	x0, 0x4000551c <vfs_touch+0xa0>
40005480: 39400008     	ldrb	w8, [x0]
40005484: 340004c8     	cbz	w8, 0x4000551c <vfs_touch+0xa0>
40005488: d10583ff     	sub	sp, sp, #0x160
4000548c: d0000069     	adrp	x9, 0x40013000 <kernel_capture_buffer+0x3480>
40005490: a9154ff4     	stp	x20, x19, [sp, #0x150]
40005494: aa1f03f4     	mov	x20, xzr
40005498: f945c933     	ldr	x19, [x9, #0xb90]
4000549c: aa0003e9     	mov	x9, x0
400054a0: a9127bfd     	stp	x29, x30, [sp, #0x120]
400054a4: a9135ffc     	stp	x28, x23, [sp, #0x130]
400054a8: 910483fd     	add	x29, sp, #0x120
400054ac: a91457f6     	stp	x22, x21, [sp, #0x140]
400054b0: 14000003     	b	0x400054bc <vfs_touch+0x40>
400054b4: aa0903f4     	mov	x20, x9
400054b8: 38401d28     	ldrb	w8, [x9, #0x1]!
400054bc: 7100bd1f     	cmp	w8, #0x2f
400054c0: 54ffffa0     	b.eq	0x400054b4 <vfs_touch+0x38>
400054c4: 35ffffa8     	cbnz	w8, 0x400054b8 <vfs_touch+0x3c>
400054c8: b4000334     	cbz	x20, 0x4000552c <vfs_touch+0xb0>
400054cc: cb000288     	sub	x8, x20, x0
400054d0: 52801fe9     	mov	w9, #0xff               // =255
400054d4: aa0103f5     	mov	x21, x1
400054d8: f103fd1f     	cmp	x8, #0xff
400054dc: aa0003e1     	mov	x1, x0
400054e0: 910083e0     	add	x0, sp, #0x20
400054e4: 9a893113     	csel	x19, x8, x9, lo
400054e8: 910083f6     	add	x22, sp, #0x20
400054ec: aa1303e2     	mov	x2, x19
400054f0: 97fff678     	bl	0x40002ed0 <kstrncpy>
400054f4: 910083e0     	add	x0, sp, #0x20
400054f8: 38336adf     	strb	wzr, [x22, x19]
400054fc: 97ffff00     	bl	0x400050fc <vfs_find>
40005500: b4000120     	cbz	x0, 0x40005524 <vfs_touch+0xa8>
40005504: b9402008     	ldr	w8, [x0, #0x20]
40005508: aa0003f3     	mov	x19, x0
4000550c: 7100051f     	cmp	w8, #0x1
40005510: 540000a1     	b.ne	0x40005524 <vfs_touch+0xa8>
40005514: 91000688     	add	x8, x20, #0x1
40005518: 14000007     	b	0x40005534 <vfs_touch+0xb8>
4000551c: 12800000     	mov	w0, #-0x1               // =-1
40005520: d65f03c0     	ret
40005524: 12800000     	mov	w0, #-0x1               // =-1
40005528: 1400006a     	b	0x400056d0 <vfs_touch+0x254>
4000552c: aa0003e8     	mov	x8, x0
40005530: aa0103f5     	mov	x21, x1
40005534: 910003e0     	mov	x0, sp
40005538: aa0803e1     	mov	x1, x8
4000553c: 528003e2     	mov	w2, #0x1f               // =31
40005540: 97fff664     	bl	0x40002ed0 <kstrncpy>
40005544: b944ba68     	ldr	w8, [x19, #0x4b8]
40005548: 39007fff     	strb	wzr, [sp, #0x1f]
4000554c: 7100051f     	cmp	w8, #0x1
40005550: 5400024b     	b.lt	0x40005598 <vfs_touch+0x11c>
40005554: aa1f03f6     	mov	x22, xzr
40005558: 9110e277     	add	x23, x19, #0x438
4000555c: 14000004     	b	0x4000556c <vfs_touch+0xf0>
40005560: 910006d6     	add	x22, x22, #0x1
40005564: eb28c2df     	cmp	x22, w8, sxtw
40005568: 5400010a     	b.ge	0x40005588 <vfs_touch+0x10c>
4000556c: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40005570: b4ffff80     	cbz	x0, 0x40005560 <vfs_touch+0xe4>
40005574: 910003e1     	mov	x1, sp
40005578: 97fff630     	bl	0x40002e38 <kstrcmp>
4000557c: 340004a0     	cbz	w0, 0x40005610 <vfs_touch+0x194>
40005580: b944ba68     	ldr	w8, [x19, #0x4b8]
40005584: 17fffff7     	b	0x40005560 <vfs_touch+0xe4>
40005588: 71003d1f     	cmp	w8, #0xf
4000558c: 5400006d     	b.le	0x40005598 <vfs_touch+0x11c>
40005590: 12800020     	mov	w0, #-0x2               // =-2
40005594: 1400004f     	b	0x400056d0 <vfs_touch+0x254>
40005598: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
4000559c: b98b8109     	ldrsw	x9, [x8, #0xb80]
400055a0: 7101fd3f     	cmp	w9, #0x7f
400055a4: 5400006d     	b.le	0x400055b0 <vfs_touch+0x134>
400055a8: 12800060     	mov	w0, #-0x4               // =-4
400055ac: 14000049     	b	0x400056d0 <vfs_touch+0x254>
400055b0: 5280980a     	mov	w10, #0x4c0             // =1216
400055b4: d000006b     	adrp	x11, 0x40013000 <kernel_capture_buffer+0x3480>
400055b8: 912e616b     	add	x11, x11, #0xb98
400055bc: 9b2a2d34     	smaddl	x20, w9, w10, x11
400055c0: 11000529     	add	w9, w9, #0x1
400055c4: 2a1f03e1     	mov	w1, wzr
400055c8: 52809802     	mov	w2, #0x4c0              // =1216
400055cc: b90b8109     	str	w9, [x8, #0xb80]
400055d0: aa1403e0     	mov	x0, x20
400055d4: 97fff673     	bl	0x40002fa0 <kmemset>
400055d8: 394003e8     	ldrb	w8, [sp]
400055dc: 340003e8     	cbz	w8, 0x40005658 <vfs_touch+0x1dc>
400055e0: 910003ea     	mov	x10, sp
400055e4: aa1f03e9     	mov	x9, xzr
400055e8: aa1503e0     	mov	x0, x21
400055ec: b240014a     	orr	x10, x10, #0x1
400055f0: 38296a88     	strb	w8, [x20, x9]
400055f4: 38696948     	ldrb	w8, [x10, x9]
400055f8: 9100052b     	add	x11, x9, #0x1
400055fc: 34000328     	cbz	w8, 0x40005660 <vfs_touch+0x1e4>
40005600: f100793f     	cmp	x9, #0x1e
40005604: aa0b03e9     	mov	x9, x11
40005608: 54ffff43     	b.lo	0x400055f0 <vfs_touch+0x174>
4000560c: 14000015     	b	0x40005660 <vfs_touch+0x1e4>
40005610: b40005f5     	cbz	x21, 0x400056cc <vfs_touch+0x250>
40005614: aa1503e0     	mov	x0, x21
40005618: 97fff5f8     	bl	0x40002df8 <kstrlen>
4000561c: 52807fe8     	mov	w8, #0x3ff              // =1023
40005620: f10ffc1f     	cmp	x0, #0x3ff
40005624: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
40005628: 9a883014     	csel	x20, x0, x8, lo
4000562c: aa1503e1     	mov	x1, x21
40005630: 9100c120     	add	x0, x9, #0x30
40005634: aa1403e2     	mov	x2, x20
40005638: 97fff683     	bl	0x40003044 <kmemcpy>
4000563c: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40005640: 2a1f03e0     	mov	w0, wzr
40005644: 8b140108     	add	x8, x8, x20
40005648: 3900c11f     	strb	wzr, [x8, #0x30]
4000564c: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40005650: f9001514     	str	x20, [x8, #0x28]
40005654: 1400001f     	b	0x400056d0 <vfs_touch+0x254>
40005658: aa1f03eb     	mov	x11, xzr
4000565c: aa1503e0     	mov	x0, x21
40005660: 382b6a9f     	strb	wzr, [x20, x11]
40005664: b904ba9f     	str	wzr, [x20, #0x4b8]
40005668: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000566c: b900229f     	str	wzr, [x20, #0x20]
40005670: f9021a93     	str	x19, [x20, #0x430]
40005674: 71003d1f     	cmp	w8, #0xf
40005678: f900169f     	str	xzr, [x20, #0x28]
4000567c: 540000ac     	b.gt	0x40005690 <vfs_touch+0x214>
40005680: 8b080e69     	add	x9, x19, x8, lsl #3
40005684: 11000508     	add	w8, w8, #0x1
40005688: b904ba68     	str	w8, [x19, #0x4b8]
4000568c: f9021d34     	str	x20, [x9, #0x438]
40005690: b4000200     	cbz	x0, 0x400056d0 <vfs_touch+0x254>
40005694: aa0003f3     	mov	x19, x0
40005698: 97fff5d8     	bl	0x40002df8 <kstrlen>
4000569c: 52807fe8     	mov	w8, #0x3ff              // =1023
400056a0: f10ffc1f     	cmp	x0, #0x3ff
400056a4: 9100c296     	add	x22, x20, #0x30
400056a8: 9a883015     	csel	x21, x0, x8, lo
400056ac: aa1603e0     	mov	x0, x22
400056b0: aa1303e1     	mov	x1, x19
400056b4: aa1503e2     	mov	x2, x21
400056b8: 97fff663     	bl	0x40003044 <kmemcpy>
400056bc: 2a1f03e0     	mov	w0, wzr
400056c0: 38356adf     	strb	wzr, [x22, x21]
400056c4: f9001695     	str	x21, [x20, #0x28]
400056c8: 14000002     	b	0x400056d0 <vfs_touch+0x254>
400056cc: 2a1f03e0     	mov	w0, wzr
400056d0: a9554ff4     	ldp	x20, x19, [sp, #0x150]
400056d4: a95457f6     	ldp	x22, x21, [sp, #0x140]
400056d8: a9535ffc     	ldp	x28, x23, [sp, #0x130]
400056dc: a9527bfd     	ldp	x29, x30, [sp, #0x120]
400056e0: 910583ff     	add	sp, sp, #0x160
400056e4: d65f03c0     	ret

00000000400056e8 <vfs_write_file>:
400056e8: 17ffff65     	b	0x4000547c <vfs_touch>

00000000400056ec <vfs_remove>:
400056ec: b40005c0     	cbz	x0, 0x400057a4 <vfs_remove+0xb8>
400056f0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
400056f4: 39400008     	ldrb	w8, [x0]
400056f8: a9024ff4     	stp	x20, x19, [sp, #0x20]
400056fc: aa0003f3     	mov	x19, x0
40005700: f9000bf5     	str	x21, [sp, #0x10]
40005704: 910003fd     	mov	x29, sp
40005708: 34000448     	cbz	w8, 0x40005790 <vfs_remove+0xa4>
4000570c: d0000074     	adrp	x20, 0x40013000 <kernel_capture_buffer+0x3480>
40005710: f945ca88     	ldr	x8, [x20, #0xb90]
40005714: b944b909     	ldr	w9, [x8, #0x4b8]
40005718: 7100053f     	cmp	w9, #0x1
4000571c: 540003ab     	b.lt	0x40005790 <vfs_remove+0xa4>
40005720: aa1f03f5     	mov	x21, xzr
40005724: 14000005     	b	0x40005738 <vfs_remove+0x4c>
40005728: b984b909     	ldrsw	x9, [x8, #0x4b8]
4000572c: 910006b5     	add	x21, x21, #0x1
40005730: eb0902bf     	cmp	x21, x9
40005734: 540002ea     	b.ge	0x40005790 <vfs_remove+0xa4>
40005738: 8b150d09     	add	x9, x8, x21, lsl #3
4000573c: f9421d20     	ldr	x0, [x9, #0x438]
40005740: b4ffff40     	cbz	x0, 0x40005728 <vfs_remove+0x3c>
40005744: aa1303e1     	mov	x1, x19
40005748: 97fff5bc     	bl	0x40002e38 <kstrcmp>
4000574c: f945ca88     	ldr	x8, [x20, #0xb90]
40005750: 35fffec0     	cbnz	w0, 0x40005728 <vfs_remove+0x3c>
40005754: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005758: d1000529     	sub	x9, x9, #0x1
4000575c: 6b15013f     	cmp	w9, w21
40005760: 5400026d     	b.le	0x400057ac <vfs_remove+0xc0>
40005764: f945ca8a     	ldr	x10, [x20, #0xb90]
40005768: b984b949     	ldrsw	x9, [x10, #0x4b8]
4000576c: d1000529     	sub	x9, x9, #0x1
40005770: 8b150d08     	add	x8, x8, x21, lsl #3
40005774: 910006b5     	add	x21, x21, #0x1
40005778: eb0902bf     	cmp	x21, x9
4000577c: f942210b     	ldr	x11, [x8, #0x440]
40005780: f9021d0b     	str	x11, [x8, #0x438]
40005784: aa0a03e8     	mov	x8, x10
40005788: 54ffff4b     	b.lt	0x40005770 <vfs_remove+0x84>
4000578c: 14000009     	b	0x400057b0 <vfs_remove+0xc4>
40005790: 12800000     	mov	w0, #-0x1               // =-1
40005794: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005798: f9400bf5     	ldr	x21, [sp, #0x10]
4000579c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
400057a0: d65f03c0     	ret
400057a4: 12800000     	mov	w0, #-0x1               // =-1
400057a8: d65f03c0     	ret
400057ac: aa0803ea     	mov	x10, x8
400057b0: 8b090d48     	add	x8, x10, x9, lsl #3
400057b4: 2a1f03e0     	mov	w0, wzr
400057b8: f9021d1f     	str	xzr, [x8, #0x438]
400057bc: f945ca88     	ldr	x8, [x20, #0xb90]
400057c0: b944b909     	ldr	w9, [x8, #0x4b8]
400057c4: 51000529     	sub	w9, w9, #0x1
400057c8: b904b909     	str	w9, [x8, #0x4b8]
400057cc: 17fffff2     	b	0x40005794 <vfs_remove+0xa8>

00000000400057d0 <vfs_list_dir>:
400057d0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400057d4: d0000068     	adrp	x8, 0x40013000 <kernel_capture_buffer+0x3480>
400057d8: f100001f     	cmp	x0, #0x0
400057dc: a90257f6     	stp	x22, x21, [sp, #0x20]
400057e0: f945c908     	ldr	x8, [x8, #0xb90]
400057e4: f9000bf7     	str	x23, [sp, #0x10]
400057e8: 910003fd     	mov	x29, sp
400057ec: a9034ff4     	stp	x20, x19, [sp, #0x30]
400057f0: 9a800115     	csel	x21, x8, x0, eq
400057f4: b94022a8     	ldr	w8, [x21, #0x20]
400057f8: 7100051f     	cmp	w8, #0x1
400057fc: 54000521     	b.ne	0x400058a0 <vfs_list_dir+0xd0>
40005800: d0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40005804: 9115d000     	add	x0, x0, #0x574
40005808: 97fff951     	bl	0x40003d4c <uart_puts>
4000580c: b0000000     	adrp	x0, 0x40006000 <__rodata_start>
40005810: 912e7800     	add	x0, x0, #0xb9e
40005814: 97fff94e     	bl	0x40003d4c <uart_puts>
40005818: f0000000     	adrp	x0, 0x40008000 <__rodata_start+0x2000>
4000581c: 91255000     	add	x0, x0, #0x954
40005820: 97fff94b     	bl	0x40003d4c <uart_puts>
40005824: f9421aa8     	ldr	x8, [x21, #0x430]
40005828: b4000088     	cbz	x8, 0x40005838 <vfs_list_dir+0x68>
4000582c: d0000000     	adrp	x0, 0x40007000 <__rodata_start+0x1000>
40005830: 912b9c00     	add	x0, x0, #0xae7
40005834: 97fff946     	bl	0x40003d4c <uart_puts>
40005838: b944baa1     	ldr	w1, [x21, #0x4b8]
4000583c: 7100043f     	cmp	w1, #0x1
40005840: 5400034b     	b.lt	0x400058a8 <vfs_list_dir+0xd8>
40005844: aa1f03f6     	mov	x22, xzr
40005848: f0000013     	adrp	x19, 0x40008000 <__rodata_start+0x2000>
4000584c: 9115b673     	add	x19, x19, #0x56d
40005850: 9110e2b7     	add	x23, x21, #0x438
40005854: d0000014     	adrp	x20, 0x40007000 <__rodata_start+0x1000>
40005858: 913c1a94     	add	x20, x20, #0xf06
4000585c: 14000008     	b	0x4000587c <vfs_list_dir+0xac>
40005860: b9402841     	ldr	w1, [x2, #0x28]
40005864: aa1403e0     	mov	x0, x20
40005868: 97fffa49     	bl	0x4000418c <uart_printf>
4000586c: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40005870: 910006d6     	add	x22, x22, #0x1
40005874: eb0102df     	cmp	x22, x1
40005878: 5400018a     	b.ge	0x400058a8 <vfs_list_dir+0xd8>
4000587c: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005880: b4ffff62     	cbz	x2, 0x4000586c <vfs_list_dir+0x9c>
40005884: b9402048     	ldr	w8, [x2, #0x20]
40005888: 7100051f     	cmp	w8, #0x1
4000588c: 54fffea1     	b.ne	0x40005860 <vfs_list_dir+0x90>
40005890: aa1303e0     	mov	x0, x19
40005894: aa0203e1     	mov	x1, x2
40005898: 97fffa3d     	bl	0x4000418c <uart_printf>
4000589c: 17fffff4     	b	0x4000586c <vfs_list_dir+0x9c>
400058a0: 12800000     	mov	w0, #-0x1               // =-1
400058a4: 14000005     	b	0x400058b8 <vfs_list_dir+0xe8>
400058a8: b0000000     	adrp	x0, 0x40006000 <__rodata_start>
400058ac: 9138e000     	add	x0, x0, #0xe38
400058b0: 97fffa37     	bl	0x4000418c <uart_printf>
400058b4: 2a1f03e0     	mov	w0, wzr
400058b8: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400058bc: f9400bf7     	ldr	x23, [sp, #0x10]
400058c0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400058c4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400058c8: d65f03c0     	ret

00000000400058cc <vfs_load>:
400058cc: d65f03c0     	ret
