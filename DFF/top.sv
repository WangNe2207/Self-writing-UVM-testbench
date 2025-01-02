`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:30:53 PM
// Design Name: 
// Module Name: top
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
`include "uvm_macros.svh"
import uvm_pkg::*;


`include "Interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "score_board.sv"
`include "Enviroment.sv"
`include "test.sv"

module top;
    logic clk;
    
    initial begin
        clk <= 0;
        forever begin
            #5 clk <= ~clk;
        end
    end
    initial begin
        uvm_config_db#(virtual DFF_interface)::set(null,"*","vif",inf);
    end
    DFF DUT(
    .i_clk(inf.clk),
    .i_rst_n(inf.i_rst_n),
    .i_din(inf.i_din),
    .o_dout(inf.o_dout),
    .o_dout_n(inf.o_dout_n)
    );
    
    DFF_interface inf(.clk(clk));
    
  initial begin
    $monitor($time, "clk = %d", clk);
    $monitor($time, "rst = %d", inf.i_rst_n);
    $monitor($time, "d = %d", inf.i_din);
    $monitor($time, "q = %d", inf.o_dout);
     //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  initial begin 
    run_test("DFF_test");
  end
  
endmodule
