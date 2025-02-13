.data
D1:    .word  266
D2:    .hword 42
D3:    .byte 12

    .text
    .global main
main:
      LDR r3, LD_D1
      LDR r4, [r3]
      BL EcrNdecimal32  @ Affiche la valeur de r4 (266)
      MOV r1, r3
      BL EcrNdecimal32  @ Affiche l'adresse de D1

      LDR r5, LD_D2
      LDRH r6, [r5]
      BL EcrNdecimal16  @ Affiche la valeur de r6 (42)
      MOV r1, r5
      BL EcrNdecimal32  @ Affiche l'adresse de D2

      LDR r7, LD_D3
      LDRB r8, [r7]
      BL EcrNdecimal8   @ Affiche la valeur de r8 (12)
      MOV r1, r7
      BL EcrNdecimal32  @ Affiche l'adresse de D3

fin:  B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_D1:   .word D1
LD_D2:   .word D2
LD_D3:   .word D3

