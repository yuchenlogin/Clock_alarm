module Off_alarm (
    input wire CLK,
    input wire off,
    output reg judge
);

reg flag;

// when off avaiable, turn off alarm(flag == 0)
always @(posedge CLK or posedge off) begin
    if (off) begin
        flag <= 0;
    end else begin
        flag <= 1;
    end
end

always @(*) begin
    judge = flag;
end

endmodule
