calculette: calculette.o analyse_lexicale.o analyse_syntaxique.o lecture_caracteres.o
	gcc -g -Wall -o calculette calculette.o analyse_lexicale.o analyse_syntaxique.o lecture_caracteres.o

test_lexeme: analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o
	gcc -g -Wall -o test_lexeme analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o

analyse_lexicale.o: analyse_lexicale.c analyse_lexicale.h lecture_caracteres.h
	gcc -g -Wall -c analyse_lexicale.c

lecture_caracteres.o: lecture_caracteres.h lecture_caracteres.c
	gcc -g -Wall -c lecture_caracteres.c

analyse_syntaxique.o: analyse_syntaxique.h analyse_lexicale.h analyse_syntaxique.c
	gcc -g -Wall -c analyse_syntaxique.c

test_lexeme.o: analyse_lexicale.h
	gcc -g -Wall -c test_lexeme.c

calculette.o: calculette.c analyse_lexicale.h analyse_syntaxique.h
	gcc -g -Wall -c calculette.c

clean:
	rm -f  test_lexeme *.o
	rm -f  calculette *.o


