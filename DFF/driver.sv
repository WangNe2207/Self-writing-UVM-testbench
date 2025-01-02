`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:46:55 PM
// Design Name: 
// Module Name: driver
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

class DFF_driver extends uvm_driver#(DFF_seq_item);
    `uvm_component_utils(DFF_driver)
    virtual DFF_interface intf;
    DFF_seq_item tx;
    uvm_analysis_port#(DFF_seq_item) drv2scb;
    
    function new(string name = "DFF_driver",uvm_component parent);
        super.new(name, parent);
        `uvm_info("driver Class","constructor",UVM_MEDIUM)
    endfunction
    
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!uvm_config_db#(virtual DFF_interface)::get(this, "", "vif", intf))
           `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
         
         drv2scb = new("drv2scb", this);
    endfunction
    
    
    
  task run_phase(uvm_phase phase);
    initilize();
    forever begin
      `uvm_info("driver Class:", "run_phase", UVM_MEDIUM)

      seq_item_port.get_next_item(tx);
      drive(tx);
      `uvm_info("driver Class: Receive Transaction from Sequence, and sent it to monitor and DUT", "run_phase", UVM_MEDIUM)
      drv2scb.write(tx);
      `uvm_info("driver Class: Sent Transaction Done", tx.convert2string() , UVM_MEDIUM)
      seq_item_port.item_done();
    end
  endtask
  
  task drive(DFF_seq_item tx);
    @(intf.cb);
    intf.cb.i_rst_n <= tx.i_rst_n;
    intf.cb.i_din <= tx.i_din;
  endtask
  
  task initilize();
    intf.i_din   = 0;
    intf.i_rst_n = 0;
  endtask
endclass
