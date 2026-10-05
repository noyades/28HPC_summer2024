module b2u_3b(
	clk, rst, in, out
	);
  
	input wire clk, rst;	
	input wire [2:0] in;
  	output reg [6:0] out;

	always@(posedge clk, negedge rst) begin
		if (rst == 0)
			out <= 7'b0000000;
		else if (in==3'b000)
			out <= 7'b0000000;
		else if (in==3'b001)
			out <= 7'b0000001;
		else if (in==3'b010)
			out <= 7'b0000011;
		else if (in==3'b011)
			out <= 7'b0000111;
		else if (in==3'b100)
			out <= 7'b0001111;
		else if (in==3'b101)
			out <= 7'b0011111;
		else if (in==3'b110)
			out <= 7'b0111111;
		else if (in==3'b111)
			out <= 7'b1111111;
	end

endmodule

