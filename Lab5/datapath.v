module datapath (clk,readnum,vsel,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,writenum,write,datapath_in,Z_out,datapath_out);
	input clk,vsel,loada,loadb,asel,bsel,loadc,loads,write;
	input [1:0] shift,ALUop;
	input [2:0] readnum,writenum;
	input [15:0] datapath_in;

	output reg Z_out;
	output reg [15:0] datapath_out;

	reg [15:0] data_in,A,B,C,Ain,Bin;
	wire Z;
	wire[15:0] data_out,sout,out;


	//9, MUX with vsel
	always @(*) begin
		if(vsel ==1)
			data_in = datapath_in;
		else
			data_in = datapath_out;
	end

	//1, register file
	regfile REGFILE (.data_in(data_in),.writenum(writenum),.write(write),.readnum(readnum),.clk(clk),.data_out(data_out));

	//3, register A
	always @(posedge clk) begin
		if(loada == 1)
			A = data_out;
	end

	//6, MUX with asel
	always @(*) begin
		if(asel == 1)
			Ain = 16'b0;
		else
			Ain = A;
	end

	//4 register B
	always @(posedge clk) begin
		if(loadb == 1)
			B = data_out;
	end
	
	//8 shifter
	shifter SHIFTER (.in(B),.shift(shift),.sout(sout));

	//7 MUX with bsel
	always @(*) begin
		if(bsel == 1)
			Bin = {11'b0,datapath_in[4:0]};
		else
			Bin = sout;
	end

	//2 arithmetic logic unit
	ALU alu(.Ain(Ain),.Bin(Bin),.ALUop(ALUop),.out(out),.Z(Z));

	//10 status register
	always @(posedge clk) begin
		if(loads == 1)
			Z_out = Z;
	end

	//5 register C
	always @(posedge clk) begin
		if(loadc == 1) begin
			C = out;
			datapath_out = out;
		end
			
	end
endmodule
