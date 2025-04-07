# 1 "progTBC.s"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "progTBC.s"
# 10 "progTBC.s"
.data
msg1: .asciz "Entrer un mot"
msg2: .asciz "Distance entre les 2 mots "
d: .word 42
.bss
ch1: .skip 80
ch2: .skip 80
.text
.global main
main: push {lr}

    @@ A COMPLETER
# 1 "corpsMain.s" 1
@20: EcrChaine("Entrer un mot")
    ldr R1, LD_msg1 @ Qestion d)
    bl EcrChaine @ Qestion d)
@21: LireChaine(&ch1)
    ldr R1, LD_ch1 @ Qestion d)
    bl LireChaine @ Qestion d)
   
@22: EcrChaine("Entrer un mot")
    ldr R1, LD_msg1
    bl EcrChaine
@23: LireChaine(&ch2)
    ldr R1, LD_ch2
    bl LireChaine
   
@24: d:=DistLev(ch1,ch2)

# 1 "appel.s" 1
@d:=DistLev(ch1,ch2)
    ldr R0, LD_ch1
    push {R0}
    ldr R0, LD_ch2
    push {R0}
    mov R0, #1024
    push {R0}
    bl DistLev
    pop {R0}
    add SP, SP, #8
    ldr R1, LD_d
    str R0, [R1]
# 18 "corpsMain.s" 2

@25: EcrChaine("Distance entre les 2 mots ")
    ldr R1, LD_msg2 @ Qestion d)
    bl EcrChaine @ Qestion d)
@26: EcrNdecimal32(d)
    ldr R1, LD_d @ Qestion d)
    ldr R1, [R1] @ Qestion d)
    bl EcrNdecimal32 @ Qestion d)
# 23 "progTBC.s" 2

    pop {lr}
    mov R0, #0
    bx lr

# 1 "fonction.s" 1
DistLev:
    push {lr} @ Qestion f)
    push {fp}
    mov fp,sp
    sub sp,sp,#8
    push {R0}
    push {R1}
    push {R2}

# 1 "corpsFonction.s" 1
@si (a[0]+b[0]) == 0 alors loc = 0 sinon l.2 finsi(l.11) @ Qestion g)
    ldr R0, [fp,#16]
    ldrb R0, [R0]
    ldr R1, [fp,#12]
    ldrb R1, [R1]
    add R0, R0, R1
    cmp R0, #0
    bne l.2
    str R0, [fp,#-4]
    b l.11
l.2: @sinon si a[0] == 0 alors loc = 1 + DistLev(a, adresse de b[1])
    ldr R0, [fp,#16]
    ldrb R0, [R0]
    cmp R0, #0
    bne l.3
    ldr R0, [fp,#16]
    push {R0}
    ldr R0, [fp,#12]
    add R0,R0,#1
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    add R0,R0,#1
    str R0, [fp,#-4]
    b l.11
l.3: @sinon si b[0] == 0 alors loc = 1 + DistLev(adresse de a[1],b)
    ldr R0, [fp,#12]
    ldrb R0, [R0]
    cmp R0, #0
    bne l.4
    ldr R0, [fp,#16]
    add R0,R0,#1
    push {R0}
    ldr R0, [fp,#12]
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    add R0,R0,#1
    str R0, [fp,#-4]
    b l.11
l.4: @sinon si a[0] == b[0] alors loc = DistLev(adresse de a[1], adresse de b[1])
    ldr R0, [fp,#12]
    ldrb R0, [R0]
    ldr R1, [fp,#16]
    ldrb R1, [R1]
    cmp R0, R1
    bne l.5
    ldr R0, [fp,#16]
    add R0,R0,#1
    push {R0}
    ldr R0, [fp,#12]
    add R0,R0,#1
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    str R0, [fp,#-4]
    b l.11
l.5: @sinon
l.6: @loc = 1 + DistLev(adresse de a[1], b)
    ldr R0, [fp,#16]
    add R0,R0,#1
    push {R0}
    ldr R0, [fp,#12]
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    add R0,R0,#1
    str R0, [fp,#-4]
l.7: @ alt = 1 + DistLev(adresse de a[1], adresse de b[1])
    ldr R0, [fp,#16]
    add R0,R0,#1
    push {R0}
    ldr R0, [fp,#12]
    add R0,R0,#1
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    add R0,R0,#1
    str R0, [fp,#-8]
l.8: @si alt < loc alors loc = alt finsi
    ldr R0, [fp,#-8]
    ldr R1, [fp,#-4]
    cmp R0, R1
    bgt l.9
    str R0, [fp,#-4]
l.9: @alt = 1 + DistLev(a, adresse de b[1])

# 1 "alt.s" 1
@alt = 1 + DistLev(a, adresse de b[1])
    ldr R0, [fp,#16]
    push {R0}
    ldr R0, [fp,#12]
    add R0,R0,#1
    push {R0}
    sub SP, SP, #4
    bl DistLev
    pop {R0}
    add SP, SP, #8
    add R0,R0,#1
    str R0, [fp,#-8]
# 99 "corpsFonction.s" 2

l.10: @si alt < loc alors loc = alt finsi
    ldr R0, [fp,#-8]
    ldr R1, [fp,#-4]
    cmp R0, R1
    bgt l.11
    str R0, [fp,#-4]
l.11: nop
# 11 "fonction.s" 2

    ldr R0, [fp,#-4] @ Qestion i)
    str R0, [fp,#8]
    pop {R2}
    pop {R1}
    pop {R0}
    add sp,sp,#8
    pop {fp}
    pop {lr}
    bx lr
# 29 "progTBC.s" 2




LD_d: .word d
LD_ch1: .word ch1
LD_ch2: .word ch2
LD_msg1: .word msg1
LD_msg2: .word msg2
