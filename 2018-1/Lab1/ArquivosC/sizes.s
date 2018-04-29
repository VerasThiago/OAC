	.file	"sizes.c"
	.option nopic
	.section	.rodata
	.align	3
.LC0:
	.string	"sizeof(char)=%d\n"
	.align	3
.LC1:
	.string	"sizeof(short)=%d\n"
	.align	3
.LC2:
	.string	"sizeof(int)=%d\n"
	.align	3
.LC3:
	.string	"sizeof(long int)=%d\n"
	.align	3
.LC4:
	.string	"sizeof(long long int)=%d\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a1,1
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a1,2
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	li	a1,4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	li	a1,8
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	li	a1,8
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
