//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
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
        input logic [3:0] funct,
        input logic [1:0] aluop,
        output logic [3:0] aluctrl
    );

    // Default initialization
    initial aluctrl = 4'b0000;

    // Combinational logic to determine ALU control signal
    always @* begin
        case(aluop)
            2'b01: aluctrl <= 4'b0010; // sub for BEQ
	    	2'b10: aluctrl <= 4'b0001; // add for LW,SW,ADDI
	    	2'b11: aluctrl <= 4'bxxxx; // for when not in use
            default: begin
                if (funct > 0) begin
                	aluctrl <= funct;
            	end else begin
                	aluctrl <= 4'bxxxx;
            	end
            end
        endcase
    end

endmodule

`endif // ALUDEC
