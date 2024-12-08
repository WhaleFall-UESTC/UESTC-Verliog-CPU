`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:11 11/30/2024 
// Design Name: 
// Module Name:    MUX5_2_1 
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
module MUX5_2_1(
    input wire [4:0] X1, // 5
    input wire [4:0] X0, // 5
    input wire S,        // 
    output wire [4:0] Y  // 5
);

    assign Y = S ? X1 : X0;

endmodule