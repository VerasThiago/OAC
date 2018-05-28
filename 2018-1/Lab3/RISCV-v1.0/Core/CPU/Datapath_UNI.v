/*
 * Caminho de dados processador Uniciclo
 *
 */

module Datapath_UNI (
    // Inputs e clocks
    input  wire        iCLK, iCLK50, iRST,
    input  wire [31:0] iInitialPC,

    // Para monitoramento
    output wire [31:0] wPC, woInstr,
    input  wire [4:0]  wRegDispSelect,
    output wire [31:0] wDebug,

    output wire        wCRegWrite,
    output wire [1:0]  wCALUOp,
    output wire [2:0]  wCMem2Reg,
	 
	 output wire [31:0] wBRReadA,
	 output wire [31:0] wBRReadB,
	 output wire [31:0] wBRWrite,
	 output wire [31:0] wULA,	 


    //  Barramento de Dados
    output             DwReadEnable, DwWriteEnable,
    output      [3:0]  DwByteEnable,
    output      [31:0] DwAddress, DwWriteData,
    input       [31:0] DwReadData,

    // Barramento de Instrucoes
    output             IwReadEnable, IwWriteEnable,
    output      [3:0]  IwByteEnable,
    output      [31:0] IwAddress, IwWriteData,
    input       [31:0] IwReadData,

    input [7:0] iPendingInterrupt                           // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    );



/* Padrao de nomeclatura
 *
 * XXXXX - registrador XXXX
 * wXXXX - wire XXXX
 * wCXXX - wire do sinal de controle XXX
 * memXX - memoria XXXX
 * Xunit - unidade funcional X
 * iXXXX - sinal de entrada/input
 * oXXXX - sinal de saida/output
 */

reg  [31:0] PC;                                 // registrador do PC
wire [31:0] wPC4;
wire [31:0] wiPC;
wire [31:0] wInstr;
wire [31:0] wMemDataWrite;
wire [6:0]  wOpcode, wFunct7;
wire [4:0]  wAddrRs1, wAddrRs2, wAddrRd, wRegDst;     // enderecos dos reg rs,rt ,rd e saida do Mux regDst
wire [31:0] wOrigALU;
wire        wZero;
wire [4:0]  wALUControl;
wire [31:0] wALUresult, wRead1, wRead2, wMemAccess;
wire [31:0] wReadData;
wire [31:0] wDataReg;
wire [15:0] wImm;
wire [31:0] wExtImm;
wire [31:0] wBranchPC;
wire [31:0] wExtZeroImm;
wire        wCMemRead, wCMemWrite, wCALUSrc;
wire [2:0]  wFunct3;




/* Inicializacao */
initial
begin
    PC         <= BEGINNING_TEXT;
end

assign wPC4         = wPC + 32'h4;                          /* Calculo PC+4 */
//assign wBranchPC    = wPC4 + {wExtImm[29:0],{2'b00}};       /* Endereco do Branch */
assign wPC          = PC;
assign wOpcode      = wInstr[6:0]; 
assign wAddrRs1     = wInstr[19:15];
assign wAddrRs2     = wInstr[24:20];
assign wAddrRd      = wInstr[11:7];
assign woInstr      = wInstr;
assign wFunct3 	  = wInstr[14:12];
assign wFunct7 	  = wInstr[31:25];
//assign wImmGen 	  = wInstr[31:0];

/* Assigns para debug */
assign wDebug   = 32'h00BEBAD0;//005AD1C0//00F1A5C0//0ACEF0DA;


/* Barramento da Memoria de Instrucoes */
assign    IwReadEnable      = ON;
assign    IwWriteEnable     = wCodeMemoryWrite;
assign    IwByteEnable      = wMemEnable;
assign    IwAddress         = wPC;
assign    IwWriteData       = ZERO;
assign    wInstr            = IwReadData;

/* Banco de Registradores */
Registers RegsUNI ( //a modificar
    .iCLK(iCLK),
    .iCLR(iRST),
    .iReadRegister1(wAddrRs1),
    .iReadRegister2(wAddrRs2),
    .iWriteRegister(wRegDst),
    .iWriteData(wDataReg),
    .iRegWrite(wCRegWrite),
    .oReadData1(wRead1),
    .oReadData2(wRead2),
	);

/* ALU CTRL */
ALUControl ALUControlunit (
    .iFunct3(wFunct3),
	 .iFunct7(wFunct7),
    .iOpcode(wOpcode),
    .iALUOp(wCALUOp),
    .oControlSignal(wALUControl)
	);

/* ALU */
ALU ALUunit(
    .iCLK(iCLK),
    .iRST(iRST),
    .iControlSignal(wALUControl),
    .iA(wRead1),
    .iB(wOrigALU),
    .oALUresult(wALUresult),
    .oZero(wZero),
	);

MemStore MemStore0 (
    .iAlignment(wALUresult[1:0]),
    .iWriteTypeF(STORE_TYPE_DUMMY),
    .iOpcode(wOpcode),
    .iData(wRead2),
    .oData(wMemStore),
    .oException()
	);

/* Barramento da memoria de dados */
assign DwReadEnable     = wCMemRead;
assign DwWriteEnable    = wCMemWrite;
assign DwByteEnable     = wMemEnable;
assign DwWriteData      = wMemDataWrite;
assign wReadData        = DwReadData;
assign DwAddress        = wALUresult;

MemLoad MemLoad0 (
    .iAlignment(wALUresult[1:0]),
    .iLoadTypeF(LOAD_TYPE_DUMMY),
    .iOpcode(wOpcode),
    .iData(wReadData),
    .oData(wMemAccess),
    .oException()
	);

/* Unidade de Controle */
Control_UNI CtrUNI (
    .iFunct3(wFunct3),
	 .iFunct7(wFunct7),
	 .iOp(wOpcode),
    .oBranch(wBranchPC), //Nao sei se isso ta certo ou se eh pra ser wCBranch apesar de nao estar declarado.
    .oMemRead(wCMemRead),	 
    .oMemtoReg(wCMem2Reg),
    .oALUop(wCALUOp),
    .oMemWrite(wCMemWrite),
	 .oALUsrc(wCALUSrc),
    .oRegWrite(wCRegWrite),	 
	);

endmodule
