#ifndef __ANALYSE_SYNTAXIQUE__
#define __ANALYSE_SYNTAXIQUE__

void erreur_syntaxique(char *message);

int Evaluer(int vald, char op, int valg);

void Rec_eaep(int *sous_resultat);

void analyser(char *fichier, int *resultat) ;

#endif