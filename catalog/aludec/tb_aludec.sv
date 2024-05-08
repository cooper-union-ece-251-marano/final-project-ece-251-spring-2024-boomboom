//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module tbaludec;
    // Testbench uses same parameter size as the aludec module
    parameter n = 32;
    reg [3:0] funct;
    reg [1:0] aluop;
    wire [3:0] aluctrl;

    aludec #(.n(n)) dut(
        .funct(funct),
        .aluop(aluop),
        .aluctrl(aluctrl)
    );

    initial begin
        // Initial inputs
        funct = 4'b0000;
        aluop = 2'b00;
        
        // Display header for results
        $display("Time\t aluop\t funct\t aluctrl");
        $monitor("%g\t %b\t %b\t %b", $time, aluop, funct, aluctrl);

        #10 aluop = 2'b01; funct = 4'bxxxx;

        #10 aluop = 2'b10;

        #10 aluop = 2'b11;

        #10 aluop = 2'b00; funct = 4'b1010;

        #10 aluop = 2'b00; funct = 4'b1111;

        #10 aluop = 2'b00; funct = 4'b0000;

        #10 $finish;
    end

endmodule