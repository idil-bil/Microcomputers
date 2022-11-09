module regfile_tb;

	reg [15:0] data_in_tb;
	reg [2:0] writenum_tb, readnum_tb;
	reg write_tb, clk_tb;
 	wire [15:0] data_out_tb;
	reg err = 0;

	regfile DUT(
		.data_in(data_in_tb),
		.writenum(writenum_tb),
		.readnum(readnum_tb),
		.write(write_tb),
		.clk(clk_tb),
		.data_out(data_out_tb)
	);

	initial begin
		data_in_tb = 16'b00011100011100;
		#5;

		writenum_tb = 0;
		readnum_tb = 0;

		write_tb = 1;
		#5;

		if (data_out_tb == 16'b00011100011100) //checking if it changes without clock
			err = 1;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011100011100) //checking to see if data_in was assigned to register 0
			err = 1'b1;

		data_in_tb = 16'b00011100011101;
		#5;

		writenum_tb = 1;
		readnum_tb = 1;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011100011101) //checking to see if data_in was assigned to register 1
			err = 1'b1;

		data_in_tb = 16'b00011100011111;
		#5;

		writenum_tb = 2;
		readnum_tb = 2;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011100011111) //checking to see if data_in was assigned to register 2
			err = 1'b1;

		data_in_tb = 16'b00011100111111;
		#5;

		writenum_tb = 3;
		readnum_tb = 3;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011100111111) //checking to see if data_in was assigned to register 3
			err = 1'b1;

		data_in_tb = 16'b00011101111111;
		#5;

		writenum_tb = 4;
		readnum_tb = 4;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011101111111) //checking to see if data_in was assigned to register 4
			err = 1'b1;

		data_in_tb = 16'b00011111111111;
		#5;

		writenum_tb = 5;
		readnum_tb = 5;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00011111111111) //checking to see if data_in was assigned to register 5
			err = 1'b1;

		data_in_tb = 16'b00111111111111;
		#5;

		writenum_tb = 6;
		readnum_tb = 6;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b00111111111111) //checking to see if data_in was assigned to register 6
			err = 1'b1;

		data_in_tb = 16'b01111111111111;
		#5;

		writenum_tb = 7;
		readnum_tb = 7;
		write_tb = 1;
		#5;

		clk_tb = 1;
		#5;
	
		write_tb = 0;
		clk_tb = 0;
		#5;

		if(data_out_tb != 16'b01111111111111) //checking to see if data_in was assigned to register 7
			err = 1'b1;

		data_in_tb = 16'b0101010101010101;
		#5;
		
		writenum_tb = 2;
		readnum_tb = 2;
		#5;

		clk_tb = 1;
		#5;

		clk_tb = 0;
		#5;

		if(data_out_tb ==  16'b0101010101010101) // checking to see if data_in changes whithout write
			err = 1;

		readnum_tb = 3;
		#5

		if(data_out_tb != 16'b00011100111111) // checking reading whithout writing
			err = 1;

		$display("err = %d!",err); 
	end
endmodule
	