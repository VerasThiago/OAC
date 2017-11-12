.data
file: .asciiz "Ryu_L_Punch.spr"
.align 2
input1: .space 4
.align 2
input2: .space 4
.align 2
input3: .space 4
.text
	la $a0, file
	li $a2, 0
	li $v0, 13
	syscall
	
	move $a0, $v0
	la $a1, input1
	li $a2, 4
	li $v0, 14
	syscall
	
	move $t9, $a0
	la $a1, input2
	li $a2, 4
	li $v0, 14
	syscall
	
	move $a0, $t9
	la $a1, input3
	li $a2, 4
	li $v0, 14
	syscall
	
	li $v0, 16
	syscall
	
	la $t0, input1
	lw $s0, 0($t0)
	
	la $t0, input2
	lw $s1, 0($t0)
	
	la $t0, input3
	lw $s2, 0($t0)
	
	li $v0, 10
	syscall