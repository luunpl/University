#include <stdio.h>
#include <stdlib.h>

#include "variables.h"

int main(int argc, char *argv[]) {
    int i;
    char val[512];
    variables vars;

    if (argc < 2) {
        printf("ce programme necessite un argument au moins\n");
        exit(1);
    }

    init_variables(&vars);
    for (i = 1; i < argc; i++) {
        printf("Valeur de %s ?\n", argv[i]);
        scanf("%s", val);
        ajouter_variable(&vars, argv[i], val);
    }

    printf("Ensemble de variables :\n");
    afficher_ensemble_variables(&vars);

    printf("Recherche des variables :\n");
    for (i = 1; i < argc; i++) {
        int indice = trouver_variable(&vars, argv[i]);
        if (indice == -1) {
            printf("PROBLEME ! %s n'a pas ete trouvee dans la table\n", argv[i]);
        } else {
            printf("%s vaut %s\n", nom_variable(&vars, indice), valeur_variable(&vars, indice));
        }

    }
    int indice = ajouter_variable(&vars, argv[1], "INF123 C'est SUPER !!!");

    printf("%s\n", valeur_variable(&vars, indice));
    return 0;
}
