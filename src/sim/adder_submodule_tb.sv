`timescale 1ns/1ps

module adder_submodule_tb;

    // Señales para probar el módulo adder_submodule
    logic clk;
    logic reset;
    logic [11:0] number1;       // Primer número de 3 dígitos decimales
    logic [11:0] number2;       // Segundo número de 3 dígitos decimales
    logic start_suma;           // Señal para iniciar la suma
    logic [13:0] sum;           // Resultado de la suma (hasta 4 dígitos decimales)
    logic valid;                // Señal que indica si la suma está lista

    // Instancia del módulo bajo prueba (UUT - Unit Under Test)
    adder_submodule uut (
        .clk(clk),
        .reset(reset),
        .number1(number1),
        .number2(number2),
        .start_suma(start_suma),
        .sum(sum),
        .valid(valid)
    );

    // Generar la señal de reloj (clk)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Alternar el valor del reloj cada 5 unidades de tiempo (10 ns de período total)
    end

    // Proceso de simulación
    initial begin
        // Inicializar las señales
        reset = 1;               // Activar reset al inicio
        start_suma = 0;
        number1 = 12'd0;
        number2 = 12'd0;

        // Esperar algunos ciclos de reloj
        #10;
        reset = 0;               // Desactivar reset después de 10 ns
        #10;

        // Probar la suma de algunos números

        // Caso 1: Suma de 123 + 456
        number1 = 12'd123;
        number2 = 12'd456;
        start_suma = 1;
        #10 start_suma = 0;      // Detener el start después de 1 ciclo
        #10;
        wait (valid);            // Esperar hasta que la suma esté lista
        $display("Suma 123 + 456 = %d", sum);
        #10;

        // Caso 2: Suma de 999 + 999 (caso borde)
        number1 = 12'd999;
        number2 = 12'd999;
        start_suma = 1;
        #10 start_suma = 0;      // Detener el start después de 1 ciclo
        #10;
        wait (valid);            // Esperar hasta que la suma esté lista
        $display("Suma 999 + 999 = %d", sum);
        #10;

        // Caso 3: Suma de 234 + 765
        number1 = 12'd234;
        number2 = 12'd765;
        start_suma = 1;
        #10 start_suma = 0;      // Detener el start después de 1 ciclo
        #10;
        wait (valid);            // Esperar hasta que la suma esté lista
        $display("Suma 234 + 765 = %d", sum);
        #10;

        // Caso 4: Suma de 567 + 432
        number1 = 12'd567;
        number2 = 12'd432;
        start_suma = 1;
        #10 start_suma = 0;      // Detener el start después de 1 ciclo
        #10;
        wait (valid);            // Esperar hasta que la suma esté lista
        $display("Suma 567 + 432 = %d", sum);
        #10;

        // Finalizar simulación
        $stop;
    end

    // Generar el archivo dumpfile para ver las señales en una herramienta gráfica (como GTKWave)
    initial begin
        $dumpfile("adder_submodule_tb.vcd"); // Nombre del archivo VCD
        $dumpvars(1, clk, reset, number1, number2, start_suma, sum, valid);    // Volcar todas las señales del testbench
    end

endmodule
