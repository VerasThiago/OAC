.macro M_Exit
	li a7,10		# seta o seviço 10
	ecall			# chama a execução do serviço
.end_macro

.macro M_lia(%registrador,%label)		# Le o imediado do endereço LABEL para o registrador
	la %registrador,%label			# Carrega o registrador com o endereço
	lw %registrador,0(%registrador)		# Carrega em registrador = Memoria[0+registrador]
.end_macro

.macro M_SetEcall(%label)
 	la t0,%label		# carrega em t0 o endereço base das rotinas do sistema ECALL
 	csrrw zero,5,t0 	# seta utvec (reg 5) para o endereço t0
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)
 .end_macro
