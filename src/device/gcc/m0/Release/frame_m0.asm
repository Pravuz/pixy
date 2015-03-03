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
  13              		.file	"frame_m0.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.section	.text.vsync,"ax",%progbits
  18              		.align	2
  19              		.global	vsync
  20              		.code	16
  21              		.thumb_func
  23              	vsync:
  24              	.LFB32:
  25              		.file 1 "../src/frame_m0.c"
   1:../src/frame_m0.c **** //
   2:../src/frame_m0.c **** // begin license header
   3:../src/frame_m0.c **** //
   4:../src/frame_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/frame_m0.c **** //
   6:../src/frame_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/frame_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/frame_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/frame_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/frame_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/frame_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/frame_m0.c **** //
  13:../src/frame_m0.c **** // end license header
  14:../src/frame_m0.c **** //
  15:../src/frame_m0.c **** 
  16:../src/frame_m0.c **** #include "debug_frmwrk.h"
  17:../src/frame_m0.c **** #include "chirp.h"
  18:../src/frame_m0.c **** #include "frame_m0.h"
  19:../src/frame_m0.c **** 
  20:../src/frame_m0.c **** #define CAM_PCLK_MASK   0x2000
  21:../src/frame_m0.c **** 
  22:../src/frame_m0.c **** #define ALIGN(v, n)  ((uint32_t)v&((n)-1) ? ((uint32_t)v&~((n)-1))+(n) : (uint32_t)v)
  23:../src/frame_m0.c **** 
  24:../src/frame_m0.c **** void vsync()
  25:../src/frame_m0.c **** {
  26              		.loc 1 25 0
  27              		.cfi_startproc
  28 0000 80B5     		push	{r7, lr}
  29              		.cfi_def_cfa_offset 8
  30              		.cfi_offset 7, -8
  31              		.cfi_offset 14, -4
  32 0002 82B0     		sub	sp, sp, #8
  33              		.cfi_def_cfa_offset 16
  34 0004 00AF     		add	r7, sp, #0
  35              		.cfi_def_cfa_register 7
  26:../src/frame_m0.c **** 	int v = 0, h = 0;
  36              		.loc 1 26 0
  37 0006 0023     		mov	r3, #0
  38 0008 7B60     		str	r3, [r7, #4]
  39 000a 0023     		mov	r3, #0
  40 000c 3B60     		str	r3, [r7]
  41              	.L8:
  27:../src/frame_m0.c **** 
  28:../src/frame_m0.c **** 	while(1)
  29:../src/frame_m0.c **** 	{
  30:../src/frame_m0.c **** 		h = 0;
  42              		.loc 1 30 0
  43 000e 0023     		mov	r3, #0
  44 0010 3B60     		str	r3, [r7]
  31:../src/frame_m0.c **** 		while(CAM_VSYNC()!=0);
  45              		.loc 1 31 0
  46 0012 C046     		mov	r8, r8
  47              	.L2:
  48              		.loc 1 31 0 is_stmt 0 discriminator 1
  49 0014 134A     		ldr	r2, .L10
  50 0016 144B     		ldr	r3, .L10+4
  51 0018 D258     		ldr	r2, [r2, r3]
  52 001a 8023     		mov	r3, #128
  53 001c 5B01     		lsl	r3, r3, #5
  54 001e 1340     		and	r3, r2
  55 0020 F8D1     		bne	.L2
  56              	.L7:
  32:../src/frame_m0.c **** 		while(1) // vsync low
  33:../src/frame_m0.c **** 		{
  34:../src/frame_m0.c **** 			while(CAM_HSYNC()==0)
  57              		.loc 1 34 0 is_stmt 1
  58 0022 07E0     		b	.L3
  59              	.L5:
  35:../src/frame_m0.c **** 			{
  36:../src/frame_m0.c **** 			if (CAM_VSYNC()!=0)
  60              		.loc 1 36 0
  61 0024 0F4A     		ldr	r2, .L10
  62 0026 104B     		ldr	r3, .L10+4
  63 0028 D258     		ldr	r2, [r2, r3]
  64 002a 8023     		mov	r3, #128
  65 002c 5B01     		lsl	r3, r3, #5
  66 002e 1340     		and	r3, r2
  67 0030 00D0     		beq	.L3
  37:../src/frame_m0.c **** 				goto end;
  68              		.loc 1 37 0
  69 0032 12E0     		b	.L9
  70              	.L3:
  34:../src/frame_m0.c **** 			{
  71              		.loc 1 34 0
  72 0034 0B4A     		ldr	r2, .L10
  73 0036 0C4B     		ldr	r3, .L10+4
  74 0038 D258     		ldr	r2, [r2, r3]
  75 003a 8023     		mov	r3, #128
  76 003c 1B01     		lsl	r3, r3, #4
  77 003e 1340     		and	r3, r2
  78 0040 F0D0     		beq	.L5
  38:../src/frame_m0.c **** 			}
  39:../src/frame_m0.c **** 			while(CAM_HSYNC()!=0); //grab data
  79              		.loc 1 39 0
  80 0042 C046     		mov	r8, r8
  81              	.L6:
  82              		.loc 1 39 0 is_stmt 0 discriminator 1
  83 0044 074A     		ldr	r2, .L10
  84 0046 084B     		ldr	r3, .L10+4
  85 0048 D258     		ldr	r2, [r2, r3]
  86 004a 8023     		mov	r3, #128
  87 004c 1B01     		lsl	r3, r3, #4
  88 004e 1340     		and	r3, r2
  89 0050 F8D1     		bne	.L6
  40:../src/frame_m0.c **** 			h++;
  90              		.loc 1 40 0 is_stmt 1
  91 0052 3B68     		ldr	r3, [r7]
  92 0054 0133     		add	r3, r3, #1
  93 0056 3B60     		str	r3, [r7]
  41:../src/frame_m0.c **** 		}
  94              		.loc 1 41 0
  95 0058 E3E7     		b	.L7
  96              	.L9:
  97              	.L4:
  42:../src/frame_m0.c **** end:
  43:../src/frame_m0.c **** 		v++;
  98              		.loc 1 43 0
  99 005a 7B68     		ldr	r3, [r7, #4]
 100 005c 0133     		add	r3, r3, #1
 101 005e 7B60     		str	r3, [r7, #4]
  44:../src/frame_m0.c **** 		//if (v%25==0)
  45:../src/frame_m0.c **** 			//printf("%d %d\n", v, h);
  46:../src/frame_m0.c **** 	}
 102              		.loc 1 46 0
 103 0060 D5E7     		b	.L8
 104              	.L11:
 105 0062 C046     		.align	2
 106              	.L10:
 107 0064 00400F40 		.word	1074741248
 108 0068 04210000 		.word	8452
 109              		.cfi_endproc
 110              	.LFE32:
 112              		.section	.text.syncM0,"ax",%progbits
 113              		.align	2
 114              		.global	syncM0
 115              		.code	16
 116              		.thumb_func
 118              	syncM0:
 119              	.LFB33:
  47:../src/frame_m0.c **** }
  48:../src/frame_m0.c **** 
  49:../src/frame_m0.c **** 
  50:../src/frame_m0.c **** void syncM0(uint32_t *gpioIn, uint32_t clkMask)
  51:../src/frame_m0.c **** {
 120              		.loc 1 51 0
 121              		.cfi_startproc
 122 0000 80B5     		push	{r7, lr}
 123              		.cfi_def_cfa_offset 8
 124              		.cfi_offset 7, -8
 125              		.cfi_offset 14, -4
 126 0002 82B0     		sub	sp, sp, #8
 127              		.cfi_def_cfa_offset 16
 128 0004 00AF     		add	r7, sp, #0
 129              		.cfi_def_cfa_register 7
 130 0006 7860     		str	r0, [r7, #4]
 131 0008 3960     		str	r1, [r7]
  52:../src/frame_m0.c **** asm(".syntax unified");
 132              		.loc 1 52 0
 133              	@ 52 "../src/frame_m0.c" 1
 134              		.syntax unified
 135              	@ 0 "" 2
  53:../src/frame_m0.c **** 
  54:../src/frame_m0.c **** 	asm("PUSH	{r4}");
 136              		.loc 1 54 0
 137              	@ 54 "../src/frame_m0.c" 1
 138 000a 10B4     		PUSH	{r4}
 139              	@ 0 "" 2
  55:../src/frame_m0.c **** 
  56:../src/frame_m0.c **** asm("start:");
 140              		.loc 1 56 0
 141              	@ 56 "../src/frame_m0.c" 1
 142              		start:
 143              	@ 0 "" 2
  57:../src/frame_m0.c **** 	// This sequence can be extended to reduce probability of false phase detection.
  58:../src/frame_m0.c **** 	// This routine acts as a "sieve", only letting a specific phase through.  
  59:../src/frame_m0.c **** 	// In practice, 2 different phases separated by 1 clock are permitted through
  60:../src/frame_m0.c **** 	// which is acceptable-- 5ns in a 30ns period.  
  61:../src/frame_m0.c **** 	// If the pixel clock is shifted 1/2 a cpu clock period (or less), with respect to the CPU clock, 
  62:../src/frame_m0.c **** 	// If the pixel clock is perfectly in line with the cpu clock, 1 phase will match.  
  63:../src/frame_m0.c **** 	// Worst case will aways be 2 possible phases. 
  64:../src/frame_m0.c **** 	// It takes between 50 and 200 cpu clock cycles to complete.  	
  65:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 144              		.loc 1 65 0
 145              	@ 65 "../src/frame_m0.c" 1
 146 000c 0268     		LDR 	r2, [r0]
 147              	@ 0 "" 2
  66:../src/frame_m0.c **** 	asm("NOP");
 148              		.loc 1 66 0
 149              	@ 66 "../src/frame_m0.c" 1
 150 000e C046     		NOP
 151              	@ 0 "" 2
  67:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // low
 152              		.loc 1 67 0
 153              	@ 67 "../src/frame_m0.c" 1
 154 0010 0368     		LDR 	r3, [r0]
 155              	@ 0 "" 2
  68:../src/frame_m0.c **** 	asm("BICS	r2, r3");
 156              		.loc 1 68 0
 157              	@ 68 "../src/frame_m0.c" 1
 158 0012 9A43     		BICS	r2, r3
 159              	@ 0 "" 2
  69:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // high
 160              		.loc 1 69 0
 161              	@ 69 "../src/frame_m0.c" 1
 162 0014 0368     		LDR 	r3, [r0]
 163              	@ 0 "" 2
  70:../src/frame_m0.c **** 	asm("ANDS	r3, r2");
 164              		.loc 1 70 0
 165              	@ 70 "../src/frame_m0.c" 1
 166 0016 1340     		ANDS	r3, r2
 167              	@ 0 "" 2
  71:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 168              		.loc 1 71 0
 169              	@ 71 "../src/frame_m0.c" 1
 170 0018 0268     		LDR 	r2, [r0]
 171              	@ 0 "" 2
  72:../src/frame_m0.c **** 	asm("LDR 	r4, [r0]"); // high
 172              		.loc 1 72 0
 173              	@ 72 "../src/frame_m0.c" 1
 174 001a 0468     		LDR 	r4, [r0]
 175              	@ 0 "" 2
  73:../src/frame_m0.c **** 	asm("BICS 	r4, r2");
 176              		.loc 1 73 0
 177              	@ 73 "../src/frame_m0.c" 1
 178 001c 9443     		BICS 	r4, r2
 179              	@ 0 "" 2
  74:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 180              		.loc 1 74 0
 181              	@ 74 "../src/frame_m0.c" 1
 182 001e 0268     		LDR 	r2, [r0]
 183              	@ 0 "" 2
  75:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 184              		.loc 1 75 0
 185              	@ 75 "../src/frame_m0.c" 1
 186 0020 9443     		BICS	r4, r2
 187              	@ 0 "" 2
  76:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 188              		.loc 1 76 0
 189              	@ 76 "../src/frame_m0.c" 1
 190 0022 0268     		LDR 	r2, [r0]
 191              	@ 0 "" 2
  77:../src/frame_m0.c **** 	asm("ANDS	r4, r2");
 192              		.loc 1 77 0
 193              	@ 77 "../src/frame_m0.c" 1
 194 0024 1440     		ANDS	r4, r2
 195              	@ 0 "" 2
  78:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 196              		.loc 1 78 0
 197              	@ 78 "../src/frame_m0.c" 1
 198 0026 0268     		LDR 	r2, [r0]
 199              	@ 0 "" 2
  79:../src/frame_m0.c **** 	
  80:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 200              		.loc 1 80 0
 201              	@ 80 "../src/frame_m0.c" 1
 202 0028 9443     		BICS	r4, r2
 203              	@ 0 "" 2
  81:../src/frame_m0.c **** 	asm("ANDS	r4, r3");
 204              		.loc 1 81 0
 205              	@ 81 "../src/frame_m0.c" 1
 206 002a 1C40     		ANDS	r4, r3
 207              	@ 0 "" 2
  82:../src/frame_m0.c **** 
  83:../src/frame_m0.c **** 	asm("TST	r4, r1");
 208              		.loc 1 83 0
 209              	@ 83 "../src/frame_m0.c" 1
 210 002c 0C42     		TST	r4, r1
 211              	@ 0 "" 2
  84:../src/frame_m0.c **** 	asm("BEQ	start");
 212              		.loc 1 84 0
 213              	@ 84 "../src/frame_m0.c" 1
 214 002e EDD0     		BEQ	start
 215              	@ 0 "" 2
  85:../src/frame_m0.c **** 
  86:../src/frame_m0.c **** 	// in-phase begins here
  87:../src/frame_m0.c **** 	asm("POP   	{r4}");
 216              		.loc 1 87 0
 217              	@ 87 "../src/frame_m0.c" 1
 218 0030 10BC     		POP   	{r4}
 219              	@ 0 "" 2
  88:../src/frame_m0.c **** 
  89:../src/frame_m0.c **** 	asm(".syntax divided");
 220              		.loc 1 89 0
 221              	@ 89 "../src/frame_m0.c" 1
 222              		.syntax divided
 223              	@ 0 "" 2
  90:../src/frame_m0.c **** }
 224              		.loc 1 90 0
 225              		.code	16
 226 0032 BD46     		mov	sp, r7
 227 0034 02B0     		add	sp, sp, #8
 228              		@ sp needed
 229 0036 80BD     		pop	{r7, pc}
 230              		.cfi_endproc
 231              	.LFE33:
 233              		.section	.text.syncM1,"ax",%progbits
 234              		.align	2
 235              		.global	syncM1
 236              		.code	16
 237              		.thumb_func
 239              	syncM1:
 240              	.LFB34:
  91:../src/frame_m0.c **** 
  92:../src/frame_m0.c **** 
  93:../src/frame_m0.c **** void syncM1(uint32_t *gpioIn, uint32_t clkMask)
  94:../src/frame_m0.c **** {
 241              		.loc 1 94 0
 242              		.cfi_startproc
 243 0000 80B5     		push	{r7, lr}
 244              		.cfi_def_cfa_offset 8
 245              		.cfi_offset 7, -8
 246              		.cfi_offset 14, -4
 247 0002 82B0     		sub	sp, sp, #8
 248              		.cfi_def_cfa_offset 16
 249 0004 00AF     		add	r7, sp, #0
 250              		.cfi_def_cfa_register 7
 251 0006 7860     		str	r0, [r7, #4]
 252 0008 3960     		str	r1, [r7]
  95:../src/frame_m0.c **** asm(".syntax unified");
 253              		.loc 1 95 0
 254              	@ 95 "../src/frame_m0.c" 1
 255              		.syntax unified
 256              	@ 0 "" 2
  96:../src/frame_m0.c **** 
  97:../src/frame_m0.c **** 	asm("PUSH	{r4}");
 257              		.loc 1 97 0
 258              	@ 97 "../src/frame_m0.c" 1
 259 000a 10B4     		PUSH	{r4}
 260              	@ 0 "" 2
  98:../src/frame_m0.c **** 
  99:../src/frame_m0.c **** asm("startSyncM1:");
 261              		.loc 1 99 0
 262              	@ 99 "../src/frame_m0.c" 1
 263              		startSyncM1:
 264              	@ 0 "" 2
 100:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 265              		.loc 1 100 0
 266              	@ 100 "../src/frame_m0.c" 1
 267 000c 0268     		LDR 	r2, [r0]
 268              	@ 0 "" 2
 101:../src/frame_m0.c **** 	asm("NOP");
 269              		.loc 1 101 0
 270              	@ 101 "../src/frame_m0.c" 1
 271 000e C046     		NOP
 272              	@ 0 "" 2
 102:../src/frame_m0.c **** 	asm("NOP");
 273              		.loc 1 102 0
 274              	@ 102 "../src/frame_m0.c" 1
 275 0010 C046     		NOP
 276              	@ 0 "" 2
 103:../src/frame_m0.c **** 	asm("NOP");
 277              		.loc 1 103 0
 278              	@ 103 "../src/frame_m0.c" 1
 279 0012 C046     		NOP
 280              	@ 0 "" 2
 104:../src/frame_m0.c **** 	asm("NOP");
 281              		.loc 1 104 0
 282              	@ 104 "../src/frame_m0.c" 1
 283 0014 C046     		NOP
 284              	@ 0 "" 2
 105:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // low
 285              		.loc 1 105 0
 286              	@ 105 "../src/frame_m0.c" 1
 287 0016 0368     		LDR 	r3, [r0]
 288              	@ 0 "" 2
 106:../src/frame_m0.c **** 	asm("BICS	r2, r3");
 289              		.loc 1 106 0
 290              	@ 106 "../src/frame_m0.c" 1
 291 0018 9A43     		BICS	r2, r3
 292              	@ 0 "" 2
 107:../src/frame_m0.c **** 	asm("NOP");
 293              		.loc 1 107 0
 294              	@ 107 "../src/frame_m0.c" 1
 295 001a C046     		NOP
 296              	@ 0 "" 2
 108:../src/frame_m0.c **** 	asm("NOP");
 297              		.loc 1 108 0
 298              	@ 108 "../src/frame_m0.c" 1
 299 001c C046     		NOP
 300              	@ 0 "" 2
 109:../src/frame_m0.c **** 	asm("NOP");
 301              		.loc 1 109 0
 302              	@ 109 "../src/frame_m0.c" 1
 303 001e C046     		NOP
 304              	@ 0 "" 2
 110:../src/frame_m0.c **** 	asm("LDR 	r3, [r0]"); // high
 305              		.loc 1 110 0
 306              	@ 110 "../src/frame_m0.c" 1
 307 0020 0368     		LDR 	r3, [r0]
 308              	@ 0 "" 2
 111:../src/frame_m0.c **** 	asm("ANDS	r3, r2");
 309              		.loc 1 111 0
 310              	@ 111 "../src/frame_m0.c" 1
 311 0022 1340     		ANDS	r3, r2
 312              	@ 0 "" 2
 112:../src/frame_m0.c **** 	asm("NOP");
 313              		.loc 1 112 0
 314              	@ 112 "../src/frame_m0.c" 1
 315 0024 C046     		NOP
 316              	@ 0 "" 2
 113:../src/frame_m0.c **** 	asm("NOP");
 317              		.loc 1 113 0
 318              	@ 113 "../src/frame_m0.c" 1
 319 0026 C046     		NOP
 320              	@ 0 "" 2
 114:../src/frame_m0.c **** 	asm("NOP");
 321              		.loc 1 114 0
 322              	@ 114 "../src/frame_m0.c" 1
 323 0028 C046     		NOP
 324              	@ 0 "" 2
 115:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 325              		.loc 1 115 0
 326              	@ 115 "../src/frame_m0.c" 1
 327 002a 0268     		LDR 	r2, [r0]
 328              	@ 0 "" 2
 116:../src/frame_m0.c **** 	asm("LDR 	r4, [r0]"); // high
 329              		.loc 1 116 0
 330              	@ 116 "../src/frame_m0.c" 1
 331 002c 0468     		LDR 	r4, [r0]
 332              	@ 0 "" 2
 117:../src/frame_m0.c **** 	asm("BICS 	r4, r2");
 333              		.loc 1 117 0
 334              	@ 117 "../src/frame_m0.c" 1
 335 002e 9443     		BICS 	r4, r2
 336              	@ 0 "" 2
 118:../src/frame_m0.c **** 	asm("NOP");
 337              		.loc 1 118 0
 338              	@ 118 "../src/frame_m0.c" 1
 339 0030 C046     		NOP
 340              	@ 0 "" 2
 119:../src/frame_m0.c **** 	asm("NOP");
 341              		.loc 1 119 0
 342              	@ 119 "../src/frame_m0.c" 1
 343 0032 C046     		NOP
 344              	@ 0 "" 2
 120:../src/frame_m0.c **** 	asm("NOP");
 345              		.loc 1 120 0
 346              	@ 120 "../src/frame_m0.c" 1
 347 0034 C046     		NOP
 348              	@ 0 "" 2
 121:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 349              		.loc 1 121 0
 350              	@ 121 "../src/frame_m0.c" 1
 351 0036 0268     		LDR 	r2, [r0]
 352              	@ 0 "" 2
 122:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 353              		.loc 1 122 0
 354              	@ 122 "../src/frame_m0.c" 1
 355 0038 9443     		BICS	r4, r2
 356              	@ 0 "" 2
 123:../src/frame_m0.c **** 	asm("NOP");
 357              		.loc 1 123 0
 358              	@ 123 "../src/frame_m0.c" 1
 359 003a C046     		NOP
 360              	@ 0 "" 2
 124:../src/frame_m0.c **** 	asm("NOP");
 361              		.loc 1 124 0
 362              	@ 124 "../src/frame_m0.c" 1
 363 003c C046     		NOP
 364              	@ 0 "" 2
 125:../src/frame_m0.c **** 	asm("NOP");
 365              		.loc 1 125 0
 366              	@ 125 "../src/frame_m0.c" 1
 367 003e C046     		NOP
 368              	@ 0 "" 2
 126:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // high
 369              		.loc 1 126 0
 370              	@ 126 "../src/frame_m0.c" 1
 371 0040 0268     		LDR 	r2, [r0]
 372              	@ 0 "" 2
 127:../src/frame_m0.c **** 	asm("ANDS	r4, r2");
 373              		.loc 1 127 0
 374              	@ 127 "../src/frame_m0.c" 1
 375 0042 1440     		ANDS	r4, r2
 376              	@ 0 "" 2
 128:../src/frame_m0.c **** 	asm("NOP");
 377              		.loc 1 128 0
 378              	@ 128 "../src/frame_m0.c" 1
 379 0044 C046     		NOP
 380              	@ 0 "" 2
 129:../src/frame_m0.c **** 	asm("NOP");
 381              		.loc 1 129 0
 382              	@ 129 "../src/frame_m0.c" 1
 383 0046 C046     		NOP
 384              	@ 0 "" 2
 130:../src/frame_m0.c **** 	asm("NOP");
 385              		.loc 1 130 0
 386              	@ 130 "../src/frame_m0.c" 1
 387 0048 C046     		NOP
 388              	@ 0 "" 2
 131:../src/frame_m0.c **** 	asm("LDR 	r2, [r0]"); // low
 389              		.loc 1 131 0
 390              	@ 131 "../src/frame_m0.c" 1
 391 004a 0268     		LDR 	r2, [r0]
 392              	@ 0 "" 2
 132:../src/frame_m0.c **** 	
 133:../src/frame_m0.c **** 	asm("BICS	r4, r2");
 393              		.loc 1 133 0
 394              	@ 133 "../src/frame_m0.c" 1
 395 004c 9443     		BICS	r4, r2
 396              	@ 0 "" 2
 134:../src/frame_m0.c **** 	asm("ANDS	r4, r3");
 397              		.loc 1 134 0
 398              	@ 134 "../src/frame_m0.c" 1
 399 004e 1C40     		ANDS	r4, r3
 400              	@ 0 "" 2
 135:../src/frame_m0.c **** 
 136:../src/frame_m0.c **** 	asm("TST		r4, r1");
 401              		.loc 1 136 0
 402              	@ 136 "../src/frame_m0.c" 1
 403 0050 0C42     		TST		r4, r1
 404              	@ 0 "" 2
 137:../src/frame_m0.c **** 	asm("NOP");		// an extra NOP makes us converge faster, worst case 400 cycles.
 405              		.loc 1 137 0
 406              	@ 137 "../src/frame_m0.c" 1
 407 0052 C046     		NOP
 408              	@ 0 "" 2
 138:../src/frame_m0.c **** 	asm("NOP");
 409              		.loc 1 138 0
 410              	@ 138 "../src/frame_m0.c" 1
 411 0054 C046     		NOP
 412              	@ 0 "" 2
 139:../src/frame_m0.c **** 	asm("NOP");
 413              		.loc 1 139 0
 414              	@ 139 "../src/frame_m0.c" 1
 415 0056 C046     		NOP
 416              	@ 0 "" 2
 140:../src/frame_m0.c **** 	asm("BEQ		startSyncM1");
 417              		.loc 1 140 0
 418              	@ 140 "../src/frame_m0.c" 1
 419 0058 D8D0     		BEQ		startSyncM1
 420              	@ 0 "" 2
 141:../src/frame_m0.c **** 
 142:../src/frame_m0.c **** 	// in-phase begins here
 143:../src/frame_m0.c **** 
 144:../src/frame_m0.c **** 
 145:../src/frame_m0.c **** 	asm("POP   	{r4}");
 421              		.loc 1 145 0
 422              	@ 145 "../src/frame_m0.c" 1
 423 005a 10BC     		POP   	{r4}
 424              	@ 0 "" 2
 146:../src/frame_m0.c **** 
 147:../src/frame_m0.c **** 	asm(".syntax divided");
 425              		.loc 1 147 0
 426              	@ 147 "../src/frame_m0.c" 1
 427              		.syntax divided
 428              	@ 0 "" 2
 148:../src/frame_m0.c **** }
 429              		.loc 1 148 0
 430              		.code	16
 431 005c BD46     		mov	sp, r7
 432 005e 02B0     		add	sp, sp, #8
 433              		@ sp needed
 434 0060 80BD     		pop	{r7, pc}
 435              		.cfi_endproc
 436              	.LFE34:
 438 0062 C046     		.section	.text.lineM0,"ax",%progbits
 439              		.align	2
 440              		.global	lineM0
 441              		.code	16
 442              		.thumb_func
 444              	lineM0:
 445              	.LFB35:
 149:../src/frame_m0.c **** 
 150:../src/frame_m0.c **** 
 151:../src/frame_m0.c **** void lineM0(uint32_t *gpio, uint8_t *memory, uint32_t xoffset, uint32_t xwidth)
 152:../src/frame_m0.c **** {
 446              		.loc 1 152 0
 447              		.cfi_startproc
 448 0000 80B5     		push	{r7, lr}
 449              		.cfi_def_cfa_offset 8
 450              		.cfi_offset 7, -8
 451              		.cfi_offset 14, -4
 452 0002 84B0     		sub	sp, sp, #16
 453              		.cfi_def_cfa_offset 24
 454 0004 00AF     		add	r7, sp, #0
 455              		.cfi_def_cfa_register 7
 456 0006 F860     		str	r0, [r7, #12]
 457 0008 B960     		str	r1, [r7, #8]
 458 000a 7A60     		str	r2, [r7, #4]
 459 000c 3B60     		str	r3, [r7]
 153:../src/frame_m0.c **** //	asm("PRESERVE8");
 154:../src/frame_m0.c **** //	asm("IMPORT callSyncM0");
 155:../src/frame_m0.c **** asm(".syntax unified");
 460              		.loc 1 155 0
 461              	@ 155 "../src/frame_m0.c" 1
 462              		.syntax unified
 463              	@ 0 "" 2
 156:../src/frame_m0.c **** 
 157:../src/frame_m0.c **** 	asm("PUSH	{r4-r5}");
 464              		.loc 1 157 0
 465              	@ 157 "../src/frame_m0.c" 1
 466 000e 30B4     		PUSH	{r4-r5}
 467              	@ 0 "" 2
 158:../src/frame_m0.c **** 
 159:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 160:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 468              		.loc 1 160 0
 469              	@ 160 "../src/frame_m0.c" 1
 470 0010 5B18     		ADDS	r3, r1
 471              	@ 0 "" 2
 161:../src/frame_m0.c **** 	// generate hsync bit
 162:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 472              		.loc 1 162 0
 473              	@ 162 "../src/frame_m0.c" 1
 474 0012 0124     		MOVS	r4, #0x1
 475              	@ 0 "" 2
 163:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 476              		.loc 1 163 0
 477              	@ 163 "../src/frame_m0.c" 1
 478 0014 E402     		LSLS	r4, #11
 479              	@ 0 "" 2
 164:../src/frame_m0.c **** 
 165:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}");	 	// save args
 480              		.loc 1 165 0
 481              	@ 165 "../src/frame_m0.c" 1
 482 0016 0FB4     		PUSH	{r0-r3}
 483              	@ 0 "" 2
 166:../src/frame_m0.c **** 	asm("BL		callSyncM0");	// get pixel sync
 484              		.loc 1 166 0
 485              	@ 166 "../src/frame_m0.c" 1
 486 0018 FFF7FEFF 		BL		callSyncM0
 487              	@ 0 "" 2
 167:../src/frame_m0.c **** 	asm("POP	{r0-r3}");		// restore args
 488              		.loc 1 167 0
 489              	@ 167 "../src/frame_m0.c" 1
 490 001c 0FBC     		POP	{r0-r3}
 491              	@ 0 "" 2
 168:../src/frame_m0.c **** 	   
 169:../src/frame_m0.c **** 	// pixel sync starts here
 170:../src/frame_m0.c **** 
 171:../src/frame_m0.c ****     // these nops are set us up for sampling hsync reliably
 172:../src/frame_m0.c **** 	asm("NOP");
 492              		.loc 1 172 0
 493              	@ 172 "../src/frame_m0.c" 1
 494 001e C046     		NOP
 495              	@ 0 "" 2
 173:../src/frame_m0.c **** 	asm("NOP");
 496              		.loc 1 173 0
 497              	@ 173 "../src/frame_m0.c" 1
 498 0020 C046     		NOP
 499              	@ 0 "" 2
 174:../src/frame_m0.c **** 
 175:../src/frame_m0.c **** 	// wait for hsync to go high
 176:../src/frame_m0.c **** asm("dest21:");
 500              		.loc 1 176 0
 501              	@ 176 "../src/frame_m0.c" 1
 502              		dest21:
 503              	@ 0 "" 2
 177:../src/frame_m0.c ****     asm("LDR 	r5, [r0]");	 	// 2
 504              		.loc 1 177 0
 505              	@ 177 "../src/frame_m0.c" 1
 506 0022 0568     		LDR 	r5, [r0]
 507              	@ 0 "" 2
 178:../src/frame_m0.c **** 	asm("TST	r5, r4");			// 1
 508              		.loc 1 178 0
 509              	@ 178 "../src/frame_m0.c" 1
 510 0024 2542     		TST	r5, r4
 511              	@ 0 "" 2
 179:../src/frame_m0.c **** 	asm("BEQ	dest21");			// 3
 512              		.loc 1 179 0
 513              	@ 179 "../src/frame_m0.c" 1
 514 0026 FCD0     		BEQ	dest21
 515              	@ 0 "" 2
 180:../src/frame_m0.c **** 
 181:../src/frame_m0.c **** 		// skip pixels
 182:../src/frame_m0.c **** asm("dest22:");
 516              		.loc 1 182 0
 517              	@ 182 "../src/frame_m0.c" 1
 518              		dest22:
 519              	@ 0 "" 2
 183:../src/frame_m0.c **** 	asm("SUBS	r2, #0x1");	// 1
 520              		.loc 1 183 0
 521              	@ 183 "../src/frame_m0.c" 1
 522 0028 013A     		SUBS	r2, #0x1
 523              	@ 0 "" 2
 184:../src/frame_m0.c ****     asm("NOP");				// 1
 524              		.loc 1 184 0
 525              	@ 184 "../src/frame_m0.c" 1
 526 002a C046     		NOP
 527              	@ 0 "" 2
 185:../src/frame_m0.c ****     asm("NOP");				// 1
 528              		.loc 1 185 0
 529              	@ 185 "../src/frame_m0.c" 1
 530 002c C046     		NOP
 531              	@ 0 "" 2
 186:../src/frame_m0.c ****     asm("NOP");				// 1
 532              		.loc 1 186 0
 533              	@ 186 "../src/frame_m0.c" 1
 534 002e C046     		NOP
 535              	@ 0 "" 2
 187:../src/frame_m0.c ****     asm("NOP");				// 1
 536              		.loc 1 187 0
 537              	@ 187 "../src/frame_m0.c" 1
 538 0030 C046     		NOP
 539              	@ 0 "" 2
 188:../src/frame_m0.c ****     asm("NOP");				// 1
 540              		.loc 1 188 0
 541              	@ 188 "../src/frame_m0.c" 1
 542 0032 C046     		NOP
 543              	@ 0 "" 2
 189:../src/frame_m0.c ****     asm("NOP");				// 1
 544              		.loc 1 189 0
 545              	@ 189 "../src/frame_m0.c" 1
 546 0034 C046     		NOP
 547              	@ 0 "" 2
 190:../src/frame_m0.c ****     asm("NOP");				// 1
 548              		.loc 1 190 0
 549              	@ 190 "../src/frame_m0.c" 1
 550 0036 C046     		NOP
 551              	@ 0 "" 2
 191:../src/frame_m0.c ****     asm("NOP");				// 1
 552              		.loc 1 191 0
 553              	@ 191 "../src/frame_m0.c" 1
 554 0038 C046     		NOP
 555              	@ 0 "" 2
 192:../src/frame_m0.c ****     asm("BGE	dest22");	// 3
 556              		.loc 1 192 0
 557              	@ 192 "../src/frame_m0.c" 1
 558 003a F5DA     		BGE	dest22
 559              	@ 0 "" 2
 193:../src/frame_m0.c **** 
 194:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 195:../src/frame_m0.c **** 
 196:../src/frame_m0.c ****     asm("LDRB 	r2, [r0]");	 	  // 0
 560              		.loc 1 196 0
 561              	@ 196 "../src/frame_m0.c" 1
 562 003c 0278     		LDRB 	r2, [r0]
 563              	@ 0 "" 2
 197:../src/frame_m0.c ****     asm("STRB 	r2, [r1, #0x00]");
 564              		.loc 1 197 0
 565              	@ 197 "../src/frame_m0.c" 1
 566 003e 0A70     		STRB 	r2, [r1, #0x00]
 567              	@ 0 "" 2
 198:../src/frame_m0.c ****     asm("NOP");
 568              		.loc 1 198 0
 569              	@ 198 "../src/frame_m0.c" 1
 570 0040 C046     		NOP
 571              	@ 0 "" 2
 199:../src/frame_m0.c ****     asm("NOP");
 572              		.loc 1 199 0
 573              	@ 199 "../src/frame_m0.c" 1
 574 0042 C046     		NOP
 575              	@ 0 "" 2
 200:../src/frame_m0.c **** 
 201:../src/frame_m0.c ****     asm("LDRB 	r2, [r0]");	 	  // 0
 576              		.loc 1 201 0
 577              	@ 201 "../src/frame_m0.c" 1
 578 0044 0278     		LDRB 	r2, [r0]
 579              	@ 0 "" 2
 202:../src/frame_m0.c ****     asm("STRB 	r2, [r1, #0x01]");
 580              		.loc 1 202 0
 581              	@ 202 "../src/frame_m0.c" 1
 582 0046 4A70     		STRB 	r2, [r1, #0x01]
 583              	@ 0 "" 2
 203:../src/frame_m0.c ****     asm("NOP");
 584              		.loc 1 203 0
 585              	@ 203 "../src/frame_m0.c" 1
 586 0048 C046     		NOP
 587              	@ 0 "" 2
 204:../src/frame_m0.c ****     asm("NOP");
 588              		.loc 1 204 0
 589              	@ 204 "../src/frame_m0.c" 1
 590 004a C046     		NOP
 591              	@ 0 "" 2
 205:../src/frame_m0.c **** 
 206:../src/frame_m0.c **** asm("loop11:");
 592              		.loc 1 206 0
 593              	@ 206 "../src/frame_m0.c" 1
 594              		loop11:
 595              	@ 0 "" 2
 207:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]"); 	  // 0
 596              		.loc 1 207 0
 597              	@ 207 "../src/frame_m0.c" 1
 598 004c 0278     		LDRB 	r2, [r0]
 599              	@ 0 "" 2
 208:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x2]");
 600              		.loc 1 208 0
 601              	@ 208 "../src/frame_m0.c" 1
 602 004e 8A70     		STRB 	r2, [r1, #0x2]
 603              	@ 0 "" 2
 209:../src/frame_m0.c **** 
 210:../src/frame_m0.c **** 	asm("ADDS	r1, #0x03");
 604              		.loc 1 210 0
 605              	@ 210 "../src/frame_m0.c" 1
 606 0050 0331     		ADDS	r1, #0x03
 607              	@ 0 "" 2
 211:../src/frame_m0.c **** 	asm("NOP");
 608              		.loc 1 211 0
 609              	@ 211 "../src/frame_m0.c" 1
 610 0052 C046     		NOP
 611              	@ 0 "" 2
 212:../src/frame_m0.c **** 
 213:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");	  // 0
 612              		.loc 1 213 0
 613              	@ 213 "../src/frame_m0.c" 1
 614 0054 0278     		LDRB 	r2, [r0]
 615              	@ 0 "" 2
 214:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x0]");
 616              		.loc 1 214 0
 617              	@ 214 "../src/frame_m0.c" 1
 618 0056 0A70     		STRB 	r2, [r1, #0x0]
 619              	@ 0 "" 2
 215:../src/frame_m0.c **** 
 216:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 620              		.loc 1 216 0
 621              	@ 216 "../src/frame_m0.c" 1
 622 0058 9942     		CMP	r1, r3
 623              	@ 0 "" 2
 217:../src/frame_m0.c **** 
 218:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");	  // -1
 624              		.loc 1 218 0
 625              	@ 218 "../src/frame_m0.c" 1
 626 005a 0278     		LDRB 	r2, [r0]
 627              	@ 0 "" 2
 219:../src/frame_m0.c **** 	asm("STRB 	r2, [r1, #0x1]");
 628              		.loc 1 219 0
 629              	@ 219 "../src/frame_m0.c" 1
 630 005c 4A70     		STRB 	r2, [r1, #0x1]
 631              	@ 0 "" 2
 220:../src/frame_m0.c **** 
 221:../src/frame_m0.c **** 	asm("BLT	loop11");
 632              		.loc 1 221 0
 633              	@ 221 "../src/frame_m0.c" 1
 634 005e F5DB     		BLT	loop11
 635              	@ 0 "" 2
 222:../src/frame_m0.c **** 
 223:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 224:../src/frame_m0.c **** asm("dest13:");
 636              		.loc 1 224 0
 637              	@ 224 "../src/frame_m0.c" 1
 638              		dest13:
 639              	@ 0 "" 2
 225:../src/frame_m0.c ****     asm("LDR 	r5, [r0]"); 	// 2
 640              		.loc 1 225 0
 641              	@ 225 "../src/frame_m0.c" 1
 642 0060 0568     		LDR 	r5, [r0]
 643              	@ 0 "" 2
 226:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 644              		.loc 1 226 0
 645              	@ 226 "../src/frame_m0.c" 1
 646 0062 2542     		TST	r5, r4
 647              	@ 0 "" 2
 227:../src/frame_m0.c **** 	asm("BNE	dest13");		// 3
 648              		.loc 1 227 0
 649              	@ 227 "../src/frame_m0.c" 1
 650 0064 FCD1     		BNE	dest13
 651              	@ 0 "" 2
 228:../src/frame_m0.c **** 
 229:../src/frame_m0.c **** 	asm("POP	{r4-r5}");
 652              		.loc 1 229 0
 653              	@ 229 "../src/frame_m0.c" 1
 654 0066 30BC     		POP	{r4-r5}
 655              	@ 0 "" 2
 230:../src/frame_m0.c **** 
 231:../src/frame_m0.c **** 	asm(".syntax divided");
 656              		.loc 1 231 0
 657              	@ 231 "../src/frame_m0.c" 1
 658              		.syntax divided
 659              	@ 0 "" 2
 232:../src/frame_m0.c **** }
 660              		.loc 1 232 0
 661              		.code	16
 662 0068 BD46     		mov	sp, r7
 663 006a 04B0     		add	sp, sp, #16
 664              		@ sp needed
 665 006c 80BD     		pop	{r7, pc}
 666              		.cfi_endproc
 667              	.LFE35:
 669 006e C046     		.section	.text.lineM1R1,"ax",%progbits
 670              		.align	2
 671              		.global	lineM1R1
 672              		.code	16
 673              		.thumb_func
 675              	lineM1R1:
 676              	.LFB36:
 233:../src/frame_m0.c **** 
 234:../src/frame_m0.c **** 
 235:../src/frame_m0.c **** void lineM1R1(uint32_t *gpio, uint8_t *memory, uint32_t xoffset, uint32_t xwidth)
 236:../src/frame_m0.c **** {
 677              		.loc 1 236 0
 678              		.cfi_startproc
 679 0000 80B5     		push	{r7, lr}
 680              		.cfi_def_cfa_offset 8
 681              		.cfi_offset 7, -8
 682              		.cfi_offset 14, -4
 683 0002 84B0     		sub	sp, sp, #16
 684              		.cfi_def_cfa_offset 24
 685 0004 00AF     		add	r7, sp, #0
 686              		.cfi_def_cfa_register 7
 687 0006 F860     		str	r0, [r7, #12]
 688 0008 B960     		str	r1, [r7, #8]
 689 000a 7A60     		str	r2, [r7, #4]
 690 000c 3B60     		str	r3, [r7]
 237:../src/frame_m0.c **** //	asm("PRESERVE8");
 238:../src/frame_m0.c **** //	asm("IMPORT	callSyncM1");
 239:../src/frame_m0.c **** asm(".syntax unified");
 691              		.loc 1 239 0
 692              	@ 239 "../src/frame_m0.c" 1
 693              		.syntax unified
 694              	@ 0 "" 2
 240:../src/frame_m0.c **** 
 241:../src/frame_m0.c **** 	asm("PUSH	{r4-r5}");
 695              		.loc 1 241 0
 696              	@ 241 "../src/frame_m0.c" 1
 697 000e 30B4     		PUSH	{r4-r5}
 698              	@ 0 "" 2
 242:../src/frame_m0.c **** 
 243:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 244:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 699              		.loc 1 244 0
 700              	@ 244 "../src/frame_m0.c" 1
 701 0010 5B18     		ADDS	r3, r1
 702              	@ 0 "" 2
 245:../src/frame_m0.c **** 	// generate hsync bit
 246:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 703              		.loc 1 246 0
 704              	@ 246 "../src/frame_m0.c" 1
 705 0012 0124     		MOVS	r4, #0x1
 706              	@ 0 "" 2
 247:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 707              		.loc 1 247 0
 708              	@ 247 "../src/frame_m0.c" 1
 709 0014 E402     		LSLS	r4, #11
 710              	@ 0 "" 2
 248:../src/frame_m0.c **** 
 249:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 711              		.loc 1 249 0
 712              	@ 249 "../src/frame_m0.c" 1
 713 0016 0FB4     		PUSH	{r0-r3}
 714              	@ 0 "" 2
 250:../src/frame_m0.c **** 	asm("BL 	callSyncM1"); // get pixel sync
 715              		.loc 1 250 0
 716              	@ 250 "../src/frame_m0.c" 1
 717 0018 FFF7FEFF 		BL 	callSyncM1
 718              	@ 0 "" 2
 251:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 719              		.loc 1 251 0
 720              	@ 251 "../src/frame_m0.c" 1
 721 001c 0FBC     		POP	{r0-r3}
 722              	@ 0 "" 2
 252:../src/frame_m0.c **** 	   
 253:../src/frame_m0.c **** 	// pixel sync starts here
 254:../src/frame_m0.c **** 
 255:../src/frame_m0.c **** 	// wait for hsync to go high
 256:../src/frame_m0.c **** asm("dest1:");
 723              		.loc 1 256 0
 724              	@ 256 "../src/frame_m0.c" 1
 725              		dest1:
 726              	@ 0 "" 2
 257:../src/frame_m0.c ****     asm("LDR	r5, [r0]"); // 2
 727              		.loc 1 257 0
 728              	@ 257 "../src/frame_m0.c" 1
 729 001e 0568     		LDR	r5, [r0]
 730              	@ 0 "" 2
 258:../src/frame_m0.c **** 	asm("TST	r5, r4");	// 1
 731              		.loc 1 258 0
 732              	@ 258 "../src/frame_m0.c" 1
 733 0020 2542     		TST	r5, r4
 734              	@ 0 "" 2
 259:../src/frame_m0.c **** 	asm("BEQ	dest1");	// 3
 735              		.loc 1 259 0
 736              	@ 259 "../src/frame_m0.c" 1
 737 0022 FCD0     		BEQ	dest1
 738              	@ 0 "" 2
 260:../src/frame_m0.c **** 
 261:../src/frame_m0.c **** 	// skip pixels
 262:../src/frame_m0.c **** asm("dest2:");
 739              		.loc 1 262 0
 740              	@ 262 "../src/frame_m0.c" 1
 741              		dest2:
 742              	@ 0 "" 2
 263:../src/frame_m0.c **** 	asm("SUBS	r2, #0x1");	// 1
 743              		.loc 1 263 0
 744              	@ 263 "../src/frame_m0.c" 1
 745 0024 013A     		SUBS	r2, #0x1
 746              	@ 0 "" 2
 264:../src/frame_m0.c **** 	asm("NOP");				// 1
 747              		.loc 1 264 0
 748              	@ 264 "../src/frame_m0.c" 1
 749 0026 C046     		NOP
 750              	@ 0 "" 2
 265:../src/frame_m0.c **** 	asm("NOP");				// 1
 751              		.loc 1 265 0
 752              	@ 265 "../src/frame_m0.c" 1
 753 0028 C046     		NOP
 754              	@ 0 "" 2
 266:../src/frame_m0.c **** 	asm("NOP");				// 1
 755              		.loc 1 266 0
 756              	@ 266 "../src/frame_m0.c" 1
 757 002a C046     		NOP
 758              	@ 0 "" 2
 267:../src/frame_m0.c **** 	asm("NOP");				// 1
 759              		.loc 1 267 0
 760              	@ 267 "../src/frame_m0.c" 1
 761 002c C046     		NOP
 762              	@ 0 "" 2
 268:../src/frame_m0.c **** 	asm("NOP");				// 1
 763              		.loc 1 268 0
 764              	@ 268 "../src/frame_m0.c" 1
 765 002e C046     		NOP
 766              	@ 0 "" 2
 269:../src/frame_m0.c **** 	asm("NOP");				// 1
 767              		.loc 1 269 0
 768              	@ 269 "../src/frame_m0.c" 1
 769 0030 C046     		NOP
 770              	@ 0 "" 2
 270:../src/frame_m0.c **** 	asm("NOP");				// 1
 771              		.loc 1 270 0
 772              	@ 270 "../src/frame_m0.c" 1
 773 0032 C046     		NOP
 774              	@ 0 "" 2
 271:../src/frame_m0.c **** 	asm("NOP");				// 1
 775              		.loc 1 271 0
 776              	@ 271 "../src/frame_m0.c" 1
 777 0034 C046     		NOP
 778              	@ 0 "" 2
 272:../src/frame_m0.c **** 	asm("NOP");				// 1
 779              		.loc 1 272 0
 780              	@ 272 "../src/frame_m0.c" 1
 781 0036 C046     		NOP
 782              	@ 0 "" 2
 273:../src/frame_m0.c **** 	asm("NOP");				// 1
 783              		.loc 1 273 0
 784              	@ 273 "../src/frame_m0.c" 1
 785 0038 C046     		NOP
 786              	@ 0 "" 2
 274:../src/frame_m0.c **** 	asm("NOP");				// 1
 787              		.loc 1 274 0
 788              	@ 274 "../src/frame_m0.c" 1
 789 003a C046     		NOP
 790              	@ 0 "" 2
 275:../src/frame_m0.c **** 	asm("NOP");				// 1
 791              		.loc 1 275 0
 792              	@ 275 "../src/frame_m0.c" 1
 793 003c C046     		NOP
 794              	@ 0 "" 2
 276:../src/frame_m0.c **** 	asm("NOP");				// 1
 795              		.loc 1 276 0
 796              	@ 276 "../src/frame_m0.c" 1
 797 003e C046     		NOP
 798              	@ 0 "" 2
 277:../src/frame_m0.c **** 	asm("NOP");				// 1
 799              		.loc 1 277 0
 800              	@ 277 "../src/frame_m0.c" 1
 801 0040 C046     		NOP
 802              	@ 0 "" 2
 278:../src/frame_m0.c **** 	asm("NOP");				// 1
 803              		.loc 1 278 0
 804              	@ 278 "../src/frame_m0.c" 1
 805 0042 C046     		NOP
 806              	@ 0 "" 2
 279:../src/frame_m0.c **** 	asm("NOP");				// 1
 807              		.loc 1 279 0
 808              	@ 279 "../src/frame_m0.c" 1
 809 0044 C046     		NOP
 810              	@ 0 "" 2
 280:../src/frame_m0.c **** 	asm("NOP");				// 1
 811              		.loc 1 280 0
 812              	@ 280 "../src/frame_m0.c" 1
 813 0046 C046     		NOP
 814              	@ 0 "" 2
 281:../src/frame_m0.c **** 	asm("NOP");				// 1
 815              		.loc 1 281 0
 816              	@ 281 "../src/frame_m0.c" 1
 817 0048 C046     		NOP
 818              	@ 0 "" 2
 282:../src/frame_m0.c **** 	asm("NOP");				// 1
 819              		.loc 1 282 0
 820              	@ 282 "../src/frame_m0.c" 1
 821 004a C046     		NOP
 822              	@ 0 "" 2
 283:../src/frame_m0.c **** 	asm("NOP");				// 1
 823              		.loc 1 283 0
 824              	@ 283 "../src/frame_m0.c" 1
 825 004c C046     		NOP
 826              	@ 0 "" 2
 284:../src/frame_m0.c **** 	asm("BGE	dest2");		// 3
 827              		.loc 1 284 0
 828              	@ 284 "../src/frame_m0.c" 1
 829 004e E9DA     		BGE	dest2
 830              	@ 0 "" 2
 285:../src/frame_m0.c **** 
 286:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 287:../src/frame_m0.c **** 	asm("NOP");
 831              		.loc 1 287 0
 832              	@ 287 "../src/frame_m0.c" 1
 833 0050 C046     		NOP
 834              	@ 0 "" 2
 288:../src/frame_m0.c **** 	asm("NOP");
 835              		.loc 1 288 0
 836              	@ 288 "../src/frame_m0.c" 1
 837 0052 C046     		NOP
 838              	@ 0 "" 2
 289:../src/frame_m0.c **** 
 290:../src/frame_m0.c **** asm("loop1:");
 839              		.loc 1 290 0
 840              	@ 290 "../src/frame_m0.c" 1
 841              		loop1:
 842              	@ 0 "" 2
 291:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");
 843              		.loc 1 291 0
 844              	@ 291 "../src/frame_m0.c" 1
 845 0054 0278     		LDRB 	r2, [r0]
 846              	@ 0 "" 2
 292:../src/frame_m0.c **** 	asm("STRB 	r2, [r1]");
 847              		.loc 1 292 0
 848              	@ 292 "../src/frame_m0.c" 1
 849 0056 0A70     		STRB 	r2, [r1]
 850              	@ 0 "" 2
 293:../src/frame_m0.c **** 	asm("NOP");
 851              		.loc 1 293 0
 852              	@ 293 "../src/frame_m0.c" 1
 853 0058 C046     		NOP
 854              	@ 0 "" 2
 294:../src/frame_m0.c **** 	asm("NOP");
 855              		.loc 1 294 0
 856              	@ 294 "../src/frame_m0.c" 1
 857 005a C046     		NOP
 858              	@ 0 "" 2
 295:../src/frame_m0.c **** 	asm("NOP");
 859              		.loc 1 295 0
 860              	@ 295 "../src/frame_m0.c" 1
 861 005c C046     		NOP
 862              	@ 0 "" 2
 296:../src/frame_m0.c **** 	asm("ADDS	r1, #0x01");
 863              		.loc 1 296 0
 864              	@ 296 "../src/frame_m0.c" 1
 865 005e 0131     		ADDS	r1, #0x01
 866              	@ 0 "" 2
 297:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 867              		.loc 1 297 0
 868              	@ 297 "../src/frame_m0.c" 1
 869 0060 9942     		CMP	r1, r3
 870              	@ 0 "" 2
 298:../src/frame_m0.c **** 	asm("BLT	loop1");
 871              		.loc 1 298 0
 872              	@ 298 "../src/frame_m0.c" 1
 873 0062 F7DB     		BLT	loop1
 874              	@ 0 "" 2
 299:../src/frame_m0.c **** 
 300:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 301:../src/frame_m0.c **** asm("dest3:");
 875              		.loc 1 301 0
 876              	@ 301 "../src/frame_m0.c" 1
 877              		dest3:
 878              	@ 0 "" 2
 302:../src/frame_m0.c ****     asm("LDR 	r5, [r0]"); 	// 2
 879              		.loc 1 302 0
 880              	@ 302 "../src/frame_m0.c" 1
 881 0064 0568     		LDR 	r5, [r0]
 882              	@ 0 "" 2
 303:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 883              		.loc 1 303 0
 884              	@ 303 "../src/frame_m0.c" 1
 885 0066 2542     		TST	r5, r4
 886              	@ 0 "" 2
 304:../src/frame_m0.c **** 	asm("BNE	dest3");		// 3
 887              		.loc 1 304 0
 888              	@ 304 "../src/frame_m0.c" 1
 889 0068 FCD1     		BNE	dest3
 890              	@ 0 "" 2
 305:../src/frame_m0.c **** 
 306:../src/frame_m0.c **** 	asm("POP	{r4-r5}");
 891              		.loc 1 306 0
 892              	@ 306 "../src/frame_m0.c" 1
 893 006a 30BC     		POP	{r4-r5}
 894              	@ 0 "" 2
 307:../src/frame_m0.c **** 
 308:../src/frame_m0.c **** 	asm(".syntax divided");
 895              		.loc 1 308 0
 896              	@ 308 "../src/frame_m0.c" 1
 897              		.syntax divided
 898              	@ 0 "" 2
 309:../src/frame_m0.c **** }
 899              		.loc 1 309 0
 900              		.code	16
 901 006c BD46     		mov	sp, r7
 902 006e 04B0     		add	sp, sp, #16
 903              		@ sp needed
 904 0070 80BD     		pop	{r7, pc}
 905              		.cfi_endproc
 906              	.LFE36:
 908 0072 C046     		.section	.text.lineM1R2,"ax",%progbits
 909              		.align	2
 910              		.global	lineM1R2
 911              		.code	16
 912              		.thumb_func
 914              	lineM1R2:
 915              	.LFB37:
 310:../src/frame_m0.c **** 
 311:../src/frame_m0.c **** 
 312:../src/frame_m0.c **** void lineM1R2(uint32_t *gpio, uint16_t *memory, uint32_t xoffset, uint32_t xwidth)
 313:../src/frame_m0.c **** {
 916              		.loc 1 313 0
 917              		.cfi_startproc
 918 0000 80B5     		push	{r7, lr}
 919              		.cfi_def_cfa_offset 8
 920              		.cfi_offset 7, -8
 921              		.cfi_offset 14, -4
 922 0002 84B0     		sub	sp, sp, #16
 923              		.cfi_def_cfa_offset 24
 924 0004 00AF     		add	r7, sp, #0
 925              		.cfi_def_cfa_register 7
 926 0006 F860     		str	r0, [r7, #12]
 927 0008 B960     		str	r1, [r7, #8]
 928 000a 7A60     		str	r2, [r7, #4]
 929 000c 3B60     		str	r3, [r7]
 314:../src/frame_m0.c **** //	asm("PRESERVE8");
 315:../src/frame_m0.c **** //	asm("IMPORT callSyncM1");
 316:../src/frame_m0.c **** asm(".syntax unified");
 930              		.loc 1 316 0
 931              	@ 316 "../src/frame_m0.c" 1
 932              		.syntax unified
 933              	@ 0 "" 2
 317:../src/frame_m0.c **** 
 318:../src/frame_m0.c **** 	asm("PUSH	{r4-r6}");
 934              		.loc 1 318 0
 935              	@ 318 "../src/frame_m0.c" 1
 936 000e 70B4     		PUSH	{r4-r6}
 937              	@ 0 "" 2
 319:../src/frame_m0.c **** 
 320:../src/frame_m0.c **** 	// add width to memory pointer so we can compare
 321:../src/frame_m0.c **** 	asm("LSLS	r3, #1");
 938              		.loc 1 321 0
 939              	@ 321 "../src/frame_m0.c" 1
 940 0010 5B00     		LSLS	r3, #1
 941              	@ 0 "" 2
 322:../src/frame_m0.c **** 	asm("ADDS	r3, r1");
 942              		.loc 1 322 0
 943              	@ 322 "../src/frame_m0.c" 1
 944 0012 5B18     		ADDS	r3, r1
 945              	@ 0 "" 2
 323:../src/frame_m0.c **** 	// generate hsync bit
 324:../src/frame_m0.c **** 	asm("MOVS	r4, #0x1");
 946              		.loc 1 324 0
 947              	@ 324 "../src/frame_m0.c" 1
 948 0014 0124     		MOVS	r4, #0x1
 949              	@ 0 "" 2
 325:../src/frame_m0.c **** 	asm("LSLS	r4, #11");
 950              		.loc 1 325 0
 951              	@ 325 "../src/frame_m0.c" 1
 952 0016 E402     		LSLS	r4, #11
 953              	@ 0 "" 2
 326:../src/frame_m0.c **** 
 327:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 954              		.loc 1 327 0
 955              	@ 327 "../src/frame_m0.c" 1
 956 0018 0FB4     		PUSH	{r0-r3}
 957              	@ 0 "" 2
 328:../src/frame_m0.c **** 	asm("BL		callSyncM1"); // get pixel sync
 958              		.loc 1 328 0
 959              	@ 328 "../src/frame_m0.c" 1
 960 001a FFF7FEFF 		BL		callSyncM1
 961              	@ 0 "" 2
 329:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 962              		.loc 1 329 0
 963              	@ 329 "../src/frame_m0.c" 1
 964 001e 0FBC     		POP	{r0-r3}
 965              	@ 0 "" 2
 330:../src/frame_m0.c **** 	   
 331:../src/frame_m0.c **** 	// pixel sync starts here
 332:../src/frame_m0.c **** asm("dest7:");
 966              		.loc 1 332 0
 967              	@ 332 "../src/frame_m0.c" 1
 968              		dest7:
 969              	@ 0 "" 2
 333:../src/frame_m0.c ****    asm("LDR 	r5, [r0]"); // 2
 970              		.loc 1 333 0
 971              	@ 333 "../src/frame_m0.c" 1
 972 0020 0568     		LDR 	r5, [r0]
 973              	@ 0 "" 2
 334:../src/frame_m0.c ****    asm("TST		r5, r4");	// 1
 974              		.loc 1 334 0
 975              	@ 334 "../src/frame_m0.c" 1
 976 0022 2542     		TST		r5, r4
 977              	@ 0 "" 2
 335:../src/frame_m0.c ****    asm("BEQ		dest7");	// 3
 978              		.loc 1 335 0
 979              	@ 335 "../src/frame_m0.c" 1
 980 0024 FCD0     		BEQ		dest7
 981              	@ 0 "" 2
 336:../src/frame_m0.c **** 
 337:../src/frame_m0.c ****    // skip pixels
 338:../src/frame_m0.c **** asm("dest8:");
 982              		.loc 1 338 0
 983              	@ 338 "../src/frame_m0.c" 1
 984              		dest8:
 985              	@ 0 "" 2
 339:../src/frame_m0.c ****     asm("SUBS	r2, #0x1");	// 1
 986              		.loc 1 339 0
 987              	@ 339 "../src/frame_m0.c" 1
 988 0026 013A     		SUBS	r2, #0x1
 989              	@ 0 "" 2
 340:../src/frame_m0.c **** 	asm("NOP");				// 1
 990              		.loc 1 340 0
 991              	@ 340 "../src/frame_m0.c" 1
 992 0028 C046     		NOP
 993              	@ 0 "" 2
 341:../src/frame_m0.c **** 	asm("NOP");				// 1
 994              		.loc 1 341 0
 995              	@ 341 "../src/frame_m0.c" 1
 996 002a C046     		NOP
 997              	@ 0 "" 2
 342:../src/frame_m0.c **** 	asm("NOP");				// 1
 998              		.loc 1 342 0
 999              	@ 342 "../src/frame_m0.c" 1
 1000 002c C046     		NOP
 1001              	@ 0 "" 2
 343:../src/frame_m0.c **** 	asm("NOP");				// 1
 1002              		.loc 1 343 0
 1003              	@ 343 "../src/frame_m0.c" 1
 1004 002e C046     		NOP
 1005              	@ 0 "" 2
 344:../src/frame_m0.c **** 	asm("NOP");				// 1
 1006              		.loc 1 344 0
 1007              	@ 344 "../src/frame_m0.c" 1
 1008 0030 C046     		NOP
 1009              	@ 0 "" 2
 345:../src/frame_m0.c **** 	asm("NOP");				// 1
 1010              		.loc 1 345 0
 1011              	@ 345 "../src/frame_m0.c" 1
 1012 0032 C046     		NOP
 1013              	@ 0 "" 2
 346:../src/frame_m0.c **** 	asm("NOP");				// 1
 1014              		.loc 1 346 0
 1015              	@ 346 "../src/frame_m0.c" 1
 1016 0034 C046     		NOP
 1017              	@ 0 "" 2
 347:../src/frame_m0.c **** 	asm("NOP");				// 1
 1018              		.loc 1 347 0
 1019              	@ 347 "../src/frame_m0.c" 1
 1020 0036 C046     		NOP
 1021              	@ 0 "" 2
 348:../src/frame_m0.c **** 	asm("NOP");				// 1
 1022              		.loc 1 348 0
 1023              	@ 348 "../src/frame_m0.c" 1
 1024 0038 C046     		NOP
 1025              	@ 0 "" 2
 349:../src/frame_m0.c **** 	asm("NOP");				// 1
 1026              		.loc 1 349 0
 1027              	@ 349 "../src/frame_m0.c" 1
 1028 003a C046     		NOP
 1029              	@ 0 "" 2
 350:../src/frame_m0.c **** 	asm("NOP");				// 1
 1030              		.loc 1 350 0
 1031              	@ 350 "../src/frame_m0.c" 1
 1032 003c C046     		NOP
 1033              	@ 0 "" 2
 351:../src/frame_m0.c **** 	asm("NOP");				// 1
 1034              		.loc 1 351 0
 1035              	@ 351 "../src/frame_m0.c" 1
 1036 003e C046     		NOP
 1037              	@ 0 "" 2
 352:../src/frame_m0.c **** 	asm("NOP");				// 1
 1038              		.loc 1 352 0
 1039              	@ 352 "../src/frame_m0.c" 1
 1040 0040 C046     		NOP
 1041              	@ 0 "" 2
 353:../src/frame_m0.c **** 	asm("NOP");				// 1
 1042              		.loc 1 353 0
 1043              	@ 353 "../src/frame_m0.c" 1
 1044 0042 C046     		NOP
 1045              	@ 0 "" 2
 354:../src/frame_m0.c **** 	asm("NOP");				// 1
 1046              		.loc 1 354 0
 1047              	@ 354 "../src/frame_m0.c" 1
 1048 0044 C046     		NOP
 1049              	@ 0 "" 2
 355:../src/frame_m0.c **** 	asm("NOP");				// 1
 1050              		.loc 1 355 0
 1051              	@ 355 "../src/frame_m0.c" 1
 1052 0046 C046     		NOP
 1053              	@ 0 "" 2
 356:../src/frame_m0.c **** 	asm("NOP");				// 1
 1054              		.loc 1 356 0
 1055              	@ 356 "../src/frame_m0.c" 1
 1056 0048 C046     		NOP
 1057              	@ 0 "" 2
 357:../src/frame_m0.c **** 	asm("NOP");				// 1
 1058              		.loc 1 357 0
 1059              	@ 357 "../src/frame_m0.c" 1
 1060 004a C046     		NOP
 1061              	@ 0 "" 2
 358:../src/frame_m0.c **** 	asm("NOP");				// 1
 1062              		.loc 1 358 0
 1063              	@ 358 "../src/frame_m0.c" 1
 1064 004c C046     		NOP
 1065              	@ 0 "" 2
 359:../src/frame_m0.c **** 	asm("NOP");				// 1
 1066              		.loc 1 359 0
 1067              	@ 359 "../src/frame_m0.c" 1
 1068 004e C046     		NOP
 1069              	@ 0 "" 2
 360:../src/frame_m0.c **** 	asm("BGE	dest8");		// 3
 1070              		.loc 1 360 0
 1071              	@ 360 "../src/frame_m0.c" 1
 1072 0050 E9DA     		BGE	dest8
 1073              	@ 0 "" 2
 361:../src/frame_m0.c **** 
 362:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 363:../src/frame_m0.c **** 	asm("NOP");
 1074              		.loc 1 363 0
 1075              	@ 363 "../src/frame_m0.c" 1
 1076 0052 C046     		NOP
 1077              	@ 0 "" 2
 364:../src/frame_m0.c **** 	asm("NOP");
 1078              		.loc 1 364 0
 1079              	@ 364 "../src/frame_m0.c" 1
 1080 0054 C046     		NOP
 1081              	@ 0 "" 2
 365:../src/frame_m0.c **** 
 366:../src/frame_m0.c **** asm("loop3:");
 1082              		.loc 1 366 0
 1083              	@ 366 "../src/frame_m0.c" 1
 1084              		loop3:
 1085              	@ 0 "" 2
 367:../src/frame_m0.c **** 	asm("LDRB 	r2, [r0]");
 1086              		.loc 1 367 0
 1087              	@ 367 "../src/frame_m0.c" 1
 1088 0056 0278     		LDRB 	r2, [r0]
 1089              	@ 0 "" 2
 368:../src/frame_m0.c **** 	asm("NOP");
 1090              		.loc 1 368 0
 1091              	@ 368 "../src/frame_m0.c" 1
 1092 0058 C046     		NOP
 1093              	@ 0 "" 2
 369:../src/frame_m0.c **** 	asm("NOP");
 1094              		.loc 1 369 0
 1095              	@ 369 "../src/frame_m0.c" 1
 1096 005a C046     		NOP
 1097              	@ 0 "" 2
 370:../src/frame_m0.c **** 	asm("NOP");
 1098              		.loc 1 370 0
 1099              	@ 370 "../src/frame_m0.c" 1
 1100 005c C046     		NOP
 1101              	@ 0 "" 2
 371:../src/frame_m0.c **** 	asm("NOP");
 1102              		.loc 1 371 0
 1103              	@ 371 "../src/frame_m0.c" 1
 1104 005e C046     		NOP
 1105              	@ 0 "" 2
 372:../src/frame_m0.c **** 	asm("NOP");
 1106              		.loc 1 372 0
 1107              	@ 372 "../src/frame_m0.c" 1
 1108 0060 C046     		NOP
 1109              	@ 0 "" 2
 373:../src/frame_m0.c **** 	asm("NOP");
 1110              		.loc 1 373 0
 1111              	@ 373 "../src/frame_m0.c" 1
 1112 0062 C046     		NOP
 1113              	@ 0 "" 2
 374:../src/frame_m0.c **** 	asm("NOP");
 1114              		.loc 1 374 0
 1115              	@ 374 "../src/frame_m0.c" 1
 1116 0064 C046     		NOP
 1117              	@ 0 "" 2
 375:../src/frame_m0.c **** 	asm("NOP");
 1118              		.loc 1 375 0
 1119              	@ 375 "../src/frame_m0.c" 1
 1120 0066 C046     		NOP
 1121              	@ 0 "" 2
 376:../src/frame_m0.c **** 	asm("NOP");
 1122              		.loc 1 376 0
 1123              	@ 376 "../src/frame_m0.c" 1
 1124 0068 C046     		NOP
 1125              	@ 0 "" 2
 377:../src/frame_m0.c **** 	asm("NOP");
 1126              		.loc 1 377 0
 1127              	@ 377 "../src/frame_m0.c" 1
 1128 006a C046     		NOP
 1129              	@ 0 "" 2
 378:../src/frame_m0.c **** 
 379:../src/frame_m0.c **** 	asm("LDRB 	r5, [r0]");
 1130              		.loc 1 379 0
 1131              	@ 379 "../src/frame_m0.c" 1
 1132 006c 0578     		LDRB 	r5, [r0]
 1133              	@ 0 "" 2
 380:../src/frame_m0.c ****     asm("NOP");
 1134              		.loc 1 380 0
 1135              	@ 380 "../src/frame_m0.c" 1
 1136 006e C046     		NOP
 1137              	@ 0 "" 2
 381:../src/frame_m0.c **** 	asm("NOP");
 1138              		.loc 1 381 0
 1139              	@ 381 "../src/frame_m0.c" 1
 1140 0070 C046     		NOP
 1141              	@ 0 "" 2
 382:../src/frame_m0.c **** 	asm("NOP");
 1142              		.loc 1 382 0
 1143              	@ 382 "../src/frame_m0.c" 1
 1144 0072 C046     		NOP
 1145              	@ 0 "" 2
 383:../src/frame_m0.c **** 	asm("NOP");
 1146              		.loc 1 383 0
 1147              	@ 383 "../src/frame_m0.c" 1
 1148 0074 C046     		NOP
 1149              	@ 0 "" 2
 384:../src/frame_m0.c **** 	asm("NOP");
 1150              		.loc 1 384 0
 1151              	@ 384 "../src/frame_m0.c" 1
 1152 0076 C046     		NOP
 1153              	@ 0 "" 2
 385:../src/frame_m0.c **** 	asm("NOP");
 1154              		.loc 1 385 0
 1155              	@ 385 "../src/frame_m0.c" 1
 1156 0078 C046     		NOP
 1157              	@ 0 "" 2
 386:../src/frame_m0.c **** 	asm("NOP");
 1158              		.loc 1 386 0
 1159              	@ 386 "../src/frame_m0.c" 1
 1160 007a C046     		NOP
 1161              	@ 0 "" 2
 387:../src/frame_m0.c **** 	asm("NOP");
 1162              		.loc 1 387 0
 1163              	@ 387 "../src/frame_m0.c" 1
 1164 007c C046     		NOP
 1165              	@ 0 "" 2
 388:../src/frame_m0.c **** 	asm("NOP");
 1166              		.loc 1 388 0
 1167              	@ 388 "../src/frame_m0.c" 1
 1168 007e C046     		NOP
 1169              	@ 0 "" 2
 389:../src/frame_m0.c **** 	asm("NOP");
 1170              		.loc 1 389 0
 1171              	@ 389 "../src/frame_m0.c" 1
 1172 0080 C046     		NOP
 1173              	@ 0 "" 2
 390:../src/frame_m0.c **** 
 391:../src/frame_m0.c **** 	asm("LDRB 	r6, [r0]");
 1174              		.loc 1 391 0
 1175              	@ 391 "../src/frame_m0.c" 1
 1176 0082 0678     		LDRB 	r6, [r0]
 1177              	@ 0 "" 2
 392:../src/frame_m0.c **** 	asm("ADDS   r6, r2");
 1178              		.loc 1 392 0
 1179              	@ 392 "../src/frame_m0.c" 1
 1180 0084 B618     		ADDS   r6, r2
 1181              	@ 0 "" 2
 393:../src/frame_m0.c **** 	asm("STRH 	r6, [r1, #0x00]");
 1182              		.loc 1 393 0
 1183              	@ 393 "../src/frame_m0.c" 1
 1184 0086 0E80     		STRH 	r6, [r1, #0x00]
 1185              	@ 0 "" 2
 394:../src/frame_m0.c ****     asm("NOP");
 1186              		.loc 1 394 0
 1187              	@ 394 "../src/frame_m0.c" 1
 1188 0088 C046     		NOP
 1189              	@ 0 "" 2
 395:../src/frame_m0.c **** 	asm("NOP");
 1190              		.loc 1 395 0
 1191              	@ 395 "../src/frame_m0.c" 1
 1192 008a C046     		NOP
 1193              	@ 0 "" 2
 396:../src/frame_m0.c **** 	asm("NOP");
 1194              		.loc 1 396 0
 1195              	@ 396 "../src/frame_m0.c" 1
 1196 008c C046     		NOP
 1197              	@ 0 "" 2
 397:../src/frame_m0.c **** 	asm("NOP");
 1198              		.loc 1 397 0
 1199              	@ 397 "../src/frame_m0.c" 1
 1200 008e C046     		NOP
 1201              	@ 0 "" 2
 398:../src/frame_m0.c **** 	asm("NOP");
 1202              		.loc 1 398 0
 1203              	@ 398 "../src/frame_m0.c" 1
 1204 0090 C046     		NOP
 1205              	@ 0 "" 2
 399:../src/frame_m0.c **** 	asm("NOP");
 1206              		.loc 1 399 0
 1207              	@ 399 "../src/frame_m0.c" 1
 1208 0092 C046     		NOP
 1209              	@ 0 "" 2
 400:../src/frame_m0.c **** 	asm("NOP");
 1210              		.loc 1 400 0
 1211              	@ 400 "../src/frame_m0.c" 1
 1212 0094 C046     		NOP
 1213              	@ 0 "" 2
 401:../src/frame_m0.c **** 
 402:../src/frame_m0.c **** 	asm("LDRB 	r6, [r0]");
 1214              		.loc 1 402 0
 1215              	@ 402 "../src/frame_m0.c" 1
 1216 0096 0678     		LDRB 	r6, [r0]
 1217              	@ 0 "" 2
 403:../src/frame_m0.c **** 	asm("ADDS   r6, r5");
 1218              		.loc 1 403 0
 1219              	@ 403 "../src/frame_m0.c" 1
 1220 0098 7619     		ADDS   r6, r5
 1221              	@ 0 "" 2
 404:../src/frame_m0.c **** 	asm("STRH 	r6, [r1, #0x02]");
 1222              		.loc 1 404 0
 1223              	@ 404 "../src/frame_m0.c" 1
 1224 009a 4E80     		STRH 	r6, [r1, #0x02]
 1225              	@ 0 "" 2
 405:../src/frame_m0.c **** 	asm("NOP");
 1226              		.loc 1 405 0
 1227              	@ 405 "../src/frame_m0.c" 1
 1228 009c C046     		NOP
 1229              	@ 0 "" 2
 406:../src/frame_m0.c **** 	asm("NOP");
 1230              		.loc 1 406 0
 1231              	@ 406 "../src/frame_m0.c" 1
 1232 009e C046     		NOP
 1233              	@ 0 "" 2
 407:../src/frame_m0.c **** 	asm("ADDS	r1, #0x04");
 1234              		.loc 1 407 0
 1235              	@ 407 "../src/frame_m0.c" 1
 1236 00a0 0431     		ADDS	r1, #0x04
 1237              	@ 0 "" 2
 408:../src/frame_m0.c **** 	asm("CMP	r1, r3");
 1238              		.loc 1 408 0
 1239              	@ 408 "../src/frame_m0.c" 1
 1240 00a2 9942     		CMP	r1, r3
 1241              	@ 0 "" 2
 409:../src/frame_m0.c **** 	asm("BLT	loop3");
 1242              		.loc 1 409 0
 1243              	@ 409 "../src/frame_m0.c" 1
 1244 00a4 D7DB     		BLT	loop3
 1245              	@ 0 "" 2
 410:../src/frame_m0.c **** 
 411:../src/frame_m0.c **** 		// wait for hsync to go low (end of line)
 412:../src/frame_m0.c **** asm("dest9:");
 1246              		.loc 1 412 0
 1247              	@ 412 "../src/frame_m0.c" 1
 1248              		dest9:
 1249              	@ 0 "" 2
 413:../src/frame_m0.c **** 	asm("LDR 	r5, [r0]"); 	// 2
 1250              		.loc 1 413 0
 1251              	@ 413 "../src/frame_m0.c" 1
 1252 00a6 0568     		LDR 	r5, [r0]
 1253              	@ 0 "" 2
 414:../src/frame_m0.c **** 	asm("TST	r5, r4");		// 1
 1254              		.loc 1 414 0
 1255              	@ 414 "../src/frame_m0.c" 1
 1256 00a8 2542     		TST	r5, r4
 1257              	@ 0 "" 2
 415:../src/frame_m0.c **** 	asm("BNE	dest9");		// 3
 1258              		.loc 1 415 0
 1259              	@ 415 "../src/frame_m0.c" 1
 1260 00aa FCD1     		BNE	dest9
 1261              	@ 0 "" 2
 416:../src/frame_m0.c **** 
 417:../src/frame_m0.c **** 	asm("POP	{r4-r6}");
 1262              		.loc 1 417 0
 1263              	@ 417 "../src/frame_m0.c" 1
 1264 00ac 70BC     		POP	{r4-r6}
 1265              	@ 0 "" 2
 418:../src/frame_m0.c **** 
 419:../src/frame_m0.c **** 	asm(".syntax divided");
 1266              		.loc 1 419 0
 1267              	@ 419 "../src/frame_m0.c" 1
 1268              		.syntax divided
 1269              	@ 0 "" 2
 420:../src/frame_m0.c **** }
 1270              		.loc 1 420 0
 1271              		.code	16
 1272 00ae BD46     		mov	sp, r7
 1273 00b0 04B0     		add	sp, sp, #16
 1274              		@ sp needed
 1275 00b2 80BD     		pop	{r7, pc}
 1276              		.cfi_endproc
 1277              	.LFE37:
 1279              		.section	.text.lineM1R2Merge,"ax",%progbits
 1280              		.align	2
 1281              		.global	lineM1R2Merge
 1282              		.code	16
 1283              		.thumb_func
 1285              	lineM1R2Merge:
 1286              	.LFB38:
 421:../src/frame_m0.c **** 
 422:../src/frame_m0.c **** 
 423:../src/frame_m0.c **** void lineM1R2Merge(uint32_t *gpio, uint16_t *lineMemory, uint8_t *memory, uint32_t xoffset, uint32_
 424:../src/frame_m0.c **** {
 1287              		.loc 1 424 0
 1288              		.cfi_startproc
 1289 0000 80B5     		push	{r7, lr}
 1290              		.cfi_def_cfa_offset 8
 1291              		.cfi_offset 7, -8
 1292              		.cfi_offset 14, -4
 1293 0002 84B0     		sub	sp, sp, #16
 1294              		.cfi_def_cfa_offset 24
 1295 0004 00AF     		add	r7, sp, #0
 1296              		.cfi_def_cfa_register 7
 1297 0006 F860     		str	r0, [r7, #12]
 1298 0008 B960     		str	r1, [r7, #8]
 1299 000a 7A60     		str	r2, [r7, #4]
 1300 000c 3B60     		str	r3, [r7]
 425:../src/frame_m0.c **** //	asm("PRESERVE8");
 426:../src/frame_m0.c **** //	asm("IMPORT callSyncM1");
 427:../src/frame_m0.c **** asm(".syntax unified");
 1301              		.loc 1 427 0
 1302              	@ 427 "../src/frame_m0.c" 1
 1303              		.syntax unified
 1304              	@ 0 "" 2
 428:../src/frame_m0.c **** 
 429:../src/frame_m0.c **** 	asm("PUSH	{r4-r7}");
 1305              		.loc 1 429 0
 1306              	@ 429 "../src/frame_m0.c" 1
 1307 000e F0B4     		PUSH	{r4-r7}
 1308              	@ 0 "" 2
 430:../src/frame_m0.c **** 	asm("LDR	r4, [sp, #0x28]"); // *** keil
 1309              		.loc 1 430 0
 1310              	@ 430 "../src/frame_m0.c" 1
 1311 0010 0A9C     		LDR	r4, [sp, #0x28]
 1312              	@ 0 "" 2
 431:../src/frame_m0.c **** 
 432:../src/frame_m0.c ****    	// add width to memory pointer so we can compare
 433:../src/frame_m0.c **** 	asm("ADDS	r4, r2");
 1313              		.loc 1 433 0
 1314              	@ 433 "../src/frame_m0.c" 1
 1315 0012 A418     		ADDS	r4, r2
 1316              	@ 0 "" 2
 434:../src/frame_m0.c **** 	// generate hsync bit
 435:../src/frame_m0.c **** 	asm("MOVS	r5, #0x1");
 1317              		.loc 1 435 0
 1318              	@ 435 "../src/frame_m0.c" 1
 1319 0014 0125     		MOVS	r5, #0x1
 1320              	@ 0 "" 2
 436:../src/frame_m0.c **** 	asm("LSLS	r5, #11");
 1321              		.loc 1 436 0
 1322              	@ 436 "../src/frame_m0.c" 1
 1323 0016 ED02     		LSLS	r5, #11
 1324              	@ 0 "" 2
 437:../src/frame_m0.c **** 
 438:../src/frame_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 1325              		.loc 1 438 0
 1326              	@ 438 "../src/frame_m0.c" 1
 1327 0018 0FB4     		PUSH	{r0-r3}
 1328              	@ 0 "" 2
 439:../src/frame_m0.c **** 	asm("BL 	callSyncM1"); // get pixel sync
 1329              		.loc 1 439 0
 1330              	@ 439 "../src/frame_m0.c" 1
 1331 001a FFF7FEFF 		BL 	callSyncM1
 1332              	@ 0 "" 2
 440:../src/frame_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 1333              		.loc 1 440 0
 1334              	@ 440 "../src/frame_m0.c" 1
 1335 001e 0FBC     		POP	{r0-r3}
 1336              	@ 0 "" 2
 441:../src/frame_m0.c **** 	   
 442:../src/frame_m0.c **** 	// pixel sync starts here
 443:../src/frame_m0.c **** 
 444:../src/frame_m0.c **** 	// wait for hsync to go high
 445:../src/frame_m0.c **** asm("dest4:");
 1337              		.loc 1 445 0
 1338              	@ 445 "../src/frame_m0.c" 1
 1339              		dest4:
 1340              	@ 0 "" 2
 446:../src/frame_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 1341              		.loc 1 446 0
 1342              	@ 446 "../src/frame_m0.c" 1
 1343 0020 0668     		LDR 	r6, [r0]
 1344              	@ 0 "" 2
 447:../src/frame_m0.c **** 	asm("TST	r6, r5");		// 1
 1345              		.loc 1 447 0
 1346              	@ 447 "../src/frame_m0.c" 1
 1347 0022 2E42     		TST	r6, r5
 1348              	@ 0 "" 2
 448:../src/frame_m0.c **** 	asm("BEQ	dest4");		// 3
 1349              		.loc 1 448 0
 1350              	@ 448 "../src/frame_m0.c" 1
 1351 0024 FCD0     		BEQ	dest4
 1352              	@ 0 "" 2
 449:../src/frame_m0.c **** 
 450:../src/frame_m0.c **** 		// skip pixels
 451:../src/frame_m0.c **** asm("dest5:");
 1353              		.loc 1 451 0
 1354              	@ 451 "../src/frame_m0.c" 1
 1355              		dest5:
 1356              	@ 0 "" 2
 452:../src/frame_m0.c **** 	asm("SUBS	r3, #0x1");	    // 1
 1357              		.loc 1 452 0
 1358              	@ 452 "../src/frame_m0.c" 1
 1359 0026 013B     		SUBS	r3, #0x1
 1360              	@ 0 "" 2
 453:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1361              		.loc 1 453 0
 1362              	@ 453 "../src/frame_m0.c" 1
 1363 0028 C046     		NOP
 1364              	@ 0 "" 2
 454:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1365              		.loc 1 454 0
 1366              	@ 454 "../src/frame_m0.c" 1
 1367 002a C046     		NOP
 1368              	@ 0 "" 2
 455:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1369              		.loc 1 455 0
 1370              	@ 455 "../src/frame_m0.c" 1
 1371 002c C046     		NOP
 1372              	@ 0 "" 2
 456:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1373              		.loc 1 456 0
 1374              	@ 456 "../src/frame_m0.c" 1
 1375 002e C046     		NOP
 1376              	@ 0 "" 2
 457:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1377              		.loc 1 457 0
 1378              	@ 457 "../src/frame_m0.c" 1
 1379 0030 C046     		NOP
 1380              	@ 0 "" 2
 458:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1381              		.loc 1 458 0
 1382              	@ 458 "../src/frame_m0.c" 1
 1383 0032 C046     		NOP
 1384              	@ 0 "" 2
 459:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1385              		.loc 1 459 0
 1386              	@ 459 "../src/frame_m0.c" 1
 1387 0034 C046     		NOP
 1388              	@ 0 "" 2
 460:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1389              		.loc 1 460 0
 1390              	@ 460 "../src/frame_m0.c" 1
 1391 0036 C046     		NOP
 1392              	@ 0 "" 2
 461:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1393              		.loc 1 461 0
 1394              	@ 461 "../src/frame_m0.c" 1
 1395 0038 C046     		NOP
 1396              	@ 0 "" 2
 462:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1397              		.loc 1 462 0
 1398              	@ 462 "../src/frame_m0.c" 1
 1399 003a C046     		NOP
 1400              	@ 0 "" 2
 463:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1401              		.loc 1 463 0
 1402              	@ 463 "../src/frame_m0.c" 1
 1403 003c C046     		NOP
 1404              	@ 0 "" 2
 464:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1405              		.loc 1 464 0
 1406              	@ 464 "../src/frame_m0.c" 1
 1407 003e C046     		NOP
 1408              	@ 0 "" 2
 465:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1409              		.loc 1 465 0
 1410              	@ 465 "../src/frame_m0.c" 1
 1411 0040 C046     		NOP
 1412              	@ 0 "" 2
 466:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1413              		.loc 1 466 0
 1414              	@ 466 "../src/frame_m0.c" 1
 1415 0042 C046     		NOP
 1416              	@ 0 "" 2
 467:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1417              		.loc 1 467 0
 1418              	@ 467 "../src/frame_m0.c" 1
 1419 0044 C046     		NOP
 1420              	@ 0 "" 2
 468:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1421              		.loc 1 468 0
 1422              	@ 468 "../src/frame_m0.c" 1
 1423 0046 C046     		NOP
 1424              	@ 0 "" 2
 469:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1425              		.loc 1 469 0
 1426              	@ 469 "../src/frame_m0.c" 1
 1427 0048 C046     		NOP
 1428              	@ 0 "" 2
 470:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1429              		.loc 1 470 0
 1430              	@ 470 "../src/frame_m0.c" 1
 1431 004a C046     		NOP
 1432              	@ 0 "" 2
 471:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1433              		.loc 1 471 0
 1434              	@ 471 "../src/frame_m0.c" 1
 1435 004c C046     		NOP
 1436              	@ 0 "" 2
 472:../src/frame_m0.c **** 	asm("NOP");				 	// 1
 1437              		.loc 1 472 0
 1438              	@ 472 "../src/frame_m0.c" 1
 1439 004e C046     		NOP
 1440              	@ 0 "" 2
 473:../src/frame_m0.c **** 	asm("BGE	dest5");		// 3
 1441              		.loc 1 473 0
 1442              	@ 473 "../src/frame_m0.c" 1
 1443 0050 E9DA     		BGE	dest5
 1444              	@ 0 "" 2
 474:../src/frame_m0.c **** 
 475:../src/frame_m0.c **** 	// variable delay --- get correct phase for sampling
 476:../src/frame_m0.c **** 	asm("NOP");
 1445              		.loc 1 476 0
 1446              	@ 476 "../src/frame_m0.c" 1
 1447 0052 C046     		NOP
 1448              	@ 0 "" 2
 477:../src/frame_m0.c **** 	asm("NOP");
 1449              		.loc 1 477 0
 1450              	@ 477 "../src/frame_m0.c" 1
 1451 0054 C046     		NOP
 1452              	@ 0 "" 2
 478:../src/frame_m0.c **** 
 479:../src/frame_m0.c **** asm("loop4:");
 1453              		.loc 1 479 0
 1454              	@ 479 "../src/frame_m0.c" 1
 1455              		loop4:
 1456              	@ 0 "" 2
 480:../src/frame_m0.c **** 	asm("LDRB 	r3, [r0]"); // 0
 1457              		.loc 1 480 0
 1458              	@ 480 "../src/frame_m0.c" 1
 1459 0056 0378     		LDRB 	r3, [r0]
 1460              	@ 0 "" 2
 481:../src/frame_m0.c **** 	asm("LDRH	r6, [r1, #0x00]");
 1461              		.loc 1 481 0
 1462              	@ 481 "../src/frame_m0.c" 1
 1463 0058 0E88     		LDRH	r6, [r1, #0x00]
 1464              	@ 0 "" 2
 482:../src/frame_m0.c **** 	asm("ADDS   r6, r3");
 1465              		.loc 1 482 0
 1466              	@ 482 "../src/frame_m0.c" 1
 1467 005a F618     		ADDS   r6, r3
 1468              	@ 0 "" 2
 483:../src/frame_m0.c **** 	asm("NOP");
 1469              		.loc 1 483 0
 1470              	@ 483 "../src/frame_m0.c" 1
 1471 005c C046     		NOP
 1472              	@ 0 "" 2
 484:../src/frame_m0.c **** 	asm("NOP");
 1473              		.loc 1 484 0
 1474              	@ 484 "../src/frame_m0.c" 1
 1475 005e C046     		NOP
 1476              	@ 0 "" 2
 485:../src/frame_m0.c **** 	asm("NOP");
 1477              		.loc 1 485 0
 1478              	@ 485 "../src/frame_m0.c" 1
 1479 0060 C046     		NOP
 1480              	@ 0 "" 2
 486:../src/frame_m0.c **** 	asm("NOP");
 1481              		.loc 1 486 0
 1482              	@ 486 "../src/frame_m0.c" 1
 1483 0062 C046     		NOP
 1484              	@ 0 "" 2
 487:../src/frame_m0.c **** 	asm("NOP");
 1485              		.loc 1 487 0
 1486              	@ 487 "../src/frame_m0.c" 1
 1487 0064 C046     		NOP
 1488              	@ 0 "" 2
 488:../src/frame_m0.c **** 	asm("NOP");
 1489              		.loc 1 488 0
 1490              	@ 488 "../src/frame_m0.c" 1
 1491 0066 C046     		NOP
 1492              	@ 0 "" 2
 489:../src/frame_m0.c **** 	asm("NOP");
 1493              		.loc 1 489 0
 1494              	@ 489 "../src/frame_m0.c" 1
 1495 0068 C046     		NOP
 1496              	@ 0 "" 2
 490:../src/frame_m0.c **** 
 491:../src/frame_m0.c **** 	asm("LDRB 	r3, [r0]"); // 0
 1497              		.loc 1 491 0
 1498              	@ 491 "../src/frame_m0.c" 1
 1499 006a 0378     		LDRB 	r3, [r0]
 1500              	@ 0 "" 2
 492:../src/frame_m0.c **** 	asm("LDRH	r7, [r1, #0x02]");
 1501              		.loc 1 492 0
 1502              	@ 492 "../src/frame_m0.c" 1
 1503 006c 4F88     		LDRH	r7, [r1, #0x02]
 1504              	@ 0 "" 2
 493:../src/frame_m0.c **** 	asm("ADDS   r7, r3");
 1505              		.loc 1 493 0
 1506              	@ 493 "../src/frame_m0.c" 1
 1507 006e FF18     		ADDS   r7, r3
 1508              	@ 0 "" 2
 494:../src/frame_m0.c **** 	asm("NOP");
 1509              		.loc 1 494 0
 1510              	@ 494 "../src/frame_m0.c" 1
 1511 0070 C046     		NOP
 1512              	@ 0 "" 2
 495:../src/frame_m0.c **** 	asm("NOP");
 1513              		.loc 1 495 0
 1514              	@ 495 "../src/frame_m0.c" 1
 1515 0072 C046     		NOP
 1516              	@ 0 "" 2
 496:../src/frame_m0.c **** 	asm("NOP");
 1517              		.loc 1 496 0
 1518              	@ 496 "../src/frame_m0.c" 1
 1519 0074 C046     		NOP
 1520              	@ 0 "" 2
 497:../src/frame_m0.c **** 	asm("NOP");
 1521              		.loc 1 497 0
 1522              	@ 497 "../src/frame_m0.c" 1
 1523 0076 C046     		NOP
 1524              	@ 0 "" 2
 498:../src/frame_m0.c **** 	asm("NOP");
 1525              		.loc 1 498 0
 1526              	@ 498 "../src/frame_m0.c" 1
 1527 0078 C046     		NOP
 1528              	@ 0 "" 2
 499:../src/frame_m0.c **** 	asm("NOP");
 1529              		.loc 1 499 0
 1530              	@ 499 "../src/frame_m0.c" 1
 1531 007a C046     		NOP
 1532              	@ 0 "" 2
 500:../src/frame_m0.c **** 	asm("NOP");
 1533              		.loc 1 500 0
 1534              	@ 500 "../src/frame_m0.c" 1
 1535 007c C046     		NOP
 1536              	@ 0 "" 2
 501:../src/frame_m0.c **** 
 502:../src/frame_m0.c **** 	asm("LDRB	r3, [r0]"); 	  // 0
 1537              		.loc 1 502 0
 1538              	@ 502 "../src/frame_m0.c" 1
 1539 007e 0378     		LDRB	r3, [r0]
 1540              	@ 0 "" 2
 503:../src/frame_m0.c **** 	asm("ADDS   r6, r3");
 1541              		.loc 1 503 0
 1542              	@ 503 "../src/frame_m0.c" 1
 1543 0080 F618     		ADDS   r6, r3
 1544              	@ 0 "" 2
 504:../src/frame_m0.c **** 	asm("LSRS   r6, #2");
 1545              		.loc 1 504 0
 1546              	@ 504 "../src/frame_m0.c" 1
 1547 0082 B608     		LSRS   r6, #2
 1548              	@ 0 "" 2
 505:../src/frame_m0.c **** 	asm("STRB 	r6, [r2, #0x00]");
 1549              		.loc 1 505 0
 1550              	@ 505 "../src/frame_m0.c" 1
 1551 0084 1670     		STRB 	r6, [r2, #0x00]
 1552              	@ 0 "" 2
 506:../src/frame_m0.c **** 	asm("NOP");
 1553              		.loc 1 506 0
 1554              	@ 506 "../src/frame_m0.c" 1
 1555 0086 C046     		NOP
 1556              	@ 0 "" 2
 507:../src/frame_m0.c **** 	asm("NOP");
 1557              		.loc 1 507 0
 1558              	@ 507 "../src/frame_m0.c" 1
 1559 0088 C046     		NOP
 1560              	@ 0 "" 2
 508:../src/frame_m0.c **** 	asm("NOP");
 1561              		.loc 1 508 0
 1562              	@ 508 "../src/frame_m0.c" 1
 1563 008a C046     		NOP
 1564              	@ 0 "" 2
 509:../src/frame_m0.c **** 	asm("NOP");
 1565              		.loc 1 509 0
 1566              	@ 509 "../src/frame_m0.c" 1
 1567 008c C046     		NOP
 1568              	@ 0 "" 2
 510:../src/frame_m0.c **** 	asm("NOP");
 1569              		.loc 1 510 0
 1570              	@ 510 "../src/frame_m0.c" 1
 1571 008e C046     		NOP
 1572              	@ 0 "" 2
 511:../src/frame_m0.c **** 	asm("NOP");
 1573              		.loc 1 511 0
 1574              	@ 511 "../src/frame_m0.c" 1
 1575 0090 C046     		NOP
 1576              	@ 0 "" 2
 512:../src/frame_m0.c **** 
 513:../src/frame_m0.c **** 	asm("LDRB	r3, [r0]"); 	 // 0
 1577              		.loc 1 513 0
 1578              	@ 513 "../src/frame_m0.c" 1
 1579 0092 0378     		LDRB	r3, [r0]
 1580              	@ 0 "" 2
 514:../src/frame_m0.c **** 	asm("ADDS	r7, r3");
 1581              		.loc 1 514 0
 1582              	@ 514 "../src/frame_m0.c" 1
 1583 0094 FF18     		ADDS	r7, r3
 1584              	@ 0 "" 2
 515:../src/frame_m0.c **** 	asm("LSRS	r7, #2");
 1585              		.loc 1 515 0
 1586              	@ 515 "../src/frame_m0.c" 1
 1587 0096 BF08     		LSRS	r7, #2
 1588              	@ 0 "" 2
 516:../src/frame_m0.c **** 	asm("STRB	r7, [r2, #0x01]");
 1589              		.loc 1 516 0
 1590              	@ 516 "../src/frame_m0.c" 1
 1591 0098 5770     		STRB	r7, [r2, #0x01]
 1592              	@ 0 "" 2
 517:../src/frame_m0.c **** 	asm("ADDS	r1, #0x04");
 1593              		.loc 1 517 0
 1594              	@ 517 "../src/frame_m0.c" 1
 1595 009a 0431     		ADDS	r1, #0x04
 1596              	@ 0 "" 2
 518:../src/frame_m0.c **** 	asm("ADDS	r2, #0x02");
 1597              		.loc 1 518 0
 1598              	@ 518 "../src/frame_m0.c" 1
 1599 009c 0232     		ADDS	r2, #0x02
 1600              	@ 0 "" 2
 519:../src/frame_m0.c **** 	asm("CMP	r2, r4");
 1601              		.loc 1 519 0
 1602              	@ 519 "../src/frame_m0.c" 1
 1603 009e A242     		CMP	r2, r4
 1604              	@ 0 "" 2
 520:../src/frame_m0.c **** 	asm("BLT	loop4");
 1605              		.loc 1 520 0
 1606              	@ 520 "../src/frame_m0.c" 1
 1607 00a0 D9DB     		BLT	loop4
 1608              	@ 0 "" 2
 521:../src/frame_m0.c **** 
 522:../src/frame_m0.c **** 	// wait for hsync to go low (end of line)
 523:../src/frame_m0.c **** asm("dest6:");
 1609              		.loc 1 523 0
 1610              	@ 523 "../src/frame_m0.c" 1
 1611              		dest6:
 1612              	@ 0 "" 2
 524:../src/frame_m0.c **** 	asm("LDR	r6, [r0]"); 	// 2
 1613              		.loc 1 524 0
 1614              	@ 524 "../src/frame_m0.c" 1
 1615 00a2 0668     		LDR	r6, [r0]
 1616              	@ 0 "" 2
 525:../src/frame_m0.c **** 	asm("TST	r6, r5");		// 1
 1617              		.loc 1 525 0
 1618              	@ 525 "../src/frame_m0.c" 1
 1619 00a4 2E42     		TST	r6, r5
 1620              	@ 0 "" 2
 526:../src/frame_m0.c **** 	asm("BNE	dest6");		// 3
 1621              		.loc 1 526 0
 1622              	@ 526 "../src/frame_m0.c" 1
 1623 00a6 FCD1     		BNE	dest6
 1624              	@ 0 "" 2
 527:../src/frame_m0.c **** 
 528:../src/frame_m0.c **** 	asm("POP	{r4-r7}");
 1625              		.loc 1 528 0
 1626              	@ 528 "../src/frame_m0.c" 1
 1627 00a8 F0BC     		POP	{r4-r7}
 1628              	@ 0 "" 2
 529:../src/frame_m0.c **** 
 530:../src/frame_m0.c **** 	asm(".syntax divided");
 1629              		.loc 1 530 0
 1630              	@ 530 "../src/frame_m0.c" 1
 1631              		.syntax divided
 1632              	@ 0 "" 2
 531:../src/frame_m0.c **** }
 1633              		.loc 1 531 0
 1634              		.code	16
 1635 00aa BD46     		mov	sp, r7
 1636 00ac 04B0     		add	sp, sp, #16
 1637              		@ sp needed
 1638 00ae 80BD     		pop	{r7, pc}
 1639              		.cfi_endproc
 1640              	.LFE38:
 1642              		.section	.text.skipLine,"ax",%progbits
 1643              		.align	2
 1644              		.global	skipLine
 1645              		.code	16
 1646              		.thumb_func
 1648              	skipLine:
 1649              	.LFB39:
 532:../src/frame_m0.c **** 
 533:../src/frame_m0.c **** 
 534:../src/frame_m0.c **** void skipLine()
 535:../src/frame_m0.c **** {
 1650              		.loc 1 535 0
 1651              		.cfi_startproc
 1652 0000 80B5     		push	{r7, lr}
 1653              		.cfi_def_cfa_offset 8
 1654              		.cfi_offset 7, -8
 1655              		.cfi_offset 14, -4
 1656 0002 00AF     		add	r7, sp, #0
 1657              		.cfi_def_cfa_register 7
 536:../src/frame_m0.c **** 	while(!CAM_HSYNC());
 1658              		.loc 1 536 0
 1659 0004 C046     		mov	r8, r8
 1660              	.L19:
 1661              		.loc 1 536 0 is_stmt 0 discriminator 1
 1662 0006 084A     		ldr	r2, .L21
 1663 0008 084B     		ldr	r3, .L21+4
 1664 000a D258     		ldr	r2, [r2, r3]
 1665 000c 8023     		mov	r3, #128
 1666 000e 1B01     		lsl	r3, r3, #4
 1667 0010 1340     		and	r3, r2
 1668 0012 F8D0     		beq	.L19
 537:../src/frame_m0.c **** 	while(CAM_HSYNC());
 1669              		.loc 1 537 0 is_stmt 1
 1670 0014 C046     		mov	r8, r8
 1671              	.L20:
 1672              		.loc 1 537 0 is_stmt 0 discriminator 1
 1673 0016 044A     		ldr	r2, .L21
 1674 0018 044B     		ldr	r3, .L21+4
 1675 001a D258     		ldr	r2, [r2, r3]
 1676 001c 8023     		mov	r3, #128
 1677 001e 1B01     		lsl	r3, r3, #4
 1678 0020 1340     		and	r3, r2
 1679 0022 F8D1     		bne	.L20
 538:../src/frame_m0.c **** }
 1680              		.loc 1 538 0 is_stmt 1
 1681 0024 BD46     		mov	sp, r7
 1682              		@ sp needed
 1683 0026 80BD     		pop	{r7, pc}
 1684              	.L22:
 1685              		.align	2
 1686              	.L21:
 1687 0028 00400F40 		.word	1074741248
 1688 002c 04210000 		.word	8452
 1689              		.cfi_endproc
 1690              	.LFE39:
 1692              		.section	.text.skipLines,"ax",%progbits
 1693              		.align	2
 1694              		.global	skipLines
 1695              		.code	16
 1696              		.thumb_func
 1698              	skipLines:
 1699              	.LFB40:
 539:../src/frame_m0.c **** 
 540:../src/frame_m0.c **** 
 541:../src/frame_m0.c **** void skipLines(uint32_t lines)
 542:../src/frame_m0.c **** {
 1700              		.loc 1 542 0
 1701              		.cfi_startproc
 1702 0000 80B5     		push	{r7, lr}
 1703              		.cfi_def_cfa_offset 8
 1704              		.cfi_offset 7, -8
 1705              		.cfi_offset 14, -4
 1706 0002 84B0     		sub	sp, sp, #16
 1707              		.cfi_def_cfa_offset 24
 1708 0004 00AF     		add	r7, sp, #0
 1709              		.cfi_def_cfa_register 7
 1710 0006 7860     		str	r0, [r7, #4]
 543:../src/frame_m0.c **** 	uint32_t line;
 544:../src/frame_m0.c **** 
 545:../src/frame_m0.c **** 	// wait for remainder of frame to pass
 546:../src/frame_m0.c **** 	while(!CAM_VSYNC()); 
 1711              		.loc 1 546 0
 1712 0008 C046     		mov	r8, r8
 1713              	.L24:
 1714              		.loc 1 546 0 is_stmt 0 discriminator 1
 1715 000a 0F4A     		ldr	r2, .L28
 1716 000c 0F4B     		ldr	r3, .L28+4
 1717 000e D258     		ldr	r2, [r2, r3]
 1718 0010 8023     		mov	r3, #128
 1719 0012 5B01     		lsl	r3, r3, #5
 1720 0014 1340     		and	r3, r2
 1721 0016 F8D0     		beq	.L24
 547:../src/frame_m0.c **** 	// vsync asserted
 548:../src/frame_m0.c **** 	while(CAM_VSYNC());
 1722              		.loc 1 548 0 is_stmt 1
 1723 0018 C046     		mov	r8, r8
 1724              	.L25:
 1725              		.loc 1 548 0 is_stmt 0 discriminator 1
 1726 001a 0B4A     		ldr	r2, .L28
 1727 001c 0B4B     		ldr	r3, .L28+4
 1728 001e D258     		ldr	r2, [r2, r3]
 1729 0020 8023     		mov	r3, #128
 1730 0022 5B01     		lsl	r3, r3, #5
 1731 0024 1340     		and	r3, r2
 1732 0026 F8D1     		bne	.L25
 549:../src/frame_m0.c **** 	// skip lines
 550:../src/frame_m0.c **** 	for (line=0; line<lines; line++)
 1733              		.loc 1 550 0 is_stmt 1
 1734 0028 0023     		mov	r3, #0
 1735 002a FB60     		str	r3, [r7, #12]
 1736 002c 04E0     		b	.L26
 1737              	.L27:
 551:../src/frame_m0.c **** 		skipLine();
 1738              		.loc 1 551 0 discriminator 3
 1739 002e FFF7FEFF 		bl	skipLine
 550:../src/frame_m0.c **** 		skipLine();
 1740              		.loc 1 550 0 discriminator 3
 1741 0032 FB68     		ldr	r3, [r7, #12]
 1742 0034 0133     		add	r3, r3, #1
 1743 0036 FB60     		str	r3, [r7, #12]
 1744              	.L26:
 550:../src/frame_m0.c **** 		skipLine();
 1745              		.loc 1 550 0 is_stmt 0 discriminator 1
 1746 0038 FA68     		ldr	r2, [r7, #12]
 1747 003a 7B68     		ldr	r3, [r7, #4]
 1748 003c 9A42     		cmp	r2, r3
 1749 003e F6D3     		bcc	.L27
 552:../src/frame_m0.c **** }
 1750              		.loc 1 552 0 is_stmt 1
 1751 0040 BD46     		mov	sp, r7
 1752 0042 04B0     		add	sp, sp, #16
 1753              		@ sp needed
 1754 0044 80BD     		pop	{r7, pc}
 1755              	.L29:
 1756 0046 C046     		.align	2
 1757              	.L28:
 1758 0048 00400F40 		.word	1074741248
 1759 004c 04210000 		.word	8452
 1760              		.cfi_endproc
 1761              	.LFE40:
 1763              		.section	.text.grabM0R0,"ax",%progbits
 1764              		.align	2
 1765              		.global	grabM0R0
 1766              		.code	16
 1767              		.thumb_func
 1769              	grabM0R0:
 1770              	.LFB41:
 553:../src/frame_m0.c **** 
 554:../src/frame_m0.c **** 
 555:../src/frame_m0.c **** void grabM0R0(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 556:../src/frame_m0.c **** {
 1771              		.loc 1 556 0
 1772              		.cfi_startproc
 1773 0000 80B5     		push	{r7, lr}
 1774              		.cfi_def_cfa_offset 8
 1775              		.cfi_offset 7, -8
 1776              		.cfi_offset 14, -4
 1777 0002 86B0     		sub	sp, sp, #24
 1778              		.cfi_def_cfa_offset 32
 1779 0004 00AF     		add	r7, sp, #0
 1780              		.cfi_def_cfa_register 7
 1781 0006 F860     		str	r0, [r7, #12]
 1782 0008 B960     		str	r1, [r7, #8]
 1783 000a 7A60     		str	r2, [r7, #4]
 1784 000c 3B60     		str	r3, [r7]
 557:../src/frame_m0.c **** 	uint32_t line;
 558:../src/frame_m0.c **** 
 559:../src/frame_m0.c **** 	xoffset >>= 1;
 1785              		.loc 1 559 0
 1786 000e FB68     		ldr	r3, [r7, #12]
 1787 0010 5B08     		lsr	r3, r3, #1
 1788 0012 FB60     		str	r3, [r7, #12]
 560:../src/frame_m0.c **** 	yoffset &= ~1;
 1789              		.loc 1 560 0
 1790 0014 BB68     		ldr	r3, [r7, #8]
 1791 0016 0122     		mov	r2, #1
 1792 0018 9343     		bic	r3, r2
 1793 001a BB60     		str	r3, [r7, #8]
 561:../src/frame_m0.c **** 
 562:../src/frame_m0.c **** 	skipLines(yoffset);
 1794              		.loc 1 562 0
 1795 001c BB68     		ldr	r3, [r7, #8]
 1796 001e 181C     		mov	r0, r3
 1797 0020 FFF7FEFF 		bl	skipLines
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1798              		.loc 1 563 0
 1799 0024 0023     		mov	r3, #0
 1800 0026 7B61     		str	r3, [r7, #20]
 1801 0028 0CE0     		b	.L31
 1802              	.L32:
 564:../src/frame_m0.c **** 		lineM0((uint32_t *)&CAM_PORT, memory, xoffset, xwidth); // wait, grab, wait
 1803              		.loc 1 564 0 discriminator 3
 1804 002a 0A48     		ldr	r0, .L33
 1805 002c 396A     		ldr	r1, [r7, #32]
 1806 002e FA68     		ldr	r2, [r7, #12]
 1807 0030 7B68     		ldr	r3, [r7, #4]
 1808 0032 FFF7FEFF 		bl	lineM0
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1809              		.loc 1 563 0 discriminator 3
 1810 0036 7B69     		ldr	r3, [r7, #20]
 1811 0038 0133     		add	r3, r3, #1
 1812 003a 7B61     		str	r3, [r7, #20]
 1813 003c 3A6A     		ldr	r2, [r7, #32]
 1814 003e 7B68     		ldr	r3, [r7, #4]
 1815 0040 D318     		add	r3, r2, r3
 1816 0042 3B62     		str	r3, [r7, #32]
 1817              	.L31:
 563:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1818              		.loc 1 563 0 is_stmt 0 discriminator 1
 1819 0044 7A69     		ldr	r2, [r7, #20]
 1820 0046 3B68     		ldr	r3, [r7]
 1821 0048 9A42     		cmp	r2, r3
 1822 004a EED3     		bcc	.L32
 565:../src/frame_m0.c **** }
 1823              		.loc 1 565 0 is_stmt 1
 1824 004c BD46     		mov	sp, r7
 1825 004e 06B0     		add	sp, sp, #24
 1826              		@ sp needed
 1827 0050 80BD     		pop	{r7, pc}
 1828              	.L34:
 1829 0052 C046     		.align	2
 1830              	.L33:
 1831 0054 04610F40 		.word	1074749700
 1832              		.cfi_endproc
 1833              	.LFE41:
 1835              		.section	.text.grabM1R1,"ax",%progbits
 1836              		.align	2
 1837              		.global	grabM1R1
 1838              		.code	16
 1839              		.thumb_func
 1841              	grabM1R1:
 1842              	.LFB42:
 566:../src/frame_m0.c **** 
 567:../src/frame_m0.c **** 
 568:../src/frame_m0.c **** void grabM1R1(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 569:../src/frame_m0.c **** {
 1843              		.loc 1 569 0
 1844              		.cfi_startproc
 1845 0000 80B5     		push	{r7, lr}
 1846              		.cfi_def_cfa_offset 8
 1847              		.cfi_offset 7, -8
 1848              		.cfi_offset 14, -4
 1849 0002 86B0     		sub	sp, sp, #24
 1850              		.cfi_def_cfa_offset 32
 1851 0004 00AF     		add	r7, sp, #0
 1852              		.cfi_def_cfa_register 7
 1853 0006 F860     		str	r0, [r7, #12]
 1854 0008 B960     		str	r1, [r7, #8]
 1855 000a 7A60     		str	r2, [r7, #4]
 1856 000c 3B60     		str	r3, [r7]
 570:../src/frame_m0.c **** 	uint32_t line;
 571:../src/frame_m0.c **** 
 572:../src/frame_m0.c **** 	xoffset >>= 1;
 1857              		.loc 1 572 0
 1858 000e FB68     		ldr	r3, [r7, #12]
 1859 0010 5B08     		lsr	r3, r3, #1
 1860 0012 FB60     		str	r3, [r7, #12]
 573:../src/frame_m0.c **** 	yoffset &= ~1;
 1861              		.loc 1 573 0
 1862 0014 BB68     		ldr	r3, [r7, #8]
 1863 0016 0122     		mov	r2, #1
 1864 0018 9343     		bic	r3, r2
 1865 001a BB60     		str	r3, [r7, #8]
 574:../src/frame_m0.c **** 
 575:../src/frame_m0.c **** 	skipLines(yoffset);
 1866              		.loc 1 575 0
 1867 001c BB68     		ldr	r3, [r7, #8]
 1868 001e 181C     		mov	r0, r3
 1869 0020 FFF7FEFF 		bl	skipLines
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1870              		.loc 1 576 0
 1871 0024 0023     		mov	r3, #0
 1872 0026 7B61     		str	r3, [r7, #20]
 1873 0028 0CE0     		b	.L36
 1874              	.L37:
 577:../src/frame_m0.c **** 		lineM1R1((uint32_t *)&CAM_PORT, memory, xoffset, xwidth); // wait, grab, wait
 1875              		.loc 1 577 0 discriminator 3
 1876 002a 0A48     		ldr	r0, .L38
 1877 002c 396A     		ldr	r1, [r7, #32]
 1878 002e FA68     		ldr	r2, [r7, #12]
 1879 0030 7B68     		ldr	r3, [r7, #4]
 1880 0032 FFF7FEFF 		bl	lineM1R1
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1881              		.loc 1 576 0 discriminator 3
 1882 0036 7B69     		ldr	r3, [r7, #20]
 1883 0038 0133     		add	r3, r3, #1
 1884 003a 7B61     		str	r3, [r7, #20]
 1885 003c 3A6A     		ldr	r2, [r7, #32]
 1886 003e 7B68     		ldr	r3, [r7, #4]
 1887 0040 D318     		add	r3, r2, r3
 1888 0042 3B62     		str	r3, [r7, #32]
 1889              	.L36:
 576:../src/frame_m0.c **** 	for (line=0; line<ywidth; line++, memory+=xwidth)
 1890              		.loc 1 576 0 is_stmt 0 discriminator 1
 1891 0044 7A69     		ldr	r2, [r7, #20]
 1892 0046 3B68     		ldr	r3, [r7]
 1893 0048 9A42     		cmp	r2, r3
 1894 004a EED3     		bcc	.L37
 578:../src/frame_m0.c **** }
 1895              		.loc 1 578 0 is_stmt 1
 1896 004c BD46     		mov	sp, r7
 1897 004e 06B0     		add	sp, sp, #24
 1898              		@ sp needed
 1899 0050 80BD     		pop	{r7, pc}
 1900              	.L39:
 1901 0052 C046     		.align	2
 1902              	.L38:
 1903 0054 04610F40 		.word	1074749700
 1904              		.cfi_endproc
 1905              	.LFE42:
 1907              		.section	.text.grabM1R2,"ax",%progbits
 1908              		.align	2
 1909              		.global	grabM1R2
 1910              		.code	16
 1911              		.thumb_func
 1913              	grabM1R2:
 1914              	.LFB43:
 579:../src/frame_m0.c **** 
 580:../src/frame_m0.c **** 
 581:../src/frame_m0.c **** void grabM1R2(uint32_t xoffset, uint32_t yoffset, uint32_t xwidth, uint32_t ywidth, uint8_t *memory
 582:../src/frame_m0.c **** {
 1915              		.loc 1 582 0
 1916              		.cfi_startproc
 1917 0000 90B5     		push	{r4, r7, lr}
 1918              		.cfi_def_cfa_offset 12
 1919              		.cfi_offset 4, -12
 1920              		.cfi_offset 7, -8
 1921              		.cfi_offset 14, -4
 1922 0002 89B0     		sub	sp, sp, #36
 1923              		.cfi_def_cfa_offset 48
 1924 0004 02AF     		add	r7, sp, #8
 1925              		.cfi_def_cfa 7, 40
 1926 0006 F860     		str	r0, [r7, #12]
 1927 0008 B960     		str	r1, [r7, #8]
 1928 000a 7A60     		str	r2, [r7, #4]
 1929 000c 3B60     		str	r3, [r7]
 583:../src/frame_m0.c **** 	uint32_t line;
 584:../src/frame_m0.c **** 	uint16_t *lineStore = (uint16_t *)(memory + xwidth*ywidth + 16);
 1930              		.loc 1 584 0
 1931 000e 7B68     		ldr	r3, [r7, #4]
 1932 0010 3A68     		ldr	r2, [r7]
 1933 0012 5343     		mul	r3, r2
 1934 0014 1033     		add	r3, r3, #16
 1935 0016 BA6A     		ldr	r2, [r7, #40]
 1936 0018 D318     		add	r3, r2, r3
 1937 001a 3B61     		str	r3, [r7, #16]
 585:../src/frame_m0.c **** 	lineStore = (uint16_t *)ALIGN(lineStore, 2);
 1938              		.loc 1 585 0
 1939 001c 3B69     		ldr	r3, [r7, #16]
 1940 001e 0122     		mov	r2, #1
 1941 0020 1340     		and	r3, r2
 1942 0022 04D0     		beq	.L41
 1943              		.loc 1 585 0 is_stmt 0 discriminator 1
 1944 0024 3B69     		ldr	r3, [r7, #16]
 1945 0026 0122     		mov	r2, #1
 1946 0028 9343     		bic	r3, r2
 1947 002a 0233     		add	r3, r3, #2
 1948 002c 00E0     		b	.L42
 1949              	.L41:
 1950              		.loc 1 585 0 discriminator 2
 1951 002e 3B69     		ldr	r3, [r7, #16]
 1952              	.L42:
 1953              		.loc 1 585 0 discriminator 4
 1954 0030 3B61     		str	r3, [r7, #16]
 586:../src/frame_m0.c **** 
 587:../src/frame_m0.c **** 	// clear line storage for 1 line
 588:../src/frame_m0.c **** 	for (line=0; line<xwidth; line++)
 1955              		.loc 1 588 0 is_stmt 1 discriminator 4
 1956 0032 0023     		mov	r3, #0
 1957 0034 7B61     		str	r3, [r7, #20]
 1958 0036 08E0     		b	.L43
 1959              	.L44:
 589:../src/frame_m0.c **** 		lineStore[line] = 0;
 1960              		.loc 1 589 0 discriminator 3
 1961 0038 7B69     		ldr	r3, [r7, #20]
 1962 003a 5B00     		lsl	r3, r3, #1
 1963 003c 3A69     		ldr	r2, [r7, #16]
 1964 003e D318     		add	r3, r2, r3
 1965 0040 0022     		mov	r2, #0
 1966 0042 1A80     		strh	r2, [r3]
 588:../src/frame_m0.c **** 		lineStore[line] = 0;
 1967              		.loc 1 588 0 discriminator 3
 1968 0044 7B69     		ldr	r3, [r7, #20]
 1969 0046 0133     		add	r3, r3, #1
 1970 0048 7B61     		str	r3, [r7, #20]
 1971              	.L43:
 588:../src/frame_m0.c **** 		lineStore[line] = 0;
 1972              		.loc 1 588 0 is_stmt 0 discriminator 1
 1973 004a 7A69     		ldr	r2, [r7, #20]
 1974 004c 7B68     		ldr	r3, [r7, #4]
 1975 004e 9A42     		cmp	r2, r3
 1976 0050 F2D3     		bcc	.L44
 590:../src/frame_m0.c **** 
 591:../src/frame_m0.c **** 	skipLines(yoffset*2);
 1977              		.loc 1 591 0 is_stmt 1
 1978 0052 BB68     		ldr	r3, [r7, #8]
 1979 0054 5B00     		lsl	r3, r3, #1
 1980 0056 181C     		mov	r0, r3
 1981 0058 FFF7FEFF 		bl	skipLines
 592:../src/frame_m0.c **** 	// grab 1 line to put us out of phase with the camera's internal vertical downsample (800 to 400 l
 593:../src/frame_m0.c **** 	// ie, we are going to downsample again from 400 to 200.  Because the bayer lines alternate
 594:../src/frame_m0.c **** 	// there tends to be little difference between line pairs bg and gr lines after downsampling.
 595:../src/frame_m0.c **** 	// Same logic applies horizontally as well, but we always skip a pixel pair in the line routine.  
 596:../src/frame_m0.c **** 	lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore, memory, xoffset, xwidth); // wait, grab, wait
 1982              		.loc 1 596 0
 1983 005c 2348     		ldr	r0, .L48
 1984 005e 3969     		ldr	r1, [r7, #16]
 1985 0060 BA6A     		ldr	r2, [r7, #40]
 1986 0062 FC68     		ldr	r4, [r7, #12]
 1987 0064 7B68     		ldr	r3, [r7, #4]
 1988 0066 0093     		str	r3, [sp]
 1989 0068 231C     		mov	r3, r4
 1990 006a FFF7FEFF 		bl	lineM1R2Merge
 597:../src/frame_m0.c **** 	memory += xwidth;
 1991              		.loc 1 597 0
 1992 006e BA6A     		ldr	r2, [r7, #40]
 1993 0070 7B68     		ldr	r3, [r7, #4]
 1994 0072 D318     		add	r3, r2, r3
 1995 0074 BB62     		str	r3, [r7, #40]
 598:../src/frame_m0.c **** 	for (line=0; line<ywidth; line+=2, memory+=xwidth*2)
 1996              		.loc 1 598 0
 1997 0076 0023     		mov	r3, #0
 1998 0078 7B61     		str	r3, [r7, #20]
 1999 007a 30E0     		b	.L45
 2000              	.L47:
 599:../src/frame_m0.c **** 	{
 600:../src/frame_m0.c **** 		// CAM_HSYNC is negated here
 601:../src/frame_m0.c **** 		lineM1R2((uint32_t *)&CAM_PORT, lineStore, xoffset, xwidth); // wait, grab, wait
 2001              		.loc 1 601 0
 2002 007c 1B48     		ldr	r0, .L48
 2003 007e 3969     		ldr	r1, [r7, #16]
 2004 0080 FA68     		ldr	r2, [r7, #12]
 2005 0082 7B68     		ldr	r3, [r7, #4]
 2006 0084 FFF7FEFF 		bl	lineM1R2
 602:../src/frame_m0.c **** 		lineM1R2((uint32_t *)&CAM_PORT, lineStore+xwidth, xoffset, xwidth); // wait, grab, wait
 2007              		.loc 1 602 0
 2008 0088 7B68     		ldr	r3, [r7, #4]
 2009 008a 5B00     		lsl	r3, r3, #1
 2010 008c 3A69     		ldr	r2, [r7, #16]
 2011 008e D118     		add	r1, r2, r3
 2012 0090 1648     		ldr	r0, .L48
 2013 0092 FA68     		ldr	r2, [r7, #12]
 2014 0094 7B68     		ldr	r3, [r7, #4]
 2015 0096 FFF7FEFF 		bl	lineM1R2
 603:../src/frame_m0.c **** 		lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore, memory, xoffset, xwidth); // wait, grab, wait
 2016              		.loc 1 603 0
 2017 009a 1448     		ldr	r0, .L48
 2018 009c 3969     		ldr	r1, [r7, #16]
 2019 009e BA6A     		ldr	r2, [r7, #40]
 2020 00a0 FC68     		ldr	r4, [r7, #12]
 2021 00a2 7B68     		ldr	r3, [r7, #4]
 2022 00a4 0093     		str	r3, [sp]
 2023 00a6 231C     		mov	r3, r4
 2024 00a8 FFF7FEFF 		bl	lineM1R2Merge
 604:../src/frame_m0.c **** 		if (line<CAM_RES2_HEIGHT-2)
 2025              		.loc 1 604 0
 2026 00ac 7B69     		ldr	r3, [r7, #20]
 2027 00ae C52B     		cmp	r3, #197
 2028 00b0 0DD8     		bhi	.L46
 605:../src/frame_m0.c **** 			lineM1R2Merge((uint32_t *)&CAM_PORT, lineStore+xwidth, memory+xwidth, xoffset, xwidth); // wait,
 2029              		.loc 1 605 0
 2030 00b2 7B68     		ldr	r3, [r7, #4]
 2031 00b4 5B00     		lsl	r3, r3, #1
 2032 00b6 3A69     		ldr	r2, [r7, #16]
 2033 00b8 D118     		add	r1, r2, r3
 2034 00ba BA6A     		ldr	r2, [r7, #40]
 2035 00bc 7B68     		ldr	r3, [r7, #4]
 2036 00be D218     		add	r2, r2, r3
 2037 00c0 0A48     		ldr	r0, .L48
 2038 00c2 FC68     		ldr	r4, [r7, #12]
 2039 00c4 7B68     		ldr	r3, [r7, #4]
 2040 00c6 0093     		str	r3, [sp]
 2041 00c8 231C     		mov	r3, r4
 2042 00ca FFF7FEFF 		bl	lineM1R2Merge
 2043              	.L46:
 598:../src/frame_m0.c **** 	{
 2044              		.loc 1 598 0 discriminator 2
 2045 00ce 7B69     		ldr	r3, [r7, #20]
 2046 00d0 0233     		add	r3, r3, #2
 2047 00d2 7B61     		str	r3, [r7, #20]
 2048 00d4 7B68     		ldr	r3, [r7, #4]
 2049 00d6 5B00     		lsl	r3, r3, #1
 2050 00d8 BA6A     		ldr	r2, [r7, #40]
 2051 00da D318     		add	r3, r2, r3
 2052 00dc BB62     		str	r3, [r7, #40]
 2053              	.L45:
 598:../src/frame_m0.c **** 	{
 2054              		.loc 1 598 0 is_stmt 0 discriminator 1
 2055 00de 7A69     		ldr	r2, [r7, #20]
 2056 00e0 3B68     		ldr	r3, [r7]
 2057 00e2 9A42     		cmp	r2, r3
 2058 00e4 CAD3     		bcc	.L47
 606:../src/frame_m0.c **** 	}					
 607:../src/frame_m0.c **** }
 2059              		.loc 1 607 0 is_stmt 1
 2060 00e6 BD46     		mov	sp, r7
 2061 00e8 07B0     		add	sp, sp, #28
 2062              		@ sp needed
 2063 00ea 90BD     		pop	{r4, r7, pc}
 2064              	.L49:
 2065              		.align	2
 2066              	.L48:
 2067 00ec 04610F40 		.word	1074749700
 2068              		.cfi_endproc
 2069              	.LFE43:
 2071              		.section	.text.callSyncM0,"ax",%progbits
 2072              		.align	2
 2073              		.global	callSyncM0
 2074              		.code	16
 2075              		.thumb_func
 2077              	callSyncM0:
 2078              	.LFB44:
 608:../src/frame_m0.c **** 
 609:../src/frame_m0.c **** 
 610:../src/frame_m0.c **** void callSyncM0(void)
 611:../src/frame_m0.c **** {
 2079              		.loc 1 611 0
 2080              		.cfi_startproc
 2081 0000 80B5     		push	{r7, lr}
 2082              		.cfi_def_cfa_offset 8
 2083              		.cfi_offset 7, -8
 2084              		.cfi_offset 14, -4
 2085 0002 00AF     		add	r7, sp, #0
 2086              		.cfi_def_cfa_register 7
 612:../src/frame_m0.c **** 	syncM0((uint32_t *)&CAM_PORT, CAM_PCLK_MASK);
 2087              		.loc 1 612 0
 2088 0004 044A     		ldr	r2, .L51
 2089 0006 8023     		mov	r3, #128
 2090 0008 9B01     		lsl	r3, r3, #6
 2091 000a 101C     		mov	r0, r2
 2092 000c 191C     		mov	r1, r3
 2093 000e FFF7FEFF 		bl	syncM0
 613:../src/frame_m0.c **** }
 2094              		.loc 1 613 0
 2095 0012 BD46     		mov	sp, r7
 2096              		@ sp needed
 2097 0014 80BD     		pop	{r7, pc}
 2098              	.L52:
 2099 0016 C046     		.align	2
 2100              	.L51:
 2101 0018 04610F40 		.word	1074749700
 2102              		.cfi_endproc
 2103              	.LFE44:
 2105              		.section	.text.callSyncM1,"ax",%progbits
 2106              		.align	2
 2107              		.global	callSyncM1
 2108              		.code	16
 2109              		.thumb_func
 2111              	callSyncM1:
 2112              	.LFB45:
 614:../src/frame_m0.c **** 
 615:../src/frame_m0.c **** 
 616:../src/frame_m0.c **** void callSyncM1(void)
 617:../src/frame_m0.c **** {
 2113              		.loc 1 617 0
 2114              		.cfi_startproc
 2115 0000 80B5     		push	{r7, lr}
 2116              		.cfi_def_cfa_offset 8
 2117              		.cfi_offset 7, -8
 2118              		.cfi_offset 14, -4
 2119 0002 00AF     		add	r7, sp, #0
 2120              		.cfi_def_cfa_register 7
 618:../src/frame_m0.c **** 	syncM1((uint32_t *)&CAM_PORT, CAM_PCLK_MASK);
 2121              		.loc 1 618 0
 2122 0004 044A     		ldr	r2, .L54
 2123 0006 8023     		mov	r3, #128
 2124 0008 9B01     		lsl	r3, r3, #6
 2125 000a 101C     		mov	r0, r2
 2126 000c 191C     		mov	r1, r3
 2127 000e FFF7FEFF 		bl	syncM1
 619:../src/frame_m0.c **** }
 2128              		.loc 1 619 0
 2129 0012 BD46     		mov	sp, r7
 2130              		@ sp needed
 2131 0014 80BD     		pop	{r7, pc}
 2132              	.L55:
 2133 0016 C046     		.align	2
 2134              	.L54:
 2135 0018 04610F40 		.word	1074749700
 2136              		.cfi_endproc
 2137              	.LFE45:
 2139              		.section	.text.getFrame,"ax",%progbits
 2140              		.align	2
 2141              		.global	getFrame
 2142              		.code	16
 2143              		.thumb_func
 2145              	getFrame:
 2146              	.LFB46:
 620:../src/frame_m0.c **** 
 621:../src/frame_m0.c **** 
 622:../src/frame_m0.c **** int32_t getFrame(uint8_t *type, uint32_t *memory, uint16_t *xoffset, uint16_t *yoffset, uint16_t *x
 623:../src/frame_m0.c **** {
 2147              		.loc 1 623 0
 2148              		.cfi_startproc
 2149 0000 90B5     		push	{r4, r7, lr}
 2150              		.cfi_def_cfa_offset 12
 2151              		.cfi_offset 4, -12
 2152              		.cfi_offset 7, -8
 2153              		.cfi_offset 14, -4
 2154 0002 87B0     		sub	sp, sp, #28
 2155              		.cfi_def_cfa_offset 40
 2156 0004 02AF     		add	r7, sp, #8
 2157              		.cfi_def_cfa 7, 32
 2158 0006 F860     		str	r0, [r7, #12]
 2159 0008 B960     		str	r1, [r7, #8]
 2160 000a 7A60     		str	r2, [r7, #4]
 2161 000c 3B60     		str	r3, [r7]
 624:../src/frame_m0.c **** 	//printf("M0: grab %d %d %d %d %d\n", *type, *xoffset, *yoffset, *xwidth, *ywidth);
 625:../src/frame_m0.c **** 
 626:../src/frame_m0.c **** 	if (*type==CAM_GRAB_M0R0)
 2162              		.loc 1 626 0
 2163 000e FB68     		ldr	r3, [r7, #12]
 2164 0010 1B78     		ldrb	r3, [r3]
 2165 0012 002B     		cmp	r3, #0
 2166 0014 12D1     		bne	.L57
 627:../src/frame_m0.c **** 		grabM0R0(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2167              		.loc 1 627 0
 2168 0016 7B68     		ldr	r3, [r7, #4]
 2169 0018 1B88     		ldrh	r3, [r3]
 2170 001a 181C     		mov	r0, r3
 2171 001c 3B68     		ldr	r3, [r7]
 2172 001e 1B88     		ldrh	r3, [r3]
 2173 0020 191C     		mov	r1, r3
 2174 0022 3B6A     		ldr	r3, [r7, #32]
 2175 0024 1B88     		ldrh	r3, [r3]
 2176 0026 1A1C     		mov	r2, r3
 2177 0028 7B6A     		ldr	r3, [r7, #36]
 2178 002a 1B88     		ldrh	r3, [r3]
 2179 002c 1C1C     		mov	r4, r3
 2180 002e BB68     		ldr	r3, [r7, #8]
 2181 0030 1B68     		ldr	r3, [r3]
 2182 0032 0093     		str	r3, [sp]
 2183 0034 231C     		mov	r3, r4
 2184 0036 FFF7FEFF 		bl	grabM0R0
 2185 003a 30E0     		b	.L58
 2186              	.L57:
 628:../src/frame_m0.c **** 	else if (*type==CAM_GRAB_M1R1)
 2187              		.loc 1 628 0
 2188 003c FB68     		ldr	r3, [r7, #12]
 2189 003e 1B78     		ldrb	r3, [r3]
 2190 0040 112B     		cmp	r3, #17
 2191 0042 12D1     		bne	.L59
 629:../src/frame_m0.c **** 		grabM1R1(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2192              		.loc 1 629 0
 2193 0044 7B68     		ldr	r3, [r7, #4]
 2194 0046 1B88     		ldrh	r3, [r3]
 2195 0048 181C     		mov	r0, r3
 2196 004a 3B68     		ldr	r3, [r7]
 2197 004c 1B88     		ldrh	r3, [r3]
 2198 004e 191C     		mov	r1, r3
 2199 0050 3B6A     		ldr	r3, [r7, #32]
 2200 0052 1B88     		ldrh	r3, [r3]
 2201 0054 1A1C     		mov	r2, r3
 2202 0056 7B6A     		ldr	r3, [r7, #36]
 2203 0058 1B88     		ldrh	r3, [r3]
 2204 005a 1C1C     		mov	r4, r3
 2205 005c BB68     		ldr	r3, [r7, #8]
 2206 005e 1B68     		ldr	r3, [r3]
 2207 0060 0093     		str	r3, [sp]
 2208 0062 231C     		mov	r3, r4
 2209 0064 FFF7FEFF 		bl	grabM1R1
 2210 0068 19E0     		b	.L58
 2211              	.L59:
 630:../src/frame_m0.c **** 	else if (*type==CAM_GRAB_M1R2)
 2212              		.loc 1 630 0
 2213 006a FB68     		ldr	r3, [r7, #12]
 2214 006c 1B78     		ldrb	r3, [r3]
 2215 006e 212B     		cmp	r3, #33
 2216 0070 12D1     		bne	.L60
 631:../src/frame_m0.c **** 		grabM1R2(*xoffset, *yoffset, *xwidth, *ywidth, (uint8_t *)*memory);
 2217              		.loc 1 631 0
 2218 0072 7B68     		ldr	r3, [r7, #4]
 2219 0074 1B88     		ldrh	r3, [r3]
 2220 0076 181C     		mov	r0, r3
 2221 0078 3B68     		ldr	r3, [r7]
 2222 007a 1B88     		ldrh	r3, [r3]
 2223 007c 191C     		mov	r1, r3
 2224 007e 3B6A     		ldr	r3, [r7, #32]
 2225 0080 1B88     		ldrh	r3, [r3]
 2226 0082 1A1C     		mov	r2, r3
 2227 0084 7B6A     		ldr	r3, [r7, #36]
 2228 0086 1B88     		ldrh	r3, [r3]
 2229 0088 1C1C     		mov	r4, r3
 2230 008a BB68     		ldr	r3, [r7, #8]
 2231 008c 1B68     		ldr	r3, [r3]
 2232 008e 0093     		str	r3, [sp]
 2233 0090 231C     		mov	r3, r4
 2234 0092 FFF7FEFF 		bl	grabM1R2
 2235 0096 02E0     		b	.L58
 2236              	.L60:
 632:../src/frame_m0.c **** 	else
 633:../src/frame_m0.c **** 		return -1;
 2237              		.loc 1 633 0
 2238 0098 0123     		mov	r3, #1
 2239 009a 5B42     		neg	r3, r3
 2240 009c 00E0     		b	.L61
 2241              	.L58:
 634:../src/frame_m0.c **** 
 635:../src/frame_m0.c **** 	return 0;
 2242              		.loc 1 635 0
 2243 009e 0023     		mov	r3, #0
 2244              	.L61:
 636:../src/frame_m0.c **** }
 2245              		.loc 1 636 0
 2246 00a0 181C     		mov	r0, r3
 2247 00a2 BD46     		mov	sp, r7
 2248 00a4 05B0     		add	sp, sp, #20
 2249              		@ sp needed
 2250 00a6 90BD     		pop	{r4, r7, pc}
 2251              		.cfi_endproc
 2252              	.LFE46:
 2254              		.section	.rodata
 2255              		.align	2
 2256              	.LC0:
 2257 0000 67657446 		.ascii	"getFrame\000"
 2257      72616D65 
 2257      00
 2258 0009 000000   		.section	.text.frame_init,"ax",%progbits
 2259              		.align	2
 2260              		.global	frame_init
 2261              		.code	16
 2262              		.thumb_func
 2264              	frame_init:
 2265              	.LFB47:
 637:../src/frame_m0.c **** 
 638:../src/frame_m0.c **** 
 639:../src/frame_m0.c **** int frame_init(void)
 640:../src/frame_m0.c **** {
 2266              		.loc 1 640 0
 2267              		.cfi_startproc
 2268 0000 80B5     		push	{r7, lr}
 2269              		.cfi_def_cfa_offset 8
 2270              		.cfi_offset 7, -8
 2271              		.cfi_offset 14, -4
 2272 0002 00AF     		add	r7, sp, #0
 2273              		.cfi_def_cfa_register 7
 641:../src/frame_m0.c **** 	chirpSetProc("getFrame", (ProcPtr)getFrame);
 2274              		.loc 1 641 0
 2275 0004 044A     		ldr	r2, .L64
 2276 0006 054B     		ldr	r3, .L64+4
 2277 0008 101C     		mov	r0, r2
 2278 000a 191C     		mov	r1, r3
 2279 000c FFF7FEFF 		bl	chirpSetProc
 642:../src/frame_m0.c **** 		
 643:../src/frame_m0.c **** 	return 0;	
 2280              		.loc 1 643 0
 2281 0010 0023     		mov	r3, #0
 644:../src/frame_m0.c **** }
 2282              		.loc 1 644 0
 2283 0012 181C     		mov	r0, r3
 2284 0014 BD46     		mov	sp, r7
 2285              		@ sp needed
 2286 0016 80BD     		pop	{r7, pc}
 2287              	.L65:
 2288              		.align	2
 2289              	.L64:
 2290 0018 00000000 		.word	.LC0
 2291 001c 00000000 		.word	getFrame
 2292              		.cfi_endproc
 2293              	.LFE47:
 2295              		.text
 2296              	.Letext0:
 2297              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
 2298              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
 2299              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
 2300              		.file 5 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 frame_m0.c
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:18     .text.vsync:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:23     .text.vsync:00000000 vsync
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:107    .text.vsync:00000064 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:113    .text.syncM0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:118    .text.syncM0:00000000 syncM0
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:142    .text.syncM0:0000000c start
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:234    .text.syncM1:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:239    .text.syncM1:00000000 syncM1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:263    .text.syncM1:0000000c startSyncM1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:439    .text.lineM0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:444    .text.lineM0:00000000 lineM0
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2077   .text.callSyncM0:00000000 callSyncM0
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:502    .text.lineM0:00000022 dest21
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:518    .text.lineM0:00000028 dest22
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:594    .text.lineM0:0000004c loop11
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:638    .text.lineM0:00000060 dest13
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:670    .text.lineM1R1:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:675    .text.lineM1R1:00000000 lineM1R1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2111   .text.callSyncM1:00000000 callSyncM1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:725    .text.lineM1R1:0000001e dest1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:741    .text.lineM1R1:00000024 dest2
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:841    .text.lineM1R1:00000054 loop1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:877    .text.lineM1R1:00000064 dest3
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:909    .text.lineM1R2:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:914    .text.lineM1R2:00000000 lineM1R2
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:968    .text.lineM1R2:00000020 dest7
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:984    .text.lineM1R2:00000026 dest8
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1084   .text.lineM1R2:00000056 loop3
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1248   .text.lineM1R2:000000a6 dest9
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1280   .text.lineM1R2Merge:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1285   .text.lineM1R2Merge:00000000 lineM1R2Merge
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1339   .text.lineM1R2Merge:00000020 dest4
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1355   .text.lineM1R2Merge:00000026 dest5
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1455   .text.lineM1R2Merge:00000056 loop4
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1611   .text.lineM1R2Merge:000000a2 dest6
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1643   .text.skipLine:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1648   .text.skipLine:00000000 skipLine
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1687   .text.skipLine:00000028 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1693   .text.skipLines:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1698   .text.skipLines:00000000 skipLines
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1758   .text.skipLines:00000048 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1764   .text.grabM0R0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1769   .text.grabM0R0:00000000 grabM0R0
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1831   .text.grabM0R0:00000054 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1836   .text.grabM1R1:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1841   .text.grabM1R1:00000000 grabM1R1
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1903   .text.grabM1R1:00000054 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1908   .text.grabM1R2:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:1913   .text.grabM1R2:00000000 grabM1R2
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2067   .text.grabM1R2:000000ec $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2072   .text.callSyncM0:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2101   .text.callSyncM0:00000018 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2106   .text.callSyncM1:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2135   .text.callSyncM1:00000018 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2140   .text.getFrame:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2145   .text.getFrame:00000000 getFrame
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2255   .rodata:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2259   .text.frame_init:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2264   .text.frame_init:00000000 frame_init
C:\Users\OUROBO~1\AppData\Local\Temp\ccIGpanw.s:2290   .text.frame_init:00000018 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
chirpSetProc
