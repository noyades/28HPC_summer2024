`timescale 1ns/1ps

module clkDiv 
#(parameter integer DIV = 32) (clk_in, rst, clk_out);

    input wire clk_in;    // Input clock
    input wire rst;
    output reg clk_out;   // Output clock (clk_in divided by 32)

    reg [4:0] counter;

    localparam integer TC = DIV/2 - 1;
    integer count;

    wire terminate = (count ==TC); 

    always @(posedge clk_in) begin
        if (!rst | terminate)
            count <= 0;
        else
            count <= count + 1;

        if (!rst)
            clk_out <= 0;
        else if (terminate)
            clk_out <= ~clk_out;
    end


endmodule


