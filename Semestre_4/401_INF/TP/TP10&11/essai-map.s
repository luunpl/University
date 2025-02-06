         .set     NMAX, 10       @ nombre d'elements

         .data
invite1: .asciz   "Saisir une sequence de "
invite2: .asciz   " entiers :"
afftab1: .asciz   "Sequence donnee S :"
afftab2: .asciz   "map(S, plus_un) :"
afftab3: .asciz   "map(S, carre) :"
tab1:    .skip    NMAX           @ tableau de NMAX octets
tab2:    .skip    NMAX           @ tableau de NMAX octets

         .text
         .global  main
@ procedure principale
main:
         push {lr}               @ sauvegarde adresse de retour
         @ saisir la sequence donnee
         ldr      r1, LD_invite1
         bl       EcrChn
         mov      r1, #NMAX
         bl       EcrNdecim32
         ldr      r1, LD_invite2
         bl       EcrChaine
         ldr      r0, LD_tab1
         mov      r1, #NMAX
         bl       saisir_tab

         @ afficher la sequence donnee
         bl       AlaLigne
         ldr      r1, LD_afftab1
         bl       EcrChaine
         mov      r1, #NMAX
         bl       afficher_tab

         @ appel de la procedure map(tab1, NMAX, tab2, plus_un)
         @@@@@@@@@@@@@
         @ A COMPLETER
         @@@@@@@@@@@@@

         @ afficher la sequence resultat
         bl       AlaLigne
         ldr      r1, LD_afftab2
         bl       EcrChaine
         @@@@@@@@@@@@@
         @ A COMPLETER
         @@@@@@@@@@@@@

         @ appel de la procedure map(tab1, NMAX, tab2, carre)
         @@@@@@@@@@@@@
         @ A COMPLETER
         @@@@@@@@@@@@@

         @ afficher la sequence resultat
         bl       AlaLigne
         ldr      r1, LD_afftab3
         bl       EcrChaine
         @@@@@@@@@@@@@
         @ A COMPLETER
         @@@@@@@@@@@@@

         @ fin du programme principal
         pop      {lr}           @ restauration adresse de retour
         bx       lr             @ retour a l'appelant

@ adresses pour l'acces en zone data
LD_invite1:
         .word    invite1
LD_invite2:
         .word    invite2
LD_afftab1:
         .word    afftab1
LD_afftab2:
         .word    afftab2
LD_afftab3:
         .word    afftab3
LD_tab1:
         .word    tab1
LD_tab2:
         .word    tab2
LD_plus_un:
         .word    plus_un
LD_carre:
         .word    carre
