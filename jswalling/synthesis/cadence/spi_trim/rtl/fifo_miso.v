`timescale 1ns / 1ps

module fifo_miso #(
    parameter DEPTH = 8, // Number of 43-bit words the FIFO can store
    parameter ADDR_WIDTH = 3 // Log2(DEPTH)
)(
    input wire clk,
    input wire rst,
    input wire write_enable, // Signal to write 43-bit word into the FIFO
    input wire [42:0] data_in, // 43-bit data input
    input wire read_enable, // Signal to read next 16-bit segment from the FIFO
    output reg [15:0] data_out, // 16-bit data output
    output wire fifo_full, // FIFO is full
    output wire fifo_empty, // FIFO is empty
    output reg segment_valid // Indicates a valid 16-bit segment is ready
);

// FIFO storage for 43-bit words
reg [42:0] fifo[DEPTH-1:0];
reg [ADDR_WIDTH-1:0] write_ptr;
reg [ADDR_WIDTH-1:0] read_ptr;
reg [DEPTH-1:0] count; // Count of 43-bit words in FIFO
reg [1:0] segment_ptr; // Points to the current 16-bit segment within a 43-bit word

assign fifo_full = (count == DEPTH);
assign fifo_empty = (count == 0);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        write_ptr <= 0;
        read_ptr <= 0;
        count <= 0;
        segment_ptr <= 0;
        segment_valid <= 0;
    end else begin
        if (write_enable && !fifo_full) begin
            fifo[write_ptr] <= data_in;
            write_ptr <= (write_ptr + 1) % DEPTH;
            count <= count + 1;
        end
        
        if (read_enable && !fifo_empty && segment_ptr < 3) begin
            // Extract 16-bit segments from the 43-bit word
            case (segment_ptr)
                2'b00: data_out <= fifo[read_ptr][42:27];
                2'b01: data_out <= fifo[read_ptr][26:11];
                2'b10: data_out <= {3'b000, fifo[read_ptr][10:0]}; // Zero padding for last segment
            endcase
            segment_ptr <= segment_ptr + 1;
            segment_valid <= 1;
            
            if (segment_ptr == 2) begin
                // Move to next word after all segments have been read
                read_ptr <= (read_ptr + 1) % DEPTH;
                count <= count - 1;
                segment_ptr <= 0;
            end
        end else begin
            segment_valid <= 0; // Clear valid flag when not outputting data
        end
    end
end

endmodule
