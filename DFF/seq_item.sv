`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 09:01:05 PM
// Design Name: 
// Module Name: seq_item
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
import uvm_pkg::*;

`include "uvm_macros.svh"

class DFF_seq_item extends uvm_sequence_item;
    
    rand logic i_rst_n;
    rand logic i_din;
    logic o_dout;
    logic o_dout_n;
      //---------------- register dff_sequence_item class with factory --------
  `uvm_object_utils_begin(DFF_seq_item) 
     `uvm_field_int(i_din   ,UVM_ALL_ON)
     `uvm_field_int(i_rst_n ,UVM_ALL_ON)
     `uvm_field_int(o_dout   ,UVM_ALL_ON)
     `uvm_field_int(o_dout_n   ,UVM_ALL_ON)
  `uvm_object_utils_end
    
    function new(string name = "DFF_seq_item");
        super.new(name);
        `uvm_info("sequence item Class","constructor",UVM_MEDIUM)
    endfunction
    
    function string input2string();
        return($sformatf("d=%0b  rst=%0b", i_din,i_rst_n));
    endfunction
      // write DUT outputs here for printing
    function string output2string();
      return($sformatf("q=%0b",o_dout));
    endfunction
    function string convert2string();
        return($sformatf({input2string(), " || ", output2string()}));
    endfunction
    
    constraint wr_rd_c {i_rst_n != 0;};
endclass
