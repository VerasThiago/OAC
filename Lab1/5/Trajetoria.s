.macro seno
	.data
	quebra: .asciiz "\n"
	PI: .float 3.141592653589
	const: .float 180.0
	alter: .float -1.0
	um: .float 1.0
	fat2: .float 2.0
	fat3: .float 6.0
	fat4: .float 24.0
	fat5: .float 120.0
	fat6: .float 720.0
	fat7: .float 5040.0
	fat8: .float 40320.0
	fat9: .float 362880.0
	
	.text 
	l.s $f1, var
	#mov.s $f1,$f0#variavel X
	jal RAD 
	mul.s $f2,$f1,$f1#y==x^2
	l.s $f4,alter
	jal Trans
	mov.s $f30,$f5
	jal Cosseno
	mov.s $f31,$f5  #O registrador 30 tá o seno e o 31 o cosseno
	li $v0,2
	mov.s $f12,$f30
	syscall
	li $v0,4
	la $a0,quebra
	syscall
	li $v0,2
	mov.s $f12,$f31
	syscall
	j Done
	
 RAD:   l.s $f2,PI
 	l.s $f3,const
 	mul.s $f4,$f1,$f2
 	div.s $f5,$f4,$f3 #angulo está em radianos
 	mov.s $f1,$f5#volta para variavel X
 	jr $ra
 	
 Trans: addi $sp,$sp,-20 #faz a serie até o 5 termo
 	s.s   $f1,16($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat3
 	div.s $f1,$f1,$f3
 	s.s   $f1,12($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat5
 	div.s $f1,$f1,$f3
 	s.s   $f1,8($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat7
 	div.s $f1,$f1,$f3
 	s.s   $f1,4($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat9
 	div.s $f1,$f1,$f3
 	s.s $f1,0($sp)
 	j Soma
 
Soma:	l.s $f5,0($sp)
 	l.s $f6,4($sp)
 	l.s $f7,8($sp)
 	l.s $f8,12($sp)
 	l.s $f9,16($sp)
 	addi $sp,$sp,16
 	add.s $f5,$f5,$f6
 	add.s $f5,$f5,$f7
 	add.s $f5,$f5,$f8
 	add.s $f5,$f5,$f9
 	jr $ra
 	
Cosseno: addi $sp,$sp,-20
 	 l.s $f1,um
 	 s.s $f1,16($sp)
 	 mul.s $f1,$f1,$f2
 	 mul.s $f1,$f1,$f4
 	 l.s $f3,fat2
 	 div.s $f1,$f1,$f3
 	 s.s $f1,12($sp)
  	 mul.s $f1,$f1,$f2
 	 mul.s $f1,$f1,$f4
 	 l.s $f3,fat4
 	 div.s $f1,$f1,$f3
 	 s.s $f1,8($sp)
 	 mul.s $f1,$f1,$f2
 	 mul.s $f1,$f1,$f4
 	 l.s $f3,fat6
 	 div.s $f1,$f1,$f3
 	 s.s $f1,4($sp)
 	 mul.s $f1,$f1,$f2
 	 mul.s $f1,$f1,$f4
 	 l.s $f3,fat8
 	 div.s $f1,$f1,$f3
 	 s.s $f1,0($sp)
 	 j Soma
 	
 Done:
 .end_macro
 .data
 .globl var
 var: .float 30
 .text
 	seno
 	li $v0, 10
 	syscall