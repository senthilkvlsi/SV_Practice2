`timescale 1ns / 1ns

module mem_new
#(parameter integer AWIDTH=1,
  parameter integer DWIDTH=1
 )
 (
  input logic clk,
  input logic wrt,
  input logic [AWIDTH-1:0] addr,
  inout wire [DWIDTH-1:0] data
 );

  logic [DWIDTH-1:0] mem [0:2**AWIDTH-1];
  logic [DWIDTH-1:0] datao; // data reg

  always @(posedge clk) if (wrt)
    mem[addr] <= data;

  always @(posedge clk) if (!wrt)
    datao <= mem[addr];

  assign data = wrt? 'bZ : datao;

endmodule // mem_m
