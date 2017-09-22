.data
	myArray: .space 2000
	TESTE: .word 0x12345678
.text
.eqv N 3

.data
vetor:  .word 5,6,-4
endl:	.asciiz "\n"
tab:	.asciiz "\t"


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
MAIN:
	prints("Digite sua operacao:\n")
	prints("0 - Criar um Vetor\n")
	prints("1 - Fazer GCD\n")
	read($t4)
	beqz $t4,INSERIRVETOR
	j GCD
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
	FOR: beq $t1,$t2,OUT2
		lw $t3,0($t0)
		printi($t3)
		addi $t0,$t0,4
		addi $t2, $t2,1
		j FOR
	OUT2:
		j FIM
