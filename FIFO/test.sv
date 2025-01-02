class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
  fifo_env env;
  fifo_sequence seq;
  
  function new(string name = "fifo_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_test:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_test:","build phase", UVM_MEDIUM)
    env = fifo_env::type_id::create("env", this);
    seq = fifo_sequence::type_id::create("seq", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("fifo_test:","connect phase", UVM_MEDIUM)
  endfunction
  
  virtual function void end_of_elaboration();
    `uvm_info("fifo_test:","end_of_elaboration phase", UVM_MEDIUM)
    print();
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("fifo_test:","run phase", UVM_MEDIUM)
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
  
endclass