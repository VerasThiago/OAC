	.file	"teste9.c"
	.option nopic
	.text
	.align	2
	.globl	proc
	.type	proc, @function
proc:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sb	a5,-41(s0)
	lbu	a5,-41(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a4,a5
	lbu	a5,-41(s0)
	addi	a5,a5,1
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	mulw	a5,a4,a5
	sext.w	a5,a5
	fcvt.s.w	fa5,a5
	fsw	fa5,-20(s0)
	flw	fa5,-20(s0)
	fmv.s	fa0,fa5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	proc, .-proc
	.section	.rodata
	.align	3
.LC1:
	.string	"Digite um numero:"
	.align	3
.LC2:
	.string	"%d"
	.align	3
.LC3:
	.string	"Resultado:%f\n"
	.align	3
.LC0:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
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
	ld	a4,%lo(.LC0)(a5)
	sd	a4,-32(s0)
	addi	a5,a5,%lo(.LC0)
	lhu	a5,8(a5)
	sh	a5,-24(s0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-17
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	lbu	a4,-17(s0)
	addi	a5,s0,-32
	mv	a1,a4
	mv	a0,a5
	call	proc
	fmv.s	fa5,fa0
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
