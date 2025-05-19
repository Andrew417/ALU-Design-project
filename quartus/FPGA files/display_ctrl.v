module display_ctrl #(
    parameter cdbits = 18,      // clock divider bits
                                // Clock freq.  bits
                                //       50MHz  18
                                //      100MHz  19
                                //      200MHz  20
                                //      400MHz  21
                                //      800MHz  22    etc.
    parameter hex = 0           // output hexadecimal format
                                //   0 - decimal only (display invalid as "-")
                                //   1 - hexadecimal (0123456789AbCdEf)
    )(
    input wire ck,              // system clock
    input wire sel,             // 1: displays binary
                                // 0: displays decimal

    input wire [3:0] x3,        // display digits, from left to right
    input wire [3:0] x2,
    input wire [3:0] x1,
    input wire [3:0] x0,
    output reg [0:6] seg,       // 7-segment output
    output reg [3:0] an        // anode output
    );

    // Internal signals
    reg [cdbits-1:0] counter = 'd0;    // clock divider counter
    reg [3:0] d;                       // 7-seg converter input

    // Clock divider
    always @(posedge ck)
        counter = counter + 1;

    // Anode signal decoder
    always @*
        case (counter[cdbits-1:cdbits-2])
        2'd0: an = 4'b1110;
        2'd1: an = 4'b1101;
        2'd2: an = 4'b1011;
        2'd3: an = 4'b0111;
        endcase

    // 7-seg converter multiplexer
    always @*
        case (counter[cdbits-1:cdbits-2])
        2'd0: d = (sel)? {3'b0,x0[0]} : x0;
        2'd1: d = (sel)? {3'b0,x0[1]} : x1;
        2'd2: d = (sel)? {3'b0,x0[2]} : x2;
        2'd3: d = (sel)? {3'b0,x0[3]} : x3;
        endcase

    // 7-seg converter
    always @*
        case (d)
        4'h0: seg = (counter[cdbits-1:cdbits-2] == 3 && sel)? 7'b0000001 : (counter[cdbits-1:cdbits-2] != 3)? 7'b0000001 : 7'b1111111; 
        4'h1: seg = (counter[cdbits-1:cdbits-2] == 3 && sel)? 7'b1001111 : (counter[cdbits-1:cdbits-2] != 3)? 7'b1001111 : 7'b1111110;
        4'h2: seg = 7'b0010010;
        4'h3: seg = 7'b0000110;
        4'h4: seg = 7'b1001100;
        4'h5: seg = 7'b0100100;
        4'h6: seg = 7'b0100000;
        4'h7: seg = 7'b0001111;
        4'h8: seg = 7'b0000000;
        4'h9: seg = 7'b0000100;
        4'ha: seg = hex ? 7'b0001000 : 7'b1111110;
        4'hb: seg = hex ? 7'b1100000 : 7'b1111110;
        4'hc: seg = hex ? 7'b0110001 : 7'b1111110;
        4'hd: seg = hex ? 7'b1000010 : 7'b1111110;
        4'he: seg = hex ? 7'b0110000 : 7'b1111110;
        default: seg = hex ? 7'b0111000 : 7'b1111110; // F
        endcase

endmodule // display ctrl