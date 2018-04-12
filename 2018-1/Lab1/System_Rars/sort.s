.eqv N 100

.data
vetor:  .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100
newl:	.string "\n"
tab:	.string "\t"


.text	
MAIN:	la a0,vetor
	li a1,N
	nop
	jal show

	la a0,vetor
	li a1,N
	jal sort

	la a0,vetor
	li a1,N
	jal show

	li a7,10
	ecall	


swap:	slli t1,a1,2
	add t1,a0,t1
	lw t0,0(t1)
	lw t2,4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret

sort:	addi sp,sp,-20
	sw ra,16(sp)
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)
	mv s2,a0
	mv s3,a1
	mv s0,zero
for1:	slt t0,s0,s3
	beq t0,zero,exit1
	addi s1,s0,-1
for2:	slti t0,s1,0
	bne t0,zero,exit2
	slli t1,s1,2
	add t2,s2,t1
	lw t3,0(t2)
	lw t4,4(t2)
	slt t0,t4,t3
	beq t0,zero,exit2
	mv a0,s2
	mv a1,s1
	jal swap
	addi s1,s1,-1
	j for2
exit2:	addi s0,s0,1
	j for1
exit1: 	lw s0,0(sp)
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	ret

show:	mv t0,a0
	mv t1,a1
	mv t2,zero

loop1: 	beq t2,t1,fim1
	li a7,1
	lw a0,0(t0)
	ecall
	li a7,4
	la a0,tab
	ecall
	addi t0,t0,4
	addi t2,t2,1
	j loop1

fim1:	li a7,4
	la a0,newl
	ecall
	ret
