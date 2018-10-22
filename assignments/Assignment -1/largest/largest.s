; VINAY CHANDRASEKHAR K - IMT2015523
; ARM Cortex M4 assembly code for finding greatest of three numbers
; INPUT: R0, R1, R2
; OUTPUT: R3

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #1		;input A
		MOV  r1, #2 	;input B
		MOV  r2, #3		;input C	
		
		CMP r0, r1		; r0 > r1?
		ITE GE			; Works without ITE aswell
		MOVGE r3, r0	; YES r3 = r0
		MOVLT r3, r1	; NO r3 = r1
		
		CMP r2, r3		; r2 > r3
		IT GE			; Works without IT aswell
		MOVGE r3, r2	; YES r3 = r2

stop B stop 			; stop program
     ENDFUNC
     END
		 
		
; TESTING RESULTS
; INPUT R0,R1,R2 = 1,2,3 OUTPUT R3 = 3
; INPUT R0,R1,R2 = 1,3,2 OUTPUT R3 = 3
; INPUT R0,R1,R2 = 2,3,1 OUTPUT R3 = 3
; INPUT R0,R1,R2 = 3,2,1 OUTPUT R3 = 3
; INPUT R0,R1,R2 = 3,1,2 OUTPUT R3 = 3
; INPUT R0,R1,R2 = 2,1,3 OUTPUT R3 = 3