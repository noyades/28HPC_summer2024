module tb_DSM_41b;

    // Parameters
    parameter CLK_PERIOD = 20;  // Just an example, adjust as needed
    
    // Signals
    reg clk;
    reg rst;
    reg [40:0] in;
    wire [2:0] out;

    
    reg [40:0] in_vector [0:249999];  // Array to store the sine values
    initial begin
       integer n;
       real A, val;

       A = 2**40 - 1;

       for (n = 0; n < 250000; n = n + 1) begin
          val = A * $sin(6.283185307179586 * n / 250000);  // 2*pi is approximated as 6.283185307179586
          in_vector[n] = val;  // Convert real to reg. Note: Rounding/truncation will occur
       end
    end


    // Instantiate the DSM
    busSplittingDsm uut (
        .clk(clk),
        .reset(rst),
        .in(in),
        .out(out)
    );

    // Clock Generation
    always begin
        # (CLK_PERIOD/2) clk = ~clk;
    end

    // Testbench Logic
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        in = 0;

        // Reset pulse
        # CLK_PERIOD reset = 0;
        # CLK_PERIOD reset = 1;

        for (n = 0; n < 250000; n = n + 1) begin
           in = in_vector[n];
           # CLK_PERIOD;
        end
        // Test sequence
        in = 41'd0;
        # CLK_PERIOD;
        in = 41'd1024;
        # CLK_PERIOD;
        in = 41'd2048;
        # CLK_PERIOD;
        in = 41'd3072;
        # CLK_PERIOD;
        in = 41'd4096;
        # CLK_PERIOD;
        in = 41'd5120;
        # CLK_PERIOD;

        // More test cases can be added

        // End simulation
        $finish;
    end

endmodule

