`timescale 1ns / 1ps

module tb_syn_fifo();
 logic clk=0;
 logic srst=0;
 logic [7 : 0] din=0;
 logic wr_en=0;
 logic rd_en=0;
 logic  [7 : 0] dout=0;
 logic  full=0;
 logic  empty=0;

syn_fifo syn_fifo_Inst(.*); // instance of syn_fifo module
parameter DATA_WIDTH = 8;
parameter FIFO_DEPTH = 2**9;
always #5 clk = ~clk;
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
