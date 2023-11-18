module outputlogic(
    input logic [9:0] BUS,
    input logic [9:0] REG,
    input logic [1:0] TIME,
    input logic DONE,
    input logic Pkb,

    output logic [9:0] LED_B,
    output logic [6:0] DHEX0,
    output logic [6:0] DHEX1,
    output logic [6:0] DHEX2,
    output logic [6:0] THEX,
    output logic LED_D
);

    // LED_B shows the current values on the data bus
    assign LED_B = BUS;

    // THEX shows the current timestep decoded to a 7-segment display
    assign THEX = time_to_7seg(TIME);

    // DHEX2:0 shows either BUS or REG based on Pkb
    logic [20:0] hex_value; // 3 * 7 segments = 21 bits
    assign hex_value = value_to_7seg(Pkb ? BUS : REG);

    assign DHEX0 = hex_value[6:0];
    assign DHEX1 = hex_value[13:7];
    assign DHEX2 = hex_value[20:14];

    // LED_D is active if DONE is logic-1
    assign LED_D = DONE;

endmodule

// Function to convert 2-bit time to 7-segment display
function [6:0] time_to_7seg(input [1:0] processor_time);
    begin
        case (processor_time)
            2'b00: time_to_7seg = 7'b1000000; // Display "0"
            2'b01: time_to_7seg = 7'b1111001; // Display "1"
            2'b10: time_to_7seg = 7'b0100100; // Display "2"
            2'b11: time_to_7seg = 7'b0110000; // Display "3"
            default: time_to_7seg = 7'b1111111; // Display nothing
        endcase
    end
endfunction

// Function to convert 10-bit value to three 7-segment displays
function [20:0] value_to_7seg(input [9:0] value);
    logic [3:0] digit[2:0]; // Each digit of the 10-bit value
    begin
        // Splitting 10-bit value into 3 digits
        digit[0] = value % 10;        // Least significant digit
        digit[1] = (value / 10) % 10; // Middle digit
        digit[2] = value / 100;       // Most significant digit

        // Convert each digit to 7-segment
        value_to_7seg = {digit_to_7seg(digit[2]), digit_to_7seg(digit[1]), digit_to_7seg(digit[0])};
    end
endfunction

// Function to convert a single digit to 7-segment display
function [6:0] digit_to_7seg(input [3:0] digit);
    begin
        case (digit)
            // Define cases for each digit (0-9)
            4'b0000: digit_to_7seg  = 7'b1000000; // 0
            4'b0001: digit_to_7seg  = 7'b1111001; // 1
            4'b0010: digit_to_7seg  = 7'b0100100; // 2
            4'b0011: digit_to_7seg  = 7'b0110000; // 3
            4'b0100: digit_to_7seg  = 7'b0011001; // 4
            4'b0101: digit_to_7seg  = 7'b0010010; // 5
            4'b0110: digit_to_7seg  = 7'b0000010; // 6
            4'b0111: digit_to_7seg  = 7'b1111000; // 7
            4'b1000: digit_to_7seg  = 7'b0000000; // 8
            4'b1001: digit_to_7seg  = 7'b0010000; // 9
            4'b1010: digit_to_7seg  = 7'b0001000; // Display A
            4'b1011: digit_to_7seg  = 7'b0000011; // Display B
            4'b1100: digit_to_7seg  = 7'b1000110; // Display C
            4'b1101: digit_to_7seg  = 7'b0100001; // Display D
            4'b1110: digit_to_7seg  = 7'b0000110; // Display E
            4'b1111: digit_to_7seg  = 7'b0001110; // Display F

            default: digit_to_7seg = 7'b1111111; // Display nothing for invalid digit
        endcase
    end
endfunction



