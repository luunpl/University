     .data
a: .word 0
b: .word 0
min: .word 0
max: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Résultat : "

     .text
     .global main
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_a
  bl Lire32
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_b
  bl Lire32

  @ completer par le calcul du min et du max de a et b

  @ A FAIRE
  
  @ affichage des resultats
  ldr R1, LC_resultat
  bl EcrChn
  ldr R1, LD_min
  ldr R1, [R1]
  bl EcrZdecimal32
  ldr R1, LD_max
  ldr R1, [R1]
  bl EcrZdecimal32
  

fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_a: .word a
LD_b: .word b
LD_min: .word min
LD_max: .word max
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


