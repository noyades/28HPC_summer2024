module trimDecoder(clk, rst, enable, binIn, refTrimOut, bgTrimOut, exTrimOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [31:0] binIn; //upper 12MSBs not used currently, they are added to allow for expansion of resolution or function in later revs 

   output wire  [9:0] refTrimOut;
   output wire  [8:0] bgTrimOut;
   output wire  [12:0] exTrimOut; // These bits are not currently attached (SEE ABOVE)

   trimRegs dec_0(
         .clk(clk),
         .rst(rst),
         .enable( enable ),
         .binIn(binIn[31:0]),
         .binOut({exTrimOut[12:0],refTrimOut[9:0], bgTrimOut[8:0]})
   );

endmodule
