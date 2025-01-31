   .data
debutTAB: .skip 5*4

   .text
   .global main
main:
   ldr r0, ptr_debutTAB

     mov r3, #11                @ val <- 11
     mov r2, #0                 @ i <- 0
tq:  cmp r2, #5                 @ i-5 ??
     beq fintq
        @ i-5 <> 0
        ldr r0, ptr_debutTAB        @ r0 <- debutTAB
        add r0, r0, r2, LSL #2  @ r0 <- r0 + r2*4 = debutTAB + i*4
        str r3, [r0]            @ MEM[debutTAB+i*4] <- val
        add r2, r2, #1          @ i <- i + 1
        add r3, r3, #11         @ val <- val + 11
     b   tq
fintq:  @ i-5 = 0

fin:  BX LR

ptr_debutTAB : .word debutTAB

