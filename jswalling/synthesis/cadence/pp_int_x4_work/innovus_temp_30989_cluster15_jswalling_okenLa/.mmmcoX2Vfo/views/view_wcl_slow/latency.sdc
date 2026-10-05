set_clock_latency -max  -rise 0.136707  [get_clocks {clk_4}]
set_clock_latency -max  -fall 0.137094  [get_clocks {clk_4}]
set_clock_latency -source -early -max -rise  -0.227357 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.235694 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.227357 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.235694 [get_ports {clk}] -clock clk 
