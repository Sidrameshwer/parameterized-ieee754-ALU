`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2025 19:39:48
// Design Name: 
// Module Name: fp32_comp
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


module fp32_comp#(parameter n=32)(input [(n-1):0]a,b,
output  reg [n-1:0]out);
//output overflow,underflow);
//0 = equal, 1=gretaer, 2=lesser
    //assign overflow= &a || &b;
    //assign underflow=1'b0;
    integer i;
    //assign out=(a^b)?1'b0:1'b1;
    always @(*) begin
    out=32'b0;
    if ((a[n-1]^b[n-1]) && a[n-1]) begin
    out=32'h00000001;
    end
    else
    begin:block
    
    for(i=n-2;i>0;i=i-1) begin
    if((a[i]^b[i]) && a[i])begin
    out=32'h00000002;
    disable block;
    end
    else if((a[i]^b[i])&& b[i]) begin
    out=32'h00000001;
    disable block;
    end
    end
    end
    end
endmodule
