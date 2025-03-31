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
    input   wire[`InstAddrBus]          pc_i,               // ָ���ַ
    input   wire[`InstBus]              inst_i,             // ָ��
    // Regfile���
    input   wire[`RegDataBus]           r_reg1_data_in,     // ���˿�1�����?
    input   wire[`RegDataBus]           r_reg2_data_in,     // ���˿�2�����?
    // Regfile����
    output  reg                         reg1_rce_o,         // ���˿�1��ʹ��
    output  reg[`RegAddrBus]            r_reg1_addr_o,      // ���˿�1����ַ
    output  reg                         reg2_rce_o,         // ���˿�2��ʹ��
    output  reg[`RegAddrBus]            r_reg2_addr_o,      // ���˿�2����ַ            
    // EX�׶�����
    output  reg[`AluOpBus]              alu_op_o,           // ALU��������������
    output  reg[`AluSelBus]             alu_sel_o,          // ALU��������
    output  reg[`RegDataBus]            reg1_o,             // Դ������1
    output  reg[`RegDataBus]            reg2_o,             // Դ������2
    output  reg[`RegAddrBus]            w_reg_addr_o,       // Ŀ�ļĴ�����ַ
    output  reg                         reg_wce             // дʹ��
    );
    
    wire[5:0] op = inst_i[31:26];
    
    reg[31:0] imme; // 32λ������
    reg instvalid;  // ָ���Ƿ���Ч
    
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
                alu_op_o <= `EX_OP_OR; // ������
                alu_sel_o <= `EX_SEL_LOGIC; // �߼���������
                reg_wce <= `WriteEnable;
                imme <= {16'h0000, imme}; // �������������޷�����չ
                instvalid <= `InstValid; // ָ����Ч
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
