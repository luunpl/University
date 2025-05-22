.data
x:    .byte 0x01
y:    .byte 0x02
z:    .byte 0x04
    .balign 4  @ Alignement à 4 octets pour a
a:    .word 0x0A0B0C0D
b:    .byte 0x08

.text
.global main
main:
    @ Lire et afficher la valeur de x
    LDR r0, LD_x
    LDRB r1, [r0]
    BL EcrZdecimal8

    @ Lire et afficher la valeur de y
    LDR r0, LD_y
    LDRB r1, [r0]
    BL EcrZdecimal8

    @ Lire et afficher la valeur de z
    LDR r0, LD_z
    LDRB r1, [r0]
    BL EcrZdecimal8

    @ Lire et afficher la valeur de a
    LDR r0, LD_a
    LDR r1, [r0]
    BL EcrZdecimal32

    @ Lire et afficher la valeur de b
    LDR r0, LD_b
    LDRB r1, [r0]
    BL EcrZdecimal8

    B fin  @ terminaison immédiate du processus

fin:  B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_x:   .word x
LD_y:   .word y
LD_z:   .word z
LD_a:   .word a
LD_b:   .word b

