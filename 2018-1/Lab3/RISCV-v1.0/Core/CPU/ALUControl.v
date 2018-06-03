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
	input wire [6:0] iFunct7, iOpcode, /*iRt,*/   // 1/2016. Adicionado iRt.
	input wire [1:0] iALUOp,
	output reg [5:0] oControlSignal
	);
	
always @(*)
begin
	case (iALUOp)
		2'b00:
		oControlSignal = OPADD;
		2'b01:
		oControlSignal = OPSUB;
		2'b10:   // Todas as instruções do tipo R
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
					FUN3SLT,
					FUN3MULHSU:
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
					FUN3SLTU,
					FUN3MULHU:
						begin
							case (iFunct7)
								FUN7SLTU:
									oControlSignal = OPSLTU;
								FUN7MULHU:
									oControlSignal = OPMULHU;
								default:
									oControlSignal = ZERO;
							endcase
						end
					FUN3XOR,
					FUN3DIV:
						begin
							case (iFunct7)
								FUN7XOR:
									oControlSignal = OPXOR;
								FUN7DIV:
									oControlSignal = OPDIV;
								default:
									oControlSignal = ZERO;
							endcase
						end
					FUN3SRL,
					FUN3DIVU,
					FUN3SRA:
						begin
							case (iFunct7)
								FUN7SRL:
									oControlSignal = OPSRL;
								FUN7DIVU:
									oControlSignal = OPDIVU;
								FUN7SRA:
									oControlSignal = OPSRA;
								default:
									oControlSignal = ZERO;
							endcase
						end
					FUN3OR,
					FUN3REM:
						begin
							case (iFunct7)
								FUN7OR:
									oControlSignal = OPOR;
								FUN7REM:
									oControlSignal = OPREM;
								default:
									oControlSignal = ZERO;
							endcase
						end
					FUN3AND,
					FUN3REMU:
						begin
							case (iFunct7)
								FUN7AND:
									oControlSignal = OPAND;
								FUN7REMU:
									oControlSignal = OPREMU;
								default:
									oControlSignal = ZERO;
							endcase
						end
					default:
						oControlSignal = ZERO;
				endcase
			end
		2'b11: // Todas instruções do tipo I e SB
			begin
				case(iOpcode)
					OPCSTORE,
					OPCLOAD:         
						oControlSignal = OPADD;
					OPCIMM:
						begin
							case(iFunct3)
								FUN3ADDI:
									oControlSignal = OPADD;
								FUN3SLLI:
									oControlSignal = OPSLL;
								FUN3SLTI:
									oControlSignal = OPSLT;
								FUN3SLTIU:
									oControlSignal = OPSLTU;
								FUN3XORI:
									oControlSignal = OPXOR;
								FUN3SRLI:
									oControlSignal = OPSRL;
								FUN3SRAI:
									oControlSignal = OPSRA;
								FUN3ORI:
									oControlSignal = OPOR;
								FUN3ANDI:	
									oControlSignal = OPAND;
								default:
									oControlSignal = ZERO;		
							endcase
						end
					OPCLUI:
						oControlSignal = OPLUI;
					OPCBRANCH:
						begin
							case(iFunct3)
								FUN3BEQ:
									oControlSignal = OPSUB;
								FUN3BNE:
									oControlSignal = OPBNE;		
								FUN3BLT:
									oControlSignal = OPBLT;		
								FUN3BGE:
									oControlSignal = OPBGE;
								FUN3BLTU:
									oControlSignal = OPBLTU;		
								FUN3BGEU:
									oControlSignal = OPBLTU;		
							endcase
						end
				endcase
			end
	endcase
end
endmodule
