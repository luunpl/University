   .data
invite: .asciz "Quel est votre nombre ? "
resultat: .asciz "Resultat : "
   .balign 4
x: .word 0

   .text
   .global main
   

@ minMax : range R0 et R1 dans l'ordre
@ la plus petite valeur dans R0
@ la plus grande dans R1
minMax :

 @ fonction à compléter 

 
  
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  ldr R2, [R1]
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  ldr R1, [R1]
  mov R0, R2
tq: cmp R0, R1
  beq fin
  bl minMax
  sub R1, R1, R0
  b tq
fin:  
  ldr R1, LC_resultat
  bl EcrChaine
  mov R1, R0
  bl EcrZdecimal32
  mov R0, #0
  pop {lr}
  BX lr

LC_invite : .word invite
LC_resultat : .word resultat
LD_x : .word x

