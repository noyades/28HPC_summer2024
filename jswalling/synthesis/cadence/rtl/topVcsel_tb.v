`timescale 1ns / 1ps

module topVcsel_tb;

    // Testbench Parameters
    parameter CLK_PERIOD_NS = 25;       // System clock period in ns for 40 MHz
    parameter SCLK_PERIOD_NS = 31.25;   // SPI clock period in ns for 32 MHz
    parameter DATA_WIDTH = 16;          // Width of SPI data packets

    // Testbench Signals
    reg clk = 0;
    reg rst = 1;
    reg sclk = 0;
    reg ss = 1;       // Initially not selected
    reg mosi = 0;
    // Outputs
    wire [31:0] ROW;
    wire [7:0] EN;
    wire [5:0] AC;
    wire [31:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;

    // Instantiate the Top-Level Module
    topVcselDigital uut (
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .ss(ss),
        .mosi(mosi),
        .ROW(ROW), 
        .EN(EN), 
        .AC(AC), 
        .c0(c0), .c1(c1), .c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6), .c7(c7), .c8(c8), .c9(c9), .c10(c10), .c11(c11), .c12(c12), .c13(c13), .c14(c14), .c15(c15), .c16(c16), .c17(c17), .c18(c18), .c19(c19), .c20(c20), .c21(c21), .c22(c22), .c23(c23), .c24(c24), .c25(c25), .c26(c26), .c27(c27), .c28(c28), .c29(c29), .c30(c30), .c31(c31)
    );

    // Clock Generation for System Clock (40 MHz)
    always #(CLK_PERIOD_NS / 2) clk = ~clk;

    // SPI Clock Generation (32 MHz)
    always begin
        wait (ss == 0);
        #(SCLK_PERIOD_NS / 2) sclk = 1;
        #(SCLK_PERIOD_NS / 2) sclk = 0;
        if (ss == 1) begin
            sclk = 0;
            @(negedge ss);
        end
    end

    // SPI Master Behavior Simulation
    task send_spi_data;
        input [DATA_WIDTH-1:0] data;
        integer i;
        begin
            for (i = DATA_WIDTH-1; i >= 0; i = i - 1) begin
                mosi = data[i];
                #(SCLK_PERIOD_NS); // Wait one SPI clock cycle
            end
        end
    endtask

    // Testbench Sequence
    initial begin
        // Initialize Testbench
    	rst = 0; ss = 1; mosi = 0;
	#(CLK_PERIOD_NS * 10); // Reset time
    	rst = 1;
    	#(CLK_PERIOD_NS * 2); // System stabilization time

    	// Begin SPI Transmission of First Two Packets
    	ss = 0; // Select slave
    	send_spi_data(16'h0461); // Send first 16-bit packet
    	send_spi_data(16'hAB07); // Send second 16-bit packet
    	ss = 1; // Deselect slave

    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay

    	// Send Two More Packets after Delay
    	ss = 0; // Select slave again
    	send_spi_data(16'h05A2); // Send third 16-bit packet
    	send_spi_data(16'hE19C); // Send fourth 16-bit packet
    	ss = 1; // Deselect slave after transmission

    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay

    	// Send Two More Packets after Delay
    	ss = 0; // Select slave again
    	send_spi_data(16'h07D0); // Send third 16-bit packet
    	send_spi_data(16'h001D); // Send fourth 16-bit packet
    	ss = 1; // Deselect slave after transmission

    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay

    	// Send Two More Packets after Delay
    	ss = 0; // Select slave again
    	send_spi_data(16'h0411); // Send third 16-bit packet
    	send_spi_data(16'h964A); // Send fourth 16-bit packet
    	ss = 1; // Deselect slave after transmission

    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay

    	// Send Two More Packets after Delay
    	ss = 0; // Select slave again
    	send_spi_data(16'h0221); // Send third 16-bit packet
    	send_spi_data(16'h3596); // Send fourth 16-bit packet
    	ss = 1; // Deselect slave after transmission

    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay

    	// Send Two More Packets after Delay
    	ss = 0; // Select slave again
    	send_spi_data(16'h0621); // Send third 16-bit packet
    	send_spi_data(16'h3596); // Send fourth 16-bit packet
    	ss = 1; // Deselect slave after transmission

    	// Wait and Observe
    	#(CLK_PERIOD_NS * 200);
    
    	$finish; // End simulation
    end

endmodule
