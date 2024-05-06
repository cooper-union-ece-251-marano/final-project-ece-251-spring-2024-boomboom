//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-03
//     Module Name: tb_cpu
//     Description: Test bench for cpu
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CPU
`define TB_CPU

`timescale 1ns/100ps
`include "cpu.sv"

module tb_cpu;
    parameter n = 32;
    reg clk, reset;
    reg [(n-1):0] instr, readdata;
    wire memwrite;
    wire [(n-1):0] pc, aluout, writedata, jalout, hi, lo;

    cpu #(.n(n)) test_cpu (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .memwrite(memwrite),
        .aluout(aluout),
        .writedata(writedata),
        .jalout(jalout),
        .readdata(readdata),
        .hi(hi),
        .lo(lo)
    );

    // Clock check
    always begin
        clk = 0;
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, tb_cpu);
        reset = 1;
        instr = 32'h00000000;
        readdata = 32'h00000000;

        #10 reset = 0;
        
        // Testing
        instr = 32'h20100010;  // ADDI R1, R0, #16
        #10; 

        instr = 32'h00221820; // ADD R3, R1, R2
        #20; 
        #100 $finish;
    end

    initial begin
        $monitor("Time: %t | PC: %h | ALUOut: %h | WriteData: %h | MemWrite: %b | JALOut: %h | Hi: %h | Lo: %h",
                 $time, pc, aluout, writedata, memwrite, jalout, hi, lo);
    end

endmodule
`endif // TB_CPU