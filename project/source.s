;;;;;; An ARM Based VGA controller
; https://github.com/7andahalf/ARM_class/tree/master/project

;;;;;;;;;;;;;;;; Constants

; Reg address
RCC_BASE EQU 0x40023800
RCC_CR EQU RCC_BASE
RCC_CFGR EQU RCC_BASE + 0x08
RCC_PLLCFGR EQU RCC_BASE + 0x04
RCC_AHB1ENR EQU RCC_BASE + 0x30
RCC_APB1ENR EQU RCC_BASE + 0x40
RCC_CIR EQU RCC_BASE + 0x0C
PWR_BASE EQU 0x40007000
PWR_CR EQU PWR_BASE
FLASH_BASE EQU 0x40023C00
FLASH_ACR EQU FLASH_BASE
GPIOD_BASE EQU 0x40020C00
GPIOD_MODER EQU GPIOD_BASE
GPIOD_ODR EQU GPIOD_BASE + 0x14
GPIOD_OTYPER EQU 0x40020C04
GPIOD_OSPEEDR EQU 0x40020C08
GPIOD_PUPDR EQU	0x40020C0C
TIM2_BASE EQU 0x40000000 
TIM2_ARR EQU TIM2_BASE + 0x2C
TIM2_CR1 EQU TIM2_BASE
TIM2_DIER EQU TIM2_BASE + 0x0C
TIM2_PSC EQU TIM2_BASE + 0x28
TIM2_SR EQU TIM2_BASE + 0x10
TIM2_EGR EQU TIM2_BASE + 0x14
TIM2_CTR EQU TIM2_BASE + 0x24
NVIC_ISER0 EQU 0xE000E100
	
; bit locations
GPIODEN EQU 1 << 3
MODER12_OUT EQU 1 << 24
LED_GREEN EQU 1 << 12
PLLON EQU 1 << 24
PLLRDY EQU 1 << 25
PLLSRC EQU 1 << 22
HSION EQU 1
HSEBYP EQU 1 << 18
HSEON EQU 1 << 16
HSERDY EQU 1 << 17
CSSON EQU 1 << 19
PWREN EQU 1 << 28
VOS EQU 1 << 14
SW0 EQU 1
SW1 EQU 1 << 1
SWS0 EQU 1 << 2
SWS1 EQU 1 << 3             
PLL_M EQU 8
PLL_N EQU 336
PLL_P EQU 2
PLL_Q EQU 7
DELAY EQU 0x5F
ACR_LATENCY_5WS EQU 5 
RCC_PLLCFGR_PLLP EQU ~(0x3 << 16)
RCC_PLLCFGR_PLLM EQU ~0x3F
RCC_PLLCFGR_PLLN EQU ~(0x1FF << 6)
RCC_CFGR_HPRE_DIV1 EQU 0xF << 4
RCC_CFGR_PPRE2_DIV2 EQU 0x8000 
RCC_CFGR_PPRE1_DIV4 EQU 0x1400
RCC_CFGR_SW EQU 3
RCC_CFGR_SWS EQU 3 << 2
NVIC_TIM2EN EQU 1 << 28
CEN EQU 1
UIE EQU 1
UIF EQU 1
UG EQU 1

	EXPORT SystemInit
	EXPORT __main
	EXPORT TIM2_IRQHandler
	AREA	MYCODE, CODE, READONLY


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BITMAP IMAGES
;;; Mario
image DCD 0,0,0,0,0,64512,64512,64512,64512,64512,0,0,0,0,0,0,0,0,0,0,64512,64512,64512,64512,64512,64512,64512,64512,64512,0,0,0,0,0,0,0,12288,12288,12288,61440,61440,12288,61440,0,0,0,0,0,0,0,0,12288,61440,12288,61440,61440,61440,12288,61440,61440,61440,0,0,0,0,0,0,12288,61440,12288,12288,61440,61440,61440,12288,61440,61440,61440,0,0,0,0,0,12288,12288,61440,61440,61440,61440,12288,12288,12288,12288,0,0,0,0,0,0,0,0,61440,61440,61440,61440,61440,61440,61440,0,0,0,0,0,0,0,0,12288,12288,64512,12288,12288,12288,0,0,0,0,0,0,0,0,0,12288,12288,12288,64512,12288,12288,64512,12288,12288,12288,0,0,0,0,0,12288,12288,12288,12288,64512,64512,64512,64512,12288,12288,12288,12288,0,0,0,0,61440,61440,12288,64512,61440,64512,64512,61440,64512,12288,61440,61440,0,0,0,0,61440,61440,61440,64512,64512,64512,64512,64512,64512,61440,61440,61440,0,0,0,0,61440,61440,64512,64512,64512,64512,64512,64512,64512,64512,61440,61440,0,0,0,0,0,0,64512,64512,64512,0,0,64512,64512,64512,0,0,0,0,0,0,0,12288,12288,12288,0,0,0,0,12288,12288,12288,0,0,0,0,0,12288,12288,12288,12288,0,0,0,0,12288,12288,12288,12288,0,0,0,0,0,0,0,64512,64512,64512,64512,64512,0,0,0,0,0,0,0,0,0,0,64512,64512,64512,64512,64512,64512,64512,64512,64512,0,0,0,0,0,0,0,12288,12288,12288,61440,61440,12288,61440,0,0,0,0,0,0,0,0,12288,61440,12288,61440,61440,61440,12288,61440,61440,61440,0,0,0,0,0,0,12288,61440,12288,12288,61440,61440,61440,12288,61440,61440,61440,0,0,0,0,0,12288,12288,61440,61440,61440,61440,12288,12288,12288,12288,0,0,0,0,0,0,0,0,61440,61440,61440,61440,61440,61440,61440,0,0,0,0,0,0,0,0,12288,12288,64512,12288,12288,12288,0,0,0,0,0,0,0,0,0,12288,12288,12288,64512,12288,12288,64512,12288,12288,12288,0,0,0,0,0,12288,12288,12288,12288,64512,64512,64512,64512,12288,12288,12288,12288,0,0,0,0,61440,61440,12288,64512,61440,64512,64512,61440,64512,12288,61440,61440,0,0,0,0,61440,61440,61440,64512,64512,64512,64512,64512,64512,61440,61440,61440,0,0,0,0,61440,61440,64512,64512,64512,64512,64512,64512,64512,64512,61440,61440,0,0,0,0,0,0,64512,64512,64512,0,0,64512,64512,64512,0,0,0,0,0,0,0,12288,12288,12288,0,0,0,0,12288,12288,12288,0,0,0,0,0,12288,12288,12288,12288,0,0,0,0,12288,12288,12288,12288,0,0

