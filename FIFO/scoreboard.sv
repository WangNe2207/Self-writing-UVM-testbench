
class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  uvm_blocking_get_port#(fifo_seq_item) exp_port;
  uvm_blocking_get_port#(fifo_seq_item) act_port;
  fifo_seq_item act_trans;
  fifo_seq_item exp_trans;
  bit result;
  int count_right, count_wrong, count;

  
  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("fifo_scoreboard:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("fifo_scoreboard:","build phase", UVM_MEDIUM)
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("fifo_scoreboard:","connect phase", UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    exp_trans = fifo_seq_item::type_id::create("exp_trans",this);
    act_trans = fifo_seq_item::type_id::create("act_trans",this);
    forever begin
    	exp_port.get(exp_trans);
     	act_port.get(act_trans);
      result = (exp_trans.data_in == act_trans.data_in) &&(exp_trans.get==act_trans.put)&&(exp_trans.put==act_trans.get);
      if(result) begin
        PASS();
        `uvm_info("Scoreboard","Compare SUCCCESSFULL",UVM_MEDIUM);
      end
      else begin
        WRONG();
        `uvm_warning("WARNING", "compare failed")
      end
        
    end
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(count_right==count) begin
      `uvm_info("PASS",$sformatf("TEST PASS: %0d vector ran, %0d vector ran passed!!!!!!",count, count_right),UVM_LOW)
    end
    else begin
      `uvm_info("FAILED",$sformatf("TEST FAILED: %0d vector ran, %0d vector ran passed!!!!!!",count, count_right),UVM_LOW)
    end
  endfunction
        
   function void PASS();
     count_right++;
     count++;
   endfunction
  
   function void WRONG();
     count_wrong++;
     count++;
   endfunction
  
endclass