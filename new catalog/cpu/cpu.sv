//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-03
//     Module Name: cpu
//     Description: 32-bit RISC-based CPU (MIPS)
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
    output logic [(n-1):0] aluout, writedata, jalout, // jalout added
    input  logic [(n-1):0] readdata, 
    output logic hi, lo // hi and lo added
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic       memtoreg, alusrc, regdst, regwrite, jump, jrsrc, jalsrc, pcsrc, zero;
    logic [3:0] alucontrol;
    
    controller c(instr[(31):26], zero,
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump, jrsrc, jalsrc,
                    alucontrol);

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump, jrsrc, jalsrc,
                    alucontrol,
                    zero, pc, jalout, instr, // jalout added
                    aluout, writedata, hi, lo, readdata); // hi and lo added

endmodule

`endif // CPU