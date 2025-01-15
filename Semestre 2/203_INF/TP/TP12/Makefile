interpreteur: interpreteur.o systeme.o variables.o lignes.o commandes.o
	clang -o interpreteur interpreteur.o systeme.o variables.o lignes.o commandes.o

systeme.o: systeme.c systeme.h debug.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c systeme.c

variables.o: variables.c debug.h variables.h variables_base.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c variables.c

lignes.o: lignes.c lignes.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c lignes.c

interpreteur.o: interpreteur.c systeme.h lignes.h debug.h variables.h \
  variables_base.h commandes.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c interpreteur.c

commandes.o: commandes.c debug.h commandes.h systeme.h interpreteur.h \
  lignes.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c commandes.c

clean:
	rm *.o interpreteur
