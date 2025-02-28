module Music_output (
    input wire CLK,
    input wire CLK_1,
    input wire CLK_2,
    input wire CLK_3,
    input wire judge,
    input wire chime,
    output reg Music
);

reg tone;

always @(CLK) begin
    if (judge == 1'b1 || chime == 1'b1) begin
		tone <= CLK_3;
    end else begin
        tone <= 0;
        // tone = CLK_1;
    end
end

always @(*) begin
    Music <= tone;
end

endmodule
