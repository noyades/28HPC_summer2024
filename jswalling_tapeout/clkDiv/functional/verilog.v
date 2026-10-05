// Created by ihdl
module clkDiv (VDD, VSS, VNW, VPW, 
	rst, 
	clk_out, 
	clk_in, 
	clk_in_clone1);
   inout VDD, VSS, VNW, VPW;
 input rst;
   output clk_out;
   input clk_in;
   input clk_in_clone1;

   // Internal wires
   wire CTS_5;
   wire CTS_2;
   wire CTS_1;
   wire [31:0] count;
   wire n_0;
   wire n_1;
   wire n_2;

   INV_X2B_A9PP140ZTL_C30 CTS_ccl_a_inv_00085 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(clk_in_clone1),
	.Y(CTS_5));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_01433 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_2),
	.Y(clk_out));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_01434 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_1),
	.Y(CTS_2));
   DFFQA_X1M_A9PP140ZTL_C30 clk_out_reg (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(clk_in),
	.D(n_2),
	.Q(CTS_1));
   AND2_X6M_A9PP140ZTL_C30 g20__2398 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(rst),
	.B(n_1),
	.Y(n_2));
   DFFQN_X2M_A9PP140ZTL_C30 \count_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(n_0),
	.QN(count[0]));
   XNOR2_X0P7M_A9PP140ZTL_C30 g22__5107 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(count[0]),
	.B(clk_out),
	.Y(n_1));
   AND2_X1M_A9PP140ZTL_C30 g23__6260 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(rst),
	.B(count[0]),
	.Y(n_0));
endmodule
