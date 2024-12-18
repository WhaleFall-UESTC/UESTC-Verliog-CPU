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


module MyInstROM_CPU(Addr, INST
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
		  
		  // addi $1,$0, 5   // $1 = 5
        InstROM[1] = {OP_addiu, 5'b00000, 5'b00001, 16'h0005};
        // lw $2, 0($0)     // $2 = M[0]
        InstROM[2] = {OP_lw, 5'b00000, 5'b00010, 16'h0000};
        // addi $3,$0, 10  // $3 = 10
        InstROM[3] = {OP_addiu, 5'b00000, 5'b00011, 16'h000A};
        // sw $1, 4($0)     // M[4] = $1
        InstROM[4] = {OP_sw, 5'b00000, 5'b00001, 16'h0004};
        // beq $2,$3, 4    // if ($2 ==$3) PC += 4
        InstROM[5] = {OP_beq, 5'b00010, 5'b00011, 16'h0004};
        // lw $4, 4($0)     // $4 = M[4]
        InstROM[6] = {OP_lw, 5'b00000, 5'b00100, 16'h0004};
        // addi $5,$4, 1   // $5 =$4 + 1
        InstROM[7] = {OP_addiu, 5'b00100, 5'b00101, 16'h0001};
        // sw $5, 8($0)     // M[8] = $5
        InstROM[8] = {OP_sw, 5'b00000, 5'b00101, 16'h0008};
        // j 0x0000000C     // 无条件跳转到地址 0x0000000C
        InstROM[9] = {OP_jump, 26'h000000C};
	  end
	
endmodule