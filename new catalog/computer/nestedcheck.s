# Nested procedure in MIPS assembly

main:
    jal outer_proc

    addi $v0, $zero, 10
    syscall

outer_proc:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal inner_proc

    # Restore return address from the stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    jr $ra

inner_proc:
    addi $v0, $zero, 1   
    addi $a0, $zero, 123        
    syscall             

    # Return from inner procedure
    jr $ra