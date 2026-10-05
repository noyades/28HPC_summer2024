module dsm1_11b_stage1(clk, rst, data_in, data_out);

    input wire clk;
    input wire rst;
    input wire [10:0] data_in;
    output wire data_out;

    reg [11:0] integrator = 12'b0;
    reg quantizer;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator <= 12'b0;
            quantizer <= 1'b0;
        end
        else begin
            // Integrator update
            integrator <= integrator + {1'b0, data_in} - quantizer;

            // Quantizer decision
            quantizer <= (integrator[11] == 1'b1);
        end
    end

    assign data_out = quantizer;

endmodule

