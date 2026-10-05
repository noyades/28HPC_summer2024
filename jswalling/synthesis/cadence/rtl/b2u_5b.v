module b2u_5b (
    input wire [4:0] binary_input,
    output wire [31:0] thermometer_output
);

    thermometer_output[0] <= (binary_input >= 3'b00000) ? 1'b1 : 1'b0;
    thermometer_output[1] <= (binary_input >= 3'b00001) ? 1'b1 : 1'b0;
    thermometer_output[2] <= (binary_input >= 3'b00010) ? 1'b1 : 1'b0;
    thermometer_output[3] <= (binary_input >= 3'b00011) ? 1'b1 : 1'b0;
    thermometer_output[4] <= (binary_input >= 3'b00100) ? 1'b1 : 1'b0;
    thermometer_output[5] <= (binary_input >= 3'b00101) ? 1'b1 : 1'b0;
    thermometer_output[6] <= (binary_input >= 3'b00110) ? 1'b1 : 1'b0;
    thermometer_output[7] <= (binary_input >= 3'b00111) ? 1'b1 : 1'b0;
    thermometer_output[8] <= (binary_input >= 3'b01000) ? 1'b1 : 1'b0;
    thermometer_output[9] <= (binary_input >= 3'b01001) ? 1'b1 : 1'b0;
    thermometer_output[10] <= (binary_input >= 3'b01010) ? 1'b1 : 1'b0;
    thermometer_output[11] <= (binary_input >= 3'b01011) ? 1'b1 : 1'b0;
    thermometer_output[12] <= (binary_input >= 3'b01100) ? 1'b1 : 1'b0;
    thermometer_output[13] <= (binary_input >= 3'b01101) ? 1'b1 : 1'b0;
    thermometer_output[14] <= (binary_input >= 3'b01110) ? 1'b1 : 1'b0;
    thermometer_output[15] <= (binary_input >= 3'b01111) ? 1'b1 : 1'b0;
    thermometer_output[16] <= (binary_input >= 3'b10000) ? 1'b1 : 1'b0;
    thermometer_output[17] <= (binary_input >= 3'b10001) ? 1'b1 : 1'b0;
    thermometer_output[18] <= (binary_input >= 3'b10010) ? 1'b1 : 1'b0;
    thermometer_output[19] <= (binary_input >= 3'b10011) ? 1'b1 : 1'b0;
    thermometer_output[20] <= (binary_input >= 3'b10100) ? 1'b1 : 1'b0;
    thermometer_output[21] <= (binary_input >= 3'b10101) ? 1'b1 : 1'b0;
    thermometer_output[22] <= (binary_input >= 3'b10110) ? 1'b1 : 1'b0;
    thermometer_output[23] <= (binary_input >= 3'b10111) ? 1'b1 : 1'b0;
    thermometer_output[24] <= (binary_input >= 3'b11000) ? 1'b1 : 1'b0;
    thermometer_output[25] <= (binary_input >= 3'b11001) ? 1'b1 : 1'b0;
    thermometer_output[26] <= (binary_input >= 3'b11010) ? 1'b1 : 1'b0;
    thermometer_output[27] <= (binary_input >= 3'b11011) ? 1'b1 : 1'b0;
    thermometer_output[28] <= (binary_input >= 3'b11100) ? 1'b1 : 1'b0;
    thermometer_output[29] <= (binary_input >= 3'b11101) ? 1'b1 : 1'b0;
    thermometer_output[30] <= (binary_input >= 3'b11110) ? 1'b1 : 1'b0;
    thermometer_output[31] <= 1'b1; // Always set the highest bit

endmodule

