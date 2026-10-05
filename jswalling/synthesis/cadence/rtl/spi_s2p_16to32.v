module spi_s2p_16to32 (
    input wire sclk,        // SPI Clock
    input wire ss,        // Chip Select, active low
    input wire mosi,        // Master Out Slave In (SPI Data Input)
    input wire rst,     // Asynchronous reset, active low
    //output reg [31:0] parallel_data, // 32-bit parallel data output
    output reg [31:0] latched_data, // 32-bit parallel data output
    output reg oe            // Data ready signal
);

reg [4:0] bit_count; // To count the number of bits received (0-15 for first half, 16-31 for second half)
reg [15:0] temp_data; // Temporary storage for the first 16 bits

// SPI state machine with asynchronous reset
always @(posedge sclk or negedge rst) begin
    if (!rst) begin
        // Asynchronous reset is active, initialize all registers
        bit_count <= 0;
        temp_data <= 0;
        //parallel_data <= 0;
        latched_data <= 0;
        oe <= 0;
    end else if (ss) begin
        // When chip select is not active, and reset is not active, reset the bit counter and oe signal
        bit_count <= 0;
        oe <= 0;
    end else begin
        // SPI communication active
        if (bit_count < 16) begin
            // First 16 bits are being received
            temp_data <= (temp_data << 1) | mosi;
        //end else if (bit_count >= 16 && bit_count < 32) begin
            // Next 16 bits are being received, shift into the higher part of parallel_data
        //    parallel_data[30:0] <= (parallel_data[30:0] << 1) | mosi; // Correct shift operation for parallel_data
        end else if (bit_count < 32) begin
            if (bit_count == 16) begin
                latched_data[31:16] <= temp_data;
            end
            latched_data[15:0] <= (latched_data[15:0] << 1) | mosi;
        end
        
        bit_count <= bit_count + 1;
        
        // Check if all 32 bits have been received
        if (bit_count == 31) begin
            // After the full 32 bits are received, combine the two 16-bit segments
            //parallel_data <= {temp_data, parallel_data[15:0]};
            oe <= 1; // Indicate that data is ready
            bit_count <= 0; // Reset the bit counter for the next word
        end else begin
            oe <= 0;
        end
    end
end

endmodule
