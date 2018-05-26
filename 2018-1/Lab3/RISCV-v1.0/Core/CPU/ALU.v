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
	input [4:0] iShamt,
	output oZero, oOverflow,
	output [31:0] oALUresult
	);

reg [31:0] HI, LO;
reg [63:0] TMP;

assign oZero = (oALUresult == 32'b0);

initial
begin
    {HI,LO} <= 64'b0;
end

assign oOverflow = iControlSignal==OPADD ?
        ((iA[31] == 0 && iB[31] == 0 &&  oALUresult[31] == 1) || (iA[31] == 1 && iB[31] == 1 && oALUresult[31] == 0))
        : iControlSignal==OPSUB ?
            ((iA[31] == 0 && iB[31] == 1 && oALUresult[31]== 1)|| (iA[31] == 1 && iB[31] == 0 && oALUresult[31] == 0))
            : 1'b0;
			
always @(*)
begin
	case (iControlSignal)
		OPAND:
			oALUresult  = iA & iB;
		OPOR:
			oALUresult  = iA | iB;
		OPADD:
			oALUresult  = iA + iB;
	//	OPMFHI:
	//		oALUresult  = HI;
		OPSLL:
			oALUresult  = iA << iB;
	//	OPMFLO:
	//		oALUresult  = LO;
		OPSUB:
			oALUresult  = iA - iB;
		OPSLT:
			oALUresult  = iA < iB;
	//	OPSGT:                          //2016/1 - implementada para as operacoes bgtz e blez
	//		oALUresult  = iA > iB;
		OPSRL:
			oALUresult  = iA >> iB;
		OPSRA:
			oALUresult  = iA >>> iB;
		OPXOR:
			oALUresult  = iA ^ iB;
		OPSLTU:
			oALUresult  = $unsigned(iA) < $unsigned(iB);
		OPNOR:
			oALUresult  = ~(iA | iB);
		OPLUI:
			oALUresult  = {iB[15:0],16'b0};
		OPSLLV:
			oALUresult  = iB << iA[4:0];
		OPSRAV:
			oALUresult  = iB >>> iA[4:0];
		OPSRLV:
			oALUresult  = iB >> iA[4:0];
		OPMUL:
			begin
				TMP = iA * iB;	
				oALUresult  = TMP[31:0];
			end
		OPDIV:
			oALUresult  = iA / iB;
		OPDIVU:
			oALUresult  = $unsigned(iA) / $unsigned(iB);
		OPREM:
			oALUresult  = iA % iB;
		OPREMU:
			oALUresult  = $unsigned(iA) % $unsigned(iB);
		OPMULH:
			begin
				TMP = iA * iB;	
				oALUresult  = TMP[63:32];
			end
		OPMULHSU:
			begin
				TMP = iA * $unsigned(iB);	
				oALUresult  = TMP[63:32];
			end
		OPMULHU:
			begin
				TMP = $unsigned(iA) * $unsigned(iB);	
				oALUresult  = TMP[63:32];
			end
		default:
			oALUresult  = ZERO;
	endcase
end

endmodule
