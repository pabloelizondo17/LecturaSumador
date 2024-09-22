`timescale 1ns / 1ps

module main_tb;

// Parámetros del reloj
parameter CLK_PERIOD = 10; // Período del reloj en nanosegundos
parameter DEBOUNCE_TIME = 20_000_000; // Tiempo de debounce
// Señales del testbench
logic clk;
logic rst;
logic [3:0] row;
logic [3:0] col;
logic [3:0] button;

// Instancia del módulo principal
main #(
    .DEBOUNCE_TIME(DEBOUNCE_TIME)
) uut (
    .clk(clk),
    .rst(rst),
    .row(row),
    .col(col),
    .button(button)
);

// Generador del reloj
initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
end

// Generador del reset y estímulo
initial begin
    $dumpfile("simulation.vcd"); // Nombre del archivo VCD
    $dumpvars(0, main_tb);        // Registrar todas las señales en el módulo tb_main

    rst = 1;
    row = 4'b1111; // Inicializa row como 1111
    #100; // Mantener reset activo por 100 ns
    rst = 0;

    // Prueba de botones
    // Prueba con fila 0 (row[0])
    #50 row = 4'b1110; // Simula presión de botón en la primera fila
    #200 row = 4'b1111; // Liberar botón
    #100; // Esperar

    // Prueba con fila 1 (row[1])
    #50 row = 4'b1101; // Simula presión de botón en la segunda fila
    #200 row = 4'b1111; // Liberar botón
    #100; // Esperar

    // Prueba con fila 2 (row[2])
    #50 row = 4'b1011; // Simula presión de botón en la tercera fila
    #200 row = 4'b1111; // Liberar botón
    #100; // Esperar

    // Prueba con fila 3 (row[3])
    #50 row = 4'b0111; // Simula presión de botón en la cuarta fila
    #200 row = 4'b1111; // Liberar botón
    #100; // Esperar

    // Finalizar simulación
    #100;
    $finish;
end

// Monitoreo de señales
initial begin
    $monitor("Time = %0t, row = %b, col = %b, button = %b", $time, row, col, button);
end

endmodule
