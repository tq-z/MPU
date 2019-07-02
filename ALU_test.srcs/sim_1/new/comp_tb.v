`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/30 17:42:44
// Design Name: 
// Module Name: comp_tb
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


module comp_tb;
reg   [31:0]  a                            = 0 ;
reg   [31:0]  b                            = 0 ;
reg    [31:0]  c                            = 0 ;
reg  [31:0]right = 0;
reg flag = 1;
wire [31:0]o ;
       wire[6:0]oo;
        wire [4:0]xoro;
        wire [4:0]co;

//compare compare_u(a,b,o);
test_2 test_2_u(.a(a),.b(b),.o(o),.c(c));
initial
begin
repeat (20000)
begin
#1
    {a,b,c} = {$random,$random,$random};
    right = a+b+c;
    #0.1
    flag = (right==o)?1:0;
    end
end
endmodule
