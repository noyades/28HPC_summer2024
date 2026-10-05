module spi_sub(clk, rst, cs, sclk, mosi, miso);

    input wire clk;
    input wire rst;
    input wire cs;
    input wire sclk;
    input wire mosi;
    output wire miso;

    parameter IDLE = 2'b00;
    parameter READ = 2'b01;
    parameter WRITE = 2'b10;
    
    reg [1:0] state;
    reg [31:0] data_out;
    reg [31:0] data_in;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else if (cs) begin
            case (state)
                IDLE: begin
                    if (!sclk) begin
                        state <= READ;
                        data_out <= 32'h12345678; // Example data to send
                    end
                end
                
                READ: begin
                    if (!sclk) begin
                        state <= IDLE;
                    end
                end
                
                WRITE: begin
                    if (!sclk) begin
                        state <= IDLE;
                        data_in <= data_in << 1;
                        data_in[0] <= mosi;
                    end
                end
            endcase
        end
    end
    
    assign miso = data_out[31];
    
endmodule

