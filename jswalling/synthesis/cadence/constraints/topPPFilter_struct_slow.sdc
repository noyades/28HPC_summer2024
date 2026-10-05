###################################################################

# Created by write_sdc on Sun Mar 31 19:40:21 2024

###################################################################
set sdc_version 2.1
set_units -time ns -capacitance pF ;# -resistance kOhm -voltage V -current mA
current_design pp_fir_u_7

# Use this constraint to define the clock, prior to layout and CTS
create_clock -period 0.5 [get_ports clk]
set CLOCK [get_clocks clk]
set_clock_uncertainty -setup 0.1375 $CLOCK ;# Assumes jitter of 50ps and skew + margin of 75ps
set_clock_latency -max 0.22 $CLOCK ;# pre layout assumes input latency of the clock is maximum 40% of the period
set_clock_transition -max 0.0275 $CLOCK ;# assumes that the rise time of the clock is 5% of the period

# Set same delay for all ports 
set_input_delay -max 0.35 -clock clk [all_inputs] 
remove_input_delay [get_ports clk]
set_output_delay -max 0.075 -clock clk [all_outputs] ;# Need to know setup time of FF in SCPA FF + any logic delay before this flop

# Use this to set specific delays for some ports
#set_output_delay -max 0.025 -clock clk  [get_ports miso]
#set_input_delay -max 0.025 -clock clk  [get_ports {modclk}]

set_load .011 [all_outputs] ;# Assumes load of 10fF for all outputs

#set_max_fanout 15.000 [current_design]
set_max_transition 0.055 [all_inputs] ;# Assumes that the maximum input transition time will be 50 pS

set_driving_cell  -library sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c -lib_cell BUF_X4B_A9PP140ZTL_C30  \
         [remove_from_collection [all_inputs] $CLOCK] 

set_false_path -from [get_ports {enb_1_8_0}] -to [all_outputs]

#set_fix_hold $CLOCK
