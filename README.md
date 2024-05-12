# Final Project: Building and Simulating a MIPS-based RISC.
University: The Cooper Union of Advanced Science and Arts

Course Name: ECE 251 Computer Architecture

Instructor Name: Professor Rob Marano

Teammates: Anthony Kwon, Jonghyeok (Burt) Kim

## Explanation of How Our Computer Works
### Instruction Types
Our computer is built using 32-bit MIPS words featuring unique instruction formats.

Rather than using common basic instruction formats, our computer runs based on the following basic instruction formats:

R type: instr[31:26] = OP code, instr[25:19] = rs, instr[18:12] = rt, instr[11:5] = rd, instr[4:0] = shamt

I type: instr[31:26] = OP code, instr[25:19] = rs, instr[18:12] = rt, instr[11:0] = immediate

J type: instr[31:26] = OP code, instr[25:0] = address.

In our OP code, first two digits represent the type of insructions, and the last four digits represent funct code. 

Instruction type correseonding to the first two digits of OP code:

	00 = R type
 
	01 = I type
 
	00 = J type.

By employing this approach, we can utilize 7-bit registers.

The cons of constructing this computer is that we can have fewer instructions than other computers have.

### Registers
We set our registers as the following numbers(decimal):

0: $zero

1: Hi

2: Lo

3-10: $a0-$a9 (Funct)

11-20: $t0-$9 (Arguments)

21-40: $t0-$t19 (Temporaries)

41-120: $s0-$s79 (Saved temporaries)

124: $gp (global pointer)

125: $sp (stack pointer)

126: $fp (frame pointer)

127: $ra (return address)

### Test bench
### 1. Fibonacci Function

An initial input is set to be 10.

The output of the testbench(tb_computer) must be 10th order of fibonacci sequence, which is 89.

### 2. Leaf Procedure

An initial value of $to is set to be 0, and an initial value of $a0 is set to be 10.

For every loop, $t0 is incremented by 1.

When $t0's value equals to the value of $a0, the for loop breaks.

### 3. Nested Procedure

In outer_proc, space is allocated on the stack by decrementing the stack pointer $sp by 4 bytes using addi $sp, $sp, -4. 

The return address ($ra) is then stored on the stack using sw $ra, 0($sp).

The jal instruction is used again to call the inner_proc.

Inside inner_proc, the system call to print an integer (syscall) is invoked. 

In this case, the integer value 123 is loaded into register $a0, and the system call code 1 (which represents printing an integer) is loaded into register $v0.

After printing the integer, the jr $ra instruction is used to return from the inner_proc procedure, jumping back to the return address stored in $ra.

Back in outer_proc, the return address is retrieved from the stack using lw $ra, 0($sp), and the stack pointer is incremented to deallocate the space used for the return address.

Finally, jr $ra is used to return from outer_proc, jumping back to the return address stored in $ra when main called outer_proc. 

This effectively returns control back to main, which then ends the instruction by loading 10 into $v0.

Thank you,

Anthony Kwon and Jonghyeok (Burt) Kim
