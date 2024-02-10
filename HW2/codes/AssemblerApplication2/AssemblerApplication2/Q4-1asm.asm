.global calculate_gcd

calculate_gcd:
    ; Inputs: R30 and R31
    ; Outputs: R29 (GCD)

    ; Initialize R29 with the smaller of R30 and R31
    cp      R30, R31
    cpc     R29, R30
    brge    gcd_start
    mov     R29, R31
    rjmp    gcd_start

gcd_start:
    ; Initialize R28 with 0 (counter)
    clr     R28

gcd_loop:
    ; Check if the counter equals the value in R29
    cp      R28, R29
    breq    gcd_done

    ; Check if both numbers are divisible by the counter
    mov     R20, R30
    mov     R21, R28
    rcall   check_remainder

    ; If remainder is non-zero, go to the next iteration
    tst     R22
    breq    check_r31

    rjmp    next_iteration

check_r31:
    mov     R20, R31
    mov     R21, R28
    rcall   check_remainder

    ; If remainder is zero, found GCD
    tst     R22
    brne    next_iteration

    rjmp    found_gcd

next_iteration:
    ; Increment the counter
    inc     R28
    rjmp    gcd_loop

found_gcd:
    ; Move the GCD to register R29
    mov     R29, R28
    ret

check_remainder:
    ; Divide R20 by R21 and store remainder in R22
    clr     R22
    idiv
    ret
