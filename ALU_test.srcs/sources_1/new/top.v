`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 15:22:08
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
    input clk,
    input e,
    input f,
    input g,
    output reg c
    );
    wire [32:0] a,b,p;
    wire [32:0] p_;
    wire add;
    reg h[1:0],i,k;
    reg temp;
    always @(*)
    begin
    if (f)
    begin
        temp = g+e;
        end
        else
        begin
         temp =h[1];
         end
    end    
    always @ (posedge clk)
        c <= h[1];
//    adder_gen u (
//    clk,a,b,1,p,p_
//    );
    
//    vio_0 your_instance_name (
//  .clk(clk),                // input wire clk
//  .probe_in0(p),    // input wire [31 : 0] probe_in0
//  .probe_in1(p_),    // input wire [31 : 0] probe_in1
//  .probe_out0(a),  // output wire [32 : 0] probe_out0
//  .probe_out1(b)  // output wire [31 : 0] probe_out1
//);
    
    
endmodule
