	.file	"teste6.c"
	.option nopic
	.text
	.align	2
	.globl	proc
	.type	proc, @function
proc:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	addiw	a5,a5,2
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	proc, .-proc
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,12288
	addiw	a5,a5,57
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	proc
	mv	a5,a0
	addiw	a5,a5,3
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
