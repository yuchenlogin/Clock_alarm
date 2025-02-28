module Carrier_60 (
    input wire CLK,
    input wire EN_work,
    input wire EN_set,
    input wire [3:0] sec_ones,
    input wire [3:0] sec_tens,
    input wire [3:0] min_ones,
    input wire [3:0] min_tens,
    output reg min_COUT,
    output reg hour_COUT
);

always @(sec_ones) begin
    if (EN_work == 1'b0 || EN_set == 1'b0) begin
        // if (sec_ones == 4'b1001 && sec_tens == 4'b0101) begin // sec == 59
        if (sec_ones == 4'b1000 && sec_tens == 4'b0101) begin // sec == 58
            min_COUT <= 1'b1;
            if (min_ones == 4'b1001 && min_tens == 4'b0101) begin // min == 59
            // if (min_ones == 4'b1000 && min_tens == 4'b0101) begin // min == 58
                hour_COUT <= 1'b1;
            end else begin
                hour_COUT <= 1'b0;
            end
        end else begin
            min_COUT <= 1'b0;
            hour_COUT <= 1'b0;
        end
    end
end

endmodule