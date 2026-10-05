module b2u_split_3b3b3b(
	clk, rst, in, lsb, nsb, msb
	);

	input wire clk, rst;
	input wire [9:0] in;
        wire [6:0] l;
        wire [6:0] n;
        wire [6:0] m;
	output reg [7:0] lsb;
	output reg [6:0] nsb;
	output reg [6:0] msb;

	b2u_3b lsb_decoder(
		.clk(clk),
		.rst(rst),
		.in(in[2:0]),
		.out(l)
	);

	b2u_3b nsb_decoder(
		.clk(clk),
		.rst(rst),
		.in(in[5:3]),
		.out(n)
	);

	b2u_3b msb_decoder(
		.clk(clk),
		.rst(rst),
		.in(in[8:6]),
		.out(m)
	);

        always @ (posedge clk or negedge rst) begin
           if (!rst) begin
              msb <= 0;
              nsb <= 0;
              lsb <= 0;
           end else begin
              msb <= m;
              nsb <= n;
              lsb[7:1] <= l;
              lsb[0] <= in[9];
           end
        end

endmodule
