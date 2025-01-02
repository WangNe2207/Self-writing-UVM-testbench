
class ALU_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ALU_scoreboard)
  
  uvm_blocking_get_port#(ALU_seq_item) exp_port;
  uvm_blocking_get_port#(ALU_seq_item) act_port;
  ALU_seq_item act_trans;
  ALU_seq_item exp_trans;
  logic [7:0] out;
  logic [8:0] tmp;
  logic CarryOut;
  bit result;
  int count_right, count_wrong, count;

  
  function new(string name = "ALU_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ALU_scoreboard:","Constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ALU_scoreboard:","build phase", UVM_MEDIUM)
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ALU_scoreboard:","connect phase", UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    exp_trans = ALU_seq_item::type_id::create("exp_trans",this);
    act_trans = ALU_seq_item::type_id::create("act_trans",this);
    forever begin
    	exp_port.get(exp_trans);
      
     	act_port.get(act_trans);
      
      if(exp_trans.reset) begin
        out = 'd0;
      end
      else begin
        case(exp_trans.ALU_Sel)
          4'b0000:begin // Addition
            out = exp_trans.A + exp_trans.B ; 
          end
          4'b0001:begin // Subtraction
            out = exp_trans.A - exp_trans.B ;
          end
          4'b0010: begin // Multiplication
            out = exp_trans.A * exp_trans.B;
          end
          4'b0011: begin// Division
            out = exp_trans.A/exp_trans.B;
          end
          default: begin 
            out = 'd0 ;
          end
        endcase
      end
      tmp = {1'b0,exp_trans.A} + {1'b0,exp_trans.B};
      CarryOut = tmp[8];
      $display("Scoreboard: exp_trans");
      $display("exp_A: %0d", exp_trans.A);
      $display("exp_B: %0d", exp_trans.B);
      $display("ALU_Sel: %0d", exp_trans.ALU_Sel);
      $display("exp_out: %0d", out);
      $display("exp_CarryOut: %0d", CarryOut);
      
      $display("Scoreboard: act_trans");
      $display("act_A: %0d", act_trans.A);
      $display("act_B: %0d", act_trans.B);
      $display("ALU_Sel: %0d", act_trans.ALU_Sel);
      $display("act_out: %0d", act_trans.ALU_Out);
      $display("act_CarryOut: %0d", act_trans.CarryOut);
      result = (act_trans.ALU_Out == out) &&(act_trans.CarryOut==CarryOut);
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