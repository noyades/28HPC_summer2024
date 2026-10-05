`timescale 1ns/1ps

module vcselDecoder(clk, rst, enable, binIn, colOut, rowOut, binOut, acOut, data_received);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [31:0] binIn; //upper 6MSBs not used currently, they are added to allow for expansion of resolution or function in later revs 

   output wire [31:0] colOut;
   output wire [31:0] rowOut;
   output wire  [7:0] binOut;
   output wire  [5:0] acOut;

   output reg data_received;

   binRegs dec_0(
         .clk(clk),
         .rst(rst),
         .enable( enable ),
         .binIn(binIn[7:0]),
         .acIn(binIn[25:20]),
         .binOut(binOut),
         .acOut(acOut) 
   );

   bin2therm_5to31 dec_1(
         .clk( clk ), 
         .rst( rst ),
         .enable( enable ),
         .uIn( binIn[12:8] ),
         .msb( binIn[18]),
         .uOut( rowOut )
   );

   bin2therm_5to31 dec_2(
         .clk( clk ), 
         .rst( rst ),
         .enable( enable ),
         .uIn( binIn[17:13] ),
         .msb( binIn[19]),
         .uOut( colOut )
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
