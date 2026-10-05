`timescale 1ns/1ps 

module thermalDecoder(clk, rst, enable, binIn, colOut, rowOut, binOut, data_received);

   input wire clk;
   input wire rst;
   input wire enable;
   input wire [31:0] binIn; //upper 14MSBs not used currently, they are added to allow for expansion of resolution or function in later revs 

   output wire [15:0] colOut;
   output wire [15:0] rowOut;
   output wire  [7:0] binOut;
   
   output reg data_received;

   thermalBinRegs dec_B(
         .clk(clk),
         .rst(rst),
         .enable( enable ),
         .binIn(binIn[7:0]),
         .binOut(binOut)
   );

   fourBitThermometerDecoder dec_R(
         .clk( clk ), 
         .rst( rst ),
         .enable( enable ),
         .uIn( binIn[11:8] ),
         .msb( binIn[16]),
         .uOut( rowOut )
   );

   fourBitThermometerDecoder dec_C(
         .clk( clk ), 
         .rst( rst ),
         .enable( enable ),
         .uIn( binIn[15:12] ),
         .msb( binIn[17]),
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
