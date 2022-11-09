module ALU(Ain,Bin,ALUop,out,Z);
	input [15:0] Ain, Bin;
	input [1:0] ALUop;
	output [15:0] out;
	output [2:0] Z;

	reg [15:0] out;
	reg [2:0] Z = 1'b0;

	always @(*) begin
		case(ALUop)
			0: out = Ain + Bin;
			1: out = Ain - Bin;
			2: out = Ain & Bin;
			3: out = ~Bin;
		endcase

		if(out == 16'b0)
			Z[0] = 1'b1;
		else
			Z[0] = 1'b0;

		if(out[15] == 1)
			Z[1] = 1'b1;
		else
			Z[1] = 1'b0;
		if(Ain[15] == Ain[15] && Ain[15] != out[15])
			Z[2] = 1'b1;
		else
			Z[2] = 1'b0;
	end
endmodule
