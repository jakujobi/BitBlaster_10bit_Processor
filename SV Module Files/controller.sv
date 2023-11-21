module controller(
    input logic [9:0] INST,
    input logic [1:0] T,

    output logic [9:0] IMM,
    output logic [1:0] Rin,
    output logic [1:0] Rout,
    output logic ENW,
    output logic ENR,
    output logic Ain,
    output logic Gin,
    output logic Gout,
    output logic [3:0] ALUcont,
    output logic Ext,
    output logic IRin,
    output logic Clr
);

//if the first two bits of the instruction are 00, then we go to next step
logic [1:0] first_two_bits;
assign first_two_bits = INST[9:8];

always_comb begin
    if (first_two_bits == 10) begin

    end
    else if (first_two_bits == 11) begin

    end
    else if (first_two_bits == 01) begin

    end
    else if (first_two_bits == 00) begin



    end 
    else begin

    end
end

always_comb begin
    case (first_two_bits)
        2'b01 : 


endmodule


/*
Processor Controller
- The ‘brains’ of the processor, and perhaps the most challenging aspect of the design process, is the controller.
- The controller needs to determine the output of each of the control signals for the processor (shown as red in Fig. 1).
- The list of outputs, given in Table 2, are combinational logic that depend on the current timestep T and the current instruction INSTR (from the list in Table 1).
- It is suggested that a time-instruction table similar to that in class is created, and behavioral or procedural logic is derived.

Table 2: Processor Control Signal Outputs

Signal Bit-width Description
- IMM   10  Immediate value to be used for the two immediate instructions
- Rin   2   Address for the register to be written to, from the shared data bus
- Rout  2   Address for the register to be read from, to the shared data bus
- ENW   1   Enable signal to write data to the register file
- ENR   1   Enable signal to read data from the register file
- Ain   1   Enable signal to save data to the intermediate ALU input “A”
- Gin   1   Enable signal to save data to the intermediate ALU output “G”
- Gout  1   Enable signal to write data from the ALU intermediate output “G” to the shared data bus
- ALUcont 4 Signal to control which arithmetic or logic operation the ALU should perform
- Ext   1    Enable signal to drive the shared data bus from the external “data” signal
- IRin  1     Enable signal to save data to the instruction register
- Clr   1     Clear signal for the timestep counter
*/