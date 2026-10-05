set_multi_cpu_usage -local_cpu 16

enable_metric -on
push_snapshot_stack
set_db opt_fix_hold_allow_setup_tns_degradation false
set_db opt_fix_hold_ignore_path_groups default
opt_design -post_cts -hold -report_dir RPT -report_prefix \
postcts_hold
pop_snapshot_stack
enable_metric
create_snapshot -name postcts_hold -categories design
write_db DBS/postcts_hold.dat
write_netlist DBS/LEC/postcts_hold.v.gz
report_threshold_instance_count -area
set top_cell [get_db designs .name]
report_metric -format vivid -out_file RPT/${top_cell}_metric.html
write_metric -format json -out_file RPT/${top_cell}_metric.json
