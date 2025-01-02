class fifo_sequencer extends uvm_sequencer#(fifo_seq_item);
  `uvm_component_utils(fifo_sequencer)
  
  function new(string name = "fifo_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_sequencer:","Constructor", UVM_MEDIUM)
  endfunction
  
  
endclass