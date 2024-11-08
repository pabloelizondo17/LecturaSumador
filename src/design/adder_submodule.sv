module adder_submodule (
    input logic clk,              
    input logic reset,           
    input logic [11 : 0] number1,        // Entrada de 12 bits máximo
    input logic [11 : 0] number2,        // Entrada de 12 bits máximo
    input logic enable,                  // Señal de habilitación 
    output logic [11 : 0] sum_result,    // Resultado de 12 bits máximo
    output logic sum_state               // Estado de la suma 
);

    logic [11 : 0] sum_reg = 12'b0;     // Registro temporal de 12 bits máximo
    logic sum_ready = 1'b0;             // Registro de estado temporal

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum_reg <= 12'b0;          
            sum_ready <= 1'b0;         
        end else if (enable) begin
            sum_reg <= number1 + number2;
            sum_ready <= 1'b1; 
        end
    end

    assign sum_result = sum_reg;
    assign sum_state = sum_ready;  
endmodule
