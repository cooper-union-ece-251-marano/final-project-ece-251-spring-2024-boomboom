University: The Cooper Union of Advanced Science and Arts
Course Name: ECE 251 Computer Architecture
Instructor Name: Professor Rob Marano
Final Project: Building and Simulating a MIPS-based RISC.
Teammates: Anthony Kwon, Jonghyeok (Burt) Kim

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

To test our computer, we're simulating a Fibonacci function. 
First initial value is set as 10 in the instruction memory.
The output of the testbench(tb_computer) must be 10th order of fibonacci sequence, which is 89.

Thank you,
Jonghyeok (Burt) Kim and Anthony Kwon 
