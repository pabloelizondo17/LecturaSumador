module display_multiplexer(
    input logic clk,
    input logic reset,
    input logic [11:0] sum_result,                    // Resultado con 12 bits máximo
    output logic [6:0] segments,                      // Código para los displays
    output logic [3:0] display_select                 // Indica el display activo
);
    logic [3:0] units, tens, hundreds, thousands;     // Guarda unidades, decenas, centenas y miles
    logic [1:0] current_display = 2'b0;               // Código del display activo
    logic [19:0] refresh_counter = 19'b0;             // Contador de refresco

    // Separación de cifras
    always_comb begin
        thousands = sum_result / 1000;                // Separa miles
        hundreds = (sum_result % 1000) / 100;         // Separa centenas
        tens = (sum_result % 100) / 10;               // Separa decenas
        units = sum_result % 10;                      // Separa unidades
    end
    //double dabble

    always_ff @(posedge clk or posedge reset) begin   // Contador de refresco
        if (reset) begin
            refresh_counter <= 0;
            current_display <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_counter == 10000) begin
                refresh_counter <= 0;
                current_display <= current_display + 1;
            end
        end
    end

    always_comb begin
        case(current_display)
            2'b00: display_select = 4'b1110;          // Display para unidades
            2'b01: display_select = 4'b1101;          // Display para decenas
            2'b10: display_select = 4'b1011;          // Display para centenas
            2'b11: display_select = 4'b0111;          // Display para miles
            default: display_select = 4'b1111; 
        endcase
    end
    
    always_comb begin                                 // Asigna el código para el display
        segments = 7'b0000000;
        case(display_select)
            4'b1110: segments = display_to_segments(units);
            4'b1101: segments = display_to_segments(tens);
            4'b1011: segments = display_to_segments(hundreds);
            4'b0111: segments = display_to_segments(thousands);
            default: segments = 7'b0000000;
        endcase
    end

    function [6:0] display_to_segments(input logic [3:0] digit);
        case(digit)
            4'd0: display_to_segments = 7'b1111110;
            4'd1: display_to_segments = 7'b0110000;
            4'd2: display_to_segments = 7'b1101101; 
            4'd3: display_to_segments = 7'b1111001;
            4'd4: display_to_segments = 7'b0110011; 
            4'd5: display_to_segments = 7'b1011011;
            4'd6: display_to_segments = 7'b1011111; 
            4'd7: display_to_segments = 7'b1110000;
            4'd8: display_to_segments = 7'b1111111; 
            4'd9: display_to_segments = 7'b1110011; 
            default: display_to_segments = 7'b0000000;
        endcase
    endfunction
endmodule