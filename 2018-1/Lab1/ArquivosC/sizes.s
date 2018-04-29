	.file	"sizes.c"
	.option nopic
	.section	.rodata
	.align	2
.LC0:
	.string	"sizeof(char)=%d\n"
	.align	2
.LC1:
	.string	"sizeof(short)=%d\n"
	.align	2
.LC2:
	.string	"sizeof(int)=%d\n"
	.align	2
.LC3:
	.string	"sizeof(long int)=%d\n"
	.align	2
.LC4:
	.string	"sizeof(long long int)=%d\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
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
	li	a1,4
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	li	a1,8
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
