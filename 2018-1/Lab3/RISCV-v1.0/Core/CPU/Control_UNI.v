/*
 * Bloco de Controle UNICICLO
 *
 */

 module Control_UNI(
    input  wire [6:0]  iOp, iFunct7,
    input  wire [2:0]  iFunct3,
    output wire [1:0]  oALUop,
    output wire oBranch, oMemRead, oMemtoReg, oMemWrite, oALUsrc, oRegWrite
);


initial
begin
	oALUsrc   = 1'b0;
	oMemtoReg = 1'b0;
	oRegWrite = 1'b0;
	oMemRead  = 1'b0;
	oMemWrite = 1'b0;
	oBranch   = 1'b0;
	oALUop    = 2'b0;
end


always @(*)
begin
	case(iOp)
        OPCRTYPE:
	        begin
		    	oALUsrc   = 1'b0;
				oMemtoReg = 1'b0;
				oRegWrite = 1'b1;
				oMemRead  = 1'b0;
				oMemWrite = 1'b0;
				oBranch   = 1'b0;
				oALUop    = 2'b10;
	        end
	    OPCIMM,
	    OPCLOGICIMM:
	    	begin
	    		oALUsrc   = 1'b1;
				oMemtoReg = 1'b0;
				oRegWrite = 1'b1;
				oMemRead  = 1'b0;
				oMemWrite = 1'b0;
				oBranch   = 1'b0;
				oALUop    = 2'b11;
	    	end
	    OPCLOAD:
	    	begin
	    		oALUsrc   = 1'b1;
				oMemtoReg = 1'b1;
				oRegWrite = 1'b1;
				oMemRead  = 1'b1;
				oMemWrite = 1'b0;
				oBranch   = 1'b0;
				oALUop    = 2'b00;
	    	end
	    OPCBRANCH:
	    	begin
	    		oALUsrc   = 1'b0;
				oMemtoReg = 1'b0;
				oRegWrite = 1'b0;
				oMemRead  = 1'b0;
				oMemWrite = 1'b0;
				oBranch   = 1'b1;
				oALUop    = 2'b11;	    		
	    	end
	    OPCSTORE:
	    	begin
	    		oALUsrc   = 1'b0;
				oMemtoReg = 1'b0;
				oRegWrite = 1'b0;
				oMemRead  = 1'b0;
				oMemWrite = 1'b0;
				oBranch   = 1'b1;
				oALUop    = 2'b11;	    	
	    	end
	    OPCLUI,
	    OPCAUIPC:
	    	begin
	    		oALUsrc   = 1'b1;
				oMemtoReg = 1'b0;
				oRegWrite = 1'b1;
				oMemRead  = 1'b0;
				oMemWrite = 1'b0;
				oBranch   = 1'b0;
				oALUop    = 2'b00;	    	
			end 
    endcase
end

endmodule
