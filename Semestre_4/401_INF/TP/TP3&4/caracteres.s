    .data
cc: @ ne pas modifier cette partie
    .byte 0x42
    .byte 0x4f
    .byte 0x4e
    .byte 0x4a
    .byte 0x4f
    .byte 0x55
    .byte 0x52
    .byte 0x00     @ code de fin de chaine
    @ la suite pourra etr emofifiee

    .word 12
    .word 0x11223344
av: .asciz "au revoir..."

    .text
    .global main
main:

@ impression de la chaine de caractere d'adresse cc
    ldr r1, LD_cc
    bl EcrChaine

@ impression de la chaine "au revoir..."
@ A COMPLETER
    ldr r1, LD_av
    bl EcrChaine


@ modification de la chaine d'adresse cc
@ A COMPLETER
    MOV r4, #-25
    LDR r5, LD_cc
    STR r4, [r5]

@ impression de la chaine cc modifiee
     ldr r1, LD_cc
     bl EcrChaine

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_cc: .word cc
LD_av: .word av

