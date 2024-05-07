//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: imem
//     Description: 32-bit RISC memory (instruction "text" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module imem
    #(parameter n = 32, parameter r = 7)
    (
    input logic [(r-1):0] addr,
    output logic [(n-1):0] readdata
    );

    logic [(n-1):0] RAM[(2**r)-1:0];  // Ensuring array bounds are clearly defined

    // Initialize memory
    initial begin
        $readmemh("mult-prog_exe.hex");  // Load the actual program
    end

    assign readdata = RAM[addr];  // Word aligned access

endmodule

`endif // IMEM
