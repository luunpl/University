   .data
invite: .asciz "Entrer un nombre : "
   .balign 4
m: .word 0
n: .word 0
r: .word 0

   .text
   .global main
   
ackermann:


    @ à compléter


	bx lr
  
main: 
    push {lr}

    
    @ à compléter
    
    
    mov R0, #0
    pop {lr}
    BX lr

LC_invite : .word invite
LD_m : .word m
LD_n : .word n
LD_r : .word r

