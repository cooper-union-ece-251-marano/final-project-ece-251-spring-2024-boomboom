//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: regfile
//     Description: 32-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE

`timescale 1ns/100ps

module regfile

    #(parameter n = 32, parameter r = 7)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, 
    input  logic        we3, 
    input  logic [(r-1):0]  ra1, ra2, wa3, 
    input  logic [(n-1):0] wd3, 
    output logic [(n-1):0] rd1, rd2
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] rf[(2**7-1):0];

    // three ported register file
    // read two ports combinationally
    // write third port on rising edge of clk
    // register 0 hardwired to 0
    // note: for pipelined processor, write third port
    // on falling edge of clk

    always begin
        rf[0] <= 0;
        @(posedge clk)
            if (we3) rf[wa3] <= wd3;

                assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
                assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
    end
endmodule

`endif // REGFILE
