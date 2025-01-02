`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:50:40 PM
// Design Name: 
// Module Name: sequencer
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

class DFF_sequencer extends uvm_sequencer#(DFF_seq_item);
    `uvm_component_utils(DFF_sequencer)
    
    function new(string name = "DFF_sequencer",uvm_component parent);
        super.new(name, parent);
        `uvm_info("sequencer Class","constructor",UVM_MEDIUM)
    endfunction
    
endclass
