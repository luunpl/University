#include <stdio.h>


int main () {
	FILE *f ;
	char c ;

	f = fopen("Candide_chapitre1.txt", "r") ;
        if (f == NULL) {
		printf("%s n'a pas pu être ouvert en lecture\n", "Candide_chapitre1.txt") ;
		return 1 ;
		}
	
	fscanf(f, "%c", &c) ;
	while (!feof(f)) {
		printf("%c", c) ;	
		fscanf(f, "%c", &c) ;
		}

	fclose(f) ;
	return 0 ;
}
