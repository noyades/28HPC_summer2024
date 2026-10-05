module clkDiv_8 (
    input wire clk_in,    // Input clock
    output reg clk_out   // Output clock (clk_in divided by 8)
);

    reg [2:0] counter;

    always @(posedge clk_in) begin
        if (counter == 3'b111) begin
            counter <= 3'b000;
            clk_out <= ~clk_out;  // Toggle the output clock
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule
