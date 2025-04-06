    .data
invite: .asciz "Votre texte ?"
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

  @ impression de la chaine lue
    ldr r1, LD_texte
	bl EcrChaine
  @ modification de la chaine => minuscules
  @ A COMPLETER


  @ impression de la chaine minuscules
    ldr r1, LD_texte
	bl EcrChaine
  @ modification de la chaine => première lettre Majuscule, le reste minuscule
  @ A COMPLETER


  @ impression de la chaine première lettre Majuscule, le reste minuscule
    ldr r1, LD_texte
	bl EcrChaine
  @ modification de la chaine => Majuscule
  @ A COMPLETER


  @ impression de la chaine Majuscule
    ldr r1, LD_texte
	bl EcrChaine

fin: 
   mov R0, #0
   pop {lr}
   bx lr

LD_invite: .word invite
LD_texte: .word texte

