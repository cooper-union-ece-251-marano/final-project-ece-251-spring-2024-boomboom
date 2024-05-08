//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbmux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBMUX2
`define TBMUX2

`timescale 1ns/100ps
`include "mux2.sv"
`include "../clock/clock.sv"

module tbmux2;
    parameter n = 32; // #bits for an operand
    logic s;
    logic [(n-1):0] d0, d1;
    logic [(n-1):0] y;
    wire clk;
    logic enable;


   initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, uut0, uut1);
        // $monitor("s = %0b d0 = (%0h)(%0d) d1 = (%0h)(%0d) y = (%0h)(%0d)", s, d0, d0, d1, d1, y, y);
        $monitor("time=%0t \t enable=%0b s=%0b y=%h d0=%h d1=%h",$realtime, enable, s, y, d0, d1);
    end

    initial begin
        d0 <= #n'h80000000;
        d1 <= #n'h00000001;
        enable <= 0;
        #10 enable <= 1;
        #10 s <= 1'b0;
        #20 s <= 1'b1;
        #100 enable <= 0;
        $finish;
    end

    mux2 uut0(
        .S(s), .D0(d0), .D1(d1), .Y(y)
    );
    clock uut1(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
`endif // TBMUX2