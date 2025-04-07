#include <stdio.h>

/* Rétro-Ingéniérie, calcul naïf de la racine carré entière d'un nombre (librement inspiré d'un exercice issu d'un partiel)
 *
 * Le code ARM ci-après donne dans R4 le résultat du calcul de la racine carrée entière d'un nombre donné dans R7.
 *
 *    mov r4,#1
 * tq: 
 *    mul r5,r4,r4
 *    cmp r5,r7
 *    bgt finTq
 *    add r4,r4,#1
 *    b tq
 * finTq: 
 *    sub r4,r4,#1
 *
 * Traduire en C ce programme.
 */
 
int main() {
     int R4, R5, R7;
     
printf("Donner un entier : ");
scanf("%d",&R7);

/****************************
 * debut de votre programme *
 ****************************/






/**************************
 * fin de votre programme *
 **************************/
 printf("Resultat : %d\n",R4);
 return 0;
 }


