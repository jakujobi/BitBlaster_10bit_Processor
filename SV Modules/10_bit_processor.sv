// 10-bit processor
// This is the top level file
module 10_bit_processor (
    input logic [9:0] raw_data,
    input logic CLOCK_50,

    output logic [9:0] LED_B,
    output logic [6:0] DHEX0,
    output logic [6:0] DHEX1
    output logic [6:0] DHEX2,
    output logic [6:0] THEX,
    output logic LED_D
);




endmodule

/*
You will build the processor shown in Fig. 1 with the set of instructions in Section 3.2.
Your data bus will be 10-bits wide, and is used to pass data between elements of your processor (shown in green in Fig. 1).
A general description of the processor will be provided here, with each of the top-level modules and inputs/outputs described in more detail below.
Your 10-bit processor takes in data and instructions via an external source (labeled “data”).
Depending on the current instruction (saved in the instruction register) and the current timestep (saved in a 2-bit counter),
    your controller drives the control signals of your multi-stage processor circuit. All data is saved in one of four 10-bit registers (R0–R3) within the register file.
To perform arithmetic and logic operations on the stored data, a multi-stage arithmetic logic unit (ALU) is used that calculates an output G = A FN OP,
    where “FN” is the arithmetic or logic operation to be performed,
    A and G are intermediate input and output registers, respectively,
    and OP and RES are connected to the shared data bus as the operand input and result output, respectively.
The processor has a shared data bus.

The 10-bit processor is similar to that discussed in the supplementary PDF written by Brown and Vranesic (old textbook) and that we discussed in class.
The PDF contains many hints and SystemVerilog samples beyond those discussed in class.

3.2 Instruction Set
You will implement, and your processor will support, the following functions using the exact instruction formats in Table 1.
Some instructions use the ALU, some need just one operand, some are just for data movement, and some use immediate values as operands.
ARM-TI is leaving you the design decision to determine how best to decode each instruction, but they expect the minimum number of timesteps required per instruction type
    (hint: if you only need one operand, you might (read: must) be able to skip an ALU step [wink, wink]).

Table 1: Processor instruction set
Opcode          Mnemonic            Instruction
00_XX_UUU_0000  ld Rx               Load data into Rx from the slide switches (external data input): Rx ← Data
00_XX_YY_0001   cp Rx, Ry           Copy the value from Ry and store to Rx: Rx ← [Ry]
00_XX_YY_0010   add Rx, Ry          Add the values in Rx and Ry and store the result in Rx: Rx ← [Rx] + [Ry]
00_XX_YY_0011   sub Rx, Ry          Subtract the value in Ry from Rx and store the result in Rx: Rx ← [Rx]−[Ry]
00_XX_YY_0100   inv Rx, Ry          Take the twos-complement of the value in Ry and store to Rx: Rx ← −[Ry]
00_XX_YY_0101   flp Rx, Ry          Flip the bits of the value in Ry and store to Rx: Rx ←∼ [Ry]
00_XX_YY_0110   and Rx, Ry          Bit-wise AND the values in Rx and Ry and store the result in Rx: Rx ← [Rx] & [Ry]
00_XX_YY_0111   or Rx, Ry           Bit-wise OR the values in Rx and Ry and store the result in Rx: Rx ← [Rx] | [Ry]
00_XX_YY_1000   xor Rx, Ry          Bit-wise XOR the values in Rx and Ry and stroe the result in Rx: ← [Rx] ∧ [Ry]
00_XX_YY_1001   lsl Rx, Ry          Logical shift left the value in Rx by Ry and store the result in Rx: Rx ← [Rx] <<[Ry]
00_XX_YY_1010   lsr Rx, Ry          Logical shift right the value in Rx by Ry and store the result in Rx: Rx ← [Rx] >>[Ry]
00_XX_YY_1011   asr Rx, Ry          Arithmatic shift right the value of Rx by Ry and store the result in Rx: ← [Rx] >>>[Ry]
10_XX_IIIIII    addi Rx, 6’bIIIIII  Add the 6-bit immediate value 10’b0000IIIIII (left-padded with zeros) to the value in Rx and store in Rx: Rx ← [Rx] + 10’b0000IIIIII
11_XX_IIIIII    subi Rx, 6’bIIIIII  Subtract the 6-bit immediate value 10’b0000IIIIII (left-padded with zeros) from the value in Rx and store in Rx: Rx ← [Rx] - 10’b0000IIIIII

*/