CC=clang 

all: ensembles

ensembles.o: operations_ens.h sac.h type_ensemble.h
	$(CC) -c ensembles.c

operations_ens.o: operations_ens.h
	$(CC) -c operations_ens.c operations_ens.h

sac.o: sac.h
	$(CC) -c sac.c 

ensembles: ensembles.o operations_ens.o sac.o
	$(CC) ensembles.o operations_ens.o sac.o -o ensembles

clean:
	rm -f ensembles *.o

