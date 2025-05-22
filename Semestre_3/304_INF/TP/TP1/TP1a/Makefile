##############################################################################################
# Makefile pour la compilation des programmes du TP1-a
##############################################################################################

all: essai_ligne_de_commande

##############################################################################################

essai_ligne_de_commande.o : essai_ligne_de_commande.c
	clang -c essai_ligne_de_commande.c

essai_ligne_de_commande : essai_ligne_de_commande.o
	clang essai_ligne_de_commande.o -o essai_ligne_de_commande

##############################################################################################

exercice1.o : exercice1.c
	clang -c exercice1.c

exercice1 : exercice1.o
	clang exercice1.o -o exercice1

##############################################################################################

exercice2 : exercice2.o
	clang exercice2.o -o exercice2

exercice2.o : exercice2.c
	clang -c  exercice2.c

##############################################################################################

exercice3 : exercice3.o
	clang exercice3.o -o exercice3

exercice3.o : exercice3.c
	clang -c exercice3.c

##############################################################################################

exercice4.o : exercice4.c
	clang -c exercice4.c

exercice4 : exercice4.o
	clang exercice4.o -o exercice4

##############################################################################################

exercice5.o : exercice5.c
	clang -c exercice5.c

exercice5 : exercice5.o
	clang exercice5.o -o exercice5

##############################################################################################
# nettoyage: suppressions des fichiers .o et executables
##############################################################################################

clean :
	rm -rf *.o essai_ligne_de_commande exercice{1,2,3,4,5}



