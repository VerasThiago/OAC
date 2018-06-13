`ifndef PARAM
`define PARAM
/* Parametros Gerais*/
parameter
    ON          = 1'b1,
    OFF         = 1'b0,
    ZERO        = 32'h0,

/* Operacoes da ULA */
	OPAND       = 6'b000000,            //0
	OPOR        = 6'b000001,            //1
	OPXOR       = 6'b000010,            //2
	OPADD       = 6'b000011,            //3
	OPSUB       = 6'b000100,            //4
	OPSLT       = 6'b000101,            //5
	OPSLTU      = 6'b000110,            //6
	OPBGE       = 6'b000111,            //7
	OPBGEU      = 6'b001000,            //8
	OPSLL       = 6'b001001,            //9
	OPSRL       = 6'b001010,            //10
	OPSRA       = 6'b001011,            //11
	OPADDI      = 6'b001100,            //12
	OPANDI      = 6'b001101,            //13
	OPORI       = 6'b001110,            //14
	OPXORI      = 6'b001111,            //15
	OPSLTI      = 6'b010000,            //16
	OPSLTIU     = 6'b010001,            //17
	OPSLLI      = 6'b010010,            //18
	OPSRLI      = 6'b010011,            //19
	OPSRAI      = 6'b010100,            //20
	OPAUIPC     = 6'b010101,            //21        
	OPBEQ       = 6'b010110,            //22        
	OPBNE       = 6'b010111,            //23       
	OPBLT		   = 6'b011000,			 	//24 		 
	OPBLTU		= 6'b011001,			 	//25 		 
	OPJAL		   = 6'b011010,			 	//26 		 
	OPJALR		= 6'b011011,			 	//27 		 
	OPLB 		   = 6'b011100, 			 	//28
	OPLBU       = 6'b011101,            //29
	OPLH        = 6'b011110,         	//30
	OPLHU       = 6'b011111,            //31
	OPLW        = 6'b100000,				//32
	OPSB        = 6'b100001,				//33
	OPSH        = 6'b100010,            //34
	OPSW        = 6'b100011,            //35
	OPLUI       = 6'b100100,            //36
	OPMUL 		= 6'b100101,
	OPMULH		= 6'b100110,
	OPMULHU	 	= 6'b100111,
	OPMULHSU 	= 6'b101000,
	OPDIV			= 6'b101001,
	OPDIVU		= 6'b101010,
	OPREM			= 6'b101011,
	OPREMU		= 6'b101100,
	
/* Operacoes da ULA FP */
    OPADDS      = 4'b0001,
    OPSUBS      = 4'b0010,
    OPMULS      = 4'b0011,
    OPDIVS      = 4'b0100,
    OPSQRT      = 4'b0101,
    OPABS       = 4'b0110,
    OPNEG       = 4'b0111,
    OPCEQ       = 4'b1000,
    OPCLT       = 4'b1001,
    OPCLE       = 4'b1010,
    OPCVTSW     = 4'b1011,
    OPCVTWS     = 4'b1100,
    OPCEILWS    = 4'b1101,
    OPFLOORWS   = 4'b1110,
    OPROUNDWS   = 4'b1111,


/* Campo FUNCT3 */
	 FUN3BEQ		 = 3'h0, 
	 FUN3BNE 	 = 3'h1, 
	 FUN3ADDI 	 = 3'h0, 
	 FUN3SLTI 	 = 3'h2, 
	 FUN3SLTIU 	 = 3'h3, 
	 FUN3ANDI 	 = 3'h7, 
	 FUN3XORI 	 = 3'h4, 
	 FUN3LW 	 	 = 3'h2, 
	 FUN3LB 	    = 3'h0, 
	 FUN3LBU 	 = 3'h4, 
	 FUN3LH 		 = 3'h1, 
	 FUN3LHU 	 = 3'h5, 
	 FUN3SW 		 = 3'h2, 
	 FUN3SB 	  	 = 3'h0, 
	 FUN3SH 		 = 3'h1, 
	 FUN3JALR 	 = 3'h0, 
	 FUN3ADD 	 = 3'h0,
	 FUN3SUB 	 = 3'h0,
	 FUN3AND		 = 3'h7,
	 FUN3OR 		 = 3'h6,
	 FUN3XOR 	 = 3'h4,
	 FUN3SLT 	 = 3'h2, 
	 FUN3SLTU 	 = 3'h3,
	 FUN3SLL 	 = 3'h1,
	 FUN3SRL 	 = 3'h5,
	 FUN3SRA 	 = 3'h5,
	 FUN3ORI		 = 3'h6,
	 FUN3SLLI	 = 3'h1,
	 FUN3SRLI	 = 3'h5,
	 FUN3SRAI	 = 3'h5,
	 FUN3BGE		 = 3'h5,
	 FUN3BGEU	 = 3'h7,
	 FUN3BLT		 = 3'h4,
	 FUN3BLTU	 = 3'h6,
	 FUN3MUL		 = 3'h0,
	 FUN3MULH	 = 3'h1,
	 FUN3MULHU	 =	3'h2,
	 FUN3MULHSU	 = 3'h3,
	 FUN3DIV		 = 3'h4,
	 FUN3DIVU	 = 3'h5,
	 FUN3REM		 = 3'h6,
	 FUN3REMU	 = 3'h7,
	 
	 
	 
