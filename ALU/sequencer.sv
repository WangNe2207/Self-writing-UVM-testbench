class ALU_sequencer extends uvm_sequencer#(ALU_seq_item);
  `uvm_component_utils(ALU_sequencer)
  
  function new(string name = "ALU_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_sequencer:","Constructor", UVM_MEDIUM)
  endfunction
  
  
endclass