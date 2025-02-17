    .data
DW:    .word  0
DH:    .hword 0
DB:    .byte 0

    .text
    .global main
main:
      LDR r0, LD_DW
      LDR r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal32

      MOV r4, #-10
      LDR r5, LD_DW
      STR r4, [r5]

      LDR r0, LD_DW
      LDR r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal32
    
    @ === Manipulation du mot de 16 bits (DH) ===
      LDR r0, LD_DH
      LDRH r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal16

      MOV r4, #-10
      LDR r5, LD_DH
      STRH r4, [r5]

      LDR r0, LD_DH
      LDRH r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal16

    @ === Manipulation du mot de 8 bits (DB) ===
      LDR r0, LD_DB
      LDRB r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal8

      MOV r4, #-10
      LDR r5, LD_DB
      STRB r4, [r5]

      LDR r0, LD_DB
      LDRB r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal8

fin:  B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_DW:   .word DW
LD_DH:   .word DH
LD_DB:   .word DB
