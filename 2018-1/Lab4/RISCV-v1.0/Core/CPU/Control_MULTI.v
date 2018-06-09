/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire iCLK, iRST,
	input wire [5:0] iOp, iFunct,
	input wire [4:0] iFmt, iRt,		// 1/2016. Adicionado iRt.
	input wire iFt,
	output wire oIRWrite, oMemtoReg, oMemWrite, oMemRead, oIorD, 
					oPCWrite, oPCWriteBEQ, oPCWriteBNE,oRegWrite, oRegDst,
					oFPPCWriteBc1t, oFPPCWriteBc1f, oFPRegWrite, oFPFlagWrite, 
					oFPU2Mem, 
	output wire [1:0] oALUOp, oALUSrcA, oFPDataReg, oFPRegDst,
	output wire [2:0] oALUSrcB, oPCSource, oStore,
	output wire [5:0] oState,
	//Adicionado em 1/2014
	output wire [2:0] oLoadCase,
	output wire [1:0] oWriteCase,
	// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
	input iCOP0ALUoverflow, iCOP0FPALUoverflow, iCOP0FPALUunderflow, 
			iCOP0FPALUnan, iCOP0UserMode, iCOP0ExcLevel,
	input [7:0] iCOP0PendingInterrupt,
	output oCOP0PCOriginalWrite,
	output reg oCOP0RegWrite, oCOP0Eret, oCOP0ExcOccurred,
	output oCOP0BranchDelay,
	output [4:0] oCOP0ExcCode,
	output oCOP0Interrupted,
	// 2017/1
	input iFPBusy,
	output oFPStart
	);


wire [14:0] word;			// sinais de controle do caminho de dados
reg [5:0] pr_state;		// present state
wire [5:0] nx_state;		// next estate



assign oPCcondWrite  = word[0];
assign oPCwrite      = word[1];
assign oIorD         = word[2];
assign oMemWrite     = word[3];
assign oMemRead      = word[4];
assign oIRWrite      = word[5];
assign oOriPC        = word[6];
assign oALUop        = word[8:7];
assign oOriAALU      = word[9];
assign oOriBALU      = word[11:10];
assign oRegWrite     = word[12];
assign oMem2Reg      = word[14:13];

assign oState		 = pr_state;

initial
begin
	pr_state	<= FETCH;
end


/* Main control block */
always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		pr_state	<= FETCH;
	else
		pr_state	<= nx_state;
end


always @(*)
begin
	
	case (pr_state)
	
		FETCH:
		begin
			word	<= 15'b000000001010110;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			word	<=  15'b000000000001100;

			case(iOp)
				
				OPCLOAD:
					nx_state <= 

				OPCRTYPE:
					nx_state <=

				OPCBEQ:
					nx_state <=

				OPCJAL:				
					nx_state <=
				
			endcase

		end			
	
		
	endcase
end

endmodule
