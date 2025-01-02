`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 09:03:33 PM
// Design Name: 
// Module Name: score_board
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
`uvm_analysis_imp_decl(_drv)
`uvm_analysis_imp_decl(_mon)
class DFF_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(DFF_scoreboard)
    uvm_analysis_imp_mon#(DFF_seq_item, DFF_scoreboard) aport_mon;
    
    uvm_analysis_imp_drv#(DFF_seq_item, DFF_scoreboard) aport_drv;
    
    uvm_tlm_fifo #(DFF_seq_item) expfifo;
    uvm_tlm_fifo #(DFF_seq_item) outfifo;
    bit out[$];
    logic i_din, i_rst_n, o_dout, o_dout_temp;
    int unsigned count = 0;
    int i;
    int VECT_CNT, PASS_CNT, ERROR_CNT;

    function new(string name = "DFF_scoreboard",uvm_component parent);
        super.new(name, parent);
        `uvm_info("Scoreboard Class","constructor",UVM_MEDIUM);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aport_mon = new("aport_mon", this);    
        aport_drv = new("aport_drv", this); 
        expfifo= new("expfifo",this);
        outfifo= new("outfifo",this);
    endfunction
    
    function void write_drv(DFF_seq_item tx);
        `uvm_info("write_drv: receive Trans for driver", tx.input2string(), UVM_MEDIUM)
        i_din    = tx.i_din;
        i_rst_n  = tx.i_rst_n;
        o_dout_temp = o_dout;
        if(i_rst_n==0) begin 
          count=0;
          o_dout = 0;
          out={0,0};
          i=1;
          out.push_back(o_dout);
        end
        else begin 
          o_dout=i_din;
          out.push_back(o_dout);
        end
        tx.o_dout = out[i-1];
        i++;
        void'(expfifo.try_put(tx));
    endfunction
    
  function void write_mon(DFF_seq_item tx);
    `uvm_info("write_mon: receive output for DUT", tx.convert2string(), UVM_MEDIUM)
     void'(outfifo.try_put(tx));
  endfunction
  
  task run_phase(uvm_phase phase);
	DFF_seq_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
        if (out_tr.o_dout===exp_tr.o_dout && count>0) begin
            PASS();
           `uvm_info ("\n [ PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      	else if (out_tr.o_dout!==exp_tr.o_dout && count>0) begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
          count++;
    end
  endtask
  
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	  VECT_CNT++;
	  PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
    
endclass
