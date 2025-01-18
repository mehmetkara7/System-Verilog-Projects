`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.01.2025 12:28:41
// Design Name: 
// Module Name: syn_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module syn_fifo(
    input  logic clk,
    input  logic srst,
    input  logic [7 : 0] din,
    input  logic wr_en,
    input  logic rd_en,
    output logic  [7 : 0] dout,
    output logic  full,
    output logic  empty
    );


fifo_generator_0 your_instance_name (
  .clk(clk),      // input wire clk
  .srst(srst),    // input wire srst
  .din(din),      // input wire [7 : 0] din
  .wr_en(wr_en),  // input wire wr_en
  .rd_en(rd_en),  // input wire rd_en
  .dout(dout),    // output wire [7 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);
endmodule
