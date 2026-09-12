
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
40000048: 30 ce 05 40  	.word	0x4005ce30
4000004c: 00 00 00 00  	.word	0x00000000
40000050: 00 d0 00 40  	.word	0x4000d000
40000054: 00 00 00 00  	.word	0x00000000
40000058: 30 ce 04 40  	.word	0x4004ce30
4000005c: 00 00 00 00  	.word	0x00000000

0000000040000060 <handle_sync_exception>:
40000060: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40000064: a9024ff4     	stp	x20, x19, [sp, #0x20]
40000068: aa0003f3     	mov	x19, x0
4000006c: d503201f     	nop
40000070: 10053780     	adr	x0, 0x4000a760 <__rodata_start+0x1760>
40000074: f9000bf5     	str	x21, [sp, #0x10]
40000078: 910003fd     	mov	x29, sp
4000007c: d5385214     	mrs	x20, ESR_EL1
40000080: d5386015     	mrs	x21, FAR_EL1
40000084: 94000de9     	bl	0x40003828 <uart_puts>
40000088: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000008c: 91023000     	add	x0, x0, #0x8c
40000090: aa1403e1     	mov	x1, x20
40000094: 94000efa     	bl	0x40003c7c <uart_printf>
40000098: f9407e61     	ldr	x1, [x19, #0xf8]
4000009c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000a0: 9102ac00     	add	x0, x0, #0xab
400000a4: 94000ef6     	bl	0x40003c7c <uart_printf>
400000a8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000ac: 91116800     	add	x0, x0, #0x45a
400000b0: aa1503e1     	mov	x1, x21
400000b4: 94000ef2     	bl	0x40003c7c <uart_printf>
400000b8: 531a7e94     	lsr	w20, w20, #26
400000bc: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400000c0: 91267c00     	add	x0, x0, #0x99f
400000c4: 2a1403e1     	mov	w1, w20
400000c8: 94000eed     	bl	0x40003c7c <uart_printf>
400000cc: 35000094     	cbnz	w20, 0x400000dc <handle_sync_exception+0x7c>
400000d0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400000d4: 91000000     	add	x0, x0, #0x0
400000d8: 1400000a     	b	0x40000100 <handle_sync_exception+0xa0>
400000dc: 7100929f     	cmp	w20, #0x24
400000e0: 540000c0     	b.eq	0x400000f8 <handle_sync_exception+0x98>
400000e4: 7100569f     	cmp	w20, #0x15
400000e8: 540000e1     	b.ne	0x40000104 <handle_sync_exception+0xa4>
400000ec: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000f0: 91150800     	add	x0, x0, #0x542
400000f4: 14000003     	b	0x40000100 <handle_sync_exception+0xa0>
400000f8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400000fc: 9136c800     	add	x0, x0, #0xdb2
40000100: 94000dca     	bl	0x40003828 <uart_puts>
40000104: f9407e68     	ldr	x8, [x19, #0xf8]
40000108: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
4000010c: 91030800     	add	x0, x0, #0xc2
40000110: 91001108     	add	x8, x8, #0x4
40000114: f9007e68     	str	x8, [x19, #0xf8]
40000118: 94000dc4     	bl	0x40003828 <uart_puts>
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
40000140: 913bc800     	add	x0, x0, #0xef2
40000144: 910003fd     	mov	x29, sp
40000148: d5385214     	mrs	x20, ESR_EL1
4000014c: 94000ecc     	bl	0x40003c7c <uart_printf>
40000150: f9407e62     	ldr	x2, [x19, #0xf8]
40000154: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000158: 912c0400     	add	x0, x0, #0xb01
4000015c: aa1403e1     	mov	x1, x20
40000160: 94000ec7     	bl	0x40003c7c <uart_printf>
40000164: 14000000     	b	0x40000164 <c_handle_sync_invalid+0x34>

0000000040000168 <c_handle_irq_invalid>:
40000168: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000016c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000170: 91027400     	add	x0, x0, #0x9d
40000174: 910003fd     	mov	x29, sp
40000178: 94000dac     	bl	0x40003828 <uart_puts>
4000017c: 14000000     	b	0x4000017c <c_handle_irq_invalid+0x14>

0000000040000180 <c_handle_fiq_invalid>:
40000180: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000184: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000188: 91373000     	add	x0, x0, #0xdcc
4000018c: 910003fd     	mov	x29, sp
40000190: 94000da6     	bl	0x40003828 <uart_puts>
40000194: 14000000     	b	0x40000194 <c_handle_fiq_invalid+0x14>

0000000040000198 <c_handle_serror_invalid>:
40000198: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
4000019c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001a0: 91167800     	add	x0, x0, #0x59e
400001a4: 910003fd     	mov	x29, sp
400001a8: 94000da0     	bl	0x40003828 <uart_puts>
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
400001d8: 94000ab2     	bl	0x40002ca0 <timer_handle_interrupt>
400001dc: aa1303e0     	mov	x0, x19
400001e0: 940015aa     	bl	0x40005888 <sched_switch>
400001e4: aa0003f3     	mov	x19, x0
400001e8: 14000005     	b	0x400001fc <handle_irq_exception+0x4c>
400001ec: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400001f0: 911c2000     	add	x0, x0, #0x708
400001f4: 2a1403e1     	mov	w1, w20
400001f8: 94000ea1     	bl	0x40003c7c <uart_printf>
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
400002fc: 940009fb     	bl	0x40002ae8 <memset>
40000300: aa1303e0     	mov	x0, x19
40000304: aa1403e1     	mov	x1, x20
40000308: 528007e2     	mov	w2, #0x3f               // =63
4000030c: 940009d2     	bl	0x40002a54 <kstrncpy>
40000310: 5280003c     	mov	w28, #0x1               // =1
40000314: aa1403e0     	mov	x0, x20
40000318: b932427c     	str	w28, [x19, #0x3240]
4000031c: 9400121f     	bl	0x40004b98 <vfs_find>
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
400003bc: 10053ac0     	adr	x0, 0x4000ab14 <__rodata_start+0x1b14>
400003c0: 94000d1a     	bl	0x40003828 <uart_puts>
400003c4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400003c8: 91353294     	add	x20, x20, #0xd4c
400003cc: b0000056     	adrp	x22, 0x40009000 <__rodata_start>
400003d0: 91040ad6     	add	x22, x22, #0x102
400003d4: d0000058     	adrp	x24, 0x4000a000 <__rodata_start+0x1000>
400003d8: 91155318     	add	x24, x24, #0x554
400003dc: d0000059     	adrp	x25, 0x4000a000 <__rodata_start+0x1000>
400003e0: 91244339     	add	x25, x25, #0x910
400003e4: 9000009a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
400003e8: 9109135a     	add	x26, x26, #0x244
400003ec: 9000009b     	adrp	x27, 0x40010000 <__bss_start+0x3000>
400003f0: 14000004     	b	0x40000400 <launch_kedit+0x13c>
400003f4: 51004d08     	sub	w8, w8, #0x13
400003f8: 90000089     	adrp	x9, 0x40010000 <__bss_start+0x3000>
400003fc: b9024d28     	str	w8, [x9, #0x24c]
40000400: aa1403e0     	mov	x0, x20
40000404: 94000d09     	bl	0x40003828 <uart_puts>
40000408: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000040c: 910e4400     	add	x0, x0, #0x391
40000410: 94000d06     	bl	0x40003828 <uart_puts>
40000414: aa1603e0     	mov	x0, x22
40000418: 94000d04     	bl	0x40003828 <uart_puts>
4000041c: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000420: 9102e800     	add	x0, x0, #0xba
40000424: aa1303e1     	mov	x1, x19
40000428: 94000e15     	bl	0x40003c7c <uart_printf>
4000042c: b9725268     	ldr	w8, [x19, #0x3250]
40000430: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000434: 91141929     	add	x9, x9, #0x506
40000438: 7100011f     	cmp	w8, #0x0
4000043c: d0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40000440: 912e6d08     	add	x8, x8, #0xb9b
40000444: 9a880120     	csel	x0, x9, x8, eq
40000448: 94000cf8     	bl	0x40003828 <uart_puts>
4000044c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000450: 91036400     	add	x0, x0, #0xd9
40000454: 94000cf5     	bl	0x40003828 <uart_puts>
40000458: aa1f03f5     	mov	x21, xzr
4000045c: b9b24e68     	ldrsw	x8, [x19, #0x324c]
40000460: b9724269     	ldr	w9, [x19, #0x3240]
40000464: 8b0802a8     	add	x8, x21, x8
40000468: 8b081e6a     	add	x10, x19, x8, lsl #7
4000046c: 6b09011f     	cmp	w8, w9
40000470: 9101014a     	add	x10, x10, #0x40
40000474: 9a98b140     	csel	x0, x10, x24, lt
40000478: 94000cec     	bl	0x40003828 <uart_puts>
4000047c: aa1903e0     	mov	x0, x25
40000480: 94000cea     	bl	0x40003828 <uart_puts>
40000484: 910006b5     	add	x21, x21, #0x1
40000488: 710052bf     	cmp	w21, #0x14
4000048c: 54fffe81     	b.ne	0x4000045c <launch_kedit+0x198>
40000490: aa1603e0     	mov	x0, x22
40000494: 94000ce5     	bl	0x40003828 <uart_puts>
40000498: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000049c: 91157c00     	add	x0, x0, #0x55f
400004a0: 94000ce2     	bl	0x40003828 <uart_puts>
400004a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004a8: 9137a400     	add	x0, x0, #0xde9
400004ac: 94000cdf     	bl	0x40003828 <uart_puts>
400004b0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400004b4: 91244800     	add	x0, x0, #0x912
400004b8: 94000cdc     	bl	0x40003828 <uart_puts>
400004bc: 2940a349     	ldp	w9, w8, [x26, #0x4]
400004c0: b940034a     	ldr	w10, [x26]
400004c4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400004c8: 91121800     	add	x0, x0, #0x486
400004cc: 4b080128     	sub	w8, w9, w8
400004d0: 11000542     	add	w2, w10, #0x1
400004d4: 11000901     	add	w1, w8, #0x2
400004d8: 94000de9     	bl	0x40003c7c <uart_printf>
400004dc: 94000d07     	bl	0x400038f8 <uart_getc>
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
40000550: 9400093a     	bl	0x40002a38 <kstrcpy>
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
4000057c: 9400092f     	bl	0x40002a38 <kstrcpy>
40000580: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000584: b9b206a9     	ldrsw	x9, [x21, #0x3204]
40000588: 910023e1     	add	x1, sp, #0x8
4000058c: 8b081ea8     	add	x8, x21, x8, lsl #7
40000590: 3829691f     	strb	wzr, [x8, x9]
40000594: b9b20aa8     	ldrsw	x8, [x21, #0x3208]
40000598: 91000508     	add	x8, x8, #0x1
4000059c: 8b081ea0     	add	x0, x21, x8, lsl #7
400005a0: b9320aa8     	str	w8, [x21, #0x3208]
400005a4: 94000925     	bl	0x40002a38 <kstrcpy>
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
400005dc: 940008e8     	bl	0x4000297c <kstrlen>
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
40000674: 940008c2     	bl	0x4000297c <kstrlen>
40000678: 0b0002d4     	add	w20, w22, w0
4000067c: 710ffa9f     	cmp	w20, #0x3fe
40000680: 54fffeec     	b.gt	0x4000065c <launch_kedit+0x398>
40000684: 910023e0     	add	x0, sp, #0x8
40000688: aa1503e1     	mov	x1, x21
4000068c: 940008c3     	bl	0x40002998 <kstrcat>
40000690: 910023e0     	add	x0, sp, #0x8
40000694: aa1903e1     	mov	x1, x25
40000698: 940008c0     	bl	0x40002998 <kstrcat>
4000069c: 11000696     	add	w22, w20, #0x1
400006a0: 17ffffef     	b	0x4000065c <launch_kedit+0x398>
400006a4: 910023e1     	add	x1, sp, #0x8
400006a8: aa1303e0     	mov	x0, x19
400006ac: 940012b6     	bl	0x40005184 <vfs_write_file>
400006b0: b932527f     	str	wzr, [x19, #0x3250]
400006b4: 5280003c     	mov	w28, #0x1               // =1
400006b8: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006bc: 91353294     	add	x20, x20, #0xd4c
400006c0: 14000040     	b	0x400007c0 <launch_kedit+0x4fc>
400006c4: 94000c8d     	bl	0x400038f8 <uart_getc>
400006c8: 12001c14     	and	w20, w0, #0xff
400006cc: 94000c8b     	bl	0x400038f8 <uart_getc>
400006d0: 71016e9f     	cmp	w20, #0x5b
400006d4: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
400006d8: 91353294     	add	x20, x20, #0xd4c
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
40000710: 9400089b     	bl	0x4000297c <kstrlen>
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
40000760: 94000887     	bl	0x4000297c <kstrlen>
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
40000824: 94000856     	bl	0x4000297c <kstrlen>
40000828: eb14001f     	cmp	x0, x20
4000082c: b0000054     	adrp	x20, 0x40009000 <__rodata_start>
40000830: 91353294     	add	x20, x20, #0xd4c
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
4000088c: 912c6800     	add	x0, x0, #0xb1a
40000890: 94000be6     	bl	0x40003828 <uart_puts>
40000894: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000898: 912e2400     	add	x0, x0, #0xb89
4000089c: 94000be3     	bl	0x40003828 <uart_puts>
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
400008d8: 9400163e     	bl	0x400061d0 <virtio_net_poll>
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
40000910: 3004d400     	adr	x0, 0x4000a391 <__rodata_start+0x1391>
40000914: 910003fd     	mov	x29, sp
40000918: 94000bc4     	bl	0x40003828 <uart_puts>
4000091c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000920: 91244000     	add	x0, x0, #0x910
40000924: 94000bc1     	bl	0x40003828 <uart_puts>
40000928: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000092c: 91163000     	add	x0, x0, #0x58c
40000930: 94000bbe     	bl	0x40003828 <uart_puts>
40000934: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000938: 912ea000     	add	x0, x0, #0xba8
4000093c: 94000bbb     	bl	0x40003828 <uart_puts>
40000940: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000944: 91035400     	add	x0, x0, #0xd5
40000948: 94000bb8     	bl	0x40003828 <uart_puts>
4000094c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000950: 91009c00     	add	x0, x0, #0x27
40000954: 94000bb5     	bl	0x40003828 <uart_puts>
40000958: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000095c: 91044000     	add	x0, x0, #0x110
40000960: 94000bb2     	bl	0x40003828 <uart_puts>
40000964: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000968: 911ca000     	add	x0, x0, #0x728
4000096c: 94000baf     	bl	0x40003828 <uart_puts>
40000970: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000974: 91037c00     	add	x0, x0, #0xdf
40000978: 94000cc1     	bl	0x40003c7c <uart_printf>
4000097c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000980: 91246400     	add	x0, x0, #0x919
40000984: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000988: 91184021     	add	x1, x1, #0x610
4000098c: 94000cbc     	bl	0x40003c7c <uart_printf>
40000990: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000994: 910da400     	add	x0, x0, #0x369
40000998: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000099c: 91053021     	add	x1, x1, #0x14c
400009a0: 94000cb7     	bl	0x40003c7c <uart_printf>
400009a4: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009a8: 9137b800     	add	x0, x0, #0xdee
400009ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400009b0: 14000b9e     	b	0x40003828 <uart_puts>

00000000400009b4 <print_about>:
400009b4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400009b8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009bc: 910a3000     	add	x0, x0, #0x28c
400009c0: 910003fd     	mov	x29, sp
400009c4: 94000b99     	bl	0x40003828 <uart_puts>
400009c8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009cc: 911e5400     	add	x0, x0, #0x795
400009d0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009d4: 91057421     	add	x1, x1, #0x15d
400009d8: 94000ca9     	bl	0x40003c7c <uart_printf>
400009dc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
400009e0: 91295c00     	add	x0, x0, #0xa57
400009e4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
400009e8: 91184021     	add	x1, x1, #0x610
400009ec: 94000ca4     	bl	0x40003c7c <uart_printf>
400009f0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400009f4: 91144c00     	add	x0, x0, #0x513
400009f8: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400009fc: 91053021     	add	x1, x1, #0x14c
40000a00: 94000c9f     	bl	0x40003c7c <uart_printf>
40000a04: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000a08: 910ee400     	add	x0, x0, #0x3b9
40000a0c: 94000b87     	bl	0x40003828 <uart_puts>
40000a10: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000a14: 91239800     	add	x0, x0, #0x8e6
40000a18: 94000b84     	bl	0x40003828 <uart_puts>
40000a1c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a20: 91244000     	add	x0, x0, #0x910
40000a24: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000a28: 14000b80     	b	0x40003828 <uart_puts>

0000000040000a2c <print_sysinfo>:
40000a2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40000a30: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a34: 9109dc00     	add	x0, x0, #0x277
40000a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
40000a3c: 910003fd     	mov	x29, sp
40000a40: d5384248     	mrs	x8, CurrentEL
40000a44: d3420d13     	ubfx	x19, x8, #2, #2
40000a48: d5380014     	mrs	x20, MIDR_EL1
40000a4c: 94000b77     	bl	0x40003828 <uart_puts>
40000a50: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a54: 9133e800     	add	x0, x0, #0xcfa
40000a58: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a5c: 91057421     	add	x1, x1, #0x15d
40000a60: b0000042     	adrp	x2, 0x40009000 <__rodata_start>
40000a64: 91184042     	add	x2, x2, #0x610
40000a68: 94000c85     	bl	0x40003c7c <uart_printf>
40000a6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a70: 91346400     	add	x0, x0, #0xd19
40000a74: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000a78: 91053021     	add	x1, x1, #0x14c
40000a7c: 94000c80     	bl	0x40003c7c <uart_printf>
40000a80: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000a84: 913f0800     	add	x0, x0, #0xfc2
40000a88: 94000c7d     	bl	0x40003c7c <uart_printf>
40000a8c: f0000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
40000a90: 911f2508     	add	x8, x8, #0x7c9
40000a94: f0000049     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40000a98: 910fb929     	add	x9, x9, #0x3ee
40000a9c: f1000a7f     	cmp	x19, #0x2
40000aa0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000aa4: 9118ac00     	add	x0, x0, #0x62b
40000aa8: 9a880128     	csel	x8, x9, x8, eq
40000aac: f100067f     	cmp	x19, #0x1
40000ab0: d0000049     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40000ab4: 912f8d29     	add	x9, x9, #0xbe3
40000ab8: 2a1303e1     	mov	w1, w19
40000abc: 9a880122     	csel	x2, x9, x8, eq
40000ac0: 94000c6f     	bl	0x40003c7c <uart_printf>
40000ac4: 53187e81     	lsr	w1, w20, #24
40000ac8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000acc: 911eb800     	add	x0, x0, #0x7ae
40000ad0: aa1403e2     	mov	x2, x20
40000ad4: 94000c6a     	bl	0x40003c7c <uart_printf>
40000ad8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000adc: 913a4000     	add	x0, x0, #0xe90
40000ae0: d503201f     	nop
40000ae4: 10ffa8e1     	adr	x1, 0x40000000 <_start>
40000ae8: 94000c65     	bl	0x40003c7c <uart_printf>
40000aec: d503201f     	nop
40000af0: 10ffa881     	adr	x1, 0x40000000 <_start>
40000af4: d503201f     	nop
40000af8: 1003c582     	adr	x2, 0x400083a8 <__text_end>
40000afc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b00: 91354c00     	add	x0, x0, #0xd53
40000b04: cb010043     	sub	x3, x2, x1
40000b08: 94000c5d     	bl	0x40003c7c <uart_printf>
40000b0c: d503201f     	nop
40000b10: 10042781     	adr	x1, 0x40009000 <__rodata_start>
40000b14: d503201f     	nop
40000b18: 10057cc2     	adr	x2, 0x4000bab0 <__rodata_end>
40000b1c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b20: 911ce000     	add	x0, x0, #0x738
40000b24: cb010043     	sub	x3, x2, x1
40000b28: 94000c55     	bl	0x40003c7c <uart_printf>
40000b2c: d503201f     	nop
40000b30: 1005a681     	adr	x1, 0x4000c000 <next_pid>
40000b34: d503201f     	nop
40000b38: 102617c2     	adr	x2, 0x4004ce30
40000b3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b40: 91302400     	add	x0, x0, #0xc09
40000b44: cb010043     	sub	x3, x2, x1
40000b48: 94000c4d     	bl	0x40003c7c <uart_printf>
40000b4c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b50: 91050400     	add	x0, x0, #0x141
40000b54: d503201f     	nop
40000b58: 102e16c1     	adr	x1, 0x4005ce30 <__stack_top>
40000b5c: 94000c48     	bl	0x40003c7c <uart_printf>
40000b60: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40000b64: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b68: 91244000     	add	x0, x0, #0x910
40000b6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40000b70: 14000b2e     	b	0x40003828 <uart_puts>

0000000040000b74 <print_android_roadmap>:
40000b74: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000b78: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000b7c: 910fe400     	add	x0, x0, #0x3f9
40000b80: 910003fd     	mov	x29, sp
40000b84: 94000b29     	bl	0x40003828 <uart_puts>
40000b88: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000b8c: 913aa800     	add	x0, x0, #0xeaa
40000b90: 94000b26     	bl	0x40003828 <uart_puts>
40000b94: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000b98: 91193000     	add	x0, x0, #0x64c
40000b9c: 94000b23     	bl	0x40003828 <uart_puts>
40000ba0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ba4: 9134cc00     	add	x0, x0, #0xd33
40000ba8: 94000b20     	bl	0x40003828 <uart_puts>
40000bac: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bb0: 911d8800     	add	x0, x0, #0x762
40000bb4: 94000b1d     	bl	0x40003828 <uart_puts>
40000bb8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000bbc: 910e6400     	add	x0, x0, #0x399
40000bc0: 94000b1a     	bl	0x40003828 <uart_puts>
40000bc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000bc8: 9135f400     	add	x0, x0, #0xd7d
40000bcc: 94000b17     	bl	0x40003828 <uart_puts>
40000bd0: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000bd4: 911f5400     	add	x0, x0, #0x7d5
40000bd8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000bdc: 14000b13     	b	0x40003828 <uart_puts>

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
40000c04: 9126f694     	add	x20, x20, #0x9bd
40000c08: aa1703f6     	mov	x22, x23
40000c0c: 94000b3b     	bl	0x400038f8 <uart_getc>
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
40000c60: 94000adb     	bl	0x400037cc <uart_putc>
40000c64: 17ffffe9     	b	0x40000c08 <read_line+0x28>
40000c68: aa1f03f7     	mov	x23, xzr
40000c6c: b4fffcf6     	cbz	x22, 0x40000c08 <read_line+0x28>
40000c70: aa1403e0     	mov	x0, x20
40000c74: d10006d7     	sub	x23, x22, #0x1
40000c78: 94000aec     	bl	0x40003828 <uart_puts>
40000c7c: 17ffffe3     	b	0x40000c08 <read_line+0x28>
40000c80: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000c84: 91058400     	add	x0, x0, #0x161
40000c88: 94000ae8     	bl	0x40003828 <uart_puts>
40000c8c: 38366a7f     	strb	wzr, [x19, x22]
40000c90: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40000c94: a94257f6     	ldp	x22, x21, [sp, #0x20]
40000c98: f9400bf7     	ldr	x23, [sp, #0x10]
40000c9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40000ca0: d65f03c0     	ret

0000000040000ca4 <print_help>:
40000ca4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40000ca8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cac: 912fbc00     	add	x0, x0, #0xbef
40000cb0: 910003fd     	mov	x29, sp
40000cb4: 94000add     	bl	0x40003828 <uart_puts>
40000cb8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cbc: 91160800     	add	x0, x0, #0x582
40000cc0: 94000ada     	bl	0x40003828 <uart_puts>
40000cc4: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000cc8: 91249800     	add	x0, x0, #0x926
40000ccc: 94000ad7     	bl	0x40003828 <uart_puts>
40000cd0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000cd4: 91059000     	add	x0, x0, #0x164
40000cd8: 94000ad4     	bl	0x40003828 <uart_puts>
40000cdc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000ce0: 910a6c00     	add	x0, x0, #0x29b
40000ce4: 94000ad1     	bl	0x40003828 <uart_puts>
40000ce8: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cec: 9105a000     	add	x0, x0, #0x168
40000cf0: 94000ace     	bl	0x40003828 <uart_puts>
40000cf4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000cf8: 91208000     	add	x0, x0, #0x820
40000cfc: 94000acb     	bl	0x40003828 <uart_puts>
40000d00: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d04: 911eb400     	add	x0, x0, #0x7ad
40000d08: 94000ac8     	bl	0x40003828 <uart_puts>
40000d0c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d10: 91259400     	add	x0, x0, #0x965
40000d14: 94000ac5     	bl	0x40003828 <uart_puts>
40000d18: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d1c: 91219800     	add	x0, x0, #0x866
40000d20: 94000ac2     	bl	0x40003828 <uart_puts>
40000d24: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d28: 91269800     	add	x0, x0, #0x9a6
40000d2c: 94000abf     	bl	0x40003828 <uart_puts>
40000d30: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d34: 91371000     	add	x0, x0, #0xdc4
40000d38: 94000abc     	bl	0x40003828 <uart_puts>
40000d3c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d40: 91041c00     	add	x0, x0, #0x107
40000d44: 94000ab9     	bl	0x40003828 <uart_puts>
40000d48: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d4c: 9110c400     	add	x0, x0, #0x431
40000d50: 94000ab6     	bl	0x40003828 <uart_puts>
40000d54: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000d58: 91258800     	add	x0, x0, #0x962
40000d5c: 94000ab3     	bl	0x40003828 <uart_puts>
40000d60: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d64: 913bac00     	add	x0, x0, #0xeeb
40000d68: 94000ab0     	bl	0x40003828 <uart_puts>
40000d6c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d70: 910b0800     	add	x0, x0, #0x2c2
40000d74: 94000aad     	bl	0x40003828 <uart_puts>
40000d78: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d7c: 911f5400     	add	x0, x0, #0x7d5
40000d80: 94000aaa     	bl	0x40003828 <uart_puts>
40000d84: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000d88: 91270400     	add	x0, x0, #0x9c1
40000d8c: 94000aa7     	bl	0x40003828 <uart_puts>
40000d90: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000d94: 91171c00     	add	x0, x0, #0x5c7
40000d98: 94000aa4     	bl	0x40003828 <uart_puts>
40000d9c: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000da0: 910ab800     	add	x0, x0, #0x2ae
40000da4: 94000aa1     	bl	0x40003828 <uart_puts>
40000da8: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dac: 910f9c00     	add	x0, x0, #0x3e7
40000db0: 94000a9e     	bl	0x40003828 <uart_puts>
40000db4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000db8: 9111a800     	add	x0, x0, #0x46a
40000dbc: 94000a9b     	bl	0x40003828 <uart_puts>
40000dc0: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dc4: 9127a000     	add	x0, x0, #0x9e8
40000dc8: 94000a98     	bl	0x40003828 <uart_puts>
40000dcc: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000dd0: 91182c00     	add	x0, x0, #0x60b
40000dd4: 94000a95     	bl	0x40003828 <uart_puts>
40000dd8: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000ddc: 91123c00     	add	x0, x0, #0x48f
40000de0: 94000a92     	bl	0x40003828 <uart_puts>
40000de4: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000de8: 91282800     	add	x0, x0, #0xa0a
40000dec: 94000a8f     	bl	0x40003828 <uart_puts>
40000df0: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000df4: 911f8400     	add	x0, x0, #0x7e1
40000df8: 94000a8c     	bl	0x40003828 <uart_puts>
40000dfc: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e00: 9137c000     	add	x0, x0, #0xdf0
40000e04: 94000a89     	bl	0x40003828 <uart_puts>
40000e08: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e0c: 9104e400     	add	x0, x0, #0x139
40000e10: 94000a86     	bl	0x40003828 <uart_puts>
40000e14: f0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40000e18: 9112b000     	add	x0, x0, #0x4ac
40000e1c: 94000a83     	bl	0x40003828 <uart_puts>
40000e20: b0000040     	adrp	x0, 0x40009000 <__rodata_start>
40000e24: 912c8800     	add	x0, x0, #0xb22
40000e28: 94000a80     	bl	0x40003828 <uart_puts>
40000e2c: d0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40000e30: 91207c00     	add	x0, x0, #0x81f
40000e34: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40000e38: 14000a7c     	b	0x40003828 <uart_puts>

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
40000f04: 912cc421     	add	x1, x1, #0xb31
40000f08: d10083a0     	sub	x0, x29, #0x20
40000f0c: 382c691f     	strb	wzr, [x8, x12]
40000f10: 940006ab     	bl	0x400029bc <kstrcmp>
40000f14: 34001400     	cbz	w0, 0x40001194 <execute_command+0x358>
40000f18: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f1c: 91280821     	add	x1, x1, #0xa02
40000f20: d10083a0     	sub	x0, x29, #0x20
40000f24: 940006a6     	bl	0x400029bc <kstrcmp>
40000f28: 340013a0     	cbz	w0, 0x4000119c <execute_command+0x360>
40000f2c: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f30: 910bd421     	add	x1, x1, #0x2f5
40000f34: d10083a0     	sub	x0, x29, #0x20
40000f38: 940006a1     	bl	0x400029bc <kstrcmp>
40000f3c: 34001680     	cbz	w0, 0x4000120c <execute_command+0x3d0>
40000f40: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f44: 913cac21     	add	x1, x1, #0xf2b
40000f48: d10083a0     	sub	x0, x29, #0x20
40000f4c: 9400069c     	bl	0x400029bc <kstrcmp>
40000f50: 34001800     	cbz	w0, 0x40001250 <execute_command+0x414>
40000f54: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f58: 910cb021     	add	x1, x1, #0x32c
40000f5c: d10083a0     	sub	x0, x29, #0x20
40000f60: 94000697     	bl	0x400029bc <kstrcmp>
40000f64: 34001860     	cbz	w0, 0x40001270 <execute_command+0x434>
40000f68: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000f6c: 91261421     	add	x1, x1, #0x985
40000f70: d10083a0     	sub	x0, x29, #0x20
40000f74: 94000692     	bl	0x400029bc <kstrcmp>
40000f78: 34001900     	cbz	w0, 0x40001298 <execute_command+0x45c>
40000f7c: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000f80: 913fcc21     	add	x1, x1, #0xff3
40000f84: d10083a0     	sub	x0, x29, #0x20
40000f88: 9400068d     	bl	0x400029bc <kstrcmp>
40000f8c: 34001960     	cbz	w0, 0x400012b8 <execute_command+0x47c>
40000f90: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000f94: 91176021     	add	x1, x1, #0x5d8
40000f98: d10083a0     	sub	x0, x29, #0x20
40000f9c: 94000688     	bl	0x400029bc <kstrcmp>
40000fa0: 34001880     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fa4: d0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40000fa8: 91310c21     	add	x1, x1, #0xc43
40000fac: d10083a0     	sub	x0, x29, #0x20
40000fb0: 94000683     	bl	0x400029bc <kstrcmp>
40000fb4: 340017e0     	cbz	w0, 0x400012b0 <execute_command+0x474>
40000fb8: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fbc: 912d4c21     	add	x1, x1, #0xb53
40000fc0: d10083a0     	sub	x0, x29, #0x20
40000fc4: 9400067e     	bl	0x400029bc <kstrcmp>
40000fc8: 34001960     	cbz	w0, 0x400012f4 <execute_command+0x4b8>
40000fcc: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000fd0: 91167421     	add	x1, x1, #0x59d
40000fd4: d10083a0     	sub	x0, x29, #0x20
40000fd8: 94000679     	bl	0x400029bc <kstrcmp>
40000fdc: 34001900     	cbz	w0, 0x400012fc <execute_command+0x4c0>
40000fe0: f0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40000fe4: 9122a421     	add	x1, x1, #0x8a9
40000fe8: d10083a0     	sub	x0, x29, #0x20
40000fec: 94000674     	bl	0x400029bc <kstrcmp>
40000ff0: 34001aa0     	cbz	w0, 0x40001344 <execute_command+0x508>
40000ff4: b0000041     	adrp	x1, 0x40009000 <__rodata_start>
40000ff8: 91133021     	add	x1, x1, #0x4cc
40000ffc: d10083a0     	sub	x0, x29, #0x20
40001000: 9400066f     	bl	0x400029bc <kstrcmp>
40001004: 34001b80     	cbz	w0, 0x40001374 <execute_command+0x538>
40001008: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000100c: 91281821     	add	x1, x1, #0xa06
40001010: d10083a0     	sub	x0, x29, #0x20
40001014: 9400066a     	bl	0x400029bc <kstrcmp>
40001018: 34001dc0     	cbz	w0, 0x400013d0 <execute_command+0x594>
4000101c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001020: 9131f821     	add	x1, x1, #0xc7e
40001024: d10083a0     	sub	x0, x29, #0x20
40001028: 94000665     	bl	0x400029bc <kstrcmp>
4000102c: 340020e0     	cbz	w0, 0x40001448 <execute_command+0x60c>
40001030: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001034: 91283421     	add	x1, x1, #0xa0d
40001038: d10083a0     	sub	x0, x29, #0x20
4000103c: 94000660     	bl	0x400029bc <kstrcmp>
40001040: 34001e20     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001044: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001048: 9106b021     	add	x1, x1, #0x1ac
4000104c: d10083a0     	sub	x0, x29, #0x20
40001050: 9400065b     	bl	0x400029bc <kstrcmp>
40001054: 34001d80     	cbz	w0, 0x40001404 <execute_command+0x5c8>
40001058: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
4000105c: 91069c21     	add	x1, x1, #0x1a7
40001060: d10083a0     	sub	x0, x29, #0x20
40001064: 94000656     	bl	0x400029bc <kstrcmp>
40001068: 340021a0     	cbz	w0, 0x4000149c <execute_command+0x660>
4000106c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001070: 910cbc21     	add	x1, x1, #0x32f
40001074: d10083a0     	sub	x0, x29, #0x20
40001078: 94000651     	bl	0x400029bc <kstrcmp>
4000107c: 34002260     	cbz	w0, 0x400014c8 <execute_command+0x68c>
40001080: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001084: 9114b021     	add	x1, x1, #0x52c
40001088: d10083a0     	sub	x0, x29, #0x20
4000108c: 9400064c     	bl	0x400029bc <kstrcmp>
40001090: 34002340     	cbz	w0, 0x400014f8 <execute_command+0x6bc>
40001094: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001098: 91223021     	add	x1, x1, #0x88c
4000109c: d10083a0     	sub	x0, x29, #0x20
400010a0: 94000647     	bl	0x400029bc <kstrcmp>
400010a4: 340023e0     	cbz	w0, 0x40001520 <execute_command+0x6e4>
400010a8: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010ac: 91215c21     	add	x1, x1, #0x857
400010b0: d10083a0     	sub	x0, x29, #0x20
400010b4: 94000642     	bl	0x400029bc <kstrcmp>
400010b8: 34002520     	cbz	w0, 0x4000155c <execute_command+0x720>
400010bc: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010c0: 91085821     	add	x1, x1, #0x216
400010c4: d10083a0     	sub	x0, x29, #0x20
400010c8: 9400063d     	bl	0x400029bc <kstrcmp>
400010cc: 34002720     	cbz	w0, 0x400015b0 <execute_command+0x774>
400010d0: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010d4: 9114c821     	add	x1, x1, #0x532
400010d8: d10083a0     	sub	x0, x29, #0x20
400010dc: 94000638     	bl	0x400029bc <kstrcmp>
400010e0: 34002600     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010e4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400010e8: 91217421     	add	x1, x1, #0x85d
400010ec: d10083a0     	sub	x0, x29, #0x20
400010f0: 94000633     	bl	0x400029bc <kstrcmp>
400010f4: 34002560     	cbz	w0, 0x400015a0 <execute_command+0x764>
400010f8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400010fc: 91224821     	add	x1, x1, #0x892
40001100: d10083a0     	sub	x0, x29, #0x20
40001104: 9400062e     	bl	0x400029bc <kstrcmp>
40001108: 34002aa0     	cbz	w0, 0x4000165c <execute_command+0x820>
4000110c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001110: 910c0021     	add	x1, x1, #0x300
40001114: d10083a0     	sub	x0, x29, #0x20
40001118: 94000629     	bl	0x400029bc <kstrcmp>
4000111c: 34002a00     	cbz	w0, 0x4000165c <execute_command+0x820>
40001120: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001124: 91111c21     	add	x1, x1, #0x447
40001128: d10083a0     	sub	x0, x29, #0x20
4000112c: 94000624     	bl	0x400029bc <kstrcmp>
40001130: 34002aa0     	cbz	w0, 0x40001684 <execute_command+0x848>
40001134: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001138: 91362c21     	add	x1, x1, #0xd8b
4000113c: d10083a0     	sub	x0, x29, #0x20
40001140: 9400061f     	bl	0x400029bc <kstrcmp>
40001144: 34003080     	cbz	w0, 0x40001754 <execute_command+0x918>
40001148: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
4000114c: 9128b021     	add	x1, x1, #0xa2c
40001150: d10083a0     	sub	x0, x29, #0x20
40001154: 9400061a     	bl	0x400029bc <kstrcmp>
40001158: 34002ee0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
4000115c: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001160: 9117ac21     	add	x1, x1, #0x5eb
40001164: d10083a0     	sub	x0, x29, #0x20
40001168: 94000615     	bl	0x400029bc <kstrcmp>
4000116c: 34002e40     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001170: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001174: 91325c21     	add	x1, x1, #0xc97
40001178: d10083a0     	sub	x0, x29, #0x20
4000117c: 94000610     	bl	0x400029bc <kstrcmp>
40001180: 34002da0     	cbz	w0, 0x40001734 <execute_command+0x8f8>
40001184: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001188: 9117c000     	add	x0, x0, #0x5f0
4000118c: d10083a1     	sub	x1, x29, #0x20
40001190: 140000b4     	b	0x40001460 <execute_command+0x624>
40001194: 97fffec4     	bl	0x40000ca4 <print_help>
40001198: 1400002f     	b	0x40001254 <execute_command+0x418>
4000119c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011a0: 910a3000     	add	x0, x0, #0x28c
400011a4: 940009a1     	bl	0x40003828 <uart_puts>
400011a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011ac: 911e5400     	add	x0, x0, #0x795
400011b0: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011b4: 91057421     	add	x1, x1, #0x15d
400011b8: 94000ab1     	bl	0x40003c7c <uart_printf>
400011bc: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011c0: 91295c00     	add	x0, x0, #0xa57
400011c4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
400011c8: 91184021     	add	x1, x1, #0x610
400011cc: 94000aac     	bl	0x40003c7c <uart_printf>
400011d0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400011d4: 91144c00     	add	x0, x0, #0x513
400011d8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400011dc: 91053021     	add	x1, x1, #0x14c
400011e0: 94000aa7     	bl	0x40003c7c <uart_printf>
400011e4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400011e8: 910ee400     	add	x0, x0, #0x3b9
400011ec: 9400098f     	bl	0x40003828 <uart_puts>
400011f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400011f4: 91239800     	add	x0, x0, #0x8e6
400011f8: 9400098c     	bl	0x40003828 <uart_puts>
400011fc: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001200: 91244000     	add	x0, x0, #0x910
40001204: 94000989     	bl	0x40003828 <uart_puts>
40001208: 14000013     	b	0x40001254 <execute_command+0x418>
4000120c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001210: 91088800     	add	x0, x0, #0x222
40001214: 94000985     	bl	0x40003828 <uart_puts>
40001218: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000121c: 910b8400     	add	x0, x0, #0x2e1
40001220: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001224: 91184021     	add	x1, x1, #0x610
40001228: 94000a95     	bl	0x40003c7c <uart_printf>
4000122c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001230: 9130cc00     	add	x0, x0, #0xc33
40001234: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001238: 91053021     	add	x1, x1, #0x14c
4000123c: 94000a90     	bl	0x40003c7c <uart_printf>
40001240: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001244: 9105d400     	add	x0, x0, #0x175
40001248: 94000978     	bl	0x40003828 <uart_puts>
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
40001274: 940005c2     	bl	0x4000297c <kstrlen>
40001278: b4000260     	cbz	x0, 0x400012c4 <execute_command+0x488>
4000127c: 910103e0     	add	x0, sp, #0x40
40001280: 94000fd1     	bl	0x400051c4 <vfs_remove>
40001284: 34000280     	cbz	w0, 0x400012d4 <execute_command+0x498>
40001288: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000128c: 9116f800     	add	x0, x0, #0x5be
40001290: 94000966     	bl	0x40003828 <uart_puts>
40001294: 17fffff0     	b	0x40001254 <execute_command+0x418>
40001298: 910103e0     	add	x0, sp, #0x40
4000129c: 940005b8     	bl	0x4000297c <kstrlen>
400012a0: b4000220     	cbz	x0, 0x400012e4 <execute_command+0x4a8>
400012a4: 910103e0     	add	x0, sp, #0x40
400012a8: 97fffc07     	bl	0x400002c4 <launch_kedit>
400012ac: 17ffffea     	b	0x40001254 <execute_command+0x418>
400012b0: 94000688     	bl	0x40002cd0 <tui_launch>
400012b4: 17ffffe8     	b	0x40001254 <execute_command+0x418>
400012b8: 910103e0     	add	x0, sp, #0x40
400012bc: 9400024f     	bl	0x40001bf8 <kproj_execute>
400012c0: 17ffffe5     	b	0x40001254 <execute_command+0x418>
400012c4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012c8: 911a5c00     	add	x0, x0, #0x697
400012cc: 94000957     	bl	0x40003828 <uart_puts>
400012d0: 17ffffe1     	b	0x40001254 <execute_command+0x418>
400012d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400012d8: 91360400     	add	x0, x0, #0xd81
400012dc: 94000953     	bl	0x40003828 <uart_puts>
400012e0: 17ffffdd     	b	0x40001254 <execute_command+0x418>
400012e4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400012e8: 91387400     	add	x0, x0, #0xe1d
400012ec: 9400094f     	bl	0x40003828 <uart_puts>
400012f0: 17ffffd9     	b	0x40001254 <execute_command+0x418>
400012f4: 94000383     	bl	0x40002100 <launch_ktop>
400012f8: 17ffffd7     	b	0x40001254 <execute_command+0x418>
400012fc: 910103e0     	add	x0, sp, #0x40
40001300: 9400059f     	bl	0x4000297c <kstrlen>
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
40001350: 94000605     	bl	0x40002b64 <kstrstr>
40001354: b4000460     	cbz	x0, 0x400013e0 <execute_command+0x5a4>
40001358: 3900001f     	strb	wzr, [x0]
4000135c: 38401c08     	ldrb	w8, [x0, #0x1]!
40001360: 7100811f     	cmp	w8, #0x20
40001364: 54ffffc0     	b.eq	0x4000135c <execute_command+0x520>
40001368: 91001661     	add	x1, x19, #0x5
4000136c: 94000f86     	bl	0x40005184 <vfs_write_file>
40001370: 17ffffb9     	b	0x40001254 <execute_command+0x418>
40001374: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001378: 910bf421     	add	x1, x1, #0x2fd
4000137c: 910103e0     	add	x0, sp, #0x40
40001380: 9400058f     	bl	0x400029bc <kstrcmp>
40001384: 34000720     	cbz	w0, 0x40001468 <execute_command+0x62c>
40001388: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000138c: 911b5000     	add	x0, x0, #0x6d4
40001390: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001394: 91057421     	add	x1, x1, #0x15d
40001398: 14000032     	b	0x40001460 <execute_command+0x624>
4000139c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400013a0: 91194400     	add	x0, x0, #0x651
400013a4: 94000921     	bl	0x40003828 <uart_puts>
400013a8: 17ffffab     	b	0x40001254 <execute_command+0x418>
400013ac: 2a1f03f3     	mov	w19, wzr
400013b0: 2a1303e0     	mov	w0, w19
400013b4: 940002be     	bl	0x40001eac <process_kill>
400013b8: 3100041f     	cmn	w0, #0x1
400013bc: 540001a0     	b.eq	0x400013f0 <execute_command+0x5b4>
400013c0: 35fff4a0     	cbnz	w0, 0x40001254 <execute_command+0x418>
400013c4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013c8: 910b0c00     	add	x0, x0, #0x2c3
400013cc: 1400000b     	b	0x400013f8 <execute_command+0x5bc>
400013d0: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400013d4: 910b5c00     	add	x0, x0, #0x2d7
400013d8: 94000914     	bl	0x40003828 <uart_puts>
400013dc: 17ffff9e     	b	0x40001254 <execute_command+0x418>
400013e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013e4: 911b5000     	add	x0, x0, #0x6d4
400013e8: 910103e1     	add	x1, sp, #0x40
400013ec: 1400001d     	b	0x40001460 <execute_command+0x624>
400013f0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400013f4: 911ab400     	add	x0, x0, #0x6ad
400013f8: 2a1303e1     	mov	w1, w19
400013fc: 94000a20     	bl	0x40003c7c <uart_printf>
40001400: 17ffff95     	b	0x40001254 <execute_command+0x418>
40001404: 94000d93     	bl	0x40004a50 <vfs_get_cwd>
40001408: aa0003f3     	mov	x19, x0
4000140c: 910103e0     	add	x0, sp, #0x40
40001410: 9400055b     	bl	0x4000297c <kstrlen>
40001414: b40003e0     	cbz	x0, 0x40001490 <execute_command+0x654>
40001418: 910103e0     	add	x0, sp, #0x40
4000141c: 94000ddf     	bl	0x40004b98 <vfs_find>
40001420: b40004c0     	cbz	x0, 0x400014b8 <execute_command+0x67c>
40001424: b9402008     	ldr	w8, [x0, #0x20]
40001428: 35000368     	cbnz	w8, 0x40001494 <execute_command+0x658>
4000142c: b9402801     	ldr	w1, [x0, #0x28]
40001430: b0000048     	adrp	x8, 0x4000a000 <__rodata_start+0x1000>
40001434: 9121d108     	add	x8, x8, #0x874
40001438: aa0003e2     	mov	x2, x0
4000143c: aa0803e0     	mov	x0, x8
40001440: 94000a0f     	bl	0x40003c7c <uart_printf>
40001444: 17ffff84     	b	0x40001254 <execute_command+0x418>
40001448: 910003e0     	mov	x0, sp
4000144c: 52800801     	mov	w1, #0x40               // =64
40001450: 94000d83     	bl	0x40004a5c <vfs_getcwd>
40001454: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001458: 911b5000     	add	x0, x0, #0x6d4
4000145c: 910003e1     	mov	x1, sp
40001460: 94000a07     	bl	0x40003c7c <uart_printf>
40001464: 17ffff7c     	b	0x40001254 <execute_command+0x418>
40001468: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
4000146c: 9120a000     	add	x0, x0, #0x828
40001470: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001474: 91057421     	add	x1, x1, #0x15d
40001478: 90000042     	adrp	x2, 0x40009000 <__rodata_start>
4000147c: 91184042     	add	x2, x2, #0x610
40001480: d0000043     	adrp	x3, 0x4000b000 <__rodata_start+0x2000>
40001484: 91053063     	add	x3, x3, #0x14c
40001488: 940009fd     	bl	0x40003c7c <uart_printf>
4000148c: 17ffff72     	b	0x40001254 <execute_command+0x418>
40001490: aa1303e0     	mov	x0, x19
40001494: 94000f85     	bl	0x400052a8 <vfs_list_dir>
40001498: 17ffff6f     	b	0x40001254 <execute_command+0x418>
4000149c: 910103e0     	add	x0, sp, #0x40
400014a0: 94000e23     	bl	0x40004d2c <vfs_chdir>
400014a4: 34ffed80     	cbz	w0, 0x40001254 <execute_command+0x418>
400014a8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014ac: 91108c00     	add	x0, x0, #0x423
400014b0: 910103e1     	add	x1, sp, #0x40
400014b4: 17ffffeb     	b	0x40001460 <execute_command+0x624>
400014b8: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400014bc: 91199000     	add	x0, x0, #0x664
400014c0: 910103e1     	add	x1, sp, #0x40
400014c4: 17ffffe7     	b	0x40001460 <execute_command+0x624>
400014c8: 910103e0     	add	x0, sp, #0x40
400014cc: 9400052c     	bl	0x4000297c <kstrlen>
400014d0: b40003e0     	cbz	x0, 0x4000154c <execute_command+0x710>
400014d4: 910103e0     	add	x0, sp, #0x40
400014d8: 94000db0     	bl	0x40004b98 <vfs_find>
400014dc: b4000060     	cbz	x0, 0x400014e8 <execute_command+0x6ac>
400014e0: b9402008     	ldr	w8, [x0, #0x20]
400014e4: 34000a28     	cbz	w8, 0x40001628 <execute_command+0x7ec>
400014e8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400014ec: 910ccc00     	add	x0, x0, #0x333
400014f0: 940008ce     	bl	0x40003828 <uart_puts>
400014f4: 17ffff58     	b	0x40001254 <execute_command+0x418>
400014f8: 910103e0     	add	x0, sp, #0x40
400014fc: 94000520     	bl	0x4000297c <kstrlen>
40001500: b4000480     	cbz	x0, 0x40001590 <execute_command+0x754>
40001504: 910103e0     	add	x0, sp, #0x40
40001508: 94000e2e     	bl	0x40004dc0 <vfs_mkdir>
4000150c: 34ffea40     	cbz	w0, 0x40001254 <execute_command+0x418>
40001510: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001514: 910c0000     	add	x0, x0, #0x300
40001518: 940008c4     	bl	0x40003828 <uart_puts>
4000151c: 17ffff4e     	b	0x40001254 <execute_command+0x418>
40001520: 910103e0     	add	x0, sp, #0x40
40001524: 94000516     	bl	0x4000297c <kstrlen>
40001528: b40008a0     	cbz	x0, 0x4000163c <execute_command+0x800>
4000152c: 910103e0     	add	x0, sp, #0x40
40001530: aa1f03e1     	mov	x1, xzr
40001534: 94000e79     	bl	0x40004f18 <vfs_touch>
40001538: 34ffe8e0     	cbz	w0, 0x40001254 <execute_command+0x418>
4000153c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001540: 91177000     	add	x0, x0, #0x5dc
40001544: 940008b9     	bl	0x40003828 <uart_puts>
40001548: 17ffff43     	b	0x40001254 <execute_command+0x418>
4000154c: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001550: 91137c00     	add	x0, x0, #0x4df
40001554: 940008b5     	bl	0x40003828 <uart_puts>
40001558: 17ffff3f     	b	0x40001254 <execute_command+0x418>
4000155c: 910103e0     	add	x0, sp, #0x40
40001560: 52800401     	mov	w1, #0x20               // =32
40001564: 9400059b     	bl	0x40002bd0 <kstrchr>
40001568: b4000720     	cbz	x0, 0x4000164c <execute_command+0x810>
4000156c: aa0003e1     	mov	x1, x0
40001570: 910103e0     	add	x0, sp, #0x40
40001574: 3800143f     	strb	wzr, [x1], #0x1
40001578: 94000f03     	bl	0x40005184 <vfs_write_file>
4000157c: 34ffe6c0     	cbz	w0, 0x40001254 <execute_command+0x418>
40001580: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001584: 91134800     	add	x0, x0, #0x4d2
40001588: 940008a8     	bl	0x40003828 <uart_puts>
4000158c: 17ffff32     	b	0x40001254 <execute_command+0x418>
40001590: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001594: 911a8000     	add	x0, x0, #0x6a0
40001598: 940008a4     	bl	0x40003828 <uart_puts>
4000159c: 17ffff2e     	b	0x40001254 <execute_command+0x418>
400015a0: d503201f     	nop
400015a4: 30046f60     	adr	x0, 0x4000a391 <__rodata_start+0x1391>
400015a8: 940008a0     	bl	0x40003828 <uart_puts>
400015ac: 17ffff2a     	b	0x40001254 <execute_command+0x418>
400015b0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015b4: 91244000     	add	x0, x0, #0x910
400015b8: 9400089c     	bl	0x40003828 <uart_puts>
400015bc: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015c0: 913fe400     	add	x0, x0, #0xff9
400015c4: 94000899     	bl	0x40003828 <uart_puts>
400015c8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015cc: 91018800     	add	x0, x0, #0x62
400015d0: 94000896     	bl	0x40003828 <uart_puts>
400015d4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015d8: 913ccc00     	add	x0, x0, #0xf33
400015dc: 94000893     	bl	0x40003828 <uart_puts>
400015e0: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
400015e4: 91138400     	add	x0, x0, #0x4e1
400015e8: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
400015ec: 91053021     	add	x1, x1, #0x14c
400015f0: 940009a3     	bl	0x40003c7c <uart_printf>
400015f4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400015f8: 91284000     	add	x0, x0, #0xa10
400015fc: 9400088b     	bl	0x40003828 <uart_puts>
40001600: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001604: 9122b800     	add	x0, x0, #0x8ae
40001608: 94000888     	bl	0x40003828 <uart_puts>
4000160c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001610: 911ad400     	add	x0, x0, #0x6b5
40001614: 94000885     	bl	0x40003828 <uart_puts>
40001618: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000161c: 91312c00     	add	x0, x0, #0xc4b
40001620: 94000882     	bl	0x40003828 <uart_puts>
40001624: 17ffff0c     	b	0x40001254 <execute_command+0x418>
40001628: 90000048     	adrp	x8, 0x40009000 <__rodata_start>
4000162c: 911b5108     	add	x8, x8, #0x6d4
40001630: 9100c001     	add	x1, x0, #0x30
40001634: aa0803e0     	mov	x0, x8
40001638: 17ffff8a     	b	0x40001460 <execute_command+0x624>
4000163c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001640: 91320800     	add	x0, x0, #0xc82
40001644: 94000879     	bl	0x40003828 <uart_puts>
40001648: 17ffff03     	b	0x40001254 <execute_command+0x418>
4000164c: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001650: 9138d800     	add	x0, x0, #0xe36
40001654: 94000875     	bl	0x40003828 <uart_puts>
40001658: 17fffeff     	b	0x40001254 <execute_command+0x418>
4000165c: 910103e0     	add	x0, sp, #0x40
40001660: 940004c7     	bl	0x4000297c <kstrlen>
40001664: b4000080     	cbz	x0, 0x40001674 <execute_command+0x838>
40001668: 910103e0     	add	x0, sp, #0x40
4000166c: 9400048c     	bl	0x4000289c <script_run_file>
40001670: 17fffef9     	b	0x40001254 <execute_command+0x418>
40001674: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001678: 9113d800     	add	x0, x0, #0x4f6
4000167c: 9400086b     	bl	0x40003828 <uart_puts>
40001680: 17fffef5     	b	0x40001254 <execute_command+0x418>
40001684: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001688: 913c9c00     	add	x0, x0, #0xf27
4000168c: 94000867     	bl	0x40003828 <uart_puts>
40001690: f0ffffe8     	adrp	x8, 0x40000000 <_start>
40001694: 90000055     	adrp	x21, 0x40009000 <__rodata_start>
40001698: 911402b5     	add	x21, x21, #0x500
4000169c: 39400113     	ldrb	w19, [x8]
400016a0: d344fe68     	lsr	x8, x19, #4
400016a4: 38686aa0     	ldrb	w0, [x21, x8]
400016a8: 94000849     	bl	0x400037cc <uart_putc>
400016ac: 92400e68     	and	x8, x19, #0xf
400016b0: 38686aa0     	ldrb	w0, [x21, x8]
400016b4: 94000846     	bl	0x400037cc <uart_putc>
400016b8: 52800400     	mov	w0, #0x20               // =32
400016bc: 94000844     	bl	0x400037cc <uart_putc>
400016c0: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
400016c4: 910d2273     	add	x19, x19, #0x348
400016c8: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400016cc: 91244294     	add	x20, x20, #0x910
400016d0: 52800036     	mov	w22, #0x1               // =1
400016d4: d503201f     	nop
400016d8: 10ff4957     	adr	x23, 0x40000000 <_start>
400016dc: 1400000d     	b	0x40001710 <execute_command+0x8d4>
400016e0: 38766af8     	ldrb	w24, [x23, x22]
400016e4: d344ff08     	lsr	x8, x24, #4
400016e8: 38686aa0     	ldrb	w0, [x21, x8]
400016ec: 94000838     	bl	0x400037cc <uart_putc>
400016f0: 92400f08     	and	x8, x24, #0xf
400016f4: 38686aa0     	ldrb	w0, [x21, x8]
400016f8: 94000835     	bl	0x400037cc <uart_putc>
400016fc: 52800400     	mov	w0, #0x20               // =32
40001700: 94000833     	bl	0x400037cc <uart_putc>
40001704: 910006d6     	add	x22, x22, #0x1
40001708: f10082df     	cmp	x22, #0x20
4000170c: 54ffd780     	b.eq	0x400011fc <execute_command+0x3c0>
40001710: 72000adf     	tst	w22, #0x7
40001714: 54000061     	b.ne	0x40001720 <execute_command+0x8e4>
40001718: aa1303e0     	mov	x0, x19
4000171c: 94000843     	bl	0x40003828 <uart_puts>
40001720: 72000edf     	tst	w22, #0xf
40001724: 54fffde1     	b.ne	0x400016e0 <execute_command+0x8a4>
40001728: aa1403e0     	mov	x0, x20
4000172c: 9400083f     	bl	0x40003828 <uart_puts>
40001730: 17ffffec     	b	0x400016e0 <execute_command+0x8a4>
40001734: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001738: 91396400     	add	x0, x0, #0xe59
4000173c: 9400083b     	bl	0x40003828 <uart_puts>
40001740: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001744: 910c3c00     	add	x0, x0, #0x30f
40001748: 94000838     	bl	0x40003828 <uart_puts>
4000174c: d503207f     	wfi
40001750: 17ffffff     	b	0x4000174c <execute_command+0x910>
40001754: 97fffd08     	bl	0x40000b74 <print_android_roadmap>
40001758: 17fffebf     	b	0x40001254 <execute_command+0x418>

000000004000175c <kernel_shell>:
4000175c: d10543ff     	sub	sp, sp, #0x150
40001760: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001764: 9131b000     	add	x0, x0, #0xc6c
40001768: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
4000176c: a9106ffc     	stp	x28, x27, [sp, #0x100]
40001770: 9103c3fd     	add	x29, sp, #0xf0
40001774: a91167fa     	stp	x26, x25, [sp, #0x110]
40001778: a9125ff8     	stp	x24, x23, [sp, #0x120]
4000177c: a91357f6     	stp	x22, x21, [sp, #0x130]
40001780: a9144ff4     	stp	x20, x19, [sp, #0x140]
40001784: 94000829     	bl	0x40003828 <uart_puts>
40001788: 90000053     	adrp	x19, 0x40009000 <__rodata_start>
4000178c: 913d2e73     	add	x19, x19, #0xf4b
40001790: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40001794: 9106aa94     	add	x20, x20, #0x1aa
40001798: d0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
4000179c: 9126f6b5     	add	x21, x21, #0x9bd
400017a0: b0000056     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
400017a4: 910586d6     	add	x22, x22, #0x161
400017a8: d0000057     	adrp	x23, 0x4000b000 <__rodata_start+0x2000>
400017ac: 9128b2f7     	add	x23, x23, #0xa2c
400017b0: d0000058     	adrp	x24, 0x4000b000 <__rodata_start+0x2000>
400017b4: 9117af18     	add	x24, x24, #0x5eb
400017b8: 910123fa     	add	x26, sp, #0x48
400017bc: 90000059     	adrp	x25, 0x40009000 <__rodata_start>
400017c0: 91325f39     	add	x25, x25, #0xc97
400017c4: 910023e0     	add	x0, sp, #0x8
400017c8: 52800801     	mov	w1, #0x40               // =64
400017cc: 94000ca4     	bl	0x40004a5c <vfs_getcwd>
400017d0: 910023e1     	add	x1, sp, #0x8
400017d4: aa1303e0     	mov	x0, x19
400017d8: 94000929     	bl	0x40003c7c <uart_printf>
400017dc: aa1403e0     	mov	x0, x20
400017e0: 94000812     	bl	0x40003828 <uart_puts>
400017e4: aa1f03fc     	mov	x28, xzr
400017e8: aa1c03fb     	mov	x27, x28
400017ec: 94000843     	bl	0x400038f8 <uart_getc>
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
40001840: 940007e3     	bl	0x400037cc <uart_putc>
40001844: 17ffffe9     	b	0x400017e8 <kernel_shell+0x8c>
40001848: aa1f03fc     	mov	x28, xzr
4000184c: b4fffcfb     	cbz	x27, 0x400017e8 <kernel_shell+0x8c>
40001850: aa1503e0     	mov	x0, x21
40001854: d100077c     	sub	x28, x27, #0x1
40001858: 940007f4     	bl	0x40003828 <uart_puts>
4000185c: 17ffffe3     	b	0x400017e8 <kernel_shell+0x8c>
40001860: aa1603e0     	mov	x0, x22
40001864: 940007f1     	bl	0x40003828 <uart_puts>
40001868: 910123e0     	add	x0, sp, #0x48
4000186c: 383b6b5f     	strb	wzr, [x26, x27]
40001870: 94000443     	bl	0x4000297c <kstrlen>
40001874: b4fffa80     	cbz	x0, 0x400017c4 <kernel_shell+0x68>
40001878: 910123e0     	add	x0, sp, #0x48
4000187c: 94000343     	bl	0x40002588 <script_execute_line>
40001880: 910123e0     	add	x0, sp, #0x48
40001884: aa1703e1     	mov	x1, x23
40001888: 9400044d     	bl	0x400029bc <kstrcmp>
4000188c: 34000120     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
40001890: 910123e0     	add	x0, sp, #0x48
40001894: aa1803e1     	mov	x1, x24
40001898: 94000449     	bl	0x400029bc <kstrcmp>
4000189c: 340000a0     	cbz	w0, 0x400018b0 <kernel_shell+0x154>
400018a0: 910123e0     	add	x0, sp, #0x48
400018a4: aa1903e1     	mov	x1, x25
400018a8: 94000445     	bl	0x400029bc <kstrcmp>
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
40001908: 9400130f     	bl	0x40006544 <virtio_net_get_mac>
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
40001960: 9128f800     	add	x0, x0, #0xa3e
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
400019a4: 940007a1     	bl	0x40003828 <uart_puts>
400019a8: aa1f03f5     	mov	x21, xzr
400019ac: b0000053     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
400019b0: 9114e273     	add	x19, x19, #0x538
400019b4: 910053f6     	add	x22, sp, #0x14
400019b8: b0000054     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400019bc: 91244294     	add	x20, x20, #0x910
400019c0: 14000003     	b	0x400019cc <test_arp+0xfc>
400019c4: f100f2bf     	cmp	x21, #0x3c
400019c8: 54000140     	b.eq	0x400019f0 <test_arp+0x120>
400019cc: 38756ac1     	ldrb	w1, [x22, x21]
400019d0: aa1303e0     	mov	x0, x19
400019d4: 940008aa     	bl	0x40003c7c <uart_printf>
400019d8: 910006b5     	add	x21, x21, #0x1
400019dc: f2400ebf     	tst	x21, #0xf
400019e0: 54ffff21     	b.ne	0x400019c4 <test_arp+0xf4>
400019e4: aa1403e0     	mov	x0, x20
400019e8: 94000790     	bl	0x40003828 <uart_puts>
400019ec: 17fffff6     	b	0x400019c4 <test_arp+0xf4>
400019f0: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400019f4: 91244000     	add	x0, x0, #0x910
400019f8: 9400078c     	bl	0x40003828 <uart_puts>
400019fc: 910053e0     	add	x0, sp, #0x14
40001a00: 52800781     	mov	w1, #0x3c               // =60
40001a04: 94001279     	bl	0x400063e8 <virtio_net_send>
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
40001a38: 94000759     	bl	0x4000379c <uart_init>
40001a3c: d503201f     	nop
40001a40: 30044a80     	adr	x0, 0x4000a391 <__rodata_start+0x1391>
40001a44: 94000779     	bl	0x40003828 <uart_puts>
40001a48: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001a4c: 91168800     	add	x0, x0, #0x5a2
40001a50: 94000776     	bl	0x40003828 <uart_puts>
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
40001a84: 94000769     	bl	0x40003828 <uart_puts>
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
40001ab0: 94000a7f     	bl	0x400044ac <vfs_init>
40001ab4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001ab8: 91295400     	add	x0, x0, #0xa55
40001abc: 9400075b     	bl	0x40003828 <uart_puts>
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
40001aec: 1002e8a8     	adr	x8, 0x40007800 <exception_vector_table>
40001af0: d518c008     	msr	VBAR_EL1, x8
40001af4: 9400074d     	bl	0x40003828 <uart_puts>
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
40001b20: 91236000     	add	x0, x0, #0x8d8
40001b24: 94000741     	bl	0x40003828 <uart_puts>
40001b28: b90003ff     	str	wzr, [sp]
40001b2c: b94003e8     	ldr	w8, [sp]
40001b30: 6b13011f     	cmp	w8, w19
40001b34: 540000aa     	b.ge	0x40001b48 <kmain+0x12c>
40001b38: b94003e8     	ldr	w8, [sp]
40001b3c: 11000508     	add	w8, w8, #0x1
40001b40: b90003e8     	str	w8, [sp]
40001b44: 17fffffa     	b	0x40001b2c <kmain+0x110>
40001b48: 94000440     	bl	0x40002c48 <timer_init>
40001b4c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001b50: 912cd800     	add	x0, x0, #0xb36
40001b54: 94000735     	bl	0x40003828 <uart_puts>
40001b58: b90003ff     	str	wzr, [sp]
40001b5c: b94003e8     	ldr	w8, [sp]
40001b60: 6b13011f     	cmp	w8, w19
40001b64: 540000aa     	b.ge	0x40001b78 <kmain+0x15c>
40001b68: b94003e8     	ldr	w8, [sp]
40001b6c: 11000508     	add	w8, w8, #0x1
40001b70: b90003e8     	str	w8, [sp]
40001b74: 17fffffa     	b	0x40001b5c <kmain+0x140>
40001b78: 94000e12     	bl	0x400053c0 <pmm_init>
40001b7c: 94000ea6     	bl	0x40005614 <sched_init>
40001b80: 94000f65     	bl	0x40005914 <virtio_blk_init>
40001b84: 34000180     	cbz	w0, 0x40001bb4 <kmain+0x198>
40001b88: 910003e1     	mov	x1, sp
40001b8c: aa1f03e0     	mov	x0, xzr
40001b90: 94000fab     	bl	0x40005a3c <virtio_blk_read_sector>
40001b94: 34000080     	cbz	w0, 0x40001ba4 <kmain+0x188>
40001b98: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001b9c: 913edc00     	add	x0, x0, #0xfb7
40001ba0: 94000722     	bl	0x40003828 <uart_puts>
40001ba4: 9400127b     	bl	0x40006590 <fat16_init>
40001ba8: 94000e05     	bl	0x400053bc <vfs_load>
40001bac: 940010e0     	bl	0x40005f2c <virtio_net_init>
40001bb0: 97ffff48     	bl	0x400018d0 <test_arp>
40001bb4: 529e1013     	mov	w19, #0xf080            // =61568
40001bb8: d503201f     	nop
40001bbc: 10ff6820     	adr	x0, 0x400008c0 <system_idle_daemon>
40001bc0: 72a05f53     	movk	w19, #0x2fa, lsl #16
40001bc4: 94000ebb     	bl	0x400056b0 <sched_create_task>
40001bc8: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001bcc: 911b6000     	add	x0, x0, #0x6d8
40001bd0: 94000716     	bl	0x40003828 <uart_puts>
40001bd4: d50342ff     	msr	DAIFClr, #0x2
40001bd8: b90003ff     	str	wzr, [sp]
40001bdc: b94003e8     	ldr	w8, [sp]
40001be0: 6b13011f     	cmp	w8, w19
40001be4: 54ffffaa     	b.ge	0x40001bd8 <kmain+0x1bc>
40001be8: b94003e8     	ldr	w8, [sp]
40001bec: 11000508     	add	w8, w8, #0x1
40001bf0: b90003e8     	str	w8, [sp]
40001bf4: 17fffffa     	b	0x40001bdc <kmain+0x1c0>

0000000040001bf8 <kproj_execute>:
40001bf8: d10683ff     	sub	sp, sp, #0x1a0
40001bfc: a9187bfd     	stp	x29, x30, [sp, #0x180]
40001c00: 910603fd     	add	x29, sp, #0x180
40001c04: a9194ffc     	stp	x28, x19, [sp, #0x190]
40001c08: b40001c0     	cbz	x0, 0x40001c40 <kproj_execute+0x48>
40001c0c: aa0003f3     	mov	x19, x0
40001c10: 9400035b     	bl	0x4000297c <kstrlen>
40001c14: b4000160     	cbz	x0, 0x40001c40 <kproj_execute+0x48>
40001c18: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001c1c: 9129c000     	add	x0, x0, #0xa70
40001c20: aa1303e1     	mov	x1, x19
40001c24: 94000816     	bl	0x40003c7c <uart_printf>
40001c28: aa1303e0     	mov	x0, x19
40001c2c: 94000c65     	bl	0x40004dc0 <vfs_mkdir>
40001c30: 34000140     	cbz	w0, 0x40001c58 <kproj_execute+0x60>
40001c34: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001c38: 9128c400     	add	x0, x0, #0xa31
40001c3c: 14000003     	b	0x40001c48 <kproj_execute+0x50>
40001c40: d503201f     	nop
40001c44: 1004ce60     	adr	x0, 0x4000b610 <__rodata_start+0x2610>
40001c48: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001c4c: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001c50: 910683ff     	add	sp, sp, #0x1a0
40001c54: 140006f5     	b	0x40003828 <uart_puts>
40001c58: aa1303e0     	mov	x0, x19
40001c5c: 94000c34     	bl	0x40004d2c <vfs_chdir>
40001c60: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001c64: 91071c00     	add	x0, x0, #0x1c7
40001c68: 94000c56     	bl	0x40004dc0 <vfs_mkdir>
40001c6c: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001c70: 91225400     	add	x0, x0, #0x895
40001c74: 94000c53     	bl	0x40004dc0 <vfs_mkdir>
40001c78: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001c7c: 9109a421     	add	x1, x1, #0x269
40001c80: 910203e0     	add	x0, sp, #0x80
40001c84: 9400036d     	bl	0x40002a38 <kstrcpy>
40001c88: 910203e0     	add	x0, sp, #0x80
40001c8c: aa1303e1     	mov	x1, x19
40001c90: 94000342     	bl	0x40002998 <kstrcat>
40001c94: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001c98: 913fd021     	add	x1, x1, #0xff4
40001c9c: 910203e0     	add	x0, sp, #0x80
40001ca0: 9400033e     	bl	0x40002998 <kstrcat>
40001ca4: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001ca8: 91263400     	add	x0, x0, #0x98d
40001cac: 910203e1     	add	x1, sp, #0x80
40001cb0: 94000c9a     	bl	0x40004f18 <vfs_touch>
40001cb4: d0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40001cb8: 910cd400     	add	x0, x0, #0x335
40001cbc: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001cc0: 91327021     	add	x1, x1, #0xc9c
40001cc4: 94000c95     	bl	0x40004f18 <vfs_touch>
40001cc8: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001ccc: 910c1021     	add	x1, x1, #0x304
40001cd0: 910003e0     	mov	x0, sp
40001cd4: 94000359     	bl	0x40002a38 <kstrcpy>
40001cd8: 910003e0     	mov	x0, sp
40001cdc: aa1303e1     	mov	x1, x19
40001ce0: 9400032e     	bl	0x40002998 <kstrcat>
40001ce4: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001ce8: 912d6021     	add	x1, x1, #0xb58
40001cec: 910003e0     	mov	x0, sp
40001cf0: 9400032a     	bl	0x40002998 <kstrcat>
40001cf4: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001cf8: 91008000     	add	x0, x0, #0x20
40001cfc: 910003e1     	mov	x1, sp
40001d00: 94000c86     	bl	0x40004f18 <vfs_touch>
40001d04: 94000c84     	bl	0x40004f14 <vfs_sync>
40001d08: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001d0c: 91144400     	add	x0, x0, #0x511
40001d10: 940006c6     	bl	0x40003828 <uart_puts>
40001d14: 90000040     	adrp	x0, 0x40009000 <__rodata_start>
40001d18: 91150000     	add	x0, x0, #0x540
40001d1c: aa1303e1     	mov	x1, x19
40001d20: 940007d7     	bl	0x40003c7c <uart_printf>
40001d24: b0000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40001d28: 91072c00     	add	x0, x0, #0x1cb
40001d2c: 94000c00     	bl	0x40004d2c <vfs_chdir>
40001d30: a9594ffc     	ldp	x28, x19, [sp, #0x190]
40001d34: a9587bfd     	ldp	x29, x30, [sp, #0x180]
40001d38: 910683ff     	add	sp, sp, #0x1a0
40001d3c: d65f03c0     	ret

0000000040001d40 <process_init>:
40001d40: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40001d44: a9024ff4     	stp	x20, x19, [sp, #0x20]
40001d48: f0000054     	adrp	x20, 0x4000c000 <next_pid>
40001d4c: d503201f     	nop
40001d50: 10072833     	adr	x19, 0x40010254 <proc_table>
40001d54: b9400289     	ldr	w9, [x20]
40001d58: 52800068     	mov	w8, #0x3                // =3
40001d5c: b9002668     	str	w8, [x19, #0x24]
40001d60: d503201f     	nop
40001d64: 700470e1     	adr	x1, 0x4000ab83 <__rodata_start+0x1b83>
40001d68: b9005668     	str	w8, [x19, #0x54]
40001d6c: 91001260     	add	x0, x19, #0x4
40001d70: 910003fd     	mov	x29, sp
40001d74: b9008668     	str	w8, [x19, #0x84]
40001d78: b900b668     	str	w8, [x19, #0xb4]
40001d7c: b900e668     	str	w8, [x19, #0xe4]
40001d80: b9011668     	str	w8, [x19, #0x114]
40001d84: b9014668     	str	w8, [x19, #0x144]
40001d88: b9017668     	str	w8, [x19, #0x174]
40001d8c: b901a668     	str	w8, [x19, #0x1a4]
40001d90: b901d668     	str	w8, [x19, #0x1d4]
40001d94: b9020668     	str	w8, [x19, #0x204]
40001d98: b9023668     	str	w8, [x19, #0x234]
40001d9c: b9026668     	str	w8, [x19, #0x264]
40001da0: b9029668     	str	w8, [x19, #0x294]
40001da4: b902c668     	str	w8, [x19, #0x2c4]
40001da8: b902f668     	str	w8, [x19, #0x2f4]
40001dac: 11000528     	add	w8, w9, #0x1
40001db0: f9000bf5     	str	x21, [sp, #0x10]
40001db4: b900327f     	str	wzr, [x19, #0x30]
40001db8: b900627f     	str	wzr, [x19, #0x60]
40001dbc: b900927f     	str	wzr, [x19, #0x90]
40001dc0: b900c27f     	str	wzr, [x19, #0xc0]
40001dc4: b900f27f     	str	wzr, [x19, #0xf0]
40001dc8: b901227f     	str	wzr, [x19, #0x120]
40001dcc: b901527f     	str	wzr, [x19, #0x150]
40001dd0: b901827f     	str	wzr, [x19, #0x180]
40001dd4: b901b27f     	str	wzr, [x19, #0x1b0]
40001dd8: b901e27f     	str	wzr, [x19, #0x1e0]
40001ddc: b902127f     	str	wzr, [x19, #0x210]
40001de0: b902427f     	str	wzr, [x19, #0x240]
40001de4: b902727f     	str	wzr, [x19, #0x270]
40001de8: b902a27f     	str	wzr, [x19, #0x2a0]
40001dec: b902d27f     	str	wzr, [x19, #0x2d0]
40001df0: b9000288     	str	w8, [x20]
40001df4: b9000269     	str	w9, [x19]
40001df8: 94000310     	bl	0x40002a38 <kstrcpy>
40001dfc: b9400288     	ldr	w8, [x20]
40001e00: 52a00209     	mov	w9, #0x100000           // =1048576
40001e04: 5280384a     	mov	w10, #0x1c2             // =450
40001e08: 2904a67f     	stp	wzr, w9, [x19, #0x24]
40001e0c: d0000041     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40001e10: 9129a821     	add	x1, x1, #0xa6a
40001e14: 11000509     	add	w9, w8, #0x1
40001e18: 9100d260     	add	x0, x19, #0x34
40001e1c: 2905a26a     	stp	w10, w8, [x19, #0x2c]
40001e20: b9000289     	str	w9, [x20]
40001e24: 94000305     	bl	0x40002a38 <kstrcpy>
40001e28: b9400288     	ldr	w8, [x20]
40001e2c: 529d0009     	mov	w9, #0xe800             // =59392
40001e30: 52800035     	mov	w21, #0x1               // =1
40001e34: 72a00069     	movk	w9, #0x3, lsl #16
40001e38: 5280018a     	mov	w10, #0xc               // =12
40001e3c: 90000041     	adrp	x1, 0x40009000 <__rodata_start>
40001e40: 912de821     	add	x1, x1, #0xb7a
40001e44: 290aa675     	stp	w21, w9, [x19, #0x54]
40001e48: 11000509     	add	w9, w8, #0x1
40001e4c: 91019260     	add	x0, x19, #0x64
40001e50: b9000289     	str	w9, [x20]
40001e54: 290ba26a     	stp	w10, w8, [x19, #0x5c]
40001e58: 940002f8     	bl	0x40002a38 <kstrcpy>
40001e5c: b9400288     	ldr	w8, [x20]
40001e60: 52a00809     	mov	w9, #0x400000           // =4194304
40001e64: 5280960a     	mov	w10, #0x4b0             // =1200
40001e68: 2910a675     	stp	w21, w9, [x19, #0x84]
40001e6c: b0000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40001e70: 9114f021     	add	x1, x1, #0x53c
40001e74: 11000509     	add	w9, w8, #0x1
40001e78: 91025260     	add	x0, x19, #0x94
40001e7c: 2911a26a     	stp	w10, w8, [x19, #0x8c]
40001e80: b9000289     	str	w9, [x20]
40001e84: 940002ed     	bl	0x40002a38 <kstrcpy>
40001e88: 529a0008     	mov	w8, #0xd000             // =53248
40001e8c: 52800aa9     	mov	w9, #0x55               // =85
40001e90: f9400bf5     	ldr	x21, [sp, #0x10]
40001e94: 72a000e8     	movk	w8, #0x7, lsl #16
40001e98: b900be69     	str	w9, [x19, #0xbc]
40001e9c: 2916a27f     	stp	wzr, w8, [x19, #0xb4]
40001ea0: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40001ea4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40001ea8: d65f03c0     	ret

0000000040001eac <process_kill>:
40001eac: 7100041f     	cmp	w0, #0x1
40001eb0: 5400118b     	b.lt	0x400020e0 <process_kill+0x234>
40001eb4: d503201f     	nop
40001eb8: 10071ce9     	adr	x9, 0x40010254 <proc_table>
40001ebc: b9400128     	ldr	w8, [x9]
40001ec0: 6b00011f     	cmp	w8, w0
40001ec4: 54000081     	b.ne	0x40001ed4 <process_kill+0x28>
40001ec8: b9402528     	ldr	w8, [x9, #0x24]
40001ecc: 71000d1f     	cmp	w8, #0x3
40001ed0: 54000f41     	b.ne	0x400020b8 <process_kill+0x20c>
40001ed4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001ed8: 910a1129     	add	x9, x9, #0x284
40001edc: b9400128     	ldr	w8, [x9]
40001ee0: 6b00011f     	cmp	w8, w0
40001ee4: 54000081     	b.ne	0x40001ef4 <process_kill+0x48>
40001ee8: b9402528     	ldr	w8, [x9, #0x24]
40001eec: 71000d1f     	cmp	w8, #0x3
40001ef0: 54000e41     	b.ne	0x400020b8 <process_kill+0x20c>
40001ef4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001ef8: 910ad129     	add	x9, x9, #0x2b4
40001efc: b9400128     	ldr	w8, [x9]
40001f00: 6b00011f     	cmp	w8, w0
40001f04: 54000081     	b.ne	0x40001f14 <process_kill+0x68>
40001f08: b9402528     	ldr	w8, [x9, #0x24]
40001f0c: 71000d1f     	cmp	w8, #0x3
40001f10: 54000d41     	b.ne	0x400020b8 <process_kill+0x20c>
40001f14: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f18: 910b9129     	add	x9, x9, #0x2e4
40001f1c: b9400128     	ldr	w8, [x9]
40001f20: 6b00011f     	cmp	w8, w0
40001f24: 54000081     	b.ne	0x40001f34 <process_kill+0x88>
40001f28: b9402528     	ldr	w8, [x9, #0x24]
40001f2c: 71000d1f     	cmp	w8, #0x3
40001f30: 54000c41     	b.ne	0x400020b8 <process_kill+0x20c>
40001f34: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f38: 910c5129     	add	x9, x9, #0x314
40001f3c: b9400128     	ldr	w8, [x9]
40001f40: 6b00011f     	cmp	w8, w0
40001f44: 54000081     	b.ne	0x40001f54 <process_kill+0xa8>
40001f48: b9402528     	ldr	w8, [x9, #0x24]
40001f4c: 71000d1f     	cmp	w8, #0x3
40001f50: 54000b41     	b.ne	0x400020b8 <process_kill+0x20c>
40001f54: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f58: 910d1129     	add	x9, x9, #0x344
40001f5c: b9400128     	ldr	w8, [x9]
40001f60: 6b00011f     	cmp	w8, w0
40001f64: 54000081     	b.ne	0x40001f74 <process_kill+0xc8>
40001f68: b9402528     	ldr	w8, [x9, #0x24]
40001f6c: 71000d1f     	cmp	w8, #0x3
40001f70: 54000a41     	b.ne	0x400020b8 <process_kill+0x20c>
40001f74: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f78: 910dd129     	add	x9, x9, #0x374
40001f7c: b9400128     	ldr	w8, [x9]
40001f80: 6b00011f     	cmp	w8, w0
40001f84: 54000081     	b.ne	0x40001f94 <process_kill+0xe8>
40001f88: b9402528     	ldr	w8, [x9, #0x24]
40001f8c: 71000d1f     	cmp	w8, #0x3
40001f90: 54000941     	b.ne	0x400020b8 <process_kill+0x20c>
40001f94: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001f98: 910e9129     	add	x9, x9, #0x3a4
40001f9c: b9400128     	ldr	w8, [x9]
40001fa0: 6b00011f     	cmp	w8, w0
40001fa4: 54000081     	b.ne	0x40001fb4 <process_kill+0x108>
40001fa8: b9402528     	ldr	w8, [x9, #0x24]
40001fac: 71000d1f     	cmp	w8, #0x3
40001fb0: 54000841     	b.ne	0x400020b8 <process_kill+0x20c>
40001fb4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001fb8: 910f5129     	add	x9, x9, #0x3d4
40001fbc: b9400128     	ldr	w8, [x9]
40001fc0: 6b00011f     	cmp	w8, w0
40001fc4: 54000081     	b.ne	0x40001fd4 <process_kill+0x128>
40001fc8: b9402528     	ldr	w8, [x9, #0x24]
40001fcc: 71000d1f     	cmp	w8, #0x3
40001fd0: 54000741     	b.ne	0x400020b8 <process_kill+0x20c>
40001fd4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001fd8: 91101129     	add	x9, x9, #0x404
40001fdc: b9400128     	ldr	w8, [x9]
40001fe0: 6b00011f     	cmp	w8, w0
40001fe4: 54000081     	b.ne	0x40001ff4 <process_kill+0x148>
40001fe8: b9402528     	ldr	w8, [x9, #0x24]
40001fec: 71000d1f     	cmp	w8, #0x3
40001ff0: 54000641     	b.ne	0x400020b8 <process_kill+0x20c>
40001ff4: f0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40001ff8: 9110d129     	add	x9, x9, #0x434
40001ffc: b9400128     	ldr	w8, [x9]
40002000: 6b00011f     	cmp	w8, w0
40002004: 54000081     	b.ne	0x40002014 <process_kill+0x168>
40002008: b9402528     	ldr	w8, [x9, #0x24]
4000200c: 71000d1f     	cmp	w8, #0x3
40002010: 54000541     	b.ne	0x400020b8 <process_kill+0x20c>
40002014: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40002018: 91119129     	add	x9, x9, #0x464
4000201c: b9400128     	ldr	w8, [x9]
40002020: 6b00011f     	cmp	w8, w0
40002024: 54000081     	b.ne	0x40002034 <process_kill+0x188>
40002028: b9402528     	ldr	w8, [x9, #0x24]
4000202c: 71000d1f     	cmp	w8, #0x3
40002030: 54000441     	b.ne	0x400020b8 <process_kill+0x20c>
40002034: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40002038: 91125129     	add	x9, x9, #0x494
4000203c: b9400128     	ldr	w8, [x9]
40002040: 6b00011f     	cmp	w8, w0
40002044: 54000081     	b.ne	0x40002054 <process_kill+0x1a8>
40002048: b9402528     	ldr	w8, [x9, #0x24]
4000204c: 71000d1f     	cmp	w8, #0x3
40002050: 54000341     	b.ne	0x400020b8 <process_kill+0x20c>
40002054: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40002058: 91131129     	add	x9, x9, #0x4c4
4000205c: b9400128     	ldr	w8, [x9]
40002060: 6b00011f     	cmp	w8, w0
40002064: 54000081     	b.ne	0x40002074 <process_kill+0x1c8>
40002068: b9402528     	ldr	w8, [x9, #0x24]
4000206c: 71000d1f     	cmp	w8, #0x3
40002070: 54000241     	b.ne	0x400020b8 <process_kill+0x20c>
40002074: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40002078: 9113d129     	add	x9, x9, #0x4f4
4000207c: b9400128     	ldr	w8, [x9]
40002080: 6b00011f     	cmp	w8, w0
40002084: 54000081     	b.ne	0x40002094 <process_kill+0x1e8>
40002088: b9402528     	ldr	w8, [x9, #0x24]
4000208c: 71000d1f     	cmp	w8, #0x3
40002090: 54000141     	b.ne	0x400020b8 <process_kill+0x20c>
40002094: d0000069     	adrp	x9, 0x40010000 <__bss_start+0x3000>
40002098: 91149129     	add	x9, x9, #0x524
4000209c: b9400128     	ldr	w8, [x9]
400020a0: 6b00011f     	cmp	w8, w0
400020a4: 12800008     	mov	w8, #-0x1               // =-1
400020a8: 54000281     	b.ne	0x400020f8 <process_kill+0x24c>
400020ac: b940252a     	ldr	w10, [x9, #0x24]
400020b0: 71000d5f     	cmp	w10, #0x3
400020b4: 54000220     	b.eq	0x400020f8 <process_kill+0x24c>
400020b8: 7100041f     	cmp	w0, #0x1
400020bc: 54000161     	b.ne	0x400020e8 <process_kill+0x23c>
400020c0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400020c4: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
400020c8: 912a8400     	add	x0, x0, #0xaa1
400020cc: 910003fd     	mov	x29, sp
400020d0: 940005d6     	bl	0x40003828 <uart_puts>
400020d4: 12800020     	mov	w0, #-0x2               // =-2
400020d8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400020dc: d65f03c0     	ret
400020e0: 12800000     	mov	w0, #-0x1               // =-1
400020e4: d65f03c0     	ret
400020e8: 5280004a     	mov	w10, #0x2               // =2
400020ec: 2a1f03e0     	mov	w0, wzr
400020f0: b900252a     	str	w10, [x9, #0x24]
400020f4: d65f03c0     	ret
400020f8: 2a0803e0     	mov	w0, w8
400020fc: d65f03c0     	ret

0000000040002100 <launch_ktop>:
40002100: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002104: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002108: 91218400     	add	x0, x0, #0x861
4000210c: f9000bf7     	str	x23, [sp, #0x10]
40002110: a90257f6     	stp	x22, x21, [sp, #0x20]
40002114: 910003fd     	mov	x29, sp
40002118: a9034ff4     	stp	x20, x19, [sp, #0x30]
4000211c: 940005c3     	bl	0x40003828 <uart_puts>
40002120: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002124: 912a8800     	add	x0, x0, #0xaa2
40002128: 940005c0     	bl	0x40003828 <uart_puts>
4000212c: 2a1f03e8     	mov	w8, wzr
40002130: 2a1f03e1     	mov	w1, wzr
40002134: 52800209     	mov	w9, #0x10               // =16
40002138: d000006a     	adrp	x10, 0x40010000 <__bss_start+0x3000>
4000213c: 9109f14a     	add	x10, x10, #0x27c
40002140: 14000004     	b	0x40002150 <launch_ktop+0x50>
40002144: f1000529     	subs	x9, x9, #0x1
40002148: 9100c14a     	add	x10, x10, #0x30
4000214c: 54000120     	b.eq	0x40002170 <launch_ktop+0x70>
40002150: b85fc14b     	ldur	w11, [x10, #-0x4]
40002154: 121f796b     	and	w11, w11, #0xfffffffe
40002158: 7100097f     	cmp	w11, #0x2
4000215c: 54ffff40     	b.eq	0x40002144 <launch_ktop+0x44>
40002160: b940014b     	ldr	w11, [x10]
40002164: 11000421     	add	w1, w1, #0x1
40002168: 0b080168     	add	w8, w11, w8
4000216c: 17fffff6     	b	0x40002144 <launch_ktop+0x44>
40002170: 530a7d02     	lsr	w2, w8, #10
40002174: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002178: 912e1000     	add	x0, x0, #0xb84
4000217c: 940006c0     	bl	0x40003c7c <uart_printf>
40002180: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002184: 9132f000     	add	x0, x0, #0xcbc
40002188: 940005a8     	bl	0x40003828 <uart_puts>
4000218c: b0000040     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40002190: 9100d800     	add	x0, x0, #0x36
40002194: 940005a5     	bl	0x40003828 <uart_puts>
40002198: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
4000219c: 910a0294     	add	x20, x20, #0x280
400021a0: b0000055     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
400021a4: 9106c2b5     	add	x21, x21, #0x1b0
400021a8: d503201f     	nop
400021ac: 1004c776     	adr	x22, 0x4000ba98 <__rodata_start+0x2a98>
400021b0: 52800217     	mov	w23, #0x10              // =16
400021b4: 90000053     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
400021b8: 911b5e73     	add	x19, x19, #0x6d7
400021bc: 1400000a     	b	0x400021e4 <launch_ktop+0xe4>
400021c0: 297f9288     	ldp	w8, w4, [x20, #-0x4]
400021c4: b85d4281     	ldur	w1, [x20, #-0x2c]
400021c8: d100a285     	sub	x5, x20, #0x28
400021cc: aa1303e0     	mov	x0, x19
400021d0: 530a7d03     	lsr	w3, w8, #10
400021d4: 940006aa     	bl	0x40003c7c <uart_printf>
400021d8: f10006f7     	subs	x23, x23, #0x1
400021dc: 9100c294     	add	x20, x20, #0x30
400021e0: 54000120     	b.eq	0x40002204 <launch_ktop+0x104>
400021e4: b85f8288     	ldur	w8, [x20, #-0x8]
400021e8: 71000d1f     	cmp	w8, #0x3
400021ec: 54ffff60     	b.eq	0x400021d8 <launch_ktop+0xd8>
400021f0: 7100091f     	cmp	w8, #0x2
400021f4: aa1503e2     	mov	x2, x21
400021f8: 54fffe48     	b.hi	0x400021c0 <launch_ktop+0xc0>
400021fc: f8687ac2     	ldr	x2, [x22, x8, lsl #3]
40002200: 17fffff0     	b	0x400021c0 <launch_ktop+0xc0>
40002204: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002208: 910c1c00     	add	x0, x0, #0x307
4000220c: 94000587     	bl	0x40003828 <uart_puts>
40002210: 52808114     	mov	w20, #0x408             // =1032
40002214: 52800033     	mov	w19, #0x1               // =1
40002218: 72a02014     	movk	w20, #0x100, lsl #16
4000221c: 14000003     	b	0x40002228 <launch_ktop+0x128>
40002220: 7101c51f     	cmp	w8, #0x71
40002224: 54000100     	b.eq	0x40002244 <launch_ktop+0x144>
40002228: 940005b4     	bl	0x400038f8 <uart_getc>
4000222c: 12001c08     	and	w8, w0, #0xff
40002230: 7100611f     	cmp	w8, #0x18
40002234: 54ffff68     	b.hi	0x40002220 <launch_ktop+0x120>
40002238: 1ac82269     	lsl	w9, w19, w8
4000223c: 6a14013f     	tst	w9, w20
40002240: 54ffff00     	b.eq	0x40002220 <launch_ktop+0x120>
40002244: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002248: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000224c: 912edc00     	add	x0, x0, #0xbb7
40002250: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002254: f9400bf7     	ldr	x23, [sp, #0x10]
40002258: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000225c: 14000573     	b	0x40003828 <uart_puts>

0000000040002260 <script_init>:
40002260: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
40002264: d0000068     	adrp	x8, 0x40010000 <__bss_start+0x3000>
40002268: d503201f     	nop
4000226c: 5003d460     	adr	x0, 0x40009cfa <__rodata_start+0xcfa>
40002270: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40002274: 9132bc21     	add	x1, x1, #0xcaf
40002278: 910003fd     	mov	x29, sp
4000227c: b905551f     	str	wzr, [x8, #0x554]
40002280: 94000007     	bl	0x4000229c <script_set_var>
40002284: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40002288: 913da800     	add	x0, x0, #0xf6a
4000228c: 90000041     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
40002290: 91226c21     	add	x1, x1, #0x89b
40002294: a8c17bfd     	ldp	x29, x30, [sp], #0x10
40002298: 14000001     	b	0x4000229c <script_set_var>

000000004000229c <script_set_var>:
4000229c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400022a0: a9015ff8     	stp	x24, x23, [sp, #0x10]
400022a4: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
400022a8: 910003fd     	mov	x29, sp
400022ac: b94556e8     	ldr	w8, [x23, #0x554]
400022b0: a9034ff4     	stp	x20, x19, [sp, #0x30]
400022b4: aa0103f3     	mov	x19, x1
400022b8: aa0003f4     	mov	x20, x0
400022bc: a90257f6     	stp	x22, x21, [sp, #0x20]
400022c0: 7100051f     	cmp	w8, #0x1
400022c4: 5400024b     	b.lt	0x4000230c <script_set_var+0x70>
400022c8: aa1f03f8     	mov	x24, xzr
400022cc: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400022d0: 912562b5     	add	x21, x21, #0x958
400022d4: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
400022d8: 911562d6     	add	x22, x22, #0x558
400022dc: aa1603e0     	mov	x0, x22
400022e0: aa1403e1     	mov	x1, x20
400022e4: 940001b6     	bl	0x400029bc <kstrcmp>
400022e8: 340003e0     	cbz	w0, 0x40002364 <script_set_var+0xc8>
400022ec: b98556e8     	ldrsw	x8, [x23, #0x554]
400022f0: 91000718     	add	x24, x24, #0x1
400022f4: 910202b5     	add	x21, x21, #0x80
400022f8: 910082d6     	add	x22, x22, #0x20
400022fc: eb08031f     	cmp	x24, x8
40002300: 54fffeeb     	b.lt	0x400022dc <script_set_var+0x40>
40002304: 71007d1f     	cmp	w8, #0x1f
40002308: 5400038c     	b.gt	0x40002378 <script_set_var+0xdc>
4000230c: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
40002310: 911562b5     	add	x21, x21, #0x558
40002314: aa1403e1     	mov	x1, x20
40002318: 93407d08     	sxtw	x8, w8
4000231c: 528003e2     	mov	w2, #0x1f               // =31
40002320: 8b0816a0     	add	x0, x21, x8, lsl #5
40002324: 940001cc     	bl	0x40002a54 <kstrncpy>
40002328: b98556e8     	ldrsw	x8, [x23, #0x554]
4000232c: d0000074     	adrp	x20, 0x40010000 <__bss_start+0x3000>
40002330: 91256294     	add	x20, x20, #0x958
40002334: aa1303e1     	mov	x1, x19
40002338: 52800fe2     	mov	w2, #0x7f               // =127
4000233c: 8b0816a9     	add	x9, x21, x8, lsl #5
40002340: 8b081e80     	add	x0, x20, x8, lsl #7
40002344: 39007d3f     	strb	wzr, [x9, #0x1f]
40002348: 940001c3     	bl	0x40002a54 <kstrncpy>
4000234c: b98556e8     	ldrsw	x8, [x23, #0x554]
40002350: 8b081e89     	add	x9, x20, x8, lsl #7
40002354: 11000508     	add	w8, w8, #0x1
40002358: b90556e8     	str	w8, [x23, #0x554]
4000235c: 3901fd3f     	strb	wzr, [x9, #0x7f]
40002360: 14000006     	b	0x40002378 <script_set_var+0xdc>
40002364: aa1503e0     	mov	x0, x21
40002368: aa1303e1     	mov	x1, x19
4000236c: 52800fe2     	mov	w2, #0x7f               // =127
40002370: 940001b9     	bl	0x40002a54 <kstrncpy>
40002374: 3901febf     	strb	wzr, [x21, #0x7f]
40002378: a9434ff4     	ldp	x20, x19, [sp, #0x30]
4000237c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002380: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002384: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40002388: d65f03c0     	ret

000000004000238c <script_get_var>:
4000238c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40002390: a90257f6     	stp	x22, x21, [sp, #0x20]
40002394: d0000076     	adrp	x22, 0x40010000 <__bss_start+0x3000>
40002398: 910003fd     	mov	x29, sp
4000239c: b94556c8     	ldr	w8, [x22, #0x554]
400023a0: a9015ff8     	stp	x24, x23, [sp, #0x10]
400023a4: a9034ff4     	stp	x20, x19, [sp, #0x30]
400023a8: 7100051f     	cmp	w8, #0x1
400023ac: 540002ab     	b.lt	0x40002400 <script_get_var+0x74>
400023b0: aa0003f4     	mov	x20, x0
400023b4: aa1f03f7     	mov	x23, xzr
400023b8: d0000073     	adrp	x19, 0x40010000 <__bss_start+0x3000>
400023bc: 91256273     	add	x19, x19, #0x958
400023c0: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400023c4: 911562b5     	add	x21, x21, #0x558
400023c8: f0000038     	adrp	x24, 0x40009000 <__rodata_start>
400023cc: 91265718     	add	x24, x24, #0x995
400023d0: aa1503e0     	mov	x0, x21
400023d4: aa1403e1     	mov	x1, x20
400023d8: 94000179     	bl	0x400029bc <kstrcmp>
400023dc: 34000160     	cbz	w0, 0x40002408 <script_get_var+0x7c>
400023e0: b98556c8     	ldrsw	x8, [x22, #0x554]
400023e4: 910006f7     	add	x23, x23, #0x1
400023e8: 91020273     	add	x19, x19, #0x80
400023ec: 910082b5     	add	x21, x21, #0x20
400023f0: eb0802ff     	cmp	x23, x8
400023f4: 54fffeeb     	b.lt	0x400023d0 <script_get_var+0x44>
400023f8: aa1803f3     	mov	x19, x24
400023fc: 14000003     	b	0x40002408 <script_get_var+0x7c>
40002400: f0000033     	adrp	x19, 0x40009000 <__rodata_start>
40002404: 91265673     	add	x19, x19, #0x995
40002408: aa1303e0     	mov	x0, x19
4000240c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40002410: a94257f6     	ldp	x22, x21, [sp, #0x20]
40002414: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40002418: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000241c: d65f03c0     	ret

0000000040002420 <script_expand_vars>:
40002420: d10203ff     	sub	sp, sp, #0x80
40002424: a9036ffc     	stp	x28, x27, [sp, #0x30]
40002428: 2a1f03fc     	mov	w28, wzr
4000242c: a90467fa     	stp	x26, x25, [sp, #0x40]
40002430: f0000039     	adrp	x25, 0x40009000 <__rodata_start>
40002434: 91265739     	add	x25, x25, #0x995
40002438: a9055ff8     	stp	x24, x23, [sp, #0x50]
4000243c: 910003f8     	mov	x24, sp
40002440: d000007a     	adrp	x26, 0x40010000 <__bss_start+0x3000>
40002444: a90657f6     	stp	x22, x21, [sp, #0x60]
40002448: 2a1f03f6     	mov	w22, wzr
4000244c: a9074ff4     	stp	x20, x19, [sp, #0x70]
40002450: aa0103f3     	mov	x19, x1
40002454: aa0003f4     	mov	x20, x0
40002458: a9027bfd     	stp	x29, x30, [sp, #0x20]
4000245c: 910083fd     	add	x29, sp, #0x20
40002460: 14000001     	b	0x40002464 <script_expand_vars+0x44>
40002464: 93407f89     	sxtw	x9, w28
40002468: 38696a88     	ldrb	w8, [x20, x9]
4000246c: 7100911f     	cmp	w8, #0x24
40002470: 540000e0     	b.eq	0x4000248c <script_expand_vars+0x6c>
40002474: 34000788     	cbz	w8, 0x40002564 <script_expand_vars+0x144>
40002478: 110006ca     	add	w10, w22, #0x1
4000247c: 3836ca68     	strb	w8, [x19, w22, sxtw]
40002480: 1100053c     	add	w28, w9, #0x1
40002484: 2a0a03f6     	mov	w22, w10
40002488: 17fffff7     	b	0x40002464 <script_expand_vars+0x44>
4000248c: aa1f03e8     	mov	x8, xzr
40002490: 14000005     	b	0x400024a4 <script_expand_vars+0x84>
40002494: 9100050a     	add	x10, x8, #0x1
40002498: 38286b09     	strb	w9, [x24, x8]
4000249c: d1000789     	sub	x9, x28, #0x1
400024a0: aa0a03e8     	mov	x8, x10
400024a4: 9100053c     	add	x28, x9, #0x1
400024a8: 14000004     	b	0x400024b8 <script_expand_vars+0x98>
400024ac: f100791f     	cmp	x8, #0x1e
400024b0: 9100079c     	add	x28, x28, #0x1
400024b4: 54ffff09     	b.ls	0x40002494 <script_expand_vars+0x74>
400024b8: 387c6a89     	ldrb	w9, [x20, x28]
400024bc: 121a792a     	and	w10, w9, #0xffffffdf
400024c0: 5101054a     	sub	w10, w10, #0x41
400024c4: 7100695f     	cmp	w10, #0x1a
400024c8: 54ffff23     	b.lo	0x400024ac <script_expand_vars+0x8c>
400024cc: 71017d3f     	cmp	w9, #0x5f
400024d0: 54fffee0     	b.eq	0x400024ac <script_expand_vars+0x8c>
400024d4: 5100c12a     	sub	w10, w9, #0x30
400024d8: 7100255f     	cmp	w10, #0x9
400024dc: 54fffe89     	b.ls	0x400024ac <script_expand_vars+0x8c>
400024e0: b9455749     	ldr	w9, [x26, #0x554]
400024e4: 38286b1f     	strb	wzr, [x24, x8]
400024e8: 7100053f     	cmp	w9, #0x1
400024ec: 5400028b     	b.lt	0x4000253c <script_expand_vars+0x11c>
400024f0: aa1f03fb     	mov	x27, xzr
400024f4: d0000075     	adrp	x21, 0x40010000 <__bss_start+0x3000>
400024f8: 911562b5     	add	x21, x21, #0x558
400024fc: d0000077     	adrp	x23, 0x40010000 <__bss_start+0x3000>
40002500: 912562f7     	add	x23, x23, #0x958
40002504: 910003e1     	mov	x1, sp
40002508: aa1503e0     	mov	x0, x21
4000250c: 9400012c     	bl	0x400029bc <kstrcmp>
40002510: 34000100     	cbz	w0, 0x40002530 <script_expand_vars+0x110>
40002514: b9855748     	ldrsw	x8, [x26, #0x554]
40002518: 9100077b     	add	x27, x27, #0x1
4000251c: 910202f7     	add	x23, x23, #0x80
40002520: 910082b5     	add	x21, x21, #0x20
40002524: eb08037f     	cmp	x27, x8
40002528: 54fffeeb     	b.lt	0x40002504 <script_expand_vars+0xe4>
4000252c: aa1903f7     	mov	x23, x25
40002530: 394002e8     	ldrb	w8, [x23]
40002534: 350000a8     	cbnz	w8, 0x40002548 <script_expand_vars+0x128>
40002538: 17ffffcb     	b	0x40002464 <script_expand_vars+0x44>
4000253c: aa1903f7     	mov	x23, x25
40002540: 394002e8     	ldrb	w8, [x23]
40002544: 34fff908     	cbz	w8, 0x40002464 <script_expand_vars+0x44>
40002548: 8b36c269     	add	x9, x19, w22, sxtw
4000254c: 910006ea     	add	x10, x23, #0x1
40002550: 38001528     	strb	w8, [x9], #0x1
40002554: 110006d6     	add	w22, w22, #0x1
40002558: 38401548     	ldrb	w8, [x10], #0x1
4000255c: 35ffffa8     	cbnz	w8, 0x40002550 <script_expand_vars+0x130>
40002560: 17ffffc1     	b	0x40002464 <script_expand_vars+0x44>
40002564: 3836ca7f     	strb	wzr, [x19, w22, sxtw]
40002568: a9474ff4     	ldp	x20, x19, [sp, #0x70]
4000256c: a94657f6     	ldp	x22, x21, [sp, #0x60]
40002570: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40002574: a94467fa     	ldp	x26, x25, [sp, #0x40]
40002578: a9436ffc     	ldp	x28, x27, [sp, #0x30]
4000257c: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40002580: 910203ff     	add	sp, sp, #0x80
40002584: d65f03c0     	ret

0000000040002588 <script_execute_line>:
40002588: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
4000258c: a9014ffc     	stp	x28, x19, [sp, #0x10]
40002590: 910003fd     	mov	x29, sp
40002594: d10803ff     	sub	sp, sp, #0x200
40002598: 14000004     	b	0x400025a8 <script_execute_line+0x20>
4000259c: 7100811f     	cmp	w8, #0x20
400025a0: 54000121     	b.ne	0x400025c4 <script_execute_line+0x3c>
400025a4: 91000400     	add	x0, x0, #0x1
400025a8: 39400008     	ldrb	w8, [x0]
400025ac: 71007d1f     	cmp	w8, #0x1f
400025b0: 54ffff6c     	b.gt	0x4000259c <script_execute_line+0x14>
400025b4: 7100251f     	cmp	w8, #0x9
400025b8: 54ffff60     	b.eq	0x400025a4 <script_execute_line+0x1c>
400025bc: 34001668     	cbz	w8, 0x40002888 <script_execute_line+0x300>
400025c0: 14000003     	b	0x400025cc <script_execute_line+0x44>
400025c4: 71008d1f     	cmp	w8, #0x23
400025c8: 54001600     	b.eq	0x40002888 <script_execute_line+0x300>
400025cc: 910403e1     	add	x1, sp, #0x100
400025d0: 910403f3     	add	x19, sp, #0x100
400025d4: 97ffff93     	bl	0x40002420 <script_expand_vars>
400025d8: 394403e9     	ldrb	w9, [sp, #0x100]
400025dc: 34001529     	cbz	w9, 0x40002880 <script_execute_line+0x2f8>
400025e0: 394407e8     	ldrb	w8, [sp, #0x101]
400025e4: aa1f03ea     	mov	x10, xzr
400025e8: 2a0903eb     	mov	w11, w9
400025ec: 14000004     	b	0x400025fc <script_execute_line+0x74>
400025f0: 9100054a     	add	x10, x10, #0x1
400025f4: 386a6a6b     	ldrb	w11, [x19, x10]
400025f8: 340003cb     	cbz	w11, 0x40002670 <script_execute_line+0xe8>
400025fc: b4ffffaa     	cbz	x10, 0x400025f0 <script_execute_line+0x68>
40002600: 7100f57f     	cmp	w11, #0x3d
40002604: 54ffff61     	b.ne	0x400025f0 <script_execute_line+0x68>
40002608: 8b13014b     	add	x11, x10, x19
4000260c: 385ff16c     	ldurb	w12, [x11, #-0x1]
40002610: 7100f59f     	cmp	w12, #0x3d
40002614: 54fffee0     	b.eq	0x400025f0 <script_execute_line+0x68>
40002618: 3940056b     	ldrb	w11, [x11, #0x1]
4000261c: 7100f57f     	cmp	w11, #0x3d
40002620: 54fffe80     	b.eq	0x400025f0 <script_execute_line+0x68>
40002624: aa1f03ec     	mov	x12, xzr
40002628: 2a1f03eb     	mov	w11, wzr
4000262c: 386c6a6d     	ldrb	w13, [x19, x12]
40002630: 9100058c     	add	x12, x12, #0x1
40002634: 710081bf     	cmp	w13, #0x20
40002638: 1a9f156b     	csinc	w11, w11, wzr, ne
4000263c: eb0c015f     	cmp	x10, x12
40002640: 54ffff61     	b.ne	0x4000262c <script_execute_line+0xa4>
40002644: 35fffd6b     	cbnz	w11, 0x400025f0 <script_execute_line+0x68>
40002648: 7101a53f     	cmp	w9, #0x69
4000264c: 54fffd20     	b.eq	0x400025f0 <script_execute_line+0x68>
40002650: 7101991f     	cmp	w8, #0x66
40002654: 54fffce0     	b.eq	0x400025f0 <script_execute_line+0x68>
40002658: 910403e8     	add	x8, sp, #0x100
4000265c: 910403e0     	add	x0, sp, #0x100
40002660: 8b0a0101     	add	x1, x8, x10
40002664: 3800143f     	strb	wzr, [x1], #0x1
40002668: 97ffff0d     	bl	0x4000229c <script_set_var>
4000266c: 14000087     	b	0x40002888 <script_execute_line+0x300>
40002670: 394403e9     	ldrb	w9, [sp, #0x100]
40002674: 7101a53f     	cmp	w9, #0x69
40002678: 54001041     	b.ne	0x40002880 <script_execute_line+0x2f8>
4000267c: 7101991f     	cmp	w8, #0x66
40002680: 54001001     	b.ne	0x40002880 <script_execute_line+0x2f8>
40002684: 39440be8     	ldrb	w8, [sp, #0x102]
40002688: 7100811f     	cmp	w8, #0x20
4000268c: 54000fa1     	b.ne	0x40002880 <script_execute_line+0x2f8>
40002690: 39440fe9     	ldrb	w9, [sp, #0x103]
40002694: 7100813f     	cmp	w9, #0x20
40002698: 54000081     	b.ne	0x400026a8 <script_execute_line+0x120>
4000269c: aa1f03e9     	mov	x9, xzr
400026a0: 52800068     	mov	w8, #0x3                // =3
400026a4: 14000014     	b	0x400026f4 <script_execute_line+0x16c>
400026a8: 910403ea     	add	x10, sp, #0x100
400026ac: aa1f03e8     	mov	x8, xzr
400026b0: 910303eb     	add	x11, sp, #0xc0
400026b4: 9100114a     	add	x10, x10, #0x4
400026b8: 34000189     	cbz	w9, 0x400026e8 <script_execute_line+0x160>
400026bc: f100f91f     	cmp	x8, #0x3e
400026c0: 54000148     	b.hi	0x400026e8 <script_execute_line+0x160>
400026c4: 38286969     	strb	w9, [x11, x8]
400026c8: 38686949     	ldrb	w9, [x10, x8]
400026cc: 9100050c     	add	x12, x8, #0x1
400026d0: aa0c03e8     	mov	x8, x12
400026d4: 7100813f     	cmp	w9, #0x20
400026d8: 54ffff01     	b.ne	0x400026b8 <script_execute_line+0x130>
400026dc: 11000d8a     	add	w10, w12, #0x3
400026e0: 2a0c03e8     	mov	w8, w12
400026e4: 14000002     	b	0x400026ec <script_execute_line+0x164>
400026e8: 11000d0a     	add	w10, w8, #0x3
400026ec: 2a0803e9     	mov	w9, w8
400026f0: 2a0a03e8     	mov	w8, w10
400026f4: 910303ea     	add	x10, sp, #0xc0
400026f8: 3829695f     	strb	wzr, [x10, x9]
400026fc: 910403e9     	add	x9, sp, #0x100
40002700: 3868692a     	ldrb	w10, [x9, x8]
40002704: 7100815f     	cmp	w10, #0x20
40002708: 54000061     	b.ne	0x40002714 <script_execute_line+0x18c>
4000270c: 91000508     	add	x8, x8, #0x1
40002710: 17fffffc     	b	0x40002700 <script_execute_line+0x178>
40002714: 7100855f     	cmp	w10, #0x21
40002718: 54000060     	b.eq	0x40002724 <script_execute_line+0x19c>
4000271c: 7100f55f     	cmp	w10, #0x3d
40002720: 540000e1     	b.ne	0x4000273c <script_execute_line+0x1b4>
40002724: 11000509     	add	w9, w8, #0x1
40002728: 910403ea     	add	x10, sp, #0x100
4000272c: 38694949     	ldrb	w9, [x10, w9, uxtw]
40002730: 9100090a     	add	x10, x8, #0x2
40002734: 7100f53f     	cmp	w9, #0x3d
40002738: 9a880148     	csel	x8, x10, x8, eq
4000273c: b2607fe9     	mov	x9, #-0x100000000       // =-4294967296
40002740: 910403ea     	add	x10, sp, #0x100
40002744: d2c0002b     	mov	x11, #0x100000000       // =4294967296
40002748: 8b088129     	add	x9, x9, x8, lsl #32
4000274c: 8b28c14a     	add	x10, x10, w8, sxtw
40002750: 51000508     	sub	w8, w8, #0x1
40002754: 3840154c     	ldrb	w12, [x10], #0x1
40002758: 8b0b0129     	add	x9, x9, x11
4000275c: 11000508     	add	w8, w8, #0x1
40002760: 7100819f     	cmp	w12, #0x20
40002764: 54ffff80     	b.eq	0x40002754 <script_execute_line+0x1cc>
40002768: 9360fd2c     	asr	x12, x9, #32
4000276c: 910403e9     	add	x9, sp, #0x100
40002770: 386c692d     	ldrb	w13, [x9, x12]
40002774: 710081bf     	cmp	w13, #0x20
40002778: 54000061     	b.ne	0x40002784 <script_execute_line+0x1fc>
4000277c: aa1f03ea     	mov	x10, xzr
40002780: 14000010     	b	0x400027c0 <script_execute_line+0x238>
40002784: aa1f03eb     	mov	x11, xzr
40002788: 910203ec     	add	x12, sp, #0x80
4000278c: 3400016d     	cbz	w13, 0x400027b8 <script_execute_line+0x230>
40002790: f100f97f     	cmp	x11, #0x3e
40002794: 54000128     	b.hi	0x400027b8 <script_execute_line+0x230>
40002798: 382b698d     	strb	w13, [x12, x11]
4000279c: 386b694d     	ldrb	w13, [x10, x11]
400027a0: 9100056e     	add	x14, x11, #0x1
400027a4: 11000508     	add	w8, w8, #0x1
400027a8: aa0e03eb     	mov	x11, x14
400027ac: 710081bf     	cmp	w13, #0x20
400027b0: 54fffee1     	b.ne	0x4000278c <script_execute_line+0x204>
400027b4: 2a0e03eb     	mov	w11, w14
400027b8: 93407d0c     	sxtw	x12, w8
400027bc: 2a0b03ea     	mov	w10, w11
400027c0: d3607d8d     	lsl	x13, x12, #32
400027c4: 910203eb     	add	x11, sp, #0x80
400027c8: d2c0006f     	mov	x15, #0x300000000       // =12884901888
400027cc: d2c00050     	mov	x16, #0x200000000       // =8589934592
400027d0: d2c0002e     	mov	x14, #0x100000000       // =4294967296
400027d4: 11001108     	add	w8, w8, #0x4
400027d8: 382a697f     	strb	wzr, [x11, x10]
400027dc: 8b0f01aa     	add	x10, x13, x15
400027e0: 8b1001ab     	add	x11, x13, x16
400027e4: 8b0e01ad     	add	x13, x13, x14
400027e8: 8b0c0129     	add	x9, x9, x12
400027ec: 3840152c     	ldrb	w12, [x9], #0x1
400027f0: 7100819f     	cmp	w12, #0x20
400027f4: 540000c1     	b.ne	0x4000280c <script_execute_line+0x284>
400027f8: 11000508     	add	w8, w8, #0x1
400027fc: 8b0e014a     	add	x10, x10, x14
40002800: 8b0e016b     	add	x11, x11, x14
40002804: 8b0e01ad     	add	x13, x13, x14
40002808: 17fffff9     	b	0x400027ec <script_execute_line+0x264>
4000280c: 7101d19f     	cmp	w12, #0x74
40002810: 54000381     	b.ne	0x40002880 <script_execute_line+0x2f8>
40002814: 9360fdac     	asr	x12, x13, #32
40002818: 910403e9     	add	x9, sp, #0x100
4000281c: 386c692c     	ldrb	w12, [x9, x12]
40002820: 7101a19f     	cmp	w12, #0x68
40002824: 540002e1     	b.ne	0x40002880 <script_execute_line+0x2f8>
40002828: 9360fd6b     	asr	x11, x11, #32
4000282c: 386b6929     	ldrb	w9, [x9, x11]
40002830: 7101953f     	cmp	w9, #0x65
40002834: 54000261     	b.ne	0x40002880 <script_execute_line+0x2f8>
40002838: 9360fd4a     	asr	x10, x10, #32
4000283c: 910403e9     	add	x9, sp, #0x100
40002840: 386a692a     	ldrb	w10, [x9, x10]
40002844: 7101b95f     	cmp	w10, #0x6e
40002848: 540001c1     	b.ne	0x40002880 <script_execute_line+0x2f8>
4000284c: 8b28c128     	add	x8, x9, w8, sxtw
40002850: d1000501     	sub	x1, x8, #0x1
40002854: 38401c28     	ldrb	w8, [x1, #0x1]!
40002858: 7100811f     	cmp	w8, #0x20
4000285c: 54ffffc0     	b.eq	0x40002854 <script_execute_line+0x2cc>
40002860: 910003e0     	mov	x0, sp
40002864: 94000075     	bl	0x40002a38 <kstrcpy>
40002868: 910303e0     	add	x0, sp, #0xc0
4000286c: 910203e1     	add	x1, sp, #0x80
40002870: 94000053     	bl	0x400029bc <kstrcmp>
40002874: 350000a0     	cbnz	w0, 0x40002888 <script_execute_line+0x300>
40002878: 910003e0     	mov	x0, sp
4000287c: 14000002     	b	0x40002884 <script_execute_line+0x2fc>
40002880: 910403e0     	add	x0, sp, #0x100
40002884: 97fff96e     	bl	0x40000e3c <execute_command>
40002888: 2a1f03e0     	mov	w0, wzr
4000288c: 910803ff     	add	sp, sp, #0x200
40002890: a9414ffc     	ldp	x28, x19, [sp, #0x10]
40002894: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002898: d65f03c0     	ret

000000004000289c <script_run_file>:
4000289c: d10503ff     	sub	sp, sp, #0x140
400028a0: a9107bfd     	stp	x29, x30, [sp, #0x100]
400028a4: 910403fd     	add	x29, sp, #0x100
400028a8: f9008bfc     	str	x28, [sp, #0x110]
400028ac: a91257f6     	stp	x22, x21, [sp, #0x120]
400028b0: a9134ff4     	stp	x20, x19, [sp, #0x130]
400028b4: aa0003f4     	mov	x20, x0
400028b8: 940008b8     	bl	0x40004b98 <vfs_find>
400028bc: b4000080     	cbz	x0, 0x400028cc <script_run_file+0x30>
400028c0: b9402008     	ldr	w8, [x0, #0x20]
400028c4: aa0003f3     	mov	x19, x0
400028c8: 340000e8     	cbz	w8, 0x400028e4 <script_run_file+0x48>
400028cc: 90000040     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400028d0: 91078800     	add	x0, x0, #0x1e2
400028d4: aa1403e1     	mov	x1, x20
400028d8: 940004e9     	bl	0x40003c7c <uart_printf>
400028dc: 12800000     	mov	w0, #-0x1               // =-1
400028e0: 14000021     	b	0x40002964 <script_run_file+0xc8>
400028e4: f9401668     	ldr	x8, [x19, #0x28]
400028e8: aa1f03f4     	mov	x20, xzr
400028ec: 2a1f03e9     	mov	w9, wzr
400028f0: 9100c275     	add	x21, x19, #0x30
400028f4: 910003f6     	mov	x22, sp
400028f8: 14000008     	b	0x40002918 <script_run_file+0x7c>
400028fc: 7100053f     	cmp	w9, #0x1
40002900: 3829cadf     	strb	wzr, [x22, w9, sxtw]
40002904: 2a1f03e9     	mov	w9, wzr
40002908: 5400022a     	b.ge	0x4000294c <script_run_file+0xb0>
4000290c: 91000694     	add	x20, x20, #0x1
40002910: eb08029f     	cmp	x20, x8
40002914: 54000268     	b.hi	0x40002960 <script_run_file+0xc4>
40002918: eb08029f     	cmp	x20, x8
4000291c: 54ffff00     	b.eq	0x400028fc <script_run_file+0x60>
40002920: 38746aaa     	ldrb	w10, [x21, x20]
40002924: 7100295f     	cmp	w10, #0xa
40002928: 54fffea0     	b.eq	0x400028fc <script_run_file+0x60>
4000292c: 7100355f     	cmp	w10, #0xd
40002930: 54fffee0     	b.eq	0x4000290c <script_run_file+0x70>
40002934: 7103f93f     	cmp	w9, #0xfe
40002938: 54fffeac     	b.gt	0x4000290c <script_run_file+0x70>
4000293c: 1100052b     	add	w11, w9, #0x1
40002940: 3829caca     	strb	w10, [x22, w9, sxtw]
40002944: 2a0b03e9     	mov	w9, w11
40002948: 17fffff1     	b	0x4000290c <script_run_file+0x70>
4000294c: 910003e0     	mov	x0, sp
40002950: 97ffff0e     	bl	0x40002588 <script_execute_line>
40002954: f9401668     	ldr	x8, [x19, #0x28]
40002958: 2a1f03e9     	mov	w9, wzr
4000295c: 17ffffec     	b	0x4000290c <script_run_file+0x70>
40002960: 2a1f03e0     	mov	w0, wzr
40002964: a9534ff4     	ldp	x20, x19, [sp, #0x130]
40002968: f9408bfc     	ldr	x28, [sp, #0x110]
4000296c: a95257f6     	ldp	x22, x21, [sp, #0x120]
40002970: a9507bfd     	ldp	x29, x30, [sp, #0x100]
40002974: 910503ff     	add	sp, sp, #0x140
40002978: d65f03c0     	ret

000000004000297c <kstrlen>:
4000297c: b40000c0     	cbz	x0, 0x40002994 <kstrlen+0x18>
40002980: aa1f03e8     	mov	x8, xzr
40002984: 38686809     	ldrb	w9, [x0, x8]
40002988: 91000508     	add	x8, x8, #0x1
4000298c: 35ffffc9     	cbnz	w9, 0x40002984 <kstrlen+0x8>
40002990: d1000500     	sub	x0, x8, #0x1
40002994: d65f03c0     	ret

0000000040002998 <kstrcat>:
40002998: b4000100     	cbz	x0, 0x400029b8 <kstrcat+0x20>
4000299c: b40000e1     	cbz	x1, 0x400029b8 <kstrcat+0x20>
400029a0: d1000408     	sub	x8, x0, #0x1
400029a4: 38401d09     	ldrb	w9, [x8, #0x1]!
400029a8: 35ffffe9     	cbnz	w9, 0x400029a4 <kstrcat+0xc>
400029ac: 38401429     	ldrb	w9, [x1], #0x1
400029b0: 38001509     	strb	w9, [x8], #0x1
400029b4: 35ffffc9     	cbnz	w9, 0x400029ac <kstrcat+0x14>
400029b8: d65f03c0     	ret

00000000400029bc <kstrcmp>:
400029bc: aa0003e8     	mov	x8, x0
400029c0: 12800000     	mov	w0, #-0x1               // =-1
400029c4: b4000188     	cbz	x8, 0x400029f4 <kstrcmp+0x38>
400029c8: b4000161     	cbz	x1, 0x400029f4 <kstrcmp+0x38>
400029cc: 38401509     	ldrb	w9, [x8], #0x1
400029d0: 340000e9     	cbz	w9, 0x400029ec <kstrcmp+0x30>
400029d4: 3940002a     	ldrb	w10, [x1]
400029d8: 6b0a013f     	cmp	w9, w10
400029dc: 54000081     	b.ne	0x400029ec <kstrcmp+0x30>
400029e0: 38401509     	ldrb	w9, [x8], #0x1
400029e4: 91000421     	add	x1, x1, #0x1
400029e8: 35ffff69     	cbnz	w9, 0x400029d4 <kstrcmp+0x18>
400029ec: 39400028     	ldrb	w8, [x1]
400029f0: 4b080120     	sub	w0, w9, w8
400029f4: d65f03c0     	ret

00000000400029f8 <kstrncmp>:
400029f8: 12800008     	mov	w8, #-0x1               // =-1
400029fc: b4000160     	cbz	x0, 0x40002a28 <kstrncmp+0x30>
40002a00: b4000141     	cbz	x1, 0x40002a28 <kstrncmp+0x30>
40002a04: b4000102     	cbz	x2, 0x40002a24 <kstrncmp+0x2c>
40002a08: 38401408     	ldrb	w8, [x0], #0x1
40002a0c: 38401429     	ldrb	w9, [x1], #0x1
40002a10: 34000108     	cbz	w8, 0x40002a30 <kstrncmp+0x38>
40002a14: 6b09011f     	cmp	w8, w9
40002a18: 540000c1     	b.ne	0x40002a30 <kstrncmp+0x38>
40002a1c: f1000442     	subs	x2, x2, #0x1
40002a20: 54ffff41     	b.ne	0x40002a08 <kstrncmp+0x10>
40002a24: 2a1f03e8     	mov	w8, wzr
40002a28: 2a0803e0     	mov	w0, w8
40002a2c: d65f03c0     	ret
40002a30: 4b090100     	sub	w0, w8, w9
40002a34: d65f03c0     	ret

0000000040002a38 <kstrcpy>:
40002a38: b40000c0     	cbz	x0, 0x40002a50 <kstrcpy+0x18>
40002a3c: b40000a1     	cbz	x1, 0x40002a50 <kstrcpy+0x18>
40002a40: aa0003e8     	mov	x8, x0
40002a44: 38401429     	ldrb	w9, [x1], #0x1
40002a48: 38001509     	strb	w9, [x8], #0x1
40002a4c: 35ffffc9     	cbnz	w9, 0x40002a44 <kstrcpy+0xc>
40002a50: d65f03c0     	ret

0000000040002a54 <kstrncpy>:
40002a54: b4000480     	cbz	x0, 0x40002ae4 <kstrncpy+0x90>
40002a58: b4000461     	cbz	x1, 0x40002ae4 <kstrncpy+0x90>
40002a5c: b4000442     	cbz	x2, 0x40002ae4 <kstrncpy+0x90>
40002a60: aa1f03e9     	mov	x9, xzr
40002a64: aa0203e8     	mov	x8, x2
40002a68: 3869682a     	ldrb	w10, [x1, x9]
40002a6c: 3829680a     	strb	w10, [x0, x9]
40002a70: 340000ca     	cbz	w10, 0x40002a88 <kstrncpy+0x34>
40002a74: 91000529     	add	x9, x9, #0x1
40002a78: d1000508     	sub	x8, x8, #0x1
40002a7c: eb09005f     	cmp	x2, x9
40002a80: 54ffff41     	b.ne	0x40002a68 <kstrncpy+0x14>
40002a84: 14000018     	b	0x40002ae4 <kstrncpy+0x90>
40002a88: cb09004a     	sub	x10, x2, x9
40002a8c: 8b090009     	add	x9, x0, x9
40002a90: f100095f     	cmp	x10, #0x2
40002a94: 54000082     	b.hs	0x40002aa4 <kstrncpy+0x50>
40002a98: 91000528     	add	x8, x9, #0x1
40002a9c: aa0a03e9     	mov	x9, x10
40002aa0: 1400000e     	b	0x40002ad8 <kstrncpy+0x84>
40002aa4: 927ff908     	and	x8, x8, #0xfffffffffffffffe
40002aa8: 927ff94b     	and	x11, x10, #0xfffffffffffffffe
40002aac: 9100092c     	add	x12, x9, #0x2
40002ab0: 8b090108     	add	x8, x8, x9
40002ab4: 92400149     	and	x9, x10, #0x1
40002ab8: aa0b03ed     	mov	x13, x11
40002abc: 91000508     	add	x8, x8, #0x1
40002ac0: f10009ad     	subs	x13, x13, #0x2
40002ac4: 381ff19f     	sturb	wzr, [x12, #-0x1]
40002ac8: 3800259f     	strb	wzr, [x12], #0x2
40002acc: 54ffffa1     	b.ne	0x40002ac0 <kstrncpy+0x6c>
40002ad0: eb0b015f     	cmp	x10, x11
40002ad4: 54000080     	b.eq	0x40002ae4 <kstrncpy+0x90>
40002ad8: f1000529     	subs	x9, x9, #0x1
40002adc: 3800151f     	strb	wzr, [x8], #0x1
40002ae0: 54ffffc1     	b.ne	0x40002ad8 <kstrncpy+0x84>
40002ae4: d65f03c0     	ret

0000000040002ae8 <memset>:
40002ae8: b40002a0     	cbz	x0, 0x40002b3c <memset+0x54>
40002aec: b4000282     	cbz	x2, 0x40002b3c <memset+0x54>
40002af0: f100085f     	cmp	x2, #0x2
40002af4: 54000082     	b.hs	0x40002b04 <memset+0x1c>
40002af8: aa0003e8     	mov	x8, x0
40002afc: aa0203e9     	mov	x9, x2
40002b00: 1400000c     	b	0x40002b30 <memset+0x48>
40002b04: 927ff84a     	and	x10, x2, #0xfffffffffffffffe
40002b08: 92400049     	and	x9, x2, #0x1
40002b0c: 9100040b     	add	x11, x0, #0x1
40002b10: 8b0a0008     	add	x8, x0, x10
40002b14: aa0a03ec     	mov	x12, x10
40002b18: f100098c     	subs	x12, x12, #0x2
40002b1c: 381ff161     	sturb	w1, [x11, #-0x1]
40002b20: 38002561     	strb	w1, [x11], #0x2
40002b24: 54ffffa1     	b.ne	0x40002b18 <memset+0x30>
40002b28: eb0a005f     	cmp	x2, x10
40002b2c: 54000080     	b.eq	0x40002b3c <memset+0x54>
40002b30: f1000529     	subs	x9, x9, #0x1
40002b34: 38001501     	strb	w1, [x8], #0x1
40002b38: 54ffffc1     	b.ne	0x40002b30 <memset+0x48>
40002b3c: d65f03c0     	ret

0000000040002b40 <memcpy>:
40002b40: b4000100     	cbz	x0, 0x40002b60 <memcpy+0x20>
40002b44: b40000e1     	cbz	x1, 0x40002b60 <memcpy+0x20>
40002b48: b40000c2     	cbz	x2, 0x40002b60 <memcpy+0x20>
40002b4c: aa0003e8     	mov	x8, x0
40002b50: 38401429     	ldrb	w9, [x1], #0x1
40002b54: f1000442     	subs	x2, x2, #0x1
40002b58: 38001509     	strb	w9, [x8], #0x1
40002b5c: 54ffffa1     	b.ne	0x40002b50 <memcpy+0x10>
40002b60: d65f03c0     	ret

0000000040002b64 <kstrstr>:
40002b64: aa1f03e2     	mov	x2, xzr
40002b68: b40000e0     	cbz	x0, 0x40002b84 <kstrstr+0x20>
40002b6c: b40000c1     	cbz	x1, 0x40002b84 <kstrstr+0x20>
40002b70: 39400028     	ldrb	w8, [x1]
40002b74: 340002c8     	cbz	w8, 0x40002bcc <kstrstr+0x68>
40002b78: 39400009     	ldrb	w9, [x0]
40002b7c: 35000109     	cbnz	w9, 0x40002b9c <kstrstr+0x38>
40002b80: aa1f03e2     	mov	x2, xzr
40002b84: aa0203e0     	mov	x0, x2
40002b88: d65f03c0     	ret
40002b8c: 3940012c     	ldrb	w12, [x9]
40002b90: 340001ec     	cbz	w12, 0x40002bcc <kstrstr+0x68>
40002b94: 38401c09     	ldrb	w9, [x0, #0x1]!
40002b98: 34ffff49     	cbz	w9, 0x40002b80 <kstrstr+0x1c>
40002b9c: 6b08013f     	cmp	w9, w8
40002ba0: 54ffffa1     	b.ne	0x40002b94 <kstrstr+0x30>
40002ba4: 5280002a     	mov	w10, #0x1               // =1
40002ba8: aa0103e9     	mov	x9, x1
40002bac: 2a0803eb     	mov	w11, w8
40002bb0: 3840152c     	ldrb	w12, [x9], #0x1
40002bb4: 6b0c017f     	cmp	w11, w12
40002bb8: 54fffec1     	b.ne	0x40002b90 <kstrstr+0x2c>
40002bbc: 386a680b     	ldrb	w11, [x0, x10]
40002bc0: 9100054a     	add	x10, x10, #0x1
40002bc4: 35ffff6b     	cbnz	w11, 0x40002bb0 <kstrstr+0x4c>
40002bc8: 17fffff1     	b	0x40002b8c <kstrstr+0x28>
40002bcc: d65f03c0     	ret

0000000040002bd0 <kstrchr>:
40002bd0: b4000140     	cbz	x0, 0x40002bf8 <kstrchr+0x28>
40002bd4: 39400009     	ldrb	w9, [x0]
40002bd8: 340000c9     	cbz	w9, 0x40002bf0 <kstrchr+0x20>
40002bdc: 12001c28     	and	w8, w1, #0xff
40002be0: 6b08013f     	cmp	w9, w8
40002be4: 540000a0     	b.eq	0x40002bf8 <kstrchr+0x28>
40002be8: 38401c09     	ldrb	w9, [x0, #0x1]!
40002bec: 35ffffa9     	cbnz	w9, 0x40002be0 <kstrchr+0x10>
40002bf0: 72001c3f     	tst	w1, #0xff
40002bf4: 9a9f0000     	csel	x0, x0, xzr, eq
40002bf8: d65f03c0     	ret

0000000040002bfc <ktolower>:
40002bfc: 51010408     	sub	w8, w0, #0x41
40002c00: 321b0009     	orr	w9, w0, #0x20
40002c04: 7100691f     	cmp	w8, #0x1a
40002c08: 1a803120     	csel	w0, w9, w0, lo
40002c0c: d65f03c0     	ret

0000000040002c10 <kstr_tolower>:
40002c10: b40001a0     	cbz	x0, 0x40002c44 <kstr_tolower+0x34>
40002c14: b4000181     	cbz	x1, 0x40002c44 <kstr_tolower+0x34>
40002c18: 39400029     	ldrb	w9, [x1]
40002c1c: 34000129     	cbz	w9, 0x40002c40 <kstr_tolower+0x30>
40002c20: 91000428     	add	x8, x1, #0x1
40002c24: 5101052a     	sub	w10, w9, #0x41
40002c28: 321b012b     	orr	w11, w9, #0x20
40002c2c: 7100695f     	cmp	w10, #0x1a
40002c30: 1a893169     	csel	w9, w11, w9, lo
40002c34: 38001409     	strb	w9, [x0], #0x1
40002c38: 38401509     	ldrb	w9, [x8], #0x1
40002c3c: 35ffff49     	cbnz	w9, 0x40002c24 <kstr_tolower+0x14>
40002c40: 3900001f     	strb	wzr, [x0]
40002c44: d65f03c0     	ret

0000000040002c48 <timer_init>:
40002c48: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40002c4c: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002c50: f9000bf3     	str	x19, [sp, #0x10]
40002c54: d53be008     	mrs	x8, CNTFRQ_EL0
40002c58: f29999a9     	movk	x9, #0xcccd
40002c5c: f0000073     	adrp	x19, 0x40011000 <var_values+0x6a8>
40002c60: 528003c0     	mov	w0, #0x1e               // =30
40002c64: 9bc97d09     	umulh	x9, x8, x9
40002c68: 910003fd     	mov	x29, sp
40002c6c: 5280002a     	mov	w10, #0x1               // =1
40002c70: f904ae68     	str	x8, [x19, #0x958]
40002c74: d343fd29     	lsr	x9, x9, #3
40002c78: d51be209     	msr	CNTP_TVAL_EL0, x9
40002c7c: d51be22a     	msr	CNTP_CTL_EL0, x10
40002c80: 97fff570     	bl	0x40000240 <gic_enable_interrupt>
40002c84: d50342ff     	msr	DAIFClr, #0x2
40002c88: d503201f     	nop
40002c8c: 500444a0     	adr	x0, 0x4000b522 <__rodata_start+0x2522>
40002c90: b9495a61     	ldr	w1, [x19, #0x958]
40002c94: f9400bf3     	ldr	x19, [sp, #0x10]
40002c98: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40002c9c: 140003f8     	b	0x40003c7c <uart_printf>

0000000040002ca0 <timer_handle_interrupt>:
40002ca0: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002ca4: b202e7e9     	mov	x9, #-0x3333333333333334 // =-3689348814741910324
40002ca8: f944ad08     	ldr	x8, [x8, #0x958]
40002cac: f29999a9     	movk	x9, #0xcccd
40002cb0: 9bc97d08     	umulh	x8, x8, x9
40002cb4: f0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40002cb8: f944b12a     	ldr	x10, [x9, #0x960]
40002cbc: 9100054a     	add	x10, x10, #0x1
40002cc0: f904b12a     	str	x10, [x9, #0x960]
40002cc4: d343fd08     	lsr	x8, x8, #3
40002cc8: d51be208     	msr	CNTP_TVAL_EL0, x8
40002ccc: d65f03c0     	ret

0000000040002cd0 <tui_launch>:
40002cd0: d105c3ff     	sub	sp, sp, #0x170
40002cd4: a9117bfd     	stp	x29, x30, [sp, #0x110]
40002cd8: 910443fd     	add	x29, sp, #0x110
40002cdc: a9126ffc     	stp	x28, x27, [sp, #0x120]
40002ce0: a91367fa     	stp	x26, x25, [sp, #0x130]
40002ce4: a9145ff8     	stp	x24, x23, [sp, #0x140]
40002ce8: a91557f6     	stp	x22, x21, [sp, #0x150]
40002cec: a9164ff4     	stp	x20, x19, [sp, #0x160]
40002cf0: 94000758     	bl	0x40004a50 <vfs_get_cwd>
40002cf4: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002cf8: f000007c     	adrp	x28, 0x40011000 <var_values+0x6a8>
40002cfc: f000007b     	adrp	x27, 0x40011000 <var_values+0x6a8>
40002d00: f904b500     	str	x0, [x8, #0x968]
40002d04: d503201f     	nop
40002d08: 1003eee0     	adr	x0, 0x4000aae4 <__rodata_start+0x1ae4>
40002d0c: b909739f     	str	wzr, [x28, #0x970]
40002d10: b909777f     	str	wzr, [x27, #0x974]
40002d14: 940002c5     	bl	0x40003828 <uart_puts>
40002d18: f0000036     	adrp	x22, 0x40009000 <__rodata_start>
40002d1c: 91121ad6     	add	x22, x22, #0x486
40002d20: f0000037     	adrp	x23, 0x40009000 <__rodata_start>
40002d24: 910d22f7     	add	x23, x23, #0x348
40002d28: f0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40002d2c: 91260318     	add	x24, x24, #0x980
40002d30: f000007a     	adrp	x26, 0x40011000 <var_values+0x6a8>
40002d34: f0000034     	adrp	x20, 0x40009000 <__rodata_start>
40002d38: 91159e94     	add	x20, x20, #0x567
40002d3c: 14000005     	b	0x40002d50 <tui_launch+0x80>
40002d40: b9497388     	ldr	w8, [x28, #0x970]
40002d44: 7100011f     	cmp	w8, #0x0
40002d48: 1a9f17e8     	cset	w8, eq
40002d4c: b9097388     	str	w8, [x28, #0x970]
40002d50: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002d54: b9097b5f     	str	wzr, [x26, #0x978]
40002d58: f944b50a     	ldr	x10, [x8, #0x968]
40002d5c: f9421948     	ldr	x8, [x10, #0x430]
40002d60: b4000108     	cbz	x8, 0x40002d80 <tui_launch+0xb0>
40002d64: 52800029     	mov	w9, #0x1                // =1
40002d68: f0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
40002d6c: b9097b49     	str	w9, [x26, #0x978]
40002d70: f904c11f     	str	xzr, [x8, #0x980]
40002d74: f9401548     	ldr	x8, [x10, #0x28]
40002d78: b50000a8     	cbnz	x8, 0x40002d8c <tui_launch+0xbc>
40002d7c: 14000027     	b	0x40002e18 <tui_launch+0x148>
40002d80: 2a1f03e9     	mov	w9, wzr
40002d84: f9401548     	ldr	x8, [x10, #0x28]
40002d88: b4000488     	cbz	x8, 0x40002e18 <tui_launch+0x148>
40002d8c: 2a0903e9     	mov	w9, w9
40002d90: d100050c     	sub	x12, x8, #0x1
40002d94: d240152b     	eor	x11, x9, #0x3f
40002d98: eb0b019f     	cmp	x12, x11
40002d9c: 9a8b318b     	csel	x11, x12, x11, lo
40002da0: b400022c     	cbz	x12, 0x40002de4 <tui_launch+0x114>
40002da4: 9100056c     	add	x12, x11, #0x1
40002da8: 8b090f0e     	add	x14, x24, x9, lsl #3
40002dac: 9111014d     	add	x13, x10, #0x440
40002db0: 927f798b     	and	x11, x12, #0xfffffffe
40002db4: aa090169     	orr	x9, x11, x9
40002db8: 910021ce     	add	x14, x14, #0x8
40002dbc: aa0b03ef     	mov	x15, x11
40002dc0: a97fc5b0     	ldp	x16, x17, [x13, #-0x8]
40002dc4: f10009ef     	subs	x15, x15, #0x2
40002dc8: 910041ad     	add	x13, x13, #0x10
40002dcc: a93fc5d0     	stp	x16, x17, [x14, #-0x8]
40002dd0: 910041ce     	add	x14, x14, #0x10
40002dd4: 54ffff61     	b.ne	0x40002dc0 <tui_launch+0xf0>
40002dd8: eb0b019f     	cmp	x12, x11
40002ddc: 54000061     	b.ne	0x40002de8 <tui_launch+0x118>
40002de0: 1400000d     	b	0x40002e14 <tui_launch+0x144>
40002de4: aa1f03eb     	mov	x11, xzr
40002de8: 8b0b0d4a     	add	x10, x10, x11, lsl #3
40002dec: 9100056b     	add	x11, x11, #0x1
40002df0: 9110e14a     	add	x10, x10, #0x438
40002df4: f840854c     	ldr	x12, [x10], #0x8
40002df8: f100f93f     	cmp	x9, #0x3e
40002dfc: f8297b0c     	str	x12, [x24, x9, lsl #3]
40002e00: 91000529     	add	x9, x9, #0x1
40002e04: 54000088     	b.hi	0x40002e14 <tui_launch+0x144>
40002e08: eb08017f     	cmp	x11, x8
40002e0c: 9100056b     	add	x11, x11, #0x1
40002e10: 54ffff23     	b.lo	0x40002df4 <tui_launch+0x124>
40002e14: b9097b49     	str	w9, [x26, #0x978]
40002e18: b949776a     	ldr	w10, [x27, #0x974]
40002e1c: 51000528     	sub	w8, w9, #0x1
40002e20: 6b08015f     	cmp	w10, w8
40002e24: 1a88b148     	csel	w8, w10, w8, lt
40002e28: 6b09015f     	cmp	w10, w9
40002e2c: 5400004a     	b.ge	0x40002e34 <tui_launch+0x164>
40002e30: 36f80068     	tbz	w8, #0x1f, 0x40002e3c <tui_launch+0x16c>
40002e34: 0aa87d08     	bic	w8, w8, w8, asr #31
40002e38: b9097768     	str	w8, [x27, #0x974]
40002e3c: f0000020     	adrp	x0, 0x40009000 <__rodata_start>
40002e40: 91265800     	add	x0, x0, #0x996
40002e44: 94000279     	bl	0x40003828 <uart_puts>
40002e48: b9497388     	ldr	w8, [x28, #0x970]
40002e4c: 52800020     	mov	w0, #0x1                // =1
40002e50: 52800501     	mov	w1, #0x28               // =40
40002e54: f0000022     	adrp	x2, 0x40009000 <__rodata_start>
40002e58: 91023042     	add	x2, x2, #0x8c
40002e5c: 7100011f     	cmp	w8, #0x0
40002e60: 1a9f17e3     	cset	w3, eq
40002e64: 94000171     	bl	0x40003428 <draw_box>
40002e68: 52800075     	mov	w21, #0x3               // =3
40002e6c: aa1603e0     	mov	x0, x22
40002e70: 2a1503e1     	mov	w1, w21
40002e74: 52800042     	mov	w2, #0x2                // =2
40002e78: 94000381     	bl	0x40003c7c <uart_printf>
40002e7c: aa1703e0     	mov	x0, x23
40002e80: 9400026a     	bl	0x40003828 <uart_puts>
40002e84: aa1703e0     	mov	x0, x23
40002e88: 94000268     	bl	0x40003828 <uart_puts>
40002e8c: aa1703e0     	mov	x0, x23
40002e90: 94000266     	bl	0x40003828 <uart_puts>
40002e94: aa1703e0     	mov	x0, x23
40002e98: 94000264     	bl	0x40003828 <uart_puts>
40002e9c: aa1703e0     	mov	x0, x23
40002ea0: 94000262     	bl	0x40003828 <uart_puts>
40002ea4: aa1703e0     	mov	x0, x23
40002ea8: 94000260     	bl	0x40003828 <uart_puts>
40002eac: aa1703e0     	mov	x0, x23
40002eb0: 9400025e     	bl	0x40003828 <uart_puts>
40002eb4: aa1703e0     	mov	x0, x23
40002eb8: 9400025c     	bl	0x40003828 <uart_puts>
40002ebc: aa1703e0     	mov	x0, x23
40002ec0: 9400025a     	bl	0x40003828 <uart_puts>
40002ec4: aa1703e0     	mov	x0, x23
40002ec8: 94000258     	bl	0x40003828 <uart_puts>
40002ecc: aa1703e0     	mov	x0, x23
40002ed0: 94000256     	bl	0x40003828 <uart_puts>
40002ed4: aa1703e0     	mov	x0, x23
40002ed8: 94000254     	bl	0x40003828 <uart_puts>
40002edc: aa1703e0     	mov	x0, x23
40002ee0: 94000252     	bl	0x40003828 <uart_puts>
40002ee4: aa1703e0     	mov	x0, x23
40002ee8: 94000250     	bl	0x40003828 <uart_puts>
40002eec: aa1703e0     	mov	x0, x23
40002ef0: 9400024e     	bl	0x40003828 <uart_puts>
40002ef4: aa1703e0     	mov	x0, x23
40002ef8: 9400024c     	bl	0x40003828 <uart_puts>
40002efc: aa1703e0     	mov	x0, x23
40002f00: 9400024a     	bl	0x40003828 <uart_puts>
40002f04: aa1703e0     	mov	x0, x23
40002f08: 94000248     	bl	0x40003828 <uart_puts>
40002f0c: aa1703e0     	mov	x0, x23
40002f10: 94000246     	bl	0x40003828 <uart_puts>
40002f14: aa1703e0     	mov	x0, x23
40002f18: 94000244     	bl	0x40003828 <uart_puts>
40002f1c: aa1703e0     	mov	x0, x23
40002f20: 94000242     	bl	0x40003828 <uart_puts>
40002f24: aa1703e0     	mov	x0, x23
40002f28: 94000240     	bl	0x40003828 <uart_puts>
40002f2c: aa1703e0     	mov	x0, x23
40002f30: 9400023e     	bl	0x40003828 <uart_puts>
40002f34: aa1703e0     	mov	x0, x23
40002f38: 9400023c     	bl	0x40003828 <uart_puts>
40002f3c: aa1703e0     	mov	x0, x23
40002f40: 9400023a     	bl	0x40003828 <uart_puts>
40002f44: aa1703e0     	mov	x0, x23
40002f48: 94000238     	bl	0x40003828 <uart_puts>
40002f4c: aa1703e0     	mov	x0, x23
40002f50: 94000236     	bl	0x40003828 <uart_puts>
40002f54: aa1703e0     	mov	x0, x23
40002f58: 94000234     	bl	0x40003828 <uart_puts>
40002f5c: aa1703e0     	mov	x0, x23
40002f60: 94000232     	bl	0x40003828 <uart_puts>
40002f64: aa1703e0     	mov	x0, x23
40002f68: 94000230     	bl	0x40003828 <uart_puts>
40002f6c: aa1703e0     	mov	x0, x23
40002f70: 9400022e     	bl	0x40003828 <uart_puts>
40002f74: aa1703e0     	mov	x0, x23
40002f78: 9400022c     	bl	0x40003828 <uart_puts>
40002f7c: aa1703e0     	mov	x0, x23
40002f80: 9400022a     	bl	0x40003828 <uart_puts>
40002f84: aa1703e0     	mov	x0, x23
40002f88: 94000228     	bl	0x40003828 <uart_puts>
40002f8c: aa1703e0     	mov	x0, x23
40002f90: 94000226     	bl	0x40003828 <uart_puts>
40002f94: aa1703e0     	mov	x0, x23
40002f98: 94000224     	bl	0x40003828 <uart_puts>
40002f9c: aa1703e0     	mov	x0, x23
40002fa0: 94000222     	bl	0x40003828 <uart_puts>
40002fa4: aa1703e0     	mov	x0, x23
40002fa8: 94000220     	bl	0x40003828 <uart_puts>
40002fac: 110006b5     	add	w21, w21, #0x1
40002fb0: 71005ebf     	cmp	w21, #0x17
40002fb4: 54fff5c1     	b.ne	0x40002e6c <tui_launch+0x19c>
40002fb8: b9497768     	ldr	w8, [x27, #0x974]
40002fbc: 52800249     	mov	w9, #0x12               // =18
40002fc0: 7100491f     	cmp	w8, #0x12
40002fc4: 1a89c108     	csel	w8, w8, w9, gt
40002fc8: 51004915     	sub	w21, w8, #0x12
40002fcc: 8b354f19     	add	x25, x24, w21, uxtw #3
40002fd0: aa1f03f8     	mov	x24, xzr
40002fd4: 14000004     	b	0x40002fe4 <tui_launch+0x314>
40002fd8: 91000718     	add	x24, x24, #0x1
40002fdc: f100531f     	cmp	x24, #0x14
40002fe0: 540005a0     	b.eq	0x40003094 <tui_launch+0x3c4>
40002fe4: b9897b48     	ldrsw	x8, [x26, #0x978]
40002fe8: 8b1802b3     	add	x19, x21, x24
40002fec: eb08027f     	cmp	x19, x8
40002ff0: 5400052a     	b.ge	0x40003094 <tui_launch+0x3c4>
40002ff4: 11000f01     	add	w1, w24, #0x3
40002ff8: aa1603e0     	mov	x0, x22
40002ffc: 52800062     	mov	w2, #0x3                // =3
40003000: 9400031f     	bl	0x40003c7c <uart_printf>
40003004: b9497768     	ldr	w8, [x27, #0x974]
40003008: eb08027f     	cmp	x19, x8
4000300c: 540000c1     	b.ne	0x40003024 <tui_launch+0x354>
40003010: b9497388     	ldr	w8, [x28, #0x970]
40003014: 35000088     	cbnz	w8, 0x40003024 <tui_launch+0x354>
40003018: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000301c: 91040800     	add	x0, x0, #0x102
40003020: 94000202     	bl	0x40003828 <uart_puts>
40003024: f8787b28     	ldr	x8, [x25, x24, lsl #3]
40003028: b40001e8     	cbz	x8, 0x40003064 <tui_launch+0x394>
4000302c: b9402108     	ldr	w8, [x8, #0x20]
40003030: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
40003034: 91113d29     	add	x9, x9, #0x44f
40003038: 910223e0     	add	x0, sp, #0x88
4000303c: 7100051f     	cmp	w8, #0x1
40003040: d0000028     	adrp	x8, 0x40009000 <__rodata_start>
40003044: 9139f908     	add	x8, x8, #0xe7e
40003048: 9a880121     	csel	x1, x9, x8, eq
4000304c: 97fffe7b     	bl	0x40002a38 <kstrcpy>
40003050: f8787b21     	ldr	x1, [x25, x24, lsl #3]
40003054: 910223e0     	add	x0, sp, #0x88
40003058: 97fffe50     	bl	0x40002998 <kstrcat>
4000305c: 910223e0     	add	x0, sp, #0x88
40003060: 14000003     	b	0x4000306c <tui_launch+0x39c>
40003064: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003068: 9133f400     	add	x0, x0, #0xcfd
4000306c: 940001ef     	bl	0x40003828 <uart_puts>
40003070: b9497768     	ldr	w8, [x27, #0x974]
40003074: eb08027f     	cmp	x19, x8
40003078: 54fffb01     	b.ne	0x40002fd8 <tui_launch+0x308>
4000307c: b9497388     	ldr	w8, [x28, #0x970]
40003080: 35fffac8     	cbnz	w8, 0x40002fd8 <tui_launch+0x308>
40003084: f0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40003088: 9137a400     	add	x0, x0, #0xde9
4000308c: 940001e7     	bl	0x40003828 <uart_puts>
40003090: 17ffffd2     	b	0x40002fd8 <tui_launch+0x308>
40003094: b9497388     	ldr	w8, [x28, #0x970]
40003098: 52800540     	mov	w0, #0x2a               // =42
4000309c: 528004c1     	mov	w1, #0x26               // =38
400030a0: f0000022     	adrp	x2, 0x4000a000 <__rodata_start+0x1000>
400030a4: 9107fc42     	add	x2, x2, #0x1ff
400030a8: 7100051f     	cmp	w8, #0x1
400030ac: 1a9f17e3     	cset	w3, eq
400030b0: 940000de     	bl	0x40003428 <draw_box>
400030b4: 52800075     	mov	w21, #0x3               // =3
400030b8: aa1603e0     	mov	x0, x22
400030bc: 2a1503e1     	mov	w1, w21
400030c0: 52800562     	mov	w2, #0x2b               // =43
400030c4: 940002ee     	bl	0x40003c7c <uart_printf>
400030c8: aa1703e0     	mov	x0, x23
400030cc: 940001d7     	bl	0x40003828 <uart_puts>
400030d0: aa1703e0     	mov	x0, x23
400030d4: 940001d5     	bl	0x40003828 <uart_puts>
400030d8: aa1703e0     	mov	x0, x23
400030dc: 940001d3     	bl	0x40003828 <uart_puts>
400030e0: aa1703e0     	mov	x0, x23
400030e4: 940001d1     	bl	0x40003828 <uart_puts>
400030e8: aa1703e0     	mov	x0, x23
400030ec: 940001cf     	bl	0x40003828 <uart_puts>
400030f0: aa1703e0     	mov	x0, x23
400030f4: 940001cd     	bl	0x40003828 <uart_puts>
400030f8: aa1703e0     	mov	x0, x23
400030fc: 940001cb     	bl	0x40003828 <uart_puts>
40003100: aa1703e0     	mov	x0, x23
40003104: 940001c9     	bl	0x40003828 <uart_puts>
40003108: aa1703e0     	mov	x0, x23
4000310c: 940001c7     	bl	0x40003828 <uart_puts>
40003110: aa1703e0     	mov	x0, x23
40003114: 940001c5     	bl	0x40003828 <uart_puts>
40003118: aa1703e0     	mov	x0, x23
4000311c: 940001c3     	bl	0x40003828 <uart_puts>
40003120: aa1703e0     	mov	x0, x23
40003124: 940001c1     	bl	0x40003828 <uart_puts>
40003128: aa1703e0     	mov	x0, x23
4000312c: 940001bf     	bl	0x40003828 <uart_puts>
40003130: aa1703e0     	mov	x0, x23
40003134: 940001bd     	bl	0x40003828 <uart_puts>
40003138: aa1703e0     	mov	x0, x23
4000313c: 940001bb     	bl	0x40003828 <uart_puts>
40003140: aa1703e0     	mov	x0, x23
40003144: 940001b9     	bl	0x40003828 <uart_puts>
40003148: aa1703e0     	mov	x0, x23
4000314c: 940001b7     	bl	0x40003828 <uart_puts>
40003150: aa1703e0     	mov	x0, x23
40003154: 940001b5     	bl	0x40003828 <uart_puts>
40003158: aa1703e0     	mov	x0, x23
4000315c: 940001b3     	bl	0x40003828 <uart_puts>
40003160: aa1703e0     	mov	x0, x23
40003164: 940001b1     	bl	0x40003828 <uart_puts>
40003168: aa1703e0     	mov	x0, x23
4000316c: 940001af     	bl	0x40003828 <uart_puts>
40003170: aa1703e0     	mov	x0, x23
40003174: 940001ad     	bl	0x40003828 <uart_puts>
40003178: aa1703e0     	mov	x0, x23
4000317c: 940001ab     	bl	0x40003828 <uart_puts>
40003180: aa1703e0     	mov	x0, x23
40003184: 940001a9     	bl	0x40003828 <uart_puts>
40003188: aa1703e0     	mov	x0, x23
4000318c: 940001a7     	bl	0x40003828 <uart_puts>
40003190: aa1703e0     	mov	x0, x23
40003194: 940001a5     	bl	0x40003828 <uart_puts>
40003198: aa1703e0     	mov	x0, x23
4000319c: 940001a3     	bl	0x40003828 <uart_puts>
400031a0: aa1703e0     	mov	x0, x23
400031a4: 940001a1     	bl	0x40003828 <uart_puts>
400031a8: aa1703e0     	mov	x0, x23
400031ac: 9400019f     	bl	0x40003828 <uart_puts>
400031b0: aa1703e0     	mov	x0, x23
400031b4: 9400019d     	bl	0x40003828 <uart_puts>
400031b8: aa1703e0     	mov	x0, x23
400031bc: 9400019b     	bl	0x40003828 <uart_puts>
400031c0: aa1703e0     	mov	x0, x23
400031c4: 94000199     	bl	0x40003828 <uart_puts>
400031c8: aa1703e0     	mov	x0, x23
400031cc: 94000197     	bl	0x40003828 <uart_puts>
400031d0: aa1703e0     	mov	x0, x23
400031d4: 94000195     	bl	0x40003828 <uart_puts>
400031d8: aa1703e0     	mov	x0, x23
400031dc: 94000193     	bl	0x40003828 <uart_puts>
400031e0: aa1703e0     	mov	x0, x23
400031e4: 94000191     	bl	0x40003828 <uart_puts>
400031e8: 110006b5     	add	w21, w21, #0x1
400031ec: 71005ebf     	cmp	w21, #0x17
400031f0: 54fff641     	b.ne	0x400030b8 <tui_launch+0x3e8>
400031f4: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400031f8: 9117a800     	add	x0, x0, #0x5ea
400031fc: 52800061     	mov	w1, #0x3                // =3
40003200: 52800562     	mov	w2, #0x2b               // =43
40003204: 9400029e     	bl	0x40003c7c <uart_printf>
40003208: d503201f     	nop
4000320c: 10068248     	adr	x8, 0x40010254 <proc_table>
40003210: aa1f03f3     	mov	x19, xzr
40003214: 9100a115     	add	x21, x8, #0x28
40003218: 52800058     	mov	w24, #0x2               // =2
4000321c: d0000039     	adrp	x25, 0x40009000 <__rodata_start>
40003220: 9121bf39     	add	x25, x25, #0x86f
40003224: b85fc2a8     	ldur	w8, [x21, #-0x4]
40003228: 71000d1f     	cmp	w8, #0x3
4000322c: 54000140     	b.eq	0x40003254 <tui_launch+0x584>
40003230: b94002a8     	ldr	w8, [x21]
40003234: b85d82a3     	ldur	w3, [x21, #-0x28]
40003238: d10092a4     	sub	x4, x21, #0x24
4000323c: 11000b01     	add	w1, w24, #0x2
40003240: aa1403e0     	mov	x0, x20
40003244: 52800562     	mov	w2, #0x2b               // =43
40003248: 530a7d05     	lsr	w5, w8, #10
4000324c: 9400028c     	bl	0x40003c7c <uart_printf>
40003250: 11000718     	add	w24, w24, #0x1
40003254: f1003a7f     	cmp	x19, #0xe
40003258: 540000a8     	b.hi	0x4000326c <tui_launch+0x59c>
4000325c: 7100531f     	cmp	w24, #0x14
40003260: 91000673     	add	x19, x19, #0x1
40003264: 9100c2b5     	add	x21, x21, #0x30
40003268: 54fffdeb     	b.lt	0x40003224 <tui_launch+0x554>
4000326c: 940001a3     	bl	0x400038f8 <uart_getc>
40003270: 52801be8     	mov	w8, #0xdf               // =223
40003274: 0a080008     	and	w8, w0, w8
40003278: 7101451f     	cmp	w8, #0x51
4000327c: 54000c00     	b.eq	0x400033fc <tui_launch+0x72c>
40003280: 12001c08     	and	w8, w0, #0xff
40003284: 7100311f     	cmp	w8, #0xc
40003288: 5400010c     	b.gt	0x400032a8 <tui_launch+0x5d8>
4000328c: 7100251f     	cmp	w8, #0x9
40003290: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
40003294: 91260318     	add	x24, x24, #0x980
40003298: 54ffd540     	b.eq	0x40002d40 <tui_launch+0x70>
4000329c: 7100291f     	cmp	w8, #0xa
400032a0: 540002e0     	b.eq	0x400032fc <tui_launch+0x62c>
400032a4: 17fffeab     	b	0x40002d50 <tui_launch+0x80>
400032a8: 7100351f     	cmp	w8, #0xd
400032ac: d0000078     	adrp	x24, 0x40011000 <var_values+0x6a8>
400032b0: 91260318     	add	x24, x24, #0x980
400032b4: 54000240     	b.eq	0x400032fc <tui_launch+0x62c>
400032b8: 71006d1f     	cmp	w8, #0x1b
400032bc: 54ffd4a1     	b.ne	0x40002d50 <tui_launch+0x80>
400032c0: 9400018e     	bl	0x400038f8 <uart_getc>
400032c4: 12001c13     	and	w19, w0, #0xff
400032c8: 9400018c     	bl	0x400038f8 <uart_getc>
400032cc: 71016e7f     	cmp	w19, #0x5b
400032d0: 54ffd401     	b.ne	0x40002d50 <tui_launch+0x80>
400032d4: 12001c08     	and	w8, w0, #0xff
400032d8: 7101051f     	cmp	w8, #0x41
400032dc: 54000781     	b.ne	0x400033cc <tui_launch+0x6fc>
400032e0: b9497388     	ldr	w8, [x28, #0x970]
400032e4: 35ffd368     	cbnz	w8, 0x40002d50 <tui_launch+0x80>
400032e8: b9497768     	ldr	w8, [x27, #0x974]
400032ec: 71000508     	subs	w8, w8, #0x1
400032f0: 54ffd30b     	b.lt	0x40002d50 <tui_launch+0x80>
400032f4: b9097768     	str	w8, [x27, #0x974]
400032f8: 17fffe96     	b	0x40002d50 <tui_launch+0x80>
400032fc: b9497388     	ldr	w8, [x28, #0x970]
40003300: 35ffd288     	cbnz	w8, 0x40002d50 <tui_launch+0x80>
40003304: b9497b48     	ldr	w8, [x26, #0x978]
40003308: 7100051f     	cmp	w8, #0x1
4000330c: 54ffd22b     	b.lt	0x40002d50 <tui_launch+0x80>
40003310: b9897768     	ldrsw	x8, [x27, #0x974]
40003314: f8687b15     	ldr	x21, [x24, x8, lsl #3]
40003318: b4000115     	cbz	x21, 0x40003338 <tui_launch+0x668>
4000331c: b94022a8     	ldr	w8, [x21, #0x20]
40003320: 7100051f     	cmp	w8, #0x1
40003324: 54000161     	b.ne	0x40003350 <tui_launch+0x680>
40003328: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
4000332c: b909777f     	str	wzr, [x27, #0x974]
40003330: f904b515     	str	x21, [x8, #0x968]
40003334: 17fffe87     	b	0x40002d50 <tui_launch+0x80>
40003338: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
4000333c: b909777f     	str	wzr, [x27, #0x974]
40003340: f944b528     	ldr	x8, [x9, #0x968]
40003344: f9421908     	ldr	x8, [x8, #0x430]
40003348: f904b528     	str	x8, [x9, #0x968]
4000334c: 17fffe81     	b	0x40002d50 <tui_launch+0x80>
40003350: 390223ff     	strb	wzr, [sp, #0x88]
40003354: aa1903e0     	mov	x0, x25
40003358: 94000610     	bl	0x40004b98 <vfs_find>
4000335c: eb0002bf     	cmp	x21, x0
40003360: 540001e0     	b.eq	0x4000339c <tui_launch+0x6cc>
40003364: 910023e0     	add	x0, sp, #0x8
40003368: 910223e1     	add	x1, sp, #0x88
4000336c: 97fffdb3     	bl	0x40002a38 <kstrcpy>
40003370: 910223e0     	add	x0, sp, #0x88
40003374: aa1903e1     	mov	x1, x25
40003378: 97fffdb0     	bl	0x40002a38 <kstrcpy>
4000337c: 910223e0     	add	x0, sp, #0x88
40003380: aa1503e1     	mov	x1, x21
40003384: 97fffd85     	bl	0x40002998 <kstrcat>
40003388: 910223e0     	add	x0, sp, #0x88
4000338c: 910023e1     	add	x1, sp, #0x8
40003390: 97fffd82     	bl	0x40002998 <kstrcat>
40003394: f9421ab5     	ldr	x21, [x21, #0x430]
40003398: b5fffdf5     	cbnz	x21, 0x40003354 <tui_launch+0x684>
4000339c: 910223e0     	add	x0, sp, #0x88
400033a0: 97fffd77     	bl	0x4000297c <kstrlen>
400033a4: b5000080     	cbnz	x0, 0x400033b4 <tui_launch+0x6e4>
400033a8: 910223e0     	add	x0, sp, #0x88
400033ac: aa1903e1     	mov	x1, x25
400033b0: 97fffda2     	bl	0x40002a38 <kstrcpy>
400033b4: 910223e0     	add	x0, sp, #0x88
400033b8: 97fff3c3     	bl	0x400002c4 <launch_kedit>
400033bc: d503201f     	nop
400033c0: 1003b920     	adr	x0, 0x4000aae4 <__rodata_start+0x1ae4>
400033c4: 94000119     	bl	0x40003828 <uart_puts>
400033c8: 17fffe62     	b	0x40002d50 <tui_launch+0x80>
400033cc: 7101091f     	cmp	w8, #0x42
400033d0: 54ffcc01     	b.ne	0x40002d50 <tui_launch+0x80>
400033d4: b9497388     	ldr	w8, [x28, #0x970]
400033d8: 35ffcbc8     	cbnz	w8, 0x40002d50 <tui_launch+0x80>
400033dc: b9497b49     	ldr	w9, [x26, #0x978]
400033e0: b9497768     	ldr	w8, [x27, #0x974]
400033e4: 51000529     	sub	w9, w9, #0x1
400033e8: 6b09011f     	cmp	w8, w9
400033ec: 54ffcb2a     	b.ge	0x40002d50 <tui_launch+0x80>
400033f0: 11000508     	add	w8, w8, #0x1
400033f4: b9097768     	str	w8, [x27, #0x974]
400033f8: 17fffe56     	b	0x40002d50 <tui_launch+0x80>
400033fc: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003400: 912edc00     	add	x0, x0, #0xbb7
40003404: 94000109     	bl	0x40003828 <uart_puts>
40003408: a9564ff4     	ldp	x20, x19, [sp, #0x160]
4000340c: a95557f6     	ldp	x22, x21, [sp, #0x150]
40003410: a9545ff8     	ldp	x24, x23, [sp, #0x140]
40003414: a95367fa     	ldp	x26, x25, [sp, #0x130]
40003418: a9526ffc     	ldp	x28, x27, [sp, #0x120]
4000341c: a9517bfd     	ldp	x29, x30, [sp, #0x110]
40003420: 9105c3ff     	add	sp, sp, #0x170
40003424: d65f03c0     	ret

0000000040003428 <draw_box>:
40003428: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
4000342c: 90000048     	adrp	x8, 0x4000b000 <__rodata_start+0x2000>
40003430: 9129c108     	add	x8, x8, #0xa70
40003434: 7100007f     	cmp	w3, #0x0
40003438: f0000029     	adrp	x9, 0x4000a000 <__rodata_start+0x1000>
4000343c: 910d2529     	add	x9, x9, #0x349
40003440: a9034ff4     	stp	x20, x19, [sp, #0x30]
40003444: 2a0003f3     	mov	w19, w0
40003448: 9a880120     	csel	x0, x9, x8, eq
4000344c: a9015ff8     	stp	x24, x23, [sp, #0x10]
40003450: a90257f6     	stp	x22, x21, [sp, #0x20]
40003454: 910003fd     	mov	x29, sp
40003458: aa0203f4     	mov	x20, x2
4000345c: 2a0103f5     	mov	w21, w1
40003460: 940000f2     	bl	0x40003828 <uart_puts>
40003464: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003468: 9121c400     	add	x0, x0, #0x871
4000346c: 52800041     	mov	w1, #0x2                // =2
40003470: 2a1303e2     	mov	w2, w19
40003474: 94000202     	bl	0x40003c7c <uart_printf>
40003478: 51000ab6     	sub	w22, w21, #0x2
4000347c: 510006b7     	sub	w23, w21, #0x1
40003480: d0000035     	adrp	x21, 0x40009000 <__rodata_start>
40003484: 91158eb5     	add	x21, x21, #0x563
40003488: 2a1603f8     	mov	w24, w22
4000348c: aa1503e0     	mov	x0, x21
40003490: 940000e6     	bl	0x40003828 <uart_puts>
40003494: 71000718     	subs	w24, w24, #0x1
40003498: 54ffffa1     	b.ne	0x4000348c <draw_box+0x64>
4000349c: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400034a0: 91282000     	add	x0, x0, #0xa08
400034a4: 940000e1     	bl	0x40003828 <uart_puts>
400034a8: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
400034ac: 9121f400     	add	x0, x0, #0x87d
400034b0: 11000a62     	add	w2, w19, #0x2
400034b4: 52800041     	mov	w1, #0x2                // =2
400034b8: aa1403e3     	mov	x3, x20
400034bc: 940001f0     	bl	0x40003c7c <uart_printf>
400034c0: f0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
400034c4: 911be694     	add	x20, x20, #0x6f9
400034c8: 52800061     	mov	w1, #0x3                // =3
400034cc: aa1403e0     	mov	x0, x20
400034d0: 2a1303e2     	mov	w2, w19
400034d4: 940001ea     	bl	0x40003c7c <uart_printf>
400034d8: 0b1302e2     	add	w2, w23, w19
400034dc: aa1403e0     	mov	x0, x20
400034e0: 52800061     	mov	w1, #0x3                // =3
400034e4: 940001e6     	bl	0x40003c7c <uart_printf>
400034e8: aa1403e0     	mov	x0, x20
400034ec: 52800081     	mov	w1, #0x4                // =4
400034f0: 2a1303e2     	mov	w2, w19
400034f4: 940001e2     	bl	0x40003c7c <uart_printf>
400034f8: 0b1302e2     	add	w2, w23, w19
400034fc: aa1403e0     	mov	x0, x20
40003500: 52800081     	mov	w1, #0x4                // =4
40003504: 940001de     	bl	0x40003c7c <uart_printf>
40003508: aa1403e0     	mov	x0, x20
4000350c: 528000a1     	mov	w1, #0x5                // =5
40003510: 2a1303e2     	mov	w2, w19
40003514: 940001da     	bl	0x40003c7c <uart_printf>
40003518: 0b1302e2     	add	w2, w23, w19
4000351c: aa1403e0     	mov	x0, x20
40003520: 528000a1     	mov	w1, #0x5                // =5
40003524: 940001d6     	bl	0x40003c7c <uart_printf>
40003528: aa1403e0     	mov	x0, x20
4000352c: 528000c1     	mov	w1, #0x6                // =6
40003530: 2a1303e2     	mov	w2, w19
40003534: 940001d2     	bl	0x40003c7c <uart_printf>
40003538: 0b1302e2     	add	w2, w23, w19
4000353c: aa1403e0     	mov	x0, x20
40003540: 528000c1     	mov	w1, #0x6                // =6
40003544: 940001ce     	bl	0x40003c7c <uart_printf>
40003548: aa1403e0     	mov	x0, x20
4000354c: 528000e1     	mov	w1, #0x7                // =7
40003550: 2a1303e2     	mov	w2, w19
40003554: 940001ca     	bl	0x40003c7c <uart_printf>
40003558: 0b1302e2     	add	w2, w23, w19
4000355c: aa1403e0     	mov	x0, x20
40003560: 528000e1     	mov	w1, #0x7                // =7
40003564: 940001c6     	bl	0x40003c7c <uart_printf>
40003568: aa1403e0     	mov	x0, x20
4000356c: 52800101     	mov	w1, #0x8                // =8
40003570: 2a1303e2     	mov	w2, w19
40003574: 940001c2     	bl	0x40003c7c <uart_printf>
40003578: 0b1302e2     	add	w2, w23, w19
4000357c: aa1403e0     	mov	x0, x20
40003580: 52800101     	mov	w1, #0x8                // =8
40003584: 940001be     	bl	0x40003c7c <uart_printf>
40003588: aa1403e0     	mov	x0, x20
4000358c: 52800121     	mov	w1, #0x9                // =9
40003590: 2a1303e2     	mov	w2, w19
40003594: 940001ba     	bl	0x40003c7c <uart_printf>
40003598: 0b1302e2     	add	w2, w23, w19
4000359c: aa1403e0     	mov	x0, x20
400035a0: 52800121     	mov	w1, #0x9                // =9
400035a4: 940001b6     	bl	0x40003c7c <uart_printf>
400035a8: aa1403e0     	mov	x0, x20
400035ac: 52800141     	mov	w1, #0xa                // =10
400035b0: 2a1303e2     	mov	w2, w19
400035b4: 940001b2     	bl	0x40003c7c <uart_printf>
400035b8: 0b1302e2     	add	w2, w23, w19
400035bc: aa1403e0     	mov	x0, x20
400035c0: 52800141     	mov	w1, #0xa                // =10
400035c4: 940001ae     	bl	0x40003c7c <uart_printf>
400035c8: aa1403e0     	mov	x0, x20
400035cc: 52800161     	mov	w1, #0xb                // =11
400035d0: 2a1303e2     	mov	w2, w19
400035d4: 940001aa     	bl	0x40003c7c <uart_printf>
400035d8: 0b1302e2     	add	w2, w23, w19
400035dc: aa1403e0     	mov	x0, x20
400035e0: 52800161     	mov	w1, #0xb                // =11
400035e4: 940001a6     	bl	0x40003c7c <uart_printf>
400035e8: aa1403e0     	mov	x0, x20
400035ec: 52800181     	mov	w1, #0xc                // =12
400035f0: 2a1303e2     	mov	w2, w19
400035f4: 940001a2     	bl	0x40003c7c <uart_printf>
400035f8: 0b1302e2     	add	w2, w23, w19
400035fc: aa1403e0     	mov	x0, x20
40003600: 52800181     	mov	w1, #0xc                // =12
40003604: 9400019e     	bl	0x40003c7c <uart_printf>
40003608: aa1403e0     	mov	x0, x20
4000360c: 528001a1     	mov	w1, #0xd                // =13
40003610: 2a1303e2     	mov	w2, w19
40003614: 9400019a     	bl	0x40003c7c <uart_printf>
40003618: 0b1302e2     	add	w2, w23, w19
4000361c: aa1403e0     	mov	x0, x20
40003620: 528001a1     	mov	w1, #0xd                // =13
40003624: 94000196     	bl	0x40003c7c <uart_printf>
40003628: aa1403e0     	mov	x0, x20
4000362c: 528001c1     	mov	w1, #0xe                // =14
40003630: 2a1303e2     	mov	w2, w19
40003634: 94000192     	bl	0x40003c7c <uart_printf>
40003638: 0b1302e2     	add	w2, w23, w19
4000363c: aa1403e0     	mov	x0, x20
40003640: 528001c1     	mov	w1, #0xe                // =14
40003644: 9400018e     	bl	0x40003c7c <uart_printf>
40003648: aa1403e0     	mov	x0, x20
4000364c: 528001e1     	mov	w1, #0xf                // =15
40003650: 2a1303e2     	mov	w2, w19
40003654: 9400018a     	bl	0x40003c7c <uart_printf>
40003658: 0b1302e2     	add	w2, w23, w19
4000365c: aa1403e0     	mov	x0, x20
40003660: 528001e1     	mov	w1, #0xf                // =15
40003664: 94000186     	bl	0x40003c7c <uart_printf>
40003668: aa1403e0     	mov	x0, x20
4000366c: 52800201     	mov	w1, #0x10               // =16
40003670: 2a1303e2     	mov	w2, w19
40003674: 94000182     	bl	0x40003c7c <uart_printf>
40003678: 0b1302e2     	add	w2, w23, w19
4000367c: aa1403e0     	mov	x0, x20
40003680: 52800201     	mov	w1, #0x10               // =16
40003684: 9400017e     	bl	0x40003c7c <uart_printf>
40003688: aa1403e0     	mov	x0, x20
4000368c: 52800221     	mov	w1, #0x11               // =17
40003690: 2a1303e2     	mov	w2, w19
40003694: 9400017a     	bl	0x40003c7c <uart_printf>
40003698: 0b1302e2     	add	w2, w23, w19
4000369c: aa1403e0     	mov	x0, x20
400036a0: 52800221     	mov	w1, #0x11               // =17
400036a4: 94000176     	bl	0x40003c7c <uart_printf>
400036a8: aa1403e0     	mov	x0, x20
400036ac: 52800241     	mov	w1, #0x12               // =18
400036b0: 2a1303e2     	mov	w2, w19
400036b4: 94000172     	bl	0x40003c7c <uart_printf>
400036b8: 0b1302e2     	add	w2, w23, w19
400036bc: aa1403e0     	mov	x0, x20
400036c0: 52800241     	mov	w1, #0x12               // =18
400036c4: 9400016e     	bl	0x40003c7c <uart_printf>
400036c8: aa1403e0     	mov	x0, x20
400036cc: 52800261     	mov	w1, #0x13               // =19
400036d0: 2a1303e2     	mov	w2, w19
400036d4: 9400016a     	bl	0x40003c7c <uart_printf>
400036d8: 0b1302e2     	add	w2, w23, w19
400036dc: aa1403e0     	mov	x0, x20
400036e0: 52800261     	mov	w1, #0x13               // =19
400036e4: 94000166     	bl	0x40003c7c <uart_printf>
400036e8: aa1403e0     	mov	x0, x20
400036ec: 52800281     	mov	w1, #0x14               // =20
400036f0: 2a1303e2     	mov	w2, w19
400036f4: 94000162     	bl	0x40003c7c <uart_printf>
400036f8: 0b1302e2     	add	w2, w23, w19
400036fc: aa1403e0     	mov	x0, x20
40003700: 52800281     	mov	w1, #0x14               // =20
40003704: 9400015e     	bl	0x40003c7c <uart_printf>
40003708: aa1403e0     	mov	x0, x20
4000370c: 528002a1     	mov	w1, #0x15               // =21
40003710: 2a1303e2     	mov	w2, w19
40003714: 9400015a     	bl	0x40003c7c <uart_printf>
40003718: 0b1302e2     	add	w2, w23, w19
4000371c: aa1403e0     	mov	x0, x20
40003720: 528002a1     	mov	w1, #0x15               // =21
40003724: 94000156     	bl	0x40003c7c <uart_printf>
40003728: aa1403e0     	mov	x0, x20
4000372c: 528002c1     	mov	w1, #0x16               // =22
40003730: 2a1303e2     	mov	w2, w19
40003734: 94000152     	bl	0x40003c7c <uart_printf>
40003738: 0b1302e2     	add	w2, w23, w19
4000373c: aa1403e0     	mov	x0, x20
40003740: 528002c1     	mov	w1, #0x16               // =22
40003744: 9400014e     	bl	0x40003c7c <uart_printf>
40003748: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
4000374c: 91176800     	add	x0, x0, #0x5da
40003750: 528002e1     	mov	w1, #0x17               // =23
40003754: 2a1303e2     	mov	w2, w19
40003758: 94000149     	bl	0x40003c7c <uart_printf>
4000375c: d0000033     	adrp	x19, 0x40009000 <__rodata_start>
40003760: 91158e73     	add	x19, x19, #0x563
40003764: aa1303e0     	mov	x0, x19
40003768: 94000030     	bl	0x40003828 <uart_puts>
4000376c: 710006d6     	subs	w22, w22, #0x1
40003770: 54ffffa1     	b.ne	0x40003764 <draw_box+0x33c>
40003774: d0000020     	adrp	x0, 0x40009000 <__rodata_start>
40003778: 91179800     	add	x0, x0, #0x5e6
4000377c: 9400002b     	bl	0x40003828 <uart_puts>
40003780: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40003784: f0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40003788: 9137a400     	add	x0, x0, #0xde9
4000378c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40003790: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40003794: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40003798: 14000024     	b	0x40003828 <uart_puts>

000000004000379c <uart_init>:
4000379c: 52800608     	mov	w8, #0x30               // =48
400037a0: 528001a9     	mov	w9, #0xd                // =13
400037a4: 5280002a     	mov	w10, #0x1               // =1
400037a8: 72a12008     	movk	w8, #0x900, lsl #16
400037ac: b900011f     	str	wzr, [x8]
400037b0: b81f4109     	stur	w9, [x8, #-0xc]
400037b4: 52800e09     	mov	w9, #0x70               // =112
400037b8: b81f810a     	stur	w10, [x8, #-0x8]
400037bc: b81fc109     	stur	w9, [x8, #-0x4]
400037c0: 52806029     	mov	w9, #0x301              // =769
400037c4: b9000109     	str	w9, [x8]
400037c8: d65f03c0     	ret

00000000400037cc <uart_putc>:
400037cc: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
400037d0: b94b8108     	ldr	w8, [x8, #0xb80]
400037d4: 340001a8     	cbz	w8, 0x40003808 <uart_putc+0x3c>
400037d8: d0000068     	adrp	x8, 0x40011000 <var_values+0x6a8>
400037dc: 5287ffca     	mov	w10, #0x3ffe            // =16382
400037e0: b94b8509     	ldr	w9, [x8, #0xb84]
400037e4: 6b0a013f     	cmp	w9, w10
400037e8: 5400010c     	b.gt	0x40003808 <uart_putc+0x3c>
400037ec: 93407d29     	sxtw	x9, w9
400037f0: d503201f     	nop
400037f4: 10071caa     	adr	x10, 0x40011b88 <kernel_capture_buffer>
400037f8: 9100052b     	add	x11, x9, #0x1
400037fc: 38296940     	strb	w0, [x10, x9]
40003800: b90b850b     	str	w11, [x8, #0xb84]
40003804: 382b695f     	strb	wzr, [x10, x11]
40003808: 52800308     	mov	w8, #0x18               // =24
4000380c: 72a12008     	movk	w8, #0x900, lsl #16
40003810: b9400109     	ldr	w9, [x8]
40003814: 372fffe9     	tbnz	w9, #0x5, 0x40003810 <uart_putc+0x44>
40003818: 12001c08     	and	w8, w0, #0xff
4000381c: 52a12009     	mov	w9, #0x9000000          // =150994944
40003820: b9000128     	str	w8, [x9]
40003824: d65f03c0     	ret

0000000040003828 <uart_puts>:
40003828: 52800308     	mov	w8, #0x18               // =24
4000382c: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003830: d000006a     	adrp	x10, 0x40011000 <var_values+0x6a8>
40003834: 72a12008     	movk	w8, #0x900, lsl #16
40003838: d503201f     	nop
4000383c: 10071a6b     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003840: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003844: 528001ad     	mov	w13, #0xd               // =13
40003848: 52a1200e     	mov	w14, #0x9000000         // =150994944
4000384c: 3940000f     	ldrb	w15, [x0]
40003850: 710029ff     	cmp	w15, #0xa
40003854: 540000a0     	b.eq	0x40003868 <uart_puts+0x40>
40003858: 3400042f     	cbz	w15, 0x400038dc <uart_puts+0xb4>
4000385c: b94b8130     	ldr	w16, [x9, #0xb80]
40003860: 35000250     	cbnz	w16, 0x400038a8 <uart_puts+0x80>
40003864: 14000019     	b	0x400038c8 <uart_puts+0xa0>
40003868: b94b812f     	ldr	w15, [x9, #0xb80]
4000386c: 3400012f     	cbz	w15, 0x40003890 <uart_puts+0x68>
40003870: b94b854f     	ldr	w15, [x10, #0xb84]
40003874: 6b0c01ff     	cmp	w15, w12
40003878: 540000cc     	b.gt	0x40003890 <uart_puts+0x68>
4000387c: 93407def     	sxtw	x15, w15
40003880: 910005f0     	add	x16, x15, #0x1
40003884: 382f696d     	strb	w13, [x11, x15]
40003888: b90b8550     	str	w16, [x10, #0xb84]
4000388c: 3830697f     	strb	wzr, [x11, x16]
40003890: b940010f     	ldr	w15, [x8]
40003894: 372fffef     	tbnz	w15, #0x5, 0x40003890 <uart_puts+0x68>
40003898: b90001cd     	str	w13, [x14]
4000389c: 3940000f     	ldrb	w15, [x0]
400038a0: b94b8130     	ldr	w16, [x9, #0xb80]
400038a4: 34000130     	cbz	w16, 0x400038c8 <uart_puts+0xa0>
400038a8: b94b8550     	ldr	w16, [x10, #0xb84]
400038ac: 6b0c021f     	cmp	w16, w12
400038b0: 540000cc     	b.gt	0x400038c8 <uart_puts+0xa0>
400038b4: 93407e10     	sxtw	x16, w16
400038b8: 91000611     	add	x17, x16, #0x1
400038bc: 3830696f     	strb	w15, [x11, x16]
400038c0: b90b8551     	str	w17, [x10, #0xb84]
400038c4: 3831697f     	strb	wzr, [x11, x17]
400038c8: 91000400     	add	x0, x0, #0x1
400038cc: b9400110     	ldr	w16, [x8]
400038d0: 372ffff0     	tbnz	w16, #0x5, 0x400038cc <uart_puts+0xa4>
400038d4: b90001cf     	str	w15, [x14]
400038d8: 17ffffdd     	b	0x4000384c <uart_puts+0x24>
400038dc: d65f03c0     	ret

00000000400038e0 <uart_has_data>:
400038e0: 52800308     	mov	w8, #0x18               // =24
400038e4: 52800029     	mov	w9, #0x1                // =1
400038e8: 72a12008     	movk	w8, #0x900, lsl #16
400038ec: b9400108     	ldr	w8, [x8]
400038f0: 0a681120     	bic	w0, w9, w8, lsr #4
400038f4: d65f03c0     	ret

00000000400038f8 <uart_getc>:
400038f8: 52800308     	mov	w8, #0x18               // =24
400038fc: 72a12008     	movk	w8, #0x900, lsl #16
40003900: b9400109     	ldr	w9, [x8]
40003904: 3727ffe9     	tbnz	w9, #0x4, 0x40003900 <uart_getc+0x8>
40003908: 52a12008     	mov	w8, #0x9000000          // =150994944
4000390c: b9400100     	ldr	w0, [x8]
40003910: d65f03c0     	ret

0000000040003914 <uart_print_hex_raw>:
40003914: 52800308     	mov	w8, #0x18               // =24
40003918: 2a1f03eb     	mov	w11, wzr
4000391c: 5280078c     	mov	w12, #0x3c              // =60
40003920: 72a12008     	movk	w8, #0x900, lsl #16
40003924: d503201f     	nop
40003928: 1002dece     	adr	x14, 0x40009500 <__rodata_start+0x500>
4000392c: d000006d     	adrp	x13, 0x40011000 <var_values+0x6a8>
40003930: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003934: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003938: d503201f     	nop
4000393c: 1007126a     	adr	x10, 0x40011b88 <kernel_capture_buffer>
40003940: 52a12010     	mov	w16, #0x9000000         // =150994944
40003944: 14000003     	b	0x40003950 <uart_print_hex_raw+0x3c>
40003948: b400032c     	cbz	x12, 0x400039ac <uart_print_hex_raw+0x98>
4000394c: d100118c     	sub	x12, x12, #0x4
40003950: 9acc2411     	lsr	x17, x0, x12
40003954: 53027d92     	lsr	w18, w12, #2
40003958: 92400e31     	and	x17, x17, #0xf
4000395c: 6b01025f     	cmp	w18, w1
40003960: fa40aa20     	ccmp	x17, #0x0, #0x0, ge
40003964: 1a9f056b     	csinc	w11, w11, wzr, eq
40003968: 34ffff0b     	cbz	w11, 0x40003948 <uart_print_hex_raw+0x34>
4000396c: b94b81b2     	ldr	w18, [x13, #0xb80]
40003970: 387169d1     	ldrb	w17, [x14, x17]
40003974: 34000132     	cbz	w18, 0x40003998 <uart_print_hex_raw+0x84>
40003978: b94b8532     	ldr	w18, [x9, #0xb84]
4000397c: 6b0f025f     	cmp	w18, w15
40003980: 540000cc     	b.gt	0x40003998 <uart_print_hex_raw+0x84>
40003984: 93407e52     	sxtw	x18, w18
40003988: 91000642     	add	x2, x18, #0x1
4000398c: 38326951     	strb	w17, [x10, x18]
40003990: b90b8522     	str	w2, [x9, #0xb84]
40003994: 3822695f     	strb	wzr, [x10, x2]
40003998: b9400112     	ldr	w18, [x8]
4000399c: 372ffff2     	tbnz	w18, #0x5, 0x40003998 <uart_print_hex_raw+0x84>
400039a0: b9000211     	str	w17, [x16]
400039a4: b5fffd4c     	cbnz	x12, 0x4000394c <uart_print_hex_raw+0x38>
400039a8: d65f03c0     	ret
400039ac: b94b81ab     	ldr	w11, [x13, #0xb80]
400039b0: 3400016b     	cbz	w11, 0x400039dc <uart_print_hex_raw+0xc8>
400039b4: b94b852b     	ldr	w11, [x9, #0xb84]
400039b8: 5287ffcc     	mov	w12, #0x3ffe            // =16382
400039bc: 6b0c017f     	cmp	w11, w12
400039c0: 540000ec     	b.gt	0x400039dc <uart_print_hex_raw+0xc8>
400039c4: 93407d6b     	sxtw	x11, w11
400039c8: 5280060c     	mov	w12, #0x30              // =48
400039cc: 9100056d     	add	x13, x11, #0x1
400039d0: 382b694c     	strb	w12, [x10, x11]
400039d4: b90b852d     	str	w13, [x9, #0xb84]
400039d8: 382d695f     	strb	wzr, [x10, x13]
400039dc: b9400109     	ldr	w9, [x8]
400039e0: 372fffe9     	tbnz	w9, #0x5, 0x400039dc <uart_print_hex_raw+0xc8>
400039e4: 52a12008     	mov	w8, #0x9000000          // =150994944
400039e8: 52800609     	mov	w9, #0x30               // =48
400039ec: b9000109     	str	w9, [x8]
400039f0: d65f03c0     	ret

00000000400039f4 <uart_print_hex>:
400039f4: 52800308     	mov	w8, #0x18               // =24
400039f8: f000002c     	adrp	x12, 0x4000a000 <__rodata_start+0x1000>
400039fc: 9108318c     	add	x12, x12, #0x20c
40003a00: 72a12008     	movk	w8, #0x900, lsl #16
40003a04: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
40003a08: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003a0c: d503201f     	nop
40003a10: 10070bca     	adr	x10, 0x40011b88 <kernel_capture_buffer>
40003a14: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003a18: 528001ae     	mov	w14, #0xd               // =13
40003a1c: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003a20: 39400190     	ldrb	w16, [x12]
40003a24: 71002a1f     	cmp	w16, #0xa
40003a28: 540000a0     	b.eq	0x40003a3c <uart_print_hex+0x48>
40003a2c: 34000410     	cbz	w16, 0x40003aac <uart_print_hex+0xb8>
40003a30: b94b8171     	ldr	w17, [x11, #0xb80]
40003a34: 35000231     	cbnz	w17, 0x40003a78 <uart_print_hex+0x84>
40003a38: 14000018     	b	0x40003a98 <uart_print_hex+0xa4>
40003a3c: b94b8171     	ldr	w17, [x11, #0xb80]
40003a40: 34000131     	cbz	w17, 0x40003a64 <uart_print_hex+0x70>
40003a44: b94b8531     	ldr	w17, [x9, #0xb84]
40003a48: 6b0d023f     	cmp	w17, w13
40003a4c: 540000cc     	b.gt	0x40003a64 <uart_print_hex+0x70>
40003a50: 93407e31     	sxtw	x17, w17
40003a54: 91000632     	add	x18, x17, #0x1
40003a58: 3831694e     	strb	w14, [x10, x17]
40003a5c: b90b8532     	str	w18, [x9, #0xb84]
40003a60: 3832695f     	strb	wzr, [x10, x18]
40003a64: b9400111     	ldr	w17, [x8]
40003a68: 372ffff1     	tbnz	w17, #0x5, 0x40003a64 <uart_print_hex+0x70>
40003a6c: b90001ee     	str	w14, [x15]
40003a70: b94b8171     	ldr	w17, [x11, #0xb80]
40003a74: 34000131     	cbz	w17, 0x40003a98 <uart_print_hex+0xa4>
40003a78: b94b8531     	ldr	w17, [x9, #0xb84]
40003a7c: 6b0d023f     	cmp	w17, w13
40003a80: 540000cc     	b.gt	0x40003a98 <uart_print_hex+0xa4>
40003a84: 93407e31     	sxtw	x17, w17
40003a88: 91000632     	add	x18, x17, #0x1
40003a8c: 38316950     	strb	w16, [x10, x17]
40003a90: b90b8532     	str	w18, [x9, #0xb84]
40003a94: 3832695f     	strb	wzr, [x10, x18]
40003a98: 9100058c     	add	x12, x12, #0x1
40003a9c: b9400111     	ldr	w17, [x8]
40003aa0: 372ffff1     	tbnz	w17, #0x5, 0x40003a9c <uart_print_hex+0xa8>
40003aa4: b90001f0     	str	w16, [x15]
40003aa8: 17ffffde     	b	0x40003a20 <uart_print_hex+0x2c>
40003aac: 2a1f03ec     	mov	w12, wzr
40003ab0: d503201f     	nop
40003ab4: 1002d26d     	adr	x13, 0x40009500 <__rodata_start+0x500>
40003ab8: 5280078e     	mov	w14, #0x3c              // =60
40003abc: 5287ffcf     	mov	w15, #0x3ffe            // =16382
40003ac0: 52a12010     	mov	w16, #0x9000000         // =150994944
40003ac4: 14000003     	b	0x40003ad0 <uart_print_hex+0xdc>
40003ac8: b40002ee     	cbz	x14, 0x40003b24 <uart_print_hex+0x130>
40003acc: d10011ce     	sub	x14, x14, #0x4
40003ad0: 9ace2411     	lsr	x17, x0, x14
40003ad4: f2400e31     	ands	x17, x17, #0xf
40003ad8: fa4009c4     	ccmp	x14, #0x0, #0x4, eq
40003adc: 1a9f158c     	csinc	w12, w12, wzr, ne
40003ae0: 34ffff4c     	cbz	w12, 0x40003ac8 <uart_print_hex+0xd4>
40003ae4: b94b8172     	ldr	w18, [x11, #0xb80]
40003ae8: 387169b1     	ldrb	w17, [x13, x17]
40003aec: 34000132     	cbz	w18, 0x40003b10 <uart_print_hex+0x11c>
40003af0: b94b8532     	ldr	w18, [x9, #0xb84]
40003af4: 6b0f025f     	cmp	w18, w15
40003af8: 540000cc     	b.gt	0x40003b10 <uart_print_hex+0x11c>
40003afc: 93407e52     	sxtw	x18, w18
40003b00: 91000641     	add	x1, x18, #0x1
40003b04: 38326951     	strb	w17, [x10, x18]
40003b08: b90b8521     	str	w1, [x9, #0xb84]
40003b0c: 3821695f     	strb	wzr, [x10, x1]
40003b10: b9400112     	ldr	w18, [x8]
40003b14: 372ffff2     	tbnz	w18, #0x5, 0x40003b10 <uart_print_hex+0x11c>
40003b18: b9000211     	str	w17, [x16]
40003b1c: b5fffd8e     	cbnz	x14, 0x40003acc <uart_print_hex+0xd8>
40003b20: d65f03c0     	ret
40003b24: b94b816b     	ldr	w11, [x11, #0xb80]
40003b28: 3400016b     	cbz	w11, 0x40003b54 <uart_print_hex+0x160>
40003b2c: b94b852b     	ldr	w11, [x9, #0xb84]
40003b30: 5287ffcc     	mov	w12, #0x3ffe            // =16382
40003b34: 6b0c017f     	cmp	w11, w12
40003b38: 540000ec     	b.gt	0x40003b54 <uart_print_hex+0x160>
40003b3c: 93407d6b     	sxtw	x11, w11
40003b40: 5280060c     	mov	w12, #0x30              // =48
40003b44: 9100056d     	add	x13, x11, #0x1
40003b48: 382b694c     	strb	w12, [x10, x11]
40003b4c: b90b852d     	str	w13, [x9, #0xb84]
40003b50: 382d695f     	strb	wzr, [x10, x13]
40003b54: b9400109     	ldr	w9, [x8]
40003b58: 372fffe9     	tbnz	w9, #0x5, 0x40003b54 <uart_print_hex+0x160>
40003b5c: 52a12008     	mov	w8, #0x9000000          // =150994944
40003b60: 52800609     	mov	w9, #0x30               // =48
40003b64: b9000109     	str	w9, [x8]
40003b68: d65f03c0     	ret

0000000040003b6c <uart_print_dec>:
40003b6c: d10083ff     	sub	sp, sp, #0x20
40003b70: 52800308     	mov	w8, #0x18               // =24
40003b74: 72a12008     	movk	w8, #0x900, lsl #16
40003b78: b4000540     	cbz	x0, 0x40003c20 <uart_print_dec+0xb4>
40003b7c: b202e7ea     	mov	x10, #-0x3333333333333334 // =-3689348814741910324
40003b80: aa1f03e9     	mov	x9, xzr
40003b84: 5280014b     	mov	w11, #0xa               // =10
40003b88: f29999aa     	movk	x10, #0xcccd
40003b8c: 910023ec     	add	x12, sp, #0x8
40003b90: 9bca7c0d     	umulh	x13, x0, x10
40003b94: f100241f     	cmp	x0, #0x9
40003b98: d343fdad     	lsr	x13, x13, #3
40003b9c: 1b0b81ae     	msub	w14, w13, w11, w0
40003ba0: aa0d03e0     	mov	x0, x13
40003ba4: 321c05ce     	orr	w14, w14, #0x30
40003ba8: 3829698e     	strb	w14, [x12, x9]
40003bac: 91000529     	add	x9, x9, #0x1
40003bb0: 54ffff08     	b.hi	0x40003b90 <uart_print_dec+0x24>
40003bb4: 910023ea     	add	x10, sp, #0x8
40003bb8: d000006b     	adrp	x11, 0x40011000 <var_values+0x6a8>
40003bbc: d000006c     	adrp	x12, 0x40011000 <var_values+0x6a8>
40003bc0: 5287ffcd     	mov	w13, #0x3ffe            // =16382
40003bc4: d503201f     	nop
40003bc8: 1006fe0e     	adr	x14, 0x40011b88 <kernel_capture_buffer>
40003bcc: 52a1200f     	mov	w15, #0x9000000         // =150994944
40003bd0: d1000530     	sub	x16, x9, #0x1
40003bd4: b94b8172     	ldr	w18, [x11, #0xb80]
40003bd8: 38706951     	ldrb	w17, [x10, x16]
40003bdc: 34000132     	cbz	w18, 0x40003c00 <uart_print_dec+0x94>
40003be0: b94b8592     	ldr	w18, [x12, #0xb84]
40003be4: 6b0d025f     	cmp	w18, w13
40003be8: 540000cc     	b.gt	0x40003c00 <uart_print_dec+0x94>
40003bec: 93407e52     	sxtw	x18, w18
40003bf0: 91000640     	add	x0, x18, #0x1
40003bf4: 383269d1     	strb	w17, [x14, x18]
40003bf8: b90b8580     	str	w0, [x12, #0xb84]
40003bfc: 382069df     	strb	wzr, [x14, x0]
40003c00: b9400112     	ldr	w18, [x8]
40003c04: 372ffff2     	tbnz	w18, #0x5, 0x40003c00 <uart_print_dec+0x94>
40003c08: 7100053f     	cmp	w9, #0x1
40003c0c: aa1003e9     	mov	x9, x16
40003c10: b90001f1     	str	w17, [x15]
40003c14: 54fffdec     	b.gt	0x40003bd0 <uart_print_dec+0x64>
40003c18: 910083ff     	add	sp, sp, #0x20
40003c1c: d65f03c0     	ret
40003c20: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003c24: b94b8129     	ldr	w9, [x9, #0xb80]
40003c28: 340001c9     	cbz	w9, 0x40003c60 <uart_print_dec+0xf4>
40003c2c: d0000069     	adrp	x9, 0x40011000 <var_values+0x6a8>
40003c30: 5287ffcb     	mov	w11, #0x3ffe            // =16382
40003c34: b94b852a     	ldr	w10, [x9, #0xb84]
40003c38: 6b0b015f     	cmp	w10, w11
40003c3c: 5400012c     	b.gt	0x40003c60 <uart_print_dec+0xf4>
40003c40: 93407d4a     	sxtw	x10, w10
40003c44: d503201f     	nop
40003c48: 1006fa0b     	adr	x11, 0x40011b88 <kernel_capture_buffer>
40003c4c: 5280060c     	mov	w12, #0x30              // =48
40003c50: 9100054d     	add	x13, x10, #0x1
40003c54: 382a696c     	strb	w12, [x11, x10]
40003c58: b90b852d     	str	w13, [x9, #0xb84]
40003c5c: 382d697f     	strb	wzr, [x11, x13]
40003c60: b9400109     	ldr	w9, [x8]
40003c64: 372fffe9     	tbnz	w9, #0x5, 0x40003c60 <uart_print_dec+0xf4>
40003c68: 52a12008     	mov	w8, #0x9000000          // =150994944
40003c6c: 52800609     	mov	w9, #0x30               // =48
40003c70: b9000109     	str	w9, [x8]
40003c74: 910083ff     	add	sp, sp, #0x20
40003c78: d65f03c0     	ret

0000000040003c7c <uart_printf>:
40003c7c: d10343ff     	sub	sp, sp, #0xd0
40003c80: a9077bfd     	stp	x29, x30, [sp, #0x70]
40003c84: 9101c3fd     	add	x29, sp, #0x70
40003c88: 910003e8     	mov	x8, sp
40003c8c: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40003c90: 52800315     	mov	w21, #0x18              // =24
40003c94: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003c98: a9086ffc     	stp	x28, x27, [sp, #0x80]
40003c9c: 72a12015     	movk	w21, #0x900, lsl #16
40003ca0: 128006e9     	mov	w9, #-0x38              // =-56
40003ca4: a90967fa     	stp	x26, x25, [sp, #0x90]
40003ca8: 9100e108     	add	x8, x8, #0x38
40003cac: 910183aa     	add	x10, x29, #0x60
40003cb0: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40003cb4: d0000076     	adrp	x22, 0x40011000 <var_values+0x6a8>
40003cb8: d0000077     	adrp	x23, 0x40011000 <var_values+0x6a8>
40003cbc: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40003cc0: aa0003f3     	mov	x19, x0
40003cc4: aa1f03f4     	mov	x20, xzr
40003cc8: 5287ffd8     	mov	w24, #0x3ffe            // =16382
40003ccc: d503201f     	nop
40003cd0: 1006f5d9     	adr	x25, 0x40011b88 <kernel_capture_buffer>
40003cd4: 528001ba     	mov	w26, #0xd               // =13
40003cd8: 52a1201b     	mov	w27, #0x9000000         // =150994944
40003cdc: 528004ae     	mov	w14, #0x25              // =37
40003ce0: f29999af     	movk	x15, #0xcccd
40003ce4: 52800150     	mov	w16, #0xa               // =10
40003ce8: d10063bc     	sub	x28, x29, #0x18
40003cec: d503201f     	nop
40003cf0: 1002c091     	adr	x17, 0x40009500 <__rodata_start+0x500>
40003cf4: a9000be1     	stp	x1, x2, [sp]
40003cf8: a90113e3     	stp	x3, x4, [sp, #0x10]
40003cfc: a9021be5     	stp	x5, x6, [sp, #0x20]
40003d00: f9002be9     	str	x9, [sp, #0x50]
40003d04: f90023e8     	str	x8, [sp, #0x40]
40003d08: a9032be7     	stp	x7, x10, [sp, #0x30]
40003d0c: 14000004     	b	0x40003d1c <uart_printf+0xa0>
40003d10: 52800608     	mov	w8, #0x30               // =48
40003d14: b9000368     	str	w8, [x27]
40003d18: 91000694     	add	x20, x20, #0x1
40003d1c: 38746a68     	ldrb	w8, [x19, x20]
40003d20: 7100291f     	cmp	w8, #0xa
40003d24: 54000440     	b.eq	0x40003dac <uart_printf+0x130>
40003d28: 7100951f     	cmp	w8, #0x25
40003d2c: 540000a0     	b.eq	0x40003d40 <uart_printf+0xc4>
40003d30: 34003ae8     	cbz	w8, 0x4000448c <uart_printf+0x810>
40003d34: b94b82c9     	ldr	w9, [x22, #0xb80]
40003d38: 350005a9     	cbnz	w9, 0x40003dec <uart_printf+0x170>
40003d3c: 14000034     	b	0x40003e0c <uart_printf+0x190>
40003d40: 9100068a     	add	x10, x20, #0x1
40003d44: 386a6a68     	ldrb	w8, [x19, x10]
40003d48: 7101b11f     	cmp	w8, #0x6c
40003d4c: 54000661     	b.ne	0x40003e18 <uart_printf+0x19c>
40003d50: 91000a89     	add	x9, x20, #0x2
40003d54: 91000e8b     	add	x11, x20, #0x3
40003d58: 38696a6a     	ldrb	w10, [x19, x9]
40003d5c: 7101b15f     	cmp	w10, #0x6c
40003d60: 9a890174     	csel	x20, x11, x9, eq
40003d64: 38746a69     	ldrb	w9, [x19, x20]
40003d68: 7101bd3f     	cmp	w9, #0x6f
40003d6c: 540005ed     	b.le	0x40003e28 <uart_printf+0x1ac>
40003d70: 7101d13f     	cmp	w9, #0x74
40003d74: 5400080c     	b.gt	0x40003e74 <uart_printf+0x1f8>
40003d78: 7101c13f     	cmp	w9, #0x70
40003d7c: 54000f00     	b.eq	0x40003f5c <uart_printf+0x2e0>
40003d80: 7101cd3f     	cmp	w9, #0x73
40003d84: 54000b61     	b.ne	0x40003ef0 <uart_printf+0x274>
40003d88: b98053e8     	ldrsw	x8, [sp, #0x50]
40003d8c: 36f81408     	tbz	w8, #0x1f, 0x4000400c <uart_printf+0x390>
40003d90: 11002109     	add	w9, w8, #0x8
40003d94: 3100211f     	cmn	w8, #0x8
40003d98: b90053e9     	str	w9, [sp, #0x50]
40003d9c: 54001388     	b.hi	0x4000400c <uart_printf+0x390>
40003da0: f94023e9     	ldr	x9, [sp, #0x40]
40003da4: 8b080128     	add	x8, x9, x8
40003da8: 1400009c     	b	0x40004018 <uart_printf+0x39c>
40003dac: b94b82c8     	ldr	w8, [x22, #0xb80]
40003db0: 34000128     	cbz	w8, 0x40003dd4 <uart_printf+0x158>
40003db4: b94b86e8     	ldr	w8, [x23, #0xb84]
40003db8: 6b18011f     	cmp	w8, w24
40003dbc: 540000cc     	b.gt	0x40003dd4 <uart_printf+0x158>
40003dc0: 93407d08     	sxtw	x8, w8
40003dc4: 91000509     	add	x9, x8, #0x1
40003dc8: 38286b3a     	strb	w26, [x25, x8]
40003dcc: b90b86e9     	str	w9, [x23, #0xb84]
40003dd0: 38296b3f     	strb	wzr, [x25, x9]
40003dd4: b94002a8     	ldr	w8, [x21]
40003dd8: 372fffe8     	tbnz	w8, #0x5, 0x40003dd4 <uart_printf+0x158>
40003ddc: b900037a     	str	w26, [x27]
40003de0: 38746a68     	ldrb	w8, [x19, x20]
40003de4: b94b82c9     	ldr	w9, [x22, #0xb80]
40003de8: 34000129     	cbz	w9, 0x40003e0c <uart_printf+0x190>
40003dec: b94b86e9     	ldr	w9, [x23, #0xb84]
40003df0: 6b18013f     	cmp	w9, w24
40003df4: 540000cc     	b.gt	0x40003e0c <uart_printf+0x190>
40003df8: 93407d29     	sxtw	x9, w9
40003dfc: 9100052a     	add	x10, x9, #0x1
40003e00: 38296b28     	strb	w8, [x25, x9]
40003e04: b90b86ea     	str	w10, [x23, #0xb84]
40003e08: 382a6b3f     	strb	wzr, [x25, x10]
40003e0c: b94002a9     	ldr	w9, [x21]
40003e10: 372fffe9     	tbnz	w9, #0x5, 0x40003e0c <uart_printf+0x190>
40003e14: 17ffffc0     	b	0x40003d14 <uart_printf+0x98>
40003e18: 2a0803e9     	mov	w9, w8
40003e1c: aa0a03f4     	mov	x20, x10
40003e20: 7101bd3f     	cmp	w9, #0x6f
40003e24: 54fffa6c     	b.gt	0x40003d70 <uart_printf+0xf4>
40003e28: 7100953f     	cmp	w9, #0x25
40003e2c: 54000440     	b.eq	0x40003eb4 <uart_printf+0x238>
40003e30: 71018d3f     	cmp	w9, #0x63
40003e34: 54000c00     	b.eq	0x40003fb4 <uart_printf+0x338>
40003e38: 7101913f     	cmp	w9, #0x64
40003e3c: 540005a1     	b.ne	0x40003ef0 <uart_printf+0x274>
40003e40: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e44: 7101b11f     	cmp	w8, #0x6c
40003e48: 540017c1     	b.ne	0x40004140 <uart_printf+0x4c4>
40003e4c: 36f823c9     	tbz	w9, #0x1f, 0x400042c4 <uart_printf+0x648>
40003e50: 11002128     	add	w8, w9, #0x8
40003e54: 3100213f     	cmn	w9, #0x8
40003e58: b90053e8     	str	w8, [sp, #0x50]
40003e5c: 54002348     	b.hi	0x400042c4 <uart_printf+0x648>
40003e60: f94023e8     	ldr	x8, [sp, #0x40]
40003e64: 8b090108     	add	x8, x8, x9
40003e68: f9400108     	ldr	x8, [x8]
40003e6c: b6f829a8     	tbz	x8, #0x3f, 0x400043a0 <uart_printf+0x724>
40003e70: 1400011a     	b	0x400042d8 <uart_printf+0x65c>
40003e74: 7101d53f     	cmp	w9, #0x75
40003e78: 54000840     	b.eq	0x40003f80 <uart_printf+0x304>
40003e7c: 7101e13f     	cmp	w9, #0x78
40003e80: 54000381     	b.ne	0x40003ef0 <uart_printf+0x274>
40003e84: b98053e9     	ldrsw	x9, [sp, #0x50]
40003e88: 7101b11f     	cmp	w8, #0x6c
40003e8c: 540014a1     	b.ne	0x40004120 <uart_printf+0x4a4>
40003e90: 36f81d49     	tbz	w9, #0x1f, 0x40004238 <uart_printf+0x5bc>
40003e94: 11002128     	add	w8, w9, #0x8
40003e98: 3100213f     	cmn	w9, #0x8
40003e9c: b90053e8     	str	w8, [sp, #0x50]
40003ea0: 54001cc8     	b.hi	0x40004238 <uart_printf+0x5bc>
40003ea4: f94023e8     	ldr	x8, [sp, #0x40]
40003ea8: 8b090108     	add	x8, x8, x9
40003eac: f9400108     	ldr	x8, [x8]
40003eb0: 140000eb     	b	0x4000425c <uart_printf+0x5e0>
40003eb4: b94b82c8     	ldr	w8, [x22, #0xb80]
40003eb8: 34000128     	cbz	w8, 0x40003edc <uart_printf+0x260>
40003ebc: b94b86e8     	ldr	w8, [x23, #0xb84]
40003ec0: 6b18011f     	cmp	w8, w24
40003ec4: 540000cc     	b.gt	0x40003edc <uart_printf+0x260>
40003ec8: 93407d08     	sxtw	x8, w8
40003ecc: 91000509     	add	x9, x8, #0x1
40003ed0: 38286b2e     	strb	w14, [x25, x8]
40003ed4: b90b86e9     	str	w9, [x23, #0xb84]
40003ed8: 38296b3f     	strb	wzr, [x25, x9]
40003edc: b94002a8     	ldr	w8, [x21]
40003ee0: 372fffe8     	tbnz	w8, #0x5, 0x40003edc <uart_printf+0x260>
40003ee4: b900036e     	str	w14, [x27]
40003ee8: 91000694     	add	x20, x20, #0x1
40003eec: 17ffff8c     	b	0x40003d1c <uart_printf+0xa0>
40003ef0: b94b82c8     	ldr	w8, [x22, #0xb80]
40003ef4: 34000128     	cbz	w8, 0x40003f18 <uart_printf+0x29c>
40003ef8: b94b86e8     	ldr	w8, [x23, #0xb84]
40003efc: 6b18011f     	cmp	w8, w24
40003f00: 540000cc     	b.gt	0x40003f18 <uart_printf+0x29c>
40003f04: 93407d08     	sxtw	x8, w8
40003f08: 91000509     	add	x9, x8, #0x1
40003f0c: 38286b2e     	strb	w14, [x25, x8]
40003f10: b90b86e9     	str	w9, [x23, #0xb84]
40003f14: 38296b3f     	strb	wzr, [x25, x9]
40003f18: b94002a8     	ldr	w8, [x21]
40003f1c: 372fffe8     	tbnz	w8, #0x5, 0x40003f18 <uart_printf+0x29c>
40003f20: b900036e     	str	w14, [x27]
40003f24: b94b82c9     	ldr	w9, [x22, #0xb80]
40003f28: 38746a68     	ldrb	w8, [x19, x20]
40003f2c: 34000129     	cbz	w9, 0x40003f50 <uart_printf+0x2d4>
40003f30: b94b86e9     	ldr	w9, [x23, #0xb84]
40003f34: 6b18013f     	cmp	w9, w24
40003f38: 540000cc     	b.gt	0x40003f50 <uart_printf+0x2d4>
40003f3c: 93407d29     	sxtw	x9, w9
40003f40: 9100052a     	add	x10, x9, #0x1
40003f44: 38296b28     	strb	w8, [x25, x9]
40003f48: b90b86ea     	str	w10, [x23, #0xb84]
40003f4c: 382a6b3f     	strb	wzr, [x25, x10]
40003f50: b94002a9     	ldr	w9, [x21]
40003f54: 372fffe9     	tbnz	w9, #0x5, 0x40003f50 <uart_printf+0x2d4>
40003f58: 17ffff6f     	b	0x40003d14 <uart_printf+0x98>
40003f5c: b98053e8     	ldrsw	x8, [sp, #0x50]
40003f60: 36f803c8     	tbz	w8, #0x1f, 0x40003fd8 <uart_printf+0x35c>
40003f64: 11002109     	add	w9, w8, #0x8
40003f68: 3100211f     	cmn	w8, #0x8
40003f6c: b90053e9     	str	w9, [sp, #0x50]
40003f70: 54000348     	b.hi	0x40003fd8 <uart_printf+0x35c>
40003f74: f94023e9     	ldr	x9, [sp, #0x40]
40003f78: 8b080128     	add	x8, x9, x8
40003f7c: 1400001a     	b	0x40003fe4 <uart_printf+0x368>
40003f80: b98053e9     	ldrsw	x9, [sp, #0x50]
40003f84: 7101b11f     	cmp	w8, #0x6c
40003f88: 54000bc1     	b.ne	0x40004100 <uart_printf+0x484>
40003f8c: 36f80ea9     	tbz	w9, #0x1f, 0x40004160 <uart_printf+0x4e4>
40003f90: 11002128     	add	w8, w9, #0x8
40003f94: 3100213f     	cmn	w9, #0x8
40003f98: b90053e8     	str	w8, [sp, #0x50]
40003f9c: 54000e28     	b.hi	0x40004160 <uart_printf+0x4e4>
40003fa0: f94023e8     	ldr	x8, [sp, #0x40]
40003fa4: 8b090108     	add	x8, x8, x9
40003fa8: f9400109     	ldr	x9, [x8]
40003fac: b50010a9     	cbnz	x9, 0x400041c0 <uart_printf+0x544>
40003fb0: 14000071     	b	0x40004174 <uart_printf+0x4f8>
40003fb4: b98053e8     	ldrsw	x8, [sp, #0x50]
40003fb8: 36f80828     	tbz	w8, #0x1f, 0x400040bc <uart_printf+0x440>
40003fbc: 11002109     	add	w9, w8, #0x8
40003fc0: 3100211f     	cmn	w8, #0x8
40003fc4: b90053e9     	str	w9, [sp, #0x50]
40003fc8: 540007a8     	b.hi	0x400040bc <uart_printf+0x440>
40003fcc: f94023e9     	ldr	x9, [sp, #0x40]
40003fd0: 8b080128     	add	x8, x9, x8
40003fd4: 1400003d     	b	0x400040c8 <uart_printf+0x44c>
40003fd8: f9401fe8     	ldr	x8, [sp, #0x38]
40003fdc: 91002109     	add	x9, x8, #0x8
40003fe0: f9001fe9     	str	x9, [sp, #0x38]
40003fe4: f9400100     	ldr	x0, [x8]
40003fe8: 97fffe83     	bl	0x400039f4 <uart_print_hex>
40003fec: b202e7ef     	mov	x15, #-0x3333333333333334 // =-3689348814741910324
40003ff0: 528004ae     	mov	w14, #0x25              // =37
40003ff4: 52800150     	mov	w16, #0xa               // =10
40003ff8: f29999af     	movk	x15, #0xcccd
40003ffc: d503201f     	nop
40004000: 1002a811     	adr	x17, 0x40009500 <__rodata_start+0x500>
40004004: 91000694     	add	x20, x20, #0x1
40004008: 17ffff45     	b	0x40003d1c <uart_printf+0xa0>
4000400c: f9401fe8     	ldr	x8, [sp, #0x38]
40004010: 91002109     	add	x9, x8, #0x8
40004014: f9001fe9     	str	x9, [sp, #0x38]
40004018: f9400108     	ldr	x8, [x8]
4000401c: f0000029     	adrp	x9, 0x4000b000 <__rodata_start+0x2000>
40004020: 9129e129     	add	x9, x9, #0xa78
40004024: f100011f     	cmp	x8, #0x0
40004028: 9a880128     	csel	x8, x9, x8, eq
4000402c: 39400109     	ldrb	w9, [x8]
40004030: 7100293f     	cmp	w9, #0xa
40004034: 540000a0     	b.eq	0x40004048 <uart_printf+0x3cc>
40004038: 34ffe709     	cbz	w9, 0x40003d18 <uart_printf+0x9c>
4000403c: b94b82ca     	ldr	w10, [x22, #0xb80]
40004040: 3500024a     	cbnz	w10, 0x40004088 <uart_printf+0x40c>
40004044: 14000019     	b	0x400040a8 <uart_printf+0x42c>
40004048: b94b82c9     	ldr	w9, [x22, #0xb80]
4000404c: 34000129     	cbz	w9, 0x40004070 <uart_printf+0x3f4>
40004050: b94b86e9     	ldr	w9, [x23, #0xb84]
40004054: 6b18013f     	cmp	w9, w24
40004058: 540000cc     	b.gt	0x40004070 <uart_printf+0x3f4>
4000405c: 93407d29     	sxtw	x9, w9
40004060: 9100052a     	add	x10, x9, #0x1
40004064: 38296b3a     	strb	w26, [x25, x9]
40004068: b90b86ea     	str	w10, [x23, #0xb84]
4000406c: 382a6b3f     	strb	wzr, [x25, x10]
40004070: b94002a9     	ldr	w9, [x21]
40004074: 372fffe9     	tbnz	w9, #0x5, 0x40004070 <uart_printf+0x3f4>
40004078: b900037a     	str	w26, [x27]
4000407c: 39400109     	ldrb	w9, [x8]
40004080: b94b82ca     	ldr	w10, [x22, #0xb80]
40004084: 3400012a     	cbz	w10, 0x400040a8 <uart_printf+0x42c>
40004088: b94b86ea     	ldr	w10, [x23, #0xb84]
4000408c: 6b18015f     	cmp	w10, w24
40004090: 540000cc     	b.gt	0x400040a8 <uart_printf+0x42c>
40004094: 93407d4a     	sxtw	x10, w10
40004098: 9100054b     	add	x11, x10, #0x1
4000409c: 382a6b29     	strb	w9, [x25, x10]
400040a0: b90b86eb     	str	w11, [x23, #0xb84]
400040a4: 382b6b3f     	strb	wzr, [x25, x11]
400040a8: 91000508     	add	x8, x8, #0x1
400040ac: b94002aa     	ldr	w10, [x21]
400040b0: 372fffea     	tbnz	w10, #0x5, 0x400040ac <uart_printf+0x430>
400040b4: b9000369     	str	w9, [x27]
400040b8: 17ffffdd     	b	0x4000402c <uart_printf+0x3b0>
400040bc: f9401fe8     	ldr	x8, [sp, #0x38]
400040c0: 91002109     	add	x9, x8, #0x8
400040c4: f9001fe9     	str	x9, [sp, #0x38]
400040c8: b94b82c9     	ldr	w9, [x22, #0xb80]
400040cc: 39400108     	ldrb	w8, [x8]
400040d0: 34000129     	cbz	w9, 0x400040f4 <uart_printf+0x478>
400040d4: b94b86e9     	ldr	w9, [x23, #0xb84]
400040d8: 6b18013f     	cmp	w9, w24
400040dc: 540000cc     	b.gt	0x400040f4 <uart_printf+0x478>
400040e0: 93407d29     	sxtw	x9, w9
400040e4: 9100052a     	add	x10, x9, #0x1
400040e8: 38296b28     	strb	w8, [x25, x9]
400040ec: b90b86ea     	str	w10, [x23, #0xb84]
400040f0: 382a6b3f     	strb	wzr, [x25, x10]
400040f4: b94002a9     	ldr	w9, [x21]
400040f8: 372fffe9     	tbnz	w9, #0x5, 0x400040f4 <uart_printf+0x478>
400040fc: 17ffff06     	b	0x40003d14 <uart_printf+0x98>
40004100: 36f80569     	tbz	w9, #0x1f, 0x400041ac <uart_printf+0x530>
40004104: 11002128     	add	w8, w9, #0x8
40004108: 3100213f     	cmn	w9, #0x8
4000410c: b90053e8     	str	w8, [sp, #0x50]
40004110: 540004e8     	b.hi	0x400041ac <uart_printf+0x530>
40004114: f94023e8     	ldr	x8, [sp, #0x40]
40004118: 8b090108     	add	x8, x8, x9
4000411c: 14000027     	b	0x400041b8 <uart_printf+0x53c>
40004120: 36f80969     	tbz	w9, #0x1f, 0x4000424c <uart_printf+0x5d0>
40004124: 11002128     	add	w8, w9, #0x8
40004128: 3100213f     	cmn	w9, #0x8
4000412c: b90053e8     	str	w8, [sp, #0x50]
40004130: 540008e8     	b.hi	0x4000424c <uart_printf+0x5d0>
40004134: f94023e8     	ldr	x8, [sp, #0x40]
40004138: 8b090108     	add	x8, x8, x9
4000413c: 14000047     	b	0x40004258 <uart_printf+0x5dc>
40004140: 36f81269     	tbz	w9, #0x1f, 0x4000438c <uart_printf+0x710>
40004144: 11002128     	add	w8, w9, #0x8
40004148: 3100213f     	cmn	w9, #0x8
4000414c: b90053e8     	str	w8, [sp, #0x50]
40004150: 540011e8     	b.hi	0x4000438c <uart_printf+0x710>
40004154: f94023e8     	ldr	x8, [sp, #0x40]
40004158: 8b090108     	add	x8, x8, x9
4000415c: 1400008f     	b	0x40004398 <uart_printf+0x71c>
40004160: f9401fe8     	ldr	x8, [sp, #0x38]
40004164: 91002109     	add	x9, x8, #0x8
40004168: f9001fe9     	str	x9, [sp, #0x38]
4000416c: f9400109     	ldr	x9, [x8]
40004170: b5000289     	cbnz	x9, 0x400041c0 <uart_printf+0x544>
40004174: b94b82c8     	ldr	w8, [x22, #0xb80]
40004178: 34000148     	cbz	w8, 0x400041a0 <uart_printf+0x524>
4000417c: b94b86e8     	ldr	w8, [x23, #0xb84]
40004180: 6b18011f     	cmp	w8, w24
40004184: 540000ec     	b.gt	0x400041a0 <uart_printf+0x524>
40004188: 93407d08     	sxtw	x8, w8
4000418c: 5280060a     	mov	w10, #0x30              // =48
40004190: 91000509     	add	x9, x8, #0x1
40004194: 38286b2a     	strb	w10, [x25, x8]
40004198: b90b86e9     	str	w9, [x23, #0xb84]
4000419c: 38296b3f     	strb	wzr, [x25, x9]
400041a0: b94002a8     	ldr	w8, [x21]
400041a4: 372fffe8     	tbnz	w8, #0x5, 0x400041a0 <uart_printf+0x524>
400041a8: 17fffeda     	b	0x40003d10 <uart_printf+0x94>
400041ac: f9401fe8     	ldr	x8, [sp, #0x38]
400041b0: 91002109     	add	x9, x8, #0x8
400041b4: f9001fe9     	str	x9, [sp, #0x38]
400041b8: b9400109     	ldr	w9, [x8]
400041bc: b4fffdc9     	cbz	x9, 0x40004174 <uart_printf+0x4f8>
400041c0: aa1f03ea     	mov	x10, xzr
400041c4: 9bcf7d28     	umulh	x8, x9, x15
400041c8: f100253f     	cmp	x9, #0x9
400041cc: d343fd0b     	lsr	x11, x8, #3
400041d0: 91000548     	add	x8, x10, #0x1
400041d4: 1b10a56c     	msub	w12, w11, w16, w9
400041d8: 321c0589     	orr	w9, w12, #0x30
400041dc: 382a6b89     	strb	w9, [x28, x10]
400041e0: aa0803ea     	mov	x10, x8
400041e4: aa0b03e9     	mov	x9, x11
400041e8: 54fffee8     	b.hi	0x400041c4 <uart_printf+0x548>
400041ec: d1000509     	sub	x9, x8, #0x1
400041f0: b94b82cb     	ldr	w11, [x22, #0xb80]
400041f4: 38696b8a     	ldrb	w10, [x28, x9]
400041f8: 3400012b     	cbz	w11, 0x4000421c <uart_printf+0x5a0>
400041fc: b94b86eb     	ldr	w11, [x23, #0xb84]
40004200: 6b18017f     	cmp	w11, w24
40004204: 540000cc     	b.gt	0x4000421c <uart_printf+0x5a0>
40004208: 93407d6b     	sxtw	x11, w11
4000420c: 9100056c     	add	x12, x11, #0x1
40004210: 382b6b2a     	strb	w10, [x25, x11]
40004214: b90b86ec     	str	w12, [x23, #0xb84]
40004218: 382c6b3f     	strb	wzr, [x25, x12]
4000421c: b94002ab     	ldr	w11, [x21]
40004220: 372fffeb     	tbnz	w11, #0x5, 0x4000421c <uart_printf+0x5a0>
40004224: 7100051f     	cmp	w8, #0x1
40004228: aa0903e8     	mov	x8, x9
4000422c: b900036a     	str	w10, [x27]
40004230: 54fffdec     	b.gt	0x400041ec <uart_printf+0x570>
40004234: 17fffeb9     	b	0x40003d18 <uart_printf+0x9c>
40004238: f9401fe8     	ldr	x8, [sp, #0x38]
4000423c: 91002109     	add	x9, x8, #0x8
40004240: f9001fe9     	str	x9, [sp, #0x38]
40004244: f9400108     	ldr	x8, [x8]
40004248: 14000005     	b	0x4000425c <uart_printf+0x5e0>
4000424c: f9401fe8     	ldr	x8, [sp, #0x38]
40004250: 91002109     	add	x9, x8, #0x8
40004254: f9001fe9     	str	x9, [sp, #0x38]
40004258: b9400108     	ldr	w8, [x8]
4000425c: 2a1f03e9     	mov	w9, wzr
40004260: 5280078a     	mov	w10, #0x3c              // =60
40004264: 14000003     	b	0x40004270 <uart_printf+0x5f4>
40004268: b4000daa     	cbz	x10, 0x4000441c <uart_printf+0x7a0>
4000426c: d100114a     	sub	x10, x10, #0x4
40004270: 9aca250b     	lsr	x11, x8, x10
40004274: f2400d6b     	ands	x11, x11, #0xf
40004278: fa400944     	ccmp	x10, #0x0, #0x4, eq
4000427c: 1a9f1529     	csinc	w9, w9, wzr, ne
40004280: 34ffff49     	cbz	w9, 0x40004268 <uart_printf+0x5ec>
40004284: b94b82cc     	ldr	w12, [x22, #0xb80]
40004288: 386b6a2b     	ldrb	w11, [x17, x11]
4000428c: 3400012c     	cbz	w12, 0x400042b0 <uart_printf+0x634>
40004290: b94b86ec     	ldr	w12, [x23, #0xb84]
40004294: 6b18019f     	cmp	w12, w24
40004298: 540000cc     	b.gt	0x400042b0 <uart_printf+0x634>
4000429c: 93407d8c     	sxtw	x12, w12
400042a0: 9100058d     	add	x13, x12, #0x1
400042a4: 382c6b2b     	strb	w11, [x25, x12]
400042a8: b90b86ed     	str	w13, [x23, #0xb84]
400042ac: 382d6b3f     	strb	wzr, [x25, x13]
400042b0: b94002ac     	ldr	w12, [x21]
400042b4: 372fffec     	tbnz	w12, #0x5, 0x400042b0 <uart_printf+0x634>
400042b8: b900036b     	str	w11, [x27]
400042bc: b5fffd8a     	cbnz	x10, 0x4000426c <uart_printf+0x5f0>
400042c0: 17fffe96     	b	0x40003d18 <uart_printf+0x9c>
400042c4: f9401fe8     	ldr	x8, [sp, #0x38]
400042c8: 91002109     	add	x9, x8, #0x8
400042cc: f9001fe9     	str	x9, [sp, #0x38]
400042d0: f9400108     	ldr	x8, [x8]
400042d4: b6f80668     	tbz	x8, #0x3f, 0x400043a0 <uart_printf+0x724>
400042d8: b94b82c9     	ldr	w9, [x22, #0xb80]
400042dc: 34000149     	cbz	w9, 0x40004304 <uart_printf+0x688>
400042e0: b94b86e9     	ldr	w9, [x23, #0xb84]
400042e4: 6b18013f     	cmp	w9, w24
400042e8: 540000ec     	b.gt	0x40004304 <uart_printf+0x688>
400042ec: 93407d29     	sxtw	x9, w9
400042f0: 528005ab     	mov	w11, #0x2d              // =45
400042f4: 9100052a     	add	x10, x9, #0x1
400042f8: 38296b2b     	strb	w11, [x25, x9]
400042fc: b90b86ea     	str	w10, [x23, #0xb84]
40004300: 382a6b3f     	strb	wzr, [x25, x10]
40004304: b94002a9     	ldr	w9, [x21]
40004308: 372fffe9     	tbnz	w9, #0x5, 0x40004304 <uart_printf+0x688>
4000430c: aa1f03e9     	mov	x9, xzr
40004310: 528005aa     	mov	w10, #0x2d              // =45
40004314: cb0803e8     	neg	x8, x8
40004318: b900036a     	str	w10, [x27]
4000431c: 9bcf7d0a     	umulh	x10, x8, x15
40004320: f100251f     	cmp	x8, #0x9
40004324: d343fd4a     	lsr	x10, x10, #3
40004328: 1b10a14b     	msub	w11, w10, w16, w8
4000432c: 321c0568     	orr	w8, w11, #0x30
40004330: 38296b88     	strb	w8, [x28, x9]
40004334: 91000529     	add	x9, x9, #0x1
40004338: aa0a03e8     	mov	x8, x10
4000433c: 54ffff08     	b.hi	0x4000431c <uart_printf+0x6a0>
40004340: d1000528     	sub	x8, x9, #0x1
40004344: b94b82cb     	ldr	w11, [x22, #0xb80]
40004348: 38686b8a     	ldrb	w10, [x28, x8]
4000434c: 3400012b     	cbz	w11, 0x40004370 <uart_printf+0x6f4>
40004350: b94b86eb     	ldr	w11, [x23, #0xb84]
40004354: 6b18017f     	cmp	w11, w24
40004358: 540000cc     	b.gt	0x40004370 <uart_printf+0x6f4>
4000435c: 93407d6b     	sxtw	x11, w11
40004360: 9100056c     	add	x12, x11, #0x1
40004364: 382b6b2a     	strb	w10, [x25, x11]
40004368: b90b86ec     	str	w12, [x23, #0xb84]
4000436c: 382c6b3f     	strb	wzr, [x25, x12]
40004370: b94002ab     	ldr	w11, [x21]
40004374: 372fffeb     	tbnz	w11, #0x5, 0x40004370 <uart_printf+0x6f4>
40004378: 7100053f     	cmp	w9, #0x1
4000437c: aa0803e9     	mov	x9, x8
40004380: b900036a     	str	w10, [x27]
40004384: 54fffdec     	b.gt	0x40004340 <uart_printf+0x6c4>
40004388: 17fffe64     	b	0x40003d18 <uart_printf+0x9c>
4000438c: f9401fe8     	ldr	x8, [sp, #0x38]
40004390: 91002109     	add	x9, x8, #0x8
40004394: f9001fe9     	str	x9, [sp, #0x38]
40004398: b9800108     	ldrsw	x8, [x8]
4000439c: b7fff9e8     	tbnz	x8, #0x3f, 0x400042d8 <uart_printf+0x65c>
400043a0: b40005a8     	cbz	x8, 0x40004454 <uart_printf+0x7d8>
400043a4: aa1f03ea     	mov	x10, xzr
400043a8: 9bcf7d09     	umulh	x9, x8, x15
400043ac: f100251f     	cmp	x8, #0x9
400043b0: d343fd2b     	lsr	x11, x9, #3
400043b4: 91000549     	add	x9, x10, #0x1
400043b8: 1b10a16c     	msub	w12, w11, w16, w8
400043bc: 321c0588     	orr	w8, w12, #0x30
400043c0: 382a6b88     	strb	w8, [x28, x10]
400043c4: aa0903ea     	mov	x10, x9
400043c8: aa0b03e8     	mov	x8, x11
400043cc: 54fffee8     	b.hi	0x400043a8 <uart_printf+0x72c>
400043d0: d1000528     	sub	x8, x9, #0x1
400043d4: b94b82cb     	ldr	w11, [x22, #0xb80]
400043d8: 38686b8a     	ldrb	w10, [x28, x8]
400043dc: 3400012b     	cbz	w11, 0x40004400 <uart_printf+0x784>
400043e0: b94b86eb     	ldr	w11, [x23, #0xb84]
400043e4: 6b18017f     	cmp	w11, w24
400043e8: 540000cc     	b.gt	0x40004400 <uart_printf+0x784>
400043ec: 93407d6b     	sxtw	x11, w11
400043f0: 9100056c     	add	x12, x11, #0x1
400043f4: 382b6b2a     	strb	w10, [x25, x11]
400043f8: b90b86ec     	str	w12, [x23, #0xb84]
400043fc: 382c6b3f     	strb	wzr, [x25, x12]
40004400: b94002ab     	ldr	w11, [x21]
40004404: 372fffeb     	tbnz	w11, #0x5, 0x40004400 <uart_printf+0x784>
40004408: 7100053f     	cmp	w9, #0x1
4000440c: aa0803e9     	mov	x9, x8
40004410: b900036a     	str	w10, [x27]
40004414: 54fffdec     	b.gt	0x400043d0 <uart_printf+0x754>
40004418: 17fffe40     	b	0x40003d18 <uart_printf+0x9c>
4000441c: b94b82c8     	ldr	w8, [x22, #0xb80]
40004420: 34000148     	cbz	w8, 0x40004448 <uart_printf+0x7cc>
40004424: b94b86e8     	ldr	w8, [x23, #0xb84]
40004428: 6b18011f     	cmp	w8, w24
4000442c: 540000ec     	b.gt	0x40004448 <uart_printf+0x7cc>
40004430: 93407d08     	sxtw	x8, w8
40004434: 5280060a     	mov	w10, #0x30              // =48
40004438: 91000509     	add	x9, x8, #0x1
4000443c: 38286b2a     	strb	w10, [x25, x8]
40004440: b90b86e9     	str	w9, [x23, #0xb84]
40004444: 38296b3f     	strb	wzr, [x25, x9]
40004448: b94002a8     	ldr	w8, [x21]
4000444c: 372fffe8     	tbnz	w8, #0x5, 0x40004448 <uart_printf+0x7cc>
40004450: 17fffe30     	b	0x40003d10 <uart_printf+0x94>
40004454: b94b82c8     	ldr	w8, [x22, #0xb80]
40004458: 34000148     	cbz	w8, 0x40004480 <uart_printf+0x804>
4000445c: b94b86e8     	ldr	w8, [x23, #0xb84]
40004460: 6b18011f     	cmp	w8, w24
40004464: 540000ec     	b.gt	0x40004480 <uart_printf+0x804>
40004468: 93407d08     	sxtw	x8, w8
4000446c: 5280060a     	mov	w10, #0x30              // =48
40004470: 91000509     	add	x9, x8, #0x1
40004474: 38286b2a     	strb	w10, [x25, x8]
40004478: b90b86e9     	str	w9, [x23, #0xb84]
4000447c: 38296b3f     	strb	wzr, [x25, x9]
40004480: b94002a8     	ldr	w8, [x21]
40004484: 372fffe8     	tbnz	w8, #0x5, 0x40004480 <uart_printf+0x804>
40004488: 17fffe22     	b	0x40003d10 <uart_printf+0x94>
4000448c: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004490: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004494: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004498: a94967fa     	ldp	x26, x25, [sp, #0x90]
4000449c: a9486ffc     	ldp	x28, x27, [sp, #0x80]
400044a0: a9477bfd     	ldp	x29, x30, [sp, #0x70]
400044a4: 910343ff     	add	sp, sp, #0xd0
400044a8: d65f03c0     	ret

00000000400044ac <vfs_init>:
400044ac: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
400044b0: a9044ff4     	stp	x20, x19, [sp, #0x40]
400044b4: b0000093     	adrp	x19, 0x40015000 <kernel_capture_buffer+0x3478>
400044b8: 912e8273     	add	x19, x19, #0xba0
400044bc: f9000bf9     	str	x25, [sp, #0x10]
400044c0: b0000099     	adrp	x25, 0x40015000 <kernel_capture_buffer+0x3478>
400044c4: 52800034     	mov	w20, #0x1               // =1
400044c8: aa1303e0     	mov	x0, x19
400044cc: 2a1f03e1     	mov	w1, wzr
400044d0: 52809802     	mov	w2, #0x4c0              // =1216
400044d4: a9025ff8     	stp	x24, x23, [sp, #0x20]
400044d8: 910003fd     	mov	x29, sp
400044dc: a90357f6     	stp	x22, x21, [sp, #0x30]
400044e0: b90b8b34     	str	w20, [x25, #0xb88]
400044e4: 97fff981     	bl	0x40002ae8 <memset>
400044e8: 528005e8     	mov	w8, #0x2f               // =47
400044ec: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
400044f0: b9002274     	str	w20, [x19, #0x20]
400044f4: 79000268     	strh	w8, [x19]
400044f8: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400044fc: f905c933     	str	x19, [x9, #0xb90]
40004500: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004504: 7101fd1f     	cmp	w8, #0x7f
40004508: f9021a7f     	str	xzr, [x19, #0x430]
4000450c: f900167f     	str	xzr, [x19, #0x28]
40004510: b904ba7f     	str	wzr, [x19, #0x4b8]
40004514: f905cd33     	str	x19, [x9, #0xb98]
40004518: 540028ac     	b.gt	0x40004a2c <vfs_init+0x580>
4000451c: 52809809     	mov	w9, #0x4c0              // =1216
40004520: 2a1f03e1     	mov	w1, wzr
40004524: 52809802     	mov	w2, #0x4c0              // =1216
40004528: 9b294d17     	smaddl	x23, w8, w9, x19
4000452c: 11000508     	add	w8, w8, #0x1
40004530: b90b8b28     	str	w8, [x25, #0xb88]
40004534: aa1703e0     	mov	x0, x23
40004538: 97fff96c     	bl	0x40002ae8 <memset>
4000453c: 528d2c48     	mov	w8, #0x6962             // =26978
40004540: b904baff     	str	wzr, [x23, #0x4b8]
40004544: 72a00dc8     	movk	w8, #0x6e, lsl #16
40004548: b90022f4     	str	w20, [x23, #0x20]
4000454c: b90002e8     	str	w8, [x23]
40004550: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004554: f9021af3     	str	x19, [x23, #0x430]
40004558: 71003d1f     	cmp	w8, #0xf
4000455c: f90016ff     	str	xzr, [x23, #0x28]
40004560: 540000ac     	b.gt	0x40004574 <vfs_init+0xc8>
40004564: 11000509     	add	w9, w8, #0x1
40004568: 8b080e68     	add	x8, x19, x8, lsl #3
4000456c: b904ba69     	str	w9, [x19, #0x4b8]
40004570: f9021d17     	str	x23, [x8, #0x438]
40004574: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004578: 7101fd1f     	cmp	w8, #0x7f
4000457c: 5400258c     	b.gt	0x40004a2c <vfs_init+0x580>
40004580: 52809809     	mov	w9, #0x4c0              // =1216
40004584: 2a1f03e1     	mov	w1, wzr
40004588: 52809802     	mov	w2, #0x4c0              // =1216
4000458c: 9b294d16     	smaddl	x22, w8, w9, x19
40004590: 11000508     	add	w8, w8, #0x1
40004594: b90b8b28     	str	w8, [x25, #0xb88]
40004598: aa1603e0     	mov	x0, x22
4000459c: 97fff953     	bl	0x40002ae8 <memset>
400045a0: 528e8ca8     	mov	w8, #0x7465             // =29797
400045a4: b904badf     	str	wzr, [x22, #0x4b8]
400045a8: 52800029     	mov	w9, #0x1                // =1
400045ac: 72a00c68     	movk	w8, #0x63, lsl #16
400045b0: b90022c9     	str	w9, [x22, #0x20]
400045b4: b90002c8     	str	w8, [x22]
400045b8: b984ba68     	ldrsw	x8, [x19, #0x4b8]
400045bc: f9021ad3     	str	x19, [x22, #0x430]
400045c0: 71003d1f     	cmp	w8, #0xf
400045c4: f90016df     	str	xzr, [x22, #0x28]
400045c8: 540000ac     	b.gt	0x400045dc <vfs_init+0x130>
400045cc: 11000509     	add	w9, w8, #0x1
400045d0: 8b080e68     	add	x8, x19, x8, lsl #3
400045d4: b904ba69     	str	w9, [x19, #0x4b8]
400045d8: f9021d16     	str	x22, [x8, #0x438]
400045dc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400045e0: 7101fd1f     	cmp	w8, #0x7f
400045e4: 5400224c     	b.gt	0x40004a2c <vfs_init+0x580>
400045e8: 52809809     	mov	w9, #0x4c0              // =1216
400045ec: 2a1f03e1     	mov	w1, wzr
400045f0: 52809802     	mov	w2, #0x4c0              // =1216
400045f4: 9b294d14     	smaddl	x20, w8, w9, x19
400045f8: 11000508     	add	w8, w8, #0x1
400045fc: b90b8b28     	str	w8, [x25, #0xb88]
40004600: aa1403e0     	mov	x0, x20
40004604: 97fff939     	bl	0x40002ae8 <memset>
40004608: 528ded08     	mov	w8, #0x6f68             // =28520
4000460c: b904ba9f     	str	wzr, [x20, #0x4b8]
40004610: 52800029     	mov	w9, #0x1                // =1
40004614: 72acada8     	movk	w8, #0x656d, lsl #16
40004618: 3900129f     	strb	wzr, [x20, #0x4]
4000461c: b9000288     	str	w8, [x20]
40004620: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004624: b9002289     	str	w9, [x20, #0x20]
40004628: 71003d1f     	cmp	w8, #0xf
4000462c: f9021a93     	str	x19, [x20, #0x430]
40004630: f900169f     	str	xzr, [x20, #0x28]
40004634: 540000ac     	b.gt	0x40004648 <vfs_init+0x19c>
40004638: 11000509     	add	w9, w8, #0x1
4000463c: 8b080e68     	add	x8, x19, x8, lsl #3
40004640: b904ba69     	str	w9, [x19, #0x4b8]
40004644: f9021d14     	str	x20, [x8, #0x438]
40004648: b98b8b28     	ldrsw	x8, [x25, #0xb88]
4000464c: 7101fd1f     	cmp	w8, #0x7f
40004650: 54001eec     	b.gt	0x40004a2c <vfs_init+0x580>
40004654: 52809809     	mov	w9, #0x4c0              // =1216
40004658: 2a1f03e1     	mov	w1, wzr
4000465c: 52809802     	mov	w2, #0x4c0              // =1216
40004660: 9b294d15     	smaddl	x21, w8, w9, x19
40004664: 11000508     	add	w8, w8, #0x1
40004668: b90b8b28     	str	w8, [x25, #0xb88]
4000466c: aa1503e0     	mov	x0, x21
40004670: 97fff91e     	bl	0x40002ae8 <memset>
40004674: 528dec88     	mov	w8, #0x6f64             // =28516
40004678: b904babf     	str	wzr, [x21, #0x4b8]
4000467c: 52800029     	mov	w9, #0x1                // =1
40004680: 72ae6c68     	movk	w8, #0x7363, lsl #16
40004684: 390012bf     	strb	wzr, [x21, #0x4]
40004688: b90002a8     	str	w8, [x21]
4000468c: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40004690: b90022a9     	str	w9, [x21, #0x20]
40004694: 71003d1f     	cmp	w8, #0xf
40004698: f9021ab3     	str	x19, [x21, #0x430]
4000469c: f90016bf     	str	xzr, [x21, #0x28]
400046a0: 540000ac     	b.gt	0x400046b4 <vfs_init+0x208>
400046a4: 11000509     	add	w9, w8, #0x1
400046a8: 8b080e68     	add	x8, x19, x8, lsl #3
400046ac: b904ba69     	str	w9, [x19, #0x4b8]
400046b0: f9021d15     	str	x21, [x8, #0x438]
400046b4: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400046b8: 7101fd1f     	cmp	w8, #0x7f
400046bc: 54001b8c     	b.gt	0x40004a2c <vfs_init+0x580>
400046c0: 52809809     	mov	w9, #0x4c0              // =1216
400046c4: 2a1f03e1     	mov	w1, wzr
400046c8: 52809802     	mov	w2, #0x4c0              // =1216
400046cc: 9b294d18     	smaddl	x24, w8, w9, x19
400046d0: 11000508     	add	w8, w8, #0x1
400046d4: b90b8b28     	str	w8, [x25, #0xb88]
400046d8: aa1803e0     	mov	x0, x24
400046dc: 97fff903     	bl	0x40002ae8 <memset>
400046e0: 528d2c28     	mov	w8, #0x6961             // =26977
400046e4: b904bb1f     	str	wzr, [x24, #0x4b8]
400046e8: 79000308     	strh	w8, [x24]
400046ec: b984bae8     	ldrsw	x8, [x23, #0x4b8]
400046f0: 39000b1f     	strb	wzr, [x24, #0x2]
400046f4: 71003d1f     	cmp	w8, #0xf
400046f8: b900231f     	str	wzr, [x24, #0x20]
400046fc: f9021b17     	str	x23, [x24, #0x430]
40004700: f900171f     	str	xzr, [x24, #0x28]
40004704: 540000ac     	b.gt	0x40004718 <vfs_init+0x26c>
40004708: 8b080ee9     	add	x9, x23, x8, lsl #3
4000470c: 11000508     	add	w8, w8, #0x1
40004710: b904bae8     	str	w8, [x23, #0x4b8]
40004714: f9021d38     	str	x24, [x9, #0x438]
40004718: d503201f     	nop
4000471c: 30039057     	adr	x23, 0x4000b925 <__rodata_start+0x2925>
40004720: 9100c300     	add	x0, x24, #0x30
40004724: aa1703e1     	mov	x1, x23
40004728: 97fff8c4     	bl	0x40002a38 <kstrcpy>
4000472c: aa1703e0     	mov	x0, x23
40004730: 97fff893     	bl	0x4000297c <kstrlen>
40004734: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004738: f9001700     	str	x0, [x24, #0x28]
4000473c: 7101fd1f     	cmp	w8, #0x7f
40004740: 5400176c     	b.gt	0x40004a2c <vfs_init+0x580>
40004744: 52809809     	mov	w9, #0x4c0              // =1216
40004748: 2a1f03e1     	mov	w1, wzr
4000474c: 52809802     	mov	w2, #0x4c0              // =1216
40004750: 9b294d17     	smaddl	x23, w8, w9, x19
40004754: 11000508     	add	w8, w8, #0x1
40004758: b90b8b28     	str	w8, [x25, #0xb88]
4000475c: aa1703e0     	mov	x0, x23
40004760: 97fff8e2     	bl	0x40002ae8 <memset>
40004764: d28e6de8     	mov	x8, #0x736f             // =29551
40004768: b904baff     	str	wzr, [x23, #0x4b8]
4000476c: 528cae69     	mov	w9, #0x6573             // =25971
40004770: f2ae45a8     	movk	x8, #0x722d, lsl #16
40004774: 790012e9     	strh	w9, [x23, #0x8]
40004778: f2cd8ca8     	movk	x8, #0x6c65, lsl #32
4000477c: 39002aff     	strb	wzr, [x23, #0xa]
40004780: f2ec2ca8     	movk	x8, #0x6165, lsl #48
40004784: b90022ff     	str	wzr, [x23, #0x20]
40004788: f90002e8     	str	x8, [x23]
4000478c: b984bac8     	ldrsw	x8, [x22, #0x4b8]
40004790: f9021af6     	str	x22, [x23, #0x430]
40004794: 71003d1f     	cmp	w8, #0xf
40004798: f90016ff     	str	xzr, [x23, #0x28]
4000479c: 540000ac     	b.gt	0x400047b0 <vfs_init+0x304>
400047a0: 8b080ec9     	add	x9, x22, x8, lsl #3
400047a4: 11000508     	add	w8, w8, #0x1
400047a8: b904bac8     	str	w8, [x22, #0x4b8]
400047ac: f9021d37     	str	x23, [x9, #0x438]
400047b0: b0000036     	adrp	x22, 0x40009000 <__rodata_start>
400047b4: 913a16d6     	add	x22, x22, #0xe85
400047b8: 9100c2e0     	add	x0, x23, #0x30
400047bc: aa1603e1     	mov	x1, x22
400047c0: 97fff89e     	bl	0x40002a38 <kstrcpy>
400047c4: aa1603e0     	mov	x0, x22
400047c8: 97fff86d     	bl	0x4000297c <kstrlen>
400047cc: b98b8b28     	ldrsw	x8, [x25, #0xb88]
400047d0: f90016e0     	str	x0, [x23, #0x28]
400047d4: 7101fd1f     	cmp	w8, #0x7f
400047d8: 540012ac     	b.gt	0x40004a2c <vfs_init+0x580>
400047dc: 52809809     	mov	w9, #0x4c0              // =1216
400047e0: 2a1f03e1     	mov	w1, wzr
400047e4: 52809802     	mov	w2, #0x4c0              // =1216
400047e8: 9b294d16     	smaddl	x22, w8, w9, x19
400047ec: 11000508     	add	w8, w8, #0x1
400047f0: b90b8b28     	str	w8, [x25, #0xb88]
400047f4: aa1603e0     	mov	x0, x22
400047f8: 97fff8bc     	bl	0x40002ae8 <memset>
400047fc: d28caee8     	mov	x8, #0x6577             // =25975
40004800: b904badf     	str	wzr, [x22, #0x4b8]
40004804: 528f0e89     	mov	w9, #0x7874             // =30836
40004808: f2ac6d88     	movk	x8, #0x636c, lsl #16
4000480c: 72a00e89     	movk	w9, #0x74, lsl #16
40004810: b90022df     	str	wzr, [x22, #0x20]
40004814: f2cdade8     	movk	x8, #0x6d6f, lsl #32
40004818: b9000ac9     	str	w9, [x22, #0x8]
4000481c: f2e5cca8     	movk	x8, #0x2e65, lsl #48
40004820: f9021ad5     	str	x21, [x22, #0x430]
40004824: f90002c8     	str	x8, [x22]
40004828: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000482c: f90016df     	str	xzr, [x22, #0x28]
40004830: 71003d1f     	cmp	w8, #0xf
40004834: 540000ac     	b.gt	0x40004848 <vfs_init+0x39c>
40004838: 8b080ea9     	add	x9, x21, x8, lsl #3
4000483c: 11000508     	add	w8, w8, #0x1
40004840: b904baa8     	str	w8, [x21, #0x4b8]
40004844: f9021d36     	str	x22, [x9, #0x438]
40004848: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
4000484c: 9100aaf7     	add	x23, x23, #0x2a
40004850: 9100c2c0     	add	x0, x22, #0x30
40004854: aa1703e1     	mov	x1, x23
40004858: 97fff878     	bl	0x40002a38 <kstrcpy>
4000485c: aa1703e0     	mov	x0, x23
40004860: 97fff847     	bl	0x4000297c <kstrlen>
40004864: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004868: f90016c0     	str	x0, [x22, #0x28]
4000486c: 7101fd1f     	cmp	w8, #0x7f
40004870: 54000dec     	b.gt	0x40004a2c <vfs_init+0x580>
40004874: 52809809     	mov	w9, #0x4c0              // =1216
40004878: 2a1f03e1     	mov	w1, wzr
4000487c: 52809802     	mov	w2, #0x4c0              // =1216
40004880: 9b294d16     	smaddl	x22, w8, w9, x19
40004884: 11000508     	add	w8, w8, #0x1
40004888: b90b8b28     	str	w8, [x25, #0xb88]
4000488c: aa1603e0     	mov	x0, x22
40004890: 97fff896     	bl	0x40002ae8 <memset>
40004894: d28c2d08     	mov	x8, #0x6168             // =24936
40004898: b904badf     	str	wzr, [x22, #0x4b8]
4000489c: 528e85c9     	mov	w9, #0x742e             // =29742
400048a0: f2ac8e48     	movk	x8, #0x6472, lsl #16
400048a4: 72ae8f09     	movk	w9, #0x7478, lsl #16
400048a8: 390032df     	strb	wzr, [x22, #0xc]
400048ac: f2cc2ee8     	movk	x8, #0x6177, lsl #32
400048b0: b9000ac9     	str	w9, [x22, #0x8]
400048b4: f2ecae48     	movk	x8, #0x6572, lsl #48
400048b8: b90022df     	str	wzr, [x22, #0x20]
400048bc: f90002c8     	str	x8, [x22]
400048c0: b984baa8     	ldrsw	x8, [x21, #0x4b8]
400048c4: f9021ad5     	str	x21, [x22, #0x430]
400048c8: 71003d1f     	cmp	w8, #0xf
400048cc: f90016df     	str	xzr, [x22, #0x28]
400048d0: 540000ac     	b.gt	0x400048e4 <vfs_init+0x438>
400048d4: 8b080ea9     	add	x9, x21, x8, lsl #3
400048d8: 11000508     	add	w8, w8, #0x1
400048dc: b904baa8     	str	w8, [x21, #0x4b8]
400048e0: f9021d36     	str	x22, [x9, #0x438]
400048e4: d0000037     	adrp	x23, 0x4000a000 <__rodata_start+0x1000>
400048e8: 91115af7     	add	x23, x23, #0x456
400048ec: 9100c2c0     	add	x0, x22, #0x30
400048f0: aa1703e1     	mov	x1, x23
400048f4: 97fff851     	bl	0x40002a38 <kstrcpy>
400048f8: aa1703e0     	mov	x0, x23
400048fc: 97fff820     	bl	0x4000297c <kstrlen>
40004900: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004904: f90016c0     	str	x0, [x22, #0x28]
40004908: 7101fd1f     	cmp	w8, #0x7f
4000490c: 5400090c     	b.gt	0x40004a2c <vfs_init+0x580>
40004910: 52809809     	mov	w9, #0x4c0              // =1216
40004914: 2a1f03e1     	mov	w1, wzr
40004918: 52809802     	mov	w2, #0x4c0              // =1216
4000491c: 9b294d16     	smaddl	x22, w8, w9, x19
40004920: 11000508     	add	w8, w8, #0x1
40004924: b90b8b28     	str	w8, [x25, #0xb88]
40004928: aa1603e0     	mov	x0, x22
4000492c: 97fff86f     	bl	0x40002ae8 <memset>
40004930: 528d2c28     	mov	w8, #0x6961             // =26977
40004934: b904badf     	str	wzr, [x22, #0x4b8]
40004938: 528e8f09     	mov	w9, #0x7478             // =29816
4000493c: 72ae85c8     	movk	w8, #0x742e, lsl #16
40004940: 79000ac9     	strh	w9, [x22, #0x4]
40004944: b90002c8     	str	w8, [x22]
40004948: b984baa8     	ldrsw	x8, [x21, #0x4b8]
4000494c: 39001adf     	strb	wzr, [x22, #0x6]
40004950: 71003d1f     	cmp	w8, #0xf
40004954: b90022df     	str	wzr, [x22, #0x20]
40004958: f9021ad5     	str	x21, [x22, #0x430]
4000495c: f90016df     	str	xzr, [x22, #0x28]
40004960: 540000ac     	b.gt	0x40004974 <vfs_init+0x4c8>
40004964: 8b080ea9     	add	x9, x21, x8, lsl #3
40004968: 11000508     	add	w8, w8, #0x1
4000496c: b904baa8     	str	w8, [x21, #0x4b8]
40004970: f9021d36     	str	x22, [x9, #0x438]
40004974: f0000035     	adrp	x21, 0x4000b000 <__rodata_start+0x2000>
40004978: 9118b6b5     	add	x21, x21, #0x62d
4000497c: 9100c2c0     	add	x0, x22, #0x30
40004980: aa1503e1     	mov	x1, x21
40004984: 97fff82d     	bl	0x40002a38 <kstrcpy>
40004988: aa1503e0     	mov	x0, x21
4000498c: 97fff7fc     	bl	0x4000297c <kstrlen>
40004990: b98b8b28     	ldrsw	x8, [x25, #0xb88]
40004994: f90016c0     	str	x0, [x22, #0x28]
40004998: 7101fd1f     	cmp	w8, #0x7f
4000499c: 5400048c     	b.gt	0x40004a2c <vfs_init+0x580>
400049a0: 52809809     	mov	w9, #0x4c0              // =1216
400049a4: 2a1f03e1     	mov	w1, wzr
400049a8: 52809802     	mov	w2, #0x4c0              // =1216
400049ac: 9b294d13     	smaddl	x19, w8, w9, x19
400049b0: 11000508     	add	w8, w8, #0x1
400049b4: b90b8b28     	str	w8, [x25, #0xb88]
400049b8: aa1303e0     	mov	x0, x19
400049bc: 97fff84b     	bl	0x40002ae8 <memset>
400049c0: d28cae48     	mov	x8, #0x6572             // =25970
400049c4: b904ba7f     	str	wzr, [x19, #0x4b8]
400049c8: 528e8f09     	mov	w9, #0x7478             // =29816
400049cc: f2ac8c28     	movk	x8, #0x6461, lsl #16
400049d0: 79001269     	strh	w9, [x19, #0x8]
400049d4: f2ccada8     	movk	x8, #0x656d, lsl #32
400049d8: 39002a7f     	strb	wzr, [x19, #0xa]
400049dc: f2ee85c8     	movk	x8, #0x742e, lsl #48
400049e0: b900227f     	str	wzr, [x19, #0x20]
400049e4: f9000268     	str	x8, [x19]
400049e8: b984ba88     	ldrsw	x8, [x20, #0x4b8]
400049ec: f9021a74     	str	x20, [x19, #0x430]
400049f0: 71003d1f     	cmp	w8, #0xf
400049f4: f900167f     	str	xzr, [x19, #0x28]
400049f8: 540000ac     	b.gt	0x40004a0c <vfs_init+0x560>
400049fc: 8b080e89     	add	x9, x20, x8, lsl #3
40004a00: 11000508     	add	w8, w8, #0x1
40004a04: b904ba88     	str	w8, [x20, #0x4b8]
40004a08: f9021d33     	str	x19, [x9, #0x438]
40004a0c: b0000034     	adrp	x20, 0x40009000 <__rodata_start>
40004a10: 910e5e94     	add	x20, x20, #0x397
40004a14: 9100c260     	add	x0, x19, #0x30
40004a18: aa1403e1     	mov	x1, x20
40004a1c: 97fff807     	bl	0x40002a38 <kstrcpy>
40004a20: aa1403e0     	mov	x0, x20
40004a24: 97fff7d6     	bl	0x4000297c <kstrlen>
40004a28: f9001660     	str	x0, [x19, #0x28]
40004a2c: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40004a30: f9400bf9     	ldr	x25, [sp, #0x10]
40004a34: a94357f6     	ldp	x22, x21, [sp, #0x30]
40004a38: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40004a3c: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40004a40: d65f03c0     	ret

0000000040004a44 <vfs_get_root>:
40004a44: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a48: f945c900     	ldr	x0, [x8, #0xb90]
40004a4c: d65f03c0     	ret

0000000040004a50 <vfs_get_cwd>:
40004a50: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a54: f945cd00     	ldr	x0, [x8, #0xb98]
40004a58: d65f03c0     	ret

0000000040004a5c <vfs_getcwd>:
40004a5c: d10343ff     	sub	sp, sp, #0xd0
40004a60: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004a64: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
40004a68: aa0003f3     	mov	x19, x0
40004a6c: f945cd08     	ldr	x8, [x8, #0xb98]
40004a70: a9087bfd     	stp	x29, x30, [sp, #0x80]
40004a74: 910203fd     	add	x29, sp, #0x80
40004a78: a90967fa     	stp	x26, x25, [sp, #0x90]
40004a7c: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
40004a80: a90b57f6     	stp	x22, x21, [sp, #0xb0]
40004a84: b4000228     	cbz	x8, 0x40004ac8 <vfs_getcwd+0x6c>
40004a88: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004a8c: f945c929     	ldr	x9, [x9, #0xb90]
40004a90: eb09011f     	cmp	x8, x9
40004a94: 540001a0     	b.eq	0x40004ac8 <vfs_getcwd+0x6c>
40004a98: aa1f03ea     	mov	x10, xzr
40004a9c: 910003eb     	mov	x11, sp
40004aa0: eb09011f     	cmp	x8, x9
40004aa4: 540001e0     	b.eq	0x40004ae0 <vfs_getcwd+0x84>
40004aa8: f1003d5f     	cmp	x10, #0xf
40004aac: 540001a8     	b.hi	0x40004ae0 <vfs_getcwd+0x84>
40004ab0: f82a7968     	str	x8, [x11, x10, lsl #3]
40004ab4: f9421908     	ldr	x8, [x8, #0x430]
40004ab8: 9100054c     	add	x12, x10, #0x1
40004abc: aa0c03ea     	mov	x10, x12
40004ac0: b5ffff08     	cbnz	x8, 0x40004aa0 <vfs_getcwd+0x44>
40004ac4: 14000008     	b	0x40004ae4 <vfs_getcwd+0x88>
40004ac8: f100083f     	cmp	x1, #0x2
40004acc: 54000583     	b.lo	0x40004b7c <vfs_getcwd+0x120>
40004ad0: 528005e8     	mov	w8, #0x2f               // =47
40004ad4: 3900067f     	strb	wzr, [x19, #0x1]
40004ad8: 39000268     	strb	w8, [x19]
40004adc: 14000028     	b	0x40004b7c <vfs_getcwd+0x120>
40004ae0: aa0a03ec     	mov	x12, x10
40004ae4: 7100059f     	cmp	w12, #0x1
40004ae8: 3900027f     	strb	wzr, [x19]
40004aec: 5400048b     	b.lt	0x40004b7c <vfs_getcwd+0x120>
40004af0: aa1f03f6     	mov	x22, xzr
40004af4: d1000435     	sub	x21, x1, #0x1
40004af8: 92407999     	and	x25, x12, #0x7fffffff
40004afc: 528005f7     	mov	w23, #0x2f              // =47
40004b00: 910003f8     	mov	x24, sp
40004b04: 14000005     	b	0x40004b18 <vfs_getcwd+0xbc>
40004b08: 8b0a02d6     	add	x22, x22, x10
40004b0c: f100075f     	cmp	x26, #0x1
40004b10: 38366a7f     	strb	wzr, [x19, x22]
40004b14: 54000349     	b.ls	0x40004b7c <vfs_getcwd+0x120>
40004b18: eb1502df     	cmp	x22, x21
40004b1c: aa1903fa     	mov	x26, x25
40004b20: 54000082     	b.hs	0x40004b30 <vfs_getcwd+0xd4>
40004b24: 38366a77     	strb	w23, [x19, x22]
40004b28: 910006d6     	add	x22, x22, #0x1
40004b2c: 38366a7f     	strb	wzr, [x19, x22]
40004b30: d1000759     	sub	x25, x26, #0x1
40004b34: f8797b14     	ldr	x20, [x24, x25, lsl #3]
40004b38: aa1403e0     	mov	x0, x20
40004b3c: 97fff790     	bl	0x4000297c <kstrlen>
40004b40: b4fffe60     	cbz	x0, 0x40004b0c <vfs_getcwd+0xb0>
40004b44: eb1502df     	cmp	x22, x21
40004b48: 54fffe22     	b.hs	0x40004b0c <vfs_getcwd+0xb0>
40004b4c: aa1f03e9     	mov	x9, xzr
40004b50: 8b160268     	add	x8, x19, x22
40004b54: 9100052a     	add	x10, x9, #0x1
40004b58: 38696a8b     	ldrb	w11, [x20, x9]
40004b5c: eb00015f     	cmp	x10, x0
40004b60: 3829690b     	strb	w11, [x8, x9]
40004b64: 54fffd22     	b.hs	0x40004b08 <vfs_getcwd+0xac>
40004b68: 8b160149     	add	x9, x10, x22
40004b6c: eb15013f     	cmp	x9, x21
40004b70: aa0a03e9     	mov	x9, x10
40004b74: 54ffff03     	b.lo	0x40004b54 <vfs_getcwd+0xf8>
40004b78: 17ffffe4     	b	0x40004b08 <vfs_getcwd+0xac>
40004b7c: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
40004b80: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
40004b84: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
40004b88: a94967fa     	ldp	x26, x25, [sp, #0x90]
40004b8c: a9487bfd     	ldp	x29, x30, [sp, #0x80]
40004b90: 910343ff     	add	sp, sp, #0xd0
40004b94: d65f03c0     	ret

0000000040004b98 <vfs_find>:
40004b98: d10203ff     	sub	sp, sp, #0x80
40004b9c: a9027bfd     	stp	x29, x30, [sp, #0x20]
40004ba0: 910083fd     	add	x29, sp, #0x20
40004ba4: a9036ffc     	stp	x28, x27, [sp, #0x30]
40004ba8: a90467fa     	stp	x26, x25, [sp, #0x40]
40004bac: a9055ff8     	stp	x24, x23, [sp, #0x50]
40004bb0: a90657f6     	stp	x22, x21, [sp, #0x60]
40004bb4: a9074ff4     	stp	x20, x19, [sp, #0x70]
40004bb8: b4000a60     	cbz	x0, 0x40004d04 <vfs_find+0x16c>
40004bbc: 39400008     	ldrb	w8, [x0]
40004bc0: aa0003f4     	mov	x20, x0
40004bc4: 34000a08     	cbz	w8, 0x40004d04 <vfs_find+0x16c>
40004bc8: 7100bd1f     	cmp	w8, #0x2f
40004bcc: 54000121     	b.ne	0x40004bf0 <vfs_find+0x58>
40004bd0: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004bd4: 52800037     	mov	w23, #0x1               // =1
40004bd8: f945c913     	ldr	x19, [x8, #0xb90]
40004bdc: 38776a88     	ldrb	w8, [x20, x23]
40004be0: 7100bd1f     	cmp	w8, #0x2f
40004be4: 540000e1     	b.ne	0x40004c00 <vfs_find+0x68>
40004be8: 910006f7     	add	x23, x23, #0x1
40004bec: 17fffffc     	b	0x40004bdc <vfs_find+0x44>
40004bf0: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004bf4: aa1f03f7     	mov	x23, xzr
40004bf8: f945cd33     	ldr	x19, [x9, #0xb98]
40004bfc: 14000002     	b	0x40004c04 <vfs_find+0x6c>
40004c00: 34000848     	cbz	w8, 0x40004d08 <vfs_find+0x170>
40004c04: 91000698     	add	x24, x20, #0x1
40004c08: b0000035     	adrp	x21, 0x40009000 <__rodata_start>
40004c0c: 91278eb5     	add	x21, x21, #0x9e3
40004c10: 910003f9     	mov	x25, sp
40004c14: d0000036     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
40004c18: 91072ed6     	add	x22, x22, #0x1cb
40004c1c: 14000006     	b	0x40004c34 <vfs_find+0x9c>
40004c20: f9421a68     	ldr	x8, [x19, #0x430]
40004c24: f100011f     	cmp	x8, #0x0
40004c28: 9a880273     	csel	x19, x19, x8, eq
40004c2c: 385ff348     	ldurb	w8, [x26, #-0x1]
40004c30: 340006c8     	cbz	w8, 0x40004d08 <vfs_find+0x170>
40004c34: 7100bd1f     	cmp	w8, #0x2f
40004c38: 54000061     	b.ne	0x40004c44 <vfs_find+0xac>
40004c3c: aa1f03e9     	mov	x9, xzr
40004c40: 14000010     	b	0x40004c80 <vfs_find+0xe8>
40004c44: aa1f03e9     	mov	x9, xzr
40004c48: 8b17030a     	add	x10, x24, x23
40004c4c: 34000188     	cbz	w8, 0x40004c7c <vfs_find+0xe4>
40004c50: f100793f     	cmp	x9, #0x1e
40004c54: 54000148     	b.hi	0x40004c7c <vfs_find+0xe4>
40004c58: 38296b28     	strb	w8, [x25, x9]
40004c5c: 38696948     	ldrb	w8, [x10, x9]
40004c60: 9100052b     	add	x11, x9, #0x1
40004c64: aa0b03e9     	mov	x9, x11
40004c68: 7100bd1f     	cmp	w8, #0x2f
40004c6c: 54ffff01     	b.ne	0x40004c4c <vfs_find+0xb4>
40004c70: 8b0b02f7     	add	x23, x23, x11
40004c74: aa0b03e9     	mov	x9, x11
40004c78: 14000002     	b	0x40004c80 <vfs_find+0xe8>
40004c7c: 8b0902f7     	add	x23, x23, x9
40004c80: 8b17029a     	add	x26, x20, x23
40004c84: d10006f7     	sub	x23, x23, #0x1
40004c88: 38296b3f     	strb	wzr, [x25, x9]
40004c8c: 38401748     	ldrb	w8, [x26], #0x1
40004c90: 910006f7     	add	x23, x23, #0x1
40004c94: 7100bd1f     	cmp	w8, #0x2f
40004c98: 54ffffa0     	b.eq	0x40004c8c <vfs_find+0xf4>
40004c9c: 910003e0     	mov	x0, sp
40004ca0: aa1503e1     	mov	x1, x21
40004ca4: 97fff746     	bl	0x400029bc <kstrcmp>
40004ca8: 34fffc20     	cbz	w0, 0x40004c2c <vfs_find+0x94>
40004cac: 910003e0     	mov	x0, sp
40004cb0: aa1603e1     	mov	x1, x22
40004cb4: 97fff742     	bl	0x400029bc <kstrcmp>
40004cb8: 34fffb40     	cbz	w0, 0x40004c20 <vfs_find+0x88>
40004cbc: b944ba68     	ldr	w8, [x19, #0x4b8]
40004cc0: 7100051f     	cmp	w8, #0x1
40004cc4: 5400020b     	b.lt	0x40004d04 <vfs_find+0x16c>
40004cc8: aa1f03fb     	mov	x27, xzr
40004ccc: 9110e27c     	add	x28, x19, #0x438
40004cd0: 14000005     	b	0x40004ce4 <vfs_find+0x14c>
40004cd4: b944ba68     	ldr	w8, [x19, #0x4b8]
40004cd8: 9100077b     	add	x27, x27, #0x1
40004cdc: eb28c37f     	cmp	x27, w8, sxtw
40004ce0: 5400012a     	b.ge	0x40004d04 <vfs_find+0x16c>
40004ce4: f87b7b80     	ldr	x0, [x28, x27, lsl #3]
40004ce8: b4ffff80     	cbz	x0, 0x40004cd8 <vfs_find+0x140>
40004cec: 910003e1     	mov	x1, sp
40004cf0: 97fff733     	bl	0x400029bc <kstrcmp>
40004cf4: 35ffff00     	cbnz	w0, 0x40004cd4 <vfs_find+0x13c>
40004cf8: f87b7b93     	ldr	x19, [x28, x27, lsl #3]
40004cfc: b5fff993     	cbnz	x19, 0x40004c2c <vfs_find+0x94>
40004d00: 14000002     	b	0x40004d08 <vfs_find+0x170>
40004d04: aa1f03f3     	mov	x19, xzr
40004d08: aa1303e0     	mov	x0, x19
40004d0c: a9474ff4     	ldp	x20, x19, [sp, #0x70]
40004d10: a94657f6     	ldp	x22, x21, [sp, #0x60]
40004d14: a9455ff8     	ldp	x24, x23, [sp, #0x50]
40004d18: a94467fa     	ldp	x26, x25, [sp, #0x40]
40004d1c: a9436ffc     	ldp	x28, x27, [sp, #0x30]
40004d20: a9427bfd     	ldp	x29, x30, [sp, #0x20]
40004d24: 910203ff     	add	sp, sp, #0x80
40004d28: d65f03c0     	ret

0000000040004d2c <vfs_chdir>:
40004d2c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40004d30: f9000bf3     	str	x19, [sp, #0x10]
40004d34: 910003fd     	mov	x29, sp
40004d38: b4000200     	cbz	x0, 0x40004d78 <vfs_chdir+0x4c>
40004d3c: 39400008     	ldrb	w8, [x0]
40004d40: 340001c8     	cbz	w8, 0x40004d78 <vfs_chdir+0x4c>
40004d44: f0000021     	adrp	x1, 0x4000b000 <__rodata_start+0x2000>
40004d48: 91157021     	add	x1, x1, #0x55c
40004d4c: aa0003f3     	mov	x19, x0
40004d50: 97fff71b     	bl	0x400029bc <kstrcmp>
40004d54: 34000120     	cbz	w0, 0x40004d78 <vfs_chdir+0x4c>
40004d58: aa1303e0     	mov	x0, x19
40004d5c: 97ffff8f     	bl	0x40004b98 <vfs_find>
40004d60: b40002c0     	cbz	x0, 0x40004db8 <vfs_chdir+0x8c>
40004d64: b9402008     	ldr	w8, [x0, #0x20]
40004d68: 7100051f     	cmp	w8, #0x1
40004d6c: 54000180     	b.eq	0x40004d9c <vfs_chdir+0x70>
40004d70: 12800028     	mov	w8, #-0x2               // =-2
40004d74: 1400000d     	b	0x40004da8 <vfs_chdir+0x7c>
40004d78: d0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40004d7c: 91027c00     	add	x0, x0, #0x9f
40004d80: 97ffff86     	bl	0x40004b98 <vfs_find>
40004d84: b4000080     	cbz	x0, 0x40004d94 <vfs_chdir+0x68>
40004d88: b9402008     	ldr	w8, [x0, #0x20]
40004d8c: 7100051f     	cmp	w8, #0x1
40004d90: 54000060     	b.eq	0x40004d9c <vfs_chdir+0x70>
40004d94: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004d98: f945c900     	ldr	x0, [x8, #0xb90]
40004d9c: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004da0: 2a1f03e8     	mov	w8, wzr
40004da4: f905cd20     	str	x0, [x9, #0xb98]
40004da8: f9400bf3     	ldr	x19, [sp, #0x10]
40004dac: 2a0803e0     	mov	w0, w8
40004db0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40004db4: d65f03c0     	ret
40004db8: 12800008     	mov	w8, #-0x1               // =-1
40004dbc: 17fffffb     	b	0x40004da8 <vfs_chdir+0x7c>

0000000040004dc0 <vfs_mkdir>:
40004dc0: b40001e0     	cbz	x0, 0x40004dfc <vfs_mkdir+0x3c>
40004dc4: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
40004dc8: 39400008     	ldrb	w8, [x0]
40004dcc: a9024ff4     	stp	x20, x19, [sp, #0x20]
40004dd0: aa0003f3     	mov	x19, x0
40004dd4: a90157f6     	stp	x22, x21, [sp, #0x10]
40004dd8: 910003fd     	mov	x29, sp
40004ddc: 34000148     	cbz	w8, 0x40004e04 <vfs_mkdir+0x44>
40004de0: b0000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
40004de4: f945ce95     	ldr	x21, [x20, #0xb98]
40004de8: b944baa8     	ldr	w8, [x21, #0x4b8]
40004dec: 71003d1f     	cmp	w8, #0xf
40004df0: 540000ed     	b.le	0x40004e0c <vfs_mkdir+0x4c>
40004df4: 12800020     	mov	w0, #-0x2               // =-2
40004df8: 14000043     	b	0x40004f04 <vfs_mkdir+0x144>
40004dfc: 12800000     	mov	w0, #-0x1               // =-1
40004e00: d65f03c0     	ret
40004e04: 12800000     	mov	w0, #-0x1               // =-1
40004e08: 1400003f     	b	0x40004f04 <vfs_mkdir+0x144>
40004e0c: 7100051f     	cmp	w8, #0x1
40004e10: 540001eb     	b.lt	0x40004e4c <vfs_mkdir+0x8c>
40004e14: aa1f03f6     	mov	x22, xzr
40004e18: 14000005     	b	0x40004e2c <vfs_mkdir+0x6c>
40004e1c: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004e20: 910006d6     	add	x22, x22, #0x1
40004e24: eb0802df     	cmp	x22, x8
40004e28: 5400012a     	b.ge	0x40004e4c <vfs_mkdir+0x8c>
40004e2c: 8b160ea8     	add	x8, x21, x22, lsl #3
40004e30: f9421d00     	ldr	x0, [x8, #0x438]
40004e34: b4ffff40     	cbz	x0, 0x40004e1c <vfs_mkdir+0x5c>
40004e38: aa1303e1     	mov	x1, x19
40004e3c: 97fff6e0     	bl	0x400029bc <kstrcmp>
40004e40: 340003e0     	cbz	w0, 0x40004ebc <vfs_mkdir+0xfc>
40004e44: f945ce95     	ldr	x21, [x20, #0xb98]
40004e48: 17fffff5     	b	0x40004e1c <vfs_mkdir+0x5c>
40004e4c: b0000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40004e50: b98b8909     	ldrsw	x9, [x8, #0xb88]
40004e54: 7101fd3f     	cmp	w9, #0x7f
40004e58: 5400006d     	b.le	0x40004e64 <vfs_mkdir+0xa4>
40004e5c: 12800060     	mov	w0, #-0x4               // =-4
40004e60: 14000029     	b	0x40004f04 <vfs_mkdir+0x144>
40004e64: 5280980a     	mov	w10, #0x4c0             // =1216
40004e68: b000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40004e6c: 912e816b     	add	x11, x11, #0xba0
40004e70: 9b2a2d34     	smaddl	x20, w9, w10, x11
40004e74: 11000529     	add	w9, w9, #0x1
40004e78: 2a1f03e1     	mov	w1, wzr
40004e7c: 52809802     	mov	w2, #0x4c0              // =1216
40004e80: b90b8909     	str	w9, [x8, #0xb88]
40004e84: aa1403e0     	mov	x0, x20
40004e88: 97fff718     	bl	0x40002ae8 <memset>
40004e8c: 39400268     	ldrb	w8, [x19]
40004e90: 340001a8     	cbz	w8, 0x40004ec4 <vfs_mkdir+0x104>
40004e94: aa1f03ea     	mov	x10, xzr
40004e98: 91000669     	add	x9, x19, #0x1
40004e9c: 382a6a88     	strb	w8, [x20, x10]
40004ea0: 9100054b     	add	x11, x10, #0x1
40004ea4: 386a6928     	ldrb	w8, [x9, x10]
40004ea8: 34000108     	cbz	w8, 0x40004ec8 <vfs_mkdir+0x108>
40004eac: f100795f     	cmp	x10, #0x1e
40004eb0: aa0b03ea     	mov	x10, x11
40004eb4: 54ffff43     	b.lo	0x40004e9c <vfs_mkdir+0xdc>
40004eb8: 14000004     	b	0x40004ec8 <vfs_mkdir+0x108>
40004ebc: 12800040     	mov	w0, #-0x3               // =-3
40004ec0: 14000011     	b	0x40004f04 <vfs_mkdir+0x144>
40004ec4: aa1f03eb     	mov	x11, xzr
40004ec8: 382b6a9f     	strb	wzr, [x20, x11]
40004ecc: 2a1f03e0     	mov	w0, wzr
40004ed0: 52800029     	mov	w9, #0x1                // =1
40004ed4: b904ba9f     	str	wzr, [x20, #0x4b8]
40004ed8: b984baa8     	ldrsw	x8, [x21, #0x4b8]
40004edc: b9002289     	str	w9, [x20, #0x20]
40004ee0: f9021a95     	str	x21, [x20, #0x430]
40004ee4: 71003d1f     	cmp	w8, #0xf
40004ee8: f900169f     	str	xzr, [x20, #0x28]
40004eec: 540000cc     	b.gt	0x40004f04 <vfs_mkdir+0x144>
40004ef0: 8b080ea9     	add	x9, x21, x8, lsl #3
40004ef4: 2a1f03e0     	mov	w0, wzr
40004ef8: 11000508     	add	w8, w8, #0x1
40004efc: b904baa8     	str	w8, [x21, #0x4b8]
40004f00: f9021d34     	str	x20, [x9, #0x438]
40004f04: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40004f08: a94157f6     	ldp	x22, x21, [sp, #0x10]
40004f0c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40004f10: d65f03c0     	ret

0000000040004f14 <vfs_sync>:
40004f14: d65f03c0     	ret

0000000040004f18 <vfs_touch>:
40004f18: b4000500     	cbz	x0, 0x40004fb8 <vfs_touch+0xa0>
40004f1c: 39400008     	ldrb	w8, [x0]
40004f20: 340004c8     	cbz	w8, 0x40004fb8 <vfs_touch+0xa0>
40004f24: d10583ff     	sub	sp, sp, #0x160
40004f28: b0000089     	adrp	x9, 0x40015000 <kernel_capture_buffer+0x3478>
40004f2c: a9154ff4     	stp	x20, x19, [sp, #0x150]
40004f30: aa1f03f4     	mov	x20, xzr
40004f34: f945cd33     	ldr	x19, [x9, #0xb98]
40004f38: aa0003e9     	mov	x9, x0
40004f3c: a9127bfd     	stp	x29, x30, [sp, #0x120]
40004f40: a9135ffc     	stp	x28, x23, [sp, #0x130]
40004f44: 910483fd     	add	x29, sp, #0x120
40004f48: a91457f6     	stp	x22, x21, [sp, #0x140]
40004f4c: 14000003     	b	0x40004f58 <vfs_touch+0x40>
40004f50: aa0903f4     	mov	x20, x9
40004f54: 38401d28     	ldrb	w8, [x9, #0x1]!
40004f58: 7100bd1f     	cmp	w8, #0x2f
40004f5c: 54ffffa0     	b.eq	0x40004f50 <vfs_touch+0x38>
40004f60: 35ffffa8     	cbnz	w8, 0x40004f54 <vfs_touch+0x3c>
40004f64: b4000334     	cbz	x20, 0x40004fc8 <vfs_touch+0xb0>
40004f68: cb000288     	sub	x8, x20, x0
40004f6c: 52801fe9     	mov	w9, #0xff               // =255
40004f70: aa0103f5     	mov	x21, x1
40004f74: f103fd1f     	cmp	x8, #0xff
40004f78: aa0003e1     	mov	x1, x0
40004f7c: 910083e0     	add	x0, sp, #0x20
40004f80: 9a893113     	csel	x19, x8, x9, lo
40004f84: 910083f6     	add	x22, sp, #0x20
40004f88: aa1303e2     	mov	x2, x19
40004f8c: 97fff6b2     	bl	0x40002a54 <kstrncpy>
40004f90: 910083e0     	add	x0, sp, #0x20
40004f94: 38336adf     	strb	wzr, [x22, x19]
40004f98: 97ffff00     	bl	0x40004b98 <vfs_find>
40004f9c: b4000120     	cbz	x0, 0x40004fc0 <vfs_touch+0xa8>
40004fa0: b9402008     	ldr	w8, [x0, #0x20]
40004fa4: aa0003f3     	mov	x19, x0
40004fa8: 7100051f     	cmp	w8, #0x1
40004fac: 540000a1     	b.ne	0x40004fc0 <vfs_touch+0xa8>
40004fb0: 91000688     	add	x8, x20, #0x1
40004fb4: 14000007     	b	0x40004fd0 <vfs_touch+0xb8>
40004fb8: 12800000     	mov	w0, #-0x1               // =-1
40004fbc: d65f03c0     	ret
40004fc0: 12800000     	mov	w0, #-0x1               // =-1
40004fc4: 1400006a     	b	0x4000516c <vfs_touch+0x254>
40004fc8: aa0003e8     	mov	x8, x0
40004fcc: aa0103f5     	mov	x21, x1
40004fd0: 910003e0     	mov	x0, sp
40004fd4: aa0803e1     	mov	x1, x8
40004fd8: 528003e2     	mov	w2, #0x1f               // =31
40004fdc: 97fff69e     	bl	0x40002a54 <kstrncpy>
40004fe0: b944ba68     	ldr	w8, [x19, #0x4b8]
40004fe4: 39007fff     	strb	wzr, [sp, #0x1f]
40004fe8: 7100051f     	cmp	w8, #0x1
40004fec: 5400024b     	b.lt	0x40005034 <vfs_touch+0x11c>
40004ff0: aa1f03f6     	mov	x22, xzr
40004ff4: 9110e277     	add	x23, x19, #0x438
40004ff8: 14000004     	b	0x40005008 <vfs_touch+0xf0>
40004ffc: 910006d6     	add	x22, x22, #0x1
40005000: eb28c2df     	cmp	x22, w8, sxtw
40005004: 5400010a     	b.ge	0x40005024 <vfs_touch+0x10c>
40005008: f8767ae0     	ldr	x0, [x23, x22, lsl #3]
4000500c: b4ffff80     	cbz	x0, 0x40004ffc <vfs_touch+0xe4>
40005010: 910003e1     	mov	x1, sp
40005014: 97fff66a     	bl	0x400029bc <kstrcmp>
40005018: 340004a0     	cbz	w0, 0x400050ac <vfs_touch+0x194>
4000501c: b944ba68     	ldr	w8, [x19, #0x4b8]
40005020: 17fffff7     	b	0x40004ffc <vfs_touch+0xe4>
40005024: 71003d1f     	cmp	w8, #0xf
40005028: 5400006d     	b.le	0x40005034 <vfs_touch+0x11c>
4000502c: 12800020     	mov	w0, #-0x2               // =-2
40005030: 1400004f     	b	0x4000516c <vfs_touch+0x254>
40005034: 90000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
40005038: b98b8909     	ldrsw	x9, [x8, #0xb88]
4000503c: 7101fd3f     	cmp	w9, #0x7f
40005040: 5400006d     	b.le	0x4000504c <vfs_touch+0x134>
40005044: 12800060     	mov	w0, #-0x4               // =-4
40005048: 14000049     	b	0x4000516c <vfs_touch+0x254>
4000504c: 5280980a     	mov	w10, #0x4c0             // =1216
40005050: 9000008b     	adrp	x11, 0x40015000 <kernel_capture_buffer+0x3478>
40005054: 912e816b     	add	x11, x11, #0xba0
40005058: 9b2a2d34     	smaddl	x20, w9, w10, x11
4000505c: 11000529     	add	w9, w9, #0x1
40005060: 2a1f03e1     	mov	w1, wzr
40005064: 52809802     	mov	w2, #0x4c0              // =1216
40005068: b90b8909     	str	w9, [x8, #0xb88]
4000506c: aa1403e0     	mov	x0, x20
40005070: 97fff69e     	bl	0x40002ae8 <memset>
40005074: 394003e8     	ldrb	w8, [sp]
40005078: 340003e8     	cbz	w8, 0x400050f4 <vfs_touch+0x1dc>
4000507c: 910003ea     	mov	x10, sp
40005080: aa1f03e9     	mov	x9, xzr
40005084: aa1503e0     	mov	x0, x21
40005088: b240014a     	orr	x10, x10, #0x1
4000508c: 38296a88     	strb	w8, [x20, x9]
40005090: 38696948     	ldrb	w8, [x10, x9]
40005094: 9100052b     	add	x11, x9, #0x1
40005098: 34000328     	cbz	w8, 0x400050fc <vfs_touch+0x1e4>
4000509c: f100793f     	cmp	x9, #0x1e
400050a0: aa0b03e9     	mov	x9, x11
400050a4: 54ffff43     	b.lo	0x4000508c <vfs_touch+0x174>
400050a8: 14000015     	b	0x400050fc <vfs_touch+0x1e4>
400050ac: b40005f5     	cbz	x21, 0x40005168 <vfs_touch+0x250>
400050b0: aa1503e0     	mov	x0, x21
400050b4: 97fff632     	bl	0x4000297c <kstrlen>
400050b8: 52807fe8     	mov	w8, #0x3ff              // =1023
400050bc: f10ffc1f     	cmp	x0, #0x3ff
400050c0: f8767ae9     	ldr	x9, [x23, x22, lsl #3]
400050c4: 9a883014     	csel	x20, x0, x8, lo
400050c8: aa1503e1     	mov	x1, x21
400050cc: 9100c120     	add	x0, x9, #0x30
400050d0: aa1403e2     	mov	x2, x20
400050d4: 97fff69b     	bl	0x40002b40 <memcpy>
400050d8: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
400050dc: 2a1f03e0     	mov	w0, wzr
400050e0: 8b140108     	add	x8, x8, x20
400050e4: 3900c11f     	strb	wzr, [x8, #0x30]
400050e8: f8767ae8     	ldr	x8, [x23, x22, lsl #3]
400050ec: f9001514     	str	x20, [x8, #0x28]
400050f0: 1400001f     	b	0x4000516c <vfs_touch+0x254>
400050f4: aa1f03eb     	mov	x11, xzr
400050f8: aa1503e0     	mov	x0, x21
400050fc: 382b6a9f     	strb	wzr, [x20, x11]
40005100: b904ba9f     	str	wzr, [x20, #0x4b8]
40005104: b984ba68     	ldrsw	x8, [x19, #0x4b8]
40005108: b900229f     	str	wzr, [x20, #0x20]
4000510c: f9021a93     	str	x19, [x20, #0x430]
40005110: 71003d1f     	cmp	w8, #0xf
40005114: f900169f     	str	xzr, [x20, #0x28]
40005118: 540000ac     	b.gt	0x4000512c <vfs_touch+0x214>
4000511c: 8b080e69     	add	x9, x19, x8, lsl #3
40005120: 11000508     	add	w8, w8, #0x1
40005124: b904ba68     	str	w8, [x19, #0x4b8]
40005128: f9021d34     	str	x20, [x9, #0x438]
4000512c: b4000200     	cbz	x0, 0x4000516c <vfs_touch+0x254>
40005130: aa0003f3     	mov	x19, x0
40005134: 97fff612     	bl	0x4000297c <kstrlen>
40005138: 52807fe8     	mov	w8, #0x3ff              // =1023
4000513c: f10ffc1f     	cmp	x0, #0x3ff
40005140: 9100c296     	add	x22, x20, #0x30
40005144: 9a883015     	csel	x21, x0, x8, lo
40005148: aa1603e0     	mov	x0, x22
4000514c: aa1303e1     	mov	x1, x19
40005150: aa1503e2     	mov	x2, x21
40005154: 97fff67b     	bl	0x40002b40 <memcpy>
40005158: 2a1f03e0     	mov	w0, wzr
4000515c: 38356adf     	strb	wzr, [x22, x21]
40005160: f9001695     	str	x21, [x20, #0x28]
40005164: 14000002     	b	0x4000516c <vfs_touch+0x254>
40005168: 2a1f03e0     	mov	w0, wzr
4000516c: a9554ff4     	ldp	x20, x19, [sp, #0x150]
40005170: a95457f6     	ldp	x22, x21, [sp, #0x140]
40005174: a9535ffc     	ldp	x28, x23, [sp, #0x130]
40005178: a9527bfd     	ldp	x29, x30, [sp, #0x120]
4000517c: 910583ff     	add	sp, sp, #0x160
40005180: d65f03c0     	ret

0000000040005184 <vfs_write_file>:
40005184: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005188: a9014ff4     	stp	x20, x19, [sp, #0x10]
4000518c: aa0003f4     	mov	x20, x0
40005190: aa0103e0     	mov	x0, x1
40005194: 910003fd     	mov	x29, sp
40005198: aa0103f3     	mov	x19, x1
4000519c: 97fff5f8     	bl	0x4000297c <kstrlen>
400051a0: aa0003e2     	mov	x2, x0
400051a4: aa1403e0     	mov	x0, x20
400051a8: aa1303e1     	mov	x1, x19
400051ac: 94000737     	bl	0x40006e88 <fat16_write_file>
400051b0: aa1403e0     	mov	x0, x20
400051b4: aa1303e1     	mov	x1, x19
400051b8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
400051bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400051c0: 17ffff56     	b	0x40004f18 <vfs_touch>

00000000400051c4 <vfs_remove>:
400051c4: b40005c0     	cbz	x0, 0x4000527c <vfs_remove+0xb8>
400051c8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
400051cc: 39400008     	ldrb	w8, [x0]
400051d0: a9024ff4     	stp	x20, x19, [sp, #0x20]
400051d4: aa0003f3     	mov	x19, x0
400051d8: f9000bf5     	str	x21, [sp, #0x10]
400051dc: 910003fd     	mov	x29, sp
400051e0: 34000448     	cbz	w8, 0x40005268 <vfs_remove+0xa4>
400051e4: 90000094     	adrp	x20, 0x40015000 <kernel_capture_buffer+0x3478>
400051e8: f945ce88     	ldr	x8, [x20, #0xb98]
400051ec: b944b909     	ldr	w9, [x8, #0x4b8]
400051f0: 7100053f     	cmp	w9, #0x1
400051f4: 540003ab     	b.lt	0x40005268 <vfs_remove+0xa4>
400051f8: aa1f03f5     	mov	x21, xzr
400051fc: 14000005     	b	0x40005210 <vfs_remove+0x4c>
40005200: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005204: 910006b5     	add	x21, x21, #0x1
40005208: eb0902bf     	cmp	x21, x9
4000520c: 540002ea     	b.ge	0x40005268 <vfs_remove+0xa4>
40005210: 8b150d09     	add	x9, x8, x21, lsl #3
40005214: f9421d20     	ldr	x0, [x9, #0x438]
40005218: b4ffff40     	cbz	x0, 0x40005200 <vfs_remove+0x3c>
4000521c: aa1303e1     	mov	x1, x19
40005220: 97fff5e7     	bl	0x400029bc <kstrcmp>
40005224: f945ce88     	ldr	x8, [x20, #0xb98]
40005228: 35fffec0     	cbnz	w0, 0x40005200 <vfs_remove+0x3c>
4000522c: b984b909     	ldrsw	x9, [x8, #0x4b8]
40005230: d1000529     	sub	x9, x9, #0x1
40005234: 6b15013f     	cmp	w9, w21
40005238: 5400026d     	b.le	0x40005284 <vfs_remove+0xc0>
4000523c: f945ce8a     	ldr	x10, [x20, #0xb98]
40005240: b984b949     	ldrsw	x9, [x10, #0x4b8]
40005244: d1000529     	sub	x9, x9, #0x1
40005248: 8b150d08     	add	x8, x8, x21, lsl #3
4000524c: 910006b5     	add	x21, x21, #0x1
40005250: eb0902bf     	cmp	x21, x9
40005254: f942210b     	ldr	x11, [x8, #0x440]
40005258: f9021d0b     	str	x11, [x8, #0x438]
4000525c: aa0a03e8     	mov	x8, x10
40005260: 54ffff4b     	b.lt	0x40005248 <vfs_remove+0x84>
40005264: 14000009     	b	0x40005288 <vfs_remove+0xc4>
40005268: 12800000     	mov	w0, #-0x1               // =-1
4000526c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40005270: f9400bf5     	ldr	x21, [sp, #0x10]
40005274: a8c37bfd     	ldp	x29, x30, [sp], #0x30
40005278: d65f03c0     	ret
4000527c: 12800000     	mov	w0, #-0x1               // =-1
40005280: d65f03c0     	ret
40005284: aa0803ea     	mov	x10, x8
40005288: 8b090d48     	add	x8, x10, x9, lsl #3
4000528c: 2a1f03e0     	mov	w0, wzr
40005290: f9021d1f     	str	xzr, [x8, #0x438]
40005294: f945ce88     	ldr	x8, [x20, #0xb98]
40005298: b944b909     	ldr	w9, [x8, #0x4b8]
4000529c: 51000529     	sub	w9, w9, #0x1
400052a0: b904b909     	str	w9, [x8, #0x4b8]
400052a4: 17fffff2     	b	0x4000526c <vfs_remove+0xa8>

00000000400052a8 <vfs_list_dir>:
400052a8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400052ac: 90000088     	adrp	x8, 0x40015000 <kernel_capture_buffer+0x3478>
400052b0: f100001f     	cmp	x0, #0x0
400052b4: a90257f6     	stp	x22, x21, [sp, #0x20]
400052b8: f945cd08     	ldr	x8, [x8, #0xb98]
400052bc: f9000bf7     	str	x23, [sp, #0x10]
400052c0: 910003fd     	mov	x29, sp
400052c4: a9034ff4     	stp	x20, x19, [sp, #0x30]
400052c8: 9a800115     	csel	x21, x8, x0, eq
400052cc: b94022a8     	ldr	w8, [x21, #0x20]
400052d0: 7100051f     	cmp	w8, #0x1
400052d4: 54000521     	b.ne	0x40005378 <vfs_list_dir+0xd0>
400052d8: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400052dc: 913b4800     	add	x0, x0, #0xed2
400052e0: 97fff952     	bl	0x40003828 <uart_puts>
400052e4: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
400052e8: 91222800     	add	x0, x0, #0x88a
400052ec: 97fff94f     	bl	0x40003828 <uart_puts>
400052f0: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400052f4: 9101bc00     	add	x0, x0, #0x6f
400052f8: 97fff94c     	bl	0x40003828 <uart_puts>
400052fc: f9421aa8     	ldr	x8, [x21, #0x430]
40005300: b4000088     	cbz	x8, 0x40005310 <vfs_list_dir+0x68>
40005304: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005308: 9112d000     	add	x0, x0, #0x4b4
4000530c: 97fff947     	bl	0x40003828 <uart_puts>
40005310: b944baa1     	ldr	w1, [x21, #0x4b8]
40005314: 7100043f     	cmp	w1, #0x1
40005318: 5400034b     	b.lt	0x40005380 <vfs_list_dir+0xd8>
4000531c: aa1f03f6     	mov	x22, xzr
40005320: b0000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
40005324: 91364e73     	add	x19, x19, #0xd93
40005328: 9110e2b7     	add	x23, x21, #0x438
4000532c: b0000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40005330: 9121d294     	add	x20, x20, #0x874
40005334: 14000008     	b	0x40005354 <vfs_list_dir+0xac>
40005338: b9402841     	ldr	w1, [x2, #0x28]
4000533c: aa1403e0     	mov	x0, x20
40005340: 97fffa4f     	bl	0x40003c7c <uart_printf>
40005344: b984baa1     	ldrsw	x1, [x21, #0x4b8]
40005348: 910006d6     	add	x22, x22, #0x1
4000534c: eb0102df     	cmp	x22, x1
40005350: 5400018a     	b.ge	0x40005380 <vfs_list_dir+0xd8>
40005354: f8767ae2     	ldr	x2, [x23, x22, lsl #3]
40005358: b4ffff62     	cbz	x2, 0x40005344 <vfs_list_dir+0x9c>
4000535c: b9402048     	ldr	w8, [x2, #0x20]
40005360: 7100051f     	cmp	w8, #0x1
40005364: 54fffea1     	b.ne	0x40005338 <vfs_list_dir+0x90>
40005368: aa1303e0     	mov	x0, x19
4000536c: aa0203e1     	mov	x1, x2
40005370: 97fffa43     	bl	0x40003c7c <uart_printf>
40005374: 17fffff4     	b	0x40005344 <vfs_list_dir+0x9c>
40005378: 12800000     	mov	w0, #-0x1               // =-1
4000537c: 14000005     	b	0x40005390 <vfs_list_dir+0xe8>
40005380: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005384: 91279400     	add	x0, x0, #0x9e5
40005388: 97fffa3d     	bl	0x40003c7c <uart_printf>
4000538c: 2a1f03e0     	mov	w0, wzr
40005390: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005394: f9400bf7     	ldr	x23, [sp, #0x10]
40005398: a94257f6     	ldp	x22, x21, [sp, #0x20]
4000539c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400053a0: d65f03c0     	ret

00000000400053a4 <vfs_load_internal>:
400053a4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
400053a8: 910003fd     	mov	x29, sp
400053ac: 9400086a     	bl	0x40007554 <fat16_populate_vfs>
400053b0: 2a1f03e0     	mov	w0, wzr
400053b4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
400053b8: d65f03c0     	ret

00000000400053bc <vfs_load>:
400053bc: 14000866     	b	0x40007554 <fat16_populate_vfs>

00000000400053c0 <pmm_init>:
400053c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400053c4: a9014ff4     	stp	x20, x19, [sp, #0x10]
400053c8: d503201f     	nop
400053cc: 101b3eb4     	adr	x20, 0x4003bba0 <memory_bitmap>
400053d0: aa1403e0     	mov	x0, x20
400053d4: 2a1f03e1     	mov	w1, wzr
400053d8: 52820002     	mov	w2, #0x1000             // =4096
400053dc: 910003fd     	mov	x29, sp
400053e0: 97fff5c2     	bl	0x40002ae8 <memset>
400053e4: b26237e9     	mov	x9, #0xfffc0000000      // =17591112302592
400053e8: d503201f     	nop
400053ec: 102be0a8     	adr	x8, 0x4005d000 <__kernel_end>
400053f0: f2820009     	movk	x9, #0x1000
400053f4: b26237ea     	mov	x10, #0xfffc0000000     // =17591112302592
400053f8: f2402d1f     	tst	x8, #0xfff
400053fc: 8b090109     	add	x9, x8, x9
40005400: 8b0a010a     	add	x10, x8, x10
40005404: 9a890148     	csel	x8, x10, x9, eq
40005408: d34cfd13     	lsr	x19, x8, #12
4000540c: 340001b3     	cbz	w19, 0x40005440 <pmm_init+0x80>
40005410: 2a1f03e8     	mov	w8, wzr
40005414: 52800029     	mov	w9, #0x1                // =1
40005418: 2a0803ea     	mov	w10, w8
4000541c: 1200090b     	and	w11, w8, #0x7
40005420: 11000508     	add	w8, w8, #0x1
40005424: d343fd4a     	lsr	x10, x10, #3
40005428: 1acb212b     	lsl	w11, w9, w11
4000542c: 6b08027f     	cmp	w19, w8
40005430: 386a6a8c     	ldrb	w12, [x20, x10]
40005434: 2a0b018b     	orr	w11, w12, w11
40005438: 382a6a8b     	strb	w11, [x20, x10]
4000543c: 54fffee1     	b.ne	0x40005418 <pmm_init+0x58>
40005440: 52900008     	mov	w8, #0x8000             // =32768
40005444: f0000034     	adrp	x20, 0x4000c000 <next_pid>
40005448: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
4000544c: 4b130108     	sub	w8, w8, w19
40005450: d503201f     	nop
40005454: 3002eb20     	adr	x0, 0x4000b1b9 <__rodata_start+0x21b9>
40005458: b9000688     	str	w8, [x20, #0x4]
4000545c: b90ba133     	str	w19, [x9, #0xba0]
40005460: 97fffa07     	bl	0x40003c7c <uart_printf>
40005464: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005468: 9129fc00     	add	x0, x0, #0xa7f
4000546c: 52801001     	mov	w1, #0x80               // =128
40005470: 97fffa03     	bl	0x40003c7c <uart_printf>
40005474: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005478: 91157800     	add	x0, x0, #0x55e
4000547c: 2a1303e1     	mov	w1, w19
40005480: 97fff9ff     	bl	0x40003c7c <uart_printf>
40005484: b9400688     	ldr	w8, [x20, #0x4]
40005488: a9414ff4     	ldp	x20, x19, [sp, #0x10]
4000548c: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005490: 911c2000     	add	x0, x0, #0x708
40005494: 53084d01     	ubfx	w1, w8, #8, #12
40005498: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000549c: 17fff9f8     	b	0x40003c7c <uart_printf>

00000000400054a0 <pmm_alloc_page>:
400054a0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
400054a4: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400054a8: f9000bf3     	str	x19, [sp, #0x10]
400054ac: 910003fd     	mov	x29, sp
400054b0: b940050a     	ldr	w10, [x8, #0x4]
400054b4: 3400030a     	cbz	w10, 0x40005514 <pmm_alloc_page+0x74>
400054b8: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400054bc: b94ba12b     	ldr	w11, [x9, #0xba0]
400054c0: 530f7d6c     	lsr	w12, w11, #15
400054c4: 3500022c     	cbnz	w12, 0x40005508 <pmm_alloc_page+0x68>
400054c8: 52a8000c     	mov	w12, #0x40000000        // =1073741824
400054cc: d503201f     	nop
400054d0: 101b368d     	adr	x13, 0x4003bba0 <memory_bitmap>
400054d4: 0b0b318c     	add	w12, w12, w11, lsl #12
400054d8: 5280002e     	mov	w14, #0x1               // =1
400054dc: 2a0b03ef     	mov	w15, w11
400054e0: 12000971     	and	w17, w11, #0x7
400054e4: d343fdef     	lsr	x15, x15, #3
400054e8: 1ad121d1     	lsl	w17, w14, w17
400054ec: 386f69b0     	ldrb	w16, [x13, x15]
400054f0: 6a10023f     	tst	w17, w16
400054f4: 540001e0     	b.eq	0x40005530 <pmm_alloc_page+0x90>
400054f8: 1100056b     	add	w11, w11, #0x1
400054fc: 1140058c     	add	w12, w12, #0x1, lsl #12 // =0x1000
40005500: 7140217f     	cmp	w11, #0x8, lsl #12      // =0x8000
40005504: 54fffec1     	b.ne	0x400054dc <pmm_alloc_page+0x3c>
40005508: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000550c: 9115e000     	add	x0, x0, #0x578
40005510: 14000003     	b	0x4000551c <pmm_alloc_page+0x7c>
40005514: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005518: 911c7c00     	add	x0, x0, #0x71f
4000551c: 97fff8c3     	bl	0x40003828 <uart_puts>
40005520: aa1f03e0     	mov	x0, xzr
40005524: f9400bf3     	ldr	x19, [sp, #0x10]
40005528: a8c27bfd     	ldp	x29, x30, [sp], #0x20
4000552c: d65f03c0     	ret
40005530: 2a0c03f3     	mov	w19, w12
40005534: 5100054a     	sub	w10, w10, #0x1
40005538: 1100056b     	add	w11, w11, #0x1
4000553c: aa1303e0     	mov	x0, x19
40005540: 2a1f03e1     	mov	w1, wzr
40005544: 52820002     	mov	w2, #0x1000             // =4096
40005548: 2a11020e     	orr	w14, w16, w17
4000554c: 382f69ae     	strb	w14, [x13, x15]
40005550: b900050a     	str	w10, [x8, #0x4]
40005554: b90ba12b     	str	w11, [x9, #0xba0]
40005558: 97fff564     	bl	0x40002ae8 <memset>
4000555c: aa1303e0     	mov	x0, x19
40005560: 17fffff1     	b	0x40005524 <pmm_alloc_page+0x84>

0000000040005564 <pmm_free_page>:
40005564: d35efc08     	lsr	x8, x0, #30
40005568: b4000128     	cbz	x8, 0x4000558c <pmm_free_page+0x28>
4000556c: d35bfc08     	lsr	x8, x0, #27
40005570: f100251f     	cmp	x8, #0x9
40005574: 540000c2     	b.hs	0x4000558c <pmm_free_page+0x28>
40005578: f2402c1f     	tst	x0, #0xfff
4000557c: 540000e0     	b.eq	0x40005598 <pmm_free_page+0x34>
40005580: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005584: 9122d000     	add	x0, x0, #0x8b4
40005588: 17fff8a8     	b	0x40003828 <uart_puts>
4000558c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005590: 91083c00     	add	x0, x0, #0x20f
40005594: 17fff8a5     	b	0x40003828 <uart_puts>
40005598: b26237e8     	mov	x8, #0xfffc0000000      // =17591112302592
4000559c: d503201f     	nop
400055a0: 101b300a     	adr	x10, 0x4003bba0 <memory_bitmap>
400055a4: 8b080009     	add	x9, x0, x8
400055a8: 5280002d     	mov	w13, #0x1               // =1
400055ac: d34fad28     	ubfx	x8, x9, #15, #29
400055b0: d34c392c     	ubfx	x12, x9, #12, #3
400055b4: 3868694b     	ldrb	w11, [x10, x8]
400055b8: 1acc21ac     	lsl	w12, w13, w12
400055bc: 6a0b019f     	tst	w12, w11
400055c0: 540001c0     	b.eq	0x400055f8 <pmm_free_page+0x94>
400055c4: f000002e     	adrp	x14, 0x4000c000 <next_pid>
400055c8: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
400055cc: d34cfd29     	lsr	x9, x9, #12
400055d0: b94005cf     	ldr	w15, [x14, #0x4]
400055d4: b94ba1b0     	ldr	w16, [x13, #0xba0]
400055d8: 0a2c016b     	bic	w11, w11, w12
400055dc: 3828694b     	strb	w11, [x10, x8]
400055e0: 110005e8     	add	w8, w15, #0x1
400055e4: 6b09021f     	cmp	w16, w9
400055e8: b90005c8     	str	w8, [x14, #0x4]
400055ec: 54000049     	b.ls	0x400055f4 <pmm_free_page+0x90>
400055f0: b90ba1a9     	str	w9, [x13, #0xba0]
400055f4: d65f03c0     	ret
400055f8: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400055fc: 9132e400     	add	x0, x0, #0xcb9
40005600: 17fff88a     	b	0x40003828 <uart_puts>

0000000040005604 <pmm_get_free_memory>:
40005604: f0000028     	adrp	x8, 0x4000c000 <next_pid>
40005608: b9400508     	ldr	w8, [x8, #0x4]
4000560c: 53144d00     	lsl	w0, w8, #12
40005610: d65f03c0     	ret

0000000040005614 <sched_init>:
40005614: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005618: 912ec108     	add	x8, x8, #0xbb0
4000561c: d2c00029     	mov	x9, #0x100000000        // =4294967296
40005620: f9001109     	str	x9, [x8, #0x20]
40005624: d2c00049     	mov	x9, #0x200000000        // =8589934592
40005628: d503201f     	nop
4000562c: 30022d80     	adr	x0, 0x40009bdd <__rodata_start+0xbdd>
40005630: f9001d09     	str	x9, [x8, #0x38]
40005634: d2c00069     	mov	x9, #0x300000000        // =12884901888
40005638: f9002909     	str	x9, [x8, #0x50]
4000563c: d2c00089     	mov	x9, #0x400000000        // =17179869184
40005640: f9003509     	str	x9, [x8, #0x68]
40005644: d2c000a9     	mov	x9, #0x500000000        // =21474836480
40005648: f9004109     	str	x9, [x8, #0x80]
4000564c: d2c000c9     	mov	x9, #0x600000000        // =25769803776
40005650: f9004d09     	str	x9, [x8, #0x98]
40005654: d2c000e9     	mov	x9, #0x700000000        // =30064771072
40005658: f9005909     	str	x9, [x8, #0xb0]
4000565c: d2c00109     	mov	x9, #0x800000000        // =34359738368
40005660: f9006509     	str	x9, [x8, #0xc8]
40005664: d2c00129     	mov	x9, #0x900000000        // =38654705664
40005668: f9007109     	str	x9, [x8, #0xe0]
4000566c: d2c00149     	mov	x9, #0xa00000000        // =42949672960
40005670: f9007d09     	str	x9, [x8, #0xf8]
40005674: d2c00169     	mov	x9, #0xb00000000        // =47244640256
40005678: f9008909     	str	x9, [x8, #0x110]
4000567c: d2c00189     	mov	x9, #0xc00000000        // =51539607552
40005680: f9009509     	str	x9, [x8, #0x128]
40005684: d2c001a9     	mov	x9, #0xd00000000        // =55834574848
40005688: f900a109     	str	x9, [x8, #0x140]
4000568c: d2c001c9     	mov	x9, #0xe00000000        // =60129542144
40005690: f900ad09     	str	x9, [x8, #0x158]
40005694: d2c001e9     	mov	x9, #0xf00000000        // =64424509440
40005698: f900b909     	str	x9, [x8, #0x170]
4000569c: 52800049     	mov	w9, #0x2                // =2
400056a0: a900251f     	stp	xzr, x9, [x8]
400056a4: f0000028     	adrp	x8, 0x4000c000 <next_pid>
400056a8: b900091f     	str	wzr, [x8, #0x8]
400056ac: 17fff85f     	b	0x40003828 <uart_puts>

00000000400056b0 <sched_create_task>:
400056b0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400056b4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056b8: a9034ff4     	stp	x20, x19, [sp, #0x30]
400056bc: aa0003f3     	mov	x19, x0
400056c0: b94bd108     	ldr	w8, [x8, #0xbd0]
400056c4: f9000bf7     	str	x23, [sp, #0x10]
400056c8: 910003fd     	mov	x29, sp
400056cc: a90257f6     	stp	x22, x21, [sp, #0x20]
400056d0: 340005c8     	cbz	w8, 0x40005788 <sched_create_task+0xd8>
400056d4: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056d8: b94be908     	ldr	w8, [x8, #0xbe8]
400056dc: 340005a8     	cbz	w8, 0x40005790 <sched_create_task+0xe0>
400056e0: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056e4: b94c0108     	ldr	w8, [x8, #0xc00]
400056e8: 34000588     	cbz	w8, 0x40005798 <sched_create_task+0xe8>
400056ec: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056f0: b94c1908     	ldr	w8, [x8, #0xc18]
400056f4: 34000568     	cbz	w8, 0x400057a0 <sched_create_task+0xf0>
400056f8: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400056fc: b94c3108     	ldr	w8, [x8, #0xc30]
40005700: 34000548     	cbz	w8, 0x400057a8 <sched_create_task+0xf8>
40005704: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005708: b94c4908     	ldr	w8, [x8, #0xc48]
4000570c: 34000528     	cbz	w8, 0x400057b0 <sched_create_task+0x100>
40005710: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005714: b94c6108     	ldr	w8, [x8, #0xc60]
40005718: 34000508     	cbz	w8, 0x400057b8 <sched_create_task+0x108>
4000571c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005720: b94c7908     	ldr	w8, [x8, #0xc78]
40005724: 340004e8     	cbz	w8, 0x400057c0 <sched_create_task+0x110>
40005728: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000572c: b94c9108     	ldr	w8, [x8, #0xc90]
40005730: 340004c8     	cbz	w8, 0x400057c8 <sched_create_task+0x118>
40005734: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005738: b94ca908     	ldr	w8, [x8, #0xca8]
4000573c: 340004a8     	cbz	w8, 0x400057d0 <sched_create_task+0x120>
40005740: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005744: b94cc108     	ldr	w8, [x8, #0xcc0]
40005748: 34000488     	cbz	w8, 0x400057d8 <sched_create_task+0x128>
4000574c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005750: b94cd908     	ldr	w8, [x8, #0xcd8]
40005754: 34000468     	cbz	w8, 0x400057e0 <sched_create_task+0x130>
40005758: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000575c: b94cf108     	ldr	w8, [x8, #0xcf0]
40005760: 34000448     	cbz	w8, 0x400057e8 <sched_create_task+0x138>
40005764: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005768: b94d0908     	ldr	w8, [x8, #0xd08]
4000576c: 34000428     	cbz	w8, 0x400057f0 <sched_create_task+0x140>
40005770: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005774: b94d2108     	ldr	w8, [x8, #0xd20]
40005778: 34000408     	cbz	w8, 0x400057f8 <sched_create_task+0x148>
4000577c: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005780: 910d1800     	add	x0, x0, #0x346
40005784: 1400003c     	b	0x40005874 <sched_create_task+0x1c4>
40005788: 52800034     	mov	w20, #0x1               // =1
4000578c: 1400001c     	b	0x400057fc <sched_create_task+0x14c>
40005790: 52800054     	mov	w20, #0x2               // =2
40005794: 1400001a     	b	0x400057fc <sched_create_task+0x14c>
40005798: 52800074     	mov	w20, #0x3               // =3
4000579c: 14000018     	b	0x400057fc <sched_create_task+0x14c>
400057a0: 52800094     	mov	w20, #0x4               // =4
400057a4: 14000016     	b	0x400057fc <sched_create_task+0x14c>
400057a8: 528000b4     	mov	w20, #0x5               // =5
400057ac: 14000014     	b	0x400057fc <sched_create_task+0x14c>
400057b0: 528000d4     	mov	w20, #0x6               // =6
400057b4: 14000012     	b	0x400057fc <sched_create_task+0x14c>
400057b8: 528000f4     	mov	w20, #0x7               // =7
400057bc: 14000010     	b	0x400057fc <sched_create_task+0x14c>
400057c0: 52800114     	mov	w20, #0x8               // =8
400057c4: 1400000e     	b	0x400057fc <sched_create_task+0x14c>
400057c8: 52800134     	mov	w20, #0x9               // =9
400057cc: 1400000c     	b	0x400057fc <sched_create_task+0x14c>
400057d0: 52800154     	mov	w20, #0xa               // =10
400057d4: 1400000a     	b	0x400057fc <sched_create_task+0x14c>
400057d8: 52800174     	mov	w20, #0xb               // =11
400057dc: 14000008     	b	0x400057fc <sched_create_task+0x14c>
400057e0: 52800194     	mov	w20, #0xc               // =12
400057e4: 14000006     	b	0x400057fc <sched_create_task+0x14c>
400057e8: 528001b4     	mov	w20, #0xd               // =13
400057ec: 14000004     	b	0x400057fc <sched_create_task+0x14c>
400057f0: 528001d4     	mov	w20, #0xe               // =14
400057f4: 14000002     	b	0x400057fc <sched_create_task+0x14c>
400057f8: 528001f4     	mov	w20, #0xf               // =15
400057fc: 97ffff29     	bl	0x400054a0 <pmm_alloc_page>
40005800: b4000360     	cbz	x0, 0x4000586c <sched_create_task+0x1bc>
40005804: 52800308     	mov	w8, #0x18               // =24
40005808: d503201f     	nop
4000580c: 101b9ce9     	adr	x9, 0x4003cba8 <tasks>
40005810: 9ba82696     	umaddl	x22, w20, w8, x9
40005814: 913bc015     	add	x21, x0, #0xef0
40005818: aa0003f7     	mov	x23, x0
4000581c: 2a1f03e1     	mov	w1, wzr
40005820: 52802202     	mov	w2, #0x110              // =272
40005824: f90006c0     	str	x0, [x22, #0x8]
40005828: aa1503e0     	mov	x0, x21
4000582c: 97fff4af     	bl	0x40002ae8 <memset>
40005830: 52800029     	mov	w9, #0x1                // =1
40005834: f907f6f3     	str	x19, [x23, #0xfe8]
40005838: 528000a8     	mov	w8, #0x5                // =5
4000583c: f90002d5     	str	x21, [x22]
40005840: 2a1403e1     	mov	w1, w20
40005844: 2a1303e2     	mov	w2, w19
40005848: b90012c9     	str	w9, [x22, #0x10]
4000584c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005850: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005854: f907fae8     	str	x8, [x23, #0xff0]
40005858: f9400bf7     	ldr	x23, [sp, #0x10]
4000585c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005860: 91228000     	add	x0, x0, #0x8a0
40005864: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005868: 17fff905     	b	0x40003c7c <uart_printf>
4000586c: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005870: 911c1400     	add	x0, x0, #0x705
40005874: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40005878: f9400bf7     	ldr	x23, [sp, #0x10]
4000587c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40005880: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40005884: 17fff7e9     	b	0x40003828 <uart_puts>

0000000040005888 <sched_switch>:
40005888: f0000028     	adrp	x8, 0x4000c000 <next_pid>
4000588c: b940090b     	ldr	w11, [x8, #0x8]
40005890: 3100057f     	cmn	w11, #0x1
40005894: 54000300     	b.eq	0x400058f4 <sched_switch+0x6c>
40005898: 5280030a     	mov	w10, #0x18              // =24
4000589c: d503201f     	nop
400058a0: 101b9849     	adr	x9, 0x4003cba8 <tasks>
400058a4: 9b2a256c     	smaddl	x12, w11, w10, x9
400058a8: 9b2a7d6d     	smull	x13, w11, w10
400058ac: b8410d8e     	ldr	w14, [x12, #0x10]!
400058b0: f82d6920     	str	x0, [x9, x13]
400058b4: 710009df     	cmp	w14, #0x2
400058b8: 54000061     	b.ne	0x400058c4 <sched_switch+0x3c>
400058bc: 5280002d     	mov	w13, #0x1               // =1
400058c0: b900018d     	str	w13, [x12]
400058c4: 5280020c     	mov	w12, #0x10              // =16
400058c8: 1100056b     	add	w11, w11, #0x1
400058cc: 6b0b03ed     	negs	w13, w11
400058d0: 12000d6b     	and	w11, w11, #0xf
400058d4: 12000dad     	and	w13, w13, #0xf
400058d8: 5a8d456b     	csneg	w11, w11, w13, mi
400058dc: 9b2a256d     	smaddl	x13, w11, w10, x9
400058e0: b8410dae     	ldr	w14, [x13, #0x10]!
400058e4: 710005df     	cmp	w14, #0x1
400058e8: 54000080     	b.eq	0x400058f8 <sched_switch+0x70>
400058ec: 7100058c     	subs	w12, w12, #0x1
400058f0: 54fffec1     	b.ne	0x400058c8 <sched_switch+0x40>
400058f4: d65f03c0     	ret
400058f8: 5280030a     	mov	w10, #0x18              // =24
400058fc: b900090b     	str	w11, [x8, #0x8]
40005900: 52800048     	mov	w8, #0x2                // =2
40005904: 9b2a7d6a     	smull	x10, w11, w10
40005908: b90001a8     	str	w8, [x13]
4000590c: f86a6920     	ldr	x0, [x9, x10]
40005910: d65f03c0     	ret

0000000040005914 <virtio_blk_init>:
40005914: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40005918: 528d2ec9     	mov	w9, #0x6976             // =26998
4000591c: 52a14001     	mov	w1, #0xa000000          // =167772160
40005920: 52800408     	mov	w8, #0x20               // =32
40005924: 72ae8e49     	movk	w9, #0x7472, lsl #16
40005928: a9014ff4     	stp	x20, x19, [sp, #0x10]
4000592c: 910003fd     	mov	x29, sp
40005930: 14000004     	b	0x40005940 <virtio_blk_init+0x2c>
40005934: f1000508     	subs	x8, x8, #0x1
40005938: 91080021     	add	x1, x1, #0x200
4000593c: 540001a0     	b.eq	0x40005970 <virtio_blk_init+0x5c>
40005940: b940002a     	ldr	w10, [x1]
40005944: 6b09015f     	cmp	w10, w9
40005948: 54ffff61     	b.ne	0x40005934 <virtio_blk_init+0x20>
4000594c: b9400422     	ldr	w2, [x1, #0x4]
40005950: b940082a     	ldr	w10, [x1, #0x8]
40005954: 7100095f     	cmp	w10, #0x2
40005958: 54fffee1     	b.ne	0x40005934 <virtio_blk_init+0x20>
4000595c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005960: d503201f     	nop
40005964: 7002b040     	adr	x0, 0x4000af6f <__rodata_start+0x1f6f>
40005968: f9069501     	str	x1, [x8, #0xd28]
4000596c: 97fff8c4     	bl	0x40003c7c <uart_printf>
40005970: f00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
40005974: f9469688     	ldr	x8, [x20, #0xd28]
40005978: b40004a8     	cbz	x8, 0x40005a0c <virtio_blk_init+0xf8>
4000597c: 52800029     	mov	w9, #0x1                // =1
40005980: 5280006a     	mov	w10, #0x3               // =3
40005984: b900711f     	str	wzr, [x8, #0x70]
40005988: b9007109     	str	w9, [x8, #0x70]
4000598c: b900710a     	str	w10, [x8, #0x70]
40005990: b900211f     	str	wzr, [x8, #0x20]
40005994: b900311f     	str	wzr, [x8, #0x30]
40005998: b9403509     	ldr	w9, [x8, #0x34]
4000599c: 34000409     	cbz	w9, 0x40005a1c <virtio_blk_init+0x108>
400059a0: 52800209     	mov	w9, #0x10               // =16
400059a4: b9003909     	str	w9, [x8, #0x38]
400059a8: 97fffebe     	bl	0x400054a0 <pmm_alloc_page>
400059ac: aa0003f3     	mov	x19, x0
400059b0: 97fffebc     	bl	0x400054a0 <pmm_alloc_page>
400059b4: b40003d3     	cbz	x19, 0x40005a2c <virtio_blk_init+0x118>
400059b8: f9469688     	ldr	x8, [x20, #0xd28]
400059bc: 52820009     	mov	w9, #0x1000             // =4096
400059c0: 9104026a     	add	x10, x19, #0x100
400059c4: d34cfe6b     	lsr	x11, x19, #12
400059c8: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
400059cc: 911b6800     	add	x0, x0, #0x6da
400059d0: b9002909     	str	w9, [x8, #0x28]
400059d4: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400059d8: f9069d2a     	str	x10, [x9, #0xd38]
400059dc: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400059e0: 528224aa     	mov	w10, #0x1125            // =4389
400059e4: f9069933     	str	x19, [x9, #0xd30]
400059e8: 8b0a0269     	add	x9, x19, x10
400059ec: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
400059f0: 9274cd29     	and	x9, x9, #0xfffffffffffff000
400059f4: 52800033     	mov	w19, #0x1               // =1
400059f8: f906a149     	str	x9, [x10, #0xd40]
400059fc: 528000e9     	mov	w9, #0x7                // =7
40005a00: b900410b     	str	w11, [x8, #0x40]
40005a04: b9007109     	str	w9, [x8, #0x70]
40005a08: 14000008     	b	0x40005a28 <virtio_blk_init+0x114>
40005a0c: 2a1f03f3     	mov	w19, wzr
40005a10: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005a14: 911cf000     	add	x0, x0, #0x73c
40005a18: 14000004     	b	0x40005a28 <virtio_blk_init+0x114>
40005a1c: 2a1f03f3     	mov	w19, wzr
40005a20: b0000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40005a24: 91336400     	add	x0, x0, #0xcd9
40005a28: 97fff780     	bl	0x40003828 <uart_puts>
40005a2c: 2a1303e0     	mov	w0, w19
40005a30: a9414ff4     	ldp	x20, x19, [sp, #0x10]
40005a34: a8c27bfd     	ldp	x29, x30, [sp], #0x20
40005a38: d65f03c0     	ret

0000000040005a3c <virtio_blk_read_sector>:
40005a3c: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005a40: f9469509     	ldr	x9, [x8, #0xd28]
40005a44: b4001309     	cbz	x9, 0x40005ca4 <virtio_blk_read_sector+0x268>
40005a48: d10083ff     	sub	sp, sp, #0x20
40005a4c: d360fc09     	lsr	x9, x0, #32
40005a50: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005a54: 9135216b     	add	x11, x11, #0xd48
40005a58: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005a5c: 9135614a     	add	x10, x10, #0xd58
40005a60: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005a64: 29012560     	stp	w0, w9, [x11, #0x8]
40005a68: 52801fe9     	mov	w9, #0xff               // =255
40005a6c: d358fd6d     	lsr	x13, x11, #24
40005a70: 29007d7f     	stp	wzr, wzr, [x11]
40005a74: d348fc2e     	lsr	x14, x1, #8
40005a78: d368fd6c     	lsr	x12, x11, #40
40005a7c: 39000149     	strb	w9, [x10]
40005a80: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005a84: d348fd4f     	lsr	x15, x10, #8
40005a88: f9469929     	ldr	x9, [x9, #0xd30]
40005a8c: 910043fd     	add	x29, sp, #0x10
40005a90: 39000d2d     	strb	w13, [x9, #0x3]
40005a94: d348fd6d     	lsr	x13, x11, #8
40005a98: 3900452e     	strb	w14, [x9, #0x11]
40005a9c: 5280006e     	mov	w14, #0x3               // =3
40005aa0: 3900052d     	strb	w13, [x9, #0x1]
40005aa4: d368fc2d     	lsr	x13, x1, #40
40005aa8: 3900712e     	strb	w14, [x9, #0x1c]
40005aac: d368fd4e     	lsr	x14, x10, #40
40005ab0: 3900552d     	strb	w13, [x9, #0x15]
40005ab4: 5280004d     	mov	w13, #0x2               // =2
40005ab8: 3900012b     	strb	w11, [x9]
40005abc: 3900152c     	strb	w12, [x9, #0x5]
40005ac0: d350fd6c     	lsr	x12, x11, #16
40005ac4: 3900652d     	strb	w13, [x9, #0x19]
40005ac8: 3900792d     	strb	w13, [x9, #0x1e]
40005acc: 3900852f     	strb	w15, [x9, #0x21]
40005ad0: d378fd6f     	lsr	x15, x11, #56
40005ad4: 3900b12d     	strb	w13, [x9, #0x2c]
40005ad8: d360fd6d     	lsr	x13, x11, #32
40005adc: d370fd6b     	lsr	x11, x11, #48
40005ae0: 3900952e     	strb	w14, [x9, #0x25]
40005ae4: aa0903ee     	mov	x14, x9
40005ae8: 38004dcd     	strb	w13, [x14, #0x4]!
40005aec: aa0903ed     	mov	x13, x9
40005af0: 390009cb     	strb	w11, [x14, #0x2]
40005af4: 5280020b     	mov	w11, #0x10              // =16
40005af8: 38008dab     	strb	w11, [x13, #0x8]!
40005afc: aa0903eb     	mov	x11, x9
40005b00: 39000dbf     	strb	wzr, [x13, #0x3]
40005b04: 390009bf     	strb	wzr, [x13, #0x2]
40005b08: d358fc2d     	lsr	x13, x1, #24
40005b0c: 39000dcf     	strb	w15, [x14, #0x3]
40005b10: d350fc2e     	lsr	x14, x1, #16
40005b14: aa0903ef     	mov	x15, x9
40005b18: 38010d61     	strb	w1, [x11, #0x10]!
40005b1c: 39000d6d     	strb	w13, [x11, #0x3]
40005b20: d360fc2d     	lsr	x13, x1, #32
40005b24: 3900096e     	strb	w14, [x11, #0x2]
40005b28: d378fc2e     	lsr	x14, x1, #56
40005b2c: 38004d6d     	strb	w13, [x11, #0x4]!
40005b30: d370fc2d     	lsr	x13, x1, #48
40005b34: 39000d6e     	strb	w14, [x11, #0x3]
40005b38: aa0903ee     	mov	x14, x9
40005b3c: 3900096d     	strb	w13, [x11, #0x2]
40005b40: d358fd4b     	lsr	x11, x10, #24
40005b44: d350fd4d     	lsr	x13, x10, #16
40005b48: 38020dca     	strb	w10, [x14, #0x20]!
40005b4c: 39000dcb     	strb	w11, [x14, #0x3]
40005b50: d360fd4b     	lsr	x11, x10, #32
40005b54: 390009cd     	strb	w13, [x14, #0x2]
40005b58: 38004dcb     	strb	w11, [x14, #0x4]!
40005b5c: d378fd4b     	lsr	x11, x10, #56
40005b60: d370fd4a     	lsr	x10, x10, #48
40005b64: 3900092c     	strb	w12, [x9, #0x2]
40005b68: 5280002c     	mov	w12, #0x1               // =1
40005b6c: 39000dcb     	strb	w11, [x14, #0x3]
40005b70: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005b74: 390009ca     	strb	w10, [x14, #0x2]
40005b78: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005b7c: 795ab96d     	ldrh	w13, [x11, #0xd5c]
40005b80: f9469d4e     	ldr	x14, [x10, #0xd38]
40005b84: 3900253f     	strb	wzr, [x9, #0x9]
40005b88: 92400dad     	and	x13, x13, #0xf
40005b8c: 3900353f     	strb	wzr, [x9, #0xd]
40005b90: 3900312c     	strb	w12, [x9, #0xc]
40005b94: 39003d3f     	strb	wzr, [x9, #0xf]
40005b98: 3900392c     	strb	w12, [x9, #0xe]
40005b9c: 3900753f     	strb	wzr, [x9, #0x1d]
40005ba0: 39007d3f     	strb	wzr, [x9, #0x1f]
40005ba4: 3900a53f     	strb	wzr, [x9, #0x29]
40005ba8: 3900b53f     	strb	wzr, [x9, #0x2d]
40005bac: 3900bd3f     	strb	wzr, [x9, #0x2f]
40005bb0: 3900b93f     	strb	wzr, [x9, #0x2e]
40005bb4: 38028d2c     	strb	w12, [x9, #0x28]!
40005bb8: 8b0d05cc     	add	x12, x14, x13, lsl #1
40005bbc: 38018dff     	strb	wzr, [x15, #0x18]!
40005bc0: 39000dff     	strb	wzr, [x15, #0x3]
40005bc4: 390009ff     	strb	wzr, [x15, #0x2]
40005bc8: 39000d3f     	strb	wzr, [x9, #0x3]
40005bcc: 3900093f     	strb	wzr, [x9, #0x2]
40005bd0: 3900159f     	strb	wzr, [x12, #0x5]
40005bd4: 3900119f     	strb	wzr, [x12, #0x4]
40005bd8: d5033fbf     	dmb	sy
40005bdc: 795ab969     	ldrh	w9, [x11, #0xd5c]
40005be0: f9469d4a     	ldr	x10, [x10, #0xd38]
40005be4: 11000529     	add	w9, w9, #0x1
40005be8: 53087d2c     	lsr	w12, w9, #8
40005bec: 791ab969     	strh	w9, [x11, #0xd5c]
40005bf0: 39000949     	strb	w9, [x10, #0x2]
40005bf4: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005bf8: 39000d4c     	strb	w12, [x10, #0x3]
40005bfc: d5033fbf     	dmb	sy
40005c00: f9469508     	ldr	x8, [x8, #0xd28]
40005c04: b900511f     	str	wzr, [x8, #0x50]
40005c08: f946a128     	ldr	x8, [x9, #0xd40]
40005c0c: aa0803e9     	mov	x9, x8
40005c10: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005c14: 3940052b     	ldrb	w11, [x9, #0x1]
40005c18: 3940052c     	ldrb	w12, [x9, #0x1]
40005c1c: 3940012d     	ldrb	w13, [x9]
40005c20: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005c24: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005c28: 6b09015f     	cmp	w10, w9
40005c2c: 540002a1     	b.ne	0x40005c80 <virtio_blk_read_sector+0x244>
40005c30: 5292d00a     	mov	w10, #0x9680            // =38528
40005c34: 72a0130a     	movk	w10, #0x98, lsl #16
40005c38: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005c3c: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c40: 71018d7f     	cmp	w11, #0x63
40005c44: 540000ec     	b.gt	0x40005c60 <virtio_blk_read_sector+0x224>
40005c48: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c4c: 1100056b     	add	w11, w11, #0x1
40005c50: b81fc3ab     	stur	w11, [x29, #-0x4]
40005c54: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005c58: 7101917f     	cmp	w11, #0x64
40005c5c: 54ffff6b     	b.lt	0x40005c48 <virtio_blk_read_sector+0x20c>
40005c60: 39400d0b     	ldrb	w11, [x8, #0x3]
40005c64: 3940090c     	ldrb	w12, [x8, #0x2]
40005c68: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005c6c: 6b09017f     	cmp	w11, w9
40005c70: 54000081     	b.ne	0x40005c80 <virtio_blk_read_sector+0x244>
40005c74: 7100055f     	cmp	w10, #0x1
40005c78: 5100054a     	sub	w10, w10, #0x1
40005c7c: 54fffde8     	b.hi	0x40005c38 <virtio_blk_read_sector+0x1fc>
40005c80: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005c84: 39756109     	ldrb	w9, [x8, #0xd58]
40005c88: 34000129     	cbz	w9, 0x40005cac <virtio_blk_read_sector+0x270>
40005c8c: 39756101     	ldrb	w1, [x8, #0xd58]
40005c90: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005c94: 91078c00     	add	x0, x0, #0x1e3
40005c98: 97fff7f9     	bl	0x40003c7c <uart_printf>
40005c9c: 2a1f03e0     	mov	w0, wzr
40005ca0: 14000004     	b	0x40005cb0 <virtio_blk_read_sector+0x274>
40005ca4: 2a1f03e0     	mov	w0, wzr
40005ca8: d65f03c0     	ret
40005cac: 52800020     	mov	w0, #0x1                // =1
40005cb0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005cb4: 910083ff     	add	sp, sp, #0x20
40005cb8: d65f03c0     	ret

0000000040005cbc <virtio_blk_write_sector>:
40005cbc: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005cc0: f9469509     	ldr	x9, [x8, #0xd28]
40005cc4: b4001289     	cbz	x9, 0x40005f14 <virtio_blk_write_sector+0x258>
40005cc8: d10083ff     	sub	sp, sp, #0x20
40005ccc: d360fc0a     	lsr	x10, x0, #32
40005cd0: f00001ac     	adrp	x12, 0x4003c000 <memory_bitmap+0x460>
40005cd4: 9135818c     	add	x12, x12, #0xd60
40005cd8: 52800029     	mov	w9, #0x1                // =1
40005cdc: f00001ab     	adrp	x11, 0x4003c000 <memory_bitmap+0x460>
40005ce0: 9135c16b     	add	x11, x11, #0xd70
40005ce4: 29012980     	stp	w0, w10, [x12, #0x8]
40005ce8: 52801fea     	mov	w10, #0xff              // =255
40005cec: d368fd8d     	lsr	x13, x12, #40
40005cf0: a9017bfd     	stp	x29, x30, [sp, #0x10]
40005cf4: d358fd8e     	lsr	x14, x12, #24
40005cf8: d348fd6f     	lsr	x15, x11, #8
40005cfc: 29007d89     	stp	w9, wzr, [x12]
40005d00: 910043fd     	add	x29, sp, #0x10
40005d04: 3900016a     	strb	w10, [x11]
40005d08: f00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40005d0c: f946994a     	ldr	x10, [x10, #0xd30]
40005d10: 3900154d     	strb	w13, [x10, #0x5]
40005d14: d350fd8d     	lsr	x13, x12, #16
40005d18: 39000d4e     	strb	w14, [x10, #0x3]
40005d1c: d348fd8e     	lsr	x14, x12, #8
40005d20: 3900094d     	strb	w13, [x10, #0x2]
40005d24: d368fc2d     	lsr	x13, x1, #40
40005d28: 3900054e     	strb	w14, [x10, #0x1]
40005d2c: d348fc2e     	lsr	x14, x1, #8
40005d30: 3900554d     	strb	w13, [x10, #0x15]
40005d34: 5280004d     	mov	w13, #0x2               // =2
40005d38: 3900454e     	strb	w14, [x10, #0x11]
40005d3c: d368fd6e     	lsr	x14, x11, #40
40005d40: 3900014c     	strb	w12, [x10]
40005d44: 3900654d     	strb	w13, [x10, #0x19]
40005d48: 3900794d     	strb	w13, [x10, #0x1e]
40005d4c: 3900854f     	strb	w15, [x10, #0x21]
40005d50: d378fd8f     	lsr	x15, x12, #56
40005d54: 3900b14d     	strb	w13, [x10, #0x2c]
40005d58: d360fd8d     	lsr	x13, x12, #32
40005d5c: d370fd8c     	lsr	x12, x12, #48
40005d60: 3900954e     	strb	w14, [x10, #0x25]
40005d64: aa0a03ee     	mov	x14, x10
40005d68: 38004dcd     	strb	w13, [x14, #0x4]!
40005d6c: aa0a03ed     	mov	x13, x10
40005d70: 390009cc     	strb	w12, [x14, #0x2]
40005d74: 5280020c     	mov	w12, #0x10              // =16
40005d78: 38008dac     	strb	w12, [x13, #0x8]!
40005d7c: aa0a03ec     	mov	x12, x10
40005d80: 39000dbf     	strb	wzr, [x13, #0x3]
40005d84: 390009bf     	strb	wzr, [x13, #0x2]
40005d88: d358fc2d     	lsr	x13, x1, #24
40005d8c: 39000dcf     	strb	w15, [x14, #0x3]
40005d90: d350fc2e     	lsr	x14, x1, #16
40005d94: d360fd6f     	lsr	x15, x11, #32
40005d98: 38010d81     	strb	w1, [x12, #0x10]!
40005d9c: 39000d8d     	strb	w13, [x12, #0x3]
40005da0: d360fc2d     	lsr	x13, x1, #32
40005da4: 3900098e     	strb	w14, [x12, #0x2]
40005da8: d378fc2e     	lsr	x14, x1, #56
40005dac: 38004d8d     	strb	w13, [x12, #0x4]!
40005db0: d370fc2d     	lsr	x13, x1, #48
40005db4: 39000d8e     	strb	w14, [x12, #0x3]
40005db8: aa0a03ee     	mov	x14, x10
40005dbc: 3900098d     	strb	w13, [x12, #0x2]
40005dc0: d358fd6d     	lsr	x13, x11, #24
40005dc4: aa0a03ec     	mov	x12, x10
40005dc8: 38018ddf     	strb	wzr, [x14, #0x18]!
40005dcc: 39000ddf     	strb	wzr, [x14, #0x3]
40005dd0: 390009df     	strb	wzr, [x14, #0x2]
40005dd4: d350fd6e     	lsr	x14, x11, #16
40005dd8: 38020d8b     	strb	w11, [x12, #0x20]!
40005ddc: 39000d8d     	strb	w13, [x12, #0x3]
40005de0: d378fd6d     	lsr	x13, x11, #56
40005de4: d370fd6b     	lsr	x11, x11, #48
40005de8: 3900098e     	strb	w14, [x12, #0x2]
40005dec: f00001ae     	adrp	x14, 0x4003c000 <memory_bitmap+0x460>
40005df0: 38004d8f     	strb	w15, [x12, #0x4]!
40005df4: 795ab9cf     	ldrh	w15, [x14, #0xd5c]
40005df8: 39000d8d     	strb	w13, [x12, #0x3]
40005dfc: f00001ad     	adrp	x13, 0x4003c000 <memory_bitmap+0x460>
40005e00: f9469dad     	ldr	x13, [x13, #0xd38]
40005e04: 3900255f     	strb	wzr, [x10, #0x9]
40005e08: 3900355f     	strb	wzr, [x10, #0xd]
40005e0c: 39003149     	strb	w9, [x10, #0xc]
40005e10: 39003d5f     	strb	wzr, [x10, #0xf]
40005e14: 39003949     	strb	w9, [x10, #0xe]
40005e18: 3900755f     	strb	wzr, [x10, #0x1d]
40005e1c: 39007149     	strb	w9, [x10, #0x1c]
40005e20: 39007d5f     	strb	wzr, [x10, #0x1f]
40005e24: 3900a55f     	strb	wzr, [x10, #0x29]
40005e28: 3900b55f     	strb	wzr, [x10, #0x2d]
40005e2c: 3900bd5f     	strb	wzr, [x10, #0x2f]
40005e30: 3900b95f     	strb	wzr, [x10, #0x2e]
40005e34: 38028d49     	strb	w9, [x10, #0x28]!
40005e38: 92400de9     	and	x9, x15, #0xf
40005e3c: 8b0905a9     	add	x9, x13, x9, lsl #1
40005e40: 39000d5f     	strb	wzr, [x10, #0x3]
40005e44: 3900095f     	strb	wzr, [x10, #0x2]
40005e48: 110005ea     	add	w10, w15, #0x1
40005e4c: 3900098b     	strb	w11, [x12, #0x2]
40005e50: 3900153f     	strb	wzr, [x9, #0x5]
40005e54: 3900113f     	strb	wzr, [x9, #0x4]
40005e58: 53087d49     	lsr	w9, w10, #8
40005e5c: 791ab9ca     	strh	w10, [x14, #0xd5c]
40005e60: 390009aa     	strb	w10, [x13, #0x2]
40005e64: 39000da9     	strb	w9, [x13, #0x3]
40005e68: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005e6c: d5033fbf     	dmb	sy
40005e70: f9469508     	ldr	x8, [x8, #0xd28]
40005e74: b900511f     	str	wzr, [x8, #0x50]
40005e78: f946a128     	ldr	x8, [x9, #0xd40]
40005e7c: aa0803e9     	mov	x9, x8
40005e80: 38402d2a     	ldrb	w10, [x9, #0x2]!
40005e84: 3940052b     	ldrb	w11, [x9, #0x1]
40005e88: 3940052c     	ldrb	w12, [x9, #0x1]
40005e8c: 3940012d     	ldrb	w13, [x9]
40005e90: 2a0b2149     	orr	w9, w10, w11, lsl #8
40005e94: 2a0c21aa     	orr	w10, w13, w12, lsl #8
40005e98: 6b09015f     	cmp	w10, w9
40005e9c: 540002a1     	b.ne	0x40005ef0 <virtio_blk_write_sector+0x234>
40005ea0: 5292d00a     	mov	w10, #0x9680            // =38528
40005ea4: 72a0130a     	movk	w10, #0x98, lsl #16
40005ea8: b81fc3bf     	stur	wzr, [x29, #-0x4]
40005eac: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005eb0: 71018d7f     	cmp	w11, #0x63
40005eb4: 540000ec     	b.gt	0x40005ed0 <virtio_blk_write_sector+0x214>
40005eb8: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005ebc: 1100056b     	add	w11, w11, #0x1
40005ec0: b81fc3ab     	stur	w11, [x29, #-0x4]
40005ec4: b85fc3ab     	ldur	w11, [x29, #-0x4]
40005ec8: 7101917f     	cmp	w11, #0x64
40005ecc: 54ffff6b     	b.lt	0x40005eb8 <virtio_blk_write_sector+0x1fc>
40005ed0: 39400d0b     	ldrb	w11, [x8, #0x3]
40005ed4: 3940090c     	ldrb	w12, [x8, #0x2]
40005ed8: 2a0b218b     	orr	w11, w12, w11, lsl #8
40005edc: 6b09017f     	cmp	w11, w9
40005ee0: 54000081     	b.ne	0x40005ef0 <virtio_blk_write_sector+0x234>
40005ee4: 7100055f     	cmp	w10, #0x1
40005ee8: 5100054a     	sub	w10, w10, #0x1
40005eec: 54fffde8     	b.hi	0x40005ea8 <virtio_blk_write_sector+0x1ec>
40005ef0: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005ef4: 3975c109     	ldrb	w9, [x8, #0xd70]
40005ef8: 34000129     	cbz	w9, 0x40005f1c <virtio_blk_write_sector+0x260>
40005efc: 3975c101     	ldrb	w1, [x8, #0xd70]
40005f00: 90000020     	adrp	x0, 0x40009000 <__rodata_start>
40005f04: 912b7000     	add	x0, x0, #0xadc
40005f08: 97fff75d     	bl	0x40003c7c <uart_printf>
40005f0c: 2a1f03e0     	mov	w0, wzr
40005f10: 14000004     	b	0x40005f20 <virtio_blk_write_sector+0x264>
40005f14: 2a1f03e0     	mov	w0, wzr
40005f18: d65f03c0     	ret
40005f1c: 52800020     	mov	w0, #0x1                // =1
40005f20: a9417bfd     	ldp	x29, x30, [sp, #0x10]
40005f24: 910083ff     	add	sp, sp, #0x20
40005f28: d65f03c0     	ret

0000000040005f2c <virtio_net_init>:
40005f2c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40005f30: 528d2ec9     	mov	w9, #0x6976             // =26998
40005f34: 52a14001     	mov	w1, #0xa000000          // =167772160
40005f38: 52800408     	mov	w8, #0x20               // =32
40005f3c: 72ae8e49     	movk	w9, #0x7472, lsl #16
40005f40: f9000bf7     	str	x23, [sp, #0x10]
40005f44: 910003fd     	mov	x29, sp
40005f48: a90257f6     	stp	x22, x21, [sp, #0x20]
40005f4c: a9034ff4     	stp	x20, x19, [sp, #0x30]
40005f50: 14000004     	b	0x40005f60 <virtio_net_init+0x34>
40005f54: f1000508     	subs	x8, x8, #0x1
40005f58: 91080021     	add	x1, x1, #0x200
40005f5c: 54000180     	b.eq	0x40005f8c <virtio_net_init+0x60>
40005f60: b940002a     	ldr	w10, [x1]
40005f64: 6b09015f     	cmp	w10, w9
40005f68: 54ffff61     	b.ne	0x40005f54 <virtio_net_init+0x28>
40005f6c: b940082a     	ldr	w10, [x1, #0x8]
40005f70: 7100055f     	cmp	w10, #0x1
40005f74: 54ffff01     	b.ne	0x40005f54 <virtio_net_init+0x28>
40005f78: f00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40005f7c: d503201f     	nop
40005f80: 1001a560     	adr	x0, 0x4000942c <__rodata_start+0x42c>
40005f84: f906bd01     	str	x1, [x8, #0xd78]
40005f88: 97fff73d     	bl	0x40003c7c <uart_printf>
40005f8c: f00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
40005f90: f946be88     	ldr	x8, [x20, #0xd78]
40005f94: b4001108     	cbz	x8, 0x400061b4 <virtio_net_init+0x288>
40005f98: 52800037     	mov	w23, #0x1               // =1
40005f9c: 52800069     	mov	w9, #0x3                // =3
40005fa0: b900711f     	str	wzr, [x8, #0x70]
40005fa4: b9007117     	str	w23, [x8, #0x70]
40005fa8: d0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
40005fac: 9125c000     	add	x0, x0, #0x970
40005fb0: b9007109     	str	w9, [x8, #0x70]
40005fb4: b9401109     	ldr	w9, [x8, #0x10]
40005fb8: 121b0129     	and	w9, w9, #0x20
40005fbc: b9002109     	str	w9, [x8, #0x20]
40005fc0: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005fc4: 39440101     	ldrb	w1, [x8, #0x100]
40005fc8: 39360121     	strb	w1, [x9, #0xd80]
40005fcc: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005fd0: 39440502     	ldrb	w2, [x8, #0x101]
40005fd4: 39361122     	strb	w2, [x9, #0xd84]
40005fd8: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005fdc: 39440903     	ldrb	w3, [x8, #0x102]
40005fe0: 39362123     	strb	w3, [x9, #0xd88]
40005fe4: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005fe8: 39440d04     	ldrb	w4, [x8, #0x103]
40005fec: 39363124     	strb	w4, [x9, #0xd8c]
40005ff0: f00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40005ff4: 39441105     	ldrb	w5, [x8, #0x104]
40005ff8: 39364125     	strb	w5, [x9, #0xd90]
40005ffc: 39441506     	ldrb	w6, [x8, #0x105]
40006000: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006004: 39365106     	strb	w6, [x8, #0xd94]
40006008: 97fff71d     	bl	0x40003c7c <uart_printf>
4000600c: f946be88     	ldr	x8, [x20, #0xd78]
40006010: d00001b6     	adrp	x22, 0x4003c000 <memory_bitmap+0x460>
40006014: d00001b5     	adrp	x21, 0x4003c000 <memory_bitmap+0x460>
40006018: b900311f     	str	wzr, [x8, #0x30]
4000601c: b9403509     	ldr	w9, [x8, #0x34]
40006020: 34000269     	cbz	w9, 0x4000606c <virtio_net_init+0x140>
40006024: 52800209     	mov	w9, #0x10               // =16
40006028: b9003909     	str	w9, [x8, #0x38]
4000602c: 97fffd1d     	bl	0x400054a0 <pmm_alloc_page>
40006030: aa0003f3     	mov	x19, x0
40006034: 97fffd1b     	bl	0x400054a0 <pmm_alloc_page>
40006038: f946be88     	ldr	x8, [x20, #0xd78]
4000603c: 52820009     	mov	w9, #0x1000             // =4096
40006040: 528224aa     	mov	w10, #0x1125            // =4389
40006044: 8b0a026a     	add	x10, x19, x10
40006048: d34cfe6b     	lsr	x11, x19, #12
4000604c: b9003d09     	str	w9, [x8, #0x3c]
40006050: 91040269     	add	x9, x19, #0x100
40006054: f906d2a9     	str	x9, [x21, #0xda0]
40006058: 9274cd49     	and	x9, x10, #0xfffffffffffff000
4000605c: d00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40006060: f906ced3     	str	x19, [x22, #0xd98]
40006064: f906d549     	str	x9, [x10, #0xda8]
40006068: b900410b     	str	w11, [x8, #0x40]
4000606c: b9003117     	str	w23, [x8, #0x30]
40006070: b9403509     	ldr	w9, [x8, #0x34]
40006074: 340002a9     	cbz	w9, 0x400060c8 <virtio_net_init+0x19c>
40006078: 52800209     	mov	w9, #0x10               // =16
4000607c: b9003909     	str	w9, [x8, #0x38]
40006080: 97fffd08     	bl	0x400054a0 <pmm_alloc_page>
40006084: aa0003f3     	mov	x19, x0
40006088: 97fffd06     	bl	0x400054a0 <pmm_alloc_page>
4000608c: f946be88     	ldr	x8, [x20, #0xd78]
40006090: 52820009     	mov	w9, #0x1000             // =4096
40006094: 9104026b     	add	x11, x19, #0x100
40006098: 528224ac     	mov	w12, #0x1125            // =4389
4000609c: d00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
400060a0: b9003d09     	str	w9, [x8, #0x3c]
400060a4: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400060a8: f906dd2b     	str	x11, [x9, #0xdb8]
400060ac: 8b0c0269     	add	x9, x19, x12
400060b0: d34cfe6b     	lsr	x11, x19, #12
400060b4: f906d953     	str	x19, [x10, #0xdb0]
400060b8: 9274cd29     	and	x9, x9, #0xfffffffffffff000
400060bc: d00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
400060c0: f906e149     	str	x9, [x10, #0xdc0]
400060c4: b900410b     	str	w11, [x8, #0x40]
400060c8: f946d2ad     	ldr	x13, [x21, #0xda0]
400060cc: f946cecb     	ldr	x11, [x22, #0xd98]
400060d0: aa1f03e9     	mov	x9, xzr
400060d4: aa1f03ea     	mov	x10, xzr
400060d8: d00001ac     	adrp	x12, 0x4003c000 <memory_bitmap+0x460>
400060dc: 9137218c     	add	x12, x12, #0xdc8
400060e0: 910011ad     	add	x13, x13, #0x4
400060e4: 5280010e     	mov	w14, #0x8               // =8
400060e8: 5280004f     	mov	w15, #0x2               // =2
400060ec: d368fd91     	lsr	x17, x12, #40
400060f0: 8b090170     	add	x16, x11, x9
400060f4: d358fd92     	lsr	x18, x12, #24
400060f8: d350fd80     	lsr	x0, x12, #16
400060fc: 3900020c     	strb	w12, [x16]
40006100: 91004129     	add	x9, x9, #0x10
40006104: 39001611     	strb	w17, [x16, #0x5]
40006108: d348fd91     	lsr	x17, x12, #8
4000610c: f104013f     	cmp	x9, #0x100
40006110: 39000e12     	strb	w18, [x16, #0x3]
40006114: aa1003f2     	mov	x18, x16
40006118: 39000611     	strb	w17, [x16, #0x1]
4000611c: d360fd91     	lsr	x17, x12, #32
40006120: 39000a00     	strb	w0, [x16, #0x2]
40006124: d378fd80     	lsr	x0, x12, #56
40006128: 38004e51     	strb	w17, [x18, #0x4]!
4000612c: d370fd91     	lsr	x17, x12, #48
40006130: 3900260e     	strb	w14, [x16, #0x9]
40006134: 9120018c     	add	x12, x12, #0x800
40006138: 3900361f     	strb	wzr, [x16, #0xd]
4000613c: 3900320f     	strb	w15, [x16, #0xc]
40006140: 39003e1f     	strb	wzr, [x16, #0xf]
40006144: 39003a1f     	strb	wzr, [x16, #0xe]
40006148: 39000a51     	strb	w17, [x18, #0x2]
4000614c: 8b0a05b1     	add	x17, x13, x10, lsl #1
40006150: 38008e1f     	strb	wzr, [x16, #0x8]!
40006154: 39000e1f     	strb	wzr, [x16, #0x3]
40006158: 39000a1f     	strb	wzr, [x16, #0x2]
4000615c: d348fd50     	lsr	x16, x10, #8
40006160: 39000e40     	strb	w0, [x18, #0x3]
40006164: 3900022a     	strb	w10, [x17]
40006168: 9100054a     	add	x10, x10, #0x1
4000616c: 39000630     	strb	w16, [x17, #0x1]
40006170: 54fffbe1     	b.ne	0x400060ec <virtio_net_init+0x1c0>
40006174: 528000e9     	mov	w9, #0x7                // =7
40006178: d00001ea     	adrp	x10, 0x40044000 <rx_buffers+0x7238>
4000617c: b9007109     	str	w9, [x8, #0x70]
40006180: 52800209     	mov	w9, #0x10               // =16
40006184: d5033fbf     	dmb	sy
40006188: 791b9149     	strh	w9, [x10, #0xdc8]
4000618c: f946d2a8     	ldr	x8, [x21, #0xda0]
40006190: 39000909     	strb	w9, [x8, #0x2]
40006194: f946be89     	ldr	x9, [x20, #0xd78]
40006198: 39000d1f     	strb	wzr, [x8, #0x3]
4000619c: b900513f     	str	wzr, [x9, #0x50]
400061a0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400061a4: f9400bf7     	ldr	x23, [sp, #0x10]
400061a8: a94257f6     	ldp	x22, x21, [sp, #0x20]
400061ac: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400061b0: d65f03c0     	ret
400061b4: a9434ff4     	ldp	x20, x19, [sp, #0x30]
400061b8: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
400061bc: 91027000     	add	x0, x0, #0x9c
400061c0: a94257f6     	ldp	x22, x21, [sp, #0x20]
400061c4: f9400bf7     	ldr	x23, [sp, #0x10]
400061c8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
400061cc: 17fff597     	b	0x40003828 <uart_puts>

00000000400061d0 <virtio_net_poll>:
400061d0: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400061d4: f946bd08     	ldr	x8, [x8, #0xd78]
400061d8: b40006e8     	cbz	x8, 0x400062b4 <virtio_net_poll+0xe4>
400061dc: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400061e0: a9054ff4     	stp	x20, x19, [sp, #0x50]
400061e4: d00001b4     	adrp	x20, 0x4003c000 <memory_bitmap+0x460>
400061e8: 910003fd     	mov	x29, sp
400061ec: f946e289     	ldr	x9, [x20, #0xdc0]
400061f0: a9016ffc     	stp	x28, x27, [sp, #0x10]
400061f4: a90267fa     	stp	x26, x25, [sp, #0x20]
400061f8: a9035ff8     	stp	x24, x23, [sp, #0x30]
400061fc: a90457f6     	stp	x22, x21, [sp, #0x40]
40006200: d00001f5     	adrp	x21, 0x40044000 <rx_buffers+0x7238>
40006204: 795b9aa8     	ldrh	w8, [x21, #0xdcc]
40006208: 39400d2a     	ldrb	w10, [x9, #0x3]
4000620c: 3940092b     	ldrb	w11, [x9, #0x2]
40006210: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006214: 6b0a011f     	cmp	w8, w10
40006218: 54000300     	b.eq	0x40006278 <virtio_net_poll+0xa8>
4000621c: 90000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
40006220: 9108fa73     	add	x19, x19, #0x23e
40006224: 92400d08     	and	x8, x8, #0xf
40006228: aa1303e0     	mov	x0, x19
4000622c: 8b080d28     	add	x8, x9, x8, lsl #3
40006230: 38404d09     	ldrb	w9, [x8, #0x4]!
40006234: 3940090a     	ldrb	w10, [x8, #0x2]
40006238: 3940050b     	ldrb	w11, [x8, #0x1]
4000623c: 39400d08     	ldrb	w8, [x8, #0x3]
40006240: 53103d4a     	lsl	w10, w10, #16
40006244: 2a0b2129     	orr	w9, w9, w11, lsl #8
40006248: 2a086148     	orr	w8, w10, w8, lsl #24
4000624c: 2a090101     	orr	w1, w8, w9
40006250: 97fff68b     	bl	0x40003c7c <uart_printf>
40006254: 795b9aa8     	ldrh	w8, [x21, #0xdcc]
40006258: f946e289     	ldr	x9, [x20, #0xdc0]
4000625c: 11000508     	add	w8, w8, #0x1
40006260: 791b9aa8     	strh	w8, [x21, #0xdcc]
40006264: 39400d2a     	ldrb	w10, [x9, #0x3]
40006268: 3940092b     	ldrb	w11, [x9, #0x2]
4000626c: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006270: 6b28215f     	cmp	w10, w8, uxth
40006274: 54fffd81     	b.ne	0x40006224 <virtio_net_poll+0x54>
40006278: d00001ba     	adrp	x26, 0x4003c000 <memory_bitmap+0x460>
4000627c: d00001fb     	adrp	x27, 0x40044000 <rx_buffers+0x7238>
40006280: f946d749     	ldr	x9, [x26, #0xda8]
40006284: 795ba368     	ldrh	w8, [x27, #0xdd0]
40006288: 39400d2a     	ldrb	w10, [x9, #0x3]
4000628c: 3940092b     	ldrb	w11, [x9, #0x2]
40006290: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006294: 6b0a011f     	cmp	w8, w10
40006298: 54000101     	b.ne	0x400062b8 <virtio_net_poll+0xe8>
4000629c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400062a0: a94457f6     	ldp	x22, x21, [sp, #0x40]
400062a4: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400062a8: a94267fa     	ldp	x26, x25, [sp, #0x20]
400062ac: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400062b0: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400062b4: d65f03c0     	ret
400062b8: f0000014     	adrp	x20, 0x40009000 <__rodata_start>
400062bc: 91283294     	add	x20, x20, #0xa0c
400062c0: 90000035     	adrp	x21, 0x4000a000 <__rodata_start+0x1000>
400062c4: 912442b5     	add	x21, x21, #0x910
400062c8: d00001bc     	adrp	x28, 0x4003c000 <memory_bitmap+0x460>
400062cc: d00001f9     	adrp	x25, 0x40044000 <rx_buffers+0x7238>
400062d0: 90000036     	adrp	x22, 0x4000a000 <__rodata_start+0x1000>
400062d4: 9114e2d6     	add	x22, x22, #0x538
400062d8: 1400001e     	b	0x40006350 <virtio_net_poll+0x180>
400062dc: aa1503e0     	mov	x0, x21
400062e0: 97fff552     	bl	0x40003828 <uart_puts>
400062e4: 795b9328     	ldrh	w8, [x25, #0xdc8]
400062e8: f946d389     	ldr	x9, [x28, #0xda0]
400062ec: 53087eea     	lsr	w10, w23, #8
400062f0: 92400d08     	and	x8, x8, #0xf
400062f4: 8b080528     	add	x8, x9, x8, lsl #1
400062f8: 3900150a     	strb	w10, [x8, #0x5]
400062fc: 39001117     	strb	w23, [x8, #0x4]
40006300: d5033fbf     	dmb	sy
40006304: 795b9328     	ldrh	w8, [x25, #0xdc8]
40006308: f946d389     	ldr	x9, [x28, #0xda0]
4000630c: 11000508     	add	w8, w8, #0x1
40006310: 39000928     	strb	w8, [x9, #0x2]
40006314: 53087d0a     	lsr	w10, w8, #8
40006318: 791b9328     	strh	w8, [x25, #0xdc8]
4000631c: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006320: f946bd08     	ldr	x8, [x8, #0xd78]
40006324: 39000d2a     	strb	w10, [x9, #0x3]
40006328: b900511f     	str	wzr, [x8, #0x50]
4000632c: 795ba368     	ldrh	w8, [x27, #0xdd0]
40006330: f946d749     	ldr	x9, [x26, #0xda8]
40006334: 11000508     	add	w8, w8, #0x1
40006338: 791ba368     	strh	w8, [x27, #0xdd0]
4000633c: 39400d2a     	ldrb	w10, [x9, #0x3]
40006340: 3940092b     	ldrb	w11, [x9, #0x2]
40006344: 2a0a216a     	orr	w10, w11, w10, lsl #8
40006348: 6b28215f     	cmp	w10, w8, uxth
4000634c: 54fffa80     	b.eq	0x4000629c <virtio_net_poll+0xcc>
40006350: 92400d08     	and	x8, x8, #0xf
40006354: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
40006358: 910d4400     	add	x0, x0, #0x351
4000635c: 8b080d28     	add	x8, x9, x8, lsl #3
40006360: 38404d09     	ldrb	w9, [x8, #0x4]!
40006364: 38404d0a     	ldrb	w10, [x8, #0x4]!
40006368: 385fe10b     	ldurb	w11, [x8, #-0x2]
4000636c: 3940090c     	ldrb	w12, [x8, #0x2]
40006370: 385fd10d     	ldurb	w13, [x8, #-0x3]
40006374: 385ff10e     	ldurb	w14, [x8, #-0x1]
40006378: d370bd6b     	lsl	x11, x11, #16
4000637c: 3940050f     	ldrb	w15, [x8, #0x1]
40006380: 39400d08     	ldrb	w8, [x8, #0x3]
40006384: 53103d8c     	lsl	w12, w12, #16
40006388: aa0d2129     	orr	x9, x9, x13, lsl #8
4000638c: aa0e616b     	orr	x11, x11, x14, lsl #24
40006390: 2a0f214a     	orr	w10, w10, w15, lsl #8
40006394: 2a086188     	orr	w8, w12, w8, lsl #24
40006398: aa090177     	orr	x23, x11, x9
4000639c: 2a0a0118     	orr	w24, w8, w10
400063a0: 2a1703e2     	mov	w2, w23
400063a4: 2a1803e1     	mov	w1, w24
400063a8: 97fff635     	bl	0x40003c7c <uart_printf>
400063ac: aa1403e0     	mov	x0, x20
400063b0: 97fff51e     	bl	0x40003828 <uart_puts>
400063b4: 34fff958     	cbz	w24, 0x400062dc <virtio_net_poll+0x10c>
400063b8: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
400063bc: 91372108     	add	x8, x8, #0xdc8
400063c0: 7100831f     	cmp	w24, #0x20
400063c4: 8b172d13     	add	x19, x8, x23, lsl #11
400063c8: 52800408     	mov	w8, #0x20               // =32
400063cc: 1a883318     	csel	w24, w24, w8, lo
400063d0: 38401661     	ldrb	w1, [x19], #0x1
400063d4: aa1603e0     	mov	x0, x22
400063d8: 97fff629     	bl	0x40003c7c <uart_printf>
400063dc: f1000718     	subs	x24, x24, #0x1
400063e0: 54ffff81     	b.ne	0x400063d0 <virtio_net_poll+0x200>
400063e4: 17ffffbe     	b	0x400062dc <virtio_net_poll+0x10c>

00000000400063e8 <virtio_net_send>:
400063e8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
400063ec: a90257f6     	stp	x22, x21, [sp, #0x20]
400063f0: d00001b6     	adrp	x22, 0x4003c000 <memory_bitmap+0x460>
400063f4: 910003fd     	mov	x29, sp
400063f8: f946bec8     	ldr	x8, [x22, #0xd78]
400063fc: a9015ff8     	stp	x24, x23, [sp, #0x10]
40006400: a9034ff4     	stp	x20, x19, [sp, #0x30]
40006404: b4000968     	cbz	x8, 0x40006530 <virtio_net_send+0x148>
40006408: d00001f7     	adrp	x23, 0x40044000 <rx_buffers+0x7238>
4000640c: aa0103f3     	mov	x19, x1
40006410: aa0003f5     	mov	x21, x0
40006414: 795baae8     	ldrh	w8, [x23, #0xdd4]
40006418: 2a1f03e1     	mov	w1, wzr
4000641c: 52800142     	mov	w2, #0xa                // =10
40006420: 92400d18     	and	x24, x8, #0xf
40006424: d00001e8     	adrp	x8, 0x40044000 <rx_buffers+0x7238>
40006428: 91375908     	add	x8, x8, #0xdd6
4000642c: 8b182d14     	add	x20, x8, x24, lsl #11
40006430: aa1403e0     	mov	x0, x20
40006434: 97fff1ad     	bl	0x40002ae8 <memset>
40006438: 91002a80     	add	x0, x20, #0xa
4000643c: aa1503e1     	mov	x1, x21
40006440: aa1303e2     	mov	x2, x19
40006444: 97fff1bf     	bl	0x40002b40 <memcpy>
40006448: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000644c: d368fe89     	lsr	x9, x20, #40
40006450: d358fe8a     	lsr	x10, x20, #24
40006454: f946d908     	ldr	x8, [x8, #0xdb0]
40006458: d350fe8b     	lsr	x11, x20, #16
4000645c: d370fe8c     	lsr	x12, x20, #48
40006460: d378fe8d     	lsr	x13, x20, #56
40006464: aa1303e1     	mov	x1, x19
40006468: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
4000646c: 912bbc00     	add	x0, x0, #0xaef
40006470: 8b181108     	add	x8, x8, x24, lsl #4
40006474: 39001509     	strb	w9, [x8, #0x5]
40006478: d348fe89     	lsr	x9, x20, #8
4000647c: 39000d0a     	strb	w10, [x8, #0x3]
40006480: 11002a6a     	add	w10, w19, #0xa
40006484: 3900090b     	strb	w11, [x8, #0x2]
40006488: 53087d4b     	lsr	w11, w10, #8
4000648c: 39000509     	strb	w9, [x8, #0x1]
40006490: d360fe89     	lsr	x9, x20, #32
40006494: 39000114     	strb	w20, [x8]
40006498: 3900250b     	strb	w11, [x8, #0x9]
4000649c: aa0803eb     	mov	x11, x8
400064a0: 3900351f     	strb	wzr, [x8, #0xd]
400064a4: 3900311f     	strb	wzr, [x8, #0xc]
400064a8: 39003d1f     	strb	wzr, [x8, #0xf]
400064ac: 3900391f     	strb	wzr, [x8, #0xe]
400064b0: 38004d09     	strb	w9, [x8, #0x4]!
400064b4: 53107d49     	lsr	w9, w10, #16
400064b8: 38008d6a     	strb	w10, [x11, #0x8]!
400064bc: 53187d4a     	lsr	w10, w10, #24
400064c0: 39000969     	strb	w9, [x11, #0x2]
400064c4: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
400064c8: 3900090c     	strb	w12, [x8, #0x2]
400064cc: 795baaec     	ldrh	w12, [x23, #0xdd4]
400064d0: f946dd2e     	ldr	x14, [x9, #0xdb8]
400064d4: 39000d0d     	strb	w13, [x8, #0x3]
400064d8: 92400d8c     	and	x12, x12, #0xf
400064dc: 39000d6a     	strb	w10, [x11, #0x3]
400064e0: 8b0c05c8     	add	x8, x14, x12, lsl #1
400064e4: 3900151f     	strb	wzr, [x8, #0x5]
400064e8: 39001118     	strb	w24, [x8, #0x4]
400064ec: d5033fbf     	dmb	sy
400064f0: 795baae8     	ldrh	w8, [x23, #0xdd4]
400064f4: f946dd29     	ldr	x9, [x9, #0xdb8]
400064f8: 11000508     	add	w8, w8, #0x1
400064fc: 53087d0a     	lsr	w10, w8, #8
40006500: 791baae8     	strh	w8, [x23, #0xdd4]
40006504: 39000928     	strb	w8, [x9, #0x2]
40006508: 39000d2a     	strb	w10, [x9, #0x3]
4000650c: 52800029     	mov	w9, #0x1                // =1
40006510: d5033fbf     	dmb	sy
40006514: f946bec8     	ldr	x8, [x22, #0xd78]
40006518: b9005109     	str	w9, [x8, #0x50]
4000651c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40006520: a94257f6     	ldp	x22, x21, [sp, #0x20]
40006524: a9415ff8     	ldp	x24, x23, [sp, #0x10]
40006528: a8c47bfd     	ldp	x29, x30, [sp], #0x40
4000652c: 17fff5d4     	b	0x40003c7c <uart_printf>
40006530: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40006534: a94257f6     	ldp	x22, x21, [sp, #0x20]
40006538: a9415ff8     	ldp	x24, x23, [sp, #0x10]
4000653c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40006540: d65f03c0     	ret

0000000040006544 <virtio_net_get_mac>:
40006544: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006548: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
4000654c: d00001aa     	adrp	x10, 0x4003c000 <memory_bitmap+0x460>
40006550: 39760108     	ldrb	w8, [x8, #0xd80]
40006554: 39000008     	strb	w8, [x0]
40006558: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
4000655c: 39761129     	ldrb	w9, [x9, #0xd84]
40006560: 39762108     	ldrb	w8, [x8, #0xd88]
40006564: 3976314a     	ldrb	w10, [x10, #0xd8c]
40006568: 39000409     	strb	w9, [x0, #0x1]
4000656c: d00001a9     	adrp	x9, 0x4003c000 <memory_bitmap+0x460>
40006570: 39000808     	strb	w8, [x0, #0x2]
40006574: d00001a8     	adrp	x8, 0x4003c000 <memory_bitmap+0x460>
40006578: 39764129     	ldrb	w9, [x9, #0xd90]
4000657c: 39765108     	ldrb	w8, [x8, #0xd94]
40006580: 39000c0a     	strb	w10, [x0, #0x3]
40006584: 39001009     	strb	w9, [x0, #0x4]
40006588: 39001408     	strb	w8, [x0, #0x5]
4000658c: d65f03c0     	ret

0000000040006590 <fat16_init>:
40006590: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
40006594: a9014ffc     	stp	x28, x19, [sp, #0x10]
40006598: 910003fd     	mov	x29, sp
4000659c: d10803ff     	sub	sp, sp, #0x200
400065a0: d503201f     	nop
400065a4: 5001f960     	adr	x0, 0x4000a4d2 <__rodata_start+0x14d2>
400065a8: 97fff4a0     	bl	0x40003828 <uart_puts>
400065ac: 910003e1     	mov	x1, sp
400065b0: aa1f03e0     	mov	x0, xzr
400065b4: 97fffd22     	bl	0x40005a3c <virtio_blk_read_sector>
400065b8: 34000780     	cbz	w0, 0x400066a8 <fat16_init+0x118>
400065bc: d503201f     	nop
400065c0: 102340d3     	adr	x19, 0x4004cdd8 <bpb>
400065c4: 910003e1     	mov	x1, sp
400065c8: aa1303e0     	mov	x0, x19
400065cc: 528007c2     	mov	w2, #0x3e               // =62
400065d0: 97fff15c     	bl	0x40002b40 <memcpy>
400065d4: 90000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400065d8: 91029421     	add	x1, x1, #0xa5
400065dc: 9100da60     	add	x0, x19, #0x36
400065e0: 528000a2     	mov	w2, #0x5                // =5
400065e4: 97fff105     	bl	0x400029f8 <kstrncmp>
400065e8: 34000160     	cbz	w0, 0x40006614 <fat16_init+0x84>
400065ec: d0000220     	adrp	x0, 0x4004c000 <tx_buffers+0x722a>
400065f0: 91383800     	add	x0, x0, #0xe0e
400065f4: 90000021     	adrp	x1, 0x4000a000 <__rodata_start+0x1000>
400065f8: 910e2c21     	add	x1, x1, #0x38b
400065fc: 528000a2     	mov	w2, #0x5                // =5
40006600: 97fff0fe     	bl	0x400029f8 <kstrncmp>
40006604: 34000080     	cbz	w0, 0x40006614 <fat16_init+0x84>
40006608: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
4000660c: 91344c00     	add	x0, x0, #0xd13
40006610: 97fff486     	bl	0x40003828 <uart_puts>
40006614: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40006618: 91378d08     	add	x8, x8, #0xde3
4000661c: d0000233     	adrp	x19, 0x4004c000 <tx_buffers+0x722a>
40006620: 39401d09     	ldrb	w9, [x8, #0x7]
40006624: 3940190a     	ldrb	w10, [x8, #0x6]
40006628: 3940050b     	ldrb	w11, [x8, #0x1]
4000662c: 3940010c     	ldrb	w12, [x8]
40006630: 39400d0d     	ldrb	w13, [x8, #0x3]
40006634: 39400901     	ldrb	w1, [x8, #0x2]
40006638: 2a092142     	orr	w2, w10, w9, lsl #8
4000663c: f0000000     	adrp	x0, 0x40009000 <__rodata_start>
40006640: 91286400     	add	x0, x0, #0xa19
40006644: 2a0b2189     	orr	w9, w12, w11, lsl #8
40006648: 3940310b     	ldrb	w11, [x8, #0xc]
4000664c: 39402d0c     	ldrb	w12, [x8, #0xb]
40006650: 0b02152a     	add	w10, w9, w2, lsl #5
40006654: 2a0b218b     	orr	w11, w12, w11, lsl #8
40006658: 3940150c     	ldrb	w12, [x8, #0x5]
4000665c: 5100054a     	sub	w10, w10, #0x1
40006660: 1ac90d49     	sdiv	w9, w10, w9
40006664: 3940110a     	ldrb	w10, [x8, #0x4]
40006668: 2a0a21aa     	orr	w10, w13, w10, lsl #8
4000666c: 1b0c296b     	madd	w11, w11, w12, w10
40006670: d000022c     	adrp	x12, 0x4004c000 <tx_buffers+0x722a>
40006674: b90e198a     	str	w10, [x12, #0xe18]
40006678: d000022a     	adrp	x10, 0x4004c000 <tx_buffers+0x722a>
4000667c: b90e1d4b     	str	w11, [x10, #0xe1c]
40006680: d000022a     	adrp	x10, 0x4004c000 <tx_buffers+0x722a>
40006684: b90e2149     	str	w9, [x10, #0xe20]
40006688: 0b0b0129     	add	w9, w9, w11
4000668c: b90e2669     	str	w9, [x19, #0xe24]
40006690: 97fff57b     	bl	0x40003c7c <uart_printf>
40006694: b94e2661     	ldr	w1, [x19, #0xe24]
40006698: b0000020     	adrp	x0, 0x4000b000 <__rodata_start+0x2000>
4000669c: 91081c00     	add	x0, x0, #0x207
400066a0: 97fff577     	bl	0x40003c7c <uart_printf>
400066a4: 14000004     	b	0x400066b4 <fat16_init+0x124>
400066a8: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400066ac: 91233c00     	add	x0, x0, #0x8cf
400066b0: 97fff45e     	bl	0x40003828 <uart_puts>
400066b4: 910803ff     	add	sp, sp, #0x200
400066b8: a9414ffc     	ldp	x28, x19, [sp, #0x10]
400066bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
400066c0: d65f03c0     	ret

00000000400066c4 <fat16_list_root>:
400066c4: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
400066c8: a9016ffc     	stp	x28, x27, [sp, #0x10]
400066cc: 910003fd     	mov	x29, sp
400066d0: a90267fa     	stp	x26, x25, [sp, #0x20]
400066d4: a9035ff8     	stp	x24, x23, [sp, #0x30]
400066d8: a90457f6     	stp	x22, x21, [sp, #0x40]
400066dc: a9054ff4     	stp	x20, x19, [sp, #0x50]
400066e0: d10843ff     	sub	sp, sp, #0x210
400066e4: 90000020     	adrp	x0, 0x4000a000 <__rodata_start+0x1000>
400066e8: 9123dc00     	add	x0, x0, #0x8f7
400066ec: 97fff44f     	bl	0x40003828 <uart_puts>
400066f0: d0000235     	adrp	x21, 0x4004c000 <tx_buffers+0x722a>
400066f4: b94e22a8     	ldr	w8, [x21, #0xe20]
400066f8: 34000ee8     	cbz	w8, 0x400068d4 <fat16_list_root+0x210>
400066fc: 2a1f03f6     	mov	w22, wzr
40006700: d0000237     	adrp	x23, 0x4004c000 <tx_buffers+0x722a>
40006704: 910003f8     	mov	x24, sp
40006708: 90000033     	adrp	x19, 0x4000a000 <__rodata_start+0x1000>
4000670c: 913ea673     	add	x19, x19, #0xfa9
40006710: 90000034     	adrp	x20, 0x4000a000 <__rodata_start+0x1000>
40006714: 9113e294     	add	x20, x20, #0x4f8
40006718: 528005d9     	mov	w25, #0x2e              // =46
4000671c: 14000005     	b	0x40006730 <fat16_list_root+0x6c>
40006720: b94e22a8     	ldr	w8, [x21, #0xe20]
40006724: 110006d6     	add	w22, w22, #0x1
40006728: 6b0802df     	cmp	w22, w8
4000672c: 54000d42     	b.hs	0x400068d4 <fat16_list_root+0x210>
40006730: b94e1ee8     	ldr	w8, [x23, #0xe1c]
40006734: 910043e1     	add	x1, sp, #0x10
40006738: 910043fa     	add	x26, sp, #0x10
4000673c: 0b160100     	add	w0, w8, w22
40006740: 97fffcbf     	bl	0x40005a3c <virtio_blk_read_sector>
40006744: 5280021b     	mov	w27, #0x10              // =16
40006748: 14000010     	b	0x40006788 <fat16_list_root+0xc4>
4000674c: aa1a03e8     	mov	x8, x26
40006750: 910003e1     	mov	x1, sp
40006754: aa1303e0     	mov	x0, x19
40006758: 3841cd09     	ldrb	w9, [x8, #0x1c]!
4000675c: 3940090a     	ldrb	w10, [x8, #0x2]
40006760: 3940050b     	ldrb	w11, [x8, #0x1]
40006764: 39400d08     	ldrb	w8, [x8, #0x3]
40006768: 53103d4a     	lsl	w10, w10, #16
4000676c: 2a0b2129     	orr	w9, w9, w11, lsl #8
40006770: 2a086148     	orr	w8, w10, w8, lsl #24
40006774: 2a090102     	orr	w2, w8, w9
40006778: 97fff541     	bl	0x40003c7c <uart_printf>
4000677c: f100077b     	subs	x27, x27, #0x1
40006780: 9100835a     	add	x26, x26, #0x20
40006784: 54fffce0     	b.eq	0x40006720 <fat16_list_root+0x5c>
40006788: 39400349     	ldrb	w9, [x26]
4000678c: 7103953f     	cmp	w9, #0xe5
40006790: 54ffff60     	b.eq	0x4000677c <fat16_list_root+0xb8>
40006794: 34000a09     	cbz	w9, 0x400068d4 <fat16_list_root+0x210>
40006798: 39402f48     	ldrb	w8, [x26, #0xb]
4000679c: 72000d1f     	tst	w8, #0xf
400067a0: 54fffee1     	b.ne	0x4000677c <fat16_list_root+0xb8>
400067a4: 7100813f     	cmp	w9, #0x20
400067a8: 54000061     	b.ne	0x400067b4 <fat16_list_root+0xf0>
400067ac: aa1f03e9     	mov	x9, xzr
400067b0: 14000003     	b	0x400067bc <fat16_list_root+0xf8>
400067b4: 390003e9     	strb	w9, [sp]
400067b8: 52800029     	mov	w9, #0x1                // =1
400067bc: 3940074a     	ldrb	w10, [x26, #0x1]
400067c0: 7100815f     	cmp	w10, #0x20
400067c4: 54000080     	b.eq	0x400067d4 <fat16_list_root+0x110>
400067c8: aa09030b     	orr	x11, x24, x9
400067cc: 91000529     	add	x9, x9, #0x1
400067d0: 3900016a     	strb	w10, [x11]
400067d4: 39400b4a     	ldrb	w10, [x26, #0x2]
400067d8: 7100815f     	cmp	w10, #0x20
400067dc: 54000080     	b.eq	0x400067ec <fat16_list_root+0x128>
400067e0: aa09030b     	orr	x11, x24, x9
400067e4: 91000529     	add	x9, x9, #0x1
400067e8: 3900016a     	strb	w10, [x11]
400067ec: 39400f4a     	ldrb	w10, [x26, #0x3]
400067f0: 7100815f     	cmp	w10, #0x20
400067f4: 54000080     	b.eq	0x40006804 <fat16_list_root+0x140>
400067f8: 9100052b     	add	x11, x9, #0x1
400067fc: 38296b0a     	strb	w10, [x24, x9]
40006800: aa0b03e9     	mov	x9, x11
40006804: 3940134a     	ldrb	w10, [x26, #0x4]
40006808: 7100815f     	cmp	w10, #0x20
4000680c: 54000080     	b.eq	0x4000681c <fat16_list_root+0x158>
40006810: 9100052b     	add	x11, x9, #0x1
40006814: 38296b0a     	strb	w10, [x24, x9]
40006818: aa0b03e9     	mov	x9, x11
4000681c: 3940174a     	ldrb	w10, [x26, #0x5]
40006820: 7100815f     	cmp	w10, #0x20
40006824: 54000080     	b.eq	0x40006834 <fat16_list_root+0x170>
40006828: 9100052b     	add	x11, x9, #0x1
4000682c: 38296b0a     	strb	w10, [x24, x9]
40006830: aa0b03e9     	mov	x9, x11
40006834: 39401b4a     	ldrb	w10, [x26, #0x6]
40006838: 7100815f     	cmp	w10, #0x20
4000683c: 54000080     	b.eq	0x4000684c <fat16_list_root+0x188>
40006840: 9100052b     	add	x11, x9, #0x1
40006844: 38296b0a     	strb	w10, [x24, x9]
40006848: aa0b03e9     	mov	x9, x11
4000684c: 39401f4a     	ldrb	w10, [x26, #0x7]
40006850: 7100815f     	cmp	w10, #0x20
40006854: 54000080     	b.eq	0x40006864 <fat16_list_root+0x1a0>
40006858: 9100052b     	add	x11, x9, #0x1
4000685c: 38296b0a     	strb	w10, [x24, x9]
40006860: aa0b03e9     	mov	x9, x11
40006864: 3940234b     	ldrb	w11, [x26, #0x8]
40006868: 7100817f     	cmp	w11, #0x20
4000686c: 540001e0     	b.eq	0x400068a8 <fat16_list_root+0x1e4>
40006870: 3940274c     	ldrb	w12, [x26, #0x9]
40006874: 8b09030d     	add	x13, x24, x9
40006878: 9100092a     	add	x10, x9, #0x2
4000687c: 390001b9     	strb	w25, [x13]
40006880: 7100819f     	cmp	w12, #0x20
40006884: 390005ab     	strb	w11, [x13, #0x1]
40006888: 54000080     	b.eq	0x40006898 <fat16_list_root+0x1d4>
4000688c: 91000d29     	add	x9, x9, #0x3
40006890: 382a6b0c     	strb	w12, [x24, x10]
40006894: aa0903ea     	mov	x10, x9
40006898: 39402b4b     	ldrb	w11, [x26, #0xa]
4000689c: 7100817f     	cmp	w11, #0x20
400068a0: 54000101     	b.ne	0x400068c0 <fat16_list_root+0x1fc>
400068a4: aa0a03e9     	mov	x9, x10
400068a8: 38296b1f     	strb	wzr, [x24, x9]
400068ac: 3627f508     	tbz	w8, #0x4, 0x4000674c <fat16_list_root+0x88>
400068b0: 910003e1     	mov	x1, sp
400068b4: aa1403e0     	mov	x0, x20
400068b8: 97fff4f1     	bl	0x40003c7c <uart_printf>
400068bc: 17ffffb0     	b	0x4000677c <fat16_list_root+0xb8>
400068c0: 91000549     	add	x9, x10, #0x1
400068c4: 382a6b0b     	strb	w11, [x24, x10]
400068c8: 38296b1f     	strb	wzr, [x24, x9]
400068cc: 3627f408     	tbz	w8, #0x4, 0x4000674c <fat16_list_root+0x88>
400068d0: 17fffff8     	b	0x400068b0 <fat16_list_root+0x1ec>
400068d4: 910843ff     	add	sp, sp, #0x210
400068d8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
400068dc: a94457f6     	ldp	x22, x21, [sp, #0x40]
400068e0: a9435ff8     	ldp	x24, x23, [sp, #0x30]
400068e4: a94267fa     	ldp	x26, x25, [sp, #0x20]
400068e8: a9416ffc     	ldp	x28, x27, [sp, #0x10]
400068ec: a8c67bfd     	ldp	x29, x30, [sp], #0x60
400068f0: d65f03c0     	ret

00000000400068f4 <fat16_get_next_cluster>:
400068f4: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
400068f8: f9000bfc     	str	x28, [sp, #0x10]
400068fc: 910003fd     	mov	x29, sp
40006900: a9024ff4     	stp	x20, x19, [sp, #0x20]
40006904: d10803ff     	sub	sp, sp, #0x200
40006908: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
4000690c: 12181c09     	and	w9, w0, #0xff00
40006910: d37f1c13     	ubfiz	x19, x0, #1, #8
40006914: b94e1908     	ldr	w8, [x8, #0xe18]
40006918: 910003e1     	mov	x1, sp
4000691c: 910003f4     	mov	x20, sp
40006920: 0b492108     	add	w8, w8, w9, lsr #8
40006924: aa0803e0     	mov	x0, x8
40006928: 97fffc45     	bl	0x40005a3c <virtio_blk_read_sector>
4000692c: 8b130288     	add	x8, x20, x19
40006930: 39400509     	ldrb	w9, [x8, #0x1]
40006934: 39400108     	ldrb	w8, [x8]
40006938: 2a092100     	orr	w0, w8, w9, lsl #8
4000693c: 910803ff     	add	sp, sp, #0x200
40006940: a9424ff4     	ldp	x20, x19, [sp, #0x20]
40006944: f9400bfc     	ldr	x28, [sp, #0x10]
40006948: a8c37bfd     	ldp	x29, x30, [sp], #0x30
4000694c: d65f03c0     	ret

0000000040006950 <fat16_read_file>:
40006950: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006954: a9016ffc     	stp	x28, x27, [sp, #0x10]
40006958: 910003fd     	mov	x29, sp
4000695c: a90267fa     	stp	x26, x25, [sp, #0x20]
40006960: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006964: a90457f6     	stp	x22, x21, [sp, #0x40]
40006968: a9054ff4     	stp	x20, x19, [sp, #0x50]
4000696c: d110c3ff     	sub	sp, sp, #0x430
40006970: aa0103f3     	mov	x19, x1
40006974: 910877e1     	add	x1, sp, #0x21d
40006978: aa0203f5     	mov	x21, x2
4000697c: 94000084     	bl	0x40006b8c <to_fat_name>
40006980: d0000234     	adrp	x20, 0x4004c000 <tx_buffers+0x722a>
40006984: b94e2288     	ldr	w8, [x20, #0xe20]
40006988: 34000788     	cbz	w8, 0x40006a78 <fat16_read_file+0x128>
4000698c: 2a1f03f6     	mov	w22, wzr
40006990: d0000237     	adrp	x23, 0x4004c000 <tx_buffers+0x722a>
40006994: 910077f8     	add	x24, sp, #0x1d
40006998: 14000005     	b	0x400069ac <fat16_read_file+0x5c>
4000699c: b94e2288     	ldr	w8, [x20, #0xe20]
400069a0: 110006d6     	add	w22, w22, #0x1
400069a4: 6b0802df     	cmp	w22, w8
400069a8: 54000682     	b.hs	0x40006a78 <fat16_read_file+0x128>
400069ac: b94e1ee8     	ldr	w8, [x23, #0xe1c]
400069b0: 910077e1     	add	x1, sp, #0x1d
400069b4: 0b160100     	add	w0, w8, w22
400069b8: 97fffc21     	bl	0x40005a3c <virtio_blk_read_sector>
400069bc: aa1f03f9     	mov	x25, xzr
400069c0: 14000004     	b	0x400069d0 <fat16_read_file+0x80>
400069c4: 91008339     	add	x25, x25, #0x20
400069c8: f108033f     	cmp	x25, #0x200
400069cc: 54fffe80     	b.eq	0x4000699c <fat16_read_file+0x4c>
400069d0: 38796b08     	ldrb	w8, [x24, x25]
400069d4: 7103951f     	cmp	w8, #0xe5
400069d8: 54ffff60     	b.eq	0x400069c4 <fat16_read_file+0x74>
400069dc: 340004e8     	cbz	w8, 0x40006a78 <fat16_read_file+0x128>
400069e0: 8b190308     	add	x8, x24, x25
400069e4: 39402d08     	ldrb	w8, [x8, #0xb]
400069e8: 7200111f     	tst	w8, #0x1f
400069ec: 54fffec1     	b.ne	0x400069c4 <fat16_read_file+0x74>
400069f0: 8b190300     	add	x0, x24, x25
400069f4: 910877e1     	add	x1, sp, #0x21d
400069f8: 52800162     	mov	w2, #0xb                // =11
400069fc: 97ffefff     	bl	0x400029f8 <kstrncmp>
40006a00: 35fffe20     	cbnz	w0, 0x400069c4 <fat16_read_file+0x74>
40006a04: 910077e8     	add	x8, sp, #0x1d
40006a08: 8b190108     	add	x8, x8, x25
40006a0c: aa0803e9     	mov	x9, x8
40006a10: 3841cd2a     	ldrb	w10, [x9, #0x1c]!
40006a14: 3940092b     	ldrb	w11, [x9, #0x2]
40006a18: 3940052c     	ldrb	w12, [x9, #0x1]
40006a1c: 39400d29     	ldrb	w9, [x9, #0x3]
40006a20: d370bd6b     	lsl	x11, x11, #16
40006a24: aa0c214a     	orr	x10, x10, x12, lsl #8
40006a28: aa096169     	orr	x9, x11, x9, lsl #24
40006a2c: aa0a0136     	orr	x22, x9, x10
40006a30: 34000a16     	cbz	w22, 0x40006b70 <fat16_read_file+0x220>
40006a34: 39406d09     	ldrb	w9, [x8, #0x1b]
40006a38: 39406908     	ldrb	w8, [x8, #0x1a]
40006a3c: 2a09210a     	orr	w10, w8, w9, lsl #8
40006a40: 529ffea9     	mov	w9, #0xfff5             // =65525
40006a44: 51000948     	sub	w8, w10, #0x2
40006a48: 6b09011f     	cmp	w8, w9
40006a4c: 540009a8     	b.hi	0x40006b80 <fat16_read_file+0x230>
40006a50: eb1502df     	cmp	x22, x21
40006a54: d10006b7     	sub	x23, x21, #0x1
40006a58: aa1f03f4     	mov	x20, xzr
40006a5c: 9a9532c8     	csel	x8, x22, x21, lo
40006a60: eb1702df     	cmp	x22, x23
40006a64: d000023b     	adrp	x27, 0x4004c000 <tx_buffers+0x722a>
40006a68: 9a9732d9     	csel	x25, x22, x23, lo
40006a6c: 5280401c     	mov	w28, #0x200             // =512
40006a70: f90007e8     	str	x8, [sp, #0x8]
40006a74: 1400001b     	b	0x40006ae0 <fat16_read_file+0x190>
40006a78: 12800014     	mov	w20, #-0x1              // =-1
40006a7c: 2a1403e0     	mov	w0, w20
40006a80: 9110c3ff     	add	sp, sp, #0x430
40006a84: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40006a88: a94457f6     	ldp	x22, x21, [sp, #0x40]
40006a8c: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40006a90: a94267fa     	ldp	x26, x25, [sp, #0x20]
40006a94: a9416ffc     	ldp	x28, x27, [sp, #0x10]
40006a98: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40006a9c: d65f03c0     	ret
40006aa0: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40006aa4: f9400be9     	ldr	x9, [sp, #0x10]
40006aa8: 9108a3e1     	add	x1, sp, #0x228
40006aac: b94e1908     	ldr	w8, [x8, #0xe18]
40006ab0: d37f1d35     	ubfiz	x21, x9, #1, #8
40006ab4: 0b492100     	add	w0, w8, w9, lsr #8
40006ab8: 97fffbe1     	bl	0x40005a3c <virtio_blk_read_sector>
40006abc: 9108a3e8     	add	x8, sp, #0x228
40006ac0: 8b150108     	add	x8, x8, x21
40006ac4: 39400509     	ldrb	w9, [x8, #0x1]
40006ac8: 39400108     	ldrb	w8, [x8]
40006acc: 2a09210a     	orr	w10, w8, w9, lsl #8
40006ad0: 529ffec9     	mov	w9, #0xfff6             // =65526
40006ad4: 51000948     	sub	w8, w10, #0x2
40006ad8: 6b09011f     	cmp	w8, w9
40006adc: 54000542     	b.hs	0x40006b84 <fat16_read_file+0x234>
40006ae0: f94007e8     	ldr	x8, [sp, #0x8]
40006ae4: eb08029f     	cmp	x20, x8
40006ae8: 540004e2     	b.hs	0x40006b84 <fat16_read_file+0x234>
40006aec: 39779768     	ldrb	w8, [x27, #0xde5]
40006af0: f9000bea     	str	x10, [sp, #0x10]
40006af4: 34fffd68     	cbz	w8, 0x40006aa0 <fat16_read_file+0x150>
40006af8: 51000949     	sub	w9, w10, #0x2
40006afc: 52800038     	mov	w24, #0x1               // =1
40006b00: 1b087d28     	mul	w8, w9, w8
40006b04: d0000229     	adrp	x9, 0x4004c000 <tx_buffers+0x722a>
40006b08: b94e2529     	ldr	w9, [x9, #0xe24]
40006b0c: 0b08013a     	add	w26, w9, w8
40006b10: 2a1a03e0     	mov	w0, w26
40006b14: 910077e1     	add	x1, sp, #0x1d
40006b18: 97fffbc9     	bl	0x40005a3c <virtio_blk_read_sector>
40006b1c: 91080288     	add	x8, x20, #0x200
40006b20: cb1402c9     	sub	x9, x22, x20
40006b24: cb1402ea     	sub	x10, x23, x20
40006b28: eb16011f     	cmp	x8, x22
40006b2c: 8b140260     	add	x0, x19, x20
40006b30: 910077e1     	add	x1, sp, #0x1d
40006b34: 9a9c8128     	csel	x8, x9, x28, hi
40006b38: 8b140109     	add	x9, x8, x20
40006b3c: eb17013f     	cmp	x9, x23
40006b40: 9a888155     	csel	x21, x10, x8, hi
40006b44: aa1503e2     	mov	x2, x21
40006b48: 97ffeffe     	bl	0x40002b40 <memcpy>
40006b4c: 8b1402b4     	add	x20, x21, x20
40006b50: eb19029f     	cmp	x20, x25
40006b54: 54fffa62     	b.hs	0x40006aa0 <fat16_read_file+0x150>
40006b58: 39779768     	ldrb	w8, [x27, #0xde5]
40006b5c: 1100075a     	add	w26, w26, #0x1
40006b60: eb08031f     	cmp	x24, x8
40006b64: 91000718     	add	x24, x24, #0x1
40006b68: 54fffd43     	b.lo	0x40006b10 <fat16_read_file+0x1c0>
40006b6c: 17ffffcd     	b	0x40006aa0 <fat16_read_file+0x150>
40006b70: 2a1f03f4     	mov	w20, wzr
40006b74: b4fff855     	cbz	x21, 0x40006a7c <fat16_read_file+0x12c>
40006b78: 3900027f     	strb	wzr, [x19]
40006b7c: 17ffffc0     	b	0x40006a7c <fat16_read_file+0x12c>
40006b80: aa1f03f4     	mov	x20, xzr
40006b84: 38346a7f     	strb	wzr, [x19, x20]
40006b88: 17ffffbd     	b	0x40006a7c <fat16_read_file+0x12c>

0000000040006b8c <to_fat_name>:
40006b8c: 52800408     	mov	w8, #0x20               // =32
40006b90: 39000028     	strb	w8, [x1]
40006b94: 39000428     	strb	w8, [x1, #0x1]
40006b98: 39000828     	strb	w8, [x1, #0x2]
40006b9c: 39000c28     	strb	w8, [x1, #0x3]
40006ba0: 39001028     	strb	w8, [x1, #0x4]
40006ba4: 39001428     	strb	w8, [x1, #0x5]
40006ba8: 39001828     	strb	w8, [x1, #0x6]
40006bac: 39001c28     	strb	w8, [x1, #0x7]
40006bb0: 39002028     	strb	w8, [x1, #0x8]
40006bb4: 39002428     	strb	w8, [x1, #0x9]
40006bb8: 39002828     	strb	w8, [x1, #0xa]
40006bbc: 39400009     	ldrb	w9, [x0]
40006bc0: 340002a9     	cbz	w9, 0x40006c14 <to_fat_name+0x88>
40006bc4: aa1f03e8     	mov	x8, xzr
40006bc8: 9100040a     	add	x10, x0, #0x1
40006bcc: 12001d2b     	and	w11, w9, #0xff
40006bd0: 7100b97f     	cmp	w11, #0x2e
40006bd4: 540001c0     	b.eq	0x40006c0c <to_fat_name+0x80>
40006bd8: f1001d1f     	cmp	x8, #0x7
40006bdc: 54000188     	b.hi	0x40006c0c <to_fat_name+0x80>
40006be0: 5101852b     	sub	w11, w9, #0x61
40006be4: 5100812c     	sub	w12, w9, #0x20
40006be8: 12001d6b     	and	w11, w11, #0xff
40006bec: 7100697f     	cmp	w11, #0x1a
40006bf0: 9100050b     	add	x11, x8, #0x1
40006bf4: 1a893189     	csel	w9, w12, w9, lo
40006bf8: 38286829     	strb	w9, [x1, x8]
40006bfc: 38686949     	ldrb	w9, [x10, x8]
40006c00: aa0b03e8     	mov	x8, x11
40006c04: 35fffe49     	cbnz	w9, 0x40006bcc <to_fat_name+0x40>
40006c08: 2a0b03e8     	mov	w8, w11
40006c0c: 2a0803e9     	mov	w9, w8
40006c10: 14000002     	b	0x40006c18 <to_fat_name+0x8c>
40006c14: aa1f03e9     	mov	x9, xzr
40006c18: 8b000128     	add	x8, x9, x0
40006c1c: 91000d08     	add	x8, x8, #0x3
40006c20: 3869680a     	ldrb	w10, [x0, x9]
40006c24: 340000ea     	cbz	w10, 0x40006c40 <to_fat_name+0xb4>
40006c28: 7100b95f     	cmp	w10, #0x2e
40006c2c: 540000c0     	b.eq	0x40006c44 <to_fat_name+0xb8>
40006c30: 91000529     	add	x9, x9, #0x1
40006c34: 91000508     	add	x8, x8, #0x1
40006c38: 3869680a     	ldrb	w10, [x0, x9]
40006c3c: 35ffff6a     	cbnz	w10, 0x40006c28 <to_fat_name+0x9c>
40006c40: d65f03c0     	ret
40006c44: 11000529     	add	w9, w9, #0x1
40006c48: 38694809     	ldrb	w9, [x0, w9, uxtw]
40006c4c: 34ffffa9     	cbz	w9, 0x40006c40 <to_fat_name+0xb4>
40006c50: 5101852a     	sub	w10, w9, #0x61
40006c54: 5100812b     	sub	w11, w9, #0x20
40006c58: 7100695f     	cmp	w10, #0x1a
40006c5c: 1a893169     	csel	w9, w11, w9, lo
40006c60: 39002029     	strb	w9, [x1, #0x8]
40006c64: 385ff109     	ldurb	w9, [x8, #-0x1]
40006c68: 34fffec9     	cbz	w9, 0x40006c40 <to_fat_name+0xb4>
40006c6c: 5101852a     	sub	w10, w9, #0x61
40006c70: 5100812b     	sub	w11, w9, #0x20
40006c74: 7100695f     	cmp	w10, #0x1a
40006c78: 1a893169     	csel	w9, w11, w9, lo
40006c7c: 39002429     	strb	w9, [x1, #0x9]
40006c80: 39400108     	ldrb	w8, [x8]
40006c84: 34fffde8     	cbz	w8, 0x40006c40 <to_fat_name+0xb4>
40006c88: 51018509     	sub	w9, w8, #0x61
40006c8c: 5100810a     	sub	w10, w8, #0x20
40006c90: 7100693f     	cmp	w9, #0x1a
40006c94: 1a883148     	csel	w8, w10, w8, lo
40006c98: 39002828     	strb	w8, [x1, #0xa]
40006c9c: d65f03c0     	ret

0000000040006ca0 <fat16_set_fat_entry>:
40006ca0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
40006ca4: f9000bfc     	str	x28, [sp, #0x10]
40006ca8: 910003fd     	mov	x29, sp
40006cac: a90257f6     	stp	x22, x21, [sp, #0x20]
40006cb0: a9034ff4     	stp	x20, x19, [sp, #0x30]
40006cb4: d10803ff     	sub	sp, sp, #0x200
40006cb8: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40006cbc: 12181c09     	and	w9, w0, #0xff00
40006cc0: d37f1c15     	ubfiz	x21, x0, #1, #8
40006cc4: b94e1908     	ldr	w8, [x8, #0xe18]
40006cc8: 2a0103f4     	mov	w20, w1
40006ccc: 910003e1     	mov	x1, sp
40006cd0: 910003f6     	mov	x22, sp
40006cd4: 0b492113     	add	w19, w8, w9, lsr #8
40006cd8: aa1303e0     	mov	x0, x19
40006cdc: 97fffb58     	bl	0x40005a3c <virtio_blk_read_sector>
40006ce0: 53087e88     	lsr	w8, w20, #8
40006ce4: 8b1502c9     	add	x9, x22, x21
40006ce8: 910003e1     	mov	x1, sp
40006cec: aa1303e0     	mov	x0, x19
40006cf0: 39000134     	strb	w20, [x9]
40006cf4: 39000528     	strb	w8, [x9, #0x1]
40006cf8: 97fffbf1     	bl	0x40005cbc <virtio_blk_write_sector>
40006cfc: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40006d00: 3977a108     	ldrb	w8, [x8, #0xde8]
40006d04: 7100091f     	cmp	w8, #0x2
40006d08: 540001c3     	b.lo	0x40006d40 <fat16_set_fat_entry+0xa0>
40006d0c: 52800034     	mov	w20, #0x1               // =1
40006d10: d0000235     	adrp	x21, 0x4004c000 <tx_buffers+0x722a>
40006d14: 9137a2b5     	add	x21, x21, #0xde8
40006d18: 39401ea8     	ldrb	w8, [x21, #0x7]
40006d1c: 39401aa9     	ldrb	w9, [x21, #0x6]
40006d20: 910003e1     	mov	x1, sp
40006d24: 2a082128     	orr	w8, w9, w8, lsl #8
40006d28: 1b084e80     	madd	w0, w20, w8, w19
40006d2c: 97fffbe4     	bl	0x40005cbc <virtio_blk_write_sector>
40006d30: 394002a8     	ldrb	w8, [x21]
40006d34: 11000694     	add	w20, w20, #0x1
40006d38: 6b08029f     	cmp	w20, w8
40006d3c: 54fffee3     	b.lo	0x40006d18 <fat16_set_fat_entry+0x78>
40006d40: 910803ff     	add	sp, sp, #0x200
40006d44: a9434ff4     	ldp	x20, x19, [sp, #0x30]
40006d48: f9400bfc     	ldr	x28, [sp, #0x10]
40006d4c: a94257f6     	ldp	x22, x21, [sp, #0x20]
40006d50: a8c47bfd     	ldp	x29, x30, [sp], #0x40
40006d54: d65f03c0     	ret

0000000040006d58 <fat16_allocate_cluster>:
40006d58: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
40006d5c: f9000bfc     	str	x28, [sp, #0x10]
40006d60: 910003fd     	mov	x29, sp
40006d64: a9025ff8     	stp	x24, x23, [sp, #0x20]
40006d68: a90357f6     	stp	x22, x21, [sp, #0x30]
40006d6c: a9044ff4     	stp	x20, x19, [sp, #0x40]
40006d70: d10803ff     	sub	sp, sp, #0x200
40006d74: d0000236     	adrp	x22, 0x4004c000 <tx_buffers+0x722a>
40006d78: 9137bad6     	add	x22, x22, #0xdee
40006d7c: 394006c8     	ldrb	w8, [x22, #0x1]
40006d80: 394002c9     	ldrb	w9, [x22]
40006d84: 2a082128     	orr	w8, w9, w8, lsl #8
40006d88: 340006e8     	cbz	w8, 0x40006e64 <fat16_allocate_cluster+0x10c>
40006d8c: aa1f03f7     	mov	x23, xzr
40006d90: aa1f03f4     	mov	x20, xzr
40006d94: d0000235     	adrp	x21, 0x4004c000 <tx_buffers+0x722a>
40006d98: 910003f8     	mov	x24, sp
40006d9c: 14000008     	b	0x40006dbc <fat16_allocate_cluster+0x64>
40006da0: 394006c8     	ldrb	w8, [x22, #0x1]
40006da4: 394002c9     	ldrb	w9, [x22]
40006da8: 91000694     	add	x20, x20, #0x1
40006dac: 910402f7     	add	x23, x23, #0x100
40006db0: aa082128     	orr	x8, x9, x8, lsl #8
40006db4: eb08029f     	cmp	x20, x8
40006db8: 54000562     	b.hs	0x40006e64 <fat16_allocate_cluster+0x10c>
40006dbc: b94e1aa8     	ldr	w8, [x21, #0xe18]
40006dc0: 910003e1     	mov	x1, sp
40006dc4: 8b080280     	add	x0, x20, x8
40006dc8: 97fffb1d     	bl	0x40005a3c <virtio_blk_read_sector>
40006dcc: aa1f03e8     	mov	x8, xzr
40006dd0: aa1703f3     	mov	x19, x23
40006dd4: 14000005     	b	0x40006de8 <fat16_allocate_cluster+0x90>
40006dd8: 91000908     	add	x8, x8, #0x2
40006ddc: 91000673     	add	x19, x19, #0x1
40006de0: f108011f     	cmp	x8, #0x200
40006de4: 54fffde0     	b.eq	0x40006da0 <fat16_allocate_cluster+0x48>
40006de8: f27f3a7f     	tst	x19, #0xfffe
40006dec: 54ffff60     	b.eq	0x40006dd8 <fat16_allocate_cluster+0x80>
40006df0: 78686b09     	ldrh	w9, [x24, x8]
40006df4: 35ffff29     	cbnz	w9, 0x40006dd8 <fat16_allocate_cluster+0x80>
40006df8: b94e1aa9     	ldr	w9, [x21, #0xe18]
40006dfc: 910003ea     	mov	x10, sp
40006e00: 910003e1     	mov	x1, sp
40006e04: 529fffeb     	mov	w11, #0xffff            // =65535
40006e08: 7828694b     	strh	w11, [x10, x8]
40006e0c: 0b140120     	add	w0, w9, w20
40006e10: 97fffbab     	bl	0x40005cbc <virtio_blk_write_sector>
40006e14: d0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40006e18: 3977a108     	ldrb	w8, [x8, #0xde8]
40006e1c: 7100091f     	cmp	w8, #0x2
40006e20: 54000243     	b.lo	0x40006e68 <fat16_allocate_cluster+0x110>
40006e24: 52800036     	mov	w22, #0x1               // =1
40006e28: d0000237     	adrp	x23, 0x4004c000 <tx_buffers+0x722a>
40006e2c: 9137a2f7     	add	x23, x23, #0xde8
40006e30: 39401ee8     	ldrb	w8, [x23, #0x7]
40006e34: 39401ae9     	ldrb	w9, [x23, #0x6]
40006e38: 910003e1     	mov	x1, sp
40006e3c: b94e1aaa     	ldr	w10, [x21, #0xe18]
40006e40: 2a082128     	orr	w8, w9, w8, lsl #8
40006e44: 0b140149     	add	w9, w10, w20
40006e48: 1b0826c0     	madd	w0, w22, w8, w9
40006e4c: 97fffb9c     	bl	0x40005cbc <virtio_blk_write_sector>
40006e50: 394002e8     	ldrb	w8, [x23]
40006e54: 110006d6     	add	w22, w22, #0x1
40006e58: 6b0802df     	cmp	w22, w8
40006e5c: 54fffea3     	b.lo	0x40006e30 <fat16_allocate_cluster+0xd8>
40006e60: 14000002     	b	0x40006e68 <fat16_allocate_cluster+0x110>
40006e64: 2a1f03f3     	mov	w19, wzr
40006e68: 2a1303e0     	mov	w0, w19
40006e6c: 910803ff     	add	sp, sp, #0x200
40006e70: a9444ff4     	ldp	x20, x19, [sp, #0x40]
40006e74: f9400bfc     	ldr	x28, [sp, #0x10]
40006e78: a94357f6     	ldp	x22, x21, [sp, #0x30]
40006e7c: a9425ff8     	ldp	x24, x23, [sp, #0x20]
40006e80: a8c57bfd     	ldp	x29, x30, [sp], #0x50
40006e84: d65f03c0     	ret

0000000040006e88 <fat16_write_file>:
40006e88: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40006e8c: a9016ffc     	stp	x28, x27, [sp, #0x10]
40006e90: 910003fd     	mov	x29, sp
40006e94: a90267fa     	stp	x26, x25, [sp, #0x20]
40006e98: a9035ff8     	stp	x24, x23, [sp, #0x30]
40006e9c: a90457f6     	stp	x22, x21, [sp, #0x40]
40006ea0: a9054ff4     	stp	x20, x19, [sp, #0x50]
40006ea4: d11083ff     	sub	sp, sp, #0x420
40006ea8: aa0103f4     	mov	x20, x1
40006eac: 910837e1     	add	x1, sp, #0x20d
40006eb0: aa0203f3     	mov	x19, x2
40006eb4: 97ffff36     	bl	0x40006b8c <to_fat_name>
40006eb8: d0000236     	adrp	x22, 0x4004c000 <tx_buffers+0x722a>
40006ebc: b94e22c8     	ldr	w8, [x22, #0xe20]
40006ec0: 34000d48     	cbz	w8, 0x40007068 <fat16_write_file+0x1e0>
40006ec4: aa1f03f5     	mov	x21, xzr
40006ec8: 2a1f03f8     	mov	w24, wzr
40006ecc: 2a1f03f7     	mov	w23, wzr
40006ed0: d0000239     	adrp	x25, 0x4004c000 <tx_buffers+0x722a>
40006ed4: 910033fa     	add	x26, sp, #0xc
40006ed8: 1400000b     	b	0x40006f04 <fat16_write_file+0x7c>
40006edc: b40000d5     	cbz	x21, 0x40006ef4 <fat16_write_file+0x6c>
40006ee0: 910837e1     	add	x1, sp, #0x20d
40006ee4: aa1503e0     	mov	x0, x21
40006ee8: 52800162     	mov	w2, #0xb                // =11
40006eec: 97ffeec3     	bl	0x400029f8 <kstrncmp>
40006ef0: 34000480     	cbz	w0, 0x40006f80 <fat16_write_file+0xf8>
40006ef4: b94e22c8     	ldr	w8, [x22, #0xe20]
40006ef8: 110006f7     	add	w23, w23, #0x1
40006efc: 6b0802ff     	cmp	w23, w8
40006f00: 540003e2     	b.hs	0x40006f7c <fat16_write_file+0xf4>
40006f04: b94e1f28     	ldr	w8, [x25, #0xe1c]
40006f08: 910033e1     	add	x1, sp, #0xc
40006f0c: 0b170100     	add	w0, w8, w23
40006f10: 97fffacb     	bl	0x40005a3c <virtio_blk_read_sector>
40006f14: aa1f03fb     	mov	x27, xzr
40006f18: 14000008     	b	0x40006f38 <fat16_write_file+0xb0>
40006f1c: 910837e1     	add	x1, sp, #0x20d
40006f20: 52800162     	mov	w2, #0xb                // =11
40006f24: 97ffeeb5     	bl	0x400029f8 <kstrncmp>
40006f28: 340001c0     	cbz	w0, 0x40006f60 <fat16_write_file+0xd8>
40006f2c: 9100837b     	add	x27, x27, #0x20
40006f30: f108037f     	cmp	x27, #0x200
40006f34: 54fffd40     	b.eq	0x40006edc <fat16_write_file+0x54>
40006f38: 8b1b0340     	add	x0, x26, x27
40006f3c: 39400008     	ldrb	w8, [x0]
40006f40: 7103951f     	cmp	w8, #0xe5
40006f44: 7a401904     	ccmp	w8, #0x0, #0x4, ne
40006f48: 54fffea1     	b.ne	0x40006f1c <fat16_write_file+0x94>
40006f4c: b5ffff15     	cbnz	x21, 0x40006f2c <fat16_write_file+0xa4>
40006f50: b94e1f28     	ldr	w8, [x25, #0xe1c]
40006f54: aa0003f5     	mov	x21, x0
40006f58: 0b170118     	add	w24, w8, w23
40006f5c: 17fffff4     	b	0x40006f2c <fat16_write_file+0xa4>
40006f60: 8b1b0348     	add	x8, x26, x27
40006f64: 39402d09     	ldrb	w9, [x8, #0xb]
40006f68: 3727fe29     	tbnz	w9, #0x4, 0x40006f2c <fat16_write_file+0xa4>
40006f6c: b94e1f29     	ldr	w9, [x25, #0xe1c]
40006f70: aa0803f5     	mov	x21, x8
40006f74: 0b170138     	add	w24, w9, w23
40006f78: 17ffffda     	b	0x40006ee0 <fat16_write_file+0x58>
40006f7c: b4000775     	cbz	x21, 0x40007068 <fat16_write_file+0x1e0>
40006f80: 910837e1     	add	x1, sp, #0x20d
40006f84: aa1503e0     	mov	x0, x21
40006f88: 52800162     	mov	w2, #0xb                // =11
40006f8c: b90007f8     	str	w24, [sp, #0x4]
40006f90: 97ffee9a     	bl	0x400029f8 <kstrncmp>
40006f94: d000023b     	adrp	x27, 0x4004c000 <tx_buffers+0x722a>
40006f98: 9137a37b     	add	x27, x27, #0xde8
40006f9c: 350006a0     	cbnz	w0, 0x40007070 <fat16_write_file+0x1e8>
40006fa0: 39406ea8     	ldrb	w8, [x21, #0x1b]
40006fa4: 39406aa9     	ldrb	w9, [x21, #0x1a]
40006fa8: 529ffeaa     	mov	w10, #0xfff5            // =65525
40006fac: 2a082128     	orr	w8, w9, w8, lsl #8
40006fb0: 51000909     	sub	w9, w8, #0x2
40006fb4: 6b0a013f     	cmp	w9, w10
40006fb8: 540005c8     	b.hi	0x40007070 <fat16_write_file+0x1e8>
40006fbc: 910863f6     	add	x22, sp, #0x218
40006fc0: 529ffed7     	mov	w23, #0xfff6            // =65526
40006fc4: 14000005     	b	0x40006fd8 <fat16_write_file+0x150>
40006fc8: 2a182328     	orr	w8, w25, w24, lsl #8
40006fcc: 51000909     	sub	w9, w8, #0x2
40006fd0: 6b17013f     	cmp	w9, w23
40006fd4: 540004e2     	b.hs	0x40007070 <fat16_write_file+0x1e8>
40006fd8: d0000239     	adrp	x25, 0x4004c000 <tx_buffers+0x722a>
40006fdc: 53087d15     	lsr	w21, w8, #8
40006fe0: 910863e1     	add	x1, sp, #0x218
40006fe4: b94e1b29     	ldr	w9, [x25, #0xe18]
40006fe8: d37f1d18     	ubfiz	x24, x8, #1, #8
40006fec: 0b150120     	add	w0, w9, w21
40006ff0: 97fffa93     	bl	0x40005a3c <virtio_blk_read_sector>
40006ff4: b94e1b28     	ldr	w8, [x25, #0xe18]
40006ff8: 8b1802da     	add	x26, x22, x24
40006ffc: 910863e1     	add	x1, sp, #0x218
40007000: 39400758     	ldrb	w24, [x26, #0x1]
40007004: 39400359     	ldrb	w25, [x26]
40007008: 0b150115     	add	w21, w8, w21
4000700c: aa1503e0     	mov	x0, x21
40007010: 97fffa8b     	bl	0x40005a3c <virtio_blk_read_sector>
40007014: 910863e1     	add	x1, sp, #0x218
40007018: aa1503e0     	mov	x0, x21
4000701c: 3900075f     	strb	wzr, [x26, #0x1]
40007020: 3900035f     	strb	wzr, [x26]
40007024: 97fffb26     	bl	0x40005cbc <virtio_blk_write_sector>
40007028: b0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
4000702c: 3977a108     	ldrb	w8, [x8, #0xde8]
40007030: 7100091f     	cmp	w8, #0x2
40007034: 54fffca3     	b.lo	0x40006fc8 <fat16_write_file+0x140>
40007038: 5280003a     	mov	w26, #0x1               // =1
4000703c: 39401f68     	ldrb	w8, [x27, #0x7]
40007040: 39401b69     	ldrb	w9, [x27, #0x6]
40007044: 910863e1     	add	x1, sp, #0x218
40007048: 2a082128     	orr	w8, w9, w8, lsl #8
4000704c: 1b085740     	madd	w0, w26, w8, w21
40007050: 97fffb1b     	bl	0x40005cbc <virtio_blk_write_sector>
40007054: 39400368     	ldrb	w8, [x27]
40007058: 1100075a     	add	w26, w26, #0x1
4000705c: 6b08035f     	cmp	w26, w8
40007060: 54fffee3     	b.lo	0x4000703c <fat16_write_file+0x1b4>
40007064: 17ffffd9     	b	0x40006fc8 <fat16_write_file+0x140>
40007068: 12800013     	mov	w19, #-0x1              // =-1
4000706c: 14000131     	b	0x40007530 <fat16_write_file+0x6a8>
40007070: 2a1f03f6     	mov	w22, wzr
40007074: 2a1f03f5     	mov	w21, wzr
40007078: aa1f03fc     	mov	x28, xzr
4000707c: b000023a     	adrp	x26, 0x4004c000 <tx_buffers+0x722a>
40007080: 52804019     	mov	w25, #0x200             // =512
40007084: 14000003     	b	0x40007090 <fat16_write_file+0x208>
40007088: b9400bf6     	ldr	w22, [sp, #0x8]
4000708c: b4000a13     	cbz	x19, 0x400071cc <fat16_write_file+0x344>
40007090: 72003edf     	tst	w22, #0xffff
40007094: 2a1503f8     	mov	w24, w21
40007098: fa400a60     	ccmp	x19, #0x0, #0x0, eq
4000709c: 1a9f17e8     	cset	w8, eq
400070a0: eb13039f     	cmp	x28, x19
400070a4: 54000043     	b.lo	0x400070ac <fat16_write_file+0x224>
400070a8: 34000928     	cbz	w8, 0x400071cc <fat16_write_file+0x344>
400070ac: 97ffff2b     	bl	0x40006d58 <fat16_allocate_cluster>
400070b0: 72003c17     	ands	w23, w0, #0xffff
400070b4: 540020e0     	b.eq	0x400074d0 <fat16_write_file+0x648>
400070b8: 72003edf     	tst	w22, #0xffff
400070bc: 2a0003f5     	mov	w21, w0
400070c0: 1a960016     	csel	w22, w0, w22, eq
400070c4: 72003f1f     	tst	w24, #0xffff
400070c8: b9000bf6     	str	w22, [sp, #0x8]
400070cc: 54000400     	b.eq	0x4000714c <fat16_write_file+0x2c4>
400070d0: b0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
400070d4: 12181f09     	and	w9, w24, #0xff00
400070d8: 910863e1     	add	x1, sp, #0x218
400070dc: b94e1908     	ldr	w8, [x8, #0xe18]
400070e0: d37f1f18     	ubfiz	x24, x24, #1, #8
400070e4: 0b492116     	add	w22, w8, w9, lsr #8
400070e8: aa1603e0     	mov	x0, x22
400070ec: 97fffa54     	bl	0x40005a3c <virtio_blk_read_sector>
400070f0: 53087ea8     	lsr	w8, w21, #8
400070f4: 910863e9     	add	x9, sp, #0x218
400070f8: 910863e1     	add	x1, sp, #0x218
400070fc: 8b180129     	add	x9, x9, x24
40007100: aa1603e0     	mov	x0, x22
40007104: 39000528     	strb	w8, [x9, #0x1]
40007108: 39000135     	strb	w21, [x9]
4000710c: 97fffaec     	bl	0x40005cbc <virtio_blk_write_sector>
40007110: b0000228     	adrp	x8, 0x4004c000 <tx_buffers+0x722a>
40007114: 3977a108     	ldrb	w8, [x8, #0xde8]
40007118: 7100091f     	cmp	w8, #0x2
4000711c: 54000183     	b.lo	0x4000714c <fat16_write_file+0x2c4>
40007120: 52800038     	mov	w24, #0x1               // =1
40007124: 39401f68     	ldrb	w8, [x27, #0x7]
40007128: 39401b69     	ldrb	w9, [x27, #0x6]
4000712c: 910863e1     	add	x1, sp, #0x218
40007130: 2a082128     	orr	w8, w9, w8, lsl #8
40007134: 1b085b00     	madd	w0, w24, w8, w22
40007138: 97fffae1     	bl	0x40005cbc <virtio_blk_write_sector>
4000713c: 39400368     	ldrb	w8, [x27]
40007140: 11000718     	add	w24, w24, #0x1
40007144: 6b08031f     	cmp	w24, w8
40007148: 54fffee3     	b.lo	0x40007124 <fat16_write_file+0x29c>
4000714c: 39779748     	ldrb	w8, [x26, #0xde5]
40007150: 34fff9c8     	cbz	w8, 0x40007088 <fat16_write_file+0x200>
40007154: 51000ae9     	sub	w9, w23, #0x2
40007158: 52800038     	mov	w24, #0x1               // =1
4000715c: 1b087d28     	mul	w8, w9, w8
40007160: b0000229     	adrp	x9, 0x4004c000 <tx_buffers+0x722a>
40007164: b94e2529     	ldr	w9, [x9, #0xe24]
40007168: 0b080137     	add	w23, w9, w8
4000716c: 91080388     	add	x8, x28, #0x200
40007170: cb1c0269     	sub	x9, x19, x28
40007174: 910033e0     	add	x0, sp, #0xc
40007178: eb13011f     	cmp	x8, x19
4000717c: 2a1f03e1     	mov	w1, wzr
40007180: 52804002     	mov	w2, #0x200              // =512
40007184: 9a998136     	csel	x22, x9, x25, hi
40007188: 97ffee58     	bl	0x40002ae8 <memset>
4000718c: 910033e0     	add	x0, sp, #0xc
40007190: 8b1c0281     	add	x1, x20, x28
40007194: aa1603e2     	mov	x2, x22
40007198: 97ffee6a     	bl	0x40002b40 <memcpy>
4000719c: 2a1703e0     	mov	w0, w23
400071a0: 910033e1     	add	x1, sp, #0xc
400071a4: 97fffac6     	bl	0x40005cbc <virtio_blk_write_sector>
400071a8: 8b1c02dc     	add	x28, x22, x28
400071ac: eb13039f     	cmp	x28, x19
400071b0: 54fff6c2     	b.hs	0x40007088 <fat16_write_file+0x200>
400071b4: 39779748     	ldrb	w8, [x26, #0xde5]
400071b8: 110006f7     	add	w23, w23, #0x1
400071bc: eb08031f     	cmp	x24, x8
400071c0: 91000718     	add	x24, x24, #0x1
400071c4: 54fffd43     	b.lo	0x4000716c <fat16_write_file+0x2e4>
400071c8: 17ffffb0     	b	0x40007088 <fat16_write_file+0x200>
400071cc: b94007e8     	ldr	w8, [sp, #0x4]
400071d0: 910033e1     	add	x1, sp, #0xc
400071d4: 910033f5     	add	x21, sp, #0xc
400071d8: 2a0803f4     	mov	w20, w8
400071dc: aa1403e0     	mov	x0, x20
400071e0: 97fffa17     	bl	0x40005a3c <virtio_blk_read_sector>
400071e4: 910033e0     	add	x0, sp, #0xc
400071e8: 910837e1     	add	x1, sp, #0x20d
400071ec: 52800162     	mov	w2, #0xb                // =11
400071f0: 97ffee02     	bl	0x400029f8 <kstrncmp>
400071f4: 34001740     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
400071f8: 394033e8     	ldrb	w8, [sp, #0xc]
400071fc: 910033f5     	add	x21, sp, #0xc
40007200: 7103951f     	cmp	w8, #0xe5
40007204: 540016c0     	b.eq	0x400074dc <fat16_write_file+0x654>
40007208: 340016a8     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
4000720c: 910033e8     	add	x8, sp, #0xc
40007210: 910837e1     	add	x1, sp, #0x20d
40007214: 52800162     	mov	w2, #0xb                // =11
40007218: 91008115     	add	x21, x8, #0x20
4000721c: aa1503e0     	mov	x0, x21
40007220: 97ffedf6     	bl	0x400029f8 <kstrncmp>
40007224: 340015c0     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
40007228: 3940b3e8     	ldrb	w8, [sp, #0x2c]
4000722c: 34001588     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
40007230: 7103951f     	cmp	w8, #0xe5
40007234: 54001540     	b.eq	0x400074dc <fat16_write_file+0x654>
40007238: 910033e8     	add	x8, sp, #0xc
4000723c: 910837e1     	add	x1, sp, #0x20d
40007240: 52800162     	mov	w2, #0xb                // =11
40007244: 91010115     	add	x21, x8, #0x40
40007248: aa1503e0     	mov	x0, x21
4000724c: 97ffedeb     	bl	0x400029f8 <kstrncmp>
40007250: 34001460     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
40007254: 394133e8     	ldrb	w8, [sp, #0x4c]
40007258: 34001428     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
4000725c: 7103951f     	cmp	w8, #0xe5
40007260: 540013e0     	b.eq	0x400074dc <fat16_write_file+0x654>
40007264: 910033e8     	add	x8, sp, #0xc
40007268: 910837e1     	add	x1, sp, #0x20d
4000726c: 52800162     	mov	w2, #0xb                // =11
40007270: 91018115     	add	x21, x8, #0x60
40007274: aa1503e0     	mov	x0, x21
40007278: 97ffede0     	bl	0x400029f8 <kstrncmp>
4000727c: 34001300     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
40007280: 3941b3e8     	ldrb	w8, [sp, #0x6c]
40007284: 340012c8     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
40007288: 7103951f     	cmp	w8, #0xe5
4000728c: 54001280     	b.eq	0x400074dc <fat16_write_file+0x654>
40007290: 910033e8     	add	x8, sp, #0xc
40007294: 910837e1     	add	x1, sp, #0x20d
40007298: 52800162     	mov	w2, #0xb                // =11
4000729c: 91020115     	add	x21, x8, #0x80
400072a0: aa1503e0     	mov	x0, x21
400072a4: 97ffedd5     	bl	0x400029f8 <kstrncmp>
400072a8: 340011a0     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
400072ac: 394233e8     	ldrb	w8, [sp, #0x8c]
400072b0: 34001168     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
400072b4: 7103951f     	cmp	w8, #0xe5
400072b8: 54001120     	b.eq	0x400074dc <fat16_write_file+0x654>
400072bc: 910033e8     	add	x8, sp, #0xc
400072c0: 910837e1     	add	x1, sp, #0x20d
400072c4: 52800162     	mov	w2, #0xb                // =11
400072c8: 91028115     	add	x21, x8, #0xa0
400072cc: aa1503e0     	mov	x0, x21
400072d0: 97ffedca     	bl	0x400029f8 <kstrncmp>
400072d4: 34001040     	cbz	w0, 0x400074dc <fat16_write_file+0x654>
400072d8: 3942b3e8     	ldrb	w8, [sp, #0xac]
400072dc: 34001008     	cbz	w8, 0x400074dc <fat16_write_file+0x654>
400072e0: 7103951f     	cmp	w8, #0xe5
400072e4: 54000fc0     	b.eq	0x400074dc <fat16_write_file+0x654>
400072e8: 910033e8     	add	x8, sp, #0xc
400072ec: 910837e1     	add	x1, sp, #0x20d
400072f0: 52800162     	mov	w2, #0xb                // =11
400072f4: 91030115     	add	x21, x8, #0xc0
400072f8: 2a1603f7     	mov	w23, w22
400072fc: aa1503e0     	mov	x0, x21
40007300: 97ffedbe     	bl	0x400029f8 <kstrncmp>
40007304: 34000ea0     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007308: 394333e8     	ldrb	w8, [sp, #0xcc]
4000730c: 34000e68     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007310: 7103951f     	cmp	w8, #0xe5
40007314: 2a1703f6     	mov	w22, w23
40007318: 54000e20     	b.eq	0x400074dc <fat16_write_file+0x654>
4000731c: 910033e8     	add	x8, sp, #0xc
40007320: 910837e1     	add	x1, sp, #0x20d
40007324: 52800162     	mov	w2, #0xb                // =11
40007328: 91038115     	add	x21, x8, #0xe0
4000732c: aa1503e0     	mov	x0, x21
40007330: 97ffedb2     	bl	0x400029f8 <kstrncmp>
40007334: 34000d20     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007338: 3943b3e8     	ldrb	w8, [sp, #0xec]
4000733c: 34000ce8     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007340: 7103951f     	cmp	w8, #0xe5
40007344: 2a1703f6     	mov	w22, w23
40007348: 54000ca0     	b.eq	0x400074dc <fat16_write_file+0x654>
4000734c: 910033e8     	add	x8, sp, #0xc
40007350: 910837e1     	add	x1, sp, #0x20d
40007354: 52800162     	mov	w2, #0xb                // =11
40007358: 91040115     	add	x21, x8, #0x100
4000735c: aa1503e0     	mov	x0, x21
40007360: 97ffeda6     	bl	0x400029f8 <kstrncmp>
40007364: 34000ba0     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007368: 394433e8     	ldrb	w8, [sp, #0x10c]
4000736c: 34000b68     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007370: 7103951f     	cmp	w8, #0xe5
40007374: 2a1703f6     	mov	w22, w23
40007378: 54000b20     	b.eq	0x400074dc <fat16_write_file+0x654>
4000737c: 910033e8     	add	x8, sp, #0xc
40007380: 910837e1     	add	x1, sp, #0x20d
40007384: 52800162     	mov	w2, #0xb                // =11
40007388: 91048115     	add	x21, x8, #0x120
4000738c: aa1503e0     	mov	x0, x21
40007390: 97ffed9a     	bl	0x400029f8 <kstrncmp>
40007394: 34000a20     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007398: 3944b3e8     	ldrb	w8, [sp, #0x12c]
4000739c: 340009e8     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
400073a0: 7103951f     	cmp	w8, #0xe5
400073a4: 2a1703f6     	mov	w22, w23
400073a8: 540009a0     	b.eq	0x400074dc <fat16_write_file+0x654>
400073ac: 910033e8     	add	x8, sp, #0xc
400073b0: 910837e1     	add	x1, sp, #0x20d
400073b4: 52800162     	mov	w2, #0xb                // =11
400073b8: 91050115     	add	x21, x8, #0x140
400073bc: aa1503e0     	mov	x0, x21
400073c0: 97ffed8e     	bl	0x400029f8 <kstrncmp>
400073c4: 340008a0     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
400073c8: 394533e8     	ldrb	w8, [sp, #0x14c]
400073cc: 34000868     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
400073d0: 7103951f     	cmp	w8, #0xe5
400073d4: 2a1703f6     	mov	w22, w23
400073d8: 54000820     	b.eq	0x400074dc <fat16_write_file+0x654>
400073dc: 910033e8     	add	x8, sp, #0xc
400073e0: 910837e1     	add	x1, sp, #0x20d
400073e4: 52800162     	mov	w2, #0xb                // =11
400073e8: 91058115     	add	x21, x8, #0x160
400073ec: aa1503e0     	mov	x0, x21
400073f0: 97ffed82     	bl	0x400029f8 <kstrncmp>
400073f4: 34000720     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
400073f8: 3945b3e8     	ldrb	w8, [sp, #0x16c]
400073fc: 340006e8     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007400: 7103951f     	cmp	w8, #0xe5
40007404: 2a1703f6     	mov	w22, w23
40007408: 540006a0     	b.eq	0x400074dc <fat16_write_file+0x654>
4000740c: 910033e8     	add	x8, sp, #0xc
40007410: 910837e1     	add	x1, sp, #0x20d
40007414: 52800162     	mov	w2, #0xb                // =11
40007418: 91060115     	add	x21, x8, #0x180
4000741c: aa1503e0     	mov	x0, x21
40007420: 97ffed76     	bl	0x400029f8 <kstrncmp>
40007424: 340005a0     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007428: 394633e8     	ldrb	w8, [sp, #0x18c]
4000742c: 34000568     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007430: 7103951f     	cmp	w8, #0xe5
40007434: 2a1703f6     	mov	w22, w23
40007438: 54000520     	b.eq	0x400074dc <fat16_write_file+0x654>
4000743c: 910033e8     	add	x8, sp, #0xc
40007440: 910837e1     	add	x1, sp, #0x20d
40007444: 52800162     	mov	w2, #0xb                // =11
40007448: 91068115     	add	x21, x8, #0x1a0
4000744c: aa1503e0     	mov	x0, x21
40007450: 97ffed6a     	bl	0x400029f8 <kstrncmp>
40007454: 34000420     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007458: 3946b3e8     	ldrb	w8, [sp, #0x1ac]
4000745c: 340003e8     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007460: 7103951f     	cmp	w8, #0xe5
40007464: 2a1703f6     	mov	w22, w23
40007468: 540003a0     	b.eq	0x400074dc <fat16_write_file+0x654>
4000746c: 910033e8     	add	x8, sp, #0xc
40007470: 910837e1     	add	x1, sp, #0x20d
40007474: 52800162     	mov	w2, #0xb                // =11
40007478: 91070115     	add	x21, x8, #0x1c0
4000747c: aa1503e0     	mov	x0, x21
40007480: 97ffed5e     	bl	0x400029f8 <kstrncmp>
40007484: 340002a0     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
40007488: 394733e8     	ldrb	w8, [sp, #0x1cc]
4000748c: 34000268     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
40007490: 7103951f     	cmp	w8, #0xe5
40007494: 2a1703f6     	mov	w22, w23
40007498: 54000220     	b.eq	0x400074dc <fat16_write_file+0x654>
4000749c: 910033e8     	add	x8, sp, #0xc
400074a0: 910837e1     	add	x1, sp, #0x20d
400074a4: 52800162     	mov	w2, #0xb                // =11
400074a8: 91078115     	add	x21, x8, #0x1e0
400074ac: aa1503e0     	mov	x0, x21
400074b0: 97ffed52     	bl	0x400029f8 <kstrncmp>
400074b4: 34000120     	cbz	w0, 0x400074d8 <fat16_write_file+0x650>
400074b8: 3947b3e8     	ldrb	w8, [sp, #0x1ec]
400074bc: 340000e8     	cbz	w8, 0x400074d8 <fat16_write_file+0x650>
400074c0: 7103951f     	cmp	w8, #0xe5
400074c4: 2a1703f6     	mov	w22, w23
400074c8: 540000a0     	b.eq	0x400074dc <fat16_write_file+0x654>
400074cc: 14000019     	b	0x40007530 <fat16_write_file+0x6a8>
400074d0: 12800033     	mov	w19, #-0x2              // =-2
400074d4: 14000017     	b	0x40007530 <fat16_write_file+0x6a8>
400074d8: 2a1703f6     	mov	w22, w23
400074dc: 910837e1     	add	x1, sp, #0x20d
400074e0: aa1503e0     	mov	x0, x21
400074e4: 52800162     	mov	w2, #0xb                // =11
400074e8: 97ffed5b     	bl	0x40002a54 <kstrncpy>
400074ec: 52800408     	mov	w8, #0x20               // =32
400074f0: 3801ceb3     	strb	w19, [x21, #0x1c]!
400074f4: 53087ec9     	lsr	w9, w22, #8
400074f8: 381ef2a8     	sturb	w8, [x21, #-0x11]
400074fc: 53187e68     	lsr	w8, w19, #24
40007500: 910033e1     	add	x1, sp, #0xc
40007504: aa1403e0     	mov	x0, x20
40007508: 381fe2b6     	sturb	w22, [x21, #-0x2]
4000750c: 381ff2a9     	sturb	w9, [x21, #-0x1]
40007510: 53107e69     	lsr	w9, w19, #16
40007514: 39000ea8     	strb	w8, [x21, #0x3]
40007518: 53087e68     	lsr	w8, w19, #8
4000751c: 381f92bf     	sturb	wzr, [x21, #-0x7]
40007520: 381f82bf     	sturb	wzr, [x21, #-0x8]
40007524: 39000aa9     	strb	w9, [x21, #0x2]
40007528: 390006a8     	strb	w8, [x21, #0x1]
4000752c: 97fff9e4     	bl	0x40005cbc <virtio_blk_write_sector>
40007530: 2a1303e0     	mov	w0, w19
40007534: 911083ff     	add	sp, sp, #0x420
40007538: a9454ff4     	ldp	x20, x19, [sp, #0x50]
4000753c: a94457f6     	ldp	x22, x21, [sp, #0x40]
40007540: a9435ff8     	ldp	x24, x23, [sp, #0x30]
40007544: a94267fa     	ldp	x26, x25, [sp, #0x20]
40007548: a9416ffc     	ldp	x28, x27, [sp, #0x10]
4000754c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40007550: d65f03c0     	ret

0000000040007554 <fat16_populate_vfs>:
40007554: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
40007558: f9000bfc     	str	x28, [sp, #0x10]
4000755c: 910003fd     	mov	x29, sp
40007560: a90267fa     	stp	x26, x25, [sp, #0x20]
40007564: a9035ff8     	stp	x24, x23, [sp, #0x30]
40007568: a90457f6     	stp	x22, x21, [sp, #0x40]
4000756c: a9054ff4     	stp	x20, x19, [sp, #0x50]
40007570: d11843ff     	sub	sp, sp, #0x610
40007574: b0000233     	adrp	x19, 0x4004c000 <tx_buffers+0x722a>
40007578: b94e2268     	ldr	w8, [x19, #0xe20]
4000757c: 34000d68     	cbz	w8, 0x40007728 <fat16_populate_vfs+0x1d4>
40007580: 911043e8     	add	x8, sp, #0x410
40007584: 2a1f03f4     	mov	w20, wzr
40007588: b0000236     	adrp	x22, 0x4004c000 <tx_buffers+0x722a>
4000758c: 91001515     	add	x21, x8, #0x5
40007590: 911003f7     	add	x23, sp, #0x400
40007594: 528005d8     	mov	w24, #0x2e              // =46
40007598: 14000005     	b	0x400075ac <fat16_populate_vfs+0x58>
4000759c: b94e2268     	ldr	w8, [x19, #0xe20]
400075a0: 11000694     	add	w20, w20, #0x1
400075a4: 6b08029f     	cmp	w20, w8
400075a8: 54000c02     	b.hs	0x40007728 <fat16_populate_vfs+0x1d4>
400075ac: b94e1ec8     	ldr	w8, [x22, #0xe1c]
400075b0: 911043e1     	add	x1, sp, #0x410
400075b4: 0b140100     	add	w0, w8, w20
400075b8: 97fff921     	bl	0x40005a3c <virtio_blk_read_sector>
400075bc: aa1503f9     	mov	x25, x21
400075c0: 5280021a     	mov	w26, #0x10              // =16
400075c4: 14000004     	b	0x400075d4 <fat16_populate_vfs+0x80>
400075c8: f100075a     	subs	x26, x26, #0x1
400075cc: 91008339     	add	x25, x25, #0x20
400075d0: 54fffe60     	b.eq	0x4000759c <fat16_populate_vfs+0x48>
400075d4: 385fb328     	ldurb	w8, [x25, #-0x5]
400075d8: 7103951f     	cmp	w8, #0xe5
400075dc: 54ffff60     	b.eq	0x400075c8 <fat16_populate_vfs+0x74>
400075e0: 34000a48     	cbz	w8, 0x40007728 <fat16_populate_vfs+0x1d4>
400075e4: 39401b29     	ldrb	w9, [x25, #0x6]
400075e8: 7200113f     	tst	w9, #0x1f
400075ec: 54fffee1     	b.ne	0x400075c8 <fat16_populate_vfs+0x74>
400075f0: 7100811f     	cmp	w8, #0x20
400075f4: 54000061     	b.ne	0x40007600 <fat16_populate_vfs+0xac>
400075f8: aa1f03e8     	mov	x8, xzr
400075fc: 14000003     	b	0x40007608 <fat16_populate_vfs+0xb4>
40007600: 391003e8     	strb	w8, [sp, #0x400]
40007604: 52800028     	mov	w8, #0x1                // =1
40007608: 385fc329     	ldurb	w9, [x25, #-0x4]
4000760c: 7100813f     	cmp	w9, #0x20
40007610: 54000080     	b.eq	0x40007620 <fat16_populate_vfs+0xcc>
40007614: aa0802ea     	orr	x10, x23, x8
40007618: 91000508     	add	x8, x8, #0x1
4000761c: 39000149     	strb	w9, [x10]
40007620: 385fd329     	ldurb	w9, [x25, #-0x3]
40007624: 7100813f     	cmp	w9, #0x20
40007628: 54000080     	b.eq	0x40007638 <fat16_populate_vfs+0xe4>
4000762c: aa0802ea     	orr	x10, x23, x8
40007630: 91000508     	add	x8, x8, #0x1
40007634: 39000149     	strb	w9, [x10]
40007638: 385fe329     	ldurb	w9, [x25, #-0x2]
4000763c: 7100813f     	cmp	w9, #0x20
40007640: 54000080     	b.eq	0x40007650 <fat16_populate_vfs+0xfc>
40007644: 9100050a     	add	x10, x8, #0x1
40007648: 38286ae9     	strb	w9, [x23, x8]
4000764c: aa0a03e8     	mov	x8, x10
40007650: 385ff329     	ldurb	w9, [x25, #-0x1]
40007654: 7100813f     	cmp	w9, #0x20
40007658: 54000080     	b.eq	0x40007668 <fat16_populate_vfs+0x114>
4000765c: 9100050a     	add	x10, x8, #0x1
40007660: 38286ae9     	strb	w9, [x23, x8]
40007664: aa0a03e8     	mov	x8, x10
40007668: 39400329     	ldrb	w9, [x25]
4000766c: 7100813f     	cmp	w9, #0x20
40007670: 54000080     	b.eq	0x40007680 <fat16_populate_vfs+0x12c>
40007674: 9100050a     	add	x10, x8, #0x1
40007678: 38286ae9     	strb	w9, [x23, x8]
4000767c: aa0a03e8     	mov	x8, x10
40007680: 39400729     	ldrb	w9, [x25, #0x1]
40007684: 7100813f     	cmp	w9, #0x20
40007688: 54000080     	b.eq	0x40007698 <fat16_populate_vfs+0x144>
4000768c: 9100050a     	add	x10, x8, #0x1
40007690: 38286ae9     	strb	w9, [x23, x8]
40007694: aa0a03e8     	mov	x8, x10
40007698: 39400b29     	ldrb	w9, [x25, #0x2]
4000769c: 7100813f     	cmp	w9, #0x20
400076a0: 54000080     	b.eq	0x400076b0 <fat16_populate_vfs+0x15c>
400076a4: 9100050a     	add	x10, x8, #0x1
400076a8: 38286ae9     	strb	w9, [x23, x8]
400076ac: aa0a03e8     	mov	x8, x10
400076b0: 39400f2a     	ldrb	w10, [x25, #0x3]
400076b4: 7100815f     	cmp	w10, #0x20
400076b8: 54000240     	b.eq	0x40007700 <fat16_populate_vfs+0x1ac>
400076bc: 3940132b     	ldrb	w11, [x25, #0x4]
400076c0: 8b0802ec     	add	x12, x23, x8
400076c4: 91000909     	add	x9, x8, #0x2
400076c8: 39000198     	strb	w24, [x12]
400076cc: 7100817f     	cmp	w11, #0x20
400076d0: 3900058a     	strb	w10, [x12, #0x1]
400076d4: 54000080     	b.eq	0x400076e4 <fat16_populate_vfs+0x190>
400076d8: 91000d08     	add	x8, x8, #0x3
400076dc: 38296aeb     	strb	w11, [x23, x9]
400076e0: aa0803e9     	mov	x9, x8
400076e4: 3940172a     	ldrb	w10, [x25, #0x5]
400076e8: 7100815f     	cmp	w10, #0x20
400076ec: 54000061     	b.ne	0x400076f8 <fat16_populate_vfs+0x1a4>
400076f0: aa0903e8     	mov	x8, x9
400076f4: 14000003     	b	0x40007700 <fat16_populate_vfs+0x1ac>
400076f8: 91000528     	add	x8, x9, #0x1
400076fc: 38296aea     	strb	w10, [x23, x9]
40007700: 911003e0     	add	x0, sp, #0x400
40007704: 910003e1     	mov	x1, sp
40007708: 52808002     	mov	w2, #0x400              // =1024
4000770c: 38286aff     	strb	wzr, [x23, x8]
40007710: 97fffc90     	bl	0x40006950 <fat16_read_file>
40007714: 37fff5a0     	tbnz	w0, #0x1f, 0x400075c8 <fat16_populate_vfs+0x74>
40007718: 911003e0     	add	x0, sp, #0x400
4000771c: 910003e1     	mov	x1, sp
40007720: 97fff5fe     	bl	0x40004f18 <vfs_touch>
40007724: 17ffffa9     	b	0x400075c8 <fat16_populate_vfs+0x74>
40007728: 911843ff     	add	sp, sp, #0x610
4000772c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
40007730: f9400bfc     	ldr	x28, [sp, #0x10]
40007734: a94457f6     	ldp	x22, x21, [sp, #0x40]
40007738: a9435ff8     	ldp	x24, x23, [sp, #0x30]
4000773c: a94267fa     	ldp	x26, x25, [sp, #0x20]
40007740: a8c67bfd     	ldp	x29, x30, [sp], #0x60
40007744: d65f03c0     	ret
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
