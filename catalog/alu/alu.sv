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
    input logic [2:0] S,
    output logic [n-1:0] Y,

    //
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    always @(A or B or S)
	    case(S)
		    3'b000: Y = A + B; //add
		    3'b001: Y = A - B; //sub
		    3'b010: Y = A|B; //or
		    3'b011: Y = A&B; //and
		    3'b100: Y = A<<B; //sll
		    3'b101: Y = A>>B; //srl
		    3'b110: Y = ~(A|B); //nor
		    3'b111: Y = (A < B) ? 1:0; //slt

		endcase
	end

		    


endmodule

`endif // ALU
