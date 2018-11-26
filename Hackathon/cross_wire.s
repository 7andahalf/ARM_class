; (P, Q) is the new Origin
; X = 320 is the width of screen, and Y = 240 is the height

; in co-oridinate system, the last pixel is at x = 319, and y = 239
; store these values in r4, r5 respectively

; store the co ordinates of origin in r2, r3 respectively


; so for origin at (100, 100) and size 320, 240, the register layout looks like this
;
; | R0  | R1 | R2  | R3  | R4  |  R5 |
; |  0  | 0  | 100 | 100 | 319 | 239 |
;

; Function Horiz1 draws the horizontal line from Yaxis to origin
; Function Horiz2 draws the horizontal line from origin to infinity
;
; Function Vert1 draws the vertical line from Xaxis to origin
; Function Vert2 draws the vertical line from origin to infinity

;
; For Horiz1, y(R1) = R3, and incrementing R0 till it is equal to origin
; and pushing the values at each step into stack
; in horiz2, y(R1) = R3 incrementing R0 again till end of screen
; and pushing the values at each step into stack
;
; same for vertical functions



	AREA     appcode, CODE, READONLY
	EXPORT __main
	ENTRY 

__main FUNCTION
	MOV r0, #0 ; x
	MOV r1, #0 ; y
	MOV r2, #100 ; P
	MOV r3, #100 ; Q
	MOV r4, #319 ; Max = 320
	MOV r5, #239 ; Max = 240

	push{r2, r3} ; Pushing origin
	push{r3, r4} ; Pushing right most point in horizontal line
	; you can aswell make BET Vert1 to BGT Vert1 instead of this.

Horiz1 MOV r0, #0
	MOV r1, r3
Lhoriz1 CMP r0, r2
	BEQ Horiz2
	PUSH {r0, r1}
	ADD r0, #1
	B Lhoriz1 

Horiz2 ADD r0, #1
Lhoriz2 CMP r0, r4
	BEQ Vert1
	PUSH {r0, r1}
	ADD r0, #1
	B Lhoriz2

Vert1 MOV r0, r2
	MOV r1, #0
Lvert1 CMP r1, r3
	BEQ Vert2
	PUSH {r0, r1}
	ADD r1, #1
	B Lvert1

Vert2 ADD r1, #1
Lvert2 CMP r1, r5
	BGT stop
	PUSH {r0, r1}
	ADD r1, #1
	B Lvert2

	;BL DrawCrossWire

stop B stop
    ENDFUNC
end