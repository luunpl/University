  .data
txt: .asciz "Bonjour le monde"
  .balign 4
n: .word 3
msgVide: .asciz "Chaine vide"
msg0: .asciz "Pas de rotation"
msgDonne: .asciz "=>"


  .text
  .global main
  
main:
  push {lr}

  @
  @ partie manquante 
  @


  mov R0, #0
  pop {lr}
  bx lr

LD_txt: .word txt
LD_n: .word n
LD_msgVide: .word msgVide
LD_msg0: .word msg0
LD_msgDonne: .word msgDonne