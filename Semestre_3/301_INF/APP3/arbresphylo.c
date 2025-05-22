#include "arbresphylo.h"
#include "arbres.h"
#include "listes.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/* ACTE I */
void analyse_arbre(arbre racine, int *nb_esp, int *nb_carac)
{ // Cas vide
   if (racine == NULL)
   {
      *nb_esp = 0;
      *nb_carac = 0;
      return;
   }
   // Cas d'une feuille
   if (racine->gauche == NULL && racine->droit == NULL)
   {
      *nb_esp = 1;
      *nb_carac = 0;
      return;
   }
   // Cas normal
    int nb_esp_gauche, nb_carac_gauche;
    int nb_esp_droit, nb_carac_droit;
    analyse_arbre(racine->gauche, &nb_esp_gauche, &nb_carac_gauche);
    analyse_arbre(racine->droit, &nb_esp_droit, &nb_carac_droit);
    *nb_esp = nb_esp_gauche + nb_esp_droit;
    *nb_carac = nb_carac_gauche + nb_carac_droit + 1;
}

/* ACTE IB */
// Rappel commande : dot -Tpng -o arbre.png arbre.dot
void conversion_algo(arbre a, FILE *f){
    if (a == NULL){
        return;
    } if (a->droit != NULL){
        fprintf(f, "%s -> %s [label = \"oui\"]\n", a->valeur, a->droit->valeur);
        conversion_algo(a->droit, f);
    } if (a->gauche != NULL){
        fprintf(f, "%s -> %s [label = \"non\"]\n", a->valeur, a->gauche->valeur);
        conversion_algo(a->gauche, f);
    }
}

void conversion(arbre a, FILE *f){
    // Écriture de l'en-tête du fichier
    fprintf(f, "digraph arbre {\n");
    //  Appel de la fonction récursive
    conversion_algo(a, f);
    // Écriture de la fin du fichier
    fprintf(f, "}");
}

/* ACTE II */
/* Recherche l'espece dans l'arbre. Modifie la liste passée en paramètre pour y
 * mettre les caractéristiques. Retourne 0 si l'espèce a été retrouvée, 1 sinon.
 */
int est_Feuille(arbre a)
{
    return !(a->gauche) && !(a->droit);
}

int rechercher_espece(arbre racine, char* espece, liste_t* seq) {
    if (racine == NULL) {
        return 1; // Cas vide 
    }
    else if (est_Feuille(racine)){
        if (strcmp(racine->valeur, espece) == 0) {
            liberer_liste(seq);
            return 0;
        } else { 
            return 1;
            }
    } else {
        // Recherche dans les sous-arbres gauche et droit
        if (rechercher_espece(racine->gauche, espece, seq) == 0) {
            return 0; 
        } else if (rechercher_espece(racine->droit, espece, seq) == 0) {
            ajouter_tete(seq, racine->valeur);
            return 0; 
        } 
        return 1; 
    }
}

/* ACTE III */
/* Doit renvoyer 0 si l'espece a bien ete ajoutee, 1 sinon, et ecrire un
 * message d'erreur.
 */
int ajouter_espece (arbre* a, char *espece, cellule_t* seq) {
    assert(a != NULL);

    if (*a == NULL && seq == NULL){
        // Arbre et liste vides, on insère l'espèce
        noeud *nouvelle_branche = nouveau_noeud();
        nouvelle_branche->valeur = espece;
        (*a) = nouvelle_branche;
        return 0;
    } else if (*a == NULL && seq != NULL) {
        // Arbre vide mais liste non vide
        noeud *nouvelle_branche = nouveau_noeud();
        nouvelle_branche->valeur = strdup(seq->val);
        (*a) = nouvelle_branche;
        return ajouter_espece(&((*a)->droit), espece, seq->suivant);
    } else if ((*a)->droit == NULL && (*a)->gauche == NULL && seq == NULL) {
        // Liste vide mais arbre est une espèce, erreur
        printf("Il y a déjà une espèce dans l'arbre avec toutes les mêmes caractéristiques!");
        return 1;
    } else if ((*a)->droit == NULL && (*a)->gauche == NULL && seq != NULL) {
        // Atteint une espèce et liste non vide, ajouter caractéristique et mettre l'espèce à gauche
        noeud *nouvelle_branche = nouveau_noeud();
        nouvelle_branche->valeur = strdup(seq->val);
        nouvelle_branche->gauche = *a;
        (*a) = nouvelle_branche;
        return ajouter_espece(&((*a)->droit), espece, seq->suivant);
    } else if ( seq != NULL && (strcmp((*a)->valeur, seq->val) == 0) ) {
        // Atteint la caractéristique dans la liste, aller à droite
        return ajouter_espece(&((*a)->droit), espece, seq->suivant);
    } else if (seq != NULL  && (strcmp((*a)->valeur, seq->val) != 0) ) {
        // Atteint une caractéristique non dans la liste, aller à gauche
        return ajouter_espece(&((*a)->gauche), espece, seq);
    } else if ( seq == NULL && ((*a)->droit != NULL || (*a)->gauche != NULL) ) {
        // Atteint une caractéristique et liste vide, aller à gauche
        return ajouter_espece(&((*a)->gauche), espece, seq);
    }
    assert(0);
}

