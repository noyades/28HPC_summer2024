`timescale 1ns/1ps

module topVcselDigital_tb;

    // Inputs
    reg clk;
    reg rst;
    reg sclk;
    reg ss;
    reg mosi;

    // Outputs
    wire [31:0] ROW;
    wire [7:0] EN;
    wire [5:0] AC;
    wire [31:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;

    // Instantiate the Unit Under Test (UUT)
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

    reg[0:0] test_vector[1695:0];
    integer n;
    integer m;

    // Clock Generation
    always 
      begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
      end

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        ss = 1;
        mosi = 0;

        // Wait 100 ns for global reset to finish
        #100;
        rst = 0; // Reset the system
        #100;
        rst = 1;

        // Initialize SPI transmission
        $display("Starting...");
        $readmemb("/home/darpaH6/projects/h6_65nm/jswalling/synopsys/h6digital/rtl/Simulation_Data/vcselTestVector_seed\=1.input", test_vector);
        for (m = 0; m < 53; m = m+1) begin
           ss = 0;// Asssert Slave Select  
           for (n = m*32+0; n < m*32+32; n = n+1) begin
              mosi = test_vector[n]; // Set SPI data bit
              //#10; CLK = 1; #10; CLK = 0;
              $display("SPI Data = %b, RST = %b", mosi, rst);
              $display("CLK = %b", clk);
              #15.625; sclk = 1; #15.625; sclk = 0; // Toggle clock to simulate SPI clock
           end
           //#10; CLK = 1; #10; CLK = 0;
           ss = 1;
           mosi = 0;
           #500;
           $display("EN = %b", EN);
        end

        $display("...Done");
        $finish;
    end

endmodule
