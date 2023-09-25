#PROGRAM: fibonacci
    
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
    la $s0 mat                 # load  *mat in $s0   
    sw $t1 ($s0)
	sw $t1 4($s0)
	sw $t1 8($s0)
	sw $zero 12($s0)

    addi $sp, $sp, -4        # before matrixPower function Call, save $ra on stack
    sw $ra, ($sp)

    addi $a1 $a0 -1          # n-1을 두번째 인자로 넘겨줌
    add $a0 $s0 $zero        # mat 을 첫번째 인자로 넘겨줌. 
    
    jal MatrixPower
	
    lw $v0 ($s0)           # $v[0] <= mat[0]
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

fibonacci_end1:
	li $v0 0
    jr $ra
	
fibonacci_end2:
    li $v0 1
    jr $ra


MatrixPower:
    addi $sp, $sp, -16
    sw $a0, 0($sp)
    sw $a1, 4($sp)  
    sw $ra, 8($sp)
    sw $s0, 12($sp)

                                # if(n<=1),  restore stack and jump to $ra
    li $t1 1                    # t1 <- 1 
    slti $t2 $a1 1              # t2 == 1 if n<1
    beq $t2 $t1  matrixPower_end1           
    beq $a1 $t1  matrixPower_end1         # t3 == 1 if n=1


                                # for문 temp[i] = mat[i] 
    addi $sp, $sp, -16          # $sp  <- *temp 
    lw $t0 ($a0)
    sw $t0 0($sp)
    lw $t0 4($a0)
    sw $t0 4($sp)
    lw $t0 8($a0)
    sw $t0 8($sp)
    lw $t0 12($a0)
    sw $t0 12($sp)

                                         #call matrixPower
    # li $t1, 2
    # div $a1, $t1
    # mflo $a1                                # $a1 <- (int) n/2
    # jal MatrixPower

                                            #call multiply 
    add $a1 $a0 $zero
    jal Multiply

    #                                         #if(n%2 == 1) call multiply(mat, temp)
    # li $t1 2
    # rem  $t2 $a1 $t1                        # $t2 = s1 % s2  gives remainder
    # bne $t2 $zero callMultiply2             # 나머지는 0 아니면 1 나머지가 1일경우 callMultimpy2

    addi $sp, $sp, 16                       # temp 부분 은 local var.
                                            ## restore stack and jump to $ra
    lw $a0, 0($sp)  
    lw $a1, 4($sp)  
    lw $ra, 8($sp)
    lw $s0, 12($sp)
    addi $sp, $sp, 16
    j $ra

matrixPower_end1:
    lw $a0, 0($sp)
    lw $a1, 4($sp)  
    lw $ra, 8($sp)
    lw $s0, 12($sp)
    addi $sp, $sp, 16
    j $ra

# callMultiply2:
#     add $a1 $zero $sp               # $a1 <= temp 
#     jal Multiply
        
Multiply:
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)  
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    
	lw $t0 ($a0)
	lw $t1 4($a0)
	lw $t2 8($a0)   
	lw $t3 12($a0)
	lw $t4 ($a1)
	lw $t5 4($a1)
	lw $t6 8($a1)   
	lw $t7 12($a1)

	mul $s0 $t0 $t4 
	mul $s1 $t1 $t5
	add $s0 $s0 $s1

	mul $s1 $t0 $t5
	mul $s2 $t1 $t7
	add $s1 $s1 $s2 

	mul $s2 $t2 $t4
	mul $s3 $t3 $t6
	add $s2 $s2 $s3

	mul $s3 $t2 $t5
	mul $s4 $t3 $t7
	add $s3 $s3 $s4

	sw $s0 ($a0)
	sw $s1 4($a0)
	sw $s2 8($a0)
	sw $s3 12($a0)
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)  
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    addi $sp, $sp, 16

	jr $ra
