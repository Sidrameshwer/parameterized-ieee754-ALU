`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2025 18:26:34
// Design Name: 
// Module Name: ALU
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


module ALU#(parameter N = 32, M = 8)(
  input[N-1:0] A,
  input[N-1:0] B,
  input[2:0] Sel,
  
   output reg [N-1:0] FINAL_OUT
   
    );
    
    reg [N-1:0] a1,a2,m1,m2,d1,d2,c1,c2;
    wire [N-1:0] w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11;
    wire [2:0] w12;
    
    assign w1 = a1;
    assign w2 = a2;
    assign w4 = m1;
    assign w5 = m2;
    assign w7 = d1;
    assign w8 = d2;
    assign w10 = c1;
    assign w11 = c2;
    
    mul_param #(N,M) M01 (w4,w5,w6);
    add_sub#(N,M) A01(w1,w2,w3);
    fp_divider #(N,M) D01(w7,w8,w9);
    fp32_comp #(N) C1(w10,w11,w12);
      
   always@(*) begin
   if (Sel == 1)
      begin
       a1 = A;
       a2 = B;
       FINAL_OUT = w3;
      end
      
   else if (Sel == 2)
     begin
       a1 = A;
       a2 = {~B[N-1],B[N-2:0]};
       FINAL_OUT = w3;
      end
   
   else if (Sel == 3)
       begin
       m1 = A;
       m2 = B;
       FINAL_OUT = w6;
       end
   
   else if (Sel == 4)
     begin
       d1 = A;
       d2 = B;
       FINAL_OUT = w9;
       end
   
   else if (Sel == 5)
     begin
       c1 = A;
       c2 = B;
       FINAL_OUT = {29'b0,w12};
       end
   
   else
      FINAL_OUT = 0;
    
   end  
endmodule
