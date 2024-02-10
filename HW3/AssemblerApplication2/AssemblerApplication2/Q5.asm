.include "m32def.inc"

.org    0x00              ; Reset vector
    rjmp    reset_handler

.org    0x04              ; Interrupt vector table
    rjmp    reset_handler

reset_handler:
    ldi     R29, 2            ; Initialize R29 with the base value (e.g., 2)
    ldi     R30, 3            ; Initialize R30 with the exponent value (e.g., 3)

    ldi     R16, 1            ; Initialize counter
    ldi     R17, 0            ; Initialize temporary register

power_loop:
    cpi     R16, 0            ; Check if counter is zero
    breq    power_done

    mul     R17, R29, R17     ; Multiply R29 by the temporary register (result in R1:R0)
    mov     R29, R0           ; Store the low byte of the result in R29
    mov     R30, R1           ; Store the high byte of the result in R30

    dec     R16               ; Decrement counter
    rjmp    power_loop

power_done:
    ; R29 now contains the result of R29^R30

