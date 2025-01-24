    .data
n: .word 0
f: .word 0
invite: .asciz "Votre entier ? "
resultat: .asciz "Resultat : "

    .text
    .global main
main:
   push {lr}
   
  @ saisie de n
    ldr r1, LD_invite
	bl EcrChn
    ldr r1, LD_n
	bl Lire32

  @ calcul de la factoriel de n
    
  @ A COMPLETER


  @ impression de la factoriel
    ldr r1, LD_resultat
	bl EcrChn
    ldr r1, LD_f
    ldr r1, [r1]
    bl EcrZdecimal32


fin: 
   mov R0, #0
   pop {lr}
   bx lr

LD_n: .word n
LD_f: .word f
LD_invite: .word invite
LD_resultat: .word resultat

