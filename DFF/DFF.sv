`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:09:25 PM
// Design Name: 
// Module Name: DFF
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


module DFF(
input i_clk,
input i_rst_n,
input i_din,
output reg o_dout,
output reg o_dout_n
    );
    always@(posedge i_clk) begin
        if(!i_rst_n) o_dout <= 'b0;
        else o_dout <= i_din;
    end
    assign o_dout_n = ~o_dout;
endmodule
