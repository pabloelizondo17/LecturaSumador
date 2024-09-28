module div_frec (
    input logic clk,
    input integer Nciclos,
    output logic f
);

    logic salida;
    integer cuenta = 0;

    always_ff @(posedge clk) begin
        if (cuenta >= Nciclos - 1) begin
            cuenta <= 0;
            salida <= ~salida;
        end else begin
            cuenta <= cuenta + 1;
        end
    end

    assign f = salida;

endmodule
