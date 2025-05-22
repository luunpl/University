CC=arm-linux-gnueabi-gcc


CFLAGS=-static -Wall -gdwarf-2 ${C_NEGATIF} ${C_SYMETRY}


# Object files created from C source code
C_OBJS = afficher_contenu.o main.o tabsym.o negatif.o symetrie.o 

# Object files created from .S source code
C_ASM_OBJS = negatif_asm.o symetrie_asm.o 


OBJS= afficher_contenu.o main.o tabsym.o negatif.o negatif_asm.o symetrie.o symetrie_asm.o 


all:	transformer

clean:
	/bin/rm -rf *.o

transformer:	${OBJS}
	${CC} ${CFLAGS} ${OBJS} -o $@

main.o:	commun.h image_bits_include.h main.c image_bits_content.c

%_asm.o:	%_asm.S image_bits_include.h Makefile
	${CC} ${CFLAGS} -c $< -o $@

%.o:	%.c image_bits_include.h commun.h Makefile
	${CC} ${CFLAGS} -c $< -o $@

