    .data
n: .word 0
chaine_invite: .asciz "Donner un nombre : "
chaine_resultat: .asciz "Resultat : "
chaine_fin: .asciz "xxx"

   .text
   .global main
main: 
  push {lr}
  ldr R1, LC_invite
  bl EcrChn
  ldr R1, LD_n
  bl Lire32
  ldr R1, LC_resultat
  bl EcrChaine
tq:

  @ ajouter ici un appel à la procedure etoile suivi d'un appel à la procédure AlaLigne




  ldr R1, LC_fin
  bl EcrChaine
  ldr R0, LD_n
  ldr R1, [R0]
  sub R1, R1, #1
  str R1, [R0]
  cmp R1, #0
  bne tq
  pop {lr}
  BX lr

LD_n: .word n
LC_invite : .word chaine_invite
LC_resultat : .word chaine_resultat
LC_fin : .word chaine_fin

etoile: 
  push {lr}
  ldr R0, LD_stderr 
  ldr R0, [R0] 
  ldr R1, LD_S
  ldr R2, LC_Msg1
  bl fprintf
  mov R0, #131072
  bl usleep
  ldr R0, LD_stderr 
  ldr R0, [R0] 
  ldr R1, LD_S
  ldr R2, LC_Msg2
  bl fprintf
  mov R0, #131072
  bl usleep
  ldr R0, LD_stderr 
  ldr R0, [R0] 
  ldr R1, LD_S
  ldr R2, LC_Msg3
  bl fprintf
  mov R0, #131072
  bl usleep
  ldr R0, LD_stderr 
  ldr R0, [R0] 
  ldr R1, LD_S
  ldr R2, LC_Msg4
  bl fprintf
  mov R0, #131072
  bl usleep
  ldr R0, LD_S
  ldr R1, LC_Msg5
  bl printf
  mov R0, #131072
  bl usleep

  mov R0, #0
  pop {lr}
  BX lr

LC_Msg1 : .word Msg1
LC_Msg2 : .word Msg2
LC_Msg3 : .word Msg3
LC_Msg4 : .word Msg4
LC_Msg5 : .word Msg5
LD_S    : .word S
LD_stderr : .word stderr

   .data
S:    .asciz "%s"
Msg1: .asciz "\r | "
Msg2: .asciz "\r / "
Msg3: .asciz "\r---"
Msg4: .asciz "\r \\ "
Msg5: .asciz "\r X"

