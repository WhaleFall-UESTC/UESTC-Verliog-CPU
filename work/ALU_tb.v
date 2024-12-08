`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:56:38 11/23/2024
// Design Name:   ALU
// Module Name:   /home/whalefall/Course/Lab2024/work/ALU_tb.v
// Project Name:  work
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module ALU_tb;

    reg [31:0] X, Y;
    reg [2:0] ALUctr;
    wire [31:0] R;
    wire Overflow, Zero;
    
    // Instantiate the ALU module
    ALU alu_instance (
        .X(X),
        .Y(Y),
        .ALUctr(ALUctr),
        .R(R),
        .Overflow(Overflow),
        .Zero(Zero)
    );
    
    initial begin
        // Initial values
        X = 32'h22222222;
        Y = 32'h11111111;
        ALUctr = 3'b000; // ADD operation
        
        // Apply some delay before starting the test
        #10;
        
        // Test different operations
        // Test ADD
        ALUctr = 3'b001;
        #10;
        
        // Test SUB
        ALUctr = 3'b101;
        #10;
        
        // Test SLT
        ALUctr = 3'b111;
        #10;
        
        // Test ORI
        ALUctr = 3'b010;
        #10;
        
        // Test ADDIU
        ALUctr = 3'b000;
        #10;
        
        // Test LW
        ALUctr = 3'b000;
        #10;
        
        // Test SW
        ALUctr = 3'b000;
        #10;
        
        // Test BEQ
        ALUctr = 3'b101;
        #10;
        
        
        // Finish simulation
        $finish;
    end
    
endmodule