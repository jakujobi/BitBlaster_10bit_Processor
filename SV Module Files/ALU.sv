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
    input logic Ain,    //Register A used to stage the inputs
    input logic Gin,
    input logic Gout,
    input logic CLKb,

    output logic [9:0] RES
);

parameter 
    LOAD = 4'b0000, //Load 
    COPY = 4'b0001, //Copy the value from Ry and store to Rx: Rx←[Ry]
    ADD = 4'b0010,  //add Rx and RY; Add the values in Rx and Ry and store the result inRx:  Rx←[Rx] + [Ry]
    SUB = 4'b0011,  //sub Rx and RY; Subtract the value in Ry from Rx and store the result inRx:  Rx←[Rx] − [Ry]
    INV = 4'b0100,  //inv Rx and RY; Take the twos-complement of the value in Ry and store to Rx:  Rx←−[Ry]
    FLIP = 4'b0101, //flp Rx and RY; Flip the bits of the value in Ry and store to Rx:  Rx←∼[Ry]
    AND = 4'b0110,  //and Rx and RY; Bit-wise AND the values in Rx and Ry and store the result inRx:  Rx←[Rx] & [Ry]
    OR = 4'b0111,   //or Rx and RY; Bit-wise OR the values in Rx and Ry and store the result inRx:  Rx←[Rx] | [Ry]
    XOR = 4'b1000,  //xor Rx and RY; Bit-wise XOR the values in Rx and Ry and store the result inRx:  Rx←[Rx] ⊕ [Ry]
    LSL = 4'b1001,  //lsl Rx and RY; Logical shift left the value in Rx by Ry and store the result inRx:  Rx←[Rx] << [Ry]
    LSR = 4'b1010,  //lsr Rx and RY; Logical shift right the value in Rx by Ry and store the result inRx:  Rx←[Rx] >> [Ry]
    ASR = 4'b1011,  //asr Rx and RY; Arithmetic shift right the value of Rx by Ry and store the result inRx:  Rx←[Rx] >>> [Ry]
    ADDI = 4'b1100, //addi Rx, 6’bIIIIII; Add the value in Rx and the 6’bIIIIII and store the result inRx:  Rx←[Rx] + [6’bIIIIII]
    SUBI = 4'b1101; //subi Rx, 6’bIIIIII; Subtract the value in Rx and the 6’bIIIIII and store the result inRx:  Rx←[Rx] − [6’bIIIIII]

logic [9:0] A; //Register A
logic [9:0] G; //Register G (result)

// Prepping the input to register A
always_ff @(negedge CLKb) begin
    if (Ain) begin
        A <= OP; // Load A with OP on negative clock edge when Ain is enabled
    end
end


// Logic for ALU operations
always_comb begin
    case (FN)
        LOAD:  G = OP;
        COPY:  G = A;  // Assuming COPY means taking value from A
        ADD:   G = A + OP;
        SUB:   G = A - OP;
        INV:   G = ~A; // Twos complement
        FLIP:  G = ~A; // Bitwise NOT
        AND:   G = A & OP;
        OR:    G = A | OP;
        XOR:   G = A ^ OP;
        LSL:   G = A << OP;
        LSR:   G = A >> OP;
        ASR:   G = A >>> OP;
        ADDI:  G = A + OP;  // Immediate value is part of OP
        SUBI:  G = A - OP;  // Immediate value is part of OP
        default: G = 10'b0; // Default case to handle undefined operations
    endcase
end


// Storing the result to RES based on Gout
always_ff @(negedge CLKb) begin
    if (Gin) begin
        RES <= G; // Store result in RES when Gin is enabled
    end
end



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