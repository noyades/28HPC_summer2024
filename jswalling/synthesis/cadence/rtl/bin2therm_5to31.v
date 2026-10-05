`timescale 1ns/1ps

module bin2therm_5to31 (clk, rst, enable, uIn, msb, uOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire msb;
   input wire [4:0] uIn;

   output reg [31:0] uOut;

   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         uOut <= 32'h00000000;
      end else if (enable) begin
          if (!msb) begin
              uOut <= (1 << uIn) -1; 
          end else begin
              uOut <= 32'hFFFFFFFF;
          end
      end
   end
      
endmodule
