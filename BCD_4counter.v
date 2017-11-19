module BCD_4counter (clk, cout, cin, out, mode, load, load_en, a_clr);
	input clk, load_en, a_clr;
	input [1:0] mode;
	//00 = clear (synchronous)
	//01 = up
	//10 = down
	//11 = no change
	input [15:0] load;
	
	output reg [15:0] out;
	output reg cout, cin;
	
	wire [3:0] in0, in1, in2, in3;
	
	
	always @ (posedge clk, negedge a_clr) begin
		if(load_en == 1) begin
			in3 <= load[15:12];
			in2 <= load[11:8];
			in1 <= load[7:4];
			in0 <= load[3:0];
		end
		
	
	
	
	
	
	end

endmodule