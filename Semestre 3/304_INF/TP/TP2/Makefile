CC=clang -g

all: exec_test_tri

exec_test_tri.o: exec_test_tri.c test_tri.h tri.h es_tableau.h type_tableau.h
	$(CC) -c exec_test_tri.c

test_tri.o: test_tri.c tri.h es_tableau.h type_tableau.h
	$(CC) -c test_tri.c

es_tableau.o: es_tableau.c type_tableau.h
	$(CC) -c es_tableau.c

type_tableau.o: type_tableau.c type_tableau.h
	$(CC) -c type_tableau.c

tri.o: tri.c tri.h type_tableau.h
	$(CC) -c tri.c

exec_test_tri: exec_test_tri.o test_tri.o es_tableau.o type_tableau.o tri.o
	$(CC) exec_test_tri.o test_tri.o es_tableau.o type_tableau.o tri.o -o exec_test_tri

clean:
	rm -f exec_test_tri *.o
