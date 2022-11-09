`timescale 1 ps/ 1 ps

module lab3_top_tb;

	reg [3:0] sim_SW;
	reg [3:0] sim_KEY;
	wire [6:0] sim_HEX0, sim_HEX1, sim_HEX2, sim_HEX3, sim_HEX4, sim_HEX5;
	wire [9:0] sim_LEDR; // optional: use these outputs for debugging on your DE1-SoC
	
	lab3_top dut (
	 .SW(sim_SW),
	 .KEY(sim_KEY),
	 .HEX0(sim_HEX0), .HEX1(sim_HEX1), .HEX2(sim_HEX2), .HEX3(sim_HEX3), .HEX4(sim_HEX4), .HEX5(sim_HEX5),
	 .LEDR(sim_LEDR)
	);
	
	initial begin 
		sim_SW = 4'd0;
		sim_KEY[0] = 1'b1;
		sim_KEY[3] = 1'b1;	//sets all switches to off and buttons to unpushed
		#5;

		sim_KEY[3] = 1'b0;
		#5;
		sim_KEY[0] = 1'b0; //resets
		#5;

		sim_KEY[0] = 1'b1;
		sim_KEY[3] = 1'b1; //buttons go back to unpushed
		#5;

		sim_SW = 4'd3;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd4;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd4;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd1;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd8;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;
		
		sim_SW = 4'd9;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;
	
		#10; //it should be open!

		sim_KEY[0] = 1'b1;
		sim_KEY[3] = 1'b1;	//buttons to unpressed
		#5;

		sim_KEY[3] = 1'b0;
		#5;
		sim_KEY[0] = 1'b0; //resets
		#5;

		sim_KEY[0] = 1'b1;
		sim_KEY[3] = 1'b1;	//buttons back to to unpressed
		#5;

		sim_SW = 4'd3;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd4;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd5; //not right!
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd1;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd8;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		sim_SW = 4'd9;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		#10; //should be closed

		sim_SW = 4'd2;
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1; //should remain closed until reset
		#5;

		#10

		sim_KEY[3] = 1'b0;
		#5;
		sim_KEY[0] = 1'b0; //resets
		#5;

		sim_KEY[0] = 1'b1;
		sim_KEY[3] = 1'b1;	//buttons back to to unpressed
		#5;

		sim_SW = 4'd12; //not a valid number should print error
		#5;

		sim_KEY[0] = 1'b0;
		#5;
		sim_KEY[0] = 1'b1;
		#5;

		$stop;

	end
endmodule
		