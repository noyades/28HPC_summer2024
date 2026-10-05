`timescale 1ns/1ps

module topVcselDigital (clk, rst, sclk, ss, mosi, ROW, EN, AC, c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31);


    input wire clk;
    input wire rst;
    input wire sclk;
    input wire ss;
    input wire mosi;

    integer i;
    wire [31:0] colOut;
    wire [31:0] rowOut;
    wire [7:0] binOut;
    wire [5:0] acOut;

    // Signals for SPI to FIFO connection
    wire [31:0] spi_data_out;
    wire spi_data_valid;
    wire fifo_read_enable;
    wire fifo_empty;
    wire [31:0] fifo_data_out;
    wire [31:0] reg_data_out;
    wire reg_data_valid;
    wire fifo_rx_ack;

    output reg [31:0] ROW;
    output reg [7:0] EN;
    output reg [5:0] AC;
    //output reg [31:0] [31:0] c;
    output reg [31:0] c31 ;
    output reg [31:0] c30;
    output reg [31:0] c29 ;
    output reg [31:0] c28 ;
    output reg [31:0] c27;
    output reg [31:0] c26;
    output reg [31:0] c25;
    output reg [31:0] c24;
    output reg [31:0] c23;
    output reg [31:0] c22;
    output reg [31:0] c21;
    output reg [31:0] c20;
    output reg [31:0] c19;
    output reg [31:0] c18;
    output reg [31:0] c17;
    output reg [31:0] c16;
    output reg [31:0] c15;
    output reg [31:0] c14;
    output reg [31:0] c13;
    output reg [31:0] c12;
    output reg [31:0] c11;
    output reg [31:0] c10;
    output reg [31:0] c9;
    output reg [31:0] c8;
    output reg [31:0] c7;
    output reg [31:0] c6;
    output reg [31:0] c5;
    output reg [31:0] c4;
    output reg [31:0] c3;
    output reg [31:0] c2;
    output reg [31:0] c1;
    output reg [31:0] c0;
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

    vcselDecoder vcselDec_inst(
        .clk(clk),
        .rst(rst),
        .enable(reg_data_valid),
        .binIn(reg_data_out),
        .colOut(colOut),
        .rowOut(rowOut),
        .binOut(binOut),
        .acOut(acOut),
        .data_received(decoder_received)
    );

    always @ (posedge clk_32 or negedge rst) begin
      if (!rst) begin
         for(i=0; i<32; i=i+1) begin
            c31[i] <= 0;
            c30[i] <= 0;
            c29[i] <= 0;
            c28[i] <= 0;
            c27[i] <= 0;
            c26[i] <= 0;
            c25[i] <= 0;
            c24[i] <= 0;
            c23[i] <= 0;
            c22[i] <= 0;
            c21[i] <= 0;
            c20[i] <= 0;
            c19[i] <= 0;
            c18[i] <= 0;
            c17[i] <= 0;
            c16[i] <= 0;
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
         ROW <= 32'h00000000;
         EN <= 8'h00;
         AC <= 6'b000000;
      end
      else begin
         for(i=0; i<32; i=i+1) begin
            c31[i] <= colOut[i];
            c30[i] <= colOut[i];
            c29[i] <= colOut[i];
            c28[i] <= colOut[i];
            c27[i] <= colOut[i];
            c26[i] <= colOut[i];
            c25[i] <= colOut[i];
            c24[i] <= colOut[i];
            c23[i] <= colOut[i];
            c22[i] <= colOut[i];
            c21[i] <= colOut[i];
            c20[i] <= colOut[i];
            c19[i] <= colOut[i];
            c18[i] <= colOut[i];
            c17[i] <= colOut[i];
            c16[i] <= colOut[i];
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
         AC <= acOut;
      end
    end

endmodule

