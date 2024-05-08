//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbsl2
//     Description: Test bench for shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBSL2
`define TBSL2

`timescale 1ns/100ps
`include "sl2.sv"

module tbsl2;
    parameter n = 32;
    logic [(n-1):0] a, y;

   initial begin
        $dumpfile("sl2.vcd");
        $dumpvars(0, uut);
        //$monitor("a = %0b (%0h)(%0d) y = %0b (%0h)(%0d) ", a, a, a, y, y, y);
        $monitor("time=%0t \t a=%b y=%b",$realtime, a, y);
    end

    initial begin
        a <= #n'h0000000F;
    end

    sl2 uut(
        .A(a), .Y(y)
    );
endmodule
`endif // TBSL2