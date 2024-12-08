`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:51:09 11/30/2024 
// Design Name: 
// Module Name:    CPU 
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
module CPU(Clk, PC, Inst, R);
			input Clk;						//
			output [31:0] PC;		//
			output [31:0] Inst;	//
			output [31:0] R;		//ALU
		
			wire Jump, Branch, Zero, Overflow;
			wire RegWr, ALUSrc, RegDst, MemtoReg, MemWr, ExtOp, WE;
			wire [2:0] ALUctr;
			
			wire [5:0] OP;
			wire [4:0] Rs, Rt, Rd, Rw;
			wire [15:0] immd;
			wire [5:0] func;
			wire [31:0] extImmd, busA, busB, aluB, busW, Dout, Result;
			
			assign OP = Inst[31:26];
			assign Rs = Inst[25:21];
			assign Rt = Inst[20:16];
			assign Rd = Inst[15:11];
			assign immd = Inst[15:0];
			assign func = Inst[5:0];
			
			assign R = Result;
			
			assign WE = (~Overflow) & RegWr;
			
			MUX32_2_1 mux32_1(
					.X1(extImmd),
					.X0(busB),
					.S(ALUSrc),
					.Y(aluB)
			);
			
			MUX32_2_1 mux32_2(
					.X1(Dout),
					.X0(Result),
					.S(MemtoReg),
					.Y(busW)
			);
			
			MUX5_2_1 mux5(
					.X1(Rd),
					.X0(Rt),
					.S(RegDst),
					.Y(Rw)
			);
			
			ALU cpu_alu(
					.X(busA), 
					.Y(aluB), 
					.ALUctr(ALUctr), 
					.R(Result), 
					.Overflow(Overflow), 
					.Zero(Zero)
			);
			
			Ifetch ifetch(
					.Clk(Clk),
					.Jump(Jump),
					.Branch(Branch),
					.Z(Zero),
					.Inst(Inst),
					.PC(PC)
			);
			
			ControlUnit controlUnit(
					.OP(OP), 
					.func(func), 
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
				
			RegFiles regs(
					.CLK(Clk), 
					.busW(busW), 
					.WE(WE), 
					.Rw(Rw), 
					.Ra(Rs), 
					.Rb(Rt), 
					.busA(busA), 
					.busB(busB)
			);
			
			
			Ext ext(
					.imm16(immd), 
					.ExtOp(ExtOp), 
					.Extout(extImmd)
			);
			
			DataRAM RAM(
					.CLK(Clk), 
					.DataIn(busB), 
					.WE(MemWr), 
					.Address(Result), 
					.DataOut(Dout)
			);
			
endmodule
