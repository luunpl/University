#ifndef __AUTOMATE__
#define __AUTOMATE__

#define NB_MAX_ETATS 128
#define NB_MAX_ENTREES 128
#define LG_MAX_SORTIE 128

typedef struct {
	int nb_etats ;
	int etat_initial ;
	int etats_finals[NB_MAX_ETATS] ;
	int transitions[NB_MAX_ETATS][NB_MAX_ENTREES] ;
	char sortie[NB_MAX_ETATS][NB_MAX_ENTREES][LG_MAX_SORTIE] ;
	} automate ;

void init_mon_automate(automate *A)  ;

void simule_automate(automate *A)  ;

#endif
