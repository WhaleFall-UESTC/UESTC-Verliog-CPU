`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:41:12 12/07/2024
// Design Name:   mux4to1
// Module Name:   /home/whalefall/Course/Lab2024/work/mux4t01_tb.v
// Project Name:  work
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux4to1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux4to1_testbench;

    // Inputs
    reg [1:0] Selector;
    reg [31:0] R0;
    reg [31:0] R1;
    reg [31:0] R2;
    reg [31:0] R3;

    // Outputs
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    mux4to1 uut (
        .Selector(Selector), 
        .R0(R0), 
        .R1(R1), 
        .R2(R2), 
        .R3(R3), 
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        Selector = 0;
        R0 = 32'hDEADBEEF;
        R1 = 32'hCAFEBABE;
        R2 = 32'hBADF00D;
        R3 = 32'h01234567;

        // Wait for global reset to finish
        #100;

        // Add stimulus here
        Selector = 2'b00;
        #100;
        Selector = 2'b01;
        #100;
        Selector = 2'b10;
        #100;
        Selector = 2'b11;
        #100;
        Selector = 2'b00;
        #100;

        $stop; // End the simulation
    end
      
endmodule
