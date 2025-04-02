
#ifndef ___TS___
#define ___TS___

#define LIDF 20  // nombre maximum de caractéres pour un IDF 
#define NBMAXSYMB 100  // nombre maximum d'IDF 

typedef struct {
   char nom[LIDF] ; // nom d'un identificateur
   int valeur ;     // valeur de cet identificateur
} Couple ;
extern Couple TS[NBMAXSYMB];
extern int NbSymb;
		        // le nombre courant de couples dans la table

 int initTS() ; 
// intialise la TS en effectant 0 à NbSymb

extern void afficheTS(Couple TS[], int NbSymb);
 // affiche le contenu complet de la TS 

 extern int estPresentTS(char *idf, int *v,Couple TS[], int NbSymb) ;
// si un couple (idf, v') est present dans la table alors 
//      affecte v' à *v 
//      estPresentTS renvoie vrai
// sinon
//      estPresentTS renvoie faux

extern int estPresentTS2(char *idf,Couple TS[], int NbSymb);
// si idf est present dans la TS, renvoie vrai sinon renvoie faux
// pas de nouvelle valeur affectée a idf


 extern void insererTS(char *idf, int v,Couple TS[], int *NbSymb) ;
// si un couple (idf,v') est present dans la table alors 
//      remplace la valeur v' par v 
// sinon
//      ajoute le couple (idf,v) dans la TS

#endif