/*Campo FUNCT7*/
	
    FUN7ADD 		 = 7'h00,
	 FUN7SUB 		 = 7'h20,
	 FUN7AND 		 = 7'h00,
	 FUN7OR	 	    = 7'h00,
	 FUN7XOR 		 = 7'h00,
	 FUN7SLT 		 = 7'h00,
	 FUN7SLTU 		 = 7'h00,
	 FUN7SLL 		 = 7'h00,
	 FUN7SRL 	    = 7'h00, 
	 FUN7SRA 		 = 7'h20,
	 FUN7SRLI 		 = 7'h00,
	 FUN7SRAI 	 	 = 7'h20,
	 FUN7MUL 		 = 7'h01,
	 FUN7MULH       = 7'h01,
	 FUN7MULHSU 	 = 7'h01,
	 FUN7MULHU		 = 7'h01,
	 FUN7DIV			 = 7'h01,
	 FUN7DIVU		 = 7'h01,
	 FUN7REM        = 7'h01,
	 FUN7REMU       = 7'h01,
	 
	
/* Campo OPCODE */
//	 OPCADD 		 = 7'h33, //1
//	 OPCSUB 		 = 7'h33, //2
//	 OPCAND		 = 7'h33, //3
//	 OPCOR 		 = 7'h33, //4
//	 OPCXOR 		 = 7'h33, //5
//	 OPCSLT      = 7'h33, //6
//	 OPCSLTU     = 7'h33, //7
//	 OPCSLL      = 7'h33, //8
//	 OPCSRL      = 7'h33, //9
//	 OPCSRA      = 7'h33, //10
//  OPCADDI     = 7'h13, //11
//  OPCANDI     = 7'h13, //12
//	 OPCORI  	 = 7'h13, //13
//	 OPCXORI 	 = 7'h13, //14
//  OPCSLTI     = 7'h13, //15
//  OPCSLTIU    = 7'h13, //16
//	 OPCSLLI 	 = 7'h13, //17
//	 OPCSRLI 	 = 7'h13, //18
//	 OPCSRAI 	 = 7'h13, //19
	 OPCAUIPC  	 = 7'h17, //20
    OPCLUI      = 7'h37, //21
//	 OPCBEQ      = 7'h63, //22
//  OPCBNE      = 7'h63, //23
//	 OPCBLT 	 	 = 7'h63, //24
//	 OPCBGE		 = 7'h63, //25
//	 OPCBLTU 	 = 7'h63, //26
//	 OPCBGEU 	 = 7'h63, //27
    OPCJAL      = 7'h6F, //28
    OPCJALR     = 7'h67, //29
