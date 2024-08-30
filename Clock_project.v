module Clock_project(
    input EN_setalarm, EN_work,
    input CLK,
    input CLK_Music,
    input setTime_high_A, setTime_high_B, setTime_high_C, setTime_high_D,
    input setTime_low_A, setTime_low_B, setTime_low_C, setTime_low_D,
    input SetTime_A, SetTime_B,
    input page,
    input Off,
    output hour_high_A, hour_high_B, hour_high_C, hour_high_D,
    output hour_low_A, hour_low_B, hour_low_C, hour_low_D,
    output min_high_A, min_high_B, min_high_C, min_high_D,
    output min_low_A, min_low_B, min_low_C, min_low_D,
    output sec_high_A, sec_high_B, sec_high_C, sec_high_D,
    output sec_low_a, sec_low_b, sec_low_c, sec_low_d, sec_low_e, sec_low_f, sec_low_g,

    output Speaker // Music
);

// Internal signals
wire [3:0] Cinl;
wire [3:0] Cinh;
wire hour1, hour2, min, sec;
wire [3:0] Osl, Osh, Oml, Omh, Ohl, Ohh; // set second-low
wire carry_sec, carry_min;
wire alarm_hour1, alarm_hour2, alarm_min1, alarm_min2;
wire [3:0] aml, amh, ahl, ahh; // now minute-low
wire ring1, ring2, ring3;  // Music
wire [3:0] out6, out5, out4, out3, out2;
wire CLK_2, CLK_22, CLK_23, CLK_24, CLK_25, CLK_26;

// Assignments
assign Cinl = {setTime_low_D, setTime_low_C, setTime_low_B, setTime_low_A};
assign Cinh = {setTime_high_D, setTime_high_C, setTime_high_B, setTime_high_A};

Decoder_2to4 u1(
    .inB(SetTime_B), .inA(SetTime_A), .EN(CLK), 
    .outD(hour1), .outC(hour2), .outB(min), .outA(sec)
);

MOD_60 u2 (
    .CLK(CLK),
    .Carry(1'b1),
    .min_or_sec(sec),
    .EN_work(EN_work),
    .EN_setalarm(EN_setalarm),
    .set0(Cinl),
    .set1(Cinh),
    .ones(Osl),
    .tens(Osh)
);


Carrier_60 u3(
    .CLK(CLK), .EN_work(EN_work), .EN_set(EN_setalarm), 
    .sec_ones(Osl), .sec_tens(Osh), 
    .min_ones(Oml), .min_tens(Omh), 
    .min_COUT(carry_sec), .hour_COUT(carry_min)
);

MOD_60 u4(
    .CLK(CLK), .Carry(carry_sec), .min_or_sec(min), 
    .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .set0(Cinl), .set1(Cinh), 
    .ones(Oml), .tens(Omh)
);

MOD_24 u5(
    .CLK(CLK), .Carry(carry_min), .ishour(hour1 & hour2), 
    .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .set0(Cinl), .set1(Cinh), 
    .ones(Ohl), .tens(Ohh)
);

Num_display_decoder u6(
    .Cin(Osl), .CLK(CLK), .sec(sec), 
    .EN(EN_work & EN_setalarm), .page(page), 
    .a(sec_low_a), .b(sec_low_b), .c(sec_low_c), 
    .d(sec_low_d), .e(sec_low_e), .f(sec_low_f), .g(sec_low_g)
);

Decoder_2to4 u7(
    .inB(SetTime_B), .inA(SetTime_A), .EN(CLK), 
    .outD(alarm_hour1), .outC(alarm_hour2), 
    .outB(alarm_min1), .outA(alarm_min2)
);

Storage_8bit u8(
    .CLK(CLK), .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .hour_or_min(alarm_min1 & alarm_min2), 
    .set0(Cinl), .set1(Cinh), 
    .out0(aml), .out1(amh)
);

Storage_8bit u9(
    .CLK(CLK), .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .hour_or_min(alarm_hour1 & alarm_hour2), 
    .set0(Cinl), .set1(Cinh), 
    .out0(ahl), .out1(ahh)
);

Alarm_compare u10(
    .CLK(CLK), .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .set_minL(aml), .set_minH(amh), .set_hourL(ahl), .set_hourH(ahh), 
    .now_minL(Oml), .now_minH(Omh), .now_hourL(Ohl), .now_hourH(Ohh), 
    .judge(ring1)
);

Off_alarm u11(
    .CLK(CLK), .off(Off), .judge(ring3)
);

Striking_pulse_generator u12(
    .CLK(CLK), .EN_work(EN_work), 
    .sec_low(Osl), .sec_high(Osh), 
    .min_low(Oml), .min_high(Omh), 
    .hour_low(Ohl), .hour_high(Ohh),
    .Chime(ring2)
);

Music_output u13(
    .CLK(CLK), .CLK_1(CLK_24), .CLK_2(CLK_25), .CLK_3(CLK_26), 
    .judge(ring1 & ring3), .chime(ring2), 
    .Music(Speaker)
);

Flash_controller u14(
    .CLK(CLK), .EN_work(EN_work), .EN_setalarm(EN_setalarm), 
    .sec(sec), .min(min & alarm_min1 & alarm_min2), 
    .hour(hour1 & hour2 & alarm_hour1 & alarm_hour2), 
    .page(page), 
    .in6(Ohh), .in5(Ohl), .in4(Omh), .in3(Oml), .in2(Osh), 
    .ahh(ahh), .ahl(ahl), .amh(amh), .aml(aml), 
    .out6(out6), .out5(out5), .out4(out4), .out3(out3), .out2(out2)
);

Devider_2 u15(
    .CLK(CLK_Music), .CLK_out(CLK_2)
);

Devider_2 u16(
    .CLK(CLK_2), .CLK_out(CLK_22)
);

Devider_2 u17(
    .CLK(CLK_22), .CLK_out(CLK_23)
);

Devider_2 u18(
    .CLK(CLK_23), .CLK_out(CLK_24)
);

Devider_2 u19(
    .CLK(CLK_24), .CLK_out(CLK_25)
);

Devider_2 u20(
    .CLK(CLK_25), .CLK_out(CLK_26)
);

// Output assignments
assign hour_high_A = out6[0];
assign hour_high_B = out6[1];
assign hour_high_C = out6[2];
assign hour_high_D = out6[3];

assign hour_low_A = out5[0];
assign hour_low_B = out5[1];
assign hour_low_C = out5[2];
assign hour_low_D = out5[3];

assign min_high_A = out4[0];
assign min_high_B = out4[1];
assign min_high_C = out4[2];
assign min_high_D = out4[3];

assign min_low_A = out3[0];
assign min_low_B = out3[1];
assign min_low_C = out3[2];
assign min_low_D = out3[3];

assign sec_high_A = out2[0];
assign sec_high_B = out2[1];
assign sec_high_C = out2[2];
assign sec_high_D = out2[3];

endmodule