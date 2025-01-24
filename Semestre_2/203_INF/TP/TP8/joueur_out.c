#include <stdio.h>
#include "joueurs.h"
#include "joueurs_out.h"

void ecrire_les_joueurs(joueurs *ens, char *nom_fich) {
    // Ouvrir le fichier, mode erciture
    FILE *fichier = fopen(nom_fich, "w");
    
    // Vérification
    if (fichier == NULL) {
        fprintf(stderr, "Erreur lors de l'ouverture du fichier %s\n", nom_fich);
        return;
    }
    
    // Écrire le nombre de joueurs dans le fichier
    fprintf(fichier, "%d\n", ens->nb);
    
    // Parcourir tous les joueurs et les écrire dans le fichier
    for (int i = 0; i < ens->nb; i++) {
        fprintf(fichier, "%s %d\n", ens->T[i].pseudo, ens->T[i].nb_billes);
    }
    
    // Fermer le fichier
    fclose(fichier);
}

void ecrire_les_elements(joueurs *e, int ens[], char *nom_fich) {
    // Ouvrir le fichier en mode écriture
    FILE *fichier = fopen(nom_fich, "w");
    
    // Vérifier si le fichier est ouvert avec succès
    if (fichier == NULL) {
        fprintf(stderr, "Erreur lors de l'ouverture du fichier %s\n", nom_fich);
        return;
    }
    
    // Écrire le nombre d'éléments à écrire dans le fichier
    int nb_elements = sizeof(ens) / sizeof(ens[0]);
    fprintf(fichier, "%d\n", nb_elements);
    
    // Parcourir les elem
    for (int i = 0; i < nb_elements; i++) {
        int index_joueur = ens[i];
        fprintf(fichier, "%s %d\n", e->T[index_joueur].pseudo, e->T[index_joueur].nb_billes);
    }
    
    // Fermer 
    fclose(fichier);
}
