class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent)
  fifo_monitor mon;
  fifo_driver drv;
  fifo_sequencer seqr;
  function new(string name = "fifo_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_agent:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_agent:","build phase", UVM_MEDIUM)
    mon = fifo_monitor::type_id::create("mon", this);
    drv = fifo_driver::type_id::create("drv", this);
    seqr = fifo_sequencer::type_id::create("seqr", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("fifo_agent:","connect phase", UVM_MEDIUM)
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass