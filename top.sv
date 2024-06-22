`timescale 1ns / 1ns
module top;
  
  localparam integer AWIDTH=5;
  localparam integer DWIDTH=8;
  
  logic  clk=0;
  logic wrt;
  logic [AWIDTH-1:0] addr;
  wire [DWIDTH-1:0] data;
  logic [DWIDTH-1:0] data_out;
  
  always #5 clk = !clk;
  
  mem_new  #(AWIDTH,DWIDTH) mem  (clk,wrt,addr,data);
  
  // Drive the inout port conditionally
  assign data = wrt ? data_out : 'bz;
  
  initial begin
    
    #1 
    $display("This is printed after 1 nanosecond delay");
    #1
    $display("Time=%f", $time);
    
    #1
    addr = 10;
    wrt = 1;
    data_out = 10;
    
    #1
    addr = 20;
    wrt = 1;
    
    #1
    addr = 30;
    wrt = 1;
    
    #1
    wrt = 0;
    addr = 10;
    $display("addr=%h, data=%h", addr,data);
    
    #1
    addr = 30;
    $display("addr=%h, data=%h", addr,data);
    
    #1
    addr = 20;
    $display("addr=%h, data=%h", addr,data);
    
    
  end  
  
  
  
endmodule 
