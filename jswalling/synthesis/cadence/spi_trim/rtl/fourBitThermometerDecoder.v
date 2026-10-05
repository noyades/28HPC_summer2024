`timescale 1ns/1ps 

module fourBitThermometerDecoder (clk, rst, enable, uIn, msb, uOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire msb;
   input wire [3:0] uIn;

   output reg [15:0] uOut;

   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         uOut <= 16'h0000;
      end else if (enable) begin
          if (!msb) begin
              uOut <= (1 << uIn) - 1; 
          end else begin
              uOut <= 16'hFFFF;
          end
      end
   end
endmodule
