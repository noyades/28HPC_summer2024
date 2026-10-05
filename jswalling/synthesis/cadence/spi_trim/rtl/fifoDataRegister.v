module fifoDataRegister(
    input wire clk,
    input wire rst_n,
    input wire fifo_empty,      // Indicates if FIFO is empty
    input wire data_consumed,   // Downstream logic has consumed the data
    input wire [31:0] fifo_data,// Data output from FIFO
    output reg [31:0] data_reg, // Register to hold data from FIFO
    output reg data_valid,       // Indicates when data_reg holds valid data
    output wire ready_for_data   // Indicates registers are ready for new data
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // On reset, initialize all registers to 0
            data_reg <= 32'b0;
            data_valid <= 1'b0;
        end
        else if (data_consumed || fifo_empty) begin
            data_valid <= 1'b0; 
        end
        else begin
            data_reg <= fifo_data;
            data_valid <= 1'b1; // Clear the valid flag as the data has been consumed.
        end
    end
    assign ready_for_data = !data_valid || data_consumed;

endmodule

