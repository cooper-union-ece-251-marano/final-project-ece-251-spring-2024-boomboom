//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbdmem
//     Description: Test bench for data memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBDMEM
`define TBDMEM

`timescale 1ns/100ps
`include "dmem.sv"
`include "../clock/clock.sv"

module tbdmem;
    parameter n = 32; // bit length of registers/memory
    parameter r = 7; // we are only addressing 64=2**6 mem slots in imem
    logic [(n-1):0] readdata, writedata;
    logic [(n-1):0] dmemaddr;
    logic writeenable;
    logic clk, clockenable;

   initial begin
        $dumpfile("dmem.vcd");
        $dumpvars(0, uut, uut1);
        $monitor("time=%0t writeenable=%b dmemaddr=%h readdata=%h writedata=%h",
            $realtime, writeenable, dmemaddr, readdata, writedata);
    end

    initial begin
        #10 clockenable <= 1;
        #20 writedata = #(n)'hFFFFFFFF;
        #20 dmemaddr <= #(r)'b000000;
        #20 writeenable <= 1;
        #20 writeenable <= 0;
        #20 dmemaddr <= #(r)'b000001;
        #20 writedata = #(n)'h0000FFFF;
        #20 writeenable <= 1;
        #20 writeenable <= 0;
        #20 dmemaddr <= #(r)'b000010;
        #20 writedata = #(n)'h00000000;
        #20 writeenable <= 1;
        #20 writeenable <= 0;
        #20 $finish;
    end

   dmem uut(
        .clk(clk),
        .writeenable(writeenable),
        .addr(dmemaddr),
        .writedata(writedata),
        .readdata(readdata)
    );
    clock uut1(
        .ENABLE(clockenable),
        .CLOCK(clk)
    );
endmodule

`endif // TBIMEM