`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 09:29:43 PM
// Design Name: 
// Module Name: agent
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

class DFF_agent extends uvm_agent;
    `uvm_component_utils(DFF_agent)
    
    DFF_monitor monitor;
    DFF_driver driver;
    DFF_sequencer sequencer;
    
    function new(string name = "DFF_agent",uvm_component parent);
        super.new(name, parent);
        `uvm_info("agent Class","constructor",UVM_MEDIUM);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = DFF_monitor::type_id::create("DFF_monitor", this);
        driver = DFF_driver::type_id::create("DFF_driver", this);
        sequencer = DFF_sequencer::type_id::create("DFF_sequencer", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("agent class","connect phase",UVM_MEDIUM)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass

