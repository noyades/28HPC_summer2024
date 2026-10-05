###################################################################

# Created by write_sdc on Sun Mar 31 19:40:21 2024

###################################################################
set sdc_version 2.1
#set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
current_design topPLLDigital

create_clock -period 30 [get_ports clk]
create_clock -period 31.25 [get_ports sclk]
create_generated_clock -divide_by 2 -source [get_ports clk] -name clk_2 [get_nets clk_2]

set_clock_groups -name async_clk_sclk -asynchronous -group {clk sclk} 

set_false_path -from clk -to sclk
set_false_path -from clk -to clk_2
set_false_path -from sclk -to clk_2

set_input_delay -clock clk 3 [all_inputs] -add_delay -clock sclk 3 [all_inputs]
set_output_delay -clock clk_2 -max 3 [all_outputs]


set_output_delay -clock clk_2  1.5  [get_ports miso]
set_output_delay -clock clk_2  1.5  [get_ports {dsm_out[4]}]
set_output_delay -clock clk_2  1.5  [get_ports {dsm_out[3]}]
set_output_delay -clock clk_2  1.5  [get_ports {dsm_out[2]}]
set_output_delay -clock clk_2  1.5  [get_ports {dsm_out[1]}]
set_output_delay -clock clk_2  1.5  [get_ports {dsm_out[0]}]
set_input_delay -clock clk  1.5  [get_ports {modclk}]
set_input_delay -clock clk  1.5  [get_ports {rst}]
set_input_delay -clock clk  1.5  [get_ports {sclk}]
set_input_delay -clock clk  1.5  [get_ports {ss}]
set_input_delay -clock clk  1.5  [get_ports {mosi}]

set_load 1 [all_outputs]

set_max_fanout 15.000 [current_design]
set_max_transition 6 [current_design]
