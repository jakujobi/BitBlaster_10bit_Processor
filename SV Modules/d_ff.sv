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
















// module d_ff(
//     input logic D,
//     input logic clk,
//     input logic reset,
//     output logic Q,
//     output logic Q_bar
// );

//     logic d_not;
//     not_gate not1(.in(D), .out(d_not));
//     and_gate and1(.in1(d_not), .in2(clk), .out(Q));
//     and_gate and2(.in1(D), .in2(clk), .out(Q_bar));
//     always_comb begin
//         if (reset) begin
//             Q <= 0;
//             Q_bar <= 1;
//         end
//     end
// endmodule

// // not_gate module
// module not_gate(
//     input logic in,
//     output logic out
// );
//     assign out = ~in;
// endmodule

// // and_gate module
// module and_gate(
//     input logic in1,
//     input logic in2,
//     output logic out
// );
//     assign out = in1 & in2;
// endmodule




// module d_ff(
//     input logic D,
//     input logic clk,
//     input logic reset,
//     output logic Q,
//     output logic Q_bar);

//     always_ff @(posedge clk, posedge reset) begin
//         if (reset) begin
//             Q <= 0;
//             Q_bar <= 1;
//         end else begin
//             Q <= D;
//             Q_bar <= ~D;
//         end
//     end
// endmodule




endmodule