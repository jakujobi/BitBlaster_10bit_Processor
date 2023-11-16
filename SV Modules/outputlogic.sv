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
    assign TIME4[2] = 0
    assign TIME4[3] = 0

    binary4todecimal7decoder timeDecoder(
        .binary(TIME4),
        .sevenSeg(THEX)
    );

    // Decoding BUS or REG to 7-segment displays based on Pkb
    logic [3:0] digit0, digit1, digit2;

    always_comb begin
        if (Pkb) {
            // If Pkb is logic-1, show BUS on DHEX2:0
            digit0 = BUS[3:0];
            digit1 = BUS[7:4];
            digit2 = {6'b0, BUS[9:8]};
        } else {
            // If Pkb is logic-0, show REG on DHEX2:0
            digit0 = REG[3:0];
            digit1 = REG[7:4];
            digit2 = {6'b0, REG[9:8]};
        }
    end

    // Decoding digits to 7-segment displays
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

endmodule

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