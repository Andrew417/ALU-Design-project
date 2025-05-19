module ALU (
    input clk,          // Clock for flip-flops
    input rst_n,          // Reset
    input signed [3:0] a, b,
    input [3:0] sel,
    output reg signed [7:0] y
);

// Internal flip-flops for inputs/outputs
reg signed [3:0] a_ff, b_ff;
reg signed [7:0] y_ff;
reg [3:0] sel_ff;

// Flip-flop assignments
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin     
        a_ff <= 0;
        b_ff <= 0;
       // sel_ff <= 0;
        y <= 0;
    end else begin
        a_ff <= a;
        b_ff <= b;
        sel_ff <= sel;
        y <= y_ff;
    end
end

// ALU Logic
always @(*) begin
    case (sel_ff)
        // Arithmetic Unit (sel[3] = 0)
        4'b0000: y_ff = a_ff + 1;              // Increment a
        4'b0001: y_ff = b_ff + 1;              // Increment b
        4'b0010: y_ff = a_ff;                  // Transfer a
        4'b0011: y_ff = b_ff;                  // Transfer b
        4'b0100: y_ff = a_ff - 1;              // Decrement a
        4'b0101: y_ff = a_ff * b_ff;           // Multiply (truncated to 4 bits)
        4'b0110: y_ff = a_ff + b_ff;           // Add
        4'b0111: y_ff = a_ff - b_ff;           // Subtract (assumes a >= b)
        
        // Logic Unit (sel[3] = 1)
        4'b1000: y_ff = ~a_ff;                 // 1's complement a
        4'b1001: y_ff = ~b_ff;                 // 1's complement b
        4'b1010: y_ff = a_ff & b_ff;           // AND
        4'b1011: y_ff = a_ff | b_ff;           // OR
        4'b1100: y_ff = a_ff ^ b_ff;           // XOR
        4'b1101: y_ff = ~(a_ff ^ b_ff);        // XNOR
        4'b1110: y_ff = ~(a_ff & b_ff);        // NAND
        4'b1111: y_ff = ~(a_ff | b_ff);        // NOR
        default: y_ff = 0;
    endcase
end

endmodule