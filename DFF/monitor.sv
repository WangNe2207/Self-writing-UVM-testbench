`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:49:47 PM
// Design Name: 
// Module Name: monitor
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

class DFF_monitor extends uvm_monitor;
    `uvm_component_utils(DFF_monitor)
     virtual DFF_interface intf;
     uvm_analysis_port#(DFF_seq_item) mon2scb;
     DFF_seq_item tx;
     
    function new(string name = "DFF_monitor",uvm_component parent);
        super.new(name, parent);
        `uvm_info("monitor Class","constructor",UVM_MEDIUM)
    endfunction
    
    function void build_phase(uvm_phase phase);
         super.build_phase(phase);
         mon2scb = new("item_collected_port", this);
         if(!uvm_config_db#(virtual DFF_interface)::get(this, "", "vif", intf))
           `uvm_fatal("no_inif in monitor","virtual interface get failed from config db");

    endfunction
    
    task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("monitor Class", "run_phase", UVM_MEDIUM)
            tx = DFF_seq_item::type_id::create("tx");
            @(intf.cb);
            #1;
            tx.i_rst_n = intf.i_rst_n;
            tx.i_din = intf.i_din;
            tx.o_dout = intf.o_dout;
            tx.o_dout_n = intf.o_dout_n;
            `uvm_info("monitor Class: receive Trans from DUT", tx.convert2string(), UVM_MEDIUM)
            mon2scb.write(tx);
            `uvm_info("monitor Class: sent Trans to scoreboard", tx.convert2string(), UVM_MEDIUM)
        end
  endtask
    
    
endclass