;; Colors
;image DCD 0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512,0,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240,11264,12288,13312,14336,15360,16384,17408,18432,19456,20480,21504,22528,23552,24576,25600,26624,27648,28672,29696,30720,31744,32768,33792,34816,35840,36864,37888,38912,39936,40960,41984,43008,44032,45056,46080,47104,48128,49152,50176,51200,52224,53248,54272,55296,56320,57344,58368,59392,60416,61440,62464,63488,64512


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SYSTEM INIT
SystemInit FUNCTION
	
	PUSH {lr}
	
	;;;;;;;;;;; Clock configuration
	; Reset HSION
    LDR         r0, =RCC_CR
    MOV         r1, #HSION
    STR         r1, [r0]
	
	; Reset RCC_CFGR
    LDR         r0, =RCC_CFGR
    MOV         r1, #0
    STR         r1, [r0]
	
	; clear HSEON, CSSON, PLLON
    LDR         r0, =RCC_CR
    LDR         r1, [r0]
    LDR         r2, =HSEON | CSSON | PLLON
    BIC         r1, r2
    STR         r1, [r0]
	
	; Reset RCC_PLLCFGR
    LDR         r0, =RCC_PLLCFGR 
    LDR         r1, =0x24003010
    STR         r1, [r0]
	
	; Reset HSEBYP
    LDR         r0, =RCC_CR 
    LDR         r1, [r0]
    BIC         r1, #HSEBYP
    STR         r1, [r0]
	
	; Disable interrupts
    LDR         r0, =RCC_CIR
    MOV         r1, #0
    STR         r1, [r0]
    
	; Enable HSE
	LDR         r0, =RCC_CR
    LDR         r1, [r0]
    ORR         r1, #HSEON
    STR         r1, [r0]
	
