//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbimem
//     Description: Test bench for instruction memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module imem
    #(parameter n = 32, parameter r = 7)(
    input logic [(r-1):0] addr,
    output logic [(n-1):0] readdata
);

    logic [(n-1):0] RAM[(1<<r)-1:0];  // Ensure array bounds are correctly defined

    initial begin
        integer i;
        for (i = 0; i < (1<<r); i = i + 1) {
            RAM[i] = 32'h00000000;  // Initialize all memory to NOP (or zero)
        }
        $readmemh("imem_check.dat", RAM);  // Load the actual program
    end

    assign readdata = RAM[addr];  // Word aligned access
endmodule

`endif // IMEM
