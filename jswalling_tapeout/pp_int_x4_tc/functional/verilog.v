// Created by ihdl
`timescale 10ns/1ps

module pp_int_x4_tc(VDD, VSS, clk, rst_n, en, enb, enb_1_1_1, enb_1_4_0,
     enb_1_4_1);
  inout VDD, VSS;
  input clk, rst_n, en;
  output enb, enb_1_1_1, enb_1_4_0, enb_1_4_1;
  wire VDD, VSS;
  wire clk, rst_n, en;
  wire enb, enb_1_1_1, enb_1_4_0, enb_1_4_1;
  wire [1:0] count4;
  wire n_0, n_1_danc, n_2, n_3, n_4, phase_0, phase_1;
AND2_X8M_A9PP140ZTL_C30 g72 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A (en), .B (phase_0), .Y (enb_1_4_0));
SDFFRPQA_X1M_A9PP140ZTL_C30 \\count4_reg\[1\] (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .R (n_0), .CK (clk), .D
       (count4[1]), .SI (n_4), .SE (en), .Q (count4[1]));
SDFFRPQA_X1M_A9PP140ZTL_C30 phase_0_reg (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .R (n_0), .CK (clk), .D
       (phase_0), .SI (n_2), .SE (en), .Q (phase_0));
SDFFSQA_X1M_A9PP140ZTL_C30 phase_1_reg (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .SN (rst_n), .CK (clk), .D
       (phase_1), .SI (n_1_danc), .SE (en), .Q (phase_1));
DFFSQNA_X1M_A9PP140ZTL_C30 \\count4_reg\[0\] (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .SN (rst_n), .CK (clk), .D
       (n_3), .QN (count4[0]));
NOR2_X1A_A9PP140ZTL_C30 g83 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A (n_1_danc), .B (n_2), .Y (n_4));
XNOR2_X0P7M_A9PP140ZTL_C30 g84 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A (en), .B (count4[0]), .Y (n_3));
NOR2B_X1M_A9PP140ZTL_C30 g85 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .AN (count4[1]), .B (count4[0]), .Y
       (n_2));
NOR2B_X1M_A9PP140ZTL_C30 g86 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .AN (count4[0]), .B (count4[1]), .Y
       (n_1_danc));
INV_X0P7M_A9PP140ZTL_C30 g87 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A (rst_n), .Y (n_0));
AND2_X4M_A9PP140ZTL_C30 g88 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A (phase_1), .B (en), .Y (enb_1_4_1));
endmodule
