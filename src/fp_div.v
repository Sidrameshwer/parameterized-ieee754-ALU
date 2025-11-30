`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2025 23:40:09
// Design Name: 
// Module Name: fp_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module FloatingDivision#(parameter XLEN=32)
                        (input [XLEN-1:0]A,
                         input [XLEN-1:0]B,
                         output zero_division,
                         output [XLEN-1:0] result);

wire [7:0] Exponent;
wire [31:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, result_unprotected;
wire [31:0] reciprocal;
wire [31:0] x0,x1,x2,x3;

// zero division flag
assign zero_division = (B[30:23] == 0) ? 1'b1 : 1'b0;

/*----Initial value----       B_Mantissa * (2 ^ -1)            32 / 17 */
mul_param M1(.A({{1'b0,8'd126,B[22:0]}}),.B(32'h3ff0f0f1),.clk(clk),.result(temp1)); //verified
//                         48 / 17        -abs(temp1)
add_aub A1(.A(32'h4034b4b5),.B({1'b1,temp1[30:0]}),.result(x0));

/*----First Iteration----*/
mul_param M2(.A({{1'b0,8'd126,B[22:0]}}),.B(x0),.clk(clk),.result(temp2));
//                         +2            -temp2
add_sub A2(.A(32'h40000000),.B({!temp2[31],temp2[30:0]}),.result(temp3));
mul_param M3(.A(x0),.B(temp3),.clk(clk),.result(x1));

/*----Second Iteration----*/
mul_param M4(.A({1'b0,8'd126,B[22:0]}),.B(x1),.clk(clk),.result(temp4));
add_sub A3(.A(32'h40000000),.B({!temp4[31],temp4[30:0]}),.result(temp5));
mul_param M5(.A(x1),.B(temp5),.clk(clk),.result(x2));

/*----Third Iteration----*/
mul_param M6(.A({1'b0,8'd126,B[22:0]}),.B(x2),.clk(clk),.result(temp6));
add_sub A4(.A(32'h40000000),.B({!temp6[31],temp6[30:0]}),.result(temp7));
mul_param M7(.A(x2),.B(temp7),.clk(clk),.result(x3));

/*----Reciprocal : 1/B----*/
assign Exponent = x3[30:23]+8'd126-B[30:23];
assign reciprocal = {B[31],Exponent,x3[22:0]};

/*----Multiplication A*1/B----*/
mul_param M8(.A(A), .B(reciprocal), .result(result_unprotected));

assign result = ((A[30:23] == 0) || zero_division) ? 32'h0000_0000 : result_unprotected;
endmodule
/*module fp_divider #(parameter n=32,m=8)(input [n-1:0]a,b,
output [31:0]out);


wire [n-m:0]diff1,diff2,diff3;
//reg [e-1:0]m;
reg [n-m-2:0]count;
reg sign;
reg [m-1:0] exp;
reg [n-m-2:0]mant;
assign out={sign,exp,mant};
assign diff1={1'b1,a[n-m-2:0]}-{{1'b1,b[n-m-2:0]}*0};
assign diff2={1'b1,a[n-m-2:0]}-{{1'b1,b[n-m-2:0]}*1};
assign diff3={1'b1,a[n-m-2:0]}-{{1'b1,b[n-m-2:0]}*2};
always@(*)
begin
sign=a[n-1]^b[n-1];
exp=a[n-2:n-m-1]-b[n-2:n-m-1]+ 127;
   if(diff2[n-m]==1)
    count=diff1[n-m-2:0];
    else
    begin
    if(diff3[n-m]==1)
    count=diff2[n-m-2:0];
    else
    count=0;
    end
   mant=count; 
end
endmodule*/
