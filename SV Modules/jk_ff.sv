module jk_ff (
    input j, k, clk,
    output reg q,
    output reg q_bar
);

logic jandq_bar, kn, knandq, jandq_barorknandq;
// jandq_bar = j & q_bar
// kn = ~k
// knandq = kn & q
// jandq_barorknandq = jandq_bar | knandq

assign jandq_bar = j & q_bar;
assign kn = ~k;
assign knandq = kn & q;
assign jandq_barorknandq = jandq_bar | knandq;

d_ff module1 (
    .d(jandq_barorknandq),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// module jk_ff (
//     input j, k, clk,
//     output reg q,
//     output reg q_bar
// );

//     always @(posedge clk) begin
//         if (j && !k) begin
//             q <= 1;
//             q_bar <= 0;
//         end else if (!j && k) begin
//             q <= 0;
//             q_bar <= 1;
//         end else if (j && k) begin
//             q <= ~q;
//             q_bar <= ~q_bar;
//         end
//     end

// endmodule


endmodule
