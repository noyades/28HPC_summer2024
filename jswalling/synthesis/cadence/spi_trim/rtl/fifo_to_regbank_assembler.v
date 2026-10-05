`timescale 1ns / 1ps

module fifo_to_regbank_assembler (
    input wire clk,
    input wire rst,
    input wire fifo_data_valid,
    input wire [11:0] fifo_data,
    output reg [42:0] reg_data,
    output reg reg_data_valid,
    output reg fifo_read_enable
);

localparam IDLE = 3'b000,
           PREREAD = 3'b001,
           READ1 = 3'b010,
           READ2 = 3'b011,
           READ3 = 3'b100,
           READ4 = 3'b101,
           ASSEMBLE = 3'b110;

reg [2:0] state = IDLE;
reg [11:0] data_buffer[0:3];

always @(posedge clk or negedge rst) begin
    if (!rst) begin
       state <= IDLE;
       reg_data_valid <= 0;
       fifo_read_enable <= 0;
       data_buffer[0] <= 0;
       data_buffer[1] <= 0;
       data_buffer[2] <= 0;
       data_buffer[3] <= 0;
    end else begin 
        case (state)
            IDLE: begin
                if (fifo_data_valid) begin
                    fifo_read_enable <= 1;
                    state <= PREREAD;
                end else begin
                    fifo_read_enable <= 0;
                end
                reg_data_valid <= 0;
            end
            PREREAD: begin
                state <= READ1;
                fifo_read_enable <= fifo_data_valid;
            end

            READ1: begin
                if (fifo_data_valid) begin
                    data_buffer[0] <= fifo_data;
                    fifo_read_enable <= 1;
                    state <= READ2;
                end
            end
            READ2: begin
                if (fifo_data_valid) begin
                    data_buffer[1] <= fifo_data;
                    fifo_read_enable <= 1;
                    state <= READ3;
                end
            end
            READ3: begin
                if (fifo_data_valid) begin
                    data_buffer[2] <= fifo_data;
                    fifo_read_enable <= 1;
                    state <= READ4;
                end
            end
            READ4: begin
                if (fifo_data_valid) begin
                    data_buffer[3] <= fifo_data;
                    fifo_read_enable <= 1;
                    state <= ASSEMBLE;
                end
            end
            ASSEMBLE: begin
                reg_data <= {data_buffer[0],data_buffer[1],data_buffer[2],data_buffer[3]};
                reg_data_valid <= 1;
                fifo_read_enable <= 0;
                state <= IDLE;
            end
        endcase
    end
end

 
endmodule
