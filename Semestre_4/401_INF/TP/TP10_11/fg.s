         .global plus_un, carre
         .global somme, produit
         .text
@ fonction plus_un : incremente l'entier passe en parametre
@ r3 : donnee
@ r4 : resultat
plus_un: add      r4, r3, #1
         bx       lr

@ fonction carre : eleve au carre l'entier passe en parametre
@ r3 : donnee
@ r4 : resultat
carre:   
         push {lr}               @ sauvegarde adresse de retour
         push {r0}               @ sauvegarde temporaires
         push {r1}
         push {r2}

         mov      r0, r3
         mov      r1, r3
         bl       mult
         mov      r4, r0

         pop      {r2}           @ restauration temporaires
         pop      {r1}
         pop      {r0}
         pop      {lr}           @ restauration adresse de retour
         bx       lr             @ retour a l'appelant

@ fonction somme : ajoute les deux entiers passes en parametre
@ r0, r1 : donnees
@ r2 : resultat
somme:   add      r2, r0, r1
         bx       lr

@ fonction produit : multiplie les deux entiers passes en parametre
@ r0, r1 : donnees
@ r2 : resultat

         @@@@@@@@@@@@@
         @ A COMPLETER
         @@@@@@@@@@@@@
	