module ALU_tb;
	reg [15:0] Ain_tb, Bin_tb;
	reg [1:0] ALUop_tb;
	wire [15:0] out_tb;
	wire Z_tb;
	reg err = 0;
	
	ALU DUT(
		.Ain(Ain_tb),
		.Bin(Bin_tb),
		.ALUop(ALUop_tb),
		.out(out_tb),
		.Z(Z_tb)
	);

	initial begin
		Ain_tb = 16'b0000000000101010;
		Bin_tb = 16'b0000000000101000;
		#5;

		ALUop_tb = 2'b00;
		#5;

		if(out_tb != 16'b0000000001010010) // checks if addition works
			err = 1;

		ALUop_tb = 2'b01;
		#5;

		if(out_tb != 16'b0000000000000010) // checks if subtraction works
			err = 1;

		ALUop_tb = 2'b10;
		#5;

		if(out_tb != 16'b0000000000101000) // checks if AND works
			err = 1;

		ALUop_tb = 2'b11;
		#5;

		if(out_tb != 16'b1111111111010111) // checks if NOT works
			err = 1;
		
		Bin_tb = 16'b1111111111111111;
		#5;

		if(out_tb != 16'b0000000000000000 || Z_tb != 1) // checks if NOT works againg and if Z works
			err = 1;

		Ain_tb = 16'b0000000000101000;
		Bin_tb = 16'b0000000000101001;
		#5;

		ALUop_tb = 2'b01;
		#5;

		if(out_tb != 16'b1111111111111111) // checks if subtracting to get negative numbers works
			err = 1;

		$display("err = %d!",err);
	end
endmodule
