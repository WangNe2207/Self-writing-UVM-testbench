class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  
  fifo_agent agent;
  fifo_scoreboard scb;
  uvm_tlm_analysis_fifo#(fifo_seq_item) mon2scb_fifo;
  uvm_tlm_analysis_fifo#(fifo_seq_item) drv2scb_fifo;

  function new(string name = "fifo_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_env:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_env:","build phase", UVM_MEDIUM)
    agent = fifo_agent::type_id::create("agent", this);
    scb = fifo_scoreboard::type_id::create("scb", this);
    mon2scb_fifo = new("mon2scb_fifo", this);
    drv2scb_fifo = new("drv2scb_fifo", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("fifo_env:","connect phase", UVM_MEDIUM)
    agent.drv.drv2scb.connect(drv2scb_fifo.analysis_export);
    agent.mon.mon2scb.connect(mon2scb_fifo.analysis_export);
    scb.exp_port.connect(drv2scb_fifo.blocking_get_export);
    scb.act_port.connect(mon2scb_fifo.blocking_get_export);
  endfunction
  
endclass