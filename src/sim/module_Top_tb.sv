`timescale 1ns / 1ps

module top_module_tb;

    // Señales
    logic clk;
    logic reset;
    logic [3:0] dip_switch;
    logic input_ready1;
    logic input_ready2;
    logic [6:0] segments;
    logic [3:0] display_select;

    // Instanciar el módulo top_module
    top_module uut (
        .clk(clk),
        .reset(reset),
        .dip_switch(dip_switch),
        .input_ready1(input_ready1),
        .input_ready2(input_ready2),
        .segments(segments),
        .display_select(display_select)
    );

    // Generar el reloj (clock) con un periodo de 10 ns
    always #5 clk = ~clk;

    // Secuencia de prueba
    initial begin
        // Inicializar señales
        clk = 0;
        reset = 1;
        input_ready1 = 0;
        input_ready2 = 0;
        dip_switch = 4'b0000;

        // Liberar el reset después de 20 ns
        #20 reset = 0;

        // Primera entrada de datos (primer número)
        #10 dip_switch = 4'd1;  // Ingresar 1 como centenas
        input_ready1 = 1;
        #10 input_ready1 = 0;

        #10 dip_switch = 4'd1;  // Ingresar 1 como decenas
        input_ready1 = 1;
        #10 input_ready1 = 0;

        #10 dip_switch = 4'd7;  // Ingresar 1 como unidades
        input_ready1 = 1;
        #10 input_ready1 = 0;

        // Segunda entrada de datos (segundo número)
        #10 dip_switch = 4'd9;  // Ingresar 9 como centenas
        input_ready2 = 1;
        #10 input_ready2 = 0;

        #10 dip_switch = 4'd9;  // Ingresar 9 como decenas
        input_ready2 = 1;
        #10 input_ready2 = 0;

        #10 dip_switch = 4'd8;  // Ingresar 8 como unidades
        input_ready2 = 1;
        #10 input_ready2 = 0;

        // Esperar a que la suma se complete y se muestre el resultado
        #10000000;
        $finish;
    end
        
 // Monitor para imprimir el estado de las señales cada vez que cambien
    initial begin
        $monitor("Time: %0t | clk: %b | reset: %b | input_ready1: %b | input_ready2: %b | sum_result: %d | segments: %b | display_select: %b", 
                 $time, clk, reset, input_ready1, input_ready2, uut.sum_result, segments, display_select);
        
        // Generar archivo de ondas
        $dumpfile("module_Top_tb.vcd");
        $dumpvars(0, top_module_tb);
    end
    

endmodule
