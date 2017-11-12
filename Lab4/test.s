# Program to test ISA Implementation. #
# by Gguidini - 2017/2                #
#
# Test sequence:
# <test number> - <operation>
# 0 - j
# 1 - beq
# 2 - bne
# 3 - lui|ori
# 4 - add
# 5 - sub
# 6 - addi
# 7 - and
# 8 - or
# 9 - xor
# 10 - nor
# 11 - sll
# 12 - srl
# 13 - sra
# 14 - addiu
# 15 - addu
# 16 - andi
# 17 - subu
# 18 - lb
# 19 - lh
# 20 - lw
# 21 - sllv
# 22 - srlv
# 23 - srav
# 24 - mult
# 25 - mflo
# 26 - div
# 27 - mfhi
# 28 - mthi
# 29 - mtlo
# 30 - jal
# 31 - jr
# 32 - slt
# 33 - sgt
# 34 - sw
# 35 - sh
# 36 - sb

.eqv LCD 0xFF100130
.eqv LCD_Clear 0xFF100150

.data

fail: .asciiz "ERROR IN TEST"
success: .asciiz "INSTRUCTIONS OK. ISA PASSED TEST."
test: .word 0x1234ABCD


.text
	j SAVE
	
ERRO:
    la $a0, fail
	li $a1, 10
	li $a2, 10
	la $a3, 0xFF00FF00
	li $v0, 104
	syscall
	addi $a0, $s0, 1
	li $a1, 130
	li $a2, 10
	la $a3, 0xFF00FF00
	li $v0, 101
	syscall
WA: j WA
	
SAVE:	
	beq $zero, $zero, BNE
	j ERRO
	
BNE:	bne $zero, $sp, START
	j ERRO
	
START:	# lui & ori - load immediates
	lui $t0, 0x7FFF
	ori $t0, 0xEFFC
	bne $t0, $sp, ERRO
	li $s0, 3
	
	# ULA OPERATIONS 
	li $t0, 1
	add $t1, $zero, $t0
	bne $t0, $t1, ERRO
	add $s0, $s0, $t0
	
	sub $t1, $t1, $t0
	bne $t1, $zero, ERRO
	add $s0, $s0, $t0
	
	addi $t1, $zero, 1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	li $t0, 2
	and $t1, $t1, $t0
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	or $t1, $t1, $t0
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	xor $t1, $t1, $t0
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	li $t0, -1
	nor $t1, $t1, $t0
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	li $t0, 2
	addi $t1, $t1, 1
	sll $t1, $t1, 1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	srl $t1, $t1, 2
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	li $t0, -1
	sra $t1, $t0, 5
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	addiu $t1, $t0, 1
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	addi $t1, $t1, 1
	addu $t1, $t0, $t1
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	andi $t1, $t0, 0xFFFE
	li $t0, 0xFFFE
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	li $t1, 1
	li $t0, -1
	subu $t1, $zero, $t1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	
	la $t0, test
	lb $t1, 0($t0)
	andi $t1, $t1, 0xCD
	ori $t2, $zero, 0xCD
	bne $t1, $t2, ERRO
	addi $s0, $s0, 1
	
	lh $t1, 0($t0)
	andi $t1, $t1, 0xABCD
	ori $t2, $zero, 0xABCD
	bne $t1, $t2, ERRO
	addi $s0, $s0, 1
	
	lw $t1, 0($t0)
	li $t2, 0x1234ABCD
	bne $t1, $t2, ERRO
	addi $s0, $s0, 1
	
	li $t0, 1
	sllv $t1, $t0, $t0
	sll $t0, $t0, 1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	srlv $t1, $t1, $t0
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	li $t0, -1
	li $t2, 5
	srav $t1, $t0, $t2
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	li $t0, 2
	sll $t1, $t0, 1
	mult $t0, $t1
	li $t2, 8
	mflo $t1
	bne $t1, $t2, ERRO
	addi $s0, $s0, 1
	
	div $t2, $t0
	mfhi $t1
	bne $t1, $zero, ERRO
	addi $s0, $s0, 1
	
	mflo $t1
	add $t0, $t0, $t0
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	li $t0, 10
	mthi $t0
	mfhi $t1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	mtlo $t0
	mflo $t1
	bne $t1, $t0, ERRO
	addi $s0, $s0, 1
	
	jal CATCH
	j ERRO
	addi $s0, $s0, 1
	
	li $t0, 1
	li $t1, 2
	slt $t2, $t0, $t1
	bne $t2, $t0, ERRO
	slt $t2, $t1, $t0
	bne $t2, $zero, ERRO
	addi $s0, $s0, 1
	
	sgt $t2, $t0, $t1
	bne $t2, $zero, ERRO
	sgt $t2, $t1, $t0
	bne $t2, $t0, ERRO
	addi $s0, $s0, 1

    la $t0, test
    la $t1, 0xABCD1234
    sw $t1, 0($t0)
    lw $t2, 0($t0)
    bne $t1, $t2, ERRO
    addi $s0, $s0, 1

    srl $t1, $t1, 16
    sh $t1, 0($t0)
    lw $t2, 0($t0)
    la $t3, 0x0000FFFF
    and $t2, $t2, $t3
    bne $t1, $t2, ERRO
    addi $s0, $s0, 1

    srl $t1, $t1, 8
    sb $t1, 0($t0)
    lw $t2, 0($t0)
    la $t3, 0x000000FF
    and $t2, $t2, $t3
    bne $t1, $t2, ERRO
    addi $s0, $s0, 1

	j SUCCESS
	
CATCH:	addi $s0, $s0, 1
	addi $ra, $ra, 4
	jr $ra
	
SUCCESS:
	addi $a0, $s0, 1
	li $a1, 10
	li $a2, 10
	la $a3, 0xFF00FF00
	li $v0, 101
	syscall
	la $a0, success
	li $a1, 30
	li $a2, 10
	la $a3, 0xFF00FF00
	li $v0, 104
	syscall
	la $t0, success
	la $t1, LCD
	sb $zero, 20($t1) # clear LCD
	addi $t0, $t0, 18 # short message start
	
	li $t2, 15
	li $t3, 0
shortMsg:
	beq $t2, $t3, AC
	lb $t4, 0($t0)
	sb $t4, 0($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	j shortMsg
	
	AC: j AC

	
	
	
