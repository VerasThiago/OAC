.data
	#.file	"teste1.c"
	#.option nopic
.text
	#.align	2
	#.globl	main
	#.type	main, @function
main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	li	a5,10
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	
	li a7, 1
	ecall
	#jr	ra
	#.size	main, .-main
	#.ident	"GCC: (GNU) 7.2.0"
