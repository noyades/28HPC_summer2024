// Created by ihdl
module clkDiv_DIV8 (VDD, VSS, VNW, VPW, 
	clk_in, 
	rst, 
	clk_out);
   inout VDD, VSS, VNW, VPW;
 input clk_in;
   input rst;
   output clk_out;

   // Internal wires
   wire CTS_13;
   wire CTS_14;
   wire CTS_12;
   wire CTS_11;
   wire CTS_10;
   wire CTS_9;
   wire CTS_8;
   wire CTS_7;
   wire CTS_6;
   wire CTS_5;
   wire CTS_4;
   wire CTS_3;
   wire CTS_2;
   wire CTS_1;
   wire [31:0] count;
   wire n_0;
   wire n_1;
   wire n_2;
   wire n_3;
   wire n_4;
   wire n_5;

INV_X4B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03522 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(clk_in),
	.Y(CTS_13));
INV_X2B_A9PP140ZTUL_C30 CTS_ccl_a_inv_00354 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(clk_in),
	.Y(CTS_14));
INV_X2B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03466 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_2),
	.Y(clk_out));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03472 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_3),
	.Y(CTS_2));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03478 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_4),
	.Y(CTS_3));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03483 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_5),
	.Y(CTS_4));
INV_X6B_A9PP140ZTUL_C30 CTS_ccl_inv_03488 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_6),
	.Y(CTS_5));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03493 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_7),
	.Y(CTS_6));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03498 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_8),
	.Y(CTS_7));
INV_X6B_A9PP140ZTUL_C30 CTS_ccl_inv_03503 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_9),
	.Y(CTS_8));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03507 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_10),
	.Y(CTS_9));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_inv_03510 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_11),
	.Y(CTS_10));
INV_X2B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03512 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_12),
	.Y(CTS_11));
INV_X2B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03515 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_1),
	.Y(CTS_12));
DFFQA_X1M_A9PP140ZTUL_C30 clk_out_reg (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .CK(CTS_13),
	.D(n_5),
	.Q(CTS_1));
DFFQNA_X1M_A9PP140ZTUL_C30 \\count_reg\[1\] (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .CK(CTS_14),
	.D(n_3),
	.QN(count[1]));
NOR2XB_X1M_A9PP140ZTUL_C30 g103__5107 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(n_2),
	.BN(rst),
	.Y(n_5));
DFFQNA_X1M_A9PP140ZTUL_C30 \\count_reg\[0\] (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .CK(CTS_14),
	.D(n_4),
	.QN(count[0]));
NOR2XB_X1M_A9PP140ZTUL_C30 g105__6260 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(n_1),
	.BN(count[0]),
	.Y(n_4));
AOI21_X1A_A9PP140ZTUL_C30 g106__4319 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A0(count[0]),
	.A1(count[1]),
	.B0(n_1),
	.Y(n_3));
XOR2_X0P7M_A9PP140ZTUL_C30 g107__8428 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(n_0),
	.B(CTS_11),
	.Y(n_2));
NAND2_X1B_A9PP140ZTUL_C30 g108__5526 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(rst),
	.B(n_0),
	.Y(n_1));
OR2_X1M_A9PP140ZTUL_C30 g109__6783 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(count[0]),
	.B(count[1]),
	.Y(n_0));
endmodule
