     .data
n: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat : "

     .text
     .global main
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_n
  bl Lire32

  @ completer par le calcul de la valeur absolue de n

  @ A FAIRE

  @ affichage du resultat
  ldr R1, LC_resultat
  bl EcrChn
  ldr R1, LD_n
  ldr R1, [R1]
  bl EcrZdecimal32
  

fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_n: .word n
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