w1	; Wait for HSE
    LDR         r1, [r0]
    ANDS        r1, #HSERDY
    BEQ         w1
	
	; Select mode 1 in power
    LDR         r0, =RCC_APB1ENR
    LDR         r1, [r0]
    ORR         r1, #PWREN
	ORR         r1, #1
    STR         r1, [r0]
	
    LDR         r0, =PWR_CR
    LDR         r1, [r0]
    ORR         r1, #VOS
    STR         r1, [r0]
	
	; peripheral clk prescale
    LDR         r0, =RCC_CFGR
    LDR         r1, [r0]
    BIC         r1, #RCC_CFGR_HPRE_DIV1
    ORR         r1, #RCC_CFGR_PPRE2_DIV2
    ORR         r1, #RCC_CFGR_PPRE1_DIV4
    STR         r1, [r0]
	
	; PLL config
    LDR         r0, =RCC_PLLCFGR
    LDR         r1, [r0]
    LDR         r2, =PLL_M | PLL_N << 6 | ((PLL_P >> 1) - 1) << 16 | PLLSRC | PLL_Q << 24
    ORR         r1, r2
    STR         r1, [r0]
	
	; Enable PLL
    LDR         r0, =RCC_CR
    LDR         r1, [r0]
    ORR         r1, #PLLON
    STR         r1, [r0]
	
	; Wait for PLL
w2
    LDR         r1, [r0]
    ANDS        r1, #PLLRDY 
    BEQ         w2
	
	; Flash latency to 5
    LDR         r0, =FLASH_ACR
    LDR         r1, [r0]
    LDR         r2, =ACR_LATENCY_5WS
    ORR         r1, r2
    STR         r1, [r0]
	
	; Select PLL as source
    LDR         r0, =RCC_CFGR
    LDR         r1, [r0]
    ORR         r1, #SW1
    STR         r1, [r0]
	
w3
    LDR         r1, [r0]
    AND         r1, #RCC_CFGR_SWS
    CMP         r1, #SWS1 
    BNE         w3

	;;;;;;;;;;; GPIO configuration
	
	; Enable GPIO clock
	LDR			R1, =RCC_AHB1ENR
	LDR			R0, [R1]
	ORR.W 		R0, #0x08
	STR			R0, [R1]

	; Set mode as output
	LDR			R1, =GPIOD_MODER
	LDR			R0, [R1]			
	ORR.W 		R0, #0x00550000
	AND.W		R0, #0xFF55FFFF
	STR			R0, [R1]

	; Set type as push-pull
	LDR			R1, =GPIOD_OTYPER
	LDR			R0, [R1]
	AND.W 		R0, #0xFFFFF0FF	
	STR			R0, [R1]
	
	; Set Speed slow
	LDR			R1, =GPIOD_OSPEEDR
	LDR			R0, [R1]
	ORR.W		R0, #0x00FF0000
	STR			R0, [R1]	
	
	; Set pull-up
	LDR			R1, =GPIOD_PUPDR
	LDR			R0, [R1]
	AND.W		R0, #0xFF00FFFF
	STR			R0, [R1]

	; Set mode as output
	LDR			R1, =GPIOD_MODER
	LDR			R0, [R1]			
	ORR.W 		R0, #0x55000000
	AND.W		R0, #0x55FFFFFF
	STR			R0, [R1]

	; Set type as push-pull
	LDR			R1, =GPIOD_OTYPER
	LDR			R0, [R1]
	AND.W 		R0, #0xFFFF0FFF	
	STR			R0, [R1]
	
	; Set Speed slow
	LDR			R1, =GPIOD_OSPEEDR
	LDR			R0, [R1]
	ORR.W		R0, #0xFF000000
	STR			R0, [R1]	
	
	; Set pull-up
	LDR			R1, =GPIOD_PUPDR
	LDR			R0, [R1]
	AND.W		R0, #0x00FFFFFF
	STR			R0, [R1]


	;;;;;;;;;;;;;;;;;; Init timer
	
	; Count value
	LDR         r0, =TIM2_ARR
    MOVW        r1, #603
    STR         r1, [r0]
    
	; enable intr
    LDR         r0, =TIM2_DIER
    LDR         r1, [r0]
    ORR         r1, #UIE 
    STR         r1, [r0]

	; clock presc = 0
    LDR         r0, =TIM2_PSC
    MOVW        r1, #0
    STR         r1, [r0]
	
	; update
    LDR         r0, =TIM2_EGR
    LDR         r1, [r0]
    ORR         r1, #UG
    STR         r1, [r0]
	
	; enable counter
    LDR         r0, =TIM2_CR1
    LDR         r1, [r0]
    ORR         r1, #CEN
    STR         r1, [r0]
	
	; enabe interrupt
	LDR         r0, =NVIC_ISER0 
    LDR         r1, [r0]
    ORR         r1, #NVIC_TIM2EN
    STR         r1, [r0]
	
	POP 		{lr}
	BX			LR
	
	ENDFUNC
	

