.data
    .align 2
SID:
    .word 1240003
    .align 2
median:
    .space 4
    .align 2
min_v:
    .space 4
    .align 2
max_v:
    .space 4
    .align 2
swaps:
    .space 4
    .align 2
arr:
    .space 108
.text
    .align 2
should_swap:
    addi sp,sp,-32
    sw ra,28(sp)
    sw s0,24(sp)
    addi s0,sp,32
    sw a0,-20(s0)
    sw a1,-24(s0)
    lw a4,-20(s0)
    lw a5,-24(s0)
    bge a4,a5,L_2
    li a5,1
    j L_3
L_2:
    li a5,0
L_3:
    mv a0,a5
    lw ra,28(sp)
    lw s0,24(sp)
    addi sp,sp,32
    jr ra
    .align 2
    .globl main
main:
    addi sp,sp,-48
    sw ra,44(sp)
    sw s0,40(sp)
    addi s0,sp,48
    li a5,1241088
    addi a5,a5,-1085
    sw a5,-20(s0)
    sw zero,-24(s0)
    j L_5
L_6:
    lw a4,-20(s0)
    li a5,1662976
    addi a5,a5,1549
    mul a4,a4,a5
    li a5,1013903360
    addi a5,a5,863
    add a5,a4,a5
    sw a5,-20(s0)
    lw a5,-20(s0)
    srli a4,a5,16
    li a5,274878464
    addi a5,a5,-557
    mulhu a5,a4,a5
    srli a5,a5,6
    li a3,1000
    mul a5,a5,a3
    sub a5,a4,a5
    mv a3,a5
    la a5,arr
    mv a4,a5
    lw a5,-24(s0)
    slli a5,a5,2
    add a5,a4,a5
    sw a3,0(a5)
    lw a5,-24(s0)
    addi a5,a5,1
    sw a5,-24(s0)
L_5:
    lw a4,-24(s0)
    li a5,26
    ble a4,a5,L_6
    sw zero,-28(s0)
    j L_7
L_11:
    sw zero,-32(s0)
    j L_8
L_10:
    la a5,arr
    mv a4,a5
    lw a5,-32(s0)
    slli a5,a5,2
    add a5,a4,a5
    lw a3,0(a5)
    lw a5,-32(s0)
    addi a5,a5,1
    la a4,arr
    mv a4,a4
    slli a5,a5,2
    add a5,a4,a5
    lw a5,0(a5)
    mv a1,a5
    mv a0,a3
    call should_swap
    mv a5,a0
    beq a5,zero,L_9
    la a5,arr
    mv a4,a5
    lw a5,-32(s0)
    slli a5,a5,2
    add a5,a4,a5
    lw a5,0(a5)
    sw a5,-36(s0)
    lw a5,-32(s0)
    addi a5,a5,1
    la a4,arr
    mv a4,a4
    slli a5,a5,2
    add a5,a4,a5
    lw a4,0(a5)
    la a5,arr
    mv a3,a5
    lw a5,-32(s0)
    slli a5,a5,2
    add a5,a3,a5
    sw a4,0(a5)
    lw a5,-32(s0)
    addi a5,a5,1
    la a4,arr
    mv a4,a4
    slli a5,a5,2
    add a5,a4,a5
    lw a4,-36(s0)
    sw a4,0(a5)
    la a5,swaps
    lw a5,0(a5)
    addi a4,a5,1
    la a5,swaps
    sw a4,0(a5)
L_9:
    lw a5,-32(s0)
    addi a5,a5,1
    sw a5,-32(s0)
L_8:
    li a4,26
    lw a5,-28(s0)
    sub a5,a4,a5
    lw a4,-32(s0)
    blt a4,a5,L_10
    lw a5,-28(s0)
    addi a5,a5,1
    sw a5,-28(s0)
L_7:
    lw a4,-28(s0)
    li a5,25
    ble a4,a5,L_11
    la a5,arr
    mv a5,a5
    lw a5,52(a5)
    andi a4,a5,1023
    la a5,median
    sw a4,0(a5)
    la a5,arr
    mv a5,a5
    lw a4,0(a5)
    la a5,max_v
    sw a4,0(a5)
    la a5,arr
    mv a5,a5
    lw a4,104(a5)
    la a5,min_v
    sw a4,0(a5)
    li a5,0
    mv a0,a5
    lw ra,44(sp)
    lw s0,40(sp)
    addi sp,sp,48
    li a7,10
    ecall
