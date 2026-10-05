module vcoDecoder(clk, rst, enable, binIn, vcoTrimOut, exTrimOut, data_received);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [31:0] binIn; //upper 12MSBs not used currently, they are added to allow for expansion of resolution or function in later revs 

   output wire  [15:0] vcoTrimOut;
   output wire  [15:0] exTrimOut; // These bits are not currently attached (SEE ABOVE)

   output reg data_received;

   trimRegs dec_0(
         .clk(clk),
         .rst(rst),
         .enable( enable ),
         .binIn(binIn[31:0]),
         .binOut({exTrimOut[15:0],vcoTrimOut[15:0]})
   );

   always @(posedge clk or negedge rst) begin
       if (!rst) begin
           data_received <= 0;
       end
       else if (enable) begin
           data_received <= 1;
       end
       else begin
           data_received <= 0;
       end
   end
endmodule
