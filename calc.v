module calculator(
    input clk,
    input [9:0] SW,
    input [1:0] KEY,  // KEY[0] and KEY[1] for latching numbers
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    reg [7:0] operandA, operandB;
    wire [1:0] operation = SW[9:8];
    
    reg [15:0] result;
    reg [15:0] display_value;  // Changed to 16-bit for multiplication
    
    // Latch numbers using push buttons
    always @(posedge clk) begin
        if (~KEY[0]) begin  // KEY[0] pressed - latch first number
            operandA <= SW[7:0];
        end
        if (~KEY[1]) begin  // KEY[1] pressed - latch second number  
            operandB <= SW[7:0];
        end
    end
    
    // Perform operations
    always @(*) begin
        case(operation)
            2'b00: result = {8'b0, operandA} + {8'b0, operandB}; // A + B
            2'b01: result = {8'b0, operandA} - {8'b0, operandB}; // A - B
            2'b10: result = operandA * operandB;                // A * B
            2'b11: result = (operandB != 0) ? {8'b0, (operandA / operandB)} : 16'b0; // A / B
        endcase
    end
    
    // Display the full 16-bit result for all operations
    always @(*) begin
        display_value = result;
    end
    
    // Display configuration:
    // HEX0-HEX1: Result LOW byte
    // HEX2-HEX3: Result HIGH byte (for multiplication)
    // HEX4: Operand B (latched)
    // HEX5: Operand A (latched)
    
    seg7_display seg0(.in(display_value[3:0]), .out(HEX0));
    seg7_display seg1(.in(display_value[7:4]), .out(HEX1));
    seg7_display seg2(.in(display_value[11:8]), .out(HEX2));
    seg7_display seg3(.in(display_value[15:12]), .out(HEX3));
    seg7_display seg4(.in(operandB[3:0]), .out(HEX4));
    seg7_display seg5(.in(operandB[7:4]), .out(HEX5));

endmodule