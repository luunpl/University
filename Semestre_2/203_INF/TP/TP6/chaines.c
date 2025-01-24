#include <stdio.h>
#include <string.h>
#include "generer_entier.c"
#include "bouts_de_phrases.c"

/* longueur de la chaine passee en parametre */
unsigned long mon_strlen(char *ch) {
	int i=0 ;
	/* A COMPLETER */
	return i ;
}

int main() {
	char chaine[50] ;
	unsigned long mon_resultat ;

	printf("un mot (pas trop long !) à mesurer ?\n") ;
	scanf("%49s", chaine) ;
	mon_resultat=mon_strlen(chaine) ;
	if (mon_resultat == strlen(chaine) )
		printf("longueur de la chaine %s :%lu\n", chaine, mon_resultat) ;
	else
		printf("non, la longueur de '%s' n'est pas %lu\n", chaine, mon_resultat) ;

	return 0 ;
}
