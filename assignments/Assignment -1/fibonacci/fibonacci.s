; VINAY CHANDRASEKHAR K - IMT2015523
; ARM Cortex M4 assembly code for fibonacci series
; INPUT: R0 = N
; OUTPUT: R2
; EXTRA REGS USED: R1

     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #7 ;input r0 = N
		MOV  r1, #1 ;fib(0)
		MOV  r2, #1 ;fib(1)
		SUB  r0, #1	;r0--	
		
loop	CMP r0, #0	;r0 == 0?
		BLE stop	;YES stop
		
		ADD r1, r2	;r1 += r2
		EOR r1, r2	;swap r1 and r2
		EOR r2, r1
		EOR r1, r2
		SUB r0, #1	;r0--
		B loop		;goto LOOP

stop B stop 		; stop program
     ENDFUNC
     END
		 
; TESTING RESULTS
; INPUT R0 = 0, OUTPUT R2 = 1 = fib(0)
; INPUT R0 = 1, OUTPUT R2 = 1 = fib(1)
; INPUT R0 = 2, OUTPUT R2 = 2 = fib(2)
; INPUT R0 = 3, OUTPUT R2 = 3 = fib(3)
; INPUT R0 = 4, OUTPUT R2 = 5 = fib(4)
; INPUT R0 = 5, OUTPUT R2 = 8 = fib(5)
; INPUT R0 = 6, OUTPUT R2 = 13 (0x0D) = fib(6)
; INPUT R0 = 7, OUTPUT R2 = 21 (0x15) = fib(7)