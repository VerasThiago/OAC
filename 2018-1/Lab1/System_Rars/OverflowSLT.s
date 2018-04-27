.data

OVER: .string "Deu overflow!\n"
UNDER: .string "Deu underflow!\n"
ENDL: .string "\n"
MSG: .string "A - B = "
SLT: .string "SLT = "

.text

.macro print(%x)
li a7, 1
addi a0, %x 0
ecall
li a7, 4
la a0, ENDL
ecall
.end_macro 

MAIN: 

	li a7, 5
	ecall
	add a1, a0, zero
	
	li a7, 5
	ecall
	add a2, a0, zero
	jal slto
	la a0, SLT
	li a7, 4
	ecall
	print(t0)
	j fim


slto:
	addi sp, sp, -12 
	sw a1, 0(sp)
	sw a2, 4(sp)
	sw a3, 8(sp)
	
	sub a3, a1, a2
	xor a1, a1, a2
	srli a1, a1, 31
	beq a1, zero, ok
	xor a1, a3, a2
	srli a1, a1, 31
	beq a1, zero, PROBLEMA
	
ok :
	la a0, MSG
	li a7,4
	ecall
	print(a3)
	srli a3, a3, 31
	addi t0, a3, 0
	
	
	lw a1, 0(sp)
	lw a2, 4(sp)
	lw a3, 8(sp)
	addi sp, sp, 12 
	
	jalr zero, ra, 0		
	

fim:
	li a7,10
	ecall
	
	
PROBLEMA:
	srli a2, a2, 31
	beq a2, zero, UNDERFLOW

	 
	la a0, OVER
	li a7, 4
	ecall
	j ok
	
	
UNDERFLOW:
	
	la a0, UNDER
	li a7, 4
	ecall
	j ok

 # Testar com :
 # 2147483647 , 0
 # 0 , 2147483647
 # 2147483647 , -1

 
