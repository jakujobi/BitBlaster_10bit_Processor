module outputlogic(
    input logic [9:0] BUS,
    input logic [9:0] REG,
    input logic [1:0] TIME,
    input logic DONE,
    input logic Pkb,

    output logic [9:0] LED_B,
    output logic [6:0] DHEX0,
    output logic [6:0] DHEX1
    output logic [6:0] DHEX2,
    output logic [6:0] THEX,
    output logic LED_D
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