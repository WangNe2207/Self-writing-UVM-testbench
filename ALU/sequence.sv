class ALU_sequence extends uvm_sequence#(ALU_seq_item);
  `uvm_object_utils(ALU_sequence)
  
  ALU_seq_item trans;
  
  function new(string name = "ALU_sequence");
    super.new(name);
    `uvm_info("ALU_sequence:","Constructor", UVM_MEDIUM)
  endfunction
  
  task body();
    `uvm_info("ALU_sequence:","run phase", UVM_MEDIUM)
    trans = ALU_seq_item::type_id::create("trans");
     start_item(trans);
    trans.randomize() with {trans.reset == 0;};
//     $display("ALU_sequence: randomize");
//       $display("A: %0h", trans.A);
//       $display("B: %0h", trans.B);
//       $display("reset: %0h", trans.reset);
//       $display("ALU_Sel: %0h", trans.ALU_Sel);
//       $display("ALU_Out: %0h", trans.ALU_Out);
//       $display("CarryOut: %0h", trans.CarryOut);
     finish_item(trans);
  endtask
  
endclass

class ALU_rst_sequence extends ALU_sequence#(ALU_seq_item);
  `uvm_object_utils(ALU_rst_sequence)
  
  ALU_seq_item trans;
  
  function new(string name = "ALU_rst_sequence");
    super.new(name);
    `uvm_info("ALU_rst_sequence:","Constructor", UVM_MEDIUM)
  endfunction
  
  task body();
    `uvm_info("ALU_rst_sequence:","run phase", UVM_MEDIUM)
    trans = ALU_seq_item::type_id::create("trans");
     start_item(trans);
    trans.randomize() with {trans.reset == 1;};
    $display("ALU_rst_sequence: randomize");
      $display("A: %0h", trans.A);
      $display("B: %0h", trans.B);
      $display("reset: %0h", trans.reset);
      $display("ALU_Sel: %0h", trans.ALU_Sel);
      $display("ALU_Out: %0h", trans.ALU_Out);
      $display("CarryOut: %0h", trans.CarryOut);
     finish_item(trans);
  endtask
  
endclass