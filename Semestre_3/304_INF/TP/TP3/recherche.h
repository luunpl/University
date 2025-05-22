#ifndef _RECHERCHE_H_
#define _RECHERCHE_H_

/* Recherche la sous-chaîne sc dans la chaîne c
   Renvoie :
   - l'indice du début de sc dans c si sc est une sous-chaîne de c
   - -1 si sc n'est pas une sous-chaîne de c
   Précondition : sc n'est pas vide (strlen(sc) > 0)
 */
int recherche(char *c, char *sc);

#endif
