@ Programme tabmult : Affiche les tables de multiplication de de 1 a 10
N_MAX= 10
   .data
barre :  .byte '|'
         .byte 0
espace : .byte ' '
         .byte 0
tirets : .asciz "---"

debutTab:    .skip N_MAX*N_MAX*4   @ adresse du debut du tableau

   .text
   .global main
main: 
  push {lr}

    @ affichage du tableau vide
        @ a completer...

    @ remplissage du tableau (en memoire [et affichage de la memoire])
        @ a completer...

    @ affichage du tableau rempli
        @ a completer...

fin: 
  mov R0, #0
  pop {lr}
  bx lr

ptr_debutTab : .word debutTab
adr_barre :    .word barre
adr_espace :   .word espace
adr_tirets :   .word tirets
