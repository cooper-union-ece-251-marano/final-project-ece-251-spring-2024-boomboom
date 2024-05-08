//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: clock
//     Description: Clock generator; duty cycle = 50%
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CLOCK
`define CLOCK

`timescale 1ns/100ps

module clock
    #(parameter ticks = 10)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input ENABLE,
    output reg CLOCK
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    reg startclock;
    real clockon = ticks/2; // duty cycle = 50%
    real clockoff = ticks/2;

    // initialize variables
    initial begin
      CLOCK <= 0;
      startclock <= 0;
    end

    always @(posedge ENABLE or negedge ENABLE) begin
        if (ENABLE) begin
            startclock = 1;
        end
        else begin
            startclock = 0;
        end
        // #ticks CLOCK = ~CLOCK;
    end
    always @(startclock) begin
        CLOCK = 0;
        while (startclock) begin
            #(clockoff) CLOCK = 1;
            #(clockon) CLOCK = 0;
        end
        CLOCK = 0;
    end
endmodule

`endif // CLOCK