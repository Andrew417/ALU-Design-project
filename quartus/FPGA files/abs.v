module abs (A,sign,abs_A);
    input  [7:0] A;     //4-bit signed input
    output [7:0] abs_A; //the absulte value of input A
    output       sign;  //the sign of input A

    assign sign = A[7];
    assign abs_A = (sign)? ~(A +8'b11111111) : A;


endmodule