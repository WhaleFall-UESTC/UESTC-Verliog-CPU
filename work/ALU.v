`include "Adder32.v"
`include "mux4to1.v"

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:32 11/23/2024 
// Design Name: 
// Module Name:    ALU 
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
module ALU (X, Y, ALUctr, R, Overflow, Zero);
            input [31:0] X, Y;				//32
            input [2:0] ALUctr;						//ALU
            output [31:0] R;				//32
            output Overflow, Zero;	//Overflow-Zero-

				wire SUBctr, OVctr, SIGctr;
				wire [1:0] OPctr;
				
				assign SUBctr = ALUctr[2];
				assign OVctr   = ~ALUctr[1] & ALUctr[0];
				assign SIGctr  = ALUctr[0];
				assign OPctr[1] = ALUctr[2] & ALUctr[1];
				assign OPctr[0] = ~ALUctr[2] & ALUctr[1] & ~ALUctr[0];
				
				wire [31:0] Data_Y;
				wire [31:0] one32, zero32;
				assign one32 = 32'hffffffff;
				assign zero32 = 32'h0;
				assign Data_Y = (SUBctr ? one32 ^ Y: Y);
				
				wire [31:0] F;
				wire OF, SF, CF;
				
				Adder32 adder32(
						.A(X),
						.B(Data_Y),
						.F(F),						// R0
						.Cin(SUBctr), 
						.Cout(),
						.OF(OF), 
						.SF(SF),
						.ZF(Zero),				// result of Zero
						.CF(CF)
				);
				
				assign Overflow = OVctr & OF;		// result of Overflow
				
				wire [31:0] Result;
				
				mux4to1 mux (
						.Selector(OPctr),
						.R0(F),
						.R1(X | Y),
						.R2((SIGctr ? (OF & SF) : CF) ? one32 : zero32),
						.R3(32'h0),
						.Result(Result)				// result of R
				);

				assign R = Result;

endmodule
