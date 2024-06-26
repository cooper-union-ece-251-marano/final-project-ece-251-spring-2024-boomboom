//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller (cpu)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op,
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst,
    output logic       regwrite,
    output logic       jump,
    output logic [3:0] alucontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    wire [1:0] aluop;
    logic [3:0] funct;
    wire       branch, jrsrc, jalsrc;
    
    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, jrsrc, jalsrc, aluop, funct);
    // CPU's ALU decoder
    aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
