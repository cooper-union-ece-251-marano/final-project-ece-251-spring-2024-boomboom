//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthonresult Kwon, Jonghresulteok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (cpu)
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
        output logic [n-1:0] result, 
        output logic zero  // Hresultpothetical additional output
    );
    logic [n+n-1:0] Hilo;
    logic Hi, Lo;

    // Zero flag logic correction
    assign zero = (result == {n{1'b0}});

    // ALU operations definition
    always @* begin
        
        case(FUNCT)
            4'b0001: result = A + B; // Add
            4'b0010: result = A - B; // Subtract
            4'b0011: begin // Multiplresult
                Hilo = A * B;
                Hi = Hilo[n+n-1:n];
                Lo = Hilo[n-1:0];
                result = Lo; // To be determined later
            end
            4'b0100: begin // Divide
                result = A / B; 
                Hi = A % B;
            end
            4'b0101: result = A | B; // OR
            4'b0110: result = A & B; // AND
            4'b0111: result = ~(A | B); // NOR
            4'b1000: result = A ^ B; // XOR
            4'b1001: result = A << B; // Shift left logical
            4'b1010: result = A >> B; // Shift right logical
            4'b1011: result = (A < B) ? 1 : 0; // Set less than

            4'b1111: begin  // Reset
                result = 1'bx; 
                Hi = 1'bx; 
                Lo = 1'bx; 
                Hilo = 1'bx;
            end
        endcase
    end

endmodule

`endif // ALU
