`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 11:30:48
// Design Name: 
// Module Name: adder_gen
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
// ///
//////////////////////////////////////////////////////////////////////////////////


module adder_gen(
    input clk,
//    input [15:0] A,
//    input [15:0] B,
//    input [16:0]C,
//    input signed  [15:0] A1,
//    input signed [15:0] B1,
//    input ADD,
    input rst_n,
    output reg[31:0]P,
    output  [31:0]P_
    );
    reg [3:0] A;
    wire [31:0]a,b,c;
    reg  [31:0]a_i,b_i,c_i;
    reg add;
    wire [7:0]cccc[0:2];
    wire [31:0]p;
  always @(posedge clk)
    A = A+1;
//    always @(posedge clk)
 //   {a,b,c} <= {A,B,C};
//    c_addsub_0 your_instance_name (
//  .A(a),        // input wire [15 : 0] A
//  .B(b),        // input wire [15 : 0] B
////  .ADD(add),    // input wire ADD
//  .S(P)        // output wire [15 : 0] S
//);

//    prefix_adder prefix_adder_u(
//    .in_a(a),
//    .in_b(b),
//    .out(P_)
//    );

//assign P = A&B;

//mult_gen_0 mul_u (
//  .A(A),  // input wire [13 : 0] A
//  .B(B),  // input wire [13 : 0] B
//  .P(P)  // output wire [13 : 0] P
//);

//blk_mem_gen_0 your_instance_name (
//  .clka(clk),    // input wire clka
//  .addra(B),  // input wire [9 : 0] addra
//  .dina(A),    // input wire [31 : 0] dina
//  .clkb(clk),    // input wire clkb
//  .addrb(B),  // input wire [9 : 0] addrb
//  .doutb(A)  // output wire [31 : 0] doutb
//);
//LUT6_2 #(
//.INIT(64'h0000000000000000) // Specify LUT Contents
//) LUT6_2_inst (
//.O6(P[6]), // 1-bit LUT6 output
//.O5(P[3]), // 1-bit lower LUT5 output
//.I0(A[2]), // 1-bit LUT input
//.I1(A[3]), // 1-bit LUT input
//.I2(A[4]), // 1-bit LUT input
//.I3(A[5]), // 1-bit LUT input
//.I4(A[6]), // 1-bit LUT input
//.I5(A[1]) // 1-bit LUT input (fast MUX select only available to O6 output)
//);
//assign P = A1+B1;
//assign cccc[0] = A1^B1;
//assign cccc[1]=A1&B1;
//assign P_ = cccc[0][1:2]+cccc[1][5:6];

//dist_mem_gen_0 your_instance_name (
//  .a(1),        // input wire [4 : 0] a
//  .d(A),        // input wire [31 : 0] d
//  .dpra(1),  // input wire [4 : 0] dpra
//  .clk(clk),    // input wire clk
//  .we(1),      // input wire we
//  .dpo(P)    // output wire [31 : 0] dpo
//);
//xor u1(P[0],A[0],B[0]);
//xor u2(P[2],A[2],B[2]);



//mul_comp mu_u(
//            .a(a_i[15:0]),
//            .b(b_i[15:0]),
//            .c(c_i[16:0]),
//            .o(p)
//            );
            
//    mult_gen_1 your_instance_name (
//  .A(a_i[15:0]),  // input wire [15 : 0] A
//  .B(b_i[15:0]),  // input wire [15 : 0] B
//  .P(p)  // output wire [31 : 0] P
//);
            
            
            
//            blk_mem_gen_0 unstance_name (
//                  .clka(clk),    // input wire clka
//                  .wea(1),      // input wire [0 : 0] wea
//                  .addra(a),  // input wire [9 : 0] addra
//                  .dina(p),    // input wire [16 : 0] dina
//                  .clkb(clk),    // input wire clkb
//                  .enb(0),      // input wire enb
//                  .addrb(b),  // input wire [9 : 0] addrb
//                  .doutb(P)  // output wire [16 : 0] doutb
//);    
always @ (posedge clk)    
begin 
    a_i <= a;
    b_i <= b;
    c_i <= c;
    P <= p;   
 end
blk_mem_gen_1 your_itance_name (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .addra(A),  // input wire [3 : 0] addra
  .douta(a),  // output wire [16 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(1),      // input wire enb
  .addrb(A),  // input wire [3 : 0] addrb
  .doutb(b)  // output wire [16 : 0] doutb
);
blk_mem_gen_1 your_itce_name (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .addra(A),  // input wire [3 : 0] addra
  .douta(c)  // output wire [16 : 0] douta
);

mul_top mul_top_u (
    .clk(clk),
    .rst_n(rst_n),
    .a_i(a_i),
    .b_i(b_i),
    .c_i(c_i),
    .o(p)
);

endmodule

