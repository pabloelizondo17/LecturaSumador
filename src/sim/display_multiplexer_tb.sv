`timescale 1ns / 1ps

module display_multiplexer_tb;

    // Señales de entrada y salida
    logic clk;   
    logic reset;           
    logic [13:0] sum_result;     
    logic [6:0] segments;        
    logic [3:0] display_select;

    // Instancia del módulo a probar
    display_multiplexer uut (
        .clk(clk),
        .reset(reset),
        .sum_result(sum_result),
        .segments(segments),
        .display_select(display_select)
    );

    // Generación del reloj
    always #5 clk = ~clk; // Periodo de 10 unidades de tiempo (simuladas)

    // Bloque inicial
    initial begin
        // Inicializa las señales
        clk = 0;
        reset = 1;
        sum_result = 14'b0;

        // Inicia el archivo VCD para ver en un simulador de señales
        $dumpfile("display_multiplexer.vcd");
        $dumpvars(0, display_multiplexer_tb);

        // Espera unos ciclos y luego quita el reset
        #10 reset = 0;

        // Test con el primer número binario (espera suficiente tiempo para recorrer todos los displays)
        sum_result = 14'b00000000001100;  // Prueba con el binario de 12
        #29900; // Simula más tiempo para que el multiplexor muestre todos los dígitos

        // Test con el segundo número binario
        sum_result = 14'b00001111100111;  // Prueba con el binario de 999
        #29900; // Simula más tiempo para que el multiplexor muestre todos los dígitos

        // Finaliza la simulación
        $finish;
    end

    // Monitoreo de las salidas: solo imprime cuando cambian las señales de interés
    initial begin
        $monitor("Time = %0t, sum_result = %b, display_select = %b, segments = %b", 
                 $time, sum_result, display_select, segments);
    end

    // Imprimir solo cuando el display_select cambia
    always @(posedge clk) begin
        if (display_select !== uut.display_select || segments !== uut.segments) begin
            $display("Time = %0t, sum_result = %b, display_select = %b, segments = %b", 
                     $time, sum_result, display_select, segments);
        end
    end
endmodule
