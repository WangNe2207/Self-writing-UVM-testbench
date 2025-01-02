`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:53:14 PM
// Design Name: 
// Module Name: sequence
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

class DFF_sequence extends uvm_sequence#(DFF_seq_item);
    `uvm_object_utils(DFF_sequence)
    
    DFF_seq_item tx;
    
    function new(string name = "DFF_sequence");
        super.new(name);
        `uvm_info("sequence Class","constructor",UVM_MEDIUM)
    endfunction
    
    task body();
        repeat(50) begin
        `uvm_info("sequence: create Transaction", "run_phase", UVM_MEDIUM)
        tx = DFF_seq_item ::type_id::create("tx");
        `uvm_info("sequence: wait for grant", "run_phase", UVM_MEDIUM)
        wait_for_grant();
        tx.randomize();// with (rst==1);
        `uvm_info("sequence: sent Transaction to driver", "run_phase", UVM_MEDIUM)

        send_request(tx);
        wait_for_item_done();
    end
  endtask
    
endclass
