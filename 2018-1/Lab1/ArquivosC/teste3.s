.data
.LC0:	.word	1069547520
	
.LC1:	.word	1075838976
	

.text
main:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)#(a5)
	fsw	fa5,-20(s0)
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)#(a5)
	fsw	fa5,-24(s0)
	flw	fa4,-20(s0)
	flw	fa5,-24(s0)
	fmul.s	fa5,fa4,fa5
	fmv.s	fa0,fa5
	lw	s0,28(sp)
	addi	sp,sp,32
	
	li a7, 1
	ecall
