module cpu_tb;
	reg clk, reset, s, load;
	reg [15:0] in;
	wire [15:0] out;
	wire N, V, Z, w;

	reg err = 0;

	cpu DUT(.clk(clk),.reset(reset),.s(s),.load(load),.in(in),.out(out),.N(N),.V(V),.Z(Z),.w(w));

	initial begin

	//set 1! basic tests, covers all instructions and shifts
		reset = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;
		
		in = 16'b1101000000000011; //MOV R0,#3 -> R0 = 16'b11
		load = 1;
		reset = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R0 != 16'b11)
			err = 1;

		in = 16'b1100000000101000; //MOV R1,R0,LSL#1 -> R1 = R0 * 2 = 16'b110
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R1 != 16'b110)
			err = 1;

		in = 16'b1010000101010000; //ADD R2,R1,R0,LSR#1 -> R2 = R1 + R0 / 2 = 16'b110 + 16'b1 = 16'b111
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R2 != 16'b111)
			err = 1;

		in = 16'b1101001100001110; //MOV R3,#14 -> R3 = 16'b1110
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R3 != 16'b1110)
			err = 1;

		in = 16'b1010101000011011; //CMP R2,R3,ASR#1 -> if(R2 == R3 / 2 (signed)) {Z = 1} -> R2 = 16'b111 and R3 / 2 = 16'b111 so Z = 1
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(Z != 1)
			err = 1;

		in = 16'b1011001010000011; //AND R4,R2,R3 -> R4 = 16'b111 && 16'b0110 = 16'b0110 
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R4 != 16'b0110)
			err = 1;

		in = 16'b1011100010101100; //MVN R5,R4,LSL#1  -> R5 = ~(16'b110 * 2) = 16'b1111111111110011
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R5 != 16'b1111111111110011)
			err = 1;

	//set 2! Messing around with negative numbers
		reset = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;
		
		in = 16'b1101000011111101; //MOV R0,#-3 -> R0 = 16'b1111111111111101
		load = 1;
		reset = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R0 != 16'b1111111111111101)
			err = 1;

		in = 16'b1100000000101000; //MOV R1,R0,LSL#1 -> R1 = R0 * 2 = 16'b1111111111111010
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R1 != 16'b1111111111111010)
			err = 1;

		in = 16'b1010000101000000; //ADD R2,R1,R0 -> R2 = R1 + R0 / 2 = 16'b1111111111111010 + 16'b1111111111111101 = 16'b1111111111110111
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R2 != 16'b1111111111110111)
			err = 1;

		in = 16'b1101001111111000; //MOV R3,#-8 -> R3 = 16'b1111111111111000
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R3 != 16'b1111111111111000)
			err = 1;

		in = 16'b1010101000011011; //CMP R2,R3,ASR#1 -> if(R2 == R3 / 2 (signed)) {Z = 1} -> R2 = 16'b1111111111110111 and R3 / 2 = 16'b1111111111111100 so Z = 0
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(Z != 0)
			err = 1;

		in = 16'b1011001010000011; //AND R4,R2,R3 -> R4 = 16'b1111111111110111 && 16'b1111111111111000 = 16'b1111111111110000
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R4 != 16'b1111111111110000)
			err = 1;

		in = 16'b1011100010101100; //MVN R5,R4,LSL#1  -> R5 = ~(16'b1111111111100000) = 16'b11111
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R5 != 16'b11111)
			err = 1;

//set 3! Testing other corner cases
		reset = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;
		
		in = 16'b1101011000000000; //MOV R6,#0 -> R0 = 16'b0
		load = 1;
		reset = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R6 != 16'b0)
			err = 1;

		in = 16'b1101011100000001; //MOV R7,#127 -> R0 = 16'b1
		load = 1;
		reset = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R7 != 16'b1)
			err = 1;

		in = 16'b1011100000000110; //MVN R0,R6 -> R0 = ~(16'b0) = 16'b1111111111111111
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R0 != 16'b1111111111111111)
			err = 1;

		in = 16'b1010011101000000; //ADD R2,R7,R0 -> R2 = R1 + R0 = 16'b1 + 16'b1111111111111111 = 16'b0, this tests overflow
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R2 != 16'b0)
			err = 1;


		in = 16'b1100000001111011; //MOV R3,R3,ASR#1 -> R3 = R3 / 2 (signed) = 16'b1111111111111100, acctually test ASR, tests with same reg
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R3 != 16'b1111111111111100)
			err = 1;

		in = 16'b1011010111100101; //AND R7,R5,R5 -> R5 = 16'b11111 && 16'b11111 = 16'b11111, AND's the same register
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(DUT.DP.REGFILE.R7 != 16'b11111)
			err = 1;

		in = 16'b10101000000000000; //CMP R0,R0 -> if(R0 == R0) {Z = 1} -> R2 = 16'b1111111111111111 and R3 = 16'b1111111111111111 so Z = 1
		load = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		load = 0;
		s = 1;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		s = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		clk = 1;
		#5;
		clk = 0;
		#5;

		if(Z != 1)
			err = 1;

		$stop;
	end
endmodule
