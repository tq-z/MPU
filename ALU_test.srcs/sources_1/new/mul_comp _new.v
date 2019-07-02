//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: TQ
//
// Create Date: 2019/04/26 17:00:58
// Design Name:
// Module Name: mul_comp
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// * 有符号数乘法取高17位加法运算
// * o = (a*b)>>15 + c;

// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// 		31	30	29	28	27	26	25	24	23	22	21	20	19	18	17	16	15	14	13	12	11	10	9	8	7	6	5	4	3	2	1	0
// l1														S'	-	-	S	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B
// l2														S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l3												1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l4										1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l5								1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l6						1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l7				1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	B	C
// l8		1	S'	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	D	C
// l9		X	X	X	X	X	X	X	X	X	X	X	X	X	X	X	X	X	E



//////////////////////////////////////////////////////////////////////////////////

module mul_comp(
         input [15:0]a,
         input [15:0]b,
         input [16:0]c,
         output [16:0]o,
         output [32:0]o_33

       );
////wire [19:0]l1, [19:1]l2, [21:3]l3, [23:5]l4, [25:7]l5, [27:9]l6, [29:11]l7, [31:13]l8, [31:14]l9;
wire [31:0]prod_l[1:9];//部分积
wire [9:1]s1[0:31];
wire [9:1]s1_temp[0:31];
wire [7:1]s2[0:31];//部分积
wire [6:1]s3[0:32];//部分积
wire [2:1]s4[0:32];//部分积
wire [32:0]xoro;
wire [32:0]carryo;
//wire [32:0]o_33;

genvar i,j;

// * 生成
assign {prod_l[3][21],prod_l[4][23],prod_l[5][25],prod_l[6][27],prod_l[7][29],prod_l[8][31]} = 6'b11_1111; // 最高位置1
assign prod_l[1][18:17] = {prod_l[1][16],prod_l[1][16]}; // 生成第一行的SS
assign prod_l[9][31:15] = c;

//* 调转
generate
  for (i = 1; i <= 9; i = i+1)
  begin
    for (j = 0; j <= 31; j = j+1)
    begin
      assign s1_temp[j][i] = prod_l[i][j];
    end
  end

  for (j = 0; j <= 19; j = j+1)
  begin
    assign s1[j][9:1] = s1_temp[j][9:1];
  end
  assign s1[20][7:1] = s1_temp[20][9:3];
  assign s1[21][7:1] = s1_temp[21][9:3];
  assign s1[22][6:1] = s1_temp[22][9:4];
  assign s1[23][6:1] = s1_temp[23][9:4];
  assign s1[24][5:1] = s1_temp[24][9:5];
  assign s1[25][5:1] = s1_temp[25][9:5];
  assign s1[26][4:1] = s1_temp[26][9:6];
  assign s1[27][4:1] = s1_temp[27][9:6];
  assign s1[28][3:1] = s1_temp[28][9:7];
  assign s1[29][3:1] = s1_temp[29][9:7];
  assign s1[30][2:1] = s1_temp[30][9:8];
  assign s1[31][2:1] = s1_temp[31][9:8];
endgenerate

