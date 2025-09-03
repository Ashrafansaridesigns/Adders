`timescale 1ns / 1ps

module carry_select_adder_16bit(
input [15:0] a,b,
input cin,
output [15:0] sum,
output cout);
wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10;
wire [3:0] m1,m2,m3,m4,m5,m6,m7,m8;
ripple_adder rp0(.a(a[3:0]),.b(b[3:0]),.cin(1'b0),.sum(m1),.cout(w0));
ripple_adder rp1(.a(a[3:0]),.b(b[3:0]),.cin(1'b1),.sum(m2),.cout(w1));
mux_2_4bit mux_4bit0(.a(m1),.b(m2),.sel(cin),.out(sum[3:0]));
mux_2_1bit mux_1bit0(.a(w0),.b(w1),.sel(cin),.out(w4));

ripple_adder rp2(.a(a[7:4]),.b(b[7:4]),.cin(1'b0),.sum(m3),.cout(w2));
ripple_adder rp3(.a(a[7:4]),.b(b[7:4]),.cin(1'b1),.sum(m4),.cout(w3));
mux_2_4bit mux_4bit1(.a(m3),.b(m4),.sel(w4),.out(sum[7:4]));
mux_2_1bit mux_1bit1(.a(w2),.b(w3),.sel(w4),.out(w5));

ripple_adder rp4(.a(a[11:8]),.b(b[11:8]),.cin(1'b0),.sum(m5),.cout(w6));
ripple_adder rp5(.a(a[11:8]),.b(b[11:8]),.cin(1'b1),.sum(m6),.cout(w7));
mux_2_4bit mux_4bit2(.a(m5),.b(m6),.sel(w5),.out(sum[11:8]));
mux_2_1bit mux_1bit2(.a(w6),.b(w7),.sel(w5),.out(w8));

ripple_adder rp6(.a(a[15:12]),.b(b[15:12]),.cin(1'b0),.sum(m7),.cout(w9));
ripple_adder rp7(.a(a[15:12]),.b(b[15:12]),.cin(1'b1),.sum(m8),.cout(w10));
mux_2_4bit mux_4bit3(.a(m7),.b(m8),.sel(w8),.out(sum[15:12]));
mux_2_1bit mux_1bit3(.a(w2),.b(w3),.sel(w8),.out(cout));

endmodule

module full_adder(
input a,b,cin,
output sum,cout);
assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule

module ripple_adder(
input [3:0] a,b,
input cin,
output [3:0] sum,
output cout);
wire m1,m2,m3;

full_adder fa0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(m1));
full_adder fa1(.a(a[1]),.b(b[1]),.cin(m1),.sum(sum[1]),.cout(m2));
full_adder fa2(.a(a[2]),.b(b[2]),.cin(m2),.sum(sum[2]),.cout(m3));
full_adder fa3(.a(a[3]),.b(b[3]),.cin(m3),.sum(sum[3]),.cout(cout));
endmodule

module mux_2_4bit(
input [3:0] a,b,
input sel,
output [3:0] out);
assign out = sel?b:a;

endmodule

module mux_2_1bit(
input a,b,
input sel,
output out);
assign out = sel?b:a;

endmodule
