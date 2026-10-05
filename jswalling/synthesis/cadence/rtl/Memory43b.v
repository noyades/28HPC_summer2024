`timescale 1ns / 1ps

module Memory43b(
    input wire clk,
    input wire rst,
    input wire write_enable,
    input wire [11:0] data_in,
    output reg [42:0] data_out,
    output reg data_ready,
    output reg read_enable // Signal to the FIFO when it's ready for more data
);

// Example memory storage (simplified)
reg [11:0] memory[3:0]; // Four slots for 12-bit data pieces
integer write_ptr;
integer read_ptr;
reg full, empty;

// Control logic to manage read_enable based on the memory state
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        write_ptr <= 0;
        read_ptr <= 0;
        full <= 0;
        empty <= 1;
        data_ready <= 0;
        read_enable <= 1; // Ready for data initially
    end else begin
        // Handle writing to memory
        if (write_enable && !full) begin
            memory[write_ptr] <= data_in;
            write_ptr <= (write_ptr + 1) % 4;
            empty <= 0;
            if (write_ptr == 3) full <= 1;
            read_enable <= (write_ptr != 3); // Disable if memory is about to become full
        end

        // Example logic for reading from memory and setting data_ready
        // This part is highly dependent on your specific requirements
        // e.g., if (some_condition_for_reading) { ... }
        // Simplified example for triggering a read
        if (full ) begin
            data_out <= {memory[0], memory[1], memory[2], memory[3]}; // Assuming you want to concatenate all 4 pieces
            data_ready <= 1;
            // Reset read_ptr, empty, etc., as needed
        end else begin 
            data_ready <= 0;
        end

    if (read_ptr == write_ptr) begin
        empty <= 1;
        full <= 0; // Assuming you clear full when reading
        read_enable <= 1; // Re-enable reading since we've made space
    end
    end
end

// Update empty and full flags
/*always @(posedge clk) begin
    if (read_ptr == write_ptr) begin
        empty <= 1;
        full <= 0; // Assuming you clear full when reading
        read_enable <= 1; // Re-enable reading since we've made space
    end
end*/

endmodule
