//Instruction Register
/*
The 10-bit instruction register is negative-edge triggered with synchronous active-high enable.
This register is used to save the instruction at timestep 0, and maintain the instruction throughout
the multiple clock cycles required to complete a given instruction.
*/


module reg10 (
    input logic [9:0] D ,
    input logic EN , CLKb ,
    output logic [9:0] Q
);



// always_ff @(posedge CLKb) begin
//     if (EN) begin
//         Q <= D;
//     end
// end


endmodule