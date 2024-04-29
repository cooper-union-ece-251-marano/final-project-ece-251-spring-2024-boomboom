//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //

    input logic [3:0] funct;
    input logic [1:0] alup;
    output logic [3:0] aluctrl;


    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    always @* begin
	    case(aluop)
	    	2'b01: aluctrl <= 4'b0010; // sub for BEQ
	    	2'b10: aluctrl <= 4'b0001; // add for LW,SW,ADDI
	    	2'b11: aluctrl <= 4'bxxxx; // for when not in use
		default: begin
			case(funct)
				aluctrl <= funct;
				default:
					aluctrl <= 4'bxxxx;
			endcase
	    	end
	    endcase
    end

endmodule

`endif // ALUDEC
