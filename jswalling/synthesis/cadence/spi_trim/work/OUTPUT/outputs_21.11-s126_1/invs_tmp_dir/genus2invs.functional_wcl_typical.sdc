# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.11-s126_1 on Fri May 10 16:54:15 EDT 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design topVcoDigital

create_clock -name "clk" -period 25.0 -waveform {0.0 12.5} [get_ports clk]
create_clock -name "sclk" -period 31.25 -waveform {0.0 15.625} [get_ports sclk]
set_load -pin_load 1.0 [get_ports {vcoTrim[15]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[14]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[13]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[12]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[11]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[10]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[9]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[8]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[7]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[6]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[5]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[4]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[3]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[2]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[1]}]
set_load -pin_load 1.0 [get_ports {vcoTrim[0]}]
set_false_path -from [get_clocks clk] -to [get_clocks sclk]
set_clock_groups -name "async_clk_sclk" -asynchronous -group [list \
  [get_clocks clk]  \
  [get_clocks sclk] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks sclk] -add_delay 1.25 [get_ports rst]
set_input_delay -clock [get_clocks sclk] -add_delay 1.25 [get_ports ss]
set_input_delay -clock [get_clocks sclk] -add_delay 1.25 [get_ports mosi]
set_max_fanout 10.000 [current_design]
set_max_transition 5.0 [current_design]
