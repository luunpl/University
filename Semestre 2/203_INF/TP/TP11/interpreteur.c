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
#include <sys/stat.h>
#include <ctype.h>

#define NOMBRE_MAX_ARGUMENTS 1024
#define TAILLE_MAX_NB_ARGS 16

#include "systeme.h"
#include "lignes.h"
#include "debug.h"
#include "variables.h"

variables vars;

int executer_ligne_commande(char *ligne_courante) {
    char *ligne_decoupee[NOMBRE_MAX_ARGUMENTS];
    int commande_terminee;
    int resultat_commande;
    char ligne_expansee[TAILLE_MAX_LIGNE];

    commande_terminee = 0;

    if (!commande_terminee) {
        /*
           Pour la gestion des variables, nous ajoutons une expansion de
           variable avant decouper_ligne (les variables sont remplacees par leur
           valeur)
         */
        appliquer_expansion_variables(&vars, ligne_courante, ligne_expansee);
        decouper_ligne(ligne_expansee, ligne_decoupee);
        /* Si la ligne est vide apres decoupage, on ne fait plus rien */
        commande_terminee = (ligne_decoupee[0] == NULL);
    }
    /*
       Nous commencons par traiter le cas de l'affectation de variable :
       - une analyse de la ligne de commande
       - une execution de la suite conditionnee par le fait que la ligne de
       commande n'est pas une affection de variable
     */
    if (!commande_terminee) {
        if (trouver_et_appliquer_affectation_variable(&vars, ligne_decoupee[0])) {
            if (ligne_decoupee[1] != NULL)
                fprintf(stderr, "Erreur : elements supplementaires apres l'affectation ignores\n");
            commande_terminee = 1;
        }
    }

    if (!commande_terminee) {
        /* Execution d'une commande externe */
        if (ligne_decoupee[0] != NULL) {
            resultat_commande = executer_ligne_decoupee(ligne_decoupee);
            return resultat_commande;
        }
    }
    return 0;
}

int main(int argc, char *argv[]) {
    int fini, ligne_lue;
    char ligne_courante[TAILLE_MAX_LIGNE];
    FILE *fichier;

    init_variables(&vars);
    affecter_variables_automatiques(&vars, argc, argv);

    if (argc > 1) {
        fichier = fopen(argv[1], "r");
        if (fichier == NULL) {
            perror("Erreur d'ouverture du fichier d'entree");
            exit(2);
        }
    } else {
        fichier = stdin;
    }

    fini = 0;
    while (!fini) {
        ligne_lue = lire_ligne_fichier(fichier, ligne_courante);
        fini = (ligne_lue == 0);
        if (!fini) {
            debug("Ligne lue : %s\n", ligne_courante);
            executer_ligne_commande(ligne_courante);
        }
    }

    return 0;
}
