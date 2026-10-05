set_multi_cpu_usage -local_cpu 16

enable_metric -on
push_snapshot_stack

set_db timing_analysis_type ocv
opt_design -post_route -report_dir RPT -report_prefix postroute -setup -hold

pop_snapshot_stack
enable_metric
create_snapshot -name postroute -categories design

write_db DBS/postroute.dat
write_netlist DBS/LEC/postroute.v.gz
report_threshold_instance_count -area

set top_cell [get_db designs .name]
report_metric -format vivid -out_file RPT/${top_cell}_metric.html
write_metric -format json -out_file RPT/${top_cell}_metric.json

write_db ${top_cell}_inn.enc
write_stream ${top_cell}_struct_inn.gds -map_file /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map
write_netlist ${top_cell}_struct_inn.v
