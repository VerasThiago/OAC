.include "macros.s"	# inclui arquivos de macros no inicio do programa
.data
	STR: .string "Digite um Numero:"

.text
main: 	M_SetEcall(ECALL)	# Macro de SetEcall

	la a0,STR		# Define a0 = endere�o STR
	li a7,4			# Define a7 = 4
	ecall			# Chama o servi�o original Print String
	
	li a7,5			# Define a7 = 5
	ecall			# Chama o servi�o original Read Int

	li a7,104		# Define a7 = 104
 	ecall			# Chama o novo servi�o 104

 	li a7,10		# Define a7 = 10
 	ecall			# chama o servi�o de Exit

.include "ECALL.s"	# inclui arquivo ECALLv1.s no final do programa
