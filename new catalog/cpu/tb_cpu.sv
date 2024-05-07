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
    // Define parameters
    parameter n = 32;

    // Declare inputs and outputs
    reg clk, reset;
    reg [(n-1):0] instr, readdata;
    wire memwrite;
    wire [(n-1):0] pc, aluout, writedata, jalout; 
    wire hi, lo;
    reg [(n-1):0] reg_file[31:0]; // Array to store register file contents

    // Instantiate CPU module
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

    // Clock generator
    always begin
        clk = 0;
        #5 clk = ~clk;
    end

    initial begin
        // Dump VCD file for waveform viewing
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, tb_cpu);

        reset = 1;
        instr = 32'h00000000;

        #10 reset = 0;

        // We will check these in computer
        instr = 32'b000001_0100000_0000010_0000011_00000;    // ADD $s0, $s1, $s2 
        #100;
        instr = 32'b100010_0100000_0000010_000000000110;    // ADDI $s0, $s1, 6
        #100;

        $finish;
    end
        initial begin
            $monitor("Time: %t | PC: %h | ALUOut: %h | WriteData: %h | MemWrite: %b | JALOut: %h | Hi: %h | Lo: %h",
                    $time, pc, aluout, writedata, memwrite, jalout, hi, lo);
        end

endmodule
`endif // TB_CPU