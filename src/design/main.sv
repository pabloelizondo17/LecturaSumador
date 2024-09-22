`timescale 1ns / 1ps

module main #(
    parameter DEBOUNCE_TIME = 20_000_000 // Añade el parámetro aquí
)(
    input clk,                // Reloj del sistema
    input rst,                // Entrada de reset (activo en bajo)
    input [3:0] row,          // Entrada de filas del teclado (4 bits)
    output [3:0] col,         // Salida de columnas del teclado (4 bits)
    output [3:0] button       // Salida del botón (4 bits)
);

// Señales internas
logic [3:0] debounced_row;   // Señales de filas después de debounce

// Instancias del módulo debounce para cada fila
debounce #(
    .DEBOUNCE_TIME(DEBOUNCE_TIME)
) debounce_row0 (
    .clk(clk),
    .rst(rst),
    .btn_in(row[0]),
    .btn_out(debounced_row[0])
);

debounce #(
    .DEBOUNCE_TIME(DEBOUNCE_TIME)
) debounce_row1 (
    .clk(clk),
    .rst(rst),
    .btn_in(row[1]),
    .btn_out(debounced_row[1])
);

debounce #(
    .DEBOUNCE_TIME(DEBOUNCE_TIME)
) debounce_row2 (
    .clk(clk),
    .rst(rst),
    .btn_in(row[2]),
    .btn_out(debounced_row[2])
);

debounce #(
    .DEBOUNCE_TIME(DEBOUNCE_TIME)
) debounce_row3 (
    .clk(clk),
    .rst(rst),
    .btn_in(row[3]),
    .btn_out(debounced_row[3])
);

// Instancias de los módulos teclado
teclado keypad_encoder (
    .rst(rst),
    .clk(clk),
    .row(debounced_row), // Usa las filas debounced
    .col(col),           // Salida de las columnas del teclado
    .button(button)      // Salida del botón
);

endmodule


