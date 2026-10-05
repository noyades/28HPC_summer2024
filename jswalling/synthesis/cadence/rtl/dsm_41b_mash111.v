module dsm_41b_mash111 (clk, rst, data_in, data_out);

    input wire clk;           // Clock
    input wire rst;         // Active high reset
    input wire [40:0] data_in;     // 41-bit input
    output reg [2:0] data_out;      // 3-bit output

    reg [40:0] err0, err1, err2; // Error registers
    reg [40:0] intg0, intg1, intg2; // Integrator registers

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            intg0 <= 41'd0;
            intg1 <= 41'd0;
            intg2 <= 41'd0;
        end else begin
            // First DSM
            err0 <= data_in + intg0;
            intg0 <= err0 - (err0[40] ? 41'd1 : 41'd0);

            // Second DSM
            err1 <= err0 + intg1;
            intg1 <= err1 - (err1[40] ? 41'd1 : 41'd0);

            // Third DSM
            err2 <= err1 + intg2;
            intg2 <= err2 - (err2[40] ? 41'd1 : 41'd0);

            data_out <= {err2[40], err1[40], err0[40]}; // 3-bit output
        end
    end

endmodule

