//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Thu Feb 24 21:42:48 2022
//Host        : DESKTOP-S6OV110 running 64-bit major release  (build 9200)
//Command     : generate_target led_sw_wrapper.bd
//Design      : led_sw_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module led_sw_wrapper
   (btn_switch_tri_i,
    clk_100MHz,
    led_tri_o);
  input [7:0]btn_switch_tri_i;
  input clk_100MHz;
  output [3:0]led_tri_o;

  wire [7:0]btn_switch_tri_i;
  wire clk_100MHz;
  wire [3:0]led_tri_o;

  led_sw led_sw_i
       (.btn_switch_tri_i(btn_switch_tri_i),
        .clk_100MHz(clk_100MHz),
        .led_tri_o(led_tri_o));
endmodule
