`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/02 11:11:49
// Design Name: 
// Module Name: tb_mul_top
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
module tb_mul_top;

// mul_top Parameters
parameter PERIOD  = 10;
parameter N = 100000;


// mul_top Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [31:0]  a_i                          = 0 ;
reg   [31:0]  b_i                          = 0 ;
reg   [31:0]  c_i                          = 0 ;

// mul_top Outputs
wire  [31:0]  o                            ;

// test var
reg  signed [15:0]  ah                          = 0 ;
reg  signed  [15:0]  bh                          = 0 ;
reg signed [15:0]al=0;
reg signed [15:0]bl=0;
reg signed [31:0]c=0;
reg signed  [31:0]  res                        = 0 ;

reg           flag                       = 0 ;
reg [31:0] times = 0;
initial
begin
    forever #(PERIOD/2)  
    begin
    clk=~clk;
    times = times+1;
    end
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

mul_top  u_mul_top (
    .clk                     ( clk           ),
    .rst_n                   ( rst_n         ),
    .a_i                     ( a_i    [31:0] ),
    .b_i                     ( b_i    [31:0] ),
    .c_i                     ( c_i    [31:0] ),

    .o                       ( o      [31:0] )
);

initial
begin
    repeat(N)
    begin
    #10
    a_i = $random;
    b_i = $random;
    c_i = $random;
//    a_i = times;
//    b_i = times+1;
//    c_i = times/2;

    end
    $finish;
end

initial
begin
#6
    repeat(N)
    begin
    #9
    res = al*bl+ah*bh+c;
    # 1
    flag = res==o ? 1 : 0;
    end
    $finish;
end
always @(*)
begin
    ah = a_i[31:16];
    al = a_i[15:0];
    bh = b_i[31:16];
    bl = b_i[15:0];
    c = c_i;
end
endmodule
