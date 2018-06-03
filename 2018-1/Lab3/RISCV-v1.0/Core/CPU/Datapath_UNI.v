/* Top Level Entity - RISCV Custom*/ 

`ifndef PARAM
	`include "Parametros.v"
`endif

module Datapath_UNI (
	input iClk,
	input iClr,
	input [31:0] iInst,
	output wire [31:0] wA, wB,
	output reg oZero,
	output reg [31:0] oResult,
	output wire [31:0] wPC,
	output wire [31:0] wReg,
	output wire [31:0] wUla
	
/*	
//	output reg [6:0] iOpcode,  
//	output reg [9:0] Funct10,
//	output reg [11:0] iImmTipoI,
//	output reg [11:0] iImmTipoS,
//	output reg [11:0] iImmTipoSB,
//	output reg [19:0] iImmTipoU,
*Ja foram declarados nas linhas seguintes como wire, pelo menos foi o que vi.
*/
);


/*========== assignments da intrução para os fios ==========*/

wire [6:0] iOpcode;
//wire [9:0] Funct10;
wire [6:0] iFunct7;
wire [2:0] iFunct3;
wire [11:0] iImmTipoI;
wire [11:0] iImmTipoS;
wire [11:0] iImmTipoSB;
wire [19:0] iImmTipoU;


/* =========== fios dos modulos aritmeticos  ================ */

wire [5:0] ctrl_to_ula;		// saída do ALUControl / entrada iControl da ULA
wire [31:0] ula_to_mux;		// saída da ULA / entrada do multiplexador de saída
wire [31:0] mux_to_ula;		// saida do multiplexador da ULA/ entrada do iB da ULA
wire [31:0] imm_gen;			// saída do gerador de imediato/ entrada dado1 do multiplexador da ULA
reg [31:0] mem_out = 32'd0;



/*================== fios do controle ================= */


wire oALUSrc;
wire oMemToReg;
wire oRegWrite;
wire oMemRead;
wire oMemWrite;
wire oBranch; 
wire oOrigWrite; 		// origem do dado de escrita (saída da ula ou memória / pc + imediato (para auipc))
wire [1:0] oALUOp;

/* ===== fios da ula/pc/muxes ====== */

wire [31:0] mux_to_orig; // fio que sai do mux da ula para o mux de seleção da origem do dado de escrita


/* ======== entradas do banco de registradores ======= */

wire [31:0] iA,iB;
wire [31:0] mux_to_reg;			// saida do multiplexador da ula para o breg
wire [4:0] iReadRegister1;
wire [4:0] iReadRegister2;
wire [4:0] iWriteRegister;
wire [4:0] iRegDispSelect, iVGASelect;
wire [31:0] oRegDisp,oVGARead;


wire [31:0] adder_to_pc;		// saída do adder para o pc (pois o pc só é escrito na borda de subida)
wire [31:0] wPC4;
wire [31:0] wiPC;
wire [31:0] wBranch;
reg [31:0] PC;
wire [31:0] wInst;
wire [31:0] pcImm;

assign wPC4 = PC + 32'h4;
assign wPC = PC;
assign wBranch = PC + imm_gen;		// endereco de branch

assign iOpcode = iInst[6:0];
assign iFunct7 = iInst[31:25];
assign iFunct3 = iInst[14:12];
assign iImmTipoI = iInst[31:20];
assign iImmTipoS[11:5] = iInst[31:25];
assign iImmTipoS[4:0] = iInst[11:7];
//assign iImmTipoSB[12] = iInst[31];
//assign iImmTipoSB[10:5] = iInst[30:25];
//assign iImmTipoSB[4:1] = iInst[11:8];
//assign iImmTipoSB[11] = iInst[7];
assign iImmTipoU = iInst[31:12];

//assign iA = wA;
//assign iB = wB;
assign iReadRegister1 = iInst[19:15];
assign iReadRegister2 = iInst[24:20];
assign iWriteRegister = iInst[11:7];
assign pcImm = PC + {iImmTipoU,12'b0};

// Controle Uniciclo

Control_UNI iControl (
		.iOp(iOpcode),
		.oALUop(oALUOp),
		.oALUsrc(oALUSrc),
		.oMemtoReg(oMemToReg),
		.oRegWrite(oRegWrite),
		.oMemRead(oMemRead),
		.oMemWrite(oMemWrite),
		.oBranch(oBranch),
		.oOrigWrite(oOrigWrite),
		
);


/* ================ Banco de registradores ================= */

Registers regs (
	.iCLK(iClk),
	.iCLR(iClr),
	.iRegWrite(oRegWrite),
	.iReadRegister1(iReadRegister1),
	.iReadRegister2(iReadRegister2),
	.iWriteRegister(iWriteRegister),
	.iRegDispSelect(iRegDispSelect),
	.iWriteData(mux_to_reg),
	.oReadData1(iA),
	.oReadData2(iB),
	.oRegDisp(oRegDisp),
	.iVGASelect(iVGASelect),
	.oVGARead(oVGARead)
);


/*  =============== modulos aritmeticos ======================*/


// ALU Control

ALUControl aluControlUnit (
		.iFunct3(iFunct3),
		.iFunct7(iFunct7),
		.iOpcode(iOpcode),
		.iALUOp(oALUOp),
		.oControlSignal(ctrl_to_ula)
);


// Mux2x1(32 bits) - saída do iB BREG e entrada na iB da ULA (0-Read Data 2/1-ImmGen)
// TODO: Adicionar o gerador de imediato no dado1
mux32_2 muxReg(	
	.sel(oALUSrc),
	.dado0(iB),
	.dado1(iImmTipoI),
	.saida(mux_to_ula)
);


// ALU

ALU alu0 (
	.iControlSignal(ctrl_to_ula),
	.iA(iA),
	.iB(mux_to_ula),
	.oZero(oZero),
	.oALUresult(ula_to_mux)
);

// Mux2x1(32 bits) - saída da ULA e entrada do mux seletor da origem do dado de escrita (0-saída da ULA / 1-saída da memória de dados)
mux32_2 muxUla (
	.sel(oMemToReg),
	.dado0(mem_out),
	.dado1(ula_to_mux),
	.saida(mux_to_orig)
);


//Mux2x1(32 bits) - saida do mux da ULA/Mem e entrada nO BREG (0-dado da ULA ou Mem /1-pc + imm (para auipc))
mux32_2 muxPcOrUla(
	.sel(oOrigWrite),
	.dado0(mux_to_orig),
	.dado1(pcImm),
	.saida(mux_to_reg)

);
/* somador do endereco de branch*/


//mux32_2 muxPc (
//	.sel(oBranch),
//	.dado0(wPC4),
//	.dado1(wBranch),
//	.saida(wPC)
//);
always @(posedge iClk)
	begin
		PC <= wPC4;
	end
	
//always @(*)
//	begin
//		wUla <= mux_to_out;
//	end
		
endmodule
