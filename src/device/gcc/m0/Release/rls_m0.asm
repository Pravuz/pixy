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
  13              		.file	"rls_m0.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.global	g_logLut
  18              		.section	.bss.g_logLut,"aw",%nobits
  19              		.align	2
  22              	g_logLut:
  23 0000 00000000 		.space	4
  24              		.section	.text.lineProcessedRL0A,"ax",%progbits
  25              		.align	2
  26              		.global	lineProcessedRL0A
  27              		.code	16
  28              		.thumb_func
  30              	lineProcessedRL0A:
  31              	.LFB32:
  32              		.file 1 "../src/rls_m0.c"
   1:../src/rls_m0.c **** //
   2:../src/rls_m0.c **** // begin license header
   3:../src/rls_m0.c **** //
   4:../src/rls_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/rls_m0.c **** //
   6:../src/rls_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/rls_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/rls_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/rls_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/rls_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/rls_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/rls_m0.c **** //
  13:../src/rls_m0.c **** // end license header
  14:../src/rls_m0.c **** //
  15:../src/rls_m0.c **** 
  16:../src/rls_m0.c **** #include "rls_m0.h"
  17:../src/rls_m0.c **** #include "frame_m0.h"
  18:../src/rls_m0.c **** #include "chirp.h"
  19:../src/rls_m0.c **** #include "qqueue.h"
  20:../src/rls_m0.c **** 
  21:../src/rls_m0.c **** 
  22:../src/rls_m0.c **** //#define RLTEST
  23:../src/rls_m0.c **** #define MAX_QVALS_PER_LINE 	CAM_RES2_WIDTH/5	 // width/5 because that's the worst case with noise f
  24:../src/rls_m0.c **** 
  25:../src/rls_m0.c **** uint8_t *g_logLut = NULL;
  26:../src/rls_m0.c **** 
  27:../src/rls_m0.c **** #if 0 // this is the old method, might have use down the road....
  28:../src/rls_m0.c **** // assemble blue-green words to look like this
  29:../src/rls_m0.c **** // 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
  30:../src/rls_m0.c **** //                                                  B  B  B  B  B  G G G G G
  31:../src/rls_m0.c **** __asm void lineProcessedRL0(uint32_t *gpio, uint16_t *memory, uint32_t width)
  32:../src/rls_m0.c **** { 
  33:../src/rls_m0.c **** 		PRESERVE8
  34:../src/rls_m0.c **** 		IMPORT 	callSyncM1
  35:../src/rls_m0.c **** 
  36:../src/rls_m0.c **** 		PUSH	{r4-r5, lr}
  37:../src/rls_m0.c **** 
  38:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
  39:../src/rls_m0.c **** 		ADDS	r2, r1
  40:../src/rls_m0.c **** 		// generate hsync bit
  41:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
  42:../src/rls_m0.c **** 		LSLS	r5, #11
  43:../src/rls_m0.c **** 
  44:../src/rls_m0.c **** 		PUSH	{r0-r3} // save args
  45:../src/rls_m0.c **** 		BL.W	callSyncM1 // get pixel sync
  46:../src/rls_m0.c **** 		POP		{r0-r3}	// restore args
  47:../src/rls_m0.c **** 	   
  48:../src/rls_m0.c **** 	   	// pixel sync starts here
  49:../src/rls_m0.c **** 
  50:../src/rls_m0.c **** 		// wait for hsync to go high
  51:../src/rls_m0.c **** dest10	LDR 	r3, [r0] 	// 2
  52:../src/rls_m0.c **** 		TST		r3, r5		// 1
  53:../src/rls_m0.c **** 		BEQ		dest10		// 3
  54:../src/rls_m0.c **** 
  55:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
  56:../src/rls_m0.c **** 		asm("NOP");
  57:../src/rls_m0.c **** 		asm("NOP");
  58:../src/rls_m0.c **** 
  59:../src/rls_m0.c **** #if 0
  60:../src/rls_m0.c **** loop5
  61:../src/rls_m0.c **** 		LDRB 	r3, [r0] 	  
  62:../src/rls_m0.c **** 		STRB 	r3, [r1]
  63:../src/rls_m0.c **** 		asm("NOP");
  64:../src/rls_m0.c **** 		asm("NOP");
  65:../src/rls_m0.c **** 		asm("NOP");
  66:../src/rls_m0.c **** 		ADDS	r1, #0x01
  67:../src/rls_m0.c **** 		CMP		r1, r2
  68:../src/rls_m0.c **** 		BLT		loop5
  69:../src/rls_m0.c **** #else
  70:../src/rls_m0.c **** loop5
  71:../src/rls_m0.c **** 		LDRB 	r3, [r0] // blue
  72:../src/rls_m0.c **** 		LSRS    r3, #3
  73:../src/rls_m0.c **** 		LSLS    r3, #10
  74:../src/rls_m0.c **** 		asm("NOP");
  75:../src/rls_m0.c **** 		asm("NOP");
  76:../src/rls_m0.c **** 		asm("NOP");
  77:../src/rls_m0.c **** 		asm("NOP");
  78:../src/rls_m0.c **** 		asm("NOP");
  79:../src/rls_m0.c **** 		asm("NOP");
  80:../src/rls_m0.c **** 		asm("NOP");
  81:../src/rls_m0.c **** 		asm("NOP");
  82:../src/rls_m0.c **** 
  83:../src/rls_m0.c **** 		LDRB 	r4, [r0] // green 	  
  84:../src/rls_m0.c **** 		LSRS    r4, #3
  85:../src/rls_m0.c **** 		LSLS    r4, #5
  86:../src/rls_m0.c **** 		ORRS	r3, r4
  87:../src/rls_m0.c **** 		STRH    r3,	[r1] // store blue/green
  88:../src/rls_m0.c **** 		ADDS    r1, #0x02
  89:../src/rls_m0.c **** 		CMP		r1, r2
  90:../src/rls_m0.c **** 		BLT		loop5
  91:../src/rls_m0.c **** 
  92:../src/rls_m0.c **** #endif
  93:../src/rls_m0.c **** 		// wait for hsync to go low (end of line)
  94:../src/rls_m0.c **** dest11	LDR 	r3, [r0] 	// 2
  95:../src/rls_m0.c **** 		TST		r3, r5		// 1
  96:../src/rls_m0.c **** 		BNE		dest11		// 3
  97:../src/rls_m0.c **** 
  98:../src/rls_m0.c **** 		POP		{r4-r5, pc}
  99:../src/rls_m0.c **** }
 100:../src/rls_m0.c **** 
 101:../src/rls_m0.c **** __asm uint16_t *lineProcessedRL1(uint32_t *gpio, uint16_t *memory, uint8_t *lut, uint16_t *linestor
 102:../src/rls_m0.c **** {
 103:../src/rls_m0.c **** // r0: gpio
 104:../src/rls_m0.c **** // r1: q memory
 105:../src/rls_m0.c **** // r2: lut
 106:../src/rls_m0.c **** // r3: prev line
 107:../src/rls_m0.c **** // r4: col 
 108:../src/rls_m0.c **** // r5: scratch
 109:../src/rls_m0.c **** // r6: scratch
 110:../src/rls_m0.c **** // r7: prev m val
 111:../src/rls_m0.c **** 		PRESERVE8
 112:../src/rls_m0.c **** 		IMPORT 	callSyncM1
 113:../src/rls_m0.c **** 
 114:../src/rls_m0.c **** 		PUSH	{r4-r7, lr}
 115:../src/rls_m0.c **** 		LDR		r4, [sp, #0x14]
 116:../src/rls_m0.c **** 
 117:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
 118:../src/rls_m0.c **** 		ADDS	r4, r3
 119:../src/rls_m0.c **** 	   	MOV		r8, r4
 120:../src/rls_m0.c **** 		// generate hsync bit
 121:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
 122:../src/rls_m0.c **** 		LSLS	r5, #11
 123:../src/rls_m0.c **** 
 124:../src/rls_m0.c **** 		PUSH	{r0-r3} // save args
 125:../src/rls_m0.c **** 		BL.W	callSyncM1 // get pixel sync
 126:../src/rls_m0.c **** 		POP		{r0-r3}	// restore args
 127:../src/rls_m0.c **** 	   
 128:../src/rls_m0.c **** 	   	// pixel sync starts here
 129:../src/rls_m0.c **** 		
 130:../src/rls_m0.c **** 		// wait for hsync to go high
 131:../src/rls_m0.c **** dest12	LDR 	r6, [r0] 	// 2
 132:../src/rls_m0.c **** 		TST		r6, r5		// 1
 133:../src/rls_m0.c **** 		BEQ		dest12		// 3
 134:../src/rls_m0.c **** 
 135:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
 136:../src/rls_m0.c **** 	    asm("NOP");
 137:../src/rls_m0.c **** 		//(borrow asm("NOP"); below)
 138:../src/rls_m0.c **** 		// skip green pixel
 139:../src/rls_m0.c **** 		MOVS    r5, #0x00 // clear r5 (which will be copied to r7) This will force a write of a q val 
 140:../src/rls_m0.c **** 		MOVS	r4, #0x00 // clear col (col is numbered 1 to 320)
 141:../src/rls_m0.c **** // 2
 142:../src/rls_m0.c **** loop6	MOV		r7, r5 // copy lut val (lutPrev)
 143:../src/rls_m0.c **** 		MOV		r5, r8
 144:../src/rls_m0.c **** 		CMP		r3, r5
 145:../src/rls_m0.c **** 		BGE		dest30
 146:../src/rls_m0.c **** 		asm("NOP");
 147:../src/rls_m0.c **** 		asm("NOP");
 148:../src/rls_m0.c **** 		asm("NOP");
 149:../src/rls_m0.c **** 		asm("NOP");
 150:../src/rls_m0.c **** 		asm("NOP");
 151:../src/rls_m0.c **** // 9
 152:../src/rls_m0.c **** loop7	
 153:../src/rls_m0.c **** 		LDRH	r5, [r3] // load blue green val
 154:../src/rls_m0.c **** // 2
 155:../src/rls_m0.c **** 		LDRB 	r6, [r0] // load red pixel
 156:../src/rls_m0.c **** 		LSRS    r6, #3	 // shift into place (5 bits of red)
 157:../src/rls_m0.c **** 		ORRS	r5, r6 // form 15-bit lut index
 158:../src/rls_m0.c **** 		ADDS    r3, #0x02 // inc prev line pointer
 159:../src/rls_m0.c **** 		ADDS	r4, #0x01 // inc col
 160:../src/rls_m0.c **** 		asm("NOP");
 161:../src/rls_m0.c **** 		LDRB	r5, [r2, r5] // load lut val
 162:../src/rls_m0.c **** 		EORS  	r7, r5 // compare with previous	lut val
 163:../src/rls_m0.c **** // 10
 164:../src/rls_m0.c **** 		BEQ	   	loop6 // if lut vals have haven't changed proceed (else store q val)
 165:../src/rls_m0.c **** // 1, 3
 166:../src/rls_m0.c **** 		// calc, store q val
 167:../src/rls_m0.c **** 		LSLS	r5, #0x09
 168:../src/rls_m0.c **** 		ORRS	r5, r4 // make q val
 169:../src/rls_m0.c **** 		STRH	r5, [r1] // write q val
 170:../src/rls_m0.c **** 		ADDS	r1, #0x02 // inc q mem
 171:../src/rls_m0.c **** 		MOV		r7, r5 // copy lut val (qPrev)
 172:../src/rls_m0.c **** // 6
 173:../src/rls_m0.c **** 
 174:../src/rls_m0.c **** 		MOV 	r5, r8 // bring in end of row compare val
 175:../src/rls_m0.c **** 		CMP		r3, r5
 176:../src/rls_m0.c **** 		BLT		loop7
 177:../src/rls_m0.c **** // 5
 178:../src/rls_m0.c **** dest30
 179:../src/rls_m0.c **** 	  	MOVS	r5, #0x1
 180:../src/rls_m0.c **** 		LSLS	r5, #11
 181:../src/rls_m0.c **** dest20	LDR 	r6, [r0] 	// 2
 182:../src/rls_m0.c **** 		TST		r6, r5		// 1
 183:../src/rls_m0.c **** 		BNE		dest20		// 3
 184:../src/rls_m0.c **** 
 185:../src/rls_m0.c **** 		MOV     r0, r1 // move result
 186:../src/rls_m0.c **** 		POP		{r4-r7, pc}
 187:../src/rls_m0.c **** } 
 188:../src/rls_m0.c **** #endif
 189:../src/rls_m0.c **** 
 190:../src/rls_m0.c **** void lineProcessedRL0A(uint32_t *gpio, uint8_t *memory, uint32_t width) // width in bytes
 191:../src/rls_m0.c **** { 
  33              		.loc 1 191 0
  34              		.cfi_startproc
  35 0000 80B5     		push	{r7, lr}
  36              		.cfi_def_cfa_offset 8
  37              		.cfi_offset 7, -8
  38              		.cfi_offset 14, -4
  39 0002 84B0     		sub	sp, sp, #16
  40              		.cfi_def_cfa_offset 24
  41 0004 00AF     		add	r7, sp, #0
  42              		.cfi_def_cfa_register 7
  43 0006 F860     		str	r0, [r7, #12]
  44 0008 B960     		str	r1, [r7, #8]
  45 000a 7A60     		str	r2, [r7, #4]
 192:../src/rls_m0.c **** //		PRESERVE8
 193:../src/rls_m0.c **** 
 194:../src/rls_m0.c **** 	asm(".syntax unified");
  46              		.loc 1 194 0
  47              	@ 194 "../src/rls_m0.c" 1
  48              		.syntax unified
  49              	@ 0 "" 2
 195:../src/rls_m0.c **** 
 196:../src/rls_m0.c **** 		asm("PUSH	{r4-r5}");
  50              		.loc 1 196 0
  51              	@ 196 "../src/rls_m0.c" 1
  52 000c 30B4     		PUSH	{r4-r5}
  53              	@ 0 "" 2
 197:../src/rls_m0.c **** 
 198:../src/rls_m0.c **** 		// add width to memory pointer so we can compare
 199:../src/rls_m0.c **** 		asm("ADDS	r2, r1");
  54              		.loc 1 199 0
  55              	@ 199 "../src/rls_m0.c" 1
  56 000e 5218     		ADDS	r2, r1
  57              	@ 0 "" 2
 200:../src/rls_m0.c **** 		// generate hsync bit
 201:../src/rls_m0.c **** 		asm("MOVS	r5, #0x1");
  58              		.loc 1 201 0
  59              	@ 201 "../src/rls_m0.c" 1
  60 0010 0125     		MOVS	r5, #0x1
  61              	@ 0 "" 2
 202:../src/rls_m0.c **** 		asm("LSLS	r5, #11");
  62              		.loc 1 202 0
  63              	@ 202 "../src/rls_m0.c" 1
  64 0012 ED02     		LSLS	r5, #11
  65              	@ 0 "" 2
 203:../src/rls_m0.c **** 
 204:../src/rls_m0.c **** 		asm("PUSH	{r0-r3}"); // save args
  66              		.loc 1 204 0
  67              	@ 204 "../src/rls_m0.c" 1
  68 0014 0FB4     		PUSH	{r0-r3}
  69              	@ 0 "" 2
 205:../src/rls_m0.c **** 		asm("BL.W	callSyncM1"); // get pixel sync
  70              		.loc 1 205 0
  71              	@ 205 "../src/rls_m0.c" 1
  72 0016 FFF7FEFF 		BL.W	callSyncM1
  73              	@ 0 "" 2
 206:../src/rls_m0.c **** 		asm("POP	{r0-r3}");	// restore args
  74              		.loc 1 206 0
  75              	@ 206 "../src/rls_m0.c" 1
  76 001a 0FBC     		POP	{r0-r3}
  77              	@ 0 "" 2
 207:../src/rls_m0.c **** 	   
 208:../src/rls_m0.c **** 	   	// pixel sync starts here
 209:../src/rls_m0.c **** 
 210:../src/rls_m0.c **** 		// wait for hsync to go high
 211:../src/rls_m0.c **** asm("dest10A:");
  78              		.loc 1 211 0
  79              	@ 211 "../src/rls_m0.c" 1
  80              		dest10A:
  81              	@ 0 "" 2
 212:../src/rls_m0.c **** 		asm("LDR 	r3, [r0]"); 	// 2
  82              		.loc 1 212 0
  83              	@ 212 "../src/rls_m0.c" 1
  84 001c 0368     		LDR 	r3, [r0]
  85              	@ 0 "" 2
 213:../src/rls_m0.c **** 		asm("TST	r3, r5");		// 1
  86              		.loc 1 213 0
  87              	@ 213 "../src/rls_m0.c" 1
  88 001e 2B42     		TST	r3, r5
  89              	@ 0 "" 2
 214:../src/rls_m0.c **** 		asm("BEQ	dest10A");		// 3
  90              		.loc 1 214 0
  91              	@ 214 "../src/rls_m0.c" 1
  92 0020 FCD0     		BEQ	dest10A
  93              	@ 0 "" 2
 215:../src/rls_m0.c **** 
 216:../src/rls_m0.c **** 		// variable delay --- get correct phase for sampling
 217:../src/rls_m0.c **** 		asm("NOP");
  94              		.loc 1 217 0
  95              	@ 217 "../src/rls_m0.c" 1
  96 0022 C046     		NOP
  97              	@ 0 "" 2
 218:../src/rls_m0.c **** 		asm("NOP");
  98              		.loc 1 218 0
  99              	@ 218 "../src/rls_m0.c" 1
 100 0024 C046     		NOP
 101              	@ 0 "" 2
 219:../src/rls_m0.c **** 
 220:../src/rls_m0.c **** asm("loop5A:");
 102              		.loc 1 220 0
 103              	@ 220 "../src/rls_m0.c" 1
 104              		loop5A:
 105              	@ 0 "" 2
 221:../src/rls_m0.c **** 		asm("LDRB 	r3, [r0]"); // blue
 106              		.loc 1 221 0
 107              	@ 221 "../src/rls_m0.c" 1
 108 0026 0378     		LDRB 	r3, [r0]
 109              	@ 0 "" 2
 222:../src/rls_m0.c **** 		// cycle
 223:../src/rls_m0.c **** 		asm("NOP");
 110              		.loc 1 223 0
 111              	@ 223 "../src/rls_m0.c" 1
 112 0028 C046     		NOP
 113              	@ 0 "" 2
 224:../src/rls_m0.c **** 		asm("NOP");
 114              		.loc 1 224 0
 115              	@ 224 "../src/rls_m0.c" 1
 116 002a C046     		NOP
 117              	@ 0 "" 2
 225:../src/rls_m0.c **** 		asm("NOP");
 118              		.loc 1 225 0
 119              	@ 225 "../src/rls_m0.c" 1
 120 002c C046     		NOP
 121              	@ 0 "" 2
 226:../src/rls_m0.c **** 		asm("NOP");
 122              		.loc 1 226 0
 123              	@ 226 "../src/rls_m0.c" 1
 124 002e C046     		NOP
 125              	@ 0 "" 2
 227:../src/rls_m0.c **** 		asm("NOP");
 126              		.loc 1 227 0
 127              	@ 227 "../src/rls_m0.c" 1
 128 0030 C046     		NOP
 129              	@ 0 "" 2
 228:../src/rls_m0.c **** 		asm("NOP");
 130              		.loc 1 228 0
 131              	@ 228 "../src/rls_m0.c" 1
 132 0032 C046     		NOP
 133              	@ 0 "" 2
 229:../src/rls_m0.c **** 		asm("NOP");
 134              		.loc 1 229 0
 135              	@ 229 "../src/rls_m0.c" 1
 136 0034 C046     		NOP
 137              	@ 0 "" 2
 230:../src/rls_m0.c **** 		asm("NOP");
 138              		.loc 1 230 0
 139              	@ 230 "../src/rls_m0.c" 1
 140 0036 C046     		NOP
 141              	@ 0 "" 2
 231:../src/rls_m0.c **** 		asm("NOP");
 142              		.loc 1 231 0
 143              	@ 231 "../src/rls_m0.c" 1
 144 0038 C046     		NOP
 145              	@ 0 "" 2
 232:../src/rls_m0.c **** 		asm("NOP");
 146              		.loc 1 232 0
 147              	@ 232 "../src/rls_m0.c" 1
 148 003a C046     		NOP
 149              	@ 0 "" 2
 233:../src/rls_m0.c **** 
 234:../src/rls_m0.c **** 		asm("LDRB 	r4, [r0]"); // green
 150              		.loc 1 234 0
 151              	@ 234 "../src/rls_m0.c" 1
 152 003c 0478     		LDRB 	r4, [r0]
 153              	@ 0 "" 2
 235:../src/rls_m0.c **** 		// cycle 
 236:../src/rls_m0.c **** 		asm("SUBS	r3, r4");   // blue-green
 154              		.loc 1 236 0
 155              	@ 236 "../src/rls_m0.c" 1
 156 003e 1B1B     		SUBS	r3, r4
 157              	@ 0 "" 2
 237:../src/rls_m0.c **** 		asm("ASRS   r3, #1");
 158              		.loc 1 237 0
 159              	@ 237 "../src/rls_m0.c" 1
 160 0040 5B10     		ASRS   r3, #1
 161              	@ 0 "" 2
 238:../src/rls_m0.c **** 		asm("STRB   r3, [r1]"); // store blue-green
 162              		.loc 1 238 0
 163              	@ 238 "../src/rls_m0.c" 1
 164 0042 0B70     		STRB   r3, [r1]
 165              	@ 0 "" 2
 239:../src/rls_m0.c **** 		// cycle 
 240:../src/rls_m0.c **** 		asm("ADDS   r1, #0x01");
 166              		.loc 1 240 0
 167              	@ 240 "../src/rls_m0.c" 1
 168 0044 0131     		ADDS   r1, #0x01
 169              	@ 0 "" 2
 241:../src/rls_m0.c **** 		asm("CMP	r1, r2");
 170              		.loc 1 241 0
 171              	@ 241 "../src/rls_m0.c" 1
 172 0046 9142     		CMP	r1, r2
 173              	@ 0 "" 2
 242:../src/rls_m0.c **** 		asm("NOP");
 174              		.loc 1 242 0
 175              	@ 242 "../src/rls_m0.c" 1
 176 0048 C046     		NOP
 177              	@ 0 "" 2
 243:../src/rls_m0.c **** 		asm("BLT	loop5A");
 178              		.loc 1 243 0
 179              	@ 243 "../src/rls_m0.c" 1
 180 004a ECDB     		BLT	loop5A
 181              	@ 0 "" 2
 244:../src/rls_m0.c **** 
 245:../src/rls_m0.c **** 		// wait for hsync to go low (end of line)
 246:../src/rls_m0.c **** asm("dest11A:");
 182              		.loc 1 246 0
 183              	@ 246 "../src/rls_m0.c" 1
 184              		dest11A:
 185              	@ 0 "" 2
 247:../src/rls_m0.c **** 		asm("LDR 	r3, [r0]"); 	// 2
 186              		.loc 1 247 0
 187              	@ 247 "../src/rls_m0.c" 1
 188 004c 0368     		LDR 	r3, [r0]
 189              	@ 0 "" 2
 248:../src/rls_m0.c **** 		asm("TST	r3, r5");		// 1
 190              		.loc 1 248 0
 191              	@ 248 "../src/rls_m0.c" 1
 192 004e 2B42     		TST	r3, r5
 193              	@ 0 "" 2
 249:../src/rls_m0.c **** 		asm("BNE	dest11A");		// 3
 194              		.loc 1 249 0
 195              	@ 249 "../src/rls_m0.c" 1
 196 0050 FCD1     		BNE	dest11A
 197              	@ 0 "" 2
 250:../src/rls_m0.c **** 
 251:../src/rls_m0.c **** 		asm("POP	{r4-r5}");
 198              		.loc 1 251 0
 199              	@ 251 "../src/rls_m0.c" 1
 200 0052 30BC     		POP	{r4-r5}
 201              	@ 0 "" 2
 252:../src/rls_m0.c **** 
 253:../src/rls_m0.c **** 		asm(".syntax divided");
 202              		.loc 1 253 0
 203              	@ 253 "../src/rls_m0.c" 1
 204              		.syntax divided
 205              	@ 0 "" 2
 254:../src/rls_m0.c **** }
 206              		.loc 1 254 0
 207              		.code	16
 208 0054 BD46     		mov	sp, r7
 209 0056 04B0     		add	sp, sp, #16
 210              		@ sp needed
 211 0058 80BD     		pop	{r7, pc}
 212              		.cfi_endproc
 213              	.LFE32:
 215 005a C046     		.section	.text.lineProcessedRL1A,"ax",%progbits
 216              		.align	2
 217              		.global	lineProcessedRL1A
 218              		.code	16
 219              		.thumb_func
 221              	lineProcessedRL1A:
 222              	.LFB33:
 255:../src/rls_m0.c **** 
 256:../src/rls_m0.c **** 
 257:../src/rls_m0.c **** uint32_t lineProcessedRL1A(uint32_t *gpio, Qval *memory, uint8_t *lut, uint8_t *linestore, uint32_t
 258:../src/rls_m0.c **** 	Qval *qqMem, uint32_t qqIndex, uint32_t qqSize) // width in bytes
 259:../src/rls_m0.c **** {
 223              		.loc 1 259 0
 224              		.cfi_startproc
 225 0000 80B5     		push	{r7, lr}
 226              		.cfi_def_cfa_offset 8
 227              		.cfi_offset 7, -8
 228              		.cfi_offset 14, -4
 229 0002 84B0     		sub	sp, sp, #16
 230              		.cfi_def_cfa_offset 24
 231 0004 00AF     		add	r7, sp, #0
 232              		.cfi_def_cfa_register 7
 233 0006 F860     		str	r0, [r7, #12]
 234 0008 B960     		str	r1, [r7, #8]
 235 000a 7A60     		str	r2, [r7, #4]
 236 000c 3B60     		str	r3, [r7]
 260:../src/rls_m0.c **** // The code below does the following---
 261:../src/rls_m0.c **** // -- maintain pixel sync, read red and green pixels
 262:../src/rls_m0.c **** // -- create r-g, b-g index and look up value in lut
 263:../src/rls_m0.c **** // -- filter out noise within the line.  An on pixel surrounded by off pixels will be ignored.
 264:../src/rls_m0.c **** //    An off pixel surrounded by on pixels will be ignored.
 265:../src/rls_m0.c **** // -- generate hue line sum	and pseudo average
 266:../src/rls_m0.c **** // -- generate run-length segments
 267:../src/rls_m0.c **** // 
 268:../src/rls_m0.c **** // Notes:
 269:../src/rls_m0.c **** // Run-length segments are 1 pixel larger than actual, and the last hue line value is added twice i
 270:../src/rls_m0.c **** // Spurious noise pixels within a run-length segment present a problem.  When this happens the last
 271:../src/rls_m0.c **** // is added to the sum to keep things unbiased.  ie, think of the case where a run-length consists 
 272:../src/rls_m0.c **** // spurious noise pixels.  We don't want the noise to affect the average--- only the pixels that ag
 273:../src/rls_m0.c **** // the model number for that run-length.
 274:../src/rls_m0.c **** // All pixels are read and used--- the opponent color space (r-g, b-g) works well with the bayer pa
 275:../src/rls_m0.c **** // After the red pixel is read, about 12 cycles are used to create the index and look it up.  When 
 276:../src/rls_m0.c **** // created and written it takes about 24 cycles, so a green/red pixel pair is skipped, but the gree
 277:../src/rls_m0.c **** // grabbed and put in r5 so that it can be used when we resume. 
 278:../src/rls_m0.c **** // A shift lut is provided-- it's 321 entries containing the log2 of the index, so it's basically a
 279:../src/rls_m0.c **** // that helps us fit the hue line sum in the q value.  This value indicates how many bits to shift 
 280:../src/rls_m0.c **** // the right to reduce the size of the sum.  That number is also stored in the q val so that it can
 281:../src/rls_m0.c **** // reversed on the m4 side and a real division can take place.   
 282:../src/rls_m0.c **** //
 283:../src/rls_m0.c **** // r0: gpio	register
 284:../src/rls_m0.c **** // r1: scratch 
 285:../src/rls_m0.c **** // r2: lut
 286:../src/rls_m0.c **** // r3: prev line
 287:../src/rls_m0.c **** // r4: column 
 288:../src/rls_m0.c **** // r5: scratch
 289:../src/rls_m0.c **** // r6: scratch
 290:../src/rls_m0.c **** // r7: prev model
 291:../src/rls_m0.c **** // r8: sum
 292:../src/rls_m0.c **** // r9: ending column
 293:../src/rls_m0.c **** // r10: beginning column of run-length
 294:../src/rls_m0.c **** // r11: last lut val
 295:../src/rls_m0.c **** // r12:	q memory
 296:../src/rls_m0.c **** 
 297:../src/rls_m0.c **** //		PRESERVE8
 298:../src/rls_m0.c **** 
 299:../src/rls_m0.c **** asm(".syntax unified");
 237              		.loc 1 299 0
 238              	@ 299 "../src/rls_m0.c" 1
 239              		.syntax unified
 240              	@ 0 "" 2
 300:../src/rls_m0.c **** 	asm("PUSH	{r1-r7}");
 241              		.loc 1 300 0
 242              	@ 300 "../src/rls_m0.c" 1
 243 000e FEB4     		PUSH	{r1-r7}
 244              	@ 0 "" 2
 301:../src/rls_m0.c **** 	// bring in ending column
 302:../src/rls_m0.c **** 	asm("LDR	r4, [sp, #0x20]");
 245              		.loc 1 302 0
 246              	@ 302 "../src/rls_m0.c" 1
 247 0010 089C     		LDR	r4, [sp, #0x20]
 248              	@ 0 "" 2
 303:../src/rls_m0.c **** 	asm("MOV	r9, r4");
 249              		.loc 1 303 0
 250              	@ 303 "../src/rls_m0.c" 1
 251 0012 A146     		MOV	r9, r4
 252              	@ 0 "" 2
 304:../src/rls_m0.c **** 	asm("MOVS	r5, #0x1");
 253              		.loc 1 304 0
 254              	@ 304 "../src/rls_m0.c" 1
 255 0014 0125     		MOVS	r5, #0x1
 256              	@ 0 "" 2
 305:../src/rls_m0.c **** 	asm("LSLS	r5, #11");
 257              		.loc 1 305 0
 258              	@ 305 "../src/rls_m0.c" 1
 259 0016 ED02     		LSLS	r5, #11
 260              	@ 0 "" 2
 306:../src/rls_m0.c **** 
 307:../src/rls_m0.c **** 	asm("PUSH	{r0-r3}"); // save args
 261              		.loc 1 307 0
 262              	@ 307 "../src/rls_m0.c" 1
 263 0018 0FB4     		PUSH	{r0-r3}
 264              	@ 0 "" 2
 308:../src/rls_m0.c **** 	asm("BL.W	callSyncM1"); // get pixel sync
 265              		.loc 1 308 0
 266              	@ 308 "../src/rls_m0.c" 1
 267 001a FFF7FEFF 		BL.W	callSyncM1
 268              	@ 0 "" 2
 309:../src/rls_m0.c **** 	asm("POP	{r0-r3}");	// restore args
 269              		.loc 1 309 0
 270              	@ 309 "../src/rls_m0.c" 1
 271 001e 0FBC     		POP	{r0-r3}
 272              	@ 0 "" 2
 310:../src/rls_m0.c **** 
 311:../src/rls_m0.c **** 	// pixel sync starts here
 312:../src/rls_m0.c **** 
 313:../src/rls_m0.c **** 	// wait for hsync to go high
 314:../src/rls_m0.c **** asm("dest12A:");
 273              		.loc 1 314 0
 274              	@ 314 "../src/rls_m0.c" 1
 275              		dest12A:
 276              	@ 0 "" 2
 315:../src/rls_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 277              		.loc 1 315 0
 278              	@ 315 "../src/rls_m0.c" 1
 279 0020 0668     		LDR 	r6, [r0]
 280              	@ 0 "" 2
 316:../src/rls_m0.c **** 	asm("TST	r6, r5");		// 1
 281              		.loc 1 316 0
 282              	@ 316 "../src/rls_m0.c" 1
 283 0022 2E42     		TST	r6, r5
 284              	@ 0 "" 2
 317:../src/rls_m0.c **** 	asm("BEQ	dest12A");	// 3
 285              		.loc 1 317 0
 286              	@ 317 "../src/rls_m0.c" 1
 287 0024 FCD0     		BEQ	dest12A
 288              	@ 0 "" 2
 318:../src/rls_m0.c **** 
 319:../src/rls_m0.c **** 	// variable delay --- get correct phase for sampling
 320:../src/rls_m0.c **** 	asm("MOV	r12, r1"); // save q memory
 289              		.loc 1 320 0
 290              	@ 320 "../src/rls_m0.c" 1
 291 0026 8C46     		MOV	r12, r1
 292              	@ 0 "" 2
 321:../src/rls_m0.c **** 	asm("MOVS	r4, #0"); // clear column value
 293              		.loc 1 321 0
 294              	@ 321 "../src/rls_m0.c" 1
 295 0028 0024     		MOVS	r4, #0
 296              	@ 0 "" 2
 322:../src/rls_m0.c **** 
 323:../src/rls_m0.c **** 	// *** PIXEL SYNC (start reading pixels)
 324:../src/rls_m0.c **** 	asm(GREEN);
 297              		.loc 1 324 0
 298              	@ 324 "../src/rls_m0.c" 1
 299 002a 0578     		LDRB   r5, [r0]
 300              	@ 0 "" 2
 325:../src/rls_m0.c **** 	// cycle
 326:../src/rls_m0.c **** 	asm("NOP");
 301              		.loc 1 326 0
 302              	@ 326 "../src/rls_m0.c" 1
 303 002c C046     		NOP
 304              	@ 0 "" 2
 327:../src/rls_m0.c **** 	asm("NOP");
 305              		.loc 1 327 0
 306              	@ 327 "../src/rls_m0.c" 1
 307 002e C046     		NOP
 308              	@ 0 "" 2
 328:../src/rls_m0.c **** 	asm("NOP");
 309              		.loc 1 328 0
 310              	@ 328 "../src/rls_m0.c" 1
 311 0030 C046     		NOP
 312              	@ 0 "" 2
 329:../src/rls_m0.c **** 	asm("NOP");
 313              		.loc 1 329 0
 314              	@ 329 "../src/rls_m0.c" 1
 315 0032 C046     		NOP
 316              	@ 0 "" 2
 330:../src/rls_m0.c **** 	asm("NOP");
 317              		.loc 1 330 0
 318              	@ 330 "../src/rls_m0.c" 1
 319 0034 C046     		NOP
 320              	@ 0 "" 2
 331:../src/rls_m0.c **** 	asm("NOP");
 321              		.loc 1 331 0
 322              	@ 331 "../src/rls_m0.c" 1
 323 0036 C046     		NOP
 324              	@ 0 "" 2
 332:../src/rls_m0.c **** 
 333:../src/rls_m0.c **** asm("zero0:");
 325              		.loc 1 333 0
 326              	@ 333 "../src/rls_m0.c" 1
 327              		zero0:
 328              	@ 0 "" 2
 334:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 329              		.loc 1 334 0
 330              	@ 334 "../src/rls_m0.c" 1
 331 0038 0026     		MOVS	r6, #0
 332              	@ 0 "" 2
 335:../src/rls_m0.c **** 	asm("MOV	r8, r6");	// clear sum (so we don't think we have an outstanding segment)
 333              		.loc 1 335 0
 334              	@ 335 "../src/rls_m0.c" 1
 335 003a B046     		MOV	r8, r6
 336              	@ 0 "" 2
 336:../src/rls_m0.c **** 	EOL_CHECK;
 337              		.loc 1 336 0
 338              	@ 336 "../src/rls_m0.c" 1
 339 003c 4C45     		CMP r4, r9 
 340 003e 61DA     		BGE eol
 341              	@ 0 "" 2
 337:../src/rls_m0.c **** 	// cycle
 338:../src/rls_m0.c **** 	// *** PIXEL SYNC (check for nonzero lut value)
 339:../src/rls_m0.c **** asm("zero1:");
 342              		.loc 1 339 0
 343              	@ 339 "../src/rls_m0.c" 1
 344              		zero1:
 345              	@ 0 "" 2
 340:../src/rls_m0.c **** 	//LEXT r7
 341:../src/rls_m0.c **** //	MACRO // create index, lookup, inc col, extract model
 342:../src/rls_m0.c **** //	$lx		LEXT	$rx
 343:../src/rls_m0.c **** 	asm(RED);
 346              		.loc 1 343 0
 347              	@ 343 "../src/rls_m0.c" 1
 348 0040 0678     		LDRB   r6, [r0]
 349              	@ 0 "" 2
 344:../src/rls_m0.c **** 	// cycle
 345:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 350              		.loc 1 345 0
 351              	@ 345 "../src/rls_m0.c" 1
 352 0042 761B     		SUBS	r6, r5
 353              	@ 0 "" 2
 346:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 354              		.loc 1 346 0
 355              	@ 346 "../src/rls_m0.c" 1
 356 0044 7610     		ASRS	r6, #1
 357              	@ 0 "" 2
 347:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 358              		.loc 1 347 0
 359              	@ 347 "../src/rls_m0.c" 1
 360 0046 3606     		LSLS	r6, #24
 361              	@ 0 "" 2
 348:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 362              		.loc 1 348 0
 363              	@ 348 "../src/rls_m0.c" 1
 364 0048 360C     		LSRS	r6, #16
 365              	@ 0 "" 2
 349:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 366              		.loc 1 349 0
 367              	@ 349 "../src/rls_m0.c" 1
 368 004a 1D5D     		LDRB	r5, [r3, r4]
 369              	@ 0 "" 2
 350:../src/rls_m0.c **** 	// cycle
 351:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 370              		.loc 1 351 0
 371              	@ 351 "../src/rls_m0.c" 1
 372 004c 3543     		ORRS	r5, r6
 373              	@ 0 "" 2
 352:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 374              		.loc 1 352 0
 375              	@ 352 "../src/rls_m0.c" 1
 376 004e 515D     		LDRB	r1, [r2, r5]
 377              	@ 0 "" 2
 353:../src/rls_m0.c **** 	// cycle
 354:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 378              		.loc 1 354 0
 379              	@ 354 "../src/rls_m0.c" 1
 380 0050 0134     		ADDS 	r4, #1
 381              	@ 0 "" 2
 355:../src/rls_m0.c **** 	// *** PIXEL SYNC
 356:../src/rls_m0.c **** 	asm(GREEN);
 382              		.loc 1 356 0
 383              	@ 356 "../src/rls_m0.c" 1
 384 0052 0578     		LDRB   r5, [r0]
 385              	@ 0 "" 2
 357:../src/rls_m0.c **** 	// cycle
 358:../src/rls_m0.c **** 	asm("LSLS	r7, r1, #29"); // knock off msb's
 386              		.loc 1 358 0
 387              	@ 358 "../src/rls_m0.c" 1
 388 0054 4F07     		LSLS	r7, r1, #29
 389              	@ 0 "" 2
 359:../src/rls_m0.c **** 	asm("LSRS	r7, #29"); // extract model, put in rx
 390              		.loc 1 359 0
 391              	@ 359 "../src/rls_m0.c" 1
 392 0056 7F0F     		LSRS	r7, #29
 393              	@ 0 "" 2
 360:../src/rls_m0.c **** 	//MEND
 361:../src/rls_m0.c **** 
 362:../src/rls_m0.c **** 	// cycle
 363:../src/rls_m0.c **** 	// cycle
 364:../src/rls_m0.c **** 	// cycle
 365:../src/rls_m0.c **** 	asm("CMP 	r7, #0");
 394              		.loc 1 365 0
 395              	@ 365 "../src/rls_m0.c" 1
 396 0058 002F     		CMP 	r7, #0
 397              	@ 0 "" 2
 366:../src/rls_m0.c **** 	asm("BEQ 	zero0");
 398              		.loc 1 366 0
 399              	@ 366 "../src/rls_m0.c" 1
 400 005a EDD0     		BEQ 	zero0
 401              	@ 0 "" 2
 367:../src/rls_m0.c **** 	asm("MOV	r10, r4"); // save start column
 402              		.loc 1 367 0
 403              	@ 367 "../src/rls_m0.c" 1
 404 005c A246     		MOV	r10, r4
 405              	@ 0 "" 2
 368:../src/rls_m0.c **** 	asm("ADD	r8, r1"); // add to sum
 406              		.loc 1 368 0
 407              	@ 368 "../src/rls_m0.c" 1
 408 005e 8844     		ADD	r8, r1
 409              	@ 0 "" 2
 369:../src/rls_m0.c **** 	EOL_CHECK;
 410              		.loc 1 369 0
 411              	@ 369 "../src/rls_m0.c" 1
 412 0060 4C45     		CMP r4, r9 
 413 0062 4FDA     		BGE eol
 414              	@ 0 "" 2
 370:../src/rls_m0.c **** 	// cycle
 371:../src/rls_m0.c **** 	asm("NOP");
 415              		.loc 1 371 0
 416              	@ 371 "../src/rls_m0.c" 1
 417 0064 C046     		NOP
 418              	@ 0 "" 2
 372:../src/rls_m0.c **** 	asm("NOP");
 419              		.loc 1 372 0
 420              	@ 372 "../src/rls_m0.c" 1
 421 0066 C046     		NOP
 422              	@ 0 "" 2
 373:../src/rls_m0.c **** 	// *** PIXEL SYNC (check nonzero value for consistency)
 374:../src/rls_m0.c **** //	LEXT r6;
 375:../src/rls_m0.c **** 	asm(RED);
 423              		.loc 1 375 0
 424              	@ 375 "../src/rls_m0.c" 1
 425 0068 0678     		LDRB   r6, [r0]
 426              	@ 0 "" 2
 376:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 427              		.loc 1 376 0
 428              	@ 376 "../src/rls_m0.c" 1
 429 006a 761B     		SUBS	r6, r5
 430              	@ 0 "" 2
 377:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 431              		.loc 1 377 0
 432              	@ 377 "../src/rls_m0.c" 1
 433 006c 7610     		ASRS	r6, #1
 434              	@ 0 "" 2
 378:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 435              		.loc 1 378 0
 436              	@ 378 "../src/rls_m0.c" 1
 437 006e 3606     		LSLS	r6, #24
 438              	@ 0 "" 2
 379:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 439              		.loc 1 379 0
 440              	@ 379 "../src/rls_m0.c" 1
 441 0070 360C     		LSRS	r6, #16
 442              	@ 0 "" 2
 380:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 443              		.loc 1 380 0
 444              	@ 380 "../src/rls_m0.c" 1
 445 0072 1D5D     		LDRB	r5, [r3, r4]
 446              	@ 0 "" 2
 381:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 447              		.loc 1 381 0
 448              	@ 381 "../src/rls_m0.c" 1
 449 0074 3543     		ORRS	r5, r6
 450              	@ 0 "" 2
 382:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 451              		.loc 1 382 0
 452              	@ 382 "../src/rls_m0.c" 1
 453 0076 515D     		LDRB	r1, [r2, r5]
 454              	@ 0 "" 2
 383:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 455              		.loc 1 383 0
 456              	@ 383 "../src/rls_m0.c" 1
 457 0078 0134     		ADDS 	r4, #1
 458              	@ 0 "" 2
 384:../src/rls_m0.c **** 	// *** PIXEL SYNC
 385:../src/rls_m0.c **** 	asm(GREEN);
 459              		.loc 1 385 0
 460              	@ 385 "../src/rls_m0.c" 1
 461 007a 0578     		LDRB   r5, [r0]
 462              	@ 0 "" 2
 386:../src/rls_m0.c **** 	// cycle
 387:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 463              		.loc 1 387 0
 464              	@ 387 "../src/rls_m0.c" 1
 465 007c 4E07     		LSLS	r6, r1, #29
 466              	@ 0 "" 2
 388:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 467              		.loc 1 388 0
 468              	@ 388 "../src/rls_m0.c" 1
 469 007e 760F     		LSRS	r6, #29
 470              	@ 0 "" 2
 389:../src/rls_m0.c **** // end of LEXT r6
 390:../src/rls_m0.c **** 
 391:../src/rls_m0.c **** 	// cycle
 392:../src/rls_m0.c **** 	// cycle
 393:../src/rls_m0.c **** 	// cycle
 394:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 471              		.loc 1 394 0
 472              	@ 394 "../src/rls_m0.c" 1
 473 0080 BE42     		CMP	r6, r7
 474              	@ 0 "" 2
 395:../src/rls_m0.c **** 	asm("BNE	zero0");
 475              		.loc 1 395 0
 476              	@ 395 "../src/rls_m0.c" 1
 477 0082 D9D1     		BNE	zero0
 478              	@ 0 "" 2
 396:../src/rls_m0.c **** 	asm("NOP");
 479              		.loc 1 396 0
 480              	@ 396 "../src/rls_m0.c" 1
 481 0084 C046     		NOP
 482              	@ 0 "" 2
 397:../src/rls_m0.c **** 	asm("NOP");
 483              		.loc 1 397 0
 484              	@ 397 "../src/rls_m0.c" 1
 485 0086 C046     		NOP
 486              	@ 0 "" 2
 398:../src/rls_m0.c **** asm("one:");
 487              		.loc 1 398 0
 488              	@ 398 "../src/rls_m0.c" 1
 489              		one:
 490              	@ 0 "" 2
 399:../src/rls_m0.c **** 	asm("MOV	r11, r1");	// save last lut val
 491              		.loc 1 399 0
 492              	@ 399 "../src/rls_m0.c" 1
 493 0088 8B46     		MOV	r11, r1
 494              	@ 0 "" 2
 400:../src/rls_m0.c **** 	asm("ADD	r8, r1"); // add to sum
 495              		.loc 1 400 0
 496              	@ 400 "../src/rls_m0.c" 1
 497 008a 8844     		ADD	r8, r1
 498              	@ 0 "" 2
 401:../src/rls_m0.c **** 	EOL_CHECK;
 499              		.loc 1 401 0
 500              	@ 401 "../src/rls_m0.c" 1
 501 008c 4C45     		CMP r4, r9 
 502 008e 39DA     		BGE eol
 503              	@ 0 "" 2
 402:../src/rls_m0.c **** 	// cycle
 403:../src/rls_m0.c **** 	// *** PIXEL SYNC (run-length segment)
 404:../src/rls_m0.c **** 
 405:../src/rls_m0.c **** //	LEXT r6
 406:../src/rls_m0.c **** 	asm(RED);
 504              		.loc 1 406 0
 505              	@ 406 "../src/rls_m0.c" 1
 506 0090 0678     		LDRB   r6, [r0]
 507              	@ 0 "" 2
 407:../src/rls_m0.c **** 	// cycle
 408:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 508              		.loc 1 408 0
 509              	@ 408 "../src/rls_m0.c" 1
 510 0092 761B     		SUBS	r6, r5
 511              	@ 0 "" 2
 409:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 512              		.loc 1 409 0
 513              	@ 409 "../src/rls_m0.c" 1
 514 0094 7610     		ASRS	r6, #1
 515              	@ 0 "" 2
 410:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 516              		.loc 1 410 0
 517              	@ 410 "../src/rls_m0.c" 1
 518 0096 3606     		LSLS	r6, #24
 519              	@ 0 "" 2
 411:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 520              		.loc 1 411 0
 521              	@ 411 "../src/rls_m0.c" 1
 522 0098 360C     		LSRS	r6, #16
 523              	@ 0 "" 2
 412:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 524              		.loc 1 412 0
 525              	@ 412 "../src/rls_m0.c" 1
 526 009a 1D5D     		LDRB	r5, [r3, r4]
 527              	@ 0 "" 2
 413:../src/rls_m0.c **** 	// cycle
 414:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 528              		.loc 1 414 0
 529              	@ 414 "../src/rls_m0.c" 1
 530 009c 3543     		ORRS	r5, r6
 531              	@ 0 "" 2
 415:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 532              		.loc 1 415 0
 533              	@ 415 "../src/rls_m0.c" 1
 534 009e 515D     		LDRB	r1, [r2, r5]
 535              	@ 0 "" 2
 416:../src/rls_m0.c **** 	// cycle
 417:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 536              		.loc 1 417 0
 537              	@ 417 "../src/rls_m0.c" 1
 538 00a0 0134     		ADDS 	r4, #1
 539              	@ 0 "" 2
 418:../src/rls_m0.c **** 	// *** PIXEL SYNC
 419:../src/rls_m0.c **** 	asm(GREEN);
 540              		.loc 1 419 0
 541              	@ 419 "../src/rls_m0.c" 1
 542 00a2 0578     		LDRB   r5, [r0]
 543              	@ 0 "" 2
 420:../src/rls_m0.c **** 	// cycle
 421:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 544              		.loc 1 421 0
 545              	@ 421 "../src/rls_m0.c" 1
 546 00a4 4E07     		LSLS	r6, r1, #29
 547              	@ 0 "" 2
 422:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 548              		.loc 1 422 0
 549              	@ 422 "../src/rls_m0.c" 1
 550 00a6 760F     		LSRS	r6, #29
 551              	@ 0 "" 2
 423:../src/rls_m0.c **** // end of LEXT
 424:../src/rls_m0.c **** 
 425:../src/rls_m0.c **** 	// cycle
 426:../src/rls_m0.c **** 	// cycle
 427:../src/rls_m0.c **** 	// cycle
 428:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 552              		.loc 1 428 0
 553              	@ 428 "../src/rls_m0.c" 1
 554 00a8 BE42     		CMP	r6, r7
 555              	@ 0 "" 2
 429:../src/rls_m0.c **** 	asm("BEQ	one");
 556              		.loc 1 429 0
 557              	@ 429 "../src/rls_m0.c" 1
 558 00aa EDD0     		BEQ	one
 559              	@ 0 "" 2
 430:../src/rls_m0.c **** 	asm("ADD	r8, r11"); // need to add something-- use last lut val
 560              		.loc 1 430 0
 561              	@ 430 "../src/rls_m0.c" 1
 562 00ac D844     		ADD	r8, r11
 563              	@ 0 "" 2
 431:../src/rls_m0.c **** 	EOL_CHECK;
 564              		.loc 1 431 0
 565              	@ 431 "../src/rls_m0.c" 1
 566 00ae 4C45     		CMP r4, r9 
 567 00b0 28DA     		BGE eol
 568              	@ 0 "" 2
 432:../src/rls_m0.c **** 	// cycle
 433:../src/rls_m0.c **** 	asm("NOP");
 569              		.loc 1 433 0
 570              	@ 433 "../src/rls_m0.c" 1
 571 00b2 C046     		NOP
 572              	@ 0 "" 2
 434:../src/rls_m0.c **** 	asm("NOP");
 573              		.loc 1 434 0
 574              	@ 434 "../src/rls_m0.c" 1
 575 00b4 C046     		NOP
 576              	@ 0 "" 2
 435:../src/rls_m0.c **** 	asm("NOP");
 577              		.loc 1 435 0
 578              	@ 435 "../src/rls_m0.c" 1
 579 00b6 C046     		NOP
 580              	@ 0 "" 2
 436:../src/rls_m0.c **** 	// *** PIXEL SYNC (1st pixel not equal)
 437:../src/rls_m0.c **** 
 438:../src/rls_m0.c **** //	LEXT r6
 439:../src/rls_m0.c **** 	asm(RED);
 581              		.loc 1 439 0
 582              	@ 439 "../src/rls_m0.c" 1
 583 00b8 0678     		LDRB   r6, [r0]
 584              	@ 0 "" 2
 440:../src/rls_m0.c **** 	// cycle
 441:../src/rls_m0.c **** 	asm("SUBS	r6, r5");   // red-green
 585              		.loc 1 441 0
 586              	@ 441 "../src/rls_m0.c" 1
 587 00ba 761B     		SUBS	r6, r5
 588              	@ 0 "" 2
 442:../src/rls_m0.c **** 	asm("ASRS	r6, #1");	 // reduce 9 to 8 bits arithmetically
 589              		.loc 1 442 0
 590              	@ 442 "../src/rls_m0.c" 1
 591 00bc 7610     		ASRS	r6, #1
 592              	@ 0 "" 2
 443:../src/rls_m0.c **** 	asm("LSLS	r6, #24");  // shift red-green and get rid of higher-order bits
 593              		.loc 1 443 0
 594              	@ 443 "../src/rls_m0.c" 1
 595 00be 3606     		LSLS	r6, #24
 596              	@ 0 "" 2
 444:../src/rls_m0.c **** 	asm("LSRS	r6, #16");  // shift red-green back, make it the higher 8 bits of the index
 597              		.loc 1 444 0
 598              	@ 444 "../src/rls_m0.c" 1
 599 00c0 360C     		LSRS	r6, #16
 600              	@ 0 "" 2
 445:../src/rls_m0.c **** 	asm("LDRB	r5, [r3, r4]"); // load blue-green val
 601              		.loc 1 445 0
 602              	@ 445 "../src/rls_m0.c" 1
 603 00c2 1D5D     		LDRB	r5, [r3, r4]
 604              	@ 0 "" 2
 446:../src/rls_m0.c **** 	// cycle
 447:../src/rls_m0.c **** 	asm("ORRS	r5, r6");   // form 16-bit index
 605              		.loc 1 447 0
 606              	@ 447 "../src/rls_m0.c" 1
 607 00c4 3543     		ORRS	r5, r6
 608              	@ 0 "" 2
 448:../src/rls_m0.c **** 	asm("LDRB	r1, [r2, r5]"); // load lut val
 609              		.loc 1 448 0
 610              	@ 448 "../src/rls_m0.c" 1
 611 00c6 515D     		LDRB	r1, [r2, r5]
 612              	@ 0 "" 2
 449:../src/rls_m0.c **** 	// cycle
 450:../src/rls_m0.c **** 	asm("ADDS 	r4, #1"); // inc col
 613              		.loc 1 450 0
 614              	@ 450 "../src/rls_m0.c" 1
 615 00c8 0134     		ADDS 	r4, #1
 616              	@ 0 "" 2
 451:../src/rls_m0.c **** 	// *** PIXEL SYNC
 452:../src/rls_m0.c **** 	asm(GREEN);
 617              		.loc 1 452 0
 618              	@ 452 "../src/rls_m0.c" 1
 619 00ca 0578     		LDRB   r5, [r0]
 620              	@ 0 "" 2
 453:../src/rls_m0.c **** 	// cycle
 454:../src/rls_m0.c **** 	asm("LSLS	r6, r1, #29"); // knock off msb's
 621              		.loc 1 454 0
 622              	@ 454 "../src/rls_m0.c" 1
 623 00cc 4E07     		LSLS	r6, r1, #29
 624              	@ 0 "" 2
 455:../src/rls_m0.c **** 	asm("LSRS	r6, #29"); // extract model, put in rx
 625              		.loc 1 455 0
 626              	@ 455 "../src/rls_m0.c" 1
 627 00ce 760F     		LSRS	r6, #29
 628              	@ 0 "" 2
 456:../src/rls_m0.c **** // end of LEXT
 457:../src/rls_m0.c **** 
 458:../src/rls_m0.c **** 	// cycle
 459:../src/rls_m0.c **** 	// cycle
 460:../src/rls_m0.c **** 	// cycle
 461:../src/rls_m0.c **** 	asm("CMP	r6, r7");
 629              		.loc 1 461 0
 630              	@ 461 "../src/rls_m0.c" 1
 631 00d0 BE42     		CMP	r6, r7
 632              	@ 0 "" 2
 462:../src/rls_m0.c **** 	asm("BEQ	one");
 633              		.loc 1 462 0
 634              	@ 462 "../src/rls_m0.c" 1
 635 00d2 D9D0     		BEQ	one
 636              	@ 0 "" 2
 463:../src/rls_m0.c **** 	// 2nd pixel not equal--- run length is done
 464:../src/rls_m0.c **** 	QVAL;
 637              		.loc 1 464 0
 638              	@ 464 "../src/rls_m0.c" 1
 639 00d4 5546     		MOV 	r5, r10
 640              	@ 0 "" 2
 641              	@ 464 "../src/rls_m0.c" 1
 642 00d6 EE00     		LSLS 	r6, r5, #3
 643              	@ 0 "" 2
 644              	@ 464 "../src/rls_m0.c" 1
 645 00d8 3E43     		ORRS	r6, r7
 646              	@ 0 "" 2
 647              	@ 464 "../src/rls_m0.c" 1
 648 00da 611B     		SUBS  	r1, r4, r5
 649              	@ 0 "" 2
 650              	@ 464 "../src/rls_m0.c" 1
 651 00dc 0D03     		LSLS 	r5, r1, #12
 652              	@ 0 "" 2
 653              	@ 464 "../src/rls_m0.c" 1
 654 00de 2E43     		ORRS 	r6, r5
 655              	@ 0 "" 2
 656              	@ 464 "../src/rls_m0.c" 1
 657 00e0 099D     		LDR	r5, [sp, #0x24]
 658              	@ 0 "" 2
 659              	@ 464 "../src/rls_m0.c" 1
 660 00e2 495D     		LDRB 	r1, [r1, r5]
 661              	@ 0 "" 2
 662              	@ 464 "../src/rls_m0.c" 1
 663 00e4 4546     		MOV 	r5, r8
 664              	@ 0 "" 2
 665              	@ 464 "../src/rls_m0.c" 1
 666 00e6 CD40     		LSRS 	r5, r1
 667              	@ 0 "" 2
 668              	@ 464 "../src/rls_m0.c" 1
 669 00e8 6D05     		LSLS	r5, #21
 670              	@ 0 "" 2
 671              	@ 464 "../src/rls_m0.c" 1
 672 00ea 2E43     		ORRS 	r6, r5
 673              	@ 0 "" 2
 674              	@ 464 "../src/rls_m0.c" 1
 675 00ec 0907     		LSLS 	r1, #28
 676              	@ 0 "" 2
 677              	@ 464 "../src/rls_m0.c" 1
 678 00ee 0E43     		ORRS	r6, r1
 679              	@ 0 "" 2
 680              	@ 464 "../src/rls_m0.c" 1
 681 00f0 6146     		MOV 	r1, r12
 682              	@ 0 "" 2
 683              	@ 464 "../src/rls_m0.c" 1
 684 00f2 0427     		MOVS 	r7, #4
 685              	@ 0 "" 2
 686              	@ 464 "../src/rls_m0.c" 1
 687 00f4 0578     		LDRB   r5, [r0]
 688              	@ 0 "" 2
 689              	@ 464 "../src/rls_m0.c" 1
 690 00f6 0E60     		STR 	r6, [r1]
 691              	@ 0 "" 2
 692              	@ 464 "../src/rls_m0.c" 1
 693 00f8 BC44     		ADD  	r12, r7
 694              	@ 0 "" 2
 465:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 695              		.loc 1 465 0
 696              	@ 465 "../src/rls_m0.c" 1
 697 00fa 0026     		MOVS	r6, #0
 698              	@ 0 "" 2
 466:../src/rls_m0.c **** 	asm("MOV	r8, r6"); // clear sum
 699              		.loc 1 466 0
 700              	@ 466 "../src/rls_m0.c" 1
 701 00fc B046     		MOV	r8, r6
 702              	@ 0 "" 2
 467:../src/rls_m0.c **** 	asm("ADDS	r4, #1"); // add column
 703              		.loc 1 467 0
 704              	@ 467 "../src/rls_m0.c" 1
 705 00fe 0134     		ADDS	r4, #1
 706              	@ 0 "" 2
 468:../src/rls_m0.c **** 	asm("NOP");
 707              		.loc 1 468 0
 708              	@ 468 "../src/rls_m0.c" 1
 709 0100 C046     		NOP
 710              	@ 0 "" 2
 469:../src/rls_m0.c **** 	asm("B 		zero1");
 711              		.loc 1 469 0
 712              	@ 469 "../src/rls_m0.c" 1
 713 0102 9DE7     		B 		zero1
 714              	@ 0 "" 2
 470:../src/rls_m0.c **** 
 471:../src/rls_m0.c **** asm("eol:");
 715              		.loc 1 471 0
 716              	@ 471 "../src/rls_m0.c" 1
 717              		eol:
 718              	@ 0 "" 2
 472:../src/rls_m0.c **** 	// check r8 for unfinished q val
 473:../src/rls_m0.c **** 	asm("MOVS	r6, #0");
 719              		.loc 1 473 0
 720              	@ 473 "../src/rls_m0.c" 1
 721 0104 0026     		MOVS	r6, #0
 722              	@ 0 "" 2
 474:../src/rls_m0.c **** 	asm("CMP	r8, r6");
 723              		.loc 1 474 0
 724              	@ 474 "../src/rls_m0.c" 1
 725 0106 B045     		CMP	r8, r6
 726              	@ 0 "" 2
 475:../src/rls_m0.c **** 	asm("BEQ	eol0");
 727              		.loc 1 475 0
 728              	@ 475 "../src/rls_m0.c" 1
 729 0108 12D0     		BEQ	eol0
 730              	@ 0 "" 2
 476:../src/rls_m0.c **** 	QVAL;
 731              		.loc 1 476 0
 732              	@ 476 "../src/rls_m0.c" 1
 733 010a 5546     		MOV 	r5, r10
 734              	@ 0 "" 2
 735              	@ 476 "../src/rls_m0.c" 1
 736 010c EE00     		LSLS 	r6, r5, #3
 737              	@ 0 "" 2
 738              	@ 476 "../src/rls_m0.c" 1
 739 010e 3E43     		ORRS	r6, r7
 740              	@ 0 "" 2
 741              	@ 476 "../src/rls_m0.c" 1
 742 0110 611B     		SUBS  	r1, r4, r5
 743              	@ 0 "" 2
 744              	@ 476 "../src/rls_m0.c" 1
 745 0112 0D03     		LSLS 	r5, r1, #12
 746              	@ 0 "" 2
 747              	@ 476 "../src/rls_m0.c" 1
 748 0114 2E43     		ORRS 	r6, r5
 749              	@ 0 "" 2
 750              	@ 476 "../src/rls_m0.c" 1
 751 0116 099D     		LDR	r5, [sp, #0x24]
 752              	@ 0 "" 2
 753              	@ 476 "../src/rls_m0.c" 1
 754 0118 495D     		LDRB 	r1, [r1, r5]
 755              	@ 0 "" 2
 756              	@ 476 "../src/rls_m0.c" 1
 757 011a 4546     		MOV 	r5, r8
 758              	@ 0 "" 2
 759              	@ 476 "../src/rls_m0.c" 1
 760 011c CD40     		LSRS 	r5, r1
 761              	@ 0 "" 2
 762              	@ 476 "../src/rls_m0.c" 1
 763 011e 6D05     		LSLS	r5, #21
 764              	@ 0 "" 2
 765              	@ 476 "../src/rls_m0.c" 1
 766 0120 2E43     		ORRS 	r6, r5
 767              	@ 0 "" 2
 768              	@ 476 "../src/rls_m0.c" 1
 769 0122 0907     		LSLS 	r1, #28
 770              	@ 0 "" 2
 771              	@ 476 "../src/rls_m0.c" 1
 772 0124 0E43     		ORRS	r6, r1
 773              	@ 0 "" 2
 774              	@ 476 "../src/rls_m0.c" 1
 775 0126 6146     		MOV 	r1, r12
 776              	@ 0 "" 2
 777              	@ 476 "../src/rls_m0.c" 1
 778 0128 0427     		MOVS 	r7, #4
 779              	@ 0 "" 2
 780              	@ 476 "../src/rls_m0.c" 1
 781 012a 0578     		LDRB   r5, [r0]
 782              	@ 0 "" 2
 783              	@ 476 "../src/rls_m0.c" 1
 784 012c 0E60     		STR 	r6, [r1]
 785              	@ 0 "" 2
 786              	@ 476 "../src/rls_m0.c" 1
 787 012e BC44     		ADD  	r12, r7
 788              	@ 0 "" 2
 477:../src/rls_m0.c **** 
 478:../src/rls_m0.c **** 	// wait for hsync to go low
 479:../src/rls_m0.c **** asm("eol0:");
 789              		.loc 1 479 0
 790              	@ 479 "../src/rls_m0.c" 1
 791              		eol0:
 792              	@ 0 "" 2
 480:../src/rls_m0.c **** 	asm("MOVS	r5, #0x1");
 793              		.loc 1 480 0
 794              	@ 480 "../src/rls_m0.c" 1
 795 0130 0125     		MOVS	r5, #0x1
 796              	@ 0 "" 2
 481:../src/rls_m0.c **** 	asm("LSLS	r5, #11");
 797              		.loc 1 481 0
 798              	@ 481 "../src/rls_m0.c" 1
 799 0132 ED02     		LSLS	r5, #11
 800              	@ 0 "" 2
 482:../src/rls_m0.c **** 
 483:../src/rls_m0.c **** asm("dest20A:");
 801              		.loc 1 483 0
 802              	@ 483 "../src/rls_m0.c" 1
 803              		dest20A:
 804              	@ 0 "" 2
 484:../src/rls_m0.c **** 	asm("LDR 	r6, [r0]"); 	// 2
 805              		.loc 1 484 0
 806              	@ 484 "../src/rls_m0.c" 1
 807 0134 0668     		LDR 	r6, [r0]
 808              	@ 0 "" 2
 485:../src/rls_m0.c **** 	asm("TST	r6, r5");		// 1
 809              		.loc 1 485 0
 810              	@ 485 "../src/rls_m0.c" 1
 811 0136 2E42     		TST	r6, r5
 812              	@ 0 "" 2
 486:../src/rls_m0.c **** 	asm("BNE	dest20A");	// 3
 813              		.loc 1 486 0
 814              	@ 486 "../src/rls_m0.c" 1
 815 0138 FCD1     		BNE	dest20A
 816              	@ 0 "" 2
 487:../src/rls_m0.c **** 
 488:../src/rls_m0.c **** // we have approx 1800 cycles to do something here
 489:../src/rls_m0.c **** // which is enough time to copy 64 qvals (256 bytes), maximum qvals/line = 320/5
 490:../src/rls_m0.c **** // (this has been verified/tested)
 491:../src/rls_m0.c **** // The advantage of doing this is that we don't need to buffer much data
 492:../src/rls_m0.c **** // and it reduces the latency-- we can start processing qvals immediately
 493:../src/rls_m0.c **** // We need to copy these because the memory the qvals comes from must not be
 494:../src/rls_m0.c **** // accessed by the M4, or wait states will be thrown in and we'll lose pixel sync for that line
 495:../src/rls_m0.c **** 	asm("MOV	r0, r12");  // qval pointer
 817              		.loc 1 495 0
 818              	@ 495 "../src/rls_m0.c" 1
 819 013a 6046     		MOV	r0, r12
 820              	@ 0 "" 2
 496:../src/rls_m0.c **** 	asm("LDR	r1, [sp]"); // bring in original q memory location
 821              		.loc 1 496 0
 822              	@ 496 "../src/rls_m0.c" 1
 823 013c 0099     		LDR	r1, [sp]
 824              	@ 0 "" 2
 497:../src/rls_m0.c **** 	asm("SUBS	r0, r1"); // get number of qvals*4
 825              		.loc 1 497 0
 826              	@ 497 "../src/rls_m0.c" 1
 827 013e 401A     		SUBS	r0, r1
 828              	@ 0 "" 2
 498:../src/rls_m0.c **** 
 499:../src/rls_m0.c **** 	asm("LDR	r2, [sp, #0x28]"); // bring in qq memory pointer
 829              		.loc 1 499 0
 830              	@ 499 "../src/rls_m0.c" 1
 831 0140 0A9A     		LDR	r2, [sp, #0x28]
 832              	@ 0 "" 2
 500:../src/rls_m0.c **** 	asm("LDR	r3, [sp, #0x2c]"); // bring in qq index
 833              		.loc 1 500 0
 834              	@ 500 "../src/rls_m0.c" 1
 835 0142 0B9B     		LDR	r3, [sp, #0x2c]
 836              	@ 0 "" 2
 501:../src/rls_m0.c **** 	asm("LSLS 	r3, #2"); // qq index in bytes (4 bytes/qval)
 837              		.loc 1 501 0
 838              	@ 501 "../src/rls_m0.c" 1
 839 0144 9B00     		LSLS 	r3, #2
 840              	@ 0 "" 2
 502:../src/rls_m0.c **** 	asm("LDR	r4, [sp, #0x30]");; // bring in qq size
 841              		.loc 1 502 0
 842              	@ 502 "../src/rls_m0.c" 1
 843 0146 0C9C     		LDR	r4, [sp, #0x30]
 844              	@ 0 "" 2
 503:../src/rls_m0.c **** 	asm("LSLS 	r4, #2"); // qq size in bytes (4 bytes/qval)
 845              		.loc 1 503 0
 846              	@ 503 "../src/rls_m0.c" 1
 847 0148 A400     		LSLS 	r4, #2
 848              	@ 0 "" 2
 504:../src/rls_m0.c **** 
 505:../src/rls_m0.c **** 	asm("MOVS	r5, #0");
 849              		.loc 1 505 0
 850              	@ 505 "../src/rls_m0.c" 1
 851 014a 0025     		MOVS	r5, #0
 852              	@ 0 "" 2
 506:../src/rls_m0.c **** 
 507:../src/rls_m0.c **** asm("lcpy:");
 853              		.loc 1 507 0
 854              	@ 507 "../src/rls_m0.c" 1
 855              		lcpy:
 856              	@ 0 "" 2
 508:../src/rls_m0.c **** 	asm("CMP	r0, r5");	  // 1 end condition
 857              		.loc 1 508 0
 858              	@ 508 "../src/rls_m0.c" 1
 859 014c A842     		CMP	r0, r5
 860              	@ 0 "" 2
 509:../src/rls_m0.c **** 	asm("BEQ	ecpy");	  // 1 exit
 861              		.loc 1 509 0
 862              	@ 509 "../src/rls_m0.c" 1
 863 014e 08D0     		BEQ	ecpy
 864              	@ 0 "" 2
 510:../src/rls_m0.c **** 
 511:../src/rls_m0.c **** 	asm("LDR	r6, [r1, r5]");  // 2 copy (read)
 865              		.loc 1 511 0
 866              	@ 511 "../src/rls_m0.c" 1
 867 0150 4E59     		LDR	r6, [r1, r5]
 868              	@ 0 "" 2
 512:../src/rls_m0.c **** 	asm("STR	r6, [r2, r3]");  // 2 copy (write)
 869              		.loc 1 512 0
 870              	@ 512 "../src/rls_m0.c" 1
 871 0152 D650     		STR	r6, [r2, r3]
 872              	@ 0 "" 2
 513:../src/rls_m0.c **** 
 514:../src/rls_m0.c **** 	asm("ADDS	r3, #4");	  // 1 inc qq index
 873              		.loc 1 514 0
 874              	@ 514 "../src/rls_m0.c" 1
 875 0154 0433     		ADDS	r3, #4
 876              	@ 0 "" 2
 515:../src/rls_m0.c **** 	asm("ADDS	r5, #4");	  // 1 inc counter
 877              		.loc 1 515 0
 878              	@ 515 "../src/rls_m0.c" 1
 879 0156 0435     		ADDS	r5, #4
 880              	@ 0 "" 2
 516:../src/rls_m0.c **** 
 517:../src/rls_m0.c **** 	asm("CMP	r4, r3");    // 1 check for qq index wrap
 881              		.loc 1 517 0
 882              	@ 517 "../src/rls_m0.c" 1
 883 0158 9C42     		CMP	r4, r3
 884              	@ 0 "" 2
 518:../src/rls_m0.c **** 	asm("BEQ	wrap");	  // 1
 885              		.loc 1 518 0
 886              	@ 518 "../src/rls_m0.c" 1
 887 015a 00D0     		BEQ	wrap
 888              	@ 0 "" 2
 519:../src/rls_m0.c **** 	asm("B		lcpy");	  // 3
 889              		.loc 1 519 0
 890              	@ 519 "../src/rls_m0.c" 1
 891 015c F6E7     		B		lcpy
 892              	@ 0 "" 2
 520:../src/rls_m0.c **** 
 521:../src/rls_m0.c **** asm("wrap:");
 893              		.loc 1 521 0
 894              	@ 521 "../src/rls_m0.c" 1
 895              		wrap:
 896              	@ 0 "" 2
 522:../src/rls_m0.c **** 	asm("MOVS	r3, #0");    // reset qq index
 897              		.loc 1 522 0
 898              	@ 522 "../src/rls_m0.c" 1
 899 015e 0023     		MOVS	r3, #0
 900              	@ 0 "" 2
 523:../src/rls_m0.c **** 	asm("B 		lcpy");
 901              		.loc 1 523 0
 902              	@ 523 "../src/rls_m0.c" 1
 903 0160 F4E7     		B 		lcpy
 904              	@ 0 "" 2
 524:../src/rls_m0.c **** 
 525:../src/rls_m0.c **** asm("ecpy:");
 905              		.loc 1 525 0
 906              	@ 525 "../src/rls_m0.c" 1
 907              		ecpy:
 908              	@ 0 "" 2
 526:../src/rls_m0.c **** 	asm("LSRS   r0, #2"); // return number of qvals
 909              		.loc 1 526 0
 910              	@ 526 "../src/rls_m0.c" 1
 911 0162 8008     		LSRS   r0, #2
 912              	@ 0 "" 2
 527:../src/rls_m0.c **** 	asm("POP	{r1-r7}");
 913              		.loc 1 527 0
 914              	@ 527 "../src/rls_m0.c" 1
 915 0164 FEBC     		POP	{r1-r7}
 916              	@ 0 "" 2
 528:../src/rls_m0.c **** 
 529:../src/rls_m0.c **** 	asm(".syntax divided");
 917              		.loc 1 529 0
 918              	@ 529 "../src/rls_m0.c" 1
 919              		.syntax divided
 920              	@ 0 "" 2
 530:../src/rls_m0.c **** 
 531:../src/rls_m0.c **** }
 921              		.loc 1 531 0
 922              		.code	16
 923 0166 181C     		mov	r0, r3
 924 0168 BD46     		mov	sp, r7
 925 016a 04B0     		add	sp, sp, #16
 926              		@ sp needed
 927 016c 80BD     		pop	{r7, pc}
 928              		.cfi_endproc
 929              	.LFE33:
 931 016e C046     		.section	.text.intLog,"ax",%progbits
 932              		.align	2
 933              		.global	intLog
 934              		.code	16
 935              		.thumb_func
 937              	intLog:
 938              	.LFB34:
 532:../src/rls_m0.c **** 
 533:../src/rls_m0.c **** 
 534:../src/rls_m0.c **** uint8_t intLog(int i)
 535:../src/rls_m0.c **** {
 939              		.loc 1 535 0
 940              		.cfi_startproc
 941 0000 80B5     		push	{r7, lr}
 942              		.cfi_def_cfa_offset 8
 943              		.cfi_offset 7, -8
 944              		.cfi_offset 14, -4
 945 0002 82B0     		sub	sp, sp, #8
 946              		.cfi_def_cfa_offset 16
 947 0004 00AF     		add	r7, sp, #0
 948              		.cfi_def_cfa_register 7
 949 0006 7860     		str	r0, [r7, #4]
 536:../src/rls_m0.c **** 	return 0;
 950              		.loc 1 536 0
 951 0008 0023     		mov	r3, #0
 537:../src/rls_m0.c **** }
 952              		.loc 1 537 0
 953 000a 181C     		mov	r0, r3
 954 000c BD46     		mov	sp, r7
 955 000e 02B0     		add	sp, sp, #8
 956              		@ sp needed
 957 0010 80BD     		pop	{r7, pc}
 958              		.cfi_endproc
 959              	.LFE34:
 961 0012 C046     		.section	.text.createLogLut,"ax",%progbits
 962              		.align	2
 963              		.global	createLogLut
 964              		.code	16
 965              		.thumb_func
 967              	createLogLut:
 968              	.LFB35:
 538:../src/rls_m0.c **** 
 539:../src/rls_m0.c **** 
 540:../src/rls_m0.c **** void createLogLut(void)
 541:../src/rls_m0.c **** {
 969              		.loc 1 541 0
 970              		.cfi_startproc
 971 0000 90B5     		push	{r4, r7, lr}
 972              		.cfi_def_cfa_offset 12
 973              		.cfi_offset 4, -12
 974              		.cfi_offset 7, -8
 975              		.cfi_offset 14, -4
 976 0002 83B0     		sub	sp, sp, #12
 977              		.cfi_def_cfa_offset 24
 978 0004 00AF     		add	r7, sp, #0
 979              		.cfi_def_cfa_register 7
 542:../src/rls_m0.c **** 	int i;
 543:../src/rls_m0.c **** 	
 544:../src/rls_m0.c **** 	for (i=0; i<CAM_RES2_WIDTH; i++)
 980              		.loc 1 544 0
 981 0006 0023     		mov	r3, #0
 982 0008 7B60     		str	r3, [r7, #4]
 983 000a 0EE0     		b	.L6
 984              	.L7:
 545:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 985              		.loc 1 545 0 discriminator 3
 986 000c 0B4B     		ldr	r3, .L8
 987 000e 1A68     		ldr	r2, [r3]
 988 0010 7B68     		ldr	r3, [r7, #4]
 989 0012 D418     		add	r4, r2, r3
 990 0014 7B68     		ldr	r3, [r7, #4]
 991 0016 181C     		mov	r0, r3
 992 0018 FFF7FEFF 		bl	intLog
 993 001c 031C     		mov	r3, r0
 994 001e 0333     		add	r3, r3, #3
 995 0020 DBB2     		uxtb	r3, r3
 996 0022 2370     		strb	r3, [r4]
 544:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 997              		.loc 1 544 0 discriminator 3
 998 0024 7B68     		ldr	r3, [r7, #4]
 999 0026 0133     		add	r3, r3, #1
 1000 0028 7B60     		str	r3, [r7, #4]
 1001              	.L6:
 544:../src/rls_m0.c **** 		g_logLut[i] = intLog(i) + 3;
 1002              		.loc 1 544 0 is_stmt 0 discriminator 1
 1003 002a 7A68     		ldr	r2, [r7, #4]
 1004 002c 4023     		mov	r3, #64
 1005 002e FF33     		add	r3, r3, #255
 1006 0030 9A42     		cmp	r2, r3
 1007 0032 EBDD     		ble	.L7
 546:../src/rls_m0.c **** }
 1008              		.loc 1 546 0 is_stmt 1
 1009 0034 BD46     		mov	sp, r7
 1010 0036 03B0     		add	sp, sp, #12
 1011              		@ sp needed
 1012 0038 90BD     		pop	{r4, r7, pc}
 1013              	.L9:
 1014 003a C046     		.align	2
 1015              	.L8:
 1016 003c 00000000 		.word	g_logLut
 1017              		.cfi_endproc
 1018              	.LFE35:
 1020              		.section	.text.getRLSFrame,"ax",%progbits
 1021              		.align	2
 1022              		.global	getRLSFrame
 1023              		.code	16
 1024              		.thumb_func
 1026              	getRLSFrame:
 1027              	.LFB36:
 547:../src/rls_m0.c **** 
 548:../src/rls_m0.c **** #ifdef RLTEST
 549:../src/rls_m0.c **** uint8_t bgData[] = 
 550:../src/rls_m0.c **** {
 551:../src/rls_m0.c **** 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12 
 552:../src/rls_m0.c **** };
 553:../src/rls_m0.c **** 
 554:../src/rls_m0.c **** uint32_t rgData[] = 
 555:../src/rls_m0.c **** {
 556:../src/rls_m0.c **** 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0, 0x08a008a0
 557:../src/rls_m0.c **** };
 558:../src/rls_m0.c **** #endif
 559:../src/rls_m0.c **** 
 560:../src/rls_m0.c **** 
 561:../src/rls_m0.c **** int32_t getRLSFrame(uint32_t *m0Mem, uint32_t *lut)
 562:../src/rls_m0.c **** {
 1028              		.loc 1 562 0
 1029              		.cfi_startproc
 1030 0000 F0B5     		push	{r4, r5, r6, r7, lr}
 1031              		.cfi_def_cfa_offset 20
 1032              		.cfi_offset 4, -20
 1033              		.cfi_offset 5, -16
 1034              		.cfi_offset 6, -12
 1035              		.cfi_offset 7, -8
 1036              		.cfi_offset 14, -4
 1037 0002 93B0     		sub	sp, sp, #76
 1038              		.cfi_def_cfa_offset 96
 1039 0004 06AF     		add	r7, sp, #24
 1040              		.cfi_def_cfa 7, 72
 1041 0006 F860     		str	r0, [r7, #12]
 1042 0008 B960     		str	r1, [r7, #8]
 563:../src/rls_m0.c **** 	uint8_t *lut2 = (uint8_t *)*lut;
 1043              		.loc 1 563 0
 1044 000a BB68     		ldr	r3, [r7, #8]
 1045 000c 1B68     		ldr	r3, [r3]
 1046 000e 7B62     		str	r3, [r7, #36]
 564:../src/rls_m0.c **** 	Qval *qvalStore = (Qval *)*m0Mem;
 1047              		.loc 1 564 0
 1048 0010 FB68     		ldr	r3, [r7, #12]
 1049 0012 1B68     		ldr	r3, [r3]
 1050 0014 3B62     		str	r3, [r7, #32]
 565:../src/rls_m0.c **** 	uint32_t line;
 566:../src/rls_m0.c **** 	uint32_t numQvals;
 567:../src/rls_m0.c **** 	uint32_t totalQvals;
 568:../src/rls_m0.c **** 	uint8_t *lineStore;
 569:../src/rls_m0.c **** 	uint8_t *logLut;
 570:../src/rls_m0.c **** 
 571:../src/rls_m0.c **** 	lineStore = (uint8_t *)(qvalStore + MAX_QVALS_PER_LINE);
 1051              		.loc 1 571 0
 1052 0016 3B6A     		ldr	r3, [r7, #32]
 1053 0018 0133     		add	r3, r3, #1
 1054 001a FF33     		add	r3, r3, #255
 1055 001c FB61     		str	r3, [r7, #28]
 572:../src/rls_m0.c **** 	logLut = lineStore + CAM_RES2_WIDTH + 4;
 1056              		.loc 1 572 0
 1057 001e FB69     		ldr	r3, [r7, #28]
 1058 0020 4533     		add	r3, r3, #69
 1059 0022 FF33     		add	r3, r3, #255
 1060 0024 BB61     		str	r3, [r7, #24]
 573:../src/rls_m0.c **** 	// m0mem needs to be at least 64*4 + CAM_RES2_WIDTH*2 + 4 =	900 ~ 1024
 574:../src/rls_m0.c **** 
 575:../src/rls_m0.c **** 	if (g_logLut!=logLut)
 1061              		.loc 1 575 0
 1062 0026 454B     		ldr	r3, .L18
 1063 0028 1A68     		ldr	r2, [r3]
 1064 002a BB69     		ldr	r3, [r7, #24]
 1065 002c 9A42     		cmp	r2, r3
 1066 002e 04D0     		beq	.L11
 576:../src/rls_m0.c **** 	{
 577:../src/rls_m0.c **** 		g_logLut = logLut; 
 1067              		.loc 1 577 0
 1068 0030 424B     		ldr	r3, .L18
 1069 0032 BA69     		ldr	r2, [r7, #24]
 1070 0034 1A60     		str	r2, [r3]
 578:../src/rls_m0.c **** 	 	createLogLut();
 1071              		.loc 1 578 0
 1072 0036 FFF7FEFF 		bl	createLogLut
 1073              	.L11:
 579:../src/rls_m0.c **** 	}
 580:../src/rls_m0.c **** 
 581:../src/rls_m0.c **** 	// don't even attempt to grab lines if we're lacking space...
 582:../src/rls_m0.c **** 	if (qq_free()<MAX_QVALS_PER_LINE)
 1074              		.loc 1 582 0
 1075 003a FFF7FEFF 		bl	qq_free
 1076 003e 031E     		sub	r3, r0, #0
 1077 0040 3F2B     		cmp	r3, #63
 1078 0042 02D8     		bhi	.L12
 583:../src/rls_m0.c **** 		return -1; 
 1079              		.loc 1 583 0
 1080 0044 0123     		mov	r3, #1
 1081 0046 5B42     		neg	r3, r3
 1082 0048 74E0     		b	.L13
 1083              	.L12:
 584:../src/rls_m0.c **** 
 585:../src/rls_m0.c **** 	// indicate start of frame
 586:../src/rls_m0.c **** 	qq_enqueue(0xffffffff); 
 1084              		.loc 1 586 0
 1085 004a 0123     		mov	r3, #1
 1086 004c 5B42     		neg	r3, r3
 1087 004e 181C     		mov	r0, r3
 1088 0050 FFF7FEFF 		bl	qq_enqueue
 587:../src/rls_m0.c **** 	skipLines(0);
 1089              		.loc 1 587 0
 1090 0054 0020     		mov	r0, #0
 1091 0056 FFF7FEFF 		bl	skipLines
 588:../src/rls_m0.c **** 	for (line=0, totalQvals=1; line<CAM_RES2_HEIGHT; line++)  // start totalQvals at 1 because of star
 1092              		.loc 1 588 0
 1093 005a 0023     		mov	r3, #0
 1094 005c FB62     		str	r3, [r7, #44]
 1095 005e 0123     		mov	r3, #1
 1096 0060 BB62     		str	r3, [r7, #40]
 1097 0062 63E0     		b	.L14
 1098              	.L17:
 589:../src/rls_m0.c **** 	{
 590:../src/rls_m0.c **** 		// not enough space--- return error
 591:../src/rls_m0.c **** 		if (qq_free()<MAX_QVALS_PER_LINE)
 1099              		.loc 1 591 0
 1100 0064 FFF7FEFF 		bl	qq_free
 1101 0068 031E     		sub	r3, r0, #0
 1102 006a 3F2B     		cmp	r3, #63
 1103 006c 02D8     		bhi	.L15
 592:../src/rls_m0.c **** 			return -1; 
 1104              		.loc 1 592 0
 1105 006e 0123     		mov	r3, #1
 1106 0070 5B42     		neg	r3, r3
 1107 0072 5FE0     		b	.L13
 1108              	.L15:
 593:../src/rls_m0.c **** 		// mark beginning of this row (column 0 = 0)
 594:../src/rls_m0.c **** 		// column 1 is the first real column of pixels
 595:../src/rls_m0.c **** 		qq_enqueue(0); 
 1109              		.loc 1 595 0
 1110 0074 0020     		mov	r0, #0
 1111 0076 FFF7FEFF 		bl	qq_enqueue
 596:../src/rls_m0.c **** 		lineProcessedRL0A((uint32_t *)&CAM_PORT, lineStore, CAM_RES2_WIDTH); 
 1112              		.loc 1 596 0
 1113 007a 3149     		ldr	r1, .L18+4
 1114 007c FA69     		ldr	r2, [r7, #28]
 1115 007e A023     		mov	r3, #160
 1116 0080 5B00     		lsl	r3, r3, #1
 1117 0082 081C     		mov	r0, r1
 1118 0084 111C     		mov	r1, r2
 1119 0086 1A1C     		mov	r2, r3
 1120 0088 FFF7FEFF 		bl	lineProcessedRL0A
 597:../src/rls_m0.c **** 		numQvals = lineProcessedRL1A((uint32_t *)&CAM_PORT, qvalStore, lut2, lineStore, CAM_RES2_WIDTH, g
 1121              		.loc 1 597 0
 1122 008c 2B4B     		ldr	r3, .L18
 1123 008e 1968     		ldr	r1, [r3]
 1124 0090 2C4B     		ldr	r3, .L18+8
 1125 0092 1B68     		ldr	r3, [r3]
 1126 0094 0833     		add	r3, r3, #8
 1127 0096 1A1C     		mov	r2, r3
 1128 0098 2A4B     		ldr	r3, .L18+8
 1129 009a 1B68     		ldr	r3, [r3]
 1130 009c 5B88     		ldrh	r3, [r3, #2]
 1131 009e 9BB2     		uxth	r3, r3
 1132 00a0 181C     		mov	r0, r3
 1133 00a2 274B     		ldr	r3, .L18+4
 1134 00a4 7B60     		str	r3, [r7, #4]
 1135 00a6 3E6A     		ldr	r6, [r7, #32]
 1136 00a8 7D6A     		ldr	r5, [r7, #36]
 1137 00aa FC69     		ldr	r4, [r7, #28]
 1138 00ac A023     		mov	r3, #160
 1139 00ae 5B00     		lsl	r3, r3, #1
 1140 00b0 0093     		str	r3, [sp]
 1141 00b2 0191     		str	r1, [sp, #4]
 1142 00b4 0292     		str	r2, [sp, #8]
 1143 00b6 0390     		str	r0, [sp, #12]
 1144 00b8 234B     		ldr	r3, .L18+12
 1145 00ba 0493     		str	r3, [sp, #16]
 1146 00bc 7868     		ldr	r0, [r7, #4]
 1147 00be 311C     		mov	r1, r6
 1148 00c0 2A1C     		mov	r2, r5
 1149 00c2 231C     		mov	r3, r4
 1150 00c4 FFF7FEFF 		bl	lineProcessedRL1A
 1151 00c8 031C     		mov	r3, r0
 1152 00ca 7B61     		str	r3, [r7, #20]
 598:../src/rls_m0.c **** 		// modify qq to reflect added data
 599:../src/rls_m0.c **** 		g_qqueue->writeIndex += numQvals;
 1153              		.loc 1 599 0
 1154 00cc 1D4B     		ldr	r3, .L18+8
 1155 00ce 1A68     		ldr	r2, [r3]
 1156 00d0 1C4B     		ldr	r3, .L18+8
 1157 00d2 1B68     		ldr	r3, [r3]
 1158 00d4 5B88     		ldrh	r3, [r3, #2]
 1159 00d6 99B2     		uxth	r1, r3
 1160 00d8 7B69     		ldr	r3, [r7, #20]
 1161 00da 9BB2     		uxth	r3, r3
 1162 00dc CB18     		add	r3, r1, r3
 1163 00de 9BB2     		uxth	r3, r3
 1164 00e0 5380     		strh	r3, [r2, #2]
 600:../src/rls_m0.c **** 		if (g_qqueue->writeIndex>=QQ_MEM_SIZE)
 1165              		.loc 1 600 0
 1166 00e2 184B     		ldr	r3, .L18+8
 1167 00e4 1B68     		ldr	r3, [r3]
 1168 00e6 5B88     		ldrh	r3, [r3, #2]
 1169 00e8 9BB2     		uxth	r3, r3
 1170 00ea 184A     		ldr	r2, .L18+16
 1171 00ec 9342     		cmp	r3, r2
 1172 00ee 0AD9     		bls	.L16
 601:../src/rls_m0.c **** 			g_qqueue->writeIndex -= QQ_MEM_SIZE;
 1173              		.loc 1 601 0
 1174 00f0 144B     		ldr	r3, .L18+8
 1175 00f2 1A68     		ldr	r2, [r3]
 1176 00f4 134B     		ldr	r3, .L18+8
 1177 00f6 1B68     		ldr	r3, [r3]
 1178 00f8 5B88     		ldrh	r3, [r3, #2]
 1179 00fa 9BB2     		uxth	r3, r3
 1180 00fc 1449     		ldr	r1, .L18+20
 1181 00fe 8C46     		mov	ip, r1
 1182 0100 6344     		add	r3, r3, ip
 1183 0102 9BB2     		uxth	r3, r3
 1184 0104 5380     		strh	r3, [r2, #2]
 1185              	.L16:
 602:../src/rls_m0.c **** 		g_qqueue->produced += numQvals;
 1186              		.loc 1 602 0 discriminator 2
 1187 0106 0F4B     		ldr	r3, .L18+8
 1188 0108 1A68     		ldr	r2, [r3]
 1189 010a 0E4B     		ldr	r3, .L18+8
 1190 010c 1B68     		ldr	r3, [r3]
 1191 010e 9B88     		ldrh	r3, [r3, #4]
 1192 0110 99B2     		uxth	r1, r3
 1193 0112 7B69     		ldr	r3, [r7, #20]
 1194 0114 9BB2     		uxth	r3, r3
 1195 0116 CB18     		add	r3, r1, r3
 1196 0118 9BB2     		uxth	r3, r3
 1197 011a 9380     		strh	r3, [r2, #4]
 603:../src/rls_m0.c **** 		totalQvals += numQvals+1; // +1 because of beginning of line 
 1198              		.loc 1 603 0 discriminator 2
 1199 011c 7A69     		ldr	r2, [r7, #20]
 1200 011e BB6A     		ldr	r3, [r7, #40]
 1201 0120 D318     		add	r3, r2, r3
 1202 0122 0133     		add	r3, r3, #1
 1203 0124 BB62     		str	r3, [r7, #40]
 588:../src/rls_m0.c **** 	{
 1204              		.loc 1 588 0 discriminator 2
 1205 0126 FB6A     		ldr	r3, [r7, #44]
 1206 0128 0133     		add	r3, r3, #1
 1207 012a FB62     		str	r3, [r7, #44]
 1208              	.L14:
 588:../src/rls_m0.c **** 	{
 1209              		.loc 1 588 0 is_stmt 0 discriminator 1
 1210 012c FB6A     		ldr	r3, [r7, #44]
 1211 012e C72B     		cmp	r3, #199
 1212 0130 98D9     		bls	.L17
 604:../src/rls_m0.c **** 	}
 605:../src/rls_m0.c **** 	return 0;
 1213              		.loc 1 605 0 is_stmt 1
 1214 0132 0023     		mov	r3, #0
 1215              	.L13:
 606:../src/rls_m0.c **** }
 1216              		.loc 1 606 0
 1217 0134 181C     		mov	r0, r3
 1218 0136 BD46     		mov	sp, r7
 1219 0138 0DB0     		add	sp, sp, #52
 1220              		@ sp needed
 1221 013a F0BD     		pop	{r4, r5, r6, r7, pc}
 1222              	.L19:
 1223              		.align	2
 1224              	.L18:
 1225 013c 00000000 		.word	g_logLut
 1226 0140 04610F40 		.word	1074749700
 1227 0144 00000000 		.word	g_qqueue
 1228 0148 FE0B0000 		.word	3070
 1229 014c FD0B0000 		.word	3069
 1230 0150 02F4FFFF 		.word	-3070
 1231              		.cfi_endproc
 1232              	.LFE36:
 1234              		.section	.rodata
 1235              		.align	2
 1236              	.LC3:
 1237 0000 67657452 		.ascii	"getRLSFrame\000"
 1237      4C534672 
 1237      616D6500 
 1238              		.section	.text.rls_init,"ax",%progbits
 1239              		.align	2
 1240              		.global	rls_init
 1241              		.code	16
 1242              		.thumb_func
 1244              	rls_init:
 1245              	.LFB37:
 607:../src/rls_m0.c **** 
 608:../src/rls_m0.c **** 
 609:../src/rls_m0.c **** int rls_init(void)
 610:../src/rls_m0.c **** {
 1246              		.loc 1 610 0
 1247              		.cfi_startproc
 1248 0000 80B5     		push	{r7, lr}
 1249              		.cfi_def_cfa_offset 8
 1250              		.cfi_offset 7, -8
 1251              		.cfi_offset 14, -4
 1252 0002 00AF     		add	r7, sp, #0
 1253              		.cfi_def_cfa_register 7
 611:../src/rls_m0.c **** 	chirpSetProc("getRLSFrame", (ProcPtr)getRLSFrame);
 1254              		.loc 1 611 0
 1255 0004 044A     		ldr	r2, .L22
 1256 0006 054B     		ldr	r3, .L22+4
 1257 0008 101C     		mov	r0, r2
 1258 000a 191C     		mov	r1, r3
 1259 000c FFF7FEFF 		bl	chirpSetProc
 612:../src/rls_m0.c **** 	return 0;
 1260              		.loc 1 612 0
 1261 0010 0023     		mov	r3, #0
 613:../src/rls_m0.c **** }
 1262              		.loc 1 613 0
 1263 0012 181C     		mov	r0, r3
 1264 0014 BD46     		mov	sp, r7
 1265              		@ sp needed
 1266 0016 80BD     		pop	{r7, pc}
 1267              	.L23:
 1268              		.align	2
 1269              	.L22:
 1270 0018 00000000 		.word	.LC3
 1271 001c 00000000 		.word	getRLSFrame
 1272              		.cfi_endproc
 1273              	.LFE37:
 1275              		.text
 1276              	.Letext0:
 1277              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
 1278              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
 1279              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
 1280              		.file 5 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
 1281              		.file 6 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 rls_m0.c
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:22     .bss.g_logLut:00000000 g_logLut
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:19     .bss.g_logLut:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:25     .text.lineProcessedRL0A:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:30     .text.lineProcessedRL0A:00000000 lineProcessedRL0A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:80     .text.lineProcessedRL0A:0000001c dest10A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:104    .text.lineProcessedRL0A:00000026 loop5A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:184    .text.lineProcessedRL0A:0000004c dest11A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:216    .text.lineProcessedRL1A:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:221    .text.lineProcessedRL1A:00000000 lineProcessedRL1A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:275    .text.lineProcessedRL1A:00000020 dest12A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:327    .text.lineProcessedRL1A:00000038 zero0
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:717    .text.lineProcessedRL1A:00000104 eol
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:344    .text.lineProcessedRL1A:00000040 zero1
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:489    .text.lineProcessedRL1A:00000088 one
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:791    .text.lineProcessedRL1A:00000130 eol0
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:803    .text.lineProcessedRL1A:00000134 dest20A
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:855    .text.lineProcessedRL1A:0000014c lcpy
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:907    .text.lineProcessedRL1A:00000162 ecpy
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:895    .text.lineProcessedRL1A:0000015e wrap
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:932    .text.intLog:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:937    .text.intLog:00000000 intLog
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:962    .text.createLogLut:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:967    .text.createLogLut:00000000 createLogLut
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1016   .text.createLogLut:0000003c $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1021   .text.getRLSFrame:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1026   .text.getRLSFrame:00000000 getRLSFrame
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1225   .text.getRLSFrame:0000013c $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1235   .rodata:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1239   .text.rls_init:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1244   .text.rls_init:00000000 rls_init
C:\Users\OUROBO~1\AppData\Local\Temp\ccLtpiXk.s:1270   .text.rls_init:00000018 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
callSyncM1
qq_free
qq_enqueue
skipLines
g_qqueue
chirpSetProc
