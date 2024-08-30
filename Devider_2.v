module Devider_2 (
    input wire CLK,
    output reg CLK_out
);

reg bin_Y;

always @(posedge CLK) begin
    bin_Y <= ~bin_Y;
end

always @(posedge CLK) begin
    CLK_out <= bin_Y;
end

endmodule
