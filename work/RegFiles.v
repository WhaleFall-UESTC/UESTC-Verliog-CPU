`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:33:17 08/04/2024 
// Design Name: 
// Module Name:    RegisterFiles 
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
module RegFiles(CLK, busW, WE, Rw, Ra, Rb, busA, busB
    );
	 input CLK;			//CLK-д��ʱ���źţ�
	 input [31:0] busW;		//busW-д�����ݣ�
	 input WE;			//WE-дʹ���źţ�
	 input [4:0] Rw;			//Rw-д���ݵ�ַ��
	 input [4:0] Ra, Rb;		//Ra,Rb-�����ݵ�ַ��
	 output [31:0] busA, busB;		//busA,busB-�������źţ�
	 
	 reg [31:0] RegFiles [31:0];		//ͨ�üĴ����齨ģ
	 
	 always @ (negedge CLK)
	   if(WE) RegFiles[Rw] <= busW;
		
	 assign busA = RegFiles[Ra];
	 assign busB = RegFiles[Rb];
	 
	 integer i;
	 initial
	   begin
		  for(i = 0; i < 32; i = i + 1)
		    RegFiles[i] = i;
		  RegFiles[1] = 2;
	   end

endmodule
