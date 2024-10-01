module input_manager (
    input logic clk,
    input logic reset,
    input logic [3:0] dip_switch,
    input logic input_ready,
    output logic [11:0] number_out,
    output logic ready
);

    logic [3:0] units;
    logic [3:0] tens;
    logic [3:0] hundreds;
    logic [1:0] state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            units <= 4'b0;
            tens <= 4'b0;
            hundreds <= 4'b0;
            state <= 2'b00;
            ready <= 1'b0; // Inicializar ready en 0
        end else begin
            case (state)
                2'b00: begin
                    if (input_ready) begin
                        hundreds <= dip_switch; // Captura centenas
                        state <= 2'b01; // Cambia a decenas
                    end
                end
                2'b01: begin
                    if (input_ready) begin
                        tens <= dip_switch; // Captura decenas
                        state <= 2'b10; // Cambia a unidades
                    end
                end
                2'b10: begin
                    if (input_ready) begin
                        units <= dip_switch; // Captura unidades
                        state <= 2'b00; // Resetea a centenas
                        ready <= 1'b1; // Indica que el número está listo
                    end
                end
            endcase
        end
    end

    // Combina las entradas en number_out
    assign number_out = (hundreds * 100) + (tens * 10) + units; // Combina los valores adecuadamente

   always_comb begin
    if (ready) begin
        $display("Centenas: %b, Decenas: %b, Unidades: %b", hundreds, tens, units);
    end
end

endmodule


