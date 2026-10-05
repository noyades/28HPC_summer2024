module dsm1_5b_stage2(clk, rst, data_in, data_out);
    input wire clk;
    input wire rst;
    input wire [4:0] data_in;
    output reg data_out;

    reg [4:0] error;      // Error term
    reg [4:0] integrator; // Integrator register

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator <= 5'd0;
        end else begin
            // DSM Logic
            error = data_in - (integrator[4] ? 5'd1 : 5'd0); 
            integrator <= error + integrator;
            data_out <= integrator[4]; // 1-bit output, taken from the MSB
        end
    end

endmodule

