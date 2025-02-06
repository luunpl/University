     .data
aa: .word 24
xx: .word 266
bb: .word 42

     .text
     .global main
main:
     LDR r5, LD_xx
     LDR r6, [r5] 

  @ impression du contenu de r5
     MOV r1, r5
     BL EcrHexa32


  @ impression du contenu de r6
     MOV r1, r6
     BL EcrHexa32

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_xx: .word xx

