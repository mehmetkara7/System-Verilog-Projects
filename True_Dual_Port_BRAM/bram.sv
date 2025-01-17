`timescale 1ns / 1ps

module bram#(
    parameter WIDTH =16 ,//genişlik
    parameter DEPTH = 1024 //derinlik
)
(   
    input   logic  clk,
    //Port A
    input   logic  read_en_a,
    input   logic  write_en_a,
    input   logic  [WIDTH-1:0] data_in_a,
    input   logic  [$clog2(DEPTH)-1:0] addr_a,
    output  logic  [WIDTH-1:0] data_out_a,
    //Port B
    input   logic  read_en_b,
    input   logic  write_en_b,
    input   logic  [WIDTH-1:0] data_in_b,
    input   logic  [$clog2(DEPTH)-1:0] addr_b,
    output  logic  [WIDTH-1:0] data_out_b
 );

(* ram_style = "block" *) logic [WIDTH-1:0] mem [DEPTH-1:0]='{default:0};

always_ff @(clk) begin 
    if(read_en_a) begin
        data_out_a <= mem[addr_a];
    end 
    if(write_en_a) begin
        mem[addr_a] <= data_in_a;
    end
end

always_ff @(clk) begin 
    if(read_en_b) begin
        data_out_b <= mem[addr_b];
    end
    if(write_en_b) begin
        mem[addr_b] <= data_in_b;
    end

end

endmodule
