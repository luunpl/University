    .data
               @1234567890123456
SECRET: .asciz "KXKT A'PGRWX !!!"
    .balign 4
X:  .word 15

    .text           
    .global main
main:
    push {lr}
    
    @ partie manquante

    mov R0, #0
    pop {lr}
    bx lr

ptr_SECRET: .word SECRET
ptr_X:      .word X
