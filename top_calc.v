module calc (
    input MAX10_CLK1_50,
    input [9:0] SW,
    input [1:0] KEY,  // Push buttons
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    calculator calc_inst(
        .clk(MAX10_CLK1_50),
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

endmodule