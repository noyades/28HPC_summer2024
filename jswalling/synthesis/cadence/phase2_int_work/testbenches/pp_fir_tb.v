`timescale 1ps / 1ps

module pp_fir_tb;

  // Parameters
  parameter IN_PERIOD = 2400;
  parameter CLK_PERIOD = 300;

  // Signals
  reg clk;
  reg rst_n;
  reg en;
  reg [12:0] In1_re;
  reg [12:0] In1_im;
  reg ce_out = 1'b1;
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
 
  // File handling variables
  integer file_re, file_im;
  integer re_0_expected, im_0_expected, status_re_0, status_im_0;
  integer re_1_expected, im_1_expected, status_re_1, status_im_1;
  integer re_2_expected, im_2_expected, status_re_2, status_im_2;
  integer re_3_expected, im_3_expected, status_re_3, status_im_3;
  integer status_re, status_im;
  reg [7:0] expected_0_re, expected_0_im;
  reg [7:0] expected_1_re, expected_1_im;
  reg [7:0] expected_2_re, expected_2_im;
  reg [7:0] expected_3_re, expected_3_im;
 
  wire [255:0] expected_0_re_u, expected_0_im_u;
  wire [255:0] expected_1_re_u, expected_1_im_u;
  wire [255:0] expected_2_re_u, expected_2_im_u;
  wire [255:0] expected_3_re_u, expected_3_im_u;

  // Instantiate the DUT
  scpa_dig_ana_ppfir u_pp_fir (
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .In1_re(In1_re),
    .In1_im(In1_im),
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
    .Im_s_3(Out_3_im_s)
  );
  
  b2u_8to255_quad b2u_8to255_quad_0 (
          .clk(clk),
          .rst(rst_n),
          .enable(1'b1),
          .iIn(expected_0_re),
          .iMsb(1'b0),
          .qIn(expected_0_im),
          .qMsb(1'b0),
          .iOut(expected_0_re_u),
          .qOut(expected_0_im_u)
  );

  b2u_8to255_quad b2u_8to255_quad_1 (
          .clk(clk),
          .rst(rst_n),
          .enable(1'b1),
          .iIn(expected_1_re),
          .iMsb(1'b0),
          .qIn(expected_1_im),
          .qMsb(1'b0),
          .iOut(expected_1_re_u),
          .qOut(expected_1_im_u)
  );

  b2u_8to255_quad b2u_8to255_quad_2 (
          .clk(clk),
          .rst(rst_n),
          .enable(1'b1),
          .iIn(expected_2_re),
          .iMsb(1'b0),
          .qIn(expected_2_im),
          .qMsb(1'b0),
          .iOut(expected_2_re_u),
          .qOut(expected_2_im_u)
  );

  b2u_8to255_quad b2u_8to255_quad_3 (
          .clk(clk),
          .rst(rst_n),
          .enable(1'b1),
          .iIn(expected_3_re),
          .iMsb(1'b0),
          .qIn(expected_3_im),
          .qMsb(1'b0),
          .iOut(expected_3_re_u),
          .qOut(expected_3_im_u)
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

    if (file_re == 0 || file_im == 0) begin
      $display("Error opening input files.");
      $finish;
    end

    while (!$feof(file_re) && !$feof(file_im)) begin
      status_re = $fscanf(file_re, "%h\n", In1_re);
      status_im = $fscanf(file_im, "%h\n", In1_im);

      if (status_re != 1 || status_im != 1) begin
        $display("Error reading input files.");
        $finish;
      end
      
      // Apply input values to DUT
      #IN_PERIOD;
    end 

    $fclose(file_re);
    $fclose(file_im);
  end

  // Introduce a one-time delay for expected values
  initial begin
    #3000; // 750 ps delay

    // Read expected data
    re_0_expected = $fopen("re_dig_0_expected.dat", "r");
    im_0_expected = $fopen("im_dig_0_expected.dat", "r");
    re_1_expected = $fopen("re_dig_1_expected.dat", "r");
    im_1_expected = $fopen("im_dig_1_expected.dat", "r");
    re_2_expected = $fopen("re_dig_2_expected.dat", "r");
    im_2_expected = $fopen("im_dig_2_expected.dat", "r");
    re_3_expected = $fopen("re_dig_3_expected.dat", "r");
    im_3_expected = $fopen("im_dig_3_expected.dat", "r");

    if (re_0_expected == 0 || im_0_expected == 0 ||
        re_1_expected == 0 || im_1_expected == 0 || 
        re_2_expected == 0 || im_2_expected == 0 ||
        re_3_expected == 0 || im_3_expected == 0) begin
      $display("Error opening expected data files.");
      $finish;
    end  

    while (!$feof(re_0_expected) && !$feof(im_0_expected) &&
           !$feof(re_1_expected) && !$feof(im_1_expected) && 
           !$feof(re_2_expected) && !$feof(im_2_expected) &&
           !$feof(re_3_expected) && !$feof(im_3_expected)) begin
      status_re_0 = $fscanf(re_0_expected, "%h\n", expected_0_re);
      status_im_0 = $fscanf(im_0_expected, "%h\n", expected_0_im);
      status_re_1 = $fscanf(re_1_expected, "%h\n", expected_1_re);
      status_im_1 = $fscanf(im_1_expected, "%h\n", expected_1_im);
      status_re_2 = $fscanf(re_2_expected, "%h\n", expected_2_re);
      status_im_2 = $fscanf(im_2_expected, "%h\n", expected_2_im);
      status_re_3 = $fscanf(re_3_expected, "%h\n", expected_3_re);
      status_im_3 = $fscanf(im_3_expected, "%h\n", expected_3_im);

      if (status_re_0 != 1 || status_im_0 != 1 || 
          status_re_1 != 1 || status_im_1 != 1 ||
          status_re_2 != 1 || status_im_2 != 1 || 
          status_re_3 != 1 || status_im_3 != 1) begin
        $display("Error reading expected files.");
        $finish;
      end
      #CLK_PERIOD;

      // Debugging: Print input and output values
      //$display("Time: %0t | In1_re: %h | In1_im: %h | Out_0_re: %h | Out_0_im: %h", $time, In1_re, In1_im, Out_0_re, Out_0_im);

      // Check output against expected values
      if (Out_0_re !== expected_0_re_u) begin
        $display("Mismatch at time %0t: Out_0_re = %d, expected = %d", $time, Out_0_re, expected_0_re_u);
      end
      if (Out_0_im !== expected_0_im_u) begin
        $display("Mismatch at time %0t: Out_0_im = %d, expected = %d", $time, Out_0_im, expected_0_im_u);
      end
      if (Out_1_re !== expected_1_re_u) begin
        $display("Mismatch at time %0t: Out_1_re = %d, expected = %d", $time, Out_1_re, expected_1_re_u);
      end
      if (Out_1_im !== expected_1_im_u) begin
        $display("Mismatch at time %0t: Out_1_im = %d, expected = %d", $time, Out_1_im, expected_1_im_u);
      end
      if (Out_2_re !== expected_2_re_u) begin
        $display("Mismatch at time %0t: Out_2_re = %d, expected = %d", $time, Out_2_re, expected_2_re_u);
      end
      if (Out_2_im !== expected_2_im_u) begin
        $display("Mismatch at time %0t: Out_2_im = %d, expected = %d", $time, Out_2_im, expected_2_im_u);
      end
      if (Out_3_re !== expected_3_re_u) begin
        $display("Mismatch at time %0t: Out_3_re = %d, expected = %d", $time, Out_3_re, expected_3_re_u);
      end
      if (Out_3_im !== expected_3_im_u) begin
        $display("Mismatch at time %0t: Out_3_im = %d, expected = %d", $time, Out_3_im, expected_3_im_u);
      end
    end

    $fclose(re_0_expected);
    $fclose(im_0_expected);
    $fclose(re_1_expected);
    $fclose(im_1_expected);
    $fclose(re_2_expected);
    $fclose(im_2_expected);
    $fclose(re_3_expected);
    $fclose(im_3_expected);
    $stop;
  end

  // Monitor outputs
  initial begin
    $monitor("Time: %0t | In1_re: %d | In1_im: %d | Out_0_re: %d | Out_0_im: %d", $time, In1_re, In1_im, Out_0_re, Out_0_im);
  end

  // Dump waves to VCD file
  initial begin
    $dumpfile("scpa_dig_ana_ppfir_tb.vcd");
    $dumpvars(0, u_pp_fir);
    $dumpvars(0, pp_fir_tb);
  end

endmodule
