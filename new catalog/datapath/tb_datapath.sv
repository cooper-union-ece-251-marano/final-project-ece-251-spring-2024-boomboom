//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tb_datapath
//     Description: Test bench for the 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_DATAPATH
`define TB_DATAPATH

`timescale 1ns/100ps
`include "datapath.sv"

module tb_datapath;
    parameter n = 32;
    reg clk, reset;
    reg memtoreg, pcsrc, alusrc, regdst, regwrite, jump, jrsrc, jalsrc;
    reg [3:0] alucontrol;
    reg [(n-1):0] instr, readdata;
    wire zero;
    wire [(n-1):0] pc, aluout, writedata; 
    wire hi, lo; 
    wire [(n-1):0] jalout;

    datapath #(.n(n)) DUT (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .jrsrc(jrsrc),
        .jalsrc(jalsrc),
        .alucontrol(alucontrol),
        .zero(zero),
        .pc(pc),
        .jalout(jalout),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .hi(hi),
        .lo(lo),
        .readdata(readdata)
    );

    // Clock check
    always begin
        clk = 1'b0;
        #5 clk = 1'b1;
        #5 clk = 1'b0;
    end

    initial begin
        $dumpfile("datapath_tb.vcd");
        $dumpvars(0, tb_datapath);
        reset = 1'b1;
        memtoreg = 0; pcsrc = 0; alusrc = 0; regdst = 0; regwrite = 0; jump = 0; jrsrc = 0; jalsrc = 0;
        alucontrol = 4'b0000;
        instr = 32'h00000000;
        readdata = 32'h00000000;
        #10 reset = 1'b0; 

        #10 instr = 32'h20100010;
        regwrite = 1; alusrc = 1; regdst = 1; alucontrol = 4'b0010; 
        #20;

        #10 $finish;
    end

    initial begin
        $monitor("Time: %t | PC: %h | ALUOut: %h | WriteData: %h | Hi: %h | Lo: %h | Zero: %b | JALOut: %h",
                 $time, pc, aluout, writedata, hi, lo, zero, jalout);
    end

endmodule
`endif // TB_DATAPATH
