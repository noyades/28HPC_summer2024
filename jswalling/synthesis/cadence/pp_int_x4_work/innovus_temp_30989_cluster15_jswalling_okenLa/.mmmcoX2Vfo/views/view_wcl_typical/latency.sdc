set_clock_latency -max  -rise 0.103437  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.103948  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.171937 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.178048 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.171937 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.178048 [get_ports {clk}] -clock clk 
