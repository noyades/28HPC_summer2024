set_clock_latency -max  -rise 0.079665  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.080078  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.132765 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.137178 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.132765 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.137178 [get_ports {clk}] -clock clk 
