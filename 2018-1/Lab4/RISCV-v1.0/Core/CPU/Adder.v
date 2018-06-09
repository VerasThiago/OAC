/* Adder 32 bits*/

module Adder (
	input iClk,
	input [31:0] iA,
	input [31:0] iB,
	output reg [31:0] oResult
);


always @(posedge iClk)
	begin
		oResult = iA + iB;
	end
endmodule
