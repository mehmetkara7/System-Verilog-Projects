`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2022 11:36:41 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu;
   parameter N = 4;

   logic [N-1:0] A;
   logic [N-1:0] B;
   logic [2:0]   opcode;
   logic [N-1:0] Y;
   logic         overflow;

   alu #(
      .N(N)
   ) alu_inst (
      .A(A),
      .B(B),
      .opcode(opcode),
      .Y(Y),
      .overflow(overflow)
   );

   initial begin
      $display("Time\tA\tB\tOpcode\tY\tOverflow");

      A = 0;
      B = 0;
      opcode = 0;

      #10;

      A = 4; B = 2; opcode = 3'b000; #5; 
      $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, opcode, Y, overflow);

      A = 4; B = 2; opcode = 3'b001; #5; 
      $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, opcode, Y, overflow);

      A = 4; B = 0; opcode = 3'b1001; #5; 
      $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, opcode, Y, overflow);

      A = 4; B = 3; opcode = 3'b1000; #5; 
      $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, opcode, Y, overflow);

      A = 4; opcode = 3'b100; #5; 
      $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, opcode, Y, overflow);
      #10;
      $stop;
   end

endmodule