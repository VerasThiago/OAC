/*
 * ALUcontrol.v
 *
 * Arithmetic Logic Unit control module.
 * Generates control signal to the ALU depending on the opcode and the funct field in the
 * current operatio	n and on the signal sent by the processor control module.
 *
 * ALUOp    |    Control signal
 * -------------------------------------------
 * 00        |    The ALU performs an add operation.
 * 01        |    The ALU performs a subtract operation.
 * 10        |    The funct field determines the ALU operation.
 * 11        |    The opcode field (and the funct, of necessary) determines the ALU operation.
 */

module ALUControl (
	input wire [2:0] iFunct3,
	input wire [6:0] iFunct7, iOpcode, iRt,   // 1/2016. Adicionado iRt.
	input wire [1:0] iALUOp,
	output reg [4:0] oControlSignal
	);
	
always @(*)
begin
	case (iALUOp)
		2'b00:
		oControlSignal = OPADD;
		2'b01:
		oControlSignal = OPSUB;
		2'b10:
			begin
				case (iFunct3)
					FUN3MUL,
					FUN3SUB,
					FUN3ADD:
						begin
							case (iFunct7)
								FUN7MUL:              
									oControlSignal = OPMUL;
								FUN7SUB:
									oControlSignal = OPSUB;             
								FUN7ADD:
									oControlSignal = OPADD;
								default:
									oControlSignal = ZERO;
							endcase
						end
					FUN3SLL,
					FUN3MULH:
						begin
							case (iFunct7)
								FUN7SLL:
									oControlSignal = OPSLL;
								FUN7MULH:
									oControlSignal = OPMULH;
								default:
									oControlSignal = ZERO;
							endcase
						end
					SLT,
					MULHSU:
						begin
							case (iFunct7)
								FUN7SLT:
									oControlSignal = OPSLT;
								FUN7MULHSU:
									oControlSignal = OPMULHSU;
								default:
									oControlSignal = ZERO;
							endcase
						end
					SLTU,
					MULHU:
						begin
							case (iFunct7)
								FUN7SLTU:
									oControlSignal = OPSLTU;
								MULHU:
									oControlSignal = OPMULHU;
								default:
									oControlSignal = ZERO;
							endcase
						end
					XOR,
					DIV:
						begin
							case (iFunct7)
								FUN7XOR:
									oControlSignal = OPXOR;
								DIV:
									oControlSignal = OPDIV;
								default:
									oControlSignal = ZERO;
							endcase
						end
					SRL,
					DIVU,
					SRA:
						begin
							case (iFunct7)
								FUN7SRL:
									oControlSignal = OPSRL;
								DIVU:
									oControlSignal = OPDIVU;
								STA:
									oControlSignal = OPSRA;
								default:
									oControlSignal = ZERO;
							endcase
						end
					OR,
					REM:
						begin
							case (iFunct7)
								FUN7OR:
									oControlSignal = OPOR;
								REM:
									oControlSignal = OPREM;
								default:
									oControlSignal = ZERO;
							endcase
						end
					AND,
					REMU:
						begin
							case (iFunct7)
								FUN7AND:
									oControlSignal = OPAND;
								REMU:
									oControlSignal = OPREMU;
								default:
									oControlSignal = ZERO;
							endcase
						end
					default:
						oControlSignal = ZERO;
				endcase
			end
		2'b11:
		
			oControlSignal = ZERO; 
	endcase
end

endmodule
