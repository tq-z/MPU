`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/07/02 15:41:35
// Design Name:
// Module Name: regfile
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


module regfile(
         input clk,
         input rst_n,
         input [WIDTH_RF_ADDR-1:0] ra1_i [SUPERSCALAR_AMT-1:0],ra2_i [SUPERSCALAR_AMT-1:0], ra3_i [SUPERSCALAR_AMT-1:0],
         [SUPERSCALAR_AMT-1:0] wa5_i, [SUPERSCALAR_AMT-1:0] wa6_i,
         input  [31:0] wd5_i [SUPERSCALAR_AMT-1:0], wd6_i [SUPERSCALAR_AMT-1:0],
         input  [SUPERSCALAR_AMT-1:0]we5_i,[SUPERSCALAR_AMT-1:0]we6_i,
         output [31:0] rd1_o [SUPERSCALAR_AMT-1:0], rd2_o [SUPERSCALAR_AMT-1:0], rd3_o [SUPERSCALAR_AMT-1:0])
);

genvar i;

reg  [31:0] rf_w_d [1:8];
wire [31:0] rf_r_d [1:8];
reg  [2:0] rf_w_addr [1:8];
reg  [2:0] rf_r_addr [1:8];
reg  rf_we [1:8];

// addr Decoder
reg_addr_decoder reg_addr_decoder_u_r(
                  .addr_1_i(ra1_i),
                  .addr_2_i(ra2_i),
                  .addr_o(rf_r_addr)
                );
reg_addr_decoder reg_addr_decoder_u_w(
                  .addr_1_i(wa5_i),
                  .addr_2_i(wa6_i),
                  .we({we5_i,we6_i}),
                  .addr_o(rf_w_addr)
                  .we_o(rf_we [1:8])
                );
// output_mux
output_mux output_mux_u_rd1(
    .addr__i(ra1_i),
    .d1_i(rf_r_d[1]),
    .d2_i(rf_r_d[3]),
    .d3_i(rf_r_d[5]),
    .d_o(rd1_o)
  );


generate
  for(i=1;i<=8;i=i+1)
    begin
        if (i>=3&&i<=6)
            begin
                blk_mem_shared blk_mem_u_3456 (
                    //write
                    .clka(clk),    // input wire clka
                    .ena(1),      // input wire ena
                    .wea(rf_we[i]),      // input wire [0 : 0] wea
                    .addra(rf_w_addr[i]),  // input wire [1 : 0] addra
                    .dina(rf_w_d[i]),    // input wire [31 : 0] dina
                    // read
                    .clkb(clk),    // input wire clkb
                    .enb(1),      // input wire enb
                    .addrb(rf_r_addr[i]),  // input wire [1 : 0] addrb
                    .doutb(rf_r[i])  // output wire [31 : 0] doutb
                    );
            end
        else 
            begin
                blk_mem_only blk_mem_u_1278 (
                    //write
                  .clka(clk),    // input wire clka
                  .ena(1),      // input wire ena
                  .wea(rf_we[i]),      // input wire [0 : 0] wea
                  .addra(rf_w_addr[i]),  // input wire [2 : 0] addra
                  .dina(rf_w_d[i]),    // input wire [31 : 0] dina
                    // read
                  .clkb(clk),    // input wire clkb
                  .enb(1),      // input wire enb
                  .addrb(rf_r_addr[i]),  // input wire [2 : 0] addrb
                  .doutb(rf_r[i])  // output wire [31 : 0] doutb
                );
            end
        if (i<=4)
          begin
              blk_mem_c blk_mem_u_c (
                    //write
                  .clka(clk),    // input wire clka
                  .ena(1),      // input wire ena
                  .wea(we5_i[i-1]),      // input wire [0 : 0] wea
                  .addra(wd5_i[i-1]),  // input wire [2 : 0] addra
                  .dina(wd5_i[i-1]),    // input wire [31 : 0] dina
                    // read
                  .clkb(clk),    // input wire clkb
                  .enb(1),      // input wire enb
                  .addrb(rd3_i[i-1]),  // input wire [2 : 0] addrb
                  .doutb(rd3_o[i-1])  // output wire [31 : 0] doutb
                );
          end
    end
endgenerate

generate
  for(i=0;i<SUPERSCALAR_AMT;i=i+1)
    begin
      always @ (*)
        if(we)
          begin
            rf_w[wa5[i]] = wd5[i];
            rf_w[wa6[i]] = wd6[i];
          end
    end
endgenerate

generate
  for(i=0;i<SUPERSCALAR_AMT;i=i+1)
    begin
      assign rd1[i] = (ra1[i] != 0)? rf_r[ra1[i]] : 0;
      assign rd2[i] = (ra2[i] != 0)? rf_r[ra2[i]] : 0;
      assign rd3[i] = (ra3[i] != 0)? rf_r[ra3[i]] : 0;
    end
endgenerate
);
endmodule

module reg_addr_decoder(
    input [5:0]addr_1_i[3:0],
    input [5:0]addr_2_i[3:0],
    input [7:0]we,
    output reg [2:0]addr_o[1:8],
    output reg we_o[1:8]
  );
  always @(*)
  begin
      casex ({addr_1_i[0],addr_1_i[1]})
          {6'bx,6'd1},{6'd1,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 0};
          {6'bx,6'd4},{6'd4,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 1};
          {6'bx,6'd6},{6'd6,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 2};
          {6'bx,6'd7},{6'd7,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 3};
          {6'bx,6'd33},{6'd33,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 4};
          {6'bx,6'd36},{6'd36,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 5};
          {6'bx,6'd38},{6'd38,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 6};
          {6'bx,6'd39},{6'd39,6'bx}: {we_o[1] = we[1]|we[0], addr_o [1] = 7};
          default: {we_o[1] = we[1]|we[0], addr_o [1] = 3'bx};
      endcase
      casex ({addr_2_i[0],addr_2_i[1]})
          {6'bx,6'd2},{6'd2,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 0};
          {6'bx,6'd3},{6'd3,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 1};
          {6'bx,6'd5},{6'd5,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 2};
          {6'bx,6'd8},{6'd8,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 3};
          {6'bx,6'd34},{6'd34,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 4};
          {6'bx,6'd35},{6'd35,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 5};
          {6'bx,6'd37},{6'd37,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 6};
          {6'bx,6'd40},{6'd40,6'bx}: {we_o[2] = we[1]|we[0], addr_o [2] = 7};
          default: {we_o[2] = we[1]|we[0], addr_o [2] = 3'bx};
      endcase
      casex ({addr_1_i[2],addr_1_i[3]})
          {6'bx,6'd25},{6'd25,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 0};
          {6'bx,6'd28},{6'd28,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 1};
          {6'bx,6'd30},{6'd30,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 2};
          {6'bx,6'd31},{6'd31,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 3};
          {6'bx,6'd41},{6'd41,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 4};
          {6'bx,6'd44},{6'd44,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 5};
          {6'bx,6'd46},{6'd46,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 6};
          {6'bx,6'd47},{6'd47,6'bx}: {we_o[7] = we[2]|we[3], addr_o [7] = 7};
          default: {we_o[7] = we[2]|we[3], addr_o [7] = 3'bx};
      endcase
      casex ({addr_2_i[2],addr_2_i[3]})
          {6'bx,6'd26},{6'd26,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 0};
          {6'bx,6'd27},{6'd27,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 1};
          {6'bx,6'd29},{6'd29,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 2};
          {6'bx,6'd32},{6'd32,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 3};
          {6'bx,6'd42},{6'd42,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 4};
          {6'bx,6'd43},{6'd43,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 5};
          {6'bx,6'd45},{6'd45,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 6};
          {6'bx,6'd48},{6'd48,6'bx}: {we_o[8] = we[2]|we[3], addr_o [8] = 7};
          default: {we_o[8] = we[2]|we[3], addr_o [8] = 3'bx};
      endcase
      casex ({addr_1_i[0],addr_1_i[1],addr_1_i[2],addr_1_i[3]})
        {6'd10,6'bx,6'bx,6'bx},{6'bx,6'd10,6'bx,6'bx},{6'bx,6'bx,6'd10,6'bx},{6'bx,6'bx,6'bx,6'd10}: {we_o[3] = |we, addr_o[3] = 3'b0};
        {6'd11,6'bx,6'bx,6'bx},{6'bx,6'd11,6'bx,6'bx},{6'bx,6'bx,6'd11,6'bx},{6'bx,6'bx,6'bx,6'd11}: {we_o[3] = |we, addr_o[3] = 3'b1};
        {6'd13,6'bx,6'bx,6'bx},{6'bx,6'd13,6'bx,6'bx},{6'bx,6'bx,6'd13,6'bx},{6'bx,6'bx,6'bx,6'd13}: {we_o[3] = |we, addr_o[3] = 3'b2};
        {6'd16,6'bx,6'bx,6'bx},{6'bx,6'd16,6'bx,6'bx},{6'bx,6'bx,6'd16,6'bx},{6'bx,6'bx,6'bx,6'd16}: {we_o[3] = |we, addr_o[3] = 3'b3};
        default: {we_o[3] = |we, addr_o[3] = 3'bx}; 
      endcase
      casex ({addr_2_i[0],addr_2_i[1],addr_2_i[2],addr_2_i[3]})
        {6'd9,6'bx,6'bx,6'bx},{6'bx,6'd9,6'bx,6'bx},{6'bx,6'bx,6'd9,6'bx},{6'bx,6'bx,6'bx,6'd9}: {we_o[] = |we, addr_o[4] = 3'b0};
        {6'd12,6'bx,6'bx,6'bx},{6'bx,6'd12,6'bx,6'bx},{6'bx,6'bx,6'd12,6'bx},{6'bx,6'bx,6'bx,6'd12}: {we_o[] = |we, addr_o[4] = 3'b1};
        {6'd14,6'bx,6'bx,6'bx},{6'bx,6'd14,6'bx,6'bx},{6'bx,6'bx,6'd14,6'bx},{6'bx,6'bx,6'bx,6'd14}: {we_o[] = |we, addr_o[4] = 3'b2};
        {6'd15,6'bx,6'bx,6'bx},{6'bx,6'd15,6'bx,6'bx},{6'bx,6'bx,6'd15,6'bx},{6'bx,6'bx,6'bx,6'd15}: {we_o[] = |we, addr_o[4] = 3'b3};
        default: {we_o[] = |we, addr_o[4] = 3'bx}; 
      endcase
      casex ({addr_1_i[0],addr_1_i[1],addr_1_i[2],addr_1_i[3]})
        {6'd18,6'bx,6'bx,6'bx},{6'bx,6'd18,6'bx,6'bx},{6'bx,6'bx,6'd18,6'bx},{6'bx,6'bx,6'bx,6'd18}: {we_o[] = |we, addr_o[5] = 3'b0};
        {6'd19,6'bx,6'bx,6'bx},{6'bx,6'd19,6'bx,6'bx},{6'bx,6'bx,6'd19,6'bx},{6'bx,6'bx,6'bx,6'd19}: {we_o[] = |we, addr_o[5] = 3'b1};
        {6'd21,6'bx,6'bx,6'bx},{6'bx,6'd21,6'bx,6'bx},{6'bx,6'bx,6'd21,6'bx},{6'bx,6'bx,6'bx,6'd21}: {we_o[] = |we, addr_o[5] = 3'b2};
        {6'd24,6'bx,6'bx,6'bx},{6'bx,6'd24,6'bx,6'bx},{6'bx,6'bx,6'd24,6'bx},{6'bx,6'bx,6'bx,6'd24}: {we_o[] = |we, addr_o[5] = 3'b3};
        default: {we_o[] = |we, addr_o[5] = 3'bx}; 
      endcase
      casex ({addr_2_i[0],addr_2_i[1],addr_2_i[2],addr_2_i[3]})
        {6'd17,6'bx,6'bx,6'bx},{6'bx,6'd17,6'bx,6'bx},{6'bx,6'bx,6'd17,6'bx},{6'bx,6'bx,6'bx,6'd17}: {we_o[] = |we, addr_o[6] = 3'b0};
        {6'd20,6'bx,6'bx,6'bx},{6'bx,6'd20,6'bx,6'bx},{6'bx,6'bx,6'd20,6'bx},{6'bx,6'bx,6'bx,6'd20}: {we_o[] = |we, addr_o[6] = 3'b1};
        {6'd22,6'bx,6'bx,6'bx},{6'bx,6'd22,6'bx,6'bx},{6'bx,6'bx,6'd22,6'bx},{6'bx,6'bx,6'bx,6'd22}: {we_o[] = |we, addr_o[6] = 3'b2};
        {6'd23,6'bx,6'bx,6'bx},{6'bx,6'd23,6'bx,6'bx},{6'bx,6'bx,6'd23,6'bx},{6'bx,6'bx,6'bx,6'd23}: {we_o[] = |we, addr_o[6] = 3'b3};
        default: {we_o[] = |we, addr_o[6] = 3'bx}; 
      endcase    
  end
endmodule // reg_decoder

module output_mux(
    input [5:0]addr__i[3:0],
    input [31:0]d1_i,
    input [31:0]d2_i,
    input [31:0]d3_i,
    output reg [31:0]d_o[3:0]
  );
  generate
    for(i=1;i<=4;i=i+1)
      begin
        if(i<=2)
          begin
            case (addr__i[i])
              1,2,3,4,5,6,7,8: d_o[i] = d1_i;
              9,10,11,12,13,14,15,16: d_o[i] = d2_i;
              17,18,19,20,21,22,23,24: d_o[i] = d3_i;              
              default: d_o[i] = 32'bx;
            endcase
          end
        else
          begin
            case (addr__i[i])
              9,10,11,12,13,14,15,16: d_o[i] = d1_i;
              17,18,19,20,21,22,23,24: d_o[i] = d2_i;
              25,26,27,28,29,30,31,32: d_o[i] = d3_i;              
              default: d_o[i] = 32'bx;
            endcase
          end
      end
  endgenerate

endmodule // output_mux