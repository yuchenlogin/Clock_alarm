module MOD_60 (
    input wire CLK,
    input wire Carry,
    input wire min_or_sec,
    input wire EN_work,
    input wire EN_setalarm,
    input wire [3:0] set0,
    input wire [3:0] set1, // BCD code of the set time
    output reg [3:0] ones,
    output reg [3:0] tens
);

reg [3:0] onesY;
reg [3:0] tensY;

//reg isSet;

//always @(posedge CLK or posedge EN_work or posedge EN_setalarm) begin
//always @(posedge CLK) begin
always @(posedge CLK) begin
//always @(posedge CLK or negedge EN_work) begin
    if (EN_work == 1'b1 && EN_setalarm == 1'b1) begin
        if (min_or_sec == 1'b0) begin
            if (set0 > 4'b1001) begin
                onesY <= 4'b1001;
            end else begin
                onesY <= set0;
            end
            if (set1 > 4'b0101) begin
                tensY <= 4'b0101;
            end else begin
                tensY <= set1;
            end
        end
    end else if (Carry == 1) begin // carry == 1
        if (onesY == 4'b1001) begin
            onesY <= 4'b0000;
            if (tensY == 4'b0101) begin
                tensY <= 4'b0000;
            end else begin
                tensY <= tensY + 1;
            end
        end else begin
            onesY <= onesY + 1;
        end
    end

 ones = onesY;
 tens = tensY;
end

//always @(posedge CLK or negedge EN_work or negedge EN_setalarm) begin
//    if (!EN_work || !EN_setalarm) begin
//        if (EN_work && !EN_setalarm) begin
//            isSet <= 1'b1;
//        end
//    end
//end

endmodule
