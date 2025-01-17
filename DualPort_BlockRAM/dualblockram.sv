`timescale 1ns / 1ps

module dualblockram#(
    parameter WIDTH =16 ,//genişlik
    parameter DEPTH = 1024 //derinlik
)
(
    input   logic  clk,
    input   logic  write_en_a,
    input   logic  read_en_b,
    input   logic  [WIDTH-1:0] data_in_a,
    input   logic  [$clog2(DEPTH)-1:0] addr_a,
    input   logic  [$clog2(DEPTH)-1:0] addr_b,
    output  logic  [WIDTH-1:0] data_out_b
 );

 (* ram_style = "block" *);
 logic [WIDTH-1:0] ram [0:DEPTH-1]='{default :0}; //bellek
always_ff @( posedge clk ) begin 
    if (write_en_a) begin
        ram[addr_a] <= data_in_a;
    end
    if (read_en_b) begin
        data_out_b <= ram[addr_b];
    end
    
end

endmodule
