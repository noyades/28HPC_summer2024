`timescale 1ns / 1ps

module register_bank_pll(
    input wire clk,
    input wire rst,
    input wire [42:0] data_in,     // Data input
    input wire load_data,          // Signal to load data into a register
    input wire [1:0] select_reg,   // Select which register to read/write
    input wire read_enable,        // Signal to enable reading selected register data
    output reg [42:0] data_out,    // Data output for reading
    output reg read_data_valid     // Flag to indicate valid data is being output
);

// Define 4 x 43-bit registers
reg [42:0] reg0, reg1, reg2, reg3;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        reg0 <= 43'd0;
        reg1 <= 43'd0;
        reg2 <= 43'd0;
        reg3 <= 43'd0;
    end else if (load_data) begin
        // Load data into selected register based on select_reg
        case (select_reg)
            2'b00: reg0 <= data_in;
            2'b01: reg1 <= data_in;
            2'b10: reg2 <= data_in;
            2'b11: reg3 <= data_in;
            default: ; // Do nothing for default case
        endcase
    end
end

always @(posedge clk) begin
    if (read_enable) begin
        // Output data from selected register
        case (select_reg)
            2'b00: data_out <= reg0;
            2'b01: data_out <= reg1;
            2'b10: data_out <= reg2;
            2'b11: data_out <= reg3;
            default: data_out <= 43'd0; // Output zero on undefined select_reg
        endcase
        read_data_valid <= 1'b1;
    end else begin
        read_data_valid <= 1'b0; // Clear the valid flag if not reading
    end
end

endmodule
