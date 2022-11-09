`define MNONE 2'd0
`define MREAD 2'd1
`define MWRITE 2'd2

module cpu(clk,reset,s,in,out,N,V,Z,w,mem_addr,mem_cmd);
	input clk, reset, s;
	input [15:0] in;
	output N, V, Z, w;
	output [1:0] mem_cmd;
	output [8:0] mem_addr;
	output [15:0] out;
	
	reg N, V, Z, w;
	reg [1:0] mem_cmd;
	reg [8:0] mem_addr;
	reg [15:0] out;

	reg [4:0] state;
	reg [15:0] instruction;
	reg [1:0] op;
	reg [2:0] opcode;
	reg [1:0] nsel,vsel;
	reg [1:0] shift;
	reg [2:0] readnum, writenum;
	reg [15:0] sximm8, sximm5;
	reg asel, bsel, csel;
	reg loada, loadb, loadc, loads, write;
	reg [8:0] PC,next_pc,data_address;

	reg addr_sel,load_pc,reset_pc,load_ir,load_addr;

	wire [2:0] Z_out;
	wire [15:0] C;

	//Instruction Register
	always @(posedge clk) begin
		if(load_ir == 1)
			instruction <= in;
	end

	//Instruction Decoder
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
		if (opcode == 3'b100)
			shift = 2'b00;
		else		
			shift = instruction[4:3];
	end

	//FSM Controller
	always @(posedge clk) begin
		if(reset == 1)
			state = 5'b0;
		else begin
			case(state)
				5'd0: begin //RST
					reset_pc <= 1;
					load_pc <= 1;
					mem_cmd <= `MNONE;
					state <= 5'd1; //to IF1
				end
				5'd1: begin //IF1
					write <= 0;
					loada <= 0;
					loadb <= 0;
					loadc <= 0;
					loads <= 0;
					load_ir <= 0;
					load_addr <=0;
					asel <= 0;
					bsel <= 0;
					vsel <= 0;
					nsel <= 0;

					reset_pc <= 0;
					load_pc <= 0;
					addr_sel <= 1;
					mem_cmd <= `MREAD;
					state <= 5'd2; //to IF2
				end
				5'd2: begin //IF2
					load_ir <= 1;
					state <= 5'd3; //to UpdatePC
				end
				5'd3: begin //UpdatePC
					addr_sel <= 0;
					mem_cmd <= `MNONE;
					load_ir <= 0;
					load_pc <= 1;
					state <= 5'd4; //to Decode
				end
				5'd4: begin //Decode
					load_pc <= 0;

					w = 1;

					if(s == 1) begin
						w = 0;
						if(opcode == 3'b110) begin
							case(op)
								2'b00: state = 5'd5; //MOV Rd,Rm{,<sh_op>} 
								2'b10: state = 5'd8; //MOV Rn,#<im8>
							endcase
						end
						if(opcode == 3'b101) begin
							case(op)
								2'b00: state = 5'd9; //ADD Rd,Rn,Rm{,<sh_op>}
								2'b01: state = 5'd13; //CMP Rn,Rm{,<sh_op>}
								2'b10: state = 5'd9; //AND Rd,Rn,Rm{,<sh_op>}
								2'b11: state = 5'd10; //MVN Rd,Rm{,<sh_op>}
							endcase
						end
						if(opcode == 3'b011)
							state = 5'd16; //LDR Rd,[Rn{,#im5}]
						if(opcode == 3'b100)
							state = 5'd16; //STR Rd,[Rn{,#im5}]
						if(opcode == 3'b111)
							state = 5'd24; //HALT
					end
				end
				5'd5: begin //MOV Rd,Rm{,<sh_op>} (1->3)
					nsel = 2'd0;
					asel = 1;
					loadb = 1;
					state = 5'd2;
				end //Loads Rm to b and sets asel to 1
				5'd6: begin
					loadb = 0;
					loadc = 1;
					state = 5'd3;
				end //Loads C
				5'd7: begin
					loadc = 0;
					vsel = 2'd0;
					nsel = 2'd1;
					write = 1;
					state = 5'd1;
				end //Puts C in Rd
				5'd8: begin //MOV Rn,#<im8>
					nsel = 2'd2;
					vsel = 2'd2;
					write = 1;
					state = 5'd1;
				end //Puts sximm8 into Rn
				5'd9: begin //ADD Rd,Rn,Rm{,<sh_op>} (5->8) and AND Rd,Rn,Rm{,<sh_op>} (6-8)
					nsel = 2'd2;
					loada = 1;
					state = 5'd10;
				end //Loads Rn to A
				5'd10: begin //MVN Rd,Rm{,<sh_op>}
					loada = 0;
					loadb = 1;
					nsel = 2'd0;
					state = 5'd11;
				end //Loads Rm to B
				5'd11: begin
					loadb = 0;
					loadc = 1;
					state = 5'd12;
				end //Loads C
				5'd12: begin
					loadc = 0;
					vsel = 2'd0;
					nsel = 2'd1;
					write = 1;
					state = 5'd1;
				end //Sets Rd to C
				5'd13: begin //CMP Rn,Rm{,<sh_op>}
					nsel = 2'd2;
					loada = 1;
					state = 5'd14;
				end //Loads Rn to A
				5'd14: begin
					nsel = 2'd0;
					loada = 0;
					loadb = 1;
					state = 5'd15;
				end //Loads Rm to B
				5'd15: begin
					loadb = 0;
					loads = 1;
					state = 5'd1;
				end //Loads status
				5'd16: begin //LDR Rd,[Rn{,#im5}] and STR Rd,[Rn{,#im5}]
					nsel = 2'd2;
					loada = 1;
					state = 5'd17;
				end //Loads Rn to A
				5'd17: begin
					loada = 0;
					bsel = 1;
					loadc = 1;
					state = 5'd18;
				end //Loads C with A + sximm5
				5'd18: begin
					loadc = 0;
					bsel = 0;
					load_addr = 1;
					if (opcode == 3'b011)
						state = 5'd19; //continues to LDR
					if (opcode == 3'b100)
						state = 5'd21; //continues to STR
				end //Loads Data Address with C[8:0]
				5'd19: begin //LDR continued
					load_addr = 0;
					addr_sel = 0;
					mem_cmd = `MREAD;
					state = 5'd20;
				end //Reads data in RAM at data adress
				5'd20: begin
					mem_cmd = `MNONE;
					vsel = 2'd3;
					nsel = 2'd1;
					write = 1;
					state = 5'd1;
				end //Writes data read in Rd
				5'd21: begin //STR continued
					load_addr = 0;
					addr_sel = 0;
					nsel = 2'd1;
					loadb = 1;
					state = 5'd22;
				end //Loads Rd into B
				5'd22: begin
					nsel = 2'd0;
					loadb = 0;
					asel = 1;
					loadc = 1;
					state = 5'd23;
				end //Loads B into C
				5'd23: begin
					asel = 0;
					loadc = 0;
					mem_cmd = `MWRITE;
					state = 5'd1;
				end //Writes C into RAM at adress set in data address
				5'd24: begin //HALT
					state = 5'd24;
				end
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
		.mdata(in),
		.C(C)
		);

	//Output Assignment
	always @(*) begin
		out = C;
		Z = Z_out[0];
		N = Z_out[1];
		V = Z_out[2];
	end

	//PC Reset MUX
	always @(*) begin
		if (reset_pc == 1)
			next_pc = 9'b0;
		else
			next_pc = PC + 9'b1;
	end

	//Adder Select MUX
	always @(*) begin
		if (addr_sel == 1)
			mem_addr = PC;
		else
			mem_addr = data_address;
	end

	//Program Counter Register
	always @(posedge clk) begin
		if (load_pc == 1)
			PC <= next_pc;
	end

	always @(posedge clk) begin
		if (load_addr == 1)
			data_address = out[8:0];
	end

endmodule
