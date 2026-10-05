module fifo_32b(
    input clk,                // Clock signal
    input rst_n,              // Asynchronous reset, active low
    input write_enable,       // Write enable signal
    input read_enable,        // Read enable signal
    input [31:0] data_in,     // 32-bit data input
    output reg [31:0] data_out, // 32-bit data output
    output reg fifo_full,     // FIFO full flag
    output reg fifo_empty,     // FIFO empty flag
    output reg data_rx_ack     // ack that data was rx
);

parameter FIFO_DEPTH = 8;
parameter ADDR_WIDTH = 3; // Log2(FIFO_DEPTH)

reg [31:0] fifo_mem[FIFO_DEPTH-1:0]; // FIFO memory
reg [ADDR_WIDTH-1:0] write_ptr, read_ptr; // Write and read pointers
reg [ADDR_WIDTH:0] count; // Count to keep track of the number of items in FIFO
reg [FIFO_DEPTH-1:0] valid_data; 

// Asynchronous reset and synchronous write/read operations
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset logic
        write_ptr <= 0;
        read_ptr <= 0;
        count <= 0;
        fifo_full <= 0;
        fifo_empty <= 1;
        data_rx_ack <= 0;
        valid_data <= 0;
    end else begin
        data_rx_ack <= 0;
        // Write operation
        if (write_enable && !fifo_full) begin
            fifo_mem[write_ptr] <= data_in;
            valid_data[write_ptr] <= 1;
            //write_ptr <= write_ptr + 1;
			write_ptr <= (write_ptr + 1) % FIFO_DEPTH;
            count <= count + 1;
            data_rx_ack <= 1; //ack data rx
        end

        // Read operation
        if (read_enable && !fifo_empty && valid_data[read_ptr]) begin
            data_out <= fifo_mem[read_ptr];
            valid_data[read_ptr] <= 0;
            //read_ptr <= read_ptr + 1;
			read_ptr <= (read_ptr + 1) % FIFO_DEPTH;
            count <= count - 1;
        end

        // Update FIFO full and empty flags
        fifo_full <= (count == FIFO_DEPTH) || ((write_ptr + 1) % FIFO_DEPTH == read_ptr);
        fifo_empty <= (count == 0);
    end
end

endmodule
