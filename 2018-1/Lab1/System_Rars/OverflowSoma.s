.data

OVER: .string "Deu Overflow!\n"
endl: .string "\n"
um: .float 1
dois: .float 2
tres: .float 6
quatro: .float 12
cinco: .float 60

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
	li a7, 6
	ecall
	
	fcvt.s.w ft0, zero
	fadd.s f12, ft0, fa0 # P	

	ecall
	fadd.s f13, ft0, fa0 # Teta
	
	jal CONVERSAO

		
				
						
FIM:
	li a7, 10
	ecall
									
CONVERSAO:
																				
	# FT1 = seno(o)
	# FT2 = cons(o)
	addi sp, sp, -4 
	sw ra, 0(sp)
	jal SENO
	jal COS
	lw ra, 0(sp)
	addi sp, sp, 4
																								
														
SENO:
	
																
																																																
																		
																				
																						
																								
																												
	
 # Testar com :
 # 2147483647 + 0
 # 2147483647 + 1

