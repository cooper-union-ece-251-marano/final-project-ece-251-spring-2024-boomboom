//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 261 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
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
    input  logic [5:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump, jrsrc, jalsrc,
    output logic [1:0] aluop,
    output logic [3:0] funct
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    //
    logic [8:0] controls; // 9-bit control vector

    // controls has 9 logical signals
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, jrsrc, jalsrc} = controls;
    assign aluop = op[5:4];
    assign funct = op[3:0];
    // regwrite 1, regdst 1 bit, alusrc 1 bit, branch 1 bit, memwrite 1 bit, memtoreg 1 bit, jump 1 bit, aluop 2 bit 
    
    always @* begin
        case(op)
            6'b000001: controls <= 9'b110000000; // add
            6'b000010: controls <= 9'b110000000; // sub
            6'b000011: controls <= 9'b110000000; // mul
            6'b000100: controls <= 9'b110000000; // div
            6'b000101: controls <= 9'b110000000; // or
            6'b000110: controls <= 9'b110000000; // and
            6'b000111: controls <= 9'b110000000; // nor
            6'b001000: controls <= 9'b110000000; // xor
            6'b001001: controls <= 9'b110000000; // sll
            6'b001010: controls <= 9'b110000000; // srl
            6'b001011: controls <= 9'b110000000; // slt

            6'b010000: controls <= 9'b000100000; // beq 
            6'b100000: controls <= 9'b101001000; // lw
            6'b100001: controls <= 9'b001010000; // sw
            6'b100010: controls <= 9'b101000000; // addi

            6'b110000: controls <= 9'b000000100; // j
            6'b110001: controls <= 9'b100000101; // jal
            6'b110011: controls <= 9'b000000110; // jr
            default:   controls <= 9'bxxxxxxxxx; 
        endcase
    end

endmodule

`endif // MAINDEC