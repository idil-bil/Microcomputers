module datapath_tb;
	reg clk_tb,vsel_tb,loada_tb,loadb_tb,asel_tb,bsel_tb,loadc_tb,loads_tb,write_tb;
	reg [1:0] shift_tb,ALUop_tb;
	reg [2:0] readnum_tb,writenum_tb;
	reg [15:0] datapath_in_tb;

	wire Z_out_tb;
	wire [15:0] datapath_out_tb;

	reg err = 0;
	
	datapath DUT ( 
		.clk(clk_tb),
		.readnum(readnum_tb),
                .vsel(vsel_tb),
                .loada(loada_tb),
                .loadb(loadb_tb),
                .shift(shift_tb),
                .asel(asel_tb),
                .bsel(bsel_tb),
                .ALUop(ALUop_tb),
                .loadc(loadc_tb),
                .loads(loads_tb),
                .writenum(writenum_tb),
                .write(write_tb),  
                .datapath_in(datapath_in_tb),
                .Z_out(Z_out_tb),
                .datapath_out(datapath_out_tb)
	);

	initial begin
		clk_tb = 0;
		vsel_tb = 0;
		write_tb = 0;
		loada_tb = 0;
		loadb_tb = 0;
		loadc_tb = 0;
		shift_tb = 2'b00;
		ALUop_tb = 2'b00;
		asel_tb = 0;
		bsel_tb = 0;
		readnum_tb = 3'd0;
		readnum_tb = 3'd0;
		datapath_in_tb = 16'b0;
		#5;

		vsel_tb = 1;
		write_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd0;
		writenum_tb = 3'd0;
		datapath_in_tb = 16'b0000000000000111;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadb_tb = 0;
		#5

		loada_tb = 1;
		readnum_tb = 3'd1;
		writenum_tb = 3'd1;
		datapath_in_tb = 16'b0000000000000010;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loada_tb = 0;
		#5;

		shift_tb = 2'b01;
		ALUop_tb = 2'b00;
		loadc_tb = 1;
		write_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		#5;

		if(datapath_out_tb != 16'b0000000000010000) // checks 2 external inputs with addition and shifting to the left
			err = 1;

		vsel_tb = 0;
		write_tb = 1;
		writenum_tb = 3'd2;
		readnum_tb = 3'd2;
		loada_tb = 1;
		#5

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loada_tb = 0;
		#5;

		vsel_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd3;
		writenum_tb = 3'd3;
		datapath_in_tb = 16'b0000000000001001;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadb_tb = 0;
		#5

		shift_tb = 2'b00;
		ALUop_tb = 2'b01;
		loadc_tb = 1;
		write_tb = 0;
		#5;
		
		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		write_tb = 0;
		#5;

		if(datapath_out_tb != 16'b0000000000000111) // checks the previous output and a external input with subtraction
			err = 1;

		write_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd4;
		writenum_tb = 3'd4;
		datapath_in_tb = 16'b1010101010101010;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadb_tb = 0;
		#5

		loada_tb = 1;
		readnum_tb = 3'd5;
		writenum_tb = 3'd5;
		datapath_in_tb = 16'b1010101010101010;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loada_tb = 0;
		#5;

		shift_tb = 2'b10;
		ALUop_tb = 2'b10;
		loadc_tb = 1;
		loads_tb = 1;
		write_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		loads_tb = 0;
		#5;

		if(datapath_out_tb != 16'b0000000000000000 || Z_out_tb != 1) // checks 2 external inputs with AND and shifting to the right, also tests Z_out
			err = 1;

		write_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd6;
		writenum_tb = 3'd6;
		datapath_in_tb = 16'b0000000000000001;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadb_tb = 0;
		#5

		shift_tb = 2'b11;
		ALUop_tb = 2'b11;
		loadc_tb = 1;
		loads_tb = 1;
		write_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		loads_tb = 0;
		#5;

		if(datapath_out_tb != 16'b0111111111111111 || Z_out_tb != 0) // checks 1 external input with NOT and shifting to the right with wrap around, also tests if Z_out truns off
			err = 1;
		
		$display("err = %d!",err);
	end
endmodule 