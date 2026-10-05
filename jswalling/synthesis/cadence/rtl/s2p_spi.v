`timescale 1ns/1ps

module s2p_spi(sclk, rst, ss, mosi, parallel_output, oe);

    input wire sclk;          // Serial Clock
    input wire ss;           // Slave Select
    input wire mosi;          // Master Out Slave In (SPI Data)
    input wire rst;         // Active Low Reset
    output wire [31:0] parallel_output; // Parallel Output Data
    output reg oe;            // Output Enable Signal

    reg [31:0] parallel_data;
    reg [4:0] bit_counter;
    reg sclk_rising_edge;

    always @(posedge sclk or negedge rst) begin
        if (!rst) begin
            parallel_data <= 32'h00000000;
            bit_counter <= 5'b00000;
            sclk_rising_edge <= 1'b0;
        end else if (sclk_rising_edge) begin
            if (ss == 1'b0) begin
                if (bit_counter == 5'b00000)
                    parallel_data <= 32'h00000000;
                else
                    parallel_data <= {parallel_data[30:0], mosi};
                bit_counter <= bit_counter + 1'b1;
            end
        end else begin
            if (bit_counter == 5'b11111) begin
                bit_counter <= 5'b00000;
                oe <= 1'b1;  // Enable output when all data is input
                sclk_rising_edge <= 1'b1;
            end else
                oe <= 1'b0;
                sclk_rising_edge <= 1'b1;
        end
    end

    assign parallel_output = (sclk_rising_edge) ? parallel_data : 32'h00000000;

endmodule

