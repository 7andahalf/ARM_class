; VINAY CHANDRASEKHAR K - IMT2015523
; ARM Cortex M4 assembly code for GCD of two numbers
; INPUT: R0, R1
; OUTPUT: R0 or R1

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #1000	;input A
		MOV  r1, #1024 	;input B
		
loop	CMP r0, r1		; r0 == r1?
		BEQ stop		; YES stop
		
		CMP r0, r1		; r0 > r1
		ITE GT			; Works without ITE aswell
		SUBGT r0, r1	; YES r0 -= r1
		SUBLE r1, r0	; NO r1 -= r0
		
		B loop
		
stop B stop 			; stop program
     ENDFUNC
     END
		 
		
; TESTING RESULTS
; INPUT R0,R1 = 60,40 OUTPUT R0 = R1 = 20
; INPUT R0,R1 = 2,3 OUTPUT R0 = R1 = 1
; INPUT R0,R1 = 2,3 OUTPUT R0 = R1 = 1
; INPUT R0,R1 = 100,57 OUTPUT R0 = R1 = 1
; INPUT R0,R1 = 1000, 1024 OUTPUT R0 = R1 = 8