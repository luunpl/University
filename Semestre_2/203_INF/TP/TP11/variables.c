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
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "debug.h"
#include "variables.h"

void init_variables(variables * ens) {
/*************** A COMPLETER ******************/
    /* 
       Initialiser a un ensemble vide.
     */
/**********************************************/
}

int ajouter_variable(variables * ens, char *nom, char *valeur) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui affecte la valeur donnee au nom de variable donne.
       Si la variable existe deja dans les variables definies, il suffit juste
       de changer sa valeur. Dans le cas contraire, il faut l'ajouter aux
       variables definies : ajouter un couple (nom, valeur) a l'ensemble
       de variables. Dans tous les cas, la fonction retourne l'indice de la
       variable ajoutée.
     */
/**********************************************/
    return -1;
}

int nombre_variables(variables * ens) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui renvoie le nombre de variables dans l'ensemble.
     */
/**********************************************/
    return 0;
}

int trouver_variable(variables * ens, char *nom) {
    int i = 0;

/*************** A COMPLETER ******************/
    /*
       Fonction qui recherche le nom de variable dans l'ensemble
       des variables definies. Si le nom est trouve, la fonction retourne
       l'indice correspondant dans le tableau, dans le cas
       contraire elle retourne -1.
     */
/**********************************************/
    return i;
}

char *nom_variable(variables * ens, int i) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui renvoie le nom de la variable a l'indice i ou
       NULL si elle n'existe pas.
     */
/**********************************************/
    return NULL;
}

char *valeur_variable(variables * ens, int i) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui renvoie la valeur de la variable a l'indice i ou
       "" si elle n'existe pas.
     */
/**********************************************/
    return "";
}

void modifier_valeur_variable(variables * ens, int i, char *valeur) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui modifie la valeur de la variable a l'indice i.
       Comportement indeterminee si l'indice i n'est pas valide.
     */
/**********************************************/
}

void afficher_ensemble_variables(variables * ens) {
    for (int i = 0; i < nombre_variables(ens); i++) {
        printf("%s=%s\n", nom_variable(ens, i), valeur_variable(ens, i));
    }
}

int trouver_et_appliquer_affectation_variable(variables * ens, char *ligne) {
/*************** A COMPLETER ******************/
    /*
       Fonction qui cherche a reconnaitre une affectation de variable dans le 
       morceau de ligne de commande transmise et, le cas echeant, l'applique. 
       Pour cela il faut determiner si ce morceau de
       ligne est de la forme :
       nom=valeur
       Cette fonction est destructive : elle modifie ligne lorsqu'elle
       trouve une affectation. Retourne 1 en cas d'affectation trouvee, 0 dans le
       cas contraire.
     */
/**********************************************/
    return 0;
}

void appliquer_expansion_variables(variables * ens, char *ligne_originale, char *ligne_expansee) {
/*************** A COMPLETER ******************/
/*
  Fonction qui prend une ligne lue en parametre et la recopie dans le tableau
  resultat en remplacant toutes les utilisations de variable (de la forme
  '$nom' ou nom est une chaine de caracteres alphanumeriques ou * ou #) par la
  valeur de la variable correspondante.
*/
/**********************************************/
    // A remplacer : le code ci-dessous n'expanse rien
    strcpy(ligne_expansee, ligne_originale);
}

void affecter_variables_automatiques(variables *ens, int argc, char *argv[]) {
/*************** A COMPLETER ******************/
    /*
       Il faut definir les variables automatiques a partir des arguments
       donnes au programme :
       - placer la valeur de chacun des arguments transmis au programme dans la
       variable correspondante ($0, $1, $2, ...)
       - construire au fur et a mesure une chaine de caractere contenant toutes
       les valeurs et l'affecter a $*
       - affecter le nombre d'arguments a $#
     */
/**********************************************/
}
