`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 12:06:26
// Design Name: 
// Module Name: alu
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


module alu # (
   parameter N = 4 // Bit width of inputs and outputs
)(
   input  logic [N-1:0] A,        // Input A
   input  logic [N-1:0] B,        // Input B
   input  logic [2:0]   opcode,   // Operation code
   output logic [N-1:0] Y,        // Output result
   output logic         overflow  // Overflow flag
);

   // Internal variables
   logic [N:0] temp_result; // Temporary result with extra bit for overflow handling

   // ALU operation logic
   always_comb begin
      // Default values
      Y = {N{1'b0}};
      overflow = 1'b0;

      case(opcode)
         3'b000: begin
            temp_result = A + B; // Addition
            Y = temp_result[N-1:0];
            overflow = temp_result[N];
         end
         3'b001: begin
            temp_result = A - B; // Subtraction
            Y = temp_result[N-1:0];
            overflow = temp_result[N];
         end
         3'b010: Y = A - 1;       // Decrement A
         3'b011: Y = A + 1;       // Increment A
         3'b100: Y = ~A;          // Bitwise NOT of A
         3'b101: Y = A & B;       // Bitwise AND
         3'b110: Y = A | B;       // Bitwise OR
         3'b111: Y = A ^ B;       // Bitwise XOR
         3'b1000: begin           // Multiplication (new operation)
            temp_result = A * B;
            Y = temp_result[N-1:0];
            overflow = temp_result[N];
         end
         3'b1001: begin           // Division (new operation)
            if (B != 0) begin
               Y = A / B;
            end else begin
               Y = {N{1'b1}};    // Division by zero result: all bits set
            end
         end
         default: Y = {N{1'b0}};  // Default: Zero output
      endcase
   end

endmodule