module Flash_controller (
    input wire CLK,
    input wire EN_work, EN_setalarm,
    input wire sec, min, hour,
    input wire page,
    input wire [3:0] in6, in5, in4, in3, in2,
    input wire [3:0] ahh, ahl, amh, aml,
    output reg [3:0] out6, out5, out4, out3, out2
);

reg [3:0] shadow6, shadow5, shadow4, shadow3, shadow2;

always @(CLK) begin
    if (page == 1'b0) begin
        if (EN_work == 1'b1 && EN_setalarm == 1'b1) begin
            if (sec == 1'b0) begin
                shadow6 <= in6;
                shadow5 <= in5;
                shadow4 <= in4;
                shadow3 <= in3;
                shadow2 <= (CLK == 1'b1) ? in2 : 4'b1111;
            end else if (min == 1'b0) begin
                shadow6 <= in6;
                shadow5 <= in5;
                shadow2 <= in2;
                shadow4 <= (CLK == 1'b1) ? in4 : 4'b1111;
                shadow3 <= (CLK == 1'b1) ? in3 : 4'b1111;
            end else if (hour == 1'b0)begin
                shadow4 <= in4;
                shadow3 <= in3;
                shadow2 <= in2;
                shadow6 <= (CLK == 1'b1) ? in6 : 4'b1111;
                shadow5 <= (CLK == 1'b1) ? in5 : 4'b1111;
            end
        end else begin
            shadow6 <= in6;
            shadow5 <= in5;
            shadow4 <= in4;
            shadow3 <= in3;
            shadow2 <= in2;
        end
    end else begin
        shadow2 <= 4'b1111;
        if (EN_work == 1'b1 && EN_setalarm == 1'b0) begin
            if (min == 1'b0) begin
                shadow6 <= ahh;
                shadow5 <= ahl;
                shadow4 <= (CLK == 1'b1) ? amh : 4'b1111;
                shadow3 <= (CLK == 1'b1) ? aml : 4'b1111;
            end else begin
                shadow4 <= amh;
                shadow3 <= aml;
                shadow6 <= (CLK == 1'b1) ? ahh : 4'b1111;
                shadow5 <= (CLK == 1'b1) ? ahl : 4'b1111;
            end
        end else begin
            shadow6 <= ahh;
            shadow5 <= ahl;
            shadow4 <= amh;
            shadow3 <= aml;
        end
    end
    out6 <= shadow6;
    out5 <= shadow5;
    out4 <= shadow4;
    out3 <= shadow3;
    out2 <= shadow2;
end

endmodule
