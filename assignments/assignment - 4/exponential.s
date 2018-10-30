; VINAY CHANDRASEKHAR K - IMT2015523
; ARM Cortex M4 assembly code for exponential of a number
; INPUT: S0
; OUTPUT: S1
; TEMP REGS: S2 to S5
; Functioning: 	Every loop it will calculate a new term of the exponential and add it to result, 
;				it will do it until the addition is less than the precision leading to the same constant value.

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
	 
__main  FUNCTION		 		
		VMOV.F s0,#-5.00	; in
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
		
stop B stop 			; stop program
     ENDFUNC
     END
		 
		
; TESTING RESULTS
; INPUT S0 = 1; OUTPUT S1 = 2.71828
; INPUT S0 = 2; OUTPUT S1 = 7.38906
; INPUT S0 = 3; OUTPUT S1 = 20.0855
; INPUT S0 = 10; OUTPUT S1 = 22026.5
; INPUT S0 = 20; OUTPUT S1 = 4.85165e+008
; INPUT S0 = -1; OUTPUT S1 = 0.367879
; INPUT S0 = -5; OUTPUT S1 = 0.00673842