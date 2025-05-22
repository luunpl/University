#ifndef _SAC_H_
#define _SAC_H_

/* Taille maximum pour un sac */
#define TAILLE_MAX 50

/* type sac : matrice carrée implémentée dans un tableau de tableaux d'entiers
 */
typedef struct {
  /* Taille du sac = n pour un sac de n*n valeurs */
  int taille;
  /* Valeurs du sac : tableau de tableaux d'entiers */
  int tab[TAILLE_MAX][TAILLE_MAX];
} sac;

/* Initialise une structure de sac s à partir du fichier de nom f_nom */
void initialiser_sac(sac *s, char *f_nom);

/* Taille du sac (n) */
int taille_sac(sac *s);

/* Nombre de valeurs du sac (n*n) */
int nbvaleurs_sac(sac *s);

/* Affichage du sac s à l'écran */
void afficher_sac(sac *s);

#endif /* _SAC_H_ */