/* ACTE IIIB */
/* Doit afficher la liste des caractéristiques niveau par niveau, de gauche
 * à droite, dans le fichier fout.
 * Appeler la fonction avec fout=stdin pour afficher sur la sortie standard.
 */
void afficher_par_niveau(arbre racine, FILE* fout) {
    // Nous implémentons une recherche en largeur sur l'arbre pour l'imprimer
    arbre file[100000]; // tableau pour les références aux branches que nous voulons imprimer
    file[0] = racine;

    if (racine == NULL) { return; } // Cas vide

    // Initialisation des index que nous utilisons pour suivre les bords des couches
    int debut_couche = 0, fin_couche = 1;
    int debut_prochaine_couche = 0, fin_prochaine_couche = 1;

    // Initialisation des arbres courant, gauche et droit pour la recherche;
    arbre courant, gauche, droit;
    // Commencer à boucler sur les couches
    while (debut_prochaine_couche != fin_prochaine_couche) {
        // Tant que la taille de la couche n'est pas 0, c'est-à-dire que nous n'avons pas atteint la fin de l'arbre
        debut_prochaine_couche = fin_couche;

        for (int i = debut_couche; i < fin_couche; i++) {
            courant = file[i];

            gauche = courant->gauche;
            if (gauche != NULL) {
                file[fin_prochaine_couche] = gauche;
                fin_prochaine_couche++;
            }

            droit = courant->droit;
            if (droit != NULL) {
                file[fin_prochaine_couche] = droit;
                fin_prochaine_couche++;
            }

            if (gauche != NULL || droit != NULL) {
                fprintf(fout, "%s ", courant->valeur);
            }
        }
        assert(debut_prochaine_couche == fin_couche);
        debut_couche = fin_couche;
        fin_couche = fin_prochaine_couche;
        fprintf(fout, "\n");
    } 
}

/* ACTE IV */
arbre clone_arbre(arbre a) {
    if (a == NULL) {
        return NULL;
    }
    arbre new_node = nouveau_noeud();
    new_node->valeur = strdup(a->valeur);
    new_node->gauche = clone_arbre(a->gauche);
    new_node->droit = clone_arbre(a->droit);
    return new_node;
}

bool est_dans_liste(char* nom_animal, cellule_t* seq){
   for(cellule_t* i = seq; i != NULL; i = i->suivant){
      if (strcmp(i->val, nom_animal) == 0) {return true;}
   }
   return false;
}

arbre* trouver_sous_arbre_despeces(arbre* a, cellule_t* seq){
   assert(a != NULL);

   if (*a == NULL){
      return a;
   } else if (a != NULL && (*a)->droit == NULL && (*a)->gauche == NULL) {
      if ( est_dans_liste((*a)->valeur, seq) ){
         return a;
      } else {
         arbre* vide = (arbre*) malloc(sizeof(arbre));
         *vide = NULL;
         return vide;
      }
   } else if (a != NULL && ((*a)->droit != NULL || (*a)->gauche != NULL)){
      arbre* abr_gauche = &((*a)->gauche);
      arbre* abr_droit = &((*a)->droit);

      arbre* res_gauche = trouver_sous_arbre_despeces(abr_gauche, seq);
      arbre* res_droit = trouver_sous_arbre_despeces(abr_droit, seq);

      if (res_gauche == NULL || res_droit == NULL){
         return NULL;
      } else if (res_gauche == abr_gauche && res_droit == abr_droit) {
         return a;
      } else if (*res_gauche == NULL){
         return res_droit;
      } else if (*res_droit == NULL){
         return res_gauche;
      } else if (res_gauche != NULL && res_droit != NULL){
         return NULL;
      }
      assert(false);
   }
   assert(false);
   return 0;
}

int ajouter_carac(arbre* a, char* carac, cellule_t* seq) {
    assert(a != NULL);

    if (*a == NULL){
        return 1;
    }

    arbre* ancetre_commun = NULL;

    if (seq != NULL){
        ancetre_commun = trouver_sous_arbre_despeces(a, seq);
        if (ancetre_commun == NULL){
            printf("Ne peut ajouter %s: ne forme pas un sous-arbre.", carac);
            return 0;
        }  
    }

    if (*ancetre_commun == NULL){
        arbre nouvelle_branche = nouveau_noeud();
        nouvelle_branche->valeur = strdup(carac);
        nouvelle_branche->gauche = *a;
        a = &nouvelle_branche;
    }else{
        arbre nouvelle_branche = clone_arbre(*ancetre_commun);
        (*ancetre_commun)->valeur = strdup(carac);
        (*ancetre_commun)->droit = nouvelle_branche;
        (*ancetre_commun)->gauche = NULL;
    }
    return 1;
}
