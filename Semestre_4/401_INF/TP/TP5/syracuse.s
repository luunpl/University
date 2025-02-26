.text
    .global main
main:
    mov r1, #15 @ x = 15
    bl EcrNdecimal32
tq:
    cmp r1, #1
    beq fintq
si:
    tst r1, #1
    beq pair
@ impair
    add r1, r1, lsl #1 @ x = 3 * x 
    add r1, r1, #1     @ x = x + 1
    bl EcrNdecimal32
    b tq
pair:
@ pair
    mov r1, r1, lsr #1 @ x = x / 2
    bl EcrNdecimal32
    b tq
fintq:
    bx lr





