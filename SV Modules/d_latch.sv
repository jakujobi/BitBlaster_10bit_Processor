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















// assign r = ~d & clk;
// assign s = d & clk;
// assign  q = ~(r | q_bar);
// assign q_bar = ~(s | q);

// module d_latch(
//     input logic d,
//     input logic clk,
//     output logic q,
//     output logic q_bar
// );

//     logic and_out, nand_out;

//     and gate1(d, enable, and_out);
//     nand gate2(and_out, clk, nand_out);
//     nand gate3(nand_out, clk, q);
//     nand gate4(and_out, clk, q_bar);

// endmodule



// module d_latch(
//     input logic d,
//     input logic clk,
//     input logic enable,
//     output logic q, q_bar);

//     always_comb begin
//         if (enable) begin
//             q = d;
//             q_bar = ~d;
//         end
//     end

// endmodule


endmodule