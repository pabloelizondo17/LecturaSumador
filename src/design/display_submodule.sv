module display(
    input logic [11 : 0] sum_result,
    output logic [6 : 0] units,
    output logic [6 : 0] tens,
    output logic [6 : 0] hundreds,
    output logic [6 : 0] thousands
);

    //Almacena temporalmente cada dígito
    logic [3:0] units_digit;
    logic [3:0] tens_digit;
    logic [3:0] hundreds_digit;
    logic [3:0] thousands_digit;

    always_comb begin
        integer sum_value;
        sum_value = sum_result;

        //Extraer miles
        thousands_digit = sum_value / 1000;
        sum_value = sum_value % 1000;

        ///Extraer centenas
        hundreds_digit = sum_value / 100;
        sum_value = sum_value % 100;

        //Extraer decenas y unidades
        tens_digit = sum_value / 10;
        units_digit = sum_value % 10; 
    end

    //Codificación para el display
    always_comb begin
        case(units_digit)
            4'd0: units = 7'b1111110;
            4'd1: units = 7'b0110000;
            4'd2: units = 7'b1101101;
            4'd3: units = 7'b1111001;
            4'd4: units = 7'b0110011;
            4'd5: units = 7'b1011011;
            4'd6: units = 7'b1011111;
            4'd7: units = 7'b1110000;
            4'd8: units = 7'b1111111;
            4'd9: units = 7'b1110011;
            default: units = 7'b0000000;
        endcase

        case(tens_digit)
            4'd0: tens = 7'b1111110;
            4'd1: tens = 7'b0110000;
            4'd2: tens = 7'b1101101;
            4'd3: tens = 7'b1111001;
            4'd4: tens = 7'b0110011;
            4'd5: tens = 7'b1011011;
            4'd6: tens = 7'b1011111;
            4'd7: tens = 7'b1110000;
            4'd8: tens = 7'b1111111;
            4'd9: tens = 7'b1110011;
            default: tens = 7'b0000000;
        endcase

        case(hundreds_digit)
            4'd0: hundreds = 7'b1111110;
            4'd1: hundreds = 7'b0110000;
            4'd2: hundreds = 7'b1101101;
            4'd3: hundreds = 7'b1111001;
            4'd4: hundreds = 7'b0110011;
            4'd5: hundreds = 7'b1011011;
            4'd6: hundreds = 7'b1011111;
            4'd7: hundreds = 7'b1110000;
            4'd8: hundreds = 7'b1111111;
            4'd9: hundreds = 7'b1110011;
            default: hundreds = 7'b0000000;
        endcase

        case(thousands_digit)
            4'd0: thousands = 7'b1111110;
            4'd1: thousands = 7'b0110000;
            default: thousands = 7'b0000000;
        endcase
    end
endmodule