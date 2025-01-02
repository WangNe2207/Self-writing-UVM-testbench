class ALU_driver extends uvm_driver#(ALU_seq_item);
  `uvm_component_utils(ALU_driver)
  uvm_analysis_port#(ALU_seq_item) drv2scb;
  virtual ALU_interface drv2dut;
  ALU_seq_item trans;
  
  function new(string name = "ALU_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_driver:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_driver:","build phase", UVM_MEDIUM)
    if(!uvm_config_db#(virtual ALU_interface)::get(this,"","ALU_interface",drv2dut))
      `uvm_error("ALU_driver","uvm_config_db::get failed!")
     drv2scb = new("drv2scb", this);
  endfunction
  
  task send_data();

    @(posedge drv2dut.clock)
    $display($time,"time driver get");
//     if(!drv2dut.reset) begin
    trans = ALU_seq_item::type_id::create("trans");
    seq_item_port.get_next_item(trans);
        drv2dut.A = trans.A;
        drv2dut.B = trans.B;
        drv2dut.reset = trans.reset;
        drv2dut.ALU_Sel = trans.ALU_Sel;
		@(posedge drv2dut.clock)
        drv2scb.write(trans);
        $display("Driver: send data to scoreboard");
        $display("A: %0h", drv2dut.A);
        $display("B: %0h", drv2dut.B);
        $display("reset: %0h", drv2dut.reset);
        $display("ALU_Sel: %0h", drv2dut.ALU_Sel);

        seq_item_port.item_done();
//     end
  endtask
  
  task run_phase(uvm_phase phase);
    
    forever begin
    	send_data();
    end
  endtask
  
  
endclass