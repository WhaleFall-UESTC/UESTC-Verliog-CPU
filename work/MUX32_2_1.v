`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:11 11/30/2024 
// Design Name: 
// Module Name:    MUX32_2_1 
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
module MUX32_2_1(
    input wire [31:0] X1, // 32
    input wire [31:0] X0, // 32
    input wire S,         // 
    output wire [31:0] Y  // 32
);

    assign Y = S ? X1 : X0;

endmodule