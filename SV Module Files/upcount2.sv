module upcount2 (
    input logic CLR,      // Active-high synchronous clear signal
    input logic CLKb,     // Clock signal (negative edge triggered)

    output logic [1:0] CNT // 2-bit counter output
);

// The counter logic
// It increments on the negative edge of CLKb and resets to 0 when CLR is high
always_ff @(negedge CLKb or posedge CLR) begin
    if (CLR) begin
        // Reset counter to 0 when CLR is high
        CNT <= 2'b00;
    end else begin
        // Increment counter on the negative edge of CLKb
        CNT <= CNT + 1'b1;
    end
end

endmodule

// always_ff @(posedge CLKb or posedge CLR)
// if (CLR) CNT <= 0;
// else CNT <= CNT + 1;


/*
A negative-edge triggered 2-bit up-counter with active-high synchronous clear is used to keep track of the timestep of the current instruction.
*/

/*
1. **Negative-Edge Triggered Counting**: The counter is set to increment on the negative edge of the clock (`negedge CLKb`).
    This means that the counter will increment its value whenever the clock signal transitions from high to low.

2. **Active-High Synchronous Clear**: The counter resets to 0 (`2'b00`) whenever the clear signal (`CLR`) is high.
    This reset happens synchronously with the clock signal.

3. **2-Bit Counter**: The counter (`CNT`) is a 2-bit output, which means it can count from 0 to 3 (00, 01, 10, 11 in binary).

4. **Sequential Logic Implementation**: The `always_ff` block is used for sequential logic, which is appropriate for counters.
    The sensitivity list includes `negedge CLKb` and `posedge CLR`, ensuring the counter reacts to the falling edge of the clock and the rising edge of the clear signal.
*/