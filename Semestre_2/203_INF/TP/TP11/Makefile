all: interpreteur main_test_vars

interpreteur: variables.o lignes.o systeme.o interpreteur.o
	clang -o interpreteur variables.o lignes.o systeme.o interpreteur.o

main_test_vars: variables.o main_test_vars.o
	clang -o main_test_vars variables.o main_test_vars.o

interpreteur.o: interpreteur.c systeme.h lignes.h debug.h variables.h \
  variables_base.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c interpreteur.c

main_test_vars.o: main_test_vars.c variables.h variables_base.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c main_test_vars.c

lignes.o: lignes.c lignes.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c lignes.c

variables.o: variables.c debug.h variables.h variables_base.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c variables.c

systeme.o: systeme.c systeme.h debug.h
	clang -Wall -Werror -Wno-unused -g -DDEBUG -c systeme.c

clean:
	rm *.o interpreteur main_test_vars
