module topPLL (clk, rst, ss, spi_data, colOut, rowOut, binOut, acOut);

    input wire clk;
    input wire rst;
    input wire ss;
    input wire spi_data;

    output wire [31:0] colOut;
    output wire [31:0] rowOut;
    output wire [7:0] binOut;
    output wire [5:0] acOut;
    
    wire clk_32;
    wire parReady;
    wire [31:0] parallel_data;

    clkDiv_32 ckDiv(
        .clk_in(clk),
        .clk_out(clk_32)
    );

    s2p_spi s2p_regs(
        .sclk(clk), 
        .rst(rst), 
        .ss(ss), 
        .mosi(spi_data), 
        .parallel_output(parallel_data),
        .oe(parReady) 
    );
