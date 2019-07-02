`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 李�?�旭
//
// Create Date: 2019/02/01 15:16:17
// Design Name: 前缀加法�??
// Module Name: prefix_adder
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


module prefix_adder(
    input wire [31:0] in_a,
    input wire [31:0] in_b,
    output wire [31:0] out
    );
    assign out[0] = in_a[0] ^ in_b[0];
    // initial
    wire [31:0] P;
    wire [31:0] G;
//    integer i;
    genvar i;
    generate
//    always @ (*)
//    begin
        for (i = 0;i<32;i = i + 1)
        begin
            assign P[i] = in_a[i] | in_b[i];
            assign G[i] = in_a[i] & in_b[i];
        end
//    end
    endgenerate
    // first layer
    wire [31:0] P1;
    wire [31:0] G1;
    generate
        for (i = 1;i < 30;i = i + 2)
        begin
            assign P1[i] = P[i];
            assign G1[i] = G[i];
            assign P1[i + 1] = P[i + 1] & P[i];
            assign G1[i + 1] = G[i + 1] | (P[i + 1] & G[i]) ;
        end
    endgenerate
    assign P1[0] = P[0] & 1'b0;
    assign G1[0] = G[0] | (P[0] & 1'b0) ;
    assign P1[31] = P[31];
    assign G1[31] = G[31];
    //second layer
    wire [31:0] P2;
    wire [31:0] G2;
    generate
        for (i = 0;i < 32;i = i + 4)
        begin
            assign P2[i] = P1[i];
            assign G2[i] = G1[i];
            assign P2[i + 1] = P1[i + 1] & P1[i];
            assign G2[i + 1] = G1[i + 1] | (P1[i + 1] & G1[i]) ;
            assign P2[i + 2] = P1[i + 2] & P1[i];
            assign G2[i + 2] = G1[i + 2] | (P1[i + 2] & G1[i]) ;
            assign P2[i + 3] = P1[i + 3];
            assign G2[i + 3] = G1[i + 3];
        end
    endgenerate
    //third layer
    wire [31:0] P3;
    wire [31:0] G3;
    generate
        for (i = 2;i < 32;i = i + 8)
        begin
            assign P3[i - 2] = P2[i - 2];
            assign G3[i - 2] = G2[i - 2];
            assign P3[i - 1] = P2[i - 1];
            assign G3[i - 1] = G2[i - 1];
            assign P3[i] = P2[i];
            assign G3[i] = G2[i];
            assign P3[i + 1] = P2[i + 1] & P2[i];
            assign G3[i + 1] = G2[i + 1] | (P2[i + 1] & G2[i]) ;
            assign P3[i + 2] = P2[i + 2] & P2[i];
            assign G3[i + 2] = G2[i + 2] | (P2[i + 2] & G2[i]) ;
            assign P3[i + 3] = P2[i + 3] & P2[i];
            assign G3[i + 3] = G2[i + 3] | (P2[i + 3] & G2[i]) ;
            assign P3[i + 4] = P2[i + 4] & P2[i];
            assign G3[i + 4] = G2[i + 4] | (P2[i + 4] & G2[i]) ;
            assign P3[i + 5] = P2[i + 5];
            assign G3[i + 5] = G2[i + 5];
        end
    endgenerate
    //forth layer
    wire [31:0] P4;
    wire [31:0] G4;
    generate
        for (i = 6;i < 32;i = i + 16)
        begin
            assign P4[i - 6] = P3[i - 6];
            assign G4[i - 6] = G3[i - 6];
            assign P4[i - 5] = P3[i - 5];
            assign G4[i - 5] = G3[i - 5];
            assign P4[i - 4] = P3[i - 4];
            assign G4[i - 4] = G3[i - 4];
            assign P4[i - 3] = P3[i - 3];
            assign G4[i - 3] = G3[i - 3];
            assign P4[i - 2] = P3[i - 2];
            assign G4[i - 2] = G3[i - 2];
            assign P4[i - 1] = P3[i - 1];
            assign G4[i - 1] = G3[i - 1];
            assign P4[i] = P3[i];
            assign G4[i] = G3[i];
            assign P4[i + 1] = P3[i + 1] & P3[i];
            assign G4[i + 1] = G3[i + 1] | (P3[i + 1] & G3[i]) ;
            assign P4[i + 2] = P3[i + 2] & P2[i];
            assign G4[i + 2] = G3[i + 2] | (P3[i + 2] & G3[i]) ;
            assign P4[i + 3] = P3[i + 3] & P2[i];
            assign G4[i + 3] = G3[i + 3] | (P3[i + 3] & G3[i]) ;
            assign P4[i + 4] = P3[i + 4] & P2[i];
            assign G4[i + 4] = G3[i + 4] | (P3[i + 4] & G3[i]) ;
            assign P4[i + 5] = P3[i + 5] & P3[i];
            assign G4[i + 5] = G3[i + 5] | (P3[i + 5] & G3[i]) ;
            assign P4[i + 6] = P3[i + 6] & P2[i];
            assign G4[i + 6] = G3[i + 6] | (P3[i + 6] & G3[i]) ;
            assign P4[i + 7] = P3[i + 7] & P2[i];
            assign G4[i + 7] = G3[i + 7] | (P3[i + 7] & G3[i]) ;
            assign P4[i + 8] = P3[i + 8] & P2[i];
            assign G4[i + 8] = G3[i + 8] | (P3[i + 8] & G3[i]) ;
            assign P4[i + 9] = P3[i + 9];
            assign G4[i + 9] = G3[i + 9];
        end
    endgenerate
    //end layer
    generate
    for (i = 1;i<32;i = i + 1)
        begin
            assign out[i] = G4[i - 1] ^ (in_a[i] ^ in_b[i]);
        end
    endgenerate
endmodule
