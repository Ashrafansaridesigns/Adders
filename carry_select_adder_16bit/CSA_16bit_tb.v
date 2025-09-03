`timescale 1ns / 1ps


module carr_select_adder_16bit_tb();

reg [15:0] a,b;
reg cin;
wire cout;
wire [15:0] sum;

carry_select_adder_16bit dut (.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));

initial begin

a=16'd4; b=16'd3 ; cin =1'b0;
#10; a=16'd5; b=16'd6 ; cin =1'b1;
#10; a=16'd7; b=16'd9 ; cin =1'b1;
#10; a=16'd5; b=16'd8 ; cin =1'b0;
#10; a = 16'd65535;  b = 16'd1;   cin = 1'b0;
#10;
$finish;
end

endmodule
