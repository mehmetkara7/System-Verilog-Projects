`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 12:45:33
// Design Name: 
// Module Name: tb_FIFO
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


module tb_FIFO#(
    parameter FIFO_DEPTH = 8,
    parameter DATA_ADRR=9
    );

    logic                     clk=0;
    logic                     srst;
    logic [FIFO_DEPTH-1 : 0]  din;
    logic                     wr_en;
    logic                     rd_en;
    logic  [FIFO_DEPTH-1 : 0] dout;
    logic                     full;
    logic                     empty;
    logic [DATA_ADRR-1:0]     data_counter;


     FIFO#(
         .FIFO_DEPTH(FIFO_DEPTH),
         .DATA_ADRR(DATA_ADRR)
        )
        FIFO_Inst(
            .clk(clk),
            .srst(srst),
            .din(din),
            .wr_en(wr_en),
            .rd_en(rd_en),
            .dout(dout),
            .full(full),
            .empty(empty),
            .data_counter(data_counter)
            );

    always #5 clk <= ~clk;
    initial begin
        srst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        srst = 1'b0;
        #250_000;
        $stop;
    end
logic [7:0] fifo_golden[$];// push back pop front
logic write_act, read_act;
logic [1:0] write_cnt;
logic [3:0] read_cnt;
always @(posedge clk) begin

    if(srst) begin
        write_cnt = 1'b0;
        read_cnt = 3'b000;
    end
else begin
    write_cnt = write_cnt + 1;
    read_cnt = read_cnt + 1;
    if(write_cnt==0) write_act<=1'b1;
    if (read_cnt==0) read_act<=1'b1;
    
end

end
//write
always @(posedge clk) begin
    if(srst) begin
        wr_en<=1'b0;
        din<=8'b0;
    end
    else begin
        wr_en<=1'b0;
        if(!full && write_act) begin    
            din<=$random();
            wr_en<=1'b1;
        end
        if(wr_en) begin
            fifo_golden.push_back(din);
        end
    end
end

//read
    always @(posedge clk) begin
        logic rd_en_prev;
        logic [7:0] dout_golden;
        if(srst) begin
            rd_en<=1'b0;
        end
        else begin
            rd_en<=1'b0;
            if(!empty && read_act) begin
                rd_en<=1'b1;
            end
            rd_en_prev<=rd_en;
            if(rd_en_prev) begin
                dout_golden = fifo_golden.pop_front();
                assert (dout_golden==dout) $display("true: dout_golden=%h, dout=%h", dout_golden, dout);
                else $display("false: dout_golden=%h, dout=%h", dout_golden, dout);
               
            end
            
        end
    end


endmodule
