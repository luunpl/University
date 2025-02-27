
# Exemple de Makefile permettant de générer test_lexeme et calculette_v1
#  selon 2 scénarios :
#     - soit avec une lecture de caractères et une analyse lexicale écrite à la main
#     - soit en générant automatiquenent l'analyse lexicale avec flex
#
#     pour compiler sans utiliser flex :
#     		make clean ; make calculette
#     	      ou
#     		make clean ; make test_lexeme
#
#     pour compiler en produisant l'analyse lexicale avec flex :
#     		make FLEX=1 clean ; make FLEX=1 calculette
#     	      ou
#     		make FLEX=1 clean ; make FLEX=1 test_lexeme
#
# Remarque : 
# 	- le fichier analyse_lexical.c fourni initialement contient l'analyse lexicale écrite à la main,
# 	   directement utilisable pour compiler sans utiliser flex
# 	- lorsque l'on utilise flex  un nouveau fichier analyse_lexicale.c est généré 
# 		automatiquement à partir de calc-v1.l (et les fichiers lecture_caracteres.* ne sont pas nécessaires)
# 	- le fichier analyse_lexicale.h est utilisé dans les 2 sénarios
# 	- le fichier analyse_lexicale_manuelle.c est une "sauvegarde" du fichier analyse_lexicale.c fourni initialement
#


ifndef FLEX
	
	# régles de compilation lorsque l'on n'utilise pas flex

calculette: calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o lecture_caracteres.o 
	gcc -g -Wall -o calculette calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o lecture_caracteres.o

test_lexeme: analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o
	gcc -g -Wall -o test_lexeme analyse_lexicale.o  lecture_caracteres.o  test_lexeme.o

analyse_lexicale.o: analyse_lexicale.c analyse_lexicale.h lecture_caracteres.h
	gcc -g -Wall -c analyse_lexicale.c

lecture_caracteres.o: lecture_caracteres.h lecture_caracteres.c
	gcc -g -Wall -c lecture_caracteres.c

clean:
	rm -f  calculette test_lexeme *.o
else
	# régles de compilation lorsque l'on utilise flex

calculette: calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o 
	gcc -g -Wall -o calculette calculette.o analyse_syntaxique.o analyse_lexicale.o ast_construction.o ast_parcours.o

test_lexeme: analyse_lexicale.o  test_lexeme.o
	gcc -g -Wall -o test_lexeme test_lexeme.o analyse_lexicale.o

analyse_lexicale.o: analyse_lexicale.c analyse_lexicale.h
	gcc -g -c analyse_lexicale.c

analyse_lexicale.c : calculette.l analyse_lexicale.h
	flex -o analyse_lexicale.c calculette.l

clean:
	rm -f  calculette test_lexeme analyse_lexicale.c lex.yy.c test_lexeme *.o
endif

# règles de compilation communes aux deux scenarios

ast_construction.o: ast_construction.c ast_construction.h type_ast.h
	gcc -c ast_construction.c

ast_parcours.o: ast_parcours.c ast_parcours.h type_ast.h
	gcc -c ast_parcours.c

calculette.o: calculette.c analyse_syntaxique.h
	gcc -g -Wall -c calculette.c

test_lexeme.o: test_lexeme.c analyse_lexicale.h
	gcc -g -c test_lexeme.c

analyse_syntaxique.o: analyse_syntaxique.c analyse_lexicale.h ast_construction.h type_ast.h ast_parcours.h
	gcc -g -Wall -c analyse_syntaxique.c


