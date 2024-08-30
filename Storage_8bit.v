module Storage_8bit (
    input wire CLK,
    input wire EN_work,
    input wire EN_setalarm,
    input wire hour_or_min,
    input wire [3:0] set0,
    input wire [3:0] set1,
    output reg [3:0] out0,
    output reg [3:0] out1
);

always @(posedge CLK) begin
    if (EN_work && !EN_setalarm && !hour_or_min) begin
        out0 <= set0;
        out1 <= set1;
    end
end

endmodule
