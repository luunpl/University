@ elements de solution
     .data
a: .word 0
b: .word 0
c: .word 0
r: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat : "

     .text
     .global main
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChn
  @ lecture du nombre
  ldr R1, LD_a
  bl Lire32
  ldr R1, LC_invite
  bl EcrChn
  @ lecture du nombre
  ldr R1, LD_b
  bl Lire32
  ldr R1, LC_invite
  bl EcrChn
  @ lecture du nombre
  ldr R1, LD_c
  bl Lire32
  @ calcul

  @ à compléter
  
  
  @ affichage du resultat
  ldr R1, LC_resultat
  bl EcrChn
  ldr R1, LD_r
  ldr R1, [R1]
  bl EcrZdecimal32

fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_a: .word a
LD_b: .word b
LD_c: .word c
LD_r: .word r
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat




