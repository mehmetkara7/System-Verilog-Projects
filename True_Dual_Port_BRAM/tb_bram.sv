`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2025 17:58:48
// Design Name: 
// Module Name: tb_bram
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


module tb_bram #(
    parameter WIDTH =16 ,//genişlik
    parameter DEPTH = 1024 //derinlik
    );
    logic clk=0;
    //PORT A
    logic  read_en_a=0;
    logic  write_en_a=0;
    logic  [WIDTH-1:0] data_in_a=0;
    logic  [$clog2(DEPTH)-1:0] addr_a=0;
    logic  [WIDTH-1:0] data_out_a=0;
        //Port B
    logic  read_en_b=0;
    logic  write_en_b=0;
    logic  [WIDTH-1:0] data_in_b=0;
    logic  [$clog2(DEPTH)-1:0] addr_b=0;
    logic  [WIDTH-1:0] data_out_b=0;


    bram#(
        .WIDTH(WIDTH), //genişlik
        .DEPTH(DEPTH)  //derinlik
    )
    bram_Inst(   
        .clk(clk),
        //Port A
        .read_en_a(read_en_a),
        .write_en_a(write_en_a),
        .data_in_a(data_in_a),
        .addr_a(addr_a),
        .data_out_a(data_out_a),
        //Port B
          .read_en_b(read_en_b),
          .write_en_b(write_en_b),
          .data_in_b(data_in_b),
          .addr_b(addr_b),
          .data_out_b(data_out_b)
     );

     always #5 clk=~clk;

    initial begin
        @(negedge clk);
        write_en_a<=1;
        write_en_b<=1;
        data_in_a<=16'hABCD;
        data_in_b<=16'h1234;
        addr_a<=10;
        addr_b<=20;
        @(negedge clk);
        write_en_a<=0;
        write_en_b<=0;
        @(negedge clk);
        read_en_a<=1;
        read_en_b<=1;
        @(negedge clk);
        read_en_a<=0;
        read_en_b<=0;
        $finish;
        
    end


endmodule
