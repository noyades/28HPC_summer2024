`timescale 1ns/1ps

module clkDiv_32 (clk_in, clk_out);

    input wire clk_in;    // Input clock
    output reg clk_out;   // Output clock (clk_in divided by 32)

    reg [4:0] counter;

    always @(posedge clk_in) begin
        if (counter == 5'b11111) begin
            counter <= 5'b00000;
            clk_out <= ~clk_out;  // Toggle the output clock
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule


