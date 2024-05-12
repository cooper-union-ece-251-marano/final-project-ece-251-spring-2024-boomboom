//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim

//     Create Date: 2024-04-14
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
    #(parameter n = 32)(
        input [n-1:0] A, B,
        output reg [n-1:0] SUM
    );

    always @* begin
        SUM = A + B;
    end

endmodule

`endif // ADDER
