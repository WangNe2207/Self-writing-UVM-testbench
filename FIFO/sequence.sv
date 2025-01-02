class fifo_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)
  
  fifo_seq_item trans;
  
  function new(string name = "fifo_seq_item");
    super.new(name);
    `uvm_info("fifo_sequence:","Constructor", UVM_MEDIUM)
  endfunction
  
  task body();
    for(int i=0;i<20;i++) begin
      trans = fifo_seq_item::type_id::create("trans");
      start_item(trans);
      if(i<10) begin
        if(!trans.randomize() with{trans.put==1; trans.get==0;}) begin
          `uvm_error("fifo_sequence", "put error");  
        end
      end
      else begin
        if(!trans.randomize() with{trans.put==0; trans.get==1;}) begin
          `uvm_error("fifo_sequence", "get error");  
        end
      end
      finish_item(trans);
    end
  endtask
  
endclass