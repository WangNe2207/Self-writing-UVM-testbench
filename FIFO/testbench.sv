import uvm_pkg::*;

`include "uvm_macros.svh"

`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "monitor.sv"
`include "driver.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"




module testbench;
  
  FIFO_interface intf();
  
  FIFO DUT(.clk(intf.clk), 
           .reset(intf.reset), 
           .put(intf.put), 
           .get(intf.get), 
           .data_in(intf.data_in), 
           .data_out(intf.data_out),
           .empty_bar(intf.empty_bar), 
           .full_bar(intf.full_bar), 
           .data_out(intf.data_out));
  
  always #5 intf.clk = !intf.clk;
  
  initial begin
    uvm_config_db#(virtual FIFO_interface)::set(null,"*","FIFO_interface",intf);
    run_test("fifo_test");
  end
  
  initial begin
    	intf.clk <= 'b1;
    	intf.reset <= 'b1;
    repeat(3)@(posedge intf.clk);
    	intf.reset <= 'b0;
  end
endmodule:testbench