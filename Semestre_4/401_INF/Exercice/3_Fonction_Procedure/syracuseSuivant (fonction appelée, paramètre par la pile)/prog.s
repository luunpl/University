   .data
invite: .asciz "Quel est votre nombre ? "
resultat: .asciz "Resultat : "
   .balign 4
x: .word 0

   .text
   .global main
   
@syracuseSuivant en entrée 1 paramètre V (@fp+12), en sortie 1 résultat (@fp+8)
@  Si V est pair : retourner V/2
@  sinon retourner (3*V+1)/2
syracuseSuivant: 

  @ compléter
  
  
  
  
  bx lr
 
  
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  ldr R1, [R1]
  mov R0, #0
tq: cmp R1, #1
  beq fin
  push {R1}      @ parametre
  sub sp, sp, #4 @ resultat
  bl syracuseSuivant
  pop {R1}       @ resultat
  add sp, sp, #4 @ parametre
  add R0, R0, #1
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
