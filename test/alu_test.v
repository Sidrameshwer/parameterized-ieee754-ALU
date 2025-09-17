module alu_test();
reg [2:0]sel;
reg [31:0]a,b;
wire [31:0]out;
//wire underflow;
//wire overflow,underflow;
ALU dut(a,b,sel,out);
initial begin
sel=3'b001;
 a=32'h4B000000;
 b=32'h4A000000;
#30 $display($time , "  %b",out);
sel=3'b011;
a=32'h4B000000;
 b=32'h3F800000;
#30 $display($time , "  %b",  out);
sel=3'b010;
a=32'h47C35000;
 b=32'h472A0000;
#30 $display($time , "  %b",out);
sel=3'b101;
        a= 32'b01000001010000000000000000000000; // Example: 12.0 in IEEE 754
        b = 32'b01000000100000000000000000000000; // Example: 4.0 in IEEE 754

#30 $display($time , "  %b",out);
sel=3'b01;
a=32'hC7800000;
 b=32'h46800000;
#30 $display($time , "  %b",out);
sel=3'b00;
a=32'hC2F00000;
 b=32'hC2C80000;
#30 $display($time , "  %b",out);
sel=3'b10;
 a=32'h40400000;
 b=32'h40000000;
 #20;
 sel=3'b10;
  a=32'h42C80000;
 b=32'h41200000;
 #20;
a=32'hC7800000;
 b=32'h42C80000;
#30 $display($time , "  %b",out);
a=32'hCE000000;
 b=32'h3F800000;
#30 $display($time , "  %b",out);
a=32'h4F000000;
 b=32'hC0000000;
#30 $display($time , "  %b",out);
a=32'h47C35000;
 b=32'hC7C35000;
#30 $display($time , "  %b",  out);
sel=2'b10;
 a=32'h00000000;
 b=32'h00000000;
#30 $display($time , "  %b",  out);
a =32'b00000000000000000110000000000000;
b =32'b00000000000000000010000000000000;
#30;
end

endmodule
