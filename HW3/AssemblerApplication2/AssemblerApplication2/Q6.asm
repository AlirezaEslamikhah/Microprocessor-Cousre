.include "m32def.inc"

.equ    F_CPU, 8000000      ; Define the clock frequency
.equ    delay_count, F_CPU / 1024 - 1  ; Count for a 1-second delay with prescaler 1024

.org    0x00              ; Reset vector
    rjmp    reset_handler

.org    0x04              ; Interrupt vector table
    rjmp    reset_handler

reset_handler:
    ldi     R16, low(RAMEND)   ; Initialize stack pointer
    out     SPL, R16
    ldi     R16, high(RAMEND)
    out     SPH, R16

    ldi     R16, (1 << CS02) | (1 << CS00)  ; Set prescaler to 1024
    out     TCCR0, R16        ; Configure Timer/Counter 0

    ldi     R16, delay_count  ; Load delay count value
    out     TCNT0, R16        ; Load the counter value

delay_loop:
    sbis    TIFR, TOV0        ; Check if overflow flag is set
    rjmp    delay_loop        ; If not, continue waiting

    ldi     R16, delay_count  ; Reload delay count value
    out     TCNT0, R16        ; Load the counter value

    ldi     R16, (1 << TOV0)  ; Clear the overflow flag
    out     TIFR, R16


    ret
