; Load immediate value 0 into register R16
ldi R16, 0
; Load immediate value 0xFF into register R17
ldi R17, 0xFF
; Load immediate binary value 11001010 into register R18
ldi R18, 0b11001010
; Set PORTA as output (all bits to 0)
out DDRA, R16
; Set PORTB as output (all bits to 0)
out DDRB, R16
; Set PORTD as input (all bits to 1)
out DDRD, R17
loop:
    ; Read input from PORTA and store in R19
    in R19, PINA
    ; Compare R18 with R19
    cp R18, R19
    ; If not equal, go back to the loop
    brne loop
    ; Read input from PORTB and add to R19
    in R20, PINB
    add R19, R20

    ; Write the result to PORTD
    out PORTD, R19

    ; Increment R18
    inc R18

    ; Jump back to the loop
    rjmp loop
