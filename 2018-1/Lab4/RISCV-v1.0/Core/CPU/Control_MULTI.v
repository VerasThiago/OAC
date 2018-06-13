/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire iCLK, iRST,
	input wire [5:0] iOp,
	output wire oIRWrite, oMemWrite, oMemRead, oIorD, 
					oPCWrite, oRegWrite,oPCcondWrite,oALUop,oPCwrite
					oOriPC,oOriAALU,

	output wire [1:0] oALUOp, oOriBALU, oMem2Reg
);


wire [14:0] word;			// sinais de controle do caminho de dados
reg [5:0] pr_state;		// present state
wire [5:0] nx_state;		// next estate



assign oMem2Reg      = word[1:0];
assign oRegWrite     = word[2];
assign oMemWrite     = word[3];
assign oPCcondWrite  = word[4];
assign oALUop        = word[6:5];
assign oIorD         = word[7];
assign oPCwrite      = word[8];
assign oOriPC        = word[9];
assign oMemRead      = word[10];
assign oOriBALU      = word[12:11];
assign oIRWrite      = word[13];
assign oOriAALU      = word[14];


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
			word		<= 15'b000000001010110;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			nx_state  	<= EXE;
			
			case (iOp)
				OPCAUIPC:
					word		<= 15'b000000000001000;

				OPCLUI:
					word		<= 15'b000001100001000;

				default:
					word		<= 15'b000000000001100;
			endcase

		endcase

		EXE:
		begin
			
			case (iOp)

				OPCLOAD,
				OPCSTORE:
				begin	
					word		<= 15'b000000000001001;
					nx_state	<= ACESSorCONC;
				end

				OPCRTYPE:
				begin
					word		<= 15'b000001000000001;
					nx_state	<= ACESSorCONC;
				end

				OPCIMM:
				begin
					word		<= 15'b000001100000001;
					nx_state	<= ACESSorCONC;
				end


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

				OPCLUI,					
				OPCAUIPC:
				begin
					word		<= 15'b001000000000000;
					nx_state  	<= FETCH;
				end
				
				OPCJALR:
				begin
					word		<= 15'b011000000001101;
					nx_state 	<= ACCESSorCONC;
				end

			endcase
		end

		ACCESSorCONC:
		begin
			case(iOp)

				OPCSTORE:
				begin
					word		<= 15'b000100010000000;
					nx_state	<= FETCH;
				end

				OPCIMM,
				OPCRTYPE:
				begin
					word		<= 15'b001000000000000;
					nx_state	<= FETCH;
				end

				OPCLOAD:
				begin
					word		<= 15'b000000010010000;
					nx_state	<= CONC-LOAD;
				end

				OPCJALR:
				begin
					word		<= 15'b000000001100000;
					nx_state	<= FETCH;
				end

				default:
				begin
					word		<= 15'b000000000000000;					
					nx_state	<= FETCH;
				end
			endcase
		end
		
		CONC-LOAD:
			begin
				word		<= 15'b101000000000000;
				nx_state	<= FETCH;
			end	
	endcase
end
endmodule


