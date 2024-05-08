//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-04-14
//     Module Name: tbadder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBADDER
`define TBADDER

`timescale 1ns/100ps
`include "adder.sv"

module tbadder;
    parameter n = 32;
    logic [(n-1):0] a, b, y;

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tbadder);
        $monitor("a = %0h b = %0h y = %0h", a, b, y);
    end

    initial begin
        a <= {n{32'b00000000000000000000000000000011}};
        b <= {n{32'b00000000000000000000000000001111}};
        #100;
        $finish;
    end

    adder uut(
        .A(a), .B(b), .SUM(y)
    );
endmodule
`endif // TBADDER
