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
module Ex_Mem(
			input Clk,
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
			output reg [4:0] M_Rw
    );
	 
	 always @ (negedge Clk)
	   begin
		  M_Jtarg <= E_Jtarg;
		  M_Btarg <= E_Btarg;
		  M_Zero <= E_Zero;
		  M_Overflow <= E_Overflow;
		  M_ALUout <= E_ALUout;
		  M_busB <= E_busB;
		  M_Rw <= E_Rw;
		end
	 
	 initial begin							//
		  M_Jtarg = 32'h0;
		  M_Btarg = 32'h0;
		  M_Zero = 0;
		  M_Overflow = 0;
		  M_ALUout = 32'h0;
		  M_busB = 32'h0;
		  M_Rw = 4'h0;
	 end
endmodule
