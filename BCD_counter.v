//VER 2
module BCD_counter (CLK, OF, UF, DIR, EN, OUT, LOAD, LOAD_EN, CLR);
	input CLK, DIR, EN, LOAD_EN, CLR;
	input [3:0] LOAD;
	output [3:0] OUT;
	output OF, UF; //OVER/UNDERFLOW
	
	//ORDER OF PRECEDENCE
	//1. CLR 
	//2. LOAD
	//3. EN
	//4. DIR 1 = up, 0 = down
	
	always @ (posedge CLK, negedge CLR) begin
		
		if(CLR == 1'b0) begin //priority 1
			OUT <= 4'b0000;
			OF <= 1'b0;
			UF <= 1'b0;
		end
		else if (LOAD_EN == 1'b1) begin //priority 2
			OUT <= LOAD;
			OF <= (LOAD == 4'b1001);
			UF <= (LOAD == 4'b0000);
		end
		else if (EN == 1'b1) begin //priority 3
			if(DIR == 1'b1) begin //up
				if(OUT == 4'b1001) begin // 9 to 0
					OUT <= 4'b0000;
					UF <= 1'b1;
					OF <= 1'b0;
				end
				else begin
					OUT <= OUT + 1;
					UF <= 1'b0;
					OF <= ((OUT + 1) == 9); // overflow if OUT +1 is 9
				end
			end
			else begin//down
				if(OUT == 4'b0000) begin // 0 to 9
					OUT <= 4'b1001;
					UF <= 1'b0;
					OF <= 1'b1;
				end
				else begin
					OUT <= OUT - 1;
					UF <= ((OUT - 1) == 0);
					OF <= 1'b0; // overflow if OUT +1 is 9
				end
			end
		end
	end
	
endmodule