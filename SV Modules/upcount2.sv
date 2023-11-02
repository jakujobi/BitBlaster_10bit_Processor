module upcount2 (
    input logic CLR,
    input logic CLKb ,
    output logic [1:0] CNT
);


// always_ff @(posedge CLKb or posedge CLR)
// if (CLR) CNT <= 0;
// else CNT <= CNT + 1;

endmodule