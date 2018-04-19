.data
MENOR: .string "Bhaskara Negativo \n"
MAIOR: .string "Bhaskara Positivo \n"
IGUAL: .string "Bhaskara Zero \n"
X1: .string "X1 = "
X2: .string "X2 = "
.text


.macro print_str (%str)
	.data
myLabel: .string %str
	.text
	li a7, 4
	la a0, myLabel
	ecall
.end_macro

.macro printf(%x)
   li a7, 2
   fcvt.s.w f31, zero # 0
   fadd.s f30, f31, %x
   ecall

.end_macro

.macro readf(%x)
 li a7,6
 ecall
 fcvt.s.w f31, zero # 0
 fadd.s %x,f30 ,f31
.end_macro
	
main:

  	readf(f0)
  	readf(f1)
  	readf(f2)
        
  	j delta
 
  
  
  
exato: # -b / (2*a)
	
	li a7, 4
	la a0, IGUAL	
	ecall
	la a0, X1
	ecall
	fmul.s f0, f0, f7 # 2 * a
	fmul.s f1, f1, f6 # -b
	fdiv.s f10, f1, f0 	
	printf(f10)
	print_str("\n")
	
	j end
	
positivo: #x1 = (-b + sqrtdelta)/(2*a)
	fsqrt.s f3, f3 # rai de delta
	fmul.s f0, f0, f7 # 2 * a
	fmul.s f1, f1, f6 # -b
	fadd.s f9, f1, f3 # -b + sqrt(delta)
	fdiv.s f9, f9, f0 # X1
	fmul.s f3, f3, f6 # -sqrt(delta)
	fadd.s f10, f1, f3 # -b - sqrt(delta)
	fdiv.s f10, f10, f7 #X2
	li a7, 4
	la a0, MAIOR
	ecall	
	la a0, X1
	ecall
	printf(f9)
	print_str("\n")
	la a0, X2
	ecall
	printf(f10)
	print_str("\n") 
	
	j end


negativo:

	li a7, 4
	la a0, MENOR	
	ecall
 	j end  



delta:
   	
   	# f4 = 4
   	# f6 = -1
   	# f7 = 2
   	# f8 = 0
   	
   	li t1, 4 # Para mutiplica o 4 * A * C  	   	
   	fcvt.s.w f4, t1 # 4
   
   	fmul.s f3, f1, f1 # B * B
   	
   	print_str("B * B = ")
	printf(f3)
   	print_str("\n")
   
   
   	fmul.s f5, f0, f2 # A * C
   
   
   	fmul.s f5, f4, f5 # 4 * A * C
   
   	li t0, -1 # Para mutiplica por -1 e fazer a soma
   	fcvt.s.w f6, t0 # -1
   	fmul.s f5, f5, f6 # - 4 * A * C
   
   	print_str("-4 A C = ")
	printf(f5)
   	print_str("\n")
   
   
   	fadd.s  f3, f3, f4 # B*B - (4 * A * C)
   
   	fmv.s.x f8, zero
	feq.s t0, f8, f3
   
	
	print_str("Delta = ")
	printf(f3)
   	print_str("\n")
   
  
   	feq.s t0, f8,f3   # delta = 0
   	bne t0, zero, exato
   	flt.s t0,f3,f8
   	beq t0,zero, positivo
   	j negativo

 
end:
	li a7 10
	ecall
	
	  
    
  