//  OPCLB       = 7'h03, //30
//  OPCLBU      = 7'h03, //31
//  OPCLH       = 7'h03, //32
//  OPCLHU      = 7'h03, //33
//	 OPCLW       = 7'h03, //34	 
//  OPCSB       = 7'h23, //35
//  OPCSH       = 7'h23, //36
//	 OPCSW       = 7'h23, //37
//	 OPCMUL 	  	 = 7'h33, //38
//	 OPCMULH 	 = 7'h33, //39
//	 OPCMULHU 	 = 7'h33, //40
//	 OPCMULHSU 	 = 7'h33, //41
//	 OPCDIV 	  	 = 7'h33, //42
//	 OPCDIVU	 	 = 7'h33, //43
//	 OPCREM 	 	 = 7'h33, //44
//	 OPCREMU 	 = 7'h33, //45	
	 OPCRTYPE 	 = 7'h33, //R-type funct 1-10 <-> 38-45
	 OPCIMM      = 7'h13, //Imm-type funct 11-19
	 OPCLOAD 	 = 7'h03, //Load-type funct 30-34
	 OPCLOGICIMM = 7'h13, //LogicImm-type funct 11-14
	 OPCBRANCH 	 = 7'h63, //Branch-type funct 22-27
	 OPCSTORE    = 7'h23, //Store-type funct 35-37
	 OPCUTYPE    = 7'h17, //auipc & lui
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    OPCCOP0     = 6'h10,                // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    OPCFLT      = 6'h11,                /*OPCODE para operacoes da FPU*/
	 OPCRM	 	 = 6'h1C,   				 // Grupo 2 - (2/2016)
	 OPMFUNCT 	 = 6'h1C,   				 // Relatorio questao B.9) - Grupo 2 - (2/2016)
    OPCLW       = 6'h23,
    OPCLB       = 6'h20,
    OPCLBU      = 6'h24,
    OPCLH       = 6'h21,
    OPCLHU      = 6'h25,
    //OPCSW       = 6'h2B,
    //OPCSB       = 6'h28,
    //OPCSH       = 6'h29,
    OPCLWC1     = 6'h31,
    OPCSWC1     = 6'h39,
    OPCDUMMY    = 6'h3F,                // Para o MemStore e MemLoad
    OPCBGE_LTZ  = 6'h01,                // 1/2016: Para as instruções bgez, bgezal, bgltz, bltzal
    OPCBGTZ     = 6'h07,                // 1/2016
    OPCBLEZ     = 6'h06,                // 1/2016

/* Campo $rt */                         // 1/2016
    RTBGEZ      = 5'b00001,
    RTBGEZAL    = 5'b10001,
    RTBLTZ      = 5'b00000,
    RTBLTZAL    = 5'b10000,
    RTZERO      = 5'B00000,

/* Campo FMT */
    FMTS        = 5'h10,
    FMTW        = 5'h14,
    FMTBC1      = 5'h08,
    FMTMFC      = 5'h00,
    FMTMTC      = 5'h04,
    FMTERET     = 5'h10,                // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)

/* Bit 16 da instrucao, usado somente para BC1 da FPU*/
    FTTRUE      = 1'b1,
    FTFALSE     = 1'b0,

// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    EXCODEINT   = 5'd0,
    EXCODESYS   = 5'd8,
    EXCODEINSTR = 5'd10,
    EXCODEALU   = 5'd12,
    EXCODEFPALU = 5'd15,

	 INITIAL_INTERRUPT = 32'h00000911,   // 00000111  00000511 ou 00000911 teclado habilitado

/* Memory access types ***********************************************************************************************/
    LOAD_TYPE_LW        = 3'b000,
    LOAD_TYPE_LH        = 3'b001,
    LOAD_TYPE_LHU       = 3'b010,
    LOAD_TYPE_LB        = 3'b011,
    LOAD_TYPE_LBU       = 3'b100,
    LOAD_TYPE_DUMMY     = 3'b111,

    STORE_TYPE_SW       = 2'b00,
    STORE_TYPE_SH       = 2'b01,
    STORE_TYPE_SB       = 2'b10,
    STORE_TYPE_DUMMY    = 2'b11,


/* ADDRESS MACROS *****************************************************************************************************/

    BACKGROUND_IMAGE    = "display.mif",

	 BEGINNING_BOOT      = 32'h0000_0000,
	 BOOT_WIDTH				= 9,					// 128 words = 128x4 = 512 bytes
    END_BOOT            = (BEGINNING_BOOT + 2**BOOT_WIDTH) - 1,	 
//    END_BOOT            = 32'h000001FF,	// 128 words

    BEGINNING_TEXT      = 32'h0040_0000,
	 TEXT_WIDTH				= 14,					// 4096 words = 4096x4 = 16384 bytes
    END_TEXT            = (BEGINNING_TEXT + 2**TEXT_WIDTH) - 1,	 
//    END_TEXT            = 32'h00403FFF,	// 4096 words

	 
    BEGINNING_DATA      = 32'h1001_0000,
	 DATA_WIDTH				= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_DATA            = (BEGINNING_DATA + 2**DATA_WIDTH) - 1,	 
