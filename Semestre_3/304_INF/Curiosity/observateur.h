#ifndef _OBSERVATEUR_H_
#define _OBSERVATEUR_H_

typedef enum{ A, G, D, M } Alphabet;

typedef enum{ Init, Mes, Erreur } Etat;

/* Renvoie l’état initial de l’automate */
Etat initial();

/* Fonction de transition de l’automate */
Etat transition(Etat e, Alphabet c);

int est_final(Etat e);

#endif