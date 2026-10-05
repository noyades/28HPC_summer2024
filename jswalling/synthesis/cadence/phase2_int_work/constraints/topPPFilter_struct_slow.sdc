###################################################################

# Created by write_sdc on Sun Mar 31 19:40:21 2024

###################################################################
set sdc_version 2.1
set_units -time ns -capacitance pF ;# -resistance kOhm -voltage V -current mA
current_design scpa_dig_ana_ppfir

# Set the driving cells
set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_driving_cell -lib_cell BUF_X1B_A9PP140ZTUL_C30 -library                               \
sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c [get_ports clk]
set_driving_cell -lib_cell BUF_X1B_A9PP140ZTUL_C30 -library                               \
sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c [get_ports rst_n]
set_driving_cell -lib_cell BUF_X1B_A9PP140ZTUL_C30 -library                               \
sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c [get_ports en]
set_driving_cell -lib_cell BUF_X1B_A9PP140ZTUL_C30 -library                               \
sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c [get_ports In1_re]
set_driving_cell -lib_cell BUF_X1B_A9PP140ZTUL_C30 -library                               \
sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c [get_ports In1_im]


# Use this constraint to define the clock, prior to layout and CTS
create_clock -period 0.278 [get_ports clk]

# Generate clk_2 (divide by 2)
create_generated_clock -divide_by 2 -source [get_ports clk] -name clk_2 [get_pins clkDiv_1_2/clk_out]

# Generate clk_8 (divide by 8)
create_generated_clock -divide_by 8 -source [get_ports clk] -name clk_8 [get_pins clkDiv_1_8/clk_out]

set CLOCK [get_clocks clk]
set_clock_uncertainty -setup 0.07 $CLOCK ;# ~25% of period
set_clock_latency -max 0.11 $CLOCK ;# pre layout latency ~40% of period
set_clock_transition -max 0.014 $CLOCK ;# 5% of period
set_clock_transition -max 0.025 $CLOCK ;# assumes that the rise time of the clock is 5% of the period

# Set same delay for all ports 
set_input_delay -max 0.1 -clock clk [all_inputs] 
set_output_delay -max 0.05 -clock clk [all_outputs] ;# Need to know setup time of FF in SCPA FF + any logic delay before this flop

# Use this to set specific delays for some ports
#set_output_delay -max 0.025 -clock clk  [get_ports miso]
#set_input_delay -max 0.025 -clock clk  [get_ports {modclk}]

set_load .033 [get_ports Re_*] ;# Assumes load of 10fF for all outputs
set_load .033 [get_ports Im_*] ;# Assumes load of 10fF for all outputs
set_load .44 [get_ports Re_s*] ;# Assumes load of 10fF for all outputs
set_load .44 [get_ports Im_s*] ;# Assumes load of 10fF for all outputs

set_max_fanout 15.000 [current_design]
set_max_transition 0.025 [all_inputs] ;# Assumes that the maximum input transition time will be 25 pS

#set_driving_cell  -library sc9mcpp140z_cln28ht_base_ulvt_c30_tt_ctypical_max_0p90v_25c -lib_cell #BUF_X4B_A9PP140ZTL_C30  \
#         [remove_from_collection [all_inputs] $CLOCK] 

set_false_path -from [get_clocks clk] -through [get_ports {en}] -to [get_clocks clk]

# False paths between asynchronous clock domains (clk dividers have asynchronous propagation delay)
set_false_path -from [get_ports {rst_n}]
set_false_path -from [get_clocks clk] -to [get_clocks clk_2]
set_false_path -from [get_clocks clk] -to [get_clocks clk_8]
set_false_path -from [get_clocks clk_2] -to [get_clocks clk]
set_false_path -from [get_clocks clk_8] -to [get_clocks clk]

# set_false_path -from clk -to clk_4

#set_fix_hold $CLOCK
