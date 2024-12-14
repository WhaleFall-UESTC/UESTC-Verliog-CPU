`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/03 23:58:22
// Design Name: 
// Module Name: InstROM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstROM(Addr, INST
    );
	input [31:0] Addr;		//Addr-ָ���ַ��
	output [31:0] INST;		//INST-���ָ�
	
	reg [31:0] InstROM [255:0];		//InstROM-ָ��洢����ģ��

   assign INST = InstROM[Addr[9:2]];
	
	parameter [5:0] OP_R_type = 6'b000000;
	parameter [5:0] OP_ori = 6'b001101;
	parameter [5:0] OP_addiu = 6'b001001;
	parameter [5:0] OP_lw = 6'b100011;
	parameter [5:0] OP_sw = 6'b101011;
	parameter [5:0] OP_beq = 6'b000100;
	parameter [5:0] OP_jump = 6'b000010;
	parameter [4:0] shamt = 5'b00000;
	parameter [5:0] FUNC_add = 6'b100000;
	parameter [5:0] FUNC_sub = 6'b100010;
	parameter [5:0] FUNC_subu = 6'b100011;
	parameter [5:0] FUNC_slt = 6'b101010;
	parameter [5:0] FUNC_sltu = 6'b101011;
	
	integer i;
	initial 
	  begin
	    for(i = 0; i < 256; i = i + 1)
		  InstROM[i] = 32'h00000000;
		  
		  //lw 0x1f, 0x00, 0x0000: Addr <- R[0x00] + SEXT(0x0000); R[0x1f] <- M[Addr];		
		  InstROM[8'h01] = {OP_lw, 5'b00000, 5'b11111, 16'h0000};		//PC = 0x04; INST = 32'h8c1f0000; R[0x1f] = 0x80000000;
		  InstROM[8'h02] = {OP_R_type, 5'b00000, 5'b11111, 5'b11110, shamt, FUNC_sub};		//PC = 0x08; INST = 32'h001ff022; R[0x1e] = 0x0000001e;
		  InstROM[8'h03] = {OP_R_type, 5'b10000, 5'b11111, 5'b11101, shamt, FUNC_add};		//PC = 0x0c; INST = 32'h021fe820; R[0x1d] = 0x80000010;
		  InstROM[8'h04] = {OP_R_type, 5'b00000, 5'b11101, 5'b11100, shamt, FUNC_sub};		//PC = 0x10; INST = 32'h001de022; R[0x1c] = 0x7ffffff0;
		  InstROM[8'h05] = {OP_R_type, 5'b10000, 5'b11100, 5'b11011, shamt, FUNC_add};		//PC = 0x14; INST = 32'h021fe820; R[0x1b] = 0x0000001b;
  		  InstROM[8'h06] = {OP_R_type, 5'b11111, 5'b00001, 5'b11010, shamt, FUNC_subu};		//PC = 0x18; INST = 32'h03e1d023; R[0x1a] = 0x80000001;
		  InstROM[8'h07] = {OP_R_type, 5'b00001, 5'b11111, 5'b11001, shamt, FUNC_slt};		//PC = 0x1c; INST = 32'h003fc82a; R[0x19] = 0x00000000;
		  InstROM[8'h08] = {OP_R_type, 5'b00001, 5'b11111, 5'b11000, shamt, FUNC_sltu};		//PC = 0x20; INST = 32'h003fc02b; R[0x18] = 0x00000001;
		  InstROM[8'h09] = {OP_addiu, 5'b00000, 5'b10111, 16'hab00};		//PC = 0x24; INST = 32'h2417ab00; R[0x17] = 0xffffab00;
		  InstROM[8'h0a] = {OP_addiu, 5'b00000, 5'b10110, 16'h00cd};		//PC = 0x28; INST = 32'h241600cd; R[0x16] = 0x000000cd;
		  InstROM[8'h0b] = {OP_ori, 5'b10110, 5'b10101, 16'hab00};		//PC = 0x2c; INST = 32'h36d5ab00; R[0x15] = 0x0000abcd;
		  InstROM[8'h0c] = {OP_sw, 5'b00000, 5'b10101, 16'h001f};		//PC = 0x30; INST = 32'hac15001f; M[0x1f] = 0x0000abcd;
		  InstROM[8'h0d] = {OP_beq, 5'b10101, 5'b10100, 16'h0003};		//PC = 0x34; INST = 32'h12b40003;
		  InstROM[8'h0e] = {OP_lw, 5'b00000, 5'b10100, 16'h001f};		//PC = 0x38; INST = 32'h8c14001f; R[0x14] = 0x0000abcd;
		  InstROM[8'h0f] = {OP_beq, 5'b10101, 5'b10100, 16'h0003};		//PC = 0x3c; INST = 32'h12b40003;
		  InstROM[8'h13] = {OP_jump, 26'h000000f};		//PC = 0x4c; INST =32'h0800000f ; NextPC = 0x3c;
		  
	  end
	
endmodule



/*
// lw $31, 0($0)
// 将内存地址 $0 + SEXT(0x0000) 的内容加载到寄存器$31 中
InstROM[8'h01] = {OP_lw, 5'b00000, 5'b11111, 16'h0000}; // PC = 0x04; INST = 32'h8c1f0000; R[31] = 0x80000000;

// sub $30,$31, $31
// 将寄存器 $31 的值减去寄存器$31 的值，结果存储在寄存器 $30 中
InstROM[8'h02] = {OP_R_type, 5'b00000, 5'b11111, 5'b11110, shamt, FUNC_sub}; // PC = 0x08; INST = 32'h001ff022; R[30] = 0x0000001e;

// add $29,$31, $30
// 将寄存器 $31 的值加上寄存器$30 的值，结果存储在寄存器 $29 中
InstROM[8'h03] = {OP_R_type, 5'b10000, 5'b11111, 5'b11101, shamt, FUNC_add}; // PC = 0x0c; INST = 32'h021fe820; R[29] = 0x80000010;

// sub $28,$29, $30
// 将寄存器 $29 的值减去寄存器$30 的值，结果存储在寄存器 $28 中
InstROM[8'h04] = {OP_R_type, 5'b00000, 5'b11101, 5'b11100, shamt, FUNC_sub}; // PC = 0x10; INST = 32'h001de022; R[28] = 0x7ffffff0;

// add $27,$30, $31
// 将寄存器 $30 的值加上寄存器$31 的值，结果存储在寄存器 $27 中
InstROM[8'h05] = {OP_R_type, 5'b10000, 5'b11100, 5'b11011, shamt, FUNC_add}; // PC = 0x14; INST = 32'h021fe820; R[27] = 0x0000001b;

// subu $26,$31, $0
// 将寄存器 $31 的值减去寄存器$0 的值，无符号结果存储在寄存器 $26 中
InstROM[8'h06] = {OP_R_type, 5'b11111, 5'b00001, 5'b11010, shamt, FUNC_subu}; // PC = 0x18; INST = 32'h03e1d023; R[26] = 0x80000001;

// slt $25,$31, $1
// 如果寄存器 $31 的值小于寄存器$1 的值，则将 1 存储在寄存器 $25 中，否则存储 0
InstROM[8'h07] = {OP_R_type, 5'b00001, 5'b11111, 5'b11001, shamt, FUNC_slt}; // PC = 0x1c; INST = 32'h003fc82a; R[25] = 0x00000000;

// sltu $24,$31, $1
// 如果寄存器 $31 的值无符号小于寄存器$1 的值，则将 1 存储在寄存器 $24 中，否则存储 0
InstROM[8'h08] = {OP_R_type, 5'b00001, 5'b11111, 5'b11000, shamt, FUNC_sltu}; // PC = 0x20; INST = 32'h003fc02b; R[24] = 0x00000001;

// addiu $23,$0, 0xffffab00
// 将立即数 0xffffab00 加到寄存器 $0 的值上，结果存储在寄存器$23 中
InstROM[8'h09] = {OP_addiu, 5'b00000, 5'b10111, 16'hab00}; // PC = 0x24; INST = 32'h2417ab00; R[23] = 0xffffab00;

// addiu $22,$0, 0x000000cd
// 将立即数 0x000000cd 加到寄存器 $0 的值上，结果存储在寄存器$22 中
InstROM[8'h0a] = {OP_addiu, 5'b00000, 5'b10110, 16'h00cd}; // PC = 0x28; INST = 32'h241600cd; R[22] = 0x000000cd;

// ori $21,$22, 0x0000abcd
// 将寄存器 $22 的值与立即数 0x0000abcd 进行按位或操作，结果存储在寄存器$21 中
InstROM[8'h0b] = {OP_ori, 5'b10110, 5'b10101, 16'hab00}; // PC = 0x2c; INST = 32'h36d5ab00; R[21] = 0x0000abcd;

// sw $21, 0x1f($0)
// 将寄存器 $21 的值存储到内存地址$0 + 0x1f 的位置
InstROM[8'h0c] = {OP_sw, 5'b00000, 5'b10101, 16'h001f}; // PC = 0x30; INST = 32'hac15001f; M[0x1f] = 0x0000abcd;

// beq $21,$20, 0x0003
// 如果寄存器 $21 的值等于寄存器$20 的值，则跳转到 PC + 0x0003 的位置
InstROM[8'h0d] = {OP_beq, 5'b10101, 5'b10100, 16'h0003}; // PC = 0x34; INST = 32'h12b40003;

// lw $20, 0x1f($0)
// 将内存地址 $0 + 0x1f 的内容加载到寄存器$20 中
InstROM[8'h0e] = {OP_lw, 5'b00000, 5'b10100, 16'h001f}; // PC = 0x38; INST = 32'h8c14001f; R[20] = 0x0000abcd;

// beq $21,$20, 0x0003
// 如果寄存器 $21 的值等于寄存器$20 的值，则跳转到 PC + 0x0003 的位置
InstROM[8'h0f] = {OP_beq, 5'b10101, 5'b10100, 16'h0003}; // PC = 0x3c; INST = 32'h12b40003;

// j 0x000000f
// 无条件跳转到地址 0x000000f
InstROM[8'h13] = {OP_jump, 26'h000000f}; // PC = 0x4c; INST = 32'h0800000f; NextPC = 0x3c;

*/