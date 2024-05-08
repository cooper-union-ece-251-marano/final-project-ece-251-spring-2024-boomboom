//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tbcontroller
//     Description: Test bench for controller
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TBCONTROLLER
`define TBCONTROLLER

`timescale 1ns/100ps
`include "controller.sv"

module tbcontroller;
    // Parameters
    parameter n = 32;

    // Declare inputs as regs and outputs as wires
    reg [5:0] op;
    reg zero;
    wire memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, jrsrc, jalsrc;
    wire [3:0] alucontrol;

    // Instantiate the Device Under Test (DUT)
    controller #(.n(n)) dut (
        .op(op),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .jrsrc(jrsrc),
        .jalsrc(jalsrc),
        .alucontrol(alucontrol)
    );

    // Test stimulus
    initial begin
        $dumpfile("controllertb.vcd");
        $dumpvars(0, tbcontroller);

        // Initialize inputs
        op = 6'b000000; zero = 1'b0;

        // Display test outputs
        $display("Time\t op\t zero\t | memtoreg memwrite pcsrc alusrc regdst regwrite jump jrsrc jalsrc alucontrol");
        $monitor("%g\t %b\t %b\t | %b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t %b",
                 $time, op, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, jrsrc, jalsrc, alucontrol);

        // Test different scenarios
        #10 op = 6'b000001; zero = 1'b1;  // Scenario 1
        #10 op = 6'b000010; zero = 1'b0;  // Scenario 2
        #10 op = 6'b000100; zero = 1'b1;  // Scenario 3
        #10 op = 6'b000111; zero = 1'b0;  // Scenario 4

        // Reset all to zero
        #10 op = 6'b000000; zero = 1'b0;  // Reset

        // End simulation
        #10 $finish;
    end
endmodule
`endif // TBCONTROLLER