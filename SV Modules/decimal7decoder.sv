// This module implements a 7-segment decoder that takes a 4-bit 2's complement input and outputs the corresponding 7-segment display output.
module decimal7decoder(
    input [3:0] SW, // 4-bit 2's complement input
    output logic [6:0] numHEX, // 7-segment display output
    output logic [6:0] signHEX // sign bit for negative numbers
);

logic [6:0] seg; // 7-segment display output
logic [6:0] sign; // sign bit for negative numbers

always @(*) begin
    case(SW)
    //Positive numbers
        4'b0000: seg = 7'b1000000; // Display 0
        4'b0001: seg = 7'b1111001; // Display 1
        4'b0010: seg = 7'b0100100; // Display 2
        4'b0011: seg = 7'b0110000; // Display 3
        4'b0100: seg = 7'b0011001; // Display 4
        4'b0101: seg = 7'b0010010; // Display 5
        4'b0110: seg = 7'b0000010; // Display 6
        4'b0111: seg = 7'b1111000; // Display 7
        4'b1000: seg = 7'b0000000; // Display 8
        4'b1001: seg = 7'b0011000; // Display 9
        //
        4'b1010: seg = 7'b0001000; // Display A
        4'b1011: seg = 7'b0000011; // Display B
        4'b1100: seg = 7'b1000110; // Display C
        4'b1101: seg = 7'b0100001; // Display D
        4'b1110: seg = 7'b0000110; // Display E
        4'b1111: seg = 7'b0001110; // Display F

    // Negative numbers
        4'b1111: seg = 7'b1111001; // Display -1
        4'b1110: seg = 7'b0100100; // Display -2
        4'b1101: seg = 7'b0110000; // Display -3
        4'b1100: seg = 7'b0011001; // Display -4
        4'b1011: seg = 7'b0010010; // Display -5
        4'b1010: seg = 7'b0000010; // Display -6
        4'b1001: seg = 7'b1111000; // Display -7
        4'b1000: seg = 7'b0000000; // Display -8
        default: seg = 7'b1111111; // Display nothing
    endcase
end

always @(*) begin
    case (SW)
        4'b1111: sign = 7'b0111111; // Display -1
        4'b1110: sign = 7'b0111111; // Display -2
        4'b1101: sign = 7'b0111111; // Display -3
        4'b1100: sign = 7'b0111111; // Display -4
        4'b1011: sign = 7'b0111111; // Display -5
        4'b1010: sign = 7'b0111111; // Display -6
        4'b1001: sign = 7'b0111111; // Display -7
        4'b1000: sign = 7'b0111111; // Display -8
        default: sign = 7'b1111111; // Display nothing
    endcase
end

assign numHEX = seg; // assign 7-segment display output to HEX0
assign signHEX = sign; // assign sign bit for negative numbers to HEX1

endmodule

// // Improved 7-Segment Decoder Module
// module decimal7decoder (
//     input wire [3:0] SW, // 4-bit 2's complement input
//     output wire [6:0] HEX1, // 7-segment output for numeral
//     output wire [6:0] HEX0  // 7-segment output for sign
// );

//     // Internal signals to hold 7-segment data
//     reg [6:0] seg_data_numeral; // For numeral
//     reg [6:0] seg_data_sign;    // For sign

//     // Active-low 7-segment encoding for numbers 0-9 and '-' sign
//     reg [6:0] seven_seg [11:0]; // Reduced size to 11 as we only use 0-9 and 'A'
    
//     initial begin
//         // Initialize 7-segment encodings
//         seven_seg[0] = 7'b0000001; // 0
//         seven_seg[1] = 7'b1001111; // 1
//         seven_seg[2] = 7'b0010010; // 2
//         seven_seg[3] = 7'b0000110; // 3
//         seven_seg[4] = 7'b1001100; // 4
//         seven_seg[5] = 7'b0100100; // 5
//         seven_seg[6] = 7'b0100000; // 6
//         seven_seg[7] = 7'b0001111; // 7
//         seven_seg[8] = 7'b0000000; // 8
//         seven_seg[9] = 7'b0000100; // 9
//         seven_seg[10] = 7'b0001000; // - (Negative sign)
//     end

//     always @(*) begin
//         // Determine if the number is negative
//         if(SW[3]) begin
//             seg_data_numeral = seven_seg[~SW[2:0] + 4'h1]; // Convert 2's complement to decimal
//             seg_data_sign = seven_seg[10]; // Negative sign
//         end
//         else
        
//         begin
//             seg_data_numeral = seven_seg[SW[2:0]]; // Positive number
//             seg_data_sign = 7'b1111111; // No sign (all segments off)
//         end
//     end

//     // Assign outputs
//     assign HEX1 = seg_data_numeral;
//     assign HEX0 = seg_data_sign;

// endmodule


// // 7-Segment Decoder Module
// module decimal7decoder (
//     input wire [3:0] SW,
//     output wire [6:0] HEX1, // For the numeral
//     output wire [6:0] HEX0  // For the sign
// );

//     reg [6:0] seg_data_numeral; // 7-segment data for numeral
//     reg [6:0] seg_data_sign;    // 7-segment data for sign

//     // Active-low 7-segment encoding for numbers 0-9 and '-' sign
//     reg [6:0] seven_seg [15:0];
    
//     initial begin
//         seven_seg[4'h0] = 7'b0000001; // 0
//         seven_seg[4'h1] = 7'b1001111; // 1
//         seven_seg[4'h2] = 7'b0010010; // 2
//         seven_seg[4'h3] = 7'b0000110; // 3
//         seven_seg[4'h4] = 7'b1001100; // 4
//         seven_seg[4'h5] = 7'b0100100; // 5
//         seven_seg[4'h6] = 7'b0100000; // 6
//         seven_seg[4'h7] = 7'b0001111; // 7
//         seven_seg[4'h8] = 7'b0000000; // 8
//         seven_seg[4'h9] = 7'b0000100; // 9
//         seven_seg[4'hA] = 7'b0001000; // - (Negative sign)
//     end

//     always @(*) begin
//         if(SW[3]) begin // Negative number
//         seg_data_numeral = seven_seg[~SW[2:0] + 4'h1]; // 2's complement to decimal
//         seg_data_sign = seven_seg[4'hA]; // Negative sign
//         end else begin // Positive number
//         seg_data_numeral = seven_seg[SW[2:0]];
//         seg_data_sign = 7'b1111111; // No sign (all segments off)
//         end
//     end

//     assign HEX1 = seg_data_numeral;
//     assign HEX0 = seg_data_sign;

// endmodule