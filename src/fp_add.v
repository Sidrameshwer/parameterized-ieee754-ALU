module add_sub#(parameter n=32,m=8)(input [(n-1):0]a,b,
output [(n-1):0]sum);
//output reg overflow, underflow);
wire [m-1:0]expo1=a[n-2:n-m-1];
wire [m-1:0]expo2=b[n-2:n-m-1]; 
reg [m-1:0]sub,exp_temp;
reg [m:0]exp;
reg [n-m-1:0]temp1;
reg [n-m:0]sum_mant;
reg [n-m-2:0]mant;
reg sign;
//wire [(n-1):0]temp_sum;
assign sum={sign,exp[m-1:0],mant};

always @(*) 
    begin
        if(~(a[n-1]^b[n-1])) 
            begin
                sign=a[n-1];
                    if(a>b) 
                        begin
                            exp_temp=expo1;
                            sub=expo1-expo2;
                            temp1=({1'b1,b[(n-m-2):0]}>>sub);
                            sum_mant= {1'b1,a[(n-m-2):0]}+temp1;
                        end 
                    else if(a==b && (!a) &&( !b)) 
                        begin
                            sign=1'b0;
                            sum_mant=0;
                            exp_temp=0;
                        end
                    else 
                        begin
                            exp_temp=expo2;
                            sub=expo2-expo1;
                            temp1=({1'b1,a[(n-m-2):0]}>>sub) ;
                            sum_mant= {1'b1,b[(n-m-2):0]}+temp1;
                        end
                    end

        else 
            begin
                if(a[n-2:0]>b[n-2:0]) 
                    begin
                        sign=a[n-1];
                        exp_temp=expo1;
                        sub=expo1-expo2;
                        temp1=({1'b1,b[(n-m-2):0]}>>sub);
                        sum_mant= {1'b1,a[(n-m-2):0]}+(~temp1+1);

                    end 
                else if(a[n-2:0]<b[n-2:0]) 
                    begin
                        sign=b[n-1];
                        exp_temp=expo2;
                        sub=expo2-expo1;
                        temp1=({1'b1,a[(n-m-2):0]}>>sub);
                        sum_mant= {1'b1,b[(n-m-2):0]}+(~temp1)+1;

                    end
                else 
                    begin
                        sign=1'b0;
                        sum_mant=0;
                        exp_temp=0;
                    end
            end
        end

integer i;
always @(*) 
    begin
        if(sum_mant[n-m]) 
            begin
                exp=exp_temp+1;
                mant=sum_mant[n-m-1:1];
            end
        else
            begin:block
                for(i=n-m-1;i>0;i=i-1) 
                    begin
                        if(sum_mant[i]) 
                            begin
                                exp=exp_temp+i-(n-m-1);
                                mant=sum_mant[n-m-2:0]<<((n-m-1)-i);
                                disable block;
                            end
                        else 
                            begin
                                exp=exp_temp;
                                mant=sum_mant;
                            end
                    end  
            end
    end
endmodule
