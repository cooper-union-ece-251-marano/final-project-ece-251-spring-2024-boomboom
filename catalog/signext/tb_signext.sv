//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbsignext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBSIGNEXT
`define TBSIGNEXT

`timescale 1ns/100ps
`include "signext.sv"

module tbsl2;
    parameter n = 32; // #bits for an operand
    parameter i = n/2; // #bits for an immediate
    logic [(i-1):0] a;
    logic [(n-1):0] y;

   initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, uut);
        //$monitor("a = %b (%0h)(%0d) y = %b (%0h)(%0d) ", a, a, a, y, y, y);
        $monitor("time=%0t \t a=%b y=%b",$realtime, a, y);
    end

    initial begin
        a <= #i'h8000;
    end

    signext uut(
        .A(a), .Y(y)
    );
endmodule
`endif // TBSIGNEXT