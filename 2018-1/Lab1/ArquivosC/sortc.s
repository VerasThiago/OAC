.eqv N 10

.data
v:	.word	9,2,5,1,8,2,4,3,6,7
.LC0:	.string	"\t"

.text
main:
	addi	sp,sp,-16 #RESPONSAVEL POR MOSTRAR O VETOR ORIGINAL
	sw	a7,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,10
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)
	jal	show
	
	li	a1,10 #RESPONSAVEL POR ORDENAR O VETOR
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)
	jal	sort
	
	li	a1,10 #RESPONSAVEL POR MOSTRAR O VETOR ORDENADO
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)
	jal	show
	
	lw	a7,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	
	li a7, 1
	ecall



show:
	addi	sp,sp,-48
	sw	a7,44(sp)
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
	lw	a7,44(sp)
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
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	
	li a7, 4
	la a0, .LC0
	ecall

	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)


	
sort:
	addi	sp,sp,-48
	sw	a7,44(sp)
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
	lw	a7,44(sp)
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
	jal	swap #OLHAR ISSO AQUI
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

	

