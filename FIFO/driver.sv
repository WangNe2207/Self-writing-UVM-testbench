class fifo_driver extends uvm_driver#(fifo_seq_item);
  `uvm_component_utils(fifo_driver)
  uvm_analysis_port#(fifo_seq_item) drv2scb;
  virtual FIFO_interface drv2dut;
  fifo_seq_item trans;
  
  function new(string name = "fifo_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_driver:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_driver:","build phase", UVM_MEDIUM)
     if(!uvm_config_db#(virtual FIFO_interface)::get(this,"","FIFO_interface",drv2dut))
          `uvm_info("fifo_driver","uvm_config_db::get failed!",UVM_HIGH)
     drv2scb = new("drv2scb", this);
  endfunction
  
  task send_data();
    
    @(posedge drv2dut.clk)
    trans = fifo_seq_item::type_id::create("trans");
//     $display("driver: send data to scoreboard");
//       $display("reset: %0h", drv2dut.reset);
//       $display("full_bar: %0h", drv2dut.full_bar);
//       $display("put: %0h", drv2dut.put);
    if(!drv2dut.reset) begin
      seq_item_port.get_next_item(trans);
      drv2dut.data_in <= trans.data_in;
      drv2dut.get <= trans.get;
      drv2dut.put <= trans.put;
      drv2scb.write(trans);
      $display("Driver: send data to scoreboard");
      trans.print();
      seq_item_port.item_done();
    end
  endtask
  
  task run_phase(uvm_phase phase);
    forever begin
    	send_data();
    end
  endtask
  
  
endclass