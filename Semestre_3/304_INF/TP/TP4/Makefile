###############################################################################
# Makefile pour la compilation des programmes 
###############################################################################

#### options de compilation ####
LDFLAGS=
CFLAGS= -Wall

#### variables ####
CC = clang 
LD = clang

EXECUTABLES = test_commandes_pile test_type_pile_entiers \
 test_commandes_calculette calculette

all : $(EXECUTABLES)



###############################################################################
# compilation separee des packages (modules)
###############################################################################

commandes_pile.o : commandes_pile.c commandes_pile.h

commandes_calculette.o : commandes_calculette.c commandes_calculette.h

type_pile.o : type_pile.c type_pile.h

test_commandes_pile.o : test_commandes_pile.c commandes_pile.h

test_commandes_calculette.o : test_commandes_calculette.c \
 commandes_calculette.h

test_type_pile_entiers.o : test_type_pile_entiers.c commandes_pile.h \
 type_pile.h

calculette.o : calculette.c commandes_calculette.h type_pile.h

%.o: %.c
	$(CC) -c $(CFLAGS) $<


###############################################################################
# edition de lien des modules separes 
# pour la creation des programmes executables 
###############################################################################

test_commandes_pile : test_commandes_pile.o commandes_pile.o 

test_commandes_calculette : test_commandes_calculette.o commandes_calculette.o

test_type_pile_entiers : test_type_pile_entiers.o commandes_pile.o type_pile.o

calculette : calculette.o commandes_calculette.o type_pile.o 

%: %.o
	$(LD) $(LDFLAGS) $^ -o $@

###############################################################################
# nettoyage : suppression des fichiers .o et des executables
###############################################################################

clean :
	rm -rf *.o $(EXECUTABLES)
