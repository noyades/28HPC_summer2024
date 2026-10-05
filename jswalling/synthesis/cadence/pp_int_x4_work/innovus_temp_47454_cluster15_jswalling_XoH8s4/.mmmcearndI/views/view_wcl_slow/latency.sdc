set_clock_latency -max  -rise 0.133053  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.134803  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.225653 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.234903 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.225653 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.234903 [get_ports {clk}] -clock clk 
