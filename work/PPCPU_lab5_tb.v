`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:25:04 12/08/2024
// Design Name:   PPCPU
// Module Name:   /home/whalefall/Course/Lab2024/work/PPCPU_tb.v
// Project Name:  work
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PPCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PPCPU_lab5_tb;

	// Inputs
	reg Clk;

	// Outputs
	wire [31:0] I_PC;
	wire [31:0] I_Inst;
	wire [31:0] Inst;
	wire [31:0] E_ALUout;
	wire [31:0] M_ALUout;
	wire [31:0] W_RegDin;

	// Instantiate the Unit Under Test (UUT)
	PPCPU_lab5 uut (
		.Clk(Clk), 
		.I_PC(I_PC), 
		.I_Inst(I_Inst), 
		.Inst(Inst), 
		.E_ALUout(E_ALUout), 
		.M_ALUout(M_ALUout), 
		.W_RegDin(W_RegDin)
	);

	initial begin
		$dumpfile("PPCPU_lab5_tb.vcd");
        $dumpvars(0, PPCPU_lab5_tb);		
       Clk = 1;
	   #3000 $finish;
	end		
	always #10 Clk = ~Clk;	
      
endmodule

