.data
MENOR: .string "Delta Negativo\n"
MAIOR: .string "Delta Positivo\n"
IGUAL: .string "Delta Zero\n"
DELTA: .string "Delta = "
X1: .string "X1 = "
X2: .string "X2 = "
IMPOSSIVEL: "Impossivel Calcular, A = 0\n"
endl: .string "\n"
.text

	
main:
	# Pro 4 * A * C
   	li t1, 4
   	fcvt.s.w f4, t1  

   	# Pro - 4 * A * C
   	li t1, -1
   	fcvt.s.w f6, t1  

   	# 2 * A
   	li t1, 2
   	fcvt.s.w f7, t1 

   	# Pra checkar se delta = 0
   	li t1, 0
   	fcvt.s.w f8, t1  
  	
  	# Lendo A
  	li a7,6        
  	ecall     
  	fadd.s f0,f10 ,f31

  	# Lendo B
  	ecall
  	fadd.s f1,f10 ,f31

  	# Lendo C
  	ecall
  	fadd.s f2,f10 ,f31

  	# t0 = f0 == 0 ?1:0
  	feq.s t0, f8, f0

  	# se t0 = 1, então A = 0, logo nao é possivel calcular
  	bne, t0, zero, impossivel

  	j delta	

 
impossivel: 
	# Printando que é impossível calcular pois a = 0
	li a7, 4
	la a0, IMPOSSIVEL		
	ecall

	j end	



  
# -b / (2*a)  
exato: 
	
	# Printando Delta = 0
	li a7, 4
	la a0, IGUAL	
	ecall
	
	# Printando a String X1
	la a0, X1
	ecall

	# 2 * a
	fmul.s f0, f0, f7 

	# -b
	fmul.s f1, f1, f6 

	# -b / (2*a)
	fdiv.s f11, f1, f0 	

	# Printando valor de X1
	li a7, 2
	fadd.s f10, f8, f11
	ecall

	# Quebra de linha
	li a7, 4
	la a0, endl	
	ecall
	
	j end
	

#x1 = (-b + sqrtdelta)/(2*a)
#x2 = (-b - sqrtdelta)/(2*a)
positivo: 
	# raiz de delta
	fsqrt.s f3, f3 
	
	# 2 * a
	fmul.s f0, f0, f7 

	# -b
	fmul.s f1, f1, f6 

	# -b + sqrt(delta)
	fadd.s f9, f1, f3 

	# (-b + sqrtdelta)/(2*a)
	fdiv.s f9, f9, f0 

	 # -sqrt(delta)
	fmul.s f3, f3, f6

	# -b - sqrt(delta)
	fadd.s f11, f1, f3

	# (-b - sqrtdelta)/(2*a) 
	fdiv.s f11, f11, f0

	# Printando que delta > 0
	li a7, 4
	la a0, MAIOR
	ecall	

	# Printando string X1
	li a7, 4
	la a0, X1
	ecall

	# Printando valor de X1
	li a7, 2
	fadd.s f10, f8, f9
	ecall

	# Quebra de linha
	li a7, 4
	la a0, endl	
	ecall	
	
	# Printando a string X2
	li a7, 4
	la a0, X2
	ecall

	# Printando valor de X2
	li a7, 2
	fadd.s f10, f8, f11
	ecall

	# Quebra de linha
	li a7, 4
	la a0, endl	
	ecall	

	j end


negativo:
	
	# Pritando que delta < 0
	li a7, 4
	la a0, MENOR	
	ecall

 	j end  



delta:
   	# B * B
   	fmul.s f3, f1, f1 
   	
   	# A * C
   	fmul.s f5, f0, f2 
   
   	# 4 * A * C
   	fmul.s f5, f4, f5 

   	# - 4 * A * C
   	fmul.s f5, f5, f6 
   
	
	# B*B - (4 * A * C)
   	fadd.s  f3, f3, f5 
   
   	
   	# Pritando a string Delta
	li a7, 4
	la a0, DELTA	
	ecall
	
	# Printando valor de Delta
	li a7, 2
	fadd.s f10, f8, f3
	ecall

	# Quebra de linha
	li a7, 4
	la a0, endl	
	ecall	
	
	# t0 = delta == ? 1:0
   	feq.s t0, f8,f3  

   	# Se  t0 nao for zero, é porque ele é 1 e então delta é igual a zero
   	bne t0, zero, exato

   	# t0 = delta < 0 ? 1:0
   	flt.s t0,f3,f8

   	#Se t0 = 0 então delta > 0 logo vai para o positivo
   	beq t0,zero, positivo

   	#Ultimo caso, só restou ser negativo
   	j negativo

 
end:
	# Fim do programa
	li a7 10
	ecall
	
	  
    
  
