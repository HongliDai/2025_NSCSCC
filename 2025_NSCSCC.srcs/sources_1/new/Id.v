`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/30 20:19:16
// Design Name: 
// Module Name: Id
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


module Id(
    input   wire                        rst,
    input   wire[`InstAddrBus]          pc_i,               // 指令地址
    input   wire[`InstBus]              inst_i,             // 指令
    // Regfile输出
    input   wire[`RegDataBus]           r_reg1_data_in,     // 读端口1的输出?
    input   wire[`RegDataBus]           r_reg2_data_in,     // 读端口2的输出?
    // Regfile输入
    output  reg                         reg1_rce_o,         // 读端口1读使能
    output  reg[`RegAddrBus]            r_reg1_addr_o,      // 读端口1读地址
    output  reg                         reg2_rce_o,         // 读端口2读使能
    output  reg[`RegAddrBus]            r_reg2_addr_o,      // 读端口2读地址            
    // EX阶段输入
    output  reg[`AluOpBus]              alu_op_o,           // ALU运算类型子类型
    output  reg[`AluSelBus]             alu_sel_o,          // ALU运算类型
    output  reg[`RegDataBus]            reg1_o,             // 源操作数1
    output  reg[`RegDataBus]            reg2_o,             // 源操作数2
    output  reg[`RegAddrBus]            w_reg_addr_o,       // 目的寄存器地址
    output  reg                         reg_wce             // 写使能
    );
    
    wire[5:0] op = inst_i[31:26];
    
    reg[31:0] imme; // 32位立即数
    reg instvalid;  // 指令是否有效
    
    always@(*) begin
        if(rst == `RstEnable) begin
            reg1_rce_o <= `ReadDisable;
            r_reg1_addr_o <= `NOPRegAddr;
            reg2_rce_o <= `ReadDisable;
            r_reg2_addr_o <= `NOPRegAddr;
            alu_op_o <= `EX_OP_NOP;
            alu_sel_o <= `EX_SEL_NOP;
            reg1_o <= `ZeroWord;
            reg2_o <= `ZeroWord;
            w_reg_addr_o <= `NOPRegAddr;
            reg_wce <= `WriteDisable;
            imme <= `ZeroWord;
            instvalid <= `InstInvalid;     
        end
        else begin
            reg1_rce_o <= `ReadDisable;
            r_reg1_addr_o <= inst_i[25:21];
            reg2_rce_o <= `ReadDisable;
            r_reg2_addr_o <= inst_i[20:16];
            alu_op_o <= `EX_OP_NOP;
            alu_sel_o <= `EX_SEL_NOP;
            reg1_o <= `ZeroWord;
            reg2_o <= `ZeroWord;
            w_reg_addr_o <= inst_i[15:11];
            reg_wce <= `WriteDisable;
            imme <= `ZeroWord;
            instvalid <= `InstInvalid;
        end
        
        case(op)
            `EX_ORI: begin
                reg1_rce_o <= `ReadEnable;
                alu_op_o <= `EX_OP_OR; // 或运算
                alu_sel_o <= `EX_SEL_LOGIC; // 逻辑运算类型
                reg_wce <= `WriteEnable;
                imme <= {16'h0000, imme}; // 对立即数进行无符号扩展
                instvalid <= `InstValid; // 指令有效
            end
        endcase
    end
    
    always@(*) begin
        if(rst == `RstEnable)
            reg1_o <= `ZeroWord;
        else if(reg1_rce_o == `ReadEnable)
            reg1_o <= r_reg1_data_in;
        else if(reg1_rce_o == `ReadDisable)
            reg1_o <= imme;
        else
            reg1_o <= `ZeroWord;
    end
            
    always@(*) begin
        if(rst == `RstEnable)
            reg2_o <= `ZeroWord;
        else if(reg2_rce_o == `ReadEnable)
            reg2_o <= r_reg2_data_in;
        else if(reg2_rce_o == `ReadDisable)
            reg2_o <= imme;
        else
            reg2_o <= `ZeroWord;
    end
    
endmodule
