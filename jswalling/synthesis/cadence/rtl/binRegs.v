`timescale 1ns/1ps

module binRegs(clk,rst,enable,binIn,acIn,binOut,acOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [7:0] binIn;
   input wire [5:0] acIn;
   output reg [7:0] binOut;
   output reg [5:0] acOut;

   always @ (posedge clk or negedge rst) begin 
      if (!rst) begin
         binOut <= 8'b00000000;
         acOut <= 6'b000000;
      end else if (enable) begin
         binOut <= binIn;
         acOut <= acIn;
      end
   end

endmodule
