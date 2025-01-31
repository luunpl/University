   .data
debutTAB: .skip 5*4 @ reservation de 20 octets
                @ sans valeur initiale

   .text
   .global main
main:
   ldr r0, ptr_debutTAB
   mov r1, #11
   str r1, [r0]

   mov r1, #22
   add r0, r0, #4
   str r1, [r0]
   

   @ a completer

fin:  BX LR

ptr_debutTAB : .word debutTAB

