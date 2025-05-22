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


/* initialisation d'un ensemble de variables a l'ensemble vide */
void init_variables(variables *ens);

/* ajout d'une variable dans un ensemble de variables si elle n'y est pas deja,
 * ecrase sa valeur sinon. Dans tous les cas renvoie l'indice de la variable dans
 * l'ensemble */
int ajouter_variable(variables *ens, char *nom, char *valeur);

/* cardinal d'un ensemble de variables */
int nombre_variables(variables *ens);

/* recherche de l'indice d'une variable dans un ensemble, -1 si la variable n'est
 * pas presente dans l'ensemble */
int trouver_variable(variables *ens, char *nom);

/* variable d'indice i (NULL si cette variable n'existe pas dans l'ensemble) */
char *nom_variable(variables *ens, int i);

/* valeur de la variables a l'indice i ("" si inexistant) */
char *valeur_variable(variables *ens, int i);

/* met a jour la valeur de la variable d'indice i (sans effet si indice invalide) */
void modifier_valeur_variable(variables *ens, int i, char *valeur);
