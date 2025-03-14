`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:45 12/07/2024 
// Design Name: 
// Module Name:    Mem_Wr 
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
module Mem_Wr(
			input Clk,
			input [31:0] M_Dout,
			input [31:0] M_ALUout,
			input M_Overflow,
			input [4:0] M_Rw,
			output reg [31:0] W_Dout,
			output reg [31:0] W_ALUout,
			output reg W_Overflow,
			output reg [4:0] W_Rw,

			input M_RegWr,
	 		input M_MemtoReg,
	 		output reg W_RegWr,
	 		output reg W_MemtoReg
    );
	 
	 always @ (negedge Clk)
	   begin
		  W_Dout  <= M_Dout;
		  W_ALUout   <= M_ALUout;
		  W_Overflow <= M_Overflow;
		  W_Rw  <=  M_Rw;
		  W_RegWr <= M_RegWr;
		  W_MemtoReg <= M_MemtoReg;
		end
	 
	 initial begin							//
	   W_Dout = 32'h0; W_ALUout = 32'h0; W_Overflow = 0; W_Rw = 0;
	   W_RegWr = 0; W_MemtoReg = 0;
	 end
	 
endmodule
