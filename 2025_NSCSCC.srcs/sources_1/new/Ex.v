`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/31 08:30:35
// Design Name: 
// Module Name: Ex
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


module Ex(
    input   wire                    rst,
    
    input   wire[`AluOpBus]         alu_op_i,
    input   wire[`AluSelBus]        alu_sel_i,
    input   wire[`RegDataBus]       reg1_i,
    input   wire[`RegDataBus]       reg2_i,
    input   wire[`RegAddrBus]       w_reg_addr_i,
    input   wire                    reg_wce_i,
    
    output  reg[`RegAddrBus]        w_reg_addr_o,
    output  reg                     reg_wce_o,
    output  reg[`RegDataBus]        w_reg_data_o
    );
    
    reg[`RegDataBus]    logic_o; // 逻辑运算输出结果
    
    always@(*) begin
        if(rst == `RstEnable)
            logic_o <= `ZeroWord;
        else begin
            case(alu_op_i)
                `EX_OP_OR: logic_o <= reg1_i | reg2_i;
            endcase
        end
    end
    
    always@(*) begin
        w_reg_addr_o <= w_reg_addr_i;
        reg_wce_o <= reg_wce_i;
        case(alu_sel_i)
            `EX_SEL_LOGIC: w_reg_data_o <= logic_o;
        endcase
    end    
    
endmodule
