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
    ens->nb = 0;
}

int ajouter_variable(variables * ens, char *nom, char *valeur) {
    int i;

    i = trouver_variable(ens, nom);
    if (i == -1) {
        i = ens->nb;
        strcpy(ens->T[i].nom, nom);
        ens->nb++;
    }
    strcpy(ens->T[i].valeur, valeur);
    debug("Affectation de la variable %s a la valeur %s\n", nom, valeur);
    return i;
}

int nombre_variables(variables * ens) {
    return ens->nb;
}

int trouver_variable(variables * ens, char *nom) {
    int i = 0;

    debug("Je cherche la variable %s\n", nom);
    while ((i < nombre_variables(ens)) && (strcmp(nom, ens->T[i].nom) != 0))
        i++;
    if (i >= ens->nb) {
        debug("Je ne la trouve pas\n");
        i = -1;
    } else {
        debug("Je la trouve en position %d\n", i);
    }
    return i;
}

char *nom_variable(variables * ens, int i) {
    if ((i >= 0) && (i < ens->nb))
        return ens->T[i].nom;
    else
        return NULL;
}

char *valeur_variable(variables * ens, int i) {
    if ((i >= 0) && (i < ens->nb))
        return ens->T[i].valeur;
    else
        return "";
}

void modifier_valeur_variable(variables * ens, int i, char *valeur) {
    if ((i >= 0) && (i < ens->nb))
        strcpy(ens->T[i].valeur, valeur);
}

void afficher_ensemble_variables(variables * ens) {
    for (int i = 0; i < nombre_variables(ens); i++) {
        printf("%s=%s\n", nom_variable(ens, i), valeur_variable(ens, i));
    }
}

int trouver_et_appliquer_affectation_variable(variables * ens, char *ligne) {
    char *nom;
    char *nouvelle_valeur;

    debug("Est-ce une affectation de variable ?\n");
    nom = &ligne[0];
    nouvelle_valeur = index(ligne, '=');
    if (nouvelle_valeur != NULL) {
        debug("C'est une affectation de variable\n");
        nouvelle_valeur[0] = '\0';
        ajouter_variable(ens, nom, &nouvelle_valeur[1]);
        return 1;
    } else {
        debug("Ce n'est pas une affectation de variable\n");
        return 0;
    }
}

// etats de l'automate de gestion de l'expansion des variables
#define NORMAL 0
#define DOLLAR_VU 1
#define NOM_VARIABLE 2
#define VARIABLE_TROUVEE 3
#define BACKSLASH 4
#define QUOTE 5

void appliquer_expansion_variables(variables * ens, char *ligne_originale, char *ligne_expansee) {
    char *nom, *valeur, caractere_ecrase;
    int i, j;
    int etat = NORMAL;
    int fini=0;

    i = 0;
    j = 0;
    while (!fini) {
        switch (etat) {
        case DOLLAR_VU :
            // Ici on évite une copie en travaillant directement dans la ligne originale
            // Mais il faudra faire attention a ne pas perdre le caractère qui suit le nom
            nom = &ligne_originale[i];
            if ((ligne_originale[i] == '*') || (ligne_originale[i] == '#')) {
                // Dans le cas d'une variable automatique, on sait que le nom fait 1 caractère
                etat = VARIABLE_TROUVEE;
                break;
            }
            // Ici, pas de break, on profite de la structure switch (on passe au cas suivant) :
            // les transitions sortant de DOLLAR_VU sont les mêmes que celles
            // sortant de NOM_VARIABLE, on les traite donc avec le même code
        case NOM_VARIABLE:
            // Si le nom de variable est terminé, on passe dans le cas suivant en ne mettant pas de break
            // (la fin de NOM_VARIABLE correspond au même traitement que VARIABLE_TROUVEE)
            if (isalnum(ligne_originale[i])) {
                etat = NOM_VARIABLE;
                break;
            }
        case VARIABLE_TROUVEE:
            // Ici on sait que le caractère d'entrée est celui qui suit le nom
            // On le sauve durant l'expansion et on le restaure juste après
            caractere_ecrase = ligne_originale[i];
            ligne_originale[i] = '\0';
            if (nom[0] == '\0') {
                ligne_expansee[j] = '$';
                j++;
            } else {
                int indice = trouver_variable(ens, nom);
                valeur = valeur_variable(ens, indice);
                // Ici on privilegie la simplicite d'ecriture a l'efficacite
                strcpy(&ligne_expansee[j], valeur);
                j += strlen(valeur);
            }
            ligne_originale[i] = caractere_ecrase;
            // ici, pas de break : les transitions sortant de VARIABLE_TROUVEE sont les mêmes que celles
            // sortant de NORMAL, on les traite donc avec le même code
        case NORMAL :
            switch (ligne_originale[i]) {
            case '$':
                etat = DOLLAR_VU;
                break;
            case '\'':
                etat = QUOTE;
                break;
            case '\\':
                etat = BACKSLASH;
                break;
            default:
                ligne_expansee[j] = ligne_originale[i];
                j++;
                etat = NORMAL;
            }
            break;
        case BACKSLASH :
            ligne_expansee[j] = ligne_originale[i];
            j++;
            etat = NORMAL;
            break;
        case QUOTE :
            if (ligne_originale[i] == '\'')
                etat = NORMAL;
            else {
                ligne_expansee[j] = ligne_originale[i];
                j++;
            }
            break;
        }
        fini = ligne_originale[i] == '\0';
        i++;
    }
    debug("Ligne apres expansion : %s\n", ligne_expansee);
}

void affecter_variables_automatiques(variables *ens, int argc, char *argv[]) {
    /* Indice pour gerer les variables automatiques */
    int i;

    char nom_argument[TAILLE_MAX_NOM];
    char nombre_arguments[TAILLE_MAX_VALEUR];
    char tous_les_arguments[TAILLE_MAX_VALEUR];
    int premier;

    premier = 1;
    strcpy(tous_les_arguments, "");
    for (i = 1; i < argc; i++) {
        sprintf(nom_argument, "%d", i - 1);
        ajouter_variable(ens, nom_argument, argv[i]);
        if (i > 1) {
            if (!premier) {
                strcat(tous_les_arguments, " ");
            }
            strcat(tous_les_arguments, argv[i]);
            premier = 0;
        }
    }
    sprintf(nombre_arguments, "%d", argc - 2);
    ajouter_variable(ens, "#", nombre_arguments);
    ajouter_variable(ens, "*", tous_les_arguments);
}
