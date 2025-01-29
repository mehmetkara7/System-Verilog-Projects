`timescale 1ns / 1ps

module tb_uart;
    
logic clk = 0;
logic rst;
logic [7:0] din;
logic ena;
logic [15:0] clk_div = 100000000/115200-1; 
logic tx;
logic done;
logic rx;
logic [7:0] rx_dout;
logic rx_done;

// UART TX instantiation
uart_tx uart_tx_Inst(
   .clk(clk),
   .rst(rst),
   .din(din),
   .ena(ena),
   .clk_div(clk_div),
   .tx(tx),
   .done(done)
);

// UART RX instantiation
uart_rx uart_rx_Inst(
    .clk(clk),
    .rst(rst),
    .clk_div(clk_div),
    .rx(tx),  // TX çıkışı RX girişine bağlandı
    .rx_dout(rx_dout),
    .rx_done(rx_done)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("uart_test.vcd"); 
    $dumpvars(0, tb_uart_tx);

   
    rst <= 1;
    ena <= 0;  
    din <= 0; 
    #50;
    rst <= 0;
    #50;

    ena <= 1;
    din <= 8'h41; 
    #10;
    ena <= 0;

    @(posedge done);
    $display("TX done Sent: %h", din);

    @(posedge rx_done);
    if (rx_dout == 8'h41) begin
        $display(" Received: %h", rx_dout);
    end else begin
        $display("RX ERROR %h", rx_dout);
    end

    #1000; 
    
    ena <= 1;
    din <= 8'h42; 
    #1000;
    ena <= 0;

    @(posedge done);
    $display("TX done Sent: %h", din);

    @(posedge rx_done);
    if (rx_dout == 8'h42) begin
        $display("Received: %h", rx_dout);
    end else begin
        $display("RX ERROR  %h", rx_dout);
    end

    #1000;
    $display("all done");
    $stop;
end

endmodule
