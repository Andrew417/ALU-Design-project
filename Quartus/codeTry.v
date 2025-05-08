module ALU (
    input [3:0] a, b,
    input [3:0] sel,
    output reg [7:0] y
);
    always @(*) begin
        case (sel)
            // Arithmetic Unit
            4'b0000: y = a + 1;
            4'b0001: y = b + 1;
            4'b0010: y = a;
            4'b0011: y = b;
            4'b0100: y = a - 1;
            4'b0101: y = a * b;
            4'b0110: y = a + b;
            4'b0111: y = a - b;

            // Logic Unit
            4'b1000: y = ~a + 1;
            4'b1001: y = ~b + 1;
            4'b1010: y = a & b;
            4'b1011: y = a | b;
            4'b1100: y = a ^ b;
		    4'b1101: y = ~(a ^ b);
		    4'b1110: y = ~(a & b);
            4'b1111: y = ~(a | b);  // same as NOR
            default: y = 8'b00000000;
        endcase
    end
endmodule
