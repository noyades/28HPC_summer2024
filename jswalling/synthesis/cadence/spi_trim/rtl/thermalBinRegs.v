module thermalBinRegs(clk,rst,enable,binIn,binOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [7:0] binIn;
   output reg [7:0] binOut;

   always @ (posedge clk or negedge rst) begin 
      if (!rst) begin
         binOut <= 8'b00000000;
      end else if (enable) begin
         binOut <= binIn;
      end
   end

endmodule
