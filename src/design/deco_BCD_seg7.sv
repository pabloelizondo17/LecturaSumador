module deco_BCD_seg7 (
    input logic [3:0] bcd,
    output logic [6:0] seg7
);

    always_comb begin
        case (bcd)
            4'b0000: seg7 = 7'b0000001;
            4'b0001: seg7 = 7'b1001111;
            4'b0010: seg7 = 7'b0010010;
            4'b0011: seg7 = 7'b0000110;
            4'b0100: seg7 = 7'b1001100;
            4'b0101: seg7 = 7'b0100100;
            4'b0110: seg7 = 7'b0100000;
            4'b0111: seg7 = 7'b0001111;
            4'b1000: seg7 = 7'b0000000;
            4'b1001: seg7 = 7'b0000100;
            default: seg7 = 7'b1111111;
        endcase
    end

endmodule
