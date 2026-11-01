	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	SID
	.section	.srodata,"a"
	.align	2
	.type	SID, @object
	.size	SID, 4
SID:
	.word	706272707
	.globl	arr
	.bss
	.align	2
	.type	arr, @object
	.size	arr, 108
arr:
	.zero	108
	.globl	median
	.section	.sbss,"aw",@nobits
	.align	2
	.type	median, @object
	.size	median, 4
median:
	.zero	4
	.globl	minV
	.align	2
	.type	minV, @object
	.size	minV, 4
minV:
	.zero	4
	.globl	maxV
	.align	2
	.type	maxV, @object
	.size	maxV, 4
maxV:
	.zero	4
	.globl	swaps
	.align	2
	.type	swaps, @object
	.size	swaps, 4
swaps:
	.zero	4
	.text
	.align	2
	.globl	should_swap
	.type	should_swap, @function
should_swap:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	bge	a4,a5,.L2
	li	a5,1
	j	.L3
.L2:
	li	a5,0
.L3:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	should_swap, .-should_swap
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	li	a5,706273280
	addi	a5,a5,-573
	sw	a5,-20(s0)
	sw	zero,-24(s0)
	j	.L5
.L6:
	lw	a4,-20(s0)
	li	a5,1662976
	addi	a5,a5,1549
	mul	a4,a4,a5
	li	a5,1013903360
	addi	a5,a5,863
	add	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	srli	a4,a5,16
	li	a5,274878464
	addi	a5,a5,-557
	mulhu	a5,a4,a5
	srli	a5,a5,6
	li	a3,1000
	mul	a5,a5,a3
	sub	a5,a4,a5
	mv	a3,a5
	lui	a5,%hi(arr)
	addi	a4,a5,%lo(arr)
	lw	a5,-24(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L5:
	lw	a4,-24(s0)
	li	a5,26
	ble	a4,a5,.L6
	sw	zero,-28(s0)
	j	.L7
.L11:
	sw	zero,-32(s0)
	j	.L8
.L10:
	lui	a5,%hi(arr)
	addi	a4,a5,%lo(arr)
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lw	a5,-32(s0)
	addi	a5,a5,1
	lui	a4,%hi(arr)
	addi	a4,a4,%lo(arr)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	should_swap
	mv	a5,a0
	beq	a5,zero,.L9
	lui	a5,%hi(arr)
	addi	a4,a5,%lo(arr)
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	addi	a5,a5,1
	lui	a4,%hi(arr)
	addi	a4,a4,%lo(arr)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(arr)
	addi	a3,a5,%lo(arr)
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lw	a5,-32(s0)
	addi	a5,a5,1
	lui	a4,%hi(arr)
	addi	a4,a4,%lo(arr)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-36(s0)
	sw	a4,0(a5)
	lui	a5,%hi(swaps)
	lw	a5,%lo(swaps)(a5)
	addi	a4,a5,1
	lui	a5,%hi(swaps)
	sw	a4,%lo(swaps)(a5)
.L9:
	lw	a5,-32(s0)
	addi	a5,a5,1
	sw	a5,-32(s0)
.L8:
	li	a4,26
	lw	a5,-28(s0)
	sub	a5,a4,a5
	lw	a4,-32(s0)
	blt	a4,a5,.L10
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L7:
	lw	a4,-28(s0)
	li	a5,25
	ble	a4,a5,.L11
	lui	a5,%hi(arr)
	addi	a5,a5,%lo(arr)
	lw	a5,52(a5)
	andi	a4,a5,1023
	lui	a5,%hi(median)
	sw	a4,%lo(median)(a5)
	lui	a5,%hi(arr)
	addi	a5,a5,%lo(arr)
	lw	a4,0(a5)
	lui	a5,%hi(maxV)
	sw	a4,%lo(maxV)(a5)
	lui	a5,%hi(arr)
	addi	a5,a5,%lo(arr)
	lw	a4,104(a5)
	lui	a5,%hi(minV)
	sw	a4,%lo(minV)(a5)
	li	a5,0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (Arch Linux Repositories) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
