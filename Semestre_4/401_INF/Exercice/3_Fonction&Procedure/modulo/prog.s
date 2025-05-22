   .data
invite: .asciz "Quel est votre nombre ? "
resultat: .asciz "Resultat : "
   .balign 4
x: .word 0

   .text
   .global main
   

main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  ldr R6, [R1]
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  ldr R5, [R1]
tq: cmp R5, #0
  beq fin
  
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @ A completer : appel de la fonction modulo définie en C @
  @ parametre en entrée R0, R1                             @
  @ paramètre en sortie R0                                 @
  
  @ pour faire :
  @ R7 <- modulo(R6, R5)
  
  @ zone à compléter :




  @ fin de la zone à compléter @
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  
  mov R6, R5
  mov R5, R7
  b tq
fin:  
  ldr R1, LC_resultat
  bl EcrChaine
  mov R1, R6
  bl EcrZdecimal32
  mov R0, #0
  pop {lr}
  BX lr

LC_invite : .word invite
LC_resultat : .word resultat
LD_x : .word x

