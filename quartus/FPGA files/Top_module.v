module digital_tube_decoder (clk,A,sel, seg, an);
    //inputs declaration
    input       clk;  //system clock
    input [7:0] A;    //8-bit input
    input       sel;  //0: displayes 8-bit signed decimal
                      //1: displayes 4-bit binary 
    //outputs declaration
    output [0:6] seg;   //7-seg output
    output [3:0] an;    //anode output

    //internal wires declaration
    wire sign;
    wire [7:0] abs_A;
    wire [3:0] ONES,TENS, HUNDS;

    //instance of absolute module
    abs abs(.A(A),
            .sign(sign),
            .abs_A(abs_A)
            );

    //instance of binary to BCD converter
    binary_to_BCD binary_to_BCD (.A(abs_A),
                                 .ONES(ONES),
                                 .TENS(TENS),
                                 .HUNDREDS(HUNDS)
                                 );

    //instance of 7-seg control
    display_ctrl #(18,0) seven_seg_ctrl (.ck(clk),
                                         .sel(sel),
                                         .x3({3'b000,sign}),
                                         .x2(HUNDS),
                                         .x1(TENS),
                                         .x0((sel)? A[3:0] : ONES),
                                         .seg(seg),
                                         .an(an)
                                         );


    
endmodule