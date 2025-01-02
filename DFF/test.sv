`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:36:48 PM
// Design Name: 
// Module Name: test
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

class DFF_test extends uvm_test;
    `uvm_component_utils(DFF_test)
    DFF_env env;
    DFF_sequence seq;
    function new(string name = "DFF_test",uvm_component parent);
        super.new(name, parent);
        `uvm_info("Test Class","constructor",UVM_MEDIUM);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = DFF_env::type_id::create("env", this);
        seq = DFF_sequence::type_id::create("seq", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("Test Class", "connect phase", UVM_MEDIUM)
    endfunction
    
    virtual function void end_of_elaboration();
        `uvm_info("Test Class","elob phase", UVM_MEDIUM)
        print();
    endfunction
    
    task run_phase(uvm_phase phase);
        `uvm_info("Test Class", "run_phase", UVM_MEDIUM)

        phase.raise_objection(this); //stay in run_phase untill the Test drop the objection
        seq.start(env.agent.sequencer); 
        phase.drop_objection(this);
    
    endtask

endclass
