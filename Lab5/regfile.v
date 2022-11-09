module regfile(data_in,writenum,write,readnum,clk,data_out);
 input [15:0] data_in;
 input [2:0] writenum, readnum;
 input write, clk;
 output reg [15:0] data_out;
 reg [15:0] R0,R1,R2,R3,R4,R5,R6,R7;

always @(*) begin
	case(readnum)
		0: data_out = R0;
		1: data_out = R1;
		2: data_out = R2;
		3: data_out = R3;
		4: data_out = R4;
		5: data_out = R5;
		6: data_out = R6;
		7: data_out = R7;
	endcase
end

always @(posedge clk) begin
	if(write == 1) begin
		case(writenum)
			0: R0 = data_in;
			1: R1 = data_in;
			2: R2 = data_in;
			3: R3 = data_in;
			4: R4 = data_in;
			5: R5 = data_in;
			6: R6 = data_in;
			7: R7 = data_in;
		endcase
	end
end

endmodule
