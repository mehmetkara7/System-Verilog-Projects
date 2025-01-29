`timescale 1ns / 1ps

module uart_tx(
    input logic clk,
    input logic rst,
    input logic [7:0] din,
    input logic ena,
    input logic [15:0] clk_div,
    output logic tx,
    output logic done
    );

    typedef enum logic [0:0] {IDLE, TRANSFER} t_state;
    t_state state;
    logic [15:0] cnt;
    logic [3:0] bit_cnt;
    logic [9:0] tx_buf;

    always_ff @(posedge clk) begin 
        if (rst) begin
            state <= IDLE;
            done <= 1'b0;
            tx <= 1'b1;
            cnt <= 0;
            bit_cnt <= 0;
            tx_buf <= 10'b1111111111;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    tx <= 1'b1;
                    if (ena) begin
                        state <= TRANSFER;
                        cnt <= 0;
                        bit_cnt <= 0;
                        tx_buf <= {1'b1, din, 1'b0}; // Stop bit (1), Data, Start bit (0)
                    end
                end
                TRANSFER: begin
                    tx <= tx_buf[0]; 
                    if (cnt == clk_div) begin 
                        cnt <= 0;
                        bit_cnt <= bit_cnt + 1;
                        tx_buf <= {1'b1, tx_buf[9:1]}; 
                        if (bit_cnt == 9) begin
                            done <= 1'b1; // Transfer bitti
                            state <= IDLE;
                        end else begin
                            done <= 1'b0;
                        end
                    end else begin
                        cnt <= cnt + 1;
                    end
                end
            endcase
        end
    end
endmodule
