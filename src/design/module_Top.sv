module top_module (
    input logic clk,
    input logic reset,
    input logic [3:0] dip_switch,      // Entrada del DIP switch
    input logic input_ready1,          // Indica cuando el primer número está listo
    input logic input_ready2,          // Indica cuando el segundo número está listo
    output logic [6:0] segments,       // Salida hacia el display de 7 segmentos
    output logic [3:0] display_select  // Salida para seleccionar display activo
);

    // Señales internas
    logic [11:0] number1, number2, sum_result;
    logic ready1, ready2, enable_adder,sum_ready;
    logic [1:0] state;

    // Máquina de estados: 3 estados para gestionar la entrada, suma y despliegue
    typedef enum logic [1:0] {
        IM = 2'b00,   // Espera captura de datos
        ADD = 2'b01,    // Realiza la suma
        DISPLAY = 2'b10 // Muestra el resultado en el display
    } state_t;

    state_t current_state, next_state;

    // Instancia del primer submódulo para capturar el primer número
    input_manager input_manager1 (
        .clk(clk),
        .reset(reset),
        .dip_switch(dip_switch),
        .input_ready(input_ready1),
        .number_out(number1),
        .ready(ready1)
    );

    // Instancia del segundo submódulo para capturar el segundo número
    input_manager input_manager2 (
        .clk(clk),
        .reset(reset),
        .dip_switch(dip_switch),
        .input_ready(input_ready2),
        .number_out(number2),
        .ready(ready2)
    );

    // Instancia del módulo para realizar la suma
    adder_submodule adder (
        .clk(clk),
        .reset(reset),
        .number1(number1),
        .number2(number2),
        .enable(enable_adder), 
        .sum_result(sum_result),
        .sum_state(sum_ready)
    );

    // Instancia del módulo para el despliegue en el display de 7 segmentos
    display_multiplexer display (
        .clk(clk),
        .reset(reset),
        .sum_result(sum_result),
        .segments(segments),
        .display_select(display_select)
    );

    // Máquina de estados
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IM;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        enable_adder = 1'b0;
        next_state = current_state; 
        case (current_state)
            IM: begin
                // Si ambos números están listos, pasa al estado de suma
                if (ready1 & ready2) begin
                    next_state = ADD;
                end
            end
            ADD: begin
                // Si la suma está lista, pasa al estado de despliegue
                enable_adder = 1'b1;
                if (sum_ready) begin
                    next_state = DISPLAY;
                end
            end
            DISPLAY: begin
                // Mantén el estado de despliegue 
                next_state = DISPLAY; 
            end
            default: next_state = IM;
        endcase
    end

endmodule
