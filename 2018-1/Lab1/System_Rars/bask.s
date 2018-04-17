.data






.text


main:
  li a7,6
  
  ecall # Lendo o A
  fmv.s.x ft0, zero
  fadd.s f0, fa0, ft0
  
  ecall # Lendo o B
  fadd.s f1, fa0, ft0
   
  ecall # Lendo o C
  fadd.s f2, fa0, ft0
  
  j delta
  
  li a7,2
  ecall
  
  
  
  
  
  
delta:
   li t0, 4 # Para mutiplica o 4 * A * C
   fmv.s.x ft0, t0 # 4
   fmul.s f3 f1, f1 # B * B
   fmul.s f4 f0, f2 # A * C
   fmul.s f4, f4, ft0 # 4 * A * C
   li t0, -1 # Para mutiplica por -1 e fazer a soma
   fmv.s.x ft0, t0 # -1
   fmul.s f4,f4 ft0 # - 4 * A * C
   fadd.s  f3, f3, f4 # B*B - (4 * A * C)
   fmv.s.x ft0, zero
   feq.s t0,ft0,f3
   beq t0, zero, exato
   flt.s t0,f3,ft0
   beq t0,zero, positivo
   j negativo

 
  
   
    
     
      
       
exato: # -b / (2*a)
	li t0, 2
	fmv.s.x ft0, t0
	fmul.s f0, f0, ft0
	
	
positivo:


negativo:
 
  
    
  