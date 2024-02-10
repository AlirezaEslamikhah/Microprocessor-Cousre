.include "m32def.inc"
start:
    call delay
delay:
    ldi r20, 0x04
L1:
    ldi r21, 0xff
L2 :
    ldi r22, 0xff
L3:
    NOP
    dec r22
    brne L3
    dec r21
    brne L2
    dec r20
    brne L1
    ret

