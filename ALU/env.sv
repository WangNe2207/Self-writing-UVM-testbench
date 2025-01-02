class ALU_env extends uvm_env;
  `uvm_component_utils(ALU_env)
  
  ALU_agent agent;
  ALU_scoreboard scb;
  uvm_tlm_analysis_fifo#(ALU_seq_item) mon2scb_ALU;
  uvm_tlm_analysis_fifo#(ALU_seq_item) drv2scb_ALU;

  function new(string name = "ALU_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_env:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_env:","build phase", UVM_MEDIUM)
    agent = ALU_agent::type_id::create("agent", this);
    scb = ALU_scoreboard::type_id::create("scb", this);
    mon2scb_ALU = new("mon2scb_ALU", this);
    drv2scb_ALU = new("drv2scb_ALU", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ALU_env:","connect phase", UVM_MEDIUM)
    agent.drv.drv2scb.connect(drv2scb_ALU.analysis_export);
    agent.mon.mon2scb.connect(mon2scb_ALU.analysis_export);
    scb.exp_port.connect(drv2scb_ALU.blocking_get_export);
    scb.act_port.connect(mon2scb_ALU.blocking_get_export);
  endfunction
  
endclass