   .data
M: .asciz "Entrez un nombre"
   .bss
X: .word
TAB: .skip 400

   .text 
   .global main
main:
  push {lr}
            @ partie manquante

  mov R0, #0
  pop {lr}
  BX lr      bx lr

ptr_X: .word X
ptr_M: .word M
ptr_TAB: .word TAB