__main FUNCTION
		MOV r11, #0			;H pos
		MOV r12, #0			;V pos
		LDR r6, =image		;Image pos
		
beloop	LDR r5, =hloop
		LDR		R1, =GPIOD_ODR
		
hloop	; Dump pixel value
		LDR		R0, [r6]
		ADD		r6, r6, #4
		STR		R0, [R1]
		
		; Loop until line is over
		BX	r5

hreset	BL cr_f				; Reset all colors

		MOV r10, #0
		MOV r11, #0

		; Check if 1024 lines are done
		ADD	r12, r12, #1
		CMP r12, #1024
		BGE vloope
		
		; Generate sync pulse
		bl hp
		
		; housekeeping for pixel reg
		LDR r6, =image
		MOV r7, r12
		LSR r7, #5
		MOV r8, #64
		MUL r7, r7, r8
		LDR r9, =0x3FF
		AND r7, r9
		ADD r6, r6, r7
		
		B beloop
			
vloope	BL hp
		MOV r12, #0
		
		; Generate V sync
vloopfp	CMP r10, #1
		BNE	vloopfp	
		MOV r10, #0
		BL vs_t
		BL hp
		
vloopfp1	CMP r10, #1
		BNE	vloopfp1
		MOV r10, #0
		BL hp
		
vloopfp2	CMP r10, #1
		BNE	vloopfp2	
		MOV r10, #0
		BL hp
		
vloopfp3	CMP r10, #1
		BNE	vloopfp3	
		MOV r10, #0
		BL vs_t
		BL hp
		
		MOV r3, #0
vloopbp	CMP r10, #1
		BNE	vloopbp
		MOV r10, #0
		BL hp
		ADD r3, r3, #1
		CMP r3, #38
		blt vloopbp

		B beloop
		
	ENDFUNC
	
; Timer interrupt handler
TIM2_IRQHandler FUNCTION
    PUSH        {r0, r1, r2, lr}
	
	; clear intr
    LDR         r0, =TIM2_SR
    LDR         r1, [r0]
    BIC         r1, #UIF
    STR         r1, [r0]
	LDR 		r5, =hreset
	MOVW		r10, #1
    POP         {r0, r1, r2, lr}
    BX          lr
	ENDFUNC

; Function to generate H sync
hp	FUNCTION
		PUSH        {r11, lr}
		BL hs_t
	
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		nop
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		NOP
		BL hs_t
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0
		MOV r11, #1
		MOV r11, #0

	
		POP       {r11 , lr}
		BX LR
	ENDFUNC

; toggle Vsync
vs_t	FUNCTION	
	PUSH        {r0, r1, lr}
	
		; Set output high
	LDR		R1, =GPIOD_ODR
	LDR		R0, [R1]
	EOR 	R0, #1 << 8
	STR		R0, [R1]

	POP        {r0, r1, lr}
	BX          lr
	ENDFUNC

; Toggle Hsync
hs_t	FUNCTION	
	push        {r0, r1, lr}
	
		; Set output high
	LDR		R1, =GPIOD_ODR
	LDR		R0, [R1]
	EOR 	R0, #1 << 9
	STR		R0, [R1]

	POP        {r0, r1, lr}
	BX          lr
	ENDFUNC

; Function to clear all color values
cr_f	FUNCTION	
	PUSH        {r0, r1, lr}
	
		; Set output high
	LDR		R1, =GPIOD_ODR
	LDR		R0, [R1]
	AND 	R0, #~(1 << 10 | 1 <<  11 | 1 << 12 | 1 << 13 | 1 << 14 | 1 << 15)
	STR		R0, [R1]

	POP        {r0, r1, lr}
	BX         lr
	ENDFUNC
	
	END