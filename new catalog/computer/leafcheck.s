# Leaf procedure in MIPS assembly
    .data  
msg: .asciiz "Loop Counter: " 

    .text              
    .globl main

main:
    li $a0, 10 
    jal leaf_proc  

    li $v0, 10 
    syscall 

leaf_proc:
    addi $t0, $zero, 0            
 
    loop_start:
        beq $t0, $a0, loop_end 
        addi $t0, $t0, 1    # $t0 = $t0 + 1
        j loop_start

    loop_end:
    jr $ra               # Return from procedure