.data
	myArray: .space 2000
	TESTE: .word 0x12345678
	floatArray: .space 2000
	x: .space 2000
	h: .space 2000
.text
.eqv N 3

.data
vetor:  .word 5,6,-4
endl:	.asciiz "\n"
tab:	.asciiz "\t"
parte1: .asciiz "y["
parte2: .asciiz "]="


.text
.macro return0
	li $v0,10
	syscall
.end_macro

.macro prints (%str)
	.data
myLabel: .asciiz %str
	.text
	li $v0, 4
	la $a0, myLabel
	syscall
.end_macro

.macro printi (%x) #Pode ser numero direto ou variável
	li $v0, 1
	add $a0, $zero, %x
	syscall
	prints("\n")
.end_macro




.macro read (%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro


.macro reads (%x)
	li $v0, 6
	syscall
	mov.s %x, $f0
.end_macro

MAIN:
	prints("teste\n")
	la $t0, 0x00000010
	printi($t0)
	
	prints("Digite sua operacao:\n")
	prints("0 - Criar um Vetor\n")
	prints("1 - Fazer GCD\n")
	prints("2 - Vetor de float\n")
	prints("3 - Questao 1\n")
	read($t4)
	beqz $t4,INSERIRVETOR
	li $t1, 1
	beq $t4, $t1, GCD
	li $t1, 2
	beq $t4, $t1, VETORFLOAT
	j QUESTAO1
FIM:
	prints("FIM")

	return0

GCD:

	prints("Insira os 2 numeros para o gcd\n")
	read($a3)
	read($a1)
	WHILE: beq $a3,$a1, RETURN
		sle  $t1,$a3,$a1
		beq $t1,$zero,IJ
		sub $a1,$a1,$a3
		j WHILE
		IJ:
			sub $a3,$a3,$a1
			j WHILE
	RETURN:
		addi $v1,$a1,0
		prints("GCD = ")
		printi($v1)
		prints("\n")
		j FIM

INSERIRVETOR:
	prints("Digite o tamanho do vetor\n")
	read($t1)#Tamanho do vetor
	addi $t0,$zero,0 #Endereco
	addi $t2,$zero,0 #Indice do while

	WHILE2: beq $t1,$t2,OUT
		prints("Digite o numero para ser inserido no vetor\n")
		read($t3)
		sw $t3, myArray($t0)
		addi $t0, $t0,4
		addi $t2, $t2,1
		j WHILE2
	OUT:
		prints("Printando o vetor")
		prints("\n")
		la $t0,myArray #Endereco
		addi $t2,$zero,0 #Indice do while
	FOR: beq $t1,$t2,FIM
		lw $t3, ($t0)
		printi($t3)
		addi $t0,$t0,4
		addi $t2, $t2,1
		j FOR
	

		
F1:
	# $a0 = *X
	# $a1 = pos
	# $a2 = *h
	# $a3 = N	
	li $t0 , 0  # indice do for
	mtc1 $zero, $f0 # y = 0.0
	FORK : beq $t0, $a3, SAI
		add $t1, $a1, $t0  # pos + k
		div $t1,$a3
		mfhi $t1  # (pos + k) % N 
		sll $t1, $t1, 2 # deslocamento para o vetor x
		sll $t2, $t0, 2 # deslocamento do k para o vetor h
		add $t1 , $t1 , $a0
		add $t2, $t2, $a2
		lwc1 $f1, 0($t1) # x[(pos+k)%n]
		lwc1 $f2, 0($t2) # h[k]
		mul.s $f1, $f1, $f2
		add.s $f0, $f0, $f1
		addi $t0, $t0, 1
		j FORK
	SAI:

	# printf("y[%d]=%f\n")
	la $a0, parte1
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1
	syscall
	la $a0, parte2
	li $v0, 4
	syscall
	mov.s $f12, $f0
	li $v0, 2
	syscall
	la $a0, endl
	li $v0, 4
	syscall
	
	j FIM
		

VETORFLOAT:
	prints("Digite o tamanho do vetor de float\n")
	read($t1)
	addi $t0,$zero,0 #Endereco
	addi $t2,$zero,0 #Indice do while
	WHILE3: beq $t1,$t2,OUT2
		prints("Digite o numero float para ser inserido no vetor\n")
		reads($f2)
		swc1 $f2, floatArray($t0)
		addi $t0, $t0,4
		addi $t2, $t2,1
		j WHILE3
	OUT2:
		prints("Printando o vetor de float\n")
		la $t0,floatArray #Endereco
		li $t2, 0
	FOR2: beq $t2, $t1, FIM
		lwc1 $f12, ($t0)
		li $v0, 2
		syscall
		prints("\n")	
		addi $t2, $t2, 1
		addi $t0, $t0,4
		j FOR2


QUESTAO1:
 
	prints("Digite o tamanho do vetor \n")
	li $v0, 5
	syscall
	move $a3, $v0
	prints("Digite os valores do vetor X\n")
	
	li $t1, 0 # indice do for
	li $t0, 0 # posi??o do vetor
	FORQ1: beq $t1, $a3, END1
		li $v0, 6
		syscall
		swc1 $f0, x($t0)
		addi $t0 , $t0, 4
		addi $t1, $t1, 1
		j FORQ1
	END1:
	prints("Digite os valores do vetor h \n")
	
	li $t1, 0
	li $t0, 0
	FORQ12: beq $t1, $a3, END2
		li $v0, 6
		syscall
		swc1 $f0, h($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, 1
		j FORQ12
	END2:
	prints("Digite a posi??o \n")
		li $v0, 5
		syscall
		move $a1, $v0
	
	prints("Indo para a fun??o f1\n")
	la $a0 , x
	la $a2, h
	
	j F1
	
	FIMQ1: 
	prints("\nAcabou essa doidera\n")
	
		
	
		
	

	
	
	


