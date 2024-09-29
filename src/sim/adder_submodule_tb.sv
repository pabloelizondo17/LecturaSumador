`timescale 1ns/1ps
module adder_submodule_tb;

    logic clk;
    logic reset;
    logic enable;
    logic [11 : 0] number1;
    logic [11 : 0] number2;
    logic [11 : 0] sum;
    logic valid;

    adder_submodule uut (
        .clk(clk),
        .reset(reset),
        .number1(number1),
        .number2(number2),
        .enable(enable),
        .sum_result(sum),
        .sum_state(valid)
    );

    always #18.52 clk = ~clk; // Periodo de 37.04 ns (27 MHz)

    // Proceso para la simulación
    initial begin
        $dumpfile("adder_submodule_tb.vcd");
        $dumpvars(0, adder_submodule_tb);

        clk = 0;
        reset = 1;
        enable = 0;
        number1 = 12'b0;
        number2 = 12'b0;

        #10;
        reset = 0;
        
        // Caso de prueba 1: Sumar 897 + 78
        number1 = 12'b001110000001;
        number2 = 12'b000001001110;
        enable = 1;
        #38;
        $display("Time: %0t, Number1: %0d, Number2: %0d, Sum: %0d, Valid: %b", 
        $time, number1, number2, sum, valid);
        enable = 0;
        #20;

        // Caso de prueba 2: Sumar 123 + 896
        number1 = 12'b000001111011;
        number2 = 12'b001110000000;
        enable = 1;
        #38;
        $display("Time: %0t, Number1: %0d, Number2: %0d, Sum: %0d, Valid: %b", 
        $time, number1, number2, sum, valid);
        enable = 0;
        #20;

        // Caso de prueba 3: Sumar 999 + 999 (máximo valor)
        number1 = 12'b001111100111;
        number2 = 12'b001111100111;
        enable = 1;
        #38;
        $display("Time: %0t, Number1: %0d, Number2: %0d, Sum: %0d, Valid: %b", 
        $time, number1, number2, sum, valid);
        enable = 0;
        #20;

        $finish;
    end

endmodule
