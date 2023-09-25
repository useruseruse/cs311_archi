# PROGRAM: fibonacci
    
    .data		# Data declaration section

	mat:  
		.word 4

	.text

main:
    addi $sp, $sp, -4
    sw $ra, ($sp)

    li $v0 5    
    syscall                 # call scanf 
    move $a0 $v0            # $a0 <- result of scanf

    jal Fibonacci

    move $a0 $v0           # $a0 <- result of fibonacci 
    li $v0 1               # call printf
    syscall  
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

Fibonacci:
    
    beq     $a0 $zero fibonacci_end1      #if n==0 
    addi    $t0 $a0 -1                      #if n==1
	beq     $t0 $zero fibonacci_end2

    li $t1 1
    la $t2 mat                 # load  *mat in $t2    
    sw $t1 ($t2)
	sw $t1 4($t2)
	sw $t1 8($t2)
	sw $zero 12($t2)

    addi $sp, $sp, -4        # before matrixPower function Call, save $ra on stack
    sw $ra, ($sp)

    addi $a1 $a0 -1          # n-1을 두번째 인자로 넘겨줌
    add $a0 $t2 $zero        # mat 을 첫번째 인자로 넘겨줌. 
    
    jal MatrixPower
	
    lw $v0 ($t2)           # $v[0] <= mat[0]
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

fibonacci_end1:
	li $v0 0
    jr $ra
	
fibonacci_end2:
    li $v0 1
    jr $ra

