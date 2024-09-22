module debounce (
    input clk,            
    input rst,            
    input btn_in,        
    output reg btn_out   
);
parameter DEBOUNCE_TIME = 20_000_000; // 20 ms para un reloj de 50 MHz
reg [31:0] counter;   
reg btn_in_d, btn_in_d2; 

always @(posedge clk) begin
    if (!rst) begin
        btn_in_d <= btn_in;  
        btn_in_d2 <= btn_in_d; 
    end else begin
        btn_in_d <= 1'b0; 
        btn_in_d2 <= 1'b0; 
    end
end

always @(posedge clk) begin
    if (!rst) begin
        if (btn_in_d2 == btn_in_d) begin
            if (counter < DEBOUNCE_TIME) begin
                counter <= counter + 1; 
            end else begin
                btn_out <= btn_in_d; 
            end
        end else begin
            counter <= 0; 
        end
    end else begin
        counter <= 0; 
        btn_out <= 1'b0; 
    end
end

endmodule
