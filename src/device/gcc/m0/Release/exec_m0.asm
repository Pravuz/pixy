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
  13              		.file	"exec_m0.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.global	g_running
  18              		.section	.bss.g_running,"aw",%nobits
  21              	g_running:
  22 0000 00       		.space	1
  23              		.global	g_run
  24              		.section	.bss.g_run,"aw",%nobits
  27              	g_run:
  28 0000 00       		.space	1
  29              		.global	g_program
  30              		.section	.data.g_program,"aw",%progbits
  33              	g_program:
  34 0000 FF       		.byte	-1
  35              		.section	.rodata
  36              		.align	2
  37              	.LC0:
  38 0000 72756E00 		.ascii	"run\000"
  39              		.align	2
  40              	.LC3:
  41 0004 73746F70 		.ascii	"stop\000"
  41      00
  42 0009 000000   		.align	2
  43              	.LC6:
  44 000c 72756E6E 		.ascii	"running\000"
  44      696E6700 
  45              		.section	.text.exec_init,"ax",%progbits
  46              		.align	2
  47              		.global	exec_init
  48              		.code	16
  49              		.thumb_func
  51              	exec_init:
  52              	.LFB0:
  53              		.file 1 "../src/exec_m0.c"
   1:../src/exec_m0.c **** //
   2:../src/exec_m0.c **** // begin license header
   3:../src/exec_m0.c **** //
   4:../src/exec_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/exec_m0.c **** //
   6:../src/exec_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/exec_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/exec_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/exec_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/exec_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/exec_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/exec_m0.c **** //
  13:../src/exec_m0.c **** // end license header
  14:../src/exec_m0.c **** //
  15:../src/exec_m0.c **** 
  16:../src/exec_m0.c **** #include <pixyvals.h>
  17:../src/exec_m0.c **** #include "chirp.h"
  18:../src/exec_m0.c **** #include "exec_m0.h"
  19:../src/exec_m0.c **** #include "rls_m0.h"
  20:../src/exec_m0.c **** 
  21:../src/exec_m0.c **** uint8_t g_running = 0;
  22:../src/exec_m0.c **** uint8_t g_run = 0;
  23:../src/exec_m0.c **** int8_t g_program = -1;
  24:../src/exec_m0.c **** 
  25:../src/exec_m0.c **** int exec_init(void)
  26:../src/exec_m0.c **** {
  54              		.loc 1 26 0
  55              		.cfi_startproc
  56 0000 80B5     		push	{r7, lr}
  57              		.cfi_def_cfa_offset 8
  58              		.cfi_offset 7, -8
  59              		.cfi_offset 14, -4
  60 0002 00AF     		add	r7, sp, #0
  61              		.cfi_def_cfa_register 7
  27:../src/exec_m0.c **** 	chirpSetProc("run", (ProcPtr)exec_run);
  62              		.loc 1 27 0
  63 0004 0A4A     		ldr	r2, .L3
  64 0006 0B4B     		ldr	r3, .L3+4
  65 0008 101C     		mov	r0, r2
  66 000a 191C     		mov	r1, r3
  67 000c FFF7FEFF 		bl	chirpSetProc
  28:../src/exec_m0.c **** 	chirpSetProc("stop", (ProcPtr)exec_stop);
  68              		.loc 1 28 0
  69 0010 094A     		ldr	r2, .L3+8
  70 0012 0A4B     		ldr	r3, .L3+12
  71 0014 101C     		mov	r0, r2
  72 0016 191C     		mov	r1, r3
  73 0018 FFF7FEFF 		bl	chirpSetProc
  29:../src/exec_m0.c **** 	chirpSetProc("running", (ProcPtr)exec_running);
  74              		.loc 1 29 0
  75 001c 084A     		ldr	r2, .L3+16
  76 001e 094B     		ldr	r3, .L3+20
  77 0020 101C     		mov	r0, r2
  78 0022 191C     		mov	r1, r3
  79 0024 FFF7FEFF 		bl	chirpSetProc
  30:../src/exec_m0.c **** 		
  31:../src/exec_m0.c **** 	return 0;	
  80              		.loc 1 31 0
  81 0028 0023     		mov	r3, #0
  32:../src/exec_m0.c **** }
  82              		.loc 1 32 0
  83 002a 181C     		mov	r0, r3
  84 002c BD46     		mov	sp, r7
  85              		@ sp needed
  86 002e 80BD     		pop	{r7, pc}
  87              	.L4:
  88              		.align	2
  89              	.L3:
  90 0030 00000000 		.word	.LC0
  91 0034 00000000 		.word	exec_run
  92 0038 04000000 		.word	.LC3
  93 003c 00000000 		.word	exec_stop
  94 0040 0C000000 		.word	.LC6
  95 0044 00000000 		.word	exec_running
  96              		.cfi_endproc
  97              	.LFE0:
  99              		.section	.text.exec_running,"ax",%progbits
 100              		.align	2
 101              		.global	exec_running
 102              		.code	16
 103              		.thumb_func
 105              	exec_running:
 106              	.LFB1:
  33:../src/exec_m0.c **** 
  34:../src/exec_m0.c **** uint32_t exec_running(void)
  35:../src/exec_m0.c **** {
 107              		.loc 1 35 0
 108              		.cfi_startproc
 109 0000 80B5     		push	{r7, lr}
 110              		.cfi_def_cfa_offset 8
 111              		.cfi_offset 7, -8
 112              		.cfi_offset 14, -4
 113 0002 00AF     		add	r7, sp, #0
 114              		.cfi_def_cfa_register 7
  36:../src/exec_m0.c **** 	return (uint32_t)g_running;
 115              		.loc 1 36 0
 116 0004 024B     		ldr	r3, .L7
 117 0006 1B78     		ldrb	r3, [r3]
  37:../src/exec_m0.c **** }
 118              		.loc 1 37 0
 119 0008 181C     		mov	r0, r3
 120 000a BD46     		mov	sp, r7
 121              		@ sp needed
 122 000c 80BD     		pop	{r7, pc}
 123              	.L8:
 124 000e C046     		.align	2
 125              	.L7:
 126 0010 00000000 		.word	g_running
 127              		.cfi_endproc
 128              	.LFE1:
 130              		.section	.text.exec_stop,"ax",%progbits
 131              		.align	2
 132              		.global	exec_stop
 133              		.code	16
 134              		.thumb_func
 136              	exec_stop:
 137              	.LFB2:
  38:../src/exec_m0.c **** 
  39:../src/exec_m0.c **** int32_t exec_stop(void)
  40:../src/exec_m0.c **** {
 138              		.loc 1 40 0
 139              		.cfi_startproc
 140 0000 80B5     		push	{r7, lr}
 141              		.cfi_def_cfa_offset 8
 142              		.cfi_offset 7, -8
 143              		.cfi_offset 14, -4
 144 0002 00AF     		add	r7, sp, #0
 145              		.cfi_def_cfa_register 7
  41:../src/exec_m0.c **** 	g_run = 0;
 146              		.loc 1 41 0
 147 0004 034B     		ldr	r3, .L11
 148 0006 0022     		mov	r2, #0
 149 0008 1A70     		strb	r2, [r3]
  42:../src/exec_m0.c **** 	return 0;
 150              		.loc 1 42 0
 151 000a 0023     		mov	r3, #0
  43:../src/exec_m0.c **** }
 152              		.loc 1 43 0
 153 000c 181C     		mov	r0, r3
 154 000e BD46     		mov	sp, r7
 155              		@ sp needed
 156 0010 80BD     		pop	{r7, pc}
 157              	.L12:
 158 0012 C046     		.align	2
 159              	.L11:
 160 0014 00000000 		.word	g_run
 161              		.cfi_endproc
 162              	.LFE2:
 164              		.section	.text.exec_run,"ax",%progbits
 165              		.align	2
 166              		.global	exec_run
 167              		.code	16
 168              		.thumb_func
 170              	exec_run:
 171              	.LFB3:
  44:../src/exec_m0.c **** 
  45:../src/exec_m0.c **** int32_t exec_run(uint8_t *prog)
  46:../src/exec_m0.c **** {
 172              		.loc 1 46 0
 173              		.cfi_startproc
 174 0000 80B5     		push	{r7, lr}
 175              		.cfi_def_cfa_offset 8
 176              		.cfi_offset 7, -8
 177              		.cfi_offset 14, -4
 178 0002 82B0     		sub	sp, sp, #8
 179              		.cfi_def_cfa_offset 16
 180 0004 00AF     		add	r7, sp, #0
 181              		.cfi_def_cfa_register 7
 182 0006 7860     		str	r0, [r7, #4]
  47:../src/exec_m0.c **** 	g_program = *prog;
 183              		.loc 1 47 0
 184 0008 7B68     		ldr	r3, [r7, #4]
 185 000a 1B78     		ldrb	r3, [r3]
 186 000c DAB2     		uxtb	r2, r3
 187 000e 064B     		ldr	r3, .L15
 188 0010 1A70     		strb	r2, [r3]
  48:../src/exec_m0.c **** 	g_run = 1;
 189              		.loc 1 48 0
 190 0012 064B     		ldr	r3, .L15+4
 191 0014 0122     		mov	r2, #1
 192 0016 1A70     		strb	r2, [r3]
  49:../src/exec_m0.c **** 	g_running = 1;		
 193              		.loc 1 49 0
 194 0018 054B     		ldr	r3, .L15+8
 195 001a 0122     		mov	r2, #1
 196 001c 1A70     		strb	r2, [r3]
  50:../src/exec_m0.c **** 	return 0;
 197              		.loc 1 50 0
 198 001e 0023     		mov	r3, #0
  51:../src/exec_m0.c **** }
 199              		.loc 1 51 0
 200 0020 181C     		mov	r0, r3
 201 0022 BD46     		mov	sp, r7
 202 0024 02B0     		add	sp, sp, #8
 203              		@ sp needed
 204 0026 80BD     		pop	{r7, pc}
 205              	.L16:
 206              		.align	2
 207              	.L15:
 208 0028 00000000 		.word	g_program
 209 002c 00000000 		.word	g_run
 210 0030 00000000 		.word	g_running
 211              		.cfi_endproc
 212              	.LFE3:
 214              		.section	.text.setup0,"ax",%progbits
 215              		.align	2
 216              		.global	setup0
 217              		.code	16
 218              		.thumb_func
 220              	setup0:
 221              	.LFB4:
  52:../src/exec_m0.c **** 
  53:../src/exec_m0.c **** #define LUT_MEMORY_SIZE		0x10000 // bytes
  54:../src/exec_m0.c **** 
  55:../src/exec_m0.c **** void setup0()
  56:../src/exec_m0.c **** {
 222              		.loc 1 56 0
 223              		.cfi_startproc
 224 0000 80B5     		push	{r7, lr}
 225              		.cfi_def_cfa_offset 8
 226              		.cfi_offset 7, -8
 227              		.cfi_offset 14, -4
 228 0002 00AF     		add	r7, sp, #0
 229              		.cfi_def_cfa_register 7
  57:../src/exec_m0.c **** }
 230              		.loc 1 57 0
 231 0004 BD46     		mov	sp, r7
 232              		@ sp needed
 233 0006 80BD     		pop	{r7, pc}
 234              		.cfi_endproc
 235              	.LFE4:
 237              		.global	g_m0mem
 238              		.section	.data.g_m0mem,"aw",%progbits
 239              		.align	2
 242              	g_m0mem:
 243 0000 00000810 		.word	268959744
 244              		.global	g_lut
 245              		.section	.data.g_lut,"aw",%progbits
 246              		.align	2
 249              	g_lut:
 250 0000 00200810 		.word	268967936
 251              		.section	.text.loop0,"ax",%progbits
 252              		.align	2
 253              		.global	loop0
 254              		.code	16
 255              		.thumb_func
 257              	loop0:
 258              	.LFB5:
  58:../src/exec_m0.c **** 
  59:../src/exec_m0.c **** uint32_t g_m0mem = SRAM1_LOC;
  60:../src/exec_m0.c **** uint32_t g_lut = SRAM1_LOC + SRAM1_SIZE-LUT_MEMORY_SIZE;
  61:../src/exec_m0.c **** 
  62:../src/exec_m0.c **** void loop0()
  63:../src/exec_m0.c **** {
 259              		.loc 1 63 0
 260              		.cfi_startproc
 261 0000 80B5     		push	{r7, lr}
 262              		.cfi_def_cfa_offset 8
 263              		.cfi_offset 7, -8
 264              		.cfi_offset 14, -4
 265 0002 00AF     		add	r7, sp, #0
 266              		.cfi_def_cfa_register 7
  64:../src/exec_m0.c **** 	getRLSFrame(&g_m0mem, &g_lut);	
 267              		.loc 1 64 0
 268 0004 034A     		ldr	r2, .L19
 269 0006 044B     		ldr	r3, .L19+4
 270 0008 101C     		mov	r0, r2
 271 000a 191C     		mov	r1, r3
 272 000c FFF7FEFF 		bl	getRLSFrame
  65:../src/exec_m0.c **** }
 273              		.loc 1 65 0
 274 0010 BD46     		mov	sp, r7
 275              		@ sp needed
 276 0012 80BD     		pop	{r7, pc}
 277              	.L20:
 278              		.align	2
 279              	.L19:
 280 0014 00000000 		.word	g_m0mem
 281 0018 00000000 		.word	g_lut
 282              		.cfi_endproc
 283              	.LFE5:
 285              		.section	.text.exec_loop,"ax",%progbits
 286              		.align	2
 287              		.global	exec_loop
 288              		.code	16
 289              		.thumb_func
 291              	exec_loop:
 292              	.LFB6:
  66:../src/exec_m0.c **** 
  67:../src/exec_m0.c **** 
  68:../src/exec_m0.c **** void exec_loop(void)
  69:../src/exec_m0.c **** {
 293              		.loc 1 69 0
 294              		.cfi_startproc
 295 0000 80B5     		push	{r7, lr}
 296              		.cfi_def_cfa_offset 8
 297              		.cfi_offset 7, -8
 298              		.cfi_offset 14, -4
 299 0002 00AF     		add	r7, sp, #0
 300              		.cfi_def_cfa_register 7
 301              	.L26:
  70:../src/exec_m0.c **** 	while(1)
  71:../src/exec_m0.c **** 	{
  72:../src/exec_m0.c **** 		while(!g_run)
 302              		.loc 1 72 0
 303 0004 01E0     		b	.L22
 304              	.L23:
  73:../src/exec_m0.c **** 			chirpService();
 305              		.loc 1 73 0
 306 0006 FFF7FEFF 		bl	chirpService
 307              	.L22:
  72:../src/exec_m0.c **** 			chirpService();
 308              		.loc 1 72 0
 309 000a 094B     		ldr	r3, .L27
 310 000c 1B78     		ldrb	r3, [r3]
 311 000e 002B     		cmp	r3, #0
 312 0010 F9D0     		beq	.L23
  74:../src/exec_m0.c **** 		 	
  75:../src/exec_m0.c **** 		setup0();
 313              		.loc 1 75 0
 314 0012 FFF7FEFF 		bl	setup0
  76:../src/exec_m0.c **** 		while(g_run)
 315              		.loc 1 76 0
 316 0016 03E0     		b	.L24
 317              	.L25:
  77:../src/exec_m0.c **** 		{
  78:../src/exec_m0.c **** 			loop0();
 318              		.loc 1 78 0
 319 0018 FFF7FEFF 		bl	loop0
  79:../src/exec_m0.c **** 			chirpService();
 320              		.loc 1 79 0
 321 001c FFF7FEFF 		bl	chirpService
 322              	.L24:
  76:../src/exec_m0.c **** 		while(g_run)
 323              		.loc 1 76 0
 324 0020 034B     		ldr	r3, .L27
 325 0022 1B78     		ldrb	r3, [r3]
 326 0024 002B     		cmp	r3, #0
 327 0026 F7D1     		bne	.L25
  80:../src/exec_m0.c **** 		}
  81:../src/exec_m0.c **** 		// set variable to indicate we've stopped
  82:../src/exec_m0.c **** 		g_running = 0;
 328              		.loc 1 82 0
 329 0028 024B     		ldr	r3, .L27+4
 330 002a 0022     		mov	r2, #0
 331 002c 1A70     		strb	r2, [r3]
  83:../src/exec_m0.c **** 	}
 332              		.loc 1 83 0
 333 002e E9E7     		b	.L26
 334              	.L28:
 335              		.align	2
 336              	.L27:
 337 0030 00000000 		.word	g_run
 338 0034 00000000 		.word	g_running
 339              		.cfi_endproc
 340              	.LFE6:
 342              		.text
 343              	.Letext0:
 344              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
 345              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
 346              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 exec_m0.c
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:21     .bss.g_running:00000000 g_running
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:22     .bss.g_running:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:27     .bss.g_run:00000000 g_run
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:28     .bss.g_run:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:33     .data.g_program:00000000 g_program
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:36     .rodata:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:46     .text.exec_init:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:51     .text.exec_init:00000000 exec_init
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:90     .text.exec_init:00000030 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:170    .text.exec_run:00000000 exec_run
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:136    .text.exec_stop:00000000 exec_stop
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:105    .text.exec_running:00000000 exec_running
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:100    .text.exec_running:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:126    .text.exec_running:00000010 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:131    .text.exec_stop:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:160    .text.exec_stop:00000014 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:165    .text.exec_run:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:208    .text.exec_run:00000028 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:215    .text.setup0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:220    .text.setup0:00000000 setup0
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:242    .data.g_m0mem:00000000 g_m0mem
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:239    .data.g_m0mem:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:249    .data.g_lut:00000000 g_lut
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:246    .data.g_lut:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:252    .text.loop0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:257    .text.loop0:00000000 loop0
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:280    .text.loop0:00000014 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:286    .text.exec_loop:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:291    .text.exec_loop:00000000 exec_loop
C:\Users\OUROBO~1\AppData\Local\Temp\ccYcFLfn.s:337    .text.exec_loop:00000030 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
chirpSetProc
getRLSFrame
chirpService
