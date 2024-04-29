//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 261 Spring 2024
// Engineer: Jonghyeok Kim, Anthony Kwon
// 
//     Create Date: 2024-04-28
//     Module Name: maindec
//     Description: 32-bit RISC-based CPU main decoder (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [6:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [1:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [8:0] controls; // 9-bit control vector

    // controls has 9 logical signals
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;
    // regwrite 1, regdst 1 bit, alusrc 1 bit, branch 1 bit, memwrite 1 bit, memtoreg 1 bit, jump 1 bit, aluop 2 bit 
    
    always @* begin
        case(op)
            6'b000000: controls <= 9'b000000000; // add
			6'b000001: controls <= 9'b000000001; // sub
			6'b000010: controls <= 9'b000000100; // and
			6'b000011: controls <= 9'b000000101; // or
			6'b000100: controls <= 9'b000000010; // sl
			6'b000101: controls <= 9'b000000011; // sr
			6'b000110: controls <= 9'b000000110; // xor
			6'b000111: controls <= 9'b000000111; // nor
			6'b001000: controls <= 9'b000001000; // nand
			6'b001001: controls <= 9'b000001001; // not
			6'b001010: controls <= 9'b000001010; // jr
			6'b001011: controls <= 9'b000001011; // slt
			6'b001100: controls <= 9'b000001100; // sgt
			6'b001101: controls <= 9'b000001101; // addi 
			6'b001110: controls <= 9'b000001110; // subi
			6'b001111: controls <= 9'b000010000; // lw
			6'b010000: controls <= 9'b000010001; // sw
			6'b010001: controls <= 9'b000010010; // beq
			6'b010010: controls <= 9'b000010011; // bne
			6'b010011: controls <= 9'b000010100; // j
			6'b010100: controls <= 9'b000010101; // jal
        endcase
    end

endmodule

`endif // MAINDEC