//    END_DATA            = 32'h10011FFF,	// 2048 words


	 STACK_ADDRESS       = END_DATA-3,


    BEGINNING_KTEXT     = 32'h8000_0000,
	 KTEXT_WIDTH			= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_KTEXT           = (BEGINNING_KTEXT + 2**KTEXT_WIDTH) - 1,	 	 
//    END_KTEXT           = 32'h80001FFF,	// 2048 words
	 
    BEGINNING_KDATA     = 32'h9000_0000,
	 KDATA_WIDTH			= 12,					// 1024 words = 1024x4 = 4096 bytes
    END_KDATA           = (BEGINNING_KDATA + 2**KDATA_WIDTH) - 1,	 	 
//    END_KDATA           = 32'h900007FF, 	// 1024 words


	/* O que isso faz? 
	 ASCII_MIN           = 32'h00000080,
	 ASCII_MAX           = 32'h0000407F,
	 BACKGROUND          = 32'h00004080,
	 MAIN_COLOR          = 32'h00004084,
	 //LETRAS_MIN = 32'h00000100,
	 //LETRAS_MAX = 32'h00001763,
	 //NUMBER_MIN = 32'h00001764,
	 //NUMBER_MAX = 32'h00002403,*/
	 
    BEGINNING_IODEVICES         = 32'hFF00_0000,
	 
    BEGINNING_VGA               = 32'hFF00_0000,
    END_VGA                     = 32'hFF01_2C00,  // 320 x 240 = 76800 bytes

	 KDMMIO_CTRL_ADDRESS		     = 32'hFF20_0000,	// Para compatibilizar com o KDMMIO
	 KDMMIO_DATA_ADDRESS		  	  = 32'hFF20_0004,
	 
	 BUFFER0_TECLADO_ADDRESS     = 32'hFF20_0100,
    BUFFER1_TECLADO_ADDRESS     = 32'hFF20_0104,
	 
    TECLADOxMOUSE_ADDRESS       = 32'hFF20_0110,
    BUFFERMOUSE_ADDRESS         = 32'hFF20_0114,
	  
	 AUDIO_INL_ADDRESS           = 32'hFF20_0160,
    AUDIO_INR_ADDRESS           = 32'hFF20_0164,
    AUDIO_OUTL_ADDRESS          = 32'hFF20_0168,
    AUDIO_OUTR_ADDRESS          = 32'hFF20_016C,
    AUDIO_CTRL1_ADDRESS         = 32'hFF20_0170,
    AUDIO_CRTL2_ADDRESS         = 32'hFF20_0174,

    NOTE_SYSCALL_ADDRESS        = 32'hFF20_0178,
    NOTE_CLOCK                  = 32'hFF20_017C,
    NOTE_MELODY                 = 32'hFF20_0180,
    MUSIC_TEMPO_ADDRESS         = 32'hFF20_0184,
    MUSIC_ADDRESS               = 32'hFF20_0188,         // Endereco para uso do Controlador do sintetizador
    PAUSE_ADDRESS               = 32'hFF20_018C,
		
	 IRDA_DECODER_ADDRESS		 = 32'hFF20_0500,
	 IRDA_CONTROL_ADDRESS       = 32'hFF20_0504, 	 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
	 IRDA_READ_ADDRESS          = 32'hFF20_0508,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    IRDA_WRITE_ADDRESS         = 32'hFF20_050C,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    
	 STOPWATCH_ADDRESS			 = 32'hFF20_0510,	 //Feito em 2/2016 para servir de cronometro
	 
	 LFSR_ADDRESS					 = 32'hFF20_0514,			// Gerador de numeros aleatorios
	 
	 KEYMAP0_ADDRESS				 = 32'hFF20_0520,			// Mapa do teclado 2017/2
	 KEYMAP1_ADDRESS				 = 32'hFF20_0524,
	 KEYMAP2_ADDRESS				 = 32'hFF20_0528,
	 KEYMAP3_ADDRESS				 = 32'hFF20_052C,
	 
	 BREAK_ADDRESS					 = 32'hFF20_0600,  	  // Buffer do endereço do Break Point
	 
	 
/* STATES ************************************************************************************************************/
    FETCH           = 6'd0,
    DECODE          = 6'd1,
    EXE             = 6'd2,
    ACCESSorCONC    = 6'd3,
    CONC_LOAD       = 6'd4;

    
`endif
