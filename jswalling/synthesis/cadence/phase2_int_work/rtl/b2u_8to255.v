`timescale 1ns/1ps 

module b2u_8to255 (clk, rst, enable, iIn, iMsb, iOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire iMsb;
   input wire [7:0] iIn;
   
   output reg [255:0] iOut;
   
   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         iOut <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
      end else if (enable) begin
          if (!iMsb) begin
              iOut <= (1 << iIn) - 1; 
          end else begin
              iOut <= 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
          end
      end
   end

endmodule