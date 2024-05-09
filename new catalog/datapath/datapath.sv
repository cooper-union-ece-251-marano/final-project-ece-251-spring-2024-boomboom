//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (cpu)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../sl2/sl2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, reset,
    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [3:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc, jalout,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata, 
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    wire [6:0]  writereg, muxreg;
    wire [(n-1):0] pcnext, pcnextbr, pcnextbr2, pcplus4, pcbranch;
    wire [(n-1):0] signimm, signimmsh;
    wire [(n-1):0] srca, srcb;
    wire [(n-1):0] result;
    wire jrsrc, jalsrc, hi, lo;

    // "next PC" logic
    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, 32'b100, pcplus4);
    sl2         immsh(signimm, signimmsh);
    adder       pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(n)   pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnextbr2);
    
    mux2 #(n)   jrmux(pcnextbr2, srca, jrsrc, pcnext);
    // Comment: pcplus4[31:28] might need to be fixed here. Or not.

    // register file logic
    // From regfile     rf(clk, regwrite, instr[25:19], instr[18:12], writereg, result, srca, writedata);
    regfile     rf(clk, regwrite, instr[25:19], instr[18:12], writereg, result, srca, writedata);
    mux2 #(7)   wrmux(muxreg, instr[11:5], regdst, writereg);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);
    signext     se(instr[11:0], signimm);

    // ALU logic
    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(srca, srcb, alucontrol, aluout, zero);
    //jal
    mux2 #(n) jalMux(result, pcplus4, jalsrc, jalout);
    mux2 #(7) jalMux2(instr[18:12], 7'd127, jalsrc, muxreg);


endmodule

`endif // DATAPATH
