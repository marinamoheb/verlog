
module add #(parameter x=8)(input logic [x-1:0] exp1,exp2,output logic[x-1:0] y);
assign y=exp1+exp2-127;
endmodule

module  mult #(parameter x=23)(input logic [x-1:0] mant1,mant2,output logic[47:0] y);
logic[x:0]m1,m2;
assign ma={1'b1,mant1};
assign mb={1'b1,mant1};
assign y = mant1 * mant2;
endmodule

module  sign #(parameter x=1)(input logic sign1,sign2,output logic m);
assign m=sign1 ^ sign2;
endmodule

module  norm #(parameter x=8)(input logic [47:0] result,input logic[x-1:0] expo,output logic[22:0] y,output logic[x-1:0]expres);
assign y = result[47] ?result[46:24] :result[45:23]; 
assign expres=expo-1;
endmodule

module fp(input logic [31:0] a, b,output logic [31:0] m);
logic [7:0] expa, expb, expres,expo;
logic [23:0] manta, mantb,mantres;
logic signa,signb,signres;
logic [47:0] result;
assign {expa, manta} = {a[30:23], a[22:0]};
assign {expb, mantb} = {b[30:23], b[22:0]};
assign signa=a[31];
assign signb=b[31];
mult(manta,mantb,result);
add(expa,expb,expo);
sign(signa,signb,signres);
norm(result,expo,mantres,expres);
assign m={signres,expres,mantres};
endmodule


module test1 ();
 logic [31:0] a,b,y;
 fp(a,b,y);
 intial begin
       a=32'b01100000000000000000000000000000;
       b=32'b11001000000000000000000000000000;
      if(y==32'b000001001100000000000000000000) $display("right answer");
 end 
endmodule
module test ();
 logic [31:0] a,b,y;
 fp(a,b,y);
 intial begin
       a=32'b00111111100001100110011001100110;
       b=32'b00111111100001100110011001100110;
      if(y==32'b00111111000011010001111010110111) $display("right answer");
 end 
endmodule


