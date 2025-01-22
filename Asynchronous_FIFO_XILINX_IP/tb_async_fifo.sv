`timescale 1ns / 1ps

module tb_async_fifo();
logic rst;
logic wr_clk=0;
logic rd_clk=0;
logic [7 : 0] din=0;
logic wr_en=0; 
logic rd_en=0;
logic [7 : 0] dout;
logic full;
logic empty;
logic ena;
logic[7:0] golden_fifo[$];

fifo_generator_0 your_instance_name (
    .rst(rst),        // input wire rst
    .wr_clk(wr_clk),  // input wire wr_clk
    .rd_clk(rd_clk),  // input wire rd_clk
    .din(din),        // input wire [7 : 0] din
    .wr_en(wr_en),    // input wire wr_en
    .rd_en(rd_en),    // input wire rd_en
    .dout(dout),      // output wire [7 : 0] dout
    .full(full),      // output wire full
    .empty(empty)    // output wire empty
  );

  //create clock
    always  #5 wr_clk = ~wr_clk; // 10ns period
    always  #12 rd_clk = ~rd_clk; 
    initial begin
        ena <= 0;
        rst <= 1'b1;
        #100;
        rst <= 1'b0;
        #100;
        ena <= 1'b1;
        #1000000;
        $stop;
    end 
    logic [1:0] wr_cnt=0;
    always_ff @( posedge wr_clk && ena==1 ) begin 
        wr_cnt<=wr_cnt+1;
        wr_en<=0;
        if(wr_cnt==0 && full == 0) begin
            wr_en<=1;
            din<=$random();
        end
        if(wr_en) begin golden_fifo.push_back(din);
        end
    end  
// 
    logic [7:0] rd_cnt=0;
    logic [7:0] golden_dout;
    always_ff @( posedge rd_clk && ena==1 ) begin 
        rd_cnt<=rd_cnt+1;
        rd_en<=0;
        if(rd_cnt==5 && empty == 0) begin
            rd_en<=1;
        end
        if(rd_en)begin
            golden_dout<=golden_fifo.pop_front();
    end 
end
    always begin
    
    @(negedge rd_en) ;
        #200ps;
       assert (golden_dout==dout) $display("true");
       else $display("Error: dout=%h, golden_dout=%h",dout,golden_dout);

        end
    
    
    
endmodule
