//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Mon Jun 15 10:59:27 2026
//Host        : DaveHung-PC2 running 64-bit major release  (build 9200)
//Command     : generate_target timer_wrapper.bd
//Design      : timer_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module timer_wrapper
   (clk_100M_10d,
    clk_100M_50d,
    clk_100M_90d,
    clk_200M_50d,
    clk_lck,
    sys_clk);
  output clk_100M_10d;
  output clk_100M_50d;
  output clk_100M_90d;
  output clk_200M_50d;
  output clk_lck;
  input sys_clk;

  wire clk_100M_10d;
  wire clk_100M_50d;
  wire clk_100M_90d;
  wire clk_200M_50d;
  wire clk_lck;
  wire sys_clk;

  timer timer_i
       (.clk_100M_10d(clk_100M_10d),
        .clk_100M_50d(clk_100M_50d),
        .clk_100M_90d(clk_100M_90d),
        .clk_200M_50d(clk_200M_50d),
        .clk_lck(clk_lck),
        .sys_clk(sys_clk));
endmodule
