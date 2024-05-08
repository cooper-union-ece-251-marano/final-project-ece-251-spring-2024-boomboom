//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbcomputer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBCOMPUTER
`define TBCOMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"

module tbcomputer;
  parameter n = 32; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 5;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clkenable;
  logic reset;
  logic memwrite;
  logic [n-1:0] writedata, dataadr, jalout;
  logic hi, lo;

  // Load Fibonacci machine code into instruction memory
  initial begin
    $readmemh("fib.hex", dut.imem.RAM);
  end

  // Initialize necessary registers
  initial begin
    reset <= 1;
    clkenable <= 0;
    // Set initial values for registers
    // $a0 - Number of Fibonacci numbers to generate (e.g., 10)
    dut.mips.dp.rf.rf[4] <= 10;
    #50 reset <= 0;
    #50 clkenable <= 1;
  end

  // Instantiate the computer module and clock
  computer dut(clk, reset, dataadr, writedata, jalout, memwrite, hi, lo);
  clock dut1(.ENABLE(clkenable), .CLOCK(clk));

  // Add any additional monitoring or checks here
endmodule 
`endif // TBCOMPUTER