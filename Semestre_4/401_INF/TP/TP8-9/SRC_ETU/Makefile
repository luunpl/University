CC=/opt/gnu/arm/bin/arm-eabi-gcc
AS=/opt/gnu/arm/bin/arm-eabi-gcc

C_NEGATIF:=
# Comment the following lines to compile your assembler functions instead of the C one
C_NEGATIF+=-DC_NEG_OCTET
C_NEGATIF+=-DC_NEG_IMAGE


C_SYMETRY:=
# Comment the following lines to compile your assembler functions instead of the C one
C_SYMETRY+=-DC_SYMETRIE_OCTET
C_SYMETRY+=-DC_PERMUTER_COLS
C_SYMETRY+=-DC_SYMETRIE_AXE_V
C_SYMETRY+=-DC_PERMUTER_LIGNES
C_SYMETRY+=-DC_SYMETRIE_AXE_H

CFLAGS=-Wall -gdwarf-2 ${C_NEGATIF} ${C_SYMETRY}


# Object files created from C source code
C_OBJS = afficher_contenu.o main.o tabsym.o negatif.o symetrie.o multiplication.o

# Object files created from .S source code
C_ASM_OBJS = afficher_contenu_asm.o main_asm.o tabsym_asm.o negatif_asm.o symetrie_asm.o multiplication_asm.o


# Replace afficher_contenu.o by afficher_contenu_asm.o to test your own assembler code of afficher_contenu 
OBJS= afficher_contenu.o main.o tabsym.o negatif.o negatif_asm.o symetrie.o symetrie_asm.o multiplication.o


all:	transformer

clean:
	/bin/rm -rf *.o image_bits_include.h image_bits_content.c

image_bits_include.h:	image_test.bm
	./extract_image.sh $^             

image_bits_content.c:	image_test.bm
	./extract_image.sh $^            

multiplication.o:	multiplication.s
	${CC} ${CFLAGS} -c $< -o $@

transformer:	${OBJS}
	${CC} ${OBJS} -o $@

main.o:	commun.h image_bits_include.h main.c image_bits_content.c

%_asm.o:	%_asm.S image_bits_include.h Makefile
	${CC} ${CFLAGS} -c $< -o $@

%.o:	%.c image_bits_include.h commun.h Makefile
	${CC} ${CFLAGS} -c $< -o $@

