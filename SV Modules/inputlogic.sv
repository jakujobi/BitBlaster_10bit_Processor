module inputlogic (
    input logic [9:0] RawData,
    input logic Peek_key,
    input logic 50MHz,
    input logic RawCLK,
    input Extrn_Enable,

    output logic [9:0] databus,
    output logic [1:0] data2bit,
    output logic CLKb,
    output logic PeeKb,
);

//Debounce the keys__________________________________________
debouncer peek_debouncer (
    .A_noisy(Peek_key),
    .CLK50M(50MHz),
    .A(PeeKb)
);

debouncer clk_debouncer (
    .A_noisy(RawCLK),
    .CLK50M(50MHz),
    .A(CLKb)
);

//splice the lowest 2 bits
assign data2bit = RawData[1:0];

//if extrn is enabled, assign raw data to databus
assign databus = Extrn_Enable ? RawData : 0;


endmodule