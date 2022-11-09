module datapath (clk,readnum,vsel,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,writenum,write,Z_out,sximm5,sximm8,PC,mdata,C);
	input clk,loada,loadb,asel,bsel,loadc,loads,write;
	input [1:0] vsel,shift,ALUop;
	input [2:0] readnum,writenum;
	input [8:0] PC;
	input [15:0] sximm5,sximm8, mdata;

	output reg [2:0] Z_out;
	output reg [15:0] C;

	reg [15:0] data_in,A,B,Ain,Bin;
	wire [2:0] Z;
	wire [15:0] data_out,sout,out;


	//9, MUX with vsel
	always @(*) begin
		case(vsel)
			0: data_in = C;
			1: data_in = {7'b0, PC};
			2: data_in = sximm8;
			3: data_in = mdata;
		endcase
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
			Bin = sximm5;
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
		end
			
	end
endmodule
