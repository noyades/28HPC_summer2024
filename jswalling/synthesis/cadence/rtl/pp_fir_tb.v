`timescale 1ps / 1ps

module pp_fir_tb;

  // Parameters
  parameter CLK_PERIOD = 500;

  // Signals
  reg clk;
  reg rst_n;
  reg en;
  reg [15:0] In1_re;
  reg [15:0] In1_im;
  wire ce_out;
  wire [255:0] Out_0_re;
  wire Out_0_re_s;
  wire [255:0] Out_0_im;
  wire Out_0_im_s;
  wire [255:0] Out_1_re;
  wire Out_1_re_s;
  wire [255:0] Out_1_im;
  wire Out_1_im_s;
  wire [255:0] Out_2_re;
  wire Out_2_re_s;
  wire [255:0] Out_2_im;
  wire Out_2_im_s;
  wire [255:0] Out_3_re;
  wire Out_3_re_s;
  wire [255:0] Out_3_im;
  wire Out_3_im_s;
  wire [255:0] Out_4_re;
  wire Out_4_re_s;
  wire [255:0] Out_4_im;
  wire Out_4_im_s;
  wire [255:0] Out_5_re;
  wire Out_5_re_s;
  wire [255:0] Out_5_im;
  wire Out_5_im_s;  
  wire [255:0] Out_6_re;
  wire Out_6_re_s;
  wire [255:0] Out_6_im;
  wire Out_6_im_s;
  wire [255:0] Out_7_re;
  wire Out_7_re_s;
  wire [255:0] Out_7_im;
  wire Out_7_im_s;

  // File handling variables
  integer file_re, file_im;
  integer re_0_expected, im_0_expected, status_re_0, status_im_0;
  integer re_1_expected, im_1_expected, status_re_1, status_im_1;
  integer re_2_expected, im_2_expected, status_re_2, status_im_2;
  integer re_3_expected, im_3_expected, status_re_3, status_im_3;
  integer re_4_expected, im_4_expected, status_re_4, status_im_4;
  integer re_5_expected, im_5_expected, status_re_5, status_im_5;
  integer re_6_expected, im_6_expected, status_re_6, status_im_6;
  integer re_7_expected, im_7_expected, status_re_7, status_im_7;
  integer status_re, status_im;
  reg [7:0] expected_0_re, expected_0_im;
  reg [7:0] expected_1_re, expected_1_im;
  reg [7:0] expected_2_re, expected_2_im;
  reg [7:0] expected_3_re, expected_3_im;
  reg [7:0] expected_4_re, expected_4_im;
  reg [7:0] expected_5_re, expected_5_im;
  reg [7:0] expected_6_re, expected_6_im;
  reg [7:0] expected_7_re, expected_7_im;

  // Instantiate the DUT
  pp_fir u_pp_fir (
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .In1_re(In1_re),
    .In1_im(In1_im),
    .ce_out(ce_out),
    .Re_0(Out_0_re),
    .Re_s_0(Out_0_re_s),
    .Im_0(Out_0_im),
    .Im_s_0(Out_0_im_s),
    .Re_1(Out_1_re),
    .Re_s_1(Out_1_re_s),
    .Im_1(Out_1_im),
    .Im_s_1(Out_1_im_s),
    .Re_2(Out_2_re),
    .Re_s_2(Out_2_re_s), 
    .Im_2(Out_2_im),
    .Im_s_2(Out_2_im_s),
    .Re_3(Out_3_re),
    .Re_s_3(Out_3_re_s),
    .Im_3(Out_3_im),
    .Im_s_3(Out_3_im_s),
    .Re_4(Out_4_re),
    .Re_s_4(Out_4_re_s),
    .Im_4(Out_4_im),
    .Im_s_4(Out_4_im_s),
    .Re_5(Out_5_re),
    .Re_s_5(Out_5_re_s),
    .Im_5(Out_5_im),
    .Im_s_5(Out_5_im_s),
    .Re_6(Out_6_re),
    .Re_s_6(Out_6_re_s),
    .Im_6(Out_6_im),
    .Im_s_6(Out_6_im_s),
    .Re_7(Out_7_re),
    .Re_s_7(Out_7_re_s),
    .Im_7(Out_7_im),
    .Im_s_7(Out_7_im_s)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
  #200000;
    rst_n = 1;
  end

  // Enable signal
  initial begin
    en = 0;
  #300000;
    en = 1;
  end

  // Read input data and apply to DUT
  initial begin
    file_re = $fopen("In1_re.dat", "r");
    file_im = $fopen("In1_im.dat", "r");
    re_0_expected = $fopen("Re_0_expected.dat", "r");
    im_0_expected = $fopen("Im_0_expected.dat", "r");
    re_1_expected = $fopen("Re_1_expected.dat", "r");
    im_1_expected = $fopen("Im_1_expected.dat", "r");
    re_2_expected = $fopen("Re_2_expected.dat", "r");
    im_2_expected = $fopen("Im_2_expected.dat", "r");
    re_3_expected = $fopen("Re_3_expected.dat", "r");
    im_3_expected = $fopen("Im_3_expected.dat", "r");
    re_4_expected = $fopen("Re_4_expected.dat", "r");
    im_4_expected = $fopen("Im_4_expected.dat", "r");
    re_5_expected = $fopen("Re_5_expected.dat", "r");
    im_5_expected = $fopen("Im_5_expected.dat", "r");
    re_6_expected = $fopen("Re_6_expected.dat", "r");
    im_6_expected = $fopen("Im_6_expected.dat", "r");
    re_7_expected = $fopen("Re_7_expected.dat", "r");
    im_7_expected = $fopen("Im_7_expected.dat", "r");

    if (file_re == 0 || file_im == 0) begin
      $display("Error opening input files.");
      $finish;
    end

    if (re_0_expected == 0 || im_0_expected == 0 ||
        re_1_expected == 0 || im_1_expected == 0 || re_2_expected == 0 || im_2_expected == 0 ||
        re_3_expected == 0 || im_3_expected == 0 || re_4_expected == 0 || im_4_expected == 0 ||
        re_5_expected == 0 || im_5_expected == 0 || re_6_expected == 0 || im_6_expected == 0 ||
        re_7_expected == 0 || im_7_expected == 0) begin
      $display("Error opening data files.");
      $finish;
    end  

    while (!$feof(file_re) && !$feof(file_im) && !$feof(re_0_expected) && !$feof(im_0_expected) &&
           !$feof(re_1_expected) && !$feof(im_1_expected) && !$feof(re_2_expected) && !$feof(im_2_expected) &&
           !$feof(re_3_expected) && !$feof(im_3_expected) && !$feof(re_4_expected) && !$feof(im_4_expected) &&
           !$feof(re_5_expected) && !$feof(im_5_expected) && !$feof(re_6_expected) && !$feof(im_6_expected) &&
           !$feof(re_7_expected) && !$feof(im_7_expected)) begin
      status_re = $fscanf(file_re, "%h\n", In1_re);
      status_im = $fscanf(file_im, "%h\n", In1_im);
      status_re_0 = $fscanf(re_0_expected, "%h\n", expected_0_re);
      status_im_0 = $fscanf(im_0_expected, "%h\n", expected_0_im);
      status_re_1 = $fscanf(re_1_expected, "%h\n", expected_1_re);
      status_im_1 = $fscanf(im_1_expected, "%h\n", expected_1_im);
      status_re_2 = $fscanf(re_2_expected, "%h\n", expected_2_re);
      status_im_2 = $fscanf(im_2_expected, "%h\n", expected_2_im);
      status_re_3 = $fscanf(re_3_expected, "%h\n", expected_3_re);
      status_im_3 = $fscanf(im_3_expected, "%h\n", expected_3_im);
      status_re_4 = $fscanf(re_4_expected, "%h\n", expected_4_re);
      status_im_4 = $fscanf(im_4_expected, "%h\n", expected_4_im);
      status_re_5 = $fscanf(re_5_expected, "%h\n", expected_5_re);
      status_im_5 = $fscanf(im_5_expected, "%h\n", expected_5_im);
      status_re_6 = $fscanf(re_6_expected, "%h\n", expected_6_re);
      status_im_6 = $fscanf(im_6_expected, "%h\n", expected_6_im);
      status_re_7 = $fscanf(re_7_expected, "%h\n", expected_7_re);
      status_im_7 = $fscanf(im_7_expected, "%h\n", expected_7_im);

      if (status_re != 1 || status_im != 1 || status_re_0 != 1 || status_im_0 != 1 ||
          status_re_1 != 1 || status_im_1 != 1 || status_re_2 != 1 || status_im_2 != 1 ||
          status_re_3 != 1 || status_im_3 != 1 || status_re_4 != 1 || status_im_4 != 1 ||
          status_re_5 != 1 || status_im_5 != 1 || status_re_6 != 1 || status_im_6 != 1 ||
          status_re_7 != 1 || status_im_7 != 1) begin
        $display("Error reading input files.");
        $finish;
      end

      // Apply input values to DUT
      #CLK_PERIOD;

      // Debugging: Print input and output values
      $display("Time: %0t | In1_re: %h | In1_im: %h | Out_0_re: %h | Out_0_im: %h", $time, In1_re, In1_im, Out_0_re, Out_0_im);

      // Check output against expected values
      if (Out_0_re !== expected_0_re) begin
        $display("Mismatch at time %0t: Out_0_re = %d, expected = %d", $time, Out_0_re, expected_0_re);
      end
      if (Out_0_im !== expected_0_im) begin
        $display("Mismatch at time %0t: Out_0_im = %d, expected = %d", $time, Out_0_im, expected_0_im);
      end
      if (Out_1_re !== expected_1_re) begin
        $display("Mismatch at time %0t: Out_1_re = %d, expected = %d", $time, Out_1_re, expected_1_re);
      end
      if (Out_1_im !== expected_1_im) begin
        $display("Mismatch at time %0t: Out_1_im = %d, expected = %d", $time, Out_1_im, expected_1_im);
      end
      if (Out_2_re !== expected_2_re) begin
        $display("Mismatch at time %0t: Out_2_re = %d, expected = %d", $time, Out_2_re, expected_2_re);
      end
      if (Out_2_im !== expected_2_im) begin
        $display("Mismatch at time %0t: Out_2_im = %d, expected = %d", $time, Out_2_im, expected_2_im);
      end
      if (Out_3_re !== expected_3_re) begin
        $display("Mismatch at time %0t: Out_3_re = %d, expected = %d", $time, Out_3_re, expected_3_re);
      end
      if (Out_3_im !== expected_3_im) begin
        $display("Mismatch at time %0t: Out_3_im = %d, expected = %d", $time, Out_3_im, expected_3_im);
      end
      if (Out_4_re !== expected_4_re) begin
        $display("Mismatch at time %0t: Out_4_re = %d, expected = %d", $time, Out_4_re, expected_4_re);
      end
      if (Out_4_im !== expected_4_im) begin
        $display("Mismatch at time %0t: Out_4_im = %d, expected = %d", $time, Out_4_im, expected_4_im);
      end
      if (Out_5_re !== expected_5_re) begin
        $display("Mismatch at time %0t: Out_5_re = %d, expected = %d", $time, Out_5_re, expected_5_re);
      end
      if (Out_5_im !== expected_5_im) begin
        $display("Mismatch at time %0t: Out_5_im = %d, expected = %d", $time, Out_5_im, expected_5_im);
      end
      if (Out_6_re !== expected_6_re) begin
        $display("Mismatch at time %0t: Out_6_re = %d, expected = %d", $time, Out_6_re, expected_6_re);
      end
      if (Out_6_im !== expected_6_im) begin
        $display("Mismatch at time %0t: Out_6_im = %d, expected = %d", $time, Out_6_im, expected_6_im);
      end
      if (Out_7_re !== expected_7_re) begin
        $display("Mismatch at time %0t: Out_7_re = %d, expected = %d", $time, Out_7_re, expected_7_re);
      end
      if (Out_7_im !== expected_7_im) begin
        $display("Mismatch at time %0t: Out_7_im = %d, expected = %d", $time, Out_7_im, expected_7_im);
      end
    end

    $fclose(file_re);
    $fclose(file_im);
    $fclose(re_0_expected);
    $fclose(im_0_expected);
    $fclose(re_1_expected);
    $fclose(im_1_expected);
    $fclose(re_2_expected);
    $fclose(im_2_expected);
    $fclose(re_3_expected);
    $fclose(im_3_expected);
    $fclose(re_4_expected);
    $fclose(im_4_expected);
    $fclose(re_5_expected);
    $fclose(im_5_expected);
    $fclose(re_6_expected);
    $fclose(im_6_expected);
    $fclose(re_7_expected);
    $fclose(im_7_expected);
    $stop;
  end

  // Monitor outputs
  initial begin
    $monitor("Time: %0t | In1_re: %d | In1_im: %d | Out_0_re: %d | Out_0_im: %d", $time, In1_re, In1_im, Out_0_re, Out_0_im);
  end

  // Dump waves to VCD file
  initial begin
    $dumpfile("pp_fir_tb.vcd");
    $dumpvars(0, pp_fir_tb);
  end

endmodule