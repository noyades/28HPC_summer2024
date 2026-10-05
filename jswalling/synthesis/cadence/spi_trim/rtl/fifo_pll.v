`timescale 1ns / 1ps

module fifo_pll #(
    parameter WIDTH = 16, // Data width
    parameter DEPTH = 8,  // Number of entries in the FIFO
    parameter ADDR_WIDTH = 3 // Log2(DEPTH)
)(
    input wire clk,
    input wire rst,
    input wire write_enable, // Signal to write data into the FIFO
    input wire [WIDTH-1:0] data_in, // Data input
    input wire read_enable, // Signal to read data from the FIFO
    output reg [WIDTH-1:0] data_out, // Data output
    output wire fifo_full, // FIFO is full
    output wire fifo_empty, // FIFO is empty
    output reg data_valid
);

reg [WIDTH-1:0] fifo[DEPTH-1:0]; // FIFO storage
reg [ADDR_WIDTH-1:0] write_ptr; // Write pointer
reg [ADDR_WIDTH-1:0] read_ptr; // Read pointer
reg [DEPTH-1:0] count; // Count of items in FIFO

assign fifo_full = (count == DEPTH); // FIFO is full when count equals DEPTH
assign fifo_empty = (count == 0); // FIFO is empty when count is zero

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        write_ptr <= 0;
        read_ptr <= 0;
        count <= 0;
        data_valid <= 0;
    end else begin
        if (write_enable && !fifo_full) begin
            fifo[write_ptr] <= data_in;
            write_ptr <= (write_ptr + 1) % DEPTH;
            count <= count + 1;
            data_valid <= 1;
        end
        if (read_enable && !fifo_empty) begin
            data_out <= fifo[read_ptr];
            read_ptr <= (read_ptr + 1) % DEPTH;
            count <= count - 1;
            data_valid <= 0;
        end else if (!read_enable) begin
            data_valid <= !fifo_empty;
        end
    end
end

endmodule
