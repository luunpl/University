    .data
n: .word 0
invite: .asciz "Votre texte ? "
resultat: .asciz "Resultat : "

    .bss
texte: .skip 100 

    .text
    .global main
main:
   push {lr}
   
  @ saisie de la chaine de caractere d'adresse texte
    ldr r1, LD_invite
	bl EcrChaine
    ldr r1, LD_texte
	bl LireChaine

  @ calcul du nombre de mots de la chaine lue
    
  @ A COMPLETER


  @ impression du resultat
    ldr r1, LD_resultat
	bl EcrChn
    ldr r1, LD_n
    ldr r1, [r1]
    bl EcrZdecimal32


fin: 
   mov R0, #0
   pop {lr}
   bx lr

LD_n: .word n
LD_texte: .word texte
LD_invite: .word invite
LD_resultat: .word resultat
