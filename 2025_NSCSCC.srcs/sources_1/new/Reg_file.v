`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/30 16:49:40
// Design Name: 
// Module Name: Reg_file
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


module Reg_file(
    input   wire                    clk,
    input   wire                    rst,
    // д�˿�
    input   wire                    we,
    input   wire[`RegAddrBus]       waddr,
    input   wire[`RegDataBus]       wdata,
    // ���˿�1
    input   wire                    re1,
    input   wire[`RegAddrBus]       raddr1,
    output  reg[`RegDataBus]        rdata1,
    // ���˿�2
    input   wire                    re2,
    input   wire[`RegAddrBus]       raddr2,
    output  reg[`RegDataBus]        rdata2
    );
//********* ����32��32λ�Ĵ��� *********
    reg[`RegDataBus]    regs[0:`RegNum-1];
    
//*********  д������ʱ�� *********
    always@(posedge clk) begin
        if(rst == `RstDisable) begin
            if(we == `WriteEnable   &&  waddr != 5'h0) // Ԥ��$0�Ĵ�������ֵֻ��Ϊ0
                regs[waddr] <= wdata;
        end
    end
    
//********* ������1����ϣ� *********
    always@(*) begin
        if(rst == `RstEnable)
            rdata1 <= `ZeroWord;
        else if(raddr1 == 5'h0)
            rdata1 <=  `ZeroWord;
        else if(raddr1 == waddr &&  we == `WriteEnable  &&  re1 == `ReadEnable) // ��д��ַһ��ʱ��ֱ�ӽ�д�����������ȷ�����ݵ�ʱЧ��
            rdata1 <= wdata;
        else if(re1 == `ReadEnable)
            rdata1 <= regs[raddr1];
        else
            rdata1 <= `ZeroWord;
    end
    
//********* ������2����ϣ� *********
    always@(*) begin
        if(rst == `RstEnable)
            rdata2 <= `ZeroWord;
        else if(raddr2 == 5'h0)
        rdata2 <= `ZeroWord;     
        else if(raddr2 == waddr &&  we == `WriteEnable  &&  re2 == `ReadEnable) // ��д��ַһ��ʱ��ֱ�ӽ�д�����������ȷ�����ݵ�ʱЧ��
            rdata2 <= wdata;
        else if(re2 == `ReadEnable)
            rdata2 <= regs[raddr2];
        else
            rdata2 <= `ZeroWord;
    end
    
endmodule
