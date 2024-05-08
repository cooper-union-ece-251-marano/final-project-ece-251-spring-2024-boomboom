//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbregfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBREGFILE
`define TBREGFILE

`timescale 1ns/100ps
`include "regfile.sv"

module tbregfile;
    parameter n = 32;
    parameter r = 7; // Assuming 7 bits to address up to 128 registers
    reg clk;
    reg we3;
    reg [(r-1):0] ra1, ra2, wa3;
    reg [(n-1):0] wd3;
    wire [(n-1):0] rd1, rd2;

    // Instantiate the Register File
    regfile #(n, r) uut (
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation
    always begin
        clk = 0; 
        forever #5 clk = ~clk;  // Toggle clock every 10 ns (100 MHz)
    end

    // Initial Setup and Stimulus
    initial begin
        $dumpfile("regfiletb.vcd");
        $dumpvars(0, tbregfile);
        $monitor("At time %t, ra1 = %d, ra2 = %d, rd1 = %h, rd2 = %h", $time, ra1, ra2, rd1, rd2);

        we3 = 0; wa3 = 0; wd3 = 0; ra1 = 0; ra2 = 0;
        #20;

        // Testing
        wa3 = 5; wd3 = 32'hAAAABBBB; we3 = 1;
        #10; we3 = 0;

        ra1 = 5;
        #10;

        ra2 = 0;
        #10;

        wa3 = 6; wd3 = 32'h12345678; we3 = 1;
        ra2 = 6;
        #10; we3 = 0;

        #20 $finish;
    end
endmodule
`endif // TBREGFILE