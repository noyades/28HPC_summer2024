module b2u_3b_static(
	IN, BGREN
	);
  
	input wire [2:0] IN;
  	output reg [6:0] BGREN;

	always@(*) begin
		if (IN==3'b000)
			BGREN <= 7'b0000000;
		else if (IN==3'b001)
			BGREN <= 7'b0000001;
		else if (IN==3'b010)
			BGREN <= 7'b0000011;
		else if (IN==3'b011)
			BGREN <= 7'b0000111;
		else if (IN==3'b100)
			BGREN <= 7'b0001111;
		else if (IN==3'b101)
			BGREN <= 7'b0011111;
		else if (IN==3'b110)
			BGREN <= 7'b0111111;
		else 
			BGREN <= 7'b1111111;
	end

endmodule

