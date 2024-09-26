module display_multiplexer(
    input logic clk,   
    input logic reset,           
    input logic [13:0] sum_result,     
    output logic [6:0] segments,        // Código para el display encendido
    output logic [3:0] display_select
);

    logic [3:0] digit_0, digit_1, digit_2, digit_3; // Los cuatro dígitos separados
    logic [3:0] current_digit; // Dígito actual a mostrar en el display activo
    logic [1:0] current_display;    // Define el display que se enciende
    logic [19:0] refresh_counter;   // Controla la velocidad de refresco

    // Se separa cada dígito en registros individuales
    always_comb begin
        digit_0 = sum_result % 10;            // Unidades
        digit_1 = (sum_result / 10) % 10;     // Decenas
        digit_2 = (sum_result / 100) % 10;    // Centenas
        digit_3 = (sum_result / 1000) % 10;   // Miles
    end

    // Contador de refresco
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            refresh_counter <= 0;
            current_display <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_counter == 1000) begin  // Cambia de display cada cierto tiempo
                refresh_counter <= 0;
                current_display <= current_display + 1; // Pasa al siguiente display
            end
        end
    end

    // Lógica para seleccionar el display activo y enviarle el dígito correspondiente
    always_comb begin
        case(current_display)
            // Enciende el primer display y muestra las unidades
            2'b00: begin
                display_select = 4'b1110; 
                current_digit = digit_0;
            end
            // Enciende el segundo display y muestra las decenas
            2'b01: begin
                display_select = 4'b1101;
                current_digit = digit_1;
            end
            // Enciende el tercer display y muestra las centenas
            2'b10: begin
                display_select = 4'b1011;
                current_digit = digit_2;
            end
            // Enciende el cuarto display y muestra los miles
            2'b11: begin
                display_select = 4'b0111;
                current_digit = digit_3;
            end
        endcase
        segments = digit_to_segment(current_digit); // Convierte el dígito actual al código del display
    end

    // Genera la codificación necesaria para el display
    function logic [6:0] digit_to_segment(input logic [3:0] digit);
        case(digit)
            4'd0: digit_to_segment = 7'b1111110;
            4'd1: digit_to_segment = 7'b0110000;
            4'd2: digit_to_segment = 7'b1101101;
            4'd3: digit_to_segment = 7'b1111001;
            4'd4: digit_to_segment = 7'b0110011;
            4'd5: digit_to_segment = 7'b1011011;
            4'd6: digit_to_segment = 7'b1011111;
            4'd7: digit_to_segment = 7'b1110000;
            4'd8: digit_to_segment = 7'b1111111;
            4'd9: digit_to_segment = 7'b1110011;
            default: digit_to_segment = 7'b0000000;
        endcase
    endfunction
endmodule