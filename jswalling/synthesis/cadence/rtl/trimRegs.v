`timescale 1ns/1ps

module trimRegs(clk,rst,enable,binIn,binOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [31:0] binIn;
   output reg [31:0] binOut;

   always @ (posedge clk or negedge rst) begin 
      if (!rst) begin
         binOut <= 8'b00000000;
      end else if (enable) begin
         binOut <= binIn;
      end
   end

endmodule
