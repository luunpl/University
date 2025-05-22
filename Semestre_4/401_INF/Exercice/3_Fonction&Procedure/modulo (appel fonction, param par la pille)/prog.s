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
  
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @ A completer : appel de la fonction modulo             @ 
  @ 2 parametres en entrée sur la pile (@fp+16 et @fp+12) @
  @ 1 résultat en sortie sur la pile (@fp+8)              @
   
  
  @ pour faire :
  @ R7  <-  modulo(R6, R5)
  @ (avec le détail des adresses :)
  @ R7 (@fp+8)  <- suivant(R6 (@fp+16), R5 (@fp+12))
  
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
  
modulo:
  push {lr}
  push {fp}
  mov fp, sp
  push {R0}
  push {R1}
  ldr R0, [fp,#16]
  ldr R1, [fp,#12]
mtq: cmp R0,R1
  blt mfin
  sub R0, R0, R1
  b mtq
mfin:
  str R0,[fp,#8]
  pop {R1}
  pop {R0}
  pop {fp}
  pop {lr}
  bx lr

LC_invite : .word invite
LC_resultat : .word resultat
LD_x : .word x

