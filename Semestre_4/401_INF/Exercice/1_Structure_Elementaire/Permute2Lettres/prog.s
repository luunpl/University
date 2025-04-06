     .data
i: .word 0
j: .word 0
tmp: .byte 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat"

     .text
     .global main
main: 
  push {lr}
  @ saisie d'un nombre
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_i
  bl Lire32
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_j
  bl Lire32

  @ permuter les deux lettres d'indice i et j de la chaine résultat

  @ A FAIRE


  @ affichage du resultat
  ldr R1, LC_resultat
  bl EcrChaine


fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_i: .word i
LD_j: .word j
LD_tmp: .word tmp
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


