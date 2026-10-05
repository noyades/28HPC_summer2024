set_clock_latency -max  -rise 0.100517  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.102189  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.170117 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.177289 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.170117 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.177289 [get_ports {clk}] -clock clk 
