`timescale 1ns / 1ps

module topPLLDigital_tb;

    reg modclk = 0;  // 100 Hz
    reg clk = 0;     // 40 MHz
    reg rst = 1;
    reg sclk = 0;    // 32 MHz
    reg ss = 1;
    reg mosi = 0;
    wire miso;
    wire [4:0] dsm_out;

    topPLLDigital uut (
        .modclk(modclk),
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .ss(ss),
        .mosi(mosi),
        .miso(miso),
        .dsm_out(dsm_out)
    );

    parameter DATA_WIDTH = 16;          // Width of SPI data packets
    parameter CLK_PERIOD_NS = 25;       // System clock period in ns for 40 MHz
    parameter SCLK_PERIOD_NS = 31.25;   // SPI clock period in ns for 32 MHz
    parameter MODCLK_PERIOD_NS = 5000000;

    // Clock generation
    always #(CLK_PERIOD_NS / 2) clk = ~clk;  // 40 MHz -> Period = 25ns, Half period = 12.5ns
    always #(MODCLK_PERIOD_NS / 2) modclk = ~modclk;  // 100 Hz -> Period = 10ms, Half period = 5ms

    // SPI Clock Generation (32 MHz)
    always begin
        wait(ss == 0);
        #(37 - SCLK_PERIOD_NS / 2) sclk = ~sclk;
        sclk = 1;
        #(SCLK_PERIOD_NS / 2);
        while (!ss) begin 
            sclk = ~sclk;
            #(SCLK_PERIOD_NS / 2);
        end 
        sclk = 0;
    end

    // SPI Master Behavior Simulation
    task send_spi_data;
        input [3:0] control_bits;
        input [11:0] data_bits;
        integer i;
        begin
            ss = 0;
            #(24);
            for (i = 3; i >= 0; i = i - 1) begin
                mosi = control_bits[i];
                #(5 + SCLK_PERIOD_NS / 2 - 1);
                @(posedge sclk);
            end
            for (i = 11; i >= 0; i = i - 1) begin
                mosi = data_bits[i];
                #(5 + SCLK_PERIOD_NS / 2 - 1);
                @(posedge sclk);
            end
            mosi = 0;
            #(16);
            ss = 1;
            #(CLK_PERIOD_NS*100);
        end
    endtask

    initial begin

        // Initialize Testbench
		$display("Starting...");
		$dumpfile("test_topPllDigital.vcd");
		$dumpvars(0,topPLLDigital_tb);
    	rst = 0; ss = 1; mosi = 0;
	    #(CLK_PERIOD_NS * 10); // Reset time
    	rst = 1;
    	#(CLK_PERIOD_NS * 2); // System stabilization time

    	// Begin SPI Transmission of First Two Packets
    	//ss = 0; // Select slave
        send_spi_data(4'b0100, 12'h03F); // First part of the word
    	// Delay after the first two packets
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        send_spi_data(4'b0100, 12'hFFF); // Second part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0100, 12'hFFF); // Third part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0100, 12'hFFF); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0101, 12'h040); // First part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        send_spi_data(4'b0101, 12'h000); // Second part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0101, 12'h000); // Third part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0101, 12'h000); // Last part of the word, padded with zeros
   	    #(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0110, 12'h03F); // First part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        send_spi_data(4'b0110, 12'hFFF); // Second part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0110, 12'hFFF); // Third part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0110, 12'hFFF); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        send_spi_data(4'b0111, 12'h040); // First part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        send_spi_data(4'b0111, 12'h000); // Second part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0111, 12'h000); // Third part of the word
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b0111, 12'h000); // Last part of the word, padded with zeros
        // Repeat the process for the other words as needed
		send_spi_data(4'b1100, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
        #1000000; // Wait for a while in idle mode
		send_spi_data(4'b0000, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		send_spi_data(4'b1000, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 3000); // Wait for a specified delay
		send_spi_data(4'b1000, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 3000); // Wait for a specified delay
		send_spi_data(4'b1000, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 3000); // Wait for a specified delay
		send_spi_data(4'b1000, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30000); // Wait for a specified delay
        #10; // Wait for a while in idle mode
		send_spi_data(4'b1100, 12'h000); // Last part of the word, padded with zeros
    	#(CLK_PERIOD_NS * 30); // Wait for a specified delay
		#100000; // Wait for a while in idle mode
        $finish; // End simulation
    end

endmodule
