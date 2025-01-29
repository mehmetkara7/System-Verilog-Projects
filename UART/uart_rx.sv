`timescale 1ns / 1ps

module uart_rx(
    input logic clk,
    input logic rst,
    input logic [15:0] clk_div,
    input logic rx,
    output logic [7:0] rx_dout,
    output logic rx_done
    );

    typedef enum logic [1:0] {IDLE, START, TRANSFER, STOP} t_state;
    t_state state;
    logic [15:0] cnt;
    logic [3:0] bit_cnt;
    logic [8:0] rx_buf;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            rx_done <= 1'b0;
            rx_dout <= 8'b0;
            cnt <= 0;
            bit_cnt <= 0;
            rx_buf <= 9'b0;
        end else begin
            case (state)
                IDLE: begin
                    rx_done <= 1'b0;
                    if (rx == 1'b0) begin  
                        cnt <= 0;
                        state <= START;
                    end
                end
                
                START: begin
                    cnt <= cnt + 1;
                    if (cnt == (clk_div >> 1)) begin 
                        cnt <= 0;
                        state <= TRANSFER;
                        bit_cnt <= 0;
                    end
                end
                
                TRANSFER: begin
                    cnt <= cnt + 1;
                    if (cnt == clk_div - 1) begin  
                        cnt <= 0;
                        rx_buf <= {rx, rx_buf[8:1]};  
                        bit_cnt <= bit_cnt + 1;
                        
                        if (bit_cnt == 8) begin
                            state <= STOP;
                        end
                    end
                end
                
                STOP: begin
                    cnt <= cnt + 1;
                    if (cnt == clk_div - 1) begin
                        cnt <= 0;
                        if (rx == 1'b1) begin  
                            rx_dout <= rx_buf[7:0];  
                            rx_done <= 1'b1;  
                        end
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
