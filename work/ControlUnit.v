`include "ControlUnit_main.v"
`include "ControlUnit_ALU.v"
`include "MUX3_2_1.v"

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:30 08/04/2024 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(OP, func, 
                   RegWr, ALUSrc, RegDst,
						 MemtoReg, MemWr, Branch, Jump,
						 ExtOp, ALUctr
    );
	 input [5:0] OP;		//OP-ָ�����ͱ��룻
	 input [5:0] func;	//func-R_typeָ��ܱ��룻
	 output RegWr;			//RegWr-�Ĵ���д�źţ�
	 output ALUSrc;		//ALUSrc-ѡ��ALU�ڶ�����������
	 output RegDst;		//RegDst-ѡ��Ŀ�ļĴ�����
	 output MemtoReg;		//MemtoReg-ѡ��д��Ĵ��������ݣ�
	 output MemWr;			//MemWr-�洢��д�źţ�
	 output Branch;		//Branch-����ת��ָ���ж��źţ�
	 output Jump;			//Jump-������ת��ָ���ж��źţ�
	 output ExtOp;			//ExtOp-ѡ����з�����չ��������չ��
	 output [2:0] ALUctr;		//ALUctr-ALU�����źţ�
	 
	 wire [2:0] ALUop;		//ALUop-��R_typeָ��ʱ����ָ�����͸���ALU�����źţ�	
	 wire [2:0] ALUop_R;		//ALUop_R-R_typeָ��ʱ����func�������ALU�����źţ�
	 wire R_type;		//R_type-�жϵ�ǰָ���Ƿ�ΪR_typeָ�
	 
	 ControlUnit_main U1 (.OP(OP), .RegWr(RegWr), .ALUSrc(ALUSrc), .RegDst(RegDst), 
                         .MemtoReg(MemtoReg), .MemWr(MemWr), .Branch(Branch), .Jump(Jump),
								 .ExtOp(ExtOp), .ALUop(ALUop), .R_type(R_type)
                         );
    ControlUnit_ALU U2 (.func(func), .ALUctr(ALUop_R));
	 MUX3_2_1 U3 (.X1(ALUop_R), .X0(ALUop), .S(R_type), .Y(ALUctr));

endmodule
