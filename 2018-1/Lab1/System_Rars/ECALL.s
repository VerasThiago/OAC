# Exemplo da rotina ECALL

.data
.align 2			# alinha o dado seguinte em word
	E_STR: .string "Isto e so para teste:"
	E_NL:  .string "\n"	
.text
ECALL: 	li t0,104		# carrega t0 = 104
	bne a7,t0,E_FIM		# Se não for o serviço 104 então FIM
	
	mv t0,a0		# salva argumento a0 em t0
	la a0,E_STR		# ponteiro para a STR
	li a7,4			# serviço original de print string
	ecall
	
	mv a0,t0		# recupera o número a ser impresso			
	li a7,1			# serviço original print int
	ecall
	
	la a0,E_NL		# ponteiro para a NL
	li a7,4			# serviço original de print string
	ecall
		
E_FIM:	csrrw t0, 65, zero	# le o valor de EPC salvo no registrador uepc (reg 65)
	addi t0, t0, 4		# soma 4 para obter a instrução seguinte ao ecall
	csrrw zero, 65, t0	# coloca no registrador uepc
	uret			# retorna PC=uepc
