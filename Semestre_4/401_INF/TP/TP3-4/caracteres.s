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
    @ la suite pourra etre modifiee
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
    ldr r1, LD_av
    bl EcrChaine

@ modification de la chaine d'adresse cc
    ldr r0, LD_cc
    ldrb r1, [r0]
    add r1, r1, #0x20
    strb r1, [r0]
    ldrb r1, [r0, #1]
    add r1, r1, #0x20
    strb r1, [r0, #1]
    ldrb r1, [r0, #2]
    add r1, r1, #0x20
    strb r1, [r0, #2]
    ldrb r1, [r0, #3]
    add r1, r1, #0x20
    strb r1, [r0, #3]
    ldrb r1, [r0, #4]
    add r1, r1, #0x20
    strb r1, [r0, #4]
    ldrb r1, [r0, #5]
    add r1, r1, #0x20
    strb r1, [r0, #5]
    ldrb r1, [r0, #6]
    add r1, r1, #0x20
    strb r1, [r0, #6]

@ impression de la chaine cc modifiee
    ldr r1, LD_cc
    bl EcrChaine

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_cc: .word cc
LD_av: .word av
