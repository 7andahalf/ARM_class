; VINAY CHANDRASEKHAR K - IMT2015523
; Assignment 5 - Neural Network on ARM
; Registers used
;	S10, S11, S12 = Input
;	S13, S14, S15 = Weights
;	S16 = Bias
;	S17 = (Weight . Input) + Bias
;	S0 to S5, S18 = Temp
;	S19 = Output

; Testing
; running this program prints 0001011111000110011011101000
; This output corresponds to the output given by the python program exactly
; But many of the gates are not correctly implemented in the python code
; The corrected version of the code where all gates work correctly is given in the other file (floating_point_correct.s)

     area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
	 
__main  function		 
		
		BL w_and			; Call AND
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_or				; Call OR
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_not			; Call NOT
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_xor			; Call XOR
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_xnor			; Call XNOR
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_nand			; Call NAND
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		BL w_nor			; Call NOR
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 0
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 0
		BL process
		BL printMsg 		; Print result
		
		VLDR.F32 S10, = 1	; Inputs
		VLDR.F32 S11, = 1
		VLDR.F32 S12, = 1
		BL process
		BL printMsg 		; Print result
		
fullstop   B  fullstop ; stop program	   
		endfunc
	

w_or	VLDR.F32 S13, = -0.1
		VLDR.F32 S14, = 0.7
		VLDR.F32 S15, = 0.7
		VLDR.F32 S16, = -0.1
		BX	lr
		
w_and	VLDR.F32 S13, = -0.1
		VLDR.F32 S14, = 0.2
		VLDR.F32 S15, = 0.2
		VLDR.F32 S16, = -0.2
		BX	lr
		
w_not	VLDR.F32 S13, = 0.5
		VLDR.F32 S14, = -0.7
		VLDR.F32 S15, = 0
		VLDR.F32 S16, = 0.1
		BX	lr
		
w_xor	VLDR.F32 S13, = -5
		VLDR.F32 S14, = 20
		VLDR.F32 S15, = 10
		VLDR.F32 S16, = 1
		BX	lr

w_xnor	VLDR.F32 S13, = -5
		VLDR.F32 S14, = 20
		VLDR.F32 S15, = 10
		VLDR.F32 S16, = 1
		BX	lr

w_nand	VLDR.F32 S13, = 0.6
		VLDR.F32 S14, = -0.8
		VLDR.F32 S15, = -0.8
		VLDR.F32 S16, = 0.3
		BX	lr
		
w_nor	VLDR.F32 S13, = 0.5
		VLDR.F32 S14, = -0.7
		VLDR.F32 S15, = -0.7
		VLDR.F32 S16, = 0.1
		BX	lr
		
	
process	VMUL.F32 S17, S10, S13	; dot product
		VFMA.F32 S17, S11, S14
		VFMA.F32 S17, S12, S15
		VADD.F32 S17, S17, S16	; add bias
			 		
		VMOV.F s0,s17		; in
		VNEG.F s0,s0		; in = -in
		VMOV.F s1,#1		; out
		VMOV.F s2,#1		; ctr
		VMOV.F s3,s0		; tmp
		VMOV.F s4,#31 		; cmp
		VMOV.F s5,#1 		; add
		
loop	VCMP.F s1, s4		; prev value == curr value?
		VMRS APSR_nzcv,FPSCR; move FPSR flags to APSR
		BEQ stop			; YES stop
		
		VMOV.F s4, s1		; s4 = s1, for checking if value will change
		VDIV.F s3, s3, s2	; s3 /= s2
		VADD.F s1, s1, s3	; s1 += s3
		VMUL.F s3, s3, s0	; s3 *= s0
		VADD.F s2, s2, s5	; s2 += s5

		B loop

stop	VADD.F32 s1, s1, s5	; s1 += 1
		VDIV.F32 s1, s5, s1 ; s1 = 1/s1
		
		VMOV.F s4,#0.5		; Compare with 0.5 to round
		VCMP.F s1, s4		
		VMRS APSR_nzcv,FPSCR
		MOVGE R0,#1			; Logic 1 out
		MOVLT R0,#0			; Logic 0 out
		
		BX	lr

		end
			
