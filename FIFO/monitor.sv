class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)
  
  uvm_analysis_port#(fifo_seq_item) mon2scb;
  virtual FIFO_interface mon2dut;  
  fifo_seq_item trans;
  
  function new(string name = "fifo_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_monitor:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_monitor:","build phase", UVM_MEDIUM)
     if(!uvm_config_db#(virtual FIFO_interface)::get(this,"","FIFO_interface",mon2dut))
          `uvm_info("fifo_monitor","uvm_config_db::get failed!",UVM_HIGH)
       mon2scb = new("mon2scb", this);
  endfunction
  
  task receive_data();
    @(posedge mon2dut.clk)
    trans = fifo_seq_item::type_id::create("trans");
    

    if(!mon2dut.reset&mon2dut.empty_bar&mon2dut.get) begin
	  #1
      trans.data_in = mon2dut.data_out;
      trans.get = mon2dut.get;
      trans.put = mon2dut.put;
      $display("monitor: send data to scoreboard");
      $display("data_in: %0h", mon2dut.data_in);
      $display("data_out: %0h", mon2dut.data_out);
      $display("get: %0h", mon2dut.get);
      $display("put: %0h", mon2dut.put);
      $display("empty_bar: %0h", mon2dut.empty_bar);
      $display("full_bar: %0h", mon2dut.full_bar);
      mon2scb.write(trans);
    end
  endtask
  
  task run_phase(uvm_phase phase);
    forever begin
    	receive_data();
    end
  endtask
  
  
endclass