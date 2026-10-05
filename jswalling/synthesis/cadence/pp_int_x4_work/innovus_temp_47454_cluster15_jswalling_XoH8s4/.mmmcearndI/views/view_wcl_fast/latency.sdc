set_clock_latency -max  -rise 0.077704  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.0791796  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.131704 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.13708 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.131704 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.13708 [get_ports {clk}] -clock clk 
