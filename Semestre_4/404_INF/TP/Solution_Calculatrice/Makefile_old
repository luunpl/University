all: test_lexeme calculette

lecture_caracteres.o: lecture_caracteres.h lecture_caracteres.c
	gcc -g -Wall -c lecture_caracteres.c

ast_construction.o: ast_construction.c ast_construction.h type_ast.h
	gcc -c ast_construction.c

ast_parcours.o: ast_parcours.c ast_parcours.h type_ast.h
	gcc -c ast_parcours.c

analyse_lexicale.o: analyse_lexicale.c analyse_lexicale.h lecture_caracteres.h
	gcc -g -Wall -c analyse_lexicale.c

test_lexeme.c: analyse_lexicale.h
	gcc -g -Wall -c test_lexeme.c

analyse_syntaxique.o: analyse_syntaxique.c analyse_lexicale.h ast_construction.h type_ast.h ast_parcours.h
	gcc -g -Wall -c analyse_syntaxique.c

test_lexeme: analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o
	gcc -g -Wall -o test_lexeme analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o

calculette: calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o lecture_caracteres.o 
	gcc -g -Wall -o calculette calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o lecture_caracteres.o

clean:
	rm -f  calculette test_lexeme *.o


