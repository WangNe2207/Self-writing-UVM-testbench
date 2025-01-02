class ALU_test extends uvm_test;
  `uvm_component_utils(ALU_test)
  ALU_env env;
  ALU_sequence seq;
  ALU_rst_sequence rst_seq;
  
  function new(string name = "ALU_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_test:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_test:","build phase", UVM_MEDIUM)
    env = ALU_env::type_id::create("env", this);    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ALU_test:","connect phase", UVM_MEDIUM)
  endfunction
  
  virtual function void end_of_elaboration();
    `uvm_info("ALU_test:","end_of_elaboration phase", UVM_MEDIUM)
    print();
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("ALU_test:","run phase", UVM_MEDIUM)
    phase.raise_objection(this);
    
    rst_seq = ALU_rst_sequence::type_id::create("rst_seq", this);
    rst_seq.start(env.agent.seqr);
    #10
    repeat(50) begin
      seq = ALU_sequence::type_id::create("seq", this);
      seq.start(env.agent.seqr);
    end
    
    phase.drop_objection(this);
  endtask
  
endclass