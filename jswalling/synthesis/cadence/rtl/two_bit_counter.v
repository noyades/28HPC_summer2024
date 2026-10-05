module two_bit_counter(
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [1:0] out
);

always @(posedge clk or negedge rst) begin
    if (!rst) out <= 2'b00;
    else if (enable) out <= out + 1'b1;
end

endmodule
