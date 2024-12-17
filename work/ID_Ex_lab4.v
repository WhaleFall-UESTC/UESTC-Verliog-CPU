`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:18 12/07/2024 
// Design Name: 
// Module Name:    ID_Ex 
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
module ID_Ex_lab4(
	 input Clk,
	 input [31:0] PC4,
	 input [31:0] Jtarg, 				//ID
	 input [31:0] busA,
	 input [31:0] busB,
	 input [5:0] func,
	 input [15:0] immd,
	 input [4:0] Rd,
	 input [4:0] Rt,
     input [4:0] Rs,
	 output reg [31:0] E_PC4,
	 output reg [31:0] E_Jtarg,		//Ex
	 output reg [31:0]  E_busA,
	 output reg [31:0] E_busB,
	 output reg [5:0] E_func,
	 output reg [15:0] E_immd,
	 output reg [4:0] E_Rd,
	 output reg [4:0] E_Rt,
     output reg [4:0] E_Rs,

	 input ExtOp,
	 input RegDst,
	 input ALUSrc,
	 input [2:0] ALUctr,
	 output reg E_ExtOp,
	 output reg E_RegDst,
	 output reg E_ALUSrc,
	 output reg [2:0] E_ALUctr,

	 input Jump,
	 input Branch,
	 input MemWr,
	 output reg E_Jump, 
	 output reg E_Branch,
	 output reg E_MemWr,

	 input RegWr,
	 input MemtoReg,
	 output reg E_RegWr,
	 output reg E_MemtoReg


	 );
	 
	 always @ (negedge Clk)
	   begin
		  E_PC4 <= PC4;
		  E_Jtarg <= Jtarg;
		  E_busA <= busA;
		  E_busB <= busB;
		  E_func <= func;
		  E_immd <= immd;
		  E_Rd <= Rd;
		  E_Rt <= Rt;
          E_Rs <= Rs;

		  	E_ExtOp <= ExtOp;
    		E_RegDst <= RegDst;
    		E_ALUSrc <= ALUSrc;
    		E_ALUctr <= ALUctr;

    		E_Jump <= Jump;
    		E_Branch <= Branch;
    		E_MemWr <= MemWr;

    		E_RegWr <= RegWr;
    		E_MemtoReg <= MemtoReg;
		end
	 
	 initial begin							
	   E_PC4 = 32'h0; E_Jtarg = 32'h0; E_busA = 32'h0; E_busB = 32'h0;
		E_func = 5'h0; E_immd = 16'h0; E_Rd = 4'h0; E_Rt = 4'h0; E_Rs = 4'h0;
	 	E_ExtOp = 1'b0; E_RegDst = 1'b0; E_ALUSrc = 1'b0; E_ALUctr = 3'h0;
    	E_Jump = 1'b0; E_Branch = 1'b0; E_MemWr = 1'b0;
    	E_RegWr = 1'b0;	E_MemtoReg = 1'b0;
	 end


endmodule
