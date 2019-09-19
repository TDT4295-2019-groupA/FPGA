`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 12:03:01 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input wire CLK,
    output reg [3:0] led,
    input wire [3:0] sw
    );

    always @ (posedge CLK)
    begin
        if(sw[0] == 0)
        begin
            led[0] <= 1'b0;
        end
        else
        begin
            led[0] <= 1'b1;
        end
    end
endmodule