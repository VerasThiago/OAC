	#.file	"teste4.c"
	#.option nopic
	#.section	.rodata
	#.align	2
.data
.LC0: .asciz	"Numero:"
.text
	#.align	2
	#.globl	main
	#.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,12288
	addi	a5,a5,57
	sw	a5,-20(s0)
	lw	a1,-20(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	
	li a7, 4
	la a0, .LC0
	ecall
	
	#call	printf
	lw	a5,-20(s0)
	addi	a5,a5,2
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	
	li a7, 1
	ecall