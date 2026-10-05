`timescale 1ns / 1ps


module spi_slave_pll(
    input wire clk,            // System clock
    input wire rst,            // Asynchronous reset, active low
    input wire sclk,           // SPI Clock
    input wire ss,             // Slave Select, active low
    input wire mosi,           // Master Out, Slave In
    input wire data_cap,       // Data Captured by FIFO
    input wire [15:0] fifo_data,
    input wire fifo_data_valid,
    output reg miso,           // Master In, Slave Out
    //output reg [3:0] control,  // Control bits extracted from SPI payload
    output reg [15:0] data,    // Data bits extracted from SPI payload
    output reg data_valid      // Indicates valid data has been received
);

reg [4:0] miso_bit_counter;         // Counts bits received
reg [4:0] mosi_bit_counter;         // Counts bits received
reg [15:0] miso_shift_reg;          // Shift register to capture SPI payload
reg [15:0] mosi_shift_reg;          // Shift register to capture SPI payload
reg load_miso_data;

always @(posedge sclk or negedge rst) begin
    if (!rst) begin
        mosi_bit_counter <= 0;
        mosi_shift_reg <= 0;
        data_valid <= 0;
        data <= 0;
        //load_miso_data <= 0;
    end else if (!ss) begin
        // SPI transfer active
        if (mosi_bit_counter < 17) begin
            mosi_shift_reg <= (mosi_shift_reg << 1) | mosi; // Shift in the MOSI data
            mosi_bit_counter <= mosi_bit_counter + 1;
        end
        if (mosi_bit_counter == 16) begin
            // Last bit has been received
            data_valid <= 1; // Signal that data is valid on the next clock cycle
            //control <= shift_reg[15:12]; // Extract control bits
            data <= mosi_shift_reg[15:0]; // Extract data bits
            mosi_bit_counter <= 0; // Reset for next transfer
        end else if (data_cap) begin
            // SPI transfer completed, and data has been processed
            data_valid <= 0; // Clear data_valid flag after data is processed
        end
    end else begin
        data_valid <= 0;
        mosi_bit_counter <= 0;
    end
end
 
// MISO data transmission logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        miso <= 0;
        miso_bit_counter <= 0;
        miso_shift_reg <= 0;
        load_miso_data <= 0;
    end else begin
        if (fifo_data_valid && load_miso_data == 0) begin
            // Load new data from FIFO when valid and not currently shifting out
            miso_shift_reg <= fifo_data;
            load_miso_data <= 1;
            miso_bit_counter <= 16; // Set bit counter for full 16-bit transmission
        end else if (load_miso_data && miso_bit_counter > 0) begin
            // Shift out data on MISO line
            miso <= miso_shift_reg[15];
            miso_shift_reg <= miso_shift_reg << 1; // Shift left for next bit
            miso_bit_counter <= miso_bit_counter - 1;
        end
 
        if (miso_bit_counter == 1) begin
            // Last bit has been shifted out, prepare for next load
            load_miso_data <= 0;
        end
    end
end

endmodule
