module teclado (
    input logic clk,
    input logic [3:0] c,
    output logic [3:0] f,
    output logic [6:0] seg7_out,
    output logic L_out
);

    logic fr, far, b;
    logic [3:0] reg_tecla = 4'b0001;
    logic [3:0] bcd, cl;
    logic [7:0] col_fil;

    // Instanciación de los módulos de división de frecuencia y anti-rebote
    div_frec df1 (.clk(clk), .Nciclos(10000), .f(far));
    div_frec df2 (.clk(clk), .Nciclos(125000), .f(fr));

    generate
        for (genvar i = 0; i < 4; i++) begin
            anti_rebote antr (.clk(far), .btn(c[i]), .bto(cl[i]));
        end
    endgenerate

    always_ff @(posedge fr) begin
        reg_tecla <= {reg_tecla[2:0], reg_tecla[3]};
    end

    assign b = cl[0] | cl[1] | cl[2] | cl[3];

    always_ff @(posedge b) begin
        col_fil <= {c, reg_tecla};
    end

    always_comb begin
        case (col_fil)
            8'b01000001: bcd = 4'b0000;
            8'b10001000: bcd = 4'b0001;
            8'b01001000: bcd = 4'b0010;
            8'b00101000: bcd = 4'b0011;
            8'b10000100: bcd = 4'b0100;
            8'b01000100: bcd = 4'b0101;
            8'b00100100: bcd = 4'b0110;
            8'b10000010: bcd = 4'b0111;
            8'b01000010: bcd = 4'b1000;
            8'b00100010: bcd = 4'b1001;
            8'b00011000: bcd = 4'b1010;
            8'b00010100: bcd = 4'b1011;
            8'b00010010: bcd = 4'b1100;
            8'b10000001: bcd = 4'b1101;
            8'b00100001: bcd = 4'b1110;
            8'b00010001: bcd = 4'b1111;
            default: bcd = 4'b0000;
        endcase
    end

    // Decodificador BCD a 7 segmentos
    deco_BCD_seg7 bcd_seg7 (.bcd(bcd), .seg7(seg7_out));

    assign f = reg_tecla;
    assign L_out = 1'b0;

endmodule


