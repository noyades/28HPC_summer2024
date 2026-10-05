//Verilog HDL for "jswalling_tapeout", "vcselDriverDecoder" "verilog"
`timescale 1 ns/ 1 ps

module vcselDriverDecoder (clk, rst, bIn, uIn, bOut, uOut);

   input wire clk;
   input wire rst;
   input wire [7:0] bIn;
   input wire [4:0] uIn;

   output reg [31:0] uOut;
   output reg [7:0] bOut;

   always @ (posedge clk or negedge rst)
      begin
         if (!rst)
            begin
               bOut <= 'b00000000;
               uOut <= 'b00000000000000000000000000000000;
            end
         else
            begin
               bOut <= bIn;
               if (uIn=='b00000)
                  begin
                     uOut<='b00000000000000000000000000000000;
                  end
               else if (uIn=='b00001)
                  begin
                     uOut<='b00000000000000000000000000000001;
                  end
               else if (uIn=='b00010)
                  begin
                     uOut<='b00000000000000000000000000000011;
                  end
               else if (uIn=='b00011)
                  begin
                     uOut<='b00000000000000000000000000000111;
                  end
               else if (uIn=='b00100)
                  begin
                     uOut<='b00000000000000000000000000001111;
                  end
               else if (uIn=='b00101)
                  begin
                     uOut<='b00000000000000000000000000011111;
                  end
               else if (uIn=='b00110)
                  begin
                     uOut<='b00000000000000000000000000111111;
                  end
               else if (uIn=='b00111)
                  begin
                     uOut<='b00000000000000000000000001111111;
                  end
               else if (uIn=='b01000)
                  begin
                     uOut<='b00000000000000000000000011111111;
                  end
               else if (uIn=='b01001)
                  begin
                     uOut<='b00000000000000000000000111111111;
                  end
               else if (uIn=='b01010)
                  begin
                     uOut<='b00000000000000000000001111111111;
                  end
               else if (uIn=='b01011)
                  begin
                     uOut<='b00000000000000000000011111111111;
                  end
               else if (uIn=='b01100)
                  begin
                     uOut<='b00000000000000000000111111111111;
                  end
               else if (uIn=='b01101)
                  begin
                     uOut<='b00000000000000000001111111111111;
                  end
               else if (uIn=='b01110)
                  begin
                     uOut<='b00000000000000000011111111111111;
                  end
               else if (uIn=='b01111)
                  begin
                     uOut<='b00000000000000000111111111111111;
                  end
               else if (uIn=='b10000)
                  begin
                     uOut<='b00000000000000001111111111111111;
                  end
               else if (uIn=='b10001)
                  begin
                     uOut<='b00000000000000011111111111111111;
                  end
               else if (uIn=='b10010)
                  begin
                     uOut<='b00000000000000111111111111111111;
                  end
               else if (uIn=='b10011)
                  begin
                     uOut<='b00000000000001111111111111111111;
                  end
               else if (uIn=='b10100)
                  begin
                     uOut<='b00000000000011111111111111111111;
                  end
               else if (uIn=='b10101)
                  begin
                     uOut<='b00000000000111111111111111111111;
                  end
               else if (uIn=='b10110)
                  begin
                     uOut<='b00000000001111111111111111111111;
                  end
               else if (uIn=='b10111)
                  begin
                     uOut<='b00000000011111111111111111111111;
                  end
               else if (uIn=='b11000)
                  begin
                     uOut<='b00000000111111111111111111111111;
                  end
               else if (uIn=='b11001)
                  begin
                     uOut<='b00000001111111111111111111111111;
                  end
               else if (uIn=='b11010)
                  begin
                     uOut<='b00000011111111111111111111111111;
                  end
               else if (uIn=='b11011)
                  begin
                     uOut<='b00000111111111111111111111111111;
                  end
               else if (uIn=='b11100)
                  begin
                     uOut<='b00001111111111111111111111111111;
                  end
               else if (uIn=='b11101)
                  begin
                     uOut<='b00011111111111111111111111111111;
                  end
               else if (uIn=='b11110)
                  begin
                     uOut<='b00111111111111111111111111111111;
                  end
               else if (uIn=='b11111)
                  begin
                     uOut<='b01111111111111111111111111111111;
                  end
               
            end
         
      end 
   
endmodule
