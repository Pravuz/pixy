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
  13              		.file	"cr_startup_lpc43xx-m0app.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.global	g_pfnVectors
  18              		.section	.isr_vector,"a",%progbits
  19              		.align	2
  22              	g_pfnVectors:
  23 0000 00000000 		.word	_vStackTop
  24 0004 00000000 		.word	ResetISR
  25 0008 00000000 		.word	M0_NMI_Handler
  26 000c 00000000 		.word	M0_HardFault_Handler
  27 0010 00000000 		.word	0
  28 0014 00000000 		.word	0
  29 0018 00000000 		.word	0
  30 001c 00000000 		.word	0
  31 0020 00000000 		.word	0
  32 0024 00000000 		.word	0
  33 0028 00000000 		.word	0
  34 002c 00000000 		.word	M0_SVC_Handler
  35 0030 00000000 		.word	0
  36 0034 00000000 		.word	0
  37 0038 00000000 		.word	M0_PendSV_Handler
  38 003c 00000000 		.word	M0_SysTick_Handler
  39 0040 00000000 		.word	M0_RTC_IRQHandler
  40 0044 00000000 		.word	M0_M4CORE_IRQHandler
  41 0048 00000000 		.word	M0_DMA_IRQHandler
  42 004c 00000000 		.word	0
  43 0050 00000000 		.word	0
  44 0054 00000000 		.word	M0_ETH_IRQHandler
  45 0058 00000000 		.word	M0_SDIO_IRQHandler
  46 005c 00000000 		.word	M0_LCD_IRQHandler
  47 0060 00000000 		.word	M0_USB0_IRQHandler
  48 0064 00000000 		.word	M0_USB1_IRQHandler
  49 0068 00000000 		.word	M0_SCT_IRQHandler
  50 006c 00000000 		.word	M0_RIT_OR_WWDT_IRQHandler
  51 0070 00000000 		.word	M0_TIMER0_IRQHandler
  52 0074 00000000 		.word	M0_GINT1_IRQHandler
  53 0078 00000000 		.word	M0_TIMER3_IRQHandler
  54 007c 00000000 		.word	0
  55 0080 00000000 		.word	0
  56 0084 00000000 		.word	M0_MCPWM_IRQHandler
  57 0088 00000000 		.word	M0_ADC0_IRQHandler
  58 008c 00000000 		.word	M0_I2C0_OR_I2C1_IRQHandler
  59 0090 00000000 		.word	M0_SGPIO_IRQHandler
  60 0094 00000000 		.word	M0_SPI_OR_DAC_IRQHandler
  61 0098 00000000 		.word	M0_ADC1_IRQHandler
  62 009c 00000000 		.word	M0_SSP0_OR_SSP1_IRQHandler
  63 00a0 00000000 		.word	M0_EVENTROUTER_IRQHandler
  64 00a4 00000000 		.word	M0_USART0_IRQHandler
  65 00a8 00000000 		.word	M0_USART2_OR_C_CAN1_IRQHandler
  66 00ac 00000000 		.word	M0_USART3_IRQHandler
  67 00b0 00000000 		.word	M0_I2S0_OR_I2S1_OR_QEI_IRQHandler
  68 00b4 00000000 		.word	M0_C_CAN0_IRQHandler
  69 00b8 00000000 		.word	M0_SPIFI_OR_VADC_IRQHandler
  70 00bc 00000000 		.word	M0_M0SUB_IRQHandler
  71              		.section	.after_vectors,"ax",%progbits
  72              		.align	2
  73              		.global	data_init
  74              		.code	16
  75              		.thumb_func
  77              	data_init:
  78              	.LFB32:
  79              		.file 1 "../src/cr_startup_lpc43xx-m0app.c"
   1:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
   2:../src/cr_startup_lpc43xx-m0app.c **** // LPC43xx (Cortex M0 APP) Startup code for use with LPCXpresso IDE
   3:../src/cr_startup_lpc43xx-m0app.c **** //
   4:../src/cr_startup_lpc43xx-m0app.c **** // Version : 140113
   5:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
   6:../src/cr_startup_lpc43xx-m0app.c **** //
   7:../src/cr_startup_lpc43xx-m0app.c **** // Copyright(C) NXP Semiconductors, 2013-2014
   8:../src/cr_startup_lpc43xx-m0app.c **** // All rights reserved.
   9:../src/cr_startup_lpc43xx-m0app.c **** //
  10:../src/cr_startup_lpc43xx-m0app.c **** // Software that is described herein is for illustrative purposes only
  11:../src/cr_startup_lpc43xx-m0app.c **** // which provides customers with programming information regarding the
  12:../src/cr_startup_lpc43xx-m0app.c **** // LPC products.  This software is supplied "AS IS" without any warranties of
  13:../src/cr_startup_lpc43xx-m0app.c **** // any kind, and NXP Semiconductors and its licensor disclaim any and
  14:../src/cr_startup_lpc43xx-m0app.c **** // all warranties, express or implied, including all implied warranties of
  15:../src/cr_startup_lpc43xx-m0app.c **** // merchantability, fitness for a particular purpose and non-infringement of
  16:../src/cr_startup_lpc43xx-m0app.c **** // intellectual property rights.  NXP Semiconductors assumes no responsibility
  17:../src/cr_startup_lpc43xx-m0app.c **** // or liability for the use of the software, conveys no license or rights under any
  18:../src/cr_startup_lpc43xx-m0app.c **** // patent, copyright, mask work right, or any other intellectual property rights in
  19:../src/cr_startup_lpc43xx-m0app.c **** // or to any products. NXP Semiconductors reserves the right to make changes
  20:../src/cr_startup_lpc43xx-m0app.c **** // in the software without notification. NXP Semiconductors also makes no
  21:../src/cr_startup_lpc43xx-m0app.c **** // representation or warranty that such application will be suitable for the
  22:../src/cr_startup_lpc43xx-m0app.c **** // specified use without further testing or modification.
  23:../src/cr_startup_lpc43xx-m0app.c **** //
  24:../src/cr_startup_lpc43xx-m0app.c **** // Permission to use, copy, modify, and distribute this software and its
  25:../src/cr_startup_lpc43xx-m0app.c **** // documentation is hereby granted, under NXP Semiconductors' and its
  26:../src/cr_startup_lpc43xx-m0app.c **** // licensor's relevant copyrights in the software, without fee, provided that it
  27:../src/cr_startup_lpc43xx-m0app.c **** // is used in conjunction with NXP Semiconductors microcontrollers.  This
  28:../src/cr_startup_lpc43xx-m0app.c **** // copyright, permission, and disclaimer notice must appear in all copies of
  29:../src/cr_startup_lpc43xx-m0app.c **** // this code.
  30:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  31:../src/cr_startup_lpc43xx-m0app.c **** 
  32:../src/cr_startup_lpc43xx-m0app.c **** #include "debug_frmwrk.h"
  33:../src/cr_startup_lpc43xx-m0app.c **** 
  34:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__cplusplus)
  35:../src/cr_startup_lpc43xx-m0app.c **** #ifdef __REDLIB__
  36:../src/cr_startup_lpc43xx-m0app.c **** #error Redlib does not support C++
  37:../src/cr_startup_lpc43xx-m0app.c **** #else
  38:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  39:../src/cr_startup_lpc43xx-m0app.c **** //
  40:../src/cr_startup_lpc43xx-m0app.c **** // The entry point for the C++ library startup
  41:../src/cr_startup_lpc43xx-m0app.c **** //
  42:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  43:../src/cr_startup_lpc43xx-m0app.c **** extern "C" {
  44:../src/cr_startup_lpc43xx-m0app.c ****   extern void __libc_init_array(void);
  45:../src/cr_startup_lpc43xx-m0app.c **** }
  46:../src/cr_startup_lpc43xx-m0app.c **** #endif
  47:../src/cr_startup_lpc43xx-m0app.c **** #endif
  48:../src/cr_startup_lpc43xx-m0app.c **** 
  49:../src/cr_startup_lpc43xx-m0app.c **** #define WEAK __attribute__ ((weak))
  50:../src/cr_startup_lpc43xx-m0app.c **** #define ALIAS(f) __attribute__ ((weak, alias (#f)))
  51:../src/cr_startup_lpc43xx-m0app.c **** 
  52:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  53:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__cplusplus)
  54:../src/cr_startup_lpc43xx-m0app.c **** extern "C" {
  55:../src/cr_startup_lpc43xx-m0app.c **** #endif
  56:../src/cr_startup_lpc43xx-m0app.c **** 
  57:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  58:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_CMSIS) || defined (__USE_LPCOPEN)
  59:../src/cr_startup_lpc43xx-m0app.c **** // Declaration of external SystemInit function
  60:../src/cr_startup_lpc43xx-m0app.c **** extern void SystemInit(void);
  61:../src/cr_startup_lpc43xx-m0app.c **** #endif
  62:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  63:../src/cr_startup_lpc43xx-m0app.c **** //
  64:../src/cr_startup_lpc43xx-m0app.c **** // Forward declaration of the default handlers. These are aliased.
  65:../src/cr_startup_lpc43xx-m0app.c **** // When the application defines a handler (with the same name), this will 
  66:../src/cr_startup_lpc43xx-m0app.c **** // automatically take precedence over these weak definitions
  67:../src/cr_startup_lpc43xx-m0app.c **** //
  68:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  69:../src/cr_startup_lpc43xx-m0app.c ****      void ResetISR(void);
  70:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
  71:../src/cr_startup_lpc43xx-m0app.c **** WEAK void NMI_Handler(void);
  72:../src/cr_startup_lpc43xx-m0app.c **** WEAK void HardFault_Handler(void);
  73:../src/cr_startup_lpc43xx-m0app.c **** WEAK void SVC_Handler(void);
  74:../src/cr_startup_lpc43xx-m0app.c **** WEAK void PendSV_Handler(void);
  75:../src/cr_startup_lpc43xx-m0app.c **** WEAK void SysTick_Handler(void);
  76:../src/cr_startup_lpc43xx-m0app.c **** WEAK void IntDefaultHandler(void);
  77:../src/cr_startup_lpc43xx-m0app.c **** #else
  78:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_NMI_Handler(void);
  79:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_HardFault_Handler (void);
  80:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_SVC_Handler(void);
  81:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_PendSV_Handler(void);
  82:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_SysTick_Handler(void);
  83:../src/cr_startup_lpc43xx-m0app.c **** WEAK void M0_IntDefaultHandler(void);
  84:../src/cr_startup_lpc43xx-m0app.c **** #endif
  85:../src/cr_startup_lpc43xx-m0app.c **** 
  86:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  87:../src/cr_startup_lpc43xx-m0app.c **** //
  88:../src/cr_startup_lpc43xx-m0app.c **** // Forward declaration of the specific IRQ handlers. These are aliased
  89:../src/cr_startup_lpc43xx-m0app.c **** // to the IntDefaultHandler, which is a 'forever' loop. When the application
  90:../src/cr_startup_lpc43xx-m0app.c **** // defines a handler (with the same name), this will automatically take 
  91:../src/cr_startup_lpc43xx-m0app.c **** // precedence over these weak definitions
  92:../src/cr_startup_lpc43xx-m0app.c **** //
  93:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
  94:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
  95:../src/cr_startup_lpc43xx-m0app.c **** void RTC_IRQHandler(void) ALIAS(IntDefaultHandler);
  96:../src/cr_startup_lpc43xx-m0app.c **** void MX_CORE_IRQHandler(void) ALIAS(IntDefaultHandler);
  97:../src/cr_startup_lpc43xx-m0app.c **** void DMA_IRQHandler(void) ALIAS(IntDefaultHandler);
  98:../src/cr_startup_lpc43xx-m0app.c **** void FLASHEEPROM_IRQHandler(void) ALIAS(IntDefaultHandler);
  99:../src/cr_startup_lpc43xx-m0app.c **** void ETH_IRQHandler(void) ALIAS(IntDefaultHandler);
 100:../src/cr_startup_lpc43xx-m0app.c **** void SDIO_IRQHandler(void) ALIAS(IntDefaultHandler);
 101:../src/cr_startup_lpc43xx-m0app.c **** void LCD_IRQHandler(void) ALIAS(IntDefaultHandler);
 102:../src/cr_startup_lpc43xx-m0app.c **** void USB0_IRQHandler(void) ALIAS(IntDefaultHandler);
 103:../src/cr_startup_lpc43xx-m0app.c **** void USB1_IRQHandler(void) ALIAS(IntDefaultHandler);
 104:../src/cr_startup_lpc43xx-m0app.c **** void SCT_IRQHandler(void) ALIAS(IntDefaultHandler);
 105:../src/cr_startup_lpc43xx-m0app.c **** void RIT_IRQHandler(void) ALIAS(IntDefaultHandler);
 106:../src/cr_startup_lpc43xx-m0app.c **** void TIMER0_IRQHandler(void) ALIAS(IntDefaultHandler);
 107:../src/cr_startup_lpc43xx-m0app.c **** void GINT1_IRQHandler(void) ALIAS(IntDefaultHandler);
 108:../src/cr_startup_lpc43xx-m0app.c **** void GPIO4_IRQHandler(void) ALIAS(IntDefaultHandler);
 109:../src/cr_startup_lpc43xx-m0app.c **** void TIMER3_IRQHandler(void) ALIAS(IntDefaultHandler);
 110:../src/cr_startup_lpc43xx-m0app.c **** void MCPWM_IRQHandler(void) ALIAS(IntDefaultHandler);
 111:../src/cr_startup_lpc43xx-m0app.c **** void ADC0_IRQHandler(void) ALIAS(IntDefaultHandler);
 112:../src/cr_startup_lpc43xx-m0app.c **** void I2C0_IRQHandler(void) ALIAS(IntDefaultHandler);
 113:../src/cr_startup_lpc43xx-m0app.c **** void SGPIO_IRQHandler(void) ALIAS(IntDefaultHandler);
 114:../src/cr_startup_lpc43xx-m0app.c **** void SPI_IRQHandler (void) ALIAS(IntDefaultHandler);
 115:../src/cr_startup_lpc43xx-m0app.c **** void ADC1_IRQHandler(void) ALIAS(IntDefaultHandler);
 116:../src/cr_startup_lpc43xx-m0app.c **** void SSP0_IRQHandler(void) ALIAS(IntDefaultHandler);
 117:../src/cr_startup_lpc43xx-m0app.c **** void EVRT_IRQHandler(void) ALIAS(IntDefaultHandler);
 118:../src/cr_startup_lpc43xx-m0app.c **** void UART0_IRQHandler(void) ALIAS(IntDefaultHandler);
 119:../src/cr_startup_lpc43xx-m0app.c **** void UART1_IRQHandler(void) ALIAS(IntDefaultHandler);
 120:../src/cr_startup_lpc43xx-m0app.c **** void UART2_IRQHandler(void) ALIAS(IntDefaultHandler);
 121:../src/cr_startup_lpc43xx-m0app.c **** void UART3_IRQHandler(void) ALIAS(IntDefaultHandler);
 122:../src/cr_startup_lpc43xx-m0app.c **** void I2S0_IRQHandler(void) ALIAS(IntDefaultHandler);
 123:../src/cr_startup_lpc43xx-m0app.c **** void CAN0_IRQHandler(void) ALIAS(IntDefaultHandler);
 124:../src/cr_startup_lpc43xx-m0app.c **** void SPIFI_ADCHS_IRQHandler(void) ALIAS(IntDefaultHandler);
 125:../src/cr_startup_lpc43xx-m0app.c **** void M0SUB_IRQHandler(void) ALIAS(IntDefaultHandler);
 126:../src/cr_startup_lpc43xx-m0app.c **** #else
 127:../src/cr_startup_lpc43xx-m0app.c **** void M0_RTC_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 128:../src/cr_startup_lpc43xx-m0app.c **** void M0_M4CORE_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 129:../src/cr_startup_lpc43xx-m0app.c **** void M0_DMA_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 130:../src/cr_startup_lpc43xx-m0app.c **** void M0_ETH_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 131:../src/cr_startup_lpc43xx-m0app.c **** void M0_SDIO_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 132:../src/cr_startup_lpc43xx-m0app.c **** void M0_LCD_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 133:../src/cr_startup_lpc43xx-m0app.c **** void M0_USB0_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 134:../src/cr_startup_lpc43xx-m0app.c **** void M0_USB1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 135:../src/cr_startup_lpc43xx-m0app.c **** void M0_SCT_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 136:../src/cr_startup_lpc43xx-m0app.c **** void M0_RIT_OR_WWDT_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 137:../src/cr_startup_lpc43xx-m0app.c **** void M0_TIMER0_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 138:../src/cr_startup_lpc43xx-m0app.c **** void M0_GINT1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 139:../src/cr_startup_lpc43xx-m0app.c **** void M0_TIMER3_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 140:../src/cr_startup_lpc43xx-m0app.c **** void M0_MCPWM_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 141:../src/cr_startup_lpc43xx-m0app.c **** void M0_ADC0_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 142:../src/cr_startup_lpc43xx-m0app.c **** void M0_I2C0_OR_I2C1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 143:../src/cr_startup_lpc43xx-m0app.c **** void M0_SGPIO_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 144:../src/cr_startup_lpc43xx-m0app.c **** void M0_SPI_OR_DAC_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 145:../src/cr_startup_lpc43xx-m0app.c **** void M0_ADC1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 146:../src/cr_startup_lpc43xx-m0app.c **** void M0_SSP0_OR_SSP1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 147:../src/cr_startup_lpc43xx-m0app.c **** void M0_EVENTROUTER_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 148:../src/cr_startup_lpc43xx-m0app.c **** void M0_USART0_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 149:../src/cr_startup_lpc43xx-m0app.c **** void M0_USART2_OR_C_CAN1_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 150:../src/cr_startup_lpc43xx-m0app.c **** void M0_USART3_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 151:../src/cr_startup_lpc43xx-m0app.c **** void M0_I2S0_OR_I2S1_OR_QEI_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 152:../src/cr_startup_lpc43xx-m0app.c **** void M0_C_CAN0_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 153:../src/cr_startup_lpc43xx-m0app.c **** void M0_SPIFI_OR_VADC_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 154:../src/cr_startup_lpc43xx-m0app.c **** void M0_M0SUB_IRQHandler(void) ALIAS(M0_IntDefaultHandler);
 155:../src/cr_startup_lpc43xx-m0app.c **** #endif
 156:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 157:../src/cr_startup_lpc43xx-m0app.c **** //
 158:../src/cr_startup_lpc43xx-m0app.c **** // The entry point for the application.
 159:../src/cr_startup_lpc43xx-m0app.c **** // __main() is the entry point for Redlib based applications
 160:../src/cr_startup_lpc43xx-m0app.c **** // main() is the entry point for Newlib based applications
 161:../src/cr_startup_lpc43xx-m0app.c **** //
 162:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 163:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__REDLIB__)
 164:../src/cr_startup_lpc43xx-m0app.c **** extern void __main(void);
 165:../src/cr_startup_lpc43xx-m0app.c **** #endif
 166:../src/cr_startup_lpc43xx-m0app.c **** extern int main(void);
 167:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 168:../src/cr_startup_lpc43xx-m0app.c **** //
 169:../src/cr_startup_lpc43xx-m0app.c **** // External declaration for the pointer to the stack top from the Linker Script
 170:../src/cr_startup_lpc43xx-m0app.c **** //
 171:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 172:../src/cr_startup_lpc43xx-m0app.c **** extern void _vStackTop(void);
 173:../src/cr_startup_lpc43xx-m0app.c **** 
 174:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 175:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__cplusplus)
 176:../src/cr_startup_lpc43xx-m0app.c **** } // extern "C"
 177:../src/cr_startup_lpc43xx-m0app.c **** #endif
 178:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 179:../src/cr_startup_lpc43xx-m0app.c **** //
 180:../src/cr_startup_lpc43xx-m0app.c **** // The vector table.
 181:../src/cr_startup_lpc43xx-m0app.c **** // This relies on the linker script to place at correct location in memory.
 182:../src/cr_startup_lpc43xx-m0app.c **** //
 183:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 184:../src/cr_startup_lpc43xx-m0app.c **** extern void (* const g_pfnVectors[])(void);
 185:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".isr_vector")))
 186:../src/cr_startup_lpc43xx-m0app.c **** void (* const g_pfnVectors[])(void) = {
 187:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 188:../src/cr_startup_lpc43xx-m0app.c ****     // Core Level - CM0
 189:../src/cr_startup_lpc43xx-m0app.c ****     &_vStackTop,                        // The initial stack pointer
 190:../src/cr_startup_lpc43xx-m0app.c ****     ResetISR,                           // 1 The reset handler
 191:../src/cr_startup_lpc43xx-m0app.c ****     NMI_Handler,                    // The NMI handler
 192:../src/cr_startup_lpc43xx-m0app.c ****     HardFault_Handler,              // The hard fault handler
 193:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 4 Reserved
 194:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 5 Reserved
 195:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 6 Reserved
 196:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 7 Reserved
 197:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 8 Reserved
 198:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 9 Reserved
 199:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 10 Reserved
 200:../src/cr_startup_lpc43xx-m0app.c ****     SVC_Handler,                    // SVCall handler
 201:../src/cr_startup_lpc43xx-m0app.c ****     0,                              // Reserved
 202:../src/cr_startup_lpc43xx-m0app.c ****     0,                              // Reserved
 203:../src/cr_startup_lpc43xx-m0app.c ****     PendSV_Handler,                 // The PendSV handler
 204:../src/cr_startup_lpc43xx-m0app.c ****     SysTick_Handler,                // The SysTick handler
 205:../src/cr_startup_lpc43xx-m0app.c **** 
 206:../src/cr_startup_lpc43xx-m0app.c ****     // Chip Level - 43xx M0 core
 207:../src/cr_startup_lpc43xx-m0app.c ****     RTC_IRQHandler,                 // 16 RTC
 208:../src/cr_startup_lpc43xx-m0app.c ****     MX_CORE_IRQHandler,             // 17 CortexM4/M0 (LPC43XX ONLY)
 209:../src/cr_startup_lpc43xx-m0app.c ****     DMA_IRQHandler,                 // 18 General Purpose DMA
 210:../src/cr_startup_lpc43xx-m0app.c ****     0,                              // 19 Reserved
 211:../src/cr_startup_lpc43xx-m0app.c ****     FLASHEEPROM_IRQHandler,         // 20 ORed flash Bank A, flash Bank B, EEPROM interrupts
 212:../src/cr_startup_lpc43xx-m0app.c ****     ETH_IRQHandler,                 // 21 Ethernet
 213:../src/cr_startup_lpc43xx-m0app.c ****     SDIO_IRQHandler,                // 22 SD/MMC
 214:../src/cr_startup_lpc43xx-m0app.c ****     LCD_IRQHandler,                 // 23 LCD
 215:../src/cr_startup_lpc43xx-m0app.c ****     USB0_IRQHandler,                // 24 USB0
 216:../src/cr_startup_lpc43xx-m0app.c ****     USB1_IRQHandler,                // 25 USB1
 217:../src/cr_startup_lpc43xx-m0app.c ****     SCT_IRQHandler,                 // 26 State Configurable Timer
 218:../src/cr_startup_lpc43xx-m0app.c ****     RIT_IRQHandler,                 // 27 ORed Repetitive Interrupt Timer, WWDT
 219:../src/cr_startup_lpc43xx-m0app.c ****     TIMER0_IRQHandler,              // 28 Timer0
 220:../src/cr_startup_lpc43xx-m0app.c ****     GINT1_IRQHandler,               // 29 GINT1
 221:../src/cr_startup_lpc43xx-m0app.c ****     GPIO4_IRQHandler,               // 30 GPIO4
 222:../src/cr_startup_lpc43xx-m0app.c ****     TIMER3_IRQHandler,              // 31 Timer 3
 223:../src/cr_startup_lpc43xx-m0app.c ****     MCPWM_IRQHandler,               // 32 Motor Control PWM
 224:../src/cr_startup_lpc43xx-m0app.c ****     ADC0_IRQHandler,                // 33 A/D Converter 0
 225:../src/cr_startup_lpc43xx-m0app.c ****     I2C0_IRQHandler,                // 34 ORed I2C0, I2C1
 226:../src/cr_startup_lpc43xx-m0app.c ****     SGPIO_IRQHandler,               // 35 SGPIO (LPC43XX ONLY)
 227:../src/cr_startup_lpc43xx-m0app.c ****     SPI_IRQHandler,                 // 36 ORed SPI, DAC (LPC43XX ONLY)
 228:../src/cr_startup_lpc43xx-m0app.c ****     ADC1_IRQHandler,                // 37 A/D Converter 1
 229:../src/cr_startup_lpc43xx-m0app.c ****     SSP0_IRQHandler,                // 38 ORed SSP0, SSP1
 230:../src/cr_startup_lpc43xx-m0app.c ****     EVRT_IRQHandler,                // 39 Event Router
 231:../src/cr_startup_lpc43xx-m0app.c ****     UART0_IRQHandler,               // 40 UART0
 232:../src/cr_startup_lpc43xx-m0app.c ****     UART1_IRQHandler,               // 41 UART1
 233:../src/cr_startup_lpc43xx-m0app.c ****     UART2_IRQHandler,               // 42 UART2
 234:../src/cr_startup_lpc43xx-m0app.c ****     UART3_IRQHandler,               // 43 USRT3
 235:../src/cr_startup_lpc43xx-m0app.c ****     I2S0_IRQHandler,                // 44 ORed I2S0, I2S1
 236:../src/cr_startup_lpc43xx-m0app.c ****     CAN0_IRQHandler,                // 45 C_CAN0
 237:../src/cr_startup_lpc43xx-m0app.c ****     SPIFI_ADCHS_IRQHandler,         // 46 SPIFI OR ADCHS interrupt
 238:../src/cr_startup_lpc43xx-m0app.c ****     M0SUB_IRQHandler,               // 47 M0SUB core
 239:../src/cr_startup_lpc43xx-m0app.c **** };
 240:../src/cr_startup_lpc43xx-m0app.c **** #else
 241:../src/cr_startup_lpc43xx-m0app.c ****     // Core Level - CM0
 242:../src/cr_startup_lpc43xx-m0app.c ****     &_vStackTop,                        // The initial stack pointer
 243:../src/cr_startup_lpc43xx-m0app.c ****     ResetISR,                           // 1 The reset handler
 244:../src/cr_startup_lpc43xx-m0app.c ****     M0_NMI_Handler,                     // 2 The NMI handler
 245:../src/cr_startup_lpc43xx-m0app.c ****     M0_HardFault_Handler,               // 3 The hard fault handler
 246:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 4 Reserved
 247:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 5 Reserved
 248:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 6 Reserved
 249:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 7 Reserved
 250:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 8 Reserved
 251:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 9 Reserved
 252:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 10 Reserved
 253:../src/cr_startup_lpc43xx-m0app.c ****     M0_SVC_Handler,                     // 11 SVCall handler
 254:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 12 Reserved
 255:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 13 Reserved
 256:../src/cr_startup_lpc43xx-m0app.c ****     M0_PendSV_Handler,                  // 14 The PendSV handler
 257:../src/cr_startup_lpc43xx-m0app.c ****     M0_SysTick_Handler,                 // 15 The SysTick handler
 258:../src/cr_startup_lpc43xx-m0app.c **** 
 259:../src/cr_startup_lpc43xx-m0app.c ****     // Chip Level - LPC43 (CM0 APP)
 260:../src/cr_startup_lpc43xx-m0app.c ****         M0_RTC_IRQHandler,              // 16 RTC
 261:../src/cr_startup_lpc43xx-m0app.c ****     M0_M4CORE_IRQHandler,               // 17 Interrupt from M4 Core
 262:../src/cr_startup_lpc43xx-m0app.c ****     M0_DMA_IRQHandler,                  // 18 General Purpose DMA
 263:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 19 Reserved
 264:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 20 Reserved
 265:../src/cr_startup_lpc43xx-m0app.c ****     M0_ETH_IRQHandler,                  // 21 Ethernet
 266:../src/cr_startup_lpc43xx-m0app.c ****     M0_SDIO_IRQHandler,                 // 22 SD/MMC
 267:../src/cr_startup_lpc43xx-m0app.c ****     M0_LCD_IRQHandler,                  // 23 LCD
 268:../src/cr_startup_lpc43xx-m0app.c ****     M0_USB0_IRQHandler,                 // 24 USB0
 269:../src/cr_startup_lpc43xx-m0app.c ****     M0_USB1_IRQHandler,                 // 25 USB1
 270:../src/cr_startup_lpc43xx-m0app.c ****     M0_SCT_IRQHandler ,                 // 26 State Configurable Timer
 271:../src/cr_startup_lpc43xx-m0app.c ****     M0_RIT_OR_WWDT_IRQHandler,          // 27 Repetitive Interrupt Timer
 272:../src/cr_startup_lpc43xx-m0app.c ****     M0_TIMER0_IRQHandler,               // 28 Timer0
 273:../src/cr_startup_lpc43xx-m0app.c ****     M0_GINT1_IRQHandler,                // 29 GINT1
 274:../src/cr_startup_lpc43xx-m0app.c ****     M0_TIMER3_IRQHandler,               // 30 Timer3
 275:../src/cr_startup_lpc43xx-m0app.c ****     0,                                  // 31 Reserved
 276:../src/cr_startup_lpc43xx-m0app.c ****     0 ,                                 // 32 Reserved
 277:../src/cr_startup_lpc43xx-m0app.c ****     M0_MCPWM_IRQHandler,                // 33 Motor Control PWM
 278:../src/cr_startup_lpc43xx-m0app.c ****     M0_ADC0_IRQHandler,                 // 34 ADC0
 279:../src/cr_startup_lpc43xx-m0app.c ****     M0_I2C0_OR_I2C1_IRQHandler,         // 35 I2C0 or I2C1
 280:../src/cr_startup_lpc43xx-m0app.c ****     M0_SGPIO_IRQHandler,                // 36 Serial GPIO
 281:../src/cr_startup_lpc43xx-m0app.c ****     M0_SPI_OR_DAC_IRQHandler,           // 37 SPI or DAC
 282:../src/cr_startup_lpc43xx-m0app.c ****     M0_ADC1_IRQHandler,                 // 38 ADC1
 283:../src/cr_startup_lpc43xx-m0app.c ****     M0_SSP0_OR_SSP1_IRQHandler,         // 39 SSP0 or SSP1
 284:../src/cr_startup_lpc43xx-m0app.c ****     M0_EVENTROUTER_IRQHandler,          // 40 Event Router
 285:../src/cr_startup_lpc43xx-m0app.c ****     M0_USART0_IRQHandler,               // 41 USART0
 286:../src/cr_startup_lpc43xx-m0app.c ****     M0_USART2_OR_C_CAN1_IRQHandler,     // 42 USART2 or C CAN1
 287:../src/cr_startup_lpc43xx-m0app.c ****     M0_USART3_IRQHandler,               // 43 USART3
 288:../src/cr_startup_lpc43xx-m0app.c ****     M0_I2S0_OR_I2S1_OR_QEI_IRQHandler,  // 44 I2S0 or I2S1 or QEI
 289:../src/cr_startup_lpc43xx-m0app.c ****     M0_C_CAN0_IRQHandler,               // 45 C CAN0
 290:../src/cr_startup_lpc43xx-m0app.c ****     M0_SPIFI_OR_VADC_IRQHandler,        // 46
 291:../src/cr_startup_lpc43xx-m0app.c ****     M0_M0SUB_IRQHandler,                // 47 Interrupt from M0SUB
 292:../src/cr_startup_lpc43xx-m0app.c ****   };
 293:../src/cr_startup_lpc43xx-m0app.c **** #endif
 294:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 295:../src/cr_startup_lpc43xx-m0app.c **** // Functions to carry out the initialization of RW and BSS data sections. These
 296:../src/cr_startup_lpc43xx-m0app.c **** // are written as separate functions rather than being inlined within the
 297:../src/cr_startup_lpc43xx-m0app.c **** // ResetISR() function in order to cope with MCUs with multiple banks of
 298:../src/cr_startup_lpc43xx-m0app.c **** // memory.
 299:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 300:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 301:../src/cr_startup_lpc43xx-m0app.c **** void data_init(unsigned int romstart, unsigned int start, unsigned int len) {
  80              		.loc 1 301 0
  81              		.cfi_startproc
  82 0000 80B5     		push	{r7, lr}
  83              		.cfi_def_cfa_offset 8
  84              		.cfi_offset 7, -8
  85              		.cfi_offset 14, -4
  86 0002 88B0     		sub	sp, sp, #32
  87              		.cfi_def_cfa_offset 40
  88 0004 00AF     		add	r7, sp, #0
  89              		.cfi_def_cfa_register 7
  90 0006 F860     		str	r0, [r7, #12]
  91 0008 B960     		str	r1, [r7, #8]
  92 000a 7A60     		str	r2, [r7, #4]
 302:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int *pulDest = (unsigned int*) start;
  93              		.loc 1 302 0
  94 000c BB68     		ldr	r3, [r7, #8]
  95 000e FB61     		str	r3, [r7, #28]
 303:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int *pulSrc = (unsigned int*) romstart;
  96              		.loc 1 303 0
  97 0010 FB68     		ldr	r3, [r7, #12]
  98 0012 BB61     		str	r3, [r7, #24]
 304:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int loop;
 305:../src/cr_startup_lpc43xx-m0app.c ****   for (loop = 0; loop < len; loop = loop + 4)
  99              		.loc 1 305 0
 100 0014 0023     		mov	r3, #0
 101 0016 7B61     		str	r3, [r7, #20]
 102 0018 0AE0     		b	.L2
 103              	.L3:
 306:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = *pulSrc++;
 104              		.loc 1 306 0 discriminator 3
 105 001a FB69     		ldr	r3, [r7, #28]
 106 001c 1A1D     		add	r2, r3, #4
 107 001e FA61     		str	r2, [r7, #28]
 108 0020 BA69     		ldr	r2, [r7, #24]
 109 0022 111D     		add	r1, r2, #4
 110 0024 B961     		str	r1, [r7, #24]
 111 0026 1268     		ldr	r2, [r2]
 112 0028 1A60     		str	r2, [r3]
 305:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = *pulSrc++;
 113              		.loc 1 305 0 discriminator 3
 114 002a 7B69     		ldr	r3, [r7, #20]
 115 002c 0433     		add	r3, r3, #4
 116 002e 7B61     		str	r3, [r7, #20]
 117              	.L2:
 305:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = *pulSrc++;
 118              		.loc 1 305 0 is_stmt 0 discriminator 1
 119 0030 7A69     		ldr	r2, [r7, #20]
 120 0032 7B68     		ldr	r3, [r7, #4]
 121 0034 9A42     		cmp	r2, r3
 122 0036 F0D3     		bcc	.L3
 307:../src/cr_startup_lpc43xx-m0app.c **** }
 123              		.loc 1 307 0 is_stmt 1
 124 0038 BD46     		mov	sp, r7
 125 003a 08B0     		add	sp, sp, #32
 126              		@ sp needed
 127 003c 80BD     		pop	{r7, pc}
 128              		.cfi_endproc
 129              	.LFE32:
 131 003e C046     		.align	2
 132              		.global	bss_init
 133              		.code	16
 134              		.thumb_func
 136              	bss_init:
 137              	.LFB33:
 308:../src/cr_startup_lpc43xx-m0app.c **** 
 309:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 310:../src/cr_startup_lpc43xx-m0app.c **** void bss_init(unsigned int start, unsigned int len) {
 138              		.loc 1 310 0
 139              		.cfi_startproc
 140 0040 80B5     		push	{r7, lr}
 141              		.cfi_def_cfa_offset 8
 142              		.cfi_offset 7, -8
 143              		.cfi_offset 14, -4
 144 0042 84B0     		sub	sp, sp, #16
 145              		.cfi_def_cfa_offset 24
 146 0044 00AF     		add	r7, sp, #0
 147              		.cfi_def_cfa_register 7
 148 0046 7860     		str	r0, [r7, #4]
 149 0048 3960     		str	r1, [r7]
 311:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int *pulDest = (unsigned int*) start;
 150              		.loc 1 311 0
 151 004a 7B68     		ldr	r3, [r7, #4]
 152 004c FB60     		str	r3, [r7, #12]
 312:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int loop;
 313:../src/cr_startup_lpc43xx-m0app.c ****   for (loop = 0; loop < len; loop = loop + 4)
 153              		.loc 1 313 0
 154 004e 0023     		mov	r3, #0
 155 0050 BB60     		str	r3, [r7, #8]
 156 0052 07E0     		b	.L5
 157              	.L6:
 314:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = 0;
 158              		.loc 1 314 0 discriminator 3
 159 0054 FB68     		ldr	r3, [r7, #12]
 160 0056 1A1D     		add	r2, r3, #4
 161 0058 FA60     		str	r2, [r7, #12]
 162 005a 0022     		mov	r2, #0
 163 005c 1A60     		str	r2, [r3]
 313:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = 0;
 164              		.loc 1 313 0 discriminator 3
 165 005e BB68     		ldr	r3, [r7, #8]
 166 0060 0433     		add	r3, r3, #4
 167 0062 BB60     		str	r3, [r7, #8]
 168              	.L5:
 313:../src/cr_startup_lpc43xx-m0app.c ****     *pulDest++ = 0;
 169              		.loc 1 313 0 is_stmt 0 discriminator 1
 170 0064 BA68     		ldr	r2, [r7, #8]
 171 0066 3B68     		ldr	r3, [r7]
 172 0068 9A42     		cmp	r2, r3
 173 006a F3D3     		bcc	.L6
 315:../src/cr_startup_lpc43xx-m0app.c **** }
 174              		.loc 1 315 0 is_stmt 1
 175 006c BD46     		mov	sp, r7
 176 006e 04B0     		add	sp, sp, #16
 177              		@ sp needed
 178 0070 80BD     		pop	{r7, pc}
 179              		.cfi_endproc
 180              	.LFE33:
 182              		.section	.text.ResetISR,"ax",%progbits
 183              		.align	2
 184              		.global	ResetISR
 185              		.code	16
 186              		.thumb_func
 188              	ResetISR:
 189              	.LFB34:
 316:../src/cr_startup_lpc43xx-m0app.c **** 
 317:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 318:../src/cr_startup_lpc43xx-m0app.c **** // The following symbols are constructs generated by the linker, indicating
 319:../src/cr_startup_lpc43xx-m0app.c **** // the location of various points in the "Global Section Table". This table is
 320:../src/cr_startup_lpc43xx-m0app.c **** // created by the linker via the Code Red managed linker script mechanism. It
 321:../src/cr_startup_lpc43xx-m0app.c **** // contains the load address, execution address and length of each RW data
 322:../src/cr_startup_lpc43xx-m0app.c **** // section and the execution and length of each BSS (zero initialized) section.
 323:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 324:../src/cr_startup_lpc43xx-m0app.c **** extern unsigned int __data_section_table;
 325:../src/cr_startup_lpc43xx-m0app.c **** extern unsigned int __data_section_table_end;
 326:../src/cr_startup_lpc43xx-m0app.c **** extern unsigned int __bss_section_table;
 327:../src/cr_startup_lpc43xx-m0app.c **** extern unsigned int __bss_section_table_end;
 328:../src/cr_startup_lpc43xx-m0app.c **** 
 329:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 330:../src/cr_startup_lpc43xx-m0app.c **** // Reset entry point for your code.
 331:../src/cr_startup_lpc43xx-m0app.c **** // Sets up a simple runtime environment and initializes the C/C++
 332:../src/cr_startup_lpc43xx-m0app.c **** // library.
 333:../src/cr_startup_lpc43xx-m0app.c **** //
 334:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 335:../src/cr_startup_lpc43xx-m0app.c **** void
 336:../src/cr_startup_lpc43xx-m0app.c **** ResetISR(void) {
 190              		.loc 1 336 0
 191              		.cfi_startproc
 192 0000 80B5     		push	{r7, lr}
 193              		.cfi_def_cfa_offset 8
 194              		.cfi_offset 7, -8
 195              		.cfi_offset 14, -4
 196 0002 86B0     		sub	sp, sp, #24
 197              		.cfi_def_cfa_offset 32
 198 0004 00AF     		add	r7, sp, #0
 199              		.cfi_def_cfa_register 7
 337:../src/cr_startup_lpc43xx-m0app.c **** 
 338:../src/cr_startup_lpc43xx-m0app.c ****   // ******************************
 339:../src/cr_startup_lpc43xx-m0app.c ****   // Modify CREG->M0APPMAP so that M0 looks in correct place
 340:../src/cr_startup_lpc43xx-m0app.c ****   // for its vector table when an exception is triggered.
 341:../src/cr_startup_lpc43xx-m0app.c ****   // Note that we do not use the CMSIS register access mechanism,
 342:../src/cr_startup_lpc43xx-m0app.c ****   // as there is no guarantee that the project has been configured
 343:../src/cr_startup_lpc43xx-m0app.c ****   // to use CMSIS.
 344:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int *pCREG_M0APPMAP = (unsigned int *) 0x40043404;
 200              		.loc 1 344 0
 201 0006 1D4B     		ldr	r3, .L13
 202 0008 3B61     		str	r3, [r7, #16]
 345:../src/cr_startup_lpc43xx-m0app.c ****   // CMSIS : CREG->M0APPMAP = <address of vector table>
 346:../src/cr_startup_lpc43xx-m0app.c ****   *pCREG_M0APPMAP = (unsigned int)g_pfnVectors;
 203              		.loc 1 346 0
 204 000a 1D4A     		ldr	r2, .L13+4
 205 000c 3B69     		ldr	r3, [r7, #16]
 206 000e 1A60     		str	r2, [r3]
 347:../src/cr_startup_lpc43xx-m0app.c **** 
 348:../src/cr_startup_lpc43xx-m0app.c ****     //
 349:../src/cr_startup_lpc43xx-m0app.c ****     // Copy the data sections from flash to SRAM.
 350:../src/cr_startup_lpc43xx-m0app.c ****     //
 351:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int LoadAddr, ExeAddr, SectionLen;
 352:../src/cr_startup_lpc43xx-m0app.c ****   unsigned int *SectionTableAddr;
 353:../src/cr_startup_lpc43xx-m0app.c **** 
 354:../src/cr_startup_lpc43xx-m0app.c ****   // Load base address of Global Section Table
 355:../src/cr_startup_lpc43xx-m0app.c ****   SectionTableAddr = &__data_section_table;
 207              		.loc 1 355 0
 208 0010 1C4B     		ldr	r3, .L13+8
 209 0012 7B61     		str	r3, [r7, #20]
 356:../src/cr_startup_lpc43xx-m0app.c **** 
 357:../src/cr_startup_lpc43xx-m0app.c ****     // Copy the data sections from flash to SRAM.
 358:../src/cr_startup_lpc43xx-m0app.c ****   while (SectionTableAddr < &__data_section_table_end) {
 210              		.loc 1 358 0
 211 0014 16E0     		b	.L8
 212              	.L9:
 359:../src/cr_startup_lpc43xx-m0app.c ****     LoadAddr = *SectionTableAddr++;
 213              		.loc 1 359 0
 214 0016 7B69     		ldr	r3, [r7, #20]
 215 0018 1A1D     		add	r2, r3, #4
 216 001a 7A61     		str	r2, [r7, #20]
 217 001c 1B68     		ldr	r3, [r3]
 218 001e FB60     		str	r3, [r7, #12]
 360:../src/cr_startup_lpc43xx-m0app.c ****     ExeAddr = *SectionTableAddr++;
 219              		.loc 1 360 0
 220 0020 7B69     		ldr	r3, [r7, #20]
 221 0022 1A1D     		add	r2, r3, #4
 222 0024 7A61     		str	r2, [r7, #20]
 223 0026 1B68     		ldr	r3, [r3]
 224 0028 BB60     		str	r3, [r7, #8]
 361:../src/cr_startup_lpc43xx-m0app.c ****     SectionLen = *SectionTableAddr++;
 225              		.loc 1 361 0
 226 002a 7B69     		ldr	r3, [r7, #20]
 227 002c 1A1D     		add	r2, r3, #4
 228 002e 7A61     		str	r2, [r7, #20]
 229 0030 1B68     		ldr	r3, [r3]
 230 0032 7B60     		str	r3, [r7, #4]
 362:../src/cr_startup_lpc43xx-m0app.c ****     data_init(LoadAddr, ExeAddr, SectionLen);
 231              		.loc 1 362 0
 232 0034 F968     		ldr	r1, [r7, #12]
 233 0036 BA68     		ldr	r2, [r7, #8]
 234 0038 7B68     		ldr	r3, [r7, #4]
 235 003a 081C     		mov	r0, r1
 236 003c 111C     		mov	r1, r2
 237 003e 1A1C     		mov	r2, r3
 238 0040 FFF7FEFF 		bl	data_init
 239              	.L8:
 358:../src/cr_startup_lpc43xx-m0app.c ****     LoadAddr = *SectionTableAddr++;
 240              		.loc 1 358 0
 241 0044 7A69     		ldr	r2, [r7, #20]
 242 0046 104B     		ldr	r3, .L13+12
 243 0048 9A42     		cmp	r2, r3
 244 004a E4D3     		bcc	.L9
 363:../src/cr_startup_lpc43xx-m0app.c ****   }
 364:../src/cr_startup_lpc43xx-m0app.c ****   // At this point, SectionTableAddr = &__bss_section_table;
 365:../src/cr_startup_lpc43xx-m0app.c ****   // Zero fill the bss segment
 366:../src/cr_startup_lpc43xx-m0app.c ****   while (SectionTableAddr < &__bss_section_table_end) {
 245              		.loc 1 366 0
 246 004c 0FE0     		b	.L10
 247              	.L11:
 367:../src/cr_startup_lpc43xx-m0app.c ****     ExeAddr = *SectionTableAddr++;
 248              		.loc 1 367 0
 249 004e 7B69     		ldr	r3, [r7, #20]
 250 0050 1A1D     		add	r2, r3, #4
 251 0052 7A61     		str	r2, [r7, #20]
 252 0054 1B68     		ldr	r3, [r3]
 253 0056 BB60     		str	r3, [r7, #8]
 368:../src/cr_startup_lpc43xx-m0app.c ****     SectionLen = *SectionTableAddr++;
 254              		.loc 1 368 0
 255 0058 7B69     		ldr	r3, [r7, #20]
 256 005a 1A1D     		add	r2, r3, #4
 257 005c 7A61     		str	r2, [r7, #20]
 258 005e 1B68     		ldr	r3, [r3]
 259 0060 7B60     		str	r3, [r7, #4]
 369:../src/cr_startup_lpc43xx-m0app.c ****     bss_init(ExeAddr, SectionLen);
 260              		.loc 1 369 0
 261 0062 BA68     		ldr	r2, [r7, #8]
 262 0064 7B68     		ldr	r3, [r7, #4]
 263 0066 101C     		mov	r0, r2
 264 0068 191C     		mov	r1, r3
 265 006a FFF7FEFF 		bl	bss_init
 266              	.L10:
 366:../src/cr_startup_lpc43xx-m0app.c ****     ExeAddr = *SectionTableAddr++;
 267              		.loc 1 366 0
 268 006e 7A69     		ldr	r2, [r7, #20]
 269 0070 064B     		ldr	r3, .L13+16
 270 0072 9A42     		cmp	r2, r3
 271 0074 EBD3     		bcc	.L11
 370:../src/cr_startup_lpc43xx-m0app.c ****   }
 371:../src/cr_startup_lpc43xx-m0app.c **** 
 372:../src/cr_startup_lpc43xx-m0app.c **** // **********************************************************
 373:../src/cr_startup_lpc43xx-m0app.c **** // No need to call SystemInit() here, as master CM4 cpu will
 374:../src/cr_startup_lpc43xx-m0app.c **** // have done the main system set up before enabling CM0.
 375:../src/cr_startup_lpc43xx-m0app.c **** // **********************************************************
 376:../src/cr_startup_lpc43xx-m0app.c **** 
 377:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__cplusplus)
 378:../src/cr_startup_lpc43xx-m0app.c ****   //
 379:../src/cr_startup_lpc43xx-m0app.c ****   // Call C++ library initialisation
 380:../src/cr_startup_lpc43xx-m0app.c ****   //
 381:../src/cr_startup_lpc43xx-m0app.c ****   __libc_init_array();
 382:../src/cr_startup_lpc43xx-m0app.c **** #endif
 383:../src/cr_startup_lpc43xx-m0app.c **** 
 384:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__REDLIB__)
 385:../src/cr_startup_lpc43xx-m0app.c ****   // Call the Redlib library, which in turn calls main()
 386:../src/cr_startup_lpc43xx-m0app.c ****   __main() ;
 272              		.loc 1 386 0
 273 0076 FFF7FEFF 		bl	__main
 274              	.L12:
 387:../src/cr_startup_lpc43xx-m0app.c **** #else
 388:../src/cr_startup_lpc43xx-m0app.c ****   main();
 389:../src/cr_startup_lpc43xx-m0app.c **** #endif
 390:../src/cr_startup_lpc43xx-m0app.c **** 
 391:../src/cr_startup_lpc43xx-m0app.c ****   //
 392:../src/cr_startup_lpc43xx-m0app.c ****   // main() shouldn't return, but if it does, we'll just enter an infinite loop 
 393:../src/cr_startup_lpc43xx-m0app.c ****   //
 394:../src/cr_startup_lpc43xx-m0app.c ****   while (1) {
 395:../src/cr_startup_lpc43xx-m0app.c ****     ;
 396:../src/cr_startup_lpc43xx-m0app.c ****   }
 275              		.loc 1 396 0 discriminator 1
 276 007a FEE7     		b	.L12
 277              	.L14:
 278              		.align	2
 279              	.L13:
 280 007c 04340440 		.word	1074017284
 281 0080 00000000 		.word	g_pfnVectors
 282 0084 00000000 		.word	__data_section_table
 283 0088 00000000 		.word	__data_section_table_end
 284 008c 00000000 		.word	__bss_section_table_end
 285              		.cfi_endproc
 286              	.LFE34:
 288              		.section	.after_vectors
 289 0072 C046     		.align	2
 290              		.weak	M0_NMI_Handler
 291              		.code	16
 292              		.thumb_func
 294              	M0_NMI_Handler:
 295              	.LFB35:
 397:../src/cr_startup_lpc43xx-m0app.c **** }
 398:../src/cr_startup_lpc43xx-m0app.c **** 
 399:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 400:../src/cr_startup_lpc43xx-m0app.c **** // Default exception handlers. Override the ones here by defining your own
 401:../src/cr_startup_lpc43xx-m0app.c **** // handler routines in your application code.
 402:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 403:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 404:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 405:../src/cr_startup_lpc43xx-m0app.c **** void NMI_Handler(void)
 406:../src/cr_startup_lpc43xx-m0app.c **** #else
 407:../src/cr_startup_lpc43xx-m0app.c **** void M0_NMI_Handler(void)
 408:../src/cr_startup_lpc43xx-m0app.c **** #endif
 409:../src/cr_startup_lpc43xx-m0app.c **** {   while(1) { }
 296              		.loc 1 409 0
 297              		.cfi_startproc
 298 0074 80B5     		push	{r7, lr}
 299              		.cfi_def_cfa_offset 8
 300              		.cfi_offset 7, -8
 301              		.cfi_offset 14, -4
 302 0076 00AF     		add	r7, sp, #0
 303              		.cfi_def_cfa_register 7
 304              	.L16:
 305              		.loc 1 409 0 discriminator 1
 306 0078 FEE7     		b	.L16
 307              		.cfi_endproc
 308              	.LFE35:
 310              		.section	.rodata
 311              		.align	2
 312              	.LC4:
 313 0000 48617264 		.ascii	"HardFault\012\000"
 313      4661756C 
 313      740A00
 314 000b 00       		.section	.after_vectors
 315 007a C046     		.align	2
 316              		.weak	M0_HardFault_Handler
 317              		.code	16
 318              		.thumb_func
 320              	M0_HardFault_Handler:
 321              	.LFB36:
 410:../src/cr_startup_lpc43xx-m0app.c **** }
 411:../src/cr_startup_lpc43xx-m0app.c **** 
 412:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 413:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 414:../src/cr_startup_lpc43xx-m0app.c **** void HardFault_Handler(void)
 415:../src/cr_startup_lpc43xx-m0app.c **** #else
 416:../src/cr_startup_lpc43xx-m0app.c **** void M0_HardFault_Handler(void)
 417:../src/cr_startup_lpc43xx-m0app.c **** #endif
 418:../src/cr_startup_lpc43xx-m0app.c **** {
 322              		.loc 1 418 0
 323              		.cfi_startproc
 324 007c 80B5     		push	{r7, lr}
 325              		.cfi_def_cfa_offset 8
 326              		.cfi_offset 7, -8
 327              		.cfi_offset 14, -4
 328 007e 00AF     		add	r7, sp, #0
 329              		.cfi_def_cfa_register 7
 419:../src/cr_startup_lpc43xx-m0app.c **** 	_DBG("HardFault\n");
 330              		.loc 1 419 0
 331 0080 034A     		ldr	r2, .L19
 332 0082 044B     		ldr	r3, .L19+4
 333 0084 101C     		mov	r0, r2
 334 0086 191C     		mov	r1, r3
 335 0088 FFF7FEFF 		bl	UARTPuts
 336              	.L18:
 420:../src/cr_startup_lpc43xx-m0app.c **** 	while(1) { }
 337              		.loc 1 420 0 discriminator 1
 338 008c FEE7     		b	.L18
 339              	.L20:
 340 008e C046     		.align	2
 341              	.L19:
 342 0090 00200840 		.word	1074274304
 343 0094 00000000 		.word	.LC4
 344              		.cfi_endproc
 345              	.LFE36:
 347              		.align	2
 348              		.weak	M0_SVC_Handler
 349              		.code	16
 350              		.thumb_func
 352              	M0_SVC_Handler:
 353              	.LFB37:
 421:../src/cr_startup_lpc43xx-m0app.c **** }
 422:../src/cr_startup_lpc43xx-m0app.c **** 
 423:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 424:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 425:../src/cr_startup_lpc43xx-m0app.c **** void SVC_Handler(void)
 426:../src/cr_startup_lpc43xx-m0app.c **** #else
 427:../src/cr_startup_lpc43xx-m0app.c **** void M0_SVC_Handler(void)
 428:../src/cr_startup_lpc43xx-m0app.c **** #endif
 429:../src/cr_startup_lpc43xx-m0app.c **** {   while(1) { }
 354              		.loc 1 429 0
 355              		.cfi_startproc
 356 0098 80B5     		push	{r7, lr}
 357              		.cfi_def_cfa_offset 8
 358              		.cfi_offset 7, -8
 359              		.cfi_offset 14, -4
 360 009a 00AF     		add	r7, sp, #0
 361              		.cfi_def_cfa_register 7
 362              	.L22:
 363              		.loc 1 429 0 discriminator 1
 364 009c FEE7     		b	.L22
 365              		.cfi_endproc
 366              	.LFE37:
 368 009e C046     		.align	2
 369              		.weak	M0_PendSV_Handler
 370              		.code	16
 371              		.thumb_func
 373              	M0_PendSV_Handler:
 374              	.LFB38:
 430:../src/cr_startup_lpc43xx-m0app.c **** }
 431:../src/cr_startup_lpc43xx-m0app.c **** 
 432:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 433:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 434:../src/cr_startup_lpc43xx-m0app.c **** void PendSV_Handler(void)
 435:../src/cr_startup_lpc43xx-m0app.c **** #else
 436:../src/cr_startup_lpc43xx-m0app.c **** void M0_PendSV_Handler(void)
 437:../src/cr_startup_lpc43xx-m0app.c **** #endif
 438:../src/cr_startup_lpc43xx-m0app.c **** {   while(1) { }
 375              		.loc 1 438 0
 376              		.cfi_startproc
 377 00a0 80B5     		push	{r7, lr}
 378              		.cfi_def_cfa_offset 8
 379              		.cfi_offset 7, -8
 380              		.cfi_offset 14, -4
 381 00a2 00AF     		add	r7, sp, #0
 382              		.cfi_def_cfa_register 7
 383              	.L24:
 384              		.loc 1 438 0 discriminator 1
 385 00a4 FEE7     		b	.L24
 386              		.cfi_endproc
 387              	.LFE38:
 389 00a6 C046     		.align	2
 390              		.weak	M0_SysTick_Handler
 391              		.code	16
 392              		.thumb_func
 394              	M0_SysTick_Handler:
 395              	.LFB39:
 439:../src/cr_startup_lpc43xx-m0app.c **** }
 440:../src/cr_startup_lpc43xx-m0app.c **** 
 441:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 442:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 443:../src/cr_startup_lpc43xx-m0app.c **** void SysTick_Handler(void)
 444:../src/cr_startup_lpc43xx-m0app.c **** #else
 445:../src/cr_startup_lpc43xx-m0app.c **** void M0_SysTick_Handler(void)
 446:../src/cr_startup_lpc43xx-m0app.c **** #endif
 447:../src/cr_startup_lpc43xx-m0app.c **** {   while(1) { }
 396              		.loc 1 447 0
 397              		.cfi_startproc
 398 00a8 80B5     		push	{r7, lr}
 399              		.cfi_def_cfa_offset 8
 400              		.cfi_offset 7, -8
 401              		.cfi_offset 14, -4
 402 00aa 00AF     		add	r7, sp, #0
 403              		.cfi_def_cfa_register 7
 404              	.L26:
 405              		.loc 1 447 0 discriminator 1
 406 00ac FEE7     		b	.L26
 407              		.cfi_endproc
 408              	.LFE39:
 410 00ae C046     		.align	2
 411              		.weak	M0_IntDefaultHandler
 412              		.code	16
 413              		.thumb_func
 415              	M0_IntDefaultHandler:
 416              	.LFB40:
 448:../src/cr_startup_lpc43xx-m0app.c **** }
 449:../src/cr_startup_lpc43xx-m0app.c **** 
 450:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 451:../src/cr_startup_lpc43xx-m0app.c **** //
 452:../src/cr_startup_lpc43xx-m0app.c **** // Processor ends up here if an unexpected interrupt occurs or a specific
 453:../src/cr_startup_lpc43xx-m0app.c **** // handler is not present in the application code.
 454:../src/cr_startup_lpc43xx-m0app.c **** //
 455:../src/cr_startup_lpc43xx-m0app.c **** //*****************************************************************************
 456:../src/cr_startup_lpc43xx-m0app.c **** __attribute__ ((section(".after_vectors")))
 457:../src/cr_startup_lpc43xx-m0app.c **** #if defined (__USE_LPCOPEN)
 458:../src/cr_startup_lpc43xx-m0app.c **** void IntDefaultHandler(void)
 459:../src/cr_startup_lpc43xx-m0app.c **** #else
 460:../src/cr_startup_lpc43xx-m0app.c **** void M0_IntDefaultHandler(void)
 461:../src/cr_startup_lpc43xx-m0app.c **** #endif
 462:../src/cr_startup_lpc43xx-m0app.c **** {   while(1) { }
 417              		.loc 1 462 0
 418              		.cfi_startproc
 419 00b0 80B5     		push	{r7, lr}
 420              		.cfi_def_cfa_offset 8
 421              		.cfi_offset 7, -8
 422              		.cfi_offset 14, -4
 423 00b2 00AF     		add	r7, sp, #0
 424              		.cfi_def_cfa_register 7
 425              	.L28:
 426              		.loc 1 462 0 discriminator 1
 427 00b4 FEE7     		b	.L28
 428              		.cfi_endproc
 429              	.LFE40:
 431              		.weak	M0_RTC_IRQHandler
 432              		.thumb_set M0_RTC_IRQHandler,M0_IntDefaultHandler
 433              		.weak	M0_M4CORE_IRQHandler
 434              		.thumb_set M0_M4CORE_IRQHandler,M0_IntDefaultHandler
 435              		.weak	M0_DMA_IRQHandler
 436              		.thumb_set M0_DMA_IRQHandler,M0_IntDefaultHandler
 437              		.weak	M0_ETH_IRQHandler
 438              		.thumb_set M0_ETH_IRQHandler,M0_IntDefaultHandler
 439              		.weak	M0_SDIO_IRQHandler
 440              		.thumb_set M0_SDIO_IRQHandler,M0_IntDefaultHandler
 441              		.weak	M0_LCD_IRQHandler
 442              		.thumb_set M0_LCD_IRQHandler,M0_IntDefaultHandler
 443              		.weak	M0_USB0_IRQHandler
 444              		.thumb_set M0_USB0_IRQHandler,M0_IntDefaultHandler
 445              		.weak	M0_USB1_IRQHandler
 446              		.thumb_set M0_USB1_IRQHandler,M0_IntDefaultHandler
 447              		.weak	M0_SCT_IRQHandler
 448              		.thumb_set M0_SCT_IRQHandler,M0_IntDefaultHandler
 449              		.weak	M0_RIT_OR_WWDT_IRQHandler
 450              		.thumb_set M0_RIT_OR_WWDT_IRQHandler,M0_IntDefaultHandler
 451              		.weak	M0_TIMER0_IRQHandler
 452              		.thumb_set M0_TIMER0_IRQHandler,M0_IntDefaultHandler
 453              		.weak	M0_GINT1_IRQHandler
 454              		.thumb_set M0_GINT1_IRQHandler,M0_IntDefaultHandler
 455              		.weak	M0_TIMER3_IRQHandler
 456              		.thumb_set M0_TIMER3_IRQHandler,M0_IntDefaultHandler
 457              		.weak	M0_MCPWM_IRQHandler
 458              		.thumb_set M0_MCPWM_IRQHandler,M0_IntDefaultHandler
 459              		.weak	M0_ADC0_IRQHandler
 460              		.thumb_set M0_ADC0_IRQHandler,M0_IntDefaultHandler
 461              		.weak	M0_I2C0_OR_I2C1_IRQHandler
 462              		.thumb_set M0_I2C0_OR_I2C1_IRQHandler,M0_IntDefaultHandler
 463              		.weak	M0_SGPIO_IRQHandler
 464              		.thumb_set M0_SGPIO_IRQHandler,M0_IntDefaultHandler
 465              		.weak	M0_SPI_OR_DAC_IRQHandler
 466              		.thumb_set M0_SPI_OR_DAC_IRQHandler,M0_IntDefaultHandler
 467              		.weak	M0_ADC1_IRQHandler
 468              		.thumb_set M0_ADC1_IRQHandler,M0_IntDefaultHandler
 469              		.weak	M0_SSP0_OR_SSP1_IRQHandler
 470              		.thumb_set M0_SSP0_OR_SSP1_IRQHandler,M0_IntDefaultHandler
 471              		.weak	M0_EVENTROUTER_IRQHandler
 472              		.thumb_set M0_EVENTROUTER_IRQHandler,M0_IntDefaultHandler
 473              		.weak	M0_USART0_IRQHandler
 474              		.thumb_set M0_USART0_IRQHandler,M0_IntDefaultHandler
 475              		.weak	M0_USART2_OR_C_CAN1_IRQHandler
 476              		.thumb_set M0_USART2_OR_C_CAN1_IRQHandler,M0_IntDefaultHandler
 477              		.weak	M0_USART3_IRQHandler
 478              		.thumb_set M0_USART3_IRQHandler,M0_IntDefaultHandler
 479              		.weak	M0_I2S0_OR_I2S1_OR_QEI_IRQHandler
 480              		.thumb_set M0_I2S0_OR_I2S1_OR_QEI_IRQHandler,M0_IntDefaultHandler
 481              		.weak	M0_C_CAN0_IRQHandler
 482              		.thumb_set M0_C_CAN0_IRQHandler,M0_IntDefaultHandler
 483              		.weak	M0_SPIFI_OR_VADC_IRQHandler
 484              		.thumb_set M0_SPIFI_OR_VADC_IRQHandler,M0_IntDefaultHandler
 485              		.weak	M0_M0SUB_IRQHandler
 486              		.thumb_set M0_M0SUB_IRQHandler,M0_IntDefaultHandler
 487 00b6 C046     		.text
 488              	.Letext0:
 489              		.file 2 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\machine\\_defau
 490              		.file 3 "c:\\nxp\\lpcxpresso_7.6.2_326\\lpcxpresso\\tools\\arm-none-eabi\\include\\stdint.h"
 491              		.file 4 "C:\\Users\\ouroborus\\Dropbox\\Bacheloroppgave 2015\\Utvikling og Kode\\Pixy_3_3_15\\gcc\
DEFINED SYMBOLS
                            *ABS*:00000000 cr_startup_lpc43xx-m0app.c
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:22     .isr_vector:00000000 g_pfnVectors
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:19     .isr_vector:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:188    .text.ResetISR:00000000 ResetISR
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:294    .after_vectors:00000074 M0_NMI_Handler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:320    .after_vectors:0000007c M0_HardFault_Handler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:352    .after_vectors:00000098 M0_SVC_Handler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:373    .after_vectors:000000a0 M0_PendSV_Handler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:394    .after_vectors:000000a8 M0_SysTick_Handler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_RTC_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_M4CORE_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_DMA_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_ETH_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SDIO_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_LCD_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_USB0_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_USB1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SCT_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_RIT_OR_WWDT_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_TIMER0_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_GINT1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_TIMER3_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_MCPWM_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_ADC0_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_I2C0_OR_I2C1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SGPIO_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SPI_OR_DAC_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_ADC1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SSP0_OR_SSP1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_EVENTROUTER_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_USART0_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_USART2_OR_C_CAN1_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_USART3_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_I2S0_OR_I2S1_OR_QEI_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_C_CAN0_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_SPIFI_OR_VADC_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_M0SUB_IRQHandler
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:72     .after_vectors:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:77     .after_vectors:00000000 data_init
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:136    .after_vectors:00000040 bss_init
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:183    .text.ResetISR:00000000 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:280    .text.ResetISR:0000007c $d
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:311    .rodata:00000000 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:342    .after_vectors:00000090 $d
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:347    .after_vectors:00000098 $t
C:\Users\OUROBO~1\AppData\Local\Temp\cclpyF6h.s:415    .after_vectors:000000b0 M0_IntDefaultHandler
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
_vStackTop
__main
__data_section_table
__data_section_table_end
__bss_section_table_end
UARTPuts
