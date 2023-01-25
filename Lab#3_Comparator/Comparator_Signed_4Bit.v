`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SABANCI UNIVERSITY
// Engineer: BERNA YILDIRAN
// 
// Create Date: 12/07/2022 09:20:10 PM
// Design Name: Signed 4-Bit Comparator Circuit
// Module Name: Comparator_Signed_4Bit
// Project Name: CS303 PRE-LAB #3
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


module CompUnsigned #(
    parameter Bits = 1
)
(
    input [(Bits -1):0] a,
    input [(Bits -1):0] b,
    output \> ,
    output \= ,
    output \<
);
    assign \> = a > b;
    assign \= = a == b;
    assign \< = a < b;
endmodule

module Comparator_Signed_4Bit(
      input A3,
      input A2,
      input A1,
      input A0,
      input B3,
      input B2,
      input B1,
      input B0,
      output A_GREATER_B,
      output A_LESS_B,
      output A_EQUAL_B
      );
      
      wire s0;
      wire s1;
      wire s2;
      wire s3;
      wire s4;
      wire s5;
      wire s6;
      wire s7;
      wire s8;
      wire s9;
      wire s10;
      wire s11;
      wire s12;
      wire s13;
      
      // ----------------------------
      // Comp 3 MSB
      CompUnsigned #(
        .Bits(1)
      )
      CompUnsigned_i0 (
        .a( A3 ),
        .b( B3 ),
        .\> ( s0 ),
        .\= ( s1 ),
        .\< ( s2 )
      );
      
      // ----------------------------
      // Comp 2
      CompUnsigned #(
        .Bits(1)
      )
      CompUnsigned_i1 (
        .a( A2 ),
        .b( B2 ),
        .\> ( s3 ),
        .\= ( s4 ),
        .\< ( s5 )
      );
      
      // ----------------------------
      // Comp 1
      CompUnsigned #(
        .Bits(1)
      )
      CompUnsigned_i2 (
        .a( A1 ),
        .b( B1 ),
        .\> ( s6 ),
        .\= ( s7 ),
        .\< ( s8 )
      );
      
      // ----------------------------
      // Comp 0
      CompUnsigned #(
        .Bits(1)
      )
      CompUnsigned_i3 (
        .a( A0 ),
        .b( B0 ),
        .\> ( s9 ),
        .\= ( s10 ),
        .\< ( s11 )
      );
      
      // ----------------------------
      // OUTPUTS
      assign s12 = (s1 & s4);
      assign s13 = (s12 & s7);
      assign A_EQUAL_B  = (s13 & s10);
      assign A_LESS_B  = (s0 | (s1 & s5) | (s12 & s8) | (s13 & s11));
      assign A_GREATER_B  = (s2 | (s1 & s3) | (s12 & s6) | (s13 & s9));
    endmodule
