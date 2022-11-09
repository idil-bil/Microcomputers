`define A 4'd0
`define B 4'd1
`define C 4'd2
`define D 4'd3
`define E 4'd4
`define F 4'd5
`define G 4'd6
`define H 4'd7
`define I 4'd8
`define J 4'd9
`define K 4'd10
`define L 4'd11
`define M 4'd12

module lab3_top(
  input [3:0] SW,
  input [3:0] KEY,
  output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  output [9:0] LEDR); // optional: use these outputs for debugging on your DE1-SoC
  reg [3:0] state;

  	always @(negedge KEY[0]) begin
		if(KEY[3] == 0)
			state = `A;
		else begin
			case(state)
				`A: if (SW == 4'd3)
					state = `B;
					else 
					state = `H;
				`B: if (SW == 4'd4)
					state = `C;
					else 
					state = `I;
				`C: if (SW == 4'd4)
					state = `D;
					else 
					state = `J;
				`D: if (SW == 4'd1)
					state = `E;
					else
					state = `K;
				`E: if (SW == 4'd8)
					state = `F;
					else 
					state = `L;
				`F: if (SW == 4'd9)
					state = `G;
					else
					state = `M;
				`G: state = `G;
				`H: state = `I;
				`I: state = `J;
				`J: state = `K;
				`K: state = `L;
				`L: state = `M;
				`M: state = `M;
				default: state = `M;
			endcase
		end
	end

always @* begin
	case (SW)
		0: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b1000000;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		1: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b1111001;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		2: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0100100;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		3: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0110000;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		4: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0011001;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		5: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0010010;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		6: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0000010;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		7: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b1111000;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		8: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0000000;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		9: if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b0010000;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
		default: begin
			if (state == `A | state == `B | state ==`C | state == `D | state == `E | state == `F | state == `H | state == `I | state == `J | state == `K | state == `L) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b0000110;
			HEX3 = 7'b0101111;
			HEX2 = 7'b0101111;
			HEX1 = 7'b1000000;
			HEX0 = 7'b0101111;
			end
			else if (state == `G) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0001100;
			HEX1 = 7'b0000110;
			HEX0 = 7'b0101011;
			end
			else begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
			end
	endcase
	end
endmodule

