
#include "operations_ens.h"
#include <stdio.h>
#include <stdlib.h>

/* Initialisations d'ensembles à partir d'un sac */
/* Ensemble vide */
void init_vide(ensemble *ens, sac *s) {
  ens->valeurs = s;
  ens->card = 0;
}

/* Ensemble contenant tous les éléments du sac */
void init_plein(ensemble *ens, sac *s) {
  int k, n;
  int i, j;
  int x;

  ens->valeurs = s;
  n = 0;
  for (i = 0; i < s->taille; i++) {
    for (j = 0; j < s->taille; j++) {
      x = s->tab[i][j];
      k = 0;
      while ((k < n) && (s->tab[ens->indices[k].a][ens->indices[k].b] != x)) {
        k = k + 1;
      }
      if (k == n) {
        n = n + 1;
        ens->indices[k].a = i;
        ens->indices[k].a = j;
      }
    }
  }
  ens->card = n;
}

/* Ensemble défini par la liste des indices de ses éléments dans le
   sac, liste saisie au clavier et précédée du cardinal de
   l'ensemble.
   Attention : les valeurs correspondantes aux indices doivent être
   toutes différentes (pas de vérification lors de la saisie)
*/
void init_saisie(ensemble *ens, sac *s) {
  int n;
  int i;

  ens->valeurs = s;
  printf("Saisie des couples d'indices des éléments d'un ensemble\n");
  do {
    printf("  Entrer le cardinal de l'ensemble (dans l'intervalle [%d, %d]) : ",
           0, nbvaleurs_sac(s));
    scanf("%d", &n);
  } while ((n < 0) || (n > nbvaleurs_sac(s)));
  ens->card = n;
  for (i = 0; i < n; i++) {
    printf("  Entrer les indices a et b de l'élément %d : ", i + 1);
    scanf("%d %d", &(ens->indices[i].a), &(ens->indices[i].b));
  }
}

/* Ensemble aléatoire (attention : tirage non uniforme) */
void init_alea(ensemble *ens, sac *s) {
  int k, n;
  int i, j;
  int x;

  ens->valeurs = s;
  ens->card = rand() % nbvaleurs_sac(s);
  /* si le cardinal "aléatoire" est plus grand que le nombre
     d'éléments différents dans V... ça boucle... s'il en est proche,
     c'est très long... */
  n = 0;
  while (n < ens->card) {
    i = rand() % taille_sac(s);
    j = rand() % taille_sac(s);
    x = s->tab[i][j];
    k = 0;
    while ((k < n) && (s->tab[ens->indices[k].a][ens->indices[k].b] != x)) {
      k = k + 1;
    }
    if (k == n) {
      ens->indices[n].a = i;
      ens->indices[n].b = j;
      n = n + 1;
    }
  }
}

/* Affichage des éléments d'un ensemble */
void afficher_ensemble(ensemble *ens) {
  int i, n;

  n = ens->card;

  printf("{ ");
  for (i = 0; i < (n - 1); i++) {
    printf("%d,", ens->valeurs->tab[ens->indices[i].a][ens->indices[i].b]);
    if (((i + 1) % 20) == 0) {
      printf("\n");
    }
  }
  if (n != 0) {
    printf("%d",
           ens->valeurs->tab[ens->indices[n - 1].a][ens->indices[n - 1].b]);
  }
  printf(" }");
}

/* Opérations classiques sur les ensembles */
/* Appartenance de l'élément x à l'ensemble ens */
int appartient(int x, ensemble *ens) {
  int k;
  k = 0;
  while ((k < ens->card) &&
         (ens->valeurs->tab[ens->indices[k].a][ens->indices[k].b] != x)) {
    k = k + 1;
  }
  return (k < ens->card);
}

/* Égalité de deux ensembles */
int egal(ensemble *ens1, ensemble *ens2) {
  int i, k;
  int eg;

  if (ens1->card != ens2->card) {
    eg = 0;
  } else {
    eg = 1;
    for (i = 0; i < ens1->card; i++) {
      k = 0;
      while ((k < ens2->card) &&
             (ens2->valeurs->tab[ens1->indices[i].a][ens2->indices[k].b] !=
              ens1->valeurs->tab[ens2->indices[k].a][ens1->indices[i].b])) {
        k = k + 1;
      }
      eg = (k < ens2->card);
    }
  }
  return eg;
}

/* Intersection de deux ensembles : le résultat est affecté au
   paramètre ens_res */
void intersection(ensemble *ens1, ensemble *ens2, ensemble *ens_res) {
  int n, i, k;

  ens_res->valeurs = ens1->valeurs;
  n = 0;
  for (i = 0; i < ens1->card; i++) {
    k = 0;
    while ((k < (ens2->card - 1)) &&
           (ens2->valeurs->tab[ens2->indices[k].a][ens2->indices[k].b] !=
            ens1->valeurs->tab[ens1->indices[i].a][ens1->indices[i].b])) {
      k = k + 1;
    }
    if (k < (ens2->card - 1)) {
      n = n + 1;
      ens_res->indices[n].a = ens1->indices[i].a;
      ens_res->indices[n].b = ens1->indices[i].b;
    }
  }
  ens_res->card = n;
}

/* Union de deux ensembles : le résultat est affecté au paramètre
   ens1 */
void union_ens(ensemble *ens1, ensemble *ens2) {
  int i, k;

  for (i = 0; i < ens2->card; i++) {
    k = 0;
    while ((k < ens1->card) &&
           (ens1->valeurs->tab[ens1->indices[k].a][ens1->indices[k].b] !=
            ens2->valeurs->tab[ens2->indices[i].a][ens2->indices[i].b])) {
      k = k + 1;
    }
    if (ens1->valeurs->tab[ens1->indices[k].a][ens1->indices[k].b] !=
        ens2->valeurs->tab[ens2->indices[i].a][ens2->indices[i].b]) {
      ens1->indices[ens1->card].a = ens2->indices[k].a;
      ens1->indices[ens1->card].b = ens2->indices[k].b;
      ens1->card = ens1->card + 1;
    }
  }
}
