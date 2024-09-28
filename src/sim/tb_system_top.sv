module tb_system_top;

    logic clk;
    logic [3:0] btn_input;
    logic [3:0] f_out;
    logic [6:0] seg7_out;
    logic L_out;

    // Instancia del módulo a probar
    system_top uut (
        .clk(clk),
        .btn_input(btn_input),
        .f_out(f_out),
        .seg7_out(seg7_out),
        .L_out(L_out)
    );

    // Generación del reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        btn_input = 4'b0000;

        // Simulación de entradas
        #10 btn_input = 4'b0001; // Presiona el primer botón
        #10 btn_input = 4'b0010; // Presiona el segundo botón
        #10 btn_input = 4'b0011; // Presiona el tercer botón
        #10 btn_input = 4'b0100; // Presiona el cuarto botón
        #10 btn_input = 4'b0101; // Presiona el quinto botón
        #10 btn_input = 4'b0110; // Presiona el sexto botón
        #10 btn_input = 4'b0111; // Presiona el séptimo botón
        #10 btn_input = 4'b1000; // Presiona el octavo botón
        #10 btn_input = 4'b1001; // Presiona el noveno botón
        #10 btn_input = 4'b1010; // Presiona el décimo botón

        // Observación de salidas
        #10; // Espera un ciclo de reloj adicional para ver el resultado
        $display("f_out = %b, seg7_out = %b, L_out = %b", f_out, seg7_out, L_out);

        // Finalización de la simulación
        #10 $finish;
    end

endmodule


