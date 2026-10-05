module spi_slave (
    input wire clk,          // System Clock
    input wire sclk,         // SPI Clock
    input wire ss,           // Chip Select, active low
    input wire mosi,         // Master Out Slave In (SPI Data Input)
    input wire rst,          // Asynchronous reset, active low
    input wire data_captured, // Receiver has the data
    output reg [31:0] latched_data, // 32-bit parallel data output
    output reg oe            // Data ready signal
);

reg [4:0] bit_count;                // To count the number of bits received
reg [15:0] temp_data;               // Temporary storage for the first 16 bits

// SPI data reception logic clocked by sclk
always @(posedge sclk or negedge rst) begin
    if (!rst) begin
        bit_count <= 0;
        temp_data <= 0;
        oe <= 0;                   // Reset oe here to ensure it starts in a known state
    end else if (!ss) begin
        if (bit_count < 16) begin
            temp_data <= (temp_data << 1) | mosi;
        end else if (bit_count < 32) begin
            if (bit_count == 16) latched_data[31:16] <= temp_data;
            latched_data[15:0] <= (latched_data[15:0] << 1) | mosi;
        end
        
        bit_count <= bit_count + 1;
        
        if (bit_count == 31 && latched_data[26] == 1) begin
            oe <= 1;                // Indicate that data is ready
            bit_count <= 0;         // Reset for the next packet
        end else if (data_captured) begin
            oe <= 0;
        end
    end else begin
        oe <= 0;
        bit_count <= 0;             // Reset on SS deselection
    end
end

// Logic to reset oe using system clock, should trigger on the positive edge
//always @(posedge clk or negedge rst) begin
//    if (!rst) begin
//        oe <= 0;
//    end else if (data_captured) begin
//        oe <= 0;                    // Reset oe when data is captured, ensuring it's ready for the next data
//    end
//end

endmodule
