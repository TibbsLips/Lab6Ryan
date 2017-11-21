module BCD_4counter (CLK, OF, UF, DIR, EN, OUT, LOAD, LOAD_EN, CLR);
	input CLK, DIR, EN, LOAD_EN, CLR;
	input [15:0] LOAD;
	output [15:0] OUT;
	output OF, UF; //OVER/UNDERFLOW
	
	//ORDER OF PRECEDENCE
	//1. CLR 
	//2. LOAD
	//3. EN
	//4. DIR 1 = up, 0 = down
	
	reg OF0, OF1, OF2, OF3;
	reg UF0, UF1, UF2, UF3;
	reg EN0, EN1, EN2, EN3;
	
	assign EN0 = EN;
	assign EN1 = (EN & OF0) ^ (EN & UF0);
	assign EN2 = (EN & OF1) ^ (EN & UF1);
	assign EN3 = (EN & OF2) ^ (EN & UF2);
	assign OF = OF3;
	assign UF = UF3;
	
	
	BCD_counter bcd0(CLK, OF0, UF0, DIR, EN0, OUT[3:0], LOAD[3:0], LOAD_EN, CLR);
	BCD_counter bcd1(CLK, OF1, UF1, DIR, EN1, OUT[7:4], LOAD[7:4], LOAD_EN, CLR);
	BCD_counter bcd2(CLK, OF2, UF2, DIR, EN2, OUT[11:8], LOAD[11:8], LOAD_EN, CLR);
	BCD_counter bcd3(CLK, OF3, UF3, DIR, EN3, OUT[15:12], LOAD[15:12], LOAD_EN, CLR);

endmodule