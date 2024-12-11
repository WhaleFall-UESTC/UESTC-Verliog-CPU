`include "Adder16.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:56 08/01/2024 
// Design Name: 
// Module Name:    Adder32 
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
module Adder32(A, B, F, Cin, Cout,
               OF, SF, ZF, CF
    );
	 input [31:0] A, B;		//A-32λ�������� B-32λ������
	 input Cin;		//Cin-���λ��λ���룻
	 output [31:0] F;		//F-�ӷ������
	 output Cout;		//Cout-���λ��λ�����
	 output OF;		//OF-�����־��
	 output SF;		//SF-���ű�־��
	 output ZF;		//ZF-���־��
	 output CF;		//CF-��λ/��λ��־��
	 
	 wire Gx1, Gx0, Px1, Px0;
	 wire C15, C31, C30;
	 
	 Adder16 LW (.A(A[15:0]), .B(B[15:0]), .Cin(Cin), .F(F[15:0]), .Px(Px0), .Gx(Gx0), .C14());
	 Adder16 HW (.A(A[31:16]), .B(B[31:16]), .Cin(C15), .F(F[31:16]), .Px(Px1), .Gx(Gx1), .C14(C30));
	 
	 assign C15 = Gx0 + (Px0 & Cin);
	 assign C31 = Gx1 + (Px1 & Gx0) + (Px1 & Px0 & Cin);
	 assign Cout = C31;
	 
	 assign OF = C31 ^ C30;
	 assign SF = F[31];
	 assign ZF = ~|F;		//��Լ����������F�źŰ�λ���õ�һλ�źź�ȡ����
	 assign CF = Cout ^ Cin;
	 

endmodule
