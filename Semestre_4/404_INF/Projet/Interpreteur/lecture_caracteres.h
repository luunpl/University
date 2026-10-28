#ifndef __LEC_CAR__
#define __LEC_CAR__

/* ------------------------------------------------------------------------
-- Module: lecture_caracteres
--
-- Description: Gestion d'une séquence de caractères.
--
-- J-P. Peyrin, G. Serasset (version initiale) : janvier 1999
-- P. Habraken : 12 novembre 2002
-- L. Mounier (version C) : août 2016
------------------------------------------------------------------------ */

void demarrer_car(char *nom_fichier);
// e.i. : Indifférent
// e.f. : La séquence de caractères est accessible dans le fichier désigné
//        par nom_fichier.
//        fin_de_sequence vaut vrai ou alors caractere_courant est le
//        premier caractère de la séquence.

void avancer_car();
// Pré-condition : La séquence de caractères est accessible.
// e.i. : fin_de_sequence = faux ;
//        On pose i = rang du caractère courant.
// e.f. : fin_de_sequence vaut vrai ou alors caractere_courant est le
//        caractère de rang i+1 dans la séquence.

char caractere_courant();
// Pré-condition : La séquence de caractères est accessible.
// caractere_courant est le caractère de rang i.
// Pré-condition : La machine séquentielle est démarrée et
// fin_de_sequence = faux.

int fin_de_sequence_car();
// Pré-condition : La séquence de caractères est accessible.
// fin_de_sequence vaut vrai <=> Tous les caractères de la séquence
// ont été lus.
// Pré-condition : La machine séquentielle est démarrée.

unsigned int numero_ligne();
// Pré-condition : La séquence de caractères est accessible.
// Numéro de la ligne où se trouve le caractère courant.
// Pré-condition : La machine séquentielle est démarrée et
// fin_de_sequence = faux.

unsigned int numero_colonne();
// Pré-condition : La séquence de caractères est accessible.
// Numéro de la colonne où se trouve le caractère courant.
// Pré-condition : La machine séquentielle est démarrée et
// fin_de_sequence = faux.

void arreter_car();
// Pré-condition : La séquence de caractères est accessible.
// e.i. : Indifférent
// e.f. : La séquence de caractères n'est plus accessible.

#endif 
