module d_latch(
    input logic d,
    input logic clk,
    output logic q,
    output logic q_bar
);


logic DandCLK, DnandCLK;

assign DandCLK = d & clk;
assign DnandCLK = ~d & clk;

sr_latch latch (
    .s (DandCLK), //s: 1-bit input signal
    .r (DnandCLK), //r: 1-bit input signal
    .q (q), //q: 1-bit output signal
    .q_bar (q_bar) //q_bar: 1-bit output signal
);


endmodule