module datapath_tb;
	reg clk_tb,loada_tb,loadb_tb,asel_tb,bsel_tb,loadc_tb,loads_tb,write_tb;
	reg [1:0] shift_tb,ALUop_tb,vsel_tb;
	reg [2:0] readnum_tb,writenum_tb;
	reg [7:0] PC_tb;
	reg [15:0] mdata_tb,sximm8_tb,sximm5_tb;

	wire Z_out_tb;
	wire [15:0] C_tb;

	reg err = 0;
	
	datapath DUT
		(
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
		.Z_out(Z_out_tb),
		.sximm5(sximm5_tb),
		.sximm8(sximm8_tb),
		.PC(PC_tb),
		.mdata(mdata_tb),
		.C(C_tb)
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
		#5;

		vsel_tb = 2'd2;
		write_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd0;
		writenum_tb = 3'd0;
		sximm8_tb = 8'd7;
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

		vsel_tb = 2'd1;
		loada_tb = 1;
		readnum_tb = 3'd1;
		writenum_tb = 3'd1;
		PC_tb = 8'd1;
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

		if(C_tb != 16'd15) // checks addition with sximm8 shifted left and PC
			err = 1;

		vsel_tb = 2'd0;
		write_tb = 1;
		loadb_tb = 1;
		readnum_tb = 3'd0;
		writenum_tb = 3'd0;
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

		vsel_tb = 2'd3;
		loada_tb = 1;
		readnum_tb = 3'd1;
		writenum_tb = 3'd1;
		mdata_tb = 8'd8;
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
		ALUop_tb = 2'b01;
		loadc_tb = 1;
		write_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		#5;

		if(C_tb != 16'd1) // checks subtraction with C shifted right and mdata
			err = 1;

		vsel_tb = 2'd0;
		loada_tb = 1;
		bsel_tb = 1;
		write_tb = 1;
		sximm5_tb = 16'd4;
		readnum_tb = 3'd0;
		writenum_tb = 3'd0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		#5

		shift_tb = 2'b00;
		ALUop_tb = 2'b00;
		loadc_tb = 1;
		write_tb = 0;
		#5;

		clk_tb = 1;
		#5;
		clk_tb = 0;
		loadc_tb = 0;
		#5;

		if(C_tb != 16'd5) // checks addition with sximm5 and C
			err = 1;

		$display("err = %d!",err);
	end
endmodule 