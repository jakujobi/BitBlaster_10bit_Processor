
module registerFile (
    input logic [9:0] D,     // Common 10-bit input data
    input logic ENW,         // Write enable
    input logic ENR0,        // Read enable for Q0
    input logic ENR1,        // Read enable for Q1
    input logic CLKb,        // Clock signal (negative edge triggered)
    input logic [1:0] WRA,   // Write address (2-bit)
    input logic [1:0] RDA0,  // Read address for Q0 (2-bit)
    input logic [1:0] RDA1,  // Read address for Q1 (2-bit)
    
    output logic [9:0] Q0,   // Output data for Q0
    output logic [9:0] Q1    // Output data for Q1
);

// Define four 10-bit registers
logic [9:0] registers[3:0];

// Write operation (Clocked)
always_ff @(negedge CLKb) begin
    if (ENW) begin
        registers[WRA] <= D; // Write data into the register specified by WRA
    end
end

//assign Q0 = ENR0 ? registers[RDA0] : 0;
//assign Q1 = ENR1 ? registers[RDA1] : 0;


// Read operation (Combinational)
always_comb begin
    if (ENR0) begin
        Q0 = registers[RDA0]; // Output data from the register specified by RDA0
    end else begin
        Q0 = 10'bz; // High-impedance state if not enabled
    end

    if (ENR1) begin
        Q1 = registers[RDA1]; // Output data from the register specified by RDA1
    end else begin
        Q1 = 10'bz; // High-impedance state if not enabled
    end
end

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

    Read-operation: The read operation of the register file is combinational and does not depend on the active-edge of the clock.
    For each read signal (Q0 or Q1), if ENR is active, the output Q is equal to the value stored in the register associated with read address RDA. If not
    enabled, the register file should disconnect its outputs to avoid contention (i.e., high-impedance ‘Z’).

Warning: you should NOT have an additional 8 registers to implement the second read port; this will cost you points.
Use good engineering design to be able to add a second read port to your design.
*/