// * 部分积
generate
  // * 生成Abox
  for (j = 1; j<9; j = j+1)
    begin
      for (i = 1; i < 16; i = i+1)
        begin
          A_box A_box_u_prod_l(
                  .b_i((j==1) ? {b[1:0],1'b0} : b[2*j-1:2*j-3]),
                  .a_i(a[i:i-1]),
                  .o(prod_l[j][i + (j-1)*2]) // 第8行从15开始
                );
        end
      if (j < 8)
        begin
          BC_box BC_box_u_prod_l_md(
                   .b_i((j==1) ? {b[1:0],1'b0} : b[2*j-1:2*j-3]),
                   .a_i(a[0]),
                   .b_box_o(prod_l[j][(j-1)*2]),
                   .c_box_o(prod_l[j+1][j*2-1])
                 );
        end
      else
        begin
          DE_box DE_box_u_prod_l_end(
                   .b_i(b[2*j-1:2*j-3]),
                   .a_i(a[0]),
                   .d_box_o(prod_l[8][14]),
                   .e_box_o(prod_l[9][14])
                 );
        end
      if (j<=2)
        begin
          SnS_box SnS_box_u_prod_l(
                    .b_i((j==1) ? {b[1:0],1'b0} : b[2*j-1:2*j-3]),
                    .a_i(a[15]),
                    .s_box_o(prod_l[j][(j==1) ? 16 : 18]),
                    .ns_box_o(prod_l[j][19])
                  );
        end
      else
        begin
          SnS_box SnS_box_u_prod_l(
                    .b_i(b[2*j-1:2*j-3]),
                    .a_i(a[15]),
                    .ns_box_o(prod_l[j][j*2+14])
                  );
        end
    end
endgenerate

// * 压缩
generate 
//  state1 -> state2
 // 0 ~ 2
  assign s2[0][1] = s1[0][1];
  assign s2[1][2:1] = s1[1][2:1];
  assign s2[2][2:1] = s1[2][2:1];
 // 3 ~ 8
  for (i=3; i<=8; i=i+1)
    begin
      comp32 comp32_u_s1_3_8(
        .a_i(s1[i][3:1]),
        .o({s2[i][1],s2[i+1][2]})
      );
    end
  assign s2[5][3] = s1[5][4];
  assign s2[6][3] = s1[6][4];
  comp233 comp233_u_s1_7(
          .a1_i(s1[8][5:4]),
          .a0_i({s1[7][5:4],1'b0}),
          .o({s2[7][3],s2[8][3],s2[9][3]})
  );
 // 9
  comp63 comp63_u_s1_9(
         .a_i(s1[9][6:1]),
         .o({s2[9][1],s2[10][3],s2[11][2]})
  );
 // 10
  comp32 comp32_u_s1_10(
         .a_i(s1[10][3:1]),
         .o({s2[10][1],s2[11][3]})
  );
  comp32 comp32_u_s1_10_2(
         .a_i(s1[10][6:4]),
         .o({s2[10][2],s2[11][4]})
  );
 // 11
  comp63 comp63_u_s1_11(
         .a_i(s1[11][6:1]),
         .o({s2[11][1],s2[12][4],s2[13][2]})
  );
  assign s2[11][5] = s1[11][7];
 // 12
  comp32 comp32_u_s1_12(
         .a_i(s1[12][3:1]),
         .o({s2[12][1],s2[13][3]})
  );
  comp32 comp32_u_s1_12_2(
         .a_i(s1[12][6:4]),
         .o({s2[12][2],s2[13][4]})
  );
  assign s2[12][3] = s1[12][7];
 // 13
  comp63 comp63_u_s1_13(
         .a_i(s1[13][6:1]),
         .o({s2[13][1],s2[14][3],s2[15][4]})
  );
  assign s2[13][5] = s1[13][7];
  assign s2[13][6] = s1[13][8];
 // 14
  comp32 comp32_u_s1_14(
         .a_i(s1[14][3:1]),
         .o({s2[14][1],s2[15][5]})
  );
  comp63 comp63_u_s1_14(
         .a_i(s1[14][9:4]),
         .o({s2[14][2],s2[15][6],s2[16][4]})
  ); 
 // 15
  comp32 comp32_u_s1_15_1(
         .a_i(s1[15][3:1]),
         .o({s2[15][1],s2[16][5]})
  );
  comp32 comp32_u_s1_15_2(
         .a_i(s1[15][6:4]),
         .o({s2[15][2],s2[16][6]})
  );
  comp32 comp32_u_s1_15_3(
         .a_i(s1[15][9:7]),
         .o({s2[15][3],s2[16][7]})
  );
 // 16
  comp233 comp233_u_s1_16(
          .a0_i(s1[16][3:1]),
          .a1_i(s1[17][5:4]),
          .o({s2[16][1],s2[17][2],s2[18][3]})
  );  
  comp233 comp233_u_s1_16_2(
          .a0_i(s1[16][6:4]),
          .a1_i(s1[17][7:6]),
          .o({s2[16][2],s2[17][3],s2[18][4]})
  );
  comp233 comp233_u_s1_16_3(
          .a0_i(s1[16][9:7]),
          .a1_i(s1[17][9:8]),
          .o({s2[16][3],s2[17][4],s2[18][5]})
  );
 // 17
  comp32 comp32_u_s1_17(
         .a_i(s1[17][3:1]),
         .o({s2[17][1],s2[18][6]})
  );
 // 18
  comp32 comp32_u_s1_18(
         .a_i(s1[18][3:1]),
         .o({s2[18][1],s2[19][3]})
  );
  comp63 comp63_u_s1_18(
         .a_i(s1[18][9:4]),
         .o({s2[18][2],s2[19][4],s2[20][3]})
  ); 
 // 19
  comp32 comp32_u_s1_19(
         .a_i(s1[19][3:1]),
         .o({s2[19][1],s2[20][4]})
  );
  comp63 comp63_u_s1_19(
         .a_i(s1[19][9:4]),
         .o({s2[19][2],s2[20][5],s2[21][4]})
  ); 
 // 20
  comp63 comp63_u_s1_20(
         .a_i(s1[20][6:1]),
         .o({s2[20][1],s2[21][5],s2[22][3]})
  ); 
  assign s2[20][2] = s1[20][7];
 // 21
  comp32 comp32_u_s1_21(
         .a_i(s1[21][3:1]),
         .o({s2[21][1],s2[22][4]})
  );
  comp32 comp32_u_s1_21_2(
         .a_i(s1[21][6:4]),
         .o({s2[21][2],s2[22][5]})
  );
  assign s2[21][3] = s1[21][7];
 // 22
  comp32 comp32_u_s1_22(
         .a_i(s1[22][3:1]),
         .o({s2[22][1],s2[23][2]})
  );
  comp32 comp32_u_s1_22_2(
         .a_i(s1[22][6:4]),
         .o({s2[22][2],s2[23][3]})
  );
 // 23
  comp63 comp63_u_s1_23(
         .a_i(s1[23][6:1]),
         .o({s2[23][1],s2[24][4],s2[25][6]})
  ); 
 // 24
  comp32 comp32_u_s1_24(
         .a_i(s1[24][3:1]),
         .o({s2[24][1],s2[25][7]})
  );
  assign s2[24][3:2] = s1[24][5:4];
 // 25
  assign s2[25][5:1] = s1[25][5:1];
 // 26
  comp32 comp32_u_s1_26(
         .a_i(s1[26][3:1]),
         .o({s2[26][1],s2[27][5]})
  );
  assign s2[26][2] = s1[26][4];
 // 27
  assign s2[27][4:1] = s1[27][4:1];
 // 28
  comp32 comp32_u_s1_28(
         .a_i(s1[28][3:1]),
         .o({s2[28][1],s2[29][2]})
  );
 // 29
  comp233 comp233_u_s1_29(
          .a0_i(s1[29][3:1]),
          .a1_i(s1[30][2:1]),
          .o({s2[29][1],s2[30][1],s2[31][3]})
  );
 // 30
 // 31
  assign s2[31][2:1] = s1[31][2:1];
//  state2 -> state3
 // 0 ~ 4
  assign s3[0][1]   = s2[0][1];
  assign s3[1][2:1] = s2[1][2:1];
  assign s3[2][2:1] = s2[2][2:1];
  assign s3[3][1]   = s2[3][1];
  assign s3[4][2:1] = s2[4][2:1];
 // 5 ~ 15
  for (i=5; i<16; i=i+1)
    begin
        comp32 comp32_u_s2_5_15(
               .a_i(s2[i][3:1]),
               .o({s3[i][1],s3[i+1][2]})
        );
    end
  assign s3[11][4:3] = s2[11][5:4];
  assign s3[12][3]   = s2[12][4];
  comp32 comp32_u_s2_13_2(
         .a_i(s2[13][6:4]),
         .o({s3[13][3],s3[14][3]})
  ); 
  comp233 comp233_u_s2_15(
         .a0_i(s2[15][6:4]),
         .a1_i(s2[16][7:6]),
         .o({s3[15][3],s3[16][3],s3[17][2]})
  );
 // 16
  comp153 comp153_u_s2_16(
          .a0_i(s2[16][5:1]),
          .a1_i(s2[17][4]),
          .o({s3[16][1],s3[17][3],s3[18][2]})
  );
 // 17
  comp32 comp32_u_s2_17(
         .a_i(s2[17][3:1]),
         .o({s3[17][1],s3[18][3]})
  ); 
 // 18
  comp63 comp63_u_s2_18(
         .a_i(s2[18][6:1]),
         .o({s3[18][1],s3[19][3],s3[20][2]})
  ); 
 // 19
  comp233 comp233_u_s2_19(
         .a0_i(s2[19][3:1]),
         .a1_i(s2[20][2:1]),
         .o({s3[19][1],s3[20][3],s3[21][2]})
  );
  assign s3[19][2] = s2[19][4];
 // 20
  comp233 comp233_u_s2_20(
         .a0_i(s2[20][5:3]),
         .a1_i(s2[21][2:1]),
         .o({s3[20][1],s3[21][3],s3[22][2]})
  ); 
 // 21
  comp233 comp233_u_s2_21(
         .a0_i(s2[21][5:3]),
         .a1_i(s2[22][5:4]),
         .o({s3[21][1],s3[22][3],s3[23][3]})
  ); 
 // 22 ~ 24
  for(i=22; i<=24; i = i+1)
    begin
        comp32 comp32_u_s2_22_24(
              .a_i(s2[i][3:1]),
              .o({s3[i][1],s3[i+1][2]})
        );
    end
  assign s3[24][3] = s2[24][4];
 // 25
  comp63 comp63_u_s2_25(
         .a_i(s2[25][6:1]),
         .o({s3[25][1],s3[26][3],s3[27][6]})
  );  
  assign s3[25][3] = s2[25][7];
 // 26 ~ 32
  assign s3[26][2:1] = s2[26][2:1];
  assign s3[27][5:1] = s2[27][5:1];
  assign s3[28][1]   = s2[28][1];
  assign s3[29][2:1] = s2[29][2:1];
  assign s3[30][1]   = s2[30][1];
  comp32 comp32_u_s2_31(
        .a_i(s2[31][3:1]),
        .o({s3[31][1],s3[32][1]})
  );  
//  state3 -> state4
 // 0 ~ 10
  for(i=0; i<=10; i=i+1)
    begin
      case (i)
        0,3,5: begin assign s4[i][1] = s3[i][1]; end
        default: begin assign s4[i][2:1] = s3[i][2:1]; end
      endcase
    end
 // 11 ~ 26
  for (i=11; i<=26; i=i+1)
  begin
      comp32 comp32_u_s3_11_26(
              .a_i(s3[i][3:1]),
              .o({s4[i][1],s4[i+1][2]})
      );
  end
  assign s4[11][2] = s3[11][4];
 // 27
  comp63 comp63_u_s3_27(
         .a_i(s3[27][6:1]),
         .o({s4[27][1],s4[28][2],s4[29][2]})
  ); 
 // 28 ~ 32
  assign s4[28][1] = s3[28][1];
  comp32 comp32_u_s3_29(
        .a_i({s3[29][2:1],1'b0}),
        .o({s4[29][1],s4[30][2]})
  );
  assign s4[30][1] = s3[30][1];
  assign s4[31][1] = s3[31][1];
  assign s4[32][1] = s3[32][1];

endgenerate

// * 合并
generate
// 舍弃0位
  xor2 xor2_u_1_2(
       .a1(s4[1][2:1]),
       .a2(s4[2][2:1]),
       .o1(xoro[1]),
       .o2(xoro[2])
  );
  assign xoro[3] = s4[3][1];
  assign xoro[5] = s4[5][1];
  xor2 xor2_u_46(
       .a1(s4[4][2:1]),
       .a2(s4[6][2:1]),
       .o1(xoro[4]),
       .o2(xoro[6])
  );
  for(i=4; i<=15; i=i+1)
    begin
        xor2 xor2_u_1_2(
             .a1(s4[i*2-1][2:1]),
             .a2(s4[i*2][2:1]),
             .o1(xoro[i*2-1]),
             .o2(xoro[i*2])
       );
    end
  assign xoro[31] = s4[31][1];
  assign xoro[32] = s4[32][1];
  // carry
  for(i=1; i<9; i = i+1)
  begin
    CARRY4 CARRY4_inst (
      .CO(carryo[i*4:i*4-3]), // 4-bit carry out
      .O(o_33[i*4:i*4-3]), // 4-bit carry chain XOR data out
      .CI((i==1) ? 0 : carryo[(i-1)*4]), // 1-bit carry cascade input
      .CYINIT(0), // 1-bit carry initialization
      .DI({s4[i*4][1], s4[i*4-1][1], s4[i*4-2][1],s4[i*4-3][1]}), // 4-bit carry-MUX data in
      .S(xoro[i*4:i*4-3]) // 4-bit carry-MUX select input
    );
  end
endgenerate

assign o = o_33[31:15];
assign o_33[0] = s4[0][1];
endmodule// mul_comp





module A_box(
          input [2:0]b_i,
          input [1:0]a_i,
          output wire o
        );
  LUT5 #(
        .INIT(32'h0E16_6870) // Specify LUT Contents
      ) LUT5_A_box (
        .O(o), // LUT general output
        .I0(b_i[0]), // LUT input
        .I1(b_i[1]), // LUT input
        .I2(b_i[2]), // LUT input
        .I3(a_i[0]), // LUT input
        .I4(a_i[1]) // LUT input
      );
endmodule // Abox

module BC_box(
         input [2:0]b_i,
         input a_i,
         output wire b_box_o,
         output wire c_box_o
       );
  LUT6_2 #(
            .INIT(64'h0000_1070_0000_6600)
         // .INIT(64'h0066_0000_0E08_0000) // Specify LUT Contents
        ) LUT6_2_BC_box (
          .O6(c_box_o), // 1-bit Cbox @ LUT6 output
          .O5(b_box_o), // 1-bit Bbox @ LUT5 output
          .I0(b_i[0]), // LUT input
          .I1(b_i[1]), // LUT input
          .I2(b_i[2]), // LUT input
          .I3(a_i), // LUT input
          .I4(0), // LUT input
          .I5(1) // LUT input control mux
        );
endmodule //BC_box

module DE_box(
         input [2:0]b_i,
         input a_i,
         output wire d_box_o,
         output wire e_box_o
       );
  LUT6_2 #(
             .INIT(64'h0000_7070_0000_1670) // Specify LUT Contents
          // .INIT(64'h0E68_0000_0E0E_0000) // Specify LUT Contents
        ) LUT6_2_DE_box (
          .O6(e_box_o), // 1-bit Ebox @ LUT6 output
          .O5(d_box_o), // 1-bit Dbox @ LUT5 output
          .I0(b_i[0]), // LUT input
          .I1(b_i[1]), // LUT input
          .I2(b_i[2]), // LUT input
          .I3(a_i), // LUT input
          .I4(0), // LUT input
          .I5(1) // LUT input control mux
        );
endmodule //DE_box

module SnS_box(
         input [2:0]b_i,
         input a_i,
         output wire s_box_o,
         output wire ns_box_o
       );
  LUT6_2 #(
             .INIT('h0000_F18F_0000_0E70) // Specify LUT Contents
          // .INIT('h0E70_0000_F18F_0000) // Specify LUT Contents
        ) LUT6_2_SnS_box (
          .O6(ns_box_o), // 1-bit nSbox @ LUT6 output
          .O5(s_box_o), // 1-bit Sbox @ LUT5 output
          .I0(b_i[0]), // LUT input
          .I1(b_i[1]), // LUT input
          .I2(b_i[2]), // LUT input
          .I3(a_i), // LUT input
          .I4(0), // LUT input
          .I5(1) // LUT input control mux
        );
endmodule //  SnS_box


module comp32(
         input [2:0]a_i,
         output wire [1:0]o
       );
  LUT6_2 #(
             .INIT('h0000_00E8_0000_0096) // Specify LUT Contents
          // .INIT('h6900_0000_1700_0000) // Specify LUT Contents
        ) LUT6_2_comp32_box (
          .O6(o[0]), // 1-bit o1 @ LUT6 output
          .O5(o[1]), // 1-bit o0 @ LUT5 output
          .I0(a_i[0]), // LUT input
          .I1(a_i[1]), // LUT input
          .I2(a_i[2]), // LUT input
          .I3(0), // LUT input
          .I4(0), // LUT input
          .I5(1) // LUT input control mux
        );
endmodule

module comp63(
         input [5:0]a_i,
         output wire [2:0]o
       );
  LUT6 #(//第i位
        .INIT('h6996_9669_9669_6996) // Specify LUT Contents
      ) LUT6_comp63_0_box (
        .O(o[2]), // 1-bit o0 @ LUT6 output
        .I0(a_i[0]), // LUT input
        .I1(a_i[1]), // LUT input
        .I2(a_i[2]), // LUT input
        .I3(a_i[3]), // LUT input
        .I4(a_i[4]), // LUT input
        .I5(a_i[5]) // LUT input 
      );
  LUT6 #(//第i+1位
        .INIT('h8117_177E_177E_7EE8) // Specify LUT Contents
        // .INIT('h177E_7EE8_7EE8_E881) // Specify LUT Contents
      ) LUT6_comp63_1_box (
        .O(o[1]), // 1-bit o1 @ LUT6 output
        .I0(a_i[0]), // LUT input
        .I1(a_i[1]), // LUT input
        .I2(a_i[2]), // LUT input
        .I3(a_i[3]), // LUT input
        .I4(a_i[4]), // LUT input
        .I5(a_i[5]) // LUT input 
      );
  LUT6 #(//第i+2位
        .INIT('hFEE8_E880_E880_8000) // Specify LUT Contents
        // .INIT('h0001_0117_0117_177F) // Specify LUT Contents
      ) LUT6_comp63_2_box (
        .O(o[0]), // 1-bit o2 @ LUT6 output
        .I0(a_i[0]), // LUT input
        .I1(a_i[1]), // LUT input
        .I2(a_i[2]), // LUT input
        .I3(a_i[3]), // LUT input
        .I4(a_i[4]), // LUT input
        .I5(a_i[5]) // LUT input 
      );
endmodule

module comp153(
         input a1_i,
         input [4:0]a0_i,
         output wire [2:0]o
       );
  LUT6 #(// 第i位
        .INIT('h9669_6996_9669_6996) // Specify LUT Contents
        // .INIT('h6996_9669_6996_9669) // Specify LUT Contents
      ) LUT6_comp153_0_box (
        .O(o[2]), // 1-bit o0 @ LUT6 output
        .I0(a0_i[0]), // LUT input
        .I1(a0_i[1]), // LUT input
        .I2(a0_i[2]), // LUT input
        .I3(a0_i[3]), // LUT input
        .I4(a0_i[4]), // LUT input
        .I5(a1_i) // LUT input 
      );
  LUT6 #(// 第i+1位
        .INIT('hE881_8117_177E_7EE8) // Specify LUT Contents
        // .INIT('h177E_7EE8_E881_8117) // Specify LUT Contents
      ) LUT6_comp153_1_box (
        .O(o[1]), // 1-bit o1 @ LUT6 output
        .I0(a0_i[0]), // LUT input
        .I1(a0_i[1]), // LUT input
        .I2(a0_i[2]), // LUT input
        .I3(a0_i[3]), // LUT input
        .I4(a0_i[4]), // LUT input
        .I5(a1_i) // LUT input 
      );
  LUT6 #(//第i+2位
        .INIT('hFFFE_FEE8_E880_8000) // Specify LUT Contents
        // .INIT('h0001_0117_177F_7FFF) // Specify LUT Contents
      ) LUT6_comp153_2_box (
        .O(o[0]), // 1-bit o2 @ LUT6 output
        .I0(a0_i[0]), // LUT input
        .I1(a0_i[1]), // LUT input
        .I2(a0_i[2]), // LUT input
        .I3(a0_i[3]), // LUT input
        .I4(a0_i[4]), // LUT input
        .I5(a1_i) // LUT input 
      );
endmodule

module comp233(
         input [1:0]a1_i,
         input [2:0]a0_i,
         output wire [2:0]o
       );
  LUT6_2 #(//第i，i+1位
        .INIT('hE817_17E8_9696_9696) // Specify LUT Contents
        // .INIT('h6969_6969_17E8_E817) // Specify LUT Contents
      ) LUT6_2_comp233_0_1_box (
        .O6(o[1]), // 1-bit o1 @ LUT6 output
        .O5(o[2]), // 1-bit o0 @ LUT5 output
        .I0(a0_i[0]), // LUT input
        .I1(a0_i[1]), // LUT input
        .I2(a0_i[2]), // LUT input
        .I3(a1_i[0]), // LUT input
        .I4(a1_i[1]), // LUT input 
        .I5(1) // 1bit control mux
      );
  LUT5 #(//第i+2位
        .INIT('hFFE8_E800) // Specify LUT Contents
        // .INIT('h0017_17FF) // Specify LUT Contents
      ) LUT5_comp233_2_box (
        .O(o[0]), // 1-bit o2 @ LUT5 output
        .I0(a0_i[0]), // LUT input
        .I1(a0_i[1]), // LUT input
        .I2(a0_i[2]), // LUT input
        .I3(a1_i[0]), // LUT input
        .I4(a1_i[1]) // LUT input
      );
endmodule

module xor2(// o1 = ^a1[1:0], o2 = ^a2[1:0]
       input [1:0]a1,
       input [1:0]a2,
       output wire o1,
       output wire o2
      );
    LUT6_2 #(
          .INIT('h0000_0FF0_0000_6666) // Specify LUT Contents
          // .INIT('h6666_0000_0FF0_0000) // Specify LUT Contents
        ) LUT6_2_xor2_box (
          .O6(o2), // 1-bit o1 @ LUT6 output
          .O5(o1), // 1-bit o0 @ LUT5 output
          .I0(a1[0]), // LUT input
          .I1(a1[1]), // LUT input
          .I2(a2[0]), // LUT input
          .I3(a2[1]), // LUT input
          .I4(0), // LUT input 
          .I5(1) // 1bit control mux
        );
endmodule
