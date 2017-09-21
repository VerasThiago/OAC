	.data
	PI: .float 3.141592653589
	const: .float 180.0
	alter: .float -1.0
	zero: .float 0.0
	fat3: .float 6.0
	fat5: .float 120.0
	fat7: .float 5040.0
	fat9: .float 362880
	.text 
	li $v0,6
	syscall 
	mov.s $f1,$f0#variavel X
	jal RAD 
	mul.s $f2,$f1,$f1#y==x^2
	l.s $f4,alter
	jal Trans
	li $v0,2
	mov.s $f12,$f5
	syscall
	li $v0,10
	syscall
	
 RAD:   l.s $f2,PI
 	l.s $f3,const
 	mul.s $f4,$f1,$f2
 	div.s $f5,$f4,$f3 #angulo está em radianos
 	mov.s $f1,$f5#volta para variavel X
 	jr $ra
 	
 Trans: addi $sp,$sp,-16 #faz a serie até o 5 termo
 	s.s   $f1,12($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat3
 	div.s $f1,$f1,$f3
 	s.s   $f1,8($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat5
 	div.s $f1,$f1,$f3
 	s.s   $f1,4($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat7
 	div.s $f1,$f1,$f3
 	s.s   $f1,0($sp)
 	mul.s $f1,$f2,$f1
 	mul.s $f1,$f4,$f1
 	l.s $f3,fat9
 	div.s $f1,$f1,$f3
 	add $t0,$zero,$zero
 	j Soma
 
Soma:	l.s $f5,0($sp)
 	l.s $f6,4($sp)
 	l.s $f7,8($sp)
 	l.s $f8,12($sp)
 	addi $sp,$sp,16
 	add.s $f5,$f5,$f6
 	add.s $f5,$f5,$f7
 	add.s $f5,$f5,$f8
 	jr $ra
 	
 
 
 
 
 
 
 
 
 
 
