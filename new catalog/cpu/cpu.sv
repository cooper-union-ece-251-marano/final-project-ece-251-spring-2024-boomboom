//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-03
//     Module Name: cpu
//     Description: 32-bit RISC-based CPU (cpu)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    wire       memtoreg, alusrc, regdst, jump, jrsrc, jalsrc, pcsrc, zero, hi, lo;
    wire      regwrite;
    wire [3:0] alucontrol;

    controller c(instr[(31):26], zero,
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol);

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol,
                    zero, pc, instr,
                    aluout, writedata, readdata); // hi and lo deleted

endmodule

`endif // CPU
