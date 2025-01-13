`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2025 21:57:19
// Design Name: 
// Module Name: bin_to_gray
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


module bin_to_gray
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] bin,
    output logic [WIDTH-1:0] gray
);

always_comb begin  
    gray[WIDTH-1] = bin[WIDTH-1];
    for (int i = 0; i <WIDTH-1; i++) begin
        gray[i] = bin[i] ^ bin[i+1];
    end
    
end


   
endmodule
