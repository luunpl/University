     .data
n:  .word 0
v:  .word 0
Pi: .word 3
    .word 1
    .word 4
    .word 1
    .word 5
    .word 9
    .word 2
    .word 6
    .word 5
    .word 3
chaine_invite: .asciz "Donner un indice : "
chaine_resultat: .asciz "Resultat : "

     .text
     .global main
main: 
  push {lr}
  @ saisie d'un nombre
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_n
  bl Lire32

  @ completer par l'acces v <- Pi[n]

  @ A FAIRE


  @ affichage du resultat
  ldr R1, LC_resultat
  bl EcrChn
  ldr R1, LD_v
  ldr R1, [R1]
  bl EcrZdecimal32


fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_n: .word n
LD_v: .word v
LD_Pi: .word Pi
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


