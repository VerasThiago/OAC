.macro sleep(%d)	# stop program execution for %d milisseconds
    li $a0, %d
    li $v0, 32
    syscall
.end_macro

.macro done
	li $v0,10
	syscall
.end_macro

.macro printStr (%str)
	.data
myLabel: .asciiz %str
	.text
	li $v0, 4
	la $a0, myLabel
	syscall
.end_macro

.macro printi(%x) #Pode ser numero direto ou variÃ¡vel
	li $v0, 1
	add $a0, $zero, %x
	syscall
.end_macro

.macro readS (%x)
	li $v0, 6
	syscall
	mov.s %x, $f0
.end_macro

.macro read (%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

 
.data
g:    .float -49
dez: .float 10
.text
 MAIN:
 	printStr("Digite o Vx: ")
 	readS($f20)
 	printStr("Digite o Vy: ")
 	readS($f1)
	jal FUNC	
 	done
FUNC:
	# $f20 = Vx
	# $f1 = Vy
	# $f2 = X  $f3 = Y
	# Y = Vy(X/vx) - 49(X/vx)²
	# $f4 = $f2/$f20    = X/vx
	# $f5 = -49
	# Y = $f1 * $f4  - $f5 * $f4 * $f4
	# Y = $f1(Vy) * $f4($f2/$f20)  - $f5 * $f4($f2/$f20) * $f4($f2/$f20)
	# $f6 = $f4²
	
	lwc1 $f30, dez           	#
 	mul.s $f1, $f1, $f30      	# Multiplicando por 10 as entradas para aumentar a escala
 	mul.s $f20, $f20, $f30   	#
	li $t0, 0			# Coordenada X (0 ~ 320)
	li $t1, 320 			# limite do display
	
	FOR: beq $t0, $t1, FIM		
		mtc1 $t0,$f2  		# Carregando o X para c1
		cvt.s.w $f2,$f2 	# Convertendo o X para precisão simples
		div.s $f4,$f2,$f20 	# f2 = X/vx
		mul.s $f3, $f1,$f4 	# Y = VY * (X/Vx)
		mul.s $f6,$f4,$f4 	# $f4²
		lwc1 $f5, g 		# Carregando gravidade
		mul.s $f6, $f6, $f5 	# Multiplicando a gravidade
		add.s $f3, $f3,$f6 	# Somando pois a gradivade é negativa
		addi $t0,$t0, 1		# Prox coordenada do X
					# coordenada (X,Y) = ($f2,$f3)
		round.w.s $f2,$f2  	#
		mfc1 $t8,$f2       	# Arredondado pra int 
		round.w.s $f3,$f3  	#         e
		mfc1 $t9,$f3       	# jogando no $t8, $t9
					# (X,Y) = ($t8,$t9)
	
		
		slti $s0, $t9, 0   	#
		li $s2, 240		# Verificando se as coordenadas
		slt  $s1, $s2, $t9	# estão corretas destro do display
		or $s0, $s0, $s1	# (Se o Y não passa pra cima ou pra baixo)
		beqz $s0, PRINT		#

		j FOR
		
		
	PRINT:	                        # Printing Pixel
		printStr("X = ")
		printi($t8)
		printStr(" Y = ")
		printi($t9)
		printStr("\n")	
		la $t4, 0xff000000   	# Endereço do primeiro pixel
		addi $t4, $t4, 76800   	# Deslocando pro display embaixo na esquerda
		add $t4, $t4, $t8     	# Deslocamento do X
		mul $t6, $t9, -320      # Deslocamento do Y
		add $t4, $t4, $t6      	# Somando no Display
		la $t7, 0x0C            # Cor
		sb $t7,0($t4)         	# Printando pixel
		sleep(10)
		j FOR
	
	FIM: jr $ra
				
	
