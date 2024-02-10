; Load immediate values into registers
LDI R16, 20    ; Load the lower byte of the first number into R16
LDI R17, 25    ; Load the upper byte of the first number into R17
LDI R18, 30    ; Load the divisor into R18

LDI R19, 16    ; Load the loop counter with the bit count
CLR R20        ; Clear the lower byte of the quotient
CLR R21        ; Clear the upper byte of the quotient

; Divide loop
ForLoop:
    LSL R20     ; Shift the quotient left
    ROL R21     ; Rotate the carry into the upper byte of the quotient
    CP R21, R18 ; Compare the current quotient with the divisor
    BRCS No ; Branch if the carry is set (quotient >= divisor)

    ; Subtract the divisor from the current quotient
    SUB R21, R18 ; Subtract the divisor from the quotient's upper byte
    INC R20      ; Increment the lower byte of the quotient

No:
    DEC R19      ; Decrement the loop counter
    BRNE ForLoop ; Branch to DivideLoop if the loop counter is not zero
