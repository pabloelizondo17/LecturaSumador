`timescale 1ns / 1ps

module top_module_tb;

    // Señales para el testbench
    logic clk;
    logic reset;
    logic [3:0] dip_switch;
    logic input_ready1;
    logic input_ready2;
    logic [6:0] segments;
    logic [3:0] display_select;

    // Instancia del módulo `Top`
    top_module uut (
        .clk(clk),
        .reset(reset),
        .dip_switch(dip_switch),
        .input_ready1(input_ready1),
        .input_ready2(input_ready2),
        .segments(segments),
        .display_select(display_select)
    );

    // Generador del reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Periodo de reloj de 10 ns
    end

    // Simulación de estímulos
    initial begin
        reset = 1;
        dip_switch = 4'b0000;
        input_ready1 = 0;
        input_ready2 = 0;
        #10 reset = 0;

        // Primera entrada de datos (número 1)
        dip_switch = 4'd2;  // Centenas
        input_ready1 = 1;
        #10 input_ready1 = 0;

        dip_switch = 4'd3;  // Decenas
        input_ready1 = 1;
        #10 input_ready1 = 0;

        dip_switch = 4'd4;  // Unidades
        input_ready1 = 1;
        #10 input_ready1 = 0;

        // Segunda entrada de datos (número 2)
        dip_switch = 4'd5;  // Centenas
        input_ready2 = 1;
        #10 input_ready2 = 0;

        dip_switch = 4'd6;  // Decenas
        input_ready2 = 1;
        #10 input_ready2 = 0;

        dip_switch = 4'd7;  // Unidades
        input_ready2 = 1;
        #10 input_ready2 = 0;

        // Esperar el resultado
        #100;
        $finish;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time = %0t, dip_switch = %b, input_ready1 = %b, input_ready2 = %b, segments = %b, display_select = %b",
                 $time, dip_switch, input_ready1, input_ready2, segments, display_select);
    end

endmodule
