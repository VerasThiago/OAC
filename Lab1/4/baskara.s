

.macro readFloat (%r)
	li $v0, 6
	syscall
	mov.s %r, $f0 
.end_macro

.macro done
	li $v0,10
	syscall
.end_macro
		
.text 

	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	mfc1 $a0, $f1
	mfc1 $a1, $f2
	mfc1 $a2, $f3
	
	jal delta
	jal baskara
	done

delta:	# $a0 = a, $a1 = b, $a2 = c
	mtc1 $a1, $f2	# copiando floats
	mtc1 $a2, $f3 
	mtc1 $a0, $f1 
	
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
	bc1t 0, complex # raiz complexa
	# se forem reais
	mov.s $f0, $f5  # delta in $f5
	li $v0, 1
	j baskaraR
	
complex: li $v0, 2
	 j baskaraC

baskaraR: # delta em $f5 # $f1 = a, $f2 = b, $f3 = c
	
	
	