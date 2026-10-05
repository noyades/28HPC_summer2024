// Created by ihdl
module clkDiv_DIV2 (VDD, VSS, VNW, VPW, 
	clk_in, 
	rst, 
	clk_out);
   inout VDD, VSS, VNW, VPW;
 input clk_in;
   input rst;
   output clk_out;

   // Internal wires
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
   wire n_0;

INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03513 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_2),
	.Y(clk_out));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03516 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_3),
	.Y(CTS_2));
INV_X6B_A9PP140ZTUL_C30 CTS_ccl_inv_03518 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_4),
	.Y(CTS_3));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03520 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_5),
	.Y(CTS_4));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03523 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_6),
	.Y(CTS_5));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03526 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_7),
	.Y(CTS_6));
INV_X6B_A9PP140ZTUL_C30 CTS_ccl_inv_03528 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_8),
	.Y(CTS_7));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03529 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_9),
	.Y(CTS_8));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03530 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_10),
	.Y(CTS_9));
INV_X7P5B_A9PP140ZTUL_C30 CTS_ccl_inv_03533 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_11),
	.Y(CTS_10));
INV_X6B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03534 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_12),
	.Y(CTS_11));
INV_X4B_A9PP140ZTUL_C30 CTS_ccl_a_inv_03535 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_1),
	.Y(CTS_12));
DFFQA_X1M_A9PP140ZTUL_C30 clk_out_reg (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .CK(clk_in),
	.D(n_0),
	.Q(CTS_1));
NOR2XB_X1M_A9PP140ZTUL_C30 g12__2398 (.VDD(VDD),.VSS(VSS),.VNW(VDD),.VPW(VSS), .A(CTS_11),
	.BN(rst),
	.Y(n_0));
endmodule
