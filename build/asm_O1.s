	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	should_swap
	.type	should_swap, @function
should_swap:
	slt	a0,a0,a1
	ret
	.size	should_swap, .-should_swap
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a7,%hi(.LANCHOR0)
	addi	a7,a7,%lo(.LANCHOR0)
	addi	t3,a7,108
	mv	a2,a7
	li	a4,1241088
	addi	a4,a4,-1085
	li	a6,1662976
	addi	a6,a6,1549
	li	a0,1013903360
	addi	a0,a0,863
	li	a1,274878464
	addi	a1,a1,-557
	li	t1,1000
.L3:
	mul	a4,a4,a6
	add	a4,a4,a0
	srli	a3,a4,16
	mulhu	a5,a3,a1
	srli	a5,a5,6
	mul	a5,a5,t1
	sub	a3,a3,a5
	sw	a3,0(a2)
	addi	a2,a2,4
	bne	a2,t3,.L3
	lui	a5,%hi(swaps)
	lw	a1,%lo(swaps)(a5)
	addi	a2,a7,104
	li	a0,0
	li	a6,1
	j	.L4
.L5:
	addi	a5,a5,4
	beq	a5,a2,.L11
.L6:
	lw	a4,0(a5)
	lw	a3,4(a5)
	bge	a4,a3,.L5
	sw	a3,0(a5)
	sw	a4,4(a5)
	addi	a1,a1,1
	mv	a0,a6
	j	.L5
.L11:
	addi	a2,a2,-4
	beq	a2,a7,.L7
.L4:
	mv	a5,a7
	j	.L6
.L7:
	beq	a0,zero,.L8
	lui	a5,%hi(swaps)
	sw	a1,%lo(swaps)(a5)
.L8:
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	a4,52(a5)
	andi	a4,a4,1023
	lui	a3,%hi(median)
	sw	a4,%lo(median)(a3)
	lw	a3,0(a5)
	lui	a4,%hi(maxV)
	sw	a3,%lo(maxV)(a4)
	lw	a4,104(a5)
	lui	a5,%hi(minV)
	sw	a4,%lo(minV)(a5)
	li	a0,0
	ret
	.size	main, .-main
	.globl	swaps
	.globl	maxV
	.globl	minV
	.globl	median
	.globl	arr
	.globl	SID
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	arr, @object
	.size	arr, 108
arr:
	.zero	108
	.section	.sbss,"aw",@nobits
	.align	2
	.type	swaps, @object
	.size	swaps, 4
swaps:
	.zero	4
	.type	maxV, @object
	.size	maxV, 4
maxV:
	.zero	4
	.type	minV, @object
	.size	minV, 4
minV:
	.zero	4
	.type	median, @object
	.size	median, 4
median:
	.zero	4
	.section	.srodata,"a"
	.align	2
	.type	SID, @object
	.size	SID, 4
SID:
	.word	1240003
	.ident	"GCC: (Arch Linux Repositories) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
