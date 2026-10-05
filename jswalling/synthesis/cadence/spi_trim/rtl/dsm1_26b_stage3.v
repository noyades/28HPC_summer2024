module dsm1_26b_stage3(clk, rst, data_in, data_out);
    input wire clk;           // Clock
    input wire rst;         // Active high reset
    input wire [25:0] data_in;     // 26-bit input
    output reg [2:0] data_out;      // 3-bit output

    reg [25:0] error;       // Error term
    reg [25:0] integrator;  // Integrator register

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator <= 26'd0;
        end else begin
            // DSM Logic
            error = data_in - (integrator[25] ? 26'd1 : 26'd0); 
            integrator <= error + integrator;
            data_out <= {integrator[25], integrator[24], integrator[23]}; // 3-bit output
        end
    end

endmodule

