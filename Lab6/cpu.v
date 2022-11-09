module cpu(clk,reset,s,load,in,out,N,V,Z,w);
	input clk, reset, s, load;
	input [15:0] in;
	output [15:0] out;
	output N, V, Z, w;
	
	reg [15:0] out;
	reg N, V, Z, w;

	reg [3:0] state;
	reg [15:0] instruction;
	reg [1:0] op;
	reg [2:0] opcode;
	reg [1:0] nsel,vsel;
	reg [1:0] shift;
	reg [2:0] readnum, writenum;
	reg [15:0] sximm8, sximm5;
	reg asel, bsel, csel;
	reg loada, loadb, loadc, loads, write;
	reg [7:0] PC;
	reg [15:0] mdata;

	wire [2:0] Z_out;
	wire [15:0] C;

	//Instruction Register
	always @(posedge clk) begin
		if(load == 1)
			instruction = in;
	end

	//MUX with nsel
	always @(*) begin
	//To Controller FSM
		opcode = instruction[15:13];
		op  = instruction[12:11];
	//To Datapath
		//MUX with nsel
		case(nsel)
			0: begin
				readnum = instruction[2:0];
				writenum = instruction[2:0];
			end
			1: begin
				readnum = instruction[7:5];
				writenum = instruction[7:5];
			end
			2: begin
				readnum = instruction[10:8];
				writenum = instruction[10:8];
			end
			default: begin
				readnum = instruction[10:8];
				writenum = instruction[10:8];
			end
		endcase
		//Sign Extender
		if(instruction[7] == 0)
			sximm8 = {8'b00000000,instruction[7:0]};
		else
			sximm8 = {8'b11111111,instruction[7:0]};
		if(instruction[4] == 0)
			sximm5 = {11'b00000000000,instruction[4:0]};
		else
			sximm5 = {11'b11111111111,instruction[4:0]};

		//Shift Assignment
		shift = instruction[4:3];
	end

	//FSM Controller
	always @(posedge clk) begin
		if(reset == 1)
			state = 0;
		else begin
			case(state)
				0: begin
					w = 1;
					write = 0;
					loada = 0;
					loadb = 0;
					loadc = 0;
					loads = 0;
					asel = 0;
					bsel = 0;
					vsel = 0;
					nsel = 0;

					if(s == 1) begin
						w = 0;
						if(opcode == 3'b110) begin
							case(op)
								0: state = 4'd1; //MOV Rd,Rm{,<sh_op>} 
								2: state = 4'd4; //MOV Rn,#<im8>
							endcase
						end
						if(opcode == 3'b101) begin
							case(op)
								0: state = 4'd5; //ADD Rd,Rn,Rm{,<sh_op>}
								1: state = 4'd9; //CMP Rn,Rm{,<sh_op>}
								2: state = 4'd5; //AND Rd,Rn,Rm{,<sh_op>}
								3: state = 4'd6; //MVN Rd,Rm{,<sh_op>}
							endcase
						end
					end
				end
				1: begin //MOV Rd,Rm{,<sh_op>} (1->3)
					nsel = 2'd0;
					asel = 1;
					loadb = 1;
					state = 4'd2;
				end //Loads Rm to b and sets asel to 1
				2: begin
					loadb = 0;
					loadc = 1;
					state = 4'd3;
				end //Loads C
				3: begin
					loadc = 0;
					vsel = 2'd0;
					nsel = 2'd1;
					write = 1;
					state = 4'b0;
				end //Puts C in Rd
				4: begin //MOV Rn,#<im8>
					nsel = 2'd2;
					vsel = 2'd2;
					write = 1;
					state = 4'd0;
				end //Puts sximm8 into Rn
				5: begin //ADD Rd,Rn,Rm{,<sh_op>} (5->8) and AND Rd,Rn,Rm{,<sh_op>} (6-8)
					nsel = 2'd2;
					loada = 1;
					state = 4'd6;
				end //Loads Rn to A
				6: begin //MVN Rd,Rm{,<sh_op>}
					loada = 0;
					loadb = 1;
					nsel = 2'd0;
					state = 4'd7;
				end //Loads Rm to B
				7: begin
					loadb = 0;
					loadc = 1;
					state = 4'd8;
				end //Loads C
				8: begin
					loadc = 0;
					vsel = 2'd0;
					nsel = 2'd1;
					write = 1;
					state = 4'b0;
				end //Sets Rd to C
				9: begin //CMP Rn,Rm{,<sh_op>}
					nsel = 2'd2;
					loada = 1;
					state = 4'd10;
				end //Loads Rn to A
				10: begin
					nsel = 2'd0;
					loada = 0;
					loadb = 1;
					state = 4'd11;
				end //Loads Rm to B
				11: begin
					loadb = 0;
					loads = 1;
					state = 4'b0;
				end //Loads status

			endcase			
		end
	end

	//Datapath
	datapath DP
		(
		.clk(clk),
		.readnum(readnum),
		.vsel(vsel),
		.loada(loada),
		.loadb(loadb),
		.shift(shift),
		.asel(asel),
		.bsel(bsel),
		.ALUop(op),
		.loadc(loadc),
		.loads(loads),
		.writenum(writenum),
		.write(write),
		.Z_out(Z_out),
		.sximm5(sximm5),
		.sximm8(sximm8),
		.PC(PC),
		.mdata(mdata),
		.C(C)
		);

	//Output Assignment
	always @(*) begin
		out = C;
		Z = Z_out[0];
		N = Z_out[1];
		V = Z_out[2];
	end
endmodule
