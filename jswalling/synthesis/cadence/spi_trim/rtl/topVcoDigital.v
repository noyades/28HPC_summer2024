`timescale 1ns/1ps

module topVcoDigital (clk, rst, sclk, ss, mosi, vcoTrim);


    input wire clk;
    input wire rst;
    input wire sclk;
    input wire ss;
    input wire mosi;

    wire [15:0] trimOut;
    wire [15:0] exOut;

    // Signals for SPI to FIFO connection
    wire [31:0] spi_data_out;
    wire spi_data_valid;
    wire fifo_read_enable;
    wire fifo_empty;
    wire [31:0] fifo_data_out;
    wire [31:0] reg_data_out;
    wire reg_data_valid;
    wire fifo_rx_ack;

    output reg [15:0] vcoTrim;
    wire clk_32;
    wire fifo_full;
    wire decoder_received;
    reg spi_valid;
    reg spi_valid_prev;

    clkDiv #( .DIV(32) ) ckDiv(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_32)
    );

    // Control signal for FIFO read operation (example implementation)
    // In a real application, you would implement specific logic to determine when to read from the FIFO.
    //assign fifo_read_enable = !fifo_empty && !spi_data_valid; // Example: read when FIFO is not empty and SPI not currently outputting

    // SPI Slave Module
    spi_slave spi_slave_inst(
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .ss(ss),
        .mosi(mosi),
        .latched_data(spi_data_out),
        .oe(spi_data_valid),
        .data_captured(spi_valid_prev) // Use SPI data valid signal directly to trigger FIFO writes, with handshake if needed
    );

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            spi_valid <= 0;
            spi_valid_prev <= 0;
        end else begin
            spi_valid_prev <= spi_data_valid;
            if (spi_data_valid && !spi_valid_prev) begin
                spi_valid <= 1;
            end else begin
                spi_valid <= 0;
            end
        end
    end

    // FIFO Module
    fifo_32b fifo_inst(
        .clk(clk),
        .rst_n(rst),
        .data_in(spi_data_out),
        .write_enable(spi_valid),
        .read_enable(fifo_read_enable),
        .data_out(fifo_data_out),
        .fifo_full(fifo_full), // Optionally used in your system's logic
        .fifo_empty(fifo_empty),
        .data_rx_ack(fifo_rx_ack)
    );

    // Data Register Module
    fifoDataRegister data_register_inst(
        .clk(clk),
        .rst_n(rst),
        .fifo_empty(fifo_empty),
        .data_consumed(decoder_received),
        .fifo_data(fifo_data_out),
        .data_reg(reg_data_out),
        .data_valid(reg_data_valid),
        .ready_for_data(fifo_read_enable)
    );

    vcoDecoder vcoDec_inst(
        .clk(clk),
        .rst(rst),
        .enable(reg_data_valid),
        .binIn(reg_data_out),
        .vcoTrimOut(trimOut),
        .exTrimOut(exOut),
        .data_received(decoder_received)
    );

    always @ (posedge clk_32 or negedge rst) begin
      if (!rst) begin
         vcoTrim <= 0;
      end
      else begin
         vcoTrim <= trimOut;
      end
    end

endmodule

