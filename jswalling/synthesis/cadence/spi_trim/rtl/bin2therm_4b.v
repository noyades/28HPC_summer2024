module bin2therm_4b (clk, rst, uIn, msb, uOut);

   input wire clk;
   input wire rst;
   input wire msb;
   input wire [3:0] uIn;

   output reg [15:0] uOut;

   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         uOut <= 16'h0000;
      end
      else if (!msb) begin
         case(uIn)
            4'b0000: uOut <= 16'h0000;
            4'b0001: uOut <= 16'h0001;
            4'b0010: uOut <= 16'h0003;
            4'b0011: uOut <= 16'h0007;
            4'b0100: uOut <= 16'h000F;
            4'b0101: uOut <= 16'h001F;
            4'b0110: uOut <= 16'h003F;
            4'b0111: uOut <= 16'h007F;
            4'b1000: uOut <= 16'h00FF;
            4'b1001: uOut <= 16'h01FF;
            4'b1010: uOut <= 16'h03FF;
            4'b1011: uOut <= 16'h07FF;
            4'b1100: uOut <= 16'h0FFF;
            4'b1101: uOut <= 16'h1FFF;
            4'b1110: uOut <= 16'h3FFF;
            4'b1111: uOut <= 16'h7FFF;
         endcase
      end 
      else if (msb) begin
         uOut <= 16'hFFFF;
      end
   end
endmodule
