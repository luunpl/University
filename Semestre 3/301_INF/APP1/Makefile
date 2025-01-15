# Si clang non trouvé, possible d'utiliser gcc
CC=clang
CFLAGS=-g -Wall -Wextra -Werror -gdwarf-4

EXEC=projetX crypteMove planB BayOfPigs OneMillion crypteSeq Northwoods

# Utilisé uniquement si exécution sur Caseine.
# Pour changer le programme lancé par Caseine, modifiez la ligne ci-dessous

all: $(EXEC)

client-interactif: client-interactif.o client.o

client-tutoriel: client-tutoriel.o client.o

client.o: client.c client.h

client-tutorielFORT: client-tutorielFORT.o client.o

fonction.o: fonction.c fonction.h

projetX : projetX.o client.o fonction.o

crypteMove: crypteMove.o client.o fonction.o

OneMillion: OneMillion.o client.o fonction.o

BayOfPigs: BayOfPigs.o client.o fonction.o

planB: planB.o client.o fonction.o

crypteSeq: crypteSeq.o client.o fonction.o

Northwoods: Northwoods.o client.o

clean:
	rm -f *.o

clear:
	rm -f $(EXEC)

.PHONY: clear clean main
