`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:28:16 11/30/2024
// Design Name:   CPU
// Module Name:   /home/whalefall/Course/Lab2024/work/CPU_tb.v
// Project Name:  work
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_tb;

	// Inputs
	reg Clk;

	// Outputs
	wire [31:0] PC;
	wire [31:0] Inst;
	wire [31:0] R;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.Clk(Clk), 
		.PC(PC), 
		.Inst(Inst), 
		.R(R)
	);
	
	// Insts to be tested are in InstROM 

	initial begin		
       Clk = 1;
	end		
	always #50 Clk = ~Clk;	
	
	
endmodule		

