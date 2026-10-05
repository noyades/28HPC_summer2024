module spi_slave_v2 (
    input wire clk,         // System Clock
    input wire sclk,        // SPI Clock
    input wire ss,        // Chip Select, active low
    input wire mosi,        // Master Out Slave In (SPI Data Input)
    input wire rst,     // Asynchronous reset, active low
    input wire data_captured, // Receiver has the data
    output reg [31:0] latched_data, // 32-bit parallel data output
    output reg oe            // Data ready signal
);

reg [4:0] bit_count; // To count the number of bits received (0-15 for first half, 16-31 for second half)
reg [15:0] temp_data; // Temporary storage for the first 16 bits
reg data_ready_to_latch;

// SPI data reception logic clocked by sclk
always @(posedge sclk or negedge rst) begin
    if (!rst) begin
        bit_count <= 0;
        temp_data <= 0;
        data_ready_to_latch <= 0;
    end else if (!ss) begin
        if (bit_count < 16) begin
            temp_data <= (temp_data << 1) | mosi;
        end else if (bit_count < 32) begin
            if (bit_count == 16) latched_data[31:16] <= temp_data;
            latched_data[15:0] <= (latched_data[15:0] << 1) | mosi;
        end
        
        bit_count <= bit_count + 1;
        
        if (bit_count == 31 && latched_data[26] == 1) begin
            oe <= 1; // Indicate that data is ready
            data_ready_to_latch <= 1;
            bit_count <= 0; // Reset for the next packet
        end
    end
end

// Logic to reset oe using system clock, independent of sclk state
always @(negedge clk or negedge rst) begin
    if (!rst) begin
        oe <= 0;
    //end else if (bit_count == 31 && latched_data[26] == 1) begin
    //    oe <= 1;
    end else if (data_captured) begin
        oe <= 0; // Reset oe when data is captured, ensuring it's ready for the next data
    end
end

endmodule
// SPI state machine with asynchronous reset
/*always @(posedge sclk or negedge rst) begin
    if (!rst) begin
        // Asynchronous reset is active, initialize all registers
        bit_count <= 0;
        temp_data <= 0;
        latched_data <= 0;
        oe <= 0;
        data_ready_to_latch <= 0;
    end else if (ss) begin
        // When chip select is not active, and reset is not active, reset the bit counter and oe signal
        bit_count <= 0;
        oe <= 0;
        // Allow new data to be latched if it was previously ready and captured
        if (data_ready_to_latch && data_captured) begin
            data_ready_to_latch <= 0;
        end
    end else begin
        // SPI communication active
        if (bit_count < 16) begin
            // First 16 bits are being received
            temp_data <= (temp_data << 1) | mosi;
        end else if (bit_count < 32) begin
            // Second 16 bits are being received
            if (bit_count == 16) begin
                latched_data[31:16] <= temp_data;
            end
            latched_data[15:0] <= (latched_data[15:0] << 1) | mosi;
        end
        
        bit_count <= bit_count + 1;
        
        // Check if all 32 bits have been received
        if (bit_count == 31 && (!data_ready_to_latch || data_captured)) begin
            oe <= 1; // Indicate that data is ready
            data_ready_to_latch <= 1; 
            bit_count <= 0; // Reset the bit counter for the next word
        end else if (data_captured) begin
            oe <= 0;
        end
    end
end

endmodule*/
