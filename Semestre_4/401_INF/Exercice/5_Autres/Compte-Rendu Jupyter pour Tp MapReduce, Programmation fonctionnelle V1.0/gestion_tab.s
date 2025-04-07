         .data
entier:  .byte    0              @ entiers de la sequence

         .text
         .global  saisir_tab, afficher_tab

@ procedure saisir_tab : saisit une sequence d'entiers
@ r0 = T : adresse de debut du tableau contenant la sequence
@ r1 = N : nombre d'elements de la sequence
@ algorithme : i parcourant 0 .. N - 1 : Lire8(T[i])

saisir_tab:
         push {lr}               @ sauvegarde adresse de retour
         push {r1}               @ sauvegarde temporaires
         push {r2}
         push {r5}
         push {r6}

         mov      r5, #0         @ indice dans le tableau
         mov      r6, r1         @ nombre d'elements

tantque1:
         cmp      r5, r6
         beq      fintq1
         ldr      r1, LD_entier @ lire un entier
         bl       Lire8
         ldrb     r2, [r1]
         strb     r2, [r0, r5]   @ le ranger dans le tableau
         add      r5, r5, #1     @ octet suivant
         bal      tantque1
fintq1:
         pop      {r6}           @ restauration temporaires
         pop      {r5}
         pop      {r2}
         pop      {r1}
         pop      {lr}           @ restauration adresse de retour
         bx       lr             @ retour a l'appelant
LD_entier:
         .word    entier

@ procedure afficher_tab : affiche une sequence d'entiers
@ r0 = T : adresse de debut du tableau contenant la sequence
@ r1 = N : nombre d'elements de la sequence
@ algorithme : i parcourant 0 .. N - 1 : EcrNdecimal8(T[i])

afficher_tab:
         push {lr}               @ sauvegarde adresse de retour
         push {r1}               @ sauvegarde temporaires
         push {r5}
         push {r6}
         push {r7}

         @ corps de la procedure
         mov      r5, #0         @ indice dans tableau
         mov      r6, r0         @ adresse de debut
         mov      r7, r1         @ taille du tableau

tantque2:
         cmp      r5, r7
         beq      fintq2
         ldrb     r1, [r6, r5]   @ on recupere l'octet courant
         bl       EcrNdecim32    @ qui est imprime
         mov      r1, #' '
         bl       EcrCar         @ en le separant du suivant par un espace
         add      r5, r5, #1     @ octet suivant
         bal      tantque2

fintq2:
         bl       AlaLigne
         pop      {r7}           @ restauration temporaires
         pop      {r6}
         pop      {r5}
         pop      {r1}
         pop      {lr}           @ restauration adresse de retour
         bx       lr             @ retour a l'appelant
