module shifter(in,shift,sout);
	input [15:0] in;
	input [1:0] shift;
	output [15:0] sout;
	
	reg [15:0] sout;
	reg temp;

	always @(*) begin
		temp = in[0];

		case(shift)
			0: sout = in;
			1: sout = in << 1;
			2: sout = in >> 1;
			3: begin
				sout = in >> 1;
				sout[15] = temp;
			end
		endcase
	end
endmodule
