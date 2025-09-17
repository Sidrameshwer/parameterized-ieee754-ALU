module mul_param#(parameter n=32,m=8)(input [(n-1):0]a,b,
output reg [(n-1):0]out);
wire sign;
wire[m:0]expo_add;
wire[m:0]expo,temp;
wire[2*(n-m)-1:0] mant_mul;
wire[n-m-2:0]mant;
wire [(n-1):0]temp_output;
assign sign =a[n-1] ^ b[n-1];
localparam bias = 2**(m-1) -1;
assign expo_add= a[n-2:n-m-1] + b[n-2:n-m-1]; 
assign temp = expo_add - bias;
assign mant_mul = {1'b1,a[(n-m-2):0]} * {1'b1,b[(n-m-2):0]};
assign expo = mant_mul[2*(n-m)-1] ? temp+1:temp;
assign mant = mant_mul[2*(n-m)-1] ? mant_mul[(2*(n-m)-2):n-m] : mant_mul[(2*(n-m)-3):n-m-1];
assign temp_output={sign,expo[m-1:0],mant};

always@(*) 
    begin
    if(!a || !b ) begin
    out=0;
    end
   else if(expo>=255) begin
    out=0;
    end
   else if(expo_add<127) begin
    out=0;
    end
   else begin
    out=temp_output;
    end
    
    end
endmodule 