/*
module outputlogic(
    input logic [9:0] BUS,
    input logic [9:0] REG,
    input logic [1:0] TIME,
    input logic DONE,
    input logic Pkb,

    output logic [9:0] LED_B,
    output logic [6:0] DHEX0,
    output logic [6:0] DHEX1,
    output logic [6:0] DHEX2,
    output logic [6:0] THEX,
    output logic LED_D
);

// LED_D indicates when the current instruction is done
assign LED_D = DONE;

// LED_B shows the current values on the data bus
assign LED_B = BUS;

// Decoding TIME to a 7-segment display (THEX)
// Assuming a function binary4todecimal7decoder is defined to convert binary to 7-segment code
logic [3:0] TIME4;      // TIME4 is a 4 bit variable that represents the time
assign TIME4[0] = TIME[0];
assign TIME4[1] = TIME[1];
assign TIME4[2] = 0;
assign TIME4[3] = 0;

// Decoding TIME to 7-segment display
binary4todecimal7decoder timeDecoder(
    .binary(TIME4),
    .sevenSeg(THEX)
);

//! Decoding BUS or REG to 7-segment displays based on Pkb
logic [3:0] digit0, digit1, digit2;

always_comb begin
    // This block decides what to display on the 7-segment displays DHEX2:0 based on the value of Pkb
    if (Pkb) {
        // If Pkb is logic-1, display the BUS value on DHEX2:0
        digit0 = BUS[3:0];   // Extracting the least significant 4 bits of BUS for the first digit
        digit1 = BUS[7:4];   // Extracting the next 4 bits of BUS for the second digit
        digit2 = {6'b0, BUS[9:8]}; // Extracting the most significant 2 bits of BUS for the third digit, padded with zeros
    } else {
        // If Pkb is logic-0, display the REG value on DHEX2:0
        digit0 = REG[3:0];   // Extracting the least significant 4 bits of REG for the first digit
        digit1 = REG[7:4];   // Extracting the next 4 bits of REG for the second digit
        digit2 = {6'b0, REG[9:8]}; // Extracting the most significant 2 bits of REG for the third digit, padded with zeros
    }
end


always_comb begin
    if (Pkb){
        binary4todecimal7decoder digit0Decoder(
            .binary(digit0),
            .sevenSeg(DHEX0)
        );

        binary4todecimal7decoder digit1Decoder(
            .binary(digit1),
            .sevenSeg(DHEX1)
        );

        binary4todecimal7decoder digit2Decoder(
            .binary(digit2),
            .sevenSeg(DHEX2)
        );
    } else {
        binary4todecimal7decoder digit0Decoder(
            .binary(digit0),
            .sevenSeg(DHEX0)
        );

        binary4todecimal7decoder digit1Decoder(
            .binary(digit1),
            .sevenSeg(DHEX1)
        );

        binary4todecimal7decoder digit2Decoder(
            .binary(digit2),
            .sevenSeg(DHEX2)
        );
    }
//! Decoding digits to 7-segment displays


endmodule

*/

/*
Output Logic
- In a normal processor, the logic signals remain invisible to the user.
- For testing and demonstration purposes, ARM-TI has requested a special combinational output logic block that can probe the
data within the processor (shown as the blue signals in Fig. 1).
- The output logic takes as inputs the current data on the shared bus (BUS), the output of the second read port on the register file
(REG), and the current timestep of the processor (TIME).
- Based on these inputs, the following outputs are always shown: LED B shows the current values on the data bus, and THEX shows
the current timestep decoded to a 7-segment display.
- The DHEX2:0 outputs change depending on the value of PEEKb, which can be used to “peek” into a register.
- If PEEKb is a logic-1, DHEX2:0 shows the current 10-bit value on the data bus decoded to three 7-segment displays.
- If PEEKb is a logic-0, DHEX2:0 shows the 10-bit output of the second read port of the register file.
- This can be used to “peek” into each of the eight registers using the three least significant bits of the “data” signal (RDA1).
- One final input/output of the output logic block takes the “Clr” signal from the controller.
- If “Clr” is a logic-1, an LED DONE output should be active to indicate the current instruction has completed.
*/