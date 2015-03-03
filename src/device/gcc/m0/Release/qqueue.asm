   1              		.cpu cortex-m0
   2              		.fpu softvfp
   3              		.eabi_attribute 20, 1
   4              		.eabi_attribute 21, 1
   5              		.eabi_attribute 23, 3
   6              		.eabi_attribute 24, 1
   7              		.eabi_attribute 25, 1
   8              		.eabi_attribute 26, 1
   9              		.eabi_attribute 30, 6
  10              		.eabi_attribute 34, 0
  11              		.eabi_attribute 18, 4
  12              		.code	16
  13              		.file	"qqueue.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.global	g_qqueue
  18              		.section	.data.g_qqueue,"aw",%progbits
  19              		.align	2
  22              	g_qqueue:
  23 0000 00C00020 		.word	536920064
  24              		.section	.text.qq_enqueue,"ax",%progbits
  25              		.align	2
  26              		.global	qq_enqueue
  27              		.code	16
  28              		.thumb_func
  30              	qq_enqueue:
  31              	.LFB0:
  32              		.file 1 "../src/qqueue.c"
   1:../src/qqueue.c **** //
   2:../src/qqueue.c **** // begin license header
   3:../src/qqueue.c **** //
   4:../src/qqueue.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/qqueue.c **** //
   6:../src/qqueue.c **** // All Pixy source code is provided under the terms of the
   7:../src/qqueue.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/qqueue.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/qqueue.c **** // technologies under different licensing terms should contact us at
  10:../src/qqueue.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/qqueue.c **** // all portions of the Pixy codebase presented here.
  12:../src/qqueue.c **** //
  13:../src/qqueue.c **** // end license header
  14:../src/qqueue.c **** //
  15:../src/qqueue.c **** 
  16:../src/qqueue.c **** #include "qqueue.h"
  17:../src/qqueue.c **** #include "pixyvals.h"
  18:../src/qqueue.c **** 
  19:../src/qqueue.c **** struct QqueueFields *g_qqueue = (struct QqueueFields *)QQ_LOC;
  20:../src/qqueue.c **** 
  21:../src/qqueue.c **** uint32_t qq_enqueue(Qval val)
  22:../src/qqueue.c **** {
  33              		.loc 1 22 0
  34              		.cfi_startproc
  35 0000 80B5     		push	{r7, lr}
  36              		.cfi_def_cfa_offset 8
  37              		.cfi_offset 7, -8
  38              		.cfi_offset 14, -4
  39 0002 82B0     		sub	sp, sp, #8
  40              		.cfi_def_cfa_offset 16
  41 0004 00AF     		add	r7, sp, #0
  42              		.cfi_def_cfa_register 7
  43 0006 7860     		str	r0, [r7, #4]
  23:../src/qqueue.c ****     if (qq_free()>0)
  44              		.loc 1 23 0
  45 0008 FFF7FEFF 		bl	qq_free
  46 000c 031E     		sub	r3, r0, #0
  47 000e 21D0     		beq	.L2
  24:../src/qqueue.c ****     {
  25:../src/qqueue.c ****         g_qqueue->data[g_qqueue->writeIndex++] = val;
  48              		.loc 1 25 0
  49 0010 134B     		ldr	r3, .L5
  50 0012 1968     		ldr	r1, [r3]
  51 0014 124B     		ldr	r3, .L5
  52 0016 1B68     		ldr	r3, [r3]
  53 0018 5A88     		ldrh	r2, [r3, #2]
  54 001a 92B2     		uxth	r2, r2
  55 001c 501C     		add	r0, r2, #1
  56 001e 80B2     		uxth	r0, r0
  57 0020 5880     		strh	r0, [r3, #2]
  58 0022 131C     		mov	r3, r2
  59 0024 0233     		add	r3, r3, #2
  60 0026 9B00     		lsl	r3, r3, #2
  61 0028 7A68     		ldr	r2, [r7, #4]
  62 002a 5A50     		str	r2, [r3, r1]
  26:../src/qqueue.c ****         g_qqueue->produced++;
  63              		.loc 1 26 0
  64 002c 0C4B     		ldr	r3, .L5
  65 002e 1B68     		ldr	r3, [r3]
  66 0030 9A88     		ldrh	r2, [r3, #4]
  67 0032 92B2     		uxth	r2, r2
  68 0034 0132     		add	r2, r2, #1
  69 0036 92B2     		uxth	r2, r2
  70 0038 9A80     		strh	r2, [r3, #4]
  27:../src/qqueue.c **** 		if (g_qqueue->writeIndex==QQ_MEM_SIZE)
  71              		.loc 1 27 0
  72 003a 094B     		ldr	r3, .L5
  73 003c 1B68     		ldr	r3, [r3]
  74 003e 5B88     		ldrh	r3, [r3, #2]
  75 0040 9BB2     		uxth	r3, r3
  76 0042 084A     		ldr	r2, .L5+4
  77 0044 9342     		cmp	r3, r2
  78 0046 03D1     		bne	.L3
  28:../src/qqueue.c **** 			g_qqueue->writeIndex = 0;
  79              		.loc 1 28 0
  80 0048 054B     		ldr	r3, .L5
  81 004a 1B68     		ldr	r3, [r3]
  82 004c 0022     		mov	r2, #0
  83 004e 5A80     		strh	r2, [r3, #2]
  84              	.L3:
  29:../src/qqueue.c ****         return 1;
  85              		.loc 1 29 0
  86 0050 0123     		mov	r3, #1
  87 0052 00E0     		b	.L4
  88              	.L2:
  30:../src/qqueue.c ****     }
  31:../src/qqueue.c ****     return 0;
  89              		.loc 1 31 0
  90 0054 0023     		mov	r3, #0
  91              	.L4:
  32:../src/qqueue.c **** }
  92              		.loc 1 32 0
  93 0056 181C     		mov	r0, r3
  94 0058 BD46     		mov	sp, r7
  95 005a 02B0     		add	sp, sp, #8
  96              		@ sp needed
  97 005c 80BD     		pop	{r7, pc}
  98              	.L6:
  99 005e C046     		.align	2
 100              	.L5:
 101 0060 00000000 		.word	g_qqueue
 102 0064 FE0B0000 		.word	3070
 103              		.cfi_endproc
 104              	.LFE0:
 106              		.section	.text.qq_free,"ax",%progbits
 107              		.align	2
 108              		.global	qq_free
 109              		.code	16
 110              		.thumb_func
 112              	qq_free:
 113              	.LFB1:
  33:../src/qqueue.c **** 
  34:../src/qqueue.c **** uint16_t qq_free(void)
  35:../src/qqueue.c **** {
 114              		.loc 1 35 0
 115              		.cfi_startproc
 116 0000 80B5     		push	{r7, lr}
 117              		.cfi_def_cfa_offset 8
 118              		.cfi_offset 7, -8
 119              		.cfi_offset 14, -4
 120 0002 82B0     		sub	sp, sp, #8
 121              		.cfi_def_cfa_offset 16
 122 0004 00AF     		add	r7, sp, #0
 123              		.cfi_def_cfa_register 7
  36:../src/qqueue.c ****     uint16_t len = g_qqueue->produced - g_qqueue->consumed;
 124              		.loc 1 36 0
 125 0006 0A4B     		ldr	r3, .L9
 126 0008 1B68     		ldr	r3, [r3]
 127 000a 9B88     		ldrh	r3, [r3, #4]
 128 000c 99B2     		uxth	r1, r3
 129 000e 084B     		ldr	r3, .L9
 130 0010 1B68     		ldr	r3, [r3]
 131 0012 DB88     		ldrh	r3, [r3, #6]
 132 0014 9AB2     		uxth	r2, r3
 133 0016 BB1D     		add	r3, r7, #6
 134 0018 8A1A     		sub	r2, r1, r2
 135 001a 1A80     		strh	r2, [r3]
  37:../src/qqueue.c **** 	return QQ_MEM_SIZE-len;
 136              		.loc 1 37 0
 137 001c BB1D     		add	r3, r7, #6
 138 001e 1B88     		ldrh	r3, [r3]
 139 0020 044A     		ldr	r2, .L9+4
 140 0022 D31A     		sub	r3, r2, r3
 141 0024 9BB2     		uxth	r3, r3
  38:../src/qqueue.c **** } 
 142              		.loc 1 38 0
 143 0026 181C     		mov	r0, r3
 144 0028 BD46     		mov	sp, r7
 145 002a 02B0     		add	sp, sp, #8
 146              		@ sp needed
 147 002c 80BD     		pop	{r7, pc}
 148              	.L10:
 149 002e C046     		.align	2
 150              	.L9:
 151 0030 00000000 		.word	g_qqueue
 152 0034 FE0B0000 		.word	3070
 153              		.cfi_endproc
 154              	.LFE1:
 156              		.text
 157              	.Letext0:
 158              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
 159              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
 160              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 qqueue.c
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:22     .data.g_qqueue:00000000 g_qqueue
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:19     .data.g_qqueue:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:25     .text.qq_enqueue:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:30     .text.qq_enqueue:00000000 qq_enqueue
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:112    .text.qq_free:00000000 qq_free
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:101    .text.qq_enqueue:00000060 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:107    .text.qq_free:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cci3pmxh.s:151    .text.qq_free:00000030 $d
                     .debug_frame:00000010 $d

NO UNDEFINED SYMBOLS
