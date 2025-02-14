     .data
x: .byte 0x01
y: .byte 0x02
z: .byte 0x04
.balign 4 a: .word 0x0A0B0C0D
b: .byte 0x08

     .text
     .global main
main:

  @ impression du contenu de x
      LDR r3, LD_x
      LDR r4, [r3]
      BL EcrNdecimal32  @ Affiche la valeur de r4 
      MOV r1, r3
      BL EcrNdecimal32  @ Affiche l'adresse de a

  @ impression du contenu de y
      LDR r5, LD_y
      LDR r6, [r5]
      BL EcrNdecimal32  @ Affiche la valeur de r4 
      MOV r1, r5
      BL EcrNdecimal32  @ Affiche l'adresse de a

  @ impression du contenu de z
      LDR r5, LD_z
      LDR r6, [r5]
      BL EcrNdecimal32  @ Affiche la valeur de r4 
      MOV r1, r5
      BL EcrNdecimal32  @ Affiche l'adresse de a

  @ impression du contenu de a
      LDR r5, LD_a
      LDR r6, [r5]
      BL EcrNdecimal32  @ Affiche la valeur de r4 
      MOV r1, r5
      BL EcrNdecimal32  @ Affiche l'adresse de a

  @ impression du contenu de b
      LDR r5, LD_b
      LDR r6, [r5]
      BL EcrNdecimal32  @ Affiche la valeur de r4 
      MOV r1, r5
      BL EcrNdecimal32  @ Affiche l'adresse de a

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_x: .word x
LD_y: .word y
LD_z: .word z
LD_a: .word a
LD_b: .word b
