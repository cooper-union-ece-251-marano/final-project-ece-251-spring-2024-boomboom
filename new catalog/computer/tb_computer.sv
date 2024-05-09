//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbcomputer
//     Description: Test bench for a single-cycle cpu computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
/*`ifndef TBCOMPUTER
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
    #50 reset <= 0;
    #50 clkenable <= 1;
    $finish;
  end
  // Instantiate the computer module and clock
  computer dut(clk, reset, dataadr, writedata, jalout, memwrite, hi, lo);
  clock dut1(.ENABLE(clkenable), .CLOCK(clk));

  // Monitoring changes in the simulation
  initial begin
    $monitor("Time: %t, Reset: %b, clk: %b, Data Address: %h, Write Data: %h, jalout: %h, memwrite: %b, hi: %b, lo: %b",
             $time, reset, clk, dataadr, writedata, jalout, memwrite, hi, lo);
  end

  // Add any additional monitoring or checks here
endmodule 
`endif // TBCOMPUTER*/

`ifndef TBCOMPUTER
`define TBCOMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"


module tb_computer;
  parameter n = 32; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 7;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clkenable;
  logic reset;
  wire memwrite;
  wire [31:0] writedata;
  wire [31:0] jalout, dataadr;
  logic firstTest, secondTest;
  logic hi, lo;

  // instantiate the CPU as the device to be tested
  computer dut(clk, reset, dataadr, writedata, memwrite);
  // generate clock to sequence tests
  // always
  //   begin
  //     clk <= 1; # 5; clk <= 0; # 5;
  //   end

  // instantiate the clock
  clock dut1(.ENABLE(clkenable), .CLOCK(clk));


  initial begin
    firstTest = 1'b0;
    secondTest = 1'b0;
    $dumpfile("tbcomputer.vcd");
    $dumpvars(0,dut1,dut,clk,reset,writedata,dataadr,memwrite);
    $monitor("t=%t\t%7h\t%7d\t%8d",$realtime,writedata,dataadr,memwrite);
    // $dumpvars(0,clk,a,b,ctrl,result,zero,negative,carryOut,overflow);
    // $display("Ctl Z  N  O  C  A                    B                    ALUresult");
    // $monitor("%3b %b  %b  %b  %b  %8b (%2h;%3d)  %8b (%2h;%3d)  %8b (%2h;%3d)",ctrl,zero,negative,overflow,carryOut,a,a,a,b,b,b,result,result,result);
  end

  // Testing fib
  initial begin
    $readmemh("fib.hex", dut.imem.RAM);
  end

  // initialize test
  initial begin
    #0 clkenable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clkenable <= 1;
    #100 $finish;
  end

  // monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin/*
      $display("+");
      $display("\t+instr = %8h",dut.instr);
      $display("\t+op = 0b%6b",dut.cpu.c.op);
      $display("\t+controls = 0b%9b",dut.cpu.c.md.controls);
      $display("\t+funct = 0b%4b",dut.cpu.c.ad.funct);
      $display("\t+aluop = 0b%2b",dut.cpu.c.ad.aluop);
      $display("\t+alucontrol = 0b%4b",dut.cpu.c.ad.alucontrol);
      $display("\t+alu result = %8h",dut.cpu.dp.alu.result);
      // $display("\t+HiLo = %8h",dut.cpu.dp.alu.HiLo);
      $display("\t+$v0 = %8h",dut.cpu.dp.rf.rf[3]);
      $display("\t+$v1 = %8h",dut.cpu.dp.rf.rf[4]);*/
      $display("\t+$a0 = %8h",dut.cpu.dp.rf.rf[11]);
      // $display("\t+$a1 = %4h",dut.cpu.dp.rf.rf[12]);
      /*$display("\t+$t0 = %8h",dut.cpu.dp.rf.rf[21]);
      // $display("\t+$t1 = %4h",dut.cpu.dp.rf.rf[22]);
      $display("\t+$s0 = %8h",dut.cpu.dp.rf.rf[41]);
      $display("\t+$s1 = %8h",dut.cpu.dp.rf.rf[42]);
      $display("\t+$s2 = %8h",dut.cpu.dp.rf.rf[43]);*/
      $display("\t+$s3 = %8h",dut.cpu.dp.rf.rf[44]);
      /*$display("\t+regfile -- ra1 = %d",dut.cpu.dp.rf.ra1);
      $display("\t+regfile -- ra2 = %d",dut.cpu.dp.rf.ra2);
      $display("\t+regfile -- we3 = %d",dut.cpu.dp.rf.we3);
      $display("\t+regfile -- wa3 = %d",dut.cpu.dp.rf.wa3);
      $display("\t+regfile -- wd3 = %d",dut.cpu.dp.rf.wd3);
      $display("\t+regfile -- rd1 = %d",dut.cpu.dp.rf.rd1);
      $display("\t+regfile -- rd2 = %d",dut.cpu.dp.rf.rd2);
      $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
      $display("writedata\tdataadr\tmemwrite");*/
  end

  // run program
  // monitor what happens at negedge of clock transition
  always @(negedge clk) begin
    /*$display("-");
    $display("\t+instr = %8h",dut.instr);
    $display("\t+op = 0b%6b",dut.cpu.c.op);
    $display("\t+controls = 0b%9b",dut.cpu.c.md.controls);
    $display("\t+funct = 0b%4b",dut.cpu.c.ad.funct);
    $display("\t+aluop = 0b%2b",dut.cpu.c.ad.aluop);
    $display("\t+alucontrol = 0b%4b",dut.cpu.c.ad.alucontrol);
    $display("\t+alu result = %8h",dut.cpu.dp.alu.result);
    $display("\t+$v0 = %8h",dut.cpu.dp.rf.rf[3]);
    $display("\t+$v1 = %8h",dut.cpu.dp.rf.rf[4]);*/
    $display("\t+$a0 = %8h",dut.cpu.dp.rf.rf[11]);
    // $display("\t+$a1 = %4h",dut.cpu.dp.rf.rf[12]);
    /*$display("\t+$t0 = %8h",dut.cpu.dp.rf.rf[21]);
    // $display("\t+$t1 = %4h",dut.cpu.dp.rf.rf[22]);
    $display("\t+$s0 = %8h",dut.cpu.dp.rf.rf[41]);
    $display("\t+$s1 = %8h",dut.cpu.dp.rf.rf[42]);
    $display("\t+$s2 = %8h",dut.cpu.dp.rf.rf[43]);*/
    $display("\t+$s3 = %8h",dut.cpu.dp.rf.rf[44]);
    /*$display("\t-regfile -- ra1 = %d",dut.cpu.dp.rf.ra1);
    $display("\t-regfile -- ra2 = %d",dut.cpu.dp.rf.ra2);
    $display("\t-regfile -- we3 = %d",dut.cpu.dp.rf.we3);
    $display("\t-regfile -- wa3 = %d",dut.cpu.dp.rf.wa3);
    $display("\t-regfile -- wd3 = %d",dut.cpu.dp.rf.wd3);
    $display("\t-regfile -- rd1 = %d",dut.cpu.dp.rf.rd1);
    $display("\t-regfile -- rd2 = %d",dut.cpu.dp.rf.rd2);
    $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
    $display("writedata\tdataadr\tmemwrite");*/
  end

  always @(negedge clk, posedge clk) begin
    // check results
    // TODO: You need to update the checks below
    // if (dut.dmem.RAM[84] === 32'h9504)
    //   begin
    //     $display("Successfully wrote %4h at RAM[%3d]",84,32'h9504);
    //     firstTest = 1'b1;
    //   end

    if (dut.dmem.RAM[84] === 32'h96)
      begin
        $display("Successfully wrote %4h at RAM[%3d]",84,32'h0096);
        firstTest = 1'b1;
      end
    if(memwrite) begin
      if(dataadr === 84 & writedata === 32'h96)
      begin
        $display("Successfully wrote %4h at RAM[%3d]",writedata,dataadr);
        firstTest = 1'b1;
      end
    end
    if (firstTest === 1'b1)
    begin
        $display("Program successfully completed");
        $finish;
    end
  end

endmodule

`endif // TBCOMPUTER
