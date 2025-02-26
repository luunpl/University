.text
    .global main
main:
    mov r0, #15 @ x = 15
    bl afficher @ Call afficher function
    b fin

afficher:
    push {lr}
    mov r1, r0
    bl printf
    pop {lr}
    bx lr
tq:
    cmp r0, #1
    beq fintq
si:
    tst r0, #1
    beq else
@ pair
    mov r0, r0, lsr #1 @ x = x / 2
    b tq
else:
@ impair
    add r0, r0, lsl #1 @ x = 3 * x 
    add r0, r0, #1     @ x = x + 1

    b tq
fintq:
    bx lr

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)



