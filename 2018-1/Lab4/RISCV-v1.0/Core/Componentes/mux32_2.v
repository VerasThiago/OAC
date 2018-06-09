module mux32_2(
	input sel,
	input [31:0] dado0,
	input [31:0] dado1,
	output reg [31:0] saida
	);
	
	always @(*)
		case (sel)
			1'b0: saida = dado0;
			1'b1: saida = dado1;
			default: saida = 32'b0;
		endcase
			
endmodule
	