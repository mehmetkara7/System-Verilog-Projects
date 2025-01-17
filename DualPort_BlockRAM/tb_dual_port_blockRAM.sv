`timescale 1ns / 1ps

module tb_dual_port_blockRAM#(
    parameter WIDTH = 16,  // genişlik
    parameter DEPTH = 1024 // derinlik
);
logic  clk = 0;
logic  write_en_a = 0;
logic  read_en_b = 0;
logic  [WIDTH-1:0] data_in_a = 0;
logic  [$clog2(DEPTH)-1:0] addr_a = 0;
logic  [$clog2(DEPTH)-1:0] addr_b = 0;
logic  [WIDTH-1:0] data_out_b = 0;

dualblockram#(
    .WIDTH(WIDTH), // genişlik
    .DEPTH(DEPTH)  // derinlik
)
dualblockram_Inst(
    .clk(clk),
    .write_en_a(write_en_a),
    .read_en_b(read_en_b),
    .data_in_a(data_in_a),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .data_out_b(data_out_b)
);

// Clock generation
always #5 clk = ~clk;


initial begin
    // İlk durum
    #100 @(negedge clk);
    write_en_a = 1;
    read_en_b = 0;
    data_in_a = 16'hABCD;
    addr_a = 10;

    @(negedge clk);
    write_en_a = 0;
    read_en_b = 1;
    addr_b = 10;

    
    @(negedge clk); 
    if (data_out_b !== 16'hABCD) 
        $display("Error: addr_b=10, data_out_b mismatch. Expected: ABCD, Got: %h", data_out_b);
    else
        $display("Success: addr_b=10, data_out_b=%h", data_out_b);

    @(negedge clk);
    read_en_b = 0;
    write_en_a = 1;
    data_in_a = 16'h1234;
    addr_a = 11;

    @(negedge clk);
    write_en_a = 0;
    read_en_b = 1;
    addr_b = 11;

    @(negedge clk); 
    if (data_out_b !== 16'h1234) 
        $display("Error: addr_b=11, data_out_b mismatch. Expected: 1234, Got: %h", data_out_b);
    else
        $display("Success: addr_b=11, data_out_b=%h", data_out_b);

    #100;
    $finish;
end

endmodule
