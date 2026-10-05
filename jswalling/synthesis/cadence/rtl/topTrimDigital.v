module topTrimDigital(clk, clk_32, rst, ss, spi_data, refControl, bgControl);

    input wire clk;
    input wire rst;
    input wire ss;
    input wire spi_data;

    output wire [8:0] bgControl;
    output wire [9:0] refControl;
    
    output wire clk_32;
    wire parReady;
    wire [31:0] parallel_data;

    clkDiv #( .DIV(32) ) ckDiv(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_32)
    );

    spi_s2p_16to32 s2p_regs(
        .sclk(clk), 
        .rst(rst), 
        .ss(ss), 
        .mosi(spi_data), 
        //.parallel_data(parallel_data),
        .latched_data(parallel_data),
        .oe(parReady) 
    );

    trimDecoder trimDec_inst(
        .clk(clk_32),
        .rst(rst),
        .enable(parReady),
        .binIn(parallel_data),
        .refTrimOut(refControl),
        .bgTrimOut(bgControl),
        .exTrimOut()
    );

endmodule

