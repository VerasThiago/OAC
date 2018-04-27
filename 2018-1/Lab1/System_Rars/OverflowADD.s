.data

OVER: .string "Deu Overflow!\n"
endl: .string "\n"

.text

.macro print(%x)
li a7, 1
addi a0, %x 0
ecall
li a7, 4
la a0, endl
ecall
.end_macro 

MAIN: 

	li a7, 5
	ecall
	add a1, a0, zero
	
	li a7, 5
	ecall
	add a2, a0, zero

	jal addo
	j fim


addo:
	addi sp, sp, -12
	sw a1, 0(sp)
	sw a2, 4(sp)
	sw a3, 8(sp)

	add a3, a1, a2
	xor a1, a1, a2
	srli a1, a1, 31
	bne a1, zero, ok
	srli a1, a3, 31
	srli a2, a2, 31
	bne a1,a2, OVERFLOW
	
ok :
	
	addi t0, a3, 0
	addi a0, t0, 0
	
	lw a1, 0(sp)
	lw a2, 4(sp)
	lw a3, 8(sp)
	addi sp, sp, 12
	
	li a7,1
	ecall
	jalr zero, ra, 0

fim:
	li a7,10
	ecall
	
	
OVERFLOW: 
	la a0, OVER
	li a7, 4
	ecall
	j ok

	

 # Testar com :
 # 2147483647 + 0
 # 2147483647 + 1

