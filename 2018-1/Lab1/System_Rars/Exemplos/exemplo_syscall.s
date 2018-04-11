#################################################
#  Programa de exemplo de uso dos syscalls   	#
#  Versão Polling				#
#  ISC NOv 2017				      	#
#  Marcus Vinicius			      	#
#################################################
# Conecte o BitMap Display Tool E o Keyboard Display MMIO Tool


.include "SYSTEM.s"			# carrega as rotinas do sistema

.data 
FILE: .asciiz "display.bin"		# string do nome do arquivo
STR: .asciiz "Placar do sapo:"		# string da mensagem

.text

# Abre o arquivo
	la $a0,FILE
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	move $s0,$v0
	
# Le o arquivos para a memoria VGA
	move $a0,$s0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

#Fecha o arquivo
	move $a0,$s0
	li $v0,16
	syscall

# Escreve a string do endereço $a0, na posição ($a1,$a2) com as cores $a4		
	la $a0,STR   	#Endereco da STR
	li $a1,0	# coluna
	li $a2,0	# linha
	li $a3,0xFF00	# cores de frente(00) e fundo(FF) do texto
	li $v0,104	# syscall de print string		
	syscall

MAINLOOP: jal KEYBOARD       	# Verifica se houve tecla pressionada

	move $a0,$t2		# imprime o código ascii da tecla pressionada
	li $a1,152		# coluna
	li $a2,0		# linha
	li $a3,0xFF00		# cores de frente(00) e fundo(FF) do texto
	li $v0,101		# syscall de print int	
	syscall	  
	  
	move $a0,$t2		# imprime a tecla lida no nariz do sapo
	li $a1,220		# coluna
	li $a2,100		# linha
	li $a3,0x3807		# cores de frente(0x07) e fundo(0x38) do caracter ASCII do teclado
	li $v0,111		# syscall de print char
	syscall 

  	j MAINLOOP		# volta ao loop principal

FIM:	li $v0,10		# syscall de Exit
	syscall

KEYBOARD: 	la $t1,0xFF100000	# carrega o endereço de controle do KDMMIO
		lw $t0,0($t1)		# le a palavra de controle
		andi $t0,$t0,0x0001	# mascara o bit menos signifcativo
   		beq $t0,$zero,PULA   	# Se não há tecla pressionada então vá para PULA
  		lw $t2,4($t1)  		# le a tecla pressionada
		sw $t2,12($t1)  	# escreve a tecla do no display de texto
	
	
PULA:	jr $ra

