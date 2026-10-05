`timescale 1ns/1ps 

module b2u_8to255_quad (clk, rst, enable, iIn, iMsb, qIn, qMsb, iOut, qOut);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire iMsb;
   input wire qMsb;
   input wire [7:0] iIn;
   input wire [7:0] qIn;

   output reg [255:0] iOut;
   output reg [255:0] qOut;

   // Intermediate pipeline registers to break long combinational paths
   reg [255:0] iOut_pipe;
   reg [255:0] qOut_pipe;

   always @ (posedge clk or negedge rst) begin
      if (!rst) begin
         iOut <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
         qOut <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
         iOut_pipe <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
         qOut_pipe <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
      end else if (enable) begin
          // Stage 1: Combinational logic captures from shift/reverse
          if (!iMsb) begin
              iOut_pipe <= (1 << iIn) - 1; 
          end else begin
              iOut_pipe <= 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
          end
          if (!qMsb) begin
              qOut_pipe <= reverse_bits((1 << qIn) - 1);
          end else begin
              qOut_pipe <= 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
          end
          // Stage 2: Final output register (breaks path from iOut_pipe/qOut_pipe to output)
          iOut <= iOut_pipe;
          qOut <= qOut_pipe;
      end
   end

      // Function to reverse the bits of a 256-bit vector
   function automatic [255:0] reverse_bits;
      input [255:0] in;
      integer i;
      begin
         for (i = 0; i < 256; i = i + 1) begin
            reverse_bits[i] = in[255 - i];
         end
      end
   endfunction

endmodule