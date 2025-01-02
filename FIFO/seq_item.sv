class fifo_seq_item extends uvm_sequence_item;
  rand logic put;
  rand logic get;
  rand logic [15:0] data_in;
  logic [15:0] data_out;
  logic empty_bar;
  logic full_bar;
  
    `uvm_object_utils_begin(fifo_seq_item)
        `uvm_field_int(put, UVM_ALL_ON)
        `uvm_field_int(get, UVM_ALL_ON)
        `uvm_field_int(data_in, UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
        `uvm_field_int(empty_bar, UVM_ALL_ON)
        `uvm_field_int(full_bar, UVM_ALL_ON)
     `uvm_object_utils_end
  
  function new(string name = "fifo_seq_item");
    super.new(name);
    `uvm_info("fifo_seq_item:","Constructor", UVM_MEDIUM)
  endfunction
  
  constraint wr_rd_c {put != get;};
  
endclass