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
  logic clock;
  ALU_interface intf(.clock(clock));
  
  alu DUT(
    .clock(intf.clock),
    .reset(intf.reset),
    .A(intf.A),
    .B(intf.B),  // ALU 8-bit Inputs                 
    .ALU_Sel(intf.ALU_Sel),// ALU Selection
    .ALU_Out(intf.ALU_Out), // ALU 8-bit Output
    .CarryOut(intf.CarryOut) // Carry Out Flag
);
  
  initial begin 
    clock <= 'b0;

  end
  
  always #5 clock = ~clock;
  
  initial begin
    uvm_config_db#(virtual ALU_interface)::set(null,"*","ALU_interface",intf);
    run_test("ALU_test");
  end
  
  initial begin
    $dumpfile("d.vcd");
    $dumpvars();
  end

  
endmodule
