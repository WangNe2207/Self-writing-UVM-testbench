class ALU_monitor extends uvm_monitor;
  `uvm_component_utils(ALU_monitor)
  
  uvm_analysis_port#(ALU_seq_item) mon2scb;
  virtual ALU_interface drv2dut;  
  ALU_seq_item trans;
  
  function new(string name = "ALU_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_monitor:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_monitor:","build phase", UVM_MEDIUM)
    if(!uvm_config_db#(virtual ALU_interface)::get(this,"","ALU_interface",drv2dut))
      `uvm_error("ALU_driver","uvm_config_db::get failed!")
       mon2scb = new("mon2scb", this);
  endfunction
  
  task receive_data();
    
    
      trans = ALU_seq_item::type_id::create("trans");
      @(posedge drv2dut.clock);
//     if(!mon2dut.reset) begin
    $display($time,"time monitor get input");
      #1
      trans.A = drv2dut.A;
      trans.B = drv2dut.B;
      trans.reset = drv2dut.reset;
      trans.ALU_Sel = drv2dut.ALU_Sel;
    $display("A: %0h", trans.A);
    $display("B: %0h", trans.B);
    $display("ALU_Sel: %0h", trans.ALU_Sel);
      @(posedge drv2dut.clock);
      #1
    $display($time,"time monitor get output");
      trans.ALU_Out = drv2dut.ALU_Out;
      trans.CarryOut = drv2dut.CarryOut;
      $display("monitor: send data to scoreboard");
      $display("ALU_Out: %0h", trans.ALU_Out);
      $display("CarryOut: %0h", trans.CarryOut);
      mon2scb.write(trans);
//     end
  endtask
  
  task run_phase(uvm_phase phase);
    forever begin
    	receive_data();
    end
  endtask
  
  
endclass