; INPUT: 	R10 start of array 
;			R11 length of array
; OUTPUT: R0 or R1

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
	 
	 
__main  FUNCTION		 		
		MOV  r10, #1000	;input A
		MOV  r11, #1024 ;input B
		
		;;;;;;;;;; ENCRYPTION
		
		MOV	 r8, #0x11111111 ; init
		
		MOV  r7, #0x00000002 ; in
		BL e_proc
		MOV r0, r6;
		
		MOV  r7, #0x00000003 ; in
		BL e_proc
		MOV r1, r6;
		
		MOV  r7, #0x00000004 ; in
		BL e_proc
		MOV r2, r6;

		;;;;;;;;;;;;; DECRYPTION
		
		MOV	 r8, #0x11111111 ; init
		
		MOV r7, r0;
		BL d_proc
		MOV r0, r6;
		
		MOV r7, r1;
		BL d_proc
		MOV r1, r6;
		
		MOV r7, r2;
		BL d_proc
		MOV r2, r6;
	
stop B stop 			; stop program
     ENDFUNC
     
	
; R8 = IV
; R7 = Input
; R6 = Output
e_proc	EOR r6, r7, r8
		ROR r6, #8			; CBC
		MOV r8, r6			; update IV
		BX lr

; R8 = IV
; R7 = Input
; R6 = Output
d_proc	MOV r6, r8			; update IV
		MOV r8, r7
		ROR r7, #24
		EOR r6, r6, r7		; CBC	
		BX lr
		
		END
		
