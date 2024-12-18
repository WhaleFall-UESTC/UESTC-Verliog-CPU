`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:28 12/07/2024 
// Design Name: 
// Module Name:    Ex_Mem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Ex_Mem_lab5 (
			input Clk,
			input Clrn,
			input [31:0] E_Jtarg,
			input [31:0] E_Btarg, 
			input E_Zero, 
			input E_Overflow,
			input [31:0] E_ALUout,
			input [31:0] E_busB,
			input [4:0] E_Rw,
			output reg [31:0] M_Jtarg,
			output reg [31:0] M_Btarg, 
			output reg M_Zero, 
			output reg M_Overflow,
			output reg [31:0] M_ALUout,
			output reg [31:0] M_busB,
			output reg [4:0] M_Rw,

			input E_Jump,
	 		input E_Branch,
	 		input E_MemWr,
	 		output reg M_Jump, 
	 		output reg M_Branch,
	 		output reg M_MemWr,

	 		input E_RegWr,
	 		input E_MemtoReg,
	 		output reg M_RegWr,
	 		output reg M_MemtoReg
    );
	 
	 always @ (negedge Clk)
	   begin
		if (Clrn) begin
		  	M_Jtarg <= E_Jtarg;
		  	M_Btarg <= E_Btarg;
		  	M_Zero <= E_Zero;
		  	M_Overflow <= E_Overflow;
		  	M_ALUout <= E_ALUout;
		  	M_busB <= E_busB;
		  	M_Rw <= E_Rw;

			M_Jump <= E_Jump;
    		M_Branch <= E_Branch;
    		M_MemWr <= E_MemWr;

    		M_RegWr <= E_RegWr;
    		M_MemtoReg <= E_MemtoReg;
		end else begin
			M_Jtarg <= 32'h0;
		  	M_Btarg <= 32'h0;
		  	M_Zero <= 0;
		  	M_Overflow <= 0;
		  	M_ALUout <= 32'h0;
		  	M_busB <= 32'h0;
		  	M_Rw <= 4'h0;
		  	M_Jump <= 1'b0; M_Branch <= 1'b0; M_MemWr <= 1'b0;
    	  	M_RegWr <= 1'b0; M_MemtoReg <= 1'b0;
		end
	   end
	 
	 initial begin							//
		  M_Jtarg = 32'h0;
		  M_Btarg = 32'h0;
		  M_Zero = 0;
		  M_Overflow = 0;
		  M_ALUout = 32'h0;
		  M_busB = 32'h0;
		  M_Rw = 4'h0;
		  M_Jump = 1'b0; M_Branch = 1'b0; M_MemWr = 1'b0;
    	  M_RegWr = 1'b0; M_MemtoReg = 1'b0;
	 end
endmodule
