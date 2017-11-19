//Initial VER
module BCD_counter (clk, cout, cin, out, mode, load, load_en, a_clr);
	input clk, load_en, a_clr;
	input [3:0] load;
	input [1:0] mode;
	//00 = no change
	//01 = up
	//10 = down
	//11 = no change
	output reg [3:0] out;
	output reg cout, cin;
	
	always @ (posedge clk, negedge a_clr) begin
		if(load_en == 1) begin
			out <= load;
			cout <= 0;
			cin <= 0;
		end
		else begin
			case(mode)
			2'b00: begin//no change
				out = out;
				cout <= 0;
				cin <= 0;
			end
			2'b01: begin//increment
				if((out >=0) && (out <8)) begin
					out <= out + 1;
					cout <= 0;
					cin <= 0;
				end
				else if(out == 8) begin
					out <= out + 1;
					cout <= 1;
					cin <= 0;
				end
				else begin
					out <= 0;
					cout <= 0;
					cin <= 0;
				end
			end
			2'b10: begin//decrement
				if((out <=9) && (out >1)) begin
					out <= out - 1;
					cout <= 0;
					cin <= 0;
				end
				else if(out == 1) begin
					out <= out - 1;
					cout <= 0;
					cin <= 1;
				end
				else begin
					out <= 9;
					cout <= 0;
					cin <= 0;
				end
			end
			2'b11: begin//no change
				out = out;
				cout <= 0;
				cin <= 0;
			end
		end
		if(a_clr == 0) begin
			out <= 0;
			cout <= 0;
			cin <= 0;
		end
	end
endmodule
	