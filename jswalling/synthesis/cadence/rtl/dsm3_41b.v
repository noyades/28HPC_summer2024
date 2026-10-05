module dsm3_41b(clk, rst, data_in, data_out);
    input wire clk;            // Clock
    input wire rst;          // Active high reset
    input wire [40:0] data_in;      // 41-bit input
    output reg [2:0] data_out;       // 3-bit output

    reg [40:0] error1, error2, error3;       // Error terms for each stage
    reg [40:0] integrator1, integrator2, integrator3; // Integrator registers for each stage

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator1 <= 41'd0;
            integrator2 <= 41'd0;
            integrator3 <= 41'd0;
        end else begin
            // First integrator and quantizer
            error1 = data_in - (integrator1[40] ? 41'd1 : 41'd0);
            integrator1 <= error1 + integrator1;
            
            // Second integrator and quantizer
            error2 = error1 - (integrator2[40] ? 41'd1 : 41'd0);
            integrator2 <= error2 + integrator2;

            // Third integrator and quantizer
            error3 = error2 - (integrator3[40] ? 41'd1 : 41'd0);
            integrator3 <= error3 + integrator3;

            // 3-bit output: MSBs from each integrator
            data_out <= {integrator3[40], integrator2[40], integrator1[40]};
        end
    end

endmodule

