	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"premier.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r1, #10
	sub	sp, sp, #16
	ldr	r0, .L2
	bl	printf
	ldr	r3, .L2+4
	ldr	r3, [r3, #0]
	add	r4, sp, #4
	ldr	r2, [r3, #4]
	mov	r0, r4
	mov	r1, #10
	bl	fgets
	mov	r1, r4
	ldr	r0, .L2+8
	bl	printf
	mov	r0, r4
	bl	strlen
	mov	r1, r0
	ldr	r0, .L2+12
	bl	printf
	add	sp, sp, #16
	ldmfd	sp!, {r4, lr}
	bx	lr
.L3:
	.align	2
.L2:
	.word	.LC0
	.word	_impure_ptr
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Donner une chaine de longueur inferieure a %d:\012\000"
.LC1:
	.ascii	"la chaine lue est : %s\012\000"
.LC2:
	.ascii	"la longueur de la chaine lue est : %d\012\000"
	.ident	"GCC: (GNU) 4.5.3"
