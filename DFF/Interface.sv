`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:20:30 PM
// Design Name: 
// Module Name: Interface
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


interface DFF_interface (input logic clk);
    logic i_rst_n;
    logic i_din;
    logic o_dout;
    logic o_dout_n;
    
    clocking cb @(posedge clk);
      default input #2 output #1step;
      output i_rst_n,i_din; //input of DUT
      input  o_dout;     //output of DUT
    endclocking
endinterface 
