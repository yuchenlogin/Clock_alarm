module Striking_pulse_generator (
    input wire CLK,
    input wire EN_work,
    input wire [3:0] sec_low,
    input wire [3:0] sec_high,
    input wire [3:0] min_low,
    input wire [3:0] min_high,
    input wire [3:0] hour_low,
    input wire [3:0] hour_high,
    output reg Chime
);

reg isChime;

// always @(posedge CLK or negedge EN_work) begin
always @(CLK) begin
    if (EN_work == 1'b0) begin
		// if(hour_low != 4'b0000 || hour_high != 4'b0000) begin // hour != 00 01 10 11
			if ((sec_low < 4'b0011 && sec_high == 4'b0000) && min_low == 4'b0000 && min_high == 4'b0000) begin
				// 如果秒的低位小于 3，秒的高位为 0，且分钟的低位和高位都为 0
				isChime <= 1'b1;  // 设置isChime 为 1
			end else begin
				isChime <= 1'b0;  // 如果不满足上述条件，设置 isChime 为 0
			end
		//end else begin
		//	isChime <= 1'b0;
		//end
    end else begin
        isChime <= 1'b0;  // 如果 EN_work 不为 0，设置 isChime 为 0
    end
    
    //Chime <= isChime;  // 将 isChime 的值赋给 Chime 输出
    Chime <= isChime;
end


endmodule