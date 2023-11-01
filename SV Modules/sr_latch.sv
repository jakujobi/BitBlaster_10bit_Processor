module sr_latch(
    input s, r,
    output reg q, q_bar
);

// assign q = s | q_bar;
// assign q_bar = r | ~q;


assign  q = ~(r | q_bar);
assign q_bar = ~(s | q);


// module sr_latch(
//         input s, r, clk,
//         output reg q, q_bar
//         );

// always @(posedge clk) begin
//     if (s && !r) begin
//         q <= 1;
//         q_bar <= 0;
//     end
    
//     else if (!s && r) begin
//         q <= 0;
//         q_bar <= 1;
//     end
    
//     else if (s && r) begin
//         // Invalid state, do nothing
//     end
// end

// endmodule


endmodule