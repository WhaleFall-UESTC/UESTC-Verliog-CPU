`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:25 11/23/2024 
// Design Name: 
// Module Name:    mux4to1 
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
module mux4to1(
    input [1:0] Selector,
    input [31:0] R0, R1, R2, R3,
    output reg [31:0] Result // reg
);

    always @(*) begin // always
        case (Selector)
            2'b00: Result = R0;
            2'b01: Result = R1;
            2'b10: Result = R2;
            2'b11: Result = R3;
            default: Result = 32'b0; // Selector00, 01, 10, 11
        endcase
    end

endmodule
