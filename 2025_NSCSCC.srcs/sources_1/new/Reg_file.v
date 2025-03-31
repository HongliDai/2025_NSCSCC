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
    // 写端口
    input   wire                    we,
    input   wire[`RegAddrBus]       waddr,
    input   wire[`RegDataBus]       wdata,
    // 读端口1
    input   wire                    re1,
    input   wire[`RegAddrBus]       raddr1,
    output  reg[`RegDataBus]        rdata1,
    // 读端口2
    input   wire                    re2,
    input   wire[`RegAddrBus]       raddr2,
    output  reg[`RegDataBus]        rdata2
    );
//********* 定义32个32位寄存器 *********
    reg[`RegDataBus]    regs[0:`RegNum-1];
    
//*********  写操作（时序） *********
    always@(posedge clk) begin
        if(rst == `RstDisable) begin
            if(we == `WriteEnable   &&  waddr != 5'h0) // 预留$0寄存器，其值只能为0
                regs[waddr] <= wdata;
        end
    end
    
//********* 读操作1（组合） *********
    always@(*) begin
        if(rst == `RstEnable)
            rdata1 <= `ZeroWord;
        else if(raddr1 == 5'h0)
            rdata1 <=  `ZeroWord;
        else if(raddr1 == waddr &&  we == `WriteEnable  &&  re1 == `ReadEnable) // 读写地址一致时，直接将写的内容输出，确保数据的时效性
            rdata1 <= wdata;
        else if(re1 == `ReadEnable)
            rdata1 <= regs[raddr1];
        else
            rdata1 <= `ZeroWord;
    end
    
//********* 读操作2（组合） *********
    always@(*) begin
        if(rst == `RstEnable)
            rdata2 <= `ZeroWord;
        else if(raddr2 == 5'h0)
        rdata2 <= `ZeroWord;     
        else if(raddr2 == waddr &&  we == `WriteEnable  &&  re2 == `ReadEnable) // 读写地址一致时，直接将写的内容输出，确保数据的时效性
            rdata2 <= wdata;
        else if(re2 == `ReadEnable)
            rdata2 <= regs[raddr2];
        else
            rdata2 <= `ZeroWord;
    end
    
endmodule
