@ Algorithme de multiplication par addition et decalage
@ Principe : pour chaque bit i de a valant 1, ajouter b << i
@ int mult (int a, int b) {
@   int resultat=0; 
@   while (a != 0) {
@     if ((a & 1) != 0) {// ajouter b si a_0 == 1
@        resultat = resultat + b;}
@     b = b << 1; 
@     a = a >> 1;}  
@   return resultat; }

@ Convention d'appel :
@ en entree, a : r0 ; b : r1 ; 
@ variable locale : r2 (resultat [intermediaire]) 
@ valeur retour : r0 (attention, remplace le r0 en entree)

   .text
   .global   mult
mult:
   push {r1}
   push {r2}
   mov   r2,#0
   b     ctq 
tq: tst  r0,#1          
   addne r2,r2,r1       @ ajouter b si a_0 == 1
   mov   r1,r1, LSL #1
   mov   r0,r0, LSR #1
ctq: cmp r0,#0
   bne   tq
   mov   r0,r2
   pop {r2}
   pop {r1}
   bx lr
