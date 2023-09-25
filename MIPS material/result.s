# PROGRAM: fibonacci
    
    .data		# Data declaration section

	list: 

	.text

main:
    li $a0 4
    jal fibonacci


fibonacci:
    beq $a0 $zero End1
    addi $t0 $a0 -1 
	beq $t0 $zero End2
    
    li $t1 1
    addi $sp, $sp, -16
    sw $t1 ($sp)
	sw $t1 4($sp)
	sw $t1 8($sp)
	sw $zero 12($sp)

    add $a0 $s0 zero    // mat 을 첫번째 인자로 넘겨줌. 
    addi $a1 $a0 -1    // n-1을 두번째 인자로 넘겨줌
    jal matrixPower
	
    # $v[0] <= $s[0]
    addi $sp, $sp, 16
	jr $ra

End1:
	li $v0 0
	jr $ra 
	
	
End2:
    li $v0 1
    jr $ra 



