all: main


CC=clang

## Flags de compilation en mode debug, convient pour presque tout l'APP
CFLAGS+= -g -Wall -Wextra -Werror -Wno-unused-parameter -gdwarf-4

## Flags de compilation pour les tests de performance.
## A decommenter pour desactiver tous les affichages, puis forcer la 
## recompilation avec 'make -B'
## ou bien faire 'make silent' dans un terminal
# CFLAGS=-O3 -g -Wall -Wextra -Werror -DSILENT -Wno-unused-parameter -gdwarf-4



# Ici, on utilise l'"intelligence" de 'make' qui saura tout seul
# comment créer les .o à partir des .c
main: main.o curiosity.o listes.o interprete.o

silent:
	CFLAGS=-DSILENT make -B all


clean:
	rm -f main *.o

.PHONY: all silent clean
