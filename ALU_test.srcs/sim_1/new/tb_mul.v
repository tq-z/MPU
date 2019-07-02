//~ `New testbench
`timescale  1ns / 1ps

module tb_mul;

// mul_comp Parameters
parameter PERIOD  = 10;


// mul_comp Inputs
reg  signed [15:0]  a                            = 0 ;
reg  signed [15:0]  b                            = 0 ;
reg  signed [16:0]  c                            = 0 ;
reg   [31:0] EN = 0;
reg    EN2 = 0;
reg   EN3 = 0;
// mul_comp Outputs
wire  [16:0]  o                            ;
wire  [32:0]  o_33;


mul_comp  u_mul_comp (
    .a                       ( a  [15:0] ),
    .b                       ( b  [15:0] ),
    .c                       ( c  [16:0] ),

    .o                       ( o  [16:0] ),
    .o_33(o_33[32:0])
);

initial
begin
    #1
    a = 16'b1001_1011_1001_0010;
    b = 'b1011_0110_0000_1001;
    c = 0;
    #100
    repeat(100000000)
    begin
    #1
    a = $random;
    b = $random;
    c = {$random,$random};
    end
    $finish;
end
always @(*)
begin
    EN = ((a*b)+(c<<15));
    EN2 = EN>>15 != o ;
    EN3 = EN != o_33[31:0];
end
endmodule