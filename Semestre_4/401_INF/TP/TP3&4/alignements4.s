.data
x:  .byte 0x11
    .balign 2  @ Alignement à 2 octets pour a
a:  .hword 0x3456

.text
.global main
main:
    @ Lire et afficher la valeur de x
    LDR r0, LD_x
    LDRB r1, [r0]
    BL EcrZdecimal8

    @ Lire et afficher la valeur de a
    LDR r0, LD_a
    LDRH r1, [r0]
    BL EcrZdecimal16

    B fin  @ terminaison immédiate du processus

fin:  B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_x: .word x
LD_a: .word a

