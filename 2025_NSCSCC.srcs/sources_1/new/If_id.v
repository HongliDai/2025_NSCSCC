`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/29 16:57:29
// Design Name: 
// Module Name: If_id
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


module If_id(
    input   wire                    clk,
    input   wire                    rst,
    input   wire[`InstAddrBus]      if_pc, // 取指地址
    input   wire[`InstBus]          if_inst, // 取指指令    
    output  reg[`InstAddrBus]       id_pc, // 译码地址
    output  reg[`InstBus]           id_inst // 译码指令        
    );
    
    always@(posedge clk) begin
        if(rst == `RstEnable) begin
            id_pc <= 32'h0000_0000;
            id_inst <= 32'h0000_0000;
        end
        else begin // 向下传递
            id_pc <= if_pc;
            id_inst <= id_inst;
        end
    end
    
endmodule
