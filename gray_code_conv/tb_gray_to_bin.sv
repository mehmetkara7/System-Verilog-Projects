`timescale 1ns / 1ps
module tb_gray_to_bin#(
    parameter WIDTH = 4
);
    logic [WIDTH-1:0] gray;
    logic [WIDTH-1:0] bin;

    gray_to_bin 
        dut (
        .bin(bin), 
        .gray(gray)
    );

    // Testbench variables
    logic [WIDTH-1:0] expected_bin;

    initial begin
        $display("Starting Gray to Binary Testbench");
        #20
        bin= 4'b0000;
        gray = 4'b0000;
        expected_bin = 4'b0000;
        #10;
        if (bin !== expected_bin) $error("Test case 1 failed: gray=%b, bin=%b", gray, bin);

        // Test case 2
        gray = 4'b0001;
        expected_bin = 4'b0001;
        #10;
        if (bin !== expected_bin) $error("Test case 2 failed: gray=%b, bin=%b", gray, bin);

         gray = 4'b1100;
        expected_bin = 4'b1000;
        #10;
        if (bin !== expected_bin) $error("Test case 2 failed: gray=%b, bin=%b", gray, bin);

        $display("All test cases passed!");
        $finish;
    end

endmodule
