module MOD_24 (
    input wire CLK,
    input wire Carry,
    input wire ishour,
    input wire EN_work, EN_setalarm,
    input wire [3:0] set0,
    input wire [3:0] set1,
    output reg [3:0] ones,
    output reg [3:0] tens
);

reg [3:0] onesY;
reg [3:0] tensY;

// always @(posedge CLK or posedge EN_work or posedge EN_setalarm) begin
always @(posedge CLK) begin
	if (EN_work == 1'b1 && EN_setalarm == 1'b1) begin
		if (ishour == 1'b0) begin
			if (set1 > 4'b0001) begin
				tensY <= 4'b0010;
				if (set0 > 4'b0011) begin
					onesY <= 4'b0011;
				end
			end else begin
				tensY <= set1;
				if (set0 > 4'b1001) begin
					onesY <= 4'b1001;
				end else begin
					onesY <= set0;
				end
			end
		end
	end else if (Carry == 1'b1) begin
		if (onesY == 4'b0011 && tensY == 4'b0010) begin
			onesY <= 4'b0000;
			tensY <= 4'b0000;
		end else if (onesY == 4'b1001) begin
			onesY <= 4'b0000;
			tensY <= tensY + 1;
		end else begin
			onesY <= onesY + 1;
		end
	end
	ones <= onesY;
	tens <= tensY;
end
endmodule