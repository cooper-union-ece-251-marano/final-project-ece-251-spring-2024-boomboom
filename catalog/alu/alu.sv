//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    input logic [n-1:0] A,B,
    input logic [3:0] FUNCT,
    output logic [n-1:0] Y, Hi, Lo,
    output logic [n+n-1:0] Hilo,
    output logic zero

    //
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign zero = (result == {n{1'b0}});
    always @(A or B or FUNCT) begin
	    case(FUNCT)
		    4'b0001: Y = A + B; //add
		    4'b0010: Y = A - B; //sub
		    4'b0011: Hilo = A*B; //mult
			     Hi = Hilo[n+n-1:n];
			     Lo = Hilo[n-1:0];
		    4'b0100: Lo = A/B; //div
		    	     Hi = A%B;
		    4'b0100: Y = A/B;
		    4'b0101: Y = A|B; //or
		    4'b0110: Y = A&B; //and
		    4'b0111: Y = ~(A|B); //nor
		    4'b1000: Y = A^B; //xor
		    4'b1001: Y = A<<B; //sll
		    4'b1010: Y = A>>B; //srl
		    4'b1011: Y = (A < B) ? 1:0; //slt
		endcase
	end

		    


endmodule

`endif // ALU
