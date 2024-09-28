`timescale 1ns / 1ps

module module_divFrec_tb;

// Señales para el testbench
logic clk;                   // Señal de reloj
logic [23:0] Nciclos;        // Número de ciclos para el divisor
logic f;                     // Señal de salida (frecuencia dividida)

// Parámetro para controlar el período del reloj
parameter CLK_PERIOD = 37;   // Período del reloj en nanosegundos (27 MHz)

// Instancia del módulo divisor de frecuencia
module_divFrec uut (
    .clk(clk),
    .Nciclos(Nciclos),
    .f(f)
);

// Generador del reloj
initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk; // Genera un reloj de 27 MHz (10 ns de período)
end

// Proceso para aplicar estímulos
initial begin
    // Inicialización
    Nciclos = 24'd13500; // Establece un valor inicial de 5400 ciclos
    #100; // Espera 100 ns para la inicialización del sistema

    // Cambia el valor de Nciclos durante la simulación
    //#5000 Nciclos = 24'd5400;  //   Mantiene 5400 ciclos después de 5000 ns
    //#7000 Nciclos = 24'd1000;  // Cambia a 1000 ciclos después de otros 5000 ns
    //#9000 Nciclos = 24'd2000;  // Cambia a 2000 ciclos después de otros 5000 ns
    //#11000 Nciclos = 24'd5400;   // Cambia de nuevo a 5400 ciclos
    //#13000 Nciclos = 24'd13500; // Cambia de nuevo a 13500 ciclos para 1 kHz

    // Finaliza la simulación
    #10000000; 
    $finish;
end

// Monitoreo de señales
initial begin
    $monitor("Time = %0t ns, Nciclos = %0d, f = %b", $time, Nciclos, f);
end

initial begin
        $dumpfile("module_divFrec_tb.vcd");
        $dumpvars(0, module_divFrec_tb);
end

endmodule

