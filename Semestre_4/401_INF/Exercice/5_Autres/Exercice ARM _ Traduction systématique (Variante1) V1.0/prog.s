     .data
n: .word 1
a: .byte 'A'
chaine_invite: .asciz "Donner un chiffre (0<=x<10) : "
chaine_resultat1: .asciz "Resultat1 : "
chaine_resultat2: .asciz "Resultat2 : "

     .text
     .global main
main: 
  push {lr}
  @ saisie
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_n
  bl Lire32
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_a
  bl LireCar
  bl LireCar

  @ completer par la traduction des instructions suivantes
  @ si n > a-'0'  : n <- 5*n+13
  @ sinon : a <- '9' +1 - (a - '0')  
  
    @ A FAIRE



  @ affichage des resultats
  ldr R1, LC_resultat1
  bl EcrChn
  ldr R1, LD_n
  ldr R1, [R1]
  bl EcrZdecimal32
  ldr R1, LC_resultat2
  bl EcrChn
  ldr R1, LD_a
  ldr R1, [R1]
  bl EcrCar
  bl AlaLigne


fin: 
  pop {lr}
  bx lr

LD_n: .word n
LD_a: .word a
LC_invite : .word chaine_invite
LC_resultat1 : .word chaine_resultat1
LC_resultat2 : .word chaine_resultat2

