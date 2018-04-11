.include "macros.s"	# inclui arquivos de macros no inicio do programa
.data
	N: .word 104
	STR: .string "Digite um Numero:"

.text
main: 	M_SetEcall(ECALL)	# Macro de SetEcall

	la a0,STR		# Define a0 = endereço STR
	li a7,4			# Define a7 = 4
	ecall			# Chama o serviço Print String
	
	li a7,5			# Define a7 = 5
	ecall			# Chama o serviço Read Int

	M_lia a7,N		# Define a7 = 104
 	ecall			# Chama o novo serviço 104

 	M_Exit			# Macro de Exit

.include "ECALL.s"	# inclui arquivo ECALLv1.s no final do programa
