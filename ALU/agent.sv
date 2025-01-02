class ALU_agent extends uvm_agent;
  `uvm_component_utils(ALU_agent)
  ALU_monitor mon;
  ALU_driver drv;
  ALU_sequencer seqr;
  function new(string name = "ALU_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_agent:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_agent:","build phase", UVM_MEDIUM)
    mon = ALU_monitor::type_id::create("mon", this);
    drv = ALU_driver::type_id::create("drv", this);
    seqr = ALU_sequencer::type_id::create("seqr", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ALU_agent:","connect phase", UVM_MEDIUM)
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass