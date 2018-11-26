; INPUT: 	R10 start of array 
;			R11 length of array
; OUTPUT: R0 or R1

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
	 
	 
__main  FUNCTION

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CLIENT
		;; DATA: 0 to 100
		MOV  r0, #0		; counter
		
		;;;;;;;;;; ENCRYPTION
		
		;; init
		MOV	 r1, #0x11111111 ; init
		MOV  r2, #0x11111111 ; init
		
		;; loop
loop	MOV r8, r1;
		MOV  r7, r0 ; in
		BL e_proc
		MOV r1, r8;
		
		MOV r7, r6;
		BL e_hamm
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SERVER
		
		;;;;;;;;;; DECRYPTION
		MOV r5, r6;
		BL d_hamm
		
		MOV r7, r6;
		MOV r8, r2;
		BL d_proc
		MOV r2, r8;
		
		PUSH {R6}
		
		ADD r0, r0, #1;
		CMP r0, #7;
		BLT loop;
		
stop B stop 			; stop program
     ENDFUNC
     
	
; R8 = IV
; R7 = Input
; R6 = Output
e_proc	EOR r6, r7, r8
		;ROR r6, #8			; CBC
		MOV r8, r6			; update IV
		BX lr

; R8 = IV
; R7 = Input
; R6 = Output
d_proc	MOV r6, r8			; update IV
		MOV r8, r7
		;ROR r7, #24
		EOR r6, r6, r7		; CBC	
		BX lr
		
; R7 = Input
; R6 = Output
			
e_hamm	MOV     R8, R7 , LSR #2    ;Load data
		 AND     R8, R8,#1
		 MOV     R9, R7 , LSR #1    ;Load data
		 AND     R9, R9,#1
		 MOV     R10, R7 
		 AND     R10, R10,#1
   
		EOR	R3, R8, R9;C1
		EOR	R4, R8, R10;C2
		EOR	R5, R9, R10;C3
	
		MOV R6, R3, LSL #5 ; R8 = R9 * 2 ^ 3
		ADD R6, R6, R4, LSL #4 ; R8 = R8 + R9 * 2^2
		ADD R6, R6, R8, LSL #3 ; R8 = R8 + R9 * 2^2
		ADD R6, R6, R5, LSL #2 ; R8 = R8 + R9 * 2^2
		ADD R6, R6, R9, LSL #1 ; R8 = R8 + R9 * 2^2
		ADD R6, R6, R10, LSL #0 ; R8 = R8 + R9 * 2^2
		BX lr
		
		
			
; R5 = Inp
; R6 = Output
d_hamm	; const
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
		
