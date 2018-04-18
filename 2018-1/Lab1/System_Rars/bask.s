.data
MENOR: .string "Bhaskara Negativo \n"
MAIOR: .string "Bhaskara Positivo \n"
IGUAL: .string "Bhaskara Zero \n"
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
   fcvt.s.w ft7, zero # 0
   fadd.s fa0, ft7, %x
   ecall

.end_macro

.macro readf(%x)
 li a7,6
 ecall
 fcvt.s.w ft7, zero # 0
 fadd.s %x,fa0 ,ft7
.end_macro
	
main:

  	readf(f0)
  	readf(f1)
  	readf(f2)
        
  	j delta
 
  
  
  
exato: # -b / (2*a)
	li t0, 2
	fmv.s.x ft0, t0
	fmul.s f0, f0, ft0
	li a7, 4
	la a0, IGUAL	
	ecall
	j end
	
positivo:
	li a7, 4
	la a0, MAIOR	
	ecall
	j end


negativo:

	li a7, 4
	la a0, MENOR	
	ecall
 	j end  



delta:
   	
   	li t1, 4 # Para mutiplica o 4 * A * C  	   	
   	fcvt.s.w f6, t1 # 4
   
   	fmul.s f3, f1, f1 # B * B
   
   	fmul.s f4, f0, f2 # A * C
   
   
   	fmul.s f4, f4, f6 # 4 * A * C
   
   	li t0, -1 # Para mutiplica por -1 e fazer a soma
   	fcvt.s.w ft0, t0 # -1
   	fmul.s f4, f4, ft0 # - 4 * A * C
   
   
   	fadd.s  f3, f3, f4 # B*B - (4 * A * C)
   
   	fmv.s.x ft0, zero
	feq.s t0, ft0, f3
   
	
	print_str("Delta = ")
	printf(f3)
   	print_str("\n")
   
   	
   	fcvt.s.w f10, zero # para ver se  delta <, > ou = 0
   	
   	print_str("f10 = ")
	printf(f10)
   	print_str("\n")
   
   	
   	feq.s t0, f10,f3   # delta = 0
   	bne t0, zero, exato
   	flt.s t0,f3,f10
   	beq t0,zero, positivo
   	j negativo

 
end:
	li a7 10
	ecall
	
	  
    
  
