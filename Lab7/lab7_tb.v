module lab7_tb;
	reg [3:0] KEY;
	reg [9:0] SW;
	wire [9:0] LEDR;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	lab7_top DUT (KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

  	initial forever begin
		DUT.clk = 1; #5;
  	  	DUT.clk = 0; #5;
  	end

	initial begin
		DUT.reset = 1;
		DUT.s = 1;
		#5;

		DUT.reset = 0;
		#500;



		$stop;
	end
endmodule
