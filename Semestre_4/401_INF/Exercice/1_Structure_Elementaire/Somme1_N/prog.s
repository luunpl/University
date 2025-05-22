    .data
n: .word 0
somme: .word 0
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

  @ calcul de la somme des entiers 1..n
    
  @ A COMPLETER


  @ impression de la somme
    ldr r1, LD_resultat
	bl EcrChn
    ldr r1, LD_somme
    ldr r1, [r1]
    bl EcrZdecimal32


fin: 
   mov R0, #0
   pop {lr}
   bx lr

LD_n: .word n
LD_somme: .word somme
LD_invite: .word invite
LD_resultat: .word resultat

