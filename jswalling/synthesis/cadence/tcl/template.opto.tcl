source ../tcl/setup.phys.tcl
set DESIGN FIR_Filter_M
include read_lib.phys.tcl
read_libs $LIBRARY
read_physical -lef $LEF_LIBRARY
suspend
set_db lp_insert_clock_gating true
include read_rtl_phys.tcl
elaborate $DESIGN
check_design
suspend
read_sdc ../constraints/topPPFilter_struct.sdc
check_timing_intent
set_db [get_db designs] .lp_clock_gating_max_flops 16
set_db [get_db designs] .lp_clock_gating_min_flops 4
syn_generic
syn_map
syn_opt
report_qor
