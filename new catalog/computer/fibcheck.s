# Fibonacci funcion in MIPS assembly

.text
.globl main         
main:
    addi $v0, $zero, 5 
    syscall  
    addi $a0, $v0, 0
    jal fib
    add $a0, $v0, $zero 
    jal print_int 
    addi $v0, $zero, 4      
    addi $a0, $gp, 100   
    syscall       
    addi $v0, $zero, 10     
    syscall        
fib:
    addi $v0, $zero, 1              
    beq $a0, 0, exit      
    addi $t1, $zero, 1  
    beq  $a0, $t1, continue 
    j    recurse   
continue:
    addi $v0, $zero, 0              
    beq $a0, 0, exit      
    addi $v0, $zero, 1            
    jr $ra          

recurse:
    sub $sp, $sp, 16     
    sw $ra, 0($sp)         
    sw $a0, 4($sp)         
    addi $a0, $a0, -1      
    jal fib               
    lw $a1, 4($sp)         
    sw $v0, 8($sp)       

    addi $a0, $a1, -2     
    jal fib               
    lw $t0, 8($sp)         

    add $v0, $v0, $t0    

    lw $ra, 0($sp)         
    addi $sp, $sp, 16      # Deallocate stack space

exit:
    jr $ra                 # Return to caller

print_int:
    addi $v0, $zero, 1      
    syscall               
    jr $ra                 # Return to caller
