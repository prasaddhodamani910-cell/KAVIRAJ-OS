
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
4000003c: 94000678     	bl	0x40001a1c <kmain>

0000000040000040 <halt>:
40000040: d503207f     	wfi
40000044: 17ffffff     	b	0x40000040 <halt>
40000048: 50 e0 45 40  	.word	0x4045e050
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 d0 00 40  	.word	0x4000d000
40000054: 00 00 00 00  	.word	0x00000000
40000058: 50 e0 44 40  	.word	0x4044e050
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 50053a80     	adr	x0, 0x4000a7c2 <__rodata_start+0x17c2>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000dee     	bl	0x4000383c <uart_puts>
40000088: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000008c: 91041800     	add	x0, x0, #0x106
40000090: aa1403e1     	mov	x1, x20
40000094: 94000eff     	bl	0x40003c90 <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000a0: 9103bc00     	add	x0, x0, #0xef
400000a4: 94000efb     	bl	0x40003c90 <uart_printf>
400000a8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000ac: 91116800     	add	x0, x0, #0x45a
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000ef7     	bl	0x40003c90 <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400000c0: 91286400     	add	x0, x0, #0xa19
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000ef2     	bl	0x40003c90 <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000f0: 91169000     	add	x0, x0, #0x5a4
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000fc: 9138b000     	add	x0, x0, #0xe2c
40000100: 94000dcf     	bl	0x4000383c <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
4000010c: 91030800     	add	x0, x0, #0xc2
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000dc9     	bl	0x4000383c <uart_puts>
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
40000140: 913c4400     	add	x0, x0, #0xf11
40000144: 910003fd     	mov	x29, sp
40000148: d5385214     	mrs	x20, ESR_EL1
4000014c: 94000ed1     	bl	0x40003c90 <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000158: 912c8000     	add	x0, x0, #0xb20
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000ecc     	bl	0x40003c90 <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000170: 91045c00     	add	x0, x0, #0x117
40000174: 910003fd     	mov	x29, sp
40000178: 94000db1     	bl	0x4000383c <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000188: 91391800     	add	x0, x0, #0xe46
4000018c: 910003fd     	mov	x29, sp
40000190: 94000dab     	bl	0x4000383c <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001a0: 91186000     	add	x0, x0, #0x618
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000da5     	bl	0x4000383c <uart_puts>
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
400001d8: 94000ab7     	bl	0x40002cb4 <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 940015af     	bl	0x4000589c <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001f0: 911e0800     	add	x0, x0, #0x782
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000ea6     	bl	0x40003c90 <uart_printf>
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
400002fc: 94000a00     	bl	0x40002afc <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 940009d7     	bl	0x40002a68 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 94001224     	bl	0x40004bac <vfs_find>
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
400003bc: 50053dc0     	adr	x0, 0x4000ab76 <__rodata_start+0x1b76>
400003c0: 94000d1f     	bl	0x4000383c <uart_puts>
400003c4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400003c8: 9135ae94     	add	x20, x20, #0xd6b
400003cc: b0000056     	adrp	x22, 0x40009000 <__rodata_start>
400003d0: 91040ad6     	add	x22, x22, #0x102
400003d4: d0000058     	adrp	x24, 0x4000a000 <__rodata_start+0x1000>
400003d8: 9116db18     	add	x24, x24, #0x5b6
400003dc: d0000059     	adrp	x25, 0x4000a000 <__rodata_start+0x1000>
400003e0: 9125cb39     	add	x25, x25, #0x972
400003e4: 9000009a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: 9000009b     	adrp	x27, 0x40010000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000d0e     	bl	0x4000383c <uart_puts>
40000408: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000040c: 910f5400     	add	x0, x0, #0x3d5
40000410: 94000d0b     	bl	0x4000383c <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000d09     	bl	0x4000383c <uart_puts>
4000041c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000420: 9104d000     	add	x0, x0, #0x134
40000424: aa1303e1     	mov	x1, x19
40000428: 94000e1a     	bl	0x40003c90 <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000434: 91152929     	add	x9, x9, #0x54a
40000438: 7100011f     	cmp	w8, #0x0
4000043c: d0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40000440: 912ff508     	add	x8, x8, #0xbfd
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000cfd     	bl	0x4000383c <uart_puts>
4000044c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000450: 91047400     	add	x0, x0, #0x11d
40000454: 94000cfa     	bl	0x4000383c <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000cf1     	bl	0x4000383c <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000cef     	bl	0x4000383c <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000cea     	bl	0x4000383c <uart_puts>
40000498: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000049c: 91170400     	add	x0, x0, #0x5c1
400004a0: 94000ce7     	bl	0x4000383c <uart_puts>
400004a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004a8: 91398c00     	add	x0, x0, #0xe63
400004ac: 94000ce4     	bl	0x4000383c <uart_puts>
400004b0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004b4: 9125d000     	add	x0, x0, #0x974
400004b8: 94000ce1     	bl	0x4000383c <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400004c8: 91121800     	add	x0, x0, #0x486
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000dee     	bl	0x40003c90 <uart_printf>
400004dc: 94000d0c     	bl	0x4000390c <uart_getc>
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
40000550: 9400093f     	bl	0x40002a4c <kstrcpy>
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
4000057c: 94000934     	bl	0x40002a4c <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 9400092a     	bl	0x40002a4c <kstrcpy>
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
400005dc: 940008ed     	bl	0x40002990 <kstrlen>
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
40000674: 940008c7     	bl	0x40002990 <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 940008c8     	bl	0x400029ac <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 940008c5     	bl	0x400029ac <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 940012bb     	bl	0x40005198 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006bc: 9135ae94     	add	x20, x20, #0xd6b
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c92     	bl	0x4000390c <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c90     	bl	0x4000390c <uart_getc>
400006d0: 71016e9f     	cmp	w20, #0x5b
400006d4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006d8: 9135ae94     	add	x20, x20, #0xd6b
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
40000710: 940008a0     	bl	0x40002990 <kstrlen>
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
40000760: 9400088c     	bl	0x40002990 <kstrlen>
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
40000824: 9400085b     	bl	0x40002990 <kstrlen>
40000828: eb14001f     	cmp	x0, x20
4000082c: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
40000830: 9135ae94     	add	x20, x20, #0xd6b
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
4000088c: 912df000     	add	x0, x0, #0xb7c
40000890: 94000beb     	bl	0x4000383c <uart_puts>
40000894: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000898: 912fac00     	add	x0, x0, #0xbeb
4000089c: 94000be8     	bl	0x4000383c <uart_puts>
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
400008c8: 529869f3     	mov	w19, #0xc34f            // =49999
400008cc: 52986a14     	mov	w20, #0xc350            // =50000
400008d0: a9017bfd     	stp	x29, x30, [sp, #0x10]
400008d4: 910043fd     	add	x29, sp, #0x10
400008d8: 94001664     	bl	0x40006268 <virtio_net_poll>
400008dc: b81fc3bf     	stur	wzr, [x29, #-0x4]
400008e0: b85fc3a8     	ldur	w8, [x29, #-0x4]
400008e4: 6b13011f     	cmp	w8, w19
400008e8: 54ffff8c     	b.gt	0x400008d8 <system_idle_daemon+0x18>
400008ec: b85fc3a8     	ldur	w8, [x29, #-0x4]
400008f0: 11000508     	add	w8, w8, #0x1
400008f4: b81fc3a8     	stur	w8, [x29, #-0x4]
400008f8: b85fc3a8     	ldur	w8, [x29, #-0x4]
400008fc: 6b14011f     	cmp	w8, w20
40000900: 54ffff6b     	b.lt	0x400008ec <system_idle_daemon+0x2c>
40000904: 17fffff5     	b	0x400008d8 <system_idle_daemon+0x18>

0000000040000908 <print_banner>:
40000908: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000090c: d503201f     	nop
40000910: 3004d620     	adr	x0, 0x4000a3d5 <__rodata_start+0x13d5>
40000914: 910003fd     	mov	x29, sp
40000918: 94000bc9     	bl	0x4000383c <uart_puts>
4000091c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000920: 9125c800     	add	x0, x0, #0x972
40000924: 94000bc6     	bl	0x4000383c <uart_puts>
40000928: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000092c: 9117b800     	add	x0, x0, #0x5ee
40000930: 94000bc3     	bl	0x4000383c <uart_puts>
40000934: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000938: 91302800     	add	x0, x0, #0xc0a
4000093c: 94000bc0     	bl	0x4000383c <uart_puts>
40000940: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000944: 91053c00     	add	x0, x0, #0x14f
40000948: 94000bbd     	bl	0x4000383c <uart_puts>
4000094c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000bba     	bl	0x4000383c <uart_puts>
40000958: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000095c: 91062800     	add	x0, x0, #0x18a
40000960: 94000bb7     	bl	0x4000383c <uart_puts>
40000964: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000968: 911e8800     	add	x0, x0, #0x7a2
4000096c: 94000bb4     	bl	0x4000383c <uart_puts>
40000970: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000974: 91048c00     	add	x0, x0, #0x123
40000978: 94000cc6     	bl	0x40003c90 <uart_printf>
4000097c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000980: 9125ec00     	add	x0, x0, #0x97b
40000984: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000988: 91184021     	add	x1, x1, #0x610
4000098c: 94000cc1     	bl	0x40003c90 <uart_printf>
40000990: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000994: 910f8c00     	add	x0, x0, #0x3e3
40000998: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000099c: 91071821     	add	x1, x1, #0x1c6
400009a0: 94000cbc     	bl	0x40003c90 <uart_printf>
400009a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009a8: 9139a000     	add	x0, x0, #0xe68
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000ba3     	b	0x4000383c <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009bc: 910a3000     	add	x0, x0, #0x28c
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b9e     	bl	0x4000383c <uart_puts>
400009c8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009cc: 911fdc00     	add	x0, x0, #0x7f7
400009d0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009d4: 91075c21     	add	x1, x1, #0x1d7
400009d8: 94000cae     	bl	0x40003c90 <uart_printf>
400009dc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009e0: 9129d800     	add	x0, x0, #0xa76
400009e4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
400009e8: 91184021     	add	x1, x1, #0x610
400009ec: 94000ca9     	bl	0x40003c90 <uart_printf>
400009f0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009f4: 91155c00     	add	x0, x0, #0x557
400009f8: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009fc: 91071821     	add	x1, x1, #0x1c6
40000a00: 94000ca4     	bl	0x40003c90 <uart_printf>
40000a04: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000a08: 9110cc00     	add	x0, x0, #0x433
40000a0c: 94000b8c     	bl	0x4000383c <uart_puts>
40000a10: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000a14: 91241400     	add	x0, x0, #0x905
40000a18: 94000b89     	bl	0x4000383c <uart_puts>
40000a1c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a20: 9125c800     	add	x0, x0, #0x972
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b85     	b	0x4000383c <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a34: 910aec00     	add	x0, x0, #0x2bb
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b7c     	bl	0x4000383c <uart_puts>
40000a50: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a54: 91357000     	add	x0, x0, #0xd5c
40000a58: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a5c: 91075c21     	add	x1, x1, #0x1d7
40000a60: b0000042     	adrp	x2, 0x40009000 <__rodata_start>
40000a64: 91184042     	add	x2, x2, #0x610
40000a68: 94000c8a     	bl	0x40003c90 <uart_printf>
40000a6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a70: 9135ec00     	add	x0, x0, #0xd7b
40000a74: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a78: 91071821     	add	x1, x1, #0x1c6
40000a7c: 94000c85     	bl	0x40003c90 <uart_printf>
40000a80: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000a84: 9100f000     	add	x0, x0, #0x3c
40000a88: 94000c82     	bl	0x40003c90 <uart_printf>
40000a8c: f0000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
40000a90: 91210d08     	add	x8, x8, #0x843
40000a94: f0000049     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40000a98: 9111a129     	add	x9, x9, #0x468
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000aa4: 9118ac00     	add	x0, x0, #0x62b
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000ab4: 91311529     	add	x9, x9, #0xc45
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c74     	bl	0x40003c90 <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000acc: 91204000     	add	x0, x0, #0x810
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c6f     	bl	0x40003c90 <uart_printf>
40000ad8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000adc: 913c2800     	add	x0, x0, #0xf0a
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c6a     	bl	0x40003c90 <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 10040582     	adr	x2, 0x40008ba8 <__text_end>
40000afc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b00: 9135c800     	add	x0, x0, #0xd72
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c62     	bl	0x40003c90 <uart_printf>
40000b0c: d503201f     	nop
40000b10: 10042781     	adr	x1, 0x40009000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 10058082     	adr	x2, 0x4000bb28 <__rodata_end>
40000b1c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b20: 911d5c00     	add	x0, x0, #0x757
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000c5a     	bl	0x40003c90 <uart_printf>
40000b2c: d503201f     	nop
40000b30: 1005a681     	adr	x1, 0x4000c000 <next_pid>
40000b34: d0002262     	adrp	x2, 0x4044e000 <bpb>
40000b38: 91014042     	add	x2, x2, #0x50
40000b3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b40: 9130a000     	add	x0, x0, #0xc28
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000c52     	bl	0x40003c90 <uart_printf>
40000b4c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b50: 91061400     	add	x0, x0, #0x185
40000b54: d00022e1     	adrp	x1, 0x4045e000
40000b58: 91014021     	add	x1, x1, #0x50
40000b5c: 94000c4d     	bl	0x40003c90 <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b68: 9125c800     	add	x0, x0, #0x972
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000b33     	b	0x4000383c <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000b7c: 9111cc00     	add	x0, x0, #0x473
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000b2e     	bl	0x4000383c <uart_puts>
40000b88: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b8c: 913c9000     	add	x0, x0, #0xf24
40000b90: 94000b2b     	bl	0x4000383c <uart_puts>
40000b94: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b98: 91193000     	add	x0, x0, #0x64c
40000b9c: 94000b28     	bl	0x4000383c <uart_puts>
40000ba0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ba4: 91365400     	add	x0, x0, #0xd95
40000ba8: 94000b25     	bl	0x4000383c <uart_puts>
40000bac: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bb0: 911e0400     	add	x0, x0, #0x781
40000bb4: 94000b22     	bl	0x4000383c <uart_puts>
40000bb8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000bbc: 910f7400     	add	x0, x0, #0x3dd
40000bc0: 94000b1f     	bl	0x4000383c <uart_puts>
40000bc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bc8: 91367000     	add	x0, x0, #0xd9c
40000bcc: 94000b1c     	bl	0x4000383c <uart_puts>
40000bd0: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000bd4: 91213c00     	add	x0, x0, #0x84f
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000b18     	b	0x4000383c <uart_puts>

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
40000c04: 9128de94     	add	x20, x20, #0xa37
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000b40     	bl	0x4000390c <uart_getc>
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
40000c60: 94000ae0     	bl	0x400037e0 <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000af1     	bl	0x4000383c <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000c84: 91069400     	add	x0, x0, #0x1a5
40000c88: 94000aed     	bl	0x4000383c <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cac: 91314400     	add	x0, x0, #0xc51
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000ae2     	bl	0x4000383c <uart_puts>
40000cb8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cbc: 91160800     	add	x0, x0, #0x582
40000cc0: 94000adf     	bl	0x4000383c <uart_puts>
40000cc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cc8: 91251400     	add	x0, x0, #0x945
40000ccc: 94000adc     	bl	0x4000383c <uart_puts>
40000cd0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cd4: 9106a000     	add	x0, x0, #0x1a8
40000cd8: 94000ad9     	bl	0x4000383c <uart_puts>
40000cdc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ce0: 910b7c00     	add	x0, x0, #0x2df
40000ce4: 94000ad6     	bl	0x4000383c <uart_puts>
40000ce8: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cec: 91078800     	add	x0, x0, #0x1e2
40000cf0: 94000ad3     	bl	0x4000383c <uart_puts>
40000cf4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cf8: 91226800     	add	x0, x0, #0x89a
40000cfc: 94000ad0     	bl	0x4000383c <uart_puts>
40000d00: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d04: 911f3000     	add	x0, x0, #0x7cc
40000d08: 94000acd     	bl	0x4000383c <uart_puts>
40000d0c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d10: 91271c00     	add	x0, x0, #0x9c7
40000d14: 94000aca     	bl	0x4000383c <uart_puts>
40000d18: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d1c: 91238000     	add	x0, x0, #0x8e0
40000d20: 94000ac7     	bl	0x4000383c <uart_puts>
40000d24: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d28: 91282000     	add	x0, x0, #0xa08
40000d2c: 94000ac4     	bl	0x4000383c <uart_puts>
40000d30: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d34: 91378c00     	add	x0, x0, #0xde3
40000d38: 94000ac1     	bl	0x4000383c <uart_puts>
40000d3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d40: 91041c00     	add	x0, x0, #0x107
40000d44: 94000abe     	bl	0x4000383c <uart_puts>
40000d48: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d4c: 9112ac00     	add	x0, x0, #0x4ab
40000d50: 94000abb     	bl	0x4000383c <uart_puts>
40000d54: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d58: 91260400     	add	x0, x0, #0x981
40000d5c: 94000ab8     	bl	0x4000383c <uart_puts>
40000d60: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d64: 913d9400     	add	x0, x0, #0xf65
40000d68: 94000ab5     	bl	0x4000383c <uart_puts>
40000d6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d70: 910c1800     	add	x0, x0, #0x306
40000d74: 94000ab2     	bl	0x4000383c <uart_puts>
40000d78: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d7c: 9120dc00     	add	x0, x0, #0x837
40000d80: 94000aaf     	bl	0x4000383c <uart_puts>
40000d84: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d88: 9128ec00     	add	x0, x0, #0xa3b
40000d8c: 94000aac     	bl	0x4000383c <uart_puts>
40000d90: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d94: 9118a400     	add	x0, x0, #0x629
40000d98: 94000aa9     	bl	0x4000383c <uart_puts>
40000d9c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000da0: 910ab800     	add	x0, x0, #0x2ae
40000da4: 94000aa6     	bl	0x4000383c <uart_puts>
40000da8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dac: 9110ac00     	add	x0, x0, #0x42b
40000db0: 94000aa3     	bl	0x4000383c <uart_puts>
40000db4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000db8: 91139000     	add	x0, x0, #0x4e4
40000dbc: 94000aa0     	bl	0x4000383c <uart_puts>
40000dc0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dc4: 91292800     	add	x0, x0, #0xa4a
40000dc8: 94000a9d     	bl	0x4000383c <uart_puts>
40000dcc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dd0: 9119b400     	add	x0, x0, #0x66d
40000dd4: 94000a9a     	bl	0x4000383c <uart_puts>
40000dd8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000ddc: 91123c00     	add	x0, x0, #0x48f
40000de0: 94000a97     	bl	0x4000383c <uart_puts>
40000de4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000de8: 912a1000     	add	x0, x0, #0xa84
40000dec: 94000a94     	bl	0x4000383c <uart_puts>
40000df0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000df4: 91200000     	add	x0, x0, #0x800
40000df8: 94000a91     	bl	0x4000383c <uart_puts>
40000dfc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e00: 91383c00     	add	x0, x0, #0xe0f
40000e04: 94000a8e     	bl	0x4000383c <uart_puts>
40000e08: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e0c: 9104e400     	add	x0, x0, #0x139
40000e10: 94000a8b     	bl	0x4000383c <uart_puts>
40000e14: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000e18: 91149800     	add	x0, x0, #0x526
40000e1c: 94000a88     	bl	0x4000383c <uart_puts>
40000e20: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e24: 912d0400     	add	x0, x0, #0xb41
40000e28: 94000a85     	bl	0x4000383c <uart_puts>
40000e2c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000e30: 91220400     	add	x0, x0, #0x881
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a81     	b	0x4000383c <uart_puts>

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
40000f04: 912e4c21     	add	x1, x1, #0xb93
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 940006b0     	bl	0x400029d0 <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f1c: 91288421     	add	x1, x1, #0xa21
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 940006ab     	bl	0x400029d0 <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f30: 910ce421     	add	x1, x1, #0x339
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 940006a6     	bl	0x400029d0 <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f44: 913e9421     	add	x1, x1, #0xfa5
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 940006a1     	bl	0x400029d0 <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f58: 910cb021     	add	x1, x1, #0x32c
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 9400069c     	bl	0x400029d0 <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f6c: 91269021     	add	x1, x1, #0x9a4
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 94000697     	bl	0x400029d0 <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000f80: 9101b421     	add	x1, x1, #0x6d
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 94000692     	bl	0x400029d0 <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000f94: 91194821     	add	x1, x1, #0x652
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 9400068d     	bl	0x400029d0 <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000fa8: 91329421     	add	x1, x1, #0xca5
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000688     	bl	0x400029d0 <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fbc: 912dc821     	add	x1, x1, #0xb72
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 94000683     	bl	0x400029d0 <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fd0: 91167421     	add	x1, x1, #0x59d
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 9400067e     	bl	0x400029d0 <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000fe4: 91248c21     	add	x1, x1, #0x923
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000679     	bl	0x400029d0 <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000ff8: 91133021     	add	x1, x1, #0x4cc
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 94000674     	bl	0x400029d0 <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000100c: 9129a021     	add	x1, x1, #0xa68
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 9400066f     	bl	0x400029d0 <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001020: 91327421     	add	x1, x1, #0xc9d
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 9400066a     	bl	0x400029d0 <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001034: 9129bc21     	add	x1, x1, #0xa6f
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 94000665     	bl	0x400029d0 <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001048: 91089821     	add	x1, x1, #0x226
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 94000660     	bl	0x400029d0 <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000105c: 9107ac21     	add	x1, x1, #0x1eb
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 9400065b     	bl	0x400029d0 <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001070: 910cbc21     	add	x1, x1, #0x32f
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 94000656     	bl	0x400029d0 <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001084: 9115c021     	add	x1, x1, #0x570
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 94000651     	bl	0x400029d0 <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001098: 9123b821     	add	x1, x1, #0x8ee
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 9400064c     	bl	0x400029d0 <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010ac: 9121d821     	add	x1, x1, #0x876
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 94000647     	bl	0x400029d0 <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010c0: 91085821     	add	x1, x1, #0x216
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 94000642     	bl	0x400029d0 <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010d4: 9115d821     	add	x1, x1, #0x576
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 9400063d     	bl	0x400029d0 <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010e8: 9121f021     	add	x1, x1, #0x87c
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 94000638     	bl	0x400029d0 <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010fc: 9123d021     	add	x1, x1, #0x8f4
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 94000633     	bl	0x400029d0 <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001110: 910d1021     	add	x1, x1, #0x344
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 9400062e     	bl	0x400029d0 <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001124: 91122c21     	add	x1, x1, #0x48b
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 94000629     	bl	0x400029d0 <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001138: 9137b421     	add	x1, x1, #0xded
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 94000624     	bl	0x400029d0 <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000114c: 912a9821     	add	x1, x1, #0xaa6
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 9400061f     	bl	0x400029d0 <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001160: 91199421     	add	x1, x1, #0x665
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 9400061a     	bl	0x400029d0 <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001174: 9132d821     	add	x1, x1, #0xcb6
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 94000615     	bl	0x400029d0 <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001188: 9119a800     	add	x0, x0, #0x66a
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011a0: 910a3000     	add	x0, x0, #0x28c
400011a4: 940009a6     	bl	0x4000383c <uart_puts>
400011a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011ac: 911fdc00     	add	x0, x0, #0x7f7
400011b0: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011b4: 91075c21     	add	x1, x1, #0x1d7
400011b8: 94000ab6     	bl	0x40003c90 <uart_printf>
400011bc: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011c0: 9129d800     	add	x0, x0, #0xa76
400011c4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400011c8: 91184021     	add	x1, x1, #0x610
400011cc: 94000ab1     	bl	0x40003c90 <uart_printf>
400011d0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011d4: 91155c00     	add	x0, x0, #0x557
400011d8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011dc: 91071821     	add	x1, x1, #0x1c6
400011e0: 94000aac     	bl	0x40003c90 <uart_printf>
400011e4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400011e8: 9110cc00     	add	x0, x0, #0x433
400011ec: 94000994     	bl	0x4000383c <uart_puts>
400011f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011f4: 91241400     	add	x0, x0, #0x905
400011f8: 94000991     	bl	0x4000383c <uart_puts>
400011fc: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001200: 9125c800     	add	x0, x0, #0x972
40001204: 9400098e     	bl	0x4000383c <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001210: 910a7000     	add	x0, x0, #0x29c
40001214: 9400098a     	bl	0x4000383c <uart_puts>
40001218: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000121c: 910b8400     	add	x0, x0, #0x2e1
40001220: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001224: 91184021     	add	x1, x1, #0x610
40001228: 94000a9a     	bl	0x40003c90 <uart_printf>
4000122c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001230: 91314800     	add	x0, x0, #0xc52
40001234: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001238: 91071821     	add	x1, x1, #0x1c6
4000123c: 94000a95     	bl	0x40003c90 <uart_printf>
40001240: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001244: 9105d400     	add	x0, x0, #0x175
40001248: 9400097d     	bl	0x4000383c <uart_puts>
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
40001274: 940005c7     	bl	0x40002990 <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000fd6     	bl	0x400051d8 <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000128c: 9118e000     	add	x0, x0, #0x638
40001290: 9400096b     	bl	0x4000383c <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 940005bd     	bl	0x40002990 <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 9400068d     	bl	0x40002ce4 <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 94000254     	bl	0x40001c0c <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012c8: 911a5c00     	add	x0, x0, #0x697
400012cc: 9400095c     	bl	0x4000383c <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400012d8: 91378c00     	add	x0, x0, #0xde3
400012dc: 94000958     	bl	0x4000383c <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012e8: 9138f000     	add	x0, x0, #0xe3c
400012ec: 94000954     	bl	0x4000383c <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000388     	bl	0x40002114 <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 940005a4     	bl	0x40002990 <kstrlen>
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
40001348: 9126a821     	add	x1, x1, #0x9aa
4000134c: aa1303e0     	mov	x0, x19
40001350: 9400060a     	bl	0x40002b78 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f8b     	bl	0x40005198 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001378: 910d0421     	add	x1, x1, #0x341
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 94000594     	bl	0x400029d0 <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000138c: 911b5000     	add	x0, x0, #0x6d4
40001390: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001394: 91075c21     	add	x1, x1, #0x1d7
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400013a0: 911acc00     	add	x0, x0, #0x6b3
400013a4: 94000926     	bl	0x4000383c <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 940002c3     	bl	0x40001ec0 <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013c8: 910cf400     	add	x0, x0, #0x33d
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013d4: 910d4400     	add	x0, x0, #0x351
400013d8: 94000919     	bl	0x4000383c <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013e4: 911b5000     	add	x0, x0, #0x6d4
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013f4: 911ab400     	add	x0, x0, #0x6ad
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 94000a25     	bl	0x40003c90 <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d98     	bl	0x40004a64 <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 94000560     	bl	0x40002990 <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000de4     	bl	0x40004bac <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: b0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40001434: 91235908     	add	x8, x8, #0x8d6
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 94000a14     	bl	0x40003c90 <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d88     	bl	0x40004a70 <vfs_getcwd>
40001454: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001458: 911b5000     	add	x0, x0, #0x6d4
4000145c: 910003e1     	mov	x1, sp
40001460: 94000a0c     	bl	0x40003c90 <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000146c: 91211c00     	add	x0, x0, #0x847
40001470: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001474: 91075c21     	add	x1, x1, #0x1d7
40001478: 90000042     	adrp	x2, 0x40009000 <__rodata_start>
4000147c: 91184042     	add	x2, x2, #0x610
40001480: d0000043     	adrp	x3, 0x4000b000 <__rodata_start+0x2000>
40001484: 91071863     	add	x3, x3, #0x1c6
40001488: 94000a02     	bl	0x40003c90 <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f8a     	bl	0x400052bc <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000e28     	bl	0x40004d40 <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014ac: 91119c00     	add	x0, x0, #0x467
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014bc: 911b1800     	add	x0, x0, #0x6c6
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 94000531     	bl	0x40002990 <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000db5     	bl	0x40004bac <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400014ec: 910ccc00     	add	x0, x0, #0x333
400014f0: 940008d3     	bl	0x4000383c <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 94000525     	bl	0x40002990 <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000e33     	bl	0x40004dd4 <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001514: 910de800     	add	x0, x0, #0x37a
40001518: 940008c9     	bl	0x4000383c <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 9400051b     	bl	0x40002990 <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e7e     	bl	0x40004f2c <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001540: 91195800     	add	x0, x0, #0x656
40001544: 940008be     	bl	0x4000383c <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001550: 91156400     	add	x0, x0, #0x559
40001554: 940008ba     	bl	0x4000383c <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 940005a0     	bl	0x40002be4 <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000f08     	bl	0x40005198 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001584: 91134800     	add	x0, x0, #0x4d2
40001588: 940008ad     	bl	0x4000383c <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001594: 911c0800     	add	x0, x0, #0x702
40001598: 940008a9     	bl	0x4000383c <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: d503201f     	nop
400015a4: 30047180     	adr	x0, 0x4000a3d5 <__rodata_start+0x13d5>
400015a8: 940008a5     	bl	0x4000383c <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015b4: 9125c800     	add	x0, x0, #0x972
400015b8: 940008a1     	bl	0x4000383c <uart_puts>
400015bc: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400015c0: 9101cc00     	add	x0, x0, #0x73
400015c4: 9400089e     	bl	0x4000383c <uart_puts>
400015c8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 9400089b     	bl	0x4000383c <uart_puts>
400015d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015d8: 913eb400     	add	x0, x0, #0xfad
400015dc: 94000898     	bl	0x4000383c <uart_puts>
400015e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015e4: 91138400     	add	x0, x0, #0x4e1
400015e8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400015ec: 91071821     	add	x1, x1, #0x1c6
400015f0: 940009a8     	bl	0x40003c90 <uart_printf>
400015f4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015f8: 9129c800     	add	x0, x0, #0xa72
400015fc: 94000890     	bl	0x4000383c <uart_puts>
40001600: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001604: 9124a000     	add	x0, x0, #0x928
40001608: 9400088d     	bl	0x4000383c <uart_puts>
4000160c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001610: 911c5c00     	add	x0, x0, #0x717
40001614: 9400088a     	bl	0x4000383c <uart_puts>
40001618: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000161c: 9132b400     	add	x0, x0, #0xcad
40001620: 94000887     	bl	0x4000383c <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: 90000048     	adrp	x8, 0x40009000 <__rodata_start>
4000162c: 911b5108     	add	x8, x8, #0x6d4
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001640: 91328400     	add	x0, x0, #0xca1
40001644: 9400087e     	bl	0x4000383c <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001650: 91395400     	add	x0, x0, #0xe55
40001654: 9400087a     	bl	0x4000383c <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 940004cc     	bl	0x40002990 <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 94000491     	bl	0x400028b0 <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001678: 9115c000     	add	x0, x0, #0x570
4000167c: 94000870     	bl	0x4000383c <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001688: 913d1800     	add	x0, x0, #0xf46
4000168c: 9400086c     	bl	0x4000383c <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: 90000055     	adrp	x21, 0x40009000 <__rodata_start>
40001698: 911402b5     	add	x21, x21, #0x500
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 9400084e     	bl	0x400037e0 <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 9400084b     	bl	0x400037e0 <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 94000849     	bl	0x400037e0 <uart_putc>
400016c0: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
400016c4: 910d2273     	add	x19, x19, #0x348
400016c8: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400016cc: 9125ca94     	add	x20, x20, #0x972
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 9400083d     	bl	0x400037e0 <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 9400083a     	bl	0x400037e0 <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 94000838     	bl	0x400037e0 <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 94000848     	bl	0x4000383c <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 94000844     	bl	0x4000383c <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001738: 9139e000     	add	x0, x0, #0xe78
4000173c: 94000840     	bl	0x4000383c <uart_puts>
40001740: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001744: 910e2400     	add	x0, x0, #0x389
40001748: 9400083d     	bl	0x4000383c <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001764: 91333800     	add	x0, x0, #0xcce
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 9400082e     	bl	0x4000383c <uart_puts>
40001788: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
4000178c: 913daa73     	add	x19, x19, #0xf6a
40001790: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40001794: 9107ba94     	add	x20, x20, #0x1ee
40001798: d0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
4000179c: 9128deb5     	add	x21, x21, #0xa37
400017a0: b0000056     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
400017a4: 910696d6     	add	x22, x22, #0x1a5
400017a8: d0000057     	adrp	x23, 0x4000b000 <__rodata_start+0x2000>
400017ac: 912a9af7     	add	x23, x23, #0xaa6
400017b0: d0000058     	adrp	x24, 0x4000b000 <__rodata_start+0x2000>
400017b4: 91199718     	add	x24, x24, #0x665
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: 90000059     	adrp	x25, 0x40009000 <__rodata_start>
400017c0: 9132db39     	add	x25, x25, #0xcb6
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000ca9     	bl	0x40004a70 <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 9400092e     	bl	0x40003c90 <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 94000817     	bl	0x4000383c <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 94000848     	bl	0x4000390c <uart_getc>
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
40001840: 940007e8     	bl	0x400037e0 <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 940007f9     	bl	0x4000383c <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 940007f6     	bl	0x4000383c <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 94000448     	bl	0x40002990 <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 94000348     	bl	0x4000259c <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 94000452     	bl	0x400029d0 <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 9400044e     	bl	0x400029d0 <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 9400044a     	bl	0x400029d0 <kstrcmp>
400018ac: 35fff8c0     	cbnz	w0, 0x400017c4 <kernel_shell+0x68>
400018b0: a9544ff4     	ldp	x20, x19, [sp, #0x140]
400018b4: a95357f6     	ldp	x22, x21, [sp, #0x130]
400018b8: a9525ff8     	ldp	x24, x23, [sp, #0x120]
400018bc: a95167fa     	ldp	x26, x25, [sp, #0x110]
400018c0: a9506ffc     	ldp	x28, x27, [sp, #0x100]
400018c4: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
400018c8: 910543ff     	add	sp, sp, #0x150
400018cc: d65f03c0     	ret

00000000400018d0 <test_arp>:
400018d0: d10203ff     	sub	sp, sp, #0x80
400018d4: 910033e0     	add	x0, sp, #0xc
400018d8: a9057bfd     	stp	x29, x30, [sp, #0x50]
400018dc: 910143fd     	add	x29, sp, #0x50
400018e0: a90657f6     	stp	x22, x21, [sp, #0x60]
400018e4: a9074ff4     	stp	x20, x19, [sp, #0x70]
400018e8: 2902ffff     	stp	wzr, wzr, [sp, #0x14]
400018ec: 2903ffff     	stp	wzr, wzr, [sp, #0x1c]
400018f0: 2904ffff     	stp	wzr, wzr, [sp, #0x24]
400018f4: 2905ffff     	stp	wzr, wzr, [sp, #0x2c]
400018f8: 2906ffff     	stp	wzr, wzr, [sp, #0x34]
400018fc: 2907ffff     	stp	wzr, wzr, [sp, #0x3c]
40001900: 2908ffff     	stp	wzr, wzr, [sp, #0x44]
40001904: b9004fff     	str	wzr, [sp, #0x4c]
40001908: 94001383     	bl	0x40006714 <virtio_net_get_mac>
4000190c: 12800008     	mov	w8, #-0x1               // =-1
40001910: 529fffe9     	mov	w9, #0xffff             // =65535
40001914: 5280c10e     	mov	w14, #0x608             // =1544
40001918: b90017e8     	str	w8, [sp, #0x14]
4000191c: 394037e8     	ldrb	w8, [sp, #0xd]
40001920: 5280010f     	mov	w15, #0x8               // =8
40001924: 394033ea     	ldrb	w10, [sp, #0xc]
40001928: 790033e9     	strh	w9, [sp, #0x18]
4000192c: 39403be9     	ldrb	w9, [sp, #0xe]
40001930: 39006fe8     	strb	w8, [sp, #0x1b]
40001934: 39403feb     	ldrb	w11, [sp, #0xf]
40001938: 394043ec     	ldrb	w12, [sp, #0x10]
4000193c: 3900afe8     	strb	w8, [sp, #0x2b]
40001940: 52800148     	mov	w8, #0xa                // =10
40001944: 394047ed     	ldrb	w13, [sp, #0x11]
40001948: 72a1e048     	movk	w8, #0xf02, lsl #16
4000194c: 72a0200e     	movk	w14, #0x100, lsl #16
40001950: 72a080cf     	movk	w15, #0x406, lsl #16
40001954: 29067fe8     	stp	w8, wzr, [sp, #0x30]
40001958: 52a00148     	mov	w8, #0xa0000            // =655360
4000195c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001960: 912a8000     	add	x0, x0, #0xaa0
40001964: 29043fee     	stp	w14, w15, [sp, #0x20]
40001968: 5280200e     	mov	w14, #0x100             // =256
4000196c: b9003be8     	str	w8, [sp, #0x38]
40001970: 52804048     	mov	w8, #0x202              // =514
40001974: 39006bea     	strb	w10, [sp, #0x1a]
40001978: 390073e9     	strb	w9, [sp, #0x1c]
4000197c: 390077eb     	strb	w11, [sp, #0x1d]
40001980: 39007bec     	strb	w12, [sp, #0x1e]
40001984: 39007fed     	strb	w13, [sp, #0x1f]
40001988: 790053ee     	strh	w14, [sp, #0x28]
4000198c: 3900abea     	strb	w10, [sp, #0x2a]
40001990: 3900b3e9     	strb	w9, [sp, #0x2c]
40001994: 3900b7eb     	strb	w11, [sp, #0x2d]
40001998: 3900bbec     	strb	w12, [sp, #0x2e]
4000199c: 3900bfed     	strb	w13, [sp, #0x2f]
400019a0: 79007be8     	strh	w8, [sp, #0x3c]
400019a4: 940007a6     	bl	0x4000383c <uart_puts>
400019a8: aa1f03f5     	mov	x21, xzr
400019ac: b0000053     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
400019b0: 9115f273     	add	x19, x19, #0x57c
400019b4: 910053f6     	add	x22, sp, #0x14
400019b8: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400019bc: 9125ca94     	add	x20, x20, #0x972
400019c0: 14000003     	b	0x400019cc <test_arp+0xfc>
400019c4: f100f2bf     	cmp	x21, #0x3c
400019c8: 54000140     	b.eq	0x400019f0 <test_arp+0x120>
400019cc: 38756ac1     	ldrb	w1, [x22, x21]
400019d0: aa1303e0     	mov	x0, x19
400019d4: 940008af     	bl	0x40003c90 <uart_printf>
400019d8: 910006b5     	add	x21, x21, #0x1
400019dc: f2400ebf     	tst	x21, #0xf
400019e0: 54ffff21     	b.ne	0x400019c4 <test_arp+0xf4>
400019e4: aa1403e0     	mov	x0, x20
400019e8: 94000795     	bl	0x4000383c <uart_puts>
400019ec: 17fffff6     	b	0x400019c4 <test_arp+0xf4>
400019f0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400019f4: 9125c800     	add	x0, x0, #0x972
400019f8: 94000791     	bl	0x4000383c <uart_puts>
400019fc: 910053e0     	add	x0, sp, #0x14
40001a00: 52800781     	mov	w1, #0x3c               // =60
40001a04: 940012bf     	bl	0x40006500 <virtio_net_send>
40001a08: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40001a0c: a94657f6     	ldp	x22, x21, [sp, #0x60]
40001a10: a9457bfd     	ldp	x29, x30, [sp, #0x50]
40001a14: 910203ff     	add	sp, sp, #0x80
40001a18: d65f03c0     	ret

0000000040001a1c <kmain>:
40001a1c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001a20: f9000bfc     	str	x28, [sp, #0x10]
40001a24: 910003fd     	mov	x29, sp
40001a28: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001a2c: d10803ff     	sub	sp, sp, #0x200
40001a30: 529c6c13     	mov	w19, #0xe360            // =58208
40001a34: 72a002d3     	movk	w19, #0x16, lsl #16
40001a38: 9400075e     	bl	0x400037b0 <uart_init>
40001a3c: d503201f     	nop
40001a40: 30044ca0     	adr	x0, 0x4000a3d5 <__rodata_start+0x13d5>
40001a44: 9400077e     	bl	0x4000383c <uart_puts>
40001a48: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001a4c: 91168800     	add	x0, x0, #0x5a2
40001a50: 9400077b     	bl	0x4000383c <uart_puts>
40001a54: b90003ff     	str	wzr, [sp]
40001a58: b94003e8     	ldr	w8, [sp]
40001a5c: 6b13011f     	cmp	w8, w19
40001a60: 540000aa     	b.ge	0x40001a74 <kmain+0x58>
40001a64: b94003e8     	ldr	w8, [sp]
40001a68: 11000508     	add	w8, w8, #0x1
40001a6c: b90003e8     	str	w8, [sp]
40001a70: 17fffffa     	b	0x40001a58 <kmain+0x3c>
40001a74: 528aa213     	mov	w19, #0x5510            // =21776
40001a78: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001a7c: 910d2800     	add	x0, x0, #0x34a
40001a80: 72a00453     	movk	w19, #0x22, lsl #16
40001a84: 9400076e     	bl	0x4000383c <uart_puts>
40001a88: b90003ff     	str	wzr, [sp]
40001a8c: b94003e8     	ldr	w8, [sp]
40001a90: 6b13011f     	cmp	w8, w19
40001a94: 540000aa     	b.ge	0x40001aa8 <kmain+0x8c>
40001a98: b94003e8     	ldr	w8, [sp]
40001a9c: 11000508     	add	w8, w8, #0x1
40001aa0: b90003e8     	str	w8, [sp]
40001aa4: 17fffffa     	b	0x40001a8c <kmain+0x70>
40001aa8: 5298d814     	mov	w20, #0xc6c0            // =50880
40001aac: 72a005b4     	movk	w20, #0x2d, lsl #16
40001ab0: 94000a84     	bl	0x400044c0 <vfs_init>
40001ab4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001ab8: 912adc00     	add	x0, x0, #0xab7
40001abc: 94000760     	bl	0x4000383c <uart_puts>
40001ac0: b90003ff     	str	wzr, [sp]
40001ac4: b94003e8     	ldr	w8, [sp]
40001ac8: 6b14011f     	cmp	w8, w20
40001acc: 540000aa     	b.ge	0x40001ae0 <kmain+0xc4>
40001ad0: b94003e8     	ldr	w8, [sp]
40001ad4: 11000508     	add	w8, w8, #0x1
40001ad8: b90003e8     	str	w8, [sp]
40001adc: 17fffffa     	b	0x40001ac4 <kmain+0xa8>
40001ae0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001ae4: 91087000     	add	x0, x0, #0x21c
40001ae8: d503201f     	nop
40001aec: 100328a8     	adr	x8, 0x40008000 <exception_vector_table>
40001af0: d518c008     	msr	VBAR_EL1, x8
40001af4: 94000752     	bl	0x4000383c <uart_puts>
40001af8: b90003ff     	str	wzr, [sp]
40001afc: b94003e8     	ldr	w8, [sp]
40001b00: 6b13011f     	cmp	w8, w19
40001b04: 540000aa     	b.ge	0x40001b18 <kmain+0xfc>
40001b08: b94003e8     	ldr	w8, [sp]
40001b0c: 11000508     	add	w8, w8, #0x1
40001b10: b90003e8     	str	w8, [sp]
40001b14: 17fffffa     	b	0x40001afc <kmain+0xe0>
40001b18: 97fff9bf     	bl	0x40000214 <gic_init>
40001b1c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001b20: 91254800     	add	x0, x0, #0x952
40001b24: 94000746     	bl	0x4000383c <uart_puts>
40001b28: b90003ff     	str	wzr, [sp]
40001b2c: b94003e8     	ldr	w8, [sp]
40001b30: 6b13011f     	cmp	w8, w19
40001b34: 540000aa     	b.ge	0x40001b48 <kmain+0x12c>
40001b38: b94003e8     	ldr	w8, [sp]
40001b3c: 11000508     	add	w8, w8, #0x1
40001b40: b90003e8     	str	w8, [sp]
40001b44: 17fffffa     	b	0x40001b2c <kmain+0x110>
40001b48: 94000445     	bl	0x40002c5c <timer_init>
40001b4c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001b50: 912e6000     	add	x0, x0, #0xb98
40001b54: 9400073a     	bl	0x4000383c <uart_puts>
40001b58: b90003ff     	str	wzr, [sp]
40001b5c: b94003e8     	ldr	w8, [sp]
40001b60: 6b13011f     	cmp	w8, w19
40001b64: 540000aa     	b.ge	0x40001b78 <kmain+0x15c>
40001b68: b94003e8     	ldr	w8, [sp]
40001b6c: 11000508     	add	w8, w8, #0x1
40001b70: b90003e8     	str	w8, [sp]
40001b74: 17fffffa     	b	0x40001b5c <kmain+0x140>
40001b78: 94000e17     	bl	0x400053d4 <pmm_init>
40001b7c: 94000eab     	bl	0x40005628 <sched_init>
40001b80: 94000f6a     	bl	0x40005928 <virtio_blk_init>
40001b84: 34000220     	cbz	w0, 0x40001bc8 <kmain+0x1ac>
40001b88: 910003e1     	mov	x1, sp
40001b8c: aa1f03e0     	mov	x0, xzr
40001b90: 94000fb0     	bl	0x40005a50 <virtio_blk_read_sector>
40001b94: 34000080     	cbz	w0, 0x40001ba4 <kmain+0x188>
40001b98: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001b9c: 913f5800     	add	x0, x0, #0xfd6
40001ba0: 94000727     	bl	0x4000383c <uart_puts>
40001ba4: 940012ef     	bl	0x40006760 <fat16_init>
40001ba8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001bac: 9137d400     	add	x0, x0, #0xdf5
40001bb0: 94000723     	bl	0x4000383c <uart_puts>
40001bb4: 94000e07     	bl	0x400053d0 <vfs_load>
40001bb8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001bbc: 911b6000     	add	x0, x0, #0x6d8
40001bc0: 9400071f     	bl	0x4000383c <uart_puts>
40001bc4: 940010e3     	bl	0x40005f50 <virtio_net_init>
40001bc8: 529e1013     	mov	w19, #0xf080            // =61568
40001bcc: d503201f     	nop
40001bd0: 10ff6780     	adr	x0, 0x400008c0 <system_idle_daemon>
40001bd4: 72a05f53     	movk	w19, #0x2fa, lsl #16
40001bd8: 94000ebb     	bl	0x400056c4 <sched_create_task>
40001bdc: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001be0: 911bdc00     	add	x0, x0, #0x6f7
40001be4: 94000716     	bl	0x4000383c <uart_puts>
40001be8: d50342ff     	msr	DAIFClr, #0x2
40001bec: b90003ff     	str	wzr, [sp]
40001bf0: b94003e8     	ldr	w8, [sp]
40001bf4: 6b13011f     	cmp	w8, w19
40001bf8: 54ffffaa     	b.ge	0x40001bec <kmain+0x1d0>
40001bfc: b94003e8     	ldr	w8, [sp]
40001c00: 11000508     	add	w8, w8, #0x1
40001c04: b90003e8     	str	w8, [sp]
40001c08: 17fffffa     	b	0x40001bf0 <kmain+0x1d4>

0000000040001c0c <kproj_execute>:
40001c0c: d10683ff     	sub	sp, sp, #0x1a0
40001c10: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001c14: 910603fd     	add	x29, sp, #0x180
40001c18: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001c1c: b40001c0     	cbz	x0, 0x40001c54 <kproj_execute+0x48>
40001c20: aa0003f3     	mov	x19, x0
40001c24: 9400035b     	bl	0x40002990 <kstrlen>
40001c28: b4000160     	cbz	x0, 0x40001c54 <kproj_execute+0x48>
40001c2c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001c30: 912a3c00     	add	x0, x0, #0xa8f
40001c34: aa1303e1     	mov	x1, x19
40001c38: 94000816     	bl	0x40003c90 <uart_printf>
40001c3c: aa1303e0     	mov	x0, x19
40001c40: 94000c65     	bl	0x40004dd4 <vfs_mkdir>
40001c44: 34000140     	cbz	w0, 0x40001c6c <kproj_execute+0x60>
40001c48: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001c4c: 912aac00     	add	x0, x0, #0xaab
40001c50: 14000003     	b	0x40001c5c <kproj_execute+0x50>
40001c54: d503201f     	nop
40001c58: 5004d180     	adr	x0, 0x4000b68a <__rodata_start+0x268a>
40001c5c: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001c60: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001c64: 910683ff     	add	sp, sp, #0x1a0
40001c68: 140006f5     	b	0x4000383c <uart_puts>
40001c6c: aa1303e0     	mov	x0, x19
40001c70: 94000c34     	bl	0x40004d40 <vfs_chdir>
40001c74: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001c78: 91082c00     	add	x0, x0, #0x20b
40001c7c: 94000c56     	bl	0x40004dd4 <vfs_mkdir>
40001c80: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001c84: 9123dc00     	add	x0, x0, #0x8f7
40001c88: 94000c53     	bl	0x40004dd4 <vfs_mkdir>
40001c8c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001c90: 9109a421     	add	x1, x1, #0x269
40001c94: 910203e0     	add	x0, sp, #0x80
40001c98: 9400036d     	bl	0x40002a4c <kstrcpy>
40001c9c: 910203e0     	add	x0, sp, #0x80
40001ca0: aa1303e1     	mov	x1, x19
40001ca4: 94000342     	bl	0x400029ac <kstrcat>
40001ca8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001cac: 91004c21     	add	x1, x1, #0x13
40001cb0: 910203e0     	add	x0, sp, #0x80
40001cb4: 9400033e     	bl	0x400029ac <kstrcat>
40001cb8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001cbc: 9126b000     	add	x0, x0, #0x9ac
40001cc0: 910203e1     	add	x1, sp, #0x80
40001cc4: 94000c9a     	bl	0x40004f2c <vfs_touch>
40001cc8: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001ccc: 910ebc00     	add	x0, x0, #0x3af
40001cd0: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001cd4: 9132ec21     	add	x1, x1, #0xcbb
40001cd8: 94000c95     	bl	0x40004f2c <vfs_touch>
40001cdc: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001ce0: 910d2021     	add	x1, x1, #0x348
40001ce4: 910003e0     	mov	x0, sp
40001ce8: 94000359     	bl	0x40002a4c <kstrcpy>
40001cec: 910003e0     	mov	x0, sp
40001cf0: aa1303e1     	mov	x1, x19
40001cf4: 9400032e     	bl	0x400029ac <kstrcat>
40001cf8: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001cfc: 912ddc21     	add	x1, x1, #0xb77
40001d00: 910003e0     	mov	x0, sp
40001d04: 9400032a     	bl	0x400029ac <kstrcat>
40001d08: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001d0c: 9100fc00     	add	x0, x0, #0x3f
40001d10: 910003e1     	mov	x1, sp
40001d14: 94000c86     	bl	0x40004f2c <vfs_touch>
40001d18: 94000c84     	bl	0x40004f28 <vfs_sync>
40001d1c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001d20: 91144400     	add	x0, x0, #0x511
40001d24: 940006c6     	bl	0x4000383c <uart_puts>
40001d28: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001d2c: 91150000     	add	x0, x0, #0x540
40001d30: aa1303e1     	mov	x1, x19
40001d34: 940007d7     	bl	0x40003c90 <uart_printf>
40001d38: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001d3c: 91083c00     	add	x0, x0, #0x20f
40001d40: 94000c00     	bl	0x40004d40 <vfs_chdir>
40001d44: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001d48: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001d4c: 910683ff     	add	sp, sp, #0x1a0
40001d50: d65f03c0     	ret

0000000040001d54 <process_init>:
40001d54: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001d58: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001d5c: f0000054     	adrp	x20, 0x4000c000 <next_pid>
40001d60: d503201f     	nop
40001d64: 10072793     	adr	x19, 0x40010254 <proc_table>
40001d68: b9400289     	ldr	w9, [x20]
40001d6c: 52800068     	mov	w8, #0x3                // =3
40001d70: b9002668     	str	w8, [x19, #0x24]
40001d74: d503201f     	nop
40001d78: 30047361     	adr	x1, 0x4000abe5 <__rodata_start+0x1be5>
40001d7c: b9005668     	str	w8, [x19, #0x54]
40001d80: 91001260     	add	x0, x19, #0x4
40001d84: 910003fd     	mov	x29, sp
40001d88: b9008668     	str	w8, [x19, #0x84]
40001d8c: b900b668     	str	w8, [x19, #0xb4]
40001d90: b900e668     	str	w8, [x19, #0xe4]
40001d94: b9011668     	str	w8, [x19, #0x114]
40001d98: b9014668     	str	w8, [x19, #0x144]
40001d9c: b9017668     	str	w8, [x19, #0x174]
40001da0: b901a668     	str	w8, [x19, #0x1a4]
40001da4: b901d668     	str	w8, [x19, #0x1d4]
40001da8: b9020668     	str	w8, [x19, #0x204]
40001dac: b9023668     	str	w8, [x19, #0x234]
40001db0: b9026668     	str	w8, [x19, #0x264]
40001db4: b9029668     	str	w8, [x19, #0x294]
40001db8: b902c668     	str	w8, [x19, #0x2c4]
40001dbc: b902f668     	str	w8, [x19, #0x2f4]
40001dc0: 11000528     	add	w8, w9, #0x1
40001dc4: f9000bf5     	str	x21, [sp, #0x10]
40001dc8: b900327f     	str	wzr, [x19, #0x30]
40001dcc: b900627f     	str	wzr, [x19, #0x60]
40001dd0: b900927f     	str	wzr, [x19, #0x90]
40001dd4: b900c27f     	str	wzr, [x19, #0xc0]
40001dd8: b900f27f     	str	wzr, [x19, #0xf0]
40001ddc: b901227f     	str	wzr, [x19, #0x120]
40001de0: b901527f     	str	wzr, [x19, #0x150]
40001de4: b901827f     	str	wzr, [x19, #0x180]
40001de8: b901b27f     	str	wzr, [x19, #0x1b0]
40001dec: b901e27f     	str	wzr, [x19, #0x1e0]
40001df0: b902127f     	str	wzr, [x19, #0x210]
40001df4: b902427f     	str	wzr, [x19, #0x240]
40001df8: b902727f     	str	wzr, [x19, #0x270]
40001dfc: b902a27f     	str	wzr, [x19, #0x2a0]
40001e00: b902d27f     	str	wzr, [x19, #0x2d0]
40001e04: b9000288     	str	w8, [x20]
40001e08: b9000269     	str	w9, [x19]
40001e0c: 94000310     	bl	0x40002a4c <kstrcpy>
40001e10: b9400288     	ldr	w8, [x20]
40001e14: 52a00209     	mov	w9, #0x100000           // =1048576
40001e18: 5280384a     	mov	w10, #0x1c2             // =450
40001e1c: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001e20: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001e24: 912b9021     	add	x1, x1, #0xae4
40001e28: 11000509     	add	w9, w8, #0x1
40001e2c: 9100d260     	add	x0, x19, #0x34
40001e30: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001e34: b9000289     	str	w9, [x20]
40001e38: 94000305     	bl	0x40002a4c <kstrcpy>
40001e3c: b9400288     	ldr	w8, [x20]
40001e40: 529d0009     	mov	w9, #0xe800             // =59392
40001e44: 52800035     	mov	w21, #0x1               // =1
40001e48: 72a00069     	movk	w9, #0x3, lsl #16
40001e4c: 5280018a     	mov	w10, #0xc               // =12
40001e50: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001e54: 912e6421     	add	x1, x1, #0xb99
40001e58: 290aa675     	stp	w21, w9, [x19, #0x54]
40001e5c: 11000509     	add	w9, w8, #0x1
40001e60: 91019260     	add	x0, x19, #0x64
40001e64: b9000289     	str	w9, [x20]
40001e68: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001e6c: 940002f8     	bl	0x40002a4c <kstrcpy>
40001e70: b9400288     	ldr	w8, [x20]
40001e74: 52a00809     	mov	w9, #0x400000           // =4194304
40001e78: 5280960a     	mov	w10, #0x4b0             // =1200
40001e7c: 2910a675     	stp	w21, w9, [x19, #0x84]
40001e80: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001e84: 91160021     	add	x1, x1, #0x580
40001e88: 11000509     	add	w9, w8, #0x1
40001e8c: 91025260     	add	x0, x19, #0x94
40001e90: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001e94: b9000289     	str	w9, [x20]
40001e98: 940002ed     	bl	0x40002a4c <kstrcpy>
40001e9c: 529a0008     	mov	w8, #0xd000             // =53248
40001ea0: 52800aa9     	mov	w9, #0x55               // =85
40001ea4: f9400bf5     	ldr	x21, [sp, #0x10]
40001ea8: 72a000e8     	movk	w8, #0x7, lsl #16
40001eac: b900be69     	str	w9, [x19, #0xbc]
40001eb0: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001eb4: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001eb8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001ebc: d65f03c0     	ret

0000000040001ec0 <process_kill>:
40001ec0: 7100041f     	cmp	w0, #0x1
40001ec4: 5400118b     	b.lt	0x400020f4 <process_kill+0x234>
40001ec8: d503201f     	nop
40001ecc: 10071c49     	adr	x9, 0x40010254 <proc_table>
40001ed0: b9400128     	ldr	w8, [x9]
40001ed4: 6b00011f     	cmp	w8, w0
40001ed8: 54000081     	b.ne	0x40001ee8 <process_kill+0x28>
40001edc: b9402528     	ldr	w8, [x9, #0x24]
40001ee0: 71000d1f     	cmp	w8, #0x3
40001ee4: 54000f41     	b.ne	0x400020cc <process_kill+0x20c>
40001ee8: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001eec: 910a1129     	add	x9, x9, #0x284
40001ef0: b9400128     	ldr	w8, [x9]
40001ef4: 6b00011f     	cmp	w8, w0
40001ef8: 54000081     	b.ne	0x40001f08 <process_kill+0x48>
40001efc: b9402528     	ldr	w8, [x9, #0x24]
40001f00: 71000d1f     	cmp	w8, #0x3
40001f04: 54000e41     	b.ne	0x400020cc <process_kill+0x20c>
40001f08: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f0c: 910ad129     	add	x9, x9, #0x2b4
40001f10: b9400128     	ldr	w8, [x9]
40001f14: 6b00011f     	cmp	w8, w0
40001f18: 54000081     	b.ne	0x40001f28 <process_kill+0x68>
40001f1c: b9402528     	ldr	w8, [x9, #0x24]
40001f20: 71000d1f     	cmp	w8, #0x3
40001f24: 54000d41     	b.ne	0x400020cc <process_kill+0x20c>
40001f28: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f2c: 910b9129     	add	x9, x9, #0x2e4
40001f30: b9400128     	ldr	w8, [x9]
40001f34: 6b00011f     	cmp	w8, w0
40001f38: 54000081     	b.ne	0x40001f48 <process_kill+0x88>
40001f3c: b9402528     	ldr	w8, [x9, #0x24]
40001f40: 71000d1f     	cmp	w8, #0x3
40001f44: 54000c41     	b.ne	0x400020cc <process_kill+0x20c>
40001f48: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f4c: 910c5129     	add	x9, x9, #0x314
40001f50: b9400128     	ldr	w8, [x9]
40001f54: 6b00011f     	cmp	w8, w0
40001f58: 54000081     	b.ne	0x40001f68 <process_kill+0xa8>
40001f5c: b9402528     	ldr	w8, [x9, #0x24]
40001f60: 71000d1f     	cmp	w8, #0x3
40001f64: 54000b41     	b.ne	0x400020cc <process_kill+0x20c>
40001f68: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f6c: 910d1129     	add	x9, x9, #0x344
40001f70: b9400128     	ldr	w8, [x9]
40001f74: 6b00011f     	cmp	w8, w0
40001f78: 54000081     	b.ne	0x40001f88 <process_kill+0xc8>
40001f7c: b9402528     	ldr	w8, [x9, #0x24]
40001f80: 71000d1f     	cmp	w8, #0x3
40001f84: 54000a41     	b.ne	0x400020cc <process_kill+0x20c>
40001f88: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f8c: 910dd129     	add	x9, x9, #0x374
40001f90: b9400128     	ldr	w8, [x9]
40001f94: 6b00011f     	cmp	w8, w0
40001f98: 54000081     	b.ne	0x40001fa8 <process_kill+0xe8>
40001f9c: b9402528     	ldr	w8, [x9, #0x24]
40001fa0: 71000d1f     	cmp	w8, #0x3
40001fa4: 54000941     	b.ne	0x400020cc <process_kill+0x20c>
40001fa8: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001fac: 910e9129     	add	x9, x9, #0x3a4
40001fb0: b9400128     	ldr	w8, [x9]
40001fb4: 6b00011f     	cmp	w8, w0
40001fb8: 54000081     	b.ne	0x40001fc8 <process_kill+0x108>
40001fbc: b9402528     	ldr	w8, [x9, #0x24]
40001fc0: 71000d1f     	cmp	w8, #0x3
40001fc4: 54000841     	b.ne	0x400020cc <process_kill+0x20c>
40001fc8: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001fcc: 910f5129     	add	x9, x9, #0x3d4
40001fd0: b9400128     	ldr	w8, [x9]
40001fd4: 6b00011f     	cmp	w8, w0
40001fd8: 54000081     	b.ne	0x40001fe8 <process_kill+0x128>
40001fdc: b9402528     	ldr	w8, [x9, #0x24]
40001fe0: 71000d1f     	cmp	w8, #0x3
40001fe4: 54000741     	b.ne	0x400020cc <process_kill+0x20c>
40001fe8: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001fec: 91101129     	add	x9, x9, #0x404
40001ff0: b9400128     	ldr	w8, [x9]
40001ff4: 6b00011f     	cmp	w8, w0
40001ff8: 54000081     	b.ne	0x40002008 <process_kill+0x148>
40001ffc: b9402528     	ldr	w8, [x9, #0x24]
40002000: 71000d1f     	cmp	w8, #0x3
40002004: 54000641     	b.ne	0x400020cc <process_kill+0x20c>
40002008: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000200c: 9110d129     	add	x9, x9, #0x434
40002010: b9400128     	ldr	w8, [x9]
40002014: 6b00011f     	cmp	w8, w0
40002018: 54000081     	b.ne	0x40002028 <process_kill+0x168>
4000201c: b9402528     	ldr	w8, [x9, #0x24]
40002020: 71000d1f     	cmp	w8, #0x3
40002024: 54000541     	b.ne	0x400020cc <process_kill+0x20c>
40002028: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000202c: 91119129     	add	x9, x9, #0x464
40002030: b9400128     	ldr	w8, [x9]
40002034: 6b00011f     	cmp	w8, w0
40002038: 54000081     	b.ne	0x40002048 <process_kill+0x188>
4000203c: b9402528     	ldr	w8, [x9, #0x24]
40002040: 71000d1f     	cmp	w8, #0x3
40002044: 54000441     	b.ne	0x400020cc <process_kill+0x20c>
40002048: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000204c: 91125129     	add	x9, x9, #0x494
40002050: b9400128     	ldr	w8, [x9]
40002054: 6b00011f     	cmp	w8, w0
40002058: 54000081     	b.ne	0x40002068 <process_kill+0x1a8>
4000205c: b9402528     	ldr	w8, [x9, #0x24]
40002060: 71000d1f     	cmp	w8, #0x3
40002064: 54000341     	b.ne	0x400020cc <process_kill+0x20c>
40002068: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000206c: 91131129     	add	x9, x9, #0x4c4
40002070: b9400128     	ldr	w8, [x9]
40002074: 6b00011f     	cmp	w8, w0
40002078: 54000081     	b.ne	0x40002088 <process_kill+0x1c8>
4000207c: b9402528     	ldr	w8, [x9, #0x24]
40002080: 71000d1f     	cmp	w8, #0x3
40002084: 54000241     	b.ne	0x400020cc <process_kill+0x20c>
40002088: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
4000208c: 9113d129     	add	x9, x9, #0x4f4
40002090: b9400128     	ldr	w8, [x9]
40002094: 6b00011f     	cmp	w8, w0
40002098: 54000081     	b.ne	0x400020a8 <process_kill+0x1e8>
4000209c: b9402528     	ldr	w8, [x9, #0x24]
400020a0: 71000d1f     	cmp	w8, #0x3
400020a4: 54000141     	b.ne	0x400020cc <process_kill+0x20c>
400020a8: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
400020ac: 91149129     	add	x9, x9, #0x524
400020b0: b9400128     	ldr	w8, [x9]
400020b4: 6b00011f     	cmp	w8, w0
400020b8: 12800008     	mov	w8, #-0x1               // =-1
400020bc: 54000281     	b.ne	0x4000210c <process_kill+0x24c>
400020c0: b940252a     	ldr	w10, [x9, #0x24]
400020c4: 71000d5f     	cmp	w10, #0x3
400020c8: 54000220     	b.eq	0x4000210c <process_kill+0x24c>
400020cc: 7100041f     	cmp	w0, #0x1
400020d0: 54000161     	b.ne	0x400020fc <process_kill+0x23c>
400020d4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400020d8: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
400020dc: 912b0000     	add	x0, x0, #0xac0
400020e0: 910003fd     	mov	x29, sp
400020e4: 940005d6     	bl	0x4000383c <uart_puts>
400020e8: 12800020     	mov	w0, #-0x2               // =-2
400020ec: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400020f0: d65f03c0     	ret
400020f4: 12800000     	mov	w0, #-0x1               // =-1
400020f8: d65f03c0     	ret
400020fc: 5280004a     	mov	w10, #0x2               // =2
40002100: 2a1f03e0     	mov	w0, wzr
40002104: b900252a     	str	w10, [x9, #0x24]
40002108: d65f03c0     	ret
4000210c: 2a0803e0     	mov	w0, w8
40002110: d65f03c0     	ret

0000000040002114 <launch_ktop>:
40002114: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002118: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000211c: 91220000     	add	x0, x0, #0x880
40002120: f9000bf7     	str	x23, [sp, #0x10]
40002124: a90257f6     	stp	x22, x21, [sp, #0x20]
40002128: 910003fd     	mov	x29, sp
4000212c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40002130: 940005c3     	bl	0x4000383c <uart_puts>
40002134: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002138: 912c1000     	add	x0, x0, #0xb04
4000213c: 940005c0     	bl	0x4000383c <uart_puts>
40002140: 2a1f03e8     	mov	w8, wzr
40002144: 2a1f03e1     	mov	w1, wzr
40002148: 52800209     	mov	w9, #0x10               // =16
4000214c: d000006a     	adrp	x10, 0x40010000 <__bss_start+0x3000>
40002150: 9109f14a     	add	x10, x10, #0x27c
40002154: 14000004     	b	0x40002164 <launch_ktop+0x50>
40002158: f1000529     	subs	x9, x9, #0x1
4000215c: 9100c14a     	add	x10, x10, #0x30
40002160: 54000120     	b.eq	0x40002184 <launch_ktop+0x70>
40002164: b85fc14b     	ldur	w11, [x10, #-0x4]
40002168: 121f796b     	and	w11, w11, #0xfffffffe
4000216c: 7100097f     	cmp	w11, #0x2
40002170: 54ffff40     	b.eq	0x40002158 <launch_ktop+0x44>
40002174: b940014b     	ldr	w11, [x10]
40002178: 11000421     	add	w1, w1, #0x1
4000217c: 0b080168     	add	w8, w11, w8
40002180: 17fffff6     	b	0x40002158 <launch_ktop+0x44>
40002184: 530a7d02     	lsr	w2, w8, #10
40002188: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000218c: 912e8c00     	add	x0, x0, #0xba3
40002190: 940006c0     	bl	0x40003c90 <uart_printf>
40002194: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002198: 91336c00     	add	x0, x0, #0xcdb
4000219c: 940005a8     	bl	0x4000383c <uart_puts>
400021a0: b0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400021a4: 9102c000     	add	x0, x0, #0xb0
400021a8: 940005a5     	bl	0x4000383c <uart_puts>
400021ac: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
400021b0: 910a0294     	add	x20, x20, #0x280
400021b4: b0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
400021b8: 9108aab5     	add	x21, x21, #0x22a
400021bc: d503201f     	nop
400021c0: 1004ca96     	adr	x22, 0x4000bb10 <__rodata_start+0x2b10>
400021c4: 52800217     	mov	w23, #0x10              // =16
400021c8: 90000053     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
400021cc: 911ce673     	add	x19, x19, #0x739
400021d0: 1400000a     	b	0x400021f8 <launch_ktop+0xe4>
400021d4: 297f9288     	ldp	w8, w4, [x20, #-0x4]
400021d8: b85d4281     	ldur	w1, [x20, #-0x2c]
400021dc: d100a285     	sub	x5, x20, #0x28
400021e0: aa1303e0     	mov	x0, x19
400021e4: 530a7d03     	lsr	w3, w8, #10
400021e8: 940006aa     	bl	0x40003c90 <uart_printf>
400021ec: f10006f7     	subs	x23, x23, #0x1
400021f0: 9100c294     	add	x20, x20, #0x30
400021f4: 54000120     	b.eq	0x40002218 <launch_ktop+0x104>
400021f8: b85f8288     	ldur	w8, [x20, #-0x8]
400021fc: 71000d1f     	cmp	w8, #0x3
40002200: 54ffff60     	b.eq	0x400021ec <launch_ktop+0xd8>
40002204: 7100091f     	cmp	w8, #0x2
40002208: aa1503e2     	mov	x2, x21
4000220c: 54fffe48     	b.hi	0x400021d4 <launch_ktop+0xc0>
40002210: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
40002214: 17fffff0     	b	0x400021d4 <launch_ktop+0xc0>
40002218: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000221c: 910d2c00     	add	x0, x0, #0x34b
40002220: 94000587     	bl	0x4000383c <uart_puts>
40002224: 52808114     	mov	w20, #0x408             // =1032
40002228: 52800033     	mov	w19, #0x1               // =1
4000222c: 72a02014     	movk	w20, #0x100, lsl #16
40002230: 14000003     	b	0x4000223c <launch_ktop+0x128>
40002234: 7101c51f     	cmp	w8, #0x71
40002238: 54000100     	b.eq	0x40002258 <launch_ktop+0x144>
4000223c: 940005b4     	bl	0x4000390c <uart_getc>
40002240: 12001c08     	and	w8, w0, #0xff
40002244: 7100611f     	cmp	w8, #0x18
40002248: 54ffff68     	b.hi	0x40002234 <launch_ktop+0x120>
4000224c: 1ac82269     	lsl	w9, w19, w8
40002250: 6a14013f     	tst	w9, w20
40002254: 54ffff00     	b.eq	0x40002234 <launch_ktop+0x120>
40002258: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000225c: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002260: 912f5800     	add	x0, x0, #0xbd6
40002264: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002268: f9400bf7     	ldr	x23, [sp, #0x10]
4000226c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002270: 14000573     	b	0x4000383c <uart_puts>

0000000040002274 <script_init>:
40002274: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002278: d0000068     	adrp	x8, 0x40010000 <__bss_start+0x3000>
4000227c: d503201f     	nop
40002280: 3003d4c0     	adr	x0, 0x40009d19 <__rodata_start+0xd19>
40002284: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40002288: 91344421     	add	x1, x1, #0xd11
4000228c: 910003fd     	mov	x29, sp
40002290: b905551f     	str	wzr, [x8, #0x554]
40002294: 94000007     	bl	0x400022b0 <script_set_var>
40002298: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000229c: 913f9000     	add	x0, x0, #0xfe4
400022a0: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400022a4: 9123f421     	add	x1, x1, #0x8fd
400022a8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400022ac: 14000001     	b	0x400022b0 <script_set_var>

00000000400022b0 <script_set_var>:
400022b0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400022b4: a9015ff8     	stp	x24, x23, [sp, #0x10]
400022b8: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
400022bc: 910003fd     	mov	x29, sp
400022c0: b94556e8     	ldr	w8, [x23, #0x554]
400022c4: a9034ff4     	stp	x20, x19, [sp, #0x30]
400022c8: aa0103f3     	mov	x19, x1
400022cc: aa0003f4     	mov	x20, x0
400022d0: a90257f6     	stp	x22, x21, [sp, #0x20]
400022d4: 7100051f     	cmp	w8, #0x1
400022d8: 5400024b     	b.lt	0x40002320 <script_set_var+0x70>
400022dc: aa1f03f8     	mov	x24, xzr
400022e0: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400022e4: 912562b5     	add	x21, x21, #0x958
400022e8: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
400022ec: 911562d6     	add	x22, x22, #0x558
400022f0: aa1603e0     	mov	x0, x22
400022f4: aa1403e1     	mov	x1, x20
400022f8: 940001b6     	bl	0x400029d0 <kstrcmp>
400022fc: 340003e0     	cbz	w0, 0x40002378 <script_set_var+0xc8>
40002300: b98556e8     	ldrsw	x8, [x23, #0x554]
40002304: 91000718     	add	x24, x24, #0x1
40002308: 910202b5     	add	x21, x21, #0x80
4000230c: 910082d6     	add	x22, x22, #0x20
40002310: eb08031f     	cmp	x24, x8
40002314: 54fffeeb     	b.lt	0x400022f0 <script_set_var+0x40>
40002318: 71007d1f     	cmp	w8, #0x1f
4000231c: 5400038c     	b.gt	0x4000238c <script_set_var+0xdc>
40002320: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
40002324: 911562b5     	add	x21, x21, #0x558
40002328: aa1403e1     	mov	x1, x20
4000232c: 93407d08     	sxtw	x8, w8
40002330: 528003e2     	mov	w2, #0x1f               // =31
40002334: 8b0816a0     	add	x0, x21, x8, lsl #5
40002338: 940001cc     	bl	0x40002a68 <kstrncpy>
4000233c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002340: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
40002344: 91256294     	add	x20, x20, #0x958
40002348: aa1303e1     	mov	x1, x19
4000234c: 52800fe2     	mov	w2, #0x7f               // =127
40002350: 8b0816a9     	add	x9, x21, x8, lsl #5
40002354: 8b081e80     	add	x0, x20, x8, lsl #7
40002358: 39007d3f     	strb	wzr, [x9, #0x1f]
4000235c: 940001c3     	bl	0x40002a68 <kstrncpy>
40002360: b98556e8     	ldrsw	x8, [x23, #0x554]
40002364: 8b081e89     	add	x9, x20, x8, lsl #7
40002368: 11000508     	add	w8, w8, #0x1
4000236c: b90556e8     	str	w8, [x23, #0x554]
40002370: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002374: 14000006     	b	0x4000238c <script_set_var+0xdc>
40002378: aa1503e0     	mov	x0, x21
4000237c: aa1303e1     	mov	x1, x19
40002380: 52800fe2     	mov	w2, #0x7f               // =127
40002384: 940001b9     	bl	0x40002a68 <kstrncpy>
40002388: 3901febf     	strb	wzr, [x21, #0x7f]
4000238c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002390: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002394: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002398: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000239c: d65f03c0     	ret

00000000400023a0 <script_get_var>:
400023a0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400023a4: a90257f6     	stp	x22, x21, [sp, #0x20]
400023a8: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
400023ac: 910003fd     	mov	x29, sp
400023b0: b94556c8     	ldr	w8, [x22, #0x554]
400023b4: a9015ff8     	stp	x24, x23, [sp, #0x10]
400023b8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400023bc: 7100051f     	cmp	w8, #0x1
400023c0: 540002ab     	b.lt	0x40002414 <script_get_var+0x74>
400023c4: aa0003f4     	mov	x20, x0
400023c8: aa1f03f7     	mov	x23, xzr
400023cc: d0000073     	adrp	x19, 0x40010000 <__bss_start+0x3000>
400023d0: 91256273     	add	x19, x19, #0x958
400023d4: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400023d8: 911562b5     	add	x21, x21, #0x558
400023dc: f0000038     	adrp	x24, 0x40009000 <__rodata_start>
400023e0: 9126d318     	add	x24, x24, #0x9b4
400023e4: aa1503e0     	mov	x0, x21
400023e8: aa1403e1     	mov	x1, x20
400023ec: 94000179     	bl	0x400029d0 <kstrcmp>
400023f0: 34000160     	cbz	w0, 0x4000241c <script_get_var+0x7c>
400023f4: b98556c8     	ldrsw	x8, [x22, #0x554]
400023f8: 910006f7     	add	x23, x23, #0x1
400023fc: 91020273     	add	x19, x19, #0x80
40002400: 910082b5     	add	x21, x21, #0x20
40002404: eb0802ff     	cmp	x23, x8
40002408: 54fffeeb     	b.lt	0x400023e4 <script_get_var+0x44>
4000240c: aa1803f3     	mov	x19, x24
40002410: 14000003     	b	0x4000241c <script_get_var+0x7c>
40002414: f0000033     	adrp	x19, 0x40009000 <__rodata_start>
40002418: 9126d273     	add	x19, x19, #0x9b4
4000241c: aa1303e0     	mov	x0, x19
40002420: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002424: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002428: a9415ff8     	ldp	x24, x23, [sp, #0x10]
4000242c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002430: d65f03c0     	ret

0000000040002434 <script_expand_vars>:
40002434: d10203ff     	sub	sp, sp, #0x80
40002438: a9036ffc     	stp	x28, x27, [sp, #0x30]
4000243c: 2a1f03fc     	mov	w28, wzr
40002440: a90467fa     	stp	x26, x25, [sp, #0x40]
40002444: f0000039     	adrp	x25, 0x40009000 <__rodata_start>
40002448: 9126d339     	add	x25, x25, #0x9b4
4000244c: a9055ff8     	stp	x24, x23, [sp, #0x50]
40002450: 910003f8     	mov	x24, sp
40002454: d000007a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
40002458: a90657f6     	stp	x22, x21, [sp, #0x60]
4000245c: 2a1f03f6     	mov	w22, wzr
40002460: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002464: aa0103f3     	mov	x19, x1
40002468: aa0003f4     	mov	x20, x0
4000246c: a9027bfd     	stp	x29, x30, [sp, #0x20]
40002470: 910083fd     	add	x29, sp, #0x20
40002474: 14000001     	b	0x40002478 <script_expand_vars+0x44>
40002478: 93407f89     	sxtw	x9, w28
4000247c: 38696a88     	ldrb	w8, [x20, x9]
40002480: 7100911f     	cmp	w8, #0x24
40002484: 540000e0     	b.eq	0x400024a0 <script_expand_vars+0x6c>
40002488: 34000788     	cbz	w8, 0x40002578 <script_expand_vars+0x144>
4000248c: 110006ca     	add	w10, w22, #0x1
40002490: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002494: 1100053c     	add	w28, w9, #0x1
40002498: 2a0a03f6     	mov	w22, w10
4000249c: 17fffff7     	b	0x40002478 <script_expand_vars+0x44>
400024a0: aa1f03e8     	mov	x8, xzr
400024a4: 14000005     	b	0x400024b8 <script_expand_vars+0x84>
400024a8: 9100050a     	add	x10, x8, #0x1
400024ac: 38286b09     	strb	w9, [x24, x8]
400024b0: d1000789     	sub	x9, x28, #0x1
400024b4: aa0a03e8     	mov	x8, x10
400024b8: 9100053c     	add	x28, x9, #0x1
400024bc: 14000004     	b	0x400024cc <script_expand_vars+0x98>
400024c0: f100791f     	cmp	x8, #0x1e
400024c4: 9100079c     	add	x28, x28, #0x1
400024c8: 54ffff09     	b.ls	0x400024a8 <script_expand_vars+0x74>
400024cc: 387c6a89     	ldrb	w9, [x20, x28]
400024d0: 121a792a     	and	w10, w9, #0xffffffdf
400024d4: 5101054a     	sub	w10, w10, #0x41
400024d8: 7100695f     	cmp	w10, #0x1a
400024dc: 54ffff23     	b.lo	0x400024c0 <script_expand_vars+0x8c>
400024e0: 71017d3f     	cmp	w9, #0x5f
400024e4: 54fffee0     	b.eq	0x400024c0 <script_expand_vars+0x8c>
400024e8: 5100c12a     	sub	w10, w9, #0x30
400024ec: 7100255f     	cmp	w10, #0x9
400024f0: 54fffe89     	b.ls	0x400024c0 <script_expand_vars+0x8c>
400024f4: b9455749     	ldr	w9, [x26, #0x554]
400024f8: 38286b1f     	strb	wzr, [x24, x8]
400024fc: 7100053f     	cmp	w9, #0x1
40002500: 5400028b     	b.lt	0x40002550 <script_expand_vars+0x11c>
40002504: aa1f03fb     	mov	x27, xzr
40002508: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
4000250c: 911562b5     	add	x21, x21, #0x558
40002510: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
40002514: 912562f7     	add	x23, x23, #0x958
40002518: 910003e1     	mov	x1, sp
4000251c: aa1503e0     	mov	x0, x21
40002520: 9400012c     	bl	0x400029d0 <kstrcmp>
40002524: 34000100     	cbz	w0, 0x40002544 <script_expand_vars+0x110>
40002528: b9855748     	ldrsw	x8, [x26, #0x554]
4000252c: 9100077b     	add	x27, x27, #0x1
40002530: 910202f7     	add	x23, x23, #0x80
40002534: 910082b5     	add	x21, x21, #0x20
40002538: eb08037f     	cmp	x27, x8
4000253c: 54fffeeb     	b.lt	0x40002518 <script_expand_vars+0xe4>
40002540: aa1903f7     	mov	x23, x25
40002544: 394002e8     	ldrb	w8, [x23]
40002548: 350000a8     	cbnz	w8, 0x4000255c <script_expand_vars+0x128>
4000254c: 17ffffcb     	b	0x40002478 <script_expand_vars+0x44>
40002550: aa1903f7     	mov	x23, x25
40002554: 394002e8     	ldrb	w8, [x23]
40002558: 34fff908     	cbz	w8, 0x40002478 <script_expand_vars+0x44>
4000255c: 8b36c269     	add	x9, x19, w22, sxtw
40002560: 910006ea     	add	x10, x23, #0x1
40002564: 38001528     	strb	w8, [x9], #0x1
40002568: 110006d6     	add	w22, w22, #0x1
4000256c: 38401548     	ldrb	w8, [x10], #0x1
40002570: 35ffffa8     	cbnz	w8, 0x40002564 <script_expand_vars+0x130>
40002574: 17ffffc1     	b	0x40002478 <script_expand_vars+0x44>
40002578: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
4000257c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40002580: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002584: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002588: a94467fa     	ldp	x26, x25, [sp, #0x40]
4000258c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40002590: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002594: 910203ff     	add	sp, sp, #0x80
40002598: d65f03c0     	ret

000000004000259c <script_execute_line>:
4000259c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400025a0: a9014ffc     	stp	x28, x19, [sp, #0x10]
400025a4: 910003fd     	mov	x29, sp
400025a8: d10803ff     	sub	sp, sp, #0x200
400025ac: 14000004     	b	0x400025bc <script_execute_line+0x20>
400025b0: 7100811f     	cmp	w8, #0x20
400025b4: 54000121     	b.ne	0x400025d8 <script_execute_line+0x3c>
400025b8: 91000400     	add	x0, x0, #0x1
400025bc: 39400008     	ldrb	w8, [x0]
400025c0: 71007d1f     	cmp	w8, #0x1f
400025c4: 54ffff6c     	b.gt	0x400025b0 <script_execute_line+0x14>
400025c8: 7100251f     	cmp	w8, #0x9
400025cc: 54ffff60     	b.eq	0x400025b8 <script_execute_line+0x1c>
400025d0: 34001668     	cbz	w8, 0x4000289c <script_execute_line+0x300>
400025d4: 14000003     	b	0x400025e0 <script_execute_line+0x44>
400025d8: 71008d1f     	cmp	w8, #0x23
400025dc: 54001600     	b.eq	0x4000289c <script_execute_line+0x300>
400025e0: 910403e1     	add	x1, sp, #0x100
400025e4: 910403f3     	add	x19, sp, #0x100
400025e8: 97ffff93     	bl	0x40002434 <script_expand_vars>
400025ec: 394403e9     	ldrb	w9, [sp, #0x100]
400025f0: 34001529     	cbz	w9, 0x40002894 <script_execute_line+0x2f8>
400025f4: 394407e8     	ldrb	w8, [sp, #0x101]
400025f8: aa1f03ea     	mov	x10, xzr
400025fc: 2a0903eb     	mov	w11, w9
40002600: 14000004     	b	0x40002610 <script_execute_line+0x74>
40002604: 9100054a     	add	x10, x10, #0x1
40002608: 386a6a6b     	ldrb	w11, [x19, x10]
4000260c: 340003cb     	cbz	w11, 0x40002684 <script_execute_line+0xe8>
40002610: b4ffffaa     	cbz	x10, 0x40002604 <script_execute_line+0x68>
40002614: 7100f57f     	cmp	w11, #0x3d
40002618: 54ffff61     	b.ne	0x40002604 <script_execute_line+0x68>
4000261c: 8b13014b     	add	x11, x10, x19
40002620: 385ff16c     	ldurb	w12, [x11, #-0x1]
40002624: 7100f59f     	cmp	w12, #0x3d
40002628: 54fffee0     	b.eq	0x40002604 <script_execute_line+0x68>
4000262c: 3940056b     	ldrb	w11, [x11, #0x1]
40002630: 7100f57f     	cmp	w11, #0x3d
40002634: 54fffe80     	b.eq	0x40002604 <script_execute_line+0x68>
40002638: aa1f03ec     	mov	x12, xzr
4000263c: 2a1f03eb     	mov	w11, wzr
40002640: 386c6a6d     	ldrb	w13, [x19, x12]
40002644: 9100058c     	add	x12, x12, #0x1
40002648: 710081bf     	cmp	w13, #0x20
4000264c: 1a9f156b     	csinc	w11, w11, wzr, ne
40002650: eb0c015f     	cmp	x10, x12
40002654: 54ffff61     	b.ne	0x40002640 <script_execute_line+0xa4>
40002658: 35fffd6b     	cbnz	w11, 0x40002604 <script_execute_line+0x68>
4000265c: 7101a53f     	cmp	w9, #0x69
40002660: 54fffd20     	b.eq	0x40002604 <script_execute_line+0x68>
40002664: 7101991f     	cmp	w8, #0x66
40002668: 54fffce0     	b.eq	0x40002604 <script_execute_line+0x68>
4000266c: 910403e8     	add	x8, sp, #0x100
40002670: 910403e0     	add	x0, sp, #0x100
40002674: 8b0a0101     	add	x1, x8, x10
40002678: 3800143f     	strb	wzr, [x1], #0x1
4000267c: 97ffff0d     	bl	0x400022b0 <script_set_var>
40002680: 14000087     	b	0x4000289c <script_execute_line+0x300>
40002684: 394403e9     	ldrb	w9, [sp, #0x100]
40002688: 7101a53f     	cmp	w9, #0x69
4000268c: 54001041     	b.ne	0x40002894 <script_execute_line+0x2f8>
40002690: 7101991f     	cmp	w8, #0x66
40002694: 54001001     	b.ne	0x40002894 <script_execute_line+0x2f8>
40002698: 39440be8     	ldrb	w8, [sp, #0x102]
4000269c: 7100811f     	cmp	w8, #0x20
400026a0: 54000fa1     	b.ne	0x40002894 <script_execute_line+0x2f8>
400026a4: 39440fe9     	ldrb	w9, [sp, #0x103]
400026a8: 7100813f     	cmp	w9, #0x20
400026ac: 54000081     	b.ne	0x400026bc <script_execute_line+0x120>
400026b0: aa1f03e9     	mov	x9, xzr
400026b4: 52800068     	mov	w8, #0x3                // =3
400026b8: 14000014     	b	0x40002708 <script_execute_line+0x16c>
400026bc: 910403ea     	add	x10, sp, #0x100
400026c0: aa1f03e8     	mov	x8, xzr
400026c4: 910303eb     	add	x11, sp, #0xc0
400026c8: 9100114a     	add	x10, x10, #0x4
400026cc: 34000189     	cbz	w9, 0x400026fc <script_execute_line+0x160>
400026d0: f100f91f     	cmp	x8, #0x3e
400026d4: 54000148     	b.hi	0x400026fc <script_execute_line+0x160>
400026d8: 38286969     	strb	w9, [x11, x8]
400026dc: 38686949     	ldrb	w9, [x10, x8]
400026e0: 9100050c     	add	x12, x8, #0x1
400026e4: aa0c03e8     	mov	x8, x12
400026e8: 7100813f     	cmp	w9, #0x20
400026ec: 54ffff01     	b.ne	0x400026cc <script_execute_line+0x130>
400026f0: 11000d8a     	add	w10, w12, #0x3
400026f4: 2a0c03e8     	mov	w8, w12
400026f8: 14000002     	b	0x40002700 <script_execute_line+0x164>
400026fc: 11000d0a     	add	w10, w8, #0x3
40002700: 2a0803e9     	mov	w9, w8
40002704: 2a0a03e8     	mov	w8, w10
40002708: 910303ea     	add	x10, sp, #0xc0
4000270c: 3829695f     	strb	wzr, [x10, x9]
40002710: 910403e9     	add	x9, sp, #0x100
40002714: 3868692a     	ldrb	w10, [x9, x8]
40002718: 7100815f     	cmp	w10, #0x20
4000271c: 54000061     	b.ne	0x40002728 <script_execute_line+0x18c>
40002720: 91000508     	add	x8, x8, #0x1
40002724: 17fffffc     	b	0x40002714 <script_execute_line+0x178>
40002728: 7100855f     	cmp	w10, #0x21
4000272c: 54000060     	b.eq	0x40002738 <script_execute_line+0x19c>
40002730: 7100f55f     	cmp	w10, #0x3d
40002734: 540000e1     	b.ne	0x40002750 <script_execute_line+0x1b4>
40002738: 11000509     	add	w9, w8, #0x1
4000273c: 910403ea     	add	x10, sp, #0x100
40002740: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002744: 9100090a     	add	x10, x8, #0x2
40002748: 7100f53f     	cmp	w9, #0x3d
4000274c: 9a880148     	csel	x8, x10, x8, eq
40002750: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002754: 910403ea     	add	x10, sp, #0x100
40002758: d2c0002b     	mov	x11, #0x100000000       // =4294967296
4000275c: 8b088129     	add	x9, x9, x8, lsl #32
40002760: 8b28c14a     	add	x10, x10, w8, sxtw
40002764: 51000508     	sub	w8, w8, #0x1
40002768: 3840154c     	ldrb	w12, [x10], #0x1
4000276c: 8b0b0129     	add	x9, x9, x11
40002770: 11000508     	add	w8, w8, #0x1
40002774: 7100819f     	cmp	w12, #0x20
40002778: 54ffff80     	b.eq	0x40002768 <script_execute_line+0x1cc>
4000277c: 9360fd2c     	asr	x12, x9, #32
40002780: 910403e9     	add	x9, sp, #0x100
40002784: 386c692d     	ldrb	w13, [x9, x12]
40002788: 710081bf     	cmp	w13, #0x20
4000278c: 54000061     	b.ne	0x40002798 <script_execute_line+0x1fc>
40002790: aa1f03ea     	mov	x10, xzr
40002794: 14000010     	b	0x400027d4 <script_execute_line+0x238>
40002798: aa1f03eb     	mov	x11, xzr
4000279c: 910203ec     	add	x12, sp, #0x80
400027a0: 3400016d     	cbz	w13, 0x400027cc <script_execute_line+0x230>
400027a4: f100f97f     	cmp	x11, #0x3e
400027a8: 54000128     	b.hi	0x400027cc <script_execute_line+0x230>
400027ac: 382b698d     	strb	w13, [x12, x11]
400027b0: 386b694d     	ldrb	w13, [x10, x11]
400027b4: 9100056e     	add	x14, x11, #0x1
400027b8: 11000508     	add	w8, w8, #0x1
400027bc: aa0e03eb     	mov	x11, x14
400027c0: 710081bf     	cmp	w13, #0x20
400027c4: 54fffee1     	b.ne	0x400027a0 <script_execute_line+0x204>
400027c8: 2a0e03eb     	mov	w11, w14
400027cc: 93407d0c     	sxtw	x12, w8
400027d0: 2a0b03ea     	mov	w10, w11
400027d4: d3607d8d     	lsl	x13, x12, #32
400027d8: 910203eb     	add	x11, sp, #0x80
400027dc: d2c0006f     	mov	x15, #0x300000000       // =12884901888
400027e0: d2c00050     	mov	x16, #0x200000000       // =8589934592
400027e4: d2c0002e     	mov	x14, #0x100000000       // =4294967296
400027e8: 11001108     	add	w8, w8, #0x4
400027ec: 382a697f     	strb	wzr, [x11, x10]
400027f0: 8b0f01aa     	add	x10, x13, x15
400027f4: 8b1001ab     	add	x11, x13, x16
400027f8: 8b0e01ad     	add	x13, x13, x14
400027fc: 8b0c0129     	add	x9, x9, x12
40002800: 3840152c     	ldrb	w12, [x9], #0x1
40002804: 7100819f     	cmp	w12, #0x20
40002808: 540000c1     	b.ne	0x40002820 <script_execute_line+0x284>
4000280c: 11000508     	add	w8, w8, #0x1
40002810: 8b0e014a     	add	x10, x10, x14
40002814: 8b0e016b     	add	x11, x11, x14
40002818: 8b0e01ad     	add	x13, x13, x14
4000281c: 17fffff9     	b	0x40002800 <script_execute_line+0x264>
40002820: 7101d19f     	cmp	w12, #0x74
40002824: 54000381     	b.ne	0x40002894 <script_execute_line+0x2f8>
40002828: 9360fdac     	asr	x12, x13, #32
4000282c: 910403e9     	add	x9, sp, #0x100
40002830: 386c692c     	ldrb	w12, [x9, x12]
40002834: 7101a19f     	cmp	w12, #0x68
40002838: 540002e1     	b.ne	0x40002894 <script_execute_line+0x2f8>
4000283c: 9360fd6b     	asr	x11, x11, #32
40002840: 386b6929     	ldrb	w9, [x9, x11]
40002844: 7101953f     	cmp	w9, #0x65
40002848: 54000261     	b.ne	0x40002894 <script_execute_line+0x2f8>
4000284c: 9360fd4a     	asr	x10, x10, #32
40002850: 910403e9     	add	x9, sp, #0x100
40002854: 386a692a     	ldrb	w10, [x9, x10]
40002858: 7101b95f     	cmp	w10, #0x6e
4000285c: 540001c1     	b.ne	0x40002894 <script_execute_line+0x2f8>
40002860: 8b28c128     	add	x8, x9, w8, sxtw
40002864: d1000501     	sub	x1, x8, #0x1
40002868: 38401c28     	ldrb	w8, [x1, #0x1]!
4000286c: 7100811f     	cmp	w8, #0x20
40002870: 54ffffc0     	b.eq	0x40002868 <script_execute_line+0x2cc>
40002874: 910003e0     	mov	x0, sp
40002878: 94000075     	bl	0x40002a4c <kstrcpy>
4000287c: 910303e0     	add	x0, sp, #0xc0
40002880: 910203e1     	add	x1, sp, #0x80
40002884: 94000053     	bl	0x400029d0 <kstrcmp>
40002888: 350000a0     	cbnz	w0, 0x4000289c <script_execute_line+0x300>
4000288c: 910003e0     	mov	x0, sp
40002890: 14000002     	b	0x40002898 <script_execute_line+0x2fc>
40002894: 910403e0     	add	x0, sp, #0x100
40002898: 97fff969     	bl	0x40000e3c <execute_command>
4000289c: 2a1f03e0     	mov	w0, wzr
400028a0: 910803ff     	add	sp, sp, #0x200
400028a4: a9414ffc     	ldp	x28, x19, [sp, #0x10]
400028a8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400028ac: d65f03c0     	ret

00000000400028b0 <script_run_file>:
400028b0: d10503ff     	sub	sp, sp, #0x140
400028b4: a9107bfd     	stp	x29, x30, [sp, #0x100]
400028b8: 910403fd     	add	x29, sp, #0x100
400028bc: f9008bfc     	str	x28, [sp, #0x110]
400028c0: a91257f6     	stp	x22, x21, [sp, #0x120]
400028c4: a9134ff4     	stp	x20, x19, [sp, #0x130]
400028c8: aa0003f4     	mov	x20, x0
400028cc: 940008b8     	bl	0x40004bac <vfs_find>
400028d0: b4000080     	cbz	x0, 0x400028e0 <script_run_file+0x30>
400028d4: b9402008     	ldr	w8, [x0, #0x20]
400028d8: aa0003f3     	mov	x19, x0
400028dc: 340000e8     	cbz	w8, 0x400028f8 <script_run_file+0x48>
400028e0: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400028e4: 91089800     	add	x0, x0, #0x226
400028e8: aa1403e1     	mov	x1, x20
400028ec: 940004e9     	bl	0x40003c90 <uart_printf>
400028f0: 12800000     	mov	w0, #-0x1               // =-1
400028f4: 14000021     	b	0x40002978 <script_run_file+0xc8>
400028f8: f9401668     	ldr	x8, [x19, #0x28]
400028fc: aa1f03f4     	mov	x20, xzr
40002900: 2a1f03e9     	mov	w9, wzr
40002904: 9100c275     	add	x21, x19, #0x30
40002908: 910003f6     	mov	x22, sp
4000290c: 14000008     	b	0x4000292c <script_run_file+0x7c>
40002910: 7100053f     	cmp	w9, #0x1
40002914: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002918: 2a1f03e9     	mov	w9, wzr
4000291c: 5400022a     	b.ge	0x40002960 <script_run_file+0xb0>
40002920: 91000694     	add	x20, x20, #0x1
40002924: eb08029f     	cmp	x20, x8
40002928: 54000268     	b.hi	0x40002974 <script_run_file+0xc4>
4000292c: eb08029f     	cmp	x20, x8
40002930: 54ffff00     	b.eq	0x40002910 <script_run_file+0x60>
40002934: 38746aaa     	ldrb	w10, [x21, x20]
40002938: 7100295f     	cmp	w10, #0xa
4000293c: 54fffea0     	b.eq	0x40002910 <script_run_file+0x60>
40002940: 7100355f     	cmp	w10, #0xd
40002944: 54fffee0     	b.eq	0x40002920 <script_run_file+0x70>
40002948: 7103f93f     	cmp	w9, #0xfe
4000294c: 54fffeac     	b.gt	0x40002920 <script_run_file+0x70>
40002950: 1100052b     	add	w11, w9, #0x1
40002954: 3829caca     	strb	w10, [x22, w9, sxtw]
40002958: 2a0b03e9     	mov	w9, w11
4000295c: 17fffff1     	b	0x40002920 <script_run_file+0x70>
40002960: 910003e0     	mov	x0, sp
40002964: 97ffff0e     	bl	0x4000259c <script_execute_line>
40002968: f9401668     	ldr	x8, [x19, #0x28]
4000296c: 2a1f03e9     	mov	w9, wzr
40002970: 17ffffec     	b	0x40002920 <script_run_file+0x70>
40002974: 2a1f03e0     	mov	w0, wzr
40002978: a9534ff4     	ldp	x20, x19, [sp, #0x130]
4000297c: f9408bfc     	ldr	x28, [sp, #0x110]
40002980: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002984: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002988: 910503ff     	add	sp, sp, #0x140
4000298c: d65f03c0     	ret

0000000040002990 <kstrlen>:
40002990: b40000c0     	cbz	x0, 0x400029a8 <kstrlen+0x18>
40002994: aa1f03e8     	mov	x8, xzr
40002998: 38686809     	ldrb	w9, [x0, x8]
4000299c: 91000508     	add	x8, x8, #0x1
400029a0: 35ffffc9     	cbnz	w9, 0x40002998 <kstrlen+0x8>
400029a4: d1000500     	sub	x0, x8, #0x1
400029a8: d65f03c0     	ret

00000000400029ac <kstrcat>:
400029ac: b4000100     	cbz	x0, 0x400029cc <kstrcat+0x20>
400029b0: b40000e1     	cbz	x1, 0x400029cc <kstrcat+0x20>
400029b4: d1000408     	sub	x8, x0, #0x1
400029b8: 38401d09     	ldrb	w9, [x8, #0x1]!
400029bc: 35ffffe9     	cbnz	w9, 0x400029b8 <kstrcat+0xc>
400029c0: 38401429     	ldrb	w9, [x1], #0x1
400029c4: 38001509     	strb	w9, [x8], #0x1
400029c8: 35ffffc9     	cbnz	w9, 0x400029c0 <kstrcat+0x14>
400029cc: d65f03c0     	ret

00000000400029d0 <kstrcmp>:
400029d0: aa0003e8     	mov	x8, x0
400029d4: 12800000     	mov	w0, #-0x1               // =-1
400029d8: b4000188     	cbz	x8, 0x40002a08 <kstrcmp+0x38>
400029dc: b4000161     	cbz	x1, 0x40002a08 <kstrcmp+0x38>
400029e0: 38401509     	ldrb	w9, [x8], #0x1
400029e4: 340000e9     	cbz	w9, 0x40002a00 <kstrcmp+0x30>
400029e8: 3940002a     	ldrb	w10, [x1]
400029ec: 6b0a013f     	cmp	w9, w10
400029f0: 54000081     	b.ne	0x40002a00 <kstrcmp+0x30>
400029f4: 38401509     	ldrb	w9, [x8], #0x1
400029f8: 91000421     	add	x1, x1, #0x1
400029fc: 35ffff69     	cbnz	w9, 0x400029e8 <kstrcmp+0x18>
40002a00: 39400028     	ldrb	w8, [x1]
40002a04: 4b080120     	sub	w0, w9, w8
40002a08: d65f03c0     	ret

0000000040002a0c <kstrncmp>:
40002a0c: 12800008     	mov	w8, #-0x1               // =-1
40002a10: b4000160     	cbz	x0, 0x40002a3c <kstrncmp+0x30>
40002a14: b4000141     	cbz	x1, 0x40002a3c <kstrncmp+0x30>
40002a18: b4000102     	cbz	x2, 0x40002a38 <kstrncmp+0x2c>
40002a1c: 38401408     	ldrb	w8, [x0], #0x1
40002a20: 38401429     	ldrb	w9, [x1], #0x1
40002a24: 34000108     	cbz	w8, 0x40002a44 <kstrncmp+0x38>
40002a28: 6b09011f     	cmp	w8, w9
40002a2c: 540000c1     	b.ne	0x40002a44 <kstrncmp+0x38>
40002a30: f1000442     	subs	x2, x2, #0x1
40002a34: 54ffff41     	b.ne	0x40002a1c <kstrncmp+0x10>
40002a38: 2a1f03e8     	mov	w8, wzr
40002a3c: 2a0803e0     	mov	w0, w8
40002a40: d65f03c0     	ret
40002a44: 4b090100     	sub	w0, w8, w9
40002a48: d65f03c0     	ret

0000000040002a4c <kstrcpy>:
40002a4c: b40000c0     	cbz	x0, 0x40002a64 <kstrcpy+0x18>
40002a50: b40000a1     	cbz	x1, 0x40002a64 <kstrcpy+0x18>
40002a54: aa0003e8     	mov	x8, x0
40002a58: 38401429     	ldrb	w9, [x1], #0x1
40002a5c: 38001509     	strb	w9, [x8], #0x1
40002a60: 35ffffc9     	cbnz	w9, 0x40002a58 <kstrcpy+0xc>
40002a64: d65f03c0     	ret

0000000040002a68 <kstrncpy>:
40002a68: b4000480     	cbz	x0, 0x40002af8 <kstrncpy+0x90>
40002a6c: b4000461     	cbz	x1, 0x40002af8 <kstrncpy+0x90>
40002a70: b4000442     	cbz	x2, 0x40002af8 <kstrncpy+0x90>
40002a74: aa1f03e9     	mov	x9, xzr
40002a78: aa0203e8     	mov	x8, x2
40002a7c: 3869682a     	ldrb	w10, [x1, x9]
40002a80: 3829680a     	strb	w10, [x0, x9]
40002a84: 340000ca     	cbz	w10, 0x40002a9c <kstrncpy+0x34>
40002a88: 91000529     	add	x9, x9, #0x1
40002a8c: d1000508     	sub	x8, x8, #0x1
40002a90: eb09005f     	cmp	x2, x9
40002a94: 54ffff41     	b.ne	0x40002a7c <kstrncpy+0x14>
40002a98: 14000018     	b	0x40002af8 <kstrncpy+0x90>
40002a9c: cb09004a     	sub	x10, x2, x9
40002aa0: 8b090009     	add	x9, x0, x9
40002aa4: f100095f     	cmp	x10, #0x2
40002aa8: 54000082     	b.hs	0x40002ab8 <kstrncpy+0x50>
40002aac: 91000528     	add	x8, x9, #0x1
40002ab0: aa0a03e9     	mov	x9, x10
40002ab4: 1400000e     	b	0x40002aec <kstrncpy+0x84>
40002ab8: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002abc: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002ac0: 9100092c     	add	x12, x9, #0x2
40002ac4: 8b090108     	add	x8, x8, x9
40002ac8: 92400149     	and	x9, x10, #0x1
40002acc: aa0b03ed     	mov	x13, x11
40002ad0: 91000508     	add	x8, x8, #0x1
40002ad4: f10009ad     	subs	x13, x13, #0x2
40002ad8: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002adc: 3800259f     	strb	wzr, [x12], #0x2
40002ae0: 54ffffa1     	b.ne	0x40002ad4 <kstrncpy+0x6c>
40002ae4: eb0b015f     	cmp	x10, x11
40002ae8: 54000080     	b.eq	0x40002af8 <kstrncpy+0x90>
40002aec: f1000529     	subs	x9, x9, #0x1
40002af0: 3800151f     	strb	wzr, [x8], #0x1
40002af4: 54ffffc1     	b.ne	0x40002aec <kstrncpy+0x84>
40002af8: d65f03c0     	ret

0000000040002afc <memset>:
40002afc: b40002a0     	cbz	x0, 0x40002b50 <memset+0x54>
40002b00: b4000282     	cbz	x2, 0x40002b50 <memset+0x54>
40002b04: f100085f     	cmp	x2, #0x2
40002b08: 54000082     	b.hs	0x40002b18 <memset+0x1c>
40002b0c: aa0003e8     	mov	x8, x0
40002b10: aa0203e9     	mov	x9, x2
40002b14: 1400000c     	b	0x40002b44 <memset+0x48>
40002b18: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
40002b1c: 92400049     	and	x9, x2, #0x1
40002b20: 9100040b     	add	x11, x0, #0x1
40002b24: 8b0a0008     	add	x8, x0, x10
40002b28: aa0a03ec     	mov	x12, x10
40002b2c: f100098c     	subs	x12, x12, #0x2
40002b30: 381ff161     	sturb	w1, [x11, #-0x1]
40002b34: 38002561     	strb	w1, [x11], #0x2
40002b38: 54ffffa1     	b.ne	0x40002b2c <memset+0x30>
40002b3c: eb0a005f     	cmp	x2, x10
40002b40: 54000080     	b.eq	0x40002b50 <memset+0x54>
40002b44: f1000529     	subs	x9, x9, #0x1
40002b48: 38001501     	strb	w1, [x8], #0x1
40002b4c: 54ffffc1     	b.ne	0x40002b44 <memset+0x48>
40002b50: d65f03c0     	ret

0000000040002b54 <memcpy>:
40002b54: b4000100     	cbz	x0, 0x40002b74 <memcpy+0x20>
40002b58: b40000e1     	cbz	x1, 0x40002b74 <memcpy+0x20>
40002b5c: b40000c2     	cbz	x2, 0x40002b74 <memcpy+0x20>
40002b60: aa0003e8     	mov	x8, x0
40002b64: 38401429     	ldrb	w9, [x1], #0x1
40002b68: f1000442     	subs	x2, x2, #0x1
40002b6c: 38001509     	strb	w9, [x8], #0x1
40002b70: 54ffffa1     	b.ne	0x40002b64 <memcpy+0x10>
40002b74: d65f03c0     	ret

0000000040002b78 <kstrstr>:
40002b78: aa1f03e2     	mov	x2, xzr
40002b7c: b40000e0     	cbz	x0, 0x40002b98 <kstrstr+0x20>
40002b80: b40000c1     	cbz	x1, 0x40002b98 <kstrstr+0x20>
40002b84: 39400028     	ldrb	w8, [x1]
40002b88: 340002c8     	cbz	w8, 0x40002be0 <kstrstr+0x68>
40002b8c: 39400009     	ldrb	w9, [x0]
40002b90: 35000109     	cbnz	w9, 0x40002bb0 <kstrstr+0x38>
40002b94: aa1f03e2     	mov	x2, xzr
40002b98: aa0203e0     	mov	x0, x2
40002b9c: d65f03c0     	ret
40002ba0: 3940012c     	ldrb	w12, [x9]
40002ba4: 340001ec     	cbz	w12, 0x40002be0 <kstrstr+0x68>
40002ba8: 38401c09     	ldrb	w9, [x0, #0x1]!
40002bac: 34ffff49     	cbz	w9, 0x40002b94 <kstrstr+0x1c>
40002bb0: 6b08013f     	cmp	w9, w8
40002bb4: 54ffffa1     	b.ne	0x40002ba8 <kstrstr+0x30>
40002bb8: 5280002a     	mov	w10, #0x1               // =1
40002bbc: aa0103e9     	mov	x9, x1
40002bc0: 2a0803eb     	mov	w11, w8
40002bc4: 3840152c     	ldrb	w12, [x9], #0x1
40002bc8: 6b0c017f     	cmp	w11, w12
40002bcc: 54fffec1     	b.ne	0x40002ba4 <kstrstr+0x2c>
40002bd0: 386a680b     	ldrb	w11, [x0, x10]
40002bd4: 9100054a     	add	x10, x10, #0x1
40002bd8: 35ffff6b     	cbnz	w11, 0x40002bc4 <kstrstr+0x4c>
40002bdc: 17fffff1     	b	0x40002ba0 <kstrstr+0x28>
40002be0: d65f03c0     	ret

0000000040002be4 <kstrchr>:
40002be4: b4000140     	cbz	x0, 0x40002c0c <kstrchr+0x28>
40002be8: 39400009     	ldrb	w9, [x0]
40002bec: 340000c9     	cbz	w9, 0x40002c04 <kstrchr+0x20>
40002bf0: 12001c28     	and	w8, w1, #0xff
40002bf4: 6b08013f     	cmp	w9, w8
40002bf8: 540000a0     	b.eq	0x40002c0c <kstrchr+0x28>
40002bfc: 38401c09     	ldrb	w9, [x0, #0x1]!
40002c00: 35ffffa9     	cbnz	w9, 0x40002bf4 <kstrchr+0x10>
40002c04: 72001c3f     	tst	w1, #0xff
40002c08: 9a9f0000     	csel	x0, x0, xzr, eq
40002c0c: d65f03c0     	ret

0000000040002c10 <ktolower>:
40002c10: 51010408     	sub	w8, w0, #0x41
40002c14: 321b0009     	orr	w9, w0, #0x20
40002c18: 7100691f     	cmp	w8, #0x1a
40002c1c: 1a803120     	csel	w0, w9, w0, lo
40002c20: d65f03c0     	ret

0000000040002c24 <kstr_tolower>:
40002c24: b40001a0     	cbz	x0, 0x40002c58 <kstr_tolower+0x34>
40002c28: b4000181     	cbz	x1, 0x40002c58 <kstr_tolower+0x34>
40002c2c: 39400029     	ldrb	w9, [x1]
40002c30: 34000129     	cbz	w9, 0x40002c54 <kstr_tolower+0x30>
40002c34: 91000428     	add	x8, x1, #0x1
40002c38: 5101052a     	sub	w10, w9, #0x41
40002c3c: 321b012b     	orr	w11, w9, #0x20
40002c40: 7100695f     	cmp	w10, #0x1a
40002c44: 1a893169     	csel	w9, w11, w9, lo
40002c48: 38001409     	strb	w9, [x0], #0x1
40002c4c: 38401509     	ldrb	w9, [x8], #0x1
40002c50: 35ffff49     	cbnz	w9, 0x40002c38 <kstr_tolower+0x14>
40002c54: 3900001f     	strb	wzr, [x0]
40002c58: d65f03c0     	ret

0000000040002c5c <timer_init>:
40002c5c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002c60: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002c64: f9000bf3     	str	x19, [sp, #0x10]
40002c68: d53be008     	mrs	x8, CNTFRQ_EL0
40002c6c: f29999a9     	movk	x9, #0xcccd
40002c70: f0000073     	adrp	x19, 0x40011000 <var_values+0x6a8>
40002c74: 528003c0     	mov	w0, #0x1e               // =30
40002c78: 9bc97d09     	umulh	x9, x8, x9
40002c7c: 910003fd     	mov	x29, sp
40002c80: 5280002a     	mov	w10, #0x1               // =1
40002c84: f904ae68     	str	x8, [x19, #0x958]
40002c88: d343fd29     	lsr	x9, x9, #3
40002c8c: d51be209     	msr	CNTP_TVAL_EL0, x9
40002c90: d51be22a     	msr	CNTP_CTL_EL0, x10
40002c94: 97fff56b     	bl	0x40000240 <gic_enable_interrupt>
40002c98: d50342ff     	msr	DAIFClr, #0x2
40002c9c: d503201f     	nop
40002ca0: 100447e0     	adr	x0, 0x4000b59c <__rodata_start+0x259c>
40002ca4: b9495a61     	ldr	w1, [x19, #0x958]
40002ca8: f9400bf3     	ldr	x19, [sp, #0x10]
40002cac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002cb0: 140003f8     	b	0x40003c90 <uart_printf>

0000000040002cb4 <timer_handle_interrupt>:
40002cb4: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002cb8: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002cbc: f944ad08     	ldr	x8, [x8, #0x958]
40002cc0: f29999a9     	movk	x9, #0xcccd
40002cc4: 9bc97d08     	umulh	x8, x8, x9
40002cc8: f0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40002ccc: f944b12a     	ldr	x10, [x9, #0x960]
40002cd0: 9100054a     	add	x10, x10, #0x1
40002cd4: f904b12a     	str	x10, [x9, #0x960]
40002cd8: d343fd08     	lsr	x8, x8, #3
40002cdc: d51be208     	msr	CNTP_TVAL_EL0, x8
40002ce0: d65f03c0     	ret

0000000040002ce4 <tui_launch>:
40002ce4: d105c3ff     	sub	sp, sp, #0x170
40002ce8: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002cec: 910443fd     	add	x29, sp, #0x110
40002cf0: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002cf4: a91367fa     	stp	x26, x25, [sp, #0x130]
40002cf8: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002cfc: a91557f6     	stp	x22, x21, [sp, #0x150]
40002d00: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002d04: 94000758     	bl	0x40004a64 <vfs_get_cwd>
40002d08: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002d0c: f000007c     	adrp	x28, 0x40011000 <var_values+0x6a8>
40002d10: f000007b     	adrp	x27, 0x40011000 <var_values+0x6a8>
40002d14: f904b500     	str	x0, [x8, #0x968]
40002d18: d503201f     	nop
40002d1c: 5003f140     	adr	x0, 0x4000ab46 <__rodata_start+0x1b46>
40002d20: b909739f     	str	wzr, [x28, #0x970]
40002d24: b909777f     	str	wzr, [x27, #0x974]
40002d28: 940002c5     	bl	0x4000383c <uart_puts>
40002d2c: f0000036     	adrp	x22, 0x40009000 <__rodata_start>
40002d30: 91121ad6     	add	x22, x22, #0x486
40002d34: f0000037     	adrp	x23, 0x40009000 <__rodata_start>
40002d38: 910d22f7     	add	x23, x23, #0x348
40002d3c: f0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40002d40: 91260318     	add	x24, x24, #0x980
40002d44: f000007a     	adrp	x26, 0x40011000 <var_values+0x6a8>
40002d48: f0000034     	adrp	x20, 0x40009000 <__rodata_start>
40002d4c: 91159e94     	add	x20, x20, #0x567
40002d50: 14000005     	b	0x40002d64 <tui_launch+0x80>
40002d54: b9497388     	ldr	w8, [x28, #0x970]
40002d58: 7100011f     	cmp	w8, #0x0
40002d5c: 1a9f17e8     	cset	w8, eq
40002d60: b9097388     	str	w8, [x28, #0x970]
40002d64: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002d68: b9097b5f     	str	wzr, [x26, #0x978]
40002d6c: f944b50a     	ldr	x10, [x8, #0x968]
40002d70: f9421948     	ldr	x8, [x10, #0x430]
40002d74: b4000108     	cbz	x8, 0x40002d94 <tui_launch+0xb0>
40002d78: 52800029     	mov	w9, #0x1                // =1
40002d7c: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002d80: b9097b49     	str	w9, [x26, #0x978]
40002d84: f904c11f     	str	xzr, [x8, #0x980]
40002d88: f9401548     	ldr	x8, [x10, #0x28]
40002d8c: b50000a8     	cbnz	x8, 0x40002da0 <tui_launch+0xbc>
40002d90: 14000027     	b	0x40002e2c <tui_launch+0x148>
40002d94: 2a1f03e9     	mov	w9, wzr
40002d98: f9401548     	ldr	x8, [x10, #0x28]
40002d9c: b4000488     	cbz	x8, 0x40002e2c <tui_launch+0x148>
40002da0: 2a0903e9     	mov	w9, w9
40002da4: d100050c     	sub	x12, x8, #0x1
40002da8: d240152b     	eor	x11, x9, #0x3f
40002dac: eb0b019f     	cmp	x12, x11
40002db0: 9a8b318b     	csel	x11, x12, x11, lo
40002db4: b400022c     	cbz	x12, 0x40002df8 <tui_launch+0x114>
40002db8: 9100056c     	add	x12, x11, #0x1
40002dbc: 8b090f0e     	add	x14, x24, x9, lsl #3
40002dc0: 9111014d     	add	x13, x10, #0x440
40002dc4: 927f798b     	and	x11, x12, #0xfffffffe
40002dc8: aa090169     	orr	x9, x11, x9
40002dcc: 910021ce     	add	x14, x14, #0x8
40002dd0: aa0b03ef     	mov	x15, x11
40002dd4: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002dd8: f10009ef     	subs	x15, x15, #0x2
40002ddc: 910041ad     	add	x13, x13, #0x10
40002de0: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002de4: 910041ce     	add	x14, x14, #0x10
40002de8: 54ffff61     	b.ne	0x40002dd4 <tui_launch+0xf0>
40002dec: eb0b019f     	cmp	x12, x11
40002df0: 54000061     	b.ne	0x40002dfc <tui_launch+0x118>
40002df4: 1400000d     	b	0x40002e28 <tui_launch+0x144>
40002df8: aa1f03eb     	mov	x11, xzr
40002dfc: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002e00: 9100056b     	add	x11, x11, #0x1
40002e04: 9110e14a     	add	x10, x10, #0x438
40002e08: f840854c     	ldr	x12, [x10], #0x8
40002e0c: f100f93f     	cmp	x9, #0x3e
40002e10: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002e14: 91000529     	add	x9, x9, #0x1
40002e18: 54000088     	b.hi	0x40002e28 <tui_launch+0x144>
40002e1c: eb08017f     	cmp	x11, x8
40002e20: 9100056b     	add	x11, x11, #0x1
40002e24: 54ffff23     	b.lo	0x40002e08 <tui_launch+0x124>
40002e28: b9097b49     	str	w9, [x26, #0x978]
40002e2c: b949776a     	ldr	w10, [x27, #0x974]
40002e30: 51000528     	sub	w8, w9, #0x1
40002e34: 6b08015f     	cmp	w10, w8
40002e38: 1a88b148     	csel	w8, w10, w8, lt
40002e3c: 6b09015f     	cmp	w10, w9
40002e40: 5400004a     	b.ge	0x40002e48 <tui_launch+0x164>
40002e44: 36f80068     	tbz	w8, #0x1f, 0x40002e50 <tui_launch+0x16c>
40002e48: 0aa87d08     	bic	w8, w8, w8, asr #31
40002e4c: b9097768     	str	w8, [x27, #0x974]
40002e50: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002e54: 9126d400     	add	x0, x0, #0x9b5
40002e58: 94000279     	bl	0x4000383c <uart_puts>
40002e5c: b9497388     	ldr	w8, [x28, #0x970]
40002e60: 52800020     	mov	w0, #0x1                // =1
40002e64: 52800501     	mov	w1, #0x28               // =40
40002e68: f0000022     	adrp	x2, 0x40009000 <__rodata_start>
40002e6c: 91023042     	add	x2, x2, #0x8c
40002e70: 7100011f     	cmp	w8, #0x0
40002e74: 1a9f17e3     	cset	w3, eq
40002e78: 94000171     	bl	0x4000343c <draw_box>
40002e7c: 52800075     	mov	w21, #0x3               // =3
40002e80: aa1603e0     	mov	x0, x22
40002e84: 2a1503e1     	mov	w1, w21
40002e88: 52800042     	mov	w2, #0x2                // =2
40002e8c: 94000381     	bl	0x40003c90 <uart_printf>
40002e90: aa1703e0     	mov	x0, x23
40002e94: 9400026a     	bl	0x4000383c <uart_puts>
40002e98: aa1703e0     	mov	x0, x23
40002e9c: 94000268     	bl	0x4000383c <uart_puts>
40002ea0: aa1703e0     	mov	x0, x23
40002ea4: 94000266     	bl	0x4000383c <uart_puts>
40002ea8: aa1703e0     	mov	x0, x23
40002eac: 94000264     	bl	0x4000383c <uart_puts>
40002eb0: aa1703e0     	mov	x0, x23
40002eb4: 94000262     	bl	0x4000383c <uart_puts>
40002eb8: aa1703e0     	mov	x0, x23
40002ebc: 94000260     	bl	0x4000383c <uart_puts>
40002ec0: aa1703e0     	mov	x0, x23
40002ec4: 9400025e     	bl	0x4000383c <uart_puts>
40002ec8: aa1703e0     	mov	x0, x23
40002ecc: 9400025c     	bl	0x4000383c <uart_puts>
40002ed0: aa1703e0     	mov	x0, x23
40002ed4: 9400025a     	bl	0x4000383c <uart_puts>
40002ed8: aa1703e0     	mov	x0, x23
40002edc: 94000258     	bl	0x4000383c <uart_puts>
40002ee0: aa1703e0     	mov	x0, x23
40002ee4: 94000256     	bl	0x4000383c <uart_puts>
40002ee8: aa1703e0     	mov	x0, x23
40002eec: 94000254     	bl	0x4000383c <uart_puts>
40002ef0: aa1703e0     	mov	x0, x23
40002ef4: 94000252     	bl	0x4000383c <uart_puts>
40002ef8: aa1703e0     	mov	x0, x23
40002efc: 94000250     	bl	0x4000383c <uart_puts>
40002f00: aa1703e0     	mov	x0, x23
40002f04: 9400024e     	bl	0x4000383c <uart_puts>
40002f08: aa1703e0     	mov	x0, x23
40002f0c: 9400024c     	bl	0x4000383c <uart_puts>
40002f10: aa1703e0     	mov	x0, x23
40002f14: 9400024a     	bl	0x4000383c <uart_puts>
40002f18: aa1703e0     	mov	x0, x23
40002f1c: 94000248     	bl	0x4000383c <uart_puts>
40002f20: aa1703e0     	mov	x0, x23
40002f24: 94000246     	bl	0x4000383c <uart_puts>
40002f28: aa1703e0     	mov	x0, x23
40002f2c: 94000244     	bl	0x4000383c <uart_puts>
40002f30: aa1703e0     	mov	x0, x23
40002f34: 94000242     	bl	0x4000383c <uart_puts>
40002f38: aa1703e0     	mov	x0, x23
40002f3c: 94000240     	bl	0x4000383c <uart_puts>
40002f40: aa1703e0     	mov	x0, x23
40002f44: 9400023e     	bl	0x4000383c <uart_puts>
40002f48: aa1703e0     	mov	x0, x23
40002f4c: 9400023c     	bl	0x4000383c <uart_puts>
40002f50: aa1703e0     	mov	x0, x23
40002f54: 9400023a     	bl	0x4000383c <uart_puts>
40002f58: aa1703e0     	mov	x0, x23
40002f5c: 94000238     	bl	0x4000383c <uart_puts>
40002f60: aa1703e0     	mov	x0, x23
40002f64: 94000236     	bl	0x4000383c <uart_puts>
40002f68: aa1703e0     	mov	x0, x23
40002f6c: 94000234     	bl	0x4000383c <uart_puts>
40002f70: aa1703e0     	mov	x0, x23
40002f74: 94000232     	bl	0x4000383c <uart_puts>
40002f78: aa1703e0     	mov	x0, x23
40002f7c: 94000230     	bl	0x4000383c <uart_puts>
40002f80: aa1703e0     	mov	x0, x23
40002f84: 9400022e     	bl	0x4000383c <uart_puts>
40002f88: aa1703e0     	mov	x0, x23
40002f8c: 9400022c     	bl	0x4000383c <uart_puts>
40002f90: aa1703e0     	mov	x0, x23
40002f94: 9400022a     	bl	0x4000383c <uart_puts>
40002f98: aa1703e0     	mov	x0, x23
40002f9c: 94000228     	bl	0x4000383c <uart_puts>
40002fa0: aa1703e0     	mov	x0, x23
40002fa4: 94000226     	bl	0x4000383c <uart_puts>
40002fa8: aa1703e0     	mov	x0, x23
40002fac: 94000224     	bl	0x4000383c <uart_puts>
40002fb0: aa1703e0     	mov	x0, x23
40002fb4: 94000222     	bl	0x4000383c <uart_puts>
40002fb8: aa1703e0     	mov	x0, x23
40002fbc: 94000220     	bl	0x4000383c <uart_puts>
40002fc0: 110006b5     	add	w21, w21, #0x1
40002fc4: 71005ebf     	cmp	w21, #0x17
40002fc8: 54fff5c1     	b.ne	0x40002e80 <tui_launch+0x19c>
40002fcc: b9497768     	ldr	w8, [x27, #0x974]
40002fd0: 52800249     	mov	w9, #0x12               // =18
40002fd4: 7100491f     	cmp	w8, #0x12
40002fd8: 1a89c108     	csel	w8, w8, w9, gt
40002fdc: 51004915     	sub	w21, w8, #0x12
40002fe0: 8b354f19     	add	x25, x24, w21, uxtw #3
40002fe4: aa1f03f8     	mov	x24, xzr
40002fe8: 14000004     	b	0x40002ff8 <tui_launch+0x314>
40002fec: 91000718     	add	x24, x24, #0x1
40002ff0: f100531f     	cmp	x24, #0x14
40002ff4: 540005a0     	b.eq	0x400030a8 <tui_launch+0x3c4>
40002ff8: b9897b48     	ldrsw	x8, [x26, #0x978]
40002ffc: 8b1802b3     	add	x19, x21, x24
40003000: eb08027f     	cmp	x19, x8
40003004: 5400052a     	b.ge	0x400030a8 <tui_launch+0x3c4>
40003008: 11000f01     	add	w1, w24, #0x3
4000300c: aa1603e0     	mov	x0, x22
40003010: 52800062     	mov	w2, #0x3                // =3
40003014: 9400031f     	bl	0x40003c90 <uart_printf>
40003018: b9497768     	ldr	w8, [x27, #0x974]
4000301c: eb08027f     	cmp	x19, x8
40003020: 540000c1     	b.ne	0x40003038 <tui_launch+0x354>
40003024: b9497388     	ldr	w8, [x28, #0x970]
40003028: 35000088     	cbnz	w8, 0x40003038 <tui_launch+0x354>
4000302c: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003030: 91040800     	add	x0, x0, #0x102
40003034: 94000202     	bl	0x4000383c <uart_puts>
40003038: f8787b28     	ldr	x8, [x25, x24, lsl #3]
4000303c: b40001e8     	cbz	x8, 0x40003078 <tui_launch+0x394>
40003040: b9402108     	ldr	w8, [x8, #0x20]
40003044: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40003048: 91124d29     	add	x9, x9, #0x493
4000304c: 910223e0     	add	x0, sp, #0x88
40003050: 7100051f     	cmp	w8, #0x1
40003054: d0000028     	adrp	x8, 0x40009000 <__rodata_start>
40003058: 913a7508     	add	x8, x8, #0xe9d
4000305c: 9a880121     	csel	x1, x9, x8, eq
40003060: 97fffe7b     	bl	0x40002a4c <kstrcpy>
40003064: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40003068: 910223e0     	add	x0, sp, #0x88
4000306c: 97fffe50     	bl	0x400029ac <kstrcat>
40003070: 910223e0     	add	x0, sp, #0x88
40003074: 14000003     	b	0x40003080 <tui_launch+0x39c>
40003078: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000307c: 91347000     	add	x0, x0, #0xd1c
40003080: 940001ef     	bl	0x4000383c <uart_puts>
40003084: b9497768     	ldr	w8, [x27, #0x974]
40003088: eb08027f     	cmp	x19, x8
4000308c: 54fffb01     	b.ne	0x40002fec <tui_launch+0x308>
40003090: b9497388     	ldr	w8, [x28, #0x970]
40003094: 35fffac8     	cbnz	w8, 0x40002fec <tui_launch+0x308>
40003098: f0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000309c: 91398c00     	add	x0, x0, #0xe63
400030a0: 940001e7     	bl	0x4000383c <uart_puts>
400030a4: 17ffffd2     	b	0x40002fec <tui_launch+0x308>
400030a8: b9497388     	ldr	w8, [x28, #0x970]
400030ac: 52800540     	mov	w0, #0x2a               // =42
400030b0: 528004c1     	mov	w1, #0x26               // =38
400030b4: f0000022     	adrp	x2, 0x4000a000 <__rodata_start+0x1000>
400030b8: 91090c42     	add	x2, x2, #0x243
400030bc: 7100051f     	cmp	w8, #0x1
400030c0: 1a9f17e3     	cset	w3, eq
400030c4: 940000de     	bl	0x4000343c <draw_box>
400030c8: 52800075     	mov	w21, #0x3               // =3
400030cc: aa1603e0     	mov	x0, x22
400030d0: 2a1503e1     	mov	w1, w21
400030d4: 52800562     	mov	w2, #0x2b               // =43
400030d8: 940002ee     	bl	0x40003c90 <uart_printf>
400030dc: aa1703e0     	mov	x0, x23
400030e0: 940001d7     	bl	0x4000383c <uart_puts>
400030e4: aa1703e0     	mov	x0, x23
400030e8: 940001d5     	bl	0x4000383c <uart_puts>
400030ec: aa1703e0     	mov	x0, x23
400030f0: 940001d3     	bl	0x4000383c <uart_puts>
400030f4: aa1703e0     	mov	x0, x23
400030f8: 940001d1     	bl	0x4000383c <uart_puts>
400030fc: aa1703e0     	mov	x0, x23
40003100: 940001cf     	bl	0x4000383c <uart_puts>
40003104: aa1703e0     	mov	x0, x23
40003108: 940001cd     	bl	0x4000383c <uart_puts>
4000310c: aa1703e0     	mov	x0, x23
40003110: 940001cb     	bl	0x4000383c <uart_puts>
40003114: aa1703e0     	mov	x0, x23
40003118: 940001c9     	bl	0x4000383c <uart_puts>
4000311c: aa1703e0     	mov	x0, x23
40003120: 940001c7     	bl	0x4000383c <uart_puts>
40003124: aa1703e0     	mov	x0, x23
40003128: 940001c5     	bl	0x4000383c <uart_puts>
4000312c: aa1703e0     	mov	x0, x23
40003130: 940001c3     	bl	0x4000383c <uart_puts>
40003134: aa1703e0     	mov	x0, x23
40003138: 940001c1     	bl	0x4000383c <uart_puts>
4000313c: aa1703e0     	mov	x0, x23
40003140: 940001bf     	bl	0x4000383c <uart_puts>
40003144: aa1703e0     	mov	x0, x23
40003148: 940001bd     	bl	0x4000383c <uart_puts>
4000314c: aa1703e0     	mov	x0, x23
40003150: 940001bb     	bl	0x4000383c <uart_puts>
40003154: aa1703e0     	mov	x0, x23
40003158: 940001b9     	bl	0x4000383c <uart_puts>
4000315c: aa1703e0     	mov	x0, x23
40003160: 940001b7     	bl	0x4000383c <uart_puts>
40003164: aa1703e0     	mov	x0, x23
40003168: 940001b5     	bl	0x4000383c <uart_puts>
4000316c: aa1703e0     	mov	x0, x23
40003170: 940001b3     	bl	0x4000383c <uart_puts>
40003174: aa1703e0     	mov	x0, x23
40003178: 940001b1     	bl	0x4000383c <uart_puts>
4000317c: aa1703e0     	mov	x0, x23
40003180: 940001af     	bl	0x4000383c <uart_puts>
40003184: aa1703e0     	mov	x0, x23
40003188: 940001ad     	bl	0x4000383c <uart_puts>
4000318c: aa1703e0     	mov	x0, x23
40003190: 940001ab     	bl	0x4000383c <uart_puts>
40003194: aa1703e0     	mov	x0, x23
40003198: 940001a9     	bl	0x4000383c <uart_puts>
4000319c: aa1703e0     	mov	x0, x23
400031a0: 940001a7     	bl	0x4000383c <uart_puts>
400031a4: aa1703e0     	mov	x0, x23
400031a8: 940001a5     	bl	0x4000383c <uart_puts>
400031ac: aa1703e0     	mov	x0, x23
400031b0: 940001a3     	bl	0x4000383c <uart_puts>
400031b4: aa1703e0     	mov	x0, x23
400031b8: 940001a1     	bl	0x4000383c <uart_puts>
400031bc: aa1703e0     	mov	x0, x23
400031c0: 9400019f     	bl	0x4000383c <uart_puts>
400031c4: aa1703e0     	mov	x0, x23
400031c8: 9400019d     	bl	0x4000383c <uart_puts>
400031cc: aa1703e0     	mov	x0, x23
400031d0: 9400019b     	bl	0x4000383c <uart_puts>
400031d4: aa1703e0     	mov	x0, x23
400031d8: 94000199     	bl	0x4000383c <uart_puts>
400031dc: aa1703e0     	mov	x0, x23
400031e0: 94000197     	bl	0x4000383c <uart_puts>
400031e4: aa1703e0     	mov	x0, x23
400031e8: 94000195     	bl	0x4000383c <uart_puts>
400031ec: aa1703e0     	mov	x0, x23
400031f0: 94000193     	bl	0x4000383c <uart_puts>
400031f4: aa1703e0     	mov	x0, x23
400031f8: 94000191     	bl	0x4000383c <uart_puts>
400031fc: 110006b5     	add	w21, w21, #0x1
40003200: 71005ebf     	cmp	w21, #0x17
40003204: 54fff641     	b.ne	0x400030cc <tui_launch+0x3e8>
40003208: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000320c: 9117a800     	add	x0, x0, #0x5ea
40003210: 52800061     	mov	w1, #0x3                // =3
40003214: 52800562     	mov	w2, #0x2b               // =43
40003218: 9400029e     	bl	0x40003c90 <uart_printf>
4000321c: d503201f     	nop
40003220: 100681a8     	adr	x8, 0x40010254 <proc_table>
40003224: aa1f03f3     	mov	x19, xzr
40003228: 9100a115     	add	x21, x8, #0x28
4000322c: 52800058     	mov	w24, #0x2               // =2
40003230: d0000039     	adrp	x25, 0x40009000 <__rodata_start>
40003234: 91223b39     	add	x25, x25, #0x88e
40003238: b85fc2a8     	ldur	w8, [x21, #-0x4]
4000323c: 71000d1f     	cmp	w8, #0x3
40003240: 54000140     	b.eq	0x40003268 <tui_launch+0x584>
40003244: b94002a8     	ldr	w8, [x21]
40003248: b85d82a3     	ldur	w3, [x21, #-0x28]
4000324c: d10092a4     	sub	x4, x21, #0x24
40003250: 11000b01     	add	w1, w24, #0x2
40003254: aa1403e0     	mov	x0, x20
40003258: 52800562     	mov	w2, #0x2b               // =43
4000325c: 530a7d05     	lsr	w5, w8, #10
40003260: 9400028c     	bl	0x40003c90 <uart_printf>
40003264: 11000718     	add	w24, w24, #0x1
40003268: f1003a7f     	cmp	x19, #0xe
4000326c: 540000a8     	b.hi	0x40003280 <tui_launch+0x59c>
40003270: 7100531f     	cmp	w24, #0x14
40003274: 91000673     	add	x19, x19, #0x1
40003278: 9100c2b5     	add	x21, x21, #0x30
4000327c: 54fffdeb     	b.lt	0x40003238 <tui_launch+0x554>
40003280: 940001a3     	bl	0x4000390c <uart_getc>
40003284: 52801be8     	mov	w8, #0xdf               // =223
40003288: 0a080008     	and	w8, w0, w8
4000328c: 7101451f     	cmp	w8, #0x51
40003290: 54000c00     	b.eq	0x40003410 <tui_launch+0x72c>
40003294: 12001c08     	and	w8, w0, #0xff
40003298: 7100311f     	cmp	w8, #0xc
4000329c: 5400010c     	b.gt	0x400032bc <tui_launch+0x5d8>
400032a0: 7100251f     	cmp	w8, #0x9
400032a4: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
400032a8: 91260318     	add	x24, x24, #0x980
400032ac: 54ffd540     	b.eq	0x40002d54 <tui_launch+0x70>
400032b0: 7100291f     	cmp	w8, #0xa
400032b4: 540002e0     	b.eq	0x40003310 <tui_launch+0x62c>
400032b8: 17fffeab     	b	0x40002d64 <tui_launch+0x80>
400032bc: 7100351f     	cmp	w8, #0xd
400032c0: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
400032c4: 91260318     	add	x24, x24, #0x980
400032c8: 54000240     	b.eq	0x40003310 <tui_launch+0x62c>
400032cc: 71006d1f     	cmp	w8, #0x1b
400032d0: 54ffd4a1     	b.ne	0x40002d64 <tui_launch+0x80>
400032d4: 9400018e     	bl	0x4000390c <uart_getc>
400032d8: 12001c13     	and	w19, w0, #0xff
400032dc: 9400018c     	bl	0x4000390c <uart_getc>
400032e0: 71016e7f     	cmp	w19, #0x5b
400032e4: 54ffd401     	b.ne	0x40002d64 <tui_launch+0x80>
400032e8: 12001c08     	and	w8, w0, #0xff
400032ec: 7101051f     	cmp	w8, #0x41
400032f0: 54000781     	b.ne	0x400033e0 <tui_launch+0x6fc>
400032f4: b9497388     	ldr	w8, [x28, #0x970]
400032f8: 35ffd368     	cbnz	w8, 0x40002d64 <tui_launch+0x80>
400032fc: b9497768     	ldr	w8, [x27, #0x974]
40003300: 71000508     	subs	w8, w8, #0x1
40003304: 54ffd30b     	b.lt	0x40002d64 <tui_launch+0x80>
40003308: b9097768     	str	w8, [x27, #0x974]
4000330c: 17fffe96     	b	0x40002d64 <tui_launch+0x80>
40003310: b9497388     	ldr	w8, [x28, #0x970]
40003314: 35ffd288     	cbnz	w8, 0x40002d64 <tui_launch+0x80>
40003318: b9497b48     	ldr	w8, [x26, #0x978]
4000331c: 7100051f     	cmp	w8, #0x1
40003320: 54ffd22b     	b.lt	0x40002d64 <tui_launch+0x80>
40003324: b9897768     	ldrsw	x8, [x27, #0x974]
40003328: f8687b15     	ldr	x21, [x24, x8, lsl #3]
4000332c: b4000115     	cbz	x21, 0x4000334c <tui_launch+0x668>
40003330: b94022a8     	ldr	w8, [x21, #0x20]
40003334: 7100051f     	cmp	w8, #0x1
40003338: 54000161     	b.ne	0x40003364 <tui_launch+0x680>
4000333c: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40003340: b909777f     	str	wzr, [x27, #0x974]
40003344: f904b515     	str	x21, [x8, #0x968]
40003348: 17fffe87     	b	0x40002d64 <tui_launch+0x80>
4000334c: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003350: b909777f     	str	wzr, [x27, #0x974]
40003354: f944b528     	ldr	x8, [x9, #0x968]
40003358: f9421908     	ldr	x8, [x8, #0x430]
4000335c: f904b528     	str	x8, [x9, #0x968]
40003360: 17fffe81     	b	0x40002d64 <tui_launch+0x80>
40003364: 390223ff     	strb	wzr, [sp, #0x88]
40003368: aa1903e0     	mov	x0, x25
4000336c: 94000610     	bl	0x40004bac <vfs_find>
40003370: eb0002bf     	cmp	x21, x0
40003374: 540001e0     	b.eq	0x400033b0 <tui_launch+0x6cc>
40003378: 910023e0     	add	x0, sp, #0x8
4000337c: 910223e1     	add	x1, sp, #0x88
40003380: 97fffdb3     	bl	0x40002a4c <kstrcpy>
40003384: 910223e0     	add	x0, sp, #0x88
40003388: aa1903e1     	mov	x1, x25
4000338c: 97fffdb0     	bl	0x40002a4c <kstrcpy>
40003390: 910223e0     	add	x0, sp, #0x88
40003394: aa1503e1     	mov	x1, x21
40003398: 97fffd85     	bl	0x400029ac <kstrcat>
4000339c: 910223e0     	add	x0, sp, #0x88
400033a0: 910023e1     	add	x1, sp, #0x8
400033a4: 97fffd82     	bl	0x400029ac <kstrcat>
400033a8: f9421ab5     	ldr	x21, [x21, #0x430]
400033ac: b5fffdf5     	cbnz	x21, 0x40003368 <tui_launch+0x684>
400033b0: 910223e0     	add	x0, sp, #0x88
400033b4: 97fffd77     	bl	0x40002990 <kstrlen>
400033b8: b5000080     	cbnz	x0, 0x400033c8 <tui_launch+0x6e4>
400033bc: 910223e0     	add	x0, sp, #0x88
400033c0: aa1903e1     	mov	x1, x25
400033c4: 97fffda2     	bl	0x40002a4c <kstrcpy>
400033c8: 910223e0     	add	x0, sp, #0x88
400033cc: 97fff3be     	bl	0x400002c4 <launch_kedit>
400033d0: d503201f     	nop
400033d4: 5003bb80     	adr	x0, 0x4000ab46 <__rodata_start+0x1b46>
400033d8: 94000119     	bl	0x4000383c <uart_puts>
400033dc: 17fffe62     	b	0x40002d64 <tui_launch+0x80>
400033e0: 7101091f     	cmp	w8, #0x42
400033e4: 54ffcc01     	b.ne	0x40002d64 <tui_launch+0x80>
400033e8: b9497388     	ldr	w8, [x28, #0x970]
400033ec: 35ffcbc8     	cbnz	w8, 0x40002d64 <tui_launch+0x80>
400033f0: b9497b49     	ldr	w9, [x26, #0x978]
400033f4: b9497768     	ldr	w8, [x27, #0x974]
400033f8: 51000529     	sub	w9, w9, #0x1
400033fc: 6b09011f     	cmp	w8, w9
40003400: 54ffcb2a     	b.ge	0x40002d64 <tui_launch+0x80>
40003404: 11000508     	add	w8, w8, #0x1
40003408: b9097768     	str	w8, [x27, #0x974]
4000340c: 17fffe56     	b	0x40002d64 <tui_launch+0x80>
40003410: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003414: 912f5800     	add	x0, x0, #0xbd6
40003418: 94000109     	bl	0x4000383c <uart_puts>
4000341c: a9564ff4     	ldp	x20, x19, [sp, #0x160]
40003420: a95557f6     	ldp	x22, x21, [sp, #0x150]
40003424: a9545ff8     	ldp	x24, x23, [sp, #0x140]
40003428: a95367fa     	ldp	x26, x25, [sp, #0x130]
4000342c: a9526ffc     	ldp	x28, x27, [sp, #0x120]
40003430: a9517bfd     	ldp	x29, x30, [sp, #0x110]
40003434: 9105c3ff     	add	sp, sp, #0x170
40003438: d65f03c0     	ret

000000004000343c <draw_box>:
4000343c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40003440: 90000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
40003444: 912ba908     	add	x8, x8, #0xaea
40003448: 7100007f     	cmp	w3, #0x0
4000344c: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40003450: 910e3529     	add	x9, x9, #0x38d
40003454: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003458: 2a0003f3     	mov	w19, w0
4000345c: 9a880120     	csel	x0, x9, x8, eq
40003460: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003464: a90257f6     	stp	x22, x21, [sp, #0x20]
40003468: 910003fd     	mov	x29, sp
4000346c: aa0203f4     	mov	x20, x2
40003470: 2a0103f5     	mov	w21, w1
40003474: 940000f2     	bl	0x4000383c <uart_puts>
40003478: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000347c: 91224000     	add	x0, x0, #0x890
40003480: 52800041     	mov	w1, #0x2                // =2
40003484: 2a1303e2     	mov	w2, w19
40003488: 94000202     	bl	0x40003c90 <uart_printf>
4000348c: 51000ab6     	sub	w22, w21, #0x2
40003490: 510006b7     	sub	w23, w21, #0x1
40003494: d0000035     	adrp	x21, 0x40009000 <__rodata_start>
40003498: 91158eb5     	add	x21, x21, #0x563
4000349c: 2a1603f8     	mov	w24, w22
400034a0: aa1503e0     	mov	x0, x21
400034a4: 940000e6     	bl	0x4000383c <uart_puts>
400034a8: 71000718     	subs	w24, w24, #0x1
400034ac: 54ffffa1     	b.ne	0x400034a0 <draw_box+0x64>
400034b0: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400034b4: 91289c00     	add	x0, x0, #0xa27
400034b8: 940000e1     	bl	0x4000383c <uart_puts>
400034bc: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400034c0: 91227000     	add	x0, x0, #0x89c
400034c4: 11000a62     	add	w2, w19, #0x2
400034c8: 52800041     	mov	w1, #0x2                // =2
400034cc: aa1403e3     	mov	x3, x20
400034d0: 940001f0     	bl	0x40003c90 <uart_printf>
400034d4: f0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400034d8: 911d6e94     	add	x20, x20, #0x75b
400034dc: 52800061     	mov	w1, #0x3                // =3
400034e0: aa1403e0     	mov	x0, x20
400034e4: 2a1303e2     	mov	w2, w19
400034e8: 940001ea     	bl	0x40003c90 <uart_printf>
400034ec: 0b1302e2     	add	w2, w23, w19
400034f0: aa1403e0     	mov	x0, x20
400034f4: 52800061     	mov	w1, #0x3                // =3
400034f8: 940001e6     	bl	0x40003c90 <uart_printf>
400034fc: aa1403e0     	mov	x0, x20
40003500: 52800081     	mov	w1, #0x4                // =4
40003504: 2a1303e2     	mov	w2, w19
40003508: 940001e2     	bl	0x40003c90 <uart_printf>
4000350c: 0b1302e2     	add	w2, w23, w19
40003510: aa1403e0     	mov	x0, x20
40003514: 52800081     	mov	w1, #0x4                // =4
40003518: 940001de     	bl	0x40003c90 <uart_printf>
4000351c: aa1403e0     	mov	x0, x20
40003520: 528000a1     	mov	w1, #0x5                // =5
40003524: 2a1303e2     	mov	w2, w19
40003528: 940001da     	bl	0x40003c90 <uart_printf>
4000352c: 0b1302e2     	add	w2, w23, w19
40003530: aa1403e0     	mov	x0, x20
40003534: 528000a1     	mov	w1, #0x5                // =5
40003538: 940001d6     	bl	0x40003c90 <uart_printf>
4000353c: aa1403e0     	mov	x0, x20
40003540: 528000c1     	mov	w1, #0x6                // =6
40003544: 2a1303e2     	mov	w2, w19
40003548: 940001d2     	bl	0x40003c90 <uart_printf>
4000354c: 0b1302e2     	add	w2, w23, w19
40003550: aa1403e0     	mov	x0, x20
40003554: 528000c1     	mov	w1, #0x6                // =6
40003558: 940001ce     	bl	0x40003c90 <uart_printf>
4000355c: aa1403e0     	mov	x0, x20
40003560: 528000e1     	mov	w1, #0x7                // =7
40003564: 2a1303e2     	mov	w2, w19
40003568: 940001ca     	bl	0x40003c90 <uart_printf>
4000356c: 0b1302e2     	add	w2, w23, w19
40003570: aa1403e0     	mov	x0, x20
40003574: 528000e1     	mov	w1, #0x7                // =7
40003578: 940001c6     	bl	0x40003c90 <uart_printf>
4000357c: aa1403e0     	mov	x0, x20
40003580: 52800101     	mov	w1, #0x8                // =8
40003584: 2a1303e2     	mov	w2, w19
40003588: 940001c2     	bl	0x40003c90 <uart_printf>
4000358c: 0b1302e2     	add	w2, w23, w19
40003590: aa1403e0     	mov	x0, x20
40003594: 52800101     	mov	w1, #0x8                // =8
40003598: 940001be     	bl	0x40003c90 <uart_printf>
4000359c: aa1403e0     	mov	x0, x20
400035a0: 52800121     	mov	w1, #0x9                // =9
400035a4: 2a1303e2     	mov	w2, w19
400035a8: 940001ba     	bl	0x40003c90 <uart_printf>
400035ac: 0b1302e2     	add	w2, w23, w19
400035b0: aa1403e0     	mov	x0, x20
400035b4: 52800121     	mov	w1, #0x9                // =9
400035b8: 940001b6     	bl	0x40003c90 <uart_printf>
400035bc: aa1403e0     	mov	x0, x20
400035c0: 52800141     	mov	w1, #0xa                // =10
400035c4: 2a1303e2     	mov	w2, w19
400035c8: 940001b2     	bl	0x40003c90 <uart_printf>
400035cc: 0b1302e2     	add	w2, w23, w19
400035d0: aa1403e0     	mov	x0, x20
400035d4: 52800141     	mov	w1, #0xa                // =10
400035d8: 940001ae     	bl	0x40003c90 <uart_printf>
400035dc: aa1403e0     	mov	x0, x20
400035e0: 52800161     	mov	w1, #0xb                // =11
400035e4: 2a1303e2     	mov	w2, w19
400035e8: 940001aa     	bl	0x40003c90 <uart_printf>
400035ec: 0b1302e2     	add	w2, w23, w19
400035f0: aa1403e0     	mov	x0, x20
400035f4: 52800161     	mov	w1, #0xb                // =11
400035f8: 940001a6     	bl	0x40003c90 <uart_printf>
400035fc: aa1403e0     	mov	x0, x20
40003600: 52800181     	mov	w1, #0xc                // =12
40003604: 2a1303e2     	mov	w2, w19
40003608: 940001a2     	bl	0x40003c90 <uart_printf>
4000360c: 0b1302e2     	add	w2, w23, w19
40003610: aa1403e0     	mov	x0, x20
40003614: 52800181     	mov	w1, #0xc                // =12
40003618: 9400019e     	bl	0x40003c90 <uart_printf>
4000361c: aa1403e0     	mov	x0, x20
40003620: 528001a1     	mov	w1, #0xd                // =13
40003624: 2a1303e2     	mov	w2, w19
40003628: 9400019a     	bl	0x40003c90 <uart_printf>
4000362c: 0b1302e2     	add	w2, w23, w19
40003630: aa1403e0     	mov	x0, x20
40003634: 528001a1     	mov	w1, #0xd                // =13
40003638: 94000196     	bl	0x40003c90 <uart_printf>
4000363c: aa1403e0     	mov	x0, x20
40003640: 528001c1     	mov	w1, #0xe                // =14
40003644: 2a1303e2     	mov	w2, w19
40003648: 94000192     	bl	0x40003c90 <uart_printf>
4000364c: 0b1302e2     	add	w2, w23, w19
40003650: aa1403e0     	mov	x0, x20
40003654: 528001c1     	mov	w1, #0xe                // =14
40003658: 9400018e     	bl	0x40003c90 <uart_printf>
4000365c: aa1403e0     	mov	x0, x20
40003660: 528001e1     	mov	w1, #0xf                // =15
40003664: 2a1303e2     	mov	w2, w19
40003668: 9400018a     	bl	0x40003c90 <uart_printf>
4000366c: 0b1302e2     	add	w2, w23, w19
40003670: aa1403e0     	mov	x0, x20
40003674: 528001e1     	mov	w1, #0xf                // =15
40003678: 94000186     	bl	0x40003c90 <uart_printf>
4000367c: aa1403e0     	mov	x0, x20
40003680: 52800201     	mov	w1, #0x10               // =16
40003684: 2a1303e2     	mov	w2, w19
40003688: 94000182     	bl	0x40003c90 <uart_printf>
4000368c: 0b1302e2     	add	w2, w23, w19
40003690: aa1403e0     	mov	x0, x20
40003694: 52800201     	mov	w1, #0x10               // =16
40003698: 9400017e     	bl	0x40003c90 <uart_printf>
4000369c: aa1403e0     	mov	x0, x20
400036a0: 52800221     	mov	w1, #0x11               // =17
400036a4: 2a1303e2     	mov	w2, w19
400036a8: 9400017a     	bl	0x40003c90 <uart_printf>
400036ac: 0b1302e2     	add	w2, w23, w19
400036b0: aa1403e0     	mov	x0, x20
400036b4: 52800221     	mov	w1, #0x11               // =17
400036b8: 94000176     	bl	0x40003c90 <uart_printf>
400036bc: aa1403e0     	mov	x0, x20
400036c0: 52800241     	mov	w1, #0x12               // =18
400036c4: 2a1303e2     	mov	w2, w19
400036c8: 94000172     	bl	0x40003c90 <uart_printf>
400036cc: 0b1302e2     	add	w2, w23, w19
400036d0: aa1403e0     	mov	x0, x20
400036d4: 52800241     	mov	w1, #0x12               // =18
400036d8: 9400016e     	bl	0x40003c90 <uart_printf>
400036dc: aa1403e0     	mov	x0, x20
400036e0: 52800261     	mov	w1, #0x13               // =19
400036e4: 2a1303e2     	mov	w2, w19
400036e8: 9400016a     	bl	0x40003c90 <uart_printf>
400036ec: 0b1302e2     	add	w2, w23, w19
400036f0: aa1403e0     	mov	x0, x20
400036f4: 52800261     	mov	w1, #0x13               // =19
400036f8: 94000166     	bl	0x40003c90 <uart_printf>
400036fc: aa1403e0     	mov	x0, x20
40003700: 52800281     	mov	w1, #0x14               // =20
40003704: 2a1303e2     	mov	w2, w19
40003708: 94000162     	bl	0x40003c90 <uart_printf>
4000370c: 0b1302e2     	add	w2, w23, w19
40003710: aa1403e0     	mov	x0, x20
40003714: 52800281     	mov	w1, #0x14               // =20
40003718: 9400015e     	bl	0x40003c90 <uart_printf>
4000371c: aa1403e0     	mov	x0, x20
40003720: 528002a1     	mov	w1, #0x15               // =21
40003724: 2a1303e2     	mov	w2, w19
40003728: 9400015a     	bl	0x40003c90 <uart_printf>
4000372c: 0b1302e2     	add	w2, w23, w19
40003730: aa1403e0     	mov	x0, x20
40003734: 528002a1     	mov	w1, #0x15               // =21
40003738: 94000156     	bl	0x40003c90 <uart_printf>
4000373c: aa1403e0     	mov	x0, x20
40003740: 528002c1     	mov	w1, #0x16               // =22
40003744: 2a1303e2     	mov	w2, w19
40003748: 94000152     	bl	0x40003c90 <uart_printf>
4000374c: 0b1302e2     	add	w2, w23, w19
40003750: aa1403e0     	mov	x0, x20
40003754: 528002c1     	mov	w1, #0x16               // =22
40003758: 9400014e     	bl	0x40003c90 <uart_printf>
4000375c: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003760: 91176800     	add	x0, x0, #0x5da
40003764: 528002e1     	mov	w1, #0x17               // =23
40003768: 2a1303e2     	mov	w2, w19
4000376c: 94000149     	bl	0x40003c90 <uart_printf>
40003770: d0000033     	adrp	x19, 0x40009000 <__rodata_start>
40003774: 91158e73     	add	x19, x19, #0x563
40003778: aa1303e0     	mov	x0, x19
4000377c: 94000030     	bl	0x4000383c <uart_puts>
40003780: 710006d6     	subs	w22, w22, #0x1
40003784: 54ffffa1     	b.ne	0x40003778 <draw_box+0x33c>
40003788: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000378c: 91179800     	add	x0, x0, #0x5e6
40003790: 9400002b     	bl	0x4000383c <uart_puts>
40003794: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003798: f0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000379c: 91398c00     	add	x0, x0, #0xe63
400037a0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400037a4: a9415ff8     	ldp	x24, x23, [sp, #0x10]
400037a8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400037ac: 14000024     	b	0x4000383c <uart_puts>

00000000400037b0 <uart_init>:
400037b0: 52800608     	mov	w8, #0x30               // =48
400037b4: 528001a9     	mov	w9, #0xd                // =13
400037b8: 5280002a     	mov	w10, #0x1               // =1
400037bc: 72a12008     	movk	w8, #0x900, lsl #16
400037c0: b900011f     	str	wzr, [x8]
400037c4: b81f4109     	stur	w9, [x8, #-0xc]
400037c8: 52800e09     	mov	w9, #0x70               // =112
400037cc: b81f810a     	stur	w10, [x8, #-0x8]
400037d0: b81fc109     	stur	w9, [x8, #-0x4]
400037d4: 52806029     	mov	w9, #0x301              // =769
400037d8: b9000109     	str	w9, [x8]
400037dc: d65f03c0     	ret

00000000400037e0 <uart_putc>:
400037e0: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
400037e4: b94b8108     	ldr	w8, [x8, #0xb80]
400037e8: 340001a8     	cbz	w8, 0x4000381c <uart_putc+0x3c>
400037ec: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
400037f0: 5287ffca     	mov	w10, #0x3ffe            // =16382
400037f4: b94b8509     	ldr	w9, [x8, #0xb84]
400037f8: 6b0a013f     	cmp	w9, w10
400037fc: 5400010c     	b.gt	0x4000381c <uart_putc+0x3c>
40003800: 93407d29     	sxtw	x9, w9
40003804: d503201f     	nop
40003808: 10071c0a     	adr	x10, 0x40011b88 <kernel_capture_buffer>
4000380c: 9100052b     	add	x11, x9, #0x1
40003810: 38296940     	strb	w0, [x10, x9]
40003814: b90b850b     	str	w11, [x8, #0xb84]
40003818: 382b695f     	strb	wzr, [x10, x11]
4000381c: 52800308     	mov	w8, #0x18               // =24
40003820: 72a12008     	movk	w8, #0x900, lsl #16
40003824: b9400109     	ldr	w9, [x8]
40003828: 372fffe9     	tbnz	w9, #0x5, 0x40003824 <uart_putc+0x44>
4000382c: 12001c08     	and	w8, w0, #0xff
40003830: 52a12009     	mov	w9, #0x9000000          // =150994944
40003834: b9000128     	str	w8, [x9]
40003838: d65f03c0     	ret

000000004000383c <uart_puts>:
4000383c: 52800308     	mov	w8, #0x18               // =24
40003840: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003844: d000006a     	adrp	x10, 0x40011000 <var_values+0x6a8>
40003848: 72a12008     	movk	w8, #0x900, lsl #16
4000384c: d503201f     	nop
40003850: 100719cb     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003854: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003858: 528001ad     	mov	w13, #0xd               // =13
4000385c: 52a1200e     	mov	w14, #0x9000000         // =150994944
40003860: 3940000f     	ldrb	w15, [x0]
40003864: 710029ff     	cmp	w15, #0xa
40003868: 540000a0     	b.eq	0x4000387c <uart_puts+0x40>
4000386c: 3400042f     	cbz	w15, 0x400038f0 <uart_puts+0xb4>
40003870: b94b8130     	ldr	w16, [x9, #0xb80]
40003874: 35000250     	cbnz	w16, 0x400038bc <uart_puts+0x80>
40003878: 14000019     	b	0x400038dc <uart_puts+0xa0>
4000387c: b94b812f     	ldr	w15, [x9, #0xb80]
40003880: 3400012f     	cbz	w15, 0x400038a4 <uart_puts+0x68>
40003884: b94b854f     	ldr	w15, [x10, #0xb84]
40003888: 6b0c01ff     	cmp	w15, w12
4000388c: 540000cc     	b.gt	0x400038a4 <uart_puts+0x68>
40003890: 93407def     	sxtw	x15, w15
40003894: 910005f0     	add	x16, x15, #0x1
40003898: 382f696d     	strb	w13, [x11, x15]
4000389c: b90b8550     	str	w16, [x10, #0xb84]
400038a0: 3830697f     	strb	wzr, [x11, x16]
400038a4: b940010f     	ldr	w15, [x8]
400038a8: 372fffef     	tbnz	w15, #0x5, 0x400038a4 <uart_puts+0x68>
400038ac: b90001cd     	str	w13, [x14]
400038b0: 3940000f     	ldrb	w15, [x0]
400038b4: b94b8130     	ldr	w16, [x9, #0xb80]
400038b8: 34000130     	cbz	w16, 0x400038dc <uart_puts+0xa0>
400038bc: b94b8550     	ldr	w16, [x10, #0xb84]
400038c0: 6b0c021f     	cmp	w16, w12
400038c4: 540000cc     	b.gt	0x400038dc <uart_puts+0xa0>
400038c8: 93407e10     	sxtw	x16, w16
400038cc: 91000611     	add	x17, x16, #0x1
400038d0: 3830696f     	strb	w15, [x11, x16]
400038d4: b90b8551     	str	w17, [x10, #0xb84]
400038d8: 3831697f     	strb	wzr, [x11, x17]
400038dc: 91000400     	add	x0, x0, #0x1
400038e0: b9400110     	ldr	w16, [x8]
400038e4: 372ffff0     	tbnz	w16, #0x5, 0x400038e0 <uart_puts+0xa4>
400038e8: b90001cf     	str	w15, [x14]
400038ec: 17ffffdd     	b	0x40003860 <uart_puts+0x24>
400038f0: d65f03c0     	ret

00000000400038f4 <uart_has_data>:
400038f4: 52800308     	mov	w8, #0x18               // =24
400038f8: 52800029     	mov	w9, #0x1                // =1
400038fc: 72a12008     	movk	w8, #0x900, lsl #16
40003900: b9400108     	ldr	w8, [x8]
40003904: 0a681120     	bic	w0, w9, w8, lsr #4
40003908: d65f03c0     	ret

000000004000390c <uart_getc>:
4000390c: 52800308     	mov	w8, #0x18               // =24
40003910: 72a12008     	movk	w8, #0x900, lsl #16
40003914: b9400109     	ldr	w9, [x8]
40003918: 3727ffe9     	tbnz	w9, #0x4, 0x40003914 <uart_getc+0x8>
4000391c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003920: b9400100     	ldr	w0, [x8]
40003924: d65f03c0     	ret

0000000040003928 <uart_print_hex_raw>:
40003928: 52800308     	mov	w8, #0x18               // =24
4000392c: 2a1f03eb     	mov	w11, wzr
40003930: 5280078c     	mov	w12, #0x3c              // =60
40003934: 72a12008     	movk	w8, #0x900, lsl #16
40003938: d503201f     	nop
4000393c: 1002de2e     	adr	x14, 0x40009500 <__rodata_start+0x500>
40003940: d000006d     	adrp	x13, 0x40011000 <var_values+0x6a8>
40003944: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003948: 5287ffcf     	mov	w15, #0x3ffe            // =16382
4000394c: d503201f     	nop
40003950: 100711ca     	adr	x10, 0x40011b88 <kernel_capture_buffer>
40003954: 52a12010     	mov	w16, #0x9000000         // =150994944
40003958: 14000003     	b	0x40003964 <uart_print_hex_raw+0x3c>
4000395c: b400032c     	cbz	x12, 0x400039c0 <uart_print_hex_raw+0x98>
40003960: d100118c     	sub	x12, x12, #0x4
40003964: 9acc2411     	lsr	x17, x0, x12
40003968: 53027d92     	lsr	w18, w12, #2
4000396c: 92400e31     	and	x17, x17, #0xf
40003970: 6b01025f     	cmp	w18, w1
40003974: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003978: 1a9f056b     	csinc	w11, w11, wzr, eq
4000397c: 34ffff0b     	cbz	w11, 0x4000395c <uart_print_hex_raw+0x34>
40003980: b94b81b2     	ldr	w18, [x13, #0xb80]
40003984: 387169d1     	ldrb	w17, [x14, x17]
40003988: 34000132     	cbz	w18, 0x400039ac <uart_print_hex_raw+0x84>
4000398c: b94b8532     	ldr	w18, [x9, #0xb84]
40003990: 6b0f025f     	cmp	w18, w15
40003994: 540000cc     	b.gt	0x400039ac <uart_print_hex_raw+0x84>
40003998: 93407e52     	sxtw	x18, w18
4000399c: 91000642     	add	x2, x18, #0x1
400039a0: 38326951     	strb	w17, [x10, x18]
400039a4: b90b8522     	str	w2, [x9, #0xb84]
400039a8: 3822695f     	strb	wzr, [x10, x2]
400039ac: b9400112     	ldr	w18, [x8]
400039b0: 372ffff2     	tbnz	w18, #0x5, 0x400039ac <uart_print_hex_raw+0x84>
400039b4: b9000211     	str	w17, [x16]
400039b8: b5fffd4c     	cbnz	x12, 0x40003960 <uart_print_hex_raw+0x38>
400039bc: d65f03c0     	ret
400039c0: b94b81ab     	ldr	w11, [x13, #0xb80]
400039c4: 3400016b     	cbz	w11, 0x400039f0 <uart_print_hex_raw+0xc8>
400039c8: b94b852b     	ldr	w11, [x9, #0xb84]
400039cc: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039d0: 6b0c017f     	cmp	w11, w12
400039d4: 540000ec     	b.gt	0x400039f0 <uart_print_hex_raw+0xc8>
400039d8: 93407d6b     	sxtw	x11, w11
400039dc: 5280060c     	mov	w12, #0x30              // =48
400039e0: 9100056d     	add	x13, x11, #0x1
400039e4: 382b694c     	strb	w12, [x10, x11]
400039e8: b90b852d     	str	w13, [x9, #0xb84]
400039ec: 382d695f     	strb	wzr, [x10, x13]
400039f0: b9400109     	ldr	w9, [x8]
400039f4: 372fffe9     	tbnz	w9, #0x5, 0x400039f0 <uart_print_hex_raw+0xc8>
400039f8: 52a12008     	mov	w8, #0x9000000          // =150994944
400039fc: 52800609     	mov	w9, #0x30               // =48
40003a00: b9000109     	str	w9, [x8]
40003a04: d65f03c0     	ret

0000000040003a08 <uart_print_hex>:
40003a08: 52800308     	mov	w8, #0x18               // =24
40003a0c: f000002c     	adrp	x12, 0x4000a000 <__rodata_start+0x1000>
40003a10: 9109418c     	add	x12, x12, #0x250
40003a14: 72a12008     	movk	w8, #0x900, lsl #16
40003a18: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
40003a1c: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003a20: d503201f     	nop
40003a24: 10070b2a     	adr	x10, 0x40011b88 <kernel_capture_buffer>
40003a28: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a2c: 528001ae     	mov	w14, #0xd               // =13
40003a30: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a34: 39400190     	ldrb	w16, [x12]
40003a38: 71002a1f     	cmp	w16, #0xa
40003a3c: 540000a0     	b.eq	0x40003a50 <uart_print_hex+0x48>
40003a40: 34000410     	cbz	w16, 0x40003ac0 <uart_print_hex+0xb8>
40003a44: b94b8171     	ldr	w17, [x11, #0xb80]
40003a48: 35000231     	cbnz	w17, 0x40003a8c <uart_print_hex+0x84>
40003a4c: 14000018     	b	0x40003aac <uart_print_hex+0xa4>
40003a50: b94b8171     	ldr	w17, [x11, #0xb80]
40003a54: 34000131     	cbz	w17, 0x40003a78 <uart_print_hex+0x70>
40003a58: b94b8531     	ldr	w17, [x9, #0xb84]
40003a5c: 6b0d023f     	cmp	w17, w13
40003a60: 540000cc     	b.gt	0x40003a78 <uart_print_hex+0x70>
40003a64: 93407e31     	sxtw	x17, w17
40003a68: 91000632     	add	x18, x17, #0x1
40003a6c: 3831694e     	strb	w14, [x10, x17]
40003a70: b90b8532     	str	w18, [x9, #0xb84]
40003a74: 3832695f     	strb	wzr, [x10, x18]
40003a78: b9400111     	ldr	w17, [x8]
40003a7c: 372ffff1     	tbnz	w17, #0x5, 0x40003a78 <uart_print_hex+0x70>
40003a80: b90001ee     	str	w14, [x15]
40003a84: b94b8171     	ldr	w17, [x11, #0xb80]
40003a88: 34000131     	cbz	w17, 0x40003aac <uart_print_hex+0xa4>
40003a8c: b94b8531     	ldr	w17, [x9, #0xb84]
40003a90: 6b0d023f     	cmp	w17, w13
40003a94: 540000cc     	b.gt	0x40003aac <uart_print_hex+0xa4>
40003a98: 93407e31     	sxtw	x17, w17
40003a9c: 91000632     	add	x18, x17, #0x1
40003aa0: 38316950     	strb	w16, [x10, x17]
40003aa4: b90b8532     	str	w18, [x9, #0xb84]
40003aa8: 3832695f     	strb	wzr, [x10, x18]
40003aac: 9100058c     	add	x12, x12, #0x1
40003ab0: b9400111     	ldr	w17, [x8]
40003ab4: 372ffff1     	tbnz	w17, #0x5, 0x40003ab0 <uart_print_hex+0xa8>
40003ab8: b90001f0     	str	w16, [x15]
40003abc: 17ffffde     	b	0x40003a34 <uart_print_hex+0x2c>
40003ac0: 2a1f03ec     	mov	w12, wzr
40003ac4: d503201f     	nop
40003ac8: 1002d1cd     	adr	x13, 0x40009500 <__rodata_start+0x500>
40003acc: 5280078e     	mov	w14, #0x3c              // =60
40003ad0: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003ad4: 52a12010     	mov	w16, #0x9000000         // =150994944
40003ad8: 14000003     	b	0x40003ae4 <uart_print_hex+0xdc>
40003adc: b40002ee     	cbz	x14, 0x40003b38 <uart_print_hex+0x130>
40003ae0: d10011ce     	sub	x14, x14, #0x4
40003ae4: 9ace2411     	lsr	x17, x0, x14
40003ae8: f2400e31     	ands	x17, x17, #0xf
40003aec: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003af0: 1a9f158c     	csinc	w12, w12, wzr, ne
40003af4: 34ffff4c     	cbz	w12, 0x40003adc <uart_print_hex+0xd4>
40003af8: b94b8172     	ldr	w18, [x11, #0xb80]
40003afc: 387169b1     	ldrb	w17, [x13, x17]
40003b00: 34000132     	cbz	w18, 0x40003b24 <uart_print_hex+0x11c>
40003b04: b94b8532     	ldr	w18, [x9, #0xb84]
40003b08: 6b0f025f     	cmp	w18, w15
40003b0c: 540000cc     	b.gt	0x40003b24 <uart_print_hex+0x11c>
40003b10: 93407e52     	sxtw	x18, w18
40003b14: 91000641     	add	x1, x18, #0x1
40003b18: 38326951     	strb	w17, [x10, x18]
40003b1c: b90b8521     	str	w1, [x9, #0xb84]
40003b20: 3821695f     	strb	wzr, [x10, x1]
40003b24: b9400112     	ldr	w18, [x8]
40003b28: 372ffff2     	tbnz	w18, #0x5, 0x40003b24 <uart_print_hex+0x11c>
40003b2c: b9000211     	str	w17, [x16]
40003b30: b5fffd8e     	cbnz	x14, 0x40003ae0 <uart_print_hex+0xd8>
40003b34: d65f03c0     	ret
40003b38: b94b816b     	ldr	w11, [x11, #0xb80]
40003b3c: 3400016b     	cbz	w11, 0x40003b68 <uart_print_hex+0x160>
40003b40: b94b852b     	ldr	w11, [x9, #0xb84]
40003b44: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003b48: 6b0c017f     	cmp	w11, w12
40003b4c: 540000ec     	b.gt	0x40003b68 <uart_print_hex+0x160>
40003b50: 93407d6b     	sxtw	x11, w11
40003b54: 5280060c     	mov	w12, #0x30              // =48
40003b58: 9100056d     	add	x13, x11, #0x1
40003b5c: 382b694c     	strb	w12, [x10, x11]
40003b60: b90b852d     	str	w13, [x9, #0xb84]
40003b64: 382d695f     	strb	wzr, [x10, x13]
40003b68: b9400109     	ldr	w9, [x8]
40003b6c: 372fffe9     	tbnz	w9, #0x5, 0x40003b68 <uart_print_hex+0x160>
40003b70: 52a12008     	mov	w8, #0x9000000          // =150994944
40003b74: 52800609     	mov	w9, #0x30               // =48
40003b78: b9000109     	str	w9, [x8]
40003b7c: d65f03c0     	ret

0000000040003b80 <uart_print_dec>:
40003b80: d10083ff     	sub	sp, sp, #0x20
40003b84: 52800308     	mov	w8, #0x18               // =24
40003b88: 72a12008     	movk	w8, #0x900, lsl #16
40003b8c: b4000540     	cbz	x0, 0x40003c34 <uart_print_dec+0xb4>
40003b90: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003b94: aa1f03e9     	mov	x9, xzr
40003b98: 5280014b     	mov	w11, #0xa               // =10
40003b9c: f29999aa     	movk	x10, #0xcccd
40003ba0: 910023ec     	add	x12, sp, #0x8
40003ba4: 9bca7c0d     	umulh	x13, x0, x10
40003ba8: f100241f     	cmp	x0, #0x9
40003bac: d343fdad     	lsr	x13, x13, #3
40003bb0: 1b0b81ae     	msub	w14, w13, w11, w0
40003bb4: aa0d03e0     	mov	x0, x13
40003bb8: 321c05ce     	orr	w14, w14, #0x30
40003bbc: 3829698e     	strb	w14, [x12, x9]
40003bc0: 91000529     	add	x9, x9, #0x1
40003bc4: 54ffff08     	b.hi	0x40003ba4 <uart_print_dec+0x24>
40003bc8: 910023ea     	add	x10, sp, #0x8
40003bcc: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
40003bd0: d000006c     	adrp	x12, 0x40011000 <var_values+0x6a8>
40003bd4: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003bd8: d503201f     	nop
40003bdc: 1006fd6e     	adr	x14, 0x40011b88 <kernel_capture_buffer>
40003be0: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003be4: d1000530     	sub	x16, x9, #0x1
40003be8: b94b8172     	ldr	w18, [x11, #0xb80]
40003bec: 38706951     	ldrb	w17, [x10, x16]
40003bf0: 34000132     	cbz	w18, 0x40003c14 <uart_print_dec+0x94>
40003bf4: b94b8592     	ldr	w18, [x12, #0xb84]
40003bf8: 6b0d025f     	cmp	w18, w13
40003bfc: 540000cc     	b.gt	0x40003c14 <uart_print_dec+0x94>
40003c00: 93407e52     	sxtw	x18, w18
40003c04: 91000640     	add	x0, x18, #0x1
40003c08: 383269d1     	strb	w17, [x14, x18]
40003c0c: b90b8580     	str	w0, [x12, #0xb84]
40003c10: 382069df     	strb	wzr, [x14, x0]
40003c14: b9400112     	ldr	w18, [x8]
40003c18: 372ffff2     	tbnz	w18, #0x5, 0x40003c14 <uart_print_dec+0x94>
40003c1c: 7100053f     	cmp	w9, #0x1
40003c20: aa1003e9     	mov	x9, x16
40003c24: b90001f1     	str	w17, [x15]
40003c28: 54fffdec     	b.gt	0x40003be4 <uart_print_dec+0x64>
40003c2c: 910083ff     	add	sp, sp, #0x20
40003c30: d65f03c0     	ret
40003c34: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003c38: b94b8129     	ldr	w9, [x9, #0xb80]
40003c3c: 340001c9     	cbz	w9, 0x40003c74 <uart_print_dec+0xf4>
40003c40: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003c44: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003c48: b94b852a     	ldr	w10, [x9, #0xb84]
40003c4c: 6b0b015f     	cmp	w10, w11
40003c50: 5400012c     	b.gt	0x40003c74 <uart_print_dec+0xf4>
40003c54: 93407d4a     	sxtw	x10, w10
40003c58: d503201f     	nop
40003c5c: 1006f96b     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003c60: 5280060c     	mov	w12, #0x30              // =48
40003c64: 9100054d     	add	x13, x10, #0x1
40003c68: 382a696c     	strb	w12, [x11, x10]
40003c6c: b90b852d     	str	w13, [x9, #0xb84]
40003c70: 382d697f     	strb	wzr, [x11, x13]
40003c74: b9400109     	ldr	w9, [x8]
40003c78: 372fffe9     	tbnz	w9, #0x5, 0x40003c74 <uart_print_dec+0xf4>
40003c7c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003c80: 52800609     	mov	w9, #0x30               // =48
40003c84: b9000109     	str	w9, [x8]
40003c88: 910083ff     	add	sp, sp, #0x20
40003c8c: d65f03c0     	ret

0000000040003c90 <uart_printf>:
40003c90: d10343ff     	sub	sp, sp, #0xd0
40003c94: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003c98: 9101c3fd     	add	x29, sp, #0x70
40003c9c: 910003e8     	mov	x8, sp
40003ca0: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003ca4: 52800315     	mov	w21, #0x18              // =24
40003ca8: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003cac: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003cb0: 72a12015     	movk	w21, #0x900, lsl #16
40003cb4: 128006e9     	mov	w9, #-0x38              // =-56
40003cb8: a90967fa     	stp	x26, x25, [sp, #0x90]
40003cbc: 9100e108     	add	x8, x8, #0x38
40003cc0: 910183aa     	add	x10, x29, #0x60
40003cc4: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003cc8: d0000076     	adrp	x22, 0x40011000 <var_values+0x6a8>
40003ccc: d0000077     	adrp	x23, 0x40011000 <var_values+0x6a8>
40003cd0: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003cd4: aa0003f3     	mov	x19, x0
40003cd8: aa1f03f4     	mov	x20, xzr
40003cdc: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003ce0: d503201f     	nop
40003ce4: 1006f539     	adr	x25, 0x40011b88 <kernel_capture_buffer>
40003ce8: 528001ba     	mov	w26, #0xd               // =13
40003cec: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003cf0: 528004ae     	mov	w14, #0x25              // =37
40003cf4: f29999af     	movk	x15, #0xcccd
40003cf8: 52800150     	mov	w16, #0xa               // =10
40003cfc: d10063bc     	sub	x28, x29, #0x18
40003d00: d503201f     	nop
40003d04: 1002bff1     	adr	x17, 0x40009500 <__rodata_start+0x500>
40003d08: a9000be1     	stp	x1, x2, [sp]
40003d0c: a90113e3     	stp	x3, x4, [sp, #0x10]
40003d10: a9021be5     	stp	x5, x6, [sp, #0x20]
40003d14: f9002be9     	str	x9, [sp, #0x50]
40003d18: f90023e8     	str	x8, [sp, #0x40]
40003d1c: a9032be7     	stp	x7, x10, [sp, #0x30]
40003d20: 14000004     	b	0x40003d30 <uart_printf+0xa0>
40003d24: 52800608     	mov	w8, #0x30               // =48
40003d28: b9000368     	str	w8, [x27]
40003d2c: 91000694     	add	x20, x20, #0x1
40003d30: 38746a68     	ldrb	w8, [x19, x20]
40003d34: 7100291f     	cmp	w8, #0xa
40003d38: 54000440     	b.eq	0x40003dc0 <uart_printf+0x130>
40003d3c: 7100951f     	cmp	w8, #0x25
40003d40: 540000a0     	b.eq	0x40003d54 <uart_printf+0xc4>
40003d44: 34003ae8     	cbz	w8, 0x400044a0 <uart_printf+0x810>
40003d48: b94b82c9     	ldr	w9, [x22, #0xb80]
40003d4c: 350005a9     	cbnz	w9, 0x40003e00 <uart_printf+0x170>
40003d50: 14000034     	b	0x40003e20 <uart_printf+0x190>
40003d54: 9100068a     	add	x10, x20, #0x1
40003d58: 386a6a68     	ldrb	w8, [x19, x10]
40003d5c: 7101b11f     	cmp	w8, #0x6c
40003d60: 54000661     	b.ne	0x40003e2c <uart_printf+0x19c>
40003d64: 91000a89     	add	x9, x20, #0x2
40003d68: 91000e8b     	add	x11, x20, #0x3
40003d6c: 38696a6a     	ldrb	w10, [x19, x9]
40003d70: 7101b15f     	cmp	w10, #0x6c
40003d74: 9a890174     	csel	x20, x11, x9, eq
40003d78: 38746a69     	ldrb	w9, [x19, x20]
40003d7c: 7101bd3f     	cmp	w9, #0x6f
40003d80: 540005ed     	b.le	0x40003e3c <uart_printf+0x1ac>
40003d84: 7101d13f     	cmp	w9, #0x74
40003d88: 5400080c     	b.gt	0x40003e88 <uart_printf+0x1f8>
40003d8c: 7101c13f     	cmp	w9, #0x70
40003d90: 54000f00     	b.eq	0x40003f70 <uart_printf+0x2e0>
40003d94: 7101cd3f     	cmp	w9, #0x73
40003d98: 54000b61     	b.ne	0x40003f04 <uart_printf+0x274>
40003d9c: b98053e8     	ldrsw	x8, [sp, #0x50]
40003da0: 36f81408     	tbz	w8, #0x1f, 0x40004020 <uart_printf+0x390>
40003da4: 11002109     	add	w9, w8, #0x8
40003da8: 3100211f     	cmn	w8, #0x8
40003dac: b90053e9     	str	w9, [sp, #0x50]
40003db0: 54001388     	b.hi	0x40004020 <uart_printf+0x390>
40003db4: f94023e9     	ldr	x9, [sp, #0x40]
40003db8: 8b080128     	add	x8, x9, x8
40003dbc: 1400009c     	b	0x4000402c <uart_printf+0x39c>
40003dc0: b94b82c8     	ldr	w8, [x22, #0xb80]
40003dc4: 34000128     	cbz	w8, 0x40003de8 <uart_printf+0x158>
40003dc8: b94b86e8     	ldr	w8, [x23, #0xb84]
40003dcc: 6b18011f     	cmp	w8, w24
40003dd0: 540000cc     	b.gt	0x40003de8 <uart_printf+0x158>
40003dd4: 93407d08     	sxtw	x8, w8
40003dd8: 91000509     	add	x9, x8, #0x1
40003ddc: 38286b3a     	strb	w26, [x25, x8]
40003de0: b90b86e9     	str	w9, [x23, #0xb84]
40003de4: 38296b3f     	strb	wzr, [x25, x9]
40003de8: b94002a8     	ldr	w8, [x21]
40003dec: 372fffe8     	tbnz	w8, #0x5, 0x40003de8 <uart_printf+0x158>
40003df0: b900037a     	str	w26, [x27]
40003df4: 38746a68     	ldrb	w8, [x19, x20]
40003df8: b94b82c9     	ldr	w9, [x22, #0xb80]
40003dfc: 34000129     	cbz	w9, 0x40003e20 <uart_printf+0x190>
40003e00: b94b86e9     	ldr	w9, [x23, #0xb84]
40003e04: 6b18013f     	cmp	w9, w24
40003e08: 540000cc     	b.gt	0x40003e20 <uart_printf+0x190>
40003e0c: 93407d29     	sxtw	x9, w9
40003e10: 9100052a     	add	x10, x9, #0x1
40003e14: 38296b28     	strb	w8, [x25, x9]
40003e18: b90b86ea     	str	w10, [x23, #0xb84]
40003e1c: 382a6b3f     	strb	wzr, [x25, x10]
40003e20: b94002a9     	ldr	w9, [x21]
40003e24: 372fffe9     	tbnz	w9, #0x5, 0x40003e20 <uart_printf+0x190>
40003e28: 17ffffc0     	b	0x40003d28 <uart_printf+0x98>
40003e2c: 2a0803e9     	mov	w9, w8
40003e30: aa0a03f4     	mov	x20, x10
40003e34: 7101bd3f     	cmp	w9, #0x6f
40003e38: 54fffa6c     	b.gt	0x40003d84 <uart_printf+0xf4>
40003e3c: 7100953f     	cmp	w9, #0x25
40003e40: 54000440     	b.eq	0x40003ec8 <uart_printf+0x238>
40003e44: 71018d3f     	cmp	w9, #0x63
40003e48: 54000c00     	b.eq	0x40003fc8 <uart_printf+0x338>
40003e4c: 7101913f     	cmp	w9, #0x64
40003e50: 540005a1     	b.ne	0x40003f04 <uart_printf+0x274>
40003e54: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e58: 7101b11f     	cmp	w8, #0x6c
40003e5c: 540017c1     	b.ne	0x40004154 <uart_printf+0x4c4>
40003e60: 36f823c9     	tbz	w9, #0x1f, 0x400042d8 <uart_printf+0x648>
40003e64: 11002128     	add	w8, w9, #0x8
40003e68: 3100213f     	cmn	w9, #0x8
40003e6c: b90053e8     	str	w8, [sp, #0x50]
40003e70: 54002348     	b.hi	0x400042d8 <uart_printf+0x648>
40003e74: f94023e8     	ldr	x8, [sp, #0x40]
40003e78: 8b090108     	add	x8, x8, x9
40003e7c: f9400108     	ldr	x8, [x8]
40003e80: b6f829a8     	tbz	x8, #0x3f, 0x400043b4 <uart_printf+0x724>
40003e84: 1400011a     	b	0x400042ec <uart_printf+0x65c>
40003e88: 7101d53f     	cmp	w9, #0x75
40003e8c: 54000840     	b.eq	0x40003f94 <uart_printf+0x304>
40003e90: 7101e13f     	cmp	w9, #0x78
40003e94: 54000381     	b.ne	0x40003f04 <uart_printf+0x274>
40003e98: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e9c: 7101b11f     	cmp	w8, #0x6c
40003ea0: 540014a1     	b.ne	0x40004134 <uart_printf+0x4a4>
40003ea4: 36f81d49     	tbz	w9, #0x1f, 0x4000424c <uart_printf+0x5bc>
40003ea8: 11002128     	add	w8, w9, #0x8
40003eac: 3100213f     	cmn	w9, #0x8
40003eb0: b90053e8     	str	w8, [sp, #0x50]
40003eb4: 54001cc8     	b.hi	0x4000424c <uart_printf+0x5bc>
40003eb8: f94023e8     	ldr	x8, [sp, #0x40]
40003ebc: 8b090108     	add	x8, x8, x9
40003ec0: f9400108     	ldr	x8, [x8]
40003ec4: 140000eb     	b	0x40004270 <uart_printf+0x5e0>
40003ec8: b94b82c8     	ldr	w8, [x22, #0xb80]
40003ecc: 34000128     	cbz	w8, 0x40003ef0 <uart_printf+0x260>
40003ed0: b94b86e8     	ldr	w8, [x23, #0xb84]
40003ed4: 6b18011f     	cmp	w8, w24
40003ed8: 540000cc     	b.gt	0x40003ef0 <uart_printf+0x260>
40003edc: 93407d08     	sxtw	x8, w8
40003ee0: 91000509     	add	x9, x8, #0x1
40003ee4: 38286b2e     	strb	w14, [x25, x8]
40003ee8: b90b86e9     	str	w9, [x23, #0xb84]
40003eec: 38296b3f     	strb	wzr, [x25, x9]
40003ef0: b94002a8     	ldr	w8, [x21]
40003ef4: 372fffe8     	tbnz	w8, #0x5, 0x40003ef0 <uart_printf+0x260>
40003ef8: b900036e     	str	w14, [x27]
40003efc: 91000694     	add	x20, x20, #0x1
40003f00: 17ffff8c     	b	0x40003d30 <uart_printf+0xa0>
40003f04: b94b82c8     	ldr	w8, [x22, #0xb80]
40003f08: 34000128     	cbz	w8, 0x40003f2c <uart_printf+0x29c>
40003f0c: b94b86e8     	ldr	w8, [x23, #0xb84]
40003f10: 6b18011f     	cmp	w8, w24
40003f14: 540000cc     	b.gt	0x40003f2c <uart_printf+0x29c>
40003f18: 93407d08     	sxtw	x8, w8
40003f1c: 91000509     	add	x9, x8, #0x1
40003f20: 38286b2e     	strb	w14, [x25, x8]
40003f24: b90b86e9     	str	w9, [x23, #0xb84]
40003f28: 38296b3f     	strb	wzr, [x25, x9]
40003f2c: b94002a8     	ldr	w8, [x21]
40003f30: 372fffe8     	tbnz	w8, #0x5, 0x40003f2c <uart_printf+0x29c>
40003f34: b900036e     	str	w14, [x27]
40003f38: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f3c: 38746a68     	ldrb	w8, [x19, x20]
40003f40: 34000129     	cbz	w9, 0x40003f64 <uart_printf+0x2d4>
40003f44: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f48: 6b18013f     	cmp	w9, w24
40003f4c: 540000cc     	b.gt	0x40003f64 <uart_printf+0x2d4>
40003f50: 93407d29     	sxtw	x9, w9
40003f54: 9100052a     	add	x10, x9, #0x1
40003f58: 38296b28     	strb	w8, [x25, x9]
40003f5c: b90b86ea     	str	w10, [x23, #0xb84]
40003f60: 382a6b3f     	strb	wzr, [x25, x10]
40003f64: b94002a9     	ldr	w9, [x21]
40003f68: 372fffe9     	tbnz	w9, #0x5, 0x40003f64 <uart_printf+0x2d4>
40003f6c: 17ffff6f     	b	0x40003d28 <uart_printf+0x98>
40003f70: b98053e8     	ldrsw	x8, [sp, #0x50]
40003f74: 36f803c8     	tbz	w8, #0x1f, 0x40003fec <uart_printf+0x35c>
40003f78: 11002109     	add	w9, w8, #0x8
40003f7c: 3100211f     	cmn	w8, #0x8
40003f80: b90053e9     	str	w9, [sp, #0x50]
40003f84: 54000348     	b.hi	0x40003fec <uart_printf+0x35c>
40003f88: f94023e9     	ldr	x9, [sp, #0x40]
40003f8c: 8b080128     	add	x8, x9, x8
40003f90: 1400001a     	b	0x40003ff8 <uart_printf+0x368>
40003f94: b98053e9     	ldrsw	x9, [sp, #0x50]
40003f98: 7101b11f     	cmp	w8, #0x6c
40003f9c: 54000bc1     	b.ne	0x40004114 <uart_printf+0x484>
40003fa0: 36f80ea9     	tbz	w9, #0x1f, 0x40004174 <uart_printf+0x4e4>
40003fa4: 11002128     	add	w8, w9, #0x8
40003fa8: 3100213f     	cmn	w9, #0x8
40003fac: b90053e8     	str	w8, [sp, #0x50]
40003fb0: 54000e28     	b.hi	0x40004174 <uart_printf+0x4e4>
40003fb4: f94023e8     	ldr	x8, [sp, #0x40]
40003fb8: 8b090108     	add	x8, x8, x9
40003fbc: f9400109     	ldr	x9, [x8]
40003fc0: b50010a9     	cbnz	x9, 0x400041d4 <uart_printf+0x544>
40003fc4: 14000071     	b	0x40004188 <uart_printf+0x4f8>
40003fc8: b98053e8     	ldrsw	x8, [sp, #0x50]
40003fcc: 36f80828     	tbz	w8, #0x1f, 0x400040d0 <uart_printf+0x440>
40003fd0: 11002109     	add	w9, w8, #0x8
40003fd4: 3100211f     	cmn	w8, #0x8
40003fd8: b90053e9     	str	w9, [sp, #0x50]
40003fdc: 540007a8     	b.hi	0x400040d0 <uart_printf+0x440>
40003fe0: f94023e9     	ldr	x9, [sp, #0x40]
40003fe4: 8b080128     	add	x8, x9, x8
40003fe8: 1400003d     	b	0x400040dc <uart_printf+0x44c>
40003fec: f9401fe8     	ldr	x8, [sp, #0x38]
40003ff0: 91002109     	add	x9, x8, #0x8
40003ff4: f9001fe9     	str	x9, [sp, #0x38]
40003ff8: f9400100     	ldr	x0, [x8]
40003ffc: 97fffe83     	bl	0x40003a08 <uart_print_hex>
40004000: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40004004: 528004ae     	mov	w14, #0x25              // =37
40004008: 52800150     	mov	w16, #0xa               // =10
4000400c: f29999af     	movk	x15, #0xcccd
40004010: d503201f     	nop
40004014: 1002a771     	adr	x17, 0x40009500 <__rodata_start+0x500>
40004018: 91000694     	add	x20, x20, #0x1
4000401c: 17ffff45     	b	0x40003d30 <uart_printf+0xa0>
40004020: f9401fe8     	ldr	x8, [sp, #0x38]
40004024: 91002109     	add	x9, x8, #0x8
40004028: f9001fe9     	str	x9, [sp, #0x38]
4000402c: f9400108     	ldr	x8, [x8]
40004030: f0000029     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40004034: 912bc929     	add	x9, x9, #0xaf2
40004038: f100011f     	cmp	x8, #0x0
4000403c: 9a880128     	csel	x8, x9, x8, eq
40004040: 39400109     	ldrb	w9, [x8]
40004044: 7100293f     	cmp	w9, #0xa
40004048: 540000a0     	b.eq	0x4000405c <uart_printf+0x3cc>
4000404c: 34ffe709     	cbz	w9, 0x40003d2c <uart_printf+0x9c>
40004050: b94b82ca     	ldr	w10, [x22, #0xb80]
40004054: 3500024a     	cbnz	w10, 0x4000409c <uart_printf+0x40c>
40004058: 14000019     	b	0x400040bc <uart_printf+0x42c>
4000405c: b94b82c9     	ldr	w9, [x22, #0xb80]
40004060: 34000129     	cbz	w9, 0x40004084 <uart_printf+0x3f4>
40004064: b94b86e9     	ldr	w9, [x23, #0xb84]
40004068: 6b18013f     	cmp	w9, w24
4000406c: 540000cc     	b.gt	0x40004084 <uart_printf+0x3f4>
40004070: 93407d29     	sxtw	x9, w9
40004074: 9100052a     	add	x10, x9, #0x1
40004078: 38296b3a     	strb	w26, [x25, x9]
4000407c: b90b86ea     	str	w10, [x23, #0xb84]
40004080: 382a6b3f     	strb	wzr, [x25, x10]
40004084: b94002a9     	ldr	w9, [x21]
40004088: 372fffe9     	tbnz	w9, #0x5, 0x40004084 <uart_printf+0x3f4>
4000408c: b900037a     	str	w26, [x27]
40004090: 39400109     	ldrb	w9, [x8]
40004094: b94b82ca     	ldr	w10, [x22, #0xb80]
40004098: 3400012a     	cbz	w10, 0x400040bc <uart_printf+0x42c>
4000409c: b94b86ea     	ldr	w10, [x23, #0xb84]
400040a0: 6b18015f     	cmp	w10, w24
400040a4: 540000cc     	b.gt	0x400040bc <uart_printf+0x42c>
400040a8: 93407d4a     	sxtw	x10, w10
400040ac: 9100054b     	add	x11, x10, #0x1
400040b0: 382a6b29     	strb	w9, [x25, x10]
400040b4: b90b86eb     	str	w11, [x23, #0xb84]
400040b8: 382b6b3f     	strb	wzr, [x25, x11]
400040bc: 91000508     	add	x8, x8, #0x1
400040c0: b94002aa     	ldr	w10, [x21]
400040c4: 372fffea     	tbnz	w10, #0x5, 0x400040c0 <uart_printf+0x430>
400040c8: b9000369     	str	w9, [x27]
400040cc: 17ffffdd     	b	0x40004040 <uart_printf+0x3b0>
400040d0: f9401fe8     	ldr	x8, [sp, #0x38]
400040d4: 91002109     	add	x9, x8, #0x8
400040d8: f9001fe9     	str	x9, [sp, #0x38]
400040dc: b94b82c9     	ldr	w9, [x22, #0xb80]
400040e0: 39400108     	ldrb	w8, [x8]
400040e4: 34000129     	cbz	w9, 0x40004108 <uart_printf+0x478>
400040e8: b94b86e9     	ldr	w9, [x23, #0xb84]
400040ec: 6b18013f     	cmp	w9, w24
400040f0: 540000cc     	b.gt	0x40004108 <uart_printf+0x478>
400040f4: 93407d29     	sxtw	x9, w9
400040f8: 9100052a     	add	x10, x9, #0x1
400040fc: 38296b28     	strb	w8, [x25, x9]
40004100: b90b86ea     	str	w10, [x23, #0xb84]
40004104: 382a6b3f     	strb	wzr, [x25, x10]
40004108: b94002a9     	ldr	w9, [x21]
4000410c: 372fffe9     	tbnz	w9, #0x5, 0x40004108 <uart_printf+0x478>
40004110: 17ffff06     	b	0x40003d28 <uart_printf+0x98>
40004114: 36f80569     	tbz	w9, #0x1f, 0x400041c0 <uart_printf+0x530>
40004118: 11002128     	add	w8, w9, #0x8
4000411c: 3100213f     	cmn	w9, #0x8
40004120: b90053e8     	str	w8, [sp, #0x50]
40004124: 540004e8     	b.hi	0x400041c0 <uart_printf+0x530>
40004128: f94023e8     	ldr	x8, [sp, #0x40]
4000412c: 8b090108     	add	x8, x8, x9
40004130: 14000027     	b	0x400041cc <uart_printf+0x53c>
40004134: 36f80969     	tbz	w9, #0x1f, 0x40004260 <uart_printf+0x5d0>
40004138: 11002128     	add	w8, w9, #0x8
4000413c: 3100213f     	cmn	w9, #0x8
40004140: b90053e8     	str	w8, [sp, #0x50]
40004144: 540008e8     	b.hi	0x40004260 <uart_printf+0x5d0>
40004148: f94023e8     	ldr	x8, [sp, #0x40]
4000414c: 8b090108     	add	x8, x8, x9
40004150: 14000047     	b	0x4000426c <uart_printf+0x5dc>
40004154: 36f81269     	tbz	w9, #0x1f, 0x400043a0 <uart_printf+0x710>
40004158: 11002128     	add	w8, w9, #0x8
4000415c: 3100213f     	cmn	w9, #0x8
40004160: b90053e8     	str	w8, [sp, #0x50]
40004164: 540011e8     	b.hi	0x400043a0 <uart_printf+0x710>
40004168: f94023e8     	ldr	x8, [sp, #0x40]
4000416c: 8b090108     	add	x8, x8, x9
40004170: 1400008f     	b	0x400043ac <uart_printf+0x71c>
40004174: f9401fe8     	ldr	x8, [sp, #0x38]
40004178: 91002109     	add	x9, x8, #0x8
4000417c: f9001fe9     	str	x9, [sp, #0x38]
40004180: f9400109     	ldr	x9, [x8]
40004184: b5000289     	cbnz	x9, 0x400041d4 <uart_printf+0x544>
40004188: b94b82c8     	ldr	w8, [x22, #0xb80]
4000418c: 34000148     	cbz	w8, 0x400041b4 <uart_printf+0x524>
40004190: b94b86e8     	ldr	w8, [x23, #0xb84]
40004194: 6b18011f     	cmp	w8, w24
40004198: 540000ec     	b.gt	0x400041b4 <uart_printf+0x524>
4000419c: 93407d08     	sxtw	x8, w8
400041a0: 5280060a     	mov	w10, #0x30              // =48
400041a4: 91000509     	add	x9, x8, #0x1
400041a8: 38286b2a     	strb	w10, [x25, x8]
400041ac: b90b86e9     	str	w9, [x23, #0xb84]
400041b0: 38296b3f     	strb	wzr, [x25, x9]
400041b4: b94002a8     	ldr	w8, [x21]
400041b8: 372fffe8     	tbnz	w8, #0x5, 0x400041b4 <uart_printf+0x524>
400041bc: 17fffeda     	b	0x40003d24 <uart_printf+0x94>
400041c0: f9401fe8     	ldr	x8, [sp, #0x38]
400041c4: 91002109     	add	x9, x8, #0x8
400041c8: f9001fe9     	str	x9, [sp, #0x38]
400041cc: b9400109     	ldr	w9, [x8]
400041d0: b4fffdc9     	cbz	x9, 0x40004188 <uart_printf+0x4f8>
400041d4: aa1f03ea     	mov	x10, xzr
400041d8: 9bcf7d28     	umulh	x8, x9, x15
400041dc: f100253f     	cmp	x9, #0x9
400041e0: d343fd0b     	lsr	x11, x8, #3
400041e4: 91000548     	add	x8, x10, #0x1
400041e8: 1b10a56c     	msub	w12, w11, w16, w9
400041ec: 321c0589     	orr	w9, w12, #0x30
400041f0: 382a6b89     	strb	w9, [x28, x10]
400041f4: aa0803ea     	mov	x10, x8
400041f8: aa0b03e9     	mov	x9, x11
400041fc: 54fffee8     	b.hi	0x400041d8 <uart_printf+0x548>
40004200: d1000509     	sub	x9, x8, #0x1
40004204: b94b82cb     	ldr	w11, [x22, #0xb80]
40004208: 38696b8a     	ldrb	w10, [x28, x9]
4000420c: 3400012b     	cbz	w11, 0x40004230 <uart_printf+0x5a0>
40004210: b94b86eb     	ldr	w11, [x23, #0xb84]
40004214: 6b18017f     	cmp	w11, w24
40004218: 540000cc     	b.gt	0x40004230 <uart_printf+0x5a0>
4000421c: 93407d6b     	sxtw	x11, w11
40004220: 9100056c     	add	x12, x11, #0x1
40004224: 382b6b2a     	strb	w10, [x25, x11]
40004228: b90b86ec     	str	w12, [x23, #0xb84]
4000422c: 382c6b3f     	strb	wzr, [x25, x12]
40004230: b94002ab     	ldr	w11, [x21]
40004234: 372fffeb     	tbnz	w11, #0x5, 0x40004230 <uart_printf+0x5a0>
40004238: 7100051f     	cmp	w8, #0x1
4000423c: aa0903e8     	mov	x8, x9
40004240: b900036a     	str	w10, [x27]
40004244: 54fffdec     	b.gt	0x40004200 <uart_printf+0x570>
40004248: 17fffeb9     	b	0x40003d2c <uart_printf+0x9c>
4000424c: f9401fe8     	ldr	x8, [sp, #0x38]
40004250: 91002109     	add	x9, x8, #0x8
40004254: f9001fe9     	str	x9, [sp, #0x38]
40004258: f9400108     	ldr	x8, [x8]
4000425c: 14000005     	b	0x40004270 <uart_printf+0x5e0>
40004260: f9401fe8     	ldr	x8, [sp, #0x38]
40004264: 91002109     	add	x9, x8, #0x8
40004268: f9001fe9     	str	x9, [sp, #0x38]
4000426c: b9400108     	ldr	w8, [x8]
40004270: 2a1f03e9     	mov	w9, wzr
40004274: 5280078a     	mov	w10, #0x3c              // =60
40004278: 14000003     	b	0x40004284 <uart_printf+0x5f4>
4000427c: b4000daa     	cbz	x10, 0x40004430 <uart_printf+0x7a0>
40004280: d100114a     	sub	x10, x10, #0x4
40004284: 9aca250b     	lsr	x11, x8, x10
40004288: f2400d6b     	ands	x11, x11, #0xf
4000428c: fa400944     	ccmp	x10, #0x0, #0x4, eq
40004290: 1a9f1529     	csinc	w9, w9, wzr, ne
40004294: 34ffff49     	cbz	w9, 0x4000427c <uart_printf+0x5ec>
40004298: b94b82cc     	ldr	w12, [x22, #0xb80]
4000429c: 386b6a2b     	ldrb	w11, [x17, x11]
400042a0: 3400012c     	cbz	w12, 0x400042c4 <uart_printf+0x634>
400042a4: b94b86ec     	ldr	w12, [x23, #0xb84]
400042a8: 6b18019f     	cmp	w12, w24
400042ac: 540000cc     	b.gt	0x400042c4 <uart_printf+0x634>
400042b0: 93407d8c     	sxtw	x12, w12
400042b4: 9100058d     	add	x13, x12, #0x1
400042b8: 382c6b2b     	strb	w11, [x25, x12]
400042bc: b90b86ed     	str	w13, [x23, #0xb84]
400042c0: 382d6b3f     	strb	wzr, [x25, x13]
400042c4: b94002ac     	ldr	w12, [x21]
400042c8: 372fffec     	tbnz	w12, #0x5, 0x400042c4 <uart_printf+0x634>
400042cc: b900036b     	str	w11, [x27]
400042d0: b5fffd8a     	cbnz	x10, 0x40004280 <uart_printf+0x5f0>
400042d4: 17fffe96     	b	0x40003d2c <uart_printf+0x9c>
400042d8: f9401fe8     	ldr	x8, [sp, #0x38]
400042dc: 91002109     	add	x9, x8, #0x8
400042e0: f9001fe9     	str	x9, [sp, #0x38]
400042e4: f9400108     	ldr	x8, [x8]
400042e8: b6f80668     	tbz	x8, #0x3f, 0x400043b4 <uart_printf+0x724>
400042ec: b94b82c9     	ldr	w9, [x22, #0xb80]
400042f0: 34000149     	cbz	w9, 0x40004318 <uart_printf+0x688>
400042f4: b94b86e9     	ldr	w9, [x23, #0xb84]
400042f8: 6b18013f     	cmp	w9, w24
400042fc: 540000ec     	b.gt	0x40004318 <uart_printf+0x688>
40004300: 93407d29     	sxtw	x9, w9
40004304: 528005ab     	mov	w11, #0x2d              // =45
40004308: 9100052a     	add	x10, x9, #0x1
4000430c: 38296b2b     	strb	w11, [x25, x9]
40004310: b90b86ea     	str	w10, [x23, #0xb84]
40004314: 382a6b3f     	strb	wzr, [x25, x10]
40004318: b94002a9     	ldr	w9, [x21]
4000431c: 372fffe9     	tbnz	w9, #0x5, 0x40004318 <uart_printf+0x688>
40004320: aa1f03e9     	mov	x9, xzr
40004324: 528005aa     	mov	w10, #0x2d              // =45
40004328: cb0803e8     	neg	x8, x8
4000432c: b900036a     	str	w10, [x27]
40004330: 9bcf7d0a     	umulh	x10, x8, x15
40004334: f100251f     	cmp	x8, #0x9
40004338: d343fd4a     	lsr	x10, x10, #3
4000433c: 1b10a14b     	msub	w11, w10, w16, w8
40004340: 321c0568     	orr	w8, w11, #0x30
40004344: 38296b88     	strb	w8, [x28, x9]
40004348: 91000529     	add	x9, x9, #0x1
4000434c: aa0a03e8     	mov	x8, x10
40004350: 54ffff08     	b.hi	0x40004330 <uart_printf+0x6a0>
40004354: d1000528     	sub	x8, x9, #0x1
40004358: b94b82cb     	ldr	w11, [x22, #0xb80]
4000435c: 38686b8a     	ldrb	w10, [x28, x8]
40004360: 3400012b     	cbz	w11, 0x40004384 <uart_printf+0x6f4>
40004364: b94b86eb     	ldr	w11, [x23, #0xb84]
40004368: 6b18017f     	cmp	w11, w24
4000436c: 540000cc     	b.gt	0x40004384 <uart_printf+0x6f4>
40004370: 93407d6b     	sxtw	x11, w11
40004374: 9100056c     	add	x12, x11, #0x1
40004378: 382b6b2a     	strb	w10, [x25, x11]
4000437c: b90b86ec     	str	w12, [x23, #0xb84]
40004380: 382c6b3f     	strb	wzr, [x25, x12]
40004384: b94002ab     	ldr	w11, [x21]
40004388: 372fffeb     	tbnz	w11, #0x5, 0x40004384 <uart_printf+0x6f4>
4000438c: 7100053f     	cmp	w9, #0x1
40004390: aa0803e9     	mov	x9, x8
40004394: b900036a     	str	w10, [x27]
40004398: 54fffdec     	b.gt	0x40004354 <uart_printf+0x6c4>
4000439c: 17fffe64     	b	0x40003d2c <uart_printf+0x9c>
400043a0: f9401fe8     	ldr	x8, [sp, #0x38]
400043a4: 91002109     	add	x9, x8, #0x8
400043a8: f9001fe9     	str	x9, [sp, #0x38]
400043ac: b9800108     	ldrsw	x8, [x8]
400043b0: b7fff9e8     	tbnz	x8, #0x3f, 0x400042ec <uart_printf+0x65c>
400043b4: b40005a8     	cbz	x8, 0x40004468 <uart_printf+0x7d8>
400043b8: aa1f03ea     	mov	x10, xzr
400043bc: 9bcf7d09     	umulh	x9, x8, x15
400043c0: f100251f     	cmp	x8, #0x9
400043c4: d343fd2b     	lsr	x11, x9, #3
400043c8: 91000549     	add	x9, x10, #0x1
400043cc: 1b10a16c     	msub	w12, w11, w16, w8
400043d0: 321c0588     	orr	w8, w12, #0x30
400043d4: 382a6b88     	strb	w8, [x28, x10]
400043d8: aa0903ea     	mov	x10, x9
400043dc: aa0b03e8     	mov	x8, x11
400043e0: 54fffee8     	b.hi	0x400043bc <uart_printf+0x72c>
400043e4: d1000528     	sub	x8, x9, #0x1
400043e8: b94b82cb     	ldr	w11, [x22, #0xb80]
400043ec: 38686b8a     	ldrb	w10, [x28, x8]
400043f0: 3400012b     	cbz	w11, 0x40004414 <uart_printf+0x784>
400043f4: b94b86eb     	ldr	w11, [x23, #0xb84]
400043f8: 6b18017f     	cmp	w11, w24
400043fc: 540000cc     	b.gt	0x40004414 <uart_printf+0x784>
40004400: 93407d6b     	sxtw	x11, w11
40004404: 9100056c     	add	x12, x11, #0x1
40004408: 382b6b2a     	strb	w10, [x25, x11]
4000440c: b90b86ec     	str	w12, [x23, #0xb84]
40004410: 382c6b3f     	strb	wzr, [x25, x12]
40004414: b94002ab     	ldr	w11, [x21]
40004418: 372fffeb     	tbnz	w11, #0x5, 0x40004414 <uart_printf+0x784>
4000441c: 7100053f     	cmp	w9, #0x1
40004420: aa0803e9     	mov	x9, x8
40004424: b900036a     	str	w10, [x27]
40004428: 54fffdec     	b.gt	0x400043e4 <uart_printf+0x754>
4000442c: 17fffe40     	b	0x40003d2c <uart_printf+0x9c>
40004430: b94b82c8     	ldr	w8, [x22, #0xb80]
40004434: 34000148     	cbz	w8, 0x4000445c <uart_printf+0x7cc>
40004438: b94b86e8     	ldr	w8, [x23, #0xb84]
4000443c: 6b18011f     	cmp	w8, w24
40004440: 540000ec     	b.gt	0x4000445c <uart_printf+0x7cc>
40004444: 93407d08     	sxtw	x8, w8
40004448: 5280060a     	mov	w10, #0x30              // =48
4000444c: 91000509     	add	x9, x8, #0x1
40004450: 38286b2a     	strb	w10, [x25, x8]
40004454: b90b86e9     	str	w9, [x23, #0xb84]
40004458: 38296b3f     	strb	wzr, [x25, x9]
4000445c: b94002a8     	ldr	w8, [x21]
40004460: 372fffe8     	tbnz	w8, #0x5, 0x4000445c <uart_printf+0x7cc>
40004464: 17fffe30     	b	0x40003d24 <uart_printf+0x94>
40004468: b94b82c8     	ldr	w8, [x22, #0xb80]
4000446c: 34000148     	cbz	w8, 0x40004494 <uart_printf+0x804>
40004470: b94b86e8     	ldr	w8, [x23, #0xb84]
40004474: 6b18011f     	cmp	w8, w24
40004478: 540000ec     	b.gt	0x40004494 <uart_printf+0x804>
4000447c: 93407d08     	sxtw	x8, w8
40004480: 5280060a     	mov	w10, #0x30              // =48
40004484: 91000509     	add	x9, x8, #0x1
40004488: 38286b2a     	strb	w10, [x25, x8]
4000448c: b90b86e9     	str	w9, [x23, #0xb84]
40004490: 38296b3f     	strb	wzr, [x25, x9]
40004494: b94002a8     	ldr	w8, [x21]
40004498: 372fffe8     	tbnz	w8, #0x5, 0x40004494 <uart_printf+0x804>
4000449c: 17fffe22     	b	0x40003d24 <uart_printf+0x94>
400044a0: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
400044a4: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
400044a8: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
400044ac: a94967fa     	ldp	x26, x25, [sp, #0x90]
400044b0: a9486ffc     	ldp	x28, x27, [sp, #0x80]
400044b4: a9477bfd     	ldp	x29, x30, [sp, #0x70]
400044b8: 910343ff     	add	sp, sp, #0xd0
400044bc: d65f03c0     	ret

00000000400044c0 <vfs_init>:
400044c0: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
400044c4: a9044ff4     	stp	x20, x19, [sp, #0x40]
400044c8: b0000093     	adrp	x19, 0x40015000 <kernel_capture_buffer+0x3478>
400044cc: 912e8273     	add	x19, x19, #0xba0
400044d0: f9000bf9     	str	x25, [sp, #0x10]
400044d4: b0000099     	adrp	x25, 0x40015000 <kernel_capture_buffer+0x3478>
400044d8: 52800034     	mov	w20, #0x1               // =1
400044dc: aa1303e0     	mov	x0, x19
400044e0: 2a1f03e1     	mov	w1, wzr
400044e4: 52809802     	mov	w2, #0x4c0              // =1216
400044e8: a9025ff8     	stp	x24, x23, [sp, #0x20]
400044ec: 910003fd     	mov	x29, sp
400044f0: a90357f6     	stp	x22, x21, [sp, #0x30]
400044f4: b90b8b34     	str	w20, [x25, #0xb88]
400044f8: 97fff981     	bl	0x40002afc <memset>
400044fc: 528005e8     	mov	w8, #0x2f               // =47
40004500: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004504: b9002274     	str	w20, [x19, #0x20]
40004508: 79000268     	strh	w8, [x19]
4000450c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004510: f905c933     	str	x19, [x9, #0xb90]
40004514: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004518: 7101fd1f     	cmp	w8, #0x7f
4000451c: f9021a7f     	str	xzr, [x19, #0x430]
40004520: f900167f     	str	xzr, [x19, #0x28]
40004524: b904ba7f     	str	wzr, [x19, #0x4b8]
40004528: f905cd33     	str	x19, [x9, #0xb98]
4000452c: 540028ac     	b.gt	0x40004a40 <vfs_init+0x580>
40004530: 52809809     	mov	w9, #0x4c0              // =1216
40004534: 2a1f03e1     	mov	w1, wzr
40004538: 52809802     	mov	w2, #0x4c0              // =1216
4000453c: 9b294d17     	smaddl	x23, w8, w9, x19
40004540: 11000508     	add	w8, w8, #0x1
40004544: b90b8b28     	str	w8, [x25, #0xb88]
40004548: aa1703e0     	mov	x0, x23
4000454c: 97fff96c     	bl	0x40002afc <memset>
40004550: 528d2c48     	mov	w8, #0x6962             // =26978
40004554: b904baff     	str	wzr, [x23, #0x4b8]
40004558: 72a00dc8     	movk	w8, #0x6e, lsl #16
4000455c: b90022f4     	str	w20, [x23, #0x20]
40004560: b90002e8     	str	w8, [x23]
40004564: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004568: f9021af3     	str	x19, [x23, #0x430]
4000456c: 71003d1f     	cmp	w8, #0xf
40004570: f90016ff     	str	xzr, [x23, #0x28]
40004574: 540000ac     	b.gt	0x40004588 <vfs_init+0xc8>
40004578: 11000509     	add	w9, w8, #0x1
4000457c: 8b080e68     	add	x8, x19, x8, lsl #3
40004580: b904ba69     	str	w9, [x19, #0x4b8]
40004584: f9021d17     	str	x23, [x8, #0x438]
40004588: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000458c: 7101fd1f     	cmp	w8, #0x7f
40004590: 5400258c     	b.gt	0x40004a40 <vfs_init+0x580>
40004594: 52809809     	mov	w9, #0x4c0              // =1216
40004598: 2a1f03e1     	mov	w1, wzr
4000459c: 52809802     	mov	w2, #0x4c0              // =1216
400045a0: 9b294d16     	smaddl	x22, w8, w9, x19
400045a4: 11000508     	add	w8, w8, #0x1
400045a8: b90b8b28     	str	w8, [x25, #0xb88]
400045ac: aa1603e0     	mov	x0, x22
400045b0: 97fff953     	bl	0x40002afc <memset>
400045b4: 528e8ca8     	mov	w8, #0x7465             // =29797
400045b8: b904badf     	str	wzr, [x22, #0x4b8]
400045bc: 52800029     	mov	w9, #0x1                // =1
400045c0: 72a00c68     	movk	w8, #0x63, lsl #16
400045c4: b90022c9     	str	w9, [x22, #0x20]
400045c8: b90002c8     	str	w8, [x22]
400045cc: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400045d0: f9021ad3     	str	x19, [x22, #0x430]
400045d4: 71003d1f     	cmp	w8, #0xf
400045d8: f90016df     	str	xzr, [x22, #0x28]
400045dc: 540000ac     	b.gt	0x400045f0 <vfs_init+0x130>
400045e0: 11000509     	add	w9, w8, #0x1
400045e4: 8b080e68     	add	x8, x19, x8, lsl #3
400045e8: b904ba69     	str	w9, [x19, #0x4b8]
400045ec: f9021d16     	str	x22, [x8, #0x438]
400045f0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045f4: 7101fd1f     	cmp	w8, #0x7f
400045f8: 5400224c     	b.gt	0x40004a40 <vfs_init+0x580>
400045fc: 52809809     	mov	w9, #0x4c0              // =1216
40004600: 2a1f03e1     	mov	w1, wzr
40004604: 52809802     	mov	w2, #0x4c0              // =1216
40004608: 9b294d14     	smaddl	x20, w8, w9, x19
4000460c: 11000508     	add	w8, w8, #0x1
40004610: b90b8b28     	str	w8, [x25, #0xb88]
40004614: aa1403e0     	mov	x0, x20
40004618: 97fff939     	bl	0x40002afc <memset>
4000461c: 528ded08     	mov	w8, #0x6f68             // =28520
40004620: b904ba9f     	str	wzr, [x20, #0x4b8]
40004624: 52800029     	mov	w9, #0x1                // =1
40004628: 72acada8     	movk	w8, #0x656d, lsl #16
4000462c: 3900129f     	strb	wzr, [x20, #0x4]
40004630: b9000288     	str	w8, [x20]
40004634: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004638: b9002289     	str	w9, [x20, #0x20]
4000463c: 71003d1f     	cmp	w8, #0xf
40004640: f9021a93     	str	x19, [x20, #0x430]
40004644: f900169f     	str	xzr, [x20, #0x28]
40004648: 540000ac     	b.gt	0x4000465c <vfs_init+0x19c>
4000464c: 11000509     	add	w9, w8, #0x1
40004650: 8b080e68     	add	x8, x19, x8, lsl #3
40004654: b904ba69     	str	w9, [x19, #0x4b8]
40004658: f9021d14     	str	x20, [x8, #0x438]
4000465c: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004660: 7101fd1f     	cmp	w8, #0x7f
40004664: 54001eec     	b.gt	0x40004a40 <vfs_init+0x580>
40004668: 52809809     	mov	w9, #0x4c0              // =1216
4000466c: 2a1f03e1     	mov	w1, wzr
40004670: 52809802     	mov	w2, #0x4c0              // =1216
40004674: 9b294d15     	smaddl	x21, w8, w9, x19
40004678: 11000508     	add	w8, w8, #0x1
4000467c: b90b8b28     	str	w8, [x25, #0xb88]
40004680: aa1503e0     	mov	x0, x21
40004684: 97fff91e     	bl	0x40002afc <memset>
40004688: 528dec88     	mov	w8, #0x6f64             // =28516
4000468c: b904babf     	str	wzr, [x21, #0x4b8]
40004690: 52800029     	mov	w9, #0x1                // =1
40004694: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004698: 390012bf     	strb	wzr, [x21, #0x4]
4000469c: b90002a8     	str	w8, [x21]
400046a0: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400046a4: b90022a9     	str	w9, [x21, #0x20]
400046a8: 71003d1f     	cmp	w8, #0xf
400046ac: f9021ab3     	str	x19, [x21, #0x430]
400046b0: f90016bf     	str	xzr, [x21, #0x28]
400046b4: 540000ac     	b.gt	0x400046c8 <vfs_init+0x208>
400046b8: 11000509     	add	w9, w8, #0x1
400046bc: 8b080e68     	add	x8, x19, x8, lsl #3
400046c0: b904ba69     	str	w9, [x19, #0x4b8]
400046c4: f9021d15     	str	x21, [x8, #0x438]
400046c8: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400046cc: 7101fd1f     	cmp	w8, #0x7f
400046d0: 54001b8c     	b.gt	0x40004a40 <vfs_init+0x580>
400046d4: 52809809     	mov	w9, #0x4c0              // =1216
400046d8: 2a1f03e1     	mov	w1, wzr
400046dc: 52809802     	mov	w2, #0x4c0              // =1216
400046e0: 9b294d18     	smaddl	x24, w8, w9, x19
400046e4: 11000508     	add	w8, w8, #0x1
400046e8: b90b8b28     	str	w8, [x25, #0xb88]
400046ec: aa1803e0     	mov	x0, x24
400046f0: 97fff903     	bl	0x40002afc <memset>
400046f4: 528d2c28     	mov	w8, #0x6961             // =26977
400046f8: b904bb1f     	str	wzr, [x24, #0x4b8]
400046fc: 79000308     	strh	w8, [x24]
40004700: b984bae8     	ldrsw	x8, [x23, #0x4b8]
40004704: 39000b1f     	strb	wzr, [x24, #0x2]
40004708: 71003d1f     	cmp	w8, #0xf
4000470c: b900231f     	str	wzr, [x24, #0x20]
40004710: f9021b17     	str	x23, [x24, #0x430]
40004714: f900171f     	str	xzr, [x24, #0x28]
40004718: 540000ac     	b.gt	0x4000472c <vfs_init+0x26c>
4000471c: 8b080ee9     	add	x9, x23, x8, lsl #3
40004720: 11000508     	add	w8, w8, #0x1
40004724: b904bae8     	str	w8, [x23, #0x4b8]
40004728: f9021d38     	str	x24, [x9, #0x438]
4000472c: d503201f     	nop
40004730: 70039377     	adr	x23, 0x4000b99f <__rodata_start+0x299f>
40004734: 9100c300     	add	x0, x24, #0x30
40004738: aa1703e1     	mov	x1, x23
4000473c: 97fff8c4     	bl	0x40002a4c <kstrcpy>
40004740: aa1703e0     	mov	x0, x23
40004744: 97fff893     	bl	0x40002990 <kstrlen>
40004748: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000474c: f9001700     	str	x0, [x24, #0x28]
40004750: 7101fd1f     	cmp	w8, #0x7f
40004754: 5400176c     	b.gt	0x40004a40 <vfs_init+0x580>
40004758: 52809809     	mov	w9, #0x4c0              // =1216
4000475c: 2a1f03e1     	mov	w1, wzr
40004760: 52809802     	mov	w2, #0x4c0              // =1216
40004764: 9b294d17     	smaddl	x23, w8, w9, x19
40004768: 11000508     	add	w8, w8, #0x1
4000476c: b90b8b28     	str	w8, [x25, #0xb88]
40004770: aa1703e0     	mov	x0, x23
40004774: 97fff8e2     	bl	0x40002afc <memset>
40004778: d28e6de8     	mov	x8, #0x736f             // =29551
4000477c: b904baff     	str	wzr, [x23, #0x4b8]
40004780: 528cae69     	mov	w9, #0x6573             // =25971
40004784: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004788: 790012e9     	strh	w9, [x23, #0x8]
4000478c: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
40004790: 39002aff     	strb	wzr, [x23, #0xa]
40004794: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004798: b90022ff     	str	wzr, [x23, #0x20]
4000479c: f90002e8     	str	x8, [x23]
400047a0: b984bac8     	ldrsw	x8, [x22, #0x4b8]
400047a4: f9021af6     	str	x22, [x23, #0x430]
400047a8: 71003d1f     	cmp	w8, #0xf
400047ac: f90016ff     	str	xzr, [x23, #0x28]
400047b0: 540000ac     	b.gt	0x400047c4 <vfs_init+0x304>
400047b4: 8b080ec9     	add	x9, x22, x8, lsl #3
400047b8: 11000508     	add	w8, w8, #0x1
400047bc: b904bac8     	str	w8, [x22, #0x4b8]
400047c0: f9021d37     	str	x23, [x9, #0x438]
400047c4: b0000036     	adrp	x22, 0x40009000 <__rodata_start>
400047c8: 913a92d6     	add	x22, x22, #0xea4
400047cc: 9100c2e0     	add	x0, x23, #0x30
400047d0: aa1603e1     	mov	x1, x22
400047d4: 97fff89e     	bl	0x40002a4c <kstrcpy>
400047d8: aa1603e0     	mov	x0, x22
400047dc: 97fff86d     	bl	0x40002990 <kstrlen>
400047e0: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047e4: f90016e0     	str	x0, [x23, #0x28]
400047e8: 7101fd1f     	cmp	w8, #0x7f
400047ec: 540012ac     	b.gt	0x40004a40 <vfs_init+0x580>
400047f0: 52809809     	mov	w9, #0x4c0              // =1216
400047f4: 2a1f03e1     	mov	w1, wzr
400047f8: 52809802     	mov	w2, #0x4c0              // =1216
400047fc: 9b294d16     	smaddl	x22, w8, w9, x19
40004800: 11000508     	add	w8, w8, #0x1
40004804: b90b8b28     	str	w8, [x25, #0xb88]
40004808: aa1603e0     	mov	x0, x22
4000480c: 97fff8bc     	bl	0x40002afc <memset>
40004810: d28caee8     	mov	x8, #0x6577             // =25975
40004814: b904badf     	str	wzr, [x22, #0x4b8]
40004818: 528f0e89     	mov	w9, #0x7874             // =30836
4000481c: f2ac6d88     	movk	x8, #0x636c, lsl #16
40004820: 72a00e89     	movk	w9, #0x74, lsl #16
40004824: b90022df     	str	wzr, [x22, #0x20]
40004828: f2cdade8     	movk	x8, #0x6d6f, lsl #32
4000482c: b9000ac9     	str	w9, [x22, #0x8]
40004830: f2e5cca8     	movk	x8, #0x2e65, lsl #48
40004834: f9021ad5     	str	x21, [x22, #0x430]
40004838: f90002c8     	str	x8, [x22]
4000483c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004840: f90016df     	str	xzr, [x22, #0x28]
40004844: 71003d1f     	cmp	w8, #0xf
40004848: 540000ac     	b.gt	0x4000485c <vfs_init+0x39c>
4000484c: 8b080ea9     	add	x9, x21, x8, lsl #3
40004850: 11000508     	add	w8, w8, #0x1
40004854: b904baa8     	str	w8, [x21, #0x4b8]
40004858: f9021d36     	str	x22, [x9, #0x438]
4000485c: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
40004860: 910126f7     	add	x23, x23, #0x49
40004864: 9100c2c0     	add	x0, x22, #0x30
40004868: aa1703e1     	mov	x1, x23
4000486c: 97fff878     	bl	0x40002a4c <kstrcpy>
40004870: aa1703e0     	mov	x0, x23
40004874: 97fff847     	bl	0x40002990 <kstrlen>
40004878: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000487c: f90016c0     	str	x0, [x22, #0x28]
40004880: 7101fd1f     	cmp	w8, #0x7f
40004884: 54000dec     	b.gt	0x40004a40 <vfs_init+0x580>
40004888: 52809809     	mov	w9, #0x4c0              // =1216
4000488c: 2a1f03e1     	mov	w1, wzr
40004890: 52809802     	mov	w2, #0x4c0              // =1216
40004894: 9b294d16     	smaddl	x22, w8, w9, x19
40004898: 11000508     	add	w8, w8, #0x1
4000489c: b90b8b28     	str	w8, [x25, #0xb88]
400048a0: aa1603e0     	mov	x0, x22
400048a4: 97fff896     	bl	0x40002afc <memset>
400048a8: d28c2d08     	mov	x8, #0x6168             // =24936
400048ac: b904badf     	str	wzr, [x22, #0x4b8]
400048b0: 528e85c9     	mov	w9, #0x742e             // =29742
400048b4: f2ac8e48     	movk	x8, #0x6472, lsl #16
400048b8: 72ae8f09     	movk	w9, #0x7478, lsl #16
400048bc: 390032df     	strb	wzr, [x22, #0xc]
400048c0: f2cc2ee8     	movk	x8, #0x6177, lsl #32
400048c4: b9000ac9     	str	w9, [x22, #0x8]
400048c8: f2ecae48     	movk	x8, #0x6572, lsl #48
400048cc: b90022df     	str	wzr, [x22, #0x20]
400048d0: f90002c8     	str	x8, [x22]
400048d4: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400048d8: f9021ad5     	str	x21, [x22, #0x430]
400048dc: 71003d1f     	cmp	w8, #0xf
400048e0: f90016df     	str	xzr, [x22, #0x28]
400048e4: 540000ac     	b.gt	0x400048f8 <vfs_init+0x438>
400048e8: 8b080ea9     	add	x9, x21, x8, lsl #3
400048ec: 11000508     	add	w8, w8, #0x1
400048f0: b904baa8     	str	w8, [x21, #0x4b8]
400048f4: f9021d36     	str	x22, [x9, #0x438]
400048f8: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
400048fc: 91126af7     	add	x23, x23, #0x49a
40004900: 9100c2c0     	add	x0, x22, #0x30
40004904: aa1703e1     	mov	x1, x23
40004908: 97fff851     	bl	0x40002a4c <kstrcpy>
4000490c: aa1703e0     	mov	x0, x23
40004910: 97fff820     	bl	0x40002990 <kstrlen>
40004914: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004918: f90016c0     	str	x0, [x22, #0x28]
4000491c: 7101fd1f     	cmp	w8, #0x7f
40004920: 5400090c     	b.gt	0x40004a40 <vfs_init+0x580>
40004924: 52809809     	mov	w9, #0x4c0              // =1216
40004928: 2a1f03e1     	mov	w1, wzr
4000492c: 52809802     	mov	w2, #0x4c0              // =1216
40004930: 9b294d16     	smaddl	x22, w8, w9, x19
40004934: 11000508     	add	w8, w8, #0x1
40004938: b90b8b28     	str	w8, [x25, #0xb88]
4000493c: aa1603e0     	mov	x0, x22
40004940: 97fff86f     	bl	0x40002afc <memset>
40004944: 528d2c28     	mov	w8, #0x6961             // =26977
40004948: b904badf     	str	wzr, [x22, #0x4b8]
4000494c: 528e8f09     	mov	w9, #0x7478             // =29816
40004950: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004954: 79000ac9     	strh	w9, [x22, #0x4]
40004958: b90002c8     	str	w8, [x22]
4000495c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004960: 39001adf     	strb	wzr, [x22, #0x6]
40004964: 71003d1f     	cmp	w8, #0xf
40004968: b90022df     	str	wzr, [x22, #0x20]
4000496c: f9021ad5     	str	x21, [x22, #0x430]
40004970: f90016df     	str	xzr, [x22, #0x28]
40004974: 540000ac     	b.gt	0x40004988 <vfs_init+0x4c8>
40004978: 8b080ea9     	add	x9, x21, x8, lsl #3
4000497c: 11000508     	add	w8, w8, #0x1
40004980: b904baa8     	str	w8, [x21, #0x4b8]
40004984: f9021d36     	str	x22, [x9, #0x438]
40004988: f0000035     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
4000498c: 911a9eb5     	add	x21, x21, #0x6a7
40004990: 9100c2c0     	add	x0, x22, #0x30
40004994: aa1503e1     	mov	x1, x21
40004998: 97fff82d     	bl	0x40002a4c <kstrcpy>
4000499c: aa1503e0     	mov	x0, x21
400049a0: 97fff7fc     	bl	0x40002990 <kstrlen>
400049a4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400049a8: f90016c0     	str	x0, [x22, #0x28]
400049ac: 7101fd1f     	cmp	w8, #0x7f
400049b0: 5400048c     	b.gt	0x40004a40 <vfs_init+0x580>
400049b4: 52809809     	mov	w9, #0x4c0              // =1216
400049b8: 2a1f03e1     	mov	w1, wzr
400049bc: 52809802     	mov	w2, #0x4c0              // =1216
400049c0: 9b294d13     	smaddl	x19, w8, w9, x19
400049c4: 11000508     	add	w8, w8, #0x1
400049c8: b90b8b28     	str	w8, [x25, #0xb88]
400049cc: aa1303e0     	mov	x0, x19
400049d0: 97fff84b     	bl	0x40002afc <memset>
400049d4: d28cae48     	mov	x8, #0x6572             // =25970
400049d8: b904ba7f     	str	wzr, [x19, #0x4b8]
400049dc: 528e8f09     	mov	w9, #0x7478             // =29816
400049e0: f2ac8c28     	movk	x8, #0x6461, lsl #16
400049e4: 79001269     	strh	w9, [x19, #0x8]
400049e8: f2ccada8     	movk	x8, #0x656d, lsl #32
400049ec: 39002a7f     	strb	wzr, [x19, #0xa]
400049f0: f2ee85c8     	movk	x8, #0x742e, lsl #48
400049f4: b900227f     	str	wzr, [x19, #0x20]
400049f8: f9000268     	str	x8, [x19]
400049fc: b984ba88     	ldrsw	x8, [x20, #0x4b8]
40004a00: f9021a74     	str	x20, [x19, #0x430]
40004a04: 71003d1f     	cmp	w8, #0xf
40004a08: f900167f     	str	xzr, [x19, #0x28]
40004a0c: 540000ac     	b.gt	0x40004a20 <vfs_init+0x560>
40004a10: 8b080e89     	add	x9, x20, x8, lsl #3
40004a14: 11000508     	add	w8, w8, #0x1
40004a18: b904ba88     	str	w8, [x20, #0x4b8]
40004a1c: f9021d33     	str	x19, [x9, #0x438]
40004a20: b0000034     	adrp	x20, 0x40009000 <__rodata_start>
40004a24: 910e5e94     	add	x20, x20, #0x397
40004a28: 9100c260     	add	x0, x19, #0x30
40004a2c: aa1403e1     	mov	x1, x20
40004a30: 97fff807     	bl	0x40002a4c <kstrcpy>
40004a34: aa1403e0     	mov	x0, x20
40004a38: 97fff7d6     	bl	0x40002990 <kstrlen>
40004a3c: f9001660     	str	x0, [x19, #0x28]
40004a40: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004a44: f9400bf9     	ldr	x25, [sp, #0x10]
40004a48: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004a4c: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004a50: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004a54: d65f03c0     	ret

0000000040004a58 <vfs_get_root>:
40004a58: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a5c: f945c900     	ldr	x0, [x8, #0xb90]
40004a60: d65f03c0     	ret

0000000040004a64 <vfs_get_cwd>:
40004a64: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a68: f945cd00     	ldr	x0, [x8, #0xb98]
40004a6c: d65f03c0     	ret

0000000040004a70 <vfs_getcwd>:
40004a70: d10343ff     	sub	sp, sp, #0xd0
40004a74: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a78: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004a7c: aa0003f3     	mov	x19, x0
40004a80: f945cd08     	ldr	x8, [x8, #0xb98]
40004a84: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004a88: 910203fd     	add	x29, sp, #0x80
40004a8c: a90967fa     	stp	x26, x25, [sp, #0x90]
40004a90: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40004a94: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004a98: b4000228     	cbz	x8, 0x40004adc <vfs_getcwd+0x6c>
40004a9c: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004aa0: f945c929     	ldr	x9, [x9, #0xb90]
40004aa4: eb09011f     	cmp	x8, x9
40004aa8: 540001a0     	b.eq	0x40004adc <vfs_getcwd+0x6c>
40004aac: aa1f03ea     	mov	x10, xzr
40004ab0: 910003eb     	mov	x11, sp
40004ab4: eb09011f     	cmp	x8, x9
40004ab8: 540001e0     	b.eq	0x40004af4 <vfs_getcwd+0x84>
40004abc: f1003d5f     	cmp	x10, #0xf
40004ac0: 540001a8     	b.hi	0x40004af4 <vfs_getcwd+0x84>
40004ac4: f82a7968     	str	x8, [x11, x10, lsl #3]
40004ac8: f9421908     	ldr	x8, [x8, #0x430]
40004acc: 9100054c     	add	x12, x10, #0x1
40004ad0: aa0c03ea     	mov	x10, x12
40004ad4: b5ffff08     	cbnz	x8, 0x40004ab4 <vfs_getcwd+0x44>
40004ad8: 14000008     	b	0x40004af8 <vfs_getcwd+0x88>
40004adc: f100083f     	cmp	x1, #0x2
40004ae0: 54000583     	b.lo	0x40004b90 <vfs_getcwd+0x120>
40004ae4: 528005e8     	mov	w8, #0x2f               // =47
40004ae8: 3900067f     	strb	wzr, [x19, #0x1]
40004aec: 39000268     	strb	w8, [x19]
40004af0: 14000028     	b	0x40004b90 <vfs_getcwd+0x120>
40004af4: aa0a03ec     	mov	x12, x10
40004af8: 7100059f     	cmp	w12, #0x1
40004afc: 3900027f     	strb	wzr, [x19]
40004b00: 5400048b     	b.lt	0x40004b90 <vfs_getcwd+0x120>
40004b04: aa1f03f6     	mov	x22, xzr
40004b08: d1000435     	sub	x21, x1, #0x1
40004b0c: 92407999     	and	x25, x12, #0x7fffffff
40004b10: 528005f7     	mov	w23, #0x2f              // =47
40004b14: 910003f8     	mov	x24, sp
40004b18: 14000005     	b	0x40004b2c <vfs_getcwd+0xbc>
40004b1c: 8b0a02d6     	add	x22, x22, x10
40004b20: f100075f     	cmp	x26, #0x1
40004b24: 38366a7f     	strb	wzr, [x19, x22]
40004b28: 54000349     	b.ls	0x40004b90 <vfs_getcwd+0x120>
40004b2c: eb1502df     	cmp	x22, x21
40004b30: aa1903fa     	mov	x26, x25
40004b34: 54000082     	b.hs	0x40004b44 <vfs_getcwd+0xd4>
40004b38: 38366a77     	strb	w23, [x19, x22]
40004b3c: 910006d6     	add	x22, x22, #0x1
40004b40: 38366a7f     	strb	wzr, [x19, x22]
40004b44: d1000759     	sub	x25, x26, #0x1
40004b48: f8797b14     	ldr	x20, [x24, x25, lsl #3]
40004b4c: aa1403e0     	mov	x0, x20
40004b50: 97fff790     	bl	0x40002990 <kstrlen>
40004b54: b4fffe60     	cbz	x0, 0x40004b20 <vfs_getcwd+0xb0>
40004b58: eb1502df     	cmp	x22, x21
40004b5c: 54fffe22     	b.hs	0x40004b20 <vfs_getcwd+0xb0>
40004b60: aa1f03e9     	mov	x9, xzr
40004b64: 8b160268     	add	x8, x19, x22
40004b68: 9100052a     	add	x10, x9, #0x1
40004b6c: 38696a8b     	ldrb	w11, [x20, x9]
40004b70: eb00015f     	cmp	x10, x0
40004b74: 3829690b     	strb	w11, [x8, x9]
40004b78: 54fffd22     	b.hs	0x40004b1c <vfs_getcwd+0xac>
40004b7c: 8b160149     	add	x9, x10, x22
40004b80: eb15013f     	cmp	x9, x21
40004b84: aa0a03e9     	mov	x9, x10
40004b88: 54ffff03     	b.lo	0x40004b68 <vfs_getcwd+0xf8>
40004b8c: 17ffffe4     	b	0x40004b1c <vfs_getcwd+0xac>
40004b90: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004b94: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004b98: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004b9c: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004ba0: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004ba4: 910343ff     	add	sp, sp, #0xd0
40004ba8: d65f03c0     	ret

0000000040004bac <vfs_find>:
40004bac: d10203ff     	sub	sp, sp, #0x80
40004bb0: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004bb4: 910083fd     	add	x29, sp, #0x20
40004bb8: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004bbc: a90467fa     	stp	x26, x25, [sp, #0x40]
40004bc0: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004bc4: a90657f6     	stp	x22, x21, [sp, #0x60]
40004bc8: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004bcc: b4000a60     	cbz	x0, 0x40004d18 <vfs_find+0x16c>
40004bd0: 39400008     	ldrb	w8, [x0]
40004bd4: aa0003f4     	mov	x20, x0
40004bd8: 34000a08     	cbz	w8, 0x40004d18 <vfs_find+0x16c>
40004bdc: 7100bd1f     	cmp	w8, #0x2f
40004be0: 54000121     	b.ne	0x40004c04 <vfs_find+0x58>
40004be4: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004be8: 52800037     	mov	w23, #0x1               // =1
40004bec: f945c913     	ldr	x19, [x8, #0xb90]
40004bf0: 38776a88     	ldrb	w8, [x20, x23]
40004bf4: 7100bd1f     	cmp	w8, #0x2f
40004bf8: 540000e1     	b.ne	0x40004c14 <vfs_find+0x68>
40004bfc: 910006f7     	add	x23, x23, #0x1
40004c00: 17fffffc     	b	0x40004bf0 <vfs_find+0x44>
40004c04: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004c08: aa1f03f7     	mov	x23, xzr
40004c0c: f945cd33     	ldr	x19, [x9, #0xb98]
40004c10: 14000002     	b	0x40004c18 <vfs_find+0x6c>
40004c14: 34000848     	cbz	w8, 0x40004d1c <vfs_find+0x170>
40004c18: 91000698     	add	x24, x20, #0x1
40004c1c: b0000035     	adrp	x21, 0x40009000 <__rodata_start>
40004c20: 91280ab5     	add	x21, x21, #0xa02
40004c24: 910003f9     	mov	x25, sp
40004c28: d0000036     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
40004c2c: 91083ed6     	add	x22, x22, #0x20f
40004c30: 14000006     	b	0x40004c48 <vfs_find+0x9c>
40004c34: f9421a68     	ldr	x8, [x19, #0x430]
40004c38: f100011f     	cmp	x8, #0x0
40004c3c: 9a880273     	csel	x19, x19, x8, eq
40004c40: 385ff348     	ldurb	w8, [x26, #-0x1]
40004c44: 340006c8     	cbz	w8, 0x40004d1c <vfs_find+0x170>
40004c48: 7100bd1f     	cmp	w8, #0x2f
40004c4c: 54000061     	b.ne	0x40004c58 <vfs_find+0xac>
40004c50: aa1f03e9     	mov	x9, xzr
40004c54: 14000010     	b	0x40004c94 <vfs_find+0xe8>
40004c58: aa1f03e9     	mov	x9, xzr
40004c5c: 8b17030a     	add	x10, x24, x23
40004c60: 34000188     	cbz	w8, 0x40004c90 <vfs_find+0xe4>
40004c64: f100793f     	cmp	x9, #0x1e
40004c68: 54000148     	b.hi	0x40004c90 <vfs_find+0xe4>
40004c6c: 38296b28     	strb	w8, [x25, x9]
40004c70: 38696948     	ldrb	w8, [x10, x9]
40004c74: 9100052b     	add	x11, x9, #0x1
40004c78: aa0b03e9     	mov	x9, x11
40004c7c: 7100bd1f     	cmp	w8, #0x2f
40004c80: 54ffff01     	b.ne	0x40004c60 <vfs_find+0xb4>
40004c84: 8b0b02f7     	add	x23, x23, x11
40004c88: aa0b03e9     	mov	x9, x11
40004c8c: 14000002     	b	0x40004c94 <vfs_find+0xe8>
40004c90: 8b0902f7     	add	x23, x23, x9
40004c94: 8b17029a     	add	x26, x20, x23
40004c98: d10006f7     	sub	x23, x23, #0x1
40004c9c: 38296b3f     	strb	wzr, [x25, x9]
40004ca0: 38401748     	ldrb	w8, [x26], #0x1
40004ca4: 910006f7     	add	x23, x23, #0x1
40004ca8: 7100bd1f     	cmp	w8, #0x2f
40004cac: 54ffffa0     	b.eq	0x40004ca0 <vfs_find+0xf4>
40004cb0: 910003e0     	mov	x0, sp
40004cb4: aa1503e1     	mov	x1, x21
40004cb8: 97fff746     	bl	0x400029d0 <kstrcmp>
40004cbc: 34fffc20     	cbz	w0, 0x40004c40 <vfs_find+0x94>
40004cc0: 910003e0     	mov	x0, sp
40004cc4: aa1603e1     	mov	x1, x22
40004cc8: 97fff742     	bl	0x400029d0 <kstrcmp>
40004ccc: 34fffb40     	cbz	w0, 0x40004c34 <vfs_find+0x88>
40004cd0: b944ba68     	ldr	w8, [x19, #0x4b8]
40004cd4: 7100051f     	cmp	w8, #0x1
40004cd8: 5400020b     	b.lt	0x40004d18 <vfs_find+0x16c>
40004cdc: aa1f03fb     	mov	x27, xzr
40004ce0: 9110e27c     	add	x28, x19, #0x438
40004ce4: 14000005     	b	0x40004cf8 <vfs_find+0x14c>
40004ce8: b944ba68     	ldr	w8, [x19, #0x4b8]
40004cec: 9100077b     	add	x27, x27, #0x1
40004cf0: eb28c37f     	cmp	x27, w8, sxtw
40004cf4: 5400012a     	b.ge	0x40004d18 <vfs_find+0x16c>
40004cf8: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004cfc: b4ffff80     	cbz	x0, 0x40004cec <vfs_find+0x140>
40004d00: 910003e1     	mov	x1, sp
40004d04: 97fff733     	bl	0x400029d0 <kstrcmp>
40004d08: 35ffff00     	cbnz	w0, 0x40004ce8 <vfs_find+0x13c>
40004d0c: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004d10: b5fff993     	cbnz	x19, 0x40004c40 <vfs_find+0x94>
40004d14: 14000002     	b	0x40004d1c <vfs_find+0x170>
40004d18: aa1f03f3     	mov	x19, xzr
40004d1c: aa1303e0     	mov	x0, x19
40004d20: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004d24: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004d28: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004d2c: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004d30: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004d34: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004d38: 910203ff     	add	sp, sp, #0x80
40004d3c: d65f03c0     	ret

0000000040004d40 <vfs_chdir>:
40004d40: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004d44: f9000bf3     	str	x19, [sp, #0x10]
40004d48: 910003fd     	mov	x29, sp
40004d4c: b4000200     	cbz	x0, 0x40004d8c <vfs_chdir+0x4c>
40004d50: 39400008     	ldrb	w8, [x0]
40004d54: 340001c8     	cbz	w8, 0x40004d8c <vfs_chdir+0x4c>
40004d58: f0000021     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40004d5c: 91175821     	add	x1, x1, #0x5d6
40004d60: aa0003f3     	mov	x19, x0
40004d64: 97fff71b     	bl	0x400029d0 <kstrcmp>
40004d68: 34000120     	cbz	w0, 0x40004d8c <vfs_chdir+0x4c>
40004d6c: aa1303e0     	mov	x0, x19
40004d70: 97ffff8f     	bl	0x40004bac <vfs_find>
40004d74: b40002c0     	cbz	x0, 0x40004dcc <vfs_chdir+0x8c>
40004d78: b9402008     	ldr	w8, [x0, #0x20]
40004d7c: 7100051f     	cmp	w8, #0x1
40004d80: 54000180     	b.eq	0x40004db0 <vfs_chdir+0x70>
40004d84: 12800028     	mov	w8, #-0x2               // =-2
40004d88: 1400000d     	b	0x40004dbc <vfs_chdir+0x7c>
40004d8c: d0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40004d90: 9102f800     	add	x0, x0, #0xbe
40004d94: 97ffff86     	bl	0x40004bac <vfs_find>
40004d98: b4000080     	cbz	x0, 0x40004da8 <vfs_chdir+0x68>
40004d9c: b9402008     	ldr	w8, [x0, #0x20]
40004da0: 7100051f     	cmp	w8, #0x1
40004da4: 54000060     	b.eq	0x40004db0 <vfs_chdir+0x70>
40004da8: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004dac: f945c900     	ldr	x0, [x8, #0xb90]
40004db0: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004db4: 2a1f03e8     	mov	w8, wzr
40004db8: f905cd20     	str	x0, [x9, #0xb98]
40004dbc: f9400bf3     	ldr	x19, [sp, #0x10]
40004dc0: 2a0803e0     	mov	w0, w8
40004dc4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004dc8: d65f03c0     	ret
40004dcc: 12800008     	mov	w8, #-0x1               // =-1
40004dd0: 17fffffb     	b	0x40004dbc <vfs_chdir+0x7c>

0000000040004dd4 <vfs_mkdir>:
40004dd4: b40001e0     	cbz	x0, 0x40004e10 <vfs_mkdir+0x3c>
40004dd8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004ddc: 39400008     	ldrb	w8, [x0]
40004de0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004de4: aa0003f3     	mov	x19, x0
40004de8: a90157f6     	stp	x22, x21, [sp, #0x10]
40004dec: 910003fd     	mov	x29, sp
40004df0: 34000148     	cbz	w8, 0x40004e18 <vfs_mkdir+0x44>
40004df4: b0000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
40004df8: f945ce95     	ldr	x21, [x20, #0xb98]
40004dfc: b944baa8     	ldr	w8, [x21, #0x4b8]
40004e00: 71003d1f     	cmp	w8, #0xf
40004e04: 540000ed     	b.le	0x40004e20 <vfs_mkdir+0x4c>
40004e08: 12800020     	mov	w0, #-0x2               // =-2
40004e0c: 14000043     	b	0x40004f18 <vfs_mkdir+0x144>
40004e10: 12800000     	mov	w0, #-0x1               // =-1
40004e14: d65f03c0     	ret
40004e18: 12800000     	mov	w0, #-0x1               // =-1
40004e1c: 1400003f     	b	0x40004f18 <vfs_mkdir+0x144>
40004e20: 7100051f     	cmp	w8, #0x1
40004e24: 540001eb     	b.lt	0x40004e60 <vfs_mkdir+0x8c>
40004e28: aa1f03f6     	mov	x22, xzr
40004e2c: 14000005     	b	0x40004e40 <vfs_mkdir+0x6c>
40004e30: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004e34: 910006d6     	add	x22, x22, #0x1
40004e38: eb0802df     	cmp	x22, x8
40004e3c: 5400012a     	b.ge	0x40004e60 <vfs_mkdir+0x8c>
40004e40: 8b160ea8     	add	x8, x21, x22, lsl #3
40004e44: f9421d00     	ldr	x0, [x8, #0x438]
40004e48: b4ffff40     	cbz	x0, 0x40004e30 <vfs_mkdir+0x5c>
40004e4c: aa1303e1     	mov	x1, x19
40004e50: 97fff6e0     	bl	0x400029d0 <kstrcmp>
40004e54: 340003e0     	cbz	w0, 0x40004ed0 <vfs_mkdir+0xfc>
40004e58: f945ce95     	ldr	x21, [x20, #0xb98]
40004e5c: 17fffff5     	b	0x40004e30 <vfs_mkdir+0x5c>
40004e60: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004e64: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004e68: 7101fd3f     	cmp	w9, #0x7f
40004e6c: 5400006d     	b.le	0x40004e78 <vfs_mkdir+0xa4>
40004e70: 12800060     	mov	w0, #-0x4               // =-4
40004e74: 14000029     	b	0x40004f18 <vfs_mkdir+0x144>
40004e78: 5280980a     	mov	w10, #0x4c0             // =1216
40004e7c: b000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40004e80: 912e816b     	add	x11, x11, #0xba0
40004e84: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004e88: 11000529     	add	w9, w9, #0x1
40004e8c: 2a1f03e1     	mov	w1, wzr
40004e90: 52809802     	mov	w2, #0x4c0              // =1216
40004e94: b90b8909     	str	w9, [x8, #0xb88]
40004e98: aa1403e0     	mov	x0, x20
40004e9c: 97fff718     	bl	0x40002afc <memset>
40004ea0: 39400268     	ldrb	w8, [x19]
40004ea4: 340001a8     	cbz	w8, 0x40004ed8 <vfs_mkdir+0x104>
40004ea8: aa1f03ea     	mov	x10, xzr
40004eac: 91000669     	add	x9, x19, #0x1
40004eb0: 382a6a88     	strb	w8, [x20, x10]
40004eb4: 9100054b     	add	x11, x10, #0x1
40004eb8: 386a6928     	ldrb	w8, [x9, x10]
40004ebc: 34000108     	cbz	w8, 0x40004edc <vfs_mkdir+0x108>
40004ec0: f100795f     	cmp	x10, #0x1e
40004ec4: aa0b03ea     	mov	x10, x11
40004ec8: 54ffff43     	b.lo	0x40004eb0 <vfs_mkdir+0xdc>
40004ecc: 14000004     	b	0x40004edc <vfs_mkdir+0x108>
40004ed0: 12800040     	mov	w0, #-0x3               // =-3
40004ed4: 14000011     	b	0x40004f18 <vfs_mkdir+0x144>
40004ed8: aa1f03eb     	mov	x11, xzr
40004edc: 382b6a9f     	strb	wzr, [x20, x11]
40004ee0: 2a1f03e0     	mov	w0, wzr
40004ee4: 52800029     	mov	w9, #0x1                // =1
40004ee8: b904ba9f     	str	wzr, [x20, #0x4b8]
40004eec: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004ef0: b9002289     	str	w9, [x20, #0x20]
40004ef4: f9021a95     	str	x21, [x20, #0x430]
40004ef8: 71003d1f     	cmp	w8, #0xf
40004efc: f900169f     	str	xzr, [x20, #0x28]
40004f00: 540000cc     	b.gt	0x40004f18 <vfs_mkdir+0x144>
40004f04: 8b080ea9     	add	x9, x21, x8, lsl #3
40004f08: 2a1f03e0     	mov	w0, wzr
40004f0c: 11000508     	add	w8, w8, #0x1
40004f10: b904baa8     	str	w8, [x21, #0x4b8]
40004f14: f9021d34     	str	x20, [x9, #0x438]
40004f18: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004f1c: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004f20: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004f24: d65f03c0     	ret

0000000040004f28 <vfs_sync>:
40004f28: d65f03c0     	ret

0000000040004f2c <vfs_touch>:
40004f2c: b4000500     	cbz	x0, 0x40004fcc <vfs_touch+0xa0>
40004f30: 39400008     	ldrb	w8, [x0]
40004f34: 340004c8     	cbz	w8, 0x40004fcc <vfs_touch+0xa0>
40004f38: d10583ff     	sub	sp, sp, #0x160
40004f3c: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004f40: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004f44: aa1f03f4     	mov	x20, xzr
40004f48: f945cd33     	ldr	x19, [x9, #0xb98]
40004f4c: aa0003e9     	mov	x9, x0
40004f50: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004f54: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004f58: 910483fd     	add	x29, sp, #0x120
40004f5c: a91457f6     	stp	x22, x21, [sp, #0x140]
40004f60: 14000003     	b	0x40004f6c <vfs_touch+0x40>
40004f64: aa0903f4     	mov	x20, x9
40004f68: 38401d28     	ldrb	w8, [x9, #0x1]!
40004f6c: 7100bd1f     	cmp	w8, #0x2f
40004f70: 54ffffa0     	b.eq	0x40004f64 <vfs_touch+0x38>
40004f74: 35ffffa8     	cbnz	w8, 0x40004f68 <vfs_touch+0x3c>
40004f78: b4000334     	cbz	x20, 0x40004fdc <vfs_touch+0xb0>
40004f7c: cb000288     	sub	x8, x20, x0
40004f80: 52801fe9     	mov	w9, #0xff               // =255
40004f84: aa0103f5     	mov	x21, x1
40004f88: f103fd1f     	cmp	x8, #0xff
40004f8c: aa0003e1     	mov	x1, x0
40004f90: 910083e0     	add	x0, sp, #0x20
40004f94: 9a893113     	csel	x19, x8, x9, lo
40004f98: 910083f6     	add	x22, sp, #0x20
40004f9c: aa1303e2     	mov	x2, x19
40004fa0: 97fff6b2     	bl	0x40002a68 <kstrncpy>
40004fa4: 910083e0     	add	x0, sp, #0x20
40004fa8: 38336adf     	strb	wzr, [x22, x19]
40004fac: 97ffff00     	bl	0x40004bac <vfs_find>
40004fb0: b4000120     	cbz	x0, 0x40004fd4 <vfs_touch+0xa8>
40004fb4: b9402008     	ldr	w8, [x0, #0x20]
40004fb8: aa0003f3     	mov	x19, x0
40004fbc: 7100051f     	cmp	w8, #0x1
40004fc0: 540000a1     	b.ne	0x40004fd4 <vfs_touch+0xa8>
40004fc4: 91000688     	add	x8, x20, #0x1
40004fc8: 14000007     	b	0x40004fe4 <vfs_touch+0xb8>
40004fcc: 12800000     	mov	w0, #-0x1               // =-1
40004fd0: d65f03c0     	ret
40004fd4: 12800000     	mov	w0, #-0x1               // =-1
40004fd8: 1400006a     	b	0x40005180 <vfs_touch+0x254>
40004fdc: aa0003e8     	mov	x8, x0
40004fe0: aa0103f5     	mov	x21, x1
40004fe4: 910003e0     	mov	x0, sp
40004fe8: aa0803e1     	mov	x1, x8
40004fec: 528003e2     	mov	w2, #0x1f               // =31
40004ff0: 97fff69e     	bl	0x40002a68 <kstrncpy>
40004ff4: b944ba68     	ldr	w8, [x19, #0x4b8]
40004ff8: 39007fff     	strb	wzr, [sp, #0x1f]
40004ffc: 7100051f     	cmp	w8, #0x1
40005000: 5400024b     	b.lt	0x40005048 <vfs_touch+0x11c>
40005004: aa1f03f6     	mov	x22, xzr
40005008: 9110e277     	add	x23, x19, #0x438
4000500c: 14000004     	b	0x4000501c <vfs_touch+0xf0>
40005010: 910006d6     	add	x22, x22, #0x1
40005014: eb28c2df     	cmp	x22, w8, sxtw
40005018: 5400010a     	b.ge	0x40005038 <vfs_touch+0x10c>
4000501c: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
40005020: b4ffff80     	cbz	x0, 0x40005010 <vfs_touch+0xe4>
40005024: 910003e1     	mov	x1, sp
40005028: 97fff66a     	bl	0x400029d0 <kstrcmp>
4000502c: 340004a0     	cbz	w0, 0x400050c0 <vfs_touch+0x194>
40005030: b944ba68     	ldr	w8, [x19, #0x4b8]
40005034: 17fffff7     	b	0x40005010 <vfs_touch+0xe4>
40005038: 71003d1f     	cmp	w8, #0xf
4000503c: 5400006d     	b.le	0x40005048 <vfs_touch+0x11c>
40005040: 12800020     	mov	w0, #-0x2               // =-2
40005044: 1400004f     	b	0x40005180 <vfs_touch+0x254>
40005048: 90000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
4000504c: b98b8909     	ldrsw	x9, [x8, #0xb88]
40005050: 7101fd3f     	cmp	w9, #0x7f
40005054: 5400006d     	b.le	0x40005060 <vfs_touch+0x134>
40005058: 12800060     	mov	w0, #-0x4               // =-4
4000505c: 14000049     	b	0x40005180 <vfs_touch+0x254>
40005060: 5280980a     	mov	w10, #0x4c0             // =1216
40005064: 9000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40005068: 912e816b     	add	x11, x11, #0xba0
4000506c: 9b2a2d34     	smaddl	x20, w9, w10, x11
40005070: 11000529     	add	w9, w9, #0x1
40005074: 2a1f03e1     	mov	w1, wzr
40005078: 52809802     	mov	w2, #0x4c0              // =1216
4000507c: b90b8909     	str	w9, [x8, #0xb88]
40005080: aa1403e0     	mov	x0, x20
40005084: 97fff69e     	bl	0x40002afc <memset>
40005088: 394003e8     	ldrb	w8, [sp]
4000508c: 340003e8     	cbz	w8, 0x40005108 <vfs_touch+0x1dc>
40005090: 910003ea     	mov	x10, sp
40005094: aa1f03e9     	mov	x9, xzr
40005098: aa1503e0     	mov	x0, x21
4000509c: b240014a     	orr	x10, x10, #0x1
400050a0: 38296a88     	strb	w8, [x20, x9]
400050a4: 38696948     	ldrb	w8, [x10, x9]
400050a8: 9100052b     	add	x11, x9, #0x1
400050ac: 34000328     	cbz	w8, 0x40005110 <vfs_touch+0x1e4>
400050b0: f100793f     	cmp	x9, #0x1e
400050b4: aa0b03e9     	mov	x9, x11
400050b8: 54ffff43     	b.lo	0x400050a0 <vfs_touch+0x174>
400050bc: 14000015     	b	0x40005110 <vfs_touch+0x1e4>
400050c0: b40005f5     	cbz	x21, 0x4000517c <vfs_touch+0x250>
400050c4: aa1503e0     	mov	x0, x21
400050c8: 97fff632     	bl	0x40002990 <kstrlen>
400050cc: 52807fe8     	mov	w8, #0x3ff              // =1023
400050d0: f10ffc1f     	cmp	x0, #0x3ff
400050d4: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
400050d8: 9a883014     	csel	x20, x0, x8, lo
400050dc: aa1503e1     	mov	x1, x21
400050e0: 9100c120     	add	x0, x9, #0x30
400050e4: aa1403e2     	mov	x2, x20
400050e8: 97fff69b     	bl	0x40002b54 <memcpy>
400050ec: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
400050f0: 2a1f03e0     	mov	w0, wzr
400050f4: 8b140108     	add	x8, x8, x20
400050f8: 3900c11f     	strb	wzr, [x8, #0x30]
400050fc: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
40005100: f9001514     	str	x20, [x8, #0x28]
40005104: 1400001f     	b	0x40005180 <vfs_touch+0x254>
40005108: aa1f03eb     	mov	x11, xzr
4000510c: aa1503e0     	mov	x0, x21
40005110: 382b6a9f     	strb	wzr, [x20, x11]
40005114: b904ba9f     	str	wzr, [x20, #0x4b8]
40005118: b984ba68     	ldrsw	x8, [x19, #0x4b8]
4000511c: b900229f     	str	wzr, [x20, #0x20]
40005120: f9021a93     	str	x19, [x20, #0x430]
40005124: 71003d1f     	cmp	w8, #0xf
40005128: f900169f     	str	xzr, [x20, #0x28]
4000512c: 540000ac     	b.gt	0x40005140 <vfs_touch+0x214>
40005130: 8b080e69     	add	x9, x19, x8, lsl #3
40005134: 11000508     	add	w8, w8, #0x1
40005138: b904ba68     	str	w8, [x19, #0x4b8]
4000513c: f9021d34     	str	x20, [x9, #0x438]
40005140: b4000200     	cbz	x0, 0x40005180 <vfs_touch+0x254>
40005144: aa0003f3     	mov	x19, x0
40005148: 97fff612     	bl	0x40002990 <kstrlen>
4000514c: 52807fe8     	mov	w8, #0x3ff              // =1023
40005150: f10ffc1f     	cmp	x0, #0x3ff
40005154: 9100c296     	add	x22, x20, #0x30
40005158: 9a883015     	csel	x21, x0, x8, lo
4000515c: aa1603e0     	mov	x0, x22
40005160: aa1303e1     	mov	x1, x19
40005164: aa1503e2     	mov	x2, x21
40005168: 97fff67b     	bl	0x40002b54 <memcpy>
4000516c: 2a1f03e0     	mov	w0, wzr
40005170: 38356adf     	strb	wzr, [x22, x21]
40005174: f9001695     	str	x21, [x20, #0x28]
40005178: 14000002     	b	0x40005180 <vfs_touch+0x254>
4000517c: 2a1f03e0     	mov	w0, wzr
40005180: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005184: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005188: a9535ffc     	ldp	x28, x23, [sp, #0x130]
4000518c: a9527bfd     	ldp	x29, x30, [sp, #0x120]
40005190: 910583ff     	add	sp, sp, #0x160
40005194: d65f03c0     	ret

0000000040005198 <vfs_write_file>:
40005198: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000519c: a9014ff4     	stp	x20, x19, [sp, #0x10]
400051a0: aa0003f4     	mov	x20, x0
400051a4: aa0103e0     	mov	x0, x1
400051a8: 910003fd     	mov	x29, sp
400051ac: aa0103f3     	mov	x19, x1
400051b0: 97fff5f8     	bl	0x40002990 <kstrlen>
400051b4: aa0003e2     	mov	x2, x0
400051b8: aa1403e0     	mov	x0, x20
400051bc: aa1303e1     	mov	x1, x19
400051c0: 940007a6     	bl	0x40007058 <fat16_write_file>
400051c4: aa1403e0     	mov	x0, x20
400051c8: aa1303e1     	mov	x1, x19
400051cc: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400051d0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400051d4: 17ffff56     	b	0x40004f2c <vfs_touch>

00000000400051d8 <vfs_remove>:
400051d8: b40005c0     	cbz	x0, 0x40005290 <vfs_remove+0xb8>
400051dc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
400051e0: 39400008     	ldrb	w8, [x0]
400051e4: a9024ff4     	stp	x20, x19, [sp, #0x20]
400051e8: aa0003f3     	mov	x19, x0
400051ec: f9000bf5     	str	x21, [sp, #0x10]
400051f0: 910003fd     	mov	x29, sp
400051f4: 34000448     	cbz	w8, 0x4000527c <vfs_remove+0xa4>
400051f8: 90000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
400051fc: f945ce88     	ldr	x8, [x20, #0xb98]
40005200: b944b909     	ldr	w9, [x8, #0x4b8]
40005204: 7100053f     	cmp	w9, #0x1
40005208: 540003ab     	b.lt	0x4000527c <vfs_remove+0xa4>
4000520c: aa1f03f5     	mov	x21, xzr
40005210: 14000005     	b	0x40005224 <vfs_remove+0x4c>
40005214: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005218: 910006b5     	add	x21, x21, #0x1
4000521c: eb0902bf     	cmp	x21, x9
40005220: 540002ea     	b.ge	0x4000527c <vfs_remove+0xa4>
40005224: 8b150d09     	add	x9, x8, x21, lsl #3
40005228: f9421d20     	ldr	x0, [x9, #0x438]
4000522c: b4ffff40     	cbz	x0, 0x40005214 <vfs_remove+0x3c>
40005230: aa1303e1     	mov	x1, x19
40005234: 97fff5e7     	bl	0x400029d0 <kstrcmp>
40005238: f945ce88     	ldr	x8, [x20, #0xb98]
4000523c: 35fffec0     	cbnz	w0, 0x40005214 <vfs_remove+0x3c>
40005240: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005244: d1000529     	sub	x9, x9, #0x1
40005248: 6b15013f     	cmp	w9, w21
4000524c: 5400026d     	b.le	0x40005298 <vfs_remove+0xc0>
40005250: f945ce8a     	ldr	x10, [x20, #0xb98]
40005254: b984b949     	ldrsw	x9, [x10, #0x4b8]
40005258: d1000529     	sub	x9, x9, #0x1
4000525c: 8b150d08     	add	x8, x8, x21, lsl #3
40005260: 910006b5     	add	x21, x21, #0x1
40005264: eb0902bf     	cmp	x21, x9
40005268: f942210b     	ldr	x11, [x8, #0x440]
4000526c: f9021d0b     	str	x11, [x8, #0x438]
40005270: aa0a03e8     	mov	x8, x10
40005274: 54ffff4b     	b.lt	0x4000525c <vfs_remove+0x84>
40005278: 14000009     	b	0x4000529c <vfs_remove+0xc4>
4000527c: 12800000     	mov	w0, #-0x1               // =-1
40005280: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005284: f9400bf5     	ldr	x21, [sp, #0x10]
40005288: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000528c: d65f03c0     	ret
40005290: 12800000     	mov	w0, #-0x1               // =-1
40005294: d65f03c0     	ret
40005298: aa0803ea     	mov	x10, x8
4000529c: 8b090d48     	add	x8, x10, x9, lsl #3
400052a0: 2a1f03e0     	mov	w0, wzr
400052a4: f9021d1f     	str	xzr, [x8, #0x438]
400052a8: f945ce88     	ldr	x8, [x20, #0xb98]
400052ac: b944b909     	ldr	w9, [x8, #0x4b8]
400052b0: 51000529     	sub	w9, w9, #0x1
400052b4: b904b909     	str	w9, [x8, #0x4b8]
400052b8: 17fffff2     	b	0x40005280 <vfs_remove+0xa8>

00000000400052bc <vfs_list_dir>:
400052bc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400052c0: 90000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
400052c4: f100001f     	cmp	x0, #0x0
400052c8: a90257f6     	stp	x22, x21, [sp, #0x20]
400052cc: f945cd08     	ldr	x8, [x8, #0xb98]
400052d0: f9000bf7     	str	x23, [sp, #0x10]
400052d4: 910003fd     	mov	x29, sp
400052d8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400052dc: 9a800115     	csel	x21, x8, x0, eq
400052e0: b94022a8     	ldr	w8, [x21, #0x20]
400052e4: 7100051f     	cmp	w8, #0x1
400052e8: 54000521     	b.ne	0x4000538c <vfs_list_dir+0xd0>
400052ec: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400052f0: 913bc400     	add	x0, x0, #0xef1
400052f4: 97fff952     	bl	0x4000383c <uart_puts>
400052f8: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400052fc: 9122a400     	add	x0, x0, #0x8a9
40005300: 97fff94f     	bl	0x4000383c <uart_puts>
40005304: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005308: 9103a400     	add	x0, x0, #0xe9
4000530c: 97fff94c     	bl	0x4000383c <uart_puts>
40005310: f9421aa8     	ldr	x8, [x21, #0x430]
40005314: b4000088     	cbz	x8, 0x40005324 <vfs_list_dir+0x68>
40005318: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000531c: 9113e000     	add	x0, x0, #0x4f8
40005320: 97fff947     	bl	0x4000383c <uart_puts>
40005324: b944baa1     	ldr	w1, [x21, #0x4b8]
40005328: 7100043f     	cmp	w1, #0x1
4000532c: 5400034b     	b.lt	0x40005394 <vfs_list_dir+0xd8>
40005330: aa1f03f6     	mov	x22, xzr
40005334: b0000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
40005338: 91383673     	add	x19, x19, #0xe0d
4000533c: 9110e2b7     	add	x23, x21, #0x438
40005340: b0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40005344: 91235a94     	add	x20, x20, #0x8d6
40005348: 14000008     	b	0x40005368 <vfs_list_dir+0xac>
4000534c: b9402841     	ldr	w1, [x2, #0x28]
40005350: aa1403e0     	mov	x0, x20
40005354: 97fffa4f     	bl	0x40003c90 <uart_printf>
40005358: b984baa1     	ldrsw	x1, [x21, #0x4b8]
4000535c: 910006d6     	add	x22, x22, #0x1
40005360: eb0102df     	cmp	x22, x1
40005364: 5400018a     	b.ge	0x40005394 <vfs_list_dir+0xd8>
40005368: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
4000536c: b4ffff62     	cbz	x2, 0x40005358 <vfs_list_dir+0x9c>
40005370: b9402048     	ldr	w8, [x2, #0x20]
40005374: 7100051f     	cmp	w8, #0x1
40005378: 54fffea1     	b.ne	0x4000534c <vfs_list_dir+0x90>
4000537c: aa1303e0     	mov	x0, x19
40005380: aa0203e1     	mov	x1, x2
40005384: 97fffa43     	bl	0x40003c90 <uart_printf>
40005388: 17fffff4     	b	0x40005358 <vfs_list_dir+0x9c>
4000538c: 12800000     	mov	w0, #-0x1               // =-1
40005390: 14000005     	b	0x400053a4 <vfs_list_dir+0xe8>
40005394: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005398: 91281000     	add	x0, x0, #0xa04
4000539c: 97fffa3d     	bl	0x40003c90 <uart_printf>
400053a0: 2a1f03e0     	mov	w0, wzr
400053a4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400053a8: f9400bf7     	ldr	x23, [sp, #0x10]
400053ac: a94257f6     	ldp	x22, x21, [sp, #0x20]
400053b0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400053b4: d65f03c0     	ret

00000000400053b8 <vfs_load_internal>:
400053b8: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400053bc: 910003fd     	mov	x29, sp
400053c0: 940008d9     	bl	0x40007724 <fat16_populate_vfs>
400053c4: 2a1f03e0     	mov	w0, wzr
400053c8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400053cc: d65f03c0     	ret

00000000400053d0 <vfs_load>:
400053d0: 140008d5     	b	0x40007724 <fat16_populate_vfs>

00000000400053d4 <pmm_init>:
400053d4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400053d8: a9014ff4     	stp	x20, x19, [sp, #0x10]
400053dc: d503201f     	nop
400053e0: 101b3e14     	adr	x20, 0x4003bba0 <memory_bitmap>
400053e4: aa1403e0     	mov	x0, x20
400053e8: 2a1f03e1     	mov	w1, wzr
400053ec: 52820002     	mov	w2, #0x1000             // =4096
400053f0: 910003fd     	mov	x29, sp
400053f4: 97fff5c2     	bl	0x40002afc <memset>
400053f8: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
400053fc: d00022c8     	adrp	x8, 0x4045f000 <__kernel_end>
40005400: 91000108     	add	x8, x8, #0x0
40005404: f2820009     	movk	x9, #0x1000
40005408: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
4000540c: f2402d1f     	tst	x8, #0xfff
40005410: 8b090109     	add	x9, x8, x9
40005414: 8b0a010a     	add	x10, x8, x10
40005418: 9a890148     	csel	x8, x10, x9, eq
4000541c: d34cfd13     	lsr	x19, x8, #12
40005420: 340001b3     	cbz	w19, 0x40005454 <pmm_init+0x80>
40005424: 2a1f03e8     	mov	w8, wzr
40005428: 52800029     	mov	w9, #0x1                // =1
4000542c: 2a0803ea     	mov	w10, w8
40005430: 1200090b     	and	w11, w8, #0x7
40005434: 11000508     	add	w8, w8, #0x1
40005438: d343fd4a     	lsr	x10, x10, #3
4000543c: 1acb212b     	lsl	w11, w9, w11
40005440: 6b08027f     	cmp	w19, w8
40005444: 386a6a8c     	ldrb	w12, [x20, x10]
40005448: 2a0b018b     	orr	w11, w12, w11
4000544c: 382a6a8b     	strb	w11, [x20, x10]
40005450: 54fffee1     	b.ne	0x4000542c <pmm_init+0x58>
40005454: 52900008     	mov	w8, #0x8000             // =32768
40005458: f0000034     	adrp	x20, 0x4000c000 <next_pid>
4000545c: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005460: 4b130108     	sub	w8, w8, w19
40005464: d503201f     	nop
40005468: 7002ee40     	adr	x0, 0x4000b233 <__rodata_start+0x2233>
4000546c: b9000688     	str	w8, [x20, #0x4]
40005470: b90ba133     	str	w19, [x9, #0xba0]
40005474: 97fffa07     	bl	0x40003c90 <uart_printf>
40005478: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000547c: 912be400     	add	x0, x0, #0xaf9
40005480: 52801001     	mov	w1, #0x80               // =128
40005484: 97fffa03     	bl	0x40003c90 <uart_printf>
40005488: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000548c: 91176000     	add	x0, x0, #0x5d8
40005490: 2a1303e1     	mov	w1, w19
40005494: 97fff9ff     	bl	0x40003c90 <uart_printf>
40005498: b9400688     	ldr	w8, [x20, #0x4]
4000549c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400054a0: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400054a4: 911c9c00     	add	x0, x0, #0x727
400054a8: 53084d01     	ubfx	w1, w8, #8, #12
400054ac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400054b0: 17fff9f8     	b	0x40003c90 <uart_printf>

00000000400054b4 <pmm_alloc_page>:
400054b4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400054b8: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400054bc: f9000bf3     	str	x19, [sp, #0x10]
400054c0: 910003fd     	mov	x29, sp
400054c4: b940050a     	ldr	w10, [x8, #0x4]
400054c8: 3400030a     	cbz	w10, 0x40005528 <pmm_alloc_page+0x74>
400054cc: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400054d0: b94ba12b     	ldr	w11, [x9, #0xba0]
400054d4: 530f7d6c     	lsr	w12, w11, #15
400054d8: 3500022c     	cbnz	w12, 0x4000551c <pmm_alloc_page+0x68>
400054dc: 52a8000c     	mov	w12, #0x40000000        // =1073741824
400054e0: d503201f     	nop
400054e4: 101b35ed     	adr	x13, 0x4003bba0 <memory_bitmap>
400054e8: 0b0b318c     	add	w12, w12, w11, lsl #12
400054ec: 5280002e     	mov	w14, #0x1               // =1
400054f0: 2a0b03ef     	mov	w15, w11
400054f4: 12000971     	and	w17, w11, #0x7
400054f8: d343fdef     	lsr	x15, x15, #3
400054fc: 1ad121d1     	lsl	w17, w14, w17
40005500: 386f69b0     	ldrb	w16, [x13, x15]
40005504: 6a10023f     	tst	w17, w16
40005508: 540001e0     	b.eq	0x40005544 <pmm_alloc_page+0x90>
4000550c: 1100056b     	add	w11, w11, #0x1
40005510: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
40005514: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
40005518: 54fffec1     	b.ne	0x400054f0 <pmm_alloc_page+0x3c>
4000551c: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005520: 9117c800     	add	x0, x0, #0x5f2
40005524: 14000003     	b	0x40005530 <pmm_alloc_page+0x7c>
40005528: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
4000552c: 911cf800     	add	x0, x0, #0x73e
40005530: 97fff8c3     	bl	0x4000383c <uart_puts>
40005534: aa1f03e0     	mov	x0, xzr
40005538: f9400bf3     	ldr	x19, [sp, #0x10]
4000553c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005540: d65f03c0     	ret
40005544: 2a0c03f3     	mov	w19, w12
40005548: 5100054a     	sub	w10, w10, #0x1
4000554c: 1100056b     	add	w11, w11, #0x1
40005550: aa1303e0     	mov	x0, x19
40005554: 2a1f03e1     	mov	w1, wzr
40005558: 52820002     	mov	w2, #0x1000             // =4096
4000555c: 2a11020e     	orr	w14, w16, w17
40005560: 382f69ae     	strb	w14, [x13, x15]
40005564: b900050a     	str	w10, [x8, #0x4]
40005568: b90ba12b     	str	w11, [x9, #0xba0]
4000556c: 97fff564     	bl	0x40002afc <memset>
40005570: aa1303e0     	mov	x0, x19
40005574: 17fffff1     	b	0x40005538 <pmm_alloc_page+0x84>

0000000040005578 <pmm_free_page>:
40005578: d35efc08     	lsr	x8, x0, #30
4000557c: b4000128     	cbz	x8, 0x400055a0 <pmm_free_page+0x28>
40005580: d35bfc08     	lsr	x8, x0, #27
40005584: f100251f     	cmp	x8, #0x9
40005588: 540000c2     	b.hs	0x400055a0 <pmm_free_page+0x28>
4000558c: f2402c1f     	tst	x0, #0xfff
40005590: 540000e0     	b.eq	0x400055ac <pmm_free_page+0x34>
40005594: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005598: 91234c00     	add	x0, x0, #0x8d3
4000559c: 17fff8a8     	b	0x4000383c <uart_puts>
400055a0: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400055a4: 91094c00     	add	x0, x0, #0x253
400055a8: 17fff8a5     	b	0x4000383c <uart_puts>
400055ac: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
400055b0: d503201f     	nop
400055b4: 101b2f6a     	adr	x10, 0x4003bba0 <memory_bitmap>
400055b8: 8b080009     	add	x9, x0, x8
400055bc: 5280002d     	mov	w13, #0x1               // =1
400055c0: d34fad28     	ubfx	x8, x9, #15, #29
400055c4: d34c392c     	ubfx	x12, x9, #12, #3
400055c8: 3868694b     	ldrb	w11, [x10, x8]
400055cc: 1acc21ac     	lsl	w12, w13, w12
400055d0: 6a0b019f     	tst	w12, w11
400055d4: 540001c0     	b.eq	0x4000560c <pmm_free_page+0x94>
400055d8: f000002e     	adrp	x14, 0x4000c000 <next_pid>
400055dc: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
400055e0: d34cfd29     	lsr	x9, x9, #12
400055e4: b94005cf     	ldr	w15, [x14, #0x4]
400055e8: b94ba1b0     	ldr	w16, [x13, #0xba0]
400055ec: 0a2c016b     	bic	w11, w11, w12
400055f0: 3828694b     	strb	w11, [x10, x8]
400055f4: 110005e8     	add	w8, w15, #0x1
400055f8: 6b09021f     	cmp	w16, w9
400055fc: b90005c8     	str	w8, [x14, #0x4]
40005600: 54000049     	b.ls	0x40005608 <pmm_free_page+0x90>
40005604: b90ba1a9     	str	w9, [x13, #0xba0]
40005608: d65f03c0     	ret
4000560c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005610: 91346c00     	add	x0, x0, #0xd1b
40005614: 17fff88a     	b	0x4000383c <uart_puts>

0000000040005618 <pmm_get_free_memory>:
40005618: f0000028     	adrp	x8, 0x4000c000 <next_pid>
4000561c: b9400508     	ldr	w8, [x8, #0x4]
40005620: 53144d00     	lsl	w0, w8, #12
40005624: d65f03c0     	ret

0000000040005628 <sched_init>:
40005628: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000562c: 912ec108     	add	x8, x8, #0xbb0
40005630: d2c00029     	mov	x9, #0x100000000        // =4294967296
40005634: f9001109     	str	x9, [x8, #0x20]
40005638: d2c00049     	mov	x9, #0x200000000        // =8589934592
4000563c: d503201f     	nop
40005640: 10022de0     	adr	x0, 0x40009bfc <__rodata_start+0xbfc>
40005644: f9001d09     	str	x9, [x8, #0x38]
40005648: d2c00069     	mov	x9, #0x300000000        // =12884901888
4000564c: f9002909     	str	x9, [x8, #0x50]
40005650: d2c00089     	mov	x9, #0x400000000        // =17179869184
40005654: f9003509     	str	x9, [x8, #0x68]
40005658: d2c000a9     	mov	x9, #0x500000000        // =21474836480
4000565c: f9004109     	str	x9, [x8, #0x80]
40005660: d2c000c9     	mov	x9, #0x600000000        // =25769803776
40005664: f9004d09     	str	x9, [x8, #0x98]
40005668: d2c000e9     	mov	x9, #0x700000000        // =30064771072
4000566c: f9005909     	str	x9, [x8, #0xb0]
40005670: d2c00109     	mov	x9, #0x800000000        // =34359738368
40005674: f9006509     	str	x9, [x8, #0xc8]
40005678: d2c00129     	mov	x9, #0x900000000        // =38654705664
4000567c: f9007109     	str	x9, [x8, #0xe0]
40005680: d2c00149     	mov	x9, #0xa00000000        // =42949672960
40005684: f9007d09     	str	x9, [x8, #0xf8]
40005688: d2c00169     	mov	x9, #0xb00000000        // =47244640256
4000568c: f9008909     	str	x9, [x8, #0x110]
40005690: d2c00189     	mov	x9, #0xc00000000        // =51539607552
40005694: f9009509     	str	x9, [x8, #0x128]
40005698: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
4000569c: f900a109     	str	x9, [x8, #0x140]
400056a0: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
400056a4: f900ad09     	str	x9, [x8, #0x158]
400056a8: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
400056ac: f900b909     	str	x9, [x8, #0x170]
400056b0: 52800049     	mov	w9, #0x2                // =2
400056b4: a900251f     	stp	xzr, x9, [x8]
400056b8: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400056bc: b900091f     	str	wzr, [x8, #0x8]
400056c0: 17fff85f     	b	0x4000383c <uart_puts>

00000000400056c4 <sched_create_task>:
400056c4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400056c8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056cc: a9034ff4     	stp	x20, x19, [sp, #0x30]
400056d0: aa0003f3     	mov	x19, x0
400056d4: b94bd108     	ldr	w8, [x8, #0xbd0]
400056d8: f9000bf7     	str	x23, [sp, #0x10]
400056dc: 910003fd     	mov	x29, sp
400056e0: a90257f6     	stp	x22, x21, [sp, #0x20]
400056e4: 340005c8     	cbz	w8, 0x4000579c <sched_create_task+0xd8>
400056e8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056ec: b94be908     	ldr	w8, [x8, #0xbe8]
400056f0: 340005a8     	cbz	w8, 0x400057a4 <sched_create_task+0xe0>
400056f4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056f8: b94c0108     	ldr	w8, [x8, #0xc00]
400056fc: 34000588     	cbz	w8, 0x400057ac <sched_create_task+0xe8>
40005700: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005704: b94c1908     	ldr	w8, [x8, #0xc18]
40005708: 34000568     	cbz	w8, 0x400057b4 <sched_create_task+0xf0>
4000570c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005710: b94c3108     	ldr	w8, [x8, #0xc30]
40005714: 34000548     	cbz	w8, 0x400057bc <sched_create_task+0xf8>
40005718: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000571c: b94c4908     	ldr	w8, [x8, #0xc48]
40005720: 34000528     	cbz	w8, 0x400057c4 <sched_create_task+0x100>
40005724: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005728: b94c6108     	ldr	w8, [x8, #0xc60]
4000572c: 34000508     	cbz	w8, 0x400057cc <sched_create_task+0x108>
40005730: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005734: b94c7908     	ldr	w8, [x8, #0xc78]
40005738: 340004e8     	cbz	w8, 0x400057d4 <sched_create_task+0x110>
4000573c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005740: b94c9108     	ldr	w8, [x8, #0xc90]
40005744: 340004c8     	cbz	w8, 0x400057dc <sched_create_task+0x118>
40005748: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000574c: b94ca908     	ldr	w8, [x8, #0xca8]
40005750: 340004a8     	cbz	w8, 0x400057e4 <sched_create_task+0x120>
40005754: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005758: b94cc108     	ldr	w8, [x8, #0xcc0]
4000575c: 34000488     	cbz	w8, 0x400057ec <sched_create_task+0x128>
40005760: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005764: b94cd908     	ldr	w8, [x8, #0xcd8]
40005768: 34000468     	cbz	w8, 0x400057f4 <sched_create_task+0x130>
4000576c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005770: b94cf108     	ldr	w8, [x8, #0xcf0]
40005774: 34000448     	cbz	w8, 0x400057fc <sched_create_task+0x138>
40005778: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000577c: b94d0908     	ldr	w8, [x8, #0xd08]
40005780: 34000428     	cbz	w8, 0x40005804 <sched_create_task+0x140>
40005784: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005788: b94d2108     	ldr	w8, [x8, #0xd20]
4000578c: 34000408     	cbz	w8, 0x4000580c <sched_create_task+0x148>
40005790: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005794: 910f0000     	add	x0, x0, #0x3c0
40005798: 1400003c     	b	0x40005888 <sched_create_task+0x1c4>
4000579c: 52800034     	mov	w20, #0x1               // =1
400057a0: 1400001c     	b	0x40005810 <sched_create_task+0x14c>
400057a4: 52800054     	mov	w20, #0x2               // =2
400057a8: 1400001a     	b	0x40005810 <sched_create_task+0x14c>
400057ac: 52800074     	mov	w20, #0x3               // =3
400057b0: 14000018     	b	0x40005810 <sched_create_task+0x14c>
400057b4: 52800094     	mov	w20, #0x4               // =4
400057b8: 14000016     	b	0x40005810 <sched_create_task+0x14c>
400057bc: 528000b4     	mov	w20, #0x5               // =5
400057c0: 14000014     	b	0x40005810 <sched_create_task+0x14c>
400057c4: 528000d4     	mov	w20, #0x6               // =6
400057c8: 14000012     	b	0x40005810 <sched_create_task+0x14c>
400057cc: 528000f4     	mov	w20, #0x7               // =7
400057d0: 14000010     	b	0x40005810 <sched_create_task+0x14c>
400057d4: 52800114     	mov	w20, #0x8               // =8
400057d8: 1400000e     	b	0x40005810 <sched_create_task+0x14c>
400057dc: 52800134     	mov	w20, #0x9               // =9
400057e0: 1400000c     	b	0x40005810 <sched_create_task+0x14c>
400057e4: 52800154     	mov	w20, #0xa               // =10
400057e8: 1400000a     	b	0x40005810 <sched_create_task+0x14c>
400057ec: 52800174     	mov	w20, #0xb               // =11
400057f0: 14000008     	b	0x40005810 <sched_create_task+0x14c>
400057f4: 52800194     	mov	w20, #0xc               // =12
400057f8: 14000006     	b	0x40005810 <sched_create_task+0x14c>
400057fc: 528001b4     	mov	w20, #0xd               // =13
40005800: 14000004     	b	0x40005810 <sched_create_task+0x14c>
40005804: 528001d4     	mov	w20, #0xe               // =14
40005808: 14000002     	b	0x40005810 <sched_create_task+0x14c>
4000580c: 528001f4     	mov	w20, #0xf               // =15
40005810: 97ffff29     	bl	0x400054b4 <pmm_alloc_page>
40005814: b4000360     	cbz	x0, 0x40005880 <sched_create_task+0x1bc>
40005818: 52800308     	mov	w8, #0x18               // =24
4000581c: d503201f     	nop
40005820: 101b9c49     	adr	x9, 0x4003cba8 <tasks>
40005824: 9ba82696     	umaddl	x22, w20, w8, x9
40005828: 913bc015     	add	x21, x0, #0xef0
4000582c: aa0003f7     	mov	x23, x0
40005830: 2a1f03e1     	mov	w1, wzr
40005834: 52802202     	mov	w2, #0x110              // =272
40005838: f90006c0     	str	x0, [x22, #0x8]
4000583c: aa1503e0     	mov	x0, x21
40005840: 97fff4af     	bl	0x40002afc <memset>
40005844: 52800029     	mov	w9, #0x1                // =1
40005848: f907f6f3     	str	x19, [x23, #0xfe8]
4000584c: 528000a8     	mov	w8, #0x5                // =5
40005850: f90002d5     	str	x21, [x22]
40005854: 2a1403e1     	mov	w1, w20
40005858: 2a1303e2     	mov	w2, w19
4000585c: b90012c9     	str	w9, [x22, #0x10]
40005860: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005864: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005868: f907fae8     	str	x8, [x23, #0xff0]
4000586c: f9400bf7     	ldr	x23, [sp, #0x10]
40005870: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005874: 91240800     	add	x0, x0, #0x902
40005878: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000587c: 17fff905     	b	0x40003c90 <uart_printf>
40005880: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005884: 911d9c00     	add	x0, x0, #0x767
40005888: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000588c: f9400bf7     	ldr	x23, [sp, #0x10]
40005890: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005894: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005898: 17fff7e9     	b	0x4000383c <uart_puts>

000000004000589c <sched_switch>:
4000589c: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400058a0: b940090b     	ldr	w11, [x8, #0x8]
400058a4: 3100057f     	cmn	w11, #0x1
400058a8: 54000300     	b.eq	0x40005908 <sched_switch+0x6c>
400058ac: 5280030a     	mov	w10, #0x18              // =24
400058b0: d503201f     	nop
400058b4: 101b97a9     	adr	x9, 0x4003cba8 <tasks>
400058b8: 9b2a256c     	smaddl	x12, w11, w10, x9
400058bc: 9b2a7d6d     	smull	x13, w11, w10
400058c0: b8410d8e     	ldr	w14, [x12, #0x10]!
400058c4: f82d6920     	str	x0, [x9, x13]
400058c8: 710009df     	cmp	w14, #0x2
400058cc: 54000061     	b.ne	0x400058d8 <sched_switch+0x3c>
400058d0: 5280002d     	mov	w13, #0x1               // =1
400058d4: b900018d     	str	w13, [x12]
400058d8: 5280020c     	mov	w12, #0x10              // =16
400058dc: 1100056b     	add	w11, w11, #0x1
400058e0: 6b0b03ed     	negs	w13, w11
400058e4: 12000d6b     	and	w11, w11, #0xf
400058e8: 12000dad     	and	w13, w13, #0xf
400058ec: 5a8d456b     	csneg	w11, w11, w13, mi
400058f0: 9b2a256d     	smaddl	x13, w11, w10, x9
400058f4: b8410dae     	ldr	w14, [x13, #0x10]!
400058f8: 710005df     	cmp	w14, #0x1
400058fc: 54000080     	b.eq	0x4000590c <sched_switch+0x70>
40005900: 7100058c     	subs	w12, w12, #0x1
40005904: 54fffec1     	b.ne	0x400058dc <sched_switch+0x40>
40005908: d65f03c0     	ret
4000590c: 5280030a     	mov	w10, #0x18              // =24
40005910: b900090b     	str	w11, [x8, #0x8]
40005914: 52800048     	mov	w8, #0x2                // =2
40005918: 9b2a7d6a     	smull	x10, w11, w10
4000591c: b90001a8     	str	w8, [x13]
40005920: f86a6920     	ldr	x0, [x9, x10]
40005924: d65f03c0     	ret

0000000040005928 <virtio_blk_init>:
40005928: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000592c: 528d2ec9     	mov	w9, #0x6976             // =26998
40005930: 52a14001     	mov	w1, #0xa000000          // =167772160
40005934: 52800408     	mov	w8, #0x20               // =32
40005938: 72ae8e49     	movk	w9, #0x7472, lsl #16
4000593c: a9014ff4     	stp	x20, x19, [sp, #0x10]
40005940: 910003fd     	mov	x29, sp
40005944: 14000004     	b	0x40005954 <virtio_blk_init+0x2c>
40005948: f1000508     	subs	x8, x8, #0x1
4000594c: 91080021     	add	x1, x1, #0x200
40005950: 540001a0     	b.eq	0x40005984 <virtio_blk_init+0x5c>
40005954: b940002a     	ldr	w10, [x1]
40005958: 6b09015f     	cmp	w10, w9
4000595c: 54ffff61     	b.ne	0x40005948 <virtio_blk_init+0x20>
40005960: b9400422     	ldr	w2, [x1, #0x4]
40005964: b940082a     	ldr	w10, [x1, #0x8]
40005968: 7100095f     	cmp	w10, #0x2
4000596c: 54fffee1     	b.ne	0x40005948 <virtio_blk_init+0x20>
40005970: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005974: d503201f     	nop
40005978: 3002b380     	adr	x0, 0x4000afe9 <__rodata_start+0x1fe9>
4000597c: f9069501     	str	x1, [x8, #0xd28]
40005980: 97fff8c4     	bl	0x40003c90 <uart_printf>
40005984: f00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
40005988: f9469688     	ldr	x8, [x20, #0xd28]
4000598c: b40004a8     	cbz	x8, 0x40005a20 <virtio_blk_init+0xf8>
40005990: 52800029     	mov	w9, #0x1                // =1
40005994: 5280006a     	mov	w10, #0x3               // =3
40005998: b900711f     	str	wzr, [x8, #0x70]
4000599c: b9007109     	str	w9, [x8, #0x70]
400059a0: b900710a     	str	w10, [x8, #0x70]
400059a4: b900211f     	str	wzr, [x8, #0x20]
400059a8: b900311f     	str	wzr, [x8, #0x30]
400059ac: b9403509     	ldr	w9, [x8, #0x34]
400059b0: 34000409     	cbz	w9, 0x40005a30 <virtio_blk_init+0x108>
400059b4: 52800209     	mov	w9, #0x10               // =16
400059b8: b9003909     	str	w9, [x8, #0x38]
400059bc: 97fffebe     	bl	0x400054b4 <pmm_alloc_page>
400059c0: aa0003f3     	mov	x19, x0
400059c4: 97fffebc     	bl	0x400054b4 <pmm_alloc_page>
400059c8: b40003d3     	cbz	x19, 0x40005a40 <virtio_blk_init+0x118>
400059cc: f9469688     	ldr	x8, [x20, #0xd28]
400059d0: 52820009     	mov	w9, #0x1000             // =4096
400059d4: 9104026a     	add	x10, x19, #0x100
400059d8: d34cfe6b     	lsr	x11, x19, #12
400059dc: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400059e0: 911d5000     	add	x0, x0, #0x754
400059e4: b9002909     	str	w9, [x8, #0x28]
400059e8: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400059ec: f9069d2a     	str	x10, [x9, #0xd38]
400059f0: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400059f4: 528224aa     	mov	w10, #0x1125            // =4389
400059f8: f9069933     	str	x19, [x9, #0xd30]
400059fc: 8b0a0269     	add	x9, x19, x10
40005a00: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005a04: 9274cd29     	and	x9, x9, #0xfffffffffffff000
40005a08: 52800033     	mov	w19, #0x1               // =1
40005a0c: f906a149     	str	x9, [x10, #0xd40]
40005a10: 528000e9     	mov	w9, #0x7                // =7
40005a14: b900410b     	str	w11, [x8, #0x40]
40005a18: b9007109     	str	w9, [x8, #0x70]
40005a1c: 14000008     	b	0x40005a3c <virtio_blk_init+0x114>
40005a20: 2a1f03f3     	mov	w19, wzr
40005a24: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005a28: 911e7800     	add	x0, x0, #0x79e
40005a2c: 14000004     	b	0x40005a3c <virtio_blk_init+0x114>
40005a30: 2a1f03f3     	mov	w19, wzr
40005a34: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005a38: 9134ec00     	add	x0, x0, #0xd3b
40005a3c: 97fff780     	bl	0x4000383c <uart_puts>
40005a40: 2a1303e0     	mov	w0, w19
40005a44: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40005a48: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005a4c: d65f03c0     	ret

0000000040005a50 <virtio_blk_read_sector>:
40005a50: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005a54: f9469509     	ldr	x9, [x8, #0xd28]
40005a58: b4001349     	cbz	x9, 0x40005cc0 <virtio_blk_read_sector+0x270>
40005a5c: d10083ff     	sub	sp, sp, #0x20
40005a60: d360fc09     	lsr	x9, x0, #32
40005a64: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005a68: 9135216b     	add	x11, x11, #0xd48
40005a6c: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005a70: 9135614a     	add	x10, x10, #0xd58
40005a74: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005a78: 29012560     	stp	w0, w9, [x11, #0x8]
40005a7c: 52801fe9     	mov	w9, #0xff               // =255
40005a80: d358fd6d     	lsr	x13, x11, #24
40005a84: 29007d7f     	stp	wzr, wzr, [x11]
40005a88: d348fc2e     	lsr	x14, x1, #8
40005a8c: d368fd6c     	lsr	x12, x11, #40
40005a90: 39000149     	strb	w9, [x10]
40005a94: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005a98: d348fd4f     	lsr	x15, x10, #8
40005a9c: f9469929     	ldr	x9, [x9, #0xd30]
40005aa0: 910043fd     	add	x29, sp, #0x10
40005aa4: 39000d2d     	strb	w13, [x9, #0x3]
40005aa8: d348fd6d     	lsr	x13, x11, #8
40005aac: 3900452e     	strb	w14, [x9, #0x11]
40005ab0: 5280006e     	mov	w14, #0x3               // =3
40005ab4: 3900052d     	strb	w13, [x9, #0x1]
40005ab8: d368fc2d     	lsr	x13, x1, #40
40005abc: 3900712e     	strb	w14, [x9, #0x1c]
40005ac0: d368fd4e     	lsr	x14, x10, #40
40005ac4: 3900552d     	strb	w13, [x9, #0x15]
40005ac8: 5280004d     	mov	w13, #0x2               // =2
40005acc: 3900012b     	strb	w11, [x9]
40005ad0: 3900152c     	strb	w12, [x9, #0x5]
40005ad4: d350fd6c     	lsr	x12, x11, #16
40005ad8: 3900652d     	strb	w13, [x9, #0x19]
40005adc: 3900792d     	strb	w13, [x9, #0x1e]
40005ae0: 3900852f     	strb	w15, [x9, #0x21]
40005ae4: d378fd6f     	lsr	x15, x11, #56
40005ae8: 3900b12d     	strb	w13, [x9, #0x2c]
40005aec: d360fd6d     	lsr	x13, x11, #32
40005af0: d370fd6b     	lsr	x11, x11, #48
40005af4: 3900952e     	strb	w14, [x9, #0x25]
40005af8: aa0903ee     	mov	x14, x9
40005afc: 38004dcd     	strb	w13, [x14, #0x4]!
40005b00: aa0903ed     	mov	x13, x9
40005b04: 390009cb     	strb	w11, [x14, #0x2]
40005b08: 5280020b     	mov	w11, #0x10              // =16
40005b0c: 38008dab     	strb	w11, [x13, #0x8]!
40005b10: aa0903eb     	mov	x11, x9
40005b14: 39000dbf     	strb	wzr, [x13, #0x3]
40005b18: 390009bf     	strb	wzr, [x13, #0x2]
40005b1c: d358fc2d     	lsr	x13, x1, #24
40005b20: 39000dcf     	strb	w15, [x14, #0x3]
40005b24: d350fc2e     	lsr	x14, x1, #16
40005b28: aa0903ef     	mov	x15, x9
40005b2c: 38010d61     	strb	w1, [x11, #0x10]!
40005b30: 39000d6d     	strb	w13, [x11, #0x3]
40005b34: d360fc2d     	lsr	x13, x1, #32
40005b38: 3900096e     	strb	w14, [x11, #0x2]
40005b3c: d378fc2e     	lsr	x14, x1, #56
40005b40: 38004d6d     	strb	w13, [x11, #0x4]!
40005b44: d370fc2d     	lsr	x13, x1, #48
40005b48: 39000d6e     	strb	w14, [x11, #0x3]
40005b4c: aa0903ee     	mov	x14, x9
40005b50: 3900096d     	strb	w13, [x11, #0x2]
40005b54: d358fd4b     	lsr	x11, x10, #24
40005b58: d350fd4d     	lsr	x13, x10, #16
40005b5c: 38020dca     	strb	w10, [x14, #0x20]!
40005b60: 39000dcb     	strb	w11, [x14, #0x3]
40005b64: d360fd4b     	lsr	x11, x10, #32
40005b68: 390009cd     	strb	w13, [x14, #0x2]
40005b6c: 38004dcb     	strb	w11, [x14, #0x4]!
40005b70: d378fd4b     	lsr	x11, x10, #56
40005b74: d370fd4a     	lsr	x10, x10, #48
40005b78: 3900092c     	strb	w12, [x9, #0x2]
40005b7c: 5280002c     	mov	w12, #0x1               // =1
40005b80: 39000dcb     	strb	w11, [x14, #0x3]
40005b84: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005b88: 390009ca     	strb	w10, [x14, #0x2]
40005b8c: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005b90: 795ab96d     	ldrh	w13, [x11, #0xd5c]
40005b94: f9469d4e     	ldr	x14, [x10, #0xd38]
40005b98: 3900253f     	strb	wzr, [x9, #0x9]
40005b9c: 92400dad     	and	x13, x13, #0xf
40005ba0: 3900353f     	strb	wzr, [x9, #0xd]
40005ba4: 3900312c     	strb	w12, [x9, #0xc]
40005ba8: 39003d3f     	strb	wzr, [x9, #0xf]
40005bac: 3900392c     	strb	w12, [x9, #0xe]
40005bb0: 3900753f     	strb	wzr, [x9, #0x1d]
40005bb4: 39007d3f     	strb	wzr, [x9, #0x1f]
40005bb8: 3900a53f     	strb	wzr, [x9, #0x29]
40005bbc: 3900b53f     	strb	wzr, [x9, #0x2d]
40005bc0: 3900bd3f     	strb	wzr, [x9, #0x2f]
40005bc4: 3900b93f     	strb	wzr, [x9, #0x2e]
40005bc8: 38028d2c     	strb	w12, [x9, #0x28]!
40005bcc: 8b0d05cc     	add	x12, x14, x13, lsl #1
40005bd0: 38018dff     	strb	wzr, [x15, #0x18]!
40005bd4: 39000dff     	strb	wzr, [x15, #0x3]
40005bd8: 390009ff     	strb	wzr, [x15, #0x2]
40005bdc: 39000d3f     	strb	wzr, [x9, #0x3]
40005be0: 3900093f     	strb	wzr, [x9, #0x2]
40005be4: 3900159f     	strb	wzr, [x12, #0x5]
40005be8: 3900119f     	strb	wzr, [x12, #0x4]
40005bec: d5033fbf     	dmb	sy
40005bf0: 795ab969     	ldrh	w9, [x11, #0xd5c]
40005bf4: f9469d4a     	ldr	x10, [x10, #0xd38]
40005bf8: 11000529     	add	w9, w9, #0x1
40005bfc: 53087d2c     	lsr	w12, w9, #8
40005c00: 791ab969     	strh	w9, [x11, #0xd5c]
40005c04: 39000949     	strb	w9, [x10, #0x2]
40005c08: 39000d4c     	strb	w12, [x10, #0x3]
40005c0c: d5033fbf     	dmb	sy
40005c10: f9469509     	ldr	x9, [x8, #0xd28]
40005c14: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005c18: b900513f     	str	wzr, [x9, #0x50]
40005c1c: f946a109     	ldr	x9, [x8, #0xd40]
40005c20: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005c24: 3940052b     	ldrb	w11, [x9, #0x1]
40005c28: 3940052c     	ldrb	w12, [x9, #0x1]
40005c2c: 3940012d     	ldrb	w13, [x9]
40005c30: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005c34: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005c38: 6b09015f     	cmp	w10, w9
40005c3c: 54000301     	b.ne	0x40005c9c <virtio_blk_read_sector+0x24c>
40005c40: 5290d40a     	mov	w10, #0x86a0            // =34464
40005c44: 72a0002a     	movk	w10, #0x1, lsl #16
40005c48: 14000009     	b	0x40005c6c <virtio_blk_read_sector+0x21c>
40005c4c: f946a10b     	ldr	x11, [x8, #0xd40]
40005c50: 39400d6c     	ldrb	w12, [x11, #0x3]
40005c54: 3940096b     	ldrb	w11, [x11, #0x2]
40005c58: 2a0c216b     	orr	w11, w11, w12, lsl #8
40005c5c: 6b09017f     	cmp	w11, w9
40005c60: 7a410940     	ccmp	w10, #0x1, #0x0, eq
40005c64: 5100054a     	sub	w10, w10, #0x1
40005c68: 540001a9     	b.ls	0x40005c9c <virtio_blk_read_sector+0x24c>
40005c6c: d5033fbf     	dmb	sy
40005c70: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005c74: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c78: 71018d7f     	cmp	w11, #0x63
40005c7c: 54fffe8c     	b.gt	0x40005c4c <virtio_blk_read_sector+0x1fc>
40005c80: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c84: 1100056b     	add	w11, w11, #0x1
40005c88: b81fc3ab     	stur	w11, [x29, #-0x4]
40005c8c: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c90: 7101917f     	cmp	w11, #0x64
40005c94: 54ffff6b     	b.lt	0x40005c80 <virtio_blk_read_sector+0x230>
40005c98: 17ffffed     	b	0x40005c4c <virtio_blk_read_sector+0x1fc>
40005c9c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005ca0: 39756109     	ldrb	w9, [x8, #0xd58]
40005ca4: 34000129     	cbz	w9, 0x40005cc8 <virtio_blk_read_sector+0x278>
40005ca8: 39756101     	ldrb	w1, [x8, #0xd58]
40005cac: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005cb0: 91097400     	add	x0, x0, #0x25d
40005cb4: 97fff7f7     	bl	0x40003c90 <uart_printf>
40005cb8: 2a1f03e0     	mov	w0, wzr
40005cbc: 14000004     	b	0x40005ccc <virtio_blk_read_sector+0x27c>
40005cc0: 2a1f03e0     	mov	w0, wzr
40005cc4: d65f03c0     	ret
40005cc8: 52800020     	mov	w0, #0x1                // =1
40005ccc: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005cd0: 910083ff     	add	sp, sp, #0x20
40005cd4: d65f03c0     	ret

0000000040005cd8 <virtio_blk_write_sector>:
40005cd8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005cdc: f9469509     	ldr	x9, [x8, #0xd28]
40005ce0: b40012c9     	cbz	x9, 0x40005f38 <virtio_blk_write_sector+0x260>
40005ce4: d10083ff     	sub	sp, sp, #0x20
40005ce8: d360fc0a     	lsr	x10, x0, #32
40005cec: f00001ac     	adrp	x12, 0x4003c000 <memory_bitmap+0x460>
40005cf0: 9135818c     	add	x12, x12, #0xd60
40005cf4: 52800029     	mov	w9, #0x1                // =1
40005cf8: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005cfc: 9135c16b     	add	x11, x11, #0xd70
40005d00: 29012980     	stp	w0, w10, [x12, #0x8]
40005d04: 52801fea     	mov	w10, #0xff              // =255
40005d08: d368fd8d     	lsr	x13, x12, #40
40005d0c: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005d10: d358fd8e     	lsr	x14, x12, #24
40005d14: d348fd6f     	lsr	x15, x11, #8
40005d18: 29007d89     	stp	w9, wzr, [x12]
40005d1c: 910043fd     	add	x29, sp, #0x10
40005d20: 3900016a     	strb	w10, [x11]
40005d24: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005d28: f946994a     	ldr	x10, [x10, #0xd30]
40005d2c: 3900154d     	strb	w13, [x10, #0x5]
40005d30: d350fd8d     	lsr	x13, x12, #16
40005d34: 39000d4e     	strb	w14, [x10, #0x3]
40005d38: d348fd8e     	lsr	x14, x12, #8
40005d3c: 3900094d     	strb	w13, [x10, #0x2]
40005d40: d368fc2d     	lsr	x13, x1, #40
40005d44: 3900054e     	strb	w14, [x10, #0x1]
40005d48: d348fc2e     	lsr	x14, x1, #8
40005d4c: 3900554d     	strb	w13, [x10, #0x15]
40005d50: 5280004d     	mov	w13, #0x2               // =2
40005d54: 3900454e     	strb	w14, [x10, #0x11]
40005d58: d368fd6e     	lsr	x14, x11, #40
40005d5c: 3900014c     	strb	w12, [x10]
40005d60: 3900654d     	strb	w13, [x10, #0x19]
40005d64: 3900794d     	strb	w13, [x10, #0x1e]
40005d68: 3900854f     	strb	w15, [x10, #0x21]
40005d6c: d378fd8f     	lsr	x15, x12, #56
40005d70: 3900b14d     	strb	w13, [x10, #0x2c]
40005d74: d360fd8d     	lsr	x13, x12, #32
40005d78: d370fd8c     	lsr	x12, x12, #48
40005d7c: 3900954e     	strb	w14, [x10, #0x25]
40005d80: aa0a03ee     	mov	x14, x10
40005d84: 38004dcd     	strb	w13, [x14, #0x4]!
40005d88: aa0a03ed     	mov	x13, x10
40005d8c: 390009cc     	strb	w12, [x14, #0x2]
40005d90: 5280020c     	mov	w12, #0x10              // =16
40005d94: 38008dac     	strb	w12, [x13, #0x8]!
40005d98: aa0a03ec     	mov	x12, x10
40005d9c: 39000dbf     	strb	wzr, [x13, #0x3]
40005da0: 390009bf     	strb	wzr, [x13, #0x2]
40005da4: d358fc2d     	lsr	x13, x1, #24
40005da8: 39000dcf     	strb	w15, [x14, #0x3]
40005dac: d350fc2e     	lsr	x14, x1, #16
40005db0: d350fd6f     	lsr	x15, x11, #16
40005db4: 38010d81     	strb	w1, [x12, #0x10]!
40005db8: 39000d8d     	strb	w13, [x12, #0x3]
40005dbc: d360fc2d     	lsr	x13, x1, #32
40005dc0: 3900098e     	strb	w14, [x12, #0x2]
40005dc4: d378fc2e     	lsr	x14, x1, #56
40005dc8: 38004d8d     	strb	w13, [x12, #0x4]!
40005dcc: d370fc2d     	lsr	x13, x1, #48
40005dd0: 39000d8e     	strb	w14, [x12, #0x3]
40005dd4: aa0a03ee     	mov	x14, x10
40005dd8: 3900098d     	strb	w13, [x12, #0x2]
40005ddc: d358fd6d     	lsr	x13, x11, #24
40005de0: aa0a03ec     	mov	x12, x10
40005de4: 38020d8b     	strb	w11, [x12, #0x20]!
40005de8: 39000d8d     	strb	w13, [x12, #0x3]
40005dec: d360fd6d     	lsr	x13, x11, #32
40005df0: 38018ddf     	strb	wzr, [x14, #0x18]!
40005df4: 3900098f     	strb	w15, [x12, #0x2]
40005df8: 38004d8d     	strb	w13, [x12, #0x4]!
40005dfc: d378fd6d     	lsr	x13, x11, #56
40005e00: 39000ddf     	strb	wzr, [x14, #0x3]
40005e04: d370fd6b     	lsr	x11, x11, #48
40005e08: 390009df     	strb	wzr, [x14, #0x2]
40005e0c: f00001ae     	adrp	x14, 0x4003c000 <memory_bitmap+0x460>
40005e10: 39000d8d     	strb	w13, [x12, #0x3]
40005e14: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
40005e18: 795ab9cf     	ldrh	w15, [x14, #0xd5c]
40005e1c: 3900098b     	strb	w11, [x12, #0x2]
40005e20: f9469dab     	ldr	x11, [x13, #0xd38]
40005e24: 3900255f     	strb	wzr, [x10, #0x9]
40005e28: 3900355f     	strb	wzr, [x10, #0xd]
40005e2c: 39003149     	strb	w9, [x10, #0xc]
40005e30: 39003d5f     	strb	wzr, [x10, #0xf]
40005e34: 39003949     	strb	w9, [x10, #0xe]
40005e38: 3900755f     	strb	wzr, [x10, #0x1d]
40005e3c: 39007149     	strb	w9, [x10, #0x1c]
40005e40: 39007d5f     	strb	wzr, [x10, #0x1f]
40005e44: 3900a55f     	strb	wzr, [x10, #0x29]
40005e48: 3900b55f     	strb	wzr, [x10, #0x2d]
40005e4c: 3900bd5f     	strb	wzr, [x10, #0x2f]
40005e50: 3900b95f     	strb	wzr, [x10, #0x2e]
40005e54: 38028d49     	strb	w9, [x10, #0x28]!
40005e58: 92400de9     	and	x9, x15, #0xf
40005e5c: 8b090569     	add	x9, x11, x9, lsl #1
40005e60: 39000d5f     	strb	wzr, [x10, #0x3]
40005e64: 3900095f     	strb	wzr, [x10, #0x2]
40005e68: 110005ea     	add	w10, w15, #0x1
40005e6c: 3900153f     	strb	wzr, [x9, #0x5]
40005e70: 3900113f     	strb	wzr, [x9, #0x4]
40005e74: 53087d49     	lsr	w9, w10, #8
40005e78: 791ab9ca     	strh	w10, [x14, #0xd5c]
40005e7c: 3900096a     	strb	w10, [x11, #0x2]
40005e80: 39000d69     	strb	w9, [x11, #0x3]
40005e84: d5033fbf     	dmb	sy
40005e88: f9469509     	ldr	x9, [x8, #0xd28]
40005e8c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005e90: b900513f     	str	wzr, [x9, #0x50]
40005e94: f946a109     	ldr	x9, [x8, #0xd40]
40005e98: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005e9c: 3940052b     	ldrb	w11, [x9, #0x1]
40005ea0: 3940052c     	ldrb	w12, [x9, #0x1]
40005ea4: 3940012d     	ldrb	w13, [x9]
40005ea8: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005eac: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005eb0: 6b09015f     	cmp	w10, w9
40005eb4: 54000301     	b.ne	0x40005f14 <virtio_blk_write_sector+0x23c>
40005eb8: 5290d40a     	mov	w10, #0x86a0            // =34464
40005ebc: 72a0002a     	movk	w10, #0x1, lsl #16
40005ec0: 14000009     	b	0x40005ee4 <virtio_blk_write_sector+0x20c>
40005ec4: f946a10b     	ldr	x11, [x8, #0xd40]
40005ec8: 39400d6c     	ldrb	w12, [x11, #0x3]
40005ecc: 3940096b     	ldrb	w11, [x11, #0x2]
40005ed0: 2a0c216b     	orr	w11, w11, w12, lsl #8
40005ed4: 6b09017f     	cmp	w11, w9
40005ed8: 7a410940     	ccmp	w10, #0x1, #0x0, eq
40005edc: 5100054a     	sub	w10, w10, #0x1
40005ee0: 540001a9     	b.ls	0x40005f14 <virtio_blk_write_sector+0x23c>
40005ee4: d5033fbf     	dmb	sy
40005ee8: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005eec: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005ef0: 71018d7f     	cmp	w11, #0x63
40005ef4: 54fffe8c     	b.gt	0x40005ec4 <virtio_blk_write_sector+0x1ec>
40005ef8: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005efc: 1100056b     	add	w11, w11, #0x1
40005f00: b81fc3ab     	stur	w11, [x29, #-0x4]
40005f04: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005f08: 7101917f     	cmp	w11, #0x64
40005f0c: 54ffff6b     	b.lt	0x40005ef8 <virtio_blk_write_sector+0x220>
40005f10: 17ffffed     	b	0x40005ec4 <virtio_blk_write_sector+0x1ec>
40005f14: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005f18: 3975c109     	ldrb	w9, [x8, #0xd70]
40005f1c: 34000129     	cbz	w9, 0x40005f40 <virtio_blk_write_sector+0x268>
40005f20: 3975c101     	ldrb	w1, [x8, #0xd70]
40005f24: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005f28: 912bec00     	add	x0, x0, #0xafb
40005f2c: 97fff759     	bl	0x40003c90 <uart_printf>
40005f30: 2a1f03e0     	mov	w0, wzr
40005f34: 14000004     	b	0x40005f44 <virtio_blk_write_sector+0x26c>
40005f38: 2a1f03e0     	mov	w0, wzr
40005f3c: d65f03c0     	ret
40005f40: 52800020     	mov	w0, #0x1                // =1
40005f44: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005f48: 910083ff     	add	sp, sp, #0x20
40005f4c: d65f03c0     	ret

0000000040005f50 <virtio_net_init>:
40005f50: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40005f54: 528d2ec9     	mov	w9, #0x6976             // =26998
40005f58: 52a14001     	mov	w1, #0xa000000          // =167772160
40005f5c: 52800408     	mov	w8, #0x20               // =32
40005f60: 72ae8e49     	movk	w9, #0x7472, lsl #16
40005f64: f9000bf9     	str	x25, [sp, #0x10]
40005f68: 910003fd     	mov	x29, sp
40005f6c: a9025ff8     	stp	x24, x23, [sp, #0x20]
40005f70: a90357f6     	stp	x22, x21, [sp, #0x30]
40005f74: a9044ff4     	stp	x20, x19, [sp, #0x40]
40005f78: 14000004     	b	0x40005f88 <virtio_net_init+0x38>
40005f7c: f1000508     	subs	x8, x8, #0x1
40005f80: 91080021     	add	x1, x1, #0x200
40005f84: 54000180     	b.eq	0x40005fb4 <virtio_net_init+0x64>
40005f88: b940002a     	ldr	w10, [x1]
40005f8c: 6b09015f     	cmp	w10, w9
40005f90: 54ffff61     	b.ne	0x40005f7c <virtio_net_init+0x2c>
40005f94: b940082a     	ldr	w10, [x1, #0x8]
40005f98: 7100055f     	cmp	w10, #0x1
40005f9c: 54ffff01     	b.ne	0x40005f7c <virtio_net_init+0x2c>
40005fa0: 900001c8     	adrp	x8, 0x4003d000 <net_base>
40005fa4: d503201f     	nop
40005fa8: 1001a420     	adr	x0, 0x4000942c <__rodata_start+0x42c>
40005fac: f9000101     	str	x1, [x8]
40005fb0: 97fff738     	bl	0x40003c90 <uart_printf>
40005fb4: 900001d5     	adrp	x21, 0x4003d000 <net_base>
40005fb8: f94002a8     	ldr	x8, [x21]
40005fbc: b4001468     	cbz	x8, 0x40006248 <virtio_net_init+0x2f8>
40005fc0: 52800039     	mov	w25, #0x1               // =1
40005fc4: 52800069     	mov	w9, #0x3                // =3
40005fc8: b900711f     	str	wzr, [x8, #0x70]
40005fcc: b9007119     	str	w25, [x8, #0x70]
40005fd0: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005fd4: 9127a800     	add	x0, x0, #0x9ea
40005fd8: b9007109     	str	w9, [x8, #0x70]
40005fdc: b9401109     	ldr	w9, [x8, #0x10]
40005fe0: 121b0129     	and	w9, w9, #0x20
40005fe4: b9002109     	str	w9, [x8, #0x20]
40005fe8: 900001c9     	adrp	x9, 0x4003d000 <net_base>
40005fec: 39440101     	ldrb	w1, [x8, #0x100]
40005ff0: 39002121     	strb	w1, [x9, #0x8]
40005ff4: 900001c9     	adrp	x9, 0x4003d000 <net_base>
40005ff8: 39440502     	ldrb	w2, [x8, #0x101]
40005ffc: 39003122     	strb	w2, [x9, #0xc]
40006000: f00001a9     	adrp	x9, 0x4003d000 <net_base>
40006004: 39440903     	ldrb	w3, [x8, #0x102]
40006008: 39004123     	strb	w3, [x9, #0x10]
4000600c: f00001a9     	adrp	x9, 0x4003d000 <net_base>
40006010: 39440d04     	ldrb	w4, [x8, #0x103]
40006014: 39005124     	strb	w4, [x9, #0x14]
40006018: f00001a9     	adrp	x9, 0x4003d000 <net_base>
4000601c: 39441105     	ldrb	w5, [x8, #0x104]
40006020: 39006125     	strb	w5, [x9, #0x18]
40006024: 39441506     	ldrb	w6, [x8, #0x105]
40006028: f00001a8     	adrp	x8, 0x4003d000 <net_base>
4000602c: 39007106     	strb	w6, [x8, #0x1c]
40006030: 97fff718     	bl	0x40003c90 <uart_printf>
40006034: f94002a8     	ldr	x8, [x21]
40006038: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000603c: 91161800     	add	x0, x0, #0x586
40006040: 2a1f03e1     	mov	w1, wzr
40006044: b900311f     	str	wzr, [x8, #0x30]
40006048: b9403513     	ldr	w19, [x8, #0x34]
4000604c: 2a1303e2     	mov	w2, w19
40006050: 97fff710     	bl	0x40003c90 <uart_printf>
40006054: f94002a8     	ldr	x8, [x21]
40006058: f00001b7     	adrp	x23, 0x4003d000 <net_base>
4000605c: f00001b8     	adrp	x24, 0x4003d000 <net_base>
40006060: f00001b6     	adrp	x22, 0x4003d000 <net_base>
40006064: 34000333     	cbz	w19, 0x400060c8 <virtio_net_init+0x178>
40006068: 900021d4     	adrp	x20, 0x4043e000 <net_queue_mem>
4000606c: 91000294     	add	x20, x20, #0x0
40006070: 2a1f03e1     	mov	w1, wzr
40006074: aa1403e0     	mov	x0, x20
40006078: 52900002     	mov	w2, #0x8000             // =32768
4000607c: b90052f3     	str	w19, [x23, #0x50]
40006080: b9003913     	str	w19, [x8, #0x38]
40006084: 97fff29e     	bl	0x40002afc <memset>
40006088: f94002a8     	ldr	x8, [x21]
4000608c: 8b13128a     	add	x10, x20, x19, lsl #4
40006090: 531f7a6b     	lsl	w11, w19, #1
40006094: 52820009     	mov	w9, #0x1000             // =4096
40006098: b9002909     	str	w9, [x8, #0x28]
4000609c: 8b0a016b     	add	x11, x11, x10
400060a0: b9003d09     	str	w9, [x8, #0x3c]
400060a4: 528200a9     	mov	w9, #0x1005             // =4101
400060a8: 8b090169     	add	x9, x11, x9
400060ac: d34cfe8b     	lsr	x11, x20, #12
400060b0: f90016ca     	str	x10, [x22, #0x28]
400060b4: f00001aa     	adrp	x10, 0x4003d000 <net_base>
400060b8: 9274cd29     	and	x9, x9, #0xfffffffffffff000
400060bc: f9001314     	str	x20, [x24, #0x20]
400060c0: f9001949     	str	x9, [x10, #0x30]
400060c4: b900410b     	str	w11, [x8, #0x40]
400060c8: b9003119     	str	w25, [x8, #0x30]
400060cc: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400060d0: 91161800     	add	x0, x0, #0x586
400060d4: b9403513     	ldr	w19, [x8, #0x34]
400060d8: 52800021     	mov	w1, #0x1                // =1
400060dc: 2a1303e2     	mov	w2, w19
400060e0: 97fff6ec     	bl	0x40003c90 <uart_printf>
400060e4: 34000393     	cbz	w19, 0x40006154 <virtio_net_init+0x204>
400060e8: f94002a8     	ldr	x8, [x21]
400060ec: 90002214     	adrp	x20, 0x40446000 <net_queue_mem+0x8000>
400060f0: 91000294     	add	x20, x20, #0x0
400060f4: aa1403e0     	mov	x0, x20
400060f8: 2a1f03e1     	mov	w1, wzr
400060fc: 52900002     	mov	w2, #0x8000             // =32768
40006100: b90052f3     	str	w19, [x23, #0x50]
40006104: b9003913     	str	w19, [x8, #0x38]
40006108: 97fff27d     	bl	0x40002afc <memset>
4000610c: f94002a8     	ldr	x8, [x21]
40006110: 52820009     	mov	w9, #0x1000             // =4096
40006114: 8b13128a     	add	x10, x20, x19, lsl #4
40006118: 531f7a6b     	lsl	w11, w19, #1
4000611c: b9002909     	str	w9, [x8, #0x28]
40006120: b9003d09     	str	w9, [x8, #0x3c]
40006124: f00001a9     	adrp	x9, 0x4003d000 <net_base>
40006128: f900212a     	str	x10, [x9, #0x40]
4000612c: 8b0a0169     	add	x9, x11, x10
40006130: 528200aa     	mov	w10, #0x1005            // =4101
40006134: f00001ab     	adrp	x11, 0x4003d000 <net_base>
40006138: 8b0a0129     	add	x9, x9, x10
4000613c: f00001aa     	adrp	x10, 0x4003d000 <net_base>
40006140: f9001d74     	str	x20, [x11, #0x38]
40006144: d34cfe8b     	lsr	x11, x20, #12
40006148: 9274cd29     	and	x9, x9, #0xfffffffffffff000
4000614c: f9002549     	str	x9, [x10, #0x48]
40006150: b900410b     	str	w11, [x8, #0x40]
40006154: b94052e8     	ldr	w8, [x23, #0x50]
40006158: 34000568     	cbz	w8, 0x40006204 <virtio_net_init+0x2b4>
4000615c: f94016cb     	ldr	x11, [x22, #0x28]
40006160: f940130c     	ldr	x12, [x24, #0x20]
40006164: aa1f03e9     	mov	x9, xzr
40006168: f00001aa     	adrp	x10, 0x4003d000 <net_base>
4000616c: 9101514a     	add	x10, x10, #0x54
40006170: 5280010d     	mov	w13, #0x8               // =8
40006174: 9100116b     	add	x11, x11, #0x4
40006178: 9100398c     	add	x12, x12, #0xe
4000617c: 5280004e     	mov	w14, #0x2               // =2
40006180: d368fd4f     	lsr	x15, x10, #40
40006184: aa0c03f0     	mov	x16, x12
40006188: d358fd51     	lsr	x17, x10, #24
4000618c: 381f2e0a     	strb	w10, [x16, #-0xe]!
40006190: 381f718f     	sturb	w15, [x12, #-0x9]
40006194: d350fd4f     	lsr	x15, x10, #16
40006198: 39000e11     	strb	w17, [x16, #0x3]
4000619c: d348fd51     	lsr	x17, x10, #8
400061a0: 39000a0f     	strb	w15, [x16, #0x2]
400061a4: d360fd4f     	lsr	x15, x10, #32
400061a8: 381f3191     	sturb	w17, [x12, #-0xd]
400061ac: d378fd51     	lsr	x17, x10, #56
400061b0: 38004e0f     	strb	w15, [x16, #0x4]!
400061b4: d370fd4f     	lsr	x15, x10, #48
400061b8: 39000e11     	strb	w17, [x16, #0x3]
400061bc: 9120014a     	add	x10, x10, #0x800
400061c0: 39000a0f     	strb	w15, [x16, #0x2]
400061c4: aa0c03ef     	mov	x15, x12
400061c8: d348fd30     	lsr	x16, x9, #8
400061cc: 381fadff     	strb	wzr, [x15, #-0x6]!
400061d0: 39000dff     	strb	wzr, [x15, #0x3]
400061d4: 390009ff     	strb	wzr, [x15, #0x2]
400061d8: 8b09056f     	add	x15, x11, x9, lsl #1
400061dc: 381fb18d     	sturb	w13, [x12, #-0x5]
400061e0: 381ff19f     	sturb	wzr, [x12, #-0x1]
400061e4: 381fe18e     	sturb	w14, [x12, #-0x2]
400061e8: 3900059f     	strb	wzr, [x12, #0x1]
400061ec: 3801059f     	strb	wzr, [x12], #0x10
400061f0: 390001e9     	strb	w9, [x15]
400061f4: 91000529     	add	x9, x9, #0x1
400061f8: eb09011f     	cmp	x8, x9
400061fc: 390005f0     	strb	w16, [x15, #0x1]
40006200: 54fffc01     	b.ne	0x40006180 <virtio_net_init+0x230>
40006204: f94002a8     	ldr	x8, [x21]
40006208: 528000e9     	mov	w9, #0x7                // =7
4000620c: b9007109     	str	w9, [x8, #0x70]
40006210: f00011a9     	adrp	x9, 0x4023d000 <rx_buffers+0x1fffac>
40006214: d5033fbf     	dmb	sy
40006218: 7940a2e8     	ldrh	w8, [x23, #0x50]
4000621c: f94016ca     	ldr	x10, [x22, #0x28]
40006220: f9400bf9     	ldr	x25, [sp, #0x10]
40006224: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40006228: 7900a928     	strh	w8, [x9, #0x54]
4000622c: 53087d09     	lsr	w9, w8, #8
40006230: a94357f6     	ldp	x22, x21, [sp, #0x30]
40006234: 39000948     	strb	w8, [x10, #0x2]
40006238: a9425ff8     	ldp	x24, x23, [sp, #0x20]
4000623c: 39000d49     	strb	w9, [x10, #0x3]
40006240: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40006244: d65f03c0     	ret
40006248: a9444ff4     	ldp	x20, x19, [sp, #0x40]
4000624c: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
40006250: 91027000     	add	x0, x0, #0x9c
40006254: a94357f6     	ldp	x22, x21, [sp, #0x30]
40006258: a9425ff8     	ldp	x24, x23, [sp, #0x20]
4000625c: f9400bf9     	ldr	x25, [sp, #0x10]
40006260: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40006264: 17fff576     	b	0x4000383c <uart_puts>

0000000040006268 <virtio_net_poll>:
40006268: f00001a8     	adrp	x8, 0x4003d000 <net_base>
4000626c: f9400108     	ldr	x8, [x8]
40006270: b4000a08     	cbz	x8, 0x400063b0 <virtio_net_poll+0x148>
40006274: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006278: a9054ff4     	stp	x20, x19, [sp, #0x50]
4000627c: f00011b3     	adrp	x19, 0x4023d000 <rx_buffers+0x1fffac>
40006280: 910003fd     	mov	x29, sp
40006284: b9405a68     	ldr	w8, [x19, #0x58]
40006288: a9016ffc     	stp	x28, x27, [sp, #0x10]
4000628c: a90267fa     	stp	x26, x25, [sp, #0x20]
40006290: 11000508     	add	w8, w8, #0x1
40006294: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006298: 710fa11f     	cmp	w8, #0x3e8
4000629c: a90457f6     	stp	x22, x21, [sp, #0x40]
400062a0: b9005a68     	str	w8, [x19, #0x58]
400062a4: 54000061     	b.ne	0x400062b0 <virtio_net_poll+0x48>
400062a8: 97ffed8a     	bl	0x400018d0 <test_arp>
400062ac: b9005a7f     	str	wzr, [x19, #0x58]
400062b0: d5033fbf     	dmb	sy
400062b4: f00001b4     	adrp	x20, 0x4003d000 <net_base>
400062b8: f00011b5     	adrp	x21, 0x4023d000 <rx_buffers+0x1fffac>
400062bc: b9405a68     	ldr	w8, [x19, #0x58]
400062c0: 710f9d1f     	cmp	w8, #0x3e7
400062c4: 54000121     	b.ne	0x400062e8 <virtio_net_poll+0x80>
400062c8: f9402688     	ldr	x8, [x20, #0x48]
400062cc: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400062d0: 91031000     	add	x0, x0, #0xc4
400062d4: 39400d09     	ldrb	w9, [x8, #0x3]
400062d8: 39400908     	ldrb	w8, [x8, #0x2]
400062dc: 7940baa2     	ldrh	w2, [x21, #0x5c]
400062e0: 2a092101     	orr	w1, w8, w9, lsl #8
400062e4: 97fff66b     	bl	0x40003c90 <uart_printf>
400062e8: f9402688     	ldr	x8, [x20, #0x48]
400062ec: 7940baa9     	ldrh	w9, [x21, #0x5c]
400062f0: 39400d0a     	ldrb	w10, [x8, #0x3]
400062f4: 3940090b     	ldrb	w11, [x8, #0x2]
400062f8: 2a0a216a     	orr	w10, w11, w10, lsl #8
400062fc: 6b0a013f     	cmp	w9, w10
40006300: 54000380     	b.eq	0x40006370 <virtio_net_poll+0x108>
40006304: f00001b6     	adrp	x22, 0x4003d000 <net_base>
40006308: 90000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
4000630c: 910a0a73     	add	x19, x19, #0x282
40006310: b94052ca     	ldr	w10, [x22, #0x50]
40006314: 12003d29     	and	w9, w9, #0xffff
40006318: aa1303e0     	mov	x0, x19
4000631c: 1aca092b     	udiv	w11, w9, w10
40006320: 1b0aa569     	msub	w9, w11, w10, w9
40006324: 8b294d08     	add	x8, x8, w9, uxtw #3
40006328: 38404d09     	ldrb	w9, [x8, #0x4]!
4000632c: 3940090a     	ldrb	w10, [x8, #0x2]
40006330: 3940050b     	ldrb	w11, [x8, #0x1]
40006334: 39400d08     	ldrb	w8, [x8, #0x3]
40006338: 53103d4a     	lsl	w10, w10, #16
4000633c: 2a0b2129     	orr	w9, w9, w11, lsl #8
40006340: 2a086148     	orr	w8, w10, w8, lsl #24
40006344: 2a090101     	orr	w1, w8, w9
40006348: 97fff652     	bl	0x40003c90 <uart_printf>
4000634c: 7940baa8     	ldrh	w8, [x21, #0x5c]
40006350: 11000509     	add	w9, w8, #0x1
40006354: f9402688     	ldr	x8, [x20, #0x48]
40006358: 7900baa9     	strh	w9, [x21, #0x5c]
4000635c: 39400d0a     	ldrb	w10, [x8, #0x3]
40006360: 3940090b     	ldrb	w11, [x8, #0x2]
40006364: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006368: 6b29215f     	cmp	w10, w9, uxth
4000636c: 54fffd21     	b.ne	0x40006310 <virtio_net_poll+0xa8>
40006370: d5033fbf     	dmb	sy
40006374: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006378: f00011bb     	adrp	x27, 0x4023d000 <rx_buffers+0x1fffac>
4000637c: f9401908     	ldr	x8, [x8, #0x30]
40006380: 7940c369     	ldrh	w9, [x27, #0x60]
40006384: 39400d0a     	ldrb	w10, [x8, #0x3]
40006388: 3940090b     	ldrb	w11, [x8, #0x2]
4000638c: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006390: 6b0a013f     	cmp	w9, w10
40006394: 54000101     	b.ne	0x400063b4 <virtio_net_poll+0x14c>
40006398: a9454ff4     	ldp	x20, x19, [sp, #0x50]
4000639c: a94457f6     	ldp	x22, x21, [sp, #0x40]
400063a0: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400063a4: a94267fa     	ldp	x26, x25, [sp, #0x20]
400063a8: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400063ac: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400063b0: d65f03c0     	ret
400063b4: f0000014     	adrp	x20, 0x40009000 <__rodata_start>
400063b8: 9128ae94     	add	x20, x20, #0xa2b
400063bc: 90000035     	adrp	x21, 0x4000a000 <__rodata_start+0x1000>
400063c0: 9125cab5     	add	x21, x21, #0x972
400063c4: f00001bc     	adrp	x28, 0x4003d000 <net_base>
400063c8: f00001b9     	adrp	x25, 0x4003d000 <net_base>
400063cc: f00011ba     	adrp	x26, 0x4023d000 <rx_buffers+0x1fffac>
400063d0: 90000036     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
400063d4: 9115f2d6     	add	x22, x22, #0x57c
400063d8: 14000021     	b	0x4000645c <virtio_net_poll+0x1f4>
400063dc: aa1503e0     	mov	x0, x21
400063e0: 97fff517     	bl	0x4000383c <uart_puts>
400063e4: 7940ab48     	ldrh	w8, [x26, #0x54]
400063e8: b9405389     	ldr	w9, [x28, #0x50]
400063ec: 1ac9090a     	udiv	w10, w8, w9
400063f0: 1b09a148     	msub	w8, w10, w9, w8
400063f4: f9401729     	ldr	x9, [x25, #0x28]
400063f8: 53087eea     	lsr	w10, w23, #8
400063fc: 8b284528     	add	x8, x9, w8, uxtw #1
40006400: 3900150a     	strb	w10, [x8, #0x5]
40006404: 39001117     	strb	w23, [x8, #0x4]
40006408: d5033fbf     	dmb	sy
4000640c: 7940ab48     	ldrh	w8, [x26, #0x54]
40006410: f9401729     	ldr	x9, [x25, #0x28]
40006414: 11000508     	add	w8, w8, #0x1
40006418: 39000928     	strb	w8, [x9, #0x2]
4000641c: 53087d0a     	lsr	w10, w8, #8
40006420: 7900ab48     	strh	w8, [x26, #0x54]
40006424: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006428: f9400108     	ldr	x8, [x8]
4000642c: 39000d2a     	strb	w10, [x9, #0x3]
40006430: b900511f     	str	wzr, [x8, #0x50]
40006434: 7940c368     	ldrh	w8, [x27, #0x60]
40006438: 11000509     	add	w9, w8, #0x1
4000643c: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006440: f9401908     	ldr	x8, [x8, #0x30]
40006444: 7900c369     	strh	w9, [x27, #0x60]
40006448: 39400d0a     	ldrb	w10, [x8, #0x3]
4000644c: 3940090b     	ldrb	w11, [x8, #0x2]
40006450: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006454: 6b29215f     	cmp	w10, w9, uxth
40006458: 54fffa00     	b.eq	0x40006398 <virtio_net_poll+0x130>
4000645c: b940538a     	ldr	w10, [x28, #0x50]
40006460: 12003d29     	and	w9, w9, #0xffff
40006464: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40006468: 910e5400     	add	x0, x0, #0x395
4000646c: 1aca092b     	udiv	w11, w9, w10
40006470: 1b0aa569     	msub	w9, w11, w10, w9
40006474: 8b294d08     	add	x8, x8, w9, uxtw #3
40006478: 38404d09     	ldrb	w9, [x8, #0x4]!
4000647c: 38404d0a     	ldrb	w10, [x8, #0x4]!
40006480: 385fe10b     	ldurb	w11, [x8, #-0x2]
40006484: 3940090c     	ldrb	w12, [x8, #0x2]
40006488: 385fd10d     	ldurb	w13, [x8, #-0x3]
4000648c: 385ff10e     	ldurb	w14, [x8, #-0x1]
40006490: d370bd6b     	lsl	x11, x11, #16
40006494: 3940050f     	ldrb	w15, [x8, #0x1]
40006498: 39400d08     	ldrb	w8, [x8, #0x3]
4000649c: 53103d8c     	lsl	w12, w12, #16
400064a0: aa0d2129     	orr	x9, x9, x13, lsl #8
400064a4: aa0e616b     	orr	x11, x11, x14, lsl #24
400064a8: 2a0f214a     	orr	w10, w10, w15, lsl #8
400064ac: 2a086188     	orr	w8, w12, w8, lsl #24
400064b0: aa090177     	orr	x23, x11, x9
400064b4: 2a0a0118     	orr	w24, w8, w10
400064b8: 2a1703e2     	mov	w2, w23
400064bc: 2a1803e1     	mov	w1, w24
400064c0: 97fff5f4     	bl	0x40003c90 <uart_printf>
400064c4: aa1403e0     	mov	x0, x20
400064c8: 97fff4dd     	bl	0x4000383c <uart_puts>
400064cc: 34fff898     	cbz	w24, 0x400063dc <virtio_net_poll+0x174>
400064d0: f00001a8     	adrp	x8, 0x4003d000 <net_base>
400064d4: 91015108     	add	x8, x8, #0x54
400064d8: 7100831f     	cmp	w24, #0x20
400064dc: 8b172d13     	add	x19, x8, x23, lsl #11
400064e0: 52800408     	mov	w8, #0x20               // =32
400064e4: 1a883318     	csel	w24, w24, w8, lo
400064e8: 38401661     	ldrb	w1, [x19], #0x1
400064ec: aa1603e0     	mov	x0, x22
400064f0: 97fff5e8     	bl	0x40003c90 <uart_printf>
400064f4: f1000718     	subs	x24, x24, #0x1
400064f8: 54ffff81     	b.ne	0x400064e8 <virtio_net_poll+0x280>
400064fc: 17ffffb8     	b	0x400063dc <virtio_net_poll+0x174>

0000000040006500 <virtio_net_send>:
40006500: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006504: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006508: f00001b7     	adrp	x23, 0x4003d000 <net_base>
4000650c: 910003fd     	mov	x29, sp
40006510: f94002e8     	ldr	x8, [x23]
40006514: a9016ffc     	stp	x28, x27, [sp, #0x10]
40006518: a90267fa     	stp	x26, x25, [sp, #0x20]
4000651c: a90457f6     	stp	x22, x21, [sp, #0x40]
40006520: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006524: b4000ea8     	cbz	x8, 0x400066f8 <virtio_net_send+0x1f8>
40006528: f00011a8     	adrp	x8, 0x4023d000 <rx_buffers+0x1fffac>
4000652c: f00001b9     	adrp	x25, 0x4003d000 <net_base>
40006530: f00011b4     	adrp	x20, 0x4023d000 <rx_buffers+0x1fffac>
40006534: 91019a94     	add	x20, x20, #0x66
40006538: 7940c909     	ldrh	w9, [x8, #0x64]
4000653c: b940532a     	ldr	w10, [x25, #0x50]
40006540: aa0103f3     	mov	x19, x1
40006544: aa0003f6     	mov	x22, x0
40006548: 2a1f03e1     	mov	w1, wzr
4000654c: 1aca092b     	udiv	w11, w9, w10
40006550: 1100052c     	add	w12, w9, #0x1
40006554: 52800142     	mov	w2, #0xa                // =10
40006558: 5280015b     	mov	w27, #0xa               // =10
4000655c: 1aca098d     	udiv	w13, w12, w10
40006560: 1b0aa578     	msub	w24, w11, w10, w9
40006564: 11000929     	add	w9, w9, #0x2
40006568: 7900c909     	strh	w9, [x8, #0x64]
4000656c: 8b182e95     	add	x21, x20, x24, lsl #11
40006570: aa1503e0     	mov	x0, x21
40006574: 1b0ab1ba     	msub	w26, w13, w10, w12
40006578: 97fff161     	bl	0x40002afc <memset>
4000657c: 12003f5c     	and	w28, w26, #0xffff
40006580: aa1603e1     	mov	x1, x22
40006584: aa1303e2     	mov	x2, x19
40006588: 8b1c2e94     	add	x20, x20, x28, lsl #11
4000658c: aa1403e0     	mov	x0, x20
40006590: 97fff171     	bl	0x40002b54 <memcpy>
40006594: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006598: d358feab     	lsr	x11, x21, #24
4000659c: d350feac     	lsr	x12, x21, #16
400065a0: f9401d09     	ldr	x9, [x8, #0x38]
400065a4: d368fea8     	lsr	x8, x21, #40
400065a8: d378fead     	lsr	x13, x21, #56
400065ac: d368fe8e     	lsr	x14, x20, #40
400065b0: d360fe8f     	lsr	x15, x20, #32
400065b4: aa1303e1     	mov	x1, x19
400065b8: 8b38512a     	add	x10, x9, w24, uxtw #4
400065bc: 8b3c5129     	add	x9, x9, w28, uxtw #4
400065c0: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400065c4: 912d4400     	add	x0, x0, #0xb51
400065c8: 39000d4b     	strb	w11, [x10, #0x3]
400065cc: 53087f4b     	lsr	w11, w26, #8
400065d0: 39001548     	strb	w8, [x10, #0x5]
400065d4: d348fea8     	lsr	x8, x21, #8
400065d8: 3900094c     	strb	w12, [x10, #0x2]
400065dc: d360feac     	lsr	x12, x21, #32
400065e0: 39003d4b     	strb	w11, [x10, #0xf]
400065e4: aa0a03eb     	mov	x11, x10
400065e8: 39000548     	strb	w8, [x10, #0x1]
400065ec: 52800028     	mov	w8, #0x1                // =1
400065f0: 38004d6c     	strb	w12, [x11, #0x4]!
400065f4: d370feac     	lsr	x12, x21, #48
400065f8: 39000155     	strb	w21, [x10]
400065fc: 3900255f     	strb	wzr, [x10, #0x9]
40006600: 3900355f     	strb	wzr, [x10, #0xd]
40006604: 39003148     	strb	w8, [x10, #0xc]
40006608: 3900395a     	strb	w26, [x10, #0xe]
4000660c: 38008d5b     	strb	w27, [x10, #0x8]!
40006610: 39000d6d     	strb	w13, [x11, #0x3]
40006614: 3900096c     	strb	w12, [x11, #0x2]
40006618: d350fe8b     	lsr	x11, x20, #16
4000661c: d358fe6c     	lsr	x12, x19, #24
40006620: 39000d5f     	strb	wzr, [x10, #0x3]
40006624: 3900095f     	strb	wzr, [x10, #0x2]
40006628: d358fe8a     	lsr	x10, x20, #24
4000662c: 3900092b     	strb	w11, [x9, #0x2]
40006630: d348fe6b     	lsr	x11, x19, #8
40006634: 39000d2a     	strb	w10, [x9, #0x3]
40006638: d348fe8a     	lsr	x10, x20, #8
4000663c: 3900252b     	strb	w11, [x9, #0x9]
40006640: d350fe6b     	lsr	x11, x19, #16
40006644: 3900052a     	strb	w10, [x9, #0x1]
40006648: aa0903ea     	mov	x10, x9
4000664c: 38008d53     	strb	w19, [x10, #0x8]!
40006650: 39000134     	strb	w20, [x9]
40006654: 3900094b     	strb	w11, [x10, #0x2]
40006658: 39000d4c     	strb	w12, [x10, #0x3]
4000665c: f00021aa     	adrp	x10, 0x4043d000 <tx_buffers+0x1fff9a>
40006660: 3900353f     	strb	wzr, [x9, #0xd]
40006664: 3900313f     	strb	wzr, [x9, #0xc]
40006668: 39003d3f     	strb	wzr, [x9, #0xf]
4000666c: 3900393f     	strb	wzr, [x9, #0xe]
40006670: 7940d14b     	ldrh	w11, [x10, #0x68]
40006674: b940532c     	ldr	w12, [x25, #0x50]
40006678: 3900152e     	strb	w14, [x9, #0x5]
4000667c: d370fe8e     	lsr	x14, x20, #48
40006680: 38004d2f     	strb	w15, [x9, #0x4]!
40006684: 1acc096d     	udiv	w13, w11, w12
40006688: 3900092e     	strb	w14, [x9, #0x2]
4000668c: f00001ae     	adrp	x14, 0x4003d000 <net_base>
40006690: 1b0cadab     	msub	w11, w13, w12, w11
40006694: f94021cc     	ldr	x12, [x14, #0x40]
40006698: d378fe8d     	lsr	x13, x20, #56
4000669c: 39000d2d     	strb	w13, [x9, #0x3]
400066a0: 8b2b458b     	add	x11, x12, w11, uxtw #1
400066a4: 53087f0c     	lsr	w12, w24, #8
400066a8: 3900156c     	strb	w12, [x11, #0x5]
400066ac: 39001178     	strb	w24, [x11, #0x4]
400066b0: d5033fbf     	dmb	sy
400066b4: 7940d149     	ldrh	w9, [x10, #0x68]
400066b8: f94021cb     	ldr	x11, [x14, #0x40]
400066bc: 11000529     	add	w9, w9, #0x1
400066c0: 53087d2c     	lsr	w12, w9, #8
400066c4: 7900d149     	strh	w9, [x10, #0x68]
400066c8: 39000969     	strb	w9, [x11, #0x2]
400066cc: 39000d6c     	strb	w12, [x11, #0x3]
400066d0: d5033fbf     	dmb	sy
400066d4: f94002e9     	ldr	x9, [x23]
400066d8: b9005128     	str	w8, [x9, #0x50]
400066dc: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400066e0: a94457f6     	ldp	x22, x21, [sp, #0x40]
400066e4: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400066e8: a94267fa     	ldp	x26, x25, [sp, #0x20]
400066ec: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400066f0: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400066f4: 17fff567     	b	0x40003c90 <uart_printf>
400066f8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400066fc: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006700: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006704: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006708: a9416ffc     	ldp	x28, x27, [sp, #0x10]
4000670c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006710: d65f03c0     	ret

0000000040006714 <virtio_net_get_mac>:
40006714: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006718: f00001a9     	adrp	x9, 0x4003d000 <net_base>
4000671c: f00001aa     	adrp	x10, 0x4003d000 <net_base>
40006720: 39402108     	ldrb	w8, [x8, #0x8]
40006724: 39000008     	strb	w8, [x0]
40006728: f00001a8     	adrp	x8, 0x4003d000 <net_base>
4000672c: 39403129     	ldrb	w9, [x9, #0xc]
40006730: 39404108     	ldrb	w8, [x8, #0x10]
40006734: 3940514a     	ldrb	w10, [x10, #0x14]
40006738: 39000409     	strb	w9, [x0, #0x1]
4000673c: f00001a9     	adrp	x9, 0x4003d000 <net_base>
40006740: 39000808     	strb	w8, [x0, #0x2]
40006744: f00001a8     	adrp	x8, 0x4003d000 <net_base>
40006748: 39406129     	ldrb	w9, [x9, #0x18]
4000674c: 39407108     	ldrb	w8, [x8, #0x1c]
40006750: 39000c0a     	strb	w10, [x0, #0x3]
40006754: 39001009     	strb	w9, [x0, #0x4]
40006758: 39001408     	strb	w8, [x0, #0x5]
4000675c: d65f03c0     	ret

0000000040006760 <fat16_init>:
40006760: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40006764: a9014ffc     	stp	x28, x19, [sp, #0x10]
40006768: 910003fd     	mov	x29, sp
4000676c: d10803ff     	sub	sp, sp, #0x200
40006770: d503201f     	nop
40006774: 5001ed00     	adr	x0, 0x4000a516 <__rodata_start+0x1516>
40006778: 97fff431     	bl	0x4000383c <uart_puts>
4000677c: 910003e1     	mov	x1, sp
40006780: aa1f03e0     	mov	x0, xzr
40006784: 97fffcb3     	bl	0x40005a50 <virtio_blk_read_sector>
40006788: 34000780     	cbz	w0, 0x40006878 <fat16_init+0x118>
4000678c: 90002253     	adrp	x19, 0x4044e000 <bpb>
40006790: 91000273     	add	x19, x19, #0x0
40006794: 910003e1     	mov	x1, sp
40006798: aa1303e0     	mov	x0, x19
4000679c: 528007c2     	mov	w2, #0x3e               // =62
400067a0: 97fff0ed     	bl	0x40002b54 <memcpy>
400067a4: 90000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400067a8: 9103a421     	add	x1, x1, #0xe9
400067ac: 9100da60     	add	x0, x19, #0x36
400067b0: 528000a2     	mov	w2, #0x5                // =5
400067b4: 97fff096     	bl	0x40002a0c <kstrncmp>
400067b8: 34000160     	cbz	w0, 0x400067e4 <fat16_init+0x84>
400067bc: 90002240     	adrp	x0, 0x4044e000 <bpb>
400067c0: 9100d800     	add	x0, x0, #0x36
400067c4: 90000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400067c8: 910f3c21     	add	x1, x1, #0x3cf
400067cc: 528000a2     	mov	w2, #0x5                // =5
400067d0: 97fff08f     	bl	0x40002a0c <kstrncmp>
400067d4: 34000080     	cbz	w0, 0x400067e4 <fat16_init+0x84>
400067d8: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
400067dc: 9134c800     	add	x0, x0, #0xd32
400067e0: 97fff417     	bl	0x4000383c <uart_puts>
400067e4: 90002248     	adrp	x8, 0x4044e000 <bpb>
400067e8: 91002d08     	add	x8, x8, #0xb
400067ec: 90002253     	adrp	x19, 0x4044e000 <bpb>
400067f0: 39401d09     	ldrb	w9, [x8, #0x7]
400067f4: 3940190a     	ldrb	w10, [x8, #0x6]
400067f8: 3940050b     	ldrb	w11, [x8, #0x1]
400067fc: 3940010c     	ldrb	w12, [x8]
40006800: 39400d0d     	ldrb	w13, [x8, #0x3]
40006804: 39400901     	ldrb	w1, [x8, #0x2]
40006808: 2a092142     	orr	w2, w10, w9, lsl #8
4000680c: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
40006810: 9128e000     	add	x0, x0, #0xa38
40006814: 2a0b2189     	orr	w9, w12, w11, lsl #8
40006818: 3940310b     	ldrb	w11, [x8, #0xc]
4000681c: 39402d0c     	ldrb	w12, [x8, #0xb]
40006820: 0b02152a     	add	w10, w9, w2, lsl #5
40006824: 2a0b218b     	orr	w11, w12, w11, lsl #8
40006828: 3940150c     	ldrb	w12, [x8, #0x5]
4000682c: 5100054a     	sub	w10, w10, #0x1
40006830: 1ac90d49     	sdiv	w9, w10, w9
40006834: 3940110a     	ldrb	w10, [x8, #0x4]
40006838: 2a0a21aa     	orr	w10, w13, w10, lsl #8
4000683c: 1b0c296b     	madd	w11, w11, w12, w10
40006840: 9000224c     	adrp	x12, 0x4044e000 <bpb>
40006844: b900418a     	str	w10, [x12, #0x40]
40006848: 9000224a     	adrp	x10, 0x4044e000 <bpb>
4000684c: b900454b     	str	w11, [x10, #0x44]
40006850: 9000224a     	adrp	x10, 0x4044e000 <bpb>
40006854: b9004949     	str	w9, [x10, #0x48]
40006858: 0b0b0129     	add	w9, w9, w11
4000685c: b9004e69     	str	w9, [x19, #0x4c]
40006860: 97fff50c     	bl	0x40003c90 <uart_printf>
40006864: b9404e61     	ldr	w1, [x19, #0x4c]
40006868: b0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000686c: 910a0400     	add	x0, x0, #0x281
40006870: 97fff508     	bl	0x40003c90 <uart_printf>
40006874: 14000004     	b	0x40006884 <fat16_init+0x124>
40006878: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000687c: 9124c400     	add	x0, x0, #0x931
40006880: 97fff3ef     	bl	0x4000383c <uart_puts>
40006884: 910803ff     	add	sp, sp, #0x200
40006888: a9414ffc     	ldp	x28, x19, [sp, #0x10]
4000688c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40006890: d65f03c0     	ret

0000000040006894 <fat16_list_root>:
40006894: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006898: a9016ffc     	stp	x28, x27, [sp, #0x10]
4000689c: 910003fd     	mov	x29, sp
400068a0: a90267fa     	stp	x26, x25, [sp, #0x20]
400068a4: a9035ff8     	stp	x24, x23, [sp, #0x30]
400068a8: a90457f6     	stp	x22, x21, [sp, #0x40]
400068ac: a9054ff4     	stp	x20, x19, [sp, #0x50]
400068b0: d10843ff     	sub	sp, sp, #0x210
400068b4: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400068b8: 91256400     	add	x0, x0, #0x959
400068bc: 97fff3e0     	bl	0x4000383c <uart_puts>
400068c0: 90002255     	adrp	x21, 0x4044e000 <bpb>
400068c4: b9404aa8     	ldr	w8, [x21, #0x48]
400068c8: 34000ee8     	cbz	w8, 0x40006aa4 <fat16_list_root+0x210>
400068cc: 2a1f03f6     	mov	w22, wzr
400068d0: 90002257     	adrp	x23, 0x4044e000 <bpb>
400068d4: 910003f8     	mov	x24, sp
400068d8: b0000033     	adrp	x19, 0x4000b000 <__rodata_start+0x2000>
400068dc: 91008e73     	add	x19, x19, #0x23
400068e0: 90000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400068e4: 9114f294     	add	x20, x20, #0x53c
400068e8: 528005d9     	mov	w25, #0x2e              // =46
400068ec: 14000005     	b	0x40006900 <fat16_list_root+0x6c>
400068f0: b9404aa8     	ldr	w8, [x21, #0x48]
400068f4: 110006d6     	add	w22, w22, #0x1
400068f8: 6b0802df     	cmp	w22, w8
400068fc: 54000d42     	b.hs	0x40006aa4 <fat16_list_root+0x210>
40006900: b94046e8     	ldr	w8, [x23, #0x44]
40006904: 910043e1     	add	x1, sp, #0x10
40006908: 910043fa     	add	x26, sp, #0x10
4000690c: 0b160100     	add	w0, w8, w22
40006910: 97fffc50     	bl	0x40005a50 <virtio_blk_read_sector>
40006914: 5280021b     	mov	w27, #0x10              // =16
40006918: 14000010     	b	0x40006958 <fat16_list_root+0xc4>
4000691c: aa1a03e8     	mov	x8, x26
40006920: 910003e1     	mov	x1, sp
40006924: aa1303e0     	mov	x0, x19
40006928: 3841cd09     	ldrb	w9, [x8, #0x1c]!
4000692c: 3940090a     	ldrb	w10, [x8, #0x2]
40006930: 3940050b     	ldrb	w11, [x8, #0x1]
40006934: 39400d08     	ldrb	w8, [x8, #0x3]
40006938: 53103d4a     	lsl	w10, w10, #16
4000693c: 2a0b2129     	orr	w9, w9, w11, lsl #8
40006940: 2a086148     	orr	w8, w10, w8, lsl #24
40006944: 2a090102     	orr	w2, w8, w9
40006948: 97fff4d2     	bl	0x40003c90 <uart_printf>
4000694c: f100077b     	subs	x27, x27, #0x1
40006950: 9100835a     	add	x26, x26, #0x20
40006954: 54fffce0     	b.eq	0x400068f0 <fat16_list_root+0x5c>
40006958: 39400349     	ldrb	w9, [x26]
4000695c: 7103953f     	cmp	w9, #0xe5
40006960: 54ffff60     	b.eq	0x4000694c <fat16_list_root+0xb8>
40006964: 34000a09     	cbz	w9, 0x40006aa4 <fat16_list_root+0x210>
40006968: 39402f48     	ldrb	w8, [x26, #0xb]
4000696c: 72000d1f     	tst	w8, #0xf
40006970: 54fffee1     	b.ne	0x4000694c <fat16_list_root+0xb8>
40006974: 7100813f     	cmp	w9, #0x20
40006978: 54000061     	b.ne	0x40006984 <fat16_list_root+0xf0>
4000697c: aa1f03e9     	mov	x9, xzr
40006980: 14000003     	b	0x4000698c <fat16_list_root+0xf8>
40006984: 390003e9     	strb	w9, [sp]
40006988: 52800029     	mov	w9, #0x1                // =1
4000698c: 3940074a     	ldrb	w10, [x26, #0x1]
40006990: 7100815f     	cmp	w10, #0x20
40006994: 54000080     	b.eq	0x400069a4 <fat16_list_root+0x110>
40006998: aa09030b     	orr	x11, x24, x9
4000699c: 91000529     	add	x9, x9, #0x1
400069a0: 3900016a     	strb	w10, [x11]
400069a4: 39400b4a     	ldrb	w10, [x26, #0x2]
400069a8: 7100815f     	cmp	w10, #0x20
400069ac: 54000080     	b.eq	0x400069bc <fat16_list_root+0x128>
400069b0: aa09030b     	orr	x11, x24, x9
400069b4: 91000529     	add	x9, x9, #0x1
400069b8: 3900016a     	strb	w10, [x11]
400069bc: 39400f4a     	ldrb	w10, [x26, #0x3]
400069c0: 7100815f     	cmp	w10, #0x20
400069c4: 54000080     	b.eq	0x400069d4 <fat16_list_root+0x140>
400069c8: 9100052b     	add	x11, x9, #0x1
400069cc: 38296b0a     	strb	w10, [x24, x9]
400069d0: aa0b03e9     	mov	x9, x11
400069d4: 3940134a     	ldrb	w10, [x26, #0x4]
400069d8: 7100815f     	cmp	w10, #0x20
400069dc: 54000080     	b.eq	0x400069ec <fat16_list_root+0x158>
400069e0: 9100052b     	add	x11, x9, #0x1
400069e4: 38296b0a     	strb	w10, [x24, x9]
400069e8: aa0b03e9     	mov	x9, x11
400069ec: 3940174a     	ldrb	w10, [x26, #0x5]
400069f0: 7100815f     	cmp	w10, #0x20
400069f4: 54000080     	b.eq	0x40006a04 <fat16_list_root+0x170>
400069f8: 9100052b     	add	x11, x9, #0x1
400069fc: 38296b0a     	strb	w10, [x24, x9]
40006a00: aa0b03e9     	mov	x9, x11
40006a04: 39401b4a     	ldrb	w10, [x26, #0x6]
40006a08: 7100815f     	cmp	w10, #0x20
40006a0c: 54000080     	b.eq	0x40006a1c <fat16_list_root+0x188>
40006a10: 9100052b     	add	x11, x9, #0x1
40006a14: 38296b0a     	strb	w10, [x24, x9]
40006a18: aa0b03e9     	mov	x9, x11
40006a1c: 39401f4a     	ldrb	w10, [x26, #0x7]
40006a20: 7100815f     	cmp	w10, #0x20
40006a24: 54000080     	b.eq	0x40006a34 <fat16_list_root+0x1a0>
40006a28: 9100052b     	add	x11, x9, #0x1
40006a2c: 38296b0a     	strb	w10, [x24, x9]
40006a30: aa0b03e9     	mov	x9, x11
40006a34: 3940234b     	ldrb	w11, [x26, #0x8]
40006a38: 7100817f     	cmp	w11, #0x20
40006a3c: 540001e0     	b.eq	0x40006a78 <fat16_list_root+0x1e4>
40006a40: 3940274c     	ldrb	w12, [x26, #0x9]
40006a44: 8b09030d     	add	x13, x24, x9
40006a48: 9100092a     	add	x10, x9, #0x2
40006a4c: 390001b9     	strb	w25, [x13]
40006a50: 7100819f     	cmp	w12, #0x20
40006a54: 390005ab     	strb	w11, [x13, #0x1]
40006a58: 54000080     	b.eq	0x40006a68 <fat16_list_root+0x1d4>
40006a5c: 91000d29     	add	x9, x9, #0x3
40006a60: 382a6b0c     	strb	w12, [x24, x10]
40006a64: aa0903ea     	mov	x10, x9
40006a68: 39402b4b     	ldrb	w11, [x26, #0xa]
40006a6c: 7100817f     	cmp	w11, #0x20
40006a70: 54000101     	b.ne	0x40006a90 <fat16_list_root+0x1fc>
40006a74: aa0a03e9     	mov	x9, x10
40006a78: 38296b1f     	strb	wzr, [x24, x9]
40006a7c: 3627f508     	tbz	w8, #0x4, 0x4000691c <fat16_list_root+0x88>
40006a80: 910003e1     	mov	x1, sp
40006a84: aa1403e0     	mov	x0, x20
40006a88: 97fff482     	bl	0x40003c90 <uart_printf>
40006a8c: 17ffffb0     	b	0x4000694c <fat16_list_root+0xb8>
40006a90: 91000549     	add	x9, x10, #0x1
40006a94: 382a6b0b     	strb	w11, [x24, x10]
40006a98: 38296b1f     	strb	wzr, [x24, x9]
40006a9c: 3627f408     	tbz	w8, #0x4, 0x4000691c <fat16_list_root+0x88>
40006aa0: 17fffff8     	b	0x40006a80 <fat16_list_root+0x1ec>
40006aa4: 910843ff     	add	sp, sp, #0x210
40006aa8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006aac: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006ab0: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006ab4: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006ab8: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006abc: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006ac0: d65f03c0     	ret

0000000040006ac4 <fat16_get_next_cluster>:
40006ac4: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40006ac8: f9000bfc     	str	x28, [sp, #0x10]
40006acc: 910003fd     	mov	x29, sp
40006ad0: a9024ff4     	stp	x20, x19, [sp, #0x20]
40006ad4: d10803ff     	sub	sp, sp, #0x200
40006ad8: 90002248     	adrp	x8, 0x4044e000 <bpb>
40006adc: 12181c09     	and	w9, w0, #0xff00
40006ae0: d37f1c13     	ubfiz	x19, x0, #1, #8
40006ae4: b9404108     	ldr	w8, [x8, #0x40]
40006ae8: 910003e1     	mov	x1, sp
40006aec: 910003f4     	mov	x20, sp
40006af0: 0b492108     	add	w8, w8, w9, lsr #8
40006af4: aa0803e0     	mov	x0, x8
40006af8: 97fffbd6     	bl	0x40005a50 <virtio_blk_read_sector>
40006afc: 8b130288     	add	x8, x20, x19
40006b00: 39400509     	ldrb	w9, [x8, #0x1]
40006b04: 39400108     	ldrb	w8, [x8]
40006b08: 2a092100     	orr	w0, w8, w9, lsl #8
40006b0c: 910803ff     	add	sp, sp, #0x200
40006b10: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40006b14: f9400bfc     	ldr	x28, [sp, #0x10]
40006b18: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40006b1c: d65f03c0     	ret

0000000040006b20 <fat16_read_file>:
40006b20: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006b24: a9016ffc     	stp	x28, x27, [sp, #0x10]
40006b28: 910003fd     	mov	x29, sp
40006b2c: a90267fa     	stp	x26, x25, [sp, #0x20]
40006b30: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006b34: a90457f6     	stp	x22, x21, [sp, #0x40]
40006b38: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006b3c: d110c3ff     	sub	sp, sp, #0x430
40006b40: aa0103f3     	mov	x19, x1
40006b44: 910877e1     	add	x1, sp, #0x21d
40006b48: aa0203f5     	mov	x21, x2
40006b4c: 94000084     	bl	0x40006d5c <to_fat_name>
40006b50: 90002254     	adrp	x20, 0x4044e000 <bpb>
40006b54: b9404a88     	ldr	w8, [x20, #0x48]
40006b58: 34000788     	cbz	w8, 0x40006c48 <fat16_read_file+0x128>
40006b5c: 2a1f03f6     	mov	w22, wzr
40006b60: 90002257     	adrp	x23, 0x4044e000 <bpb>
40006b64: 910077f8     	add	x24, sp, #0x1d
40006b68: 14000005     	b	0x40006b7c <fat16_read_file+0x5c>
40006b6c: b9404a88     	ldr	w8, [x20, #0x48]
40006b70: 110006d6     	add	w22, w22, #0x1
40006b74: 6b0802df     	cmp	w22, w8
40006b78: 54000682     	b.hs	0x40006c48 <fat16_read_file+0x128>
40006b7c: b94046e8     	ldr	w8, [x23, #0x44]
40006b80: 910077e1     	add	x1, sp, #0x1d
40006b84: 0b160100     	add	w0, w8, w22
40006b88: 97fffbb2     	bl	0x40005a50 <virtio_blk_read_sector>
40006b8c: aa1f03f9     	mov	x25, xzr
40006b90: 14000004     	b	0x40006ba0 <fat16_read_file+0x80>
40006b94: 91008339     	add	x25, x25, #0x20
40006b98: f108033f     	cmp	x25, #0x200
40006b9c: 54fffe80     	b.eq	0x40006b6c <fat16_read_file+0x4c>
40006ba0: 38796b08     	ldrb	w8, [x24, x25]
40006ba4: 7103951f     	cmp	w8, #0xe5
40006ba8: 54ffff60     	b.eq	0x40006b94 <fat16_read_file+0x74>
40006bac: 340004e8     	cbz	w8, 0x40006c48 <fat16_read_file+0x128>
40006bb0: 8b190308     	add	x8, x24, x25
40006bb4: 39402d08     	ldrb	w8, [x8, #0xb]
40006bb8: 7200111f     	tst	w8, #0x1f
40006bbc: 54fffec1     	b.ne	0x40006b94 <fat16_read_file+0x74>
40006bc0: 8b190300     	add	x0, x24, x25
40006bc4: 910877e1     	add	x1, sp, #0x21d
40006bc8: 52800162     	mov	w2, #0xb                // =11
40006bcc: 97ffef90     	bl	0x40002a0c <kstrncmp>
40006bd0: 35fffe20     	cbnz	w0, 0x40006b94 <fat16_read_file+0x74>
40006bd4: 910077e8     	add	x8, sp, #0x1d
40006bd8: 8b190108     	add	x8, x8, x25
40006bdc: aa0803e9     	mov	x9, x8
40006be0: 3841cd2a     	ldrb	w10, [x9, #0x1c]!
40006be4: 3940092b     	ldrb	w11, [x9, #0x2]
40006be8: 3940052c     	ldrb	w12, [x9, #0x1]
40006bec: 39400d29     	ldrb	w9, [x9, #0x3]
40006bf0: d370bd6b     	lsl	x11, x11, #16
40006bf4: aa0c214a     	orr	x10, x10, x12, lsl #8
40006bf8: aa096169     	orr	x9, x11, x9, lsl #24
40006bfc: aa0a0136     	orr	x22, x9, x10
40006c00: 34000a16     	cbz	w22, 0x40006d40 <fat16_read_file+0x220>
40006c04: 39406d09     	ldrb	w9, [x8, #0x1b]
40006c08: 39406908     	ldrb	w8, [x8, #0x1a]
40006c0c: 2a09210a     	orr	w10, w8, w9, lsl #8
40006c10: 529ffea9     	mov	w9, #0xfff5             // =65525
40006c14: 51000948     	sub	w8, w10, #0x2
40006c18: 6b09011f     	cmp	w8, w9
40006c1c: 540009a8     	b.hi	0x40006d50 <fat16_read_file+0x230>
40006c20: eb1502df     	cmp	x22, x21
40006c24: d10006b7     	sub	x23, x21, #0x1
40006c28: aa1f03f4     	mov	x20, xzr
40006c2c: 9a9532c8     	csel	x8, x22, x21, lo
40006c30: eb1702df     	cmp	x22, x23
40006c34: 9000225b     	adrp	x27, 0x4044e000 <bpb>
40006c38: 9a9732d9     	csel	x25, x22, x23, lo
40006c3c: 5280401c     	mov	w28, #0x200             // =512
40006c40: f90007e8     	str	x8, [sp, #0x8]
40006c44: 1400001b     	b	0x40006cb0 <fat16_read_file+0x190>
40006c48: 12800014     	mov	w20, #-0x1              // =-1
40006c4c: 2a1403e0     	mov	w0, w20
40006c50: 9110c3ff     	add	sp, sp, #0x430
40006c54: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006c58: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006c5c: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006c60: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006c64: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006c68: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006c6c: d65f03c0     	ret
40006c70: 90002248     	adrp	x8, 0x4044e000 <bpb>
40006c74: f9400be9     	ldr	x9, [sp, #0x10]
40006c78: 9108a3e1     	add	x1, sp, #0x228
40006c7c: b9404108     	ldr	w8, [x8, #0x40]
40006c80: d37f1d35     	ubfiz	x21, x9, #1, #8
40006c84: 0b492100     	add	w0, w8, w9, lsr #8
40006c88: 97fffb72     	bl	0x40005a50 <virtio_blk_read_sector>
40006c8c: 9108a3e8     	add	x8, sp, #0x228
40006c90: 8b150108     	add	x8, x8, x21
40006c94: 39400509     	ldrb	w9, [x8, #0x1]
40006c98: 39400108     	ldrb	w8, [x8]
40006c9c: 2a09210a     	orr	w10, w8, w9, lsl #8
40006ca0: 529ffec9     	mov	w9, #0xfff6             // =65526
40006ca4: 51000948     	sub	w8, w10, #0x2
40006ca8: 6b09011f     	cmp	w8, w9
40006cac: 54000542     	b.hs	0x40006d54 <fat16_read_file+0x234>
40006cb0: f94007e8     	ldr	x8, [sp, #0x8]
40006cb4: eb08029f     	cmp	x20, x8
40006cb8: 540004e2     	b.hs	0x40006d54 <fat16_read_file+0x234>
40006cbc: 39403768     	ldrb	w8, [x27, #0xd]
40006cc0: f9000bea     	str	x10, [sp, #0x10]
40006cc4: 34fffd68     	cbz	w8, 0x40006c70 <fat16_read_file+0x150>
40006cc8: 51000949     	sub	w9, w10, #0x2
40006ccc: 52800038     	mov	w24, #0x1               // =1
40006cd0: 1b087d28     	mul	w8, w9, w8
40006cd4: 90002249     	adrp	x9, 0x4044e000 <bpb>
40006cd8: b9404d29     	ldr	w9, [x9, #0x4c]
40006cdc: 0b08013a     	add	w26, w9, w8
40006ce0: 2a1a03e0     	mov	w0, w26
40006ce4: 910077e1     	add	x1, sp, #0x1d
40006ce8: 97fffb5a     	bl	0x40005a50 <virtio_blk_read_sector>
40006cec: 91080288     	add	x8, x20, #0x200
40006cf0: cb1402c9     	sub	x9, x22, x20
40006cf4: cb1402ea     	sub	x10, x23, x20
40006cf8: eb16011f     	cmp	x8, x22
40006cfc: 8b140260     	add	x0, x19, x20
40006d00: 910077e1     	add	x1, sp, #0x1d
40006d04: 9a9c8128     	csel	x8, x9, x28, hi
40006d08: 8b140109     	add	x9, x8, x20
40006d0c: eb17013f     	cmp	x9, x23
40006d10: 9a888155     	csel	x21, x10, x8, hi
40006d14: aa1503e2     	mov	x2, x21
40006d18: 97ffef8f     	bl	0x40002b54 <memcpy>
40006d1c: 8b1402b4     	add	x20, x21, x20
40006d20: eb19029f     	cmp	x20, x25
40006d24: 54fffa62     	b.hs	0x40006c70 <fat16_read_file+0x150>
40006d28: 39403768     	ldrb	w8, [x27, #0xd]
40006d2c: 1100075a     	add	w26, w26, #0x1
40006d30: eb08031f     	cmp	x24, x8
40006d34: 91000718     	add	x24, x24, #0x1
40006d38: 54fffd43     	b.lo	0x40006ce0 <fat16_read_file+0x1c0>
40006d3c: 17ffffcd     	b	0x40006c70 <fat16_read_file+0x150>
40006d40: 2a1f03f4     	mov	w20, wzr
40006d44: b4fff855     	cbz	x21, 0x40006c4c <fat16_read_file+0x12c>
40006d48: 3900027f     	strb	wzr, [x19]
40006d4c: 17ffffc0     	b	0x40006c4c <fat16_read_file+0x12c>
40006d50: aa1f03f4     	mov	x20, xzr
40006d54: 38346a7f     	strb	wzr, [x19, x20]
40006d58: 17ffffbd     	b	0x40006c4c <fat16_read_file+0x12c>

0000000040006d5c <to_fat_name>:
40006d5c: 52800408     	mov	w8, #0x20               // =32
40006d60: 39000028     	strb	w8, [x1]
40006d64: 39000428     	strb	w8, [x1, #0x1]
40006d68: 39000828     	strb	w8, [x1, #0x2]
40006d6c: 39000c28     	strb	w8, [x1, #0x3]
40006d70: 39001028     	strb	w8, [x1, #0x4]
40006d74: 39001428     	strb	w8, [x1, #0x5]
40006d78: 39001828     	strb	w8, [x1, #0x6]
40006d7c: 39001c28     	strb	w8, [x1, #0x7]
40006d80: 39002028     	strb	w8, [x1, #0x8]
40006d84: 39002428     	strb	w8, [x1, #0x9]
40006d88: 39002828     	strb	w8, [x1, #0xa]
40006d8c: 39400009     	ldrb	w9, [x0]
40006d90: 340002a9     	cbz	w9, 0x40006de4 <to_fat_name+0x88>
40006d94: aa1f03e8     	mov	x8, xzr
40006d98: 9100040a     	add	x10, x0, #0x1
40006d9c: 12001d2b     	and	w11, w9, #0xff
40006da0: 7100b97f     	cmp	w11, #0x2e
40006da4: 540001c0     	b.eq	0x40006ddc <to_fat_name+0x80>
40006da8: f1001d1f     	cmp	x8, #0x7
40006dac: 54000188     	b.hi	0x40006ddc <to_fat_name+0x80>
40006db0: 5101852b     	sub	w11, w9, #0x61
40006db4: 5100812c     	sub	w12, w9, #0x20
40006db8: 12001d6b     	and	w11, w11, #0xff
40006dbc: 7100697f     	cmp	w11, #0x1a
40006dc0: 9100050b     	add	x11, x8, #0x1
40006dc4: 1a893189     	csel	w9, w12, w9, lo
40006dc8: 38286829     	strb	w9, [x1, x8]
40006dcc: 38686949     	ldrb	w9, [x10, x8]
40006dd0: aa0b03e8     	mov	x8, x11
40006dd4: 35fffe49     	cbnz	w9, 0x40006d9c <to_fat_name+0x40>
40006dd8: 2a0b03e8     	mov	w8, w11
40006ddc: 2a0803e9     	mov	w9, w8
40006de0: 14000002     	b	0x40006de8 <to_fat_name+0x8c>
40006de4: aa1f03e9     	mov	x9, xzr
40006de8: 8b000128     	add	x8, x9, x0
40006dec: 91000d08     	add	x8, x8, #0x3
40006df0: 3869680a     	ldrb	w10, [x0, x9]
40006df4: 340000ea     	cbz	w10, 0x40006e10 <to_fat_name+0xb4>
40006df8: 7100b95f     	cmp	w10, #0x2e
40006dfc: 540000c0     	b.eq	0x40006e14 <to_fat_name+0xb8>
40006e00: 91000529     	add	x9, x9, #0x1
40006e04: 91000508     	add	x8, x8, #0x1
40006e08: 3869680a     	ldrb	w10, [x0, x9]
40006e0c: 35ffff6a     	cbnz	w10, 0x40006df8 <to_fat_name+0x9c>
40006e10: d65f03c0     	ret
40006e14: 11000529     	add	w9, w9, #0x1
40006e18: 38694809     	ldrb	w9, [x0, w9, uxtw]
40006e1c: 34ffffa9     	cbz	w9, 0x40006e10 <to_fat_name+0xb4>
40006e20: 5101852a     	sub	w10, w9, #0x61
40006e24: 5100812b     	sub	w11, w9, #0x20
40006e28: 7100695f     	cmp	w10, #0x1a
40006e2c: 1a893169     	csel	w9, w11, w9, lo
40006e30: 39002029     	strb	w9, [x1, #0x8]
40006e34: 385ff109     	ldurb	w9, [x8, #-0x1]
40006e38: 34fffec9     	cbz	w9, 0x40006e10 <to_fat_name+0xb4>
40006e3c: 5101852a     	sub	w10, w9, #0x61
40006e40: 5100812b     	sub	w11, w9, #0x20
40006e44: 7100695f     	cmp	w10, #0x1a
40006e48: 1a893169     	csel	w9, w11, w9, lo
40006e4c: 39002429     	strb	w9, [x1, #0x9]
40006e50: 39400108     	ldrb	w8, [x8]
40006e54: 34fffde8     	cbz	w8, 0x40006e10 <to_fat_name+0xb4>
40006e58: 51018509     	sub	w9, w8, #0x61
40006e5c: 5100810a     	sub	w10, w8, #0x20
40006e60: 7100693f     	cmp	w9, #0x1a
40006e64: 1a883148     	csel	w8, w10, w8, lo
40006e68: 39002828     	strb	w8, [x1, #0xa]
40006e6c: d65f03c0     	ret

0000000040006e70 <fat16_set_fat_entry>:
40006e70: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40006e74: f9000bfc     	str	x28, [sp, #0x10]
40006e78: 910003fd     	mov	x29, sp
40006e7c: a90257f6     	stp	x22, x21, [sp, #0x20]
40006e80: a9034ff4     	stp	x20, x19, [sp, #0x30]
40006e84: d10803ff     	sub	sp, sp, #0x200
40006e88: 90002248     	adrp	x8, 0x4044e000 <bpb>
40006e8c: 12181c09     	and	w9, w0, #0xff00
40006e90: d37f1c15     	ubfiz	x21, x0, #1, #8
40006e94: b9404108     	ldr	w8, [x8, #0x40]
40006e98: 2a0103f4     	mov	w20, w1
40006e9c: 910003e1     	mov	x1, sp
40006ea0: 910003f6     	mov	x22, sp
40006ea4: 0b492113     	add	w19, w8, w9, lsr #8
40006ea8: aa1303e0     	mov	x0, x19
40006eac: 97fffae9     	bl	0x40005a50 <virtio_blk_read_sector>
40006eb0: 53087e88     	lsr	w8, w20, #8
40006eb4: 8b1502c9     	add	x9, x22, x21
40006eb8: 910003e1     	mov	x1, sp
40006ebc: aa1303e0     	mov	x0, x19
40006ec0: 39000134     	strb	w20, [x9]
40006ec4: 39000528     	strb	w8, [x9, #0x1]
40006ec8: 97fffb84     	bl	0x40005cd8 <virtio_blk_write_sector>
40006ecc: 90002248     	adrp	x8, 0x4044e000 <bpb>
40006ed0: 39404108     	ldrb	w8, [x8, #0x10]
40006ed4: 7100091f     	cmp	w8, #0x2
40006ed8: 540001c3     	b.lo	0x40006f10 <fat16_set_fat_entry+0xa0>
40006edc: 52800034     	mov	w20, #0x1               // =1
40006ee0: 90002255     	adrp	x21, 0x4044e000 <bpb>
40006ee4: 910042b5     	add	x21, x21, #0x10
40006ee8: 39401ea8     	ldrb	w8, [x21, #0x7]
40006eec: 39401aa9     	ldrb	w9, [x21, #0x6]
40006ef0: 910003e1     	mov	x1, sp
40006ef4: 2a082128     	orr	w8, w9, w8, lsl #8
40006ef8: 1b084e80     	madd	w0, w20, w8, w19
40006efc: 97fffb77     	bl	0x40005cd8 <virtio_blk_write_sector>
40006f00: 394002a8     	ldrb	w8, [x21]
40006f04: 11000694     	add	w20, w20, #0x1
40006f08: 6b08029f     	cmp	w20, w8
40006f0c: 54fffee3     	b.lo	0x40006ee8 <fat16_set_fat_entry+0x78>
40006f10: 910803ff     	add	sp, sp, #0x200
40006f14: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40006f18: f9400bfc     	ldr	x28, [sp, #0x10]
40006f1c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40006f20: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40006f24: d65f03c0     	ret

0000000040006f28 <fat16_allocate_cluster>:
40006f28: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40006f2c: f9000bfc     	str	x28, [sp, #0x10]
40006f30: 910003fd     	mov	x29, sp
40006f34: a9025ff8     	stp	x24, x23, [sp, #0x20]
40006f38: a90357f6     	stp	x22, x21, [sp, #0x30]
40006f3c: a9044ff4     	stp	x20, x19, [sp, #0x40]
40006f40: d10803ff     	sub	sp, sp, #0x200
40006f44: 90002256     	adrp	x22, 0x4044e000 <bpb>
40006f48: 91005ad6     	add	x22, x22, #0x16
40006f4c: 394006c8     	ldrb	w8, [x22, #0x1]
40006f50: 394002c9     	ldrb	w9, [x22]
40006f54: 2a082128     	orr	w8, w9, w8, lsl #8
40006f58: 340006e8     	cbz	w8, 0x40007034 <fat16_allocate_cluster+0x10c>
40006f5c: aa1f03f7     	mov	x23, xzr
40006f60: aa1f03f4     	mov	x20, xzr
40006f64: 90002255     	adrp	x21, 0x4044e000 <bpb>
40006f68: 910003f8     	mov	x24, sp
40006f6c: 14000008     	b	0x40006f8c <fat16_allocate_cluster+0x64>
40006f70: 394006c8     	ldrb	w8, [x22, #0x1]
40006f74: 394002c9     	ldrb	w9, [x22]
40006f78: 91000694     	add	x20, x20, #0x1
40006f7c: 910402f7     	add	x23, x23, #0x100
40006f80: aa082128     	orr	x8, x9, x8, lsl #8
40006f84: eb08029f     	cmp	x20, x8
40006f88: 54000562     	b.hs	0x40007034 <fat16_allocate_cluster+0x10c>
40006f8c: b94042a8     	ldr	w8, [x21, #0x40]
40006f90: 910003e1     	mov	x1, sp
40006f94: 8b080280     	add	x0, x20, x8
40006f98: 97fffaae     	bl	0x40005a50 <virtio_blk_read_sector>
40006f9c: aa1f03e8     	mov	x8, xzr
40006fa0: aa1703f3     	mov	x19, x23
40006fa4: 14000005     	b	0x40006fb8 <fat16_allocate_cluster+0x90>
40006fa8: 91000908     	add	x8, x8, #0x2
40006fac: 91000673     	add	x19, x19, #0x1
40006fb0: f108011f     	cmp	x8, #0x200
40006fb4: 54fffde0     	b.eq	0x40006f70 <fat16_allocate_cluster+0x48>
40006fb8: f27f3a7f     	tst	x19, #0xfffe
40006fbc: 54ffff60     	b.eq	0x40006fa8 <fat16_allocate_cluster+0x80>
40006fc0: 78686b09     	ldrh	w9, [x24, x8]
40006fc4: 35ffff29     	cbnz	w9, 0x40006fa8 <fat16_allocate_cluster+0x80>
40006fc8: b94042a9     	ldr	w9, [x21, #0x40]
40006fcc: 910003ea     	mov	x10, sp
40006fd0: 910003e1     	mov	x1, sp
40006fd4: 529fffeb     	mov	w11, #0xffff            // =65535
40006fd8: 7828694b     	strh	w11, [x10, x8]
40006fdc: 0b140120     	add	w0, w9, w20
40006fe0: 97fffb3e     	bl	0x40005cd8 <virtio_blk_write_sector>
40006fe4: 90002248     	adrp	x8, 0x4044e000 <bpb>
40006fe8: 39404108     	ldrb	w8, [x8, #0x10]
40006fec: 7100091f     	cmp	w8, #0x2
40006ff0: 54000243     	b.lo	0x40007038 <fat16_allocate_cluster+0x110>
40006ff4: 52800036     	mov	w22, #0x1               // =1
40006ff8: 90002257     	adrp	x23, 0x4044e000 <bpb>
40006ffc: 910042f7     	add	x23, x23, #0x10
40007000: 39401ee8     	ldrb	w8, [x23, #0x7]
40007004: 39401ae9     	ldrb	w9, [x23, #0x6]
40007008: 910003e1     	mov	x1, sp
4000700c: b94042aa     	ldr	w10, [x21, #0x40]
40007010: 2a082128     	orr	w8, w9, w8, lsl #8
40007014: 0b140149     	add	w9, w10, w20
40007018: 1b0826c0     	madd	w0, w22, w8, w9
4000701c: 97fffb2f     	bl	0x40005cd8 <virtio_blk_write_sector>
40007020: 394002e8     	ldrb	w8, [x23]
40007024: 110006d6     	add	w22, w22, #0x1
40007028: 6b0802df     	cmp	w22, w8
4000702c: 54fffea3     	b.lo	0x40007000 <fat16_allocate_cluster+0xd8>
40007030: 14000002     	b	0x40007038 <fat16_allocate_cluster+0x110>
40007034: 2a1f03f3     	mov	w19, wzr
40007038: 2a1303e0     	mov	w0, w19
4000703c: 910803ff     	add	sp, sp, #0x200
40007040: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40007044: f9400bfc     	ldr	x28, [sp, #0x10]
40007048: a94357f6     	ldp	x22, x21, [sp, #0x30]
4000704c: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40007050: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40007054: d65f03c0     	ret

0000000040007058 <fat16_write_file>:
40007058: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
4000705c: a9016ffc     	stp	x28, x27, [sp, #0x10]
40007060: 910003fd     	mov	x29, sp
40007064: a90267fa     	stp	x26, x25, [sp, #0x20]
40007068: a9035ff8     	stp	x24, x23, [sp, #0x30]
4000706c: a90457f6     	stp	x22, x21, [sp, #0x40]
40007070: a9054ff4     	stp	x20, x19, [sp, #0x50]
40007074: d11083ff     	sub	sp, sp, #0x420
40007078: aa0103f4     	mov	x20, x1
4000707c: 910837e1     	add	x1, sp, #0x20d
40007080: aa0203f3     	mov	x19, x2
40007084: 97ffff36     	bl	0x40006d5c <to_fat_name>
40007088: f0002236     	adrp	x22, 0x4044e000 <bpb>
4000708c: b9404ac8     	ldr	w8, [x22, #0x48]
40007090: 34000d48     	cbz	w8, 0x40007238 <fat16_write_file+0x1e0>
40007094: aa1f03f5     	mov	x21, xzr
40007098: 2a1f03f8     	mov	w24, wzr
4000709c: 2a1f03f7     	mov	w23, wzr
400070a0: f0002239     	adrp	x25, 0x4044e000 <bpb>
400070a4: 910033fa     	add	x26, sp, #0xc
400070a8: 1400000b     	b	0x400070d4 <fat16_write_file+0x7c>
400070ac: b40000d5     	cbz	x21, 0x400070c4 <fat16_write_file+0x6c>
400070b0: 910837e1     	add	x1, sp, #0x20d
400070b4: aa1503e0     	mov	x0, x21
400070b8: 52800162     	mov	w2, #0xb                // =11
400070bc: 97ffee54     	bl	0x40002a0c <kstrncmp>
400070c0: 34000480     	cbz	w0, 0x40007150 <fat16_write_file+0xf8>
400070c4: b9404ac8     	ldr	w8, [x22, #0x48]
400070c8: 110006f7     	add	w23, w23, #0x1
400070cc: 6b0802ff     	cmp	w23, w8
400070d0: 540003e2     	b.hs	0x4000714c <fat16_write_file+0xf4>
400070d4: b9404728     	ldr	w8, [x25, #0x44]
400070d8: 910033e1     	add	x1, sp, #0xc
400070dc: 0b170100     	add	w0, w8, w23
400070e0: 97fffa5c     	bl	0x40005a50 <virtio_blk_read_sector>
400070e4: aa1f03fb     	mov	x27, xzr
400070e8: 14000008     	b	0x40007108 <fat16_write_file+0xb0>
400070ec: 910837e1     	add	x1, sp, #0x20d
400070f0: 52800162     	mov	w2, #0xb                // =11
400070f4: 97ffee46     	bl	0x40002a0c <kstrncmp>
400070f8: 340001c0     	cbz	w0, 0x40007130 <fat16_write_file+0xd8>
400070fc: 9100837b     	add	x27, x27, #0x20
40007100: f108037f     	cmp	x27, #0x200
40007104: 54fffd40     	b.eq	0x400070ac <fat16_write_file+0x54>
40007108: 8b1b0340     	add	x0, x26, x27
4000710c: 39400008     	ldrb	w8, [x0]
40007110: 7103951f     	cmp	w8, #0xe5
40007114: 7a401904     	ccmp	w8, #0x0, #0x4, ne
40007118: 54fffea1     	b.ne	0x400070ec <fat16_write_file+0x94>
4000711c: b5ffff15     	cbnz	x21, 0x400070fc <fat16_write_file+0xa4>
40007120: b9404728     	ldr	w8, [x25, #0x44]
40007124: aa0003f5     	mov	x21, x0
40007128: 0b170118     	add	w24, w8, w23
4000712c: 17fffff4     	b	0x400070fc <fat16_write_file+0xa4>
40007130: 8b1b0348     	add	x8, x26, x27
40007134: 39402d09     	ldrb	w9, [x8, #0xb]
40007138: 3727fe29     	tbnz	w9, #0x4, 0x400070fc <fat16_write_file+0xa4>
4000713c: b9404729     	ldr	w9, [x25, #0x44]
40007140: aa0803f5     	mov	x21, x8
40007144: 0b170138     	add	w24, w9, w23
40007148: 17ffffda     	b	0x400070b0 <fat16_write_file+0x58>
4000714c: b4000775     	cbz	x21, 0x40007238 <fat16_write_file+0x1e0>
40007150: 910837e1     	add	x1, sp, #0x20d
40007154: aa1503e0     	mov	x0, x21
40007158: 52800162     	mov	w2, #0xb                // =11
4000715c: b90007f8     	str	w24, [sp, #0x4]
40007160: 97ffee2b     	bl	0x40002a0c <kstrncmp>
40007164: f000223b     	adrp	x27, 0x4044e000 <bpb>
40007168: 9100437b     	add	x27, x27, #0x10
4000716c: 350006a0     	cbnz	w0, 0x40007240 <fat16_write_file+0x1e8>
40007170: 39406ea8     	ldrb	w8, [x21, #0x1b]
40007174: 39406aa9     	ldrb	w9, [x21, #0x1a]
40007178: 529ffeaa     	mov	w10, #0xfff5            // =65525
4000717c: 2a082128     	orr	w8, w9, w8, lsl #8
40007180: 51000909     	sub	w9, w8, #0x2
40007184: 6b0a013f     	cmp	w9, w10
40007188: 540005c8     	b.hi	0x40007240 <fat16_write_file+0x1e8>
4000718c: 910863f6     	add	x22, sp, #0x218
40007190: 529ffed7     	mov	w23, #0xfff6            // =65526
40007194: 14000005     	b	0x400071a8 <fat16_write_file+0x150>
40007198: 2a182328     	orr	w8, w25, w24, lsl #8
4000719c: 51000909     	sub	w9, w8, #0x2
400071a0: 6b17013f     	cmp	w9, w23
400071a4: 540004e2     	b.hs	0x40007240 <fat16_write_file+0x1e8>
400071a8: f0002239     	adrp	x25, 0x4044e000 <bpb>
400071ac: 53087d15     	lsr	w21, w8, #8
400071b0: 910863e1     	add	x1, sp, #0x218
400071b4: b9404329     	ldr	w9, [x25, #0x40]
400071b8: d37f1d18     	ubfiz	x24, x8, #1, #8
400071bc: 0b150120     	add	w0, w9, w21
400071c0: 97fffa24     	bl	0x40005a50 <virtio_blk_read_sector>
400071c4: b9404328     	ldr	w8, [x25, #0x40]
400071c8: 8b1802da     	add	x26, x22, x24
400071cc: 910863e1     	add	x1, sp, #0x218
400071d0: 39400758     	ldrb	w24, [x26, #0x1]
400071d4: 39400359     	ldrb	w25, [x26]
400071d8: 0b150115     	add	w21, w8, w21
400071dc: aa1503e0     	mov	x0, x21
400071e0: 97fffa1c     	bl	0x40005a50 <virtio_blk_read_sector>
400071e4: 910863e1     	add	x1, sp, #0x218
400071e8: aa1503e0     	mov	x0, x21
400071ec: 3900075f     	strb	wzr, [x26, #0x1]
400071f0: 3900035f     	strb	wzr, [x26]
400071f4: 97fffab9     	bl	0x40005cd8 <virtio_blk_write_sector>
400071f8: f0002228     	adrp	x8, 0x4044e000 <bpb>
400071fc: 39404108     	ldrb	w8, [x8, #0x10]
40007200: 7100091f     	cmp	w8, #0x2
40007204: 54fffca3     	b.lo	0x40007198 <fat16_write_file+0x140>
40007208: 5280003a     	mov	w26, #0x1               // =1
4000720c: 39401f68     	ldrb	w8, [x27, #0x7]
40007210: 39401b69     	ldrb	w9, [x27, #0x6]
40007214: 910863e1     	add	x1, sp, #0x218
40007218: 2a082128     	orr	w8, w9, w8, lsl #8
4000721c: 1b085740     	madd	w0, w26, w8, w21
40007220: 97fffaae     	bl	0x40005cd8 <virtio_blk_write_sector>
40007224: 39400368     	ldrb	w8, [x27]
40007228: 1100075a     	add	w26, w26, #0x1
4000722c: 6b08035f     	cmp	w26, w8
40007230: 54fffee3     	b.lo	0x4000720c <fat16_write_file+0x1b4>
40007234: 17ffffd9     	b	0x40007198 <fat16_write_file+0x140>
40007238: 12800013     	mov	w19, #-0x1              // =-1
4000723c: 14000131     	b	0x40007700 <fat16_write_file+0x6a8>
40007240: 2a1f03f6     	mov	w22, wzr
40007244: 2a1f03f5     	mov	w21, wzr
40007248: aa1f03fc     	mov	x28, xzr
4000724c: f000223a     	adrp	x26, 0x4044e000 <bpb>
40007250: 52804019     	mov	w25, #0x200             // =512
40007254: 14000003     	b	0x40007260 <fat16_write_file+0x208>
40007258: b9400bf6     	ldr	w22, [sp, #0x8]
4000725c: b4000a13     	cbz	x19, 0x4000739c <fat16_write_file+0x344>
40007260: 72003edf     	tst	w22, #0xffff
40007264: 2a1503f8     	mov	w24, w21
40007268: fa400a60     	ccmp	x19, #0x0, #0x0, eq
4000726c: 1a9f17e8     	cset	w8, eq
40007270: eb13039f     	cmp	x28, x19
40007274: 54000043     	b.lo	0x4000727c <fat16_write_file+0x224>
40007278: 34000928     	cbz	w8, 0x4000739c <fat16_write_file+0x344>
4000727c: 97ffff2b     	bl	0x40006f28 <fat16_allocate_cluster>
40007280: 72003c17     	ands	w23, w0, #0xffff
40007284: 540020e0     	b.eq	0x400076a0 <fat16_write_file+0x648>
40007288: 72003edf     	tst	w22, #0xffff
4000728c: 2a0003f5     	mov	w21, w0
40007290: 1a960016     	csel	w22, w0, w22, eq
40007294: 72003f1f     	tst	w24, #0xffff
40007298: b9000bf6     	str	w22, [sp, #0x8]
4000729c: 54000400     	b.eq	0x4000731c <fat16_write_file+0x2c4>
400072a0: f0002228     	adrp	x8, 0x4044e000 <bpb>
400072a4: 12181f09     	and	w9, w24, #0xff00
400072a8: 910863e1     	add	x1, sp, #0x218
400072ac: b9404108     	ldr	w8, [x8, #0x40]
400072b0: d37f1f18     	ubfiz	x24, x24, #1, #8
400072b4: 0b492116     	add	w22, w8, w9, lsr #8
400072b8: aa1603e0     	mov	x0, x22
400072bc: 97fff9e5     	bl	0x40005a50 <virtio_blk_read_sector>
400072c0: 53087ea8     	lsr	w8, w21, #8
400072c4: 910863e9     	add	x9, sp, #0x218
400072c8: 910863e1     	add	x1, sp, #0x218
400072cc: 8b180129     	add	x9, x9, x24
400072d0: aa1603e0     	mov	x0, x22
400072d4: 39000528     	strb	w8, [x9, #0x1]
400072d8: 39000135     	strb	w21, [x9]
400072dc: 97fffa7f     	bl	0x40005cd8 <virtio_blk_write_sector>
400072e0: f0002228     	adrp	x8, 0x4044e000 <bpb>
400072e4: 39404108     	ldrb	w8, [x8, #0x10]
400072e8: 7100091f     	cmp	w8, #0x2
400072ec: 54000183     	b.lo	0x4000731c <fat16_write_file+0x2c4>
400072f0: 52800038     	mov	w24, #0x1               // =1
400072f4: 39401f68     	ldrb	w8, [x27, #0x7]
400072f8: 39401b69     	ldrb	w9, [x27, #0x6]
400072fc: 910863e1     	add	x1, sp, #0x218
40007300: 2a082128     	orr	w8, w9, w8, lsl #8
40007304: 1b085b00     	madd	w0, w24, w8, w22
40007308: 97fffa74     	bl	0x40005cd8 <virtio_blk_write_sector>
4000730c: 39400368     	ldrb	w8, [x27]
40007310: 11000718     	add	w24, w24, #0x1
40007314: 6b08031f     	cmp	w24, w8
40007318: 54fffee3     	b.lo	0x400072f4 <fat16_write_file+0x29c>
4000731c: 39403748     	ldrb	w8, [x26, #0xd]
40007320: 34fff9c8     	cbz	w8, 0x40007258 <fat16_write_file+0x200>
40007324: 51000ae9     	sub	w9, w23, #0x2
40007328: 52800038     	mov	w24, #0x1               // =1
4000732c: 1b087d28     	mul	w8, w9, w8
40007330: f0002229     	adrp	x9, 0x4044e000 <bpb>
40007334: b9404d29     	ldr	w9, [x9, #0x4c]
40007338: 0b080137     	add	w23, w9, w8
4000733c: 91080388     	add	x8, x28, #0x200
40007340: cb1c0269     	sub	x9, x19, x28
40007344: 910033e0     	add	x0, sp, #0xc
40007348: eb13011f     	cmp	x8, x19
4000734c: 2a1f03e1     	mov	w1, wzr
40007350: 52804002     	mov	w2, #0x200              // =512
40007354: 9a998136     	csel	x22, x9, x25, hi
40007358: 97ffede9     	bl	0x40002afc <memset>
4000735c: 910033e0     	add	x0, sp, #0xc
40007360: 8b1c0281     	add	x1, x20, x28
40007364: aa1603e2     	mov	x2, x22
40007368: 97ffedfb     	bl	0x40002b54 <memcpy>
4000736c: 2a1703e0     	mov	w0, w23
40007370: 910033e1     	add	x1, sp, #0xc
40007374: 97fffa59     	bl	0x40005cd8 <virtio_blk_write_sector>
40007378: 8b1c02dc     	add	x28, x22, x28
4000737c: eb13039f     	cmp	x28, x19
40007380: 54fff6c2     	b.hs	0x40007258 <fat16_write_file+0x200>
40007384: 39403748     	ldrb	w8, [x26, #0xd]
40007388: 110006f7     	add	w23, w23, #0x1
4000738c: eb08031f     	cmp	x24, x8
40007390: 91000718     	add	x24, x24, #0x1
40007394: 54fffd43     	b.lo	0x4000733c <fat16_write_file+0x2e4>
40007398: 17ffffb0     	b	0x40007258 <fat16_write_file+0x200>
4000739c: b94007e8     	ldr	w8, [sp, #0x4]
400073a0: 910033e1     	add	x1, sp, #0xc
400073a4: 910033f5     	add	x21, sp, #0xc
400073a8: 2a0803f4     	mov	w20, w8
400073ac: aa1403e0     	mov	x0, x20
400073b0: 97fff9a8     	bl	0x40005a50 <virtio_blk_read_sector>
400073b4: 910033e0     	add	x0, sp, #0xc
400073b8: 910837e1     	add	x1, sp, #0x20d
400073bc: 52800162     	mov	w2, #0xb                // =11
400073c0: 97ffed93     	bl	0x40002a0c <kstrncmp>
400073c4: 34001740     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
400073c8: 394033e8     	ldrb	w8, [sp, #0xc]
400073cc: 910033f5     	add	x21, sp, #0xc
400073d0: 7103951f     	cmp	w8, #0xe5
400073d4: 540016c0     	b.eq	0x400076ac <fat16_write_file+0x654>
400073d8: 340016a8     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
400073dc: 910033e8     	add	x8, sp, #0xc
400073e0: 910837e1     	add	x1, sp, #0x20d
400073e4: 52800162     	mov	w2, #0xb                // =11
400073e8: 91008115     	add	x21, x8, #0x20
400073ec: aa1503e0     	mov	x0, x21
400073f0: 97ffed87     	bl	0x40002a0c <kstrncmp>
400073f4: 340015c0     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
400073f8: 3940b3e8     	ldrb	w8, [sp, #0x2c]
400073fc: 34001588     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
40007400: 7103951f     	cmp	w8, #0xe5
40007404: 54001540     	b.eq	0x400076ac <fat16_write_file+0x654>
40007408: 910033e8     	add	x8, sp, #0xc
4000740c: 910837e1     	add	x1, sp, #0x20d
40007410: 52800162     	mov	w2, #0xb                // =11
40007414: 91010115     	add	x21, x8, #0x40
40007418: aa1503e0     	mov	x0, x21
4000741c: 97ffed7c     	bl	0x40002a0c <kstrncmp>
40007420: 34001460     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
40007424: 394133e8     	ldrb	w8, [sp, #0x4c]
40007428: 34001428     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
4000742c: 7103951f     	cmp	w8, #0xe5
40007430: 540013e0     	b.eq	0x400076ac <fat16_write_file+0x654>
40007434: 910033e8     	add	x8, sp, #0xc
40007438: 910837e1     	add	x1, sp, #0x20d
4000743c: 52800162     	mov	w2, #0xb                // =11
40007440: 91018115     	add	x21, x8, #0x60
40007444: aa1503e0     	mov	x0, x21
40007448: 97ffed71     	bl	0x40002a0c <kstrncmp>
4000744c: 34001300     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
40007450: 3941b3e8     	ldrb	w8, [sp, #0x6c]
40007454: 340012c8     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
40007458: 7103951f     	cmp	w8, #0xe5
4000745c: 54001280     	b.eq	0x400076ac <fat16_write_file+0x654>
40007460: 910033e8     	add	x8, sp, #0xc
40007464: 910837e1     	add	x1, sp, #0x20d
40007468: 52800162     	mov	w2, #0xb                // =11
4000746c: 91020115     	add	x21, x8, #0x80
40007470: aa1503e0     	mov	x0, x21
40007474: 97ffed66     	bl	0x40002a0c <kstrncmp>
40007478: 340011a0     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
4000747c: 394233e8     	ldrb	w8, [sp, #0x8c]
40007480: 34001168     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
40007484: 7103951f     	cmp	w8, #0xe5
40007488: 54001120     	b.eq	0x400076ac <fat16_write_file+0x654>
4000748c: 910033e8     	add	x8, sp, #0xc
40007490: 910837e1     	add	x1, sp, #0x20d
40007494: 52800162     	mov	w2, #0xb                // =11
40007498: 91028115     	add	x21, x8, #0xa0
4000749c: aa1503e0     	mov	x0, x21
400074a0: 97ffed5b     	bl	0x40002a0c <kstrncmp>
400074a4: 34001040     	cbz	w0, 0x400076ac <fat16_write_file+0x654>
400074a8: 3942b3e8     	ldrb	w8, [sp, #0xac]
400074ac: 34001008     	cbz	w8, 0x400076ac <fat16_write_file+0x654>
400074b0: 7103951f     	cmp	w8, #0xe5
400074b4: 54000fc0     	b.eq	0x400076ac <fat16_write_file+0x654>
400074b8: 910033e8     	add	x8, sp, #0xc
400074bc: 910837e1     	add	x1, sp, #0x20d
400074c0: 52800162     	mov	w2, #0xb                // =11
400074c4: 91030115     	add	x21, x8, #0xc0
400074c8: 2a1603f7     	mov	w23, w22
400074cc: aa1503e0     	mov	x0, x21
400074d0: 97ffed4f     	bl	0x40002a0c <kstrncmp>
400074d4: 34000ea0     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
400074d8: 394333e8     	ldrb	w8, [sp, #0xcc]
400074dc: 34000e68     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
400074e0: 7103951f     	cmp	w8, #0xe5
400074e4: 2a1703f6     	mov	w22, w23
400074e8: 54000e20     	b.eq	0x400076ac <fat16_write_file+0x654>
400074ec: 910033e8     	add	x8, sp, #0xc
400074f0: 910837e1     	add	x1, sp, #0x20d
400074f4: 52800162     	mov	w2, #0xb                // =11
400074f8: 91038115     	add	x21, x8, #0xe0
400074fc: aa1503e0     	mov	x0, x21
40007500: 97ffed43     	bl	0x40002a0c <kstrncmp>
40007504: 34000d20     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007508: 3943b3e8     	ldrb	w8, [sp, #0xec]
4000750c: 34000ce8     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007510: 7103951f     	cmp	w8, #0xe5
40007514: 2a1703f6     	mov	w22, w23
40007518: 54000ca0     	b.eq	0x400076ac <fat16_write_file+0x654>
4000751c: 910033e8     	add	x8, sp, #0xc
40007520: 910837e1     	add	x1, sp, #0x20d
40007524: 52800162     	mov	w2, #0xb                // =11
40007528: 91040115     	add	x21, x8, #0x100
4000752c: aa1503e0     	mov	x0, x21
40007530: 97ffed37     	bl	0x40002a0c <kstrncmp>
40007534: 34000ba0     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007538: 394433e8     	ldrb	w8, [sp, #0x10c]
4000753c: 34000b68     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007540: 7103951f     	cmp	w8, #0xe5
40007544: 2a1703f6     	mov	w22, w23
40007548: 54000b20     	b.eq	0x400076ac <fat16_write_file+0x654>
4000754c: 910033e8     	add	x8, sp, #0xc
40007550: 910837e1     	add	x1, sp, #0x20d
40007554: 52800162     	mov	w2, #0xb                // =11
40007558: 91048115     	add	x21, x8, #0x120
4000755c: aa1503e0     	mov	x0, x21
40007560: 97ffed2b     	bl	0x40002a0c <kstrncmp>
40007564: 34000a20     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007568: 3944b3e8     	ldrb	w8, [sp, #0x12c]
4000756c: 340009e8     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007570: 7103951f     	cmp	w8, #0xe5
40007574: 2a1703f6     	mov	w22, w23
40007578: 540009a0     	b.eq	0x400076ac <fat16_write_file+0x654>
4000757c: 910033e8     	add	x8, sp, #0xc
40007580: 910837e1     	add	x1, sp, #0x20d
40007584: 52800162     	mov	w2, #0xb                // =11
40007588: 91050115     	add	x21, x8, #0x140
4000758c: aa1503e0     	mov	x0, x21
40007590: 97ffed1f     	bl	0x40002a0c <kstrncmp>
40007594: 340008a0     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007598: 394533e8     	ldrb	w8, [sp, #0x14c]
4000759c: 34000868     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
400075a0: 7103951f     	cmp	w8, #0xe5
400075a4: 2a1703f6     	mov	w22, w23
400075a8: 54000820     	b.eq	0x400076ac <fat16_write_file+0x654>
400075ac: 910033e8     	add	x8, sp, #0xc
400075b0: 910837e1     	add	x1, sp, #0x20d
400075b4: 52800162     	mov	w2, #0xb                // =11
400075b8: 91058115     	add	x21, x8, #0x160
400075bc: aa1503e0     	mov	x0, x21
400075c0: 97ffed13     	bl	0x40002a0c <kstrncmp>
400075c4: 34000720     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
400075c8: 3945b3e8     	ldrb	w8, [sp, #0x16c]
400075cc: 340006e8     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
400075d0: 7103951f     	cmp	w8, #0xe5
400075d4: 2a1703f6     	mov	w22, w23
400075d8: 540006a0     	b.eq	0x400076ac <fat16_write_file+0x654>
400075dc: 910033e8     	add	x8, sp, #0xc
400075e0: 910837e1     	add	x1, sp, #0x20d
400075e4: 52800162     	mov	w2, #0xb                // =11
400075e8: 91060115     	add	x21, x8, #0x180
400075ec: aa1503e0     	mov	x0, x21
400075f0: 97ffed07     	bl	0x40002a0c <kstrncmp>
400075f4: 340005a0     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
400075f8: 394633e8     	ldrb	w8, [sp, #0x18c]
400075fc: 34000568     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007600: 7103951f     	cmp	w8, #0xe5
40007604: 2a1703f6     	mov	w22, w23
40007608: 54000520     	b.eq	0x400076ac <fat16_write_file+0x654>
4000760c: 910033e8     	add	x8, sp, #0xc
40007610: 910837e1     	add	x1, sp, #0x20d
40007614: 52800162     	mov	w2, #0xb                // =11
40007618: 91068115     	add	x21, x8, #0x1a0
4000761c: aa1503e0     	mov	x0, x21
40007620: 97ffecfb     	bl	0x40002a0c <kstrncmp>
40007624: 34000420     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007628: 3946b3e8     	ldrb	w8, [sp, #0x1ac]
4000762c: 340003e8     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007630: 7103951f     	cmp	w8, #0xe5
40007634: 2a1703f6     	mov	w22, w23
40007638: 540003a0     	b.eq	0x400076ac <fat16_write_file+0x654>
4000763c: 910033e8     	add	x8, sp, #0xc
40007640: 910837e1     	add	x1, sp, #0x20d
40007644: 52800162     	mov	w2, #0xb                // =11
40007648: 91070115     	add	x21, x8, #0x1c0
4000764c: aa1503e0     	mov	x0, x21
40007650: 97ffecef     	bl	0x40002a0c <kstrncmp>
40007654: 340002a0     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007658: 394733e8     	ldrb	w8, [sp, #0x1cc]
4000765c: 34000268     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007660: 7103951f     	cmp	w8, #0xe5
40007664: 2a1703f6     	mov	w22, w23
40007668: 54000220     	b.eq	0x400076ac <fat16_write_file+0x654>
4000766c: 910033e8     	add	x8, sp, #0xc
40007670: 910837e1     	add	x1, sp, #0x20d
40007674: 52800162     	mov	w2, #0xb                // =11
40007678: 91078115     	add	x21, x8, #0x1e0
4000767c: aa1503e0     	mov	x0, x21
40007680: 97ffece3     	bl	0x40002a0c <kstrncmp>
40007684: 34000120     	cbz	w0, 0x400076a8 <fat16_write_file+0x650>
40007688: 3947b3e8     	ldrb	w8, [sp, #0x1ec]
4000768c: 340000e8     	cbz	w8, 0x400076a8 <fat16_write_file+0x650>
40007690: 7103951f     	cmp	w8, #0xe5
40007694: 2a1703f6     	mov	w22, w23
40007698: 540000a0     	b.eq	0x400076ac <fat16_write_file+0x654>
4000769c: 14000019     	b	0x40007700 <fat16_write_file+0x6a8>
400076a0: 12800033     	mov	w19, #-0x2              // =-2
400076a4: 14000017     	b	0x40007700 <fat16_write_file+0x6a8>
400076a8: 2a1703f6     	mov	w22, w23
400076ac: 910837e1     	add	x1, sp, #0x20d
400076b0: aa1503e0     	mov	x0, x21
400076b4: 52800162     	mov	w2, #0xb                // =11
400076b8: 97ffecec     	bl	0x40002a68 <kstrncpy>
400076bc: 52800408     	mov	w8, #0x20               // =32
400076c0: 3801ceb3     	strb	w19, [x21, #0x1c]!
400076c4: 53087ec9     	lsr	w9, w22, #8
400076c8: 381ef2a8     	sturb	w8, [x21, #-0x11]
400076cc: 53187e68     	lsr	w8, w19, #24
400076d0: 910033e1     	add	x1, sp, #0xc
400076d4: aa1403e0     	mov	x0, x20
400076d8: 381fe2b6     	sturb	w22, [x21, #-0x2]
400076dc: 381ff2a9     	sturb	w9, [x21, #-0x1]
400076e0: 53107e69     	lsr	w9, w19, #16
400076e4: 39000ea8     	strb	w8, [x21, #0x3]
400076e8: 53087e68     	lsr	w8, w19, #8
400076ec: 381f92bf     	sturb	wzr, [x21, #-0x7]
400076f0: 381f82bf     	sturb	wzr, [x21, #-0x8]
400076f4: 39000aa9     	strb	w9, [x21, #0x2]
400076f8: 390006a8     	strb	w8, [x21, #0x1]
400076fc: 97fff977     	bl	0x40005cd8 <virtio_blk_write_sector>
40007700: 2a1303e0     	mov	w0, w19
40007704: 911083ff     	add	sp, sp, #0x420
40007708: a9454ff4     	ldp	x20, x19, [sp, #0x50]
4000770c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40007710: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40007714: a94267fa     	ldp	x26, x25, [sp, #0x20]
40007718: a9416ffc     	ldp	x28, x27, [sp, #0x10]
4000771c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40007720: d65f03c0     	ret

0000000040007724 <fat16_populate_vfs>:
40007724: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40007728: f9000bfc     	str	x28, [sp, #0x10]
4000772c: 910003fd     	mov	x29, sp
40007730: a90267fa     	stp	x26, x25, [sp, #0x20]
40007734: a9035ff8     	stp	x24, x23, [sp, #0x30]
40007738: a90457f6     	stp	x22, x21, [sp, #0x40]
4000773c: a9054ff4     	stp	x20, x19, [sp, #0x50]
40007740: d11843ff     	sub	sp, sp, #0x610
40007744: f0002233     	adrp	x19, 0x4044e000 <bpb>
40007748: b9404a68     	ldr	w8, [x19, #0x48]
4000774c: 34000d68     	cbz	w8, 0x400078f8 <fat16_populate_vfs+0x1d4>
40007750: 911043e8     	add	x8, sp, #0x410
40007754: 2a1f03f4     	mov	w20, wzr
40007758: f0002236     	adrp	x22, 0x4044e000 <bpb>
4000775c: 91001515     	add	x21, x8, #0x5
40007760: 911003f7     	add	x23, sp, #0x400
40007764: 528005d8     	mov	w24, #0x2e              // =46
40007768: 14000005     	b	0x4000777c <fat16_populate_vfs+0x58>
4000776c: b9404a68     	ldr	w8, [x19, #0x48]
40007770: 11000694     	add	w20, w20, #0x1
40007774: 6b08029f     	cmp	w20, w8
40007778: 54000c02     	b.hs	0x400078f8 <fat16_populate_vfs+0x1d4>
4000777c: b94046c8     	ldr	w8, [x22, #0x44]
40007780: 911043e1     	add	x1, sp, #0x410
40007784: 0b140100     	add	w0, w8, w20
40007788: 97fff8b2     	bl	0x40005a50 <virtio_blk_read_sector>
4000778c: aa1503f9     	mov	x25, x21
40007790: 5280021a     	mov	w26, #0x10              // =16
40007794: 14000004     	b	0x400077a4 <fat16_populate_vfs+0x80>
40007798: f100075a     	subs	x26, x26, #0x1
4000779c: 91008339     	add	x25, x25, #0x20
400077a0: 54fffe60     	b.eq	0x4000776c <fat16_populate_vfs+0x48>
400077a4: 385fb328     	ldurb	w8, [x25, #-0x5]
400077a8: 7103951f     	cmp	w8, #0xe5
400077ac: 54ffff60     	b.eq	0x40007798 <fat16_populate_vfs+0x74>
400077b0: 34000a48     	cbz	w8, 0x400078f8 <fat16_populate_vfs+0x1d4>
400077b4: 39401b29     	ldrb	w9, [x25, #0x6]
400077b8: 7200113f     	tst	w9, #0x1f
400077bc: 54fffee1     	b.ne	0x40007798 <fat16_populate_vfs+0x74>
400077c0: 7100811f     	cmp	w8, #0x20
400077c4: 54000061     	b.ne	0x400077d0 <fat16_populate_vfs+0xac>
400077c8: aa1f03e8     	mov	x8, xzr
400077cc: 14000003     	b	0x400077d8 <fat16_populate_vfs+0xb4>
400077d0: 391003e8     	strb	w8, [sp, #0x400]
400077d4: 52800028     	mov	w8, #0x1                // =1
400077d8: 385fc329     	ldurb	w9, [x25, #-0x4]
400077dc: 7100813f     	cmp	w9, #0x20
400077e0: 54000080     	b.eq	0x400077f0 <fat16_populate_vfs+0xcc>
400077e4: aa0802ea     	orr	x10, x23, x8
400077e8: 91000508     	add	x8, x8, #0x1
400077ec: 39000149     	strb	w9, [x10]
400077f0: 385fd329     	ldurb	w9, [x25, #-0x3]
400077f4: 7100813f     	cmp	w9, #0x20
400077f8: 54000080     	b.eq	0x40007808 <fat16_populate_vfs+0xe4>
400077fc: aa0802ea     	orr	x10, x23, x8
40007800: 91000508     	add	x8, x8, #0x1
40007804: 39000149     	strb	w9, [x10]
40007808: 385fe329     	ldurb	w9, [x25, #-0x2]
4000780c: 7100813f     	cmp	w9, #0x20
40007810: 54000080     	b.eq	0x40007820 <fat16_populate_vfs+0xfc>
40007814: 9100050a     	add	x10, x8, #0x1
40007818: 38286ae9     	strb	w9, [x23, x8]
4000781c: aa0a03e8     	mov	x8, x10
40007820: 385ff329     	ldurb	w9, [x25, #-0x1]
40007824: 7100813f     	cmp	w9, #0x20
40007828: 54000080     	b.eq	0x40007838 <fat16_populate_vfs+0x114>
4000782c: 9100050a     	add	x10, x8, #0x1
40007830: 38286ae9     	strb	w9, [x23, x8]
40007834: aa0a03e8     	mov	x8, x10
40007838: 39400329     	ldrb	w9, [x25]
4000783c: 7100813f     	cmp	w9, #0x20
40007840: 54000080     	b.eq	0x40007850 <fat16_populate_vfs+0x12c>
40007844: 9100050a     	add	x10, x8, #0x1
40007848: 38286ae9     	strb	w9, [x23, x8]
4000784c: aa0a03e8     	mov	x8, x10
40007850: 39400729     	ldrb	w9, [x25, #0x1]
40007854: 7100813f     	cmp	w9, #0x20
40007858: 54000080     	b.eq	0x40007868 <fat16_populate_vfs+0x144>
4000785c: 9100050a     	add	x10, x8, #0x1
40007860: 38286ae9     	strb	w9, [x23, x8]
40007864: aa0a03e8     	mov	x8, x10
40007868: 39400b29     	ldrb	w9, [x25, #0x2]
4000786c: 7100813f     	cmp	w9, #0x20
40007870: 54000080     	b.eq	0x40007880 <fat16_populate_vfs+0x15c>
40007874: 9100050a     	add	x10, x8, #0x1
40007878: 38286ae9     	strb	w9, [x23, x8]
4000787c: aa0a03e8     	mov	x8, x10
40007880: 39400f2a     	ldrb	w10, [x25, #0x3]
40007884: 7100815f     	cmp	w10, #0x20
40007888: 54000240     	b.eq	0x400078d0 <fat16_populate_vfs+0x1ac>
4000788c: 3940132b     	ldrb	w11, [x25, #0x4]
40007890: 8b0802ec     	add	x12, x23, x8
40007894: 91000909     	add	x9, x8, #0x2
40007898: 39000198     	strb	w24, [x12]
4000789c: 7100817f     	cmp	w11, #0x20
400078a0: 3900058a     	strb	w10, [x12, #0x1]
400078a4: 54000080     	b.eq	0x400078b4 <fat16_populate_vfs+0x190>
400078a8: 91000d08     	add	x8, x8, #0x3
400078ac: 38296aeb     	strb	w11, [x23, x9]
400078b0: aa0803e9     	mov	x9, x8
400078b4: 3940172a     	ldrb	w10, [x25, #0x5]
400078b8: 7100815f     	cmp	w10, #0x20
400078bc: 54000061     	b.ne	0x400078c8 <fat16_populate_vfs+0x1a4>
400078c0: aa0903e8     	mov	x8, x9
400078c4: 14000003     	b	0x400078d0 <fat16_populate_vfs+0x1ac>
400078c8: 91000528     	add	x8, x9, #0x1
400078cc: 38296aea     	strb	w10, [x23, x9]
400078d0: 911003e0     	add	x0, sp, #0x400
400078d4: 910003e1     	mov	x1, sp
400078d8: 52808002     	mov	w2, #0x400              // =1024
400078dc: 38286aff     	strb	wzr, [x23, x8]
400078e0: 97fffc90     	bl	0x40006b20 <fat16_read_file>
400078e4: 37fff5a0     	tbnz	w0, #0x1f, 0x40007798 <fat16_populate_vfs+0x74>
400078e8: 911003e0     	add	x0, sp, #0x400
400078ec: 910003e1     	mov	x1, sp
400078f0: 97fff58f     	bl	0x40004f2c <vfs_touch>
400078f4: 17ffffa9     	b	0x40007798 <fat16_populate_vfs+0x74>
400078f8: 911843ff     	add	sp, sp, #0x610
400078fc: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40007900: f9400bfc     	ldr	x28, [sp, #0x10]
40007904: a94457f6     	ldp	x22, x21, [sp, #0x40]
40007908: a9435ff8     	ldp	x24, x23, [sp, #0x30]
4000790c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40007910: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40007914: d65f03c0     	ret
		...

0000000040008000 <exception_vector_table>:
40008000: 140001e1     	b	0x40008784 <handle_sync_invalid>
40008004: d503201f     	nop
40008008: d503201f     	nop
4000800c: d503201f     	nop
40008010: d503201f     	nop
40008014: d503201f     	nop
40008018: d503201f     	nop
4000801c: d503201f     	nop
40008020: d503201f     	nop
40008024: d503201f     	nop
40008028: d503201f     	nop
4000802c: d503201f     	nop
40008030: d503201f     	nop
40008034: d503201f     	nop
40008038: d503201f     	nop
4000803c: d503201f     	nop
40008040: d503201f     	nop
40008044: d503201f     	nop
40008048: d503201f     	nop
4000804c: d503201f     	nop
40008050: d503201f     	nop
40008054: d503201f     	nop
40008058: d503201f     	nop
4000805c: d503201f     	nop
40008060: d503201f     	nop
40008064: d503201f     	nop
40008068: d503201f     	nop
4000806c: d503201f     	nop
40008070: d503201f     	nop
40008074: d503201f     	nop
40008078: d503201f     	nop
4000807c: d503201f     	nop

0000000040008080 <curr_el_sp0_irq>:
40008080: 140001ed     	b	0x40008834 <handle_irq_invalid>
40008084: d503201f     	nop
40008088: d503201f     	nop
4000808c: d503201f     	nop
40008090: d503201f     	nop
40008094: d503201f     	nop
40008098: d503201f     	nop
4000809c: d503201f     	nop
400080a0: d503201f     	nop
400080a4: d503201f     	nop
400080a8: d503201f     	nop
400080ac: d503201f     	nop
400080b0: d503201f     	nop
400080b4: d503201f     	nop
400080b8: d503201f     	nop
400080bc: d503201f     	nop
400080c0: d503201f     	nop
400080c4: d503201f     	nop
400080c8: d503201f     	nop
400080cc: d503201f     	nop
400080d0: d503201f     	nop
400080d4: d503201f     	nop
400080d8: d503201f     	nop
400080dc: d503201f     	nop
400080e0: d503201f     	nop
400080e4: d503201f     	nop
400080e8: d503201f     	nop
400080ec: d503201f     	nop
400080f0: d503201f     	nop
400080f4: d503201f     	nop
400080f8: d503201f     	nop
400080fc: d503201f     	nop

0000000040008100 <curr_el_sp0_fiq>:
40008100: 140001f8     	b	0x400088e0 <handle_fiq_invalid>
40008104: d503201f     	nop
40008108: d503201f     	nop
4000810c: d503201f     	nop
40008110: d503201f     	nop
40008114: d503201f     	nop
40008118: d503201f     	nop
4000811c: d503201f     	nop
40008120: d503201f     	nop
40008124: d503201f     	nop
40008128: d503201f     	nop
4000812c: d503201f     	nop
40008130: d503201f     	nop
40008134: d503201f     	nop
40008138: d503201f     	nop
4000813c: d503201f     	nop
40008140: d503201f     	nop
40008144: d503201f     	nop
40008148: d503201f     	nop
4000814c: d503201f     	nop
40008150: d503201f     	nop
40008154: d503201f     	nop
40008158: d503201f     	nop
4000815c: d503201f     	nop
40008160: d503201f     	nop
40008164: d503201f     	nop
40008168: d503201f     	nop
4000816c: d503201f     	nop
40008170: d503201f     	nop
40008174: d503201f     	nop
40008178: d503201f     	nop
4000817c: d503201f     	nop

0000000040008180 <curr_el_sp0_serror>:
40008180: 14000203     	b	0x4000898c <handle_serror_invalid>
40008184: d503201f     	nop
40008188: d503201f     	nop
4000818c: d503201f     	nop
40008190: d503201f     	nop
40008194: d503201f     	nop
40008198: d503201f     	nop
4000819c: d503201f     	nop
400081a0: d503201f     	nop
400081a4: d503201f     	nop
400081a8: d503201f     	nop
400081ac: d503201f     	nop
400081b0: d503201f     	nop
400081b4: d503201f     	nop
400081b8: d503201f     	nop
400081bc: d503201f     	nop
400081c0: d503201f     	nop
400081c4: d503201f     	nop
400081c8: d503201f     	nop
400081cc: d503201f     	nop
400081d0: d503201f     	nop
400081d4: d503201f     	nop
400081d8: d503201f     	nop
400081dc: d503201f     	nop
400081e0: d503201f     	nop
400081e4: d503201f     	nop
400081e8: d503201f     	nop
400081ec: d503201f     	nop
400081f0: d503201f     	nop
400081f4: d503201f     	nop
400081f8: d503201f     	nop
400081fc: d503201f     	nop

0000000040008200 <curr_el_spx_sync>:
40008200: 14000210     	b	0x40008a40 <handle_sync_exception_asm>
40008204: d503201f     	nop
40008208: d503201f     	nop
4000820c: d503201f     	nop
40008210: d503201f     	nop
40008214: d503201f     	nop
40008218: d503201f     	nop
4000821c: d503201f     	nop
40008220: d503201f     	nop
40008224: d503201f     	nop
40008228: d503201f     	nop
4000822c: d503201f     	nop
40008230: d503201f     	nop
40008234: d503201f     	nop
40008238: d503201f     	nop
4000823c: d503201f     	nop
40008240: d503201f     	nop
40008244: d503201f     	nop
40008248: d503201f     	nop
4000824c: d503201f     	nop
40008250: d503201f     	nop
40008254: d503201f     	nop
40008258: d503201f     	nop
4000825c: d503201f     	nop
40008260: d503201f     	nop
40008264: d503201f     	nop
40008268: d503201f     	nop
4000826c: d503201f     	nop
40008270: d503201f     	nop
40008274: d503201f     	nop
40008278: d503201f     	nop
4000827c: d503201f     	nop

0000000040008280 <curr_el_spx_irq>:
40008280: 1400021d     	b	0x40008af4 <handle_irq_exception_asm>
40008284: d503201f     	nop
40008288: d503201f     	nop
4000828c: d503201f     	nop
40008290: d503201f     	nop
40008294: d503201f     	nop
40008298: d503201f     	nop
4000829c: d503201f     	nop
400082a0: d503201f     	nop
400082a4: d503201f     	nop
400082a8: d503201f     	nop
400082ac: d503201f     	nop
400082b0: d503201f     	nop
400082b4: d503201f     	nop
400082b8: d503201f     	nop
400082bc: d503201f     	nop
400082c0: d503201f     	nop
400082c4: d503201f     	nop
400082c8: d503201f     	nop
400082cc: d503201f     	nop
400082d0: d503201f     	nop
400082d4: d503201f     	nop
400082d8: d503201f     	nop
400082dc: d503201f     	nop
400082e0: d503201f     	nop
400082e4: d503201f     	nop
400082e8: d503201f     	nop
400082ec: d503201f     	nop
400082f0: d503201f     	nop
400082f4: d503201f     	nop
400082f8: d503201f     	nop
400082fc: d503201f     	nop

0000000040008300 <curr_el_spx_fiq>:
40008300: 14000178     	b	0x400088e0 <handle_fiq_invalid>
40008304: d503201f     	nop
40008308: d503201f     	nop
4000830c: d503201f     	nop
40008310: d503201f     	nop
40008314: d503201f     	nop
40008318: d503201f     	nop
4000831c: d503201f     	nop
40008320: d503201f     	nop
40008324: d503201f     	nop
40008328: d503201f     	nop
4000832c: d503201f     	nop
40008330: d503201f     	nop
40008334: d503201f     	nop
40008338: d503201f     	nop
4000833c: d503201f     	nop
40008340: d503201f     	nop
40008344: d503201f     	nop
40008348: d503201f     	nop
4000834c: d503201f     	nop
40008350: d503201f     	nop
40008354: d503201f     	nop
40008358: d503201f     	nop
4000835c: d503201f     	nop
40008360: d503201f     	nop
40008364: d503201f     	nop
40008368: d503201f     	nop
4000836c: d503201f     	nop
40008370: d503201f     	nop
40008374: d503201f     	nop
40008378: d503201f     	nop
4000837c: d503201f     	nop

0000000040008380 <curr_el_spx_serror>:
40008380: 14000183     	b	0x4000898c <handle_serror_invalid>
40008384: d503201f     	nop
40008388: d503201f     	nop
4000838c: d503201f     	nop
40008390: d503201f     	nop
40008394: d503201f     	nop
40008398: d503201f     	nop
4000839c: d503201f     	nop
400083a0: d503201f     	nop
400083a4: d503201f     	nop
400083a8: d503201f     	nop
400083ac: d503201f     	nop
400083b0: d503201f     	nop
400083b4: d503201f     	nop
400083b8: d503201f     	nop
400083bc: d503201f     	nop
400083c0: d503201f     	nop
400083c4: d503201f     	nop
400083c8: d503201f     	nop
400083cc: d503201f     	nop
400083d0: d503201f     	nop
400083d4: d503201f     	nop
400083d8: d503201f     	nop
400083dc: d503201f     	nop
400083e0: d503201f     	nop
400083e4: d503201f     	nop
400083e8: d503201f     	nop
400083ec: d503201f     	nop
400083f0: d503201f     	nop
400083f4: d503201f     	nop
400083f8: d503201f     	nop
400083fc: d503201f     	nop

0000000040008400 <lower_el_aarch64_sync>:
40008400: 140000e1     	b	0x40008784 <handle_sync_invalid>
40008404: d503201f     	nop
40008408: d503201f     	nop
4000840c: d503201f     	nop
40008410: d503201f     	nop
40008414: d503201f     	nop
40008418: d503201f     	nop
4000841c: d503201f     	nop
40008420: d503201f     	nop
40008424: d503201f     	nop
40008428: d503201f     	nop
4000842c: d503201f     	nop
40008430: d503201f     	nop
40008434: d503201f     	nop
40008438: d503201f     	nop
4000843c: d503201f     	nop
40008440: d503201f     	nop
40008444: d503201f     	nop
40008448: d503201f     	nop
4000844c: d503201f     	nop
40008450: d503201f     	nop
40008454: d503201f     	nop
40008458: d503201f     	nop
4000845c: d503201f     	nop
40008460: d503201f     	nop
40008464: d503201f     	nop
40008468: d503201f     	nop
4000846c: d503201f     	nop
40008470: d503201f     	nop
40008474: d503201f     	nop
40008478: d503201f     	nop
4000847c: d503201f     	nop

0000000040008480 <lower_el_aarch64_irq>:
40008480: 140000ed     	b	0x40008834 <handle_irq_invalid>
40008484: d503201f     	nop
40008488: d503201f     	nop
4000848c: d503201f     	nop
40008490: d503201f     	nop
40008494: d503201f     	nop
40008498: d503201f     	nop
4000849c: d503201f     	nop
400084a0: d503201f     	nop
400084a4: d503201f     	nop
400084a8: d503201f     	nop
400084ac: d503201f     	nop
400084b0: d503201f     	nop
400084b4: d503201f     	nop
400084b8: d503201f     	nop
400084bc: d503201f     	nop
400084c0: d503201f     	nop
400084c4: d503201f     	nop
400084c8: d503201f     	nop
400084cc: d503201f     	nop
400084d0: d503201f     	nop
400084d4: d503201f     	nop
400084d8: d503201f     	nop
400084dc: d503201f     	nop
400084e0: d503201f     	nop
400084e4: d503201f     	nop
400084e8: d503201f     	nop
400084ec: d503201f     	nop
400084f0: d503201f     	nop
400084f4: d503201f     	nop
400084f8: d503201f     	nop
400084fc: d503201f     	nop

0000000040008500 <lower_el_aarch64_fiq>:
40008500: 140000f8     	b	0x400088e0 <handle_fiq_invalid>
40008504: d503201f     	nop
40008508: d503201f     	nop
4000850c: d503201f     	nop
40008510: d503201f     	nop
40008514: d503201f     	nop
40008518: d503201f     	nop
4000851c: d503201f     	nop
40008520: d503201f     	nop
40008524: d503201f     	nop
40008528: d503201f     	nop
4000852c: d503201f     	nop
40008530: d503201f     	nop
40008534: d503201f     	nop
40008538: d503201f     	nop
4000853c: d503201f     	nop
40008540: d503201f     	nop
40008544: d503201f     	nop
40008548: d503201f     	nop
4000854c: d503201f     	nop
40008550: d503201f     	nop
40008554: d503201f     	nop
40008558: d503201f     	nop
4000855c: d503201f     	nop
40008560: d503201f     	nop
40008564: d503201f     	nop
40008568: d503201f     	nop
4000856c: d503201f     	nop
40008570: d503201f     	nop
40008574: d503201f     	nop
40008578: d503201f     	nop
4000857c: d503201f     	nop

0000000040008580 <lower_el_aarch64_serror>:
40008580: 14000103     	b	0x4000898c <handle_serror_invalid>
40008584: d503201f     	nop
40008588: d503201f     	nop
4000858c: d503201f     	nop
40008590: d503201f     	nop
40008594: d503201f     	nop
40008598: d503201f     	nop
4000859c: d503201f     	nop
400085a0: d503201f     	nop
400085a4: d503201f     	nop
400085a8: d503201f     	nop
400085ac: d503201f     	nop
400085b0: d503201f     	nop
400085b4: d503201f     	nop
400085b8: d503201f     	nop
400085bc: d503201f     	nop
400085c0: d503201f     	nop
400085c4: d503201f     	nop
400085c8: d503201f     	nop
400085cc: d503201f     	nop
400085d0: d503201f     	nop
400085d4: d503201f     	nop
400085d8: d503201f     	nop
400085dc: d503201f     	nop
400085e0: d503201f     	nop
400085e4: d503201f     	nop
400085e8: d503201f     	nop
400085ec: d503201f     	nop
400085f0: d503201f     	nop
400085f4: d503201f     	nop
400085f8: d503201f     	nop
400085fc: d503201f     	nop

0000000040008600 <lower_el_aarch32_sync>:
40008600: 14000061     	b	0x40008784 <handle_sync_invalid>
40008604: d503201f     	nop
40008608: d503201f     	nop
4000860c: d503201f     	nop
40008610: d503201f     	nop
40008614: d503201f     	nop
40008618: d503201f     	nop
4000861c: d503201f     	nop
40008620: d503201f     	nop
40008624: d503201f     	nop
40008628: d503201f     	nop
4000862c: d503201f     	nop
40008630: d503201f     	nop
40008634: d503201f     	nop
40008638: d503201f     	nop
4000863c: d503201f     	nop
40008640: d503201f     	nop
40008644: d503201f     	nop
40008648: d503201f     	nop
4000864c: d503201f     	nop
40008650: d503201f     	nop
40008654: d503201f     	nop
40008658: d503201f     	nop
4000865c: d503201f     	nop
40008660: d503201f     	nop
40008664: d503201f     	nop
40008668: d503201f     	nop
4000866c: d503201f     	nop
40008670: d503201f     	nop
40008674: d503201f     	nop
40008678: d503201f     	nop
4000867c: d503201f     	nop

0000000040008680 <lower_el_aarch32_irq>:
40008680: 1400006d     	b	0x40008834 <handle_irq_invalid>
40008684: d503201f     	nop
40008688: d503201f     	nop
4000868c: d503201f     	nop
40008690: d503201f     	nop
40008694: d503201f     	nop
40008698: d503201f     	nop
4000869c: d503201f     	nop
400086a0: d503201f     	nop
400086a4: d503201f     	nop
400086a8: d503201f     	nop
400086ac: d503201f     	nop
400086b0: d503201f     	nop
400086b4: d503201f     	nop
400086b8: d503201f     	nop
400086bc: d503201f     	nop
400086c0: d503201f     	nop
400086c4: d503201f     	nop
400086c8: d503201f     	nop
400086cc: d503201f     	nop
400086d0: d503201f     	nop
400086d4: d503201f     	nop
400086d8: d503201f     	nop
400086dc: d503201f     	nop
400086e0: d503201f     	nop
400086e4: d503201f     	nop
400086e8: d503201f     	nop
400086ec: d503201f     	nop
400086f0: d503201f     	nop
400086f4: d503201f     	nop
400086f8: d503201f     	nop
400086fc: d503201f     	nop

0000000040008700 <lower_el_aarch32_fiq>:
40008700: 14000078     	b	0x400088e0 <handle_fiq_invalid>
40008704: d503201f     	nop
40008708: d503201f     	nop
4000870c: d503201f     	nop
40008710: d503201f     	nop
40008714: d503201f     	nop
40008718: d503201f     	nop
4000871c: d503201f     	nop
40008720: d503201f     	nop
40008724: d503201f     	nop
40008728: d503201f     	nop
4000872c: d503201f     	nop
40008730: d503201f     	nop
40008734: d503201f     	nop
40008738: d503201f     	nop
4000873c: d503201f     	nop
40008740: d503201f     	nop
40008744: d503201f     	nop
40008748: d503201f     	nop
4000874c: d503201f     	nop
40008750: d503201f     	nop
40008754: d503201f     	nop
40008758: d503201f     	nop
4000875c: d503201f     	nop
40008760: d503201f     	nop
40008764: d503201f     	nop
40008768: d503201f     	nop
4000876c: d503201f     	nop
40008770: d503201f     	nop
40008774: d503201f     	nop
40008778: d503201f     	nop
4000877c: d503201f     	nop

0000000040008780 <lower_el_aarch32_serror>:
40008780: 14000083     	b	0x4000898c <handle_serror_invalid>

0000000040008784 <handle_sync_invalid>:
40008784: d10443ff     	sub	sp, sp, #0x110
40008788: a90007e0     	stp	x0, x1, [sp]
4000878c: d5384020     	mrs	x0, ELR_EL1
40008790: d5384001     	mrs	x1, SPSR_EL1
40008794: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008798: a94007e0     	ldp	x0, x1, [sp]
4000879c: a9010fe2     	stp	x2, x3, [sp, #0x10]
400087a0: a90217e4     	stp	x4, x5, [sp, #0x20]
400087a4: a9031fe6     	stp	x6, x7, [sp, #0x30]
400087a8: a90427e8     	stp	x8, x9, [sp, #0x40]
400087ac: a9052fea     	stp	x10, x11, [sp, #0x50]
400087b0: a90637ec     	stp	x12, x13, [sp, #0x60]
400087b4: a9073fee     	stp	x14, x15, [sp, #0x70]
400087b8: a90847f0     	stp	x16, x17, [sp, #0x80]
400087bc: a9094ff2     	stp	x18, x19, [sp, #0x90]
400087c0: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400087c4: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400087c8: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400087cc: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400087d0: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400087d4: f9007bfe     	str	x30, [sp, #0xf0]
400087d8: 910003e0     	mov	x0, sp
400087dc: 97ffde55     	bl	0x40000130 <c_handle_sync_invalid>
400087e0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400087e4: d5184020     	msr	ELR_EL1, x0
400087e8: d5184001     	msr	SPSR_EL1, x1
400087ec: a94007e0     	ldp	x0, x1, [sp]
400087f0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400087f4: a94217e4     	ldp	x4, x5, [sp, #0x20]
400087f8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400087fc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008800: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008804: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008808: a9473fee     	ldp	x14, x15, [sp, #0x70]
4000880c: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008810: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008814: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008818: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
4000881c: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008820: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008824: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008828: f9407bfe     	ldr	x30, [sp, #0xf0]
4000882c: 910443ff     	add	sp, sp, #0x110
40008830: d69f03e0     	eret

0000000040008834 <handle_irq_invalid>:
40008834: d10443ff     	sub	sp, sp, #0x110
40008838: a90007e0     	stp	x0, x1, [sp]
4000883c: d5384020     	mrs	x0, ELR_EL1
40008840: d5384001     	mrs	x1, SPSR_EL1
40008844: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008848: a94007e0     	ldp	x0, x1, [sp]
4000884c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40008850: a90217e4     	stp	x4, x5, [sp, #0x20]
40008854: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008858: a90427e8     	stp	x8, x9, [sp, #0x40]
4000885c: a9052fea     	stp	x10, x11, [sp, #0x50]
40008860: a90637ec     	stp	x12, x13, [sp, #0x60]
40008864: a9073fee     	stp	x14, x15, [sp, #0x70]
40008868: a90847f0     	stp	x16, x17, [sp, #0x80]
4000886c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40008870: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008874: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008878: a90c67f8     	stp	x24, x25, [sp, #0xc0]
4000887c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40008880: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008884: f9007bfe     	str	x30, [sp, #0xf0]
40008888: 97ffde38     	bl	0x40000168 <c_handle_irq_invalid>
4000888c: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40008890: d5184020     	msr	ELR_EL1, x0
40008894: d5184001     	msr	SPSR_EL1, x1
40008898: a94007e0     	ldp	x0, x1, [sp]
4000889c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400088a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
400088a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
400088a8: a94427e8     	ldp	x8, x9, [sp, #0x40]
400088ac: a9452fea     	ldp	x10, x11, [sp, #0x50]
400088b0: a94637ec     	ldp	x12, x13, [sp, #0x60]
400088b4: a9473fee     	ldp	x14, x15, [sp, #0x70]
400088b8: a94847f0     	ldp	x16, x17, [sp, #0x80]
400088bc: a9494ff2     	ldp	x18, x19, [sp, #0x90]
400088c0: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
400088c4: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
400088c8: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
400088cc: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
400088d0: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
400088d4: f9407bfe     	ldr	x30, [sp, #0xf0]
400088d8: 910443ff     	add	sp, sp, #0x110
400088dc: d69f03e0     	eret

00000000400088e0 <handle_fiq_invalid>:
400088e0: d10443ff     	sub	sp, sp, #0x110
400088e4: a90007e0     	stp	x0, x1, [sp]
400088e8: d5384020     	mrs	x0, ELR_EL1
400088ec: d5384001     	mrs	x1, SPSR_EL1
400088f0: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400088f4: a94007e0     	ldp	x0, x1, [sp]
400088f8: a9010fe2     	stp	x2, x3, [sp, #0x10]
400088fc: a90217e4     	stp	x4, x5, [sp, #0x20]
40008900: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008904: a90427e8     	stp	x8, x9, [sp, #0x40]
40008908: a9052fea     	stp	x10, x11, [sp, #0x50]
4000890c: a90637ec     	stp	x12, x13, [sp, #0x60]
40008910: a9073fee     	stp	x14, x15, [sp, #0x70]
40008914: a90847f0     	stp	x16, x17, [sp, #0x80]
40008918: a9094ff2     	stp	x18, x19, [sp, #0x90]
4000891c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008920: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008924: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40008928: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
4000892c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008930: f9007bfe     	str	x30, [sp, #0xf0]
40008934: 97ffde13     	bl	0x40000180 <c_handle_fiq_invalid>
40008938: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
4000893c: d5184020     	msr	ELR_EL1, x0
40008940: d5184001     	msr	SPSR_EL1, x1
40008944: a94007e0     	ldp	x0, x1, [sp]
40008948: a9410fe2     	ldp	x2, x3, [sp, #0x10]
4000894c: a94217e4     	ldp	x4, x5, [sp, #0x20]
40008950: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008954: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008958: a9452fea     	ldp	x10, x11, [sp, #0x50]
4000895c: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008960: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008964: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008968: a9494ff2     	ldp	x18, x19, [sp, #0x90]
4000896c: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008970: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008974: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008978: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
4000897c: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008980: f9407bfe     	ldr	x30, [sp, #0xf0]
40008984: 910443ff     	add	sp, sp, #0x110
40008988: d69f03e0     	eret

000000004000898c <handle_serror_invalid>:
4000898c: d10443ff     	sub	sp, sp, #0x110
40008990: a90007e0     	stp	x0, x1, [sp]
40008994: d5384020     	mrs	x0, ELR_EL1
40008998: d5384001     	mrs	x1, SPSR_EL1
4000899c: a90f87e0     	stp	x0, x1, [sp, #0xf8]
400089a0: a94007e0     	ldp	x0, x1, [sp]
400089a4: a9010fe2     	stp	x2, x3, [sp, #0x10]
400089a8: a90217e4     	stp	x4, x5, [sp, #0x20]
400089ac: a9031fe6     	stp	x6, x7, [sp, #0x30]
400089b0: a90427e8     	stp	x8, x9, [sp, #0x40]
400089b4: a9052fea     	stp	x10, x11, [sp, #0x50]
400089b8: a90637ec     	stp	x12, x13, [sp, #0x60]
400089bc: a9073fee     	stp	x14, x15, [sp, #0x70]
400089c0: a90847f0     	stp	x16, x17, [sp, #0x80]
400089c4: a9094ff2     	stp	x18, x19, [sp, #0x90]
400089c8: a90a57f4     	stp	x20, x21, [sp, #0xa0]
400089cc: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
400089d0: a90c67f8     	stp	x24, x25, [sp, #0xc0]
400089d4: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
400089d8: a90e77fc     	stp	x28, x29, [sp, #0xe0]
400089dc: f9007bfe     	str	x30, [sp, #0xf0]
400089e0: 97ffddee     	bl	0x40000198 <c_handle_serror_invalid>
400089e4: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
400089e8: d5184020     	msr	ELR_EL1, x0
400089ec: d5184001     	msr	SPSR_EL1, x1
400089f0: a94007e0     	ldp	x0, x1, [sp]
400089f4: a9410fe2     	ldp	x2, x3, [sp, #0x10]
400089f8: a94217e4     	ldp	x4, x5, [sp, #0x20]
400089fc: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008a00: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008a04: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008a08: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008a0c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008a10: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008a14: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008a18: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008a1c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008a20: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008a24: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008a28: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008a2c: f9407bfe     	ldr	x30, [sp, #0xf0]
40008a30: 910443ff     	add	sp, sp, #0x110
40008a34: d69f03e0     	eret

0000000040008a38 <trigger_undefined_instruction>:
40008a38: 00000000     	udf	#0x0
40008a3c: d65f03c0     	ret

0000000040008a40 <handle_sync_exception_asm>:
40008a40: d10443ff     	sub	sp, sp, #0x110
40008a44: a90007e0     	stp	x0, x1, [sp]
40008a48: d5384020     	mrs	x0, ELR_EL1
40008a4c: d5384001     	mrs	x1, SPSR_EL1
40008a50: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008a54: a94007e0     	ldp	x0, x1, [sp]
40008a58: a9010fe2     	stp	x2, x3, [sp, #0x10]
40008a5c: a90217e4     	stp	x4, x5, [sp, #0x20]
40008a60: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008a64: a90427e8     	stp	x8, x9, [sp, #0x40]
40008a68: a9052fea     	stp	x10, x11, [sp, #0x50]
40008a6c: a90637ec     	stp	x12, x13, [sp, #0x60]
40008a70: a9073fee     	stp	x14, x15, [sp, #0x70]
40008a74: a90847f0     	stp	x16, x17, [sp, #0x80]
40008a78: a9094ff2     	stp	x18, x19, [sp, #0x90]
40008a7c: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008a80: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008a84: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40008a88: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40008a8c: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008a90: f9007bfe     	str	x30, [sp, #0xf0]
40008a94: 910003e0     	mov	x0, sp
40008a98: 97ffdd72     	bl	0x40000060 <handle_sync_exception>
40008a9c: 9100001f     	mov	sp, x0
40008aa0: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40008aa4: d5184020     	msr	ELR_EL1, x0
40008aa8: d5184001     	msr	SPSR_EL1, x1
40008aac: a94007e0     	ldp	x0, x1, [sp]
40008ab0: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40008ab4: a94217e4     	ldp	x4, x5, [sp, #0x20]
40008ab8: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008abc: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008ac0: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008ac4: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008ac8: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008acc: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008ad0: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008ad4: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008ad8: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008adc: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008ae0: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008ae4: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008ae8: f9407bfe     	ldr	x30, [sp, #0xf0]
40008aec: 910443ff     	add	sp, sp, #0x110
40008af0: d69f03e0     	eret

0000000040008af4 <handle_irq_exception_asm>:
40008af4: d10443ff     	sub	sp, sp, #0x110
40008af8: a90007e0     	stp	x0, x1, [sp]
40008afc: d5384020     	mrs	x0, ELR_EL1
40008b00: d5384001     	mrs	x1, SPSR_EL1
40008b04: a90f87e0     	stp	x0, x1, [sp, #0xf8]
40008b08: a94007e0     	ldp	x0, x1, [sp]
40008b0c: a9010fe2     	stp	x2, x3, [sp, #0x10]
40008b10: a90217e4     	stp	x4, x5, [sp, #0x20]
40008b14: a9031fe6     	stp	x6, x7, [sp, #0x30]
40008b18: a90427e8     	stp	x8, x9, [sp, #0x40]
40008b1c: a9052fea     	stp	x10, x11, [sp, #0x50]
40008b20: a90637ec     	stp	x12, x13, [sp, #0x60]
40008b24: a9073fee     	stp	x14, x15, [sp, #0x70]
40008b28: a90847f0     	stp	x16, x17, [sp, #0x80]
40008b2c: a9094ff2     	stp	x18, x19, [sp, #0x90]
40008b30: a90a57f4     	stp	x20, x21, [sp, #0xa0]
40008b34: a90b5ff6     	stp	x22, x23, [sp, #0xb0]
40008b38: a90c67f8     	stp	x24, x25, [sp, #0xc0]
40008b3c: a90d6ffa     	stp	x26, x27, [sp, #0xd0]
40008b40: a90e77fc     	stp	x28, x29, [sp, #0xe0]
40008b44: f9007bfe     	str	x30, [sp, #0xf0]
40008b48: 910003e0     	mov	x0, sp
40008b4c: 97ffdd99     	bl	0x400001b0 <handle_irq_exception>
40008b50: 9100001f     	mov	sp, x0
40008b54: a94f87e0     	ldp	x0, x1, [sp, #0xf8]
40008b58: d5184020     	msr	ELR_EL1, x0
40008b5c: d5184001     	msr	SPSR_EL1, x1
40008b60: a94007e0     	ldp	x0, x1, [sp]
40008b64: a9410fe2     	ldp	x2, x3, [sp, #0x10]
40008b68: a94217e4     	ldp	x4, x5, [sp, #0x20]
40008b6c: a9431fe6     	ldp	x6, x7, [sp, #0x30]
40008b70: a94427e8     	ldp	x8, x9, [sp, #0x40]
40008b74: a9452fea     	ldp	x10, x11, [sp, #0x50]
40008b78: a94637ec     	ldp	x12, x13, [sp, #0x60]
40008b7c: a9473fee     	ldp	x14, x15, [sp, #0x70]
40008b80: a94847f0     	ldp	x16, x17, [sp, #0x80]
40008b84: a9494ff2     	ldp	x18, x19, [sp, #0x90]
40008b88: a94a57f4     	ldp	x20, x21, [sp, #0xa0]
40008b8c: a94b5ff6     	ldp	x22, x23, [sp, #0xb0]
40008b90: a94c67f8     	ldp	x24, x25, [sp, #0xc0]
40008b94: a94d6ffa     	ldp	x26, x27, [sp, #0xd0]
40008b98: a94e77fc     	ldp	x28, x29, [sp, #0xe0]
40008b9c: f9407bfe     	ldr	x30, [sp, #0xf0]
40008ba0: 910443ff     	add	sp, sp, #0x110
40008ba4: d69f03e0     	eret
