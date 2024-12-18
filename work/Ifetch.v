`include "PC.v"
`include "SEXT.v"
`include "MyInstROM_CPU.v"

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:10:50 08/04/2024 
// Design Name: 
// Module Name:    Ifetch 
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
module Ifetch(Clk, Jump, Branch, Z, Inst, PC
    );
	 input Clk;			//Clk-ʱ���źţ�
	 input Jump;		//Jump-������ת�Ʊ�־��
	 input Branch;		//Branch-����ת�Ʊ�־��
	 input Z;		//Z-�ӷ������־��
	 output [31:0] Inst;	//Inst-ָ�
	 output [31:0] PC;	//ָ���ַ��
	 
	 wire [31:0] PCin;		//PCin-PC�������룻
	 wire [31:0] PCout;		//PCout-PC���������
	 wire [31:0] PC4;		//PC4-��ǰPC��4��
	 wire [15:0] immd = Inst[15:0];
	 wire [31:0] SEXTout;		//SEXTout-������չ�������
	 wire [31:0] Addr_Beq;		//Addr_Beq-������ת��ַ��
	 wire [31:0] Addr_Jump;		//Addr_Jump-��������ת��ַ��
	 wire [31:0] Addr_NJump;	//Addr_NJump-������������תָ��ĵ�ַ��	 
	 
	 PC U1 (.Clk(Clk), .PCin(PCin), .PCout(PCout));
	 Adder32 U2 (.A(PCout), .B(32'h4), .F(PC4), .Cin(1'b0), .Cout(),
                .OF(), .SF(), .ZF(), .CF()
    				);
	 SEXT U3 (.datain(immd), .dataout(SEXTout));
	 Adder32 U4 (.A(PC4), .B(SEXTout << 2), .F(Addr_Beq), .Cin(1'b0), .Cout(),
                .OF(), .SF(), .ZF(), .CF()
    				);
	 MUX32_2_1 U5 (.X1(Addr_Beq), .X0(PC4), .S(Branch & Z), .Y(Addr_NJump));
	 MUX32_2_1 U6 (.X1(Addr_Jump), .X0(Addr_NJump), .S(Jump), .Y(PCin));
	 MyInstROM_CPU U7 (.Addr(PCout), .INST(Inst));
	 
	 assign Addr_Jump = {PCout[31:28], Inst[25:0], 2'b00};
	 assign PC = PCout;

endmodule
