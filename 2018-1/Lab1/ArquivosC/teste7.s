	.file	"teste7.c"
	.option nopic
	.section	.rodata
	.align	3
.LC0:
	.string	"Digite um numero:"
	.align	3
.LC1:
	.string	"%d"
	.align	3
.LC2:
	.string	"O resultado eh %f\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	lw	a5,-24(s0)
	sext.w	a5,a5
	andi	a5,a5,1
	sext.w	a5,a5
	bnez	a5,.L2
	lw	a5,-24(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a5,a5
	fcvt.s.w	fa5,a5
	fsw	fa5,-20(s0)
	j	.L3
.L2:
	lw	a5,-24(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,3
	addw	a5,a5,a4
	sext.w	a5,a5
	fcvt.s.w	fa5,a5
	fsw	fa5,-20(s0)
.L3:
	flw	fa5,-20(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
