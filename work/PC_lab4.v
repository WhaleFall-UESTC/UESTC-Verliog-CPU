`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:31:48 08/04/2024 
// Design Name: 
// Module Name:    PC 
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
module PC_lab4(Clk, EN, PCin, PCout
    );
	 input Clk;		//CLK-ʱ���źţ�
	 input EN;
	 input [31:0] PCin;	//PCin-������������룻
	 output [31:0] PCout;	//PCout-��������������
	 
	 reg [31:0] PC = 32'h00000000;
	 
	 always @ (negedge Clk)
	 	if (EN) begin
	   		PC <= PCin;
		end
	 assign PCout = PC;	  

endmodule
