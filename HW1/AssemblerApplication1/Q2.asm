; Initialize R10 (cnt) to 0
LDI R19, 0x00    ; Load immediate value 0x00 into R19
MOV R10, R19     ; Move the value from R19 to R10 (cnt)

; Load loop counters i and j from memory
LDS R17, 0xB0    ; Load i from memory (address 0xB0)
LDS R18, 0xB1    ; Load j from memory (address 0xB1)

; Initialize loop counters i and j
LDI R17, 0x01    ; Load immediate value 0x01 into R17 (i)
LDI R18, 0x05    ; Load immediate value 0x05 into R18 (j)

; First loop (i)
FirstFor:
    CPI R17, 0x0B   ; Compare i with 0x0B (11 in decimal)
    BRGE EndFirstFor ; Branch if i >= 11

    ; Second loop (j)
SecondFor:
    CP R18, R17     ; Compare j with i
    BRLO EndSecondFor ; Branch if j < i

    INC R10         ; Increment cnt
    DEC R18         ; Decrement j
    RJMP SecondFor  ; Repeat SecondFor loop

EndFirstFor:
    STS 0xB0, R17   ; Store the final value of i to memory (address 0xB0)
    STS 0xB1, R18   ; Store the final value of j to memory (address 0xB1)
    RJMP EndFirstFor ; Repeat EndFirstFor indefinitely

EndSecondFor:
    INC R10         ; Increment cnt
    INC R10         ; Increment cnt again (equivalent to cnt += 2)
    INC R17         ; Increment i
    LDI R18, 0x05   ; Reload immediate value 0x05 into R18 (j)
    RJMP FirstFor   ; Repeat FirstFor loop
