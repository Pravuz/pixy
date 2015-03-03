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
  13              		.file	"main_m0.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.global	g_loop
  18              		.section	.data.g_loop,"aw",%progbits
  21              	g_loop:
  22 0000 01       		.byte	1
  23              		.section	.rodata
  24              		.align	2
  25              	.LC0:
  26 0000 4D302073 		.ascii	"M0 start\012\000"
  26      74617274 
  26      0A00
  27 000a 0000     		.section	.text.main,"ax",%progbits
  28              		.align	2
  29              		.global	main
  30              		.code	16
  31              		.thumb_func
  33              	main:
  34              	.LFB32:
  35              		.file 1 "../src/main_m0.c"
   1:../src/main_m0.c **** //
   2:../src/main_m0.c **** // begin license header
   3:../src/main_m0.c **** //
   4:../src/main_m0.c **** // This file is part of Pixy CMUcam5 or "Pixy" for short
   5:../src/main_m0.c **** //
   6:../src/main_m0.c **** // All Pixy source code is provided under the terms of the
   7:../src/main_m0.c **** // GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
   8:../src/main_m0.c **** // Those wishing to use Pixy source code, software and/or
   9:../src/main_m0.c **** // technologies under different licensing terms should contact us at
  10:../src/main_m0.c **** // cmucam@cs.cmu.edu. Such licensing terms are available for
  11:../src/main_m0.c **** // all portions of the Pixy codebase presented here.
  12:../src/main_m0.c **** //
  13:../src/main_m0.c **** // end license header
  14:../src/main_m0.c **** //
  15:../src/main_m0.c **** 
  16:../src/main_m0.c **** #include <debug.h>
  17:../src/main_m0.c **** #include <chirp.h>
  18:../src/main_m0.c **** #include <cycletimer.h>
  19:../src/main_m0.c **** #include <pixyvals.h>
  20:../src/main_m0.c **** #include "exec_m0.h"
  21:../src/main_m0.c **** #include "frame_m0.h"
  22:../src/main_m0.c **** #include "rls_m0.h"
  23:../src/main_m0.c **** 
  24:../src/main_m0.c **** volatile uint8_t g_loop = 1;
  25:../src/main_m0.c **** 
  26:../src/main_m0.c **** int main(void)
  27:../src/main_m0.c **** {
  36              		.loc 1 27 0
  37              		.cfi_startproc
  38 0000 80B5     		push	{r7, lr}
  39              		.cfi_def_cfa_offset 8
  40              		.cfi_offset 7, -8
  41              		.cfi_offset 14, -4
  42 0002 82B0     		sub	sp, sp, #8
  43              		.cfi_def_cfa_offset 16
  44 0004 00AF     		add	r7, sp, #0
  45              		.cfi_def_cfa_register 7
  28:../src/main_m0.c **** 	//CTIMER_DECLARE();
  29:../src/main_m0.c **** #if 0
  30:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
  31:../src/main_m0.c **** 	uint32_t lut = SRAM1_LOC;
  32:../src/main_m0.c **** 
  33:../src/main_m0.c **** 	//while(1);
  34:../src/main_m0.c **** 	memset((void *)QQ_LOC, 0x01, 0x3000);
  35:../src/main_m0.c **** 	g_qqueue->writeIndex = 0;
  36:../src/main_m0.c **** 	g_qqueue->produced = 0;
  37:../src/main_m0.c **** 	g_qqueue->consumed = 0;
  38:../src/main_m0.c **** 
  39:../src/main_m0.c ****  	while(1)
  40:../src/main_m0.c ****  		getRLSFrame(&memory, &lut); 
  41:../src/main_m0.c **** #endif
  42:../src/main_m0.c **** 	//printf("M0 start\n");
  43:../src/main_m0.c ****  	int i = 0;
  46              		.loc 1 43 0
  47 0006 0023     		mov	r3, #0
  48 0008 7B60     		str	r3, [r7, #4]
  44:../src/main_m0.c **** 
  45:../src/main_m0.c ****  	_DBG("M0 start\n");
  49              		.loc 1 45 0
  50 000a 0A4A     		ldr	r2, .L3
  51 000c 0A4B     		ldr	r3, .L3+4
  52 000e 101C     		mov	r0, r2
  53 0010 191C     		mov	r1, r3
  54 0012 FFF7FEFF 		bl	UARTPuts
  46:../src/main_m0.c **** 	chirpOpen();
  55              		.loc 1 46 0
  56 0016 FFF7FEFF 		bl	chirpOpen
  47:../src/main_m0.c **** 	exec_init();
  57              		.loc 1 47 0
  58 001a FFF7FEFF 		bl	exec_init
  48:../src/main_m0.c **** 	frame_init();
  59              		.loc 1 48 0
  60 001e FFF7FEFF 		bl	frame_init
  49:../src/main_m0.c **** 	rls_init();
  61              		.loc 1 49 0
  62 0022 FFF7FEFF 		bl	rls_init
  50:../src/main_m0.c **** 
  51:../src/main_m0.c **** #if 0
  52:../src/main_m0.c **** 	vsync();
  53:../src/main_m0.c **** #endif
  54:../src/main_m0.c **** #if 0
  55:../src/main_m0.c **** 	//while(g_loop);
  56:../src/main_m0.c **** 	uint8_t type = CAM_GRAB_M1R2;
  57:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
  58:../src/main_m0.c **** 	uint16_t offset = 0;
  59:../src/main_m0.c **** 	uint16_t width = 320;
  60:../src/main_m0.c **** 	uint16_t height = 200;
  61:../src/main_m0.c **** 	while(1)
  62:../src/main_m0.c **** 	{
  63:../src/main_m0.c **** 		 getFrame(&type, &memory, &offset, &offset, &width, &height);
  64:../src/main_m0.c **** 		 i++;
  65:../src/main_m0.c **** 
  66:../src/main_m0.c **** 		 if (i%50==0)
  67:../src/main_m0.c **** 		 {
  68:../src/main_m0.c **** 			 _DBD32(i), _CR();
  69:../src/main_m0.c **** 		 }
  70:../src/main_m0.c **** 	}
  71:../src/main_m0.c **** #endif
  72:../src/main_m0.c **** 	//printf("M0 ready\n");
  73:../src/main_m0.c **** 	exec_loop();
  63              		.loc 1 73 0
  64 0026 FFF7FEFF 		bl	exec_loop
  74:../src/main_m0.c **** 
  75:../src/main_m0.c **** #if 0
  76:../src/main_m0.c **** 	while(1)
  77:../src/main_m0.c **** 	{
  78:../src/main_m0.c **** 		CTIMER_START();
  79:../src/main_m0.c **** 		syncM1((uint32_t *)&LPC_GPIO_PORT->PIN[1], 0x2000);
  80:../src/main_m0.c **** 		CTIMER_STOP();
  81:../src/main_m0.c **** 		
  82:../src/main_m0.c **** 		printf("%d\n", CTIMER_GET());
  83:../src/main_m0.c **** 	}	
  84:../src/main_m0.c **** #endif
  85:../src/main_m0.c **** #if 0
  86:../src/main_m0.c **** {
  87:../src/main_m0.c **** 	uint32_t i;
  88:../src/main_m0.c **** 	uint8_t *lut = (uint8_t *)SRAM1_LOC + 0x10000;
  89:../src/main_m0.c **** 	uint32_t memory = SRAM1_LOC;
  90:../src/main_m0.c **** 	uint32_t size = SRAM1_SIZE/2;
  91:../src/main_m0.c **** 	for (i=0; i<0x10000; i++)
  92:../src/main_m0.c **** 		lut[i] = 0;
  93:../src/main_m0.c **** 	lut[0xb400] = 0;
  94:../src/main_m0.c **** 	lut[0xb401] = 1;
  95:../src/main_m0.c **** 	lut[0xb402] = 1;
  96:../src/main_m0.c **** 	lut[0xb403] = 1;
  97:../src/main_m0.c **** 	lut[0xb404] = 0;
  98:../src/main_m0.c **** 	lut[0xb405] = 1;
  99:../src/main_m0.c **** 	lut[0xb406] = 1;
 100:../src/main_m0.c **** 	lut[0xb407] = 0;
 101:../src/main_m0.c **** 	lut[0xb408] = 0;
 102:../src/main_m0.c **** 	lut[0xb409] = 0;
 103:../src/main_m0.c **** 
 104:../src/main_m0.c **** 	while(1)
 105:../src/main_m0.c ****  		getRLSFrame(&memory, &size, (uint32_t *)&lut);
 106:../src/main_m0.c **** }
 107:../src/main_m0.c **** #endif
 108:../src/main_m0.c **** 
 109:../src/main_m0.c **** return 0;
  65              		.loc 1 109 0
  66 002a 0023     		mov	r3, #0
 110:../src/main_m0.c **** }
  67              		.loc 1 110 0
  68 002c 181C     		mov	r0, r3
  69 002e BD46     		mov	sp, r7
  70 0030 02B0     		add	sp, sp, #8
  71              		@ sp needed
  72 0032 80BD     		pop	{r7, pc}
  73              	.L4:
  74              		.align	2
  75              	.L3:
  76 0034 00200840 		.word	1074274304
  77 0038 00000000 		.word	.LC0
  78              		.cfi_endproc
  79              	.LFE32:
  81              		.text
  82              	.Letext0:
  83              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
  84              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
  85              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 main_m0.c
C:\Users\OUROBO~1\AppData\Local\Temp\cc64mRKV.s:21     .data.g_loop:00000000 g_loop
C:\Users\OUROBO~1\AppData\Local\Temp\cc64mRKV.s:24     .rodata:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cc64mRKV.s:28     .text.main:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cc64mRKV.s:33     .text.main:00000000 main
C:\Users\OUROBO~1\AppData\Local\Temp\cc64mRKV.s:76     .text.main:00000034 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
UARTPuts
chirpOpen
exec_init
frame_init
rls_init
exec_loop
