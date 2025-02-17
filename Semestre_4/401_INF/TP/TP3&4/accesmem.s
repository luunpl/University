     .data
aa: .word 24
xx: .word 266
bb: .word 42

     .text
     .global main
main:
     LDR r5, LD_xx
     LDR r6, [r5] 

     LDR r3, LD_aa
     LDR r4, [r3] 

     LDR r7, LD_bb
     LDR r8, [r7] 
@xx
  @ impression du contenu de r5
     MOV r1, r5
     BL EcrHexa32

  @ impression du contenu de r6
     MOV r1, r6
     BL EcrHexa32
@aa
  @ impression du contenu de r3
     MOV r1, r3
     BL EcrHexa32

  @ impression du contenu de r4
     MOV r1, r4
     BL EcrHexa32

@bb 
  @ impression du contenu de r7
     MOV r1, r7
     BL EcrHexa32
  @ impression du contenu de r8
     MOV r1, r8
     BL EcrHexa32
fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_xx: .word xx
LD_aa: .word aa
LD_bb: .word bb
