set_multi_cpu_usage -local_cpu 8

enable_metric -on
push_snapshot_stack

set_db route_design_detail_use_multi_cut_via_effort high
get_db route_design_with_litho_driven

set_db cts_buffer_cells "BUF_X2B_A9PP140ZTL_C30 \
BUF_X4B_A9PP140ZTL_C30 BUF_X6B_A9PP140ZTL_C30 \
BUF_X7P5B_A9PP140ZTL_C30"
set_db cts_inverter_cells "INV_X2B_A9PP140ZTL_C30 \
INV_X4B_A9PP140ZTL_C30 INV_X6B_A9PP140ZTL_C30 \
INV_X7P5B_A9PP140ZTL_C30"

set_db cts_use_inverters true
get_db cts_update_clock_latency
create_clock_tree_spec
get_db clock_trees *
set_db cts_target_max_transition_time 0.025
set_db cts_target_skew 0.010

#ccopt_design -report_dir RPT -report_prefix cts
clock_opt_design -report_dir RPT -report_prefix cts
report_clock_trees -out_file RPT/rclk_full.rpt
report_skew_groups -out_file RPT/rskg_full.rpt
pop_snapshot_stack
enable_metric
create_snapshot -name cts -categories "power check design flow hold route clock setup"

write_db DBS/cts.dat
write_netlist DBS/LEC/cts.v.gz
report_threshold_instance_count -area
set top_cell [get_db designs .name]
report_metric -format vivid -out_file RPT/${top_cell}_metric.html
write_metric -format json -out_file RPT/${top_cell}_metric.json
