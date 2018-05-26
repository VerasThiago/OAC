/*
 * Bloco de Controle UNICICLO
 *
 */

 module Control_UNI(
    input  wire        iCLK,
    input  wire [6:0]  iOp, iFunct7,
    input  wire [2:0]  iFunct3,
    output wire [1:0]  oALUop,
    output wire oBranch, oMemRead, oMemtoReg, oMemWrite, oALUsrc, oRegWrite

);


initial
begin
	oBranch = 1'b0;
	oMemRead = 1'b0;
	oMemtoReg = 1'b0;
	oALUop = 2'b0;
	oMemWrite = 1'b0;
	oALUsrc = 1'b0;
	oRegWrite = 1'b0;
end


always @(*)
begin
	case(iOp)
        OPCRTYPE:
        begin
            oBranch = 1'b0;
            oMemRead = 1'b0;
            oMemtoReg = 1'b0;
            oALUop = 2'b10;
            oMemWrite = 1'b0;
            oALUsrc = 1'b0;
            oRegWrite = 1'b1;
        end
	OPCSHIFTIMM:
	begin
            oBranch = 1'b0;
            oMemRead = 1'b0;
            oMemtoReg = 1'b0;
            oALUop = 2'b10;
            oMemWrite = 1'b0;
            oALUsrc = 1'b1;
            oRegWrite = 1'b1;
	end
	OPCLOAD:
  	begin
            oBranch = 1'b0;
            oMemRead = 1'b1;
            oMemtoReg = 1'b1;
            oALUop = 2'b00;
            oMemWrite = 1'b0;
            oALUsrc = 1'b1;
            oRegWrite = 1'b1;
	end
	begin
	OPCLOGICIMM:
            oBranch = 1'b0;
            oMemRead = 1'b0;
            oMemtoReg = 1'b1;
            oALUop = 2'b10;
            oMemWrite = 1'b1;
            oALUsrc = 1'b1;
            oRegWrite = 1'b1;
	end
	begin
	OPCBRANCH:
            oBranch = 1'b1;
            oMemRead = 1'b0;
            oMemtoReg = 1'b0; //0 ou 1
            oALUop = 2'b10;
            oMemWrite = 1'b0;
            oALUsrc = 1'b0;
            oRegWrite = 1'b0;		  
	end
	begin
	OPCJAL:
            oBranch = 1'b1;
            oMemRead = 1'b0;
            oMemtoReg = 1'b0;
            oALUop = 2'b10;
            oMemWrite = 1'b0;
            oALUsrc = 1'b1;
            oRegWrite = 1'b0;
	end
	begin
	OPCJALR:
            oBranch = 1'b1;
            oMemRead = 1'b0;
            oMemtoReg = 1'b0;
            oALUop = 2'b10;
            oMemWrite = 1'b0;
            oALUsrc = 1'b1;
            oRegWrite = 1'b1;				
	end
		  
    endcase
end

endmodule
