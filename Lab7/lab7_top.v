`define MNONE 2'd0
`define MREAD 2'd1
`define MWRITE 2'd2

module lab7_top(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input [3:0] KEY;
	input [9:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	reg [9:0] LEDR;
	reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	reg clk,reset,s,load,ten_out,nine_out,eight_out;
	wire N,V,Z,w,enable,write;
	wire [1:0] mem_cmd;
	wire [8:0] mem_addr;
	wire [15:0] out,dout,read_data;
	

	cpu CPU (.clk(clk),.reset(reset),.s(s),.in(read_data),.out(out),.N(N),.V(V),.Z(Z),.w(w),.mem_addr(mem_addr),.mem_cmd(mem_cmd));

	RAM MEM (.clk(clk),.read_address(mem_addr[7:0]),.write_address(mem_addr[7:0]),.write(write),.din(out),.dout(dout));

	always @(*) begin
		if (mem_cmd == `MWRITE)
			ten_out = 1'b1;
		else
			ten_out = 1'b0;
		if (mem_cmd == `MREAD)
			nine_out = 1'b1;
		else
			nine_out = 1'b0;

		if (mem_addr[8] == 1'b0)
			eight_out = 1'b1;
		else
			eight_out = 1'b0;
	end

	assign enable = eight_out & nine_out;

	assign write = eight_out & ten_out;

	assign read_data = enable ? dout : {16{1'bz}};
	
endmodule
