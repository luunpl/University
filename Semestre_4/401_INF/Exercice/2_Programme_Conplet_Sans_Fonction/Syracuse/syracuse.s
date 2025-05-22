   .data
invite: .asciz "Donner un nombre :"
   .balign 4
x: .word 0

   .text
   .global main
main: 
  push {lr}

  @ Saisie nombre
  ldr R1, LC_invite
  bl EcrChaine
  ldr R1, LD_x
  bl Lire32
  
  @ Syracuse
  
  @@@@@@@@@@@@@
  @ completer @
  @@@@@@@@@@@@@
  
  
  

fin:  
  mov R0, #0
  pop {lr}
  BX lr

LC_invite : .word invite
LD_x : .word x

