//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_alu
//     Description: Test bench for simple behavorial ALU
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALU
`define TB_ALU

`timescale 1ns/100ps
`include "alu.sv"

module tb_alu;
    parameter n = 32;

    // Declare inputs as regs and outputs as wires
    reg [n-1:0] A, B;
    reg [3:0] FUNCT;
    wire [n-1:0] Y, Hi, Lo;
    wire zero;

    // Instantiate the Device Under Test (DUT)
    alu #(.n(n)) dut (
        .A(A),
        .B(B),
        .FUNCT(FUNCT),
        .Y(Y),
        .Hi(Hi),
        .Lo(Lo),
        .zero(zero)
    );

    // Test stimulus
    initial begin
        A = 0; B = 0; FUNCT = 0;
        #5; // Delay to ensure proper reset
        // Display results
        $display("Time\t FUNCT\t\t A\t\t B\t\t Y\t\t Hi\t\t Lo\t Zero");
        $monitor("%g\t %b\t %d\t %d\t %d\t %d\t %d\t %b", $time, FUNCT, A, B, Y, Hi, Lo, zero);

        // Test Case 1: Addition
        #10 A = 15; B = 10; FUNCT = 4'b0001;
        #10 FUNCT = 4'b1111; // reset values
       
        // Test Case 2: Subtraction
        #10 A = 20; B = 10; FUNCT = 4'b0010;
        #10 FUNCT = 4'b1111; // reset values
        
        // Test Case 3: Multiplication
        #10 A = 10; B = 3; FUNCT = 4'b0011;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 4: Division and Remainder
        #10 A = 23; B = 5; FUNCT = 4'b0100;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 5: OR
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b0101;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 6: AND
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b0110;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 7: NOR
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b0111;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 8: XOR
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b1000;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 9: Shift left logical
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b1001;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 10: Shift right logical
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b1010;
        #10 FUNCT = 4'b1111; // reset values

        // Test Case 11: Set less than
        #10 A = 6'b000111; B = 6'b111111; FUNCT = 4'b1011;
        #10 FUNCT = 4'b1111; // reset values
        // End simulation
        #10 $finish;
    end

endmodule
`endif // TB_ALU
