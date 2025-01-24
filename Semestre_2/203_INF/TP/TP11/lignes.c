/*
Interpréteur de commandes à but pédagogique
Copyright (C) 2011-2018 Guillaume Huard
Ce programme est libre, vous pouvez le redistribuer et/ou le modifier selon les
termes de la Licence Publique Générale GNU publiée par la Free Software
Foundation (version 2 ou bien toute autre version ultérieure choisie par vous).

Ce programme est distribué car potentiellement utile, mais SANS AUCUNE
GARANTIE, ni explicite ni implicite, y compris les garanties de
commercialisation ou d'adaptation dans un but spécifique. Reportez-vous à la
Licence Publique Générale GNU pour plus de détails.

Vous devez avoir reçu une copie de la Licence Publique Générale GNU en même
temps que ce programme ; si ce n'est pas le cas, écrivez à la Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
États-Unis.

Contact: Guillaume.Huard@imag.fr
	 Bâtiment IMAG
	 700 avenue centrale, domaine universitaire
	 38401 Saint Martin d'Hères
*/


#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "lignes.h"

int lire_ligne_fichier(FILE * fichier, char *ligne) {
/*************** A COMPLETER ******************/
    /*
       Lecture d'une ligne depuis un fichier avec stockage de la ligne lue
       dans la variable ligne. Ne pas inclure le '\n' final dans la variable
       ligne, ne pas oublier de completer la ligne avec un '\0' terminal.
       La valeur de retour doit etre 0 s'il n'y a plus rien a lire (fin de
       fichier sans avoir lu aucun caractere) et 1 sinon.
     */
/**********************************************/
    return 0;
}

void decouper_ligne(char *ligne, char *ligne_decoupee[]) {
/*************** A COMPLETER ******************/
    /* 
       Decoupage de la ligne : chaque mot devient une chaine, c'est-a-dire
       est termine par '\0'. ligne_decoupee contient les adresses de ces mots,
       et se termine par NULL (s'il y a N mots, ligne_decoupee[0] pointe sur
       le premier mot et ligne_decoupee[N] vaut NULL.
       L'algorithme consiste a parcourir la variable ligne en reperant
       les debuts et les fins de mots (les mots sont separes par des espaces).
       Au debut d'un mot, on garde son adresse dans ligne_decoupee.
       A la fin d'un mot, on remplace le 1er espace qui le suit par '\0'
     */
/**********************************************/
    // A remplacer : cette solution temporaire ne découpe rien, elle ne
    // fonctionne qu'avec les commandes sans argument
    ligne_decoupee[0] = ligne;
    ligne_decoupee[1] = NULL;
}

