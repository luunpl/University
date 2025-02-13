.data
DW:    .word  0
DH:    .hword 0
DB:    .byte 0

    .text
    .global main
main:
      @ Affichage de la valeur initiale à l'adresse DW
      LDR r0, LD_DW
      LDR r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal32

      @ Modification de la valeur à l'adresse DW
      MOV r4, #-10
      LDR r5, LD_DW
      STR r4, [r5]

      @ Affichage de la nouvelle valeur à l'adresse DW
      LDR r0, LD_DW
      LDR r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal32

      @ Affichage de la valeur initiale à l'adresse DH
      LDR r0, LD_DH
      LDRH r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal16

      @ Modification de la valeur à l'adresse DH
      MOV r4, #42
      LDR r5, LD_DH
      STRH r4, [r5]

      @ Affichage de la nouvelle valeur à l'adresse DH
      LDR r0, LD_DH
      LDRH r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal16

      @ Affichage de la valeur initiale à l'adresse DB
      LDR r0, LD_DB
      LDRB r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal8

      @ Modification de la valeur à l'adresse DB
      MOV r4, #12
      LDR r5, LD_DB
      STRB r4, [r5]

      @ Affichage de la nouvelle valeur à l'adresse DB
      LDR r0, LD_DB
      LDRB r1, [r0]
      BL EcrHexa32
      BL EcrZdecimal8

fin:  B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

LD_DW:   .word DW
LD_DH:   .word DH
LD_DB:   .word DB

