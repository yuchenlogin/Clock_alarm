module Decoder_2to4 (
    input wire inB, inA, EN,
    output reg outD,
    output reg outC,
    output reg outB,
    output reg outA
);
    reg [3:0] Y;

    always @(*) begin
            case ({inB, inA})
                2'b00: Y = 4'b1110;
                2'b01: Y = 4'b1101;
                2'b10: Y = 4'b1011;
                2'b11: Y = 4'b0111;
                default: Y = 4'b1111;
            endcase
    end

    always @* begin
        outD = Y[3];
        outC = Y[2];
        outB = Y[1];
        outA = Y[0];
    end

endmodule