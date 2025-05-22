    .data
longueur: .word -1
invite: .asciz "Votre texte ?"
rappel: .asciz "Votre texte :"
resultat: .asciz "Resultat :"

    .bss
texte: .skip 100 

    .text
    .global main
main:
   push {lr}
   
  @ saisie de la chaine de caractere d'adresse cc
    ldr r1, LD_invite
	bl EcrChaine
    ldr r1, LD_texte
	bl LireChaine

  @ calcul de la longueur de la chaine lue
    
  @ A COMPLETER


  @ impression de la chaine et de sa longueur
    ldr r1, LD_rappel
	bl EcrChaine
    ldr r1, LD_texte
	bl EcrChaine
    ldr r1, LD_resultat
	bl EcrChaine
    ldr r1, LD_longueur
    ldr r1, [r1]
    bl EcrZdecimal32


fin: 
   mov R0, #0
   pop {lr}
   bx lr

LD_longueur: .word longueur
LD_texte: .word texte
LD_invite: .word invite
LD_rappel: .word rappel
LD_resultat: .word resultat

