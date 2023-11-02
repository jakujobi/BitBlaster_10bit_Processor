// ALU

/*
- The multi-stage ALU shown in Fig. 2, which performs the useful arithmetic operations on data held in the registers, is very similar to Lab 7.
- The ALU takes one common operand through the OP input.
- To perform an arithmetic or logic operation on two inputs, an ‘A’ register is used to stage the inputs.
- The ALU always outputs (combinational logic) A FN OP, where FN is one of the operations in the instruction set specified by ALUcont.
- Two additional control signals determine when the result should be saved (Gin) and when the result should output (Gout).
- Both of the registers operate on a synchronized negative-edge triggered clock signal.
*/
module ALU (
    input logic [9:0] OP,
    input logic [3:0] FN,
    input logic Ain,
    input logic Gin,
    input logic Gout,
    input logic CLKb,

    output logic [9:0] Q
);



endmodule