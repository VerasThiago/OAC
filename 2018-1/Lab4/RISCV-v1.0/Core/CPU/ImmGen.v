/*
 * Imm Generator
 *
 */

module ImmGen (
	input [31:0] Instruction,
	output [31:0] oImm
);

wire [6:0] Opc;


assign Opc =  Instruction[6:0];

			
always @(*)
begin
	case (Opc)
		OPCLOGICIMM,
		OPCLOAD,
		OPCJALR:
			oImm = { {20{ Instruction[31] }}, Instruction[31:20] };
		OPCSTORE:
			oImm = { {20{ Instruction[31] }}, Instruction[31:25], Instruction[11:7] };
		OPCBRANCH:
			oImm = { {20{ Instruction[31] }}, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0 };
		OPCUTYPE:
			oImm = { Instruction[31:12], 12'b0};
		OPCJAL:
			oImm = { {20{ Instruction[31] }}, Instruction[30:12], 1'b0 };
	endcase
end

endmodule