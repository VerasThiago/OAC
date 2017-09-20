.data
	myArray: .space 2000
.text 
.eqv N 3

.data
vetor:  .word 5,6,-4
newl:	.asciiz "\n"
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

.macro printi (%x) #Pode ser numero direto ou variÃ¡vel
	li $v0, 1
	add $a0, $zero, %x
	syscall
.end_macro

.macro read (%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro
MAIN:
	addi $a0, $zero, 4
	addi $a1, $zero, 2
	prints("OI")
	jal GCD
	prints("GCD = ")
	printi($v1)	
	return0

GCD:
	WHILE: beq $a0,$a1, RETURN				
		sle  $t1,$a1,$a2
		beq $t1,$zero,IJ
		sub $a2,$a2,$a1
		jal WHILE
		IJ: 
			sub $a1,$a1,$a2
		jal WHILE	
	RETURN:
		addi $v1,$a1,0
		jr $ra	 						
																
INSERIRVETOR:
	prints("Digite o tamanho do vetor\n")
	read($t1)#Tamanho do vetor
	addi $t0,$zero,0 #Endereço
	addi $t2,$zero,0 #Índice do while
	
WHILE2: beq $t1,$t2,OUT
	prints("Digite o numero para ser inserido no vetor\n")
	read($t3)
	sw $t3, myArray($t0)
	addi $t0, $t0,4
	addi $t2, $t2,1
	jal WHILE2		   

OUT:
	prints("Acabou\n")	
	
	return0

