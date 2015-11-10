.data
vars: .word 0:26
prompt: .asciiz	"Input: "
.text
.globl main
main:
	move $t1 $a0
	li	$v0 4
	la	$a0 prompt
	syscall
	li $v0 5
	syscall
	la $t0 vars
	sw $v0 52($t0)
	move $a0 $t1
	li $a0 0
	la $t0 vars
	sw $a0 0($t0)
	li $a0 0
	la $t0 vars
	sw $a0 56($t0)
	li $a0 0
	la $t0 vars
	sw $a0 16($t0)
LOOP0:
	la $t0 vars
	lw $a0 0($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	la $t0 vars
	lw $a0 52($t0)
	lw $t0 4($sp)
	addiu $sp $sp 4
	move $t1 $a0
	li $a0 1
	ble $t0 $t1 SKIP0
	li $a0 0
SKIP0:
	li $t0 0
	beq $a0 $t0 END_LOOP0
	la $t0 vars
	lw $a0 0($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 1
	lw $t0 4($sp)
	addiu $sp $sp 4
	and $a0 $t0 $a0
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 1
	lw $t0 4($sp)
	addiu $sp $sp 4
	move $t1 $a0
	li $a0 1
	beq $t0 $t1 SKIP1
	li $a0 0
SKIP1:
	li $t0 0
	beq $a0 $t0 ELSE0
	la $t0 vars
	lw $a0 56($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	la $t0 vars
	lw $a0 0($t0)
	lw $t0 4($sp)
	addiu $sp $sp 4
	add $a0 $t0 $a0
	la $t0 vars
	sw $a0 56($t0)
	j END_IF0
ELSE0:
	la $t0 vars
	lw $a0 16($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	la $t0 vars
	lw $a0 0($t0)
	lw $t0 4($sp)
	addiu $sp $sp 4
	add $a0 $t0 $a0
	la $t0 vars
	sw $a0 16($t0)
END_IF0:
	la $t0 vars
	lw $a0 0($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 1
	lw $t0 4($sp)
	addiu $sp $sp 4
	add $a0 $t0 $a0
	la $t0 vars
	sw $a0 0($t0)
	j LOOP0
END_LOOP0:
	la $t0 vars
	lw $a0 56($t0)
	li $v0 1
	syscall
	move $t0 $a0
	li $v0 11
	li $a0 10
	syscall
	move $a0 $t0
	la $t0 vars
	lw $a0 16($t0)
	li $v0 1
	syscall
	move $t0 $a0
	li $v0 11
	li $a0 10
	syscall
	move $a0 $t0
	li	$v0 10	# Code for syscall: exit
	syscall

