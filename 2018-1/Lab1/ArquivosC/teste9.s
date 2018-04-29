	.file	"teste9.c"
	.option nopic
	.text
	.align	2
	.globl	proc
	.type	proc, @function
proc:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	mv	a5,a1
	sb	a5,-37(s0)
	lbu	a5,-37(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a3,a5
	lbu	a5,-37(s0)
	addi	a5,a5,1
	lw	a4,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mul	a5,a3,a5
	fcvt.s.w	fa5,a5
	fsw	fa5,-20(s0)
	flw	fa5,-20(s0)
	fmv.s	fa0,fa5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	proc, .-proc
	.section	.rodata
	.align	2
.LC1:
	.string	"Digite um numero:"
	.align	2
.LC2:
	.string	"%d"
	.globl	__extendsfdf2
	.align	2
.LC3:
	.string	"Resultado:%f\n"
	.align	2
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
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	lw	a4,%lo(.LC0)(a5)
	sw	a4,-28(s0)
	addi	a4,a5,%lo(.LC0)
	lw	a4,4(a4)
	sw	a4,-24(s0)
	addi	a5,a5,%lo(.LC0)
	lhu	a5,8(a5)
	sh	a5,-20(s0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-17
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	lbu	a4,-17(s0)
	addi	a5,s0,-28
	mv	a1,a4
	mv	a0,a5
	call	proc
	fmv.s	fa5,fa0
	fmv.s	fa0,fa5
	call	__extendsfdf2
	mv	a5,a0
	mv	a6,a1
	mv	a2,a5
	mv	a3,a6
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
