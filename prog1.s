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
	sw $v0 0($t0)
	move $a0 $t1
	la $t0 vars
	lw $a0 0($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 2
	lw $t0 4($sp)
	addiu $sp $sp 4
	div $t0 $a0
	mflo $a0
	la $t0 vars
	sw $a0 8($t0)
	la $t0 vars
	lw $a0 8($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 5
	lw $t0 4($sp)
	addiu $sp $sp 4
	add $a0 $t0 $a0
	li $v0 1
	syscall
	move $t0 $a0
	li $v0 11
	li $a0 10
	syscall
	move $a0 $t0
	la $t0 vars
	lw $a0 0($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	la $t0 vars
	lw $a0 8($t0)
	sw $a0 0($sp)
	addiu $sp $sp -4
	li $a0 10
	lw $t0 4($sp)
	addiu $sp $sp 4
	mul $a0 $t0 $a0
	lw $t0 4($sp)
	addiu $sp $sp 4
	sub $a0 $t0 $a0
	la $t0 vars
	sw $a0 12($t0)
	la $t0 vars
	lw $a0 12($t0)
	li $v0 1
	syscall
	move $t0 $a0
	li $v0 11
	li $a0 10
	syscall
	move $a0 $t0
	li	$v0 10	# Code for syscall: exit
	syscall

