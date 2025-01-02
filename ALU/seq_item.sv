class ALU_seq_item extends uvm_sequence_item;
  rand logic reset;
  rand logic [7:0] A;
  rand logic [7:0] B;
  rand logic [3:0] ALU_Sel;
  logic [7:0] ALU_Out;
  logic CarryOut;
  
    `uvm_object_utils_begin(ALU_seq_item)
  		`uvm_field_int(reset, UVM_ALL_ON)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(ALU_Sel, UVM_ALL_ON)
        `uvm_field_int(ALU_Out, UVM_ALL_ON)
        `uvm_field_int(CarryOut, UVM_ALL_ON)
     `uvm_object_utils_end
  
  function new(string name = "ALU_seq_item");
    super.new(name);
    `uvm_info("ALU_seq_item:","Constructor", UVM_MEDIUM)
  endfunction
  
  constraint input1_c {A inside {[10:20]};}
  constraint input2_c {B inside {[1:10]};}
  constraint op_code_c {ALU_Sel inside {0,1,2,3};}
  
endclass