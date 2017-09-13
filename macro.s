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

.macro printi (%x) #Pode ser numero direto ou variável
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
	read($t0)
	prints("numero eh ")
	printi($t0)
	
	return0

