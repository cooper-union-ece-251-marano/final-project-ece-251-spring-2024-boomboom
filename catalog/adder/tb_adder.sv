//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter n = 32;
    logic [(n-1):0] a, b, y;

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_adder);
        $monitor("a = 0x%0h b = 0x%0h y = 0x%0h", a, b, y);
    end

    initial begin
        a <= #10 {n{1'b1}};
        b <= #10 {n{1'b1}};
        #100; // Delay for simulation
        $finish; // Finish simulation
    end

    adder uut(
        .A(a), .A(b), .SUM(y)
    );
endmodule
`endif // TB_ADDER
