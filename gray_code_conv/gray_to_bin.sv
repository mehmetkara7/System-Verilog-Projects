`timescale 1ns / 1ps

module gray_to_bin
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] gray,
    output logic [WIDTH-1:0] bin
);

always_comb begin  
    bin[WIDTH-1] = gray[WIDTH-1];
    for (int i =0; i <WIDTH-1; i++) begin
        bin[i] = bin[i+1] ^ gray[i];
    end
end

endmodule




    

