.include "m32def.inc"

.equ    F_CPU, 8000000      ; Define the clock frequency

.org    0x00              ; Reset vector
    rjmp    reset_handler

.org    0x04              ; Interrupt vector table
    rjmp    reset_handler

reset_handler:
    ldi     R16, low(RAMEND)   ; Initialize stack pointer
    out     SPL, R16
    ldi     R16, high(RAMEND)
    out     SPH, R16

    ldi     R16, (1 << WGM01) | (1 << CS02) | (1 << CS00)  ; Set CTC mode and prescaler to 1024
    out     TCCR0, R16        ; Configure Timer/Counter 0

    ldi     R16, 0xFF         ; Set OCR0 to its maximum value
    out     OCR0, R16         ; Set Output Compare Register

    sbi     DDRC, PC2         ; Set PC2 as output pin

    sei                       ; Enable global interrupts

    reti

