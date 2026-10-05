module busSplittingDsm(clk, rst, data_in, data_out);

    input wire clk;
    input wire rst;
    input wire [40:0] data_in;
    output wire [2:0] data_out;

    wire o1, o2; //Intermediate outputs
    reg [4:0] sum1;
    reg [25:0] sum2;

    dsm1_10b_stage1 dsm_1 (
       .clk(clk),
       .rst(rst),
       .data_in(data_in[9:0]),
       .data_out(o1) 
    );

    dsm1_5b_stage2 dsm_2 (
       .clk(clk),
       .rst(rst),
       .data_in(sum1),
       .data_out(o2) 
    );

    dsm1_26b_stage3 dsm_3 (
       .clk(clk),
       .rst(rst),
       .data_in(sum2),
       .data_out(data_out) 
    );

    always @(posedge clk or negedge rst) begin
       if (!rst) begin
          sum1 <= 5'b00000;
          sum2 <= 26'b00000000000000000000000000;
       end else begin
          sum1 <= data_in[14:10] + o1;
          sum2 <= data_in[40:15] + o2;
       end
    end

endmodule


