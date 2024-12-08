`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:41 11/23/2024 
// Design Name: 
// Module Name:    MUXwire 
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
module MUXwire(Selector, A, B, Output);
				input wire Selector, A, B;
				output Output;
				
				Output = (Selector ? A : B);

endmodule
