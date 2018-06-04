/*
 * ALU
 *
 * Arithmetic Logic Unit with control signals as defined by the COD book:
 *
 * Signal controls in ALUOP.v
 */
module ALU (
	input iCLK, iRST,
	input signed [31:0] iA, iB,
	input [5:0] iControlSignal,
	output oChangePC,
	output [31:0] oALUresult
	);

wire [63:0] mul, mulu, mulsu;
assign mul = iA*iB;
assign mulu = $unsigned(iA)*$unsigned(iB);
assign mulsu= $unsigned(iA)*iB;

assign oChangePC = (oALUresult == ZERO);

			
always @(*)
begin
	case (iControlSignal)
		OPAND:
			oALUresult  = iA & iB;
		OPOR:
			oALUresult  = iA | iB;
		OPADD:
			oALUresult  = iA + iB;
		OPSLL:
			oALUresult  = iA << iB;
		OPSUB:
			oALUresult  = iA - iB;
		OPSLT:
			oALUresult  = iA < iB;
		OPSRL:
			oALUresult  = iA >> iB;
		OPSRA:
			oALUresult  = iA >>> iB;
		OPXOR:
			oALUresult  = iA ^ iB;
		OPSLTU:
			oALUresult  = $unsigned(iA) < $unsigned(iB);	
		OPLUI:
			oALUresult  = {iB[19:0],12'b0};
		OPMUL:
			oALUresult  = mul[31:0];
		OPDIV:
			oALUresult  = iA / iB;
		OPDIVU:
			oALUresult  = $unsigned(iA) / $unsigned(iB);
		OPREM:
			oALUresult  = iA % iB;
		OPREMU:
			oALUresult  = $unsigned(iA) % $unsigned(iB);
		OPMULH:
			oALUresult  = mul[63:32];
		OPMULHU:
			oALUresult  = mulu[63:32];
		OPMULHSU:
			oALUresult  = mulsu[63:32];	
		OPBNE:
			oALUresult = iA == iB;// Se iA != iB entao a igualdade é falsa e o oALUresult = 0, com isso o pino do oZero = 1 e assim o pc vai pra branch
		OPBLT:
			oALUresult = iA >= iB;// Se iA < iB então essa condição é falsa e o oALUresult = 0, com isso o pino do oZero = 1 e assim o pc vai pra branch
		OPBGE:			
			oALUresult = iA < iB;// Se iA >= iB então essa condição é falsa e o oALUresult = 0, com isso o pino do oZero = 1 e assim o pc vai pra branch
		OPBLTU:
			oALUresult = $unsigned(iA) >= $unsigned(iB);  // Mesmo que o OPBLT
		OPBGEU:
			oALUresult = $unsigned(iA) < $unsigned(iB);   // Mesmo que o OPBGEU
		default:
			oALUresult  = ZERO;
	endcase
end

endmodule
