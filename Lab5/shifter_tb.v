module shifter_tb;
	reg [15:0] in_tb;
	reg [1:0] shift_tb;
	wire [15:0] sout_tb;
	reg err = 0;

	shifter DUT(
		.in(in_tb),
		.shift(shift_tb),
		.sout(sout_tb)
	);

	initial begin
		in_tb = 16'b0101010101010101;
		#5;

		shift_tb = 2'b00;
		#5;

		if(sout_tb != 16'b0101010101010101) //checks if the "do nothing" operation works
			err = 1;

		shift_tb = 2'b01;
		#5;

		if(sout_tb != 16'b1010101010101010) //checks if the "shift left" operation works
			err = 1;

		shift_tb = 2'b10;
		#5;

		if(sout_tb != 16'b010101010101010) //checks if the "shift right" operation works
			err = 1;

		shift_tb = 2'b11;
		#5;

		if(sout_tb != 16'b1010101010101010) //checks if the "shift right wrap around" operation works
			err = 1;

		in_tb = 16'b0000000000001111;
		#5;

		if(sout_tb != 16'b1000000000000111) //checks if the "shift right wrap around" operation works agin
			err = 1;

		$display("err = %d!",err);
	end
endmodule
		