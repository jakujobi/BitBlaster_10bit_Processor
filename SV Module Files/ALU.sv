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

    output logic [9:0] RES
);

parameter   LOAD = 4'b0000, //Load 
            ADD = 4'b0001,  //add Rx and RY; Add the values in Rx and Ry and store the result inRx:  Rx←[Rx] + [Ry]
            COPY 


endmodule


/*
ld Rx (00_XX_UUU_0000)
    - Load data into Rx from the slide switches (external data input): Rx ← Data
cp Rx, Ry (00_XX_YY_0001)
    - Copy the value from Ry and store to Rx: Rx ← [Ry]
add Rx, Ry (00_XX_YY_0010)
    - Add the values in Rx and Ry and store the result in Rx: Rx ← [Rx] + [Ry]
sub Rx, Ry (00_XX_YY_0011)
    - Subtract the value in Ry from Rx and store the result in Rx: Rx ← [Rx] − [Ry]
inv Rx, Ry (00_XX_YY_0100)
    - Take the twos-complement of the value in Ry and store to Rx: Rx ← −[Ry]
flp Rx, Ry (00_XX_YY_0101)
    - Flip the bits of the value in Ry and store to Rx: Rx ← ∼[Ry]
and Rx, Ry (00_XX_YY_0110)
    - Bit-wise AND the values in Rx and Ry and store the result in Rx: Rx ← [Rx] & [Ry]
or Rx, Ry (00_XX_YY_0111)
    - Bit-wise OR the values in Rx and Ry and store the result in Rx: Rx ← [Rx] | [Ry]
xor Rx, Ry (00_XX_YY_1000)
    - Bit-wise XOR the values in Rx and Ry and store the result in Rx: Rx ← [Rx] ∧ [Ry]
lsl Rx, Ry (00_XX_YY_1001)
    - Logical shift left the value in Rx by Ry and store the result in Rx: Rx ← [Rx] << [Ry]
lsr Rx, Ry (00_XX_YY_1010)
    - Logical shift right the value in Rx by Ry and store the result in Rx: Rx ← [Rx] >> [Ry]
asr Rx, Ry (00_XX_YY_1011)
    - Arithmetic shift right the value of Rx by Ry and store the result in Rx: Rx ← [Rx] >>> [Ry]
addi Rx, 6’bIIIIII (10_XX_IIIIII)
    - Add the 6-bit immediate value 10’b0000IIIIII (left-padded with zeros) to the value in Rx and store in Rx: Rx ← [Rx] + 10’b0000IIIIII
subi Rx, 6’bIIIIII (11_XX_IIIIII)
    - Subtract the 6-bit immediate value 10’b0000IIIIII (left-padded with zeros) from the value in Rx
    - then store in Rx: Rx ← [Rx] - 10’b0000IIIIII
*/