module adder_submodule (
    input logic clk,              // Reloj sincrónico
    input logic reset,            // Señal de reset
    input logic [11:0] number1,   // Primer número (3 dígitos decimales en binario)
    input logic [11:0] number2,   // Segundo número (3 dígitos decimales en binario)
    input logic start_suma,       // Señal que habilita la operación de suma
    output logic [13:0] sum,      // Salida de la suma (hasta 4 dígitos decimales)
    output logic valid            // Señal que indica si la suma está lista
);

    // Registro para almacenar el resultado de la suma
    logic [13:0] sum_reg;
    logic sum_ready;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum_reg <= 14'd0;
            sum_ready <= 1'b0;
        end else if (start_suma) begin
            sum_reg <= number1 + number2;
            sum_ready <= 1'b1;    // La suma está lista
        end else begin
            sum_ready <= 1'b0;
        end
    end

    // Asignaciones de salida
    assign sum = sum_reg;
    assign valid = sum_ready;

endmodule