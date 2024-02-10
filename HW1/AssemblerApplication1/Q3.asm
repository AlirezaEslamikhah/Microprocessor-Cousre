; Load the values into registers
LDI R16, 20    ; Load the lower byte of the first number into R16
LDI R17, 25    ; Load the upper byte of the first number into R17
LDI R18, 30    ; Load the lower byte of the second number into R18
LDI R19, 35    ; Load the upper byte of the second number into R19

; Multiply the upper byte of the first number with the lower byte of the second number
MUL R16, R19   ; Multiply the first high byte with the second low byte
ADD R21, R0    ; Add the result to the upper byte of the previous multiplication
ADC R22, R1    ; Add the carry to R22

; Multiply the lower byte of the first number with the upper byte of the second number
MUL R17, R18   ; Multiply the first low byte with the second high byte
ADD R21, R0    ; Add the result to the high byte of the previous multiplication
ADC R22, R1    ; Add the carry to R22

; Multiply the low bytes and store in R1:R0
MUL R17, R19   ; Multiply the low bytes and store the result in R1:R0
ADD R22, R0    ; Add the lower byte of the result to R22
ADC R23, R1    ; Add the carry to R23
