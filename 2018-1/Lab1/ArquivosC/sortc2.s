.eqv N 10
.data
.LC0:	.word	5,8,3,4,7,6,8,0,1,9

.LC1:	.asciz	""
	
.text

main:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC0)
	lui	t3,%lo(.LC0)#(a5)
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
	jal	show
	addi	a5,s0,-56
	li	a1,10
	mv	a0,a5
	jal	sort
	addi	a5,s0,-56
	li	a1,10
	mv	a0,a5
	jal	show
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	
	li a7, 1
	ecall
	
show:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	jal	.L2

.L2:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L3
	li	a0,10
	
	li a6, 4
	la a0, .LC0
	ecall

	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	
	li a7, 1
	ecall

.L3:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	
	li a7, 4
	la a0, .LC0
	ecall
	
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)

sort:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	jal	.L6	



.L6:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L10
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	
	li a7, 1
	ecall

.L10:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
	jal	.L7

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
.L9:
	lw	a1,-24(s0)
	lw	a0,-36(s0)
	jal	swap
	lw	a5,-24(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)


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
	
	li a7, 1
	ecall




