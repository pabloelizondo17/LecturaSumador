module tb_input_manager;
    logic clk;
    logic reset;
    logic [3:0] dip_switch;
    logic input_ready;
    logic [11:0] number_out;
    logic ready;

    // Instanciar el módulo input_manager
    input_manager uut (
        .clk(clk),
        .reset(reset),
        .dip_switch(dip_switch),
        .input_ready(input_ready),
        .number_out(number_out),
        .ready(ready)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Reloj con un periodo de 10 unidades de tiempo
    end

    // Secuencia de prueba
    initial begin
        reset = 1;
        input_ready = 0;
        dip_switch = 4'b0000;
        #10; // Esperar

        reset = 0;
        #10;

        // Ingresar el número 3 (centenas)
        dip_switch = 4'b1001; // Centenas: 3
        input_ready = 1;
        #10; // Esperar a que se procese

        input_ready = 0; // Desactivar el estado listo
        #10;

        // Ingresar el número 2 (decenas)
        dip_switch = 4'b1000; // Decenas: 2
        input_ready = 1;
        #10; // Esperar a que se procese

        input_ready = 0; // Desactivar el estado listo
        #10;

        // Ingresar el número 1 (unidades)
        dip_switch = 4'b0010; // Unidades: 1
        input_ready = 1;
        #10; // Esperar a que se procese

        input_ready = 0; // Desactivar el estado listo
        #10;


        // Finaliza la simulación
        $display("Number out: %d, Ready: %b", number_out, ready);
        $finish;
    end
endmodule


