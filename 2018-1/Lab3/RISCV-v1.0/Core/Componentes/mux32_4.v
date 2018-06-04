module mux32_4(
	input sel,
	input [31:0] dado0,dado1,dado2,dado3,
	output reg [31:0] saida
	);
	
	always @(*)
		case (sel)
			2'b00: saida = dado0;
			2'b01: saida = dado1;
			2'b10: saida = dado2;
			2'b11: saida = dado3;
			default: saida = 32'b0;
		endcase
			
endmodule