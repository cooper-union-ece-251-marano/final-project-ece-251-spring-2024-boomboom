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
  wire [31:0] dataadr;
  logic firstTest, secondTest;
  logic hi, lo;

  // instantiate the CPU as the device to be tested
  computer dut(clk, reset, dataadr, writedata, memwrite);

  // instantiate the clock
  clock dut1(.ENABLE(clkenable), .CLOCK(clk));


  initial begin
    $dumpfile("tb_computer.vcd");
    $dumpvars(0,dut1,dut,clk,reset,writedata,dataadr,memwrite);
    //$monitor("t=%t\t%7h\t%7d\t%8d",$realtime,writedata,dataadr,memwrite);
  end

  // Testing fib
  initial begin
    $readmemb("fib.dat", dut.imem.RAM);
  end

  initial begin
	  #0 clkenable <= 0;
	  #50 reset <= 1;
	  #50 reset <= 0;
	  #50 clkenable <= 1;
  end

  //monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin
      $display("+");
      $display("\t+pc = %8h" ,dut.cpu.dp.pc);
      $display("\t+pcplus4 = %8h" ,dut.cpu.dp.pcplus4);
      $display("\t+pcbr = %8h" ,dut.cpu.dp.pcnextbr);
      $display("\t+pcj = %8h" ,dut.cpu.dp.pcnextj);
      $display("\t+pcjr = %8h" ,dut.cpu.dp.pcnextj2);
      $display("\t+pcjal = %8h" ,dut.cpu.dp.pcnext);
      $display("\t+pcnext = %8h" ,dut.cpu.dp.pcnext);
      $display("\t+instr = %8h" ,dut.instr);
      $display("\t+op = %6b",dut.cpu.c.op);
      //$display("\t+controls = %9b",dut.cpu.c.md.controls);
      //$display("\t+funct = %4b",dut.cpu.c.ad.funct);
      //$display("\t+aluop = %2b",dut.cpu.c.ad.aluop);
      //$display("\t+alucontrol = %4b",dut.cpu.c.ad.alucontrol);
      $display("\t+source a = %8h", dut.cpu.dp.rf.rd1);
      $display("\t+alu A = %8h", dut.cpu.dp.alu.A);
      $display("\t+alu B = %8h", dut.cpu.dp.alu.B);
      $display("\t+result = %8h", dut.cpu.dp.alu.result);
      $display("\t+$v0 = %8h",dut.cpu.dp.rf.rf[3]);
      $display("\t+$a0 = %8h",dut.cpu.dp.rf.rf[11]);
      $display("\t+$t0 = %8h",dut.cpu.dp.rf.rf[21]);
      $display("\t+$s0 = %8h",dut.cpu.dp.rf.rf[41]);
      $display("\t+$s1 = %8h",dut.cpu.dp.rf.rf[42]);
      $display("\t+$s2 = %8h",dut.cpu.dp.rf.rf[43]);
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


endmodule

`endif // TBCOMPUTER
