`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/30 17:13:31
// Design Name: TQ
// Module Name: compare
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

module compare_top(
    input clk,
    input rst_n,
    input [31:0]a_in,
    input [31:0]b_in,
    output reg agtb_h_o,
    output reg agtb_l_o    
);
wire [1:0]agtb;
compare compare_u_h(
    .a_in(a_in[31:16]),
    .b_in(b_in[31:16]),
    .o(agtb[1])
);
compare compare_u_l(
    .a_in(a_in[15:0]),
    .b_in(b_in[15:0]),
    .o(agtb[0])
);
always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
      begin
        {agtb_h_o,agtb_l_o} <= 0;
      end
    else
      begin
         {agtb_h_o,agtb_l_o} <= agtb;
      end
  end
endmodule // compare_top