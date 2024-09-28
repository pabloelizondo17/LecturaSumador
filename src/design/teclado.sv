`timescale 1ns / 1ps

module teclado #(parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5)(
    input rst,
    input clk,
    input [3:0] row,
    output logic [3:0] col,
    output logic [3:0] button
);

logic [2:0] state, next_state;
logic [7:0] key;

// Reset y estado inicial
always @(posedge rst) begin
    state <= S0; 
    next_state <= S0; 
    col <= 4'b1111; 
    button <= 4'b0000;
end

// Lógica de transición de estados
always @(posedge clk) begin
    if (!rst) begin
        state <= next_state;
    end
end

// Control de columnas
always @(state) begin
    case(state)
        S0: col = 4'b1111;
        S1: col = 4'b0001;
        S2: col = 4'b0010;
        S3: col = 4'b0100;
        S4: col = 4'b1000;
        S5: col = 4'b1111;
        default: col = 4'b1111;
    endcase
end

// Lógica de estados y lectura de filas
always @(row or state) begin
    case (state)
        S0: begin
            if (row != 4'b1111) begin // Si hay un botón presionado
                key[7:4] <= row;
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end
        S1: begin
            if (row != 4'b1111) begin
                key[3:0] <= col;
                next_state <= S2;
            end else begin
                next_state <= S1;
            end
        end
        S2: begin
            if (row != 4'b1111) begin
                key[3:0] <= col;
                next_state <= S3;
            end else begin
                next_state <= S2;
            end
        end
        S3: begin
            if (row != 4'b1111) begin
                key[3:0] <= col;
                next_state <= S4;
            end else begin
                next_state <= S3;
            end
        end
        S4: begin
            if (row != 4'b1111) begin
                key[3:0] <= col;
                next_state <= S5;
            end else begin
                next_state <= S4;
            end
        end 
        S5: begin
            if (row == 4'b1111) begin
                next_state <= S0;
            end else begin
                next_state <= S5;
            end
        end
    endcase    
end

// Decodificación de botones
always @(posedge clk) begin
    if (state == S5 && row != 4'b1111) begin
        case (key)
            8'b00101000: button <= 4'd0; //Tecla 0
            8'b00010001: button <= 4'd0; //Tecla 1
            8'b00100001: button <= 4'd2; //Tecla 2
            8'b01000001: button <= 4'd3; //Tecla 3
            8'b00010010: button <= 4'd4; //Tecla 4
            8'b00100010: button <= 4'd5; //Tecla 5
            8'b01000010: button <= 4'd6; //Tecla 6
            8'b00010100: button <= 4'd7; //Tecla 7
            8'b00100100: button <= 4'd8; //Tecla 8
            8'b01000100: button <= 4'd9; //Tecla 9
            //8'b00010100: button <= 4'd10;
            //8'b01001000: button <= 4'd11;
            //8'b10000001: button <= 4'd12;
            //8'b10000010: button <= 4'd13;
            //8'b10000100: button <= 4'd14;
            //8'b10001000: button <= 4'd15;
            default: button <= 4'd0;
        endcase
    end
end 

endmodule
