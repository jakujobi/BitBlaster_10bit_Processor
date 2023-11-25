module controller(
    input logic [9:0] INST, //Immediatevalue to be used for the two immediate instructions
    input logic [1:0] T,    //Current timestep

    output logic [9:0] IMM,
    output logic [1:0] Rin, //Address for the register to be written to, from the shared data bus
    output logic [1:0] Rout,//Address for the register to be read from, to the shared data bus
    output logic ENW,       //Enable signal to write data to the register file
    output logic ENR,       //Enable signal to read data from the register file
    output logic Ain,       //Enable signal to save data to the intermediate ALU input “A”
    output logic Gin,       //Enable signal to save data to the intermediate ALU output “G”
    output logic Gout,      //Enable signal to write data from the ALU intermediate output “G” to the shared data bus
    output logic [3:0] ALUcont, //Signal to control which arithmetic or logic operation the ALU should perform
    output logic Ext,       //Enable signal to drive the shared data bus from the external “data” signal
    output logic IRin,      //Enable signal to save data to the instruction register
    output logic Clr        //Clear signal for the timestep counter
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


//if the first two bits of the instruction are 00, then we go to next step
logic [1:0] last_two_bits;
//assign last_two_bits = INST[9:8];

logic ALU_instruction;

logic Rx;
logic Ry;


// //Initialize all control signals to 0
// assign IMM = 0;
// assign Rin = 0;
// assign Rout = 0;
// assign ENW = 0;
// assign ENR = 0;
// assign Ain = 0;
// assign Gin = 0;
// assign Gout = 0;
// assign ALUcont = 0;
// assign Ext = 0;
// assign IRin = 0;
// assign Clr = 0;

// assign IMM = 0, Rin = 0, Rout = 0, ENW = 0, ENR = 0, Ain = 0, Gin = 0, Gout = 0, ALUcont = 0, Ext = 0, IRin = 0, Clr = 0;

//Determine control signals based on opcode and timestep



always_comb begin
    case (T)
    00: 
        //Set everything else to 0
        ENW = 0, WRA = 0, Gout = 0;
        ENR = 0, Ain = 0, Gin = 0;
        Clr = 0;  
        IMM = 10'bz; //Don't let IMM write to the bus from the controller

        Ext = 1;    //Allow external data input
        IRin = 1;   //Let the instruction register read

    01: 
        IMM = 10'bz; //Don't let IMM write to the bus from the controller

        Ext = 0;    //Don't allow external data input to the bus
        IRin = 0;  //Stop the instruction register from reading
        //By this time, we have the instruction

        last_two_bits = INST[9:8];  //Get the last two bits of the instruction
        Rx = INST(6:7);            //Get the Rx register

        if (last_two_bits == 00) begin
            Ry = INST(4:5);     //Get the Ry register
            ALU_instruction = INST(3:0);    //Get the ALU instruction

            // Logic for ALU operations
            case (ALU_instruction)
                LOAD:
                    Rin = Rx;   //Load the data into the Rx register
                    enRin = 1;  //Let the register file read
                    Clr = 1;    //Done with the operation, reset the counter
                COPY:  
                ADD:   
                SUB:   
                INV:   
                FLIP:  
                AND:   
                OR:    
                XOR:   
                LSL:   
                LSR:   
                ASR:   
                ADDI:  
                SUBI:  
                default: G = 10'b0; // Default case to handle undefined operations
            endcase

        end else if (last_two_bits == 01) begin
            //
        end else if (last_two_bits == 10) begin
            //
        end else if (last_two_bits == 11) begin
            //
        end

    10:
        if (last_two_bits == 00) begin
            //

            case (ALU_instruction)
                LOAD:
                COPY:  
                ADD:   
                SUB:   
                INV:   
                FLIP:  
                AND:   
                OR:    
                XOR:   
                LSL:   
                LSR:   
                ASR:   
                ADDI:  
                SUBI:  
                default: G = 10'b0; // Default case to handle undefined operations
            endcase

        end else if (last_two_bits == 01) begin
            //
        end else if (last_two_bits == 10) begin
            //
        end else if (last_two_bits == 11) begin
            //
        end



    11:
        if (last_two_bits == 00) begin
            //
            Gout = 1;
            Rin = Rx;
            enRin = 1;
            CLR = 1;

        end else if (last_two_bits == 01) begin
            //
        end else if (last_two_bits == 10) begin
            //
        end else if (last_two_bits == 11) begin
            //
        end

endcase



always_comb begin
    //!Normal operations
    if (last_two_bits == 00) begin
        ALUcont = INST[3:0];
        Rx = INST(6:7);
        Ry = INST(4:5);

        if (T == 0) begin
            //Load data into Rx from the slide switches (external data input): Rx ← Data
            if (INST[7:4] == 0000) begin
                Ext = 1;
            end

            //Copy the value from Ry and store to Rx: Rx ← [Ry]
            else if (INST[7:4] == 0001) begin
                Rin = Ry;
                Rout = Rx;
                ENR = 1;
                ENW = 1;
            end

            //Add the values in Rx and Ry and store the result in Rx: Rx ← [Rx] + [Ry]
            else if (INST[7:4] == 0010) begin
                Rin = Rx;
                Rout = Ry;
                ENR = 1;
                ENW = 1;
                Ain = 1;
                Gout = 1;
            end

            //Subtract the value in Ry from Rx and store the result in Rx: Rx ← [Rx] − [Ry]
            else if (INST[7:4] == 0011) begin
                Rin = Rx;
                Rout = Ry;
                ENR = 1;
                ENW = 1;
                Ain = 1;
                Gout = 1;
            end

            //Take the twos-complement of the value in Ry and store to Rx: Rx ← −[Ry]
            else if (INST[7:4] == 0100) begin
                Rin = Ry;
                Rout = Rx;
                ENR = 1;
                ENW = 1;
                Ain = 1;
                Gout = 1;
            end

            //Flip the bits of the value in Ry and store to Rx: Rx ← ∼[Ry]
            else if (INST[7:4] == 0101) begin
                Rin = Ry;
                Rout = Rx;
                ENR = 1;
                ENW = 1;
                Ain = 1;
                Gout = 1;
            end

            //Bit-wise AND the values in Rx and Ry and store the result in Rx: Rx ← [Rx] & [Ry]
            else if (INST[7:4] == 0110) begin
                Rin = Rx;
                Rout = Ry
                ENR = 1;
                ENW = 1;
                Ain = 1;
                Gout = 1;
            end

            
    end

    //! addi Rx
    else if (last_two_bits == 10) begin
        //addi Rx, 6'bIIIIII
        //Add  the  6-bitimmediatevalue  10’b0000IIIIII  (left-padded  with  zeros) 
            //to  the  value  in  Rx  and  store  inRx:  Rx←[Rx] +10’b0000IIIIII
        /*
        if T == 0:
                Ext = 1
            if T == 1:
                ALUcont = <ALU operation for addi>
                Ain = 1
                Gout = 1
        */
    end

    //! subi Rx
    else if (last_two_bits == 11) begin
        //subi Rx, 6'bIIIIII
        //Subtract  the  6-bitimmediatevalue  10’b0000IIIIII  (left-padded  with  zeros) 
            //from  the  value  in  Rx  and  store  inRx:  Rx←[Rx] -10’b0000IIIIII
        /*
        if T == 0:
                Ext = 1
            if T == 1:
                ALUcont = <ALU operation for subi>
                Ain = 1
                Gout = 1
        */
    end

    else if (last_two_bits == 01) begin
        //DO nothing
    end 

    else begin

    end
end



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