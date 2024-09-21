module adder_submodule (
    input logic clk,              
    input logic reset,           
    input logic [11:0] number1, 
    input logic [11:0] number2,
    input logic enable, 
    output logic [11:0] sum_result, //Resultado de la suma
    output logic sum_state          //Estado de la suma (finalizada o no)
);

    logic [13:0] sum_reg;
    logic sum_ready;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            sum_reg <= 14'd0;
            sum_ready <= 1'b0;
        end else if (enable) begin
            sum_reg <= number1 + number2;
            sum_ready <= 1'b1;
        end else begin
            sum_ready <= 1'b0;
        end
    end

    assign sum_result = sum_reg;
    assign sum_state = sum_ready;
    
endmodule