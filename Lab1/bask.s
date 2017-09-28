
.data

	ABSMask : .word 0x7FFFFFFF  # mascara para pegar o ABS
	RAIZ1 : .asciiz "R(1)="		# strings para formatacao da apresentacao das raizes
	RAIZ2 : .asciiz "\nR(2)="
	PLUS : .asciiz " + ("
	MINUS : .asciiz " - ("
	IMA : .asciiz ") i\n"
	ENDL : .asciiz "\n"
		
.text 

main:
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	
	li $v0, 6
	syscall
	mov.s $f3, $f0

	mtc1 $zero, $f0
	c.eq.s 0, $f0, $f1
	bc1f 0, delta
	c.eq.s 0, $f0, $f2
	bc1f 0, delta
	c.eq.s 0, $f0, $f3
	bc1f 0, delta
	j end
	

delta:	# $f1 = a, $f2 = b, $f3 = c

	
	# calcular delta
	mul.s $f0, $f2, $f2 # $f0 = b*b
	mul.s $f4, $f1, $f3 # $f4 = a*c
	li $t0, -4
	mtc1 $t0, $f5
	cvt.s.w $f5, $f5
	mul.s $f4, $f4, $f5 # $f4 = (-4)*a*c
	add.s $f5, $f0, $f4 # delta
	li $t0, 0
	mtc1 $t0, $f6
	cvt.s.w $f6, $f6
	
	# vendo se eh real ou complexo
	c.lt.s 0, $f5, $f6 # vendo se delta eh menor que zero
	#mov.s $f0, $f5  # delta in $f5
	bc1t 0, complex # raiz complexa
	# se forem reais
	li $v0, 1
	j baskara
	
complex: li $v0, 2

baskara: # delta em $f5 # $f1 = a, $f2 = b, $f3 = c
    li $t0, -1	# $f7 = -1
    mtc1 $t0, $f7 
    cvt.s.w $f7, $f7
    mul.s $f2, $f2, $f7 # b = b*(-1) 
    li $t0, 2	# $f8 = 2
    mtc1 $t0, $f8
    cvt.s.w $f8, $f8
    mul.s $f1, $f1, $f8 # a = a * 2 
    la $t1, ABSMask # carrega $t1 com o valor da mascara
    mfc1 $t2 $f5
    and $t2, $t2, $t1
    mtc1 $t2, $f5 
    sqrt.s $f5, $f5 # delta = raiz quadrada de delta

    add.s $f8, $f2, $f5 # $f8 = -b + sqrt(delta)
    div.s $f8, $f8, $f1 # $f8 = (-b + sqrt(delta)) / 2 * a

    mul.s $f5, $f5, $f7 # sqrt(delta) = (-1) * sqrt(delta)
    add.s $f9, $f2, $f5 # $f9 = -b - sqrt(delta)
    div.s $f9, $f9, $f1 # $f9 = (-b - sqrt(delta)) / 2 * a

    mfc1 $t0, $f8		# move os valores das raizes para registradores do processador
    mfc1 $t1, $f9
    addi $sp, $sp, -8	# alocando espaco para a pilha
    sw $t0, 0($sp)		# empilhando primeira raiz
    sw $t1, 4($sp)      # empilhando segunda raiz

    li $t0, 2
    beq $v0, $t0, show2		# checa se $v0 = 2, caso for, entra no show(2)

show1:
	li $v0, 4			# procedimento syscall para printar string 
	la $a0, RAIZ1
	syscall

	lw $t0, 0($sp)		# recupera o valor da primeira raiz salvo na pilha
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2			# procedimento syscall para printar float
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, RAIZ2
	syscall

	lw $t0, 4($sp)		# recupera o valor da segunda raiz salvo na pilha
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2			# procedimento syscall para printar float
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, ENDL
	syscall

	addi $sp, $sp, 8

	j main

show2:
	li $v0, 4			# procedimeno syscall para printar string
	la $a0, RAIZ1
	syscall

	lw $t0, 0($sp)		# recupera o valor da primeira raiz salvo na pilha
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2			# procedimento syscall para printar float
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, PLUS		
	syscall

	lw $t1, 4($sp)		# recupera o valor da segunda raiz salvo na pilha
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, IMA
	syscall

	#---Segunda Raiz---#

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, RAIZ1
	syscall

	# nao eh necessario o comando de puxar da pilha, pois $t0 ainda possui a primeira raiz
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2			# procedimento syscall para printar float
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, MINUS
	syscall

	# nao eh necessario o comando de puxar da pilha, pois $t1 ainda possui a segunda raiz
	mtc1 $t0, $f12		# move o valor para o coproc 1
	li $v0, 2			# procedimento syscall para printar float
	syscall

	li $v0, 4			# procedimeno syscall para printar string
	la $a0, IMA
	syscall

	addi $sp, $sp, 8

	j main

end:
	
	li $v0, 10
	syscall







    



	
	
	
