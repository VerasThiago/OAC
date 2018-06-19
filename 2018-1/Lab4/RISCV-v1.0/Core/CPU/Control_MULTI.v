/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire iCLK, iRST,
	input reg [6:0] iOp,
	output reg oIRWrite, oMemWrite, oMemRead, oIorD, 
					oPCw, oRegWrite,oPCcondWrite,
					oOriPC,oOriAALU,

	output reg [1:0] oALUOp, oOriBALU, oMem2Reg
);


reg [14:0] word;			// sinais de controle do caminho de dados
reg [5:0] pr_state;		// present state
reg [5:0] nx_state;		// next estate



assign oMem2Reg      = word[14:13];
assign oRegWrite     = word[12];
assign oMemWrite     = word[11];
assign oPCcondWrite  = word[10];
assign oALUop        = word[9:8];
assign oIorD         = word[7];
assign oPCw          = word[6];
assign oOriPC        = word[5];
assign oMemRead      = word[4];
assign oOriBALU      = word[3:2];
assign oIRWrite      = word[1];
assign oOriAALU      = word[0];


initial
begin
	pr_state	<= FETCH;
	nx_state    <= FETCH;
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
			word		<= 15'b000000001010110;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			nx_state  	<= EXE;
			word		<= 15'b000000000001100;
		end

		

		EXE:
		begin
			
			nx_state	<= ACCESSorCONC;
		
			case (iOp)

				OPCLOAD,
				OPCSTORE:
					word		<= 15'b000000000001001;

				OPCRTYPE:
					word		<= 15'b000001000000001;

				OPCIMM:
					word		<= 15'b000001100000001;

				OPCBRANCH:
				begin
					word		<= 15'b000011100100001;
					nx_state	<= FETCH;
				end

				OPCJAL:
				begin
					word		<= 15'b011000001100000;
					nx_state    <= FETCH;
				end

				OPCAUIPC:
					word 		<= 15'b000000000001000;

				OPCLUI:
					word		<= 15'b000001100001000;
				
				OPCJALR:
					word		<= 15'b011000000001101;

			endcase
		end

		ACCESSorCONC:
		begin
			nx_state	<= FETCH;
			case(iOp)

				OPCLUI,					
				OPCAUIPC:
					word		<= 15'b001000000000000;

				OPCSTORE:
					word		<= 15'b000100010000000;

				OPCIMM,
				OPCRTYPE:
					word		<= 15'b001000000000000;

				OPCLOAD:
				begin
					word		<= 15'b000000010010000;
					nx_state	<= CONC_LOAD;
				end

				OPCJALR:
					word		<= 15'b000000001100000;

				default:
					word		<= 15'b000000000000000;					

			endcase
		end
		
		CONC_LOAD:
			begin
				word		<= 15'b101000000000000;
				nx_state	<= FETCH;
			end	
	endcase
end
endmodule


