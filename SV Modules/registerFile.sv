module registerFile (
    input logic [9:0] D ,
    input logic ENW ,
    input logic ENR0,
    input logic ENR1 ,
    input logic CLKb ,
    input logic [1:0] WRA,
    input logic [1:0] RDA0,
    input logic [1:0] RDA1,
    
    output logic [9:0] Q0,
    output logic [9:0] Q1
);




endmodule


/*
Similar to the in-class example, the register for this processor will contain eight 10-bit registers.
Each register shares a common 10-bit input (D), and share two common 10-bit data outputs (Q0
and Q1).
- To determine which register (if any) should be saving the input data and driving the
output signals, there are three 3-bit address inputs and three enable inputs.
- The operation of the register file is as follows:
    Write-operation: On the active-edge of the debounced clock signal CLKb, if ENW is active,
    then the register associated with the write address WRA saves the value on the D input.

    Read-operation: The read operation of the register file is combinational and does not depend on the active-edge of the clock.
    For each read signal (Q0 or Q1), if ENR is active, the output Q is equal to the value stored in the register associated with read address RDA. If not
    enabled, the register file should disconnect its outputs to avoid contention (i.e., high-impedance ‘Z’).

Warning: you should NOT have an additional 8 registers to implement the second read port; this will cost you points.
Use good engineering design to be able to add a second read port to your design.
*/