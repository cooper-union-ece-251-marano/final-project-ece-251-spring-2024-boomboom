//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Anthony Kwon, Jonghyeok(Burt) Kim
// 
//     Create Date: 2024-05-02
//     Module Name: tb_maindec
//     Description: Test bench for simple behavorial main decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps
`include "maindec.sv"

module tb_maindec;
    reg [5:0] op;
    wire memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
    wire [1:0] aluop;

    maindec uut (
        .op(op),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );

    initial begin
        $dumpfile("tb_maindec.vcd");
        $dumpvars(0, tb_maindec);

        op = 6'b000000;
        #10;

        for (int i = 0; i < 64; i++) begin
            op = i;
            #10;
        end

        $finish;
    end

    initial begin
        $monitor("At time %t, op = %b | mtg=%b mwt=%b br=%b als=%b rdst=%b rwt=%b jmp=%b aluop=%b",
                 $time, op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    end

endmodule
`endif // TB_MAINDEC