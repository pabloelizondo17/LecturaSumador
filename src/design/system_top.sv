module system_top (
    input logic clk,
    input logic [3:0] btn_input,
    output logic [3:0] f_out,
    output logic [6:0] seg7_out,
    output logic L_out
);

    teclado u_teclado (
        .clk(clk),
        .c(btn_input),
        .f(f_out),
        .seg7_out(seg7_out),
        .L_out(L_out)
    );

endmodule
