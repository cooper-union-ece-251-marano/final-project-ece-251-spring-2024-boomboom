//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(parameter n = 32)
    (
        input logic [n-1:0] A, B,
        input logic [3:0] FUNCT,
        output logic [n-1:0] Y, Hi, Lo,
        output logic zero
    );
    logic [n+n-1:0] Hilo;

    // Zero flag logic correction
    assign zero = (Y == {n{1'b0}});

    // ALU operations definition
    always @* begin
        
        case(FUNCT)
            4'b0001: Y = A + B; // Add
            4'b0010: Y = A - B; // Subtract
            4'b0011: begin // Multiply
                Hilo = A * B;
                Hi = Hilo[n+n-1:n];
                Lo = Hilo[n-1:0];
                Y = Lo; // To be determined later
            end
            4'b0100: begin // Divide
                Y = A / B; 
                Hi = A % B;
            end
            4'b0101: Y = A | B; // OR
            4'b0110: Y = A & B; // AND
            4'b0111: Y = ~(A | B); // NOR
            4'b1000: Y = A ^ B; // XOR
            4'b1001: Y = A << B; // Shift left logical
            4'b1010: Y = A >> B; // Shift right logical
            4'b1011: Y = (A < B) ? 1 : 0; // Set less than

            4'b1111: begin  // Reset
                Y = 1'bx; 
                Hi = 1'bx; 
                Lo = 1'bx; 
                Hilo = 1'bx;
            end
        endcase
    end

endmodule

`endif // ALU
