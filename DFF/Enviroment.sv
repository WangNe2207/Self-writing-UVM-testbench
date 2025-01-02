`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 08:45:35 PM
// Design Name: 
// Module Name: Enviroment
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

class DFF_env extends uvm_env;
    `uvm_component_utils(DFF_env)
    DFF_scoreboard scoreboard;
    DFF_agent agent;
    function new(string name = "DFF_env",uvm_component parent);
        super.new(name, parent);
        `uvm_info("env Class","constructor",UVM_MEDIUM)
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scoreboard = DFF_scoreboard::type_id::create("scb", this);
        agent = DFF_agent::type_id::create("agent", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("env class","connect phase",UVM_MEDIUM)
        agent.monitor.mon2scb.connect(scoreboard.aport_mon);
        agent.driver.drv2scb.connect(scoreboard.aport_drv);
    endfunction
endclass