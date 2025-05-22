#ifndef _OPERATIONS_ENS_H_
#define _OPERATIONS_ENS_H_

#include "sac.h"
#include "type_ensemble.h"

/* Initialisations d'ensembles à partir d'un sac */
/* Ensemble vide */
void init_vide(ensemble *ens, sac *s);

/* Ensemble contenant tous les éléments du sac */
void init_plein(ensemble *ens, sac *s);

/* Ensemble défini par la liste des indices de ses éléments dans le
   sac, liste saisie au clavier et précédée du cardinal de
   l'ensemble.
   Attention : les valeurs correspondantes aux indices doivent être
   toutes différentes (pas de vérification lors de la saisie)
*/
void init_saisie(ensemble *ens, sac *s);

/* Ensemble aléatoire (attention : tirage non uniforme) */
void init_alea(ensemble *ens, sac *s);

/* Affichage des éléments d'un ensemble */
void afficher_ensemble(ensemble *ens);

/* Opérations classiques sur les ensembles */
/* Appartenance de l'élément x à l'ensemble ens */
int appartient(int x, ensemble *ens);
/* Égalité de deux ensembles */
int egal(ensemble *ens1, ensemble *ens2);
/* Intersection de deux ensembles : le résultat est affecté au
   paramètre ens_res */
void intersection(ensemble *ens1, ensemble *ens2, ensemble *ens_res);
/* Union de deux ensembles : le résultat est affecté au paramètre
   ens1 */
void union_ens(ensemble *ens1, ensemble *ens2);

#endif /* _OPERATIONS_ENS_H_ */
