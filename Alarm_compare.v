module Alarm_compare (
    input wire CLK,
    input wire EN_work,
    input wire EN_setalarm,
    input wire [3:0] set_minL,
    input wire [3:0] set_minH,
    input wire [3:0] set_hourL,
    input wire [3:0] set_hourH,
    input wire [3:0] now_minL,
    input wire [3:0] now_minH,
    input wire [3:0] now_hourL,
    input wire [3:0] now_hourH,
    output reg judge
);

reg isSet;

always @(CLK) begin
	if (EN_work && !EN_setalarm) begin
		isSet <= 1'b1;
	end
end

always @(CLK) begin
    if (!EN_work && isSet) begin
        if (set_minL == now_minL && set_minH == now_minH &&
            set_hourL == now_hourL && set_hourH == now_hourH) begin
            judge <= 1'b1;
        end else begin
            judge <= 1'b0;
        end
    end else begin
        judge <= 1'b0;
    end
end

endmodule
