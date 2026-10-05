`timescale 1ns/1ps

module topThermalDigital (clk, rst, sclk, ss, mosi, ROW, EN, c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15);

    input wire clk;
    input wire rst;
    input wire sclk;
    input wire ss;
    input wire mosi;

    integer i;
    wire [15:0] colOut;
    wire [15:0] rowOut;
    wire [7:0] binOut;

    // Signals for SPI to FIFO connection
    wire [31:0] spi_data_out;
    wire spi_data_valid;
    wire fifo_read_enable;
    wire fifo_empty;
    wire [31:0] fifo_data_out;
    wire [31:0] reg_data_out;
    wire reg_data_valid;
    wire fifo_rx_ack;

    output reg [15:0] ROW;
    output reg [7:0] EN;
    output reg [15:0] c15;
    output reg [15:0] c14;
    output reg [15:0] c13;
    output reg [15:0] c12;
    output reg [15:0] c11;
    output reg [15:0] c10;
    output reg [15:0] c9;
    output reg [15:0] c8;
    output reg [15:0] c7;
    output reg [15:0] c6;
    output reg [15:0] c5;
    output reg [15:0] c4;
    output reg [15:0] c3;
    output reg [15:0] c2;
    output reg [15:0] c1;
    output reg [15:0] c0;
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

    thermalDecoder thermalDec_inst(
        .clk(clk),
        .rst(rst),
        .enable(reg_data_valid),
        .binIn(reg_data_out),
        .colOut(colOut),
        .rowOut(rowOut),
        .binOut(binOut),
        .data_received(decoder_received)
    );

    always @ (posedge clk_32 or negedge rst) begin
      if (!rst) begin
         for(i=0; i<16; i=i+1) begin
            c15[i] <= 0;
            c14[i] <= 0;
            c13[i] <= 0;
            c12[i] <= 0;
            c11[i] <= 0;
            c10[i] <= 0;
            c9[i] <= 0;
            c8[i] <= 0;
            c7[i] <= 0;
            c6[i] <= 0;
            c5[i] <= 0;
            c4[i] <= 0;
            c3[i] <= 0;
            c2[i] <= 0;
            c1[i] <= 0;
            c0[i] <= 0;
         end
         ROW <= 16'h0000;
         EN <= 8'h00;
      end
      else begin
         for(i=0; i<16; i=i+1) begin
            c15[i] <= colOut[i];
            c14[i] <= colOut[i];
            c13[i] <= colOut[i];
            c12[i] <= colOut[i];
            c11[i] <= colOut[i];
            c10[i] <= colOut[i];
            c9[i] <= colOut[i];
            c8[i] <= colOut[i];
            c7[i] <= colOut[i];
            c6[i] <= colOut[i];
            c5[i] <= colOut[i];
            c4[i] <= colOut[i];
            c3[i] <= colOut[i];
            c2[i] <= colOut[i];
            c1[i] <= colOut[i];
            c0[i] <= colOut[i];
         end
         ROW <= rowOut;
         EN <= binOut;
      end
    end

endmodule

