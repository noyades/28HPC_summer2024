`timescale 1ns/1ps

module bin2therm_5b (clk, rst, enable, uIn, msb, uOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire msb;
   input wire [4:0] uIn;

   output reg [31:0] uOut;

   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         uOut <= 32'h00000000;
      end
      else if (!msb) begin
         case(uIn)
            5'b00000: uOut <= 32'h00000000;
            5'b00001: uOut <= 32'h00000001;
            5'b00010: uOut <= 32'h00000003;
            5'b00011: uOut <= 32'h00000007;
            5'b00100: uOut <= 32'h0000000F;
            5'b00101: uOut <= 32'h0000001F;
            5'b00110: uOut <= 32'h0000003F;
            5'b00111: uOut <= 32'h0000007F;
            5'b01000: uOut <= 32'h000000FF;
            5'b01001: uOut <= 32'h000001FF;
            5'b01010: uOut <= 32'h000003FF;
            5'b01011: uOut <= 32'h000007FF;
            5'b01100: uOut <= 32'h00000FFF;
            5'b01101: uOut <= 32'h00001FFF;
            5'b01110: uOut <= 32'h00003FFF;
            5'b01111: uOut <= 32'h00007FFF;
            5'b10000: uOut <= 32'h0000FFFF;
            5'b10001: uOut <= 32'h0001FFFF;
            5'b10010: uOut <= 32'h0003FFFF;
            5'b10011: uOut <= 32'h0007FFFF;
            5'b10100: uOut <= 32'h000FFFFF;
            5'b10101: uOut <= 32'h001FFFFF;
            5'b10110: uOut <= 32'h003FFFFF;
            5'b10111: uOut <= 32'h007FFFFF;
            5'b11000: uOut <= 32'h00FFFFFF;
            5'b11001: uOut <= 32'h01FFFFFF;
            5'b11010: uOut <= 32'h03FFFFFF;
            5'b11011: uOut <= 32'h07FFFFFF;
            5'b11100: uOut <= 32'h0FFFFFFF;
            5'b11101: uOut <= 32'h1FFFFFFF;
            5'b11110: uOut <= 32'h3FFFFFFF;
            5'b11111: uOut <= 32'h7FFFFFFF;
         endcase
      end 
      else if (msb) begin
         uOut <= 32'hFFFFFFFF;
      end
   end
endmodule
