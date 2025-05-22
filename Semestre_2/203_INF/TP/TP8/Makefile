CC=clang
CFLAGS=-Wall -g

IO=$(patsubst %.c, %.o, $(wildcard joueurs_*.c))

billes: billes.o generer_entier.o joueurs.o $(IO)
	$(CC) -o $@ $^

gestion: gestion.o joueurs_in.o joueurs_out.o operations.o
	$(CC) -o $@ $^

clean:
	-rm billes gestion *.o