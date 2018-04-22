.data

MENOR: .string "Delta Negativo\n"
MAIOR: .string "Delta Positivo\n"
IGUAL: .string "Delta Zero\n"
DELTA: .string "Delta = "
X1: .string "R(1)="
X2: .string "R(2)="
IMPOSSIVEL: "Impossivel Calcular, A = 0\n"
ENDL: .string "\n"
I: " i\n"
MAIS: " + "
MENOS: " - "

.text


main:
	#Constantes => f21, f22, f24 e f6. Utilizadas para:
	
	# 4 * A * C
   	li t1, 4
   	fcvt.s.w f24, t1  

   	# - 4 * A * C
   	li t1, -1
   	fcvt.s.w f26, t1  		

   	# 2 * A
   	li t1, 2
   	fcvt.s.w f22, t1 

   	# Pra checkar se delta = 0
   	li t1, 0
   	fcvt.s.w f21, t1

  	
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

  
  	jal baskara
  	jal show
  	j end
 




baskara:
   	# B * B
   	fmul.s f3, f1, f1 
   	
   	# A * C
   	fmul.s f5, f0, f2 
   
   	# 4 * A * C
   	fmul.s f5, f24, f5 

   	# - 4 * A * C
   	fmul.s f5, f5, f26 
   
	
	# B*B - (4 * A * C)
   	fadd.s  f3, f3, f5 
   	
   	# Pritando a string Delta
	li a7, 4
	la a0, DELTA	
	ecall
	
	# Printando valor de Delta
	li a7, 2
	fadd.s f10, f21, f3
	ecall

	# Quebra de linha
	li a7, 4
	la a0, ENDL	
	ecall	
	
   	# t0 = delta < 0 ? 1:0
   	flt.s t0,f3,f21

   	#Se t0 = 0 então delta > 0 logo vai para o positivo
   	beq t0,zero, positivo


	# Se chegou aqui é porque não é positivo o delta	
	
	# Alocando espaço para 2 variáveis, parte real e imaginária das raízes (que são as mesmas)
	addi sp, sp, 8

	# Transformando o delta positivo para tirar a raiz
	fmul.s f3, f3, f26

	# raiz de delta
	fsqrt.s f3, f3

	# 2 * a
	fmul.s f0, f0, f22 

	# -b
	fmul.s f1, f1, f26 

	# -b/(2*a)
	fdiv.s f1, f1, f0 

	# raiz de delta / (2*a) parte imaginária
	fdiv.s f3, f3 ,f0

	# Empilhando a parte real
	fsw f1, 4(sp)  

	# Empilhando a parte imaginaria
	fsw f3, 0,(sp)

	# Setando a variável de retorno como 2
	fadd.s f11, f21, f22

	j continua


#x1 = (-b + sqrtdelta)/(2*a)
#x2 = (-b - sqrtdelta)/(2*a)
positivo: 

	
	#Alocando espaço para 2 variáveis, raiz1 e raiz2
	addi sp, sp, 8

	# raiz de delta
	fsqrt.s f3, f3 
	
	# 2 * a
	fmul.s f0, f0, f22 

	# -b
	fmul.s f1, f1, f26 

	# -b + sqrt(delta)
	fadd.s f9, f1, f3 

	# (-b + sqrtdelta)/(2*a)
	fdiv.s f9, f9, f0 

	 # -sqrt(delta)
	fmul.s f3, f3, f26

	# -b - sqrt(delta)
	fadd.s f11, f1, f3

	# (-b - sqrtdelta)/(2*a) 
	fdiv.s f11, f11, f0

	# Empilhando r1
	fsw f9, 4(sp)

	# Empilhando r2
	fsw f11, 0(sp)


	# Setando a variavel de retorno como 1
	li a6, 1
	fcvt.s.w f11, a6

continua:
	# Volta para a função que chamou
	jalr zero, ra, 0

show:
	
	# Verificando se o argumento passado é 2
	feq.s t1, f11, f22
	

	# Se o argumento for 2, vai para o tratamento de imaginarios
	li t0, 1
	beq t1,t0, imaginario

	# Se veio aqui é porque as raízes são reais
	
	# Desempilhando a raiz 1
	flw f9, 4(sp)

	# Desempilhando a raiz 1
	flw f11, 0(sp)

	#Desalocando espaço na pilha
	addi sp, sp, 8

	# Printando string X1
	li a7, 4
	la a0, X1
	ecall

	# Printando valor de X1
	li a7, 2
	fadd.s f10, f21, f9
	ecall

	# Quebra de linha
	li a7, 4
	la a0, ENDL	
	ecall	
	
	# Printando a string X2
	li a7, 4
	la a0, X2
	ecall

	# Printando valor de X2
	li a7, 2
	fadd.s f10, f21, f11
	ecall

	# Quebra de linha
	li a7, 4
	la a0, ENDL	
	ecall

	j continua2		


imaginario:
	
	
	#desempilhando a parte real
	flw f1, 4(sp)
	
	#desempilhando a parte imaginaria
	flw f3, 0(sp)

	#Desalocando espaço na pilha
	addi sp, sp, 8

	# Printando a string X1
	li a7, 4
	la a0, X1
	ecall

	# Printando a parte real de X1
	li a7, 2
	fadd.s f10, f21, f1
	ecall

	# Printando sinal positivo
	li a7, 4
	la a0, MAIS	
	ecall

	# Printando a parte imaginária de X1
	li a7, 2
	fadd.s f10, f21, f3
	ecall

	# Printando a string i
	li a7, 4
	la a0, I	
	ecall	
	
	#Printando a string X2
	li a7, 4
	la a0, X2
	ecall

	# Printando a parte real de X2
	li a7, 2
	fadd.s f10, f21, f1
	ecall

	# Printando sinal negativo
	li a7, 4
	la a0, MENOS	
	ecall


	# Printando a parte imaginária de X2
	li a7, 2
	fadd.s f10, f21, f3
	ecall

	# Printando a string i
	li a7, 4
	la a0, I	
	ecall

continua2:
	jalr zero, ra, 0


end:
	# Fim do programa
	li a7 10
	ecall
	
	  
    
  
