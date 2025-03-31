`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/31 08:12:10
// Design Name: 
// Module Name: Id_ex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Id_ex(
    input   wire                    clk,
    input   wire                    rst,
    // ID输出
    input   wire[`AluOpBus]         id_alu_op,
    input   wire[`AluSelBus]        id_alu_sel,
    input   wire[`RegDataBus]       id_reg1,
    input   wire[`RegDataBus]       id_reg2,
    input   wire[`RegAddrBus]       id_w_reg_addr,
    input   wire                    id_reg_wce,
    // ALU输入
    output  reg[`AluOpBus]          ex_alu_op,
    output  reg[`AluSelBus]         ex_alu_sel,
    output  reg[`RegDataBus]        ex_reg1,
    output  reg[`RegDataBus]        ex_reg2,
    output  reg[`RegAddrBus]        ex_w_reg_addr,
    output  reg                     ex_reg_wce
    );
    
    always@(posedge clk) begin
        if(rst == `RstEnable) begin
            ex_alu_op <= `EX_OP_NOP;
            ex_alu_sel <= `EX_SEL_NOP;
            ex_reg1 <= `ZeroWord;
            ex_reg2 <= `ZeroWord;
            ex_w_reg_addr <= `NOPRegAddr;
            ex_reg_wce <= `WriteDisable;
        end
        else begin // 向下传递
            ex_alu_op <= id_alu_op;
            ex_alu_sel <= id_alu_sel;
            ex_reg1 <= id_reg1;
            ex_reg2 <= id_reg2;
            ex_w_reg_addr <= id_w_reg_addr;
            ex_reg_wce <= id_reg_wce;
        end
    
    end
    
endmodule
