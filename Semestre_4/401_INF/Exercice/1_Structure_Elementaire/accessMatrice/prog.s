     .data
i: .word 0
j: .word 0
v: .word 0
Pascal: .word 1         @[0,0]
          .word 1       @[0,1]
            .word 1     @[0,2]
              .word 1   @[0,3]
        .word 0         @[1,0]
          .word 1       @[1,1]
            .word 2     @ ...
              .word 3   @ ...
        .word 0         @[2,0]
          .word 0       @ ...
            .word 1
              .word 3
        .word 0         @[3,0]
          .word 0       @ ...
            .word 0
              .word 1
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat : "

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

  @ completer par v <- Pascal[i,j]

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

LD_i: .word i
LD_j: .word j
LD_v: .word v
LD_Pascal: .word Pascal
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat


