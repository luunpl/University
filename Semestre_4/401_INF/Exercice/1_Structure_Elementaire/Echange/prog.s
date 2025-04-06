     .data
a: .word 0
b: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat : "

     .text
     .global main
main: 
  push {lr}
  @ saisie d'un nombre
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_a
  bl Lire32

  @ saisie d'un nombre
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_b
  bl Lire32

  @ completer par l'échange des valeurs a et b

  @ A FAIRE


  @ affichage du resultat
  ldr R1, LC_resultat
  bl EcrChn
  ldr R1, LD_a
  ldr R1, [R1]
  bl EcrZdecimal32
  ldr R1, LD_b
  ldr R1, [R1]
  bl EcrZdecimal32


fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_a: .word a
LD_b: .word b
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


