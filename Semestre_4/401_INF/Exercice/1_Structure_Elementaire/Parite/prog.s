     .data
n: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_pair: .asciz "pair"
chaine_impair: .asciz "impair"

     .text
     .global main
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_n
  bl Lire32

  @ completer par l'affichage du resultat

  @ A FAIRE
  

fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_n: .word n
LC_invite : .word chaine_invite
LC_pair : .word chaine_pair
LC_impair : .word chaine_impair


