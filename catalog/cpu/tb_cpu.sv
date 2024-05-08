//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-03
//     Module Name: tbcpu
//     Description: Test bench for cpu
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBCPU
`define TBCPU

`timescale 1ns/100ps
`include "cpu.sv"

module tbcpu;
    // Define parameters
    parameter n = 32;

    // Declare inputs and outputs
    reg clk, reset;
    reg [(n-1):0] instr, readdata;
    wire memwrite;
    wire [(n-1):0] pc, aluout, writedata, jalout; 
    wire hi, lo;
    reg [(n-1):0] regfile[31:0]; // Array to store register file contents

    // Instantiate CPU module
    cpu #(.n(n)) testcpu (
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

    // Clock generator
    always begin
        clk = 0;
        #5 clk = ~clk;
    end

    initial begin
        // Dump VCD file for waveform viewing
        $dumpfile("cputb.vcd");
        $dumpvars(0, tbcpu);

        reset = 1;
        instr = 32'h00000000;

        #10 reset = 0;

        // We will check these in computer
        instr = 32'b00000101000000000010000001100000;    // ADD $s0, $s1, $s2 
        #100;
        instr = 32'b10001001000000000010000000000110;    // ADDI $s0, $s1, 6
        #100;

        $finish;
    end
        initial begin
            $monitor("Time: %t | PC: %h | ALUOut: %h | WriteData: %h | MemWrite: %b | JALOut: %h | Hi: %h | Lo: %h",
                    $time, pc, aluout, writedata, memwrite, jalout, hi, lo);
        end

endmodule
`endif // TBCPU