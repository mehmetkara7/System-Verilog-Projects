`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2025 15:35:45
// Design Name: 
// Module Name: block_ram
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


module block_ram
#(
    parameter WIDTH =16 ,//genişlik
    parameter DEPTH = 1024 //derinlik
)
(
    input   logic  clk,
    input   logic  write_en,
    input   logic  read_en,
    input   logic  [WIDTH-1:0] data_in,
    input   logic  [$clog2(DEPTH)-1:0] addr,
    output  logic  [WIDTH-1:0] data_out
 );
(* ram_style = "block" *) //ram tipi
logic [WIDTH-1:0] ram [0:DEPTH-1]='{default :0}; //bellek
always_ff @( posedge clk ) begin 
    if (write_en) begin
        ram[addr] <= data_in;
    end
    if (read_en) begin
        data_out <= ram[addr];
    end
    
end
endmodule
