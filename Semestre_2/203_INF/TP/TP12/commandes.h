/*
Interpréteur de commandes à but pédagogique
Copyright (C) 2011-2018 Guillaume Huard
Ce programme est libre, vous pouvez le redistribuer et/ou le modifier selon les
termes de la Licence Publique Générale GNU publiée par la Free Software
Foundation (version 2 ou bien toute autre version ultérieure choisie par vous).

Ce programme est distribué car potentiellement utile, mais SANS AUCUNE
GARANTIE, ni explicite ni implicite, y compris les garanties de
commercialisation ou d'adaptation dans un but spécifique. Reportez-vous à la
Licence Publique Générale GNU pour plus de détails.

Vous devez avoir reçu une copie de la Licence Publique Générale GNU en même
temps que ce programme ; si ce n'est pas le cas, écrivez à la Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
États-Unis.

Contact: Guillaume.Huard@imag.fr
	 Bâtiment IMAG
	 700 avenue centrale, domaine universitaire
	 38401 Saint Martin d'Hères
*/


#ifndef __COMMANDES_H__
#define __COMMANDES_H__

#define NB_MAX_ETATS 128
#define NB_MAX_ENTREES 128

typedef struct {
	int etat;
        int nb_etats;
        int etat_initial;
        int transitions[NB_MAX_ETATS][NB_MAX_ENTREES];
        int sortie[NB_MAX_ETATS][NB_MAX_ENTREES];
	int ligne_boucle;
        } automate;

void init_automate_commandes(automate *A)  ;
int analyse_commande_interne(automate *A, char *ligne_courante);

#endif
