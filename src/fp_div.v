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

module fp_divider #(parameter n=32,m=8)(input [n-1:0]a,b,
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
endmodule
