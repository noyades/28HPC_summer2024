`timescale 1ns / 1ps

module topPLLDigital(
    input wire modclk,         //low frequency clock for PLL modulation
    input wire clk,            // System clock
    input wire rst,            // Asynchronous reset, active low
    input wire sclk,           // SPI Clock
    input wire ss,             // Slave Select, active low
    input wire mosi,           // Master Out, Slave In
    output wire miso,          // Master In, Slave Out
    output wire [4:0] dsm_out
);


	// Define control modes
	localparam MODE_WRITE = 2'b01,
	           MODE_READ = 2'b10,
		   MODE_IDLE = 2'b11,
		   MODE_CONTINUOUS_OUTPUT = 2'b00; // Using '00' for continuous output mode

    // Internal signals
    //wire [3:0] control;
    wire [15:0] spi_data_out;
    wire spi_data_valid;
    wire [42:0] assembler_data_out;
    wire assembler_data_valid;
    wire [42:0] reg_data_out; // Placeholder for observation
    reg [1:0] read_address; // Placeholder for address, adjust as needed
    reg write_enable;
    reg read_enable; // Control signal for reading from register bank

    // Additional internal signals for SPI-FIFO-Register Bank interaction
    reg fifo_write_enable; //= spi_data_valid && (control[3:2] == MODE_WRITE); // Enable FIFO write on write mode
    wire [15:0] fifo_data_in = spi_data_out; //{control, spi_data_out}; // Assuming data needs extension to match FIFO width
    wire [15:0] fifo_data_out;
    wire fifo_empty;
    wire [1:0] counter_output;
    wire clk_2;
    reg enable_continuous_output;
    wire fifo_data_valid;
    reg spi_valid_prev;
    reg [1:0] control;
    wire [15:0] fifo_miso_out;
    wire fifo_miso_valid;
 
    clkDiv #( .DIV(2) ) ckDiv(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_2)
    );
	
    // Instantiate the two_bit_counter
    two_bit_counter counter_inst(
        .clk(modclk),
        .rst(rst),
        .enable(enable_continuous_output),
        .out(counter_output)
    );
    
    // Instantiate SPI Slave module
    spi_slave_pll spi_slave_inst(
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .ss(ss),
        .mosi(mosi),
        .data_cap(spi_valid_prev),
        .fifo_data(fifo_miso_out),
        .fifo_data_valid(fifo_miso_valid),
        .miso(miso),
        //.control(control),  // Assuming control logic within SPI Slave handles control bits
        .data(spi_data_out),
        .data_valid(spi_data_valid)
    );

    // FIFO module for reading data out

    fifo_miso #(
        .DEPTH(8),
        .ADDR_WIDTH(3)
    ) fifo_miso_inst(
        .clk(clk),
        .rst(rst),
        .write_enable(read_enable),
        .data_in(reg_data_out),
        .read_enable(read_enable),
        .data_out(fifo_miso_out),
        .fifo_full(),
        .fifo_empty(),
        .segment_valid(fifo_miso_valid)
    );        

    // FIFO module instantiation
    fifo_pll #(
	.WIDTH(16),
	.DEPTH(8),
	.ADDR_WIDTH(3)
    ) fifo_inst(
	.clk(clk),
	.rst(rst),
	.write_enable(fifo_write_enable),
	.data_in(fifo_data_in),
	.read_enable(spi_data_valid),
	.data_out(fifo_data_out),
	.fifo_full(), // Optionally used
	.fifo_empty(fifo_empty),
        .data_valid(fifo_data_valid)
    );

    reg fifo_data_valid_prev;
    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            fifo_data_valid_prev <= 0;
        end else if (write_enable == 1'b1) begin
            fifo_data_valid_prev <= fifo_data_valid;
        end else begin
            fifo_data_valid_prev <= 0;
        end            
    end

    Memory43b m_43b_inst(
        .clk(clk),
        .rst(rst),
        .write_enable(fifo_data_valid_prev),// && !fifo_data_valid_prev),
        .data_in(fifo_data_out[11:0]),
        .data_out(assembler_data_out),
        .data_ready(assembler_data_valid)
    );
    
    reg assembler_data_valid_prev;
    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            assembler_data_valid_prev <= 0;
        end else begin
            assembler_data_valid_prev <= assembler_data_valid;
        end
    end

    wire read_now;
    assign read_now = (read_enable || enable_continuous_output);
    // Instantiate Register Bank module
    register_bank_pll reg_bank_inst(
        .clk(clk),
        //.mod_clk(modclk),
        .rst(rst),
        .data_in(assembler_data_out),
        .load_data(assembler_data_valid_prev),// && !assembler_data_valid_prev),
        .select_reg(read_address),  // This needs to be driven based on your design's requirements
        .read_enable(enable_continuous_output),
        //.continuous_read_mode(enable_continuous_output),
        .data_out(reg_data_out),
        .read_data_valid(read_now)
    );

    reg [42:0] mash_transfer;
    always@(posedge modclk or negedge rst) begin
        if (!rst) begin
            mash_transfer <= 0;
        end else if (enable_continuous_output && read_now) begin
            mash_transfer <= reg_data_out;
        end            
    end

    // Instantiate MASH111
    mash111 mash111_inst(
        .clk(clk_2),
        .rst(rst),
        .clk_enable(enable_continuous_output && read_now), // Enable based on continuous mode and data validity
        .In1(reg_data_out), // Connect Register Bank output to MASH111 input
        .Out1(dsm_out)
        // .ce_out and .Out1 as needed
    );
	
    // Modification to include the two_bit_counter's output for continuous output mode
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            read_address <= 0; // Placeholder for address, adjust as needed
	    write_enable <= 0;
            read_enable <= 0;
	    write_enable <= 0;
            enable_continuous_output <= 0;
            spi_valid_prev <= 0;
            fifo_write_enable <= 0;
            control <= 0;
        end else begin
            control <= spi_data_out[15:14];
            read_address <= spi_data_out[13:12];
            if (control == MODE_WRITE) begin
                spi_valid_prev <= spi_data_valid;
                read_address <= fifo_data_out[13:12];
                if (spi_data_valid && !spi_valid_prev) begin
                    fifo_write_enable <= 1;
                end else begin
                    write_enable <= 1;
		    read_enable <= 0;
		    enable_continuous_output <= 0;
                    fifo_write_enable <= 0;
                end
	    end else if (control == MODE_READ) begin
                fifo_write_enable <= 0;
                read_address <= fifo_data_out[13:12];
	        write_enable <= 0;
	        read_enable <= 1;
	        enable_continuous_output <= 0;
	    end else if (control == MODE_IDLE) begin
	        read_enable <= 0;
                enable_continuous_output <= 0;
	        write_enable <= 0;
                read_enable <= 0;
                fifo_write_enable <= 0;
            end else if (control == MODE_CONTINUOUS_OUTPUT) begin
                fifo_write_enable <= 0;
                write_enable <= 0;
                //read_enable <= 1;
                enable_continuous_output <= 1;
                //fifo_data_valid_prev <= 1;
                // Connect counter_output to the register bank's read address in continuous output mode
                read_address <= counter_output; // Adjust register_bank_pll instantiation to use this dynamically
            end
        end	
    end
endmodule
