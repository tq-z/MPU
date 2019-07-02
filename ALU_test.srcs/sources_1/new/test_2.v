`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/01 08:28:15
// Design Name: 
// Module Name: test_2
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


module test_2(
        input a1,
        input a2,
        input a3,
        input a4,
        input a5,
        input a6,
        input b1,
        input b2,
        input b3,
        input b4,
        input b5,
        input b6,
        input [31:0]a,
        input [31:0]b,
        input [31:0]c,
//        input [31:0]d,
        output [31:0]o,
        output [6:0]oo,
        output [4:0]xoro,
        output [4:0]co
    );
    wire [31:0]s;
    wire [31:0]d;
    wire [31:0]carryo;
//   assign temp = a[0]+a[1]+a[2];
//   assign temp2 = temp[1]+a[3]+a[4];
//assign o = a+b+c;
genvar i;
for(i=0;i<32;i=i+1)
begin
assign d[i] = ^{a[i],b[i],c[i]};
assign s[i] = i==0 ? d[i] : d[i]^((a[i-1]&b[i-1])|(c[i-1]&(a[i-1]|b[i-1])));

end
for(i=1; i<9; i = i+1)
  begin
    CARRY4 CARRY4_inst (
      .CO(carryo[i*4-1:i*4-4]), // 4-bit carry out
      .O(o[i*4-1:i*4-4]), // 4-bit carry chain XOR data out
      .CI((i==1) ? 0 : carryo[(i-1)*4-1]), // 1-bit carry cascade input
      .CYINIT(0), // 1-bit carry initialization
      .DI(d[i*4-1:i*4-4]), // 4-bit carry-MUX data in
      .S(s[i*4-1:i*4-4]) // 4-bit carry-MUX select input
    );
  end

endmodule

//module comp(
//input [2:0]a0_i,
//input [2:0]a1_i,
//output xor6,
//output xor3
//);
//LUT6_2 #(//µÚi£¬i+1Î»
//        .INIT('hE817_17E8_9696_9696) // Specify LUT Contents
//        // .INIT('h6969_6969_17E8_E817) // Specify LUT Contents
//      ) LUT6_2_comp233_0_1_box (
//        .O6(o), // 1-bit o1 @ LUT6 output
//        .O5(o[2]), // 1-bit o0 @ LUT5 output
//        .I0(a0_i[0]), // LUT input
//        .I1(a0_i[1]), // LUT input
//        .I2(a0_i[2]), // LUT input
//        .I3(a1_i[0]), // LUT input
//        .I4(a1_i[1]), // LUT input 
//        .I5(1) // 1bit control mux
//      );
//endmodule 