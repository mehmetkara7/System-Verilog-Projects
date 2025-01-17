`timescale 1ns / 1ps

module tb_block_ram#(
    parameter WIDTH =16 ,//genişlik
    parameter DEPTH = 1024 //derinlik;
                    );
  logic  clk=0;
  logic  write_en;
  logic  read_en;
  logic  [WIDTH-1:0] data_in;
  logic  [$clog2(DEPTH)-1:0] addr;
  logic  [WIDTH-1:0] data_out;
block_ram
#(
     .WIDTH(WIDTH), 
     .DEPTH(DEPTH)  
)
block_ram_Inst(
      .clk(clk),
      .write_en(write_en),
      .read_en(read_en),
      .data_in(data_in),
      .addr(addr),
      .data_out(data_out)
 );

//test
always #5 clk = ~clk;
initial begin
    #100 @(negedge clk); 
    write_en = 1;
    read_en = 0;
    data_in = 16'hABCD;
    addr = 10;
    @(negedge clk);
    write_en = 1;
    read_en = 0;
    data_in = 16'h1234;
    addr = 11;
    #100
    @(negedge clk);
    write_en = 0;
    #100 @(negedge clk);
    addr = 10;
    read_en = 1;
    @(negedge clk);
    read_en = 1;
    addr = 11;
    @(negedge clk);
    $finish;
end





endmodule
