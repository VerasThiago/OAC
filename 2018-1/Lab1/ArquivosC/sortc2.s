	.file	"sortc2.c"
	.option nopic
	.section	.rodata
	.align	2
.LC1:
	.string	"%d\t"
	.text
	.align	2
	.globl	show
	.type	show, @function
show:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L3
	li	a0,10
	call	putchar
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	show, .-show
	.align	2
	.globl	swap
	.type	swap, @function
swap:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-40(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a4,a4,a5
	lw	a5,-40(s0)
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	swap, .-swap
	.align	2
	.globl	sort
	.type	sort, @function
sort:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L6
.L10:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
	j	.L7
.L9:
	lw	a1,-24(s0)
	lw	a0,-36(s0)
	call	swap
	lw	a5,-24(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
.L7:
	lw	a5,-24(s0)
	bltz	a5,.L8
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	bgt	a4,a5,.L9
.L8:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L10
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	sort, .-sort
	.section	.rodata
	.align	2
.LC0:
	.word	5
	.word	8
	.word	3
	.word	4
	.word	7
	.word	6
	.word	8
	.word	0
	.word	1
	.word	9
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC0)
	lw	t3,%lo(.LC0)(a5)
	addi	a4,a5,%lo(.LC0)
	lw	t1,4(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a7,8(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a6,12(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a0,16(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a1,20(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a2,24(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a3,28(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a4,32(a4)
	addi	a5,a5,%lo(.LC0)
	lw	a5,36(a5)
	sw	t3,-56(s0)
	sw	t1,-52(s0)
	sw	a7,-48(s0)
	sw	a6,-44(s0)
	sw	a0,-40(s0)
	sw	a1,-36(s0)
	sw	a2,-32(s0)
	sw	a3,-28(s0)
	sw	a4,-24(s0)
	sw	a5,-20(s0)
	addi	a5,s0,-56
	li	a1,10
	mv	a0,a5
	call	show
	addi	a5,s0,-56
	li	a1,10
	mv	a0,a5
	call	sort
	addi	a5,s0,-56
	li	a1,10
	mv	a0,a5
	call	show
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
