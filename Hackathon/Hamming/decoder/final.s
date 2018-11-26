; INPUT: 	R10 start of array 
;			R11 length of array
; OUTPUT: R0 or R1

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
	 
	 
__main  FUNCTION		 		
		MOV  r5, #0x0B;
		
		BL h_dec
	
stop B stop 			; stop program
     ENDFUNC
     
	
; R5 = Inp
; R6 = Output
h_dec	; const
		MOV r8, #0;
		
		; Parity 1
		MOV r6, r5;
		MOV r7, r5;
		ROR r6, #3;
		ROR r7, #1;
		AND r6, #1;
		AND r7, #1;
		EOR r6, r6, r7;
		MOV r7, r5;
		ROR r7, #5;
		AND r7, #1;
		EOR r6, r6, r7;
		ADD r8, r8, r6;
		
		; Parity 2
		MOV r6, r5;
		MOV r7, r5;
		ROR r6, #3;
		AND r6, #1;
		AND r7, #1;
		EOR r6, r6, r7;
		MOV r7, r5;
		ROR r7, #4;
		AND r7, #1;
		EOR r6, r6, r7;
		ADD r8, r8, r6;
		ADD r8, r8, r6;
		
		; Parity 3
		MOV r6, r5;
		MOV r7, r5;
		ROR r6, #1;
		AND r6, #1;
		AND r7, #1;
		EOR r6, r6, r7;
		MOV r7, r5;
		ROR r7, #2;
		AND r7, #1;
		EOR r6, r6, r7;
		ADD r8, r8, r6;
		ADD r8, r8, r6;
		ADD r8, r8, r6;
		ADD r8, r8, r6;
		
		; check if any errors
		
		MOV r7, r5;
		
		CMP r8, #0;
		BEQ done
		
		MOV r6, #6;
		SUB r8, r6 , r8
		MOV r6, #1;
		LSL r6, r8;
		EOR r7, r7, r6;
		
done	MOV r6, r7;
		AND r6, #3;
		LSR r7, #1;
		AND r7, #4;
		ORR	r6, r7;
		
		BX lr

		END