//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbdff
//     Description: Test bench for 32 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBDFF
`define TBDFF

`timescale 1ns/100ps
`include "dff.sv"
`include "../clock/clock.sv"

module tbdff;
    parameter n = 32; // #bits for an operand
    wire clk;
    logic enable;
    logic reset;
    logic [(n-1):0] d;
    logic [(n-1):0] q;

   initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, uut0, uut1);
        //$monitor("d = %b (%0h)(%0d) q = %b (%0h)(%0d) ", d,d,d,q,q,q);
        $monitor("time=%0t \t d=%h q=%h",$realtime, d, q);
    end

    initial begin
        d <= #n'h8000;
        enable <= 0;
        #10 enable <= 1;
        #10 reset <= 1;
        #20 d <= #n'h0001;
        #10 reset <= 0;
        #10 reset <=0;
        #20 d <= #n'h0001;
        #100 enable <= 0;
        $finish;        
    end

    dff uut0(
        .CLOCK(clk), .RESET(reset), .D(d), .Q(q)
    );

   clock uut1(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
`endif // TBDFF