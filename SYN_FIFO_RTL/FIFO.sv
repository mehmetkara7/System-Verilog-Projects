`timescale 1ns / 1ps
module FIFO#(
parameter FIFO_DEPTH = 8,
parameter DATA_ADRR=9
)(
    input  logic                     clk,
    input  logic                     srst,
    input  logic [FIFO_DEPTH-1 : 0]  din,
    input  logic                     wr_en,
    input  logic                     rd_en,
    output logic  [FIFO_DEPTH-1 : 0] dout,
    output logic                     full,
    output logic                     empty,
    output logic [DATA_ADRR-1:0]     data_counter
    );

    logic [FIFO_DEPTH-1 : 0] fifo_mem[0:2**DATA_ADRR-1];
    logic [DATA_ADRR-1:0] rd_ptr, wr_ptr;

    always_ff @( posedge clk ) begin 
        if (srst) begin
            rd_ptr <= 0;
            wr_ptr <= 0;
            data_counter<=0;
        end
        else begin
            case({wr_en,rd_en})
                2'b00:;
                2'b01: begin
                    dout<=fifo_mem[rd_ptr];
                    rd_ptr <= rd_ptr + 1;
                    data_counter<=data_counter-1;
                end
                2'b10: begin
                    fifo_mem[wr_ptr] <= din;
                    wr_ptr <= wr_ptr + 1;
                    data_counter<=data_counter+1;
                end
                
                2'b11: begin 
                    dout<=fifo_mem[rd_ptr];
                    fifo_mem[wr_ptr] <= din;
                    rd_ptr <= rd_ptr + 1;
                    wr_ptr <= wr_ptr + 1;
                end   
            endcase
    end
end

    assign empty = (data_counter==0);
    assign full = (data_counter==2**DATA_ADRR);

endmodule
