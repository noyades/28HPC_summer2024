# Additional timing constraints for pp_int_x4 module to meet 3.6 GHz
# Keep it minimal to avoid syntax errors

# Set aggressive max delay constraints on critical paths
# These constraints force the tool to work harder on these paths
set_max_delay 0.20 -from [get_pins -hier */product*_reg*/CK] -to [get_pins -hier */sum*_reg*/D]
set_max_delay 0.20 -from [get_pins -hier */multiplier*_reg*/CK] -to [get_pins -hier */product*_reg*/D]
