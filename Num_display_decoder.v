module Num_display_decoder (
    input wire [3:0] Cin,
    input wire CLK,
    input wire sec,
    input wire EN,
    input wire page,
    output reg a, b, c, d, e, f, g
);
    reg [6:0] num;

    always @(*) begin
        case (Cin)
            4'b0000: num = 7'b1111110;
            4'b0001: num = 7'b0110000;
            4'b0010: num = 7'b1101101;
            4'b0011: num = 7'b1111001;
            4'b0100: num = 7'b0110011;
            4'b0101: num = 7'b1011011;
            4'b0110: num = 7'b1011111;
            4'b0111: num = 7'b1110000;
            4'b1000: num = 7'b1111111;
            4'b1001: num = 7'b1111011;
            default: num = 7'b1111011;
        endcase

        if ((EN == 1'b1 && CLK == 1'b0 && sec == 1'b0) || page == 1'b1) begin
            num = 7'b0000000;
        end
    end

    always @(*) begin
        a = num[6];
        b = num[5];
        c = num[4];
        d = num[3];
        e = num[2];
        f = num[1];
        g = num[0];
    end

endmodule