###############################################################################
# Makefile pour la compilation du programme transformation_image
###############################################################################

all : transformation_image

###############################################################################
# compilation séparée des packages (modules)
###############################################################################

type_image.o : type_image.h type_image.c
	clang -c type_image.c

operations_image.o : operations_image.h operations_image.c type_image.h
	clang -c operations_image.c

image_io.o : image_io.h image_io.c type_image.h
	clang -c image_io.c

transformation_image.o : transformation_image.c type_image.h \
			 operations_image.h image_io.h
	clang -c transformation_image.c

###############################################################################
# Edition de lien des modules séparés
# pour la création du programme exécutable transformation_image
###############################################################################

transformation_image : transformation_image.o type_image.o operations_image.o image_io.o
	clang transformation_image.o type_image.o operations_image.o image_io.o -o transformation_image


###############################################################################
# nettoyage : suppression des fichiers .o et transformation_image
###############################################################################
clean :
	rm -rf *.o transformation_image

