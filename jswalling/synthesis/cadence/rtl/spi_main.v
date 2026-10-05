module spi_main(clk, rst, cs, sclk, mosi, miso, ss);

    input wire clk;
    input wire rst;
    input wire cs;
    input wire sclk;
    output wire mosi;
    input wire miso;
    output wire [1:0] sub_select;

    wire [31:0] sub_data_out[3:0];
    wire [31:0] sub_data_in[3:0];
    
    wire [1:0] active_sub;
    wire [31:0] selected_data_out;
    wire [31:0] selected_data_in;
    
    spi_sub sub0 (
        .clk(clk),
        .rst(rst),
        .cs(cs & (active_sub == 2'b00)),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .data_out(sub_data_out[0]),
        .data_in(sub_data_in[0])
    );
    
    spi_sub sub1 (
        .clk(clk),
        .rst(rst),
        .cs(cs & (active_sub == 2'b01)),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .data_out(sub_data_out[1]),
        .data_in(sub_data_in[1])
    );
    
    spi_sub sub2 (
        .clk(clk),
        .rst(rst),
        .cs(cs & (active_sub == 2'b10)),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .data_out(sub_data_out[2]),
        .data_in(sub_data_in[2])
    );
    
    spi_sub sub3 (
        .clk(clk),
        .rst(rst),
        .cs(cs & (active_sub == 2'b11)),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .data_out(sub_data_out[3]),
        .data_in(sub_data_in[3])
    );
    
    assign active_sub = sub_select;
    assign selected_data_out = sub_data_out[active_sub];
    assign selected_data_in = sub_data_in[active_sub];
    
endmodule

