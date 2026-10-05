module dsm1_10b_stage1(clk, rst, data_in, data_out);
    input wire clk;
    input wire rst;
    input wire [9:0] data_in;
    output reg data_out;

    reg [9:0] error;      // Error term
    reg [9:0] integrator; // Integrator register

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator <= 10'd0;
        end else begin
            // DSM Logic
            error = data_in - (integrator[9] ? 10'd1 : 10'd0); 
            integrator <= error + integrator;
            data_out <= integrator[9]; // 1-bit output, taken from the MSB
        end
    end

endmodule

