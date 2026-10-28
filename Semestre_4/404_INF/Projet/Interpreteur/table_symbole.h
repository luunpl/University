#ifndef ___TS___
#define ___TS___

#define LIDF 20       // Nombre maximum de caractères pour un IDF
#define NBMAXSYMB 100 // Nombre maximum d'IDF

typedef struct {
   char nom[LIDF]; // Nom d'un identificateur
   int valeur;     // Valeur de cet identificateur
} Couple;

extern Couple TS[NBMAXSYMB];
extern int NbSymb; // Le nombre courant de couples dans la table

int initTS();
// Initialise la TS en affectant 0 à NbSymb

extern void afficheTS(Couple TS[], int NbSymb);
// Affiche le contenu complet de la TS

extern int estPresentTS(char *idf, int *v, Couple TS[], int NbSymb);
// Si un couple (idf, v') est présent dans la table alors
//      affecte v' à *v
//      estPresentTS renvoie vrai
// Sinon
//      estPresentTS renvoie faux

extern int estPresentTS2(char *idf, Couple TS[], int NbSymb);
// Si idf est présent dans la TS, renvoie vrai sinon renvoie faux
// Pas de nouvelle valeur affectée à idf

extern void insererTS(char *idf, int v, Couple TS[], int *NbSymb);
// Si un couple (idf, v') est présent dans la table alors
//      remplace la valeur v' par v
// Sinon
//      ajoute le couple (idf, v) dans la TS

#endif
