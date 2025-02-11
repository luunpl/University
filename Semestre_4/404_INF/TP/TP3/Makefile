
essai_ast: ast_construction.o  ast_parcours.o  essai_ast.o  
	gcc -g -Wall -o essai_ast ast_construction.o  ast_parcours.o  essai_ast.o


ast_construction.o: ast_construction.c type_ast.h
	gcc -g -Wall -c ast_construction.c

ast_parcours.o: ast_parcours.c type_ast.h
	gcc -g -Wall -c ast_parcours.c

essai_ast.o: essai_ast.c  ast_construction.h  ast_parcours.h  type_ast.h
	gcc -g -Wall -c essai_ast.c

clean:
	rm *.o essai_ast

