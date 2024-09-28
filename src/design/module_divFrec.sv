module module_divFrec (
    input logic clk,                   // Reloj de entrada
    input logic [23:0] Nciclos,        // Número de ciclos para el divisor (ajustado a 24 bits)
    output logic f                     // Señal de salida (frecuencia dividida)
);

    // Señales internas
    logic salida = 1'b0;                      // Señal de salida para dividir la frecuencia
    logic [23:0] cuenta = 24'b0;       // Contador de 24 bits inicializado en 0

    // Proceso secuencial
    always_ff @(posedge clk) begin
        if (cuenta >= Nciclos - 1) begin
            cuenta <= 0;
            salida <= ~salida;          // Invierte la señal de salida
        end else begin
            cuenta <= cuenta + 1;       // Incrementa el contador
        end
    end

    assign f = salida;                  // La señal de salida se asigna a 'f'
endmodule
