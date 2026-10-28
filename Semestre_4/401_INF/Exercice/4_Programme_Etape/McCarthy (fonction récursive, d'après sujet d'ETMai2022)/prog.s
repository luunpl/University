@ GESTION DES PARTIES CONDITIONNELLES
@ Le programme ci-dessous comporte des parties conditionnelles 
@ Selon la condition, votre code, un code C ou un code de référence (Ref) est utilisé
@ Pour utiliser/exécuter avec les codes en C ou Ref, enlever les @ ci-dessous (dé-commenter les #define), 
@ #define saisieC
@ #define appelRef
@ #define fonctionRef
@ #define affichageC
@ Pour utiliser/exécuter votre code en ARM, remettre les @ ci-dessus (commenter les #define) 
@ lors des tests automatiques, ces #define seront définis par le programme de test
@ les codes C et Ref dans les parties conditionnelles ne sont disponibles que dans les parties conditionnelles 
@ les codes C et Ref dans les parties conditionnelles ne sont disponibles que quand la condition est valide
@ vous pouvez vous inspirer des codes C pour produire vos codes ARM 


     .data
x: .word 999
y: .word 999
chaine_saisie: .asciz "(ARM) Donner un nombre :\n"
chaine_appel: .asciz "(ARM) Appel de la fonction\n"
chaine_fonction: .asciz "(ARM) Code de la fonction\n"
chaine_affichage: .asciz "(ARM) Resultat :\n"

     .text
     .global main
     .global f91
     .global x
     .global y

main: 
  push {lr}
  bl affichageImmediat_C

#ifdef saisieC
  bl saisie_C  @ ne fonctionne que si saisieC est defini
#else  
  @ saisie d'un nombre
  ldr R1, LC_saisie
  bl EcrChn
  @ completer ici par votre code pour la saisie


  @ fin de votre code de saisie
#endif

  
#ifdef appelRef
#include "appel_Ref.s"  @ ne fonctionne que si appelRef est defini
#else
  ldr R1, LC_appel
  bl EcrChn
  @ completer ici par votre code pour l'appel


  @ fin de votre code d'appel
#endif

#ifdef affichageC
  bl affichage_C  @ ne fonctionne que si affichageC est defini
#else
  @ affichage du resultat
  ldr R1, LC_affichage
  bl EcrChn
  @ completer ici par votre code pour l'affichage
 

  @ fin de votre code d'affichage
#endif

fin: 
  mov R0, #0
  pop {lr}
  bx lr

LD_x: .word x
LD_y: .word y
LC_saisie : .word chaine_saisie
LC_appel : .word chaine_appel
LC_fonction : .word chaine_fonction
LC_affichage : .word chaine_affichage
  

f91: 
#ifdef fonctionRef
#include "fonction_Ref.s"  @ ne fonctionne que si fonctionRef est defini
#else
  @ code de la fonction
  @ completer ici par le code de votre fonction


  @ fin du code de votre fonction
#endif

bl exit @au cas où !