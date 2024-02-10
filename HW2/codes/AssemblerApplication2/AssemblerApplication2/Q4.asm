.include "m32def.inc"

.equ    GCD_result =  0x20  ; Address to store the result

.org    0x00              ; Reset vector
    rjmp    reset_handler

.org    0x04              ; Interrupt vector table
    rjmp    reset_handler

reset_handler:
    ldi     R16, low(RAMEND)   ; Initialize stack pointer
    out     SPL, R16
    ldi     R16, high(RAMEND)
    out     SPH, R16

    ldi     R16, GCD_result    ; Load address of result variable
    std     Z + 0, R16         ; Store the address in the Z register

    ldi     ZL, low(RAMEND)    ; Initialize Z register for result storage
    ldi     ZH, high(RAMEND)

    ldi     R16, 0             ; Initialize counter
    ldi     R17, 0             ; Initialize temporary register

gcd_loop:
    cpi     R16, 255           ; Check if counter reached maximum value
    breq    gcd_done

    ldi     R18, 0             ; Clear R18 for remainder calculation

    mov     R19, R30           ; Copy R30 to R19
    mov     R20, R16           ; Copy counter to R20

    rcall   check_remainder   ; Check remainder for R30

    tst     R18                ; Check if remainder is zero
    breq    check_r31          ; If zero, check R31

    rjmp    next_iteration

check_r31:
    mov     R19, R31           ; Copy R31 to R19
    mov     R20, R16           ; Copy counter to R20

    rcall   check_remainder   ; Check remainder for R31

    tst     R18                ; Check if remainder is zero
    breq    found_gcd

next_iteration:
    inc     R16                ; Increment counter
    rjmp    gcd_loop

found_gcd:
    mov     R16, R20           ; Copy counter to R16 (GCD)
    std     Z + 0, R16         ; Store GCD in the result variable

gcd_done:


check_remainder:
    ; Divide R19 by R20 and store remainder in R18
    clr     R18
    ldi     R20, 0x01          ; Ensure R20 is non-zero for division
    ret
