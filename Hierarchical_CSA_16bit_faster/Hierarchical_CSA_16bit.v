`timescale 1ns / 1ps

module Hierarchical_CSA_16bit(
input [15:0] a,b,
input cin,
output [15:0] sum,
output cout);
wire c4,c81,c82,c8,c121,c122,c161,c162;
wire [3:0] m1,m2,m3,m4,m5,m6;
wire [4:0] p1,p2;

ripplen_adder rpaa0(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(c4));

ripplen_adder rpaa1(.a(a[7:4]),.b(b[7:4]),.cin(1'b0),.sum(m1),.cout(c81));
ripplen_adder rpaa2(.a(a[7:4]),.b(b[7:4]),.cin(1'b1),.sum(m2),.cout(c82));

muxn_2_5bit mux00(.a({c81,m1}),.b({c82,m2}),.sel(c4),.out({c8,sum[7:4]}));

ripplen_adder rpaa3(.a(a[11:8]),.b(b[11:8]),.cin(1'b0),.sum(m3),.cout(c121));
ripplen_adder rpaa4(.a(a[11:8]),.b(b[11:8]),.cin(1'b1),.sum(m4),.cout(c122));

ripplen_adder rpaa5(.a(a[15:12]),.b(b[15:12]),.cin(1'b0),.sum(m5),.cout(c161));
ripplen_adder rpaa6(.a(a[15:15]),.b(b[15:12]),.cin(1'b1),.sum(m6),.cout(c162));

muxn_2_5bit mux01(.a({c161,m5}),.b({c162,m6}),.sel(c121),.out(p1));
muxn_2_5bit mux02(.a({c161,m5}),.b({c162,m6}),.sel(c122),.out(p2));

muxn_2_9bit mux03(.a({p1,m3}),.b({p2,m4}),.sel(c8),.out({cout,sum[15:8]}));

endmodule

module fulln_adder(
input a,b,cin,
output sum,cout);
assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule

module ripplen_adder(
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

module muxn_2_5bit(
input [4:0] a,b,
input sel,
output [4:0] out);
assign out = sel?b:a;

endmodule

module muxn_2_9bit(
input [8:0] a,b,
input sel,
output [8:0] out);
assign out = sel?b:a;

endmodule
