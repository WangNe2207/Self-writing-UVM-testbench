interface FIFO_interface();
  logic clk, reset, put, get, empty_bar, full_bar;
  logic [15:0]data_in;
  logic [15:0] data_out;
endinterface