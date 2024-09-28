module anti_rebote (
    input logic clk,
    input logic btn,
    output logic bto
);

    logic [7:0] reg_rebote;

    always_ff @(posedge clk) begin
        reg_rebote <= {reg_rebote[6:0], btn};
    end

    assign bto = (reg_rebote == 8'hFF) ? 1'b1 : 1'b0;

endmodule

