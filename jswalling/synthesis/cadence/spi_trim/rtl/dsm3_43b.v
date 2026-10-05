module dsm3_43b (clk, rst, in, out);

    input clk;
    input rst;
    input signed [42:0] in; // 43-bit input
    output reg out;

    reg signed [42:0] integrator1, integrator2, integrator3;
    reg signed [42:0] feedback;
    reg signed [42:0] quantizer_input;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            integrator1 <= 0;
            integrator2 <= 0;
            integrator3 <= 0;
            feedback <= 0;
            out <= 0;
        end else begin
            integrator1 <= in - feedback + integrator1;
            integrator2 <= integrator1 + integrator2;
            integrator3 <= integrator2 + integrator3;
            quantizer_input <= integrator3;
            if (quantizer_input >= 0) begin
                out <= 1;
                feedback <= 43'h1FFFFFFFFFFF; // Maximum positive value for 43-bit signed number
            end else begin
                out <= 0;
                feedback <= -43'h200000000000; // Maximum negative value for 43-bit signed number
            end
        end
    end
endmodule
