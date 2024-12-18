
`include "MUX32_2_1.v"
`include "PC.v"
`include "MyInstROM.v"
`include "IF_ID.v"
`include "ControlUnit.v"
`include "RegFiles.v"
`include "ID_Ex_lab4.v"
`include "Ext.v"
`include "ALU.v"
`include "Ex_Mem.v"
`include "DataRAM.v"
`include "Mem_Wr.v"
`include "DetUnit.v"
`include "DetUnit_load.v"

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:58 12/07/2024 
// Design Name: 
// Module Name:    PPCPU 
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
module PPCPU_lab4 (Clk, I_PC, I_Inst, Inst, E_ALUout, M_ALUout, W_RegDin);
        input Clk;			//
        output [31:0] I_PC;		//IF
        output [31:0] I_Inst;		//IF
        output [31:0] Inst;		//ID
        output [31:0] E_ALUout;//ExALU
        output [31:0] M_ALUout;	//MemALU
        output [31:0] W_RegDin;	//Wr
		  
		  
		  // IF
		  wire [31:0] PCin, PCout, I_PC4;
		  wire [31:0] I_PC_wire, I_Inst_wire;  // for output
		  
		  // ID
		  wire [31:0] PC4, PC, busA, busB, Jtarg;
		  // wire [25:0] target;
		  wire [4:0] Rs, Rt, Rd;
		  wire [5:0] func;
		  wire [15:0] immd;
		  wire [31:0] Inst_wire; // for output
		  
		  //Ex
		  wire [31:0] E_Jtarg, E_Btarg, E_PC4, E_busA, E_busB, E_immd_ext;
		  wire [15:0] E_immd;
		  wire [5:0] E_func;
		  wire [4:0] E_Rt, E_Rd, E_Rw;
		  //wire [2:0] /*E_ALUop, E_func_CU,*/ ALUctr;
		  wire E_RegDst, /*E_R_type,*/ E_Z, E_Overflow, E_ALUSrc, E_ExtOp;
		  wire [31:0] E_ALUout_wire; // for output
		  
		  //Mem
		  wire [31:0] M_Btarg, M_Jtarg, M_busB,M_Dout, E_Btarg_or_Jtarg;
		  wire [4:0] M_Rw;
		  wire M_Z, M_Overflow, M_MemWr, M_Branch, M_Jump, E_PCSrc;
		  wire [31:0] M_ALUout_wire; // for output
		  
		  // Wr
		  wire [31:0] W_Dout, W_ALUout;
		  wire [4:0] W_Rw;
		  wire W_Overflow, W_RegWr, W_RegWE, W_MemtoReg;
		  wire [31:0] W_RegDin_wire; // for output
		  
		  assign I_PC = I_PC_wire;
		  assign I_Inst = I_Inst_wire;
		  assign Inst = Inst_wire;
		  assign E_ALUout = E_ALUout_wire;
		  assign M_ALUout = M_ALUout_wire;
		  assign W_RegDin = W_RegDin_wire;



		  /************
				IF
			***********/
			
		  MUX32_2_1 mux32_3(
				.X1(E_Btarg_or_Jtarg),
				.X0(I_PC4),
				.S(E_PCSrc),
				.Y(PCin)
			);
					
		  	PC pc (
				.Clk(Clk),
				.PCin(PCin),
				.PCout(I_PC_wire)
			);
			
			// wire [31:0] PCadd;
			// assign PCadd = ;
			// Adder32 AdderIF (
			// 		.A(I_PC_wire), .B(32'h4), .F(I_PC4), 
			// 		.Cin(), .Cout(),
            //    .OF(), .SF(), .ZF(), .CF()
			// );
			assign I_PC4 = I_PC_wire + 4;
			
			MyInstROM instROM (
					.Addr(I_PC_wire), 
					.INST(I_Inst_wire)
			);
			
			IF_ID if_id (
					.Clk(Clk), 
					.I_PC4(I_PC4), .I_PC(I_PC_wire), .I_Inst(I_Inst_wire), 
					.PC4(PC4), .PC(PC), .Inst(Inst_wire)
			);
			
				
				
		  /************
				ID
			***********/
			
			wire [5:0] OP;
			assign OP = Inst[31:26];
			assign Rs = Inst[25:21];
			assign Rt = Inst[20:16];
			assign Rd = Inst[15:11];
			assign immd = Inst[15:0];
			assign func = Inst[5:0];

			wire ExtOp, ALUSrc, RegDst, Jump, Branch, MemWr, RegWr, MemtoReg; 
			wire [2:0] ALUctr;
			
			ControlUnit CU (
					.OP(OP), .func(func), 
					.RegWr(RegWr), 
					.ALUSrc(ALUSrc), 
					.RegDst(RegDst),
					.MemtoReg(MemtoReg), 
					.MemWr(MemWr), 
					.Branch(Branch), 
					.Jump(Jump),
					.ExtOp(ExtOp), 
					.ALUctr(ALUctr)
			 );
			 
			 RegFiles regfiles (
					.CLK(Clk), 
					.busW(W_RegDin), 
					.WE(W_RegWE), 
					.Rw(W_Rw), 
					.Ra(Rs), 
					.Rb(Rt), 
					.busA(busA), 
					.busB(busB)
				);

			wire E_Jump, E_Branch, E_MemWr, E_RegWr, E_MemtoReg;
			wire [2:0] E_ALUctr;
			wire [4:0] E_Rs;
			assign Jtarg = {PC[31:28], Inst[25:0], 2'b00};
			ID_Ex_lab4 id_ex (
					.Clk(Clk),
					.PC4(PC4), .Jtarg(Jtarg), 
					.busA(busA), .busB(busB), 
					.func(func), .immd(immd),
					.Rd(Rd), .Rt(Rt), .Rs(Rs),
					.E_PC4(E_PC4), .E_Jtarg(E_Jtarg) ,
					.E_busA(E_busA), .E_busB(E_busB),
					.E_func(E_func), .E_immd(E_immd),
					.E_Rd(E_Rd), .E_Rt(E_Rt), .E_Rs(E_Rs),

					.ExtOp(ExtOp), .RegDst(RegDst), .ALUSrc(ALUSrc), .ALUctr(ALUctr),
					.E_ExtOp(E_ExtOp), .E_RegDst(E_RegDst), .E_ALUSrc(E_ALUSrc), .E_ALUctr(E_ALUctr),

					.Jump(Jump), .Branch(Branch), .MemWr(MemWr), 
					.E_Jump(E_Jump), .E_Branch(E_Branch), .E_MemWr(E_MemWr),

					.RegWr(RegWr), .MemtoReg(MemtoReg), 
					.E_RegWr(E_RegWr), .E_MemtoReg(E_MemtoReg)
			);
			
					
		  /************
				Ex
			***********/
			
			assign E_Rw = (E_RegDst ? E_Rd : E_Rt);
			
			Ext ext1 (
					.imm16(E_immd), 
					.ExtOp(E_ExtOp), 
					.Extout(E_immd_ext)
			);

			wire [1:0] ALUSrcA, ALUSrcB;
			DetUnit detunit (
				.E_Rs(E_Rs),
				.E_Rt(E_Rt),
				.E_ALUSrc(E_ALUSrc),
				.M_Rw(M_Rw),
				.W_Rw(W_Rw),
				.M_RegWr(M_RegWr),
				.W_RegWr(W_RegWr),
				.ALUSrcA(ALUSrcA),
				.ALUSrcB(ALUSrcB)
			);

			wire [31:0] AluA, AluB;
			mux4to1 mux1 (
				.Selector(ALUSrcA),
				.R0(E_busA),
				.R1(M_ALUout),
				.R2(W_RegDin),
				.Result(AluA)
			);

			mux4to1 mux2 (
				.Selector(ALUSrcB), 
				.R0(E_busB),
				.R1(M_ALUout),
				.R2(W_RegDin),
				.R3(E_immd_ext),
				.Result(AluB)
			);
			
			
			ALU alu_ppcpu (
					.X(AluA), 
					.Y(AluB), 
					.ALUctr(E_ALUctr), 
					.R(E_ALUout_wire), 
					.Overflow(E_Overflow), 
					.Zero(E_Z)
			);
			
			// Adder32 adderEx (
			// 		.A(E_PC4), .B(E_immd_ext << 2), .F(E_Btarg), 
			// 		.Cin(), .Cout(),
            //    .OF(), .SF(), .ZF(), .CF()
			// );
			assign E_Btarg = E_PC4 + (E_immd_ext << 2);
			
			wire M_RegWr, M_MemtoReg;
			Ex_Mem ex_mem (
					.Clk(Clk),
					.E_Jtarg(E_Jtarg), .E_Btarg(E_Btarg), 
					.E_Zero(E_Z), .E_Overflow(E_Overflow), .E_ALUout(E_ALUout),
					.E_busB(E_busB), .E_Rw(E_Rw),
					.M_Jtarg(M_Jtarg), .M_Btarg(M_Btarg), 
					.M_Zero(M_Z), .M_Overflow(M_Overflow),
					.M_ALUout(M_ALUout), .M_busB(M_busB), .M_Rw(M_Rw),

					.E_Jump(E_Jump), .E_Branch(E_Branch), .E_MemWr(E_MemWr),
					.M_Jump(M_Jump), .M_Branch(M_Branch), .M_MemWr(M_MemWr),

					.E_RegWr(E_RegWr), .E_MemtoReg(E_MemtoReg),
					.M_RegWr(M_RegWr), .M_MemtoReg(M_MemtoReg)
			);
			
			
			
			/************
				Mem
			***********/
			
			MUX32_2_1 mux32_5 (
					.X0(M_Jtarg),
					.X1(M_Btarg),
					.S(M_Branch),
					.Y(E_Btarg_or_Jtarg)
			);
			
			assign E_PCSrc = M_Jump | (M_Branch & M_Z);
			
			DataRAM RAM_1 (
					.CLK(Clk), 
					.DataIn(M_busB), .DataOut(M_Dout),
					.WE(M_MemWr), .Address(M_ALUout)
			);
			
			Mem_Wr mem_wr (
					.Clk(Clk),
					.M_Dout(M_Dout), .M_ALUout(M_ALUout),
					.M_Overflow(M_Overflow), .M_Rw(M_Rw),
					.W_Dout(W_Dout), .W_ALUout(W_ALUout),
					.W_Overflow(W_Overflow), .W_Rw(W_Rw),

					.M_RegWr(M_RegWr), .M_MemtoReg(M_MemtoReg),
					.W_RegWr(W_RegWr), .W_MemtoReg(W_MemtoReg)
			);
			
			
			
			/************
				Wr
			***********/

			MUX32_2_1 mux32_6 (
					.X0(W_ALUout),
					.X1(W_Dout),
					.S(W_MemtoReg),
					.Y(W_RegDin)
			);
			
			assign W_RegWE = (W_RegWr & (~W_Overflow));
			
		  
endmodule
