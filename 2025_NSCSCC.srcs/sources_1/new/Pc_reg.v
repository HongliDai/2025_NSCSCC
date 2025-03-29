`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/29 16:47:30
// Design Name: 
// Module Name: pc_reg
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


module Pc_reg(
    input   wire    clk,
    input   wire    rst,
    output  reg     [`InstAddrBus]pc,
    output  reg     ce
    );
    
    always@(posedge clk) begin
        if(rst == `RstEnable)
            ce <= `ChipDisable;
        else
            ce <=  `ChipEnable;
    end
    
    always@(posedge clk) begin
        if(ce == 1'b0)
            pc <= 32'h0000_0000;
        else
            pc <= pc + 4'h4;
    end
    
endmodule
