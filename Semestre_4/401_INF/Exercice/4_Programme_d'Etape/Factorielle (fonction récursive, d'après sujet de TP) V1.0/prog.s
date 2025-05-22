   .data
invite: .asciz "Donner un nombre :"
   .balign 4
n: .word 0
fn: .word 0

   .text
   .global main
   
fact:

  @@@@@@@@@@@@@
  @ completer @
  @@@@@@@@@@@@@

  bx lr
  
  
main: 
  push {lr}

  @ Saisie nombre
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_n
  bl Lire32
  
  @ appel a fact(n, adresse de fn) 
  
  @@@@@@@@@@@@@
  @ completer @
  @@@@@@@@@@@@@
  

  @ affichage resultat
  ldr R1, LD_fn
  ldr R1, [R1]
  bl EcrZdecimal32
  
fin: 
  mov R0, #0
  pop {lr}
  BX lr

LC_invite : .word invite
LD_n : .word n
LD_fn : .word fn

