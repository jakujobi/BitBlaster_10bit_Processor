module d_ff(
    input logic d,
    input logic clk,
    output logic q,
    output logic q_bar
);

logic Qprimary, nclk, nQprimary;
not( nclk , clk);

d_latch primary(
    .d(d),
    .clk(nclk),
    .q(Qprimary),
    .q_bar(nQprimary)
);

d_latch secondary(
    .d(Qprimary),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

endmodule